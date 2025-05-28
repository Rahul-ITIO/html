<?
//status for 69, 690 - 699  ICICI :- QR, Intent & UPI Collect

$qp = 0;
if(isset($_SESSION['post']['qp'])&&$_SESSION['post']['qp']) $qp=$_SESSION['post']['qp'];
elseif(isset($_REQUEST['qp'])&&$_REQUEST['qp']) $qp=$_REQUEST['qp'];

if(isset($data['ROOT'])&&$data['ROOT']) $root=$data['ROOT'];
else $root='../../';

#####	TEMP* for email response as testing	#########
if((isset($_REQUEST['actionurl'])&&$_REQUEST['actionurl']=='notify')||(isset($_REQUEST['action'])&&$_REQUEST['action']=='notify')||(isset($_REQUEST['action'])&&$_REQUEST['action']=='webhook'))
{	
	
	$data['transIDExit']=1;
	$data['status_in_email']=1;
	$data['devEmail']='arun@bigit.io';
	
}


$is_curl_on = true;
if(!isset($data['STATUS_ROOT'])){
	include($root.'config.do');
	########## callback section #############

	//callback section - fetch callback body
	$str=file_get_contents("php://input");

	//if(!str) $str=$_POST;	//if not received then fetch via $_POST;
	if(isset($_REQUEST['st'])&&$_REQUEST['st']) $str=$_REQUEST['st'];

	if($str)	//if received string then json decode
	{
		$is_curl_on = false;
		$request	= json_decode($str);
	
		//open certificate and fetch private key which use to decrypt response
		$fp= fopen($data['Path'].'/payin/pay69/live_privatekey.key',"r");
		$priv_key=fread($fp,8192);
		fclose($fp);
	
		$res = openssl_get_privatekey($priv_key, "");
		openssl_private_decrypt(base64_decode($request->encryptedKey), $key, $res);
		$encData = base64_decode($request->encryptedData); 
		$encData = openssl_decrypt($encData,"aes-128-cbc",$key,OPENSSL_PKCS1_PADDING);
		
		$newsource = substr($encData, 16); 
		
		//create log file
		//$log = "RESPONSE - ".$raw_response."\n\n";
		$log= "RESPONSE DECRYPTED - ".$newsource."\n\n";
		
		if($qp)
		{
			$str_arr = json_decode($str,1);
			echo "<br/><br/><br/>str_arr=> "; print_r($str_arr);
			echo "<br/><br/><br/>log=> "; echo nl2br($log);
			echo "<br/><br/><br/>newsource=> "; print_r($newsource);
			if($qp==2)exit;
		}

		$responseParamList = json_decode($newsource,1);		//	decode response
		if(isset($responseParamList['merchantTranId'])&&$responseParamList['merchantTranId'])
		{
			$_REQUEST['transID'] = $responseParamList['merchantTranId'];
			$_REQUEST['actionurl']= 'notify';	//set notify means execute via callback
			$_REQUEST['action']= 'webhook';	//set notify means execute via callback
		}
		####################
	}
	
	if($qp)
	{
		echo "<br/><br/><br/>responseParamList=> "; print_r($responseParamList);
		echo "<br/><br/><br/>_REQUEST=> "; print_r($_REQUEST);
		echo "<br/><br/><br/>log=> "; echo nl2br($log);
		if($qp==3)exit;
	}
		
	########## callback section #############
	
	include($data['Path'].'/payin/status_top'.$data['iex']);
}

#####	TEMP* for Response check as testing	#########
//include($data['Path'].'/payin/res_insert'.$data['iex']);



echo "<br/><br/><br/>td=> "; print_r($td);


exit;

//print_r($td);
//print_r($json_value);



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
	echo "<br/>transID=>".$transID;
}

