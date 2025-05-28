import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

public class PaymentGateway {
    public static void main(String[] args) {
        try {
            String gatewayUrl = "http://localhost:8080/gw/directapi";

            String protocol = "http://"; // Default to http
            String referer = protocol + "localhost:8080"; // Replace with actual server name and request URI

            Map<String, String> dataPost = new HashMap<>();

            // Replace of 2 very important parameters * your Business Public Key and TerNO
            dataPost.put("public_key", "MTEzMTFfODE2XzIwMjQxMjExMTMwNTQ4"); // Business Public Key
            dataPost.put("terNO", "816"); // terNO

            // Optional
            // dataPost.put("acquirer_id", "");

            // Default (fixed) value * default
            dataPost.put("integration-type", "s2s");
            // dataPost.put("unique_reference", "Y");
            dataPost.put("bill_ip", "127.0.0.1"); // Replace with actual IP retrieval logic
            dataPost.put("source", "Curl-Direct-Card-Payment");
            dataPost.put("source_url", referer);

            // Product bill_amt, bill_currency and product name * by cart total bill_amt
            dataPost.put("bill_amt", "10.00");
            dataPost.put("bill_currency", "USD");
            dataPost.put("product_name", "Testing Product");

            // Billing details of customer
            dataPost.put("fullname", "Test Full Name");
            dataPost.put("bill_email", "test.5500@test.com");
            dataPost.put("bill_address", "36A Alpha");
            dataPost.put("bill_city", "Jurong");
            dataPost.put("bill_state", "SG");
            dataPost.put("bill_country", "SG");
            dataPost.put("bill_zip", "447602");
            dataPost.put("bill_phone", "+65 62294466");
            dataPost.put("reference", "23120228"); // should be unique by time() or your reference is unique
            dataPost.put("webhook_url", "https://yourdomain.com/webhook_url.php");
            dataPost.put("return_url", "https://yourdomain.com/return_url.php");
            dataPost.put("checkout_url", "https://yourdomain.com/checkout_url.php");

            // Card details of customer
            dataPost.put("mop", "CC");
            dataPost.put("ccno", "4242424242424242");
            dataPost.put("ccvv", "123");
            dataPost.put("month", "01");
            dataPost.put("year", "30");

            // S2S via HttpURLConnection
            URL url = new URL(gatewayUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("User-Agent", "Mozilla/5.0");
            conn.setRequestProperty("Referer", referer);
            conn.setDoOutput(true);
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

            StringBuilder postData = new StringBuilder();
            for (Map.Entry<String, String> entry : dataPost.entrySet()) {
                if (postData.length() != 0) postData.append('&');
                postData.append(entry.getKey()).append('=').append(entry.getValue());
            }

            try (OutputStream os = conn.getOutputStream()) {
                os.write(postData.toString().getBytes());
            }

            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String response;
            StringBuilder responseBuilder = new StringBuilder();
            while ((response = in.readLine()) != null) {
                responseBuilder.append(response);
            }
            in.close();

            String jsonResponse = responseBuilder.toString();
            // Assuming a JSON library is used to parse the response
            Map<String, Object> results = new HashMap<>(); // Replace with actual JSON parsing logic

            // Check for errors in the response
            /* 
            if (results == null || !results.containsKey("transID") || results.containsKey("Error") || results.containsKey("error")) 
            {
                System.out.println("Error or missing response: " + jsonResponse);
                return;
            } else 
            */
            {
                int orderStatus = (int) results.get("order_status");

                StringBuilder subQuery = new StringBuilder();
                for (Map.Entry<String, Object> entry : results.entrySet()) {
                    if (subQuery.length() != 0) subQuery.append('&');
                    subQuery.append(entry.getKey()).append('=').append(entry.getValue());
                }

                String redirectUrl;
                if (results.containsKey("authurl") && results.get("authurl") != null) { // 3D Bank URL
                    redirectUrl = (String) results.get("authurl");
                    System.out.println("Redirecting to: " + redirectUrl);
                } else if (orderStatus == 1 || orderStatus == 9) { // 1:Approved/Success,9:Test Transaction
                    redirectUrl = (String) dataPost.get("return_url");
                    redirectUrl += redirectUrl.contains("?") ? "&" : "?";
                    redirectUrl += subQuery.toString();
                    System.out.println("Redirecting to: " + redirectUrl);
                } else if (orderStatus == 2 || orderStatus == 22 || orderStatus == 23) { // 2:Declined, 22:Expired, 23:Cancelled, 24:Failed
                    redirectUrl = (String) dataPost.get("return_url");
                    redirectUrl += redirectUrl.contains("?") ? "&" : "?";
                    redirectUrl += subQuery.toString();
                    System.out.println("Redirecting to: " + redirectUrl);
                } else { // Pending for check auth status
                    redirectUrl = (String) dataPost.get("authstatus");
                    System.out.println("Redirecting to: " + redirectUrl);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

