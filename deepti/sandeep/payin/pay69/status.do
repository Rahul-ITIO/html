<?php 
if(!isset($_SESSION)) {
	session_start();
}

include('../../config_db.do');
include('../../include/browser_os_function'.$data['iex']);
$browserOs1=browserOs("1"); $browserOs=json_encode($browserOs1);

error_reporting(0);

//-----------------------------------------------------------

$data['pq']=0;
if((isset($_REQUEST['pq']))&&(!empty($_REQUEST['pq']))){
	$data['pq']=$_REQUEST['pq'];
}

$host_path=$data['Host'];

$status=-99;

$actionurl_get="";
$transID="";$transaction_id=""; $where_pred=""; $message="";

//-----------------------------------------------------------

$onclick='javascript:top.popuploadig();popupclose2();';
$actionurl="";$callbacks_url="";

$is_admin=false; $subQuery="";

// curl parameter get by bank getaway 
if( (isset($_REQUEST['action']))&&($_REQUEST['action']=='asynNtfyUrl') ){
	$this_action=$_REQUEST['action'];
	$_REQUEST['actionurl']='admin_direct';
	$_REQUEST['admin']=$this_action.'_is_curl_getaway';
	$subQuery.='&actionInfo='.$this_action;
}

if((isset($_REQUEST['actionurl']))&&(!empty($_REQUEST['actionurl']))){
	$actionurl=$_REQUEST['actionurl'];
}

// get order_status
if((isset($_REQUEST['order_status']))&&(!empty($_REQUEST['order_status']))){
	$status=$_REQUEST['order_status'];
}

if((isset($_REQUEST['redirecturl']))&&(!empty($_REQUEST['actionurl']))){
	$actionurl.="&redirecturl=".urlencode($_REQUEST['redirecturl']);
}

if(isset($_REQUEST['admin'])&&$_REQUEST['admin']){
	$is_admin=true;
	$subQuery.="&destroy=2&actionurl=$actionurl";
}

if(isset($_REQUEST['cron_tab'])&&$_REQUEST['cron_tab']){
	$subQuery.='&cron_tab='.$_REQUEST['cron_tab'];
}

//-----------------------------------------------------------

if(isset($response['reference'])&&!empty($response['reference'])){
	$transaction_id=$response['reference'];

	$where_pred.=" (`transaction_id`={$transaction_id}) AND";
}
if(isset($_REQUEST['actionurl'])&&!empty($_REQUEST['actionurl'])){
	$actionurl_get=$_REQUEST['actionurl'];
}

if((isset($_REQUEST['oh_id'])&&!empty($_REQUEST['oh_id']))){
	if(!empty($_REQUEST['oh_id'])){
		$transID=$_REQUEST['oh_id'];
	}
}

if((isset($_REQUEST['mh_oid'])&&!empty($_REQUEST['mh_oid']))){
	if(!empty($_REQUEST['mh_oid'])){
		$transID=$_REQUEST['mh_oid'];
	}
}

if((isset($_REQUEST['transID'])&&!empty($_REQUEST['transID']))){
	if(!empty($_REQUEST['transID'])){
		$transID=$_REQUEST['transID'];
	}
}

if(!empty($transID)){
	$transactionId=transIDf($transID,0);
	$uid=transIDf($transID,2);
	$tr_id=transIDf($transID,5);

	$where_pred.=" (`transaction_id`={$transactionId}) AND (`receiver`={$uid}) AND";
	if(!empty($tr_id)){
		$where_pred.=" (`id`={$tr_id}) AND";
	}
}

