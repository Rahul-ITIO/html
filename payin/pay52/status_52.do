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
			//$data['gateway_push_notify'] = $responseParamList['data']['trxDetails']['status'];
		
			if(isset($responseParamList['data']['trxDetails']['trxRef'])&&isset($responseParamList['data']['trxDetails']['status'])&&@$responseParamList['data']['trxDetails']['status']) 
			{

				$transID_via_reference=rawurldecode($responseParamList['data']['trxDetails']['trxRef']);
				
				if(@$qp)
				{
					echo "<br/><hr/><br/>responseParamList=><br/>";
					print_r($responseParamList);

					echo "<br/><br/>transID_via_reference=>".$transID_via_reference;
					echo "<br/><br/>status=>".$responseParamList['data']['trxDetails']['status'];
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
		
	if($is_curl_on)
    {
		##################################################################################

			if(empty($acquirer_status_url)||strtolower($acquirer_status_url)=='NA') $acquirer_status_url="https://staging.borderlesspaymentng.com/api/charge/validation";

		##################################################################################
			
			//{"bearer_key":"1yXt$PC3X0FLoigs"}


			$bearer_key=@$apc_get['bearer_key'];

			if(empty($bearer_key)&&isset($apc_get_a['live']['bearer_key'])&&!empty($apc_get_a['live']['bearer_key']))
			{
				$bearer_key=@$apc_get_a['live']['bearer_key'];
			}
			
				//$acquirer_ref = "5b7d49a2-4276-11ef-a294-ea4cdff7277e";
			
			
		##################################################################################

		// Initialize a cURL session
		$curl = curl_init();

		curl_setopt_array($curl, array(
		CURLOPT_URL => $acquirer_status_url, // API endpoint
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
			CURLOPT_POSTFIELDS =>'{
				"reference" : "'.$transID.'",
				"orderid" : "'.@$acquirer_ref.'"
			}',
			CURLOPT_HTTPHEADER => array(
				'Authorization: Bearer '.$bearer_key,
				'Content-Type: application/json',
				'Cookie: XSRF-TOKEN=eyJpdiI6IjZIclE0WXB2ZWVIcWhhYjdUQjJYRkE9PSIsInZhbHVlIjoiUzJhRkpDUGVxaDVmNXV3STBUakFXWjQzeUlmTGE1dzN0ZlFGK1dKWm1ycGRqZCsxekFLWEcxcUdrcFdBdEM3ZmNjcG5QcC9yS1ZFSis3TUFQTTlZSllkVlpCS2dQRnMzVWp4ejNzSktETFVOeDR1K3JwdGRzWExTVFdwRkdzRHgiLCJtYWMiOiIyNzdkNjljZDE4OThjMzhiODViYWU0NjNlZThiZWU3ZjExNTk0MDY0ODcwY2MzZTc5MzM5MjE2MTE1YjBiNWU1IiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IjlkaFB1ejhobk93MFJTc3RGS0xGNEE9PSIsInZhbHVlIjoiUlpqMzVWVFhYUEs5amc3TnQrRFlOckkzWUVKRXdEdmwxeGMxQXVudTRKMTA1ZWtFbDdzMEtBZ2JmTnNxTlNDd0U1ZnMvdHRneStQVUp4cENZblRMUTcyUGJ6ZTRGTmxRS0pQV0dZaGxJQUhQbXNaMldoM3laTUdObFN4ZjduODEiLCJtYWMiOiJkNDg4MDFkZDZlN2RkODJmMzM5NDYyM2I3ZTQ2YTEyYjc5ZmZiMDQ2MjMzNjA3NDg0Njc4NzUxZTM3N2YyZjBlIiwidGFnIjoiIn0%3D'
			  ),
		));

		// Execute the cURL session
		$response = curl_exec($curl);

		/*
		['data']['trxDetails']['status']
		['data']['trxDetails']['message']
		['data']['trxDetails']['amount']
		{
			"data": {
				"trxDetails": {
					"status": "pending",
					"message": "None",
					"trxRef": "12300002",
					"amount": "0.01",
					"currency": "USD",
					"transDate": "2024-08-03 05:01:46"
				},
				"custDetails": {
					"fullName": "First Last",
					"email": "123000@gmail.com",
					"phone": "+15556664444"
				},
				"cardDetails": {
					"cardType": "MASTERCARD",
					"cardNumber": "555555******6666",
					"expiryDate": "10/2031"
				}
			},
			"message": "success",
			"status": "success"
		}
		*/

		// Close the cURL session
		curl_close($curl);

		//echo $response;
		// Decode the JSON response to an array
		$responseParamList = json_decode($response, 1);

	}

	$results = @$responseParamList;
	/*
	['data']['trxDetails']['status']
	['data']['trxDetails']['message']
	['data']['trxDetails']['amount']
	*/
	if(@$qp)
	{
		echo '<div type="button" class="btn btn-success my-2" style="word-wrap:break-word;background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
		//echo "res=>"; print_r($res);
		echo "<br/>mode=>".$apc_get['mode'];
		echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
		echo "<br/>auth_key=> ".$auth_key;

		echo "<br/><br/>acquirer status ['data']['trxDetails']['status']=> ".@$responseParamList['data']['trxDetails']['status'];
		echo "<br/>acquirer message ['data']['trxDetails']['message']=> ".@$responseParamList['data']['trxDetails']['message'];
		echo "<br/>acquirer responseAmount ['data']['trxDetails']['amount']=> ".@$responseParamList['data']['trxDetails']['amount'];
		
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
		if(@$responseParamList['data']['trxDetails']['message']) $message = @$responseParamList['data']['trxDetails']['message'];

		if($message=='Transaction not found'&&!empty($td['trans_response'])){
			$message = @$td['trans_response'];
		}
		

		if(@$qp) echo "<br/>acquirer message => ".@$message;

		$status = "";
		if(isset($responseParamList['data']['trxDetails']['status']))
			$status = strtolower($responseParamList['data']['trxDetails']['status']);
			
			
		if(isset($responseParamList['data']['trxDetails']['amount'])&&$responseParamList['data']['trxDetails']['amount'])
		{
		 	$_SESSION['responseAmount']=$responseParamList['data']['trxDetails']['amount'];
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

		if(!empty($status))
		{
			if($status=='success' || $status=='approved'){ //success
				$_SESSION['acquirer_response']=$message." - Success";
				$_SESSION['acquirer_status_code']=2;
			}
			elseif(@$responseParamList['data']['trxDetails']['message']=='Transaction not found' || $status=='failed')
			//elseif(@$responseParamList['data']['trxDetails']['message']=='Transaction not found' )
			
			{	//failed || timed_out
				
				$_SESSION['acquirer_response']=$message;
				$_SESSION['acquirer_status_code']=23;
			}
			elseif($status=='declined' ){	//failed || timed_out
				
				$_SESSION['acquirer_response']=$message." - Cancelled";
				$_SESSION['acquirer_status_code']=-1;
			}
			else{ //pending
				//$message = "User Paying / Pending";
				$_SESSION['acquirer_response']=$message." - Pending";
				$_SESSION['acquirer_status_code']=1;
				
			}
		}
	}
}

if(@$qp) echo "<br/>acquirer_status_code => ".@$_SESSION['acquirer_status_code'];
if(@$qp) echo "<br/>acquirer response => ".@$_SESSION['acquirer_response'];
if(@$qp) echo "<br/>status => ".@$status;

if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}

?>