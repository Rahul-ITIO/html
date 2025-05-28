if (session.getAttribute("step") != null) {
    session.removeAttribute("step");
}
if (session.getAttribute("acquirer_action") != null) {
    session.removeAttribute("acquirer_action");
}
if (session.getAttribute("acquirer_response") != null) {
    session.removeAttribute("acquirer_response");
}
if (session.getAttribute("acquirer_status_code") != null) {
    session.removeAttribute("acquirer_status_code");
}
if (session.getAttribute("acquirer_transaction_id") != null) {
    session.removeAttribute("acquirer_transaction_id");
}
if (session.getAttribute("acquirer_descriptor") != null) {
    session.removeAttribute("acquirer_descriptor");
}
if (session.getAttribute("curl_values") != null) {
    session.removeAttribute("curl_values");
}
if (session.getAttribute("s30_count") != null) {
    session.removeAttribute("s30_count");
}
if (session.getAttribute("3ds2_auth") != null) {
    session.removeAttribute("3ds2_auth");
}
if (session.getAttribute("b_" + acquirer + "_acquirer_descriptor") != null && !((String) session.getAttribute("b_" + acquirer + "_acquirer_descriptor")).trim().isEmpty()) {
    session.setAttribute("acquirer_descriptor", (String) session.getAttribute("b_" + acquirer + "_acquirer_descriptor"));
}
List<String> tr_upd_order_0 = new ArrayList<>();
String api_root = data.get("Path") + "/";
String otp_sample_url = data.get("Host") + "/test3dsecureauthentication" + data.get("ex") + "?transID=" + transID + ctest;
String process = data.get("Host") + "/secure/process" + data.get("ex");
String auth_3ds2 = data.get("Host") + "/secure/auth_3ds2" + data.get("ex");
String authurl = data.get("Host") + "/authurl" + data.get("ex") + "?transID=" + transID;
String return_url = data.get("Host") + "/return_url" + file_v + data.get("ex") + "?transID=" + transID + "&action=redirect";
String trans_processing = data.get("Host") + "/trans_processing" + file_v + data.get("ex") + "?transID=" + transID + "&action=status";
String intent_process_url = data.get("Host") + "/intent_process" + file_v + data.get("ex") + "?transID=" + transID + "&action=authurl";
String indian_qr_url = data.get("Host") + "/payin/indian-qr" + data.get("ex") + "?transID=" + transID + "&orderId=" + transID + "&action=chart";
String chart_url = data.get("Host") + "/payin/chart" + data.get("ex") + "?transID=" + transID;
String chart_qr_code_url = data.get("Host") + "/payin/chart_qr_code" + data.get("ex") + "?transID=" + transID;
String qr_code_url = data.get("Host") + "/payin/qr_code" + data.get("ex") + "?transID=" + transID;
String dba = session.getAttribute("info_data").get("company_name");
boolean hkipass = false;
boolean hktrust = false;
boolean ac_25 = false;
boolean fht_ac = false;
boolean rebill_ac = false;
if (request.getParameter("ctest") != null) {
    apJson.put("apJson_f", session.getAttribute("acquirer_processing_json" + acquirer));
    trans_updatesf(session.getAttribute("tr_newid"), apJson);
}
Map<String, String> browserOs1 = browserOs("1");
String browserOs = new Gson().toJson(browserOs1);
String country_two = get_country_code(post.get("bill_country"));
post.put("country_two", country_two);
post.put("country_iso3", get_country_code(post.get("bill_country"), 3));
if (post.get("acquirer") != null && !post.get("acquirer").trim().isEmpty()) {
    acquirer = post.get("acquirer");
} else if (post.get("acquirer") != null && !post.get("acquirer").trim().isEmpty()) {
    acquirer = post.get("acquirer");
}
acquirer_payin = acquirer;
if (session.getAttribute("b_" + acquirer + "_default_acquirer") != null && !((String) session.getAttribute("b_" + acquirer + "_default_acquirer")).trim().isEmpty()) {
    acquirer_payin = (String) session.getAttribute("b_" + acquirer + "_default_acquirer");
}



// set the common condition for acquirer wise Application programming interface 

