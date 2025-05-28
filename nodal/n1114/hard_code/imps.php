<?
/*
(2) Sample Request Packet for IMPS
{
"localTxnDtTime":"20190808161038",
"beneAccNo": "001700000004",
"beneIFSC": "HDFC0922915",
"amount":"287.00",
"tranRefNo":"1236456",
"paymentRef": "FTTransferP2A",
"senderName":"Ram singh",
"mobile":"9999988888",
"retailerCode": "rcode",
"passCode": "3f4dbbdad1a241bca994339c0d3f3efd",
"bcID": "IBCFli00044",
"crpId":"CIBNEXT",
"crpUsr":"BALAKIRAN",
"aggrId": " AGGRID"
}
*/
?>
<?

$cib	= 'mEyFnBO1vVoSoCkW6osC4qBtBC8yWoDI';
$apiKey = "1aS5HPwjzKv5S8xCrMsO4z4EHiiziAPh";
//1aS5HPwjzKv5S8xCrMsO4z4EHiiziAPh
	//NEFT
	//v1
	$url = "https://apibankingone.icicibank.com/api/v1/composite-payment";

	$amount		= "2";
	$reference	= 'order'.time();
	
	$postData = array();
	$postData['tranRefNo']		=$reference;
	$postData['paymentRef']		="Pay for $reference";
	$postData['amount']			=$amount;
	//$postData['senderAcctNo']	="348805002989";
	$postData['senderName']		="Skywalk Technologies Private Limited";
	$postData['beneAccNo']		="5044555223";
	$postData['beneIFSC']		="CITI0000015";
	$postData['bcID']			="IBCSky01110";
//	$postData['bcName']			="Skywalk Technologies Private Limited";
	$postData['passCode']		="737b679493cf40949ee5493d2058e0a7";
	$postData['crpId']			="584286151";
	$postData['crpUsr']			="TISUVERM";
	$postData['aggrId']			="CUST0813";
	$postData['urn']			="sky1001";
	$postData['localTxnDtTime']	=date('YmdHis');
	$postData['mobile']			="6202138025";
	$postData['retailerCode']	="rcode";
	
	
	$fp = fopen('../live_rsaapikey.cer', 'r');
	$pub_key= fread($fp, 8192);
	fclose($fp);
	
	$RANDOMNO1 = "1212121234483448";
	$RANDOMNO2 = '1234567890123456';
	
	openssl_get_publickey($pub_key);
	
	openssl_public_encrypt($RANDOMNO1, $encrypted_key, $pub_key);
	$encrypted_data = openssl_encrypt(json_encode($postData), 'AES-128-CBC', $RANDOMNO1, OPENSSL_RAW_DATA, $RANDOMNO2);

	$postbody= [
		"requestId" => $reference,
		"service" => "",
		"encryptedKey" => base64_encode($encrypted_key),
		"oaepHashingAlgorithm" => "NONE",
		"iv" => base64_encode($RANDOMNO2),
		"encryptedData" => base64_encode($encrypted_data),
		"clientInfo" => "",
		"optionalParam" => ""
	];

	$headers = array(
		"content-type: application/json", 
		"apikey:$apiKey",
		"x-priority: 0100" //1000 for upi, 0100 for imps, 0010 for neft, 0001 for rtgs
	);

	$file = 'composite_log.txt';

	$log = "\n\nGUID - ".$reference."================================================================\n";
	$log .= 'URL - '.$url."\n\n";
	$log .= 'HEADER - '.json_encode($headers)."\n\n";
	$log .= 'REQUEST - '.json_encode($postData)."\n\n";
	$log .= 'REQUEST ENCRYPTED - '.json_encode($postbody)."\n\n";

	//file_put_contents($file, $log, FILE_APPEND | LOCK_EX);
	
	//584286151.TISUVERM
	
	$curl = curl_init($url);
	curl_setopt($curl, CURLOPT_URL, $url);
	curl_setopt($curl, CURLOPT_POST, true);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
	//curl_setopt($curl, CURLOPT_USERPWD, '584286151:TISUVERM');
	curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($postbody));

	$raw_response = curl_exec($curl);
	$httpcode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
	$err = curl_error($curl);
	curl_close($curl);

	$request = json_decode($raw_response);
	$fp= fopen("../live_privatekey.key","r");
	$priv_key=fread($fp,8192);
	fclose($fp);
	$res = openssl_get_privatekey($priv_key, "");
	openssl_private_decrypt(base64_decode($request->encryptedKey), $key, $res);
	$encData = base64_decode($request->encryptedData); 
	$encData = openssl_decrypt($encData,"aes-128-cbc",$key,OPENSSL_PKCS1_PADDING);

	$newsource = substr($encData, 16); 

	$log.= "\n\nGUID - ".$reference."================================================================\n";
	$log.= "RESPONSE - ".$raw_response."\n\n";
	$log.= "RESPONSE DECRYPTED - ".$newsource."\n\n";

	echo nl2br($log);
	//	file_put_contents($file, $log, FILE_APPEND | LOCK_EX);

	//CHECK STATUS
	echo '<a href="status.php?reference='.$reference.'">Check Staus</a>';
	exit;
?>