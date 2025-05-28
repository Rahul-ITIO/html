<?
//echo "abcd";
  echo $token=$_GET['token'];
$data['NO_SALT']=true;

if(isset($data['ROOT'])&&$data['ROOT']) $root=$data['ROOT'];
else $root='../../';


$is_curl_on = true;

if((isset($_REQUEST['status']))&&(!empty($_REQUEST['status']))){
	//$_REQUEST['action']='webhook';
	$is_curl_on = false;
	$responseParamList=$_REQUEST;
	
	$data['ordersetExit']=1;
	$data['status_in_email']=1;
	$data['devEmail']='arun@bigit.io';
	
}

//print_r($responseParamList);
			
if(!isset($data['STATUS_ROOT'])){
	include($root.'config_db.do');
	include($data['Path'].'/payin/status_top'.$data['iex']);
}

#####	TEMP* for Response check as testing	#########
if(!isset($_SESSION['adm_login']))
{
	//include($data['Path'].'/payin/res_insert'.$data['iex']);
}


############################################

	if($is_curl_on==true)	//if check status direct via admin or realtime response
	{
		//if not found acquirer_status_url
		if(empty($acquirer_status_url)) 
			$acquirer_status_url="https://zookwallet.com/en/request/status";
		
		
		 $url = $acquirer_status_url;
		 $merchant_key = $apc_get['merchant_key'];
		
		if($qp)
		{
			echo '<div type="button" class="btn btn-success my-2" style="background: #fff2d4;color:#2c2c2c;padding:5px 10px;border-radius:2px;margin:10px auto;width:fit-content;display:block;max-width:99%;">';
	
			echo "<br/>acquirer_status_url=>".$acquirer_status_url;
			echo "<br/>key=>".$merchant_key; 
			echo "<br/>customer_order_id=>". $transID;
			
			echo '<br/><br/></div>';
		}
			
		
		$postData = array(
    'merchant_key'=> $merchant_key,
    'token'=> $token
    );
//Print_r($postData);
		
		
		
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $url );
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, $postData);

$responseParamList = json_decode(curl_exec($ch),true);
//echo $response;

curl_close($ch);
 print_r($responseParamList);
exit;
		
		//print_r($responseParamList);
			
		
	}


	if($qp)
	{
		echo '<div type="button" class="btn btn-success my-2" style="background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
		
		echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
		echo "<br/>acquirer status [responseCode]=> ".@$responseParamList['status'];
		echo "<br/>acquirer message [responseMessage] => ".@$responseParamList['success_message'];
		
		
		//echo "<br/>response_json=> ".@$response_json;
		echo "<br/><br/>responseParamList=> "; print_r($responseParamList);
		
		//echo "<br/><br/>responseParamList=> ".htmlentitiesf(@$responseParamList);
		echo '<br/><br/></div>';
	}
		
		
	//exit;

	if(is_array($responseParamList))
	$results= $responseParamList;
		
	else{
		$_SESSION['acquirer_response']="Pending";
		$results['Error']="Request too often! Try again later.";
	}	
	
	if($data['pq'])
	{
		echo "<hr/>uid=>".$uid;
		echo "<hr/>response=>".$response;
		echo "<hr/>responseParamList=>";print_r($responseParamList );
		//exit;
	}
	
	if(isset($responseParamList))
	{

		if($data['pq']&&$responseCode)
		{
			$responseParamList['status']=$responseCode;
			$responseParamList['success_message']=jsonvaluef($response,'success_message');
			
		}
	
	
		$_SESSION['acquirer_action']=1;
		$_SESSION['acquirer_response']=$msg=$responseParamList['success_message'];
		//$_SESSION['acquirer_status_code']=$responseParamList['responseCode'];
		$_SESSION['curl_values']=@$responseParamList;
		
		
			
		
		if($responseParamList['status']=="1"){ //success
			$_SESSION['acquirer_status_code']=2;
			$status_completed=true;
			$_SESSION['acquirer_response']="Success";
			
			if(!isset($_SESSION['adm_login'])) echo json_encode($data_status);
		}
		elseif($responseParamList['status']=="0"){ //failed or other
			$_SESSION['acquirer_response']=@$msg." - Cancelled";
			$_SESSION['acquirer_status_code']=-1;
		}
		else{ //pending
			$_SESSION['acquirer_response']=@$msg." - Pending";
			$_SESSION['acquirer_status_code']=1;
		}
		
	}
	
if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}
?>
