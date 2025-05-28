<?
function qr_78_post($urlQr,$reqQr){
	global $apc_get;
	
	$checksum='';
	foreach ($reqQr as $val){
		$checksum.=$val;
	}
	$checksum_stringQ=$checksum.$apc_get['Checksum_key'];
	$reqQr['checksum']=hash('sha256',$checksum_stringQ);
	$key= $apc_get['Encryption_key'];
	$key=substr((hash('sha256',$key,true)),0,16);
	$cipher='AES-128-ECB';
	$encrypted_string=openssl_encrypt(
		json_encode($reqQr),
		$cipher,
		$key
	);
	$curl = curl_init();

	curl_setopt_array($curl, array(
		CURLOPT_URL => $urlQr,
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => '',
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 30,
		CURLOPT_FOLLOWLOCATION => true,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_HEADER => 0,
		CURLOPT_SSL_VERIFYHOST => 0,
		CURLOPT_SSL_VERIFYPEER => 0,
		CURLOPT_CUSTOMREQUEST => 'POST',
		CURLOPT_POSTFIELDS =>$encrypted_string,
		CURLOPT_HTTPHEADER => array(
			'cid:' .$apc_get['key'],
			'Content-Type: text/plain'
		),
	));
	$responseQr = curl_exec($curl);

	curl_close($curl);


	$decrypted_string = openssl_decrypt(
		$responseQr,
		$cipher,
		$key
	);
	$resQr = json_decode($decrypted_string,true);
	//print_r($resQr);
	//echo $resQr['qrString'];
	
	return $resQr;
}
?>