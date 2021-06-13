<div class="uk-container uk-container-small uk-margin-small-top">
    <a uk-toggle="target: #charts_area; animation: uk-animation-fade, uk-animation-fade" class = "uk-text-secondary uk-text-large uk-text"type="button">Resumo<span uk-icon="icon: triangle-down"></span></a>
    <div class="uk-grid-large uk-child-width-expand@s uk-text-center" hidden="" id="charts_area" uk-grid>
      <div>
          <div class="uk-card uk-card-default uk-card-body"><?php include("../charts/chart_client_estado_civil.php") ?></div>
      </div>
      <div>
          <div class="uk-card uk-card-default uk-card-body"><?php include("../charts/chart_client_histogram .php") ?></div>
      </div>
    </div>
</div>
