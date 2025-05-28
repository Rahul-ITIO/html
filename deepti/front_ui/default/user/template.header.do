<? if(isset($data['ScriptLoaded'])){ ?>
<!DOCTYPE html>
<html lang="en" class="h-100 theme_mode" data-bs-theme="light">
<head>
<script>
var uid_var="<?=@$_SESSION['uid']?>";
var hostName="<?=$data['Host']?>";
var con_name="<?=$data['con_name']?>";
</script>
<?
$rootPath="";
if(strpos($_SERVER['REQUEST_URI'],"user/")!==false){$rootPath="../"; }
//include($rootPath."user/domain_server".$data['iex']);
//$domain_server=domain_serverf("","merchant");
//$domain_server=domain_serverf("checkdebit.net","merchant");
//$_SESSION['domain_server']=$domain_server;
$domain_server=(isset($_SESSION['domain_server'])?$_SESSION['domain_server']:'');
//print_r($domain_server);

//echo $domain_server['clients']['payout_request'];
//echo $domain_server['clients']['qrcode_gateway_request'];

// color from template from subadmin

//echo $data['PageFile'];
if($data['PageFile']=='summary'){
$_SESSION['dashboard_type']="payout-dashboar";
}
if($data['PageFile']=='qr_dashboard'){
$_SESSION['dashboard_type']="qrcode-dashboard";
}
if($data['PageFile']=='index'){
$_SESSION['dashboard_type']="";
}

//echo $_SESSION['dashboard_type'];

$du1=array();
$du1=implode(',',$data['all_host']);
//echo "<br/>du111=>". $du1;
$du1=explode(',',$du1);
//echo "<br/>du1222=>". $du1;

$data['PageTitle']=str_replace($du1,"Merchant Back Office",$data['PageTitle']);
$data['SiteCopyrights']=str_replace($du1,"",$data['SiteCopyrights']);
if(isset($domain_server)&&isset($domain_server['STATUS'])&&$domain_server['STATUS']==true){
	$ds_pt=$domain_server['PageTitle'];
	$du1=$domain_server['du1'];
	//$du2=$domain_server['du2'];
	$du2="Merchant Back Office";
	$data['PageTitle']=str_replace($du1,$du2,$data['PageTitle']);
	$data['SiteTitle']=str_replace($du1,$du2,$data['SiteTitle']);
	$data['SiteDescription']=str_replace($du1,$du2,$data['SiteDescription']);
	$data['SiteKeywords']=str_replace($du1,$du2,$data['SiteKeywords']);
	$data['SiteCopyrights']=str_replace($du1,$du2,$data['SiteCopyrights']);
	
	$proto_col = isset($_SERVER["HTTPS"])?'https://':'http://';
	$data['home_url']=$proto_col.$_SERVER['SERVER_NAME'];
	if(!empty($domain_server['sub_admin_css'])){$_SESSION['theme_color']=$domain_server['sub_admin_css'];}
}
if(isset($data['HostL'])&&$data['HostL']){
	$data['Host']=$data['HostL'];
}
//for permission
$str1 = trim(((isset($_SESSION['m_clients_role'])&&$_SESSION['m_clients_role'])?$_SESSION['m_clients_role']:''));
$grole=explode(',',$str1);

?>
<title><?=ucwords(strtolower($data['PageTitle']))?></title>
<? if(isset($domain_server)&&isset($domain_server['STATUS'])&&$domain_server['STATUS']==true&&(isset($domain_server['LOGO_ICON'])&&$domain_server['LOGO_ICON'])){ ?>
<!-- Favicon -->
<meta name="msapplication-TileImage" content="<?=encode_imgf($domain_server['LOGO_ICON']);?>">
<!-- Windows 8 -->
<meta name="msapplication-TileColor" content="#00CCFF"/>
<!-- Windows 8 color -->
<!--[if IE]><link rel="shortcut icon" href="<?=encode_imgf($domain_server['LOGO_ICON']);?>"><![endif]-->
<link rel="shortcut icon" href="<?=encode_imgf($domain_server['LOGO_ICON']);?>" type="image/x-icon">
<link rel="icon" href="<?=encode_imgf($domain_server['LOGO_ICON']);?>" type="image/x-icon">
<link rel="icon" type="image/png" href="<?=encode_imgf($domain_server['LOGO_ICON']);?>">
<? } ?>
<? if($data['con_name']=='clk1'){ ?>
<link rel="shortcut icon" href="<?=$data['Host']?>/images/fev_clk.png" type="image/x-icon">
<link rel="icon" href="<?=$data['Host']?>/images/fev_clk.png" type="image/x-icon">
<link rel="icon" type="image/png" href="<?=$data['Host']?>/images/fev_clk.png">
<? } ?>
<meta name=Title content="<?=prntext($data['SiteTitle'])?>">
<meta http-equiv=Content-Type content="text/html; charset=<?=prntext($data['SiteCharset'])?>">
<!-- Meta -->
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
<meta http-equiv="Content-Security-Policy" content="default-src 'self'; font-src * 'unsafe-inline'; style-src * 'unsafe-inline'; script-src * 'unsafe-inline' 'unsafe-eval'; img-src * data: 'unsafe-inline'; connect-src * 'unsafe-inline'; frame-src *; object-src 'none'" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<script type="text/javascript">var hostPath="<?php echo $data['Host']?>";</script>
<script src="<?=$data['TEMPATH']?>/common/js/jquery-3.6.4.min.js"></script>
<link href="<?=$data['TEMPATH']?>/common/css/bootstrap.min.css" rel="stylesheet">
<link href="<?=$data['Host']?>/thirdpartyapp/fontawesome/css/all.min.css" rel="stylesheet">
<script src="<?=$data['TEMPATH']?>/common/js/bootstrap.bundle.min.js"></script>
<link href="<?=$data['TEMPATH']?>/common/css/template-custom.css" rel="stylesheet">
<script src="<?=$data['TEMPATH']?>/common/js/common_use.js" type="text/javascript"></script>
<script src="<?=$data['TEMPATH']?>/common/js/common_use_merchant.js" type="text/javascript"></script>
<? 
///////////////////// Color Code Get From Header - Hardcoded ////////////////
$body_bg_color="#ffffff";
$body_text_color="#000000";
	
$heading_bg_color="#ffffff";;
$heading_text_color="#000000";
///////////////////// End Color Code Get From Header ////////////////

// include for display dynamic template color
include($data['Path'].'/include/header_color_ux'.$data['iex']); 

// include for display font awasome icon
include($data['Path'].'/include/fontawasome_icon'.$data['iex']);

// include for Adjustment Template Color & size by merchant added by vikash on 29122022
include($data['Path'].'/include/color_font_adjustment_ux'.$data['iex']);

?>
<style>

/*common class for all merchant pages*/
.dropdown-item.active, .dropdown-item:active {
    color: var(--color-2) !important;/*//by vikash on 28022023*/
    background: var(--color-4) !important;
}

.wrapper .container, .wrapper #container  {
max-width: 100%;
}
.leftPanelBody .navbar {
    margin-bottom: 0px;
	border-bottom: 3px solid #fff;
    float: left;
    width: 100%;
    box-shadow: 0px -10px 10px 5px rgb(0 0 0 / 75%);
}
.wrapper {
    display: flex;
    width: 100%;
    align-items: stretch;
    background: #fff;
}
.hide{
 display:none;
}
.dropdown-toggle::after {
    /*display: block;
    position: absolute;
    top: 50%;
    right: 20px;
    transform: translateY(-50%);*/
}

