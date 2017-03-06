SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/**************** DROP IF EXISTS ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'CUP_SPI_ComprasEspeciales_RegistroLog') 
  DROP PROCEDURE  CUP_SPI_ComprasEspeciales_RegistroLog
GO

/* =============================================
  Created by:    Enrique Sierra Gtez
  Creation Date: 2017-02-17

  Description: Procedimiento encargado de llevar el registro
  de las compras especiales.

============================================= */

CREATE PROCEDURE [dbo].CUP_SPI_ComprasEspeciales_RegistroLog
(
	  @Modulo         CHAR(5),          
	  @ID             INT,            
	  @Accion         CHAR(20),            
	  @Base           CHAR(20),  
    @Estatus        CHAR(15),
    @EstatusNuevo   CHAR(15),
    @Mov            CHAR(20),
    @MovTipo        CHAR(20),          
	  @Usuario        CHAR(10),
    @OK             INT          OUTPUT,
    @OkRef          VARCHAR(255) OUTPUT       
)                
AS BEGIN 

  IF @Modulo = 'COMS'
  AND @Movtipo = 'COMS.O'
  AND @Mov LIKE 'Orden%'
  AND @Accion IN ('AFECTAR','GENERAR')
  AND @Estatus = 'SINAFECTAR'
  BEGIN

    INSERT INTO CUP_ComprasEspeciales
    (
      Compra_ID,
      Criterio_ID
    )
    SELECT
      @ID,
      Criterio_ID
    FROM 
      dbo.CUP_fn_CriteriosCompraEspecial(@ID)
  
  END

END