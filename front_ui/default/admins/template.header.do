<? if(isset($data['ScriptLoaded'])){ ?>
<?
	if(!isset($_SESSION['mop_option']))
		$_SESSION['mop_option']=mop_option_list_f(1);
	//print_r($_SESSION['mop_option']);

	if(isset($_REQUEST['hideMenu'])){
		$data['HideMenu']=true;
		$data['HideAllMenu']=true;
	}
	if(isset($_REQUEST['hideAllMenu'])){
		$data['HideMenu']=true;
		$data['HideAllMenu']=true;
		$data['HideSearch']=true;
	}
	if(!isset($_GET['time_period'])){
		//$_REQUEST['time_period']=date("Y-m-d 00:00:00",strtotime('-6 days')).' to '.date("Y-m-d 23:59:59");
	}

	$store_name=($data['MYWEBSITE']?$data['MYWEBSITE']:'Website');

	if(isset($_REQUEST['bid'])&&$data['PageFile']=='transactions'){
		$_REQUEST['merchant_details']=$_REQUEST['bid'];
	}
// Store session For Display Payout Menu Added on 07-09-2022 
$_SESSION['admin_dashboard_type']=isset($_SESSION['admin_dashboard_type'])&&$_SESSION['admin_dashboard_type']?$_SESSION['admin_dashboard_type']:'';
if($data['PageFile']=='payout-transaction'){
$_SESSION['admin_dashboard_type']="payout-dashboar";
}
if($data['PageFile']=='index'){
$_SESSION['admin_dashboard_type']="";
}

//echo $_SESSION['admin_dashboard_type'];
///////////////////////////////////


?>
<?
	//$domain_server=domain_serverf("","admin");
	$domain_server=$data['domain_server'];
	if($domain_server['STATUS']==true){
	$ds_pt=$domain_server['PageTitle'];
	$du1=$domain_server['du1'];
	$du2=$domain_server['du2'];
	$data['PageTitle']=str_replace($du1,$du2,$data['PageTitle']);
	$data['SiteTitle']=str_replace($du1,$du2,$data['SiteTitle']);
	$data['SiteDescription']=str_replace($du1,$du2,$data['SiteDescription']);
	$data['SiteKeywords']=str_replace($du1,$du2,$data['SiteKeywords']);
	$data['SiteCopyrights']=str_replace($du1,$du2,$data['SiteCopyrights']);

	$proto_col = isset($_SERVER["HTTPS"])?'https://':'http://';
	$data['home_url']=$proto_col.$_SERVER['SERVER_NAME'];
	if(!empty($domain_server['sub_admin_css'])){
		$_SESSION['admin_theme_color']=$domain_server['sub_admin_css'];
	}

	//echo "<hr/>mailgun_from=>".$domain_server['mailgun_from'];
}
if(isset($data['HostL'])){
	$data['Host']=$data['HostL'];
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<title> <?=$data['PageTitle']?> [ADMINISTRATION AREA]</title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Pragma-directive" content="no-cache">
<meta http-equiv="Cache-Directive" content="no-cache">
<meta http-equiv="Expires" content="0">
<meta http-equiv="Content-Security-Policy" content="default-src 'self'; font-src * 'unsafe-inline'; style-src * 'unsafe-inline'; script-src * 'unsafe-inline' 'unsafe-eval'; img-src * data: 'unsafe-inline'; connect-src * 'unsafe-inline'; frame-src *;">
<? if($domain_server['STATUS']==true&&isset($domain_server['LOGO_ICON'])&&$domain_server['LOGO_ICON']){ ?>
<!-- Favicon -->
<meta name="msapplication-TileImage" content="<?=encode_imgf($domain_server['LOGO_ICON']);?>">
<!-- Windows 8 -->
<meta name="msapplication-TileColor" content="#00CCFF"/>
<!-- Windows 8 color -->
<!--[if IE]><link rel="shortcut icon" href="<?=encode_imgf($domain_server['LOGO_ICON']);?>"><![endif]-->
<link rel="icon" type="image/png" href="<?=encode_imgf($domain_server['LOGO_ICON']);?>">
<? } ?>
<? if($data['con_name']=='clk1'){ ?>
<link rel="shortcut icon" href="<?=$data['Host']?>/images/fev_clk.png" type="image/x-icon">
<link rel="icon" href="<?=$data['Host']?>/images/fev_clk.png" type="image/x-icon">
<link rel="icon" type="image/png" href="<?=$data['Host']?>/images/fev_clk.png">
<? } ?>


<!-- Meta -->
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />

<script src="<?=$data['TEMPATH']?>/common/js/jquery-3.6.4.min.js"></script>
<link href="<?=$data['TEMPATH']?>/common/css/bootstrap.min.css" rel="stylesheet">
<link href="<?=$data['Host']?>/thirdpartyapp/fontawesome/css/all.min.css" rel="stylesheet">
<script src="<?=$data['TEMPATH']?>/common/js/bootstrap.bundle.min.js"></script>
<link href="<?=$data['TEMPATH']?>/common/css/template-custom.css" rel="stylesheet">
<script src="<?=$data['TEMPATH']?>/common/js/common_use.js" type="text/javascript"></script>
<script src="<?=$data['TEMPATH']?>/common/js/common_use_merchant.js" type="text/javascript"></script>

<script type="text/javascript">function s(){window.status="ADMINISTRATION ARE";return true;};if(document.layers)document.captureEvents(Event.MOUSEOVER|Event.MOUSEOUT|Event.CLICK|Event.DBLCLICK);document.onmouseover=s;document.onmouseout=s;</script>
<?
	if(isset($_GET['ajaxf'])){
		$trans_href="{$data['Admins']}/{$data['trnslist']}2".$data['ex'];
		$ajaxtrans="data-href=\"".$trans_href;
		$trans_target='target="modal_popup3_frame"';
		$trans_datah="data-";
		$trans_class="datahref";
		$_SESSION['trans_href']=$trans_href;
		$_SESSION['trans_datah']=$trans_datah;
		$_SESSION['trans_target']=$trans_target;
		$_SESSION['trans_class']=$trans_class;
	}else{
		$trans_href="{$data['Admins']}/{$data['trnslist']}".$data['ex'];$ajaxtrans="href=\"".$trans_href;$trans_target='';$trans_datah="";$trans_class="";$_SESSION['trans_href']=$trans_href;$_SESSION['trans_datah']=$trans_datah;$_SESSION['trans_target']=$trans_target;$_SESSION['trans_class']=$trans_class;
	}

	if(isset($data['PageFile'])&&$data['PageFile']=='analytic'){
		$search_form_action="{$data['Admins']}/analytic".$data['ex'];
		$se_fa='gra';
	}elseif(isset($data['PageFile'])&&$data['PageFile']=='runtime_graph'){
		$search_form_action="{$data['Admins']}/runtime_graph".$data['ex'];
		$se_fa='runtime_graph';
	}elseif(isset($data['PageFile'])&&$data['PageFile']=='transactiongraph'){
		$search_form_action="{$data['Admins']}/transactiongraph".$data['ex'];
		$se_fa='gra';
	}elseif((isset($data['PageFile'])&&$data['PageFile']=='txn')||isset($data['MULTI_TXT_VIEW'])){
		$search_form_action="{$data['Admins']}/txn".$data['ex'];
		$se_fa='tra';
	}else{
		$search_form_action=$trans_href;
		$se_fa='tra';
	}

?>
<script>var hostPath="<?php echo $data['Host']?>"; var trans_class="<?php echo $trans_class;?>";</script>
<?
$front_ui_panel=isset($domain_server['subadmin']['front_ui_panel'])&&$domain_server['subadmin']['front_ui_panel']?$domain_server['subadmin']['front_ui_panel']:'';
if($front_ui_panel=='Left_Panel'){
	if($data['PageFile']=='login'){

	}else{
		$data['themeName']='LeftPanel';
		$_SESSION['themeName']=$data['themeName'];
	}
}

///////////////////// Default Color Option hardcoaded ////////////////////

$body_bg_color="#ffffff";
$body_text_color="#000000";

$heading_bg_color="#ffffff";;
$heading_text_color="#000000";

// Fetch dynamic template colors
include($data['Path'].'/include/header_color_ux'.$data['iex']);
// Fetch fontawasome icon
include($data['Path'].'/include/fontawasome_icon'.$data['iex']);

//Dev Tech : 23-05-15 fix the bug for default wise get if not define

// include for Adjustment Template Color & size by merchant
include($data['Path'].'/include/color_font_adjustment_ux'.$data['iex']);

// for Seperate header background color and header text color
$seperate_header=($data['Path'].'/front_ui/'.$data['frontUiName'].'/common/header_color_seperate'.$data['iex']);
$seperate_header_def=($data['Path'].'/front_ui/default/common/header_color_seperate'.$data['iex']);
if(file_exists($seperate_header)){
    include($seperate_header);
}
elseif(file_exists($seperate_header_def)){
	include($seperate_header_def);
}
// for search with range and double calender
$cal_search_script=($data['Path']."/front_ui/{$data['frontUiName']}/common/template.cal".$data['iex']);
$cal_search_script_def=($data['Path']."/front_ui/default/common/template.cal".$data['iex']);
if(file_exists($cal_search_script)){
include($cal_search_script);
}elseif(file_exists($cal_search_script_def)){
	include($cal_search_script_def);
}
?>
<style>


.visiting_container{background-color:#fff;padding:10px;margin:0px;border-radius:10px;}
.visiting_header{background-color:#90C040;padding:10px;border-radius:10px 10px 0 0;text-align:center}
.visiting_profile{display:flex;justify-content:space-between;align-items:center;margin-top:20px}
.visiting_image{width:150px;height:auto}
.visiting_info{margin-left:20px}
.visiting_container h3{font-size:20px !important;margin-bottom:5px;color:#333;}
.visiting_details{font-size:16px;color:#666}


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
<? if(isset($hd_b_l_9)&&$hd_b_l_9){ ?>
.input-group-text {
    /*background-color: var(--color-3);
    border: 1px solid <?=$hd_b_l_9?>;
	color: var(--color-4)!important;*/
}
<? } ?>

.row {--bs-gutter-x: 0.5rem;}

</style>

<?

	if(empty($data['theme_color'])){
		$data['theme_color']="white"; //white	orange
	}
	$theme_color=$data['theme_color'];
	$color_f=find_css_color($data['theme_color']);
	$color1=$color_f[0];
	if($color1){
		$color1_ex=explode1(' !important;',$color1);
		$data['background_g']=$color1_ex[0];
		$data['color_g']=str_replace('color:','',$color1_ex[1]);

		if(isset($_GET['clr'])){
			 echo "<hr/>background_g=>".$background_g;
			 echo "<hr/>color_g=>".$color_g;print_r($color1_ex);
		}
	}

   if(isset($_GET['clr'])){
	echo print_r($color1);
   }

$_SESSION['background_g']=$data['background_g'];
$_SESSION['color_g']=$data['color_g'];

?>
<? if(isset($data['addCss'])&&$data['addCss']=='collabsible'){ ?>
<!--Not Use in Default Template-->
<!--<link rel="stylesheet" href="<?=$data['Host']?>/theme/css/collabsible<?=$data['css']?>" />-->
<? } ?>


<!--Chosen Script for advance search and multi select dropdown-->
<script src="<?=$data['TEMPATH']?>/common/css/chosen/chosen.jquery.min.js"></script>
<link href="<?=$data['TEMPATH']?>/common/css/chosen/chosen.min.css" rel="stylesheet"/>


<style>
/*use for Merchant Detail Ratio Realtime calander*/
.datepicker-toggle{float:left;display:inline-block;position:relative;width:18px;height:19px}.datepicker-toggle-button{position:absolute;left:0;top:0;width:100%;height:100%;background:#fff url(<?=$data['Host']?>/images/calendar_2.png);background-size:100%}.datepicker-input{position:absolute;left:0;top:0;width:100%;height:100%;opacity:0;cursor:pointer;box-sizing:border-box}.datepicker-input::-webkit-calendar-picker-indicator{position:absolute;left:0;top:0;width:100%;height:100%;margin:0;padding:0;cursor:pointer}

.content_div {overflow: unset;box-shadow: 0 0px 0px 0 rgb(14 12 12 / 85%);}
#search_bar .chosen-container, html #search_bar .chosen-container {/*width:unset !important;*/width:100% !important;}
.admins #search_keyname.select_cs_2 option{margin:0; padding:0 5px; line-height:normal;}


[type="date"] {
    background: #fff url(<?=$data['Host']?>/images/calendar_2.png) 94% 50% no-repeat;
    background-color: rgb(255, 255, 255);
    background-color: rgb(255, 255, 255);
	background-size:18px;
}
[type="date"]::-webkit-inner-spin-button {
  display: none;  width:0px;
}
[type="date"]::-webkit-calendar-picker-indicator {
  opacity: 0; width:30px !important; min-width:30px !important;
}
::-webkit-datetime-edit { padding: 0em; }
::-webkit-datetime-edit-fields-wrapper { background: #fff; }
::-webkit-datetime-edit-text { color: red; padding: 0 0em; }
::-webkit-datetime-edit-month-field { color: blue; }
::-webkit-datetime-edit-day-field { color: green; }
::-webkit-datetime-edit-year-field { color: purple; }
::-webkit-inner-spin-button { display: none; }
::-webkit-calendar-picker-indicator {color: green;  }

input55:invalid+span:after {
    content: '✖';
    padding-left: 5px;
}
input55:valid+span:after {
    content: '✓';
    padding-left: 5px;
}

.csearch form {margin-top:5px !important;}

.hide2 {display: none !important;}
.leftsideadmin table {width:190px; text-align: left; float: left;}
.leftsideadmin {background: #e9e9e9; text-align: left; }
.leftsideadmin br {display:none;}
.leftsideadmin br {display:none;}
.leftsideadmin a {text-indent: -15px;display: block;margin: 8px 0 8px 12px; font-size:12px;}
.frame.accor {display:none;}
.frame.accor.active {display:block;}
.col3 {width:400px; -webkit-columns:2;-moz-columns:2; columns:2;}
.content_div {float:left;width:99%;margin:0 0 0 1%;}
.modal_popup3_frame_img_div {display:none;position:absolute;top:50px;z-index:9999;width:100%;}
#modal_popup3_frame_img {display:block;width:30px;margin:0 auto;}

.navbar.main .topnav > li.open .dropdown-menu li:hover ul.dropdown-content {display: block;}
.navbar.main .topnav > li.open .dropdown-menu li:hover > a {background:#fff !important}
.navbar.main .topnav > li.open .dropdown-menu li:hover ul.dropdown-content li a {background:#d0d0d0 !important; }
.navbar.main .topnav > li.open .dropdown-menu li:hover ul.dropdown-content li a:hover {background:#fff !important;}
.navbar.main .topnav > li.open .dropdown-menu li a, .navbar.main .topnav > li.open .dropdown-menu li a:hover {height: 24px; line-height: 24px;}
.navbar.main .topnav > li .dropdown-menu i:before {top: 2px !important; font-size: 14px !important; color: #37a6cd; }
.glyphicons.btn-icon {padding: 5px 7px 5px 35px;}
.glyphicons.btn-icon i:before {width:36px;padding:5px 0 0;}
.opn_tkt {position:absolute;z-index:999;top:5px;right:2px;display:inline-block;width:20px;height:20px;line-height:20px;overflow:hidden;background:red; color:#fff;text-align:center;border-radius:110%;cursor:pointer;font-size:12px;font-weight:bold;}
.opn_tkt:hover {background:#fff;color:red;}
.loading {position:relative;float:left;clear:both;width:90%;margin:75px 0;font-size:16px;text-align:center;padding:5%;line-height:30px;}
.modal_popupframe .navbar.main, .modal_popupframe .adm_tr_2, .modal_popupframe .adm_wel_1, .modal_popupframe .copy {display:none !important;}
.waitxt.plea1{top:33%;width:100px;height: 30px;left:50%;margin:0 0 0 -50px;}
/*27-08-2018*/
.ipDIVbar{  width: 100%;
			height: auto;
			min-height:25px;
			border: 0px solid;
			margin: 0 auto;
			margin-bottom: 0px;
			border-radius: 5px;
			margin-bottom: 10px;
			font-size:12px;
			padding-bottom:10px;
}
.ipDIV{width:48%;padding-left:10px;padding-top:5px;padding-bottom:5px; float:left; font-weight:bold;}
.balanceDIV{width:48%;text-align:right;padding-right:10px;padding-top:5px;padding-bottom:5px; float:right; font-weight:bold;}
.filter_link{width:100%;padding-bottom:10px;float:left;}


<? if(isset($data['frontUiName'])&&in_array($data['frontUiName'],array("ice","ice1"))){ ?>
.navbar.main,body .capl.bg2{background:#fff!important}
.navbar.main .topnav > li > a,.navbar.main .topnav > li .notif li > a{color:#7500a7!important;outline:0!important;font-weight:700}

.lbl-toggle {/*background-color:linear-gradient(to right,#a1a9e7,#ada6f0,#bca2f6,#cf9cf9,#e395f9)!important;background:linear-gradient(to right,#a1a9e7,#ada6f0,#bca2f6,#cf9cf9,#e395f9)!important;color:#fff!important*/}

html .sub_logins, .table thead,table thead tr,ul.pagination li a,.btn-primary6666 {background-image:linear-gradient(to right,#0019dc,#490dcb,#6201bb,#7100ac,#7a009e)!important;background:linear-gradient(to right,#0019dc,#490dcb,#6201bb,#7100ac,#7a009e)!important;color:#fff!important}

A,A:active,A:visited a:hover,a:focus {color:#1c1cb0!important}
A,A:active,A:visited {color:#06C;text-decoration:none}



	<? if($data['PageFile']=='admin_messages'){ ?>
		html main{margin:0 auto;background:transparent;padding:0;border-top:none;margin-bottom:-22px}
		html main h1{color:#999393;margin:0 0 12px;padding:0;font-size:23px;text-shadow:0 0 0 #3f3f3d;position:relative;top:-11px}
		html .container-fluid.fixed{width:100%!important;margin:0!important;padding:0;border:0}
		html input[name=css-tabs]{display:none}
		html a{color:#F29A77}
		html #tabs{padding:0;width:100%;margin-left:0;background:#fff;height:50px;border-bottom:none;box-shadow:none}
		html #tabs::before{content:"";display:block;position:absolute;z-index:-100;width:100%;left:0;margin-top:16px;height:50px;background:#fff}
		html #tabs::after{content:"";display:block;position:absolute;z-index:0;height:50px;width:102px;background:#e395f9;border-radius:10px;transition:transform 400ms}
		.collapsea.btn-primary,.btn-block{background:#fff!important;background-image:#fff!important}
		html #tabs label{position:relative;z-index:100;display:block;float:left;font-size:11px;text-align:center;width:100px;height:100%;border-right:none;cursor:pointer;color:#5d008f}
		html #tabs .glyphicons{padding:0}
		html #tabs .glyphicons i{position:relative;padding:0;float:none;display:block;margin:-14px auto 0;width:20px;height:15px}
		html #tabs .glyphicons i::before{text-align:center;font-size:18px;color:#000;width:20px;height:20px;position:relative}
		html #tabs label:first-child{border-left:none}
		html #tabs label::before{content:"";display:block;height:20px;width:20px;background-position:center;background-repeat:no-repeat;background-size:contain;filter:invert(40%);margin:4px auto}
		html #tabs {background:#ffffff;}
		html .admin_messages #wrapper{width:calc(100% - 70px)!important;padding:0 30px!important;background:#fff}
		html label#tab5{display:none;}
	<? } ?>

<? } ?>

@media(max-width:1270px){
	.csearch1 {position:relative;top:0px;margin-bottom:0px;width:100%;}
	.csearch .visible-desktop {display:none !important;}
}
@media (max-width: 999px){
#content.active { width: calc(100% - 40px) !important;}
.csearch.advSdiv.deskV {float:left;width:98%;margin:0px 0 5px 10px;}
.visible-desktop {display: none!important; }
.col3 {width:300px; -webkit-columns:1;-moz-columns:1; columns:1; left: auto !important; right: -130px !important;}
.leftsideadmin {display: none!important; }
.navbar.main .appbrand {position:relative;left:-10px;width:113px !important;}
.navbar.main .dropdown-menu.clients {right:-50px !important;}
.content_div {overflow-x:scroll;}
.cpi1 {display:none;}
<!--.btn-primary{width: 30%;float: left;padding: 0px;margin-right: 8px;}-->
.filter_link{width: 94%;float: left;height: 45px;padding: 7px;}
/*#cs_form {margin-top: 103px !important;}*/
}

@media (max-width: 767px){
.clients .w50 {width:96% !important;}
}


@media (max-width: 610px){
.filter_link{width: 94%;float: left;height: 45px;padding: 7px;}
}
@media (max-width: 525px){
.ipDIVbar{height:60px;}
.ipDIV,.balanceDIV{width:100%;padding-left:10px;float:left;text-align:left;}
.filter_link{width: 94%;float: left;height: 45px;padding: 7px;}
}
@media (max-width: 410px){.navbar.main .appbrand {display:none!important;}
.filter_link{width: 94%;float: left;height: 45px;padding: 7px;}
}
@media (max-width: 365px){
	.navbar.main .topnav > li > a.glyphicons, .navbar.main .topnav > li .notif li > a.glyphicons {
		padding: 0 10px 0 25px;
	}
}
@media (max-width: 300px){.navbar.main .appbrand {display:none!important;}
.filter_link{width: 94%;float: left;height: 45px;padding: 7px;}
}
</style>
<script>

function GetAcquirerIDfromWebsiteId(webId, cont = '0'){
	var acquirerId=$('#acquirer_id').val();
	//alert(acquirerId);
	if(cont == '2'){
		webId=$('#account_ids').val();
	}
	//alert('webId2=>'+webId+', cont=>'+cont);
	//acquirer-------------
	if(webId !='' ){
		var acquirer_url = "<?=$data['Admins']?>/analytic<?=$data['ex']?>?wid="+webId+"&action=getacquirerid";
		wnf(acquirer_url);
		$.ajax({
			 url:acquirer_url,
			 success:function(data1){
				$('#acquirer_id').html(data1);
				$("#acquirer_id").val(acquirerId).trigger("change");
				$('#acquirer_id').trigger("chosen:updated");
			}
		});
	}else{
		//$('#acquirer_id').html($type_csearchVar);
	}
}
function GetStoreID(){
  var mid=$('#merchant_details').val();
  var webId=$('#account_ids').val();

  var thisurls = "<?=$data['Admins']?>/analytic<?=$data['ex']?>?mid="+mid+"&action=getaccountid";
	wnf(thisurls);
  $.ajax({
		 url:thisurls,
		 success:function(data){
			//alert(data);
			$('#account_ids').html(data);


			$("#account_ids").val(webId).trigger("change");
			$('#account_ids').trigger("chosen:updated");

			GetAcquirerIDfromWebsiteId(webId,'1');


		}
	});

}

function activeslide(){

}

</script>

<script>
$(document).ready(function(){
	activeHerf();

     $("#hide").click(function(){
     $("#search_keyname").hide();
	 $("#simplesearch2").hide();
	 $("#s_main_div").hide(300);
	 $("#advancesearch").show(1000);
	 $('.changemyicon i').attr('class','<?=$data['fwicon']['search-minus'];?> 33');
     $("#hide").hide();
     $("#show").show();

  });

  $("#show").click(function(){
    $("#search_keyname").show();
	$("#simplesearch2").show();
	$("#s_main_div").show(1000);
	$("#advancesearch").hide(300);
	$('.changemyicon i').attr('class','<?=$data['fwicon']['search-plus'];?> 22');
    $("#show").hide();
    $("#hide").show();

  });
});
</script>

<script>

function hashtagf(thevalue){
	if(top.window.location.href==thevalue){
	}else{top.window.location.href=thevalue;}
}
function view_reviewf(theId){
	top.window.location.href="<?=$data['Admins']?>/<?=$data['my_project']?><?=$data['ex']?>?action=select&type=active&store_active="+theId;
}
function opn_tktf(theVal){
	top.window.location.href="<?=$data['Admins']?>/messages<?=$data['ex']?>?filter=1&tab=0&stf="+theVal;
}
function opn_treplyf(){
	if(trans_class=="datahref"){
		datahref("<?=$trans_href;?>?action=select&acquirer=0&status=-1&keyname=19&searchkey=1");
	}else{
		top.window.location.href="<?=$data['Admins']?>/<?=$data['trnslist'];?><?=$data['ex']?>?action=select&acquirer=0&status=-1&keyname=19&searchkey=1";
	}
}
function opn_tr_calc_skip(){
	if(trans_class=="datahref"){
		datahref("<?=$trans_href;?>?action=select&acquirer=0&status=-1&keyname=224&searchkey=1");
	}else{
		top.window.location.href="<?=$data['Admins']?>/<?=$data['trnslist'];?><?=$data['ex']?>?action=select&acquirer=0&status=-1&keyname=224&searchkey=1";
	}
}

// for header watch time format
function formatAMPM(date) {
	var hours = date.getHours();
	var minutes = date.getMinutes();
	var seconds = date.getSeconds();
	var ampm = hours >= 12 ? 'PM' : 'AM';
	hours = hours % 12;
	hours = hours ? hours : 12; // the hour '0' should be '12'
	hours = hours < 10 ? '0'+hours : hours;
	minutes = minutes < 10 ? '0'+minutes : minutes;
	seconds = seconds < 10 ? '0'+seconds : seconds;
	var strTime = hours + ':' + minutes + ':' + seconds + ' ' + ampm;
	return strTime;
}

function format24(date) {
    var hours = date.getHours();
	var minutes = date.getMinutes();
	var seconds = date.getSeconds();
	//var ampm = hours >= 12 ? 'PM' : 'AM';
	hours = hours % 24;
	hours = hours ? hours : 0; // the hour '0' should be '12'
	hours = hours < 10 ? '0'+hours : hours;
	minutes = minutes < 10 ? '0'+minutes : minutes;
	seconds = seconds < 10 ? '0'+seconds : seconds;
	var wicon = "<i class='<?=$data['fwicon']['clock'];?>' aria-hidden='true'></i> ";
	//alert (wicon);
	var strTime = wicon + hours + ':' + minutes + ':' + seconds;
	return strTime;
}
function format24_caption(date) {
    var hours = date.getHours();
	var minutes = date.getMinutes();
	var seconds = date.getSeconds();
	//var ampm = hours >= 12 ? 'PM' : 'AM';
	hours = hours % 24;
	hours = hours ? hours : 0; // the hour '0' should be '12'
	hours = hours < 10 ? '0'+hours : hours;
	minutes = minutes < 10 ? '0'+minutes : minutes;
	seconds = seconds < 10 ? '0'+seconds : seconds;
	var strTime = hours + ':' + minutes + ':' + seconds;
	return strTime;
}

$(document).ready(function(){

	<? if(isset($_GET['SEARCH'])){ ?>
		$('.abvSearch').trigger('click');
		//setTimeout( $('.abvSearch').trigger('click') , 5000);
	<? } ?>

	<? if(isset($data['themeName'])&&$data['themeName']=='LeftPanel'){ ?>
		$('body').addClass('is_leftPanel');
  	<? } ?>

	$('.mprofile').click(function(){
		var subqry=$.trim($(this).text());
		var mid = $(this).attr('data-mid');
		if(mid !== undefined){subqry=$.trim(mid);}
		$('.mprofile').removeClass('mactive');
		$(this).addClass('mactive');

		var urls="<?=$data['Admins']?>/<?=$data['my_project']?><?=$data['ex']?>?action=detail&admin=1&hideAllMenu=1&type=active&id="+subqry;
		$("#modal_popup_iframe_div").html("<div class='loading'>Now loading url is : "+urls+".<br/><br/><img src='<?php echo $data['Host']?>/images/icons/loading_spin_icon.gif' style='width:270px;position:relative;top:-180px;'> <div class='waitxt plea1'>Please wait...</div></div>");
		var mprofiledata='<iframe name="modal_popupframe" id="modal_popupframe" src='+urls+' width="100%" height="520" scrolling="auto" frameborder="0" marginwidth="0" marginheight="0" style="width:100%!important;height:520px!important;display:block;margin:20px auto;" ></iframe>';

		$("#modal_popup_iframe_div").html(mprofiledata);

		/*
		$.ajax({url:urls, success: function(result){
			$("#modal_popup_iframe_div").html(mprofiledata);
		}});
		*/

		$('#modal_popup_popup').slideDown(900);
    });

    $('.main_conf_tab a').click(function(){
	  var thevalue = "<?=$data['Admins']?>/main-conf<?=$data['ex']?>#general";
		if(top.window.location.href==thevalue){

		}else{
			top.window.location.href=thevalue;
		}

		var hash_id =  $(this).attr('href');
		var var_id =  $(this).attr('href').replace("#", "");
		$('.accor').removeClass('active');
		$('.accor').slideUp(100);

		$(hash_id+'_accordion').slideDown(700);
		//$(hash_id+'_accordion').addClass('active');
		//alert(elementIdToScroll);

		//$('html,body').animate({scrollTop: $(hash_id).offset().top},'slow');

	});

	<? if(isset($data['TimeZone'])&&$data['TimeZone']){?>
			var d = new Date().toLocaleString("en-US", {timeZone: "<?=$data['TimeZone'];?>"});
		<? }else{ ?>
			var d = new Date().toLocaleString("en-US", {timeZone: "Asia/Singapore"});
		<? } ?>
		d = new Date(d);
		 //document.getElementById("jqclock").innerHTML = formatAMPM(d);
		// $('#jqclock').html(formatAMPM(d));
		 var clocktitle = format24_caption(d).concat(" GMT+8");
		 $('#jqclock').attr('title',clocktitle);

		 $('#jqclock').html(format24(d));

	setInterval(function() {

		<? if(isset($data['TimeZone'])&&$data['TimeZone']){?>
			var d = new Date().toLocaleString("en-US", {timeZone: "<?=$data['TimeZone'];?>"});
		<? }else{ ?>
			var d = new Date().toLocaleString("en-US", {timeZone: "Asia/Singapore"});
		<? } ?>
		d = new Date(d);
		 //document.getElementById("jqclock").innerHTML = formatAMPM(d);
		 //$('#jqclock').attr('title',formatAMPM(d));
		 var clocktitle = format24_caption(d).concat(" GMT+8");
		 $('#jqclock').attr('title',clocktitle);
		 $('#jqclock').html(format24(d));

	}, 1000);



	<?
	if(isset($_REQUEST['merchant_details'])||isset($_REQUEST['bid'])){ ?>
		 GetStoreID();
	<? } if(isset($_REQUEST['storeid'])){ ?>
		setTimeout(function(){

			chosen_more_value_f("account_ids",[<?=('"'.implodes('", "',$_REQUEST['storeid']).'"');?>]);
			
			map_f1('#account_ids');
			
		}, 1000);
		
	<? } if(isset($_REQUEST['acquirer'])){

		// Search value and delete
		$acquirer_get=$_REQUEST['acquirer'];
		if(is_array($acquirer_get)&&($key = array_search("0", $acquirer_get)) !== false)
			unset($acquirer_get[$key]);
		elseif(is_string($acquirer_get)&&$acquirer_get==0)
			unset($acquirer_get);

		if(isset($acquirer_get)&&$acquirer_get)
		$acquirer_imp=('"'.implodes('", "',$acquirer_get).'"');

		//echo "<br/>acquirer_imp=>".$acquirer_imp;
		//$acquirer_imp=str_replace([', "0"','"0",','"0"'],'',$acquirer_imp);
		//echo "<br/>acquirer_imp=>".$acquirer_imp;


		if(isset($acquirer_imp)&&$acquirer_imp)
		{
	?>
		setTimeout(function(){

			chosen_more_value_f("acquirer_id",[<?=($acquirer_imp);?>]);
			map_f1('#acquirer_id');

		}, 2000);
	<? }} ?>



	setTimeout(function(){
		<? if(isset($_REQUEST['merchant_details'])&&$_REQUEST['merchant_details']){ ?>
		chosen_more_value_f("merchant_details",[<?=('"'.implodes('", "',$_REQUEST['merchant_details']).'"');?>],'no');
		<?  } ?>


	}, 100);


	$("#search_key_text").chosen({
		no_results_text: "Add More: "
	});

	$(".chosen-select").chosen({
	  no_results_text: "Oops, nothing found!"
	});

	setTimeout(function(){
		$("#search_bar").show(100);
	}, 50);


	$('.clear').click(function (ev) {
		var r = confirm("Are you sure to clear?");
		if (r == true || r === true) {
		  //txt = "You pressed OK!";
		   ev.preventDefault();
			$('#search_bar').find(".filter_option").each(function(i, v) {
				//alert($(this).val());
				$(this).val("");

				var checked =  $(this).is(":checked");
				if(checked){
				 $(this).prop('checked', false);
				 $(this).attr('checked', false);
				}

				if($(this).hasClass('checked')){
					$(this).prop('checked', true);
					$(this).attr('checked', true);
				}

			});
			$(".chosen-select,.chosen-select1").val('').trigger("change");
			$('.chosen-select,.chosen-select1').trigger("chosen:updated");
		} else {
		  //txt = "You pressed Cancel!";
		}


	});




	/*
	setTimeout(function(){
		$('#search_key_text_chosen .chosen-search-input.default').on('keyup keypress keydown', function(e) {
			//alert($(this).val());
		});
	}, 1500);
	*/







});




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

<style>

.tooltip-inner {color:#ffffff !important; }
.hide_menu_1.admins .content_div {
    width: 100% !important;
    padding: 0px;
    padding-top: 0px;
    border-radius: 0px;
    float: none !important;
    margin: 0 auto !important;
	box-shadow: 0 0px 0px 0 rgba(14, 12, 12, 0.85);
}
.hide_menu_1.admins {
    padding: 0;
}

body .btn-primary:hover {
    color: var(--color-3)!important;
    border-color: var(--border-color-1) !important;
    background: var(--color-4) !important;
}

.container.border.rounded:not(.admin_header_main) {min-height: calc(100vh - 170px);}
</style>
<style type="text/css">
<?=$domain_server['STYLE'];?>
</style>
</head>
<?
if(isset($_SESSION['admin_dashboard_type'])&&$_SESSION['admin_dashboard_type']=="payout-dashboar"){
$payouttitle="Payout Gateway";
$payouticon=$data['fwicon']['money-bill-transfer'];
$payouticon1=$data['fwicon']['check-circle'];
$payouticon2=$data['fwicon']['credit-card'];
}else{
$payouttitle="Payment Gateway";
$payouticon=$data['fwicon']['credit-card'];
$payouticon1=$data['fwicon']['money-bill-transfer'];
$payouticon2=$data['fwicon']['check-circle'];
}

?>
<? $data['themeName']=((isset($data['themeName']) &&$data['themeName'])?$data['themeName']:'')?>

<body class="d-flex flex-column h-100 admins <?=isset($data['PageFile2'])&&$data['PageFile2']?$data['PageFile2']:''?> <?=$data['PageFile']?> bnav <?=$theme_color;?> hide_menu_<?=isset($data['HideAllMenu'])&&$data['HideAllMenu']?$data['HideAllMenu']:'';?> <? if((strpos($data['themeName'],'LeftPanel')!==false)||(isset($data['leftPanelBody'])&&$data['leftPanelBody'])){ echo "leftPanelBody";} ?>" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">

<div class="switcher-box-mode">
  <div class="clr-box border">
  <a type="button" data-bs-toggle="dropdown" aria-expanded="false">
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


<script>if(window.name=="modal_popupframe"){$('html,body').addClass('modal_popupframe');}</script>
<?

if(isset($_GET['HideMenu'])&&$_GET['HideMenu']==1){$data['HideMenu']=1;
	    $data['HideMenu']=true;
		$data['HideAllMenu']=true;
		$data['HideSearch']=true;
}

?>
<?php if(isset($data['HideMenu'])&&$data['HideMenu']){?>
<style>
.container, .container-lg, .container-md, .container-sm, .container-xl {
max-width: 100%;
}
</style>

<? } ?>
<? if(!isset($data['HideMenu'])){ ?>


<nav class="navbar navbar-expand-lg navbar-light bg-light5 bg-primary text-white">
  <div class="container">
    <? if(($data['hdr_logo'])&&($domain_server['LOGO'])){ ?>
    <a href="<?=$data['Admins']?>/index<?=$data['ex']?>" class="img-fluid"><img src="<?=encode_imgf($domain_server['LOGO']);?>" style="height:30px;padding-right: 10px;"></a>
    <? } ?>
	<?php if($data['themeName']!='LeftPanel'){ ?>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"> <i class="<?=$data['fwicon']['toggle-sidebar'];?>" title="Toggle Sidebar" ></i> </button>
	<? } else { ?>
    <button type="button" id="sidebarCollapse" class="btn btn-primary me-1" autocomplete="off"><i class="<?=$data['fwicon']['toggle-sidebar'];?>" title="Toggle Sidebar" ></i><span><!--&nbsp;Toggle Sidebar--></span></button>
<script>
 $("#sidebarCollapse").click(function(){
  if($('#sidebar').hasClass('active')){
  		$('body').addClass('is_leftPanel');

  }else{
  	$('body').removeClass('is_leftPanel');
  }
  //alert("The paragraph was clicked.");
  //$("#sidebar").find('bg-primary active')
   // $('#listdivid').css('width', '81vw');
});
</script>
    <? } ?>
	
	<?php if(isset($_SESSION['DB_CON_NAME'])&&$_SESSION['DB_CON_NAME']){ ?>
		<div class="navbar-text fw-bold border-watch text-white btn mx-2 text-end px-2 mb-1" style="padding:4px;"><i class="fa-solid fa-database  px-1 fa-fw"></i> <?=$_SESSION['DB_CON_NAME'];?>
		</div>
	<? } ?>
	
    <div class="welcome collapse navbar-collapse bg-primary77 text-white" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0 header_menu_link">
	  <?php if($data['themeName']!='LeftPanel'){ ?>



<?

		$payout_button=($data['Path']."/front_ui/{$data['frontUiName']}/common/template.admin_payout_button".$data['iex']);
		if(file_exists($payout_button)){
		include($payout_button);
		}else{
		$payout_button=($data['Path']."/payout/template.admin_payout_button".$data['iex']);
		if(file_exists($payout_button)){
		include($payout_button);
		}}

?>
	  <? if(isset($_SESSION['admin_dashboard_type'])&&$_SESSION['admin_dashboard_type']=="payout-dashboar"){ ?>

		<?
		$payout_link=($data['Path']."/front_ui/{$data['frontUiName']}/common/template.admin_payout_link".$data['iex']);
		if(file_exists($payout_link)){
		include($payout_link);
		}else{
		$payout_link=($data['Path']."/payout/template.admin_payout_link".$data['iex']);
		if(file_exists($payout_link)){
		include($payout_link);
		}
		}
		?>
	    <? }else{ ?>

        <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['acquirer_group'])&&$_SESSION['acquirer_group']==1)){ ?>
		<li class="nav-item dropdown ">
            <a class="nav-link text-white dropdown-toggle pointer" data-bs-toggle="dropdown" data-bs-auto-close="outside"><i class="<?=$data['fwicon']['transaction'];?>"></i> Transaction</a>
            <ul class="dropdown-menu">
             <li class="dropend">


<a class="dropdown-item" href="<?=$data['Admins'];?>/<?=$data['trnslist'];?><?=$data['ex']?>?acquirer=0&status=-1&action=select"><i class="<?=$data['fwicon']['transaction'];?>"></i> All Transaction</a>

<?
foreach($data['TransactionStatus'] as $tr => $tr_value) {
?>
<a class="dropdown-item" href="<?=$data['Admins'];?>/<?=$data['trnslist'];?><?=$data['ex']?>?acquirer=0&status=<?=$tr;?>&action=select"><i class="<?=$data['fwicon']['transaction'];?>"></i> <?=$tr_value;?></a>
<?
}
?>

<a class="dropdown-item" href="<?=$data['Admins'];?>/<?=$data['trnslist'];?><?=$data['ex']?>?acquirer=2&status=-1&action=select"><i class="<?=$data['fwicon']['transaction'];?>"></i> All Withdraw</a>


<?if(isset($data['CUSTOM_SETTLEMENT_WD_V3'])&&$data['CUSTOM_SETTLEMENT_WD_V3']=='Y'){?>
	<a title="All Withdraw - Custom Settlement" class="dropdown-item" href="<?=$data['Admins'];?>/<?=$data['trnslist'];?>_custom_settlement<?=$data['ex']?>?acquirer=2&status=-1&action=select"><i class="<?=$data['fwicon']['transaction'];?> fa-fw"></i> All Withdraw - Custom S3</a> 
	<a title="All Rolling - Custom Settlement" class="dropdown-item" href="<?=$data['Admins'];?>/<?=$data['trnslist'];?>_custom_settlement<?=$data['ex']?>?acquirer=3&status=-1&action=select"><i class="<?=$data['fwicon']['transaction'];?> fa-fw"></i> All Rolling - Custom S3</a> 
<?}?>

                <!--</ul>-->
              </li>




            </ul>
          </li>



        <? } ?>

        <!-- Email-->
        <? if($data['ztspaypci']==false){ ?>
        <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['email_zoho_etc'])&&$_SESSION['email_zoho_etc']==1)){ ?>
        <li class="nav-item dropdown"> <a class="nav-link text-white dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false"> <i class="<?=$data['fwicon']['email'];?>"></i> Email </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
           <li> <a class="dropdown-item" href="<?=$data['Admins'];?>/emails<?=$data['ex']?>?&action=select&status=0" ><i class="<?=$data['fwicon']['email'];?> px-1 "></i> All Email</a></li>
            <li> <a class="dropdown-item" href="<?=$data['Admins'];?>/emails<?=$data['ex']?>?action=select&status=1"><i class="<?=$data['fwicon']['email'];?> px-1 "></i> Success Email</a></li>
            <li> <a class="dropdown-item" href="<?=$data['Admins'];?>/emails<?=$data['ex']?>?action=select&status=2&type=0" ><i class="<?=$data['fwicon']['email'];?> px-1 "></i> Failed Email</a></li>
          </ul>
        </li>
        <? } ?>
        <? } ?>
        <!-- Merchant-->
        <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_menu_group'])&&$_SESSION['clients_menu_group']==1)){ ?>
        <li class="nav-item dropdown"> <a class="nav-link text-white dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false"> <i class="<?=$data['fwicon']['merchant'];?>"></i> Merchant </a>
          <? if(((isset($_SESSION['login_adm']))||(isset($_SESSION['active'])&&$_SESSION['active']==1))&&(isset($_REQUEST['tms']))){ ?>
          <? $mem_u_r=clients_review_counts(0,' `active`=4 ');?>
          <span class="opn_tkt" title="<?=$store_name;?> Status : Under review"  onClick="view_reviewf('<?=$mem_u_r['clientid'];?>')">
          <?=$mem_u_r['count'];?>
          </span>
          <? $mem_blank=clients_review_counts(0,' `active`=0 ');?>
          <span class="opn_tkt" title="<?=$store_name;?> Status : Blank"  onClick="view_reviewf('<?=$mem_blank['clientid'];?>')" style="right:30px;">
          <?=$mem_blank['count'];?>
          </span>
          <? $mem_appr=clients_review_counts(0,' `active`=1 ');?>
          <span class="opn_tkt" title="<?=$store_name;?> Status : Approved"  onClick="view_reviewf('<?=$mem_appr['clientid'];?>')" style="right:60px;">
          <?=$mem_appr['count'];?>
          </span>
          <? } ?>
          <ul class="dropdown-menu pull-right clients">
            <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['active'])&&$_SESSION['active']==1)){ ?>
            <li> <a class="dropdown-item" href="<?=$data['Admins']?>/<?=$data['my_project']?><?=$data['ex']?>?action=select&type=active"><i class="<?=$data['fwicon']['check-circle'];?> px-1"></i> Active</a></li>
            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['suspended'])&&$_SESSION['suspended']==1)){ ?>
            <li> <a class="dropdown-item" href="<?=$data['Admins']?>/<?=$data['my_project']?><?=$data['ex']?>?action=select&type=suspended" ><i class="<?=$data['fwicon']['suspended'];?> px-1"></i> Suspended</a></li>
            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['closed'])&&$_SESSION['closed']==1)){ ?>
            <li><a class="dropdown-item" href="<?=$data['Admins']?>/<?=$data['my_project']?><?=$data['ex']?>?action=select&type=closed" ><i class="<?=$data['fwicon']['circle-cross'];?>  px-1"></i> Closed</a></li>
            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['submerchant'])&&$_SESSION['submerchant']==1)){ ?>
            <li><a class="dropdown-item" href="<?=$data['Admins']?>/<?=$data['my_project']?><?=$data['ex']?>?action=select&type=submerchant"><i class="<?=$data['fwicon']['user-double'];?> px-1"></i> Sub Merchant</a></li>
            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['unregistered'])&&$_SESSION['unregistered']==1)){ ?>
            <li><a class="dropdown-item" href="<?=$data['Admins']?>/unregistered<?=$data['ex']?>?action=select" ><i class="<?=$data['fwicon']['user-minus'];?> px-1"></i> Un-Registered</a></li>
            <? } if((isset($_SESSION['login_adm']))||(isset($_SESSION['addnew'])&&$_SESSION['addnew']==1)){ ?>
            <li><a class="dropdown-item" href="<?=$data['Admins']?>/<?=$data['my_project']?><?=$data['ex']?>?action=insert" ><i class="<?=$data['fwicon']['user-plus'];?> px-1"></i> Add New</a></li>
            <? } ?>
          </ul>
        </li>
        <? } ?>
        <!-- Sub Admin-->
        <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['sub_admin_menu_group'])&&$_SESSION['sub_admin_menu_group']==1)){ ?>
        <li class="nav-item dropdown"> <a class="nav-link text-white dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false"> <i class="<?=$data['fwicon']['sub-admin'];?>"></i> Sub Admin </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
            <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['add_sub_admin'])&&$_SESSION['add_sub_admin']==1)){ ?>
            <li> <a class="dropdown-item" href="<?=$data['Admins']?>/subadmin<?=$data['ex']?>?action=insert"><i class="<?=$data['fwicon']['add-sub-admin'];?> px-1"></i> Add Sub Admin</a></li>
            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['list_sub_admin'])&&$_SESSION['list_sub_admin']==1)){ ?>
            <li> <a class="dropdown-item" href="<?=$data['Admins']?>/listsubadmin<?=$data['ex']?>?action=select" ><i class="<?=$data['fwicon']['sub-admin-list'];?> px-1  "></i> Sub Admin List</a></li>
            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['create_roles'])&&$_SESSION['create_roles']==1)){ ?>
            <li> <a class="dropdown-item" href="<?=$data['Admins']?>/roles<?=$data['ex']?>?action=insert"><i class="<?=$data['fwicon']['create-roles'];?> px-1"></i> Create Roles</a></li>
            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['list_of_roles'])&&$_SESSION['list_of_roles']==1)){ ?>
            <li style="overflow:hidden;"> <a class="dropdown-item" href="<?=$data['Admins']?>/listroles<?=$data['ex']?>?action=select" ><i class="<?=$data['fwicon']['role-list'];?> px-1"></i> Roles List</a></li>
            <? } ?>
			<? if((isset($data['ACCOUNT_MANAGER_ENABLE'])&&@$data['ACCOUNT_MANAGER_ENABLE']=='Y')&&((isset($_SESSION['login_adm']))||(isset($_SESSION['account_manager'])&&$_SESSION['account_manager']==1))){ ?>
	<li><a class="dropdown-item" href="<?=$data['Admins']?>/account_manager<?=$data['ex']?>"><img src="../images/account_manager_icon_1.png" style="height:18px;" /> Account Manager</a></li>
	<? } ?>
          </ul>
        </li>
        <? } ?>
        <!-- Template-->
        <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['templates_menu_group'])&&$_SESSION['templates_menu_group']==1)){ ?>
        <li class="nav-item dropdown"> <a class="nav-link text-white dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false"> <i class="<?=$data['fwicon']['template'];?>"></i> Templates </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">


	<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['acquirer_table'])&&$_SESSION['acquirer_table']==1)){ ?>
	<li><a class="dropdown-item" href="<?=$data['Admins']?>/acquirer<?=$data['ex']?>"><i class="<?=$data['fwicon']['bank-gateway'];?>    px-1 fa-fw"></i>  Acquirer</a></li>
	<? } ?>

		<?
	if((isset($_SESSION['login_adm']))||(isset($_SESSION['acquirer_template'])&&$_SESSION['acquirer_template']==1)){ ?>
	<li ><a class="dropdown-item" href="<?=$data['Admins']?>/acquirer_template<?=$data['ex']?>" ><i class="<?=$data['fwicon']['pricing-template'];?>   px-1 fa-fw"></i> Acquirer Templates</a></li>
	<? } ?>

		<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['bank_table'])&&$_SESSION['bank_table']==1)){ ?>
	<li><a class="dropdown-item" href="<?=$data['Admins']?>/bank<?=$data['ex']?>"><i class="<?=$data['fwicon']['bank'];?>   px-1 fa-fw"></i>  Bank Table</a></li>
	<? } ?>

		<?php
	if((isset($_SESSION['login_adm']))||(isset($_SESSION['black_list'])&&$_SESSION['black_list']==1)){ ?>
	<li><a class="dropdown-item" href="<?=$data['Admins']?>/blacklist<?=$data['ex']?>"><i class="<?=$data['fwicon']['ban'];?>  px-1 fa-fw"></i>  Black List</a></li>
	<? }?>





	<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['e_mail_templates'])&&$_SESSION['e_mail_templates']==1)){ ?>
	<li><a class="dropdown-item" href="<?=$data['Admins']?>/mail-conf<?=$data['ex']?>"><i class="<?=$data['fwicon']['email-template'];?>  px-1 fa-fw"></i> E-Mail Templates</a></li>
	<? } ?>
	
	<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['graphical_staticstics'])&&$_SESSION['graphical_staticstics']==1)){ ?>
	<li> <a class="dropdown-item" href="<?=$data['Admins']?>/analytic<?=$data['ex']?>" ><i class="<?=$data['fwicon']['graphical-statistics'];?>  px-1 fa-fw"></i> Analytic</a></li>
	<li> <a class="dropdown-item" href="<?=$data['Admins']?>/runtime_graph<?=$data['ex']?>" ><i class="<?=$data['fwicon']['graphical-statistics'];?>  px-1 fa-fw"></i> Runtime Graph</a></li>
	<? } ?>

	<?  if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_category'])&& $_SESSION['merchant_category']==1)){ ?>
	<li><a class="dropdown-item" href="<?=$data['Admins']?>/merchant_category<?=$data['ex']?>"><i class="<?=$data['fwicon']['merchant-category'];?>  px-1 fa-fw"></i>  Merchant Category</a></li>
	<? } ?>

	<?
	if((isset($_SESSION['login_adm']))||(isset($_SESSION['mop_table'])&&$_SESSION['mop_table']==1)){ ?>
	<li ><a class="dropdown-item" href="<?=$data['Admins']?>/mop_template<?=$data['ex']?>" ><i class="<?=$data['fwicon']['money-check-dollar'];?>   px-1 fa-fw"></i> MOP Templates</a></li>
	<? } ?>
	<?

	if(((isset($_SESSION['login_adm']))||(isset($_SESSION['salt_management'])&&$_SESSION['salt_management']==1)) ){ ?>
	<li><a class="dropdown-item" href="<?=$data['Admins']?>/salt_management<?=$data['ex']?>"><i class="<?=$data['fwicon']['salt-management'];?>   px-1 fa-fw"></i> Salt Management</a></li>
	<? } ?>

		<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['transaction_reason'])&&$_SESSION['transaction_reason']==1)){?>
	<li ><a class="dropdown-item" href="<?=$data['Admins']?>/transaction_reason<?=$data['ex']?>"><i class="<?=$data['fwicon']['reason'];?>   px-1 fa-fw"></i> Transaction Reason</a>
	</li>
	<? }?>


	<?
	if((isset($_SESSION['login_adm']))||(isset($_SESSION['transaction_staticstics'])&&$_SESSION['transaction_staticstics']==1)){ ?>
	<li> <a class="dropdown-item" href="<?=$data['Admins']?>/transactiongraph<?=$data['ex']?>" ><i class="<?=$data['fwicon']['transaction-statistics'];?> px-1"></i> Transaction Statistics</a></li>
	<? } ?>
















          </ul>
        </li>
        <? } ?>

		<? } ?>

		<? } ?>
		<? if(isset($_SESSION['login'])&&$_SESSION['login']){
        if(isset($_SESSION['m_username'])&&$_SESSION['m_username']){ $username=$_SESSION['m_username'];
		}elseif(isset($_SESSION['username'])&&$_SESSION['username']){ $username=$_SESSION['username']; }
?>
        <? } else { ?>
        <!--<li class="nav-item"> <a href="<?=$data['Host']?>/signup<?=$data['ex']?>" class="nav-link text-white"><i></i>Sign Up</a> </li>
        <li class="nav-item"> <a href="<?=$data['Host']?>" class="nav-link text-white"><i></i>Login</a> </li>-->
        <? } ?>
      </ul>

      <!-- Admin Section-->
	  <span class="navbar-text" style="padding:0;">
       <div title="Server Time" id="jqclock" class="jqclock clocktime fw-bold border-watch text-white btn mx-2 text-end px-2 mb-1" data-time="<?php echo time(); ?>"></div>
      </span>
      <? if((isset($_SESSION['adm_login']))||(isset($_SESSION['admin_menu_group'])&&$_SESSION['admin_menu_group']==1)){ ?>
     <div class="dropdown mx-2 mb-1"> <a class="btn btn-primary dropdown-toggle33 border-watch  header_menu_link" data-bs-toggle="dropdown" title="Welcome, <?=@$_SESSION['admin_fullname'];?> [<?=@$_SESSION['sub_username'];?>]"> <i class="<?=$data['fwicon']['circle-user'];?>" aria-hidden="true" ></i> <? if(isset($_SESSION['sub_admin_id']) && $_SESSION['sub_admin_id']){?> <?=@$_SESSION['sub_admin_fullname'];?>  <? }else{ ?> Admin <? }?> </a>

        <ul class="dropdown-menu dropdown-menu-end drop-align-left" id="VDisplayleft" aria-labelledby="navbarDropdown" style="min-width:113px !important;">

<? if(isset($_SESSION['sub_admin_id']) && $_SESSION['sub_admin_id']){?>
<li>
<h2 class="mx-2 text-center text-primary">Hi, <?=$_SESSION['sub_username'];?> <?php /*?><span class="text-primary">[<?=$_SESSION['admin_roles_name'];?>]</span><?php */?></h2>
</li>
<li><hr class="dropdown-divider"></li>
<? } ?>
<? if(isset($_SESSION['admin_dashboard_type'])&&$_SESSION['admin_dashboard_type']=="payout-dashboar"){ ?>

<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['bank_table'])&&$_SESSION['bank_table']==1)){ ?>
<li><a class="dropdown-item" href="<?=$data['Admins']?>/bank<?=$data['ex']?>"><i class="<?=$data['fwicon']['bank'];?> px-1 fa-fw"></i> Bank Payout</a></li>
<? } ?>

