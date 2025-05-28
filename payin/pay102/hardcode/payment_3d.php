<?php
if(!isset($_SESSION)) {
	session_start(); 
	//session_regenerate_id(true); 
}
// http://localhost:8080/gw/payin/pay102/hardcode/payment_3d.php

// https://ipg.i15.tech/secure/payment_3d.php

$data['cqp']=1;

$merchant_id='GLADCORIGKEN';
$merchant_base_url="https://ap-gateway.mastercard.com/api/rest/version/78/merchant/".$merchant_id;

$apiUsername='merchant.'.$merchant_id;
$PWD='4d3f8e07b2c625d779b81c678086cc1d'; // api 
$AuthorizationBasic='Basic bWVyY2hhbnQuR0xBRENPUklHS0VOOjRkM2Y4ZTA3YjJjNjI1ZDc3OWI4MWM2NzgwODZjYzFk';
$redirectUrl='https://aws-cc-uat.web1.one/responseDataList/?urlaction=redirectUrl_mastercard';
$redirectUrl='https://ipg.i15.tech/responseDataList/?urlaction=success_auth3d_mpgs';

$prefix_url='ap';
//$prefix_url='test';



@$transID='102'.(new DateTime())->format('ymdHisu');
@$total_payment=0.01;
@$orderCurrency='USD';

//live visa 
/*
$post['ccno']='4147673003870003';
$post['month']='03';
$post['year']='29';
$post['ccvv']='383';
*/

// 
$post['ccno']='4281021015248691';
$post['month']='03';
$post['year']='28';
$post['ccvv']='049';
$_SESSION['bill_ip']='122.176.92.114';



##### start - 1_create : session id ###############################################################

$url_step_1=$merchant_base_url."/order/{$transID}/transaction/auth3d".$transID;

$postData_1='{
    "authentication": {
        "acceptVersions": "3DS1,3DS2",
        "channel": "PAYER_BROWSER",
        "purpose": "PAYMENT_TRANSACTION"
    },
    "correlationId": "'.$transID.'",
    "order": {
        "currency": "'.$orderCurrency.'"
    },
    "sourceOfFunds": {
        "provided": {
            "card": {
                "number": "'.$post['ccno'].'"
            }
        }
    },
    "apiOperation": "INITIATE_AUTHENTICATION"
}';

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => $url_step_1,
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
  CURLOPT_POSTFIELDS =>$postData_1,
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
    "authentication": {
        "3ds2": {
            "authenticationScheme": "VISA",
            "directoryServerId": "A000000003",
            "methodSupported": "NOT_SUPPORTED",
            "protocolVersion": "2.2.0",
            "requestorId": "10065253*APGLADCORIGKEN_MPGS",
            "requestorName": "CORIGUN INTERNATIONAL LIMITED"
        },
        "acceptVersions": "3DS1,3DS2",
        "channel": "PAYER_BROWSER",
        "purpose": "PAYMENT_TRANSACTION",
        "redirect": {
            "html": "<script id=\"initiate-authentication-script\"></script>"
        },
        "version": "3DS2"
    },
    "correlationId": "dev3dtest013",
    "merchant": "GLADCORIGKEN",
    "order": {
        "authenticationStatus": "AUTHENTICATION_AVAILABLE",
        "creationTime": "2024-04-20T08:53:44.079Z",
        "currency": "USD",
        "id": "dev3dtest013",
        "lastUpdatedTime": "2024-04-20T08:53:44.044Z",
        "merchantCategoryCode": "5943",
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
                "fundingMethod": "CREDIT",
                "number": "428102xxxxxx8691",
                "scheme": "VISA"
            }
        },
        "type": "CARD"
    },
    "timeOfLastUpdate": "2024-04-20T08:53:44.044Z",
    "timeOfRecord": "2024-04-20T08:53:44.079Z",
    "transaction": {
        "amount": 0,
        "authenticationStatus": "AUTHENTICATION_AVAILABLE",
        "currency": "USD",
        "id": "dev3dtest013",
        "type": "AUTHENTICATION"
    },
    "version": "78"
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















##### start - 2_Update_Amount_and_Card : session updateStatus_is_SUCCESS ########################




