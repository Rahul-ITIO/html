<? if(isset($data['ScriptLoaded'])){ ?>
<!DOCTYPE html>
<html lang="en" class="h-100 theme_mode" data-bs-theme="light">
<head>
<script>
var uid_var="<?=@$_SESSION['uid']?>";
var hostName="<?=$data['Host']?>";
var con_name="<?=@$data['con_name']?>";
</script>
<?
$rootPath="";
// For Active Menu after search / Page redirect

if(strstr($_SERVER['REQUEST_URI'],"dashboard")){ $activecss="active_a"; 
} elseif(strstr($_SERVER['REQUEST_URI'],"settlement")){ $activecss_settlement="active_a";
} elseif(strstr($_SERVER['REQUEST_URI'],"statement")){ $activecss_statement="active_a";
}

// for Open payout & QR Code without button click
@$_SESSION['dashboard_type']="Active";

if(strpos($_SERVER['REQUEST_URI'],"user/")!==false){$rootPath="../"; }

$domain_server=@$_SESSION['domain_server'];
$_SESSION['dashboard_notice']=@$domain_server['subadmin']['dashboard_notice'];
$_SESSION['notice_type']=@$domain_server['subadmin']['notice_type'];
// color from template from subadmin

if($data['PageFile']=='summary'){
$_SESSION['dashboard_type']="payout-dashboar";
}
if($data['PageFile']=='qr_dashboard'){
$_SESSION['dashboard_type']="qrcode-dashboard";
}
if($data['PageFile']=='index'){
$_SESSION['dashboard_type']="";
}
//echo $_SESSION['dashboard_type']."@@@@@";
$du1=array();
$du1=implode(',',$data['all_host']);
//echo "<br/>du111=>". $du1;
$du1=explode(',',$du1);
//echo "<br/>du1222=>". $du1;

	$data['PageTitle']=str_replace($du1,"Merchant Back Office",$data['PageTitle']);
	$data['SiteCopyrights']=str_replace($du1,"",$data['SiteCopyrights']);
if(isset($domain_server['STATUS'])&&$domain_server['STATUS']==true){
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
<title><?=$data['PageTitle']?></title>
<? if(isset($domain_server['STATUS'])&&$domain_server['STATUS']==true&&(isset($domain_server['LOGO_ICON'])&&$domain_server['LOGO_ICON'])){ ?>
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

<!--<script src="<?=$data['TEMPATH']?>/common/js/jquery-3.6.0.min.js"></script>
<link href="<?=$data['TEMPATH']?>/common/css/bootstrap.min.css" rel="stylesheet">
<link href="<?=$data['Host']?>/thirdpartyapp/fontawesome/css/all.min.css" rel="stylesheet">
<script src="<?=$data['TEMPATH']?>/common/js/bootstrap.bundle.min.js"></script>
<link href="<?=$data['TEMPATH']?>/common/css/template-custom.css" rel="stylesheet">
<script src="<?=$data['TEMPATH']?>/common/js/common_use.js" type="text/javascript"></script>
<script src="<?=$data['TEMPATH']?>/common/js/common_use_merchant.js" type="text/javascript"></script>-->

<script type="text/javascript">var hostPath="<?php echo $data['Host']?>";</script>
<script src="<?=$data['Host']?>/front_ui/default/common/js/jquery-3.6.4.min.js"></script>
<link href="<?=$data['Host']?>/front_ui/default/common/css/bootstrap.min.css" rel="stylesheet">
<link href="<?=$data['Host']?>/thirdpartyapp/fontawesome/css/all.min.css" rel="stylesheet">
<script src="<?=$data['Host']?>/front_ui/default/common/js/bootstrap.bundle.min.js"></script>
<link href="<?=$data['Host']?>/front_ui/default/common/css/template-custom.css" rel="stylesheet">
<script src="<?=$data['Host']?>/front_ui/default/common/js/common_use.js" type="text/javascript"></script>
<script src="<?=$data['Host']?>/front_ui/default/common/js/common_use_merchant.js" type="text/javascript"></script>
<link href="<?=$data['TEMPATH']?>/common/css/opal_ind_custom.css" rel="stylesheet">


<?php 
$_SESSION['subadmin_customer_service_no']=@$domain_server['subadmin']['customer_service_no'];
$_SESSION['subadmin_customer_service_email']=@$domain_server['subadmin']['customer_service_email'];

///////////////////// Hardcoded////////////////////
$body_bg_color="url('".$data['TEMPATH']."/common/images/chevron.png')";
$body_text_color="#212529";

$heading_bg_color="url('".$data['TEMPATH']."/common/images/light_grey.png')";
$heading_text_color="#0071bc";


// include for display font awasome icon
include($data['Path'].'/include/fontawasome_icon'.$data['iex']);


$header_bg_color_by_header="#8a4af7";
$body_bg_color="#ffffff";
$body_text_color="#000000";
	
$heading_bg_color="#ffffff";;
$heading_text_color="#000000";
///////////////////// End Color Code Get From Header ////////////////

// include for display dynamic template color
include($data['Path'].'/include/header_color_ux'.$data['iex']);
$get_clientid_details_companyname=@$domain_server['clients']['company_name'];
//print_r($domain_server);
?>
<style>
.crv_first22.bg-primary.active .list-unstyled.components.invisible-scrollbar {
	max-width:50px;
}

.dropdown-item.active, .dropdown-item:active {
background:var(--color-3) !important;
}

.text-warning {
color:var(--color-4)!important;
}

.wrapper .container, .wrapper #container  {
    max-width: 100%;
}
.leftPanelBody .navbar {
    float: left;
    width: 100%;
}
.wrapper {
    display: flex;
    width: 100%;
    align-items: stretch;
}
.hide{
 display:none;
}

<? if(isset($hd_b_l_9)&&$hd_b_l_9){ ?>
.input-group-text {
	background-color: var(--color-3);
	border: 1px solid #0a3b59;
	color: var(--color-4)!important;
}
<? } ?>
<? if(!isset($_SESSION['login'])||empty($_SESSION['login'])){ ?>
.bg {
	/* The image used */
	background-image: url("<?=$data['Host']?>/images/draw2.webp");
	/* Full height */
	height: 100vh;
	/* Center and scale the image nicely */
	background-position: center;
	background-repeat: no-repeat;
	background-size: cover;
	float: left;
	width: 100%;
}
body {
	background: url("<?=$data['Host']?>/images/draw2.webp") !important;
	height: 100vh;
	background-position: center;
	background-repeat: no-repeat;
	background-size: cover !important;
	width: 100%;
	
}
.container.bodycontainer {
	max-width: 100%;
}
<? } ?>

/*scroll bar*/ 
html{scrollbar-color:#cfcfcf #5d008f; --scrollbarbg:#cfcfcf; --thumbbg:#5d008f;}
body::-webkit-scrollbar{width:5px;}
body{scrollbar-width:thin;scrollbar-color:var(--thumbBG) var(--scrollbarBG)}
body::-webkit-scrollbar-track{background:var(--scrollbarBG);}
body::-webkit-scrollbar-thumb{background-color:var(--thumbBG);border-radius:6px;border:1px solid var(--scrollbarBG);}

.tbl_exl2,.table-responsive{overflow-y:auto;scrollbar-color:#5d008f #cfcfcf;scrollbar-width:thin;border-radius:6px}
::-webkit-scrollbar{width:6px;height:6px;}
::-webkit-scrollbar-track{-webkit-box-shadow:inset 0 0 6px rgba(0,0,0,0.3);-webkit-border-radius:10px;border-radius:10px;}
::-webkit-scrollbar-thumb{-webkit-border-radius:10px;border-radius:10px;background:#5d008f;-webkit-box-shadow:inset 0 0 6px rgba(0,0,0,0.5);}
::-webkit-scrollbar-thumb:window-inactive{background:#5d008f;}
.invisible-scrollbar::-webkit-scrollbar {
  display: none;
}

.navbar.navbar-expand-lg.navbar-light.text-dark {z-index: 999;}
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
	
	//$data['themeName']=$theme_color;
	//$_SESSION['themeName']=$theme_color;
	
	$data['themeName']='LeftPanel';
	$_SESSION['themeName']=$data['themeName'];
	
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
<?=$domain_server['STYLE'];?>
</style>
<script>
function s(){window.status="processing...";return true;};if(document.layers)document.captureEvents(Event.MOUSEOVER|Event.MOUSEOUT|Event.CLICK|Event.DBLCLICK);document.onmouseover=s;document.onmouseout=s;
 </script>
 
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
function chosen_no_resultsf(e,theId){
	var spanVar=$(e).find('span').text();
	//if(theId==='search_key_text'){

		//alert(spanVar);

		$("#"+theId).append('<option value="'+spanVar+'" selected>'+spanVar+'</option>').trigger("change");
		$("#"+theId).trigger("chosen:updated");

		if($("#"+theId+"_hdn").hasClass('hide')){
			$("#"+theId+"_hdn").append('<option value="'+spanVar+'" selected>'+spanVar+'</option>').trigger("change");
		}

	//}
}
function chosen_search_closef(e,theId){
	var spanVar=$(e).prev('span').text();
	spanVar=spanVar.replace(/\s/g, "");
	if($("#"+theId+"_hdn").hasClass('hide')){
		$("#"+theId+"_hdn").find('option:contains('+spanVar+')', this).remove();
	}
	//alert(spanVar);
}
 </script>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Pragma-directive" content="no-cache">
<meta http-equiv="Cache-Directive" content="no-cache">
<meta http-equiv="Expires" content="0">
</head>
<?php 
//echo $data['HideAllMenu'];exit;
$redirect_url=((isset($redirect_url)&&$redirect_url)?$redirect_url:''); 
//$data['HideAllMenu']=((isset($data['HideAllMenu'])&&$data['HideAllMenu'])?$data['HideAllMenu']:''); 
//$redirect_url=((isset($redirect_url)&&$redirect_url)?$redirect_url:''); 
$_SESSION['m_clients_type']=((isset($_SESSION['m_clients_type'])&&$_SESSION['m_clients_type'])?$_SESSION['m_clients_type']:'');
$_SESSION['m_clients_role']=((isset($_SESSION['m_clients_role'])&&$_SESSION['m_clients_role'])?$_SESSION['m_clients_role']:'');

if($_SESSION['dashboard_type']=="payout-dashboar"){ 
$payouttitle="Payout Gateway"; 
$payouticon="fa-solid fa-money-bill-transfer";
$payouticon1="fa-solid fa-check";
$payouticon2="fa-solid fa-credit-card";
$payouticon3="fa-solid fa-qrcode";

}elseif($_SESSION['dashboard_type']=="qrcode-dashboard"){ 

//$payouttitle="QR Gateway"; 
$payouttitle=$data['SOFT_POS_LABELS']; 
$payouticon="fa-solid fa-qrcode";
$payouticon1="fa-solid fa-money-bill-transfer";
$payouticon2="fa-solid fa-credit-card";
$payouticon3="fa-solid fa-check";
}else{ 
$payouttitle="Payment Gateway"; 
$payouticon="fa-solid fa-credit-card";
$payouticon1="fa-solid fa-money-bill-transfer";
$payouticon2="fa-solid fa-check";
$payouticon3="fa-solid fa-qrcode";
}
?>
<body  class="d-flex flex-column h-100 <?=$data['PageFile']?> <?=($data['themeName_sys']?$data['themeName_sys'].' ':'')?><?=($data['frontUiName']?$data['frontUiName'].' ':'')?> <?=$redirect_url?> <?=$theme_color;?> hide_menu_<?=((isset($data['HideAllMenu']) &&$data['HideAllMenu'])?$data['HideAllMenu']:'') ;?> <? if((isset($data['themeName'])&&strpos($data['themeName'],'LeftPanel')!==false)||(isset($data['leftPanelBody'])&&$data['leftPanelBody'])){ echo "leftPanelBody";} ?> <?=((isset($is_logo)&&$is_logo)?$is_logo:'');?>">
<div class="switcher-box-mode">
  <div class="clr-box border bg-secondary-subtle">
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
<?php /*?><div class="switcher-box">

  <div class="clr-box border">
<a type="button" data-bs-toggle="dropdown" aria-expanded="false" title="Set Font Size"><i id="font-active" class="<?=$data['fwicon']['a'];?>"></i></a>
  
<ul class="dropdown-menu dropdown-menu-end text-start px-2" aria-labelledby="bd-theme" style="--bs-dropdown-min-width: 8rem;">
<li><button type="button" class="dropdown-item change_font_size" id="font-plus2" data-code="plus2"><i class="<?=$data['fwicon']['a'];?>"  style="font-size:18px"></i> ++</button></li>
<li><button type="button" class="dropdown-item change_font_size" id="font-plus" data-code="plus" ><i class="<?=$data['fwicon']['a'];?>" style="font-size:16px"></i> +</button></li>
<li><button type="button" class="dropdown-item change_font_size" id="font-minus" data-code="minus"><i class="<?=$data['fwicon']['a'];?>" style="font-size:14px"></i></button></li>
                  
                
              
              
              
            </ul>
  
  </div>
</div><?php */?>


<? if(isset($_SESSION['login']) && (!isset($data['HideAllMenu']) && !isset($data['HideMenu']))){ ?>
<!--<div>-->

<?php if($data['themeName']!='LeftPanel'){ ?>
<? }else{ ?>
<style>
  /*
    DEMO STYLE
*/

.container.border, .bodycontainer {
    min-height: 88%;
}

.navbar {
   /* padding: 15px 10px;*/
    /*background: #fff;
    border: none;
    border-radius: 0;
    margin-bottom: 40px;
    box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.1);*/
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
    /*min-width: 200px;
    max-width: 200px;*/
    width: 200px;
    color: #fff;
    transition: all 0.3s;
	box-shadow: 4px 0px 0px #ffa800;
	border-bottom-right-radius: 30px !important;
	border-top-right-radius:  30px !important;
	z-index:999 !important;
}

#sidebar.active {
    margin-left: 0px;
	width: 40px;
	min-width:40px;
}
#sidebar.active .menu_title {display:none;}
#sidebar.active .dropdown-toggle::after {display:none;}

#sidebar .sidebar-header {
    padding: 20px;
    background: #6d7fcc;
}



#sidebar ul.components {
    padding: 2px 0;
    /*border-bottom: 1px solid #47748b;*/
}
.card {
    border: 0px solid rgba(0,0,0,.125) !important;
}

#sidebar ul p {
    color: #fff;
    padding: 10px;
}

#sidebar ul li a {
    padding: 14px;
	/*padding: 12px;*/
    display: block;
	margin: 2px 0px 0px 5px !important;
}

#sidebar.active ul li a {
    padding: 10px !important;
	width:38px;
}

#sidebar ul li a:hover {
    color: #ffa800 !important; 
	background: #1d1d1d;
	border-radius: 25px;
	margin: 2px 0px 0px 5px;
}
#sidebar.active ul li a:hover {
padding: 10px !important;
margin: 2px 0px 0px 0px !important;
width:38px;
}
#sidebar .active_a {
    color: var(--color-4) !important; /*!important remove on 02122022*/
	background: var(--color-3); /*!important remove on 02122022*/ /*//var(--background-1)!important;*/
	border-radius: 25px;
	margin: 0px 15px 0px 0px;
	position: relative;
    z-index: 2;
	width:100%
}

