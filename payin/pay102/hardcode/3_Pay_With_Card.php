<?php

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://ap-gateway.mastercard.com/api/rest/version/78/merchant/GLADCORIGKEN/order/devOrderTEST5/transaction/transTEST5',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'PUT',
  CURLOPT_POSTFIELDS =>'{
    "apiOperation": "PAY",
    "sourceOfFunds": {
        "type": "CARD"
    },
    "session": {
        "id": "SESSION0002794014567H3251842M57"
    },
    "transaction": {
        "reference": "devOrderTEST5"
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
    "authorizationResponse": {
        "cardLevelIndicator": "C ",
        "cardSecurityCodeError": "M",
        "commercialCard": "!01",
        "commercialCardIndicator": "0",
        "date": "0417",
        "posData": "1025100006600",
        "posEntryMode": "812",
        "processingCode": "000000",
        "responseCode": "00",
        "returnAci": "M",
        "stan": "111333",
        "time": "101547",
        "transactionIdentifier": "404108369486854",
        "validationCode": "KG36"
    },
    "gatewayEntryPoint": "WEB_SERVICES_API",
    "merchant": "GLADCORIGKEN",
    "order": {
        "amount": 1.00,
        "authenticationStatus": "AUTHENTICATION_NOT_IN_EFFECT",
        "chargeback": {
            "amount": 0,
            "currency": "USD"
        },
        "creationTime": "2024-04-17T10:15:47.528Z",
        "currency": "USD",
        "id": "devOrderTEST5",
        "lastUpdatedTime": "2024-04-17T10:15:48.508Z",
        "merchantAmount": 1.00,
        "merchantCategoryCode": "5943",
        "merchantCurrency": "USD",
        "reference": "devOrderTEST5",
        "status": "CAPTURED",
        "totalAuthorizedAmount": 1.00,
        "totalCapturedAmount": 1.00,
        "totalDisbursedAmount": 0.00,
        "totalRefundedAmount": 0.00
    },
    "response": {
        "acquirerCode": "00",
        "acquirerMessage": "Approved",
        "cardSecurityCode": {
            "acquirerCode": "M",
            "gatewayCode": "MATCH"
        },
        "gatewayCode": "APPROVED",
        "gatewayRecommendation": "NO_ACTION"
    },
    "result": "SUCCESS",
    "risk": {
        "response": {
            "gatewayCode": "ACCEPTED",
            "provider": "ABRIGHTERIONMLE",
            "review": {
                "decision": "NOT_REQUIRED"
            },
            "rule": [
                {
                    "data": "414767",
                    "name": "MERCHANT_BIN_RANGE",
                    "recommendation": "NO_ACTION",
                    "type": "MERCHANT_RULE"
                },
                {
                    "data": "M",
                    "name": "MERCHANT_CSC",
                    "recommendation": "NO_ACTION",
                    "type": "MERCHANT_RULE"
                },
                {
                    "name": "SUSPECT_CARD_LIST",
                    "recommendation": "NO_ACTION",
                    "type": "MERCHANT_RULE"
                },
                {
                    "name": "TRUSTED_CARD_LIST",
                    "recommendation": "NO_ACTION",
                    "type": "MERCHANT_RULE"
                },
                {
                    "data": "NO_RULES",
                    "name": "MSO_3D_SECURE",
                    "recommendation": "NO_ACTION",
                    "type": "MSO_RULE"
                },
                {
                    "data": "414767",
                    "name": "MSO_BIN_RANGE",
                    "recommendation": "NO_ACTION",
                    "type": "MSO_RULE"
                },
                {
                    "data": "M",
                    "name": "MSO_CSC",
                    "recommendation": "NO_ACTION",
                    "type": "MSO_RULE"
                }
            ],
            "totalScore": 10
        }
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
                "storedOnFile": "NOT_STORED"
            }
        },
        "type": "CARD"
    },
    "timeOfLastUpdate": "2024-04-17T10:15:48.508Z",
    "timeOfRecord": "2024-04-17T10:15:47.562Z",
    "transaction": {
        "acquirer": {
            "batch": 20240417,
            "date": "0417",
            "id": "UBAKEN_S2I",
            "merchantId": "GLADCORIGKEN033",
            "settlementDate": "2024-04-17",
            "timeZone": "+0300",
            "transactionId": "404108369486854"
        },
        "amount": 1.00,
        "authenticationStatus": "AUTHENTICATION_NOT_IN_EFFECT",
        "authorizationCode": "752507",
        "currency": "USD",
        "id": "transTEST5",
        "receipt": "410810111333",
        "reference": "devOrderTEST5",
        "source": "INTERNET",
        "stan": "111333",
        "terminal": "UBAS3I01",
        "type": "PAYMENT"
    },
    "version": "78"
}

*/


?>