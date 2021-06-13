<div id="table1" class="
                    uk-container
                    uk-container-small
                    uk-margin-small-top
                    uk-animation-fade
                    custom_border
                    custom_rounded_top ">
  <table class="uk-table uk-table-small uk-table-middle ">
    <thead>
      <?php
        switch ($type) {
          default:
            echo "<tr >
                    <th>Cliente</th>
                    <th>Tipo do atendimento</th>
                    <th>Telefone</th>
                    <th>Detalhes</th>
                  </tr>";
            break;
        }
       ?>

    </thead>