if (acquirer_payin != null && !acquirer_payin.trim().isEmpty() && session.getAttribute("mode" + acquirer) == 1 && !testcardno && !scrubbedstatus && session.getAttribute("b_" + acquirer + "_acquirer_status") == 1) 
{
    tr_upd_order_0 = new ArrayList<>();
    if (session.getAttribute("curr") != null) {
        orderCurrency = (String) session.getAttribute("curr");
    } else {
        orderCurrency = ((String) session.getAttribute("currency" + acquirer));
    }
    session.setAttribute("currency" + acquirer, orderCurrency);
    session.setAttribute("total_payment", total_payment);
    orderCurrencySymbol = get_currency(orderCurrency);
    Map<String, String> apc_json = jsondecode((String) session.getAttribute("b_" + acquirer + "_acquirer_processing_creds"), 1, 1);
    Map<String, String> apc_get = new HashMap<>();
    if (session.getAttribute("b_" + acquirer + "_acquirer_prod_mode") == 2) {
        apc_get = apc_json.get("test") != null ? apc_json.get("test") : apc_json;
        bank_url = (String) session.getAttribute("b_" + acquirer + "_acquirer_uat_url");
        apc_get.put("mode", "test");
    } else {
        apc_get = apc_json.get("live") != null ? apc_json.get("live") : apc_json;
        bank_url = (String) session.getAttribute("b_" + acquirer + "_acquirer_prod_url");
        apc_get.put("mode", "live");
    }
    tr_upd_order_0.put("acquirer_processing_creds", jsonencode(apc_get));
    String acquirer_status_url = session.getAttribute("b_" + acquirer + "_acquirer_status_url") != null && !((String) session.getAttribute("b_" + acquirer + "_acquirer_status_url")).trim().isEmpty() ? (String) session.getAttribute("b_" + acquirer + "_acquirer_status_url") : "";
    String acquirer_refund_url = session.getAttribute("b_" + acquirer + "_acquirer_refund_url") != null && !((String) session.getAttribute("b_" + acquirer + "_acquirer_refund_url")).trim().isEmpty() ? (String) session.getAttribute("b_" + acquirer + "_acquirer_refund_url") : "";
    if (acquirer_status_url != null) {
        tr_upd_order_0.put("acquirer_status_url", acquirer_status_url);
    }
    if (acquirer_refund_url != null) {
        tr_upd_order_0.put("acquirer_refund_url", acquirer_refund_url);
    }
    db_trf(session.getAttribute("tr_newid"), "acquirer_creds_processing_final", apc_get);
    Map<String, String> apj = new HashMap<>();
    if (session.getAttribute("b_" + acquirer + "_acquirer_prod_mode") == 1) {
        if (session.getAttribute("apJson" + acquirer) != null && !((String) session.getAttribute("apJson" + acquirer)).trim().isEmpty()) {
            apj = jsondecode((String) session.getAttribute("apJson" + acquirer), 1, 1);
            for (Map.Entry<String, String> entry : apj.entrySet()) {
                String ke = entry.getKey();
                String va = entry.getValue();
                if (va != null && va instanceof Map && ke != null && ke instanceof String) {
                    apc_get.put(ke, json_encode(va));
                } else if (va != null && va instanceof String && ke != null && ke instanceof String) {
                    apc_get.put(ke, va);
                }
            }
        }
    }
    tr_upd_order_0.put("acquirer_processing_json", jsonencode(apj));
    String apc_get_en = jsonencode(apc_get);
    apc_get = jsondecode(apc_get_en, 1, 1);
    int trans_auto_expired = session.getAttribute("b_" + acquirer + "_trans_auto_expired") != null && !((String) session.getAttribute("b_" + acquirer + "_trans_auto_expired")).trim().isEmpty() ? Integer.parseInt((String) session.getAttribute("b_" + acquirer + "_trans_auto_expired")) : 5;
    double set_trans_auto_expired = 59978.53333333333 * trans_auto_expired;
    if (acquirer_wl_domain != null && !acquirer_wl_domain.trim().isEmpty()) {
        acquirer_wl_domain = (String) session.getAttribute("b_" + acquirer + "_acquirer_wl_domain");
    } else {
        acquirer_wl_domain = data.get("Host");
    }
    String check_status = "status" + data.get("ex") + "?transID=" + transID + "&action=redirect";
    String status_url = acquirer_wl_domain + "/" + check_status;
    String status_url_1 = acquirer_wl_domain + "/status" + data.get("ex") + "?transID=" + transID;
    String status_default_url = acquirer_wl_domain + "/payin/pay" + acquirer_payin + "/status_" + acquirer_payin + data.get("ex") + "?transID=" + transID;
    String webhook_url = acquirer_wl_domain + "/payin/pay" + acquirer_payin + "/handler_" + acquirer_payin + data.get("ex") + "?transID=" + transID + "&action=webhook";
    String webhookhandler = acquirer_wl_domain + "/payin/pay" + acquirer_payin + "/webhookhandler_" + acquirer_payin + data.get("ex");
    String webhookhandler_url = acquirer_wl_domain + "/payin/pay" + acquirer_payin + "/webhookhandler_" + acquirer_payin + data.get("ex") + "?transID=" + transID;
    String reprocess_url = acquirer_wl_domain + "/payin/pay" + acquirer_payin + "/reprocess_" + acquirer_payin + data.get("ex") + "?transID=" + transID;
    if (session.getAttribute("select_mcc") != null && !((String) session.getAttribute("select_mcc")).trim().isEmpty()) {
        select_mcc_code = (String) session.getAttribute("select_mcc");
    } else {
        select_mcc_code = "";
    }
    tr_upd_order_0.add("s30_count=4");
    tr_upd_order_0.add("default_mid=" + acquirer_payin);
    tr_upd_order_0.add("host_" + acquirer + "=" + data.get("Host"));
    tr_upd_order_0.add("status_" + acquirer + "=" + check_status);
    tr_upd_order_0.add("status_url=" + status_url);
    tr_upd_order_0.add("bank_url" + acquirer + "=" + bank_url);
    tr_upd_order_0.add("acquirer_logo=" + acquirer_logo_f(acquirer));
    tr_upd_order_0.add("trans_auto_expired=" + (session.getAttribute("b_" + acquirer + "_trans_auto_expired") != null && !((String) session.getAttribute("b_" + acquirer + "_trans_auto_expired")).trim().isEmpty() ? (String) session.getAttribute("b_" + acquirer + "_trans_auto_expired") : ""));
    if (select_mcc_code != null && !select_mcc_code.trim().isEmpty()) {
        tr_upd_order_0.add("select_mcc_code=" + select_mcc_code);
    }
    if (qrcode_ajax != null && qrcode_ajax == 1) {
        tr_upd_order_0.add("qrcode_ajax=qrcodeadd");
    }
    if (request.getHeader("User-Agent") != null && !request.getHeader("User-Agent").trim().isEmpty()) {
        tr_upd_order_0.add("HTTP_USER_AGENT=" + request.getHeader("User-Agent"));
    }
    trans_updatesf(session.getAttribute("tr_newid"), tr_upd_order_0);
}





