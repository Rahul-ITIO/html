<?php
namespace Blocktrail\CryptoJSAES;

$data = '{
"clientTxnId": "45166213",
"serviceId": "9072",
"txnAmount": "10.00",
"txnNote": "Test Product",
"payeeVPA": "sky.shivam@fin",
"txnReference": "FINOUPI3436143",
"ExpiryTime": "30",
"mobilenumber": "919803122221"
}';

{ "clientTxnId": "4516840", "serviceId": "9072", "txnAmount": "20.00", "txnNote": "Test Product", "payeeVPA": "sky.shivam@fin", "txnReference": "FINOUPI508571",, "ExpiryTime": "30", "mobilenumber": "919803122221" }








/*$data='{
    "clientTxnId": "1245679965",
    "serviceId": "9031",
    "payeraddr": "pravin99@fin",
    "payername": "Narayanan",
    "payeename": "Miss Caroline Victor Dsouza",
    "initiationmode": "00",
    "referencecategory": "00",
    "currencycode": "INR",
    "amount": "5.00",
    "purpose": "01",
    "payeeaddr": "sky.prince@fin",
    "payercode": "0000",
    "payertype": "PERSON",
    "mobilenumber": "918887819239",
    "txnnote": "FINOBANKUPI",
    "expireafter": "30",
    "location": "Ghazibad",
    "geocode": "28.6446214,77.3272125",
    "id": "38a0ef79917a3070",
    "ip": "122.176.17.22",
    "type": "MOB",
    "app": "finoapp",
    "os": "Windows 11",
    "capability": "FULL",
    "telecom": "NA",
    "refid": "FINOUPIUAT 3313400298676542681",
    "simno": "238a0ef79917a3070"
}';*/

/*$data ='{
"clientTxnId": "12345678912389",
"serviceId": "9071",
"mobileno": "918887819239",
"referenceid": "FINOUPI1256789"
}';*/

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