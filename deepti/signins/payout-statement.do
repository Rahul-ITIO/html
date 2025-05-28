<?
$data['PageName']	= 'Payout Statement';
$data['PageFile']	= 'payout-statement';

$data['rootNoAssing']=1; 
###############################################################################
include('../config.do');
$data['PageTitle'] = $data['PageName'].' - '.$data['domain_name'];
###############################################################################

if((!isset($_SESSION['adm_login']))&&(!isset($_SESSION['sub_admin_id']))){
	$_SESSION['adminRedirectUrl']=$data['urlpath'];
	header("Location:{$data['slogin']}/login".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

//check payout folder exists or not - 
$payout_button=($data['Path']."/payout/template.admin_payout_button".$data['iex']);
if(!file_exists($payout_button)){	//If payout not exist then showing Admin' index page
	header("Location:{$data['slogin']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}


if(!isset($post['action'])||!$post['action']){$post['action']='select'; $post['step']=1; }
if(!isset($post['step'])||!$post['step']){$post['step']=1; }

###############################################################################

if(isset($post['send'])&&($post['send']=='add_data')){
	$post['step']=2;
}

if($post['step']==1){

	//$data['MaxRowsByPage']=50;
	if(isset($_REQUEST['page'])){$page=$_REQUEST['page'];unset($_REQUEST['page']);}else{$page=1;}

	$data['startPage'] = $page;
	$start	= ($page-1)*$data['MaxRowsByPage'];
	$end	= isset($_REQUEST['records_per_page'])&&$_REQUEST['records_per_page']?$_REQUEST['records_per_page']:$data['MaxRowsByPage'];
	
	$limit	= " LIMIT $start, $end";
	
	$requrl	= "";
	$sql_query	=" AND `transaction_status`='1'";
	if((isset($_GET['date_1st'])&&$_GET['date_1st']) and ($_GET['date_2nd']&&$_GET['date_2nd'])){ 
		$data['start_date']	=$_GET['date_1st'];
		$data['end_date']	=$_GET['date_2nd'];
		$enddate	= $data['end_date'];
		$sql_query.=" AND `transaction_date`>='{$data['start_date']}' AND `transaction_date`<='{$enddate}' ";
		$requrl .= "&start_date=".$data['start_date']."&end_date=".$data['end_date'];
	}
	if((isset($_GET['searchkey'])&&$_GET['searchkey']) and ($_GET['key_name']<>"")){ 
		$sql_query.=" AND `".$_GET['key_name']."` = '" .trim($_GET['searchkey'])."'";
		$requrl.="&".$_GET['searchkey']."=".$_GET['searchkey'];
	}
	if(isset($_GET['status'])&&$_GET['status']<>""){ 
		//$sql_query.=" AND `transaction_status` = '" .trim($_GET['status'])."'";
		//$requrl.="& transaction_status =".$_GET['status'];
	}
	
	$sqlStmt	= "SELECT count(id) as ct FROM `{$data['DbPrefix']}payout_transaction` WHERE 1 $sql_query";
	$result_ct	= db_rows_2($sqlStmt,0);
	$data['total_record']= $result_ct[0]['ct'];

	$sqlStmt ="SELECT * FROM `{$data['DbPrefix']}payout_transaction` WHERE 1 $sql_query ORDER BY `transaction_date` DESC $limit";
	
	$result_select= db_rows_2($sqlStmt,0);
	$post['result_list'] = $result_select;

	$data['cntdata']=count($post['result_list']);

	$data['rec_start']	=$start+1;
	$data['rec_end']	=(($data['cntdata']<$data['MaxRowsByPage'])?($start+$data['cntdata']):($start+$data['MaxRowsByPage']));
}

/*if($post['step']==1){

	$data['MaxRowsByPage']=50;

	$sql_query	=" AND `transaction_status`='1'"; 

	if(isset($_REQUEST['page'])){$page=$_REQUEST['page'];unset($_REQUEST['page']);}else{$page=1;}

	$data['startPage'] = $page;
	$start	= ($page-1)*$data['MaxRowsByPage'];
	$end	= $data['MaxRowsByPage'];
	
	$limit	= " LIMIT $start, $end";
	
	$requrl		="";
	if((isset($_GET['start_date'])<>"") and ($_GET['end_date']<>"")){ 
		$data['start_date']	=$_GET['start_date'];
		$data['end_date']	=$_GET['end_date'];
		$enddate	= $data['end_date'] . ' 23:59:59';

		$sql_query.=" AND `transaction_date`>='{$data['start_date']}' AND `transaction_date`<='{$enddate}' ";
	
		$requrl .= "&start_date=".$_GET['start_date']."&end_date=".$_GET['end_date'];
	}
	if((isset($_GET['value'])<>"") and ($_GET['type']<>"")){ 
		$sql_query.=" AND `".$_GET['type']."` = '" .trim($_GET['value'])."'";
		$requrl.="&".$_GET['type']."=".$_GET['value'];
	}
	
	$sqlStmt	= "SELECT count(id) as ct FROM `{$data['DbPrefix']}payout_transaction` WHERE 1 $sql_query";
	$result_ct	= db_rows_2($sqlStmt,0);
	$data['total_record']= $result_ct[0]['ct'];

	$sqlStmt = "SELECT * FROM `{$data['DbPrefix']}payout_transaction` WHERE 1 $sql_query ORDER BY `transaction_date` DESC $limit";
	$result_select= db_rows_2($sqlStmt,0);
	$post['result_list'] = $result_select;

	$data['cntdata']=count($post['result_list']);
	
	$data['rec_start']	=$start+1;
	$data['rec_end']	=(($data['cntdata']<$data['MaxRowsByPage'])?($start+$data['cntdata']):($start+$data['MaxRowsByPage']));
}*/

###############################################################################

display('admins');

###############################################################################

?>