<?
//status 42 kapopay
if(isset($data['ROOT'])&&$data['ROOT']) $root=$data['ROOT'];
else $root='../../';



$is_curl_on = true;
if(!isset($data['STATUS_ROOT'])){
	include($root.'config_db.do');
	/*$str='{
	  "amount": "2.0",
	  "utr": "315211024304",
	  "orderId": "RAI5949295692288245",
	  "name": "Deepti  Tyagi",
	  "txnId": "1113689154819981312",
	  "upi": "9568315028@paytm",
	  "status": "SUCCESS"
	}';*/
	$str = file_get_contents("php://input");
	$responseGet = $res = json_decode($str,true);
	
	$orderId=@$responseGet['TransactionId'];
	 
	if(isset($responseGet['PaymentStatus'])&&trim($responseGet['PaymentStatus'])&&isset($responseGet['TransactionId'])&&trim($responseGet['TransactionId'])){
		$responseParamList = $responseGet;
		$is_curl_on = false;
	}
	//exit;
	if(isset($orderId)&&@$orderId){
		$_REQUEST['transID'] = @$orderId;
		$gateway_push_notify['transID']=$_REQUEST['transID'];	
		$data['gateway_push_notify']=$responseGet;
		
	}

	include($data['Path'].'/payin/status_top'.$data['iex']);
}

#####	TEMP* for Response check as testing	#########
//include($data['Path'].'/payin/res_insert'.$data['iex']);

//exit;

$apJson['ShopId']=(isset($data['apJson']['ShopId'])?@$data['apJson']['ShopId']:'');
$apJson['Pass']=(isset($data['apJson']['Pass'])?@$data['apJson']['Pass']:'');
$apJson['AccountId']=(isset($data['apJson']['AccountId'])?@$data['apJson']['AccountId']:'');
$apJson['Key']=(isset($data['apJson']['Key'])?@$data['apJson']['Key']:'');
$Conf = @$json_value['ConfirmationNumber'];

