<?
// Dev Tech : 24-11-25  116 - Netpluspay -  Visa  Acquirer 

//$data['cqp']=9;



//{"merchantId":"MID635fcda6321d5"}
//{"visa":"MID4ab0fdb181c604","mastercard":"MID51958f0cbb776e"}

############################################################

$merchantId=@$apc_get['merchantId'];

if(isset($apc_get)&&is_array($apc_get)&&$_SESSION['info_data']['mop']&&((strpos($_SESSION['apJson'.$acquirer],"visa")!==false)||(strpos($_SESSION['apJson'.$acquirer],"mastercard")!==false)||(strpos($_SESSION['apJson'.$acquirer],"jcb")!==false)||(strpos($_SESSION['apJson'.$acquirer],"amex")!==false))&&(isset($_SESSION['info_data']['mop'])&&$_SESSION['info_data']['mop'])){
	$merchantId=$apc_get[$_SESSION['info_data']['mop']];

   // echo "<br/>00 merchantId=>".$merchantId; echo "<br/>mop=>".$_SESSION['info_data']['mop'];
}



/*
if(!isset($post['bill_street_1'])||empty($post['bill_street_1'])||@$post['bill_street_1']=='') 
{
    if(@$post['bill_address']) $post['bill_street_1']=$post['bill_address'];
    else $post['bill_street_1']='NA';
}

if(!isset($post['bill_street_2'])||empty($post['bill_street_2'])||@$post['bill_street_2']=='') $post['bill_street_2']='NA';
*/

//merchantId=MID635fcda6321d5&name=DEV%20TECH&email=temidoswag%40gmail.com&amount=2&currency=NGN&orderId=NPT6YZARVB1399366045637577

$requestPost_1['merchantId']=@$merchantId;
$requestPost_1['name']=@$post['fullname'];
$requestPost_1['email']=@$post['bill_email'];
$requestPost_1['amount']=@$total_payment;
$requestPost_1['currency']=@$orderCurrency;
$requestPost_1['orderId']=@$transID;

//'https://api.paysaddle.com/api/v2/checkout?merchantId=MID635fcda6321d5&name=DEV TECH&email=temidoswag@gmail.com&amount=2&currency=NGN&orderId=NPT6YZARVB1399366045637577', // API endpoint


$bank_url_checkout=$bank_url.'/checkout?'.http_build_query($requestPost_1);

// Initialize a cURL session
$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => $bank_url_checkout, // API endpoint
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
  CURLOPT_POSTFIELDS =>$requestPost_1, // JSON payload for the request
  
));

// Execute the cURL session
$response = curl_exec($curl);

// Close the cURL session
curl_close($curl);

// Decode the JSON response to an array
$response_array = json_decode($response,1);


if(isset($response_array['transId'])&&trim($response_array['transId']))
$tr_upd_order1['acquirer_ref']=@$response_array['transId'];

$tr_upd_order1['requestPost_1']=@$requestPost_1;
$tr_upd_order1['url_step_1']=$bank_url;
$tr_upd_order1['response_1']=(isset($response_array)&&is_array($response_array)?htmlTagsInArray($response_array):stf($response));

$tr_upd_order1=(isset($tr_upd_order1)&&is_array($tr_upd_order1)?htmlTagsInArray($tr_upd_order1):stf($tr_upd_order1));

trans_updatesf($_SESSION['tr_newid'], $tr_upd_order1);

