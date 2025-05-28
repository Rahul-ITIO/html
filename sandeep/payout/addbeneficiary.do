<?
include('../config.do');

$str	= file_get_contents("php://input");
$json	= json_decode($str, true);
//print_r($json);
$json	=$json[0];

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
$de_token  = json_decode($decode_token,1);
$tid=$de_token['tid'];

//$acc_row = select_tablef("`id`='{$sub_client_id}' ",'clientid_table',0,1);
$acc_row = clientidf($sub_client_id,'payout_setting');

$secret_key			= $acc_row['private_key'];
$payoutFee 			= $acc_row['payoutFee'];
//$respo['payout_secret_key1']=$acc_row['payout_secret_key'];
$payout_secret_key	= jsondecode($acc_row['payout_secret_key'],1,1)['decrypt'];
$payout_secret_key_gt= json_decode($acc_row['payout_secret_key'],1)['gt'];	//get payout key generate
//$respo['payout_secret_key2']=$payout_secret_key;
$payout_token		= $acc_row['payout_token'];

/*
$json_value 		= jsondecode($acc_row['json_value'],1);
$whitelisted_ips	= $json_value['whitelisted_ips'];
*/

$whitelisted_ips	= @$acc_row['whitelisted_ips'];

$ips_array = explode(",",$whitelisted_ips);


$data_decode= data_decode_sha256($pram_encode,$secret_key,$post['payout_token']);

parse_str($data_decode, $output);

$de_submit_secret_key 	= encode_f($output['payout_secret_key'],1);
$en_submit_secret_key	= json_decode($de_submit_secret_key,1)['decrypt'];

$is_ip_validation=true;

####	check is our host page	####################
$http_referer_log=0;
if(isset($_SERVER['HTTP_REFERER'])) 
$http_referer_host=$_SERVER['HTTP_REFERER'];
else $http_referer_host='';
if($http_referer_host){
	//echo "<br/>http_referer_host=>".$http_referer_host."<br/>";
	foreach($data['all_host'] as $ke=>$vl){
		//echo "<br/>$ke=>".$vl;
		if(($vl)&&(strpos($http_referer_host,$vl)!==false)){
			//echo "<br/>$ke=>".$vl;
			$http_referer_log=1; 
			break;
		}
	}
}
//echo "<br/>http_referer_log=>".$http_referer_log."<br/>";

if((isset($output['mer_id'])&&$output['mer_id']==$sub_client_id)&&((isset($_SERVER['HTTP_REFERER']))&&($http_referer_log==1))){
	$is_ip_validation=false;
}




//$respo['status']="$de_submit_secret_key";
//$respo['reason']="$en_submit_secret_key";
//json_print($respo);

$serverval	=$_SERVER['HTTP_REFERER'];
$servername	=$_SERVER['SERVER_NAME'];

$sub_client_id	= ltrim($sub_client_id, "0");

$curr_time = time();
$cooling_period = round(abs($curr_time - $payout_secret_key_gt) / 60,2);	//calculate time from when payout key generated in minutes - 


