SET DATEFIRST 1;
SET ANSI_NULLS,ANSI_WARNINGS ON;

GO

IF EXISTS(SELECT name 
          FROM sysobjects
          WHERE name ='CUP_v_ProvCatProductoServicio'
          AND xtype='V')
  DROP VIEW CUP_v_ProvCatProductoServicio
GO

CREATE VIEW CUP_v_ProvCatProductoServicio
AS
SELECT 
  ps.ID,
  Descripcion = REPLICATE(CHAR(32)+CHAR(32), ps.ID.GetLevel() - 1) + ps.Descripcion,
  ID_String = ps.ID.ToString(),
  ps.ParentID,
  ParentID_String = ps.ParentID.ToString(),
  [Level] = ps.ID.GetLevel(),
  info.Has_Childs
FROM 
  CUP_ProvCatProductoServicio ps
-- Look for childs
CROSS APPLY
(
  SELECT 
      Has_Childs= CASE 
                   WHEN EXISTS(SELECT 
                                 child.ID 
                               FROM 
                                 CUP_ProvCatProductoServicio child
                               WHERE 
                                 child.ParentID = ps.ID) THEN 
                     1
                   ELSE 
                     0
                  END
 ) info