<? } ?>

<? 
//Dev Tech : 23-11-30 re-modify for switch of more db instance 
more_db_conf();
?> 





		  <!-- Notification-->
        <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['admin_notification'])&&$_SESSION['admin_notification']==1)){ ?>
          <li><a class="dropdown-item" href="<?=$data['Admins']?>/notification<?=$data['ex']?>"><i class="<?=$data['fwicon']['bell'];?>  px-1 fa-fw"></i>  Notification</a></li>
        <? } ?>

          <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['change_password'])&&$_SESSION['change_password']==1)){ ?>
	<? if(isset($_SESSION['sub_admin_id']) && $_SESSION['sub_admin_id']){?>
          <li class="visible-mobile" style="overflow:hidden;"><a class="dropdown-item" href="<?=$data['Admins']?>/password<?=$data['ex']?>"><i class="<?=$data['fwicon']['unlock'];?>  px-1 fa-fw"></i>  Change Password</a></li>
	 <? } ?>
          <? } ?>

          <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['mass_mailing'])&&$_SESSION['mass_mailing']==1)){ ?>
          <li> <a class="dropdown-item" href="<?=$data['Admins']?>/mass-mail<?=$data['ex']?>"><i class="<?=$data['fwicon']['email-mass'];?>  px-1 fa-fw"></i>  Mass Mailing</a></li>

          <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['useful_link'])&&$_SESSION['useful_link']==1)){ ?>
          <li> <a class="dropdown-item" href="<?=$data['Admins']?>/useful_link<?=$data['ex']?>" ><i class="<?=$data['fwicon']['link'];?>  px-1 fa-fw"></i>  Useful Link</a></li>
          <? } ?>
          <? if((!isset($_SESSION['login_adm']))&&(isset($_SESSION['subadmin_pdf_report_link']))&&($_SESSION['subadmin_pdf_report_link']==1)){ ?>
          <li> <a class="dropdown-item"target="associatreport" href="<?=$data['Host']?>/associatreport<?=$data['ex']?>"><span class="visible-desktop" style="font-size: medium;"><i class="<?=$data['fwicon']['report'];?> px-1 fa-fw"></i>  Report </span> </a></li>
          <? }if((!isset($_SESSION['login_adm']))&&(isset($_SESSION['subadmin_profile_link']))&&($_SESSION['subadmin_profile_link']==1)){ ?>
          <li> <a class="dropdown-item" href="<?=$data['Admins']?>/subadmin<?=$data['ex']?>?id=<?=$_SESSION['sub_admin_id'];?>&action=update&page=0"><span class="visible-desktop"><i class="<?=$data['fwicon']['profile'];?> px-1 fa-fw"></i>  Profile </span> </a> </li>
          <? } ?>


