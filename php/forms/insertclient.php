<?php include("../blocks/cpf.php") ?>
<script>
function validateMe(){
    var x=document.getElementById("estado_civil").selectedIndex;
    var y=document.getElementById("estado_civil").options;
    var x1=document.getElementById("sexo").selectedIndex;
    var y1=document.getElementById("sexo").options;
    if(y[x] != "Casado(a)"|| y[x] != "Divorciado(a)" || y[x] != "Separado(a)" || y[x] != "Solteiro(a)" || y[x] != "Viuvo(a)"){
       return false;
       print("falso mano");/
    }
    if(y1[x1] != "M"|| y1[x1] != "F"){
       return false;
       print("falso mano");
    }

    return true;
}
</script>
<div class="uk-container uk-container-small">
  <form name="Form" id ="Form" action="../config/inserttodatabase.php" method="get" onSubmit="return validateMe()">
    <input type="hidden" name="cpf" value="<?php echo $cpf; ?>">
    <input type="hidden" name="type" value="<?php echo $type; ?>">
    <fieldset class="uk-fieldset">

        <legend class="uk-legend">Informações básicas</legend>

        <div class="uk-margin">
            <label for="cpf" uk-label>cpf</label>
            <input class="uk-input" value="<?php echo $cpf ?>" name="cpf" type="text" placeholder="CPF" disabled>
        </div>

        <div class="uk-margin">
            <input class="uk-input"  name="name" type="text" placeholder="Nome">
        </div>

        <div class="uk-margin">
            <select class="uk-select" name="estado_civil" id="estado_civil">
                <option value="choose">Selecione o estado civil</option>
                <option value="Casado(a)">Casado(a)</option>
                <option value="Divorciado(a)">Divorciado(a)</option>
                <option value="Separado(a)">Separado(a)</option>
                <option value="Solteiro(a)">Solteiro(a)</option>
                <option value="Viuvo(a)">Viuvo(a)</option>
            </select>
        </div>
        <div class="uk-margin">
            <select class="uk-select" name="sexo" id="sexo">
                <option value="choose">Selecione o sexo</option>
                <option value="1">M</option>
                <option value="0">F</option>
            </select>
        </div>

        <div class="uk-margin">
          <label>Data de nascimento:<input class="uk-input"  name="nascimento" type="date" placeholder="Data"></label>
        </div>

        <div class="uk-margin">
            <input class="uk-input"  name="telefone" id="telefone" type="tel" placeholder="Telefone">
        </div>

        <div class="uk-margin">
            <input class="uk-input"  name="cep" type="number" placeholder="CEP">
        </div>

        <div class="uk-margin">
            <input class="uk-input"  name="estado" type="text" placeholder="Estado">
        </div>

        <div class="uk-margin">
            <input class="uk-input"  name="cidade" type="text" placeholder="Cidade">
        </div>

        <div class="uk-margin">
            <input class="uk-input"  name="bairro" type="text" placeholder="Bairro">
        </div>

        <div class="uk-margin">
            <input class="uk-input"  name="logradouro" type="text" placeholder="Logradouro">
        </div>

        <div class="uk-margin">
            <input class="uk-input"  name="complemento" type="text" placeholder="Complemento">
        </div>

        <div class="uk-margin">
            <input class="uk-input"  name="numero" type="number" placeholder="Numero">
        </div>

        <div class="uk-margin">
            <input class="uk-input"  name="email" type="e-mail" placeholder="e-mail... (DarthVader22@Imperio.com 👌)">
        </div>

        <legend class="uk-legend">Doenças pré-existentes:</legend>

        <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid">
            <?php
            $sql = "call obter_doencas()";
            foreach ($dbl->query($sql) as $row) {
                $nome = $row['nome'];
                $doenca_id = $row['doenca_id'];

                echo '<div class="uk-width-1-4"><label><input class="uk-checkbox" type="checkbox" value="'.$doenca_id.'" name="doenca_'.$doenca_id.'"> '.$nome.'</label><br></div>';
            }
             ?>
        </div>


        <legend class="uk-legend">Planos de Saúde</legend>

        <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid">
            <?php
            $sql = 'call hospital.obter_plano_de_saude();';
            foreach ($dbl->query($sql) as $row) {
              $nome = $row['nome'];
              $id = $row['plano_de_saude_id'];
              echo '<div class="uk-width-1-4"><label><input class="uk-checkbox" type="checkbox" value="'.$id.'" name="plano_'.$id.'"> '.$nome.'</label><br></div>';
            }
             ?>
        </div>

        <div class="uk-margin-large uk-flex uk-flex-center">
            <button type="submit" class="uk-margin-medium-right uk-button uk-button-primary uk-button-large">Enviar</button>
            <button type="button" class="uk-margin-medium-left uk-button uk-button-danger uk-button-large" onclick='window.location.href="list.php?type=<?php echo $type;?>"'>Cancelar</button>
        </div>
    </fieldset>
</form>
</div>
