IF OBJECT_ID('dbo.CUP_AccionesComprasEspeciales', 'U') IS NOT NULL 
  DROP TABLE dbo.CUP_AccionesComprasEspeciales; 

CREATE TABLE dbo.CUP_AccionesComprasEspeciales
(
  ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
  Descripcion VARCHAR(255) NOT NULL,
  Activo BIT NOT NULL 
         CONSTRAINT [DF_CUP_AccionesComprasEspeciales_Activo] DEFAULT 1
) 

GO
