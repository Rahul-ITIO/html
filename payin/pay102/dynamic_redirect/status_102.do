<?
// Dev Tech : 23-12-26  87 status binopay

$data['NO_SALT']=true;
$is_curl_on = true;

if((isset($_REQUEST['transaction_number']))&&(!empty($_REQUEST['transaction_number']))){
	$_REQUEST['acquirer_ref'] = $_REQUEST['transaction_number'];
	//$is_curl_on = false; $_REQUEST['actionurl']='notify';
}

if((isset($_REQUEST['acquirer_ref']))&&(!empty($_REQUEST['acquirer_ref']))){
	$_REQUEST['acquirer_ref'] = $_REQUEST['acquirer_ref'];
}

//webhook : 
if(isset($_REQUEST['action'])&&$_REQUEST['action']=='webhook')
{

	$body_input = file_get_contents("php://input");
	$response = @$body_input;

	//$response = '{&quot;authentication&quot;:{&quot;3ds&quot;:{&quot;acsEci&quot;:&quot;07&quot;,&quot;transactionId&quot;:&quot;98e6afe6-246c-4bf6-af7e-ed6340c5fd08&quot;},&quot;3ds2&quot;:{&quot;3dsServerTransactionId&quot;:&quot;b284ff9a-d3f6-4755-a2f9-edc3405a388a&quot;,&quot;acsTransactionId&quot;:&quot;faae8055-ece5-11ee-9189-c3e396489dd6&quot;,&quot;directoryServerId&quot;:&quot;A000000003&quot;,&quot;dsTransactionId&quot;:&quot;98e6afe6-246c-4bf6-af7e-ed6340c5fd08&quot;,&quot;methodCompleted&quot;:false,&quot;methodSupported&quot;:&quot;SUPPORTED&quot;,&quot;protocolVersion&quot;:&quot;2.2.0&quot;,&quot;requestorId&quot;:&quot;10065253*APGLADCORIGKEN_MPGS&quot;,&quot;requestorName&quot;:&quot;CORIGUN INTERNATIONAL LIMITED&quot;,&quot;statusReasonCode&quot;:&quot;01&quot;,&quot;transactionStatus&quot;:&quot;N&quot;},&quot;acceptVersions&quot;:&quot;3DS1,3DS2&quot;,&quot;amount&quot;:2.01,&quot;channel&quot;:&quot;PAYER_BROWSER&quot;,&quot;method&quot;:&quot;DYNAMIC&quot;,&quot;payerInteraction&quot;:&quot;REQUIRED&quot;,&quot;purpose&quot;:&quot;PAYMENT_TRANSACTION&quot;,&quot;redirect&quot;:{&quot;domainName&quot;:&quot;secure-acs2ui-b4.wibmo.com&quot;},&quot;time&quot;:&quot;2024-03-28T09:31:37.939Z&quot;,&quot;version&quot;:&quot;3DS2&quot;},&quot;billing&quot;:{&quot;address&quot;:{&quot;city&quot;:&quot;New Delhi&quot;,&quot;country&quot;:&quot;IND&quot;,&quot;postcodeZip&quot;:&quot;110001&quot;,&quot;stateProvince&quot;:&quot;Delhi&quot;,&quot;street&quot;:&quot;161&quot;,&quot;street2&quot;:&quot;Kallang Way&quot;}},&quot;device&quot;:{&quot;browser&quot;:&quot;Mozilla\/5.0 (Macintosh; Intel Mac OS X 10.15; rv:124.0) Gecko\/20100101 Firefox\/124.0&quot;,&quot;ipAddress&quot;:&quot;122.176.92.114&quot;},&quot;merchant&quot;:&quot;GLADCORIGKEN&quot;,&quot;order&quot;:{&quot;amount&quot;:2.01,&quot;authenticationStatus&quot;:&quot;AUTHENTICATION_FAILED&quot;,&quot;chargeback&quot;:{&quot;amount&quot;:0,&quot;currency&quot;:&quot;USD&quot;},&quot;creationTime&quot;:&quot;2024-03-28T09:31:37.933Z&quot;,&quot;currency&quot;:&quot;USD&quot;,&quot;description&quot;:&quot;Test Product&quot;,&quot;id&quot;:&quot;1021770455&quot;,&quot;lastUpdatedTime&quot;:&quot;2024-03-28T09:31:48.951Z&quot;,&quot;merchantAmount&quot;:2.01,&quot;merchantCategoryCode&quot;:&quot;5943&quot;,&quot;merchantCurrency&quot;:&quot;USD&quot;,&quot;status&quot;:&quot;AUTHENTICATION_UNSUCCESSFUL&quot;,&quot;totalAuthorizedAmount&quot;:0,&quot;totalCapturedAmount&quot;:0,&quot;totalDisbursedAmount&quot;:0,&quot;totalRefundedAmount&quot;:0,&quot;valueTransfer&quot;:{&quot;accountType&quot;:&quot;NOT_A_TRANSFER&quot;}},&quot;response&quot;:{&quot;gatewayCode&quot;:&quot;DECLINED&quot;,&quot;gatewayRecommendation&quot;:&quot;DO_NOT_PROCEED&quot;},&quot;result&quot;:&quot;FAILURE&quot;,&quot;sourceOfFunds&quot;:{&quot;provided&quot;:{&quot;card&quot;:{&quot;brand&quot;:&quot;VISA&quot;,&quot;expiry&quot;:{&quot;month&quot;:&quot;11&quot;,&quot;year&quot;:&quot;28&quot;},&quot;fundingMethod&quot;:&quot;CREDIT&quot;,&quot;nameOnCard&quot;:&quot;Ar di&quot;,&quot;number&quot;:&quot;404745xxxxxx6090&quot;,&quot;scheme&quot;:&quot;VISA&quot;}},&quot;type&quot;:&quot;CARD&quot;},&quot;timeOfLastUpdate&quot;:&quot;2024-03-28T09:31:48.951Z&quot;,&quot;timeOfRecord&quot;:&quot;2024-03-28T09:31:37.074Z&quot;,&quot;transaction&quot;:{&quot;acquirer&quot;:{&quot;merchantId&quot;:&quot;GLADCORIGKEN033&quot;},&quot;amount&quot;:2.01,&quot;authenticationStatus&quot;:&quot;AUTHENTICATION_FAILED&quot;,&quot;currency&quot;:&quot;USD&quot;,&quot;id&quot;:&quot;trans-568&quot;,&quot;stan&quot;:&quot;0&quot;,&quot;type&quot;:&quot;AUTHENTICATION&quot;},&quot;version&quot;:&quot;72&quot;}';

	/*
	
	$response = '{
        "authentication": {
            "3ds": {
                "acsEci": "07",
                "transactionId": "98e6afe6-246c-4bf6-af7e-ed6340c5fd08"
            },
            "3ds2": {
                "3dsServerTransactionId": "b284ff9a-d3f6-4755-a2f9-edc3405a388a",
                "acsTransactionId": "faae8055-ece5-11ee-9189-c3e396489dd6",
                "directoryServerId": "A000000003",
                "dsTransactionId": "98e6afe6-246c-4bf6-af7e-ed6340c5fd08",
                "methodCompleted": false,
                "methodSupported": "SUPPORTED",
                "protocolVersion": "2.2.0",
                "requestorId": "10065253*APGLADCORIGKEN_MPGS",
                "requestorName": "CORIGUN INTERNATIONAL LIMITED",
                "statusReasonCode": "01",
                "transactionStatus": "N"
            },
            "acceptVersions": "3DS1,3DS2",
            "amount": 2.01,
            "channel": "PAYER_BROWSER",
            "method": "DYNAMIC",
            "payerInteraction": "REQUIRED",
            "purpose": "PAYMENT_TRANSACTION",
            "redirect": {
                "domainName": "secure-acs2ui-b4.wibmo.com"
            },
            "time": "2024-03-28T09:31:37.939Z",
            "version": "3DS2"
        },
        "billing": {
            "address": {
                "city": "New Delhi",
                "country": "IND",
                "postcodeZip": "110001",
                "stateProvince": "Delhi",
                "street": "161",
                "street2": "Kallang Way"
            }
        },
        "device": {
            "browser": "Mozilla\/5.0 (Macintosh; Intel Mac OS X 10.15; rv:124.0) Gecko\/20100101 Firefox\/124.0",
            "ipAddress": "122.176.92.114"
        },
        "merchant": "GLADCORIGKEN",
        "order": {
            "amount": 2.01,
            "authenticationStatus": "AUTHENTICATION_FAILED",
            "chargeback": {
                "amount": 0,
                "currency": "USD"
            },
            "creationTime": "2024-03-28T09:31:37.933Z",
            "currency": "USD",
            "description": "Test Product",
            "id": "1021770455",
            "lastUpdatedTime": "2024-03-28T09:31:48.951Z",
            "merchantAmount": 2.01,
            "merchantCategoryCode": "5943",
            "merchantCurrency": "USD",
            "status": "AUTHENTICATION_UNSUCCESSFUL",
            "totalAuthorizedAmount": 0,
            "totalCapturedAmount": 0,
            "totalDisbursedAmount": 0,
            "totalRefundedAmount": 0,
            "valueTransfer": {
                "accountType": "NOT_A_TRANSFER"
            }
        },
        "response": {
            "gatewayCode": "DECLINED",
            "gatewayRecommendation": "DO_NOT_PROCEED"
        },
        "result": "FAILURE",
        "sourceOfFunds": {
            "provided": {
                "card": {
                    "brand": "VISA",
                    "expiry": {
                        "month": "11",
                        "year": "28"
                    },
                    "fundingMethod": "CREDIT",
                    "nameOnCard": "Ar di",
                    "number": "404745xxxxxx6090",
                    "scheme": "VISA"
                }
            },
            "type": "CARD"
        },
        "timeOfLastUpdate": "2024-03-28T09:31:48.951Z",
        "timeOfRecord": "2024-03-28T09:31:37.074Z",
        "transaction": {
            "acquirer": {
                "merchantId": "GLADCORIGKEN033"
            },
            "amount": 2.01,
            "authenticationStatus": "AUTHENTICATION_FAILED",
            "currency": "USD",
            "id": "trans-568",
            "stan": "0",
            "type": "AUTHENTICATION"
        },
        "version": "72"
    }';

	*/

	$response = (html_entity_decode($response)); $response = str_replace(["&gt; ","&gt;"],"",$response);
	
	$responseParamList = $data['gateway_push_notify'] = json_decode($response, true);


	if(isset($responseParamList["order"]["id"]))
	{
		$_REQUEST['transID']= rawurldecode($responseParamList["order"]["id"]);
		$is_curl_on = false;
	}
	
	//echo "<hr/><br/>is_curl_on=>".$is_curl_on ; echo "<br/>transID via webhook=>".$_REQUEST['transID']; echo "<br/><br/>responseParamList=>"; print_r($responseParamList); exit;
	
}

