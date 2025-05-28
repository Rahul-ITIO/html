<?

if(!isset($data['STATUS_ROOT'])){
	include('../../config_db.do');
	//include('../status_top'.$data['iex']);
}
/* 
if(!isset($_SESSION['adm_login'])&&!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Admins']}/login".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}
*/
if((isset($_REQUEST['transaction_id'])&&!empty($_REQUEST['transaction_id']))){
	if(!empty($_REQUEST['transaction_id'])){
		$transaction_id=$_REQUEST['transaction_id'];
		$where_pred=" (`transaction_id`='{$transaction_id}') AND";
	}

	if(!empty($tr_id)){
		//$where_pred.=" (`id`={$tr_id}) AND";
	}
}
// transactions get ----------------------------

if(empty($where_pred)&&isset($where_pred_curl)&&$where_pred_curl) $where_pred = $where_pred_curl;

$where_pred=substr_replace($where_pred,'', strrpos($where_pred, 'AND'), 3);

$td=db_rows_2(
	"SELECT * ". 
	" FROM `{$data['DbPrefix']}payout_transaction`".
	" WHERE ".$where_pred.
	" LIMIT 1",$qp //DESC ASC
);

$td=$td[0];
$transaction_id=$td['transaction_id'];

 
$bank_master	= select_tablef("`payout_id` = '".$td['pay_type']."'",'bank_payout_table');

$bank_status_url = $bank_master['bank_status_url'];

$bjson = decode_f($bank_master['encode_processing_creds']);
$encode_processing_creds = json_decode($bjson,true);
$siteid_get['merchantId']	= $encode_processing_creds['merchantId'];
$siteid_get['secretKey']	= $encode_processing_creds['secretKey'];


//print_r($_REQUEST);exit;


//-----------------------------------------------------------
$data['pq']=0;
$cp=0; 
//cmn

if((isset($_REQUEST['pq']))&&(!empty($_REQUEST['pq'])))
{
	$data['pq']=$_REQUEST['pq'];
	$cp=1;
}


$host_path=$data['Host'];

//$transaction_id='27922844';$siteid_get['merchantId']='G0313';

//if((isset($_REQUEST['t']))&&(!empty($_REQUEST['t']))) $transaction_id=$_REQUEST['t'];
//if((isset($_REQUEST['m']))&&(!empty($_REQUEST['m']))) $siteid_get['merchantId']=$_REQUEST['m'];

if($bank_status_url)
	$post_url=$bank_status_url.$siteid_get['merchantId']."/FundOutStatus/$transaction_id";
else
	$post_url="https://query.safepaymentapp.com/Services/Merchants/".$siteid_get['merchantId']."/FundOutStatus/$transaction_id";


//$post_url="https://query.testingzone88.com/Services/Merchants/".$siteid_get['merchantId']."/FundOutStatus/$transaction_id";


if(isset($data['pq'])&&$data['pq'])
{
	echo "<br/><br/>post_url=>"; print_r($post_url);
	//echo "<br/><br/>post_url=>"; print_r($post_url);
}	

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $post_url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
curl_setopt($ch, CURLOPT_HEADER, FALSE);
curl_setopt($ch, CURLOPT_POST, TRUE);
curl_setopt($ch, CURLOPT_HTTPHEADER, array(
	"Content-Type: application/x-www-form-urlencoded"
));

$response = curl_exec($ch);
curl_close($ch);

$xml = simplexml_load_string($response);
$json = json_encode($xml); // convert the XML string to JSON


$responseParam = json_decode($json, TRUE);

if(isset($data['pq'])&&$data['pq'])
{
	echo "<br/><br/>responseParam=>"; print_r($responseParam);
}

$txn_value['responseParam']= $responseParam;

$response_array_post=json_encode($txn_value, JSON_UNESCAPED_SLASHES);

$txn_value['sendRequest']	= $sendRequest;
$txn_value['postbody']		= $postbody;

$new_txn_value = json_encode($txn_value, JSON_UNESCAPED_SLASHES);

if(isset($data['pq'])&&$data['pq'])
{
	echo "<br/><br/>txn_value=>"; print_r($txn_value);
	echo "<br/><br/>new_txn_value=>"; print_r($new_txn_value);
}

if(isset($txn_value)&&$txn_value) display_nested_array($txn_value);

exit;
//----------------------------------------------------------------
?>