<?
$bjson = decode_f($bank_master['encode_processing_creds']);

$encode_processing_creds = json_decode($bjson,true);

if($bank_master['payout_prod_mode']==1) {
	$siteid_set	= $encode_processing_creds['live'];
	$bank_url	= $bank_master['bank_payment_url'];
}
else {
	$siteid_set	= $encode_processing_creds['test'];
	$bank_url	= $bank_master['payout_uat_url'];
}

$bg_active	= $bank_master['bg_active'];

$global_data['cib']			= $siteid_set['cib'];
$global_data['apiKey']		= $siteid_set['apiKey'];
$global_data['crpId']		= $siteid_set['crpId'];
$global_data['crpUsr']		= $siteid_set['crpUsr'];
$global_data['aggrId']		= $siteid_set['aggrId'];
$global_data['aggrName']	= $siteid_set['aggrName'];
$global_data['urn']			= $siteid_set['urn'];
$global_data['senderAcctNo']= $siteid_set['senderAcctNo'];

$global_data['currency']	= $bank_master['payout_processing_currency'];
$global_data['bank_url']	= $bank_url;

function send_payout_request($post)
{
	global $global_data, $data;

	#########ICICIC
	$postData = array();
	$postData['tranRefNo']		=$post['transaction_id'];
	$postData['amount']			=$post['price'];
	$postData['senderAcctNo']	=$global_data['senderAcctNo'];
	$postData['beneAccNo']		=$post['account_number'];
	$postData['beneName']		=$post['beneficiary_name'];
	$postData['beneIFSC']		=$post['ifsc'];
	$postData['narration1']		=$post['narration'];
	$postData['crpId']			=$global_data['crpId'];
	$postData['crpUsr']			=$global_data['crpUsr'];
	$postData['aggrId']			=$global_data['aggrId'];
	$postData['urn']			=$global_data['urn'];
	$postData['aggrName']		=$global_data['aggrName'];
	$postData['txnType']		="RGS";
	$postData['WORKFLOW_REQD']	="Y";
	#########I ICIC

	$url = $global_data['bank_url']."/v1/composite-payment";

	$fp = fopen($data['Path'].'/nodal/n1114/live_rsaapikey.cer', 'r');
	$pub_key= fread($fp, 8192);
	fclose($fp);
	
	$RANDOMNO1 = "1212121234483448";
	$RANDOMNO2 = '1234567890123456';
	
	openssl_get_publickey($pub_key);
	
	openssl_public_encrypt($RANDOMNO1, $encrypted_key, $pub_key);
	$encrypted_data = openssl_encrypt(json_encode($postData), 'AES-128-CBC', $RANDOMNO1, OPENSSL_RAW_DATA, $RANDOMNO2);

	$postbody= [
		"requestId" => $post['transaction_id'],
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
		"x-priority: 0010" //1000 for upi, 0100 for imps, 0010 for neft, 0001 for rtgs
	);

	$log = "\n\nGUID - ".$post['transaction_id']."===============================================\n";
	$log .= 'URL - '.$url."\n\n";
	$log .= 'HEADER - '.json_encode($headers)."\n\n";
	$log .= 'REQUEST - '.json_encode($postData)."\n\n";
	$log .= 'REQUEST ENCRYPTED - '.json_encode($postbody)."\n\n";

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
	$fp= fopen($data['Path']."/nodal/n1114/live_privatekey.key","r");
	$priv_key=fread($fp,8192);
	fclose($fp);
	$res = openssl_get_privatekey($priv_key, "");
	openssl_private_decrypt(base64_decode($request->encryptedKey), $key, $res);
	$encData = base64_decode($request->encryptedData); 
	$encData = openssl_decrypt($encData,"aes-128-cbc",$key,OPENSSL_PKCS1_PADDING);

	$newsource = substr($encData, 16); 

	$log.= "\n\nGUID - ".$post['transaction_id']."================================================\n";
	$log.= "RESPONSE - ".$raw_response."\n\n";
	$log.= "RESPONSE DECRYPTED - ".$newsource."\n\n";

	//echo nl2br($log);

	$responseParam = json_decode($newsource,1);

	//print_r($responseParam);exit;

	$return_resp = array();
	if(isset($responseParam['STATUS'])&&$responseParam['STATUS']=='SUCCESS'){
		$status = '00';
		$return_resp['status']	= $status;
		$return_resp['txn_id']	= $responseParam['UTRNUMBER'];
	}
	elseif(isset($responseParam['STATUS'])&&$responseParam['STATUS']=='FAILURE'){
		$status = '01';
		$return_resp['status']	= $status;
		$return_resp['MESSAGE']	= $responseParam['MESSAGE'];
	}
	else {
		$status = '99';
		$return_resp['status']	= $status;
		$return_resp['MESSAGE']	= ((isset($responseParam['MESSAGE'])&&$responseParam['MESSAGE'])?$responseParam['MESSAGE']:$raw_response);
	}

	return $return_resp;
}
?>