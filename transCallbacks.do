<?
$data['HideAllMenu']=true;
$data['SponsorDomain']=1;

$update_time_log=array();
$update_time_log['update_log_1']=(new DateTime())->format('Y-m-d H:i:s.u');


//include('config_db.do');
if(!isset($data['CONFIGFILE'])){
	include('config.do');
}
$qprint=$data['cqp'];

//$qprint=1;$_GET['ctest']=11;

if(isset($_GET['qp1'])){
	$qprint=1;
}
if(isset($_GET['pr0'])&&$_GET['pr0']==0){
	$qprint=0;
}

//error_reporting(0);
/*
error_reporting(-1); // reports all errors
ini_set("display_errors", "1"); // shows all errors
ini_set("log_errors", 1);
ini_set("error_log", "php-error.log");
*/
//if(session_id() == '' || !isset($_SESSION)) {session_start();}
function decode_base64_2($sData){ 
    $sBase64 = strtr($sData, '-_', '+/'); 
    return base64_decode($sBase64); 
} 
function decryptres_2($sData, $sKey='pctDusPay'){ 
    $sResult = ''; 
    $sData   = decode_base64_2($sData); 
    for($i=0;$i<32;$i++){ 
        $sChar    = substr($sData, $i, 1); 
        $sKeyChar = substr($sKey, ($i % strlen($sKey)) - 1, 1); 
        $sChar    = chr(ord($sChar) - ord($sKeyChar)); 
        $sResult .= $sChar; 
    } 
    return $sData; 
}
function ccno_is($number, $bin_no='', $size=4) {
	global $ccno_last4;
	if($number){
		$number = card_decrypts256($number);
		$ccno_last4=substr($number,-4);
		//echo "<hr/>number1=>".$number;
		//echo "<hr/>ccno_last4=>".$ccno_last4;
		if(strpos($number,'XXXX')!==false){
			$number=bclf($number,$bin_no);
			return $number;
		}else{
			$result='';
			$length=strlen($number);
			for($i=0;$i<$length-$size;$i++)$result.='X';
			//$ccno_last4=substr($number, $length-$size, $length);
			$number=$result.substr($number, $length-$size, $length);
			$number=bclf($number,$bin_no);
			return $number;
		}
	}
	if(isset($_GET['cc'])){
		echo "<hr/>number1=>".$number;exit; 
	}
}

function encryption_sha256_f($string,$private_key_code,$public_key_code) {
    $output = false;
    $encrypt_method = "AES-256-CBC";
    $iv = substr( hash( 'sha256', $public_key_code ), 0, 16 );
    $output = rtrim( strtr( base64_encode( openssl_encrypt( $string, $encrypt_method, $private_key_code, 0, $iv ) ), '+/', '-_'), '=');
    return $output;
}

$notify_condition=true;$emailer_condition=true;$transactions_update=true;$validatepay=true;$transaction_processing_url=false;
$urlpath=$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
$success_page=false;$get_transID=true;$failed_page=false;

if(strpos($urlpath,"return_url")!==false){$get_transID=true; $transactions_update=true;$validatepay=false;}
elseif(strpos($urlpath,"trans_processing")!==false){$get_transID=true;$notify_condition=true;$success_page=false;$failed_page=false;$transactions_update=true;$transaction_processing_url=true;}
elseif(((isset($_SESSION['integration-type']))&&($_SESSION['integration-type']=="s2s")) || (strpos($urlpath,"api")!==false)  || (strpos($urlpath,"success_curl")!==false) ){
	$get_transID=true;$transactions_update=true;$validatepay=false;$_SESSION['integration-type_notify']="curl_setopt"; 
}


if(isset($_SERVER['HTTP_REFERER'])&&$_SERVER['HTTP_REFERER']){	
	$update_time_log['update_log_http_referer_1.1']=$_SERVER['HTTP_REFERER'];	
}
$update_time_log['update_log_urlpath_1.2']=$data['urlpath'];
if(isset($_GET)&&count($_GET)>0){	
	$update_time_log['update_log_get_1.3']=json_encode($_GET);	
}
if(isset($_POST)&&count($_POST)>0){	
	$update_time_log['update_log_post_1.4']=json_encode($_POST);	
}


$host_path=$data['Host'];

//************************************************************************

$d=array(); $acquirer_response_arr=array();

$_SESSION['info_data']=array();
if(!isset($return_response_arr)) $return_response_arr=array();
$getresponse=array();
$getresponse['transID']="";
$getresponse['order_status']="";
$getresponse['status']="Pending";
$getresponse['price']="";
$getresponse['curr']="";
$getresponse['reference']="";
$getresponse['ccno']="";
$getresponse['mop']="";
$getresponse['response']="";
$trans_response_get="";

$getresponse['terNO']="";
$getresponse['merID']="";
	
	$getresponse['fullname']="";
	$getresponse['bill_email']="";
	$getresponse['bill_address']="";
	
	$getresponse['bill_city']="";
	$getresponse['bill_state']="";
	$getresponse['bill_country']="";
	$getresponse['bill_phone']="";
	$getresponse['product_name']="";
	$getresponse['amt']="";
	
	

$getresponse['mode_info']="";

$getresponse['memail']="";
$getresponse['company_name']="";	

$trans_where_append="";


// update execution is default true for query & calculation update if true 
$update_execution=true;

if(isset($_POST['ctest']) && $_POST['ctest']){
	$_GET['ctest']=$_POST['ctest'];
}



if($get_transID==true){
	
	if(!empty($_REQUEST['transID'])&&(isset($_REQUEST['transID'])))
		$transID=$_REQUEST['transID'];
	elseif(!empty($_REQUEST['orderset'])&&(isset($_REQUEST['orderset'])))
		$transID=$_REQUEST['orderset'];
	elseif(isset($_SESSION['transID'])&&trim($_SESSION['transID'])) 
		$transID=$_SESSION['transID'];
	elseif(isset($_SESSION['SA']['transID'])&&trim($_SESSION['SA']['transID'])) 
		$transID=$_SESSION['SA']['transID'];
	
	if(isset($transID)&&!empty($transID)){
		$transID=transIDf($transID,0);
		$getresponse['transID']=$transID;
	}
	
}


//
$ccno="";
$tr_status_set="";
$status_cc=0;
$webhook_url="";
$return_url="";
$account_name="";
$subquery ="";

$notification_merchant="";
$notification_customer="";
$tr_comments="";
$moto_vt=false;$source_url="";$request_money=false; $session_remove=false;
$actionurl="";

	$declined_txt_1="3D transaction or may blocked by the bank for";
	$descriptor_nm="";
	$descriptor_tr=" ";
	$descriptor_br=" ";
	$attempts_txt="3";
	
	$getresponse['bussinessurl']="";
	$getresponse['contact_us_url']="";
	$getresponse['customer_service_no']="";

	$getresponse['tdate']="";
	$getresponse['descriptor']="";
	$mpreferences="";

	$trdetails="";
	$scrubbedmsg="";
	$gateway_transaction_id="";
	$subject_merchant="";
	
	if((isset($_SESSION['scrubbed_msg'])) && (!isset($_SESSION['re_post']))){
		$scrubbedmsg=$_SESSION['scrubbed_msg'];
		$getresponse['response']=$_SESSION['scrubbed_msg'];
		$getresponse['scrubbed_msg']=urlencode($_SESSION['scrubbed_msg']);
	}
	
	if(((isset($_GET['scrubbed_msg']))&&(!empty($_GET['scrubbed_msg']))) && (!isset($_SESSION['re_post']))){
		$scrubbedmsg=$_GET['scrubbed_msg'];
		$getresponse['response']=$_GET['scrubbed_msg'];
		$getresponse['scrubbed_msg']=urlencode($_GET['scrubbed_msg']);
	}
	
	$system_notes="";$company_name="";$csn_profile="";
	$bank_country_name="Offshore Location";
	$acquirer_ref_trow="";$transID_tr="";$type_tr="";
			
