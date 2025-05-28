<? 
include('../../config.do');
//cmn
$sq= 0;
if(isset($_GET['sq'])&&$_GET['sq']) $sq= 1;

$hardcode_test=0;
if($data['localhosts']==true){
	$hardcode_test=1;
}
if((isset($_SERVER['HTTP_REFERER'])&&(strpos($_SERVER['HTTP_REFERER'],'signins/merchant_settlement')!==false) && (isset($post['curl'])&&$post['curl']=='byCurl'))) {
	//cmn
	//echo "<br/>_POST=><br/>";print_r($_POST); echo "<br/>_GET=><br/>";print_r($_GET);
	//$hardcode_test=0;
}else{
	if(!isset($_SESSION['login_adm'])&&!isset($_SESSION['login'])){
		$_SESSION['redirectUrl']=$data['urlpath'];
		header("Location:{$data['Admins']}/login".$data['ex']);
		echo('ACCESS DENIED.');
		exit;
	}
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

$status="";

$actionurl_get=$transID=$transID=$where_pred=$message="";

//-----------------------------------------------------------

$onclick='javascript:top.popuploadig();popupclose2();';
$actionurl="";
$callbacks_url="";

$is_admin=false; 
$verify_by_admin = false;
$subQuery="";

if((isset($_SESSION['login_adm'])&&$_SESSION['login_adm']&&isset($_GET['admin'])&&$_GET['admin']) || (isset($_SERVER['HTTP_REFERER'])&&(strpos($_SERVER['HTTP_REFERER'],'signins/merchant_settlement')!==false) && (isset($post['curl'])&&$post['curl']=='byCurl'))) {
	$is_admin=true;
}

if(isset($_SESSION['login_adm'])&&$_SESSION['login_adm']&&isset($_GET['admin_verify'])&&$_GET['admin_verify']) {
	$verify_by_admin=true;
}

//FETCH DATA FROM BANK TABLE 
$bank_master = select_tablef('`payout_id` IN (1114)','bank_payout_table');
 
$bjson = decode_f($bank_master['encode_processing_creds']);

$encode_processing_creds = json_decode($bjson,true);

if($bank_master['payout_prod_mode']==1) {
	$siteid_set=$encode_processing_creds['live'];
	$bank_url = $bank_master['bank_payment_url'];
	$file_start = "live_";
}
else {
	$siteid_set=$encode_processing_creds['test'];
	$bank_url = $bank_master['payout_uat_url'];
	$file_start = "test_";
}

$cib		= $siteid_set['cib'];
$apiKey		= $siteid_set['apiKey'];
$crpId		= $siteid_set['crpId'];
$crpUsr		= $siteid_set['crpUsr'];
$aggrId		= $siteid_set['aggrId'];
$aggrName	= $siteid_set['aggrName'];
$urn		= $siteid_set['urn'];
$senderAcctNo= $siteid_set['senderAcctNo'];
$passCode	= $siteid_set['passCode'];
$bcID		= $siteid_set['bcID'];
$mobile		= $siteid_set['mobile'];

$acquirer_ref="";

$cron_tab_array=array();

if((isset($_REQUEST['actionurl']))&&(!empty($_REQUEST['actionurl']))){
	$actionurl=$_REQUEST['actionurl'];
}

if((isset($_REQUEST['redirecturl']))&&(!empty($_REQUEST['actionurl']))){
	$actionurl.="&redirecturl=".urlencode($_REQUEST['redirecturl']);
}

if(isset($_REQUEST['cron_tab'])&&$_REQUEST['cron_tab']){
	$subQuery.='&cron_tab='.$_REQUEST['cron_tab'];
}

//-----------------------------------------------------------

if(isset($_REQUEST['transID'])&&!empty($_REQUEST['transID'])){
	$transID=$_REQUEST['transID'];
}
if(isset($_REQUEST['actionurl'])&&!empty($_REQUEST['actionurl'])){
	$actionurl_get=$_REQUEST['actionurl'];
}

if((isset($_REQUEST['transID'])&&!empty($_REQUEST['transID']))){
	if(!empty($_REQUEST['transID'])){
		$transID=$_REQUEST['transID'];
	}
}

if($transID){
	$transID=transIDf($transID,0); // transID
	//$tr_id=transIDf($transID,1); // table id

	$where_pred.=" (`transID`='{$transID}') AND ";
	if(!empty($tr_id)){
		//$where_pred.=" (`id`='{$tr_id}') AND";
	}
}

// transactions get ----------------------------

$where_pred=substr_replace($where_pred,'', strrpos($where_pred, 'AND'), 3);

$td=db_rows(
	"SELECT * ". 
	" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
	" WHERE ".$where_pred.
	" ORDER BY `id` DESC LIMIT 1",0 //DESC ASC
);
//cmn
if($sq){
	print_r($td);
	//exit;
}
$td=$td[0];
$id	= $td['id'];
$merID	= $td['merID'];
$acquirer		= $td['acquirer'];
$trans_date	= date('m/d/Y', strtotime($td['created_date']));

$acquirer_response	= json_decode($td['acquirer_response'],1);
$payment_method=$acquirer_response['payment_method'];

$json_value1=jsonencode1($td['json_value'],'',1);
$json_value1=str_replace(array('[productName],'),'",',$json_value1);
$json_value1=str_replace(array('[productName]},"'),'"},"',$json_value1);

$jsv=json_decode($json_value1 ,1);
$wd_pay_amount_default_currency=abs($jsv['wd_pay_amount_default_currency']);
$amount	= $wd_pay_amount_default_currency;
$amount_get	= $wd_pay_amount_default_currency;

$sendRequest = array();

if(strtolower($payment_method)=='neft' || strtolower($payment_method)=='rtgs' || empty($payment_method))
{
	$sendRequest['UNIQUEID']=$transID;
	$sendRequest['USERID']	=$crpUsr;
	$sendRequest['AGGRID']	=$aggrId;
	$sendRequest['CORPID']	=$crpId;
	$sendRequest['URN']		=$urn;
	
	if(strtolower($payment_method)=='neft' || empty($payment_method)) $x_priority = '0010';
	else  $x_priority = '0001';
}
elseif(strtolower($payment_method)=='imps' || strtolower($payment_method)=='upi')
{
	$sendRequest['USERID']		=$crpUsr;
	$sendRequest['AGGRID']		=$aggrId;
	$sendRequest['CORPID']		=$crpId;
	$sendRequest['URN']			=$urn;
	$sendRequest['bcID']		=$bcID;
	$sendRequest['passCode']	=$passCode;
	$sendRequest['recon360']	="N";
	$sendRequest['date']		=$trans_date;

	if(strtolower($payment_method)=='imps') $x_priority = '0100';
	else  $x_priority = '1000';
}

$fp = fopen($file_start.'rsaapikey.cer', 'r');
$pub_key= fread($fp, 8192);
fclose($fp);

$RANDOMNO1 = "1212121234483448";
$RANDOMNO2 = '1234567890123456';

openssl_get_publickey($pub_key);

openssl_public_encrypt($RANDOMNO1, $encrypted_key, $pub_key);
$encrypted_data = openssl_encrypt(json_encode($sendRequest), 'AES-128-CBC', $RANDOMNO1, OPENSSL_RAW_DATA, $RANDOMNO2);

$postbody= [
	"requestId" => $transID,
	"service" => "",
	"encryptedKey" => base64_encode($encrypted_key),
	"oaepHashingAlgorithm" => "NONE",
	"iv" => base64_encode($RANDOMNO2),
	"encryptedData" => base64_encode($encrypted_data),
	"clientInfo" => "",
	"optionalParam" => ""
];

$headers = array(
	"content-type: application/json", 
	"apikey:$apiKey",
	"x-priority: ".$x_priority  //1000 for upi, 0100 for imps, 0010 for neft, 0001 for rtgs
);

$post_url = $bank_url."/v1/composite-status";

$curl = curl_init($post_url);
curl_setopt($curl, CURLOPT_URL, $post_url);
curl_setopt($curl, CURLOPT_POST, true);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($postbody));

