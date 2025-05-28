<?
//112 lipad from 108
//$testcardno=false;
if((($post['midcard']==112 || ($post['midcard']>1120&&$post['midcard']<1130)) && $_SESSION['mode'.$post['midcard']]==1 && $testcardno==false && $scrubbedstatus==false && $_SESSION['b_'.$post['midcard']]['bg_active']==1))
 {

//lipad curl
//echo '2111111';
 
	include('function_112.do');	
	
    $midcard=$post['midcard']; //for Acquirer NO

	$default_mid = 112;

	$tr_upd_order=array(); //function for update the transaction table
	###############################################################

	$bank_url = $_SESSION['b_'.$midcard]['bank_payment_url'];
	if($_SESSION['b_'.$midcard]['account_mode']==2){$bank_url=$_SESSION['b_'.$midcard]['bank_payment_test_url'];}

	if($_SESSION['curr']){$orderCurrency=$_SESSION['curr'];}
	else{$orderCurrency= trim($_SESSION['currency'.$midcard]);}

	$_SESSION['currency112']		= $orderCurrency; // dynamic value for currency
	$_SESSION['total_payment']	= $total_payment; // dynamic value for payment

###############################################################
 //form bank
	$bank_json=jsondecode($_SESSION['b_'.$midcard]['bank_json'],true);
	$siteid_get=array();
	if($_SESSION['b_'.$midcard]['account_mode']==2){ // this is for test mode trnasaction
		$siteid_set			= $bank_json['test'];
		$bank_url			= $_SESSION['b_'.$midcard]['bank_payment_test_url'];
		$siteid_get['mode']	= 'test';
	}else{// this is for live mode transaction
		$siteid_set			= $bank_json['live'];
		$bank_url			= $_SESSION['b_'.$midcard]['bank_payment_url'];
		$siteid_get['mode']	= 'live';
	}
	$siteid_get['AccessKey']	= $siteid_set['AccessKey'];//access Key provided by lipad 
	$siteid_get['ServiceCode']	= $siteid_set['ServiceCode'];//service code provided by lipad
	$siteid_get['ConsumerSecret']	= $siteid_set['ConsumerSecret'];//consumerSecerete provided by lipad
    $siteid_get['ClientCode']	= $siteid_set['ClientCode'];//clientCode provided by lipad
    $siteid_get['IVKey']	= $siteid_set['IVKey'];//iv key provided by lipad
    $siteid_get['ConsumerKey']	= $siteid_set['ConsumerKey'];//consumerKey provided by lipad
	
	//form acquirer
	if($_SESSION['b_'.$midcard]['account_mode']==1){
		$siteid_acquirer = jsondecode($_SESSION['siteid'.$midcard]);

		if(isset($siteid_acquirer['Access_Key'])&&$siteid_acquirer['Access_Key']){
			$siteid_get['Access_Key']=$siteid_acquirer['Access_Key'];
		}
		if(isset($siteid_acquirer['Service_Code'])&&$siteid_acquirer['Service_Code']){
			$siteid_get['Service_Code']=$siteid_acquirer['Service_Code'];
		}
		if(isset($siteid_acquirer['Consumer_Secret'])&&$siteid_acquirer['Consumer_Secret']){
			$siteid_get['Consumer_Secret']=$siteid_acquirer['Consumer_Secret'];
		}
		if(isset($siteid_acquirer['Client_Code'])&&$siteid_acquirer['Client_Code']){
			$siteid_get['Client_Code']=$siteid_acquirer['Client_Code'];
		}
		if(isset($siteid_acquirer['IVKey'])&&$siteid_acquirer['IVKey']){
			$siteid_get['IVKey']=$siteid_acquirer['IVKey'];
		}
		if(isset($siteid_acquirer['consumerKey'])&&$siteid_acquirer['consumerKey']){
			$siteid_get['consumerKey']=$siteid_acquirer['consumerKey'];
		}
		
	}
	if($_SESSION['b_'.$midcard]['bank_process_url']){
		$bank_process_url=$_SESSION['b_'.$midcard]['bank_process_url'];
	}else{
		$bank_process_url=$data['Host'];
	}

	$siteid_get['bank_process_url']=$bank_process_url;
    $order_id = $_SESSION['transaction_id'];
	$check_status = "bankstatus{$data['ex']}?orderset=".$orderset."&action=check_status";
	//save value in transaction table of midcard
	
	//exit;	
	$tr_upd_order=$siteid_get;
	$tr_upd_order['s30_count']=4;
	$tr_upd_order['default_mid']='112';
	$tr_upd_order['host_'.$midcard]=$data['Host'];
	$tr_upd_order['status_'.$midcard]=$check_status;
	$tr_upd_order['bank_url'.$midcard]=$bank_url;
	$tr_upd_order['orderCurrency_mid']=$orderCurrency;
	#################################################
	
	
	//first step for token
	//if($midcard==112){
	$postData['msisdn']= $post['bill_phone'];
    $postData['account_number']="N/A";
    $postData['country_code']="KEN";// by deafault USA
    $postData['currency_code']= $orderCurrency;
    $postData['client_code']= $siteid_get['ClientCode'];//client code will fixed 
	$postData['due_date']=date('Y-m-d');
	$postData['access_key']= $siteid_get['AccessKey'];//access key provided by lipad
	$postData['customer_email']=$post['email'];
    $postData['customer_first_name']= $post['ccholder'];
    $postData['customer_last_name']= $post['ccholder_lname'];
	$postData['merchant_transaction_id']= $order_id;
    $postData['callback_url']= 	$bank_process_url."/payin/pay112/status_112{$data['ex']}?orderset=".$_SESSION['transaction_id']."&actionurl=notify";
	//$bank_process_url."/payin/pay112/status_112{$data['ex']}?orderset=".$_SESSION['transaction_id']."&actionurl=notify";
	
    $postData['request_amount']= $total_payment;
    $postData['request_description']=$post['product'];
    $postData['success_redirect_url']= $bank_process_url."/payin/pay112/status_112{$data['ex']}?orderset=".$_SESSION['transaction_id']."&status=success";
    $postData['failed_redirect_url']= $bank_process_url."/payin/pay112/status_112{$data['ex']}?orderset=".$_SESSION['transaction_id']."&status=fail";
    $postData['language_code']= "en";
    $postData['service_code']= $siteid_get['ServiceCode'];//COGCHE125;//you can change service code accordingly
	//print_r($postData);
	//exit;
	//we use for encryption IV Key and consumer secrete key provided by lipad
	$ivKey =  $siteid_get['IVKey'];//iv key
	$secretKey= $siteid_get['ConsumerSecret'];//cunsumer secerete for encryption
	$consumer_key = $siteid_get['consumerKey'];
	#################################################
	
	
    //The encryption method to be used
    $encrypt_method = "AES-256-CBC";
    // Hash the secret key
    $passphrase = substr(hash('sha256', $secretKey), 0, 32);
    // Hash the iv - encrypt method AES-256-CBC expects 16 bytes
	
    $iv = substr(hash('sha256', $ivKey), 0, 16);

      $encrypted = openssl_encrypt(
        json_encode($postData,true),
        $encrypt_method,
        $passphrase,
        0,
        $iv
    );
   
$accessKey=$siteid_get['AccessKey'];
  
   
   //echo $url= "https://checkout.lipad.io/?access_key=$siteid_get['AccessKey']&payload=$encrypted";
   
    $url= "https://checkout.lipad.io/?access_key=$accessKey&payload=$encrypted";
	
     
	$tr_upd_order['request']=$postData;
	
	$tr_upd_order['merchant_transaction_id']=$order_id;
		//save response for curl request
	$curl_values_arr['browserOsInfo']=$browserOs;	//save browser information for curl request

	//$_SESSION['hkip_action']="hkip";		//set action HKIP for update trasaction via callback
	$_SESSION['curl_values']=@$curl_values_arr;
	//exit;	//set curl values into into $_SESSION
	
	//$curl_values_arr['pay_url']=$link;
	
	/*
	
	$_SESSION['redirect_url']=$url;
	$_SESSION['pay_url']=$url;
	$tr_upd_order['pay_mode']='3D';
	$tr_upd_order['pay_url']=$url;	
	
	*/
	
	
	transactions_updates($_SESSION['tr_newid'],$tr_upd_order);
	//$_SESSION['redirect_url']=$res['result']['form_link'];
	//print_r($_SESSION);
	//$_SESSION['redirect_url']=$link;
	//exit;
	
	/*
	if($midcard==108){
	 $process_url=$data['Host'].'/secure/process'.$data['ex'];
	}
	*/
		
if($midcard==112){
	//echo $bank_url;
	 
	  $consumerSecret= $siteid_get['ConsumerSecret'];
	  $ConsumerKey  =$siteid_get['ConsumerKey'];
			
	 //echo $consumer_key;
	 
$request='{"consumer_key":"'.$ConsumerKey.'","consumer_secret": "'.$consumerSecret.'"}';

$tr_upd_order['request_key']=$request;	

$url="https://dev.lipad.io/v1/auth";
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
  CURLOPT_POSTFIELDS =>$request,
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/json'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
//echo $response;
$res = json_decode($response,1);

$tr_upd_order['url_1']=$url;	
$tr_upd_order['response_1']=($res?$res:$response);	


$token=$res['access_token'];//token here
$data_pay_load = array(
    "external_reference" => $order_id,
    "origin_channel_code" => "API",
    "client_code" => $siteid_get['ClientCode'],
    "originator_msisdn" => $post['bill_phone'],
    "payer_msisdn" => $post['bill_phone'],
    "service_code" => $siteid_get['ServiceCode'],
    "account_number" => $post['bill_phone'],
    "invoice_number" => "gdhss-shgsj-sh",
    "currency_code" => "KES",
    "country_code" => "KEN",
    "amount" => $total_payment,
	"success_redirect_url"=>$bank_process_url."/payin/pay112/status_112{$data['ex']}?orderset=".$_SESSION['transaction_id']."&status=success",
	"failed_redirect_url"=>$bank_process_url."/payin/pay112/status_112{$data['ex']}?orderset=".$_SESSION['transaction_id']."&status=fail",
    "add_transaction_charge" => false,
    "transaction_charge" => 0,
    "payment_method_code" => "CARD",
    "extra_data" => array(
        "store_number" => 20,
        "location" => "Nairobi"

    ),
    "payer_name" => $post['ccholder'],
    "payer_email" => $post['email'],
    "description" => "Flight booking payment",
    "notify_client" => 1,
    "notify_originator" => 1,
    "device" => array(
        "browser" => "MOZILLA",
        "ipAddress" => $_SESSION['client_ip'],
        "browserDetails" => array(
            "3DSecureChallengeWindowSize" => "FULL_SCREEN",
            "acceptHeaders" => "application/json",
            "colorDepth" => 24,
            "javaEnabled" => true,
            "language" => "en-US",
            "screenHeight" => 400,
            "screenWidth" => 250,
            "timeZone" => 273,
			
        ),
    ),

    "card" => $encryptedData
);
//echo $_SERVER['HTTP_USER_AGENT'];
   $requestPayload = json_encode($data_pay_load);


	
// https://dev.charge.lipad.io/v1/cards/charge

$curl = curl_init();

curl_setopt_array($curl, array(
    CURLOPT_URL => $bank_url,
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_ENCODING => '',
    CURLOPT_MAXREDIRS => 10,
    CURLOPT_TIMEOUT => 30,
    CURLOPT_FOLLOWLOCATION => true,
    CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
    CURLOPT_CUSTOMREQUEST => 'POST',
    CURLOPT_POSTFIELDS => $requestPayload,
    CURLOPT_HTTPHEADER => array(
        "Content-Type: application/json",
        "x-access-token: $token"
        //"x-access-token: test"
    ),
));

$response_2 = curl_exec($curl);

curl_close($curl);
//echo $response_2;
$res_2 = json_decode($response_2, 1);
//print_r($res_2);exit;
//$process_url=$data['Host'].'/secure/process'.$data['ex'];
$html_data_set=$res_2['html'];

$tr_upd_order['url_2']=$bank_url;	
if(isset($res_2['html'])) unset($res_2['html']);
$tr_upd_order['response_2']=($res_2?$res_2:$response_2);	

		$html_data = $html_data_set;
		if(isset($_SESSION['3ds2_auth'])) unset($_SESSION['3ds2_auth']);
		$_SESSION['3ds2_auth']=$auth_3ds2=($html_data);
		
		$tr_upd_order['auth_data']	=htmlentitiesf($html_data);
		
		if(isset($auth_3ds2)&&$auth_3ds2)
			{
				$process_url = $_SESSION['pay_url']= $data['Host'].'/secure/3ds2_auth'.$data['ex'];
				
				$tr_upd_order['pay_mode']='3D';
				$tr_upd_order['pay_url']=$_SESSION['pay_url'];
				$tr_upd_order['pay_root']='secure/3ds2_auth';
				$_SESSION['bank_pay_url']=$_SESSION['pay_url'];
				
			}
			
			
			
	}
	
	
	$tr_upd_order['token']=$token;	
	$tr_upd_order['encryptedData']=$encryptedData;	
	$tr_upd_order['data_pay_load']=$data_pay_load;	
	
	
	transactions_updates($_SESSION['tr_newid'],$tr_upd_order);
	
	
	
	
	//exit;
	
	
	
	if($post['cardsend']=="curl"){
		 
	}else{
		
		if(!empty($process_url))
		{	
			header("Location:".trim($process_url));
			exit();
		}
		else
		{
			$data['Error']=7004;
			$data['Message']="Could not established secure connection";
			error_print($data['Error'],$data['Message']);
		}
	}
	
 }
 
 
 ?>
 
