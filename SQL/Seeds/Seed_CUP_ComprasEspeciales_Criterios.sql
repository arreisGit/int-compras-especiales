EXEC CUP_spp_TruncateTable CUP_ComprasEspeciales_Criterios

GO


INSERT INTO CUP_ComprasEspeciales_Criterios
(
  Usuario,
  Descripcion,
  Cliente,
  ProvCatProductoServicio_ID,
  Proveedor,
  ArtCategoria,
  ArtGrupo,
  ArtFamilia,
  Articulo,
  Dimension,
  Vinil,
  Accion_ID,
  Recurrencia_ID,
  Recurrencia_Cantidad,
  FechaInicio
)
SELECT
  Usuario = '63527',
  Descripcion =   'Criterio de Ejemplo',
  Cliente =   NULL,
  ProvCatProductoServicio_ID =   '/1/2/',
  Proveedor = NULL,
  ArtCategoria =   NULL,
  ArtGrupo =   NULL,
  ArtFamilia =  NULL,
  Articulo =   NULL,
  Dimension =   NULL,
  Vinil =   NULL,
  Accion_ID =   2,
  Recurrencia_ID =   2,
  Recurrencia_Cantidad =   3,
  FechaInicio =   '2017-02-15'


SELECT 
  *
FROM 
  CUP_ComprasEspeciales_Criterios