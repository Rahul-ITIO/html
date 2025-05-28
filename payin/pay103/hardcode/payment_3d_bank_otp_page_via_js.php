<?php
if(!isset($_SESSION)) {
	session_start(); 
	//session_regenerate_id(true); 
}
// http://localhost:8080/gw/payin/pay103/hardcode/payment_3d_bank_otp_page_via_js.php

// https://ipg.i15.tech/payin/pay103/hardcode/payment_3d_bank_otp_page_via_js.php

//{"merchant_id":"GLADRASHKEN","api_password_key":"b7e502f1b9955b7135cce1dd985aa501","authorization":"bWVyY2hhbnQuR0xBRFJBU0hLRU46YjdlNTAyZjFiOTk1NWI3MTM1Y2NlMWRkOTg1YWE1MDE="}


$data['cqp']=1;

$merchant_id='GLADRASHKEN';
$merchant_base_url="https://ap-gateway.mastercard.com/api/rest/version/78/merchant/".$merchant_id;

$apiUsername='merchant.'.$merchant_id;
$PWD='b7e502f1b9955b7135cce1dd985aa501'; // api 
$AuthorizationBasic='Basic bWVyY2hhbnQuR0xBRFJBU0hLRU46YjdlNTAyZjFiOTk1NWI3MTM1Y2NlMWRkOTg1YWE1MDE=';
$redirectUrl='https://aws-cc-uat.web1.one/responseDataList/?urlaction=redirectUrl_mastercard';
$redirectUrl='https://ipg.i15.tech/responseDataList/?urlaction=success_auth3d_mpgs';

$prefix_url='ap';
//$prefix_url='test';


echo "<hr/><br/>AuthorizationBasic=>".$AuthorizationBasic;

$AuthorizationBasic='Basic '.base64_encode("merchant.$merchant_id:$PWD");

echo "<hr/><br/>AuthorizationBasic=>".$AuthorizationBasic;
//exit;


@$transID='devTech3ds103'.(new DateTime())->format('YmdHisu');
@$total_payment=0.01;
@$orderCurrency='USD';

//live visa 

$post['ccno']='4147673003870003';
$post['month']='03';
$post['year']='29';
$post['ccvv']='383';


// 
/*
$post['ccno']='4281021015248691';
$post['month']='03';
$post['year']='28';
$post['ccvv']='049';
*/

$_SESSION['bill_ip']='122.176.92.114';



##### start - GLADCORIGKEN SAM FOR 3D JS - 1_create : session id ###############################################################

$url_step_1=$merchant_base_url."/session";

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => $url_step_1,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
    CURLOPT_HEADER => 0,
    CURLOPT_SSL_VERIFYPEER => 0,
    CURLOPT_SSL_VERIFYHOST => 0,
    CURLOPT_POSTFIELDS =>'{
        "session": {
            "authenticationLimit": 25
        }
    }',
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/json',
    'Authorization: '.$AuthorizationBasic
  ),
));

$response_1 = curl_exec($curl);

curl_close($curl);
//echo $response_1;

/*

{
    "merchant": "GLADRASHKEN",
    "result": "SUCCESS",
    "session": {
        "aes256Key": "kEo7nOoziZofpdSkYl1eUbjeyXUF22sx+mix2HIZy+s=",
        "authenticationLimit": 25,
        "id": "SESSION0002404553563L76033492H7",
        "updateStatus": "NO_UPDATE",
        "version": "d2c00eec01"
    }
}

*/

//echo "<br/><hr/>session=>".$response=urldecode('https://view?'.$response); parse_str(parse_url($response_1, PHP_URL_QUERY), $response_1_via_create); 

$response_1_via_create=json_decode($response_1,1);
$get_session_id=$_SESSION['session_id']=@$response_1_via_create['session']['id'];

$tr_upd_order1['url_step_1']=$url_step_1;
$tr_upd_order1['response_1_via_create']=isset($response_1_via_create)&&$response_1_via_create?$response_1_via_create:($response_1);

if($data['cqp']>0) 
{
    echo "<hr/><br/>url_step_1=>".$url_step_1;
    echo "<br/>response_1_via_create=><br/>";
    print_r($response_1_via_create);
    echo "<br/>";
    echo "<br/>session_id=>".$get_session_id."<br/>";
}

##### end - 1_create : session id ###############################################################















##### start - 02. PAY VIA JS REQUEST  ########################


// "notificationUrl": "'.$webhookhandler_url.'"