String reference = request.getParameter("reference");
String opener_transID = "<script>var transID='" + transID + "'; var varTransID='" + transID + "'; var varReferenceNo='" + reference + "'; if (window.opener && window.opener.document) { opener.transID='" + transID + "'; opener.varTransID='" + transID + "'; opener.varReferenceNo='" + reference + "'; opener.trans_auto_expired=" + set_trans_auto_expired + "; } </script>";
String opener_script = session.getAttribute("opener_script") + opener_transID + "<script> if (window.opener && window.opener.document) { opener.pendingCheckStartf();} </script>";
if (request.getParameter("actionajax") != null && !request.getParameter("actionajax").trim().isEmpty() && request.getParameter("actionajax").equals("ajaxJsonArray")) {
    post.put("actionajax", "ajaxJsonArray");
}
if (popup_msg_f != null && !popup_msg_f.trim().isEmpty()) {
    tr_upd_order_111.put("acquirer_redirect_popup_msg", popup_msg_f);
}
if (re_post_less_than_step != null && re_post_less_than_step > 0) {
    if (session.getAttribute("json_value") == null || ((Map<String, Object>) session.getAttribute("json_value")).get("post") == null) {
        ((Map<String, Object>) session.getAttribute("json_value")).put("post", new HashMap<String, Object>());
    }
    if (((Map<String, Object>) session.getAttribute("json_value")).get("post").get("countPost") == null) {
        ((Map<String, Object>) session.getAttribute("json_value")).get("post").put("countPost", 0);
    }
    ((Map<String, Object>) session.getAttribute("json_value")).get("post").put("countPost", ((int) ((Map<String, Object>) session.getAttribute("json_value")).get("post").get("countPost")) + 1);
    tr_upd_order_111.put("countPost", ((Map<String, Object>) session.getAttribute("json_value")).get("post").get("countPost"));
    if (errorMsg != null) {
        tr_upd_order_111.put("errorMsg", errorMsg);
    }
    trans_updatesf(session.getAttribute("tr_newid"), tr_upd_order_111);
    if (session.getAttribute("transID") != null && !((String) session.getAttribute("transID")).trim().isEmpty() && ((Map<String, Object>) session.getAttribute("json_value")).get("post").get("countPost") != null && (int) ((Map<String, Object>) session.getAttribute("json_value")).get("post").get("countPost") < re_post_less_than_step) {
        String integration_type = (String) session.getAttribute("re_post.integration-type");
        String re_post_url = "";
        if (session.getAttribute("re_post.integration-type") != null && ((String) session.getAttribute("re_post.integration-type")).equals("s2s")) {
            re_post_url = data.get("Host") + "/directapi" + data.get("ex");
        } else {
            re_post_url = data.get("Host") + "/checkout" + data.get("ex");
        }
        String dataPost_step = json_encode(session.getAttribute("re_post"));
        out.println("<script>");
        out.println("function redirect_payin_post_f2(url, data) {");
        out.println("var form = document.createElement('form');");
        out.println("document.body.appendChild(form);");
        out.println("form.method = 'post';");
        out.println("form.target = '_top';");
        out.println("form.action = url;");
        out.println("for (var name in data) {");
        out.println("var input = document.createElement('input');");
        out.println("input.type = 'hidden';");
        out.println("input.name = name;");
        out.println("input.value = data[name];");
        out.println("form.appendChild(input);");
        out.println("}");
        out.println("form.submit();");
        out.println("}");
        out.println("var re_post_url = '" + re_post_url + "';");
        out.println("var dataPost_step = " + dataPost_step + ";");
        out.println("setTimeout(function(){");
        out.println("redirect_payin_post_f2(re_post_url,dataPost_step);");
        out.println("}, 2000);");
        out.println("</script>");
    }
}
if (qr_intent_address != null && !qr_intent_address.trim().isEmpty()) {
    if (isMobileDevice()) {
        if (without_intent != null && without_intent == 1) {
            payment_url = urldecodef(qr_intent_address);
            session.setAttribute("3ds2_auth.payaddress", qr_intent_address);
        } else {
            intent_paymentUrl = qr_intent_address;
            session.setAttribute("3ds2_auth.payaddress", qr_intent_address);
        }
    } else {
        generate_qr_code = qr_intent_address;
        generate_qr_code = generate_qr_code.replaceAll("[\\r\\n\\t]+", "");
        generate_qr_code = generate_qr_code.replaceAll(" ", "+");
        web_base_qrcode = 1;
        session.setAttribute("3ds2_auth.payaddress", qr_intent_address);
    }
}
if (intent_paymentUrl != null && !intent_paymentUrl.trim().isEmpty()) {
    intent_paymentUrl = urldecodef(intent_paymentUrl);
    tr_upd_order_111.put("qrUpi", intent_paymentUrl);
    if (without_intent_function != null && without_intent_function == 1) {
    } else {
        if (request.getParameter("actionajax") != null && request.getParameter("actionajax").trim().equals("ajaxJsonArray")) {
            json_arr_setUrl = intent_payment_array_url_f(intent_paymentUrl, "", 1);
            intent_paymentUrl = json_arr_setUrl.get("otherApps");
        } else {
            intent_paymentUrl = intent_payment_url_f(intent_paymentUrl, post.get("wallet_code_app"), 1);
        }
    }
    data.put("intent_paymentUrl", intent_paymentUrl);
    session.setAttribute("intent_paymentUrl", intent_paymentUrl);
    if (intent_paymentUrl != null && intent_paymentUrl instanceof String) {
        payment_url = urldecodef(intent_paymentUrl);
    }
    tr_upd_order_111.put("pay_mode", "3D");
    tr_upd_order_111.put("wallet_code_app_intent", post.get("wallet_code_app"));
    tr_upd_order_111.put("pay_url", intent_paymentUrl);
    tr_upd_order_111.put("intent_paymentUrl", intent_paymentUrl);
    session.setAttribute("SA.intent_acitve", 1);
    mobile_android_base_intent = 1;
    session.setAttribute("3ds2_auth.payaddress", intent_paymentUrl);
    tr_upd_order_111.put("intent_process_include", intent_process_include);
}
if (web_base_qrcode_international != null && web_base_qrcode_international) {
    session.setAttribute("3ds2_auth.payaddress", web_base_qrcode_international);
    payment_url = indian_qr_url = qr_code_url;
    web_base_qrcode = 1;
    qrcode_ajax = 1;
}
if (redirect_3d_url != null && redirect_3d_url) {
    tr_upd_order_111.put("redirect_3d_url", redirect_3d_url);
    tr_upd_order_111.put("auth_url", redirect_3d_url);
    payment_url = redirect_3d_url;
    authf(session.getAttribute("tr_newid"), redirect_3d_url);
}
if (secure_process != null && secure_process) {
    session.setAttribute("redirect_url", secure_process);
    tr_upd_order_111.put("auth_url", secure_process);
    tr_upd_order_111.put("secure_process", process);
    payment_url = process;
    authf(session.getAttribute("tr_newid"), secure_process);
}
if (auth_3ds2_secure != null && auth_3ds2_secure) {
    if (auth_3ds2_base64 != null && auth_3ds2_base64) {
        session.setAttribute("3ds2_auth.base64", "base64_decode");
    }
    if (auth_3ds2_action != null && auth_3ds2_action) {
        session.setAttribute("3ds2_auth.action", auth_3ds2_action);
    }
    if (json_arr_set.check_acquirer_status_in_realtime != null && json_arr_set.check_acquirer_status_in_realtime) {
        session.setAttribute("3ds2_auth.check_acquirer_status_in_realtime", json_arr_set.check_acquirer_status_in_realtime);
    }
    if (popup_msg_f != null && popup_msg_f && popup_msg_f.matches(".*(?i)(redirect|newtab).*")) {
        payment_url = auth_3ds2;
        tr_upd_order_111.put("action_type", popup_msg_f);
    } else {
        if (post.actionajax == null) {
            post.put("actionajax", "ajaxJsonArray");
        }
        json_arr_set.auth_3ds2 = auth_3ds2;
        tr_upd_order_111.put("action_type", post.actionajax);
    }
    session.setAttribute("3ds2_auth.payaddress", auth_3ds2_secure);
    tr_upd_order_111.put("auth_url", auth_3ds2);
    tr_upd_order_111.put("auth_data", auth_3ds2_secure);
    tr_upd_order_111.put("authurl", authurl);
    authf(session.getAttribute("tr_newid"), auth_3ds2, session.getAttribute("3ds2_auth"));
}
if (session.getAttribute("3ds2_auth") != null && !((Map<String, Object>) session.getAttribute("3ds2_auth")).isEmpty()) {
    session.setAttribute("3ds2_auth.processed", status_url);
    if (session.getAttribute("3ds2_auth.paytitle") == null) {
        session.setAttribute("3ds2_auth.paytitle", session.getAttribute("dba"));
    }
    session.setAttribute("3ds2_auth.currname", orderCurrency);
    session.setAttribute("3ds2_auth.payamt", total_payment);
    if (tr_upd_order_0.get("trans_auto_expired") > 0) {
        session.setAttribute("3ds2_auth.auto_expired", tr_upd_order_0.get("trans_auto_expired"));
    }
    String appName = session.getAttribute("dba") != null ? session.getAttribute("dba") : "";
    if (data.appName != null && !data.appName.trim().isEmpty()) {
        appName = data.appName;
    }
    if (post.wallet_code_app != null && !post.wallet_code_app.trim().isEmpty()) {
        appName = post.wallet_code_app;
    }
    if (session.getAttribute("3ds2_auth.appName") == null) {
        session.setAttribute("3ds2_auth.appName", appName);
    }
    session.setAttribute("3ds2_auth.bill_currency", session.getAttribute("bill_currency"));
    session.setAttribute("3ds2_auth.bill_amt", session.getAttribute("bill_amt") != null && !((String) session.getAttribute("bill_amt")).trim().isEmpty() ? session.getAttribute("bill_amt") : total_payment);
    session.setAttribute("3ds2_auth.payaddress", intent_paymentUrl);
    tr_upd_order_111.put("pay_mode", "3D");
    tr_upd_order_111.put("wallet_code_app_intent", post.wallet_code_app);
    tr_upd_order_111.put("pay_url", intent_paymentUrl);
    tr_upd_order_111.put("intent_paymentUrl", intent_paymentUrl);
    session.setAttribute("SA.intent_acitve", 1);
    mobile_android_base_intent = 1;
    session.setAttribute("3ds2_auth.payaddress", intent_paymentUrl);
    tr_upd_order_111.put("intent_process_include", intent_process_include);
}
String reference = request.getParameter("reference");
String opener_transID = "<script>var transID='" + transID + "'; var varTransID='" + transID + "'; var varReferenceNo='" + reference + "'; if (window.opener && window.opener.document) { opener.transID='" + transID + "'; opener.varTransID='" + transID + "'; opener.varReferenceNo='" + reference + "'; opener.trans_auto_expired=" + set_trans_auto_expired + "; } </script>";
String opener_script = session.getAttribute("opener_script") + opener_transID + "<script> if (window.opener && window.opener.document) { opener.pendingCheckStartf();} </script>";
if (request.getParameter("actionajax") != null && !request.getParameter("actionajax").trim().isEmpty() && request.getParameter("actionajax").equals("ajaxJsonArray")) {
    post.put("actionajax", "ajaxJsonArray");
}
if (popup_msg_f != null && !popup_msg_f.trim().isEmpty()) {
    tr_upd_order_111.put("acquirer_redirect_popup_msg", popup_msg_f);
}
if (re_post_less_than_step != null && re_post_less_than_step > 0) {
    if (session.getAttribute("json_value") == null || ((Map<String, Object>) session.getAttribute("json_value")).get("post") == null) {
        ((Map<String, Object>) session.getAttribute("json_value")).put("post", new HashMap<String, Object>());
    }
    if (((Map<String, Object>) session.getAttribute("json_value")).get("post").get("countPost") == null) {
        ((Map<String, Object>) session.getAttribute("json_value")).get("post").put("countPost", 0);
    }
    ((Map<String, Object>) session.getAttribute("json_value")).get("post").put("countPost", ((int) ((Map<String, Object>) session.getAttribute("json_value")).get("post").get("countPost")) + 1);
    tr_upd_order_111.put("countPost", ((Map<String, Object>) session.getAttribute("json_value")).get("post").get("countPost"));
    if (errorMsg != null) {
        tr_upd_order_111.put("errorMsg", errorMsg);
    }
    trans_updatesf(session.getAttribute("tr_newid"), tr_upd_order_111);
    if (session.getAttribute("transID") != null && !((String) session.getAttribute("transID")).trim().isEmpty() && ((Map<String, Object>) session.getAttribute("json_value")).get("post").get("countPost") != null && (int) ((Map<String, Object>) session.getAttribute("json_value")).get("post").get("countPost") < re_post_less_than_step) {
        String integration_type = (String) session.getAttribute("re_post.integration-type");
        String re_post_url = "";
        if (session.getAttribute("re_post.integration-type") != null && ((String) session.getAttribute("re_post.integration-type")).equals("s2s")) {
            re_post_url = data.get("Host") + "/directapi" + data.get("ex");
        } else {
            re_post_url = data.get("Host") + "/checkout" + data.get("ex");
        }
        String dataPost_step = json_encode(session.getAttribute("re_post"));
        out.println("<script>");
        out.println("function redirect_payin_post_f2(url, data) {");
        out.println("var form = document.createElement('form');");
        out.println("document.body.appendChild(form);");
        out.println("form.method = 'post';");
        out.println("form.target = '_top';");
        out.println("form.action = url;");
        out.println("for (var name in data) {");
        out.println("var input = document.createElement('input');");
        out.println("input.type = 'hidden';");
        out.println("input.name = name;");
        out.println("input.value = data[name];");
        out.println("form.appendChild(input);");
        out.println("}");
        out.println("form.submit();");
        out.println("}");
        out.println("var re_post_url = '" + re_post_url + "';");
        out.println("var dataPost_step = " + dataPost_step + ";");
        out.println("setTimeout(function(){");
        out.println("redirect_payin_post_f2(re_post_url,dataPost_step);");
        out.println("}, 2000);");
        out.println("</script>");
    }
}
if (qr_intent_address != null && !qr_intent_address.trim().isEmpty()) {
    if (isMobileDevice()) {
        if (without_intent != null && without_intent == 1) {
            payment_url = urldecodef(qr_intent_address);
            session.setAttribute("3ds2_auth.payaddress", qr_intent_address);
        } else {
            intent_paymentUrl = qr_intent_address;
            session.setAttribute("3ds2_auth.payaddress", qr_intent_address);
        }
    } else {
        generate_qr_code = qr_intent_address;
        generate_qr_code = generate_qr_code.replaceAll("[\\r\\n\\t]+", "");
        generate_qr_code = generate_qr_code.replaceAll(" ", "+");
        web_base_qrcode = 1;
        session.setAttribute("3ds2_auth.payaddress", qr_intent_address);
    }
}
if (intent_paymentUrl != null && !intent_paymentUrl.trim().isEmpty()) {
    intent_paymentUrl = urldecodef(intent_paymentUrl);
    tr_upd_order_111.put("qrUpi", intent_paymentUrl);
    if (without_intent_function != null && without_intent_function == 1) {
    } else {
        if (request.getParameter("actionajax") != null && request.getParameter("actionajax").trim().equals("ajaxJsonArray")) {
            json_arr_setUrl = intent_payment_array_url_f(intent_paymentUrl, "", 1);
            intent_paymentUrl = json_arr_setUrl.get("otherApps");
        } else {
            intent_paymentUrl = intent_payment_url_f(intent_paymentUrl, post.get("wallet_code_app"), 1);
        }
    }
    data.put("intent_paymentUrl", intent_paymentUrl);
    session.setAttribute("intent_paymentUrl", intent_paymentUrl);
    if (intent_paymentUrl != null && intent_paymentUrl instanceof String) {
        payment_url = urldecodef(intent_paymentUrl);
    }
    tr_upd_order_111.put("pay_mode", "3D");
    tr_upd_order_111.put("wallet_code_app_intent", post.get("wallet_code_app"));
    tr_upd_order_111.put("pay_url", intent_paymentUrl);
    tr_upd_order_111.put("intent_paymentUrl", intent_paymentUrl);
    session.setAttribute("SA.intent_acitve", 1);
    mobile_android_base_intent = 1;
    session.setAttribute("3ds2_auth.payaddress", intent_paymentUrl);
    tr_upd_order_111.put("intent_process_include", intent_process_include);
}
String reference = request.getParameter("reference");
String opener_transID = "<script>var transID='" + transID + "'; var varTransID='" + transID + "'; var varReferenceNo='" + reference + "'; if (window.opener && window.opener.document) { opener.transID='" + transID + "'; opener.varTransID='" + transID + "'; opener.varReferenceNo='" + reference + "'; opener.trans_auto_expired=" + set_trans_auto_expired + "; } </script>";
String opener_script = session.getAttribute("opener_script") + opener_transID + "<script> if (window.opener && window.opener.document) { opener.pendingCheckStartf();} </script>";
if (request.getParameter("actionajax") != null && !request.getParameter("actionajax").trim().isEmpty() && request.getParameter("actionajax").equals("ajaxJsonArray")) {
    post.put("actionajax", "ajaxJsonArray");
}
if (popup_msg_f != null && !popup_msg_f.trim().isEmpty()) {
    tr_upd_order_111.put("acquirer_redirect_popup_msg", popup_msg_f);
}
if (re_post_less_than_step != null && re_post_less_than_step > 0) {
    if (session.getAttribute("json_value") == null || ((Map<String, Object>) session.getAttribute("json_value")).get("post") == null) {
        ((Map<String, Object>) session.getAttribute("json_value")).put("post", new HashMap<String, Object>());
    }
    if (((Map<String, Object>) session.getAttribute("json_value")).get("post").get("countPost") == null) {
        ((Map<String, Object>) session.getAttribute("json_value")).get("post").put("countPost", 0);
    }
    ((Map<String, Object>) session.getAttribute("json_value")).get("post").put("countPost", ((int) ((Map<String, Object>) session.getAttribute("json_value")).get("post").get("countPost")) + 1);
    tr_upd_order_111.put("countPost", ((Map<String, Object>) session.getAttribute("json_value")).get("post").get("countPost"));
    if (errorMsg != null) {
        tr_upd_order_111.put("errorMsg", errorMsg);
    }
    trans_updatesf(session.getAttribute("tr_newid"), tr_upd_order_111);
    if (session.getAttribute("transID") != null && !((String) session.getAttribute("transID")).trim().isEmpty() && ((Map<String, Object>) session.getAttribute("json_value")).get("post").get("countPost") != null && (int) ((Map<String, Object>) session.getAttribute("json_value")).get("post").get("countPost") < re_post_less_than_step) {
        String integration_type = (String) session.getAttribute("re_post.integration-type");
        String re_post_url = "";
        if (session.getAttribute("re_post.integration-type") != null && ((String) session.getAttribute("re_post.integration-type")).equals("s2s")) {
            re_post_url = data.get("Host") + "/directapi" + data.get("ex");
        } else {
            re_post_url = data.get("Host") + "/checkout" + data.get("ex");
        }
        String dataPost_step = json_encode(session.getAttribute("re_post"));
        out.println("<script>");
        out.println("function redirect_payin_post_f2(url, data) {");
        out.println("var form = document.createElement('form');");
        out.println("document.body.appendChild(form);");
        out.println("form.method = 'post';");
        out.println("form.target = '_top';");
        out.println("form.action = url;");
        out.println("for (var name in data) {");
        out.println("var input = document.createElement('input');");
        out.println("input.type = 'hidden';");
        out.println("input.name = name;");
        out.println("input.value = data[name];");
        out.println("form.appendChild(input);");
        out.println("}");
        out.println("form.submit();");
        out.println("}");
        out.println("var re_post_url = '" + re_post_url + "';");
        out.println("var dataPost_step = " + dataPost_step + ";");
        out.println("setTimeout(function(){");
        out.println("redirect_payin_post_f2(re_post_url,dataPost_step);");
        out.println("}, 2000);");
        out.println("</script>");
    }
}
if (web_base_qrcode_international != null && web_base_qrcode_international) {
    session.setAttribute("3ds2_auth.payaddress", web_base_qrcode_international);
    payment_url = indian_qr_url = qr_code_url;
    web_base_qrcode = 1;
    qrcode_ajax = 1;
}
if (redirect_3d_url != null && redirect_3d_url) {
    tr_upd_order_111.put("redirect_3d_url", redirect_3d_url);
    tr_upd_order_111.put("auth_url", redirect_3d_url);
    payment_url = redirect_3d_url;
    authf(session.getAttribute("tr_newid"), redirect_3d_url);
}
if (secure_process != null && secure_process) {
    session.setAttribute("redirect_url", secure_process);
    tr_upd_order_111.put("auth_url", secure_process);
    tr_upd_order_111.put("secure_process", process);
    payment_url = process;
    authf(session.getAttribute("tr_newid"), secure_process);
}
if (auth_3ds2_secure != null && auth_3ds2_secure) {
    if (auth_3ds2_base64 != null && auth_3ds2_base64) {
        session.setAttribute("3ds2_auth.base64", "base64_decode");
    }
    if (auth_3ds2_action != null && auth_3ds2_action) {
        session.setAttribute("3ds2_auth.action", auth_3ds2_action);
    }
    if (json_arr_set.check_acquirer_status_in_realtime != null && json_arr_set.check_acquirer_status_in_realtime) {
        session.setAttribute("3ds2_auth.check_acquirer_status_in_realtime", json_arr_set.check_acquirer_status_in_realtime);
    }
    if (popup_msg_f != null && popup_msg_f && popup_msg_f.matches(".*(?i)(redirect|newtab).*")) {
        payment_url = auth_3ds2;
        tr_upd_order_111.put("action_type", popup_msg_f);
    } else {
        if (post.actionajax == null) {
            post.put("actionajax", "ajaxJsonArray");
        }
        json_arr_set.auth_3ds2 = auth_3ds2;
        tr_upd_order_111.put("action_type", post.actionajax);
    }
    session.setAttribute("3ds2_auth.payaddress", auth_3ds2_secure);
    tr_upd_order_111.put("auth_url", auth_3ds2);
    tr_upd_order_111.put("auth_data", auth_3ds2_secure);
    tr_upd_order_111.put("authurl", authurl);
    authf(session.getAttribute("tr_newid"), auth_3ds2, session.getAttribute("3ds2_auth"));
}


