import javax.crypto.Cipher;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;

public class Main {

    public static void main(String[] args) {
        try {
            Main main = new Main();
            main.encryptCardData();
        } catch (NoSuchAlgorithmException e) {
            System.err.println("Encryption algorithm not found: " + e.getMessage());
        }
    }

    public void encryptCardData() throws NoSuchAlgorithmException {
        // Issued zone encryption key (ZEK)
        var zek = "679942a3636b7b6b5ebf06a05f6a82cd6dc5e21ec88fe4a3c5d2dc676d412998";

        // Issued public API key
        var publicApiKey = "a98a7967053c85aa413ffe3bab0a0e3dd11541b775acfee8e958f3f44cd947263d13f2a4f69d6807d58e3a2317f1093b5ed1e5082bbbe01240cb3127";

        // Card data to be encrypted
        var cardData = "{\"cardNo\": \"5123450000000008\",\"expiryDate\": \"3112\",\"securityCode\":123}";

        // Retrieve secret key by decrypting the public API key using the encryption key (ZEK)
        var zekSecretKeySpec = new SecretKeySpec(HexUtils.fromHexString(zek), "AES");
        var secretKey = decrypt(publicApiKey, zekSecretKeySpec);

        // Convert card data to hex string
        var cardDataHex = HexUtils.toHexString(cardData.getBytes(StandardCharsets.UTF_8));
        var secretKeySpec = new SecretKeySpec(HexUtils.fromHexString(secretKey), "AES");

        // Encrypt card data
        var encryptedDataHex = encrypt(cardDataHex, secretKeySpec);
        System.out.println("Encrypted card data: " + encryptedDataHex);
    }

    private String encrypt(String dataHexString, SecretKeySpec secretKey) {
        SecureRandom secureRandom = new SecureRandom();
        byte[] ivBytes = new byte[12];
        secureRandom.nextBytes(ivBytes); // Ensure IV is generated

        try {
            Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
            GCMParameterSpec gcmParamSpec = new GCMParameterSpec(128, ivBytes);
            cipher.init(Cipher.ENCRYPT_MODE, secretKey, gcmParamSpec);

            byte[] dataBytes = HexUtils.fromHexString(dataHexString);
            byte[] encryptedBytes = cipher.doFinal(dataBytes);

            String ivText = HexUtils.toHexString(ivBytes);
            String encryptedText = HexUtils.toHexString(encryptedBytes);

            return ivText + encryptedText;
        } catch (Exception e) {
            throw new RuntimeException("Error during encryption", e);
        }
    }

    private String decrypt(String encryptedHexString, SecretKeySpec secretKey) {
        byte[] ivPlusEncryptedBytes = HexUtils.fromHexString(encryptedHexString);
        byte[] iv = Arrays.copyOfRange(ivPlusEncryptedBytes, 0, 12);
        byte[] encryptedBytes = Arrays.copyOfRange(ivPlusEncryptedBytes, 12, ivPlusEncryptedBytes.length);

        try {
            Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
            GCMParameterSpec spec = new GCMParameterSpec(128, iv);
            cipher.init(Cipher.DECRYPT_MODE, secretKey, spec);

            byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
            return HexUtils.toHexString(decryptedBytes);
        } catch (Exception e) {
            throw new RuntimeException("Error during decryption", e);
        }
    }
}

class HexUtils {
    public static String toHexString(byte[] bytes) {
        StringBuilder hexString = new StringBuilder();
        for (byte b : bytes) {
            String hex = Integer.toHexString(0xFF & b);
            if (hex.length() == 1) {
                hexString.append('0');
            }
            hexString.append(hex);
        }
        return hexString.toString();
    }

    public static byte[] fromHexString(String hex) {
        int len = hex.length();
        byte[] data = new byte[len / 2];
        for (int i = 0; i < len; i += 2) {
            data[i / 2] = (byte) ((Character.digit(hex.charAt(i), 16) << 4)
                    + Character.digit(hex.charAt(i+1), 16));
        }
        return data;
    }
}
