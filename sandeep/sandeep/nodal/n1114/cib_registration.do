<?php 
include('../../config.do');

if((!isset($_SESSION['adm_login']))&&(!isset($_SESSION['sub_admin_id']))){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['slogin']}/login".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}             

//FETCH DATA FROM BANK TABLE
$bank_master = select_tablef('`payout_id` IN (1114) ','bank_payout_table');


$bjson = decode_f($bank_master['encode_processing_creds']);

$encode_processing_creds = json_decode($bjson,true);

if($bank_master['payout_prod_mode']==1) {
	$siteid_set=$encode_processing_creds['live'];
	$bank_url = $bank_master['bank_payment_url'];
	$file_start = "live_";
}
else {
	$siteid_set=$encode_processing_creds['test'];
	$bank_url = $bank_master['payout_uat_url'];
	
	$file_start = "test_";
}

$cib		= $siteid_set['cib'];
$apiKey		= $siteid_set['apiKey'];
$crpId		= $siteid_set['crpId'];
$crpUsr		= $siteid_set['crpUsr'];
$aggrId		= $siteid_set['aggrId'];
$aggrName	= $siteid_set['aggrName'];
$urn		= $siteid_set['urn'];
$senderAcctNo= $siteid_set['senderAcctNo'];

$url = $bank_url."/Corporate/CIB/v1/Registration";

$fp = fopen($file_start."SKYWALK_CIB_CERT.cer", 'r');
$pub_key= fread($fp, 8192);
fclose($fp);

$data = '{
"AGGRID":"'.$aggrId.'",
"CORPID":"'.$crpId.'",
"USERID":"'.$crpUsr.'",
"URN":"'.$urn.'",
"AGGRNAME":"'.$aggrName.'",
"ALIASID":""
}';

$RANDOMNO1 = "1212121234483448";
$RANDOMNO2 = '1234567890123456';

openssl_get_publickey($pub_key);

openssl_public_encrypt($RANDOMNO1, $encrypted_key, $pub_key);
$encrypted_data = openssl_encrypt($data, 'AES-128-CBC', $RANDOMNO1, OPENSSL_RAW_DATA, $RANDOMNO2);

$postbody= [
	"requestId" => "req_".time(),
	"service" => "",
	"encryptedKey" => base64_encode($encrypted_key),
	"oaepHashingAlgorithm" => "NONE",
	"iv" => base64_encode($RANDOMNO2),
	"encryptedData" => base64_encode($encrypted_data),
	"clientInfo" => "",
	"optionalParam" => ""
];

//echo json_encode($postbody);
//die;

$headers = array(
	"Content-type: application/json", 
	"x-forwarded-for:".$_SERVER['REMOTE_ADDR'], 
	"apikey:$cib",
);

//$file = 'composite_log.txt';

$log = "\n\n".'GUID - '.time()."======================= \n";
$log .= 'URL - '.$url."\n\n";
$log .= 'HEADER - '.json_encode($headers)."\n\n";
$log .= 'REQUEST - '.$data."\n\n";
$log .= 'REQUEST ENCRYPTED - '.json_encode($postbody)."\n\n";

//file_put_contents($file, $log, FILE_APPEND | LOCK_EX);

$curl = curl_init($url);
curl_setopt($curl, CURLOPT_URL, $url);
curl_setopt($curl, CURLOPT_POST, true);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($postbody));

$raw_response = curl_exec($curl);
$httpcode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
$err = curl_error($curl);
curl_close($curl);

$request = json_decode($raw_response);
$fp= fopen($file_start."privatekey.key","r");
$priv_key=fread($fp,8192);
fclose($fp);
$res = openssl_get_privatekey($priv_key, "");
openssl_private_decrypt(base64_decode($request->encryptedKey), $key, $res);
$encData = base64_decode($request->encryptedData); 
$encData = openssl_decrypt($encData,"aes-128-cbc",$key,OPENSSL_PKCS1_PADDING);
$newsource = substr($encData, 16); 


$log .= "\n\n".'GUID - '.time()."======================= \n";
$log .= 'RESPONSE - '.$raw_response."\n\n";
$log .= 'RESPONSE DECRYPTED - '.$newsource."\n\n";
//file_put_contents($file, $log, FILE_APPEND | LOCK_EX);

echo  nl2br($log);
$response = json_decode($newsource,1);

if(isset($response['Response'])&&$response['Response']=='SUCCESS')
{
	echo $response['Message'];
}

exit;
?>