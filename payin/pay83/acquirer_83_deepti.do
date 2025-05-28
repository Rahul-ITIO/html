<?
$data['cqp']=1;
##########################################################

$acquirer_set=@$acquirer;

if(isset($post['mop'])&&($post['mop']=='QRINTENT'||$post['mop']=='UPICOLLECT')) $acquirer_set=0;

##########################################################

$vpaRequestPost=0;

if(isset($_REQUEST['vpaRequestPost'])&&$_REQUEST['vpaRequestPost']>0)   $vpaRequestPost=(int)@$_REQUEST['vpaRequestPost'];


$vpaEnqRequestPost=0;

if(isset($_REQUEST['vpaEnqRequestPost'])&&$_REQUEST['vpaEnqRequestPost']>0)   $vpaEnqRequestPost=(int)@$_REQUEST['vpaEnqRequestPost'];


##########################################################

// Prepare POST data for token request
$tokenPost['grant_type'] = $apc_get['grant_type'];
$tokenPost['redirect_uri'] = "https://can-webhook.web1.one/payin/pay83/webhookhandler_83";//$apc_get['redirect_uri'];
$tokenPost['state'] = $apc_get['state'];
$tokenPost['scope'] = @$apc_get['scope'];
$tokenPost['code'] = @$apc_get['code'];
//$tokenPost['code'] = "N4IrZQ8pKoWWnrFvPQir29rnl3f30MZZ"; // Replace with actual value if needed
@$authorizationBearer='n2pfYJdeu2nhj66ut6mIoccOBnqmIROw'; // Replace with actual value if needed for Bearer 

 // Extract refresh token and other data
 $refresh_token = @$apc_get['refresh_token']; //"9Gzi4dV9zxV5AcQzicIXlImwNOYG0FVi"; //$tokenResponse['refresh_token'];

if(isset($apc_get['bearer'])&&!empty($apc_get['bearer']))
    @$authorizationBearer=$apc_get['bearer'];

    if(isset($data['cqp'])&&$data['cqp']>0)
    {
        echo "<br/><hr/><br/><h3>ACQUIRER KEY</h3><br/>"; 
        echo "<br/><hr/><br/>code:<br/>"; print_r(@$tokenPost['code']);
        echo "<br/><hr/><br/>Authorization Bearer:<br/>"; print_r(@$authorizationBearer);
        echo "<br/><hr/><br/>tokenPost:<br/>"; print_r(@$tokenPost);
        echo "<br/><hr/><br/>apc_get:<br/>"; print_r(@$apc_get);
        echo "<br/><hr/><br/>";
    }

    $tokenString = http_build_query($tokenPost);

    $userName = $apc_get['Username'];
    $password = $apc_get['Password'];

    $credentials = base64_encode($userName . ':' . $password);

    //$tokenUrl = $bank_url . "/oauth2/token";

    $header = array(
        'Content-Type: application/x-www-form-urlencoded',
        'Authorization: Basic ' . $credentials
    );


