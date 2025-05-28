<?
// Dev Tech : 24-03-27  102 - mastercard  Acquirer 

if($_SESSION['b_'.$acquirer]['acquirer_prod_mode']==2)
{
	

}

if($data['localhosts']==true) 
{
	$webhookhandler_url='https://aws-cc-uat.web1.one/responseDataList/?urlaction=notify_mastercard';

}

//{"merchant_id":"GLADRASHKEN","api_password_key":"b7e502f1b9955b7135cce1dd985aa501","authorization":"bWVyY2hhbnQuR0xBRFJBU0hLRU46YjdlNTAyZjFiOTk1NWI3MTM1Y2NlMWRkOTg1YWE1MDE="}

//{"prefix_url":"eu","merchant_id":"TECHNGL1","api_password_key":"6e517c7f3b6be078f70a22af5e1d16a3"}

############################################################

$merchant_id=@$apc_get['merchant_id'];


$prefix_url='ap';
if(isset($apc_get['prefix_url'])&&trim($apc_get['prefix_url']))
$prefix_url=trim($apc_get['prefix_url']);


$merchant_base_url="https://{$prefix_url}-gateway.mastercard.com/api/rest/version/78/merchant/".$merchant_id;

if($data['cqp']>0) 
{
    echo "<hr/><br/>prefix_url=>".@$prefix_url;
    echo "<br/>merchant_base_url=><br/>";
    print_r(@$merchant_base_url);
    echo "<br/>";
    
}

$apiUsername='merchant.'.$merchant_id;
$PWD='b7e502f1b9955b7135cce1dd985aa501'; // api 
$AuthorizationBasic='Basic bWVyY2hhbnQuR0xBRFJBU0hLRU46YjdlNTAyZjFiOTk1NWI3MTM1Y2NlMWRkOTg1YWE1MDE=';


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

//@$transIDSet='TRANSESSION0000000000'.@$transID;
@$transIDSet=prefix_trans_lenght(@$transID,31,1,'TRANSESSION','O');

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
@$get_session_id=@$response_1_via_create['session']['id'];

//$_SESSION['3ds2_auth']['prefix_url']=$prefix_url;

$tr_upd_order1['prefix_url']=$prefix_url;

$tr_upd_order1['url_step_1']=$url_step_1;
$tr_upd_order1['response_1_via_create']=(isset($response_1_via_create)&&$response_1_via_create?htmlTagsInArray($response_1_via_create):($response_1));

if($data['cqp']>0) 
{
    echo "<hr/><br/>url_step_1=>".$url_step_1;
    echo "<br/>response_1_via_create=><br/>";
    print_r($response_1_via_create);
    echo "<br/>";
    echo "<br/>session_id=>".@$get_session_id."<br/>";
}

##### end - 1_create : session id ###############################################################















##### start - 2_Update_Amount_and_Card : session updateStatus_is_SUCCESS ########################


$postData_2='{
    "order": {
        "currency": "'.@$orderCurrency.'",
        "amount": '.$total_payment.',
        "id": "'.$transIDSet.'",
        "reference": "'.$transIDSet.'",
        "notificationUrl": "'.$webhookhandler_url.'"
    },
    "authentication": {
        "channel": "PAYER_BROWSER",
        "redirectResponseUrl": "'.@$status_default_url.'"
    },
    "transaction": {
        "id": "'.$transIDSet.'"
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

$tr_upd_order1['acquirer_ref']=@$get_session_id;

if(isset($response_2_via_card["transaction"]["acquirer"]["batch"])) $tr_upd_order1['upa']=@$response_2_via_card["transaction"]["acquirer"]["batch"];
if(isset($response_2_via_card["transaction"]["receipt"])) $tr_upd_order1['rrn']=@$response_2_via_card["transaction"]["receipt"];

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











##### start - 03. Initiate 3DS Authentication after JS REQUEST : response is "gatewayCode": "AUTHENTICATION_IN_PROGRESS" ####################################################

$postData_3='{
    "apiOperation":"INITIATE_AUTHENTICATION",
	"authentication":{ 
		"acceptVersions":"3DS1,3DS2",
	    "channel":"PAYER_BROWSER",
	    "purpose":"PAYMENT_TRANSACTION"
	},
    "correlationId": "'.$transIDSet.'",
    "order": {
        "reference": "'.$transIDSet.'",
        "currency": "'.$orderCurrency.'"
    },
    "session": {
		"id": "'.$get_session_id.'"
	},
	"transaction": {
		"reference": "'.$transIDSet.'"
	}
}';


$url_step_3=$merchant_base_url.'/order/'.$transIDSet.'/transaction/'.$transIDSet;

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

$response_3 = curl_exec($curl);

curl_close($curl);



$response_3_via_pay=json_decode($response_3,1);
$gatewayCode=@$response_3_via_pay['response']['gatewayCode'];


//save if descriptor via requestorName
if(@$response_3_via_pay['authentication']['3ds2']['requestorName']) $tr_upd_order1['descriptor']=$_SESSION['acquirer_descriptor']=@$response_3_via_pay['authentication']['3ds2']['requestorName'];


if(isset($response_3_via_pay['authentication']['redirect'])) unset($response_3_via_pay['authentication']['redirect']);

$tr_upd_order1['url_step_3']=$url_step_3;
$tr_upd_order1['response_3_via_pay']=(isset($response_3_via_pay)&&$response_3_via_pay?htmlTagsInArray($response_3_via_pay):($response_3));


$_SESSION['3ds2_auth']['prefix_url']=$prefix_url;
$_SESSION['3ds2_auth']['merchant_id']=$merchant_id;
$_SESSION['3ds2_auth']['get_session_id']=@$get_session_id;
$tr_upd_order1['pay_mode']='3D';
//$auth_3ds2_secure=@$reprocess_url;
//$auth_3ds2_secure=@$status_default_url;
$auth_3ds2_secure=@$reprocess_url;
$auth_3ds2_action='redirect';


db_trf($_SESSION['tr_newid'], 'acquirer_response_stage1', $tr_upd_order1);


if($data['cqp']>0) 
{
    //SESSION0002589457355J66722209K7
    
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


##### end - 03. Initiate 3DS Authentication after JS REQUEST : response is "gatewayCode": "AUTHENTICATION_IN_PROGRESS" ####################################################








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