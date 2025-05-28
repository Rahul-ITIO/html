<?php
include('../config_root.do');

// you may change these values to your own
$secret_key = '0ca40e54ff0b814b8f4e8eadadb7f04065de67248a8c3ce7e69b0e1aa67a9355';  // Secret Key 
$payout_token = 'YWZoNzE0c1MzblhhM1h2blJqU2tyemF3TFBHaHo1Tm4xUll2ZXVRRDhaVUdFb1dabHpreU56RzVjSjFtYkFpMA'; // Website API Token

$gateway_url=$data['Host']."/payout/payoutapi.do";

#######################################################
//<!--default (fixed) value * default -->
	
$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
$referer=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];

$pramPost=array();

$pramPost["payout_token"]=$payout_token;   

#################################################

$pramPost["client_ip"]=(isset($_SERVER['HTTP_X_FORWARDED_FOR'])?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR']);
$pramPost["action"]="payout";
$pramPost["source"]="Payout-Encode";
$pramPost["source_url"]=$referer;
$pramPost["payout_secret_key"]="test";//encode_f("test",0);

//<!--product price,curr and product name * by cart total amount -->

$pramPost["price"]="30.00";
$pramPost["curr"]="USD";
$pramPost["product_name"]="Testing Product or Description of your cart";

//<!--billing details of .* customer -->

$pramPost["ccholder"]="Test First Name";
$pramPost["ccholder_lname"]="Test Last Name";
$pramPost["email"]="test.4256@test.com";
$pramPost["bill_phone"]="+91 9962200944";
$pramPost["id_order"]="20170131"; /// Merchant Order Id.
$pramPost["notify_url"]="https://yourdomain.com/notify.php";
$pramPost["success_url"]="https://yourdomain.com/success.php";
$pramPost["error_url"]="https://yourdomain.com/failed.php";

$get_string=http_build_query($pramPost);

function data_encode($string,$secret_key,$payout_token) {
    $output = false;
    $encrypt_method = "AES-256-CBC";
    $iv = substr( hash( 'sha256', $payout_token ), 0, 16 );
    $output = rtrim( strtr( base64_encode( openssl_encrypt( $string, $encrypt_method, $secret_key, 0, $iv ) ), '+/', '-_'), '=');
    return $output;
}

if($get_string){	
	$encrypted = data_encode($get_string,$secret_key,$payout_token);
	if($encrypted){
		header("Location:{$gateway_url}?pram_encode={$encrypted}{$payout_token}");exit;
	}
}

exit;


?>