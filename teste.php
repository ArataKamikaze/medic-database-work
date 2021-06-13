<?php
    include("php/config/db.php");
    $sql = 'call dados_clientes_idade(@media, @mediana, @desvio);';
    $dbl->query($sql);
    $sql = 'select @media, @mediana, @desvio from dual;';
    foreach ($dbl->query($sql) as $row) {
      $var = $row['@media'];
    }


?>
