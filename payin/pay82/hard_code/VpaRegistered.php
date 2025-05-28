<?php
namespace Blocktrail\CryptoJSAES;

// http://localhost:8080/gw/payin/pay82/hard_code/VpaRegistered.php

error_reporting(-1); // reports all errors
ini_set("display_errors", "1"); // shows all errors
ini_set("log_errors", 1);
ini_set("error_log", "php-error.log");

abstract class CryptoJSAES {

    /**
     * @param      $data
     * @param      $passphrase
     * @param null $salt        ONLY FOR TESTING
     * @return string           encrypted data in base64 OpenSSL format
     */
    public static function encrypt($data, $passphrase, $salt = null) {
        $salt = $salt ?: openssl_random_pseudo_bytes(8);
        list($key, $iv) = self::evpkdf($passphrase, $salt);

        $ct = openssl_encrypt($data, 'aes-256-cbc', $key, true, $iv);

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

        $data = openssl_decrypt($ct, 'aes-256-cbc', $key, true, $iv);

        return $data;
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

###################################################################################

//vpa request header via body


$headeRequest = '{
"PartnerId":524,
"AuthKey":"f9f1da40-4f0a-473a-8693-c388301e95b7"
}';

//$headeRequest = '{"PartnerId":524,"AuthKey":"f9f1da40-4f0a-473a-8693-c388301e95b7"}';

//Header_Encryption_Key
$Header_Encryption_Key = '982b0d01-b262-4ece-a2a2-45be82212ba1';

echo "<hr/><br/><b style='font-size:18px'>Header_Encryption_Key via header:</b><br/> $Header_Encryption_Key\n";

    

$encryptedDataHeader = CryptoJSAES::encrypt($headeRequest,  $Header_Encryption_Key);//header encrypted request
echo "<hr/><br/>Encrypted Header Dynamic:<br/> $encryptedDataHeader\n";

//$encryptedDataHeader = "U2FsdGVkX1+nv02ZyJGNe5CDBJsXreELz3mZa2/RNnotKpp2ZTPHIMmmzaFKRVLc+qPgtDsmATGclOJM2oUtCcWZDQr1sNVyCzgLXCGDIjt/CYLsjn8z6FA0GNQWo+ZO";//header encrypted request

$decryptedData = CryptoJSAES::decrypt($encryptedDataHeader,  $Header_Encryption_Key);

echo "<hr/><br/>Encrypted Header:<br/> $encryptedDataHeader\n";
echo "<hr/><br/>Decrypted Header:<br/> $decryptedData\n";

//exit;


###################################################################################

//vpa request data via body

$dataVPA = '{
"clientTxnId": "132072023112178",
"serviceId": "9001",
"mobilenumber": "918788693162",
"vpasubstring": "deepti",
"firstname": "deepti",
"lastname": "tyagi",
"accountnumber": "6411978921",
"ifsc": "KKBK0000638",
"accounttype": "SAVINGS",
"mcccode": "7407",
"franchisename": "TV Showroom - Kharghar",
"brandname": "FINO UPI",
"Settlement_Account": "232132322424212",
"Settlement_IFSC": "FINO00111123",
"Bank_Name": "Fino payments Bank",
"Bene_Name": "Rahul Shetty",
"MDR_Per": "1",
"Minimum_Charge": "0.01",
"MDR_Type": "P"
}';

//Encryption_Decryption_Key

//$passphrase = "2a8dbe2c-0b6d-4ee1-91e8-c182234f710f"; // test key
$passphrase = "97604492-a0bc-4d3e-82b5-6ad34bb5a32b"; // live key
echo "<hr/><br/><b style='font-size:18px'>Encryption_Decryption_Key for request vpa data via  body:</b><br/> $passphrase\n";



  // Encrypt the data
$encryptedData = CryptoJSAES::encrypt($dataVPA, $passphrase);
echo "<hr/><br/>Encrypted request dataVPA:<br/> $encryptedData\n";

// Decrypt the data
$decryptedData = CryptoJSAES::decrypt($encryptedData, $passphrase);
echo "<hr/><br/>Decrypted request dataVPA:<br/> $decryptedData\n";


###################################################################################

$vpaUrl = trim('https://upipay.finopaymentbank.in/UPIUIRegService/UPIUIRegService.svc/UPIUIRegRequest');

echo "<hr/><br/>vpaUrl: $vpaUrl\n";

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => $vpaUrl,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_SSL_VERIFYPEER => 0,
  CURLOPT_SSL_VERIFYHOST => 0,
  CURLOPT_HEADER => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>'"'.$encryptedData.'"',
  CURLOPT_HTTPHEADER => array(
    'Authentication: '.$encryptedDataHeader,
    'Content-Type: application/json'
  ),
));

$response = curl_exec($curl);

curl_close($curl);

$req = json_decode($response,1);

echo "<hr/><br/>response: $response\n";

echo "<hr/><br/>response json_decode:\n";
print_r(@$req);

$ResponseData = @$req['ResponseData'];
$ClientTxnId = @$req['ClientTxnId'];

//echo "<hr/><br/>error:";

$decryptedData = CryptoJSAES::decrypt($ResponseData, $passphrase);

echo "<hr/><br/>decryptedData: $decryptedData\n";



###################################################################################
/*

{
    "status": {
        "code": "0",
        "message": "SUCCESS"
    },
    "id": "7195306953115639808",
    "vpa_id": "7195306953136611328",
    "merchant_id": "7195306953124028416",
    "VPA": "sky.deepti@finobank"
}

response: {"ClientTxnId":"132072023112178","ResponseCode":"0","ResponseMessage":"Create Merchant and VPA Generation Success","ResponseData":"U2FsdGVkX19IwxGnutHFpCm54xK84pBpsZG7NBCqY9E6EyPtSZ3XRhpf404GtKWrxrocAP7XFpN7GpWhFFvA6Vrj\/weaOoDdG\/W919eS0DgloAqEhGY0Daa5m34B5cbTU\/zFwn1CpWy2vfcR7oUMIYGRHe+O021j2vS9frhv4twdAF\/QNNmxEUDvSmwjyGLDnOFEWybWpi382+wFFJMZHjr\/ylD+ZUWlu+jfWL0B7qe8BA08\/4B9gX6oeqc8IqIy"}

response json_decode: Array ( [ClientTxnId] => 132072023112178 [ResponseCode] => 0 [ResponseMessage] => Create Merchant and VPA Generation Success [ResponseData] => U2FsdGVkX19IwxGnutHFpCm54xK84pBpsZG7NBCqY9E6EyPtSZ3XRhpf404GtKWrxrocAP7XFpN7GpWhFFvA6Vrj/weaOoDdG/W919eS0DgloAqEhGY0Daa5m34B5cbTU/zFwn1CpWy2vfcR7oUMIYGRHe+O021j2vS9frhv4twdAF/QNNmxEUDvSmwjyGLDnOFEWybWpi382+wFFJMZHjr/ylD+ZUWlu+jfWL0B7qe8BA08/4B9gX6oeqc8IqIy ) 


decryptedData: {"status":{"code":"0","message":"SUCCESS"},"id":"7195306953115639808","vpa_id":"7195306953136611328","merchant_id":"7195306953124028416","VPA":"sky.deepti@finobank"} 

*/

###################################################################################

?>