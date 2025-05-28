<?php

function makePayment($paymentData) {
    $url = 'https://testsecureacceptance.cybersource.com/pay'; // UAT endpoint for both authorization and settlement
    $ch = curl_init();

    // Set the options for cURL
    curl_setopt_array($ch, [
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => http_build_query($paymentData),
        CURLOPT_HTTPHEADER => [
            'Content-Type: application/x-www-form-urlencoded',
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

// Example payment data for Authorization
$paymentDataAuth = [
    'access_key' => 'd307c74e-a05f-41df-a61c-ff40ddf4347a',
    'profile_id' => '20F3DC8C-A88B-4DF6-972D-9BEDEC16B311',
    'transaction_type' => 'authorization',
    'amount' => '100.00',
    'currency' => 'USD',
    'reference_number' => uniqid(),
    'signed_date_time' => gmdate('Y-m-d\TH:i:s\Z'),
    'signed_field_names' => 'access_key,profile_id,transaction_type,amount,currency,reference_number,signed_date_time',
    'card_number' => '4111111111111111', // Test card number
    'card_expiry_date' => '12-2023',
    'card_cvn' => '123',
    'bill_to_forename' => 'John',
    'bill_to_surname' => 'Doe',
    'bill_to_email' => 'john.doe@example.com',
    'bill_to_address_line1' => '123 Main St',
    'bill_to_address_city' => 'San Francisco',
    'bill_to_address_state' => 'CA',
    'bill_to_address_postal_code' => '94105',
    'bill_to_address_country' => 'US',
];

// Generate the signature for Authorization
$paymentDataAuth['signature'] = generateSignature($paymentDataAuth);

// Make the Authorization Payment
$responseAuth = makePayment($paymentDataAuth);
print_r($responseAuth);

// Check if the authorization was successful and extract the payment token
//if (isset($responseAuth['decision']) && $responseAuth['decision'] === 'ACCEPT') 
if($responseAuth)
{
    $paymentToken = $responseAuth['req_payment_token']; // Extract the payment token from the response

    // Example payment data for Settlement
    $paymentDataSettle = [
        'access_key' => 'd307c74e-a05f-41df-a61c-ff40ddf4347a',
        'profile_id' => '20F3DC8C-A88B-4DF6-972D-9BEDEC16B311',
        'transaction_type' => 'sale', // or 'capture' if settling an authorization
        'amount' => '100.00',
        'currency' => 'USD',
        'reference_number' => uniqid(),
        'signed_date_time' => gmdate('Y-m-d\TH:i:s\Z'),
        'signed_field_names' => 'access_key,profile_id,transaction_type,amount,currency,reference_number,signed_date_time,payment_token',
        'payment_token' => $paymentToken, // Use the payment token from the previous transaction
    ];

    // Generate the signature for Settlement
    $paymentDataSettle['signature'] = generateSignature($paymentDataSettle);

    // Make the Settlement Payment
    $responseSettle = makePayment($paymentDataSettle);
    print_r($responseSettle);
} else {
    echo "Authorization failed. No payment token available.";
}

// Function to generate the signature
function generateSignature($data) {
    $secret = 'FHC5qzxsgdaiG1htvxMjeQKykrrIadLGuqz5W+ZSCfE='; // Your shared secret
    // Create the string to sign
    $signedFields = explode(',', $data['signed_field_names']);
    $stringToSign = '';
    foreach ($signedFields as $field) {
        $stringToSign .= $field . '=' . $data[$field] . "\n";
    }
    // Generate the HMAC signature
    return base64_encode(hash_hmac('sha256', $stringToSign, base64_decode($secret), true));
}
?>