//if($vpaRequestPost==1 || $vpaEnqRequestPost==1 )
{
    $tokenUrl = "https://apibanking.canarabank.in/v1/oauth2/token";

    if(isset($data['cqp'])&&$data['cqp']>0)
    {
        echo "<br/><hr/><br/><h3>ACCESS TOKEN</h3><br/>"; 
        echo "<br/><hr/><br/>tokenUrl:<br/>"; print_r(@$tokenUrl);
        echo "<br/><hr/><br/>tokenString:<br/>"; print_r(@$tokenString);
        echo "<br/><hr/><br/>header:<br/>"; print_r(@$header);
        echo "<br/><hr/><br/>";
    }

    // Request for access token
    $curl = curl_init();
    curl_setopt_array($curl, array(
        CURLOPT_URL => $tokenUrl,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => '',
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 0,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => 'POST',
        CURLOPT_POSTFIELDS => $tokenString,
        CURLOPT_HTTPHEADER => $header
    ));

    $response = curl_exec($curl);
    curl_close($curl);

    $tokenResponse = json_decode($response, true);

    if(isset($data['cqp'])&&$data['cqp']>0)
    {
        echo "<br/><hr/><br/>Token response:<br/>"; print_r($response);
        echo "<br/><hr/><br/>tokenResponse:<br/>"; print_r($tokenResponse);
        echo "<br/><hr/><br/>";
    }




    #####################################################################################
   
    $Grand_type = "refresh_token";
    $access_token = $tokenResponse['refresh_token'];

    $Rpost['refresh_token'] = $refresh_token;
    $Rpost['grant_type'] = $Grand_type;

    $tokenRefreshUrl = $bank_url . "/oauth2/refresh-token";

    $RtokenString = http_build_query($Rpost);

    if(isset($data['cqp'])&&$data['cqp']>0)
    {
        echo "<br/><hr/><br/><h3>REFRESH TOKEN</h3><br/>"; 
        echo "<br/><hr/><br/>tokenRefreshUrl:<br/>"; print_r(@$tokenRefreshUrl);
        echo "<br/><hr/><br/>RtokenString:<br/>"; print_r(@$RtokenString);
        echo "<br/><hr/><br/>header:<br/>"; print_r(@$header);
        echo "<br/><hr/><br/>";
    }

    // Request for refreshed token
    $curl = curl_init();
    curl_setopt_array($curl, array(
        CURLOPT_URL => $tokenRefreshUrl,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => '',
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 0,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => 'POST',
        CURLOPT_POSTFIELDS => $RtokenString, // Fix the POSTFIELDS variable
        CURLOPT_HTTPHEADER => $header // If different headers are required, update this
    ));

    $response = curl_exec($curl);
    curl_close($curl);


    if(isset($data['cqp'])&&$data['cqp']>0)
    {
        echo "<br/><hr/><br/>REFRESH TOKEN response:<br/>"; print_r(@$response);
        echo "<br/><hr/><br/>";
    }


    // Vpa_creation
    $access_token = "bnRXSCxG7BcA5WaMuEDcAmAe9qwMjA55";
    ############################################################################################# 
    $postVpa['x-client-id'] = $apc_get['x-client-id'];
    $postVpa['x-client-secret'] = $apc_get['x-client-secret'];
    $postVpa['x-client-certificate'] = $apc_get['x-client-certificate'];
    $postVpa['x-api-interaction-id'] = rand();
    $postVpa['x-timestamp'] =time();
    $postVpa['Cookie'] = "test";

}

