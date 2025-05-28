<?php
namespace Blocktrail\CryptoJSAES;

 $IntentRequest='{
    "clientTxnId": "8267897854347",
    "serviceId": "9075",
    "mobilenumber": "918303344556",
    "txnAmount": "2",
    "txnNote": "FINOIntent",
    "payeeVPA": "sky.arun@fin",
    "txnReference": "REF20240528058987",
    "ExpiryTime": "25"
}';


/*$VapRequest='{
    "clientTxnId": "132072023112165",
    "serviceId": "9001",
    "mobilenumber": "918788693162",
    "vpasubstring": "arun",
    "firstname": "arun",
    "lastname": "UPITest",
    "accountnumber": "6411978921",
    "ifsc": "KKBK0000638",
    "accounttype": "SAVINGS",
    "mcccode": "7407",
    "franchisename": "TV Showroom - Kharghar",
    "brandname": "FINO UPI",
    "Settlement_Account": "232132322424212",
    "Settlement_IFSC": "FINO0011112",
    "Bank_Name": "Fino payments Bank",
    "Bene_Name": "Rahul Shetty",
    "MDR_Per": "1",
    "Minimum_Charge": "0.01",
    "MDR_Type": "P"
}';*/
// To ensure the JSON is correctly formatted, you can decode it and encode it again
$jsonDecoded = json_decode($IntentRequest, true);
if (json_last_error() !== JSON_ERROR_NONE) {
    die("JSON Error: " . json_last_error_msg());
}

$statusRequest = json_encode($jsonDecoded);

// Now you can use $statusRequest as needed
//echo $statusRequest;
//exit;

 $passphrase = "2a8dbe2c-0b6d-4ee1-91e8-c182234f710f";
 



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
  // Encrypt the data
  echo $encryptedData = CryptoJSAES::encrypt($IntentRequest, $passphrase);
 $request = $encryptedData;
 //echo $request;
//Decrypt the response data
$decryptedData = CryptoJSAES::decrypt("U2FsdGVkX18w3rumccBUbvmVpRRA8QJqUrrCZYaR8uByP9bcwd9rMSBuL5B/+C/SG0zPU2xXw1V3CRHnJxrm0jV2zSb0K5jZ0NqbPzzttX1YzkLF/XVonBmXcYFZ/XiPw79C8I2iIXv7/ohZl4AEkLqhiJSkrEkilXX65cYZXcjwLYUfN81ZCXuR5koWg8XR6ATt2njIc0iuNspkj5Ia/Gblo+Yebzr2avhx+gLuRk53/Rbhu944U5kKEarFhBEWPa+e3zp2ydVxVCdPGaRLJHo+an0vVZk1GoL9J1ybdjYScFULKJJgaJhkg41pM/WrB0UCCOYzAlBwk6BvEt94GEubWb05olLv32I94XfURVNADWijC3AQtAmrqOIay44Q", $passphrase);
echo $decryptedData;
// Decrypt the data

?>