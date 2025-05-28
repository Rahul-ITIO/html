<? 
 $secereteKey = $apc_get['SecretKey'];
	$card_post_1 = $_SESSION['card_post_1'];
	
	$dataReq = json_encode($card_post_1);

	 $post_enc = encrypt3Des($dataReq, getKey($apc_get['SecretKey']));

	($qp)
	{
		echo "<br/>dataReq=>";
		var_dump($dataReq);
		//exit;
	}
	
	$postdata = array(
		'public_key' => $apc_get['PublicKey'],
		'client' => $post_enc,
		'alg' => '3DES-24'
	);

	if($qp)
	{
		echo "<br/>postdata=>";
		var_dump($postdata);
		exit;
	}

	if(isset($card_post['authorization']['mode']) && $card_post['authorization']['mode'] == "avs_noauth")
	{
		if(!isset($card_post['authorization']['state']) || $card_post['authorization']['state']=='')
		{
			$card_post['authorization']['state']=$card_post['authorization']['city'];
		
		}
	}
	
	$response = send_request($postdata, $apc_get['SecretKey'], $bank_url."/v3/charges?type=card");

	if($qp)
	{
		print_r($card_post_1);
		echo "response 1==>";
		print_r($response);
		echo "response 1 end";
		exit;
	}
	
	$tr_upd_order = array();

	$request_post_data=$card_post_1;

	if(isset($card_post_1['authorization']['pin']))
	{
		unset($request_post_data['authorization']['pin']);
	}
	unset($request_post_data['card_number']);
	unset($request_post_data['cvv']);
	unset($request_post_data['expiry_month']);
	unset($request_post_data['expiry_year']);

	$tr_upd_order['request_post_step_1']=$request_post_data;
	$tr_upd_order['MerchantWebsite']=$_SESSION['name'];

	//$tr_upd_order['bank_url'.$midcard]=$bank_url;
	//$tr_upd_order['host_'.$midcard]=$data['Host'];
	//$tr_upd_order['default_mid']=31;
	//$tr_upd_order['status_'.$midcard]="api/pay31/status31{$data['ex']}?transID={$transID}";
	//$tr_upd_order['status_'.$midcard]="bankstatus{$data['ex']}?transID={$transID}";

	if(isset($response['status']) && $response['status']=="success")
	{
		$message = $response['message'];
		
		if(isset($response['meta']['authorization']['mode'])) 
			$mode = $response['meta']['authorization']['mode'];
		
		if(isset($response['data']['id']))
		{
			$flw_ref= $response['data']['flw_ref'];
			$txn_id = $response['data']['id'];

			$tr_upd_order['acquirer_ref']	= $txn_id;
			$tr_upd_order['flw_ref']= $flw_ref;

			if(isset($response['meta']['authorization']['mode']))
			{
				//$mode = $response['meta']['authorization']['mode'];

				if($mode =="redirect")
				{
					$tr_upd_order['pay_mode']='3D';
					if(isset($response['meta']['authorization']['redirect']) && !empty($response['meta']['authorization']['redirect']))
					{
						$redirect = $response['meta']['authorization']['redirect'];

						//$paymentUrl="{$bank_process_url}/api/pay31/update31{$data['ex']}?transID=".$_SESSION['transaction_id'];
						
						$paymentUrl="{$bank_process_url}/bank3dstep2{$data['ex']}?transID=".$_SESSION['transID'];
						//exit;
						
						$_SESSION['pay_url']=$paymentUrl;
						$_SESSION['bank_pay_url']=$redirect;
					}
				}
				elseif(!empty($mode))
				{
					$tr_upd_order['pay_mode']='2D';
					$tr_upd_order['endpoint']=$response['meta']['authorization']['endpoint'];
					
					$paymentUrl="{$bank_process_url}/bank3dstep2{$data['ex']}?transID=".$_SESSION['transID']."&mode={$mode}";

					$_SESSION['pay_url']=$paymentUrl;
					//exit;
				}
			}
		}
		else
		{
			if(strtolower($mode)=='pin' || strtolower($mode)=='avs_noauth')
			{
				//$_SESSION['card_post']=$card_post_1;
				
				$tr_upd_order['pay_mode']='2D';

				$paymentUrl="{$bank_process_url}/bank3dstep2{$data['ex']}?transID=".$_SESSION['transID']."&mode={$mode}";

				$_SESSION['pay_url']=$paymentUrl;
			}
			else
			{
				$paymentUrl="{$bank_process_url}/bank3dstep2{$data['ex']}?transID=".$_SESSION['transID'];

				$_SESSION['pay_url']=$paymentUrl;
			}
		}
	}
	elseif(isset($response['status']) && $response['status']=="error")
	{
		$message = $response['message'];
		$tr_upd_order['response_error_msg']=$message;
	}

	$tr_upd_order['response_step_1']=$response;
	if(isset($tr_upd_order['response_step_1']['data']['card'])) unset($tr_upd_order['response_step_1']['data']['card']);

	$tr_upd_order['q_order_'.$midcard]['cr_dt']=date('Y-m-d H:i:s');
	$tr_upd_order['pay_url']=$_SESSION['pay_url'];

	if(isset($response['meta']['authorization']['redirect']) && !empty($response['meta']['authorization']['redirect'])) $tr_upd_order['bank_pay_url']=$redirect;

	transactions_updates($_SESSION['tr_newid'], $tr_upd_order);

	$curl_values_arr['responseInfo']=$response;
	$curl_values_arr['browserOsInfo']=$browserOs;
	
	$_SESSION['acquirer_action']=1;
	$_SESSION['curl_values']=$curl_values_arr;

	if($qp)
	{
		echo '<br/><br/><b>bank_url:</b> '.$bank_url;
		echo '<br/><br/><b>result:</b> ';
		print_r($tr_upd_order);
	}

	if(isset($paymentUrl) && !empty($paymentUrl))
	{
		
		$_SESSION['acquirer_status_code']=1;
		$process_url = $paymentUrl; 
		$_SESSION['acquirer_response']=$message;
	}
	else{
		
		$_SESSION['acquirer_status_code']=-1;

		$_SESSION['acquirer_response']=$message." - Cancelled";

		$process_url = "{$data['Host']}/return_url{$data['ex']}?transID={$transID}&action=hkip"; 

		//header("location:$process_url");exit;
	}

	if($post['cardsend']=="curl"){
		//$_SESSION['acquirer_status_code']=1;
		//$use_curl=use_curl($process_url,$data_send);
	}else{
		header("Location:$process_url");
		exit;
	}
?>
