<?
$data['PageFile']='merchant_list';
$data['PageFile2']='clients_test';
$data['G_MID']=$_REQUEST['gid'];
include('../config.do');

###############################################################################

if(!isset($_SESSION['login'])&&!isset($_SESSION['adm_login'])){
	header("Location:{$data['USER_FOLDER']}/login{$data['ex']}");
	echo('ACCESS DENIED.');
	exit;
//}elseif(isset($_SESSION['sub_admin_id'])&&$_SESSION['sub_admin_id']!=3){
}elseif((isset($_SESSION['sub_admin_id']))&&(!isset($_SESSION['edit_trans']))){
	// header("Location:{$data['USER_FOLDER']}/login{$data['ex']}"); echo('ACCESS DENIED.'); exit;
}

$is_admin=false;
if(isset($_SESSION['adm_login'])&&$_SESSION['adm_login']&&isset($_GET['admin'])&&$_GET['admin']){
	$is_admin=true;
	//echo "<hr/>is_admin=>".$is_admin;
}

if(isset($is_admin)&&$is_admin&&isset($uid)&&$uid){
	//$data['frontUiName']="";
}
if(isset($_REQUEST['tempui'])){
	$data['frontUiName']=$_REQUEST['tempui'];
}

if(isset($data['con_name'])&&$data['con_name']=='clk'){
	$post['swift_con']='IFSC';
	$ovalidation=false;
}else{
	$post['swift_con']='SWIFT';
	$ovalidation=true;
}

$post['ovalidation']=$ovalidation;

$post['gid']=$_REQUEST['gid'];
$post['MemberInfo']['sponsor']=$_REQUEST['sponsor'];
$post['MemberInfo']['id']=$post['gid'];
if(isset($post['action'])&&$post['action']=='delete_list'){
	$post['BanksInfo']=select_banks($post['gid'],0,0,0,'2');
}else{
	$post['BanksInfo']=select_banks($post['gid']);
}

if(isset($post['action'])&&$post['action']=='delete_list'){
	$post['WalletInfo']=select_coin_wallet($post['gid'],0,0,0,'2');
}else{
	$post['WalletInfo']=select_coin_wallet($post['gid']);
}

$data['b_result_count']=sizeof($post['BanksInfo'])+sizeof($post['WalletInfo']);


showpage("common/template.bank_admin".$data['iex']);exit;

?>
