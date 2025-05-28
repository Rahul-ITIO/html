<?
//acquirer 78
if((($post['acquirer']==81 || ($post['acquirer']>810&&$post['acquirer']<820)) && $_SESSION['mode'.$post['acquirer']]==1 && $testcardno==false && $scrubbedstatus==false && $_SESSION['b_'.$post['acquirer']]['bg_active']==1))
 {

	$acquirer=$post['acquirer'];//for acquirerNo

	$tr_upd_order=array(); //function for update the transaction table
	//------------------------------------

	if($_SESSION['curr']){$orderCurrency=$_SESSION['curr'];}
	else{$orderCurrency= trim($_SESSION['currency'.$acquirer]);}

	$_SESSION['currency81']=$orderCurrency; // dynamic value for currency
	$_SESSION['total_payment']=$total_payment; // dynamic value for payment

	################################

	//form bank
	$bank_json=jsondecode($_SESSION['b_'.$acquirer]['bank_json'],true); //json value from backend
	//print_r($bank_json);exit;
	$siteid_get=array();

	if($_SESSION['b_'.$acquirer]['account_mode']==2){ // this is for test mode trnasaction
		$siteid_set=$bank_json['test'];
		$bank_url=$_SESSION['b_'.$acquirer]['bank_payment_test_url'];
		$siteid_get['mode']='test';
	}else{
		$siteid_set=$bank_json['live']; // this is for live mode transaction
		$bank_url=$_SESSION['b_'.$acquirer]['bank_payment_url'];
		$siteid_get['mode']='live';
	}
 
	$siteid_get['source']	= $siteid_set['source']; // signKey provide by ipaybill
	$siteid_get['extTransactionId']= $siteid_set['extTransactionId']; //gatewayNo provided by ipaybill
	$siteid_get['terminalId']= $siteid_set['terminalId'];
	$siteid_get['sid']= $siteid_set['sid'];
	$siteid_get['Encryption_key']= $siteid_set['Encryption_key'];
	$siteid_get['key']= $siteid_set['key'];
	$siteid_get['Checksum_key']= $siteid_set['Checksum_key'];

	

	$acquirer_json	= ($_SESSION['b_'.$acquirer]['acquirer_json']);	// fetch acquirer_json values
	$bank_status_url= jsonvaluef($acquirer_json,'bank_status_url');	// fetch bank_status_url
	$bank_refund_url= jsonvaluef($acquirer_json,'bank_refund_url');	// fetch bank_refund_url

	//check bank_status_url exists in DB or not, if yes then save into json value 
	if($bank_status_url)
	{
		$siteid_get['bank_status_url'] = $bank_status_url;
	}
	//check bank_refund_url exists in DB or not, if yes then save into json value 
	if($bank_refund_url)
	{
		$siteid_get['bank_refund_url'] = $bank_refund_url;
	}

	//from acquirer if live mode
	if($_SESSION['b_'.$acquirer]['account_mode']==1){
		if(isset($_SESSION['siteid'.$acquirer])&&$_SESSION['siteid'.$acquirer])
		{
			$siteid_acquirer = jsondecode($_SESSION['siteid'.$acquirer]);

			if($siteid_acquirer['source']){
				$siteid_get['source']=$siteid_acquirer['source'];
			}
			if($siteid_acquirer['extTransactionId']){
				$siteid_get['extTransactionId']=$siteid_acquirer['extTransactionId'];
			}
			if($siteid_acquirer['terminalId']){
				$siteid_get['terminalId']=$siteid_acquirer['terminalId'];
			}
			if($siteid_acquirer['sid']){
				$siteid_get['sid']=$siteid_acquirer['sid'];
			}
		}
	}

	################################

	if($_SESSION['b_'.$acquirer]['bank_process_url']){
		$bank_process_url=$_SESSION['b_'.$acquirer]['bank_process_url'];
	}else{
		$bank_process_url=$data['Host'];
	}

	$siteid_get['bank_process_url']=$bank_process_url;
	$order_id = $_SESSION['transID'];

	
	$check_status = "bankstatus{$data['ex']}?transID=".$transID."&action=redirect";

	$tr_upd_order=$siteid_get;
	$tr_upd_order['s30_count']			=4;
	$tr_upd_order['default_mid']		='78';
	$tr_upd_order['host_'.$acquirer]		=$data['Host'];
	$tr_upd_order['status_'.$acquirer]	=$check_status;
	$tr_upd_order['bank_url'.$acquirer]	=$bank_url;

	// parameter request
	$verifyUrl = $bank_url.'/verifyVPA';
	$req = [
		'source' => $siteid_get['source'],
		'channel' => 'api',
		'extTransactionId' => $siteid_get['extTransactionId'].$_SESSION['transID'],
		'upiId' => $post['upi_address'],
		'terminalId' => $siteid_get['terminalId'],
		'sid' => $siteid_get['sid'],
	];
	$checksum='';
	foreach ($req as $val){
		$checksum.=$val;
	}
	$checksum_string=$checksum.$siteid_get['Checksum_key'];
	$req['checksum']=hash('sha256',$checksum_string);
	$key= $siteid_get['Encryption_key'];
	$key=substr((hash('sha256',$key,true)),0,16);
	$cipher='AES-128-ECB';

	$encrypted_string=openssl_encrypt(
		json_encode($req),
		$cipher,
		$key
	);
	$curl = curl_init();

	curl_setopt_array($curl, array(
		CURLOPT_URL => $verifyUrl,
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => '',
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 0,
		CURLOPT_FOLLOWLOCATION => true,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => 'POST',
		CURLOPT_POSTFIELDS =>$encrypted_string,
		CURLOPT_HTTPHEADER => array(
			'cid:' .$siteid_get['key'],
			'Content-Type: text/plain'
		),
	));
	$response = curl_exec($curl);
	curl_close($curl);
	//echo $response;
	//exit;
	$decrypted_string = openssl_decrypt(
		$response,
		$cipher,
		$key
	);
	$res = json_decode($decrypted_string,true);
	
	
	$tr_upd_order['dataPost_verify']	=$req;
	$tr_upd_order['checksum_string']	= $checksum_string;
	$tr_upd_order['encrypted_string']	=$encrypted_string;
	$tr_upd_order['response']			=isset($res)&&$res?$res:$response;
	$tr_upd_order['verifyUrl']			=$verifyUrl;
	$tr_upd_order['cid']				=$siteid_get['key'];

	trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);

	if($qp)
	{
		echo 'verify_response'.$response;
		print_r($res);
		exit;
	}
	
	if($acquirer==81){
	
		$urlC = $bank_url.'/transfer';
		$reqCollect = [
			'source' => $siteid_get['source'],
			'channel' => 'api',
			'extTransactionId' => $siteid_get['extTransactionId'].$_SESSION['transID'],
			'upiId' => $post['upi_address'],
			'terminalId' => $siteid_get['terminalId'],
			'amount' => $total_payment,
			'statusKYC' => 'Y',
			'sid' => $siteid_get['sid'],
		];
		
		$checksum='';
		foreach ($reqCollect as $val){
			$checksum.=$val;
		}
		$checksum_stringC=$checksum.$siteid_get['Checksum_key'];
		$reqCollect['checksum']=hash('sha256',$checksum_stringC);
		$key= $siteid_get['Encryption_key'];
		$key=substr((hash('sha256',$key,true)),0,16);
		$cipher='AES-128-ECB';
		$encrypted_string=openssl_encrypt(
			json_encode($reqCollect),
			$cipher,
			$key
		);
		$curl = curl_init();
	
		curl_setopt_array($curl, array(
			CURLOPT_URL => $urlC,
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_ENCODING => '',
			CURLOPT_MAXREDIRS => 10,
			CURLOPT_TIMEOUT => 0,
			CURLOPT_FOLLOWLOCATION => true,
			CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			CURLOPT_CUSTOMREQUEST => 'POST',
			CURLOPT_POSTFIELDS =>$encrypted_string,
			CURLOPT_HTTPHEADER => array(
				'cid:' .$siteid_get['key'],
				'Content-Type: text/plain'
			),
		));
	
		$responseCollect = curl_exec($curl);
		
		curl_close($curl);
		//echo $response;
		$decrypted_string = openssl_decrypt(
			$responseCollect,
			$cipher,
			$key
		);
		$rescollect = json_decode($decrypted_string,true);
		
		
		
		//exit;
		$request_data = $reqCollect;	//transfer all request information to another variable
	//	unset($request_data['upiId']);		//unset card number
	
	//	$tr_upd_order['dataKey']	=$dataKey;
		$tr_upd_order['dataPost']	=$request_data;
		$tr_upd_order['collectUrl']	=$urlC;
		$tr_upd_order['collectResponse'] =$rescollect;
		$tr_upd_order['checksum_string'] =$checksum_stringC;

		$curl_values_arr['responseInfo']	=$tr_upd_order['collectResponse'];	//save response for curl request
		$curl_values_arr['browserOsInfo']=$browserOs;	//save browser information for curl request

		$_SESSION['acquirer_action']=1;		//set action HKIP for update trasaction via callback
		$_SESSION['curl_values']=@$curl_values_arr;	//set curl values into into $_SESSION

		//trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);
		
		if($qp)
		{
			echo 'verify_response'.$responseCollect;exit;
		}
		########## 78 staatus
		//applied condition according to response status
			if(isset($res['status']) && ($res['status']=='SUCCESS')){//for success
				$_SESSION['hkip_status']=2;
				$_SESSION['acquirer_status_code']=2;
				$_SESSION['acquirer_response']=" Successfully - Success";
				$process_url = "{$data['Host']}/success{$file_v}{$data['ex']}?transID={$transID}&action=hkip"; 
			}
			else if(isset($res['status']) && ($res['status']=="FAILURE" )){//for failed
				$_SESSION['hkip_status']=-1;
				$_SESSION['acquirer_status_code']=-1;
				$_SESSION['acquirer_response']="Failed - Cancelled";
				$process_url = "{$data['Host']}/failed{$file_v}{$data['ex']}?transID={$transID}&action=hkip"; 
			}
			else{// for pending
				
				$_SESSION['acquirer_status_code']=1;
				$_SESSION['acquirer_response']=$_SESSION['acquirer_response']." - Pending";
				$process_url = "{$data['Host']}/trans_processing{$file_v}{$data['ex']}?transID={$transID}&action=hkip";
			}		
		###############
	}
	elseif($acquirer==811){
	
		$urlQr = $bank_url.'/dqr';
		$reqQr = [
			'source' => $siteid_get['source'],
			'channel' => 'api',
			'extTransactionId' => $siteid_get['extTransactionId'].$_SESSION['transID'],
			'sid' => $siteid_get['sid'],
			'terminalId' => $siteid_get['terminalId'],
			'amount' => $total_payment,
			'type' => 'D',
			'remark' => 'test',
			'requestTime' => date("Y-m-d H:i:s"),
			'minAmount' => $total_payment,
		];
		
		$checksum='';
		foreach ($reqQr as $val){
			$checksum.=$val;
		}
		$checksum_stringQ=$checksum.$siteid_get['Checksum_key'];
		$reqQr['checksum']=hash('sha256',$checksum_stringQ);
		$key= $siteid_get['Encryption_key'];
		$key=substr((hash('sha256',$key,true)),0,16);
		$cipher='AES-128-ECB';
		$encrypted_string=openssl_encrypt(
			json_encode($reqQr),
			$cipher,
			$key
		);
		$curl = curl_init();
	
		curl_setopt_array($curl, array(
			CURLOPT_URL => $urlQr,
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_ENCODING => '',
			CURLOPT_MAXREDIRS => 10,
			CURLOPT_TIMEOUT => 0,
			CURLOPT_FOLLOWLOCATION => true,
			CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			CURLOPT_CUSTOMREQUEST => 'POST',
			CURLOPT_POSTFIELDS =>$encrypted_string,
			CURLOPT_HTTPHEADER => array(
				'cid:' .$siteid_get['key'],
				'Content-Type: text/plain'
			),
		));
		$responseQr = curl_exec($curl);

		curl_close($curl);
	
	
		$decrypted_string = openssl_decrypt(
			$responseQr,
			$cipher,
			$key
		);
		$resQr = json_decode($decrypted_string,true);
		//print_r($resQr);
		//echo $resQr['qrString'];
		
		
	
		
		if(isMobileDevice()){
		
			//$int = str_replace('upi','intent',$resQr['qrString']);
	//			header('Location:'.$resQr['qrString']);
			$payment_url = $resQr['qrString'];
		}
		else{
		
			//fetch merchant from $_SESSION
			if(isset($_SESSION['domain_server']['clients']['company_name'])&&$_SESSION['domain_server']['clients']['company_name'])
				$paytitle = $_SESSION['domain_server']['clients']['company_name'];
			else
				$paytitle = trim($_SESSION['domain_server']['clients']['fname'].' '.$_SESSION['domain_server']['clients']['fname']);

			$_SESSION['3ds2_auth']['processed']		=$bank_status_url;
			$_SESSION['3ds2_auth']['payaddress']	=$resQr['qrString'];
			$_SESSION['3ds2_auth']['paytitle']		=$paytitle;
			$_SESSION['3ds2_auth']['currname']		=$orderCurrency;
			$_SESSION['3ds2_auth']['payamt']	=$total_payment;
			$_SESSION['3ds2_auth']['transaction_amt']	=$total_payment;
			$_SESSION['3ds2_auth']['orderId']			=$siteid_get['extTransactionId'].$_SESSION['transID'];
			$_SESSION['3ds2_auth']['currency']		=$_SESSION['json_value']['post']['curr'];
			$_SESSION['3ds2_auth']['amount']			=$_SESSION['json_value']['post']['price'];
			//$_SESSION['3ds2_auth']['bank_process_url']=$siteid_get['bank_process_url'];
		//	$_SESSION['3ds2_auth']['netWorkType']		=$walletType;
			
			
			///print_r($_SESSION['3ds2_auth']);exit;
			$payment_url = "{$data['Host']}/payin/common-qr{$data['ex']}?transID=$transID&orderId={$_SESSION['transID']}&action=chart";
			/*?>
			<img src="https://quickchart.io/chart?chs=200x200&cht=qr&chl=<?=$resQr['qrString'];?>&choe=UTF-8" title=""/><?
		*/
		}

		$_SESSION['redirect_url']=$payment_url;
		$_SESSION['pay_url']=$_SESSION['redirect_url'];

		$tr_upd_order['qrUrl']			= $urlQr;
		$tr_upd_order['checksum_string']= $checksum_stringQ;
		$tr_upd_order['request_data']	= $reqQr;
		$tr_upd_order['qrResponse']		= $resQr;

		$tr_upd_order['pay_url']=$_SESSION['pay_url'];

		$curl_values_arr['responseInfo']	=$tr_upd_order['qrResponse'];	//save response for curl request
		$curl_values_arr['browserOsInfo']	=$browserOs;	//save browser information for curl request

		$_SESSION['acquirer_action']=1;		//set action HKIP for update trasaction via callback
		$_SESSION['curl_values']=@$curl_values_arr;	//set curl values into into $_SESSION

		//trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);

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
	}

	trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);
	
	if(isset($_SESSION['post']['qp'])&&$_SESSION['post']['qp'])
	{
		print_r($req);
		print_r($res);
		//exit;
	}


	if($post['cardsend']=="curl"){
		//$_SESSION['acquirer_status_code']=1;
	}else{
		header("Location:$process_url");
		exit;
	}
}?>