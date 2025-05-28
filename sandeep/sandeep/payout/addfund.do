<?
include('../config.do');

$str=file_get_contents("php://input");
$json = json_decode($str, true);
//print_r($json);
$json=$json[0];


if(!isset($_REQUEST['pram_encode'])){
	$_SESSION['Error'] = 'ACCESS DENIED!! request invalid';
	
	$respo['status']="0005";
	$respo['reason']="ACCESS DENIED!! request invalid";
	json_print($respo);
}

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
//print_r($decode_token);exit;

$sub_client_id = json_decode($decode_token,1)['tid'];

//$respo['pram_encode1']	= $post['payout_token'];
//$respo['decode_token']	= $decode_token;
//$respo['sub_client_id']		= $sub_client_id;

//print_r($decode_token);

if(!$sub_client_id)
{
	$respo['status']="0005";
	$respo['reason']="Unauthorized - Invalid payout token or Invalid secret key";
	json_print($respo);
	exit;
}

$de_token = json_decode($decode_token,1);
$tid=$de_token['tid'];

$acc_row = select_tablef("`id`='{$sub_client_id}' ",'clientid_table',0,1);

$secret_key		= $acc_row['apikey'];
$payoutFee		= $acc_row['payoutFee'];
$payout_request	= $acc_row['payout_request'];

//$payout_secret_key	= json_decode($acc_row['payout_secret_key'],1)['decrypt'];
$payout_token	= $acc_row['payout_token'];

$data_decode = data_decode_sha256($pram_encode,$secret_key,$post['payout_token']);

parse_str($data_decode, $output);

//$de_submit_secret_key	= encode_f($output['payout_secret_key'],1);
//$en_submit_secret_key	= json_decode($de_submit_secret_key,1)['decrypt'];


//$respo['status']="$de_submit_secret_key";
//$respo['reason']="$en_submit_secret_key";
//json_print($respo);

$sub_client_id = ltrim($sub_client_id, "0");


$payout_token		= $output['payout_token'];
$client_ip			= $output['client_ip'];
$action				= $output['action'];
$source				= $output['source'];
$payout_secret_key	= $output['payout_secret_key'];
$amount				= $output['amount'];
$curr				= $output['curr'];
//	$ac_default_curr	= $output['ac_default_curr'];
$product_name		= $output['product_name'];
$transaction_id		= $output['transaction_id'];
$beneficiary_id		= $output['beneficiary_id'];
$remarks	= $output['remarks'];
$narration	= $output['narration'];

if(isset($output['sender_name']))
	$sender_name	= $output['sender_name'];
else 
	$sender_name	= "";

$request['request'] = $output;

unset($request['request']['payout_secret_key']);
unset($request['request']['payout_token']);
$txn_value=json_encode($request);

if($payout_request==2) $transaction_status = 9;
else $transaction_status = 0;

$sqlStmt = "INSERT INTO `{$data['DbPrefix']}payout_transaction`(".
	"`transaction_id`, `sub_client_id`, `transaction_type`, `transaction_for`, `transaction_currency`, `transaction_amount`, `sender_name`,`beneficiary_id`,`transaction_status`,`remarks`,`narration`,`txn_value`,`transaction_date`,`created_date`) VALUES(".
"'{$transaction_id}', '{$sub_client_id}','1', '{$product_name}', '{$curr}', '{$amount}',  '{$sender_name}', '{$beneficiary_id}', '{$transaction_status}','$remarks','$narration','$txn_value','".CURRENT_TIME."','".CURRENT_TIME."')";
	
db_query_2($sqlStmt,0);
$newId = newid_2();

if($newId)
{
    json_log_upd_payout($newId,'payout_transaction',$sub_client_id);
	$respo['status']	="0000";
	$respo['transaction_id']=$transaction_id;
	$respo['reason']	="Success";
	$respo['amount']	=$amount;
	json_print($respo);
}
else 
{
	$respo['status']="0002";
	///$respo['sqlStmt']=$sqlStmt;
	json_print($respo);
}



//exit;

?>