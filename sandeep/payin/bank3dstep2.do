<??>
<style>
body {
    background: #f4f5f9;
    font-family: 'Open Sans', sans-serif !important;
    margin: 0 !important;
    overflow-x: hidden !important;
    color: #67757c !important;
}
.button {
	background-color: #4CAF50; /* Green */
	border: none;
	color: white;
	padding: 15px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	cursor: pointer;
	font-family:Arial, Helvetica, sans-serif;
	border-radius: 15px;
}

.button2 {background-color: #008CBA;} /* Blue */
.button3 {background-color: #f44336;} /* Red */ 
.button4 {background-color: #e7e7e7; color: black;} /* Gray */ 
.button5 {background-color: #555555;} /* Black */

#payment_option {width:360px;float:unset;margin:90px auto;}
</style>

<?php
include_once "../../config_db.do";
function url_f($url){
	$result=0;
	if(($url)&&((strpos($url,"http:")!==false) || (strpos($url,"https:")!==false))){
		$result=1;
	}
	return $result;
}


if(isset($_REQUEST['transID'])){
	$transaction_id	= trim($_REQUEST['transID']); 
}
else {$transaction_id = "";}

$json_value=[];

if(!empty($transaction_id)){
	$td=db_rows(
		"SELECT * ". 
		" FROM `{$data['DbPrefix']}transactions`".
		" WHERE (`transaction_id`='{$transaction_id}') ".
		"  LIMIT 1",0
	);
	$td=$td[0];
	$json_value=jsondecode($td['json_value'],true,1);

	$transID = $td['transID'];
}
$txn_id		= $json_value['txn_id'];
$bank_url	= $json_value['bank_url'];
$PublicKey	= $json_value['PublicKey'];
$SecretKey	= $json_value['SecretKey'];
$pay_url	= $json_value['pay_url'];
$redirect_url	= $json_value['redirect_url'];
$bank_pay_url	= $json_value['bank_pay_url'];
$bin_bank_name	= $json_value['bin_bank_name'];
$MerchantWebsite= $json_value['MerchantWebsite'];
$processor_response= $json_value['response_step_1']['data']['processor_response'];
$process_file_url = $json_value['hostUrl']."/".$json_value['process_file']."/".$data['ex'];
$postData = $json_value['post'];
$getData = $json_value['get'];
if($getData&&$postData&&is_array($getData)){
	$postData=array_merge($getData,$postData);
}
//print_r($postData);print_r($process_file_url);

$url_f=url_f($process_file_url);
if($url_f){
	$process_file=$process_file_url;
}elseif(isset($_SERVER['HTTP_REFERER'])&&!empty($_SERVER['HTTP_REFERER'])){
	$process_file=$_SERVER['HTTP_REFERER'];
}



if($bank_pay_url)
{
	if(!isset($_SESSION['authURL'])) {
		$authURL = $bank_pay_url;
		$_SESSION['authURL'] = 1;
	}
	else
	{
		$authURL = "";
	}
}

if(!empty($txn_id))
{
	$url = $bank_url."/v3/transactions/{$txn_id}/verify/";

	$curl = curl_init();

	curl_setopt_array($curl, array(
		CURLOPT_URL => $url,
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => "",
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 0,
		CURLOPT_FOLLOWLOCATION => true,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => "GET",
		CURLOPT_HTTPHEADER => array(
			"Content-Type: application/json",
			"Authorization: Bearer ".$SecretKey,
		),
	));

	$response = curl_exec($curl);
	
	curl_close($curl);

	$responseParamList = json_decode($response, true);

	if($qp)
	{
		echo "<br/>responseParamList=>";
		var_dump($responseParamList);
		//exit;
	}

	$results = $responseParamList;

	if ($err) {
		var_dump($err);
	}
	else {
		if (isset($responseParamList) && count($responseParamList)>0)
		{
			$status = $responseParamList['status'];

			if($responseParamList['success']){
				$message	= $responseParamList['message'];
			}else{
				$message	= $responseParamList['message'];
			}
			
			$_SESSION['acquirer_action']=1;
			$_SESSION['acquirer_response']=$message;
			$_SESSION['curl_values']=$responseParamList;

			if(isset($status) && !empty($status))
			{
				if($responseParamList['data']['status']=='successful'){ //success
					$_SESSION['acquirer_response']=$responseParamList['data']['processor_response']." - Success";
					$_SESSION['hkip_status']=2;
					$_SESSION['acquirer_status_code']=2;
				}
				elseif($responseParamList['data']['status']=='failed' || $responseParamList['status']=='error'){	//failed
					$msg = '';
					if(isset($responseParamList['data']['processor_response']))
						$msg = $responseParamList['data']['processor_response'];
					elseif(isset($responseParamList['message']))
						$msg = $responseParamList['message'];
					 
					$_SESSION['acquirer_response']=$msg." - Cancelled";
					$_SESSION['hkip_status']=-1;
					$_SESSION['acquirer_status_code']=-1;
				}
				else{ //pending
					if($authURL)
					{
						//$_SESSION['authURL_'.$td['type']] = $authURL;
					?>
					<div id="ProceedtoPayment" style="width:300px; margin:80px auto; max-width:600px;">
					<h1>3D Secure Authentication</h1>
					<div>
					During a 3D Secure transaction, Your identity will be verified, Based on the authentication provided by your issuer<? if($bin_bank_name) echo " <b>{$bin_bank_name}</b>";?>, You will be redirected to a site controlled by your Card issuing bank<? if($bin_bank_name) echo " <b>{$bin_bank_name}</b>";?> to answer additional security questions (usually a unique password or SMS verification).<br /><br />

This reduces the chance of a fraudulent transaction occurring.<br /><br />

You will be redirected back to the merchant website<? if($MerchantWebsite) echo " <b>{$MerchantWebsite}</b>";?> after authontication.<br /><br /></div>
					<form name="myForm" id="myForm" action="<?=$authURL;?>" target="_blank" method="get">
					<?
					$req_string	= substr($authURL, strpos($authURL, '?')+1);
					$req_arr	= explode('&', $req_string);
						
					foreach ($req_arr as $key => $val)
					{
						$field_dt=explode('=', $val);
						?>
						<input type="hidden"  name="<?=$field_dt[0]?>" value="<?=$field_dt[1]?>" />
						<?
					}
					?>
					<input type="submit" value="Yes Processed" class="button" onclick="javascript:changepagetext();" />
					<a href="javascrtip:void(0);" class="button button5" onclick="goRePost()">No</a>
					</form>

					</div>
					
					<div id="payment_option" style="text-align:center;">
						<h1>3D Secure Authentication is being Processed</h1>
						Have you authenticated the transaction of your card issuer site? <br/><br/>
						
						<b><?=$processor_response;?><b/><br/><br/>

						<div><a href="<?="{$data['Host']}/payin/pay31/status31{$data['ex']}?transID=".$transaction_id;?>" class="button">Yes I have completed</a> <a href="javascrtip:void(0);" class="button button5" onclick="goRePost()">No I would like to try again!</a></div>
					</div>
					<?
					}
					else{
						$_SESSION['acquirer_status_code']=-1;
					}
				}
			}
		}
	}

	if($_SESSION['acquirer_status_code']==2){ //success
		$process_url = "{$data['Host']}/success{$data['ex']}?transID=$transID&action=hkip";
	}
	elseif($_SESSION['acquirer_status_code']==-1){ //failed
		$process_url = "{$data['Host']}/failed{$data['ex']}?transID=$transID&action=hkip";
	}
	
	if($process_url){
		unset($_SESSION['authURL']);
		header("Location:$process_url");
		exit;
	}
}
?>

<script>
document.getElementById('payment_option').style.display = 'none';
function changepagetext() {
	document.getElementById('ProceedtoPayment').style.display = 'none';
	document.getElementById('payment_option').style.display = 'block';
}
function redirect_Postf(url, data) {
	var form = document.createElement('form');
	document.body.appendChild(form);
	form.method = 'post';
	form.target = '_top';
	form.action = url;
	for (var name in data) {
		var input = document.createElement('input');
		input.type = 'hidden';
		input.name = name;
		input.value = data[name];
		form.appendChild(input);
	}
	form.submit();
}
var process_file="<?=$process_file?>";
var postData=<?=$postData?>;
	
function goRePost(){
	if(process_file){redirect_Postf(process_file,postData);}
}

</script>