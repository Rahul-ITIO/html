<?php 
include('../../config.do');
//cmn
$hardcode_test=0;
if($data['localhosts']==true){
	$hardcode_test=1;
}

if(!isset($_SESSION['adm_login'])&&!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Admins']}/login".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}


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

if((isset($_REQUEST['t']))&&(!empty($_REQUEST['t']))) $transaction_id=$_REQUEST['t'];
if((isset($_REQUEST['m']))&&(!empty($_REQUEST['m']))) $siteid_get['merchantId']=$_REQUEST['m'];

$post_url="https://query.safepaymentapp.com/Services/Merchants/".$siteid_get['merchantId']."/FundOutStatus/$transaction_id";

//$post_url="https://query.testingzone88.com/Services/Merchants/".$siteid_get['merchantId']."/FundOutStatus/$transaction_id";


//if(isset($data['pq'])&&$data['pq'])
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

//if(isset($data['pq'])&&$data['pq'])
{
	echo "<br/><br/>responseParam=>"; print_r($responseParam);
}

$txn_value['responseParam']= $responseParam;

$response_array_post=json_encode($txn_value, JSON_UNESCAPED_SLASHES);

$txn_value['sendRequest']	= $sendRequest;
$txn_value['postbody']		= $postbody;

$new_txn_value = json_encode($txn_value, JSON_UNESCAPED_SLASHES);

//if(isset($data['pq'])&&$data['pq'])
{
	echo "<br/><br/>txn_value=>"; print_r($txn_value);
	echo "<br/><br/>new_txn_value=>"; print_r($new_txn_value);
}

exit;
//----------------------------------------------------------------
?>