<?
###############################################################################
$data['PageName']='Payout Statement';
$data['PageFile']='payout-statement';
$data['PageFileName']='payout-statement';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Payout Statement - '.$data['domain_name']; 
##########################Check Permission#####################################

if((isset($_SESSION['m_clients_role']) &&$_SESSION['m_clients_role'])?$_SESSION['m_clients_role']:'');
if((isset($_SESSION['m_clients_type']) &&$_SESSION['m_clients_type'])?$_SESSION['m_clients_type']:'');

if(!clients_page_permission('21',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }

if(isset($_SESSION['m_clients_role'])&&isset($_SESSION['m_clients_type'])&&!clients_page_permission('21',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }


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
if(!isset($post['step']) || !$post['step'])$post['step']=1;
$post['Buttons']=get_files_list($data['SinBtnsPath']);

###############################################################################

if(isset($post['step'])&&$post['step']==1){

	//paging create by  on 26-8
//	$data['MaxRowsByPage']=5;	//testing purpose set five records per page 

	if(isset($_REQUEST['page'])){$page=$_REQUEST['page'];unset($_REQUEST['page']);}else{$page=1;}

	$data['startPage'] = $page;
	$start	= ($page-1)*$data['MaxRowsByPage'];
	$end	= $data['MaxRowsByPage'];
	
	$limit	= " LIMIT $start, $end";

	$requrl	= "";
	$sql_query = "`sub_client_id`='{$uid}' AND `transaction_status`='1'";
	if((isset($_GET['start_date'])<>"") and ($_GET['end_date']<>"")){ 
		$data['start_date']	=$_GET['start_date'];
		$data['end_date']	=$_GET['end_date'];
		$enddate	= $data['end_date'] . ' 23:59:59';

		$sql_query.=" AND `transaction_date`>='{$data['start_date']}' AND `transaction_date`<='{$enddate}' ";
	
		$requrl .= "&start_date=".$_GET['start_date']."&end_date=".$_GET['end_date'];
	}
	if((isset($_GET['value'])<>"") and ($_GET['type']<>"")){ 
		$sql_query.=" AND `".$_GET['type']."` = '" .$_GET['value']."'";
		$requrl.="&".$_GET['type']."=".$_GET['value'];
	}

	$sqlStmt	= "SELECT count(id) as ct FROM `{$data['DbPrefix']}payout_transaction` WHERE $sql_query";
	$result_ct	= db_rows_2($sqlStmt,0);
	$data['total_record']= $result_ct[0]['ct'];

	$sqlStmt	= "SELECT * FROM `{$data['DbPrefix']}payout_transaction` WHERE $sql_query ORDER BY `transaction_date` DESC $limit";
	$result_select		= db_rows_2($sqlStmt,0);
	$data['TransData']	= $result_select;

	$data['cntdata']	=count($data['TransData']);

	$data['rec_start']	=$start+1;
	$data['rec_end']	=(($data['cntdata']<$data['MaxRowsByPage'])?($start+$data['cntdata']):($start+$data['MaxRowsByPage']));
}

###############################################################################
display('user');
###############################################################################
?>
