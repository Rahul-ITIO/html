<?
$data['PageName']='Beneficiary List';
$data['PageTitle']='Beneficiary List';
$data['HideLeftSide']=true;
$data['rootNoAssing']=1;
###############################################################################
include('../config.do');

###############################################################################
if(!isset($_SESSION['adm_login'])&&!isset($_SESSION['login'])){
	header("location:{$data['USER_FOLDER']}/login".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

if(is_info_empty($uid)){
	header("Location:{$data['USER_FOLDER']}/profile".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

$post=select_info($uid, $post);
include_once $data['Path'].'/include/payout-request'.$data['iex'];

###############################################################################

if(isset($_SESSION['uid'])&&$_SESSION['uid']>0){
	$gid = $_SESSION['uid'];

	//paging create by  on 26-8
	//$data['MaxRowsByPage']=5;	//testing purpose set five records per page 
	if(isset($_REQUEST['page'])){$page=$_REQUEST['page'];unset($_REQUEST['page']);}else{$page=1;}

	$data['startPage'] = $page;
	$start	= ($page-1)*$data['MaxRowsByPage'];
	$end	= $data['MaxRowsByPage'];
	
	$limit	= " LIMIT $start, $end";

	if($data['connection_type']=='PSQL'&&!empty(trim($limit))) 
	{
		$limit= ' LIMIT '.$end.' OFFSET '.$start;
	}

	$sql_query	="`clientid`='{$gid}' AND status='1'";

	$sqlStmt	= "SELECT count(id) as ct FROM `{$data['DbPrefix']}payout_beneficiary` WHERE $sql_query";
	$result_ct	= db_rows_2($sqlStmt,0);
	$data['total_record']= $result_ct[0]['ct'];
	
	$sqlStmt	= "SELECT * FROM `{$data['DbPrefix']}payout_beneficiary` WHERE $sql_query ORDER BY bene_id $limit";
	$result_select		= db_rows_2($sqlStmt,0);
	$data['bene_list']	= $result_select;

	$data['cntdata']	= count($data['bene_list']);

	$data['rec_start']	=$start+1;
	$data['rec_end']	=(($data['cntdata']<$data['MaxRowsByPage'])?($start+$data['cntdata']):($start+$data['MaxRowsByPage']));
	
	/*
	$result_select=db_rows_2(
		"SELECT * FROM `{$data['DbPrefix']}payout_beneficiary`".
		" WHERE `clientid`='{$gid}' AND status='1'".
		" ORDER BY bene_id",0
		//" ORDER BY beneficiary_nickname, beneficiary_name",0
	);
	*/
	//$post['bene_list'] = $result_select;
}

$post['ViewMode']=$post['action'];
$is_admin=false;

if(isset($is_admin)&&$is_admin&&isset($uid)&&$uid){
	$data['frontUiName']="";
}
if(isset($_REQUEST['tempui'])&&$_REQUEST['tempui']){
	$data['frontUiName']=$_REQUEST['tempui'];
}
if(isset($_REQUEST['dtest'])&&$_REQUEST['dtest']){
	echo "<br/>is_admin=>".$is_admin;
	echo "<br/>uid=>".$uid;
	echo "<br/>frontUiName=>".$data['frontUiName'];
}
if(isset($data['PageDisplay'])){
	display('user');
}else{
	showpage("user/template.payout_beneficiary_list".$data['iex']);exit;
}
?>