//----------------------------------------------------------------
function send_attchment_message5($email_to,$email_to_name,$email_subject,$email_message,$email_from='Dev <dev@bigit.io>',$email_reply='Dev <dev@bigit.io>',$pst=0){

	$email_from_name=$email_from;
	$email_from_value="dev@bigit.io";
	if(strpos($email_from,'>')!==false){
		$email_from_name=explode('<',$email_from);$email_from_name=$email_from_name[1];
		$email_from_value=explode('>',$email_from_name);$email_from_value=$email_from_value[0];
	}

	$email_reply_name=$email_reply;
	$email_reply_value="dev@bigit.io";

	if(strpos($email_reply,'>')!==false){
		$email_reply_name=explode('<',$email_reply);$email_reply_name=$email_reply_name[1];
		$email_reply_value=explode('>',$email_reply_name);$email_reply_value=$email_reply_value[0];
	}

	$email_to_value="$email_to_name <$email_to>";

	$ch = curl_init();
	curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
	curl_setopt($ch, CURLOPT_USERPWD, 'api:key-831f358fc91577a53525ae05797e957e');
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

	curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
	curl_setopt($ch, CURLOPT_URL, 'https://api.mailgun.net/v3/mail.ztspay.com/messages');
	curl_setopt($ch, CURLOPT_POSTFIELDS, array('from' => $email_from,
											'to' => $email_to_value,
											'subject' => $email_subject,
											'html' => $email_message,
											//'attachment' => curl_file_create('FULL_PATH_TO_ATTACHMENT')
											));
	curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);

	$result = curl_exec($ch);
	curl_close($ch);

	return $result;
}

	$email_from="nextCogmer<info@cogmer.com>";
	$email_to=$data['testEmail_1'];
	$email_to_name="Dev Tech";
	$email_subject=$td['transaction_id']." - ".$td['type']." Account Type 343 mdPayment - Mailgun Successfully Email has been received from {$_SERVER["HTTP_HOST"]}";
	$email_message="<html><h1>Hello, {$_SERVER["HTTP_HOST"]}</h1><p>Mailgun Successfully Email has been received</p></html>";

	$email_message.="<p><b>urlpath: </b>".$data['urlpath']."</p>";

	if($is_admin){
		$email_message.="<p><b>is_admin: </b>".$is_admin."</p>";
	}
	if($callbacks_url){
		$email_message.="<p><b>callbacks_url: </b>".$callbacks_url."</p>";
	}
	if(isset($_SERVER['HTTP_REFERER'])){
		$email_message.="<p><b>HTTP_REFERER: </b>".$_SERVER['HTTP_REFERER']."</p>";
	}
	if(isset($_POST)){
		$email_message.="<p><b>_POST: </b>".json_encode($_POST)."</p>";
	}
	if(isset($_GET)){
		$email_message.="<p><b>_GET: </b>".json_encode($_GET)."</p>";
	}
	if(isset($_REQUEST)){
		$email_message.="<p><b>_REQUEST: </b>".json_encode($_REQUEST)."</p>";
	}
	if(isset($_SESSION)){
		//$email_message.="<p><b>_SESSION: </b>".json_encode($_SESSION)."</p>";
	}
	if($browserOs){
		$email_message.="<p><b>browserOs</b>".json_encode($browserOs)."</p>";
	} 

	if($data_send){
		$email_message.="<p><b>data_send: </b>".json_encode($data_send)."</p>";
	}

	if(isset($_SERVER)){
		$email_message.="<p><b>_SERVER</b>".json_encode($_SERVER)."</p>";
	} 
	if($td){
		$email_message.="<p><b>transDetails</b>".json_encode($td)."</p>";
	}

	$sam['HostL']=1;

	if($is_admin==false){}

	//--------------------------------------------------------

	$where_pred=substr_replace($where_pred,'', strrpos($where_pred, 'AND'), 3);

	$td=db_rows(
		"SELECT * ". 
		" FROM `{$data['DbPrefix']}transactions`".
		" WHERE ".$where_pred.
		" ORDER BY `id` DESC LIMIT 1",0 //DESC ASC
	);

	$td=$td[0];
	$transID=$td['transID'];

	$jsn=$td['json_value'];
	$json_value=jsondecode($jsn,true);
	$json_value_o=$json_value['q_order_'.$td['type']];

