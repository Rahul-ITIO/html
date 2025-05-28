<?
// start : include_status_top

$qp=0;
$data['pq']=0;

if((isset($_REQUEST['pq']))&&(!empty($_REQUEST['pq']))){
	$data['pq']=$_REQUEST['pq'];
	$qp=1;
}
if((isset($_REQUEST['response']))&&(!empty($_REQUEST['response']))){
	$re_response=$_REQUEST['response'];
	$re_dec = json_decode($re_response, true);
	if(isset($re_dec['txRef'])&&!empty($re_dec['txRef']))
	{
		$txRef = $re_dec['txRef'];
		$_REQUEST['actionurl']='notify';
		$_REQUEST['transaction_id'] = $txRef;
	}
}
if((!isset($_REQUEST['transaction_id'])||empty($_REQUEST['transaction_id']))&&(!isset($data['ordersetExit']))){
	echo 'Orderset missing!!!';
	exit;
}
$host_path=$data['Host'];

	$status='';

	$actionurl_get	="";
	$transaction_id		="";
	$transaction_id	=""; 
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

	if(isset($_REQUEST['cron_tab'])&&$_REQUEST['cron_tab']){
		$subQuery.='&cron_tab='.$_REQUEST['cron_tab'];
	}

	if(isset($_REQUEST['actionInfo'])&&$_REQUEST['actionInfo']){
		$subQuery.="&actionInfo=".$_REQUEST['actionInfo'];
	}



isset($_REQUEST['payout_action']) unset($_SESSION['payout_action']);
isset($_REQUEST['payout_info']) unset($_SESSION['payout_info']);
isset($_REQUEST['payout_order_status']) unset($_SESSION['payout_order_status']);
isset($_REQUEST['payout_pid']) unset($_SESSION['payout_pid']);
isset($_REQUEST['payout_billing_desc']) unset($_SESSION['payout_billing_desc']);
isset($_REQUEST['curl_values']) unset($_SESSION['curl_values']);

if((isset($_REQUEST['transaction_id'])&&!empty($_REQUEST['transaction_id']))){
	if(!empty($_REQUEST['transaction_id'])){
		$transaction_id=$_REQUEST['transaction_id'];
		$where_pred.=" (`transaction_id`={$transactionId}) AND";
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


$jsn=$td['json_log'];

if($qp){
	echo "<hr>JSN=><br />";
	echo $jsn;
}

$json_value=jsondecode($jsn,1,1);

$data['json_value'] = $json_value;

if($qp){
	echo "<hr>json_value=><br />";
	print_r($json_value);
}

$cardsend=$json_value['post']['cardsend'];

if(isset($json_value['host_'.$td['transaction_type']])&&$json_value['host_'.$td['transaction_type']]){
	//$host_path=$json_value['host_'.$td['transaction_type']];
}

//include('status_in_email'.$data['iex']);

if(isset($_REQUEST['cron_tab'])&&$_REQUEST['cron_tab']){

}else{
	/*	
	$validate_url=$host_path."/payout_validate".$data['ex'];
	$valid_data=array();
	$valid_data['transaction_id']=$td['transaction_id'];
	if(isset($json_value['get']['api_token'])&&$json_value['get']['api_token']) $valid_data['api_token']=$json_value['get']['api_token'];
	if(isset($json_value['post']['api_token'])&&$json_value['post']['api_token']) $valid_data['api_token']=$json_value['post']['api_token'];
	if($td['mrid']) $valid_data['id_order']=$td['mrid'];
	$valid_data['actionurl']='validate';
	
	if((!isset($_SESSION['adm_login']))&&(empty($_SESSION['adm_login']))&&($cardsend!="curl")&&($td['status']>0)&&(empty($_SERVER['HTTP_REFERER']))){
		$validateUrl=$validate_url."?".http_build_query($valid_data);
		echo "<a target='_top' href='$validateUrl' class='upd_status' style='float:none;display:block;clear:both;width:250px;text-align:center;margin:15px auto;line-height:40px;border-radius:3px;background-color:#dff0d8;font-size:16px'>Check Status</a>";
		//echo "ACCESS DENY";  
		exit;
	}else if((!isset($_SESSION['adm_login']))&&(empty($_SESSION['adm_login']))&&($cardsend!="curl")&&($td['status']>0)&&(!empty($_SERVER['HTTP_REFERER']))){
		
		if(isset($json_value['post']['cardsend'])&&$json_value['post']['cardsend']=='curl'){
			$use_curl=use_curl($validate_url,$valid_data);
			//print_r($use_curl);
		}else{
			post_redirect($validate_url, $valid_data);
		}
		exit;
		
	}
	*/
}

// end : include_status_top

?>