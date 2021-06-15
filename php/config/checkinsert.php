<?php
switch ($type) {
  case "clientes":
      include("../forms/insertclient.php");
      break;
  case "medicos":

      break;
  case "atendimentos":
      include("../forms/insertatendimentos.php");
      break;
  case "planos":

      break;
  case "funcionarios":

      break;
  case "tratamentos":

      break;
  default:

      break;
    }
 ?>
