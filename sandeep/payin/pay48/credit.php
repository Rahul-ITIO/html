<?
$salt ="DGOWXA1QBO";
$post['key']="QOD594EXO8";
$post['txnid']=rand();
$post['amount']="50.0";
$post['productinfo']="test";
$post['firstname']="deepti";
$post['phone']="+9977997799";
$post['email']="deepti@gmail.com";
$post['surl']="http://localhost/test/success.php";
$post['furl']="http://localhost/test/cancel.php";
//$post['furl']="http://localhost/test/cancel.php";

  $hashSequence = $post['key'] . "|" . $post['txnid']. "|" . $post['amount'] . "|" . $post['productinfo'] . "|" .$post['firstname'] . "|" . $post['email'] ."|" . "|" . "|" . "|"  ."|" . "|" . "|" . "|" . "|" . "|" .  "|" . $salt;
   $hash = hash('sha512', $hashSequence);
  $post['hash']=$hash;
  //$post['show_payment_mode']="NB";
  $post['request_flow']="SEAMLESS";
  //print_r($post);
  //exit;
  $string = http_build_query($post);
  $curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://pay.easebuzz.in/payment/initiateLink',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS => $string ,
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/x-www-form-urlencoded'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
//echo $response;
$res = json_decode($response,1);
//print_r($res);
//exit;
  $access_Key=$res['data'];
$method = "aes-256-cbc";
   
    $key = substr(hash('sha256', 'QOD594EXO8'), 0, 32);
	$iv = substr(hash('sha256', 'DGOWXA1QBO'), 0, 16);
	$card="4017041875022763";//here is card number
	$encrypted_card_number = $card;
	$encrypted_card_number = openssl_encrypt($encrypted_card_number, $method, $key, 0, $iv);  
	$name = "test";
    $encrypted_card_holder_name = $name;
    $encrypted_card_holder_name = openssl_encrypt($encrypted_card_holder_name, $method, $key, 0, $iv);  
	$cvv="462";
    $encrypted_card_cvv = $cvv;
    $encrypted_card_cvv = openssl_encrypt($cvv, $method, $key, 0, $iv);  
	 $date="08/2029";
     $encrypted_card_expiry_date =  $date;
    $encrypted_card_expiry_date = openssl_encrypt($date, $method, $key, 0, $iv);
	$postData['access_key']= $access_Key;
	$postData['payment_mode']= "DC";
    $postData['card_number']= $encrypted_card_number;
    $postData['card_holder_name']= $encrypted_card_holder_name;
    $postData['card_cvv']= $encrypted_card_cvv;
    $postData['card_expiry_date']= $encrypted_card_expiry_date;


$StringUPI = http_build_query($postData);


$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
$referer=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
$gateway_url = "https://pay.easebuzz.in/initiate_seamless_payment/";



$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, 'https://pay.easebuzz.in/initiate_seamless_payment/');
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$response = curl_exec($ch);
curl_close($ch);

// Extract CSRF token from response
preg_match('/<input type="hidden" name="csrf_token" value="(.*)"\/>/', $response, $matches);
$csrfToken = $matches[1];

$curl = curl_init();
//curl_setopt($curl, CURLOPT_REFERER, $referer);
curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://pay.easebuzz.in/initiate_seamless_payment/',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_SSL_VERIFYPEER => 0,
  CURLOPT_SSL_VERIFYHOST => 0,
  CURLOPT_USERAGENT=> $_SERVER['HTTP_USER_AGENT'],
  CURLOPT_REFERER => $referer,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS => $StringUPI ,
   CURLOPT_HEADER=> 0,
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/x-www-form-urlencoded',
	'X-CSRFToken: ' . $csrfToken, 
  ),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;





?>
