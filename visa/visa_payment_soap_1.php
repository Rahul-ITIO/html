<?php

if(!isset($_SESSION)) {
	session_start(); 
	//session_regenerate_id(true); 
}


$content = file_get_contents(basename(@$_SERVER['SCRIPT_NAME'])); if(is_string($content)) $content = htmlentities($content);echo "<pre style='color:#f8f8f2;background-color:#272822;width:97vw;padding:10px;word-wrap:break-word;border-radius:5px;'><code style='padding:10px;word-wrap:break-word;text-wrap:initial;margin:auto;'>{$content}</code></pre>";

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);


// Merchant credentials
$merchant_id = "abz_tech_1205335_usd";
$transaction_key = "d307c74e-a05f-41df-a61c-ff40ddf4347a";

// API endpoint for NVP
$api_url = "https://ics2wstest.ic3.com/commerce/1.x/transactionProcessor/NVP"; // Ensure this is the correct NVP endpoint

// Prepare the request data
$request_data = array(
    'merchantID' => $merchant_id,
    'merchantReferenceCode' => 'MRC-12345', // Unique reference code for the transaction
    'billTo_firstName' => 'John',
    'billTo_lastName' => 'Doe',
    'billTo_street1' => '123 Main St',
    'billTo_city' => 'San Francisco',
    'billTo_state' => 'CA',
    'billTo_postalCode' => '94105',
    'billTo_country' => 'US',
    'billTo_email' => 'john.doe@example.com',
    'card_accountNumber' => '4111111111111111', // Test card number
    'card_expirationMonth' => '12',
    'card_expirationYear' => '2025',
    'purchaseTotals_currency' => 'USD',
    'purchaseTotals_grandTotalAmount' => '100.00', // Total amount for the transaction
);

// Initialize cURL
$ch = curl_init();

// Set cURL options
curl_setopt_array($ch, array(
    CURLOPT_URL => $api_url,
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_POST => true,
    CURLOPT_POSTFIELDS => http_build_query($request_data), // Convert the request array to a query string
    CURLOPT_HTTPHEADER => array(
        'Content-Type: application/x-www-form-urlencoded',
        'Accept: application/json'
    ),
));

// Execute the cURL request
$response = curl_exec($ch);

// Check for cURL errors
if (curl_errno($ch)) {
    echo 'Curl error: ' . curl_error($ch);
} else {
    // Log the raw response for debugging
    file_put_contents('response.log', $response . PHP_EOL, FILE_APPEND);

    // Decode the response
    parse_str($response, $reply); // Parse the response string into an associative array

    // Check if the response contains the expected fields
    if (isset($reply['decision'])) {
        if ($reply['decision'] == 'ACCEPT') {
            echo "Transaction successful. Request ID: " . $reply['requestID'];
        } else {
            // Provide more detailed error information
            $reason = isset($reply['reasonCode']) ? $reply['reasonCode'] : 'No reason code provided';
            $message = isset($reply['message']) ? $reply['message'] : 'No message provided';
            echo "Transaction failed. Reason: " . $reason . " - " . $message;
        }
    } else {
        echo "Transaction failed. Response did not contain a decision. Raw response: " . $response;
    }
}

// Close cURL
curl_close($ch);
?>