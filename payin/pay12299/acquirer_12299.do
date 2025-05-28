<?
// 122-TetherCoin from 342 TetherCoin 
// 122-TetherCoin : 342 - api/34/CreateCryptoCurrencyInvoice.do | Default Acquier : 12299

//{"coinName":"USDT","coinTitle":"TetherCoin","tetherTransportProtocol":"ETHEREUM"}

// {"coinName":"USDT","coinTitle":"TetherCoin","tetherTransportProtocol":"ETHEREUM","netWorkType":"TRON / TRC20 / TRX", "sci_name":"SCI_i15gw_2023","sign_key":"2c8dc6bccd04b1ca81fd2ce69898d50d9a42a303bc53021a2466b6e6b51905cc","account_email":"vik.mno@gmail.com","api_name":"API_i15gw_2023","api_pass":"India@1230"}

if(isset($apc_get['account_email'])&&trim($apc_get['account_email']))
$ac_account_email=$apc_get['account_email']; 
else $ac_account_email="vik.mno@gmail.com";

//sciName
if(isset($apc_get['sci_name'])&&trim($apc_get['sci_name']))
		$sciName=$apc_get['sci_name']; 
else 	$sciName='TetherSciPayment'; 


$b['sciName']=$sciName;
$b['coinName']=$apc_get['coinName'];
$b['coinTitle']=$apc_get['coinTitle'];
$b['netWorkType']=$apc_get['netWorkType'];
$b['tetherTransportProtocol']=$apc_get['tetherTransportProtocol'];
//$b['bank_process_url_'.$acquirer]=$bank_process_url;




