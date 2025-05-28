<?
//1121 lipad from 112

//$data['cqp']=9;

// {"ServiceCode":"COGCHE197","ClientCode":"COGMER-5WXOBTC","ConsumerKey":"9nUfLzIwMCmF0kk4zZCOi8MGSWTFC1","ConsumerSecret":"GZJECZKhfAJ0rWtPpKXndvPXQYg2DW","AccessKey":"lcdr1TG6Njqs8q1rBlEqrIWCrjWHSP","IVKey":"5re4WY3wnpnS4kxtn4MimJJBjO4ZYp","v":"2"}

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


//echo @$apc_get['v']; exit;

$encryptionUrl='http://15.207.116.247:8084/webhook55/pay_load_112_v2';

if($data['localhosts']==true) 
{
	$webhookhandler_url='https://aws-cc-uat.web1.one/responseDataList/?urlaction=notify_mastercard';
	$status_default_url='https://aws-cc-uat.web1.one/responseDataList/?urlaction=notify_mastercard';
    $encryptionUrl='http://localhost:8084/webhook55/pay_load_112_v2';

	//if($_SESSION['b_'.$acquirer]['acquirer_prod_mode']==2) $post['ccno']='254712345001';

}

if(isset($data['cqp'])&&$data['cqp']>0)
{
    echo "<br/><hr/><br/><h3>APC_GET :: KEY - {$transID}</h3><br/>"; 
    echo '<pre>';
        print_r($apc_get);
    echo '</pre>';
}

//$total_payment_100=$total_payment*100;

// Initialize an empty array
$postData = array();

// Populate the array with parameters from the URL
$postData['external_reference'] = @$transID;
$postData['origin_channel_code'] = "API";
$postData['originator_msisdn'] = @$post['bill_phone'];
$postData['payer_msisdn'] = @$post['bill_phone'];
$postData['payer_email'] = @$post['bill_email'];
$postData['payer_name'] = @$post['fullname'];
$postData['client_code'] = @$apc_get['ClientCode'];//client code will fixed 
$postData['service_code'] = @$apc_get['ServiceCode'];//COGCHE189;//you can change service code accordingly
$postData['account_number'] = 'N/A'; // ACCOUNT234
$postData['invoice_number'] =  @$transID;
$postData['currency_code'] = $orderCurrency; // KES
$postData['country_code'] = 'KEN';//@$post['country_three'];// KEN by deafault USA
$postData['amount'] = @$total_payment; // 100

// Device information
$postData['ip_address'] = @$_SESSION['bill_ip'];
$postData['browser'] =  "Mozilla";

// Card information
$postData['name_on_card'] = @$post['fullname'];
$postData['number'] = @$post['ccno'];
$postData['security_code'] = @$post['ccvv'];
$postData['expiry_month'] = @$post['month'];
$postData['expiry_year'] = @$post['year4'];



// Example of how to use the $postData array