if($data['cqp']>0) 
{
    
    echo "<br/><hr/><br/>bank_url=><br/>"; print_r($bank_url);
    echo "<br/><br/>requestPost_1=><br/>"; print_r($requestPost_1);
    echo "<br/><br/>response=><br/>"; print_r($response);
    echo "<br/><br/>tr_upd_order1=><br/>"; print_r($tr_upd_order1);
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
elseif(isset($response_array['transId']))
{
    // Initialize another cURL session
	$curl = curl_init();
	
    //transId:LIVE:cardPan:card expiry:cvv::currency

    //NP24091015122683593:LIVE:53998347****6632:09/24:472::USD

    $clientData_join=@$response_array['transId'].':LIVE:'.@$post['ccno'].':'.@$post['month'].'/'.@$post['year'].':'.@$post['ccvv'].'::'.@$orderCurrency;
    //$clientData_join=@$response_array['transId'].':TEST:'.@$post['ccno'].':'.@$post['month'].'/'.@$post['year'].':'.@$post['ccvv'].'::'.@$orderCurrency;
    $clientData=base64_encode($clientData_join);


    
    //'https://api.paysaddle.com/api/v2/pay', // API endpoint for 

    $curl_bank_url_2=$bank_url.'/pay';
    
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
        CURLOPT_POSTFIELDS =>'{
            "clientData":"'.$clientData.'",
            "type":"PAY" 
        }',
        CURLOPT_HTTPHEADER => array(
            'Content-Type: application/json'
        ),
	));
	
	// Execute the cURL session
	$response = curl_exec($curl);
	
	// Close the cURL session
	curl_close($curl);
	
	// Output the response
	//echo $response;
	
	// Decode the JSON response to an array
	$response_array = json_decode($response,1);

    if(isset($response_array['message'])) $_SESSION['acquirer_response']=@$response_array['message'];

	//if(isset($response_array['redirectHtml'])) unset($response_array['redirectHtml']);
	if(isset($response_array['TermUrl'])) unset($response_array['TermUrl']);
	if(isset($response_array['PaReq'])) unset($response_array['PaReq']);


    if($data['cqp']>0) 
    {
        $tr_upd_order1['url_step_2']=$curl_bank_url_2;
        $tr_upd_order1['clientData_join']=$clientData_join;
    }

    $tr_upd_order1['clientData']=$clientData;
    $tr_upd_order1['response_2']=(isset($response_array)&&is_array($response_array)?htmlTagsInArray($response_array):stf($response));

	
	// Store the payment ID and encryption key in session variables
	$payment_id=@$response_array['transId'];
	
    if($data['cqp']>0) 
    {
        echo "<br/><hr/><br/>curl_bank_url_2=><br/>"; print_r(@$curl_bank_url_2);
        echo "<br/><br/>payment_id=> "; print_r(@$payment_id);
        
        echo "<br/><br/>tr_upd_order1=><br/>"; print_r(@$tr_upd_order1);
        
    }


    
    if(isset($response_array['redirectHtml'])&&@$response_array['redirectHtml'])
    {
        $challengeScript=@$response_array['redirectHtml'];
        unset($response_array['redirectHtml']);

        $tr_upd_order1['challengeScript']=$auth_3ds2_secure=base64_encode(@$challengeScript);
                    
        //$auth_3ds2_secure = @$challengeScript;
        $auth_3ds2_base64=1;

        $_SESSION['3ds2_auth']['startSetInterval']='Y';

    }
    elseif(isset($response_array['ACSUrl'])) 
    {

       
        $_SESSION['3ds2_auth']['startSetInterval']='Y';
        $_SESSION['3ds2_auth']['paytitle']=@$dba;
        $_SESSION['3ds2_auth']['payamt']=@$total_payment;
        $_SESSION['3ds2_auth']['paycurrency']=@$orderCurrency;
        $_SESSION['3ds2_auth']['bill_amt']=@$post['bill_amt'];
        $_SESSION['3ds2_auth']['bill_currency']=@$post['bill_currency'];
        $_SESSION['3ds2_auth']['product_name']=@$post['product_name'];
        
        $auth_3ds2_secure=@$_SESSION['3ds2_auth']['payaddress']=$payment_url=curl_url_replace_f($response_array['ACSUrl']); // Retrieve the redirect URL
        $auth_3ds2_action='redirect'; //  redirect  post_redirect  
        $auth_3ds2=$secure_process_3d; 
    
        $tr_upd_order1['auth_3ds2_secure']=@$auth_3ds2_secure;
        $tr_upd_order1['auth_3ds2_action']=@$auth_3ds2_action;

    } 
    else{
        
        if(isset($response_array['message'])) $_SESSION['acquirer_response']=@$response_array['message'];
        //$process_url = $return_url; 

        //failed from end
        $_SESSION['acquirer_action']=1;
        //$_SESSION['acquirer_status_code']=-1;
        $_SESSION['acquirer_status_code']=23;
    
        if(isset($_SESSION['acquirer_response'])&&!empty($_SESSION['acquirer_response']))
        db_trf($_SESSION['tr_newid'], 'trans_response', @$_SESSION['acquirer_response']);
    
        $tr_upd_order1['FAILED']=@$_SESSION['acquirer_response'];
        $process_url = $status_url_1; 
        //$json_arr_set['check_acquirer_status_in_realtime']='f';
        //$json_arr_set['realtime_response_url']=$status_url_1;
        
        $json_arr_set['realtime_response_url']=$trans_processing;
    }

    $tr_upd_order1=(isset($tr_upd_order1)&&is_array($tr_upd_order1)?htmlTagsInArray($tr_upd_order1):stf($tr_upd_order1));

    db_trf($_SESSION['tr_newid'], 'acquirer_response_stage1', $tr_upd_order1);


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
            "code": "S0",
            "status": "3DS Required",
            "result": "NPPSEC2409111023407",
            "orderId": "NPT6YZARVB13993660456381",
            "amount": "1",
            "provider": "MPGS",
            "MD": "",
            "ACSUrl": "https://secure-acs2ui-b1-indblr-blrtdc.wibmo.com/v1/acs/services/browser/creq/L/8528/75341e0b-7027-11ef-b667-45e8ee180ee9",
            "PaReq": "eyJ0aHJlZURTU2VydmVyVHJhbnNJRCI6ImFkM2U3MDVjLTJiM2UtNDY4NS1iN2UzLTY2NTQxYWFlMzFkYyIsImFjc1RyYW5zSUQiOiI3NTM0MWUwYi03MDI3LTExZWYtYjY2Ny00NWU4ZWUxODBlZTkiLCJjaGFsbGVuZ2VXaW5kb3dTaXplIjoiMDUiLCJtZXNzYWdlVHlwZSI6IkNSZXEiLCJtZXNzYWdlVmVyc2lvbiI6IjIuMi4wIn0",
            "eciFlag": "N/P",
            "TermUrl": "https://api.paysaddle.com/api/v2/validateMPGS3D/TlAyNDA5MTExMDE4MzI5ODYyOTpMSVZFOjUzOTk4MzQ3MjYzMDY2MzI6MTEvMjQ6NDcxOjpVU0Q=/NPPSEC2409111023407",
            "transId": "NP24091110183298629",
            "redirectHtml": "<div id=\"threedsChallengeRedirect\" xmlns=\"http://www.w3.org/1999/html\" style=\" height: 100vh\"> <form id =\"threedsChallengeRedirectForm\" method=\"POST\" action=\"https://secure-acs2ui-b1-indblr-blrtdc.wibmo.com/v1/acs/services/browser/creq/L/8528/75341e0b-7027-11ef-b667-45e8ee180ee9\" target=\"challengeFrame\"> <input type=\"hidden\" name=\"creq\" value=\"eyJ0aHJlZURTU2VydmVyVHJhbnNJRCI6ImFkM2U3MDVjLTJiM2UtNDY4NS1iN2UzLTY2NTQxYWFlMzFkYyIsImFjc1RyYW5zSUQiOiI3NTM0MWUwYi03MDI3LTExZWYtYjY2Ny00NWU4ZWUxODBlZTkiLCJjaGFsbGVuZ2VXaW5kb3dTaXplIjoiMDUiLCJtZXNzYWdlVHlwZSI6IkNSZXEiLCJtZXNzYWdlVmVyc2lvbiI6IjIuMi4wIn0\" /> </form> <iframe id=\"challengeFrame\" name=\"challengeFrame\" width=\"100%\" height=\"100%\" ></iframe> <script id=\"authenticate-payer-script\"> var e=document.getElementById(\"threedsChallengeRedirectForm\"); if (e) { e.submit(); if (e.parentNode !== null) { e.parentNode.removeChild(e); } } </script> </div>"
        }

        */
}
else{
    $json_arr_set['realtime_response_url']=$trans_processing;

    


    //failed from end
    $_SESSION['acquirer_action']=1;
    //$_SESSION['acquirer_status_code']=-1;
    $_SESSION['acquirer_status_code']=23;

    if(isset($_SESSION['acquirer_response'])&&!empty($_SESSION['acquirer_response']))
    db_trf($_SESSION['tr_newid'], 'trans_response', @$_SESSION['acquirer_response']);

    $tr_upd_order1['FAILED']=@$_SESSION['acquirer_response'];
    $process_url = $status_url_1; 
    $json_arr_set['check_acquirer_status_in_realtime']='f';
}

$tr_upd_order_111=$tr_upd_order1;

?>