<li><hr class="dropdown-divider"></li>
<li><a class="dropdown-item" href="<?=$data['Admins']?>/logout<?=$data['ex']?>"><i class="<?=$data['fwicon']['signout'];?> text-danger px-1 fa-fw"></i>  Sign Out</a></li>


		</ul>

      </div>
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
/*.menu_title { display:none;}*/

#sidebar {
    min-width: 150px;
    width: 160px;
    background: #0071bc;
    color: #fff;
    transition: all 0.3s;
}

#sidebar.active {
    margin-left: 0px;
	width: 40px;
}
#sidebar.active .menu_title {display:none;}
#sidebar.active .dropdown-toggle::after {display:none;}

#sidebar .sidebar-header {
    padding: 20px;
    background: #6d7fcc;
}

#sidebar ul.components {
    /*padding: 20px 0;*/
   /* border-bottom: 1px solid #47748b;*/
}

#sidebar ul p {
    color: #fff;
    padding: 10px;
}

#sidebar ul li a {
    padding: 10px;
    display: block;
}

#sidebar ul li a:hover {
    color: var(--color-1) !important; /*change on 28022023*/
	background: var(--background-1) !important;

}

#sidebar ul li.active>a,
a[aria-expanded99="true"] {
    color: var(--color-3) !important;
	background: var(--color-4) !important;
}

