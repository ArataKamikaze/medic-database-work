<?php
    $validcpf = "checking";
    if(isset($_GET['validcpf'])){
        $validcpf=$_GET['validcpf'];
    }
    $cpf = 0;
    if(isset($_GET['cpf'])){
        $cpf=$_GET['cpf'];
    }
 ?>
 <div id="my-id" class="uk-modal <?php $retVal = ($validcpf== "true") ? "" : "uk-open" ; echo $retVal?>" uk-modal="" style="<?php $retVal = ($validcpf == "true") ? "" : " display: block;" ; echo $retVal; ?>">
     <div class="uk-modal-dialog uk-modal-body">
       <div class="uk-container uk-container-small uk-flex uk-flex-center">
         <form id="search_form"class="uk-search uk-search-large" action="../config/checkcpf.php" method="get">
             <a href="javascript:{}" onclick="document.getElementById('search_form').submit();" class="uk-search-icon-flip" uk-search-icon></a>
             <input type="hidden" name="type" value="<?php echo $type; ?>">
             <input name="cpf" class="uk-search-input" type="number" placeholder="CPF">
         </form>
       </div>
       <?php
        if ($validcpf == "false") {
          echo '<div class="uk-alert-danger" uk-alert>
                   <a class="uk-alert-close" uk-close></a>
                   <p>Cpf ja cadastrado!</p>
                </div>';
          $validcpf = "checking";
        }

        ?>
     </div>
 </div>
