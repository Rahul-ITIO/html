<?php if($data['themeName']!='LeftPanel'){ ?>
<style> 
.phide .menu_title { display:none !important;}
.header_menu_link li i { display: inline !important;}

</style>
<? }?>
<li class="dropdown phide" id="payout_button">
	  
	    <a class="btn btn-primary dropdown-toggle55 border  header_menu_link px-2 mx-1"  data-bs-toggle="dropdown"> <i class="<?=$payouticon;?> fa-fw" aria-hidden="true" title="<?=ucwords($payouttitle);?>" ></i><span class="text-hide-mobile"> <span class="menu_title"><?=ucwords($payouttitle);?></span></span>

		
        </a>
        <ul class="dropdown-display dropdown-menu dropdown_from_top" style="width:190px;position: absolute !important;inset: 0px auto auto 0px !important;">
         
          <li> <a class="dropdown-item" href="<?=$data['Members']?>/dashboard<?=$data['ex']?>" ><i class="<?=$payouticon2;?> text-primary fa-fw"></i> Payment Gateway</a> </li>
        <li> <a class="dropdown-item" href="<?=$data['Members']?>/summary<?=$data['ex']?>?act=1"><i class="<?=$payouticon1;?> text-primary fa-fw"></i> Payout Gateway</a> </li>
          
        </ul>
		
      </li>