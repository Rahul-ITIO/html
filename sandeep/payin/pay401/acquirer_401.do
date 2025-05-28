<?
//40 to 409 via gw2.mcpayment.net

	// $data['cqp']==6;
	
	include ($data['Path']."/payin/pay401/function_401".$data['iex']);
		
	$bankstatus = $status_default_url;

	$requestPost = array();
	if($acquirer==406)
	{
		$requestPost['mcptid']			= (string)$apc_get['mcpTerminalId'];
		$requestPost['currency']		= (string)$orderCurrency;
		$requestPost['amount']			= (string)round($total_payment*100);
		$requestPost['referenceNo']		= (string)$_SESSION['transID'];
		$requestPost['statusUrl']		= $webhookhandler_url;
		$requestPost['returnUrl']		= $bankstatus;
		$requestPost['itemDetail']		= "N";
		$requestPost['tokenize']		= "N";
		$requestPost['subject']			= (string)$post['bill_name'];
		$requestPost['customerEmail']	= (string)$post['bill_email'];
		$requestPost['phoneNumber']		= (string)$post['bill_phone'];
		$requestPost['billCountry']		= (string)$country_two;
		$requestPost['billAddress']		= (string)$post['bill_address'];
		$requestPost['billState']		= (string)$post['state_two'];
		$requestPost['billCity']		= (string)$post['bill_city'];
		$requestPost['billPostalCode']	= (string)$post['bill_zip'];
		$requestPost['shipCountry']		= (string)$country_two;
		$requestPost['shipAddress']		= (string)$post['bill_address'];
		$requestPost['shipState']		= (string)$post['state_two'];
		$requestPost['shipCity']		= (string)$post['bill_city'];
		$requestPost['shipPostalCode']	= (string)$post['bill_zip'];
	}
	else
	{
		$requestPost['header']['version']		=(string)$apc_get['version'];
		$requestPost['header']['appType']		=(string)$apc_get['appType'];
		$requestPost['header']['appVersion']	=(string)$apc_get['appVersion'];
		$requestPost['header']['mcpTerminalId']	=(string)$apc_get['mcpTerminalId'];
		
		$requestPost['data']['referenceNo']		=(string)$_SESSION['transID'];
		//$requestPost['data']['amountSettled']	=(string)round($total_payment*100);
		$requestPost['data']['currency']		=(string)$orderCurrency;
		$requestPost['data']['totalAmount']		=(string)round($total_payment*100);
		$requestPost['data']['eType']			=(string)$apc_get['eType'];
		$requestPost['data']['description']		="ewallet";
		$requestPost['data']['clientUrl']		=$bankstatus;
		//$requestPost['data']['amountSettled']=round($total_payment*100);
		
		//$requestPost['header']['signature']=hash_hmac('SHA512', json_encode($request), $apc_get['mcpTerminalId']);
	}
	
	$tr_upd_order=array();
	//$tr_upd_order=$apc_get;
	
	$tr_upd_order['redirect_url']	=$bankstatus;

	$request_post_data=$requestPost;

	$tr_upd_order['requestPost']=$request_post_data;
	//$tr_upd_order['responseParamList']=$responseParamList?$responseParamList:$response;

	trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);

	//$curl_values_arr['responseInfo']=$responseParamList?$responseParamList:$response;
	//$curl_values_arr['browserOsInfo']=$browserOs;

	$_SESSION['acquirer_action']=1;
//	$_SESSION['acquirer_response']=$responseRequest['type'];
	$_SESSION['curl_values']=@$curl_values_arr;

	if($data['cqp']==6)
	{
		echo '<br/><br/><b>bank_url:</b> '.$bank_url;
		echo '<br/><br/><b>requestPost:</b> ';
		print_r($requestPost);
		exit;
	}
	
	if(@$data['localhosts']==true)
		
	$result = '{"data":{"walletPaymentType":72001,"qrUrl":"https://qr.alipayplus.com/2816660403930m0p49j110cy1x7QFkz2rqSp","referenceNo":"401766641","walletType":77772,"amountInCNY":"171425","amountSettled":"34285","merchantOrderNo":"12070738","transactionId":"12070738","transactionType":72001,"totalAmount":"34285","currencySettled":"SGD","currency":"SGD","transactionState":"71"},"header":{"appType":"APP","appVersion":"1.2.3","mcpTerminalId":"7020120009","status":{"message":"Approved","responseCode":"0000"},"version":"5"}}';
	
	else 
	$result = sendRequest($bank_url, $requestPost);

	if($acquirer==406)
	{
		$payment_url = $result;
		$_SESSION['pay_url']=$payment_url;
	}
	else
	{
		$response_arr=json_decode($result,1);
	
		if($data['cqp']==7)
		{
			echo '<br/><br/><b>response_arr:</b> ';
			print_r($response_arr);
			exit;
		}
		
		
		if(isset($response_arr['header']['status']['responseCode']))
		{
			$responseCode = $response_arr['header']['status']['responseCode'];
	
			$tr_upd_order1=array();
	
			if(isset($response_arr['data']['transactionId'])) $tr_upd_order1['acquirer_ref']=$response_arr['data']['transactionId'];
	
			$tr_upd_order1['response']=$response_arr?$response_arr:$result;
	
			trans_updatesf($_SESSION['tr_newid'], $tr_upd_order1);
	
	//print_r($tr_upd_order);exit;
	
			$curl_values_arr['responseInfo']=(isset($result)&&$result?$result:$response);
			$curl_values_arr['browserOsInfo']=$browserOs;
	
			$_SESSION['acquirer_action']=1;
		///	$_SESSION['acquirer_response']=$responseRequest['type'];
			$_SESSION['curl_values']=$curl_values_arr;
	
			if($data['cqp']==8)
			{
				echo '<br/><br/><b>bank_url:</b> '.$bank_url;
				echo '<br/><br/><b>result:</b> ';
				print_r($tr_upd_order1);
				//exit;
			}
			if($responseCode=='0000')
			{ // qr code for wallet 
		
				// only web base qr_code generate for international like tetherCoins scanqr
				
				
				if(isset($_SESSION['3ds2_auth'])) unset($_SESSION['3ds2_auth']);
				$web_base_qrcode_international=@$response_arr['data']['qrUrl'];
				
			}
			elseif(isset($response_arr['data']['errorMessage']))
			{
				$errorMessage = $response_arr['data']['errorMessage'];
				
				$tr_upd_order['errorMsg']=@$errorMessage;
				trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);
				
				echo 'Error for '.@$errorMessage;
			}
		}
	}	

	
	
	

?>