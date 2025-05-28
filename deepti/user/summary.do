<?
$data['PageName']	= 'Summary';
$data['PageFile']	= 'summary';

###############################################################################
include('../config.do');
$data['PageTitle'] = 'Summary - '.$data['domain_name']; 
##########################Check Permission#####################################
// Page for Payout Merchant dashboard 
###############################################################################

if(!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

###############################################################################
if(is_info_empty($uid)){
	header("Location:{$data['USER_FOLDER']}/profile".$data['ex']);
	echo('ACCESS DENIED..');
	exit;
}

$post=select_info($uid, $post);

//include_once $data['Path'].'/include/payout-request'.$data['iex'];

###############################################################################

// For store session before loading header
if(($data['PageFile']=='summary') && (isset($_REQUEST['act'])&&$_REQUEST['act']=="1")){
	$_SESSION['dashboard_type']="payout-dashboar";
}
// Redirect to dashboard when not assign payout request or Payout Dashboard
if(($post['payout_request']!='1' && $post['payout_request']!='2') || $_SESSION['dashboard_type']==""){
	$_SESSION['dashboard_type']="";
	header("Location:{$data['USER_FOLDER']}/dashboard".$data['ex']);
	echo('ACCESS DENIED..');
	exit;
}

###############################################################################

if(!isset($post['step']) || !$post['step'])$post['step']=1;
$post['Buttons']=get_files_list($data['SinBtnsPath']);

//$post=select_info($uid, $post);
//print_r($post);

if(!isset($post['step']) || !$post['step'])$post['step']=1;

###############################################################################
if($post['google_auth_code']=='') {
	header("Location:{$data['USER_FOLDER']}/two-factor-authentication{$data['ex']}");exit;
}
elseif(($post['google_auth_access']==1||$post['google_auth_access']==3)&&($post['google_auth_code'])) {
	$data['withdraw_gmfa']=1;
	$_SESSION['google_auth_code']=$google_auth_code=$post['google_auth_code'];
	$google_auth_access=$post['google_auth_access'];
	$authenticat_msg='and successfully authenticated';
}
################
display('user');
################
?>