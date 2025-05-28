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

function makeAuthorizationPayment($paymentId, $clientReferenceCode) {
    $url = "https://apitest.cybersource.com/pts/v2/payments/{$paymentId}/captures"; // Authorization URL
    $ch = curl_init();

    // Prepare the request body
    $paymentData = [
        "clientReferenceInformation" => [
            "code" => $clientReferenceCode
        ],
        "orderInformation" => [
            "amountDetails" => [
                "totalAmount" => "102.21",
                "currency" => "USD"
            ]
        ]
    ];

    // Set the options for cURL
    curl_setopt_array($ch, [
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => json_encode($paymentData), // Encode the payment data as JSON
        CURLOPT_HTTPHEADER => [
            'Content-Type: application/json', // Set the content type to JSON
            'v-c-merchant-id: ' . $merchant_id, // Merchant ID
            'v-c-date: ' . gmdate('D, d M Y H:i:s T'), // Generate the current date
            'digest: ' . generateDigest($paymentData), // Generate digest
            'signature: ' . generateSignature($paymentData) // Generate signature
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
$paymentId = 'your_existing_payment_id_here'; // Replace with the actual payment ID
$clientReferenceCode = 'TC50171_3'; // Example reference code

$responseAuth = makeAuthorizationPayment($paymentId, $clientReferenceCode);



echo "<br/><hr/><br/><br/>";
print_r($responseAuth);



$content = file_get_contents(basename(@$_SERVER['SCRIPT_NAME'])); if(is_string($content)) $content = htmlentities($content);echo "<br/><br/><hr/><br/><br/><pre style='color:#f8f8f2;background-color:#272822;width:97vw;padding:10px;word-wrap:break-word;border-radius:5px;'><code style='padding:10px;word-wrap:break-word;text-wrap:initial;margin:auto;'>{$content}</code></pre>";


?>