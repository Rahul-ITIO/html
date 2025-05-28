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


// === Pesaway Test/Sandbox Credentials ===
$clientKey  = '4b0446ec-ff55-11ef-a7d4-36f1d24257a9'; // Example client_key
$password   = 'db16ad9eb50d11e6de2f160dacf78537';    // Example PASSWORD

// === Order & Card Details ===
$orderId          = "119".date('YmdHis');
$orderAmount      = '11.99';
$orderCurrency    = 'USD';
$orderDescription = 'Dev Tech Test Payment';
$cardNumber       = '4111111111111111';
$cardExpMonth     = '12'; // 06 || 12
$cardExpYear      = '2038';
$cardCVV2         = '123';

// === Payer Details ===
$payerFirstName = 'Dev';
$payerLastName  = 'Tech';
$payerAddress   = 'Big street';
$payerCountry   = 'US';
$payerState     = 'CA';
$payerCity      = 'City';
$payerZip       = '123456';
$payerEmail     = 'doe@example.com';
$payerPhone     = '199999999';
$payerIP        = '123.123.123.123';
$termUrl3ds     = 'https://aws-cc-uat.web1.one/responseDataList/?urlaction=termUrl3ds_pesaway';
$webhookUrl     = 'https://aws-cc-uat.web1.one/payin/pay119/webhookhandler_119?dev=testing';

// === Optional Flags ===
$auth      = 'N'; // Set to 'Y' for AUTH-only
$reqToken  = 'Y';  // If you want card_token returned

// === Optional Flags ===
$auth      = 'Y'; // Set to 'Y' for AUTH-only
$reqToken  = 'N'; // If you want card_token returned

// === Calculate HASH using Formula 1 ===
$first6  = substr($cardNumber, 0, 6);
$last4   = substr($cardNumber, -4);
$hashRaw = strtoupper(strrev($payerEmail) . $password . strrev($first6 . $last4));
$hash    = md5($hashRaw);

// === Build Request Data ===
$postData = [
    'action'             => 'SALE',
    'client_key'         => $clientKey,
    'order_id'           => $orderId,
    'order_amount'       => $orderAmount,
    'order_currency'     => $orderCurrency,
    'order_description'  => $orderDescription,
    'card_number'        => $cardNumber,
    'card_exp_month'     => $cardExpMonth,
    'card_exp_year'      => $cardExpYear,
    'card_cvv2'          => $cardCVV2,
    'payer_first_name'   => $payerFirstName,
    'payer_last_name'    => $payerLastName,
    'payer_address'      => $payerAddress,
    'payer_country'      => $payerCountry,
    'payer_state'        => $payerState,
    'payer_city'         => $payerCity,
    'payer_zip'          => $payerZip,
    'payer_email'        => $payerEmail,
    'payer_phone'        => $payerPhone,
    'payer_ip'           => $payerIP,
    'term_url_3ds'       => $termUrl3ds,
    'auth'               => $auth,
    'req_token'          => $reqToken,
    'hash'               => $hash
];


############################################

echo "<br/><hr/><br/>url endpoint=>".$endpoint."<br/>";
echo "<br/><hr/><br/>client_key=>".$clientKey."<br/>";
echo "<br/><hr/><br/>order_id=>".$orderId."<br/>";
echo "<br/><hr/><br/>hashRaw=>".$hashRaw."<br/>";
echo "<br/><hr/><br/>hash with md5=>".$hash."<br/>";

$postDataJsonEncode = json_encode($postData);
echo "<br/><hr/><br/>postDataJsonEncode=>".$postDataJsonEncode."<br/>";






// === CURL REQUEST ===
// === SEND REQUEST ===
$ch = curl_init($endpoint);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_POST, true);
//curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json']);
//curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($postData));
curl_setopt($ch, CURLOPT_POSTFIELDS,  $postData);
curl_setopt($ch, CURLOPT_MAXREDIRS, 10);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);

