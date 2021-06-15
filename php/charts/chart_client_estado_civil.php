<canvas id="grafico_clientes_estado_civil" width="300" height="200"></canvas>
<?php
      $sql = 'select estado_civil, count(*) as contagem from (select * from pessoa join cliente using(CPF)) as A group by estado_civil;';
      $i = 0;
      foreach ($dbl->query($sql) as $row) {
        $estado_civil[$i] = $row['contagem'];
        $i+=1;
      }
    echo "
    <script type='text/javascript'>
      var ctx = document.getElementById('grafico_clientes_estado_civil').getContext('2d');
      var grafico_clientes_estado_civil = new Chart(ctx, {
        type: 'pie',
        data: {
            labels: ['Casado(a)', 'Divorciado(a)', 'Separado(a)', 'Solteiro(a)', 'Viuvo(a)'],
            datasets: [{
                label: 'Estado civil dos clientes',
                data: [".intval($estado_civil[4]).", ".intval($estado_civil[1]).", ".intval($estado_civil[2]).", ".intval($estado_civil[0]).", ".intval($estado_civil[3])."],
                backgroundColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)'
                ],
                borderWidth: 1
            }]
        },
        options:{
            pointRadius:0,
            plugins:{
                title:{
                    display: true,
                    text: 'Estado Civil',
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
    ";
   ?>
