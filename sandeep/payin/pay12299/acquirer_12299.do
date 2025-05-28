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

?>
