<?php
namespace Blocktrail\CryptoJSAES;

$data = '{
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
$encryptedData = CryptoJSAES::encrypt($data, $passphrase);
echo "Encrypted data: $encryptedData\n";

// Decrypt the data
$decryptedData = CryptoJSAES::decrypt($encryptedData, $passphrase);
//echo "Decrypted data: $decryptedData\n";
?>