$response = curl_exec($ch);
$http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
$curlError = curl_error($ch);
curl_close($ch);

// === OUTPUT ===


// === Parse & Display Result ===
if (@$curlError) {
    echo "❌ CURL Error: $curlError";
    exit;
}

$response_array = json_decode($response, true);

echo "<h2>Pesaway Response</h2>";
echo "<pre>" . print_r($response_array, true) . "</pre>";

if (!$response_array) {
    echo "❌ Invalid JSON response.";
    exit;
}

switch ($response_array['result']) {
    case 'SUCCESS':
        echo "✅ Transaction Approved!<br>";
        echo "Transaction ID: " . $response_array['trans_id'] . "<br>";
        echo "Card Token: " . ($response_array['card_token'] ?? 'N/A');
        break;

    case 'REDIRECT':
        echo "🔄 3D Secure Required. Redirecting to 3DS page...<br>";
        echo "<br/><hr/><br/>redirect_url=>".@$response_array['redirect_url']."<br/>";
        //header("Location: " . $response_array['redirect_url']);
        //exit;

    case 'DECLINED':
    default:
        echo "❌ Transaction Declined: " . ($response_array['error_message'] ?? 'Unknown Error');
        break;
}


// === SHOW RESPONSE ===
echo "<br/><hr/><br/>";
echo "<b>HTTP Status:=></b><br/>".$http_code."<br>";
echo "<br/><b>response=></b><br/>".$response."<br>";
echo "<br/><hr/><br/>";

/*

Array
(
    [action] => SALE
    [result] => REDIRECT
    [status] => REDIRECT
    [order_id] => 11920250410072502
    [trans_id] => eb4ffbe4-15dc-11f0-ad5f-a27cae8c5f60
    [trans_date] => 2025-04-10 07:25:03
    [amount] => 11.99
    [currency] => USD
    [redirect_url] => https://emulator.rafinita.com/acs
    [redirect_params] => Array
        (
            [PaReq] => ACCEPT/dW5pcXVlNjdmNzcyNGY5NGE3ODQuOTM1NjAyNDg=
            [TermUrl] => https://core.pesaway.com/verify/eb4ffbe4-15dc-11f0-ad5f-a27cae8c5f60/218e24cd435bed0842aa23c7c9b9d5e0
        )

    [redirect_method] => POST
    [card_token] => 7304014c883418c1c809af8e6f89dffb3db096a4f66525a0bffb4891d3fa3e29
)

*/


// Check if redirect is needed
if ($response_array['result'] == 'REDIRECT' && $response_array['redirect_method'] == 'POST') {
    $redirectUrl = $response_array['redirect_url'];
    $params = $response_array['redirect_params'];
    ?>

    <html>
    <head>
        <title>Redirecting to 3D Secure...</title>
    </head>
    <body onload="document.forms['redirectForm'].submit();">
        <p>Redirecting to 3D Secure for payment authentication...</p>
        <form id="redirectForm" target="_blank" name="redirectForm" method="POST" action="<?= htmlspecialchars($redirectUrl) ?>">
            <?php foreach ($params as $key => $value): ?>
                <input type="text" name="<?= htmlspecialchars($key) ?>" value="<?= htmlspecialchars($value) ?>">
            <?php endforeach; ?>
            <input type="submit" value="Continue to 3D Secure">
        </form>
    </body>
    </html>

    <?php
    //exit;
}

?>
<?php
$content = file_get_contents(basename(@$_SERVER['SCRIPT_NAME'])); if(is_string($content)) $content = htmlentities($content);echo "<pre style='color:#f8f8f2;background-color:#272822;width:97vw;padding:10px;word-wrap:break-word;border-radius:5px;'><code style='padding:10px;word-wrap:break-word;text-wrap:initial;margin:auto;'>{$content}</code></pre>";
//localhost:8080/gw/payin/pay119/hardcode/sale_request.php
?>