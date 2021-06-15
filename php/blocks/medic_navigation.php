<div class="uk-container uk-container-small uk-margin-small-top">
    <a uk-toggle="target: #charts_area; animation: uk-animation-fade, uk-animation-fade" class = "uk-text-secondary uk-text-large uk-text"type="button">Resumo<span uk-icon="icon: triangle-down"></span></a>
    <div class="uk-grid-large uk-grid-match uk-child-width-expand@s uk-text-center" hidden="" id="charts_area" uk-grid>
      <div>
          <div class="uk-card uk-card-default uk-card-body"><?php include("../charts/chart_medicos_prestadores_vs_funcionarios.php") ?></div>
      </div>
      <div>
        <div class="uk-card uk-card-default uk-card-body">
          <?php
              $sql = 'call dados_das_especialidades_quant_medicos_maximo(@a, @b, @c, @d)';
              $nomeprint = "";
              $nomeprint2 = "";
              $nomeprint3 = "";
              $nomeprint4 = "";
              $nomeprint5 = "";
              foreach ($dbl->query($sql) as $row) {
                $nome   = $row['nome'];
                $nomeprint .="[".$nome."]";
              }
              $sql = 'call dados_das_especialidades_quant_medicos_minimo(@a, @b, @c, @d)';
              foreach ($dbl->query($sql) as $row) {
                $nome   = $row['nome'];
                $nomeprint2 .= "[".$nome."]";
              }
              $sql = 'call dados_das_especialidades_valores_arrecadados_maximo(@a, @b, @c, @d)';
              foreach ($dbl->query($sql) as $row) {
                $nome   = $row['nome'];
                $nomeprint3 .= "[".$nome."]";
              }
              $sql = 'call dados_das_especialidades_valores_arrecadados_minimo(@a, @b, @c, @d)';
              foreach ($dbl->query($sql) as $row) {
                $nome   = $row['nome'];
                $nomeprint4 .= "[".$nome."]";
              }
              $sql = 'call dados_medicos_vs_quant_pacientes_maximo(@a, @b, @c, @d)';
              foreach ($dbl->query($sql) as $row) {
                $nome   = $row['nome'];
                $nomeprint5 .= "[".$nome."]";
              }
           ?>
           <p class="uk-text-bold uk-margin-small">Médico que mais atendeu:</p>
           <p class="uk-margin-small"><?php echo $nomeprint5; ?></p>
           <p class="uk-text-bold uk-margin-small">Especialidade que mais atende:</p>
           <p class="uk-margin-small"><?php echo $nomeprint; ?></p>
           <p class="uk-text-bold uk-margin-small">Especialidade que menos atende:</p>
           <p class="uk-margin-small"><?php  echo $nomeprint2?></p>
           <p class="uk-text-bold uk-margin-small">Especialidade que mais arrecadou:</p>
           <p class="uk-margin-small"><?php  echo $nomeprint3?></p>
           <p class="uk-text-bold uk-margin-small">Especialidade que menos arrecadou:</p>
           <p class="uk-margin-small"><?php  echo $nomeprint4?></p>
        </div>
      </div>
    </div>
</div>
