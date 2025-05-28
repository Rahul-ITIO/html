<?php
// http://localhost/gw/payin/pay86/hardcode/refund.php

// 865253
// 94UXNRBDUZ1QI7CHD86J

// POST: https://api.sandbox.openacquiring.com/v1/merchants/vynh3bui63qbx604/payment/94UXNRBDUZ1QI7CHD86J/refund


$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://api.sandbox.openacquiring.com/v1/merchants/vynh3bui63qbx604/payment/94UXNRBDUZ1QI7CHD86J/refund',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>'{
    "amount": "12.00",
    "invoice_number": "865253",
    "custom": {
        "field1": "this is a test"
    }
}',
  CURLOPT_HTTPHEADER => array(
    'Authorization: Basic eWNpMDkyYmtyY2Qya2ZyYjo4aWR2YnU3NzhiOHUweWh6',
    'Content-Type: application/json'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;

/*

{
    "eventId": "d9cdbb57-9ff4-4a21-a739-6d63db512edf",
    "code": "5175",
    "name": "TRANSACTION_NOT_FOUND",
    "message": "Transaction corresponding to the Authorization ID not found."
}

*/


?>