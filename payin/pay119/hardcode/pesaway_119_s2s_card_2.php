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
$hash_string = $order_number . $order_amount . $order_currency . $order_description . $card_number . $password;
$final_hash = sha1(md5(strtoupper($hash_string)));

$url = "https://core.pesaway.com/post";
$url = "https://core.pesaway.com/post";

echo "<br/><hr/><br/>url=>".$url."<br/>";
echo "<br/><hr/><br/>order_number=>".$order_number."<br/>";
echo "<br/><hr/><br/>hash_string=>".$hash_string."<br/>";
echo "<br/><hr/><br/>final_hash=>".$final_hash."<br/>";

// === PAYLOAD ===
$payload = json_encode([
    "merchant_key" => $merchant_key,
    "operation" => "debit",
    "order" => [
        "number" => $order_number,
        "amount" => $order_amount,
        "currency" => $order_currency,
        "description" => $order_description
    ],
    "card" => [
        "number" => $card_number,
        "expiry_month" => $card_expiry_month,
        "expiry_year" => $card_expiry_year,
        "cvv" => $card_cvv
    ],
    "hash" => $final_hash
]);

// === CURL REQUEST ===
$curl = curl_init();

curl_setopt_array($curl, array(
    CURLOPT_URL => $url,
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_ENCODING => '',
    CURLOPT_MAXREDIRS => 10,
    CURLOPT_TIMEOUT => 0,
    CURLOPT_FOLLOWLOCATION => true,
    CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
    CURLOPT_CUSTOMREQUEST => 'POST',
    CURLOPT_POSTFIELDS => $payload,
    CURLOPT_HTTPHEADER => array(
        'Content-Type: application/json'
    ),
));

$response = curl_exec($curl);
curl_close($curl);

// === SHOW RESPONSE ===
echo "<br/><hr/><br/>";
echo "<b>payload=></b><br/>".$payload."<br>";
echo "<br/><hr/><br/>";
echo "<b>response=></b><br/>".$response."<br>";
echo "<br/><hr/><br/>"; 


?>
<?php
$content = file_get_contents(basename(@$_SERVER['SCRIPT_NAME'])); if(is_string($content)) $content = htmlentities($content);echo "<pre style='color:#f8f8f2;background-color:#272822;width:97vw;padding:10px;word-wrap:break-word;border-radius:5px;'><code style='padding:10px;word-wrap:break-word;text-wrap:initial;margin:auto;'>{$content}</code></pre>";
//localhost:8080/gw/payin/pay119/hardcode/pesaway_119_s2s_card_2.php
?>