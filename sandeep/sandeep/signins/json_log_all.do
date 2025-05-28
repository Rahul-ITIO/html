<?
$data['PageName']='Json Log History';
$data['PageFile']='json_log_all';
$data['HideMenu']=true;
$data['HideAllMenu']=true;
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Json Log History - '.$data['domain_name'];
###############################################################################

if(!isset($_SESSION['adm_login'])&&!isset($_SESSION['login']))
//if(!isset($_SESSION['adm_login']))
{
	echo('ACCESS DENIED.'); exit;
}


$tablename=(isset($_REQUEST['tablename'])?$_REQUEST['tablename']:'');
$get_owner=(isset($_REQUEST['clientid'])?$_REQUEST['clientid']:'');
$action_name=(isset($_REQUEST['action_name'])?$_REQUEST['action_name']:'');

if(!isset($_SESSION['adm_login'])&&isset($_SESSION['login']))
$get_owner=$_SESSION['uid'];

if(isset($_REQUEST['mode'])&&$_REQUEST['mode']="json_log"){

	$result_list=db_rows(
		"SELECT json_log_history FROM {$data['DbPrefix']}$tablename",0
	);

}
else{
	$qrs='';
	if(isset($get_owner)&&$get_owner){ $qrs .=" AND `clientid`='$get_owner' "; }
	if(isset($action_name)&&$action_name){ $qrs .=" AND `action_name`='$action_name' "; }
	
	$result_list=db_rows(
		"SELECT * FROM {$data['DbPrefix']}json_log".
		" WHERE `tableName` = '$tablename' $qrs ".
		" ORDER BY id DESC ",0
	);
	
}

	$post['result_list']=array();
	
	foreach($result_list as $key=>$value){
		$post['result_list'][$key]=$value;
	}

display('admins');

?>









