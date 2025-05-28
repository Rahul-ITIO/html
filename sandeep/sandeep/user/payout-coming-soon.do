<?
###############################################################################
$data['PageName']='Payout Coming Soon';
$data['PageFile']='payout-coming-soon';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Payout Coming Soon - '.$data['domain_name'];
##########################Check Permission#####################################
if(!clients_page_permission('17',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }
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



###############################################################################
display('user');
###############################################################################
?>