<?php
//localhost:8080/gw/payin/pay119/hardcode/pesaway_119_checkout.php
//https://aws-cc-uat.web1.one/payin/pay119/hardcode/pesaway_119_checkout.php
?>
<?php
$content = file_get_contents(basename(@$_SERVER['SCRIPT_NAME'])); if(is_string($content)) $content = htmlentities($content);echo "<pre style='color:#f8f8f2;background-color:#272822;width:97vw;padding:10px;word-wrap:break-word;border-radius:5px;'><code style='padding:10px;word-wrap:break-word;text-wrap:initial;margin:auto;'>{$content}</code></pre>";

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
//$order_number = "dev-".date('YmdHis')."-".rand(1000,9999);
//$order_number = "orde-dev-1234";
$order_number = "119".date('YmdHis');
$order_amount = "10.00"; // Amount in UGX
$order_currency = "USD";
$order_description = "Important gift";

// === CREATE HASH ===
$hash_string = $order_number . $order_amount . $order_currency . $order_description . $password;
$session_hash = sha1(md5(strtoupper($hash_string)));

$hash_payment_id = sha1(md5(strtoupper($order_number . $order_amount . $password)));
        

echo "<br/><hr/><br/>order_number=>".$order_number."<br><br>";
echo "<br/><hr/><br/>hash_string=>".$hash_string."<br><br>";
echo "<br/><hr/><br/>session_hash=>".$session_hash."<br><br>";
echo "<br/><hr/><br/>hash_payment_id=>".$hash_payment_id."<br><br>";

// === PREPARE PAYLOAD ===
$payload = json_encode([
    "merchant_key" => $merchant_key,
    "operation" => "purchase",
    "methods" => ["card"],
    "order" => [
        "number" => $order_number,
        "amount" => $order_amount,
        "currency" => $order_currency,
        "description" => $order_description
    ],
    "cancel_url" => "https://aws-cc-uat.web1.one/responseDataList/?urlaction=notify_pesaway",
    "success_url" => "https://aws-cc-uat.web1.one/responseDataList/?urlaction=success_pesaway",
    "customer" => [
        "name" => "Dev Tech",
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
    "recurring_init" => "false",
    "hash" => $session_hash
]);

$url="https://pay.pesaway.com/api/v1/session";
$data_query = json_encode($payload);

echo "<br/><hr/><br/><b>url=></b><br/>".$url."<br>";
echo "<br/><hr/><br/><b>data_query=></b><br/>".$data_query."<br>";



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

echo "<br/><hr/><br/><b>response=></b><br/>".$response;

$response_de = json_decode($response, true);
if (isset($response_de['redirect_url'])) {
    echo "<br/><hr/><br/><b>Redirect URL=></b><br/>".$response_de['redirect_url'];
} 

/*

{"redirect_url":"https://pay.pesaway.com/auth/ZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKU1V6STFOaUo5LmV5SnBZWFFpT2pFM05EUXhPVFkyTVRnc0ltcDBhU0k2SWpRNVpqUTJaRFV5TFRFMU16SXRNVEZtTUMxaFpqVmlMVGRsTkRSaE56VXlaVEZpWVNJc0ltVjRjQ0k2TVRjME5ESXdNREl4T0gwLkduZnBJcjJzWFNnaTUtM3dTWUhuUGQwb29zSjJWQjFXTmRzak9ycEdVczBfN1lROGhpUHFSNXpYTVBWM1JQOFA4XzNUQ0VvckRmMGFDUU02UU90SHpCaHBlbVpBaXE0V0RvYWRIdDJLbVdyYXo3dXdiLXM5V0hndm1qWGY4aUZDcnNOY1MwNkdyZ0VpNFFucDZTQmJZQ2hVUlk5TkZPbDJaZjNjVmZqeHBaT3NTSkJ4d282d2JjVVZQcU95bVhKWGJ0MFRSOXo5Q2xpX3JzMU5SdXVLQ0Rzc1NBd3JqV2hWa2NsYTJsSGZubDNHQ1Z4MFVxSjcweWdTQk9nekd3NXBkRFBFd2FnOXVrNkVvTDhpejFQMEotQ3dqMWE3WHNlTU9UbWd6ZDRiRDJuSGY4aEZ2NS0wSjJVSWVvakJTUVpaVlk0RldFRHlHalFaQ0szYWN5XzVUbFhldUE0Z0ZtNkxFUVoydk4xQ1ZpUnZYZF9vN3dvMXpVWUt5eW5YbWxSUGZwYVAwU3BTOGRDU1p5bVUwaDVIUVNyUnNsX2xpUkZfUVlySEdvMTZXYllZNXJYanIwSnZjMlhVYVNFNWR5NlJkVmV5cmJBajBrbmVCbkYzUU5HR1hkTGdMcFdLNFltQ054RFlrYk4xRE1XWlk2X1Y2RjJsREpRbU5TLTlkTFN1Vk9kTGZRMUJHUGY1ZlRZNjJMNlJwdkdXZ2lRZnNUcldYQkVpUDVfYVFEUzJYaGI0YkJLWmxfX0xzaW5KbHI5MHRjLV9Ndk8tMGswM3FNM0V0UEVkY01FM1dnVEJGcXkzMktraDl4R2NDTWxHUDlmc2piUnhpeC1aTkp2SHVEeGtjY01mYVNtbURudlgxVHg5M3hBMEczSFFQQjFFRWJ2aDdjTzlveVVwanRF"}

*/

?>
