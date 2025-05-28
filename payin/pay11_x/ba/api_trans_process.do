<?
if(isset($_SESSION['step']))unset($_SESSION['step']);			
if(isset($_SESSION['acquirer_action']))unset($_SESSION['acquirer_action']); 
if(isset($_SESSION['acquirer_response']))unset($_SESSION['acquirer_response']);
if(isset($_SESSION['acquirer_status_code']))unset($_SESSION['acquirer_status_code']);
if(isset($_SESSION['acquirer_transaction_id'])) unset($_SESSION['acquirer_transaction_id']);
if(isset($_SESSION['acquirer_descriptor'])) unset($_SESSION['acquirer_descriptor']);

if(isset($_SESSION['curl_values'])) unset($_SESSION['curl_values']);
if(isset($_SESSION['s30_count'])) unset($_SESSION['s30_count']); 
if(isset($_SESSION['3ds2_auth'])) unset($_SESSION['3ds2_auth']); 

$tr_upd_order_0=array();
$api_root=$data['Path']."/";

$otp_sample_url = "{$data['Host']}/test3dsecureauthentication".$data['ex']."?orderset=".$_SESSION['tr_orderset'].$ctest;
$process=$data['Host'].'/secure/process'.$data['ex']; 

// return_url to be use for success or failed pages 
$return_url = $data['Host']."/return_url{$file_v}{$data['ex']}?orderset=".$orderset."&action=status";

// return_url to be use for success or failed pages 
$trans_processing = $data['Host']."/trans_processing{$file_v}{$data['ex']}?orderset=".$orderset."&action=status";

// intent_process_url to be use for auth url  
$intent_process_url = $data['Host']."/intent_process{$file_v}{$data['ex']}?transID=".$transID."&action=authurl";

$indian_qr_url = $data['Host']."/payin/indian-qr{$data['ex']}?orderset=$orderset&orderId={$transID}&action=chart";

//dba common use and dba fetch of terminal & merchant via company_name in SESSION of info_data
$dba=$_SESSION['dba']=$_SESSION['info_data']['company_name'];



$hkipass=false;$hktrust=false;$ac_25=false;$fht_ac=false;$rebill_ac=false; 
$intent_process_redirect=0;$intent_process_include=0;

//echo "<hr/>_SESSION cardtype =>".$_SESSION['info_data']['cardtype']; echo "<hr/>_SESSION apJson acquirer final =>".$_SESSION["apJson".$acquirer]; exit;

if(isset($_GET['ctest'])){	
	$apJson['apJson_f']=$_SESSION["acquirer_processing_json".$acquirer];		
	trans_updatesf($_SESSION['tr_newid'], $apJson);
}

$browserOs1=browserOs("1"); $browserOs=json_encode($browserOs1);


$country_two=get_country_code($post['bill_country']);
$post['country_two']=$country_two;
$post['country_iso3']=get_country_code($post['bill_country'],3);





##### start: dynamic acquirer include for path of payin  ###############

if(isset($post['acquirer'])&&trim($post['acquirer']))$acquirer=$post['acquirer'];
elseif(isset($post['acquirer'])&&trim($post['acquirer']))$acquirer=$post['acquirer']; // after final will be remove line 

$acquirer_payin=$acquirer;

// Getting default acquirer from acquirer table 
if(isset($_SESSION['b_'.$acquirer]['default_acquirer'])&&trim($_SESSION['b_'.$acquirer]['default_acquirer'])){ 
	$acquirer_payin=$_SESSION['b_'.$acquirer]['default_acquirer'];
}



// set the common condition for acquirer wise Application programming interface 

