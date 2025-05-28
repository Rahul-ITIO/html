<?
function getKey($seckey){
	$hashedkey = md5($seckey);
	$hashedkeylast12 = substr($hashedkey, -12);
	
	$seckeyadjusted = str_replace("FLWSECK-", "", $seckey);
	$seckeyadjustedfirst12 = substr($seckeyadjusted, 0, 12);
	
	$encryptionkey = $seckeyadjustedfirst12.$hashedkeylast12;
	return $encryptionkey;
}

function encrypt3Des($datas, $key){
	$encData = openssl_encrypt($datas, 'DES-EDE3', $key, OPENSSL_RAW_DATA);
	return base64_encode($encData);
}

?>