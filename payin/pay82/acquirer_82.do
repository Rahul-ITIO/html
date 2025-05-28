<?
// https://www.sslshopper.com/csr-decoder.html

$headeRequest = '{
"PartnerId":' . $apc_get['PartnerId'] . ',
"AuthKey":"' . $apc_get['AuthKey'] . '"
}';

$passphrase = $apc_get['Header_Encryption_Key'];//header encryption key
//Encryption function
########################################################################################################
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
        list($ct, $salt) = self::decode($base64);
        list($key, $iv) = self::evpkdf($passphrase, $salt);

        $Decryptdata = openssl_decrypt($ct, 'aes-256-cbc', $key, true, $iv);

        return $Decryptdata;
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
        $data = base64_decode($base64);

        if (substr($data, 0, 8) !== "Salted__") {
            throw new \InvalidArgumentException();
        }

        $salt = substr($data, 8, 8);
        $ct = substr($data, 16);

        return [$ct, $salt];
    }

    public static function encode($ct, $salt) {
        return base64_encode("Salted__" . $salt . $ct);
    }
}
  #################################################################################################################
  $encryptedDataHeader = CryptoJSAES::encrypt($headeRequest,  $passphrase);//header encrypted request
  $decryptedData = CryptoJSAES::decrypt($encryptedDataHeader,  $passphrase);
  
  
//for QR dynamic code QR & if device is mobile then push the INTENT via hard code key

if( ($acquirer==82) || (isset($post['mop'])&&$post['mop']=='QRINTENT') )
{ //for QR dynamic code QR & INTENT



  $IntentRequest='{
      "clientTxnId": "'.$transID.'",
      "serviceId": "9075",
      "mobilenumber": "'.@$apc_get['mobilenumber'].'",
      "txnAmount": "'.$total_payment.'",
      "txnNote": "'.$post['product'].'",
      "payeeVPA": "'.@$apc_get['payeeVPA'].'",
      "txnReference": "FINOUPI'.$transID.'",
      "ExpiryTime": "25"
  }';
 

  $passphraseIntent = $apc_get['Encryption_Decryption_Key'];

  $encryptedDataIntent = CryptoJSAES::encrypt($IntentRequest, $passphraseIntent);//vpa encrypted request
  

  $curl = curl_init();

  curl_setopt_array($curl, array(
    CURLOPT_URL => $bank_url,
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_ENCODING => '',
    CURLOPT_MAXREDIRS => 10,
    CURLOPT_TIMEOUT => 0,
    CURLOPT_FOLLOWLOCATION => true,
    CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
    CURLOPT_CUSTOMREQUEST => 'POST',
    CURLOPT_POSTFIELDS =>'"'.$encryptedDataIntent.'"',
    CURLOPT_HTTPHEADER => array(
      'Authentication: '.$encryptedDataHeader,
      'Content-Type: application/json'
    ),
  ));

  $response = curl_exec($curl);

  curl_close($curl);

  $DataIntentRequest = json_decode($response,1);
  $DataResponseIntent = $DataIntentRequest['ResponseData'];

  $decryptedData = CryptoJSAES::decrypt($DataResponseIntent, $passphraseIntent);

  $intent_process_include=1;
  $qr_intent_address=replace_space_tab_br_for_intent_deeplink($decryptedData,1);
  $requestIntentQr=json_decode($IntentRequest,1);
    
  $tr_upd_order['IntentRequest'] = $requestIntentQr;
  $tr_upd_order['qrString'] =$decryptedData;
  trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);


/*
// Create the Intent Address & qr code also but not use now 

  $intent_arr=[];
  $intent_arr['pa']=@$apc_get['payeeVPA'];
  $intent_arr['pn']=@$apc_get['pn'];
  $intent_arr['mc']=@$apc_get['mc'];
  $intent_arr['tr']=(isset($apc_get['tr'])&&trim($apc_get['tr'])?@$apc_get['tr']:'FINOUPI').@$transID;
  $intent_arr['tn']=@$apc_get['tn'];
  $intent_arr['am']=@$total_payment;
  $intent_arr['mode']=(isset($apc_get['mode'])&&trim($apc_get['mode'])?@$apc_get['mode']:'04');
  $intent_arr['tid']=@$transID;

  $qrString='upi://pay?'.http_build_query($intent_arr);

  //upi://pay?pa=sky.skywalk@finobank&pn=SkywalkTechnology&mc=5999&tr=FINOUPI821117924&tn=skywalk+technology&am=2.00&mode=04&tid=8268822

  $intent_process_include=1;
    
  // urlencodef 
  $qr_intent_address=replace_space_tab_br_for_intent_deeplink($qrString,1); // return upi address for auto run for check via mobile or web 
    
    
  $tr_upd_order['intent_arr'] =$intent_arr;
  $tr_upd_order['qrString'] =$qrString;
  trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);

*/


