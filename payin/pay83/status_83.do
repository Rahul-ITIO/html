<?
$is_curl_on=1;
$qr=0;

$javaUrl="http://15.207.116.247:8080";



if(isset($_REQUEST['qr'])){
    $qr=$_REQUEST['qr'];
}
if(isset($_REQUEST['pq'])){
    $pq=$qr=$_REQUEST['pq'];
}


if(!isset($data['STATUS_ROOT'])){
    include('../../config_db.do');

    //Webhook 
    if(isset($_REQUEST['action'])&&$_REQUEST['action']=='webhook')
    {
        $str_file_get=file_get_contents("php://input");
        $res_json_decode = json_decode($str_file_get,true);


        ##############################################################################

            //QR Code & Intent Decode
        $qrCodeEncryptData = @$res_json_decode['Request']['body']['encryptData'];

        if(isset($data['cqp'])&&$data['cqp']>0 || isset($qr)&&$qr )
        {
            echo "<br/><hr/><br/><h3>GET PHP INPUT VIA WEBHOOK</h3><br/>"; 
            echo "<br/><hr/><br/>str_file_get:<br/>"; print_r(@$str_file_get);
            echo "<br/><hr/><br/>res_json_decode:<br/>"; print_r(@$res_json_decode);
            echo "<br/><hr/><br/>qrCodeEncryptData:<br/>"; print_r(@$qrCodeEncryptData);
           
            echo "<br/><hr/><br/>";

        }

        // Construct the URL
        $url = $javaUrl.'/api/QR/decrypt?encryptedData=' . urlencode(@$qrCodeEncryptData);

        // Use file_get_contents to make the request
        $response = file_get_contents($url);

        // Output the response
        //echo $response;

        //Merchant successfully onboarded
        $response_replace = str_replace("Decrypted Data: ","",$response);
        $decodeQrResponse = json_decode(@$response_replace,1);

        if(isset($decodeQrResponse['Request']['body']['encryptData'])&&is_array($decodeQrResponse['Request']['body']['encryptData'])) $decodeQrResponse = @$decodeQrResponse['Request']['body']['encryptData'];

            $qr_status=$tr_upd_order['qr_status']=@$decodeQrResponse['status'];
            $customer_vpa=$tr_upd_order['customer_vpa']=@$decodeQrResponse['customer_vpa'];
            $rrn=$tr_upd_order['rrn']=@$decodeQrResponse['rrn'];
        $txnId=$tr_upd_order['txnId']=@$decodeQrResponse['txnId'];
        $amount=$tr_upd_order['amount']=@$decodeQrResponse['amount'];
        $extTransactionId=$tr_upd_order['extTransactionId']=@$decodeQrResponse['extTransactionId'];
        $customerName=$tr_upd_order['customerName']=@$decodeQrResponse['customerName'];
        $responseTime=$tr_upd_order['responseTime']=@$decodeQrResponse['responseTime'];
        

       

        if(isset($data['cqp'])&&$data['cqp']>0 || isset($qr)&&$qr )
        {
            echo "<br/><hr/><br/><h3>DECRYP RESPONSE OF QR CODE & INTENT VIA WEBHOOK</h3><br/>"; 
            echo "<br/><hr/><br/>response:<br/>"; print_r(@$response);
            echo "<br/><hr/><br/>response_replace:<br/>"; print_r(@$response_replace);
            echo "<br/><hr/><br/>decodeQrResponse:<br/>"; print_r(@$decodeQrResponse);
                echo "<br/><hr/><br/>qr_status:<br/>"; print_r(@$qr_status);
            echo "<br/><hr/><br/>customer_vpa:<br/>"; print_r(@$customer_vpa);
            echo "<br/><hr/><br/>rrn:<br/>"; print_r(@$rrn);
            echo "<br/><hr/><br/>txnId:<br/>"; print_r(@$txnId);
            echo "<br/><hr/><br/>amount:<br/>"; print_r(@$amount);
            echo "<br/><hr/><br/>extTransactionId:<br/>"; print_r(@$extTransactionId);
            echo "<br/><hr/><br/>customerName:<br/>"; print_r(@$customerName);
            echo "<br/><hr/><br/>responseTime:<br/>"; print_r(@$responseTime);
            echo "<br/><hr/><br/>";

        }

        ##############################################################################


        $res = @$decodeQrResponse;
        
       // $data['logs']['php_input_0']=$str_file_get;
        $data['gateway_push_notify']=$decodeQrResponse;	
        
        if(isset($res['extTransactionId'])&&$res['extTransactionId'])
        {
            $is_curl_on = false;
            @$responseParamList=@$res;

            $_REQUEST['transID']=preg_replace("/[^0-9.]/", "",$res['extTransactionId']);

            if(isset($res['data'][0])&&@$res['data'][0])  @$responseParamList=@$res['data'][0];
            elseif(isset($res['data'])&&@$res['data'])  @$responseParamList=@$res['data'];

           
        }

        if(isset($data['cqp'])&&$data['cqp']>0 || isset($qr)&&$qr )
        {
            echo "<br/><hr/><br/><h3>TRANSID VIA WEBHOOK</h3><br/>"; 
            echo "<br/><hr/><br/>transID _REQUEST:<br/>"; print_r(@$_REQUEST['transID']);
            echo "<br/><hr/><br/>responseParamList:<br/>"; print_r(@$responseParamList);
            echo "<br/><hr/><br/>res:<br/>"; print_r(@$res);
           
            echo "<br/><hr/><br/>";

            if($qr==3) exit;

        }

    }

    include($data['Path'].'/payin/status_top'.$data['iex']);
}


