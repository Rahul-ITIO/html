<?
//status 12

$is_curl_on=true;



if(isset($_REQUEST['ac_order_id'])){
	$_REQUEST['transID']=$_REQUEST['ac_order_id'];
}
elseif(isset($_REQUEST['orderId'])){
	$_REQUEST['transID']=$_REQUEST['orderId'];
}

if(!isset($data['STATUS_ROOT'])){
	include('../../config_db.do');

	//webhook 
	if(isset($_REQUEST['action'])&&@$_REQUEST['action']=='webhook')
	{
		if(isset($_REQUEST['ac_amount'])){
			$responseParamList['transactionAmount']=$_REQUEST['ac_amount'];
		}
		
		if(isset($_REQUEST['ac_transaction_status'])){

			$is_curl_on=false;

			$responseParamList['transactionStatus']=$_REQUEST['ac_transaction_status'];
		}

		/*
		via _POST & _REQUEST
		{
			"actionCheck": "status",
			"ac_src_wallet": "TDqSquXBgUCLYvYC4XZgrprLK589dkhSCf",
			"ac_dest_wallet": "U934138677037",
			"ac_amount": "10.50",
			"ac_merchant_amount": "12.00",
			"ac_merchant_currency": "USD",
			"ac_fee": "1.50",
			"ac_buyer_amount_without_commission": "10.50",
			"ac_buyer_amount_with_commission": "12.00",
			"ac_buyer_currency": "USD",
			"ac_transfer": "b68c08e6-afed-489e-acff-1be64741bea0",
			"ac_sci_name": "digi51_USDT_SCI_B",
			"ac_start_date": "2024-06-05 07:48:31",
			"ac_order_id": "122170728",
			"ac_ps": "USD_TETHER",
			"ac_transaction_status": "COMPLETED",
			"ac_comments": "122170728",
			"ac_hash": "4f8a7ff83b887fa6e386d726d06ddfa936169a7203b54dba3a562cadfb9ab8b2"
		}

		*/
		
	}

	include($data['Path'].'/payin/status_top'.$data['iex']);
}

$txn_id			= $td['acquirer_ref'];


