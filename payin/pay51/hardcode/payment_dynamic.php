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
if(isset($response_array['data']['links']['redirect_url'])) {
    $redirect_url = $response_array['data']['links']['redirect_url']; // Retrieve the redirect URL
    header("Location:$redirect_url"); // Redirect to the URL
    exit; // Exit the script
} else {
    // Output the response if no redirect URL is found
    echo $response;
}


/*

{
    "data": {
        "auth_type": "3ds",
        "configuration": null,
        "expires_at": "2024-07-13T21:11:55.952977Z",
        "links": {
            "redirect_url": "https://pgv2.qa.arca-payments.network/arca-mp/api/v2/inith?mtx=ARCFIW05115082061720861919590"
        },
        "message": "Waiting for payment",
        "payment": {
            "amount": 100,
            "amount_paid": null,
            "cancellation_reason": null,
            "correlation_id": "f372e896-40f7-11ef-bd1f-ea4cdff7277e",
            "currency": "USD",
            "customer": {
                "billing_address": {
                    "city": "Springfield",
                    "country": "US",
                    "line1": "123 Main St",
                    "line2": "",
                    "state": "CA",
                    "zip_code": "12345"
                },
                "email": "john.doe@example.com",
                "first_name": "John",
                "id": "39ae57ad-a113-4498-95d1-6aa167687931",
                "last_name": "Doe",
                "phone_number": "+2348118873422"
            },
            "date": "2024-07-13T09:11:55.726880Z",
            "description": "Test",
            "id": "f3702372-40f7-11ef-a198-ea4cdff7277e",
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
            },
            "mode": "test",
            "payer": null,
            "payment_method": {
                "card_number": "512345******0008",
                "expiry_month": 1,
                "expiry_year": 2039,
                "id": "455e8579-809b-4a25-9d19-18a6b6566539",
                "type": "card"
            },
            "provider_id": null,
            "reference": "1b09d9b2-11jd9eheveb-9203v054",
            "status": "authenticating",
            "type": "payin"
        },
        "status": "authenticating"
    }
}



###################################################

https://api-sandbox.spendjuice.com/payment-sessions/JJRqg5HY8NZnhoKYnjCqKm/3ds?order_payment_reference=ARCPAY-0F390FD9D69846B1A64846EB722F62B8&status=successful


*/
?>
