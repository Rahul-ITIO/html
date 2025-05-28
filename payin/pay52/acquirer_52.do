<?
// Dev Tech : 24-08-03  52 - Visa  Acquirer | borderlesspaymentng

//$data['cqp']=9;

//if acquirer is test mode 
if($_SESSION['b_'.$acquirer]['acquirer_prod_mode']==2)
{
	$post['ccno']='5555555555556666';
	$post['ccvv']='321';
	$post['month']='10';
	$post['year4']='2031';
}

if($data['localhosts']==true) 
{
	$webhookhandler_url='https://aws-cc-uat.web1.one/responseDataList/?urlaction=notify_mastercard';
	//$status_url_1="https://aws-cc-uat.web1.one/responseDataList/?transID={$transID}&urlaction=notify_mastercard";
   // $_SESSION['bill_ip']='123.221.222.111';

}

//{"bearer_key":"1yXt$PC3X0FLoigs"}

############################################################

$bearer_key=@$apc_get['bearer_key'];


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

/*
if(isset($post['bill_ip'])&&!empty($post['bill_ip']))
    $bill_ip=@$post['bill_ip'];
else $bill_ip=@$_SESSION['bill_ip'];
*/

//$reference_29='1b09d9b2-11jd9eheveb-9203v0'.rand(10,99);
//@$reference_29=prefix_trans_lenght(@$transID,29,1,'TRANSESSION','O');

$requestPost_1='{
    "firstname" : "'.@$post['ccholder'].'",
    "lastname" : "'.@$post['ccholder_lname'].'",
    "phone" : "'.@$bill_phone.'",
    "email" : "'.@$post['bill_email'].'",
    "address" : "'.@$post['bill_address'].'",
    "city" : "'.@$post['bill_city'].'",
    "state" : "'.@$post['state_two'].'",
    "country" : "'.@$post['country_two'].'",
    "zip_code" : "'.@$post['bill_zip'].'",
    "amount" : "'.$total_payment.'",
    "currency" : "'.@$orderCurrency.'",
    "cardName" : "'.@$post['fullname'].'",
    "cardNumber" : "'.@$post['ccno'].'",
    "cardCVV" : "'.@$post['ccvv'].'",
    "expMonth" : "'.@$post['month'].'",
    "expYear" : "'.@$post['year4'].'",
    "reference" : "'.$transID.'",
    "ip_address" : "'.@$_SESSION['bill_ip'].'",
    "webhook_url" : "'.$webhookhandler_url.'",
    "callback_url" : "'.$status_url_1.'"
}';


$requestPost_1_json_decode=json_decode($requestPost_1,1);

if($requestPost_1_json_decode['cardNumber']) unset($requestPost_1_json_decode['cardNumber']);
if($requestPost_1_json_decode['cardCVV']) unset($requestPost_1_json_decode['cardCVV']);
if($requestPost_1_json_decode['expMonth']) unset($requestPost_1_json_decode['expMonth']);
if($requestPost_1_json_decode['expYear']) unset($requestPost_1_json_decode['expYear']);


$api_gateway_execution=1;

