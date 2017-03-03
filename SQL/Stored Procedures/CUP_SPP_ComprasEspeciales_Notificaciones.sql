SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/**************** DROP IF EXISTS ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'CUP_SPP_ComprasEspeciales_Notificaciones') 
  DROP PROCEDURE  CUP_SPP_ComprasEspeciales_Notificaciones
GO

/* =============================================
  Created by:    Enrique Sierra Gtez
  Creation Date: 2017-02-15

  Description: Procedimiento almacenado 
  encargado de controlar las notificaciones
  de las compras especiales.

============================================= */

CREATE PROCEDURE [dbo].CUP_SPP_ComprasEspeciales_Notificaciones
(
	  @Modulo         CHAR(5),          
	  @ID             INT,            
	  @Accion         CHAR(20),            
	  @Base           CHAR(20),  
    @Estatus        CHAR(15),
    @Mov            CHAR(20),
    @MovTipo        CHAR(20),          
	  @GenerarMov     CHAR(20),   
    @GenerarMovTipo CHAR(20),         
	  @Usuario        CHAR(10),
    @OK             INT          OUTPUT,
    @OkRef          VARCHAR(255) OUTPUT       
)                
AS BEGIN 
  DECLARE 
    @recipients VARCHAR(MAX),
    @profile_name sysname,
    @copy_recipients VARCHAR(MAX),
    @blind_copy_recipients VARCHAR(MAX),
    @reply_to VARCHAR(MAX),
    @importance VARCHAR(6),
    @subject NVARCHAR(255),
    @body NVARCHAR(MAX),
    @Movimiento VARCHAR(50),
    @Fecha  VARCHAR(30),
    @Referencia VARCHAR(50),
    @Usuario_Nombre VARCHAR(100),
    @OrdenCompra VARCHAR(50),
    @Proveedor VARCHAR(100),
    @Criterios_Especiales VARCHAR(MAX)

  IF  (   -- Ordenes Compra y Controles Calidad Pendientes
          @MovTipo ='COMS.O'
      AND @Estatus  = 'PENDIENTE'
      )
  OR  (   -- Entradas Concluidas
          @Movtipo IN ('COMS.EG','COMS.F')
      AND @Estatus = 'CONCLUIDO'
      )
  AND @Accion = 'AFECTAR'
  BEGIN
  
    -- Revisa si existe algun criterio de notificacion de compra.
    SELECT
      @Criterios_Especiales  = '<td>' + CAST(criterio.Criterio_ID AS VARCHAR) + '</td>'
                             + '<td>' + LTRIM(RTRIM(criterio.Descripcion)) + '</td>'
    FROM 
      dbo.CUP_fn_CriteriosCompraEspecial(@ID) criterio
    WHERE 
      criterio.Accion = 1

    IF @@rowcount > 0
    BEGIN

      -- Perpara los datos para el envio del correo
      SELECT 
          @profile_name = sql_profile ,
          @recipients = destinatarios,
          @copy_recipients = cc,
          @blind_copy_recipients = bcc,
          @reply_to = 'enrique.sierra@cuprum.com',
          @importance = importancia,
          @body = cuerpo,
          @subject = asunto
      FROM 
        [172.18.9.69].InventariosPlanos.dbo.FormatosMail 
      WHERE 
          id_formato = 66

      SELECT 
        @Movimiento = LTRIM(RTRIM(c.Mov)) + ' ' + c.movID,
        @Fecha = CONVERT(VARCHAR(30), c.FechaEmision, 	105),
        @Referencia = ISNULL(c.Referencia,''),
        @Proveedor = p.Nombre,
        @OrdenCompra = ISNULL(orden_compra.Mov,'')
      FROM 
        Compra c 
      JOIN Prov p ON p.Proveedor = c.Proveedor
      -- orden de compra
      OUTER APPLY(SELECT TOP 1
                    Mov = LTRIM(RTRIM(mf.OMov)) + ' ' + mf.OMovID
                  FROM 
                    dbo.fnCMLMovFlujo('COMS',@ID,0) mf 
                  WHERE 
                    mf.Indice <= 0
                  AND mf.OModulo = 'COMS'
                  AND mf.OMov LIKE 'Orden%'
                  ORDER BY
                    mf.OID ASC
                ) orden_compra
      WHERE
        c.ID = @ID

      SELECT 
        @Usuario_Nombre = u.Nombre
      FROM 
        Usuario u
      WHERE 
        u.Usuario = @Usuario

      SELECT
        @recipients =  REPLACE(@recipients,'[RESPONSABLES]','perla.quirarte@cuprum.com;'),
        @copy_recipients = REPLACE(@recipients,'[CC]','luis.balderas@cuprum.com;'),
        @subject = REPLACE(@subject,'[MOVIMIENTO]',@Movimiento)

      -- prepara el cabecero del correo
      SET @body = REPLACE(@body,'[MOVIMIENTO]',@Movimiento)
      SET @body = REPLACE(@body,'[FECHA]',@Fecha)
      SET @body = REPLACE(@body,'[REFERENCIA]',@Referencia)
      SET @body = REPLACE(@body,'[USUARIO]',@Usuario_Nombre)
      SET @body = REPLACE(@body,'[ORDEN_COMPRA]',@OrdenCompra)
      SET @body = REPLACE(@body,'[PROVEEDOR]',@Proveedor)

      -- integra la informacion de los criterios aplicados
      SET @body = REPLACE(@body,'[CRITERIOS_ESPECIALES]',@Criterios_Especiales)

      IF @body IS NOT NULL 
      AND @recipients IS NOT NULL
      BEGIN

        EXEC msdb.dbo.sp_send_dbmail  
          @profile_name = @copy_recipients,  
          @recipients = @recipients,  
          @blind_copy_recipients = @blind_copy_recipients,
          @body =  @body,  
          @subject = @subject,
          @reply_to = @reply_to,
          @importance = @importance

      END


    END
    
  END
  
  
END