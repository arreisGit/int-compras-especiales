INSERT INTO CUP_ComprasEspeciales_Criterios
(
  Usuario,
  Descripcion,
  Cliente,
  ProvCatProductoServicio_ID,
  ArtCategoria,
  ArtGrupo,
  ArtFamilia,
  Articulo,
  Dimension,
  Accion_ID,
  Recurrencia_ID,
  FechaInicio
)
VALUES
(
  '63527',
  'Criterio de Ejemplo',
  NULL,
  '/1/2/',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  2,
  2,
  '2016-09-15'
)

SELECT 
  *
FROM 
  CUP_ComprasEspeciales_Criterios