// VPA Post
if($vpaRequestPost==1)
{
    $encryption = use_curl('http://15.207.116.247:8080/api/encryption/encrypt');
    $encryptedData = trim(substr($encryption, strlen('Encrypted Data: ')));

    $VpaEnqSignature = use_curl('http://15.207.116.247:8080/api/encryption/sign'); 

    $VpaUrl = "https://apibanking.canarabank.in/v1/upi/vpa-creation";   // $bank_url . "/upi/vpa-creation";



    //Dev Tech : 24-08-21 Modify for log print - start 

    $encryptedData=str_replace('"','',$encryptedData);

    $vpa_CURLOPT_HTTPHEADER=array(
        'x-client-id: ' . $apc_get['x-client-id'],
        'x-client-secret: ' . $apc_get['x-client-secret'],
        'x-client-certificate: ' . $apc_get['x-client-certificate'],
        'x-api-interaction-id: ' . $postVpa['x-api-interaction-id'],
        'x-timestamp: ' . $postVpa['x-timestamp'],
        'Cookie: test',
        'Content-Type: application/json',
        'x-signature: ' . $VpaEnqSignature,
        'Authorization: Bearer '.@$authorizationBearer
    );

    if(isset($data['cqp'])&&$data['cqp']>0)
    {
        echo "<br/><hr/><br/><h3>VPA POST</h3><br/>"; 
        echo "<br/><hr/><br/>VpaUrl:<br/>"; print_r($VpaUrl);
        echo "<br/><hr/><br/>encryptedData:<br/>"; print_r($encryptedData);
        echo "<br/><hr/><br/>VpaEnqSignature:<br/>"; print_r($VpaEnqSignature);
        echo "<br/><hr/><br/>Vpa HTTPHEADER:<br/>"; print_r($vpa_CURLOPT_HTTPHEADER);
        echo "<br/><hr/><br/>";
    }


    $curl = curl_init();
    curl_setopt_array($curl, array(
        CURLOPT_URL => $VpaUrl,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => '',
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 0,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => 'POST',
        CURLOPT_POSTFIELDS => json_encode(array(
            "Request" => array(
                "body" => array(
                    "encryptData" => "$encryptedData"
                )
            )
        )),
        CURLOPT_HTTPHEADER => $vpa_CURLOPT_HTTPHEADER,
    ));

    $response = curl_exec($curl);
    curl_close($curl);

    $VpaResponse = json_decode($response,1);


    $tr_upd_order['VpaUrl'] = $VpaUrl;
    $tr_upd_order['VpaRequest'] = $encryptedData;
    $tr_upd_order['VpaResponse'] = (isset($VpaResponse)&&is_array($VpaResponse)?htmlTagsInArray($VpaResponse):stf($response));
    trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);

    if(isset($data['cqp'])&&$data['cqp']>0)
    {
        echo "<br/><hr/><br/>Vpa response:<br/>"; print_r($response);
        echo "<br/><hr/><br/>VpaResponse:<br/>"; print_r($VpaResponse);
        echo "<br/><hr/><br/>";
    }

}

