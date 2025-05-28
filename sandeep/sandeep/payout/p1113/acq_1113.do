<?
$bjson = decode_f($bank_master['encode_processing_creds']);

$encode_processing_creds = json_decode($bjson,true);

if($bank_master['payout_prod_mode']==1) {
	$siteid_set	= $encode_processing_creds['live'];
	$bank_url	= $bank_master['bank_payment_url'];
}
else {
	$siteid_set	= $encode_processing_creds['test'];
	$bank_url	= $bank_master['payout_uat_url'];
}

$bg_active	= $bank_master['bg_active'];

$global_data['merchantId']	= $siteid_set['merchantId'];
$global_data['secretKey']	= $siteid_set['secretKey'];
$global_data['currency']	= $bank_master['payout_processing_currency'];
$global_data['bank_url']	= $bank_url;

function send_payout_request($post)
{
	global $global_data;

	$Datetime	= date('Y-m-d h:i:sA');//Date & Time Format "2012-05-09 04:09:41AM";

	$req_post = array();
	$req_post['ClientIP']		= $post['client_ip'];

	$req_post['ReturnURI']		= $data['Host']."/payout/p1113/status_1113.php";
	//$req_post['ReturnURI']		= "https://api.gatewayurl.com/responseDataList.do?action=payout&transaction_id=".$post['transaction_id'];
	$req_post['MerchantCode']	= $global_data['merchantId'];
	$req_post['secretKey']		= $global_data['secretKey'];
	$req_post['CurrencyCode']	= $global_data['currency'];

	$req_post['TransactionID']		= $post['transaction_id'];
	$req_post['MemberCode']			= $post['beneficiary_id'];
	$req_post['Amount']				= number_formatf_2($post['price']);
		//$req_post['BankCode']			= $post['ifsc'];//"BBL"
	$req_post['BankCode']			= $post['bank_code1'];//"BBL"
	$req_post['toBankAccountName']	= $post['beneficiary_name'];//"test";
		//$req_post['toBankAccountNumber']= $post['baccount'];//"123456";
	$req_post['toBankAccountNumber']= $post['account_number'];//"123456";

	$req_post['TransactionDateTime']= $Datetime;

	$dt	= date('YmdHis', strtotime($Datetime));

	$hashkey= md5($req_post['MerchantCode'].$req_post['TransactionID'].$req_post['MemberCode'].$req_post['Amount'].$req_post['CurrencyCode'].$dt.$req_post['toBankAccountNumber'].$req_post['secretKey']);

	$req_post['Key']=$hashkey;

	$request = http_build_query($req_post);

	$url = $global_data['bank_url']."/".$req_post['MerchantCode'];

	$curl = curl_init();
	curl_setopt_array($curl, [
		CURLOPT_URL => $url,
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => "",
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 30,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => 'POST',
		CURLOPT_POSTFIELDS => $request,
		CURLOPT_HTTPHEADER => [
			"Content-Type: application/x-www-form-urlencoded"
		],
	]);

	$response = curl_exec($curl);

	$xml = simplexml_load_string($response);
	$re_json	= json_encode($xml);
	$re_array	= json_decode($re_json, TRUE);

	//print_r($re_array);exit;

	if(isset($re_array['statusCode'])&&$re_array['statusCode']=='000')		$status = '00';
	elseif(isset($re_array['statusCode'])&&$re_array['statusCode']=='001')	$status = '01';
	else $status = '99';

	$arr['status']	= $status;
	$arr['message']	= $re_array['message'];
	//$arr['bankResponse'] = jsonencode($re_array,1,1);
	$arr['reqPost'] = ($req_post);
	$arr['bankResponse'] = ($re_array);
	//cmn
	$arr['bankUrl']	= $url;

	return $arr;
}
?>