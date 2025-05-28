<?php
if(!isset($_SESSION['adm_login'])){
	echo('ACCESS DENIED.');
	exit;
}

$merchant_id=@$apc_get['merchant_id'];
$api_password_key=@$apc_get['api_password_key'];

$apiUsername='merchant.'.$merchant_id;
$PWD=$api_password_key; //'4d3f8e07b2c625d779b81c678086cc1d'; // api 
$AuthorizationBasic='Basic bWVyY2hhbnQuR0xBRENPUklHS0VOOjRkM2Y4ZTA3YjJjNjI1ZDc3OWI4MWM2NzgwODZjYzFk';

if(isset($apc_get['authorization'])&&trim($apc_get['authorization'])){
  $AuthorizationBasic='Basic '.@$apc_get['authorization'];
}

//echo "<hr/>acquirer_refund_url1=>".$acquirer_refund_url;

if(empty($acquirer_refund_url)||$acquirer_refund_url=='NA'){
	$acquirer_refund_url="https://ap-gateway.mastercard.com/api/rest/version/78/merchant";
}

//echo "<hr/>acquirer_refund_url2=>".$acquirer_refund_url;

//check if test mode than assing uat status url 

if(@$acquirer_prod_mode==2||@$apc_get['mode']=='test') $acquirer_refund_url="https://ap-gateway.mastercard.com/api/rest/version/78/merchant";

// https://ap-gateway.mastercard.com/api/rest/version/78/merchant/GLADCORIGKEN/order/orderTEST1/transaction/transTEST20
$acquirer_refund_url	= @$acquirer_refund_url.'/'.$merchant_id.'/order/'.@$transID.'/transaction/trans'.$transID; 


if(empty($acquirer_ref)) echo "<br/><b>Acquirer Ref not found</b><br/>".$acquirer_ref;




//if(!isset($_GET['rtest']))
{
	echo "<hr/>acquirer_refund_url=>".$acquirer_refund_url;
}


#########################################################

############################################################

$postreqStr='{
  "apiOperation": "REFUND",
  "transaction": {
      "amount": '.@$paramsInfo['refundAmount'].',
      "currency": "'.@$paramsInfo['refundCurrency'].'",
      "reference": "'.@$transID.'"
  }
}';

if($data['cqp']>0||isset($_GET['rtest'])) echo "<br/>postreqStr=>".$postreqStr;



$curl = curl_init();

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => $acquirer_refund_url,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'PUT',
    CURLOPT_HEADER => 0,
    CURLOPT_SSL_VERIFYPEER => 0,
    CURLOPT_SSL_VERIFYHOST => 0,
  CURLOPT_POSTFIELDS => $postreqStr,
  CURLOPT_HTTPHEADER => array(
    'Authorization: '.$AuthorizationBasic
  ),
));

$response = curl_exec($curl);

curl_close($curl);

//echo $response;



#########################################################

$result=json_decode($response, TRUE);

$gatewayCode=@$result['response']['gatewayCode'];

#########################################################

	//if(!isset($_GET['rtest']))
	{
		echo "<hr/><br/>gatewayCode=>";print_r(@$gatewayCode);
		echo "<hr/><br/>result=>";print_r($result);
	}
	
	
	if((!empty($result['response']['gatewayCode']))&&(@$result['response']['gatewayCode']=='APPROVED')){
		$post_reply="Refund Successful";
		$live_refund_status='Y';
	}
	else $live_refund_status='N';
	
	
  

?>