if(isset($acquirer_payin)&&trim($acquirer_payin)&&$_SESSION['mode'.$acquirer]==1&&$testcardno==false&&$scrubbedstatus==false&&$_SESSION['b_'.$acquirer]['acquirer_status']==1){
	
##############################################################

	$tr_upd_order_0=array(); //function for update the master_trans_table
	

##############################################################

	//fetch bill curr 
	if($_SESSION['curr']){$orderCurrency=$_SESSION['curr'];}
	else{$orderCurrency= trim($_SESSION['currency'.$acquirer]);}

	$_SESSION['currency'.$acquirer]=$orderCurrency; // dynamic value for currency
	$_SESSION['total_payment']=$total_payment; // dynamic value for payment
	
	$orderCurrencySymbol=get_currency($orderCurrency);	//fetch currnecy symbol into session

##############################################################
	
	//form acquirer table for acquirer processing creds
	$apc_json=jsondecode($_SESSION['b_'.$acquirer]['acquirer_processing_creds'],1,1); //json value from backend
	//print_r($apc_json);exit;
	$apc_get=array();

	if($_SESSION['b_'.$acquirer]['acquirer_prod_mode']==2){ // this is for test mode trnasaction
		$apc_get=$apc_json['test'];
		$bank_url=$_SESSION['b_'.$acquirer]['acquirer_uat_url'];
		$apc_get['mode']='test';
	}else{
		$apc_get=$apc_json['live']; // this is for live mode transaction
		$bank_url=$_SESSION['b_'.$acquirer]['acquirer_prod_url'];
		$apc_get['mode']='live';
	}
	
	$tr_upd_order_0['acquirer_processing_creds']=$apc_get;
 
	
##############################################################
	
	//acquirer processing json from mer setting if live mode
	$apj=array(); 
	if($_SESSION['b_'.$acquirer]['acquirer_prod_mode']==1){
		if(isset($_SESSION['apJson'.$acquirer])&&$_SESSION['apJson'.$acquirer])
		{	
			$apj = jsondecode($_SESSION['apJson'.$acquirer]);	
			if(isset($apj)&&is_array($apj)){
				foreach($apj as $ke=>$va){
					if(trim($va)){
						$apc_get[$ke]=$va;
					}
				}
			}
		}
	}
	
	$tr_upd_order_0['acquirer_processing_json']=$apj;
	
##############################################################

	//fetch Acquirer Status URL & Acquirer Refund URL from acquirer table 
	
	// fetch Acquirer Status URL
	$acquirer_status_url=((isset($_SESSION['b_'.$acquirer]['acquirer_status_url'])&&trim($_SESSION['b_'.$acquirer]['acquirer_status_url']))?$_SESSION['b_'.$acquirer]['acquirer_status_url']:'');	
	
	// fetch Acquirer Refund URL
	$acquirer_refund_url= ((isset($_SESSION['b_'.$acquirer]['acquirer_refund_url'])&&trim($_SESSION['b_'.$acquirer]['acquirer_refund_url']))?$_SESSION['b_'.$acquirer]['acquirer_refund_url']:'');	

	if($acquirer_status_url) $tr_upd_order_0['acquirer_status_url']=$acquirer_status_url;

	if($acquirer_refund_url) $tr_upd_order_0['acquirer_refund_url']=$acquirer_refund_url;
	
	
##############################################################

	//$qrcode_ajax=0;
	$popup_msg_f=acquirer_popup_msg_f($transID);
	if(isset($popup_msg_f)&&$popup_msg_f&&strpos($popup_msg_f,'qrcodeadd')!==false){
		$qrcode_ajax=1;
	}

##############################################################
	
	//fetch Acquirer Whitelisting Domain from acquirer table
	
	if(isset($_SESSION['b_'.$acquirer]['acquirer_wl_domain'])&&trim($_SESSION['b_'.$acquirer]['acquirer_wl_domain'])){
		$acquirer_wl_domain=$_SESSION['b_'.$acquirer]['acquirer_wl_domain'];
	}else{
		$acquirer_wl_domain=$data['Host'];
	}


##############################################################

	$check_status="status{$data['ex']}?orderset=".$orderset."&action=redirect";
	$status_url=$acquirer_wl_domain."/".$check_status;
	
	//$bank_status=$acquirer_wl_domain."/"."bank_status{$data['ex']}";
	
##############################################################
	if(isset($_SESSION['select_mcc'])&&$_SESSION['select_mcc'])
	$select_mcc_code=$_SESSION['select_mcc'];
	else 
	$select_mcc_code='';

##############################################################
	
	$tr_upd_order_0['s30_count']			=4;
	$tr_upd_order_0['default_mid']			=$acquirer_payin;
	$tr_upd_order_0['host_'.$acquirer]		=$data['Host'];
	$tr_upd_order_0['status_'.$acquirer]	=$check_status;
	$tr_upd_order_0['status_url']			=$status_url;
	$tr_upd_order_0['bank_url'.$acquirer]	=$bank_url;
	$tr_upd_order_0['acquirer_logo']		=acquirer_logo_f($acquirer);
	
	if(isset($select_mcc_code)&&$select_mcc_code) 
		$tr_upd_order_0['select_mcc_code']	=$select_mcc_code;
	if(isset($qrcode_ajax)&&$qrcode_ajax==1)
		$tr_upd_order_0['qrcode_ajax']		='qrcodeadd';
	if(isset($_SERVER["HTTP_USER_AGENT"])&&$_SERVER["HTTP_USER_AGENT"]) 
		$tr_upd_order_0['HTTP_USER_AGENT']	=$_SERVER["HTTP_USER_AGENT"];
	
	trans_updatesf($_SESSION['tr_newid'],$tr_upd_order_0);
	
##############################################################





##########	PAYIN FILE PATH	#############################################
	
	$payin_file_path=($data['Path']."/payin/pay{$acquirer_payin}/acquirer_{$acquirer_payin}".$data['iex']);
	
	if(file_exists($payin_file_path)){
		include($payin_file_path);
	}else{echo "not exit file : ".$payin_file_path;exit;}
	
	

########  get for qr intent address from bank in urldecode #############

	if(isset($qr_intent_address)&&@$qr_intent_address){
		
		if(isMobileDevice()){
			//mobile base intent 
			if(isset($without_intent) && $without_intent==1) 
			{	
				$payment_url=urldecode(@$qr_intent_address);
				@$_SESSION['3ds2_auth']['payaddress']=(@$qr_intent_address);
				
			}else{
				@$intent_paymentUrl=(@$qr_intent_address);
				@$_SESSION['3ds2_auth']['payaddress']=(@$qr_intent_address);
			}
		}
		else{
			//web base qr-code
			$generate_qr_code=($qr_intent_address);
			
			//payaddress
			$web_base_qrcode=1;
			$_SESSION['3ds2_auth']['payaddress']=($qr_intent_address);
		}
	}

##########	android base intent	######################################

	if(isset($intent_paymentUrl) && !empty($intent_paymentUrl)) 
	{
		
		$intent_paymentUrl = urldecode($intent_paymentUrl);
		$tr_upd_order_111['qrUpi']=$intent_paymentUrl; 
		
		if(isset($without_intent_function) && $without_intent_function==1) 
		{
			
		}
		else {
			$intent_paymentUrl=intent_payment_url_f($intent_paymentUrl,$post['wallet_code_app'],1);
		}
		
		$data['intent_paymentUrl']=$intent_paymentUrl;
			$payment_url=urldecode($intent_paymentUrl);
		
		$tr_upd_order_111['pay_mode']='3D'; 
		$tr_upd_order_111['wallet_code_app_intent']=$post['wallet_code_app'];	
			
		$tr_upd_order_111['pay_url']=$intent_paymentUrl;	
		$tr_upd_order_111['intent_paymentUrl']=$intent_paymentUrl;
		$_SESSION['SA']['intent_acitve']=1;
		
		//payaddress
		$mobile_android_base_intent=1;
		$_SESSION['3ds2_auth']['payaddress']=$intent_paymentUrl;
		
		
		$tr_upd_order_111['intent_process_include']=$intent_process_include;
	}


#######	 redirect 3d url  ############################################

	if(isset($redirect_3d_url)&&$redirect_3d_url){
		$tr_upd_order_111['redirect_3d_url']=$redirect_3d_url;
		$tr_upd_order_111['auth_url']=$redirect_3d_url;
		$payment_url=$redirect_3d_url;
		authf($_SESSION['tr_newid'],$redirect_3d_url);
	}
	
#######	redirect url via folder of secure with process iframe 	#########

	elseif(isset($secure_process)&&$secure_process){
		$_SESSION['redirect_url']=$secure_process;
		$tr_upd_order_111['auth_url']=$secure_process;
		$tr_upd_order_111['secure_process']=$process;
		//$tr_upd_order_111['pay_root']='secure/process';
		$payment_url=$process;
		authf($_SESSION['tr_newid'],$secure_process);
	}
	
##########	qr & intent	######################################
	elseif(isset($_SESSION['3ds2_auth'])&&$_SESSION['3ds2_auth']){
		
		$_SESSION['3ds2_auth']['processed']	=$status_url;
		$_SESSION['3ds2_auth']['paytitle']	=$_SESSION['dba'];
		$_SESSION['3ds2_auth']['currname']	=$orderCurrency;
		$_SESSION['3ds2_auth']['payamt']	=$total_payment;
		
		$appName='UPI / APP / Wallet';
		if(isset($data['appName'])&&$data['appName']) $appName=$data['appName'];
		if(isset($post['wallet_code_app'])&&$post['wallet_code_app']) $appName=$post['wallet_code_app'];
		$_SESSION['3ds2_auth']['appName']	=$appName;

		$_SESSION['3ds2_auth']['bill_currency']=$_SESSION['bill_currency'];
		$_SESSION['3ds2_auth']['bill_amt']	=(isset($_SESSION['json_value']['post']['bill_amt'])&&trim($_SESSION['json_value']['post']['bill_amt'])?$_SESSION['json_value']['post']['bill_amt']:$total_payment);
		$_SESSION['3ds2_auth']['product_name']=$_SESSION['product'];
		
		if(isset($mobile_android_base_intent)&&$mobile_android_base_intent){
			$_SESSION['3ds2_auth']['os']		='mobile_android';
			$_SESSION['3ds2_auth']['mop']		='upi_intent';
			
			$payaddress=(isset($_SESSION['3ds2_auth']['payaddress'])&&$_SESSION['3ds2_auth']['payaddress']?$_SESSION['3ds2_auth']['payaddress']:'');
			
			$tr_upd_order_111['auth_url']=urldecode($payaddress);
			authf($_SESSION['tr_newid'],$payaddress,$_SESSION['3ds2_auth']);
		}
		elseif(isset($web_base_qrcode)&&$web_base_qrcode){
			$_SESSION['3ds2_auth']['os']		='web';
			$_SESSION['3ds2_auth']['mop']		='qrcode';
			
			$tr_upd_order_111['auth_url']=$indian_qr_url;
			authf($_SESSION['tr_newid'],$indian_qr_url,$_SESSION['3ds2_auth']);
			if(!isset($qrcode_ajax)) $process_url=$indian_qr_url;
			else $process_url = $trans_processing ;
		}
		$tr_upd_order_111['auth_data']=htmlentitiesf($_SESSION['3ds2_auth']);
		
		$_SESSION['acquirer_status_code']=1; // pending 
		
	}			
	
	
		
	$tr_upd_order_111['payment_url']=(isset($payment_url)?$payment_url:'');
	$tr_upd_order_111['process_url']=(isset($process_url)?$process_url:'');
	
	if(isset($tr_upd_order_111)&&$tr_upd_order_111){
		trans_updatesf($_SESSION['tr_newid'],$tr_upd_order_111);
	}
	
	
##############################################################
	
	$curl_values_arr['browserOsInfo']=$browserOs;	//save browser information for curl request
	$_SESSION['curl_values']=@$curl_values_arr;	//set curl values into into $_SESSION
	
##############################################################
	
	if($post['integration-type']=="s2s"){
		
	}else{
		
		if(isset($payment_url) && !empty($payment_url))
		{
			$_SESSION['acquirer_status_code']=1;
			$process_url=$payment_url; 
		}
		
		if(isset($post['actionajax'])&&$post['actionajax']=='ajaxIntentUrl'&&isset($_SESSION['3ds2_auth']['payaddress'])&&$_SESSION['3ds2_auth']['payaddress']){
				$generate_intent_url=$_SESSION['3ds2_auth']['payaddress'];
		}
		elseif(isset($qrcode_ajax)&&$qrcode_ajax==1&&isset($_SESSION['3ds2_auth']['payaddress'])&&$_SESSION['3ds2_auth']['payaddress']){
				$generate_qr_code=$_SESSION['3ds2_auth']['payaddress'];
		}
		
		
		if(isset($generate_intent_url) && !empty($generate_intent_url) && isset($post['actionajax']) && $post['actionajax']=='ajaxIntentUrl') {
			$generate_intent_url=urldecode($generate_intent_url);
			echo "<script>
				transID='$transID';
				var varTransID='$transID';
			</script>";
			echo "<a class=\"appOpenUrl nopopup suButton btn btn-icon btn-primary\" href=\"{$generate_intent_url}\" style=\"width:48%\" title=\"{$orderCurrencySymbol}{$total_payment} paying to {$dba} \" target=\"_blank\">Open</a> "; exit;
		}
		elseif(isset($generate_qr_code) && !empty($generate_qr_code) && isset($post['actionajax']) && $post['actionajax']=='ajaxQrCode') {
			echo "<script>
				//parent.window.transID='$transID';
				transID='$transID';
				var varTransID='$transID';
			</script>";
			echo "<img src=\"https://quickchart.io/chart?chs=150x150&cht=qr&chl={$generate_qr_code}&choe=UTF-8\" title=\"{$orderCurrencySymbol}{$total_payment} paying to {$dba} \" />";exit;
		}
		elseif(isset($intent_paymentUrl) && !empty($intent_paymentUrl) &&  isset($intent_process_redirect) && $intent_process_redirect==1) {
			header("Location:".trim($intent_process_url));
			exit();
		}elseif(isset($intent_paymentUrl) && !empty($intent_paymentUrl) &&  isset($intent_process_include) && $intent_process_include==1) {
			$data['config_root']=1;
			include($data['Path']."/intent_process".$data['iex']);
		}
		elseif(!empty($process_url)){	
			header("Location:".trim($process_url));
			exit();
		}
		else{
			$data['Error']=7004;
			$data['Message']="Missing url";
			error_print($data['Error'],$data['Message']);
		}
		exit;
	}
	
}

