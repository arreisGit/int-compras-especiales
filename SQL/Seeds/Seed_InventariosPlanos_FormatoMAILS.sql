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
  asunto = 'Notificación de avance compra especial [MOVIMIENTO]',
  cuerpo = 
'<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport"
        content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <title[TITLE]</title>

  <!-- Normalize -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/normalize/6.0.0/normalize.min.css"
        rel="stylesheet">

   <!-- Ubuntu Font OP -->
  <link href="https://fonts.googleapis.com/css?family=Ubuntu" rel="stylesheet">

  <!-- custom css -->
  <style>

    body{ font-family: "Ubuntu", "Times New Roman", Times, serif;}

    .cml-container {
      width : 100%;
      max-width : 1200px;
      padding: 0 16px 12px 18px;
      box-sizing: border-box; 
    }

    .bold { font-weight: bold; }
    .center { text-align: center; }

    header > h1 { margin-bottom: 12px; }
    .header-data { border-style: none; }
    .header-data td { padding: 0 6px 0 6px; }

    .cml-table
    {
      text-align: left;
      margin-top: 20px;
      margin-bottom: 20px;
      border-collapse: collapse;
      background-color: transparent;
    }
    
    .cml-table caption
    {
      text-align: left; 
      font-weight: 100;
      font-style: italic;
      font-size: 12px;
      color: #636c72;
      margin: 0 !important;
      padding: 0 !important;
    }

    .cml-table th
    {
      padding:  4px;
      line-height: 1.5;
      border-top: ;
      border-bottom: 1px solid #eceeef;

    }
    .cml-table td
    {
      padding:  4px;
      line-height: 1.5;
      vertical-align: top;
      display: table-cell;
      border-bottom: 1px solid #eceeef;
    }
    
  </style>
</head>
<body>
  
  <header class="cml-container">
    <h1 class="center">Notificación de compra especial</h1>
    
    <table class="header-data">
      <tr>
        <td class="bold">Mov:</td>
        <td>[MOVIMIENTO]</td>
      </tr>
      <tr>
        <td class="bold">Fecha Emisión:</td>
        <td>[FECHA]</td>
      </tr>
      <tr>
        <td class="bold">Referencia:</td>
        <td>[REFERENCIA]</td>
      </tr>
      <tr>
        <td class="bold">Usuario:</td>
        <td>[USUARIO]</td>
      </tr>
      <tr>
        <td class="bold">Orden Compra:</td>
        <td>[ORDEN_COMPRA]</td>
      </tr>
      <tr>
        <td class="bold">Cliente:</td>
        <td>[CLIENTE]</td>
      </tr>
      <tr>
        <td class="bold">Proveedor:</td>
        <td>[PROVEEDOR]</td>
      </tr>
      <tr>
        <td class="bold">Factura:</td>
        <td>[FACTURA]</td>
      </tr>
      <tr>
        <td class="bold">Fecha Factura:</td>
        <td>[FACTURA_FECHA]</td>
      </tr>
    </table>
  </header>
  
  <main class="cml-container">

    <!-- Special Criteria -->
    <table class="cml-table">
      <caption>Criterios aplicados:</caption>
      <thead>
        <tr>
          <th>Criterio</th>
          <th>Descripción</th>
        </tr>
      </thead>
      <tbody>
        [CRITERIOS_ESPECIALES]
      </tbody>
    </table>

    <!-- Details -->
    <table class="cml-table">
      <caption>Detalle del Movimiento:</caption>
      <thead>
        <tr>
          <th>Articulo</th>
          <th>Subcuenta</th>
          <th>Descripción</th>
          <th>Cantidad</th>
          <th>Unidad</th>
        </tr>
      </thead>
      <tbody>
        [DETALLE_MOV]
      </tbody>
    </table>
  </main>
</body>
</html>',
  destinatarios = '[RESPONSABLES]',
  cc = '[CC]',
  bcc = 'enrique.sierra@cuprum.com',
  modulo = 'COMS',
  descripcion_breve ='Notificación de compras especiales'

SELECT
  * 
FROM
  [172.18.9.69].InventariosPlanos.dbo.FormatosMail 


--DELETE    [172.18.9.69].InventariosPlanos.dbo.FormatosMail   WHERE id_formato = 67