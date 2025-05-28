<?

$apiKey = "HOxY8jy74toUiMe1siO2hl3XDIy7DwOV";
$MID = 409229;
$terminalId = 5411;
$amount		= 1;
$reference	= 'order'.time();

$url = "https://apibankingonesandbox.icicibank.com/api/MerchantAPI/UPI/v0/QR3/{$MID}";

$postData = array();
$postData['merchantTranId']			=$reference;
$postData['amount']					=$amount;
$postData['merchantId']				=$MID;
$postData['terminalId']				=$terminalId;
$postData['billNumber']				="ICIC".time();
$postData['validatePayerAccFlag']	="ankit13182@icici";
$postData['payerAccount']			="lets.pe@icici";
$postData['payerIFSC']				="216225411";

//$fp = fopen('../test_merchantEncryption.pem', 'r');
$fp = fopen('Skywalk_PublicCerti.crt', 'r');

$pub_key= fread($fp, 8192);
fclose($fp);

$RANDOMNO1 = "1212121234483448";
$RANDOMNO2 = '1234567890123456';

openssl_get_publickey($pub_key);

openssl_public_encrypt($RANDOMNO1, $encrypted_key, $pub_key);
$encrypted_data = openssl_encrypt(json_encode($postData), 'AES-128-CBC', $RANDOMNO1, OPENSSL_RAW_DATA, $RANDOMNO2);

$postbody= [
	"requestId" => $reference,
	"service" => "",
	"encryptedKey" => base64_encode($encrypted_key),
	"oaepHashingAlgorithm" => "NONE",
	"iv" => base64_encode($RANDOMNO2),
	"encryptedData" => base64_encode($encrypted_data),
	"clientInfo" => "",
	"optionalParam" => ""
];

$headers = array(
	"content-type: application/json", 
	"apikey:$apiKey"
);

$file = 'composite_log.txt';

$log = "\n\nGUID - ".$reference."================================================================\n";
$log.= 'URL - '.$url."\n\n";
$log.= 'HEADER - '.json_encode($headers)."\n\n";
$log.= 'REQUEST - '.json_encode($postData)."\n\n";
$log.= 'REQUEST ENCRYPTED - '.json_encode($postbody)."\n\n";

//file_put_contents($file, $log, FILE_APPEND | LOCK_EX);

$curl = curl_init($url);
curl_setopt($curl, CURLOPT_URL, $url);
curl_setopt($curl, CURLOPT_POST, true);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($postbody));

$raw_response = curl_exec($curl);
$httpcode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
$err = curl_error($curl);
curl_close($curl);

$request = json_decode($raw_response);
$fp= fopen("../test_privatekey.key","r");
$priv_key=fread($fp,8192);
fclose($fp);
$res = openssl_get_privatekey($priv_key, "");
openssl_private_decrypt(base64_decode($request->encryptedKey), $key, $res);
$encData = base64_decode($request->encryptedData); 
$encData = openssl_decrypt($encData,"aes-128-cbc",$key,OPENSSL_PKCS1_PADDING);

$newsource = substr($encData, 16); 

$log.= "\n\nGUID - ".$reference."================================================================\n";
$log.= "RESPONSE - ".$raw_response."\n\n";
$log.= "RESPONSE DECRYPTED - ".$newsource."\n\n";

echo nl2br($log);
//	file_put_contents($file, $log, FILE_APPEND | LOCK_EX);

//CHECK STATUS
//echo '<a href="status.php?reference='.$reference.'">Check Status</a>';
exit;
?>