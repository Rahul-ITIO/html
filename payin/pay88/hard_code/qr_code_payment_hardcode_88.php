<?php

$curl = curl_init();

curl_setopt_array($curl, array(
		CURLOPT_URL => 'https://apis.paytme.com/v1/merchant/payin/scanQR',
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => '',
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 0,
		CURLOPT_FOLLOWLOCATION => true,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => 'POST',
		CURLOPT_POSTFIELDS =>'{
    "userContactNumber":"1234567890",
    "merchantTransactionId":"2980000190",
    "amount":10,
    "name":"xxx",
    "email":"xxx@xxx.com"
}',
		CURLOPT_HTTPHEADER => array(
				'x-api-key: b03104fd5d92036c1f32e48fb57449ca',
				'Content-Type: application/json'
		),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;


/*

{
    "data": {
        "scanQR": "https://merchant.paytme.com/payment-qr-code?pa=11917842@cbin&pn=COB&tn=9cxtjowenq&tr=9cxtjowenq&am=10&cu=INR&mr=Letspe&tid=67137eff73d5b6348d4bf08c&rdul=undefined",
        "upiurl": "upi://pay?pa=11917842@cbin&pn=COB&tn=9cxtjowenq&tr=9cxtjowenq&am=10&cu=INR",
        "transaction_id": "67137eff73d5b6348d4bf08c"
    },
    "code": 200,
    "message": "Payin information has been successfully created."
}

*/
