DECLARE @ProvL TABLE
(
  Proveedor CHAR(10) PRIMARY KEY NOT NULL,
  Producto VARCHAR(20) NOT NULL,
  Servicio VARCHAR(20) NOT NULL
)

INSERT INTO @ProvL
(
  Proveedor
 ,Producto
 ,Servicio
)
VALUES
  ( LTRIM(RTRIM(NULLIF('AC0591    ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('AC0592    ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('I198      ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('I2033     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('I2036     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('I2037     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('I206      ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('I218      ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('I221      ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('I231      ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('I236      ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('I237      ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('I238      ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('I241      ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('I243      ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('I244      ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('I261      ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('I275      ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('I283      ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('I299      ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('I306      ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('I319      ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('I401      ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('N1072     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('N340      ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('N3539     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('N3779     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('N3831     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('N3890     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('N400      ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('N4129     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('N4508     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('N4655     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('N481      ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('N5055     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('N5063     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('N5089     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('N5091     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('N5113     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('N5129     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('N5141     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('N5148     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('N5151     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('TDF101    ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('TDF12     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('TDF345    ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('TDF7      ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('V0027     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('V0037     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3115     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3137     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3139     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3141     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3146     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3147     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3152     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3158     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3163     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3164     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3167     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3168     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3169     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3173     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3174     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3175     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3177     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3180     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3181     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3184     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3187     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3188     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3200     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3249     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Molino',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3250     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3260     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) ),
  ( LTRIM(RTRIM(NULLIF('V3274     ',''))), LTRIM(RTRIM(NULLIF('Materia Prima',''))), LTRIM(RTRIM(NULLIF('Broker',''))) )

;WITH ProvL AS ( 
  SELECT 
    Proveedor,
    Producto,
    Servicio,
    ID = CASE Servicio
           WHEN 'Broker' THEN 
             '/1/1/'
           ELSE 
             '/1/2/'
        END

  FROM 
    @ProvL
)
UPDATE p 
SET 
  p.CUP_CatProductoServicio = pl.ID
FROM 
  ProvL pl 
JOIN Prov p ON p.Proveedor = pl.Proveedor