$postData_2='{
    "order": {
        "currency": "'.@$orderCurrency.'",
        "amount": '.$total_payment.',
        "id": "'.$transID.'",
        "reference": "'.$transID.'",
        "notificationUrl": "https://ipg.i15.tech/responseDataList/?urlaction=notify_102_3d_js"
    },
    "authentication": {
        "channel": "PAYER_BROWSER",
        "redirectResponseUrl": "https://ipg.i15.tech/payin/pay103/hardcode/pay_method_on_response_otp.php?&transID='.$transID.'&get_session_id='.$get_session_id.'&urlaction=redirectResponseUrl_103_3d_js"
    },
    "transaction": {
        "id": "'.$transID.'"
    },
    "sourceOfFunds": {
        "provided": {
            "card": {
                "number": "'.$post['ccno'].'",
                "securityCode": "'.$post['ccvv'].'",
                "expiry": {
                    "month": "'.$post['month'].'",
                    "year": "'.$post['year'].'"
                }
            }
        },
        "type": "CARD"
    }
}';


// https://ap-gateway.mastercard.com/api/rest/version/78/merchant/GLADRASHKEN/session/SESSION0002404553563L76033492H7
$url_step_2=$url_step_1."/".$get_session_id;

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => $url_step_2,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'PUT',
    CURLOPT_HEADER => 0,
    CURLOPT_SSL_VERIFYPEER => 0,
    CURLOPT_SSL_VERIFYHOST => 0,
  CURLOPT_POSTFIELDS =>$postData_2,
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/json',
    'Authorization: '.$AuthorizationBasic
  ),
));

$response_2 = curl_exec($curl);

curl_close($curl);
//echo $response_2;

$response_2_via_card=json_decode($response_2,1);
$html_data='';

if(isset($response_2_via_card['authentication']['redirect']['html'])){
    $html_data=$_SESSION['html_data']=@$response_2_via_card['authentication']['redirect']['html'];
    unset($response_2_via_card['authentication']['redirect']['html']);
}

$acsUrl='';
$cReq='';
$form_post='';

/*
if(isset($response_2_via_card['authentication']['customizedHtml']['3ds2']['acsUrl']))
{
    $acsUrl=@$response_2_via_card['authentication']['customizedHtml']['3ds2']['acsUrl'];
    $cReq=@$response_2_via_card['authentication']['customizedHtml']['3ds2']['cReq'];
    $form_post='<form name="myForm" id="myForm" action="'.$acsUrl.'" target="_blank" method="post"><input type="text" name="cReq"  placeholder="Enter" value="'.$cReq.'"  style="padding:5px 20px;line-height:40px; clear:both;width:94%;"  required /><input type="submit" value="SUBMIT" class="button"  style="padding:0 30px;height:54px;line-height:54px;clear:both;width:97%;margin:20px 0;" /></form>';
}
*/

$tr_upd_order1['url_step_2']=$url_step_2;
$tr_upd_order1['response_2_via_card']=isset($response_2_via_card)&&$response_2_via_card?$response_2_via_card:($response_2);

if($data['cqp']>0) 
{
    echo "<hr/><br/>url_step_2=>".$url_step_2;
    echo "<br/>response_2_via_card=><br/>";
    print_r($response_2_via_card);
    echo "<br/>";
    echo "<br/>postData_2=><br/>";
    print_r($postData_2);
    echo "<br/><br/>html=><br/>";
    echo "<br/>".htmlentities(@$html_data)."<br/>";
}

echo "<hr/><br/>form_post=><br/>";
if(isset($form_post)&&!empty($form_post)){
    echo $form_post;
}

/*
echo "<hr/><br/>html_data=><br/>";
if(isset($html_data)&&!empty($html_data)){
    echo "<br/><br/><a href=\"html_data.php\" target=\"_blank\" style=\"font-family:'Open Sans',sans-serif;font-weight:425;width: 310px;display:block;margin:0 auto;padding:10px 20px;font-size: 18px;line-height:26px;word-break:break-all;word-wrap:break-word;white-space:pre;white-space:pre-wrap;background-color:#f6f4f4;border:1px solid #ccc;border:1px solid rgba(0,0,0,.15);-webkit-border-radius:4px;-moz-border-radius:4px;border-radius:4px;color: #079c10;text-decoration: none;text-align: center;\">REDIRECT TO AUTH 3D PAYLOAD</a><br/><br/>";
}

*/

/*

{
    "authentication": {
        "channel": "PAYER_BROWSER",
        "redirectResponseUrl": "https://ipg.i15.tech/responseDataList/?urlaction=notify_102_3d_js"
    },
    "merchant": "GLADRASHKEN",
    "order": {
        "amount": "0.1",
        "currency": "USD",
        "id": "devJS3D23",
        "reference": "devJS3D23"
    },
    "session": {
        "id": "SESSION0002404553563L76033492H7",
        "updateStatus": "SUCCESS",
        "version": "50baa51302"
    },
    "sourceOfFunds": {
        "provided": {
            "card": {
                "brand": "VISA",
                "expiry": {
                    "month": "3",
                    "year": "29"
                },
                "fundingMethod": "CREDIT",
                "number": "414767xxxxxx0003",
                "scheme": "VISA",
                "securityCode": "xxx"
            }
        },
        "type": "CARD"
    },
    "transaction": {
        "id": "devJS3D23"
    },
    "version": "78"
}

*/


