<?
// Dev Tech : 24-07-13  51 - Visa  Acquirer 

//$data['cqp']=9;

if($_SESSION['b_'.$acquirer]['acquirer_prod_mode']==2)
{
	

}

if($data['localhosts']==true) 
{
	$webhookhandler_url='https://aws-cc-uat.web1.one/responseDataList/?urlaction=notify_mastercard';

}

//{"auth_key":"test_Z2F0ZXdheS10ZXN0OmFmZjVhY2M2LTZhZjItNDVhYS04ZTk3LTcxYzA5ODM1NzAyMzpiMzVmODk3NS04NGE2LTRiZjItYjFhMC04NTM3ZTQ0MmI4NTk"}

############################################################

$auth_key=@$apc_get['auth_key'];


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



//$reference_29='1b09d9b2-11jd9eheveb-9203v0'.rand(10,99);
@$reference_29=prefix_trans_lenght(@$transID,29,1,'TRANSESSION','O');

//remove 0 if starting 0
if(preg_match("#^0+\d*#", $post['month'])) $post['month']=str_replace('0','',$post['month']);

$total_payment_100=$total_payment*100;

/*
if(!isset($post['bill_street_1'])||empty($post['bill_street_1'])||@$post['bill_street_1']=='') 
{
    if(@$post['bill_address']) $post['bill_street_1']=$post['bill_address'];
    else $post['bill_street_1']='NA';
}

if(!isset($post['bill_street_2'])||empty($post['bill_street_2'])||@$post['bill_street_2']=='') $post['bill_street_2']='NA';
*/

$requestPost_1='{
    "customer": {
        "first_name": "'.@$post['ccholder'].'",
        "last_name": "'.@$post['ccholder_lname'].'",
        "email": "'.@$post['bill_email'].'",
        "phone_number": "'.@$bill_phone.'",
        "billing_address": {
            "line1": "'.@$post['bill_street_1'].'",
            "line2": "'.@$post['bill_street_2'].'",
            "city": "'.@$post['bill_city'].'",
            "state": "'.@$post['state_two'].'",
            "country": "'.@$post['country_two'].'",
            "zip_code": "'.@$post['bill_zip'].'"
        }
    },
    "description": "'.@$post['product'].'",
    "currency": "'.@$orderCurrency.'",
    "amount": '.@$total_payment_100.',
    "direction": "incoming",
    "payment_method": {
        "type": "card"
    },
    "reference": "'.@$reference_29.'",
    "settlement_target": "business",
    "metadata": {
        "order": {
            "identifier": "'.@$transID.'",
            "items": [
                {
                    "name": "Deposit",
                    "type": "digital"
                }
            ]
        }
    }
}';

//'https://api-sandbox.spendjuice.com/payment-sessions', // API endpoint

// Initialize a cURL session
$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => $bank_url, // API endpoint
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
  CURLOPT_POSTFIELDS =>$requestPost_1, // JSON payload for the request
  CURLOPT_HTTPHEADER => array(
    "Authorization: $auth_key", // Authorization header
    "content-type: application/json" // Content type header
  ),
));

// Execute the cURL session
$response = curl_exec($curl);

// Close the cURL session
curl_close($curl);

// Decode the JSON response to an array
$response_array = json_decode($response,1);


if(isset($response_array['data']['payment']['id'])&&trim($response_array['data']['payment']['id']))
$tr_upd_order1['acquirer_ref']=@$response_array['data']['payment']['id'];

