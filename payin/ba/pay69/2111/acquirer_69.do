<?
// fetch data from qr_code via store_id and create dynamically QR with amount
if((($post['acquirer']==69)||($post['acquirer']>690&&$post['acquirer']<699)) && $_SESSION['mode'.$post['acquirer']]==1 && $testcardno==false && $scrubbedstatus==false && $_SESSION['b_'.$post['acquirer']]['bg_active']==1){

	$acquirer=$post['acquirer'];

	$default_mid = 69;

	// $_SESSION['post']['qp']=1;
	//------------------------------------

	include ($data['Path']."/payin/pay69/function_69".$data['iex']);

	if($_SESSION['curr']){$orderCurrency=$_SESSION['curr'];}
	else{$orderCurrency= trim($_SESSION['currency'.$acquirer]);}

	$_SESSION['currency69']		=$orderCurrency;
	$_SESSION['total_payment']	=$total_payment;

	################################


	//form bank
	$bank_json=jsondecode($_SESSION['b_'.$acquirer]['bank_json'],true);
	$siteid_get=array();
	if($_SESSION['b_'.$acquirer]['account_mode']==2){
		$siteid_set			= $bank_json['test'];
		$bank_url			= $_SESSION['b_'.$acquirer]['bank_payment_test_url'];
	}else{
		$siteid_set			= $bank_json['live'];
		$bank_url			= $_SESSION['b_'.$acquirer]['bank_payment_url'];
	}

	if(isset($_SESSION['domain_server']['clients']['company_name'])&&$_SESSION['domain_server']['clients']['company_name'])
		$merchantName = $_SESSION['domain_server']['clients']['company_name'];
	else  
		$merchantName = trim($_SESSION['domain_server']['clients']['fname'].' '.$_SESSION['domain_server']['clients']['fname']);

	//fetch the data from qr_code table
	$qr_code_row	= select_tablef("`account_no`='{$acquirer}'",'qr_code',0,1,'`vpa`, `json_value`');
	if($qr_code_row['vpa']&&$qr_code_row['json_value'])
	{
		$sub_merchantId		= $qr_code_row['sub_merchantId'];
		$vpa		= decode_f($qr_code_row['vpa']);
		$json_value	= json_decode($qr_code_row['json_value'],1);

		$siteid_get=$json_value['siteid_get'];
		$siteid_get['vpa']=$vpa;
	
		$siteid_get['merchantAliasName']=$json_value['dmo_request']['merchantAliasName'];
	}
	else
	{
		$siteid_get['vpa'] = $bank_json['vpa'];
	
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
	if($_SESSION['b_'.$acquirer]['bank_process_url']){
		$bank_process_url=$_SESSION['b_'.$acquirer]['bank_process_url'];
	}else{
		$bank_process_url=$data['Host'];
	}

	$siteid_get['bank_process_url']=$bank_process_url;

	$bankstatus = $bank_process_url."/bankstatus{$data['ex']}?transID=$transID&action=webhook";

	$tr_upd_order=array();
	$tr_upd_order=$siteid_get;
	$tr_upd_order['default_mid']=$default_mid;
	$tr_upd_order['s30_count']=4;
	$tr_upd_order['bank_url'.$acquirer]=$bank_url;
	$tr_upd_order['host_'.$acquirer]=$data['Host'];
	$tr_upd_order['status_'.$acquirer]="bankstatus{$data['ex']}?transID={$transID}";

	$requestPost = array();
	
	$collectByDate = date('d/m/Y h:i A');

	$requestPost['payerVa']				=$siteid_get['vpa'];//$siteid_get['vpa'];
	$requestPost['amount']				=$total_payment;
	$requestPost['merchantId']			=$siteid_get['merchantId'];
	$requestPost['terminalId']			=$siteid_get['terminalId'];
	$requestPost['subMerchantId']		=$siteid_get['merchantId'];
	$requestPost['note']				="collect-pay-request";
	$requestPost['merchantName']		=$merchantName;
	$requestPost['subMerchantName']		=$siteid_get['merchantAliasName'];
	$requestPost['collectByDate']		=$collectByDate;
	$requestPost['merchantTranId']		=$_SESSION['transID'];
	$requestPost['billNumber']			="ICIC".time();
	$requestPost['validatePayerAccFlag']="Y";
	$requestPost['payerAccount']		=$siteid_get['payerAccount'];
	$requestPost['payerIFSC']			=$siteid_set['payerIFSC'];

//print_r($requestPost);exit;
	############### - ICICI Section
	
	$fp = fopen($data['Path'].'/payin/pay69/Skywalk_PublicCerti.crt', 'r');
	
	$pub_key= fread($fp, 8192);
	fclose($fp);
	
	$RANDOMNO1 = "1221331212344838";
	$RANDOMNO2 = '1234562278901456';
	
	openssl_get_publickey($pub_key);
	
	openssl_public_encrypt($RANDOMNO1, $encrypted_key, $pub_key);
	$encrypted_data = openssl_encrypt(json_encode($requestPost), 'AES-128-CBC', $RANDOMNO1, OPENSSL_RAW_DATA, $RANDOMNO2);
	
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
	
	$headers = array(
		"content-type: application/json", 
		"apikey:".$siteid_get['apiKey']
	);
	
	$file = 'composite_log.txt';
	
	$url = $bank_url.'/'.$siteid_get['merchantId'];
	
	$log = "\n\nGUID - ".$_SESSION['transID']."===============================\n";
	$log.= 'URL - '.$url."\n\n";
	$log.= 'HEADER - '.json_encode($headers)."\n\n";
	$log.= 'REQUEST - '.json_encode($postData)."\n\n";
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
	
	$log.= "\n\nGUID - ".$_SESSION['transID']."================================\n";
	$log.= "RESPONSE - ".$raw_response."\n\n";
	$log.= "RESPONSE DECRYPTED - ".$newsource."\n\n";
	
	if($_SESSION['post']['qp'])
	{
		echo nl2br($log);
		//exit;
	}
	$response = json_decode($newsource,1);

//print_r($response);exit;

############### - ICICI Section


	$request_post_data=$requestPost;

	$tr_upd_order['requestPost']=$request_post_data;

	$tr_upd_order['response']=$response?$response:$raw_response;

	trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);

	if(isset($_SESSION['post']['qp'])&&$_SESSION['post']['qp'])
	{
		print_r($tr_upd_order);exit;
	}

	$curl_values_arr['responseInfo']=$tr_upd_order['response'];
	$curl_values_arr['browserOsInfo']=$browserOs;

	$_SESSION['acquirer_action']=1;
///	$_SESSION['acquirer_response']=$responseRequest['type'];
	$_SESSION['curl_values']=$curl_values_arr;

	if(isset($_SESSION['post']['qp'])&&$_SESSION['post']['qp'])
	{
		echo '<br/><br/><b>bank_url:</b> '.$bank_url;
		echo '<br/><br/><b>result:</b> ';
		print_r($tr_upd_order);
		//exit;
	}


	trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);


	$_SESSION['acquirer_action']=1;
