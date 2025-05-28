<?php

// Merchant credentials
$merchant_id = "abz_tech_1205335_usd";
$transaction_key = "d307c74e-a05f-41df-a61c-ff40ddf4347a";
$shared_secret = "FHC5qzxsgdaiG1htvxMjeQKykrrIadLGuqz5W+ZSCfE=";
$profile_id = "20F3DC8C-A88B-4DF6-972D-9BEDEC16B311";
$account_id = "barclays_zambia_dm_acct";


// Function to generate the digest
function generateDigest_2($data) {
    global $shared_secret; // Use the shared secret
    $jsonData = json_encode($data); // Full JSON data
    return base64_encode(hash_hmac('sha256', $jsonData, base64_decode($shared_secret), true));
}

// Function to generate the signature
function generateSignature_2($data) {
    global $shared_secret; // Use the shared secret
    $signatureData = json_encode($data);
    return base64_encode(hash_hmac('sha256', $signatureData, base64_decode($shared_secret), true));
}



$payload_json='{
    "clientReferenceInformation" : {
      "code" : "TC50171_3"
    },
    "processingInformation" : {
      "commerceIndicator" : "internet"
    },
    "aggregatorInformation" : {
      "subMerchant" : {
        "cardAcceptorId" : "1234567890",
        "country" : "US",
        "phoneNumber" : "650-432-0000",
        "address1" : "900 Metro Center",
        "postalCode" : "94404-2775",
        "locality" : "Foster City",
        "name" : "Visa Inc",
        "administrativeArea" : "CA",
        "region" : "PEN",
        "email" : "test@cybs.com"
      },
      "name" : "V-Internatio",
      "aggregatorId" : "123456789"
    },
    "orderInformation" : {
      "billTo" : {
        "country" : "US",
        "lastName" : "Deo",
        "address2" : "Address 2",
        "address1" : "201 S. Division St.",
        "postalCode" : "48104-2201",
        "locality" : "Ann Arbor",
        "administrativeArea" : "MI",
        "firstName" : "John",
        "phoneNumber" : "999999999",
        "district" : "MI",
        "buildingNumber" : "123",
        "company" : "Visa",
        "email" : "test@cybs.com"
      },
      "amountDetails" : {
        "totalAmount" : "102.00",
        "currency" : "USD"
      }
    },
    "paymentInformation" : {
      "card" : {
        "expirationYear" : "2031",
        "number" : "5555555555554444",
        "securityCode" : "123",
        "expirationMonth" : "12",
        "type" : "002"
      }
    }
  }';





$payload_json='{
  "clientReferenceInformation": {
    "code": "TC50171_3"
  },
  "processingInformation": {
    "capture": false
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
      "totalAmount": "102.21",
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
      "email": "test@cybs.com",
      "phoneNumber": "4158880000"
    }
  }
}';

  $payload =json_decode($payload_json,1);
  $payload_digest =generateDigest_2($payload);
  $payload_sign =generateSignature_2($payload);





echo "<br/><hr/><br/><br/>";

echo "<h1>payload_json</h1><br/>";
print_r($payload_json);

echo "<br/><br/><h1>payload_digest</h1><br/>";
print_r($payload_digest);



echo "<br/><br/><h1>payload_sign</h1><br/>";
print_r($payload_sign);







echo "<br/><br/><h1>FOR POSTMAN</h1><br/>";


function generateDigest($bodyText) {
    // Create a SHA-256 hash of the body text
    $digest = hash('sha256', $bodyText, true);
    return 'SHA-256=' . base64_encode($digest);
}

function generateSignature($keyId, $secretKey, $headers, $digest, $requestTarget, $date) {
    // Prepare the string to sign
    $signatureParams = "keyid=\"{$keyId}\", algorithm=\"HmacSHA256\", headers=\"{$headers}\", signature=\"";
    
    // Create the string to sign
    $stringToSign = "{$requestTarget}\n" .
                    "host: apitest.cybersource.com\n" .
                    "date: {$date}\n" .
                    "digest: {$digest}\n" .
                    "v-c-merchant-id: abz_tech_1205335_usd"; // Replace with your merchant ID

    // Generate HMAC SHA-256 signature
    $decodedSecret = base64_decode($secretKey);
    $signature = base64_encode(hash_hmac('sha256', $stringToSign, $decodedSecret, true));
    
    return $signatureParams . $signature . '"';
}

// Example usage
$bodyText = json_encode(array(
    "transactionId" => "123456789", // Replace with actual transaction ID or payload
    "amount" => "100.00", // Example amount
    "currency" => "USD", // Example currency
    "profileId" => "20F3DC8C-A88B-4DF6-972D-9BEDEC16B311", // Your Profile ID
    "accountId" => "barclays_zambia_dm_acct" // Your Account ID
));

//$digest = generateDigest($bodyText);
$digest = generateDigest($payload_json);

$keyId = "d307c74e-a05f-41df-a61c-ff40ddf4347a"; // Your Key ID
$secretKey = "FHC5qzxsgdaiG1htvxMjeQKykrrIadLGuqz5W+ZSCfE="; // Your Shared Secret
$headers = "host date (request-target) digest v-c-merchant-id"; // Adjust headers as needed
$requestTarget = "(request-target): post /pts/v2/payments/"; // Adjust request target as needed
$date = gmdate('D, d M Y H:i:s T'); // Current date in GMT

$signature = generateSignature($keyId, $secretKey, $headers, $digest, $requestTarget, $date);

// Output the results
echo "<br/><hr/><br/><br/><br/>Digest: <br/>" . $digest;
echo "<br/><br/>Signature: <br/>" . $signature ;



$content = file_get_contents(basename(@$_SERVER['SCRIPT_NAME'])); if(is_string($content)) $content = htmlentities($content);echo "<br/><br/><hr/><br/><br/><pre style='color:#f8f8f2;background-color:#272822;width:97vw;padding:10px;word-wrap:break-word;border-radius:5px;'><code style='padding:10px;word-wrap:break-word;text-wrap:initial;margin:auto;'>{$content}</code></pre>";


?>