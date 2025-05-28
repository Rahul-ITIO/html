<?
//Acquirer_31

$tr_upd_order=$apc_get;//all backend json value from Acquirer coming this($apc_get)
$tr_upd_order['s30_count']=10;

//request for token generation coming from json backend
$req = '{ 
  "email": "'.$apc_get['email'].'",
  "password": "'.$apc_get['password'].'"
}';

//exit;
$loginUrl="https://api.step2pay.online/login";//login url through this end point we will get token for further process 
$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => $loginUrl,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_POSTFIELDS => $req,
  CURLOPT_HTTPHEADER => array(
     "Content-Type: application/json"
  ),
));

$response = curl_exec($curl);

curl_close($curl);

$restoken = json_decode($response,1);
//need to alphaNumeric value in order id
$userid= "Ample";
//$order_id=$userid.$transID;
$order_id=$transID;
$token = $restoken['access_token'];

if($token){
	
$request = '{
  "billing_person_name": "'.$post['fullname'].'",
  "fulfillment_status": "1",
  "payment_status": "1",
  "order_number": "'.$order_id.'",
  "tax": "0",
  "type": "3",
  "total": '.$total_payment.',
  "phone": "'.$post['bill_phone'].'",
  "subtotal": '.$total_payment.',
  "platform_id": "0",
  "return_url": "'.($status_url).'",
  "currency": "'.$orderCurrency.'",
  "email": "'.$post['bill_email'].'"
}';
//exit;
//fullfillment_status=1,payment_status=1,tax=0,type=3,platform_id=0 these values will be fixed according to documents
$Qrequest = json_decode($request,1);
//print_r($Qrequest);
//exit;
 $headers=array(
    "Authorization: Bearer ".$token."",
    "Content-Type: application/json"
  );
  
$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => $bank_url,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_POSTFIELDS => $request,
  CURLOPT_HTTPHEADER => $headers,
));

 $response1 = curl_exec($curl);

curl_close($curl);
//echo $response;
$res = json_decode($response1,1);
//print_r($res);
//exit;

$Qrurl=$res['upi_url'];


$qr_intent_address=urlencode($Qrurl); // return upi address for auto run for check via mobile or web 
//$without_intent=1;
//$without_intent_function=1; 
$intent_process_redirect=1;

	/*
	if(isMobileDevice()){
		$intent_process_redirect=1;
		//$intent_paymentUrl=$Qrurl;
		//payaddress
		$mobile_android_base_intent=1;
		$_SESSION['3ds2_auth']['payaddress']=$qr_intent_address;
	}
	*/
	
		//exit;
	
		$tr_upd_order['qrUrl']			=$Qrurl;
		
		$tr_upd_order['request_data']	=$Qrequest;//qr request store in database
		
		if(isset($restoken['user']['config'])) 
			unset($restoken['user']['config']);
		
		$tr_upd_order['trResponse']		=$restoken;//token response store in database
        $tr_upd_order['qrResponse']		=$res;

		$curl_values_arr['responseInfo'] =$tr_upd_order['qrResponse'];	//save response for curl request
		
		//check if payment_url define then re-direct to this url else direct to failed.do
		
		$_SESSION['acquirer_action']=1;		//set for update trasaction via callback
}

 trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);
	
	