/*
// 64 image base qr code not use now 

$randomPart = mt_rand(100000, 999999);

//payeeVPA:sky.shivam@fin

$dataQr = '{
"clientTxnId":  "'.$transID.'",
"serviceId": "9072",
"txnAmount": "'.$total_payment.'",
"txnNote": "'.$post['product'].'",
"payeeVPA": "'.@$apc_get['payeeVPA'].'",
"txnReference": "FINOUPI'.$transID.'",
"ExpiryTime": "30",
"mobilenumber": "'.@$apc_get['mobilenumber'].'"
}';

$passphraseQr = $apc_get['Encryption_Decryption_Key'];

  $encryptedDataQR = CryptoJSAES::encrypt($dataQr, $passphraseQr);//vpa encrypted request
  $decryptedData = CryptoJSAES::decrypt($encryptedDataQR,  $passphraseQr);
 
$qrUrl = trim($bank_url);
$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => $qrUrl,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>'"'.$encryptedDataQR.'"',
  CURLOPT_HTTPHEADER => array(
    'Authentication: '.$encryptedDataHeader,
    'Content-Type: application/json'
  ),
));

$response = curl_exec($curl);

curl_close($curl);

$req = json_decode($response,1);



   $ResponseData = $req['ResponseData'];
   $ClientTxnId = $req['ClientTxnId'];
  
  $decryptedData = CryptoJSAES::decrypt($ResponseData, $passphraseQr);
  
  

 $tr_upd_order['dataRequest']   =json_decode($dataQr,1);
 
 $tr_upd_order['QrUrl']= $qrUrl;
 
 $tr_upd_order['QrResponse']=$tr_upd_order['acquirer_ref']=@$ClientTxnId;

 if(isset($_REQUEST['qp'])) 
 {
    echo "<hr/><br/>tr_upd_order=><br/>";
    print_r($tr_upd_order);

    echo "<hr/><br/>tr_upd_order json=><br/>".json_encode($tr_upd_order);
 }

 
 //$tr_upd_order['DecryptResponse']=$decryptedData;
// $curl_values_arr['responseInfo']    =$tr_upd_order['QrResponse'];  //save response for curl request
 
 //$curl_values_arr['browserOsInfo']=$browserOs;
 
 $_SESSION['acquirer_action']=1;     //set action HKIP for update trasaction via callback
 
 //$_SESSION['curl_values']=@$curl_values_arr; //set curl values into into $_SESSION
 
 trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);
 $qr_intent_address=$decryptedData;
 $qr_process_base64=1;
 $_SESSION['3ds2_auth']['base64']=1;

*/


}
//for collect
elseif( ($acquirer==821) || (isset($post['mop'])&&$post['mop']=='UPICOLLECT') ){

$requestPost['vpa']=@$post['upi_address'];
if(isset($post['upi_address_suffix'])&&$post['upi_address_suffix']) $requestPost['vpa'].=@$post['upi_address_suffix'];
$tr_upd_order['upa']=@$requestPost['vpa'];

// payeraddr via customer from checkout 
// payeraddr via customer from checkout 

//"mobilenumber": "918887819239",
// "payeraddr": "pravin99@fin",
// "payername": "Narayanan",
//  txnReference via referenceid



$dataCollect='{
    "clientTxnId":  "'.$transID.'",
    "serviceId": "9031",
    "payeraddr": "'.@$requestPost['vpa'].'",
    "payername": "'.@$post['fullname'].'",
    "payeename": "Miss Caroline Victor Dsouza",
    "initiationmode": "00",
    "referencecategory": "00",
    "currencycode": "INR",
    "amount": "'.$total_payment.'",
    "purpose": "01",
    "payeeaddr": "'.@$apc_get['payeeVPA'].'",
    "payercode": "0000",
    "payertype": "PERSON",
    "mobilenumber": "'.@$apc_get['mobilenumber'].'",
    "txnnote": "FINOBANKUPI",
    "expireafter": "30",
    "location": "Ghazibad",
    "geocode": "28.6446214,77.3272125",
    "id": "38a0ef79917a3070",
    "ip": "122.176.17.22",
    "type": "MOB",
    "app": "finoapp",
    "os": "Windows 11",
    "capability": "FULL",
    "telecom": "NA",
    "referenceid": "FINOUPI'.$transID.'",
    "refid": "FINOUPIUAT 3313400298676542681",
    "simno": "238a0ef79917a3070"
}';
$passphraseCollect = $apc_get['Encryption_Decryption_Key'];

    $encryptedDataCollect = CryptoJSAES::encrypt($dataCollect, $passphraseCollect);//vpa encrypted request
  $decryptedData = CryptoJSAES::decrypt($encryptedDataCollect,  $passphraseCollect);
  

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => $bank_url,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>'"'. $encryptedDataCollect.'"',
  CURLOPT_HTTPHEADER => array(
    'Authentication: '.$encryptedDataHeader,
    'Content-Type: application/json'
  ),
));

