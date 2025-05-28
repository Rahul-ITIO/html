<?php

// http://localhost:8080/visa/visa_payment_3.php?live=1

if(!isset($_SESSION)) {
	session_start(); 
	//session_regenerate_id(true); 
}


ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// UAT - TEST Your credentials (consider using environment variables for security)
$access_key = 'd307c74e-a05f-41df-a61c-ff40ddf4347a'; // Your Access Key
$profile_id = '20F3DC8C-A88B-4DF6-972D-9BEDEC16B311'; // Your Profile ID
$shared_secret = 'FHC5qzxsgdaiG1htvxMjeQKykrrIadLGuqz5W+ZSCfE='; // Your Shared Secret


if (isset($_REQUEST['live'])) {

    // LIVE Your credentials (consider using environment variables for security)
    $access_key = '3353809a-61d8-466b-bb51-1a2329f5677d'; // Your Access Key
    $profile_id = 'abb_1197094_consulting_usd'; // Your Profile ID
    $shared_secret = 'qkzmB23UGesX+j23C+N+7hjLL4IRROyx6HXFHs0noY8='; // Your Shared Secret


}

// Generate a unique transaction ID
//$transaction_uuid = uniqid();
$transaction_uuid = '115' . date('ymdHis');
$reference_number = '999' . date('ymdHis');
$amount = '100.00';
$currency = 'USD';
$locale = 'en';

// Customer billing information
$bill_to_forename = 'John';
$bill_to_surname = 'Doe';
$bill_to_email = 'johndoe@example.com';
$bill_to_address_line1 = '123 Main St';
$bill_to_address_city = 'Anytown';
$bill_to_address_state = 'CA';
$bill_to_address_postal_code = '12345';
$bill_to_address_country = 'US';

// UAT - Test Card information
$card_number = '4111111111111111'; // Test Visa card number
$card_expiry_date = '12-2025'; // Expiration date in MM-YYYY format
$card_cvn = '123'; // CVN number

if (isset($_REQUEST['live'])) {
    // Live Card information
    $card_number = '4281021015248691'; // Test Visa card number
    $card_expiry_date = '07-2029'; // Expiration date in MM-YYYY format
    $card_cvn = '123'; // CVN number
}

// Prepare the request fields
$request_fields = [
    'access_key' => $access_key,
    'profile_id' => $profile_id,
    'transaction_type' => 'sale',
    'reference_number' => $reference_number,
    'amount' => $amount,
    'currency' => $currency,
    'locale' => $locale,
    'transaction_uuid' => $transaction_uuid,
    'bill_to_forename' => $bill_to_forename,
    'bill_to_surname' => $bill_to_surname,
    'bill_to_email' => $bill_to_email,
    'bill_to_address_line1' => $bill_to_address_line1,
    'bill_to_address_city' => $bill_to_address_city,
    'bill_to_address_state' => $bill_to_address_state,
    'bill_to_address_postal_code' => $bill_to_address_postal_code,
    'bill_to_address_country' => $bill_to_address_country,
    'card_number' => $card_number,
    'card_expiry_date' => $card_expiry_date,
    'card_cvn' => $card_cvn,
];

// Generate a signature for the request
$signed_field_names = implode(',', array_keys($request_fields));
$signed_data = http_build_query($request_fields, '', '&');

// Generate the HMAC signature
$signature = base64_encode(hash_hmac('sha256', $signed_data, base64_decode($shared_secret), true));

// Add the signature to the request
$request_fields['signed_field_names'] = $signed_field_names;
$request_fields['signature'] = $signature;

// cURL request
$endpoint = 'https://testsecureacceptance.cybersource.com/pay'; // Use the correct UAT endpoint
if (isset($_REQUEST['live'])) {
    $endpoint = 'https://secureacceptance.in.cybersource.com/pay'; // Use the correct Live endpoint in India
    $endpoint = 'https://secureacceptance.cybersource.com/pay'; // Use the correct Live endpoint in India
}

$ch = curl_init();
curl_setopt_array($ch, [
    CURLOPT_URL => $endpoint,
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_SSL_VERIFYPEER => false,
    CURLOPT_SSL_VERIFYHOST => false,
    CURLOPT_HEADER => false,
    CURLOPT_POST => true,
    CURLOPT_POSTFIELDS => http_build_query($request_fields),
    CURLOPT_HTTPHEADER => [
        "Content-Type: application/x-www-form-urlencoded",
    ],
]);

// Execute the request
$response = curl_exec($ch);

// Debugging output



echo "<b>access_key:</b> <br/> $access_key <br/><br/>";
echo "<b>profile_id:</b> <br/> $profile_id <br/><br/>";
echo "<b>shared_secret:</b> <br/> $shared_secret <br/><br/>";


echo "<b>Request URL:</b> <br/> $endpoint <br/><br/>";
echo "<b>Request Fields:</b> <br/>" . print_r($request_fields, true) . "<br/><br/>";
echo "<b>Raw Response:</b> <br/>" . ($response) . "<br/><br/>"; // Output raw response for debugging

// Check for cURL errors
if ($response === false) {
    echo "Error processing payment: " . curl_error($ch) . "<br/>";
    echo "HTTP Response Code: " . curl_getinfo($ch, CURLINFO_HTTP_CODE) . "<br/>";
} else {
    // Output HTTP response code for debugging
    $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    echo "HTTP Response Code: " . $http_code . "<br/>";
    
    // Check if the response is HTML (indicating an error)
    if (strpos($response, '<!DOCTYPE html>') !== false) {
        echo "Received an HTML response instead of JSON. The response is:<br/>";
        echo htmlspecialchars($response);
    } else {
        // Validate and process the response
        $response_data = json_decode($response, true);
        if (json_last_error() !== JSON_ERROR_NONE) {
            echo "Error decoding JSON response: " . json_last_error_msg() . "<br/>";
        } else {
            print_r($response_data);
        }
    }
}



$content = file_get_contents(basename(@$_SERVER['SCRIPT_NAME'])); if(is_string($content)) $content = htmlentities($content);echo "<br/><br/><hr/><br/><br/><pre style='color:#f8f8f2;background-color:#272822;width:97vw;padding:10px;word-wrap:break-word;border-radius:5px;'><code style='padding:10px;word-wrap:break-word;text-wrap:initial;margin:auto;'>{$content}</code></pre>";

?>