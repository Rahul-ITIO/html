<?
//status 12

$is_curl_on=true;

if(isset($_REQUEST['orderId'])){
	$_REQUEST['transID']=$_REQUEST['orderId'];
}

if(!isset($data['STATUS_ROOT'])){
	include('../../config_db.do');
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
		
		if($transactionStatus=="COMPLETED"||$transactionStatus=="CONFIRMED"||$status=="PAYMENT_RECEIVED"){ // //success
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
if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}

?>