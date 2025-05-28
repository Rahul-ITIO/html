<?




$gateway_url="http://localhost/gw/charge.do";

	
$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
$referer=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];

// you may change these values to your own
$secret_key = '45167719091014e07fd489edade4550d2b20370bea013df167334226929d0324';
$website_api_token = 'MjdfMTEyMl8yMDE4MDcyNTE0NDc1OA';
	
	
$pramPost=array();

//<!--Replace of 2 very important parameters * your Website API Token and Website ID -->

$pramPost["api_token"]=$website_api_token;    // Website API Token 
$pramPost["website_id"]="1120";        // Website Id 

//<!--default (fixed) value * default -->

//$pramPost["cardsend"]="curl";
$pramPost["cardsend"]="CHECKOUT";
$pramPost["client_ip"]=(isset($_SERVER['HTTP_X_FORWARDED_FOR'])?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR']);
$pramPost["action"]="product";
$pramPost["source"]="Curl-Direct-Card-Payment";
$pramPost["source_url"]=$referer;

//<!--product price,curr and product name * by cart total amount -->

$pramPost["price"]="30.00";
$pramPost["curr"]="USD";
$pramPost["product_name"]="Testing Product";

//<!--billing details of .* customer -->

$pramPost["ccholder"]="Test First Name";
$pramPost["ccholder_lname"]="Test Last Name";
$pramPost["email"]="test.4256@test.com";
$pramPost["bill_street_1"]="25A Alpha";
$pramPost["bill_street_2"]="tagore lane";
$pramPost["bill_city"]="Jurong";
$pramPost["bill_state"]="Singapore";
$pramPost["bill_country"]="Singapore";
$pramPost["bill_zip"]="787602";
$pramPost["bill_phone"]="+65 62200944";
$pramPost["id_order"]="20170131";
$pramPost["notify_url"]="https://yourdomain.com/notify.php";
$pramPost["success_url"]="https://yourdomain.com/success.php";
$pramPost["error_url"]="https://yourdomain.com/failed.php";

//<!--card details of .* customer -->

$pramPost["ccno"]="4242424242424242";
$pramPost["ccvv"]="123";
$pramPost["month"]="01";
$pramPost["year"]="30";
$pramPost["notes"]="Remark for transaction";

if(isset($_REQUEST['ccno'])&&$_REQUEST['ccno']){
	$pramPost["ccno"]=$_REQUEST['ccno'];
	
}

$get_string=http_build_query($pramPost);


function data_encode($string,$secret_key,$website_api_token) {
    $output = false;
    $encrypt_method = "AES-256-CBC";
    $iv = substr( hash( 'sha256', $website_api_token ), 0, 16 );
    $output = rtrim( strtr( base64_encode( openssl_encrypt( $string, $encrypt_method, $secret_key, 0, $iv ) ), '+/', '-_'), '=');
    return $output;
}

if($get_string){	
	$encrypted = data_encode($get_string,$secret_key,$website_api_token);
	header("Location:{$gateway_url}?pram_encode={$encrypted}{$website_api_token}");exit;
	/*
	echo "<hr/>encrypted=>".$encrypted;
	echo "<hr/><a target='_blank' href='pram_decode.do?pram_encode={$encrypted}{$website_api_token}' >Continue...<a/>";
	echo "<hr/><a target='_blank' href='../charge.do?pram_encode={$encrypted}{$website_api_token}' >Charge to Continue...<a/>";
	*/
	
}

exit;





?>