IF OBJECT_ID('dbo.CUP_CriteriosComprasEspeciales', 'U') IS NOT NULL 
  DROP TABLE dbo.CUP_CriteriosComprasEspeciales; 

CREATE TABLE dbo.CUP_CriteriosComprasEspeciales
(
  ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
  ProvCatProductoServicio_ID HIERARCHYID
                             NULL
                             CONSTRAINT FK_CUP_CriteriosComprasEspeciales_ProvCatProductoServicio
                             FOREIGN KEY
                             REFERENCES CUP_ProvCatProductoServicio(ID),
  ArtCategoria VARCHAR(50) NULL,
  ArtGrupo VARCHAR(50) NULL,
  Articulo CHAR(20) NULL,
  Largo VARCHAR(20) NULL,
  Accion_ID INT NOT NULL
             CONSTRAINT FK_CUP_CriteriosComprasEspeciales_Accion
             FOREIGN KEY 
             REFERENCES CUP_AccionesComprasEspeciales(ID),
  Recurrencia_ID INT NOT NULL 
                  CONSTRAINT FK_CUP_CriteriosComprasEspeciales_Recurrencia
                  FOREIGN KEY  
                  REFERENCES CUP_RecurrenciaAccionComprasEspeciales(ID),
  FechaInicio DATE NOT NULL,
  Activo BIT NOT NULL 
         CONSTRAINT [DF_CUP_CUP_CriteriosComprasEspeciales_Activo]
         DEFAULT 1,
  Descripcion VARCHAR(255) NOT NULL,
  Usuario INT NOT NULL,
  FechaRegistro DATETIME NOT NULL
                CONSTRAINT [DF_CUP_CUP_CriteriosComprasEspeciales_FechaRegistro]
                DEFAULT GETDATE()
) 

GO
