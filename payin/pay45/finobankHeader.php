<?php
namespace Blocktrail\CryptoJSAES;

$headeRequest ='{
"PartnerId":524,
"AuthKey":"392f9d10-9caa-43b5-956b-aeacda9e1e34"
}';
//echo $headeRequest;
//exit;
 $passphrase ="982b0d01-b262-4ece-a2a2-45be82212ba1";



abstract class CryptoJSAES {
    /**
     * @param      $data
     * @param      $passphrase
     * @param null $salt        ONLY FOR TESTING
     * @return string           encrypted data in base64 OpenSSL format
     */
    public static function encrypt($request, $passphrase, $salt = null) {
        $salt = $salt ?: openssl_random_pseudo_bytes(8);
        list($key, $iv) = self::evpkdf($passphrase, $salt);

        $ct = openssl_encrypt($request, 'aes-256-cbc', $key, true, $iv);

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

        $Decrypdata = openssl_decrypt($ct, 'aes-256-cbc', $key, true, $iv);

        return $Decrypdata;
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
$encryptedData = CryptoJSAES::encrypt($headeRequest, $passphrase);
echo "Encrypted data: $encryptedData\n";

// Decrypt the data
$decryptedData = CryptoJSAES::decrypt($encryptedData, $passphrase);
//echo "Decrypted data: $decryptedData\n";
?>