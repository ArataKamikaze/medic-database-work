<div class="uk-margin-small-top uk-align-left">
  <?php
    if ($type != "medicos" && $type != "funcionarios" && $type != "planos" && $type != "tratamentos") {
      ?>
      <form class="" action="insert.php" method="get">
          <button type="submit" class="uk-button uk-button-default uk-button-primary"><?php $retVal = ($type == "atendimentos" || $type == "tratamentos") ? "Agendar" : "Cadastrar" ; echo $retVal ?> <?php echo $type; ?></button>
          <input type="hidden" name="type" value="<?php echo $type; ?>">
      </form>
      <?php
    }
   ?>
</div>
