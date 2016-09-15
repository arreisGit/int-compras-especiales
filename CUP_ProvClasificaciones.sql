IF OBJECT_ID('dbo.CUP_ProvCatProductoServicio', 'U') IS NOT NULL 
  DROP TABLE dbo.CUP_ProvCatProductoServicio; 

CREATE TABLE dbo.CUP_ProvCatProductoServicio
(
  ID HierarchyID PRIMARY KEY,
  Descripcion VARCHAR(100) NULL,
  ParentID AS CASE
                WHEN ID.GetLevel() = 1 THEN
                  NULL 
                ELSE 
                  ID.GetAncestor(1) 
                END PERSISTED REFERENCES CUP_ProvCatProductoServicio(ID),
  CHECK (ID.GetLevel() != 0)
) 

GO

CREATE INDEX IX_CUP_ProvCatProductoServicio_ParentID
ON dbo.CUP_ProvCatProductoServicio(ParentID ASC);