#sidebar .active_a::before {
    content: ' ';
    background: var(--color-3);
    border-radius: 25px;
    margin: -10px 0 0 0;
    position: absolute;
	z-index: 0;
    left: -41px;
    height: 41px;
    width: 50px;
    line-height: 41px;
}
#sidebar.active .active_a::before {
    background: #000000 !important;
    left: -50px;
    width: 40px;
}
.active_a11::after {
    content: ' ';
    background: var(--color-3) !important;
    border-radius: 0;
    margin: -10px 0 0 0;
    position: absolute;
    left: 134px;
    height: 41px;
    width: 33px;
    line-height: 41px;
    z-index: 0;
}			
/*.active_ap::before {
    content: "-";
    background: green;
    margin: 0px 10px 0px 10px;
    position: absolute;
	
	
}*/

/*#sidebar ul li.active>a,
a[aria-expanded="true"] {
    color: #5d008f;
    background: #6d7fcc;
}*/

a[data-toggle="collapse"] {
    position: relative;
}

.dropdown-toggle::after {
    display: block;
    position: absolute;
    top: 50%;
    right: 5px;
    transform: translateY(-50%);
}

ul ul a {
    padding-left: 30px !important;
    background: #6d7fcc;
}

ul.CTAs {
    padding: 20px;
}

