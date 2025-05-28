<?php
namespace Blocktrail\CryptoJSAES;

//Status Payload
 $statusRequest = '{
    "clientTxnId": "8291802152",
    "serviceId": "9071",
    "mobileno": "918788693162",
    "referenceid": "FINOUPI821117924"
}';

// To ensure the JSON is correctly formatted, you can decode it and encode it again
$jsonDecoded = json_decode($statusRequest, true);
if (json_last_error() !== JSON_ERROR_NONE) {
    die("JSON Error: " . json_last_error_msg());
}

$statusRequest = json_encode($jsonDecoded);

// Now you can use $statusRequest as needed
//echo $statusRequest;
//exit;

 $passphrase = "97604492-a0bc-4d3e-82b5-6ad34bb5a32b";
 



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
  echo $encryptedData = CryptoJSAES::encrypt($statusRequest, $passphrase);
 $request = $encryptedData ;
 //echo $request;
//Decrypt the response data
$decryptedData = CryptoJSAES::decrypt("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", $passphrase);
echo "Decrypted data: $decryptedData\n";
// Decrypt the data

?>