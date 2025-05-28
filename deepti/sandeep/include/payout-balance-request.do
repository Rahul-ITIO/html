<?
include('../config.do');

if($_REQUEST["memid"]){
	
	$memid = $_REQUEST["memid"];

	$memb_data		= select_tablef("`id` = '".$memid."'",'clientid_table');
	$payout_setting_row = clientidf($memid,'payout_setting');
	if(isset($payout_setting_row)&&is_array($payout_setting_row))
	$memb_data=array_merge($memb_data,$payout_setting_row);
	
	$payout_account	= $memb_data['payout_account'];
	 
	$bank_master	= select_tablef("`id` = '".$payout_account."'",'bank_payout_table');
	$ac_payout_id	= $bank_master['payout_id'];
	$ac_default_curr= $bank_master['payout_processing_currency'];	//fetch Bank Processing default currency

	$balamt	=0.00;
	$field	="`transaction_status` IN (1) AND `sub_client_id`='$memid' ";
	//$field	="`transaction_status` NOT IN (2) AND `sub_client_id`='$memid' ";

	//fetch the sum of success transactions via real time calculatioin
	$sqlStmt = "SELECT SUM(converted_transaction_amount) AS balance FROM `{$data['DbPrefix']}payout_transaction` WHERE $field";
	//$check_balance = db_rows_2($sqlStmt);
	
	//fetch available_balance as last success transaction
	$sqlStmt = "SELECT available_balance AS balance FROM `{$data['DbPrefix']}payout_transaction` WHERE $field ORDER by transaction_date DESC, id DESC LIMIT 0,1";
	$check_balance = db_rows_2($sqlStmt,0);

	if(isset($check_balance[0]['balance'])&&$check_balance[0]['balance'])
		$balance = $check_balance[0]['balance'];
	else
		$balance = 0;
	

	$curr = get_currency($ac_default_curr);
	echo $balamt=$curr." ".number_format((float)$balance, 2, '.', '');
}
?>