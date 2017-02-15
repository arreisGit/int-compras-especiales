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
    @body NVARCHAR(MAX)

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
  
    -- Si existe  Algun Criterio de Notificacion aplicable.
    IF EXISTS( SELECT 
                 criterio.ID
               FROM 
                  dbo.CUP_fn_CriteriosCompraEspecial(@ID) criterio
               WHERE 
                  criterio.Accion = 1)
    BEGIN

      -- Perpara los datos para el envio del correo
      SELECT 
          @profile_name = sql_profile ,
          @copy_recipients = cc,
          @blind_copy_recipients = bcc,
          @reply_to = 'enrique.sierra@cuprum.com',
          @importance = importancia,
          @body = cuerpo,
          @subject = asunto
      FROM 
        [172.18.9.69].InventariosPlanos.dbo.FormatosMail 
      WHERE 
          id_formato = NULL -- ** 

      -- Envia Correo
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