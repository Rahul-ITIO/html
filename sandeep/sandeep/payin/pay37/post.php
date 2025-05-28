<?

$tenderId = "LASI1";

$ClientId	="b1fd42e9f58618f3a93c059290f1a7b9";
$ClientSecret="6795e1e3ed3546c801f9d857a113f4b9";

$reference = "NET81".time();

$request = '{
  "request": {
    "header": {
      "requestUUID": "'.$reference.'",
      "channelId": "IND"
    },
    "body": {
      "fetchIECDataReq": {
        "customerTenderId": "'.$tenderId.'"
      }
    }
  }
}
';

$fp = fopen('indusinduat-publickey.txt', 'r');
$pub_key= fread($fp, 8192);
fclose($fp);

$RANDOMNO1 = "1212121234483448";
$RANDOMNO2 = '1234567890123456';

openssl_get_publickey($pub_key);

openssl_public_encrypt($RANDOMNO1, $encrypted_key, $pub_key);
$encrypted_data = openssl_encrypt($request, 'AES-256-CBC', $RANDOMNO1, OPENSSL_RAW_DATA, $RANDOMNO2);
//echo $encrypted_data = openssl_encrypt($request, 'RSA-256-OAEP', $RANDOMNO1, OPENSSL_RAW_DATA, $RANDOMNO2);


$postbody= [
	"data" => base64_encode($encrypted_key),
	"key" => base64_encode($encrypted_data),
	"bit" => 0,
];
?>