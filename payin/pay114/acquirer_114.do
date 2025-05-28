<?
//  114 - paymentsolo -  payment solo

// {"token":"5e12cef38728dc61c68bfdf0cf1ed11d","authorization":"8e1fbd6f20ff0cfce4f40671a3bb2396"}

 $postData=[];
 $postData['fullName']=@$post['fullname'];
 $postData['street1']=@$post['bill_address'];
 $postData['invoiceNumber']=$transID;
 $postData['country']=@$post['country_two'];
 $postData['state']=@$post['bill_state'];
 $postData['city']=@$post['bill_city'];
 $postData['email']=@$post['bill_email'];
 $postData['phone']=@$post['bill_phone'];
 $postData['amount']=$total_payment;
 $postData['currency']=$orderCurrency;
 $postData['token']=(isset($apc_get['token'])&&trim($apc_get['token'])?$apc_get['token']:'5e12cef38728dc61c68bfdf0cf1ed11d'); 
 $postData['postal_code']=@$post['bill_zip'];  
 $postData['return_url']=$status_url_1;  
 $postData['status_url']=$webhookhandler_url;  


//print_r($postData); exit;
 
$authorization=(isset($apc_get['authorization'])&&trim($apc_get['authorization'])?$apc_get['authorization']:'8e1fbd6f20ff0cfce4f40671a3bb2396'); 

$user_via_base_url=(isset($apc_get['user'])&&trim($apc_get['user'])?$apc_get['user']:'paymentsolo'); 
$bank_url=$bank_url."/{$user_via_base_url}/process_payment.php";
	
 $curl = curl_init();
  curl_setopt_array($curl, array(
  CURLOPT_URL => $bank_url,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_FOLLOWLOCATION  => false,
  CURLOPT_ENCODING => "",
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
    CURLOPT_HEADER => 0,
    CURLOPT_SSL_VERIFYPEER => 0,
    CURLOPT_SSL_VERIFYHOST => 0,
  CURLOPT_POSTFIELDS => $postData,
  CURLOPT_HTTPHEADER => array(
    'Authorization: Bearer '.$authorization
  ),
));

$response = curl_exec($curl);
$err = curl_error($curl);  
curl_close($curl);


//3d url get from java script
if(strpos($response,"script")!==false){
  $response_script=strip_tags(trim($response));
  $response_script=str_replace('location.href="','',$response_script);
  $response_script=explode('";parent',$response_script)[0];


  $responseData=$auth_3ds2_secure=$response_script;

  if(isset($data['cqp'])&&$data['cqp']>0) echo "<hr/>response_script=><br/>".$response_script;

}
else {
  //Convert json to Array
  $responseData = json_decode($response,true);
}

//print_r($responseData);exit;

if(isset($data['cqp'])&&$data['cqp']>0){
	echo "<br/><hr/><br/>postData=>"; print_r($postData);
	echo "<br/><hr/><br/>responseData=>"; print_r($responseData);

  if($data['cqp']==9) exit;

}

$tr_upd_order['bank_url']=$bank_url;
$tr_upd_order['postData']=$postData;

//$tr_upd_order['responseInfo']=stf($response);

$tr_upd_order['responseInfo']=((isset($responseData)&&is_array($responseData))? htmlTagsInArray($responseData) : @$auth_3ds2_secure);

if(isset($responseData["invoiceNumber"])) $tr_upd_order['acquirer_ref']=$responseData["invoiceNumber"];

//3d url get from s2s array via 3DSUrl
if(isset($responseData["3DSUrl"])) {
    $tr_upd_order['auth']=$auth_3ds2_secure=$responseData["3DSUrl"];
}


/*
$tr_upd_order['responseScript']=$response=base64_encode($response);
			
$auth_3ds2_secure = $response;
$auth_3ds2_base64=1;
*/

$_SESSION['acquirer_action']=1;
//trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);


if(isset($auth_3ds2_secure)&&!empty($auth_3ds2_secure)){
	$tr_upd_order['pay_mode']='3D';
	//$auth_3ds2_secure=$responseData['3DSUrl'];
	$auth_3ds2_action='redirect';
}
else if(isset($responseData['status'])&&@$responseData['status']=='Failed'){
	$_SESSION['acquirer_status_code']=-1;
	//$process_url = $return_url; 
	$json_arr_set['realtime_response_url']=$trans_processing;
}
else{ //pending
    
	$_SESSION['acquirer_status_code']=1;
	//$process_url = $trans_processing;
	$json_arr_set['realtime_response_url']=$trans_processing;
}



$tr_upd_order_111=$tr_upd_order;


?>
