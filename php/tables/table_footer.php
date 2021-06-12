<?php
  $size = 500;
  $pages = intdiv($size,10);
  $page = 0;
  if(isset($_GET['page'])){
        $page=$_GET['page'];
  }


 ?>


<div class="uk-container uk-container-small custom_blue_bg custom_rounded_bottom custom_white uk-align-center uk-margin-remove-top uk-margin-remove-bottom custom_padding_5 uk-animation-fade">
  <?php if ($type == "") {?>
      <p class="uk-text-center ">Mais Informações</p>
  <?php } else {?>
      <ul class="uk-pagination uk-flex-center custom_white" uk-margin>
          <li><a class="custom_white" href="#"><span uk-pagination-previous></span></a></li>
          <li><a class="custom_white" href="#">1</a></li>
          <li class="uk-disabled"><span>...</span></li>
          <li><a class="custom_white" href="#">4</a></li>
          <li><a class="custom_white" href="#">5</a></li>
          <li><a class="custom_white" href="#">6</a></li>
          <li class="uk-active"><span>7</span></li>
          <li><a class="custom_white" href="#">8</a></li>
          <li><a class="custom_white" href="#">9</a></li>
          <li><a class="custom_white" href="#">10</a></li>
          <li class="uk-disabled"><span>...</span></li>
          <li><a class="custom_white" href="#">20</a></li>
          <li><a class="custom_white" href="#"><span uk-pagination-next></span></a></li>
      </ul>
  <?php }?>
</div>
