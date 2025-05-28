<?
//acquirer 78, 781
	
	if($acquirer==78){
		
		if(isset($post['bill_phone']) && !empty($post['bill_phone']) && (empty($post['upi_address'])) )
		{
			$post['upi_address']=$post['bill_phone'];
		}
			
		if(isset($post['upi_address_suffix'])&&$post['upi_address_suffix']) 
		{ 
			$post['upi_address'].=$post['upi_address_suffix'];
			$tr_upd_order['upa']=$post['upi_address'];
		}
				
		// parameter request
		$verifyUrl = $bank_url.'/verifyVPA';
		
		$req = [
			'source' => $apc_get['source'],
			'channel' => 'api',
			'extTransactionId' => $apc_get['extTransactionId'].$_SESSION['transID'],
			'upiId' => $post['upi_address'],
			'terminalId' => $apc_get['terminalId'],
			'sid' => $apc_get['sid'],
		];
		
		//ksort($req);
		
		$checksum='';
		foreach ($req as $val){
			$checksum.=$val;
		}
		$checksum_string=$checksum.$apc_get['Checksum_key'];
		$req['checksum']=hash('sha256',$checksum_string);
		$key= $apc_get['Encryption_key'];
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
			CURLOPT_TIMEOUT => 30,
			CURLOPT_FOLLOWLOCATION => true,
			CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			CURLOPT_HEADER => 0,
			CURLOPT_SSL_VERIFYHOST => 0,
			CURLOPT_SSL_VERIFYPEER => 0,
			CURLOPT_CUSTOMREQUEST => 'POST',
			CURLOPT_POSTFIELDS =>$encrypted_string,
			CURLOPT_HTTPHEADER => array(
				'cid:' .$apc_get['key'],
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
		
		$tr_upd_order['dataPost_verify'] = $req;
		$tr_upd_order['checksum_string_verify'] = $checksum_string;
		$tr_upd_order['encrypted_string_verify'] = $encrypted_string;
		$tr_upd_order['response_verify'] = ((isset($res)&&$res)?$res:$response);
		$tr_upd_order['verifyUrl'] =$verifyUrl;
		$tr_upd_order['cid'] =$apc_get['key'];

		trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);


		
		
		
		$urlC = $bank_url.'/transfer';
		$tr_upd_order['transfer']	=$urlC;
		$reqCollect = [
				'source' => $apc_get['source'],
				'channel' => 'api',
				'extTransactionId' => $apc_get['extTransactionId'].$_SESSION['transID'],
				'upiId' => $post['upi_address'],
				'terminalId' => $apc_get['terminalId'],
				'amount' => $total_payment,
				'statusKYC' => 'Y',
				'sid' => $apc_get['sid'],
		];
		
		//ksort($reqCollect);
		
		$checksum='';
		foreach ($reqCollect as $val){
			$checksum.=$val;
		}
		$checksum_stringC=$checksum.$apc_get['Checksum_key'];
		$reqCollect['checksum']=hash('sha256',$checksum_stringC);
		$key= $apc_get['Encryption_key'];
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
			CURLOPT_TIMEOUT => 30,
			CURLOPT_FOLLOWLOCATION => true,
			CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			CURLOPT_HEADER => 0,
			CURLOPT_SSL_VERIFYHOST => 0,
			CURLOPT_SSL_VERIFYPEER => 0,
			CURLOPT_CUSTOMREQUEST => 'POST',
			CURLOPT_POSTFIELDS =>$encrypted_string,
			CURLOPT_HTTPHEADER => array(
				'cid:' .$apc_get['key'],
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
		//print_r($rescollect);
		
		
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
		/*	if(isset($res['status']) && ($res['status']=='SUCCESS')){//for success
				$_SESSION['hkip_status']=2;
				$_SESSION['acquirer_status_code']=2;
				$_SESSION['acquirer_response']=" Successfully - Success";
				$process_url = $return_url;
			}
			else */ 
			if(isset($res['status']) && ($res['status']=="FAILURE" )){//for failed
				$_SESSION['hkip_status']=-1;
				$_SESSION['acquirer_status_code']=-1;
				$_SESSION['acquirer_response']="Failed - Cancelled";
				$process_url = $return_url; 
			}
			else{// for pending
				
				$_SESSION['acquirer_status_code']=1;
				$_SESSION['acquirer_response']=$_SESSION['acquirer_response']." - Pending";
				$process_url = $trans_processing;
			}		
		###############
	}
	elseif($acquirer==781){
		$urlQr = $bank_url.'/dqr';
		$reqQr = [
			'source' => $apc_get['source'],
			'channel' => 'api',
			'extTransactionId' => $apc_get['extTransactionId'].$_SESSION['transID'],
			'sid' => $apc_get['sid'],
			'terminalId' => $apc_get['terminalId'],
			'amount' => $total_payment,
			'type' => 'D',
			'remark' => $_SESSION['transID'],
			'requestTime' => date("Y-m-d H:i:s"),
			'minAmount' => $total_payment,
		];
		
		$checksum='';
		foreach ($reqQr as $val){
			$checksum.=$val;
		}
		$checksum_stringQ=$checksum.$apc_get['Checksum_key'];
		$reqQr['checksum']=hash('sha256',$checksum_stringQ);
		$key= $apc_get['Encryption_key'];
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
			CURLOPT_TIMEOUT => 30,
			CURLOPT_FOLLOWLOCATION => true,
			CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			CURLOPT_HEADER => 0,
			CURLOPT_SSL_VERIFYHOST => 0,
			CURLOPT_SSL_VERIFYPEER => 0,
			CURLOPT_CUSTOMREQUEST => 'POST',
			CURLOPT_POSTFIELDS =>$encrypted_string,
			CURLOPT_HTTPHEADER => array(
				'cid:' .$apc_get['key'],
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
		
		if(isset($resQr['qrString'])&&$resQr['qrString']){ 
		
			$intent_process_include=1;
			
			$qr_intent_address=urlencodef($resQr['qrString']); // return upi address for auto run for check via mobile or web 
			
			//Remove space and new line and tab 
			$qr_intent_address = preg_replace('~[\r\n\t]+~', '', $qr_intent_address);	
			$qr_intent_address = str_ireplace([' ',' ',' '], '', $qr_intent_address);
			
			//$qr_intent_address=urlencodef($qr_intent_address); // return upi address for auto run for check via mobile or web 
			
			
		}else{
			$payment_url=$trans_processing;
		}
		
		
		/*
		
		if(isMobileDevice()){
			
			//$payment_url = urldecode($resQr['qrString']);
			$intent_paymentUrl = urldecode($resQr['qrString']);
			
			if(isset($intent_paymentUrl) && !empty($intent_paymentUrl)) 
			{
				$intent_paymentUrl=intent_payment_url_f($intent_paymentUrl,$post['wallet_code_app'],1);
				$data['intent_paymentUrl']=$intent_paymentUrl;
					//$paymentUrl=$intent_paymentUrl;
					$payment_url=$intent_paymentUrl;
				$_SESSION['pay_url']=$intent_paymentUrl;
				$tr_upd_order['pay_mode']='3D'; 
				$tr_upd_order['wallet_code_app']=$post['wallet_code_app'];	
					
				$tr_upd_order['pay_url']=$intent_paymentUrl;	
				$tr_upd_order['intent_paymentUrl']=$intent_paymentUrl;
				//$_SESSION['SA']['intent_paymentUrl'] = $intent_paymentUrl;
				$_SESSION['SA']['intent_acitve']=1;
				//echo "<br/><br/>intent_paymentUrl=><br/>".$intent_paymentUrl;
				
				
				$_SESSION['3ds2_auth']['processed']	=$status_url;
				$_SESSION['3ds2_auth']['payaddress']=$intent_paymentUrl;
				$_SESSION['3ds2_auth']['paytitle']	=$_SESSION['dba'];
				$_SESSION['3ds2_auth']['currname']	=$orderCurrency;
				$_SESSION['3ds2_auth']['payamt']	=$total_payment;
				$_SESSION['3ds2_auth']['appName']	=$data['appName'];
				
				$_SESSION['3ds2_auth']['bill_currency']=$_SESSION['bill_currency'];
				$_SESSION['3ds2_auth']['bill_amt']	=$_SESSION['json_value']['post']['bill_amt'];
				$_SESSION['3ds2_auth']['product_name']	=$_SESSION['product'];
			
			
				$_SESSION['3ds2_auth']['os']		='mobile_android';
				$_SESSION['3ds2_auth']['mop']		='upi_intent';
				
					//$tr_upd_order['auth_url']=$intent_process_url;
					$tr_upd_order['auth_url']=$intent_paymentUrl;
					$tr_upd_order['auth_data']=htmlentitiesf($_SESSION['3ds2_auth']);
				authf($_SESSION['tr_newid'],$intent_paymentUrl,$_SESSION['3ds2_auth']);
			}
				
		}
		else{
		

			$_SESSION['3ds2_auth']['processed']			= $status_url;
			$_SESSION['3ds2_auth']['payaddress']		= urldecode($resQr['qrString']);
			$_SESSION['3ds2_auth']['paytitle']			=$_SESSION['dba'];
			$_SESSION['3ds2_auth']['currname']			=$orderCurrency;
			$_SESSION['3ds2_auth']['payamt']			=$total_payment;
			
			$_SESSION['3ds2_auth']['bill_currency']		=$_SESSION['bill_currency'];
			$_SESSION['3ds2_auth']['bill_amt']			=$_SESSION['json_value']['post']['bill_amt'];
			$_SESSION['3ds2_auth']['product_name']		=$_SESSION['product'];
			
			$_SESSION['3ds2_auth']['os']				='web';
			$_SESSION['3ds2_auth']['mop']				='qrcode';
			
			//$_SESSION['3ds2_auth']['transaction_amt']	=$total_payment;
			//$_SESSION['3ds2_auth']['orderId']			=$apc_get['extTransactionId'].$_SESSION['transID'];
			
			
			
			///print_r($_SESSION['3ds2_auth']);exit;
			$payment_url = "{$data['Host']}/payin/common-qr{$data['ex']}?transID=$transID&orderId={$_SESSION['transID']}&action=chart";
			
			
			//$tr_upd_order['3ds2_auth'] = $_SESSION['3ds2_auth'];
			
				$tr_upd_order['auth_url']=$payment_url;
				$tr_upd_order['auth_data']=htmlentitiesf($_SESSION['3ds2_auth']);
			authf($_SESSION['tr_newid'],$payment_url,$_SESSION['3ds2_auth']);
			
		}
		
		*/
		
		
		$tr_upd_order['qrUrl']			= $urlQr;
		$tr_upd_order['checksum_string']= $checksum_stringQ;
		$tr_upd_order['request_data']	= $reqQr;
		$tr_upd_order['qrResponse']		= $resQr;

		$curl_values_arr['responseInfo']	=$tr_upd_order['qrResponse'];	//save response for curl request
	

		$_SESSION['acquirer_action']=1;		//set action HKIP for update trasaction via callback
		
		//trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);

		//check if payment_url define then re-direct to this url else direct to failed.do
		
	}
	
	

	trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);
	
	
	

	

?>