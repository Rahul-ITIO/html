<?php 
	require_once 'vendor/autoload.php';
	use Jose\Component\Core\AlgorithmManager;
	use Jose\Component\Encryption\Algorithm\KeyEncryption\A256KW;
	use Jose\Component\Encryption\Algorithm\ContentEncryption\A256GCM;
	use Jose\Component\Signature\Algorithm\RS256;
	use Jose\Component\Encryption\Compression\CompressionMethodManager;
	use Jose\Component\Encryption\Compression\Deflate;
	use Jose\Component\Encryption\JWEBuilder ;
	use Jose\Component\KeyManagement\JWKFactory;
	use Jose\Component\Encryption\Serializer\CompactSerializer;
	use Jose\Component\Encryption\Algorithm\KeyEncryption\RSAOAEP256;
	use Jose\Component\Encryption\Serializer\JWESerializerManager;
	use Jose\Component\Encryption\JWEDecrypter;
	
	$client_id		= $apc_get['IBL-Client-Id'];
	$client_secret	=$apc_get['IBL-Client-Secret'];
	$apiUrl			= $bank_url;
	$CustomerTenderId=$apc_get['CustomerTenderId'];
	$certFile		= $data['Path'].'/payin/pay'.$acquirer_payin.'/'.$apc_get['mode'].'_indusapi.indusind.com-sscert.pem';
	$pgMerchantId	= $apc_get['pgMerchantId'];


	$ts = date('Y-m-d H:i:s');
	$ts = str_replace(' ', 'T',$ts);
	$ts = $ts.'Z';
	
	$Payload = [
		'pgMerchantId' => "$pgMerchantId",
		'txnId' => $transID,
		'txnNote' => "PE_20",
		'ts' => "$ts",//"2023-01-17T19:44:27Z",
		'initMode' => "00",
		'purposeCode' => "00",
		'refId' => $transID,
		'refUrl' => "https://shoppingmango.com",	
		'refCategory' => "NA",
		'expiryTime' => "30",
		'amount' => "$total_payment",
		'payerVpa' => $payerVpa,//"reg7@indusuat",
		'payerName' => $payerName,
		'payerType' => "PERSON",
		'payerMCC' => $mcc,
		'merchantMobile' => $post['bill_phone'],
		'merchantDeviceAppName' => isMobileDevice()?'MOB':'NA',
		'merchantDeviceOS' => isMobileDevice()?'MOB':'NA',
		'merchantDeviceId' => "OP123456",
		'merchantDeviceType' => isMobileDevice()?'MOB':'INET',
		'merchantDeviceIP' => $_SERVER['REMOTE_ADDR'],
		'merchantDeviceLocation' => "NA",
		'merchantDeviceGeoCode' => "17.5221503,78.3045558",
		'addInfo9' => "",
		'addInfo10' => ""
	];

