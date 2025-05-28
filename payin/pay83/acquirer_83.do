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

$vpaRequestPost=0;

if(isset($_REQUEST['vpaRequestPost'])&&$_REQUEST['vpaRequestPost']>0)   $vpaRequestPost=(int)@$_REQUEST['vpaRequestPost'];


$vpaEnqRequestPost=0;

if(isset($_REQUEST['vpaEnqRequestPost'])&&$_REQUEST['vpaEnqRequestPost']>0)   $vpaEnqRequestPost=(int)@$_REQUEST['vpaEnqRequestPost'];

$generatTokenPost=0;

if(isset($_REQUEST['generatTokenPost'])&&$_REQUEST['generatTokenPost']>0)   $generatTokenPost=(int)@$_REQUEST['generatTokenPost'];

$refreshTokenPost=0;

if(isset($_REQUEST['refreshTokenPost'])&&$_REQUEST['refreshTokenPost']>0)   $refreshTokenPost=(int)@$_REQUEST['refreshTokenPost'];
if(isset($_REQUEST['stopRefreshTokenPost'])&&$_REQUEST['stopRefreshTokenPost']>0)   $refreshTokenPost=0;


##########################################################

$javaUrl="http://15.207.116.247:8080";

if($data['localhosts']==true){
    $javaUrl="http://localhost:8091";
    //$javaUrl="http://192.168.1.10:8091";
}


##########################################################

// Prepare POST data for token request
$tokenPost['grant_type'] = $apc_get['grant_type'];
$tokenPost['redirect_uri'] = "https://can-webhook.web1.one/payin/pay83/webhookhandler_83";//$apc_get['redirect_uri'];
$tokenPost['state'] = $apc_get['state'];
$tokenPost['scope'] = @$apc_get['scope'];
$tokenPost['code'] = @$apc_get['code'];
//$tokenPost['code'] = "N4IrZQ8pKoWWnrFvPQir29rnl3f30MZZ"; // Replace with actual value if needed
@$authorizationBearer=''; // Replace with actual value if needed for Bearer n2pfYJdeu2nhj66ut6mIoccOBnqmIROw


//if acquier table 
if(isset($apc_get['bearer'])&&!empty($apc_get['bearer']))
    @$authorizationBearer=$apc_get['bearer'];


    if(isset($data['cqp'])&&$data['cqp']>0)
    {
        echo "<br/><hr/><br/><h3>ACQUIRER KEY</h3><br/>"; 
        echo "<br/><hr/><br/><b>transID</b>:<br/>"; print_r(@$transID);
        echo "<br/><hr/><br/>code:<br/>"; print_r(@$tokenPost['code']);
        echo "<br/><hr/><br/>Authorization Bearer:<br/>"; print_r(@$authorizationBearer);
        echo "<br/><hr/><br/>tokenPost:<br/>"; print_r(@$tokenPost);
        echo "<br/><hr/><br/>apc_get:<br/>"; print_r(@$apc_get);
        echo "<br/><hr/><br/>";
    }


    ################################################################

    //Get Access Token from table of Token 

    if(!isset($apc_get['refresh_token'])) 
    {
            
        $token_table_db=select_tablef(" `acquirer_id`='83' ",'token_table',0,1,"`access_token`,`refresh_token`,`previous_access_token`,`previous_refresh_token`,`code`,`updated_date`");

        if(isset($data['cqp'])&&$data['cqp']>0)
        {
        echo "<br/><hr/><br/><h3>GET TOKEN TABLE DB QUERY=></h3><br/>"; 
        print_r(@$token_table_db);
        }

        if(isset($token_table_db)&&is_array($token_table_db))
        {
            if(isset($data['cqp'])&&$data['cqp']>0)
            echo "<br/><hr/><br/><h4>code=></h4>".@$token_table_db['code'];

            if(isset($token_table_db['code'])) unset($token_table_db['code']);
            @$apc_get=array_merge(@$apc_get,@$token_table_db);
        }

            
        //if token table for authorization bearer
        if(isset($apc_get['access_token'])&&!empty($apc_get['access_token']))
        @$authorizationBearer=$apc_get['access_token'];

        if(isset($data['cqp'])&&$data['cqp']>0)
        {
            echo "<br/><hr/><br/><h4>APC GET=></h4>"; print_r(@$apc_get);
            echo "<br/><hr/><br/><h4>access_token=></h4>"; print_r(@$apc_get['access_token']);
            echo "<br/><hr/><br/><h4>refresh_token=></h4>"; print_r(@$apc_get['refresh_token']);
            echo "<br/><hr/><br/><h4>authorizationBearer=></h4>"; print_r(@$authorizationBearer);
        }
    }
    ################################################################


     // Extract refresh token and other data
    $refresh_token = @$apc_get['refresh_token']; //"9Gzi4dV9zxV5AcQzicIXlImwNOYG0FVi"; //$tokenResponse['refresh_token'];


    $tokenString = http_build_query($tokenPost);

    $userName = $apc_get['Username'];
    $password = $apc_get['Password'];

    $credentials = base64_encode($userName . ':' . $password);

    //$tokenUrl = $bank_url . "/oauth2/token";

    $header = array(
        'Content-Type: application/x-www-form-urlencoded',
        'Authorization: Basic ' . $credentials
    );

    // Vpa_creation variable 
    
    ############################################################################################# 
    $postVpa['x-client-id'] = $apc_get['x-client-id'];
    $postVpa['x-client-secret'] = $apc_get['x-client-secret'];
    $postVpa['x-client-certificate'] = $apc_get['x-client-certificate'];
    $postVpa['x-api-interaction-id'] = rand();
    $postVpa['x-timestamp'] =time();
    $postVpa['Cookie'] = "test";