// &&(isset($curl_action)&&$curl_action==true)
//Dev Tech : 24-09-13 Block Country as per IP of country_code
if(isset($acquirer)&&(isset($_SESSION["b_".$acquirer]['block_countries']))&&(trim($_SESSION["b_".$acquirer]['block_countries']))&&(isset($_SESSION['bill_ip'])))
{
	
	$url_ip_details=$data['Host']."/third_party_api/ips?action=json&remote=".$_SESSION['bill_ip'];
	
	$country_via_ip = file_get_contents(@$url_ip_details);

	$ipResponse = json_decode($country_via_ip, true);

	if(@$data['cqp']>0) 
	{
		echo "<br/><hr/><br/><h2>IPS RES.</h2><br/>"; 

		echo "<br/><hr/><br/>url_ip_details=><br/>"; print_r(@$url_ip_details);
		echo "<br/><br/>IP country_code=><br/>"; print_r(@$ipResponse['country_code']);
		echo "<br/><br/>ipResponse=><br/>"; print_r(@$ipResponse);
		echo "<br/><br/>Acquirer block_countries_arr=><br/>"; print_r(@$_SESSION["b_".$acquirer]['block_countries_arr']);
		echo "<br/><hr/><br/>";
	}

	
    if(isset($ipResponse['country_code'])&&in_array(@$ipResponse['country_code'],@$_SESSION["b_".$acquirer]['block_countries_arr']))
    {
        $api_gateway_execution=0;

        $tr_upd_order1['IP_COUNTRY_CODE']=@$ipResponse['country_code'];

        $return_response_arr['Error']=1581;
        //$return_response_arr['Message']='Error for '.$ipResponse['country_code']." is block country from your IP : ".$_SESSION['bill_ip'];
        $return_response_arr['Message']='IP address originates from a restricted country ('.$ipResponse['country_code'].").";

		$_SESSION['acquirer_response']=$return_response_arr['Message'];
        $tr_upd_order1['Error']=@$return_response_arr['Message'];

		if(@$data['cqp']>0) print_r($_SESSION['acquirer_response']);
        //json_print($jsonError);exit;
    }
    else
    {
        $responseBin=card_binf(@$post['ccno']);
	
        
        if(isset($responseBin['josn']['countryCode'])&&$responseBin['josn']['countryCode']){
            $countryCodeBin=$responseBin['josn']['countryCode'];
            
            if(isset($countryCodeBin)&&in_array(@$countryCodeBin,@$_SESSION["b_".$acquirer]['block_countries_arr']))
            {
                $api_gateway_execution=0;

                $tr_upd_order1['BIN_COUNTRY_CODE']=@$countryCodeBin;

                $return_response_arr['Error']=1582;
                //$return_response_arr['Message']='Error for '.$countryCodeBin." is block country from your ".@$responseBin['josn']['scheme'];
                $return_response_arr['Message']='Card BIN associated with a restricted country ('.$countryCodeBin.").";

                $_SESSION['acquirer_response']=$return_response_arr['Message'];

                $tr_upd_order1['Error']=@$return_response_arr['Message'];

                if(@$data['cqp']>0) print_r($_SESSION['acquirer_response']);
                //json_print($jsonError);exit;
            }
            //echo $countryCodeBin;exit;
        }

    }


}




if($api_gateway_execution==1)
{


    //'https://staging.borderlesspaymentng.com/api/charge', // API endpoint

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
        'Authorization: Bearer '.$bearer_key,
        'Content-Type: application/json',
        'Cookie: XSRF-TOKEN=eyJpdiI6IjZIclE0WXB2ZWVIcWhhYjdUQjJYRkE9PSIsInZhbHVlIjoiUzJhRkpDUGVxaDVmNXV3STBUakFXWjQzeUlmTGE1dzN0ZlFGK1dKWm1ycGRqZCsxekFLWEcxcUdrcFdBdEM3ZmNjcG5QcC9yS1ZFSis3TUFQTTlZSllkVlpCS2dQRnMzVWp4ejNzSktETFVOeDR1K3JwdGRzWExTVFdwRkdzRHgiLCJtYWMiOiIyNzdkNjljZDE4OThjMzhiODViYWU0NjNlZThiZWU3ZjExNTk0MDY0ODcwY2MzZTc5MzM5MjE2MTE1YjBiNWU1IiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IjlkaFB1ejhobk93MFJTc3RGS0xGNEE9PSIsInZhbHVlIjoiUlpqMzVWVFhYUEs5amc3TnQrRFlOckkzWUVKRXdEdmwxeGMxQXVudTRKMTA1ZWtFbDdzMEtBZ2JmTnNxTlNDd0U1ZnMvdHRneStQVUp4cENZblRMUTcyUGJ6ZTRGTmxRS0pQV0dZaGxJQUhQbXNaMldoM3laTUdObFN4ZjduODEiLCJtYWMiOiJkNDg4MDFkZDZlN2RkODJmMzM5NDYyM2I3ZTQ2YTEyYjc5ZmZiMDQ2MjMzNjA3NDg0Njc4NzUxZTM3N2YyZjBlIiwidGFnIjoiIn0%3D'
    ),

    ));

    // Execute the cURL session
    $response = curl_exec($curl);

    // Close the cURL session
    curl_close($curl);

    // Decode the JSON response to an array
    $response_array = json_decode($response,1);


    if(isset($response_array['data']['orderid'])&&trim($response_array['data']['orderid']))
    $tr_upd_order1['acquirer_ref']=@$response_array['data']['orderid'];

    $tr_upd_order1['requestPost_1']=$requestPost_1_json_decode;
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

}

