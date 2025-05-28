<?php
if($data['cqp']>0){
	error_reporting(E_ALL); // check all type of errors
	ini_set('display_errors', 1); // display those errors
	ini_set('log_errors ', 1); // display those errors
	ini_set('error_log ', 1); // display those errors
}


//{"live":{"pub_key":"CB1qorYnpLRtf4R","secret_key":"6SLKgJhJ7x1cRWi"}, "test":{"pub_key":"CB1qorYnpLRtf4R","secret_key":"6SLKgJhJ7x1cRWi"}}


$base_url = $bank_url; // base url 

$pubKey    	= $apc_get['pub_key']; //'CB1qorYnpLRtf4R';
$secretKeys = $apc_get['secret_key']; //'6SLKgJhJ7x1cRWi';
$transrefNo = $transID;

function HashSha512($transactionRef, $secretKey)
{
    $prefix = substr($secretKey, 0, 5) === "test_" ? "test_scrk_" : "scrk_";
    $key = str_replace($prefix, "", $secretKey);
    return hash('sha512', $transactionRef . $key);
}
function getapi_responce($dataRequest, $header, $url)
{
 
		 
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
    curl_setopt($ch, CURLOPT_TIMEOUT, 30);
    curl_setopt($ch, CURLOPT_MAXREDIRS, 10);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $dataRequest);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);

    $result = curl_exec($ch);
    //		$errors = curl_error($ch);
    curl_close($ch);
    return $result;
}


$postRequest=[];
$postRequest['phone']= @$post['bill_phone'];
$postRequest['price']= $total_payment;
$postRequest['customer_name']= @$post['ccholder'];
$postRequest['last_name']= @$post['ccholder_lname'];
$postRequest['email']= @$post['bill_email'];
$postRequest['bill_street_address']= @$post['bill_address'];
$postRequest['bill_city']= @$post['bill_city'];
$postRequest['bill_postcode']= @$post['bill_zip'];
$postRequest['bill_country']= @$post['country_two'];
$postRequest['bill_state']= @$post['bill_state'];
$postRequest['currency']= @$orderCurrency;
$postRequest['ip_address']= @$_SESSION['bill_ip'];
$postRequest['descriptor']= @$_SESSION['acquirer_descriptor'];
$postRequest['successReturnUrl']= @$status_url_1."&action=successReturnUrl";
$postRequest['failureReturnUrl']= @$status_url_1."&action=failureReturnUrl";
$postRequest['cancelReturnUrl']= @$status_url_1."&action=cancelReturnUrl";


