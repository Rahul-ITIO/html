<?php

// http://localhost:8080/gw/payin/pay117/hardcode/payment_117_hardcode.php



$curl = curl_init();

curl_setopt_array($curl, array(
		CURLOPT_URL => 'https://api.pay.agency/v1/test/transaction',
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => '',
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 0,
		CURLOPT_FOLLOWLOCATION => true,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => 'POST',
		CURLOPT_POSTFIELDS =>'{
    "first_name": "First Name",
    "last_name": "Last Name",
    "address": "Address",
    "customer_order_id": "ORDER-123457112",
    "country": "US",
    "state": "NY",
    "city": "New York",
    "zip": "38564",
    "ip_address": "122.176.92.114",
    "email": "test@gmail.com",
    "country_code": "+91",
    "phone_no": "999999999",
    "amount": "10.00",
    "currency": "USD",
    "card_no": "4263982640269299",
    "ccExpiryMonth": "02",
    "ccExpiryYear": "2026",
    "cvvNumber": "123",
    "response_url": "https://www.google.com/"
}',
		CURLOPT_HTTPHEADER => array(
				'Content-Type: application/json',
				'Accept: application/json',
				'Authorization: Bearer 29a993a8-ab75-426c-985d-eb8a9f886c13',
				'Cookie: AWSALB=pVOEhLbB8RRLcBbTzBzXyRAGJ8lY9AlPgGFU1cy1uT3Jgj6IYzK3eMNM7DAM9es/E2z/KdOiUVeAh3ofmKycyg1KlX04VCFhorZeLzy7YABSMiRxQne66nkobsLW; AWSALBCORS=pVOEhLbB8RRLcBbTzBzXyRAGJ8lY9AlPgGFU1cy1uT3Jgj6IYzK3eMNM7DAM9es/E2z/KdOiUVeAh3ofmKycyg1KlX04VCFhorZeLzy7YABSMiRxQne66nkobsLW'
		),
));

$response = curl_exec($curl);

curl_close($curl);


echo "<br/><hr/><br/><h3>Step 3: Capture the Payment</h3><br/>response=><br/>";
print_r($response);


/*

{
    "status": 300,
    "message": "redirected",
    "auth_url": "https://api.pay.agency/v1/test/transaction/form/eyJpdiI6IlI1Qkk2bHVTaTdkZ3FoYmhHbU53NEE9PSIsInZhbHVlIjoiNTBKeXE3bjVUZ003d0F3UkJYMlR0OU0wK2NVT0hVK3cyREkraUtvTUFDQmlhRXhiZTRZTnFFWjhCTHVGVEdVNSIsIm1hYyI6ImVhMDRjYWM3NzE5ZmY2MGQ5Mzk5YTg1Yjk1NDQyNzk1ZGRkOWYxMjFhNWIyMDkzNmIxOWQ2MmNlYjc2OTJkMWMiLCJ0YWciOiIifQ==",
    "transaction": {
        "order_id": null,
        "transaction_id": "T251732530750PDMK4",
        "terminal_id": null,
        "customer": {
            "first_name": "First Name",
            "last_name": "Last Name",
            "email": "test@gmail.com",
            "phone_number": null
        },
        "billing": {
            "zip": "38564",
            "address": "Address",
            "city": "New York",
            "state": "NY",
            "country": "US"
        },
        "payment_details": [],
        "order": {
            "amount": "10.00",
            "currency": "USD"
        },
        "device": {
            "ip_address": "122.176.92.114"
        },
        "result": {
            "status": "redirected",
            "message": "Additional details required."
        },
        "refund": {
            "status": false,
            "refund_reason": null,
            "refunded_on": null
        },
        "chargebacks": {
            "status": false,
            "chargebacked_on": null
        },
        "flagged": {
            "status": false,
            "flagged_on": null
        }
    }
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
    "status": 300,
    "message": "redirected",
    "auth_url": "https://api.pay.agency/v1/test/transaction/form/eyJpdiI6IlI1Qkk2bHVTaTdkZ3FoYmhHbU53NEE9PSIsInZhbHVlIjoiNTBKeXE3bjVUZ003d0F3UkJYMlR0OU0wK2NVT0hVK3cyREkraUtvTUFDQmlhRXhiZTRZTnFFWjhCTHVGVEdVNSIsIm1hYyI6ImVhMDRjYWM3NzE5ZmY2MGQ5Mzk5YTg1Yjk1NDQyNzk1ZGRkOWYxMjFhNWIyMDkzNmIxOWQ2MmNlYjc2OTJkMWMiLCJ0YWciOiIifQ==",
    "transaction": {
        "order_id": null,
        "transaction_id": "T251732530750PDMK4",
        "terminal_id": null,
        "customer": {
            "first_name": "First Name",
            "last_name": "Last Name",
            "email": "test@gmail.com",
            "phone_number": null
        },
        "billing": {
            "zip": "38564",
            "address": "Address",
            "city": "New York",
            "state": "NY",
            "country": "US"
        },
        "payment_details": [],
        "order": {
            "amount": "10.00",
            "currency": "USD"
        },
        "device": {
            "ip_address": "122.176.92.114"
        },
        "result": {
            "status": "redirected",
            "message": "Additional details required."
        },
        "refund": {
            "status": false,
            "refund_reason": null,
            "refunded_on": null
        },
        "chargebacks": {
            "status": false,
            "chargebacked_on": null
        },
        "flagged": {
            "status": false,
            "flagged_on": null
        }
    }
}


*/




?>
