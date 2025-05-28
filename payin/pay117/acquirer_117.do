<?
// Dev Tech : 24-11-25  117 - Payagency -  Visa  Acquirer 

//$data['cqp']=9;



//{"secret_key":"29a993a8-ab75-426c-985d-eb8a9f886c13"}

############################################################

$secret_key=@$apc_get['secret_key'];


if($data['localhosts']==true) 
{
	$webhookhandler_url='https://webhook.site/20619be7-ac2f-4f10-9757-4bf11586aef4';

}

//Dev Tech : 24-07-30 ISD code get from country + last 10 digit phone number 


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
$isd_code='+'.@$post['isd_code'];

//@$transID_set=prefix_trans_lenght(@$transID,28,1,'TRANSESSION','O');
@$transID_set=@$transID;


$requestPost_1_jsn='{
    "first_name": "'.@$post['ccholder'].'",
    "last_name": "'.@$post['ccholder_lname'].'",
    "address": "'.@$post['bill_address'].'",
    "order_id": "'.@$transID_set.'",
    "country": "'.@$post['country_two'].'",
    "state": "'.@$post['state_two'].'",
    "city": "'.@$post['bill_city'].'",
    "zip": "'.@$post['bill_zip'].'",
    "ip_address": "'.@$_SESSION['bill_ip'].'",
    "email": "'.@$post['bill_email'].'",
    "country_code": "'.@$isd_code.'",
    "phone_number": "'.@$post['bill_phone'].'",
    "amount": "'.@$total_payment.'",
    "currency": "'.@$orderCurrency.'",
    "card_number": "'.@$post['ccno'].'",
    "card_expiry_month": "'.@$post['month'].'",
    "card_expiry_year": "'.@$post['year4'].'",
    "card_cvv": "'.@$post['ccvv'].'",
    "response_url": "'.@$status_url_1.'",
    "webhook_url": "'.@$webhookhandler_url.'"
}';

