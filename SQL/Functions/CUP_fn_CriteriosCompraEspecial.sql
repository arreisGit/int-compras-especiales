SET ANSI_NULLS, ANSI_WARNINGS ON;

IF EXISTS(SELECT NAME FROM sysobjects WHERE xtype='TF' and name='CUP_fn_CriteriosCompraEspecial')
	DROP FUNCTION dbo.CUP_fn_CriteriosCompraEspecial

GO

/* =============================================
  Created by:    Enrique Sierra Gtez
  Creation Date: 2017-02-15

  Description: Devuelve los criterios que convierten a una compra
  en especial. 

  EXAMPLE: 
  SELECT
    ID,
    Accion,
    Descripcion
  FROM
    dbo.CUP_fn_CriteriosCompraEspecial(1)

============================================= */

CREATE FUNCTION dbo.CUP_fn_CriteriosCompraEspecial
( 
  @Id INT 
)
RETURNS @Criterios TABLE
(
  Criterio_ID INT NOT NULL
              PRIMARY KEY,
  Descripcion VARCHAR(255) NOT NULL,
  Accion_ID   INT NOT NULL,
  Accion      VARCHAR(255) NOT NULL,
  Recurrencia_ID INT NOT NULL,
  Recurrencia VARCHAR(255) NOT NULL,
  Recurrencia_Valor DECIMAL(18,4) NULL,
  ComprasPreviamenteEfectuadas INT NOT NULL
)
AS
BEGIN

	INSERT INTO @Criterios
  (
    Criterio_ID,
    Descripcion,
    Accion_ID,
    Accion,
    Recurrencia_ID,
    Recurrencia,
    RecurrenciaValor,
    ComprasPreviamenteEfectuadas
  )
  SELECT DISTINCT
    criterio.ID,
    criterio.Descripcion,
    criterio.Accion_ID,
    Accion = c_accio.Descripcion,
    criterio.Recurrencia_ID,
    Recurrencia = c_recurrencia.Descripcion,
    Recurrencia_Valor = criterio.Recurrencia_Valor,
    ComprasPreviamenteEfectuadas = ISNULL(compras_especiales.Cuantas,0)
  FROM  
    Compra c
  JOIN Movtipo t ON t.Modulo = 'COMS'
                AND t.Mov = c.Mov
  JOIN CompraD d ON d.ID = c.ID
  JOIN Prov p ON p.Proveedor = c.Proveedor
  JOIN Art a ON d.Articulo = a.Articulo
  CROSS APPLY (
            SELECT  
              Dimension =  dbo.CUP_fn_SubCtaDim(d.SubCuenta),
              Vinil     =  dbo.CUP_fn_SubCtaVinil(d.SubCuenta)
          ) subCta   
  LEFT JOIN CUP_ProvClasificacion prov_clas ON prov_clas.Proveedor = p.Proveedor
  -- Orden de compra origen
  CROSS APPLY(
                SELECT TOP  1
                  ID = mfOc.OID,
                  oc.FechaRegistro
                FROM
                  dbo.fnCMLMovFlujo('COMS',c.ID,0) mfOc
                JOIN compra oc ON oc.ID = mfOc.DID
                WHERE 
                  mfOc.Indice <= 0
                AND mfOc.OModulo = 'COMS'
                AND mfOc.OMovTipo = 'COMS.O'
                AND mfOc.OMov Like 'Orden%'
                AND oc.Estatus IN ('CONCLUIDO','PENDIENTE')
                ORDER BY
                   mfOc.Indice ASC,
                   oc.ID ASC
              ) orden_compra
  -- Solicitud Abastos
  OUTER APPLY
  (
    SELECT TOP 1 
      sol_ab.Cliente
    FROM 
      CUP_SolicitudesAbastosDetalle sol_abD
    JOIN CUP_SolicitudesAbastos sol_ab ON sol_ab.solicitudAbasto = sol_abD.solicitudAbasto
    WHERE
      sol_abD.ordenCompra = orden_compra.ID
    ORDER BY
      sol_abD.partida DESC
  ) sol_abasto
	JOIN CUP_ComprasEspeciales_Criterios criterio ON  criterio.Activo = 1
                                                AND criterio.FechaInicio <= orden_compra.FechaRegistro
                                                    -- Cliente ( Cuando la orden viene de solcitud de abastos)
                                                AND (
                                                        criterio.Cliente IS NULL
                                                     OR sol_abasto.cliente = criterio.Cliente
                                                    )
                                                    -- Proveedor Categoria Producto Servicio 
                                                AND ( 
                                                        criterio.ProvCatProductoServicio_ID IS NULL 
                                                     OR prov_clas.CatProductoServicio.IsDescendantOf(criterio.ProvCatProductoServicio_ID) = 1
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
  -- Solo Reucrrencias Activas
  JOIN CUP_ComprasEspeciales_Recurrencias c_recurrencia ON c_recurrencia.ID = criterio.Recurrencia_ID
                                                       AND c_recurrencia.Activo = 1
  
  -- Numero de compras especiales que han tenido al menos una Entrada de compra
  -- y aplican para el criterio
  OUTER APPLY( SELECT   
                 Cuantas = COUNT(DISTINCT coms_esp.ID)
               FROM 
                 CUP_ComprasEspeciales coms_esp 
               JOIN Compra oc_esp ON oc_esp.ID = coms_esp.Compra_ID
               CROSS APPLY(
                           SELECT
                             ID = MAX(mf.DID)
                           FROM
                             dbo.fnCMLMovFlujo('COMS',coms_esp.Compra_ID,0) mf
                           JOIN compra entrada ON entrada.ID = mf.DID
                           WHERE 
                             mf.Indice > 0
                           AND mf.DModulo = 'COMS'
                           AND mf.DMovTipo IN (
                                                'COMS.F',
                                                'COMS.EG'
                                              )
                           AND entrada.Estatus = 'CONCLUIDO'
                          ) entradas_compra
                WHERE 
                 coms_esp.Criterio_ID = criterio.ID
                AND criterio.FechaInicio <=  CAST(oc_esp.FechaRegistro AS DATE) 
              ) compras_especiales
  WHERE
    c.ID = @ID
  -- Validar Recurrencia
  AND (
        criterio.Recurrencia_ID = 1 -- Siempre
      OR  (
            criterio.Recurrencia_ID = 2 
          AND ISNULL(compras_especiales.Cuantas,0) < ISNULL(criterio.Recurrencia_Cantidad,0)
          )
      )

  RETURN	
END
go