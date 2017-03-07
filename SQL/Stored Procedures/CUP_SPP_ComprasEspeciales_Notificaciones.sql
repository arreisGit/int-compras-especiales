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
    @Cliente CHAR(10),
    @Proveedor VARCHAR(100),
    @Factura VARCHAR(20),
    @FechaFactura VARCHAR(30),
    @Criterios_Especiales VARCHAR(MAX),
    @Detalle_Mov VARCHAR(MAX)

  IF  (   -- Ordenes Compra y Controles Calidad Pendientes
          @MovTipo ='COMS.O'
      AND @Estatus  = 'PENDIENTE'
      AND @GenerarMov IS NULL
      )
  OR  (   -- Entradas Concluidas
          @Movtipo IN ('COMS.EG','COMS.F')
      AND @Estatus = 'CONCLUIDO'
      )
  AND @Accion = 'AFECTAR'
  BEGIN
  
    -- Revisa si existe algun criterio de notificacion de compra.
    SELECT
      @Criterios_Especiales  = '<td>' + CAST(com_esp.Criterio_ID AS VARCHAR) + '</td>'
                             + '<td>' + LTRIM(RTRIM(criterio.Descripcion)) + '</td>'
    FROM 
      dbo.fnCMLMovFlujo('COMS', @ID, 0) mf
    JOIN CUP_ComprasEspeciales com_esp ON com_esp.Compra_ID = mf.OID
    JOIN CUP_ComprasEspeciales_Criterios criterio ON criterio.ID = com_esp.Criterio_ID
    WHERE 
      mf.Indice <= 0
    AND mf.OModulo = 'COMS'
    AND mf.OMovTipo = 'COMS.O'
    AND mf.OMov LIKE 'Orden%'

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
        @Cliente = ISNULL(sol_abasto.Cliente,''),
        @Proveedor = p.Nombre,
        @OrdenCompra = ISNULL(orden_compra.Mov,''),
        @Factura = ISNULL(c.CuprumFactura, ''),
        @FechaFactura = ISNULL(CONVERT(VARCHAR(30), c.FechaFactura, 	105),'')
      FROM 
        Compra c 
      JOIN Prov p ON p.Proveedor = c.Proveedor
      -- orden de compra
      OUTER APPLY(SELECT TOP 1
                    ID = OID,
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
      -- Solicitud Abastos
      OUTER APPLY
      (
        SELECT TOP 1 
          sol_ab.Cliente
        FROM 
          CUP_SolicitudesAbastosDetalle sol_abD
        JOIN CUP_SolicitudesAbastos sol_ab ON sol_ab.solicitudAbasto = sol_abD.solicitudAbasto
        WHERE
          sol_abD.ordenCompra = orden_compra.ID
        ORDER BY
          sol_abD.partida DESC
      ) sol_abasto
      WHERE
        c.ID = @ID

      SELECT 
        @Detalle_Mov = '<td>' + LTRIM(RTRIM(d.Articulo)) + '</td>'
                     + '<td>' + ISNULL(d.SubCuenta,'') + '</td>'
                     + '<td>' + LTRIM(RTRIM(Art.Descripcion1)) + '</td>'
                     + '<td>' + CONVERT(VARCHAR(30), CAST(d.Cantidad AS MONEY)) + '</td>'
                     + '<td>' + d.Unidad + '</td>'
      FROM  
        CompraD d
      JOIN Art ON Art.Articulo = d.Articulo
      WHERE 
        d.Id = @ID

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
      SET @body = REPLACE(@body, '[MOVIMIENTO]', @Movimiento)
      SET @body = REPLACE(@body, '[FECHA]', @Fecha)
      SET @body = REPLACE(@body, '[REFERENCIA]', @Referencia)
      SET @body = REPLACE(@body, '[USUARIO]', @Usuario_Nombre)
      SET @body = REPLACE(@body, '[ORDEN_COMPRA]', @OrdenCompra)
      SET @body = REPLACE(@body, '[CLIENTE]', @Cliente)
      SET @body = REPLACE(@body, '[PROVEEDOR]', @Proveedor)
      SET @body = REPLACE(@body, '[FACTURA]', @Factura)
      SET @body = REPLACE(@body, '[FECHA_FACTURA]', @FechaFactura)

      -- integra la informacion de los criterios aplicados
      SET @body = REPLACE(@body,'[CRITERIOS_ESPECIALES]', ISNULL(@Criterios_Especiales,'') )

      -- integra la informacion del detalle del movimiento
      SET @body = REPLACE(@body,'[DETALLE_MOV]', ISNULL(@Detalle_Mov,''))

      IF ISNULL(@body,'') <> ''
      AND ISNULL(@recipients,'') <> ''
      BEGIN

        EXEC msdb.dbo.sp_send_dbmail  
          @profile_name = @profile_name,  
          @recipients = @recipients,  
          @copy_recipients = @copy_recipients,
          @blind_copy_recipients = @blind_copy_recipients,
          @body =  @body,  
          @subject = @subject,
          @reply_to = @reply_to,
          @importance = @importance

      END


    END
    
  END
  
  
END