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
			//$data['gateway_push_notify'] = $responseParamList['transaction']['result']['status'];
		
			if(isset($responseParamList['transaction']['order_id'])&&isset($responseParamList['transaction']['result']['status'])&&@$responseParamList['transaction']['result']['status']) 
			{

				$transID_via_reference=rawurldecode($responseParamList['transaction']['order_id']);
				
				if(@$qp)
				{
					echo "<br/><hr/><br/>responseParamList=><br/>";
					print_r($responseParamList);

					echo "<br/><br/>transID_via_reference=>".$transID_via_reference;
					echo "<br/><br/>status=>".$responseParamList['transaction']['result']['status'];
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

			$secret_key=@$apc_get['secret_key'];

		
			$payment_id = @$acquirer_ref; // Payment Id fetch via Acquire Ref db 


		##################################################################################

			//https://api.pay.agency/v1/test/get/transaction

			if(empty($acquirer_status_url)||strtolower($acquirer_status_url)=='NA') $acquirer_status_url="https://api.pay.agency/v1/test/get/transaction";

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
			CURLOPT_HEADER => 0,
			CURLOPT_SSL_VERIFYPEER => 0,
			CURLOPT_SSL_VERIFYHOST => 0,
			CURLOPT_CUSTOMREQUEST => 'POST',
		CURLOPT_POSTFIELDS =>'{
    "transaction_id": "'.@$payment_id.'"
}',
			CURLOPT_HTTPHEADER => array(
					'Content-Type: application/json',
					'Authorization: Bearer '.@$secret_key,
					'Cookie: AWSALB=Jskx+Ui93xam625FsveUwPh/rYjBJTLB/2/cDEVrNwgGfWzHQviEt5aw/fkkbhRsuKEn6WRAD86ePyu1z58VGBJCQB3sj+faKr/kVk9tWVLqbQENKCyLRtI9crJo; AWSALBCORS=Jskx+Ui93xam625FsveUwPh/rYjBJTLB/2/cDEVrNwgGfWzHQviEt5aw/fkkbhRsuKEn6WRAD86ePyu1z58VGBJCQB3sj+faKr/kVk9tWVLqbQENKCyLRtI9crJo'
			),
		));

		// Execute the cURL session
		$response = curl_exec($curl);

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
		echo "<br/>secret_key=> ".$secret_key;
		echo "<br/>transaction_id=> ".$payment_id;

		echo "<br/><br/>acquirer status ['status']=> ".@$responseParamList['transaction']['result']['status'];
		echo "<br/>acquirer message ['result']=> ".@$responseParamList['transaction']['result']['message'];
		echo "<br/>acquirer responseAmount ['amount']=> ".@$responseParamList['transaction']['order']['amount'];
		

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
		if(isset($responseParamList['transaction']['result']['status']))
			$status = strtolower($responseParamList['transaction']['result']['status']);
			
			
		if(isset($responseParamList['transaction']['order']['amount'])&&$responseParamList['transaction']['order']['amount'])
		{
		 	$_SESSION['responseAmount']=$responseParamList['transaction']['order']['amount'];
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
			if($status=='success' || $status=='settled'){ //success
				$_SESSION['acquirer_response']=$message." - Success";
				$_SESSION['acquirer_status_code']=2;
			}
			elseif($status=='failed'){	//failed || timed_out
				
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


if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}

?>