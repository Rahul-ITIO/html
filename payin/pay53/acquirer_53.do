<?
// Dev Tech : 24-08-06  53 - Visa  Acquirer 

//$data['cqp']=9;

if($_SESSION['b_'.$acquirer]['acquirer_prod_mode']==2)
{
	$post['ccno']='5123450000000008';

}

$encryptionUrl='http://15.207.116.247:8084/webhook55/encode_53';

if($data['localhosts']==true) 
{
	$webhookhandler_url='https://aws-cc-uat.web1.one/responseDataList/?urlaction=notify_mastercard';
    //$encryptionUrl='http://localhost:8084/webhook55/encode_53';

}


//{"merchantCode":"TESTUBAPROPHNG","auth_ApiKey":"a62fe2fc139471ed8cb97fed3cf73424af66d5f1","header_ApiKey":"a98a7967053c85aa413ffe3bab0a0e3dd11541b775acfee8e958f3f44cd947263d13f2a4f69d6807d58e3a2317f1093b5ed1e5082bbbe01240cb3127","zek":"679942a3636b7b6b5ebf06a05f6a82cd6dc5e21ec88fe4a3c5d2dc676d412998"}

############################################################

$auth_ApiKey=@$apc_get['auth_ApiKey'];
$header_ApiKey=@$apc_get['header_ApiKey'];
$merchantCode=@$apc_get['merchantCode'];


//@$reference_29=prefix_trans_lenght(@$transID,29,1,'TRANSESSION','O');


### //Step 1: Authentication #############################################


//'https://pr-web-api-gateway-k8.dev.prophius-api.com/api/v1/gateway/auth?apiKey=a62fe2fc139471ed8cb97fed3cf73424af66d5f1', // API endpoint


$bank_url_1=str_replace(["-payment-"],"-api-",$bank_url);

$url_step_1=$bank_url_1.'/gateway/auth?apiKey='.@$auth_ApiKey;

// Initialize a cURL session
$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => $url_step_1, // API endpoint
  CURLOPT_RETURNTRANSFER => true, // Return the transfer as a string
  CURLOPT_ENCODING => '', // Accept all encodings
  CURLOPT_MAXREDIRS => 10, // Maximum number of redirects
  CURLOPT_TIMEOUT => 0, // No timeout
  CURLOPT_FOLLOWLOCATION => true, // Follow redirects
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1, // Use HTTP 1.1
  CURLOPT_CUSTOMREQUEST => 'POST', // HTTP POST method
    CURLOPT_HEADER => 0,
    CURLOPT_SSL_VERIFYPEER => 0,
    CURLOPT_SSL_VERIFYHOST => 0,
));

// Execute the cURL session
$response = curl_exec($curl);

// Close the cURL session
curl_close($curl);

// Decode the JSON response to an array
$response_array = json_decode($response,1);

//if(isset($response_array['data']['payment']['id'])&&trim($response_array['data']['payment']['id'])) $tr_upd_order1['acquirer_ref']=@$response_array['data']['payment']['id'];

//$tr_upd_order1['requestPost_1']=json_decode($requestPost_1,1);
$tr_upd_order1['url_step_1']=$url_step_1;
$tr_upd_order1['response_1']=(isset($response_array)&&is_array($response_array)?htmlTagsInArray($response_array):stf($response));

$tr_upd_order1=(isset($tr_upd_order1)&&is_array($tr_upd_order1)?htmlTagsInArray($tr_upd_order1):stf($tr_upd_order1));

trans_updatesf($_SESSION['tr_newid'], $tr_upd_order1);

if($data['cqp']>0) 
{
    echo "<br/><hr/><br/>bank_url=><br/>"; print_r($url_step_1);
    echo "<br/><br/>response=><br/>"; print_r($response);
    echo "<br/><br/>tr_upd_order1=><br/>"; print_r($tr_upd_order1);
}