a[data-toggle="collapse"] {
    position: relative;
}

.dropdown-toggle::after {
    display: block;
    position: absolute;
    top: 50%;
    right: 20px;
    transform: translateY(-50%);
}

ul ul a {
	padding: 0.25rem 1rem !important;
    clear: both !important;
    font-weight: 400 !important;
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
	min-height: calc(100vh - 100px);
}

#sidebar > ul {min-height: calc(100vh - 100px);}

 table td:before {
	padding-left:5px;
  }
/* ---------------------------------------------------
    MEDIAQUERIES
----------------------------------------------------- */

@media (max-width: 768px) {
    .is_leftPanel #sidebar, .remove_leftPanel #sidebar {
        margin-left: -160px; /* --- change 150 to 160 on 12102022 by vikash --- */
    }
    #sidebar.active {
        margin-left: 0;
    }
    #sidebarCollapse span {
        display: none;
    }
}
@media (max-width: 406px){

    #payout_button_admin .dropdown-display {inset: -90px 0px 30px 0px !important;}


}
@media (max-width: 999px) {
.welcome.collapse:not(.show) { display: block !important; }
.navbar-collapse {
    flex-basis: unset !important;
    flex-grow: 0 !important;
    margin-top: 0px !important;
}
.navbar-text{display:none !important;}
.navbar-hide{display:none !important;}
.navbar-nav{display:none !important;}
.drop-align-left{right: 0 !important;}
}
  </style>

