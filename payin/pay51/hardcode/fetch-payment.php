<?php
session_start(); // Start a new session or resume the existing session

// http://localhost:8080/gw/payin/pay51/hardcode/fetch-payment.php

// Retrieve the payment ID and encryption key from session variables
$payment_id = "01b015d2-4265-11ef-bcc2-ea4cdff7277e";

// Initialize a cURL session
$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://api-sandbox.spendjuice.com/payments/'.$payment_id, // API endpoint
  CURLOPT_RETURNTRANSFER => true, // Return the transfer as a string
  CURLOPT_ENCODING => '', // Accept all encodings
  CURLOPT_MAXREDIRS => 10, // Maximum number of redirects
  CURLOPT_TIMEOUT => 0, // No timeout
  CURLOPT_FOLLOWLOCATION => true, // Follow redirects
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1, // Use HTTP 1.1
  CURLOPT_CUSTOMREQUEST => 'GET', // HTTP POST method
    CURLOPT_HEADER => 0,
    CURLOPT_SSL_VERIFYPEER => 0,
    CURLOPT_SSL_VERIFYHOST => 0,
  CURLOPT_HTTPHEADER => array(
    'Authorization: test_Z2F0ZXdheS10ZXN0OmFmZjVhY2M2LTZhZjItNDVhYS04ZTk3LTcxYzA5ODM1NzAyMzpiMzVmODk3NS04NGE2LTRiZjItYjFhMC04NTM3ZTQ0MmI4NTk', // Authorization header
    'Content-Type: application/json' // Content type header
  ),
));

// Execute the cURL session
$response = curl_exec($curl);

// Close the cURL session
curl_close($curl);

echo $response;
// Decode the JSON response to an array
$response_array = json_decode($response, 1);
?>
