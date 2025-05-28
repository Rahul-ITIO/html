<?php 
//  https://aws-cc-uat.web1.one/enc/decode_encryption_method_aes256_2.php

// Decode AES-256-CBC encrypted webhook response

$website_public_key = "MjcyXzEwXzIwMjQwNjA0MTcwMzIw"; // Should be your public_key
$private_key = "MjcyXzIwMjMwOTI2MTIxMzUx";       // Should be your private_key

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
function data_decodef($string,$private_key,$website_public_key) {
    $output = false;
    $encrypt_method = "AES-256-CBC";	//encrypt method
    $iv = substr( hash( 'sha256', $website_public_key ), 0, 16 );
	$output = openssl_decrypt( base64_decode( $string ), $encrypt_method, $private_key, 0, $iv );
    return $output;
}


// Replace with your actual webhook response from @$_REQUEST['encryption_data']
//$webhook_response_encrypted = @$_REQUEST['encryption_data'];
$webhook_response_encrypted = "cS92L3ZIRVhXZmVIZnVqaThtWHhmWUdwMVN5Z2Z0ZFpnV2ExTXdLNDA0RDl4ZHNNd1ViL3FtQUY5TnhMaWpLckRxNDZ6RjJEVTFYUnVMU0NPVXVrYjQ3LzFSUjVwSjVvYytDdm04MUF1Q1F5eVV3Z3daWjQ3c3huMTdqK0ExVlB6a0xXaE81dG8veklGbXErWU5hUG9lbUplNlFPSHJDWFlGelhKVk1LWkRwbmZKZkVhQm0rekNtREhuazk2ZjIzbWIyM1ErSi9uRFEvZzdZR0Z1TnlQaXJtMndmZDZjZVJLTDY1cm5EZmVuQTI2cjkxRVpjWlBCQi9HejlpWnlFSWxJU0ptOXQwSHEwdWJNS0ZyL3Y0dmtjKzBGTGZ2VS9Vd3Rtc2taNlNyOXVjNVNJVjdFT255NzJXcnZWcVdhaURGMGRBNTZNQ1hXaW5XS1dDVW1hTG1xR01sMWlSbmwvNDJkcTNxcEZYeS9YQmdVN3ErQnNrcVFTRWhkZW4xWDFQQlJYSlNiRnZHTkxRZnA1dEQ5Snp5UUE2bTgvaWR0OTRvRko1UzZ3aDZGR2VPaGVkTnZFUkFxdGhzQ3lUWm9PYnhrMUZtazlNMHIxVEFQZDdNamVXcFVwcnA5akpNUVlucUs1ckxDVG0vb0k9";

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



$content = file_get_contents(basename(@$_SERVER['SCRIPT_NAME'])); if(is_string($content)) $content = htmlentities($content);echo "<br/><br/><pre style='color:#f8f8f2;background-color:#272822;width:97vw;padding:10px;word-wrap:break-word;border-radius:5px;'><code style='padding:10px;word-wrap:break-word;text-wrap:initial;margin:auto;'>{$content}</code></pre>";


?>
