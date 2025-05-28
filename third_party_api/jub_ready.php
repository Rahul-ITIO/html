<?php
// /third_party_api/jub_ready.php
// Juvlon API endpoint
$url = "https://api2.juvlon.com/v5/sendEmail";


// MTA1MTQ1IyMjMjAyNS0wNS0wOCAxNDo1Nzo0Ng== pay api
// MTA1MTUxIyMjMjAyNS0wNS0wOCAxNjo0OTozOQ== payable api

//$email_to = "shivamg@itio.in";
$email_to = "devops@itio.in";
if(isset($_REQUEST['em'])) $email_to = $_REQUEST['em'];

echo "Email_to: $email_to\n";


// JSON payload with your API key and email details
$data_api = json_encode([
    "apiKey" => "MTA1MTUxIyMjMjAyNS0wNS0wOCAxNjo0OTozOQ==",   // paywb api 🔑 Replace with your real API key
    "from" => "it@paywb.co",
    "fromName" => "Dev",
    "to" => $email_to,
    "subject" => "Test Email from PHP using Juvlon API",
    "body" => '<p style="text-align:left;">Dear <b>[username]</b></p><p style="text-align:left;">A request has been received to change your [sitename] account.</p><p style="text-align:left;border-bottom:2px solid #00948f;padding:0px;margin:0px;height:2px;"> </p><p style="text-align:left;padding:20px 0 0 0;">To reset your password, click on the button below:</p><a style="float:unset;width:310px;display:block;color:rgb(255, 255, 255)!important; font-family:Roboto,RobotoDraft,Helvetica,Arial,sans-serif;font-size:22px;font-style: normal;font-weight:400;margin:20px auto 10px auto;padding:10px 30px;border:0px; vertical-align:baseline;background:none left top repeat rgb(0, 148, 143);clear:both;text-decoration:none !important;border-radius:7px;text-align:center;" target="_blank" href="[resetpasswordurl]?c=[confcode]">Reset Password</a><p>Or copy and paste the URL into your browser:</p><p><b>[resetpasswordurl]?c=[confcode]</b></p><p style="text-align:left;border-bottom:2px solid #00948f;padding:0px;margin:20px 0 0 0px;height:2px;"> </p><p style="text-align:left;margin:30px 0 0 0;">Please note that the link will be valid for next 1 hour.</p><p style="text-align:left;padding-top:30px;">Sincerely,</p><p><b>[sitename]</b> Team</p>',
    "trackClicks" => "1",
    "sendWithoutAttachment" => "1"
]);

// Initialize cURL
$ch = curl_init();

curl_setopt($ch, CURLOPT_URL, $url);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, $data_api);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); // ⚠ Only for testing, remove this line on production!

// Set HTTP headers
curl_setopt($ch, CURLOPT_HTTPHEADER, [
    'Content-Type: application/json',
    'Accept: application/json'
]);

// Execute cURL request
$response = curl_exec($ch);

// Get HTTP status code
$http_status = curl_getinfo($ch, CURLINFO_HTTP_CODE);

// Handle cURL errors
if (curl_errno($ch)) {
    echo 'cURL error: ' . curl_error($ch);
} else {
    echo "HTTP Status Code: $http_status\n";
    echo "Response: $response\n";

    // Decode JSON response
    $response_data = json_decode($response, true);
    if ($response_data) {
        if ($response_data['code'] === '200') {
            echo "✅ Email sent successfully. Transaction ID: " . $response_data['transactionId'] . "\n";
        } else {
            echo "⚠ Error: " . $response_data['status'] . " (Code: " . $response_data['code'] . ")\n";
            echo "Transaction ID: " . $response_data['transactionId'] . "\n";
        }
    } else {
        echo "⚠ Failed to decode JSON response.\n";
    }
}

// Close cURL
curl_close($ch);

/*

HTTP Status Code: 200 Response: {"code":"200","status":"Success","transactionId":"15339931"} ✅ Email sent successfully. Transaction ID: 15339931 

*/
