<?php

// Merchant credentials
$merchant_id = "abz_tech_1205335_usd";
$transaction_key = "d307c74e-a05f-41df-a61c-ff40ddf4347a";
$shared_secret = "FHC5qzxsgdaiG1htvxMjeQKykrrIadLGuqz5W+ZSCfE=";
$profile_id = "20F3DC8C-A88B-4DF6-972D-9BEDEC16B311";
$account_id = "barclays_zambia_dm_acct";


//1. Card Payments - Authorization

function authorizePayment($merchant_id, $transaction_key, $profile_id, $account_id) {
    $api_url = "https://testsecureacceptance.cybersource.com/commerce/1.x/transactionProcessor";

    // Prepare the request data for authorization
    $request_data = array(
        'merchantID' => $merchant_id,
        'merchantReferenceCode' => 'MRC-'.uniqid(), // Unique reference code for the transaction
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
        'profileID' => $profile_id,
        'accountID' => $account_id,
        'purchaseTotals_taxAmount' => '0.00',
        'purchaseTotals_shippingAmount' => '0.00',
        'decision' => 'ACCEPT' // This is just an example; actual decision is made by CyberSource
    );

    // Initialize cURL
    $ch = curl_init();

    // Set cURL options
    curl_setopt_array($ch, array(
        CURLOPT_URL => $api_url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => http_build_query($request_data),
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
        parse_str($response, $reply);

        // Check if the response contains the expected fields
        if (isset($reply['decision'])) {
            if ($reply['decision'] == 'ACCEPT') {
                echo "Authorization successful. Request ID: " . $reply['requestID'];
            } else {
                echo "Authorization failed. Reason: " . $reply['reasonCode'] . " - " . $reply['message'];
            }
        } else {
            echo "Authorization failed. Response did not contain a decision. Raw response: " . $response;
        }
    }

    // Close cURL
    curl_close($ch);
}

// Call the function with your credentials
authorizePayment("abz_tech_1205335_usd", "d307c74e-a05f-41df-a61c-ff40ddf4347a", "20F3DC8C-A88B-4DF6-972D-9BEDEC16B311", "barclays_zambia_dm_acct");






//2. Card Payments - Settlement 

function settlePayment($merchant_id, $transaction_key, $request_id) {
    $api_url = "https://testsecureacceptance.cybersource.com/commerce/1.x/transactionProcessor";

    // Prepare the request data for settlement
    $request_data = array(
        'merchantID' => $merchant_id,
        'merchantReferenceCode' => 'MRC-'.uniqid(), // Unique reference code for the transaction
        'requestID' => $request_id, // The request ID from the authorization response
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
        CURLOPT_POSTFIELDS => http_build_query($request_data),
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
        parse_str($response, $reply);

        // Check if the response contains the expected fields
        if (isset($reply['decision'])) {
            if ($reply['decision'] == 'ACCEPT') {
                echo "Settlement successful. Request ID: " . $reply['requestID'];
            } else {
                echo "Settlement failed. Reason: " . $reply['reasonCode'] . " - " . $reply['message'];
            }
        } else {
            echo "Settlement failed. Response did not contain a decision. Raw response: " . $response;
        }
    }

    // Close cURL
    curl_close($ch);
}

// Call the function with your credentials and the request ID from the authorization response
settlePayment("abz_tech_1205335_usd", "d307c74e-a05f-41df-a61c-ff40ddf4347a", "REQUEST_ID_FROM_AUTHORIZATION");





//3. Decision Manager

function decisionManager($merchant_id, $transaction_key, $request_data) {
    $api_url = "https://testsecureacceptance.cybersource.com/commerce/1.x/transactionProcessor";

    // Prepare the request data for Decision Manager
    $request_data['merchantID'] = $merchant_id;
    $request_data['merchantReferenceCode'] = 'MRC-'.uniqid(); // Unique reference code for the transaction

    // Initialize cURL
    $ch = curl_init();

    // Set cURL options
    curl_setopt_array($ch, array(
        CURLOPT_URL => $api_url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => http_build_query($request_data),
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
        parse_str($response, $reply);

        // Check if the response contains the expected fields
        if (isset($reply['decision'])) {
            if ($reply['decision'] == 'ACCEPT') {
                echo "Transaction accepted. Request ID: " . $reply['requestID'];
            } else {
                echo "Transaction declined. Reason: " . $reply['reasonCode'] . " - " . $reply['message'];
            }
        } else {
            echo "Transaction failed. Response did not contain a decision. Raw response: " . $response;
        }
    }

    // Close cURL
    curl_close($ch);
}

// Example request data for Decision Manager
$request_data = array(
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

// Call the function with your credentials and request data
decisionManager("abz_tech_1205335_usd", "d307c74e-a -a05f-41df-a61c-ff40ddf4347a", $request_data); 

?>