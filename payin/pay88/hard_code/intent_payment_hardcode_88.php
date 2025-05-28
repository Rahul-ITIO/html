<?php

$curl = curl_init();

curl_setopt_array($curl, array(
		CURLOPT_URL => 'https://apis.paytme.com/v1/merchant/payin',
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
        "gpayurl": "tez://upi/pay?pa=yuiiecateed321489@ypbiz&pn=f59d23ac19020c989cd8566a4ea16646ad4e02f67516cedc3bd7d833efda516e&tn=Pay to f59d23ac19020c989cd8566a4ea16646ad4e02f67516cedc3bd7d833efda516e&tr=AIRPAY457958259&am=10.00&cu=INR",
        "paytmurl": "paytmmp://upi/pay?pa=yuiiecateed321489@ypbiz&pn=f59d23ac19020c989cd8566a4ea16646ad4e02f67516cedc3bd7d833efda516e&tn=Pay to f59d23ac19020c989cd8566a4ea16646ad4e02f67516cedc3bd7d833efda516e&tr=AIRPAY457958259&am=10.00&cu=INR",
        "phonepeurl": "phonepe://upi/pay?pa=yuiiecateed321489@ypbiz&pn=f59d23ac19020c989cd8566a4ea16646ad4e02f67516cedc3bd7d833efda516e&tn=Pay to f59d23ac19020c989cd8566a4ea16646ad4e02f67516cedc3bd7d833efda516e&tr=AIRPAY457958259&am=10.00&cu=INR",
        "transaction_id": "67137eebc5981e348635d736",
        "upiurl": "upi://pay?pa=yuiiecateed321489@ypbiz&pn=f59d23ac19020c989cd8566a4ea16646ad4e02f67516cedc3bd7d833efda516e&cu=INR&tn=Pay+to+f59d23ac19020c989cd8566a4ea16646ad4e02f67516cedc3bd7d833efda516e&am=10.00&mc=4900&mode=04&tr=AIRPAY457958259",
        "url": "https://pay.indiangame.in",
        "message": "Transaction created."
    },
    "code": 200,
    "message": "Payin information has been successfully created."
}

*/
