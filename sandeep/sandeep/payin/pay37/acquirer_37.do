<?
$tr_upd_order=$apc_get;
$tr_upd_order['s30_count']=10;


if($acquirer==371){
		
		
	if(isset($post['bill_phone']) && !empty($post['bill_phone']) && (empty($post['upi_address'])) )
	{
		$post['upi_address']=$post['bill_phone'];
	}
		
	if(isset($post['upi_address_suffix'])&&$post['upi_address_suffix'] && (strpos($post['upi_address'],'@')===false) ) 
	{ 
		$post['upi_address']=$post['upi_address'].$post['upi_address_suffix'];
		
	}
	
	$tr_upd_order['upa']=$post['upi_address'];
	$payerVpa="7905278153@indusuat";
	$payerName	= $post['fullname'];	//payer fullname
		$mcc = '00';
	require_once 'collect.do';
	$req = json_decode($request,1);
	$url = $httpUrl;
	//print_r($req);
	if(isset($response_json)&&$response_json)
	{
		$response_param = json_decode($response_json,1);
		print_r($response_param);
		echo $custRefNo =$response_param['custRefNo'];
	}
	
	//print_r($rescollect);
	//exit;
	//echo $response;
	//exit;
	//print_r($rescollect);
	$status=((isset($response_param['status'])&&$response_param['status'])?$response_param['status']:'');
	//exit;


	//exit;
	//transfer all request information to another variable
	//	unset($request_data['upiId']);		//unset card number
	
	//$tr_upd_order['dataKey']	=$dataKey;
	$tr_upd_order['request']	=$req;
	$tr_upd_order['collectUrl']	=$url;
	$tr_upd_order['collectResponse'] =$response_param;
	$tr_upd_order['acquirer_ref'] =$transID;
	trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);

	$curl_values_arr['responseInfo']	=$tr_upd_order['collectResponse'];	//save response for curl request
	$curl_values_arr['browserOsInfo']=$browserOs;	//save browser information for curl request

	$_SESSION['acquirer_action']=1;		//set action HKIP for update trasaction via callback
	$_SESSION['curl_values']=@$curl_values_arr;	//set curl values into into $_SESSION

	//trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);
	
	if(isset($qp)&&$qp)
	{
		echo 'verify_response'.$responseCollect;exit;
	}
	
	//applied condition according to response status
		
	$_SESSION['acquirer_status_code']=1;
	$_SESSION['acquirer_response']=((isset($_SESSION['acquirer_response'])&&$_SESSION['acquirer_response'])?$_SESSION['acquirer_response']:'')." - Pending";
	$process_url=$trans_processing;
	###############
}
//exit;
//print_r($apc_get);
/*if($acquirer==371){
//require_once 'collect.do';
$payerVpa	= $post['upi_address'];	//$payerVpa  = 'reg7@indusuat';
		if(isset($post['bill_phone']) && !empty($post['bill_phone']) && (empty($post['upi_address'])) )
	{
		$post['upi_address']=$post['bill_phone'];
	}
		
	if(isset($post['upi_address_suffix'])&&$post['upi_address_suffix'] && (strpos($post['upi_address'],'@')===false) ) 
	{ 
		$post['upi_address']=$post['upi_address'].$post['upi_address_suffix'];
		
	}
	
	$tr_upd_order['upa']=$post['upi_address'];	//payer vpa for Test Env.
    echo  $payerVpa="7905278153@indusuat";
		$payerName	= $post['fullname'];	//payer fullname
		$mcc = '00';
 require_once 'collect.do';


if(isset($response_json)&&$response_json)
		{
			$response_param = json_decode($response_json,1);
			}
			//print_r($response_param);
			//print_r($Payload);
		 $status=((isset($response_param['status'])&&$response_param['status'])?$response_param['status']:'');
		
			$tr_upd_order['Payload']=$Payload;
		
			$tr_upd_order['response']=$response_param;
		    trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);
			
			$curl_values_arr['responseInfo']	=$tr_upd_order['response'];
			$curl_values_arr['browserOsInfo']	=$browserOs;
		
			$_SESSION['acquirer_action']=1;		//set action HKIP for update trasaction via callback
	        $_SESSION['curl_values']=@$curl_values_arr;
			
			if(isset($response_param['custRefNo'])&&$response_param['custRefNo'])
			{
			 $response_param['custRefNo'];
				$tr_upd_order['acquirer_ref']=$response_param['custRefNo'];
			}
			trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);
			
			
			//transactions_updates($_SESSION['tr_newid'], $tr_upd_order);*/
		
	/*	
		if(isset($qp)&&$qp)
	{
		echo 'verify_response'.$response_param;exit;
	}
	
	$_SESSION['acquirer_status_code']=1;
	$_SESSION['acquirer_response']=((isset($_SESSION['acquirer_response'])&&$_SESSION['acquirer_response'])?$_SESSION['acquirer_response']:'')." - Pending";
	$process_url=$trans_processing;
	
}*/


?>