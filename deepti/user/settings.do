<?
###############################################################################
$data['PageName']='Settings';
$data['PageFile']='settings';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Settings - '.$data['domain_name'];
##########################Check Permission#####################################
if(!clients_page_permission('13',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }
###############################################################################
if(!isset($_SESSION['adm_login'])&&!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}
$is_admin=false;
if(isset($_SESSION['adm_login'])&&isset($_GET['admin'])&&$_GET['admin']){
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
if(isset($post['change'])&&$post['change']) {
	$json_setting=jsonencode($post['setting']);
	
	if(!isset($post['setting']['merchant_pays_fee'])||empty($post['setting']['merchant_pays_fee'])){ 
		$data['error']="Can't Blank for Merchant pays fee. ";
	}
	else{
		db_query(
			"UPDATE `{$data['DbPrefix']}clientid_table` SET ".
			"`json_setting`='{$json_setting}'".
			" WHERE `id`={$_SESSION['uid']}",0
		);
	}
/* get the confirmation code from the url (link in email)*/
	if($is_admin==true){
		echo "<script>
		 top.window.location.href='{$data['Admins']}/settings{$data['ex']}id={$_GET['id']}&action=detail';
		</script>";
	}
}
$post=select_info($uid, $post);
$post['json_setting']=jsondecode($post['json_setting']);
###############################################################################
display('user');
###############################################################################
?>