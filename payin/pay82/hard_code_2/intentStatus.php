<?php
namespace Blocktrail\CryptoJSAES;

// http://localhost:8080/gw/payin/pay82/hard_code_2/intentStatus.php

//payload of status
$intentStatus ='{
"clientTxnId": "8267897854347",
"serviceId": "9071",
"mobileno": "918303344556",
"referenceid": "REF20240528058987"
}';


// To ensure the JSON is correctly formatted, you can decode it and encode it again
$jsonDecoded = json_decode($intentStatus, true);
if (json_last_error() !== JSON_ERROR_NONE) {
    die("JSON Error: " . json_last_error_msg());
}

$statusRequest = json_encode($jsonDecoded);


echo "<br/><hr/><br/>statusRequest=><br/>".$statusRequest;

 $passphrase = "2a8dbe2c-0b6d-4ee1-91e8-c182234f710f";//encryption key
 



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
$encryptedData = CryptoJSAES::encrypt($intentStatus, $passphrase);
//$request = $encryptedData;

echo "<br/><hr/><br/>encryptedData=><br/>".$encryptedData;


 //echo $request;
//Decrypt the response data
$decryptedData = CryptoJSAES::decrypt("U2FsdGVkX19oVMdz3TDL9/mxPDveGwNsBZUIG+EGmICUkZ96nUZuTM2iP+FKsUtd/i6nc49JzwdzAMHE1wItFTMaOJ0YSM0pWN+xAb11aCQK2h4wz6TxDUGcdMtnvzNtEXcmnEqQGa4NL4GguT+hWcn6IOGGqXA0BwYfRHExMvuSABFg8Qx5FxFoTkJn21iBYDzxRA/YyoKAk/935Mv1aet3WI3aT2eQTgkKGDn0O/nrjfGEw8DetgMoyJJOGy14+lNjr4yDUSrNgXpeTbKHuNJadCET5eckB0KVVc+zA1TYAldAMdz2nU2FUaIwHMBWWUyoQDOvuejLl6VWOQhbuXBWkJNTTeLtUd1MmFjnbrZARDn5NwdE8n4pPXrY0lRyi+hgzt/aTvzU4XUuaX8qqoD0zdZGDzZ4YXGdP5/k9Kv4dU5GOuDEsDRHQ54VhCZppu89D1r8FlAO6ltOZSSwzubA6j9Lhiut1QRA8i1ge5vXntNb8DNDxNTIT/gKZ3SHGTRi5SJx20/GoWeWBGi3feN155p+sZdKy7dNUMgiM4rZiN7OBmddOZLMpQ+gZvbL1VAdllgUD9s/xTwjGFxJuvEtRXENEkJEQgf8BZ0V/DYjRDaqcmKqyr9JM5fIGKzr2N1/dCy2ZtUhHH2MF7oqK92y3rCCO/FObI22yUW+5QP8mdA3ZJa57PDtYHC9uOOnwoU+jSDVU92fkHbfiwkXbmzPDB8uuGGqzSOHgDGvRofEyeCZoJXlZykw67Iy7WCnZl5/Ms76mLbkdpgA+K1yby0NoXmjpd3amuZXDoWu/Sg4FDKDr8ePo12yAeaU/PT+63S2IDjGiZJr6kH9rIPsOFugp53oiH3k3Gm/7TMHmP64deirRWuSkAlBX7nQgP7lUOzXWxKZFwCafZIXB1UmAOpJDCWOc0ZVSAfRfE+fOqsOfLzW58ZO54dMr69Sml9VRxQg1v4Myo1jA+TFYnkj6ETOWTdunXycmZ2NI+iq7PPkJ/7puTAE4hlsIeflhID+E8VqIaCn+hqgvaVOPNgpwuIiXqYQiq3rChqXOL5pwEZJbDUAisx+bIzS2ge+KBS1YylEQ8793ljzpxFYhIv7R0dto8qM7Rv08IyU08xmSOOqfPozmBOTIE7uZjzb2Gd/KPeMRHEPLeHJVj6RLVqxbk9l0JGF17W8Sasf72+lTW/8FsuQaSVc6s3V2COt7sbSFsQa7S+m/cama4xexp8JrByunXqiXJcEFcxioAB3mEQ2o1X49rRFlPpCD7ycYem4f+KpUlgT2wewDSIbIoekEi+9ln9KUZONF8x3CPwn6nXY2MosP+HxdTbJEtkBXm1cet7inO4+5f4mmp5l8auz9XSpmWnif6/okUG13TzDAzFYwalh/dsAEVifbUob+ll/UYPC9VJU+BobaLalA72L+LdzeiyqO+KhZFHCUrag8p85qCFEYYb3AYq6603KH23cea230puYmL+6ngQTj+fB+JCAw10ao8h2wSl9nozDaZYnQjPTs+jddEkpuT7L/Fth2JBsZQsNTNFXwsU5R88+oF6E0mH+YplKIAIJ1x0Ndaof/DYx/OudIE+HKgshyX6Zdd4YEoJvxyA7srUZfdNJ5KLZw8wbmz6yPw6O6SuljAk=", $passphrase);
// Decrypt the data

echo "<br/><hr/><br/>decryptedData=><br/>".$decryptedData;

?>