if(isset($response_array['access_token']) && @$response_array['access_token'])
{
    $access_token=@$response_array['access_token'];
    db_trf($_SESSION['tr_newid'], 'acquirer_response_stage1', $access_token);
}

if(isset($response_array['errors']) && @$response_array['errors'])
{

    $error_description=@$response;
    $_SESSION['acquirer_response']=$error_description;
    $tr_upd_order1['error']=$error_description;
    $tr_upd_order1['trans_response']=$error_description;

    
    db_trf($_SESSION['tr_newid'], 'trans_response', $error_description);

    trans_updatesf($_SESSION['tr_newid'], $tr_upd_order1);
    echo 'Error for '.@$error_description;exit; 
}

// Check if the payment ID exists in the response
elseif(isset($access_token)&&@$access_token)
{

    /*
    {
        ### //Step 2: Initiate Payment #############################################

    
        $requestPost_2='{
            "merchantCode": "'.$merchantCode.'",
            "transactionRef": "'.$transID.'",
            "amount": '.@$total_payment.',
            "currency": "840",
            "paymentType": "PAYMENT"
        }';

        $curl = curl_init();
        
        //'https://pr-web-payment-gateway-k8.dev.prophius-api.com/api/v1/transaction/initiate', // API endpoint for 

        $curl_bank_url_2=$bank_url.'/transaction/initiate';
        
        curl_setopt_array($curl, array(
        CURLOPT_URL =>     $curl_bank_url_2, // API endpoint for encryption keys
        CURLOPT_RETURNTRANSFER => true, // Return the transfer as a string
        CURLOPT_ENCODING => '', // Accept all encodings
        CURLOPT_MAXREDIRS => 10, // Maximum number of redirects
        CURLOPT_TIMEOUT => 0, // No timeout
        CURLOPT_FOLLOWLOCATION => true, // Follow redirects
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1, // Use HTTP 1.1
        CURLOPT_CUSTOMREQUEST => 'POST', // HTTP GET method
            CURLOPT_HEADER => 0,
            CURLOPT_SSL_VERIFYPEER => 0,
            CURLOPT_SSL_VERIFYHOST => 0,
        CURLOPT_POSTFIELDS =>$requestPost_2, // JSON payload for the request
        CURLOPT_HTTPHEADER => array(
            'ApiKey: '.$header_ApiKey,
            'Content-Type: application/json',
            'Authorization: Bearer '.$access_token
        ),
        ));
        
        // Execute the cURL session
        $response = curl_exec($curl);
        
        // Close the cURL session
        curl_close($curl);
        
        // Output the response
        //echo $response;

        


        
        // Decode the JSON response to an array
        $response_2 = json_decode($response,1);

        // Retrieve the referenceNumber from the response
        $referenceNumber=@$response_2['referenceNumber'];

        // Store the transactionRef from the response
        $transactionRef=@$response_2['transactionRef'];


        $tr_upd_order1['referenceNumber']=$tr_upd_order1['acquirer_ref']=@$referenceNumber;
        $tr_upd_order1['transactionRef']=@$transactionRef;
        $tr_upd_order1['url_step_2']=@$curl_bank_url_2;
        $tr_upd_order1['requestPost_2']=json_decode(@$requestPost_2,1);
        $tr_upd_order1['response_2']=(isset($response_2)&&is_array($response_2)?htmlTagsInArray($response_2):stf($response));



        if($data['cqp']>0) 
        {
            echo "<br/><hr/><br/>curl_bank_url_2=><br/>"; print_r(@$curl_bank_url_2);
            echo "<br/><br/>referenceNumber=> "; print_r(@$referenceNumber);
            echo "<br/><br/>transactionRef=> "; print_r(@$transactionRef);
            echo "<br/><br/>response=><br/>"; print_r(@$response);

            echo "<br/><br/>tr_upd_order1=><br/>"; print_r(@$tr_upd_order1);
            
        }

    }
    */

    ######################################################

    // encryption logic used to encrypt the card data JSON object

    $cardData='';
    //$cardData='dae41144489e16ceabd4534d4c14f285fc4b5671dc9be3eafb4aabe0fab3a5578dea231236ab2fdeac79cf1dce7735a5b7a7861ead73168aec5f109d913cd72401a1ab48a20aa9617e33c8b94458349b4849cc2fa6be44bf285ebed50942c4ca88ca';
    //$cardData='0000000000000000000000008bd22dd9300f6a4d59f8633ae1782df1b4b00802a4034972a86e4b158c519981a6ba0121704b611ce4cbd5c31a1fe7a9cadb81f09a999006d3dd986c0b51ad2dcf15fdef8099009fe04ed502a829279f50cc25f5c6b7';


    // encode_53?cardNo=5123450000000009&expiryDate=3112&securityCode=123&zek=679942a3636b7b6b5ebf06a05f6a82cd6dc5e21ec88fe4a3c5d2dc676d412998&publicApiKey=a98a7967053c85aa413ffe3bab0a0e3dd11541b775acfee8e958f3f44cd947263d13f2a4f69d6807d58e3a2317f1093b5ed1e5082bbbe01240cb3127&qp=1

    //$encryptionUrl='http://localhost:8084/webhook55/encode_53';

    if(trim($encryptionUrl)) 
    {
        // https://www.jdoodle.com/online-java-compiler

        $encryptionRequest['cardNo']=@$post['ccno'];
       // $encryptionRequest['expiryDate']=@$post['month'].@$post['year'];
        $encryptionRequest['expiryDate']=@$post['year'].@$post['month'];
        $encryptionRequest['securityCode']=@$post['ccvv'];
        $encryptionRequest['zek']=@$apc_get['zek']; 
        $encryptionRequest['publicApiKey']=@$header_ApiKey;
        
        $encryptionUrl=$encryptionUrl.'?'.http_build_query($encryptionRequest);
        //$cardData=use_curl($encryptionUrl);

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
            $cardData = curl_exec($curl);
            curl_close($curl);

        //$cardData=use_curl($encryptionUrl);

        //if($data['localhosts']==true) $tr_upd_order1['encryptionUrl']=$encryptionUrl;
    }
    

    $tr_upd_order1['encryptionUrl']=$encryptionUrl;

    $cardData=trim($cardData);
    $cardData=str_replace('"','',$cardData);
    $tr_upd_order1['card_via_card_encrypt']=$cardData;


    ### //Step 3: 3DS Make Payment #############################################
    //if(isset($referenceNumber)&&trim($referenceNumber)&&trim($cardData))
    if(trim($cardData))
    {

        //https://webhook.site/f9476141-8460-43e1-825f-4fa34950580b
        //"callbackUrl" : "'.$webhookhandler_url.'",
        $requestPost_3='{
            "merchantCode": "'.@$merchantCode.'",
            "transactionRefNumber": "'.@$transID.'",
            "amount": '.@$total_payment.',
            "currency": "840",
            "cardData": "'.$cardData.'",
            "callbackUrl" : "'.$webhookhandler_url.'",
            "redirectUrl" : "'.$status_url_1.'"
        }';

        

        $curl = curl_init();

        //'https://pr-web-payment-gateway-k8.dev.prophius-api.com/api/v1/transaction/make-payment' // 2D API endpoint
        // $curl_bank_url_3=$bank_url.'/transaction/make-payment';

        //'https://pr-web-payment-gateway-k8.dev.prophius-api.com/api/v2/payments' // 3D API endpoint

        
        //$curl_bank_url_3='https://pr-web-payment-gateway-k8.dev.prophius-api.com/api/v2/payments';
        $curl_bank_url_3='https://pr-web-payment-gateway.paycontactles.com/api/v2/payments';

        curl_setopt_array($curl, array(
        CURLOPT_URL => $curl_bank_url_3, // API endpoint
        CURLOPT_RETURNTRANSFER => true, // Return the transfer as a string
        CURLOPT_ENCODING => '', // Accept all encodings
        CURLOPT_MAXREDIRS => 10, // Maximum number of redirects
        CURLOPT_TIMEOUT => 0, // No timeout
        CURLOPT_FOLLOWLOCATION => true, // Follow redirects
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1, // Use HTTP 1.1
        CURLOPT_CUSTOMREQUEST => 'POST', // HTTP POST method
            CURLOPT_HEADER => 0,
            CURLOPT_SSL_VERIFYPEER => 0,
            CURLOPT_SSL_VERIFYHOST => 0,
            CURLOPT_POSTFIELDS =>$requestPost_3, // JSON payload for the request
            CURLOPT_HTTPHEADER => array(
            'ApiKey: '.$header_ApiKey,
            'Content-Type: application/json',
            'Authorization: Bearer '.$access_token,
			'Cookie: AWSALB=jbKhXc82EjXMFFqCbc2WSlUqUecghuOkX3+DBK042qFBeAazAk8n5E7s0+UVxevF/IyJFST1mqEAQrBhxrRO2NQzKAlr+PutO7m4Z19SS5Y9X9yiHqOf/va9i5Hj; AWSALBCORS=jbKhXc82EjXMFFqCbc2WSlUqUecghuOkX3+DBK042qFBeAazAk8n5E7s0+UVxevF/IyJFST1mqEAQrBhxrRO2NQzKAlr+PutO7m4Z19SS5Y9X9yiHqOf/va9i5Hj'
            ),
        ));

        // Execute the cURL session
        $response_3 = curl_exec($curl);

        // Close the cURL session
        curl_close($curl);

        // Decode the JSON response to an array
        $response_3_via_pay = json_decode($response_3, 1);

        if(isset($response_3_via_pay['paymentRefNumber'])&&@$response_3_via_pay['paymentRefNumber'])
        {
            $tr_upd_order1['acquirer_ref']=@$response_3_via_pay['paymentRefNumber']; 
        }

        if(isset($response_3_via_pay['challengeScript'])&&@$response_3_via_pay['challengeScript'])
        {
            $challengeScript=@$response_3_via_pay['challengeScript'];
            unset($response_3_via_pay['challengeScript']);

            $tr_upd_order1['challengeScript']=$auth_3ds2_secure=base64_encode(@$challengeScript);
                        
            //$auth_3ds2_secure = @$challengeScript;
            $auth_3ds2_base64=1;

        }

        
            
        $tr_upd_order1['url_step_3']=$curl_bank_url_3;
        $tr_upd_order1['requestPost_3']=json_decode(@$requestPost_3,1);
        $tr_upd_order1['response_3_via_pay']=(isset($response_3_via_pay)&&is_array($response_3_via_pay)?htmlTagsInArray($response_3_via_pay):stf($response_3));
        
    }


    //Dev Tech : 24-09-20 Response Message set 
    if(isset($response_3_via_pay['respDesc'])&&@$response_3_via_pay['respDesc'])
    $_SESSION['acquirer_response']=@$response_3_via_pay['respDesc'];
    elseif(isset($response_array['message'])) $_SESSION['acquirer_response']=@$response_array['message'];
    elseif(isset($response_3_via_pay['data']['message'])&&@$response_3_via_pay['data']['message'])
    $_SESSION['acquirer_response']=@$response_3_via_pay['data']['message'];
    


    //Dev Tech:24-08-06 Check if the response contains a message is Successful payment or ['data']['links']['transaction_id'] then 2D successfull 
    if(isset($challengeScript)&&$challengeScript) 
    {

    }
    elseif(isset($response_3_via_pay['respCode'])&&$response_3_via_pay['respCode']=='00') 
    { // success
        $_SESSION['acquirer_action']=1;

        
        $_SESSION['acquirer_status_code']=2;
        $json_arr_set['realtime_response_url']=$status_url_1;
    }
    // Check if the response contains a redirect URL
    elseif(isset($response_3_via_pay['data']['links']['redirect_url'])) 
    {

        //$_SESSION['3ds2_auth']['payment_id']=$payment_id;
        //$_SESSION['3ds2_auth']['ecn_key']=@$ecn_key;

        //$_SESSION['3ds2_auth']['post_redirect']['target_']='_blank';
        //$_SESSION['3ds2_auth']['post_redirect']['method_']='get';


        //$_SESSION['3ds2_auth']['startSetInterval']='Y';
        $_SESSION['3ds2_auth']['paytitle']=@$dba;
        $_SESSION['3ds2_auth']['payamt']=@$total_payment;
        $_SESSION['3ds2_auth']['paycurrency']=@$orderCurrency;
        $_SESSION['3ds2_auth']['bill_amt']=@$post['bill_amt'];
        $_SESSION['3ds2_auth']['bill_currency']=@$post['bill_currency'];
        $_SESSION['3ds2_auth']['product_name']=@$post['product_name'];
        
        $auth_3ds2_secure=@$_SESSION['3ds2_auth']['payaddress']=$payment_url=curl_url_replace_f($response_3_via_pay['data']['links']['redirect_url']); // Retrieve the redirect URL
        $auth_3ds2_action='redirect'; //  redirect  post_redirect  
        $auth_3ds2=$secure_process_3d; 
    
        $tr_upd_order1['auth_3ds2_secure']=@$auth_3ds2_secure;
        $tr_upd_order1['auth_3ds2_action']=@$auth_3ds2_action;

    } 
    else
    { 	//failed
        $_SESSION['acquirer_action']=1;
        $_SESSION['acquirer_status_code']=-1;

        if(isset($_SESSION['acquirer_response'])&&!empty($_SESSION['acquirer_response']))
        db_trf($_SESSION['tr_newid'], 'trans_response', $_SESSION['acquirer_response']);

        $tr_upd_order1['FAILED']=@$_SESSION['acquirer_response'];
       // $process_url = $return_url; 
        $process_url = $status_url_1; 
        $json_arr_set['check_acquirer_status_in_realtime']='f';
        $json_arr_set['realtime_response_url']=$status_url_1;
        
    }

    $tr_upd_order1=(isset($tr_upd_order1)&&is_array($tr_upd_order1)?htmlTagsInArray($tr_upd_order1):stf($tr_upd_order1));

    db_trf($_SESSION['tr_newid'], 'acquirer_response_stage2', $tr_upd_order1);


    if($data['cqp']==9) 
    {
        echo "<br/><hr/><br/>curl_bank_url_3=><br/>"; print_r(@$curl_bank_url_3);
        echo "<br/><br/>auth_3ds2_secure=> "; print_r(@$auth_3ds2_secure);
        echo "<br/><br/>response_3=><br/>"; print_r(@$response_3);

        echo "<br/><br/>tr_upd_order1=><br/>"; print_r(@$tr_upd_order1);
        exit;
    }

            
    /*

    {
        "cardNumber": "512345xxxxxx0008",
        "amount": "110.00",
        "rrn": "421905332739",
        "stan": "332739",
        "cardBrand": "MASTERCARD",
        "status": "N",
        "transactionCurrency": "USD",
        "authCode": "332739",
        "respCode": "00",
        "respDesc": "APPROVED",
        "approved": true,
        "merchantCode": "TESTUBAPROPHNG"
    }

    */
}
else{

    //failed from end
    $_SESSION['acquirer_action']=1;
    $_SESSION['acquirer_status_code']=-1;

    if(isset($_SESSION['acquirer_response'])&&!empty($_SESSION['acquirer_response']))
    db_trf($_SESSION['tr_newid'], 'trans_response', $_SESSION['acquirer_response']);

    $tr_upd_order1['FAILED']=@$_SESSION['acquirer_response'];
    $process_url = $status_url_1; 
    //$json_arr_set['check_acquirer_status_in_realtime']='f';
    $json_arr_set['realtime_response_url']=$status_url_1;

}

$tr_upd_order_111=$tr_upd_order1;

?>