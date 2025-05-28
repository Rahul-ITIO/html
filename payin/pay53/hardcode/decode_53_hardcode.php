<?php

// http://localhost:8080/gw/payin/pay53/hardcode/decode_53_hardcode.php

function hexToStr($hex) {
    $string = '';
    for ($i = 0; $i < strlen($hex) - 1; $i += 2) {
        $string .= chr(hexdec($hex[$i] . $hex[$i + 1]));
    }
    return $string;
}

function decrypt($encryptedHexString, $secretKey) {
    $ivPlusEncryptedBytes = hexToStr($encryptedHexString);
    $iv = substr($ivPlusEncryptedBytes, 0, 12);
    $encryptedBytes = substr($ivPlusEncryptedBytes, 12, -16);
    $tag = substr($ivPlusEncryptedBytes, -16);

    $cipher = 'aes-256-gcm';

    $decryptedData = openssl_decrypt($encryptedBytes, $cipher, $secretKey, OPENSSL_RAW_DATA, $iv, $tag);

    if ($decryptedData === false) {
        throw new RuntimeException("Error during decryption");
    }

    return $decryptedData;
}

// Your secret key (obtained from decrypting the public API key with the ZEK)
$secretKey = "679942a3636b7b6b5ebf06a05f6a82cd6dc5e21ec88fe4a3c5d2dc676d412998"; // Replace with your actual secret key

// Encrypted data to decode
$encryptedHexString = "0000000000000000000000008bd22dd9300f6a4d59f8633ae1782df1b4b00802a4034972a86e4b158c519981a6ba0121704b611ce4cbd5c31a1fe7a9cadb81f09a999006d3dd986c0b51ad2dcf15fdef8099009fe04ed502a829279f50cc25f5c6b7";
$encryptedHexString = "f51f7b86a33535799297d288b2d296980c1893cbda6dde7b5be7b206ba97f7a26172c81872b60c4c51593e45eabb1ea24ac2bbb286f117f97bec3af6b7e62466ed4f473199cf303b23b2f886d832d10b2593d918adf44ec76805a8aa21036";


try {
    $decryptedData = decrypt($encryptedHexString, $secretKey);
    echo "Decrypted Data: " . $decryptedData;
} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}
?>