##### end - 02. PAY VIA JS REQUEST ########################









##### start - 03. Initiate 3DS Authentication after JS REQUEST : response gatewayCode ####################################################

// https://ap-gateway.mastercard.com/api/rest/version/78/merchant/GLADRASHKEN/order/devJS3D23/transaction/devJS3D23
$url_step_3=$merchant_base_url.'/order/'.$transID.'/transaction/'.$transID;



$postData_3='{
    "apiOperation":"INITIATE_AUTHENTICATION",
	"authentication":{ 
		"acceptVersions":"3DS1,3DS2",
	    "channel":"PAYER_BROWSER",
	    "purpose":"PAYMENT_TRANSACTION"
	},
    "correlationId": "'.$transID.'",
    "order": {
        "reference": "'.$transID.'",
        "currency": "'.$orderCurrency.'"
    },
    "session": {
		"id": "'.$get_session_id.'"
	},
	"transaction": {
		"reference": "'.$transID.'"
	}
}';



$curl = curl_init();


curl_setopt_array($curl, array(
    CURLOPT_URL => $url_step_3,
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_ENCODING => '',
    CURLOPT_MAXREDIRS => 10,
    CURLOPT_TIMEOUT => 0,
    CURLOPT_FOLLOWLOCATION => true,
    CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
    CURLOPT_CUSTOMREQUEST => 'PUT',
      CURLOPT_HEADER => 0,
      CURLOPT_SSL_VERIFYPEER => 0,
      CURLOPT_SSL_VERIFYHOST => 0,
    CURLOPT_POSTFIELDS =>$postData_3,
    CURLOPT_HTTPHEADER => array(
      'Content-Type: application/json',
      'Authorization: '.$AuthorizationBasic
    ),
  ));

$response_4 = curl_exec($curl);

curl_close($curl);
//echo $response_4;



$response_4_via_validate=json_decode($response_4,1);
$gatewayCode_response=@$response_4_via_validate['response']['gatewayCode'];

$tr_upd_order1['url_step_3']=$url_step_3;
$tr_upd_order1['response_4_via_validate']=isset($response_4_via_validate)&&$response_4_via_validate?$response_4_via_validate:($response_4);



if($data['cqp']>0) 
{
    echo "<hr/><br/>url_step_3=>".@$url_step_3;
    echo "<br/>response_4_via_validate=><br/>";
    print_r(@$response_4_via_validate);
    echo "<br/>";
    echo "<br/>postData_3=><br/>";
    print_r($postData_3);
    echo "<br/>";
    echo "<br/>gatewayCode_response=>".@$gatewayCode_response."<br/>";
}


