<?php 
//  https://aws-cc-uat.web1.one/enc/decode_encryption_method_aes256.php

// Decode AES-256-CBC encrypted webhook response

$website_public_key = "MjcyXzEwXzIwMjQwNjA0MTcwMzIw"; // Should be your public_key
$private_key = "MjcyXzIwMjMwOTI2MTIxMzUx";       // Should be your private_key


if(isset($_REQUEST['public_key'])) {
    $website_public_key = $_REQUEST['public_key'];
}

if(isset($_REQUEST['private_key'])) {
    $private_key = $_REQUEST['private_key'];
}


// Enable error reporting
error_reporting(E_ALL);
ini_set('display_errors', '1');
ini_set('max_execution_time', 0);

/**
 * Decrypt AES-256-CBC encrypted string
 *
 * @param string $string Encrypted string
 * @param string $private_key Private key for decryption
 * @param string $public_key Public key to derive IV
 * @return string|false Decrypted string or false on failure
 */
function data_decodef($string,$private_key,$website_public_key) {	//decode string which encode via AES-256-CBC hash with private_key and token
    $output = false;
    $encrypt_method = "AES-256-CBC";	//encrypt method
    $iv = substr( hash( 'sha256', $website_public_key ), 0, 16 );
	$output = openssl_decrypt( base64_decode( $string ), $encrypt_method, $private_key, 0, $iv );
    return $output;
}



// Replace with your actual webhook response from @$_REQUEST['encryption_data']
// $webhook_response_encrypted = @$_REQUEST['encryption_data'];
$webhook_response_encrypted = "M01WbzZycnpoYlZuRVE2UXhYdFlBNE5ISExrYnRqS2hXREg5d3pSa2RJVUN0YitjVloyV0pNTGg5RVV6UlJZU1FSeVFUZm8rMGpiZVVjOWNka0FDaWN1eVdsSGRReUJadG5MN2NXb0lNMnhiOWRTSVVXN0l0MnVubThwRWRNUGNxNVVMazB5am9iMTZMZ2QzelE4aHEvU0x5RUZpU3dIOEczeXZ5bmhsK0FhMXNrSWkzMy80Z0VFU2dxOHBrY2FkUkNrZU1NVEtWa0szS1luM0tKVEFxSlJIS2NFNkdEQmg3SXk3SVJWZEs2MXp1K1N4VGZBNmtjSmhacFVoYXZ2SVdBcnFRa0Y0ZHQrRldkSFpXL2ZnLzdtUVNGSG5yd2wyajBuVHlnUHJCb0dSN010OHpRTkgxUjNHQTJIYUFPSkd6dGVTT1k1L01KRHhBUVllN2ZjRW0rNWxOeDBtcXNhQ01MYTMrU2kxM1kxYzhzUlJoZ0J1a0huRkJaczFNYTZTcVU0TXRVUFVQcVIxQnNNeDVCTWlsK0d1eEZ2OUxDTGtadUM0bUpuVlIvUm5mbmRzMGQ3MVJrTUI3d3ZXQ0NrSFBYcjEwOGwwQWRpVDNKU203aFh5K2ZybG0wcXRiTlFTcWFTZ1c0MTUvUnEyem9haDhwa0pnNDkrb0dnWWFMWEI";

if(isset($_REQUEST['encryption_data'])) {
    $webhook_response_encrypted = $_REQUEST['encryption_data'];
}

echo "<h2>Webhook Response (Encrypted)</h2>";
echo "<pre>$webhook_response_encrypted</pre>";

// Decode the webhook response
$decoded = data_decodef($webhook_response_encrypted, $private_key, $website_public_key);

echo "<h3>Decoded Webhook Response (Raw & Subquery Pram)</h3>";
echo "<pre>$decoded</pre>";

// Decode JSON
parse_str($decoded,$decoded_array);

echo "<h3>Decoded Webhook Response (Array)</h3>";
echo "<pre>";
print_r($decoded_array);
echo "</pre>";

if(!isset($_REQUEST['encryption_data'])) 
{
    $content = file_get_contents(basename(@$_SERVER['SCRIPT_NAME'])); if(is_string($content)) $content = htmlentities($content);echo "<br/><br/><pre style='color:#f8f8f2;background-color:#272822;width:97vw;padding:10px;word-wrap:break-word;border-radius:5px;'><code style='padding:10px;word-wrap:break-word;text-wrap:initial;margin:auto;'>{$content}</code></pre>";
}

?>
