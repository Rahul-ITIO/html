<?
// Dev Tech : 24-03-27  102 - mastercard  Acquirer 

if($_SESSION['b_'.$acquirer]['acquirer_prod_mode']==2)
{
	

}

if($data['localhosts']==true) 
{
	$webhookhandler_url='https://aws-cc-uat.web1.one/responseDataList/?urlaction=notify_mastercard';

}

	//{"live":{"merchant_id":"GLADCORIGKEN","api_password_key":"4d3f8e07b2c625d779b81c678086cc1d"},"test":{"merchant_id":"GLADCORIGKEN","api_password_key":"4d3f8e07b2c625d779b81c678086cc1d"}}

	############################################################

	$merchant_id=@$apc_get['merchant_id'];
	
	$postRequest = array(
		"apiOperation" => "INITIATE_CHECKOUT",
			"checkoutMode" => "PAYMENT_LINK",
		"apiPassword" => @$apc_get['api_password_key'],
		"apiUsername" => "merchant.{$merchant_id}",
		"merchant" => $merchant_id,
		"interaction.operation" => "AUTHORIZE", // AUTHORIZE || PURCHASE
		"interaction.returnUrl" => @$status_default_url, 
		"interaction.merchant.name" => $dba,
			//"interaction.merchant.url" => @$status_default_url,
		//"card.accountNumber" => '4147673003292810',
	   // "card.cardHolderName" => 'Arun Dixt',
	   // "card.expiryMonth" => '11',
		//"card.expiryYear" => '2028',
		"billing.address.city" => @$post['bill_city'],
		"billing.address.stateProvince" => @$post['state_two'],
		"billing.address.country" => @$post['country_three'],
		"billing.address.postcodeZip" => @$post['bill_zip'],
		"billing.address.street" => @$post['bill_street_1'],
		"billing.address.street2" => @$post['bill_street_2'],
		"order.id" => @$transID,
		"order.amount" => @$total_payment,
		"order.currency" => @$orderCurrency,
		"order.description" => $post['product']
	);

	
	if($data['cqp']>0) 
	{
		echo "<br/><br/>postRequest=>";
		print_r($postRequest);
	}
	
	
	$options = array(
		CURLOPT_URL => $bank_url,
		CURLOPT_POST => true,
		CURLOPT_POSTFIELDS => http_build_query($postRequest),
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_HEADER => 0,
		CURLOPT_SSL_VERIFYPEER => 0,
		CURLOPT_SSL_VERIFYHOST => 0,
	);
	
	$curl = curl_init();
	curl_setopt_array($curl, $options);
	$response = curl_exec($curl);
	curl_close($curl);
	
	
	$response=urldecode('https://view?'.$response);
	parse_str(parse_url($response, PHP_URL_QUERY), $results); 
	
	db_trf($_SESSION['tr_newid'], 'acquirer_response_stage1', $results);
	
	$get_session_id=$_SESSION['3ds2_auth']['get_session_id']=@$results['session_id'];
	
	if($data['cqp']>0) 
	{
		echo "<br/>curl_bank_url=> ".$curl_bank_url;
		echo "<br/><hr/>session=>".$response;
		echo "<br/><br/>";
		print_r($results);
		echo "<br/>";
		echo "<br/>session_id=>".@$get_session_id."<br/>";
	}

	
	############################################################

	
	

	
	
	$tr_upd_order1=array();
	if(isset($get_session_id)&&$get_session_id)  $tr_upd_order1['acquirer_ref']=$get_session_id;
	$tr_upd_order1['bank_url']=@$bank_url;
	$tr_upd_order1['postRequest']=$postRequest;
	$tr_upd_order1['response']=$response;
	$tr_upd_order1['responseParamList']=isset($results)&&$results?$results:htmlentitiesf($response);
	//$curl_values_arr['browserOsInfo']=$browserOs;
	
	
	$tr_upd_order1['pay_mode']='3D';
	//$auth_3ds2_secure=@$reprocess_url;
	//$auth_3ds2_secure=@$status_default_url;
	$auth_3ds2_secure=@$reprocess_url;
	$auth_3ds2_action='redirect';
	
	
	// Check error 
	
	
	if($data['cqp']==9)
	{
		trans_updatesf($_SESSION['tr_newid'], $tr_upd_order1);
		
		echo "<br/><br/>bank_url=> "; print_r($curl_bank_url);
		echo "<br/><br/>curlPost Encode=> ".json_encode($postRequest);
		echo "<br/><br/>curlPost=> "; print_r($postRequest);
		echo "<br/><br/>results=> "; print_r($results);
		echo "<br/><br/>response=> "; print_r($response);
		//echo "<br/><br/>error_description=> "; print_r($error_description);
		exit;
	}
	
		
	if(isset($error_description) && !empty(trim($error_description)))
	{
		$_SESSION['acquirer_response']=$error_description;
		$tr_upd_order1['error']=$error_description;
		trans_updatesf($_SESSION['tr_newid'], $tr_upd_order1);
		echo 'Error for '.@$error_description;exit; 
	}

	
	$tr_upd_order_111=$tr_upd_order1;
	//trans_updatesf($_SESSION['tr_newid'], $tr_upd_order1);
		
?>