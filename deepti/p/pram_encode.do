<?

//<!--Replace of 3 very important parameters * your Website API Token and Website ID -->
// you may change these values to your own
$secret_key = '3d641ef2c0158346dc675800d583f17a263035dfc39ed2c56ff7551027177c4d';  // Secret Key 
$website_api_token = 'NDQ0NF83Nzc3XzIwMjAxMjE0MTYwMDQ0'; // Website API Token
$website_id="7777";	 // Website Id 
		
$gateway_url="https://manage.sifipay.com/payment";

#######################################################
//<!--default (fixed) value * default -->
	
$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
$referer=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];

$pramPost=array();

$pramPost["api_token"]=$website_api_token;   
$pramPost["website_id"]=$website_id;       

#################################################

$pramPost["cardsend"]="CHECKOUT";
$pramPost["client_ip"]=(isset($_SERVER['HTTP_X_FORWARDED_FOR'])?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR']);
$pramPost["action"]="product";
$pramPost["source"]="Sifi-Encode-Checkout";
$pramPost["source_url"]=$referer;

//<!--product price,curr and product name * by cart total amount -->

$pramPost["price"]="30.00";
$pramPost["curr"]="INR";
$pramPost["product_name"]="Testing Product or Description of your cart";

//<!--billing details of .* customer -->

$pramPost["ccholder"]="Test First Name";
$pramPost["ccholder_lname"]="Test Last Name";
$pramPost["email"]="test.4256@test.com";
$pramPost["bill_street_1"]="25A Alpha";
$pramPost["bill_street_2"]="tagore lane";
$pramPost["bill_city"]="Delhi";
$pramPost["bill_state"]="Delhi";
$pramPost["bill_country"]="India";
$pramPost["bill_zip"]="110001";
$pramPost["bill_phone"]="+91 9962200944";
$pramPost["id_order"]="20170131"; /// Merchant Order Id.
$pramPost["notify_url"]="https://yourdomain.com/notify.php";
$pramPost["success_url"]="https://yourdomain.com/success.php";
$pramPost["error_url"]="https://yourdomain.com/failed.php";

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
	if($encrypted){
		header("Location:{$gateway_url}?pram_encode={$encrypted}{$website_api_token}");exit;
	}
}

exit;


?>