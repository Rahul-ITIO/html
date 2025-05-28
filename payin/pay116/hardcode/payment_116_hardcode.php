<?php

// http://localhost:8080/gw/payin/pay116/hardcode/payment_116_hardcode.php


$curl = curl_init();

curl_setopt_array($curl, array(
	CURLOPT_URL => 'https://api.paysaddle.com/api/v2/checkout?merchantId=MID635fcda6321d5&name=DEV%20TECH&email=temidoswag%40gmail.com&amount=2&currency=NGN&orderId=NPT6YZARVB1399366045637577',
	CURLOPT_RETURNTRANSFER => true,
	CURLOPT_ENCODING => '',
	CURLOPT_MAXREDIRS => 10,
	CURLOPT_TIMEOUT => 0,
	CURLOPT_FOLLOWLOCATION => true,
	CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	CURLOPT_CUSTOMREQUEST => 'GET',
));

$response = curl_exec($curl);

curl_close($curl);

echo "<br/><hr/><br/><h3>Step 3: Capture the Payment</h3><br/>response=><br/>";
print_r($response);


/*

{
    "amount": "2",
    "customerId": "Cus_6522eb7f234c0",
    "merchantId": "MID635fcda6321d5",
    "domain": "LIVE",
    "status": "ok",
    "transId": "NP24112510314640049"
}

*/



// Step 2 for Pay


/*
{
    "clientData":"TlAyNDA5MTAxNTI0MjY4NjgxNzpMSVZFOjUzOTk4MzQ3MjYzMDY2MzI6MTEvMjQ6NDcxOjpOR046UVI=",
    "type":"PAY" 
}

TlAyNDA5MTAxNTEyMjY4MzU5MzpMSVZFOjUzOTk4MzQ3KioqKjY2MzI6MDkvMjQ6NDcyOjpVU0Q=

NP24091015122683593:LIVE:53998347****6632:09/24:472::USD



transId:LIVE:cardPan:card expiry:cvv::currency

NP24112509473873471:LIVE:5129320105220468:02/28:549::INR

TlAyNDExMjUwOTMyNTIxMjExNzpMSVZFOjUxMjkzMjAxMDUyMjA0Njg6MDIvMjg6NTQ5OjpVU0Q=


NP24112509220499027:LIVE:5129320105220468:02/28:149::USD

TlAyNDExMjUwOTIyMDQ5OTAyNzpMSVZFOjUxMjkzMjAxMDUyMjA0Njg6MDIvMjg6MTQ5OjpVU0Q=


*/


$curl = curl_init();

curl_setopt_array($curl, array(
	CURLOPT_URL => 'https://api.paysaddle.com/api/v2/pay',
	CURLOPT_RETURNTRANSFER => true,
	CURLOPT_ENCODING => '',
	CURLOPT_MAXREDIRS => 10,
	CURLOPT_TIMEOUT => 0,
	CURLOPT_FOLLOWLOCATION => true,
	CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	CURLOPT_CUSTOMREQUEST => 'POST',
	CURLOPT_POSTFIELDS =>'{
    "clientData":"TlAyNDExMjUwOTQ3Mzg3MzQ3MTpMSVZFOjUxMjkzMjAxMDUyMjA0Njg6MDIvMjg6NTQ5OjpJTlI=",
    "type":"PAY" 
}',
	CURLOPT_HTTPHEADER => array(
		'Content-Type: application/json'
	),
));

$response = curl_exec($curl);

curl_close($curl);


echo "<br/><hr/><br/><h3>Step 3: Capture the Payment</h3><br/>response=><br/>";
print_r($response);

/*

{
    "code": "S0",
    "status": "3DS Required",
    "result": "NPPSEC2409111023407",
    "orderId": "NPT6YZARVB13993660456381",
    "amount": "1",
    "provider": "MPGS",
    "MD": "",
    "ACSUrl": "https://secure-acs2ui-b1-indblr-blrtdc.wibmo.com/v1/acs/services/browser/creq/L/8528/75341e0b-7027-11ef-b667-45e8ee180ee9",
    "PaReq": "eyJ0aHJlZURTU2VydmVyVHJhbnNJRCI6ImFkM2U3MDVjLTJiM2UtNDY4NS1iN2UzLTY2NTQxYWFlMzFkYyIsImFjc1RyYW5zSUQiOiI3NTM0MWUwYi03MDI3LTExZWYtYjY2Ny00NWU4ZWUxODBlZTkiLCJjaGFsbGVuZ2VXaW5kb3dTaXplIjoiMDUiLCJtZXNzYWdlVHlwZSI6IkNSZXEiLCJtZXNzYWdlVmVyc2lvbiI6IjIuMi4wIn0",
    "eciFlag": "N/P",
    "TermUrl": "https://api.paysaddle.com/api/v2/validateMPGS3D/TlAyNDA5MTExMDE4MzI5ODYyOTpMSVZFOjUzOTk4MzQ3MjYzMDY2MzI6MTEvMjQ6NDcxOjpVU0Q=/NPPSEC2409111023407",
    "transId": "NP24091110183298629",
    "redirectHtml": "<div id=\"threedsChallengeRedirect\" xmlns=\"http://www.w3.org/1999/html\" style=\" height: 100vh\"> <form id =\"threedsChallengeRedirectForm\" method=\"POST\" action=\"https://secure-acs2ui-b1-indblr-blrtdc.wibmo.com/v1/acs/services/browser/creq/L/8528/75341e0b-7027-11ef-b667-45e8ee180ee9\" target=\"challengeFrame\"> <input type=\"hidden\" name=\"creq\" value=\"eyJ0aHJlZURTU2VydmVyVHJhbnNJRCI6ImFkM2U3MDVjLTJiM2UtNDY4NS1iN2UzLTY2NTQxYWFlMzFkYyIsImFjc1RyYW5zSUQiOiI3NTM0MWUwYi03MDI3LTExZWYtYjY2Ny00NWU4ZWUxODBlZTkiLCJjaGFsbGVuZ2VXaW5kb3dTaXplIjoiMDUiLCJtZXNzYWdlVHlwZSI6IkNSZXEiLCJtZXNzYWdlVmVyc2lvbiI6IjIuMi4wIn0\" /> </form> <iframe id=\"challengeFrame\" name=\"challengeFrame\" width=\"100%\" height=\"100%\" ></iframe> <script id=\"authenticate-payer-script\"> var e=document.getElementById(\"threedsChallengeRedirectForm\"); if (e) { e.submit(); if (e.parentNode !== null) { e.parentNode.removeChild(e); } } </script> </div>"
}

*/




//LIVE CARD 64  https://www.base64encode.org/
//NP24120509224811672:LIVE:4147673003870003:03/29:383::USD

?>