//if($vpaRequestPost==1 || $vpaEnqRequestPost==1 )
{   
    //Generate Token for 24 Hours
    if($generatTokenPost==1)
    {
        $tokenUrl = "https://apibanking.canarabank.in/v1/oauth2/token";

        if(isset($data['cqp'])&&$data['cqp']>0)
        {
            echo "<br/><hr/><br/><h3>ACCESS TOKEN</h3><br/>"; 
            echo "<br/><hr/><br/>tokenUrl:<br/>"; print_r(@$tokenUrl);
            echo "<br/><hr/><br/>tokenString:<br/>"; print_r(@$tokenString);
            //echo "<br/><hr/><br/>header:<br/>"; print_r(@$header);
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

        $tr_upd_order['tokenUrl'] = $tokenUrl;
        $tr_upd_order['tokenPost'] = $tokenString;
        $tr_upd_order['tokenResponse'] = (isset($tokenResponse)&&is_array($tokenResponse)?htmlTagsInArray($tokenResponse):stf($response));
        trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);

        if(isset($data['cqp'])&&$data['cqp']>0)
        {
            echo "<br/><hr/><br/>Token response:<br/>"; print_r(@$response);
            echo "<br/><hr/><br/>tokenResponse:<br/>"; print_r(@$tokenResponse);
            echo "<br/><hr/><br/>";
        }

        ##############################################################################

        // Update token in token table 

        


        if(isset($tokenResponse['access_token'])&&trim($tokenResponse['access_token'])) $access_token=@$tokenResponse['access_token'];
        if(isset($tokenResponse['refresh_token'])&&trim($tokenResponse['refresh_token'])) $refresh_token=@$tokenResponse['refresh_token'];


        $code=@$apc_get['code'];
        $previous_access_token=@$apc_get['bearer'];
        $previous_refresh_token=@$apc_get['refresh_token'];

        $updated_date=@micro_current_date();

        ##############################################################################

        $token_table_update="`access_token`='{$access_token}', `refresh_token`='{$refresh_token}', `transID`='{$transID}', `code`='{$code}', `previous_access_token`='{$previous_access_token}', `previous_refresh_token`='{$previous_refresh_token}', `updated_date`='{$updated_date}'";


        echo "<br/><hr/><br/><h3>TOKEN TABLE UPDATE QUERY=></h3><br/>"; print_r($token_table_update);

        if(@$data['pq']){

            echo "<br/><br/><hr/>";
        }


        ##############################################################################

        $data['token_table']='token_table';
        if(!empty($access_token)&&trim($access_token)&&!empty($refresh_token)&&trim($refresh_token))
        {
            db_query(
                "UPDATE `{$data['DbPrefix']}{$data['token_table']}`".
                " SET ".$token_table_update.
                " WHERE `acquirer_id`='83'",$data['cqp']
            );
        }

        ##############################################################################

    }


    //Refresh Token for 30 days and save the refresh_token 
    if($refreshTokenPost==1)
    {
        // token refresh
        #####################################################################################
    
        $Grand_type = "refresh_token";

        //if(isset($tokenResponse['refresh_token'])&&!empty($tokenResponse['refresh_token'])) $refresh_token = @$tokenResponse['refresh_token'];

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

        $RtokenResponse = json_decode($response,1);


        $tr_upd_order['tokenRefreshUrl'] = $tokenRefreshUrl;
        $tr_upd_order['refrestokenPost'] = $RtokenString;
        $tr_upd_order['RtokenResponse'] = (isset($RtokenResponse)&&is_array($RtokenResponse)?htmlTagsInArray($RtokenResponse):stf($response));


        //retrun response via cron instance 
        $previousTokenRes['code']=@$apc_get['code'];
        $previousTokenRes['access_token']=@$apc_get['bearer'];
        $previousTokenRes['refresh_token']=@$apc_get['refresh_token'];

        $return_response_arr['tokenRefreshUrl']=@$tokenRefreshUrl;
        //$return_response_arr['RtokenString']=@$RtokenString;
        $return_response_arr['RtokenResponse'] = (isset($RtokenResponse)&&is_array($RtokenResponse)?htmlTagsInArray($RtokenResponse):stf($response));

        $return_response_arr['previousTokenRes']=@$previousTokenRes;

        $tr_upd_order['cronResponse'] = $return_response_arr;


        trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);

        if(isset($RtokenResponse['access_token'])&&trim($RtokenResponse['access_token'])){
            @$authorizationBearer=$tr_upd_order['refresTokenBearer']=$RtokenResponse['access_token'];
            
        }


        if(isset($data['cqp'])&&$data['cqp']>0)
        {
            echo "<br/><hr/><br/>REFRESH TOKEN response:<br/>"; print_r(@$response);
            if(isset($RtokenResponse['access_token'])&&trim($RtokenResponse['access_token'])) echo "<br/><hr/><br/>REFRESH TOKEN Bearer:<br/>".@$authorizationBearer ;
            echo "<br/><hr/><br/>";
        }

        

    }
    

}

