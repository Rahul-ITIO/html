<?
//error_reporting(E_ALL ^ (E_DEPRECATED));
/*
if($data['localhosts']==true)
{
	$re_post_less_than_step=4;
	$errorMsg='Testing via localhost ';
}
else 
*/

{
	
if(isset($select_mcc_code)&&trim($select_mcc_code)&&(!isset($apc_get['mcc'])||empty($apc_get['mcc'])))
{
	$mcc_code_list_arr = explode(',',$select_mcc_code);
	
	if(count($mcc_code_list_arr)>1)
	{
		$data['Error']= 'Multiple MCC code mapped';
		$apc_get['mcc']='';
		$validate=false;
	}
	else if (@$mcc_code_list_arr[0])
	{
		$apc_get['mcc']=@$mcc_code_list_arr[0];
		$validate=true;
	}
}
//acquirer 78, 781
	
	if( ($acquirer==78) || (isset($post['mop'])&&$post['mop']=='UPICOLLECT') ){ //for collect

		
		if(isset($post['bill_phone']) && !empty($post['bill_phone']) && (empty($post['upi_address'])) )
		{
			$post['upi_address']=$post['bill_phone'];
		}
			
		if(isset($post['upi_address_suffix'])&&$post['upi_address_suffix']) 
		{ 
			$post['upi_address'].=$post['upi_address_suffix'];
			$tr_upd_order['upa']=$post['upi_address'];
		}
		
		$bank_url=str_replace('/qr/v1','/cm/v2',$bank_url);
		
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
		$tr_upd_order['apiResponseVerifyTime']=date('Y-m-d H:i:s');
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
		$tr_upd_order['apiResponseTime']=date('Y-m-d H:i:s');
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
			
			
			if(isset($res['status']) && ($res['status']=="SUCCESS" )){//for SUCCESS than response is auto hit for collect via server to server in mobile app as per upi address 
			
				//Dev Tech : 23-10-11 set to UPICOLLECT response 
				$json_arr_set['UPICOLLECT']='Y';
			
			}elseif(isset($res['status']) && ($res['status']=="FAILURE" )){//for failed
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
	
	
	
	
	
	
	
	elseif( ($acquirer==781) || (isset($post['mop'])&&$post['mop']=='QRINTENT') )
	{ //for QR dynamic code QR & INTENT 
		
		$bank_url=str_replace('/cm/v2','/qr/v1',$bank_url);
		
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
			'mcc' => @$apc_get['mcc'],
		];
		
		include("acquirer_78_qr_function".$data['iex']);
		$resQr = qr_78_post($urlQr,$reqQr);
		
		######################################## 
		
		/*
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
		*/
		######################################## 


		// step 1 if error 
		if( ( isset($resQr['errorMsg'])&&$resQr['errorMsg'] ) || (!is_array($resQr)) ){ 
			//$re_post_less_than_step=4;
			
			$tr_upd_order['countPost']=1;
			$tr_upd_order['errorMsg']=@$resQr['errorMsg'];
			trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);
			
			$resQr = qr_78_post($urlQr,$reqQr);
			
			$errorMsg=@$resQr['errorMsg'];
			echo 'Error for '.@$resQr['errorMsg'];
			//exit; 
		} 
		
		// step 2 if error 
		if( ( isset($resQr['errorMsg'])&&$resQr['errorMsg'] ) || (!is_array($resQr)) ){ 
			
			$tr_upd_order['countPost']=2;
			$tr_upd_order['errorMsg']=@$resQr['errorMsg'];
			trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);
			
			$resQr = qr_78_post($urlQr,$reqQr);
			
			$errorMsg=@$resQr['errorMsg'];
			echo 'Error for '.@$resQr['errorMsg'];
			//exit; 
		} 
		
		
		// step 3 if error 
		if( ( isset($resQr['errorMsg'])&&$resQr['errorMsg'] ) || (!is_array($resQr)) ){ 
			
			$tr_upd_order['countPost']=3;
			$tr_upd_order['errorMsg']=@$resQr['errorMsg'];
			trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);
			
			$resQr = qr_78_post($urlQr,$reqQr);

			$errorMsg=@$resQr['errorMsg'];
			echo 'Error for '.@$resQr['errorMsg'];
			//exit; 
		} 
		
		
		
		
		
		if(isset($resQr['qrString'])&&$resQr['qrString']){ 
		
			$intent_process_include=1;
			
			// urlencodef 
			$qr_intent_address=replace_space_tab_br_for_intent_deeplink($resQr['qrString'],1); // return upi address for auto run for check via mobile or web 
			
			/*
			//Remove space and new line and tab 
			$qr_intent_address = preg_replace('~[\r\n\t]+~', '', $qr_intent_address);	
			$qr_intent_address = str_ireplace([' ',' ',' '], '+', $qr_intent_address);
			
			//$qr_intent_address=urlencodef($qr_intent_address); // return upi address for auto run for check via mobile or web 
			*/
			
		}else{
			$payment_url=$trans_processing;
		}
		
		
		$tr_upd_order['qrUrl']			= $urlQr;
		$tr_upd_order['checksum_string']= $checksum_stringQ;
		$tr_upd_order['request_data']	= $reqQr;
		$tr_upd_order['qrResponse']		= $resQr;
		$tr_upd_order['apiResponseTime']=date('Y-m-d H:i:s');

		$curl_values_arr['responseInfo']	=$tr_upd_order['qrResponse'];	//save response for curl request
	

		$_SESSION['acquirer_action']=1;		//set action HKIP for update trasaction via callback
		
		//trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);

		//check if payment_url define then re-direct to this url else direct to failed.do
		
	}
	
	

	trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);
	
	
}	

	

?>