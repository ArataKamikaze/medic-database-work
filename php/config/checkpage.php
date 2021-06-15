<?php
switch ($type) {
  case "clientes":
        $sql =  'select obter_n_lista_de_clientes("'.$search.'") as num from dual;';
        break;
  case "medicos":
        $sql =  'select obter_n_lista_de_medicos("'.$search.'") as num from dual;';
        break;
  case "atendimentos":
      switch ($subtype) {
          case "realizados"
              $sql =  'select obter_n_lista_de_medicos("'.$search.'") as num from dual;';
              break;
          case 'agendados':

              break;
          case 'novos':

              break;
          default:

              break;
    }
  case "planos":
        $sql =  'select obter_n_lista_de_planos("'.$search.'") as num from dual;';
        break;
  case "funcionarios":
        $sql =  'select obter_n_lista_de_funcionarios("'.$search.'") as num from dual;';
        break;
  case "tratamentos":
        $sql =  'select obter_n_lista_de_tratamentos("'.$search.'") as num from dual;';
        break;
  default:

        break;
}

  foreach ($dbl->query($sql) as $row) {
      $pages = $row['num'];
  }
  $page = 1;
  if(isset($_GET['page'])){
        $page=$_GET['page'];
  }
?>
