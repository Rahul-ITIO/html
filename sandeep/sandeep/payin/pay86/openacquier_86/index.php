<?php
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
  CURLOPT_POST => 1,
  CURLOPT_SSL_VERIFYPEER => 0,
  CURLOPT_SSL_VERIFYHOST=> 0,
  CURLOPT_POSTFIELDS =>'{
    "intent": "auth",
    "payer": {
        "payment_type": "CC",
        "funding_instrument": {
            "credit_card": {
                "number": "4111111111111111",
                "expire_month": 5,
                "expire_year": 2025,
                "cvv2": "000",
                "name": "integration test"
            }
        },
        "payer_info": {
            "email": "integration@ompay.com",
            "ip": "10.12.20.3",
            "billing_address": {
                "line1": "Test Avenue",
                "line2": "Tes",
                "city": "London",
                "country_code": "GB",
                "postal_code": "W1",
                "state": "",
                "phone": {
                    "country_code": "230",
                    "number": "56662322"
                }
            }
        }
    },
    "transaction": {
        "amount": {
            "currency": "USD",
            "total": "1.0"
        },
        "invoice_number": "123455",
        "return_url" : "http://localhost/cogmer/actions/payment/retrievePaymentSession.php",
    },
}
',
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/json',
    'Authorization: Basic eWNpMDkyYmtyY2Qya2ZyYjo4aWR2YnU3NzhiOHUweWh6'
  ),
));

$curlResponse = curl_exec($curl);

curl_close($curl);

$response = json_decode($curlResponse);

if( isset($response->result->redirect_url) ) {
    header('Location: ' . $response->result->redirect_url);
    exit;
}

print_r($response);
die();