ul.CTAs a {
    text-align: center;
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

/*.fas, .fa-solid{ font-size:10px !important;}*/
/* ---------------------------------------------------
    CONTENT STYLE
----------------------------------------------------- */

#content {
    width: 100%;
	min-height: 100vh !important;
	/*padding-right:5px;*/
	padding-left:5px;
	/*margin-top: 20px;*/
    /*padding: 20px;
    
    transition: all 0.3s;*/
}

/* ---------------------------------------------------
    MEDIAQUERIES
----------------------------------------------------- */

.clearboth_title { clear:both;}


element.style {
}

v.badge {
    padding: 0px 3px 0px 3px !important;
    font-size: 10px !important;
}
a.btn.btn-primary[value="Developer_Page"] {
    display: none !important;
}
.border { border:0px !important;}


/*html #content, body { background: var(--body_bg_color-1)!important;}*/

.container.bg-white, .container.bg-vlight, .container-sm .bg-white  { 
background: var(--body_bg_color-1)!important;
}
#zink_id.bg-white { background: var(--body_bg_color-1)!important; }
.table-responsive { box-shadow: 0px 5px 10px 0px rgba(0, 0, 0, 0.5);}
#sidebar ul.components {
    /*padding-bottom: !important;*/
}

.clearfix_ice{ clear:both !important;}

