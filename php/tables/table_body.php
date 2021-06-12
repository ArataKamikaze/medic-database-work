

    <tbody>
      <?php

      switch ($type) {
        case "clientes":
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
        case "tratamentos":
            echo "<tr >
                    <th>Nome</th>
                    <th>Cadastro</th>
                    <th>Tier</th>
                    <th>Detalhes</th>
                  </tr>";
            break;
        default:
        $sql = 'call atendimentos_proximos();';
        foreach ($dbl->query($sql) as $row) {
          $horario = $row['horario_agendado'];
          $nome = $row['nome'];
          $medico = $row['nome_medico'];
          $tipo_atendimento = $row['tipo_de_atendimento'];
          $telefone = $row['numero_do_telefone'];
          $id_atendimento = $row['atendimento_id'];

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
       ?>
    </tbody>
  </table>
</div>
