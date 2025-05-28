<?
// Dev Tech : 23-12-26  87 status binopay

$data['NO_SALT']=true;
$is_curl_on = true;


//if((isset($_REQUEST['order_id']))&&(!empty($_REQUEST['order_id']))) $_REQUEST['transID'] = $_REQUEST['order_id'];



// access status via callback - end

if(isset($data['ROOT'])&&$data['ROOT']) $root=$data['ROOT'];
else $root='../../';

if(!isset($data['STATUS_ROOT'])){
	include($root.'config_db.do');

	//webhook : 
	if(isset($_REQUEST['action'])&&$_REQUEST['action']=='webhook')
	{

			
			$responseParamList = @$_REQUEST;
			//$data['gateway_push_notify'] = $responseParamList['status'];
			/*
				{
					"action": "webhook",
					"result": "SUCCESS",
					"status": "PENDING",
					"order_id": "11920250410122854",
					"trans_id": "5ece9b28-1607-11f0-bdc2-deff67c2fa34",
					"hash": "aaa4ff37e0cf048bf94dc0d397376134",
					"trans_date": "2025-04-10 12:29:37",
					"amount": "11.99",
					"currency": "USD",
					"card": "411111****1111",
					"card_expiration_date": "12/2038"
				}
			*/
		
			if(isset($responseParamList['order_id'])&&isset($responseParamList['result'])&&@$responseParamList['result']=="SUCCESS") 
			{

				$transID_via_reference=rawurldecode($responseParamList['order_id']);
				
				if(@$qp)
				{
					echo "<br/><hr/><br/>responseParamList=><br/>";
					print_r($responseParamList);

					echo "<br/><br/>transID_via_reference=>".$transID_via_reference;
					echo "<br/><br/>status=>".$responseParamListstatus;
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

			if(empty($acquirer_status_url)||strtolower($acquirer_status_url)=='NA') $acquirer_status_url="https://pay.pesaway.com/api/v1/payment/status";

		##################################################################################
			
			// === Pesaway Test/Sandbox Credentials ===
			$merchant_key=@$apc_get['merchant_key']; //"4b0446ec-ff55-11ef-a7d4-36f1d24257a9";
			$password=@$apc_get['password']; // "db16ad9eb50d11e6de2f160dacf78537";

			
		##################################################################################

			$orderId = @$transID; // Replace with the order_id from SALE transaction

			if(isset($_GET['order_id'])) {
				$orderId = $_GET['order_id'];
			} 

			// ======== HASH GENERATION ========
			// Format: sha1(md5(order_id + password)) UPPERCASED
			$innerMd5 = md5(strtoupper($orderId . $password));
			$hash = sha1($innerMd5);

			// ======== REQUEST DATA ========
			$requestData = [
				'merchant_key' => $merchant_key,
				'order_id'     => $orderId,
				'hash'         => $hash
			];





			############################################
			if(@$qp)
			{
				echo "<br/><hr/><br/>url acquirer_status_url=>".$acquirer_status_url."<br/>";
				echo "<br/><hr/><br/>merchant_key=>".$merchant_key."<br/>";
				echo "<br/><hr/><br/>order_id=>".$orderId."<br/>";
				echo "<br/><hr/><br/>innerMd5=>".$innerMd5."<br/>";
				echo "<br/><hr/><br/>hash with sha1=>".$hash."<br/>";

				$postDataJsonEncode = json_encode($requestData);
				echo "<br/><hr/><br/>postDataJsonEncode=>".$postDataJsonEncode."<br/>";

			}


			// ======== CURL POST (JSON Format) ========
			$ch = curl_init($acquirer_status_url);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
			curl_setopt($ch, CURLOPT_POST, true);
			curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($requestData));
			curl_setopt($ch, CURLOPT_HTTPHEADER, [
				'Content-Type: application/json',
			]);
			curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
			curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
			curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
			curl_setopt($ch, CURLOPT_MAXREDIRS, 10);
			curl_setopt($ch, CURLOPT_TIMEOUT, 30); // Set timeout to 30 seconds
			curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 0); // Set connection timeout to 10 seconds
			curl_setopt($ch, CURLOPT_VERBOSE, true); // Enable verbose output for debugging
			curl_setopt($ch, CURLOPT_HEADER, 0); // Include headers in the output
			curl_setopt($ch, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_1); // Use HTTP/1.1

			$response = curl_exec($ch);
			$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
			$curlError = curl_error($ch);
			curl_close($ch);

		/*
			{
				"payment_id": "5ece9b28-1607-11f0-bdc2-deff67c2fa34",
				"date": "2025-04-10 12:28:55",
				"status": "pending",
				"order": {
					"number": "11920250410122854",
					"amount": "11.99",
					"currency": "USD",
					"description": "Dev Tech Test Payment"
				},
				"customer": {
					"name": "Dev Tech",
					"email": "doe@example.com"
				}
			}
			
			{
				"action": "webhook",
				"result": "SUCCESS",
				"status": "PENDING",
				"order_id": "11920250410122854",
				"trans_id": "5ece9b28-1607-11f0-bdc2-deff67c2fa34",
				"hash": "aaa4ff37e0cf048bf94dc0d397376134",
				"trans_date": "2025-04-10 12:29:37",
				"amount": "11.99",
				"currency": "USD",
				"card": "411111****1111",
				"card_expiration_date": "12/2038"
			}
		*/

		

		//echo $response;
		// Decode the JSON response to an array
		$responseParamList = json_decode($response, 1);

	}

	$results = @$responseParamList;
	/*
	['status']
	['status']
	['order']['amount']
	*/
	if(@$qp)
	{
		echo '<div type="button" class="btn btn-success my-2" style="word-wrap:break-word;background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
		//echo "res=>"; print_r($res);
		echo "<br/>mode=>".$apc_get['mode'];
		echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
		echo "<br/>hash=> ".$hash;

		echo "<br/><br/>acquirer status ['status']=> ".@$responseParamList['status'];
		echo "<br/>acquirer message ['status']=> ".@$responseParamList['status'];
		echo "<br/>acquirer responseAmount ['order']['amount']=> ".@$responseParamList['order']['amount'];
		
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
		if(@$responseParamList['status']) $message = @$responseParamList['status'];

		if($message=='Transaction not found'&&!empty($td['trans_response'])){
			$message = @$td['trans_response'];
		}
		

		if(@$qp) echo "<br/>acquirer message => ".@$message;

		$status = "";
		if(isset($responseParamList['status']))
			$status = strtoupper($responseParamList['status']);
			
			
		if(isset($responseParamList['order']['amount'])&&$responseParamList['order']['amount'])
		{
		 	$_SESSION['responseAmount']=$responseParamList['order']['amount'];
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
			if($status=='SUCCESS' || $status=='APPROVED'){ //success
				$_SESSION['acquirer_response']=$message." - Success";
				$_SESSION['acquirer_status_code']=2;
			}
			elseif(@$responseParamList['status']=='Transaction not found' || $status=='FAILED')
			//elseif(@$responseParamList['status']=='Transaction not found' )
			
			{	//failed || timed_out
				
				$_SESSION['acquirer_response']=$message;
				$_SESSION['acquirer_status_code']=23;
			}
			elseif($status=='DECLINED' ){	//failed || timed_out
				
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