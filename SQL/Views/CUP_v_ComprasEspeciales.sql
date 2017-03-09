SET ANSI_NULLS, ANSI_WARNINGS ON;

GO 

/*=============================================
 Created by:    Enrique Sierra Gtez
 Creation Date: 2017-11-10

 Description: Regresa las ordenes de compra 
 que cumplen con las condiciones establecidas
 en los criterios de compras especiales

 Example: SELECT * 
          FROM  CUP_v_ComprasEspeciales_PosiblesOrdenes

-- ============================================*/


IF EXISTS(SELECT * FROM sysobjects WHERE name='CUP_v_ComprasEspeciales_PosiblesOrdenes')
	DROP VIEW CUP_v_ComprasEspeciales_PosiblesOrdenes
GO
ALTER VIEW CUP_v_ComprasEspeciales_PosiblesOrdenes
AS
SELECT DISTINCT
  Compra_ID = c.ID,
  Compra_Estatus = c.Estatus,
  Compra_FechaRegistro = c.FechaRegistro,
  Compra_Proveedor = c.Proveedor,
  Criterio_ID =criterio.ID,
  Criterio =  criterio.Descripcion,
  criterio.Accion_ID,
  Accion = c_accion.Descripcion,
  criterio.Recurrencia_ID,
  Recurrencia = c_recurrencia.Descripcion,
  criterio.Recurrencia_Cantidad,
  [No] = ROW_NUMBER() 
          OVER( PARTITION BY criterio.ID, c.Proveedor ORDER BY c.FechaRegistro ASC )
FROM  
  Compra c
JOIN Movtipo t ON t.Modulo = 'COMS'
              AND t.Mov = c.Mov
JOIN CompraD d ON d.ID = c.ID
JOIN Prov p ON p.Proveedor = c.Proveedor
JOIN Art a ON d.Articulo = a.Articulo
JOIN Alm ON alm.Almacen = c.Almacen
CROSS APPLY (
        SELECT  
          Dimension =  dbo.CUP_fn_SubCtaDim(d.SubCuenta),
          Vinil     =  dbo.CUP_fn_SubCtaVinil(d.SubCuenta)
      ) subCta   
LEFT JOIN CUP_ProvClasificacion prov_clas ON prov_clas.Proveedor = p.Proveedor
-- Solicitud Abastos
OUTER APPLY
(
  SELECT TOP 1 
    sol_ab.Cliente
  FROM 
    CUP_SolicitudesAbastosDetalle sol_abD
  JOIN CUP_SolicitudesAbastos sol_ab ON sol_ab.solicitudAbasto = sol_abD.solicitudAbasto
  WHERE
    sol_abD.ordenCompra = c.ID
  ORDER BY
    sol_abD.partida DESC
) sol_abasto
JOIN CUP_ComprasEspeciales_Criterios criterio ON criterio.Activo = 1
                                            AND criterio.FechaInicio <= CAST(c.FechaRegistro As DATE)
                                                -- Sucursal ( se toma la del Almacen )
                                            AND (
                                                    criterio.Sucursal IS NULL
                                                  OR criterio.Sucursal = Alm.Sucursal
                                                )
                                                -- Cliente ( Cuando la orden viene de solcitud de abastos)
                                            AND (
                                                    criterio.Cliente IS NULL
                                                  OR criterio.Cliente = sol_abasto.cliente
                                                )
                                                -- Proveedor Categoria Producto Servicio 
                                            AND ( 
                                                    criterio.ProvCatProductoServicio_ID IS NULL 
                                                  OR prov_clas.CatProductoServicio.IsDescendantOf(criterio.ProvCatProductoServicio_ID) = 1
                                                )
                                                -- Proveedor
                                            AND ( 
                                                    criterio.Proveedor IS NULL 
                                                  OR criterio.Proveedor = p.Proveedor
                                                )
                                                -- Categoria Articulo
                                            AND ( 
                                                    criterio.ArtCategoria IS NULL 
                                                  OR criterio.ArtCategoria = a.Categoria
                                                )
                                                -- Grupo Articulo
                                            AND ( 
                                                    criterio.ArtGrupo IS NULL 
                                                  OR criterio.ArtGrupo = a.Grupo
                                                )
                                                -- Familia Articulo
                                            AND ( 
                                                    criterio.ArtFamilia IS NULL 
                                                  OR criterio.ArtFamilia = a.Familia
                                                )
                                                -- Articulo
                                            AND (
                                                    criterio.Articulo IS NULL 
                                                  OR criterio.Articulo = d.Articulo
                                                ) 
                                                -- Dimension ( Largo o Ancho )
                                            AND (
                                                    criterio.Dimension IS NULL
                                                  OR ISNULL(criterio.Dimension,'')  = ISNULL(subCta.Dimension,'')
                                                )
                                                -- Vinil
                                            AND (
                                                    criterio.Vinil IS NULL
                                                  OR ISNULL(criterio.Vinil,'') = ISNULL(subCta.Vinil,'')
                                                ) 

  JOIN CUP_ComprasEspeciales_Acciones c_accion ON c_accion.ID = criterio.Accion_ID
                                              AND c_accion.Activo = 1
  JOIN CUP_ComprasEspeciales_Recurrencias c_recurrencia ON c_recurrencia.ID = criterio.Recurrencia_ID
                                                        AND c_recurrencia.Activo = 1
WHERE
  t.Clave = 'COMS.O'
AND t.Mov LIKE 'Orden%'
AND c.Estatus IN ('SINAFECTAR','CONCLUIDO','PENDIENTE')