if(!empty($transID))
{
	if($is_curl_on==true)
	{
		//if not found acquirer_status_url
		if(empty($acquirer_status_url)) $acquirer_status_url='https://sandbox.kapopay.com/process/status/';
		
		
		
		if($qp)
		{
			echo '<div type="button" class="btn btn-success my-2" style="background:#ac7d26;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;word-break:break-all;">';
			
			echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
			echo "<br/>MerchantId=> ".$apJson['ShopId'];
			echo "<br/>subMerchantId=> ".$apJson['Pass'];
			echo "<br/>terminalId=> ".$apJson['AccountId'];
			echo "<br/>key=> ".$apJson['Key'];
			echo "<br/>ConfirmationNumber=> ".$Conf;
			echo "<br/>merchantTranId=> ".$transID;
			//echo "<br/>bank_mid=>".$bank_mid;

			echo '<br/><br/></div>';
		}
		######################################

//1st step is for token generate
 $ShopId = $apJson['ShopId'];
 $password = $apJson['Pass'];
 $AccountId = $apJson['AccountId'];
 $key = $apJson['Key'];
 $confNumber = $Conf;
 $orderId = $transID;
 $signature = hash("sha256", $orderId.$key);	
 $postData=
'
{
   "Credentials":{
	"AccountId": "' . $AccountId . '",
    "Signature": "'. $signature .'"
   
},
   "TransactionId": "' . $orderId . '",
   "ConfirmationNumber":"' . $confNumber . '"
}
';	

		$auth= base64_encode("$ShopId:$password");

		  $curl = curl_init();
		  curl_setopt_array($curl, array(
		  CURLOPT_URL =>$acquirer_status_url,
		  CURLOPT_RETURNTRANSFER => true,
		  CURLOPT_FOLLOWLOCATION  => false,  
		  CURLOPT_ENCODING => "",
		  CURLOPT_MAXREDIRS => 10,
		  CURLOPT_TIMEOUT => 30,
		  CURLOPT_CUSTOMREQUEST => "POST",
		  CURLOPT_POSTFIELDS => $postData,
		  CURLOPT_HTTPHEADER => array(
			"accept: application/json",
			"authorization: Basic $auth",
			"content-type: application/json"
		  ),
		));

		$response = curl_exec($curl);
		$err = curl_error($curl);  
		curl_close($curl);

		//Convert json to Array
		$responseParamList = json_decode($response,true);

	}

					
#######################################
	if($qp)
	{
		echo '<div type="button" class="btn btn-success my-2" style="background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
		
		echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
		echo "<br/>acquirer status [responseCode]=> ".@$responseParamList['responseCode'];
		echo "<br/>acquirer message [responseMessage] => ".@$responseParamList['responseMessage'];
		echo "<br/>acquirer amount ['TotalAmount'] => ".@$responseParamList['TotalAmount'];
		echo "<br/>acquirer from amount ['TotalAmount'] => ".@$responseParamList['TotalAmount']/100;
		
		//echo "<br/>response_json=> ".@$response_json;
		echo "<br/><br/>responseParamList=> "; print_r($responseParamList);
		
		//echo "<br/><br/>responseParamList=> ".htmlentitiesf(@$responseParamList);
		echo '<br/><br/></div>';
		
	}
	
	$results = $responseParamList;
	  
  //exit;
	//applied condition according to the status response for fail success and pending 
	if(isset($results)&&count($results)>0)
	{
		
		$status = $responseParamList['PaymentStatus'];
		$message = $responseParamList['Description'];
		
		if($qp){
			echo "<br/><br/><=status=>".$status;
		}

		$_SESSION['acquirer_action']=1;
		$_SESSION['acquirer_response']=$message;
		$_SESSION['curl_values']=$results;
		
		
		if(isset($responseParamList['amount'])&&$responseParamList['amount'])
				$_SESSION['responseAmount']	= $responseParamList['amount']/100;

		if(isset($responseParamList['TotalAmount'])&&$responseParamList['TotalAmount'])
				$_SESSION['responseAmount']	= $responseParamList['TotalAmount']/100;

		if(isset($status) && !empty($status))
		{
			if( ( $status=='SUCCESS' || $status=='APPROVED'  ) && $responseParamList['Code']==1001){ //success
				$_SESSION['acquirer_response']=$message." - Success";
				$_SESSION['acquirer_status_code']=2;
			}
			elseif($status=='DECLINED' && $responseParamList['Code']==3020){	//failed
				$_SESSION['acquirer_response']=$message." - Cancelled";
				$_SESSION['acquirer_status_code']=-1;
			}
			else{ //pending
				$_SESSION['acquirer_response']=$message." - Pending";
				$_SESSION['acquirer_status_code']=1;
				$status_completed=false;
				
				/*
				
				if((isset($_REQUEST['actionurl']))&&(!empty($_REQUEST['actionurl']))){
					$_SESSION['acquirer_response']=$_REQUEST['actionurl']." Pending or Error";
				}
						
						
					include($data['Path'].'/payin/status_expired'.$data['iex']);
				//	exit;
						
					$data_tdate=date('YmdHis', strtotime($td['tdate']));
					$current_date_1h=date('YmdHis', strtotime("-1 hours"));
					if(($data_tdate<$current_date_1h)&&($data['localhosts']==false)){
						$_SESSION['acquirer_status_code']=-1;
						$_SESSION['acquirer_response']=$message." - Cancelled"; 
					}
					
					*/
					
				}
		}
	}
	/*
	elseif(!isset($_SESSION['acquirer_status_code']) || empty($_SESSION['acquirer_status_code']))
	{
		$data_tdate=date('YmdHis', strtotime($td['tdate']));
		$current_date_2h=date('YmdHis', strtotime("-2 hours"));
		if(($data_tdate<$current_date_2h)){
			$_SESSION['acquirer_status_code']=-1;
			$_SESSION['acquirer_response']=" - Cancelled";
			include($data['Path'].'/payin/status_expired'.$data['iex']); 
		}
	}
	*/
}


#######################################################

if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}

?>