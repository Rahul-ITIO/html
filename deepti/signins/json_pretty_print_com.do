<? 
include('../config_db.do');
//header("Content-Type: application/json", true);	
if(isset($_REQUEST['strip'])){
	$array = ($_REQUEST['json']);
}else{
	$array = strip_tags($_REQUEST['json']);
}

$array = decryptres($array);
$strip_tags = strip_tags($array);

$array_flag = false;

$array_origin = $array;


if(isset($_REQUEST['strip'])){
	echo $array;
}else{
	$array = json_decode($array,1);
	$json_decode=$array;
	//print_r($json_decode);

?>
<style>
@import url("https://fonts.googleapis.com/css?family=Open+Sans:400,800,700,600");
@import url("https://fonts.googleapis.com/css?family=Raleway:400,600,700");
.hideText{text-indent:-999em;letter-spacing:-999em;overflow:hidden;}
*,a:focus{outline:none !important;}
button:focus{outline:none !important;}
button::-moz-focus-inner{border:0;}
body{font-family:'Open Sans',sans-serif;background:lightgrey;font-size:10pt;padding-bottom:35px;}

pre{font-weight:300;width:100%;margin:0 auto;padding:10px 20px;font-size:14px;line-height:20px;word-break:break-all;word-wrap:break-word;white-space:pre;white-space:pre-wrap;background-color:lightgrey;border:1px solid #ccc;border:1px solid rgba(0,0,0,0.15);-webkit-border-radius:4px;-moz-border-radius:4px;border-radius:4px;color:black;}
.inline-div {
    display:inline-block;
    margin-top: 50px;
}
.inline-txtarea {
    height:165px;
    margin-top: 5px;
}
p{
    height: 200px;
}
.div_resp{
    display: inline;
    text-align: left;
}
.Row {
    display: table;
    width: 100%; /*Optional*/
    table-layout: fixed; /*Optional*/
    border-spacing: 10px; /*Optional*/
    margin-top: -2px;
    word-break:normal;
}
.Column {
    display: table-cell;
}
</style>
<pre><?php
//if(is_array($json_decode)){
//	echo $json_encode=json_encode($array, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT | JSON_FORCE_OBJECT); // Now it's multiline and indented properly
//}else{
//	echo $strip_tags; // none json
//}

    $date = new DateTime();
    $timeZone = $date->getTimezone();
    $server_time_zone = $timeZone->getName();
    if (!array_key_exists("acquirer_id", $array)) {

//        unsset($array['post']['to_url']);
        $post_post = json_encode($array['post'], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT | JSON_FORCE_OBJECT);
        $post_requestPost = json_encode($array['requestPost'], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT | JSON_FORCE_OBJECT);
        $ar_i = json_encode($array);

        $post_creds = "";


        if ($array['mode'] && $array['login'] && $array['control'] && $array['base_url'] && $array['group_url']) {

            $post_creds = array(
                'mode' => $array['mode'],
                'login' => $array['login'],
                'control' => $array['control'],
                'acquirer_base_url' => $array['base_url'],
                'url_post_data' => $array['group_url'] . '' . $array['group']
            );

        }
        $post_creds = json_encode($post_creds, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT | JSON_FORCE_OBJECT);

        $post_date = date("Y-m-d H:i:s", strtotime("now"));
        $post_url = $array['group_url'] . '' . $array['group'];
        $post_acquirer_cut_prefix = explode("api/", $array['requestPost']['redirect_url'])[1];
        $post_acquirer = explode("/status", $post_acquirer_cut_prefix)[0];
        $post_responseRequest = $array["responseRequest"];
        $post_responseRequest = json_encode($post_responseRequest, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT | JSON_FORCE_OBJECT);


        $post_json_sign_status_sent = $array["signStatusRequest"];
        $post_json_sign_status_sent = json_encode($post_json_sign_status_sent, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT | JSON_FORCE_OBJECT);

        $post_postSignStatusRequest = $array["postSignStatusRequest"];
        $post_postSignStatusRequest = json_encode($post_postSignStatusRequest, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT | JSON_FORCE_OBJECT);

        $post_json_sign_status = $array["signStatusResponse"];
        $post_json_sign_status = json_encode($post_json_sign_status, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT | JSON_FORCE_OBJECT);


        $post_redirectResponse = $array["redirectResponse"];
        $post_redirectResponse = json_encode($post_redirectResponse, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT | JSON_FORCE_OBJECT);


        if (is_null($array)) {
            $array_flag = true;
        }

        if (!$array_flag) {
            $txn_value = json_encode($array, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT | JSON_FORCE_OBJECT);
        } else {
            $txn_value = $array_origin;
//        $txn_value = str_replace('{","','"',$txn_value);
//        $txn_value = json_encode($txn_value, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT | JSON_FORCE_OBJECT);

        }

        $steps_counter = 3;

        $step_1 = "";
        $step_2 = "";
        $step_3 = "";
        $step_4 = "";
        $step_5 = "";
        $step_6 = "";
        $step_7 = "";
        $step_8 = "";
        $step_9 = "";
        $step_10 = "";


        $step_7_flag = false;


        if (!($post_post == "null")) {
            $post_to_url = $array['post']['to_url'];
            $step_1 = "<div class=Column><p>Step: <b>1</b><br>Action: <b>Sent</b><br>URL: </strong><a href={$array['post']['to_url']}>{$array['post']['to_url']}</a><br>By: <b>Merchant</b><br>To: <b>GumballPayTech System</b><br>Data type: <b>Transaction info</b><br>Purpose: <b>Post data</b><br>Datetime: <b>{$array["post"]["datetime"]}</b></p><textarea rows=65 cols=60 class=inline-txtarea>$post_post</textarea></div>";
        }

        if (!($post_requestPost == "null")) {
            $step_2 = "<div class=Column><p style='margin-top: 63px;'>Step: <b>2</b><br>Action: <b>Adjust data and Sent</b><br>URL: </strong><a href=$post_url>$post_url</a><br>By: <b>GumballPayTech System</b><br>To: <b>Acquirer - $post_acquirer</b><br>Data type: <b>Transaction info</b><br>Purpose: <b>Post data</b><br>Datetime: <b>{$array["requestPost"]["datetime"]}</b></p><textarea rows=65 cols=60 class=inline-txtarea>$post_requestPost</textarea></div>";
        }

        if (!($post_creds == "null")) {
            $step_3 = "<div class=Column><p style='margin-top: 83px;'>Step: <b>$steps_counter</b><br>Action: <b>Sent</b><br>URL: </strong><a href=$post_url>$post_url</a><br>By: <b>GumballPayTech System</b><br>To: <b>Acquirer - $post_acquirer</b><br>Data type: <b>Merchant account login credentials</b><br>Purpose: <b>Post credentials</b><br>Datetime: <b>-</b></p><textarea rows=65 cols=60 class=inline-txtarea>$post_creds</textarea></div>";
        }

        if (!($post_responseRequest == "null")) {
            $steps_counter++;
            $step_4 = "<div class=Column><p style='margin-top: 83px;'>Step: <b>$steps_counter</b><br>Action: <b>Received</b><br>URL: <b>-</b><br>By: <b>Acquirer - $post_acquirer</b><br>To: <b>GumballPayTech System</b><br>Data type: <b>Data for polling transaction status</b><br>Purpose: <b>Get data</b><br>Datetime: <b>{$array["responseRequest"]["datetime"]}</b></p><textarea rows=65 cols=60 class=inline-txtarea>$post_responseRequest</textarea></div>";

        }


        if (!($post_json_sign_status_sent == "null")) {
            $steps_counter++;
            $step_5 = "<div class=Column><p style='margin-top: 83px;'>Step: <b>$steps_counter</b><br>Action: <b>Sent</b><br>URL: </strong><a href='https://lior.gumballpaytech.com/sign_status.do'>https://lior.gumballpaytech.com/sign_status.do</a><br>By: <b>Merchant</b><br>To: <b>GumballPayTech System</b><br>Data type: <b>Data for polling transaction status</b><br>Purpose: <b>Post data</b><br>Datetime: <b>{$array["signStatusRequest"]["datetime"]}</b></p><textarea rows=65 cols=60 class=inline-txtarea>$post_json_sign_status_sent</textarea></div>";


        }

        if (!($post_postSignStatusRequest == "null")) {
            $steps_counter++;
            $step_6 = "<div class=Column><p style='margin-top: 83px;'>Step: <b>$steps_counter</b><br>Action: <b>Sent</b><br>URL: </strong><a href='https://sandbox.gumballpay.com/paynet/api/v2/status/group/1611'>https://sandbox.gumballpay.com/paynet/api/v2/status/group/1611</a><br>By: <b>GumballPayTech System</b><br>To: <b>Acquirer - $post_acquirer</b><br>Data type: <b>Data for polling transaction status</b><br>Purpose: <b>Post data</b><br>Datetime: <b>{$array["postSignStatusRequest"]["datetime"]}</b></p><textarea rows=65 cols=60 class=inline-txtarea>$post_postSignStatusRequest</textarea></div>";
        }


        if (!($post_json_sign_status == "null")) {
            $steps_counter++;
            $step_7 = "<div class=Column><p style='margin-top: 65px;'>Step: <b>$steps_counter</b><br>Action: <b>Received</b><br>URL: <b>-</b><br>By: <b>Acquirer - $post_acquirer</b><br>To: <b>GumballPayTech System</b><br>Data type: <b>Trandaction data & Redirect url</b><br>Puropse: <b>Get data</b><br>Datetime: <b>{$array["signStatusResponse"]["datetime"]}</b></p><textarea rows=65 cols=60 class=inline-txtarea>$post_json_sign_status</textarea></div>";
            $step_7_flag = true;
        }


        if (!($post_redirectResponse == "null")) {
            $steps_counter++;
            $step_8 = "<div class=Row><div class=Column><p style='margin-top: 83px;'>Step: <b>$steps_counter</b><br>Action: <b>Sent</b><br>URL: </strong><a href={$array["signStatusResponse"]["redirect-to"]}>{$array["signStatusResponse"]["redirect-to"]}</a><br>By: <b>Merchant</b><br>To: <b>Acquirer - $post_acquirer</b><br>Data type: <b>Status request</b><br>Purpose: <b>Get status info</b><br>Datetime: <b>{$array["redirectResponse"]["datetime"]}</b></p><textarea rows=65 cols=70 class=inline-txtarea></textarea></div>";
            $steps_counter++;
            $step_9 = "<p style='margin-top: 83px;'>Step: <b>$steps_counter</b><br>Action: <b>Sent</b><br>URL: <b>-</b><br>By: <b>Acquirer - $post_acquirer</b><br>To: <b>-</b><br>Data type: <b>Status details</b><br>Purpose: <b>Send status details</b><br>Datetime: <b>{$array["redirectResponse"]["datetime"]}</b></p><textarea rows=65 cols=70 class=inline-txtarea>$post_redirectResponse</textarea></div></div>";
        }


        if (($step_4 == "") || ($step_5 == "") || ($step_6 == "") || ($step_7 == "")) {
            $step_7 = $step_7 . "" . "</div>";
        } else {
            $step_7 = "</div>" . "" . $step_7;
        }


        if ($step_1 == "" && $step_2 == "" && $step_4 == "" && $step_5 == "" && $step_6 == "" && $step_8 == "" && $step_9 == "" && !$step_7_flag) {
            $step_3 = "";
            $step_10 = "<div class=Column><p style='margin-top: 65px;'>Action: <b>Received</b><br>URL: <b>-</b><br>By: <b>Acquirer - $post_acquirer</b><br>To: <b>GumballPayTech System</b><br>Data type: <b>Acquirer bank data</b><br>Puropse: <b>Get data</b><br>Datetime: <b>{$array["signStatusResponse"]["datetime"]}</b></p><textarea rows=70 cols=175 class=inline-txtarea style='word-break: break-word;'>$txn_value</textarea></div>";
        }

        if ($step_10 != "") {
            echo $step_10;
        } else {
            echo "<span style='margin-top: 30px; position: fixed;'>Time Zone: <b>{$server_time_zone}</b></span><div class=Row>
$step_1
$step_2
$step_3
</div>
<div class=Row>
$step_4
$step_5
$step_6
$step_7
$step_8
$step_9
$step_10";
        }
    }
    else{
        $post_post = json_encode($array['post'], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT | JSON_FORCE_OBJECT);
        $step_1 = "<div class=Column><p>Step: <b>1</b><br>Action: <b>Sent</b><br>URL: </strong><a href={$array['post']['to_url']}>{$array['post']['to_url']}</a><br>By: <b>Merchant</b><br>To: <b>GumballPayTech System</b><br>Data type: <b>Transaction info</b><br>Purpose: <b>Post data</b><br>Datetime: <b>{$array["post"]["datetime"]}</b></p><textarea rows=65 cols=60 class=inline-txtarea>$post_post</textarea></div>";


        $step_2_res = $array["step_1"]["request"];
        $step_2_res = json_encode($step_2_res, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT | JSON_FORCE_OBJECT);


        $step_2 = "<div class=Column><p>Step: <b>2</b><br>Action: <b>Sent</b><br>URL: </strong><a href={$array['step_1']['request']['to_url']}>{$array['step_1']['request']['to_url']}</a><br>By: <b>GumballPayTech System</b><br>To: <b>Acquirer - {$array['acquirer_id']} </b><br>Data type: <b>Transaction info</b><br>Purpose: <b>Post data</b><br>Datetime: <b>{$array["post"]["datetime"]}</b></p><textarea rows=65 cols=60 class=inline-txtarea>$step_2_res</textarea></div>";

        $step_1_acquirer_response = $array["step_1"]["acquirer_response"];
        $step_1_acquirer_response = json_encode($step_1_acquirer_response, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT | JSON_FORCE_OBJECT);
        $step_3 = "<div class=Column><p>Step: <b>3</b><br>Action: <b>Received</b><br>URL: </strong> - <br>By: <b>GumballPayTech System </b><br>From: <b>Acquirer - {$array['acquirer_id']}</b><br>Data type: <b>Acquirer transaction info</b><br>Purpose: <b>Get data</b><br>Datetime: <b>{$array["post"]["datetime"]}</b></p><textarea rows=65 cols=60 class=inline-txtarea>$step_1_acquirer_response</textarea></div>";


        $step_2_request = $array['step_2']["request"];
        $step_2_request = json_encode($step_2_request, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT | JSON_FORCE_OBJECT);
        $step_4 = "<div class=Column><p>Step: <b>4</b><br>Action: <b>Sent</b><br>URL: </strong><a href={$array['step_2']['request']['to_url']}>{$array['step_2']['request']['to_url']}</a><br>By: <b>GumballPayTech System</b><br>To: <b>Acquirer - {$array['acquirer_id']}</b><br>Data type: <b>Acquirer transaction info</b><br>Purpose: <b>Post data</b><br>Datetime: <b>{$array["post"]["datetime"]}</b></p><textarea rows=65 cols=60 class=inline-txtarea>$step_2_request</textarea></div>";

        $step_2_acquirer_response = $array['step_2']["acquirer_response"];
        $step_2_acquirer_response = json_encode($step_2_acquirer_response, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT | JSON_FORCE_OBJECT);
        $step_5 = "<div class=Column><p>Step: <b>5</b><br>Action: <b>Received</b><br>URL: </strong> - <br>By: <b>Merchant</b><br><b>From: GumballPayTech System </b><br>Data type: <b>Acquirer transaction info</b><br>Purpose: <b>Get data</b><br>Datetime: <b>{$array['step_2']["acquirer_response_datetime"]}</b></p><textarea rows=65 cols=60 class=inline-txtarea>$step_2_acquirer_response</textarea></div>";


        $step_3_merchant_request = $array['step_3']['merchant_request'];
        $step_3_merchant_request = json_encode($step_3_merchant_request, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT | JSON_FORCE_OBJECT);
        $step_6 = "<div class=Column><p>Step: <b>6</b><br>Action: <b>Sent</b><br>URL: </strong><a href={$array["step_3"]["merchant_request_url"]}>{$array['step_3']['merchant_request_url']}</a><br>By: <b>Merchant</b><br>To: <b>GumballPayTech System</b><br>Data type: <b>Acquirer transaction status info</b><br>Purpose: <b>Post data</b><br>Datetime: <b>{$array["step_3"]["merchant_request_datetime"]}</b></p><textarea rows=65 cols=60 class=inline-txtarea>$step_3_merchant_request</textarea></div>";


        $step_4_system_request = $array['step_4']['system_request'];
        $step_4_system_request = json_encode($step_4_system_request, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT | JSON_FORCE_OBJECT);
        $step_7 = "<div class=Column><p>Step: <b>7</b><br>Action: <b>Sent</b><br>URL: </strong><a href={$array["step_4"]["system_request_url"]}>{$array["step_4"]["system_request_url"]}</a><br>By: <b>GumballPayTech System</b><br>To: <b>Merchant</b><br>Data type: <b>Merchant transaction status info</b><br>Purpose: <b>Post data</b><br>Datetime: <b>{$array["step_4"]["system_request_datetime"]}</b></p><textarea rows=65 cols=60 class=inline-txtarea>$step_4_system_request</textarea></div>";

        $step_5_merchant_request = $array['step_5']['merchant_request'];
        $step_5_merchant_request = json_encode($step_5_merchant_request, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT | JSON_FORCE_OBJECT);
        $step_8 = "<div class=Column><p>Step: <b>7</b><br>Action: <b>Sent</b><br>URL: </strong><a href={$array["step_5"]["merchant_request_url"]}>{$array["step_5"]["merchant_request_url"]}</a><br>By: <b>Merchant</b><br>To: <b>GumballPayTech System</b><br>Data type: <b>Merchant transaction status info</b><br>Purpose: <b>Get transaction status</b><br>Datetime: <b>{$array["step_5"]["merchant_request_datetime"]}</b></p><textarea rows=65 cols=60 class=inline-txtarea>$step_5_merchant_request</textarea></div>";




        echo "<span >Time Zone: <b>{$server_time_zone}</b></span><div class=Row>
        $step_1
        $step_2
        $step_3
        </div>
<div class=Row>
        $step_4
        $step_5
        $step_6
                </div>
<div class=Row>
        $step_7
        $step_8";
    }
    ?></pre>
<?}?>
