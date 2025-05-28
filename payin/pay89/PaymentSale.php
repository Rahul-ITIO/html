<?php
session_start();

//print_r($_SESSION);
//exit;
if (isset($_SESSION['token'])) {
     $token = $_SESSION['token'];
} else {
    echo "Token not set in session.";
}

//exit;
//echo $token;
//exit;
$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://checkout.wzrdpay.io/payment/sale',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>'{
    "data": {
        "type": "sale-operation",
        "attributes": {
            "card_number": "5123817234060000",
            "card_holder": "Deepti",
            "cvv": "564",
            "exp_month": "10",
            "exp_year": "31",
            "browser_info": {
                "browser_color_depth": "24",
                "browser_ip": "223.236.192.243",
                "browser_java_enabled": "",
                "browser_language": "en-US",
                "browser_screen_height": "1200",
                "browser_screen_width": "1920",
                "browser_tz": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36",
                "window_height": "***",
                "window_width": "***",
                "browser_accept_header": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
            }
        }
    }
}
',
  CURLOPT_HTTPHEADER => array(
            'Content-Type: application/json',
            'Authorization: Bearer ' . $token
        ),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;
?>