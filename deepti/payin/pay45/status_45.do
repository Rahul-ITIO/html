<?
$is_curl_on=true;

if(isset($_REQUEST['orderId'])){
    $_REQUEST['transID']=$_REQUEST['orderId'];
}

if(!isset($data['STATUS_ROOT'])){
    include('../../../config_db.do');
    include($data['Path'].'/payin/status_top'.$data['iex']);
}


 $headeRequest = '{
"PartnerId":' . $apc_get['PartnerId'] . ',
 "AuthKey":"' . $apc_get['AuthKey'] . '"
}';

$passphrase = $apc_get['Header_Encryption_Key'];


abstract class CryptoJSAES {

    /**
     * @param      $data
     * @param      $passphrase
     * @param null $salt        ONLY FOR TESTING
     * @return string           encrypted data in base64 OpenSSL format
     */
    public static function encrypt($Request, $passphrase, $salt = null) {
        $salt = $salt ?: openssl_random_pseudo_bytes(8);
        list($key, $iv) = self::evpkdf($passphrase, $salt);

        $ct = openssl_encrypt($Request, 'aes-256-cbc', $key, true, $iv);

        return self::encode($ct, $salt);
    }

    /**
     * @param string $base64        encrypted data in base64 OpenSSL format
     * @param string $passphrase
     * @return string
     */
    public static function decrypt($base64, $passphrase) {
        list($ct, $salt) = self::decode($base64);
        list($key, $iv) = self::evpkdf($passphrase, $salt);

        $Decryptdata = openssl_decrypt($ct, 'aes-256-cbc', $key, true, $iv);

        return $Decryptdata;
    }

    public static function evpkdf($passphrase, $salt) {
        $salted = '';
        $dx = '';
        while (strlen($salted) < 48) {
            $dx = md5($dx . $passphrase . $salt, true);
            $salted .= $dx;
        }
        $key = substr($salted, 0, 32);
        $iv = substr($salted, 32, 16);

        return [$key, $iv];
    }

    public static function decode($base64) {
        $data = base64_decode($base64);

        if (substr($data, 0, 8) !== "Salted__") {
            throw new \InvalidArgumentException();
        }

        $salt = substr($data, 8, 8);
        $ct = substr($data, 16);

        return [$ct, $salt];
    }

    public static function encode($ct, $salt) {
        return base64_encode("Salted__" . $salt . $ct);
    }
}
  #################################################################################################################
    $encryptedDataHeader = CryptoJSAES::encrypt($headeRequest,  $passphrase);//header encrypted request
  $decryptedData = CryptoJSAES::decrypt($encryptedDataHeader,  $passphrase);
if(!empty($transID))
{
 echo $passphraseStatus = $apc_get['Encryption_Decryption_Key'];
 
 
 $dataRequest = '{
"clientTxnId": "'.$transID.'",
"serviceId": "9071",
"mobileno": "919830093724",
"referenceid": "FINOUPI640543"
}';

echo $dataRequest;
   $encryptedStatus = CryptoJSAES::encrypt($dataRequest, $passphraseStatus);//vpa encrypted request


 $curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => trim($acquirer_status_url),
  
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>'"'. $encryptedStatus.'"',
  CURLOPT_HTTPHEADER => array(
    'Authentication: '.$encryptedDataHeader,
    'Content-Type: application/json'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;
}


if(!isset($data['STATUS_ROOT'])){
    include($data['Path'].'/payin/status_bottom'.$data['iex']);
}


?>