<?php /*?> js function for set js sesson for manage sidebar short / long on all pages <?php */?>

<script type="text/javascript">
        /*$(document).ready(function () {
            $('#sidebarCollapse').on('click', function () {
                $('#sidebar , #content').toggleClass('active');
				    if($("#sidebar").hasClass("active")){
					$("#sidebar").css("width","40px");
					sessionStorage.setItem("jqr_class", "active");
					}else{
					sessionStorage.setItem("jqr_class", "");
					$("#sidebar").css("width","160px");
					}
            });
			let personName = sessionStorage.getItem("jqr_class");
			$("#sidebar").addClass(personName);
			$('body').attr('style','');
        });*/

		/* For set sidebar width on session */
            $('#sidebarCollapse').on('click', function () {
                $('#sidebar ,#content').toggleClass('active');

				   if($("#sidebar").hasClass("active")){
					sessionStorage.setItem("jqr_class", "active");
					$("#sidebar").css("width","40px");
					$("#sidebar").css("min-width","40px");
					$(".menu_title").hide(50);
					}else{
					sessionStorage.setItem("jqr_class", "");
					$("#sidebar").css("width","160px");
					$(".menu_title").show(50);
					}

            });
			let personName = sessionStorage.getItem("jqr_class");
			$("#sidebar ,#content").addClass(personName);
</script>
<div class="wrapper">
<nav id="sidebar" class="bg-primary">
  <ul class="list-unstyled components mt-2 border-end">



<?php /*?>include payout button when payout active<?php */?>
	<?

		$payout_button=($data['Path']."/front_ui/{$data['frontUiName']}/common/template.admin_payout_button".$data['iex']);
		if(file_exists($payout_button)){
			include($payout_button);
		}else{
			$payout_button=($data['Path']."/payout/template.admin_payout_button".$data['iex']);
			if(file_exists($payout_button)){
				include($payout_button);
			}
		}

?>

<?php /*?>include payout link when payout active<?php */?>
<? if(isset($_SESSION['admin_dashboard_type'])&&$_SESSION['admin_dashboard_type']=="payout-dashboar"){

		$payout_link=($data['Path']."/front_ui/{$data['frontUiName']}/common/template.admin_payout_link".$data['iex']);
		if(file_exists($payout_link)){
		include($payout_link);
		}else{
		$payout_link=($data['Path']."/payout/template.admin_payout_link".$data['iex']);
		if(file_exists($payout_link)){
		include($payout_link);
		}
		}
?>



 <? }else{ ?>
    <li><a class="text-white text-decoration-none" href="<?=$data['Admins']?>/index<?=$data['ex']?>" title="Dashboard"><i class="<?=$data['fwicon']['home'];?> fa-fw"></i> <span class="menu_title">Dashboard</span></a></li>

<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['acquirer_group'])&&$_SESSION['acquirer_group']==1)){ ?>

		<li class="nav-item dropdown">
<a class="nav-link text-white dropdown-toggle pointer" data-bs-toggle="dropdown" data-bs-auto-close="outside" title="Transaction"><i class="<?=$data['fwicon']['transaction'];?> fa-fw"></i> <span class="menu_title">Transaction</span></a>
            <ul class="dropdown-menu ms-1 text-white" style="">
<li class="dropend"><li> <a class="dropdown-item" href="<?=$data['Admins'];?>/<?=$data['trnslist'];?><?=$data['ex']?>?acquirer=0&status=-1&action=select"><i class="<?=$data['fwicon']['transaction'];?> fa-fw"></i> All Transaction</a> </li>

<?php
//asort($data['TransactionStatus']);
foreach($data['TransactionStatus'] as $t => $t_value) {
?>
<li> <a class="dropdown-item" href="<?=$data['Admins'];?>/<?=$data['trnslist'];?><?=$data['ex']?>?acquirer=0&status=<?=$t;?>&action=select"><i class="<?=$data['fwicon']['transaction'];?> fa-fw"></i> <?=$t_value;?></a> </li>
<?php
}
?>
<li> <a class="dropdown-item" href="<?=$data['Admins'];?>/<?=$data['trnslist'];?><?=$data['ex']?>?acquirer=2&status=-1&action=select"><i class="<?=$data['fwicon']['transaction'];?> fa-fw"></i> All Withdraw</a> </li>

<?if(isset($data['CUSTOM_SETTLEMENT_WD_V3'])&&$data['CUSTOM_SETTLEMENT_WD_V3']=='Y'){?>
	<li title="All Withdraw - Custom Settlement"> <a class="dropdown-item" href="<?=$data['Admins'];?>/<?=$data['trnslist'];?>_custom_settlement<?=$data['ex']?>?acquirer=2&status=-1&action=select"><i class="<?=$data['fwicon']['transaction'];?> fa-fw"></i> All Withdraw - Custom S3</a> </li>
	<li title="All Rolling - Custom Settlement"> <a class="dropdown-item" href="<?=$data['Admins'];?>/<?=$data['trnslist'];?>_custom_settlement<?=$data['ex']?>?acquirer=3&status=-1&action=select"><i class="<?=$data['fwicon']['transaction'];?> fa-fw"></i> All Rolling - Custom S3</a> </li>
<?}?>

<li> <a class="dropdown-item" href="<?=$data['Admins'];?>/access_token<?=$data['ex']?>?acquirer=0&status=-1&action=select"><i class="<?=$data['fwicon']['transaction'];?> fa-fw"></i> Access Token</a> </li>

            </ul>
          </li>

        <? } ?>

        <!-- Merchant-->
        <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_menu_group'])&&$_SESSION['clients_menu_group']==1)){ ?>
        <li class="nav-item dropdown"> <a class="nav-link text-white dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false" title="Merchant"> <i class="<?=$data['fwicon']['merchant'];?> fa-fw"></i> <span class="menu_title">Merchant</span> </a>
          <? if(((isset($_SESSION['login_adm']))||(isset($_SESSION['active'])&&$_SESSION['active']==1))&&(isset($_REQUEST['tms']))){ ?>
          <? $mem_u_r=clients_review_counts(0,' `active`=4 ');?>
          <span class="opn_tkt" title="<?=$store_name;?> Status : Under review"  onClick="view_reviewf('<?=$mem_u_r['clientid'];?>')">
          <?=$mem_u_r['count'];?>
          </span>
          <? $mem_blank=clients_review_counts(0,' `active`=0 ');?>
          <span class="opn_tkt" title="<?=$store_name;?> Status : Blank"  onClick="view_reviewf('<?=$mem_blank['clientid'];?>')" style="right:30px;">
          <?=$mem_blank['count'];?>
          </span>
          <? $mem_appr=clients_review_counts(0,' `active`=1 ');?>
          <span class="opn_tkt" title="<?=$store_name;?> Status : Approved"  onClick="view_reviewf('<?=$mem_appr['clientid'];?>')" style="right:60px;">
          <?=$mem_appr['count'];?>
          </span>
          <? } ?>
          <ul class="dropdown-menu pull-right clients ms-1 text-white" style="">
            <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['active'])&&$_SESSION['active']==1)){ ?>
            <li> <a class="dropdown-item" href="<?=$data['Admins']?>/<?=$data['my_project']?><?=$data['ex']?>?action=select&type=active"><i class="<?=$data['fwicon']['check-circle'];?> fa-fw"></i> Active</a></li>


            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['suspended'])&&$_SESSION['suspended']==1)){ ?>
            <li> <a class="dropdown-item" href="<?=$data['Admins']?>/<?=$data['my_project']?><?=$data['ex']?>?action=select&type=suspended" ><i class="<?=$data['fwicon']['suspended'];?> fa-fw"></i> Suspended</a></li>
            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['closed'])&&$_SESSION['closed']==1)){ ?>
            <li><a class="dropdown-item" href="<?=$data['Admins']?>/<?=$data['my_project']?><?=$data['ex']?>?action=select&type=closed" ><i class="<?=$data['fwicon']['circle-cross'];?> fa-fw"></i> Closed</a></li>
            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['submerchant'])&&$_SESSION['submerchant']==1)){ ?>
            <li><a class="dropdown-item" href="<?=$data['Admins']?>/<?=$data['my_project']?><?=$data['ex']?>?action=select&type=submerchant"><i class="<?=$data['fwicon']['user-double'];?> fa-fw"></i> Sub Merchant</a></li>

            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['unregistered'])&&$_SESSION['unregistered']==1)){ ?>
            <li><a class="dropdown-item" href="<?=$data['Admins']?>/unregistered<?=$data['ex']?>?action=select" ><i class="<?=$data['fwicon']['user-minus'];?> fa-fw"></i> Un-Registered</a></li>
            <? } if((isset($_SESSION['login_adm']))||(isset($_SESSION['addnew'])&&$_SESSION['addnew']==1)){ ?>
            <li><a class="dropdown-item" href="<?=$data['Admins']?>/<?=$data['my_project']?><?=$data['ex']?>?action=insert" ><i class="<?=$data['fwicon']['user-plus'];?> fa-fw"></i> Add New</a></li>
            <? } ?>

          </ul>
        </li>
        <? } ?>

        <!-- Sub Admin-->
        <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['sub_admin_menu_group'])&&$_SESSION['sub_admin_menu_group']==1)){ ?>
        <li class="nav-item dropdown"> <a class="nav-link text-white dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false" title="Sub Admin"> <i class="<?=$data['fwicon']['sub-admin'];?> fa-fw"></i> <span class="menu_title">Sub Admin</span> </a>
          <ul class="dropdown-menu ms-1 text-white" aria-labelledby="navbarDropdown"  style="">
            <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['add_sub_admin'])&&$_SESSION['add_sub_admin']==1)){ ?>
            <li> <a class="dropdown-item" href="<?=$data['Admins']?>/subadmin<?=$data['ex']?>?action=insert"><i class="<?=$data['fwicon']['add-sub-admin'];?> fa-fw"></i> Add Sub Admin</a></li>
            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['list_sub_admin'])&&$_SESSION['list_sub_admin']==1)){ ?>
            <li> <a class="dropdown-item" href="<?=$data['Admins']?>/listsubadmin<?=$data['ex']?>?action=select" ><i class="<?=$data['fwicon']['sub-admin-list'];?> fa-fw"></i> Sub Admin List</a></li>
            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['create_roles'])&&$_SESSION['create_roles']==1)){ ?>
            <li> <a class="dropdown-item" href="<?=$data['Admins']?>/roles<?=$data['ex']?>?action=insert"><i class="<?=$data['fwicon']['create-roles'];?> fa-fw"></i> Create Roles</a></li>
            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['list_of_roles'])&&$_SESSION['list_of_roles']==1)){ ?>
            <li style="overflow:hidden;"> <a class="dropdown-item" href="<?=$data['Admins']?>/listroles<?=$data['ex']?>?action=select" ><i class="<?=$data['fwicon']['role-list'];?> px-1 fa-fw"></i> Roles List</a></li>
            <? } ?>
			<? if((isset($data['ACCOUNT_MANAGER_ENABLE'])&&@$data['ACCOUNT_MANAGER_ENABLE']=='Y')&&((isset($_SESSION['login_adm']))||(isset($_SESSION['account_manager'])&&$_SESSION['account_manager']==1))){ ?>
            <li><a class="dropdown-item" href="<?=$data['Admins']?>/account_manager<?=$data['ex']?>"><img src="../images/account_manager_icon_1.png" style="height:18px;" /> Account Manager</a></li>
            <? } ?>
          </ul>
        </li>
        <? } ?>

        <!-- Email-->
        <? if($data['ztspaypci']==false){ ?>
        <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['email_zoho_etc'])&&$_SESSION['email_zoho_etc']==1)){ ?>
        <li class="nav-item dropdown"> <a class="nav-link text-white dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false" title="Email"> <i class="<?=$data['fwicon']['email'];?> fa-fw"></i> <span class="menu_title">Email</span> </a>
          <ul class="dropdown-menu ms-1 text-white" aria-labelledby="navbarDropdown" style="">
            <li> <a class="dropdown-item" href="<?=$data['Admins'];?>/emails<?=$data['ex']?>?&action=select&status=0" ><i class="<?=$data['fwicon']['email'];?> fa-fw"></i> All Email</a></li>
            <li> <a class="dropdown-item" href="<?=$data['Admins'];?>/emails<?=$data['ex']?>?action=select&status=1"><i class="<?=$data['fwicon']['email'];?> fa-fw"></i> Success Email</a></li>
            <li> <a class="dropdown-item" href="<?=$data['Admins'];?>/emails<?=$data['ex']?>?action=select&status=2&type=0" ><i class="<?=$data['fwicon']['email'];?> fa-fw"></i> Failed Email</a></li>
          </ul>
        </li>
        <? } ?>
        <? } ?>

      <!-- Template-->
        <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['templates_menu_group'])&&$_SESSION['templates_menu_group']==1)){ ?>
        <li class="nav-item dropdown"> <a class="nav-link text-white dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false"  title="Templates"> <i class="<?=$data['fwicon']['template'];?> fa-fw"></i> <span class="menu_title">Templates</span> </a>


          <ul class="dropdown-menu ms-1 text-white" aria-labelledby="navbarDropdown" style="">

	     <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['acquirer_template'])&&$_SESSION['acquirer_template']==1)){ ?>
          <li ><a class="dropdown-item" href="<?=$data['Admins']?>/acquirer_template<?=$data['ex']?>" ><i class="<?=$data['fwicon']['pricing-template'];?> fa-fw"></i> Acquirer Templates</a></li>
		  <? } ?>

		  <?php
 if((isset($_SESSION['login_adm']))||(isset($_SESSION['black_list'])&&$_SESSION['black_list']==1)){ ?>
		  <li><a class="dropdown-item" href="<?=$data['Admins']?>/blacklist<?=$data['ex']?>"><i class="<?=$data['fwicon']['ban'];?>  fa-fw"></i>  Black List</a></li>
		<? }?>

		

			

			<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['e_mail_templates'])&&$_SESSION['e_mail_templates']==1)){ ?>
            <li><a class="dropdown-item" href="<?=$data['Admins']?>/mail-conf<?=$data['ex']?>"><i class="<?=$data['fwicon']['email-template'];?> fa-fw"></i> E-Mail Templates</a></li>
            <? } ?>

			<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['graphical_staticstics'])&&$_SESSION['graphical_staticstics']==1)){ ?>
            <li> <a class="dropdown-item" href="<?=$data['Admins']?>/analytic<?=$data['ex']?>" ><i class="<?=$data['fwicon']['graphical-statistics'];?> fa-fw"></i> Analytic</a></li>

            <li> <a class="dropdown-item" href="<?=$data['Admins']?>/runtime_graph<?=$data['ex']?>" ><i class="<?=$data['fwicon']['graphical-statistics'];?> fa-fw"></i> Runtime Graph</a></li>

            <? } ?>

					 <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_category'])&& $_SESSION['merchant_category']==1)){ ?>