$postData_2='{
    "authentication": {
        "redirectResponseUrl": "'.$redirectUrl.'"
    },
    "correlationId": "'.$transID.'",
    "device": {
        "browser": "MOZILLA",
        "browserDetails": {
            "3DSecureChallengeWindowSize": "FULL_SCREEN",
            "acceptHeaders": "application/json",
            "colorDepth": 24,
            "javaEnabled": true,
            "language": "en-US",
            "screenHeight": 640,
            "screenWidth": 480,
            "timeZone": 273
        },
        "ipAddress": "'.$_SESSION['bill_ip'].'"
    },
    "order": {
        "amount": '.$total_payment.',
        "currency": "'.$orderCurrency.'"
    },
    "sourceOfFunds": {
        "provided": {
            "card": {
                "number": "'.$post['ccno'].'",
                "expiry": {
                    "month": "'.$post['month'].'",
                    "year": "'.$post['year'].'"
                },
                "securityCode": "'.$post['ccvv'].'"
            }
        }
    },
    "apiOperation": "AUTHENTICATE_PAYER"
}';


$url_step_2=$url_step_1;

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
if(isset($response_2_via_card['authentication']['customizedHtml']['3ds2']['acsUrl'])){
    $acsUrl=@$response_2_via_card['authentication']['customizedHtml']['3ds2']['acsUrl'];
    $cReq=@$response_2_via_card['authentication']['customizedHtml']['3ds2']['cReq'];
    $form_post='<form name="myForm" id="myForm" action="'.$acsUrl.'" target="_blank" method="post"><input type="text" name="cReq"  placeholder="Enter" value="'.$cReq.'"  style="padding:5px 20px;line-height:40px; clear:both;width:94%;"  required /><input type="submit" value="SUBMIT" class="button"  style="padding:0 30px;height:54px;line-height:54px;clear:both;width:97%;margin:20px 0;" /></form>';
}

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

echo "<hr/><br/>html_data=><br/>";
if(isset($html_data)&&!empty($html_data)){
    echo "<br/><br/><a href=\"html_data.php\" target=\"_blank\" style=\"font-family:'Open Sans',sans-serif;font-weight:425;width: 310px;display:block;margin:0 auto;padding:10px 20px;font-size: 18px;line-height:26px;word-break:break-all;word-wrap:break-word;white-space:pre;white-space:pre-wrap;background-color:#f6f4f4;border:1px solid #ccc;border:1px solid rgba(0,0,0,.15);-webkit-border-radius:4px;-moz-border-radius:4px;border-radius:4px;color: #079c10;text-decoration: none;text-align: center;\">REDIRECT TO AUTH 3D PAYLOAD</a><br/><br/>";
}

