<?php
// http://localhost/testPoject/ws_demo_en_status_2.do

error_reporting(E_ALL); // check all type of errors
ini_set('display_errors', 1); // display those errors
ini_set('log_errors ', 1); // display those errors
ini_set('error_log ', 1); // display those errors

function array2String($arr){
	$str = '';
	$arr_length = count($arr)-1;
	foreach( $arr as $key => $value ){
		$str.=$key.'='.$value.'&';
	}
	return urldecode($str);

}
	
	$acquirer_status_url='https://payment.bestorpay.com/payment/external/query';
	
	$merNo=$apc_set['merNo']='800086558';
	$orderNo=$apc_set['orderNo']='1710390875';
	$tradeNo=$apc_set['tradeNo']='1517103908753732';
	$amount=$apc_set['amount']='6.50';
	$currency=$apc_set['currency']='USD';
	$hashcode='821802da8f12442badffb1ab2d0ccc48';

	
	$hash_code=hash("sha256",$merNo.$orderNo.$amount.$currency.$hashcode);
		
	$signature_data="merNo=".$merNo."&orderNo=".$orderNo."&tradeNo=".$tradeNo."&amount=".$amount."&currency=".$currency."&signature=".$hash_code."&";
	
	$apc_set['signature']=@$hash_code;
	
	$apc_set2=array2String($apc_set);
	

echo "<hr/>acquirer_status_url=> ";print_r($acquirer_status_url);	
echo "<hr/>apc_set2=> ";print_r($apc_set2);	
echo "<hr/>strlen=> ".strlen($apc_set2);	
	
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $acquirer_status_url);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/x-www-form-urlencoded'));   
curl_setopt($ch, CURLOPT_POSTFIELDS, $apc_set2);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); 
$result = curl_exec($ch);

echo "<br/>result=>".$result;



$file_get_contents=file_get_contents("$acquirer_status_url", FALSE, NULL, 0, strlen($apc_set2));

echo "<hr/>file_get_contents=> ".$file_get_contents;
	
?>

<pre>
	<code>
		
function array2String($arr){
	$str = '';
	$arr_length = count($arr)-1;
	foreach( $arr as $key => $value ){
		$str.=$key.'='.$value.'&';
	}
	return urldecode($str);

}
	
	$acquirer_status_url='https://payment.bestorpay.com/payment/external/query';
	
	$merNo=$apc_set['merNo']='800086558';
	$orderNo=$apc_set['orderNo']='1710390875';
	$tradeNo=$apc_set['tradeNo']='1517103908753732';
	$amount=$apc_set['amount']='6.50';
	$currency=$apc_set['currency']='USD';
	$hashcode='821802da8f12442badffb1ab2d0ccc48';

	
	$hash_code=hash("sha256",$merNo.$orderNo.$amount.$currency.$hashcode);
		
	$signature_data="merNo=".$merNo."&orderNo=".$orderNo."&tradeNo=".$tradeNo."&amount=".$amount."&currency=".$currency."&signature=".$hash_code."&";
	
	$apc_set['signature']=@$hash_code;
	
	$apc_set2=array2String($apc_set);
	

echo "<hr/>acquirer_status_url=> ";print_r($acquirer_status_url);	
echo "<hr/>apc_set2=> ";print_r($apc_set2);	
echo "<hr/>strlen=> ".strlen($apc_set2);	
	
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $acquirer_status_url);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/x-www-form-urlencoded'));   
curl_setopt($ch, CURLOPT_POSTFIELDS, $apc_set2);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); 
$result = curl_exec($ch);

echo "<br/>result=>".$result;



$file_get_contents=file_get_contents("$acquirer_status_url", FALSE, NULL, 0, strlen($apc_set2));

echo "<hr/>file_get_contents=> ".$file_get_contents;
	
	</code>
</pre>