if(!empty($transID))
{

	//if(empty($acquirer_status_url)) $acquirer_status_url = "https://api.flutterwave.com/v3/transactions";
	
	
	if($qp)
	{
		echo '<div type="button" class="btn btn-success my-2" style="background: #fff2d4;color:#2c2c2c;padding:5px 10px;border-radius:2px;margin:10px auto;width:fit-content;display:block;max-width:99%;">';

		echo "<br/>acquirer_status_url=>".@$acquirer_status_url;
		
		
		echo "<br/>sci_name=>".@$apc_get['sci_name']; 
		echo "<br/>sign_key=>".@$apc_get['sign_key']; 
		echo "<br/>account_email=>".@$apc_get['account_email']; 
		
		echo "<hr/><br/>api_name=>".@$apc_get['api_name']; 
		echo "<br/>api_pass=>".@$apc_get['api_pass']; 
		
		echo '<br/><br/></div>';
	}
		
	/*
	if($is_curl_on==true)	//if check status direct via admin or realtime response
	{
			
		ini_set('max_execution_time', 0);
		require_once("MerchantWebService.php");
		$merchantWebService = new MerchantWebService();

		$arg0 = new authDTO();
		
		include('config_adv.php');

		

		$arg1 = new paymentOrderRequest();
		//$arg1->sciName = "website scI adv";
		$arg1->sciName = $apc_get['sci_name'];
		$arg1->orderId = $transID;

		$findPaymentByOrderId = new findPaymentByOrderId();
		$findPaymentByOrderId->arg0 = $arg0;
		$findPaymentByOrderId->arg1 = $arg1;


		$findPaymentByOrderIdResponse = $merchantWebService->findPaymentByOrderId($findPaymentByOrderId);
		$results2=($findPaymentByOrderIdResponse->return);
			
		$status=$results2->cryptoCurrencyInvoiceStatus;
		$paymentStatus=$results2->paymentStatus;
		$transactionStatus=$results2->transactionStatus;
		$transactionAmount=$results2->transactionAmount;	
		$transactionCurrency=$results2->transactionCurrency;	
		
		 $results = $responseParamList =  (array) $results2;
		
		 $message = $status;
		
		try {
			
			if($qp)
			{
				echo "<hr/>cryptoCurrencyInvoiceStatus==>".$results2->cryptoCurrencyInvoiceStatus; echo "<hr/>paymentStatus==>".$results2->paymentStatus; echo "<hr/>results2==>".json_encode($results2);
				
				 
			}
			
		} catch (Exception $e) {
			$message =$e->getMessage();
			$message.=$e->getTraceAsString();
			//echo "ERROR MESSAGE => " . $e->getMessage() . "<br/>"; echo $e->getTraceAsString();
		}

		
	}
	
	*/
	$push_req_arr=[];
	//$push_req_arr['action']='json';
	//$push_req_arr['action']='validate';
	$push_req_arr['transID']=$transID;

	if(!empty($acquirer_status_url))
	{
		if(strpos($acquirer_status_url,'?')!==false){
			$acquirer_status_url=$acquirer_status_url."&".http_build_query($push_req_arr);
		}else{
			$acquirer_status_url=$acquirer_status_url."?".http_build_query($push_req_arr);
		}

		$acquirer_status_url=str_replace(" ","+",$acquirer_status_url);
	}


	if($is_curl_on)
	{
		$curl = curl_init();
		curl_setopt_array($curl, [
			CURLOPT_URL => $acquirer_status_url,
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_ENCODING => "",
			CURLOPT_MAXREDIRS => 10,
			CURLOPT_SSL_VERIFYPEER => 0,
			CURLOPT_SSL_VERIFYHOST => 0,
			CURLOPT_HEADER => 0,
			CURLOPT_TIMEOUT => 30,
			CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			CURLOPT_CUSTOMREQUEST => 'GET',
			CURLOPT_POSTFIELDS => json_encode($post_data),
		]);

		$response = curl_exec($curl);	
		$http_status	= curl_getinfo($curl, CURLINFO_HTTP_CODE);
		$curl_errno		= curl_errno($curl);
		curl_close($curl);

		if($qp)
		{
			echo "<br/><br/>post_data=>";
			print_r($post_data);
			echo "<br/>acquirer_status_url=>".$acquirer_status_url;
			echo "<br/>response=>".$response;
		}
		if($http_status==503 || $http_status==500 || $http_status==403 || $http_status==400 || $http_status==404) {	//transaction stay as PENDING if received any one of the above error
			$err_msg = "HTTP Status == {$http_status}.";
			
			if($curl_errno) echo "<br/>Curl Errno returned $curl_errno.<br/>";
			
			$_SESSION['acquirer_response']		=$err_msg." - Pending";
			$_SESSION['acquirer_status_code']=1;
			$status_completed=false;
			
			//exit;
		}
		elseif($curl_errno){
			echo '<br/>Request Error: '.$curl_errno.' - ' . curl_error($handle);
			exit;
		}

		$responseParamList = jsondecode($response,1,1);	// covert response from json to array
	}

	$results = @$responseParamList;

	$transactionStatus=$message='';
	if(isset($responseParamList['transactionStatus'])&&trim($responseParamList['transactionStatus'])) 
		$transactionStatus=$message=$responseParamList['transactionStatus'];
		
	
		
	$transactionAmount='';
	if(isset($responseParamList['transactionAmount'])&&trim($responseParamList['transactionAmount'])) 
		$transactionAmount=$_SESSION['bank_processing_amount']=$responseParamList['transactionAmount'];
		
	
	
	//check amount - 1.50 via USDT and USDC 
/*
	if(in_array($acquirer,["122","129"])&&isset($_SESSION['bank_processing_amount'])&&$_SESSION['bank_processing_amount']&&$_SESSION['bank_processing_amount']>1.50&&isset($transactionAmount)&&!empty($transactionAmount)) 
	{	
		if($qp) echo "<br/>bank_processing_amount=> ".@$_SESSION['bank_processing_amount'];
		$_SESSION['bank_processing_amount']=$_SESSION['bank_processing_amount']-1.50;
		if($qp) echo "<br/>bank_processing_amount - 1.50=> ".@$_SESSION['bank_processing_amount'];
	}
*/

	$transactionCurrency='';
	if(isset($responseParamList['transactionCurrency'])&&trim($responseParamList['transactionCurrency'])) 
		$transactionCurrency=$responseParamList['transactionCurrency'];

	$paymentStatus='';
	if(isset($responseParamList['paymentStatus'])&&trim($responseParamList['paymentStatus'])) 
		$paymentStatus=$responseParamList['paymentStatus'];

	if($qp)
		{
			echo '<div type="button" class="btn btn-success my-2" style="background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
			//echo "res=>"; print_r($res);
			
			echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
			echo "<br/>acquirer status=> ".@$responseParamList['cryptoCurrencyInvoiceStatus'];
			echo "<br/>acquirer message=> ".@$responseParamList['paymentStatus'];
			
			//echo "<br/>response_json=> ".@$response_json;
			echo "<br/><br/>responseParamList=> "; print_r($responseParamList);
			
			//echo "<br/><br/>res=> ".htmlentitiesf(@$responseParamList);
			echo '<br/><br/></div>';
		}
		

	if($qp)
	{
		//exit;
	}
	
	


	if (@$responseParamList['status']=='error') {
		//var_dump($responseParamList);
	}
	//else 
	{
		$_SESSION['acquirer_action']=1;
		$_SESSION['acquirer_transaction_id']=$results2->transactionId;
		$_SESSION['acquirer_descriptor']=@$acquirer_descriptor;
		
		if($transactionStatus=="COMPLETED"||$transactionStatus=="CONFIRMED"||$status=="PAYMENT_RECEIVED")
		{ // //success
			$_SESSION['acquirer_response']=$message." Success";
			$_SESSION['acquirer_status_code']=2;
			
			//responseAmount
			if(isset($transactionAmount)&&!empty($transactionAmount))
				$_SESSION['responseAmount']	= $transactionAmount;
			
			
			/*
			if(!empty($transactionAmount))
			{
				if(strtoupper($transactionCurrency)=='BTC')
				{
					$t_amt = $transactionAmount;
					$p_amt = $ac_amount;
				}
				else
				{
					$d_amt = $transactionAmount-$ac_amount;
					
					$t_amt = round($transactionAmount);
					$p_amt = round($ac_amount);
					
					if($d_amt!=0) $_SESSION['acquirer_response'].= " (Diff. $d_amt)";
				}
				if(trim($t_amt)!=trim($p_amt) || trim($transactionCurrency)!=trim($ac_currency))
				{
					$_SESSION['acquirer_response']=$message." Under Pending - Reason: Transaction Amount: $ac_currency $ac_amount while received amount: $transactionCurrency $transactionAmount";
					$status_completed=false;
					
					$_SESSION['acquirer_status_code']=1;
				}
			}
			*/
		}
		elseif($transactionStatus=="CANCELED"||$status=="EXPIRED"){	//failed 
			$_SESSION['acquirer_response']=$message."Cancelled";
			$_SESSION['acquirer_status_code']=-1;
		}
		else{ //pending
			$_SESSION['acquirer_response']=$message."Pending";
			$status_completed=false;
			$_SESSION['acquirer_status_code']=1;
		}
	}
}

//cmn
//$_REQUEST['action']='html';

if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}

?>