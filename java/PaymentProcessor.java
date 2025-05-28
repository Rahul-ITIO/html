import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import org.json.JSONObject;

public class PaymentProcessor {

    // Global session, data, and post maps to simulate the PHP superglobals
    public static Map<String, Object> _SESSION = new HashMap<>();
    public static Map<String, Object> data = new HashMap<>();
    public static Map<String, Object> post = new HashMap<>();

    public static void main(String[] args) {
        // For simulation, you can populate _SESSION, data, and post map here if needed.
        processPayment();
    }

    public static void processPayment() {
        // Dummy initializations for variables used below. In the original PHP these come from different sources.
        String acquirer_payin = _SESSION.get("acquirer_payin") != null ? (String) _SESSION.get("acquirer_payin") : "";
        String acquirer = _SESSION.get("acquirer") != null ? (String) _SESSION.get("acquirer") : "";
        boolean testcardno = _SESSION.get("testcardno") != null ? (boolean) _SESSION.get("testcardno") : false;
        boolean scrubbedstatus = _SESSION.get("scrubbedstatus") != null ? (boolean) _SESSION.get("scrubbedstatus") : false;
        double total_payment = _SESSION.get("total_payment") != null ? (double) _SESSION.get("total_payment") : 0.0;
        String opener_script = _SESSION.get("opener_script") != null ? (String) _SESSION.get("opener_script") : "";
        String dba = _SESSION.get("dba") != null ? (String) _SESSION.get("dba") : "";
        String acquirer_payin_file = _SESSION.get("acquirer_payin_file") != null ? (String) _SESSION.get("acquirer_payin_file") : "";
        // Additional variables used later
        String payment_url = _SESSION.get("payment_url") != null ? (String) _SESSION.get("payment_url") : "";
        String process_url = "";
        String generate_intent_url = "";
        String generate_qr_code = "";
        String intent_paymentUrl = _SESSION.get("intent_paymentUrl") != null ? (String) _SESSION.get("intent_paymentUrl") : "";
        int intent_process_redirect = _SESSION.get("intent_process_redirect") != null ? (int) _SESSION.get("intent_process_redirect") : 0;
        int intent_process_include = _SESSION.get("intent_process_include") != null ? (int) _SESSION.get("intent_process_include") : 0;
        String intent_process_url = _SESSION.get("intent_process_url") != null ? (String) _SESSION.get("intent_process_url") : "";
        int qr_process_base64 = _SESSION.get("qr_process_base64") != null ? (int) _SESSION.get("qr_process_base64") : 0;
        int qrcode_ajax = _SESSION.get("qrcode_ajax") != null ? (int) _SESSION.get("qrcode_ajax") : 0;
        String transID = _SESSION.get("transID") != null ? (String) _SESSION.get("transID") : "";
        String reference = _SESSION.get("reference") != null ? (String) _SESSION.get("reference") : "";
        int set_trans_auto_expired = _SESSION.get("set_trans_auto_expired") != null ? (int) _SESSION.get("set_trans_auto_expired") : 0;
        Map<String, Object> tr_upd_order_111 = _SESSION.get("tr_upd_order_111") != null ? (Map<String, Object>) _SESSION.get("tr_upd_order_111") : new HashMap<>();

        // Mimic: if(isset($acquirer_payin)&&trim($acquirer_payin)&&@$_SESSION['mode'.$acquirer]==1&&$testcardno==false&&$scrubbedstatus==false&&$_SESSION['b_'+acquirer]['acquirer_status']==1)
        Object modeObj = _SESSION.get("mode" + acquirer);
        int modeVal = (modeObj instanceof Integer) ? (Integer) modeObj : 0;
        Map<String, Object> b_acquirer = _SESSION.get("b_" + acquirer) != null ? (Map<String, Object>) _SESSION.get("b_" + acquirer) : new HashMap<>();
        int acquirer_status = b_acquirer.get("acquirer_status") != null ? (int) b_acquirer.get("acquirer_status") : 0;
        if (acquirer_payin != null && !acquirer_payin.trim().isEmpty() && modeVal == 1 && testcardno == false && scrubbedstatus == false && acquirer_status == 1) {

            //#######################################################
            Map<String, Object> tr_upd_order_0 = new HashMap<>();
            //#######################################################

            //fetch bill curr 
            String orderCurrency = "";
            if (_SESSION.get("curr") != null) {
                orderCurrency = (String) _SESSION.get("curr");
            } else {
                orderCurrency = ((String) _SESSION.get("currency" + acquirer)).trim();
            }

            _SESSION.put("currency" + acquirer, orderCurrency); // dynamic value for currency
            _SESSION.put("total_payment", total_payment); // dynamic value for payment

            String orderCurrencySymbol = get_currency(orderCurrency); //fetch currnecy symbol into session

            //#######################################################

            //form acquirer table for acquirer processing creds
            String acq_proc_creds = b_acquirer.get("acquirer_processing_creds") != null ? (String) b_acquirer.get("acquirer_processing_creds") : "";
            Map<String, Object> apc_json = jsondecode(acq_proc_creds, true, true); //json value from backend
            //print_r($apc_json);exit;
            Map<String, Object> apc_get = new HashMap<>();

            int acquirer_prod_mode = b_acquirer.get("acquirer_prod_mode") != null ? (int) b_acquirer.get("acquirer_prod_mode") : 0;
            String bank_url = "";
            if (acquirer_prod_mode == 2) { // this is for test mode trnasaction
                if (apc_json.containsKey("test")) {
                    apc_get = (Map<String, Object>) apc_json.get("test");
                } else {
                    apc_get = apc_json;
                }
                bank_url = b_acquirer.get("acquirer_uat_url") != null ? (String) b_acquirer.get("acquirer_uat_url") : "";
                apc_get.put("mode", "test");
            } else {
                if (apc_json.containsKey("live")) {
                    apc_get = (Map<String, Object>) apc_json.get("live");
                } else {
                    apc_get = apc_json;
                }
                bank_url = b_acquirer.get("acquirer_prod_url") != null ? (String) b_acquirer.get("acquirer_prod_url") : "";
                apc_get.put("mode", "live");
            }

            tr_upd_order_0.put("acquirer_processing_creds", apc_get);

            //#######################################################

            //acquirer processing json from mer setting if live mode
            Map<String, Object> apj = new HashMap<>();
            if (acquirer_prod_mode == 1) {
                Object apJsonObj = _SESSION.get("apJson" + acquirer);
                if (apJsonObj != null && !apJsonObj.toString().isEmpty()) {
                    apj = jsondecode(apJsonObj.toString(), true, true);
                    if (apj != null && apj instanceof Map) {
                        for (Map.Entry<String, Object> entry : apj.entrySet()) {
                            String ke = entry.getKey();
                            Object va = entry.getValue();
                            if (va instanceof Map && ke instanceof String) {
                                apc_get.put(ke, jsonencode((Map<String, Object>) va));
                            } else if (va instanceof String && ke instanceof String) {
                                apc_get.put(ke, va);
                            }
                        }
                    }
                }
            }

            tr_upd_order_0.put("acquirer_processing_json", apj);
            //$tr_upd_order_0=array_merge($tr_upd_order_0,$apj);

            String apc_get_en = jsonencode(apc_get);
            apc_get = jsondecode(apc_get_en, true, true);




            //########	PAYIN FILE PATH	//#######################################################
            String payin_file_path = data.get("Path") + "/payin/pay" + acquirer_payin + "/acquirer_" + acquirer_payin_file + data.get("iex");

            File payinFile = new File(payin_file_path);
            if (payinFile.exists()) {
                include(payin_file_path);
            } else {
                System.out.println("not exit file : " + payin_file_path);
                System.exit(0);
            }


            
            if (tr_upd_order_111 != null && !tr_upd_order_111.isEmpty()) {
                trans_updatesf((String) _SESSION.get("tr_newid"), tr_upd_order_111);
            }

            if ("s2s".equals(post.get("integration-type"))) {
                //include("success_curl" + data.get("iex"));
            } else {

                if (payment_url != null && !payment_url.isEmpty()) {
                    _SESSION.put("acquirer_status_code", 1);
                    process_url = payment_url;
                }

                if (post.get("actionajax") != null && (post.get("actionajax").equals("ajaxIntentUrl") || post.get("actionajax").equals("ajaxIntentArrayUrl"))
                        && _SESSION.containsKey("3ds2_auth") && ((Map) _SESSION.get("3ds2_auth")).get("payaddress") != null
                        && !((Map) _SESSION.get("3ds2_auth")).get("payaddress").toString().isEmpty()) {
                    generate_intent_url = ((Map<String, Object>) _SESSION.get("3ds2_auth")).get("payaddress").toString();
                } else if (qrcode_ajax == 1 && _SESSION.containsKey("3ds2_auth") && ((Map) _SESSION.get("3ds2_auth")).get("payaddress") != null
                        && !((Map) _SESSION.get("3ds2_auth")).get("payaddress").toString().isEmpty()) {
                    generate_qr_code = ((Map<String, Object>) _SESSION.get("3ds2_auth")).get("payaddress").toString();
                }

                if (_SESSION.get("json_arr_set") != null && !_SESSION.get("json_arr_set").toString().isEmpty() && _SESSION.get("json_arr_set") instanceof Map
                        && post.get("actionajax") != null && (post.get("actionajax").equals("ajaxIntentArrayUrl") || post.get("actionajax").equals("ajaxJsonArray"))) {
                    Map<String, Object> json_arr_set = (Map<String, Object>) _SESSION.get("json_arr_set");
                    Map<String, Object> json_arr_res = json_arr_set;
                    json_arr_res.put("DONE_AJAX", "DONE_AJAX");
                    json_arr_res.put("transID", transID);
                    json_arr_res.put("varTransID", transID);
                    json_arr_res.put("varReferenceNo", reference);
                    json_arr_res.put("trans_auto_expired", set_trans_auto_expired);

                    _SESSION.put("json_arr_res", json_arr_res);

                    jsonen(json_arr_res);

                } else if (generate_intent_url != null && !generate_intent_url.isEmpty() && generate_intent_url instanceof String
                        && post.get("actionajax") != null && post.get("actionajax").equals("ajaxIntentUrl")) {
                    generate_intent_url = urldecodef(generate_intent_url);
                    System.out.println("<script>\n\tvar transID='" + transID + "';\n\tvar varTransID='" + transID + "';\n\tvar varReferenceNo='" + reference + "';\n\tvar trans_auto_expired=" + set_trans_auto_expired + "; \n</script>");
                    System.out.println("<a DONE_AJAX class=\"appOpenUrl nopopup suButton btn btn-icon btn-primary mx_button_2\" href=\"" + generate_intent_url + "\"  title=\"" + orderCurrencySymbol + total_payment + " paying to " + dba + " \" target=\"_blank\" onclick=\"processingf();\">Open</a> ");
                    System.exit(0);
                } else if (generate_qr_code != null && !generate_qr_code.isEmpty() && post.get("actionajax") != null && post.get("actionajax").equals("ajaxQrCode")) {
                    generate_qr_code = urldecodef(generate_qr_code);
                    generate_qr_code = urlencodef(generate_qr_code);
                    reference = _SESSION.get("reference") != null ? (String) _SESSION.get("reference") : "";

                    System.out.println("<script>\n\t//parent.window.transID='" + transID + "';\n\tvar transID='" + transID + "';\n\tvar varTransID='" + transID + "';\n                var varReferenceNo='" + reference + "';\n\tvar trans_auto_expired=" + set_trans_auto_expired + "; \n</script>");

                    if (qr_process_base64 == 1) {
                        System.out.println("<img DONE_AJAX src=\"data:image/gif;base64," + generate_qr_code + "\" title=\"" + orderCurrencySymbol + total_payment + " paying to " + dba + " \" width=\"140\" />");
                    } else {
                        System.out.println("<img DONE_AJAX src=\"https://quickchart.io/chart?chs=160x160&cht=qr&chl=" + generate_qr_code + "&choe=UTF-8\" title=\"" + orderCurrencySymbol + total_payment + " paying to " + dba + " \" />");
                        //System.out.println("<img DONE_AJAX src=\"https://quickchart.io/chart?chs=160x160&cht=qr&chl=" + generate_qr_code + "&choe=UTF-8\" title=\"" + orderCurrencySymbol + total_payment + " paying to " + dba + " \" />");
                    }

                    System.exit(0);
                } else if (intent_paymentUrl != null && !intent_paymentUrl.isEmpty() && intent_process_redirect == 1) {
                    System.out.println(opener_script);
                    System.out.println("Redirecting to:" + intent_process_url.trim());
                    System.exit(0);
                } else if (intent_paymentUrl != null && !intent_paymentUrl.isEmpty() && intent_process_include == 1) {
                    data.put("config_root", 1);
                    System.out.println(opener_script);
                    include(data.get("Path") + "/intent_process" + data.get("iex"));
                } else if (process_url != null && !process_url.isEmpty()) {
                    System.out.println(opener_script);
                    System.out.println("Redirecting to:" + process_url.trim());
                    System.exit(0);
                } else {
                    System.out.println(opener_script);
                    data.put("Error", 7004);

                    if (_SESSION.get("acquirer_response") != null && !_SESSION.get("acquirer_response").toString().isEmpty())
                        System.out.println(data.put("Message", "Error for " + stf(_SESSION.get("acquirer_response"))));
                    else
                        System.out.println(data.put("Message", "Error for Could not established secure connection"));
                    //error_print($data['Error'],$data['Message']);
                }
                System.exit(0);
            }
        }
    }

