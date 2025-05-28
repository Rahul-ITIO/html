import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.security.MessageDigest;
import java.util.Base64;
import java.nio.charset.StandardCharsets;

public class Encryption {
    public static void main(String[] args) {
        // The values below should be obtained from dashboard settings under Checkout section
        String IVKey = "COGMER-5WXOBTC";
        String consumerSecret = "GZJECZKhfAJ0rWtPpKXndvPXQYg2DW";
        String accessKey = "9nUfLzIwMCmF0kk4zZCOi8MGSWTFC1";
        String payload = "{\"msisdn\":\"919831142800\",\"account_number\":\"NA\",\"country_code\":\"KEN\",\"currency_code\":\"USD\",\"client_code\":\"COGMER-5WXOBTC\",\"customer_email\":\"demo@lipad.io\",\"customer_first_name\":\"John\",\"customer_last_name\":\"Doe\",\"due_date\":\"2024-08-3113:00:00\",\"merchant_transaction_id\":\"11224093111\",\"preferred_payment_option_code\":\"MPESA_KEN\",\"callback_url\":\"https://gtw.online-epayment.com/payin/pay112/webhookhandler_112.do?status=notification\",\"request_amount\":\"10\",\"request_description\":\"Dummymerchanttransaction\",\"success_redirect_url\":\"https://gtw.online-epayment.com/payin/pay112/webhookhandler_112.do?status=success_redirect_url\",\"fail_redirect_url\":\"https://gtw.online-epayment.com/payin/pay112/webhookhandler_112.do?status=fail_redirect_url\",\"invoice_number\":\"1\",\"language_code\":\"en\",\"service_code\":\"COGCHE189\"}"; // String JSON payload

        try {
            String encryptedPayload = encrypt(IVKey, consumerSecret, payload);
            // You can now redirect to our Checkout Page i.e
            // https://{{BASE_URL}}/?access_key=<YOUR_ACCESS_KEY>&payload=<ENCRYPTED_PAYLOAD>

            // Alternatively

            // You can import our lightweight JavaScript library and pass the encrypted payload to
            // the function Lipad.makePayment(encryptedPayload)
            // It will redirect appropriately to our Checkout UI

            System.out.println("Encrypted Payload: " + encryptedPayload);

        } catch (Exception e) {
            System.err.println("Exception: " + e);
            e.printStackTrace();
        }
    }
    

    static String encrypt(String ivKey, String consumerSecret, String payload) throws Exception {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hashedIV = digest.digest(ivKey.getBytes(StandardCharsets.UTF_8));
        byte[] hashedSecret = digest.digest(consumerSecret.getBytes(StandardCharsets.UTF_8));

        // Use the first 16 bytes of the hash for the IV
        IvParameterSpec iv = new IvParameterSpec(hashedIV, 0, 16);
        // Use the first 32 bytes of the hash for the key
        SecretKeySpec key = new SecretKeySpec(hashedSecret, 0, 32, "AES");

        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.ENCRYPT_MODE, key, iv);
        byte[] encrypted = cipher.doFinal(payload.getBytes(StandardCharsets.UTF_8));
        return Base64.getEncoder().encodeToString(encrypted);
    }

    
}
