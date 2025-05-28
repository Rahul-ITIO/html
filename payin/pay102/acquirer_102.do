<?
// Dev Tech : 24-03-27  102 - mastercard  Acquirer 

if($_SESSION['b_'.$acquirer]['acquirer_prod_mode']==2)
{
	

}

if($data['localhosts']==true) 
{
	$webhookhandler_url='https://aws-cc-uat.web1.one/responseDataList/?urlaction=notify_mastercard';

}

	//{"live":{"merchant_id":"GLADCORIGKEN","api_password_key":"4d3f8e07b2c625d779b81c678086cc1d"},"test":{"merchant_id":"GLADCORIGKEN","api_password_key":"4d3f8e07b2c625d779b81c678086cc1d"}}

############################################################

$merchant_id=@$apc_get['merchant_id'];

$prefix_url='ap';
if(isset($apc_get['prefix_url'])&&trim($apc_get['prefix_url']))
$prefix_url=@trim($apc_get['prefix_url']);


$merchant_base_url="https://{$prefix_url}-gateway.mastercard.com/api/rest/version/78/merchant/".$merchant_id;

$apiUsername='merchant.'.$merchant_id;
$PWD='4d3f8e07b2c625d779b81c678086cc1d'; // api 
$AuthorizationBasic='Basic bWVyY2hhbnQuR0xBRENPUklHS0VOOjRkM2Y4ZTA3YjJjNjI1ZDc3OWI4MWM2NzgwODZjYzFk';



############################################################

if($data['cqp']>0)  echo "<hr/><br/>AuthorizationBasic=>".$AuthorizationBasic;

if(isset($apc_get['authorization'])&&trim($apc_get['authorization'])){
    $AuthorizationBasic='Basic '.@$apc_get['authorization'];
}

if(isset($apc_get['api_password_key'])&&trim($apc_get['api_password_key'])){
    $PWD=@$apc_get['api_password_key'];
}

if(isset($apc_get['merchant_id'])&&trim($apc_get['merchant_id'])&&isset($apc_get['api_password_key'])&&trim($apc_get['api_password_key']))
    $AuthorizationBasic='Basic '.base64_encode("merchant.$merchant_id:$PWD");

if($data['cqp']>0)  echo "<hr/><br/>AuthorizationBasic=>".$AuthorizationBasic;

############################################################


####	start	########################################################



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

$_SESSION['3ds2_auth']['prefix_url']=$prefix_url;

$tr_upd_order1['prefix_url']=$prefix_url;
$tr_upd_order1['url_step_1']=$url_step_1;
$tr_upd_order1['response_1_via_create']=(isset($response_1_via_create)&&$response_1_via_create?htmlTagsInArray($response_1_via_create):($response_1));

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
        "reference": "'.$transID.'",
        "notificationUrl": "'.$webhookhandler_url.'"
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
$tr_upd_order1['response_2_via_card']=(isset($response_2_via_card)&&$response_2_via_card?htmlTagsInArray($response_2_via_card):($response_2));

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
$tr_upd_order1['response_3_via_pay']=(isset($response_3_via_pay)&&$response_3_via_pay?htmlTagsInArray($response_3_via_pay):($response_3));

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

###############################################################################

$errorMessage = "";
$errorCode = "";
$gatewayCode = "";
$result = "";
$acquirerMessage= '';

$tmpArray = array();
$responseArray = array();

###############################################################################


$response_4_via_validate=$responseArray=json_decode($response_4,1);
$gatewayCode_response=@$response_4_via_validate['response']['gatewayCode'];

@$result_code = strtolower(@$gatewayCode_response);

$tr_upd_order1['url_step_4']=$url_step_4;
$tr_upd_order1['response_4_via_validate']=(isset($response_4_via_validate)&&$response_4_via_validate?htmlTagsInArray($response_4_via_validate):($response_4));

$tr_upd_order1['acquirer_ref']='trans'.$transID;
if(isset($response_4_via_validate["transaction"]["acquirer"]["batch"])) $tr_upd_order1['upa']=@$response_4_via_validate["transaction"]["acquirer"]["batch"];
if(isset($response_4_via_validate["transaction"]["receipt"])) $tr_upd_order1['rrn']=@$response_4_via_validate["transaction"]["receipt"];

if(array_key_exists("result", $responseArray))
	$result = $responseArray["result"];