//include($data['Path'].'/payin/status_in_email'.$data['iex']);


if(!empty($transID))
{

    $mopType=@$json_value['post']['mop'];
    if(empty(@$mopType)){
        $mopType=@$json_value['get']['mop'];
    }


    //if(isset($_SESSION['adm_login'])) $is_curl_on=1;

    if(@$is_curl_on)
    {

        
        if(isset($_REQUEST['qp'])&&$_REQUEST['qp']>0) $data['cqp']=1;
        elseif(isset($_REQUEST['pq'])&&$_REQUEST['pq']>0) $data['cqp']=1;
        elseif(isset($_REQUEST['dtest'])&&$_REQUEST['dtest']>0) $data['cqp']=1;
        

        ##########################################################

       


        ##########################################################

        // Prepare POST data for token request
        @$authorizationBearer=''; // Replace with actual value if needed for Bearer 

       
        if(isset($apc_get_al['bearer'])&&!empty($apc_get_al['bearer']))
            @$authorizationBearer=$apc_get_al['bearer'];

            if(isset($data['cqp'])&&$data['cqp']>0)
            {
                echo "<br/><hr/><br/><h3>STATUS - ACQUIRER KEY</h3><br/>"; 
                echo "<br/><hr/><br/><b>transID</b>:<br/>"; print_r(@$transID);
                echo "<br/><hr/><br/>Authorization Bearer:<br/>"; print_r(@$authorizationBearer);
                //echo "<br/><hr/><br/>apc_get:<br/>"; print_r(@$apc_get);
                echo "<br/><hr/><br/>";
            }

            
            
        ##########################################################


            
        ################################################################

        //Get Access Token from table of Token 

        if(!isset($apc_get_al['refresh_token'])) 
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
    
        

        if(empty($acquirer_status_url)||strtolower($acquirer_status_url)=='NA') $acquirer_status_url="https://uat-apibanking.canarabank.in/v1";

        // for collect 
        //https://uat-apibanking.canarabank.in/v1/upi/txnStatus
        
        // for qr & intent 
        //https://apibanking.canarabank.in/v1/upi/qrstatus-extid

        if(@$mopType=='QRINTENT') 
        $acquirer_status_url=$acquirer_status_url."/upi/qrstatus-extid";
        else $acquirer_status_url=$acquirer_status_url."/upi/txnStatus-extid";



        $subQueryReq=[];
        $subQueryReq['mid']=@$apc_get['mid'];
        $subQueryReq['sid']=@$apc_get['sid'];
        $subQueryReq['terminalId']='';
        $subQueryReq['extTransactionId']='NPSTPAY'.@$transID;

        $subQueryStr=http_build_query($subQueryReq);

       
        $statusEncryptionUrl=$javaUrl.'/api/Status/encrypt?'.@$subQueryStr;
        $encryption = use_curl($statusEncryptionUrl);
        $encryptedData = trim(substr($encryption, strlen('Encrypted Data: ')));
        $encryptedData=str_replace('"','',$encryptedData);

        //for Log
        $encryptedDataURL=$javaUrl.'/api/Status/decrypt?encryptedData='.@$encryptedData;

        $SignatureUrl=$javaUrl.'/api/Status/sign?'.@$subQueryStr; 
        $Signature = use_curl($SignatureUrl);

        

        
        $_httpheader=array(
            'x-client-id: ' . $apc_get['x-client-id'],
            'x-client-secret: ' . $apc_get['x-client-secret'],
            'x-client-certificate: ' . $apc_get['x-client-certificate'],
            'x-api-interaction-id: ' . rand(),
            'x-timestamp: ' . time(),
            'Cookie: test',
            'Content-Type: application/json',
            'x-signature: ' . $Signature, // Interpolated variable
            'Authorization: Bearer '.@$authorizationBearer
        );

        if(isset($data['cqp'])&&$data['cqp']>0)
        {
            echo "<br/><hr/><br/><h3>STATUS</h3><br/>"; 

            echo "<br/><hr/><br/>statusEncryptionUrl:<br/>"; print_r($statusEncryptionUrl);
            echo "<br/><hr/><br/>encryptedData:<br/>"; print_r($encryptedData);
            echo "<br/><hr/><br/>encryptedDataURL:<br/>"; print_r($encryptedDataURL);
        
            echo "<br/><hr/><br/>SignatureUrl:<br/>"; print_r($SignatureUrl);
            echo "<br/><hr/><br/>Signature:<br/>"; print_r($Signature);

            echo "<br/><hr/><br/>acquirer_status_url:<br/>"; print_r($acquirer_status_url);
            echo "<br/><hr/><br/>qr_httpheader:<br/>"; print_r($_httpheader);
            echo "<br/><hr/><br/>";
        }


        $curl = curl_init();

        curl_setopt_array($curl, array(
            CURLOPT_URL => $acquirer_status_url,
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
            CURLOPT_HTTPHEADER => $_httpheader,
        ));

        $response = curl_exec($curl);
        curl_close($curl);
        $Response = json_decode($response,1);

        $tr_upd_order['statusEncryptionUrl']=$statusEncryptionUrl;
        $tr_upd_order['encryptedData']=$javaUrl.'/api/Status/decrypt?encryptedData='.$encryptedData;

        $tr_upd_order['SignatureUrl']=$SignatureUrl;
        $tr_upd_order['Signature']=$Signature;

       

        if(isset($data['cqp'])&&$data['cqp']>0)
        {
            echo "<br/><hr/><br/><h3>RESPONSE OF STATUS.</h3><br/>"; 
            echo "<br/><hr/><br/>response:<br/>"; print_r(@$response);
            echo "<br/><hr/><br/>Response Array:<br/>"; print_r(@$Response);
            echo "<br/><hr/><br/>";
        }


        //Status Data Decode
        $statusDataDecode = @$Response['Response']['body']['encryptData'];

        // Construct the URL
        $url = $javaUrl.'/api/Status/decrypt?encryptedData=' . urlencode(@$statusDataDecode);

        // Use file_get_contents to make the request
        $response = file_get_contents($url);

        // Output the response
        //echo $response;

        //Merchant successfully onboarded decodeStatusResponse
        $response_replace = str_replace("Decrypted Data: ","",$response);
        $decodeStatusResponse = json_decode(@$response_replace,1);
        $tr_upd_order['decodeStatusResponse']=@$decodeStatusResponse;
            $qrString=$tr_upd_order['qrString']=@$decodeStatusResponse['qrString'];
        $upiId=$tr_upd_order['upiId']=@$decodeStatusResponse['upiId'];
        $extTransactionId=$tr_upd_order['extTransactionId']=@$decodeStatusResponse['extTransactionId'];
        $get_status=$tr_upd_order['get_status']=@$decodeStatusResponse['status'];

        if(isset($decodeStatusResponse['data'][0])&&@$decodeStatusResponse['data'][0])
        {
            @$responseParamList=$decodeStatusResponse['data'][0];
        }

        /*
            {
                "channel": "api",
                "terminalId": "",
                "extTransactionId": "NPSTPAY83131070442312",
                "checksum": "",
                "status": "SUCCESS",
                "txnType": "TXNSTATUS",
                "sid": "LETSPE0023",
                "mid": "SKYWALK001",
                "data": [
                    {
                        "customerName": "Arun Tech",
                        "respCode": "0",
                        "respMessge": "SUCCESS",
                        "upiTxnId": "CANA99F3531908947E6BF721710A917406A",
                        "txnTime": "2024-08-28 17:19:13.691",
                        "amount": "1.00",
                        "upiId": "7318314501@ybl",
                        "requestTime": "2024-08-28 17:18:12.552",
                        "custRefNo": "424165678225",
                        "remark": "83 - Canara Bank - UPI",
                        "payeeVpa": "skp.skywalk001.letspe0023@cnrb"
                    }
                ]
            }

        */

        if(isset($data['cqp'])&&$data['cqp']>0)
        {
            echo "<br/><hr/><br/><h3>STATUS DECRYP AFTER RESPONSE.</h3><br/>"; 
            echo "<br/><hr/><br/>statusDataDecode:<br/>"; print_r(@$url);
            echo "<br/><hr/><br/>response:<br/>"; print_r(@$response);
            echo "<br/><hr/><br/>response_replace:<br/>"; print_r(@$response_replace);
            echo "<br/><hr/><br/>decodeStatusResponse:<br/>"; print_r(@$decodeStatusResponse);
            echo "<br/><hr/><br/>qrString:<br/>"; print_r(@$qrString);
            echo "<br/><hr/><br/>upiId:<br/>"; print_r(@$upiId);
            echo "<br/><hr/><br/>extTransactionId:<br/>"; print_r(@$extTransactionId);
            echo "<br/><hr/><br/>get_status:<br/>"; print_r(@$get_status);
            echo "<br/><hr/><br/>";
        }
        


        if(@$qp)
        {
            
        }

        if(@$qp)
        {
            echo '<div type="button" class="btn btn-success my-2" style="background:#dddfff;color:#2c2c2c;padding:5px 10px;border-radius:2px;margin:10px auto;width:fit-content;display:block;max-width:99%;word-wrap:anywhere;">';

            
            echo "<br/>acquirer_status_url=>".@$acquirer_status_url;
            echo "<br/><br/>dataRequest=>". @$dataRequest;
            echo "<br/><br/>encryptedStatus=>\"". @$encryptedStatus.'"';

            echo "<br/><br/>headeRequest=>".@$headeRequest; 
            echo "<br/><br/>encryptedDataHeader=>". @$encryptedDataHeader;
            
            echo "<br/><br/>response=>".$response;
            
            echo '<br/><br/></div>';
        }

        
        if($http_status==503 || $http_status==500 || $http_status==403 || $http_status==400 || $http_status==404) {	//transaction stay as PENDING if received any one of the above error
            $err_msg = "Fino Bank :- HTTP Status == {$http_status}.";
            
            if($curl_errno) echo "<br/>Curl Errno returned $curl_errno.<br/>";
            
            $_SESSION['acquirer_response']		=$err_msg." - Pending";
            $_SESSION['acquirer_status_code']=1;
            $status_completed=false;
            
            //exit;
        }
        elseif($curl_errno){
            echo '<br/>Canara Bank :- Request Error: '.$curl_errno.' - ' . curl_error($handle);
            exit;
        }

        
                
        // response result 
        if(@$qp)
		{
			echo '<div type="button" class="btn btn-success my-2" style="background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;word-wrap:anywhere;">';
			//echo "res=>"; print_r($res);
			
			echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
			echo "<br/>acquirer status ['respMessge']=> ".@$responseParamList['respMessge'];
			//echo "<br/>acquirer message ['ResponseMessage']=> ".@$responseParamList['ResponseMessage'];

			echo "<br/><br/>acquirer amount ['amount']=> ".@$responseParamList['amount'];
			echo "<br/>acquirer UPA ['upiId']=> ".@$responseParamList['upiId'];
			echo "<br/>acquirer RRN ['custRefNo']=> ".@$responseParamList['custRefNo'];
			echo "<br/>acquirer VPA ['payeeVpa']=> ".@$responseParamList['payeeVpa'];

			
			//echo "<br/>response_json=> ".@$response_json;
			echo "<br/><br/>responseParamList=> "; print_r($responseParamList);

            echo "<br/><hr/><br/>statusDataDecode:<br/>"; print_r(@$url);
			
			//echo "<br/><br/>res=> ".htmlentitiesf(@$responseParamList);
			echo '<br/><br/></div>';
		}

    }

    $results = @$responseParamList;

    if(isset($responseParamList)&&count($responseParamList)>0)
    {


        //upa //rrn //acquirer_ref
        #######	upa, rrn, acquirer_ref update from status get :start 	###############
            
            //acquirer_ref_2	
            $acquirer_ref_2='';
            if(@$responseParamList['txnId']) $acquirer_ref_2= @$responseParamList['txnId'];
            //up acquirer_ref_2 : update if empty acquirer_ref and is txnId 
            if((empty(trim($td['acquirer_ref']))||$td['acquirer_ref']=='{}')&&!empty($acquirer_ref_2)){
                $tr_upd_status['acquirer_ref']=trim($acquirer_ref_2);
            }
            
           
            //upa =>upiId,customer_vpa
            $upa='';
            if(isset($responseParamList['customer_vpa'])&&@$responseParamList['customer_vpa']) $upa= @$responseParamList['customer_vpa'];	
            	
            //up upa : update if empty upa and is upiId 
            if(empty(trim($td['upa']))&&!empty($upa)){
                $tr_upd_status['upa']=trim($upa);
            }
                    
            
            //rrn 
            $rrn='';
            if(isset($responseParamList['rrn'])&&@$responseParamList['rrn']) $rrn= @$responseParamList['rrn'];		
            
            //up rrn : update if empty rrn and is RRN 
            if(empty(trim($td['rrn']))&&!empty($rrn)){
                $tr_upd_status['rrn']=trim($rrn);
            }
            
            
            if($qp){
                echo "<br/><br/><=upa=>".$upa;
                echo "<br/><br/><=acquirer_ref=>".$acquirer_ref;
                echo "<br/><br/><=rrn=>".$rrn;
                echo "<br/><br/><=tr_upd_status1=>";
                    print_r($tr_upd_status);
            }
            
            if(isset($tr_upd_status)&&count($tr_upd_status)>0&&is_array($tr_upd_status))
            {
                if($qp){
                    echo "<br/><br/><=tr_upd_status=>";
                    print_r($tr_upd_status);
                }
                
                trans_updatesf($td['id'], $tr_upd_status);
            }
            
        #######	upa, rrn, acquirer_ref update from status get :end 	###############



        $responseCode=$message='';

	    if(isset($responseParamList['amount'])) 
            $_SESSION['responseAmount']=$transactionAmount=$responseParamList['amount'];

	    if(isset($responseParamList['respMessge'])) 
		    $responseCode=$responseParamList['respMessge'];

	    elseif(isset($responseParamList['status'])) 
		    $responseCode=$responseParamList['status'];

	    

	   // elseif(isset($responseParamList['ResponseCode']))  $responseCode=$responseParamList['ResponseCode'];

	    if(isset($responseParamList['ResponseMessage'])&&trim($responseParamList['ResponseMessage'])) 
		$message=$responseParamList['ResponseMessage'];

        $_SESSION['acquirer_action']=1;
		//$_SESSION['acquirer_transaction_id']=$results2->transactionId;
		//$_SESSION['acquirer_descriptor']=@$acquirer_descriptor;
		
        /*
        echo "<br/>responseCode=>".$responseCode;
        echo "<br/><br/>responseParamList=>";
        print_r($responseParamList);
        exit;
        */

		if($responseCode=="SUCCESS")
		{ // success
			$_SESSION['acquirer_response']="Success";
			$_SESSION['acquirer_status_code']=2;
			
		}
        elseif($responseCode=="FAILURE")
        {	//failed 
			$_SESSION['acquirer_response']="Cancelled";
			$_SESSION['acquirer_status_code']=-1;
           
		}
       /*
		//elseif( ($responseCode=="FAILURE") && (isset($is_expired)&&$is_expired=='N') )
        {	//failed 
			//$_SESSION['acquirer_response']=$message." - Cancelled";
			//$_SESSION['acquirer_status_code']=-1;
            $_SESSION['acquirer_response']=$message." - Expired";
			$_SESSION['acquirer_status_code']=22;
		}
         
		else{ //pending
			$_SESSION['acquirer_response']=$message." - Pending";
			$status_completed=false;
			$_SESSION['acquirer_status_code']=1;
		}
        */
    }


}

if(!isset($data['STATUS_ROOT'])){
    include($data['Path'].'/payin/status_bottom'.$data['iex']);
}


?>