$raw_response = curl_exec($curl);
$httpcode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
$err = curl_error($curl);
curl_close($curl);


$request = json_decode($raw_response);
$fp= fopen($file_start."privatekey.key","r");
$priv_key=fread($fp,8192);
fclose($fp);
$res = openssl_get_privatekey($priv_key, "");
openssl_private_decrypt(base64_decode(@$request->encryptedKey), $key, $res);
$encData = base64_decode(@$request->encryptedData); 
$encData = openssl_decrypt(@$encData,"aes-128-cbc",$key,OPENSSL_PKCS1_PADDING);

$newsource = substr(@$encData, 16); 

$responseParam = json_decode(@$newsource,1);

if($sq){
	echo "<br><br>responseParam=>";
	print_r($responseParam);
}

$acquirer_response['responseParam_status']= $responseParam;

$response_array_post=json_encode($acquirer_response, JSON_UNESCAPED_SLASHES);

$acquirer_response['sendRequest_status']	= $sendRequest;
$acquirer_response['postbody_status']		= $postbody;

$new_acquirer_response = json_encode($acquirer_response, JSON_UNESCAPED_SLASHES);

$rmk_date=date('d-m-Y h:i:s A');
$system_note_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$response_array_post." </div></div>".$td['system_note'];

$acquirer_ref = @$responseParam['UTRNUMBER'];

