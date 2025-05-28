<?
$is_curl_on=true;

if(isset($_REQUEST['ClientTxnId'])){
    $_REQUEST['transID']=$_REQUEST['ClientTxnId'];
}

if(!isset($data['STATUS_ROOT'])){
    include('../../config_db.do');

    //Webhook 
    if(isset($_REQUEST['action'])&&$_REQUEST['action']=='webhook')
    {
        $str_file_get=file_get_contents("php://input");
        $res_json_decode = json_decode($str_file_get,true);
        $res = @$res_json_decode['CallBackResponse'];
        
        $data['logs']['php_input_0']=$str_file_get;
        $data['gateway_push_notify']=$res_json_decode;	
        
        if(isset($res['UPIRefID'])&&$res['UPIRefID'])
        {
            //$is_curl_on = false;
            @$responseParamList=@$res;
            $_REQUEST['transID']=preg_replace("/[^0-9.]/", "",$res['UPIRefID']);
        }
    }

    include($data['Path'].'/payin/status_top'.$data['iex']);
}


//include($data['Path'].'/payin/status_in_email'.$data['iex']);


if(!empty($transID))
{
    if($is_curl_on)
    {

        $headeRequest = '{
        "PartnerId":' . $apc_get['PartnerId'] . ',
        "AuthKey":"' . $apc_get['AuthKey'] . '"
        }';

        $passphrase = @$apc_get['Header_Encryption_Key'];


        abstract class CryptoJSAES {

            /**
             * @param      $data
             * @param      $passphrase
             * @param null $salt        ONLY FOR TESTING
             * @return string           encrypted data in base64 OpenSSL format
             */
            public static function encrypt($Request, $passphrase, $salt = null) {
                $salt = $salt ?: openssl_random_pseudo_bytes(8);
                list($key, $iv) = self::evpkdf($passphrase, $salt);

                $ct = openssl_encrypt($Request, 'aes-256-cbc', $key, true, $iv);

                return self::encode($ct, $salt);
            }

            /**
             * @param string $base64        encrypted data in base64 OpenSSL format
             * @param string $passphrase
             * @return string
             */
            public static function decrypt($base64, $passphrase) {
                if(!empty($base64))
                {
                    list($ct, $salt) = self::decode($base64);
                    list($key, $iv) = self::evpkdf($passphrase, $salt);

                    $Decryptdata = openssl_decrypt($ct, 'aes-256-cbc', $key, true, $iv);

                    return $Decryptdata;
                }
            }

            public static function evpkdf($passphrase, $salt) {
                $salted = '';
                $dx = '';
                while (strlen($salted) < 48) {
                    $dx = md5($dx . $passphrase . $salt, true);
                    $salted .= $dx;
                }
                $key = substr($salted, 0, 32);
                $iv = substr($salted, 32, 16);

                return [$key, $iv];
            }

            public static function decode($base64) {
                if(!empty($base64)){

                    $data = base64_decode(@$base64);

                    if (substr($data, 0, 8) !== "Salted__") {
                        throw new \InvalidArgumentException();
                    }

                    $salt = substr($data, 8, 8);
                    $ct = substr($data, 16);

                    return [$ct, $salt];
                }
            }

            public static function encode($ct, $salt) {
                return base64_encode("Salted__" . $salt . $ct);
            }
        }
        #################################################################################################################
        $encryptedDataHeader = CryptoJSAES::encrypt($headeRequest,  $passphrase);//header encrypted request
        $decryptedData = CryptoJSAES::decrypt($encryptedDataHeader,  $passphrase);

        
         $passphraseStatus = $apc_get['Encryption_Decryption_Key'];
        
        /*
        $dataRequest = '{
        "clientTxnId": "'.$transID.'",
        "serviceId": "9071",
        "mobileno": "919830093724",
        "referenceid": "FINOUPI640543"
        }';
        */

        if(!isset($apc_get['mobilenumber']) || empty($apc_get['mobilenumber'])) $apc_get['mobilenumber']='918788693162';

        $serviceId='9071';

       // if(@$acquirer==821) $serviceId='9061';
        

        $dataRequest = '{
        "clientTxnId": "'.$transID.'",
        "serviceId": "'.$serviceId.'",
        "mobileno": "'.@$apc_get['mobilenumber'].'",
        "referenceid": "FINOUPI'.$transID.'"
        }';


        

       
        $encryptedStatus = CryptoJSAES::encrypt($dataRequest, $passphraseStatus);//vpa encrypted request


        $curl = curl_init();

        curl_setopt_array($curl, array(
        CURLOPT_URL => trim($acquirer_status_url),
        
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => '',
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 0,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => 'POST',
        CURLOPT_POSTFIELDS =>'"'. $encryptedStatus.'"',
        CURLOPT_HTTPHEADER => array(
            'Authentication: '.$encryptedDataHeader,
            'Content-Type: application/json'
        ),
        ));

        $response = curl_exec($curl);
            $http_status	= curl_getinfo($curl, CURLINFO_HTTP_CODE);
            $curl_errno		= curl_errno($curl);
        curl_close($curl);
        // echo $response;

        if(@$qp)
        {
            
        }

        if(@$qp)
        {
            echo '<div type="button" class="btn btn-success my-2" style="background:#dddfff;color:#2c2c2c;padding:5px 10px;border-radius:2px;margin:10px auto;width:fit-content;display:block;max-width:99%;">';

            
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
            echo '<br/>Fino Bank :- Request Error: '.$curl_errno.' - ' . curl_error($handle);
            exit;
        }

        $responseParamList = jsondecode($response,1,1);	// covert response from json to array
      
        $responseData  =@$responseParamList['ResponseData'];

        // Decrypt the ResponseData
        $decryptedResponseData = CryptoJSAES::decrypt($responseData, $passphraseStatus);
        //echo "<hr/><br/>Decrypted decryptedResponseData:<br/> $decryptedResponseData\n";

        // covert ResponseData from json to array
        $responseData_array = json_decode_is($decryptedResponseData,1);	

        if(isset($responseData_array))
        {
            $responseParamList=array_merge($responseParamList,$responseData_array);
        }

        if(isset($responseParamList['ResponseData'])) unset($responseParamList['ResponseData']);
                
        // response result 
        if(@$qp)
		{
			echo '<div type="button" class="btn btn-success my-2" style="background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
			//echo "res=>"; print_r($res);
			
			echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
			echo "<br/>acquirer status ['transaction'][0]['status']=> ".@$responseParamList['transaction'][0]['status'];
			echo "<br/>acquirer message ['ResponseMessage']=> ".@$responseParamList['ResponseMessage'];

			echo "<br/><br/>acquirer amount ['transaction'][0]['amount']=> ".@$responseParamList['transaction'][0]['amount'];
			echo "<br/>acquirer VPA ['transaction'][0]['otherVpa']=> ".@$responseParamList['transaction'][0]['otherVpa'];
			echo "<br/>acquirer RRN ['transaction'][0]['customerReferenceId']=> ".@$responseParamList['transaction'][0]['customerReferenceId'];

			echo "<br/><br/>acquirer status ['ResponseData']=> ".@$decryptedResponseData;
			
			//echo "<br/>response_json=> ".@$response_json;
			echo "<br/><br/>responseParamList=> "; print_r($responseParamList);
			
			//echo "<br/><br/>res=> ".htmlentitiesf(@$responseParamList);
			echo '<br/><br/></div>';
		}

    }

    $results = @$responseParamList;

    if(isset($responseParamList)&&count($responseParamList)>0)
    {


        //upa //rrn //acquirer_ref
        #######	upa, rrn, acquirer_ref update from status get :start 	###############
            
           
            //upa =>upiId,customer_vpa
            $upa='';
            if(isset($responseParamList['transaction'][0]['otherVpa'])&&@$responseParamList['transaction'][0]['otherVpa']) $upa= @$responseParamList['transaction'][0]['otherVpa'];		
            elseif(isset($responseParamList['PayerVPA'])&&@$responseParamList['PayerVPA']) $upa= @$responseParamList['PayerVPA'];		
            //up upa : update if empty upa and is upiId 
            if(empty(trim($td['upa']))&&!empty($upa)){
                $tr_upd_status['upa']=trim($upa);
            }
                    
            
            //rrn 
            $rrn='';
            if(isset($responseParamList['transaction'][0]['customerReferenceId'])&&@$responseParamList['transaction'][0]['customerReferenceId']) $rrn= @$responseParamList['transaction'][0]['customerReferenceId'];		
            elseif(isset($responseParamList['RRN'])&&@$responseParamList['RRN']) $rrn= @$responseParamList['RRN'];
            
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

	    if(isset($responseParamList['transaction'][0]['amount'])) 
            $_SESSION['responseAmount']=$transactionAmount=$responseParamList['transaction'][0]['amount'];

	    if(isset($responseParamList['transaction'][0]['status'])) 
		    $responseCode=$responseParamList['transaction'][0]['status'];

	    elseif(isset($responseParamList['TxnStatus'])) 
		    $responseCode=$responseParamList['TxnStatus'];

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

		if($responseCode=="OK")
		{ // //success
			$_SESSION['acquirer_response']="Success";
			$_SESSION['acquirer_status_code']=2;
			
			//responseAmount
			if(isset($transactionAmount)&&!empty($transactionAmount))
				$_SESSION['responseAmount']	= $transactionAmount;
			
			
		}
        /*
		elseif( ($responseCode==1||$responseCode=="1") && (isset($is_expired)&&$is_expired=='N') ){	//failed 
			//$_SESSION['acquirer_response']=$message." - Cancelled";
			//$_SESSION['acquirer_status_code']=-1;
            $_SESSION['acquirer_response']=$message." - Expired";
			$_SESSION['acquirer_status_code']=22;
		}
        */
		else{ //pending
			$_SESSION['acquirer_response']=$message." - Pending";
			$status_completed=false;
			$_SESSION['acquirer_status_code']=1;
		}
    }


}

if(!isset($data['STATUS_ROOT'])){
    include($data['Path'].'/payin/status_bottom'.$data['iex']);
}


?>