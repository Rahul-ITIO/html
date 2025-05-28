<?
// 38 PayU from 64 

	$tr_upd_order=array();
	$tr_upd_order=$apc_get;
	$tr_upd_order['s30_count']=10;

	$bankstatus = "bankstatus{$data['ex']}?transID=".$_SESSION['transID']."&action=webhook";
	$surl		= "bankstatus{$data['ex']}?transID=".$_SESSION['transID']."&action=webhook";
	$furl		= "bankstatus{$data['ex']}?transID=".$_SESSION['transID']."&action=failed";

	$requestPost['key']				= $apc_get['merchantKey'];
	$requestPost['txnid']			= $_SESSION['transID'];
	$requestPost['amount']			= $total_payment;
	$requestPost['productinfo']		= $post['product'];
	//$requestPost['firstname']		= $post['ccholder'];
	$requestPost['firstname']		= $post['fullname'];
	$requestPost['email']			= $post['bill_email'];
	$requestPost['phone']			= isMobileValid($post['bill_phone']);
	//$requestPost['surl']			= $webhook_url;
	$requestPost['surl']			= $return_url."&actionurl=webhook_surl";
	$requestPost['furl']			= $return_url."&actionurl=failed";
	$requestPost['txn_s2s_flow']	= '4';
//	$requestPost['service_provider']= "PayMeNow";

	############### SET DATA AS PER METHOD
	if($acquirer==38){ // Card Payment 38 from 64
		$requestPost['pg']			='CC';
		$requestPost['bankcode']	='CC';
		//$requestPost['ccname']	=$post['ccholder'];
		$requestPost['ccname']		=$post['fullname'];
		$requestPost['ccnum']		=$post['ccno'];
		$requestPost['ccvv']		=$post['ccvv'];
		$requestPost['ccexpmon']	=$post['month'];
		$requestPost['ccexpyr']		=$post['year'];
		//$requestPost['Consent_shared'] ='0';
	}
	elseif($acquirer==381){ // Net Banking 381 from 641
		$requestPost['pg']			='NB';
		$requestPost['bankcode']	=$post['bank_code_payu'];
		$tr_upd_order['upa']		=$requestPost['bankcode'];
	}
	elseif(($acquirer==382||$acquirer==385||$acquirer==386) && (isset($post['mop'])&&$post['mop']=='UPICOLLECT') ) {
		// Collect 382 from 642, 645, 646 
		$requestPost['pg']			='UPI';
		$requestPost['bankcode']	='UPI'; 
		$requestPost['vpa']			=$post['upi_address'];
		
		if(isset($post['upi_address_suffix'])&&$post['upi_address_suffix']) $requestPost['vpa'].=$post['upi_address_suffix'];
		
		$tr_upd_order['upa']=$requestPost['vpa'];
		
	}elseif($acquirer==383){ // CASH  383 from 643
		$requestPost['pg']			= 'CASH';
		$requestPost['bankcode']	= $post['wallet_code'];
		$tr_upd_order['upa']=$requestPost['bankcode'];
	}
	elseif($acquirer==384){ // ...  384 from 644
		$requestPost['txn_s2s_flow']= '2';
		$requestPost['pg']			= 'UPI';
		$requestPost['bankcode']	= 'INTENT';
		$requestPost['vpa']			= $post['upi_address'];
		$tr_upd_order['upa']=$requestPost['vpa'];
	}
	elseif($acquirer==382 && isset($post['mop'])&&$post['mop']=='QRINTENT'){ // QR & Intent  382 from 647
		$requestPost['pg']			= 'UPI';
		$requestPost['bankcode']	= 'INTENT';
	}

	############### SET DATA AS PER METHOD

	$url = $bank_url.'/_payment';

	$text= $requestPost['key']."|".$requestPost['txnid']."|".$requestPost['amount']."|".$requestPost['productinfo']."|".$requestPost['firstname']."|".$requestPost['email']."|||||||||||".$apc_get['saltKey'];
	$output = hash ("sha512", $text);

	$requestPost['hash'] = $output;

	if(isset($data['pq'])&&$data['pq'])
	{
		echo "URL = >$url<br />";
		print_r($requestPost);
	}

	$response= request_post($url, $requestPost);

	$responseParam = json_decode($response,true);

	if(isset($data['pq'])&&$data['pq'])
	{
		echo "responseParam = ><br />";
		print_r($responseParam);
		exit;
	}

	

	$request_post_data=$requestPost;

	if(isset($request_post_data['ccnum']))		unset($request_post_data['ccnum']);
	if(isset($request_post_data['ccvv']))		unset($request_post_data['ccvv']);
	if(isset($request_post_data['ccexpmon']))	unset($request_post_data['ccexpmon']);
	if(isset($request_post_data['ccexpyr']))	unset($request_post_data['ccexpyr']);

	$tr_upd_order['requestPost']=$request_post_data;

	if(isset($data['pq'])&&$data['pq'])
	{
		echo "tr_upd_order = ><br />";
		print_r($tr_upd_order);
	}

	trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);

	$tr_upd_order_res['responseParam']=$responseParam?$responseParam:$response;

	/*if(isset($responseParam['metaData']['referenceId'])&&$responseParam['metaData']['referenceId'])
	{
		$tr_upd_order_res['txn_id']=$responseParam['metaData']['referenceId'];
	}
	*/
	trans_updatesf($_SESSION['tr_newid'], $tr_upd_order_res);

	if (isset($responseParam) && count($responseParam)>0) {
		if(($acquirer==382||$acquirer==385) && (isset($post['mop'])&&$post['mop']=='UPICOLLECT')) {
			// Collect 382 from 642, 645 
			
			//$auth3DUrl	= $bank_process_url.'/'.$bankstatus;
			$payment_url	= $status_url;
		}
		elseif($acquirer==384) { // ...  384 from 644
			if(isset($responseParam['intentURIData'])&&$responseParam['intentURIData'])
			{
				$payment_url='upi://pay?'.$responseParam['intentURIData'];
				//echo $auth3DUrl;exit;
			}
		}
		elseif( ($acquirer==382) && isset($post['mop'])&&$post['mop']=='QRINTENT') {
			// QR & Intent  382 from 647 
			
			if(isset($responseParam['result']['intentURIData'])&&$responseParam['result']['intentURIData'])
			{	
				
				$tr_upd_order['QRINTENT']=$qr_intent_address='upi://pay?'.$responseParam['result']['intentURIData'];
				
				$qr_intent_address=urlencodef($qr_intent_address); // return upi address for auto run for check via mobile or web 
				//$intent_process_redirect=1;
				$intent_process_include=1;
				//$qr_process_base64=1;
				
			}
			
		}
		elseif(isset($responseParam['result']['acsTemplate'])&&$responseParam['result']['acsTemplate'])
		{
			echo $opener_script;
			$acsTemplate=$responseParam['result']['acsTemplate'];
			$auth_3ds2_secure=($acsTemplate);
			$auth_3ds2_base64=1;
			
		}elseif(isset($responseParam['result']['issuerUrl'])&&$responseParam['result']['issuerUrl']){
			$redirect_3d_url	= $responseParam['result']['issuerUrl'];
		}
		elseif(isset($responseParam['result']['postToBank']['RU'])&&$responseParam['result']['postToBank']['RU']){

			$redirect_3d_url	= $responseParam['result']['postToBank']['RU'];
		}
	}

//38 end

function request_post($url, $post=null){
	$protocol	= isset($_SERVER["HTTPS"])?'https://':'http://';
	$referer	= $protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];

	$handle=curl_init();
	curl_setopt($handle, CURLOPT_URL, $url);

	if($post){
		curl_setopt($handle, CURLOPT_POST, 1);
		curl_setopt($handle, CURLOPT_POSTFIELDS, $post);
	}
	curl_setopt($handle, CURLOPT_REFERER, $referer);
	curl_setopt($handle, CURLOPT_HEADER, 0);
	curl_setopt($handle, CURLOPT_SSL_VERIFYPEER, 0);
	curl_setopt($handle, CURLOPT_SSL_VERIFYHOST, 0);

	curl_setopt($handle, CURLOPT_RETURNTRANSFER, 1);
	$result=curl_exec($handle);
	curl_close($handle);
	return $result;
}
?>