// VPA Post
if($vpaRequestPost==1)
{

    echo "<div class='alert alert-success alert-dismissible'><strong>transID : </strong>$transID</div>";

    $subQueryReq=[];
    $subQueryReq['sid']=@$apc_get['sid'];
    $subQueryReq['mid']=@$apc_get['mid'];
    $subQueryReq['error_skip']='error_skip';

    $subQueryReq['sid']=@$apc_get['sid'];
    if(isset($_REQUEST['sid'])&&trim($_REQUEST['sid']))   $subQueryReq['sid']=@$_REQUEST['sid'];
    $subQueryReq['mid']=@$apc_get['mid'];
    if(isset($_REQUEST['mid'])&&trim($_REQUEST['mid']))   $subQueryReq['mid']=@$_REQUEST['mid'];

    $subQueryReq['account_number']=@$apc_get['account_number'];
    if(isset($_REQUEST['account_number'])&&trim($_REQUEST['account_number']))   $subQueryReq['account_number']=@$_REQUEST['account_number'];
    $subQueryReq['mobile_number']=@$apc_get['mobile_number'];
    if(isset($_REQUEST['mobile_number'])&&trim($_REQUEST['mobile_number']))   $subQueryReq['mobile_number']=@$_REQUEST['mobile_number'];
    $subQueryReq['company_name']=@$apc_get['company_name'];
    if(isset($_REQUEST['company_name'])&&trim($_REQUEST['company_name']))   $subQueryReq['company_name']=@$_REQUEST['company_name'];
    $subQueryReq['bank_name']=@$apc_get['bank_name'];
    if(isset($_REQUEST['bank_name'])&&trim($_REQUEST['bank_name']))   $subQueryReq['bank_name']=@$_REQUEST['bank_name'];
    $subQueryReq['mcc']=@$apc_get['mcc'];
    if(isset($_REQUEST['mcc'])&&trim($_REQUEST['mcc']))   $subQueryReq['mcc']=@$_REQUEST['mcc'];
    $subQueryReq['ifsc_code']=@$apc_get['ifsc_code'];
    if(isset($_REQUEST['ifsc_code'])&&trim($_REQUEST['ifsc_code']))   $subQueryReq['ifsc_code']=@$_REQUEST['ifsc_code'];
    $subQueryReq['checksum']=@$apc_get['checksum'];
    if(isset($_REQUEST['checksum'])&&trim($_REQUEST['checksum']))   $subQueryReq['checksum']=@$_REQUEST['checksum'];

    $subQueryStr=http_build_query($subQueryReq);

    $vpaEncryptionUrl=$javaUrl.'/api/encryption/encrypt?'.$subQueryStr;
    $encryption = use_curl($vpaEncryptionUrl);
    $encryptedData = trim(substr($encryption, strlen('Encrypted Data: ')));

    $vpaEncSignatureUrl=$javaUrl.'/api/encryption/sign?'.$subQueryStr;
    $VpaEnqSignature = use_curl($vpaEncSignatureUrl); 


    $tr_upd_order['vpaEncryptionUrl']=@$vpaEncryptionUrl;
    $tr_upd_order['encryptedData']=$javaUrl.'/api/encryption/decrypt?encryptedData='.$encryptedData;

    $tr_upd_order['vpaEncSignatureUrl']=$vpaEncSignatureUrl;
    $tr_upd_order['VpaEnqSignature']=$VpaEnqSignature;


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

    
     //VPA Decode

     $VpaResDecrypt = $VpaResponse['Response']['body']['encryptData'];

     // Construct the URL
     $url = $javaUrl.'/api/VpaEncryption/decrypt?encryptedData=' . urlencode(@$VpaResDecrypt);
 
     // Use file_get_contents to make the request
     $response = file_get_contents($url);
 
     // Output the response
     //echo $response;
 
     //Merchant successfully onboarded
     $response_replace = str_replace("Decrypted Data: ","",$response);
     $decodeVpaPostResponse = json_decode(@$response_replace,1);
         $batch_id=$tr_upd_order['batch_id']=$apc_get['batch_id']=@$decodeVpaPostResponse['response']['batch_id'];
     $vpa_respMessge=$tr_upd_order['vpa_respMessge']=@$decodeVpaPostResponse['respMessge'];
     $vpa_status=$tr_upd_order['vpa_status']=@$decodeVpaPostResponse['status'];
    
     echo "<div class='alert alert-info alert-dismissible'><strong>VPA DECODE : </strong> $response_replace </div>";

     if(isset($batch_id)&&!empty($batch_id)&&trim($batch_id))
     {
        $vpaEnqRequestPost=1;
        echo "<div class='alert alert-success alert-dismissible'><strong>Success!</strong> Batch ID : $batch_id | Response Message : $vpa_respMessge </div>";
     } 
    
 
     $tr_upd_order['VpaDecUrl']=@$url;
     $tr_upd_order['decodeVpaPostResponse']=@$decodeVpaPostResponse;


    trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);

    if(isset($data['cqp'])&&$data['cqp']>0)
    {
        echo "<br/><hr/><br/>Vpa response:<br/>"; print_r(@$response);
        echo "<br/><hr/><br/>VpaResponse:<br/>"; print_r(@$VpaResponse);

        echo "<br/><hr/><br/>VpaDecUrl:<br/>"; print_r(@$url);
        echo "<br/><hr/><br/>decodeVpaPostResponse:<br/>"; print_r(@$decodeVpaPostResponse);

        echo "<br/><hr/><br/>";
    }

}

