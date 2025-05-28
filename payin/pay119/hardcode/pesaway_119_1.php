<?php
//localhost:8080/payin/pay119/hardcode/pesaway_119_1.php
// https://aws-cc-uat.web1.one/payin/pay119/hardcode/pesaway_119_1.php
?>
<?php
$content = file_get_contents(basename(@$_SERVER['SCRIPT_NAME'])); if(is_string($content)) $content = htmlentities($content);echo "<pre style='color:#f8f8f2;background-color:#272822;width:97vw;padding:10px;word-wrap:break-word;border-radius:5px;'><code style='padding:10px;word-wrap:break-word;text-wrap:initial;margin:auto;'>{$content}</code></pre>";

// Merchant credentials
$merchant_key = '4b0446ec-ff55-11ef-a7d4-36f1d24257a9';
$password = 'db16ad9eb50d11e6de2f160dacf78537';

// API endpoint
$url = 'http://core.pesaway.com/post';

// Dummy card data (use test values from the Pesaway documentation)
$data = [
    'merchant_key' => $merchant_key,
    'password' => $password,
    'amount' => '100',
    'currency' => 'KES',
    'card_number' => '5123450000000008',
    'card_expiry_month' => '12',
    'card_expiry_year' => '2026',
    'card_cvv' => '100',
    'order_reference' => 'TEST_ORDER_001',
    'customer_email' => 'test@example.com',
    'customer_phone' => '0712345678',
    'description' => 'Test payment'
];

// Setup CURL
$ch = curl_init($url);

curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($data));
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true); // Follow redirect
curl_setopt($ch, CURLOPT_MAXREDIRS, 5); // Max redirects

// Allow 308 to redirect while preserving POST
curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');

$response = curl_exec($ch);
$http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);

if (curl_errno($ch)) {
    echo 'Curl error: ' . curl_error($ch);
} else {
    echo "HTTP Status: $http_code\n";
    echo "Response:\n$response";
}

curl_close($ch);
?>
