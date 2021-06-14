<?php
  include("head.php");
  include("db.php");
  include("checktype.php");
  include("navbar.php");
    $cpf = 0;
    if(isset($_GET['cpf'])){
        $cpf=$_GET['cpf'];
    }
    switch ($type) {
      case "clientes":
          $sql = ("select hospital.verificar_se_existe_cliente(".$cpf.") as checkcpf;");
          break;
      case "medicos":

          break;
      case "atendimentos":

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
    foreach ($dbl->query($sql) as $row) {
        $checkcpf = $row['checkcpf'];
    }
    if ($checkcpf == 0) {
      ?>
          <script language="Javascript">
            location.href="../pages/insert.php?type=<?php echo $type; ?>&validcpf=true&cpf=<?php echo $cpf; ?>";
          </script>
      <?php
    }else {
      ?>
          <script language="Javascript">
            location.href="../pages/insert.php?type=<?php echo $type; ?>&validcpf=false&cpf=<?php echo $cpf; ?>";
          </script>
      <?php
    }
 ?>
