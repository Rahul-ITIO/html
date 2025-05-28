<?
$data['NO_SALT']=true;
$qp=0;
$data['pq']=0;
$r2='';

//as per request connection if multiple 
if(isset($data['DB_CON'])&&isset($_REQUEST['DBCON'])&&trim($_REQUEST['DBCON'])&&function_exists('config_db_more_connection'))
{
	$DBCON=(isset($_REQUEST['DBCON'])?$_REQUEST['DBCON']:"");
	$dbad=(isset($_REQUEST['dbad'])?$_REQUEST['dbad']:"");
	$dbmt=(isset($_REQUEST['dbmt'])?$_REQUEST['dbmt']:"");
	config_db_more_connection($DBCON,$dbad,$dbmt);
}


if((isset($_REQUEST['r2']))&&(!empty($_REQUEST['r2']))){
	$r2='2';
}
if((isset($_REQUEST['pq']))&&(!empty($_REQUEST['pq']))){
	$qp=$data['pq']=$pq=$_REQUEST['pq'];
}
if(isset($_REQUEST['qp'])&&$_REQUEST['qp']) {
	$qp=$data['pq']=$pq=$_REQUEST['qp'];
}

if(((!isset($_REQUEST['transID']))||(empty($_REQUEST['transID'])))&&(isset($_REQUEST['orderset'])&&trim($_REQUEST['orderset']))){
		$_REQUEST['transID']=$_REQUEST['orderset'];
}

if(((!isset($_REQUEST['transID']))||(empty($_REQUEST['transID'])))&&(!isset($data['transIDExit']))){
	echo 'transID missing!!!';
	exit;
}
$host_path=$data['Host'];

	$status='';

	$actionurl_get	="";
	$where_pred		="";

	//-----------------------------------------------------------

	$onclick='javascript:top.popuploadig();popupclose2();';
	$actionurl		="";
	$callbacks_url	="";

	$is_admin=false; $subQuery="";

	// get order_status
	if((isset($_REQUEST['status']))&&(!empty($_REQUEST['status']))){
		$status=$_REQUEST['status'];
	}

	if((isset($_REQUEST['actionurl']))&&(!empty($_REQUEST['actionurl']))){
		$actionurl=$_REQUEST['actionurl'];
	}
	if((isset($_REQUEST['redirecturl']))&&(!empty($_REQUEST['redirecturl']))){
		$actionurl.="&redirecturl=".urlencode($_REQUEST['redirecturl']);
	}
	
	if(isset($_REQUEST['actionurl'])&&$_REQUEST['actionurl']=='by_admin'){
		$_REQUEST['admin']=$_REQUEST['actionurl'];
	}
	
	if((isset($_REQUEST['admin'])&&$_REQUEST['admin'])||(isset($_REQUEST['actionurl'])&&$_REQUEST['actionurl']=="admin_direct")||(isset($_REQUEST['cron_tab'])&&$_REQUEST['cron_tab'])){
		
		$is_admin=true;
		$subQuery="&destroy=2&actionurl=$actionurl";
	}
	
	if(isset($_REQUEST['actionurl'])&&$_REQUEST['actionurl']=='notify'){
		$subQuery="&destroy=2";
	}
	
	if(isset($_REQUEST['action'])&&$_REQUEST['action']=='webhook'){
		$subQuery="&destroy=2";
	}

	if(isset($_REQUEST['cron_tab'])&&$_REQUEST['cron_tab']){
		$subQuery.='&cron_tab='.$_REQUEST['cron_tab'];
	}

	if(isset($_REQUEST['actionInfo'])&&$_REQUEST['actionInfo']){
		$subQuery.="&actionInfo=".$_REQUEST['actionInfo'];
	}

//-----------------------------------------------------------

if(isset($orderId_get)&&!empty($orderId_get)){
	$transID=$orderId_get;
	$where_pred.=" (`transID`={$transID}) AND";
}
if(isset($_REQUEST['actionurl'])&&!empty($_REQUEST['actionurl'])){
	$actionurl_get=$_REQUEST['actionurl'];
}



if(isset($_SESSION['acquirer_action']))unset($_SESSION['acquirer_action']); 
if(isset($_SESSION['acquirer_response']))unset($_SESSION['acquirer_response']);
if(isset($_SESSION['acquirer_status_code']))unset($_SESSION['acquirer_status_code']);
if(isset($_SESSION['acquirer_transaction_id'])) unset($_SESSION['acquirer_transaction_id']);
if(isset($_SESSION['acquirer_descriptor'])) unset($_SESSION['acquirer_descriptor']);
if(isset($_SESSION['curl_values'])) unset($_SESSION['curl_values']);

