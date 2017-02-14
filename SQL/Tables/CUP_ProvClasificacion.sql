SET ANSI_NULLS, ANSI_WARNINGS ON;

IF OBJECT_ID('dbo.CUP_ProvClasificacion', 'U') IS NOT NULL 
  DROP TABLE dbo.CUP_ProvClasificacion; 

GO

/* =============================================
  Created by:    Enrique Sierra Gtez
  Creation Date: 2016-12-30

  Description: Tabla encargada de contener
  la clasificacion de producto/servicio de los proveedores
 ============================================= */

CREATE TABLE dbo.CUP_ProvClasificacion
(
  Proveedor CHAR(10) NOT NULL 
            CONSTRAINT  FK_CUP_ProvClasificacion_Proveedor
            FOREIGN KEY 
            REFERENCES Prov ( Proveedor ),
  CatProductoServicio HierarchyID
                      CONSTRAINT FK_CUP_ProvClasificacion_CatProductoServicio
                      FOREIGN KEY 
                      REFERENCES CUP_ProvCatProductoservicio(ID) NULL
) 

CREATE UNIQUE CLUSTERED INDEX [PK_CUP_ProvClasificacion_Proveedor]
ON [dbo].[CUP_ProvClasificacion] ( Proveedor )