/*

{
    "authentication": {
        "3ds": {
            "transactionId": "9742d6a5-82a5-4b47-baa1-e70a8c56bdc7"
        },
        "3ds2": {
            "3dsServerTransactionId": "fcf66356-d0fe-48ec-a1cf-3e86809f4f88",
            "acsReference": "3DS_LOA_ACS_FSSP_020200_00440",
            "acsTransactionId": "28498ba6-9e1d-4445-acd3-c79b63b31582",
            "authenticationScheme": "VISA",
            "directoryServerId": "A000000003",
            "dsReference": "VISA.V 17 0003",
            "dsTransactionId": "9742d6a5-82a5-4b47-baa1-e70a8c56bdc7",
            "methodSupported": "NOT_SUPPORTED",
            "protocolVersion": "2.2.0",
            "requestorId": "10065253*APGLADCORIGKEN_MPGS",
            "requestorName": "CORIGUN INTERNATIONAL LIMITED",
            "transactionStatus": "C"
        },
        "amount": 11.01,
        "method": "DYNAMIC",
        "payerInteraction": "REQUIRED",
        "redirect": {
            "customizedHtml": {
                "3ds2": {
                    "acsUrl": "https://acs.fssnet.co.in/acsauthserveremv/IDFCCREDIT/V/creqBRW.htm",
                    "cReq": "eyJ0aHJlZURTU2VydmVyVHJhbnNJRCI6ImZjZjY2MzU2LWQwZmUtNDhlYy1hMWNmLTNlODY4MDlmNGY4OCIsImFjc1RyYW5zSUQiOiIyODQ5OGJhNi05ZTFkLTQ0NDUtYWNkMy1jNzliNjNiMzE1ODIiLCJjaGFsbGVuZ2VXaW5kb3dTaXplIjoiMDUiLCJtZXNzYWdlVHlwZSI6IkNSZXEiLCJtZXNzYWdlVmVyc2lvbiI6IjIuMi4wIn0"
                }
            },
            "domainName": "acs.fssnet.co.in",
            "html": "<div id=\"threedsChallengeRedirect\" xmlns=\"http://www.w3.org/1999/html\" style=\" height: 100vh\"> <form id =\"threedsChallengeRedirectForm\" method=\"POST\" action=\"https://acs.fssnet.co.in/acsauthserveremv/IDFCCREDIT/V/creqBRW.htm\" target=\"challengeFrame\"> <input type=\"hidden\" name=\"creq\" value=\"eyJ0aHJlZURTU2VydmVyVHJhbnNJRCI6ImZjZjY2MzU2LWQwZmUtNDhlYy1hMWNmLTNlODY4MDlmNGY4OCIsImFjc1RyYW5zSUQiOiIyODQ5OGJhNi05ZTFkLTQ0NDUtYWNkMy1jNzliNjNiMzE1ODIiLCJjaGFsbGVuZ2VXaW5kb3dTaXplIjoiMDUiLCJtZXNzYWdlVHlwZSI6IkNSZXEiLCJtZXNzYWdlVmVyc2lvbiI6IjIuMi4wIn0\" /> </form> <iframe id=\"challengeFrame\" name=\"challengeFrame\" width=\"100%\" height=\"100%\" ></iframe> <script id=\"authenticate-payer-script\"> var e=document.getElementById(\"threedsChallengeRedirectForm\"); if (e) { e.submit(); if (e.parentNode !== null) { e.parentNode.removeChild(e); } } </script> </div>"
        },
        "time": "2024-04-20T08:54:30.966Z",
        "version": "3DS2"
    },
    "correlationId": "dev3dtest013",
    "device": {
        "browser": "MOZILLA",
        "ipAddress": "122.176.92.114"
    },
    "merchant": "GLADCORIGKEN",
    "order": {
        "amount": 11.01,
        "authenticationStatus": "AUTHENTICATION_PENDING",
        "creationTime": "2024-04-20T08:53:44.079Z",
        "currency": "USD",
        "id": "dev3dtest013",
        "lastUpdatedTime": "2024-04-20T08:54:30.964Z",
        "merchantCategoryCode": "5943",
        "status": "AUTHENTICATION_INITIATED",
        "totalAuthorizedAmount": 0,
        "totalCapturedAmount": 0,
        "totalRefundedAmount": 0,
        "valueTransfer": {
            "accountType": "NOT_A_TRANSFER"
        }
    },
    "response": {
        "gatewayCode": "PENDING",
        "gatewayRecommendation": "PROCEED"
    },
    "result": "PENDING",
    "sourceOfFunds": {
        "provided": {
            "card": {
                "brand": "VISA",
                "expiry": {
                    "month": "3",
                    "year": "28"
                },
                "fundingMethod": "CREDIT",
                "number": "428102xxxxxx8691",
                "scheme": "VISA"
            }
        },
        "type": "CARD"
    },
    "timeOfLastUpdate": "2024-04-20T08:54:30.964Z",
    "timeOfRecord": "2024-04-20T08:53:44.079Z",
    "transaction": {
        "acquirer": {
            "merchantId": "GLADCORIGKEN033"
        },
        "amount": 11.01,
        "authenticationStatus": "AUTHENTICATION_PENDING",
        "currency": "USD",
        "id": "dev3dtest013",
        "type": "AUTHENTICATION"
    },
    "version": "78"
}

*/


##### end - 2_Update_Amount_and_Card : session updateStatus_is_SUCCESS ########################









##### start - 4_Validate : response gatewayCode ####################################################

$url_step_4=$merchant_base_url.'/order/'.$transID.'/transaction/auth3d'.$transID;

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => $url_step_4,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'GET',
  CURLOPT_HTTPHEADER => array(
    'Authorization: '.$AuthorizationBasic
  ),
));

$response_4 = curl_exec($curl);

curl_close($curl);
//echo $response_4;



$response_4_via_validate=json_decode($response_4,1);
$gatewayCode_response=@$response_4_via_validate['response']['gatewayCode'];

$tr_upd_order1['url_step_4']=$url_step_4;
$tr_upd_order1['response_4_via_validate']=isset($response_4_via_validate)&&$response_4_via_validate?$response_4_via_validate:($response_4);



if($data['cqp']>0) 
{
    echo "<hr/><br/>url_step_4=>".$url_step_4;
    echo "<br/>response_4_via_validate=><br/>";
    print_r($response_4_via_validate);
    echo "<br/>";
    echo "<br/>";
    echo "<br/>gatewayCode_response=>".$gatewayCode_response."<br/>";
}