<li><a class="dropdown-item" href="<?=$data['Admins']?>/merchant_category<?=$data['ex']?>"><i class="<?=$data['fwicon']['merchant-category'];?> fa-fw"></i>  Merchant Category</a></li>
<? } ?>



		<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['mop_table'])&&$_SESSION['mop_table']==1)){ ?>
          <li ><a class="dropdown-item" href="<?=$data['Admins']?>/mop_template<?=$data['ex']?>" ><i class="<?=$data['fwicon']['money-check-dollar'];?> fa-fw"></i> MOP Templates</a></li>
		  <? } ?>


		            <?
		  if(((isset($_SESSION['login_adm']))||(isset($_SESSION['salt_management'])&&$_SESSION['salt_management']==1)) ){ ?>
          <li><a class="dropdown-item" href="<?=$data['Admins']?>/salt_management<?=$data['ex']?>"><i class="<?=$data['fwicon']['salt-management'];?> fa-fw"></i> Salt Management</a></li>
          <? } ?>


		  		<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['transaction_reason'])&&$_SESSION['transaction_reason']==1)){?>
			<li ><a class="dropdown-item" href="<?=$data['Admins']?>/transaction_reason<?=$data['ex']?>"><i class="<?=$data['fwicon']['reason'];?> fa-fw"></i> Transaction Reason</a>
		  </li>
		<? } ?>


			<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['transaction_staticstics'])&&$_SESSION['transaction_staticstics']==1)){ ?>
			<li> <a class="dropdown-item" href="<?=$data['Admins']?>/transactiongraph<?=$data['ex']?>" ><i class="<?=$data['fwicon']['transaction-statistics'];?> fa-fw"></i> Transaction Statistics</a></li>
		 <? } ?>




          </ul>
        </li>
        <? } ?>

        <!-- Notification-->
        <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['admin_notification'])&&$_SESSION['admin_notification']==1)){ ?>
        <li class="nav-item"> <a class="nav-link text-white" href="<?=$data['Admins']?>/notification<?=$data['ex']?>" title="Notification"> <i class="<?=$data['fwicon']['bell'];?> fa-fw"></i> <span class="menu_title">Notification</span> </a></li>
        <? } ?>

 <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['bank_table'])&&$_SESSION['bank_table']==1)){ ?>
<li class="nav-item"><a class="nav-link text-white" href="<?=$data['Admins']?>/bank_payout<?=$data['ex']?>" title="Bank Payout"><i class="<?=$data['fwicon']['bank'];?> fa-fw"></i> <span class="menu_title">Bank Payout</span></a></li>
 <? } ?>
<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['acquirer_table'])&&$_SESSION['acquirer_table']==1)){ ?>
<li class="nav-item"><a class="nav-link text-white" href="<?=$data['Admins']?>/acquirer<?=$data['ex']?>" title="Acquirer"><i class="<?=$data['fwicon']['bank-gateway'];?> fa-fw"></i> <span class="menu_title">Acquirer</span></a></li>
  <? } ?>



 <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['glossary'])&&$_SESSION['glossary']==1)){ ?>
<li class="nav-item"><a class="nav-link text-white" href="<?=$data['Admins']?>/glossary<?=$data['ex']?>" title="Glossary"><i class="<?=$data['fwicon']['book'];?> fa-fw"></i> <span class="menu_title">Glossary</span></a></li>

 <? } ?>

<? if((!isset($data['SUPPORT_ADMIN_LINK_SKIP']))&&((isset($_SESSION['login_adm']))||(isset($_SESSION['mass_mailing'])&&$_SESSION['mass_mailing']==1))){ ?>
<li class="nav-item"><a class="nav-link text-white" href="<?=$data['Admins']?>/messages<?=$data['ex']?>" title="Support"><i class="<?=$data['fwicon']['support'];?> fa-fw"></i> <span class="menu_title">Support</span></a></li>

 <? } ?>



<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['mass_mailing'])&&$_SESSION['mass_mailing']==1)){ ?>
<li class="nav-item"><a class="nav-link text-white" href="<?=$data['Admins']?>/mass-mail<?=$data['ex']?>" title="Mass Mailing"><i class="<?=$data['fwicon']['email-mass'];?> fa-fw"></i> <span class="menu_title">Mass Mailing</span></a></li>

          <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['useful_link'])&&$_SESSION['useful_link']==1)){ ?>
<li class="nav-item"><a class="nav-link text-white"  href="<?=$data['Admins']?>/useful_link<?=$data['ex']?>" title="Useful Link" ><i class="<?=$data['fwicon']['link'];?> fa-fw"></i> <span class="menu_title">Useful Link</span></a></li>
          <? } ?>

<? } ?>
  </ul>

</nav>
<!-- Page Content  -->
<div id="content" class="">
<? } ?>




<? } ?>


