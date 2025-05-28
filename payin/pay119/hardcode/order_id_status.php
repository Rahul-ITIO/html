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
$endpoint = "https://pay.pesaway.com/api/v1/payment/status";



// ======== CONFIGURATION ========
$orderId = '11920250410074212'; // Replace with the order_id from SALE transaction
$orderId = '11920250410122854'; // Replace with the order_id from SALE transaction

if(isset($_GET['order_id'])) {
    $orderId = $_GET['order_id'];
} 

// ======== HASH GENERATION ========
// Format: sha1(md5(order_id + password)) UPPERCASED
$innerMd5 = md5(strtoupper($orderId . $password));
$hash = sha1($innerMd5);

// ======== REQUEST DATA ========
$requestData = [
    'merchant_key' => $merchant_key,
    'order_id'     => $orderId,
    'hash'         => $hash
];





############################################

echo "<br/><hr/><br/>url endpoint=>".$endpoint."<br/>";
echo "<br/><hr/><br/>merchant_key=>".$merchant_key."<br/>";
echo "<br/><hr/><br/>order_id=>".$orderId."<br/>";
echo "<br/><hr/><br/>innerMd5=>".$innerMd5."<br/>";
echo "<br/><hr/><br/>hash with sha1=>".$hash."<br/>";

$postDataJsonEncode = json_encode($requestData);
echo "<br/><hr/><br/>postDataJsonEncode=>".$postDataJsonEncode."<br/>";




// ======== CURL POST (JSON Format) ========
$ch = curl_init($endpoint);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($requestData));
curl_setopt($ch, CURLOPT_HTTPHEADER, [
    'Content-Type: application/json',
]);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
curl_setopt($ch, CURLOPT_MAXREDIRS, 10);
curl_setopt($ch, CURLOPT_TIMEOUT, 30); // Set timeout to 30 seconds
curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 0); // Set connection timeout to 10 seconds
curl_setopt($ch, CURLOPT_VERBOSE, true); // Enable verbose output for debugging
curl_setopt($ch, CURLOPT_HEADER, 0); // Include headers in the output
curl_setopt($ch, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_1); // Use HTTP/1.1

$response = curl_exec($ch);
$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
$curlError = curl_error($ch);
curl_close($ch);

// ======== RESPONSE OUTPUT ========
if ($httpCode == 200) {
    $result = json_decode($response, true);
    echo "<pre>✅ Transaction Status Response:\n";
    print_r($result);
    echo "</pre>";
} else {
    echo "❌ Error while checking transaction status. HTTP Code: $httpCode";
}




// === SHOW RESPONSE ===
echo "<br/><hr/><br/>";
echo "<b>HTTP Status:=></b><br/>".@$httpCode."<br>";
echo "<br/><b>response=></b><br/>".@$response."<br>";
echo "<br/><hr/><br/>";

/*
{
    "payment_id": "5ece9b28-1607-11f0-bdc2-deff67c2fa34",
    "date": "2025-04-10 12:28:55",
    "status": "pending",
    "order": {
        "number": "11920250410122854",
        "amount": "11.99",
        "currency": "USD",
        "description": "Dev Tech Test Payment"
    },
    "customer": {
        "name": "Dev Tech",
        "email": "doe@example.com"
    }
}


//Webhook
{
    "action": "webhook",
    "result": "SUCCESS",
    "status": "PENDING",
    "order_id": "11920250410122854",
    "trans_id": "5ece9b28-1607-11f0-bdc2-deff67c2fa34",
    "hash": "aaa4ff37e0cf048bf94dc0d397376134",
    "trans_date": "2025-04-10 12:29:37",
    "amount": "11.99",
    "currency": "USD",
    "card": "411111****1111",
    "card_expiration_date": "12/2038"
}

*/


?>
<?php
$content = file_get_contents(basename(@$_SERVER['SCRIPT_NAME'])); if(is_string($content)) $content = htmlentities($content);echo "<pre style='color:#f8f8f2;background-color:#272822;width:97vw;padding:10px;word-wrap:break-word;border-radius:5px;'><code style='padding:10px;word-wrap:break-word;text-wrap:initial;margin:auto;'>{$content}</code></pre>";
//localhost:8080/gw/payin/pay119/hardcode/order_id_status.php
?>