<!doctype html>
<html lang="en">
<head>
    <title>Clínica Madre teresa</title>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="css/uikit.min.css" />
    <link rel="stylesheet" href="css/main.css"/>
    <script src="js/uikit.min.js"></script>
    <script src="js/uikit-icons.min.js"></script>
    <script src="js/chart.min.js" type="text/javascript"></script>
    <link rel="shortcut icon" href="img/logo.png">
</head>
<body class="custom_padding_bottom_5p">
    <!-- conexão database -->
     <?php include( 'php/config/db.php'); ?>

     <!-- checagem do tipo da página -->
     <?php include( 'php/config/checktype.php'); ?>

     <!-- navbar -->
     <nav class="uk-navbar custom_blue_bg " uk-navbar="mode: click">
       <div class="uk-navbar-center uk-container-expand">
           <div class="uk-navbar-center-left">
             <div>
               <ul class="uk-navbar-nav">
                 <li><a class="custom_white" href="php/pages/list.php?type=clientes">Clientes</a></li>
                 <li><a class="custom_white" href="php/pages/list.php?type=medicos">Médicos</a></li>
                 <li><a class="custom_white" href="php/pages/list.php?type=funcionarios">Funcionários</a></li>
               </ul>
             </div>
           </div>
           <a href="" class="uk-navbar-item uk-logo">
             <img src="img/logo.png" width="50px"alt="logo">
           </a>
           <div class="uk-navbar-center-right">
             <div>
               <ul class="uk-navbar-nav">
                 <li><a class="custom_white" href="php/pages/list.php?type=tratamentos">Tratamentos</a></li>
                 <li><a class="custom_white" href="php/pages/list.php?type=atendimentos">Atendimento</a></li>
                 <li><a class="custom_white" href="php/pages/list.php?type=planos">Planos de Saúde</a></li>
               </ul>
             </div>
           </div>
         </div>
     </nav>

     <!-- informações da pagina -->
     <div class="uk-container uk-container-small uk-animation-fade">
       <label for="table1">Consultas próximas:</label>
     </div>
     <?php include( 'php/tables/table.php'); ?>


     <div class="uk-container uk-container-small uk-margin-small-top uk-animation-fade">
       <label for="table2">Clientes com tratamento crônico, que possuem agendamento pendente:</label>
     </div>
     <?php include( 'php/tables/table_1.php'); ?>
</body>
</html>
