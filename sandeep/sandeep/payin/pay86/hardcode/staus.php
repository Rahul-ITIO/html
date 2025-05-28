<?php
// http://localhost/gw/payin/pay86/hardcode/staus.php

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://api.sandbox.openacquiring.com/v1/merchants/vynh3bui63qbx604/payment/94UXNRBDUZ1QI7CHD86J',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'GET',
  CURLOPT_HTTPHEADER => array(
    'Authorization: Basic eWNpMDkyYmtyY2Qya2ZyYjo4aWR2YnU3NzhiOHUweWh6'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;

/*

{
    "id": "94UXNRBDUZ1QI7CHD86J",
    "reference_id": "94UXNRBDUZ1QI7CHD86J",
    "state": "declined",
    "result": {
        "code": "5051",
        "message": "Invalid request"
    },
    "intent": "Sale",
    "payer": {
        "payment_type": "CC",
        "funding_instrument": {
            "credit_card": {
                "id": "20e8926a-7ac3-419c-9cf4-e730183a0ff6",
                "type": "Visa",
                "expire_month": 6,
                "expire_year": 2025,
                "name": "Test Full Name",
                "last4": "9996",
                "bin": "454347"
            }
        },
        "payer_info": {
            "id": "6e3ff778-9769-4a0e-b46e-d89f1133b68f",
            "email": "test5540@test.com",
            "ip": "",
            "name": "Test Full Name",
            "billing_address": {
                "phone": {
                    "country_code": "230",
                    "number": "57976041"
                },
                "line1": "18 Avenue cassidy",
                "city": "Rose-Hill",
                "country_code": "MU",
                "postal_code": "72101",
                "state": ""
            }
        }
    },
    "transaction": {
        "amount": {
            "currency": "USD",
            "total": "12"
        },
        "type": "1",
        "mode": "1",
        "items": [
            {
                "sku": "865253",
                "name": "Test Full Name",
                "description": "Test Product",
                "quantity": "1",
                "unit_price": "0",
                "price": "12",
                "shipping": "0",
                "currency": "USD",
                "url": "",
                "tangible": true
            }
        ],
        "soft_descriptor": {},
        "invoice_number": "865253"
    },
    "risk_check": true,
    "three_d": {},
    "create_time": "2023-12-28T05:03:54Z"
}


*/


?>