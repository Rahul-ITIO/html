<?
//BNpay 
 include('function_11'.$data['iex']);//which is describe in function_11.do for signature

	$transID = $_SESSION['transID'];// dynamic value for transaction_id or order_id
	$orderCurrency=$_SESSION['curr'];//dynamic value for currency
	$tr_upd_order=$apc_get;//all backend json value from Acquirer coming this($apc_get)
	$tr_upd_order['s30_count']=10;
//print_r($apc_get);
    $timestamp = time()*1000; //get current timestamp in milliseconds
	
	$binancePayNonce = generateRandomString();
	
	$postData['env']['terminalType']		= "APP";//"APP";
	$postData['merchantTradeNo']			= $_SESSION['transID'];
	$postData['orderAmount']				= $total_payment;
	$postData['currency'] 					= "B".$orderCurrency;//"BUSD";

	$postData['goods']['goodsType']			= "01";
	$postData['goods']['goodsCategory'] 	= "Z000";	//category code for other
	$postData['goods']['referenceGoodsId']	= time();
	$postData['goods']['goodsName']			= $post['product'];
	$postData['goods']['goodsDetail']		= $post['product'];
	$postData['returnUrl']					= $data['Host'].'/'.$return_url;
	
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
	//print_r($res);
	//echo $res['status'];
	//exit;
	
	
	
	$tr_upd_order['requestPost']=$postData;
	$tr_upd_order['response']	=$res?$res:$response;
	$curl_values_arr['responseInfo']	=$tr_upd_order['response'];
	$curl_values_arr['browserOsInfo']	=$browserOs;
	$_SESSION['acquirer_action']=1;		//set action HKIP for update trasaction via callback
	$_SESSION['curl_values']=@$curl_values_arr;
	
	if(isset($res['data']['prepayId']))
	{
	
		$tr_upd_order['acquirer_ref']=$res['data']['prepayId']; 
	}
	 trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);
	 
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
				
				if($checkoutUrl)
				{
				 $payment_url = $checkoutUrl;
					$_SESSION['pay_url']=$checkoutUrl;
                   $tr_upd_order['pay_mode']='3D';
					$tr_upd_order['pay_url']=$checkoutUrl;
				}
				
				elseif($qrcodeLink) 
				{
				 $payment_url = $qrcodeLink;
					$_SESSION['pay_url']=$qrcodeLink;

					$tr_upd_order['pay_url']=$qrcodeLink;
				}
				
				//$payment_url = "{$data['Host']}/payin/common-qr{$data['ex']}?orderset=$prepayId&orderId={$orderId}&action=chart";
			}
		}
		//exit;
	if(isset($payment_url) && !empty($payment_url))
		{
			$_SESSION['acquirer_status_code']=1;
			$process_url = $payment_url; 
		}
		else{
			$_SESSION['acquirer_status_code']=-1;
			$_SESSION['acquirer_response']=$_SESSION['acquirer_response']." - Cancelled";
	
			$process_url = $return_url;
		}
		trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);

?>