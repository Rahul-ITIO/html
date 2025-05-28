<?php
if(!isset($_SESSION['adm_login'])){
	echo('ACCESS DENIED.');
	exit;
}

//check if test mode than assing uat status url 
if($acquirer_prod_mode==2) $acquirer_refund_url=$acquirer_uat_url;

if(empty($acquirer_refund_url)){
	$acquirer_refund_url="https://api.openacquiring.com/v1/merchants";
}

$acquirer_refund_url	= $acquirer_refund_url."/".@$apc_get['merchant_id']."/payment/".@$acquirer_ref."/refund";  	

if(empty($acquirer_ref)) echo "<br/><b>Acquirer Ref not found</b><br/>".$acquirer_ref;


$params=array();
$params['amount']=@$paramsInfo['refundAmount']; 
$params['invoice_number']=@$transID; //flwRef
$params['custom']['field1']="Refund request to".@$transID; //flwRef


if(isset($_GET['rtest']))
{
	echo "<hr/>params=>";
	print_r(@$params);	

}

//echo "<hr/>params=>";print_r($params); 

//if(!isset($_GET['rtest']))
{
	echo "<hr/>acquirer_refund_url=>".$acquirer_refund_url;
}
$curl = curl_init();

curl_setopt_array($curl, array(
	CURLOPT_URL => $acquirer_refund_url,
	CURLOPT_RETURNTRANSFER => true,
	CURLOPT_ENCODING => "",
	CURLOPT_MAXREDIRS => 10,
	CURLOPT_TIMEOUT => 0,
	CURLOPT_FOLLOWLOCATION => true,
	CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	CURLOPT_CUSTOMREQUEST => "POST",
	CURLOPT_POSTFIELDS => json_encode($params),
	CURLOPT_HTTPHEADER => array(
		'Authorization: Basic '.@$apc_get['authorization'],
		'Content-Type: application/json'
	),
));
$curl_exec=curl_exec($curl);
curl_close($curl);
$result=json_decode($curl_exec,true);
			
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