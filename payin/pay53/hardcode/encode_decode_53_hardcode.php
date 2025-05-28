<?php

// http://localhost:8080/gw/payin/pay53/hardcode/encode_decode_53_hardcode.php?cardNo=5123450000000008&expiryDate=3112&securityCode=123



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
        $hex .= dechex(ord($string[$i]));
    }
    return $hex;
}

function encryptCardData($cards=[]) {
    $zek = "679942a3636b7b6b5ebf06a05f6a82cd6dc5e21ec88fe4a3c5d2dc676d412998";

    // Issued public api key
    $publicApiKey = "a98a7967053c85aa413ffe3bab0a0e3dd11541b775acfee8e958f3f44cd947263d13f2a4f69d6807d58e3a2317f1093b5ed1e5082bbbe01240cb3127";

    $cardNo=$cards['ccno'];
    $expiryDate=$cards['year'].$cards['month'];
    //$expiryDate='20'.$cards['year'];
    $securityCode=$cards['ccvv'];

    if(isset($_REQUEST['cardNo'])&&trim($_REQUEST['cardNo']))$cardNo=$_REQUEST['cardNo'];
    if(isset($_REQUEST['expiryDate'])&&trim($_REQUEST['expiryDate']))$expiryDate=$_REQUEST['expiryDate'];
    if(isset($_REQUEST['securityCode'])&&trim($_REQUEST['securityCode']))$securityCode=$_REQUEST['securityCode'];

    $cardData = "{\"cardNo\": \"{$cardNo}\",\"expiryDate\": \"{$expiryDate}\",\"securityCode\":{$securityCode}}";
   // $cardData = '{"cardNo": "5123450000000008","expiryDate": "2031","securityCode":123}';


    echo "<br/><hr/><br/>cardData=>".$cardData;

    $zekSecretKeySpec = hexToStr($zek);
    $secretKey = decrypt($publicApiKey, $zekSecretKeySpec);

    $cardDataHex = strToHex($cardData);
    $secretKeySpec = hexToStr($secretKey);

    $encryptedDataHex = encrypt($cardDataHex, $secretKeySpec);
    return $encryptedDataHex;
}

function encrypt($dataHexString, $secretKey) {
    $iv = random_bytes(12);
    $cipher = 'aes-256-gcm';
    $data = hexToStr($dataHexString);
    $tag = null;

    $encryptedData = openssl_encrypt($data, $cipher, $secretKey, OPENSSL_RAW_DATA, $iv, $tag);

    if ($encryptedData === false) {
        throw new RuntimeException("Error during encryption");
    }

    $ivText = strToHex($iv);
    $encryptedText = strToHex($encryptedData . $tag);

    return $ivText . $encryptedText;
}

function decrypt($encryptedHexString, $secretKey) {
    $ivPlusEncryptedBytes = hexToStr($encryptedHexString);
    $iv = substr($ivPlusEncryptedBytes, 0, 12);
    $encryptedBytes = substr($ivPlusEncryptedBytes, 12, -16);
    $tag = substr($ivPlusEncryptedBytes, -16);

    $cipher = 'aes-256-gcm';

    $decryptedData = openssl_decrypt($encryptedBytes, $cipher, $secretKey, OPENSSL_RAW_DATA, $iv, $tag);

    //echo "<br/><hr/><br/>decryptedData=><br/>".$decryptedData ;
    if ($decryptedData === false) {
        throw new RuntimeException("Error during decryption");
    }

    return strToHex($decryptedData);
}

// Example usage:
try {

    $cards['ccno']='5123450000000008';
    //$cards['ccno']='5123450000000549';
    //$cards['ccno']='1111111111111111';
    
    $cards['month']='12';
    $cards['year']='31';
    $cards['ccvv']=123;

    $encryptedData = encryptCardData($cards);
    echo "<br/><hr/><br/>Encrypted Data: <br/>" . $encryptedData;
} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}


?>
