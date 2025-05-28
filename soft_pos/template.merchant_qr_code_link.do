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

<? if((isset($post['payout_request'])&&$post['payout_request']!=3)&& ($_SESSION['dashboard_type']=="") &&(((in_array(20, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']==''))){ ?>
	
	<li class="nav-item dropdown "> <a class="nav-link text-decoration-none <?=$class_a_1?> " href="<?=$data['USER_FOLDER']?>/qr-dashboard<?=$data['ex']?>?act=1" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false"  title="Payout"> <i class="fas fa-money-check-alt"></i> <span class="menu_title"><?=$data['SOFT_POS_LABELS']?></span> </a>
   
    <!--<ul class="dropdown-menu ms-1 bg-vlight" aria-labelledby="navbarDropdown" style="">
      <? if(((in_array(20, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
      <li><a  class="dropdown-item" href="<?=$data['USER_FOLDER']?>/payout-transaction<?=$data['ex']?>">&nbsp;&nbsp;<i class="fas fa-clipboard-list"></i>&nbsp; Payout Transaction</a></li>
      <? } ?>
	  <? if(((in_array(23, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
      <li><a  class="dropdown-item" href="<?=$data['USER_FOLDER']?>/beneficiary_list<?=$data['ex']?>">&nbsp;&nbsp;<i class="fas fa-clipboard-list"></i>&nbsp; Beneficiary List</a></li>
      <? } ?>
      <? if(((in_array(17, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
      <li><a  class="dropdown-item" href="<?=$data['USER_FOLDER']?>/addbeneficiary<?=$data['ex']?>">&nbsp;&nbsp;<i class="fas fa-clipboard-list"></i>&nbsp; Add Beneficiary</a></li>
      <? } ?>
      <? if(((in_array(19, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
      <li><a  class="dropdown-item" href="<?=$data['USER_FOLDER']?>/upload-fund<?=$data['ex']?>">&nbsp;&nbsp;<i class="fas fa-clipboard-list"></i>&nbsp; Upload Fund</a></li>
      <? } ?>
      <? if(((in_array(21, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
      <li><a  class="dropdown-item" href="<?=$data['USER_FOLDER']?>/payout-statement<?=$data['ex']?>">&nbsp;&nbsp;<i class="fas fa-clipboard-list"></i>&nbsp; Payout Statement</a></li>
      <? } ?>
      
      <? if(((in_array(22, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
      <li><a class="dropdown-item" href="<?=$data['USER_FOLDER']?>/payout-keys<?=$data['ex']?>">&nbsp;&nbsp;<i class="fas fa-clipboard-list"></i>&nbsp; Payout Keys</a></li>
      <? } ?>
    </ul>-->
	
 <? } ?>
 

 
 <? if((isset($post['qrcode_gateway_request'])&&$post['qrcode_gateway_request']!=3)&& ($_SESSION['dashboard_type']=="qrcode-dashboard")&&(((in_array(20, $grole)) && ($_SESSION['m_clients_type']=='Sub Member'))  || ($_SESSION['m_clients_type']==''))){ ?>

<li><a class="nav-link <?=$class_a_1?> " href="<?=$data['USER_FOLDER']?>/qr-dashboard<?=$data['ex']?>" title="QR Dashboard"><i class="<?=$data['fwicon']['home'];?> fa-fw"></i> <span class="menu_title">Dashboard</span></a></li>
<li class="px-2 my-1 ice1-show"><div class="hr-line"></div></li>
<li class="my-1 ice2-show"><div class="underline mx-2"></div></li>

<li><a class="nav-link <?=$class_a_1?> " href="<?=$data['USER_FOLDER']?>/qr-code<?=$data['ex']?>" title="QR Code"><i class="<?=$data['fwicon']['qrcode'];?> fa-fw"></i> <span class="menu_title">QR Code</span></a></li>
<li class="px-2 my-1 ice1-show"><div class="hr-line"></div></li>
<li class="my-1 ice2-show"><div class="underline mx-2"></div></li>

<li><a class="nav-link <?=$class_a_1?> " data-hr='qr-transactions' href="<?=$data['USER_FOLDER']?>/<?=$data['trnslist']?><?=$data['ex']?>" title="QR Transactions"><i class="<?=$data['fwicon']['transaction'];?> fa-fw"></i> <span class="menu_title">Transactions</span></a></li>
<li class="px-2 my-1 ice1-show"><div class="hr-line"></div></li>
<li class="my-1 ice2-show"><div class="underline mx-2"></div></li>

<? } ?>