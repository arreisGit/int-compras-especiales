IF OBJECT_ID('dbo.CUP_ComprasEspeciales_Recurrencias', 'U') IS NOT NULL 
  DROP TABLE dbo.CUP_ComprasEspeciales_Recurrencias; 
GO

/* =============================================
  Created by:    Enrique Sierra Gtez
  Creation Date: 2017-02-15

  Description: Contiene las recurrencias definidas para
  actuar sobre una compra especial. Por ejemplo, 
  realizar una accion sobre LAS PRIMERAS 3 COMPRAS
  de un Articulo para un Proveedor, o requerir una 
  autorizacion SIEMPRE.

============================================= */

CREATE TABLE dbo.CUP_ComprasEspeciales_Recurrencias
(
  ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
  Descripcion VARCHAR(255) NOT NULL,
  Activo BIT NOT NULL 
         CONSTRAINT [DF_CUP_RecurrenciaAccionComprasEspeciales_Activo] DEFAULT 1
) 

GO
