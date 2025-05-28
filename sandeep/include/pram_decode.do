<?

function data_decode_f($string,$secret_key,$website_api_token) {
    $output = false;
    $encrypt_method = "AES-256-CBC";
    $iv = substr( hash( 'sha256', $website_api_token ), 0, 16 );
	$output = openssl_decrypt( base64_decode( $string ), $encrypt_method, $secret_key, 0, $iv );
    return $output;
}



if(isset($_REQUEST['pram_encode'])&&$_REQUEST['pram_encode']){
	
	//45167719091014e07fd489edade4550d2b20370bea013df167334226929d0324
	$secret_key = '45167719091014e07fd489edade4550d2b20370bea013df167334226929d0324';
	$website_api_token = 'MjdfMTEyMl8yMDE4MDcyNTE0NDc1OA';

	echo "<hr/>website_api_token=>".$website_api_token;


	$pram_encode=strip_tags($_REQUEST['pram_encode']);
	
	$website_api_token = substr( $pram_encode, -30 );
	$pram_encode=str_replace($website_api_token,'',$pram_encode);
	echo "<hr/>website_api_token=>".$website_api_token;
	echo "<hr/>pram_encode=>".$pram_encode;
	
	$decryptf = data_decode_f($pram_encode,$secret_key,$website_api_token);

	echo "<hr/>decrypted=>".($decryptf);

	parse_str($decryptf,$decrypted);
	
	
	echo "<hr/>parse_str=>";
	print_r($decrypted);
	
	echo "<br/><br/><br/><br/><hr/>ccno=>".$decrypted['ccno'];
	echo "<hr/>year=>".$decrypted['year'];
	echo "<hr/>month=>".$decrypted['month'];
	echo "<hr/>ccvv=>".$decrypted['ccvv'];
	
}
	



	
	


exit;



if(isset($_REQUEST['pram_encode'])&&$_REQUEST['pram_encode']){
	$secret_key = '45167719091014e07fd489edade4550d2b20370bea013df167334226929d0324';
	$pram_encode=strip_tags($_REQUEST['pram_encode']);
	$website_api_token = substr( $pram_encode, -30 );
	$pram_encode=str_replace($website_api_token,'',$pram_encode);		
	$decryptf = data_decode_f($pram_encode,$secret_key,$website_api_token);
	parse_str($decryptf,$decrypted);
	$_POST=array_merge($_POST,$decrypted);
	$post=$_POST;
	//print_r($_POST);
}



?>