//----------------------------------------------------------------

	unset($_SESSION['acquirer_action']);
	unset($_SESSION['acquirer_response']);
	unset($_SESSION['hkip_status']);
	unset($_SESSION['acquirer_status_code']);
	unset($_SESSION['acquirer_transaction_id']);
	unset($_SESSION['acquirer_descriptor']);
	unset($_SESSION['curl_values']);

	$cardsend="";
	if(isset($json_value['post']['cardsend'])){
		$cardsend=$json_value['post']['cardsend'];
	}
	if(isset($_SESSION['adm_login'])){}

	//review 
	if( ((!isset($_SESSION['adm_login']))&&($td['status']>0)) || ((!isset($_SESSION['adm_login']))&&($cardsend=="curl")) ){}

	$status_failed='';$acquirer=$td['type'];

	if($json_value['host_'.$td['type']]){}

	//---------------------------------------------- 

	$result=$_REQUEST;
	$results=$result;

	$curl_values_arr['responseInfo']=$_REQUEST;
	$curl_values_arr['browserOsInfo']=$browserOs;

	$_SESSION['acquirer_action']=1;
	$_SESSION['acquirer_response']=$result['responseMsg'];

	$_SESSION['acquirer_status_code']=$result['transactionState'];
	$_SESSION['acquirer_transaction_id']=$result['transactionId'];

	$_SESSION['curl_values']=$curl_values_arr;

	if((isset($_SESSION['adm_login']))&&(!empty($_SESSION['adm_login']))){
		include("status".$data['iex']);
	}

	if(isset($_SESSION['acquirer_status_code'])&&($_SESSION['acquirer_status_code']==2)){ // success
		$_SESSION['acquirer_status_code']=2;
		$_SESSION['acquirer_response']="Success";
	}elseif(isset($_SESSION['acquirer_status_code'])&&($_SESSION['acquirer_status_code']==5)){ // failed 
		$_SESSION['acquirer_status_code']=-1;
		$_SESSION['acquirer_response']=$_SESSION['acquirer_response']." - Cancelled";
	}else{ //Pending
		$_SESSION['acquirer_response']=$_SESSION['acquirer_response']." Pending - ".$_SESSION['acquirer_status_code'];
		$_SESSION['acquirer_status_code']=1;

		$data_tdate=date('YmdHis', strtotime($td['tdate']));
		$current_date_1h=date('YmdHis', strtotime("-1 hours"));
		if($data_tdate<$current_date_1h){
			$_SESSION['acquirer_status_code']=-1;
			$_SESSION['acquirer_response']=$_SESSION['acquirer_response']." - Cancelled"; 
		}
	}

	//start: cron step: 1 -----------------------------------------

	$_SESSION['acquirer_response']=str_replace('N/A - ','',$_SESSION['acquirer_response']);

	$data_send=array();
	
	$data_send['transID']=$transID;
	$data_send['acquirer_action']=$_SESSION['acquirer_action'];
	$data_send['acquirer_response']=$_SESSION['acquirer_response'];
	
	$data_send['acquirer_status_code']=$_SESSION['acquirer_status_code'];
	$data_send['acquirer_transaction_id']=$_SESSION['acquirer_transaction_id'];
	$data_send['acquirer_descriptor']=$_SESSION['acquirer_descriptor'];
	$data_send['curl_values']=$_SESSION['curl_values'];
	$data_send['type']=$td['type'];
	$data_send['actionurl']='admin_direct';
	$data_send['admin']='1';

	//end: cron step: 1 -----------------------------------------

	db_disconnect();

	if($_SESSION['acquirer_status_code']==2){ //success
		$return_msg['return_code']='SUCCESS';
		$return_msg['return_msg']='OK';
		echo json_encode($return_msg);
		$callbacks_url = $host_path."/success{$data['ex']}?transID={$transID}&action=hkip".$subQuery; 
		if($data['pq']){
			echo '<br/><br/>1 (2) success callbacks_ur =>'.$callbacks_url;
		}
	}
	elseif($_SESSION['acquirer_status_code']==1){ //pending
		if($is_admin==false){
			$callbacks_url = "{$host_path}/trans_processing{$data['ex']}?transID=$transID&action=hkip";
		}else{
			$callbacks_url = 'javascript:alert("'.$_SESSION['acquirer_response'].'");';
		}
		if($data['pq']){
			echo '<br/><br/>2 (1) pending callbacks_ur =>'.$callbacks_url;
		}
	}
	else{ //failed
		$callbacks_url = $host_path."/failed{$data['ex']}?transID={$transID}&action=hkip".$subQuery; 
		if($data['pq']){
			echo '<br/><br/>3 (-1) failed callbacks_ur =>'.$callbacks_url;
		}
	}

	if(isset($_REQUEST['sp'])){
		echo "<hr/>order_status=>".$_SESSION['acquirer_status_code'];
		echo "<hr/>info=>".$_SESSION['acquirer_response'];
		echo "<hr/>callbacks_url=>".$callbacks_url;
		exit;
	}

	if($is_admin==false){
		post_redirect($callbacks_url, $data_send);
		if($data['pq']){
			echo '<br/><br/>4 is_admin false callbacks_ur =>'.$callbacks_url;
		}
		exit;
	}

	if((isset($_REQUEST['json']))&&(!empty($_REQUEST['json']))){
		$json["acquirer_status_code"]=$_SESSION['acquirer_status_code'];
		$json["callbacks_url"]=$callbacks_url;

		if($data['pq']){
			echo '<br/><br/>5 json callbacks_ur =>';
			print_r($json);
		}

		header("Content-Type: application/json", true);
		echo json_encode($json);
		exit;
	}