//	$_SESSION['acquirer_response']=$responseRequest['type'];
	$_SESSION['curl_values']=@$curl_values_arr;

	if(isset($_SESSION['post']['qp'])&&$_SESSION['post']['qp'])
	{
		echo '<br/><br/><b>bank_url:</b> '.$bank_url;
		echo '<br/><br/><b>requestPost:</b> ';
		print_r($requestPost);
	}

	##----------
		
		if(isset($response['SignedQR'])&&$response['SignedQR'])
		{
			$tr_upd_order1=array();

			if((isset($response['STATUS'])&&$response['STATUS']=='SUCCESS')||(isset($response['success'])&&$response['success']=='1'))
			{
				?>
				<img src="https://quickchart.io/chart?chs=200x200&cht=qr&chl=<?=$response['SignedQR'];?>&choe=UTF-8" title=""/>
				<?
				/*

				$_SESSION['3ds2_auth']['processed']		=$bankstatus;
				$_SESSION['3ds2_auth']['payaddress']	=$qrUrl;
				$_SESSION['3ds2_auth']['paytitle']		=$paytitle;
				$_SESSION['3ds2_auth']['currname']		=$currency;;
				$_SESSION['3ds2_auth']['payamt']	=number_format($totalAmount/100,2);
				$_SESSION['3ds2_auth']['transaction_amt']	=number_format($totalAmount/100,2);
				$_SESSION['3ds2_auth']['orderId']			=$referenceNo;
				$_SESSION['3ds2_auth']['currency']		=$_SESSION['json_value']['post']['curr'];
				$_SESSION['3ds2_auth']['amount']			=$_SESSION['json_value']['post']['price'];
				//$_SESSION['3ds2_auth']['bank_process_url']=$siteid_get['bank_process_url'];
				$_SESSION['3ds2_auth']['netWorkType']		=$walletType;
	
				if(isset($post['product'])) $_SESSION['3ds2_auth']['product']=$post['product'];
	
				$payment_url = "{$data['Host']}/payin/common-qr{$data['ex']}?transID=$transID&orderId={$_SESSION['transID']}&action=chart";
				$_SESSION['redirect_url']=$payment_url;
				
				$_SESSION['pay_url']=$redirect_url;
				
				header("Location:$payment_url");
				exit;
				*/
			}
		}
		else
		{
			/*
			$siteid_get['apiKey']		= $siteid_set['apiKey'];
			$siteid_get['merchantId']	= $siteid_set['merchantId'];
			$siteid_get['terminalId']	= $siteid_set['terminalId'];
			
			$MID = $siteid_get['merchantId'];
			$terminalId = $siteid_get['terminalId'];
			$amount		= $total_payment;
			$reference	= $_SESSION['transID'];
			$vpa		= $siteid_get['vpa'];//"letspete@icici";
			
			$url = "upi://pay?pa=$vpa&pn=$MID&tr=$reference&cu=$orderCurrency&mc=$terminalId";

			?>
			<img src="https://quickchart.io/chart?chs=300x300&cht=qr&chl=<?=$url;?>&choe=UTF-8" title=""/>
			<?
			exit;			
			*/
			$_SESSION['hkip_status']=-1;
			$_SESSION['acquirer_status_code']=-1;
			
			$_SESSION['acquirer_response']=$error_msg." - Cancelled";
			
			//$process_url = "{$data['Host']}/failed{$file_v}{$data['ex']}?transID={$transID}&action=hkip";

			//header("location:$process_url");exit;
		}

	##----------

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
		$_SESSION['acquirer_status_code']=1;
	}else{
		header("Location:$process_url");
		exit;
	}
}//69 end
?>