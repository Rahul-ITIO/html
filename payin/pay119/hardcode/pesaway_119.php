<?php
//localhost:8080/payin/pay119/hardcode/pesaway_119.php
?>
<?php
$content = file_get_contents(basename(@$_SERVER['SCRIPT_NAME'])); if(is_string($content)) $content = htmlentities($content);echo "<pre style='color:#f8f8f2;background-color:#272822;width:97vw;padding:10px;word-wrap:break-word;border-radius:5px;'><code style='padding:10px;word-wrap:break-word;text-wrap:initial;margin:auto;'>{$content}</code></pre>";

// API endpoint (as per documentation)
$url = "https://core.pesaway.com/post";

// Test credentials
$merchant_key = "4b0446ec-ff55-11ef-a7d4-36f1d24257a9";
$password = "db16ad9eb50d11e6de2f160dacf78537";



// Dummy card details (from documentation)
$card_number = "4111111111111111";
$card_expiry_month = "01";
$card_expiry_year = "2038";
$card_cvv = "100";




// Build the request data
$data = [
    "command" => "card_payment",                  // Required API command
    "merchant_key" => $merchant_key,
    "password" => $password,
    "order_id" => "TEST_ORDER_" . time(),         // Unique order ID
    "amount" => "100",                            // Amount in KES
    "currency" => "KES",
    "customer_email" => "test@example.com",
    "customer_phone" => "0712345678",
    "description" => "Test card payment",

    // Card details
    "card_number" => $card_number,
    "card_expiry_month" => $card_expiry_month,
    "card_expiry_year" => $card_expiry_year,
    "card_cvv" => $card_cvv
];

// Initialize CURL
$ch = curl_init($url);

// Set CURL options
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($data));
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
curl_setopt($ch, CURLOPT_MAXREDIRS, 15);

curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);

// Execute CURL and get response
$response = curl_exec($ch);
$http_status = curl_getinfo($ch, CURLINFO_HTTP_CODE);

if (curl_errno($ch)) {
    echo "CURL Error: " . curl_error($ch);
} else {
    echo "HTTP Status: $http_status<br>";
    echo "<pre>Response:\n" . htmlentities($response) . "</pre>";
}

// Close CURL session
curl_close($ch);
?>