if(isset($_SESSION['responseAmount'])) unset($_SESSION['responseAmount']);

if($qp){
	echo "<br/><br/>_REQUEST transID=>".@$_REQUEST['transID'];
}


if((isset($_REQUEST['transID'])&&!empty($_REQUEST['transID']))){
	
	$transID=$_REQUEST['transID'];
	
	if(strpos($transID,'?') !== false){
		$transID=explode('?',$transID)[0];
	}
	
	
	$transID=transIDf($transID,0);
	$where_pred.=" (`transID`={$transID}) AND";
	
}

if(isset($_REQUEST['tr_id'])&&!empty($_REQUEST['tr_id'])){
	$where_pred.=" (`id`={$_REQUEST['tr_id']}) AND";
}

//acquirer_ref
if(isset($_REQUEST['acquirer_ref'])&&!empty($_REQUEST['acquirer_ref'])){
	$where_pred.=" (`acquirer_ref`={$_REQUEST['acquirer_ref']}) AND";
}

// transactions get ----------------------------

if(empty($where_pred)&&isset($where_pred_curl)&&$where_pred_curl) $where_pred = $where_pred_curl;

$where_pred=substr_replace($where_pred,'', strrpos($where_pred, 'AND'), 3);

if($qp){
	echo "<br/><br/>where_pred=>".$where_pred;
}


if(trim($where_pred)){
	
	$time_log['status_top_start_1']=(new DateTime())->format('Y-m-d H:i:s.u');	
	
	//Select Data from master_trans_additional
	$join_additional=join_additional();
	
	$td_get=db_rows(
		"SELECT * ". 
		" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
		" {$join_additional} WHERE ".$where_pred.
		" LIMIT 1",$qp //DESC ASC
	);
	
	$time_log['status_top_select_trans_2']=(new DateTime())->format('Y-m-d H:i:s.u');	
}

$td=@$td_get[0];
if(isset($td['transID'])&&trim($td['transID'])){
	$transID=transIDf($td['transID'],0);
}

$reference		= @$td['reference'];
$trans_status	= @$td['trans_status'];
$acquirer_ref	= @$td['acquirer_ref'];
$tdate			= @$td['tdate'];
$acquirer		= @$td['acquirer'];
$acquirer_response_stage1		= @$td['acquirer_response_stage1'];



if(isset($acquirer_response_stage1)&&@$acquirer_response_stage1){
	
	$acquirer_response_stage1_decode64f  = decode64f($acquirer_response_stage1);
	//echo "<br/><hr/>acquirer_response_stage1=>".$acquirer_response_stage1_decode64f;
	$acquirer_response_stage1_arr = isJsonDe($acquirer_response_stage1_decode64f);
	
	//echo "<br/><hr/>acquirer_response_stage1_arr=>";print_r($acquirer_response_stage1_arr);
	
}

// Dev Tech : 23-08-16 Crosse checking for response amount via bill_amt ( actual amount )
if(isset($td['bank_processing_amount'])&&trim($td['bank_processing_amount'])&&$td['bank_processing_amount']!='0.00'&&$td['bank_processing_amount']!=null)
	$_SESSION['bank_processing_amount']=@$td['bank_processing_amount']; // Bank Processing Amount from DB 
elseif(isset($td['bill_amt'])&&trim($td['bill_amt']))
	$_SESSION['bank_processing_amount']=@$td['bill_amt']; // Bank Processing Amount from DB



if(isset($td['acquirer'])&&$td['acquirer']>0){
	$time_log['status_top_select_acquirer_table_3']=(new DateTime())->format('Y-m-d H:i:s.u');	
	// bank db get ----------------------------
	$acquirer_table_db=db_rows(
		"SELECT * FROM {$data['DbPrefix']}acquirer_table".
		" WHERE `acquirer_id`=".$td['acquirer'].
		" ORDER BY id DESC LIMIT 1"
	);
	$acquirer_table=@$acquirer_table_db[0];
	$acquirer_descriptor=@$acquirer_table['acquirer_descriptor'];
	if($acquirer_descriptor) $_SESSION['acquirer_descriptor'] = $acquirer_descriptor;
	
	$acquirer_prod_mode=@$acquirer_table['acquirer_prod_mode'];
	$acquirer_uat_url=@$acquirer_table['acquirer_uat_url'];
	$acquirer_status_url=@$acquirer_table['acquirer_status_url'];
	$acquirer_refund_url=@$acquirer_table['acquirer_refund_url'];
	
	$bank_acquirer_json_arr=jsondecode(@$acquirer_table['mer_setting_json'],1,1);
	$time_log['status_top_select_acquirer_table_4']=(new DateTime())->format('Y-m-d H:i:s.u');	
}



