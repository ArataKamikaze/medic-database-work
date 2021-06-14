    <tbody>
      <?php
      switch ($type) {
        case "clientes":
            $sql = 'call  lista_de_clientes('.($page-1).', "'.$search.'");';
            foreach ($dbl->query($sql) as $row) {
              $nome = $row['nome'];
              $idade = $row['idade'];
              $sexo = $row['sexo'];
              $telefone = $row['numero_do_telefone'];
              $cpf = $row['cpf'];

              echo '<tr >
                <td>'.$nome.'</td>
                <td>'.$idade.'</td>
                <td>'.$sexo.'</td>
                <td>'.$telefone.'</td>
                <td><a href="detail.php?type='.$type.'&id='.$cpf.'">Clique Aqui</a></td>
              </tr>';
            }
            break;
        case "medicos":
            $sql = 'call  lista_de_medicos('.$page.', "'.$search.'");';
            foreach ($dbl->query($sql) as $row) {
              $nome = $row['nome'];
              $idade = $row['idade'];
              $crm = $row['crm'];
              $sexo = $row['sexo'];
              $telefone = $row['numero_do_telefone'];
              echo '<tr >
                <td>'.$nome.'</td>
                <td>'.$idade.'</td>
                <td>'.$crm.'</td>
                <td>'.$sexo.'</td>
                <td>'.$telefone.'</td>
                <td><a href="detail.php?type='.$type.'&id='.$crm.'">Clique Aqui</a></td>
              </tr>';
            }
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
            $sql = 'call lista_de_planos('.$page.', "'.$search.'");';
            foreach ($dbl->query($sql) as $row) {
              $nome = $row['nome'];
              $id = $row['plano_de_saude_id'];
              echo '<tr >
                <td>'.$nome.'</td>
                <td><a href="detail.php?id='.$id.'">Clique Aqui</a></td>
              </tr>';
            }
            break;
        case "funcionarios":
            $sql = 'call lista_de_funcionario('.$page.', "'.$search.'");';
            foreach ($dbl->query($sql) as $row) {
              $nome = $row['nome'];
              $admissao = $row['data_de_adminissao'];
              $cargo = $row['cargo'];
              $sexo = $row['sexo'];
              $telefone = $row['numero_do_telefone'];
              $cpf = $row['cpf'];
              echo '<tr >
                <td>'.$nome.'</td>
                <td>'.$cargo.'</td>
                <td>'.$admissao.'</td>
                <td>'.$sexo.'</td>
                <td>'.$telefone.'</td>
                <td><a href="detail.php?type='.$type.'&id='.$cpf.'">Clique Aqui</a></td>
              </tr>';
            }
            break;
        case "tratamentos":
            $sql = 'call lista_de_tratamentos('.$page.',"'.$search.'")';
            foreach ($dbl->query($sql) as $row) {
              $nome = $row['cliente_nome'];
              $quant = $row['quant_de_atendimentos'];
              $tipo_atendimento = $row['tipo_de_tratamento'];
              $id_tratamento = $row['tratamento_id'];

              echo '<tr >
                <td>'.$tipo_atendimento.'</td>
                <td>'.$nome.'</td>
                <td>'.$quant.'</td>
                <td><a href="detail.php?type='.$type.'&id='.$id_tratamento.'">Clique Aqui</a></td>
              </tr>';
            }
            break;
        default:
            $sql = 'call atendimentos_proximos(0);';
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
                <td><a href="detail.php?type='.$type.'&id='.$id_atendimento.'">Clique Aqui</a></td>
              </tr>';
            }
              break;
            }
       ?>
    </tbody>
  </table>
</div>
