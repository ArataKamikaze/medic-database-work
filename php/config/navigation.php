<?php
  switch ($type) {
    case 'clientes':
        include('../blocks/client_navigation.php');
        break;
    case 'medicos':
        include('../blocks/medic_navigation.php');
        break;
    case 'funcionarios':
        include('../blocks/funcionario_navigation.php');
        break;
    case 'tratamentos':
        include('../blocks/tratamento_navigation.php');
        break;
    case 'planos':
        include('../blocks/plano_navigation.php');
        break;
    default:
      break;
  }

 ?>