<!-- END IP Address Bar -->
<? if (strpos($data['urlpath'],'/login')===false){ ?>
<div class="container border rounded admin_header_main mt-2" >

 <? if(!isset($data['HideMenu'])){ ?>



<? if(isset($_SESSION['admin_dashboard_type'])&&$_SESSION['admin_dashboard_type']!="payout-dashboar"){ ?>
<!--==============SEARCH START===============-->


<div class="row  my-2 s_section">

<?php /*?><div class="row px-0" id="s_main_div">

<div class="col-sm-6 row p-0">&nbsp;</div>

<div id="simplesearch" class="col-sm-6 row p-0 s_section_search">
<div class="col-sm-6 spacestart" >
<input type="text" id="simplesearch2" name="search_txt" class="search_textbx form-control w-100 mb-1" placeholder="<?=isset($_GET['searchkey'])?$_GET['searchkey']:"Search.."?>" onClick="return false;">

</div>
<div class="col-sm-6 ps-0" >
<div style=" width: calc(100% - 44px);float:left;">
<select name="keyname" id="search_keyname" class="select_cs_2 form-select w-100 mb-1" >
			<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['q_txn_id'])&&$_SESSION['q_txn_id']==1)){ ?>
			  <option value=1 data-holder="Transaction ID" selected="selected">Txn ID</option>
			<? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['q_name'])&&$_SESSION['q_name']==1)){ ?>
			  <option value=2 data-holder="Customer Name" title="Customer Name">Name</option>
			<? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['q_email_merchants'])&&$_SESSION['q_email_merchants']==1)){ ?>
			 <option value=311 data-holder="Email for Merchants" title="Email for Merchants">Email (Merchants)</option>
			<? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['q_email_transaction'])&&$_SESSION['q_email_transaction']==1)){ ?>
			  <option value=3 data-holder="Email for Transaction" title="Email for Transaction">Email (Transaction)</option>
			<? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['q_price'])&&$_SESSION['q_price']==1)){ ?>
			  <option value=4 data-holder="Price for Transaction" title="Price for Transaction">Price</option>
			<? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['q_phone'])&&$_SESSION['q_phone']==1)){ ?>
			  <option value=5 data-holder="Phone for Transaction" title="Phone for Transaction">Phone</option>
			<? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['q_m_orderid'])&&$_SESSION['q_m_orderid']==1)){ ?>
			  <option value=83 data-holder="Tran.M.OrderId" title="Transaction-M.OrderId">M.OrderId</option>
			<? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['q_reason'])&&$_SESSION['q_reason']==1)){ ?>
			  <option value=82 data-holder="Transaction-Bank Reason" title="Transaction-Bank Reason">Reason</option>
			<? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['q_refno'])&&$_SESSION['q_refno']==1)){ ?>
			  <option value=8 data-holder="Bank Reference Number" title="Bank Reference Number">RefNo.</option>
			<? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['q_mid'])&&$_SESSION['q_mid']==1)){ ?>
			  <option value=9 data-holder="Go to Merchant Profile" title="Go to Merchant Profile">MID</option>

			<? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['q_m_login'])&&$_SESSION['q_m_login']==1)){ ?>
			  <option value=91 data-holder="Go to Merchant Auto Login" title="Go to Merchant Auto Login">M.Login</option>
			<? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['q_m_list'])&&$_SESSION['q_m_list']==1)){ ?>
			  <option value=10 data-holder="Go to Merchant Transactions" title="Go to Merchant Transactions">M.List</option>
			<? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['q_mailgun_email'])&&$_SESSION['q_mailgun_email']==1)){ ?>

			 <option value=31 data-holder="Custom Search for MailGun Email" title="Custom Search for MailGun Email">MailGun Email</option>
			<? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['q_message'])&&$_SESSION['q_message']==1)){ ?>
			  <option value=32 data-holder="Custom Search for Message" title="Custom Search for Message">Message</option>
			<? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['q_website_id'])&&$_SESSION['q_website_id']==1)){ ?>
			  <option value=312 data-holder="<?=$store_name;?> ID" title="<?=$store_name;?> ID"><?=$store_name;?> ID</option>
			<? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['q_website'])&&$_SESSION['q_website']==1)){ ?>
			  <option value=313 data-holder="Website in <?=$store_name;?>" title="Website: Business URL in <?=$store_name;?>">Website</option>
			<? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['q_dba_brand_name'])&&$_SESSION['q_dba_brand_name']==1)){ ?>
			  <option value=314 data-holder="DBA/Brand Name in <?=$store_name;?>" title="DBA/Brand Name in <?=$store_name;?>">DBA/Brand Name</option>
			<? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['q_t_notification'])&&$_SESSION['q_t_notification']==1)){ ?>
			  <option value=315 data-holder="Email: T. Notification/CSE" title="Transaction Notification/Customer Service Email in <?=$store_name;?>">Email: T. Notification/CSE </option>
			  <optgroup label="M.Search">
			<? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['q_user_name'])&&$_SESSION['q_user_name']==1)){ ?>
				<option value="un" data-holder="User Name form Merchant Profile"
				title="User Name form Merchant Profile">User name</option>
			<? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['q_first_name'])&&$_SESSION['q_first_name']==1)){ ?>
				<!--<option value="uid" data-holder="User ID form Merchant Profile"
				title="User ID form Merchant Profile">User ID</option>-->
				<option value="fn" data-holder="First name form Merchant Profile"
				title="First name form Merchant Profile">First name</option>
			<? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['q_last_name'])&&$_SESSION['q_last_name']==1)){ ?>
				<option value="ln" data-holder="Last name form Merchant Profile"
				title="Last name form Merchant Profile">Last name</option>
			<? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['q_email'])&&$_SESSION['q_email']==1)){ ?>
				<option value="em" data-holder="E-mail form Merchant Profile"
				title="E-mail form Merchant Profile">E-mail</option>
			<? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['q_company_name'])&&$_SESSION['q_company_name']==1)){ ?>
				<option value="cn" data-holder="Company Name form Merchant Profile"
				title="Company Name form Merchant Profile">Company Name</option>

			  </optgroup>
		  <? } ?>
		</select>
</div>
<div style="width:35px;float:right;">
<a id="hide" class="btn btn-primary abvSearch changemyicon" title="Advance Search" ><i class="<?=$data['fwicon']['search-plus'];?>"></i></a>
</div>
</div>
</div>


</div><?php */?>
<style>
.shwiReslt b {color:#ff8c00;}
</style>

<div class="accordion accordion-flush " id="accordionFlushExample">
 <form class='hide1' name='search_bar' id='search_bar' action="<?=$search_form_action;?>" method="get"  <?=$trans_target;?> novalidate >
  <div class="accordion-item  ">
    <h2 class="accordion-header row btn-primary p-0 pb-1" >
		<button class="accordion-button rounded start-float col me-2" type="button"   data-bs-toggle="collapse" data-bs-target=".multi-collapse" aria-expanded="false" aria-controls="flush-collapseOne flush-collapseOne2">
			<i class="<?=$data['fwicon']['search'];?> mx-2"></i> Advanced Search
		</button>
		<div class="collapse multi-collapse col col-sm-10" id="flush-collapseOne2">
			<div class="row p-0 m-0 shwiReslt" style="font-size: 10px;"> 
				<div class="col-sm-1 pt-2 start-float" style="font-size:14px;width:80px;">Showing Result :</div>
				<div  class="col-sm-11 text-start ps-0 pt-2" >
					
			
					<div class="start-float map_f1" style="font-size: 10px;">
					
						<?if(isset($_REQUEST['date_range'])){
							
							
							//if($se_fa=='gra' && isset($_REQUEST['date_2nd']) && $_REQUEST['date_2nd'])
							if(isset($_REQUEST['date_2nd']) && $_REQUEST['date_2nd'])
							{
								
								$date_2nd=(date('Y-m-d H:i:s',strtotime($_REQUEST['date_2nd'])));
								
								$date_2nd_24=(date('His',strtotime($_REQUEST['date_2nd'])));
								if($date_2nd_24=='000000'||$date_2nd_24=='235959'){
									$date_2nd=(date('Y-m-d 24:00:00',strtotime($_REQUEST['date_2nd'])));
									//echo "<br/>date_2nd_24=>".$date_2nd_24;
									//echo "<br/>date_2nd=>".$date_2nd;
								}
							}
							if(((int)humanizef(date_dif(@$_REQUEST['date_1st'], @$date_2nd, 'year')))>0)
								$humanizef_res='year|month|day|hour|minute|second';
							elseif(((int)humanizef(date_dif(@$_REQUEST['date_1st'], @$date_2nd, 'month')))>0)
								$humanizef_res='month|day|hour|minute|second';
							elseif(((int)humanizef(date_dif(@$_REQUEST['date_1st'], @$date_2nd, 'day')))>0)
								$humanizef_res='day|hour|minute|second';
							else 
								$humanizef_res='hour|minute|second';
							
						?>
							<b><?=(isset($_REQUEST['is_created_date_on'])&&trim($_REQUEST['is_created_date_on'])?'CREATED TIMESTAMP':'UPDATED TIMESTAMP')?> RANGE: </b> <span style="font-size: 14px;"><?=@$_REQUEST['date_range'];?> (<?=@humanizef(date_dif(@$_REQUEST['date_1st'], @$date_2nd, @$humanizef_res))?>) </span> <s>|</s>
						<?}?>
						
						<input type="text" class="form-control col hide" name="date_range" id="date_range_top" placeholder="Custom Date" value="<?=@$_REQUEST['date_range'];?>" style="width:300px;" >
						
						<?if(isset($_REQUEST['merchant_details'])){?>
							<b>MerID: </b> <span id="merchant_details_txt_id" style="font-size: 14px;"> </span>
							<s>|</s>
						<?}?>
	
						<?if(isset($_REQUEST['storeid'])){?>
							<b>TerNO: </b> <span id="account_ids_txt_id" style="font-size: 14px;"> </span>
							<s>|</s>
						<?}?>

						<?if(isset($_REQUEST['acquirer'])&&$_REQUEST['acquirer']!=0){?>
							<b>Acquirer: </b> <span id="acquirer_id_txt_id" style="font-size: 14px;"> </span>
							<s>|</s>
						<?}?>

						<?if(isset($_REQUEST['payment_status'])){?>
							<b>Trans Status: </b> <span id="payment_status_txt_id" style="font-size: 14px;"> </span>
							<s>|</s>
						<?}?>

						<?if(isset($_REQUEST['ccard_types'])){?>
							<b>MOP: </b> <span id="ccard_types_txt_id" style="font-size: 14px;"> </span>
							<s>|</s>
						<?}?>

						<?if(isset($_REQUEST['key_name'])&&isset($_REQUEST['search_key'])&&$_REQUEST['search_key']){?>
							<b>Key Name: </b> <span id="searchkeyname_txt_id" style="font-size: 14px;"> </span>
							<s> & </s>
						
							<b>Search Key: </b> <span id="search_key_text_txt_id" style="font-size: 14px;"><?=((isset($_REQUEST['search_key'])&&is_string($_REQUEST['search_key'])&&(trim($_REQUEST['search_key'])))?$_REQUEST['search_key']:'')?> </span>
							<s>|</s>
						<?}?>

					</div>
				</div>
			</div>
		</div>
    </h2>


    <div id="flush-collapseOne" class="accordion-collapse collapse multi-collapse p-0" >



      <div class="accordion-body p-0">
	  <!--//////////////////////-->
	  <div id="advancesearch" class="col-sm-12 text-start ps-0 pt-2" >

<? if((isset($_SESSION['login_adm'])&&(!isset($data['HideSearch'])))||(isset($_SESSION['search_header'])&&$_SESSION['search_header']==1)){ ?>

<script>$('#search_keyname option[value="<?=((isset($_GET['keyname']) &&$_GET['keyname'])?$_GET['keyname']:'')?>"]').prop('selected','selected');</script>


        <div class="advSdiv deskV <?=$se_fa;?>">



				<? if(isset($_REQUEST['bid'])&&$trans_class!="datahref"){ ?>
				<input type="hidden" name="bid" id="cs_bid" value="<?=$_REQUEST['bid']?>" class="filter_option" />
				<? $_REQUEST['merchant_details']=$_REQUEST['bid'];?>
				<? }elseif($trans_class=="datahref"){ ?>
					<input type="hidden" name="bid" id="cs_bid" value="<?=$_REQUEST['bid']?>" class="filter_option" />
					<input type="hidden" name="ajaxf" id="cs_ajaxf" value="1" />
					<? $_REQUEST['merchant_details']=$_REQUEST['bid'];?>
				<? } ?>

				<? if(isset($_REQUEST['q'])){ ?>
					<input type="hidden" name="q" value="<?=$_REQUEST['q'];?>" class="filter_option" />
				<? } ?>

			<!--//------------------------------------------------>
		<div class="row" id="adv_search_css">

		<?//="is_created_date_on=>".isset($_REQUEST['is_created_date_on'])?prntext($_REQUEST['is_created_date_on']):""?>

                  <input type="hidden" name="is_created_date_on" id="is_created_date_on" class="hide"  style="display:none !important;"  value="<?=isset($_REQUEST['is_created_date_on'])?prntext($_REQUEST['is_created_date_on']):""?>" >

		<div class="col mb-1 input-field">
				 <select id="sortingType" name='sortingType' title='Sorting Type' class='form-control form-control-sm  form-select' required>

				  <option value="1" <?php if((@$_REQUEST["sortingType"]==1)||(@$_REQUEST["sortingType"]=='')||(empty($_REQUEST["sortingType"]))){ echo 'selected="selected"'; } ?> >Available</option>

				   <option value="2" <?php if(isset($_REQUEST["sortingType"])&&$_REQUEST["sortingType"]==2){ echo 'selected="selected"';} ?> >Not Available</option>


				  </select>
				  <label for="sortingType">Sorting Type</label>

		</div>
		<?if(isset($data['PageFile'])&&$data['PageFile']=='analytic'&&isset($_SESSION['login_adm'])){ ?>
		
			<div class="col  mb-1 input-field">
					 <div class="input_s">
					<!-- For Sub Admin -->
					<select id="sub_admin" data-placeholder="[ID] Username | Name" title="[ID] Username | Name" multiple class="form-control form-control-sm chosen-select filter_option inherit_select_classes1 form-control" name="sub_admin[]" onChange1="GetSubAdminID();" required >
					  <?=showselect(((isset($_SESSION['sub_admin'])&&$_SESSION['sub_admin'])?$_SESSION['sub_admin']:''), ((isset($_REQUEST['sub_admin'])&&$_REQUEST['sub_admin'])?$_REQUEST['sub_admin']:''));?>
					</select>
					<label for="sub_admin">Sub Admin</label>
				  </div>
			</div>
		
		<?}?>

		<div class="col  mb-1 input-field">
				 <div class="input_s">
				<!-- For Merchant ID -->
				<select id="merchant_details" data-placeholder="[MerID] Username | M. Name" title="[MerID] Username | M. Name" multiple class="form-control form-control-sm chosen-select filter_option inherit_select_classes1 form-control" name="merchant_details[]" onChange="GetStoreID();" required >
				  <?=showselect(((isset($_SESSION['merchant_details'])&&$_SESSION['merchant_details'])?$_SESSION['merchant_details']:''), ((isset($_REQUEST['merchant_details'])&&$_REQUEST['merchant_details'])?$_REQUEST['merchant_details']:''));?>
				</select>
				<label for="merchant_details">MerID</label>
			  </div>
		</div>

		<div class="col mb-1 input-field">
				 <div id="account_ids1" class="input_s">
				<select id="account_ids" data-placeholder="[TerNO] Business Name [MerID]" multiple required class="form-control form-control-sm chosen-select filter_option form-select" name="storeid[]" title="[TerNO] Business Name [MerID]" onChange="GetAcquirerIDfromWebsiteId('','2');"  >
				</select>
				<label for="account_ids">TerNO</label>
<!--<script>
$("#tid_chosen").css("width", "100%").css("background", "antiquewhite");
$("#tid_chosen").addClass("form-control");
</script>-->
			  </div>
		</div>

				 <div class="col mb-1">
				 <div id="acquirer" class="input_s input-field">
				<select name="acquirer[]" id="acquirer_id" data-placeholder="Acquirer" title="Acquirer" multiple class="form-control form-control-sm chosen-select filter_option form-select" required>
				  <?


					 foreach($data['acquirer_list'] as $key=>$value){
						 if($value>0){
						 ?>
					  <? if((isset($_SESSION['login_adm']))||(($_SESSION['acquirer_ids'])&&(in_array((int)$value, $_SESSION['acquirer_id'], true)))){ ?>
					 <option value="<?=$key;?>" title="<?=$value;?>">
						<?=$value;?>
					  </option>
					<? } ?>
					 <? } } ?>
				   <?
				   if(isset($_REQUEST['acquirer'])&&$_REQUEST['acquirer']){
				   foreach($_REQUEST['acquirer'] as $key=>$value){
					   if((isset($_REQUEST['acquirer']))&&$value>0&&(!in_array($value, $data['acquirer_id'], true))){ ?>
					  <option value="<?=$value;?>" title="<?=$value;?>" selected>
						<?=$value;?>
					  </option>
				   <? }}} ?>
				</select>
				<label for="acquirer_id">Acquirer</label>
			  </div>
				 </div>

		<div class="col mb-1 input-field">
				 <select id="payment_status" data-placeholder="Trans Status" title="Trans Status" multiple class="form-control form-control-sm chosen-select filter_option form-select" name="payment_status[]" required >
				<?

				foreach ($data['TransactionStatus'] as  $key => $value) { ?>
				<option value="<?php echo $key;?>"><?php echo $value;?></option>

				<? } ?>



			  </select>
			   <label for="payment_status">Trans Status</label>

			    <? if(isset($_REQUEST['payment_status'])&&$_REQUEST['payment_status']){ ?>
				  <script>
					chosen_more_value_f("payment_status",[<?=('"'.implodes('", "',$_REQUEST['payment_status']).'"');?>]);
				  </script>
			   <? } ?>
		</div>

		<div class="col mb-1 input-field">
			
			<select id="ccard_types" data-placeholder="MOP" title="MOP" multiple class="form-control form-control-sm  chosen-select filter_option form-select" name="ccard_types[]" required ><?=($_SESSION['mop_option']);?></select>
			<label class="form-label33" for="ccard_types" >MOP </label>
			
			
			  <? if(isset($_REQUEST['ccard_types'])&&$_REQUEST['ccard_types']){ ?>
			  <script>
				chosen_more_value_f("ccard_types",[<?=('"'.implodes('", "',$_REQUEST['ccard_types']).'"');?>]);
				//if(keyname==="tTerNO"||keyname==="tbu"||keyname==="tdba"||keyname==="tnem")
					
			  </script>
			  <? } ?>

		</div>
				 
				 
 <div class="row mt-2">
				 <div class="col-sm-2 mb-1 input-field">
	<select name="key_name" id="searchkeyname"  title="Select key name" class='filter_option form-select form-control form-control-sm ' required >
		<option value="" >Key Name..</option>
		<optgroup label="Mer Search">
			<option value="m_merID" title="Go to Merchant Profile">MerID</option>
			<option value="m_un" title="User Name form Merchant Profile">User name</option>

			<option value="m_fn" title="First name form Merchant Profile">Full Name</option>
			<option value="m_em" title="Registered Email for Merchants">Registered Email</option>
			<option value="m_cn" title="Company Name form Merchant Profile">Company Name</option>

		</optgroup>
		<optgroup label="Ter Search">
			<option value="m_tTerNO" title="Go to Merchant Business via TerNO">TerNO</option>
			<option value="m_tbu" title="Business URL">Business URL</option>
			<option value="m_tdba" title="DBA/Brand Name">DBA</option>
			<option value="m_tnem" title="Transaction Notification Email">Trans. Notification Email</option>
			

		</optgroup>
		<optgroup label="Trans Search"> </optgroup>
		<option value="transID" title="TransID" selected="selected">TransID</option>
		<option value="reference" title="Reference">Reference</option>

		

		<option value="fullname" title="Full Name">Full Name</option>
		<option value="bill_amt" title="Bill Amount">Bill Amount</option>
		<option value="trans_amt" title="Trans Amt">Trans Amt</option>
		<option value="available_balance" title="Available Balance">Available Balance</option>
		<option value="tdate" title="Timestamp">Timestamp</option>
		<option value="mop" title="Visa,MasterCard">MOP</option>
		<option value="trans_response" title="Trans Response">Trans Response</option>
		<option value="acquirer" title="Acquirer No.: 16,18,19,27\">Acquirer</option>
		<option value="trans_status" title="Trans Status: 0,1,2,">Trans Status</option>
		<option value="merID" title="MerID">MerID</option>
		<option value="bill_ip" title="IP">Bill IP</option>
		<option value="terNO" title="TerNO">TerNO</option>
		<option value="acquirer_ref" data-placeholder="Acquirer Ref" title="Acquirer Ref">Acquirer Ref</option>
		<option value="acquirer_response" title="Acquirer Response">Acquirer Response</option>
		<option value="json_value" title="Post Json for Bank">Json Value</option>
		<option value="support_note" title="Note Support">Note Support</option>
		<option value="system_note" title="Note System">Note System</option>
		<option value="source_url" title="Source Url">Source Url</option>
		<option value="webhook_url" title="Webhook Url">Webhook Url</option>
		<option value="return_url" title="Return Url">Return Url</option>
		<option value="buy_mdr_amt" title="Buy MDR Amt">Buy MDR Amt</option>
		<option value="buy_txnfee_amt" title="Buy TxnFee Amt">Buy TxnFee Amt</option>
		<option value="rolling_amt" title="Rolling Amt">Rolling Amt</option>
		<option value="mdr_cb_amt" title="MDR CB Amt">MDR CB Amt</option>
		<option value="mdr_cbk1_amt" title="MDR CBK1 Amt">MDR CBK1 Amt</option>
		<option value="mdr_refundfee_amt" title="MDR RefundFee Amt">MDR RefundFee Amt</option>
		<option value="payable_amt_of_txn" title="Payable Amt of Txn">Payable Amt of Txn</option>
		<option value="settelement_date" title="Settlement Date">Settlement Date</option>
		<option value="created_date" title="Created Date">Created Date</option>
		<option value="risk_ratio" title="Risk Ratio">Risk Ratio</option>
		<option value="transaction_period" title="Transaction Period">Transaction Period</option>
		<option value="bank_processing_amount" title="Bank Processing Amount">Bank Processing Amount</option>
		<option value="bank_processing_curr" title="Bank Processing Currency">Bank Processing Currency</option>
		<option value="bill_currency" title="Bill Currency">Bill Currency</option>
		<option value="ccno" title="Card Number">CCNo</option>
		<option value="rrn" title="RRN">RRN</option>
		<option value="trans_type" title="11,15,19">Trans Type</option>
		<option value="bill_email" title="Email for Transaction">Bill Email</option>
		<option value="bill_phone" title="Phone for Transaction">Bill Phone</option>
		<option value="product_name" title="Product Name">Product Name</option>
		<option value="bill_address" title="Bill Address">Bill Address</option>
		<option value="bill_city" title="Bill City">Bill City</option>
		<option value="bill_state" title="Bill State">Bill State</option>
		<option value="bill_country" title="Bill Country">Bill Country</option>
		<option value="bill_zip" title="Bill Zip">Bill Zip</option>
		<option value="descriptor" title="Descriptor">Descriptor</option>
		<option value="upa" title="Unique Payment Address">UPA</option>
		<? if($data['con_name']=='clk'){ ?>
		<option value="gst_amt" title="GST Amt">GST Amt</option>
		<? } ?>

		<option value="otherAddMore" id="otherAddMore" title="Other - Add more">Other - Add more</option>
		<option value="otherAddSingleString" id="otherAddSingleString" title="Other - Add string" class="hide">Other - Add string</option>
   </select>
			<label for="searchkeyname" >Key Name </label>
		<script>


			<?if(isset($_REQUEST['key_name']) &&$_REQUEST['key_name']){?>
				$('#searchkeyname option[value="<?=((isset($_REQUEST['key_name']) &&$_REQUEST['key_name'])?$_REQUEST['key_name']:'')?>"]').prop('selected','selected');
			<?}?>
				function otherKeyf(thisVal){
					// alert(thisVal);
					 if(thisVal=='otherAddMore'){
						 //alert("111=> "+thisVal);
						$("#search_key_text_input").attr('name','search_key_input_show');
						$("#search_key_text").attr('name','search_key[]');

						$("#search_key_text_div_srt").css({"display":"none"});
						$("#search_key_text_div_more").css({"display":"block"});

						$('#searchkeyname #otherAddMore').hide();
						$('#searchkeyname #otherAddSingleString').show();

					  }
					  else if(thisVal=='otherAddSingleString'){
						//alert("22222=> "+thisVal);
						$("#search_key_text_input").attr('name','search_key');
						$("#search_key_text").attr('name','search_key_more_show');

						$("#search_key_text_div_srt").css({"display":"block"});
						$("#search_key_text_div_more").css({"display":"none"});

						$('#searchkeyname #otherAddMore').show();
						$('#searchkeyname #otherAddSingleString').hide();

					  }

				 }
				
				function map_f1(theIn){
					var selected_txt ='';
					var i =0 ;
					$(theIn+' option:selected').map(function(){
						i++;
					   selected_txt += (i>1?' / ':'')+this.text; 
					}).get();
					
					$(theIn+'_txt_id').html(selected_txt); 
				}

				$(document).ready(function(){

					
					map_f1('#merchant_details');
					map_f1('#payment_status');
					map_f1('#ccard_types');
					map_f1('#searchkeyname');
					
					<?if(isset($_REQUEST['search_key'])&&is_array($_REQUEST['search_key'])&&(count($_REQUEST['search_key'])>0)){?>
						map_f1('#search_key_text');
					<?}?>
					
					//setTimeout(function(){ map_f1('#account_ids'); }, 1000);
					
					
				  $("#searchkeyname").change(function(){
					  var thisVal=$(this).val();
					  otherKeyf(thisVal);


					  if(thisVal=='otherAddMore'){
						 //alert("111=> "+thisVal);

						 $('#searchkeyname option[value="transID"]').prop('selected','selected');
					  }
					  else if(thisVal=='otherAddSingleString'){
						//alert("22222=> "+thisVal);

						 $('#searchkeyname option[value="transID"]').prop('selected','selected');
					  }

				  });


					<?if(isset($_REQUEST['search_key'])&&is_array($_REQUEST['search_key'])&&(count($_REQUEST['search_key'])>0)){?>
						otherKeyf('otherAddMore');

					<?}?>

					<? if(!isset($_GET['time_period'])){

						?>
							//time_periodf('1');
							//$("#time_period option:eq(2)").prop("selected",true).trigger("click");
							//$("#time_period option:eq(2)").prop("selected",true).trigger("change");
					<? } ?>

				});

		</script>
		</div>

				 <div class="col-sm-6 mb-1">
				 
					 
					<div id="search_key_text_div_srt" class="input-field">
					
						<input type="text" id="search_key_text_input" name="search_key" class="form-control form-control-sm mb-1 filter_option "  onclick="return false;" value="<?=((isset($_REQUEST['search_key'])&&is_string($_REQUEST['search_key'])&&(trim($_REQUEST['search_key'])))?$_REQUEST['search_key']:'');?>" required="false" autocomplete="off" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Enter Search key" style="padding: 6px 8px;" >
						
						 <label for="search_key_text_input">Search key</label>
						 
					</div>

					<div id="search_key_text_div_more" class="input-field hide">
						
						 <select id="search_key_text" placeholder="Add More for Multiple search key" title="Add More for Multiple search key" multiple class="form-control form-control-sm chosen-select1 filter_option form-select" name="search_key_more_show" required >
						  <? if(!empty(@$_REQUEST['search_key'])&&is_array($_REQUEST['search_key'])){
							  foreach(@$_REQUEST['search_key'] as $key=>$val){
						  ?>
							<option value="<?=$val?>" selected><?=$val?></option>
						  <? }} ?>
						  </select>
						  <label for="search_key_text">Add More for Multiple search key</label>
						  
					</div>

				 </div>

				 <div class="col-sm-2 mb-1 input-icons full_width input-field" style="position: relative;z-index: 999;">
<? 
if(isset($_REQUEST['date_range'])){ 
	//$date_range_echo= $_REQUEST['date_range'];
}

?>
				
<input type="text" name="date_range2" class="form-control form-control-sm bg-primary text-white" id="date_range" placeholder="Custom Date Range" value="<? if(isset($_REQUEST['date_range2'])) echo $_REQUEST['date_range2'];?>" style="min-width:252px;" required1 />

<label for="date_range" ><i class="<?=$data['fwicon']['calender'];?> cals fs-2x text-link float-start"  style="font-size: 11px;z-index:0;float: left !important;position: relative;margin: -5px 2px 0 0;" ></i> <font id="label_date_range_first"><?=(isset($_REQUEST['is_created_date_on'])&&trim($_REQUEST['is_created_date_on'])?'Created Timestamp':'Updated Timestamp')?>: </font> <i id="label_date_range"><?=@$_REQUEST['date_label'];?> </i> </label>


<?/*?> 
<i class="<?=$data['fwicon']['calender'];?> cals fs-2x text-link float-start" sss style="position:absolute;padding-top:8px;padding-left:3px 0;font-size:23px;z-index:0;" ></i>

<input type="text" class="form-control bg-primary text-white" id="date_range" placeholder="Custom Date" value="<? if(isset($_REQUEST['date_range'])) echo $_REQUEST['date_range'];?>" style="width:1px; visibility:hidden; position:absolute;z-index:10;" />

  <select id="time_period" name='time_period' title='Date Range' required class="form-control form-control-sm filter_option form-select  float-end' onClick="time_periodf1(this.value)" onChange="time_periodf(this.value)" style="padding-left:30px;position:relative;background:transparent;"  >
    <option selected1="" value="">Date</option>
    <option value="4">Today</option>
	<option value="1" selected1="selected">Last 7 days</option>
	<option value="2">Last 30 days</option>
	<option value="5">Custom dates</option>
  </select>
<label for="time_period" >Date Range </label>

    <? if(isset($_GET['time_period'])){?>
	<script>$('#time_period option[value="<?=prntext(@$_GET['time_period'])?>"]').prop('selected','selected');</script>
	<? } ?>
<?*/?>


<input type="hidden" class="form-control" name="date_1st" id="date_1st" />
<input type="hidden" class="form-control" name="date_2nd" id="date_2nd"  />
<input type="hidden" class="form-control" name="date_label" id="date_label"  />

</div>


<!--
width:calc(100% - 82px);float:left;margin-left:40px;
width:calc(100% - 65px);float:left;margin-left:22px;
-->
<div class="col-sm-2 mb-1 mt-1">
<div class="pe-1" style="width:calc(100% - 82px);float:left;margin-left:40px;">
<button class="btn btn-primary w-100" type="submit"  id="SEARCH" name="SEARCH" value="SEARCH"> Search</button>
</div>
<div style="width:40px;" class="text-end float-end">
<button class="btn btn-primary clear" type="button" title="Clear"><i class="<?=$data['fwicon']['circle-cross'];?>"></i></button>
</div>
</div>

		    </div>

</div>
			<!--//----------------------------------------------	-->
			  <!-- END For Calender - 2-->


			<style>

			</style>



        </div>




        <?

		} ?>


</div>
	  <!--//////////////////////-->
	  </div>
    </div>
  </div>

  </form>

  <script>


$('#search_bar').submit(function(e) {
	try {
		e.preventDefault();

		var $form = $('#search_bar');

		//alert('search_bar33333');

		var merchant_details = $form.find( "select[name='merchant_details[]']" ).val();
		var key_name = $form.find( "select[name='key_name']" ).val();
		var theValue = $form.find( "input[name='search_key']" ).val();
		//alert(key_name);
		if(key_name.match('m_|m_merID')){
			
			var keyname = key_name.replace("m_","");
			//alert('key_name=>'+keyname+'\r\nsearch_key=>'+merchant_details+'\r\nsearch_key=>'+merchant_details);
			var qr_ky="&key_name=m_"+keyname+"&search_key="+theValue;

			if((keyname=='merID'||keyname=='m_merID') && ( typeof(merchant_details) != 'undefined' && merchant_details != null && merchant_details !="" ))
			{
				$form.find( "input[name='search_key']" ).val(merchant_details[0]);
				//theValue=merchant_details.join(',');
				theValue=merchant_details[0];
				//alert('key_name=>'+keyname+'\r\nsearch_key=>'+theValue+'\r\merchant_details=>'+merchant_details);
			}
			
			if(theValue==''){
				alert('Cant not empty search key');
				$form.find( "input[name='search_key']" ).focus();
				return false;
			}
			else if(keyname=='merID'||keyname=='m_merID'){
				
				if(theValue.match('a|admin|d|demo')){
					top.window.location.href="<?=$data['Admins']?>/<?=$data['my_project']?><?=$data['ex']?>?action=search&keyword="+theValue+"&sfield="+keyname; 
				}
				else {
					top.window.location.href="<?=$data['Admins']?>/<?=$data['my_project']?><?=$data['ex']?>?action=detail&type=active&id="+theValue+qr_ky; 
				}
				

			}
			else if(keyname==="un"||keyname==="uid"||keyname==="fn"||keyname==="ln"||keyname==="em"||keyname==="cn"||keyname==="we"){
					top.window.location.href="<?=$data['Admins']?>/<?=$data['my_project']?><?=$data['ex']?>?action=select&keyword="+theValue+"&sfield="+keyname+qr_ky; 
			}
			else if(keyname==="tTerNO"||keyname==="tbu"||keyname==="tdba"||keyname==="tnem"){
					top.window.location.href="<?=$data['Admins']?>/<?=$data['my_project']?><?=$data['ex']?>?action=search&keyword="+theValue+"&sfield="+keyname; 
			}
			else {
				//alert(key_name+'\r\n ' +keyname);
			}
			return false;
		}



		$form.get(0).submit();

	}
	catch(err) {
	  alert('search_bar=>'+err.message);
	}
});

  </script>

</div>


<div class="col-sm-12 text-end row ps-0" >

<style>
#advancesearch .form-select,#simplesearch .form-select{
    color: #999 !important;
	font-size: 14px !important;
	}
#advancesearch .form-control,#simplesearch .form-control{
    color: #999 !important;
	font-size: 14px !important;
	}
.chosen-container-multi .chosen-choices li.search-field input[type=text] {
    margin: 0px 0 !important;
	}
</style>




</div>

<script>
			function searchclc(){
				if(trans_class=="datahref"){
					modal_popup3_frameshw();
					ajaxf2_id=$("#ajx_body");
					//alert(ajaxf2_id);
				}
			}
			$("#search_keyname").change(function(e){
				$('.search_textbx').attr('placeholder',$(this).find('option:selected').attr('data-holder'));
				quicksearchf($(this).val(),$('.search_textbx').val());
			});
			$('.search_textbx').on('keyup',function(event){
			  if(event.keyCode == 13){
				quicksearchf($('#search_keyname').val(),$(this).val());
				$(this).click();
			  }
			});
			function quicksearchf(keyname,theValues){
			//alert(keyname);
			var theValue=$.trim(theValues);
			  if(theValue){
				if(keyname==="9"){
					top.window.location.href="<?=$data['Admins'];?>/<?=$data['my_project']?><?=$data['ex']?>?action=detail&type=active&id="+theValue;
				}else if(keyname==="31"){
					top.window.location.href="<?=$data['Admins'];?>/emails<?=$data['ex']?>?action=select&status=0&searchkey="+theValue;
				}else if(keyname==="32"){
					top.window.location.href="<?=$data['Admins'];?>/messages<?=$data['ex']?>?action=select&stf=0&searchkey="+theValue;
				}else if(keyname==="91"){
					//top.window.location.href='../user/logins<?=$data['ex']?>?bid='+theValue;
					var w = window.open('<?=$data['USER_FOLDER'];?>/logins<?=$data['ex']?>?bid='+theValue,'_blank');
					w.focus();
				}else if((keyname=="311")||(keyname=="312")||(keyname=="313")||(keyname=="314")||(keyname=="315")){
					top.window.location.href="<?=$data['Admins'];?>/<?=$data['my_project']?><?=$data['ex']?>?action=search&keyword="+theValue+"&sfield="+keyname+"&searchkey="+theValue;
				}else if(keyname==="un"||keyname==="uid"||keyname==="fn"||keyname==="ln"||keyname==="em"||keyname==="cn"||keyname==="we"){
					top.window.location.href="<?=$data['Admins'];?>/<?=$data['my_project']?><?=$data['ex']?>?action=search&keyword="+theValue+"&sfield="+keyname+"&searchkey="+theValue;
				}else if(keyname==="10"){
					if(trans_class=="datahref"){
						datahref("<?=$trans_href;?>?action=select&status=-1&type=-1&bid="+theValue);
					}else{
						top.window.location.href="<?=$data['Admins'];?>/<?=$data['trnslist'];?><?=$data['ex']?>?action=select&status=-1&type=-1&bid="+theValue;
					}
				}else if(keyname==="6"||keyname==="7"){
					if(trans_class=="datahref"){
						datahref("<?=$trans_href;?>?"+"action=select&type=11&status=-1&keyname="+keyname+"&searchkey="+theValue);
					}else{
						top.window.location.href="<?=$data['Admins'];?>/<?=$data['trnslist'];?><?=$data['ex']?>?"+"action=select&type=11&status=-1&keyname="+keyname+"&searchkey="+theValue;
					}
				}else{
					if(trans_class=="datahref"){
						datahref("<?=$trans_href;?>?"+"action=select&acquirer=0&status=-1&keyname="+keyname+"&searchkey="+theValue);
					}else{
						top.window.location.href="<?=$data['Admins'];?>/<?=$data['trnslist'];?><?=$data['ex']?>?"+"action=select&acquirer=0&status=-1&keyname="+keyname+"&searchkey="+theValue;
					}
				}
			  }
			}
		</script>

</div>




<!--  ==============END SEARCH=================  -->
<? } ?>
<? } ?>
</div>
<? } ?>
<?

