    <tbody>
      <?php
      switch ($type) {
        default:
        $sql = 'call tratamentos_cronicos_proximos_de_estourar(0);';
        foreach ($dbl->query($sql) as $row) {
          $nome = $row['nome_do_cliente'];
          $telefone = $row['numero_do_telefone'];
          $tipo_atendimento = $row['tipo_de_tratamento'];
          $id_atendimento = $row['tratamento_id'];

          echo '<tr >
            <td>'.$nome.'</td>
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