//Dev Tech : 24-10-01 Bug fix if No assigned MID in data response 
if(isset($response_array['data']) && @$response_array['data']=='No assigned MID') 
    @$response_array['errors']=@$response_array['data'];


if(isset($response_array['errors']) && @$response_array['errors'] || isset($response_array['error']) && @$response_array['error'])
{

    $error_description=@$response;
    $_SESSION['acquirer_response']=$error_description;
    $tr_upd_order1['error']=$error_description;
    $tr_upd_order1['trans_response']=$error_description;

    db_trf($_SESSION['tr_newid'], 'trans_response', $error_description);

    trans_updatesf($_SESSION['tr_newid'], $tr_upd_order1);
    echo $transID.' :: Error for '.@$error_description;
    
    $process_url = $status_url_1; 
    $json_arr_set['check_acquirer_status_in_realtime']='f';

    //exit; 
}
else 
{
    // Check if the payment ID exists in the response
    if(isset($response_array['data']['orderid']))
    {
        
        // Check if the response contains a redirect URL
        if(isset($response_array['data']['link'])) 
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
            $_SESSION['3ds2_auth']['integration-type']=@$post['integration-type'];
            
            $auth_3ds2_secure=@$_SESSION['3ds2_auth']['payaddress']=$payment_url=curl_url_replace_f($response_array['data']['link']); // Retrieve the redirect URL
            $auth_3ds2_action='redirect'; //  redirect  post_redirect  
            $auth_3ds2=$secure_process_3d; 
        
            $tr_upd_order1['auth_3ds2_secure']=@$auth_3ds2_secure;
            $tr_upd_order1['auth_3ds2_action']=@$auth_3ds2_action;

        } 
        else{
            if(isset($response_array['data']['transaction']['message'])) $_SESSION['acquirer_response']=@$response_array['data']['transaction']['message'];
            else $_SESSION['acquirer_response']="Expired transaction. Please try again.";
            //$process_url = $return_url; 

            //failed from end
            $_SESSION['acquirer_action']=1;
            //$_SESSION['acquirer_status_code']=-1;
            $_SESSION['acquirer_status_code']=23;
        
            if(isset($_SESSION['acquirer_response'])&&!empty($_SESSION['acquirer_response']))
            db_trf($_SESSION['tr_newid'], 'trans_response', $_SESSION['acquirer_response']);
        
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
                    "status": "success",
                    "message": "success",
                    "data": {
                        "reference": "5220240803051044",
                        "orderid": "fa6ffbabe485f970fd4b6393ee3a733f",
                        "link": "https:\/\/staging.borderlesspaymentng.com\/api\/checkout\/1136\/eyJ1cmwiOiJodHRwczpcL1wvc3RhZ2luZy5ib3JkZXJsZXNzcGF5bWVudG5nLmNvbVwvYXBpXC8xMTM2XC9jYWxsYmFjayIsInR5cGUiOiIzRCIsImdhdGV3YXlpZCI6IjExMzYiLCJyZWZlcmVuY2UiOiI1MjIwMjQwODAzMDUxMDQ0IiwiYW1vdW50IjoiMC4wMSIsInRyYW5zZGF0ZSI6IjIwMjQtMDgtMDMgMDU6MTA6NDYiLCJpc19wbHVnaW4iOjF9"
                    }
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
        db_trf($_SESSION['tr_newid'], 'trans_response', $_SESSION['acquirer_response']);
    
        $tr_upd_order1['FAILED']=@$_SESSION['acquirer_response'];
        $process_url = $status_url_1; 
        $json_arr_set['check_acquirer_status_in_realtime']='f';
        //$json_arr_set['realtime_response_url']=$status_url_1;
    }
}
$tr_upd_order_111=$tr_upd_order1;

?>