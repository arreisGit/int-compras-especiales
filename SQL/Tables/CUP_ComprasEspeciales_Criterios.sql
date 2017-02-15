IF OBJECT_ID('dbo.CUP_ComprasEspeciales_Criterios', 'U') IS NOT NULL 
  DROP TABLE dbo.CUP_ComprasEspeciales_Criterios; 

GO

/* =============================================
  Created by:    Enrique Sierra Gtez
  Creation Date: 2017-02-15

  Description: Contiene todos los criterios
  que provocan que una compra sea considerada 
  como especial.

============================================= */

CREATE TABLE dbo.CUP_ComprasEspeciales_Criterios
(
  ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
  Usuario INT NOT NULL,
  Descripcion VARCHAR(255) NOT NULL,
  FechaRegistro DATETIME NOT NULL
                CONSTRAINT [DF_CUP_ComprasEspeciales_Criterios_FechaRegistro]
                DEFAULT GETDATE(),
  ProvCatProductoServicio_ID HIERARCHYID
                             NULL
                             CONSTRAINT FK_CUP_ComprasEspeciales_Criterios_ProvCatProductoServicio
                             FOREIGN KEY
                             REFERENCES CUP_ProvCatProductoServicio(ID),
  Proveedor CHAR(10) NULL
            CONSTRAINT FK_CUP_ComprasEspeciales_Criterios_Proveedor
            FOREIGN KEY
            REFERENCES Prov ( Proveedor ),
  ArtCategoria VARCHAR(50) NULL
               CONSTRAINT FK_CUP_ComprasEspeciales_Criterios_ArtCategoria
               FOREIGN KEY
               REFERENCES ArtCat ( Categoria ),
  ArtGrupo VARCHAR(50) NULL
           CONSTRAINT FK_CUP_ComprasEspeciales_Criterios_ArtGrupo
           FOREIGN KEY
           REFERENCES ArtGrupo ( Grupo ),
  ArtFamilia VARCHAR(50) NULL
             CONSTRAINT FK_CUP_ComprasEspeciales_Criterios_ArtFamilia
             FOREIGN KEY
             REFERENCES ArtFam ( Familia ),
  Articulo CHAR(20) NULL
           CONSTRAINT FK_CUP_ComprasEspeciales_Criterios_Articulo
           FOREIGN KEY
           REFERENCES Art ( Articulo ),
  Largo VARCHAR(20) NULL,
  Accion_ID INT NOT NULL
             CONSTRAINT FK_CUP_ComprasEspeciales_Criterios_Accion
             FOREIGN KEY 
             REFERENCES CUP_ComprasEspeciales_Acciones(ID),
  Recurrencia_ID INT NOT NULL 
                  CONSTRAINT FK_CUP_ComprasEspeciales_Criterios_Recurrencia
                  FOREIGN KEY  
                  REFERENCES CUP_ComprasEspeciales_Recurrencias(ID),
  FechaInicio DATE NOT NULL,
  Activo BIT NOT NULL 
         CONSTRAINT [DF_CUP_ComprasEspeciales_Criterios_Activo]
         DEFAULT 1
) 