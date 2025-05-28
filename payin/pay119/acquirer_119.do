<?
// Dev Tech : 25-04-11  119 - Visa  Acquirer | Pesaway as a Acquirer 44,52   ------------------
// Webhook url added by backend team from Pesaway

//$data['cqp']=9;

//if acquirer is test mode 
if($_SESSION['b_'.$acquirer]['acquirer_prod_mode']==2)
{
	$post['ccno']='4111111111111111';
	$post['ccvv']='123';
	$post['month']='12'; // 06 || 12
	$post['year4']='2038';
}

if($data['localhosts']==true) 
{
	//$webhookhandler_url='https://aws-cc-uat.web1.one/responseDataList/?urlaction=notify_mastercard';
	$status_url_1="https://aws-cc-uat.web1.one/responseDataList/?transID={$transID}&termUrl3ds=pesaway";
   // $_SESSION['bill_ip']='123.221.222.111';

}

//{"merchant_key":"4b0446ec-ff55-11ef-a7d4-36f1d24257a9","password":"db16ad9eb50d11e6de2f160dacf78537"}

############################################################
// === Pesaway Test/Sandbox Credentials ===
$merchant_key=@$apc_get['merchant_key']; //"4b0446ec-ff55-11ef-a7d4-36f1d24257a9";
$password=@$apc_get['password']; // "db16ad9eb50d11e6de2f160dacf78537";



// === Order & Card Details ===
$orderId          = @$transID;
$orderAmount      = $total_payment;
$orderCurrency    = $orderCurrency;
$orderDescription = @$dba;
$cardNumber       = $post['ccno']; // '4111111111111111'; // Dummy card number for testing
$cardExpMonth     = $post['month']; // 06 || 12 // Dummy expiry month for testing
$cardExpYear      = $post['year4']; // '2038'; // Dummy expiry year for testing
$cardCVV2         = $post['ccvv']; // '123'; // Dummy CVV2 for testing

// === Payer Details ===
$payerFirstName = @$post['ccholder'];
$payerLastName  = @$post['ccholder_lname'];
$payerAddress   = @$post['bill_address'];
$payerCountry   = @$post['country_two'];
$payerState     = @$post['state_two'];
$payerCity      = @$post['bill_city'];
$payerZip       = @$post['bill_zip'];
$payerEmail     = @$post['bill_email'];
$payerPhone     = @$post['bill_phone'];
$payerIP        = @$_SESSION['bill_ip'];
$termUrl3ds     = $status_url_1;

// === Optional Flags ===
//$auth      = 'N';  $reqToken  = 'Y';  

// === Optional Flags ===
$auth      = 'Y'; // Set to 'Y' for AUTH-only
$reqToken  = 'N'; // If you want card_token returned

// === Calculate HASH using Formula 1 ===
$first6  = substr($cardNumber, 0, 6);
$last4   = substr($cardNumber, -4);
$hashRaw = strtoupper(strrev($payerEmail) . $password . strrev($first6 . $last4));
$hash    = md5($hashRaw);

// === Build Request Data ===
$postData = [
    'action'             => 'SALE',
    'client_key'         => $merchant_key,
    'order_id'           => $orderId,
    'order_amount'       => $orderAmount,
    'order_currency'     => $orderCurrency,
    'order_description'  => $orderDescription,
    'card_number'        => $cardNumber,
    'card_exp_month'     => $cardExpMonth,
    'card_exp_year'      => $cardExpYear,
    'card_cvv2'          => $cardCVV2,
    'payer_first_name'   => $payerFirstName,
    'payer_last_name'    => $payerLastName,
    'payer_address'      => $payerAddress,
    'payer_country'      => $payerCountry,
    'payer_state'        => $payerState,
    'payer_city'         => $payerCity,
    'payer_zip'          => $payerZip,
    'payer_email'        => $payerEmail,
    'payer_phone'        => $payerPhone,
    'payer_ip'           => $payerIP,
    'term_url_3ds'       => $termUrl3ds,
    'auth'               => $auth,
    'req_token'          => $reqToken,
    'hash'               => $hash
];



$postCardUnset=$postData;

if($postCardUnset['card_number']) unset($postCardUnset['card_number']);
if($postCardUnset['card_exp_month']) unset($postCardUnset['card_exp_month']);
if($postCardUnset['card_exp_year']) unset($postCardUnset['card_exp_year']);
if($postCardUnset['card_cvv2']) unset($postCardUnset['card_cvv2']);