// VPA Enq.
if($vpaEnqRequestPost==1)
{

    

    ###################################################################################################
    // Vpa Enquiry Request
    $Vpaencryption = use_curl('http://15.207.116.247:8080/api/VpaEncryption/encrypt');
    $VpaencryptedData = trim(substr($Vpaencryption, strlen('Encrypted Data: ')));

    $VpaencryptedData=str_replace('"','',$VpaencryptedData);

    $VpaSignatureEnq = use_curl('http://15.207.116.247:8080/api/VpaEncryption/sign');

    $VpaEnqUrl = $bank_url . "/upi/vpa-creation-enq";

    $curl = curl_init();

    $vpaenq_httpheader=array(
        'x-client-id: ' . $apc_get['x-client-id'],
        'x-client-secret: ' . $apc_get['x-client-secret'],
        'x-client-certificate: ' . $apc_get['x-client-certificate'],
        'x-api-interaction-id: ' . $postVpa['x-api-interaction-id'],
        'x-timestamp: ' . $postVpa['x-timestamp'],
        'Cookie: test',
        'Content-Type: application/json',
        'x-signature: ' . $VpaSignatureEnq, // Interpolated variable
        'Authorization: Bearer '.@$authorizationBearer
    );


    if(isset($data['cqp'])&&$data['cqp']>0)
    {
        echo "<br/><hr/><br/><h3>VPA ENQ.</h3><br/>"; 
        echo "<br/><hr/><br/>VpaEnqUrl:<br/>"; print_r($VpaEnqUrl);
        echo "<br/><hr/><br/>VpaencryptedData:<br/>"; print_r($VpaencryptedData);
        echo "<br/><hr/><br/>vpaenq_httpheader:<br/>"; print_r($vpaenq_httpheader);
        echo "<br/><hr/><br/>";
    }

    curl_setopt_array($curl, array(
        CURLOPT_URL => $VpaEnqUrl,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => '',
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 0,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => 'POST',
        CURLOPT_POSTFIELDS => json_encode(array(
            "Request" => array(
                "body" => array(
                    "encryptData" => "$VpaencryptedData"
                )
            )
        )),
        CURLOPT_HTTPHEADER => $vpaenq_httpheader,
    ));

    $response = curl_exec($curl);
    curl_close($curl);

    $vpaEnqResponse = json_decode($response,1);
    $vpaEnqEncryptData = $vpaEnqResponse['Response']['body']['encryptData'];
    $tr_upd_order['vpaEnqEncryptData']=@$vpaEnqEncryptData;

    if(isset($data['cqp'])&&$data['cqp']>0)
    {
        echo "<br/><hr/><br/>Vpa Enq. response:<br/>"; print_r($response);
        echo "<br/><hr/><br/>vpaEnqResponse:<br/>"; print_r($vpaEnqResponse);
        echo "<br/><hr/><br/>vpaEnqEncryptData:<br/>"; print_r($vpaEnqEncryptData);
        echo "<br/><hr/><br/>";
    }

    /*

    $suqQuery=@http_build_query(@$apc_get);

    //echo $encryption_1 = use_curl('http://15.207.116.247:8080/api/encryption/encrypt?' . $suqQuery);
    //$subQueryUrl = 'http://15.207.116.247:8080/api/encryption/encrypt?' . $suqQuery;

    $JUrl = "http://15.207.116.247:8080/api/encryption/encrypt";

    $ch = curl_init($JUrl);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $suqQuery);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

    $response = curl_exec($ch);
    curl_close($ch);

    */   


    //VPA Decode

    // Construct the URL
    $url = "http://15.207.116.247:8080/api/encryption/decrypt?encryptedData=" . urlencode(@$vpaEnqEncryptData);

    // Use file_get_contents to make the request
    $response = file_get_contents($url);

    // Output the response
    //echo $response;

    //Merchant successfully onboarded
    $response_replace = str_replace("Decrypted Data: ","",$response);
    $decodeVpaEnqResponse = json_decode(@$response_replace,1);
        $qr_string=$tr_upd_order['qr_string']=@$decodeVpaEnqResponse['response']['qr_string'];
    $upiId=@$decodeVpaEnqResponse['response']['upiId'];
    $mobile_number=@$decodeVpaEnqResponse['response']['mobile_number'];
    $mercName=@$decodeVpaEnqResponse['response']['mercName'];

    $tr_upd_order['decodeVpaEnqResponse']=@$decodeVpaEnqResponse;
    trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);

    if(isset($data['cqp'])&&$data['cqp']>0)
    {
        echo "<br/><hr/><br/><h3>DECRYP AFTER RESPONSE OF VPA ENQ.</h3><br/>"; 
        echo "<br/><hr/><br/>response:<br/>"; print_r(@$response);
        echo "<br/><hr/><br/>response_replace:<br/>"; print_r(@$response_replace);
        echo "<br/><hr/><br/>decodeVpaEnqResponse:<br/>"; print_r(@$decodeVpaEnqResponse);
        echo "<br/><hr/><br/>qr_string:<br/>"; print_r(@$qr_string);
        echo "<br/><hr/><br/>upiId:<br/>"; print_r(@$upiId);
        echo "<br/><hr/><br/>mobile_number:<br/>"; print_r(@$mobile_number);
        echo "<br/><hr/><br/>mercName:<br/>"; print_r(@$mercName);
        echo "<br/><hr/><br/>";
    }

    if(!empty($qr_string)) echo "<img DONE_AJAX src=\"https://quickchart.io/chart?chs=160x160&cht=qr&chl={$qr_string}&choe=UTF-8\"  />";


}


if($vpaRequestPost==1 || $vpaEnqRequestPost==1 ) {
    $acquirer_set=0;
    $post['mop']='';
}

//Collect 

