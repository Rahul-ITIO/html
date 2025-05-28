<?
//status 84 Pythru
if(isset($data['ROOT'])&&$data['ROOT']) $root=$data['ROOT'];
else $root='../../';

//testing for email response 
//$data['status_in_email']=1;


$is_curl_on = true;
if(!isset($data['STATUS_ROOT'])){
	include($root.'config_db.do');
	include($data['Path'].'/payin/status_top'.$data['iex']);
}



/*
$apJson['MerchantId']=(isset($json_value['MerchantId'])?$json_value['MerchantId']:'');
$apJson['terminalId']	= (isset($json_value['terminalId'])?$json_value['terminalId']:'');
$apJson['subMerchantId']	= (isset($json_value['subMerchantId'])?$json_value['subMerchantId']:'');
*/

$apJson['MerchantId']=(isset($data['apJson']['MerchantId'])?$data['apJson']['MerchantId']:'');
$apJson['terminalId']=(isset($data['apJson']['terminalId'])?$data['apJson']['terminalId']:'');
$apJson['subMerchantId']=(isset($data['apJson']['subMerchantId'])?$data['apJson']['subMerchantId']:'');

if(!empty($transID))
{
	if($is_curl_on==true)
	{
		//if not found acquirer_status_url
		if(empty($acquirer_status_url)) $acquirer_status_url='https://merchantuat.timepayonline.com/evok/cm/v2/status';
		
		
	
	if($qp)
	{
		echo '<div type="button" class="btn btn-success my-2" style="background:#ac7d26;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
		
		echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
		echo "<br/>MerchantId=> ".$apJson['MerchantId'];
		echo "<br/>subMerchantId=> ".$apJson['subMerchantId'];
		echo "<br/>terminalId=> ".$apJson['terminalId'];
		echo "<br/>merchantTranId=> ".$transID;
		//echo "<br/>bank_mid=>".$bank_mid;

		echo '<br/><br/></div>';
	}
		

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
  CURLOPT_POSTFIELDS =>'{
  "merchantId": "'.$apJson['MerchantId'].'",
  "subMerchantId": "'.$apJson['subMerchantId'].'",
  "terminalId": "'.$apJson['terminalId'].'",
  "merchantTranId": "'.$transID.'"
}',
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/json'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
//echo "<br/><br/><==response==>".$response;

$res = json_decode($response,1);

//print_r($res);
//exit;

}
	
	
	
	if($qp)
	{
		echo '<div type="button" class="btn btn-success my-2" style="background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
		//echo "res=>"; print_r($res);
		
		echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
		echo "<br/>acquirer status=> ".$res['body']['status'];
		echo "<br/>acquirer message=> ".$res['body']['message'];
		
		
		echo "<br/><br/>res=> ".htmlentitiesf($res);
		echo '<br/><br/></div>';
	}
	

	$results = $res;
  
	//applied condition according to the status response for fail success and pending 
	if (isset($res) && count($res)>0)
	{
		$status = $res['body']['status'];
		
		if($qp){
			echo "<br/><br/><=status=>".$status;
		}

		if(isset($res['body']['message'])&&$res['body']['message']){
			$message	= $res['body']['message'];
		}else{
			$message	= $res['message'];
		}
		
		$_SESSION['acquirer_action']=1;
		$_SESSION['acquirer_response']=$message;
		$_SESSION['curl_values']=$res;

		if(isset($status) && !empty($status))
		{
			if(strtoupper($status)=='SUCCESS'){ //success
				$_SESSION['acquirer_response']=$message." - Success";
				$_SESSION['acquirer_status_code']=2;
			}
			elseif(strtoupper($status)=='FAILURE' || strtoupper($status)=='FAIL'){	//failed
				$_SESSION['acquirer_response']=$message." - Cancelled";
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
