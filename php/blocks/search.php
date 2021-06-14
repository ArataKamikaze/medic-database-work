<div class="uk-container uk-container-small uk-flex uk-flex-between">
  <div class="uk-margin-small-top uk-align-left">
    <?php
      if ($type != "medicos" && $type != "funcionarios") {
        ?>
        <form class="" action="insert.php" method="get">
            <button type="submit" class="uk-button uk-button-default uk-button-primary"><?php $retVal = ($type == "atendimentos" || $type == "tratamentos") ? "Agendar" : "Cadastrar" ; echo $retVal ?> <?php echo $type; ?></button>
            <input type="hidden" name="type" value="<?php echo $type; ?>">
        </form>
        <?php
      }

     ?>
  </div>
  <div class="uk-margin-small-top">
    <form id="search_form"class="uk-search uk-search-default" action="" method="get">
        <a href="javascript:{}" onclick="document.getElementById('search_form').submit();" class="uk-search-icon-flip" uk-search-icon></a>
        <input type="hidden" name="type" value="<?php echo $type; ?>">
        <input name="search" class="uk-search-input" type="search" placeholder="Buscar">
    </form>
    <?php if ($search != "") {?>
    <form id="search_form"class="" action="" method="get">
        <button type="submit" class="uk-button uk-width-small uk-button-primary">Voltar</button>
        <input type="hidden" name="type" value="<?php echo $type; ?>">
    </form>
    <?php } ?>
</div>
</div>
