<?php

  $sql =  'select obter_n_lista_de_clientes("") as num from dual;';
  foreach ($dbl->query($sql) as $row) {
      $pages = $row['num'];
  }
  $page = 1;
  if(isset($_GET['page'])){
        $page=$_GET['page'];
  }
?>
