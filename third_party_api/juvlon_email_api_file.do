<?
//$qp=1;

if(isset($_REQUEST['qp'])) $qp = $_REQUEST['qp'];


$post['json_value']['mail_api_name']='juvlon';

##############################################

//$email_message=htmlentitiesf($email_message);
//$email_message=stripslashes($email_message);
//$email_message=str_replace(utf8_encode("Â"),"",$email_message);

/*
$email_message=ltrim($email_message,'"');
$email_message=rtrim($email_message,'"');
$email_message="'".($email_message)."'";
*/

/*

$email_message=str_replace('\\', '', $email_message);
$email_message=addslashes($email_message);

$email_message=preg_replace('/\n+|\t+|\s+/',' ',$email_message);
$email_message=str_replace( array( "style='","'>" ), array( 'style="','">' ), $email_message);
$email_message=str_replace( array( "’","'","’","{","}","�" ), ' ', $email_message);

*/


//$email_message=mb_detect_encoding($email_message, 'UTF-8');
//$email_message=mb_detect_encoding($email_message, ['ASCII', 'UTF-8', 'ISO-8859-1'], true);
//$email_message=filter_var($email_message, FILTER_SANITIZE_EMAIL);
//$email_message=html_entity_decode($email_message);

$email_subject=($email_subject);

//ob_start("prepare");

$url_juvlon_api = "https://api2.juvlon.com/v5/sendEmail";


$mail_juvlon_api_key="MTA1MTUxIyMjMjAyNS0wNS0wOCAxNjo0OTozOQ==";

if(isset($mail_juvlon_api)) $mail_juvlon_api_key = $mail_juvlon_api;
if(isset($email_message)) $email_message_data = rawurlencode($email_message);

if (isset($email_message)) {
    // Add slashes to escape forward slashes (for \/h1 and \/p)
    //$email_message = str_replace("/", "\\/", $email_message);
    // Now encode it
    //$email_message_data = rawurlencode($email_message);

    $email_message_data = $email_message;
}


if (isset($email_message_XX)) {
    // Step 1: Escape double quotes
    $email_message_safe = str_replace('"', '\"', $email_message);

    // Step 2: Escape forward slashes
    $email_message_safe = str_replace('/', '\\/', $email_message_safe);

    // Step 3: URL-encode the entire message (converts <, >, etc.)
    $email_message_data = rawurlencode($email_message_safe);
}


// MTA1MTQ1IyMjMjAyNS0wNS0wOCAxNDo1Nzo0Ng== pay api
// MTA1MTUxIyMjMjAyNS0wNS0wOCAxNjo0OTozOQ== payable api

//$email_to = "devops@itio.in";
if(isset($_REQUEST['em'])) $email_to = $_REQUEST['em'];

if(@$qp) echo "Email_to: $email_to\n";


// JSON payload with your API key and email details
$data_juvlon_api = json_encode([
    "apiKey" => @$mail_juvlon_api_key,   // paywb api 🔑 Replace with your real API key
    "from" => @$email_reply, // "it@paywb.co"
    "fromName" => @$email_to,
    "to" => @$email_to,
    "subject" => @$email_subject,
    "body" => @$email_message_data,
    "trackClicks" => "1",
    "sendWithoutAttachment" => "1"
]);

// Initialize cURL
$ch = curl_init();

curl_setopt($ch, CURLOPT_URL, $url_juvlon_api);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, $data_juvlon_api);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); // ⚠ Only for testing, remove this line on production!
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false); // ⚠ Only for testing, remove this line on production!

// Set HTTP headers
curl_setopt($ch, CURLOPT_HTTPHEADER, [
    'Content-Type: application/json',
    'Accept: application/json'
]);

// Execute cURL request
$result = curl_exec($ch);

// Get HTTP status code
$http_status = curl_getinfo($ch, CURLINFO_HTTP_CODE);

// Handle cURL errors
if (curl_errno($ch)) {
    echo $post['response_status']='cURL error: ' . curl_error($ch) . @$result;
    
} else {
    if(@$qp) 
    {
        echo "HTTP Status Code: $http_status\n";
        echo "Response: $result\n";
    }

    // Decode JSON response
    $response_data = json_decode($result, true);
    if ($response_data) {
        if ($response_data['code'] === '200') {
            $email_to_mask=mask_email($email_to);
            $result=str_ireplace($email_to, $email_to_mask, $result );
            $post['response_status']="Queued. Thank you.";
            
           if(@$qp) echo "✅ Email sent successfully. Transaction ID: " . $response_data['transactionId'] . "\n";
        } else {
            if(@$qp) 
            {
                echo "⚠ Error: " . $response_data['status'] . " (Code: " . $response_data['code'] . ")\n";
                echo "Transaction ID: " . $response_data['transactionId'] . "\n";
            }
        }
    } else {
        if(@$qp) echo "⚠ Failed to decode JSON response.\n";
        $post['response_status']=@$result;
    }
}

// Close cURL
curl_close($ch);


##############################################

/*

HTTP Status Code: 200 Response: {"code":"200","status":"Success","transactionId":"15339931"} ✅ Email sent successfully. Transaction ID: 15339931 

*/

##############################################


if(@$qp)
{
	echo "<hr/>mail_api_name=>".$post['json_value']['mail_api_name'];
	echo "<hr/>email_url=>".$url_juvlon_api;
	echo "<hr/>mail_juvlon_api_key=>".$mail_juvlon_api_key;
	
	echo "<br/><br/><hr/>email_to=>".$email_to;
		//echo "<hr/>email_from=>".$email_from;
	echo "<hr/>email_reply=>".$email_reply;
	echo "<hr/>email_subject=>".$email_subject;
	echo "<hr/>email_message=>".$email_message;
	
	echo "<br/><br/><hr/>result=>".($result);
	//echo "<br/><br/><hr/>json_decode=>"; var_dump($json_decode);
}

exit;
?>