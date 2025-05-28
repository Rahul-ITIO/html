<?php

$url = "https://portal.finvert.io/api/test/transaction";
$key = "254|JvQ42xbfGuAQ5wcCOKcHX24hHjpJ7w68nORgMhVG";
// Fill with real customer info

$data = [
    'first_name' => 'Deepti',
    'last_name' => 'Tyagi',
    'address' => '161 Kallang Way,NA',
    'customer_order_id' => '4644513',
    'country' => 'IN',
    'state' => 'Delhi',
    'city' => 'New Delhi',
    'zip' => '110001',
    'ip_address' => '122.161.50.137',
    'email' => 'test1027@test.com',
    'country_code' => '+91',
    'phone_no' => '919830171027',
    'amount'=> '0.02',
    'currency' => 'USD',
    'card_no' => '4000000000003220',
    'ccExpiryMonth' => '10',
    'ccExpiryYear' => '2031',
    'cvvNumber' => '564',
    'response_url' => 'https://localhost/test/finver.php',
    'webhook_url' => 'https://webhook.site/7ecb7b3e-fffb-411a-b075-2f324a6fa0c7'
];

$curl = curl_init();
curl_setopt($curl, CURLOPT_URL, $url);
curl_setopt($curl, CURLOPT_POST, 1);
curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($data));
curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($curl, CURLOPT_HTTPHEADER,[
    'Content-Type: application/json',
    'Authorization: Bearer ' .$key
]);
$response = curl_exec($curl);
curl_close($curl);

$responseData = json_decode($response,1);
print_r($responseData);

?>
