<?php

// http://localhost/testPoject/ws_demo_en_status.php

function array2String($arr){
		$str = '';
		$arr_length = count($arr)-1;
		foreach( $arr as $key => $value ){
			$str.=$key.'='.$value.'&';
		}
		return urldecode($str);

	}
function http_post($payUrl, $postData) {
	$webSite = empty ( $_SERVER ['HTTP_REFERER'] ) ? $_SERVER ['HTTP_HOST'] : $_SERVER ['HTTP_REFERER'];
	//$webSite = 'www.test01.com';
	//$webSite = 'localhost';
	$options = array (
	   'http' => array (
			'method'  => "GET",
			'header'  => "Accept-language:en\r\n"."Content-type:application/x-www-form-urlencoded\r\n".
						 "Content-Length:".strlen($postData)."\r\n"."referer:".$webSite."\r\n",
			'content' => $postData, 
			'timeout' => 90 
		) 
	); 
	$context = stream_context_create($options);
	return file_get_contents($payUrl, false, $context);
}	
	
	
	$acquirer_status_url='https://payment.bestorpay.com/payment/external/query';
	//$acquirer_status_url='https://payment.gantenpay.com/payment/external/query';
	
	
	$merNo=$apc_set['merNo']='800086558';
	$orderNo=$apc_set['orderNo']='392008723';
	$tradeNo=$apc_set['tradeNo']='3817104023841993';
	$amount=$apc_set['amount']='7.01';
	$currency=$apc_set['currency']='USD';
	$hashcode='821802da8f12442badffb1ab2d0ccc48';

	
	$hash_code=hash("sha256",$merNo.$orderNo.$amount.$currency.$hashcode);
		
	$signature_data="merNo=".$merNo."&orderNo=".$orderNo."&tradeNo=".$tradeNo."&amount=".$amount."&currency=".$currency."&signature=".$hash_code."&";
	
	$apc_set['signature']=@$hash_code;
	
	echo "<hr/>acquirer_status_url=> ".$acquirer_status_url;
	echo "<hr/>hash_code=> ".$hash_code;
	echo "<hr/>signature_data=> ".$signature_data;
	echo "<hr/>apc_set=> ";print_r($apc_set);
	
	$apc_set2=array2String($apc_set);
	
	echo "<hr/>array2String=> ";print_r($apc_set);
	
	$file_get_contents=file_get_contents($acquirer_status_url."?".$apc_set2, false, NULL, 0,);
	
	echo "<hr/>file_get_contents=> ".$file_get_contents;
	
	
	
$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => $acquirer_status_url,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'GET',
  CURLOPT_POSTFIELDS =>$apc_set,
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/json'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
echo "<hr/>response_0=>".$response;

	

	$ch = curl_init();
	curl_setopt($ch,CURLOPT_URL, $acquirer_status_url);
	curl_setopt($ch,CURLOPT_HEADER, 0);
	curl_setopt($ch,CURLOPT_POST,1);
	curl_setopt($ch,CURLOPT_POSTFIELDS,$apc_set);
	curl_setopt($ch,CURLOPT_RETURNTRANSFER,10);
	curl_setopt($ch,CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_1); 
	curl_setopt($ch,CURLOPT_SSL_VERIFYPEER, false); 
	curl_setopt($ch,CURLOPT_SSL_VERIFYHOST, false);
	//curl_setopt($ch,CURLOPT_HTTPHEADER, ['Content-Type: application/json']); 
	$response = curl_exec($ch);
	curl_close($ch);

	
	$response_decode = json_decode($response,true);
	
	
	echo "<hr/>response=>".$response;
	echo "<hr/>response_decode=>";print_r($response_decode);
	
	
	
	
	$response  = http_post($acquirer_status_url,$apc_set2);
	
	$response_decode = json_decode($response,true);
	
	
	echo "<hr/>response=>".$response;
	echo "<hr/>response_decode=>";print_r($response_decode );
	
	
	
	
	
	
	$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
$referer=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];

	$curl_cookie="";
$curl = curl_init(); 
curl_setopt($curl, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);
curl_setopt($curl, CURLOPT_URL, $acquirer_status_url);
curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 0);
curl_setopt($curl, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']);
curl_setopt($curl, CURLOPT_REFERER, $referer);
curl_setopt($curl, CURLOPT_POST, 1);
curl_setopt($curl, CURLOPT_POSTFIELDS, $apc_set);
curl_setopt($curl, CURLOPT_HEADER, 0);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
$response = curl_exec($curl);
curl_close($curl);

$results = json_decode($response,true);
	
	if($results) print_r($results);
	else echo "<br/>response=>".$response; 
	
	

echo "<hr/>acquirer_status_url=> ";print_r($acquirer_status_url);	
echo "<hr/>apc_set2=> ";print_r($apc_set2);	
	
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $acquirer_status_url);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/x-www-form-urlencoded'));   
curl_setopt($ch, CURLOPT_POSTFIELDS, $apc_set2);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); 
$result = curl_exec($ch);

echo "<br/>result=>".$result;
	
	
	
	
//this send application/x-www-form-urlencoded                                                                                                     
function httpPostXform($url, $data) {                                                                 
	$curl = curl_init($url);                                                                            
	curl_setopt($curl, CURLOPT_POST, true);                                                             
	curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($data));                                    
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);                                                   
	curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type: application/x-www-form-urlencoded'));   
	$response = curl_exec($curl);                                                                       
	curl_close($curl);                                                                                  
	return $response;                                                                      
}                                                                                                       
$r = httpPostXform($acquirer_status_url,$apc_set);
	
echo "<br/>result=>".$r;

?>
