<?php
$server_key=1;$kms_salts=1;	
# Server key from Other server call by curl this key update 90days wise

//core key if not to be get other server 
	$data_key['serverKey']=array(
		1=>'mRm6MTesPFk5R5Laap6p1Z7JaAYJKmpQbWXeVGiPsGz',
	);
	
	# Private key
	$data_salts['saltsKey']=array(
	   1=>'zP1LnkuY7bCiDSSNgW1zh6PkLCjVxSVaBqzZ',
	);

if ( isset($data_key['serverKey']) && $data_key['serverKey'] != "" && $data_key['serverKey'] != null ){
	$server_key_lastvalue = array_keys($data_key['serverKey']);
	$server_key = $server_key_lastvalue[sizeof($server_key_lastvalue)-1];
}

if ( isset($data_salts['saltsKey']) && $data_salts['saltsKey'] != "" && $data_salts['saltsKey'] !=null ){
	$kms_salts_lastvalue = array_keys($data_salts['saltsKey']);
	$kms_salts = $kms_salts_lastvalue[sizeof($kms_salts_lastvalue)-1];
}


//print_r($data_key); echo "<hr/>Key=> ".$data_key['serverKey'][$server_key]; echo "<hr/>server_key=> ".$server_key."<hr/>" ; print_r($data_salts); echo "<hr/>salts=> ".$data_salts['saltsKey'][$kms_salts]; echo "<hr/>kms_salts=> ".$kms_salts."<hr/>" ;


//$server_key=1;
function getKeys256($key='') {
	global $data_key; global $server_key;
	if(!empty($key)){
		$server_key=$key;
		}
	$key=$data_key['serverKey'][$server_key];
	return $key;
}
function getPrivateSaltsKeys($key='') {
	global $data_salts; global $kms_salts;
	if(!empty($key)){
		$kms_salts=$key;
	}
	$key=$data_salts['saltsKey'][$kms_salts];
	return $key;
}
function card_encrypts256($ccno) {
	global $data_key; global $server_key; global $kms_salts;
	$publicKey = getKeys256();
	$privateSaltsKey = getPrivateSaltsKeys();
	$encryptedData=encrypts256($ccno, $publicKey, $privateSaltsKey);
	
	$ccno='{"decrypt":"'.urlencode($encryptedData).'","key":"'.$server_key.'","saltsKey":"'.$kms_salts.'","encode":"1"}';
	return $ccno;
}
function card_decrypts256($ccno) {
	$not_encrypted=jsonvaluef($ccno,"not_encrypted");
	if($not_encrypted){
		$ccno=jsonvaluef($ccno,"decrypt");
	}else{
	
	
		$server_key=jsonvaluef($ccno,"key");
		$publicKey = getKeys256($server_key);
		
		$saltsKey=jsonvaluef($ccno,"saltsKey");
		if((isset($saltsKey))&&(!empty($saltsKey))){
			$server_key=$saltsKey;
		}
		
		$privateSaltsKey = getPrivateSaltsKeys($server_key);
		
		$encode=$ccno;
		$ccno=jsonvaluef($ccno,"decrypt");
		if(($encode)&&(strpos($encode,"encode")!==false)){
			$ccno=urldecode($ccno);
		}
		
		$ccno=decrypts256($ccno, $publicKey, $privateSaltsKey);
		$ccno=ccnois($ccno);
	}
	
	
	return $ccno;
}
function checkKeys256($key, $method) {
	if (strlen($key) < 32) {
		echo "Invalid public key $key, key must be at least 256 bits (32 bytes) long."; 
		//die();
	}
}

# Decrypt a value using AES-256.	
function decrypts256($string,$dek_key,$secret_key) {
    $output = false;
    $encrypt_method = "AES-256-CBC";
    $iv = substr( hash( 'sha256', $dek_key ), 0, 16 );
	$output = openssl_decrypt( base64_decode( $string ), $encrypt_method, $secret_key, 0, $iv );
    return $output;
}

# Encrypt a value using AES-256.
function encrypts256($string,$dek_key,$secret_key) {
    $output = false;
    $encrypt_method = "AES-256-CBC";
    $iv = substr( hash( 'sha256', $dek_key ), 0, 16 );
    $output = rtrim( strtr( base64_encode( openssl_encrypt( $string, $encrypt_method, $secret_key, 0, $iv ) ), '+/', '-_'), '=');
    return $output;
}
#Get Random String - Usefull for public key
function genRandString($length = 0) { //genRandString(32);
	$charset = 'abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ@$%^';
	$str = '';
	$count = strlen($charset);
	while ($length-- > 0) {
		$str .= $charset[mt_rand(0, $count-1)];
	}
	return $str;
}
//echo "<hr/>".genRandString(256);
//echo "<hr/>".genRandString(32);		
?>