//exit;


// access status via callback - end

if(isset($data['ROOT'])&&$data['ROOT']) $root=$data['ROOT'];
else $root='../../';

if(!isset($data['STATUS_ROOT'])){
	include($root.'config_db.do');
	//include($data['Path'].'/payin/res_insert'.$data['iex']);
	include($data['Path'].'/payin/status_top'.$data['iex']);//include status_top if the page execute directly
}

//include($data['Path'].'status_in_email'.$data['iex']);

//print_r($td);
//print_r($json_value);




if(empty($acquirer_status_url)) $acquirer_status_url="https://gate.lonapay24.com/payment/api/v2/status/group";

//check if test mode than assing uat status url 
//echo "<br/>mode=>".$apc_get['mode'];
if(@$acquirer_prod_mode==2||@$apc_get['mode']=='test') $acquirer_status_url="https://sandbox.lonapay24.com/payment/api/v2/status/group";

$acquirer_status_url	= @$acquirer_status_url."/".@$apc_get['endpoint_group_id'];  	

if(empty($acquirer_ref)) echo "<br/><b>Acquirer Ref not found</b><br/>".$acquirer_ref;

if($qp)
{

	echo "<br/>acquirer_status_url=>".$acquirer_status_url;
	echo "<br/>acquirer_ref=>".$acquirer_ref;
}

