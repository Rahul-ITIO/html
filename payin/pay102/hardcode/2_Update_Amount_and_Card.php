<?php

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://ap-gateway.mastercard.com/api/rest/version/78/merchant/GLADCORIGKEN/session/SESSION0002794014567H3251842M57',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'PUT',
  CURLOPT_POSTFIELDS =>'{
    "order": {
        "currency": "USD",
        "amount": 1,
        "reference": "devOrderTEST5"
    },
    "sourceOfFunds": {
        "provided": {
            "card": {
                "number": "4147673003870003",
                "expiry": {
                    "month": "03",
                    "year": "29"
                },
                "securityCode": "383"
            }
        }
    }
}',
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/json',
    'Authorization: Basic bWVyY2hhbnQuR0xBRENPUklHS0VOOjRkM2Y4ZTA3YjJjNjI1ZDc3OWI4MWM2NzgwODZjYzFk'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;


/*

{
    "merchant": "GLADCORIGKEN",
    "order": {
        "amount": "1",
        "currency": "USD",
        "reference": "devOrderTEST5"
    },
    "session": {
        "id": "SESSION0002794014567H3251842M57",
        "updateStatus": "SUCCESS",
        "version": "e260468702"
    },
    "sourceOfFunds": {
        "provided": {
            "card": {
                "brand": "VISA",
                "expiry": {
                    "month": "3",
                    "year": "29"
                },
                "fundingMethod": "CREDIT",
                "number": "414767xxxxxx0003",
                "scheme": "VISA",
                "securityCode": "xxx"
            }
        }
    },
    "version": "78"
}

*/


?>