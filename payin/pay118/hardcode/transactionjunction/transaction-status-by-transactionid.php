<?php

//http://localhost:8080/gw/payin/pay118/hardcode/transactionjunction/transaction-status-by-transactionid.php

$url="https://prod-ipgw-oauth.auth.eu-west-1.amazoncognito.com/oauth2/token";
$client_id="rk5cktg38koapig55pckagdd";
$client_secret="1r63s9aqf6to4tmeq4j229p8ioeqjnq05mcf5tjt7f5of3arvsbl";
$merchantID="f660d8c4-c839-4dac-a05d-7ea2138c5202";
$profileID="44525823-af88-427a-98bb-4f8175edc3b7";
$transactionsID="cce56f6e-bb38-464b-b5be-85c84b3c5b19"; /// Transaction Referance Number //bfd2ed22-2b34-4a0e-8699-ca211d416c3f


///////////////////////Step-1////////////////////////////

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
}else{
echo "Access Token Not Generated";exit;
}

//////////////STEP 2/////////////////

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => "https://pg-api.transactionjunction.com/prod/ipgw/gateway/v1/transactions/".$transactionsID,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'GET',
  CURLOPT_HTTPHEADER => array(
    "Accept: application/json",
		"Authorization: Bearer $access_token",
		"Content-Type: application/json"
  ),
));

$response = curl_exec($curl);
if ($err) {
  echo "cURL Error #:" . $err;
}

curl_close($curl);
	$res = json_decode($response,1);
  
	echo "<code><pre>";
	print_r($res);
  echo "</pre></code>";


if(isset($res['transactionId'])&&$res['transactionId']){

}else{
echo "Transaction Not Found";exit;
}
	
?>

<table width="50%" border="1" cellspacing="4" cellpadding="4" align="center">
  <tr>
    <td colspan="2">Transaction Details</td>
  </tr>
  <tr>
    <td width="50%">transactionId</td>
    <td width="50%"><?=$res['transactionId'];?></td>
  </tr>
  <tr>
    <td>paymentIntentId</td>
    <td><?=$res['paymentIntentId'];?></td>
  </tr>
    <tr>
    <td>merchantRef</td>
    <td><?=$res['merchantRef'];?></td>
  </tr>
  <tr>
    <td>paymentType</td>
    <td><?=$res['paymentType'];?></td>
  </tr>
  <tr>
    <td>amount</td>
    <td><?=$res['amount'];?></td>
  </tr>
  <tr>
    <td>transactionStatus</td>
    <td><?=$res['transactionStatus'];?></td>
  </tr>
  <tr>
    <td>createdAt</td>
    <td><?=$res['createdAt'];?></td>
  </tr>
  <tr>
    <td>lastModified</td>
    <td><?=$res['lastModified'];?></td>
  </tr>
</table>


