SET ANSI_NULLS, ANSI_WARNINGS ON;

IF EXISTS(SELECT NAME FROM sysobjects WHERE xtype='TF' and name='CUP_fn_CriteriosAplicablesComprasEspeciales')
	DROP FUNCTION dbo.CUP_fn_CriteriosAplicablesComprasEspeciales
go
CREATE FUNCTION dbo.CUP_fn_CriteriosAplicablesComprasEspeciales
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
  DECLARE 
    @HOY DATE = GETDATE()

  DECLARE @Posibles_Criterios TABLE ( ID INT NOT NULL ) 

	INSERT INTO @Posibles_Criterios
  (
    ID
  )
  SELECT  DISTINCT
    criterio.ID
  FROM  
    Compra c
  JOIN Movtipo t ON t.Modulo = 'COMS'
                AND t.Mov = c.Mov
  JOIN CompraD d ON d.ID = c.ID
  JOIN Prov p ON p.Proveedor = c.Proveedor
  LEFT JOIN Art a ON d.Articulo = a.Articulo
	-- Largo
  CROSS APPLY (
            SELECT  
              Largo =  dbo.CUP_fn_SubCtaDim(d.SubCuenta)
          ) subCta     
  JOIN CUP_CriteriosMonitoreoComprasEspeciales criterio ON criterio.Activo = 1 
                                                      AND criterio.FechaInicio <= @HOY
                                                      AND ( -- Proveedor Categoria Producto Servicio 
                                                              criterio.ProvCatProductoServicio_ID IS NULL 
                                                            OR criterio.ProvCatProductoServicio_ID = p.CUP_CatProductoServicio
                                                          )
                                                      AND ( -- Categoria Articulo
                                                              criterio.ArtCategoria IS NULL 
                                                            OR criterio.ArtCategoria = a.Categoria
                                                          )
                                                      AND ( -- Grupo Articulo
                                                              criterio.ArtGrupo IS NULL 
                                                            OR criterio.ArtGrupo = a.Grupo
                                                          )  
                                                      AND ( -- Articulo
                                                              criterio.Articulo IS NULL 
                                                            OR criterio.Articulo = d.Articulo
                                                          ) 
                                                      AND ( -- Largo
                                                            ISNULL(criterio.Largo,'') IN ('',ISNULL(subCta.Largo,''))
                                                          ) 
  -- Solo acciones de criterio Activas
  JOIN CUP_AccionComprasEspeciales c_accion ON c_acciones.ID = criterio.Accion
                                           AND c_accion.Activo = 1
  -- Solo Reucrrencias Activas
  JOIN CUP_RecurrenciaAccionComprasEspeciales c_recurrencia ON c_recurrencia.ID = criterio.Recurrencia
                                                          AND c_recurrencia.Activo = 1
  WHERE
    c.ID = @ID

  --
  
  RETURN	
END
go