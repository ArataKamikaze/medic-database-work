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
          case "clientes":
            echo "<tr >
                    <th>Nome</th>
                    <th>Idade</th>
                    <th>Sexo</th>
                    <th>Telefone</th>
                    <th>Detalhes</th>
                  </tr>";
            break;
          case "medicos":
            echo "<tr>
                    <th>Nome</th>
                    <th>Idade</th>
                    <th>CRM</th>
                    <th>Sexo</th>
                    <th>Telefone</th>
                    <th>Detalhes</th>
                  </tr>";
            break;
          case "atendimentos":
            echo "<tr >
                    <th>Cliente</th>
                    <th>Médico</th>
                    <th>Data/Hora</th>
                    <th>Plano de Saúde</th>
                    <th>Detalhes</th>
                  </tr>";
            break;
          case "planos":
            echo "<tr >
                    <th>Nome</th>
                    <th>Detalhes</th>
                  </tr>";
            break;
          case "funcionarios":
            echo "<tr >
                    <th>Nome</th>
                    <th>Cargo</th>
                    <th>Data de Admissão</th>
                    <th>sexo</th>
                    <th>Detalhes</th>
                  </tr>";
            break;
          case "tratamentos":
            echo "<tr >
                    <th>Nome</th>
                    <th>Cadastro</th>
                    <th>Tier</th>
                    <th>Detalhes</th>
                  </tr>";
            break;
          default:
            echo "<tr >
                    <th>Horário</th>
                    <th>Nome</th>
                    <th>Médico</th>
                    <th>Tipo do atendimento</th>
                    <th>Telefone</th>
                    <th>Detalhes</th>
                  </tr>";
            break;
        }
       ?>

    </thead>
