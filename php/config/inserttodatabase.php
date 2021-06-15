<?php
include("db.php");
$type         = $_GET['type'];
if ($type == "cliente") {
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
$sql = "call obter_plano_de_saude();";
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
}
else{
$sala             = $_GET['sala'];
$data             = $_GET['data'];
$hora             = $_GET['hora'];
$medico           = $_GET['medico'];
$plano            = $_GET['plano'];
$tipo_atendimento = $_GET['tipo_atendimento'];
$cpf              = $_GET['cpf'];
$tipo_tratamento  = $_GET['tipo_tratamento'];
$sql = "call criar_tratamento(".$tipo_tratamento.", ".$cpf.");";
$res = $dbl->query($sql);
$sql = "SELECT * FROM tratamento where cpf = ".$cpf.";";
foreach ($dbl->query($sql) as $row) {
  $tratamento_id = $row['tratamento_id'];
}
$cad_atendimento = array(
                      "sala"=>$sala,
                      "horario_agendado"=> $data." ".$hora.":00",
                      "estado"=>0,
                      "crm"=>$medico,
                      "plano_de_saude_id"=>$plano,
                      "tipo_de_atendimento_id"=>$tipo_atendimento,
                      "tratamento_id"=>$tratamento_id
                      );
$cad_atendimento = json_encode($cad_atendimento);
echo $cad_atendimento;


$sql = "call agendar_atendimento('".$cad_atendimento."');";
echo $sql;
$res = $dbl->query($sql);


}
 ?>
 <script language="Javascript">
   location.href="../pages/list.php?type=<?php echo $type; ?>";
 </script>
