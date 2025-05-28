<?php
// API endpoint (as per documentation)
//$url = "https://core.pesaway.com/post";
$url = "https://core.pesaway.com/post/api/v1/session";
$url = "https://core.pesaway.com/v2/post";
$url = "https://core.pesaway.com/post";

// Test credentials
$merchant_key = "4b0446ec-ff55-11ef-a7d4-36f1d24257a9";
$password = "db16ad9eb50d11e6de2f160dacf78537";


// === ORDER DETAILS ===
$order_number = "119".date('YmdHis');
$order_amount = "11.00"; // Amount in UGX
$order_currency = "USD";
$order_description = "Important dev gift";

// === CREATE HASH ===
$hash_string = $order_number . $order_amount . $order_currency . $order_description . $password;
$hash = sha1(md5(strtoupper($hash_string)));

echo "<br/><hr/><br/>hash=>".$hash."<br><br>";



// Dummy card details (from documentation)
$card_number = "4111111111111111";
$card_expiry_month = "01";
$card_expiry_year = "2038";
$card_cvv = "100";



// Build the request data
$dataRequest = array(
    'merchant_key' => $merchant_key,
    'operation'    => 'purchase',
    "order" => [
        "number" => $order_number,
        "amount" => $order_amount,
        "currency" => $order_currency,
        "description" => $order_description
    ],
    "customer" => [
        "name" => "Dev John Doe",
        "email" => "test@email.com"
    ],
    "billing_address" => [
        "country" => "US",
        "state" => "CA",
        "city" => "Los Angeles",
        "address" => "Moor Building 35274",
        "zip" => "123456",
        "phone" => "347771112233"
    ],
    "methods" => ["card"],
    
    // Card details
    "card" => [
        "number" => $card_number,
        "expiry_month" => $card_expiry_month,
        "expiry_year" => $card_expiry_year,
        "cvv" => $card_cvv
    ],
    "recurring_init" => "false",

    "cancel_url" => "https://aws-cc-uat.web1.one/responseDataList/?urlaction=notify_pesaway",
    "success_url" => "https://aws-cc-uat.web1.one/responseDataList/?urlaction=success_pesaway",
    'hash'         => $hash,

);

$data_query = http_build_query($dataRequest);
$data_query = json_encode($dataRequest);

echo "<br/><hr/><br/><b>url=></b><br/>".$url."<br>";
echo "<br/><hr/><br/><b>data_query=></b><br/>".$data_query."<br>";


// Initialize CURL
$ch = curl_init($url);

// Set CURL options
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, $data_query);
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
curl_setopt($ch, CURLOPT_MAXREDIRS, 10);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
curl_setopt($ch, CURLOPT_HTTPHEADER, array(
    'Content-Type: application/json'
));
//curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/x-www-form-urlencoded'));
//curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json', 'Content-Length: ' . strlen($data_query)));
// Execute CURL and get response
$response = curl_exec($ch);
$http_status = curl_getinfo($ch, CURLINFO_HTTP_CODE);

echo "<br/><hr/><br/>";

if (curl_errno($ch)) {
    echo "CURL Error: " . curl_error($ch);
} else {
    echo "HTTP Status: $http_status<br>";
    echo "<br/><b>Response=></b><br/>"."<pre>" . htmlentities($response) . "</pre>";
}

// Close CURL session
curl_close($ch);

echo "<br/><hr/><br/>";

?>
<?php
//localhost:8080/gw/payin/pay119/hardcode/pesaway_119_s2s_card.php
$content = file_get_contents(basename(@$_SERVER['SCRIPT_NAME'])); if(is_string($content)) $content = htmlentities($content);echo "<pre style='color:#f8f8f2;background-color:#272822;width:97vw;padding:10px;word-wrap:break-word;border-radius:5px;'><code style='padding:10px;word-wrap:break-word;text-wrap:initial;margin:auto;'>{$content}</code></pre>";
?>