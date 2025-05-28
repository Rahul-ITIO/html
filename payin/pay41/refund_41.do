<?php
if(!isset($_SESSION['adm_login'])){
	echo('ACCESS DENIED.');
	exit;
}

if(empty($acquirer_refund_url)){
	$acquirer_refund_url="https://gate.lonapay24.com/payment/api/v2/return";
}

//check if test mode than assing uat status url 

if(@$acquirer_prod_mode==2||@$apc_get['mode']=='test') $acquirer_refund_url="https://sandbox.lonapay24.com/payment/api/v2/return";

$acquirer_refund_url	= @$acquirer_refund_url."/".@$apc_get['endpoint_group_id'];  


if(empty($acquirer_ref)) echo "<br/><b>Acquirer Ref not found</b><br/>".$acquirer_ref;




//if(!isset($_GET['rtest']))
{
	echo "<hr/>acquirer_refund_url=>".$acquirer_refund_url;
}


#########################################################


//control will send from here

$postreq['login'] = @$apc_get['login_id'];
$postreq['client_orderid'] = @$apc_get['endpoint_group_id'];
$postreq['orderid'] = @$acquirer_ref;
$postreq['amount_in_cents'] = (double)$paramsInfo['refundAmount'] * 100;
$postreq['currency'] = $paramsInfo['refundCurrency'];
$postreq['merchant_control']=@$apc_get['control_key'];
  
  $str = $postreq['login'].''.$postreq['client_orderid'].''.$postreq['orderid'].''.$postreq['amount_in_cents'].''.$postreq['currency'].''.$postreq['merchant_control'];


if($data['cqp']>0) echo "<br/>sha1 str=>".$str;
	
$checksum = sha1($str);

if($data['cqp']>0) echo "<br/>sha1 checksum=>".$checksum;

############################################################

$postreq['control']=$checksum;
$postreq['comment']="Refund request to".@$transID; 

if(isset($_GET['rtest']))
{
	echo "<hr/>postreq=>";
	print_r(@$postreq);	

}

$postreqStr=http_build_query($postreq);

if($data['cqp']>0||isset($_GET['rtest'])) echo "<br/>postreqStr=>".$postreqStr;



$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => $acquirer_refund_url,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_HEADER => 0,
  CURLOPT_SSL_VERIFYPEER => 0,
  CURLOPT_SSL_VERIFYHOST => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS => $postreqStr,
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/x-www-form-urlencoded'
  ),
));

$response = curl_exec($curl);

curl_close($curl);

//echo $response;



#########################################################

$res='https://view?'.$response;

$res=urldecodef($res);

//remove tab and new line from json encode value 
//$res = preg_replace('~[\r\n\t]+~', '', $res);
//$res = str_ireplace(["n&"," &"], '&', $res);

parse_str(parse_url($res, PHP_URL_QUERY), $result);

#########################################################

	//if(!isset($_GET['rtest']))
	{
		echo "<hr/>result=>";print_r($result);
	}
	
	
	if((!empty($result['code']))&&($result['code']=='0000')){
		$post_reply="Refund Successful";
		$live_refund_status='Y';
	}
	else $live_refund_status='N';
	
	

?>