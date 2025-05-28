<?php

// {"ServiceCode":"COGCHE197","ClientCode":"COGMER-5WXOBTC","ConsumerKey":"9nUfLzIwMCmF0kk4zZCOi8MGSWTFC1","ConsumerSecret":"GZJECZKhfAJ0rWtPpKXndvPXQYg2DW","AccessKey":"lcdr1TG6Njqs8q1rBlEqrIWCrjWHSP","IVKey":"5re4WY3wnpnS4kxtn4MimJJBjO4ZYp","v":"2"}


//Step : 1 - auth #############################################

$curl = curl_init();

curl_setopt_array($curl, array(
	CURLOPT_URL => 'https://api.lipad.io/v1/auth',
	CURLOPT_RETURNTRANSFER => true,
	CURLOPT_ENCODING => '',
	CURLOPT_MAXREDIRS => 10,
	CURLOPT_TIMEOUT => 0,
	CURLOPT_FOLLOWLOCATION => true,
	CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	CURLOPT_CUSTOMREQUEST => 'POST',
		CURLOPT_HEADER => 0,
		CURLOPT_SSL_VERIFYPEER => 0,
		CURLOPT_SSL_VERIFYHOST => 0,
	CURLOPT_POSTFIELDS =>'{
    "consumer_key":"9nUfLzIwMCmF0kk4zZCOi8MGSWTFC1",
    "consumer_secret":"GZJECZKhfAJ0rWtPpKXndvPXQYg2DW"
}',
	CURLOPT_HTTPHEADER => array(
		'Content-Type: application/json'
	),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;

/*

{
    "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnRfaWQiOiIyMiIsImRlc2lnbmF0aW9uIjoiQXBpIFVzZXIiLCJhdXRob3JpemVkIjp0cnVlLCJpYXQiOjE3MzY5NDIzNDgsImV4cCI6MTczNjk0ODM0OH0.J3XeYtsC7ARaVMRkgkGbOu5VrAqYbZ9Or7u9DfsGygU",
    "expiresIn": 6000
}

*/

//Step : 2 - Payment Status s2s #############################################


$curl = curl_init();

curl_setopt_array($curl, array(
	CURLOPT_URL => 'https://api.lipad.io/v1/transaction/22406/status',
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
	CURLOPT_HTTPHEADER => array(
		'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnRfaWQiOiIyMiIsImRlc2lnbmF0aW9uIjoiQXBpIFVzZXIiLCJhdXRob3JpemVkIjp0cnVlLCJpYXQiOjE3MzY5NDIzNDgsImV4cCI6MTczNjk0ODM0OH0.J3XeYtsC7ARaVMRkgkGbOu5VrAqYbZ9Or7u9DfsGygU'
	),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;

/*

{
    "event": "payment_status",
    "client_code": "COGMER-5WXOBTC",
    "service_code": "COGCHE197",
        "external_reference": "1121106195306", //transID
    "transaction_id": "2798495",
        "charge_request_id": "22406", //ar = acquirer_ref
    "payment_method_code": "CARD",
        "payer_transaction_id": "12569959787679744", // vpa
            "payment_status": 701, // status
    "country_code": "KEN",
    "currency_code": "USD",
    "receiver_narration": "Secure 3D information is invalid.",
    "payer_msisdn": "9815105821",
    "account_number": "N/A",
    "amount": "12.75",
    "payer_narration": "Payment by 9815105821",
    "extra_data": {
        "failed_redirect_url": "https://aws-cc-uat.web1.one/responseDataList/?urlaction=notify_mastercard",
        "success_redirect_url": "https://aws-cc-uat.web1.one/responseDataList/?urlaction=notify_mastercard"
    },
    "payment_date": "2025-01-15T12:33:43.460Z"
}

*/

 ?>