if($is_admin){
	if((isset($_REQUEST['actionurl']))&&($_REQUEST['actionurl']=="hkipme"||$_REQUEST['actionurl']=="customer"||$_REQUEST['actionurl']=="admin_direct")){
		if($_SESSION['acquirer_status_code']==1){
			if($data['pq']){
				echo '<br/><br/>6 pending actionurl '.$_REQUEST['actionurl'].' callbacks_ur =>';
				print_r($callbacks_url);
			}
			exit;
		}else{
			//start: cron step: 2 --------------------
			if($_REQUEST['actionurl']=="admin_direct"){
				$use_curl=use_curl($callbacks_url,$data_send);

				if($data['pq']){
					echo '<br/><br/>7 actionurl admin_direct callbacks_ur =>'.$callbacks_url;
					echo '<br/><br/>data_send=>';
					print_r($data_send);

					echo '<br/><br/>use_curl=>';
					print_r($use_curl);
				}

				exit;
			} //end: cron step: 2 --------------------
			else{
				if($data['pq']){
					echo '<br/><br/>8 actionurl '.$_REQUEST['actionurl'].' callbacks_ur =>'.$callbacks_url;
					echo '<br/><br/>data_send=>';
					print_r($data_send);
				}
				post_redirect($callbacks_url, $data_send);
			}
		}
	}

	if ((strpos ( $callbacks_url, $_SERVER['SERVER_NAME'] ) !== false) ){

	}else{
		$callbacks_url=str_replace('actionurl=by_admin','actionurl=admin_direct',$data['urlpath']);
	}

	if($data['pq']){
		echo '<br/><br/>9 actionurl '.$_REQUEST['actionurl'].' callbacks_ur =>'.$callbacks_url;
		echo '<br/><br/>results=>';
		print_r($results);
	}

	echo "<div class='hk_sts'><div class='rows'>";

	if(isset($_SESSION['acquirer_status_code'])){
		echo "<a target='hform' onclick='{$onclick}' href='$callbacks_url' class='upd_status'>Update Status "." [<b>".$_SESSION['acquirer_response']."</b>]"."</a>";
	}else{
		echo "<a target='hform' onclick='{$onclick}' href='$callbacks_url' class='upd_status'>transaction not found [<b>Proceed to Cancelled </b>]"."</a>";
	}

	if(is_array($results)){ 
		foreach($results as $key=>$value){
			if($key!="StateDetails" && $value!="Array" && !empty($value)){
				echo "<div class='dta1 key $key'>".$key."</div><div class='dta1 val'>".isJsonDe($value)."</div>";
			}
			if(is_array($value)){
				echo "<div class='dta1 h1 key $key'>".$key."</div>";
				foreach($value as $key1=>$value1){
					if($key1!="StateDetails" && $value1!="Array" && !empty($value1)){
						if(is_array($value1)){
							echo "<div class='dta1 key $key1'>".$key1."</div><div class='dta1 val'>".json_encode($value1,1)."</div>";
						}else{
							echo "<div class='dta1 key $key1'>".$key1."</div><div class='dta1 val'>".isJsonDe($value1)."</div>";
						}
					}
				}
			}
		}
	}
	echo "</div>";

	echo "<br/><br/>order_status: ".$_SESSION['acquirer_status_code']." [".$_SESSION['acquirer_response']."]";
	echo "<br/><br/>pid: ".$_SESSION['acquirer_transaction_id'];
	echo "<br/><br/>billing_desc: ".$_SESSION['acquirer_descriptor'];
	echo "<br/><br/>respMsg: ".$_SESSION['acquirer_response'];
	echo "<br/><br/>mh_oid: ".$transID;
	echo "<br/><br/>site_id: ".$site_id;
}
exit;

//----------------------------------------------------------------
?>