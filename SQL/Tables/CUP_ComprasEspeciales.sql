IF OBJECT_ID('dbo.CUP_ComprasEspeciales', 'U') IS NOT NULL 
  DROP TABLE dbo.CUP_ComprasEspeciales; 

GO

/* =============================================
  Created by:    Enrique Sierra Gtez
  Creation Date: 2017-02-15

  Description: Lleva el registro de cuales ordenes de compra
  fueron marcadas como compras especiales, junto con los
  criterios que aplicaron en su momento.

============================================= */

CREATE TABLE dbo.CUP_ComprasEspeciales
(
  ID INT IDENTITY(1,1) NOT NULL,
  Compra_ID INT NOT NULL
            CONSTRAINT FK_CUP_ComprasEspeciales_Compra
            FOREIGN KEY 
            REFERENCES Compra( ID)
            ON DELETE CASCADE,
  Criterio_ID INT NOT NULL
              CONSTRAINT FK_CUP_ComprasEspeciales_Criterios
              FOREIGN KEY 
              REFERENCES CUP_ComprasEspeciales_Criterios(ID)
              ON DELETE CASCADE,
  CONSTRAINT PK_CUP_ComprasEspeciales_Compra_ID_Criterio_ID
            PRIMARY KEY ( Compra_ID, Criterio_ID ),
  CONSTRAINT AK_CUP_ComprasEspeciales_ID
             UNIQUE ( ID )                 
)

CREATE NONCLUSTERED INDEX IX_CUP_ComprasEspeciales_ID 
  ON CUP_ComprasEspeciales ( ID )
INCLUDE 
(
  Compra_ID,
  Criterio_ID
)