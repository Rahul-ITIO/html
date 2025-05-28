<?
include('function_11'.$data['iex']);

	$transID = $_SESSION['transID'];
	$orderCurrency=$_SESSION['curr'];
	$timestamp = time()*1000; //get current timestamp in milliseconds
	
	$binancePayNonce = generateRandomString_11();
	
	$postData['env']['terminalType']= "APP";//"APP";
	$postData['merchantTradeNo']= $_SESSION['transID'];
	$postData['orderAmount']= $total_payment;
	//$postData['currency'] = "B".$orderCurrency;//"BUSD";
	$postData['currency'] = "USDT";//"BUSD";

	$postData['goods']['goodsType']	= "01";
	$postData['goods']['goodsCategory'] 	= "Z000";	//category code for other
	$postData['goods']['referenceGoodsId']	= time();
	$postData['goods']['goodsName']	= $dba .'-' .$_SESSION['product'];
	$postData['goods']['goodsDetail']= 'Order No. '.$_SESSION['transID'];
	$postData['returnUrl']	= $status_url_1;


if($data['localhosts']==true) 
	$postData['webhookUrl']='https://gtw.online-epayment.com/payin/pay11/webhookhandler_11?transID=11161029';
else $postData['webhookUrl']=$webhookhandler_url;


$payload = (string)$timestamp."\n".$binancePayNonce."\n".json_encode($postData)."\n";
	
	$signature = hash_hmac('sha512', $payload, $apc_get['secretkey']);
	
	 $signature = strtoupper($signature);
	   $url= $bank_url;//dynamic url from backend
	 
	
	   //curl for hit the request
         $ch = curl_init($url); 
	curl_setopt($ch, CURLOPT_POST, 1);
	curl_setopt($ch, CURLOPT_HTTPHEADER, array("Content-Type: application/json", "BinancePay-Timestamp: ".$timestamp, "BinancePay-Nonce: ".$binancePayNonce, "BinancePay-Certificate-SN: ".$apc_get['apikey'], "BinancePay-Signature: ".$signature));
	curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($postData));
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($ch, CURLOPT_HEADER, 0);
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
	curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
	
	 $response = curl_exec($ch);
	 curl_close($ch);
	
	$res = json_decode($response,true);
	print_r($res);
//print_r($res);
        echo $res['status'];
        //exit;
	//echo $res['status'];
	//exit;
	
	
	
	$tr_upd_order['requestPost']=$postData;
	$tr_upd_order['ResponseA']	=$res?$res:$response;
	$curl_values_arr['responseInfo']	=$tr_upd_order['ResponseA'];
	$curl_values_arr['browserOsInfo']	=$browserOs;
	$_SESSION['acquirer_action']=1;		//set action HKIP for update trasaction via callback
	$_SESSION['curl_values']=@$curl_values_arr;
	
	if(isset($res['data']['prepayId']))
	{
	
		$tr_upd_order['acquirer_ref']=$res['data']['prepayId']; 
	}
	 trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);
	// exit;
	 if(isset($_SESSION['post']['qp'])&&$_SESSION['post']['qp'])
	{
		print_r($postData);
		print_r($res);
		//exit;
	}
	
	if(isset($res['status']))
		{
		
			//echo $responseParamList['status'];
			//echo "<br />";
			if(isset($res['code'])&&$res['code']=='000000')
			{
			//echo "abcd";
				$prepayId		=$res['data']['prepayId'];
				$terminalType	=$res['data']['terminalType'];
				$expireTime		=$res['data']['expireTime'];
				$qrcodeLink		=$res['data']['qrcodeLink'];
				$qrContent		=$res['data']['qrContent'];
				$checkoutUrl	=$res['data']['checkoutUrl'];
				$deeplink		=$res['data']['deeplink'];
				$universalUrl	=$res['data']['universalUrl'];
				
				$payment_url = $trans_processing ;
				
				
				// simple redirect 3d url without iframe 
				if($checkoutUrl)$redirect_3d_url=$checkoutUrl;
				elseif($qrcodeLink) $redirect_3d_url=$qrcodeLink;
				
				// by pass for secure folder with proccess url in iframe 
				/*
				if($checkoutUrl)$secure_process=$checkoutUrl;
				elseif($qrcodeLink) $secure_process=$qrcodeLink;
				*/
				
				
			}
		}
		//exit;


	trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);

?>
