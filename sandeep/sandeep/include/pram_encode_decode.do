<?




$gateway_url="http://localhost/gw/api.do";
	
$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
$referer=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];

$curlPost=array();

//<!--Replace of 2 very important parameters * your Website API Token and Website ID -->

$curlPost["api_token"]="MjZfMTEyMF8yMDE4MDcyNzEyMjgyNQ";    // Website API Token 
$curlPost["website_id"]="1120";        // Website Id 

//<!--default (fixed) value * default -->

$curlPost["cardsend"]="curl";
$curlPost["client_ip"]=(isset($_SERVER['HTTP_X_FORWARDED_FOR'])?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR']);
$curlPost["action"]="product";
$curlPost["source"]="Curl-Direct-Card-Payment";
$curlPost["source_url"]=$referer;

//<!--product price,curr and product name * by cart total amount -->

$curlPost["price"]="30.00";
$curlPost["curr"]="USD";
$curlPost["product_name"]="Testing Product";

//<!--billing details of .* customer -->

$curlPost["ccholder"]="Test First Name";
$curlPost["ccholder_lname"]="Test Last Name";
$curlPost["email"]="test.4256@test.com";
$curlPost["bill_street_1"]="25A Alpha";
$curlPost["bill_street_2"]="tagore lane";
$curlPost["bill_city"]="Jurong";
$curlPost["bill_state"]="Singapore";
$curlPost["bill_country"]="Singapore";
$curlPost["bill_zip"]="787602";
$curlPost["bill_phone"]="+65 62200944";
$curlPost["id_order"]="20170131";
$curlPost["notify_url"]="https://yourdomain.com/notify.php";
$curlPost["success_url"]="https://yourdomain.com/success.php";
$curlPost["error_url"]="https://yourdomain.com/failed.php";

//<!--card details of .* customer -->

$curlPost["ccno"]="4242424242424242";
$curlPost["ccvv"]="123";
$curlPost["month"]="01";
$curlPost["year"]="20";
$curlPost["notes"]="Remark for transaction";


echo $get_string=http_build_query($curlPost);
//echo $get_string=http_build_query($_GET);

function encrypt_decrypt_1($string, $action){
    $output = false;

	$encrypt_method = "AES-256-CBC";
	$secret_key = 'This is my secret key';
	$website_api_token = 'This is my secret iv';

	// hash
	$key = hash('sha256', $secret_key);

	// iv - encrypt method AES-256-CBC expects 16 bytes - else you will get a warning
	$iv = substr(hash('sha256', $website_api_token), 0, 16);

	if( $action == 'encrypt' ) {
		$output = openssl_encrypt($string, $encrypt_method, $key, 0, $iv);
		//$output = base64_encode($output);
		$output = rtrim( strtr( base64_encode($output), '+/', '-_'), '=');
	}
	else if( $action == 'decrypt' ){
		$output = openssl_decrypt(base64_decode($string), $encrypt_method, $key, 0, $iv);
	}

	return $output;
}

//$secret_key = '{"mid":"27","username":"521"}'; $secret_key = hash( 'sha256', $secret_key ); echo "<hr/>secret_key=>".$secret_key;
//$secret_key = '{"mid":"4444","username":"9315980939"}'; $secret_key = hash( 'sha256', $secret_key ); echo "<hr/>secret_key=>".$secret_key;

function my_simple_crypt( $string, $action = 'e' ) {
    // you may change these values to your own
    //$secret_key = 'my_simple_secret_key';
    //$website_api_token = 'my_simple_website_api_token';
	$secret_key = 'MjZfMTEyMF8yMDE4MDcyN';
    $website_api_token = 'MjZfMTEyMF8yMDE4MDcyNzEyMjgyNQ';
 
    $output = false;
    $encrypt_method = "AES-256-CBC";
    $key = hash( 'sha256', $secret_key );
    $iv = substr( hash( 'sha256', $website_api_token ), 0, 16 );
	
	echo "<hr/>key=>".$key; echo "<hr/>iv=>".$iv;
	
    if( $action == 'e' ) {
        $output = rtrim( strtr( base64_encode( openssl_encrypt( $string, $encrypt_method, $key, 0, $iv ) ), '+/', '-_'), '=');
    }
    else if( $action == 'd' ){
        $output = openssl_decrypt( base64_decode( $string ), $encrypt_method, $key, 0, $iv );
    }
 
    return $output;
}

##################################################

function data_encode($string,$secret_key,$website_api_token) {
    $output = false;
    $encrypt_method = "AES-256-CBC";
    $iv = substr( hash( 'sha256', $website_api_token ), 0, 16 );
    $output = rtrim( strtr( base64_encode( openssl_encrypt( $string, $encrypt_method, $secret_key, 0, $iv ) ), '+/', '-_'), '=');
    return $output;
}

function data_decode_f($string,$secret_key,$website_api_token) {
    $output = false;
    $encrypt_method = "AES-256-CBC";
    $iv = substr( hash( 'sha256', $website_api_token ), 0, 16 );
	$output = openssl_decrypt( base64_decode( $string ), $encrypt_method, $secret_key, 0, $iv );
    return $output;
}


##################################################


if($get_string){
	
	$encrypted = my_simple_crypt( $get_string, 'e' );

	echo "<hr/>encrypted=>".$encrypted;

	$decrypted = my_simple_crypt( $encrypted, 'd' );

	echo "<hr/>decrypted=>".($decrypted);
	
	parse_str($decrypted,$decrypted);
	
	
	//$decrypted=parse_str($decrypted);
	
	echo "<hr/>parse_str=>";
	print_r($decrypted);
	
	echo "<br/><br/><br/><br/><hr/>ccno=>".$decrypted['ccno'];
	echo "<hr/>year=>".$decrypted['year'];
	echo "<hr/>month=>".$decrypted['month'];
	echo "<hr/>ccvv=>".$decrypted['ccvv'];
	

}
else{
	echo "-------------------------";
	$encrypted = my_simple_crypt( 'Hello World!', 'e' );

	echo "<hr/>encrypted=>".$encrypted;

	$decrypted = my_simple_crypt( 'RTlOMytOZStXdjdHbDZtamNDWFpGdz09', 'd' );

	echo "<hr/>decrypted=>".$decrypted;
}
exit;





?>