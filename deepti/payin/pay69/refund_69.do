<?
if(!isset($_SESSION['adm_login'])){
	echo('ACCESS DENIED.');
	exit;
}
exit; //	REFUND NOT DEVELOP

//$_GET['rtest']=1;
//$qp = 1;

if(isset($tr_st)&&$tr_st){
	$transDetails=$tr_st;
}
else{
	$transDetails=get_transaction_detail($post['gid'], -1);
}

echo "<br/><br/>transaction_id=>".$transDetails['transaction_id']."<br/><br/>";

//	print_r($transDetails);
//	print_r($transDetails['json_value']);

$reply_get=$transDetails['system_note'];//reply_remark
$transaction_id=$transDetails['transaction_id'];

if($transDetails['bank_processing_amount']!="0.00"&&!empty($transDetails['bank_processing_amount'])){
	$refund_amount=$transDetails['bank_processing_amount'];
}else{
	$refund_amount=$transDetails['amount'];
}

$json=($transDetails['json_value1']);
//print_r($json);

$apiKey 		= jsonvaluef($transDetails['json_value'],'apiKey'); // value of app id from json
$merchantId		= jsonvaluef($transDetails['json_value'],'merchantId'); // value of secretKey from json
$terminalId		= jsonvaluef($transDetails['json_value'],'terminalId'); // value of order id from json
$subMerchantId	= jsonvaluef($transDetails['json_value'],'subMerchantId');
$payerVa		= jsonvaluef($transDetails['json_value'],'payerVa');
$merchantTranId = jsonvaluef($transDetails['json_value'],'merchantTranId');

$txn_id = $transDetails['txn_id'];

//$bank_url = jsonvaluef($transDetails['json_value'],'bank_url'.$post['type']); // bank url from json

if($bank_refund_url){
	//bank_refund_url
	$bank_url=$bank_refund_url;
}else{
	$bank_url='https://apibankingone.icicibank.com/payin/MerchantAPI/UPI/v0/Refund';
}
 
$get_json_info=array();	// array 
$params=array();		// array 

$requestPost = array();
$requestPost['merchantId']		=$siteid_get['merchantId'];
$requestPost['subMerchantId']	=$siteid_get['subMerchantId'];
$requestPost['terminalId']		=$siteid_get['terminalId'];
$requestPost['originalBankRRN']	=$txn_id;
$requestPost['merchantTranId']	="re".$transDetails['transaction_id'];
$requestPost['originalmerchantTr']$transDetails['transaction_id'];
$requestPost['refundAmount']	=$refund_amount;
//$requestPost['payeeVA']			=$payerVa;
$requestPost['Note']			="refund request";
$requestPost['onlineRefund']	="Y";

print_r($requestPost);exit;

//$get_json_info['txn_id']	= $order_id; 
$get_json_info['appId']		= $appId; // pass value from here for app id
$get_json_info['secretKey']	= $secretKey; // pass value from here for secretKey 

$get_json_info['startDate']	= date('Y-m-d',strtotime($transDetails['tdate']));//"2018-04-02";
$get_json_info['endDate']	= date('Y-m-d',strtotime("+2 days",strtotime($transDetails['tdate'])));
//$get_json_info['orderId']	=$transaction_id;

$get_json_info['referenceId']	=$txn_id; // Cashfree reference ID
$get_json_info['refundAmount']	=(float)($refund_amount); // float required Amount to be refunded. Should be lesser than or equal to the transaction amount. // number_formatf2
$get_json_info['refundNote']="refund for order $txn_id"; // A refund note for your reference

$params=$get_json_info;

$get_json_info['bank_url']=$bank_url; // pass value from here for bank url

//$curr = (isset($transDetails['bank_processing_curr'])&&$transDetails['bank_processing_curr']?$transDetails['bank_processing_curr']:'INR');
//exit;


