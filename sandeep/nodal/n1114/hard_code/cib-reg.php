<?
$url	= 'https://apibankingone.icicibank.com/api/Corporate/CIB/v1/Registration';

$cib	= 'mEyFnBO1vVoSoCkW6osC4qBtBC8yWoDI';
$apiKey = "1aS5HPwjzKv5S8xCrMsO4z4EHiiziAPh";

$fp = fopen('../live_SKYWALK_CIB_CERT.cer', 'r');
$pub_key= fread($fp, 8192);
fclose($fp);


$data = '{
"AGGRID":"CUST0813",
"CORPID":"584286151",
"USERID":"TISUVERM",
"URN":"sky1001",
"AGGRNAME":"SKYWALK",
"ALIASID":""
}';

$RANDOMNO1 = "1212121234483448";
$RANDOMNO2 = '1234567890123456';

openssl_get_publickey($pub_key);

openssl_public_encrypt($RANDOMNO1, $encrypted_key, $pub_key);
$encrypted_data = openssl_encrypt($data, 'AES-128-CBC', $RANDOMNO1, OPENSSL_RAW_DATA, $RANDOMNO2);

$postbody= [
	"requestId" => "req_".time(),
	"service" => "",
	"encryptedKey" => base64_encode($encrypted_key),
	"oaepHashingAlgorithm" => "NONE",
	"iv" => base64_encode($RANDOMNO2),
	"encryptedData" => base64_encode($encrypted_data),
	"clientInfo" => "",
	"optionalParam" => ""
];

//echo json_encode($postbody);
//die;

$headers = array(
	"Content-type: application/json", 
//	"x-forwarded-for:65.1.5.130", //to be change 
	"apikey:$cib",
//	"x-priority: 0100";
);

$log_path="../../../log/";

$file = $log_path.'composite_log.txt';

$log = "\n\n".'GUID - '.time()."================================================================\n";
$log .= 'URL - '.$url."\n\n";
$log .= 'HEADER - '.json_encode($headers)."\n\n";
$log .= 'REQUEST - '.$data."\n\n";
$log .= 'REQUEST ENCRYPTED - '.json_encode($postbody)."\n\n";

echo nl2br($log);

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
$fp= fopen("../live_privatekey.key","r");
$priv_key=fread($fp,8192);
fclose($fp);
$res = openssl_get_privatekey($priv_key, "");
openssl_private_decrypt(base64_decode($request->encryptedKey), $key, $res);
$encData = base64_decode($request->encryptedData); 
$encData = openssl_decrypt($encData,"aes-128-cbc",$key,OPENSSL_PKCS1_PADDING);
$newsource = substr($encData, 16); 

//echo $raw_response;

$log = "\n\n".'GUID - '.time()."================================================================ \n";
$log .= 'RESPONSE - '.$raw_response."\n\n";
$log .= 'RESPONSE DECRYPTED - '.$newsource."\n\n";

//file_put_contents($file, $log, FILE_APPEND | LOCK_EX);
echo nl2br($log);

//check registration status
$request = json_decode($raw_response);
$fp= fopen("../live_privatekey.key","r");
$priv_key=fread($fp,8192);
fclose($fp);
$res = openssl_get_privatekey($priv_key, "");
openssl_private_decrypt(base64_decode($request->encryptedKey), $key, $res);
$encData = base64_decode($request->encryptedData); 
$encData = openssl_decrypt($encData,"aes-128-cbc",$key,OPENSSL_PKCS1_PADDING);

echo $newsource = substr($encData, 16); 
die;


?>