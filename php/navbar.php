<nav class="uk-navbar custom_blue_bg " uk-navbar="mode: click">
  <div class="uk-navbar-center uk-container-expand">
      <div class="uk-navbar-center-left">
        <div>
          <ul class="uk-navbar-nav">
            <li><a class="custom_white" href="../index.php">Home</a></li>
            <li><a class="custom_white <?php $navType = ($type=="clientes") ? "uk-text-bold custom_disabled" : "" ; echo $navType; ?>" href="list.php?type=clientes">Clientes</a></li>
            <li><a class="custom_white <?php $navType = ($type=="medicos") ? "uk-text-bold custom_disabled" : "" ; echo $navType; ?>" href="list.php?type=medicos">Médicos</a></li>
          </ul>
        </div>
      </div>
      <a href="../index.php" class="uk-navbar-item uk-logo">
        <img src="../img/logo.png" width="50px"alt="logo">
      </a>
      <div class="uk-navbar-center-right">
        <div>
          <ul class="uk-navbar-nav">
            <li><a class="custom_white <?php $navType = ($type=="atendimentos") ? "uk-text-bold custom_disabled" : "" ; echo $navType; ?>" href="list.php?type=atendimentos">Atendimento</a></li>
            <li><a class="custom_white <?php $navType = ($type=="planos") ? "uk-text-bold custom_disabled" : "" ; echo $navType; ?>" href="list.php?type=planos">Planos de Saúde</a></li>
          </ul>
        </div>
      </div>
    </div>
</nav>