@media (max-width: 768px) {
    #sidebar {
        /*margin-left: -200px;*/ width:40px;
    }
    #sidebar.active {
        margin-left: 0;
    }
	#sidebar .active_a {
	padding: 10px !important;
	width:38px;
	}
    #sidebarCollapse span {
        display: none;
    }
	.menu_title {display:none;}
	
	#sidebar .active_a::before {
	content: '' !important;
	background:#000000 !important;
	height: 0px  !important;
	}
	#sidebar ul li a:hover {
    padding: 10px !important;
	margin: 2px 0px 0px 0px !important;
	width:38px;
}
	#logoid { width:33px !important; text-align:left!important;}
	#sidebar .image_logo{ display:none !important;}
    #sidebar .image_favicon{ display:block !important;}
	#sidebar {
    margin-left: 0px;
    width: 40px;
    min-width: 40px;
}
#content { width: calc(100% - 40px)!important; }
#sidebar ul li a { padding: 10px !important;}

}

#sidebar.active #logoid { width:33px !important;text-align:left!important;}
.image_logo{ display:block;}
.image_favicon{ display:none;}
#sidebar.active .image_logo{ display:none !important;}
#sidebar.active .image_favicon{ display:block !important;}
.navbar-collapse { margin-top: 0px !important;}
.table-responsive #content{ min-height:10px !important;}

body .btn-primary.template_button{
background: #ffa800 !important;
margin: 0px 5px 5px 5px !important;
padding: 0.25rem 0.5rem !important;
}

