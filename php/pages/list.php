
<?php
    include("../config/head.php");
    include("../config/db.php");
    include("../config/checktype.php");
    include("../config/checksearch.php");
    include("../config/checkpage.php");
    include("../config/bodytop.php");
    include("../config/navbar.php");
    include("../config/navigation.php");
    if ($type != "atendimentos") {
        include("../blocks/search.php");
        include("../tables/table.php");
    }
    else {
        ?>
          <div class="uk-container uk-container-small uk-flex uk-flex-between">
        <?php
            include("../blocks/insertbutton.php");
        ?>
        </div>
        <div class="uk-container uk-container-small">
          <?php
              include("../config/subnavatendimentos.php");
              include("../config/checkatendimento.php")
          ?>
        </div>
        <?php
    }
    include("../config/bodyend.php");
?>