$jsn=@$td['json_value'];

//$jsn=str_replace(array('"{"','"}"'),array('{"','"}'),$jsn);
//$jsn=str_replace(array('{order_token},'),array('{order_token}",'),$jsn);


if($qp){
	echo "<hr>JSN=><br />";
	echo $jsn;
}

$json_value=jsondecode($jsn,true,1);

if(isset($json_value['post'])&&isset($json_value['get'])&&is_array($json_value['post'])&&is_array($json_value['get']))
			$json_value['post']=array_merge($json_value['post'],$json_value['get']);
		

if(isset($json_value)&&is_array($json_value)) $json_value=htmlTagsInArray($json_value);

$data['json_value'] = $json_value;


if(isset($td['acquirer_creds_processing_final'])&&trim($td['acquirer_creds_processing_final']))
	$acquirer_creds_processing_final=jsondecode($td['acquirer_creds_processing_final'],1,1);

if(isset($acquirer_creds_processing_final)&&is_array($acquirer_creds_processing_final)){
	$data['apJson'] = $acquirer_creds_processing_final;
	$step_apc_get='1. acquirer_creds_processing_final';
}else if(isset($json_value['acquirer_processing_json'])&&is_array($json_value['acquirer_processing_json'])){
	$data['apJson'] = $json_value['acquirer_processing_json'];
	$step_apc_get='2. acquirer_processing_json';
}elseif(isset($json_value['acquirer_processing_creds'])&&is_array($json_value['acquirer_processing_creds'])){
	$data['apJson'] = $json_value['acquirer_processing_creds'];
	$step_apc_get='3. acquirer_processing_creds';
}


//echo "<hr>apJson=><br />";print_r($data['apJson']);

$apc_get=@$data['apJson'];

if($qp){
	
	echo '<div type="button" class="btn btn-success my-2" style="background: #fff2d4;color:#2c2c2c;padding:5px 10px;border-radius:2px;margin:10px auto;width:fit-content;display:block;max-width:99%;">';
	
	echo "<hr>step apc_get=> ".$step_apc_get;
	echo "<hr>apc_get=><br />";print_r(@$apc_get);
	
	if($qp==2) { 
		echo "<hr>json_value=><br />"; print_r(htmlentitiesf(@$json_value)); 
	}
	
	echo '<br/><br/></div>';
}

$integrationType=@$json_value['post']['integration-type'];



//Dev Tech : 23-10-03 is_expired check - start  
	
$is_expired='N';  // is_expired set N => Not expired  


if(isset($td['transID'])&&trim($td['transID'])&&isset($td['acquirer'])&&$td['acquirer']>0)
{	
	$time_log['status_top_auto_expired_5']=(new DateTime())->format('Y-m-d H:i:s.u'); 
	if(isset($json_value['trans_auto_expired'])&&$json_value['trans_auto_expired']>0){
		$expired_times_count=((int)$json_value['trans_auto_expired']);
	}elseif(isset($acquirer_table['trans_auto_expired'])&&$acquirer_table['trans_auto_expired']>0){
		$expired_times_count=((int)$acquirer_table['trans_auto_expired']);
	}
	else $expired_times_count=10; // else 10 minutes
	
	$data_tdate_get=date('YmdHis', strtotime($td['tdate']));
	if(isset($expired_times_count)&&$expired_times_count>0){
		$expired_times=date('YmdHis', strtotime("-{$expired_times_count} minutes"));
	}
	//echo '<br/>data_tdate_get=>'.$data_tdate_get; echo '<br/>expired_times=>'.$expired_times;
	if((isset($expired_times_count)&&$expired_times_count>0&&isset($expired_times))&&($data_tdate_get<$expired_times))
	{
		$is_expired='Y';	
	}	
}

//Dev Tech : 23-10-03 is_expired check - end 


$retrun_via_status='Y';

//Dev Tech: 23-11-02 Skip the check for retrun status when trans status is 22 via webhook 
if(isset($_REQUEST['action'])&&($_REQUEST['action']=='notify'||$_REQUEST['action']=='webhook'||$_REQUEST['action']=='e')&&(@$td['trans_status']==22||@$td['trans_status']==23)){
	$retrun_via_status='Skip'; 
}	

