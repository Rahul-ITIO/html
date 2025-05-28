<?
//error_reporting(0);
if(!isset($_SESSION)) {session_start();}
/*
//To check how many request post with same IP
if(isset($_SESSION['re_post']['countPost'])&&!empty($_SESSION['re_post']['countPost'])&&((isset($data['process_file']))&&($data['process_file']!='quay'))&&$_SESSION['re_post']['countPost']>19){ // 19 || 5 
	//echo $_SESSION['re_post']['countPost'];
	$dataDb['db_ip_count']=20;	//if 20 request post with same IP then IP to be block 
	$file_create_htaccess_1=('create_htaccess.do');	//write write .htaccess file via using create_htaccess.do file
	if(file_exists($file_create_htaccess_1)){//check file exists or not, if exists then include and exit
		include($file_create_htaccess_1);exit;
	}
}
*/
$data['pq']=0;
//if($_SESSION['clientid']==2101) $data['pq']=1; 

$data['PageName']='ORDER SUMMARY';
$data['PageFile']='payin-processing-engine';
$data['HideMenu']=true;
$data['HideAllMenu']=true;
$data['SponsorDomain']=1;
$data['API_VER']=2; // directapi
//$data['SESSION_UNSET']=true;
###############################################################################
function error_print($error,$message,$json=true){	//to use of this function print error
	$jsonarray['Error']=$error;	//use for error code
	$jsonarray['Message']=$message;	//use for error message
	header("Content-Type: application/json", true);	//set header content-type
	echo $arrayEncoded2 = json_encode($jsonarray,true);	//print error in json format
	exit;
}
/*
if( ((!isset($_REQUEST)) || (count($_REQUEST)==0)) && ((isset($data['process_file']))&&($data['process_file']!='payme')&&($data['process_file']!='quay')) )
{
	$data1['Error']=1041;
	$data1['Message']="Required parameters are missing";
	error_print($data1['Error'],$data1['Message']);exit;
}
*/



include('config.do');

//print_r($_REQUEST);
include('include/country_state'.$data['iex']);	//include this file to fetch country and bill_state codes
$file_v="";
if((strpos($data['urlpath'],"api_2")!==false)){$file_v="2";}


$data['PageTitle'] = 'Order Details - '.$data['domain_name']; 
$jsonarray=array();
//$status = json_decode($_POST["x"], false);
// write log at the very begning
$glogs=$plogs=array();
if (!empty($_GET)){$glogs=$_GET;}
if (!empty($_POST)){$plogs=$_POST;}
$logs=array_merge($glogs,$plogs,$_SERVER);
$logs=json_encode($logs,true);
$fmsc = microtime(true);
$logs="/nQuery started @:".$fmsc."/n/n".$logs;
//if ($logs!=''){wh_log($logs);}
// END write log at the very begning

//echo $_SESSION['domain_server']['as']['cardbin_cashfree_key'];
//	print_r($_SESSION);exit;

function prnsumf($summ,$cur=''){	//returned the numeric value with two decimal point without comma (,)
	$summ=(float)str_replace(",", "", $summ);
	return $summ_bill_amt=number_format(($summ>0?($summ):(-$summ)), '2', '.', '');
}
function luhn($number){
    $number = (string)$number;
    if (!ctype_digit($number)) {return FALSE;}
    $length = strlen($number);
    $checksum = 0; // Checksum of the card number
    for ($i = $length - 1; $i >= 0; $i -= 2) {
        $checksum += substr($number, $i, 1); // Add up every 2nd digit, starting from the right
    }
    for ($i = $length - 2; $i >= 0; $i -= 2) {
        $double = substr($number, $i, 1) * 2; // Add up every 2nd digit doubled, starting from the right
        $checksum += ($double >= 10) ? ($double - 9) : $double; // Subtract 9 from the double where value is greater than 10
    }
    return ($checksum % 10 === 0); // If the checksum is a multiple of 10, the number is valid
}

//validate the card type 
function validatecard($number){
    global $cardName;
    $mops = array(
		"visa"		=> "/^4[0-9]{12}(?:[0-9]{3})?$/",		//visa start from four (4)
		"mastercard"=> "/^5[1-5][0-9]{14}$/",				//master card start from five (5)
		"amex"		=> "/^3[47][0-9]{13}$/",				//amex card start from three (3)
		"rupay"		=> "/^6[0-9]{12}(?:[0-9]{3})?$/",		//rupay start from six (6)
		"discover"	=> "/^6(?:011|5[0-9]{2})[0-9]{12}$/",	//discover Card begin with 6011 or 65.
		"jcb"		=> "/^(3[0-9]{4}|2131|1800)[0-9]{11}$/",//jcb  Card numbers begin with 35.
		"diners"	=> "/^3(0[0-5]|[68][0-9])[0-9]{11}$/",	//diners card 300 through 305, 36 or 38
    );
	foreach($mops as $key=>$value){
		if (preg_match($mops[$key],$number)){
			$cardName= $key;return $key;
		}
	}
}
function create_guid() {
    $charid = strtoupper(md5(uniqid(mt_rand(), true)));
    $hyphen = chr(45); // "-"
    $uuid = substr($charid, 0, 8) . $hyphen
    . substr($charid, 8, 4) . $hyphen
    . substr($charid, 12, 4) . $hyphen
    . substr($charid, 16, 4) . $hyphen
    . substr($charid, 20, 12);
    return $uuid;
}
function data_decode_f($string,$private_key,$website_public_key) {	//decode string which encode via AES-256-CBC hash with private_key and token
    $output = false;
    $encrypt_method = "AES-256-CBC";	//encrypt method
    $iv = substr( hash( 'sha256', $website_public_key ), 0, 16 );
	$output = openssl_decrypt( base64_decode( $string ), $encrypt_method, $private_key, 0, $iv );
    return $output;
}
if(isset($_SESSION['login']) && $_SESSION['login'] && @$post['action']=='moto_status'){	//check login session exists or not
	$post['clients']=$_SESSION['uid'];	//store login id into clients in post array
	$post['clientid']=$post['clients'];	//store same value in clientid
	
}



###############################################################################


//initilize the array and variables 
$post['acquirer_id_check_arr']=[];
$post['acquirer_id_card_arr']=[];
$post['acquirer_id_ewallets_arr']=[];
$post['acquirer_id_net_banking_arr']=[];
$post['acquirer_id_upi_arr']=[];
$post['acquirer_id_upi2_arr']=[];

$post['acquirer_id_check']="";
$post['acquirer_id_card']="";
$post['acquirer_id_ewallets']="";
$post['t_name6']="";
$post['acquirer_id_net_banking']="";
$post['acquirer_id_upi']='';
$post['acquirer_id_upi2']="";


$json_log_arr=[];
if(isset($_GET)){ $json_log_arr=array_merge($json_log_arr,$_GET); }
if(isset($_POST)){ $json_log_arr=array_merge($json_log_arr,$_POST); }
//echo "<br/>json_log_arr=>"; print_r($json_log_arr);


$validation=true; $addressValidation=true; $stateValidation=false; $settlementVali=true;$merchant_pays_fee=0; $luhn_validation=true;

$inputValidation=false; $inputName='';


