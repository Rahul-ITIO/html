<?php

// Merchant credentials
$merchant_id = "abz_tech_1205335_usd";
$transaction_key = "d307c74e-a05f-41df-a61c-ff40ddf4347a";
$shared_secret = "FHC5qzxsgdaiG1htvxMjeQKykrrIadLGuqz5W+ZSCfE=";
$profile_id = "20F3DC8C-A88B-4DF6-972D-9BEDEC16B311";
$account_id = "barclays_zambia_dm_acct";

function makeAuthorization($amount, $currency, $cardDetails, $clientReferenceCode) {
    global $merchant_id,$transaction_key,$shared_secret,$profile_id,$account_id;
    $url = "https://apitest.cybersource.com/pts/v2/authorizations"; // Authorization URL
    $ch = curl_init();

    // Prepare the request body
    $authData = [
        "clientReferenceInformation" => [
            "code" => $clientReferenceCode
        ],
        "paymentInformation" => [
            "card" => $cardDetails
        ],
        "orderInformation" => [
            "amountDetails" => [
                "totalAmount" => $amount,
                "currency" => $currency
            ]
        ]
    ];

    // Set the options for cURL
    curl_setopt_array($ch, [
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => json_encode($authData),
        CURLOPT_HTTPHEADER => [
            'Content-Type: application/json',
            'v-c-merchant-id: ' . $merchant_id,
            'v-c-date: ' . gmdate('D, d M Y H:i:s T'),
            'digest: ' . generateDigest($authData),
            'signature: ' . generateSignature($authData)
        ],
    ]);

    // Execute the request
    $response = curl_exec($ch);
    $error = curl_error($ch);
    curl_close($ch);

    if ($error) {
        return "cURL Error: " . $error;
    }

    return json_decode($response, true);
}

function makeCapture($transactionId, $amount, $currency) {
    global $merchant_id,$transaction_key,$shared_secret,$profile_id,$account_id;
    $url = "https://apitest.cybersource.com/pts/v2/captures"; // Capture URL
    $ch = curl_init();

    // Prepare the request body
    $captureData = [
        "clientReferenceInformation" => [
            "code" => "Capture for transaction " . $transactionId
        ],
        "orderInformation" => [
            "amountDetails" => [
                "totalAmount" => $amount,
                "currency" => $currency
            ],
            "paymentInformation" => [
                "transactionId" => $transactionId
            ]
        ]
    ];

    // Set the options for cURL
    curl_setopt_array($ch, [
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => json_encode($captureData),
        CURLOPT_HTTPHEADER => [
            'Content-Type: application/json',
            'v-c-merchant-id: ' . $merchant_id,
            'v-c-date: ' . gmdate('D, d M Y H:i:s T'),
            'digest: ' . generateDigest($captureData),
            'signature: ' . generateSignature($captureData)
        ],
    ]);

    // Execute the request
    $response = curl_exec($ch);
    $error = curl_error($ch);
    curl_close($ch);

    if ($error) {
        return "cURL Error: " . $error;
    }

    return json_decode($response, true);
}

function makeCredit($amount, $currency, $transactionId, $clientReferenceCode) {
    global $merchant_id,$transaction_key,$shared_secret,$profile_id,$account_id;
    $url = "https://apitest.cybersource.com/pts/v2/credits"; // Credit URL
    $ch = curl_init();

    // Prepare the request body
    $creditData = [
        "clientReferenceInformation" => [
            "code" => $clientReferenceCode
        ],
        "paymentInformation" => [
            "card" => [
                "number" => "4111111111111111", // Example card number
                "expirationMonth" => "03",
                "expirationYear" => "2031",
                "type" => "001" // Visa
            ]
        ],
        "orderInformation" => [
            "amountDetails" => [
                "totalAmount" => $amount,
                "currency" => $currency
            ],
            "paymentInformation" => [
                "transactionId" => $transactionId
            ]
        ]
    ];

    // Set the options for cURL
    curl_setopt_array($ch, [
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
 CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => json_encode($creditData),
        CURLOPT_HTTPHEADER => [
            'Content-Type: application/json',
            'v-c-merchant-id: ' . $merchant_id,
            'v-c-date: ' . gmdate('D, d M Y H:i:s T'),
            'digest: ' . generateDigest($creditData),
            'signature: ' . generateSignature($creditData)
        ],
    ]);

    // Execute the request
    $response = curl_exec($ch);
    $error = curl_error($ch);
    curl_close($ch);

    if ($error) {
        return "cURL Error: " . $error;
    }

    return json_decode($response, true);
}

// Function to generate the digest
function generateDigest($data) {
    global $shared_secret; // Use the shared secret
    $jsonData = json_encode($data); // Full JSON data
    return base64_encode(hash_hmac('sha256', $jsonData, base64_decode($shared_secret), true));
}

// Function to generate the signature
function generateSignature($data) {
    global $shared_secret; // Use the shared secret
    $signatureData = json_encode($data);
    return base64_encode(hash_hmac('sha256', $signatureData, base64_decode($shared_secret), true));
}

// Example usage
$clientReferenceCode = '12345678'; // Example reference code
$cardDetails = [
    "number" => "4111111111111111", // Example card number
    "expirationMonth" => "03",
    "expirationYear" => "2031",
    "type" => "001" // Visa
];

// Authorization
$amount = 100;
$currency = "USD";
$responseAuth = makeAuthorization($amount, $currency, $cardDetails, $clientReferenceCode);
$transactionId = @$responseAuth['id'];

// Capture
$captureAmount = 100;
$responseCapture = makeCapture($transactionId, $captureAmount, $currency);

// Credit
$creditAmount = 50;
$responseCredit = makeCredit($creditAmount, $currency, $transactionId, $clientReferenceCode);




echo "<br/><hr/><br/><br/>";

echo "<h1>responseAuth</h1><br/>";
print_r($responseAuth);

echo "<br/><br/><h1>responseCapture</h1><br/>";
print_r($responseCapture);

echo "<br/><br/><h1>responseCredit</h1><br/>";
print_r($responseCredit);



$content = file_get_contents(basename(@$_SERVER['SCRIPT_NAME'])); if(is_string($content)) $content = htmlentities($content);echo "<br/><br/><hr/><br/><br/><pre style='color:#f8f8f2;background-color:#272822;width:97vw;padding:10px;word-wrap:break-word;border-radius:5px;'><code style='padding:10px;word-wrap:break-word;text-wrap:initial;margin:auto;'>{$content}</code></pre>";


?>