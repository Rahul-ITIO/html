<?
$tr_upd_order=$apc_get;

$tr_upd_order['s30_count']=10;
$ShopId = $apc_get['ShopId'];
$password = $apc_get['Pass'];

 $Account_id = $apc_get['AccountId'];
 $key= $apc_get['Key'];

 $orderId = $transID;
 $signature = hash("sha256",$orderId.$key);
 $postData=
'{
  "Credentials": {
    "AccountId": "'. $Account_id .'",
    "Signature": "'. $signature .'"
  },
  "CustomerDetails": {
    "FirstName": "'.$_SESSION['info_data']['first_name'].'",
    "LastName": "'.$_SESSION['info_data']['last_name'].'",
    "CustomerIP": "'.$_SESSION['bill_ip'].'",
    "Phone": "'.$post['bill_phone'].'",
    "Email": "'.$post['bill_email'].'",
    "Street": "'.$post['bill_address'].'",
    "City": "'.$post['bill_city'].'",
    "Region": "",
    "Country": "'.$post['country_two'].'",
    "Zip": "'.$post['bill_zip'].'"
  },
  "CardDetails": {
    "CardHolderName": "'.$post['fullname'].'",
    "CardNumber": "'.$post['ccno'].'",
    "CardExpireMonth": "'.$post['month'].'",
    "CardExpireYear": "'.$post['year'].'",
    "CardSecurityCode": "'.$post['ccvv'].'"
  },
  "ProductDescription": "Request to '.$_SESSION['product'].'",
  "TotalAmount":"'. $total_payment*100 . '",
  "CurrencyCode": "'.$orderCurrency.'",
  "TransactionId": "' . $orderId . '",
"CallbackURL":"'.$webhookhandler_url.'",
  "ReturnUrl": "'.$status_url_1.'"
  
}';


//return_url change via status_url_1


$request = json_decode($postData,true);

//print_r($request); exit;
 
 $auth= base64_encode("$ShopId:$password");
	
 $curl = curl_init();
  curl_setopt_array($curl, array(
  CURLOPT_URL => $bank_url,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_FOLLOWLOCATION  => false,
  CURLOPT_ENCODING => "",
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 30,
  CURLOPT_CUSTOMREQUEST =>"POST",
  CURLOPT_POSTFIELDS => $postData,
  CURLOPT_HTTPHEADER => array(
    "accept: application/json",
    "authorization: Basic $auth",
    "content-type: application/json"
  ),
));

 $response = curl_exec($curl);
$err = curl_error($curl);  
curl_close($curl);

//Convert json to Array
$responseData = json_decode($response,true);

//print_r($responseData);
//exit;

if(isset($_GET['qp'])){
	echo "<br/><hr/><br/>request=>"; print_r($request);
	echo "<br/><hr/><br/>responseData=>"; print_r($responseData);
}
if(isset($_GET['e'])&&$_GET['e']==2){exit;}


$signature = hash("sha256", $responseData["ConfirmationNumber"].$key);


if(isset($request['CardDetails']['CardNumber'])) unset($request['CardDetails']['CardNumber']);
if(isset($request['CardDetails']['CardExpireMonth'])) unset($request['CardDetails']['CardExpireMonth']);
if(isset($request['CardDetails']['CardExpireYear'])) unset($request['CardDetails']['CardExpireYear']);
if(isset($request['CardDetails']['CardSecurityCode'])) unset($request['CardDetails']['CardSecurityCode']);


$tr_upd_order['response']=((isset($responseData)&&is_array($responseData))? htmlTagsInArray($responseData) : stf($response));
$tr_upd_order['ConfirmationNumber']=$responseData["ConfirmationNumber"];
$tr_upd_order['acquirer_ref']=$responseData["ConfirmationNumber"];
//$tr_upd_order['acquirer_ref']='devtech';
$tr_upd_order['url'] = $bank_url;
$tr_upd_order['request']=$request;
$tr_upd_order['auth']=$auth;
$tr_upd_order['signature']=$signature;
$curl_values_arr['responseInfo'] =$tr_upd_order['response'];
$_SESSION['acquirer_action']=1;
trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);

if(isset($responseData['SecurePage'])&&!empty($responseData['SecurePage'])){
  $tr_upd_order['ResponseAC'];
	$tr_upd_order['pay_mode']='3D';
	$auth_3ds2_secure=$responseData['SecurePage'];
	$auth_3ds2_action='redirect';
}
else{ //pending
    
	$_SESSION['acquirer_status_code']=1;
	//$process_url = $trans_processing;
	$json_arr_set['realtime_response_url']=$trans_processing;
}

if($responseDecode['responseCode']=="1001"){ //success
	$_SESSION['acquirer_status_code']=2;
	//$process_url = $return_url; 
	$json_arr_set['realtime_response_url']=$trans_processing;
}elseif($responseDecode['responseCode']=="3020"){	//failed or other
	$_SESSION['acquirer_status_code']=-1;
	//$process_url = $return_url; 
	$json_arr_set['realtime_response_url']=$trans_processing;
	
}
?>