if(isset($data['cqp'])&&$data['cqp']>0)
{
    echo "<br/><hr/><br/><h3>POST REQUEST V2</h3><br/>"; 
    echo "<br/><hr/><br/>postData:<br/>";
    echo '<pre>';
        print_r($postData);
    echo '</pre>';
}


    //unset Card information
    $postData_without_cards=$postData;

    if(isset($postData_without_cards['name_on_card'])) unset($postData_without_cards['name_on_card']);
    if(isset($postData_without_cards['number'])) unset($postData_without_cards['number']);
    if(isset($postData_without_cards['security_code'])) unset($postData_without_cards['security_code']);
    if(isset($postData_without_cards['expiry_month'])) unset($postData_without_cards['expiry_month']);
    if(isset($postData_without_cards['expiry_year'])) unset($postData_without_cards['expiry_year']);
    if(isset($postData_without_cards['redirect_url'])) unset($postData_without_cards['redirect_url']);
    


    $tr_upd_order['requestPost']=$postData_without_cards;
 
     

	//we use for encryption IV Key and consumer secrete key provided by lipad
	$ivKey =  @$apc_get['IVKey'];//iv key
	$secretKey= @$apc_get['ConsumerSecret'];//cunsumer secerete for encryption
	$consumer_key = @$apc_get['ClientCode'];


	
	### //Step : 1 - Encryption from java #############################################

		// encryption logic used to encrypt the card data JSON object

		$encrytedPayload='';
		
		if(trim($encryptionUrl)) 
		{
			// https://www.jdoodle.com/online-java-compiler

			$encryptionRequest=@$postData;

			$encryptionRequest['ivkey']=@$apc_get['IVKey'];//IV Key
			$encryptionRequest['consumerSecret']=@$apc_get['ConsumerSecret']; //consumerSecret via Secret Key
			//$encryptionRequest['accessKey']=@$apc_get['AccessKey'];

            $encryptionRequest['success_redirect_url']= @$status_default_url;
            $encryptionRequest['failed_redirect_url']= @$status_default_url;
            //$encryptionRequest['redirect_url'] = @$status_default_url;


            $tr_upd_order['encryptionUrl_step_1']=$encryptionUrl;
			
			$encryptionUrl=$encryptionUrl.'?'.http_build_query($encryptionRequest);
			//$cardData=use_curl($encryptionUrl);

            
			if(isset($data['cqp'])&&$data['cqp']>0)
			{
				echo "<br/><hr/><br/><h3>ENCRYPTION REQUEST</h3><br/>"; 
				echo "<br/><hr/><br/>encryptionPayLoadWithKey:<br/>"; print_r(http_build_query(@$encryptionRequest));
				echo "<br/><hr/><br/>encryptionUrl:<br/>"; print_r(@$encryptionUrl);
			}
           // exit;

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
		

		if(($data['localhosts']==true) || (isset($data['cqp'])&&$data['cqp']>2)) $tr_upd_order['encryptionUrl']=$encryptionUrl;

        
		$encrytedPayload=trim($encrytedPayload);
		$encrytedPayload=str_replace('"','',$encrytedPayload);
		$tr_upd_order['encrytedPayload']=$encrytedPayload;

        if(strlen($encrytedPayload)<1000) $tr_upd_order['ERROR_IN_ENCRYPTIONURL']=$encryptionUrl;

        if(isset($data['cqp'])&&$data['cqp']>0)
        {
            echo "<br/><hr/><br/><h3>STEP 1 :: ENCRYPTION REQUEST</h3><br/>"; 
            echo "<br/><br/>encryptionUrl:<br/>".@$encryptionUrl; 
            echo "<br/><br/>encrytedPayload:<br/>".@$encrytedPayload; 

        }


    ### //Step : 2 - auth #############################################

        
        //https://api.lipad.io/v1/auth
        $auth_url_step_2=$bank_url.'/auth';

        $curl = curl_init();
        curl_setopt_array($curl, array(
            CURLOPT_URL => $auth_url_step_2,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => '',
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 0,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => 'POST',
                CURLOPT_HEADER => 0,
                CURLOPT_SSL_VERIFYPEER => 0,
                CURLOPT_SSL_VERIFYHOST => 0,
            CURLOPT_POSTFIELDS =>'{
            "consumer_key":"'.@$apc_get['ConsumerKey'].'",
            "consumer_secret":"'.@$apc_get['ConsumerSecret'].'"
        }',
            CURLOPT_HTTPHEADER => array(
                'Content-Type: application/json'
            ),
        ));

        $response = curl_exec($curl);

        curl_close($curl);

        $res_auth_array = json_decode($response,1);

        $access_token=@$res_auth_array['access_token'];

        $tr_upd_order['url_step_2']=$auth_url_step_2;

        if(isset($access_token)&&strlen($access_token)<100) $tr_upd_order['ERROR_IN_AUTH_RESPONSE']=@$response;

        if(isset($data['cqp'])&&$data['cqp']>0)
        {
            echo "<br/><hr/><br/><h3>STEP 2 :: AUTH REQUEST</h3><br/>"; 
            echo "<br/><br/>auth_url_step_2:<br/>".@$auth_url_step_2; 
            echo "<br/><br/>access_token:<br/>".@$access_token; 

            echo "<br/><br/>response:<br/>"; 
            echo '<pre>';
                print_r($response);
            echo '</pre>';

        }

        /*

        {
            "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnRfaWQiOiIyMiIsImRlc2lnbmF0aW9uIjoiQXBpIFVzZXIiLCJhdXRob3JpemVkIjp0cnVlLCJpYXQiOjE3MzY5NDIzNDgsImV4cCI6MTczNjk0ODM0OH0.J3XeYtsC7ARaVMRkgkGbOu5VrAqYbZ9Or7u9DfsGygU",
            "expiresIn": 6000
        }

        */


	### //Step : 3 - Charge Request after payload of java #############################################

        
        //https://api.lipad.io/v1/checkout/api/card
        $charge_request_url_step_3=$bank_url.'/checkout/api/card';

        $curl = curl_init();
        curl_setopt_array($curl, array(
            CURLOPT_URL => @$charge_request_url_step_3,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => '',
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 0,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => 'POST',
                CURLOPT_HEADER => 0,
                CURLOPT_SSL_VERIFYPEER => 0,
                CURLOPT_SSL_VERIFYHOST => 0,
            CURLOPT_POSTFIELDS =>'{
            "access_key": "'.@$apc_get['AccessKey'].'", 
            "data": "'.$encrytedPayload.'"
        }',
            CURLOPT_HTTPHEADER => array(
                'x-access-token: '.@$access_token,
                'Content-Type: application/json'
            ),
        ));
        
        $response = curl_exec($curl);
        
        curl_close($curl);


        // Decode the JSON response to an array in final step for 3DS 
        $response_array = json_decode($response,1);

        /*
        if(isset($response_array['external_reference'])&&trim($response_array['external_reference']))
        $tr_upd_order['rrn']=@$response_array['external_reference'];
        */

        if(isset($response_array['charge_request_id'])&&trim($response_array['charge_request_id']))
        $tr_upd_order['acquirer_ref']=@$response_array['charge_request_id'];

        if(isset($response_array['auth_url'])&&trim($response_array['auth_url']))
        {
            @$bank_redirect_url=@$response_array['auth_url'];
            //$tr_upd_order['bank_redirect_url']=rawurldecode(@$bank_redirect_url);
            unset($response_array['auth_url']);
        }

        //$tr_upd_order['requestPost_1']=json_decode($requestPost_1,1);
        $tr_upd_order['url_step_3']=$charge_request_url_step_3;
        $tr_upd_order['response_3']=(isset($response_array)&&is_array($response_array)?htmlTagsInArray($response_array):stf($response));

        //$tr_upd_order=(isset($tr_upd_order)&&is_array($tr_upd_order)?htmlTagsInArray($tr_upd_order):stf($tr_upd_order));

        //trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);



        if(isset($data['cqp'])&&$data['cqp']>0)
        {
            echo "<br/><hr/><br/><h3>STEP 3 :: 3DS RESPONSE</h3><br/>"; 
            echo "<br/><br/>url_step_3:<br/>".@$charge_request_url_step_3; 
            echo "<br/><br/>bank_redirect_url:<br/>".@$bank_redirect_url; 
            echo "<br/><br/>acquirer_ref:<br/>".@$tr_upd_order['acquirer_ref']; 

            echo "<br/><br/>response:<br/>"; 
            echo '<pre>';
                print_r($response);
            echo '</pre>';

        }      

        /*

        {
            "status_code": 176,
            "status_description": "Request to charge customer was successfully placed.",
            "total_amount": "12.75",
            "service_amount": "12.75",
            "transaction_charge": 0,
                "charge_request_id": "22406",
            "external_reference": "1121106195306",
            "auth_available": true,
            "auth_url": "https://pay.cross-switch-pay.com/pwthree/launch?payload=%7B%22timestamp%22%3A1736944384%2C%22merchantAccount%22%3A%22SMARTHOST%22%2C%22mode%22%3A%22PROXY%22%2C%22poId%22%3A29077210%2C%22chargeId%22%3A%22af714349f1624fb8a10d50c84714dd67%22%2C%22customerLocale%22%3A%22en_US%22%7D&signature=a43ce1e69b38c700cf932550726383cd33a8e1c8bc2b28427f85eb5f54e072b9"
        }

        */


	### //Step : 4 - 3DS Bank OTP Page for redirect #############################################

	

	if(isset($data['cqp'])&&$data['cqp']>0)
	{
		echo "<br/><hr/><br/><h3>BANK REDIRECT URL</h3><br/>"; 
		print_r(@$bank_redirect_url);
	}
	
	//$tr_upd_order['bank_redirect_url']=$bank_redirect_url;
	//trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);

	if(isset($bank_redirect_url)&&!empty($bank_redirect_url)) 
	{
		$_SESSION['3ds2_auth']['paytitle']=@$dba;
		$_SESSION['3ds2_auth']['payamt']=@$total_payment;
		$_SESSION['3ds2_auth']['paycurrency']=@$orderCurrency;
		$_SESSION['3ds2_auth']['urltype']='urlencode';
		if(isset($post['bill_amt'])&&trim($post['bill_amt'])) $_SESSION['3ds2_auth']['bill_amt']=@$post['bill_amt'];
		if(isset($post['bill_currency'])&&trim($post['bill_currency'])) $_SESSION['3ds2_auth']['bill_currency']=@$post['bill_currency'];
		if(isset($post['product_name'])&&trim($post['product_name'])) $_SESSION['3ds2_auth']['product_name']=@$post['product_name'];
		if(isset($post['integration-type'])&&trim($post['integration-type'])) $_SESSION['3ds2_auth']['integration-type']=@$post['integration-type'];
		
        /*
        // Base64 3DS Redirect for Bank OTP page with status check via secure/secure_process.do after run the authurl 

		$_SESSION['3ds2_auth']['payaddress']=$auth_3ds2_secure=$payment_url=base64_encode($bank_redirect_url); // Retrieve the redirect URL base64 decode
		$auth_3ds2_action='redirect_base64'; //  redirect  post_redirect  
		
		$auth_3ds2=$secure_process_3d; 
        $auth_data_not_save=1;

        */


        $auth_data_not_save=1; // auth_data not save in json 
        $auth_3ds2_action='redirect_base64'; //  redirect_base64 iframe_base64 redirect  post_redirect 
        $_SESSION['3ds2_auth']['payaddress']=$auth_3ds2_secure=base64_encode(@$bank_redirect_url);
                    

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
        echo "<br/><hr/><br/><h3>PAYLOAD & ALL RESPONSE</h3><br/>"; 
        echo "<br/><br/>tr_upd_order json:<br/>".json_encode(@$tr_upd_order);
        echo "<br/><br/>tr_upd_order:<br/>"; print_r(@$tr_upd_order);
        
        echo "<br/><hr/><br/>";

        trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);
        exit;
    }
	
	
	//trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);

    $tr_upd_order=(isset($tr_upd_order)&&is_array($tr_upd_order)?htmlTagsInArray($tr_upd_order):stf($tr_upd_order));
	$tr_upd_order_111=$tr_upd_order;
	
	
 ?>