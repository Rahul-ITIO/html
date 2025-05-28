<?php
// http://localhost:8080/gw/payin/pay53/hardcode/decode_53_hardcode_2.php

function hexToStr($hex) {
    $string = '';
    for ($i = 0; $i < strlen($hex) - 1; $i += 2) {
        $string .= chr(hexdec($hex[$i] . $hex[$i + 1]));
    }
    return $string;
}

function decrypt($encryptedHexString, $secretKey) {
    $ivPlusEncryptedBytes = hexToStr($encryptedHexString);

    // The IV is 12 bytes, the tag is 16 bytes, and the rest is the encrypted data
    $iv = substr($ivPlusEncryptedBytes, 0, 12);
    $encryptedBytes = substr($ivPlusEncryptedBytes, 12, -16);
    $tag = substr($ivPlusEncryptedBytes, -16);

    $cipher = 'aes-256-gcm';

    // Debugging information
    echo "IV: " . bin2hex($iv) . "\n";
    echo "Encrypted Bytes: " . bin2hex($encryptedBytes) . "\n";
    echo "Tag: " . bin2hex($tag) . "\n";

    $decryptedData = openssl_decrypt($encryptedBytes, $cipher, $secretKey, OPENSSL_RAW_DATA, $iv, $tag);

    if ($decryptedData === false) {
        //throw new RuntimeException("Error during decryption");
    }

    return $decryptedData;
}

// Your secret key (obtained from decrypting the public API key with the ZEK)
$zek = "679942a3636b7b6b5ebf06a05f6a82cd6dc5e21ec88fe4a3c5d2dc676d412998";

    // Issued public api key
    $publicApiKey = "a98a7967053c85aa413ffe3bab0a0e3dd11541b775acfee8e958f3f44cd947263d13f2a4f69d6807d58e3a2317f1093b5ed1e5082bbbe01240cb3127";
$secretKey = hexToStr("679942a3636b7b6b5ebf06a05f6a82cd6dc5e21ec88fe4a3c5d2dc676d412998"); // Replace with your actual secret key in hex format

// Encrypted data to decode
$encryptedHexString = "0000000000000000000000008bd22dd9300f6a4d59f8633ae1782df1b4b00802a4034972a86e4b158c519981a6ba0121704b611ce4cbd5c31a1fe7a9cadb81f09a999006d3dd986c0b51ad2dcf15fdef8099009fe04ed502a829279f50cc25f5c6b7";
$encryptedHexString = "86f2a4a6d2a5053ec6c1f2d760e851a844c80c87f1178ca8174fcdc49a5e3eda9854e38d7399742bfc6a5e49eaeadff2d1ad4386502235a721388d9a7133693af6db14991960d0683bc7408fdf5ba8a5fb3cc67e4cedb416fce9c57e8242";

try {
    $decryptedData = decrypt($encryptedHexString, $secretKey);
    echo "Decrypted Data: " . $decryptedData;
} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}

?>
