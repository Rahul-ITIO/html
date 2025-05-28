<?php
include('../../config_db.do');
$encryptedKey='NW4R8OGM57XmIz99p8/phzDUMduuQbhnU4wYp2NRZja8FEhEugvY0Wc61+bf5n2gpsc5zheomtZ1sxlrmO7WbdueLwxdrfPoHHYdWwL7sd7qh+nP3XtNWvw8JYAP0ujt9fjVgdFxe97MvLW5wOEpr794pYdOhA5YCWEb9eVrY36frXPUxIOa/T/i8CGhwuHb5ImR/3xXK4yMpFvr6s1WQ8xeOAy/seyLZcx787r4dUcvoZHJzIYH7joIBH6zgl/scGhfvfCN07MHZrlPw/CZL5w20qlPw2Pkjlxf59OhN2kCx2/V/egeQXWBY3UzncKpRxfg3QjsW6BH0iz8dXaPmjM4DfPP0UyJOOpU6o1GZ/tRmMFUskJ/VK2PhEs7wjJ+zBDpWA4Vp0n5t4Ad5xZxFbvSY3UlCDu1eI3q84uEGS57c/EzVHxb5gunp0NxeQ1jKxwXoyJ+rqemZrQCcvGLKG7IQ3QZn/jz6sN/2o6gSEuOaWivtxI/LmPbH8v6NuGKWTlpt1bnMCcjtuGiN6yKwmcxrAINPhR8PuImR1pO1Pfh9OqJJjEALc6PFnzU+wvWSEiz+N0iUflGqvSdOIsq1+7Mv5Wgu76kEsgoB0F1jCqhazrqk0AbZJMmGCf2PVH4FvAHbiqSQyc+lKTYcd4WSXUi1TdzoYG9BkBMep2nqcs=';

$enc="P1zxue4e/MvDhZjej56hoWl3E6t8/pFfvR9lBHdBlLCPsPNXkAMv/8gaIe+C2Qt3DuptKzUfzqd1duhBT3hq6sN8mhP2Hp0IVWIPEBpet2dURdmzQWSGvkXaUo5KwgZ5k/G/IxNu6a+972PnUXq33+WVgm0NfIeFEjJObAoSODm2PD688Cd+F4MxZL/7H3Khb7aI6Hyhf5OhV+jAuwhcw1l64a8cAGyhV48JuH1jKU6/5YGORaWqarmBiGLSveWLuB5o0EfUooVUJMiz6SWKMKTs2mD7AQ4qjzj5dNIsAQm82orvhcYKqgCIbn9oSNqXasAjKC1/gHjzJTfHlgCMY2YZ+iUdPGNgeYkiV+pbaHTkQ8+STdrgo0qIVd6uApqslGLLleuLolQdRRS7tPF31jc9O8Eqxkzu8gwnJQxGRIDEYjRQB7kFyoxDI1ibNqP+";


$fp= fopen($data['Path'].'/payin/pay69/live_privatekey.key',"r");
$priv_key=fread($fp,8192);
fclose($fp);

$res = openssl_get_privatekey($priv_key, "");
openssl_private_decrypt(base64_decode($encryptedKey), $key, $res);
$encData = base64_decode($enc); 
$encData = openssl_decrypt($encData,"aes-128-cbc",$key,OPENSSL_PKCS1_PADDING);

$newsource = substr($encData, 16); 


$log = "RESPONSE - ".$raw_response."\n\n";
$log.= "RESPONSE DECRYPTED - ".$newsource."\n\n";

//if($qp)
{
	echo nl2br($log);
	exit;
}
$responseParamList = json_decode($newsource,1);
if(isset($responseParamList['merchantTranId'])&&$responseParamList['merchantTranId'])
{
	$_REQUEST['transID'] = $responseParamList['merchantTranId'];
	$_REQUEST['actionurl']='notify';
}