//$gatewayURL		= $get_json_info['bank_url']."/$transaction_id/refunds"; 
$gatewayURL		= $get_json_info['bank_url']; 

//https://api.cashfree.com/payin/v1/order/refund

//if(isset($_GET['rtest']))
{
	echo "<hr/>gatewayURL=>";print_r($gatewayURL);
	echo "<hr/>params=>";print_r($params);
}

##############################################

$curl = curl_init();
	curl_setopt_array($curl, array(
	CURLOPT_URL => $gatewayURL,
	CURLOPT_RETURNTRANSFER => true,
	CURLOPT_ENCODING => '',
	CURLOPT_MAXREDIRS => 10,
	CURLOPT_TIMEOUT => 0,
	CURLOPT_FOLLOWLOCATION => true,
	CURLOPT_CUSTOMREQUEST => 'POST',
	CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	CURLOPT_POSTFIELDS =>$params
));
$return_data = curl_exec($curl);
curl_close($curl);

$response = json_decode($return_data,1);

//echo "<br /><br /><br /><br /><br />".$response;exit;

//echo $response;
//exit;
##############################################

	
//if(isset($_GET['rtest']))
{
	echo "<hr/>result=>";print_r($response);
}

//echo "<hr/>curl_exec=>".$return_data;
//echo "<hr/>result=>";print_r($response);

$refund_qry_db=true;

if(isset($response)&&$response&&isset($response['refund_status'])&&strtoupper($response['refund_status'])=="SUCCESS"){
	$post_reply="Refund Successful";
}else{
	$post_reply="Update Refund Manually";

	if(isset($_GET['upd_request'])){

	}else{
		$refund_qry=false;
		$refund_qry_db=false;

		$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
		$urlpath=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
	?>
		<a target="hform" onclick="javascript:top.popuploadig();" href="<?=$urlpath."&upd_request=1";?>" class="upd_status" style="outline:0px !important;color:rgb(0, 102, 204);text-decoration:none;cursor:pointer;float:none;display: block;clear:both;width:90%;text-align:center;margin:100px auto 15px auto;line-height:30px;border-radius:3px;background-color:rgb(223, 240, 216);font-size:16px;font-family:'Open Sans', sans-serif;font-style:normal;font-variant-ligatures: normal;font-variant-caps:normal;font-weight: 400;letter-spacing: normal;orphans:2;text-indent:0px;text-transform:none;white-space: normal;widows:2;word-spacing:0px;-webkit-text-stroke-width:0px;">Update Refund Manually</a>

	<? exit;
	}
}

$reply_date=date('d-m-Y h:i:s A');
$reply_remark = "<div class=rmk_row><div class=rmk_date>".$reply_date."</div><div class=rmk_msg>".$post_reply."</div></div>".$reply_get;

if($refund_qry_db==true){
	db_query(
		"UPDATE `{$data['DbPrefix']}transactions`".
		" SET `system_note`='{$reply_remark}'".
		" WHERE `id`={$post['gid']}"
	);
}

if(isset($response)&&$response&&isset($response['refund_status'])&&strtoupper($response['refund_status'])=="SUCCESS"){
?>
	<a onclick="javascript:top.popupclose();" class="upd_status" style="outline:0px !important;color:rgb(0, 102, 204);text-decoration:none;cursor:pointer;float:none;display: block;clear:both;width:90%;text-align:center;margin:100px auto 15px auto;line-height:30px;border-radius:3px;background-color:rgb(223, 240, 216);font-size:16px;font-family:'Open Sans', sans-serif;font-style:normal;font-variant-ligatures: normal;font-variant-caps:normal;font-weight: 400;letter-spacing: normal;orphans:2;text-indent:0px;text-transform:none;white-space: normal;widows:2;word-spacing:0px;-webkit-text-stroke-width:0px;">Refund Successful</a>
	<script>
		setTimeout(function(){ 
			top.popupclose();
		},900); 
	</script>
<? }
?>