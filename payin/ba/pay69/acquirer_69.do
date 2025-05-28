<?
// fetch data from qr_code via store_id and create dynamically QR with amount
if((($post['acquirer']==69)||($post['acquirer']>690&&$post['acquirer']<699)) && $_SESSION['mode'.$post['acquirer']]==1 && $testcardno==false && $scrubbedstatus==false && $_SESSION['b_'.$post['acquirer']]['bg_active']==1){

	if(isset($_SESSION['website_mcc_code'])&&$_SESSION['website_mcc_code'])
		$website_mcc_code=$_SESSION['website_mcc_code'];
	else 
		$website_mcc_code='';
		

	//	echo "SESSION=><br />";print_r($_SESSION['id']);
	//	echo "<br /><br />POST=><br />";print_r($post);exit;

	$acquirer=$post['acquirer'];

	$default_mid = 69;	//set main MID as default for access status and refund urls

	// $_SESSION['post']['qp']=1;
	//------------------------------------
	
	//check in curr exists in $_SESSION then fetch and store into orderCurrency otherwise fetch currency via acquirer
	if($_SESSION['curr']){$orderCurrency=$_SESSION['curr'];}
	else{$orderCurrency= trim($_SESSION['currency'.$acquirer]);}

	$_SESSION['currency69']		=$orderCurrency;	//store currency in $_SESSION with acquirer
	$_SESSION['total_payment']	=$total_payment;	//store total transaction amount in $_SESSION

	################################


	//form bank
	$bank_json=jsondecode($_SESSION['b_'.$acquirer]['bank_json'],true);
	$siteid_get=array();
	if($_SESSION['b_'.$acquirer]['account_mode']==2){ //if account in test mode then fetch TEST bank json 
		$siteid_set	= $bank_json['test'];
		$bank_url	= $_SESSION['b_'.$acquirer]['bank_payment_test_url'];
	}else{	 //if account in LIVE mode then fetch LIVE bank json
		$siteid_set	= $bank_json['live'];
		$bank_url	= $_SESSION['b_'.$acquirer]['bank_payment_url'];
	}

	//fetch merchant from $_SESSION
	if(isset($_SESSION['domain_server']['clients']['company_name'])&&$_SESSION['domain_server']['clients']['company_name'])
		$merchantName = $_SESSION['domain_server']['clients']['company_name'];
	else 
	{
		if(isset($_SESSION['domain_server']['clients']['fullname'])&&$_SESSION['domain_server']['clients']['fullname'])
			$merchantName = $_SESSION['domain_server']['clients']['fullname'];
		else
			$merchantName = trim($_SESSION['domain_server']['clients']['fname'].' '.$_SESSION['domain_server']['clients']['lname']);
	}
	//fetch the data from qr_code table

//	$qr_code_row	= select_tablef("`account_no`='{$acquirer}' AND store_id='{$_SESSION['id']}'",'qr_code',0,1,'`sub_merchantId`,`vpa`, `json_value`');
	$qr_code_row	= select_tablef("store_id='{$_SESSION['id']}'",'qr_code',0,1,'`sub_merchantId`,`vpa`, `json_value`');
	if($qr_code_row['vpa']&&$qr_code_row['json_value'])
	{
		$sub_merchantId	= $qr_code_row['sub_merchantId'];		//sub merchant id
		$vpa			= decode_f($qr_code_row['vpa']);		//registered vpa after decode
		$json_value		= json_decode($qr_code_row['json_value'],1);

		$siteid_get=$json_value['siteid_get'];		//json key values
		$siteid_get['vpa']=$vpa;
	
		$siteid_get['merchantAliasName']=$json_value['dmo_request']['merchantAliasName']; //sub merchant name
	}
	else
	{
		$siteid_get['vpa'] = $bank_json['vpa'];

		//json key values direct from bank table
		$siteid_get['apiKey']		= $siteid_set['apiKey'];
		$siteid_get['merchantId']	= $siteid_set['merchantId'];
		$siteid_get['terminalId']	= $siteid_set['terminalId'];
		$siteid_get['payerAccount']	= $siteid_set['payerAccount'];
		$siteid_get['payerIFSC']	= $siteid_set['payerIFSC'];
		$siteid_get['dmo_url']		= $siteid_set['dmo_url'];
	
		//form acquirer
		if($_SESSION['b_'.$acquirer]['account_mode']==1){
			$siteid_acquirer = jsondecode(@$_SESSION['siteid'.$acquirer]);
	
			if(isset($siteid_acquirer['apiKey'])&&$siteid_acquirer['apiKey']){
				$siteid_get['apiKey']=$siteid_acquirer['apiKey'];
			}
			if(isset($siteid_acquirer['merchantId'])&&$siteid_acquirer['merchantId']){
				$siteid_get['merchantId']=$siteid_acquirer['merchantId'];
			}
			if(isset($siteid_acquirer['terminalId'])&&$siteid_acquirer['terminalId']){
				$siteid_get['terminalId']=$siteid_acquirer['terminalId'];
			}
		}
	}
	
	if($website_mcc_code)
	{
		$mcc_code_list_arr = explode(',',$website_mcc_code);
		
		if(count($mcc_code_list_arr)>1)
		{
			$data['Error']= 'Multiple MCC code mapped';
			$siteid_get['terminalId']='';
			$validate=false;
		}
		else
		{
			$siteid_get['terminalId']=$mcc_code_list_arr[0];
			$validate=true;
		}
	}
	
	
	//bank_process_url exists in $_SESSION then use this else use host name as a bank_process_url
	if($_SESSION['b_'.$acquirer]['bank_process_url']){
		$bank_process_url=$_SESSION['b_'.$acquirer]['bank_process_url'];
	}else{
		$bank_process_url=$data['Host'];
	}

	$siteid_get['bank_process_url']=$bank_process_url;	//bank_process_url store in array

	//url for to check transaction status
	$bankstatus = $bank_process_url."/bankstatus{$data['ex']}?transID=$transID&action=webhook";

	$tr_upd_order=array();
	$tr_upd_order=$siteid_get;						//all keys data
	$tr_upd_order['default_mid']=$default_mid;		//set main MID as default
	$tr_upd_order['s30_count']=4;					//counter for refresh status page
	$tr_upd_order['bank_url'.$acquirer]=$bank_url;	//store bankurl
	$tr_upd_order['host_'.$acquirer]=$data['Host'];	//host name
	$tr_upd_order['status_'.$acquirer]="bankstatus{$data['ex']}?transID={$transID}";	//status url

	$requestPost = array();

	if($siteid_get['terminalId'])
	{
		if($acquirer==69)	//for QR dynamic code
		{
			$requestPost['merchantId']		= isset($sub_merchantId)&&$sub_merchantId?$sub_merchantId:$siteid_get['merchantId'];
			$requestPost['terminalId']		= $siteid_get['terminalId'];
			$requestPost['amount']			= $total_payment;
			$requestPost['merchantTranId']	= $_SESSION['transID'];
			$requestPost['billNumber']		= $_SESSION['transID'];
			$requestPost['validatePayerAccFlag']= "N";
			$requestPost['payerAccount']	= $siteid_get['payerAccount'];
			$requestPost['payerIFSC']		= $siteid_set['payerIFSC'];
			$requestPost['signedIntentFlag']= "Y";
		}
		elseif($acquirer==691)	//for collect
		{
			//coolect date should be greater current time, so six hours added in server time
			if($data['localhosts']==true){
				$collectByDate = date('d/m/Y h:i A', strtotime(' + 6 hours'));
			}
			else
				$collectByDate = date('d/m/Y h:i A', strtotime(' + 6 hours'));
	
			$requestPost['merchantId']		= isset($sub_merchantId)&&$sub_merchantId?$sub_merchantId:$siteid_get['merchantId'];
			$requestPost['terminalId']		= $siteid_get['terminalId'];
			$requestPost['subMerchantId']	= isset($sub_merchantId)&&$sub_merchantId?$sub_merchantId:$siteid_get['merchantId'];
			$requestPost['payerVa']			= $post['upi_address'];
			$requestPost['amount']			= $total_payment;
			$requestPost['merchantTranId']	= $_SESSION['transID'];
			$requestPost['billNumber']		= $_SESSION['transID'];
			$requestPost['validatePayerAccFlag']= "N";
			$requestPost['note']			= "collect-pay-request";
			
		//	$requestPost['merchantName']	= $merchantName;

			$requestPost['merchantName']	= isset($siteid_get['merchantAliasName'])&&$siteid_get['merchantAliasName']?$siteid_get['merchantAliasName']:$merchantName;
			$requestPost['subMerchantName']	= isset($siteid_get['merchantAliasName'])&&$siteid_get['merchantAliasName']?$siteid_get['merchantAliasName']:$merchantName;
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
			"apikey:".$siteid_get['apiKey']
		);
	
		$url = $bank_url.'/'.$siteid_get['merchantId'];
		
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
		$curl_values_arr['browserOsInfo']	=$browserOs;
	
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
	
		if(isset($response['BankRRN'])&&$response['BankRRN'])
			$tr_upd_order['txn_id']=$response['BankRRN'];
		elseif(isset($response['refId'])&&$response['refId'])
			$tr_upd_order['txn_id']=$response['refId'];
	
		//trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);
	
		if(isset($_SESSION['post']['qp'])&&$_SESSION['post']['qp'])
		{
			print_r($tr_upd_order);exit;
		}

		//check value in SignedQR exists then redirect to qr page and show QR
		if(isset($response['SignedQR'])&&$response['SignedQR'])
		{
			$txn_id				= @$response['merchantTranId'];
			$transactionState	= @$response['message'];
			$totalAmount		= $total_payment;
			$amountSettled		= $total_payment;
			$amountInCNY		= $total_payment;
			$currency			= $orderCurrency;
			$currencySettled 	= $orderCurrency;
			$qrUrl				= @$response['SignedQR'];
 
			$_SESSION['3ds2_auth']['processed']		=$bankstatus;
			$_SESSION['3ds2_auth']['payaddress']	=$qrUrl;
			$_SESSION['3ds2_auth']['paytitle']		=$siteid_get['merchantAliasName'];
			$_SESSION['3ds2_auth']['currname']		=$currency;
			$_SESSION['3ds2_auth']['payamt']	=$totalAmount;
			$_SESSION['3ds2_auth']['transaction_amt']	=$totalAmount;
			$_SESSION['3ds2_auth']['orderId']			=$referenceNo;
			$_SESSION['3ds2_auth']['currency']		=$_SESSION['json_value']['post']['curr'];
			$_SESSION['3ds2_auth']['amount']			=$_SESSION['json_value']['post']['price'];
			//$_SESSION['3ds2_auth']['bank_process_url']=$siteid_get['bank_process_url'];
			$_SESSION['3ds2_auth']['netWorkType']		=$walletType;

			if(isset($post['product'])) $_SESSION['3ds2_auth']['product']=$post['product'];

			if(isMobileDevice()){
			//	$payment_url = $response['SignedQR'];
				
				$payment_url = "upi://pay?pa=".$siteid_get['vpa']."&pn=".$requestPost['merchantId']."&tr=".$response['refId']."&am=$totalAmount&cu=$currency&mc=".$requestPost['terminalId'];
				//$payment_url = "upi://pay?pa=".$siteid_get['vpa']."&pn=".$requestPost['merchantId']."&tr=".$_SESSION['transID']."&am=$totalAmount&cu=$currency&mc=".$requestPost['terminalId'];
		
		//exit;
			}
			else{
				//QR page path
				//$payment_url = "{$data['Host']}/payin/common-qr{$data['ex']}?transID=$transID&orderId={$_SESSION['transID']}&action=chart";
				$payment_url = "{$data['Host']}/payin/indian-qr{$data['ex']}?transID=$transID&orderId={$_SESSION['transID']}&action=chart";
			}
			$_SESSION['redirect_url']=$payment_url;
			
			$_SESSION['pay_url']=$_SESSION['redirect_url'];
				
			/*

			?>
			<img src="https://quickchart.io/chart?chs=200x200&cht=qr&chl=<?=$response['SignedQR'];?>&choe=UTF-8" title=""/>
			<?
			exit;
			*/
		}
		elseif(isset($response['success'])&&$response['success']=='true')	
		{
			//if received success for collect then redirect transaction_processing to check payment status 
			$payment_url = "{$data['Host']}/trans_processing{$data['ex']}?transID={$transID}&action=hkip"; 

			
			$_SESSION['acquirer_status_code']=1;
			
			$_SESSION['acquirer_response']=$response['message']." - Pending";
		}
		elseif(isset($response['success'])&&$response['success']=='false')	//failed
		{
			$_SESSION['hkip_status']=-1;
			$_SESSION['acquirer_status_code']=-1;
			
			$_SESSION['acquirer_response']=$response['message'];
		}
		$tr_upd_order['pay_url']=$_SESSION['pay_url'];
	}//close if checked $siteid_get['terminalId']
	else
	{
		$_SESSION['acquirer_response']=$data['Error'];
	}
	trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);

	##----------

	//check if payment_url define then re-direct to this url else direct to failed.do
	if(isset($payment_url) && !empty($payment_url))
	{
		
		$_SESSION['acquirer_status_code']=1;
		$process_url = $payment_url; 
	}
	else{
		$_SESSION['hkip_status']=-1;
		$_SESSION['acquirer_status_code']=-1;
		$_SESSION['acquirer_response']=$_SESSION['acquirer_response']." - Cancelled";

		$process_url = "{$data['Host']}/failed{$file_v}{$data['ex']}?transID={$transID}&action=hkip"; 
	}

	if($post['cardsend']=="curl"){
		//$_SESSION['acquirer_status_code']=1;
	}else{
		header("Location:$process_url");
		exit;
	}
}//69 end
?>