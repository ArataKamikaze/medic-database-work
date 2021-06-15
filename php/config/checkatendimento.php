<?php
switch ($subtype ) {
  case 'realizados':
      include("../blocks/atendimentos_realizados.php");
      $sql =  'select obter_n_atendimentos_realizados("'.$data_ini.'", "'.$data_fim.'") as num;';
      break;
  case 'agendados':
      include("../blocks/atendimentos_agendados.php");
      $sql = 'select obter_n_atendimentos_agendados("'.$data_ini.'", "'.$data_fim.'") as num;';
    break;
  default:
    // code...
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
