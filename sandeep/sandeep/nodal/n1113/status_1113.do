<?php 
include('../../config.do');
//cmn
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
$bank_master = select_tablef('`payout_id` IN (1113)','bank_payout_table');
 
$bjson = decode_f($bank_master['encode_processing_creds']);

$encode_processing_creds = json_decode($bjson,true);

if($bank_master['payout_prod_mode']==1) {
	$siteid_set	= $encode_processing_creds['live'];
	$bank_url	= $bank_master['bank_payment_url'];
	$status_url = $bank_master['bank_status_url'];
}
else {
	$siteid_set	= $encode_processing_creds['test'];
	$bank_url	= $bank_master['payout_uat_url'];
	$status_url = $siteid_set['status_url'];
}

$siteid_get['merchantId']	= $siteid_set['merchantId'];
$siteid_get['secretKey']	= $siteid_set['secretKey'];
$siteid_get['status_url']	= $siteid_set['status_url'];

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
if(isset($_POST['payout_amount'])&&$_POST['payout_amount']){
	$amount	= abs($_POST['payout_amount']);
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
if($cp){
	print_r($td);
	//exit;
}
$td=$td[0];
$id	= $td['id'];
$acquirer	= $td['acquirer'];
$merID	= $td['merID'];


$post_url=$siteid_get['status_url']."/".$siteid_get['merchantId']."/FundOutStatus/$transID";	

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

if(isset($data['pq'])&&$data['pq']){
	print_r($responseParam);
}

$acquirer_response['responseParam']= $responseParam;

$response_array_post=json_encode($acquirer_response, JSON_UNESCAPED_SLASHES);

$acquirer_response['sendRequest']	= $sendRequest;
$acquirer_response['postbody']		= $postbody;

$new_acquirer_response = json_encode($acquirer_response, JSON_UNESCAPED_SLASHES);

$rmk_date=date('d-m-Y h:i:s A');
$system_note_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$response_array_post." </div></div>".$td['system_note'];

db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`"." SET `acquirer_response`='{$new_acquirer_response}',`system_note`='".$system_note_upd."' WHERE `id`='".$td['id']."'");

if($responseParam['status']=='000')
{
	$_GET['promptmsg']		= 'Withdraw Approved: ';
	$_GET['confirm_amount']	= $amount;
	$_GET['bid']			= $merID;
	$_GET['acquirer']			= $acquirer;

	update_trans_ranges(-1, 1, $td['id']);	//	FOR SUCCESS or accept
}
elseif($responseParam['status']=='001')
{
	$_GET['promptmsg'] = 'Cancelled: ';

	$_GET['confirm_amount']	= $amount;
	$_GET['bid']			= $merID;
	$_GET['acquirer']			= $acquirer;
	//update_trans_ranges(-1, 2, $td['id']);	//	FOR FAIL or REJECT or CANCEL
}
else
{
	$_GET['promptmsg']		= 'Withdraw Pending: ';
	$_GET['confirm_amount']	= $amount;
	$_GET['bid']			= $merID;
	$_GET['acquirer']			= $acquirer;

	update_trans_ranges(-1, 0, $td['id']);	//	FOR SUCCESS or accept
}


###############

if(isset($_REQUEST['cron_tab'])&&$_REQUEST['cron_tab']){
	//print_r($cron_tab_array);
	header("Content-Type: application/json", true);	
	$cron_tab_json = json_encode($cron_tab_array);
	echo $cron_tab_json;
	exit;
}

if(is_array($acquirer_response)){
	echo "<br /><br /><div class='hk_sts'>";
	foreach($acquirer_response as $key=>$value){
		if($key!="data" && $value!="Array" && !empty($value) && !is_array($value)){
			echo "<div class='dta1 key $key'>".$key."</div><div class='dta1 val'>".$value."</div>";
		}
		if(is_array($value)){
			echo "<div class='dta1 h1 key $key'>".$key."</div>";
			foreach($value as $key1=>$value1){
				if($key1!="data" && $value1!="Array" && !empty($value1)){
					echo "<div class='dta1 key $key1'>".$key1."</div>
						<div class='dta1 val'>".$value1."</div>";
				}
			}
		}
	}
	echo '</div>';
}
exit;
//----------------------------------------------------------------
?>