<?
$data['HideMenu']=true;
$data['HideAllMenu']=true;
$data['NO_SALT']=true;
$data['PageName']='BANK 3DS STEP2';
$data['PageFile']='bank3dstep2';
//$data['notRootCss']=true;
$data['PageTitle']='Bank 3DS Step2 Processing...'; 
include('config.do');
include('api/status_top'.$data['iex']);
function url_f($url){
	$result=0;
	if(($url)&&((strpos($url,"http:")!==false) || (strpos($url,"https:")!==false))){
		$result=1;
	}
	return $result;
}
$txn_id					= $json_value['txn_id'];
$pay_url				= $json_value['pay_url'];
$redirect_url			= $json_value['redirect_url'];
$bank_pay_url			= $json_value['bank_pay_url'];

$data['bankstatus']		= $json_value['status_'.$td['type']];
$data['bin_bank_name']	= $json_value['bin_bank_name'];
$data['MerchantWebsite']= $json_value['MerchantWebsite'];
$data['processor_response']	= $json_value['response_step_1']['data']['processor_response'];
$process_file_url 		= $json_value['hostUrl']."/".$json_value['process_file'].$data['ex'];
$rePostData				= $json_value['post'];
$reGetData 				= $json_value['get'];

if($json_value['default_mid']) $default_mid = $json_value['default_mid'];

if($json_value['response_step_1']['data']['processor_response']) 
	$data['processor_response'] = $json_value['response_step_1']['data']['processor_response'];

if($reGetData&&$rePostData&&is_array($reGetData)){
	$rePostData=array_merge($reGetData,$rePostData);
}
//print_r($rePostData);print_r($process_file_url);


if(isset($_SESSION['bank_pay_url']) && !empty($_SESSION['bank_pay_url'])) $bank_pay_url = $_SESSION['bank_pay_url'];

$authURL = $bank_pay_url;
$data['authURL'] = $authURL;
$data['authURLData']=[];
parse_str(parse_url($authURL, PHP_URL_QUERY), $data['authURLData']);

//squrlf
$url_f=url_f($process_file_url);
if($url_f){
	$process_file=$process_file_url;
}elseif(isset($_SERVER['HTTP_REFERER'])&&!empty($_SERVER['HTTP_REFERER'])){
	$url_f_2=url_f($_SERVER['HTTP_REFERER']);
	if($url_f_2){
		$process_file=$_SERVER['HTTP_REFERER'];
	}
}

$data['process_file']=$process_file;
$data['rePostData']=$rePostData;

if(!isset($default_mid) && empty($default_mid)) $default_mid = $td['type'];

$filePath="api/pay".$default_mid."/update_".$default_mid.$data['iex'];

if(file_exists($filePath)){

	include($filePath);
}
//exit;

if(!isset($_SESSION["s30_count"]) && empty($_SESSION["s30_count"])){
	if(isset($data["s30_count"])&&$data["s30_count"]){
		$_SESSION["s30_count"] = (int)$data["s30_count"];
	}else{
		$_SESSION["s30_count"] = 10;
	}
}else{	
	$s30_count = $_SESSION["s30_count"];
	$s30_count--;
	$_SESSION["s30_count"]= $s30_count;
}
//echo $_SESSION["s30_count"];


display('user');
?>

