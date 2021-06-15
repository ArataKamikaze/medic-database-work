<?php
$data_ini = "2000-01-01";
if(isset($_GET['inicio'])){
    $data_ini = $_GET['inicio'];
}
$data_fim = "2030-01-01";
if(isset($_GET['fim'])){
    $data_fim = $_GET['fim'];
}
$sql = "call obter_dados_atendimentos_realizados('".$data_ini."','".$data_fim."')";
  foreach ($dbl->query($sql) as $row) {
      $recebido_media    = $row['valor_recebido_media'];
      $recebido_desvio   = $row['valor_recebido_desvio'];
      $arrecadado_media  = $row['valor_arrecadado_media'];
      $arrecadado_desvio = $row['valor_arrecadado_desvio'];
      $quantidade        = $row['quantidade'];
  }

 ?>


<div class="uk-container uk-container-small">
    <p class = "uk-text-large custom_gray">Período:</p>
    <div class="uk-grid uk-grid-medium">
      <div class="">
          <form class="" action="" method="get">
            <div class="uk-margin-small">
                <label>inicio:
                    <input type="date" class="uk-input"name="inicio" value="inicio">
                </label>
            </div>
            <div class="uk-margin-small">
                <label>fim:
                    <input type="date" class="uk-input"name="fim" value="fim">
                </label>
            </div>
            <button type="submit" class="uk-button uk-button-primary ">Enviar</button>
            <input type="hidden" name="type" value="<?php echo $type;?>">
            <input type="hidden" name="subtype" value="<?php echo $subtype;?>">
          </form>
      </div>
    </div>
</div>
<div class="uk-container uk-container-small uk-margin-small-top">
    <div class="uk-grid uk-grid-match uk-child-width-expand@s uk-text-center">
      <div class="">
          <div class="uk-card uk-card-default uk-card-body">
              <legend class="uk-legend">Valor Recebido</legend>
              <p class="uk-text-bold uk-margin-small">Media:</p>
              <p class="uk-margin-small"><?php echo $recebido_media; ?></p>
              <p class="uk-text-bold uk-margin-small">Desvio:</p>
              <p class="uk-margin-small"><?php  echo $recebido_desvio?></p>
          </div>
      </div>
      <div class="">
          <div class="uk-card uk-card-default uk-card-body">
              <legend class="uk-legend">Valor Arrecadado</legend>
              <p class="uk-text-bold uk-margin-small">Media:</p>
              <p class="uk-margin-small"><?php echo $arrecadado_media; ?></p>
              <p class="uk-text-bold uk-margin-small">Desvio:</p>
              <p class="uk-margin-small"><?php  echo $arrecadado_desvio?></p>
          </div>
      </div>
      <div class="">
          <div class="uk-card uk-card-default uk-card-body">
              <legend class="uk-legend">Quantidade</legend>
              <p class="uk-text-bold uk-margin-small">Total:</p>
              <p class="uk-margin-small"><?php echo $quantidade; ?></p>

          </div>
      </div>
    </div>
</div>