body .btn-primary.template_button:hover {
color: #ffffff !important;
background: #ffa800 !important;
border-radius: 0.25rem !important;
}
.template_button ul li a:hover{
color: #ffa800 !important;
background: #ffa800 !important;
}

.template_links, .template_links.active_a{
background: #ffffff !important;
}
#sidebar.active ul li a.template_button {
    padding: 5px !important;
    margin: 2px 2px 5px 0px !important;
    width: 35px;
}
#sidebar ul li a.template_button {
color: #ffffff !important;
}

</style>
  

<script type="text/javascript">
        $(document).ready(function () {
		
            $('#sidebarCollapse').on('click', function () {
                $('#sidebar').toggleClass('active');
				
					if($("#sidebar").hasClass("active")){
					sessionStorage.setItem("jqr_class", "active");
					}else{
					sessionStorage.setItem("jqr_class", "");
					}
					
            });
			
			
			let personName = sessionStorage.getItem("jqr_class");
			$("#sidebar").addClass(personName);
			$('#s_box').addClass('bg-primary p-2');
			$('.alert.alert-success').addClass('clearfix');
        });
		
		
    </script>
<div class="wrapper">
<nav id="sidebar" class="crv_first22 bg-primary"  >
  
  
  <div class="position-fixed" >
  <div class="text-start">
<? if(@$domain_server['LOGOXX']){  ?>
<div class="my-2 centerdiv1">

<a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>" class="img-fluid"  ><img src="<?=encode_imgf($domain_server['LOGO']);?>" id="logoid" ></a>

</div>
	
	<? } ?>
	

<? if($domain_server['LOGO'] && $domain_server['LOGO_ICON']){ ?>

<div class="my-2 image_logo">
<a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>" class="img-fluid mx-2"><img src="<?=encode_imgf($domain_server['LOGO']);?>" id="logoid" class="rounded" style="max-width:80px;"  ></a>
</div>

<div class="my-2 image_favicon">
<a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>" class="img-fluid"><img src="<?=encode_imgf($domain_server['LOGO_ICON']);?>" id="logoid1" height="20px" style="max-width:20px; margin-left:5px;" ></a>
</div>

<? } elseif($domain_server['LOGO'] && !$domain_server['LOGO_ICON']) { ?>

<div class="my-2 centerdiv1">
<a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>" class="img-fluid"  ><img src="<?=encode_imgf($domain_server['LOGO']);?>" id="logoid" style="max-width:125px;" ></a>
</div>

<? } ?>
    
	
	<?php /*?><h1 class="my-2"> </h1>
	<h4 class="mt-4"> <? if($post['user_type']==1){ echo $_SESSION['m_first_name']; }else{ echo $_SESSION['m_company']; } ?></h4><?php */?>
    
  </div>
  <ul class="list-unstyled components position-fixed invisible-scrollbar" style="height:calc(100% - 80px);overflow:hidden;overflow-y:auto;float:left;width:177px;">
     <?
	/*$payout_button=($data['Path']."/front_ui/{$data['frontUiName']}/common/template.merchant_payout_button".$data['iex']);
	if(file_exists($payout_button)){
		include($payout_button);
	}else{
		$payout_button=($data['Path']."/include/template.merchant_payout_button".$data['iex']);
		if(file_exists($payout_button)){
			include($payout_button);
		}
	}*/
   ?>
  

    
    
    <li><a class="text-primary-menu text-decoration-none text-white <?=@$activecss;?>" href="<?=$data['USER_FOLDER']?>/dashboard<?=$data['ex']?>"><i class="<?=$data['fwicon']['home'];?> fa-fw" title="Dashboard"></i> <span class="menu_title">Dashboard</span></a></li>
	
    <li><a class="text-primary-menu text-decoration-none text-white <?=@$activecss_statement;?>" href="<?=$data['USER_FOLDER']?>/statement<?=$data['ex']?>" ><i class="<?=$data['fwicon']['transaction'];?> fa-fw" title="Transaction"></i> <span class="menu_title">Transaction</span></a></li>
	
	
 	  
	
	
    <li><a class="text-primary-menu text-decoration-none text-white" href="<?=$data['USER_FOLDER']?>/invoice<?=$data['ex']?>" ><i class="fas fa-file-invoice fa-fw" title="Invoice"></i> <span class="menu_title">Invoice</span></a></li>
	
	
    <li><a class="text-primary-menu text-decoration-none text-white" href="<?=$data['USER_FOLDER']?>/payment_link<?=$data['ex']?>" ><i class="<?=$data['fwicon']['link'];?> fa-fw" title="Payment Link"></i> <span class="menu_title">Payment Link</span></a></li>
	

	

