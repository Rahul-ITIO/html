<?
//40 MCPayment via 343 MCPayment 
	

$countrycode1=$post['country_three'];
		


###############################################

	function sendRequest343($gateway_url, $data_string){
		global $json_response;
		
		$content = json_encode($data_string);

		$curl = curl_init($gateway_url);
		curl_setopt($curl, CURLOPT_HEADER, 0);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_HTTPHEADER,
				array("Content-type: application/json"));
		curl_setopt($curl, CURLOPT_POST, true);
		curl_setopt($curl, CURLOPT_POSTFIELDS, $content);
		
			curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
			curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);

		$json_response = curl_exec($curl);
		$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		if ( $status != 200 ) {
		
			$json_response=("Error: call to URL $gateway_url failed with status $status, response $json_response, curl_error " . curl_error($curl) . ", curl_errno " . curl_errno($curl) . ", request " . $content);
			
			//error_print('validation_error',$json_response); exit;
		}
		curl_close($curl);

		return $json_response;
	}
	
	
	$postRequest = array(	
		'mcptid' => (string)$apc_get['mcpTerminalId'],
		'currency' => $orderCurrency,
		'amount' => $total_payment,
		'referenceNo' => (string)$_SESSION['transID'],
		'statusUrl' => $webhookhandler_url,
		'returnUrl' => $status_default_url,
		'itemDetail' => "N",
		'tokenize' => "N",
		'subject' => $post['fullname'],
		'customerEmail' => $post['bill_email'],
		'phoneNumber' => $post['bill_phone'],
		'billCountry' => $countrycode1,
		'billAddress' => $post['bill_address'],
		'billState' => $post['state_two'],
		'billCity' => $post['bill_city'],
		'billPostalCode' => $post['bill_zip'],
		'shipCountry' => $countrycode1,
		'shipAddress' => $post['bill_address'],
		'shipState' => $post['bill_city'],
		'shipCity' => $post['state_two'],
		'shipPostalCode' => $post['bill_zip']
	);
	
	$tr_upd_order['requestPost']=htmlTagsInArray(@$postRequest);
	
###############################################

if($data['cqp']==6)
	{
		echo "<br/>bank_url=>".$bank_url;
		echo "<br/><br/><br/>postRequest=>";print_r($postRequest);
		
	}


	$result=sendRequest343($bank_url,$postRequest);
	//$result = json_decode($response, true);
	
	//$_SESSION['response']=$response;
	//$_SESSION['result']=$result;
	
	$tr_upd_order['response']=(isset($result)&&is_array($result)?htmlTagsInArray(@$result):stf(@$json_response));
		
	db_trf($_SESSION['tr_newid'], 'acquirer_response_stage1', $tr_upd_order);

	trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);
	
	if($data['cqp']==6)
	{
		echo "<br/>json_response=>".$json_response;
		echo "<br/><br/><br/>result=>";print_r($result);
		exit;
	}

	
	
	
	if(@$result){
		$redirect_3d_url=@$result; 
		$_SESSION['redirect_url']=$redirect_3d_url; 
		
		
	}	
		

?>