<?php
if(!isset($_SESSION['adm_login'])){
	echo('ACCESS DENIED.');
	exit;
}

$merchant_id=@$apc_get['merchant_id'];
$api_password_key=@$apc_get['api_password_key'];

##################################################################################
		
			
			
		// Initialize a access token
		
				
		$token_url="https://prod-ipgw-oauth.auth.eu-west-1.amazoncognito.com/oauth2/token";
		
		$client_id=@$apc_get['client_id'];//"rk5cktg38koapig55pckagdd";
		$client_secret=@$apc_get['client_secret'];//"1r63s9aqf6to4tmeq4j229p8ioeqjnq05mcf5tjt7f5of3arvsbl";
		$merchantID=@$apc_get['merchantID'];//"f660d8c4-c839-4dac-a05d-7ea2138c5202";
		$profileID=@$apc_get['profileID'];//"44525823-af88-427a-98bb-4f8175edc3b7";
		$merchantRef=$transID; /// Transaction Referance Number

      
    $transactionsID= @$acquirer_ref; //"cce56f6e-bb38-464b-b5be-85c84b3c5b19"; /// Transaction ID
    $amount=@$paramsInfo['refundAmount'];
    $currencyCode=@$paramsInfo['refundCurrency'];
    //$currencyCode="ZAR";


		if(isset($_REQUEST['hc']))
		{
			$client_id="rk5cktg38koapig55pckagdd";
			$client_secret="1r63s9aqf6to4tmeq4j229p8ioeqjnq05mcf5tjt7f5of3arvsbl";
			$merchantID="f660d8c4-c839-4dac-a05d-7ea2138c5202";
			$profileID="44525823-af88-427a-98bb-4f8175edc3b7";
			$merchantRef="Visa_test"; /// Transaction Referance Number
		}

		///////////////////////Step-1////////////////////////////

		$curl = curl_init();

		curl_setopt_array($curl, [
		CURLOPT_URL => $token_url,
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => "",
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 30,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => "POST",
			CURLOPT_HEADER => 0,
			CURLOPT_SSL_VERIFYPEER => 0,
			CURLOPT_SSL_VERIFYHOST => 0,
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
			
		if(isset($res["access_token"])&&$res["access_token"])
		{
			$access_token=$res["access_token"];
		}else{
			echo "Access Token Not Generated";
			//exit;
		}


		//////////////STEP 2 :: Get Transaction details from Merchant Reference:  /////////////////

//echo "<hr/>acquirer_refund_url1=>".$acquirer_refund_url;

if(empty($acquirer_refund_url)||$acquirer_refund_url=='NA'){
	$acquirer_refund_url="https://ap-gateway.mastercard.com/api/rest/version/78/merchant";
}


if(empty($acquirer_ref)) echo "<br/><b>Acquirer Ref not found</b><br/>".$acquirer_ref;




//if(!isset($_GET['rtest']))
{
	echo "<hr/>acquirer_refund_url=>".$acquirer_refund_url;
}


#########################################################

############################################################


$postreqStr='{
  "merchantId": "'.$merchantID.'",
  "profileId": "'.$profileID.'",
   "transactionId": "'.$transactionsID.'",
   "amount": '.$amount.',
   "currencyCode": "'.$currencyCode.'"
}';

if($data['cqp']>0||isset($_GET['rtest'])||isset($_GET['dtest'])) 
echo "<hr/><b>postreqStr=></b><br/>".$postreqStr;
//exit;


$curl = curl_init();
curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://pg-api.transactionjunction.com/prod/ipgw/cnp/v1/online/refund',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
    CURLOPT_HEADER => 0,
    CURLOPT_SSL_VERIFYPEER => 0,
    CURLOPT_SSL_VERIFYHOST => 0,

  CURLOPT_POSTFIELDS =>@$postreqStr,
  CURLOPT_HTTPHEADER => array(
    "Accept: application/json",
	"Authorization: Bearer $access_token",
	"Content-Type: application/json"
  ),
));

$response = curl_exec($curl);

curl_close($curl);


#########################################################

$result=json_decode($response, TRUE);

$gatewayCode=@$result['transactionId'];

#########################################################

	//if(!isset($_GET['rtest']))
	{
		echo "<hr/><br/>transactionId=>";print_r(@$gatewayCode);
		echo "<hr/><br/>result=>";print_r($result);
	}
	
	
	if((!empty($result['transactionId']))){
		$post_reply="Refund Successful";
		$live_refund_status='Y';
	}
	else $live_refund_status='N';
	
	
  

?>