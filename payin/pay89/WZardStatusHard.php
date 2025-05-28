<?php

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://pay.wzrdpay.io/payment-invoices/cgi_1fLwiqTKMitr0rjs',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'GET',
  CURLOPT_HTTPHEADER => array(
    'Authorization: Basic VWo1RXNmR2pKUk9ONmYwNUFMTTpXNXNNMUtCUVFzQlJJcWMxNm9QdXJtcw==',
    'Cookie: INGRESSCOOKIE=1730892110.507.177.249757|a6529a688e7fc19deb713a0f640ab065; machine_identifier=819c06cd-7eda-46c8-a11b-5057bec8fa3a; user_language=en'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;
?>