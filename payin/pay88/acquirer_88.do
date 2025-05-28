<?
//$data['cqp']=1;

if(isset($_REQUEST['dtest'])&&$_REQUEST['dtest']>0) $data['cqp']=1;
elseif(isset($_REQUEST['vqp'])&&$_REQUEST['vqp']>0) $data['cqp']=1;



##########################################################

@$dba=str_replace(["|"]," - ",@$dba);
@$remark='test';

##########################################################

$acquirer_set=@$acquirer;

if(isset($post['mop'])&&($post['mop']=='QRINTENT'||$post['mop']=='UPICOLLECT')) $acquirer_set=0;

##########################################################

if(empty($bank_url)||$bank_url=='NA') $ban='https://apis.paytme.com/v1/merchant/payin';

##########################################################

if(!isset($apc_get['userContactNumber'])) $apc_get['userContactNumber']='1234567890';

// QR & INTENT are separately

if($acquirer_set==88 || (isset($post['mop'])&&$post['mop']=='QRINTENT') )
 { //for QR dynamic code QR & INTENT 

    // {"apikey":"b03104fd5d92036c1f32e48fb57449ca","userContactNumber":"1234567890"}

    //upi://pay?pa=11917842@cbin&pn=COB&tn=9cxtjowenq&tr=9cxtjowenq&am=10&cu=INR

    $subQueryReq=[];
    $subQueryReq['userContactNumber']=$apc_get['userContactNumber'];
    $subQueryReq['merchantTransactionId']=@$transID;
    $subQueryReq['amount']=@$total_payment;
    $subQueryReq['name']=@$post['fullname'];
    $subQueryReq['email']=@$post['bill_email'];

$qr_post_request='{
    "userContactNumber":"'.@$apc_get['userContactNumber'].'",
    "merchantTransactionId":"'.@$transID.'",
    "amount":'.@$total_payment.',
    "name":"'.@$post['fullname'].'",
    "email":"'.@$post['bill_email'].'"
}';



    //https://apis.paytme.com/v1/merchant/payin/scanQR
    
    //Checkout intent URL auto-fetches based on mobile device or s2s param (device_ios or device_android)
	if(isMobileDevice() || (isset($post['os']) && ($post['os']=='device_ios'||$post['os']=='device_android')) ) $QrUrl = $bank_url ;
    
    else $QrUrl = $bank_url . "/scanQR";

    
    $qr_httpheader=array(
        'x-api-key: '.@$apc_get['apikey'],
        'Content-Type: application/json'
    );

    if(isset($data['cqp'])&&$data['cqp']>0)
    {
        echo "<br/><hr/><br/><h3>QR CODE </h3><br/>"; 

        echo "<br/><hr/><br/>QrUrl:<br/>"; print_r($QrUrl);
        echo "<br/><hr/><br/>qr_post_request:<br/>"; print_r($qr_post_request);
       
        echo "<br/><hr/><br/>subQueryReq:<br/>"; print_r($subQueryReq);

        echo "<br/><hr/><br/>qr_httpheader:<br/>"; print_r($qr_httpheader);
        echo "<br/><hr/><br/>";
    }


    $curl = curl_init();

    curl_setopt_array($curl, array(
        CURLOPT_URL => $QrUrl,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => '',
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 0,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_HEADER => 0,
			CURLOPT_SSL_VERIFYHOST => 0,
			CURLOPT_SSL_VERIFYPEER => 0,
        CURLOPT_CUSTOMREQUEST => 'POST',
        CURLOPT_POSTFIELDS => $qr_post_request,
        CURLOPT_HTTPHEADER => $qr_httpheader,
    ));

    $response = curl_exec($curl);
    curl_close($curl);
    $QrResponse = json_decode($response,1);

    if(isMobileDevice() || (isset($post['os']) && ($post['os']=='device_ios'||$post['os']=='device_android')) ) $tr_upd_order['request_type']='INTENT_MOBILE';
    else $tr_upd_order['request_type']='WEB_QR';

    $tr_upd_order['api_url']=$QrUrl;
    $tr_upd_order['post_request']=json_decode($qr_post_request,1);
    $tr_upd_order['response_qr_intent']=(isset($QrResponse)&&is_array($QrResponse)?htmlTagsInArray($QrResponse):stf($response));

    if(isset($data['cqp'])&&$data['cqp']>0)
    {
        echo "<br/><hr/><br/><h3>RESPONSE OF QRCODE & INTENT.</h3><br/>"; 
        echo "<br/><hr/><br/>response:<br/>"; print_r(@$response);
        echo "<br/><hr/><br/>QrResponse:<br/>"; print_r(@$QrResponse);
        echo "<br/><hr/><br/>";
    }

    /*

        {
            "data": {
                "scanQR": "https://merchant.paytme.com/payment-qr-code?pa=11917842@cbin&pn=COB&tn=9cxtjowenq&tr=9cxtjowenq&am=10&cu=INR&mr=Letspe&tid=67137eff73d5b6348d4bf08c&rdul=undefined",
                "upiurl": "upi://pay?pa=11917842@cbin&pn=COB&tn=9cxtjowenq&tr=9cxtjowenq&am=10&cu=INR",
                "transaction_id": "67137eff73d5b6348d4bf08c"
            },
            "code": 200,
            "message": "Payin information has been successfully created."
        }

    */


    //QR Code url from ['data']['upiurl']
   
    /*
    if(isMobileDevice()) {
        
    }
    else {

        $qrString=$tr_upd_order['qrString']=@$QrResponse['data']['upiurl'];
        
        $without_intent=1; // QR only without intent 
        $intent_process_include=1;
        $qr_intent_address=replace_space_tab_br_for_intent_deeplink($qrString,1);
    }
    */

    if(isset($QrResponse['data']['transaction_id'])&&trim($QrResponse['data']['transaction_id'])) $tr_upd_order['acquirer_ref']=@$QrResponse['data']['transaction_id'];
    
    $_SESSION['acquirer_action']=1;
    $qrString=$tr_upd_order['data_upiurl']=@$QrResponse['data']['upiurl'];
    $_SESSION['acquirer_response']=$tr_upd_order['acquirer_message']=@$QrResponse['message'];
        
    $intent_process_include=1;
    $qr_intent_address=replace_space_tab_br_for_intent_deeplink($qrString,1);


    if(isset($data['cqp'])&&$data['cqp']>0)
    {
        echo "<br/><hr/><br/><h3>AFTER RESPONSE FOR QR CODE ONLY.</h3><br/>"; 
       
        echo "<br/><hr/><br/>qrString:<br/>"; print_r(@$qrString);
        echo "<br/><hr/><br/>qr_intent_address:<br/>"; print_r(@$qr_intent_address);

        if(!empty($qrString)) echo "<img DONE_AJAX src=\"https://quickchart.io/chart?chs=160x160&cht=qr&chl={$qr_intent_address}&choe=UTF-8\"  />";
        echo "<br/><hr/><br/>";
    }

    trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);


    if(!isset($QrResponse['data']['upiurl'])&&isset($QrResponse['message'])&&@$QrResponse['message'])
    {
        $_SESSION['acquirer_status_code']=-1;
        $error_description=@$QrResponse['message'];

        $return_response_arr['Error']=1581;
		$return_response_arr['Message']=@$error_description;

        $_SESSION['acquirer_response']=$return_response_arr['Message'];
        $tr_upd_order1['Error']=$tr_upd_order['Error']=@$return_response_arr['Message'];

        $tr_upd_order1['trans_response']=$tr_upd_order['trans_response']=$error_description;

       
        if(!isset($_REQUEST['integration-type'])&&$_REQUEST['integration-type']!='s2s')
        {
            db_trf($_SESSION['tr_newid'], 'trans_response', $error_description);

            trans_updatesf($_SESSION['tr_newid'], $tr_upd_order1);
            echo 'Error for '.@$error_description;exit; 
        }
        else if(isset($_REQUEST['integration-type'])&&$_REQUEST['integration-type']=='s2s')
        {

            //failed from end
            $_SESSION['acquirer_status_code']=-1;
        
            if(isset($_SESSION['acquirer_response'])&&!empty($_SESSION['acquirer_response']))
            db_trf($_SESSION['tr_newid'], 'trans_response', $_SESSION['acquirer_response']);
        
            $tr_upd_order1['FAILED']=@$_SESSION['acquirer_response'];
            $process_url = $status_url_1; 
            //$json_arr_set['check_acquirer_status_in_realtime']='f';
            $json_arr_set['realtime_response_url']=$status_url_1;
        
        }
        
      
    }

    /*
    if(isset($QrResponse['httpCode'])&&in_array($QrResponse['httpCode'],["401"])&&isset($QrResponse['moreInformation']))
    {
        $error_description=@$QrResponse['moreInformation'];
        $_SESSION['acquirer_response']=$error_description;
        $tr_upd_order1['error']=$error_description;
        $tr_upd_order1['trans_response']=$error_description;

        db_trf($_SESSION['tr_newid'], 'trans_response', $error_description);
        echo 'Error for '.@$error_description;exit; 
    }

   */
    
 }

 /*
elseif($acquirer_set==884 || (isset($post['mop'])&&$post['mop']=='UPICOLLECT') )
{ //for collect
    
    $collectResponse = json_decode($response,1);

    $json_arr_set['UPICOLLECT']='Y';
    $tr_upd_order['collectUrl']=$RaiseCollectUrl;
    $tr_upd_order['collectResponse'] =$collectResponse;

 }

 */

 $tr_upd_order_111=$tr_upd_order;

?>