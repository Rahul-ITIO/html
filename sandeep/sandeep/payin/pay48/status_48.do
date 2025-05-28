<?
//status 48  
$data['NO_SALT']=true;

if(isset($data['ROOT'])&&$data['ROOT']) $root=$data['ROOT'];
else $root='../../';

$is_curl_on = true;


if((isset($_REQUEST['txnid'])&&$_REQUEST['txnid']))
{	
	$customer_order_id=$_REQUEST['transID']=$_REQUEST['txnid'];
}

if(isset($_REQUEST['qp'])||isset($_REQUEST['pq'])||isset($_REQUEST['dtest']))
echo "<br/><br/>data=>".@$_REQUEST['data'].'<br/>';

if((isset($_REQUEST['status']))&&(!empty($_REQUEST['status'])))
{
	//$_REQUEST['action']='webhook';
	//
	$responseParamList['msg']=$_REQUEST;
	
	if((isset($_REQUEST['action'])&&$_REQUEST['action']=='webhook')) {
		$is_curl_on = false;
	}
	
	if(isset($_REQUEST['data']))
	{
		$data_dec=json_decode($_REQUEST['data'],1);
		if(isset($data_dec)&&is_array($data_dec))
		{
			$responseParamList=$data_dec;
			// echo "<br/><br/>data_dec2=>";print_r($data_dec);
		}
	}
	if(isset($responseParamList['settled_transactions'][0]['txnid'])) {
		//$is_curl_on = false;
		$customer_order_id=$_REQUEST['transID']=@$responseParamList['settled_transactions'][0]['txnid'];
		$webhook_status=@$_REQUEST['status'];
	}
	//$data['transIDExit']=1;
	//$data['status_in_email']=1;
}
if(isset($_REQUEST['qp'])||isset($_REQUEST['pq'])||isset($_REQUEST['dtest']))
{
	echo "<br/><br/>webhook_status=>";print_r(@$webhook_status);
	echo "<br/><br/>responseParamList=>";print_r(@$responseParamList);
	echo "<br/><br/>transID=>";print_r(@$_REQUEST['transID']);
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

	if($is_curl_on==true&&isset($transID))	//if check status direct via admin or realtime response
	{
		//if not found acquirer_status_url
		if(empty($acquirer_status_url)) 
			$acquirer_status_url="https://portal.finvert.io/api/get/transaction";
		
		
		$url = $acquirer_status_url;
		$key = @$apc_get['key'];
		$salt = @$apc_get['salt'];
		$email = @$td['bill_email'];
		$phone = @$td['bill_phone'];
		$amount = @$td['bill_amt'];
		
		if(@$qp)
		{
			echo '<div type="button" class="btn btn-success my-2" style="background: #fff2d4;color:#2c2c2c;padding:5px 10px;border-radius:2px;margin:10px auto;width:fit-content;display:block;max-width:99%;">';
	
			echo "<br/>acquirer_status_url=>".$acquirer_status_url;
			echo "<br/>key=>".$key; 
			echo "<br/>customer_order_id=>". $transID;
			
			echo '<br/><br/></div>';
		}
		
		$postData['txnid']=@$transID;
		$postData['key'] =  $key;
		$postData['amount'] =number_format(@$td['bill_amt'],1);
		$postData['email'] = $email;
		$postData['phone'] =  $phone;
		$hashSequence = $postData['key'] . "|" . $postData['txnid']. "|" . $postData['amount'] . "|" . $postData['email'] . "|" .$postData['phone'] . "|" . $salt;
		$hash = hash('sha512', $hashSequence);
		$postData['hash']=$hash;

		//exit;
		

		$request = http_build_query($postData);

/*
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

		if($response) $responseParamList = json_decode($response,1);
		
		print_r($responseParamList);

			*/
		
		$curl = curl_init();
		curl_setopt_array($curl, array(
		  CURLOPT_URL => 'https://dashboard.easebuzz.in/transaction/v1/retrieve',
		  CURLOPT_RETURNTRANSFER => true,
		  CURLOPT_ENCODING => '',
		  CURLOPT_MAXREDIRS => 10,
		  CURLOPT_TIMEOUT => 0,
		  CURLOPT_FOLLOWLOCATION => true,
		  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		  CURLOPT_CUSTOMREQUEST => 'POST',
		  CURLOPT_POSTFIELDS => $request,
		  CURLOPT_HTTPHEADER => array(
			'Content-Type: application/x-www-form-urlencoded'
		  ),
		));

		$response = curl_exec($curl);

		curl_close($curl);
				
		$responseParamList = json_decode($response,1);
		//print_r($responseParamList);	
		//exit;
		
		if(isset($responseParamList['msg']['status']))
			$staus = @$responseParamList['msg']['status'];
		if(isset($responseParamList['msg']['error']))
			$msg = @$responseParamList['msg']['error'];
	}


	if(@$qp)
	{
		echo '<div type="button" class="btn btn-success my-2" style="background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
		
		echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
		if(isset($staus))
		echo "<br/>acquirer status ['msg']['status']=> ".$staus;
		//echo "<br/>acquirer message [responseMessage] => ". $msg;
		if(isset($responseParamList['msg']['amount']))
		echo "<br/>acquirer amount ['msg']['amount'] => ".@$responseParamList['msg']['amount'];
		
		//echo "<br/>response_json=> ".@$response_json;
		echo "<br/><br/>responseParamList=> "; print_r($responseParamList);
		
		echo "<br/><br/>request key=> "; print_r($request);
		echo "<br/><br/>hashSequence key=> "; print_r($hashSequence);
		
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
		echo "<hr/>response=>".$response;
		echo "<hr/>responseParamList=>";print_r($responseParamList );
		//exit;
	}
	
	if(isset($responseParamList))
	{

		if($data['pq']&&isset($staus))
		{
			$responseParamList['status']=$staus;
			$responseParamList['msg']['error']=jsonvaluef($response,'responseMessage');
			
		}
	
	
		$_SESSION['acquirer_action']=1;
		if(isset($responseParamList['msg']['error']))
		$_SESSION['acquirer_response']=$msg=$responseParamList['msg']['error'];
		//$_SESSION['acquirer_status_code']=$responseParamList['responseCode'];
		$_SESSION['curl_values']=@$responseParamList;
		
		if(isset($responseParamList['msg']['amount'])&&$responseParamList['msg']['amount'])
				$_SESSION['responseAmount']	= $responseParamList['msg']['amount'];
			
			$data_status= array(
				'merNotifyStatus'=>'1',
			);
			
		
		if(isset($responseParamList['msg']['status'])&&$responseParamList['msg']['status']=="success"){ //success
			$_SESSION['acquirer_status_code']=2;
			$status_completed=true;
			$_SESSION['acquirer_response']="Success";
			
			if(!isset($_SESSION['adm_login'])) echo json_encode($data_status);
		}
		elseif(isset($responseParamList['msg']['status'])&&($responseParamList['msg']['status']=="failed" || $responseParamList['msg']['status']=="failure")){ //failed or other
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