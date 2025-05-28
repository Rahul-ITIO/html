<?
$cib	= 'mEyFnBO1vVoSoCkW6osC4qBtBC8yWoDI';
$apiKey = "1aS5HPwjzKv5S8xCrMsO4z4EHiiziAPh";

$RANDOMNO1 = "1212121234483448";
$RANDOMNO2 = '1234567890123456';

if(!isset($_GET['BNF_ID']))
{
	//BENEFICIARY REGISTRATION

	//v1
	$url = "https://apibankingone.icicibank.com/api/Corporate/CIB/v1/BeneAddition";
	
	$postData = array();
	$postData['CrpId']		="584286151";
	$postData['CrpUsr']		="TISUVERM";
	$postData['AGGR_ID']	="CUST0813";
	
	$postData['BnfName']	="Skywalk Technologies Private Limited";	// to be change in live
	$postData['BnfNickName']="SkywalkTech001";		// to be change in live
	$postData['BnfAccNo']	="8046115009";			// to be change in live
	$postData['PayeeType']	="O";					//use "O" for other bank and "W" for ICICI bank
	$postData['IFSC']		="KKBK0004605";
	$postData['URN']		="sky1001";

	$fp = fopen('../live_SKYWALK_CIB_CERT.cer', 'r');
	$pub_key= fread($fp, 8192);
	fclose($fp);
	
	openssl_get_publickey($pub_key);
	
	openssl_public_encrypt($RANDOMNO1, $encrypted_key, $pub_key);
	$encrypted_data = openssl_encrypt(json_encode($postData), 'AES-128-CBC', $RANDOMNO1, OPENSSL_RAW_DATA, $RANDOMNO2);
	
	$postbody= [
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
		"content-type: application/json", 
		"apikey:$cib",
		"x-priority: 0010"	//1000 for upi, 0100 for imps, 0010 for neft, 0001 for rtgs
	);
	
	$log_path="../../../log/";
	$file = $log_path.'composite_log.txt';
	
	$log = "\nBeneficiary Registration \nGUID - ".$reference."=======================================\n";
	$log.= 'URL - '.$url."\n\n";
	$log.= 'HEADER - '.json_encode($headers)."\n\n";
	$log.= 'REQUEST - '.json_encode($postData)."\n\n";
	$log.= 'REQUEST ENCRYPTED - '.json_encode($postbody)."\n\n";
	
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
	$fp= fopen("../live_privatekey.key","r");
	$priv_key=fread($fp,8192);
	fclose($fp);
	$res = openssl_get_privatekey($priv_key, "");
	openssl_private_decrypt(base64_decode($request->encryptedKey), $key, $res);
	$encData = base64_decode($request->encryptedData); 
	$encData = openssl_decrypt($encData,"aes-128-cbc",$key,OPENSSL_PKCS1_PADDING);
	
	$newsource = substr($encData, 16); 
	
	$log = "\n\nGUID - ".time()."================================================================ \n";
	$log.= 'RESPONSE - '.$raw_response."\n\n";
	$log.= 'RESPONSE DECRYPTED - '.$newsource."\n\n";
	$log.= 'RESPONSE DECRYPTED - '.$newsource."\n\n";
	
	//file_put_contents($file, $log, FILE_APPEND | LOCK_EX);
	
	$response_arr = json_decode($newsource,1);
	if(isset($response_arr['Response'])&&$response_arr['Response']=='SUCCESS')
	{
		$BNF_ID = $response_arr['BNF_ID'];
		$redirecturl = $_SERVER['PHP_SELF'].'?BNF_ID='.$BNF_ID;
		header("Location:$redirecturl");exit;
	}
}
else
{
	//NEFT
	
	//v1
	$url = "https://apibankingone.icicibank.com/api/v1/composite-payment";
	
	$amount		= 5;
	$reference	= 'order'.time();
	
	$postData = array();
	$postData['tranRefNo']		=$reference;
	$postData['amount']			=$amount;
	$postData['senderAcctNo']	="348805002989";
	$postData['beneAccNo']		="8046115009";
	$postData['beneName']		="Skywalk Technologies Private Limited";
	$postData['beneIFSC']		="KKBK0004605";		// to be change as live
	$postData['narration1']		="test";
	$postData['crpId']			="584286151";
	$postData['crpUsr']			="TISUVERM";
	$postData['aggrId']			="CUST0813";
	$postData['urn']			="sky1001";
	$postData['aggrName']		="SKYWALK";
	$postData['txnType']		="RGS";
	$postData['WORKFLOW_REQD']	="N";
	
	$fp = fopen('../live_rsaapikey.cer', 'r');
	$pub_key= fread($fp, 8192);
	fclose($fp);
	
	//$RANDOMNO1 = "1212121234483448";
	//$RANDOMNO2 = '1234567890123456';
	
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

	//echo json_encode($postbody);
	//die;

	$headers = array(
		"content-type: application/json", 
		"apikey:$apiKey",
		"x-priority: 0010" //1000 for upi, 0100 for imps, 0010 for neft, 0001 for rtgs
	);

	$file = 'composite_log.txt';

	$log = "\n\nGUID - ".$reference."================================================================\n";
	$log .= 'URL - '.$url."\n\n";
	$log .= 'HEADER - '.json_encode($headers)."\n\n";
	$log .= 'REQUEST - '.json_encode($postData)."\n\n";
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
	$fp= fopen("../live_privatekey.key","r");
	$priv_key=fread($fp,8192);
	fclose($fp);
	$res = openssl_get_privatekey($priv_key, "");
	openssl_private_decrypt(base64_decode($request->encryptedKey), $key, $res);
	$encData = base64_decode($request->encryptedData); 
	$encData = openssl_decrypt($encData,"aes-128-cbc",$key,OPENSSL_PKCS1_PADDING);

	echo $newsource = substr($encData, 16); 

	$log.= "\n\nGUID - ".$reference."================================================================\n";
	$log.= "RESPONSE - ".$raw_response."\n\n";
	$log.= "RESPONSE DECRYPTED - ".$newsource."\n\n";

	echo nl2br($log);
	//	file_put_contents($file, $log, FILE_APPEND | LOCK_EX);

	//CHECK STATUS
	echo '<a href="status.php?reference='.$reference.'">Check Staus</a>';
	exit;

	$url = "https://apibankingone.icicibank.com/api/v1/composite-status";

	$postData = array();
	$postData['USERID']		="TISUVERM";
	$postData['AGGRID']		="CUST0813";
	$postData['CORPID']		="584286151";
	$postData['URN']		="sky1001";
	$postData['UNIQUEID']	=$reference;

	$fp = fopen('../live_rsaapikey.cer', 'r');
	$pub_key= fread($fp, 8192);
	fclose($fp);

	//$RANDOMNO1 = "1212121234483448";
	//$RANDOMNO2 = '1234567890123456';

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

	//echo json_encode($postbody);
	//die;

	$headers = array(
		"content-type: application/json", 
		"apikey:$apiKey",
		"x-priority: 0010" //1000 for upi, 0100 for imps, 0010 for neft, 0001 for rtgs
	);

	$file = 'composite_log.txt';

	$log = "\n\n".'GUID - '.$reference."================================================================\n";
	$log .= 'URL - '.$url."\n\n";
	$log .= 'HEADER - '.json_encode($headers)."\n\n";
	$log .= 'REQUEST - '.json_encode($postData)."\n\n";
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
	$fp= fopen("../live_privatekey.key","r");
	$priv_key=fread($fp,8192);
	fclose($fp);
	$res = openssl_get_privatekey($priv_key, "");
	openssl_private_decrypt(base64_decode($request->encryptedKey), $key, $res);
	$encData = base64_decode($request->encryptedData); 
	$encData = openssl_decrypt($encData,"aes-128-cbc",$key,OPENSSL_PKCS1_PADDING);
	
	$newsource = substr($encData, 16); 
	
	print_r(json_decode($newsource,1));
	
	$log = "\n\n".'GUID - '.time()."================================================================ \n";
	$log.= 'RESPONSE - '.$raw_response."\n\n";
	$log.= 'RESPONSE DECRYPTED - '.$newsource."\n\n";
	
	//file_put_contents($file, $log, FILE_APPEND | LOCK_EX);

	echo "<br /><br />Status=><br />".nl2br($log);
	
	exit;
}
?>

