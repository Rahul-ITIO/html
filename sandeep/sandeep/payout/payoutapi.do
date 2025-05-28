<?php
include('../config.do');


$str=file_get_contents("php://input");
$json = json_decode($str, true);
//print_r($json);
$json=$json[0];



if(isset($_REQUEST['pram_encode'])&&$_REQUEST['pram_encode']){
		$pram_encode1=strip_tags($_REQUEST['pram_encode']);
		$post['payout_token'] = substr( $pram_encode1, -86 );
		if($data['localhosts']==true){
			//$post['payout_token'] = substr( $pram_encode1, -30 );
		}
		$pram_encode=str_replace($post['payout_token'],'',$pram_encode1);
		if(isset($_REQUEST['pe'])){
			//echo "<br/><br/>1payout_token=>".$post['payout_token']; echo "<br/><br/>pram_encode1=>".$pram_encode1;
		}
		
	}

$decode_token = decode_f($post['payout_token'],0);
//print_r($decode_token);


//print_r($decode_token);
$de_token  = json_decode($decode_token,1);
$tid=$de_token['tid'];

$ben_row = select_tablef("`id`='{$tid}' ",'payout_beneficiary',0,1);
//print_r($ben_row);
$ben_payout_token 	= $ben_row['payout_token'];
$ben_payout_secret_key 	= $ben_row['payout_secret_key'];



$acc_row = select_tablef("`id`='{$ben_row['clientid']}' ",'clientid_table',0,1);
$secret_key = $acc_row['private_key'];



$data_decode= data_decode_f($pram_encode,$secret_key,$post['payout_token']);

parse_str($data_decode, $output);

//print_r($output);




$serverval=$_SERVER['HTTP_REFERER'];
$servername=$_SERVER['SERVER_NAME'];

//print_r($data['all_host']);
//print_r($_SERVER);

if($ben_payout_secret_key==encode_f($output['payout_secret_key'],0))
{
//	if(strstr($serverval, '/transactions')&& isset($servername)&& $data['all_host'] && in_array($servername,$data['all_host']))
	{
	
	
	$find_duplicate=db_rows_2(
				"SELECT `related_transaction_id` FROM `{$data['DbPrefix']}payout_transaction`".
				" WHERE `related_transaction_id`='{$json['related_transaction_id']}' LIMIT 1",0//,true
			);
	$find_duplicate=$find_duplicate[0]['related_transaction_id'];
	
		if(isset($find_duplicate)&&$find_duplicate){
		$respo['status']="Failed";
		$respo['reason']="Duplicate";
		json_print($respo);
		}else{
	
	
			db_query_2(
					"INSERT INTO `{$data['DbPrefix']}payout_transaction`(".
					"`sub_client_id`,`transaction_type`,`transaction_for`,`transaction_currency`,`transaction_amount`,`sender_name`,`remarks`".
					",`converted_transaction_currency`,`converted_transaction_amount`,`transaction_status`,`related_transaction_id`,`transaction_date`,`created_date`".
					")VALUES(".
					"'{$json['sub_client_id']}','{$json['transaction_type']}','{$json['transaction_for']}','{$json['transaction_currency']}','{$json['transaction_amount']}',".
					"'{$json['sender_name']}','{$json['remarks']}','{$json['converted_transaction_currency']}','{$json['converted_transaction_amount']}','1',".
					"'{$json['related_transaction_id']}','".CURRENT_TIME."','".CURRENT_TIME."'".
					")",0
					);
					$newid=newid_2();
					
			$respo['status']="Success";
			$respo['insertid']=$newid;
			json_print($respo);
		}
	}
}
else{
	$respo['status']="Failed";
	$respo['reason']="Unauthorized";
	json_print($respo);
}

function data_decode_f($string,$secret_key,$website_payout_token) {
    $output = false;
    $encrypt_method = "AES-256-CBC";
    $iv = substr( hash( 'sha256', $website_payout_token ), 0, 16 );
	$output = openssl_decrypt( base64_decode( $string ), $encrypt_method, $secret_key, 0, $iv );
    return $output;
}

?>