/*

{
    "authorizationResponse": {
        "cardLevelIndicator": "C ",
        "cardSecurityCodeError": "M",
        "commercialCard": "!01",
        "commercialCardIndicator": "0",
        "date": "0417",
        "posData": "1025100006600",
        "posEntryMode": "812",
        "processingCode": "000000",
        "responseCode": "00",
        "returnAci": "M",
        "stan": "111333",
        "time": "101547",
        "transactionIdentifier": "404108369486854",
        "validationCode": "KG36"
    },
    "gatewayEntryPoint": "WEB_SERVICES_API",
    "merchant": "GLADCORIGKEN",
    "order": {
        "amount": 1.00,
        "authenticationStatus": "AUTHENTICATION_NOT_IN_EFFECT",
        "chargeback": {
            "amount": 0,
            "currency": "USD"
        },
        "creationTime": "2024-04-17T10:15:47.528Z",
        "currency": "USD",
        "id": "devOrderTEST5",
        "lastUpdatedTime": "2024-04-17T10:15:48.508Z",
        "merchantAmount": 1.00,
        "merchantCategoryCode": "5943",
        "merchantCurrency": "USD",
        "reference": "devOrderTEST5",
        "status": "CAPTURED",
        "totalAuthorizedAmount": 1.00,
        "totalCapturedAmount": 1.00,
        "totalDisbursedAmount": 0.00,
        "totalRefundedAmount": 0.00
    },
    "response": {
        "acquirerCode": "00",
        "acquirerMessage": "Approved",
        "cardSecurityCode": {
            "acquirerCode": "M",
            "gatewayCode": "MATCH"
        },
        "gatewayCode": "APPROVED",
        "gatewayRecommendation": "NO_ACTION"
    },
    "result": "SUCCESS",
    "risk": {
        "response": {
            "gatewayCode": "ACCEPTED",
            "provider": "ABRIGHTERIONMLE",
            "review": {
                "decision": "NOT_REQUIRED"
            },
            "rule": [
                {
                    "data": "414767",
                    "name": "MERCHANT_BIN_RANGE",
                    "recommendation": "NO_ACTION",
                    "type": "MERCHANT_RULE"
                },
                {
                    "data": "M",
                    "name": "MERCHANT_CSC",
                    "recommendation": "NO_ACTION",
                    "type": "MERCHANT_RULE"
                },
                {
                    "name": "SUSPECT_CARD_LIST",
                    "recommendation": "NO_ACTION",
                    "type": "MERCHANT_RULE"
                },
                {
                    "name": "TRUSTED_CARD_LIST",
                    "recommendation": "NO_ACTION",
                    "type": "MERCHANT_RULE"
                },
                {
                    "data": "NO_RULES",
                    "name": "MSO_3D_SECURE",
                    "recommendation": "NO_ACTION",
                    "type": "MSO_RULE"
                },
                {
                    "data": "414767",
                    "name": "MSO_BIN_RANGE",
                    "recommendation": "NO_ACTION",
                    "type": "MSO_RULE"
                },
                {
                    "data": "M",
                    "name": "MSO_CSC",
                    "recommendation": "NO_ACTION",
                    "type": "MSO_RULE"
                }
            ],
            "totalScore": 10
        }
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
                "storedOnFile": "NOT_STORED"
            }
        },
        "type": "CARD"
    },
    "timeOfLastUpdate": "2024-04-17T10:15:48.508Z",
    "timeOfRecord": "2024-04-17T10:15:47.562Z",
    "transaction": {
        "acquirer": {
            "batch": 20240417,
            "date": "0417",
            "id": "UBAKEN_S2I",
            "merchantId": "GLADCORIGKEN033",
            "settlementDate": "2024-04-17",
            "timeZone": "+0300",
            "transactionId": "404108369486854"
        },
        "amount": 1.00,
        "authenticationStatus": "AUTHENTICATION_NOT_IN_EFFECT",
        "authorizationCode": "752507",
        "currency": "USD",
        "id": "transTEST5",
        "receipt": "410810111333",
        "reference": "devOrderTEST5",
        "source": "INTERNET",
        "stan": "111333",
        "terminal": "UBAS3I01",
        "type": "PAYMENT"
    },
    "version": "78"
}

*/


echo "<br/><br/><br/><hr/><br/>tr_upd_order1=><br/>";
print_r($tr_upd_order1);
echo "<br/>";

?>

