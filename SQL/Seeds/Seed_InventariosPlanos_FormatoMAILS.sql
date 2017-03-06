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
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>[TITLE]</title>

  
  <!-- Normalize -->
  <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css.map">

  <!-- Latest compiled and minified Bootsrap Alpha 4 CSS -->
  <link rel="stylesheet"
        href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css"
        integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ"
        crossorigin="anonymous">

  <!-- custom css -->
  <style>
    /* why would anyone use a bigger screen!! :V */
    .container-fluid {max-width:1170px;}

    .margin-xs-em-bottom {margin-bottom: .3em;}  
    .margin-sm-em-bottom {margin-bottom: .5em;}
    .margin-md-em-bottom {margin-bottom:  1em;}  
    .margin-lg-em-bottom {margin-bottom:  2em;} 
   
    .caption-top{ caption-side: top; }

    /* Because we''re re not importing a css file
       the min-width must be hardcoded :v  */
    @media (min-width: 768px) {
      .text-md-left {text-align: left;}
    }  
  </style>

</head>
<body>
  
  <div class="container-fluid">

    <header class="margin-lg-em-bottom">
      <!-- Title -->
      <div class="row
                  align-items-center
                  margin-md-em-bottom">
        <div class="hidden-sm-down
                    col-md-4">
          <img class="img-fluid"
               src="http://www.cuprum.com/images/header/logo.gif"
               alt="CUPRUM logo">
        </div>
        <div class="col-md-8
                    text-center
                    text-md-left">
          <h3>Notificación de compra especial</h3>
        </div>
      </div>

      <!-- Header -->
      <div class="row text-left" >
        <div class="col-12 header-info">

          <div class="row">
            <div class="col-sm-3
                        col-lg-2">
               <strong>Mov: </strong>
            </div>
            <div class="col-sm-9
                        col-lg-10">
                [MOVIMIENTO]
            </div>
          </div>

          <div class="row">
            <div class="col-sm-3
                        col-lg-2">
               <strong>Fecha Emisión: </strong>
            </div>
            <div class="col-sm-9
                        col-lg-10">
                [FECHA]
            </div>
          </div>

          <div class="row">
            <div class="col-sm-3
                        col-lg-2">
               <strong>Referencia:</strong>
            </div>
            <div class="col-sm-9
                        col-lg-10">
                [REFERENCIA]
            </div>
          </div>

          <div class="row">
            <div class="col-sm-3
                        col-lg-2">
               <strong>Usuario: </strong>
            </div>
            <div class="col-sm-9
                        col-lg-10">
                [USUARIO]
            </div>
          </div>
          
          <div class="row">
            <div class="col-sm-3
                        col-lg-2">
               <strong>Orden Compra:</strong>
            </div>
             <div class="col-sm-9
                         col-lg-10">
                [ORDEN_COMPRA]
            </div>
          </div>

          <div class="row ">
            <div class="col-sm-3
                        col-lg-2">
               <strong>Proveedor:</strong>
            </div>
            <div class="col-sm-9
                        col-lg-10">
                [PROVEEDOR]
            </div>
          </div>
        </div>
      </div>
    </header>

    <!-- Special Criteria -->
    <main>
      <div class="row">
        <div class="col-12">
          

          <table class="table table-sm">
            <caption class="caption-top">Criterios aplicados:</caption>
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

        </div>
      </div>
    </main>
   
  </div>

    <!-- Jquery --> 
  <script src="https://code.jquery.com/jquery-3.1.1.slim.min.js"
          integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n"
          crossorigin="anonymous"></script>

  <!-- Tether -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"
          integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb"
          crossorigin="anonymous"></script>

  <!-- Bootrap 4 javascript -->
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js"
          integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn"
          crossorigin="anonymous"></script>
   
  <!-- custom js -->
  <script type="text/javascript">
    $(document).ready(function(){
      $(".header-info > .row").after(''<div class="clearfix hidden-sm-up margin-xs-em-bottom"></div>'');
    });
  </script>

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