if(isset($getresponse['transID'])&&!empty($getresponse['transID']))
{
	
	$tr_id=0;$tr_status=-1;$channel_type=0; $trans_where_append='';
	
	if(isset($getresponse['merID'])&&$getresponse['merID']>0){
		$trans_where_append .="  AND `merID`='{$getresponse['merID']}'  ";
	}
	
	if((isset($_SESSION['tr_newid']))&&(!empty($_SESSION['tr_newid']))){
		//$trans_where_append .=" AND `id`=".$_SESSION['tr_newid']." ";
	}	
	
	
	
	//Select Data from master_trans_additional
	$join_additional=join_additional();

	if(isset($data['ACQUIRER_REF_ENABLE'])&&$data['ACQUIRER_REF_ENABLE']=='Y') $where_pred=" (`transID`='{$getresponse['transID']}' OR {$data['DbPrefix']}{$data['ASSIGN_MASTER_TRANS_ADDITIONAL']}.`acquirer_ref`='{$getresponse['transID']}') ";
	
	else $where_pred=" `transID`='{$getresponse['transID']}' ";
		
	$trow = db_rows("SELECT * FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` {$join_additional} WHERE ".$where_pred.$trans_where_append." LIMIT 1  ",$qprint);
	
	//print_r($_GET);
	$trw=sqInArray(@$trow[0]);
	//$trw=@$trow[0];
	//print_r($trw);exit;
	
	
	
	if($trw){
		$update_time_log['update_log_trans_fetch_2']=(new DateTime())->format('Y-m-d H:i:s.u');
	#############################################################################
		
		$memb_get = db_rows("SELECT * FROM `{$data['DbPrefix']}clientid_table` WHERE `id`='{$trw['merID']}' LIMIT 1  ",$qprint);
		$memb=@$memb_get[0];
		if($memb){		
			$company_name=$memb['company_name'];
			//$csn_profile=$memb['fax'];
		
		}
	
	#############################################################################
		
		$qr_terminals = db_rows("SELECT * FROM `{$data['DbPrefix']}terminal` WHERE `id`='{$trw['terNO']}' AND `merID`='{$trw['merID']}' LIMIT 1  ",$qprint);
		$qr_terminal=$qr_terminals[0];
		if($qr_terminal){
			if(trim($qr_terminal['webhook_url']))$webhook_url =$qr_terminal['webhook_url'];
			if(trim($qr_terminal['return_url']))$return_url =$qr_terminal['return_url']; 
			$data['webhook_url']=$webhook_url;
			$data['return_url']=$return_url;
			$bussinessurl_products=$qr_terminal['bussiness_url'];
			$getresponse['bussinessurl']=$qr_terminal['bussiness_url'];
			
			$getresponse['memail']=encrypts_decrypts_emails($qr_terminal['customer_service_email'],2);
			
			if(empty($getresponse['memail'])){
				$getresponse['memail']=encrypts_decrypts_emails(@$memb['registered_email'],2);
			}
			
			if(isset($qr_terminal['mer_trans_alert_email'])&&$qr_terminal['mer_trans_alert_email']){
				$mer_trans_alert_email=encrypts_decrypts_emails($qr_terminal['mer_trans_alert_email'],2);
			}else{
				$mer_trans_alert_email=encrypts_decrypts_emails(@$memb['registered_email'],2);
			}
			
			if(empty($qr_terminal['dba_brand_name'])){
				if($qr_terminal['ter_name']) $getresponse['company_name']=$qr_terminal['ter_name'];
				else
					$getresponse['company_name']=$company_name;
			}
			else{$getresponse['company_name']=$qr_terminal['dba_brand_name'];}
			//$getresponse['bussinessurl']=$memb['drvnum'];
			$getresponse['contact_us_url']=$qr_terminal['merchant_contact_us_url'];			
			if(!empty($qr_terminal['customer_service_no'])){
				$getresponse['customer_service_no']=$csn_profile=$qr_terminal['customer_service_no'];
					$csn_profile=$memb['customer_service_no'];
			}
			
			
			$service_email =encrypts_decrypts_emails($qr_terminal['customer_service_email'],2);
			
			$mpreferences=$qr_terminal['tarns_alert_email'];
		
			if(strpos($mpreferences,"002")!==false){
				$emailer_condition=true;
				$notification_customer="2";
			}
		}
		
	#############################################################################
	
		$tr_status_nm=$trw['trans_status'];

		//echo "<br/>tr_status_nm=>".$tr_status_nm;
	
	#############################################################################
		
		$channel_type=(int)$trw['channel_type'];
		$tr_json_value_str=$trw['json_value'];
		$tr_json_value_str=jsonreplace($tr_json_value_str);
		$is_test=jsonvaluef($tr_json_value_str,'is_test');
		if(isset($is_test)&&$is_test=="9"){
			$trw['trans_status']=9;
			$trans_response_get= "Transaction succeeded, we do not charge any fees for testing transaction ";
		}
		
		$tr_id=$trw['id'];
		$tr_status=$trw['trans_status'];
		$mop=$data['mop']=$trw['mop'];
		
		$_SESSION['tr_newid']=$trw['id'];
		
		//$account_name=$data['t'][$trw['acquirer']]['name2'];
		$getresponse['price']=$trw['bill_amt'];
		$getresponse['transID']=$trw['transID'];
	
		if(trim($trw['webhook_url']))$webhook_url=$trw['webhook_url'];
		if(trim($trw['return_url']))$return_url=$trw['return_url'];


		$source_url=$trw['source_url'];
		$_SESSION['re_post']['source_url']=$source_url;
		
		//if(isset($trw['rrn'])) 
			$getresponse['rrn']=@$trw['rrn'];
		
			$getresponse['upa']=@$trw['upa'];
			
		if(trim($trw['terNO'])) $getresponse['terNO']=$trw['terNO'];
		if(trim($trw['merID'])) $getresponse['merID']=$trw['merID'];
		
		$getresponse['reference']=$trw['reference'];
		$getresponse['bill_amt']=$trw['bill_amt'];
		$getresponse['amt']=$trw['bill_amt'];
		$getresponse['bill_email']=$trw['bill_email'];
		$getresponse['fullname']=$trw['fullname'];
		
		$getresponse['bill_address']=$trw['bill_address'];
		$getresponse['bill_city']=$trw['bill_city'];
		$getresponse['bill_state']=$trw['bill_state'];
		$getresponse['bill_country']=$trw['bill_country'];
		$getresponse['bill_zip']=$trw['bill_zip'];
		$getresponse['bill_phone']=$trw['bill_phone'];
		$getresponse['product_name']=$trw['product_name'];
		
		$getresponse['mop']=$trw['mop'];
		if(isset($trw['ccno'])&&$trw['ccno']){
			$ccno=$trw['ccno'];
		}else{
			$ccno='';
		}
		
		if(isset($trw['bin_no'])&&$trw['bin_no']){
			$bin_no=$trw['bin_no'];
		}else{
			$bin_no='';
		}
		
		$getresponse['tdate']=date('Y-m-d H:i:s',strtotime($trw['tdate']));
		$getresponse['order_status']=$trw['trans_status'];
		$getresponse['tr_type']=$trw['acquirer'];
		//$tr_comments=$trw['comments'];
		$getresponse['status']=$data['TransactionStatus'][$trw['trans_status']];
		$getresponse['ccno']=ccno_is($ccno,$bin_no);
		
		$system_notes=$trw['system_note'];
		
		if($trw['bill_currency']){
		  $getresponse['curr']=$getresponse['bill_currency']=get_currency($trw['bill_currency'],1);
		}
		
		if(strpos($trw['source_url'],"action=vt")!==false){ $moto_vt=true;}
		if(strpos($trw['source_url'],"actiontype=requestmoney")!==false){ $request_money=true;}
		
			
		$support_note_get= $trw['support_note']; 
		
		$trans_response_get=$getresponse['status'];
		
		
		if(isset($trw['descriptor'])&&$trw['descriptor']){
			$getresponse['descriptor']=$trw['descriptor'];
		}
		if($trw['trans_status']==10){
			$notify_condition=true;$emailer_condition=false;
			$transactions_update=false;
		}
		
		if(!empty($trw['acquirer_ref'])){
			$gateway_transaction_id=$trw['acquirer_ref'];
		}
		if($trw['acquirer_response']){
			$acquirer_response_arr=isJsonDe($trw['acquirer_response']);
		}
		
		if(isset($trw['acquirer_response'])&&trim($trw['acquirer_response'])){
			$order_status_ex=explode('order_status',$trw['acquirer_response']);
			$order_status_count=(count($order_status_ex)-1);
		}else{
			$order_status_count=0;
		}

		$type_tr=$trw['acquirer'];
		
		$tr_json_value=jsondecode($tr_json_value_str,1,1);
		
		if(isset($tr_json_value['post'])&&isset($tr_json_value['get'])&&is_array($tr_json_value['post'])&&is_array($tr_json_value['get']))
			$tr_json_value['post']=array_merge($tr_json_value['post'],$tr_json_value['get']);
		
		if(isset($tr_json_value['pay_mode'])){
			$pay_mode=$tr_json_value['pay_mode'];
			$getresponse['pay_mode']=$pay_mode;
		}
		
		/*
		$pay_url_get=jsonvaluef($tr_json_value_str,'pay_url');
		if(!empty($pay_url_get)){
			$getresponse['pay_url']=$pay_url_get;
		}
		*/
	
		$authdata_arr=isJsonDe($trw['authdata']);
		
		$auth_data_get=jsonvaluef($tr_json_value_str,'auth_data');
		if(isset($authdata_arr)&&$authdata_arr){
			$getresponse['authdata']=($authdata_arr);
		}elseif(isset($tr_json_value['auth_data'])&&$tr_json_value['auth_data']){
			$getresponse['authdata']=($tr_json_value['auth_data']);
		}elseif(!empty($auth_data_get)){
			$getresponse['authdata']=htmlentitiesf($auth_data_get);
			
		}
		
		if(isset($getresponse['authdata']['payaddress'])&&$getresponse['authdata']['payaddress']){ 
			$getresponse['authdata']['payaddress']=urldecodef($getresponse['authdata']['payaddress']);
		}
		
		
		
		$getresponse['trans_auto_expired']=$auth_data_get=jsonvaluef($tr_json_value_str,'trans_auto_expired');
		
		if($trw['trans_status']==9){
			$tr_status_set.= "Test Transaction succeeded, we do not charge any fees for testing transaction";
			$getresponse['response']=$tr_status_set;
			$getresponse['descriptor']=$trw['descriptor'];
			$descriptor_nm=$getresponse['descriptor'];
		}
		
		
		if($tr_status==0||$tr_status==9){

			//Dev Tech : 25-02-04 encrypted transID & public_key via &key= in authurl 
			if((isset($data['ENCRYPTED_TRANSID_ENABLE'])&&@$data['ENCRYPTED_TRANSID_ENABLE']=='Y')||(isset($tr_json_value['post']['encryption_method'])&&strtolower($tr_json_value['post']['encryption_method'])=='aes256')){
				$transID_json='{"transID":"'.@$trw['transID'].'","public_key":"'.@$tr_json_value['post']['public_key'].'"}';
				$encrypted_transID=encode64f($transID_json);
				$getresponse["authurl"]=$data['Host']."/authurl".$data['ex']."?key=".$encrypted_transID;
			} else 
				$getresponse["authurl"]=$data['Host']."/authurl".$data['ex']."?transID=".$trw['transID'];
		}else{
			$getresponse["authurl"]='';
		}
		
		$integrationType="";
		if(isset($tr_json_value['post']['integration-type'])){
			$integrationType=$tr_json_value['post']['integration-type'];
		}
		
		
		
		$pre_trans_response=$trw['trans_response'];
		
	
	}
	
	//if(!empty($_SESSION['info_data']['curr'])){$getresponse['curr']=$_SESSION['info_data']['curr'];}
	
	if(!empty($getresponse['tr_type'])){
		
		/*
		$query_account = db_rows("SELECT * FROM `{$data['DbPrefix']}mer_setting` WHERE `acquirer_id`='{$getresponse['tr_type']}' AND `merID`='{$getresponse['merID']}' LIMIT 1  ",$qprint);
		if($query_account){
			
		}
		*/
		
		$update_time_log['update_log_trans_fetch_3']=(new DateTime())->format('Y-m-d H:i:s.u');
	}
	
	
	
	
	if(isset($_REQUEST['cron_tab'])){$d['cron_tab_1']=$_REQUEST['cron_tab'];}
	
	if(isset($_REQUEST['actionInfo'])&&$_REQUEST['actionInfo']){$d['actionInfo']=$_REQUEST['actionInfo'];}
	
	if(isset($_POST)){
		
		$_POST=strip_tags_d($_POST);
		
		if(isset($_POST['trans_status'])){$tr_status_set=$_POST['trans_status'];}
		if(isset($_POST['error'])){$tr_status_set.=" - Reason: ".$_POST['error'];}
		
		if(isset($_POST['acquirer_action'])){$_SESSION['acquirer_action']=$_POST['acquirer_action'];}
		if(isset($_POST['acquirer_response'])&&trim($_POST['acquirer_response'])){$_SESSION['acquirer_response']=$_POST['acquirer_response'];}
		if(isset($_POST['acquirer_status_code'])){$_SESSION['acquirer_status_code']=$_POST['acquirer_status_code'];}
		if(isset($_POST['acquirer_transaction_id'])){$_SESSION['acquirer_transaction_id']=$_POST['acquirer_transaction_id'];}
		if(isset($_POST['acquirer_descriptor'])){$_SESSION['acquirer_descriptor']=$_POST['acquirer_descriptor'];}
		if(isset($_POST['curl_values'])&&$_POST['curl_values']){$_SESSION['curl_values']=$_POST['curl_values'];}
		
		if(isset($_SESSION['curl_values'])&&is_array($_SESSION['curl_values'])) {
			$_SESSION['curl_values']=strip_tags_d($_SESSION['curl_values']);
			//$_SESSION['curl_values']=jsonencode($_SESSION['curl_values'],1,1);
		}
		
		if(isset($_SESSION['curl_values'])) {
			$_SESSION['curl_values']=curly_braces_join($_SESSION['curl_values']);
		}
		
		if(isset($_POST['cron_tab'])){$d['cron_tab']=$_POST['cron_tab'];}
		
		
		
		$getresponse['response']=$tr_status_set;
		$trans_response_get=$tr_status_set;
		
		$update_time_log['update_log_trans_fetch_4']=(new DateTime())->format('Y-m-d H:i:s.u');
	}
	
	// Dev Tech : 23-12-18 remodify 
	
	$repost_condition=false;
		
	if( ( (!isset($_SESSION['adm_login'])) && (@$_REQUEST['cron_tab']!='cron_tab' ) ) && ( isset($tr_json_value['re_post']) && ($tr_json_value['re_post']=="CHECKOUT") )  )
	{
	
		//$repost_condition=1;
	}
	
	//Dev Tech : 24-07-27 bug fix for not redirect the when webhook 
	if((isset($_REQUEST['action'])&&trim($_REQUEST['action'])&&$_REQUEST['action']=='webhook')||isset($_REQUEST['cron_host_response'])||isset($_REQUEST['cron_tab'])) $repost_condition=false;
	
	//Dev Tech : 23-12-18 Admin update response via manual 
	if((isset($_REQUEST['actionurl']))&&($_REQUEST['actionurl']=="by_admin"||$_REQUEST['actionurl']=="admin_direct"))
	{
		$repost_condition=false;
		
		$notify_condition=true;$emailer_condition=true;$transactions_update=true;
		//$session_remove=true;
		if(isset($_REQUEST['acquirer_status_code'])){
			$status_cc=@$_REQUEST['acquirer_status_code'];
		}
	}
	
	
		
	//echo "<hr/>webhook==>";echo "<hr/>_SESSION==>";print_r($_SESSION); echo "<hr/>_GET==>";print_r($_GET);echo "<hr/>_POST==>";print_r($_POST);exit; 
	
	if(isset($_SESSION['acquirer_response'])&&(!empty($_SESSION['acquirer_response']))){
			$getresponse['response']=$_SESSION['acquirer_response'];
			$d['info']=$_SESSION['acquirer_response'];
			
			$trans_response_get=$_SESSION['acquirer_response'];
		
			$tr_status_set.=$_SESSION['acquirer_response'];
	  }
	
	if(isset($_SESSION['acquirer_action']) && $_SESSION['acquirer_action']==true){
		//$notify_condition=true;$emailer_condition=true;$transactions_update=true;$success_page=true;
		
		if(isset($_SESSION['acquirer_transaction_id'])&&trim($_SESSION['acquirer_transaction_id'])) $d['transID']=@$_SESSION['acquirer_transaction_id'];
		
		if(isset($_SESSION['acquirer_descriptor'])&&trim($_SESSION['acquirer_descriptor']))$d['billing_desc']=@$_SESSION['acquirer_descriptor'];
		
		if(isset($_SESSION['acquirer_status_code']))$d['order_status']=$_SESSION['acquirer_status_code'];
		
		if(!empty($_SESSION['acquirer_transaction_id'])){
			$gateway_transaction_id=$_SESSION['acquirer_transaction_id'];
		}
		
		
		if(isset($_SESSION['curl_values'])&&trim($_SESSION['curl_values'])){$d['curl_values_session']=@$_SESSION['curl_values'];}
		
		if((isset($_GET['actionurl']))&&(!empty($_GET['actionurl']))){
			$d['actionurl']=$_GET['actionurl'];
		}
		
		
		
		if(isset($_SESSION['uniqueID'])){
			$getresponse['uniqueID']=$_SESSION['uniqueID'];
		}
		
		
		//transaction_processing ----
		//$getresponse['order_status']=0;$_SESSION['acquirer_status_code']=1; //cmn 
		
		
		//BUG review and fix by Dev Tech : 23-01-10 (Bug is trans_response - order_status 23 update and admin update trans_status than not match below condition )
		//if($getresponse['order_status']<3)
		{
			if(isset($_SESSION['acquirer_status_code'])&&($_SESSION['acquirer_status_code']==2||$_SESSION['acquirer_status_code']=="2")){
				$status_cc=1;
			}elseif(isset($_SESSION['acquirer_status_code'])&&($_SESSION['acquirer_status_code']==1||$_SESSION['acquirer_status_code']=="1")){
				$status_cc=0;
			}elseif(isset($_SESSION['acquirer_status_code'])&&($_SESSION['acquirer_status_code']==22||$_SESSION['acquirer_status_code']==23)){
				$status_cc=$_SESSION['acquirer_status_code'];
			}elseif(isset($_SESSION['acquirer_status_code'])&&($_SESSION['acquirer_status_code']<1)){
				$status_cc=2;
			}
		}
		
		//echo "<br/><br/>acquirer_status_code=>".$_SESSION['acquirer_status_code']; echo "<br/><br/>status_cc=>".$status_cc; exit;



		//Dev Tech : 24-07-20 false the update execution if not empty trans_response & trans_status is 0 & acquirer response is 0 via 1 = pending and 1 not in  trans_status & not in admin session 
		if(!empty(trim($trw['trans_response']))&&(($tr_status==$status_cc)||($tr_status==1))&&(!isset($_SESSION['adm_login']))) $update_execution=false;



		
		$declined_txt_1="";$attempts_txt="7";
		
		if(isset($_SESSION['acquirer_descriptor'])&&$_SESSION['acquirer_descriptor']){
			$descriptor_nm=$_SESSION['acquirer_descriptor'];
			
			$descriptor_tr="<tr><td width=30%>Descriptor</td><td width=70%> : ".$descriptor_nm."</td></tr>";
			$descriptor_br="Transaction Descriptor: ".$descriptor_nm."<br/><br/>";
			
			$getresponse['descriptor']=$descriptor_nm;
		}
		
	}
	
	
	if(isset($_GET['actionurl'])){
		$actionurl="&actionurl=".$_GET['actionurl'];
	}
	
	if(isset($tr_json_value['bin_bank_name'])&&$tr_json_value['bin_bank_name']){
		$bin_bank_name=$tr_json_value['bin_bank_name'];
		if(isset($tr_json_value['bin_phone'])&&$tr_json_value['bin_phone']){
			$bin_bank_name.=", ".$tr_json_value['bin_phone'];
		}
		if(isset($tr_json_value['website'])&&$tr_json_value['website']){
			//$bin_bank_name.=", ".$tr_json_value['website'];
		}
	}else{
		$bin_bank_name='your bank';
	}
	
	
	if($status_cc==1){ // for Sucess
		$emailer_condition=false;
		if(strpos($mpreferences,"001")!==false){ 
			$emailer_condition=true;
			$notification_merchant="1";
		}
		if(strpos($mpreferences,"002")!==false){ 
			$emailer_condition=true;
			$notification_customer="2";
		}

		
		
		
		

	}
	elseif($status_cc==2||$status_cc==22||$status_cc==23){ // for failed
		$notify_condition=true;$emailer_condition=false;$transactions_update=true;$success_page=false;
		if($getresponse['order_status']=="10"){
			$transactions_update=false;
		}
		if(strpos($mpreferences,"004")!==false){ 
			$emailer_condition=true;
			$notification_merchant="1";
		}
		if(strpos($mpreferences,"002")!==false){ 
			$emailer_condition=true;
			$notification_customer="2";
		}
		//$d['transID']="NA";
		$d['trans_status']=" Payment Failed";
		
		//cmn 
		//$status_cc=2;
		$tr_status_set.=" Payment Failed.";
		
			
			$header_msg="<h3><i></i> Payment Failed..</h3>";
			
			$msg="<h4>".$trans_response_get."</h4>";
			$msg_fail=$msg."<h5>Please call the number given on the back side of your card and ask {$bin_bank_name} as how you can complete this purchase/transaction? (Why your transaction has been declined?).</h5>
			<div style=\"float:left;background-color:#fff0b3;width:95%;padding:10px 2.5%;text-align:left;line-height:150%;font-weight:normal;font-size: 14px;\">Your card might not be activated by {$bin_bank_name} for cross border transactions or blocked for some trans_response. 
				Please be informed that our acquiring bank is based in Asia/HongKong. You might need to ask {$bin_bank_name} to allow cross border transactions in Asia/HongKong.
				As soon as you have the confirmation from {$bin_bank_name} that card/transaction has been unlocked You may process the payment again.<br/>
			</div>";
			$footer_msg="";
			
			//$data['header_msg']=$header_msg;
			$data['msg_fail']=$msg_fail;
			$data['footer_msg']=$footer_msg;
		
	
		
		
	}
	elseif($getresponse['order_status']==10){
			
			$getresponse['response']=$trw['trans_response'];
			
			$msg 	="ERROR: Your payment has been failed with ".$getresponse['company_name']." - ".$getresponse['bussinessurl']."".$scrubbedmsg;
			
			$header_msg="<h3><i></i> Payment Failed..</h3>";
			if(!empty($scrubbedmsg)){
				$subquery.="scrubbed=".$scrubbedmsg."&";
			}
			$header_msg = "<div class=separator></div><br><h3><i></i> We are unable to process this transaction</h3><div class=separator></div>";
			
			
			$msg_fail=$msg. "<p>Unfortunately, We are unable to process this transaction. Please contact the merchant <font style=\"color:#db8f04;\"> $service_email </font> for assistance.</p><br/><p>You are being redirected to the merchant website is few seconds...</p><br/><br/><a href=\"".$return_url."\" style=\"text-decoration:none;color:#0e0eba;font-weight: normal;font-size:16px;\">Click here to return to merchant website now</a><br/><br/><br/>";
			
			$footer_msg = "";
		
		
			
			$data['header_msg']=$header_msg;
			$data['msg_fail']=$msg_fail;
			$data['footer_msg']=$footer_msg;
			
			
	}
	
	//$jsonarray=array();$jsonarray['trans_status']=$getresponse['status'];	

	//$email_details=sponsor_json($getresponse['merID']);
	
	
	//****************************************************
		$post['email_header']=1;

		$post['descriptor2'] = trim($descriptor_nm) ? " - (descriptor : " . trim($descriptor_nm) . ")" : ' ';
		$post['descriptor3'] = trim($descriptor_nm) ? trim($descriptor_nm) : ' ';
		$post['descriptor_text'] = trim($descriptor_nm) ? 'Descriptor' : ' ';


		$post['descriptor4'] = trim($descriptor_tr ?? '') . " ";
		$post['attempts'] = trim($attempts_txt ?? '') . " ";
		$post['customer_service_email'] = trim($getresponse['memail'] ?? '') . " ";
		$post['merchant_service_no'] = trim($getresponse['customer_service_no'] ?? '') . " ";
		$post['contact_us_url'] = trim($getresponse['contact_us_url'] ?? '') . " ";
		$post['info_status'] = trim($tr_status_set ?? '');



		$post['tdate']=date("m-d-Y H:i",strtotime($getresponse['tdate']));
		$post['card_no']=ccno_is($ccno,$bin_no)." ";
		if(!empty($ccno_last4)) $post['ccno_last4']=$ccno_last4;
		$post['mop']=$getresponse['mop']." ";
		
		if(isset($getresponse['mop'])&&$getresponse['mop']&&!empty($ccno_last4)){
			$img=$getresponse['mop'].".png";
			$post['card_img']="<img src={$data['Host']}/images/{$img}  style=max-height:18px;height:18px; /> - ".$ccno_last4;
		}else{
			
			if(isset($mop)&&trim($mop)){
				$mop_img=strtolower($mop).".png";
				if($trw['upa']) $upa=" - ".$trw['upa'];
				else $upa="";
			
				$post['card_img']="<img src={$data['Host']}/images/{$mop_img}  style=max-height:18px;height:18px; />".$upa;
			}
			else $post['card_img']=" ";
		}
		
		if(trim($getresponse['customer_service_no'])){
			$post['merchant_service_no_text']="or call at ";
		}else{
			$post['merchant_service_no_text']=" ";
		}
		
		
		$post['amount_currency']=@$getresponse['bill_amt']." ".@$getresponse['curr'];
		$post['customer_name']=@$getresponse['fullname'];
		$post['transID']=@$getresponse['transID'];
		
		$post['dba']=@$getresponse['company_name']." ";
		$post['bussiness_url']=@$getresponse['bussinessurl']." ";
		$post['business_url']=@$post['bussiness_url'];
		$post['customer_email']=@$getresponse['bill_email']." ";
		$post['customer_phone']=@$getresponse['bill_phone']." ";
		$post['trans_status']=@$trans_response_get . " " .@$scrubbedmsg;
		//$post['comments']=$tr_comments;
		$post['descriptor']=@$descriptor_br." ";
		$post['bank_name']=@$bank_country_name." ";
		$post['source_url']=@$source_url." ";
		$post['scrubbedmsg']=@$scrubbedmsg;
		
		$post['product_name']=@$getresponse['product_name']; 
		
		
		$post['text5']="Please call the number given on the back side of your card and ask {$bin_bank_name} as how you can complete this purchase/transaction? (Why your transaction has been declined?).<br/><br/>Your card might not be activated by {$bin_bank_name} for cross border transactions or blocked for some reason.<br/><br/>Please be informed that our acquiring bank is based in {$bin_bank_name}. You might need to ask {$bin_bank_name} to allow cross border transactions in {$bin_bank_name}.<br/><br/>As soon as you have the confirmation from {$bin_bank_name} that card/transaction has been unlocked You may process the payment again on <a href=\"{$post['bussiness_url']}\">{$post['bussiness_url']}</a> and enjoy purchasing the product/services from our accredited merchants.<br/><br/>";
		
		//$post['text6']="You still have opportunity to call your customer on the above given number and inform them the reason of the decline. Your customer can call the number given on the back side of their card and ask with their bank as how they can complete this transaction? (Why your transaction has been declined?).<br/><br/>Their card might not be activated by their bank for cross border transactions or blocked for some reason.<br/><br/>Please be informed that our acquiring bank is based in {$bin_bank_name}. Your customer might need to ask their bank to allow them cross border transactions in {$bin_bank_name}.<br/><br/>As soon as they will have the confirmation from their bank that card/transaction has been unlocked. They can process the transaction again on [bussiness_url] and enjoy purchasing the product/services from <a href=\"{$post['source_url']}\">your website</a>.<br/><br/>";
		

		
		$post['text6']="<p>Please inform your customer about the decline and advise them to contact their bank using the number on the back of their card. Their bank can explain why the transaction was declined, possibly due to cross-border restrictions or a block.<p><p>Our acquiring bank is based in <b>{$bin_bank_name}</b>, so they may need to request permission for cross-border transactions.<p><p>Once resolved, they can retry the transaction on <a href=\"{$post['bussiness_url']}\">{$post['bussiness_url']}</a> and continue shopping on <a href=\"{$post['source_url']}\">your website</a>.<p><br/><br/>";
		
		if($ccno){
			$post['credit_card_txt']=" Credit Card ";
			$post['card_no2']="<tr><td width=30%>Credit Card</td><td width=70%> : {$post['card_no']} </td></tr>";
			$post['descriptor5']="<p style=\"color:#999;width:95%;padding:10px 2.5%;\">Your credit card will read {$post['descriptor3']} in the next statement for this transaction. The actual amount might be little different due to the bank conversion charges for cross border transactions.</p>";
		}else{
			$post['credit_card_txt']=(isset($trw['channel_type'])&&$trw['channel_type']?strtoupper($data['channel'][$trw['channel_type']]['name1']):" "); 
			$post['mop']=$post['credit_card_txt'];
			$post['card_no2']=" ";
			$post['descriptor5']=" ";
			$post['text5']=" ";
			$post['text6']=" ";
			
			
		}
		
		
	//****************************************************

	if((isset($_GET['ctest']))&&($_GET['ctest']==11||$_GET['ctest']==1)){	
			$status_cc=1;
	}
	elseif((isset($_GET['ctest']))&&($_GET['ctest']==22)){	
		$status_cc=2;
	}
	
	
	$array_customer[]=["c"=>"<a style=\"color:#668cff;font-size:20px;display:block;width:100%;padding:5px 0 15px 0;\">Your Order Details</a>"];
	$array_customer[]=["n"=>"Order Reference No.","v"=>$post['transID']]; 
	$array_customer[]=["n"=>"Payment Source","v"=>$post['mop']]; 
	$array_customer[]=["n"=>"Order Date","v"=>$post['tdate']]; 
	$array_customer[]=["n"=>"Credit Card","v"=>$post['card_no']]; 
	$array_customer[]=["n"=>"Descriptor","v"=>$descriptor_nm]; 
	$array_customer[]=["n"=>"Grand Total","v"=>$post['amount_currency']]; 
	if(isset($descriptor5)&&$descriptor5){
		$array_customer[]=["c"=>$descriptor5];
	}
	
	if(trim($post['contact_us_url']) || trim($post['merchant_service_no']) || trim($post['customer_service_email'])){
	
		if(trim($post['contact_us_url'])){
			$contact_us_url_href=" href=\"{$post['contact_us_url']}\" ";
		}else{
			$contact_us_url_href="";
		}
		
		$array_customer[]=["c"=>"<a {$contact_us_url_href}  style=\"color:#668cff;font-size:20px;display:block;width:100%;padding:5px 0 15px 0;\">Merchant Contact Information</a>"]; 
		$array_customer[]=["n"=>"Merchant Phone No.","v"=>$post['merchant_service_no']];
		$array_customer[]=["n"=>"Merchant Email","v"=>$post['customer_service_email']];
	}
	
	$post['ctable1']=c_table($array_customer,'95%');
	
	
	$array_merchant[]=["n"=>"Customer Name","v"=>$post['customer_name']]; 
	$array_merchant[]=["n"=>"Customer’s E-Mail","v"=>$post['customer_email']]; 
	$array_merchant[]=["n"=>"Customer’s Phone No.","v"=>$post['customer_phone']]; 
	$array_merchant[]=["n"=>"Payment Status","v"=>$post['trans_status']]; 
	$array_merchant[]=["n"=>"Descriptor","v"=>$descriptor_nm]; 
	$array_merchant[]=["n"=>"Amount Received","v"=>$post['amount_currency']]; 
	//$array_merchant[]=["n"=>"Customer’s Comments","v"=>$post['comments']]; 
	$post['ctable2']=c_table($array_merchant,'100%');
	
	// Dev Tech : 23-01-07 position change 
	
	$system_note_upd="";
	if(isset($_GET['destroy'])&&$_GET['destroy']=="2"){
		$moto_vt=true; // if ipass trans_status 
	}
	
	$remote_addr=$_SERVER['REMOTE_ADDR'];
	if(isset($_SESSION['integration-type_notify'])&&$_SESSION['integration-type_notify']=="curl_setopt"){
		$remote_addr=$data['Addr'];
	}
	if(isset($_SESSION['client_ip'])){
		$remote_addr=$_SESSION['client_ip'];
	}
		
	 $processed_acquirer_type="";
	 if(!empty($tr_json_value['processed_acquirer_type'])){
		$processed_acquirer_type = "<div class=rmk_row><div class=rmk_date>".date('d-m-Y h:i:s A')."</div><div class=rmk_msg> <b>Processed Acquirer Type - </b> <a class=flagtag>".$tr_json_value['processed_acquirer_type']."</a></div></div>";
	}
		
		/*
		if($status_cc==1 && $moto_vt==false)
		{ // completed update
			$ip_final="{$host_path}/include/ip_final{$data['ex']}?ip=".$remote_addr."&city=".$getresponse['bill_city']."&state=".$getresponse['bill_state']."&zip=".$getresponse['bill_zip']."&type=".$getresponse['tr_type']."&email=".$getresponse['bill_email']."&format=json";
			$ip_file_get = @file_get_contents($ip_final);
			$ip_get = json_decode($ip_file_get, true);
			if(isset($ip_get)){
				if(!empty($processed_acquirer_type)){
					$system_note=$processed_acquirer_type.$ip_get['system_note'].$system_notes;
				}else{
					$system_note=$ip_get['system_note'].$system_notes;
				}
			
				if($ip_get['status']){
					$system_note_upd.=",`system_note`='".$system_note."' ";
					
					if(!empty($ip_get['flag'])){
						$system_note_upd.=",`transaction_flag`=1 ";
					}
				}
			}
		}
		
		*/
		
		
		if((!empty($processed_acquirer_type))&&(empty($system_note_upd))){
			$system_note= $processed_acquirer_type.$system_notes;
			$system_note_upd.=",`system_note`='".$system_note."' ";	
		}
		
		

		if(isset($_SESSION['acquirer_status_code'])&&($_SESSION['acquirer_status_code']==1 || $_SESSION['acquirer_status_code']=="1")){
			$status_cc=0;
			$d['trans_status']="";
			if(isset($getresponse['response'])&&$getresponse['response']){
				//cmn
				$tr_status_set=$getresponse['response'];
			}
			
			$emailer_condition=false;
			$notify_condition=true;
			$transactions_update=true;
		}
		
		
		if((isset($_GET['ctest']))&&($_GET['ctest']==11)){	
			$transactions_update=true;
			$status_cc=1;
			$d['trans_status']='manual testing success';
			$tr_status_set=$d['trans_status'];
			$gateway_transaction_id=$d['trans_status'];
			
			$emailer_condition=true; $notification_customer="2"; 
			$notify_condition=true;
			
			
		}elseif((isset($_GET['ctest']))&&($_GET['ctest']==22)){	
			$transactions_update=true;
			$status_cc=2;
			$d['trans_status']='manual testing failed';
			$tr_status_set=$d['trans_status'];
			$gateway_transaction_id=$d['trans_status'];
			
			$emailer_condition=true; $notification_customer="2"; 
			$notify_condition=true;
		}
		
		$rmk_date=date('d-m-Y h:i:s A');
		
		if(isset($_SESSION['merchantWebSite']) && isset($_SESSION['merchantWebSite'])){
			$support_note = $support_note_get; 
			
			if(!isset($system_note)) $system_note = "";
			$system_note .= "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$_SESSION['merchantWebSite']." </div></div>".(isset($system_notes)?$system_notes:''); 
			
			$system_note_upd=",`system_note`='".$system_note."' ";	
			
			
			
		}else{
			$support_note = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$tr_status_set." </div></div>".$support_note_get;
		}
		
		
		
		$getresponse['comment']=$rmk_date."  -  ".$tr_status_set." by {$data['SiteName']} - IP Address (".$remote_addr.")";
		
		
		
		
		if(isset($_SERVER['HTTP_REFERER'])){
			$d['referer_'.date('YmdHis')]=$_SERVER['HTTP_REFERER'];
		}
		$d['self_'.date('YmdHis')]=$_SERVER['PHP_SELF'];
		
		$d['uri_'.date('YmdHis')]=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
		
		$d=strip_tags_d($d);
		
		if(isset($_REQUEST)){
			$post_txn_value=strip_tags_d($_REQUEST);
			if(isset($post_txn_value['ccno'])) unset($post_txn_value['ccno']);
			if(isset($post_txn_value['ccvv'])) unset($post_txn_value['ccvv']);
			if(isset($post_txn_value['month'])) unset($post_txn_value['month']);
			if(isset($post_txn_value['year'])) unset($post_txn_value['year']);
			$d['post_'.date('YmdHis')]=$post_txn_value;
		}
		
		if(isset($_GET)){
			$d['get_'.date('YmdHis')]=$_GET;
		}
		

		
		if(isset($acquirer_response_arr)&&is_array($acquirer_response_arr)&&isset($d)&&$d){
			//$acquirer_response=implode(',',$d);
			$time_2=date('Y.m.d_H.i.s');
			$acquirer_response_arr[$time_2]=$d;
			$acquirer_response=jsonencode($acquirer_response_arr,1,1);
			
			$acquirer_response=stripslashes($acquirer_response); 
			
			//$acquirer_response=str_replace(array('"{','}"','"[',']"','{"}'),array('{','}','[',']','""'),$acquirer_response);
			$acquirer_response=str_replace(array('"{','}"','{"}'),array('{','}','""'),$acquirer_response);
			
		}else{$acquirer_response="{}";}
		
		if(isset($gateway_transaction_id)&&$gateway_transaction_id){
			$acquirer_ref=$gateway_transaction_id;
		}else{
			$acquirer_ref="{}";
		}
		
		
		if(isset($_SESSION['tr_newid'])){
			//$tr_newid=" AND `id`=".$_SESSION['tr_newid']."";
		}
		
		if($qprint){
			//$transactions_update=true;
			echo "<hr/>transactions_update=>".$transactions_update;
			echo "<hr/>d=>";
			print_r($d);
		}
		
		$trans_response=str_replace(array('Cancelled - ','Transaction has been Scrubbed . Scrubbed Reason :  ',"'"),'',$tr_status_set);
		
		
		//Dev Tech : 23-01-07 modify because trans_status 23 or 22 notify update issue 
		
		//------ reason table	---------------------------------------
		
		$desc_update = "";
			
		if(isset($_REQUEST['upa'])&&$_REQUEST['upa']){
			$desc_update .= "`upa`='".$_REQUEST['upa']."', ";
		}
		
		if(!empty($trans_response)){
			$trans_response=prntext($trans_response);
			$reason_table = db_rows("SELECT * FROM `{$data['DbPrefix']}reason_table` WHERE `reason`='{$trans_response}' LIMIT 1  ",$qprint);
			if(isset($reason_table[0])&&$reason_table[0]){
				$reason_table=$reason_table[0];
				
				if(isset($reason_table['json_log_history'])) unset($reason_table['json_log_history']);
				
				if($tr_status==9){
					$transactions_update=1;
				}
				
				$reason_note_1="Acquirer Reason : ({$status_cc} : {$getresponse['status']})  - ".$trans_response;
				$reason_note_2="<br>Unique Reason : ".jsonencode($reason_table);
				
				if(!isset($system_note)) $system_note = "";
				$system_note .= "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$reason_note_1." </div></div>";
				
				$system_note .= "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$reason_note_2." </div></div>".(isset($system_notes)?$system_notes:''); 
				$system_note_upd=",`system_note`='".$system_note."' ";
				
				$status_cc=(int)$reason_table['status_nm'];
				$getresponse['order_status']=$status_cc;
				$getresponse['status']=$data['TransactionStatus'][$status_cc];
				
				$trans_response=$getresponse['response']=$reason_table['new_reasons'];
				
				$update_time_log['update_log_reason_table_6']=(new DateTime())->format('Y-m-d H:i:s.u');

			}
		}
		
			
		
		if($status_cc=="1"||$status_cc==1){ // Completed
			//start: Notification to Customer on Approved
			$subject_customer="PAYMENT-COMPLETED-EMAIL-TO-CUSTOMER";	
			//start: Notification to Merchant on Approved
			$subject_merchant="PAYMENT-COMPLETED-EMAIL-TO-MERCHANT";
			$notify_condition=true;
			
			$update_time_log['update_log_approved_7']=(new DateTime())->format('Y-m-d H:i:s.u');
			
		}elseif($status_cc=="2" || $status_cc==2 || $status_cc==22 || $status_cc==23){ // Cancelled
			//start: Notification to Customer on Cancelled
			$subject_customer="PAYMENT-FAILED-EMAIL-TO-CUSTOMER";	
			//start: Notification to Merchant on Cancelled
			$subject_merchant="PAYMENT-FAILED-EMAIL-TO-MERCHANT";
			$notify_condition=true;
			
			if(isset($_SESSION['SA']['retrycount'])&&$_SESSION['SA']['retrycount']>0&&$status_cc==2)
				$_SESSION['SA']['retrycount']--;
			
			$update_time_log['update_log_cancelled_8']=(new DateTime())->format('Y-m-d H:i:s.u');
		}
		
	
					
		//------ rewrite url 	---------------------------------------
		
			//BUG review and fix by Dev Tech : 23-01-10 
			if(!empty($status_cc)){
				$getresponse['order_status']=$status_cc;
				$getresponse['status']=$data['TransactionStatus'][$status_cc];
			}

			$subquery .= "order_status=".$getresponse['order_status']."&status=".$getresponse['status']."&reference=".$getresponse['reference']."&transID=".$getresponse['transID']."&trans_response=".urlencode($getresponse['response'])."&descriptor=".urlencode($getresponse['descriptor'])."&tdate=".urlencode($getresponse['tdate'])."&bill_amt=".$getresponse['bill_amt']."&curr=".$getresponse['curr'].$actionurl."&";
	
			if(isset($_SESSION['uniqueID'])){
				$subquery .="uniqueID=".$_SESSION['uniqueID']."&";
			}
			
			
			if(!empty($return_url)){
				if(strpos($return_url,'?') !== false) {
					$return_url=$return_url."&".$subquery;
					$return_url_mer=$return_url."&";
				}
				else{
					$return_url=$return_url."?".$subquery;
					$return_url_mer=$return_url."?";
				}
			}
				
		// Dev Tech : 23-12-18 remodify 
			
		//----------------------------------------------
		
		//$repost_condition=false;
		
	
		
		//re_post failed or success hostUrl check than get session value
		if( ($repost_condition==1 && $tr_json_value['hostUrl'] ) && (!isset($_SESSION['re_post'])) && (!isset($_REQUEST['admin'])) && ($_REQUEST['cron_tab']!='cron_tab') ){
			if(isset($_SESSION['re_post']['acquirer'])){ unset($_SESSION['re_post']['acquirer']); }
			if ((strpos ( $data['urlpath'], $tr_json_value['hostUrl'] ) !== false) ){
			
			}else{
				$cross_domain=str_replace($host_path,$tr_json_value['hostUrl'],$data['urlpath']);
				header("Location:$cross_domain");exit;
			}
		}
		
			
		
		
		// re_post : success transaction_id update in failed_transaction_ids 
		$count_repost=0;
		if( ($repost_condition==1) && (isset($_SESSION['re_post'])) && (isset($_SESSION['re_post']['failed_transaction_ids'])) && ($_SESSION['re_post']['failed_transaction_ids']) && (!isset($_SESSION['merchantWebSite'])) &&$update_execution==true ){
			//echo "<hr/>f=>".$_SESSION['re_post']['failed_transaction_ids'];
			$related_transID=array();
			if($status_cc==1){
				$related_transID['success_transaction_id']=$getresponse['transID'];
				$failed_transaction_ids=$_SESSION['re_post']['failed_transaction_ids'];
			}else{
				$failed_transaction_ids=$_SESSION['re_post']['failed_transaction_ids'].','.$getresponse['transID'];
			}
			$related_transID['failed_transaction_ids']=$failed_transaction_ids;
			
			
			
			$json_related_transID=jsonencode($related_transID);
			
			$failed_transaction_ids_ex=explode(',',$failed_transaction_ids);
			//print_r($failed_transaction_ids);
			if($failed_transaction_ids){
				foreach($failed_transaction_ids_ex as $trVal){
					if($trVal){
						db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` SET `related_transID`='".$json_related_transID."',`reference`=''  WHERE `transID`='".$trVal."' ",$qprint);
						$count_repost++;
						
					}
				}
			}
			
			
			
			$_SESSION['re_post']['countPost']=$count_repost;
			
			if($getresponse['transID']){
				if($status_cc==2){
					$related_transID['recent_failed_tid']=$getresponse['transID'];
				}
				$recent_related_transID=jsonencode($related_transID);
				
				$reference=$trw['reference'];
				
				db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` SET `related_transID`='".$recent_related_transID."',`reference`='".$reference."'  WHERE `transID`='".$getresponse['transID']."' ",$qprint);
				
				$update_time_log['update_log_related_transID_9']=(new DateTime())->format('Y-m-d H:i:s.u');
			}
		}
		
		//echo "<hr/>status_cc=>".$status_cc;  echo "<hr/>f=>".$_SESSION['re_post']['failed_transaction_ids']; exit;
		
		//----------------------------------------------
				
				
		//s2s not pending than not update transactions and not send notify with email
		if( (!isset($_SESSION['adm_login']))&&($trw['trans_status']>0)&&($integrationType=="s2s")  ){
			if(!isset($_SESSION['merchantWebSite'])){
				$notify_condition=false;
				$emailer_condition=false;
				$transactions_update=false;
				//echo "CURL ACCESS DENY"; exit;
			}
		}
		
		
		
		
		if( (!isset($_SESSION['adm_login']))&&($trw['trans_status']>0&&$order_status_count>0)  ){
				$notify_condition=false;
				$emailer_condition=false;
				$transactions_update=false; $session_remove=true;
				
				if((isset($_SESSION['merchantWebSite'])&&$_SESSION['merchantWebSite'])||(trim($trw['reference'])&&$trw['trans_status']==0&&$status_cc>0)){
					$notify_condition=true;
					$emailer_condition=true;
				}
				
				//echo "CURL ACCESS DENY"; exit;
				/*
				if(trim($pre_reason)!=trim($tr_status_set)){
					$transactions_update=true;
				}
				*/
		}
		
		//pending check if trans_status is not pending 
		if($transaction_processing_url==true&&$tr_status>0){
			$notify_condition=false;$emailer_condition=false; $transactions_update=false; $session_remove=true;
		}
		
		
		
		if($trw['trans_status']==9){
			$notify_condition=true;$emailer_condition=true;$transactions_update=true;
			$status_cc=9;
		}
		
		//Bank notify in expired 
		if($tr_id && ( $tr_status==22 || $tr_status==23 ) && ($status_cc==1||$status_cc==2||$status_cc==22||$status_cc==23))
		{
			$notify_condition=true;$emailer_condition=true;$transactions_update=true;
			$session_remove=true;
		}
		
		//cmn ex
		/*
			echo "<hr/>";
			
			echo "<br/><br/><hr/>tr_status=>".$tr_status;
			echo "<br/>status_cc=>".$status_cc;
			echo "<br/><br/>id=>".$trw['id'];
			
			echo "<br/><br/><hr/>emailer_condition=>".$notify_condition;
			echo "<br/>emailer_condition=>".$emailer_condition;
			echo "<br/><br/>transactions_update=>".$transactions_update;
			
			exit;
		*/
		
		
		$reference_upd='';
		
		
		if(isset($support_note)&&$support_note) {
			$support_note = str_replace(array("'"),'',$support_note);
		}
		
		//--------------------------------------------


		// Dev Tech: 24-04-22 Not Admin session and if trans status is 1 - successful than not update transactions, web hook, email and calculations 
		if($trw['trans_status']==1&&!isset($_SESSION['adm_login']))
		{
			$transactions_update=false;
		}
			
		//$qprint=1;
			
		if(!empty($d) && isset($trw['id']) && $trw['id']>0 && $transactions_update==true &&$update_execution==true)
		{ 
	
			$update_time_log['update_log_trans_query_10']=(new DateTime())->format('Y-m-d H:i:s.u');
			
			if(isset($descriptor_nm)&&$descriptor_nm&&(empty($trw['descriptor']))) {
				$system_note_upd .= ", `descriptor`='".$descriptor_nm."' ";
			}
			
			if (empty($trw['rrn']) && trim($trw['rrn'] ?? '') && !empty($_REQUEST['rrn'])) {
				$system_note_upd .= ", `rrn`='" . $_REQUEST['rrn'] . "' ";
			}
			
			if (empty($trw['upa']) && trim($trw['upa'] ?? '') && !empty($_REQUEST['upa'])) {
				$system_note_upd .= ", `upa`='" . $_REQUEST['upa'] . "' ";
			}
			
		
			// query update for master_trans_additional
			$additional_update=$master_update=", `acquirer_response`='{$acquirer_response}',`acquirer_ref`='{$acquirer_ref}', `support_note`='{$support_note}', `trans_response`='{$trans_response}' ".$system_note_upd ;
			
			
		
			if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'){
				$master_update='';
				$additional_update=ltrim($additional_update,',');
				db_query("UPDATE `{$data['DbPrefix']}{$data['ASSIGN_MASTER_TRANS_ADDITIONAL']}` SET ".$additional_update." WHERE `id_ad`='".$trw['id']."' ",$qprint); 
			}

			//dev tech : 24-07-24 save deffer second 
			if(isset($data['TIME_TO_COMPLETION_TRANSACTION_SECONDS'])&&@$data['TIME_TO_COMPLETION_TRANSACTION_SECONDS']=='Y')
			{
				$tdate_micro=micro_current_date();
				$differseconds=humanizef(date_dif($trw['created_date'], $tdate_micro, 'second')); // minute || second
				$differseconds=(int)str_ireplace([' second',' minutes'],'',$differseconds);

				$master_update.=", `runtime`='{$differseconds}'";

			}	
			
			// query update for master_trans_table 
			
			db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` SET  `trans_status`='{$status_cc}' ".$master_update." WHERE `id`='".$trw['id']."' ",$qprint); 

			$update_time_log['update_log_trans_query_11']=(new DateTime())->format('Y-m-d H:i:s.u');	
		}
		
		
		
	
		if($data['cqp']==9) {
			
			echo "<hr/>d==>"; print_r(@$d);
			echo "<hr/>id==>"; print_r($trw['id']);
			echo "<hr/>transactions_update==>".@$transactions_update;
			echo "<hr/>update_execution==>".@$update_execution;

			echo "<br/><hr/>STATUS_CC==>".@$status_cc;
			echo "<hr/>acquirer_status_code==>".@$_SESSION['acquirer_status_code'];
			echo "<hr/>_POST==>";
			print_r($_POST);
			exit; 
		}
		
		
		
		if($request_money &&$update_execution==true){
			db_query("UPDATE `{$data['DbPrefix']}request_trans_table` SET `status`='{$getresponse['status']}', `transID`='".$getresponse['transID']."' WHERE `id`='".$getresponse['reference']."'  AND `clientid`=".$getresponse['merID']." ",$qprint);	
			
			$update_time_log['update_log_request_trans_table_12']=(new DateTime())->format('Y-m-d H:i:s.u');	
		}
	
		
		
		if(isset($_SESSION['adm_login'])){
			//calculation_trans_fee($tr_id,$getresponse['merID']);
		}else{
			
			//if($tr_id&&$tr_status==0)
			//if($tr_id && ($status_cc==1||$status_cc==2))
				
			/*			if($tr_id&&($tr_status==0||$tr_status==22||$tr_status==23)&&($status_cc==1||$status_cc==2))
			{
				calculation_trans_fee($tr_id,$getresponse['merID']);
			}
			*/
		}
		
	


		if(isset($_SESSION['acquirer_status_code'])&&($_SESSION['acquirer_status_code']==1 || $_SESSION['acquirer_status_code']=="1")){

				$processing_url = "{$host_path}/transaction_processing{$data['ex']}?transID={$getresponse['transID']}&reference={$getresponse['reference']}&status={$getresponse['status']}&trans_response=".($trans_response?$trans_response:"Transaction%20in%20processing");
				
		}
		
		
		
		//re_post failed ----------------
		if( (($repost_condition==1) && ($status_cc==2||$status_cc==22||$status_cc==23||$tr_status==22||$tr_status==23) && (isset($_SESSION['re_post']))) && (!isset($_SESSION['merchantWebSite'])) && ($tr_status!=10) ){

			if(@$transID=='5115409140')
			{
				echo "<br/><hr/><br/>post_redirect=><br/>";
				echo "<br/><hr/><br/>repost_condition=><br/>".$repost_condition;
				echo "<br/><hr/><br/>_SESSION re_post=><br/>"; print_r($_SESSION['re_post']); 
				echo "<br/>merchantWebSite=>".$_SESSION['merchantWebSite']; 
				echo "<br/>status_cc=>".$status_cc; 
				echo "<br/>tr_status=>".$tr_status; 
				//exit;
			}
			
			$emailer_condition=false;
				$notify_condition=false;
			
			if(isset($_SESSION['re_post']['failed_transaction_ids'])){
				$_SESSION['re_post']['failed_transaction_ids']=			$_SESSION['re_post']['failed_transaction_ids'].",".$getresponse['transID'];
			}else{
				$_SESSION['re_post']['failed_transaction_ids']=$getresponse['transID'];
			}
			
			//$_SESSION['re_post']['failed_trans_response']=$trans_response ." in ".$query_account[0]['checkout_level_name'];
			$_SESSION['re_post']['failed_reason1']=$trans_response;
			$_SESSION['re_post']['failed_reason']=$getresponse['response'];
			$_SESSION['re_post']['failed_type']=$getresponse['tr_type'];
			$_SESSION['re_post']['return_failed_url']=$data['urlpath'];
			
			
			if($count_repost>2){
			 // $_GET['ctest']=1;
			}
			
			$query_str='';
			if(isset($_GET['ctest'])){
				$query_str='?ctest='.$_GET['ctest'];
			}
			
			if(isset($tr_json_value['process_file'])){
				$paymentflow=$tr_json_value['process_file'];
			}else{
				$paymentflow='paymentflow';
			}
			
			$update_time_log['update_log_post_redirect_13']=(new DateTime())->format('Y-m-d H:i:s.u');
			
			$re_post_url="{$host_path}/{$paymentflow}{$data['ex']}{$query_str}";
			$re_post=$_SESSION['re_post'];
			post_redirect($re_post_url, $re_post); exit;
		}
			
		
		
		if(isset($_REQUEST['cron_tab'])){
			//$notify_condition=true; $emailer_condition=true;
		}
		
		if(trim($trw['reference'])&&$trw['trans_status']==0&&$status_cc>0){
			$emailer_condition=true;
		}


		
		//Dev Tech : 24-07-17 Not send the emailer when not empty trans_response & trans_status is 0 & acquirer response is 0 via 1 = pending and 1 not in  trans_status & not in admin session 
		if(($tr_status==$status_cc&&$tr_status!=1)&&(!isset($_SESSION['adm_login']))) $emailer_condition=false;

		//Dev Tech : 24-07-17 if status is pending then not send the email for merchant or customer 
		if($tr_status==0&&$status_cc==0) $emailer_condition=false;

		
		// Not Admin session and if trans status is 1 - successful than not update transactions, web hook, email and calculations 
		if($trw['trans_status']==1&&!isset($_SESSION['adm_login']))
		{
			$emailer_condition=false;
		}

		
		//---move emailer after webhook --------------------------------------------
		
	
			
	if($qprint){
		if(isset($_GET['pr2'])&&$_GET['pr2']==2){
			echo "<hr/>";
			echo "<hr/>emailer_condition=>".$emailer_condition;
			echo "<hr/>notification_merchant=>".$notification_merchant;
			echo "<hr/>subject_merchant=>".$subject_merchant;
			echo "<hr/>mer_trans_alert_email=>".$mer_trans_alert_email;
			
			echo "<hr/>notification_customer=>".$notification_customer;
			echo "<hr/>subject_customer=>".$subject_customer;
			echo "<hr/>email_customer=>".$getresponse['bill_email'];
			echo "<hr/>transID=>".$getresponse['transID'];
				
			echo "<hr/>subquery=>".$subquery;echo "<hr/>1getresponse=>";print_r($getresponse);
		}
		if(isset($_GET['pr3'])&&$_GET['pr3']==3){
			exit;die();
		}
	}

	
	// Dev Tech : 23-11-14 modify for is not s2s to check theme 

	if(isset($tr_json_value['post']['integration-type'])&&$tr_json_value['post']['integration-type']!="s2s"){
		$g_sid=(int)@$memb['sponsor'];$g_mid=0; 
		$domain_server=sponsor_themefc($g_sid,$g_mid);
		if($tr_id&&($tr_status==0||$tr_status==22)&&$tr_json_value['status_'.$type_tr]){
			$data['check_status']=$tr_json_value['status_'.$type_tr];
		}
		if($tr_id&&($tr_status==0||$tr_status==22)&&$tr_json_value['s30_count']){
			$data['s30_count']=$tr_json_value['s30_count'];
		}
		
	}

//webhook //return response 
//Dev Tech : 23-04-05 Retrun Response to url or webhook of merchant 

$return_response_arr["transID"]=$getresponse['transID'];
$return_response_arr["order_status"]=$getresponse['order_status'];
$return_response_arr["status"]=$getresponse['status'];
$return_response_arr["bill_amt"]=$getresponse['bill_amt'];
$return_response_arr["descriptor"]=$getresponse['descriptor'];
$return_response_arr["tdate"]=$getresponse['tdate'];
$return_response_arr["bill_currency"]=$getresponse['curr'];
$return_response_arr["response"]=$getresponse['response'];
$return_response_arr["reference"]=$getresponse['reference'];

if(!isset($getresponse['authdata'])||empty($getresponse['authdata'])) 
$return_response_arr["mop"]=$getresponse['mop'];

if($channel_type==2||$channel_type==3){
	$return_response_arr["ccno"]=$getresponse['ccno'];
}

//if(isset($getresponse['rrn'])&&trim($getresponse['rrn'])) 
	$return_response_arr['rrn']=@$getresponse['rrn'];

	$return_response_arr['upa']=@$getresponse['upa'];

$return_response_arr["reference"]=$getresponse['reference'];
$return_response_arr["authstatus"]=$data['Host']."/authstatus".$data['ex']."?action=authstatus&transID=".$getresponse['transID'];


//Dev Tech: 25-02-10 If the status is neither 0 or 9, stop the execution of authurl and authdata.
if( ( (@$status_cc > 0 || @$tr_status_nm > 0) && (!isset($is_test)) ) || (isset($is_test)&&$is_test=="9"&&@$tr_status_nm==0) )
{
	if(isset($getresponse['authurl'])) unset($getresponse['authurl']);
	if(isset($getresponse['authdata'])) unset($getresponse['authdata']);
}

if(isset($getresponse['authurl'])&&$getresponse['authurl'])  $return_response_arr["authurl"]=$getresponse["authurl"];
if(isset($getresponse['authdata'])&&$getresponse['authdata']) $return_response_arr["authdata"]=$getresponse['authdata'];




$data['webhook_url']=$webhook_url;
//$data['return_url']=$return_url;
if(isset($return_url_mer)&&$return_url_mer)
	$data['return_url']=$return_url_mer.http_build_query($return_response_arr);
$data['source_url']=$source_url;



	if($qprint)
	{
		echo "<hr/>";
		echo "<hr/>transID=>".$getresponse['transID'];
			
		echo "<hr/>return_response_arr=>";print_r($return_response_arr);
	}




	$_SESSION['SA']['type'] = $getresponse['tr_type'];
	$_SESSION['SA']['transID'] = $getresponse['transID'];
	

	if(isset($post['step'])) unset($post['step']);	
	if(isset($getresponse['terNO'])) unset($getresponse['terNO']);
		if(isset($getresponse['merID'])) unset($getresponse['merID']);
		if(isset($getresponse['comment'])) unset($getresponse['comment']);
	
	if(isset($getresponse['mode_info'])) unset($getresponse['mode_info']);
	if(isset($getresponse['tr_type'])) unset($getresponse['tr_type']);
	if(isset($_SESSION['clientid'])) unset($_SESSION['clientid']);
	if(isset($_SESSION['pid'])) unset($_SESSION['pid']);
	if(isset($_SESSION['terNO'])) unset($_SESSION['terNO']);
	
	if(isset($getresponse['memail'])) unset($getresponse['memail']);
	if(isset($getresponse['company_name'])) unset($getresponse['company_name']);
	if(isset($getresponse['bussinessurl'])) unset($getresponse['bussinessurl']);
	if(isset($getresponse['contact_us_url'])) unset($getresponse['contact_us_url']);
	if(isset($getresponse['customer_service_no'])) unset($getresponse['customer_service_no']);


	$data['moto_vt']=$moto_vt;
	
	/*
	echo "<br/>webhook_url=>".$webhook_url;
	echo "<br/>notify_condition=>".$notify_condition;
	exit;
	*/
	
	
	// Dev Tech : 25-02-04 bug fix 
	
	$notify_status=jsonvaluef($tr_json_value_str,'NOTIFY_STATUS');
	$notify_failed_source=jsonvaluef($tr_json_value_str,'NOTIFY_FAILED_SOURCE');
	if ((trim($notify_status ?? '') || trim($notify_failed_source ?? '')) && ($status_cc == 0 || $getresponse['order_status'] == 0)) {
		$notify_condition = false;
	}
	
	
	// Dev Tech : 23-12-06 remodify 
	//if(trim($trw['reference'])&&($trw['trans_status']==0||$trw['trans_status']==22)&&$status_cc>0)
	//if(trim($trw['reference'])&&$status_cc>0)
	if($status_cc>0||isset($_SESSION['adm_login']))
	{
		$notify_condition=true;
	}
	
	// Dev Tech : 23-09-19 notify update  
	if( (isset($_REQUEST['actionurl'])&&$_REQUEST['actionurl']=='notify') || (isset($_REQUEST['action'])&&$_REQUEST['action']=='webhook') )
	{
		$notify_condition=true;
	}

	
	$updated_by='';
	
	if(isset($_REQUEST['cron_tab'])&&$_REQUEST['cron_tab']){
		if(isset($_REQUEST['cron_host_response'])&&$_REQUEST['cron_host_response'])
		$updated_by='Crons notify updating - <b>'.$_REQUEST['cron_host_response'].'</b> | ';
	
		else 
		$updated_by='Crons notify updating - <b>'.$_REQUEST['cron_tab'].'</b> | ';
	}
	
	if(isset($_SESSION['adm_login'])){
		if(isset($_SESSION['sub_admin_id'])){
			$admin_id=$_SESSION['sub_admin_id'].":".$_SESSION['sub_admin_fullname']."-".$_SESSION['sub_admin_rolesname'];
		}elseif(isset($_SESSION['m_username'])&&(!isset($_SESSION['adm_login']))){
			$admin_id="Merchant:".$_SESSION['uid']."-".$_SESSION['m_username'];
		}else{
			if(isset($_SESSION['admin_id'])&&isset($_SESSION['sub_username'])){
				$admin_id="Admin : ".$_SESSION['admin_id']." - ".$_SESSION['sub_username'];
			}
			elseif(@$uid)
			{
				$admin_id="Merchant:".$uid."-".get_clients_username($uid);
			}
			else{
				$admin_id='Admin...';
			}
		}
		
		if($admin_id) $updated_by='Notify updating via <b>'.$admin_id.'</b> | ';
	}
	
	if(isset($_REQUEST['webhook_id'])&&trim($_REQUEST['webhook_id']))
		$webhook_id=" | <b>Webhook ID - {$_REQUEST['webhook_id']}</b> ";
	else $webhook_id='';


	//Dev Tech : 24-07-17 Not send the webhook when not empty trans_response & trans_status is 0 & acquirer response is 0 via 1 = pending and 1 not in  trans_status & not in admin session 
	if(!empty(trim($trw['trans_response']))&&($tr_status==$status_cc&&$tr_status!=1)&&(!isset($_SESSION['adm_login']))) $notify_condition=false;
	//if(!empty(trim($trw['trans_response']))&&($tr_status==0&&$status_cc==0&&$tr_status!=1)&&!isset($_SESSION['adm_login'])) $notify_condition=false;
	
	

	// Not Admin session and if trans status is 1 - successful than not update transactions, web hook, email and calculations 
	if(($trw['trans_status']==1&&!isset($_SESSION['adm_login']))|| (@$status_cc == 0 && @$tr_status_nm==0))
	{
		$notify_condition=false;
	}

	//Notify when test transaction is pending 
	if(isset($is_test)&&$is_test=="9"&&@$tr_status_nm==0)
		$notify_condition=true;
	
	if((!empty($webhook_url)) && ($notify_condition==true))
	{

		$webhook_url=curl_url_replace_f($webhook_url);

		$webhook_post_res = http_build_query($return_response_arr);

		//Dev Tech: 25-05-03 webhook encryption if encryption_method is aes256 and private_key and public_key is set
		if(isset($tr_json_value['post']['encryption_method'])&&strtolower($tr_json_value['post']['encryption_method'])=='aes256'&&isset($memb['private_key'])&&isset($tr_json_value['post']['public_key'])&&@$memb['private_key']&&@$tr_json_value['post']['public_key'])
		{
			$webhook_post_res=encryption_sha256_f($webhook_post_res,$memb['private_key'],$tr_json_value['post']['public_key']);
			$webhook_post_res="encryption_data=".$webhook_post_res;
		}

		$return_response_arr['webhook']="notify";	
		// Merchant received for notify_via s2s_base_notify
		$return_response_arr['webhook_via']="s2s_base_webhook";		
		$chs = curl_init();
			curl_setopt($chs, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);
		curl_setopt($chs, CURLOPT_URL, $webhook_url);
		curl_setopt($chs, CURLOPT_HEADER, false); // FALSE || true || 
			curl_setopt($chs, CURLOPT_MAXREDIRS, 10);
		curl_setopt($chs, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($chs, CURLOPT_SSL_VERIFYHOST, 0);
		curl_setopt($chs, CURLOPT_SSL_VERIFYPEER, 0);
		curl_setopt($chs, CURLOPT_POST, true);
		curl_setopt($chs, CURLOPT_POSTFIELDS, $webhook_post_res);
		curl_setopt($chs, CURLOPT_TIMEOUT, 10);
		$notify_res = curl_exec($chs);
		curl_close($chs);
		
		$update_time_log['update_log_webhook_url_16']=(new DateTime())->format('Y-m-d H:i:s.u');
		
		#######	save notificatio response	#############
		if($tr_id&&$tr_id>0){
			//$return_notify_json='{"notify_code":"00","notify_msg":"received"}'; echo ($return_notify_json); exit;
			
			$time_1=date('Y.m.d_H.i.s');
			$notify_de = json_decode($notify_res,true);
			if(isset($notify_de)&&is_array($notify_de)){
				//print_r($notify_de);
				if(isset($notify_de['notify_msg'])&&$notify_de['notify_msg']=='received'){
					$tr_upd_notify['NOTIFY_CALLBACKS']['MERCHANT_RECEIVE']='NOTIFY_RECEIVE';
				}
			}	
			$tr_upd_notify['NOTIFY_CALLBACKS']['NOTIFY_STATUS']='DONE';
			$tr_upd_notify['NOTIFY_CALLBACKS']['time']=prndates(date('Y-m-d H:i:s'));
			$tr_upd_notify['NOTIFY_CALLBACKS']['NOTIFY_SEND_SOURCE']='webhook';

			$return_response_arr_res=$return_response_arr;

			//Dev Tech: 24-12-13 Skip authdata save in json log if is enable of auth_data_not_save
			if(isset($tr_json_value['auth_data_not_save'])){
				if(isset($return_response_arr_res['authdata'])) unset($return_response_arr_res['authdata']);
			}

			$tr_upd_notify['NOTIFY_CALLBACKS']['RES']=$return_response_arr_res;
			
			$tr_upd_notify['system_note']='<b>Source - callback</b>'.$webhook_id.' | <b>'.$updated_by.$getresponse['status'].'</b> trans_status sent on '.$webhook_url;
			//$tr_upd_notify['NOTIFY_CALLBACKS']['get_info']=htmlentitiesf($notify_res);
			
			$update_time_log['update_log_webhook_url_17']=(new DateTime())->format('Y-m-d H:i:s.u');
			
			trans_updatesf($tr_id, $tr_upd_notify);
			
			$update_time_log['update_log_webhook_url_log_19']=(new DateTime())->format('Y-m-d H:i:s.u');
			//exit;
			
			
		}
	}
	elseif(($tr_id&&$tr_id>0) && ($notify_condition==true)){
		$tr_upd_notify['NOTIFY_FAILED_TIME']=prndates(date('Y-m-d H:i:s'));
		$tr_upd_notify['NOTIFY_FAILED_SOURCE']='webhook';
		$tr_upd_notify['NOTIFY_FAILED']='Missing notify url';
		$tr_upd_notify['system_note']='<b>Source - callback</b>'.$webhook_id.' | <b>'.$updated_by.$getresponse['status'].'</b> trans_status <b>notify skipped</b> as <b>notify url missing</b>';
		trans_updatesf($tr_id, $tr_upd_notify);
	}
	
	//Dev Tech: 23-12-30 fee update after email and webhook the merchant 



	//Dev Tech: 25-01-05 emailer position change 

	//emailer_and_notify=true;
	if($emailer_condition==true)
	{
		$post['clientid']=$trw['merID'];
		if(isset($_SESSION['tr_newid'])){
			$post['tableid']=$_SESSION['tr_newid'];
		}else{$post['tableid']='';}
		
		if($notification_customer=="2"){ 
			if(isset($subject_customer)&&$subject_customer&&$getresponse['bill_email']){
				$post['mail_type']="9";
				$post['email']=$getresponse['bill_email'];
				send_email($subject_customer, $post);
				
				$update_time_log['update_log_notification_customer_14']=(new DateTime())->format('Y-m-d H:i:s.u');
			}
		}
		
		if($notification_merchant=="1"){
			if($subject_merchant&&$mer_trans_alert_email){
				$post['mail_type']="10";
				$post['email']=$mer_trans_alert_email;
				send_email($subject_merchant, $post);
				$update_time_log['update_log_notification_merchant_15']=(new DateTime())->format('Y-m-d H:i:s.u');
			}
			
		}
		
		
			
			
	} 
	
	
	
	if(@$getresponse['transID']=='5115409140')
	{
		echo "<br/><hr/><br/>_SESSION adm_login=>".@$_SESSION['adm_login'];
		echo "<br/><hr/><br/>trans_status=>".@$trw['trans_status'];
		echo "<br/><hr/><br/>tr_id=>".@$tr_id;
		echo "<br/><br/><hr/><br/>update_execution=>".@$update_execution;
		echo "<br/><hr/><br/>tr_status=>".@$tr_status;
		echo "<br/><hr/><br/>status_cc=>".@$status_cc;
	}
	
		// Not Admin session and if trans status is 1 - successful than not update transactions, web hook, email and calculations 
		if($trw['trans_status']==1&&!isset($_SESSION['adm_login']))
		{
			//not going to calculation_trans_fee
		}
		elseif(isset($_SESSION['adm_login'])){
			$update_time_log['update_log_calculation_trans_fee_via_admin_20']=(new DateTime())->format('Y-m-d H:i:s.u');
			//echo "<br/>merID==>".$trw['merID'];
			calculation_trans_fee($tr_id,$trw['merID']);
			$update_time_log['update_log_calculation_trans_fee_via_admin_21']=(new DateTime())->format('Y-m-d H:i:s.u');
		}else{
			if($tr_id &&$update_execution==true &&($tr_status==0||$tr_status==22||$tr_status==23)&&($status_cc==1||$status_cc==2||$status_cc==23))
			{
				$update_time_log['update_log_calculation_trans_fee_20']=(new DateTime())->format('Y-m-d H:i:s.u');
				
				calculation_trans_fee($tr_id,$trw['merID']);
				
				$update_time_log['update_log_calculation_trans_fee_21']=(new DateTime())->format('Y-m-d H:i:s.u');
				$update_time_log['update_log_calculation_trans_fee_21_tr_status']=$tr_status;
				$update_time_log['update_log_calculation_trans_fee_21_status_cc']=$status_cc;
			}
		}
	
	
	$getresponse['webhook']="OK";	
	$return_response_arr['webhook']="OK";	
	if(isset($return_response_arr['webhook_via'])) unset($return_response_arr['webhook_via']);

	$data['getresponse']=$getresponse;
	$data['return_response_arr']=$return_response_arr;
	
	/*
	echo "<br/>re_post_url=>".$re_post_url;
	echo "<br/>re_post=>";print_r($re_post);
	echo "<br/>_SESSION=>";print_r($_SESSION);
	exit;
	*/
	//re_post failed ----------------
	if( isset($re_post_url) && isset($re_post) && $re_post_url && $re_post ){
		//post_redirect($re_post_url, $re_post); exit;
	}

	if(isset($_REQUEST['session_destroy'])&&@$_REQUEST['session_destroy']=='N')
	{
		// skip session remove 

	}
	elseif($moto_vt==false||$session_remove==true){
		foreach($_SESSION as $key=>$value){
			if($key!='s30_count' && $key!='SA') unset($_SESSION[$key]);
			//if($key!='s30_count' && $key!='SA' && $key!='DB_CON' && $key!='db_ad' && $key!='db_mt') unset($_SESSION[$key]);
		}
	}else{
		$_SESSION['transID']=$getresponse['transID'];
		$_SESSION['price']=$getresponse['price'];
	}

}
	
if(isset($update_time_log)&&count($update_time_log)>0&&is_array($update_time_log)&&isset($trw['id'])&&$trw['id']>0&&!isset($_SESSION['adm_login']) &&$update_execution==true)
{
	$update_time_log['update_log_22']=(new DateTime())->format('Y-m-d H:i:s.u');
	$update_time_log['update_time_log_'.(new DateTime())->format('Y-m-d H:i:s.u')]=$update_time_log;
	if(@$qp){
		echo "<br/><br/><=update_time_log=>";
		print_r($update_time_log);
	}
	
	trans_updatesf($trw['id'], $update_time_log);
}
	
		//-----------------------------------------------
//Dev Tech: 24-01-30 Add for disconnect the db 
//db_disconnect();		
		
if(isset($_REQUEST['acquirer_retrun_json_response'])&&@$_REQUEST['acquirer_retrun_json_response']=='Y'){
	echo $arrayEncoded4 = jsonencode($return_response_arr);
	exit;
}
if(isset($_REQUEST['cron_tab'])||isset($_GET['cron_tab'])){
	exit;
}
elseif((isset($_REQUEST['actionurl']))&&($_REQUEST['actionurl']=="mer")){
	if((isset($_REQUEST['redirecturl']))&&($_REQUEST['redirecturl'])){
		$redirecturl=$_REQUEST['redirecturl'];
		//echo $redirecturl;
		header("location:$redirecturl");
	}
	exit;
}elseif((isset($_REQUEST['actionurl']))&&($_REQUEST['actionurl']=="by_admin"||$_REQUEST['actionurl']=="admin_direct"||$_REQUEST['actionurl']=='notify')){
	exit;
}elseif((isset($_REQUEST['action']))&&($_REQUEST['action']=="by_admin"||$_REQUEST['action']=="admin_direct"||$_REQUEST['action']=='webhook'||$_GET['action']=='webhook')){
	
	exit;
}


//exit;
?>