<?

$tr_upd_order=$apc_get;
$tr_upd_order['s30_count']=10;
$orderCurrency=$_SESSION['curr'];
//print_r($apc_get);
require_once("function_32.do");
	$paytmParams['body']['requestType'] = "Payment";
	$paytmParams['body']['mid'] = $apc_get['mid'];
	$paytmParams['body']['websiteName'] = "DEFAULT";
	$paytmParams['body']['orderId'] = $transID;
	$paytmParams['body']['callbackUrl'] ="https://webhook.site/160ee8e8-8ed4-4976-958f-f598c5e81595"; //$data['Host']."/payin/pay31/status_31.do?action=webhook";
	$paytmParams['body']['txnAmount']['value']=$total_payment;
	$paytmParams['body']['txnAmount']['currency']=$orderCurrency;
	$paytmParams['body']['userInfo']['custId']=rand();
	$key=$apc_get['key'];
	//print_r($paytmParams);
	//exit;
###################################################
//checksum
	$checksum = PaytmChecksum::generateSignature(json_encode($paytmParams['body'], JSON_UNESCAPED_SLASHES),$key);
	$paytmParams['head']['channelId']= "WEB";
	$paytmParams['head']['signature']= $checksum;
	$post_data = json_encode($paytmParams, JSON_UNESCAPED_SLASHES);
	$mid=$apc_get['mid'];
	$urlInt =$bank_url.'/'."initiateTransaction?mid=$mid&orderId=$transID";$curl = curl_init();
	
  curl_setopt_array($curl, array(
  CURLOPT_URL => $urlInt,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>$post_data,
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/json'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
//echo $response;
$resToken = json_decode($response,1);
 $token=$resToken['body']['txnToken'];
 if($acquirer==32){
		
		
	if(isset($post['bill_phone']) && !empty($post['bill_phone']) && (empty($post['upi_address'])) )
	{
		$post['upi_address']=$post['bill_phone'];
	}
		
	if(isset($post['upi_address_suffix'])&&$post['upi_address_suffix'] && (strpos($post['upi_address'],'@')===false) ) 
	{ 
		$post['upi_address']=$post['upi_address'].$post['upi_address_suffix'];
		
	}
	
	$tr_upd_order['upa']=$post['upi_address'];
	
	

$upi = $post['upi_address'];
//exit;

$UrlVpa = $bank_url.'/'."vpa/validate?mid=$mid&orderId=$transID";
$dataVpa= '{
    "head": {
        "txnToken": "'.$token.'"
    },
    "body": {
        "vpa": "'.$upi.'"
    }
}';
$req = json_decode($dataVpa,1);
	//exit;
$curl = curl_init();
curl_setopt_array($curl, array(
  CURLOPT_URL => $UrlVpa ,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>$dataVpa,
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/json'
  ),
));

	$response = curl_exec($curl);

	curl_close($curl);
	//echo $response;
	$resVpa = json_decode($response,1);
	 $dataPro='{
    "body": {
        "requestType": "NATIVE",
        "mid": "'.$mid.'",
        "orderId": "'.$transID.'",
        "paymentMode": "UPI",
        "payerAccount": "'.$upi.'"
    },
    "head": {
        "txnToken": "'.$token.'"
    }
}';
$requestC = json_decode($dataPro,1);
 $urlCollect = $bank_url.'/'."processTransaction?mid=$mid&orderId=$transID";
 $curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => $urlCollect,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>$dataPro,
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/json'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
//echo $response;
$resCollect = json_decode($response,1);
//print_r($resCollect);
//exit;


	$status=((isset($rescollect['body']['resultInfo']['resultStatus'])&&$rescollect['body']['resultInfo']['resultStatus'])?$rescollect['body']['resultInfo']['resultStatus']:'');
	//exit;


	//exit;
	//transfer all request information to another variable
	//	unset($request_data['upiId']);		//unset card number
	
	//$tr_upd_order['dataKey']	=$dataKey;
	$tr_upd_order['request']	=$requestC;
	$tr_upd_order['collectUrl']	=$urlCollect;
	$tr_upd_order['VpaUrl']	=$UrlVpa;
	$tr_upd_order['collectResponse'] =$rescollect;
	
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
	
}
###############
	elseif($acquirer==321){
	$dataPro= '{
    "body": {
        "requestType": "NATIVE",
        "mid": "'.$mid.'",
        "orderId": "'.$transID.'",
        "paymentMode": "UPI_INTENT"   
    },
    "head": {
        "txnToken": "'.$token.'"
    }
}';
$requestQr= json_decode($dataPro,1);
	$urlInt=$bank_url.'/'."processTransaction?mid=$mid&orderId=$transID";
	$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => $urlInt,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>$dataPro,
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/json'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
//echo $response;
$resQr = json_decode($response,1);
//print_r($resQr);
 $Qurl= $resQr['body']['deepLinkInfo']['deepLink'];
 //echo $url= urlencode($Qurl);
$qr_intent_address=urlencode($Qurl);
 $intent_process_redirect=1;
 $tr_upd_order['qrUrl']			=$Qurl;
		
		$tr_upd_order['request_data']	=$requestQr;//qr request store in database
		
		if(isset($restoken['user']['config'])) 
			unset($restoken['user']['config']);
		
		$tr_upd_order['trResponse']		=$token;//token response store in database
        $tr_upd_order['qrResponse']		=$resQr;

		$curl_values_arr['responseInfo'] =$tr_upd_order['qrResponse'];	//save response for curl request
		
		//check if payment_url define then re-direct to this url else direct to failed.do
		
		$_SESSION['acquirer_action']=1;		//set for update trasaction via callback

	}
	elseif($acquirer==322){
	
	$urlNb=$bank_url.'/'."fetchNBPaymentChannels?mid=$mid&orderId=$transID";
	 $dataNet= '{
    "head": {
        "txnToken": "'.$token.'"
    },
    "body": {
        "type": "MERCHANT"
    }
}';
$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => $urlNb,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>$dataNet,
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/json'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
//echo $response;
$resN = json_decode($response,1);
//print_r($resN);
	}
	//exit;
	trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);
//exit;
?>