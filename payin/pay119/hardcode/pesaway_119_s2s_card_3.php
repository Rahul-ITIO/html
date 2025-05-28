<?php
if(!isset($_SESSION)) {
	session_start(); 
	//session_regenerate_id(true); 
}

error_reporting(E_ALL ^ (E_DEPRECATED));
ini_set('display_errors', '1');
ini_set('max_execution_time', 0);

// === CONFIGURATION ===
$merchant_key = "4b0446ec-ff55-11ef-a7d4-36f1d24257a9";
$password = "db16ad9eb50d11e6de2f160dacf78537";
$endpoint = "https://core.pesaway.com/post";


// === ORDER DETAILS ===
$order_number = "119".date('YmdHis');
$order_amount = "12.19";
$order_currency = "USD";
$order_description = "Test debit from Dev Tech";
$card_number = "4111111111111111"; // dummy Visa test card
$card_expiry_month = "12";
$card_expiry_year = "25";
$card_cvv = "123";

// === CREATE HASH ===
// Format: order_number + order_amount + order_currency + order_description + card_number + password
// === CREATE HASH ===
$order_number = "orde-s2s-001";
$order_amount = "0.19";
$order_currency = "USD";
$order_description = "Important gift";

$md5 = md5(strtoupper($order_number . $order_amount . $order_currency . $order_description . $password));
$hash = sha1($md5);


echo "<br/><hr/><br/>url=>".$endpoint."<br/>";
echo "<br/><hr/><br/>order_number=>".$order_number."<br/>";
echo "<br/><hr/><br/>md5=>".$md5."<br/>";
echo "<br/><hr/><br/>hash=>".$hash."<br/>";

// === CREATE PAYLOAD ===
$data = [
    "merchant_key" => $merchant_key,
    "operation" => "debit",
    "order" => [
      "number" => $order_number,
      "amount" => $order_amount,
      "currency" => $order_currency,
      "description" => $order_description
    ],
    "card" => [
      "number" => "4111111111111111",
      "cvv" => "123",
      "expiry_month" => "12",
      "expiry_year" => "2026"
    ],
    "billing_address" => [
      "country" => "US",
      "state" => "CA",
      "city" => "Los Angeles",
      "address" => "Moor Building 35274",
      "zip" => "123456",
      "phone" => "347771112233"
    ],
    "customer" => [
      "name" => "John Doe",
      "email" => "test@email.com"
    ],
    "hash" => $hash
  ];
  

// === CURL REQUEST ===
// === SEND REQUEST ===
$ch = curl_init($endpoint);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json']);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
curl_setopt($ch, CURLOPT_MAXREDIRS, 10);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);

$response = curl_exec($ch);
$http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

// === OUTPUT ===

if ($http_code == 200) {
    $response_data = json_decode($response, true);
    if (isset($response_data['status']) && $response_data['status'] == 'success') {
        echo "Payment successful!<br>";
        echo "Transaction ID: " . $response_data['transaction_id'] . "<br>";
    } else {
        echo "Payment failed!<br>";
        echo "Error: " . $response_data['error_message'] . "<br>";
    }
} 

// === SHOW RESPONSE ===
echo "<br/><hr/><br/>";
$payload = json_encode($data);
echo "<b>payload=></b><br/>".$payload."<br>";
echo "<br/><hr/><br/>";
echo "<b>HTTP Status:=></b><br/>".$http_code."<br>";
echo "<br/><b>response=></b><br/>".$response."<br>";
echo "<br/><hr/><br/>"; 


?>
<?php
$content = file_get_contents(basename(@$_SERVER['SCRIPT_NAME'])); if(is_string($content)) $content = htmlentities($content);echo "<pre style='color:#f8f8f2;background-color:#272822;width:97vw;padding:10px;word-wrap:break-word;border-radius:5px;'><code style='padding:10px;word-wrap:break-word;text-wrap:initial;margin:auto;'>{$content}</code></pre>";
//localhost:8080/gw/payin/pay119/hardcode/pesaway_119_s2s_card_3.php
?>