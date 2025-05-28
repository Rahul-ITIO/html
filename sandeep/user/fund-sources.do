<?
$data['PageName']	= 'Fund Sources';
$data['PageFile']	= 'fund-sources';

###############################################################################
include('../config.do');
$data['PageTitle'] = 'Fund Sources - '.$data['domain_name']; 
##########################Check Permission#####################################
if((isset($_SESSION['m_clients_role']) &&$_SESSION['m_clients_role'])?$_SESSION['m_clients_role']:'');
if((isset($_SESSION['m_clients_type']) &&$_SESSION['m_clients_type'])?$_SESSION['m_clients_type']:'');

if(!clients_page_permission('20',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }

if(isset($_SESSION['m_clients_role'])&&isset($_SESSION['m_clients_type'])&&!clients_page_permission('20',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }

###############################################################################
if(!isset($_SESSION['adm_login'])&&!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']); echo('ACCESS DENIED.'); exit;
}
$is_admin=false;
if(isset($_SESSION['adm_login'])&&isset($_GET['admin'])&&$_GET['admin']){
	$is_admin=true;
	$data['HideAllMenu']=true;
	$uid=$post['bid'];
	$_SESSION['login']=$uid;
}
$post['is_admin']=$is_admin;
if(is_info_empty($uid)){
	$get_q='';if(isset($_GET)){$get_q="?".http_build_query($_GET);}
	header("Location:{$data['Host']}/user/profile{$data['ex']}{$get_q}");
	echo('ACCESS DENIED.');
	exit;
}


###############################################################################
$post=select_info($uid, $post);

include_once $data['Path'].'/include/payout-request'.$data['iex'];

###############################################################################
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

###############################################################################
if(isset($post['action'])&&$post['action']=='generate_payout_token'){

	if(strlen($uid)==1) $paykey['tid'] ="000".$uid;
	elseif(strlen($uid)==2) $paykey['tid'] ="00".$uid;
	elseif(strlen($uid)==3) $paykey['tid'] ="0".$uid;
	else $paykey['tid'] =$uid;

	$paykey['time'] =time();
	$payout_token_en=encode_f(json_encode($paykey),1);
	
	$payout_token_de=jsondecode($payout_token_en);
	$post['payout_token']=$payout_token_de;
	$payout_token=$payout_token_de['decrypt'];

	db_query("UPDATE `{$data['DbPrefix']}clientid_table`"." SET `payout_token`='{$payout_token}' WHERE `id`='{$uid}'");

	if(isset($_REQUEST['ajax'])&&$_REQUEST['ajax'])
	{
		echo $payout_token;
		exit;
		//$_SESSION['action_success']="Payout Token Generated Successfully!";
	}
	header("location:".$data['USER_FOLDER']."/".$data['PageFileName'].$data['ex']);exit;
}elseif(isset($post['action'])&&$post['action']=='generate_secret_key'){

	$generate_secret_key=generate_secret_key($uid);

	$_SESSION['action_success']="Secret Key Generated Successfully!";
    header("location:".$data['USER_FOLDER']."/".$data['PageFileName'].$data['ex']);exit;
	

}elseif(isset($post['action'])&&$post['action']=='payout_secret_key'){

	$payout_secret_key_en=encode_f($_POST['payout_secret_key'],1);

	db_query("UPDATE `{$data['DbPrefix']}clientid_table`"." SET `payout_secret_key`='{$payout_secret_key_en}' WHERE `id`='{$uid}'");

	$_SESSION['action_success']="Payout Secret Key Generated Successfully!";
	
	header("location:".$data['USER_FOLDER']."/".$data['PageFileName'].$data['ex']);exit;
}

if(isset($post['step'])&&$post['step']==1){

	//	$data['MaxRowsByPage']=5;

	// Search Step 1 :: For Advance search total records display Added by vikash on 27092022
	if(isset($_GET['records_per_page'])&&$_GET['records_per_page']){
		$data['MaxRowsByPage']=$_GET['records_per_page'];
	}
		
	if(isset($_REQUEST['page'])){$page=$_REQUEST['page'];unset($_REQUEST['page']);}else{$page=1;}

	$data['startPage'] = $page;
	$start	= ($page-1)*$data['MaxRowsByPage'];
	$end	= $data['MaxRowsByPage'];
	$limit	= " LIMIT $start, $end";
	$sql_query = "`sub_client_id`='{$uid}'";
	$p_order_by=" `transaction_date` DESC, id DESC ";

	// Search Step 2 :: For Advance search Search by keyword display Added by vikash on 27092022
	if( (isset($_REQUEST['searchkey'])&&isset($_REQUEST['key_name'])&&$_REQUEST['searchkey']&&isset($_REQUEST['key_name'])&&$_REQUEST['key_name'])&&(!isset($_REQUEST['keyname'])||!$_REQUEST['keyname']) ){
		$searchkey=$_REQUEST['searchkey'];
		$key_name=$_REQUEST['key_name'];
		$sql_query.=" AND `$key_name` like '%$searchkey%' ";		
	}
	// Search Step 3 :: For Advance search Search by Statue display Added by vikash on 270922		
	if((isset($_REQUEST['status'])&&$_REQUEST['status']<>"")){
		$search_status=$_REQUEST['status'];
		$sql_query.=" AND `transaction_status` = '$search_status' ";		
	}
	// Search Step 4 :: For Advance search Search by Date display Added by vikash on 270922
	if(isset($_REQUEST['time_period'])&&$_REQUEST['time_period']==4){
		$date_today=date("Y-m-d");
		$sql_query .=" AND `transaction_date` like '%{$date_today}%' "; 
	}
	
	if(isset($_REQUEST['time_period'])&&$_REQUEST['time_period']==1){
		$date_1st=date("Y-m-d",strtotime("-7 day"));
		$date_2nd=date("Y-m-d",strtotime("+1 day"));
		
		$sql_query .=" AND ( `transaction_date` BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$date_2nd}', '%Y%m%d%H%i%s')) )  ";
	}
	
	if(isset($_REQUEST['time_period'])&&$_REQUEST['time_period']==2){
		$date_1st=date("Y-m-d",strtotime("-30 day"));
		$date_2nd=date("Y-m-d",strtotime("+1 day"));
		$date_1st=(date('Y-m-d H:i:s',strtotime($date_1st. ' - 1 days')));
		$date_2nd=(date('Y-m-d H:i:s',strtotime($date_2nd. ' + 1 days')));
		
		$sql_query .=" AND ( `transaction_date` BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$date_2nd}', '%Y%m%d%H%i%s')) )  ";
	}

	if(isset($_REQUEST['date_1st']) && isset($_REQUEST['date_2nd']) && $_REQUEST['date_1st']&&$_REQUEST['date_2nd'] && $_REQUEST['time_period']==5){
			$date_1st=(date('Y-m-d H:i:s',strtotime($_REQUEST['date_1st'])));
		$date_2nd=(date('Y-m-d H:i:s',strtotime($_REQUEST['date_2nd'])));
		
		$date_1st=(date('Y-m-d H:i:s',strtotime($date_1st. ' - 1 days')));
		$date_2nd=(date('Y-m-d H:i:s',strtotime($date_2nd. ' + 1 days')));
		
		$sql_query .=" AND ( `transaction_date` BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$date_2nd}', '%Y%m%d%H%i%s')) )  "; 
		
	}
	$sql_query.=" AND `transaction_for`='2'";		
	////////////// for paging /////////////////
	$sqlStmt	= "SELECT count(id) as ct FROM `{$data['DbPrefix']}payout_transaction` WHERE $sql_query";
	$result_ct	= db_rows_2($sqlStmt,0);
	$data['total_record']= $result_ct[0]['ct'];
	////////////// End paging /////////////////

	
	// AND `transaction_for`='2' for Fund Source
	

	$sqlStmt = "SELECT * FROM `{$data['DbPrefix']}payout_transaction` WHERE $sql_query ORDER BY $p_order_by $limit";
	$result_select= db_rows_2($sqlStmt,0);
	$data['TransData'] = $result_select;

	$data['cntdata']	=count($data['TransData']);

	$data['rec_start']	=$start+1;
	$data['rec_end']	=(($data['cntdata']<$data['MaxRowsByPage'])?($start+$data['cntdata']):($start+$data['MaxRowsByPage']));
}

###############################################################################
display('user');
###############################################################################
?>
