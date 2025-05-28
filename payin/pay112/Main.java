import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.security.MessageDigest;
import java.util.Base64;
import java.nio.charset.StandardCharsets;

public class Main {
    public static void main(String args[]) {
        //The values below can be obtained from dashboard settings under Checkout section
        String IVKey = "5re4WY3wnpnS4kxtn4MimJJBjO4ZYp";
        String consumerSecret = "GZJECZKhfAJ0rWtPpKXndvPXQYg2DW";
        String accessKey = "lcdr1TG6Njqs8q1rBlEqrIWCrjWHSP";
        String payload = "{\"msisdn\":\"919831142800\",\"account_number\":\"NA\",\"country_code\":\"KEN\",\"currency_code\":\"USD\",\"client_code\":\"COGMER-5WXOBTC\",\"customer_email\":\"demo@lipad.io\",\"customer_first_name\":\"John\",\"customer_last_name\":\"Doe\",\"due_date\":\"2024-08-3113:00:00\",\"merchant_transaction_id\":\"11224093111\",\"preferred_payment_option_code\":\"MPESA_KEN\",\"callback_url\":\"https://gtw.online-epayment.com/payin/pay112/webhookhandler_112.do?status=notification\",\"request_amount\":\"10\",\"request_description\":\"Dummymerchanttransaction\",\"success_redirect_url\":\"https://gtw.online-epayment.com/payin/pay112/webhookhandler_112.do?status=success_redirect_url\",\"fail_redirect_url\":\"https://gtw.online-epayment.com/payin/pay112/webhookhandler_112.do?status=fail_redirect_url\",\"invoice_number\":\"1\",\"language_code\":\"en\",\"service_code\":\"COGCHE189\"}"; // String JSON payload

        try {

            String encrytedPayload=encrypt(IVKey,consumerSecret,payload);

            System.out.println("Encrypted Payload: " + encrytedPayload);

            //Once encrypted you will import our lightweight javascript library and pass the encrypted payload to
            //availed function Lipad.makePayment((encrytedPayload))
            //It will redirect appropriately to our Checkout UI
        } catch (Exception var7) {
            System.err.println("Exception " + var7);
            var7.printStackTrace();
        }
    }

     static String encrypt(String IVKey,String consumerSecret,String payload) throws Exception {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hashedIV = digest.digest(IVKey.getBytes(StandardCharsets.UTF_8));
        byte[] hashedSecret = digest.digest(consumerSecret.getBytes(StandardCharsets.UTF_8));
        IvParameterSpec key = new IvParameterSpec(bytesToHex(hashedIV).substring(0, 16).getBytes());
        SecretKeySpec secret = new SecretKeySpec(bytesToHex(hashedSecret).substring(0, 32).getBytes(), "AES");

        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.ENCRYPT_MODE, secret, key);
        byte[] encrypted = cipher.doFinal(payload.getBytes());
        String encryptedBase64Payload = Base64.getEncoder().encodeToString(encrypted);
        return encryptedBase64Payload;
    }

    

    static String bytesToHex(byte[] data) {
        if (data == null) {
            return null;
        } else {
            int len = data.length;
            String string = "";
            for(int i = 0; i < len; ++i) {
                if ((data[i] & 255) < 16) {
                    string = string + "0" + Integer.toHexString(data[i] & 255);
                } else {
                    string = string + Integer.toHexString(data[i] & 255);
                }
            }
            return string;
        }
    }
}