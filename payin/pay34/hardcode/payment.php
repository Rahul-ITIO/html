<?php
error_reporting(E_ALL); // check all type of errors
ini_set('display_errors', 1); // display those errors
ini_set('log_errors ', 1); // display those errors
ini_set('error_log ', 1); // display those errors

// http://localhost/testPoject/hkp.php

//include('func.php');

//{"live":{"pub_key":"CB1qorYnpLRtf4R","secret_key":"6SLKgJhJ7x1cRWi"}, "test":{"pub_key":"CB1qorYnpLRtf4R","secret_key":"6SLKgJhJ7x1cRWi"}}

$pubKey    	= 'CB1qorYnpLRtf4R';
$secretKeys = '6SLKgJhJ7x1cRWi';
$transrefNo='34'.(new DateTime())->format('ymdHis.u');


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
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $dataRequest);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);

    $result = curl_exec($ch);
    //		$errors = curl_error($ch);
    curl_close($ch);
    return $result;
}

$postRequest=[];
$postRequest['phone']='9355555555';
$postRequest['price']='152.00';
$postRequest['customer_name']='Dev';
$postRequest['last_name']='Tech';
$postRequest['email']='mith1.itio@gmail.com';
$postRequest['bill_street_address']='C-32, Top Office';
$postRequest['bill_city']='Singapore';
$postRequest['bill_postcode']='110092';
$postRequest['bill_country']='SG';
$postRequest['bill_state']='SG';
$postRequest['currency']='USD';
$postRequest['ip_address']='203.136.11.87';
$postRequest['descriptor']='ITIO';
$postRequest['successReturnUrl']="https://webhook.site/258a7052-f628-4df2-b57d-925db04e653f?transID={$transrefNo}&action=successReturnUrl";
$postRequest['failureReturnUrl']="https://webhook.site/258a7052-f628-4df2-b57d-925db04e653f?transID={$transrefNo}&action=failureReturnUrl";
$postRequest['cancelReturnUrl']="https://webhook.site/258a7052-f628-4df2-b57d-925db04e653f?transID={$transrefNo}&action=cancelReturnUrl";


if (isset($postRequest['phone'])) {

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

        'callBackUrl' => 'https://webhook.site/258a7052-f628-4df2-b57d-925db04e653f?action=webhook',
        "successReturnUrl" => $postRequest['successReturnUrl'],
        "failureReturnUrl" =>$postRequest['failureReturnUrl'] ,
        "cancelReturnUrl" => $postRequest['cancelReturnUrl']
    );
    $creation_date = strtotime('now');
    // 	//    echo '<pre>';print_r($dataRequest);die;  
	
	
	
	/*
    $sql = "INSERT INTO orders (price, customer_name,  email, callBackUrl,creation_date)
	VALUES ('" . $dataRequest['price'] . "', '" . $dataRequest['customer_name'] . "', '" . $dataRequest['email'] . "', '" . $dataRequest['callBackUrl'] . "', '" . $creation_date . "')";
    $conn->query($sql);

    $sqll = "SELECT id from orders where email = '" . $dataRequest['email'] . "' and creation_date = '" . $creation_date . "'";

    $result = $conn->query($sqll);

    if ($result->num_rows > 0) {
        // output data of each row

        while ($row = $result->fetch_assoc()) {
            $transrefNo = $row['id'];
        }
    }
	
	*/

    $url = "https://henkerrpay.net/api/index";

    $headers = array(
        'Authorizations: ' . $pubKey,
    );


    $dataRequests = array(
        'username' => $pubKey, 'password' => $secretKeys,
        'api_key' => $pubKey,
        'login_passcode' => $secretKeys
    );
    $secretKey = getapi_responce($dataRequests, $headers, $url);

    $url = "https://henkerrpay.net/api/gpg";


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
	
	print_r($dataRequest);exit;

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

    //	echo '<pre>';print_r($errors);
    //	echo '<pre>';print_r($dataRequest);die;
    echo json_encode($responces);
    //$conn->close();
	
	/*
	
	Array ( [status] => 100 [data] => Array ( [order_id] => HP240301090500469878 [merch_order_id] => 28240301143522.706020 [code] => _3DSVERIFICATION [authenticationUrl] => https://henkerrpay.online/api/dsreply/HP240301090500469878/28240301143522.706020 [amount] => 152.00 [currency] => USD [transactionStatus] => trn_c7u4ugr5n2 [transactionreference] => 28240301143522.706020 ) [message] => Success ) 
	
	*/
}

?>