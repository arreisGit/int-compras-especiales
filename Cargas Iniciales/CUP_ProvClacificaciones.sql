INSERT INTO CUP_ProvCatProductoServicio
(
  ID
 ,Descripcion
) 
VALUES 
  ('/1/','Materia Prima'),
  ('/1/1/','Molino'),
  ('/1/2/','Broker')


GO 

SELECT 
  ID,
  ID_String = ID.ToString(),
  ParentId,
  ParentID_String = ParentID.ToString(),
  Descripcion = REPLICATE('    ', ID.GetLevel() - 1) + Descripcion,
  [Level] = ID.GetLevel()
FROM 
  CUP_ProvCatProductoServicio
ORDER BY 
  ID ASC 