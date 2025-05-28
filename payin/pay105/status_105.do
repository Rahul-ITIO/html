<?
// Dev Tech : 24-5-01  105 status cybersource

$data['NO_SALT']=true;
$is_curl_on = true;
//$is_curl_on = false;

$data['HideMenu']=true;
$data['NO_SALT']=true;
$data['SponsorDomain']=true;

//if((isset($_REQUEST['acquirer_ref']))&&(!empty($_REQUEST['acquirer_ref']))) $_REQUEST['acquirer_ref'] = $_REQUEST['acquirer_ref'];



// access status via callback - end

if(isset($data['ROOT'])&&$data['ROOT']) $root=$data['ROOT'];
else $root='../../';

if(!isset($data['STATUS_ROOT'])){
	include($root.'config_db.do');

	//webhook : 
	if(isset($_REQUEST['action'])&&$_REQUEST['action']=='webhook')
	{

			$body_input = file_get_contents("php://input");
			$response = @$body_input;

			$response = (html_entity_decode($response)); $response = str_replace(["&gt; ","&gt;"],"",$response);
			
			$responseParamList = $data['gateway_push_notify'] = json_decode($response, true);
			//$data['gateway_push_notify'] = $responseParamList['transactionStatus'];
		
			if(isset($responseParamList['orderId'])&&isset($responseParamList['transactionStatus'])&&@$responseParamList['transactionStatus']) 
			{

				$transID_via_reference=rawurldecode($responseParamList['orderId']);
				
				if(@$qp)
				{
					echo "<br/><hr/><br/>responseParamList=><br/>";
					print_r($responseParamList);

					echo "<br/><br/>transID_via_reference=>".$transID_via_reference;
					echo "<br/><br/>status=>".$responseParamList['transactionStatus'];
				}

				$transID_via_reference=preg_replace("/[^0-9.]/", "",@$transID_via_reference);

				$_REQUEST['transID']= rawurldecode($transID_via_reference);
				$is_curl_on = false; $_REQUEST['action']='webhook';

				if(@$qp)
				{
					echo "<br/><br/>transID 1=>".@$transID_via_reference;
					echo "<br/><br/>transID _REQUEST=>".@$_REQUEST['transID'];
				}

			}
			
			//echo "<hr/><br/>is_curl_on=>".$is_curl_on ; echo "<br/>transID via webhook=>".$_REQUEST['transID']; echo "<br/><br/>responseParamList=>"; print_r($responseParamList); exit;

		

	}

	//exit;

	//include($data['Path'].'/payin/res_insert'.$data['iex']);
	include($data['Path'].'/payin/status_top'.$data['iex']);//include status_top if the page execute directly
}




//include($data['Path'].'/payin/status_in_email'.$data['iex']);

//print_r($td);
//print_r($json_value);



