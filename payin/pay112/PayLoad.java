package perform;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.Base64;
import java.util.Enumeration;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// http://localhost:8084/webhook55/pay_load_112?bill_currency=USD&mop=DC&bill_amt=2.01&product_name=iphon12&fullname=TEST&bill_email=arun@itio.in&bill_address=Singapore%20161%20Kallang%20Way&bill_city=Singapore&bill_state=Singapore&bill_country=SG&bill_zip=110001&bill_phone=919819120812&reference=2023121912081&os=device_ios&webhook_url=https://gtw.online-epayment.com/payin/pay112/webhookhandler_112.do%3FtransID%3D11224090311%26urlaction%3Dcallback_url&qp=1

@WebServlet("/pay_load_112")
public class PayLoad extends HttpServlet {
         
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException 
	{
		response.setContentType("text/html");
		PrintWriter out=null;
		
		out=response.getWriter();
		
		// Get all parameter names
        Enumeration<String> parameterNames = request.getParameterNames();

        
		
		
		String IVKey = getOrDefault(request, "ivkey", "5re4WY3wnpnS4kxtn4MimJJBjO4ZYp");
		String consumerSecret = getOrDefault(request, "consumerSecret", "GZJECZKhfAJ0rWtPpKXndvPXQYg2DW");
		//String accessKey = getOrDefault(request, "accessKey", "lcdr1TG6Njqs8q1rBlEqrIWCrjWHSP");
		
		
		String payload = "{\"msisdn\":\"" + request.getParameter("msisdn") + "\",\"account_number\":\"" + request.getParameter("account_number") + "\",\"country_code\":\"" + request.getParameter("country_code") + "\",\"currency_code\":\"" + request.getParameter("currency_code") + "\",\"client_code\":\"" + request.getParameter("client_code") + "\",\"customer_email\":\"" + request.getParameter("customer_email") + "\",\"customer_first_name\":\"" + request.getParameter("customer_first_name") + "\",\"customer_last_name\":\"" + request.getParameter("customer_last_name") + "\",\"due_date\":\"" + request.getParameter("due_date") + "\",\"merchant_transaction_id\":\"" + request.getParameter("merchant_transaction_id") + "\",\"preferred_payment_option_code\":\"" + request.getParameter("preferred_payment_option_code") + "\",\"callback_url\":\"" + request.getParameter("callback_url") + "\",\"request_amount\":\"" + request.getParameter("request_amount") + "\",\"request_description\":\"" + request.getParameter("request_description") + "\",\"success_redirect_url\":\"" + request.getParameter("success_redirect_url") + "\",\"fail_redirect_url\":\"" + request.getParameter("fail_redirect_url") + "\",\"invoice_number\":\"" + request.getParameter("invoice_number") + "\",\"language_code\":\"" + request.getParameter("language_code") + "\",\"service_code\":\"" + request.getParameter("service_code") + "\"}"; // String JSON payload

        
        if(request.getParameter("qp") != null && request.getParameter("qp") != "") 
        { 
        		out.println("<br> <font color=blue>IVKey: "+IVKey+"</font>");
			out.println("<br> <font color=blue>consumerSecret: "+consumerSecret+"</font>");
			out.println("<br><hr><br> <font color=green>payload: "+payload+"</font><br>");
			
			// Iterate through parameter names and print them
	        while (parameterNames.hasMoreElements()) {
	            String paramName = parameterNames.nextElement();
	            String paramValue = request.getParameter(paramName);

	            // Print the parameter name and value
	            out.println("<p>" + paramName + " = " + paramValue + "</p>");
	        }
        }
        
     
        
        
		try { 
			
			
			
	        
	        
	        String encrytedPayload=encrypt(IVKey,consumerSecret,payload);

            

            

            if(request.getParameter("qp") != null && request.getParameter("qp") != "") 
            { 
            		System.out.println("Encrypted Payload: " + encrytedPayload);
            	
    				out.println("<br><hr><br> <font color=green>Encrypted Payload: <br>"+encrytedPayload+"</font><br>");
            }
            else
            {
            	
            		out.println(encrytedPayload);
            }
	        
	       
			
		}
		catch (Exception var7) {
            System.err.println("Exception " + var7);
            var7.printStackTrace();
        }
		finally {
			//out.println("<br> <br>");
			//out.println("To goto main page <a href='index'> Click HERE </a>");
			//out.println("</center>");
			
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
   
   	public static String getOrDefault(HttpServletRequest request, String paramName, String defaultValue) {
	    String value = request.getParameter(paramName);
	    return (value != null) ? value : defaultValue;
	}
    
}



