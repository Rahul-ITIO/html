<?php

/// /payin/pay114/hardcode/hardcode_status_114.php

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://www.payit123.com/clients/paymentsolo/get_order_status.php',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'GET',
    CURLOPT_HEADER => 0,
    CURLOPT_SSL_VERIFYPEER => 0,
    CURLOPT_SSL_VERIFYHOST => 0,
  CURLOPT_POSTFIELDS =>'{
    "invoiceNumber": "PS_1141772938"
}',
  CURLOPT_HTTPHEADER => array(
    "accept: application/json",
    'Authorization: Bearer 8e1fbd6f20ff0cfce4f40671a3bb2396',
    'Content-Type: application/json'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;


/*


{"status":"Pending","amount":"2.00","currency":"USD","transactionID":"f7t7pd470ibad315u5ptw44p","invoiceNumber":"PS_1141772938","message":"Payment
Under Progress"}


*/



?>
