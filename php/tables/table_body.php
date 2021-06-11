

    <tbody>
      <?php

      switch ($type) {
        case "Clientes":
          echo "<tr >
                  <th>Nome</th>
                  <th>Telefone</th>
                  <th>CPF</th>
                  <th>E-mail</th>
                  <th>Detalhes</th>
                </tr>";
          break;
        case "medicos":
          echo "<tr>
                  <th>Nome</th>
                  <th>Especialização</th>
                  <th>Cadastro</th>
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
                  <th>Cadastro</th>
                  <th>Tier</th>
                  <th>Detalhes</th>
                </tr>";
          break;
        case "funcionarios":
          echo "<tr >
                  <th>Nome</th>
                  <th>Cadastro</th>
                  <th>Tier</th>
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
          $sql = 'select horario = "10:20:10", nome="pedro", medico="lucas", tipo_atendimento="pediatria", telefone="(31) 99999-8888";';
          foreach ($dbl->query($sql) as $row) {
            $horario = $row['horario'];
            $nome = $row['nome'];
            $medico = $row['medico'];
            $tipo_atendimento = $row['tipo_atendimento'];
            $telefone = $row['telefone'];
            $id_atendimento = $row['id_atendimento'];

            echo '<tr >
              <td>'.$horario.'</td>
              <td>'.$nome.'</td>
              <td>'.$medico.'</td>
              <td>'.$tipo_atendimento.'</td>
              <td>'.$telefone.'</td>
              <td><a href="php/describe.php?id='.$id_atendimento.'">Clique Aqui</a></td>
            </tr>';
          }
          break;
        }
        $sql = '';
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