if (session.getAttribute("3ds2_auth") != null && (boolean) session.getAttribute("3ds2_auth")) {
    session.setAttribute("3ds2_auth.processed", status_url);
    if (!session.getAttribute("3ds2_auth.paytitle")) {
        session.setAttribute("3ds2_auth.paytitle", session.getAttribute("dba"));
    }
    session.setAttribute("3ds2_auth.currname", orderCurrency);
    session.setAttribute("3ds2_auth.payamt", total_payment);
    if (tr_upd_order_0.get("trans_auto_expired") > 0) {
        session.setAttribute("3ds2_auth.auto_expired", tr_upd_order_0.get("trans_auto_expired"));
    }
    String appName = (String) session.getAttribute("dba");
    if (data.containsKey("appName") && data.get("appName")) {
        appName = data.get("appName");
    }
    if (post.containsKey("wallet_code_app") && post.get("wallet_code_app")) {
        appName = post.get("wallet_code_app");
    }
    if (!session.getAttribute("3ds2_auth.appName")) {
        session.setAttribute("3ds2_auth.appName", appName);
    }
    session.setAttribute("3ds2_auth.bill_currency", session.getAttribute("bill_currency"));
    session.setAttribute("3ds2_auth.bill_amt", session.getAttribute("bill_amt") != null && !((String) session.getAttribute("bill_amt")).trim().isEmpty() ? session.getAttribute("bill_amt") : total_payment);
    session.setAttribute("3ds2_auth.product_name", session.getAttribute("product"));
    if (mobile_android_base_intent != null && mobile_android_base_intent) {
        if (data.containsKey("os_device") && data.get("os_device")) {
            session.setAttribute("3ds2_auth.os", data.get("os_device"));
        } else {
            session.setAttribute("3ds2_auth.os", "mobile_android");
        }
        session.setAttribute("3ds2_auth.mop", "upi_intent");
        String payaddress = (String) session.getAttribute("3ds2_auth.payaddress");
        if (payaddress != null && payaddress instanceof String) {
            tr_upd_order_111.put("auth_url", urldecodef(payaddress));
            authf(session.getAttribute("tr_newid"), payaddress, session.getAttribute("3ds2_auth"));
        }
    } else if (web_base_qrcode != null && web_base_qrcode) {
        session.setAttribute("3ds2_auth.os", "web");
        session.setAttribute("3ds2_auth.mop", "qrcode");
        if (qr_process_base64 != null && qr_process_base64 == 1) {
            session.setAttribute("3ds2_auth.qrcode_base", "base64");
        }
        tr_upd_order_111.put("auth_url", indian_qr_url);
        authf(session.getAttribute("tr_newid"), indian_qr_url, session.getAttribute("3ds2_auth"));
        if (qrcode_ajax == null) {
            process_url = indian_qr_url;
        } else {
            process_url = trans_processing;
        }
    }
    tr_upd_order_111.put("auth_data", htmlentitiesf(session.getAttribute("3ds2_auth")));
    session.setAttribute("acquirer_status_code", 1);
}
if (data.get("cqp") == 6) {
    System.out.println("<br/>auth_3ds2_secure=>" + auth_3ds2_secure);
    System.out.println("<br/>auth_3ds2=>" + auth_3ds2);
    System.out.println("<br/>3ds2_auth=>");
    System.out.println(session.getAttribute("3ds2_auth"));
    System.exit(0);
}
tr_upd_order_111.put("payment_url", payment_url != null ? payment_url : "");
tr_upd_order_111.put("process_url", process_url != null ? process_url : "");
if (session.getAttribute("acquirer_status_code") != null && !session.getAttribute("acquirer_status_code").toString().isEmpty()) {
    tr_upd_order_111.put("acquirer_status_code", session.getAttribute("acquirer_status_code"));
}
if (session.getAttribute("acquirer_response") != null && !session.getAttribute("acquirer_response").toString().isEmpty()) {
    tr_upd_order_111.put("acquirer_response", session.getAttribute("acquirer_response"));
}
if (session.getAttribute("acquirer_transaction_id") != null && !session.getAttribute("acquirer_transaction_id").toString().isEmpty()) {
    tr_upd_order_111.put("acquirer_transaction_id", session.getAttribute("acquirer_transaction_id"));
}
if (session.getAttribute("acquirer_descriptor") != null && !session.getAttribute("acquirer_descriptor").toString().isEmpty()) {
    tr_upd_order_111.put("acquirer_descriptor", session.getAttribute("acquirer_descriptor"));
}
if (tr_upd_order_111 != null && !tr_upd_order_111.isEmpty()) {
    trans_updatesf(session.getAttribute("tr_newid"), tr_upd_order_111);
}
##############################################################
curl_values_arr.put("browserOsInfo", browserOs);
session.setAttribute("curl_values", curl_values_arr);
##############################################################
if (post.get("integration-type").equals("s2s")) {
    //include("success_curl".$data['iex']);
} else {
    if (payment_url != null && !payment_url.isEmpty()) {
        session.setAttribute("acquirer_status_code", 1);
        process_url = payment_url;
    }
    if (post.get("actionajax") != null && (post.get("actionajax").equals("ajaxIntentUrl") || post.get("actionajax").equals("ajaxIntentArrayUrl")) && session.getAttribute("3ds2_auth.payaddress") != null && !session.getAttribute("3ds2_auth.payaddress").toString().isEmpty()) {
        generate_intent_url = session.getAttribute("3ds2_auth.payaddress");
    } else if (qrcode_ajax != null && qrcode_ajax == 1 && session.getAttribute("3ds2_auth.payaddress") != null && !session.getAttribute("3ds2_auth.payaddress").toString().isEmpty()) {
        generate_qr_code = session.getAttribute("3ds2_auth.payaddress");
    }
    if (json_arr_set != null && !json_arr_set.isEmpty() && json_arr_set instanceof Map && post.get("actionajax") != null && (post.get("actionajax").equals("ajaxIntentArrayUrl") || post.get("actionajax").equals("ajaxJsonArray"))) {
        json_arr_set.put("DONE_AJAX", "DONE_AJAX");
        json_arr_res = json_arr_set;
        json_arr_res.put("transID", transID);
        json_arr_res.put("varTransID", transID);
        json_arr_res.put("varReferenceNo", reference);
        json_arr_res.put("trans_auto_expired", set_trans_auto_expired);
        session.setAttribute("json_arr_res", json_arr_res);
        jsonen(json_arr_res);
    } else if (generate_intent_url != null && !generate_intent_url.isEmpty() && generate_intent_url instanceof String && post.get("actionajax") != null && post.get("actionajax").equals("ajaxIntentUrl")) {
        generate_intent_url = urldecodef(generate_intent_url);
        System.out.println("<script>\n" +
                "                var transID='$transID';\n" +
                "                var varTransID='$transID';\n" +
                "                var varReferenceNo='$reference';\n" +
                "                var trans_auto_expired=$set_trans_auto_expired; \n" +
                "            </script>");
        System.out.println("<a DONE_AJAX class=\"appOpenUrl nopopup suButton btn btn-icon btn-primary mx_button_2\" href=\"" + generate_intent_url + "\"  title=\"" + orderCurrencySymbol + total_payment + " paying to " + dba + " \" target=\"_blank\" onclick=\"processingf();\">Open</a> ");
        System.exit(0);
    } else if (generate_qr_code != null && !generate_qr_code.isEmpty() && post.get("actionajax") != null && post.get("actionajax").equals("ajaxQrCode")) {
        generate_qr_code = urldecodef(generate_qr_code);
        generate_qr_code = urlencodef(generate_qr_code);
        reference = request.getParameter("reference");
        System.out.println("<script>\n" +
                "                //parent.window.transID='$transID';\n" +
                "                var transID='$transID';\n" +
                "                var varTransID='$transID';\n" +
                "                var varReferenceNo='$reference';\n" +
                "                var trans_auto_expired=$set_trans_auto_expired; \n" +
                "            </script>");
        if (qr_process_base64 != null && qr_process_base64 == 1) {
            System.out.println("<img DONE_AJAX src=\"data:image/gif;base64," + generate_qr_code + "\" title=\"" + orderCurrencySymbol + total_payment + " paying to " + dba + " \" width=\"140\" />");
        } else {
            System.out.println("<img DONE_AJAX src=\"https://quickchart.io/chart?chs=160x160&cht=qr&chl=" + generate_qr_code + "&choe=UTF-8\" title=\"" + orderCurrencySymbol + total_payment + " paying to " + dba + " \" />");
        }
        System.exit(0);
    } else if (intent_paymentUrl != null && !intent_paymentUrl.isEmpty() && intent_process_redirect != null && intent_process_redirect == 1) {
        System.out.println(opener_script);
        response.sendRedirect(intent_process_url.trim());
        System.exit(0);
    } else if (intent_paymentUrl != null && !intent_paymentUrl.isEmpty() && intent_process_include != null && intent_process_include == 1) {
        data.put("config_root", 1);
        System.out.println(opener_script);
        include(data.get("Path") + "/intent_process" + data.get("iex"));
    } else if (!process_url.isEmpty()) {
        System.out.println(opener_script);
        response.sendRedirect(process_url.trim());
        System.exit(0);
    } else {
        System.out.println(opener_script);
        data.put("Error", 7004);
        System.out.println(data.get("Message") = "Could not established secure connection");
        //error_print($data['Error'],$data['Message']);
    }
    System.exit(0);
}
##### end: dynamic acquirer include for path of payin  ###############
//test_response
boolean test_response = false;
String test_process_url = "";
if (scrubbedstatus) {
    test_response = true;
    if (scrubbed_msg != null) {
        scrubbed_msg = URLEncoder.encode(scrubbed_msg);
    }
    test_process_url = return_url + ctest;
    //header("location:$test_process_url");exit;
} else if ((card_type.equals("2D") || card_type.equals("3D")) && (post.get("integration-type").equals("Encode-Checkout") || post.get("integration-type").toLowerCase().equals("encode-checkout")) && (!scrubbedstatus && acquirer.isEmpty())) { // otp
    test_response = true;
    //echo $opener_script;
    test_process_url = otp_sample_url;
} else if (testcardno) { // success
    test_response = true;
    test_process_url = return_url + ctest;
}
//s2s 2d
if (test_response && !test_process_url.isEmpty()) {
    Map<String, Object> data_send = new HashMap<>();
    data_send.put("transID", transID);
    data_send.put("acquirer_action", 1);
    if ((request.getParameter("ctest")) != null) {
        data_send.put("ctest", request.getParameter("ctest"));
    }
    if (post.get("integration-type").equals("s2s")) {
        if (card_type.equals("2D") || card_type.equals("3D")) {
            Map<String, Object> auth_otp = new HashMap<>();
            //$auth_otp['Error']="7001";
            auth_otp.put("transID", session.getAttribute("transID"));
            auth_otp.put("authurl", data.get("Host") + "/authurl" + data.get("ex") + "?transID=" + session.getAttribute("transID"));
            json_print(auth_otp);
            System.exit(0);
        } else {
            request.setAttribute("transID", session.getAttribute("transID"));
            //$use_curl=use_curl($test_process_url,$data_send);
            //exit;
        }
    } else {
        int channel_type_b = (int) session.getAttribute("b_" + acquirer + ".channel_type");
        if (channel_type_b != null && channel_type_b == 3) {
            json_arr_set.put("auth_3ds2", otp_sample_url);
        } else {
            json_arr_set.put("realtime_response_url", test_process_url);
        }
        json_arr_res = json_arr_set;
        json_arr_res.put("DONE_AJAX", "DONE_AJAX");
        json_arr_res.put("transID", transID);
        json_arr_res.put("varTransID", transID);
        json_arr_res.put("varReferenceNo", reference);
        json_arr_res.put("trans_auto_expired", set_trans_auto_expired);
        json_arr_res.put("channel_type", channel_type_b);
        json_arr_res.put("mop", request.getParameter("mop"));
        json_arr_res.put("testcardno", testcardno);
        json_arr_res.put("card_type", card_type);
        session.setAttribute("json_arr_res", json_arr_res);
        jsonen(json_arr_res);
        //echo $opener_script; header("Location:$test_process_url"); exit;
    }
}



