<?
$data['PageName']='TRANSACTIONS STATISTIC';
$data['HideLeftSide']=true;
$data['rootNoAssing']=1;
###############################################################################
include('../config.do');
if(isset($_REQUEST['bid'])&&$_REQUEST['bid']>0){

	$gid = $_REQUEST['bid'];
	$result_select=db_rows_2(
		"SELECT * FROM `{$data['DbPrefix']}payout_beneficiary`".
		" WHERE `id`='{$gid}' ".
		" LIMIT 1",0  
	);
	$data['row'] = $result_select[0];
}

//print_r($data['row']['id']);

$mid = $data['row']['clientid'];
$memb=select_tablef("`id`='{$mid}'",'clientid_table',0,1,"`company_name`");
$data['row']['company_name']=$memb['company_name'];

###############################################################################

if(!isset($_SESSION['adm_login'])&&!isset($_SESSION['login'])){
	header("location:{$data['USER_FOLDER']}/login".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}
$post['ViewMode']=$post['action'];
$is_admin_payout=false;
if(isset($_SESSION['adm_login'])&&isset($_REQUEST['admin'])){
	$is_admin_payout=true;
}
else{}
###############################################################################

if(isset($is_admin_payout)&&$is_admin_payout&&isset($uid)&&$uid){
	$data['frontUiName']="";
}
if(isset($_REQUEST['tempui'])&&$_REQUEST['tempui']){
	$data['frontUiName']=$_REQUEST['tempui'];
}
if(isset($_REQUEST['dtest'])&&$_REQUEST['dtest']){
	echo "<br/>is_admin=>".$is_admin_payout;
	echo "<br/>uid=>".$uid;
	echo "<br/>frontUiName=>".$data['frontUiName'];
}

$post['is_admin_payout']=$is_admin_payout;
showpage("common/template.beneficiary_details".$data['iex']);exit;

?>