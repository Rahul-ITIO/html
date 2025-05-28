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

	//$response = '';

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

//include($data['Path'].'/payin/status_in_email'.$data['iex']);

//print_r($td);
//print_r($json_value);



if(!empty($transID))
{
	

	

	/*
	if($is_curl_on)
	{

		$_POST['orderId']=$transID; // $transID

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
	*/


	############################################################
	
	$merchant_id=@$apc_get['merchant_id'];
	$api_password_key=@$apc_get['api_password_key'];

	$prefix_url='ap';
	if(isset($apc_get['prefix_url'])&&trim($apc_get['prefix_url']))
	$prefix_url=@trim($apc_get['prefix_url']);


	$apiUsername='merchant.'.$merchant_id;
	$PWD=$api_password_key; //'4d3f8e07b2c625d779b81c678086cc1d'; // api 
	$AuthorizationBasic='Basic bWVyY2hhbnQuR0xBRENPUklHS0VOOjRkM2Y4ZTA3YjJjNjI1ZDc3OWI4MWM2NzgwODZjYzFk';

			
	############################################################

	if(@$qp) echo "<hr/><br/>AuthorizationBasic=>".$AuthorizationBasic;

	if(isset($apc_get['authorization'])&&trim($apc_get['authorization'])){
		$AuthorizationBasic='Basic '.@$apc_get['authorization'];
	}

	if(isset($apc_get['api_password_key'])&&trim($apc_get['api_password_key'])){
		$PWD=@$apc_get['api_password_key'];
	}

	if(isset($apc_get['merchant_id'])&&trim($apc_get['merchant_id'])&&isset($apc_get['api_password_key'])&&trim($apc_get['api_password_key']))
		$AuthorizationBasic='Basic '.base64_encode("merchant.$merchant_id:$PWD");

	if(@$qp) echo "<hr/><br/>AuthorizationBasic=>".$AuthorizationBasic;

	############################################################

	@$get_session_id=@$acquirer_ref;
	//@$transIDSet='TRANSESSION0000000000'.@$transID;
	@$transIDSet=prefix_trans_lenght(@$transID,31,1,'TRANSESSION','O');

	//Amount deduct from card payment after return the response of bank OTP page if not admin session 
	if(!isset($_SESSION['adm_login']))
	{
				
		$postData_5='{
			"apiOperation": "PAY",
			"authentication": {
				"transactionId": "'.$transIDSet.'"
			},
			"session": {
				"id": "'.$get_session_id.'"
			},
			"transaction": {
				"reference": "'.$transIDSet.'"
			}
		}';


		$url_step_5="https://{$prefix_url}-gateway.mastercard.com/api/rest/version/78/merchant/{$merchant_id}/order/{$transIDSet}/transaction/{$transIDSet}PAY";

		$curl = curl_init();

		curl_setopt_array($curl, array(
		CURLOPT_URL => $url_step_5,
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
		CURLOPT_POSTFIELDS =>$postData_5,
		CURLOPT_HTTPHEADER => array(
			'Content-Type: application/json',
			'Authorization: '.$AuthorizationBasic
		),
		));

		$response_5 = curl_exec($curl);

		curl_close($curl);
		//echo $response_5;

		$response_5_via_pay=json_decode($response_5,1);

		if(isset($response_5_via_pay['authentication']['redirect']['html'])){
			unset($response_5_via_pay['authentication']['redirect']['html']);
		}

		if(isset($qp)&&$qp) 
		{
			echo "<hr/><br/>url_step_5=>".$url_step_5;
			echo "<br/><br/>postData_5=><br/>";
			print_r($postData_5);
			echo "<br/>";
			echo "<br/><br/>response_5_via_pay=><br/>";
			print_r($response_5_via_pay);
			echo "<br/>";
			echo "<br/>session_id=>".$get_session_id."<br/>";
			echo "<br/>transID=>".$transID."<br/>";
		}

	}


	//Get status from Acquirer 
	if($is_curl_on)
	{

		if(empty($acquirer_status_url)||$acquirer_status_url=='NA') $acquirer_status_url="https://{$prefix_url}-gateway.mastercard.com/api/rest/version/78/merchant";

		//check if test mode than assing uat status url 
		//echo "<br/>mode=>".$apc_get['mode'];
		if(@$acquirer_prod_mode==2||@$apc_get['mode']=='test') $acquirer_status_url="https://{$prefix_url}-gateway.mastercard.com/api/rest/version/78/merchant";


		//if($transID=='1021770217') $transID='102240417125111693708';

		//https://ap-gateway.mastercard.com/api/rest/version/78/merchant/GLADCORIGKEN/order/102240417125111693708/transaction/trans102240417125111693708


		$acquirer_status_url=str_replace("ap-gateway.mastercard.com",$prefix_url."-gateway.mastercard.com",$acquirer_status_url);

		$acquirer_status_url	= @$acquirer_status_url.'/'.$merchant_id.'/order/'.@$transIDSet.'/transaction/'.$transIDSet.'PAY';  	

		//if(empty($acquirer_ref)) echo "<br/><b>Acquirer Ref not found</b><br/>".$acquirer_ref;

		if(isset($qp)&&$qp)
		{

			echo "<br/>acquirer_status_url=>".$acquirer_status_url;
			echo "<br/>acquirer_ref=>".$acquirer_ref;
		}


		##### start - 4_Validate : response gatewayCode ####################################################



		$curl = curl_init();

		curl_setopt_array($curl, array(
		CURLOPT_URL => $acquirer_status_url,
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => '',
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 0,
		CURLOPT_FOLLOWLOCATION => true,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => 'GET',
			CURLOPT_HEADER => 0,
			CURLOPT_SSL_VERIFYPEER => 0,
			CURLOPT_SSL_VERIFYHOST => 0,
		CURLOPT_HTTPHEADER => array(
			'Authorization: '.$AuthorizationBasic
		),
		));

		$response = curl_exec($curl);

		curl_close($curl);
		//echo $response;


		/*
		$responseParamList=json_decode($response,1);
		$gatewayCode_response=@$responseParamList['response']['gatewayCode'];
		//@$result_code = strtolower(@$gatewayCode_response);

		if(isset($qp)&&$qp)
		{
			echo "<br/>responseParamList_s1=>";print_r($responseParamList);
			echo "<br/>gatewayCode_response=>";print_r($gatewayCode_response);
		}
		*/
		

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
	if ($result == "FAIL" || $result == "ERROR") {
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
				$errorCode = "Error (" . $tmpArray["code"] . ")";
				$message .= $errorCode;
			}
			else {
				$errorCode =  "Error (UNSPECIFIED)";
				$message .= $errorCode;
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

			if($responseArray["response"]["acquirerMessage"])
			$message =  rawurldecode($responseArray["response"]["acquirerMessage"]);

			elseif(array_key_exists("gatewayRecommendation", $tmpArray))
			$message = rawurldecode($tmpArray["gatewayRecommendation"]);

			if($qp) {
				echo "<br/><br/><hr/><br/><br/>acquirerMessage=>".rawurldecode(@$responseArray["response"]["acquirerMessage"]);
				echo "<br/>gatewayRecommendation=>".@$tmpArray["gatewayRecommendation"];
				echo "<br/><br/><hr/><br/>";
			}
			
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
			if((empty(trim($td['acquirer_ref']))||$td['acquirer_ref']=='{}')&&!empty($acquirer_ref_1)){
				$tr_upd_status['acquirer_ref']=trim($acquirer_ref_1);
			}

			
			
			*/


			//upa =>["transaction"]["acquirer"]["batch"]
			$upa='';
			if(isset($responseArray["transaction"]["acquirer"]["batch"]))
			$upa = rawurldecode($responseArray["transaction"]["acquirer"]["batch"]);		
			//up upa : update if empty upa and is ["transaction"]["acquirer"]["batch"] 
			if(empty(trim($td['upa']))&&!empty($upa)){
				$tr_upd_status['upa']=trim($upa);
			}
		

			//rrn 
			$rrn='';
			//if(isset($trans_id)) $rrn = @$trans_id;
			if(isset($responseArray["transaction"]["receipt"]))
				$rrn = rawurldecode($responseArray["transaction"]["receipt"]);

			//up rrn : update if empty rrn and is ["transaction"]["receipt"] 
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

		//$_SESSION['curl_values']=htmlTagsInArray(@$curl_values);
		
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