if($payout_secret_key!=$en_submit_secret_key){
	$_SESSION['Error'] = 'ACCESS DENIED!! Secret Word not match';
	
	$respo['status']="0004";
	$respo['reason']="ACCESS DENIED!! Secret Word not match";
	json_print($respo);
}
elseif($cooling_period<1440) // if the time is less than 1440 minutes (24 hrs) then not allow transfer fund
{
	$respo['status']="0011";
	$respo['reason']="Payout Secret Key is in cooling period.";
	json_print($respo);
	exit;
}
else
{
	$client_ip				= $output['client_ip'];
	$beneficiary_nickname	= $output['beneficiary_nickname'];
	$beneficiary_name		= $output['beneficiary_name'];
	$account_number			= $output['account_number'];
	$beneficiary_ac_repeat	= $output['beneficiary_ac_repeat'];
	$beneficiary_bank_name	= $output['beneficiary_bank_name'];

	$bank_code1			= $output['bank_code1'];
	$bank_code2			= $output['bank_code2'];
	$bank_code3			= $output['bank_code3'];
	$beneficiaryEmailId = $output['beneficiaryEmailId'];
	$beneficiaryPhone	= $output['beneficiaryPhone'];
	$udf1				= $output['udf1'];
	$udf2				= $output['udf2'];
	$notify_url			= $output['notify_url'];

	$payout_secret_key	= $output['payout_secret_key'];

	$sqlStmt = "SELECT id FROM `{$data['DbPrefix']}payout_beneficiary` WHERE clientid='{$sub_client_id}' AND account_number ='{$account_number}' AND bank_code2 ='{$bank_code2}'";
	$check_record = db_rows_2($sqlStmt);
	
	/*if(!in_array($client_ip, $ips_array)&&$is_ip_validation)
	{
		$respo['status']="0011";
		$respo['reason']="Access Denied for client ip or IP not whitelisted, Please Contact Support.";//.print_r($ips_array);
	}
	else */ if($account_number!=$beneficiary_ac_repeat)
	{
		$respo['status']="0001";
		$respo['reason']="Bank Account Number and Bank Account Number_repeat not match";
		$respo['account_number']=$account_number;
	}
	elseif(isset($check_record[0]['id'])&&$check_record[0]['id'])
	{
		$respo['status']="0002";
		$respo['reason']="Duplicate Entry";
		$respo['account_number'] =$account_number;
	}
	else
	{
		$sqlStmt = "INSERT INTO `{$data['DbPrefix']}payout_beneficiary` (`id`, `clientid`, `beneficiary_nickname`,`bank_name`, `beneficiary_name`, `account_number`, `bank_code1`, `bank_code2`, `bank_code3`, `beneficiaryEmailId`, `beneficiaryPhone`, `udf1`, `udf2`, `status`,`client_ip`,`notify_url`,`host_name`) VALUES (NULL, '".$sub_client_id."', '".$beneficiary_nickname."','".$beneficiary_bank_name."', '".$beneficiary_name."', '".$account_number."', '".$bank_code1."', '".$bank_code2."', '".$bank_code3."', '".$beneficiaryEmailId."', '".$beneficiaryPhone."', '".$udf1."', '".$udf2."', 1, '{$client_ip}', '{$notify_url}', '".$_SERVER['HTTP_HOST']."')";
	
		db_query_2($sqlStmt);
	
		$newId = newid_2();
	
		if($newId)
		{
			json_log_upd_payout($newId,'payout_beneficiary',$sub_client_id); 
		
			$bene_id = gen_transID_f($newId,$sub_client_id);
	
			unset($output['payout_token']);
			unset($output['payout_secret_key']);
			unset($output['beneficiary_ac_repeat']);

			$output['account_number']=@mask($output['account_number'],0,4);			
	
			$req['request']		=$output;
			$req['bene_id']		=$bene_id;
			$req['create_date']	=CURRENT_TIME;
			$req['SERVER']['HTTP_X_FORWARDED_FOR']	=@$_SERVER['HTTP_X_FORWARDED_FOR'];
			$req['SERVER']['REMOTE_ADDR']			=@$_SERVER['REMOTE_ADDR'];
			$req['SERVER']['SERVER_ADDR']			=@$_SERVER['SERVER_ADDR'];
			$req['SERVER']['SERVER_PORT']			=@$_SERVER['SERVER_PORT'];
			$req['SERVER']['HTTP_HOST']				=@$_SERVER['HTTP_HOST'];
			$req['SERVER']['REQUEST_TIME']			=@$_SERVER['REQUEST_TIME'];
			$req['SERVER']['REQUEST_TIME_FLOAT']	=@$_SERVER['REQUEST_TIME_FLOAT'];
			$req['SERVER']['HTTP_REFERER']			=@$_SERVER['HTTP_REFERER'];
			$req['SERVER']['REQUEST_URI']			=@$_SERVER['REQUEST_URI'];

			$json_log = json_encode($req);
	
			db_query_2(
				"UPDATE `{$data['DbPrefix']}payout_beneficiary` SET `bene_id`='$bene_id',`json_log`='$json_log' WHERE `id`='{$newId}'"
			);
			$respo['status']	="0000";
			$respo['bene_id']	=$bene_id;
			$respo['reason']	="Success";
			$respo['remark']	="Beneficiary successfully added";
			//json_print($respo);
		}
		else
		{
			$respo['status']="0001";
			//	$respo['reason']="Beneficiary already exists";
			$respo['sqlStmt']=$sqlStmt;
			json_print($respo);
		}
	}
}
if($notify_url){
	$notify_url_exist = @get_headers($notify_url);
	if(strpos($notify_url_exist[0],'404') !== false)
	{
		//$json_array['error']='Invalid Notify URL'; json_print($respo); exit;
		$respo['notify']="404 Page not found!";
		$respo['notify_url']=$notify_url;
	}
	else{
		$respo['notify']="OK";
		use_curl($notify_url, $respo);
	}		
}
json_print($respo);
exit;
?>