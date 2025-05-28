<?
//112 lipad from 108


// {"ServiceCode":"COGCHE189","ClientCode":"COGMER-5WXOBTC","AccessKey":"lcdr1TG6Njqs8q1rBlEqrIWCrjWHSP","IVKey":"5re4WY3wnpnS4kxtn4MimJJBjO4ZYp","SecretKey":"GZJECZKhfAJ0rWtPpKXndvPXQYg2DW"}


//ISD code get from country + last 10 digit phone number 

if($post['country_two']=='HU') $post['bill_phone']=substr($post['bill_phone'],-9);
//elseif($post['country_two']=='SG') $post['bill_phone']=substr($post['bill_phone'],-8);

$post['isd_code']=get_country_code($post['country_two'],4);

$isd_code_len=strlen($post['isd_code']);
$pLenth=10-(($isd_code_len+10)-12);
$post['bill_phone']=str_replace("+","",$post['bill_phone']);
if(substr($post['bill_phone'],0,$isd_code_len)==$post['isd_code'])
$post['bill_phone']=substr($post['bill_phone'],$isd_code_len);
$post['bill_phone']=substr($post['bill_phone'],-$pLenth);
$bill_phone='+'.@$post['isd_code'].@$post['bill_phone'];



$encryptionUrl='http://15.207.116.247:8084/webhook55/pay_load_112';