#main_link a {font-size: var(--font-size-template);}
.header_menu_link li i {/*display:none;*/}
.fa-stack-1x, .fa-stack-2x {position: unset!important; width: unset!important;}

<? if(isset($_GET['admin'])&&$_GET['admin']) { ?>
	.container {max-width:100% !important;}
	.container-flex.user_header_main {display:none;}
<? } ?>

<? if(isset($hd_b_l_9)&&$hd_b_l_9){?>
.input-group-text {
   /* background-color: var(--color-3);
    border: 1px solid <?=$hd_b_l_9?>;
	color: var(--color-4)!important;*/
}
<? }?>
</style>
<?

//print_r($data);
$front_ui_panel=((isset($domain_server['subadmin']['front_ui_panel'])&&$domain_server['subadmin']['front_ui_panel'])?$domain_server['subadmin']['front_ui_panel']:'');

$data['themeName_sys']=$data['PageFile'].'_'.$data['frontUiName'];
  
//if($data['frontUiName']=='sys'){
$theme_color=((isset($theme_color)&&$theme_color)?$theme_color:''); 


if($front_ui_panel=='Left_Panel'){

	$theme_color=$theme_color.'_'.$data['frontUiName'];
	//$theme_color=$data['themeName'].'_'.$data['frontUiName'];
	if(($data['PageFile']=='login')||(!isset($_SESSION['login']))){
		
	}else{
		$data['themeName']='LeftPanel';
		$_SESSION['themeName']=$data['themeName'];
	}
}else{
	
	//$theme_color=$data['themeName'];
	$data['themeName']=$theme_color;
	$_SESSION['themeName']=$theme_color;
	
}
//cmn
//$data['themeName']='LeftPanel';	
if(isset($_REQUEST['h'])&&$_REQUEST['h']==1){
	echo "<br/><br/>frontUiName=>".$data['frontUiName'];
	echo "<br/><br/>theme_color=>".$theme_color;
	if(isset($asco)&&$asco) {	echo "<br/><br/>asco=>";print_r($asco);}
}
?>
<style type="text/css">
<?=(isset($domain_server['STYLE'])?$domain_server['STYLE']:'');?>
</style>
<script>
function chosen_more_value_f(theId,arrVal,matchCon='yes'){
	var getArr = [];
	var conArrVal = [];
	var matchAry = [];
	var appendOption = '';

	getArr = $("#"+theId+" option").map((_,e) => e.value).get();
	conArrVal = arrVal;
	//alert(conArrVal);
	for(var i = 0; i < conArrVal.length; i++)
	{
		if(conArrVal[i]){
			//alert(conArrVal[i]);
			if ( $.inArray(conArrVal[i], getArr ) > -1 ) { // match
				matchAry.push(conArrVal[i]);
				//alert(conArrVal[i]); 
			}else{ // not match
				//alert(conArrVal[i]);
				appendOption += '<option value="'+conArrVal[i]+'" selected>'+conArrVal[i]+'</option>';
			}
		}
	}
	if(matchCon=='yes'){
		$("#"+theId).val(matchAry).trigger("change").trigger("chosen:updated");
	}
	$("#"+theId).append(appendOption).trigger("change").trigger("chosen:updated");
	//alert(matchAry);
}
 </script>
 <script>
function s(){window.status="processing...";return true;};if(document.layers)document.captureEvents(Event.MOUSEOVER|Event.MOUSEOUT|Event.CLICK|Event.DBLCLICK);document.onmouseover=s;document.onmouseout=s;
 </script>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Pragma-directive" content="no-cache">