if(!empty($acquirer_ref))
{
	$merchant_id=@$apc_get['merchant_id'];
	$api_password_key=@$apc_get['api_password_key'];

	

	
	if($is_curl_on)
	{

		$_POST['orderId']=$transID; // $transID

		/*
		$_POST['orderId']='240327082313000000'; // $transID
		$_POST['ordertransactionIdId']='trans-682'; // $acquirer_ref


		$_POST['orderId']='240327104255000000'; // $transID
		$_POST['transactionId']='trans-395'; // $acquirer_ref
*/

		//$_POST['orderId']='1021770455'; // $transID
		//$_POST['transactionId']='trans-568'; // $acquirer_ref

		
		
		if(!empty(trim($td['rrn']))) 
		{ 
			$_POST['transactionId']= trim($td['rrn']); // $rrn
		}

		$_POST['version']='72';
		$_POST['method']='GET';
		$_POST['apiOperation']='CAPTURED';

		if(isset($qp)&&$qp)
		{
			echo "<br/><hr/><br/>orderId=>".$_POST['orderId'];
			echo "<br/><br/>transactionId=>".$_POST['transactionId'];
			echo "<br/><br/>_POST=>";print_r($_POST);
			echo "<br/><hr/><br/>";
		}
		
		$receiptFalse=1;
		include('process.php');
		//$responseParamList=@$responseArray;
		
	
	}

###############################################################################

	$errorMessage = "";
	$errorCode = "";
	$gatewayCode = "";
	$result = "";
	$message= '';

	$tmpArray = array();
	$responseArray = array();


	// [Snippet] howToDecodeResponse - start
	// $response is defined in process.php as the server response

	if(isset($responseParamList)&&is_array($responseParamList))
		$responseArray =$responseParamList;
	
	elseif(isset($response)&&$response&&!isset($responseParamList))
	$responseArray = $responseParamList = json_decode($response, TRUE);
	// [Snippet] howToDecodeResponse - end

	// either a HTML error was received
	// or response is a curl error
	if ($responseArray == NULL) {
		print("JSON decode failed.");
		//die();
	}

	// [Snippet] howToParseResponse - start
	if(array_key_exists("result", $responseArray))
		$result = $responseArray["result"];
	// [Snippet] howToParseResponse - end
	if(isset($qp)&&$qp)
	{
		echo "<br/>response=>";print_r($response);
		echo "<br/>result1=>";print_r($result);
	}

	// Form error string if error is triggered
	if ($result == "FAIL") {
		if (array_key_exists("reason", $responseArray)) {
			$tmpArray = $responseArray["reason"];

			if (array_key_exists("explanation", $tmpArray)) {
			$errorMessage = $message = rawurldecode($tmpArray["explanation"]);
			}
			else if (array_key_exists("supportCode", $tmpArray)) {
			$errorMessage = $message = rawurldecode($tmpArray["supportCode"]);
			}
			else {
			$errorMessage = $message = "Reason unspecified.";
			}

			if (array_key_exists("code", $tmpArray)) {
			$errorCode = $message = "Error (" . $tmpArray["code"] . ")";
			}
			else {
			$errorCode = $message = "Error (UNSPECIFIED)";
			}
		}
	}

	else {
		//if (array_key_exists("response", $responseArray)) 
		{
			if(isset($responseArray["response"])) $tmpArray = @$responseArray["response"];
			if(isset($responseArray["transaction"][0]["response"]))$tmpArray = $responseArray["transaction"][0]["response"];
			elseif(isset($responseArray["transaction"]["response"]))$tmpArray = $responseArray["transaction"]["response"];
			elseif(isset($responseArray["response"]))$tmpArray = $responseArray["response"];

			if($qp) {
				echo "<br/><br/>tmpArray==> "; 
				print_r($tmpArray);
			}


			if(array_key_exists("gatewayRecommendation", $tmpArray))
			$message = rawurldecode($tmpArray["gatewayRecommendation"]);
			
			if(array_key_exists("gatewayCode", $tmpArray))
			$gatewayCode = rawurldecode($tmpArray["gatewayCode"]);
			else
			$gatewayCode = "Response not received.";

			if(isset($responseArray["transaction"][0]["transaction"]["id"]))
				$trans_id = rawurldecode($responseArray["transaction"][0]["transaction"]["id"]);
			elseif(isset($responseArray["transaction"]["transaction"]["id"]))
				$trans_id = rawurldecode($responseArray["transaction"]["transaction"]["id"]);
			elseif(isset($responseArray["transaction"]["id"]))
				$trans_id = rawurldecode($responseArray["transaction"]["id"]);

			if($qp) echo "<br/>trans_id=>".$trans_id;

			

		}
	}

	if($qp) echo "<br/>gatewayCode=>".$gatewayCode;

###############################################################################


	$results = @$responseParamList;
	//$_SESSION['results_100']=$results;
	
	/*
	echo "<pre><code>";
	print_r($results);
	echo "</code></pre>";
	exit;
	*/
	
	if($qp)
	{
		echo '<div type="button" class="btn btn-success my-2" style="background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
		//echo "res=>"; print_r($res);
		echo "<br/>mode=>".$apc_get['mode'];
		echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
		echo "<br/>acquirer ['type']=> ".@$responseParamList['type'];
		echo "<br/>acquirer status ['gatewayCode']=> ".@$gatewayCode;
		echo '<br/>acquirer status ["response"]["gatewayCode"]=> '.@$responseParamList["response"]["gatewayCode"];
		echo "<br/>acquirer ['descriptor']=> ".@$responseParamList['descriptor'];
		echo '<br/>acquirer message ["response"]["gatewayRecommendation"]=> '.@$message;
		echo "<br/>acquirer via ['transaction']['amount']=> ".@$responseParamList['transaction']['amount'];
		
		//echo "<br/>response_json=> ".@$response_json;
		echo "<br/><br/>responseParamList=> "; print_r($responseParamList);
		
		//echo "<br/><br/>res=> ".htmlentitiesf(@$responseParamList);
		echo '<br/><br/></div>';
	}
		
	
	/*
	
Possible statuses:
0000	Approved
0001	Approved with Risk
0002	Deferred capture


	
	*/

	if (isset($responseParamList) && count($responseParamList)>0)
	{
		
		//rrn //acquirer_ref
		#######	rrn, acquirer_ref update from status get :start 	###############
			
		/*
			//acquirer_ref
			$acquirer_ref_1='';
			if(isset($responseParamList['result']['transaction_number'])) $acquirer_ref_1 = @$responseParamList['result']['transaction_number'];
			//up acquirer_ref : update if empty acquirer_ref_1 and is ['result']['transaction_number']  
			if(empty(trim($td['acquirer_ref']))&&!empty($acquirer_ref_1)){
				$tr_upd_status['acquirer_ref']=trim($acquirer_ref_1);
			}
			
			*/

			//rrn 
			$rrn='';
			if(isset($trans_id)) $rrn = @$trans_id;
			//up rrn : update if empty rrn and is custRefNo 
			if(empty(trim($td['rrn']))&&!empty($rrn)){
				$tr_upd_status['rrn']=trim($rrn);
			}
			
			
			if($qp){
				echo "<br/><br/><=acquirer_ref=>".@$acquirer_ref_1;
				echo "<br/><br/><=tr_upd_status1=>";
					print_r(@$tr_upd_status);
			}
			
			if(isset($tr_upd_status)&&count($tr_upd_status)>0&&is_array($tr_upd_status))
			{
				if($qp){
					echo "<br/><br/><=tr_upd_status=>";
					print_r($tr_upd_status);
				}
				
				trans_updatesf($td['id'], $tr_upd_status);
			}
			
		#######	rrn, acquirer_ref update from status get :end 	###############
		
		
		
		if(isset($responseParamList['error-message'])) $message= @$responseParamList['error-message'];
		
		$_SESSION['acquirer_action']=1;
		$_SESSION['acquirer_response']=@$message;

		$curl_values=@$responseParamList;

		if(isset($curl_values['html'])) unset($curl_values['html']);

		$_SESSION['curl_values']=@$curl_values;
		
		if(isset($responseParamList['reference_id'])&&@$responseParamList['reference_id']) $_SESSION['acquirer_transaction_id']=@$responseParamList['reference_id'];
		
		if(isset($responseParamList['descriptor'])&&@$responseParamList['descriptor']) $_SESSION['acquirer_descriptor']=@$responseParamList['descriptor'];
		
		if(isset($responseParamList['transaction']['amount'])&&$responseParamList['transaction']['amount']) $_SESSION['responseAmount']=$responseParamList['transaction']['amount'];
		elseif(isset($responseParamList['amount'])&&$responseParamList['amount']) $_SESSION['responseAmount']=$responseParamList['amount'];

		$result_code = strtolower(@$gatewayCode);
		
		// "approved","declined"

		if($result_code=='approved'){ //success
			$_SESSION['acquirer_response']=$_SESSION['acquirer_response']." - Success";
			$_SESSION['acquirer_status_code']=2;
			if(isset($json_value['billing_descriptor'])&&trim($json_value['billing_descriptor'])) $_SESSION['acquirer_descriptor']=@$json_value['billing_descriptor'];
		}
		elseif($result_code=='declined'){	//failed 
			$_SESSION['acquirer_response']=$_SESSION['acquirer_response']." Payment failed - Cancelled";
			$_SESSION['acquirer_status_code']=-1;
		}
		else{
			$_SESSION['acquirer_response']=$message." - Pending";
			$_SESSION['acquirer_status_code']=1;
		}
	}
}

if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}

?>