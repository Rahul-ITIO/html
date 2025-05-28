<?php
//http://localhost:8080/gw/api-test/yoqo/pay.php

$url="https://prod-ipgw-oauth.auth.eu-west-1.amazoncognito.com/oauth2/token";
$client_id="rk5cktg38koapig55pckagdd";
$client_secret="1r63s9aqf6to4tmeq4j229p8ioeqjnq05mcf5tjt7f5of3arvsbl";
$merchantID="f660d8c4-c839-4dac-a05d-7ea2138c5202";
$profileID="44525823-af88-427a-98bb-4f8175edc3b7";
$merchantRef="reference".rand(100001,9999999); /// Auto Generate


$redirectSuccessUrl="https://itio.in/transactionjunction/status.php";
$redirectFailedUrl="https://itio.in/transactionjunction/status.php";
$redirectCancelUrl="https://itio.in/transactionjunction/status.php";

///////////////////////Step-1////////////////////////////

$_POST['amount']=1.00;

if(isset($_POST['amount'])&&$_POST['amount'])
{
 $amount=$_POST['amount'];

$curl = curl_init();

curl_setopt_array($curl, [
  CURLOPT_URL => $url,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => "",
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 30,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => "POST",
  CURLOPT_POSTFIELDS => "grant_type=client_credentials&client_id=$client_id&client_secret=$client_secret",
  CURLOPT_HTTPHEADER => [
    "Accept: application/json",
    "Content-Type: application/x-www-form-urlencoded"
  ],
]);

$response = curl_exec($curl);
$err = curl_error($curl);

curl_close($curl);

if ($err) {
  echo "cURL Error #:" . $err;
} else {
 // echo $response;
}

	$res = json_decode($response,1);
	
	if(isset($res["access_token"])&&$res["access_token"]){
	$access_token=$res["access_token"];
	//$token_type=$res["token_type"];
	//$expires_in=$res["expires_in"];
	
	////////////////STEP-2///////////////////
	$curl = curl_init();

	  curl_setopt_array($curl, [
	  CURLOPT_URL => "https://pg-api.transactionjunction.com/prod/ipgw/gateway/v1/payment-intents",
	  CURLOPT_RETURNTRANSFER => true,
	  CURLOPT_ENCODING => "",
	  CURLOPT_MAXREDIRS => 10,
	  CURLOPT_TIMEOUT => 30,
	  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	  CURLOPT_CUSTOMREQUEST => "POST",
	  CURLOPT_POSTFIELDS => json_encode([
		"paymentIntentId" => "",
		"merchantId" => "$merchantID",
		"profileId" => "$profileID",
		"merchantRef" => "$merchantRef"
	  ]),
	  CURLOPT_HTTPHEADER => [
		"Accept: application/json",
		"Authorization: Bearer $access_token",
		"Content-Type: application/json"
	  ],
	]);
	
	$response = curl_exec($curl);
	$err = curl_error($curl);
	
	curl_close($curl);
	
	if ($err) {
	  echo "cURL Error #:" . $err;
	} 
	
	
		$resintent = json_decode($response,1);
		if(isset($resintent['paymentIntentId'])&&$resintent['paymentIntentId']){
		$paymentIntentId=$resintent['paymentIntentId'];
		$merchantRef=$resintent['merchantRef'];
		
		

				
				$curl = curl_init();

  curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://pg-api.transactionjunction.com/prod/ipgw/gateway/v1/sessions',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>'{
  "redirectSuccessUrl": "'.$redirectSuccessUrl.'",
  "redirectFailedUrl": "'.$redirectFailedUrl.'",
  "redirectCancelUrl": "'.$redirectCancelUrl.'",
  "transaction": {
    "paymentIntentId": "'.$paymentIntentId.'",
    "amount": '.$amount.',
    "currency": "ZMW",
    "cartItems": [
      {
        "quantity": 1,
        "ref": "Game",
        "description": "Online Game",
        "amount": '.$amount.'
      }
      
      
    ],
    "merchantId": "'.$merchantID.'",
    "profileId": "'.$profileID.'",
    "merchantRef": "'.$merchantRef.'"
  }
}',
  CURLOPT_HTTPHEADER => array(
    "Accept: application/json",
					"Authorization: Bearer $access_token",
					"Content-Type: application/json"
  ),
));

$response = curl_exec($curl);

curl_close($curl);
//echo $response;


				$err = curl_error($curl);
				
				curl_close($curl);
				
				if ($err) {
				  echo "cURL Error #:" . $err;
				} else {
				  //echo $response;
				}
				
				
				$datas = json_decode($response,1);
				
				$redirectUrl=$datas['redirectUrl'];
				
				if(isset($redirectUrl)&&$redirectUrl)
				{

					echo "<script>top.window.location.href='{$redirectUrl}';</script>";
					
				}

		}
	}
}


?>