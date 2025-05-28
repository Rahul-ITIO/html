<?php
// http://localhost:8080/gw/payin/pay118/hardcode/payment_118_hardcode.php

// Simple Authorisation (Internet)

$curl = curl_init();

curl_setopt_array($curl, array(
	CURLOPT_URL => 'https://apitest.cybersource.com/pts/v2/payments/',
	CURLOPT_RETURNTRANSFER => true,
	CURLOPT_ENCODING => '',
	CURLOPT_MAXREDIRS => 10,
	CURLOPT_TIMEOUT => 0,
	CURLOPT_FOLLOWLOCATION => true,
	CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	CURLOPT_CUSTOMREQUEST => 'POST',
	CURLOPT_POSTFIELDS =>'{
  "clientReferenceInformation": {
    "code": "DevTransTestInt7"
  },
  "paymentInformation": {
    "card": {
      "number": "4111111111111111",
      "expirationMonth": "12",
      "expirationYear": "2031"
    }
  },
  "orderInformation": {
    "amountDetails": {
      "totalAmount": "131.31",
      "currency": "USD"
    },
    "billTo": {
      "firstName": "John",
      "lastName": "Doe",
      "address1": "1 Market St",
      "locality": "san francisco",
      "administrativeArea": "CA",
      "postalCode": "94105",
      "country": "US",
      "email": "devops@itio.in",
      "phoneNumber": "4158880000"
    }
  }
}',
	CURLOPT_HTTPHEADER => array(
		'v-c-merchant-id: dev_tech_visa_it',
		'Date: Sat, 07 Dec 2024 04:47:10 GMT',
		'Host: apitest.cybersource.com',
		'Digest: SHA-256=ib1wcghhj+PC45buMpi0d5D1qe16B8RvmsgYuG+ewpU=',
		'Signature: keyid="4a18c8d7-af18-4d79-94a8-8864b131f8ff", algorithm="HmacSHA256", headers="host date (request-target) digest v-c-merchant-id", signature="wC3Dy664tj3RYs04DpPxUoXS2Utt8cmSoXGfPXYshts="',
		'Content-Type: application/json',
		'User-Agent: Mozilla/5.0'
	),
));

$response = curl_exec($curl);

curl_close($curl);


echo "<br/>response=>".$response;


/*

{
    "_links": {
        "authReversal": {
            "method": "POST",
            "href": "/pts/v2/payments/7330488512236401904953/reversals"
        },
        "self": {
            "method": "GET",
            "href": "/pts/v2/payments/7330488512236401904953"
        },
        "capture": {
            "method": "POST",
            "href": "/pts/v2/payments/7330488512236401904953/captures"
        }
    },
    "clientReferenceInformation": {
        "code": "DevTransTestInt2"
    },
    "id": "7330488512236401904953",
    "orderInformation": {
        "amountDetails": {
            "authorizedAmount": "14200.21",
            "currency": "USD"
        }
    },
    "paymentAccountInformation": {
        "card": {
            "type": "001"
        }
    },
    "paymentInformation": {
        "tokenizedCard": {
            "type": "001"
        },
        "card": {
            "type": "001"
        }
    },
    "pointOfSaleInformation": {
        "terminalId": "111111"
    },
    "processorInformation": {
        "approvalCode": "888888",
        "networkTransactionId": "123456789619999",
        "transactionId": "123456789619999",
        "responseCode": "100",
        "avs": {
            "code": "X",
            "codeRaw": "I1"
        }
    },
    "reconciliationId": "76743169P3O4Z26T",
    "status": "AUTHORIZED",
    "submitTimeUtc": "2024-12-01T10:27:31Z"
}

*/

?>