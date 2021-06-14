<canvas id="grafico_medicos_prestadores_vs_funcionarios" width="300" height="300"></canvas>
<?php
      $sql  = 'call medicos_funcionarios_vs_prestadores();';
?>
<script type='text/javascript'>
  var ctx = document.getElementById('grafico_medicos_prestadores_vs_funcionarios').getContext('2d');
  var grafico_clientes_estado_civil = new Chart(ctx, {
    type: 'pie',
    data: {
        labels: ['funcionarios', 'prestadores'],
        datasets: [{
            label: 'Estado civil dos clientes',
            data: [
                <?php
                     foreach ($dbl->query($sql) as $row) {
                         $funcionarios = $row['funcionarios'];
                         $prestadores = $row['prestadores'];
                         echo "'".$funcionarios."', '".$prestadores."'";
                     }
                ?>
            ],
            backgroundColor: [
                'rgba(255, 206, 86, 1)',
                'rgba(6, 96, 148, 1)',
            ],
            borderColor: [
                'rgba(255, 205, 1, 1)',
                'rgba(2, 46, 71, 1)',
            ],
            borderWidth: 1
        }]
    },
    options:{
        plugins:{
            title:{
                display: true,
                text: 'Médicos prestadores de serviço vs médicos funcionários',
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