############################################
if(@$data['cqp']>0) 
{
    echo "<br/><hr/><br/>url bank_url=>".$bank_url."<br/>";
    echo "<br/><hr/><br/>client_key=>".$merchant_key."<br/>";
    echo "<br/><hr/><br/>order_id=>".$orderId."<br/>";
    echo "<br/><hr/><br/>hashRaw=>".$hashRaw."<br/>";
    echo "<br/><hr/><br/>hash with md5=>".$hash."<br/>";

    $postDataJsonEncode = json_encode($postData);
    echo "<br/><hr/><br/>postDataJsonEncode=>".$postDataJsonEncode."<br/>";
}


// === CURL REQUEST - SEND REQUEST ===
$ch = curl_init($bank_url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_POST, true);
//curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json']);
//curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($postData));
curl_setopt($ch, CURLOPT_POSTFIELDS,  $postData);
curl_setopt($ch, CURLOPT_MAXREDIRS, 10);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);

$response = curl_exec($ch);
$http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
$curlError = curl_error($ch);
curl_close($ch);

// === Parse & Display Result ===
if (@$curlError) {
    echo "❌ CURL Error: $curlError - $http_code in $transID \n";
    exit;
}

/*

Array
(
    [action] => SALE
    [result] => REDIRECT
    [status] => REDIRECT
    [order_id] => 11920250410072502
    [trans_id] => eb4ffbe4-15dc-11f0-ad5f-a27cae8c5f60
    [trans_date] => 2025-04-10 07:25:03
    [amount] => 11.99
    [currency] => USD
    [redirect_url] => https://emulator.rafinita.com/acs
    [redirect_params] => Array
        (
            [PaReq] => ACCEPT/dW5pcXVlNjdmNzcyNGY5NGE3ODQuOTM1NjAyNDg=
            [TermUrl] => https://core.pesaway.com/verify/eb4ffbe4-15dc-11f0-ad5f-a27cae8c5f60/218e24cd435bed0842aa23c7c9b9d5e0
        )

    [redirect_method] => POST
)

*/

    

    // Decode the JSON response to an array
    $response_array = json_decode(@$response,1);


    if(isset($response_array['trans_id'])&&trim($response_array['trans_id']))
    $tr_upd_order1['acquirer_ref']=@$response_array['trans_id'];

    $tr_upd_order1['requestPost_1']=@$postCardUnset;
    $tr_upd_order1['url_step_1']=@$bank_url;
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



//{"result":"ERROR","error_code":0,"error_message":"Route or parameters is not supported","errors":[]}
if(isset($response_array['error_message']) && @$response_array['error_message'] || isset($response_array['error_message']) && @$response_array['error_message'])
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
    if(isset($response_array['trans_id']))
    {
        
        // Check if the response contains a redirect URL
        if(isset($response_array['redirect_url'])&&isset($response_array['redirect_params'])) 
        {

            //$_SESSION['3ds2_auth']['startSetInterval']='Y';
            $_SESSION['3ds2_auth']['paytitle']=@$dba;
            $_SESSION['3ds2_auth']['payamt']=@$total_payment;
            $_SESSION['3ds2_auth']['paycurrency']=@$orderCurrency;
            $_SESSION['3ds2_auth']['bill_amt']=@$post['bill_amt'];
            $_SESSION['3ds2_auth']['bill_currency']=@$post['bill_currency'];
            $_SESSION['3ds2_auth']['product_name']=@$post['product_name'];
            $_SESSION['3ds2_auth']['integration-type']=@$post['integration-type'];
            $_SESSION['3ds2_auth']['action_method']="post";
           
            $auth_3ds2_action='post_redirect';
            $auth_3ds2_secure=@$_SESSION['3ds2_auth']['payaddress']=$payment_url=curl_url_replace_f($response_array['redirect_url']); // Retrieve the redirect URL
            $_SESSION['3ds2_auth']['post_redirect']=@$response_array['redirect_params'];
				
            
            $tr_upd_order1['auth_3ds2_secure']=@$auth_3ds2_secure;
            $tr_upd_order1['auth_3ds2_action']=@$auth_3ds2_action;

        } 
        else{
            if(isset($response_array['status'])) $_SESSION['acquirer_response']=@$response_array['status'];
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