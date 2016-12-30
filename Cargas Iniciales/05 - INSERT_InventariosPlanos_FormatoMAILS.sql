SET ANSI_NULLS, ANSI_WARNINGS ON;

GO 

SELECT
  * 
FROM
  [172.18.9.69].InventariosPlanos.dbo.FormatosMail 

INSERT INTO
  [172.18.9.69].InventariosPlanos.dbo.FormatosMail 
(
  sql_profile,
  importancia,
  asunto,
  cuerpo,
  destinatarios,
  cc,
  bcc,
  modulo,
  descripcion_breve
)
SELECT 
  sql_profile = 'Intelisis',
  importancia = 'High',
  asunto = 'Notificación Compra Especial',
  cuerpo = 
'<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Notificación Compra Especial</title>
  <style type="text/css">
    .blue{
      color: blue;
    }   
  </style>
</head>
<body>
  <p>Para poder facturar la <span class="blue">[Movimiento]</span>, se requiere
  de la liberación por parte de Cxc. Favor de revisar el movimiento.</p> 
</body>
</html>',
  destinatarios = '[RESPONSABLES]',
  cc = 'enrique.sierra@cuprum.com',
  bcc = 'enrique.sierra@cuprum.com',
  modulo = 'CXC',
  descripcion_breve ='Notificación orden surtido en espera de revisión Cxc'

SELECT
  * 
FROM
  [172.18.9.69].InventariosPlanos.dbo.FormatosMail 


--DELETE   ZITLSAD.InventariosPlanos.dbo.FormatosMail  WHERE id_formato = 33