// If trans_status is above of 0 than retrun via status  
if(isset($td['transID'])&&trim($td['transID'])&&isset($td['acquirer'])&&$td['acquirer']>0&&@$td['trans_status']>0&&@$retrun_via_status=='Y')
{
	$time_log['status_top_fetch_trnsStatus_6']=(new DateTime())->format('Y-m-d H:i:s.u'); 
	
	if(isset($_REQUEST['cron_tab'])&&$_REQUEST['cron_tab']){

	}else{
		
		$fetch_trnsStatus_url=$host_path."/fetch_trnsStatus".$data['ex'];
		$valid_data=array();
		$valid_data['transID']=@$td['transID'];
		if(isset($json_value['get']['public_key'])&&$json_value['get']['public_key']) $valid_data['public_key']=$json_value['get']['public_key'];
		if(isset($json_value['post']['public_key'])&&$json_value['post']['public_key']) $valid_data['public_key']=$json_value['post']['public_key'];
		if($td['reference']) $valid_data['reference']=@$td['reference'];
		$valid_data['actionurl']='validate';
		
		if(isset($_REQUEST['webhook_id'])&&trim($_REQUEST['webhook_id'])) {
			$valid_data['webhook_id']=@$_REQUEST['webhook_id'];
		}
		
		/*
		if((!isset($_SESSION['adm_login']))&&(empty($_SESSION['adm_login']))&&(@$td['trans_status']>0))
		{
			if(isset($json_value['post']['integration-type'])&&$json_value['post']['integration-type']=='s2s')
			{
				$use_curl=use_curl($fetch_trnsStatus_url,$valid_data);
				//print_r($use_curl);
			}
			post_redirect($fetch_trnsStatus_url, $valid_data);
			exit;
		}
		*/
		
		
		if( (!isset($_SESSION['adm_login']))&&(empty($_SESSION['adm_login']))&&($integrationType!="s2s")&&(@$td['trans_status']>0) )
		{
			$fetch_trnsStatusUrl=$_SESSION['fetch_trnsStatusUrl']=$fetch_trnsStatus_url."?".http_build_query($valid_data); 
			
?><!DOCTYPE html>
<html lang="en" data-bs-theme="light">
<head>
<title>Processing Done...</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
<meta http-equiv="Content-Security-Policy" content="default-src 'self'; font-src * 'unsafe-inline'; style-src * 'unsafe-inline'; script-src * 'unsafe-inline' 'unsafe-eval'; img-src * data: 'unsafe-inline'; connect-src * 'unsafe-inline'; frame-src *; object-src 'none'" />
<script type="text/javascript">
function closePayinWindow() {
	window.close();
	if (window.opener && window.opener.document) {
		//parent.window.close();
		opener.closePayinWindow();
	}
	
}
</script>
</head>
<body onload="javascript:closePayinWindow();" style="text-align:center;font-family:arial,sans-serif;font-size:14px;color:#4d4c4c;">
<h3 style="font-size:14px;color:#4d4c4c;margin:30px 0;">Processing Done...</h3>
<button onclick="javascript:closePayinWindow();" style="float:none;display:block;clear:both;width:250px;text-align:center;margin:15px auto;line-height:40px;border-radius:3px;background-color:#dff0d8;font-size:14px;border:none;">Close Window</button>
<br/><br/>OR <br/><br/>
<a target="_top" href='<?=@$fetch_trnsStatusUrl?>' class="upd_status" style="float:none;display:block;clear:both;width:250px;text-align:center;margin:15px auto;line-height:40px;border-radius:3px;background-color:#dff0d8;font-size:16px;text-decoration: none;color:#011801;border:none;">Check Response</a>
</body>
</html>
<?
exit;
			echo "<a target='_top' href='$fetch_trnsStatusUrl' class='upd_status' style='float:none;display:block;clear:both;width:250px;text-align:center;margin:15px auto;line-height:40px;border-radius:3px;background-color:#dff0d8;font-size:16px'>Check Status</a>";
			//echo "ACCESS DENY";  
			exit;
		}
		else if((!isset($_SESSION['adm_login']))&&(empty($_SESSION['adm_login']))&&(@$td['trans_status']>0))
		{
			/*
			if(isset($json_value['post']['integration-type'])&&$json_value['post']['integration-type']=='s2s'){
				$use_curl=use_curl($fetch_trnsStatus_url,$valid_data);
				//print_r($use_curl);
			}
			else {
				post_redirect($fetch_trnsStatus_url, $valid_data);
				exit;
			}
			*/
			
			post_redirect($fetch_trnsStatus_url, $valid_data);
			exit;
				
			
		}
		
	}
		
}
	
	
// end : include_status_top



?>