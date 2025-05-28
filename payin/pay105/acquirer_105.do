<?
// Dev Tech : 24-12-11  105 - cybersource -  Visa  Acquirer 

//$data['cqp']=9;



//{"merchant_mid":"abb_1197128_accounting_usd","channel":"001"}


$payaddress_arr['merchantID']=@$apc_get['merchantID'];
$payaddress_arr['merchantKey']=@$apc_get['merchantKey'];
$payaddress_arr['merchantKeySecret']=@$apc_get['merchantKeySecret'];
$payaddress_arr['apiKey']=@$apc_get['apiKey'];
$payaddress_arr['orgUnitId']=@$apc_get['orgUnitId'];
$payaddress_arr['apiIdentifier']=@$apc_get['apiIdentifier'];



//{"channel":"001","merchant_mid":"abb_1197128_accounting_usd","merchantKey":"7f1d4817-b0a8-4052-94b7-b2991735fd68","merchantKeySecret":"MtC7o4v/gToW2heUtkQ3iUJa9FhNcFeAlYM8VBsER9s=","apiKey":"8a6e82cf-d2b6-4b7c-8eb6-6164182547f0","apiIdentifier":"674626b942b962202c414dce","orgUnitId":"674626b94ac1d108dc240c93"}
//{"merchant_mid":"abb_1197128_accounting_usd","live_port":"8080","channel":"001"}

############################################################

$live_port='8080';
$channel='001';

if(isset($apc_get['live_port'])&&@$apc_get['live_port']) $live_port=@$apc_get['live_port'];
if(isset($apc_get['channel'])&&@$apc_get['channel']) $channel=@$apc_get['channel'];


if($data['localhosts']==true) 
{
	$webhookhandler_url='https://webhook.site/20619be7-ac2f-4f10-9757-4bf11586aef4';

}

    //http://13.214.193.127:8080/payload.html
    //bank_url : http://13.214.193.127

   // $java_bank_url=$bank_url.':'.$live_port.'/payload.html?'; // if port is 8080
    $java_bank_url=$bank_url.'/payload.html?'; // if ssl added as https://auth.yoqo.io

    $tr_upd_order1['java_bank_url']=$java_bank_url;

    if(isset($java_bank_url)) 
    {

        //$_SESSION['3ds2_auth']['startSetInterval']='Y';
       
        
        /*
        $auth_3ds2_secure=@$_SESSION['3ds2_auth']['payaddress']=$payment_url=curl_url_replace_f($response_array['auth_url']); // Retrieve the redirect URL
        $auth_3ds2_action='redirect'; //  redirect  post_redirect  
        $auth_3ds2=$secure_process_3d; 
        */
        
        // http://localhost:8080/payload.html?fullname=Arun%20Kumar&channel=001&cardNo=4047457514066090&monthExpiry=03&yearExpiry=2029&cvv=303&amount=1.00&transID=1197128111

        $payaddress_arr['channel']=@$channel;
        $payaddress_arr['fullname']=@$post['fullname'];
        $payaddress_arr['cardNo']=@$post['ccno'];
        $payaddress_arr['monthExpiry']=@$post['month'];
        $payaddress_arr['yearExpiry']=@$post['year4'];
        $payaddress_arr['cvv']=@$post['ccvv'];
        $payaddress_arr['amount']=@$total_payment;
        $payaddress_arr['transID']=@$transID; // orderId

        if(isset($apc_get['merchant_mid'])&&isset($apc_get['merchantKey'])&&isset($apc_get['merchantKeySecret']))
        {
            $payaddress_arr['merchantID']=@$apc_get['merchant_mid'];
            $payaddress_arr['merchantKey']=@$apc_get['merchantKey'];
            $payaddress_arr['merchantKeySecret']=@$apc_get['merchantKeySecret'];
            $payaddress_arr['apiKey']=@$apc_get['apiKey'];
            $payaddress_arr['orgUnitId']=@$apc_get['orgUnitId'];
            $payaddress_arr['apiIdentifier']=@$apc_get['apiIdentifier'];
        }

        
        $base64_data=http_build_query($payaddress_arr);
        $_SESSION['3ds2_auth']['base64_data']=base64_encode(@$base64_data);

        //$payaddress_3ds_url=$java_bank_url.http_build_query($payaddress_arr);
        $payaddress_3ds_url=$java_bank_url;

        
        $auth_data_not_save=1; // auth_data not save in json 
        $auth_3ds2_action='redirect_base64'; //  redirect_base64 iframe_base64 redirect  post_redirect 
        $_SESSION['3ds2_auth']['payaddress']=$auth_3ds2_secure=base64_encode(@$payaddress_3ds_url);
                        
        //$auth_3ds2_secure = @$challengeScript;
        //$auth_3ds2_base64=1;

        $_SESSION['3ds2_auth']['action']=$auth_3ds2_action;
        //$tr_upd_order1['auth_3ds2_secure']=@$auth_3ds2_secure;
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
       
        echo "<br/><br/>tr_upd_order1=><br/>"; print_r(@$tr_upd_order1);
        exit;
    }

        /*

       
        */

        

$tr_upd_order_111=$tr_upd_order1;

?>