//if (isset($postRequest['phone'])) 
{

    $dataRequest = array(
        'price' => $postRequest['price'],
        'customer_name' => strip_tags($postRequest['customer_name']),
        'last_name' => strip_tags($postRequest['last_name']),
        'email' => strip_tags($postRequest['email']),
        'phone' => strip_tags($postRequest['phone']),
        'bill_street_address' => strip_tags($postRequest['bill_street_address']),
        'bill_city' => strip_tags($postRequest['bill_city']),
        'bill_postcode' => strip_tags($postRequest['bill_postcode']),
        'bill_country' => strip_tags($postRequest['bill_country']),
        'bill_state' => strip_tags($postRequest['bill_state']),
        'currency' => strip_tags($postRequest['currency']),
        'ip_address' => strip_tags($postRequest['ip_address']),
        'descriptor' => strip_tags($postRequest['descriptor']),

        'callBackUrl' => $webhookhandler_url,
        "successReturnUrl" => $postRequest['successReturnUrl'],
        "failureReturnUrl" =>$postRequest['failureReturnUrl'] ,
        "cancelReturnUrl" => $postRequest['cancelReturnUrl']
    );
    $creation_date = strtotime('now');
	
	$tr_upd_order['postRequest']   = $postRequest;
	
	if($data['cqp']>0){
		echo '<pre>';print_r($dataRequest);
	}
	
	

    $url = $base_url."/index";

    $headers = array(
        'Authorizations: ' . $pubKey,
    );


    $dataRequests = array(
        'username' => $pubKey, 'password' => $secretKeys,
        'api_key' => $pubKey,
        'login_passcode' => $secretKeys
    );
    $secretKey = getapi_responce($dataRequests, $headers, $url);

	if($data['cqp']>0){
		echo "<br/><br/>url 1 =>".$url;
		echo "<br/>responce secretKey =>".$secretKey;
	}
	

   $url = $base_url."/gpg";


    $headers = array(
        'Authorizations: ' . $pubKey,
        'TransactionRef: ' . $transrefNo,
        'Signature: ' . HashSha512($transrefNo, $secretKey),
    );


    $dataRequests = array(
        'encryptedData' => base64_encode(json_encode($dataRequest)),
        'api_key' => $pubKey,
        'secretKey' => $secretKey,
        'login_passcode' => $secretKeys
    );
    $result = getapi_responce($dataRequests, $headers, $url);


    $responces = array();
    $ress = array(
        "index" => $secretKey,
        "payment" => $result,
        //		"status" => $status,
    );

    $dataRequest = json_decode($result, true);
	
	
	//update response
	$tr_upd_order['response_1']  = ((isset($dataRequest)&&is_array($dataRequest))? htmlTagsInArray($dataRequest) : stf($result));
	$tr_upd_order['acquirer_ref']   = @$dataRequest['data']['order_id'];
	
	if($data['cqp']>0){
		echo "<br/><br/>url 2 =>".$url.'<br/>';
		echo '<pre>';print_r($dataRequest);
	}
	
	if($data['cqp']==9){
		trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);
		die;  exit;
	}


    // handeling responce
    if ($dataRequest['status'] == 100) {
        if ($dataRequest['data']['code'] == '_3DSVERIFICATION') {
            $responces['url'] = $dataRequest['data']['authenticationUrl'];
            $responces['code'] = 'url';
            $responces['txn_no'] = $transrefNo;
            $responces['bankResponce'] = $dataRequest['data']['authenticationUrl'];

            $responces['data']['amount'] = $dataRequest['data']['amount'];
            $responces['data']['currency'] = $dataRequest['data']['currency'];
        } elseif ($dataRequest['data']['code'] == 'SUCCESSFUL') {
            $responces['code'] = 'success';
            $responces['txn_no'] = $transrefNo;
        } elseif ($dataRequest['data']['code'] == 'FAILED') {
            $responces['gatewayResponseMessage'] = '';
            $responces['code'] = 'failed';
            $responces['txn_no'] = $transrefNo;
        } else {
            $responces['gatewayResponseMessage'] = '';
            $responces['code'] =  'pending';
            $responces['txn_no'] = $transrefNo;
        }
    }


	if($data['cqp']>0){
		echo "<br/><br/>responces=>".$url.'<br/>';
		echo json_encode($responces);
		echo "<br/><br/>";
	}
   
   
   if(isset($responseDecode['responseCode']) && $responseDecode['responseCode']=="6")
	{
		echo 'Error for '.$responseDecode['responseMessage'];exit; 
		//echo $response;  	
	}
	elseif(isset($responces['url'])&&!empty($responces['url']))
	{ //3D redirect
		//$tr_upd_order['ResponseAC'];
		$tr_upd_order['pay_mode']='3D';
		$auth_3ds2_secure=$responces['url'];
		$auth_3ds2_action='redirect';
	}
	else{ //pending
    
		$_SESSION['acquirer_status_code']=1;
		//$process_url = $trans_processing;
		$json_arr_set['realtime_response_url']=$trans_processing;
	}	
	
	$tr_upd_order['response_2']   = $responces;
	trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);
	
	
	/*
	
	Array ( [status] => 100 [data] => Array ( [order_id] => HP240301090500469878 [merch_order_id] => 28240301143522.706020 [code] => _3DSVERIFICATION [authenticationUrl] => https://henkerrpay.online/api/dsreply/HP240301090500469878/28240301143522.706020 [amount] => 152.00 [currency] => USD [transactionStatus] => trn_c7u4ugr5n2 [transactionreference] => 28240301143522.706020 ) [message] => Success ) 
	
	*/
}

?>