    // Helper function to mimic jsondecode (using org.json)
    public static Map<String, Object> jsondecode(String json, boolean assoc, boolean depth) {
        Map<String, Object> map = new HashMap<>();
        try {
            JSONObject jsonObj = new JSONObject(json);
            map = jsonObjectToMap(jsonObj);
        } catch (Exception e) {
            // Error handling if needed
        }
        return map;
    }

    // Helper function to mimic jsonencode (using org.json)
    public static String jsonencode(Map<String, Object> map) {
        return new JSONObject(map).toString();
    }

    // Helper function to mimic urldecodef
    public static String urldecodef(String s) {
        try {
            return URLDecoder.decode(s, "UTF-8");
        } catch (Exception e) {
            return s;
        }
    }

    // Helper function to mimic urlencodef
    public static String urlencodef(String s) {
        try {
            return URLEncoder.encode(s, "UTF-8");
        } catch (Exception e) {
            return s;
        }
    }

    // Helper function for transaction update simulation
    public static void trans_updatesf(String tr_newid, Map<String, Object> updateData) {
        System.out.println("Transaction update for: " + tr_newid + " with data: " + updateData.toString());
    }

    // Helper function to mimic jsonen (outputs JSON and exits)
    public static void jsonen(Map<String, Object> json_arr_res) {
        System.out.println(new JSONObject(json_arr_res).toString());
        System.exit(0);
    }

    // Helper function to mimic stf (string formatting)
    public static String stf(Object s) {
        return s != null ? s.toString() : "";
    }

    // Dummy function to mimic get_currency, returns a currency symbol
    public static String get_currency(String orderCurrency) {
        if (orderCurrency.equals("USD")) {
            return "$";
        } else if (orderCurrency.equals("EUR")) {
            return "€";
        }
        return orderCurrency;
    }

    // Converts a JSONObject to a Map<String, Object>
    public static Map<String, Object> jsonObjectToMap(JSONObject jsonObj) {
        Map<String, Object> map = new HashMap<>();
        Iterator<String> keys = jsonObj.keys();
        while (keys.hasNext()) {
            String key = keys.next();
            Object value = jsonObj.get(key);
            if (value instanceof JSONObject) {
                map.put(key, jsonObjectToMap((JSONObject) value));
            } else {
                map.put(key, value);
            }
        }
        return map;
    }

    // Helper function to mimic PHP include by reading and outputting file content
    public static void include(String filePath) {
        try {
            String content = new String(Files.readAllBytes(Paths.get(filePath)));
            System.out.println("Included file content:\n" + content);
        } catch (IOException e) {
            System.out.println("Error including file: " + filePath);
            System.exit(0);
        }
    }
}
