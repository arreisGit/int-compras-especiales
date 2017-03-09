SET ANSI_NULLS, ANSI_WARNINGS ON;

IF EXISTS(SELECT NAME FROM sysobjects WHERE xtype='TF' and name='CUP_fn_CompraEspecial_Criterios')
	DROP FUNCTION dbo.CUP_fn_CompraEspecial_Criterios

GO

/* =============================================
  Created by:    Enrique Sierra Gtez
  Creation Date: 2017-02-15

  Description: Devuelve los criterios 
  que vuelven una compra especial y que ademas
  cumplen con la recurrencia necesaria para tomar
  una accion sobre la misma.

  EXAMPLE: 
  SELECT
    Criterio_ID,
    Descripcion,
    Accion_ID,
    Accion,
    Recurrencia_ID,
    Recurrencia,
    Recurrencia_Cantidad,
    ComprasPreviamenteEfectuadas
  FROM
    dbo.CUP_fn_CompraEspecial_Criterios(1)

============================================= */

CREATE FUNCTION dbo.CUP_fn_CompraEspecial_Criterios
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
  Recurrencia_Cantidad DECIMAL(18,4) NULL,
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
    Recurrencia_Cantidad,
    ComprasPreviamenteEfectuadas
  )
  SELECT DISTINCT
     criterio.Criterio_ID
    ,criterio.Criterio
    ,criterio.Accion_ID
    ,criterio.Accion
    ,criterio.Recurrencia_ID
    ,criterio.Recurrencia
    ,criterio.Recurrencia_Cantidad
    ,ComprasPreviamenteEfectuadas = ISNULL(compras_especiales.Cuantas,0)
  FROM  
     CUP_v_ComprasEspeciales_PosiblesOrdenes criterio
  -- Numero de compras especiales que han tenido al menos una Entrada de compra
  -- y aplican para el criterio
  OUTER APPLY( SELECT   
                 Cuantas = COUNT(DISTINCT old_coms.Compra_ID)
               FROM 
                 CUP_v_ComprasEspeciales_PosiblesOrdenes old_coms
               WHERE
                  CAST(old_coms.Compra_FechaRegistro AS DATE) <= CAST(criterio.Compra_FechaRegistro AS DATE)  
               AND old_coms.Compra_Estatus IN ('PENDIENTE','CONCLUIDO')
               AND old_coms.Compra_ID <> @ID
               AND old_coms.Compra_Proveedor = criterio.Compra_Proveedor
               AND old_coms.Criterio_ID = criterio.Criterio_ID
             ) compras_especiales
  WHERE
    criterio.Compra_ID = @ID
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