<?
//fetch values from json

$siteid_get['client_id']		= $siteid_set['client_id'];
$siteid_get['client_secret']	= $siteid_set['client_secret'];
$siteid_get['terminalId']		= @$siteid_set['terminalId'];
$siteid_get['payerAccount']		= $siteid_set['payerAccount'];
$siteid_get['payerIFSC']		= $siteid_set['payerIFSC'];
$siteid_get['dmo_url']			= $siteid_set['dmo_url'];

if(isset($siteid_set['payerBank'])) 
	$siteid_get['payerBank']=$siteid_set['payerBank'];
else
	$siteid_get['payerBank']='';

if(isset($siteid_set['requestingUserName'])) 
	$siteid_get['requestingUserName']=$siteid_set['requestingUserName'];
else
	$siteid_get['requestingUserName']='';

//Content-Type : application/json
$client_id		= $siteid_get['client_id'];
$client_secret	= $siteid_get['client_secret'];
$httpUrl		= $siteid_get['dmo_url'];

//udf 1 user for requesting username
if(isset($post['udf1'])&&$post['udf1'])
	$requestingUserName=$post['udf1'];
else 
	$requestingUserName=$siteid_get['requestingUserName'];

//generate 19 character reference id
$clientRefId = "LTP".$uid;
$reference = "000". round(microtime(true) * 1000);
$len=strlen($clientRefId);
$remLen=19-$len;

$clientRefId = $clientRefId.substr($reference,-$remLen);

$clientCallbackUrl = "{$data['Host']}/payin/pay72/status_72{$data['ex']}?actionurl=notify";

//create request
$requestArr['merchantBusinessName']=$post['product_name'];
$requestArr['firstName']=$firstName;
$requestArr['lastName']=$lastName;
$requestArr['pan']=$post['panNumber'];
$requestArr['accountNumber']=$siteid_get['payerAccount'];
$requestArr['ifsc']=$siteid_get['payerIFSC'];
$requestArr['legalStoreName']=$post['product_name'];
$requestArr['merchantVirtualAddress']=strtolower($post['vpa']).$post['vpa_ext'];
$requestArr['merchantEmailId']=$post['qr_email'];
$requestArr['merchantMobileNumber']=isMobileValid($post['mobileNumber']);
$requestArr['bankName']=$siteid_get['payerBank'];
$requestArr['clientRefId']=$clientRefId;
$requestArr['paramB']="";
$requestArr['paramC']="";
//$requestArr['clientCallbackUrl']=$clientCallbackUrl;
$requestArr['requestingUserName']=$requestingUserName;

//create json for store
$store_json['store_json'][$account_no] = $siteid_get;
$store_json['store_json'][$account_no]['vpa'] = $requestArr['merchantVirtualAddress'];
$store_json['store_json'][$account_no]['merchantAliasName'] = $requestArr['merchantBusinessName'];
$store_json['store_json'][$account_no]['panNumber'] = $requestArr['pan'];
$store_json['store_json'][$account_no]['emailID'] = $requestArr['merchantEmailId'];
$store_json['store_json'][$account_no]['requestingUserName'] = $requestArr['requestingUserName'];
$store_json_value = json_encode($store_json);

$request = json_encode($requestArr);

$headers = array(
	'client_id: '.$client_id,
	'client_secret: '.$client_secret,
	'Content-Type: application/json',
);


$curl = curl_init();
curl_setopt_array($curl, array(
	CURLOPT_URL => $httpUrl,
	CURLOPT_RETURNTRANSFER => true,
	CURLOPT_ENCODING => '',
	CURLOPT_MAXREDIRS => 1,
	CURLOPT_TIMEOUT => 60,
	CURLOPT_FOLLOWLOCATION => true,
	CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	CURLOPT_CUSTOMREQUEST => 'POST',
	CURLOPT_POSTFIELDS => $request,
	CURLOPT_HTTPHEADER => $headers,
));

$response = curl_exec($curl);
$httpcode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
curl_close($curl);

$dmo_response = json_decode($response,1);
//print_r($dmo_response);

if(isset($_GET['qp'])&&$_GET['qp'])
{
	echo "URL:$httpUrl<br />Request:<br />$request<br /><br />";
	echo "Header";print_r($headers);
	echo "<br />response: $response";
	exit;
}

$json_value = array();
$json_value['reference']	=$clientRefId;
$json_value['siteid_get']	=$siteid_get;
$json_value['dmo_request']	=$requestArr;
$json_value['dmo_response']	=$dmo_response;

if(isset($dmo_response['statusCode'])&&$dmo_response['statusCode']=='0'&&isset($dmo_response['status'])&&$dmo_response['status']=='SUCCESS')
{

	$validate=true;
	
	if(isset($siteid_set['qr_url'])&&$siteid_set['qr_url'])
	{
		//if vpa registered successfully, then create static QR code via curl
	######
		$request= '{
			"requestingUserName": "$requestingUserName"
		}';
		
		$headers = array(
			'client_id: '.$client_id,
			'client_secret: '.$client_secret,
			'Content-Type: application/json',
		);
		
		$curl = curl_init();
		curl_setopt_array($curl, array(
			CURLOPT_URL => $siteid_set['qr_url'],
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_ENCODING => '',
			CURLOPT_MAXREDIRS => 1,
			CURLOPT_TIMEOUT => 60,
			CURLOPT_FOLLOWLOCATION => true,
			CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			CURLOPT_CUSTOMREQUEST => 'POST',
			CURLOPT_POSTFIELDS => $request,
			CURLOPT_HTTPHEADER => $headers,
		));
		
		$response = curl_exec($curl);
		$httpcode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);
		
		$res = json_decode($response,1);
		//print_r($res);
		
		if(isset($res['qrData'])&&$res['qrData'])	//if received QR code data then store into json
		{
			$intentData=$res['qrData'];
			$json_value['intentType']	="base64";	//qr code received in base64 format
		}
	######
	}
	else
	{
		$intentData="upi://pay?pa={$requestArr['merchantVirtualAddress']}&pn={$requestArr['merchantBusinessName']}&mc=$mcc_code&tr=$clientRefId&tn=Test%20Product&mode=04&tid=$clientRefId";
	}
	$json_value['intentQR']	=$intentData;	//store qr data into json name - intentQR
}
else
{
	$data['Error']=$dmo_response['error'];

	$validate=false;
	//exit;
}
$validate=true;
//$validate=false;
?>