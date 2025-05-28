<? if($data['themeName']!='LeftPanel'){ ?>
<style> 
.phide .menu_title { display:none !important;}
.header_menu_link li i { display: inline !important;}
</style>
<? }?>
<?
$payout_menu_link=$data['Path']."/payout/template.merchant_payout_link".$data['iex'];
$qr_code_menu_link=$data['Path']."/soft_pos/template.merchant_qr_code_link".$data['iex'];
//echo $domain_server['clients']['payout_request']; //Fetch From Header Global Variable 
//echo $domain_server['clients']['qrcode_gateway_request']; //Fetch From Header Global Variable 
?>

<? if(($domain_server['clients']['payout_request']==1) || ($domain_server['clients']['payout_request']==2) || ($domain_server['clients']['qrcode_gateway_request']==1)){ ?>


<li class="dropdown phide" id="payout_button">
	  
<a class="btn btn-primary dropdown-toggle55 border  header_menu_link px-2 mx-1 template_button menu-summary"  data-bs-toggle="dropdown"> <i class="<?=$payouticon;?> fa-fw" aria-hidden="true" title="<?=ucwords($payouttitle);?>" ></i><span class="text-hide-mobile"> <span class="menu_title"><?=ucwords($payouttitle);?></span></span></a>

        <ul class="dropdown-display dropdown-menu dropdown_from_top" style="width:190px;position: absolute !important;inset: 0px auto auto 0px !important;">
         
        <li> <a class="dropdown-item template_links menu-summary" href="<?=$data['USER_FOLDER']?>/dashboard<?=$data['ex']?>" ><i class="<?=$payouticon2;?> fa-fw dashboard"></i> Payment Gateway</a> </li>
		
		   <? if(file_exists($payout_menu_link)){ 
		   // for check clients payout request not inactive
		   if(($domain_server['clients']['payout_request']==1) || ($domain_server['clients']['payout_request']==2)){?>
        <li> <a class="dropdown-item template_links menu-summary" href="<?=$data['USER_FOLDER']?>/summary<?=$data['ex']?>?act=1"><i class="<?=$payouticon1;?> fa-fw"></i> Payout Gateway</a> </li>
		   <? 
		   } 
		   } 
		   ?>
		
		   <? if(file_exists($qr_code_menu_link)){ 
		   // for check clients QR request not inactive
		   if($domain_server['clients']['qrcode_gateway_request']==1){?>
		<li> <a class="dropdown-item template_links menu-summary" href="<?=$data['USER_FOLDER']?>/qr-dashboard<?=$data['ex']?>?act=1"><i class="<?=$payouticon3;?> fa-fw"></i> QR Gateway</a> </li>
          <? 
		   }
		   } 
		   ?> 
		
		
        </ul>
		
      </li>
	  
<? } ?>