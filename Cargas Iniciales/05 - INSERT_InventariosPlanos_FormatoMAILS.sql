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
  asunto = 'Notificaci�n Compra Especial',
  cuerpo = 
'<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Notificaci�n Compra Especial</title>
  <style type="text/css">
    .blue{
      color: blue;
    }   
  </style>
</head>
<body>
  <p>Para poder facturar la <span class="blue">[Movimiento]</span>, se requiere
  de la liberaci�n por parte de Cxc. Favor de revisar el movimiento.</p> 
</body>
</html>',
  destinatarios = '[RESPONSABLES]',
  cc = 'enrique.sierra@cuprum.com',
  bcc = 'enrique.sierra@cuprum.com',
  modulo = 'CXC',
  descripcion_breve ='Notificaci�n orden surtido en espera de revisi�n Cxc'

SELECT
  * 
FROM
  [172.18.9.69].InventariosPlanos.dbo.FormatosMail 


--DELETE   ZITLSAD.InventariosPlanos.dbo.FormatosMail  WHERE id_formato = 33