//print_r($Payload);echo '<br><br>';//exit;

	$res_data = json_encode($Payload);
	$keyEncryptionAlgorithmManager = new AlgorithmManager([
		new A256KW(),
	]);

	// The content encryption algorithm manager with the A256CBC-HS256 algorithm.
	$contentEncryptionAlgorithmManager = new AlgorithmManager([
		new A256GCM(),
	]);

	// The signatrue encryption algorithm manager with the RS256 algorithm.
	$signatureEncryptionAlgorithmManager = new AlgorithmManager([
		new RS256(),
	]);

	// The compression method manager with the DEF (Deflate) method.
	$compressionMethodManager = new CompressionMethodManager([
		new Deflate(),
	]);

	// We instantiate our JWE Builder.
	$jweBuilder = new JWEBuilder(
		$keyEncryptionAlgorithmManager,
		$contentEncryptionAlgorithmManager,
		$compressionMethodManager
	);

	$rndEncryptionKey	= openssl_random_pseudo_bytes(32);
	$GenaratedKey		= JWKFactory :: createFromSecret(
		$rndEncryptionKey		// The shared secret
	);

	$jwe = $jweBuilder
		->create()				// We want to create a new JWE
		->withPayload($res_data)	// We set the payload
		->withSharedProtectedHeader([
			'alg' => 'A256KW',	// Key Encryption Algorithm
			'enc' => 'A256GCM',	// Content Encryption Algorithm
			'zip' => 'DEF'		// We enable the compression (irrelevant as the payload is small, just for the example).
		])
		->addRecipient($GenaratedKey)	// We add a recipient (a shared key or public key).
		->build();					// We build it
	$serializer = new CompactSerializer(); // The serializer
	$encData	= $serializer->serialize($jwe, 0); // We serialize the recipient at index 0 (we only have one recipient).
	$keyEncryptionAlgorithmManager = new AlgorithmManager([
		new RSAOAEP256(),
	]);

	// We instantiate our JWE Builder.
	
	$jweBuilder = new JWEBuilder(

		$keyEncryptionAlgorithmManager,
		$contentEncryptionAlgorithmManager,
		$compressionMethodManager
	
	);

	$key = JWKFactory::createFromKeyFile(
		$certFile,	//The indus certificate filename
		'',						// Secret if the key is encrypted, otherwise null
		[
			'use' => 'enc',		// Additional parameters
		]
	);

	$rndEncryptionKeyHexCode = bin2hex($rndEncryptionKey);

	$jwe = $jweBuilder
		->create()								// We want to create a new JWE
		->withPayload($rndEncryptionKeyHexCode) // hexcode of $rndEncryptionKey
		->withSharedProtectedHeader([
			'alg' => 'RSA-OAEP-256',	// Key Encryption Algorithm
			'enc' => 'A256GCM',			// Content Encryption Algorithm
			'zip' => 'DEF'				// We enable the compression (irrelevant as the payload is small, just for the example).
		])
		->addRecipient($key)		// We add a recipient (a shared key or public key).
		->build();					// We build it

	$serializer	= new CompactSerializer(); // The serializer
	$encKey		= $serializer->serialize($jwe, 0); // We serialize the recipient at index 0 (we only have one recipient).
	$request	= json_encode([
		'data'	=> $encData,
		'key'	=> $encKey,
		'bit'	=> 0
	]);
	//print_r($request);
	$httpUrl = $apiUrl;

	$headers = array(
		'IBL-Client-Id: '.$client_id,
		'IBL-Client-Secret: '.$client_secret,
		'Content-Type: application/json',
	);
    //print_r($headers);
	$curl = curl_init();
	curl_setopt_array($curl, array(
		CURLOPT_URL => $httpUrl,
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => '',
		CURLOPT_MAXREDIRS => 1,
		CURLOPT_TIMEOUT => 60,
		CURLOPT_FOLLOWLOCATION => true,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => 'POST',
		CURLOPT_POSTFIELDS => $request,
		CURLOPT_HTTPHEADER => $headers,
	));
	
	$response = curl_exec($curl);
	$httpcode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
	curl_close($curl);
	$response = json_decode($response)->data;

	$keyEncryptionAlgorithmManager = new AlgorithmManager([
		new A256KW(),
	]);

	// The content encryption algorithm manager with the A256CBC-HS256 algorithm.
	$contentEncryptionAlgorithmManager = new AlgorithmManager([
		new A256GCM(),
	]);

	// The compression method manager with the DEF (Deflate) method.
	$compressionMethodManager = new CompressionMethodManager([
		new Deflate(),
	]);

	// The serializer manager. We only use the JWE Compact Serialization Mode.
	$serializerManager = new JWESerializerManager([
		new CompactSerializer(),
	]);

	// We try to load the token.
	$jwe = $serializerManager->unserialize($response);

	$jwkAlgkey = JWKFactory::createFromSecret(
		$rndEncryptionKey // '4t7w!z%C*F-JaNdRfUjXn2r5u8x/A?D(',		// The shared secret
	);

	$jweDecrypter = new JWEDecrypter(
		$keyEncryptionAlgorithmManager,
		$contentEncryptionAlgorithmManager,
		$compressionMethodManager
	);
	
	///////////////deserialize and decrypt the input we receive/////////////////

	$decryptionSuccess = $jweDecrypter->decryptUsingKey($jwe, $jwkAlgkey,0);

	if (!$decryptionSuccess) {
		exit('Unable to decrypt the token');
	}

	$response_json= $jwe->getPayload(); 

	//print_r(json_decode($jwe->getPayload(),1));
?>