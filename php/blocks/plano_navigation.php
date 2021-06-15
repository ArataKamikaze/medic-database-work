<div class="uk-container uk-container-small uk-margin-small-top">
    <a uk-toggle="target: #charts_area; animation: uk-animation-fade, uk-animation-fade" class = "uk-text-secondary uk-text-large uk-text"type="button">Resumo<span uk-icon="icon: triangle-down"></span></a>
    <div class="uk-grid-small uk-grid-match uk-child-width-expand@s uk-text-center" hidden="" id="charts_area" uk-grid>
      <div>
          <div class="uk-card uk-card-default uk-card-body"><?php include("../charts/chart_tratamento_cronicos.php") ?></div>
      </div>
      <div>
          <div class="uk-card uk-card-default uk-card-body">
            <?php
                $sql = 'call plano_de_saude_que_mais_atende(@a, @b, @c, @d);';
                foreach ($dbl->query($sql) as $row) {
                  $nome = $row['nome'];
                }
             ?>
             <p class="uk-text-bold uk-margin-small">Plano com mais atendimentos:</p>
             <p class="uk-margin-small"><?php echo $nome; ?></p>
          </div>
      </div>
    </div>
</div>