$is_curl_on = true;
if(!isset($data['STATUS_ROOT'])){
	include('../../config_db.do');

	########## callback section #############

	$str=file_get_contents("php://input");
	if($str)
	{
		$is_curl_on = false;
		$request = json_decode($str);
	
		$fp= fopen($data['Path'].'/payin/pay69/live_privatekey.key',"r");
		$priv_key=fread($fp,8192);
		fclose($fp);
	
		$res = openssl_get_privatekey($priv_key, "");
		openssl_private_decrypt(base64_decode($request->encryptedKey), $key, $res);
		$encData = base64_decode($request->encryptedData); 
		$encData = openssl_decrypt($encData,"aes-128-cbc",$key,OPENSSL_PKCS1_PADDING);
		
		$newsource = substr($encData, 16); 
		
		
		$log = "RESPONSE - ".$raw_response."\n\n";
		$log.= "RESPONSE DECRYPTED - ".$newsource."\n\n";
		
		if($qp)
		{
			echo nl2br($log);
			//exit;
		}
		$responseParamList = json_decode($newsource,1);
		if(isset($responseParamList['merchantTranId'])&&$responseParamList['merchantTranId'])
		{
			$_REQUEST['transID'] = $responseParamList['merchantTranId'];
			$_REQUEST['actionurl']='notify';
		}
		####################
	}

########## callback section #############
	
	include('../status_top'.$data['iex']);
}

$mrid			= $td['mrid'];
$status			= $td['status'];
$transaction_id	= $td['transaction_id'];
$txn_id 		= $td['txn_id'];

$qp = 0;
//print_r($td);
//print_r($json_value);

if(isset($_SESSION['post']['qp'])&&$_SESSION['post']['qp']) $qp = 1;

$siteid_get['apiKey']		= "";
$siteid_get['merchantId']	= "";
$siteid_get['terminalId']	= "";
$siteid_get['subMerchantId']= "";

if(isset($json_value['apiKey'])) 		$siteid_get['apiKey'] 		= $json_value['apiKey']; 
if(isset($json_value['merchantId'])) 	$siteid_get['merchantId']	= $json_value['merchantId'];
if(isset($json_value['terminalId'])) 	$siteid_get['terminalId']	= $json_value['terminalId'];

if(isset($json_value['requestPost']['merchantId'])) 
	$siteid_get['subMerchantId']= $json_value['requestPost']['merchantId'];

//print_r($siteid_get);
if($qp){
	echo "<br/>txn_id=>".$transaction_id;
}