##### end: dynamic acquirer include for path of payin  ###############




//test_response
$test_response=false; $test_process_url="";
if($scrubbedstatus==true){
	$test_response=true;
	if($scrubbed_msg){
		$scrubbed_msg=urlencode($scrubbed_msg);
	}
	$orderset=$_SESSION['tr_orderset'];
	$test_process_url = $return_url.$ctest; 
	//header("location:$test_process_url");exit;
}elseif(($card_type=='2D'||$card_type=='3D')&&($post['integration-type']=='Encode-Checkout'||$post['integration-type']==strtolower('encode-checkout'))&&($scrubbedstatus==false&&$acquirer=='')){ // otp
	$test_response=true;
	$test_process_url=$otp_sample_url;
}elseif($testcardno==true){ // success
	$test_response=true;
	$orderset=$_SESSION['tr_orderset'];
	$test_process_url = $return_url.$ctest; 
}

//s2s 2d
if($test_response==true&&$test_process_url){
	
	$data_send=array();
	$data_send['orderset']=$orderset;
	$data_send['acquirer_action']=1;
	
	if((isset($_GET['ctest']))){
		$data_send['ctest']=$_GET['ctest'];
	}

	if($post['integration-type']=="s2s"){
		if($card_type=='2D'||$card_type=='3D'){
			$auth_otp=[];
			//$auth_otp['Error']="7001";
			$auth_otp['transID']=$_SESSION['transID'];
			$auth_otp['authurl']=$data['Host']."/authurl".$data['ex']."?transID=".$_SESSION['transID'];
			json_print($auth_otp);
			exit;
		}else{
			$_POST['transID']=$_SESSION['transID'];
			//$use_curl=use_curl($test_process_url,$data_send);
			//exit;
		}
	}else{
		header("Location:$test_process_url"); 
		//exit;
	}
}
?>