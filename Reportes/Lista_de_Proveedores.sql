-- Lista de Proveedores Activos
SELECT
  p.Proveedor,
  p.RFC,
  p.Nombre,
  p.NombreCorto,
  p.Estatus,
  p.Pais
FROM 
  Prov p
WHERE 
  p.Estatus <> 'BAJA'
ORDER BY 
  p.Proveedor

-- Lista de Proveedores Activos con su ultima compra
SELECT
  p.Proveedor,
  p.RFC,
  p.Nombre,
  p.NombreCorto,
  p.Estatus,
  p.Pais,
  UltCompra_ID = orden.ID,
  UltCompra_Mov  = orden.Mov,
  UltCompra_MovId = orden.MovID,
  UltCompra_FechaEmision = orden.FechaEmision,
  UltCompra_Articulo = ordenD.Articulo,
  UltCompra_SubCuenta = ordenD.SubCuenta,
  UltCompra_ArtCat = a.Categoria,
  UltCompra_ArtGrupo = a.Grupo,
  UltCompra_ArtFam = a.Familia,
  UltCompra_Cantidad = ordenD.Cantidad,
  UltCompra_Unidad  = ordenD.Unidad
FROM 
  Prov p
OUTER APPLY(SELECT 
              ID = MAX(c.ID)
            FROM 
              Compra c
            JOIN Movtipo t ON t.Modulo = 'COMS'
                          AND t.Mov = c.MOV 
            WHERE 
              t.Clave = 'COMS.O'
            AND c.Estatus = 'CONCLUIDO'
            AND c.Mov NOT LIKE 'Control%'
            AND c.Proveedor = p.Proveedor) ultCompra
LEFT JOIN Compra orden ON orden.ID = ultCompra.ID
LEFT JOIN CompraD ordenD ON ordenD.ID = orden.ID
LEFT JOIN Art a ON a.Articulo = ordenD.Articulo         
WHERE 
  p.Estatus <> 'BAJA'
ORDER BY 
  p.Proveedor
  sesle