//new section -- callback for static QR - START
$static_call = false;
if(empty($transID)&&(isset($responseParamList) && count($responseParamList)>0)){
	$merchantId		= $responseParamList['merchantId'];
	$subMerchantId	= $responseParamList['subMerchantId'];
	$terminalId		= $responseParamList['terminalId'];
	$BankRRN		= $responseParamList['BankRRN'];
	$merchantTranId	= $responseParamList['merchantTranId'];
	$PayerAmount	= $responseParamList['PayerAmount'];
	$TxnStatus		= $responseParamList['TxnStatus'];
	$PayerVA		= $responseParamList['PayerVA'];
	$PayerName		= $responseParamList['PayerName'];
	$PayerMobile	= $responseParamList['PayerMobile'];
	$TxnInitDate	= $responseParamList['TxnInitDate'];
	$TxnCompletionDate= $responseParamList['TxnCompletionDate'];

	if($subMerchantId&&$TxnStatus&&strtoupper($TxnStatus)=="SUCCESS")
	{
		$static_call = true;
		if(!isset($host_path)) $host_path=$data['Host'];
		$post['integration-type']=="s2s";
	
		$responseParamList['status']=$TxnStatus;

		$qrcode=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}softpos_setting`".
			" WHERE `sub_merchantId`='{$subMerchantId}' LIMIT 1",0
		);
		
		$merID			= $qrcode[0]['clientid'];
		$softpos_terNO	= $qrcode[0]['softpos_terNO'];
		$acquirer		= $qrcode[0]['acquirer'];
		$currency		= $qrcode[0]['currency'];

		if(@$currency) $_SESSION['currname']=@$currency;
		else $_SESSION['currname']="INR";

		$_SESSION['terNO']=$softpos_terNO;
		
		//$_SESSION['trans_orderset']=@$merchantTranId;
		$_SESSION['reference']=@$merchantTranId;
		$_SESSION['request_uri']=" Response Status : <b>".@$TxnStatus."</b>";

		
		create_new_trans(
			$merID,					//merID
			$PayerAmount, 		 	//bill_amt
			$acquirer,				//acquirer
			0,						//trans_status
			(isset($post['fullname'])?$post['fullname']:''),		//fullname
			(isset($post['bill_address'])?$post['bill_address']:''),	//bill_address
			(isset($post['bill_city'])?$post['bill_city']:''),		//bill_city
			(isset($post['bill_state'])?$post['bill_state']:''),	//bill_state
			(isset($post['bill_zip'])?$post['bill_zip']:''),		//bill_zip
			(isset($post['bill_email'])?$post['bill_email']:''),	//bill_email	C
			(isset($post['ccno'])?$post['ccno']:''),
			(isset($post['bill_phone'])?$post['bill_phone']:''),	//bill_phone
			(isset($post['product'])?$post['product']:''),
			(isset($_SESSION['http_referer'])?$_SESSION['http_referer']:(isset($_SERVER['HTTP_REFERER'])?$_SERVER['HTTP_REFERER']:''))
		);
			
			
		
		if(isset($_SESSION['tr_newid'])&&$_SESSION['tr_newid'])
		{
			
			$_SESSION['transID']=$transID;
			
			$tr_upd_order['response']=$responseParamList;

			if(isset($BankRRN)&&$BankRRN) $tr_upd_order['acquirer_ref']=$BankRRN;
			if(isset($PayerVA)&&$PayerVA) $tr_upd_order['upa']=$PayerVA;

			trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);
			//calculation_tr_fee($_SESSION['tr_newid']);
		}
		echo '200 OK'; //set 200 OK to stop repeat callback
		//exit;
	}
}
//new section -- callback for static QR - END

if(!empty($transID))
{
	if($bank_acquirer_json_arr&&$is_curl_on){
		
		if(empty($acquirer_status_url)&&$acquirer==69) 
			$acquirer_status_url='https://apibankingone.icicibank.com/api/MerchantAPI/UPI/v0/TransactionStatus3';
		elseif(empty($acquirer_status_url)&&$acquirer==691) 
			$acquirer_status_url='https://apibankingone.icicibank.com/api/MerchantAPI/UPI/v0/TransactionStatus3';
		

		$requestPost = array();
		$requestPost['merchantId']		=isset($siteid_get['subMerchantId'])&&$siteid_get['subMerchantId']?$siteid_get['subMerchantId']:$siteid_get['merchantId'];
		$requestPost['subMerchantId']	=$siteid_get['subMerchantId'];
		$requestPost['terminalId']		=$siteid_get['terminalId'];
		$requestPost['merchantTranId']	=$transID;

		###################
		//open certificate and fetch public key which use to encrypt requestPost
		$fp = fopen($data['Path'].'/payin/pay69/PubliccerEazypayservices.crt', 'r');
		
		$pub_key= fread($fp, 8192);
		fclose($fp);
		
		$RANDOMNO1 = "1221331212344838";
		$RANDOMNO2 = '1234562278901456';
		
		openssl_get_publickey($pub_key);
		
		openssl_public_encrypt($RANDOMNO1, $encrypted_key, $pub_key);
		$encrypted_data = openssl_encrypt(json_encode($requestPost), 'AES-128-CBC', $RANDOMNO1, OPENSSL_RAW_DATA, $RANDOMNO2);
		
		$postbody= [
			"requestId" => $transID,
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
		
		$url = $acquirer_status_url.'/'.$siteid_get['merchantId'];
		
		$log = "\n\nGUID - ".$transID."===============================\n";
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
	
		//open certificate and fetch private key which use to decrypt response
		$fp= fopen($data['Path'].'/payin/pay69/live_privatekey.key',"r");
		$priv_key=fread($fp,8192);
		fclose($fp);
	
		$res = openssl_get_privatekey($priv_key, "");
		openssl_private_decrypt(base64_decode($request->encryptedKey), $key, $res);
		$encData = base64_decode($request->encryptedData); 
		$encData = openssl_decrypt($encData,"aes-128-cbc",$key,OPENSSL_PKCS1_PADDING);
		
		$newsource = substr($encData, 16); 
		
		$log.= "\n\nGUID - ".$transID."================================\n";
		$log.= "RESPONSE - ".$raw_response."\n\n";
		$log.= "RESPONSE DECRYPTED - ".$newsource."\n\n";
		
		if($qp)
		{
			echo nl2br($log);
			exit;
		}
		$responseParamList = json_decode($newsource,1);
		####################
	}
	$results = $responseParamList;

	if (isset($responseParamList) && count($responseParamList)>0)
	{
		$message= "";
		$status	= "";
		if(isset($responseParamList['success']))	$success= $responseParamList['success'];
		if(isset($responseParamList['status']))		$status = $responseParamList['status'];
		if(isset($responseParamList['message']))	$message= $responseParamList['message'];

		$_SESSION['acquirer_action']=1;
		$_SESSION['acquirer_response']=$message;
		$_SESSION['curl_values']=$responseParamList;

		if(strtoupper($status)=='SUCCESS'){ //success
			$_SESSION['acquirer_response']=$message." - Success";
			$_SESSION['acquirer_status_code']=2;
		}
		elseif(strtoupper($status)=='FAILURE'||strtoupper($status)=='FAIL'){	//failed
			$_SESSION['acquirer_response']=$message." - Cancelled";
			$_SESSION['acquirer_status_code']=-1;
		}
		else{ //pending

			$_SESSION['acquirer_response']=$message." - Pending";
			$status_completed=false;
			$_SESSION['acquirer_status_code']=1;
			if((isset($_REQUEST['actionurl']))&&(!empty($_REQUEST['actionurl']))){
				$_SESSION['acquirer_response']=$_REQUEST['actionurl']." Pending or Error";
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

#######################################################

if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}

?>