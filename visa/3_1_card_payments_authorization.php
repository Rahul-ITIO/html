<?php


if(!isset($_SESSION)) {
	session_start(); 
	//session_regenerate_id(true); 
}


ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);



// Merchant credentials
$merchant_id = "abz_tech_1205335_usd";
$transaction_key = "d307c74e-a05f-41df-a61c-ff40ddf4347a";
$shared_secret = "FHC5qzxsgdaiG1htvxMjeQKykrrIadLGuqz5W+ZSCfE=";
$profile_id = "20F3DC8C-A88B-4DF6-972D-9BEDEC16B311";
$account_id = "barclays_zambia_dm_acct";


function makeCreditRequest($clientReferenceCode) {
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
                "number" => "4111111111111111",
                "expirationMonth" => "03",
                "expirationYear" => "2031",
                "type" => "001" // Visa
            ]
        ],
        "orderInformation" => [
            "amountDetails" => [
                "totalAmount" => "200",
                "currency" => "USD"
            ],
            "billTo" => [
                "firstName" => "John",
                "lastName" => "Deo",
                "address1" => "900 Metro Center Blvd",
                "locality" => "Foster City",
                "administrativeArea" => "CA",
                "postalCode" => "48104-2201",
                "country" => "US",
                "email" => "test@cybs.com",
                "phoneNumber" => "9321499232"
            ]
        ]
    ];

    // Set the options for cURL
    curl_setopt_array($ch, [
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => json_encode($creditData), // Encode the credit data as JSON
        CURLOPT_HTTPHEADER => [
            'Content-Type: application/json', // Set the content type to JSON
            'v-c-merchant-id: ' . $merchant_id, // Merchant ID
            'v-c-date: ' . gmdate('D, d M Y H:i:s T'), // Generate the current date
            'digest: ' . generateDigest($creditData), // Generate digest
            'signature: ' . generateSignature($creditData) // Generate signature
        ],
    ]);

    // Execute the request
    $response = curl_exec($ch);
    $error = curl_error($ch);
    curl_close($ch);

    if ($error) {
        return "cURL Error: " . $error;
    }

    return json_decode($response, true); // Assuming the response is in JSON format
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
$clientReferenceCode = '115' . date('ymdHis'); // Example reference code
$responseCredit = makeCreditRequest($clientReferenceCode);

echo "<br/><hr/><br/><br/>";
print_r($responseCredit);



$content = file_get_contents(basename(@$_SERVER['SCRIPT_NAME'])); if(is_string($content)) $content = htmlentities($content);echo "<br/><br/><hr/><br/><br/><pre style='color:#f8f8f2;background-color:#272822;width:97vw;padding:10px;word-wrap:break-word;border-radius:5px;'><code style='padding:10px;word-wrap:break-word;text-wrap:initial;margin:auto;'>{$content}</code></pre>";

?>