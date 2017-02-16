IF OBJECT_ID('dbo.CUP_ComprasEspeciales_Acciones', 'U') IS NOT NULL 
  DROP TABLE dbo.CUP_ComprasEspeciales_Acciones; 

GO

/* =============================================
  Created by:    Enrique Sierra Gtez
  Creation Date: 2017-02-15

  Description: Contiene las acciones definidas para
  actuar sobre una compra especial. Por ejemplo
  realizar una notificacion o requerir autorizacion.

============================================= */

CREATE TABLE dbo.CUP_ComprasEspeciales_Acciones
(
  ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
  Descripcion VARCHAR(255) NOT NULL
              CONSTRAINT [AK_CUP_ComprasEspeciales_Acciones_Descripcion]
              UNIQUE,
  Activo BIT NOT NULL 
         CONSTRAINT [DF_CUP_ComprasEspeciales_Acciones_Activo] DEFAULT 1
)