<?

$url = $bank_url;
$key = $apc_get['apiKey'];
// Fill with real customer info

//explode($fullname)
  
$post['isd_code']=get_country_code($post['country_two'],4);
 
//exit;
$dataRequest = [
    'first_name' => @$post['ccholder'],
    'last_name' => @$post['ccholder_lname'],
    'address' => $post['bill_address'],
    'customer_order_id' => $transID,
    'country' => $post['country_two'], //$post['bill_country']
    'state' => $post['bill_state'],
    'city' => $post['bill_city'],
    'zip' => $post['bill_zip'],
    'ip_address' => $_SESSION['bill_ip'],
    'email' => $post['bill_email'],
    'country_code' => '+'.$post['isd_code'],
    'phone_no' => $post['bill_phone'],
    'amount'=> $total_payment,
    'currency' =>$orderCurrency,
    'card_no' => $post['ccno'],
    'ccExpiryMonth' => $post['month'],
    'ccExpiryYear' => $post['year4'],
    'cvvNumber' => $post['ccvv'],
    'response_url' => $status_url_1,
    'webhook_url' => $webhookhandler_url
];


//unset card deatils
$request_post_data=@$dataRequest;
unset($request_post_data['card_no']);
unset($request_post_data['cvvNumber']);
unset($request_post_data['ccExpiryMonth']);
unset($request_post_data['ccExpiryYear']);

//update request and response
$tr_upd_order['request_post']=@$request_post_data;
trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);

$tr_upd_order=array();
if($data['localhosts']==true)
{	
	$response ='{"responseCode":"7","responseMessage":"3DS link generated successful, please redirect.","3dsUrl":"https://core.arcapg.com/arca-mp/api/v2/inith?mtx=ARCEMB07241253961698485606662","data":{"transaction":{"order_id":"ODRMFJQ1698485554G7LRI0","customer_order_id":"46348124","amount":"22.00","currency":"USD"},"client":{"first_name":"Test","last_name":"Full Name","email":"test5821@dev.com","phone_no":"9828145821","address":"161 Kallang Way","zip":"110001","city":"New Delhi","state":"Delhi","country":"IN"},"card":{"card_no":"4047457514066090","ccExpiryMonth":"06","ccExpiryYear":"2026","cvvNumber":"152"}}}';
}
else
{
	
	$curl = curl_init();
	curl_setopt($curl, CURLOPT_URL, $url);
	curl_setopt($curl, CURLOPT_POST, 1);
	curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($dataRequest));
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($curl, CURLOPT_HTTPHEADER,[
		'Content-Type: application/json',
		'Authorization: Bearer ' .$key
	]);
	$response = curl_exec($curl);
	//echo $response;

	curl_close($curl);


}


$responseDecode = json_decode($response,1);
//print_r($responseDecode);
//their order_id will fetch refund from this id so its mandatory to store in db
 $txn_id=$responseDecode['data']['transaction']['order_id'];
 

if(isset($responseDecode['data']['card'])) 
	unset($responseDecode['data']['card']);

//update response
$tr_upd_order['response']  = ((isset($responseDecode)&&is_array($responseDecode))? htmlTagsInArray($responseDecode) : stf($response));
$tr_upd_order['acquirer_ref']   = $txn_id;
trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);
//$tr_upd_order['ResponseAC'] ="test code";
//rans_updatesf($_SESSION['tr_newid'], $tr_upd_data);
//$curl_vatrans_updatesf($_SESSION['tr_newid'], $tr_upd_order);

//$curl_values_arr['responseInfo'] =$tr_upd_order['response']; $_SESSION['curl_values']=$curl_values_arr;

$_SESSION['acquirer_action']=1;

$curl_values_arr['browserOsInfo']=$browserOs;




if(isset($responseDecode['responseCode']) && $responseDecode['responseCode']=="6")
{
	echo 'Error for '.$responseDecode['responseMessage'];exit; 
	//echo $response;  	
}
elseif(isset($responseDecode['3dsUrl'])&&!empty($responseDecode['3dsUrl']))
{ //3D redirect
	//$tr_upd_order['ResponseAC'];
	$tr_upd_order['pay_mode']='3D';
	$auth_3ds2_secure=$responseDecode['3dsUrl'];
	$auth_3ds2_action='redirect';
}
else{ //pending
    
	$_SESSION['acquirer_status_code']=1;
	//$process_url = $trans_processing;
	$json_arr_set['realtime_response_url']=$trans_processing;
}	


if($responseDecode['responseCode']=="1"){ //success
	$_SESSION['acquirer_status_code']=2;
	//$process_url = $return_url; 
	$json_arr_set['realtime_response_url']=$trans_processing;
}elseif($responseDecode['responseCode']=="0"){	//failed or other
	$_SESSION['acquirer_status_code']=-1;
	//$process_url = $return_url; 
	$json_arr_set['realtime_response_url']=$trans_processing;
	echo 'Error for '.$responseDecode['responseMessage'];
	exit; 
	
}

/*
if(isset($responseDecode['3dsUrl'])&&!empty($responseDecode['3dsUrl'])){
        $tr_upd_order['pay_mode']='3D';
        $auth_3ds2_secure=$responseDecode['3dsUrl'];
        $auth_3ds2_action='redirect';
}
if(isset($responseDecode['3dsUrl'])&&!empty($responseDecode['3dsUrl'])){
        $tr_upd_order['pay_mode']='3D';
        $auth_3ds2_secure=$responseDecode['3dsUrl'];
        $auth_3ds2_action='redirect';
}
else{ //pending
    
	$_SESSION['acquirer_status_code']=1;
	//$process_url = $trans_processing;
	$json_arr_set['realtime_response_url']=$trans_processing;
}	

*/
?>
