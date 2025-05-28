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
//if(isset($_SESSION['customer_service_email'])) unset($_SESSION['customer_service_email']); 

//Set acquirer descriptor from acquirer table 
if(isset($_SESSION['b_'.$acquirer]['acquirer_descriptor'])&&trim($_SESSION['b_'.$acquirer]['acquirer_descriptor']))
$_SESSION['acquirer_descriptor']=@$_SESSION['b_'.$acquirer]['acquirer_descriptor'];


$tr_upd_order_0=array();
$api_root=$data['Path']."/";



//url 

$process=$data['Host'].'/secure/process'.$data['ex']."?transID=".$transID; 

	$auth_3ds2=$data['Host'].'/secure/auth_3ds2'.$data['ex']."?transID=".$transID; 

$secure_process_3d=$data['Host'].'/secure/secure_process'.$data['ex']."?transID=".$transID; 




//Dev Tech : 25-02-04 encrypted transID & public_key via &key= in authurl 
//Dev Tech: 25-05-03 authurl key param encryption if encryption_method is aes256
if((isset($data['ENCRYPTED_TRANSID_ENABLE'])&&@$data['ENCRYPTED_TRANSID_ENABLE']=='Y')||(isset($post['encryption_method'])&&strtolower($post['encryption_method'])=='aes256'))
{
	$transID_json='{"transID":"'.@$transID.'","public_key":"'.@$_SESSION['re_post']['public_key'].'"}';
	$encrypted_transID=encode64f($transID_json);
	$authurl=$data['Host']."/authurl".$data['ex']."?key=".$encrypted_transID;
	$otp_sample_url = "{$data['Host']}/test3dsecureauthentication".$data['ex']."?key=".$encrypted_transID.$ctest;
} 
else 
{
	$authurl=$data['Host']."/authurl{$data['ex']}?transID=".$transID;
	$otp_sample_url = "{$data['Host']}/test3dsecureauthentication".$data['ex']."?transID=".$transID.$ctest;
}


// return_url to be use for success or failed pages 
$return_url = $data['Host']."/return_url{$file_v}{$data['ex']}?transID=".$transID."&action=redirect";

// Pending url for trans_processing to be use for pending 
$trans_processing = $data['Host']."/trans_processing{$file_v}{$data['ex']}?transID=".$transID."&action=status";

// intent_process_url to be use for auth url  
$intent_process_url = $data['Host']."/intent_process{$file_v}{$data['ex']}?transID=".$transID."&action=authurl";

$indian_qr_url = $data['Host']."/payin/indian-qr{$data['ex']}?transID={$transID}&orderId={$transID}&action=chart";

//qr_code show for TetherCoins, BitsCoins via auth
$chart_url = $data['Host']."/payin/chart{$data['ex']}?transID=".$transID;

//only qr_code get for TetherCoins, BitsCoins on checkout page 
$chart_qr_code_url = $data['Host']."/payin/chart_qr_code{$data['ex']}?transID=".$transID;

$qr_code_url = $data['Host']."/payin/qr_code{$data['ex']}?transID=".$transID;

$status_url_1=$data['Host']."/status{$data['ex']}?transID=".$transID;


//dba common use and dba fetch of terminal & merchant via company_name in SESSION of info_data
$dba=$_SESSION['dba']=$_SESSION['info_data']['company_name'];



$hkipass=false;$hktrust=false;$ac_25=false;$fht_ac=false;$rebill_ac=false; 
$intent_process_redirect=0;$intent_process_include=0;$qr_process_base64=0;

//echo "<hr/>_SESSION cardtype =>".$_SESSION['info_data']['cardtype']; echo "<hr/>_SESSION apJson acquirer final =>".$_SESSION["apJson".$acquirer]; exit;

if(isset($_GET['ctest'])){	
	$apJson['apJson_f']=$_SESSION["acquirer_processing_json".$acquirer];		
	trans_updatesf($_SESSION['tr_newid'], $apJson);
}

$browserOs1=browserOs("1"); $browserOs=json_encode($browserOs1);


$country_two=get_country_code(@$post['bill_country']);
$post['country_two']=$country_two;
$post['country_iso3']=get_country_code(@$post['bill_country'],3);


##### start: dynamic acquirer include for path of payin  ###############

//check if 1 is Direct (Curl Option) 
$connection_method=@$_SESSION['b_'.$acquirer]['connection_method'];

if(isset($post['acquirer'])&&trim($post['acquirer']))$acquirer=$post['acquirer'];
elseif(isset($post['acquirer'])&&trim($post['acquirer']))$acquirer=$post['acquirer']; // after final will be remove line 

$acquirer_payin=$acquirer;

// Getting default acquirer from acquirer table 
if(isset($_SESSION['b_'.$acquirer]['default_acquirer'])&&trim($_SESSION['b_'.$acquirer]['default_acquirer'])){ 
	$acquirer_payin=$_SESSION['b_'.$acquirer]['default_acquirer'];
}


########  java script call for 2,3d, qr,intent,collect #############
$reference=@$_REQUEST['reference'];
$opener_transID="<script>var transID='$transID'; var varTransID='$transID'; var varReferenceNo='$reference'; var trans_auto_expired=$set_trans_auto_expired; if (window.opener && window.opener.document) { opener.transID='$transID'; opener.varTransID='$transID'; opener.varReferenceNo='$reference'; opener.trans_auto_expired=$set_trans_auto_expired; } </script>";