if($acquirer_set==831 || (isset($post['mop'])&&$post['mop']=='QRINTENT') )
 { //for QR dynamic code QR & INTENT 
    $Qrencryption = use_curl('http://15.207.116.247:8080/api/QR/encrypt');
    $QrencryptedData = trim(substr($Qrencryption, strlen('Encrypted Data: ')));
    $QrencryptedData=str_replace('"','',$QrencryptedData);

    $QrSignature = use_curl('http://15.207.116.247:8080/api/QR/sign');

    $QrUrl = $bank_url . "/upi/qr-generation";

    
    $qr_httpheader=array(
        'x-client-id: ' . $apc_get['x-client-id'],
        'x-client-secret: ' . $apc_get['x-client-secret'],
        'x-client-certificate: ' . $apc_get['x-client-certificate'],
        'x-api-interaction-id: ' . $postVpa['x-api-interaction-id'],
        'x-timestamp: ' . $postVpa['x-timestamp'],
        'Cookie: test',
        'Content-Type: application/json',
        'x-signature: ' . $QrSignature, // Interpolated variable
        'Authorization: Bearer '.@$authorizationBearer
    );

    if(isset($data['cqp'])&&$data['cqp']>0)
    {
        echo "<br/><hr/><br/><h3>QR CODE & INTENT</h3><br/>"; 
        echo "<br/><hr/><br/>QrUrl:<br/>"; print_r($QrUrl);
        echo "<br/><hr/><br/>QrencryptedData:<br/>"; print_r($QrencryptedData);
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
        CURLOPT_CUSTOMREQUEST => 'POST',
        CURLOPT_POSTFIELDS => json_encode(array(
            "Request" => array(
                "body" => array(
                    "encryptData" => "$QrencryptedData"
                )
            )
        )),
        CURLOPT_HTTPHEADER => $qr_httpheader,
    ));

    $response = curl_exec($curl);
    curl_close($curl);
    $QrResponse = json_decode($response,1);

    $tr_upd_order['qr_intent']=$QrUrl;
    $tr_upd_order['response_qr_intent']=(isset($QrResponse)&&is_array($QrResponse)?htmlTagsInArray($QrResponse):stf($response));

    if(isset($data['cqp'])&&$data['cqp']>0)
    {
        echo "<br/><hr/><br/><h3>RESPONSE OF QRCODE & INTENT.</h3><br/>"; 
        echo "<br/><hr/><br/>response:<br/>"; print_r(@$response);
        echo "<br/><hr/><br/>QrResponse:<br/>"; print_r(@$QrResponse);
        echo "<br/><hr/><br/>";
    }


    //QR Code & Intent Decode
    $qrCodeEncryptData = @$QrResponse['Response']['body']['encryptData'];

    // Construct the URL
    $url = "http://15.207.116.247:8080/api/QR/decrypt?encryptedData=" . urlencode(@$qrCodeEncryptData);

    // Use file_get_contents to make the request
    $response = file_get_contents($url);

    // Output the response
    //echo $response;

    //Merchant successfully onboarded
    $response_replace = str_replace("Decrypted Data: ","",$response);
    $decodeQrResponse = json_decode(@$response_replace,1);
    $tr_upd_order['decodeQrResponse']=@$decodeQrResponse;
        $qrString=$tr_upd_order['qrString']=@$decodeQrResponse['qrString'];
    $upiId=$tr_upd_order['upiId']=@$decodeQrResponse['upiId'];
    $extTransactionId=$tr_upd_order['extTransactionId']=@$decodeQrResponse['extTransactionId'];
    $qr_status=$tr_upd_order['qr_status']=@$decodeQrResponse['status'];

    $intent_process_include=1;
    $qr_intent_address=replace_space_tab_br_for_intent_deeplink($qrString,1);

    if(isset($data['cqp'])&&$data['cqp']>0)
    {
        echo "<br/><hr/><br/><h3>DECRYP AFTER RESPONSE OF QR CODE & INTENT.</h3><br/>"; 
        echo "<br/><hr/><br/>response:<br/>"; print_r(@$response);
        echo "<br/><hr/><br/>response_replace:<br/>"; print_r(@$response_replace);
        echo "<br/><hr/><br/>decodeQrResponse:<br/>"; print_r(@$decodeQrResponse);
        echo "<br/><hr/><br/>qrString:<br/>"; print_r(@$qrString);
        echo "<br/><hr/><br/>upiId:<br/>"; print_r(@$upiId);
        echo "<br/><hr/><br/>extTransactionId:<br/>"; print_r(@$extTransactionId);
        echo "<br/><hr/><br/>qr_status:<br/>"; print_r(@$qr_status);
        if(!empty($qrString)) echo "<img DONE_AJAX src=\"https://quickchart.io/chart?chs=160x160&cht=qr&chl={$qrString}&choe=UTF-8\"  />";
        echo "<br/><hr/><br/>";
    }

    trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);

    /*

    Decrypted Data: {"source":"SKYWALK001","sid":"LETSPE0014","terminalId":"","channel":"api","amount":"2.00","remark":"QR SIT testing","extTransactionId":"NPSTPAY225516776987","reciept":"https://google.com","type":"D","qrString":"upi://pay?ver=01&mode=15&am=2.00&cu=INR&pa=skp.skywalk001.letspe0014@cnrb&pn=SK PRIVATE LIMITED&mc=6012&tr=NPSTPAY225516776987&tn=QR SIT testing&mid=SKYWALK001&msid=LETSPE0014&mtid=&category=02&url=https://google.com","status":"SUCCESS","param1":"param1","param3":"param3","errorMsg":"","checksum":"","respCode":"0","requestTime":"2024-08-22 20:34:00","upiId":"skp.skywalk001.letspe0014@cnrb"}

    */
    
 }

