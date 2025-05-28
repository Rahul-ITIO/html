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
<?php /*?><? if((isset($post['payout_request'])&&$post['payout_request']!=3)&& ($_SESSION['dashboard_type']=="") &&(((in_array(20, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']==''))){ ?>
	
	<!--<li class="nav-item dropdown "> <a class="nav-link text-decoration-none <?=$class_a_1?> " href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false" title="Payout"> <i class="fas fa-money-check-alt"></i> <span class="menu_title">Payout33</span> </a>-->
   
    <!--<ul class="dropdown-menu ms-1 bg-vlight" aria-labelledby="navbarDropdown" style="">
	<? if(((in_array(17, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
      <li><a  class="dropdown-item" href="<?=$data['USER_FOLDER']?>/summary<?=$data['ex']?>?act=1">&nbsp;&nbsp;<i class="fas fa-clipboard-list"></i>&nbsp; Summary</a></li>
      <? } ?>
      <? if(((in_array(20, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
      <li><a  class="dropdown-item" href="<?=$data['USER_FOLDER']?>/transfers<?=$data['ex']?>">&nbsp;&nbsp;<i class="fas fa-clipboard-list"></i>&nbsp; Transfers</a></li>
      <? } ?>
	  <? if(((in_array(23, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
      <li><a  class="dropdown-item" href="<?=$data['USER_FOLDER']?>/beneficiaries<?=$data['ex']?>">&nbsp;&nbsp;<i class="fas fa-clipboard-list"></i>&nbsp; Beneficiaries</a></li>
      <? } ?>
      
      <? if(((in_array(19, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
      <li><a  class="dropdown-item" href="<?=$data['USER_FOLDER']?>/fund-sources<?=$data['ex']?>">&nbsp;&nbsp;<i class="fas fa-clipboard-list"></i>&nbsp; Fund Sources</a></li>
      <? } ?>
      <? if(((in_array(21, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
      <li><a  class="dropdown-item" href="<?=$data['USER_FOLDER']?>/trans_statement<?=$data['ex']?>">&nbsp;&nbsp;<i class="fas fa-clipboard-list"></i>&nbsp; Statement</a></li>
      <? } ?>
      
      <? if(((in_array(22, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
      <li><a class="dropdown-item" href="<?=$data['USER_FOLDER']?>/payout-keys<?=$data['ex']?>">&nbsp;&nbsp;<i class="fas fa-clipboard-list"></i>&nbsp; Payout Keys</a></li>
      <? } ?>
	  <li><a class="dropdown-item" href="<?=$data['Host']?>/payout/payoutapi_v1.pdf">&nbsp;&nbsp;<i class="fas fa-clipboard-list"></i>&nbsp; Developer API</a></li>
    </ul>-->
	
	<!--<li><a  class="nav-link text-decoration-none <?=$class_a_1?> " href="<?=$data['USER_FOLDER']?>/summary<?=$data['ex']?>?act=1">&nbsp;&nbsp;<i class="fas fa-clipboard-list"></i>&nbsp; Payout</a></li>-->
	
 <? } ?><?php */?>
 
 <? if((isset($post['payout_request'])&&$post['payout_request']!=3)&& ($_SESSION['dashboard_type']=="payout-dashboar")&&(((in_array(20, $grole)) && ($_SESSION['m_clients_type']=='Sub Member'))  || ($_SESSION['m_clients_type']==''))){ ?>

<li><a class="nav-link <?=$class_a_1?> " href="<?=$data['USER_FOLDER']?>/summary<?=$data['ex']?>" title="Summary"><i class="<?=$data['fwicon']['transaction'];?> fa-fw"></i> <span class="menu_title">Summary</span></a></li>
<li class="px-2 my-1 ice1-show"><div class="hr-line"></div></li>
<li class="my-1 ice2-show"><div class="underline mx-2"></div></li>

<li><a class="nav-link <?=$class_a_1?> " href="<?=$data['USER_FOLDER']?>/beneficiaries<?=$data['ex']?>" title="Beneficiaries"><i class="<?=$data['fwicon']['user-double'];?> fa-fw"></i> <span class="menu_title">Beneficiaries</span></a></li>
<li class="px-2 my-1 ice1-show"><div class="hr-line"></div></li>
<li class="my-1 ice2-show"><div class="underline mx-2"></div></li>

<li><a class="nav-link <?=$class_a_1?> " href="<?=$data['USER_FOLDER']?>/transfers<?=$data['ex']?>" title="Transfers"><i class="<?=$data['fwicon']['arrow-right-arrow-left'];?> fa-fw"></i> <span class="menu_title">Transfers</span></a></li>
<li class="px-2 my-1 ice1-show"><div class="hr-line"></div></li>
<li class="my-1 ice2-show"><div class="underline mx-2"></div></li>

<li><a class="nav-link <?=$class_a_1?> " href="<?=$data['USER_FOLDER']?>/fund-sources<?=$data['ex']?>" title="Fund Sources"><i class="<?=$data['fwicon']['fund-sources'];?> fa-fw"></i> <span class="menu_title">Fund Sources</span></a></li>
<li class="px-2 my-1 ice1-show"><div class="hr-line"></div></li>
<li class="my-1 ice2-show"><div class="underline mx-2"></div></li>

<li><a class="nav-link <?=$class_a_1?> " href="<?=$data['USER_FOLDER']?>/statements<?=$data['ex']?>" title="Reports"><i class="<?=$data['fwicon']['mystatement'];?> fa-fw"></i> <span class="menu_title">Statements</span></a></li>
<li class="px-2 my-1 ice1-show"><div class="hr-line"></div></li>
<li class="my-1 ice2-show"><div class="underline mx-2"></div></li>

<li><a class="nav-link <?=$class_a_1?> " href="<?=$data['USER_FOLDER']?>/payout-keys<?=$data['ex']?>" title="Api Keys"><i class="<?=$data['fwicon']['payout-secret-keys'];?> fa-fw"></i> <span class="menu_title">Api Keys</span></a></li>
<li class="px-2 my-1 ice1-show"><div class="hr-line"></div></li>
<li class="my-1 ice2-show"><div class="underline mx-2"></div></li>

<li><a class="nav-link <?=$class_a_1?> " href="<?=$data['Host']?>/payout/payoutapi_v1.pdf" target="_blank" title="Api Keys"><i class="<?=$data['fwicon']['pdf'];?> fa-fw"></i> <span class="menu_title">Developer API</span></a></li>
<li class="my-1 ice2-show"><div class="underline mx-2"></div></li>
<? } ?>