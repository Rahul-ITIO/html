<?
//integration 44 waral from 31 
	$tr_upd_order=array();
	//$tr_upd_order=$apc_get;
	//$tr_upd_order['s30_count']=10;
	
	$post['curr']=$orderCurrency;
	
	$post['total_payment']=trim($total_payment);

    include('function_44.do');
	$card_post = array();
	
	//request
	$card_post['card_number']	= $post['ccno'];
	$card_post['cvv']			= $post['ccvv'];
	$card_post['expiry_month']	= $post['month'];
	$card_post['expiry_year']	= $post['year'];
	$card_post['currency']		= $orderCurrency;
	$card_post['amount']		= $total_payment;
	$card_post['fullname']		= $post['fullname'];
	$card_post['email']			= $post['bill_email'];
	$card_post['phone_number']	= $post['bill_phone'];
	$card_post['client_ip']		= $_SESSION['bill_ip'];
	$card_post['tx_ref']		= $transID;
//	$card_post['device_fingerprint']= $_SESSION['tr_transID'];
	$card_post['redirect_url']	= $status_default_url;
	


	if($acquirer==441)
	{
		$card_post['authorization']['mode']		= "pin";
		$card_post['authorization']['pin']		= $post['reqPin'];
	}
	$card_post['authorization']['city']			= $post['bill_city'];
	$card_post['authorization']['address']		= $post['bill_address'];
	$card_post['authorization']['state']		= $post['state_two'];
	$card_post['authorization']['country']		= $country_two;
	$card_post['authorization']['zipcode']		= $post['bill_zip'];

	$_SESSION['card_post_1']=$card_post;
	$card_post_1 = $_SESSION['card_post_1'];
    $dataReq = json_encode($card_post_1);
	//------------------------------------
//31 end rave
    $post_enc = encrypt3Des($dataReq, getKey($apc_get['SecretKey']));
	
	$postdata = array(
		'public_key' => $apc_get['PublicKey'],
		'client' => $post_enc,
		'alg' => '3DES-24'
	);
	
	if(isset($card_post['authorization']['mode']) && $card_post['authorization']['mode'] == "avs_noauth")
	{
		if(!isset($card_post['authorization']['state']) || $card_post['authorization']['state']=='')
		{
			$card_post['authorization']['state']=$card_post['authorization']['city'];
		
		}
	}


$curlopt_url_live=1;

if(@$data['localhostsX']==true)	//if you browse in local system then execute following section
{
	//cmn hard code testing
	$curlopt_url_live=0;

	if(isset($_SESSION['acquirer_44'])) $res=$_SESSION['acquirer_44'];
}


if($curlopt_url_live==1){
		
	$url=$bank_url."/v3/charges?type=card";
	$SecretKey = $apc_get['SecretKey'];

	$curl = curl_init();
	curl_setopt_array($curl, array(
	  CURLOPT_URL =>$url,
	  CURLOPT_RETURNTRANSFER => true,
	  CURLOPT_ENCODING => '',
	  CURLOPT_MAXREDIRS => 10,
	  CURLOPT_TIMEOUT => 30,
	  CURLOPT_FOLLOWLOCATION => true,
	  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	  CURLOPT_CUSTOMREQUEST => 'POST',
	  CURLOPT_POSTFIELDS =>json_encode($postdata),
	  CURLOPT_HTTPHEADER => array(
		"Accept: application/json",
		"Authorization: Bearer ".$SecretKey,
		"Content-Type: application/json"
	  ),
	));

	$response = curl_exec($curl);

	curl_close($curl);

	$res = json_decode($response,1);
	
	//cmn
	//$_SESSION['acquirer_44']=$res;
	

}

if(isset($_GET['qp']))
{
	if(isset($_SESSION['acquirer_44']))
	print_r(@$_SESSION['acquirer_44']);
}


// Dev Tech : 23-09-16 encode64f data save for otp and pin 

//acquirer_response_stage1
$acquirer_response_stage1['current_url_1']=$url;
$acquirer_response_stage1['paylod_1']=@$card_post;
$acquirer_response_stage1['response_1']=@$res;
$acquirer_response_stage1['secretkey_1']=@$SecretKey;
$acquirer_response_stage1['pay_url_1']=$bank_url."/v3/validate-charge";
$acquirer_response_stage1['flw_ref_1']=@$res['data']['flw_ref'];
db_trf($_SESSION['tr_newid'], 'acquirer_response_stage1', $acquirer_response_stage1);
	
	
$tr_upd_order['response_step_1']=(isset($res)&&is_array($res)?$res:$response);




//Dev Tech : 23-08-28 skip the get acquirer status in checkout page as one minute interval timer
//$json_arr_set['check_acquirer_status_in_realtime']='f';


	$request_post_data=@$card_post_1;

	if(isset($card_post_1['authorization']['pin']))
	{
		unset($request_post_data['authorization']['pin']);
	}
	unset($request_post_data['card_number']);
	unset($request_post_data['cvv']);
	unset($request_post_data['expiry_month']);
	unset($request_post_data['expiry_year']);

	$tr_upd_order['request_post_step_1']=@$request_post_data;
	$tr_upd_order['MerchantWebsite']=@$dba;
	
	trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);


