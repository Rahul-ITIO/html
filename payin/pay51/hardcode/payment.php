<?php
session_start(); // Start a new session or resume the existing session

// Retrieve the payment ID and encryption key from session variables
$payment_id = $_SESSION['payment_id'];
$ecn_key = $_SESSION['ecn_key'];

// Function to encrypt card details using AES-256-GCM
function card_encrypt($payload, $key) {
    $cipher = "aes-256-gcm"; // Cipher method
    $iv = openssl_random_pseudo_bytes(16); // Generate a random initialization vector (IV)
    $cipher_text = openssl_encrypt($payload, $cipher, $key, OPENSSL_RAW_DATA, $iv, $tag); // Encrypt the payload
    return implode(':', [bin2hex($iv), bin2hex($cipher_text), bin2hex($tag)]); // Return the IV, cipher text, and tag as a single string
}

// Encrypt card details and CVV using the encryption key
$card = card_encrypt("5123450000000008", $ecn_key);
$cvv = card_encrypt("100", $ecn_key);

// Initialize a cURL session
$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://api-sandbox.spendjuice.com/payment-sessions/'.$payment_id, // API endpoint
  CURLOPT_RETURNTRANSFER => true, // Return the transfer as a string
  CURLOPT_ENCODING => '', // Accept all encodings
  CURLOPT_MAXREDIRS => 10, // Maximum number of redirects
  CURLOPT_TIMEOUT => 0, // No timeout
  CURLOPT_FOLLOWLOCATION => true, // Follow redirects
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1, // Use HTTP 1.1
  CURLOPT_CUSTOMREQUEST => 'POST', // HTTP POST method
  CURLOPT_POSTFIELDS => '{
    "card": {
        "card_number": "'.$card.'",
        "name": "Test",
        "cvv": "'.$cvv.'",
        "expiry_month": 1,
        "expiry_year": 2039
    }
}', // JSON payload for the request
  CURLOPT_HTTPHEADER => array(
    'Authorization: test_Z2F0ZXdheS10ZXN0OmFmZjVhY2M2LTZhZjItNDVhYS04ZTk3LTcxYzA5ODM1NzAyMzpiMzVmODk3NS04NGE2LTRiZjItYjFhMC04NTM3ZTQ0MmI4NTk', // Authorization header
    'Content-Type: application/json' // Content type header
  ),
));

// Execute the cURL session
$response = curl_exec($curl);

// Close the cURL session
curl_close($curl);

// Decode the JSON response to an array
$response_array = json_decode($response, 1);

// Check if the response contains a redirect URL
if(isset($response_array['data']['redirect_url'])) {
    $redirect_url = $response_array['data']['redirect_url']; // Retrieve the redirect URL
    header("Location:$redirect_url"); // Redirect to the URL
    exit; // Exit the script
} else {
    // Output the response if no redirect URL is found
    echo $response;
}


/*
https://api-sandbox.spendjuice.com/payment-sessions/JJRqg5HY8NZnhoKYnjCqKm/3ds?order_payment_reference=ARCPAY-0F390FD9D69846B1A64846EB722F62B8&status=successful


*/
?>
