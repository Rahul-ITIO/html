package perform;
import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.crypto.Cipher;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;

import java.util.Arrays;

// encode_53?cardNo=5123450000000009&expiryDate=3112&securityCode=123&zek=679942a3636b7b6b5ebf06a05f6a82cd6dc5e21ec88fe4a3c5d2dc676d412998&publicApiKey=a98a7967053c85aa413ffe3bab0a0e3dd11541b775acfee8e958f3f44cd947263d13f2a4f69d6807d58e3a2317f1093b5ed1e5082bbbe01240cb3127&qp=1

@WebServlet("/encode_53")
public class Aes256Gcm extends HttpServlet {
         
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException 
	{
		response.setContentType("text/html");
		PrintWriter out=null;
		try { 
			out=response.getWriter();
			
			String getZek=""; String getPublicApiKey="";
			
			if(request.getParameter("zek") != null && request.getParameter("zek") != "")  
				getZek=request.getParameter("zek");
			
			if(request.getParameter("publicApiKey") != null && request.getParameter("publicApiKey") != "") 
				getPublicApiKey=request.getParameter("publicApiKey");
			
			String cardNo1=request.getParameter("cardNo");
			int expiryDate1=Integer.parseInt(request.getParameter("expiryDate"));
			int securityCode1=Integer.parseInt(request.getParameter("securityCode"));
			
			//out.println("<center>");
			
			
			// Issued zone encryption key (ZEK)
	        var zek = "679942a3636b7b6b5ebf06a05f6a82cd6dc5e21ec88fe4a3c5d2dc676d412998";

	        // Issued public API key
	        var publicApiKey = "a98a7967053c85aa413ffe3bab0a0e3dd11541b775acfee8e958f3f44cd947263d13f2a4f69d6807d58e3a2317f1093b5ed1e5082bbbe01240cb3127";
	        
	        if(!getZek.isEmpty()) zek = getZek;
	        if(getPublicApiKey!=null && !getPublicApiKey.isEmpty()) publicApiKey = getPublicApiKey;
	        
	        // Card data to be encrypted
	        //var cardData = "{\"cardNo\": \"5123450000000008\",\"expiryDate\": \"3112\",\"securityCode\":123}";
	        var cardData = "{\"cardNo\": \""+cardNo1+"\",\"expiryDate\": \""+expiryDate1+"\",\"securityCode\":"+securityCode1+"}";

	        // Retrieve secret key by decrypting the public API key using the encryption key (ZEK)
	        var zekSecretKeySpec = new SecretKeySpec(HexUtils.fromHexString(zek), "AES");
	        var secretKey = decrypt(publicApiKey, zekSecretKeySpec);

	        // Convert card data to hex string
	        var cardDataHex = HexUtils.toHexString(cardData.getBytes(StandardCharsets.UTF_8));
	        var secretKeySpec = new SecretKeySpec(HexUtils.fromHexString(secretKey), "AES");

	        // Encrypt card data
	        var encryptedDataHex = encrypt(cardDataHex, secretKeySpec);
	        //System.out.println("Encrypted card data: " + encryptedDataHex);
	        
	        if(request.getParameter("qp") != null && request.getParameter("qp") != "") 
	        { 
	        	out.println("<br> <font color=blue>cardNo: "+cardNo1+"</font>");
				out.println("<br> <font color=blue>expiryDate: "+expiryDate1+"</font>");
				out.println("<br> <font color=blue>securityCode: "+securityCode1+"</font>");
				if(!getZek.isEmpty()) out.println("<br><hr><br> <font color=green>getZek: "+getZek+"</font><br>");
		        if(getPublicApiKey!=null && !getPublicApiKey.isEmpty()) out.println("<br> <font color=blue>getPublicApiKey: "+getPublicApiKey+"</font>");
	        	out.println("<br><hr><br> <font color=blue>cardData: "+cardData+"</font><br><hr>");
	        }
	        
	        out.println(encryptedDataHex);

			
		}
		
		catch(Exception e){
			out.println("Error : "+e.getMessage());
		}
		finally {
			//out.println("<br> <br>");
			//out.println("To goto main page <a href='index'> Click HERE </a>");
			//out.println("</center>");
			
		}
		
		
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