$tr_upd_order1['requestPost_1']=json_decode($requestPost_1,1);
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
elseif(isset($response_array['data']['payment']['id']))
{
    // Initialize another cURL session
	$curl = curl_init();
	
    if($_SESSION['b_'.$acquirer]['acquirer_prod_mode']==2)
    {
        $endpoint='test';
    }
    else {
        $endpoint='live';
    }

    //'https://api-sandbox.spendjuice.com/payment-sessions/encryption-keys/test', // API endpoint for 

    $curl_bank_url_2=$bank_url.'/encryption-keys/'.$endpoint;
    
	curl_setopt_array($curl, array(
	  CURLOPT_URL =>     $curl_bank_url_2, // API endpoint for encryption keys
	  CURLOPT_RETURNTRANSFER => true, // Return the transfer as a string
	  CURLOPT_ENCODING => '', // Accept all encodings
	  CURLOPT_MAXREDIRS => 10, // Maximum number of redirects
	  CURLOPT_TIMEOUT => 0, // No timeout
	  CURLOPT_FOLLOWLOCATION => true, // Follow redirects
	  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1, // Use HTTP 1.1
	  CURLOPT_CUSTOMREQUEST => 'GET', // HTTP GET method
        CURLOPT_HEADER => 0,
        CURLOPT_SSL_VERIFYPEER => 0,
        CURLOPT_SSL_VERIFYHOST => 0,
	  CURLOPT_POSTFIELDS =>'{
		"card": {
			"card_number": "'.@$post['ccno'].'",
			"name": "'.@$post['fullname'].'",
			"cvv": "'.@$post['ccvv'].'",
			"expiry_month":'.@$post['month'].',
			"expiry_year": '.@$post['year4'].'
		}
	}', // JSON payload for the request
	  CURLOPT_HTTPHEADER => array(
		"Authorization: $auth_key", // Authorization header
		"content-type: application/json" // Content type header
	  ),
	));
	
	// Execute the cURL session
	$response = curl_exec($curl);
	
	// Close the cURL session
	curl_close($curl);
	
	// Output the response
	//echo $response;
	
	// Decode the JSON response to an array
	$ecn_array = json_decode($response,1);

    $tr_upd_order1['url_step_2']=$curl_bank_url_2;
    $tr_upd_order1['response_2']=(isset($ecn_array)&&is_array($ecn_array)?htmlTagsInArray($ecn_array):stf($response));

	
	// Retrieve the encryption key from the response
	$ecn_key= $ecn_array['data']['encryption_key'];

	// Store the payment ID and encryption key in session variables
	$payment_id=$response_array['data']['payment']['id'];
	//$ecn_key=$ecn_key;

   
	
	// Redirect to payment.php and exit
	//header("Location:payment.php");exit;


    if($data['cqp']>0) 
    {
        echo "<br/><hr/><br/>curl_bank_url_2=><br/>"; print_r(@$curl_bank_url_2);
        echo "<br/><br/>payment_id=> "; print_r(@$payment_id);
        echo "<br/><br/>ecn_key=> "; print_r(@$ecn_key);
        echo "<br/><br/>response=><br/>"; print_r(@$response);

        echo "<br/><br/>tr_upd_order1=><br/>"; print_r(@$tr_upd_order1);
        
    }



    ######################################################

    // Retrieve the payment ID and encryption key from session variables
   // $payment_id = $_SESSION['payment_id'];
   // $ecn_key = $_SESSION['ecn_key'];

    // Function to encrypt card details using AES-256-GCM
    function card_encrypt($payload, $key) {
        $cipher = "aes-256-gcm"; // Cipher method
        $iv = openssl_random_pseudo_bytes(16); // Generate a random initialization vector (IV)
        $cipher_text = openssl_encrypt($payload, $cipher, $key, OPENSSL_RAW_DATA, $iv, $tag); // Encrypt the payload
        return implode(':', [bin2hex($iv), bin2hex($cipher_text), bin2hex($tag)]); // Return the IV, cipher text, and tag as a single string
    }

    // Encrypt card details and CVV using the encryption key
    $card = card_encrypt(@$post['ccno'], $ecn_key);
    $cvv = card_encrypt(@$post['ccvv'], $ecn_key);
   // $cvv = card_encrypt("100", $ecn_key);

    $tr_upd_order1['ecn_key']=$ecn_key;
    $tr_upd_order1['card_via_card_encrypt']=$card;
    $tr_upd_order1['cvv_via_card_encrypt']=$cvv;

    // Initialize a cURL session
    $curl = curl_init();

    //'https://api-sandbox.spendjuice.com/payment-sessions/'.$payment_id, // API endpoint

    $curl_bank_url_3=$bank_url.'/'.$payment_id;

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
    CURLOPT_POSTFIELDS => '{
        "card": {
            "card_number": "'.$card.'",
            "name": "'.@$post['fullname'].'",
            "cvv": "'.$cvv.'",
            "expiry_month": '.@$post['month'].',
            "expiry_year": '.@$post['year4'].'
        }
    }', // JSON payload for the request
    CURLOPT_HTTPHEADER => array(
        "Authorization: {$auth_key}", // Authorization header
        'Content-Type: application/json' // Content type header
    ),
    ));

    // Execute the cURL session
    $response_3 = curl_exec($curl);

    // Close the cURL session
    curl_close($curl);

    // Decode the JSON response to an array
    $response_3_via_pay = json_decode($response_3, 1);

    

        
    $tr_upd_order1['url_step_3']=$curl_bank_url_3;
    $tr_upd_order1['response_3_via_pay']=(isset($response_3_via_pay)&&is_array($response_3_via_pay)?htmlTagsInArray($response_3_via_pay):stf($response_3));


    //Dev Tech:24-08-06 Check if the response contains a message is Successful payment or ['data']['links']['transaction_id'] then 2D successfull 
    if((isset($response_3_via_pay['data']['message'])&&$response_3_via_pay['data']['message']=='Successful payment')||(isset($response_3_via_pay['data']['links']['transaction_id'])&&trim($response_3_via_pay['data']['links']['transaction_id']))) 
    {
        $_SESSION['acquirer_action']=1;
        $_SESSION['acquirer_response']=@$response_3_via_pay['data']['message'];
        //$_SESSION['acquirer_transaction_id']=@$result_hkip['tradeNo'];
        //$_SESSION['acquirer_descriptor']=@$result_hkip['acquirer'];


        $_SESSION['acquirer_status_code']=2;
        $json_arr_set['realtime_response_url']=$trans_processing;
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
    else{
        $_SESSION['acquirer_action']=1;
        $_SESSION['acquirer_status_code']=-1;
        if(isset($response_array['message'])) $_SESSION['acquirer_response']=@$response_array['message'];
        //$process_url = $return_url; 
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
            "data": {
                "auth_type": "3ds",
                "configuration": null,
                "expires_at": "2024-07-13T21:11:55.952977Z",
                "links": {
                    "redirect_url": "https://pgv2.qa.arca-payments.network/arca-mp/api/v2/inith?mtx=ARCFIW05115082061720861919590"
                },
                "message": "Waiting for payment",
                "payment": {
                    "amount": 100,
                    "amount_paid": null,
                    "cancellation_reason": null,
                    "correlation_id": "f372e896-40f7-11ef-bd1f-ea4cdff7277e",
                    "currency": "USD",
                    "customer": {
                        "billing_address": {
                            "city": "Springfield",
                            "country": "US",
                            "line1": "123 Main St",
                            "line2": "",
                            "state": "CA",
                            "zip_code": "12345"
                        },
                        "email": "john.doe@example.com",
                        "first_name": "John",
                        "id": "39ae57ad-a113-4498-95d1-6aa167687931",
                        "last_name": "Doe",
                        "phone_number": "+2348118873422"
                    },
                    "date": "2024-07-13T09:11:55.726880Z",
                    "description": "Test",
                    "id": "f3702372-40f7-11ef-a198-ea4cdff7277e",
                    "metadata": {
                        "order": {
                            "identifier": "ORD12344",
                            "items": [
                                {
                                    "name": "Deposit",
                                    "type": "digital"
                                }
                            ]
                        }
                    },
                    "mode": "test",
                    "payer": null,
                    "payment_method": {
                        "card_number": "512345******0008",
                        "expiry_month": 1,
                        "expiry_year": 2039,
                        "id": "455e8579-809b-4a25-9d19-18a6b6566539",
                        "type": "card"
                    },
                    "provider_id": null,
                    "reference": "1b09d9b2-11jd9eheveb-9203v054",
                    "status": "authenticating",
                    "type": "payin"
                },
                "status": "authenticating"
            }
        }



        ###################################################

        https://api-sandbox.spendjuice.com/payment-sessions/JJRqg5HY8NZnhoKYnjCqKm/3ds?order_payment_reference=ARCPAY-0F390FD9D69846B1A64846EB722F62B8&status=successful


        */
}
else{
    $_SESSION['acquirer_action']=1;
    //$_SESSION['acquirer_response']=@$response_array['message'];
    $_SESSION['acquirer_status_code']=-1;
	//$process_url = $return_url; 
	$json_arr_set['realtime_response_url']=$trans_processing;
}

$tr_upd_order_111=$tr_upd_order1;

?>