<div class="uk-container uk-container-small">
  <label for="table1">Consultas próximas:</label>
</div>
<div id="table1" class="uk-container uk-container-small custom_border custom_rounded_top uk-margin-small-top">
  <table class="uk-table uk-table-small uk-table-middle">
    <thead>
      <tr >
        <th>Clientes</th>
        <th>Médico</th>
        <th>Data/Hora</th>
        <th>Plano de Saúde</th>
        <th>Detalhes</th>
      </tr>
    </thead>
    <tbody>
      <?php
        $sql = 'select consulta.idconsulta, cliente.nome, cliente.plano_de_saude, data, tratamento, medico.nome as nome_medico, tipo from cliente left join consulta on(cliente.idcliente = consulta.idcliente) left join medico on(consulta.idmedico = medico.idmedico)';
        foreach ($dbl->query($sql) as $row) {
          $nome = $row['nome'];
          $plano_de_saude = $row['plano_de_saude'];
          $data = $row['data'];
          $tratamento = $row['tratamento'];
          $nome_medico = $row['nome_medico'];
          $id_consulta = $row['idconsulta'];

          echo '<tr >
            <td>'.$nome.'</td>
            <td>'.$nome_medico.'</td>
            <td>'.$data.'</td>
            <td>'.$plano_de_saude.'</td>
            <td><a href="php/descricao.php?id='.$id_consulta.'">Clique Aqui</a></td>
          </tr>';
        }
       ?>
    </tbody>
  </table>
</div>
<div class="uk-container
            uk-container-small
            custom_blue_bg
            custom_rounded_bottom
            custom_white
            uk-align-center
            uk-margin-remove-top
            uk-margin-remove-bottom
            custom_padding_5">
  <p class="uk-text-center">Mais Informações</p>
</div>


<div class="uk-container uk-container-small uk-margin-small-top">
  <label for="table2">Clientes com tratamento crônico, que possuem agendamento pendente:</label>
</div>


<div id="table2" class="uk-container uk-container-small custom_border custom_rounded_top uk-margin-small-top">
  <table class="uk-table uk-table-small uk-table-middle">
    <thead>
      <tr >
        <th>Clientes</th>
        <th>Tratamento</th>
        <th>Plano de Saúde</th>
        <th>Detalhes</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Pedro</td>
        <td>Luana</td>
        <td>saude+</td>
        <td>Clique aqui</td>
      </tr>
      <tr>
        <td>Pedro</td>
        <td>Luana</td>
        <td>saude+</td>
        <td>Clique aqui</td>
      </tr>
      <tr>
        <td>Pedro</td>
        <td>Luana</td>
        <td>saude+</td>
        <td>Clique aqui</td>
      </tr>
    </tbody>
  </table>
</div>
<div class="uk-container
            uk-container-small
            custom_blue_bg
            custom_rounded_bottom
            custom_white
            uk-align-center
            uk-margin-remove-top
            uk-margin-remove-bottom
            custom_padding_5">
  <p class="uk-text-center">Mais Informações</p>
</div>
