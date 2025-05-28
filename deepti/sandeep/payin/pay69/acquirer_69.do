<?
// 69, 690 - 699  ICICI :- QR, Intent & UPI Collect
// fetch data from qr_code via store_id and create dynamically QR with amount
if(!isset($_REQUEST['API_QR_CREATE'])){
	$tr_upd_order=array();
	//$tr_upd_order=$apc_get;

	$merchantName = $dba;
	
	//fetch the data from qr_code table


	$qr_code_row	= select_tablef(" `softpos_terNO`='{$_SESSION['terNO']}'",'softpos_setting',0,1,'`sub_merchantId`,`vpa`, `json_value`');
	
	if($qr_code_row['vpa']&&$qr_code_row['json_value'])
	{
		$sub_merchantId	= $qr_code_row['sub_merchantId'];		//sub merchant id
		$vpa			= decode_f($qr_code_row['vpa']);		//registered vpa after decode
		$json_value		= json_decode($qr_code_row['json_value'],1);

		if(isset($json_value['siteid_get'])&&is_array($json_value['siteid_get']))
		$apc_get=array_merge($apc_get,$json_value['siteid_get']);		//json key values
		
		if(isset($vpa)&&trim($vpa))
		$apc_get['vpa']=$vpa;
	
		if(isset($json_value['dmo_request']['merchantAliasName'])&&trim($json_value['dmo_request']['merchantAliasName']))
		$apc_get['merchantAliasName']=$json_value['dmo_request']['merchantAliasName']; //sub merchant name
		
	}
	
	/*
	else
	{
		$apc_get['vpa'] = $bank_json['vpa'];

		//json key values direct from bank table
		$apc_get['apiKey']		= $siteid_set['apiKey'];
		$apc_get['merchantId']	= $siteid_set['merchantId'];
		$apc_get['terminalId']	= $siteid_set['terminalId'];
		$apc_get['payerAccount']= $siteid_set['payerAccount'];
		$apc_get['payerIFSC']	= $siteid_set['payerIFSC'];
		$apc_get['dmo_url']		= $siteid_set['dmo_url'];
	
	}
	*/
	
	if($select_mcc_code)
	{
		$mcc_code_list_arr = explode(',',$select_mcc_code);
		
		if(count($mcc_code_list_arr)>1)
		{
			$data['Error']= 'Multiple MCC code mapped';
			//$apc_get['terminalId']='';
			$validate=false;
		}
		else
		{
			$apc_get['terminalId']=$mcc_code_list_arr[0];
			$validate=true;
		}
	}
	
	$tr_upd_order=$apc_get;
	$requestPost = array();
	
	if($apc_get['terminalId'])
	{
		//if($acquirer==69)	//for QR dynamic code
		if(isset($post['mop'])&&$post['mop']=='QRINTENT')	//for QR dynamic code
		{
			$requestPost['merchantId']		= isset($sub_merchantId)&&$sub_merchantId?$sub_merchantId:$apc_get['merchantId'];
			$requestPost['terminalId']		= $apc_get['terminalId'];
			$requestPost['amount']			= $total_payment;
			$requestPost['merchantTranId']	= $_SESSION['transID'];
			$requestPost['billNumber']		= $_SESSION['transID'];
			$requestPost['validatePayerAccFlag']= "N";
			$requestPost['payerAccount']	= $apc_get['payerAccount'];
			$requestPost['payerIFSC']		= $siteid_set['payerIFSC'];
			$requestPost['signedIntentFlag']= "Y";
		}
		//elseif($acquirer==691)	//for collect
		elseif( ($acquirer==691) || (isset($post['mop'])&&$post['mop']=='UPICOLLECT'))	//for collect
		{
			
			$bank_url=str_replace('/QR3','/CollectPay3',$bank_url);
			
			//coolect date should be greater current time, so six hours added in server time
			if($data['localhosts']==true){
				$collectByDate = date('d/m/Y h:i A', strtotime(' + 6 hours'));
			}
			else
				$collectByDate = date('d/m/Y h:i A', strtotime(' + 6 hours'));
	
			$requestPost['merchantId']		= isset($sub_merchantId)&&$sub_merchantId?$sub_merchantId:$apc_get['merchantId'];
			$requestPost['terminalId']		= $apc_get['terminalId'];
			$requestPost['subMerchantId']	= isset($sub_merchantId)&&$sub_merchantId?$sub_merchantId:$apc_get['merchantId'];
			$requestPost['payerVa']			= $post['upi_address'];
			$requestPost['amount']			= $total_payment;
			$requestPost['merchantTranId']	= $_SESSION['transID'];
			$requestPost['billNumber']		= $_SESSION['transID'];
			$requestPost['validatePayerAccFlag']= "N";
			$requestPost['note']			= "collect-pay-request";
			
		//	$requestPost['merchantName']	= $merchantName;

			$requestPost['merchantName']	= isset($apc_get['merchantAliasName'])&&$apc_get['merchantAliasName']?$apc_get['merchantAliasName']:$merchantName;
			$requestPost['subMerchantName']	= isset($apc_get['merchantAliasName'])&&$apc_get['merchantAliasName']?$apc_get['merchantAliasName']:$merchantName;
			$requestPost['collectByDate']	= $collectByDate;
	
			if(isset($post['upi_address_suffix'])&&$post['upi_address_suffix']) $requestPost['payerVa'].=$post['upi_address_suffix'];
			
			$tr_upd_order['upa']=$requestPost['payerVa'];
		}
	//print_r($requestPost);exit;
		############### - ICICI Section
		
		//open certificate and fetch public key which use to encrypt requestPost
		$fp = fopen($data['Path'].'/payin/pay69/PubliccerEazypayservices.crt', 'r');	// FOR LIVE MODE
	//	$fp = fopen($data['Path'].'/payin/pay69/UAT_Public_cert.crt', 'r');			// FOR TEST (UAT) MODE
		$pub_key= fread($fp, 8192);
		fclose($fp);
		
		$RANDOMNO1 = "1221331212344838";	//create 16 digit random number 1 as per required
		$RANDOMNO2 = '1234562278901456';	//create 16 digit random number 2 as per required
		
		openssl_get_publickey($pub_key);	//check public key
		
		openssl_public_encrypt($RANDOMNO1, $encrypted_key, $pub_key);	//encrypt public cert with random no 1
		$encrypted_data = openssl_encrypt(json_encode($requestPost), 'AES-128-CBC', $RANDOMNO1, OPENSSL_RAW_DATA, $RANDOMNO2);	//encrypt
		
		//Request body with encrypted_key and encrypted_data
		$postbody= [
			"requestId" => $_SESSION['transID'],
			"service" => "",
			"encryptedKey" => base64_encode($encrypted_key),
			"oaepHashingAlgorithm" => "NONE",
			"iv" => base64_encode($RANDOMNO2),
			"encryptedData" => base64_encode($encrypted_data),
			"clientInfo" => "",
			"optionalParam" => ""
		];
		
		//header for curl request
		$headers = array(
			"content-type: application/json", 
			"apikey:".$apc_get['apiKey']
		);
	
		$url = $bank_url.'/'.$apc_get['merchantId'];
		
		
		
		//log for check transactional request and response
		$log = "\n\nGUID - ".$_SESSION['transID']."===============================\n";
		$log.= 'URL - '.$url."\n\n";
		$log.= 'HEADER - '.json_encode($headers)."\n\n";
		$log.= 'REQUEST - '.json_encode($requestPost)."\n\n";
		$log.= 'REQUEST ENCRYPTED - '.json_encode($postbody)."\n\n";
		
		//send request via curl
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
		
		$log.= "\n\nGUID - ".$_SESSION['transID']."================================\n";
		$log.= "RESPONSE - ".$raw_response."\n\n";
		$log.= "RESPONSE DECRYPTED - ".$newsource."\n\n";
		
		if($_SESSION['post']['qp'])
		{
			echo nl2br($log);
			exit;
		}
		$response = json_decode($newsource,1);
	
		//print_r($response);exit;
		
		############### - ICICI Section
	
		$tr_upd_order['requestPost']=$requestPost;
	
		$tr_upd_order['response']=$response?$response:$raw_response;
	
		$curl_values_arr['responseInfo']	=$tr_upd_order['response'];
	
		$_SESSION['acquirer_action']=1;
		$_SESSION['curl_values']=$curl_values_arr;
	
		//print request and tr_upd_order array for testing purpose
		if(isset($_SESSION['post']['qp'])&&$_SESSION['post']['qp'])
		{
			echo '<br/><br/><b>bank_url:</b> '.$bank_url;
			echo '<br/><br/><b>requestPost:</b> ';
			print_r($requestPost);
			echo '<br/><br/><b>result:</b> ';
			print_r($tr_upd_order);
			//exit;
		}
	
		if(isset($apc_get['vpa'])&&$apc_get['vpa'])
			$tr_upd_order['upa']=$apc_get['vpa'];
		
		if(isset($response['BankRRN'])&&$response['PayerVA'])
			$tr_upd_order['upa']=$response['PayerVA'];
		
		
		if(isset($response['BankRRN'])&&$response['BankRRN'])
			$tr_upd_order['acquirer_ref']=$tr_upd_order['upa']=$response['BankRRN'];
		elseif(isset($response['refId'])&&$response['refId'])
			$tr_upd_order['acquirer_ref']=$response['refId'];
	
		//trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);
		
		$tr_upd_order['bank_url'.$acquirer]=$url;
		$tr_upd_order['bank_url']=$url;
		
		trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);
	
		if(isset($_SESSION['post']['qp'])&&$_SESSION['post']['qp'])
		{
			print_r($tr_upd_order);exit;
		}

		//check value in SignedQR exists then redirect to qr page and show QR
		if(isset($response['SignedQR'])&&$response['SignedQR'])
		{
			$qr_intent_address=urlencodef(@$response['SignedQR']); // return upi address for auto run for check via mobile or web 
			
			$intent_process_redirect=1;
			//$intent_process_include=1;
			//$qr_process_base64=1;
		}
		elseif(isset($response['success'])&&$response['success']=='true')	
		{
			//if received success for collect then redirect transaction_processing to check payment status 
				
			//Dev Tech : 23-10-11 Below line not required because status get on checkout page 	
			//$payment_url = $trans_processing;
			
			//Dev Tech : 23-10-11 set to UPICOLLECT response 
			$json_arr_set['UPICOLLECT']='Y';
			
			$_SESSION['acquirer_response']=$response['message']." - Pending";
		}
		elseif(isset($response['success'])&&$response['success']=='false')	//failed
		{
			$_SESSION['hkip_status']=-1;
			$_SESSION['acquirer_status_code']=-1;
			
			$_SESSION['acquirer_response']=$response['message'];
			
			$process_url=$return_url;
		}
		
	}//close if checked $apc_get['terminalId']
	else
	{
		$_SESSION['acquirer_response']=$data['Error'];
		$process_url=$return_url;
	}
	

	##----------
}
//69 end
?>