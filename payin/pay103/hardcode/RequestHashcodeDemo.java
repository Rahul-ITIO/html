import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

// https://chatgpt.com/c/66e434de-58a0-8008-bf19-4d1bf3d92459

public class RequestHashcodeDemo {
    public static void main(String[] args) {
        String merNo = "1888";
        String orderNo = "TS12145";
        String currencyCode = "USD";
        String amount = "12.56";
        String payIP = "127.0.0.1";
        String transType = "sales";
        String transModel = "M";
        String securityCode = "1cc5eed9a65d419c85df79f86846a0be";

        StringBuffer sb = new StringBuffer();
        sb.append("EncryptionMode=SHA256");
        sb.append("&CharacterSet=UTF8");
        sb.append("&merNo=" + merNo);
        sb.append("&orderNo=" + orderNo);
        sb.append("&currencyCode=" + currencyCode);
        sb.append("&amount=" + amount);
        sb.append("&payIP=" + payIP);
        sb.append("&transType=" + transType);
        sb.append("&transModel=" + transModel);
        sb.append("&").append(securityCode);
        System.out.println("String to be hashed: " + sb.toString());

        // Calculate the SHA-256 hash
        try {
            String hashcode = sha256(sb.toString());
            System.out.println("hashcode=" + hashcode);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
    }

    // Method to generate SHA-256 hash
    public static String sha256(String data) throws NoSuchAlgorithmException {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hash = digest.digest(data.getBytes(StandardCharsets.UTF_8));

        // Convert byte array into hex string
        StringBuilder hexString = new StringBuilder();
        for (byte b : hash) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) hexString.append('0');
            hexString.append(hex);
        }
        return hexString.toString();
    }
}