//echo $data['PageFile'];
// Added for change design og login page
$header_title_center = array("login","admin_merchant_login");
if(in_array($data['PageFile'], $header_title_center)){
$title_position="text-center";
$title_border="";
?>
<style>
bodyXX {
background-image: linear-gradient(135deg, <?=$_SESSION['background_gd3'];?> 25%, transparent 25%, transparent 50%, <?=$_SESSION['background_gd3'];?> 50%, <?=$_SESSION['background_gd3'];?> 100%, transparent 75%, <?=$_SESSION['background_gd3'];?>)!important;
}

body {
	background:var(--background-1) !important;
}
</style>
<?
}
?>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
<?
if(isset($_GET['s11'])){
	$_SESSION['s11']=1;
}

if(isset($_SESSION)&&(isset($_SESSION['sub_admin_id'])&&$_SESSION['sub_admin_id'])&&isset($_SESSION['s11'])){
	echo " | merchantAccess=>".$_SESSION['merchantAccess'];
	echo " | get_mid=>".$_SESSION['get_mid'];
	echo " | get_mid_count=>".$_SESSION['get_mid_count'];
	echo " | subAdminAccess=>".$_SESSION['subAdminAccess'];
	echo " | get_gid=>".$_SESSION['get_gid'];
	echo " | acquirer_ids=>".$_SESSION['acquirer_ids'];
}
?>