<meta http-equiv="Cache-Directive" content="no-cache">
<meta http-equiv="Expires" content="0">
</head><?php 
$redirect_url=((isset($redirect_url)&&$redirect_url)?$redirect_url:''); 
$_SESSION['m_clients_type']=((isset($_SESSION['m_clients_type'])&&$_SESSION['m_clients_type'])?$_SESSION['m_clients_type']:'');
$_SESSION['m_clients_role']=((isset($_SESSION['m_clients_role'])&&$_SESSION['m_clients_role'])?$_SESSION['m_clients_role']:'');
?>
<!--/// For Payout dropdown top and Left Panel class and icon Added By Vikash on 03-09-2022////-->
<? 
//echo $_SESSION['dashboard_type']="qrcode-dashboard";
if(isset($_SESSION['dashboard_type'])&&$_SESSION['dashboard_type']=="payout-dashboar"){ 
$payouttitle="Payout Gateway"; 
$payouticon=$data['fwicon']['money-bill-transfer'];
$payouticon1=$data['fwicon']['check-circle'];
$payouticon2=$data['fwicon']['credit-card'];
$payouticon3=$data['fwicon']['qrcode'];

}elseif(isset($_SESSION['dashboard_type'])&&$_SESSION['dashboard_type']=="qrcode-dashboard"){ 

$payouttitle="QR Gateway"; 
$payouticon=$data['fwicon']['qrcode'];
$payouticon1=$data['fwicon']['money-bill-transfer'];
$payouticon2=$data['fwicon']['credit-card'];
$payouticon3=$data['fwicon']['check-circle'];
}else{ 
$payouttitle="Payment Gateway"; 
$payouticon=$data['fwicon']['credit-card'];
$payouticon1=$data['fwicon']['money-bill-transfer'];
$payouticon2=$data['fwicon']['check-circle'];
$payouticon3=$data['fwicon']['qrcode'];
}
?>
<body class="d-flex flex-column h-100 <?=$data['PageFile']?> <?=($data['themeName_sys']?$data['themeName_sys'].' ':'')?><?=($data['frontUiName']?$data['frontUiName'].' ':'')?> <?=$redirect_url?> <?=$theme_color;?> hide_menu_<?=((isset($data['HideAllMenu']) &&$data['HideAllMenu'])?$data['HideAllMenu']:'') ;?> <? if((strpos(@$data['themeName'],'LeftPanel')!==false)||(isset($data['leftPanelBody'])&&$data['leftPanelBody'])){ echo "leftPanelBody";} ?> <?=((isset($is_logo)&&$is_logo)?$is_logo:'');?>">

<div class="switcher-box-mode">
  <div class="clr-box border">
<a type="button" data-bs-toggle="dropdown" aria-expanded="false" title="Set Color Mode">
    <vgg class="theme-icon-active"><use class="<?=$data['fwicon']['light'];?>" href="<?=$data['fwicon']['light'];?> text-white"></use></vgg>
  </a>
  <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="bd-theme" style="--bs-dropdown-min-width: 8rem;">
              <li>
                <button type="button" class="dropdown-item d-flex align-items-center change_color active" data-bs-theme-value="light">
                  <vgg class="bi me-2 opacity-50 theme-icon"><use class="<?=$data['fwicon']['light'];?>" href="<?=$data['fwicon']['light'];?> text-white"></use></vgg>
                  Light
                </button>
              </li>
              <li>
                <button type="button" class="dropdown-item d-flex align-items-center change_color" data-bs-theme-value="dark">
                  <vgg class="bi me-2 opacity-50 theme-icon"><use class="<?=$data['fwicon']['dark'];?>" href="<?=$data['fwicon']['dark'];?> text-white"></use></vgg>
                  Dark
                </button>
              </li>
              <li>
                <button type="button" class="dropdown-item d-flex align-items-center change_color" data-bs-theme-value="auto">
                  <vgg class="bi me-2 opacity-50 theme-icon"><use class="<?=$data['fwicon']['auto'];?>" href="<?=$data['fwicon']['auto'];?> text-white"></use></vgg>
                  Auto
                </button>
              </li>
            </ul>
  
  </div>
  
  </div>
<div class="switcher-box">

  <div class="clr-box border">
<a type="button" data-bs-toggle="dropdown" aria-expanded="false" title="Set Font Size"><i id="font-active" class="<?=$data['fwicon']['a'];?>"></i></a>
  
<ul class="dropdown-menu dropdown-menu-end text-start px-2" aria-labelledby="bd-theme" style="--bs-dropdown-min-width: 8rem;">
<li><button type="button" class="dropdown-item change_font_size" id="font-plus2" data-code="plus2"><i class="<?=$data['fwicon']['a'];?>"  style="font-size:18px"></i> ++</button></li>
<li><button type="button" class="dropdown-item change_font_size" id="font-plus" data-code="plus" ><i class="<?=$data['fwicon']['a'];?>" style="font-size:16px"></i> +</button></li>
<li><button type="button" class="dropdown-item change_font_size" id="font-minus" data-code="minus"><i class="<?=$data['fwicon']['a'];?>" style="font-size:14px"></i></button></li>
                  
                
              
              
              
            </ul>
  
  </div>
</div>