// if digi50 match in Bank url than enable postApiEnable
if(isset($postApiEnable)&&$postApiEnable=='Y')
{

	$params=array();

	/*
	$params['coinName']='USDT'; // USDT BTC
	$params['coinTitle']='TetherCoin'; 
	$params['tetherTransportProtocol']='ETHEREUM'; 
	$params['netWorkType']='TRON / TRC20 / TRX'; 

	$params['api_name']='digi51_API_A'; // apiName
	$params['api_pass']='2024@2024'; // apiPass

	$params['account_email']='onternity@gmail.com';
	$params['sci_name']='digi51_USDT_SCI_B'; 
		
	//$params['order_id']=$transID; // transID
	//$params['comments']=$transID; // transID
	$params['sign_key']='54c8d87829baf2b6cb382d0dd9e72f04ced6fc850817151850378ff4c1c51ade';
	*/
	
	$params['tetherTransportProtocol']=$apc_get['tetherTransportProtocol'];
	if(isset($post['tetherTransportProtocol'])&&@$post['tetherTransportProtocol'])
		$params['tetherTransportProtocol']=$post['tetherTransportProtocol']; 

	
	if(@$params['tetherTransportProtocol']=="BTC"||@$apc_get['tetherTransportProtocol']=='BTC'||@$apc_get['transportProtocol']=='BTC')	
		$params['netWorkType']='Bitcoins';
	else $params['netWorkType']=$data['tetherTransportProtocol'][$params['tetherTransportProtocol']]; 

	$params['amount']=trim($total_payment); 
	$params['currency']=$orderCurrency; 

	//s2s - check if 1 is Direct (Curl Option) 
	if($connection_method==1)
	{
		$params['integration-type']='s2s'; 

		//cmn
		//$params['transID']='1221777901'; 
		if($data['localhosts']==true) $params['transID']='12391790445'; 
	}


	$tr_upd_order_111['postDataInfo']=$params;

	//Array merge for digi50
	$params=array_merge($postApiArray,$params);

	//cmn
	//print_r($params); exit;

	//Send to Post Date via 64 encode method 
	$params_en= json_encode($params, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
	$postApi["postApiData"]=encode64f($params_en);

	// overright default acquirer
	$postApi["default_acquirer"]='122'; 
	


	//s2s - check if 1 is Direct (Curl Option) 
	if($connection_method==1){

		if(isset($_REQUEST['c'])&&@$_REQUEST['c']==2)
		{
			//cmn
			$postApi["CURLOPT_HEADER"]="1"; 
			$postApi["cron_tab"]="cron_tab"; 
			$bank_url=$bank_url.'?qp=1&qr=1';
		}

		$get_res=use_curl($bank_url, $postApi);

		if(isset($_REQUEST['c'])&&@$_REQUEST['c']==2)
		{
			echo "<hr/><br/>get_res=>".$get_res;
		}

		$get_res_de=json_decode_is($get_res,1);

		if(isset($_SESSION['customer_service_email'])&&$_SESSION['customer_service_email'])
			@$get_res_de['customer_service_email']=$_SESSION['customer_service_email'];

		$tr_upd_order_111['responseInfo']=$get_res_de;

		
		if((isset($get_res_de['payaddress']))&&(!empty($get_res_de['payaddress'])))
		{
			$payaddress=@$get_res_de['payaddress'];

			$tr_upd_order_111['upa']=@$payaddress;

			if(isset($get_res_de['action'])) unset($get_res_de['action']);

			$_SESSION['3ds2_auth']=@$get_res_de;

			$auth_3ds2 = $chart_url; // ../payin/chart.do	
			$_SESSION['url_redirect_mode']=$chart_qr_code_url; // payin/chart_qr_code
			$tr_upd_order_111['pay_mode']='3D';
			$auth_3ds2_secure=$payaddress;
			//$auth_3ds2_secure=$chart_url;
			$auth_3ds2_action='redirect';
			if(in_array($acquirer,["122"]))  $json_arr_set['html_class']='.qr_code_usdt';
			elseif(in_array($acquirer,["129"]))  $json_arr_set['html_class']='.qr_code_usdc';
			else  $json_arr_set['html_class']='.upi_qr_border_'.@$acquirer;
			$json_arr_set['html_redirect_url']=$chart_qr_code_url;

			//Dev Tech : 23-08-28 skip the get acquirer status in checkout page as one minute interval timer
			$json_arr_set['check_acquirer_status_in_realtime']='f';
			
			
			$post['actionajax']='ajaxJsonArray';

			//header("Location:".@$chart_qr_code_url);
			
		}

		//echo "<hr/><br/>payaddress=>".@$payaddress; print_r(@$get_res_de); 
		//exit;
		
	}
	else { // Host base redirect
		//$_SESSION['3ds2_auth']['post_redirect']=$params;
		$_SESSION['3ds2_auth']['post_redirect']=$postApi;
		$tr_upd_order['pay_mode']='3D';
		$auth_3ds2_secure=$bank_url;
		$auth_3ds2_action='post_redirect';
	}

}
else
{ // not digi50

	trans_updatesf($_SESSION['tr_newid'], $b);

	//Hard code testing via localhost
	if($data['localhostsXX']==true)
	{	
		$result_get['address']='TCUoZdT3yZkomjJ5ULaG8hgpBCELvRreWu';
		$result_get['cryptoCurrencyAmount']=trim($total_payment); 
		$result_get['amount']=trim($total_payment); 
		$result_get['currency']=$orderCurrency; 
		
		$result_get['note']=$transID;
		$result_get['orderId']=$transID;
		$result_get['sciName']=$sciName;
		
		//$result_arr = $result_get;
		
	}
	else 
	{
	// live - dynamic code via whitelisting 

		if(isset($_REQUEST['pq'])||isset($_REQUEST['dtest'])){
			error_reporting(E_ALL);
			ini_set('display_errors', '1');
			ini_set('max_execution_time', 0);
		}
		
		if ( PHP_VERSION_ID < 80000) 
		{
			libxml_disable_entity_loader(true);
		}
		
		//require_once("MerchantWebService.php");
		include("MerchantWebService.php");
		$merchantWebService = new MerchantWebService();


		$arg0 = new authDTO();
		
		
		include('config_adv.php');

		$arg1 = new createCryptoCurrencyInvoiceRequest();
		$arg1->amount = trim($total_payment); 
		$arg1->currency = $orderCurrency; 
			$arg1->coinName = $apc_get['coinName'];
			$arg1->tetherTransportProtocol = $apc_get['tetherTransportProtocol'];
			//$arg1->subMerchantURL = $status_default_url;

		// optional
		$arg1->sciName = $sciName;
		$arg1->orderId = $transID;
		$arg1->note = $transID; //"payment request"; 



		$createCryptoCurrencyInvoice = new createCryptoCurrencyInvoice();
		$createCryptoCurrencyInvoice->arg0 = $arg0;
		$createCryptoCurrencyInvoice->arg1 = $arg1;

		$result_get=$merchantWebService->createCryptoCurrencyInvoice($createCryptoCurrencyInvoice); 

	}


	$result_arr =  (array) $result_get;
	$je=json_encode($result_get);

	$payaddress=jsonvaluef($je,'address');

	$_SESSION['3ds2_auth']['payaddress']=$payaddress;
	$_SESSION['3ds2_auth']['payamt']=jsonvaluef($je,'cryptoCurrencyAmount');
	$_SESSION['3ds2_auth']['paycurrency']=jsonvaluef($je,'currency');
	$_SESSION['3ds2_auth']['bill_amt']=jsonvaluef($je,'amount');
	$_SESSION['3ds2_auth']['note']=jsonvaluef($je,'note');
	$_SESSION['3ds2_auth']['orderId']=jsonvaluef($je,'orderId');
	$_SESSION['3ds2_auth']['sciName']=jsonvaluef($je,'sciName');

	$_SESSION['3ds2_auth']['savePaymentTemplate']=jsonvaluef($je,'savePaymentTemplate');

	$_SESSION['3ds2_auth']['bill_currency']=$orderCurrency;
	$_SESSION['3ds2_auth']['paytitle']=$bjd['paytitle'];
	$_SESSION['3ds2_auth']['netWorkType']=$bjd['netWorkType'];


	try {
		echo print_r($merchantWebService->createCryptoCurrencyInvoice($createCryptoCurrencyInvoice));
	} catch (Exception $e) {
		echo "ERROR MESSAGE => " . $e->getMessage() . "<br/>"; echo $e->getTraceAsString();
		$response=jsonencode($e->getMessage() . "<br/>".$e->getTraceAsString());
	}




	//$tr_upd_order['host_'.$acquirer]=$data['Host'];
	//$tr_upd_order['process_'.$acquirer]=$process;
	//$tr_upd_order['transID']=$_SESSION['transID'];
	//$tr_upd_order['txn_id_'.$acquirer]=$result_arr['data']['id'];

	if(isset($result_arr)&&is_array($result_arr)){
		$tr_upd_order['postResponse']=@$result_arr;	
		$tr_upd_order['auth_3ds2']=@$_SESSION['3ds2_auth'];	
	}elseif(isset($response)&&$response){
		$tr_upd_order['postResponse']=@$response;	
	}else{
		$tr_upd_order['postResponse']='response error - '.@$je;	
	}

	$tr_upd_order['cr_dt']=date('Y-m-d H:i:s');


	//$check_status = "payin/34/processed_url{$data['ex']}?transID=".$_SESSION['transID'];
	//$tr_upd_order['host_'.$acquirer]=$data['Host'];
	//$tr_upd_order['status_'.$acquirer]=$check_status;

	trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);

	//$_SESSION['q_order_342']=$tr_upd_order;

	//echo print_r($tr_upd_order);


	if((isset($payaddress))&&(!empty($payaddress))){

		$auth_3ds2 = $chart_url; // ../payin/chart.do	
		$_SESSION['url_redirect_mode']=$chart_qr_code_url;
		$tr_upd_order['pay_mode']='3D';
		$auth_3ds2_secure=$payaddress;
		$auth_3ds2_action='redirect';
		
		
	}else{

		$payment_url = $return_url;
		
		$_SESSION['acquirer_action']=1; 
		$_SESSION['acquirer_response']= @$message."Cancelled"; 
		$_SESSION['curl_values']=@$response.",".@$browserOs; 
		$_SESSION['acquirer_status_code']=-1;  
		

	}


}


?>
