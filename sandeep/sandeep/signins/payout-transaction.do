<?
$data['PageName']	= 'Payout Transaction';
$data['PageFile']	= 'payout-transaction';

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
if(isset($post['action'])&&($post['action']=='approved')){
	if(isset($post['bid'])&&$post['bid']){
		$gid = $post['bid'];
		$mid = @$post['mid'];
		
		if(isset($_GET['mid'])) $mid = $_GET['mid'];

		if($mid){
		
			$acc_row	= select_tablef("`id`='{$mid}' ",'clientid_table',0,1);
			$payoutFee	= $acc_row['payoutFee'];
			$payout_account	= $acc_row['payout_account'];
			
			$bank_master	= select_tablef("`id` = '".$payout_account."'",'bank_payout_table');
			$ac_account_no	= $bank_master['payout_id'];
			$ac_default_curr= $bank_master['payout_processing_currency'];

			if(isset($_GET['order_curr']))	$order_curr	= $_GET['order_curr'];
			if(isset($_GET['order_amt']))	$order_amt	= $_GET['order_amt'];
			if(isset($_GET['accepted_amt'])){
				$accepted_amt	= $_GET['accepted_amt'];
				$order_amt = $accepted_amt;
				$payoutFee = 0;
			}
			//CONVERT CURRENCY - START
			if($order_curr!=$ac_default_curr)
			{
				$currencyConverter_2		= currencyConverter($order_curr, $ac_default_curr, $order_amt,0,1);
				$json["currencyConverter"]	= $currencyConverter_2;
				$transaction_amt			= $currencyConverter_2['converted_amount'];
			}
			else $transaction_amt = $order_amt;
			//CONVERT CURRENCY - END

			$mdr_amt = (($transaction_amt*$payoutFee)/100);
			$payout_amount = prnsum2($transaction_amt-$mdr_amt);

			$bal_detail = db_rows_2(
				"SELECT available_balance FROM `{$data['DbPrefix']}payout_transaction`" .
				" WHERE `sub_client_id`='{$mid}' AND `transaction_status`='1' ORDER BY transaction_date DESC LIMIT 1"
			);

			if(isset($bal_detail[0]['available_balance'])){
			 	$balance = $bal_detail[0]['available_balance'];
			}
			else 
				$balance = 0;

			$available_balance = prnsum2(($balance+$transaction_amt));
		}

		
		$t_sql = "SELECT * FROM `{$data['DbPrefix']}payout_transaction` WHERE `sub_client_id`='{$mid}' AND `id`='{$gid}' LIMIT 1";
		$trans_detail=db_rows_2($t_sql,0);

		$transaction_currency	= $trans_detail[0]['transaction_currency'];
		$transaction_amount		= $trans_detail[0]['transaction_amount'];
		$json_log	= $trans_detail[0]['json_log'];
		$json_arr	= json_decode($json_log,1);
		
		$support_notes	= $trans_detail[0]['support_notes'];

		$txn_value = json_decode($trans_detail[0]['txn_value'],1);

//		$json_arr['approved']=isset($_SESSION['adm_login'])?$_SESSION['adm_login']:$_SESSION['sub_admin_id'];
		$json_arr['approved']['order_currency']=$transaction_currency;
		$json_arr['approved']['order_amount']=$transaction_amount;
		$json_arr['approved']['transaction_currency']=$ac_default_curr;
		$json_arr['approved']['transaction_amount']=$transaction_amt;
		$json_arr['approved']['mdr_percentage']=$payoutFee;
		$json_arr['approved']['mdr_amt']=$mdr_amt;
		$json_arr['approved']['payout_amount']=$payout_amount;
		$json_arr['approved']['available_balance']=$available_balance;
		$json_arr['approved']['remarks']=$_GET['remarks'];

		if(isset($accepted_amt)&&$accepted_amt) $json_arr['approved']['accepted_amt']=$accepted_amt;

		$json_log = json_encode($json_arr);	//convert into json

		if(isset($_SESSION['sub_admin_id'])){
			$byusername=$_SESSION['sub_admin_id'].":".$_SESSION['sub_admin_fullname']."-".$_SESSION['sub_admin_rolesname'];
		}elseif(isset($_SESSION['m_username'])&&(!isset($_SESSION['adm_login']))){
			$byusername="Merchant:".$_SESSION['uid']."-".$_SESSION['m_username'];
		}else{
			if(isset($_SESSION['admin_id'])&&isset($_SESSION['sub_username'])){
				$byusername="Admin : ".$_SESSION['admin_id']." - ".$_SESSION['sub_username'];
			}else{
				$byusername='Admin';
			}
		}

		if(isset($_GET['remarks'])&&$_GET['remarks'])
		{
			$support_notes = "Update on ".prndate(CURRENT_TIME)." by $byusername : ".$_GET['remarks']." (".$_SERVER['REMOTE_ADDR'].")<br />".$support_notes;

			if($trans_detail[0]['remarks'])
				$reason = ",remarks='".$trans_detail[0]['remarks']."<br />".$_GET['remarks']."'"; 
			else
				$reason = ",remarks='".$_GET['remarks']."'"; 
		}
		
		else $reason='';
	
		
		$sqlStmt = "UPDATE `{$data['DbPrefix']}payout_transaction`".
			"SET `transaction_status`='1', converted_transaction_currency='$ac_default_curr', converted_transaction_amount='$transaction_amt', mdr_percentage='$payoutFee', mdr_amt='$mdr_amt', available_balance='$available_balance',payout_amount='$payout_amount', transaction_date='".CURRENT_TIME."' ".$reason.",`support_notes`='$support_notes',`json_log`='$json_log' WHERE `id`='{$gid}' AND `sub_client_id`='{$mid}'";

		//echo $sqlStmt;exit;

		db_query_2($sqlStmt);

		json_log_upd_payout($gid,'payout_transaction');
 
		$_SESSION['action_success']='Transaction approved successfully !!';
		header("location:{$data['Admins']}/payout-transaction".$data['ex']);exit;
	}
}
elseif(isset($post['action'])&&($post['action']=='fail')){
	if(isset($post['bid'])&&$post['bid']){

		$gid = $post['bid'];
		
		###############
		$t_sql = "SELECT * FROM `{$data['DbPrefix']}payout_transaction` WHERE `id`='{$gid}' LIMIT 1";
		$trans_detail=db_rows_2($t_sql,0);

		$json_log		= $trans_detail[0]['json_log'];
		$support_notes	= $trans_detail[0]['support_notes'];
		$txn_value		= json_decode($trans_detail[0]['txn_value'],1);
		$json_arr		= json_decode($json_log,1);

		if(isset($_SESSION['sub_admin_id'])){
			$byusername=$_SESSION['sub_admin_id'].":".$_SESSION['sub_admin_fullname']."-".$_SESSION['sub_admin_rolesname'];
		}elseif(isset($_SESSION['m_username'])&&(!isset($_SESSION['adm_login']))){
			$byusername="Merchant:".$_SESSION['uid']."-".$_SESSION['m_username'];
		}else{
			if(isset($_SESSION['admin_id'])&&isset($_SESSION['sub_username'])){
				$byusername="Admin : ".$_SESSION['admin_id']." - ".$_SESSION['sub_username'];
			}else{
				$byusername='Admin';
			}
		}

		if(isset($_GET['remarks'])&&$_GET['remarks'])
		{
			$json_arr['remarks']=$_GET['remarks'];
			$json_log = json_encode($json_arr);	//convert into json
			
			$support_notes = "Update on ".prndate(CURRENT_TIME)." by $byusername : ".$_GET['remarks']." (".$_SERVER['REMOTE_ADDR'].")<br />".$support_notes;

			if($trans_detail[0]['remarks'])
				$reason = ",remarks='".$trans_detail[0]['remarks']."<br />".$_GET['remarks']."'"; 
			else
				$reason = ",remarks='".$_GET['remarks']."'"; 
		}
		
		else $reason='';

		$sqlStmt = "UPDATE `{$data['DbPrefix']}payout_transaction`".
			"SET transaction_status='2', transaction_date='".CURRENT_TIME."'".$reason.",`support_notes`='$support_notes',`json_log`='$json_log' WHERE `id`='{$gid}'";
		
		//echo $sqlStmt;exit;
		db_query_2($sqlStmt,0);

		json_log_upd_payout($gid,'payout_transaction');
 
		$_SESSION['Error']='Transaction rejected!!';
		header("location:{$data['Admins']}/payout-transaction".$data['ex']);exit;
	}
}
else{}

if($post['step']==1){

	//$data['MaxRowsByPage']=50;
	
	if(isset($_REQUEST['page'])){$page=$_REQUEST['page'];unset($_REQUEST['page']);}else{$page=1;}

	$data['startPage'] = $page;
	$start	= ($page-1)*$data['MaxRowsByPage'];
	$end	= isset($_REQUEST['records_per_page'])&&$_REQUEST['records_per_page']?$_REQUEST['records_per_page']:$data['MaxRowsByPage'];
	
	$limit	= " LIMIT $start, $end";
	
	$requrl	= $sql_query = "";
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
		$sql_query.=" AND `transaction_status` = '" .trim($_GET['status'])."'";
		$requrl.="& transaction_status =".$_GET['status'];
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
###############################################################################

display('admins');

###############################################################################

?>