<li><a class="text-primary-menu text-decoration-none text-white" href="<?=$data['USER_FOLDER']?>/payment_button<?=$data['ex']?>" ><i class="<?=$data['fwicon']['payment_button'];?> fa-fw" title="Payment Button"></i> <span class="menu_title">Payment Button</span></a></li>
	
    
	
    <? if(((in_array(8, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
    <li><a class="text-primary-menu text-decoration-none text-white" href="<?=$data['USER_FOLDER']?>/<?=$data['MYWEBSITEURL']?><?=$data['ex']?>" title="My <?=$data['MYWEBSITE']?>"><i class="<?=$data['fwicon']['website'];?> fa-fw" title="My <?=$data['MYWEBSITE']?>"></i> <span class="menu_title">My <?=$data['MYWEBSITE']?></span></a></li>
	
    <? } ?>
    
<? if(((in_array(7, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
       <li><a class="text-primary-menu text-decoration-none text-white" href="<?=$data['USER_FOLDER']?>/bank<?=$data['ex']?>"><i class="<?=$data['fwicon']['bank'];?> fa-fw" title="Bank Accounts"></i> <span class="menu_title">Bank Accounts</span></a></li>
	    
        <? } ?>
	
	
	      <? if(((in_array(5, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
          <li> <a class="text-primary-menu text-decoration-none text-white" href="<?=$data['USER_FOLDER']?>/manage-user<?=$data['ex']?>"><i class="<?=$data['fwicon']['manage-user'];?> fa-fw" title="User Management"></i> <span class="menu_title">User</span></a> </li>
		  
          <? } ?>
		  
		   <? if(((in_array(17, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
          <li> <a class="text-primary-menu text-decoration-none text-white" href="<?=$data['USER_FOLDER']?>/stats<?=$data['ex']?>"><i class="<?=$data['fwicon']['chart'];?> fa-fw" title="Success Ratio"></i> <span class="menu_title">Success Ratio</span></a> </li>
          <? } ?>
		  

		  <?
		  if($data['con_name']=='clk') $developers='docs';
		  else $developers='developers';
		  ?>

		   
		   <li><a class="text-primary-menu text-decoration-none text-white" href="<?=$data['Host'];?>/<?=(@$developers);?><?=$data['ex']?>" title="Developer Page" target="_blank"><i class="fa-solid fa-book-open-reader fa-fw"></i><span class="menu_title" title="Developer Page">&nbsp;<span class="menu_title">Developer Page</span></span></a></li>
			   
		<? if(((in_array(6, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>	
			<li><a class="text-primary-menu text-decoration-none text-white" href="<?=$data['USER_FOLDER']?>/message<?=$data['ex']?>" title="Support"><i class="fas fa-mail-bulk fa-fw"></i><span class="menu_title" title="Support">&nbsp;<span class="menu_title">Support </span></span></a></li>
		<? } ?>
		
      
	  <?
	$payout_link=($data['Path']."/front_ui/{$data['frontUiName']}/common/template.merchant_payout_link-testttt".$data['iex']);
	if(file_exists($payout_link)){
		include($payout_link);
	}else{
		$payout_link=($data['Path']."/payout/template.merchant_payout_link99".$data['iex']);
		if(file_exists($payout_link)){
			//include($payout_link);
		}
	}
?>

		

		
		
		<? if(!file_exists($payout_link)){ ?>
		   <li><a class="text-primary-menu text-decoration-none text-white" href="<?=$data['USER_FOLDER']?>/payout-coming-soon<?=$data['ex']?>" title="Payout"><i class="fas fa-money-check-alt fa-fw"></i><span class="menu_title" title="Payout">&nbsp;<span class="menu_title">Payout <v class="badge rounded-pill bg-danger fa-beat-fade ">New</v></span></span></a></li>
		<? } ?>

  </ul>
  </div>
</nav>
<!-- Page Content  -->

<div id="content" class="crv_second22">
<nav class="navbar navbar-expand-lg navbar-light text-dark">
  <div class="container" style="width: 100%; clear: both;float: left;">
    <?php if($data['themeName']!='LeftPanel'){ ?>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation" style="float: left;width: 300px;"> <span class="navbar-toggler-icon"></span> </button>
    <? } else { ?>
    <i class="<?=$data['fwicon']['toggle-sidebar'];?>" id="sidebarCollapse" title="Toggle Sidebar" style="float: left;width: 33%;"></i>
    <?php /*?><!--&nbsp;Toggle Sidebar-->
    </span></button><!--<a class="mx-3" style="display: block;float: unset;margin: 0 auto;width: 33%;text-align: center;" >Hi , &#128515; <?=$_SESSION['m_first_name'];?></a>--><?php */?>
    <? } ?>
	
	<? if(isset($data['DB_CON_NAME_DISPLAY_IN_USER'])&&$data['DB_CON_NAME_DISPLAY_IN_USER']=='Y'&&isset($_SESSION['DB_CON_NAME'])&&$_SESSION['DB_CON_NAME']){ ?>
		<div class="navbar-text fw-bold border-watch text-white btn mx-2 text-end px-2 mb-1" style="padding:4px;"><i class="fa-solid fa-database  px-1 fa-fw"></i> <?=$_SESSION['DB_CON_NAME'];?>
		</div>
	<? } ?>
	
    <div class="collapse navbar-collapse" id="navbarSupportedContent" style="float: right;">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0 header_menu_link">
        <?php if($data['themeName']!='LeftPanel'){ ?>
        <li class="nav-item"> <a class="nav-link text-white active" aria-current="page" href="<?=$data['USER_FOLDER']?>/dashboard<?=$data['ex']?>"> Dashboard</a> </li>
        <? if(((in_array(7, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
        <li class="nav-item"> <a class="nav-link text-white" href="<?=$data['USER_FOLDER']?>/bank<?=$data['ex']?>">Account</a> </li>
        <? } ?>
        <? if(((in_array(1, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
        <li class="nav-item"> <a class="nav-link text-white" href="<?=$data['USER_FOLDER']?>/emails<?=$data['ex']?>">Emails</a> </li>
        <? } ?>
        <? if(((in_array(6, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
        <li class="nav-item"> <a class="nav-link text-white" href="<?=$data['USER_FOLDER']?>/message<?=$data['ex']?>">Message</a> </li>
        <? } ?>
        <? if(((in_array(2, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
        <li class="nav-item"> <a class="nav-link text-white" href="<?=$data['USER_FOLDER']?>/account-security<?=$data['ex']?>">Security</a> </li>
        <? } ?>
        <li class="nav-item dropdown"> <a class="nav-link text-white dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false"> Transaction </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
            <? if(((in_array(3, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
            <li><a class="dropdown-item" href="<?=$data['USER_FOLDER']?>/transactions<?=$data['ex']?>">All Transaction</a></li>
            <? } ?>
            <? if(((in_array(4, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
            <li><a class="dropdown-item" href="<?=$data['USER_FOLDER']?>/block_transactions<?=$data['ex']?>">Block Transaction</a></li>
            <? } ?>
            <? if(((in_array(15, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
            <li><a class="dropdown-item" href="<?=$data['USER_FOLDER']?>/test_transactions<?=$data['ex']?>">Test Transaction</a></li>
            <? } ?>
            <? if(((in_array(10, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
            <li><a class="dropdown-item" href="<?=$data['USER_FOLDER']?>/recent_order<?=$data['ex']?>">Recent Order</a></li>
            <? } ?>
            <li>
              <hr class="dropdown-divider">
            </li>
            <? if(((in_array(14, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
            <li><a class="dropdown-item" href="<?=$data['USER_FOLDER']?>/statement<?=$data['ex']?>">Statement</a></li>
            <? } ?>
            <? if(((in_array(16, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
            <li><a class="dropdown-item" href="<?=$data['USER_FOLDER']?>/withdraw-fund-list<?=$data['ex']?>">Withdraw Fund</a></li>
            <? } ?>
          </ul>
        </li>
        <? if(((in_array(8, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
        <li class="nav-item"> <a class="nav-link text-white" href="<?=$data['USER_FOLDER']?>/<?=$data['MYWEBSITEURL']?><?=$data['ex']?>" title="My <?=$data['MYWEBSITE']?>"><?=$data['MYWEBSITE']?></a> </li>
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



      <?
			$account_manager_user_ui=($data['Path']."/front_ui/default/common/account_manager_user_ui".$data['iex']);
			if(file_exists($account_manager_user_ui))
      {
			  include($account_manager_user_ui);
			}
	
			?>

      <? if(@$username){ ?>
	  
	 
	  
	  
	  
      <div class="dropdown badge77 rounded-pill bg-primary p-2"> 
	  <a class="dropdown-toggle bg-dark55 text-white me-3 fw-bold cursor-pointer"  id="VDisplayleft" data-bs-toggle="dropdown" aria-expanded="false" >  
	  

        <i class="fa-regular fa-circle-user"></i> <?=ucwords(strtolower(prntext($get_clientid_details_companyname)));?>
        <?php 
		if((isset($_SESSION['m_clients_name'])&&$_SESSION['m_clients_name'])?$_SESSION['m_clients_name']:''){
		echo "(".$_SESSION['m_clients_name'].")";
		}
		
		?>
        </a>
        <ul class="dropdown-menu dropdown-menu-lg-end" id="VDisplayleft">
<? 
//Dev Tech : 24-02-16 re-modify for switch of more db instance 
if(isset($data['DB_CON_SWITCH_LINK_DISPLAY_IN_USER'])&&$data['DB_CON_SWITCH_LINK_DISPLAY_IN_USER']=='Y'&&isset($data['DB_CON'])) 
more_db_conf('text-dark','text-primary');?> 
		

         
		 <? if(((in_array(2, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
			<li> <a class="dropdown-item text-dark" href="<?=$data['USER_FOLDER']?>/summary-account<?=$data['ex']?>"><i class="fas fa-shield-alt text-primary"></i> Summary Account</a> </li>
          <? } ?>
		  
          <? /* if(((in_array(31, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
          <li> <a class="dropdown-item text-dark" href="<?=$data['USER_FOLDER']?>/account-security<?=$data['ex']?>"><i class="fas fa-shield-alt text-primary"></i> Account Security</a> </li>
          <? } */?>

		  <li> <a class="dropdown-item text-dark" href="<?=$data['USER_FOLDER']?>/myblacklist<?=$data['ex']?>"><i class="fas fa-ban text-primary"></i> Black List Data</a> </li>
		  

		  
		   <? if(((in_array(1, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
        <li > <a class="dropdown-item text-dark" href="<?=$data['USER_FOLDER']?>/emails<?=$data['ex']?>"><i class="fas fa-envelope-open-text text-primary"></i> Emails</a> </li>
        <? } ?>
		
		 <? if(((in_array(9, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
          <li> <a class="dropdown-item text-dark" href="<?=$data['USER_FOLDER']?>/profile<?=$data['ex']?>" ><i class="fa fa-user text-primary"></i> Profile</a> </li>
          <? } ?>
		
		  
		  
		  <?php if($data['themeName']!='LeftPanel'){ ?>
		  
		  
          <? if(((in_array(5, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
          <li class="nav-item"> <a class="nav-link text-dark" href="<?=$data['USER_FOLDER']?>/manage-user<?=$data['ex']?>"><i class="fas fa-user-friends text-primary"></i> User Management</a> </li>
          <? } ?>
		  
		   <? if((isset($post['payout_request'])&&$post['payout_request']!=3)&&(((in_array(20, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']==''))){ ?>
		   <li class="nav-item"> <a class="nav-link text-dark" href="<?=$data['USER_FOLDER']?>/payout-transaction<?=$data['ex']?>"><i class="fas fa-money-check-alt text-primary"></i> Payout</a> </li>
		   <? } ?>
		  
		  
		   <? if(((in_array(17, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
          <li class="nav-item"> <a class="nav-link text-dark" href="<?=$data['USER_FOLDER']?>/stats<?=$data['ex']?>"><i class="fas fa-chart-pie text-primary"></i> Success Ratio</a> </li>
          <? } ?>
		  
		  <? } ?>
		  
         
          <li>
            <hr class="dropdown-divider">
          </li>
          <li><a class="dropdown-item text-dark" href="<?=$data['USER_FOLDER']?>/logout<?=$data['ex']?>"><i class="fas fa-sign-out-alt text-primary"></i> Sign Out</a></li>
        </ul>
      </div>
      <? } else { ?>
      User
      <? } ?>
    </div>
  </div>
</nav>
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
        <div class="dropdown"> <a class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown"> <i class="fa fa-user" aria-hidden="true" ></i> Welcome
          <?=ucwords(strtolower(prntext($username)));?>
          <? if($_SESSION['m_clients_name']<>""){ echo "(".$_SESSION['m_clients_name'].")"; } ?>
          </a>
          <ul class="dropdown-menu">
            <li>
              <hr class="dropdown-divider">
            </li>
            <li><a class="nav-link text-dark" href="<?=$data['USER_FOLDER']?>/logout<?=$data['ex']?>"><i class="fas fa-arrow-right"></i> Sign Out</a></li>
          </ul>
        </div>
        <? } else { ?>
        <i class="fa fa-user" aria-hidden="true" ></i>&nbsp;Welcome User
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
$header_title_search = array("payin-processing-engine", "test3dsecureauthentication", "success", "failed", "developer", "docs", "transaction_processing", "device_confirmations", "forgot", "login", "logout", "signup", "password","confirm","two-factor-authentication","bank","chart","payin-processing-engine","return_url","trans_processing","trans_developer");
$header_title_center = array("login", "forgot", "signup","confirm","password","confirm","confirm","logout","device_confirmations");
$title_position="text-start";
$title_border="vkg-main-border";

if(in_array($data['PageFile'], $header_title_center)){
$title_position="text-center";
$title_border="";
} 

$user_header_main=1;
if(!in_array($data['PageFile'], $header_title_search)) $user_header_main=0;
if(isset($_REQUEST['hd2'])&&$_REQUEST['hd2']==1) $user_header_main=0;
if(isset($data['HideAllMenu'])&&$data['HideAllMenu']==1) $user_header_main=0;
//echo "<br/>user_header_main=>".$user_header_main;	

if($user_header_main==1){?>
<div class="container-flex user_header_main">
  <div class="container py-3 <?=$title_position;?>">
    <h1><a href="index<?=$data['iex'];?>" title="Dashboard"><i class="fas fa-home"></i></a>
      <?=ucwords(strtolower(prntext($data['PageName'])))?>
    </h1>
    <div class="<?=$title_border;?>"></div>
  </div>
</div>
<? }else{ ?>
<!--<div class="my-3"></div>-->
<? } ?>
<? } ?>
<div class="container bodycontainer" >
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>


