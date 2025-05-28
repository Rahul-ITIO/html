<?php

// http://localhost:8080/gw/payin/pay53/hardcode/encode_decode_53_hardcode_test_2.php

/*
require 'vendor/autoload.php'; // Assuming you are using Composer for libraries

use Defuse\Crypto\Crypto;
use Defuse\Crypto\Key;
use Defuse\Crypto\Exception\WrongKeyException;
*/

function encryptCardData() {
    // Issued zone encryption key (ZEK)
    $zek = "679942a3636b7b6b5ebf06a05f6a82cd6dc5e21ec88fe4a3c5d2dc676d412998";

    // Issued public api key
    $publicApiKey = "a98a7967053c85aa413ffe3bab0a0e3dd11541b775acfee8e958f3f44cd947263d13f2a4f69d6807d58e3a2317f1093b5ed1e5082bbbe01240cb3127";

    $cards['ccno']='5123450000000008';
    $cards['month']='10';
    $cards['year']='31';
    $cards['ccvv']=123;

    // Card data to be encrypted
    $cardData = '{"cardNo": "5123450000000008","expiryDate": "2031","securityCode":123}';

    // Retrieve secret key by decrypting the public API key using the encryption key (ZEK)
    $zekSecretKey = hex2bin($zek);
    $secretKey = decrypt($publicApiKey, $zekSecretKey);

    // Convert card data to hex string
    $cardDataHex = bin2hex($cardData);
    $secretKeySpec = hex2bin($secretKey);

    // Encrypt card data
    $encryptedDataHex = encrypt($cardDataHex, $secretKeySpec);
}

function encrypt($dataHexString, $secretKey) {
    $ivBytes = random_bytes(12);

    try {
        $cipher = "aes-128-gcm";
        $encryptedBytes = openssl_encrypt(hex2bin($dataHexString), $cipher, $secretKey, OPENSSL_RAW_DATA | OPENSSL_NO_PADDING, $ivBytes, $tag);

        $ivText = bin2hex($ivBytes);
        $encryptedText = bin2hex($encryptedBytes);

        return $ivText . $encryptedText;
    } catch (Exception $e) {
        throw new RuntimeException("Error during encryption", $e);
    }
}

function decrypt($encryptedHexString, $secretKey) {
    $ivPlusEncryptedBytes = hex2bin($encryptedHexString);
    $iv = substr($ivPlusEncryptedBytes, 0, 12);
    $encryptedBytes = substr($ivPlusEncryptedBytes, 12);

    try {
        $cipher = "aes-128-gcm";
        $decryptedBytes = openssl_decrypt($encryptedBytes, $cipher, $secretKey, OPENSSL_RAW_DATA | OPENSSL_NO_PADDING, $iv, $tag='');
        return bin2hex($decryptedBytes);
    } catch (Exception $e) {
        throw new RuntimeException("Error during decryption", $e);
    }
}

echo encryptCardData();
?>