elseif($acquirer_set==83 || (isset($post['mop'])&&$post['mop']=='UPICOLLECT') )
{ //for collect
    
    $Collectencryption = use_curl('http://15.207.116.247:8080/api/raiseCollect/encrypt');
    $CollectencryptedData = trim(substr($Collectencryption, strlen('Encrypted Data: ')));

    $CollectencryptedData=str_replace('"','',$CollectencryptedData);

    $CollectSignature = use_curl('http://15.207.116.247:8080/api/raiseCollect/sign');

    $RaiseCollectUrl = $bank_url . "/upi/raise-collect";


    $raisecolle_httpheader=array(
        'x-client-id: ' . $apc_get['x-client-id'],
        'x-client-secret: ' . $apc_get['x-client-secret'],
        'x-client-certificate: ' . $apc_get['x-client-certificate'],
        'x-api-interaction-id: ' . $postVpa['x-api-interaction-id'],
        'x-timestamp: ' . $postVpa['x-timestamp'],
        'Cookie: test',
        'Content-Type: application/json',
        'x-signature: ' . $CollectSignature, // Interpolated variable
        'Authorization: Bearer '.@$authorizationBearer
    );

    if(isset($data['cqp'])&&$data['cqp']>0)
    {
        echo "<br/><hr/><br/><h3>RAISE COLLET</h3><br/>"; 
        echo "<br/><hr/><br/>RaiseCollectUrl:<br/>"; print_r($RaiseCollectUrl);
        echo "<br/><hr/><br/>CollectencryptedData:<br/>"; print_r($CollectencryptedData);
        echo "<br/><hr/><br/>raisecolle_httpheader:<br/>"; print_r($raisecolle_httpheader);
        echo "<br/><hr/><br/>";
    }


    $curl = curl_init();

    curl_setopt_array($curl, array(
        CURLOPT_URL => $RaiseCollectUrl,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => '',
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 0,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => 'POST',
        CURLOPT_POSTFIELDS => json_encode(array(
            "Request" => array(
                "body" => array(
                    "encryptData" => "$CollectencryptedData"
                )
            )
        )),
        CURLOPT_HTTPHEADER => $raisecolle_httpheader,
    ));

    $response = curl_exec($curl);
    curl_close($curl);
    $collectResponse = json_decode($response,1);

    $json_arr_set['UPICOLLECT']='Y';
    $tr_upd_order['collectUrl']=$RaiseCollectUrl;
    $tr_upd_order['collectResponse'] =$collectResponse;


    if(isset($data['cqp'])&&$data['cqp']>0)
    {
        echo "<br/><hr/><br/><h3>RESPONSE OF COLLECT</h3><br/>"; 
        echo "<br/><hr/><br/>response:<br/>"; print_r(@$response);
        echo "<br/><hr/><br/>CollectResponse:<br/>"; print_r(@$collectResponse);
        echo "<br/><hr/><br/>tr_upd_order:<br/>"; print_r(@$tr_upd_order);
        echo "<br/><hr/><br/>";
    }

    
    //Collect Decode
    $collectEncryptData = @$collectResponse['Response']['body']['encryptData'];

    // Construct the URL
    $url = "http://15.207.116.247:8080/api/raiseCollect/decrypt?encryptedData=" . urlencode(@$collectEncryptData);

    // Use file_get_contents to make the request
    $response = file_get_contents($url);

    // Output the response
    //echo $response;

    //Merchant successfully onboarded
    $response_replace = str_replace("Decrypted Data: ","",$response);
    $decodeCollectResponse = json_decode(@$response_replace,1);
        $payee_vpa=$tr_upd_order['payee_vpa']=@$decodeCollectResponse['payee_vpa'];
    $upiId=$tr_upd_order['upiId']=@$decodeCollectResponse['upiId'];
    $extTransactionId=$tr_upd_order['extTransactionId']=@$decodeCollectResponse['extTransactionId'];
    $upiTxnId=$tr_upd_order['upiTxnId']=$tr_upd_order['acquirer_ref']=@$decodeCollectResponse['data'][0]['upiTxnId'];

   
    trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);

    if(isset($data['cqp'])&&$data['cqp']>0)
    {
        echo "<br/><hr/><br/><h3>DECRYP AFTER RESPONSE OF COLLECT</h3><br/>"; 
        echo "<br/><hr/><br/>response:<br/>"; print_r(@$response);
        echo "<br/><hr/><br/>response_replace:<br/>"; print_r(@$response_replace);
        echo "<br/><hr/><br/>decodeCollectResponse:<br/>"; print_r(@$decodeCollectResponse);
        echo "<br/><hr/><br/>payee_vpa:<br/>"; print_r(@$payee_vpa);
        echo "<br/><hr/><br/>upiId:<br/>"; print_r(@$upiId);
        echo "<br/><hr/><br/>extTransactionId:<br/>"; print_r(@$extTransactionId);
        echo "<br/><hr/><br/>upiTxnId:<br/>"; print_r(@$upiTxnId);
        
        echo "<br/><hr/><br/>";

        exit;
    }

    /*
        {
            "source": "SKYWALK001",
            "channel": "api",
            "terminalId": "",
            "extTransactionId": "Test123456778998",
            "upiId": "9568315028@paytm",
            "amount": "2.00",
            "customerName": "WELCOME HOTEL",
            "status": "SUCCESS",
            "responseTime": "2024-08-22 15:34:20",
            "checksum": "ed29e1f13892257a7d0475303b65bd05ce8d9ed889ffc292627f27835466aae7",
            "payee_vpa": "skp.skywalk001.letspe0014@cnrb",
            "remark": "Merchant to Payment",
            "sid": "LETSPE0014",
            "data": [
                {
                    "respCode": "0",
                    "respMessge": "Collect request initiated successfully",
                    "upiTxnId": "CANCA9D765783294011905314097DF6CE2C",
                    "txnTime": "Thu Aug 22 15:34:20 IST 2024"
                }
            ]
        }
    */

   
 }


?>