if($data['localhosts']==true) 
{
	$webhookhandler_url='https://aws-cc-uat.web1.one/responseDataList/?urlaction=notify_mastercard';
    $encryptionUrl='http://localhost:8084/webhook55/pay_load_112';

	//if($_SESSION['b_'.$acquirer]['acquirer_prod_mode']==2) $post['ccno']='254712345001';

}
 

	//include('function_112.do');	
	
	
	//$tr_upd_order=array(); //function for update the transaction table
	
	//first step for token

	/*

	$pp="{\"msisdn\":\"919831142800\",\"account_number\":\"NA\",\"country_code\":\"KEN\",\"currency_code\":\"USD\",\"client_code\":\"COGMER-5WXOBTC\",\"customer_email\":\"demo@lipad.io\",\"customer_first_name\":\"John\",\"customer_last_name\":\"Doe\",\"due_date\":\"2024-08-3113:00:00\",\"merchant_transaction_id\":\"11224093111\",\"preferred_payment_option_code\":\"MPESA_KEN\",\"callback_url\":\"https://gtw.online-epayment.com/payin/pay112/webhookhandler_112.do?status=notification\",\"request_amount\":\"10\",\"request_description\":\"Dummymerchanttransaction\",\"success_redirect_url\":\"https://gtw.online-epayment.com/payin/pay112/webhookhandler_112.do?status=success_redirect_url\",\"fail_redirect_url\":\"https://gtw.online-epayment.com/payin/pay112/webhookhandler_112.do?status=fail_redirect_url\",\"invoice_number\":\"1\",\"language_code\":\"en\",\"service_code\":\"COGCHE189\"}";
		
		*/
	
	$postData['msisdn']= $post['bill_phone'];
    $postData['account_number']='N/A';
    $postData['country_code']='KEN';//@$post['country_three'];// KEN by deafault USA
    $postData['currency_code']= $orderCurrency;
    $postData['client_code']= @$apc_get['ClientCode'];//client code will fixed 
	//$postData['access_key']= @$apc_get['AccessKey'];//access key provided by lipad
	$postData['customer_email']=$post['bill_email'];
    $postData['customer_first_name']= $post['ccholder'];
    $postData['customer_last_name']= $post['ccholder_lname'];
	$postData['due_date']=date('Y-m-d H:i:s');
	$postData['merchant_transaction_id']= @$transID;
	$postData['preferred_payment_option_code']= 'MPESA_KEN';
    $postData['callback_url']= 	$webhookhandler;
    $postData['request_amount']= $total_payment;
    $postData['request_description']=$post['product'];
    $postData['success_redirect_url']= @$success_url_2;
    $postData['fail_redirect_url']= @$fail_url_2;
	$postData['invoice_number']= @$transID;
    $postData['language_code']= "en";
    $postData['service_code']= @$apc_get['ServiceCode'];//COGCHE189;//you can change service code accordingly
	
	if(isset($data['cqp'])&&$data['cqp']>0)
    {
        echo "<br/><hr/><br/><h3>POST REQUEST</h3><br/>"; 
        echo "<br/><hr/><br/>postData:<br/>"; print_r(@$postData);
    }

	//we use for encryption IV Key and consumer secrete key provided by lipad
	$ivKey =  @$apc_get['IVKey'];//iv key
	$secretKey= @$apc_get['SecretKey'];//cunsumer secerete for encryption
	$consumer_key = @$apc_get['ClientCode'];


	
	#################################################


		// encryption logic used to encrypt the card data JSON object

		$encrytedPayload='';
		

		if(trim($encryptionUrl)) 
		{
			// https://www.jdoodle.com/online-java-compiler

			$encryptionRequest=@$postData;

			$encryptionRequest['ivkey']=@$apc_get['IVKey'];//IV Key
			$encryptionRequest['consumerSecret']=@$apc_get['SecretKey']; //consumerSecret via Secret Key
			//$encryptionRequest['accessKey']=@$apc_get['AccessKey'];
			
			$encryptionUrl=$encryptionUrl.'?'.http_build_query($encryptionRequest);
			//$cardData=use_curl($encryptionUrl);

			$tr_upd_order['encryptionUrl']=$encryptionUrl;

			if(isset($data['cqp'])&&$data['cqp']>0)
			{
				echo "<br/><hr/><br/><h3>ENCRYPTION REQUEST</h3><br/>"; 
				echo "<br/><hr/><br/>encryptionPayLoadWithKey:<br/>"; print_r(http_build_query(@$encryptionRequest));
				echo "<br/><hr/><br/>encryptionUrl:<br/>"; print_r(@$encryptionUrl);
			}

			$curl = curl_init();

				curl_setopt_array($curl, array(
				CURLOPT_URL => $encryptionUrl, // API endpoint
				CURLOPT_RETURNTRANSFER => true, // Return the transfer as a string
				CURLOPT_ENCODING => '', // Accept all encodings
				CURLOPT_MAXREDIRS => 10, // Maximum number of redirects
				CURLOPT_TIMEOUT => 0, // No timeout
				CURLOPT_FOLLOWLOCATION => true, // Follow redirects
				CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1, // Use HTTP 1.1
				CURLOPT_CUSTOMREQUEST => 'GET', // HTTP POST method
					CURLOPT_HEADER => 0,
					CURLOPT_SSL_VERIFYPEER => 0,
					CURLOPT_SSL_VERIFYHOST => 0,
				));

				// Execute the cURL session
				$encrytedPayload = curl_exec($curl);
				curl_close($curl);

			
		}
		

		$tr_upd_order['encryptionUrl']=$encryptionUrl;

		$encrytedPayload=trim($encrytedPayload);
		$encrytedPayload=str_replace('"','',$encrytedPayload);
		$tr_upd_order['encrytedPayload']=$encrytedPayload;


	#################################################
	
   
	$accessKey=@$apc_get['AccessKey'];
    $bank_redirect_url= $bank_url."?access_key=$accessKey&payload=$encrytedPayload";

	if(isset($data['cqp'])&&$data['cqp']>0)
	{
		echo "<br/><hr/><br/><h3>BANK REDIRECT URL</h3><br/>"; 
		print_r(@$bank_redirect_url);
	}
	
     
	$tr_upd_order['bank_redirect_url']=$bank_redirect_url;
	$tr_upd_order['requestPost']=$postData;
	
		
	//trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);


	if(!empty($encrytedPayload)) 
	{
		$_SESSION['3ds2_auth']['paytitle']=@$dba;
		$_SESSION['3ds2_auth']['payamt']=@$total_payment;
		$_SESSION['3ds2_auth']['paycurrency']=@$orderCurrency;
		$_SESSION['3ds2_auth']['bill_amt']=@$post['bill_amt'];
		$_SESSION['3ds2_auth']['bill_currency']=@$post['bill_currency'];
		$_SESSION['3ds2_auth']['product_name']=@$post['product_name'];
		$_SESSION['3ds2_auth']['integration-type']=@$post['integration-type'];
		
		$auth_3ds2_secure=@$_SESSION['3ds2_auth']['payaddress']=$payment_url=curl_url_replace_f($bank_redirect_url); // Retrieve the redirect URL
		$auth_3ds2_action='redirect'; //  redirect  post_redirect  
		$auth_3ds2=$secure_process_3d; 

		//$tr_upd_order['auth_3ds2_secure']=@$auth_3ds2_secure;
		//$tr_upd_order['auth_3ds2_action']=@$auth_3ds2_action;
	}
	else{ // failed 
        $_SESSION['acquirer_action']=1;
        $_SESSION['acquirer_status_code']=-1;
        if(isset($response_array['message'])) $_SESSION['acquirer_response']=@$response_array['message'];
        //$process_url = $return_url; 
        $json_arr_set['realtime_response_url']=$trans_processing;
    }	
		
	/*
	//html repsone echo base64 encode via redirect bank OTP page 
	if(isset($res_2['html'])&&@$res_2['html'])
	{
		$htmlScript=@$res_2['html'];
		unset($res_2['html']);

		$tr_upd_order['htmlScript']=$auth_3ds2_secure=base64_encode(@$htmlScript);
					
		$auth_3ds2_base64=1;

	}
	
	$tr_upd_order['url_2']=$bank_url;	
	$tr_upd_order['response_2']=(isset($res_2)&&is_array($res_2)?htmlTagsInArray($res_2):stf($response_2));
		
	$tr_upd_order['token']=$token;	
	$tr_upd_order['encryptedData']=$encryptedData;	
	$tr_upd_order['data_pay_load']=$data_pay_load;	
	*/

	if(isset($data['cqp'])&&$data['cqp']>6)
    {
        echo "<br/><hr/><br/><h3>PAYLOAD & RESPONSE</h3><br/>"; 
        echo "<br/><hr/><br/>tr_upd_order:<br/>"; print_r(@$tr_upd_order);
        
        echo "<br/><hr/><br/>";

        exit;
    }
	
	
	//trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);

	$tr_upd_order_111=$tr_upd_order;
	
	
 ?>