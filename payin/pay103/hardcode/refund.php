<?php

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://ap-gateway.mastercard.com/api/rest/version/78/merchant/GLADCORIGKEN/order/orderTEST1/transaction/transTEST20',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'PUT',
  CURLOPT_POSTFIELDS =>'{
    "apiOperation": "REFUND",
    "transaction": {
        "amount": 0.5,
        "currency": "USD",
        "reference": "orderTEST11"
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
        "processingCode": "200000",
        "responseCode": "00",
        "returnAci": "M",
        "stan": "94237",
        "time": "080103",
        "transactionIdentifier": "404108288635391",
        "validationCode": "LJ79"
    },
    "gatewayEntryPoint": "WEB_SERVICES_API",
    "merchant": "GLADCORIGKEN",
    "order": {
        "amount": 1.00,
        "chargeback": {
            "amount": 0,
            "currency": "USD"
        },
        "creationTime": "2024-04-17T07:55:05.712Z",
        "currency": "USD",
        "id": "orderTEST1",
        "lastUpdatedTime": "2024-04-22T08:22:24.130Z",
        "merchantAmount": 1.00,
        "merchantCategoryCode": "5943",
        "merchantCurrency": "USD",
        "reference": "orderTEST1",
        "status": "PARTIALLY_REFUNDED",
        "totalAuthorizedAmount": 1.00,
        "totalCapturedAmount": 1.00,
        "totalDisbursedAmount": 0.00,
        "totalRefundedAmount": 0.50
    },
    "response": {
        "acquirerCode": "00",
        "acquirerMessage": "Approved",
        "cardSecurityCode": {
            "acquirerCode": "M",
            "gatewayCode": "MATCH"
        },
        "gatewayCode": "APPROVED"
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
            "totalScore": 9
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
    "timeOfLastUpdate": "2024-04-22T08:22:24.130Z",
    "timeOfRecord": "2024-04-22T08:22:23.838Z",
    "transaction": {
        "acquirer": {
            "batch": 20240422,
            "date": "0422",
            "id": "UBAKEN_S2I",
            "merchantId": "GLADCORIGKEN033",
            "settlementDate": "2024-04-22",
            "timeZone": "+0300",
            "transactionId": "404108288635391"
        },
        "amount": 0.50,
        "currency": "USD",
        "id": "transTEST20",
        "receipt": "411308328419",
        "reference": "orderTEST11",
        "source": "INTERNET",
        "stan": "328419",
        "terminal": "UBAS3I01",
        "type": "REFUND"
    },
    "version": "78"
}


*/


?>