<?php

$curl = curl_init();

curl_setopt_array($curl, array(
		CURLOPT_URL => 'https://apis.paytme.com/v1/merchant/payin/6714d64483d3af56fcbd5347',
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => '',
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 0,
		CURLOPT_FOLLOWLOCATION => true,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => 'GET',
		CURLOPT_HTTPHEADER => array(
				'x-api-key: b03104fd5d92036c1f32e48fb57449ca'
		),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;

/*

{
    "data": {
        "status": "failed",
        "settlementStatus": "pending",
        "_id": "6714d64483d3af56fcbd5347",
        "userContactNumber": "1234567890",
        "merchantTransactionId": "8814433100",
        "amount": 1.11,
        "merchantId": "670fdc8ab069f78d27adadf1",
        "createdAt": "2024-10-20T10:07:00.746Z",
        "rrn": ""
    },
    "code": 200,
    "message": "Transaction Details."
}
    
*/
