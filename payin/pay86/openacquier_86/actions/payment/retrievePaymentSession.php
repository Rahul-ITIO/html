<?php
$paymentSessionId = $_GET['payment-session-id'];

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://api.sandbox.openacquiring.com/v1/merchants/vynh3bui63qbx604/payment/session/'.$paymentSessionId,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'GET',
  CURLOPT_SSL_VERIFYPEER => 0,
  CURLOPT_SSL_VERIFYHOST=> 0,
  CURLOPT_HTTPHEADER => array(
    'Authorization: Basic eWNpMDkyYmtyY2Qya2ZyYjo4aWR2YnU3NzhiOHUweWh6'
  ),
));

$curlResponse = curl_exec($curl);

curl_close($curl);

$response = json_decode($curlResponse);

echo '<pre>';
print_r($response);