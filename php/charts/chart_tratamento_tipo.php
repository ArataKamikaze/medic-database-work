<canvas id="grafico_tratamento_tipo" width="300" height="200"></canvas>
<?php
      $sql = 'call hospital.obter_dados_tratamentos_quantidades();';

?>
    <script type='text/javascript'>
      var ctx = document.getElementById('grafico_tratamento_tipo').getContext('2d');
      var grafico_clientes_estado_civil = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: [
                      <?php
                          foreach ($dbl->query($sql) as $row) {
                            $nome = $row['nome'];
                            echo "'".$nome."', ";
                          }
                      ?>
                    ],
            datasets: [{
                label: 'Tipos de tratamento',
                data: [
                        <?php
                            foreach ($dbl->query($sql) as $row) {
                              $quant = $row['quant'];
                              echo "'".$quant."', ";
                            }
                        ?>
                      ],
                backgroundColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                ],
                borderWidth: 1
            }]
        },
        options:{
            plugins:{
                title:{
                    display: true,
                    text: 'Distribuição de tipos de tratamento',
                    position: 'top',
                    font: {
                        size: 20,
                    }
                }
            }
        }

    });
    grafico_clientes_estado_civil.options.plugins.legend.position = 'bottom';
    grafico_clientes_estado_civil.update();
    grafico_clientes_estado_civil.options.plugins.legend.labels.boxWidth = 20;
    grafico_clientes_estado_civil.update();
    </script>
