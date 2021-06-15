<?php
$subtype = "realizados";
if(isset($_GET['subtype'])){
    $subtype=$_GET['subtype'];
}
switch ($subtype ) {
  case 'realizados':
      include("../blocks/atendimentos_realizados.php");
      break;
  case 'value':
    // code...
    break;
  case 'value':
    // code...
    break;
  default:
    // code...
    break;
}
?>
