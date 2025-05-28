<?php
// Your credentials
$access_key = 'd307c74e-a05f-41df-a61c-ff40ddf4347a'; // Your Access Key
$profile_id = '20F3DC8C-A88B-4DF6-972D-9BEDEC16B311'; // Your Profile ID
$shared_secret = 'FHC5qzxsgdaiG1htvxMjeQKykrrIadLGuqz5W+ZSCfE='; // Your Shared Secret

// Generate a unique transaction ID
$transaction_uuid = uniqid(); // Unique transaction ID
$amount = '100.00'; // Amount to charge
$currency = 'USD'; // Currency code
$locale = 'en'; // Locale for the transaction

// Customer billing information
$bill_to_forename = 'John';
$bill_to_surname = 'Doe';
$bill_to_email = 'johndoe@example.com';
$bill_to_address_line1 = '123 Main St';
$bill_to_address_city = 'Anytown';
$bill_to_address_state = 'CA';
$bill_to_address_postal_code = '12345';
$bill_to_address_country = 'US';

// Card information
$card_number = '4111111111111111'; // Test Visa card number
$card_expiry_date = '12-2025'; // Expiration date in MM-YYYY format
$card_cvn = '123'; // CVN number

// Prepare the request fields
$request_fields = [
    'access_key' => $access_key,
    'profile_id' => $profile_id,
    'transaction_type' => 'sale',
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

// Send the request to the Secure Acceptance endpoint
$endpoint = 'https://secureacceptance.cybersource.com/pay'; // Use the correct endpoint
$options = [
    'http' => [
        'header'  => "Content-Type: application/x-www-form-urlencoded\r\n",
        'method'  => 'POST',
        'content' => http_build_query($request_fields),
    ],
];

// Debugging output
echo "Request URL: $endpoint\n";
echo "Request Fields: " . print_r($request_fields, true) . "\n";

$context  = stream_context_create($options);
$result = @file_get_contents($endpoint, false, $context);
if ($result === FALSE) {
    // Handle error
    $error = error_get_last();
    echo "Error processing payment: " . $error['message'] . "\n";
    // Additional debugging: Check HTTP response code
    $http_response_header = isset($http_response_header) ? $http_response_header : [];
    echo "HTTP Response Header: " . print_r($http_response_header, true) . "\n";
} else {
    // Process the response
    $response = json_decode($result, true);
    print_r($response);
}
?>