// Form error string if error is triggered
if ($result == "FAIL" || $result == "ERROR") {
	if (array_key_exists("reason", $responseArray)) {
		$tmpArray = $responseArray["reason"];

		if (array_key_exists("explanation", $tmpArray)) {
			$errorMessage = $acquirerMessage = rawurldecode($tmpArray["explanation"]);
		}
		else if (array_key_exists("supportCode", $tmpArray)) {
			$errorMessage = $acquirerMessage = rawurldecode($tmpArray["supportCode"]);
		}
		
		if (array_key_exists("code", $tmpArray)) {
			$errorCode =  "Error (" . $tmpArray["code"] . ")";

			$acquirerMessage .= $errorCode;
		}
		
	}
}


if(isset($response_4_via_validate['response']['acquirerMessage'])&&trim($response_4_via_validate['response']['acquirerMessage']))
	$acquirerMessage .= @$response_4_via_validate['response']['acquirerMessage'];
elseif(isset($response_4_via_validate['response']['gatewayRecommendation'])&&trim($response_4_via_validate['response']['gatewayRecommendation']))
	$acquirerMessage .= @$response_4_via_validate['response']['gatewayRecommendation'];


if($data['cqp']>0) 
{
    echo "<hr/><br/>url_step_4=>".$url_step_4;
    echo "<br/>response_4_via_validate=><br/>";
    print_r($response_4_via_validate);
    echo "<br/>";
    echo "<br/>";
    echo "<br/>gatewayCode_response=>".$gatewayCode_response."<br/>";
}



$_SESSION['acquirer_action']=1;
$_SESSION['acquirer_response']=@$acquirerMessage;
$_SESSION['acquirer_status_code']=@$result_code;
//$_SESSION['acquirer_transaction_id']=@$response_4_via_validate['tradeNo'];
//$_SESSION['acquirer_descriptor']=@$response_4_via_validate['acquirer'];

//$_SESSION['curl_values']=$curl_values_arr;


//print_r($post_g); exit;	
	
//Dev Tech : 23-08-28 skip the get acquirer status in checkout page as one minute interval timer
//$json_arr_set['check_acquirer_status_in_realtime']='f';


if($result_code=='approved'){ //success
	$_SESSION['acquirer_status_code']=2;
	//$process_url = $return_url; 
	$json_arr_set['realtime_response_url']=$trans_processing;
}
elseif(isset($response_4_via_validate['skipTo3DURL'])&&!empty($response_4_via_validate['skipTo3DURL'])){
	$_SESSION['acquirer_status_code']=1;
	$json_arr_set['realtime_response_url']=$trans_processing;
}
elseif($result_code=='declined'){	//failed 
	$_SESSION['acquirer_status_code']=-1;
	//$process_url = $return_url; 
	$json_arr_set['realtime_response_url']=$trans_processing;
}
else{ //pending
    
	$_SESSION['acquirer_status_code']=1;
	//$process_url = $trans_processing;
	$json_arr_set['realtime_response_url']=$trans_processing;
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


####	end		########################################################


	

	
	

	
	
	
	//if(isset($get_session_id)&&$get_session_id)  $tr_upd_order1['acquirer_ref']=$get_session_id;
	//$tr_upd_order1['bank_url']=@$bank_url;
	//$tr_upd_order1['responseParamList']=isset($results)&&$results?$results:htmlentitiesf($response);
	//$curl_values_arr['browserOsInfo']=$browserOs;
	
	/*
	$tr_upd_order1['pay_mode']='3D';
	//$auth_3ds2_secure=@$reprocess_url;
	//$auth_3ds2_secure=@$status_default_url;
	$auth_3ds2_secure=@$reprocess_url;
	$auth_3ds2_action='redirect';
	*/
	
	// Check error 
	
	
	if($data['cqp']==9)
	{
		trans_updatesf($_SESSION['tr_newid'], $tr_upd_order1);
		
		
		exit;
	}
	
		
	if(isset($error_description) && !empty(trim($error_description)))
	{
		$_SESSION['acquirer_response']=$error_description;
		$tr_upd_order1['error']=$error_description;
		trans_updatesf($_SESSION['tr_newid'], $tr_upd_order1);
		echo 'Error for '.@$error_description;exit; 
	}

	
	$tr_upd_order_111=$tr_upd_order1;
	//trans_updatesf($_SESSION['tr_newid'], $tr_upd_order1);
		
?>