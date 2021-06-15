<script>
function validateMe(){
    var x=document.getElementById("sala").selectedIndex;
    var y=document.getElementById("sala").options;
    if(y[x] == "choose"){
       return false;
    }
    var x=document.getElementById("medico").selectedIndex;
    var y=document.getElementById("medico").options;
    if(y[x] == "choose"){
       return false;
    }
    var x=document.getElementById("plano").selectedIndex;
    var y=document.getElementById("plano").options;
    if(y[x] == "choose"){
       return false;
    }
    var x=document.getElementById("tipo_atendimento").selectedIndex;
    var y=document.getElementById("tipo_atendimento").options;
    if(y[x] == "choose"){
       return false;
    }
    var x=document.getElementById("cpf").selectedIndex;
    var y=document.getElementById("cpf").options;
    if(y[x] == "choose"){
       return false;
    }
    var x=document.getElementById("tipo_tratamento").selectedIndex;
    var y=document.getElementById("tipo_tratamento").options;
    if(y[x] == "choose"){
       return false;
    }


    return true;
}
</script>
<div class="uk-container uk-container-small">
  <form name="Form" id ="Form" action="../config/inserttodatabase.php" method="get" onSubmit="return validateMe()">
    <input type="hidden" name="type" value="<?php echo $type; ?>">
    <fieldset class="uk-fieldset">

        <legend class="uk-legend">Agendar Atendimentos</legend>

        <div class="uk-margin">
            <select class="uk-select" name="sala" id="sala">
                <option value="choose">Selecione a sala</option>
                <?php
                  $sql = 'SELECT sala FROM atendimento group by sala order by sala ASC;';
                  foreach ($dbl->query($sql) as $row) {
                    $sala = $row['sala'];
                      echo "<option value=".$sala.">".$sala."</option>";
                  }
                 ?>
            </select>
        </div>

        <div class="uk-margin uk-grid">
          <div class="">
            <label> data
            <input type="date" name="data" class="uk-input">
            </label>
          </div>
          <div class="">
            <label>hora
            <input type="time" name="hora" class="uk-input">
            </label>
          </div>
        </div>


        <div class="uk-margin">
            <select class="uk-select" name="medico" id="medico">
                <option value="choose">Selecione médico</option>
                <?php
                    $sql = 'SELECT * FROM pessoa left join medico_funcionario on (pessoa.cpf = medico_funcionario.cpf) where medico_funcionario.crm is not null;';
                    foreach ($dbl->query($sql) as $row) {
                      $crm = $row['CRM'];
                      $nome = $row['nome'];
                        echo "<option value=".$crm.">".$nome."</option>";
                    }
                    $sql = 'SELECT * FROM pessoa left join medico_prestador_de_servico on (pessoa.cpf = medico_prestador_de_servico.cpf) where medico_prestador_de_servico.crm is not null;';
                    foreach ($dbl->query($sql) as $row) {
                      $crm = $row['crm'];
                      $nome = $row['nome'];
                        echo "<option value=".$crm.">".$nome."</option>";
                    }
                 ?>
            </select>
        </div>


        <div class="uk-margin">
            <select class="uk-select" name="plano" id="plano">
                <option value="choose">Selecione o plano de saude</option>
                <?php
                    $sql = 'SELECT * FROM plano_de_saude;';
                    foreach ($dbl->query($sql) as $row) {
                      $nome = $row['nome'];
                      $id = $row['plano_de_saude_id'];
                        echo "<option value=".$id.">".$nome."</option>";
                    }
                 ?>
            </select>
        </div>


        <div class="uk-margin">
            <select class="uk-select" name="tipo_atendimento" id="tipo_atendimento">
                <option value="choose">Selecione o tipo de atendimento</option>
                <?php
                    $sql = 'SELECT * FROM tipo_de_atendimento;';
                    foreach ($dbl->query($sql) as $row) {
                      $nome = $row['nome'];
                      $id = $row['tipo_de_atendimento_id'];
                        echo "<option value=".$id.">".$nome."</option>";
                    }
                 ?>
            </select>
        </div>
        <div class="uk-margin">
            <select class="uk-select" name="cpf" id="cpf">
                <option value="choose">Selecione o cliente</option>
                <?php
                    $sql = 'select cliente.cpf, pessoa.nome from cliente left join pessoa on cliente.cpf = pessoa.cpf;';
                    foreach ($dbl->query($sql) as $row) {
                      $nome = $row['nome'];
                      $id = $row['cpf'];
                        echo "<option value=".$id.">".$nome."</option>";
                    }
                 ?>
            </select>
        </div>
        <div class="uk-margin">
            <select class="uk-select" name="tipo_tratamento" id="tipo_tratamento">
                <option value="choose">Selecione o tipo do tratamento</option>
                <?php
                    $sql = 'SELECT * FROM tipo_de_tratamento;';
                    foreach ($dbl->query($sql) as $row) {
                      $nome = $row['nome'];
                      $id = $row['tipo_de_tratamento_id'];
                        echo "<option value=".$id.">".$nome."</option>";
                    }
                 ?>
            </select>
        </div>

        <div class="uk-margin-large uk-flex uk-flex-center">
            <button type="submit" class="uk-margin-medium-right uk-button uk-button-primary uk-button-large">Enviar</button>
            <button type="button" class="uk-margin-medium-left uk-button uk-button-danger uk-button-large" onclick='window.location.href="list.php?type=<?php echo $type;?>"'>Cancelar</button>
        </div>
    </fieldset>
  </form>
</div>