if(!empty($transaction_id))
{


	if($bank_acquirer_json_arr&&$is_curl_on){
		$bank_status_url=$bank_acquirer_json_arr['bank_status_url'];

		$requestPost = array();
		$requestPost['merchantId']		=$siteid_get['merchantId'];
		$requestPost['subMerchantId']	=$siteid_get['subMerchantId'];
		$requestPost['terminalId']		=$siteid_get['terminalId'];
		$requestPost['merchantTranId']	=$transaction_id;

###################
		//$fp = fopen($data['Path'].'/payin/pay69/Skywalk_PublicCerti.crt', 'r');
		$fp = fopen($data['Path'].'/payin/pay69/PubliccerEazypayservices.crt', 'r');
		
		$pub_key= fread($fp, 8192);
		fclose($fp);
		
		$RANDOMNO1 = "1221331212344838";
		$RANDOMNO2 = '1234562278901456';
		
		openssl_get_publickey($pub_key);
		
		openssl_public_encrypt($RANDOMNO1, $encrypted_key, $pub_key);
		$encrypted_data = openssl_encrypt(json_encode($requestPost), 'AES-128-CBC', $RANDOMNO1, OPENSSL_RAW_DATA, $RANDOMNO2);
		
		$postbody= [
			"requestId" => $transaction_id,
			"service" => "",
			"encryptedKey" => base64_encode($encrypted_key),
			"oaepHashingAlgorithm" => "NONE",
			"iv" => base64_encode($RANDOMNO2),
			"encryptedData" => base64_encode($encrypted_data),
			"clientInfo" => "",
			"optionalParam" => ""
		];
		
		$headers = array(
			"content-type: application/json", 
			"apikey:".$siteid_get['apiKey']
		);
		
		$file = 'composite_log.txt';
		
		$url = $bank_status_url.'/'.$siteid_get['merchantId'];
		
		$log = "\n\nGUID - ".$transaction_id."===============================\n";
		$log.= 'URL - '.$url."\n\n";
		$log.= 'HEADER - '.json_encode($headers)."\n\n";
		$log.= 'REQUEST - '.json_encode($requestPost)."\n\n";
		$log.= 'REQUEST ENCRYPTED - '.json_encode($postbody)."\n\n";
		
		//file_put_contents($file, $log, FILE_APPEND | LOCK_EX);
		
		$curl = curl_init($url);
		curl_setopt($curl, CURLOPT_URL, $url);
		curl_setopt($curl, CURLOPT_POST, true);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($postbody));
		
		$raw_response = curl_exec($curl);
		$httpcode	= curl_getinfo($curl, CURLINFO_HTTP_CODE);
		$err		= curl_error($curl);
		curl_close($curl);
		
		$request = json_decode($raw_response);
	
		$fp= fopen($data['Path'].'/payin/pay69/live_privatekey.key',"r");
		$priv_key=fread($fp,8192);
		fclose($fp);
	
		$res = openssl_get_privatekey($priv_key, "");
		openssl_private_decrypt(base64_decode($request->encryptedKey), $key, $res);
		$encData = base64_decode($request->encryptedData); 
		$encData = openssl_decrypt($encData,"aes-128-cbc",$key,OPENSSL_PKCS1_PADDING);
		
		$newsource = substr($encData, 16); 
		
		$log.= "\n\nGUID - ".$transaction_id."================================\n";
		$log.= "RESPONSE - ".$raw_response."\n\n";
		$log.= "RESPONSE DECRYPTED - ".$newsource."\n\n";
		
		if($qp)
		{
			echo nl2br($log);
			//exit;
		}
		$responseParamList = json_decode($newsource,1);
####################
	}
	$results = $responseParamList;


	if (isset($responseParamList) && count($responseParamList)>0)
	{
		$message = "";
		$status = "";
		if(isset($responseParamList['success']))	$success= $responseParamList['success'];
		if(isset($responseParamList['status']))		$status = $responseParamList['status'];
		if(isset($responseParamList['message']))	$message= $responseParamList['message'];

		$_SESSION['acquirer_action']=1;
		$_SESSION['acquirer_response']=$message;
		$_SESSION['curl_values']=$responseParamList;


		if(strtoupper($status)=='SUCCESS'){ //success
			$_SESSION['acquirer_response']=$message." - Success";
			$_SESSION['hkip_status']=2;
			$_SESSION['acquirer_status_code']=2;
		}
		elseif(strtoupper($status)=='FAILURE'||strtoupper($status)=='FAIL'){	//failed
			$_SESSION['acquirer_response']=$message." - Cancelled";
			$_SESSION['hkip_status']=-1;
			$_SESSION['acquirer_status_code']=-1;
		}
		else{ //pending

			$_SESSION['acquirer_response']=$message." - Pending";
			$status_completed=false;
			$_SESSION['acquirer_status_code']=1;
			if((isset($_REQUEST['actionurl']))&&(!empty($_REQUEST['actionurl']))){
				$_SESSION['hkip_status']=$_REQUEST['actionurl']." Pending or Error";
			}

			$data_tdate=date('YmdHis', strtotime($td['tdate']));
			$current_date_1h=date('YmdHis', strtotime("-1 hours"));
			if(($data_tdate<$current_date_1h)&&($data['localhosts']==false)){
				$_SESSION['acquirer_status_code']=-1;
				$_SESSION['acquirer_response']=$message." - Cancelled"; 
			}
		}
	}
}


if(!isset($data['STATUS_ROOT'])){
	include('../status_bottom'.$data['iex']);
}

?>