<div class="uk-container uk-container-small uk-margin-small-top">
    <a uk-toggle="target: #charts_area; animation: uk-animation-fade, uk-animation-fade" class = "uk-text-secondary uk-text-large uk-text"type="button">Resumo<span uk-icon="icon: triangle-down"></span></a>
    <div class="uk-grid-small uk-grid-match uk-child-width-expand@s uk-text-center" hidden="" id="charts_area" uk-grid>
      <div>
          <div class="uk-card uk-card-default uk-card-body"><?php include("../charts/chart_tratamento_cronicos.php") ?></div>
      </div>
      <div>
          <div class="uk-card uk-card-default uk-card-body">
            <img src="https://s2.glbimg.com/_JdtjUvVM5XV7IOXLOTrjE-BS1o=/top/i.glbimg.com/og/ig/infoglobo1/f/original/2018/02/20/2018-02-19-photo-00000502.jpg" alt="cachorrineo">
          </div>
      </div>
    </div>
    <div class="uk-grid-small uk-grid-match uk-child-width-expand@s uk-text-center" hidden="" id="charts_area" uk-grid>
      <div>
          <div class="uk-card uk-card-default uk-card-body"><?php include("../charts/chart_tratamento_tipo.php") ?></div>
      </div>
    </div>
</div>