if(!empty($transID))
{

	
	##################################################################################
	
	$payment_id=@$acquirer_ref; // Payment Id fetch via Acquire Ref db 
	$channel=@$apc_get['channel'];
	$merchantReferenceCode=@$td['rrn'];

	if($data['localhosts']==true&&empty($channel)) $channel='001';

	##################################################################################

	//if(!empty($channel)&&!empty($merchantReferenceCode)&&!empty($payment_id)) $is_curl_on = true;

	##################################################################################

		
	if($is_curl_on)
    {



		##################################################################################

			if(empty($acquirer_status_url)||strtolower($acquirer_status_url)=='NA') $acquirer_status_url="https://secure.yoqo.io/requests/search";
				
				

		##################################################################################
			
		$acquirer_status_url_config=$acquirer_status_url."/update-config";
			
		// Initialize a cURL session
		$curl = curl_init();

		curl_setopt_array($curl, array(
		CURLOPT_URL => $acquirer_status_url_config, // API endpoint
		CURLOPT_RETURNTRANSFER => true, // Return the transfer as a string
		CURLOPT_ENCODING => '', // Accept all encodings
		CURLOPT_MAXREDIRS => 10, // Maximum number of redirects
		CURLOPT_TIMEOUT => 0, // No timeout
		CURLOPT_FOLLOWLOCATION => true, // Follow redirects
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1, // Use HTTP 1.1
			CURLOPT_HEADER => 0,
			CURLOPT_SSL_VERIFYPEER => 0,
			CURLOPT_SSL_VERIFYHOST => 0,
			CURLOPT_CUSTOMREQUEST => 'POST',
		CURLOPT_POSTFIELDS =>'{
    "channelId": "'.@$channel.'",
    "merchantID": "'.@$apc_get['merchant_mid'].'",
    "merchantKey": "'.@$apc_get['merchantKey'].'",
    "merchantKeySecret": "'.@$apc_get['merchantKeySecret'].'",
    "apiKey": "'.@$apc_get['apiKey'].'",
    "orgUnitId": "'.@$apc_get['orgUnitId'].'",
    "apiIdentifier": "'.@$apc_get['apiIdentifier'].'"
}',
		CURLOPT_HTTPHEADER => array(
			'Content-Type: application/json'
		),
		));

		// Execute the cURL session
		$response_cong = curl_exec($curl);


		##################################################################################
/*		
		if(isset($merchantReferenceCode)&&@$merchantReferenceCode!=$transID&&@$payment_id)
		{
			$status_payload='{
				"channel": "'.@$channel.'",
				"merchantReferenceCode": "'.@$merchantReferenceCode.'",
				"requestId": "'.@$payment_id.'",
				"reconciliationId": null
			}';
		}
		else {
			$status_payload='{
				"channel": "'.@$channel.'",
				"orderId": "'.@$transID.'"
			}';
		}
*/
		$status_payload='{
			"channel": "'.@$channel.'",
			"orderId": "'.@$transID.'"
		}';

		##################################################################################
			
		$acquirer_status_url=$acquirer_status_url."/requests/search";

		// Initialize a cURL session
		$curl = curl_init();

		curl_setopt_array($curl, array(
		CURLOPT_URL => $acquirer_status_url, // API endpoint
		CURLOPT_RETURNTRANSFER => true, // Return the transfer as a string
		CURLOPT_ENCODING => '', // Accept all encodings
		CURLOPT_MAXREDIRS => 10, // Maximum number of redirects
		CURLOPT_TIMEOUT => 2, // No timeout
		CURLOPT_FOLLOWLOCATION => true, // Follow redirects
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1, // Use HTTP 1.1
			CURLOPT_HEADER => 0,
			CURLOPT_SSL_VERIFYPEER => 0,
			CURLOPT_SSL_VERIFYHOST => 0,
			CURLOPT_CUSTOMREQUEST => 'POST',
		CURLOPT_POSTFIELDS =>$status_payload,
		CURLOPT_HTTPHEADER => array(
			'Content-Type: application/json'
		),
		));

		// Execute the cURL session
		$response = curl_exec($curl);

		/*
			
		
		*/

		// Close the cURL session
		curl_close($curl);

		$response = preg_replace('~[\r\n\t]+~', '', $response);


		//echo $response;
		// Decode the JSON response to an array
		$responseParamList = json_decode($response, 1);

	}

	$results = @$responseParamList;


	if(@$qp)
	{
		echo '<div type="button" class="btn btn-success my-2" style="word-wrap:break-word;background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
		//echo "res=>"; print_r($res);
		echo "<br/>mode=>".$apc_get['mode'];
		echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
		echo "<br/>channel=> ".$channel;
		echo "<br/>merchantReferenceCode=> ".$merchantReferenceCode;
		echo "<br/>requestId=> ".$payment_id;
		echo "<br/><br/>status_payload=> ".$status_payload;


		echo "<br/><br/>acquirer status ['status']=> ".@$responseParamList['status'];
		echo "<br/><br/>acquirer ['statusCode']=> ".@$responseParamList['statusCode'];

		echo "<br/><br/><br/>acquirer status ['transactionStatus']=> ".@$responseParamList['transactionStatus'];
		echo "<br/>acquirer message ['result']=> ".@$responseParamList['technicalMessage'];
		echo "<br/>acquirer responseAmount ['amount']=> ".@$responseParamList['authorizedAmount'];
		echo "<br/>acquirer rrn ['threeDSServerTransactionId']=> ".@$responseParamList['threeDSServerTransactionId'];
		

		//echo "<br/>response_json=> ".@$response_json;
		echo "<br/><br/>response=> "; print_r($response);
		echo "<pre>";
		echo "<br/><br/>responseParamList=> "; print_r($responseParamList);
		echo "</pre>";
		
		//echo "<br/><br/>res=> ".htmlentitiesf(@$responseParamList);
		echo '<br/><br/></div>';
		//echo "<img src='payin/pay40/acquier_status.png' />";
		
	}

	
	if(@$qp)
	{
		if(isset($responseParamList["statusCode"])&&$responseParamList["statusCode"]==400)  
		echo "<br/><br/>if statusCode=> ".$responseParamList["statusCode"]; 

		echo "<br/><br/>count=> ".count($responseParamList); 
	}


	if (isset($responseParamList) && count($responseParamList)>0)
	{
		//$message = @$responseParamList['header']['status']['message'];
		$message='';
		if(@$responseParamList['errorMessage']) $message = @$responseParamList['errorMessage'];
		elseif(@$responseParamList['technicalMessage']) $message = @$responseParamList['technicalMessage'];
		elseif(@$responseParamList['status']) $message = @$responseParamList['status'];
		
		$status = "";
		if(isset($responseParamList['transactionStatus']))
			$status = strtolower($responseParamList['transactionStatus']);
		
			
		if(isset($responseParamList['authorizedAmount'])&&$responseParamList['authorizedAmount'])
		{
		 	$_SESSION['responseAmount']=$responseParamList['authorizedAmount'];
		}
		
		
		
		
		//rrn //acquirer_ref
		#######	rrn, acquirer_ref update from status get :start 	###############
			
			//acquirer_ref
			$acquirer_ref_1='';
			if(isset($responseParamList['requestId'])) $acquirer_ref_1 = @$responseParamList['requestId'];
			//up acquirer_ref : update if empty acquirer_ref_1 and is ['requestId']  
			if ((empty(trim(isset($td['acquirer_ref']) ? $td['acquirer_ref'] : '')) || $td['acquirer_ref'] == '{}') && (!empty($acquirer_ref_1) && $acquirer_ref_1 !== null)) {
				$tr_upd_status['acquirer_ref'] = trim($acquirer_ref_1);
			}
			
			//rrn 
			$rrn='';
			if(isset($responseParamList['threeDSServerTransactionId'])) $rrn = @$responseParamList['threeDSServerTransactionId'];
			//if(isset($responseParamList['merchantReferenceCode'])) $rrn = @$responseParamList['merchantReferenceCode'];
			//up rrn : update if empty rrn and is ['merchantReferenceCode'] 
			if (empty(trim($td['rrn'] ?? '')) && !empty($rrn)) {
				$tr_upd_status['rrn'] = trim($rrn);
			}
			


			//upa =>transactionId
			$upa='';
			if(isset($responseParamList['transactionId'])) $upa = @$responseParamList['transactionId'];
			//up upa : update if empty upa and is upiId 
			if (empty(trim($td['upa'] ?? '')) && !empty($upa)) {
				$tr_upd_status['upa'] = trim($upa);
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
	
		
		

		$_SESSION['acquirer_action']=1;
		$_SESSION['acquirer_response']=$message;
		//$_SESSION['curl_values']=$responseParamList;

		if(!empty($status)||isset($responseParamList["statusCode"]))
		{
			if($status=='success' || $status=='settled'){ //success
				$_SESSION['acquirer_response']="Approved";
				$_SESSION['acquirer_status_code']=2;
			}
			elseif( ($status=='failed' || $status=='FAILED' ) || (isset($responseParamList["statusCode"])&&$responseParamList["statusCode"]==400)  )
			{	//failed || timed_out FAILED
				
				$_SESSION['acquirer_response']=$message." - Cancelled";
				$_SESSION['acquirer_status_code']=-1;
			}
			/*
			else{ //pending
				//$message = "User Paying / Pending";
				$_SESSION['acquirer_response']=$message." - Pending";
				$_SESSION['acquirer_status_code']=1;
				
			}
			*/
		}
	}
}


if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}

?>