<?
/*
{
"device-id":"400438400438400438400438",
"mobile":"7988000014",
"channel-code":"MICICI",
"profile-id":"2996304",
"seq-no":"IC61I520407323",
"account-provider":"74",
"use-default-acc":"D",
"payee-va": "testo1@icici",
"payer-va": "uattesting0014@icici",
"amount":"3.50",
"pre-approved":"P",
"default-debit":"N",
"default-credit":"N",
"txn-type":"merchantToPersonPay",
"remarks":"none",
"mcc":"6011",
"merchant-type":"ENTITY",
	"crpID" : "PRACHICIB1",
	"aggrID" : "CUST0476",
	"userID" : "USER3",
	"vpa": "testo1@icici"
}
*/
?>
<?

$cib	= 'mEyFnBO1vVoSoCkW6osC4qBtBC8yWoDI';
$apiKey = "1aS5HPwjzKv5S8xCrMsO4z4EHiiziAPh";

	//NEFT
	//v1
	$url = "https://apibankingone.icicibank.com/api/v1/composite-payment";

	$amount		= 1;
	$reference	= 'order'.time();
	
	$postData = array();
//	$postData['ref-id']		=$reference;
	$postData['amount']			=$amount;
	$postData['mobile']			="6202138025";
	$postData['device-id']		="1029221102922110292211029221";//"1013121101312110131211013121";
	$postData['seq-no']			="ICI5DC866EA6ADC".rand (100,999);//"ICI5DC866EA6ADC427";	//to be discuss
	$postData['account-provider']="74";		//Account-provider is an optional field and can be ignored.
	$postData['payee-va']		="ankit13182@icici";
	$postData['payer-va']		="lets.pe@icici";
	$postData['profile-id']		="216275444";//"216225411";
	$postData['pre-approved']	="P";
	$postData['use-default-acc']="D";
	$postData['default-debit']	="N";
	$postData['default-credit']	="N";
	//$postData['payee-name']		="SKYWALK TECHNOLOGIES PRIVATE LIMITED NODAL ACCOUNT";
	$postData['mcc']			="6012";
	$postData['merchant-type']	="ENTITY";
	$postData['txn-type']		="merchantToPersonPay";
	$postData['channel-code']	="MICICI";
	$postData['remarks']		="test";
	
	$postData['crpID']			="584286151";
	$postData['userID']			="TISUVERM";
	$postData['aggrID']			="CUST0813";
	$postData['vpa']			="lets.pe@icici";		//what isvalue of vpa
	//$postData['urn']			="sky1001";
	//$postData['aggrName']		="SKYWALK";

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
		"x-priority: 1000" //1000 for upi, 0100 for imps, 0010 for neft, 0001 for rtgs
	);

	$file = 'composite_log.txt';

	$log = "\n\nGUID - ".$reference."================================================================\n";
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

	$log.= "\n\nGUID - ".$reference."================================================================\n";
	$log.= "RESPONSE - ".$raw_response."\n\n";
	$log.= "RESPONSE DECRYPTED - ".$newsource."\n\n";

	echo nl2br($log);
	//	file_put_contents($file, $log, FILE_APPEND | LOCK_EX);

	//CHECK STATUS
	echo '<a href="status.php?reference='.$reference.'">Check Staus</a>';
	exit;
?>