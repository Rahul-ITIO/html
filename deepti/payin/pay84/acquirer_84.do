<?
//84,840-849 paythru
error_reporting(E_ALL ^ (E_DEPRECATED));
if(isset($select_mcc_code)&&trim($select_mcc_code))
{
	$mcc_code_list_arr = explode(',',$select_mcc_code);
	
	if(count($mcc_code_list_arr)>1)
	{
		$data['Error']= 'Multiple MCC code mapped';
		$apc_get['terminalId']='';
		$validate=false;
	}
	else
	{
		$apc_get['terminalId']=$mcc_code_list_arr[0];
		$validate=true;
	}
}

################################

//$transID = $_SESSION['transID'];

$tr_upd_order=$apc_get;
$tr_upd_order['s30_count']=10;

//echo "This is demo";exit;

if($acquirer==84){
		
		
	if(isset($post['bill_phone']) && !empty($post['bill_phone']) && (empty($post['upi_address'])) )
	{
		$post['upi_address']=$post['bill_phone'];
	}
		
	if(isset($post['upi_address_suffix'])&&$post['upi_address_suffix'] && (strpos($post['upi_address'],'@')===false) ) 
	{ 
		$post['upi_address']=$post['upi_address'].$post['upi_address_suffix'];
		
	}
	
	$tr_upd_order['upa']=$post['upi_address'];
	
	

$date =  date('d/m/Y h:i A', strtotime(' + 6 hours'));
$Url = $bank_url;
$json ='{  
  "payerVa": "'.$post['upi_address'].'",
  "amount": "'.$total_payment.'",
  "note": "test",
  "collectByDate": "'.$date.'",
  "merchantId": "'.$apc_get['MerchantId'].'",
  "terminalId": "'.$apc_get['terminalId'].'",
  "merchantTranId": "'.$transID.'",
  "billNumber": "'.$transID.'"
}';
$req = json_decode($json,1);
	//exit;
$curl = curl_init();
curl_setopt_array($curl, array(
  CURLOPT_URL => $Url,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>$json,
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/json'
  ),
));

	$collectResponse = curl_exec($curl);

	curl_close($curl);
	//echo $response;
	$rescollect = json_decode($collectResponse,1);
	//print_r($rescollect);
	//exit;
	//echo $response;
	//exit;
	//print_r($rescollect);
	$status=((isset($rescollect['body']['success'])&&$rescollect['body']['success'])?$rescollect['body']['success']:'');
	//exit;


	//exit;
	//transfer all request information to another variable
	//	unset($request_data['upiId']);		//unset card number
	
	//$tr_upd_order['dataKey']	=$dataKey;
	$tr_upd_order['request']	=$req;
	$tr_upd_order['collectUrl']	=$Url;
	$tr_upd_order['collectResponse'] =$rescollect;
	$tr_upd_order['merchantTranId'] =$transID;
	trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);

	$curl_values_arr['responseInfo']	=$tr_upd_order['collectResponse'];	//save response for curl request
	$curl_values_arr['browserOsInfo']=$browserOs;	//save browser information for curl request

	$_SESSION['acquirer_action']=1;		//set action HKIP for update trasaction via callback
	$_SESSION['curl_values']=@$curl_values_arr;	//set curl values into into $_SESSION

	//trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);
	
	if(isset($qp)&&$qp)
	{
		echo 'verify_response'.$responseCollect;exit;
	}
	
	//applied condition according to response status
		
	$_SESSION['acquirer_status_code']=1;
	$_SESSION['acquirer_response']=((isset($_SESSION['acquirer_response'])&&$_SESSION['acquirer_response'])?$_SESSION['acquirer_response']:'')." - Pending";
	$process_url=$trans_processing;
	###############
}

