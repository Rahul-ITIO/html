<??><style>.ice1-show{display:none !important;}.ice2-show{display:none !important;}</style>
<?
//echo $data['frontUiName'];
if(isset($data['frontUiName'])&&in_array($data['frontUiName'],array("ice2","sys"))){
	$class_a_1='text-primary-menu text-white';
	if($data['frontUiName']	=="ice2"){ ?><style>.ice2-show{display:block !important;}</style><? } 
}
elseif(isset($data['frontUiName'])&&in_array($data['frontUiName'],array("ice1"))){
	$class_a_1='text-primary-menu';	
	?><style>.ice1-show{display:block !important;}</style><?
}

elseif(isset($data['frontUiName'])&&in_array($data['frontUiName'],array("quartz"))){
	if($data['themeName']=='LeftPanel') $class_a_1='text-primary';	
	else $class_a_1='text-white';	
}
else{
	$class_a_1=' text-white ';	
}

?>

<?
/*$payout_folder=($data['Path']."/front_ui/{$data['frontUiName']}/common/template.merchant_payout_button".$data['iex']);
	if(file_exists($payout_button)){
		include($payout_button);
		
		}*/
?>


<? if((isset($data['PAYOUT_GATEWAY_DB'])&&$data['PAYOUT_GATEWAY_DB'])&&((isset($post['payout_request'])&&$post['payout_request']!=3) &&(((in_array(20, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')))){ ?>
	
	<li class="nav-item dropdown "> <a class="nav-link text-decoration-none <?=$class_a_1?> payout_active_id" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false" title="Payout"> <i class="fas fa-money-check-alt fa-fw"></i> <span class="menu_title">Payout</span> </a>
   
    <ul class="dropdown-menu ms-1 bg-vlight" aria-labelledby="navbarDropdown" style="width: 130px;">
	<? if(((in_array(17, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
      <li><a  class="dropdown-item" href="<?=$data['USER_FOLDER']?>/summary<?=$data['ex']?>" title="Summary"><i class="fa-solid fa-rectangle-list fa-fw"></i>&nbsp;&nbsp;&nbsp;Summary</a></li>
      <? } ?>

	  <? if(((in_array(23, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
      <li><a  class="dropdown-item" href="<?=$data['USER_FOLDER']?>/beneficiaries<?=$data['ex']?>" title="Beneficiaries"><i class="fa-solid fa-user-group fa-fw"></i>&nbsp;&nbsp;&nbsp;Beneficiaries</a></li>
      <? } ?>
	  
	  <? if(((in_array(20, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
      <li><a  class="dropdown-item" href="<?=$data['USER_FOLDER']?>/transfers<?=$data['ex']?>" title="Transfers"><i class="fa-solid fa-arrow-right-arrow-left fa-fw"></i>&nbsp;&nbsp;&nbsp;Transfers</a></li>
      <? } ?>
      
      <? if(((in_array(19, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
      <li><a  class="dropdown-item" href="<?=$data['USER_FOLDER']?>/fund-sources<?=$data['ex']?>" title="Fund Sources"><i class="fa-solid fa-indian-rupee-sign fa-fw"></i>&nbsp;&nbsp;&nbsp;Fund Sources</a></li>
      <? } ?>
      <? if(((in_array(21, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
      <li><a  class="dropdown-item" href="<?=$data['USER_FOLDER']?>/statements<?=$data['ex']?>" title="Statement"><i class="fa-solid fa-file-lines fa-fw"></i>&nbsp;&nbsp;&nbsp;Statement</a></li>
      <? } ?>
      
      <? if(((in_array(22, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
      <li><a class="dropdown-item" href="<?=$data['USER_FOLDER']?>/payout-keys<?=$data['ex']?>" title="Api Keys"><i class="fa-solid fa-gear fa-fw"></i>&nbsp;&nbsp;&nbsp;Api Keys</a></li>
      <? } ?>
	  <li><a class="dropdown-item" href="<?=$data['Host']?>/payout/payoutapi.pdf" target="_blank" title="Developer API"><i class="fa-solid fa-file-pdf fa-fw"></i>&nbsp;&nbsp;&nbsp;Developer API</a></li>
    </ul>
	
 <? }else{ ?>
 
 <li><a class="text-primary-menu text-decoration-none text-white" href="<?=$data['USER_FOLDER']?>/payout-coming-soon<?=$data['ex']?>" title="Payout"><i class="fas fa-money-check-alt fa-fw"></i><span class="menu_title" title="Payout">&nbsp;<span class="menu_title">Payout <v class="badge rounded-pill bg-danger fa-beat-fade ">New</v></span></span></a></li>
 
 <? } ?>
 
 

 
  <? if((isset($data['QRCODE_GATEWAY_DB'])&&$data['QRCODE_GATEWAY_DB'])&&((isset($post['qrcode_gateway_request'])&&$post['qrcode_gateway_request']!=3) &&(((in_array(20, $grole)) && ($_SESSION['m_clients_type']=='Sub Member'))  || ($_SESSION['m_clients_type']=='')))){ ?>
	
	
	<li class="nav-item dropdown"> <a class="nav-link text-decoration-none <?=$class_a_1?> qr_active_id" href="#" id="navbarDropdown5" role="button" data-bs-toggle="dropdown" aria-expanded="false" title="<?=$data['SOFT_POS_LABELS']?>"> <i class="fa-solid fa-qrcode fa-fw"></i> <span class="menu_title"><?=$data['SOFT_POS_LABELS']?></span></a>
   
    <ul class="dropdown-menu ms-1 bg-vlight" aria-labelledby="navbarDropdown5" style="width: 130px;">
	
	<li><a class="dropdown-item" href="<?=$data['USER_FOLDER']?>/qr-dashboard<?=$data['ex']?>" title="QR Dashboard"><i class="fas fa-home fa-fw"></i>&nbsp;&nbsp;&nbsp;Dashboard</a></li>

	<li><a class="dropdown-item" href="<?=$data['USER_FOLDER']?>/qr-code<?=$data['ex']?>" title="QR Code"><i class="fa-solid fa-qrcode fa-fw"></i>&nbsp;&nbsp;&nbsp;QR Code</a></li>

	<li><a class="dropdown-item" href="<?=$data['USER_FOLDER']?>/qr-transactions<?=$data['ex']?>" title="QR Transactions"><i class="fa-solid fa-file-lines fa-fw"></i>&nbsp;&nbsp;&nbsp;Transactions</a></li>
    </ul>
	
 <? } ?>
 
 	 <script>
	 $(".qr_active_id").click(function(){	
	 $("a").removeClass("active_a");
	 $(".qr_active_id").addClass("active_a");
	 });
	 
	 $(".payout_active_id").click(function(){	
	 $("a").removeClass("active_a");
	 $(".payout_active_id").addClass("active_a");
	 });
 	 </script>