$requestPost_1_arr = [
    'order_id' => @$transID_set,
    'first_name' => @$post['ccholder'],
    'last_name' => @$post['ccholder_lname'],
    'email' => @$post['bill_email'],
    'phone_number' => @$post['bill_phone'],
    'ip_address' => @$_SESSION['bill_ip'],
    'zip' => @$post['bill_zip'],
    'city' => @$post['bill_city'],
    'state' => @$post['state_two'],
    'country' => @$post['country_two'],
    'amount' => @$total_payment,
    'currency' => @$orderCurrency,
    'card_number' => @$post['ccno'],
    'card_expiry_month' => @$post['month'],
    'card_expiry_year' => @$post['year4'],
    'card_cvv' => @$post['ccvv'],
    'webhook_url' => @$status_url_1
  ];

  //$requestPost_1=json_encode(@$requestPost_1_arr);
  $requestPost_1=$requestPost_1_jsn;

    if($data['cqp']>0) 
    {
        echo "<br/><hr/><br/>requestPost_1=><br/>"; print_r(@$requestPost_1);
        //exit;
    }


    // Initialize another cURL session
	$curl = curl_init();
	
    
    //'https://api.pay.agency/v1/test/transaction', // API endpoint for 

    
	curl_setopt_array($curl, array(
	  CURLOPT_URL => $bank_url, // API endpoint for encryption keys
	  CURLOPT_RETURNTRANSFER => true, // Return the transfer as a string
	  CURLOPT_ENCODING => '', // Accept all encodings
	  CURLOPT_MAXREDIRS => 10, // Maximum number of redirects
	  CURLOPT_TIMEOUT => 0, // No timeout
	  CURLOPT_FOLLOWLOCATION => true, // Follow redirects
	  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1, // Use HTTP 1.1
	  
        CURLOPT_HEADER => 0,
        CURLOPT_SSL_VERIFYPEER => 0,
        CURLOPT_SSL_VERIFYHOST => 0,
        CURLOPT_CUSTOMREQUEST => 'POST', // HTTP GET method
        CURLOPT_POSTFIELDS =>@$requestPost_1,
        CURLOPT_HTTPHEADER => array(
                'Content-Type: application/json',
                'Authorization: Bearer '.@$secret_key
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

    if(isset($response_array['transaction']['result']['message'])) $_SESSION['acquirer_response']=@$response_array['transaction']['result']['message'];

	$requestPost_1_de = json_decode($requestPost_1,1);
	//$requestPost_1_de = @$requestPost_1;

    if($data['localhosts']==true) 
    {

    }
    else 
    {
        if(isset($requestPost_1_de['card_no'])) unset($requestPost_1_de['card_no']);
        if(isset($requestPost_1_de['ccExpiryMonth'])) unset($requestPost_1_de['ccExpiryMonth']);
        if(isset($requestPost_1_de['ccExpiryYear'])) unset($requestPost_1_de['ccExpiryYear']);
        if(isset($requestPost_1_de['cvvNumber'])) unset($requestPost_1_de['cvvNumber']);
    }

	//if(isset($response_array['auth_url'])) unset($response_array['auth_url']);
	if(isset($response_array['TermUrl'])) unset($response_array['TermUrl']);
	if(isset($response_array['transaction']['transaction_id'])) $tr_upd_order1['acquirer_ref']=@$response_array['transaction']['transaction_id'];


    $tr_upd_order1['url_step_1']=$curl_bank_url_2;
    $tr_upd_order1['requestPost_1']=@$requestPost_1_de;
    $tr_upd_order1['response_1']=(isset($response_array)&&is_array($response_array)?htmlTagsInArray($response_array):stf($response));

    
    if($data['cqp']>0) 
    {
        echo "<br/><hr/><br/>curl_bank_url_2=><br/>"; print_r(@$curl_bank_url_2);
        
        echo "<br/><br/>tr_upd_order1=><br/>"; print_r(@$tr_upd_order1);
        echo "<br/><br/>requestPost_1_de=><br/>"; print_r(@$requestPost_1_de);
    }


   
    if(isset($response_array['auth_url'])) 
    {

        //$_SESSION['3ds2_auth']['startSetInterval']='Y';
        $_SESSION['3ds2_auth']['paytitle']=@$dba;
        $_SESSION['3ds2_auth']['payamt']=@$total_payment;
        $_SESSION['3ds2_auth']['paycurrency']=@$orderCurrency;
        $_SESSION['3ds2_auth']['bill_amt']=@$post['bill_amt'];
        $_SESSION['3ds2_auth']['bill_currency']=@$post['bill_currency'];
        $_SESSION['3ds2_auth']['product_name']=@$post['product_name'];
        
        $auth_3ds2_secure=@$_SESSION['3ds2_auth']['payaddress']=$payment_url=curl_url_replace_f($response_array['auth_url']); // Retrieve the redirect URL
        $auth_3ds2_action='redirect'; //  redirect  post_redirect  
        $auth_3ds2=$secure_process_3d; 
    
        $tr_upd_order1['auth_3ds2_secure']=@$auth_3ds2_secure;
        $tr_upd_order1['auth_3ds2_action']=@$auth_3ds2_action;

    } 
    else{
        
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

    //trans_updatesf($_SESSION['tr_newid'], $tr_upd_order1);

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
            "status": 300,
            "message": "redirected",
            "auth_url": "https://api.pay.agency/v1/test/transaction/form/eyJpdiI6IlI1Qkk2bHVTaTdkZ3FoYmhHbU53NEE9PSIsInZhbHVlIjoiNTBKeXE3bjVUZ003d0F3UkJYMlR0OU0wK2NVT0hVK3cyREkraUtvTUFDQmlhRXhiZTRZTnFFWjhCTHVGVEdVNSIsIm1hYyI6ImVhMDRjYWM3NzE5ZmY2MGQ5Mzk5YTg1Yjk1NDQyNzk1ZGRkOWYxMjFhNWIyMDkzNmIxOWQ2MmNlYjc2OTJkMWMiLCJ0YWciOiIifQ==",
            "transaction": {
                "order_id": null,
                "transaction_id": "T251732530750PDMK4",
                "terminal_id": null,
                "customer": {
                    "first_name": "First Name",
                    "last_name": "Last Name",
                    "email": "test@gmail.com",
                    "phone_number": null
                },
                "billing": {
                    "zip": "38564",
                    "address": "Address",
                    "city": "New York",
                    "state": "NY",
                    "country": "US"
                },
                "payment_details": [],
                "order": {
                    "amount": "10.00",
                    "currency": "USD"
                },
                "device": {
                    "ip_address": "122.176.92.114"
                },
                "result": {
                    "status": "redirected",
                    "message": "Additional details required."
                },
                "refund": {
                    "status": false,
                    "refund_reason": null,
                    "refunded_on": null
                },
                "chargebacks": {
                    "status": false,
                    "chargebacked_on": null
                },
                "flagged": {
                    "status": false,
                    "flagged_on": null
                }
            }
        }
        */

        

$tr_upd_order_111=$tr_upd_order1;

?>