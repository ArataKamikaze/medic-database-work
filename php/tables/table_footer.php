


<div class="uk-container uk-container-small custom_blue_bg custom_rounded_bottom custom_white uk-align-center uk-margin-remove-top uk-margin-remove-bottom custom_padding_5 uk-animation-fade">
  <?php if ($type == "") {?>
      <p class="uk-text-center ">Mais Informações</p>
  <?php } else {?>
      <ul class="uk-pagination uk-flex-center custom_white" uk-margin>
          <li><a class="custom_white" href="list.php?page=<?php echo $type; ?>&page=<?php $prevPage = ($page-1 >= 1) ? $page-1 : $page ;echo $prevPage; ?>"><span uk-pagination-previous></span></a></li>
          <?php
          if ($pages >= 11) {
              if ($page <= 6) {
                  for ($i=1; $i < 10; $i++) {
                      $thisPage = ($page == $i) ? "uk-text-bold uk-text-baseline" : "" ;
                      echo '<li><a class="custom_white '.$thisPage.'" href="list.php?type='.$type.'&search='.$search.'&page='.$i.'">'.$i.'</a></li>';
                  }
                  echo '<li class="uk-disabled"><span>...</span></li>';
                  echo '<li><a class="custom_white" href="list.php?type='.$type.'&search='.$search.'&page='.$pages.'">'.$pages.'</a></li>';
              } else if ($page >= $pages - 5) {
                  echo '<li><a class="custom_white" href="list.php?type='.$type.'&search='.$search.'&page=1">1</a></li>';
                  echo '<li class="uk-disabled"><span>...</span></li>';
                  for ($i=8; $i >= 0; $i--) {
                      $thisPage = ($page == $pages-$i) ? "uk-text-bold" : "" ;
                      echo '<li><a class="custom_white '.$thisPage.'" href="list.php?type='.$type.'&search='.$search.'&page='.($pages-$i).'">'.($pages-$i).'</a></li>';
                  }
              }
              else{
                echo '<li><a class="custom_white" href="list.php?type='.$type.'&search='.$search.'&page=1">1</a></li>';
                echo '<li class="uk-disabled"><span>...</span></li>';
                for ($i=-3; $i < 4; $i++) {
                    $thisPage = ($page == $pages+$i) ? "uk-text-bold" : "" ;
                    echo '<li><a class="custom_white '.$thisPage.'" href="list.php?type='.$type.'&search='.$search.'&page='.($page+$i).'">'.($page+$i).'</a></li>';
                }
                echo '<li class="uk-disabled"><span>...</span></li>';
                echo '<li><a class="custom_white" href="list.php?type='.$type.'&search='.$search.'&page='.$pages.'">'.$pages.'</a></li>';
              }
          }
          else{
              for ($i=1; $i <= $pages; $i++) {
                  $thisPage = ($page == $i) ? "uk-text-bold" : "" ;

                  echo '<li><a class="custom_white '.$thisPage.'" href="list.php?type='.$type.'&search='.$search.'&page='.$i.'">'.$i.'</a></li>';
              }
          }

           ?>
        <li><a class="custom_white" href="list.php?page=<?php echo $type; ?>&page=<?php $nextPage = ($page+1 <= $pages) ? $page+1 : $page ;echo $nextPage; ?>"><span uk-pagination-next></span></a></li>

      </ul>
  <?php }?>
</div>
