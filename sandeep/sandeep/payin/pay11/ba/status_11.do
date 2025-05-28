<?php
//print_r($td);
if(isset($data['ROOT'])&&$data['ROOT']) $root=$data['ROOT'];
else $root='../../';

//testing for email response 
//$data['status_in_email']=1;
if(!isset($data['STATUS_ROOT'])){
	include($root.'config_db.do');
	include($data['Path'].'/payin/status_top'.$data['iex']);
}

include('function_11'.$data['iex']);




 $txn_id			= $td['acquirer_ref'];
  $transaction_id = $td['transID'];
$apJson['apikey']=(isset($data['apJson']['apikey'])?$data['apJson']['apikey']:'');
$apJson['secretkey']=(isset($data['apJson']['secretkey'])?$data['apJson']['secretkey']:'');

 //$apJson['apikey']=(isset($data['apikey']['apikey'])?$data['apikey']['apikey']:'');
 //$apJson['secretkey']=(isset($data['secretkey']['secretkey'])?$data['secretkey']['secretkey']:'');
//print_r($apJson);
//echo "abcd";

if(!empty($transID))
{
	
		//if not found acquirer_status_url
		if(empty($acquirer_status_url)) $acquirer_status_url='https://bpay.binanceapi.com/binancepay/openpayin/v2/order/query';
		
		
	
	if($qp)
	{
		echo '<div type="button" class="btn btn-success my-2" style="background:#ac7d26;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
		
		echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
		echo "<br/>secretkey=> ".$apJson['secretkey'];
		//echo "<br/>bank_mid=>".$bank_mid;

		echo '<br/><br/></div>';
	}
	$timestamp = time()*1000;
   $binancePayNonce = generateRandomString();
   $postData['prepayId']			= $txn_id;
	$postData['merchantTradeNo']	= $transaction_id;
	$payload = (string)$timestamp."\n".$binancePayNonce."\n".json_encode($postData)."\n";
	
	$signature = hash_hmac('sha512', $payload, $apJson['secretkey']);
	$signature = strtoupper($signature);
	$headers = array(
	"Content-Type: application/json", 
	"BinancePay-Timestamp: ".$timestamp, 
	"BinancePay-Nonce: ".$binancePayNonce, 
	"BinancePay-Certificate-SN: ".$apJson['apikey'], 
	"BinancePay-Signature: ".$signature
	);
	//print_r($headers);
	//exit;
	$curl = curl_init();
 curl_setopt_array($curl, array(
  CURLOPT_URL => $acquirer_status_url,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_HEADER => 0,
  CURLOPT_SSL_VERIFYPEER => 0,
  CURLOPT_SSL_VERIFYHOST => 0,
  CURLOPT_POSTFIELDS =>json_encode($postData),
  CURLOPT_HTTPHEADER => $headers,
));

$response = curl_exec($curl);

curl_close($curl);
//echo "<br/><br/><==response==>".$response;

$res = json_decode($response,1);

//print_r($res);



	
	
	
	if($qp)
	{
		echo '<div type="button" class="btn btn-success my-2" style="background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
		//echo "res=>"; print_r($res);
		
		echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
		echo "<br/>acquirer status=> ".$res['status'];
		echo "<br/>acquirer code=> ".$res['code'];
	}
	

	$results = $res;
  
	//applied condition according to the status response for fail success and pending 
	if (isset($res) && count($res)>0)
	{
		$status = $res['status'];
		
		if($qp){
			echo "<br/><br/><=status=>".$status;
		}

		
		
		$_SESSION['acquirer_action']=1;
		//$_SESSION['acquirer_response']=$message;
		$_SESSION['curl_values']=$res;

		if(isset($status) && !empty($status))
		{
			if(strtoupper($status)=='SUCCESS'){ //success
				$_SESSION['acquirer_response']=" - Success";
				$_SESSION['acquirer_status_code']=2;
			}
			elseif(strtoupper($status)=='FAIL' || strtoupper($status)=='FAIL'){	//failed
				$_SESSION['acquirer_response']=" - Cancelled";
				$_SESSION['acquirer_status_code']=-1;
			}
			else{ //pending
				$_SESSION['acquirer_response']=$message." - Pending";
				$status_completed=false;
				$_SESSION['acquirer_status_code']=1;
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
			}
		}
	}
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
}

#######################################################

if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}


?>