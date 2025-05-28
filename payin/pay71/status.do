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
	$client_secret	= $apc_get['IBL-Client-Secret'];
	$apiUrl			= $acquirer_status_url;
	$certFile		= $data['Path'].'/payin/pay'.$apc_get['default_mid'].'/'.$apc_get['mode'].'_indusapi.indusind.com-sscert.pem';
	$pgMerchantId	= $apc_get['pgMerchantId'];

	$Payload = [
		'pgMerchantId' => "$pgMerchantId",
		'searchType' => "RRN",
		'gwRrn' =>"LTP1111".time(),
		'fromDate' => "",
		'toDate' => "",
		'phone' => "",
		'recordsPerPage' => "",
		'pageNumber' => "",
		'custRefNo' => "$acquirer_ref",
		'npciTranId' => "$transID",
		'pspRefNo' => "$transID",
	];

//	print_r($Payload);echo '<br><br>';

	if($qp)
	{
		echo '<div type="button" class="btn btn-success my-2" style="background:#ac7d26;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
		
		echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
		echo "<br/>custRefNo=> ".$acquirer_ref;
		echo "<br/>npciTranId=> ".$transID;
		echo "<br/>pgMerchantId=> ".$pgMerchantId;
		echo "<br/>certFile=> ".$certFile;
		//echo "<br/>merchantTranId=> ".$transID;
		//echo "<br/>bank_mid=>".$bank_mid;

		echo '<br/><br/></div>';
		
	}
		

	$data_res = json_encode($Payload);
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
		->withPayload($data_res)	// We set the payload
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
//	$certFile = 'indusinduat-publickey.txt';
//	$certFile = 'indusapi.indusind.com-sscert.pem';
	$key = JWKFactory::createFromKeyFile(
		$certFile,	//The indus certificate filename
		'',							// Secret if the key is encrypted, otherwise null
		[
			'use' => 'enc',			// Additional parameters
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
	$httpUrl = $apiUrl;

	$headers = array(
		'IBL-Client-Id: '.$client_id,
		'IBL-Client-Secret: '.$client_secret,
		'Content-Type: application/json',
	);

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
	
	$res = curl_exec($curl);
	$httpcode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
	curl_close($curl);
	
	$response = json_decode($res)->data;
	
	//cmn
	/*
	$response = jsondecode($res,1,1);
	if(@$pq)
	{
		echo "<br/><br/>res=>".$res;
		echo "<br/><br/>response=>"; print_r($response);
	}
	$response = @$response['data'];
	*/
	
	

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
	
	////////////////////////////////deserialize and decrypt the input we receive/////////////////////////////

	$decryptionSuccess = $jweDecrypter->decryptUsingKey($jwe, $jwkAlgkey,0);

	if (!$decryptionSuccess) {

		exit('Unable to decrypt the token');
	}

	$response_json = $jwe->getPayload(); 
	
	
	
	

	//print_r(json_decode($jwe->getPayload(),1));
?>