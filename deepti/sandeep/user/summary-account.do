<?
###############################################################################
$data['PageName']='Summary Account';
$data['PageFile']='summary_account'; 
$data['PageFiles'][]=$data['PageFile']; 
###############################################################################
if(!isset($data['DISPLAY_MULTI'])){
	include('../config.do');
}
$data['PageTitle'] = 'Summary Account - '.$data['domain_name'];
###############################################################################
if(!isset($_SESSION['adm_login'])&&!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}
$is_admin=false;
if(isset($_SESSION['adm_login'])&&$_SESSION['adm_login']&&isset($_GET['admin'])&&$_GET['admin']){
	$is_admin=true;
	$data['HideAllMenu']=true;
	$uid=$_GET['id'];
	$_SESSION['uid']=$uid;
	$_SESSION['login']=$uid;
}
###############################################################################
if(is_info_empty($uid)&&$is_admin==false){
	header("Location:{$data['Host']}/user/profile".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}
###############################################################################

$post=select_info($uid, $post);
//print_r($post);
$uid=$post['id'];
$post['google_auth_access_withut_json']=$post['google_auth_access'];
if(isset($post['profile_json'])&&$post['profile_json']){
	$post=array_merge($post,$post['profile_json']);
}

//============Work Area=================

//======================================
###############################################################################
if(!isset($data['DISPLAY_MULTI'])){
	display('user');
}
###############################################################################
?>