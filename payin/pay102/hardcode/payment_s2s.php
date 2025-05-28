<?php

// http://localhost:8080/gw/payin/pay102/hardcode/payment_s2s.php

$data['cqp']=1;

$merchant_id='GLADCORIGKEN';
$merchant_base_url="https://ap-gateway.mastercard.com/api/rest/version/78/merchant/".$merchant_id;

$apiUsername='merchant.'.$merchant_id;
$PWD='4d3f8e07b2c625d779b81c678086cc1d'; // api 
$AuthorizationBasic='Basic bWVyY2hhbnQuR0xBRENPUklHS0VOOjRkM2Y4ZTA3YjJjNjI1ZDc3OWI4MWM2NzgwODZjYzFk';
$redirectUrl='https://aws-cc-uat.web1.one/responseDataList/?urlaction=redirectUrl_mastercard';

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



##### start - 1_create : session id ###############################################################

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
    "merchant": "GLADCORIGKEN",
    "result": "SUCCESS",
    "session": {
        "aes256Key": "5IaIO6v13SaebTMhgwUDzxu8nsys05TrGkzc7gHtiWo=",
        "authenticationLimit": 25,
        "id": "SESSION0002794014567H3251842M57",
        "updateStatus": "NO_UPDATE",
        "version": "584857a801"
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















##### start - 2_Update_Amount_and_Card : session updateStatus_is_SUCCESS ########################


$postData_2='{
    "order": {
        "currency": "'.$orderCurrency.'",
        "amount": '.$total_payment.',
        "reference": "'.$transID.'"
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
    }
}';

$url_step_2=$merchant_base_url.'/session/'.$get_session_id;

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
$updateStatus_is_SUCCESS=@$response_2_via_card['session']['updateStatus'];

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
    echo "<br/>";
    echo "<br/>updateStatus_is_SUCCESS=>".$updateStatus_is_SUCCESS."<br/>";
}


/*

{
    "merchant": "GLADCORIGKEN",
    "order": {
        "amount": "1",
        "currency": "USD",
        "reference": "devOrderTEST5"
    },
    "session": {
        "id": "SESSION0002794014567H3251842M57",
        "updateStatus": "SUCCESS",
        "version": "e260468702"
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
        }
    },
    "version": "78"
}

*/


##### end - 2_Update_Amount_and_Card : session updateStatus_is_SUCCESS ########################











##### start - 3_Pay_With_Card : response gatewayCode ####################################################

$url_step_3=$merchant_base_url.'/order/'.$transID.'/transaction/trans'.$transID;

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
  CURLOPT_POSTFIELDS =>'{
    "apiOperation": "PAY",
    "sourceOfFunds": {
        "type": "CARD"
    },
    "session": {
        "id": "'.$get_session_id.'"
    },
    "transaction": {
        "reference": "'.$transID.'"
    }
}',
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/json',
    'Authorization: '.$AuthorizationBasic
  ),
));

$response_3 = curl_exec($curl);

curl_close($curl);



$response_3_via_pay=json_decode($response_3,1);
$gatewayCode=@$response_3_via_pay['response']['gatewayCode'];

$tr_upd_order1['url_step_3']=$url_step_3;
$tr_upd_order1['response_3_via_pay']=isset($response_3_via_pay)&&$response_3_via_pay?$response_3_via_pay:($response_3);

if($data['cqp']>0) 
{
    echo "<hr/><br/>url_step_3=>".$url_step_3;
    echo "<br/>response_3_via_pay=><br/>";
    print_r($response_3_via_pay);
    echo "<br/>";
   // echo "br/>postData_3=><br/>"; print_r($postData_3);
    echo "<br/>";
    echo "<br/>gatewayCode=>".$gatewayCode."<br/>";
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


##### end - 3_Pay_With_Card : response gatewayCode ####################################################





















##### start - 4_Validate : response gatewayCode ####################################################

$url_step_4=$merchant_base_url.'/order/'.$transID.'/transaction/trans'.$transID;

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

