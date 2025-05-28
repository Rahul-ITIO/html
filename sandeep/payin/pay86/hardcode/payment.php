<?php
// http://localhost/gw/payin/pay86/hardcode/payment.php

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://api.sandbox.openacquiring.com/v1/merchants/vynh3bui63qbx604/payment',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>'{
    "intent": "sale",
    "payer": {
        "payment_type": "CC",
        "funding_instrument": {
            "credit_card": {
                "number": "4543474002249996",
                "expire_month": "06",
                "expire_year": "2025",
                "cvv2": "956",
                "name": "Dev Tech Ops"
            }
        },
        "payer_info": {
            "email": "devops@itio.in",
            "name": "Dev Tech Ops",
            "billing_address": {
                "line1": "18 Avenue",
                "line2": "cassidy",
                "city": "Rose-Hill",
                "country_code": "mu",
                "postal_code": "72101",
                "state": "",
                "phone": {
                    "country_code": "230",
                    "number": "57976041"
                }
            }
        },
        "browser_info": {
            "accept_header": "text/html,application/xhtml+xml,application/xml;q\\u003d0.9,image/avif,image/webp,*/*;q\\u003d0.8",
            "color_depth": 24,
            "java_enabled": false,
            "javascript_enabled": true,
            "language": "en-US",
            "screen_height": "1080",
            "screen_width": "1920",
            "timezone_offset": -240,
            "user_agent": "Mozilla/5.0 \\u0026 #40;Windows NT 10.0; Win64; x64; rv:103.0\\u0026#41; Gecko/20100101 Firefox/103.0",
            "ip": "12.2.12.0",
            "channel": "Web"
        }
    },
    "payee": {
        "email": "devops@test.com",
        "merchant_id": "vynh3bui63qbx604"
    },
    "transaction": {
        "type": "1",
        "amount": {
            "currency": "USD",
            "total": "300"
        },
        "invoice_number": "8623122601",
        "items": [
            {
                "sku": "100299S",
                "name": "Ultrawatch",
                "description": "Smart watch",
                "quantity": "1",
                "price": "500",
                "shipping": "20",
                "currency": "USD",
                "url": "",
                "image": "",
                "tangible": "true"
            },
            {
                "sku": "100269S",
                "name": "Drone",
                "description": "drone x",
                "quantity": "1",
                "price": "500",
                "shipping": "20",
                "currency": "USD",
                "url": "",
                "image": "",
                "tangible": "true"
            }
        ]
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
    "id": "QNKJR6FYJ8WHJFUX54D1",
    "reference_id": "QNKJR6FYJ8WHJFUX54D1",
    "state": "pending",
    "result": {
        "authorisation_code": "00000",
        "redirect_url": "https://api.sandbox.openacquiring.com/v1/redirect/689b29d30e144baca2ea47e601d12059",
        "additional_data": {
            "descriptor": null
        },
        "code": "1007",
        "description": "Redirect"
    },
    "intent": "SALE",
    "payer": {
        "payment_type": "CC",
        "funding_instrument": {
            "credit_card": {
                "id": "bdb965ef-c4c7-4e8b-bca3-3f09ec427c93",
                "type": "Visa",
                "expire_month": 6,
                "expire_year": 2025,
                "name": "Dev Tech Ops",
                "last4": "9996",
                "bin": "454347",
                "bin_data": {
                    "bin": "454347",
                    "country_code": "MU",
                    "country_name": "MAURITIUS",
                    "bank_name": "STATE BANK OF MAURITIUS, LTD.",
                    "card_scheme": "VISA",
                    "card_type": "CREDIT",
                    "card_category": "Consumer"
                }
            }
        },
        "payer_info": {
            "id": "87fe53b2-3c5f-4cfd-b3ed-6a311387871f",
            "email": "devops@itio.in",
            "name": "Dev Tech Ops",
            "billing_address": {
                "phone": {
                    "country_code": "230",
                    "number": "57976041"
                },
                "line1": "18 Avenue",
                "line2": "cassidy",
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
            "total": "300"
        },
        "type": "1",
        "mode": "1",
        "items": [
            {
                "sku": "100299S",
                "name": "Ultrawatch",
                "description": "Smart watch",
                "quantity": "1",
                "price": "500",
                "shipping": "",
                "url": ""
            },
            {
                "sku": "100269S",
                "name": "Drone",
                "description": "drone x",
                "quantity": "1",
                "price": "500",
                "shipping": "",
                "url": ""
            }
        ],
        "shipping_address": {
            "phone": {}
        },
        "invoice_number": "8623122601"
    },
    "custom": {},
    "risk_check": true,
    "three_d": {},
    "create_time": "2023-12-26T12:04:50Z"
}


*/

/*

https://cogmer.com/return?payment-session-id=689b29d30e144baca2ea47e601d12059

*/



?>