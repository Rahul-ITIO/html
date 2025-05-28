<?
//Acquirer_31
//echo "abcd";
$tr_upd_order=$apc_get;//all backend json value from Acquirer coming this($apc_get)
$tr_upd_order['s30_count']=10;
$req = '{ 
  "username": "'.$apc_get['username'].'",
  "password": "'.$apc_get['password'].'"
}';

$tokenUrl=$bank_url.'/'."generateToken";//login url through this end point we will get token for further process 
$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => $tokenUrl,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>$req,
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/json'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
//echo $response;
$res = json_decode($response,1);

 $token=$res['payload']['token'];
 
 
 
 if($token){
	$reaUpi = '{
"amount": '.$total_payment.',
"option": "INTENT"
}';

$requestQr = json_decode($reaUpi,1);

	$urlInt=$bank_url.'/'."transaction/generate-upi";
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
  CURLOPT_POSTFIELDS =>$reaUpi,
  CURLOPT_HTTPHEADER => array(
   "Authorization: Bearer ".$token."",
    'Content-Type: application/json'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
//echo $response;
$resQr = json_decode($response,1);
//echo $response ;

//print_r($resQr);
//exit;
 $Qurl= $resQr['intentData'];
 //echo $url= urlencode($Qurl);
$qr_intent_address=urlencode($Qurl);
 //$intent_process_redirect=1;
 $intent_process_include=1;
 $tr_upd_order['qrUrl']			=$Qurl;
		
		$tr_upd_order['request_data']	=$requestQr;//qr request store in database
		
		//acquirer does not offer status check api
		$tr_upd_order['acquirer_does_not_offer_status_check_api']='1';
		
		
		if(isset($restoken['user']['config'])) 
			unset($restoken['user']['config']);
		
		$tr_upd_order['trResponse']		=$token;//token response store in database
        $tr_upd_order['qrResponse']		=$resQr;

		$curl_values_arr['responseInfo'] =$tr_upd_order['qrResponse'];	//save response for curl request
		
		//check if payment_url define then re-direct to this url else direct to failed.do
		
		$_SESSION['acquirer_action']=1;		//set for update trasaction via callback

	}
 /*if($token){
  $urlUpi = $bank_url.'/'."transaction/generate-upi";
 
 $reqUpi =
'{
"amount": '.$total_payment.',
"option": "INTENT"
}';
$Qrequest=json_decode($reqUpi,1);
 $headers=array(
    "Authorization: Bearer ".$token."",
    "Content-Type: application/json"
  );
  //print_r($headers);
$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => $urlUpi,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>$reqUpi,
  CURLOPT_HTTPHEADER => $headers,
));

$response = curl_exec($curl);

curl_close($curl);
//echo $response;
$resUpi = json_decode($response,1);
 $Qrurl = $resUpi['intentData'];
 
 $qr_intent_address=urlencode($Qrurl);
 $intent_process_redirect=1;
 
 $tr_upd_order['qrUrl']			=$Qrurl;
		
		$tr_upd_order['request_data']	=$Qrequest;//qr request store in database
		
		if(isset($restoken['user']['config'])) 
			unset($restoken['user']['config']);
		
		$tr_upd_order['trResponse']		=$res;//token response store in database
        $tr_upd_order['qrResponse']		=$resUpi;

		$curl_values_arr['responseInfo'] =$tr_upd_order['qrResponse'];	//save response for curl request
		
		//check if payment_url define then re-direct to this url else direct to failed.do
		
		$_SESSION['acquirer_action']=1;	
		echo "abcd";
 }
trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);*/
?>

	