$log = "\n\n".'GUID - '.$transID."===============================\n";
$log .= 'URL - '.$post_url."\n\n";
$log .= 'HEADER - '.json_encode($headers)."\n\n";
$log .= 'REQUEST - '.json_encode($sendRequest)."\n\n";
$log .= 'REQUEST ENCRYPTED - '.json_encode($postbody)."\n\n";

$log.= "\n\nGUID - $transID======================================== \n";
$log.= 'RESPONSE - '.$raw_response."\n\n";
$log.= 'RESPONSE DECRYPTED - '.$newsource."\n\n";

//if(isset($_GET['sq'])&&$_GET['sq'])
if($sq)
{
	echo "<br /><br />LOG=".nl2br($log);
//	exit;
}

db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`"." SET `acquirer_ref`='{$acquirer_ref}',`acquirer_response`='{$new_acquirer_response}',`system_note`='".$system_note_upd."' WHERE `id`='".$td['id']."'",$sq);

if((isset($responseParam))&&($responseParam['STATUS']=='SUCCESS'||$responseParam['success']=='1'))
{
	$_GET['promptmsg']		= 'Withdraw Approved: ';
	$_GET['confirm_amount']	= $amount;
	$_GET['bid']			= $merID;
	$_GET['acquirer']		= $acquirer;

	if($sq)
	{
		echo 'update status';
		print_r($_GET);
	}
	update_trans_ranges(-1, 1, $td['id']);	//	FOR SUCCESS or accept
}
elseif(isset($responseParam)&&$responseParam['STATUS']=='PENDING')
{
	$_GET['promptmsg']		= 'Withdraw Pending: ';
	$_GET['confirm_amount']	= $amount;
	$_GET['bid']			= $merID;
	$_GET['acquirer']		= $acquirer;

	update_trans_ranges(-1, 0, $td['id']);	//	FOR PENDING
}
else
{
	$_GET['promptmsg'] = 'Cancelled: ';

	$_GET['confirm_amount']	= $amount;
	$_GET['bid']			= $merID;
	$_GET['acquirer']		= $acquirer;

	//update_trans_ranges(-1, 2, $td['id']);	//	FOR FAIL or REJECT or CANCEL
}

###############

if(isset($_REQUEST['cron_tab'])&&$_REQUEST['cron_tab']){
	//print_r($cron_tab_array);
	header("Content-Type: application/json", true);	
	$cron_tab_json = json_encode($cron_tab_array);
	echo $cron_tab_json;
	exit;
}

echo "<div class='row rounded border px-1'>";
		if(isset($acquirer_response)&&is_array($acquirer_response)) display_nested_array($acquirer_response);
	echo "</div>";


exit;
//----------------------------------------------------------------
?>