elseif($acquirer==841){
	 //echo$apc_get['MerchantVPA'];
	
$urlQr = $bank_url;
$reqQr = '{
  "amount":"'.$total_payment.'",
  "merchantId":"'.$apc_get['MerchantId'].'",
  "terminalId":"'.$apc_get['terminalId'].'",
  "merchantTranId":"'.$transID.'",
  "billNumber": "'.$transID.'"
}';
$request = json_decode($reqQr,1);
//exit;		
		
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
  CURLOPT_POSTFIELDS =>$reqQr,
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/json'
  ),
));

	$response = curl_exec($curl);
	//exit;
	curl_close($curl);
	
	//echo $response;
	$res = json_decode($response,1);
	//print_r($res);
	//exit;
	
	$refId=((isset($res['body']['refId'])&&$res['body']['refId'])?$res['body']['refId']:'');
	$url="upi://pay?pa={$apc_get['MerchantVPA']}&pn={$apc_get['MerchantName']}&tr=$refId&am={$total_payment}&cu=INR&mc={$apc_get['terminalId']}";
	//exit;
	
	$urlEn=urlencode($url);
	
	$qr_intent_address=$urlEn; // return upi address for auto run for check via mobile or web 
		$intent_process_redirect=1;
	
	/*
		if(isMobileDevice()){
			
			//$payment_url = $url;
			
			$intent_paymentUrl = urldecode($urlEn);
			
			if(isset($intent_paymentUrl) && !empty($intent_paymentUrl)) 
			{
				
				$intent_paymentUrl=intent_payment_url_f($intent_paymentUrl,$post['wallet_code_app'],1);
				
				//$intent_paymentUrl = urldecode($urlEn);
				
				$data['intent_paymentUrl']=$intent_paymentUrl;
					//$paymentUrl=$intent_paymentUrl;
					$payment_url=$intent_paymentUrl;
				$_SESSION['intent_paymentUrl']=$intent_paymentUrl;
				$_SESSION['pay_url']=$intent_paymentUrl;
				$tr_upd_order['pay_mode']='3D'; 
				$tr_upd_order['wallet_code_app']=$post['wallet_code_app'];	
				$tr_upd_order['pay_url']=$intent_paymentUrl;	
				$tr_upd_order['intent_paymentUrl']=$intent_paymentUrl;
				//$_SESSION['SA']['intent_paymentUrl'] = $intent_paymentUrl;
				$_SESSION['SA']['intent_acitve']=1;
				//echo "<br/><br/>intent_paymentUrl=><br/>".$intent_paymentUrl;
				
				$tr_upd_order['auth_data'] =($intent_paymentUrl);
				
				$process_url=$intent_process_url;
				
				$_SESSION['3ds2_auth']['processed']	=$status_url;
				$_SESSION['3ds2_auth']['payaddress']=$intent_paymentUrl;
				$_SESSION['3ds2_auth']['paytitle']	=$_SESSION['dba'];
				$_SESSION['3ds2_auth']['currname']	=$orderCurrency;
				$_SESSION['3ds2_auth']['payamt']	=$total_payment;
			
				$_SESSION['3ds2_auth']['bill_currency']=$_SESSION['bill_currency'];
				$_SESSION['3ds2_auth']['bill_amt']	=$_SESSION['json_value']['post']['bill_amt'];
				$_SESSION['3ds2_auth']['product_name']	=$_SESSION['product'];
				
				$_SESSION['3ds2_auth']['os']		='mobile_android';
				$_SESSION['3ds2_auth']['mop']		='upi_intent';
				$_SESSION['3ds2_auth']['appName']	=$data['appName'];
				
					//$tr_upd_order['auth_url']=$intent_process_url;
					$tr_upd_order['auth_url']=$intent_paymentUrl;
					$tr_upd_order['auth_data']=htmlentitiesf($_SESSION['3ds2_auth']);
				authf($_SESSION['tr_newid'],$intent_paymentUrl,$_SESSION['3ds2_auth']);
				
			}
		}
		else{
		
			//web base qr-code
			
			//payaddress
			$web_base_qrcode=1;
			$_SESSION['3ds2_auth']['payaddress']	=urldecode($urlEn);

			
			
			$payment_url = "{$data['Host']}/payin/indian-qr{$data['ex']}?transID=$transID&orderId={$_SESSION['transID']}&action=chart";
			
				$tr_upd_order['auth_url']=$payment_url;
				$tr_upd_order['auth_data']=htmlentitiesf($_SESSION['3ds2_auth']);
			authf($_SESSION['tr_newid'],$payment_url,$_SESSION['3ds2_auth']);
			
		}

	*/

		$tr_upd_order['qrUrl']			= $urlQr;
		
		$tr_upd_order['request_data']	= $request;
		$tr_upd_order['qrResponse']		= $res;


		$curl_values_arr['responseInfo']	=$tr_upd_order['qrResponse'];	//save response for curl request
	

		$_SESSION['acquirer_action']=1;		//set action HKIP for update trasaction via callback
		

		

		//check if payment_url define then re-direct to this url else direct to failed.do
		
		
	}

	trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);
	
	

	
?>