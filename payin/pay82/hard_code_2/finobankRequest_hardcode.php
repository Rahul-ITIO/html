<?php
namespace Blocktrail\CryptoJSAES;
$qp=1;

error_reporting(E_ALL);

//  http://localhost:8080/gw/payin/pay82/hard_code_2/finobankRequest_hardcode?transID=82194518

    $transID='82194343';

    if(isset($_REQUEST['transID']))$transID=@$_REQUEST['transID'];

    $apc='{"Header_Encryption_Key":"982b0d01-b262-4ece-a2a2-45be82212ba1","PartnerId":"524","AuthKey":"f9f1da40-4f0a-473a-8693-c388301e95b7","Encryption_Decryption_Key":"97604492-a0bc-4d3e-82b5-6ad34bb5a32b","payeeVPA":"sky.dev@finobank","mobilenumber":"918303344556"}';
    
    $apc='{"Header_Encryption_Key":"982b0d01-b262-4ece-a2a2-45be82212ba1","PartnerId":"524","AuthKey":"f9f1da40-4f0a-473a-8693-c388301e95b7","Encryption_Decryption_Key":"97604492-a0bc-4d3e-82b5-6ad34bb5a32b","mobilenumber":"918788693162","payeeVPA":"sky.skywalk@finobank","pn":"SkywalkTechnology","tn":"skywalk+technology","tr":"FINOUPI","mc":"5999","mode":"04"}';

    $acquirer_status_url='https://upipay.finopaymentbank.in/UPIUINonFinService/UPIUINonFinService.svc/UPIUINonFinRequest';

    $apc_get=json_decode($apc,1);
    echo "<br/><hr/><br/>apc_ge=><br/>"; print_r(@$apc_get);

    $headeRequest = '{
    "PartnerId":' . $apc_get['PartnerId'] . ',
    "AuthKey":"' . $apc_get['AuthKey'] . '"
    }';

    $passphrase = @$apc_get['Header_Encryption_Key'];

    echo "<br/><hr/><br/>headeRequest=><br/>"; print_r(@$headeRequest);
    echo "<br/><hr/><br/>Header_Encryption_Key=><br/>"; print_r(@$passphrase);

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
     echo "<br/><hr/><br/>Encryption_Decryption_Key=><br/>"; print_r(@$passphraseStatus);
    
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


    echo "<br/><hr/><br/>dataRequest=>". @$dataRequest;

   
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
        CURLOPT_HEADER => 0,
        CURLOPT_SSL_VERIFYPEER => 0,
        CURLOPT_SSL_VERIFYHOST => 0,
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
    
    echo "<br/><hr/><br/>response=><br/>"; print_r(@$response);
    echo "<br/><hr/><br/>curl_errno=><br/>"; print_r(@$curl_errno);

   // if($qp)
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



    ################################

        $responseParamList = json_decode($response,1);	// covert response from json to array
      
        $responseData  =@$responseParamList['ResponseData'];

        // Decrypt the ResponseData
        $decryptedResponseData = CryptoJSAES::decrypt($responseData, $passphraseStatus);
        //echo "<hr/><br/>Decrypted decryptedResponseData:<br/> $decryptedResponseData\n";

        // covert ResponseData from json to array
        $responseData_array = json_decode($decryptedResponseData,1);	

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

			echo "<br/><br/>acquirer status ['ResponseData']=> ".@$decryptedResponseData;
			
			//echo "<br/>response_json=> ".@$response_json;
			echo "<br/><br/>responseParamList=> "; print_r($responseParamList);
			
			//echo "<br/><br/>res=> ".htmlentitiesf(@$responseParamList);
			echo '<br/><br/></div>';
		}

   


?>