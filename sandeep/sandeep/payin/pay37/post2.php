<?

$tenderId	= "LASI1";
$ClientId	= "b1fd42e9f58618f3a93c059290f1a7b9";
$ClientSecret="6795e1e3ed3546c801f9d857a113f4b9";

$reference = "ZAMPLE".time();

$request = '{
	"request": {
		"header": {
			"requestUUID": "'.$reference.'",
			"channelId": "INT"
		},
		"body": {
			"fetchIECDataReq": {
				"customerTenderId": "'.$tenderId.'"
			}
		}
	}
}';


echo $request.'<br /><br />';

$RANDOMNO1='1212121234483448';
$RANDOMNO2='1212665234483448';

$fp = fopen('indusinduat-publickey.txt', 'r');
$pub_key= fread($fp, 8192);
fclose($fp);

//openssl_get_publickey($pub_key);
//openssl_public_encrypt($RANDOMNO1, $encrypted_key, $pub_key);
$encrypted_key = hash('sha256', $pub_key);

//$encrypted_data = openssl_encrypt($request, 'AES-256-CBC', $encrypted_key, 0, $iv);
$encrypted_data = openssl_encrypt($request, 'AES-256-CBC', $RANDOMNO1, OPENSSL_RAW_DATA, $RANDOMNO2);
//$encrypted_data = openssl_encrypt($request, 'RSA-OAEP-256', $RANDOMNO1, OPENSSL_RAW_DATA, $RANDOMNO2);

$postbody= [
	"data" => base64_encode($encrypted_data),
	"key" => base64_encode($encrypted_key),
	"bit" => 0,
];
print_r($postbody);	


$headers = array(
	"content-type: application/json", 
	"IBL-Client-Id:$ClientId",
	"IBL-Client-Secret: $ClientSecret"
);

//print_r($headers);exit;
$url = 'https://indusapiuat.indusind.com/indusapi-np/uat/iec/etender/getTenderId/v1';

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

echo '<br /><br />Response: '.$raw_response;

//echo $request = json_decode($raw_response);
?>