$opener_script=$_SESSION['opener_script']=$opener_transID."<script> if (window.opener && window.opener.document) { opener.pendingCheckStartf();} </script>";



// set the common condition for acquirer wise Application programming interface 

if(isset($acquirer_payin)&&trim($acquirer_payin)&&@$_SESSION['mode'.$acquirer]==1&&$testcardno==false&&$scrubbedstatus==false&&$_SESSION['b_'.$acquirer]['acquirer_status']==1)
{
	
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
		$apc_get=(isset($apc_json['test'])?$apc_json['test']:$apc_json);
		$bank_url=$_SESSION['b_'.$acquirer]['acquirer_uat_url'];
		$apc_get['mode']='test';
	}else{
		$apc_get=(isset($apc_json['live'])?$apc_json['live']:$apc_json); // this is for live mode transaction
		$bank_url=$_SESSION['b_'.$acquirer]['acquirer_prod_url'];
		$apc_get['mode']='live';
	}
	
	$tr_upd_order_0['acquirer_processing_creds']=($apc_get);
	
	
	


	##############################################################
	
	//acquirer processing json from mer setting if live mode
	$apj=array(); 
	if($_SESSION['b_'.$acquirer]['acquirer_prod_mode']==1){
		if(isset($_SESSION['apJson'.$acquirer])&&$_SESSION['apJson'.$acquirer])
		{	
			$apj = jsondecode($_SESSION['apJson'.$acquirer],1,1);	
			if(isset($apj)&&is_array($apj)){
				foreach($apj as $ke=>$va){
					if(isset($va)&&is_array($va)&&is_string($ke)){
						$apc_get[$ke]=json_encode($va);
					}
					elseif(isset($va)&&is_string($va)&&is_string($ke)){
						$apc_get[$ke]=$va;
					}
				}
			}
		}
	}
	
	$tr_upd_order_0['acquirer_processing_json']=$apj;
	//$tr_upd_order_0=array_merge($tr_upd_order_0,$apj);
	
	$apc_get_en = jsonencode($apc_get);	
	$apc_get = jsondecode($apc_get_en,1,1);	
	
	
	
	##############################################################


	//fetch Acquirer Status URL & Acquirer Refund URL from acquirer table 
	
	// fetch Acquirer Trans auto expired (if 0 or null than default 5 minutes) for Status 
	$trans_auto_expired=((isset($_SESSION['b_'.$acquirer]['trans_auto_expired'])&&trim($_SESSION['b_'.$acquirer]['trans_auto_expired']))?$_SESSION['b_'.$acquirer]['trans_auto_expired']:'5');
	
	$set_trans_auto_expired = (59978.53333333333 * (int)$trans_auto_expired); 
	
	// fetch Acquirer Status URL
	$acquirer_status_url=((isset($_SESSION['b_'.$acquirer]['acquirer_status_url'])&&trim($_SESSION['b_'.$acquirer]['acquirer_status_url']))?$_SESSION['b_'.$acquirer]['acquirer_status_url']:'');	
	
	// fetch Acquirer Refund URL
	$acquirer_refund_url= ((isset($_SESSION['b_'.$acquirer]['acquirer_refund_url'])&&trim($_SESSION['b_'.$acquirer]['acquirer_refund_url']))?$_SESSION['b_'.$acquirer]['acquirer_refund_url']:'');	

	if($acquirer_status_url) $tr_upd_order_0['acquirer_status_url']=$acquirer_status_url;

	if($acquirer_refund_url) $tr_upd_order_0['acquirer_refund_url']=$acquirer_refund_url;
	
	
	##############################################################


	//acquirer_creds_processing_final
	db_trf($_SESSION['tr_newid'], 'acquirer_creds_processing_final', $apc_get);
 
 
	##############################################################

	//$qrcode_ajax=0;
	$popup_msg_f=acquirer_popup_msg_f($acquirer);
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

	//default acquirer wise file like acquirer_112.do 
	$acquirer_payin_file=$acquirer_payin;

	//version wise default acquirer from json key is {"v":"2"} like acquirer_112_v2.do
	if(isset($apc_get['v'])&&!empty($apc_get['v'])&&trim($apc_get['v'])) 
	$acquirer_payin_file="{$acquirer_payin}_v".@$apc_get['v'];
	

	###### //url ##################################################

	$success_url=$acquirer_wl_domain."/success_url{$data['ex']}";
	$success_url_1=$acquirer_wl_domain."/success_url{$data['ex']}?transID=".$transID;
	$success_url_2=($acquirer_wl_domain."/payin/pay{$acquirer_payin}/success_url_{$acquirer_payin_file}".$data['ex']);
	$success_url_3=($acquirer_wl_domain."/payin/pay{$acquirer_payin}/success_url_{$acquirer_payin_file}".$data['ex']."?transID=".$transID);
	

	$fail_url=$acquirer_wl_domain."/fail_url{$data['ex']}";
	$fail_url_1=$acquirer_wl_domain."/fail_url{$data['ex']}?transID=".$transID;
	$fail_url_2=($acquirer_wl_domain."/payin/pay{$acquirer_payin}/fail_url_{$acquirer_payin_file}".$data['ex']);
	$fail_url_3=($acquirer_wl_domain."/payin/pay{$acquirer_payin}/fail_url_{$acquirer_payin_file}".$data['ex']."?transID=".$transID);



	$check_status="status{$data['ex']}?transID=".$transID."&action=redirect";
	
	$status_url=$acquirer_wl_domain."/".$check_status;
	
	$status_url_1=$acquirer_wl_domain."/status{$data['ex']}?transID=".$transID;
	
	$status_default_url=$acquirer_wl_domain."/payin/pay{$acquirer_payin}/status_{$acquirer_payin_file}".$data['ex']."?transID=".$transID;
	
	$webhook_url=($acquirer_wl_domain."/payin/pay{$acquirer_payin}/handler_{$acquirer_payin_file}".$data['ex']."?transID=".$transID."&action=webhook");
	
	$webhookhandler=($acquirer_wl_domain."/payin/pay{$acquirer_payin}/webhookhandler_{$acquirer_payin_file}".$data['ex']);
	
	$webhookhandler_url=($acquirer_wl_domain."/payin/pay{$acquirer_payin}/webhookhandler_{$acquirer_payin_file}".$data['ex']."?transID=".$transID);
	
	$reprocess_url=($acquirer_wl_domain."/payin/pay{$acquirer_payin}/reprocess_{$acquirer_payin_file}".$data['ex']."?transID=".$transID);
	
	//$bank_status=$acquirer_wl_domain."/"."bank_status{$data['ex']}";
	

	##############################################################

	// digi50 match in Bank url than enable postApiEnable
	if(isset($popup_msg_f)&&@$popup_msg_f&&(preg_match('/digi50.one|digi51.one|s2sApi/', $popup_msg_f)))
	{
		$postApiEnable='Y';
		$tr_upd_order_0['postApiEnable']=$postApiEnable;
	}

	// array for post api like digi50
	$postApiArray=array();

	$source_url_postApi=isset($_SERVER["HTTPS"])?'https://':'http://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI']; 

	//$postApiArray["public_key"]=$bank_public_key;
	//$postApiArray["terNO"]=$bank_terNO;

	if(isset($post['mop'])&&$post['mop']) $postApiArray["mop"] = $post['mop'];

	$postApiArray["integration-type"]=@$post['integration-type'];
	$postApiArray["bill_ip"]=@$_SESSION['bill_ip'];
	$postApiArray["source_url"]=@$source_url_postApi;
		
	$postApiArray["bill_amt"]=@$post['bill_amt'];
	$postApiArray["bill_currency"]=@$post['bill_currency'];
		
	$postApiArray["trans_amt"]=$total_payment;
	$postApiArray["trans_currency"]=$orderCurrency;

	$postApiArray["product_name"]=@$post['product_name'];
		$postApiArray["dba"]=@$dba;

	$postApiArray["fullname"]=@$post['fullname'];
	$postApiArray["bill_email"]=@$post['bill_email'];

	$postApiArray["bill_address"]=@$post['bill_address'];
	$postApiArray["bill_city"]=@$post['bill_city'];
	$postApiArray["bill_state"]=@$post['bill_state'];
	$postApiArray["bill_country"]=@$post['bill_country'];
	$postApiArray["bill_zip"]=@$post['bill_zip'];


	$postApiArray["bill_phone"]=@$post['bill_phone'];
	$postApiArray["transID"]=@$_SESSION['transID'];
	//$postApiArray["reference"]=$_SESSION['transID'];
	//$postApiArray["unique_reference"]='Y'; 
	$postApiArray["webhook_url"]=$webhookhandler_url;
	$postApiArray["return_url"]=$status_url_1;

	/*
	$postApiArray['ccno']=$post['ccno'];
	$postApiArray['ccvv']=$post['ccvv'];
	$postApiArray['month']=$post['month'];
	$postApiArray['year']=$post['year'];
	//$postApiArray['year']=$post['year4'];

	*/

	//Send to acquirer_creds_processing via 64 encode method 
	$postApi["postApiKey"]=encode64f($apc_get_en);

	$postApi["acquirer"]=$acquirer; // current acquirer
	$postApi["default_acquirer"]=$acquirer_payin; // default acquirer

	if(isset($apc_get['v'])&&!empty($apc_get['v'])&&trim($apc_get['v'])) 
	$postApi["acquirer_payin_file"]=$acquirer_payin_file; // version wise default acquirer





	##############################################################
	if(isset($_SESSION['select_mcc'])&&$_SESSION['select_mcc'])
	$select_mcc_code=$_SESSION['select_mcc'];
	else 
	$select_mcc_code='';

	##############################################################
	
	$tr_upd_order_0['s30_count']			=4;
	$tr_upd_order_0['default_mid']			=$acquirer_payin;

	if(isset($encrypted_transID)&&@$encrypted_transID)
	$tr_upd_order_0['encrypted_transID']	=$encrypted_transID;

	if(isset($apc_get['v'])&&!empty($apc_get['v'])&&trim($apc_get['v'])) 
	$tr_upd_order_0["acquirer_payin_file"]=$acquirer_payin_file; // version wise default acquirer

	$tr_upd_order_0['host_'.$acquirer]		=$data['Host'];
	$tr_upd_order_0['status_'.$acquirer]	=$check_status;
	$tr_upd_order_0['status_url']			=$status_url;
	$tr_upd_order_0['bank_url'.$acquirer]	=$bank_url;
	$tr_upd_order_0['acquirer_logo']		=acquirer_logo_f($acquirer);
	$tr_upd_order_0['trans_auto_expired']	=((isset($_SESSION['b_'.$acquirer]['trans_auto_expired'])&&trim($_SESSION['b_'.$acquirer]['trans_auto_expired']))?$_SESSION['b_'.$acquirer]['trans_auto_expired']:'');	
	
	
	if(isset($select_mcc_code)&&$select_mcc_code) 
		$tr_upd_order_0['select_mcc_code']	=$select_mcc_code;
	if(isset($qrcode_ajax)&&$qrcode_ajax==1)
		$tr_upd_order_0['qrcode_ajax']		='qrcodeadd';
	if(isset($_SERVER["HTTP_USER_AGENT"])&&$_SERVER["HTTP_USER_AGENT"]) 
		$tr_upd_order_0['HTTP_USER_AGENT']	=$_SERVER["HTTP_USER_AGENT"];
	
	trans_updatesf($_SESSION['tr_newid'],$tr_upd_order_0);
	
	##############################################################

	




	##########	PAYIN FILE PATH	###################################

	
	//default acquirer 
	$payin_file_path=($data['Path']."/payin/pay{$acquirer_payin}/acquirer_{$acquirer_payin_file}".$data['iex']);
	
	if(file_exists($payin_file_path)){
		include($payin_file_path);
	}else{echo "not exit file : ".$payin_file_path;exit;}
	
	


	########  skip the status for acquirer via check_acquirer_status_in_realtime is f #############

	if(isset($json_arr_set['check_acquirer_status_in_realtime'])&&$json_arr_set['check_acquirer_status_in_realtime']=='SKIP_STATUS') { // no need to check status on checkout page for stop status check 
		$opener_script=$_SESSION['opener_script']=$opener_script."<script> var check_acquirer_status_in_realtime='SKIP';  if (window.opener && window.opener.document) { opener.check_acquirer_status_in_realtime='SKIP'; opener.clearIntervalf(); opener.clearIntervalf_status(); clearIntervalf_status(); } </script>";
	}

	elseif(isset($json_arr_set['check_acquirer_status_in_realtime'])&&$json_arr_set['check_acquirer_status_in_realtime']=='ALL') { 
		$opener_script=$_SESSION['opener_script']=$opener_script."<script> var check_acquirer_status_in_realtime='ALL';  if (window.opener && window.opener.document) { opener.check_acquirer_status_in_realtime='ALL'; opener.clearIntervalf(); opener.clearIntervalf2(); clearIntervalf2(); } </script>";
	}

	elseif(isset($json_arr_set['check_acquirer_status_in_realtime'])&&$json_arr_set['check_acquirer_status_in_realtime']) {
		$opener_script=$_SESSION['opener_script']=$opener_script."<script> var check_acquirer_status_in_realtime='f';  if (window.opener && window.opener.document) { opener.check_acquirer_status_in_realtime='f'; } </script>";
	}

	########  check UPICOLLECT from json_arr_set #############

	if(isset($json_arr_set['UPICOLLECT'])&&$json_arr_set['UPICOLLECT']) {
		$post['actionajax']='ajaxJsonArray';
	}

	########  save Acquirer Redirect Popup Msg in json value of trans  #############

	if(isset($popup_msg_f)&&@$popup_msg_f){
		$tr_upd_order_111['acquirer_redirect_popup_msg']=@$popup_msg_f;
	}

	######## Dev Tech: 24-01-13 If re-again post or error or null than retry to max as per value of re_post_less_than_step #############

	if(isset($re_post_less_than_step)&&$re_post_less_than_step>0)
	{
		if(!isset($_SESSION['json_value']['post']['countPost']))
			$_SESSION['json_value']['post']['countPost']=0;
		
		$_SESSION['json_value']['countPost']=$re_post_less_than_step;
		$_SESSION['json_value']['post']['countPost']++;
		
		$tr_upd_order_111['countPost']=$_SESSION['json_value']['post']['countPost'];
		if(isset($errorMsg))$tr_upd_order_111['errorMsg']=$errorMsg;
		trans_updatesf($_SESSION['tr_newid'],$tr_upd_order_111);
		
		
		if(isset($_SESSION['transID'])&&!empty($_SESSION['transID'])&&isset($_SESSION['json_value']['post']['countPost'])&&$_SESSION['json_value']['post']['countPost']<$re_post_less_than_step){
			$integration_type=$_SESSION['re_post']['integration-type'];
			if(isset($_SESSION['re_post']['integration-type'])&&$_SESSION['re_post']['integration-type']=='s2s')
				$re_post_url=$data['Host'].'/directapi'.$data['ex']; 
			else
				$re_post_url=$data['Host'].'/checkout'.$data['ex']; 
			
			
			//echo "<br/>re_post_url=>".$re_post_url; echo "<br/>re_post=>"; print_r($_SESSION['re_post']); exit;
			
			//post_redirect($re_post_url, $_SESSION['re_post']); exit;
			
			$dataPost_step=json_encode(@$_SESSION['re_post']);
					
			echo "
			<script>
				function redirect_payin_post_f2(url, data) {
					var form = document.createElement('form');
					document.body.appendChild(form);
					form.method = 'post';
					form.target = '_top';
					form.action = url;
					for (var name in data) {
						var input = document.createElement('input');
						input.type = 'hidden';
						input.name = name;
						input.value = data[name];
						form.appendChild(input);
					}
					form.submit();
				}
				
				var re_post_url='$re_post_url';
				var dataPost_step=$dataPost_step;
				setTimeout(function(){ 
					redirect_payin_post_f2(re_post_url,dataPost_step);
				}, 2000);
		
			</script>
			";
			
			
		}
		
	}
	
	
	
	########  get for qr intent address from bank in urldecode #############

	if(isset($qr_intent_address)&&@$qr_intent_address)
	{
		
		//	isMobileDevice	| isMobileBrowser
		if(isMobileDevice()) 
		{
			//mobile base intent 
			if(isset($without_intent) && $without_intent==1) 
			{	
				$payment_url=urldecodef(@$qr_intent_address);
				@$_SESSION['3ds2_auth']['payaddress']=(@$qr_intent_address);
				
			}else{
				@$intent_paymentUrl=(@$qr_intent_address);
				@$_SESSION['3ds2_auth']['payaddress']=(@$qr_intent_address);
			}
		}
		else{
			//web base qr-code
			$generate_qr_code=$qr_intent_address;
			
			//Dev Tech: 23-09-12 Remove space and new line and tab 
			$generate_qr_code = preg_replace('~[\r\n\t]+~', '', $generate_qr_code);	
			$generate_qr_code = str_replace(' ', '+', $generate_qr_code);	
			
			//payaddress
			$web_base_qrcode=1;
			$_SESSION['3ds2_auth']['payaddress']=($qr_intent_address);
			
		}
	}

	##########	android & ios base intent	#############################

	if(isset($intent_paymentUrl) && !empty($intent_paymentUrl)) 
	{
		
		$intent_paymentUrl = urldecodef($intent_paymentUrl);
		$tr_upd_order_111['qrUpi']=$intent_paymentUrl; 
		
		if(isset($without_intent_function) && $without_intent_function==1) 
		{
			
		}
		else {
			
			if(isset($_REQUEST['actionajax'])&&trim($_REQUEST['actionajax'])&&($_REQUEST['actionajax']=='ajaxIntentArrayUrl')){
				
				$json_arr_set=$_SESSION['json_arr_setUrl']=intent_payment_array_url_f($intent_paymentUrl,'',1);
				
				$intent_paymentUrl=$json_arr_set['otherApps'];
			}
			else 
			{
				$wallet_code_app=@$post['wallet_code_app'];
				$intent_paymentUrl=intent_payment_url_f($intent_paymentUrl,$wallet_code_app,1);
			}
		}
		
		$data['intent_paymentUrl']=$intent_paymentUrl;
		$_SESSION['intent_paymentUrl']=$intent_paymentUrl;
		
		if(isset($intent_paymentUrl)&&is_string($intent_paymentUrl))
			$payment_url=urldecodef($intent_paymentUrl);
		
		$tr_upd_order_111['pay_mode']='3D'; 
		$tr_upd_order_111['wallet_code_app_intent']=@$post['wallet_code_app'];	
			
		$tr_upd_order_111['pay_url']=$intent_paymentUrl;	
		$tr_upd_order_111['intent_paymentUrl']=$intent_paymentUrl;
		$_SESSION['SA']['intent_acitve']=1;
		
		//payaddress
		$mobile_android_base_intent=1;
		$_SESSION['3ds2_auth']['payaddress']=$intent_paymentUrl;
		
		
		$tr_upd_order_111['intent_process_include']=$intent_process_include;
	}

	##########	only web base qr_code generate for international like tetherCoins scanqr #################

	if(isset($web_base_qrcode_international)&&$web_base_qrcode_international){
		
		$_SESSION['3ds2_auth']['payaddress']=@$web_base_qrcode_international;
		$payment_url = $indian_qr_url = $qr_code_url ;
		$web_base_qrcode=1;
		$qrcode_ajax=1;
		
	}

	#######	 redirect 3d url  ###################################

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
	
	#######	redirect url via folder of secure with auth_3ds2 #########

	elseif(isset($auth_3ds2_secure)&&$auth_3ds2_secure){
		
		if(isset($auth_3ds2_base64)&&$auth_3ds2_base64)
			$_SESSION['3ds2_auth']['base64']='base64_decode';
		if(isset($auth_3ds2_action)&&$auth_3ds2_action)
			$_SESSION['3ds2_auth']['action']=$auth_3ds2_action; // redirect | 
		if(isset($json_arr_set['check_acquirer_status_in_realtime'])&&$json_arr_set['check_acquirer_status_in_realtime'])
			$_SESSION['3ds2_auth']['check_acquirer_status_in_realtime']=$json_arr_set['check_acquirer_status_in_realtime']; //skip the status for acquirer
		
		
		if(isset($popup_msg_f)&&$popup_msg_f&&preg_match("/(redirect|newtab)/i", $popup_msg_f)){
			// skip the json array and go to redirect on new browser tab 
			$payment_url=$auth_3ds2;
			$tr_upd_order_111['action_type']=@$popup_msg_f;
		}
		else {
			// go to via ajaxFormf as json array set
			if(!isset($post['actionajax'])) $post['actionajax']='ajaxJsonArray';
			$json_arr_set['auth_3ds2']=$auth_3ds2;
			$tr_upd_order_111['action_type']=$post['actionajax'];
		}
		
		// save auth data for run via authurl
		$_SESSION['3ds2_auth']['payaddress']=$auth_3ds2_secure;
		$tr_upd_order_111['auth_url']=$auth_3ds2;

		// auth_data not save in json if auth_data_not_save is 1
		if(isset($auth_data_not_save)&&@$auth_data_not_save==1) $tr_upd_order_111['auth_data_not_save']='Y';
		else  $tr_upd_order_111['auth_data']=$auth_3ds2_secure;

		$tr_upd_order_111['authurl']=$authurl;
		//$tr_upd_order_111['pay_root']='secure/auth_3ds2';
		
		authf($_SESSION['tr_newid'],$auth_3ds2,$_SESSION['3ds2_auth']);
	}
	
	##########	qr & intent	######################################
	elseif(isset($_SESSION['3ds2_auth'])&&$_SESSION['3ds2_auth']){
		
		$_SESSION['3ds2_auth']['processed']	=$status_url;
		if(!isset($_SESSION['3ds2_auth']['paytitle'])) $_SESSION['3ds2_auth']['paytitle']	=$_SESSION['dba'];
		$_SESSION['3ds2_auth']['currname']	=$orderCurrency;
		$_SESSION['3ds2_auth']['payamt']	=$total_payment;
		if($tr_upd_order_0['trans_auto_expired']>0)
		$_SESSION['3ds2_auth']['auto_expired']=$tr_upd_order_0['trans_auto_expired'];
		
		//$appName='UPI / APP / Wallet';
		$appName=@$_SESSION['dba'];
		if(isset($data['appName'])&&$data['appName']) $appName=$data['appName'];
		if(isset($post['wallet_code_app'])&&$post['wallet_code_app']) $appName=$post['wallet_code_app'];
		if(!isset($_SESSION['3ds2_auth']['appName'])) $_SESSION['3ds2_auth']['appName']	=$appName;

		$_SESSION['3ds2_auth']['bill_currency']=$_SESSION['bill_currency'];
		$_SESSION['3ds2_auth']['bill_amt']	=(isset($_SESSION['bill_amt'])&&trim($_SESSION['bill_amt'])?$_SESSION['bill_amt']:$total_payment);
		$_SESSION['3ds2_auth']['product_name']=$_SESSION['product'];
		
		if(isset($mobile_android_base_intent)&&$mobile_android_base_intent){
			if(isset($data['os_device'])&&$data['os_device'])
			$_SESSION['3ds2_auth']['os']		=$data['os_device'];
			else $_SESSION['3ds2_auth']['os']	='mobile_android';
			$_SESSION['3ds2_auth']['mop']		='upi_intent';
			
			$payaddress=(isset($_SESSION['3ds2_auth']['payaddress'])&&$_SESSION['3ds2_auth']['payaddress']?$_SESSION['3ds2_auth']['payaddress']:'');
			
			if(isset($payaddress)&&is_string($payaddress)) {
				$tr_upd_order_111['auth_url']=urldecodef($payaddress);
				authf($_SESSION['tr_newid'],$payaddress,$_SESSION['3ds2_auth']);
			}
		}
		elseif(isset($web_base_qrcode)&&$web_base_qrcode){
			$_SESSION['3ds2_auth']['os']		='web';
			$_SESSION['3ds2_auth']['mop']		='qrcode';
			
			if(isset($qr_process_base64)&&$qr_process_base64==1)
			$_SESSION['3ds2_auth']['qrcode_base']='base64';
		
			$tr_upd_order_111['auth_url']=$indian_qr_url;
			authf($_SESSION['tr_newid'],$indian_qr_url,$_SESSION['3ds2_auth']);
			if(!isset($qrcode_ajax)) $process_url=$indian_qr_url;
			else $process_url = $trans_processing ;
		}
		$tr_upd_order_111['auth_data']=htmlentitiesf($_SESSION['3ds2_auth']);
		
		$_SESSION['acquirer_status_code']=1; // pending 
		
	}			
	
	//cmn
	if($data['cqp']==6)
	{
		echo "<br/>auth_3ds2_secure=>".@$auth_3ds2_secure;
		echo "<br/>auth_3ds2=>".@$auth_3ds2;
		echo "<br/>3ds2_auth=>"; print_r($_SESSION['3ds2_auth']);
		exit;
	}
	
	$instance_private_ip = gethostbyname(gethostname());
	$tr_upd_order_111['instance_private_ip']=$instance_private_ip;

	$tr_upd_order_111['payment_url']=(isset($payment_url)?$payment_url:'');
	$tr_upd_order_111['payment_url']=(isset($payment_url)?$payment_url:'');
	$tr_upd_order_111['process_url']=(isset($process_url)?$process_url:'');
	
	if(isset($_SESSION['acquirer_status_code']) && !empty($_SESSION['acquirer_status_code']))
		$tr_upd_order_111['acquirer_status_code']=@$_SESSION['acquirer_status_code'];
	if(isset($_SESSION['acquirer_response']) && !empty($_SESSION['acquirer_response']))
		$tr_upd_order_111['acquirer_response']=@$_SESSION['acquirer_response'];
	if(isset($_SESSION['acquirer_transaction_id']) && !empty($_SESSION['acquirer_transaction_id']))
		$tr_upd_order_111['acquirer_transaction_id']=@$_SESSION['acquirer_transaction_id'];
	if(isset($_SESSION['acquirer_descriptor']) && !empty($_SESSION['acquirer_descriptor']))
		$tr_upd_order_111['acquirer_descriptor']=@$_SESSION['acquirer_descriptor'];
	
	
	
	if(isset($tr_upd_order_111)&&$tr_upd_order_111){
		trans_updatesf($_SESSION['tr_newid'],$tr_upd_order_111);
	}

	##############################################################
	
	if(isset($browserOs)&&$browserOs) $curl_values_arr['browserOsInfo']=@$browserOs;	//save browser information for curl request
	if(isset($curl_values_arr)&&$curl_values_arr) $_SESSION['curl_values']=@$curl_values_arr;	//set curl values into into $_SESSION
	
	##############################################################
	
	if($post['integration-type']=="s2s"){
		//include("success_curl".$data['iex']);
	}else{
		
		if(isset($payment_url) && !empty($payment_url))
		{
			$_SESSION['acquirer_status_code']=1;
			$process_url=$payment_url; 
		}
		
		if(isset($post['actionajax'])&&($post['actionajax']=='ajaxIntentUrl'||$post['actionajax']=='ajaxIntentArrayUrl')&&isset($_SESSION['3ds2_auth']['payaddress'])&&$_SESSION['3ds2_auth']['payaddress']){
				$generate_intent_url=$_SESSION['3ds2_auth']['payaddress'];
		}
		elseif(isset($qrcode_ajax)&&$qrcode_ajax==1&&isset($_SESSION['3ds2_auth']['payaddress'])&&$_SESSION['3ds2_auth']['payaddress']){
				$generate_qr_code=$_SESSION['3ds2_auth']['payaddress'];
		}
		
		
		
		
		
		if(isset($json_arr_set) && !empty($json_arr_set) && is_array($json_arr_set) && isset($post['actionajax']) && ( $post['actionajax']=='ajaxIntentArrayUrl' || $post['actionajax']=='ajaxJsonArray' ) ) {
			//$json_arr_set['html_data']=''; for pass bt in Channel is 11 or other html response 
			$json_arr_res=@$json_arr_set;
			$json_arr_res['DONE_AJAX']='DONE_AJAX';
			$json_arr_res['transID']=@$transID;
			$json_arr_res['varTransID']=@$transID;
			$json_arr_res['varReferenceNo']=@$reference;
			$json_arr_res['trans_auto_expired']=@$set_trans_auto_expired;
			
			$_SESSION['json_arr_res']=$json_arr_res;
			
			jsonen($json_arr_res);
			
		}
		elseif(isset($generate_intent_url) && !empty($generate_intent_url) && is_string($generate_intent_url) && isset($post['actionajax']) && $post['actionajax']=='ajaxIntentUrl') {
			$generate_intent_url=urldecodef($generate_intent_url);
			echo "<script>
				var transID='$transID';
				var varTransID='$transID';
				var varReferenceNo='$reference';
				var trans_auto_expired=$set_trans_auto_expired; 
			</script>";
			echo "<a DONE_AJAX class=\"appOpenUrl nopopup suButton btn btn-icon btn-primary mx_button_2\" href=\"{$generate_intent_url}\"  title=\"{$orderCurrencySymbol}{$total_payment} paying to {$dba} \" target=\"_blank\" onclick=\"processingf();\">Open</a> "; exit;
		}
		elseif(isset($generate_qr_code) && !empty($generate_qr_code) && isset($post['actionajax']) && $post['actionajax']=='ajaxQrCode') {
			$generate_qr_code=urldecodef($generate_qr_code);
			$generate_qr_code=urlencodef($generate_qr_code);
			$reference=$_REQUEST['reference'];

			echo "<script>
				//parent.window.transID='$transID';
				var transID='$transID';
				var varTransID='$transID';
                var varReferenceNo='$reference';
				var trans_auto_expired=$set_trans_auto_expired; 
			</script>";
			
			if(isset($qr_process_base64)&&$qr_process_base64==1)
			{
				echo "<img DONE_AJAX src=\"data:image/gif;base64,{$generate_qr_code}\" title=\"{$orderCurrencySymbol}{$total_payment} paying to {$dba} \" width=\"140\" />";
			}
			else 
			{
				echo "<img DONE_AJAX src=\"https://quickchart.io/chart?chs=160x160&cht=qr&chl={$generate_qr_code}&choe=UTF-8\" title=\"{$orderCurrencySymbol}{$total_payment} paying to {$dba} \" />";
				//echo "<img DONE_AJAX src=\"https://quickchart.io/chart?chs=160x160&cht=qr&chl={$generate_qr_code}&choe=UTF-8\" title=\"{$orderCurrencySymbol}{$total_payment} paying to {$dba} \" />";
			}
			
			exit;
		}
		elseif(isset($intent_paymentUrl) && !empty($intent_paymentUrl) &&  isset($intent_process_redirect) && $intent_process_redirect==1) {
			echo $opener_script;
			//header("Location:".trim($intent_process_url));
			safe_redirect(trim($intent_process_url));
			exit();
		}elseif(isset($intent_paymentUrl) && !empty($intent_paymentUrl) &&  isset($intent_process_include) && $intent_process_include==1) {
			$data['config_root']=1;
			echo $opener_script;
			include($data['Path']."/intent_process".$data['iex']);
		}
		elseif(!empty($process_url)){
			echo $opener_script;
			//header("Location:".trim($process_url));
			safe_redirect(trim($process_url));
			exit();
		}
		else{
			echo $opener_script;
			$data['Error']=7004;

			if(isset($_SESSION['acquirer_response'])&&!empty($_SESSION['acquirer_response']))
			echo $data['Message']="Error for ".stf(@$_SESSION['acquirer_response']);
			else
			echo $data['Message']="Error for Could not established secure connection";
			//error_print($data['Error'],$data['Message']);
		}
		exit;
	}
	
}

