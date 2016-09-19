IF OBJECT_ID('dbo.CUP_CriteriosMonitoreoComprasEspeciales', 'U') IS NOT NULL 
  DROP TABLE dbo.CUP_CriteriosMonitoreoComprasEspeciales; 

CREATE TABLE dbo.CUP_CriteriosMonitoreoComprasEspeciales
(
  ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
  ProvCatProductoServicio_ID HIERARCHYID
                             NULL
                             FOREIGN KEY
                             REFERENCES CUP_ProvCatProductoServicio(ID),
  ArtCategoria VARCHAR(50) NULL,
  ArtGrupo VARCHAR(50) NULL,
  Accion_ID INT NOT NULL
             FOREIGN KEY 
             REFERENCES CUP_AccionesComprasEspeciales(ID),
  Recurrencia_ID INT NOT NULL 
                  FOREIGN KEY  
                  REFERENCES CUP_RecurrenciaAccionComprasEspeciales(ID),
  FechaInicio DATE NOT NULL,
  Activo BIT NOT NULL 
         CONSTRAINT [DF_CUP_CriteriosMonitoreoComprasEspeciales_Activo] DEFAULT 1,
  FechaRegistro DATETIME NOT NULL
          CONSTRAINT [DF_CUP_CriteriosMonitoreoComprasEspeciales_FechaRegistro] DEFAULT GETDATE()
) 

GO
