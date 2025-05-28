<?php

//control will send from here

  $postreq['login'] = "CogentPayments_LP";
$postreq['client_orderid'] = "902B4FF56";
$postreq['orderid'] = "1968523";
$postreq['amount_in_cents'] = "1042";
$postreq['currency'] = "EUR";
$postreq['merchant_control']="1B962E87-86C5-4863-90B2-FB58D8721717";
  
  $str = $postreq['login'].''.$postreq['client_orderid'].''.$postreq['orderid'].''.$postreq['amount_in_cents'].''.$postreq['currency'].''.$postreq['merchant_control'];

echo  $checksum = sha1($str);
$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://sandbox.lonapay24.com/payment/api/v2/return/2545',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS => 'login=&orderid=1968523&client_orderid=902B4FF56&amount=10.42&currency=EUR&control=cd64e1938d79c4c63ce76c04e062094764bb78f0&comment=want%20to%20return%20my%20refund%20please%20refund%20it',
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/x-www-form-urlencoded',
    'Authorization: Bearer bOpEE0OQAEjobPfVvyGGVfTICAx6'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;