/*

{
    "authentication": {
        "3ds2": {
            "authenticationScheme": "VISA",
            "directoryServerId": "A000000003",
            "methodCompleted": false,
            "methodSupported": "SUPPORTED",
            "protocolVersion": "2.2.0",
            "requestorId": "10065253*APGLADRASHKEN_MPGS",
            "requestorName": "Rash Reliance And Franchise Ltd"
        },
        "acceptVersions": "3DS1,3DS2",
        "channel": "PAYER_BROWSER",
        "purpose": "PAYMENT_TRANSACTION",
        "redirect": {
            "customizedHtml": {
                "3ds2": {
                    "methodPostData": "eyJ0aHJlZURTTWV0aG9kTm90aWZpY2F0aW9uVVJMIjoiaHR0cHM6Ly9hcC5nYXRld2F5Lm1hc3RlcmNhcmQuY29tL2NhbGxiYWNrSW50ZXJmYWNlL2dhdGV3YXkvZjMyYWQyNGFiYTZmYTUwMTIwZTk0OWEwNzg5OGM2OWYxOGM5OTAxYTk5NDIyYjI2OTBjMDE4ODFmZmYwZTExYSIsInRocmVlRFNTZXJ2ZXJUcmFuc0lEIjoiMjJjNjlhNGMtYjljYS00OTVkLWEwZTYtMjk3NmU1OTljYWQyIn0=",
                    "methodUrl": "https://secure-acs2ui-b1.wibmo.com/v1/acs/services/threeDSMethod/8235?cardType=V"
                }
            },
            "html": "<div id=\"initiate3dsSimpleRedirect\" xmlns=\"http://www.w3.org/1999/html\"> <iframe id=\"methodFrame\" name=\"methodFrame\" height=\"100\" width=\"200\" > </iframe> <form id =\"initiate3dsSimpleRedirectForm\" method=\"POST\" action=\"https://secure-acs2ui-b1.wibmo.com/v1/acs/services/threeDSMethod/8235?cardType=V\" target=\"methodFrame\"> <input type=\"hidden\" name=\"threeDSMethodData\" value=\"eyJ0aHJlZURTTWV0aG9kTm90aWZpY2F0aW9uVVJMIjoiaHR0cHM6Ly9hcC5nYXRld2F5Lm1hc3RlcmNhcmQuY29tL2NhbGxiYWNrSW50ZXJmYWNlL2dhdGV3YXkvZjMyYWQyNGFiYTZmYTUwMTIwZTk0OWEwNzg5OGM2OWYxOGM5OTAxYTk5NDIyYjI2OTBjMDE4ODFmZmYwZTExYSIsInRocmVlRFNTZXJ2ZXJUcmFuc0lEIjoiMjJjNjlhNGMtYjljYS00OTVkLWEwZTYtMjk3NmU1OTljYWQyIn0=\" /> </form> <script id=\"initiate-authentication-script\"> var e=document.getElementById(\"initiate3dsSimpleRedirectForm\"); if (e) { e.submit(); if (e.parentNode !== null) { e.parentNode.removeChild(e); } } </script> </div>"
        },
        "version": "3DS2"
    },
    "correlationId": "test",
    "merchant": "GLADRASHKEN",
    "order": {
        "authenticationStatus": "AUTHENTICATION_AVAILABLE",
        "creationTime": "2024-06-07T11:06:20.219Z",
        "currency": "USD",
        "id": "devJS3D23",
        "lastUpdatedTime": "2024-06-07T11:06:20.206Z",
        "merchantCategoryCode": "5734",
        "reference": "devJS3D23",
        "status": "AUTHENTICATION_INITIATED",
        "totalAuthorizedAmount": 0,
        "totalCapturedAmount": 0,
        "totalRefundedAmount": 0
    },
    "response": {
        "gatewayCode": "AUTHENTICATION_IN_PROGRESS",
        "gatewayRecommendation": "PROCEED"
    },
    "result": "SUCCESS",
    "sourceOfFunds": {
        "provided": {
            "card": {
                "brand": "VISA",
                "expiry": {
                    "month": "3",
                    "year": "29"
                },
                "fundingMethod": "CREDIT",
                "issuer": "KOTAK MAHINDRA BANK LTD",
                "number": "414767xxxxxx0003",
                "scheme": "VISA"
            }
        },
        "type": "CARD"
    },
    "timeOfLastUpdate": "2024-06-07T11:06:20.206Z",
    "timeOfRecord": "2024-06-07T11:06:20.219Z",
    "transaction": {
        "amount": 0,
        "authenticationStatus": "AUTHENTICATION_AVAILABLE",
        "currency": "USD",
        "id": "devJS3D23",
        "reference": "devJS3D23",
        "type": "AUTHENTICATION"
    },
    "version": "78"
}


*/


echo "<br/><br/><br/><hr/><br/>tr_upd_order1=><br/>";
print_r($tr_upd_order1);
echo "<br/>";

?>
<?php
if(!isset($_SESSION)) {
	session_start(); 
	//session_regenerate_id(true); 
}
// http://localhost:8080/gw/payin/pay103/hardcode/js3d.php
// https://ipg.i15.tech/payin/pay103/hardcode/js3d.php
?><!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>3DS Challenge Redirect via JS for Secure 2 Processing...</title>
</head>
<body >
<div id="threedsChallengeRedirect" xmlns="http://www.w3.org/1999/html" style="height: 100vh">
<script src="https://ap-gateway.mastercard.com/static/threeDS/1.3.0/three-ds.min.js"></script>
<script>
ThreeDS.configure({
    merchantId: "<?=@$merchant_id?>",
    sessionId: "<?=@$get_session_id?>",
    containerId: "3DSUI",
    callback: function () {
        if (ThreeDS.isConfigured()) {
            console.log("Done with configure");
        } else {
            console.error("3DS not configured");
        }
    },
    configuration: {
        userLanguage: "en-US",
        wsVersion: 78
    }
});
var optionalParams = {
    fullScreenRedirect: true,
    billing: {
        address: {
            city: "London",
            country: "GBR"
        }
    }
};
ThreeDS.authenticatePayer("<?=@$transID?>", "<?=@$transID?>", function (data) {
    if (!data.error) {
        //data.response will contain all the response payload from the AUTHENTICATE_PAYER call.
        console.log("REST API response ", data.restApiResponse);
        console.log("HTML redirect code", data.htmlRedirectCode);
        
    }
}, optionalParams);
</script>
</body>
</html>

