<div class="uk-container uk-container-small uk-margin-small-top">
    <a uk-toggle="target: #charts_area; animation: uk-animation-fade, uk-animation-fade" class = "uk-text-secondary uk-text-large uk-text"type="button">Resumo<span uk-icon="icon: triangle-down"></span></a>
    <div class="uk-grid-small uk-grid-match uk-child-width-expand@s uk-text-center" hidden="" id="charts_area" uk-grid>
      <div>
          <div class="uk-card uk-card-default uk-card-body"><?php include("../charts/chart_client_estado_civil.php") ?></div>
      </div>
      <div>
          <div class="uk-card uk-card-default uk-card-body"><?php include("../charts/chart_client_histogram.php") ?></div>
      </div>
      <div>
          <div class="uk-card uk-card-default uk-card-body">
            <?php
                $sql = 'select @media as media, @mediana as mediana, @desvio as desvio from dual;';
                foreach ($dbl->query($sql) as $row) {
                  $media   = $row['media'];
                  $mediana = $row['mediana'];
                  $desvio  = $row['desvio'];
                }
             ?>
             <p class="uk-text-bold uk-margin-small">Media:</p>
             <p class="uk-margin-small"><?php echo $media; ?></p>
             <p class="uk-text-bold uk-margin-small">Mediana:</p>
             <p class="uk-margin-small"><?php  echo $mediana;?></p>
             <p class="uk-text-bold uk-margin-small">Desvio:</p>
             <p class="uk-margin-small"><?php  echo $desvio?></p>
          </div>
      </div>
    </div>
</div>
