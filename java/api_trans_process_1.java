import java.util.*;
import java.util.Base64;
import com.google.gson.Gson;





// Simulating $_SESSION and $_GET as static Maps
    public static Map<String, Object> session = new HashMap<>();
    public static Map<String, String> getParams = new HashMap<>();

    // Simulating $data and $post arrays
    public static Map<String, String> data = new HashMap<>();
    public static Map<String, String> post = new HashMap<>();

    // Dummy variable definitions as they appear in the PHP code
    public static String transID = "sampleTransID";
    public static String ctest = "";
    public static String file_v = "";
    public static String acquirer = "defaultAcquirer";
    
    public static void main(String[] args) {

        // $tr_upd_order_0=array();
        List<Object> tr_upd_order_0 = new ArrayList<>();

        // $api_root=$data['Path']."/";
        String api_root = data.get("Path") + "/";



        //url 

        // $process=$data['Host'].'/secure/process'.$data['ex']."?transID=".$transID; 
        String process = data.get("Host") + "/secure/process" + data.get("ex") + "?transID=" + transID; 

        //	$auth_3ds2=$data['Host'].'/secure/auth_3ds2'.$data['ex']."?transID=".$transID; 
        String auth_3ds2 = data.get("Host") + "/secure/auth_3ds2" + data.get("ex") + "?transID=" + transID; 

        // $secure_process_3d=$data['Host'].'/secure/secure_process'.$data['ex']."?transID=".$transID; 
        String secure_process_3d = data.get("Host") + "/secure/secure_process" + data.get("ex") + "?transID=" + transID; 




        //Dev Tech : 25-02-04 encrypted transID & public_key via &key= in authurl 
        if(data.containsKey("ENCRYPTED_TRANSID_ENABLE") && "Y".equals(data.get("ENCRYPTED_TRANSID_ENABLE"))) {
            String transID_json = "{\"transID\":\"" + transID + "\",\"public_key\":\"" + session.get("re_post_public_key") + "\"}";
            String encrypted_transID = encode64f(transID_json);
            String authurl = data.get("Host") + "/authurl" + data.get("ex") + "?key=" + encrypted_transID;
            String otp_sample_url = data.get("Host") + "/test3dsecureauthentication" + data.get("ex") + "?key=" + encrypted_transID + ctest;
        } else {
            String authurl = data.get("Host") + "/authurl" + data.get("ex") + "?transID=" + transID;
            String otp_sample_url = data.get("Host") + "/test3dsecureauthentication" + data.get("ex") + "?transID=" + transID + ctest;
        }


        // return_url to be use for success or failed pages 
        String return_url = data.get("Host") + "/return_url" + file_v + data.get("ex") + "?transID=" + transID + "&action=redirect";

        // Pending url for trans_processing to be use for pending 
        String trans_processing = data.get("Host") + "/trans_processing" + file_v + data.get("ex") + "?transID=" + transID + "&action=status";

        // intent_process_url to be use for auth url  
        String intent_process_url = data.get("Host") + "/intent_process" + file_v + data.get("ex") + "?transID=" + transID + "&action=authurl";

        String indian_qr_url = data.get("Host") + "/payin/indian-qr" + data.get("ex") + "?transID=" + transID + "&orderId=" + transID + "&action=chart";

        //qr_code show for TetherCoins, BitsCoins via auth
        String chart_url = data.get("Host") + "/payin/chart" + data.get("ex") + "?transID=" + transID;

        //only qr_code get for TetherCoins, BitsCoins on checkout page 
        String chart_qr_code_url = data.get("Host") + "/payin/chart_qr_code" + data.get("ex") + "?transID=" + transID;

        String qr_code_url = data.get("Host") + "/payin/qr_code" + data.get("ex") + "?transID=" + transID;



        //dba common use and dba fetch of terminal & merchant via company_name in SESSION of info_data
        session.put("dba", session.get("info_data_company_name"));
        Object dba = session.get("info_data_company_name");



        boolean hkipass = false;
        boolean hktrust = false;
        boolean ac_25 = false;
        boolean fht_ac = false;
        boolean rebill_ac = false; 
        int intent_process_redirect = 0;
        int intent_process_include = 0;
        int qr_process_base64 = 0;

        //echo "<hr/>_SESSION cardtype =>".$_SESSION['info_data']['cardtype']; echo "<hr/>_SESSION apJson acquirer final =>".$_SESSION["apJson"+acquirer]; exit;

        if(getParams.containsKey("ctest")) {	
            Map<String, Object> apJson = new HashMap<>();
            apJson.put("apJson_f", session.get("acquirer_processing_json" + acquirer));		
            trans_updatesf(session.get("tr_newid"), apJson);
        }

        Map<String, String> browserOs1 = browserOs("1"); 
        Gson gson = new Gson();
        String browserOs = gson.toJson(browserOs1);


        String country_two = get_country_code(post.get("bill_country"));
        post.put("country_two", country_two);
        post.put("country_iso3", get_country_code(post.get("bill_country"), 3));


        ##### start: dynamic acquirer include for path of payin  ###############
        
        //check if 1 is Direct (Curl Option) 
        String connection_method = "";
        if(session.containsKey("b_" + acquirer)) {
            Map<String, String> b_acquirer = (Map<String, String>) session.get("b_" + acquirer);
            connection_method = b_acquirer.get("connection_method");
        }

        if(post.containsKey("acquirer") && post.get("acquirer").trim().length() > 0)
            acquirer = post.get("acquirer");
        else if(post.containsKey("acquirer") && post.get("acquirer").trim().length() > 0)
            acquirer = post.get("acquirer"); // after final will be remove line 

        String acquirer_payin = acquirer;

        // Getting default acquirer from acquirer table 
        if(session.containsKey("b_" + acquirer)) {
            Map<String, String> b_acquirer = (Map<String, String>) session.get("b_" + acquirer);
            if(b_acquirer.get("default_acquirer") != null && b_acquirer.get("default_acquirer").trim().length() > 0) { 
                acquirer_payin = b_acquirer.get("default_acquirer");
            }
        }
    }

    // Equivalent of PHP function encode64f
    public static String encode64f(String input) {
        return Base64.getEncoder().encodeToString(input.getBytes());
    }

    // Equivalent of PHP function trans_updatesf
    public static void trans_updatesf(Object tr_newid, Map<String, Object> apJson) {
        System.out.println("trans_updatesf called with tr_newid: " + tr_newid + " and apJson: " + apJson.toString());
    }

    // Equivalent of PHP function browserOs
    public static Map<String, String> browserOs(String mode) {
        Map<String, String> result = new HashMap<>();
        result.put("os", System.getProperty("os.name"));
        result.put("mode", mode);
        return result;
    }

    // Equivalent of PHP function get_country_code with one parameter
    public static String get_country_code(String country) {
        if(country == null) return "";
        return "XX";
    }

    // Overloaded equivalent of PHP function get_country_code with two parameters
    public static String get_country_code(String country, int codeType) {
        if(country == null) return "";
        return codeType == 3 ? "XXX" : "XX";
    }



// ########################################################################################################