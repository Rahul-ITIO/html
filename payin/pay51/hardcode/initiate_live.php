<?php
session_start(); // Start a new session or resume the existing session

// http://localhost:8080/gw/payin/pay51/hardcode/initiate.php

// Authentication key for the API
$auth_key='live_Z2F0ZXdheS1saXZlOjkxNjgxNzVlLTVhOTYtNGU3YS04ZmM0LWJiY2Y4ZWU2ZTdjMTo3NzRkZWEzMC1kNGRhLTQwY2UtYmYxNi0zMzk4Nzc3N2VmMWE';


// Initialize a cURL session
$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://api-sandbox.spendjuice.com/payment-sessions', // API endpoint
  CURLOPT_RETURNTRANSFER => true, // Return the transfer as a string
  CURLOPT_ENCODING => '', // Accept all encodings
  CURLOPT_MAXREDIRS => 10, // Maximum number of redirects
  CURLOPT_TIMEOUT => 0, // No timeout
  CURLOPT_FOLLOWLOCATION => true, // Follow redirects
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1, // Use HTTP 1.1
  CURLOPT_CUSTOMREQUEST => 'POST', // HTTP POST method
  CURLOPT_POSTFIELDS =>'{
    "customer": {
        "first_name": "John",
        "last_name": "Doe",
        "email": "john.doe@example.com",
        "phone_number": "+2348118873422",
        "billing_address": {
            "line1": "123 Main St",
            "line2": "",
            "city": "Springfield",
            "state": "CA",
            "country": "US",
            "zip_code": "12345"
        }
    },
    "description": "Test",
    "currency": "USD",
    "amount": 100,
    "direction": "incoming",
    "payment_method": {
        "type": "card"
    },
    "reference": "1b09d9b2-11jd9eheveb-9203v0'.rand(10,99).'",
    "settlement_target": "business",
    "metadata": {
        "order": {
            "identifier": "ORD12344",
            "items": [
                {
                    "name": "Deposit",
                    "type": "digital"
                }
            ]
        }
    }
}', // JSON payload for the request
  CURLOPT_HTTPHEADER => array(
    "Authorization: $auth_key", // Authorization header
    "content-type: application/json" // Content type header
  ),
));

// Execute the cURL session
$response = curl_exec($curl);

// Close the cURL session
curl_close($curl);

// Decode the JSON response to an array
$response_array = json_decode($response,1);

// Check if the payment ID exists in the response
if(isset($response_array['data']['payment']['id']))
{
    // Initialize another cURL session
	$curl = curl_init();
	
	curl_setopt_array($curl, array(
	  CURLOPT_URL => 'https://api-sandbox.spendjuice.com/payment-sessions/encryption-keys/test', // API endpoint for encryption keys
	  CURLOPT_RETURNTRANSFER => true, // Return the transfer as a string
	  CURLOPT_ENCODING => '', // Accept all encodings
	  CURLOPT_MAXREDIRS => 10, // Maximum number of redirects
	  CURLOPT_TIMEOUT => 0, // No timeout
	  CURLOPT_FOLLOWLOCATION => true, // Follow redirects
	  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1, // Use HTTP 1.1
	  CURLOPT_CUSTOMREQUEST => 'GET', // HTTP GET method
	  CURLOPT_POSTFIELDS =>'{
		"card": {
			"card_number": "5123450000000008",
			"name": "test",
			"cvv": "100",
			"expiry_month":1 ,
			"expiry_year": 2039
		}
	}', // JSON payload for the request
	  CURLOPT_HTTPHEADER => array(
		"Authorization: $auth_key", // Authorization header
		"content-type: application/json" // Content type header
	  ),
	));
	
	// Execute the cURL session
	$response = curl_exec($curl);
	
	// Close the cURL session
	curl_close($curl);
	
	// Output the response
	echo $response;
	
	// Decode the JSON response to an array
	$ecn_array = json_decode($response,1);
	
	// Retrieve the encryption key from the response
	$ecn_key= $ecn_array['data']['encryption_key'];

	// Store the payment ID and encryption key in session variables
	$_SESSION['payment_id']	=$response_array['data']['payment']['id'];
	$_SESSION['ecn_key']	=$ecn_key;
	
	// Redirect to payment.php and exit
	header("Location:payment.php");exit;
}
?>