// VPA Enq.
if($vpaEnqRequestPost==1)
{

    
    $subQueryReq=[];
    $subQueryReq['sid']=@$apc_get['sid'];
    $subQueryReq['mid']=@$apc_get['mid'];

    
    $subQueryReq['sid']=@$apc_get['sid'];
    if(isset($_REQUEST['sid'])&&trim($_REQUEST['sid']))   $subQueryReq['sid']=@$_REQUEST['sid'];
    $subQueryReq['mid']=@$apc_get['mid'];
    if(isset($_REQUEST['mid'])&&trim($_REQUEST['mid']))   $subQueryReq['mid']=@$_REQUEST['mid'];
    

    $subQueryReq['batch_id']=@$apc_get['batch_id'];
    $subQueryReq['error_skip']='error_skip';
    if(isset($_REQUEST['batch_id'])&&trim($_REQUEST['batch_id']))   $subQueryReq['batch_id']=@$_REQUEST['batch_id'];

    

    $subQueryStr=http_build_query($subQueryReq);

    ###################################################################################################
    // Vpa Enquiry Request
    $vpaEncryptionUrl=$javaUrl.'/api/VpaEncryption/encrypt?'.$subQueryStr;
    $Vpaencryption = use_curl($vpaEncryptionUrl);
    $VpaencryptedData = trim(substr($Vpaencryption, strlen('Encrypted Data: ')));
    $VpaencryptedData=str_replace('"','',$VpaencryptedData);

    $vpaSignatureUrl=$javaUrl.'/api/VpaEncryption/sign?'.$subQueryStr;
    $VpaSignatureEnq = use_curl($vpaSignatureUrl);

    $VpaEnqUrl = $bank_url . "/upi/vpa-creation-enq";


    $tr_upd_order['vpaEncryptionUrl']=@$vpaEncryptionUrl;
    $tr_upd_order['VpaencryptedData']=@$VpaencryptedData;

    $tr_upd_order['vpaSignatureUrl']=@$vpaSignatureUrl;
    $tr_upd_order['VpaSignatureEnq']=@$VpaSignatureEnq;

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
        echo "<br/><hr/><br/>vpaEncryptionUrl:<br/>"; print_r($vpaEncryptionUrl);
        echo "<br/><hr/><br/>VpaencryptedData:<br/>"; print_r($VpaencryptedData);

        echo "<br/><hr/><br/>vpaSignatureUrl:<br/>"; print_r($vpaSignatureUrl);
        echo "<br/><hr/><br/>VpaSignatureEnq:<br/>"; print_r($VpaSignatureEnq);

        echo "<br/><hr/><br/>VpaEnqUrl:<br/>"; print_r($VpaEnqUrl);
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



    //VPA Decode

    // Construct the URL
    $url = $javaUrl.'/api/VpaEncryption/decrypt?encryptedData=' . urlencode(@$vpaEnqEncryptData);

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
        $error_desc=@$decodeVpaEnqResponse['response']['error_desc'];

    $tr_upd_order['decodeVpaEnqUrl']=@$url;
    $tr_upd_order['decodeVpaEnqResponse']=@$decodeVpaEnqResponse;
    trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);


    echo "<div class='alert alert-info alert-dismissible'><strong>VPA ENQ. DECODE : </strong> $response_replace </div>";

     if(isset($qr_string)&&!empty($qr_string)&&trim($qr_string))
     {
        
        echo "<div class='alert alert-success alert-dismissible'><strong>Success!</strong> upiId : $upiId | qr_string : $qr_string  | mobile_number : $mobile_number </div>";
     } 

     elseif(isset($error_desc)&&!empty($error_desc)&&trim($error_desc))
     {
        
        echo "<div class='alert alert-danger alert-dismissible'><strong>Error!</strong> $error_desc </div>";
     } 

    if(isset($data['cqp'])&&$data['cqp']>0)
    {
        echo "<br/><hr/><br/><h3>DECRYP AFTER RESPONSE OF VPA ENQ.</h3><br/>"; 
        echo "<br/><hr/><br/>response:<br/>"; print_r(@$response);
        echo "<br/><hr/><br/>response_replace:<br/>"; print_r(@$response_replace);
        echo "<br/><hr/><br/>decodeVpaEnqUrl:<br/>"; print_r(@$url);
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


// QR & INTENT 

if($acquirer_set==831 || (isset($post['mop'])&&$post['mop']=='QRINTENT') )
 { //for QR dynamic code QR & INTENT 

    // {"sid":"LETSPE0014","mid":"SKYWALK001","upiId":"skp.skywalk001.letspe0014@cnrb"}

    //sid=LETSPE0014&mid=SKYWALK001&upiId=skp.skywalk001.letspe0014@cnrb&requestTime=2024-08-23 16:3:00&dba=QrRequest&amount=25.02&transID=NPSTPAY83131070346628
    $subQueryReq=[];
    $subQueryReq['sid']=@$apc_get['sid'];
    $subQueryReq['mid']=@$apc_get['mid'];
    $subQueryReq['upiId']=@$apc_get['upiId'];
    $subQueryReq['requestTime']=date('Y-m-d H:i:s');
    $subQueryReq['dba']=@$remark;
    $subQueryReq['transID']='NPSTPAY'.@$transID;
    $subQueryReq['amount']=@$total_payment;

    $subQueryStr=http_build_query($subQueryReq);

    $QrEncryptionUrl=$javaUrl.'/api/QR/encrypt?'.@$subQueryStr;
    $Qrencryption = use_curl($QrEncryptionUrl);
    $QrencryptedData = trim(substr($Qrencryption, strlen('Encrypted Data: ')));
    $QrencryptedData=str_replace('"','',$QrencryptedData);

    $QrSignatureUrl=$javaUrl.'/api/QR/sign?'.@$subQueryStr; 
    $QrSignature = use_curl($QrSignatureUrl);

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

        echo "<br/><hr/><br/>QrEncryptionUrl:<br/>"; print_r($QrEncryptionUrl);
        echo "<br/><hr/><br/>QrencryptedData:<br/>"; print_r($QrencryptedData);
       
        echo "<br/><hr/><br/>QrSignatureUrl:<br/>"; print_r($QrSignatureUrl);
        echo "<br/><hr/><br/>QrSignature:<br/>"; print_r($QrSignature);

        echo "<br/><hr/><br/>QrUrl:<br/>"; print_r($QrUrl);
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

    $tr_upd_order['QrEncryptionUrl']=$QrEncryptionUrl;
    $tr_upd_order['QrencryptedData']=$javaUrl.'/api/QR/decrypt?encryptedData='.$QrencryptedData;

    $tr_upd_order['QrSignatureUrl']=$QrSignatureUrl;
    $tr_upd_order['QrSignature']=$QrSignature;

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
    $url = $javaUrl.'/api/QR/decrypt?encryptedData=' . urlencode(@$qrCodeEncryptData);

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

    if(isset($QrResponse['httpCode'])&&in_array($QrResponse['httpCode'],["401"])&&isset($QrResponse['moreInformation']))
    {
        $error_description=@$QrResponse['moreInformation'];
        $_SESSION['acquirer_response']=$error_description;
        $tr_upd_order1['error']=$error_description;
        $tr_upd_order1['trans_response']=$error_description;

        db_trf($_SESSION['tr_newid'], 'trans_response', $error_description);
        echo 'Error for '.@$error_description;exit; 
    }

    /*

    Decrypted Data: {"source":"SKYWALK001","sid":"LETSPE0014","terminalId":"","channel":"api","amount":"2.00","remark":"QR SIT testing","extTransactionId":"NPSTPAY225516776987","reciept":"https://google.com","type":"D","qrString":"upi://pay?ver=01&mode=15&am=2.00&cu=INR&pa=skp.skywalk001.letspe0014@cnrb&pn=SK PRIVATE LIMITED&mc=6012&tr=NPSTPAY225516776987&tn=QR SIT testing&mid=SKYWALK001&msid=LETSPE0014&mtid=&category=02&url=https://google.com","status":"SUCCESS","param1":"param1","param3":"param3","errorMsg":"","checksum":"","respCode":"0","requestTime":"2024-08-22 20:34:00","upiId":"skp.skywalk001.letspe0014@cnrb"}

    */
    
 }

elseif($acquirer_set==83 || (isset($post['mop'])&&$post['mop']=='UPICOLLECT') )
{ //for collect
    
        
    $requestPost['vpa']=@$post['upi_address'];
    if(isset($post['upi_address_suffix'])&&$post['upi_address_suffix']) $requestPost['vpa'].=@$post['upi_address_suffix'];
    $tr_upd_order['upa']=@$requestPost['vpa'];

    $subQueryReq=[];
    $subQueryReq['sid']=@$apc_get['sid'];
    $subQueryReq['mid']=@$apc_get['mid'];
    $subQueryReq['upiId']=@$apc_get['upiId'];
    $subQueryReq['requestTime']=date('Y-m-d H:i:s');
    $subQueryReq['dba']=@$remark;
    $subQueryReq['transID']='NPSTPAY'.@$transID;
    $subQueryReq['amount']=@$total_payment;
        $subQueryReq['fullname']=@$post['fullname'];
        $subQueryReq['vpa']=@$requestPost['vpa'];

    $subQueryStr=http_build_query($subQueryReq);


    $collectEncryptionUrl = $javaUrl.'/api/raiseCollect/encrypt?'.@$subQueryStr;
    $Collectencryption = use_curl($collectEncryptionUrl);
    $CollectencryptedData = trim(substr($Collectencryption, strlen('Encrypted Data: ')));
    $CollectencryptedData=str_replace('"','',$CollectencryptedData);

    $collectSignatureUrl = $javaUrl.'/api/raiseCollect/sign?'.@$subQueryStr;
    $CollectSignature = use_curl($collectSignatureUrl);

    $RaiseCollectUrl = $bank_url . "/upi/raise-collect";

    $tr_upd_order['collectEncryptionUrl']=$collectEncryptionUrl;
    $tr_upd_order['CollectencryptedData']=$javaUrl.'/api/raiseCollect/decrypt?encryptedData='.$CollectencryptedData;

    $tr_upd_order['collectSignatureUrl']=$collectSignatureUrl;
    $tr_upd_order['CollectSignature']=$CollectSignature;

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
        echo "<br/><hr/><br/>collectEncryptionUrl:<br/>"; print_r($collectEncryptionUrl);
        echo "<br/><hr/><br/>CollectencryptedData:<br/>".$javaUrl.'/api/raiseCollect/decrypt?encryptedData='.$CollectencryptedData;

        echo "<br/><hr/><br/>collectSignatureUrl:<br/>"; print_r($collectSignatureUrl);
        echo "<br/><hr/><br/>CollectSignature:<br/>"; print_r($CollectSignature);

        echo "<br/><hr/><br/>RaiseCollectUrl:<br/>"; print_r($RaiseCollectUrl);
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
    $url = $javaUrl.'/api/raiseCollect/decrypt?encryptedData=' . urlencode(@$collectEncryptData);

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