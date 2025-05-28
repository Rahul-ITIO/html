<?php
if(!isset($_SESSION['adm_login'])){
	echo('ACCESS DENIED.');
	exit;
}

$auth_ApiKey=@$apc_get['auth_ApiKey'];
$header_ApiKey=@$apc_get['header_ApiKey'];
$merchantCode=@$apc_get['merchantCode'];
$access_token=@decode64f(@$td['acquirer_response_stage1']);


if(empty($acquirer_refund_url)||$acquirer_refund_url=='NA'){
	$acquirer_refund_url="https://pr-web-payment-gateway-k8.dev.prophius-api.com/api/v1/transaction/make-void";
}

//echo "<hr/>acquirer_refund_url2=>".$acquirer_refund_url;

//check if test mode than assing uat status url 

if(@$acquirer_prod_mode==2||@$apc_get['mode']=='test') $acquirer_refund_url="https://pr-web-payment-gateway-k8.dev.prophius-api.com/api/v1/transaction/make-void";

// https://pr-web-payment-gateway-k8.dev.prophius-api.com/api/v1/transaction/make-void


if(empty($acquirer_ref)) echo "<br/><b>Acquirer Ref not found</b><br/>".$acquirer_ref;




//if(!isset($_GET['rtest']))
{
	echo "<hr/>acquirer_refund_url=>".$acquirer_refund_url;
}


#########################################################

############################################################

$postreqStr='{
    "referenceNumber": "'.$transID.'REFUND",
    "originalReferenceNumber": "'.$acquirer_ref.'",
    "merchantCode": "'.$merchantCode.'"
}';

if($data['cqp']>0||isset($_GET['rtest'])) echo "<br/>postreqStr=>".$postreqStr;




$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => $acquirer_refund_url,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
    CURLOPT_HEADER => 0,
    CURLOPT_SSL_VERIFYPEER => 0,
    CURLOPT_SSL_VERIFYHOST => 0,
  CURLOPT_POSTFIELDS => $postreqStr,
  CURLOPT_HTTPHEADER => array(
    'ApiKey: '.$header_ApiKey,
    'Content-Type: application/json',
    'Authorization: Bearer '.$access_token
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
	
	
	if((!empty($result['respCode']))&&(@$result['respCode']=='00')){
		$post_reply="Refund Successful";
		$live_refund_status='Y';
	}
	else $live_refund_status='N';
	
	
  

?>