$response = curl_exec($curl);

curl_close($curl);


$collectRequest = json_decode($response,1);

if(isset($_REQUEST['qp']))  print_r($collectRequest);


$ResponseData =$collectRequest['ResponseData']; 

 $decryptedData = CryptoJSAES::decrypt($ResponseData,  $passphraseCollect);
 $decryptedResponse = json_decode($decryptedData,1);
 $decryptedResponse['status']['message'];
 $tr_upd_order['dataRequest']   =json_decode($dataCollect,1);
 
 $json_arr_set['UPICOLLECT']='Y';
 $tr_upd_order['collectUrl']=$bank_url;
 $tr_upd_order['collectResponse'] =$collectRequest;

 /*
 $curl_values_arr['responseInfo']    =$tr_upd_order['DecryptResponse'];  //save response for curl request
 $curl_values_arr['browserOsInfo']=$browserOs;
 
 $_SESSION['acquirer_action']=1;     
 $_SESSION['curl_values']=@$curl_values_arr; //set curl values into into $_SESSION
*/

 trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);
 
}


//Deepti code 

elseif($acquirer==822){


    $IntentRequest='{
        "clientTxnId": "'.$transID.'",
        "serviceId": "9075",
        "mobilenumber": "'.@$apc_get['mobilenumber'].'",
        "txnAmount": "'.$total_payment.'",
        "txnNote": "'.$post['product'].'",
        "payeeVPA": "'.@$apc_get['payeeVPA'].'",
        "txnReference": "FINOUPI'.$transID.'",
        "ExpiryTime": "25"
    }';
    
 
    $passphraseIntent = $apc_get['Encryption_Decryption_Key'];
    
    $encryptedDataIntent = CryptoJSAES::encrypt($IntentRequest, $passphraseIntent);//vpa encrypted request
      
    
    $curl = curl_init();
    
    curl_setopt_array($curl, array(
      CURLOPT_URL => $bank_url,
      CURLOPT_RETURNTRANSFER => true,
      CURLOPT_ENCODING => '',
      CURLOPT_MAXREDIRS => 10,
      CURLOPT_TIMEOUT => 0,
      CURLOPT_FOLLOWLOCATION => true,
      CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
      CURLOPT_CUSTOMREQUEST => 'POST',
      CURLOPT_POSTFIELDS =>'"'.$encryptedDataIntent.'"',
      CURLOPT_HTTPHEADER => array(
        'Authentication: '.$encryptedDataHeader,
        'Content-Type: application/json'
      ),
    ));
    
    $response = curl_exec($curl);
    
    curl_close($curl);

    $DataIntentRequest = json_decode($response,1);
    $DataResponseIntent = $DataIntentRequest['ResponseData'];

    $decryptedData = CryptoJSAES::decrypt($DataResponseIntent, $passphraseIntent);

    $intent_process_include=1;
    $qr_intent_address=replace_space_tab_br_for_intent_deeplink($decryptedData,1);
    $requestIntentQr=json_decode($IntentRequest,1);

    $tr_upd_order['IntentRequest'] = $requestIntentQr;
    $tr_upd_order['qrString'] =$decryptedData;
    trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);
 }



?>