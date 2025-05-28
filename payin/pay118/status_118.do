<?
// Dev Tech : 25-02-20  118 status 

$data['NO_SALT']=true;
$is_curl_on = true;


//if((isset($_REQUEST['acquirer_ref']))&&(!empty($_REQUEST['acquirer_ref']))) $_REQUEST['acquirer_ref'] = $_REQUEST['acquirer_ref'];

if((isset($_REQUEST['merchant_ref']))&&(!empty($_REQUEST['merchant_ref']))) 
{ 
	$transID_via_merchant_ref = rawurldecode($_REQUEST['merchant_ref']);
	$transID_via_merchant_ref=preg_replace("/[^0-9.]/", "",@$transID_via_merchant_ref);
	$_REQUEST['transID']= rawurldecode($transID_via_merchant_ref);
}


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
		
			if(isset($responseParamList['merchant_ref'])) 
			{

				$transID_via_reference=rawurldecode($responseParamList['merchant_ref']);
				
				if(@$qp)
				{
					echo "<br/><hr/><br/>responseParamList=><br/>";
					print_r($responseParamList);

					echo "<br/><br/>transID_via_reference=>".$transID_via_reference;
					echo "<br/><br/>status=>".$responseParamList['transactionStatus'];
				}

				$transID_via_reference=preg_replace("/[^0-9.]/", "",@$transID_via_reference);

				$_REQUEST['transID']= rawurldecode($transID_via_reference);
				//$is_curl_on = false; $_REQUEST['action']='webhook';

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
		
	if($is_curl_on)
    {

		##################################################################################

			$secret_key=@$apc_get['secret_key'];

		
			$payment_id = @$acquirer_ref; // Payment Id fetch via Acquire Ref db 


		##################################################################################

			//https://api.pay.agency/v1/test/get/transaction

			if(empty($acquirer_status_url)||strtolower($acquirer_status_url)=='NA') $acquirer_status_url="https://pg-api.transactionjunction.com/prod/ipgw/gateway/v1";

		##################################################################################
		
			
			
		// Initialize a access token
		
				
		$token_url="https://prod-ipgw-oauth.auth.eu-west-1.amazoncognito.com/oauth2/token";
		
		$client_id=@$apc_get['client_id'];//"rk5cktg38koapig55pckagdd";
		$client_secret=@$apc_get['client_secret'];//"1r63s9aqf6to4tmeq4j229p8ioeqjnq05mcf5tjt7f5of3arvsbl";
		$merchantID=@$apc_get['merchantID'];//"f660d8c4-c839-4dac-a05d-7ea2138c5202";
		$profileID=@$apc_get['profileID'];//"44525823-af88-427a-98bb-4f8175edc3b7";
		$merchantRef=$transID; /// Transaction Referance Number

		if(isset($_REQUEST['hc']))
		{
			$client_id="rk5cktg38koapig55pckagdd";
			$client_secret="1r63s9aqf6to4tmeq4j229p8ioeqjnq05mcf5tjt7f5of3arvsbl";
			$merchantID="f660d8c4-c839-4dac-a05d-7ea2138c5202";
			$profileID="44525823-af88-427a-98bb-4f8175edc3b7";
			$merchantRef="Visa_test"; /// Transaction Referance Number
		}

		///////////////////////Step-1////////////////////////////

		$curl = curl_init();

		curl_setopt_array($curl, [
		CURLOPT_URL => $token_url,
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => "",
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 30,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => "POST",
			CURLOPT_HEADER => 0,
			CURLOPT_SSL_VERIFYPEER => 0,
			CURLOPT_SSL_VERIFYHOST => 0,
		CURLOPT_POSTFIELDS => "grant_type=client_credentials&client_id=$client_id&client_secret=$client_secret",
		CURLOPT_HTTPHEADER => [
			"Accept: application/json",
			"Content-Type: application/x-www-form-urlencoded"
		],
		]);

		$response = curl_exec($curl);
		$err = curl_error($curl);

		curl_close($curl);

		if ($err) {
			echo "cURL Error #:" . $err;
		} else {
			// echo $response;
		}

		$res = json_decode($response,1);
			
		if(isset($res["access_token"])&&$res["access_token"])
		{
			$access_token=$res["access_token"];
		}else{
			echo "Access Token Not Generated";
			//exit;
		}


		//////////////STEP 2 :: Get Transaction details from Merchant Reference:  /////////////////

		$curl = curl_init();

		curl_setopt_array($curl, array(
		CURLOPT_URL => $acquirer_status_url."/transactions/search?merchantRef={$merchantRef}&merchantId={$merchantID}&profileId={$profileID}",
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
			"Accept: application/json",
				"Authorization: Bearer $access_token",
				"Content-Type: application/json"
		),
		));

		$response = curl_exec($curl);





		##################################################################################

		/*
			
		
		*/

		// Close the cURL session
		curl_close($curl);

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
		echo "<br/>token_request=> grant_type=client_credentials&client_id=$client_id&client_secret=$client_secret";
		echo "<br/>access_token=> ".$access_token;

		echo "<br/><br/>acquirer status ['transactionStatus']=> ".@$responseParamList['transactionStatus'];
		//echo "<br/>acquirer message ['result']=> ".@$responseParamList['transaction']['result']['message'];
		echo "<br/>acquirer responseAmount ['amount']=> ".@$responseParamList['amount'];
		

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
		if(@$responseParamList['transaction']['result']['message']) $message = @$responseParamList['transaction']['result']['message'];
		
		$status = "";
		if(isset($responseParamList['transactionStatus']))
			$status = strtolower($responseParamList['transactionStatus']);
			
			
		if(isset($responseParamList['amount'])&&$responseParamList['amount'])
		{
		 	$_SESSION['responseAmount']=$responseParamList['amount'];
		}
		
		
		//rrn //acquirer_ref
		#######	rrn, acquirer_ref update from status get :start 	###############
			
			//acquirer_ref
			$acquirer_ref_1='';
			if(isset($responseParamList['transactionId'])) $acquirer_ref_1 = @$responseParamList['transactionId'];
			//up acquirer_ref : update if empty acquirer_ref_1 and is ['requestId']  
			if ((empty(trim(isset($td['acquirer_ref']) ? $td['acquirer_ref'] : '')) || $td['acquirer_ref'] == '{}') && (!empty($acquirer_ref_1) && $acquirer_ref_1 !== null)) {
				$tr_upd_status['acquirer_ref'] = trim($acquirer_ref_1);
			}
			
			//rrn 
			$rrn='';
			if(isset($responseParamList['paymentMethodDetails']['card']['rrn'])) $rrn = @$responseParamList['paymentMethodDetails']['card']['rrn'];
			if (empty(trim($td['rrn'] ?? '')) && !empty($rrn)) {
				$tr_upd_status['rrn'] = trim($rrn);
			}
			


			//upa =>paymentIntentId
			$upa='';
			if(isset($responseParamList['paymentIntentId'])) $upa = @$responseParamList['paymentIntentId'];
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

		if(!empty($status))
		{
			if($status=='success' || $status=='payment_settled' || $status=='settled'){ //success
				$_SESSION['acquirer_response']="Approved";
				$_SESSION['acquirer_status_code']=2;
			}
			elseif($status=='failed'||$status=='3ds_failed'){	//failed || timed_out
				
				$_SESSION['acquirer_response']="Cancelled";
				$_SESSION['acquirer_status_code']=-1;
			}
			else{ //pending
				//$message = "User Paying / Pending";
				$_SESSION['acquirer_response']="Pending";
				$_SESSION['acquirer_status_code']=1;
				
			}
		}
	}
}


if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}

?>