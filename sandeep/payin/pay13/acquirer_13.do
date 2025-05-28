<?
//13 coinbase from 103 

if(isset($_REQUEST['pq'])||isset($_REQUEST['dtest']))
{
	error_reporting(E_ALL);
	ini_set('display_errors', '1');
	ini_set('max_execution_time', 0);
}
	
$postData=[];
$postData['name']						= $transID;

$postData['description']				= $_SESSION['product'];
$postData['local_price']['amount']		= $total_payment;
$postData['local_price']['currency']	= $orderCurrency;//"BUSD";

$postData['metadata']['customer_id']	= $transID;
$postData['metadata']['customer_name']	= $post['fullname'];

$postData['pricing_type']				= "fixed_price";
$postData['redirect_url']				= $status_url_1;
$postData['cancel_url']					= $status_url_1;

// $bank_url = 'https://api.commerce.coinbase.com/charges';

$curl = curl_init();
curl_setopt_array($curl, array(
  CURLOPT_URL => $bank_url, 
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 30,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS => json_encode($postData),
  CURLOPT_HTTPHEADER => array(
    "X-CC-Api-Key: ".$apc_get['apikey'],
	"X-CC-Version: 2018-03-22",
    "Content-Type: application/json"  
  ),
));

$response = curl_exec($curl);

curl_close($curl);
//echo $response;
$responseParamList = json_decode($response,1);
//print_r($responseParamList);

if(isset($data['pq'])&&$data['pq'])
	{
		echo "postData = ><br />";
		print_r($postData);

		echo "responseParamList = ><br />";
		print_r($responseParamList);
	}
$request = $postData;
$tr_upd_order['requestPost']=$request;
$tr_upd_order['responseParamList']	= $responseParamList?$responseParamList:$response;
$curl_values_arr['responseInfo']	=$tr_upd_order['responseParamList'];
$curl_values_arr['browserOsInfo']	=$browserOs;
$_SESSION['acquirer_action']=1;
$_SESSION['curl_values']=$curl_values_arr;
	
	
if(isset($responseParamList['data']['code']))
{
	$tr_upd_order['acquirer_ref']=$responseParamList['data']['code']; 
}
	
	
if(isset($responseParamList['data']['hosted_url'])&&$responseParamList['data']['hosted_url']){
		$tr_upd_order['pay_mode']='3D';
        $auth_3ds2_secure=$responseParamList['data']['hosted_url'];
        $auth_3ds2_action='redirect';
}
else{ //pending
    
	$_SESSION['acquirer_status_code']=1;
	//$process_url = $trans_processing;
	$json_arr_set['realtime_response_url']=$trans_processing;
}

trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);
	
if(isset($data['pq'])&&$data['pq'])
{
	echo "tr_upd_order = ><br />";
	print_r($tr_upd_order);
	exit;
}
	
?>
