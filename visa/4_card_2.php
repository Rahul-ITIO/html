<?php

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
                    "v-c-merchant-id: abz_tech_1205335_usd"; // Your Merchant ID

    // Generate HMAC SHA-256 signature
    $decodedSecret = base64_decode($secretKey);
    $signature = base64_encode(hash_hmac('sha256', $stringToSign, $decodedSecret, true));
    
    return $signatureParams . $signature . '"';
}

// Define your keys and IDs
$keyId = "d307c74e-a05f-41df-a61c-ff40ddf4347a"; // Your Key ID
$secretKey = "FHC5qzxsgdaiG1htvxMjeQKykrrIadLGuqz5W+ZSCfE="; // Your Shared Secret
$merchantId = "abz_tech_1205335_usd"; // Your Merchant ID
$profileId = "20F3DC8C-A88B-4DF6-972D-9BEDEC16B311"; // Your Profile ID
$accountId = "barclays_zambia_dm_acct"; // Your Account ID



// Create the JSON payload
$bodyText = json_encode(array(
    "clientReferenceInformation" => array(
        "code" => "TC50171_3"
    ),
    "processingInformation" => array(
        "commerceIndicator" => "internet"
    ),
    "processinginformation" => array(
        "capture" => false
    ),
    "aggregatorInformation" => array(
        "subMerchant" => array(
            "cardAcceptorId" => "1234567890",
            "country" => "US",
            "phoneNumber" => "650-432-0000",
            "address1" => "900 Metro Center",
            "postalCode" => "94404-2775",
            "locality" => "Foster City",
            "name" => "Visa Inc",
            "administrativeArea" => "CA",
            "region" => "PEN",
            "email" => "test@cybs.com"
        ),
        "name" => "V-Internatio",
        "aggregatorId" => "123456789"
    ),
    "orderInformation" => array(
        "billTo" => array(
            "country" => "US",
            "lastName" => "Deo",
            "address2" => "Address 2",
            "address1" => "201 S. Division St.",
            "postalCode" => "48104-2201",
            "locality" => "Ann Arbor",
            "administrativeArea" => "MI",
            "firstName" => "John",
            "phoneNumber" => "999999999",
            "district" => "MI",
            "buildingNumber" => "123",
            "company" => "Visa",
            "email" => "test@cybs.com"
        ),
        "amountDetails" => array(
            "totalAmount" => "102.00",
            "currency" => "USD"
        )
    ),
    "paymentInformation" => array(
        "card" => array(
            "expirationYear" => "2031",
            "number" => "5555555555554444",
            "securityCode" => "123",
            "expirationMonth" => "12",
            "type" => "002"
        )
    )
));

// Generate the Digest
$digest = generateDigest($bodyText);

// Prepare headers
$date = gmdate('D, d M Y H:i:s T'); // Current date in GMT
$requestTarget = "(request-target): post /pts/v2/payments/"; // Adjust request target as needed
$headers = "host date ( request-target) digest v-c-merchant-id"; // Adjust headers as needed

// Generate the Signature
$signature = generateSignature($keyId, $secretKey, $headers, $digest, $requestTarget, $date);

// Initialize cURL
$curl = curl_init();

curl_setopt_array($curl, array(
    CURLOPT_URL => 'https://apitest.cybersource.com/pts/v2/payments/',
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_ENCODING => '',
    CURLOPT_MAXREDIRS => 10,
    CURLOPT_TIMEOUT => 0,
    CURLOPT_FOLLOWLOCATION => true,
    CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_SSL_VERIFYPEER => false, // Disable SSL verification for testing
        CURLOPT_SSL_VERIFYHOST => false, // Disable host verification for testing
        CURLOPT_VERBOSE => true, // Enable Detailed Error Reporting
    CURLOPT_CUSTOMREQUEST => 'POST',
    CURLOPT_POSTFIELDS => $bodyText,
    CURLOPT_HTTPHEADER => array(
        "v-c-merchant-id: {$merchantId}",
        "Date: {$date}",
        "Host: apitest.cybersource.com",
        "Digest: {$digest}",
        "Signature: {$signature}",
        "Content-Type: application/json",
        "User -Agent: Mozilla/5.0"
    ),
));

// Execute the cURL request
$response = curl_exec($curl);

// Check for cURL errors
if ($response === false) {
    $error = curl_error($curl);
    echo "<h1>Error</h1><br/>";
    print_r($error);
} else {
    // Output the response
    echo "<h1>Response</h1><br/>";
    print_r($response);
}

// Close cURL session
curl_close($curl);





echo "<br/><hr/><br/><br/>";

echo "<h1>error</h1><br/>";
print_r($error);

echo "<h1>digest</h1><br/>";
print_r($digest);

echo "<br/><br/><h1>signature</h1><br/>";
print_r($signature);

echo "<br/><br/><h1>response</h1><br/>";
print_r($response);



$content = file_get_contents(basename(@$_SERVER['SCRIPT_NAME'])); if(is_string($content)) $content = htmlentities($content);echo "<br/><br/><hr/><br/><br/><pre style='color:#f8f8f2;background-color:#272822;width:97vw;padding:10px;word-wrap:break-word;border-radius:5px;'><code style='padding:10px;word-wrap:break-word;text-wrap:initial;margin:auto;'>{$content}</code></pre>";


?>