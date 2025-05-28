import java.io.*;
import java.net.*;
import java.util.*;

public class PaymentGatewayIntegration {
    public static void main(String[] args) {
        try {
            // Gateway URL
            String gatewayUrl = "http://localhost:8080/gw/directapi";

            // Determine protocol and referrer
            String protocol = "http://"; // Adjust logic to determine HTTPS or HTTP dynamically if needed
            String referer = protocol + "localhost:8080/currentEndpoint"; // Replace with actual referrer logic

            // Data parameters
            Map<String, String> dataPost = new HashMap<>();

            // Required parameters
            dataPost.put("public_key", "MTEzMTFfODE2XzIwMjQxMjExMTMwNTQ4"); // Business Public Key
            dataPost.put("terNO", "816"); // Terminal Number

            // Optional parameters
            // dataPost.put("acquirer_id", "");

            // Fixed values
            dataPost.put("integration-type", "s2s");
            //dataPost.put("unique_reference", "Y");
            dataPost.put("bill_ip", "127.0.0.1"); // Replace with actual client IP logic
            dataPost.put("source", "Curl-Direct-Card-Payment");
            dataPost.put("source_url", referer);

            // Product details
            dataPost.put("bill_amt", "10.00");
            dataPost.put("bill_currency", "USD");
            dataPost.put("product_name", "Testing Product");

            // Additional billing details
            dataPost.put("fullname", "Test Full Name");
            dataPost.put("bill_email", "test.5500@test.com");
            dataPost.put("bill_address", "36A Alpha");
            dataPost.put("bill_city", "Jurong");
            dataPost.put("bill_state", "SG");
            dataPost.put("bill_country", "SG");
            dataPost.put("bill_zip", "447602");
            dataPost.put("bill_phone", "+65 62294466");
            dataPost.put("reference", "23120228"); // Unique reference
            dataPost.put("webhook_url", "https://yourdomain.com/webhook_url.php");
            dataPost.put("return_url", "https://yourdomain.com/return_url.php");
            dataPost.put("checkout_url", "https://yourdomain.com/checkout_url.php");

            // Card details
            dataPost.put("mop", "CC");
            dataPost.put("ccno", "4242424242424242");
            dataPost.put("ccvv", "123");
            dataPost.put("month", "01");
            dataPost.put("year", "30");

            // Convert dataPost to URL encoded string
            StringBuilder postData = new StringBuilder();
            for (Map.Entry<String, String> entry : dataPost.entrySet()) {
                if (postData.length() != 0) postData.append('&');
                postData.append(URLEncoder.encode(entry.getKey(), "UTF-8"));
                postData.append('=');
                postData.append(URLEncoder.encode(entry.getValue(), "UTF-8"));
            }
            byte[] postDataBytes = postData.toString().getBytes("UTF-8");

            // Open connection and send POST request
            URL url = new URL(gatewayUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            conn.setRequestProperty("Content-Length", String.valueOf(postDataBytes.length));
            conn.setDoOutput(true);
            conn.getOutputStream().write(postDataBytes);

            // Read response
            int responseCode = conn.getResponseCode();
            BufferedReader reader = new BufferedReader(new InputStreamReader(
                    (responseCode == 200) ? conn.getInputStream() : conn.getErrorStream()
            ));
            String line;
            StringBuilder response = new StringBuilder();
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
            reader.close();

            // Print response
            System.out.println("Response Code: " + responseCode);
            System.out.println("Response: " + response.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
