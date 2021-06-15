<div class="uk-container uk-container-small uk-flex uk-flex-between">
  <?php include("insertbutton.php") ?>
  <?php
    if ($type == "medicos") {
   ?>
  <div class="">
      <form id="medtype" class="" action="" method="get">
          <label><input type="checkbox" name="medtype" value="1">Apenas prestadores de serviço</label>
          <button type="submit" class="uk-button uk-button-primary">Atualizar</button>
          <input type="hidden" name="type"   value="<?php echo $type; ?>">
          <input type="hidden" name="search" value="<?php echo $search; ?>">
      </form>
  </div>
  <?php
      }
   ?>
  <div class="uk-margin-small-top">
    <form id="search_form"class="uk-search uk-search-default" action="" method="get">
        <a href="javascript:{}" onclick="document.getElementById('search_form').submit();" class="uk-search-icon-flip" uk-search-icon></a>
        <input type="hidden" name="type" value="<?php echo $type; ?>">
        <input name="search" class="uk-search-input" type="search" placeholder="Buscar">
    </form>
    <?php if ($search != "") {?>
    <form id="search_form" class="" action="" method="get">
        <button type="submit" class="uk-button uk-width-small uk-button-primary">Voltar</button>
        <input type="hidden" name="type" value="<?php echo $type; ?>">
    </form>
    <?php } ?>
</div>
</div>
