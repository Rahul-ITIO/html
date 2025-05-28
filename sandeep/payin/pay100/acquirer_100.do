<?
// Dev Tech : 23-12-26  100 Acquirer is Default root any our acquirer as per public_key, Trans URL and terNO wise for payment create 

if(isset($apc_get['public_key'])&&$apc_get['public_key']) $bank_public_key=$apc_get['public_key'];
if(isset($apc_get['terNO'])&&$apc_get['terNO']) $bank_terNO=$apc_get['terNO'];
		

	$curlPost=array();

	$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
	$source_url=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI']; 
	
	$curlPost["public_key"]=$bank_public_key;
	$curlPost["terNO"]=$bank_terNO;

	//<!-- Payment details of customer -->
	if(isset($post['mop'])&&$post['mop']) $curlPost["mop"] = $post['mop'];

	$curlPost["integration-type"]="s2s";
	$curlPost["bill_ip"]=$_SESSION['bill_ip'];
	$curlPost["source_url"]=$source_url;
	 
	$curlPost["bill_amt"]=$total_payment;
	$curlPost["bill_currency"]=$orderCurrency;
	$curlPost["product_name"]="Request to ".$post['product_name'];

	$curlPost["fullname"]=$post['fullname'];
	$curlPost["bill_email"]=$post['bill_email'];

	$curlPost["bill_address"]=$post['bill_address'];
	$curlPost["bill_city"]=$post['bill_city'];
	$curlPost["bill_state"]=$post['bill_state'];
	$curlPost["bill_country"]=$post['bill_country'];
	$curlPost["bill_zip"]=$post['bill_zip'];


	$curlPost["bill_phone"]=$post['bill_phone'];
	$curlPost["reference"]=$_SESSION['transID'];
	//$curlPost["unique_reference"]='Y'; 
	$curlPost["webhook_url"]=$webhookhandler_url;
	$curlPost["return_url"]=$status_url_1;

	$curlPost['ccno']=$post['ccno'];
	$curlPost['ccvv']=$post['ccvv'];
	$curlPost['month']=$post['month'];
	$curlPost['year']=$post['year'];

	$post_data=$curlPost;
	if(isset($post_data['ccno'])) unset($post_data['ccno']);
	if(isset($post_data['ccvv'])) unset($post_data['ccvv']);
	if(isset($post_data['month'])) unset($post_data['month']);
	if(isset($post_data['year'])) unset($post_data['year']);
	
	if(trim($bank_url)=='NA') $bank_url=$data['Host'].'/directapi'.$data['ex'];

	$curl_cookie="";
	$curl = curl_init(); 
	curl_setopt($curl, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);
	curl_setopt($curl, CURLOPT_URL, $bank_url);
	curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
	curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 0);
	curl_setopt($curl, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']);
	curl_setopt($curl, CURLOPT_REFERER, $source_url);
	curl_setopt($curl, CURLOPT_POST, 1);
	curl_setopt($curl, CURLOPT_POSTFIELDS, $curlPost);
	curl_setopt($curl, CURLOPT_TIMEOUT, 30);
	curl_setopt($curl, CURLOPT_HEADER, 0);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($curl, CURLOPT_COOKIE,$curl_cookie);
	$response = curl_exec($curl);
	curl_close($curl);

	$results = json_decode($response,true);
	$results=sqInArray($results);
	
	$tr_upd_order1=array();
	if(isset($results["transID"])&&$results["transID"])  $tr_upd_order1['acquirer_ref']=@$results["transID"];
	$tr_upd_order1['transID']=@$results["transID"];
	$tr_upd_order1['post_data']=$post_data;
	$tr_upd_order1['responseParamList']=isset($results)&&$results?$results:htmlentitiesf($response);
	$curl_values_arr['browserOsInfo']=$browserOs;
	
	$message = @$results["response"];
	$_SESSION['acquirer_response']=@$message;
	

	if((isset($results["Error"]) && ($results["Error"]))||(isset($results["error"]) && ($results["error"])))
	{
		if($results["Error"]) $_SESSION['acquirer_response'].=$results["Error"];
		if($results["error"]) $_SESSION['acquirer_response'].=$results["error"];
		$tr_upd_order1['error']=$_SESSION['acquirer_response'];
		trans_updatesf($_SESSION['tr_newid'], $tr_upd_order1);
		
		echo 'Error for '.@$_SESSION['acquirer_response'];exit; 
		
		//print_r($results); 
		//exit;
	}

	$status_nm = (int)($results["order_status"]);
	
	
	//3D Bank url for OTP validate via payaddress from authdata 
	if(isset($results["authdata"]["payaddress"]) && ($results["authdata"]["payaddress"])){ 
		$results["authurl"]=$results["authdata"]["payaddress"];
	}


	if(isset($results["authurl"]) && ($results["authurl"])){ //3D Bank data on Host URL
		
		$tr_upd_order['pay_mode']='3D';
		$auth_3ds2_secure=$results["authurl"];
		$auth_3ds2_action='redirect';
		
		unset($results["authurl"]);
		
		if(isset($results["authdata"])&&$results["authdata"]) $_SESSION['3ds2_auth']=$results["authdata"];
		
	}elseif(isset($results["pay_url"]) && ($results["pay_url"])){ //3D Bank URL
		$tr_upd_order['pay_mode']='3D';
		$auth_3ds2_secure=$results["pay_url"];
		$auth_3ds2_action='redirect';
	}
	

	
##########################################################################

	$_SESSION['acquirer_action']=1;
	// $_SESSION['acquirer_action']=$responseRequest['type'];
	// $_SESSION['curl_values']=$curl_values_arr;

	if($_SESSION['post']['qp'])
	{
		echo '<br/><br/><b>bank_url:</b> '.@$bank_url;
		echo '<br/><br/><b>result:</b> ';
		print_r(@$tr_upd_order);
		echo '<br/><br/><b>response:</b> ';
		print_r(@$response);
		exit;
	}

	if(isset($_SESSION['b_'.$midcard]['billing_descriptor'])&&$_SESSION['b_'.$midcard]['billing_descriptor']) $_SESSION['acquirer_descriptor']=@$_SESSION['b_'.$midcard]['billing_descriptor'];

	trans_updatesf($_SESSION['tr_newid'], $tr_upd_order1);
	

	if(isset($paymentUrl) && !empty($paymentUrl))
	{
		$_SESSION['acquirer_status_code']=1;
		$_SESSION['redirect_url']=$paymentUrl; 
		$process_url = $paymentUrl; 
	}
	elseif($status_nm==1){ // 1:Approved/Success,9:Test Transaction

		$_SESSION['acquirer_action']=$message." - Success";
		$_SESSION['acquirer_status_code']=2;
		//$process_url = "{$data['Host']}/success{$file_v}{$data['ex']}?transID=$transID&action=hkip"; 
		$json_arr_set['realtime_response_url']=$trans_processing;

	}elseif($status_nm==2){ // Declined/Failed
		
		$_SESSION['acquirer_action']=$message." - Cancelled";
		$_SESSION['acquirer_status_code']=-1;
		//$process_url = "{$data['Host']}/failed{$file_v}{$data['ex']}?transID={$transID}&action=hkip"; 
		$json_arr_set['realtime_response_url']=$trans_processing;

	}
/*
	else{

		$_SESSION['acquirer_status_code']=1;
		$_SESSION['acquirer_action']=$_SESSION['acquirer_action']." - Pending";

		//$process_url = "{$data['Host']}/transaction_processing{$file_v}{$data['ex']}?transID={$transID}&action=hkip"; 
	}
*/
	
?>