<? if(isset($_SESSION['login']) && (!isset($data['HideAllMenu']) && !isset($data['HideMenu']))){ ?>
<!--<div>-->
<nav class="navbar navbar-expand-lg navbar-light bg-light5 bg-primary text-white">
  <div class="container">
    <? if(($data['hdr_logo'])&&($domain_server['LOGO'])){  ?>
    <a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>" class="img-fluid"><img src="<?=encode_imgf($domain_server['LOGO']);?>" style="height:30px;padding-right: 40px;"></a>
    <? } ?>
    <?php if($data['themeName']!='LeftPanel'){ ?>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"> <i class="<?=$data['fwicon']['toggle-sidebar'];?>" title="Toggle Sidebar"></i> </button>
    <? } else { ?>
    <button type="button" id="sidebarCollapse" class="btn btn-primary me-1 border" autocomplete="off" ><i class="<?=$data['fwicon']['toggle-sidebar'];?>" title="Toggle Sidebar"></i><span>
    <!--&nbsp;Toggle Sidebar-->
    </span></button>
    <? } ?>
	
	<? if(isset($data['DB_CON_NAME_DISPLAY_IN_USER'])&&$data['DB_CON_NAME_DISPLAY_IN_USER']=='Y'&&isset($_SESSION['DB_CON_NAME'])&&$_SESSION['DB_CON_NAME']){ ?>
		<div class="navbar-text fw-bold border-watch text-white btn mx-2 text-end px-2 mb-1" style="padding:4px;"><i class="fa-solid fa-database  px-1 fa-fw"></i> <?=$_SESSION['DB_CON_NAME'];?>
		</div>
	<? } ?>
	
    <div class="collapse navbar-collapse bg-primary text-white" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0 header_menu_link">
        <?php if($data['themeName']!='LeftPanel'){ ?>
        <? //if(isset($post['payout_request'])&&($post['payout_request']==1 || $post['payout_request']==2)){ ?>
        <?php /*?> include file for payout button <?php */?>
        <?
	$payout_button=($data['Path']."/front_ui/{$data['frontUiName']}/common/template.merchant_payout_button".$data['iex']);
	if(file_exists($payout_button)){
		include($payout_button);
	}else{
		$payout_button=($data['Path']."/include/template.merchant_payout_button".$data['iex']);
		if(file_exists($payout_button)){
			include($payout_button);
		}
	}
   ?>
        <? //} ?>
        <? if(isset($_SESSION['dashboard_type'])&&$_SESSION['dashboard_type']=="payout-dashboar"){ ?>
        <!------------------>
        <? /*?> For Dynamic Payout Link <?php */?>
        <?
			$payout_link=($data['Path']."/front_ui/{$data['frontUiName']}/common/template.merchant_payout_link".$data['iex']);
			if(file_exists($payout_link)){
				include($payout_link);
			}else{
				$payout_link=($data['Path']."/payout/template.merchant_payout_link".$data['iex']);
				if(file_exists($payout_link)){
					include($payout_link);
				}
			}
			?>
        <? }elseif(isset($_SESSION['dashboard_type'])&&$_SESSION['dashboard_type']=="qrcode-dashboard"){ ?>
        <!------------------>
        <? /*?> For Dynamic Payout Link <?php */?>
        <?
			$payout_link=($data['Path']."/front_ui/{$data['frontUiName']}/common/template.merchant_qr_code_link".$data['iex']);
			if(file_exists($payout_link)){
			include($payout_link);
			}else{
			$payout_link=($data['Path']."/soft_pos/template.merchant_qr_code_link".$data['iex']);
			if(file_exists($payout_link)){
			include($payout_link);
			}
			}
			?>
        <? }else{ ?>
        <li class="nav-item"> <a class="nav-link text-white active menu-summary" aria-current="page" href="<?=$data['USER_FOLDER']?>/dashboard<?=$data['ex']?>">Dashboard</a> </li>
        <? if(((in_array(7, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
        <li class="nav-item"> <a class="nav-link text-white menu-summary" href="<?=$data['USER_FOLDER']?>/bank<?=$data['ex']?>">Account</a> </li>
        <? } ?>
        <? if(((in_array(8, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
        <li class="nav-item"> <a class="nav-link text-white menu-summary" href="<?=$data['USER_FOLDER']?>/<?=$data['MYWEBSITEURL']?><?=$data['ex']?>"><?=$data['MYWEBSITE']?></a> </li>
        <? } ?>
        <li class="nav-item dropdown"> <a class="nav-link text-white dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false"> Transactions </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
            <? if(((in_array(3, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
            <li><a class="dropdown-item menu-summary" href="<?=$data['USER_FOLDER']?>/<?=$data['trnslist'];?><?=$data['ex']?>">All Transaction</a></li>
            <? } ?>
            <? if(((in_array(4, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
            <li><a class="dropdown-item menu-summary" href="<?=$data['USER_FOLDER']?>/block_<?=$data['trnslist'];?><?=$data['ex']?>">Block Transaction</a></li>
            <? } ?>
            <? if(((in_array(15, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
            <li><a class="dropdown-item menu-summary" href="<?=$data['USER_FOLDER']?>/test_<?=$data['trnslist'];?><?=$data['ex']?>">Test Transaction</a></li>
            <? } ?>
            <? if(((in_array(10, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
            <li><a class="dropdown-item menu-summary" href="<?=$data['USER_FOLDER']?>/<?=$data['trnslist'];?>_recent_order<?=$data['ex']?>">Recent Order</a></li>
            <? } ?>
            <li>
              <hr class="dropdown-divider">
            </li>
            <? if(((in_array(14, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
            <li><a class="dropdown-item menu-summary" href="<?=$data['USER_FOLDER']?>/trans_statement<?=$data['ex']?>">Statement</a></li>
            <? } ?>
            <? if(isset($post['settlement_optimizer'])&&trim($post['settlement_optimizer'])&&$post['settlement_optimizer']=='manually'){ if(((in_array(16, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
            <li><a class="dropdown-item menu-summary" href="<?=$data['USER_FOLDER']?>/trans_withdraw-fund-list<?=$data['ex']?>">Withdraw Fund</a></li>
		<? } } ?>
          </ul>
        </li>
        <? } ?>
        <? } ?>
        <? if($_SESSION['login']){ 
        if($_SESSION['m_username']){ $username=$_SESSION['m_username'];
		}elseif($_SESSION['username']){ $username=$_SESSION['username']; }
?>
        <? } else { ?>
        <li class="nav-item"> <a href="<?=$data['Host']?>/signup<?=$data['ex']?>" class="nav-link text-white"><i></i>Sign Up</a> </li>
        <li class="nav-item"> <a href="<?=$data['Host']?>" class="nav-link text-white"><i></i>Login</a> </li>
        <? } ?>
      </ul>
      <? if($username){ ?>
      <div class="dropdown"> <a class="btn btn-primary dropdown-toggle55 border  header_menu_link"  data-bs-toggle="dropdown"> <i class="<?=$data['fwicon']['circle-user'];?>" aria-hidden="true" title="Welcome <?=ucwords(strtolower(prntext($username)));?>" ></i><span class="text-hide-mobile"> Welcome
        <?=ucwords(strtolower(prntext($username)));?>
        <?php 
		if((isset($_SESSION['m_clients_name'])&&$_SESSION['m_clients_name'])?$_SESSION['m_clients_name']:''){
		echo "(".$_SESSION['m_clients_name'].")";
		}
		
		?>
        </span> </a>
        <ul class="dropdown-menu dropdown-menu-lg-end" id="VDisplayleft" style1="width: 190px;">
		<li class="d-block d-sm-none"><a class="dropdown-item menu-summary mx-2">Welcome [<?=ucwords(strtolower(prntext($username)));?>]</a></li>
		<li class="d-block d-sm-none"><hr class="dropdown-divider"></li>
<? 
//Dev Tech : 24-02-16 re-modify for switch of more db instance 
if(isset($data['DB_CON_SWITCH_LINK_DISPLAY_IN_USER'])&&$data['DB_CON_SWITCH_LINK_DISPLAY_IN_USER']=='Y'&&isset($data['DB_CON'])) 
more_db_conf('menu-summary','');
?> 
  

		  
          <? if(@$_SESSION['dashboard_type']!="payout-dashboar" && @$_SESSION['dashboard_type']!="qrcode-dashboard"){ ?>
          <? if(((in_array(9, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
          <li> <a class="dropdown-item menu-summary" href="<?=$data['USER_FOLDER']?>/profile<?=$data['ex']?>" ><i class="<?=$data['fwicon']['profile'];?> fa-fw"></i> Profile</a> </li>
          <? } ?>
          <? if(((in_array(1, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
          <li> <a class="dropdown-item menu-summary" href="<?=$data['USER_FOLDER']?>/emails<?=$data['ex']?>"><i class="<?=$data['fwicon']['email'];?> fa-fw"></i> Emails</a> </li>
          <? } ?>
          <li> <a class="dropdown-item menu-summary" href="<?=$data['USER_FOLDER']?>/summary-account<?=$data['ex']?>"><i class="<?=$data['fwicon']['account-summary'];?> fa-fw"></i> Account Summary</a> </li>
          <? if(((in_array(2, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
          <li> <a class="dropdown-item menu-summary" href="<?=$data['USER_FOLDER']?>/account-security<?=$data['ex']?>"><i class="<?=$data['fwicon']['shield'];?> fa-fw"></i> Account Security</a> </li>
          <? } ?>
          <?php if($data['themeName']!='LeftPanel'){ ?>
          <? if(((in_array(5, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
          <li> <a class="dropdown-item menu-summary" href="<?=$data['USER_FOLDER']?>/manage-user<?=$data['ex']?>"><i class="<?=$data['fwicon']['manage-user'];?> fa-fw"></i> User Management</a> </li>
          <? } ?>
          <? if(((in_array(17, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
          <li> <a class="dropdown-item menu-summary" href="<?=$data['USER_FOLDER']?>/stats<?=$data['ex']?>"><i class="<?=$data['fwicon']['chart'];?> fa-fw"></i> Success Ratio</a> </li>
          <? } ?>
          <? } ?>
          <li> <a class="dropdown-item menu-summary" href="<?=$data['USER_FOLDER']?>/myblacklist<?=$data['ex']?>"><i class="<?=$data['fwicon']['ban'];?> fa-fw"></i> Black List</a> </li>
          <li>
            <hr class="dropdown-divider">
          </li>
          <? } ?>
          <li><a class="dropdown-item menu-summary" href="<?=$data['USER_FOLDER']?>/logout<?=$data['ex']?>"><i class="<?=$data['fwicon']['signout'];?> text-danger fa-fw"></i> Sign Out</a></li>
        </ul>
      </div>
      <? } else { ?>
      User
      <? } ?>
    </div>
  </div>
</nav>
<?php if($data['themeName']!='LeftPanel'){ ?>
<? }else{ ?>
<style>

.navbar {
    padding: 15px 10px;
    background: #fff;
    border: none;
    border-radius: 0;
    margin-bottom: 40px;
    box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.1);
}

.navbar-btn {
    box-shadow: none;
    outline: none !important;
    border: none;
}

.line {
    width: 100%;
    height: 1px;
    border-bottom: 1px dashed #ddd;
    margin: 40px 0;
}

/* ---------------------------------------------------
    SIDEBAR STYLE
----------------------------------------------------- */

.wrapper {
    display: flex;
    width: 100%;
    align-items: stretch;
}

#sidebar {
    /*min-width: 250px;
    max-width: 250px;*/
	width:200px;
    background: #0071bc;
    color: #fff;
    transition: all 0.3s;
	min-height:calc(100vh - 140px);
}

#sidebar.active {
    margin-left: 0px;
	width: 40px;
}

#sidebar .sidebar-header {
    padding: 20px;
    background: #6d7fcc;
}
#sidebar.active .menu_title {display:none;}
#sidebar.active .dropdown-toggle::after {display:none;}
#sidebar ul.components {
    padding: 2px 0;
    /*border-bottom: 1px solid #47748b;*/
}


#sidebar ul p {
    color: #fff;
    padding: 10px;
}

#sidebar ul li a {
    padding: 10px;
    font-size: var(--font-size-template);
    display: block;
}

#sidebar ul li a:hover {  /*change on 01032023*/
    color: var(--color-1) !important;  
	background: var(--menu-list-hover-color) !important;
	margin: 0px 5px 0px 5px; border-radius: 0.25rem;  
}

#sidebar ul li a.dropdown-item.menu-summary:hover { /*added on 01032023*/
    color: var(--color-1) !important; 
	background: var(--menu-list-hover-color) !important;
	margin: 0px 0px 0px 0px; border-radius: 0.25rem;  
}

#sidebar ul li.active>a,
a[aria-expanded-77="true"] {/*change on 01032023*/
    color: var(--color-1) !important;
	background: var(--menu-list-hover-color) !important; 
	margin: 0px 5px 0px 5px; border-radius: 0.25rem;  
}
a.dropdown-toggle88[aria-expanded="true"] {/*change on 01032023*/
	margin: 0px 0px 0px 0px; 
}

a[data-toggle="collapse"] {
    position: relative;
}

.dropdown-toggle::after {
    /*display: block;
    position: absolute;
    top: 50%;
    right: 20px;
    transform: translateY(-50%);*/
}

ul ul a {
    font-size: var(--font-size-template) !important;
    padding-left: 30px !important;
    background: #6d7fcc;
}

ul.CTAs {
    padding: 20px;
}

ul.CTAs a {
    text-align: center;
    font-size: var(--font-size-template) !important;
    display: block;
    border-radius: 5px;
    margin-bottom: 5px;
}

a.download {
    background: #fff;
    color: #0071bc;
}

a.article,
a.article:hover {
    background: #6d7fcc !important;
    color: #fff !important;
}

/* ---------------------------------------------------
    CONTENT STYLE
----------------------------------------------------- */

#content {
    width: 100%;
	padding-right:5px;
	padding-left:5px;
    /*padding: 20px;
    min-height: 100vh;
    transition: all 0.3s;*/
}

.dropdown_from_top { margin-top: -48px !important; width:150px; }
/* ---------------------------------------------------
    MEDIAQUERIES
----------------------------------------------------- */

@media (max-width: 768px) {
    #sidebar {
        margin-left: -200px;
    }
    #sidebar.active {
        margin-left: 0;
    }
    #sidebarCollapse span {
        display: none;
    }
}
@media (max-width: 999px) {
#content.active { width: calc(100% - 40px) !important;}
}

@media (min-width: 280px){
.navbar-expand-lg .navbar-collapse {
    display: flex!important;
    flex-basis: auto!important;
}
}
/*#content {width: calc(100% - 200px)!important;}*/
  </style>
<script type="text/javascript">


        $(document).ready(function () {
		    
			/* For set sidebar width on session */
            $('#sidebarCollapse').on('click', function () {
                $('#sidebar ,#content').toggleClass('active');

				   if($("#sidebar").hasClass("active")){
					sessionStorage.setItem("jqr_class", "active");
					$("#sidebar").css("width","40px");
					$(".menu_title").hide();
					}else{
					sessionStorage.setItem("jqr_class", "");
					$("#sidebar").css("width","200px");
					$(".menu_title").show();
					}
				
            });
			let personName = sessionStorage.getItem("jqr_class");
			$("#sidebar ,#content").addClass(personName);
			
			/* End set sidebar width on session */
			
        });
    </script>
<div class="wrapper">
<nav id="sidebar" class="bg-primary" >
  <ul class="list-unstyled components mt-2 border-end">
    <?php /*?> include file for payout button <?php */?>
    <? //if(isset($post['payout_request'])&&($post['payout_request']==1 || $post['payout_request']==2)){ ?>
    <?
	$payout_button=($data['Path']."/front_ui/{$data['frontUiName']}/common/template.merchant_payout_button".$data['iex']);
	if(file_exists($payout_button)){
		include($payout_button);
	}else{
		$payout_button=($data['Path']."/include/template.merchant_payout_button".$data['iex']);
		if(file_exists($payout_button)){
			include($payout_button);
		}
	}
?>
    <? //} ?>
    <? if(isset($_SESSION['dashboard_type'])&&$_SESSION['dashboard_type']=="payout-dashboar"){ ?>
    <?php /*?> include file for payout Menu Link <?php */?>
    <?
		$payout_link=($data['Path']."/front_ui/{$data['frontUiName']}/common/template.merchant_payout_link".$data['iex']);
		if(file_exists($payout_link)){
		include($payout_link);
		}else{
		$payout_link=($data['Path']."/payout/template.merchant_payout_link".$data['iex']);
		if(file_exists($payout_link)){
		include($payout_link);
		}
		}
		?>
    <? }elseif(isset($_SESSION['dashboard_type'])&&$_SESSION['dashboard_type']=="qrcode-dashboard"){ ?>
    <!------------------>
    <? /*?> For Dynamic Payout Link <?php */?>
    <?
			$payout_link=($data['Path']."/front_ui/{$data['frontUiName']}/common/template.merchant_qr_code_link".$data['iex']);
			if(file_exists($payout_link)){
			include($payout_link);
			}else{
			$payout_link=($data['Path']."/soft_pos/template.merchant_qr_code_link".$data['iex']);
			if(file_exists($payout_link)){
			include($payout_link);
			}
			}
			?>
    <? } else { ?>
    <li><a class="text-white text-decoration-none menu-summary" href="<?=$data['USER_FOLDER']?>/dashboard<?=$data['ex']?>" title="Dashboard"><i class="<?=$data['fwicon']['home'];?> fa-fw"></i> <span class="menu_title">Dashboard</span></a></li>
    <li class="nav-item dropdown"> <a class="nav-link text-white dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false"  title="Templates"> <i class="<?=$data['fwicon']['transaction'];?> fa-fw"></i> <span class="menu_title">Transactions</span> </a>
      <ul class="dropdown-menu text-white" aria-labelledby="navbarDropdown" style="">
        <? if(((in_array(3, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
        <li><a  class="dropdown-item menu-summary" href="<?=$data['USER_FOLDER']?>/<?=$data['trnslist'];?><?=$data['ex']?>">&nbsp;&nbsp;<i class="<?=$data['fwicon']['transaction'];?> fa-fw"></i>&nbsp;All Transaction</a></li>
        <? } ?>
        <? if(((in_array(4, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
        <li><a  class="dropdown-item menu-summary" href="<?=$data['USER_FOLDER']?>/block_<?=$data['trnslist'];?><?=$data['ex']?>">&nbsp;&nbsp;<i class="<?=$data['fwicon']['blocktransaction'];?> fa-fw"></i>&nbsp;Block Transaction</a></li>
        <? } ?>
        <? if(((in_array(15, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
        <li><a  class="dropdown-item menu-summary" href="<?=$data['USER_FOLDER']?>/test_<?=$data['trnslist'];?><?=$data['ex']?>">&nbsp;&nbsp;<i class="<?=$data['fwicon']['testtransaction'];?> fa-fw"></i>&nbsp;Test Transaction</a></li>
        <? } ?>
        <? if(((in_array(10, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
        <li><a  class="dropdown-item menu-summary" href="<?=$data['USER_FOLDER']?>/recent_order<?=$data['ex']?>">&nbsp;&nbsp;<i class="<?=$data['fwicon']['recentorder'];?> fa-fw"></i>&nbsp;Recent Order</a></li>
        <? } ?>
        <? if(((in_array(14, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
        <li><a  class="dropdown-item menu-summary" href="<?=$data['USER_FOLDER']?>/trans_statement<?=$data['ex']?>">&nbsp;&nbsp;<i class="<?=$data['fwicon']['mystatement'];?> fa-fw"></i>&nbsp;My Statement</a></li>
        <? } ?>
        <? if(((in_array(11, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
        <li><a class="dropdown-item menu-summary" href="<?=$data['USER_FOLDER']?>/request_fund<?=$data['ex']?>">&nbsp;&nbsp;<i class="<?=$data['fwicon']['requestfund'];?> fa-fw"></i>&nbsp;Request Funds
          <?php /*?><?=$post['default_currency_sys'];?><?php */?>
          </a></li>
        <? } ?>
        <? if(isset($post['settlement_optimizer'])&&trim($post['settlement_optimizer'])&&$post['settlement_optimizer']=='manually'){ if(((in_array(16, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
        <li><a  class="dropdown-item menu-summary" href="<?=$data['USER_FOLDER']?>/trans_withdraw-fund-list<?=$data['ex']?>">&nbsp;&nbsp;<i class="<?=$data['fwicon']['settlement'];?> fa-fw"></i>&nbsp;Withdrawal Funds
          <?php /*?> <?=$post['default_currency_sys'];?><?php */?>
          </a></li>
	<? } } ?>
      </ul>
    </li>
    <? if(((in_array(8, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
    <li><a class="text-white text-decoration-none menu-summary" href="<?=$data['USER_FOLDER']?>/<?=$data['MYWEBSITEURL']?><?=$data['ex']?>" title="My <?=$data['MYWEBSITE']?>"><i class="<?=$data['fwicon']['website'];?> fa-fw"></i><span class="menu_title">&nbsp;My <?=$data['MYWEBSITE']?></span></a></li>
    <? } ?>
    <? if(((in_array(7, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
    <li><a class="text-white text-decoration-none menu-summary" href="<?=$data['USER_FOLDER']?>/bank<?=$data['ex']?>" title="My Bank Accounts"><i class="<?=$data['fwicon']['bank'];?> fa-fw"></i><span class="menu_title">&nbsp;My Bank Accounts</span></a></li>
    <? } ?>
    <? if(((in_array(14, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
    <li><a  class="text-white text-decoration-none menu-summary" href="<?=$data['USER_FOLDER']?>/stats<?=$data['ex']?>" title="Success Ratio"><i class="<?=$data['fwicon']['chart'];?> fa-fw"></i><span class="menu_title">&nbsp;Success Ratio</span></a></li>
    <? } ?>
    <? if(((in_array(5, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
    <li><a class="text-white text-decoration-none menu-summary" href="<?=$data['USER_FOLDER']?>/manage-user<?=$data['ex']?>" title="User Management"><i class="<?=$data['fwicon']['manage-user'];?> fa-fw"></i><span class="menu_title">&nbsp;User Management</span></a></li>
    <? } ?>
    <? } ?>
  </ul>
</nav>
<!-- Page Content  -->
<div id="content" class="bg-primary">
<? } ?>
<? } else{ ?>
<? if(!isset($data['HideAllMenu'])&&!isset($data['HideMenu'])){ ?>
<div>
  <nav class="navbar navbar-expand-lg navbar-light bg-light5 bg-primary text-white">
    <div class="container">
      <? if(($data['hdr_logo'])&&($domain_server['LOGO'])){ ?>
      <a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>" class="img-fluid"><img src="<?=$domain_server['LOGO'];?>" style="height:30px;padding-right: 10px;"></a>
      <? } ?>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"> <span class="navbar-toggler-icon"></span> </button>
      <div class="collapse navbar-collapse bg-primary text-white" id="navbarSupportedContent">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item"> <a class="nav-link text-white active" aria-current="page" href="<?=$data['USER_FOLDER']?>/dashboard<?=$data['ex']?>">Dashboard</a> </li>
          <? if(isset($_SESSION['login'])&&$_SESSION['login']){ 
        if($_SESSION['m_username']){ $username=$_SESSION['m_username'];
		}elseif($_SESSION['username']){ $username=$_SESSION['username']; }
?>
          <li class="nav-item">
          <li><a class="nav-link text-white" href="<?=$data['USER_FOLDER']?>/logout<?=$data['ex']?>">Sign Out</a></li>
          </li>
          <? } else { ?>
          <li class="nav-item"> <a href="<?=$data['Host']?>/signup<?=$data['ex']?>" class="nav-link text-white"><i></i>Sign Up</a> </li>
          <li class="nav-item"> <a href="<?=$data['Host']?>" class="nav-link text-white"><i></i>Login</a> </li>
          <? } ?>
        </ul>
        <? if(isset($username)&&$username){ ?>
        <div class="dropdown"> <a class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown"> <i class="<?=$data['fwicon']['user'];?>" aria-hidden="true" ></i> Welcome
          <?=ucwords(strtolower(prntext($username)));?>
          <? if($_SESSION['m_clients_name']<>""){ echo "(".$_SESSION['m_clients_name'].")"; } ?>
          </a>
          <ul class="dropdown-menu">
            <li>
              <hr class="dropdown-divider">
            </li>
            <li><a class="nav-link text-dark" href="<?=$data['USER_FOLDER']?>/logout<?=$data['ex']?>"><i class="<?=$data['fwicon']['signout'];?>"></i> Sign Out</a></li>
          </ul>
        </div>
        <? } else { ?>
        <i class="<?=$data['fwicon']['user'];?>" aria-hidden="true" ></i>&nbsp;Welcome User
        <? } ?>
      </div>
    </div>
  </nav>
</div>
<? } ?>
<? } ?>
<? if(isset($_SESSION['login']) &&( !isset($data['HideAllMenu'])&&!isset($data['HideMenu']))){ ?>
<? if(strpos($data['themeName'],'LeftPanel')!==false){?>
<!--<div class="wrapper" style="display: table-cell;">-->
<? } ?>
<? }else{ ?>
<? 

//echo $data['PageFile'];
// for hide page title from page top
$header_title_search = array("payin-processing-engine", "test3dsecureauthentication", "success", "failed", "developer", "docs", "transaction_processing", "device_confirmations", "forgot", "login", "logout", "signup", "password","confirm","two-factor-authentication","bank","chart","payin-processing-engine","return_url","trans_processing","trans_developer");
$header_title_center = array("login", "forgot", "signup","confirm","password","confirm","confirm","logout","device_confirmations");

$hide_color_box = array("payin-processing-engine","success","failed","transaction_processing", "forgot", "login", "logout", "signup", "password","return_url","trans_processing");

$title_position="text-start";
$title_border="vkg-main-border";

if(in_array($data['PageFile'], $header_title_center)){
$title_position="text-center";
$title_border="";
?>
<style> 
bodyX { 
              /*background: #FFFFFF !important;*/
			  
			  background-image: linear-gradient(135deg, <?=$_SESSION['background_gd3'];?> 25%, transparent 25%, transparent 50%, <?=$_SESSION['background_gd3'];?> 50%, <?=$_SESSION['background_gd3'];?> 100%, transparent 75%, <?=$_SESSION['background_gd3'];?>)!important;
			  /*background-image: linear-gradient(140deg, #E3FDF5 25%,transparent 25%, transparent 60%, transparent 55%, #FFE6FA 25%)!important;*/
             } 
</style>
<?
}
if((in_array($data['PageFile'], $hide_color_box)) || (isset($_REQUEST['admin'])&&$_REQUEST['admin']==1)){
?>
<style>.switcher-box{ display:none;}</style>
<style>.switcher-box-mode{ display:none;}</style>
<?
} 

$user_header_main=1;
if(!in_array($data['PageFile'], $header_title_search)) $user_header_main=0;
if(isset($_REQUEST['hd2'])&&$_REQUEST['hd2']==1) $user_header_main=0;
//echo "<br/>user_header_main=>".$user_header_main;	
if(isset($data['HideAllMenu'])&&$data['HideAllMenu']==1) $user_header_main=0;

if($user_header_main==1){?>
<div class="container-flex user_header_main ">
  <div class="container py-3 <?=$title_position;?>">
    <h1><a href="index<?=$data['iex'];?>" title="Dashboard"><i class="<?=$data['fwicon']['home'];?>"></i></a>
      <?=ucwords(strtolower(prntext($data['PageName'])))?>
    </h1>
    <div class="<?=$title_border;?>"></div>
  </div>
</div>
<? }else{ ?>
<!--<div class="my-3"></div>-->
<? } ?>
<? } ?>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
