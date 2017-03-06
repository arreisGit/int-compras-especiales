EXEC CUP_spp_TruncateTable CUP_ComprasEspeciales_Criterios

GO

/*
/1/	Materia Prima
/1/1/	Molino
/1/2/	Broker

*/

INSERT INTO CUP_ComprasEspeciales_Criterios
(
  Usuario,
  Descripcion,
  Sucursal,
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
VALUES
(
  '63527', -- USUARIO
  'Compra Broker', -- Criterio Descripcion
  NULL, -- Sucursal
  NULL, -- Cliente 
  '/1/2/', -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-10-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Proveedor Nuevo', -- Criterio Descripcion
  NULL, -- Sucursal
  NULL, -- Cliente 
  '/1/1/', -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  2, -- Recurrencia_ID
  3, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Restricción Calidad Proveedor', -- Criterio Descripcion
  NULL, -- Sucursal
  NULL, -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  'I2036', -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Restricción Calidad Articulo/Proveedor', -- Criterio Descripcion
  NULL, -- Sucursal
  NULL, -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  'APE2215733986061T4 ', -- Articulo
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-09-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  '237', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  '8135', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  '9015', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  '91', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  '67', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
--,(
--  '63527', -- USUARIO
--  'Especificación de Compra', -- Criterio Descripcion
--  NULL, -- Sucursal
--  NULL, -- Cliente 
--  NULL, -- ProvCatProductoServicio_ID 
--  NULL, -- Proveedor, 
--  NULL, -- ArtCategoria
--  NULL, -- ArtGrupo
--  NULL, -- ArtFamilia
--  'IC062430P3-A', -- Articulo,
--  NULL, -- Dimension ( Ancho / Largo )
--  NULL, -- Vinil
--  1, -- Accion_ID
--  1, -- Recurrencia_ID
--  NULL, -- Recurrencia_Cantidad 
--  '2016-01-01' -- FechaInicio
--)
--,(
--  '63527', -- USUARIO
--  'Especificación de Compra', -- Criterio Descripcion
--  NULL, -- Sucursal
--  NULL, -- Cliente 
--  NULL, -- ProvCatProductoServicio_ID 
--  NULL, -- Proveedor, 
--  NULL, -- ArtCategoria
--  NULL, -- ArtGrupo
--  NULL, -- ArtFamilia
--  'IC081430P3-A', -- Articulo,
--  NULL, -- Dimension ( Ancho / Largo )
--  NULL, -- Vinil
--  1, -- Accion_ID
--  1, -- Recurrencia_ID
--  NULL, -- Recurrencia_Cantidad 
--  '2016-01-01' -- FechaInicio
--)
--,(
--  '63527', -- USUARIO
--  'Especificación de Compra', -- Criterio Descripcion
--  NULL, -- Sucursal
--  'MX0625', -- Cliente 
--  NULL, -- ProvCatProductoServicio_ID 
--  NULL, -- Proveedor, 
--  NULL, -- ArtCategoria
--  NULL, -- ArtGrupo
--  NULL, -- ArtFamilia
--  NULL, -- Articulo,
--  NULL, -- Dimension ( Ancho / Largo )
--  NULL, -- Vinil
--  1, -- Accion_ID
--  1, -- Recurrencia_ID
--  NULL, -- Recurrencia_Cantidad 
--  '2016-01-01' -- FechaInicio
--)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  'MY2423', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  'MX02952', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  '8927', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  'MX02913', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  '68', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  '8907', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  '774', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
--,(
--  '63527', -- USUARIO
--  'Especificación de Compra', -- Criterio Descripcion
--  NULL, -- Sucursal
--  '1540', -- Cliente 
--  NULL, -- ProvCatProductoServicio_ID 
--  NULL, -- Proveedor, 
--  NULL, -- ArtCategoria
--  NULL, -- ArtGrupo
--  NULL, -- ArtFamilia
--  NULL, -- Articulo,
--  NULL, -- Dimension ( Ancho / Largo )
--  NULL, -- Vinil
--  1, -- Accion_ID
--  1, -- Recurrencia_ID
--  NULL, -- Recurrencia_Cantidad 
--  '2016-01-01' -- FechaInicio
--)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  '63', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  '8887', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  '4986', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  '4695', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  '8756', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  '5579', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  '8250', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  'MY2465', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  '8129', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  'MY2469', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  'MY1925', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  'MY2178', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  'MX00707', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  '410', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  'MX02909', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  'MX03149', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  '8920', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  '7099', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  '416', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  '835', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  '8676', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)
,(
  '63527', -- USUARIO
  'Especificación de Compra', -- Criterio Descripcion
  NULL, -- Sucursal
  'MX00144', -- Cliente 
  NULL, -- ProvCatProductoServicio_ID 
  NULL, -- Proveedor, 
  NULL, -- ArtCategoria
  NULL, -- ArtGrupo
  NULL, -- ArtFamilia
  NULL, -- Articulo,
  NULL, -- Dimension ( Ancho / Largo )
  NULL, -- Vinil
  1, -- Accion_ID
  1, -- Recurrencia_ID
  NULL, -- Recurrencia_Cantidad 
  '2016-01-01' -- FechaInicio
)


SELECT 
  *
FROM 
  CUP_ComprasEspeciales_Criterios