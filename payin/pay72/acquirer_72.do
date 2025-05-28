<?
// 72 Iserve 
/*
$intent_paymentUrl=urlencodef('upi://pay?pa=is1.rario-letspe@finobank&pn=rariotest&mc=6012&tr=535453406365790208&tn=Test Product&am=2.00&mode=04&tid=LTP2720000007243822'); // return upi address for auto run for check via mobile or web 
//$intent_process_redirect=1;
$intent_process_include=1;
*/

$tr_upd_order=$apc_get;
$tr_upd_order['s30_count']=10;
##############################################
//transaction id
     $clientRefId = "LTP".$_SESSION['clientid'];
	 $transaction_id = "00000000000".$transID;
	 $len=strlen($clientRefId);
	 $remLen=19-$len;	
	 $clientRefId = $clientRefId.substr($transaction_id,-$remLen);
	 ##############################################################
	 
if(isset($post['mop'])&&$post['mop']=='UPICOLLECT'){ //for collect
		
		
	if(isset($post['bill_phone']) && !empty($post['bill_phone']) && (empty($post['upi_address'])) )
	{
		$post['upi_address']=$post['bill_phone'];
	}
		
	if(isset($post['upi_address_suffix'])&&$post['upi_address_suffix'] && (strpos($post['upi_address'],'@')===false) ) 
	{ 
		$post['upi_address']=$post['upi_address'].$post['upi_address_suffix'];
		
	}
	
	$tr_upd_order['upa']=$post['upi_address'];
	
		
	$headers = array(
		'client_id: '.$apc_get['client_id'],
		'client_secret: '.$apc_get['client_secret'],
		'Content-Type: application/json',
	);

	//$Url = $bank_url;
	$requestPost['virtualAddress']=$post['upi_address'];
	$requestPost['amount']=$total_payment;
	$requestPost['merchantType']="AGGREGATE";
	$requestPost['paymentMode']= "VPA";
	$requestPost['channelId']= isMobileDevice()?'ANDROID':'WEBUSER';
	$requestPost['clientRefId']= $clientRefId;
	$requestPost['isWalletTopUp']=true;
	$requestPost['remarks']=$post['product'];
	$requestPost['requestingUserName']= $apc_get['requestingUserName'];
	//$requestPost['requestingUserName']= "isutest";

	//exit;
    $curl = curl_init();
	curl_setopt_array($curl, array(
		CURLOPT_URL => $bank_url,
		CURLOPT_RETURNTRANSFER =>true,
		CURLOPT_ENCODING => '',
		CURLOPT_MAXREDIRS => 1,
		CURLOPT_TIMEOUT => 60,
		CURLOPT_FOLLOWLOCATION => true,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => 'POST',
		CURLOPT_POSTFIELDS =>json_encode($requestPost),
		CURLOPT_HTTPHEADER =>$headers,
	));
	
	$res = curl_exec($curl);
	$httpcode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
	curl_close($curl);
	$rescollect = json_decode($res,1);
	//print_r($rescollect);
	
	##################################
	//got their transactionId in the response
	$txnId = $rescollect['txnId'];
	$merchantId = $rescollect['merchantId'];
	$paymentState = $rescollect['paymentState'];
	
	
	$status=((isset($rescollect['status'])&&$rescollect['status'])?$rescollect['status']:'');
	
	$tr_upd_order['requestPost']=$requestPost;
	$tr_upd_order['collectUrl']	=$bank_url;
	$tr_upd_order['collectResponse'] =(isset($rescollect)&&is_array($rescollect)?$rescollect:$res);
	//$tr_upd_order['acquirer_ref'] =$transID;
	
	if(isset($rescollect['txnId'])&&$rescollect['txnId'])
		$tr_upd_order['acquirer_ref'] =$rescollect['txnId'];
	

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

elseif(isset($post['mop'])&&$post['mop']=='QRINTENT'){  //for QR dynamic code
	 //headers
	 $headers = array(
		'client_id: '.$apc_get['client_id'],
		'client_secret: '.$apc_get['client_secret'],
		'Content-Type: application/json',
	);

		
	//$requestPost['virtualAddress']=$apc_get['vpa'];		//optional para
	//$requestPost['virtualAddress']="9814121123@paytm";//$post['upi_address'];
	//Dev Tech : 23-06-17 is hardcoded for is1.skywalk1@finobank 
	$requestPost['virtualAddress']="is1.skywalk1@finobank";
	$requestPost['amount']=$total_payment;
	$requestPost['merchantType']="AGGREGATE";
	$requestPost['paymentMode']=isMobileDevice()?'INTENT':'QR';
	$requestPost['channelId']= isMobileDevice()?'ANDROID':'WEBUSER';
	$requestPost['clientRefId']= $clientRefId;
	$requestPost['isWalletTopUp']=true;
	$requestPost['remarks']=$post['product'];
	$requestPost['requestingUserName']= $apc_get['requestingUserName'];

	//exit;		
		
	$curl = curl_init();
	curl_setopt_array($curl, array(
		CURLOPT_URL => $bank_url,
		CURLOPT_RETURNTRANSFER =>true,
		CURLOPT_ENCODING => '',
		CURLOPT_MAXREDIRS => 1,
		CURLOPT_TIMEOUT => 60,
		CURLOPT_FOLLOWLOCATION => true,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => 'POST',
		CURLOPT_POSTFIELDS =>json_encode($requestPost),
		CURLOPT_HTTPHEADER =>$headers,
	));
	
	
	$res = curl_exec($curl);
	$httpcode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
	curl_close($curl);
	$response= json_decode($res,1);
	
	//echo $res;
	
	//print_r($response); exit;
	
	$tr_upd_order['requestPost']	=$requestPost;
	$tr_upd_order['upiQrIntentUrl']	=$bank_url;
	$tr_upd_order['upiQrIntentResponse'] =(isset($response)&&is_array($response)?$response:$res);
	
	if(isset($response['status'])&&trim($response['status'])&&$response['status']=='FAILED'&&@$response['statusDesc'])
	{
		echo 'Error for '.@$response['statusDesc'];exit; 
	}
	
	if(isset($response['txnId'])&&$response['txnId'])
		$tr_upd_order['acquirer_ref'] =$response['txnId'];
	
	if(isset($response['qrData'])&&trim($response['qrData']))
	{
		$qr_intent_address=urlencodef($response['qrData']); // return upi address for auto run for check via mobile or web 
		//$intent_process_redirect=1;
		//$intent_process_include=1;
		$qr_process_base64=1;
	}
	elseif(isset($response['intentData'])&&trim($response['intentData']))
	{
		$intent_paymentUrl=urlencodef($response['intentData']); // return upi address for auto run for check via mobile or web 
		//$intent_process_redirect=1;
		$intent_process_include=1;
		//$qr_process_base64=1;
	}
	
	//if(isset($response['statusDesc'])&&trim($response['statusDesc']))
		
		$_SESSION['acquirer_response']=@$response['statusDesc'];
	
	
		
}

$tr_upd_order['upa']=@$requestPost['virtualAddress'];

trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);	
	

?>
