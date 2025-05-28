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

$global_data['apiKeyId']	= $siteid_set['apiKeyId'];
$global_data['x-api-key']	= $siteid_set['x-api-key'];
$global_data['currency']	= $bank_master['payout_processing_currency'];
$global_data['bank_url']	= $bank_url;

function send_payout_request($post)
{
	global $global_data, $data;

//	$req_post['merchantEmail']	="virtualblockinnovations@gmail.com";
//	$req_post['userEmail']		="virtualblockinnovations@gmail.com";

	$req_post['merchantEmail']	=$post['merchant_email'];
	$req_post['userEmail']		=$post['beneficiaryEmailId'];
	$req_post['currency']		=$global_data['currency'];
	$req_post['withdrawAmount']	=number_formatf_2($post['price']);
	$req_post['bankName']		=$post['bank_name'];
	$req_post['ifscCode']		=$post['bank_code1'];
	$req_post['bankAccNo']		=$post['account_number'];

	//$req_post['accType']		=$post['udf1'];

	$requestJson = json_encode($req_post);

	//print_r($req_post);exit;

	$post_url = $global_data['bank_url'].$global_data['apiKeyId'];

	$curl = curl_init();

	curl_setopt_array($curl, array(
		CURLOPT_URL => $post_url,
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => '',
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 0,
		CURLOPT_FOLLOWLOCATION => true,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => 'POST',
		CURLOPT_POSTFIELDS =>$requestJson,
		CURLOPT_HTTPHEADER => array(
			'x-api-key: '.$global_data['x-api-key'],
			'Content-Type: application/json'
		),
	));

	$response = curl_exec($curl);
//echo $response;exit;
	curl_close($curl);
	$re_array = json_decode($response,1);

	if(isset($re_array['status'])&&strtolower($re_array['status'])=='success'&&isset($re_array['data']['bankStatus'])&&strtolower($re_array['data']['bankStatus'])=='success'){
		$status = '00';
		$arr['reqId']	= $re_array['data']['reqId'];
		$arr['txn_id']	= $re_array['data']['utrNumber'];
	}
	elseif(isset($re_array['status'])&&strtolower($re_array['status'])=='failed') $status = '01';
	else $status = '99';

	$arr['status']	= $status;
	$arr['message']	= $re_array['message'];
	$arr['reqPost'] = $req_post;
	$arr['bankResponse'] = $re_array;
	$arr['bankUrl']	= $post_url;

	return $arr;
}
?>