if(isset($res['status'])){
	$_SESSION['acquirer_action']=1;
	$_SESSION['acquirer_response']=@$res['message'];
}

$tr_upd_order = array();
if(isset($res['status']) && $res['status']=="error")
{
	echo 'Error for '.$res['message'];exit; 
	//echo $response;  	
}
elseif(isset($res['status']) && $res['status']=="success")
{
		$message = @$res['message'];
		
		//$_SESSION['acquirer_status_code']=@$res['order_status'];
		//$_SESSION['acquirer_transaction_id']=@$res['tradeNo'];
		//$_SESSION['acquirer_descriptor']=@$res['acquirer'];

		//$_SESSION['curl_values']=@$curl_values_arr;

		if(isset($res['meta']['authorization']['mode'])) 
			$mode = $res['meta']['authorization']['mode'];
		
		//if(isset($res['data']['id']))
		{
			$flw_ref= @$res['data']['flw_ref'];
			$txn_id = @$res['data']['id'];

			$tr_upd_order['acquirer_ref']	= $txn_id;
			$tr_upd_order['flw_ref']= $flw_ref;
						
			//if(isset($res['meta']['authorization']['mode']) && ($res['meta']['authorization']['mode']=='redirect'||$res['meta']['authorization']['mode']=='avs_noauth') )
				
			//if(isset($res['meta']['authorization']['mode']) && ($res['meta']['authorization']['mode']=='redirect') )
			if(isset($res['meta']['authorization']['redirect']) && trim($res['meta']['authorization']['redirect']) )
			{
				$tr_upd_order['pay_mode']='3D';
				$auth_3ds2_secure=$res['meta']['authorization']['redirect'];
				$auth_3ds2_action='redirect';
				
				if(isset($_GET['qp']))
				{
					echo "<br/><hr/>auth_3ds2_secure=>".$auth_3ds2_secure;
					echo "<br/><hr/>meta=>";
					print_r($res['meta']);
				}
			}
			//elseif(isset($res['meta']['authorization']['mode']) && ($res['meta']['authorization']['mode']=='avs_noauth') )
			else
			{
				$tr_upd_order['pay_mode']='3D';
				/*
				$auth_3ds2_secure=$reprocess_url;
				$auth_3ds2_action='redirect';
				*/
				//$auth_3ds2=$data['Host'].'/auth_3ds2'.$data['ex']; 
				
				$tr_upd_order['avs_noauth']=@$res['meta']['authorization']['mode'];
				
				$auth_3ds2_action='post_redirect';
				$auth_3ds2_secure='https://checkout.flutterwave.com/v3/hosted/pay';
				
				$params=array();
				$params['public_key']=$apc_get['PublicKey'];
					$params['customer[email]']=$post['bill_email'];
					$params['customer[name]']=$post['fullname'];
				$params['tx_ref']=$transID;
				$params['amount']=$total_payment;
				$params['currency']=$orderCurrency;
				$params['redirect_url']=$status_default_url;
					$params['meta[source]']='Hosted Checkout';
				
				
				//$params['b_submit']='start-payment-button';

				$_SESSION['3ds2_auth']['post_redirect']=$params;
				
				//post_redirect($auth_3ds2_secure, $params);exit();
				
				if(isset($_GET['qp']))
				{
					echo "<br/><hr/>auth_3ds2_secure=>".$auth_3ds2_secure;
					echo "<br/><hr/>meta=>";
					print_r($res['meta']);
				}
			}
			/*
			elseif(isset($res['meta']['authorization']['mode']) && ($res['meta']['authorization']['mode']=='otp'||$res['meta']['authorization']['mode']=='pin') )
			{
				$tr_upd_order['pay_mode']='2D';
				//$auth_3ds2=$reprocess_url;
				$auth_3ds2_secure=$reprocess_url;
				$auth_3ds2_action=$res['meta']['authorization']['mode'];
				
				if(isset($_GET['qp']))
				{
					echo "<br/><hr/>auth_3ds2_secure=>".$auth_3ds2_secure;
					echo "<br/><hr/>meta=>";
					print_r($res['meta']);
				}
			}
			*/
		}
		
		/*
		elseif(empty($mode))
		{
			$tr_upd_order['pay_mode']='2D';
			$tr_upd_order['endpoint']=$res['meta']['authorization']['endpoint'];
		}
		*/
}
else { //failed or other in 2D mode 
	
	
	$_SESSION['acquirer_status_code']=-1;
	//$process_url = $return_url; 
	$json_arr_set['realtime_response_url']=$trans_processing;
	
	
}
	
trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);

if(isset($_GET['qp']))
{
	//echo json_encode($res);exit;
}
	
/*
	
//$curl_values_arr['responseInfo']=$res;
$curl_values_arr['browserOsInfo']=$browserOs;
	
$_SESSION['acquirer_action']=1;
$_SESSION['acquirer_response']=@$result_hkip['respMsg'];
$_SESSION['acquirer_status_code']=@$result_hkip['order_status'];
$_SESSION['acquirer_transaction_id']=@$result_hkip['tradeNo'];
$_SESSION['acquirer_descriptor']=@$result_hkip['acquirer'];

$_SESSION['curl_values']=$curl_values_arr;

*/

?>