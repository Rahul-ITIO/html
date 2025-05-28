<?php
$url = "https://portal.finvert.io/api/refund";
$key = "254|JvQ42xbfGuAQ5wcCOKcHX24hHjpJ7w68nORgMhVG";
$data = [
    
    'customer_order_id' => 'ORDER-1234567',
    'api_key'  =>$key
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
