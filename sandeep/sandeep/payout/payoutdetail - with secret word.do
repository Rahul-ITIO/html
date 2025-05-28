<?php
include('../config.do');

/*$str=file_get_contents("php://input");
$json = json_decode($str, true);
//print_r($json);
$json=$json[0];
*/
if(isset($_REQUEST['pram_encode'])&&$_REQUEST['pram_encode']){

	$pram_encode1=strip_tags($_REQUEST['pram_encode']);
	$post['payout_token'] = substr( $pram_encode1, -86);

	if($data['localhosts']==true){
		//$post['payout_token'] = substr( $pram_encode1, -30 );
	}

	$pram_encode=str_replace($post['payout_token'],'',$pram_encode1);
	if(isset($_REQUEST['pe'])){
		//echo "<br/><br/>payout_token=>".$post['payout_token']; echo "<br/><br/>pram_encode1=>".$pram_encode1;
	}
}

//print_r($post);
$decode_token = decode_f($post['payout_token'],0);
//print_r($decode_token);

$sub_client_id = json_decode($decode_token,1)['tid'];

if(!$sub_client_id)
{
	$respo['status']="0005";
	$respo['reason']="Unauthorized - Invalid payout token or Invalid secret key";
	json_print($respo);
	exit;
}
//$respo['pram_encode1']	= $post['payout_token'];
//$respo['decode_token']	= $decode_token;
//$respo['sub_client_id']		= $sub_client_id;

//print_r($decode_token);
$de_token = json_decode($decode_token,1);
$tid=$de_token['tid'];

$acc_row = select_tablef("`id`='{$sub_client_id}' ",'clientid_table',0,1);

$secret_key			= $acc_row['apikey'];
$payoutFee			= $acc_row['payoutFee'];
$payout_secret_key	= json_decode($acc_row['payout_secret_key'],1)['decrypt'];
$payout_token		= $acc_row['payout_token'];

$data_decode = data_decode_sha256($pram_encode,$secret_key,$post['payout_token']);

parse_str($data_decode, $output);

$de_submit_secret_key	= encode_f($output['payout_secret_key'],1);
$en_submit_secret_key	= json_decode($de_submit_secret_key,1)['decrypt'];


//$respo['status']="$de_submit_secret_key";
//$respo['reason']="$en_submit_secret_key";
//json_print($respo);


$sub_client_id = ltrim($sub_client_id, "0");

if($payout_secret_key==$en_submit_secret_key)
{
	$payout_token		= $output['payout_token'];
	$client_ip			= $output['client_ip'];
	$action				= $output['action'];
	$source				= $output['source'];
	$payout_secret_key	= $output['payout_secret_key'];
	$transaction_id		= $output['transaction_id'];
	$order_number		= $output['order_number'];

	if(strtolower($action)!="paymentdetail")
	{
		$respo['status']	="0006";
		$respo['reason']	="Invalid value in action";
		json_print($respo);
	}
	elseif(!$transaction_id)
	{
		$respo['status']	="0007";
		$respo['reason']	="transaction_id required";
		json_print($respo);	
	}
	elseif(!$order_number)
	{
		$respo['status']	="0008";
		$respo['reason']	="order_number required";
		json_print($respo);	
	}
	else{
		$sqlStmt = "SELECT *FROM `{$data['DbPrefix']}payout_transaction` WHERE `transaction_id`='{$transaction_id}' AND sub_client_id='{$sub_client_id}'";

		$trans_detail = db_rows_2($sqlStmt,0);

		if(isset($trans_detail[0])&&count($trans_detail[0])>0)
		{
			$trans_de	= $trans_detail[0];
			$mrid		= $trans_de['mrid'];

			if($mrid==$order_number)
			{
				$respo['status'] ="0000";
				$respo['transaction_type']		= $trans_de['transaction_type'];
				$respo['transaction_for']		= $data['payoutProduct'][$trans_de['transaction_for']];
				$respo['transaction_date']		= $trans_de['transaction_date'];
				$respo['order_currency']		= $trans_de['transaction_currency'];
				$respo['order_amount']			= $trans_de['transaction_amount'];
				$respo['transaction_currency']	= $trans_de['converted_transaction_currency'];
				$respo['transaction_amount']	= $trans_de['converted_transaction_amount'];
				$respo['mdr_amt']				= $trans_de['mdr_amt'];
				$respo['mdr_percentage']		= $trans_de['mdr_percentage'];
				$respo['payout_amount']			= $trans_de['payout_amount'];
				$respo['available_balance']		= $trans_de['available_balance'];
				$respo['sender_name']			= $trans_de['sender_name'];
				$respo['beneficiary_id']		= $trans_de['beneficiary_id'];
				$respo['remarks']				= $trans_de['remarks'];
				$respo['narration']				= $trans_de['narration'];
				$respo['transaction_status']	= $trans_de['transaction_status'];
				$respo['notify_url']			= $trans_de['notify_url'];
				$respo['success_url']			= $trans_de['success_url'];
				$respo['failed_url']			= $trans_de['failed_url'];
				$respo['host_name']				= $trans_de['host_name'];
				json_print($respo);
			}
			else
			{
				$respo['status']	="0010";
				$respo['reason']	="Order - $order_number not exists";
				json_print($respo);	
			}
		}
		else
		{
			$respo['status']	="0009";
			$respo['reason']	="transaction_id - $transaction_id not exists";
			json_print($respo);	
		}
	}
}
else{
	$respo['status']="0004";
	$respo['reason']="Unauthorized";
	json_print($respo);
}

//exit;

?>