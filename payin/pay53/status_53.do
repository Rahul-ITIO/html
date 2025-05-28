<?
// Dev Tech : 23-12-26  87 status binopay

$data['NO_SALT']=true;
$is_curl_on = true;


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
			//$data['gateway_push_notify'] = $responseParamList['responseDetail'];
		
			if(isset($responseParamList['data']['trxDetails']['trxRef'])&&isset($responseParamList['responseDetail'])&&@$responseParamList['responseDetail']) 
			{

				$transID_via_reference=rawurldecode($responseParamList['data']['trxDetails']['trxRef']);
				
				if(@$qp)
				{
					echo "<br/><hr/><br/>responseParamList=><br/>";
					print_r($responseParamList);

					echo "<br/><br/>transID_via_reference=>".$transID_via_reference;
					echo "<br/><br/>status=>".$responseParamList['responseDetail'];
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

	
	$acquirer_response_stage2		= @$td['acquirer_response_stage2'];	
	if(isset($acquirer_response_stage2)&&@$acquirer_response_stage2){
		
		$acquirer_response_stage2_decode64f  = decode64f($acquirer_response_stage2);
		//echo "<br/><hr/>acquirer_response_stage2=>".$acquirer_response_stage2_decode64f;
		$acquirer_response_stage2_arr = isJsonDe($acquirer_response_stage2_decode64f);

		$requestPost_3=$pst=@$acquirer_response_stage2_arr['requestPost_3'];
		$requestPost_3DS=json_encode($requestPost_3, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
		
		if(@$qp)
		{
			echo "<br/><hr/>acquirer_response_stage2_arr=><br/>";print_r(@$acquirer_response_stage2_decode64f);
			
		}
		
	}

	##################################################################################

	if(empty($acquirer_status_url)||strtolower($acquirer_status_url)=='NA') $acquirer_status_url="https://pr-web-payment-gateway.paycontactles.com/api/v1/report/get-transaction-detail";

	##################################################################################
		
		//{"bearer_key":"1yXt$PC3X0FLoigs"}


		$auth_ApiKey=@$apc_get['auth_ApiKey'];
		$header_ApiKey=@$apc_get['header_ApiKey'];
		$merchantCode=@$apc_get['merchantCode'];
		//$access_token=@decode64f(@$td['acquirer_response_stage1']);
		


		###########	ACCESS TOKEN -- START	##############################################################

			//	https://pr-web-api-gateway.paycontactles.com/api/v1/gateway/auth?apiKey=da3abd5072d1365ed172f836843e2b9a0c192c8c

			$url_step_1='https://pr-web-api-gateway.paycontactles.com/api/v1/gateway/auth?apiKey='.@$auth_ApiKey;

			// Initialize a cURL session
			$curl = curl_init();

			curl_setopt_array($curl, array(
			CURLOPT_URL => $url_step_1, // API endpoint
			CURLOPT_RETURNTRANSFER => true, // Return the transfer as a string
			CURLOPT_ENCODING => '', // Accept all encodings
			CURLOPT_MAXREDIRS => 10, // Maximum number of redirects
			CURLOPT_TIMEOUT => 0, // No timeout
			CURLOPT_FOLLOWLOCATION => true, // Follow redirects
			CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1, // Use HTTP 1.1
			CURLOPT_CUSTOMREQUEST => 'POST', // HTTP POST method
				CURLOPT_HEADER => 0,
				CURLOPT_SSL_VERIFYPEER => 0,
				CURLOPT_SSL_VERIFYHOST => 0,
			));

			// Execute the cURL session
			$response_token = curl_exec($curl);

			// Close the cURL session
			curl_close($curl);

			// Decode the JSON response to an array
			$response_array = json_decode($response_token,1);

			

			if(@$qp)
			{
				echo "<br/><hr/><br/>bank_url=><br/>"; print_r($url_step_1);
				
				echo "<br/><br/>response_array=><br/>"; print_r($response_array);
			}



			if(isset($response_array['access_token']) && @$response_array['access_token'])
			{
				$access_token=@$response_array['access_token'];
				
				if(@$qp) 
				{
					 echo "<br/><br/>RESPONSE TOKEN=><br/>"; print_r(@$access_token); 
				}
			}


		###########	ACCESS TOKEN -- END		##############################################################

		//$acquirer_ref = "f4ac2201-3d8b-4d01-a0a7-eb5a7a4ed252";

			
		// https://pr-web-payment-gateway.paycontactles.com/api/v1/report/get-transaction-detail/EBN00100843D/2024090312164628529054436969443451786092

		$acquirer_status_url=$acquirer_status_url.'/'.$merchantCode.'/'.$acquirer_ref;

		
			if(@$qp)
			{ // status key - Blue
				echo '<div type="button" class="btn btn-success my-2" style="word-wrap:break-word;background:#376799;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
				echo "<hr/><h3>STATUS KEY</h3>"; 

				echo "<br/>auth_ApiKey=>".@$auth_ApiKey;
				echo "<br/>header_ApiKey=> ".@$header_ApiKey;
				echo "<br/>merchantCode=> ".@$merchantCode;

				echo "<br/><br/>access_token=> <br/>".@$access_token;
				echo "<br/><br/>acquirer_status_url=> <br/>".@$acquirer_status_url;


				echo '<br/><br/></div>';
				//echo "<img src='payin/pay40/acquier_status.png' />";
			}
		
	##################################################################################
	


	//Amount deduct from card payment after return the response of bank OTP page if not admin session 
	//if(!isset($_SESSION['adm_login'])&&isset($requestPost_3DS)&&!empty($access_token))
	if(isset($requestPost_3DS)&&!empty($access_token))
	{
		
		$postData_3DS='{
            "merchantCode": "'.@$pst['merchantCode'].'",
            "transactionRefNumber": "'.@$pst['transactionRefNumber'].'",
            "amount": '.@$pst['amount'].',
            "currency": "840",
            "cardData": "'.$pst['cardData'].'",
            "callbackUrl" : "'.$pst['callbackUrl'].'",
            "redirectUrl" : "'.$pst['redirectUrl'].'"
        }';

        $curl = curl_init();

       
        $curl_bank_url_3='https://pr-web-payment-gateway.paycontactles.com/api/v2/payments';

        curl_setopt_array($curl, array(
        CURLOPT_URL => $curl_bank_url_3, // API endpoint
        CURLOPT_RETURNTRANSFER => true, // Return the transfer as a string
        CURLOPT_ENCODING => '', // Accept all encodings
        CURLOPT_MAXREDIRS => 10, // Maximum number of redirects
        CURLOPT_TIMEOUT => 0, // No timeout
        CURLOPT_FOLLOWLOCATION => true, // Follow redirects
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1, // Use HTTP 1.1
        CURLOPT_CUSTOMREQUEST => 'POST', // HTTP POST method
            CURLOPT_HEADER => 0,
            CURLOPT_SSL_VERIFYPEER => 0,
            CURLOPT_SSL_VERIFYHOST => 0,
            CURLOPT_POSTFIELDS =>$postData_3DS, // JSON payload for the request
            CURLOPT_HTTPHEADER => array(
            'ApiKey: '.$header_ApiKey,
            'Content-Type: application/json',
            'Authorization: Bearer '.$access_token
            ),
        ));

        // Execute the cURL session
        $response_3 = curl_exec($curl);

        // Close the cURL session
        curl_close($curl);

        // Decode the JSON response to an array
        $response_3_via_pay = json_decode($response_3, 1);

		$res_3_via_pay=(isset($response_3_via_pay)&&is_array($response_3_via_pay)?htmlTagsInArray($response_3_via_pay):stf($response_3));

		if(@$qp)
		{
			
			//echo "<br/><hr/>res_3_via_pay=><br/>";print_r(@$res_3_via_pay);
			
		}
		
		if(@$qp)
		{ // status key - Orange
			echo '<div type="button" class="btn btn-success my-2" style="word-wrap:break-word;background:#376799;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
			echo "<hr/><h3>3DS ACCESS AFTER BANK OTP</h3>"; 
			

			echo "<br/>access_token=> <br/>".@$access_token;
			echo "<br/><br/>3DS Access URL=> <br/>".@$curl_bank_url_3;

			echo "<br/><br/><hr/>postData_3DS=><br/>";print_r(@$postData_3DS);
			echo "<br/><br/><hr/>res_3_via_pay=><br/>";print_r(@$res_3_via_pay);

			echo '<br/><br/></div>';
		}
	

        if(isset($response_3_via_pay['paymentRefNumber'])&&@$response_3_via_pay['paymentRefNumber'])
        {
            //$tr_upd_order1['acquirer_ref']=@$response_3_via_pay['paymentRefNumber']; 
        }

	}

	//status check 
	if($is_curl_on)
    {
		

		// Initialize 
		$curl = curl_init();

		curl_setopt_array($curl, array(
		CURLOPT_URL => $acquirer_status_url, // API endpoint
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => '',
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 0,
		CURLOPT_FOLLOWLOCATION => true,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => 'GET',
		CURLOPT_HTTPHEADER => array(
			"ApiKey: {$header_ApiKey}",
			"Authorization: Bearer ".$access_token
		),
		));

		// Execute the cURL session
		$response = curl_exec($curl);

				
		/*

		"responseCode": "12",
		"responseDetail": "DECLINED",
		"transactionDescription": null,

		
		// <<live

		{
			"transactionId": 65469,
			"merchantCode": "EBN001**843D",
			"paymentChannel": "WEB GATEWAY",
			"paymentType": "ECOM_PAYMENT",
			"transactionRef": "5316078145",
			"referenceNumber": "202409******************************6092",
			"status": "UNKNOWN",
			"merchantName": "Multic*******mart",
			"companyType": "Digital Goods – Large Digital Goods Merchant",
			"address": "3 Kunl**************reet",
			"location": "3 Kunl**************reet",
			"amount": null,
			"transactionCurrency": "USD",
			"billingAmount": "12.03",
			"billingCurrency": "USD",
			"dateTime": null,
			"responseCode": "12",
			"responseDetail": "DECLINED",
			"transactionDescription": null,
			"authCode": null,
			"cardNo": null,
			"rrn": null,
			"stan": null,
			"reversalReason": null,
			"cardSchema": null
		}

		// <<test 
		{
			"transactionId": 130998,
			"merchantCode": "TESTUB****PHNG",
			"paymentChannel": "WEB GATEWAY",
			"paymentType": "ECOM_PAYMENT",
			"transactionRef": "84770574",
			"referenceNumber": "f4ac22**************************d252",
			"status": "SUCCESS",
			"merchantName": "ECOM A***TEST",
			"companyType": "Other",
			"address": "4028 W**********Road",
			"location": "4028 W**********Road",
			"amount": "110.00",
			"transactionCurrency": "USD",
			"billingAmount": "110.00",
			"billingCurrency": "USD",
			"dateTime": "2024-08-06T05:05:25.443+00:00",
			"responseCode": "00",
			"responseDetail": "APPROVED",
			"transactionDescription": null,
			"authCode": "332739",
			"cardNo": "512345******0008",
			"rrn": "421905**2739",
			"stan": "332739",
			"reversalReason": null,
			"cardSchema": null
		}

		*/



		// Close the cURL session
		curl_close($curl);

		//echo $response;
		// Decode the JSON response to an array
		$responseParamList = json_decode($response, 1);

	}

	$results = @$responseParamList;
	
	if(@$qp)
	{ // status - Green
		echo '<div type="button" class="btn btn-success my-2" style="word-wrap:break-word;background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
		echo "<hr/><h3>STATUS RESPONSE</h3>"; 

		echo "<br/>mode=>".$apc_get['mode'];
		echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
		echo "<br/>auth_key=> ".$auth_key;

		echo "<br/><br/>acquirer status ['responseDetail']=> ".@$responseParamList['responseDetail'];
		echo "<br/>acquirer message ['status']=> ".@$responseParamList['status'];
		echo "<br/>acquirer message ['responseCode']=> ".@$responseParamList['responseCode'];
		echo "<br/>acquirer responseAmount ['billingAmount']=> ".@$responseParamList['billingAmount'];
		echo "<br/>acquirer Description ['transactionDescription']=> ".@$responseParamList['transactionDescription'];
		
		//echo "<br/>response_json=> ".@$response_json;
		echo "<br/><br/>response=> "; print_r($response);
		echo "<br/><br/>responseParamList=> "; print_r($responseParamList);
		
		//echo "<br/><br/>res=> ".htmlentitiesf(@$responseParamList);
		echo '<br/><br/></div>';
		//echo "<img src='payin/pay40/acquier_status.png' />";
	}

	

	if (isset($responseParamList) && count($responseParamList)>0)
	{
		//$message = @$responseParamList['header']['status']['message'];
		$message='';
		//if(@$responseParamList['status']) $message = @$responseParamList['status'];
		
		$status = "";
		if(isset($responseParamList['responseDetail'])) 
		{
			$status = strtolower($responseParamList['responseDetail']);
			$message = @$responseParamList['responseDetail'];
		}
			
			
		if(isset($responseParamList['billingAmount'])&&$responseParamList['billingAmount'])
		{
		 	$_SESSION['responseAmount']=$responseParamList['billingAmount'];
		}
		
		if(isset($responseParamList['transactionDescription'])&&trim($responseParamList['transactionDescription'])&&$responseParamList['transactionDescription']!=null)
		{
		 	$_SESSION['acquirer_descriptor']=trim($responseParamList['transactionDescription']);
		}
		
		
		/*
		
		//rrn //acquirer_ref
		#######	rrn, acquirer_ref update from status get :start 	###############
			
			//acquirer_ref
			$acquirer_ref_1='';
			if(isset($responseParamList['data']['transactionId'])) $acquirer_ref_1 = @$responseParamList['data']['transactionId'];
			//up acquirer_ref : update if empty acquirer_ref_1 and is ['data']['transactionId']  
			if(empty(trim($td['acquirer_ref']))&&!empty($acquirer_ref_1)&&$acquirer_ref_1!='{}'&&$acquirer_ref_1!=NULL){
				$tr_upd_status['acquirer_ref']=trim($acquirer_ref_1);
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
	*/
		
		

		$_SESSION['acquirer_action']=1;
		$_SESSION['acquirer_response']=$message;
		//$_SESSION['curl_values']=$responseParamList;

		//if(!empty($status))
		{
			if(@$status=='success' || @$status=='approved'){ //success
				$_SESSION['acquirer_response']=$message." - Success";
				$_SESSION['acquirer_status_code']=2;
			}
			elseif(@$status=='failed' || @$status=='declined' || @$status=='blocked' || @$responseParamList['status']=='BAD_REQUEST' || @$responseParamList['responseCode']=='12')
			{	//failed || timed_out
				
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