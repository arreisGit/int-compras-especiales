IF OBJECT_ID('dbo.CUP_RecurrenciaAccionComprasEspeciales', 'U') IS NOT NULL 
  DROP TABLE dbo.CUP_RecurrenciaAccionComprasEspeciales; 

CREATE TABLE dbo.CUP_RecurrenciaAccionComprasEspeciales
(
  ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
  Descripcion VARCHAR(255) NOT NULL,
  Activo BIT NOT NULL 
         CONSTRAINT [DF_CUP_RecurrenciaAccionComprasEspeciales_Activo] DEFAULT 1
) 

GO
