<?

//status 46  
$data['NO_SALT']=true;

if(isset($data['ROOT'])&&$data['ROOT']) $root=$data['ROOT'];
else $root='../../';

if((isset($_REQUEST['customer_order_id'])&&$_REQUEST['customer_order_id']))
{	
	$customer_order_id=$_REQUEST['transID']=$_REQUEST['customer_order_id'];
}


$is_curl_on = true;

if((isset($_REQUEST['responseCode']))&&(!empty($_REQUEST['responseCode']))){
	//$_REQUEST['action']='webhook';
	$is_curl_on = false;
	$responseParamList=$_REQUEST;
	/*
	$data['ordersetExit']=1;
	$data['status_in_email']=1;
	$data['devEmail']='arun@itio.in';
	*/
	
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
			$acquirer_status_url="https://portal.finvert.io/api/get/transaction";
		
		
		$url = $acquirer_status_url;
		$key = $apc_get['apiKey'];
		
		if($qp)
		{
			echo '<div type="button" class="btn btn-success my-2" style="background: #fff2d4;color:#2c2c2c;padding:5px 10px;border-radius:2px;margin:10px auto;width:fit-content;display:block;max-width:99%;">';
	
			echo "<br/>acquirer_status_url=>".$acquirer_status_url;
			echo "<br/>key=>".$key; 
			echo "<br/>customer_order_id=>". $transID;
			
			echo '<br/><br/></div>';
		}
			
		
		$dataRequest = ['customer_order_id' => $transID];
		
		
		$request = json_encode($dataRequest);

		$curl = curl_init();
		curl_setopt($curl, CURLOPT_URL, $url);
		curl_setopt($curl, CURLOPT_POST, 1);
		curl_setopt($curl, CURLOPT_POSTFIELDS, $request);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($curl, CURLOPT_HTTPHEADER,[
			'Content-Type: application/json',
			'Authorization: Bearer ' .$key
		]);
		$response = curl_exec($curl);
		curl_close($curl);

		$responseParamList = json_decode($response,1);
		
		//print_r($responseParamList);
			
		
	}


	if($qp)
	{
		echo '<div type="button" class="btn btn-success my-2" style="background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
		
		echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
		echo "<br/>acquirer status [responseCode]=> ".@$responseParamList['responseCode'];
		echo "<br/>acquirer message [responseMessage] => ".@$responseParamList['responseMessage'];
		echo "<br/>acquirer amount ['data']['transaction']['amount'] => ".@$responseParamList['data']['transaction']['amount'];
		
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
			$responseParamList['responseCode']=$responseCode;
			$responseParamList['responseMessage']=jsonvaluef($response,'responseMessage');
			
		}
	
	
		$_SESSION['acquirer_action']=1;
		$_SESSION['acquirer_response']=$msg=$responseParamList['responseMessage'];
		//$_SESSION['acquirer_status_code']=$responseParamList['responseCode'];
		$_SESSION['curl_values']=@$responseParamList;
		
		if(isset($responseParamList['data']['transaction']['amount'])&&$responseParamList['data']['transaction']['amount'])
				$_SESSION['responseAmount']	= $responseParamList['data']['transaction']['amount'];
			
			$data_status= array(
				'merNotifyStatus'=>'1',
			);
			
		
		if($responseParamList['responseCode']=="1"){ //success
			$_SESSION['acquirer_status_code']=2;
			$status_completed=true;
			$_SESSION['acquirer_response']="Success";
			
			if(!isset($_SESSION['adm_login'])) echo json_encode($data_status);
		}
		elseif($responseParamList['responseCode']=="0"){ //failed or other
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