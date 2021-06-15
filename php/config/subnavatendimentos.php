<nav class="uk-navbar-container" uk-navbar>
    <div class="uk-navbar-center">
        <ul class="uk-navbar-nav">
          <li><a class=" <?php $navType = ($type=="clientes") ? "uk-text-bold custom_disabled" : "" ; echo $navType; ?>" href="../pages/list.php?type=clientes">Realizados</a></li>
          <li><a class=" <?php $navType = ($type=="medicos") ? "uk-text-bold custom_disabled" : "" ; echo $navType; ?>" href="../pages/list.php?type=medicos">Agendados</a></li>
          <li><a class=" <?php $navType = ($type=="funcionarios") ? "uk-text-bold custom_disabled" : "" ; echo $navType; ?>" href="../pages/list.php?type=funcionarios">Novos</a></li>
        </ul>
    </div>
</nav>
