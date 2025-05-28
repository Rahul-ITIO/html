<?php

class EncryptionDecryption {

    public static function main() {
        try {
            $VPA_RSA_MODULUS = "xTSiS4+I/x9awUXcF66Ffw7tracsQfGCn6g6k/hGkLquHYMFTCYk4mOB5NwLwqczwvl8HkQfDShGcvrm47XHKUzA8iadWdA5n4toBECzRxiCWCHm1KEg59LUD3fxTG5ogGiNxDj9wSguCIzFdUxBYq5ot2J4iLgGu0qShml5vwk=";
            $VPA_RSA_PRIVATE_KEY_D = "g1WAWI4pEK9TA7CA2Yyy/2FzzNiu0uQCuE2TZYRNiomo96KQXpxwqAzZLw+VDXfJMypwDMAVZe/SqzSJnFEtZxjdxaEo3VLcZ1mnbIL0vS7D6iFeYutF9kF231165qGd3k2tgymNMMpY7oYKjS11Y6JqWDU0WE5hjS2X35iG6mE=";
            $VPA_RSA_EXPONENT = "AQAB";

            $demoApplication = new EncryptionDecryption(); 
            $publicKey = $demoApplication->readPublicKeyFromMod($VPA_RSA_MODULUS, $VPA_RSA_EXPONENT);
            $privateKey = $demoApplication->readPrivateKeyFromMod($VPA_RSA_MODULUS, $VPA_RSA_PRIVATE_KEY_D);

            $originalMessage = "1234567";
            $encryptedMessage = EncryptionDecryption::encrypt($originalMessage, $publicKey);
            echo "Encrypted message: " . base64_encode($encryptedMessage) . "\n";

            $decryptedMessage = EncryptionDecryption::decrypt($encryptedMessage, $privateKey);
            echo "Decrypted message: " . $decryptedMessage . "\n";
        } catch (Exception $e) {
            echo "Failed to generate/verify token: " . $e->getMessage() . "\n";
        }
    }

    public function readPublicKeyFromMod($VPA_RSA_MODULUS, $VPA_RSA_EXPONENT) {
        $modulusBytes = base64_decode($VPA_RSA_MODULUS);
        $exponentBytes = base64_decode($VPA_RSA_EXPONENT);
        $modulus = new BigInteger(1, $modulusBytes);
        $publicExponent = new BigInteger(1, $exponentBytes);
        $factory = "RSA";
        $rsaPubKey = new RSAPublicKeySpec($modulus, $publicExponent);
        $factory = KeyFactory::getInstance($factory);
        $publicKey = $factory->generatePublic($rsaPubKey);
        return $publicKey;
    }

    public function readPrivateKeyFromMod($VPA_RSA_MODULUS, $VPA_RSA_PRIVATE_KEY_D) {
        $modulusBytes = base64_decode($VPA_RSA_MODULUS);
        $dBytes = base64_decode($VPA_RSA_PRIVATE_KEY_D);
        $modulus = new BigInteger(1, $modulusBytes);
        $d = new BigInteger(1, $dBytes);
        $factory = "RSA";
        $privateSpec = new RSAPrivateKeySpec($modulus, $d);
        $factory = KeyFactory::getInstance($factory);
        $privateKey = $factory->generatePrivate($privateSpec);
        return $privateKey;
    }

    public static function encrypt($data, $publicKey) {
        openssl_public_encrypt($data, $encrypted, $publicKey);
        return $encrypted;
    }

    public static function decrypt($data, $privateKey) {
        openssl_private_decrypt($data, $decrypted, $privateKey);
        return $decrypted;
    }
}

EncryptionDecryption::main();

?>

