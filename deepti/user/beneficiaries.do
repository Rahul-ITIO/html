<?
$data['PageName']	= 'Beneficiaries';
$data['PageFile']	= 'beneficiaries';

###############################################################################
include('../config.do');
$data['PageTitle'] = 'Beneficiaries - '.$data['domain_name']; 
##########################Check Permission#####################################

/*if(!clients_page_permission('19',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }

if(isset($_SESSION['m_clients_role'])&&isset($_SESSION['m_clients_type'])&&!clients_page_permission('19',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }
*/
###############################################################################

if(!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

###############################################################################
if(is_info_empty($uid)){
	header("Location:{$data['USER_FOLDER']}/profile".$data['ex']);
	echo('ACCESS DENIED..');
	exit;
}

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
###############################################################################
if($post['google_auth_code']=='') {
	header("Location:{$data['USER_FOLDER']}/two-factor-authentication{$data['ex']}");exit;
}
elseif(($post['google_auth_access']==1||$post['google_auth_access']==3)&&($post['google_auth_code'])) {
	$data['withdraw_gmfa']=1;
	$_SESSION['google_auth_code']=$google_auth_code=$post['google_auth_code'];
	$google_auth_access=$post['google_auth_access'];
	$authenticat_msg='and successfully authenticated';
}

if(isset($_SESSION['uid'])&&$_SESSION['uid']>0){
	$gid = $_SESSION['uid'];

	// Search Step 1 :: For Advance search total records display Added by vikash on 28092022
	if(isset($_REQUEST['records_per_page'])&&$_REQUEST['records_per_page']){
		$data['MaxRowsByPage']=$_REQUEST['records_per_page'];
	}
	
	if(isset($_REQUEST['page'])){$page=$_REQUEST['page'];unset($_REQUEST['page']);}else{$page=1;}

	$data['startPage'] = $page;
	$start	= ($page-1)*$data['MaxRowsByPage'];
	$end	= $data['MaxRowsByPage'];
	$limit	= " LIMIT $start, $end";
	$sql_query = "`clientid`='{$gid}' AND `status` = '1' ";
	$p_order_by=" `id` DESC ";

	$whereClause=array();
		
	if(isset($_REQUEST['bene_id'])&&$_REQUEST['bene_id'])
	{
		$data['bene_id'] = $_REQUEST['bene_id'];
		$whereClause[] = "bene_id='{$data['bene_id']}'";
	}
	if(isset($_REQUEST['beneficiary_name'])&&$_REQUEST['beneficiary_name'])
	{
		$data['beneficiary_name'] = $_REQUEST['beneficiary_name'];
		$whereClause[] = "beneficiary_name LIKE '%{$data['beneficiary_name']}%'";
	}
	if(isset($_REQUEST['account_number'])&&$_REQUEST['account_number'])
	{
		$data['account_number'] = $_REQUEST['account_number'];
		$whereClause[] = "account_number='{$data['account_number']}'";
	}
	if(isset($_REQUEST['bank_name'])&&$_REQUEST['bank_name'])
	{
		$data['bank_name'] = $_REQUEST['bank_name'];
		$whereClause[] = "bank_name LIKE '%{$data['bank_name']}%'";
	}
	if(isset($_REQUEST['bank_code'])&&$_REQUEST['bank_code'])
	{
		$data['bank_code'] = $_REQUEST['bank_code'];
		$whereClause[] = "(bank_code1 LIKE '%{$data['bank_code']}%' OR bank_code2 LIKE '%{$data['bank_code']}%' OR bank_code3 LIKE '%{$data['bank_code']}%')";
	}
	
	if(count($whereClause))
	{
		$sql_query = implode(" AND ", $whereClause);
		$sql_query = ' '.$sql_query;
	}
	
	////////////// for paging /////////////////
	$sqlStmt	= "SELECT count(id) as ct FROM `{$data['DbPrefix']}payout_beneficiary` WHERE $sql_query ";
	$result_ct	= db_rows_2($sqlStmt,0);
	$data['total_record']= $result_ct[0]['ct'];
	////////////// End paging /////////////////

	$result_select=db_rows_2(
		"SELECT * FROM `{$data['DbPrefix']}payout_beneficiary`".
		" WHERE $sql_query ORDER BY $p_order_by $limit",0
	);
	$post['bene_list'] = $result_select;

	$data['cntdata']	= count($post['bene_list']);
	$data['rec_start']	=$start+1;
	$data['rec_end']	=(($data['cntdata']<$data['MaxRowsByPage'])?($start+$data['cntdata']):($start+$data['MaxRowsByPage']));

}

$post['ViewMode']=@$post['action'];
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

if(isset($_POST['send'])&&$_POST['send']=='submit_data'){
	
	if(!isset($post['beneficiary_nickname'])||!$post['beneficiary_nickname']){
		 $data['Error']='Nick Name should not be empty.';
	}elseif(!isset($post['beneficiary_name'])||!$post['beneficiary_name']){
		$data['Error']='Beneficiary Name should not be empty.';
	}elseif(!isset($post['account_number'])||!$post['account_number']){
		$data['Error']='Account Number should not be empty.';
	}elseif(!isset($post['repeated_account_number'])||!$post['repeated_account_number']){
		$data['Error']='Repeated Account Number should not be empty.';
		
	}elseif($post['account_number']!=$post['repeated_account_number']){
		$data['Error']='Account Number and Repeated Account Number not Matched.';
		
	}elseif(!isset($post['bank_name'])||!$post['bank_name']){
		$data['Error']='Bank Name should not be empty.';
	}else{
		$client_ip=$_SERVER['REMOTE_ADDR'];
	
		$sqlStmt = "INSERT INTO `{$data['DbPrefix']}payout_beneficiary` (`id`, `clientid`, `beneficiary_nickname`,`bank_name`, `beneficiary_name`, `account_number`, `bank_code1`, `bank_code2`, `bank_code3`, `beneficiaryEmailId`, `beneficiaryPhone`, `udf1`, `udf2`, `status`, `client_ip`, `host_name`) VALUES (NULL, '".$uid."', '".$post['beneficiary_nickname']."','".$post['bank_name']."', '".$post['beneficiary_name']."', '".$post['account_number']."', '".$post['bank_code1']."', '".$post['bank_code2']."', '".$post['bank_code3']."', '".$post['beneficiaryEmailId']."', '".$post['beneficiaryPhone']."', '".$post['udf1']."', '".$post['udf2']."', 1, '{$client_ip}', '".$_SERVER['HTTP_HOST']."')";
	
		db_query_2($sqlStmt,0);

		$newId = newid_2();
		
		if($newId)
		{
			json_log_upd_payout($newId,'payout_beneficiary'); 
			$bene_id = gen_transID_f($newId,$uid);
			
			db_query_2(
				"UPDATE `{$data['DbPrefix']}payout_beneficiary` SET `bene_id`='$bene_id' WHERE `id`='{$newId}'"
			);
		}else{
			$_SESSION['Error']="Data Not Inserted Please Try again";
			header("Location:{$data['Host']}/user/beneficiaries{$data['ex']}");exit;
		}
					
		 $_SESSION['action_success']="Beneficiary Added Successfully";				
		 header("Location:{$data['Host']}/user/beneficiaries{$data['ex']}");exit;
	}
	$_SESSION['Error']=$data['Error'];
	header("Location:{$data['Host']}/user/beneficiaries{$data['ex']}");exit;
	
}
################
display('user');
################
?>