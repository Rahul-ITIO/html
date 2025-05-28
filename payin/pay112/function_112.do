
<?php
//echo "abcd";

function encryptCardData($cardNumber, $expiryMonth, $expiryYear, $nameOnCard, $securityCode)
{
    // Create an associative array representing the payload  payin/pay112/lipadPublic.pem
    $publicKey = file_get_contents('lipadPublic.pem');
    $payload = array(
        "expiry" => array(
            "month" => $expiryMonth,
            "year" => $expiryYear
        ),
        "name_on_card" => $nameOnCard,
        "number" => $cardNumber,
        "security_code" => $securityCode
    );

    // Convert the array to a JSON string
    $jsonPayload = json_encode($payload);
    // Encrypt the serialized object
    openssl_public_encrypt($jsonPayload, $encryptedData, $publicKey, OPENSSL_PKCS1_OAEP_PADDING);
    // Base64 Encode the ciphertext
    return base64_encode($encryptedData);
}

// Testing 
$cardNumber     = $post['ccno'];
$expiryMonth    = $post['month'];
$expiryYear     = $post['year'];
$nameOnCard     = $post['fullname'];
$securityCode   = $post['ccvv'];
$encryptedData  = encryptCardData($cardNumber, $expiryMonth, $expiryYear, $nameOnCard, $securityCode);
$encryptedData;
//echo "xyz";
//exit;
?>