if(!isset($post['step'])){
	
	$_SESSION['info_data']=array();
	
	
	//mention the list of variable for unset from the $_SESSION
	$unset_session_1=["curling_access_key","scrubbed_msg","curl_process","failed_reason","bank_processing_amount","a","af","merchant_pays_fee","afj","AccountInfo","curr_smbl","curr","post","mISO2","descriptor","post_step0","bill_currency","bank_processing_curr","default_currency","trans_currency","bill_ip","store_midcard","common_midcard","store_midcard_test_mode","bill_amt","total","total_payment","AccountInfo_mcc_code","bank_mcc_code","select_mcc","bank_mcc_code_global","select_mcc_list","inactive_fail_bank_list","acquirer_id","inactive_acquirer_arr","inactive_bank_ac_list","DB_CON","DB_CON_NAME"];
	
	unset_sessionf($unset_session_1);
	
	$_SESSION['json_value']=array();

	//$_SESSION['SESSION_UNSET']=true;
	
	//if action and bid values are not set the set product as a default in 'action'
	if(!isset($post['action'])&&!isset($post['bid'])){ $post['action']="product"; }
	
	//If con_name is 'clk' the assign following values - like country code is "IN" and so on...
	if(isset($data['con_name'])&&$data['con_name']=='clk'){
		if(!isset($post['bill_country'])){ $post['bill_country']="IN"; }
		if(!isset($post['bill_address'])){ $post['bill_address']="NA"; }
		if(!isset($post['bill_street_2'])){ $post['bill_street_2']="NA"; }
		if(!isset($post['bill_city'])){ $post['bill_city']="NA"; }
		if(!isset($post['bill_zip'])){ $post['bill_zip']="NA"; }
	}
	
	//check if terminal_id in request then store into terminal_id into $_POST and $post array
	if((isset($_REQUEST['terminal_id']))&&($_REQUEST['terminal_id'])){
		//$_POST=array_merge(["terminal_id"=>$_REQUEST['terminal_id']],$_POST);
		$_POST["terminal_id"]=$_REQUEST['terminal_id'];
		$post["terminal_id"]=$_REQUEST['terminal_id'];
	}
	//check if acquirer_id in request then store into acquirer into $_POST and $post array
	if((isset($_REQUEST['acquirer_id']))&&(trim($_REQUEST['acquirer_id']))){
		$_POST["acquirer"]=$_REQUEST['acquirer_id'];
		$post["acquirer"]=$_REQUEST['acquirer_id'];
	}
	
	
	
	
	##################################################################
		
		$REMOTE_ADDR=(isset($_SERVER['HTTP_X_FORWARDED_FOR'])&&$_SERVER['HTTP_X_FORWARDED_FOR']?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR']);
		if(strpos($REMOTE_ADDR,',')!==false){
			$REMOTE_ADDR=explode1(',',$REMOTE_ADDR)[0];
		}
		$_POST['REMOTE_ADDR']=$REMOTE_ADDR;
		
		if((!empty($post['bill_ip']))){
			$data['Addr']=$post['bill_ip'];
			$_SESSION['bill_ip']=$post['bill_ip'];
		}else{
			$_SESSION['bill_ip']=(isset($_SERVER['HTTP_X_FORWARDED_FOR'])&&$_SERVER['HTTP_X_FORWARDED_FOR']?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR']);
		}
		
		if(strpos($_SESSION['bill_ip'],',')!==false){
			$c_ip_ex=explode1(',',$_SESSION['bill_ip']);
			$_SESSION['bill_ip']=$c_ip_ex[0];
		}
		
		if(isset($post['integration-type'])&&$post['integration-type']!='s2s'&&$REMOTE_ADDR){
			$_SESSION['bill_ip']=$REMOTE_ADDR;
		}
		
		
		//Dev Tech : 23-06-30 Validation check if unique_reference is Y must be required reference
		
		if((isset($post['unique_reference'])&&$post['unique_reference']=='Y')&&(!isset($post['reference'])||empty(trim($post['reference'])))){
			$data['Error']=111;
			$data['Message']="Reference Value Not Available";
			error_print($data['Error'],$data['Message']);
		}
		
		/*
		$skip_bill_ip=array('127.0.0.1', 'unknown');
		if((in_array(strtolower($_SESSION['bill_ip']),$skip_bill_ip)||!checkIPAddressf($_SESSION['bill_ip']))&&$data['localhosts']==false){
			$data['Error']=1042;
			$data['Message']="Invalid Billing IP ({$_SESSION['bill_ip']}) bill_address!!!";
			error_print($data['Error'],$data['Message']);exit;
			//$_SESSION['bill_ip']=$_SERVER['REMOTE_ADDR']; $data['Addr']=$_SERVER['REMOTE_ADDR'];
		}
		*/
		
		//$date_1st=(date('Y-m-d H:i:s',strtotime("-10 seconds"))); $date_2nd=(date('Y-m-d H:i:s'));
		$date_1st=(date('Y-m-d 00:00:00')); $date_2nd=(date('Y-m-d 23:59:59'));
		
		if($data['process_file']=='quay'){
			
		}
		else{
			/*
			$ipCountResult=db_rows("SELECT COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` WHERE ( `bill_ip`='{$_SESSION['bill_ip']}' ) AND ( `tdate` IS NOT NULL ) AND ( `tdate` BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$date_2nd}', '%Y%m%d%H%i%s')) )  ORDER BY id DESC LIMIT 1 ",0);
			//echo "<br/>count00=>".$ipCountResult[0]['count'];
			if((isset($ipCountResult)&&$ipCountResult)&&isset($ipCountResult[0]['count'])&&($ipCountResult[0]['count']>20)){ // 4 || 20
				//echo "<br/>count11=>".$ipCountResult[0]['count'];
				if(isset($_REQUEST['public_key'])){
					$decryptres_api = decryptres($_REQUEST['public_key']);
					$publicKey=explode1('_',$decryptres_api);
					//echo "<hr/>publicKey=".$decryptres_api;exit;
					$_REQUEST['mid']=$publicKey[0];
				}
				$dataDb['db_ip_count']=$ipCountResult[0]['count'];
				$file_create_htaccess=('create_htaccess'.$data['iex']);
				if(file_exists($file_create_htaccess)){		
					include($file_create_htaccess);exit;
				}
			}
			*/
		}
		
	
	##################################################################
	
	if(isset($_REQUEST['encrypted_payload'])&&$_REQUEST['encrypted_payload']){
		$encrypted_payload1=strip_tags($_REQUEST['encrypted_payload']);
		$post['public_key']=substr( $encrypted_payload1, -30 );
		if($data['localhosts']==true){
			//$post['public_key']=substr( $encrypted_payload1, -30 );
		}
		
		//Dev Tech : 23-04-14 decryptres and fetch numeric & underscore if less than 30 character than encryptres
		$decryptres_pub = decryptres($post['public_key']);	//decrypt public_key
		$decryptres_pub=preg_replace(array("/[^0-9_]/"), "", $decryptres_pub);
		$post['public_key'] = encryptres($decryptres_pub);	//encryptres 
		
		
		$encrypted_payload=str_replace($post['public_key'],'',$encrypted_payload1);
		if(isset($_REQUEST['pe']))
		{
			//echo "<br/><br/>1public_key=>".$post['public_key']; echo "<br/><br/>encrypted_payload1=>".$encrypted_payload1;
		}
		
	}
	
	##################################################################
	
	
	//Dev Tech : 23-02-06 modify for @ in starting with user the host url
	//payme---------------------------------------------------------
	//if payme in url then set paylinkurl is payme
	if( ( strpos($data['urlpath'],"/payme")!==false ) || (isset($data['payattherate']) && trim($data['payattherate']) && strpos($data['urlpath'],"/@")!==false) ){
		$data['paylinkurl']='payme';
		//echo "<br/>paylinkurl=>".$data['paylinkurl'].$data['ex'];
		//echo "<br/>process_file=>".$data['process_file'];
		
	}
	
	
	if(isset($post['public_key'])){
		// skip for next condition 
	}
	elseif((strpos($data['urlpath'],"/payment/")!==false)||(strpos($data['urlpath'],"/moto")!==false)||(strpos($data['urlpath'],"/payment?@")!==false)||((isset($data['paylinkurl'])&&strpos($data['urlpath'],$data['paylinkurl'].$data['ex']."/")!==false)&&($data['paylinkurl']))||(strpos($data['urlpath'],"payment.do?@")!==false) || (isset($data['paylinkurl']) && trim($data['paylinkurl']) ) ){
	
		$data['urlpath']=str_replace("/payment/@","/payment/?user=",$data['urlpath']);
		$data['urlpath']=str_replace("/payment?@","/payment/?user=",$data['urlpath']);
		$data['urlpath']=str_replace("/payment.do?@","/payment.do?user=",$data['urlpath']);
		parse_str(parse_url($data['urlpath'], PHP_URL_QUERY), $post);
		
		
		//Dev Tech : 23-02-06 modify for @user pass for payme 
		//@ url for payme : start
		if(isset($data['payattherate']) && trim($data['payattherate']) && strpos($data['urlpath'],"/@")!==false){
			$parsed_url_this =  preg_split("#/#",$data['urlpath']);
			if(isset($parsed_url_this)) {
				//print_r($parsed_url_this);
				if(isset($parsed_url_this[3]) && strpos($parsed_url_this[3],"@")!==false ) {
					$_REQUEST['user']=$post['user']=$parsed_url_this[3];
					
					if(isset($parsed_url_this[4]) && trim($parsed_url_this[4]) ) {
						$post['bill_amt']=$_SESSION['re_post']['bill_amt']=prnsumf(stf($parsed_url_this[4]));
					}
				}elseif(isset($parsed_url_this[4]) && strpos($parsed_url_this[4],"@")!==false ) {
					$_REQUEST['user']=$post['user']=$parsed_url_this[4];
					
					if(isset($parsed_url_this[5]) && trim($parsed_url_this[5]) ) {
						$post['bill_amt']=$_SESSION['re_post']['bill_amt']=prnsumf(stf($parsed_url_this[5]));
					}
				}elseif(isset($parsed_url_this[5]) && strpos($parsed_url_this[5],"@")!==false ) {
					$_REQUEST['user']=$post['user']=$parsed_url_this[5];
					
					if(isset($parsed_url_this[6]) && trim($parsed_url_this[6]) ) {
						$post['bill_amt']=$_SESSION['re_post']['bill_amt']=prnsumf(stf($parsed_url_this[6]));
					}
				}
			}			
		}
		//@ url for payme : end
		
		elseif(strpos($data['urlpath'],$data['paylinkurl'].$data['ex']."/")!==false){
			$sub_qr1=explode1($data['paylinkurl'].$data['ex'].'/',$data['urlpath']);
			$sub_qr2=explode1('/',$sub_qr1[1]);
			
			
			
			if(isset($sub_qr2[0])&&$sub_qr2[0]){
				if(strlen($sub_qr2[0])>80){
					$post['bid']=stf($sub_qr2[0]); // bid
					$post['public_key']=1;
				}elseif(strlen($sub_qr2[0])>22){
					$post['public_key']=stf($sub_qr2[0]); // public_key
				}else{
					$post['user']=stf($sub_qr2[0]); // user
				}
			}
			
			
			
			if(isset($sub_qr2[1])&&$sub_qr2[1]){
				$post['bill_amt']=$_SESSION['re_post']['bill_amt']=prnsumf(stf($sub_qr2[1])); // bill_amt 
			}
			if(isset($sub_qr2[2])&&$sub_qr2[2]){
				$post['bill_email']=stf($sub_qr2[2]); // email
			}
			if(isset($sub_qr2[3])&&$sub_qr2[3]){
				$post['bill_phone']=stf($sub_qr2[3]); // bill_phone
			}
			if(isset($sub_qr2[4])&&$sub_qr2[4]){
				$_REQUEST['fullname']=stf(urldecode($sub_qr2[4])); // fullname
				$post['fullname']=$_REQUEST['fullname'];
			}
			
			
			
			// none clk
			
			if(isset($sub_qr2[5])&&$sub_qr2[5]){
				$post['bill_country']=stf(urldecode($sub_qr2[5])); // bill_country
			}
			if(isset($sub_qr2[6])&&$sub_qr2[6]){
				$post['bill_state']=stf(urldecode($sub_qr2[6])); // bill_state
			}
			if(isset($sub_qr2[7])&&$sub_qr2[7]){
				$post['bill_city']=stf(urldecode($sub_qr2[7])); // bill_city
			}
			if(isset($sub_qr2[8])&&$sub_qr2[8]){
				$post['bill_address']=stf(urldecode($sub_qr2[8])); // bill_address
			}
			if(isset($sub_qr2[9])&&$sub_qr2[9]){
				$post['bill_street_2']=stf(urldecode($sub_qr2[9])); // bill_street_2
			}
			if(isset($sub_qr2[10])&&$sub_qr2[10]){
				$post['bill_zip']=stf($sub_qr2[10]); // bill_zip
			}
			
			//echo strlen($sub_qr2[0]); print_r($sub_qr2); print_r($post); echo "<br/><br/>urlpath=><br/>"; print_r($data['urlpath']);
		}
		
		
		//echo "<br/>bill_amt=>".$post['bill_amt'];
		
		if(isset($_REQUEST['user'])){
			$post['user']=stf($_REQUEST['user']);
			
		}
		
		if(isset($post['user'])&&$post['user']) $post['user']=str_replace('@','',$post['user']);
		
		if(!isset($post['product'])||empty($post['product'])){
			$post['product']='Payment Request';
		}
		
		/*
		if(!isset($post['integration-type'])||empty($post['integration-type'])){
			$post['integration-type']="Encode-Checkout";
		}
		
		*/
		
		//print_r($post);
		
		
		$post['pricManual']="1";
		
		if(isset($_SESSION['re_post'])&&$_SESSION['re_post']){
			$_SESSION['re_post']=array_merge($_SESSION['re_post'],$_GET,$_POST,$post);
		}else{
			$_SESSION['re_post']=array_merge($_GET,$_POST,$post);
		}
		
		
		if(isset($data['payattherate'])&&$data['payattherate']){
			$_SESSION['re_post']['process_file']=$data['paylinkurl'].$data['ex'];
			$_SESSION['re_post']['payattherate']=$data['urlpath'];
		}elseif($data['paylinkurl']){
			$_SESSION['re_post']['process_file']=$data['paylinkurl'].$data['ex'];
			$_SESSION['re_post']['paylinkurl']=$data['paylinkurl'].$data['ex'];
		}elseif($data['process_file']){
			$_SESSION['re_post']['process_file']=$data['process_file'].$data['ex'];
		}
		
		//echo "<br/><br/>re_post=><br/>"; print_r($_SESSION['re_post']);exit;
		
		
		
		
		if(!isset($post['public_key'])){	//if public_key not set or empty the fetch data from clients table
			$post['clientid']	= get_clients_id(stf($post['user']));	//user to clientid id
			
			$_SESSION['clientid'] = $post['clientid'];
			
			
			
			$get_clientid_details 		= select_client_table($post['clientid']);	//fetch clients detail via clientid
			$_SESSION['mem']= $get_clientid_details;	//store clients array into session
			
			//print_r($_SESSION['mem']);
			
			$post['allStore']=select_terminals($_SESSION['clientid'],0,0,1);	//fetch data from products table of a clients
			$post['storeSize']=count($post['allStore']);
			
			if($post['storeSize']<1){		//if rows less them 1, means no record exists and print following error code and messasge
				$data['Error']=95;
				$data['Message']="Not Business URL Available";
				error_print($data['Error'],$data['Message']);	//print error
			}
			elseif($post['storeSize']>1){	//if rows more than one then store total rows in chooseStore
				$post['chooseStore']=$post['storeSize'];
			}elseif($post['storeSize']==1){	//if retrive only one row the store public_key
					$post['public_key']=$_SESSION['re_post']['public_key']=$post['allStore'][0]['public_key'];
					unset($post['storeSize']);
			}
			
			
			//echo "<br/>storeSize=>".$post['storeSize']; echo "<br/>chooseStore=>".$post['chooseStore']; echo "<br/>public_key=>".$post['public_key']; exit;
			
			
		}
		
		
	}
	
	
	
	if(isset($post['bid'])){	//check bid set or not. If bid set then execute following block
		unset($_SESSION['acquirerIDs']);	//unset acquirer from session
		$decryptres = decryptres($post['bid']);	//decrypt bid value
		$requestmoney=explode1(';',$decryptres);	//explode descrpted value via semicolon(;)
		
		
		
		$_POST=array_merge(["bid"=>$post['bid'],"action"=>"requestmoney"],$_POST);	//merge bid and action with $_POST
		
		if(isset($_SESSION['re_post'])){	//if re_post in the session the merge with $_POST
			$_POST=array_merge($_SESSION['re_post'],$_POST);
		}
		
		
		//echo $decryptres;
		if(isset($requestmoney[0])&&$requestmoney[1]=="requestmoney"){	//if requestmoney exists in array then fetch data from requestmoney table
			$remoney=db_rows(
				"SELECT * FROM `{$data['DbPrefix']}request_trans_table`".
				" WHERE `clientid`={$requestmoney[2]}  AND `transactioncode`='{$post['bid']}' LIMIT 1",0
			);
			if($remoney&&$remoney[0]['status']=="Success"){
				echo "<div class='alert' style='font:normal 16px/40px Arial;text-align:center;float:left;width:100%;color:#ff0000;'>Invoice has expired : ".$post['bid']."</div>";
				exit;
			}
			else{
			 if($remoney[0]['amount']==$requestmoney[3]){
					//echo "<hr>db amount=>".$remoney[0]['amount'];
					//echo "<hr>db remail=>".$remoney[0]['remail'];
				
					$post['bid']=$requestmoney[2];
					$post['clients']=$remoney[0]['clientid'];	//clientid id
					$_SESSION['action']='requestmoney';		//requestmoney into session
					$post['action']='requestmoney';			//requestmoney into post
					$post['bill_amt']=$remoney[0]['amount'];	//amount store in $post['bill_amt']
					$_POST['bill_amt']=$remoney[0]['amount'];	//amount store in $_POST['bill_amt']
					$_SESSION['bill_amt']=$remoney[0]['amount'];	//amount store in $_SESSION['bill_amt']
					$post['bill_email']=$remoney[0]['receiver_email'];		//client email id
					$post['fullname']=$requestmoney[4];			// fullname
					$post['integration-type']="Checkout-RequestMoney";				//integration-type method is checkout
					$post['notes']=$remoney[0]['comments'];		//comment store in $post['notes']
					$_SESSION['notes']=$remoney[0]['comments'];		//comment store in $_SESSION['notes']
					$post['product_name']=$remoney[0]['comments'];	//comment store in $post['product_name']
					$post['bussiness_url']="";					//set bussiness_url empty
					$post['reference']=$remoney[0]['id'];		//order id
					$_SESSION['reference']=$remoney[0]['id'];	//order id in session
					
					$post['clientid']=$post['clients'];				//clients id
					
					/*
					print_r($requestmoney);
					echo "<br/><br/><br/>";
					//cmnp
					print_r($post);
					*/
					
					//missing currency from table and assing to bill_currency
					
					//if(isset($requestmoney[7])&&$requestmoney[7]) $post['curr']=$requestmoney[7];
					
					$post['public_key']=$requestmoney[0];
					
					if($remoney[0]['json_value']){	//if json_value is exists then decode and merge with $post array
						$json_value_req=jsondecode($remoney[0]['json_value'],1);
						$post=array_merge($post,$json_value_req);
					}
					
					
				}
			}
			/*
			print_r($requestmoney);
			echo "<hr>action=>".$requestmoney[1];
			echo "<hr>clients=>".$requestmoney[2];
			echo "<hr>bid=>".$requestmoney[2];
			echo "<hr>amount=>".$requestmoney[3];
			echo "<hr>fullname=>".$requestmoney[4];
			echo "<hr>lname=>".$requestmoney[5];
			echo "<hr>remail=>".$requestmoney[6];
			echo "<hr>cdate=>".$requestmoney[7];
			*/
			
			
			
			if($post['public_key'])$_POST['public_key']=$post['public_key'];
		
			
		}
		
		
		
		
		
	}
	
	
	//---------------------------------------------------------
	
	
	//public_key
	if(isset($post['public_key'])){	//check public_key is exists or not
		
		$decryptres_api = decryptres($post['public_key']);	//decrypt public_key
		$publicKey=explode1('_',$decryptres_api);	//explode $decryptres_api values via '_';
		
		//echo "<hr/>action=".$post['action'];"<hr/>public_key=".$post['public_key'];echo "<hr/>decryptres_api=".$decryptres_api;exit;
		
		$post['clients']	=(isset($publicKey[0])&&trim($publicKey[0])?$publicKey[0]:'');	//for clients id
		$post['product']=(isset($publicKey[1])&&trim($publicKey[1])?$publicKey[1]:'');	//for publicKey
		
		
		//echo "<hr>product=>".$post['product'];
		
		//fetch the data from products table
		//$product=select_terminal_details($post['product'],$post['clients'],$post['public_key']);
		$product=select_terminal_details($post['product']);
		//print_r($product);exit;
		//fetch the clients id via username
		$post['clientid']	= get_clients_id($post['clients'],'','',true);
		
		//echo "<hr/>product=";print_r($product); echo "<hr/>product active=>".$product['active'];
		
		
			
		
		if(!isset($product)&&!is_array($product))
		{	//if data in $product not avaible then print following error code and message
	
			//Dev Tech : 23-08-10 Server busy in s2s for 3 times forced redirect 
			
			if(isset($post['integration-type'])&&$post['integration-type']=='s2s')
			{
				
				if(isset($_REQUEST['source_url'])&&trim($_REQUEST['source_url']))
					$source_url_s2s=@$_REQUEST['source_url'];
				elseif(isset($_SERVER['HTTP_REFERER'])&&trim($_SERVER['HTTP_REFERER']))
					$source_url_s2s=@$_SERVER['HTTP_REFERER'];
				else
					$source_url_s2s=@$data['urlpath'];
				
				parse_str(parse_url($source_url_s2s, PHP_URL_QUERY), $sus_query);
				
				//echo "<br/><br/>sus_query=><br/>"; var_dump($sus_query); echo "<br/><br/>_POST=><br/>"; var_dump($_POST);
				
				if(isset($sus_query['re_count'])&&trim($sus_query['re_count']))
					$re_count=(int)$sus_query['re_count']+1;
				else $re_count=1;
				
				$sus_query['re_count']=$re_count;
				$sus_query_str=http_build_query($sus_query);
				$redirecturl_s2s=explode("?",$source_url_s2s)[0]."?".$sus_query_str;
				
				//echo "<br/><br/>2 redirecturl_s2s=>".$redirecturl_s2s ;
				
				$_REQUEST['re_count']=@$re_count;
				
				//echo "<br/>re_count=>".@$re_count; exit;
				
				if(isset($re_count) && $re_count < 4 )
				{
					$dataPost_s2s=json_encode(@$_REQUEST);
					
					echo "
					<script>
						function redirect_payin_post_f(url, data) {
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
						
						var redirecturl_s2s='$redirecturl_s2s';
						var dataPost_s2s=$dataPost_s2s;
						setTimeout(function(){ 
							redirect_payin_post_f(redirecturl_s2s,dataPost_s2s);
						}, 3000);
				
					</script>
					";
				}
				
			}
			
			
			if(isset($re_count) && $re_count < 4 ){
				$data['Error']=1001;
				$data['Message']="An Unspecified Error Returned ".$re_count;
			}
			else {
				$data['Error']=101;
				$data['Message']="Wrong Public Key";
			}
			error_print($data['Error'],$data['Message']);	//print error
			
		}elseif($product['active']==5){	//active is '5' then print following error code and message
			$data['Error']=103;
			$data['Message']="Acquirer missing - terminal not assigned";
			error_print($data['Error'],$data['Message']);	//print error
		}elseif($product['active']!=1){	//active not equal to '1' then print following error code and message
			$data['Error']=102 . $product['active'];
			$data['Message']=$data['store_status'][$product['active']]['title'];//"Inactive Store Id";
			error_print($data['Error'],$data['Message']);	//print error
		}elseif(empty($product['acquirerIDs'])){	//if acquirer is blank or not set then print following error code and message (Acquirer Missing)
			$data['Error']=106;
			$data['Message']="Acquirer Missing";
			error_print($data['Error'],$data['Message']);	//print error
		}elseif((isset($_REQUEST['bill_currency'])&&$_REQUEST['bill_currency']&&isset($data['CURR_SUPPORT']))&&(!in_array(strtoupper($_REQUEST['bill_currency']),$data['CURR_SUPPORT']))){ //check order currency supported or not, if currency not supported then print following error code and message 
			$data['Error']=1051;
			$data['Message']=$_REQUEST['bill_currency']." currency not supported ";
			error_print($data['Error'],$data['Message']);	//print error
		}
		
	}
	
	// if action is not set and bid not set then set product as action default value
	if(!isset($post['action'])&&!isset($post['bid'])){ $post['action']="product"; }
	
	//action
	//if the action value is one of the following then execute following section
	if(isset($post['clientid'])&&$post['clientid']>0){
			
		//echo "<br/>clientid=>".$post['clientid'];
		
			
		$get_clientid_details = select_client_table($post['clientid']);	//fetch the clients details
		$_SESSION['mem']=$get_clientid_details;	//store clients array into session
		
		if($get_clientid_details['active']!=1){	// clients not equal one (no any row return) means merchant not exist and print following error code and message
			$data['Error']=1021;
			$data['Message']="Inactive Merchant!!!";
			error_print($data['Error'],$data['Message']);	//print error
		}
		
		if($get_clientid_details){ // if merchant exists then execute following section
			
			if(isset($_REQUEST['encrypted_payload'])&&$_REQUEST['encrypted_payload']){ //check encrypted_payload set and value exists or not
				
				/*
				$private_key['mid']="{$get_clientid_details['id']}";
				$private_key['username']=$get_clientid_details['username'];
				$private_key = json_encode($private_key);
				$private_key = hash('sha256',$private_key);
				*/
				$private_key = $get_clientid_details['private_key'];	//clients api key
				$_REQUEST['generate_private_key']=$private_key;	//private_key store into session
				//echo "<hr/>private_key=>".$private_key;
				//$encrypted_payload=strip_tags($_REQUEST['encrypted_payload']);
				$decryptf = data_decode_f($encrypted_payload,$private_key,$post['public_key']); //decrypt the code of encrypted_payload and store into decryptf
				parse_str($decryptf,$decrypted);	//convert $decryptf 
				//unset($_REQUEST['encrypted_payload']);
				if($encrypted_payload1){	//check the value in $encrypted_payload1
					$encrypted_payload2=array(); 
					$encrypted_payload2['encrypted_payload']=$encrypted_payload1; //store value in new array encrypted_payload2 (not sure what is use of this array) 
				}
				
				$_POST	=array_merge($_REQUEST,$decrypted);	//merge $_REQUEST and $decrypted array and store into $_POST
				$post	=array_merge($_POST,$post);	//merge $_POST and $post array and store into $post
				
				//check value in bill_ip is exists or not, if yes the store into session
				if(isset($decrypted['bill_ip'])&&$decrypted['bill_ip']) $_SESSION['bill_ip']=$decrypted['bill_ip'];



				
				/*
				if(isset($_REQUEST['pe'])){
					echo "<br/><br/>private_key=>".$private_key;
					echo "<br/><br/>public_key=>".$post['public_key'];
					echo "<br/><br/>post=>";
					//print_r($post);
				}
				*/
			}
			
			
			//check login - if login and action is 'moto_status' then store uid value into pid
			if(isset($_SESSION['login']) && $_SESSION['login'] && $post['action']=='moto_status'){
				//$post['bid']=$get_clientid_details['private_key'];
				$_SESSION['terNO']=$_SESSION['uid'];
			}
			
			

			//if $post['curr'] is empty or not set then set user' default currency to $post['curr']
			if(!isset($post['curr'])||!$post['curr']){$post['curr']=$get_clientid_details['default_currency'];}
			
			
			$_SESSION['clientid']=(isset($post['clientid'])?$post['clientid']:'0');		//set $post['clientid'] value in session if exists
			$_SESSION['clientid2']=(isset($post['clientid2'])?$post['clientid']:'0');	//set $post['clientid'] value in session if exists
			
			$_SESSION['descriptor']=(isset($get_clientid_details['descriptor'])?$get_clientid_details['descriptor']:'');	//set user descriptor value in session if exists
			
			$_SESSION['trans_currency']=(isset($get_clientid_details['default_currency'])?trim($get_clientid_details['default_currency']):'0');	//set clients's default currency into session
			$_SESSION['curr_tr_sys']=get_currency($_SESSION['trans_currency']);	//fetch currnecy symbol into session
			
			if(!isset($get_clientid_details['default_currency'])||!$get_clientid_details['default_currency']){	//if default currnecy in Merchant User Profile (clients table) not exists then print following error code and message
				$data['Error']=105;
				$data['Message']="Account Currency missing under Merchant User Profile";
				error_print($data['Error'],$data['Message']);	//print error
			}
			
			
		
			//if $_GET['bill_amt'] is set then store in $post array
			//if(isset($_GET['bill_amt']))$post['prices']=$_GET['bill_amt'];
			
			if(isset($_GET)){
				$get_en=replacepost(prntext(json_encode($_GET)));
				if($get_en){
					$getDec=json_decode($get_en,1);
					if($get_en){$post=array_merge($post,$getDec);}
				}
			}
			
			
			//if merchant order id set must be unique, then check in transactions table merchant order number exist or not, if already exists the print / show following error code and messsage
			if((isset($data['reference_unique'])||(isset($post['unique_reference'])&&$post['unique_reference']=='Y'))&&isset($post['reference'])){
				
				$reference_unique=db_rows("SELECT COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` WHERE ( `merID`={$_SESSION['clientid']} ) AND ( `reference`='{$post['reference']}' ) ORDER BY id DESC LIMIT 1 ",0);
				
				$reference_unique_count=(isset($reference_unique[0]['count'])?$reference_unique[0]['count']:0);
				if($reference_unique_count>0){
					$data['Error']=666;
					$data['Message']="Reference is Id Order should be unique.";
					error_print($data['Error'],$data['Message']);	//print error
				}
				
			}
			
		
			if(isset($post['bill_address'])&&isset($post['bill_street_2']))	//check if value exists in both bill_address and bill_street_2 then merge and store into bill_address field
			$post['bill_address']=$post['bill_address'].",".$post['bill_street_2'];
			elseif(isset($post['bill_address']))	//check if value exists in bill_address then store into bill_address field
				$post['bill_address']=$post['bill_address'];
			elseif(isset($post['bill_street_2']))	//check if value exists in bill_street_2 then store into bill_address field
				$post['bill_address']=$post['bill_street_2'];
			else	//otherwise set emtpy in bill_address field
				$post['bill_address']='';
			//if currency receive into $_REQUEST then store into $post array
			if(isset($_REQUEST['bill_currency'])&&$_REQUEST['bill_currency']){ $post['curr']=$_REQUEST['bill_currency'];}
			$_SESSION['curr']=$post['curr'];	//store currency into session

			// if $_SESSION['curr'] is empty then store transaction amount into $_SESSION['curr']
			if((!isset($_SESSION['curr']))||(empty($_SESSION['curr']))){
				$_SESSION['curr']=$_SESSION['trans_currency'];
			}
			
			if(isset($_SESSION['curr'])){
				$currency_smbl=get_currency($_SESSION['curr']);	//fetch currency symbol
				$_SESSION['bill_currency']=$_SESSION['curr']; 	//store session curr into session['bill_currency']
				$_SESSION['curr_smbl']=$currency_smbl;		//store currnecy symbol into session
			}
			
			
			//set return_url into session if receive in request
			if(isset($post['return_url'])&&$post['return_url']){$_SESSION['return_url_get']=$post['return_url'];}
			

			//set webhook_url into session if receive in request
			if(isset($post['webhook_url'])&&$post['webhook_url']){$_SESSION['webhook_url_get']=$post['webhook_url'];}
			
		
			
			//check gateway no, if exists then store into sesssion else unset $_SESSION['gateway_no']
			if((isset($post['gateway_no']))&&(!empty($post['gateway_no']))){
				$_SESSION['gateway_no']=$post['gateway_no'];
			}else{
				$_SESSION['gateway_no']="";
				unset($_SESSION['gateway_no']);
			}
			
			
			//check source, if exists then store into sesssion else set empty $_SESSION['source']
			if((isset($post['source']))&&(!empty($post['source']))){
				$_SESSION['source']=$post['source'];
			}else{
				$_SESSION['source']="";
			}
			
			//check reference (merchant order number), if exists then store into sesssion else set empty $_SESSION['reference']
			if((isset($post['reference']))&&(!empty($post['reference']))){
				$_SESSION['reference']=$post['reference'];
			}else{
				$_SESSION['reference']="";
			}
			
			
			$json_value=array();
			//$json_value['post']=array();$json_value['get']=array();
			if(isset($_POST)){	//store $_POST values in json and unset all card detail 
				$json_value['post']=get_post1($_POST);
				unset($json_value['post']['ccno']);
				unset($json_value['post']['ccvv']);
				unset($json_value['post']['month']);
				unset($json_value['post']['year']);
				
			}
			if(isset($_GET)){	//store $_GET values in json and unset all card detail 
				$json_value['get']=get_post1($_GET);
				unset($json_value['get']['ccno']);
				unset($json_value['get']['ccvv']);
				unset($json_value['get']['month']);
				unset($json_value['get']['year']);
			}
			
			//$_SESSION['json_value']=json_encode($json_value);
			$_SESSION['json_value']=$json_value;	//store json values in _SESSION
			
			//$_SESSION['post']=$post;
			
			//print_r($_SESSION['json_value']);exit;
			
			//------------------------------------
			$_SESSION['json_value']['hostUrl']=$data['Host'];	//store host url into _SESSION which defined in config_db.do 
			if(isset($data['process_file'])&&$data['process_file']){	//check process_file path if exist then store into _SESSION
				$_SESSION['json_value']['process_file']=$data['process_file'];
			}
			
			
			//check $_SESSION['re_post'] values if set and exist then merge all three array ($_SESSION['re_post'] ,$_GET, $_POST) and store into $_SESSION['re_post']
			if(isset($_SESSION['re_post']) && $_SESSION['re_post']){
				$_SESSION['re_post']=array_merge($_SESSION['re_post'],$_GET,$_POST);
			}else{
				$_SESSION['re_post']=array_merge($_GET,$_POST);	//merge $_GET and $_POST array and store into $_SESSION['re_post']
			}
			
			//check values in $data['re_post'] set or not
			if(isset($data['re_post'])){
				if(isset($_SESSION['re_post']['http_referer'])){
					$_SERVER['HTTP_REFERER']=$_SESSION['re_post']['http_referer'];	//store referer from _SESSION to _SERVER
				}else{
					if(isset($_SERVER['HTTP_REFERER']))
					$_SESSION['re_post']['http_referer']=$_SERVER['HTTP_REFERER'];	//save referer from _SERVER to _SESSION
				}
			}
			
			
		//CHECK ? EXISTS in HTTP_REFERER or not, if '?' exists then make query string with & else with '?'
			
			
			if(isset($_SERVER['HTTP_REFERER'])&&strpos($_SERVER['HTTP_REFERER'],'?') !== false) {
				$_SESSION['http_referer']=$_SERVER['HTTP_REFERER']."&reference=".(isset($post['reference'])?$post['reference']:'');
			}else{
				$_SESSION['http_referer']=((isset($_SERVER['HTTP_REFERER']))?$_SERVER['HTTP_REFERER']:'')."?reference=".(isset($post['reference'])?$post['reference']:'');
			}

			


		
		}
		
		//check product is set and values exists then store all values of ($post['product'] into _SESSION
		if(isset($post['product'])&&isset($product)&&$post['product']&&$product){
			//$_SESSION['terminal_id']=$product['id'];
			foreach($product as $key=>$value){
				$_SESSION[$key]=$value;
			}
			$_SESSION['terNO']=$product['id'];
			$_SESSION['product']=$product['ter_name'];
			$_SESSION['ter_acquirerIDs_s2s']=$product['acquirerIDs'];
			$_SESSION['product_active']=$product['active'];
			$_SESSION['store_midcard']=explode1(',',$product['acquirerIDs']);
			if(isset($product['select_mcc'])&&$product['select_mcc']){
				$_SESSION['select_mcc_list']=explode1(',',$product['select_mcc']);
			}
		}
		$_SESSION['action']=$post['action'];
		
		
		//if process_file payme and store acquirer is 602 (paytm) then call following section and set frontUiName = ruby_paytm (theme only for paytm)
		//ruby_paytm
		if( (isset($data['process_file'])&&$data['process_file']=='payme') && isset($_SESSION['store_midcard']) && (in_array(602,$_SESSION['store_midcard'])) && !empty($_SESSION['store_midcard'])  ){
			$checkout_theme=$_SESSION['checkout_theme']=$data['frontUiName']='ruby_paytm';
			//print_r($_REQUEST); print_r($post); exit;
			if($post['integration-type']!='s2s')
			{
				$rePost_url=$data['Host']."/checkout".$data['ex'];
				post_redirect($rePost_url, array_merge(($post),($_REQUEST)));
			}
		}
		$_SESSION['inactive_acquirer_arr']=array();
		$inactive_acquirer=db_rows(
			"SELECT ".group_concat_return('`acquirer_id`',1)." AS `acquirer_id`   FROM `{$data['DbPrefix']}mer_setting`".
			" WHERE `merID`='{$_SESSION['clientid']}' AND `acquirer_processing_mode` IN ('3') LIMIT 1",0);
		if(isset($inactive_acquirer[0])&&trim((string)$inactive_acquirer[0]['acquirer_id'])){
			$_SESSION['inactive_acquirer_arr']=explodef(@$inactive_acquirer[0]['acquirer_id'],',');
			$_SESSION['inactive_acquirer_arr']=explode(',',@$inactive_acquirer[0]['acquirer_id']);
			if(isset($_REQUEST['m1']))
			{
				echo "<br/>inactive_acquirer=>";
				print_r($_SESSION['inactive_acquirer_arr']);
			}
		}
		
	
		$_SESSION['common_midcard']=array();
		
		//fetch data' from acquirer_table TABLE
		$bank_getway=db_rows(
			"SELECT * FROM {$data['DbPrefix']}acquirer_table".
			" ",0
		);
		$_SESSION['bank_mcc_code']=[];			//define array in _SESSION (bank_mcc_code)
		$_SESSION['bank_mcc_code_global']=[];	//define array in _SESSION (bank_mcc_code_global)

		//declared array
		$aj1=[];
		$inactive_bank_ac_list = array();
		$all_bank_ac_list = array();
		$inactive_fail_bank_list = array();
		foreach($bank_getway as $key=>$value){	//loop for fetch row by data from $bank_getway
		
			$all_bank_ac_list[]=$value['acquirer_id'];	// add account number in back account list array

			//if acquirer_status is greater than 0 (means only active and common list) then execute following section
			if($value['acquirer_status']>0)
			{
				//check inactive_failed_count ACTIVATED and email id store in notification_email field then set store notification_email and counter into inactive_fail_bank_list
				if(isset($value['notification_email'])&&$value['notification_email']&&isset($value['inactive_failed_count'])&&$value['inactive_failed_count']){
					$inactive_fail_bank_list[$value['acquirer_id']]=array("notification_email"=>$value['notification_email'], "inactive_failed_count"=>$value['inactive_failed_count']);
				}
				//check if any inactive period set for this account, if yes then further check inactive period with current time, if condition true then temporary inactive
				if(isset($value['inactive_start_time'])&&isset($value['inactive_end_time']))
				{
					$inactive_start_time= $value['inactive_start_time'];
					$inactive_end_time	= $value['inactive_end_time'];

					if(CURRENT_TIME>=$inactive_start_time&&CURRENT_TIME<=$inactive_end_time){
						//temp inactive bank accounts for a time period
						$inactive_bank_ac_list[]=$value['acquirer_id'];
					}
				}
				// if merchant id is 11284 OR 11228 OR 11262 then don't execute following section
				if($_SESSION['clientid']!=11284&&$_SESSION['clientid']!=11228&&$_SESSION['clientid']!=11262){
				
					if($value['acquirer_status']==2){	// check acquirer_status value if it is 2 the executue 
						$aj=[];
						$aj['id']=$value['id'];		//tid
						$aj['sponsor']=$_SESSION['mem']['sponsor'];	//sponsor id
						$aj['clientid']=$_SESSION['mem']['id'];		//clients id store inot onwer
						$aj['acquirer_name']=$value['acquirer_name'];	
						$aj['acquirer_id']=$value['acquirer_id'];	//use account number as a nick name
						//$aj1[]=array_merge($aj,jsondecode($value['mer_setting_json'],true));
						
						//check data exists in bank mer_setting_json field
						if((isset($value['mer_setting_json']))&&($value['mer_setting_json'])){
							$b_mer_setting_json_common=jsondecode($value['mer_setting_json'],true); // convert mer_setting_json into array
							
							//print_r($b_mer_setting_json_common);
							if(!isset($_SESSION['select_mcc']))	//if select_mcc not set then merge $aj array with b_mer_setting_json_common array
							{
								$aj1[]=array_merge($aj,$b_mer_setting_json_common);	//merge array
							}
							
							
							//if select_mcc_list is set then merge $aj array with b_mer_setting_json_common array and mcc code is 1111 then execute following section
						
							if((isset($_SESSION['select_mcc_list'])&&isset($value['select_mcc'])&&($value['select_mcc'])&&(strpos($value['select_mcc'],'1111')!==false)&&(isset($_SESSION['inactive_acquirer_arr'])&&!in_array($value['acquirer_id'],$_SESSION['inactive_acquirer_arr'])))||(!isset($_SESSION['select_mcc']))){
									
								$aj1[]=array_merge($aj,$b_mer_setting_json_common);
								
								$_SESSION['bank_mcc_code_global'][$value['acquirer_id']]=explode(',',$value['select_mcc']);	//store mcc code into _SESSION
							}
							
							
						}
						


						//store acquirer with account number into session
						@$_SESSION['acquirerIDs']=$_SESSION['acquirerIDs'].','.$value['acquirer_id'];
						$value['acquirer_status']=1;	//acquirer_status set 1
						$_SESSION['common_midcard'][]=$value['acquirer_id'];
					}
				}
				
				if($value['acquirer_status']==2){	//acquirer_status value is 2 then reset to 1
					$value['acquirer_status']=1;
				}
				
				$_SESSION["b_".$value['acquirer_id']]=$value; 	//store all values in array
				
				
				//check data in acquirer_processing_creds exists or not 
				if($value['acquirer_processing_creds']){
					$bj=jsondecode($value['acquirer_processing_creds'],true);	//convert acquirer_processing_creds into array
					if(isset($bj['countries'])){
						$_SESSION["b_".$value['acquirer_id']]['countries']=jsonencode($bj['countries']);	//country name store into _SESSION if exists
						$_SESSION["b_".$value['acquirer_id']]['deCon']=jsonencode($bj['countries']);	//deCon country name store into _SESSION if exists
					}
					
					
					//check mISO2 is set and acquirer_status greator than ZERO and store into _SESSION
					if(isset($bj['mISO2'])&&$value['acquirer_status']>0){
						$_SESSION['mISO2']=1;
						$_SESSION["b_".$value['acquirer_id']]['mISO2']=jsonencode($bj['mISO2']);
					}
				} 
				
				
				//check data in acquirer_processing_creds exists or not 
				if($value['acquirer_label_json']){
					$aLj=jsondecode($value['acquirer_label_json'],true);	//convert acquirer_label_json into array
					if(isset($aLj)){
						$_SESSION["b_".$value['acquirer_id']]['aLj']=($aLj);	
					}
				} 
				
				
				
				//Allow countries and not allow 
				
				if(isset($value['processing_countries'])&&trim($value['processing_countries'])){
					$_SESSION["b_".$value['acquirer_id']]['processing_countries']=($value['processing_countries']);	//allow country code store into _SESSION if exists
					//$_SESSION["b_".$value['acquirer_id']]['deCon']=jsonencode($bj['processing_countries']);	//deCon country code store into _SESSION if exists
				}
				if(isset($value['block_countries'])&&trim($value['block_countries'])){
					$_SESSION["b_".$value['acquirer_id']]['block_countries']=($value['block_countries']);	//store country list which not allow transactions
				}
				
				
				
				
				if((isset($value['mer_setting_json']))&&($value['mer_setting_json'])&&(isset($_SESSION['inactive_acquirer_arr'])&&!in_array($value['acquirer_id'],$_SESSION['inactive_acquirer_arr']))){
					$b_mer_setting_json=json_decode($value['mer_setting_json'],true); 
					$_SESSION["b_".$value['acquirer_id']]['ajs']=$b_mer_setting_json;
					
					if(isset($b_mer_setting_json['mcc_code'])&&$b_mer_setting_json['mcc_code']){
						$_SESSION['bank_mcc_code'][$value['acquirer_id']]=($b_mer_setting_json['mcc_code']);
					}
					
				} 
			}
			else
			{
				$inactive_bank_ac_list[]=$value['acquirer_id'];	//store inactive bank accounts
			}
		}
	}
	
	
	
	//echo "<br/>bank_mcc_code_global=>";print_r($_SESSION['bank_mcc_code_global']);
	//exit;
	$_SESSION['all_bank_ac_list']=$all_bank_ac_list;				//store all bank list in array
	$_SESSION['inactive_bank_ac_list']=$inactive_bank_ac_list;		//store inactive bank list in array
	$_SESSION['inactive_fail_bank_list']=$inactive_fail_bank_list;	//store fail bank list in array

	if($data['pq'])
	{
		echo 'inactive_fail_bank_list-11';
		print_r($_SESSION['inactive_fail_bank_list']);
	}
	##################
	
	if($data['UseTuringNumber'])$_SESSION['turing']=gencode();
	if(!isset($_SESSION['quantity']))$_SESSION['quantity']=1;	//set quantity is 1 if not set
	//unset($_SESSION['login']);
	
	
	
	if(isset($post['bill_country'])&&$post['bill_country']){
		$post['country_three']=get_country_code($post['bill_country'],3);	//country code in three char
	}
	if(isset($post['bill_state'])&&$post['bill_state']){
		$post['state_two']=get_state_code($post['bill_state']);		//bill_state code in 2 chars
	}
	
	$request_uri=$_SERVER['REQUEST_URI'];
	if(strpos($request_uri,'?')!==false){	//check query string in url, if yes then split url and string
		$_SESSION['request_uri']=explode1('?',$request_uri)[0];
	}else{
		$_SESSION['request_uri']=$request_uri;
	}
	
	
	
		
	
	########################################
	$post['status_mem']=get_clients_status_ex($_SESSION['clientid']); 	//fetch clients/user status
	$post['status_mem']=(int)$post['status_mem'];	//convert status in integer

	if((!isset($_SESSION['clientid']))&&(empty($_SESSION['clientid']))){	//if clientid id missing then print following error code and message;
		$data['Error']=1040;
		$data['Message']="Required parameters are missing";
		error_print($data['Error'],$data['Message']);	//print error
	}elseif(($post['status_mem']==0 || $post['status_mem']==1)&&($_SESSION['re_post']['terminal_id']!='1120')){	//if clients status is 0 OR 1 and store id not equal 1120, then print following error code and message
		$data['Error']=104;
		$data['Message']="Your account have not been approved yet";
		error_print($data['Error'],$data['Message']);	//print error
	}
	


	
	########################################
		
	$result11 =  select_client_table($_SESSION['clientid']);	//fetch the clients full data
	if(isset($result11['json_setting'])&&$result11['json_setting']){	// if the data available in json_setting field the convert into array
		$json_setting=jsondecode($result11['json_setting'],true);	//json to array
		$merchant_pays_fee=(double)$json_setting['merchant_pays_fee'];	//fetch merchant_pays_fee' numeric value from json_setting
		
		if($merchant_pays_fee){	//if value exists in merchant_pays_fee then store into _SESSION
			$_SESSION['merchant_pays_fee']=$merchant_pays_fee;
		}
	}
	
	#####	Dev Tech : 23-04-08 start - dba	#########################
	
	//dba if dba_brand_name not empty then store as company_name info data
	if(!empty($_SESSION['dba_brand_name'])){$_SESSION['info_data']['company_name']=$_SESSION['dba_brand_name'];} 
	// if dba_brand_name is empty then check ter_name if exist then store as company_name info data
	elseif(!empty($_SESSION['ter_name'])){$_SESSION['info_data']['company_name']=$_SESSION['ter_name'];}
	// if ter_name is empty then check bussiness_url if exist then store as company_name info data
	elseif(!empty($_SESSION['bussiness_url'])){$_SESSION['info_data']['company_name']=$_SESSION['bussiness_url'];}
	// if bussiness_url is empty then check business_nature if exist then store as company_name info data
	elseif(!empty($_SESSION['business_nature'])){$_SESSION['info_data']['company_name']=$_SESSION['business_nature'];}
	// if business_nature is empty then check company_name if not exist then store as profile company_name info data
	elseif(!empty($result11['company_name'])){$_SESSION['info_data']['company_name']=$result11['company_name'];}
	// if profile company_name is empty then check company_name if not exist then store as profile fullname info data
	elseif(!empty($result11['fullname'])){$_SESSION['info_data']['company_name']=$result11['fullname'];}
	// if profile fullname is empty then check company_name if not exist then store as dmn info data
	elseif(!empty($result11['dmn'])){$_SESSION['info_data']['company_name']=$result11['company_name'];}
	
	
	$_SESSION['dba']=$_SESSION['info_data']['company_name'];
	
	#####	Dev Tech : 23-04-08 end - dba	#########################
	
	
	
	$_SESSION['info_data']['memail']=$result11['registered_email'];	//clients registered_email id


	//$_SESSION['AccountInfo']=mer_settings($_SESSION['clientid']);
	
	//cmn
	//$_REQUEST['m1']=1;
	
	if(isset($_REQUEST['m1']))
	{
		echo "<br/>select_mcc=>"; print_r($_SESSION['select_mcc']);
		echo "<br/>bank_mcc_code=>"; print_r($_SESSION['bank_mcc_code']);
		echo "<br/>bank_mcc_code_global=>"; print_r($_SESSION['bank_mcc_code_global']);
	}
	
	$account_type_arr=[];
	if(isset($_SESSION['select_mcc'])&&$_SESSION['select_mcc']&&isset($_SESSION['bank_mcc_code'])&&$_SESSION['bank_mcc_code']){
		
		$select_mcc_g=$_SESSION['select_mcc'].',1111';
		//$select_mcc_g=$_SESSION['select_mcc'].",";
		$web_mc=explodef($select_mcc_g,',');
		
		if(isset($_REQUEST['m1'])){
			echo "<br/>web_mc=>";print_r($web_mc);
		}
		
		foreach($_SESSION['bank_mcc_code'] as $k4=>$v4){
			//echo "<br/><br/>k4=>".$k4; echo "<br/>v4=>";print_r($v4);
			foreach($v4 as $v41){
				if($v41&&(in_array($v41,$web_mc)))
				{
					$account_type_arr[]=$k4;
					if(isset($_REQUEST['m1']))echo "<br/><br/>v41=>".$v41;
				}
			}
			
		}
	}
	
	//if data exist in $account_type_arr, then make string with comma (,)
	if(isset($account_type_arr)&&$account_type_arr){
		//array_unique($account_type);
		$account_type1=implodef($account_type_arr);
		$account_type=implode(',', array_unique(explode(',', $account_type1)));
	}else{
		$account_type='';
	}
	if(isset($_REQUEST['m1'])){
		echo "<br/><br/>account_type=>".$account_type;
	}
	
	
	
	//fetch all acquirers of a clients
	$_SESSION['AccountInfo']=mer_settings($_SESSION['clientid'],0,0, $account_type);
	
	
	//merge $aj1 array exists then merge with $_SESSION['AccountInfo']
	if($aj1){$_SESSION['AccountInfo']=array_merge($aj1,$_SESSION['AccountInfo']);} 
	
	//print_r($_SESSION['AccountInfo']);
	

	//following variables initilized with null value
	//$post['acquirer_id']="";	//set acquirer_id is empty
	$moto_vt=false;
	$curl_action=false;
	$post['ewallets_test_card']=false;
	$login_required=false;
	$_SESSION['settelement_delay']="";
	$_SESSION['rolling_delay']="";
	$_SESSION['store_midcard_test_mode']=0;

	
	
	//fetch row by row from $_SESSION['AccountInfo']
	foreach($_SESSION['AccountInfo'] as $key=>$value){
		$_SESSION['a'][$value['acquirer_id']]=$value; //set vlues in $_SESSION
		
		//Dev Tech : 23-02-07 not required 
		/*
		if(isset($merchant_pays_fee)&&$merchant_pays_fee){	//check value in $merchant_pays_fee exists or not, if yes then calculate mdr_rate, convenience_rate and convenience_fee_cal; and store into sessioin
			
			//if(!isset($post['bill_amt'])) $post['bill_amt'] =0.00;
			$_SESSION['af'][$value['acquirer_id']]['percentage_of_customer_pays_fee']=$merchant_pays_fee;
			$mdr_rate=(double)$value['mdr_rate'];
			$convenience_rate=(($mdr_rate*$merchant_pays_fee)/100);	// calculate convenience_rate
			$_SESSION['af'][$value['acquirer_id']]['mdr_rate']=$mdr_rate;
			$_SESSION['af'][$value['acquirer_id']]['convenience_rate']=$convenience_rate;
			$_SESSION['af'][$value['acquirer_id']]['order_amount']=(double)$post['bill_amt'];
			$convenience_fee_cal=(double)((double)$post['bill_amt']*$convenience_rate/100);	// calculate convenience_fee_cal
			$_SESSION['af'][$value['acquirer_id']]['convenience_fee']=$convenience_fee_cal;
			$_SESSION['af'][$value['acquirer_id']]['total_amount']=(double)((double)$post['bill_amt']+(double)$convenience_fee_cal);
		}
		*/
		
		//if account test mode in store acquirer
		if( isset(($_SESSION['store_midcard'])) && (in_array($value['acquirer_id'],$_SESSION['store_midcard'])) && ( $value['acquirer_processing_mode']==2 ) && ($_SESSION['store_midcard'])  ){
			$_SESSION['store_midcard_test_mode']=1;	//set store acquirer test mode is true
			//$settlementVali=false;
		}
		
		//acquirer_id (acquirer) not empty then save acquirer processing mode _SESSION 
		if($value['acquirer_id']){
		  $_SESSION['mode'.$value['acquirer_id']]=$value['acquirer_processing_mode'];
		  if(isset($value['settelement_delay'])&&$value['settelement_delay']){
				$_SESSION['sp'.$value['acquirer_id']]=$value['settelement_delay'];	//settelement period
		  }
		  if(isset($value['reserve_delay'])&&$value['reserve_delay']){
				$_SESSION['rp'.$value['acquirer_id']]=$value['reserve_delay'];	//rolling period
		  }
		}
		if(isset($value['login_required']) && $value['login_required']&&$value['login_required']=="1"){
			$login_required=true;	//must be login
		}
		
		// if acquirer_processing_mode == 2, then execute following section
		if(isset($value['acquirer_processing_mode'])&&$value['acquirer_processing_mode']&&$value['acquirer_processing_mode']==2){
			$_SESSION['b_'.$value['acquirer_id']]['mop']=$_SESSION['b_'.$value['acquirer_id']]['mop'].",visa";
		}
		//to check acquirer_processing_currency is exist or not, then store acquirer_processing_currency into $_SESSION
		if(isset($value['acquirer_processing_currency'])&&$value['acquirer_processing_currency']){
		  $_SESSION['fullcurrname'.$value['acquirer_id']]=$value['acquirer_processing_currency'];
		  $curr_ex=explode1(' ',$value['acquirer_processing_currency']);
		  if(isset($curr_ex[1])&&trim($curr_ex[1])) $_SESSION['currency'.$value['acquirer_id']]=$curr_ex[1];
		  if(isset($curr_ex[0])&&trim($curr_ex[0])) $_SESSION['cursymbols'.$value['acquirer_id']]=$curr_ex[0];
		}
		//to check salt_id is exist or not, then store salt_id into $_SESSION
		if(isset($value['salt_id']) && $value['salt_id']){
			//$st_query=" `id`={$value['salt_id']} AND `salt_status`=1 ";
			//$sm=select_tablef($st_query,'salt_management',0);
			$sm=@$data['smDb'][$value['salt_id']];
			if(isset($sm['acquirer_processing_creds'])&&$sm['acquirer_processing_creds']){	//to check value in acquirer_processing_creds exist or not, if yes store in _SESSION
				$_SESSION['salt_id_'.$value['acquirer_id']]=$value['salt_id'];
				$_SESSION['salt_value_'.$value['acquirer_id']]=$sm['acquirer_processing_creds'];
				$_SESSION['salt_decode_'.$value['acquirer_id']]=jsondecode($sm['acquirer_processing_creds']);
				$_SESSION['apJson'.$value['acquirer_id']]=$sm['acquirer_processing_creds'];
			}
		}else{
			$sm['acquirer_processing_creds']=''; //unset($sm['acquirer_processing_creds']);
		}
		
		if(isset($sm['acquirer_processing_creds'])&&$sm['acquirer_processing_creds']){
			
		}elseif(isset($value['acquirer_processing_json']) && $value['acquirer_processing_json']){	//if acquirer_processing_json exist then store into $_SESSION
			$_SESSION['apJson'.$value['acquirer_id']]=$value['acquirer_processing_json'];
		}
		
		if(isset($value['encrypt_email']) && $value['encrypt_email']){	//if encrypt_email exist then store into $_SESSION
		  $_SESSION['notification'.$value['acquirer_id']]=$value['encrypt_email'];
		}
		
		//if 003 value exist in encrypt_email then add nick-name in $_SESSION['acquirerIDs']
		if(isset($value['encrypt_email']) && (strpos($value['encrypt_email'],'003') !== false) && ($_SESSION['action']=='requestmoney') ){
			$_SESSION['acquirerIDs'].=$value['acquirer_id'].",";
		}
		
		//if Wallets assign via acquirer_id and acquirer_processing_mode is two(2) then ewallets_test_card is true
		if((isset($value['acquirer_id'])) && (isset($_SESSION['b_'.$value['acquirer_id']]['channel_type']) && (!in_array($_SESSION['b_'.$value['acquirer_id']]['channel_type'],[1,2,3]))) )
		{
			if($value['acquirer_processing_mode']=="2"){
				$post['ewallets_test_card']=true;
			}
		}
		
		// moto_status is 1 then login required for access following section
		if((isset($value['moto_status']) && $value['moto_status']=="1") && (isset($_SESSION['action']) && $_SESSION['action']=='moto_status') ){
			if(empty($_SESSION['login'])){
				header("location:{$data['Host']}/index".$data['ex']);
				echo('ACCESS DENIED.');
				exit;
			}
			$moto_vt=true;$post['bussiness_url']="checkout".$data['ex'];$post['source']="MOTO ";
			
			$post['acquirer'].=$value['acquirer_id'].",";
			$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
			$_SESSION['http_referer']=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
			//$data['HideMenu']=false;
			echo"
			<style>
			.header_section, #header, .header, #container-footer, .caption {display:block !important;}
			.htmlpopup .header_section, .htmlpopup #header,  .htmlpopup .header, .htmlpopup #container-footer {display:block !important;}
			</style>
			";
		}
	}


					
	//if $_SESSION['af'] not empty then convert into json and store again in $_SESSION['afj']			
	if(isset($_SESSION['af'])&&$_SESSION['af']){
		$_SESSION['afj']=jsonencode($_SESSION['af']);
		//echo "af=>";print_r($_SESSION['afj']);
	}

	//$moto_vt is false then unset login from $_SESSION, otherwise store acquirer_id in acquirer ($_SESSION)
	if($moto_vt==false){
		unset($_SESSION['login']);
	}else{
		if(isset($post['acquirer_id'])&&trim($post['acquirer_id']))
		$_SESSION['acquirerIDs']=$post['acquirer_id'];	
	}

	
	#######################################
	
	
	$_SESSION['post']=$post;	//store $post array into $_SESSION

	if(isset($_SESSION['http_referer'])&&strpos($_SESSION['http_referer'],'http') !== false) {
		
	}else{
		if(isset($post['source_url'])&&strpos($post['source_url'],'?') !== false) {
			$_SESSION['http_referer']=$post['source_url']."&reference=".$post['reference'];
		}else{
			$_SESSION['http_referer']=(isset($post['source_url'])&&trim($post['source_url'])?$post['source_url']:'').(isset($post['reference'])&&trim($post['reference'])?'?reference='.$post['reference']:'');
		}
	}
	
	
	if(isset($_POST['bill_amt'])&&$_POST['bill_amt']>0){
		$post['bill_amt']=$_POST['bill_amt'];	//order amount (bill_amt) into $post
	}
	if(isset($post['bill_amt'])&&$post['bill_amt']>0){
		$_SESSION['bill_amt']=$post['bill_amt'];	//order amount (bill_amt) into $_SESSION
	}
	
	//Dev Tech : 23-07-08 retrycount via merchant api otherwise default is 3 into $_SESSION for retrycount is 0 check from failed than skip checkout page as well as redirect on retun url in fail condition only   
	if(!isset($_SESSION['SA']['retrycount'])&&isset($post['retrycount'])&&$post['retrycount']>0)
		$_SESSION['SA']['retrycount']=(int)$post['retrycount'];	
	elseif(!isset($_SESSION['SA']['retrycount']))
		$_SESSION['SA']['retrycount']=3;	
	 
	
	$post['step']=1;
} //end 0 step





//echo "<hr/>step3=>".$post['step'];
if(isset($_SESSION['AccountInfo'])&&$_SESSION['AccountInfo']){	// if AccountInfo in $_SESSION the sort via acquirer_display_order field
	array_multisort(array_column($_SESSION['AccountInfo'], 'acquirer_display_order'), SORT_ASC, $_SESSION['AccountInfo']);
}

###############################################################################

$unique_reference=1;

if(isset($post['unique_reference'])&&$post['unique_reference']=='Y'){
		$unique_reference=0;
}

//to check api_totke, email and bill_amt are exists or not
if(isset($_SESSION['public_key'])&&$_SESSION['public_key']&&isset($_SESSION['post']['bill_email'])&&$_SESSION['post']['bill_email']&&isset($_SESSION['post']['bill_amt'])&&$_SESSION['post']['bill_amt']&&$unique_reference==1){
	$decryptresApi = decryptres($_SESSION['public_key']);	//decrypt api_toke
	$public_key=explode1('_',$decryptresApi);	//explode descrypted token with "_"
	$clients_uid=(int)$public_key[0];				//set first value as a clients uid (userid)
	$product_id=(int)$public_key[1];				//set second value as a product id

	//if product_id greator than ZERO (0) and uid (3342 OR 3333), then set first date seven day before and second date end of today
	if(($clients_uid>0&&$product_id>0)&&($clients_uid==3342||$clients_uid==3333)){
		$date_s_1st=(date('Y-m-d 00:00:00',strtotime('-7 days'))); $date_s_2nd=(date('Y-m-d 23:59:59'));
	}else{	//above condition false, then set first date five minutes before and second date current time
		$date_s_1st=(date('Y-m-d H:i:s',strtotime('-5 minutes'))); $date_s_2nd=(date('Y-m-d H:i:s'));
	}
		
		
	//fetch the reference, transID from trans between above define date_s_1st and date_s_2nd with following conditions
		$mrid_get=db_rows("SELECT `reference`,`transID` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` WHERE ( `trans_status` IN (1) ) AND ( `bill_amt` IN ({$_SESSION['post']['bill_amt']}) ) AND ( `bill_email` IN ('{$_SESSION['post']['bill_email']}') ) AND ( `merID` IN ({$clients_uid})) AND (`terNO` IN ({$product_id})) AND ( `tdate` BETWEEN (DATE_FORMAT('{$date_s_1st}', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$date_s_2nd}', '%Y%m%d%H%i%s')) )   ORDER BY id DESC LIMIT 1 ",0);
		
	//if data recevied via above query then fetch_trnsStatus with following url
		if($mrid_get){
			$validate_url=$data['Host']."/fetch_trnsStatus".$data['ex'];
			$valid_data=array();
		$valid_data['transID']=$mrid_get[0]['transID'];	//transID
		$valid_data['public_key']=$_SESSION['public_key'];		//public_key
		$valid_data['reference']=$mrid_get[0]['reference'];			//merchant order id
		$valid_data['actionurl']='validate';					//action url is validate

		if($post['integration-type']=='s2s'){			//if integration-type is s2s then execute via use_curl function
				$use_curl=use_curl($validate_url,$valid_data);
				//print_r($use_curl);
		}else{	//else post data via post_redirect function
				post_redirect($validate_url, $valid_data);
			}
			exit;
		}
	
	
}
//check checkout theme and set
if(isset($_SESSION['checkout_theme'])&&$_SESSION['checkout_theme']){
	$checkout_theme=$_SESSION['checkout_theme'];
}else{
	$checkout_theme='';
}

$g_sid=0;$g_mid=(int)$_SESSION['clientid'];
$domain_server=sponsor_themefc($g_sid,$g_mid,$checkout_theme); //fetch sponsor theme

$_SESSION['json_value']['checkout_theme']=$data['frontUiName'];

###############################################################################

	
	//if requestmoney in action then execute following section 
	if($_SESSION['action']=='requestmoney'){
		$post['product_name']=$_SESSION['notes'];	//notes use a product name
		$post['reference']=$_SESSION['reference'];	// nerchant order id
		$post['source']=" REQUESTMONEY ";			//source requestmoney	
		$_SESSION['http_referer']=str_replace("&actiontype=requestmoney","",$_SESSION['http_referer']);	//remove actiontype from referer
		$_SESSION['http_referer']=$_SESSION['http_referer']."&actiontype=requestmoney";	//add actiontype is requestmoney in referer
		//unset($_SESSION['acquirerIDs']);
	}

###############################################################################

//if bussiness url exists then remove https http and www from url
if(isset($post['bussiness_url'])&&$post['bussiness_url']) $bussinessurl=str_replace(array("https://","http://","www."),array("","",""),$post['bussiness_url']);


//echo "<hr/>clientid=>".$_SESSION['clientid']; echo "<hr/>status=>".$post['status_mem'];


//if fullname exists and ccholder name is empty then split fullname with blankspace (' ') and add second part in ccholder_lname
if(isset($post['fullname'])&&$post['fullname']&&empty($post['ccholder'])){
	$post['ccholder']=stf($post['fullname']);
	$fullname=$post['ccholder'];
	if ($fullname == trim($fullname) && strpos($fullname, ' ') !== false) {
		$preg = preg_split('#\s+#', $fullname, 2);
		if(isset($preg[0])&&$preg[0])$post['ccholder']=$preg[0];
		if(isset($preg[1])&&$preg[1])$post['ccholder_lname']=$preg[1];
	}
}


//if bill_address exists then split bill_address with blankspace (' ') and add  bill_street_1 , bill_street_2
if(isset($post['bill_address'])&&$post['bill_address']&&!empty($post['bill_address']))
{
	$post['bill_address']=stf($post['bill_address']);
	$bill_address=$post['bill_address'];
	if ($bill_address == trim($bill_address) && strpos($bill_address, ' ') !== false) {
		$preg = preg_split('#\s+#', $bill_address, 2);
		if(isset($preg[0])&&$preg[0])$post['bill_street_1']=$preg[0];
		if(isset($preg[1])&&$preg[1])$post['bill_street_2']=$preg[1];
	}
}



//if cardnumber exists then remove blankspaces from ccno
if(isset($post['ccno'])&&$post['ccno']){$post['ccno']=str_replace(' ','',$post['ccno']);}
//$post['bill_name']=$post['fullname'];	//fullname

//check con_name, if clk then store bill_amt from $_POST to $_SESSION
if($data['con_name']=='clk'){
	if(isset($_POST['bill_amt'])&&$_POST['bill_amt']){
		$post['bill_amt']=$_POST['bill_amt'];
		$_SESSION['bill_amt']=$_POST['bill_amt'];
	}
}else{
	//for non-clk, unset $_POST['bill_amt'] if exists
	if(isset($_POST['bill_amt'])&&$_POST['bill_amt']&&isset($_SESSION['bill_amt'])&&$_SESSION['bill_amt']){
		unset($_POST['bill_amt']);
	}
}



###############################################################################

	
	if((((!isset($moto_vt)||$moto_vt==false))||((!isset($post['integration-type'])||$post['integration-type']!="s2s")))&&((isset($login_required)&&$login_required==true)&&(!isset($_SESSION['uid'])))){ // login check if assign in the account

		$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
			$_SESSION['redirect_url']=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
		
		$_SESSION['send_data']=array();
		foreach($post as $key=>$value)$_SESSION['send_data'][$key]=$value;
		
		header("location:{$data['Host']}/login".$data['ex']);

	}elseif((isset($post['integration-type']))&&($post['integration-type']=="s2s")){
		$curl_action=true;
	}
	
//check store is test mode or not	
	if($_SESSION['store_midcard_test_mode']){
		if($_SESSION['common_midcard']) unset($_SESSION['common_midcard']);
	}
	
	
//check acquirer is common, f yest then merger with store_midcard
	if(isset($_SESSION['common_midcard'])&&$_SESSION['common_midcard']&&isset($_SESSION['store_midcard'])&&$_SESSION['store_midcard']) { 			
		$_SESSION['store_midcard']=array_merge($_SESSION['common_midcard'],$_SESSION['store_midcard']);
	}
	
	/*
	echo "<br/>store_midcard_test_mode=>".$_SESSION['store_midcard_test_mode'];
	echo "<br/>store_midcard=>";print_r($_SESSION['store_midcard']);
	echo "<br/>common_midcard=>";print_r($_SESSION['common_midcard']);
	*/
	
//check acquirer exists in $_SESSION or not, if yes then execute following section

	if(isset($_SESSION['acquirerIDs'])&&$_SESSION['acquirerIDs']){
		
	$post['AccountInfoByMerchant']=array();	//create an AccountInfoByMerchant array
		//$post['AccountInfoByMerchant']=explode1(',',$_SESSION['acquirerIDs']); 
		
		$post['AccountInfoByMerchant']=(isset($_SESSION['store_midcard'])?$_SESSION['store_midcard']:''); 
	//if array AccountInfoByMerchant exists then remove duplicate data from AccountInfoByMerchant array
		if(isset($post['AccountInfoByMerchant'])&&is_array($post['AccountInfoByMerchant'])) 
			$post['AccountInfoByMerchant'] = array_unique($post['AccountInfoByMerchant']);
		else
			$post['AccountInfoByMerchant'] = array();
			

		
		foreach($post['AccountInfoByMerchant'] as $value){
			if($value){
				$value=(int)$value;
				
			
				//to check "Check : 1" in channel_type then add value in acquirer_id_check array
				if(isset($_SESSION['b_'.$value]['channel_type']) && (in_array($_SESSION['b_'.$value]['channel_type'],[1]))) {
					@$post['acquirer_id_check'] .= $value.",";
					$post['acquirer_id_check_arr'][]=$value;
				}
			
				//to check "2d, 3d - Card : 2,3" in channel_type then add value in acquirer_id_card array
				if(isset($_SESSION['b_'.$value]['channel_type']) && (in_array($_SESSION['b_'.$value]['channel_type'],[2,3]))) {
					@$post['acquirer_id_card'] .= $value.",";
					$post['acquirer_id_card_arr'][]=$value;
				}
			
			
				//to check "wa - Wallets, bt - Bank Transfer, ot- Other : 4,11,99" in channel_type then add value in acquirer_id_ewallets array
				if(isset($_SESSION['b_'.$value]['channel_type']) && (in_array($_SESSION['b_'.$value]['channel_type'],[4,11,99]))) {
					@$post['acquirer_id_ewallets'] .= $value.",";
					$post['acquirer_id_ewallets_arr'][]=$value;
					//echo "<br/>value=>".$value;
				}
			
			
				//to check name6 popup_msg_web is empty or not
				if(isMobileDevice()&&isset($_SESSION["b_".$value]['aLj']['popup_msg_mobile'])&&trim($_SESSION["b_".$value]['aLj']['popup_msg_mobile']))
				{
					@$post['t_name6'] .= $_SESSION["b_".$value]['aLj']['popup_msg_mobile'].",";
					
				}elseif(isset($_SESSION["b_".$value]['aLj']['popup_msg_web'])&&trim($_SESSION["b_".$value]['aLj']['popup_msg_web']))
				{
					@$post['t_name6'] .= $_SESSION["b_".$value]['aLj']['popup_msg_web'].", ";
				}
				
			
				//to check "nb - Banking : 6" in channel_type then add value in acquirer_id_net_banking array
				if(isset($_SESSION['b_'.$value]['channel_type']) && (in_array($_SESSION['b_'.$value]['channel_type'],[6]))) {
					@$post['acquirer_id_net_banking'] .= $value.",";
					$post['acquirer_id_net_banking_arr'][]=$value;
				}
				
				
				//to check "UPI,QR,Intent : 5,9,10" in channel_type then add value in acquirer_id_upi array
				if(isset($_SESSION['b_'.$value]['channel_type']) && (in_array($_SESSION['b_'.$value]['channel_type'],[5,9,10]))) {
					@$post['acquirer_id_upi'] .= $value.",";
					$post['acquirer_id_upi_arr'][]=$value;
				}
				
				
			}
		}
	}



//acquirer_id

if((isset($post['acquirer_id'])&&trim($post['acquirer_id'])&&$post['acquirer_id']>0)&&(!isset($post['acquirer'])||empty($post['acquirer']))){
	$post['acquirer']=$post['acquirer_id'];
}

/*
if((!isset($post['acquirer_id'])||empty($post['acquirer_id']))&&isset($_SESSION['acquirerIDs'])&&trim($_SESSION['acquirerIDs']))
$post['acquirer_id']=$_SESSION['acquirerIDs'];	//acquirer into acquirer_id
*/



/*
echo "<br/>acquirer=>".print_r($_SESSION['acquirerIDs']);
echo "<br/>store_midcard=>".print_r($_SESSION['store_midcard']);
echo "<br/>acquirer_id_card=>".print_r($post['acquirer_id_card']);
echo "<br/>acquirer_id_ewallets=>".print_r($post['acquirer_id_ewallets']);
echo "<br/>acquirer_id_net_banking=>".print_r($post['acquirer_id_net_banking']);
echo "<br/>AccountInfo=>".print_r($_SESSION['AccountInfo']);
*/	



if(isset($_SESSION['clientid'])) $_SESSION['info_data']['mid']=$_SESSION['clientid'];	//clientid id
if(isset($_SESSION['terNO'])) $_SESSION['info_data']['terNO']=$_SESSION['terNO'];		//trminal id
if(isset($post['bill_address'])&&isset($post['bill_city'])&&isset($post['bill_state'])&&isset($post['bill_country'])&&isset($post['bill_zip']))
	$_SESSION['info_data']['bill_address']="Address: ".$post['bill_address'].", City: ".$post['bill_city'].", State: ".$post['bill_state'].", Country: ".$post['bill_country'].", ZIP: ".$post['bill_zip']; //full bill_address

$_SESSION['info_data']['product_name']=(isset($_SESSION['mode'])?$_SESSION['product']:'');	//product name
$_SESSION['info_data']['mode']=(isset($_SESSION['mode'])?$_SESSION['mode']:'');	//mode


$_SESSION['info_data']['first_name']=(isset($post['ccholder'])?$post['ccholder']:'');	//card holder name
$_SESSION['info_data']['last_name']=(isset($post['ccholder_lname'])?$post['ccholder_lname']:'');	//card holder last name
$_SESSION['info_data']['bill_city']=(isset($post['bill_city'])?$post['bill_city']:'');	//bill_city
$_SESSION['info_data']['bill_state']=(isset($post['bill_state'])?$post['bill_state']:'');	//bill_state
$_SESSION['info_data']['country']=(isset($post['bill_country'])?$post['bill_country']:'');	//country
$_SESSION['info_data']['phone']=(isset($post['bill_phone'])?$post['bill_phone']:'');	//mobile number
$_SESSION['info_data']['email']=(isset($post['bill_email'])?$post['bill_email']:'');				//email id
$_SESSION['info_data']['amt']=(isset($_SESSION['bill_amt'])?$_SESSION['bill_amt']:'0');		//order amount
$_SESSION['info_data']['ccno']=(isset($post['ccno'])?$post['ccno']:'');					//card number
$_SESSION['info_data']['mop']=(isset($post['mop'])?$post['mop']:'');		//card type
$post['email_re_enter']=(isset($post['bill_email'])?$post['bill_email']:'');						//repeat email





//to check data inn bill_country exist or not, if yes then fetch country codes and country full name
if(isset($post['bill_country'])&&$post['bill_country']){
	$post['country_three']	=get_country_code($post['bill_country'],3);	//country code three char
	$post['country_two']	=get_country_code($post['bill_country'],2);	//country code two char
	$post['country_fullnm']	=get_country_code($post['bill_country'],1);	//country full name
	$post['country_full_nm']	="(".$post['country_two'].") ".$post['country_fullnm']; //country name with two char code
	
	$_SESSION['info_data']['country']=$post['country_two'];	//store country code in two chars in $_SESSION
}

if(isset($post['bill_state'])&&$post['bill_state']){
	$post['state_two']=get_state_code($post['bill_state']);	//bill_state code
}

//if country is us, canada, australia and japan then bill_state mandatory
if(isset($post['country_two'])&&$post['country_two']&& in_array($post['country_two'],array('US','CA','AU','JP')) ){
	$stateValidation=true;
}


/*
echo "<h4>post product=".$post['product']."</h4>";
echo "<h4>post step=".$post['step']."</h4>";
echo "<h4>bussinessurl=".$bussinessurl."</h4>";
echo "<h4>_SERVER HTTP_REFERER=".$_SERVER['HTTP_REFERER']."</h4>";
echo "<h4>_SESSION http_referer=".$_SESSION['http_referer']."</h4>";
echo "<h4>post status=".$post['status_mem']."</h4>";
echo "<h4>_SESSION status=".$_SESSION['status']."</h4>";

*/

###############################################################################
if(isset($post['back']) && $post['back']){
	//if($post['step']==3){ $post['step'] = 1;  } else { $post['step']--; }
}



/*
if((strpos($data['urlpath'],"/payment/?user")!==false)||(strpos($data['urlpath'],"/payment/@")!==false)){
	echo $data['urlpath'];
	if(isset($_SESSION['re_post'])){
		$post=array_merge($post,$_SESSION['re_post'],$_POST); 
		//$_POST=$_SESSION['re_post']; 					
	}
}
*/			



//Dev Tech : 23-02-21 start - s2s access for acquirer_id postion change

	//unset acquirer the values
	if(isset($_SESSION['re_post']['acquirer'])){unset($_SESSION['re_post']['acquirer']);}
	if(isset($_SESSION['re_post']['acquirer_id'])){unset($_SESSION['re_post']['acquirer_id']);}
	if(isset($_SESSION['post']['acquirer_id'])){unset($_SESSION['post']['acquirer_id']);}
	
		
	if(isset($_SESSION['re_post']['failed_reason'])&&@$curl_action==false){	//if any failed reason, then unset acquirer and acquirer id
		if(isset($post['acquirer']))unset($post['acquirer']);
		if(isset($post['acquirer_id']))unset($post['acquirer_id']);
	}

	if(isset($_SESSION['integration-type'])) unset($_SESSION['integration-type']);
	if(isset($_SESSION['integration-type_notify'])) unset($_SESSION['integration-type_notify']);
	
	
	if(isset($curl_action)&&$curl_action==true){
		$_SESSION['integration-type']=$post['integration-type'];
	}
			
	
	if(isset($curl_action)&&$curl_action==true&&(!isset($post['acquirer'])||empty(trim($post['acquirer'])))){
		//$_SESSION['integration-type']=$post['integration-type'];
		
		if(isset($post['accountid'])&&trim($post['accountid'])) $accountid=$post['accountid'];
		
		
		//Dev Tech : 23-06-30 if one acquirer in terminal and not select radio button for curl access than pass acquirerIDs in acquirer & acquirer_id automate 
		if(((!isset($post['acquirer_id']))||(empty(trim($post['acquirer_id'])))) && ((!isset($_SESSION['curling_access_key']))||(empty(trim($_SESSION['curling_access_key'])))) && (isset($_SESSION['ter_acquirerIDs_s2s'])) && (!preg_match("/(,)/i", @$_SESSION['ter_acquirerIDs_s2s'])) ){
			$post['acquirer']=$post['acquirer_id']=$_SESSION['ter_acquirerIDs_s2s'];
			//$data['Error']=@$data['Error']." cond:1,  ";
		}
		
		/*
		$data['Error']=@$data['Error']."acquirerIDs: {$_SESSION['acquirerIDs']} ,ter_acquirerIDs_s2s: {$_SESSION['ter_acquirerIDs_s2s']} ,acquirer: {$post['acquirer']} , curling_access_key: {$_SESSION['curling_access_key']} , public_key: {$_SESSION['public_key']} ";
		$data['ErrorNo']='devtech9999';
		error_print($data['ErrorNo'],$data['Error']);
		*/
		
		
		if(isset($_SESSION['curling_access_key'])&&trim($_SESSION['curling_access_key'])){
			$post['acquirer']=$_SESSION['curling_access_key'];
		}
		elseif((!isset($post['acquirer_id']))||(empty(trim($post['acquirer_id'])))){
			$data['Error']='Can not empty via acquirer_id';
			$data['ErrorNo']=80;
		}
		
		$_SESSION['info_data']['source']=" CURL: curl_setopt ";
		$_SESSION['http_referer']=$_SESSION['http_referer']."&actiontype=s2s";
		
	}
	
	
	//acquirer  No. of Acquirer / Merchant Setting ID
	if(isset($post['acquirer'])&&trim($post['acquirer'])&&$post['acquirer']>0) {
		
		$acquirer=$post['acquirer']; // No. of Acquirer / Merchant Setting ID
		
		$channel_type_get=$_SESSION["b_".$acquirer]['channel_type'];
		$channel_type_name1=$_SESSION['info_data']['mop']=(isset($channel_type_get)&&isset($data['channel'][$channel_type_get]['name1'])?strtoupper($data['channel'][$channel_type_get]['name1']):"");
		
		$card_type=$channel_type_name1; // acquirer type : 2D,3D,WL,NB,UPI
		
		$_SESSION['settelement_delay']=$_SESSION['sp'.$acquirer];
		$_SESSION['rolling_delay']=$_SESSION['rp'.$acquirer];
			
			
		//if not in 2d & 3d than validation is false for card, contact address 
		if((isset($acquirer)) && (isset($_SESSION['b_'.$acquirer]['channel_type']) && (!in_array($_SESSION['b_'.$acquirer]['channel_type'],[1,2,3]))) ){
			$validation=false;
		}

		//if cardfalse Validation not require
		if((isset($acquirer)) && isset($_SESSION["b_".$acquirer]['aLj']['skip_checkout_validation']) && (strpos($_SESSION["b_".$acquirer]['aLj']['skip_checkout_validation'],'CardFalse') !== false) ){
			$settlementVali=false;
			$validation=false;
		}

		//if AddressFalse in name5 then store name2 as a mop and addressValidation not rquire
		if((isset($acquirer)) && isset($_SESSION["b_".$acquirer]['aLj']['skip_checkout_validation']) && (strpos($_SESSION["b_".$acquirer]['aLj']['skip_checkout_validation'],'AddressFalse') !== false) ){
			$settlementVali=false;
			$addressValidation=false;
		}

		//if LuhnValidationFalse via skip_checkout_validation of acquirer table 
		if((isset($acquirer)) && isset($_SESSION["b_".$acquirer]['aLj']['skip_checkout_validation']) && (strpos($_SESSION["b_".$acquirer]['aLj']['skip_checkout_validation'],'LuhnValidationFalse') !== false) ){
			$luhn_validation=false;
		}

	}






//Dev Tech : 23-02-21 end - s2s access for acquirer_id postion change


$domain_match="";
###############################################################################
//first step of transaction
if($post['step']==1){
	
	
	if(isset($_SESSION['scrubbed_msg'])) unset($_SESSION['scrubbed_msg']);	//unset scrubbed message
	if(isset($_SESSION['tr_transID'])) unset($_SESSION['tr_transID']);	//unset transID
	if(isset($post['a1'])&&$post['a1']=='t'){
		
	}else{
		//cmn
		unset($_SESSION['tr_newid']); 	//unset newly added id
	}
	
	

	//store currency in $_SESSION
	if(($_SESSION['post']['curr'])&&($_SESSION['post']['curr']!=$_SESSION['curr'])){$_SESSION['curr']=$_SESSION['post']['curr']; }
	
	
	$domain_match ="no";
	
    if(!isset($moto_vt)||$moto_vt==false){
		if((!empty($_SESSION['http_referer']))&&(!empty($bussinessurl))){
			if((strpos($_SESSION['http_referer'],$bussinessurl) !== false)) {
				$domain_match ="yes";
			   // echo 'Match found';
			}elseif((strpos($_SESSION['http_referer'],"apiprocesspage") !== false) || (strpos($_SESSION['http_referer'],"generate") !== false)  || (strpos($_SESSION['http_referer'],"://localhost") !== false)  ) {
				$domain_match ="yes";
			}
		}
	}else{
		$domain_match ="yes";
	}
	
	if($_SESSION['action']=='requestmoney'){
		$domain_match ="yes";
	}
	
	
		
	
	
	//store merchant order id into $_SESSION
	$_SESSION['info_data']['request_reference']=(isset($post['reference'])?$post['reference']:'');
	

	
	if(isset($post['product_name'])&&$post['product_name']){$post['product']=$post['product_name'];$_SESSION['product']=$post['product_name'];}
	$post['clients']=get_clients_username(@$post['clientid']);		//fetch clients user name
	$post['status_mem']=get_clients_status_ex(@$post['clientid']);	//fetch clients status
	
	if(($_SESSION['post']['curr'])&&($_SESSION['post']['curr']!=$_SESSION['curr'])){$_SESSION['curr']=$_SESSION['post']['curr']; }
	
	if(isset($_SESSION['bill_amt'])){
		$_SESSION['bill_amt']=prnsumf($_SESSION['bill_amt'],$_SESSION['curr']);
		

		$_SESSION['total']=$_SESSION['bill_amt'];
		$total_payment = $_SESSION['total']; // bill_amt store in total_bill_amt for further use
	}
	
	//cmn
	//echo "<br/>bill_amt=>".$_SESSION['post']['bill_amt']; echo "<br/>post=>"; print_r($_SESSION['re_post']); echo "<hr/><br/>";
	
	//if(isset($post['integration-type'])&&$post['integration-type']){ //start
		
		if(isset($_SESSION['ufound'])) unset($_SESSION['ufound']); //unset session $_SESSION['ufound'] set

		if(isset($_SESSION['bill_amt'])&&$_SESSION['bill_amt']<=0){	//if bill_amt is lessthan zero (0) then message bill_amt is mandatory
				$data['Error']='Please enter valid sum for payment.';
		}elseif($_SESSION['action']=='payment'&&
			get_clients_status($uid)<2&&$_SESSION['bill_amt']>$data['PaymentMaxSum']){ //if action is payment then check clients status and transaction limit
				$data['Error']="Receiver cannot receive more than".
					" {$data['Currency']}{$data['PaymentMaxSum']} per".
					" transaction because she/he is UNVERIFIED clients.";
		}elseif((!isset($post['fullname']))||(empty(trim($post['fullname'])))){
			//cmn
			$data['Error']='Name can not be empty.';	//fullname mandatory
			$data['ErrorNo']=81;
		}
		elseif((((!isset($post['bill_email']))||(empty(trim($post['bill_email']))))||!verify_email2($post['bill_email']))&&($addressValidation)){
			$data['Error']='Email bill_address can not be empty & should be valid'; //print this message if email mandatory
			$data['ErrorNo']=82;
		}elseif(((!isset($post['bill_address']))||(!$post['bill_address']))&&($addressValidation)){	//print this message if Billing Address  mandatory
			$data['Error']='Billing Address can not be empty.';
			$data['ErrorNo']=83;
		}elseif(((!$post['bill_city'])||(empty(trim($post['bill_city']))))&&($addressValidation)){
			$data['Error']='Billing bill_city can not be empty.';	//print this message if Billing bill_city mandatory
			$data['ErrorNo']=84;
		}elseif(((!isset($post['bill_state']))||(!$post['bill_state'])||(empty(trim($post['bill_state']))))&&($addressValidation)&&($stateValidation)){
			$data['Error']='Billing bill_state can not be empty.';	//print this message if Billing bill_state mandatory
			$data['ErrorNo']=85;
		}
		elseif(!$post['bill_country']&&empty($post['bill_country'])&&$addressValidation){
			$data['Error']='Billing country can not be empty.';	//print this message if Billing country mandatory
			$data['ErrorNo']=86;
		}elseif(!get_country_code($post['bill_country'],1,1)&&$addressValidation){
			$data['Error']='Billing country ('.$post['bill_country'].') is not valid. ';	//print this message if Billing country mandatory
			$data['ErrorNo']=861;
		}elseif(((!$post['bill_zip'])||(empty(trim($post['bill_zip']))))&&($addressValidation)){
			$data['Error']='Billing bill_zip bill_address can not be empty.';	//print this message if Billing bill_zip mandatory
			$data['ErrorNo']=87;
		}elseif((!$post['bill_phone'])||(empty(trim($post['bill_phone']))) ){
			$data['Error']='Billing phone number can not be empty.';	//print this message if Billing phone number  mandatory
			$data['ErrorNo']=88;
		}else{
			//if above all condition false, then execute this section
		
			
			//print_r($post);
			$_SESSION['ufound']=true;		//set ufound is true	
			//$_SESSION['ccholder'] = $post['ccholder'];	//card holder name
			//$_SESSION['ccno'] = $post['ccno'];		//card number
			$_SESSION['email_cc'] = $post['bill_email'];	//email id
			$_SESSION['payment_mode']= isset($post['payment'])?$post['payment']:'';	//payment mode
		
			
			
			if(isset($_SESSION['re_post'])&&isset($_POST)){
				$_SESSION['re_post']=array_merge($_SESSION['re_post'],$_POST);	//merge $_POST and re_post array
			}
			
			if(isset($_POST)){
				$post2=get_post1($_POST);	//store all $_POST data into $post2 for further use
			}
			
			if(isset($_SESSION['post'])&&isset($_POST)){
				$_SESSION['post']=array_merge($_SESSION['post'],$_POST);	//merge $_POST and post array
			}
			
			if(isset($_SESSION['json_value']['post'])&&isset($post2)){
				$_SESSION['json_value']['post']=array_merge($_SESSION['json_value']['post'],$post2);	//merge json_value and post2 array
			}
			
			
			
            $post['step']++;	//step one is complete and forward to next step
		   //echo "<br/><br/><br/>"."p1= step==>".$post['step']."<br/><br/><br/>";
		}
		//if (!empty($data['Error'])){wh_log('Error='.$data['Error']);}
	//}//end		
	


	//if any error then print error with code
	if(isset($curl_action)&&$curl_action==true&&isset($data['Error'])){
		$data['Message']=$data['Error'];
		$data['Error']=$data['ErrorNo'];
		error_print($data['Error'],$data['Message']);	//print error
	}					
	
	
}



		
		
//if any error then print error with code
if(isset($data['Error']) && $data['Error'] && isset($_REQUEST['pajax']) && !empty($_REQUEST['pajax'])){
	error_print(9999,$data['Error']);exit;	//print error and exit
}elseif((isset($post['integration-type']))&&($post['integration-type']=="s2s")&&isset($data['Error'])&&$data['Error']&&isset($data['ErrorNo'])&&$data['ErrorNo']){
	error_print($data['ErrorNo'],$data['Error']);exit;		//print error and exit
}


	
//echo "<br/>Error<br/><br/>";print_r($data['Error']);echo "<br/>addressValidation<br/><br/>";print_r($addressValidation);echo "<br/>con_name<br/><br/>";print_r($data['con_name']);echo "<br/>step<br/><br/>";print_r($post['step']);echo "<br/>_REQUEST<br/><br/>";print_r($_REQUEST);echo "<br/><br/>post<br/><br/>";print_r($post);exit;

//cm
//echo "<br/>post=>"; print_r($post); exit;




//Dev Tech : 23-02-21 end - modify for check condition for STEP1 AND STEP2 






//bearer token
########	//Dev Tech: 23-03-21 for start - bearer token	#####################

if(isset($post['bearer_token_id'])&&trim($post['bearer_token_id'])){
	$bearer_token_exp=explode1('_',$post['bearer_token_id']);	
	if(isset($bearer_token_exp[0])&&trim($bearer_token_exp[0]))
		$_SESSION['bearer_token_id']	=$bearer_token_exp[0];	
	if(isset($bearer_token_exp[1])&&trim($bearer_token_exp[1]))
		$_SESSION['json_log_newid']	=$bearer_token_exp[1];	
}

	
if(isset($_SESSION['clientid'])&&$_SESSION['clientid']>0&&isset($_SESSION['terNO'])&&$_SESSION['terNO']>0){
	
	//$_SESSION['transID_arr'][]=$_SESSION['transID'];
	
	if(isset($json_log_arr['ccno'])) unset($json_log_arr['ccno']);
	if(isset($json_log_arr['ccvv'])) unset($json_log_arr['ccvv']);
	if(isset($json_log_arr['month'])) unset($json_log_arr['month']);
	if(isset($json_log_arr['year'])) unset($json_log_arr['year']);
				
	if(isset($post['step'])) $json_log_arr['step']=$post['step'];
	if(isset($_SESSION['transID_arr'])) $json_log_arr['transID_arr']=implode(',',$_SESSION['transID_arr']);

	/*if(isset($_SESSION['tr_newid'])){
		$tableId=$_SESSION['tr_newid'];
		$tableName='master_trans_table';
	}
	else */
	if(isset($_SESSION['json_log_newid'])){
		$tableId=$_SESSION['json_log_newid'];
		$tableName='json_log';
	}else{
		$tableId=0;
		$tableName='master_trans_table';
		
		$json_log_arr['merID']=$_SESSION['clientid'];
		if((isset($_SESSION['json_value']))&&(!empty($_SESSION['json_value']))){
			$_SESSION['json_value']['post']['TIMESTAMP']=prndates(date('Y-m-d H:i:s'));
			$json_log_arr=array_merge($json_log_arr,$_SESSION['json_value']);
		}
	}
	
	$action_name='Bearer Token';
	if(isset($_SESSION['bearer_token_id'])&&trim($_SESSION['bearer_token_id'])){
		$action_name=$_SESSION['bearer_token_id'];
	}
	
	
	$_SESSION['manual_log_creds']="Payin-Processing:".$_SESSION['clientid']."-".$_SESSION['mem']['username'];
	
	if(isset($data['json_log_upd_payin_processing'])&&$data['json_log_upd_payin_processing']=='Y')
	{
		json_log_upd($tableId,$tableName,$action_name,$json_log_arr,$_SESSION['clientid'],$_SESSION['terNO']);
	}
	
	if(!isset($_SESSION['bearer_token_id'])&&isset($data['bearer_token_id'])&&trim($data['bearer_token_id'])){
		$_SESSION['bearer_token_id']=$data['bearer_token_id'];
	}
	
	if(isset($_SESSION['bearer_token_id'])&&trim($_SESSION['bearer_token_id'])){
		$bearer_token=$_SESSION['bearer_token_id'];
		$_SESSION['json_value']['bearer_token_id']=$bearer_token;  
		$_SESSION['re_post']['bearer_token_id']=$bearer_token."_".$_SESSION['json_log_newid'];  
	}
	
}

########	//Dev Tech: 23-03-21 for end - bearer token	#####################



//step 2 started
if($post['step']==2){
	
	//Dev Tech : 23-06-30 if not receive integration-type than set this
	if(!isset($post['integration-type'])||empty($post['integration-type'])){
		$post['integration-type']="Encode-Checkout";
	}
	
	if(isset($_SESSION['bank_processing_amount'])) unset($_SESSION['bank_processing_amount']);	//UNSET bank_processing_amount if set in $_SESSION
	if(isset($_SESSION['bank_processing_curr'])) unset($_SESSION['bank_processing_curr']);	//UNSET bank_processing_curr if set in $_SESSION
	
	//remove blank spaces from card number if exists
	if(isset($_POST['ccno'])&&$_POST['ccno']){$_POST['ccno']=str_replace(' ','',trim($_POST['ccno']));}
	if(isset($post['ccno'])&&$post['ccno']){$post['ccno']=str_replace(' ','',$post['ccno']);}
	
	//bill_address is empty then add bill_address and bill_street_2 in bill_address field
	if(empty($post['bill_address'])&&isset($post['bill_street_2'])&&trim($post['bill_street_2'])){$post['bill_address'] = $post['bill_address'].",".$post['bill_street_2'];}
	
	
	
	######### INACTIVE BANK AC - START
	
	$inactive_fail_bank_list=$_SESSION['inactive_fail_bank_list'];

	if($data['pq'])
	{
		echo 'inactive_fail_bank_list-22';
		print_r($_SESSION['inactive_fail_bank_list']);
		//exit;
	}
	//if account in inactive_fail_bank_list then mid temporary inactive
	if(isset($acquirer)&&$acquirer>0&&isset($inactive_fail_bank_list[$acquirer]['inactive_failed_count'])&&$inactive_fail_bank_list[$acquirer]['inactive_failed_count'])
	{
		$inactive_failed_count	= $inactive_fail_bank_list[$acquirer]['inactive_failed_count'];
		$notification_email				= $inactive_fail_bank_list[$acquirer]['notification_email'];
		
		$sqlStmt = "SELECT count(`id`) as `ct` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` WHERE `acquirer`='$acquirer' AND `trans_status`='2' AND `id` > (SELECT `id` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` WHERE `acquirer`='$acquirer' AND `trans_status`='1' ORDER BY `id` DESC LIMIT 1) LIMIT 1"; 

		$fail_rows	= db_rows($sqlStmt);
		$totalFail	= $fail_rows[0]['ct'];
		if($data['pq'])
		{
			echo 'totalFail =>';
			echo $totalFail."<br />".$inactive_failed_count;
			exit;
		}
		if($totalFail>=$inactive_failed_count)
		{
			db_query(
				"UPDATE `{$data['DbPrefix']}acquirer_table` SET `acquirer_status`='0' WHERE `acquirer_id`='$acquirer'");
			
			$notification_emailArr = explode(',',$notification_email);
			
			$bank_post['uid']=$_SESSION['clientid'];
			$bank_post['tableid']=$_SESSION['clientid'];
		//	$bank_post['mail_type']="42";
			$bank_post['email_header']=1;
			$bank_post['email_br']=1;
			$bank_post['bank_name']=$acquirer;
			
			for ($i=0;$i<count($notification_emailArr);$i++) {
				$email_id = $notification_emailArr[$i];
				$bank_post['email'] = $email_id;
				send_email('BANK-GATEWAY-INACTIVATED', $bank_post);
			}
			$data['Error']=158;
			$data['Message']="This MID is inactive. Please contact to Support";
			error_print($data['Error'],$data['Message']);	//print error

			exit;
		}
	
	}

	######### INACTIVE BANK AC - END


	if(($_SESSION['post']['curr'])&&($_SESSION['post']['curr']!=$_SESSION['curr'])){$_SESSION['curr']=$_SESSION['post']['curr']; }
	
	if(isset($_SESSION['bill_amt'])&&$_SESSION['bill_amt']){
		$_SESSION['bill_amt']=prnsumf($_SESSION['bill_amt'],$_SESSION['curr']);
	}
	
	/*
	echo "<br/>acquirer=>".$acquirer;
	echo "<br/>inactive_bank_ac_list=>";print_r($_SESSION['inactive_bank_ac_list']);
	echo "<br/>all_bank_ac_list=>";print_r($_SESSION['all_bank_ac_list']);
	*/
	
	//check mid is active or not
	if(isset($acquirer)&&$acquirer&&((isset($_SESSION['inactive_bank_ac_list'])&&in_array($acquirer, $_SESSION['inactive_bank_ac_list']))||(isset($_SESSION['all_bank_ac_list'])&&!in_array($acquirer, $_SESSION['all_bank_ac_list'])))){
		$data['Error']=1044;
		$data['Message']="Requested Acquirer Id has been terminated!!!";
		error_print($data['Error'],$data['Message']);	//print error
		exit;
	}
	
	if(isset($web_mc)&&isset($account_type_arr)&&$account_type_arr&&!in_array($acquirer,$account_type_arr)&&$curl_action==true){
		$data['Error']=1045;
		$data['Message']="MCC root not found ";
		error_print($data['Error'],$data['Message']);	//print error
		exit;
	}
	
	
	$total_payment 		= $_SESSION['bill_amt']; 	//bill_amt
	$post['total'] 		= $_SESSION['bill_amt']; 	//bill_amt
	$post['product']	= (isset($_SESSION['product'])?$_SESSION['product']:''); //product
	
	
	
			
	$tr_status=0;$testcardno=false;$scrubbedstatus=false;$currConverter=true; 
	
	if( isset($post['ccno']) && $post['ccno'] && (in_array(@$post['ccno'], $data['testCardNo'])) ){
		$luhn_validation=false;
	}
	if( isset($post['ccno']) && $post['ccno'] && (in_array(substr(@$post['ccno'],0,6), $data['luhn_skip'])) ){
		$luhn_validation=false;
	}
	
	
	//this section for test mode or test cards
	if( (isset($post['ccno'])&&(in_array($post['ccno'],$data['testCardNo']))) || ( isset($acquirer) && !empty($acquirer) && ($_SESSION['mode'.$acquirer]==2) )  ){
		//$tr_status=9; // 9 
		$testcardno=true;
		$_SESSION['json_value']['is_test']="9";
		$_SESSION['json_value']['is_test_name']="test";
	}elseif( (!in_array(@$post['ccno'], $data['testCardNo'])) && ( (isset($acquirer) && !empty($acquirer) && $_SESSION['mode'.$acquirer]!=1) || (isset($_SESSION['product_active'])&&$_SESSION['product_active']==2) )  ){
		//$tr_status=9; // 9 
		$testcardno=true;
		$_SESSION['json_value']['is_test']="9";
		$_SESSION['json_value']['is_test_name']="test";
	}elseif((isset($post['ccno'])&&(in_array($post['ccno'], $data['testCardNo']))) && ($_SESSION['mode'.$acquirer]!=1)  ){
		$testcardno=true;
	}
	
	
	
	$ctest="";
	if((isset($_POST['ctest']))){
		$_GET['ctest']=$_POST['ctest'];
	}
	
	
	if((isset($_GET['ctest']))){	
		$tr_status=$_GET['ctest'];$testcardno=true;
		$ctest="&ctest=".$tr_status;
		if($tr_status==1){
			$scrubbedstatus=false;
		}elseif($tr_status==2){
			$scrubbedstatus=true;
		}elseif($tr_status==11){
			$tr_status=0;
			$scrubbedstatus=false;
			
			if($post['integration-type']!="s2s"){
				//$ctest.="&qp1=1";
			}
		}
		elseif($tr_status==22){
			$tr_status=0;
			$scrubbedstatus=true;
			if($post['integration-type']!="s2s"){
				//$ctest.="&qp1=1";
			}
		}
	}
	
	if(isset($post['ccno'])&&$post['ccno']){
		$post['validateCard']=luhn($post['ccno']);	//check card validity with Luhn algorithm
	}
	
	
	if((isset($acquirer)) && isset($_SESSION["b_".$acquirer]['aLj']['inputValidation']) && trim($_SESSION["b_".$acquirer]['aLj']['inputValidation']))
	{
		$inputValidation=true;
		$inputName=$_SESSION["b_".$acquirer]['aLj']['inputValidation'];
		
	}
	
	
	//if(isset($post['integration-type'])&&isset($acquirer)&&$acquirer>0)
	if(isset($post['integration-type']))
	{
		
		
		unset($_SESSION['ufound']);
		
		if(isset($acquirer))
		{
			$bank_cards_name=isset($_SESSION['b_'.$acquirer]['mop'])?$_SESSION['b_'.$acquirer]['mop']:''; 
		
		}
		
		if(isset($_REQUEST['actionajax'])&&!empty($_REQUEST['actionajax'])){
			$curl_action=1; // for ajax validation in error 
		}
		
		if($inputValidation&&$inputName&&(!isset($post[$inputName])||!$post[$inputName])){
			$data['Error']=$inputName.' can not be empty.';
			if(isset($curl_action)&&$curl_action==true){
				$data['Message']=$data['Error'];
				$data['Error']=1105;
				error_print($data['Error'],$data['Message']);	//print error
			}
		}elseif((empty($bank_cards_name))&&($validation==true)){
			$data['Error']='Card Name missing from Bank Gateway.';
			if(isset($curl_action)&&$curl_action==true){
				$data['Error']=150;
				$data['Message']="Card Name missing from Bank Gateway ".$acquirer;
				error_print($data['Error'],$data['Message']);	//print error
			}
		}elseif((!isset($post['ccno'])||!$post['ccno'])&&($validation==true)){
			$data['Error']='Card number can not be empty.';
			if(isset($curl_action)&&$curl_action==true){
				$data['Error']=151;
				$data['Message']="Card number can not be empty.";
				error_print($data['Error'],$data['Message']);	//print error
			}
		}elseif((!isset($post['validateCard'])||!$post['validateCard']) && ($validation==true) && (empty($post['validateCard'])) && ($testcardno==false) && ($luhn_validation==true)){
			
			//$data['Error']='Wrong card number: '.$post['ccno'].'. Please supply a valid card number.';
			
			$data['Error']='We are unable to validate the accuracy of your card. Would you like to try with another card or check the current card number please?';
			
			if(isset($curl_action)&&$curl_action==true)
			{
				$data['Error']=152;
				$data['Message']="We are unable to validate the accuracy of your card. Would you like to try with another card or check the current card number please?";
				error_print($data['Error'],$data['Message']);	//print error
			}else {
				echo'<script>alert("We are unable to validate the accuracy of your card. Would you like to try with another card or check the current card number please?");</script>';
			}
		}elseif(is_string(validatecard(@$post['ccno']))&&$bank_cards_name&&(strpos($bank_cards_name,validatecard(@$post['ccno']))===false) && ($validation==true) && ($luhn_validation==true)){
			$data['Error']="No Payment Channel  Available to process this card, Please try again using ".$bank_cards_name;
			if(isset($curl_action)&&$curl_action==true){
				$data['Error']=153;
				$data['Message']="No Payment Channel  Available to process this card, Please try again using ".$bank_cards_name;
				error_print($data['Error'],$data['Message']);	//print error
			}
		}elseif(((!isset($post['ccvv'])||!$post['ccvv'])) && ($validation==true)){
			$data['Error']='CCVV number can not be empty.';
			if(isset($curl_action)&&$curl_action==true){
				$data['Error']=154;
				$data['Message']="Card CCVV number can not be empty.";
				error_print($data['Error'],$data['Message']);	//print error
			}
		}elseif(((!isset($post['month'])||!$post['month'])) && ($validation==true)){
			$data['Error']='Please select expiry date month.';
			if(isset($curl_action)&&$curl_action==true){
				$data['Error']=155;
				$data['Message']="Expiry date month of card can not be empty.";
				error_print($data['Error'],$data['Message']);	//print error
			}
		}elseif((!isset($post['year']) || !$post['year']) && ($validation==true)){
			$data['Error']='Please select expiry date year.';
			if(isset($curl_action)&&$curl_action==true){
				$data['Error']=156;
				$data['Message']="Expiry date year of card can not be empty.";
				error_print($data['Error'],$data['Message']);	//print error
			}
		}elseif((!isset($_SESSION["sp".$acquirer])) && ($settlementVali==true)){
			$data['Error']=157;
			$data['Message']="Settlement Period missing in Acquirer. Contact to Support";
			error_print($data['Error'],$data['Message']);	//print error
		}elseif((!$acquirer) && ($validation==true)){
			$data['Error']='acquirer error';
			if(isset($curl_action)&&$curl_action==true){
				//$data['Error']=158;
				//$data['Message']="Account ID. can not be empty.";
				//error_print($data['Error'],$data['Message']);
			}
		}else{
			//print_r($post);
			
			
			$_SESSION['ufound']=true;
			
			if(isset($post['year'])&&strlen($post['year'])>=4){$post['year']=substr($post['year'],-2,2);}
			
			//$post['year4'] =((strlen($post['year'])==4)?$post['year']:"20".$post['year']);
			$post['year4'] =(isset($post['year'])?"20".$post['year']:'');
			
			if(isset($post['month']))
			{
			$post['month'] = ((strlen($post['month'])==2)?$post['month']:"0".$post['month']);
			if(strlen($post['month'])>2){$post['month']=substr($post['month'],-2);}
			
			}
			
			
			if(isset($post['ccno'])&&trim($post['ccno'])&&$validation==1){	
				$_SESSION['info_data']['mop']=validatecard(@$post['ccno']);
			}
			
			
			if($_SESSION['curr']){
				$currency_smbl=get_currency($_SESSION['curr']);
				$_SESSION['bill_currency']=$_SESSION['curr'];
			}else{
				$_SESSION['bill_currency']=$_SESSION['fullcurrname'.$acquirer];	
			}
			
			
			if(isset($post['month'])&&isset($post['year']))
			$post['expdate'] = $post['month'].$post['year'];

			//$post['bill_fees']=($_SESSION['total']*$data['PaymentPercent']/100)+$data['PaymentFees'];
			
			//$trcode step 2  insert_transaction
			
			if(isset($post['ccno'])&&$post['ccno']){$post['ccno']=str_replace(' ','',$post['ccno']);}
			if(empty($post['bill_state'])){$post['bill_state']=$post['bill_city'];}
				
			//$_SESSION['transIDSet']=$_SESSION['transID']."_".$_SESSION['terNO']."_".$_SESSION['clientid']."_".$_SESSION['reference'];
			
			
			//----------------------------------
				/* <<convenience_fee
			if($_SESSION['merchant_pays_fee']&&$_SESSION['af']&&$acquirer){
					
					$_SESSION['json_value']['af_'.$acquirer]=$_SESSION['af'][$acquirer];
					$_SESSION['bill_amt']=$_SESSION['af'][$acquirer]['total_amount'];
					
					$total_payment 		= $_SESSION['bill_amt']; 
					$post['total'] 		= $_SESSION['bill_amt']; 
					
				}
				
				*/
			//-----------------------------------
			
			
			
			$bpc=$_SESSION['b_'.$acquirer]['acquirer_processing_currency'];
			$_SESSION['json_value']['acquirer_processing_currency_bank']=$bpc;
			
						
						
	###### mid apJson :start #######################################
			//cmn
			$print_salt=0;
			if(isset($_SESSION['post']['qp'])&&$_SESSION['post']['qp']){
				$print_salt=$_SESSION['post']['qp'];		
			}
			if(isset($_SESSION['terNO_json_value'])&&$_SESSION['terNO_json_value']){
				$_SESSION['terNO_json_value']=str_replace(array('"{"','"}"'),array('{"','"}'),$_SESSION['terNO_json_value']);
				
				$sj=jsondecode($_SESSION['terNO_json_value']);
				
				if($print_salt==2){
					echo "<hr/>terNO_json_value=> ";
					print_r($sj);
				}
				//echo $sj2=jsonencode($sj); exit;
				//echo $_SESSION['terNO_json_value']; exit;
				
			}
			//$acquirer=(int)$acquirer;

			if(($acquirer==$_SESSION['curling_access_key'])&&($_SESSION['terNO_json_value'])){
				if(isset($_SESSION['salt_value_'.$acquirer])&&$_SESSION['salt_value_'.$acquirer]&&$_SESSION['salt_id_'.$acquirer]==$sj['terNO_json_curl']){
					$_SESSION["apJson$acquirer"]=jsonencode1($_SESSION['salt_value_'.$acquirer]);
					if($print_salt){echo "<hr/>if s2s=>0";}
				}elseif((!$sj['terNO_json'])&&(!$sj['terNO_json_curl'])){
					$_SESSION["apJson$acquirer"]=jsonencode1($sj);
					if($print_salt){echo "<hr/>if s2s=>1";}
				}elseif(!empty($sj['terNO_json_curl'])){
					$_SESSION["apJson$acquirer"]=jsonencode1($sj['terNO_json_curl']);
					if($print_salt){echo "<hr/>if s2s=>2";}
				}elseif(@$_SESSION['salt_value_'.$acquirer]){
					$_SESSION["apJson$acquirer"]=jsonencode1($_SESSION['salt_value_'.$acquirer]);
				}elseif(($acquirer==array_key_exists($acquirer,$sj['terNO_json']))&&(!empty($sj['terNO_json'][$acquirer]))){
					$_SESSION["apJson$acquirer"]=jsonencode1($sj['terNO_json'][$acquirer]);
					if($print_salt){echo "<hr/>if s2s=>3";}
				}
				
				//echo "<hr/>if curling=>OK";
				
			}elseif(isset($_SESSION['salt_value_'.$acquirer])&&$_SESSION['salt_value_'.$acquirer]){
				$_SESSION["apJson$acquirer"]=jsonencode1($_SESSION['salt_value_'.$acquirer]);
				if($print_salt){echo "<hr/>if salt_value_=>salt_decode_{$acquirer}<br/>";print_r($_SESSION['salt_decode_'.$acquirer]);}
			}elseif(isset($sj['terNO_json'])&&($acquirer==array_key_exists($acquirer,$sj['terNO_json']))&&(!empty($sj['terNO_json'][$acquirer]))){
				
				$_SESSION["apJson$acquirer"]=jsonencode1($sj['terNO_json'][$acquirer]);
				
				if($print_salt){echo "<hr/>if terNO_json=>OK";}
			}
			if($print_salt){ echo "<hr/>{$acquirer}_SESSION apJson acquirer=> ".$_SESSION["apJson$acquirer"];}


			//||sm_
			if(isset($_SESSION["apJson$acquirer"])&&is_string($_SESSION["apJson$acquirer"])&&strpos($_SESSION["apJson$acquirer"],'||sm_')!==false){
				
				$id_sm=(int)str_replace('||sm_','',$_SESSION["apJson$acquirer"]);
				$sm=$data['smDb'][$id_sm];
				if($sm['acquirer_processing_creds']){
					$_SESSION["apJson$acquirer"]=$sm['acquirer_processing_creds_en'];
					if($print_salt){echo "<hr/>||sm_=>OK!";}
				}
			}



			if($print_salt){ echo "<hr/>sm_=> ".$_SESSION["apJson$acquirer"];exit;}

			if(isset($_GET['ctest'])){	
				$apJson['apJson_1']=$_SESSION["apJson$acquirer"];		
			}

	###### mid apJson :end #######################################
	

			
			
			if(($_SESSION['info_data']['mop']=='discover'||$_SESSION['info_data']['mop']=='diners')&&$_SESSION['mode'.$acquirer]=="1"){
				if($_SESSION['curr']!='USD'){
					$currConverter=true;
					$bpc='USD';
				}
			}
			
			
			if((isset($acquirer)) && isset($_SESSION["b_".$acquirer]['aLj']['skip_checkout_validation']) && (strpos($_SESSION["b_".$acquirer]['aLj']['skip_checkout_validation'],'currConverterFalse') !== false) )	
			{
				$currConverter=false;
				//$_SESSION['trans_currency']=$bpc;
			}
			
			
			if(isset($post['bank_curr'])&&$post['bank_curr']&&in_array($acquirer,["701"])){
				$currConverter=true;
				$bpc=$post['bank_curr'];
			}
			
###### acquirer_processing_currency from apJson - acquirer :start #####################
			
		if((isset($_SESSION['apJson'.$acquirer]))&&(is_string($_SESSION['apJson'.$acquirer]))&&(strpos($_SESSION['apJson'.$acquirer],"acquirer_processing_currency")!==false)){
			$acquirer_processing_currency=jsonvaluef($_SESSION['apJson'.$acquirer],'acquirer_processing_currency');
			if($acquirer_processing_currency){
				$bpc=$acquirer_processing_currency;
				$_SESSION['json_value']['acquirer_processing_currency_mid']=$bpc;
				$currConverter=true;
			}
		}
		
		
		
	###### acquirer_processing_currency from apJson - acquirer :end #####################

			
			
			
			$_SESSION['currConverter']=$currConverter;
			if((!empty($bpc))&&($currConverter==true)){
				$_SESSION['bank_processing_curr']=$bpc;
				$_SESSION['json_value']['start_curr']=$_SESSION['curr'];
				$_SESSION['json_value']['bank_processing_curr']=$bpc;
				$_SESSION['json_value']['currencyConverter_total_payment']=$total_payment;
				if($_SESSION['curr']!=$bpc){
					$_SESSION['bank_processing_amount']=currencyConverter($_SESSION['curr'],$bpc,$total_payment,1);
					$_SESSION['json_value']['bank_processing_amount']=$_SESSION['bank_processing_amount'];
				}
			}
			
			
			
			$enc_email="";
			if((isset($_SESSION['notification'.$acquirer]))&&(strpos($_SESSION['notification'.$acquirer],"005")!==false)){
					$enc_email=rand_email($post['bill_email']);
					$_SESSION['json_value']['enc_email']=$enc_email;
			}
			
			//re
			if(isset($data['re_post'])){
				$_SESSION['json_value']['re_post']=$post['integration-type'];
			}
			if($_SESSION['curr']){
				$_SESSION['re_post']['curr']=$_SESSION['curr'];
			}
			
			if(isset($_SESSION['re_post'])&&isset($_POST)){
				$_SESSION['re_post']=array_merge($_SESSION['re_post'],$_POST);
			}

			if(isset($_POST)){
				$post3=get_post1($_POST);
			}
			
			if(isset($_SESSION['post'])&&isset($_POST)){
				$_SESSION['post']=array_merge($_SESSION['post'],$_POST);
			}
			if(isset($_SESSION['json_value']['post'])&&isset($post3)){
				$_SESSION['json_value']['post']=array_merge($_SESSION['json_value']['post'],$post3);
			}
			
			
			//value add in unset pram array
				//$unsetPram['un_m']=["_SESSION","_POST","_GET"];
				$unsetPram['un_m']=["_SESSION"];
				$unsetPram['un_p']=["re_post","post","json_value"];
				$unsetPram['un_v']=["step","status","status_mem","bill_name","bill_country_name","clients","cc_payment_mode","payment","acquirer","bussiness_url","aurl","bill_fees"];			
				unset_f1($unsetPram);
				
			//unset card info
				$unsetPram2['un_m']=["_SESSION"];
				$unsetPram2['un_p']=["json_value"];
				$unsetPram2['un_v']=["ccno","month","year","ccvv"];
				unset_f1($unsetPram2);
			
			if(isset($_SESSION['json_value']['post']['ccno']))	{unset($_SESSION['json_value']['post']['ccno']);}
			if(isset($_SESSION['json_value']['post']['month'])){unset($_SESSION['json_value']['post']['month']);}
			if(isset($_SESSION['json_value']['post']['year']))	{unset($_SESSION['json_value']['post']['year']);}
			if(isset($_SESSION['json_value']['post']['ccvv']))	{unset($_SESSION['json_value']['post']['ccvv']);}
			
			
			//cmn
			$thisTrInst=1;
			
			if(isset($_SESSION['transID'])&&!empty($_SESSION['transID'])&&$acquirer==602){
				//$thisTrInst=0;
			}
			
			if(isset($post['a1'])&&$post['a1']=='t'){
				//cmn
				//$thisTrInst=0;
			}
	
			
		//	if(isset($post['ccno'])&&$post['ccno']) 	$_SESSION['bin_no']		=$post['ccno'];
			if(isset($post['month'])&&$post['month']) 	$_SESSION['ex_month']	=$post['month'];
			if(isset($post['year4'])&&$post['year4']) 	$_SESSION['ex_year']	=$post['year4'];
		
		
			//print_r($data['Error']);exit;
			//insert create_new_trans -10
		
		
			
			if($thisTrInst){
				
				create_new_trans(
					$_SESSION['clientid'],		//merID
					$total_payment, 		//bill_amt
					$acquirer,				//acquirer
					$tr_status,				//trans_status
					$post['fullname'],		//fullname
					$post['bill_address'],	//bill_address
					$post['bill_city'],		//bill_city
					$post['bill_state'],	//bill_state
					$post['bill_zip'],		//bill_zip
					$post['bill_email'],	//bill_email	C
					(isset($post['ccno'])?$post['ccno']:''),
					$post['bill_phone'],	//bill_phone
					$_SESSION['product'],
					(isset($_SESSION['http_referer'])?$_SESSION['http_referer']:(isset($_SERVER['HTTP_REFERER'])?$_SERVER['HTTP_REFERER']:''))
				);
	
			}
			
			
			
			if(isset($_SESSION['product'])&&trim($_SESSION['product'])){
				$_SESSION['product'] = str_ireplace(array(':','?','/','%','|'),'',$_SESSION['product']);
				$_SESSION['product'] = substr($_SESSION['product'], 0, 45);
				$_SESSION['product'] = preg_replace("/[^A-Za-z0-9 ]/", '', strip_tags($_SESSION['product']));
				$post['product']=$_SESSION['product'];
			}
			
			
			if(isset($_SESSION['re_post']['acquirer_history'])){
				$_SESSION['re_post']['acquirer_history']= $_SESSION['re_post']['acquirer_history'].",".$acquirer;
			}else{
				$_SESSION['re_post']['acquirer_history']= $acquirer;
			}
			
			
			
			
			
			if(isset($_SESSION['bank_processing_amount'])&&$_SESSION['bank_processing_amount']>0&&$currConverter==true){
				$total_payment=$_SESSION['bank_processing_amount'];
				$_SESSION['curr']=$bpc;
			}
			
			//echo "<br/><br/><br/>"."p3= step==>".$post['step']."<br/><br/><br/>";		
				
			//RCODE
			$_SESSION['info_data']['amt']=$total_payment;
			$_SESSION['info_data']['transID']=$trcode;
		
			$_SESSION['transTMR']=$_SESSION['transID']."_".$_SESSION['terNO']."_".$_SESSION['clientid']."_".$_SESSION['reference'];
			
			//$_SESSION['transID']=$transID;
			//$transID=$_SESSION['trans_pid_mid'];
			
					
			// to check transaction is scrubbed or not
			$scrubbed_msg="";	
			$scrubbed="";	
			
			if(isset($data['SCRUBBED_TRANS_ENABLE'])&&$data['SCRUBBED_TRANS_ENABLE']=='Y'){
				$scrubbed=scrubbed_trans($_SESSION['clientid'],$acquirer,$trcode,$post['bill_email']);
			}
			
			/*
			if(isset($_SESSION['a'][$acquirer]['scrubbed_json'])&&$_SESSION['a'][$acquirer]['scrubbed_json']&&!$scrubbed['scrubbed_status']){
				$scrubbed_json_multi=json_decode($_SESSION['a'][$acquirer]['scrubbed_json'],1);
				if($scrubbed_json_multi&&is_array($scrubbed_json_multi)) $scrubbed=scrubbed_status($trcode);
			}
			*/
			
			
			
			//if transaction is scrubbed then scrubbedstatus is true and print scrubbed reason
			if(@$scrubbed){
				if($scrubbed['scrubbed_status']==true){
					$scrubbedstatus=true;
					$scrubbed_msg=$scrubbed['scrubbed_msg'];
					if(isset($post['actionajax'])&&trim($post['actionajax'])&&!empty(trim($post['actionajax']))){
						echo $scrubbed_msg; exit;
					}
				}
			}
			
			
			//store email into $post array if exists
			if($enc_email){
				$post['bill_email']=$enc_email;
			}
			
			
			
			/*
			echo "<hr/>";print_r($scrubbed);
			$jsonarray['clientid']=$_SESSION['clientid'];
			$jsonarray['acquirer']=$acquirer;
			$jsonarray['trcode']=$trcode;
			$jsonarray['email']=$post['bill_email'];
			//$jsonarray['scrubbed']=$scrubbed;
			echo "<hr/>";print_r($jsonarray);exit;
			*/
			//cmn
				//$_SESSION['tr_newid']='434474'; 
				//echo "<hr/>tr_newid=>".$_SESSION['tr_newid'];echo "<hr/>_GET=>";print_r($_GET);echo "<hr/>post";print_r($post);exit;
				
				
				
			//if data inserted then include api_trans_process file
			if(!empty($_SESSION['tr_newid'])){
				include("api_trans_process{$file_v}".$data['iex']);
				if((isset($post['integration-type']))&&($post['integration-type']=="s2s")){
					include("success_curl".$data['iex']);
				}
			}else{
				if($thisTrInst){
					$data['Error']=351;
					$data['Message']="Network interrupted. Please check your internet connection and try again.";
					error_print($data['Error'],$data['Message']);	//print error
				}
			}
		

			//$_POST['ccno']=ccnois($_POST['ccno']);
			
			//if(!isset($data['re_post'])){
				$post['step']=3;
			//}
		}
	}
	//$_SESSION['ufound']=true;
}



//at step 3 unset session values
if($post['step']==3){
	unset($post['step']);
	$unset_session_2=["buyer","ccholder","email_cc","clientid_email","owner_email","buyer_email","email_cc_email","ufound","payment_mode","fullname","ccno","ccvv","expdate","email","pid","product","action","quantity","total","bill_amt","tax","shipping","mode","acquirer"];
	unset_sessionf($unset_session_2);
}elseif($post['step']==4){
 
	if($_SESSION['action']!="moto_status"){
		foreach($_SESSION as $key=>$value)unset($_SESSION[$key]);
		session_destroy();
	}
	
}

###############################################################################


if((isset($post['integration-type']))&&($post['integration-type']=="s2s")){
	if(isset($data['Error'])&&$data['Error']){
		$jsonarray['error']=$data['Error'];
		header("Content-Type: application/json", true);	
		echo json_encode($jsonarray,true);
	}
	exit;
}else{
	if(!isset($moto_vt)||$moto_vt==false){
		$data['HideAllMenu']=true;
	}
	
	display('user');	//include user template
}


###############################################################################
?>
