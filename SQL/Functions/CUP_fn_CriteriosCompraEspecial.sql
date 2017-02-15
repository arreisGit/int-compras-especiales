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
  ID INT NOT NULL,
  Accion INT NOT NULL,
  Descripcion VARCHAR(255) NOT NULL
)
AS
BEGIN

	INSERT INTO @Criterios
  (
    ID,
    Accion,
    Descripcion
  )
  SELECT DISTINCT
    criterio.ID,
    Accion = criterio.Accion_ID,
    criterio.Descripcion
  FROM  
    Compra c
  JOIN Movtipo t ON t.Modulo = 'COMS'
                AND t.Mov = c.Mov
  JOIN CompraD d ON d.ID = c.ID
  JOIN Prov p ON p.Proveedor = c.Proveedor
  JOIN Art a ON d.Articulo = a.Articulo
  CROSS APPLY (
            SELECT  
              Largo =  dbo.CUP_fn_SubCtaDim(d.SubCuenta)
          ) subCta   
  LEFT JOIN CUP_ProvClasificacion prov_clas ON prov_clas.Proveedor = p.Proveedor
	JOIN CUP_ComprasEspeciales_Criterios criterio ON  criterio.Activo = 1
                                                AND criterio.FechaInicio <= c.FechaRegistro 
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
                                                    -- Largo
                                                AND (
                                                      ISNULL(criterio.Largo,'') IN ('',ISNULL(subCta.Largo,''))
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
              ) compras_especiales
  WHERE
    c.ID = @ID
  -- Validar Recurrencia
  AND (
        criterio.Recurrencia_ID = 1 -- Siempre
      OR  (
            criterio.Recurrencia_ID = 2 
          AND ISNULL(compras_especiales.Cuantas,0) < 3
          )
      )

                                                           
 
  RETURN	
END
go