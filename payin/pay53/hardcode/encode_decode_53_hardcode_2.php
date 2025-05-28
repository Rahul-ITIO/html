<?php

// http://localhost:8080/gw/payin/pay53/hardcode/encode_decode_53_hardcode_2.php?cardNo=5123450000000008&expiryDate=3112&securityCode=123

function hexToStr($hex) {
    $string = '';
    for ($i = 0; $i < strlen($hex) - 1; $i += 2) {
        $string .= chr(hexdec($hex[$i] . $hex[$i + 1]));
    }
    return $string;
}

function strToHex($string) {
    $hex = '';
    for ($i = 0; $i < strlen($string); $i++) {
        $hex .= str_pad(dechex(ord($string[$i])), 2, '0', STR_PAD_LEFT);
    }
    return $hex;
}

function decrypt($encryptedHexString, $secretKeyHex) {
    $ivPlusEncryptedBytes = hexToStr($encryptedHexString);
    $iv = substr($ivPlusEncryptedBytes, 0, 12);
    $encryptedBytes = substr($ivPlusEncryptedBytes, 12, -16);
    $tag = substr($ivPlusEncryptedBytes, -16);

    $cipher = 'aes-256-gcm';
    $secretKey = hexToStr($secretKeyHex);

    $decryptedData = openssl_decrypt($encryptedBytes, $cipher, $secretKey, OPENSSL_RAW_DATA, $iv, $tag);

    if ($decryptedData === false) {
        throw new RuntimeException("Error during decryption");
    }

    return $decryptedData;
}

function encrypt($dataHexString, $secretKeyHex) {
    $iv = random_bytes(12);
    $cipher = 'aes-256-gcm';
    $data = hexToStr($dataHexString);

    $secretKey = hexToStr($secretKeyHex);
    $encryptedBytes = openssl_encrypt($data, $cipher, $secretKey, OPENSSL_RAW_DATA, $iv, $tag);

    if ($encryptedBytes === false) {
        throw new RuntimeException("Error during encryption");
    }

    $ivHex = strToHex($iv);
    $encryptedHex = strToHex($encryptedBytes);
    $tagHex = strToHex($tag);

    return $ivHex . $encryptedHex . $tagHex;
}

function encryptCardData() {
    $zek = "679942a3636b7b6b5ebf06a05f6a82cd6dc5e21ec88fe4a3c5d2dc676d412998";
    $publicApiKey = "a98a7967053c85aa413ffe3bab0a0e3dd11541b775acfee8e958f3f44cd947263d13f2a4f69d6807d58e3a2317f1093b5ed1e5082bbbe01240cb3127";
    $cardData = "{\"cardNo\": \"5123450000000008\",\"expiryDate\": \"3112\",\"securityCode\":123}";

    $secretKey = decrypt($publicApiKey, $zek);
    $cardDataHex = strToHex($cardData);

    $encryptedDataHex = encrypt($cardDataHex, $secretKey);
    echo "Encrypted card data: " . $encryptedDataHex;
}

// Execute the function to see the result
try {
    encryptCardData();
} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}
?>
