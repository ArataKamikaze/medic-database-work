<?php
include("db.php");

$type         = $_GET['type'];
$cpf          = $_GET['cpf'];
$name         = $_GET['name'];
$estado_civil = $_GET['estado_civil'];
$sexo         = $_GET['sexo'];
$nascimento   = $_GET['nascimento'];
$telefone     = $_GET['telefone'];
$cep          = $_GET['cep'];
$estado       = $_GET['estado'];
$cidade       = $_GET['cidade'];
$bairro       = $_GET['bairro'];
$logradouro   = $_GET['logradouro'];
$complemento  = $_GET['complemento'];
$numero       = $_GET['numero'];
$email        = $_GET['email'];

$pessoa = array(
              "CPF"=>$cpf,
              "nome"=>$name,
              "estado_civil"=>$estado_civil,
              "sexo"=>$sexo,
              "data_de_nascimento"=>$nascimento,
              "numero_do_telefone"=>$telefone,
              "cep"=>$cep,
              "estado"=>$estado,
              "cidade"=>$cidade,
              "bairro"=>$bairro,
              "logradouro"=>$logradouro,
              "complemento"=>$complemento,
              "numero"=>$numero,
              "email"=>$email);

$doencas = "";
$sql = "call obter_doencas()";
foreach ($dbl->query($sql) as $row) {
    $doenca_id = $row['doenca_id'];
    $id_doenca = "";
    if(isset($_GET['doenca_'.$doenca_id])){
        $id_doenca=$_GET['doenca_'.$doenca_id];
        $doencas .= $id_doenca.",";
    }
}
$doencas = substr($doencas, 0, -1);


$planos = "";
$sql = "call hospital.obter_plano_de_saude();";
foreach ($dbl->query($sql) as $row) {
    $plano_id = $row['plano_de_saude_id'];
    $id_plano = "";
    if(isset($_GET['plano_'.$plano_id])){
        $planos .= $plano_id.",";
    }
}
$planos = substr($planos, 0, -1);
$cliente = array(
              "CPF"=>$cpf,
              "doencas_pre_existentes"=>$doencas,
              "planos_de_saude"=>$planos,
            );
$pessoa = json_encode($pessoa);
$cliente = json_encode($cliente);
$sql = "call cadastrar_pessoa('".$pessoa."');";
$res = $dbl->query($sql);
$sql = "call cadastrar_cliente('".$cliente."');";
$res = $dbl->query($sql);
 ?>
<script language="Javascript">
  location.href="../pages/list.php?type=<?php echo $type; ?>";
</script>
