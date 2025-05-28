<?

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
  
  
  //for qr
  if($acquirer==45){
  
  $randomPart = mt_rand(100000, 999999);

 $dataQr = '{
"clientTxnId":  "'.$transID.'",
"serviceId": "9072",
"txnAmount": "'.$total_payment.'",
"txnNote": "'.$post['product'].'",
"payeeVPA": "sky.shivam@fin",
"txnReference": "FINOUPI'.$randomPart.'",
"ExpiryTime": "30",
"mobilenumber": "'.$post['bill_phone'].'"
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

}
//for collect
if($acquirer==451){

// payeraddr via customer from checkout 
// payeraddr via customer from checkout 

$dataCollect='{
    "clientTxnId":  "'.$transID.'",
    "serviceId": "9031",
    "payeraddr": "pravin99@fin",
    "payername": "Narayanan",
    "payeename": "Miss Caroline Victor Dsouza",
    "initiationmode": "00",
    "referencecategory": "00",
    "currencycode": "INR",
    "amount": "'.$total_payment.'",
    "purpose": "01",
    "payeeaddr": "sky.shivam@fin",
    "payercode": "0000",
    "payertype": "PERSON",
    "mobilenumber": "918887819239",
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
 
 $tr_upd_order['collectUrl']=$bank_url;
 $tr_upd_order['collectResponse'] =$collectRequest;
 $curl_values_arr['responseInfo']    =$tr_upd_order['DecryptResponse'];  //save response for curl request
 $curl_values_arr['browserOsInfo']=$browserOs;
 $_SESSION['acquirer_action']=1;     //set action HKIP for update trasaction via callback
 $_SESSION['curl_values']=@$curl_values_arr; //set curl values into into $_SESSION
 trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);
 
}

?>