##### end: dynamic acquirer include for path of payin  ###############


$popup_msg_f=acquirer_popup_msg_f($acquirer);



//test_response
$test_response=false; $test_process_url="";
if($scrubbedstatus==true){
	$test_response=true;
	if($scrubbed_msg){
		$scrubbed_msg=urlencode($scrubbed_msg);
	}
	$test_process_url = $return_url.$ctest; 
	//header("location:$test_process_url");exit;
}elseif(($card_type=='2D'||$card_type=='3D')&&($post['integration-type']=='Encode-Checkout'||$post['integration-type']==strtolower('encode-checkout'))&&($scrubbedstatus==false&&$acquirer=='')){ // otp
	$test_response=true;
	//echo $opener_script;
	$test_process_url=$otp_sample_url;
}elseif($testcardno==true){ // success
	$test_response=true;
	$test_process_url = $return_url.$ctest; 
}

//s2s 2d
if($test_response==true&&$test_process_url){
	
	$data_send=array();
	$data_send['transID']=$transID;
	$data_send['acquirer_action']=1;
	
	if((isset($_GET['ctest']))){
		$data_send['ctest']=$_GET['ctest'];
	}

	if($post['integration-type']=="s2s"){
		if($card_type=='2D'||$card_type=='3D'){
			$auth_otp=[];
			//$auth_otp['Error']="7001";
			$auth_otp['transID']=$_SESSION['transID'];
			$auth_otp['order_status']=0;
			$auth_otp['status']='Pending';
			$auth_otp['bill_amt']=$_SESSION['re_post']['bill_amt'];
			
			$auth_otp['descriptor']='Test*'.@$data['SiteName'];
			$auth_otp['tdate']=@$_SESSION['tdate_micro'];
			$auth_otp['bill_currency']=$_SESSION['re_post']['bill_currency'];
			$auth_otp['response']='Test transaction initiated';
			$auth_otp['reference']=@$_SESSION['reference'];
			$auth_otp['mop']=@$_SESSION['info_data']['mop'];

			if(isset($post['ccno'])&&trim($post['ccno']))
			$auth_otp['ccno']=ccnois(@$post['ccno'],1);
			$auth_otp['rrn']='null';
			$auth_otp['upa']='null';

			//$auth_otp['authurl']=$data['Host']."/authurl".$data['ex']."?transID=".$_SESSION['transID'];
			$auth_otp['authurl']=@$authurl;
			json_print($auth_otp);
			exit;
		}else{
			$_POST['transID']=$_SESSION['transID'];
			//$use_curl=use_curl($test_process_url,$data_send);
			//exit;
		}
	}else{

			/*
			echo "<br/>acquirer=>".$acquirer;
			echo "<br/>popup_msg_f=>".$popup_msg_f;
			echo "<br/>status_url_1=>".$status_url_1;
			echo "<br/>opener_script=>".$opener_script;
			*/

			//
			if(isset($popup_msg_f)&&$popup_msg_f&&preg_match("/(redirect|newtab)/i", $popup_msg_f)){
				// skip the json array and go to redirect on new browser tab 
				echo $opener_script;
				safe_redirect(trim($status_url_1));
				
				exit();
			}

			$channel_type_b=$_SESSION['b_'.$acquirer]['channel_type'];
			if(isset($channel_type_b)&&$channel_type_b==3){
				$json_arr_set['auth_3ds2']=@$otp_sample_url;
			}else {
				$json_arr_set['realtime_response_url']=@$test_process_url;
			}
			$json_arr_res=@$json_arr_set;
			$json_arr_res['DONE_AJAX']='DONE_AJAX';
			$json_arr_res['transID']=@$transID;
			$json_arr_res['varTransID']=@$transID;
			$json_arr_res['varReferenceNo']=@$reference;
			$json_arr_res['trans_auto_expired']=@$set_trans_auto_expired;
			$json_arr_res['channel_type']=@$channel_type_b;
			$json_arr_res['mop']=@$_REQUEST['mop'];
			$json_arr_res['testcardno']=@$testcardno;
			$json_arr_res['card_type']=@$card_type;
			
			$_SESSION['json_arr_res']=$json_arr_res;
			
			jsonen($json_arr_res);
			
		//echo $opener_script; header("Location:$test_process_url"); exit;
	}
}
?>