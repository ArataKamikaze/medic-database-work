<nav class="uk-navbar-container" uk-navbar>
    <div class="uk-navbar-center">
        <ul class="uk-navbar-nav">
          <li><a class=" <?php $navType = ($subtype=="realizados") ? "uk-text-bold custom_disabled" : "" ; echo $navType; ?>" href="../pages/list.php?type=atendimentos&subtypes=realizados">Realizados</a></li>
          <li><a class=" <?php $navType = ($subtype=="agendados") ? "uk-text-bold custom_disabled" : "" ; echo $navType; ?>" href="../pages/list.php?type=atendimentos&subtype=agendados">Agendados</a></li>
        </ul>
    </div>
</nav>
