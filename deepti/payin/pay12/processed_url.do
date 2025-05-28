<?php 

if(!isset($_SESSION)) {
	session_start();
}

include('../../config_db.do');
include('../../include/browser_os_function'.$data['iex']);
$browserOs1=browserOs("1"); $browserOs=json_encode($browserOs1);
//echo $browserOs;exit;

//-----------------------------


	$data['pq']=0;

	$host_path=$data['Host'];

	$status=''; $message="";

	$actionurl_get="";
	$transID="";$transaction_id=""; $where_pred="";

	//-----------------------------------------------------------
	
	$onclick='javascript:top.popuploadig();popupclose2();';
	$actionurl="";$callbacks_url="";
		
	$is_admin=false; $subQuery="";
	
	
	if(isset($_REQUEST['qp'])){
		$data['pq']=1;
	}
	
	if(isset($_REQUEST['action'])&&$_REQUEST['action']=='processed_redirect_status'){
		$_REQUEST['admin']=1;
		$_REQUEST['actionurl']="admin_direct";
	}
	
	if((isset($_REQUEST['actionurl']))&&(!empty($_REQUEST['actionurl']))){
		$actionurl=$_REQUEST['actionurl'];
	}
	if((isset($_REQUEST['redirecturl']))&&(!empty($_REQUEST['actionurl']))){
		$actionurl.="&redirecturl=".urlencode($_REQUEST['redirecturl']);
	}
	
	if(isset($_REQUEST['admin'])&&$_REQUEST['admin']){
		$is_admin=true;
		$subQuery="&destroy=2&actionurl=$actionurl";
		
		//$host_path=$data['HostG'];
	}
		
	
//----------------------------------------------------------------

//$orderId = "342001185943061748";
$orderId = "";
if(isset($_REQUEST['orderId'])){
	$orderId = $_REQUEST['orderId'];
	
	$transaction_id=$_REQUEST['orderId'];
	
	$where_pred.=" (`transaction_id`={$transaction_id}) AND";
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
		//$where_pred.=" (`transID`='{$transID}') AND ";
		
//		$where_pred.=" (`transaction_id`={$transactionId}) AND (`receiver`={$uid}) AND";
		$where_pred.=" (`transaction_id`={$transactionId}) AND ";
		if(!empty($tr_id)){
			$where_pred.=" (`id`={$tr_id}) AND";
		}
		
		if(empty($orderId)){
			//$orderId=$transactionId;
		}
		
		$orderId=$transactionId;
		
	}
	


// transactions get ----------------------------

$where_pred=substr_replace($where_pred,'', strrpos($where_pred, 'AND'), 3);

//echo "<hr/>where_pred=>".$where_pred; echo "<hr/>transaction_id=>".$transaction_id;

$td=db_rows(
	"SELECT * ". 
	" FROM `{$data['DbPrefix']}transactions`".
	" WHERE ".$where_pred.
	" ORDER BY `id` DESC LIMIT 1",0 //DESC ASC
);
//print_r($td);
$td=$td[0];

//$transaction_amt = $td['transaction_amt'];

	$jsn=$td['json_value'];
//$jsn=str_replace(array('"{"','"}"'),array('{"','"}'),$jsn);
	$json_value=jsondecode($jsn,true,1);
	$jvg_value='';
	if(isset($json_value['sciName'])&&$json_value['sciName']){
		$jvg_value=$json_value['sciName'];
	}
	if(isset($json_value['q_order_'.$td['type']]['g'])&&$json_value['q_order_'.$td['type']]['g']){
		$jvg=$json_value['q_order_'.$td['type']]['g'];
		$jvg_value=$jvg['ac_sci_name'];

		$ac_amount = $jvg['ac_amount'];
		$ac_currency = $jvg['ac_currency'];
	}
	elseif(isset($json_value['q_order_s_'.$td['type']]['g'])&&$json_value['q_order_s_'.$td['type']]['g']){
		$jvg=$json_value['q_order_s_'.$td['type']]['g'];
		$jvg_value=$jvg['sciName'];

		$ac_amount = $jvg['amount'];
		$ac_currency = $jvg['currency'];
	}
	//if(!$jvg_value){$jvg_value=$jvg1;}
	//print_r($jvg['ac_sci_name']);
//echo "<hr/>type=>".$td['type'];




// bank db get ----------------------------
$bank_getway=db_rows(
	"SELECT * FROM {$data['DbPrefix']}bank_gateway_table".
	" ORDER BY id DESC"
);
foreach($bank_getway as $key=>$value){
	$_SESSION["b_".$value['account_no']]=$value;
}
		
//print_r($bank_getway);
//$bank_payment_url_31=$_SESSION['b_31']['bank_payment_url'];


// account db - site_id get ----------------------------

$accounts=select_accounts($td['receiver'], 0, true, $td['type']);
if($accounts[0]['hkip_siteid']){
	$site_id=$accounts[0]['hkip_siteid'];
	if($site_id){
		$siteid_array = json_decode($site_id, true);
		$api_key=$siteid_array['api_key'];
		$secret_key=$siteid_array['secret-key'];
	}
}
//exit;




//----------------------------------------------------------------
	if($data['pq']){
		echo "JSON VAL";
		print_r($json_value);
		echo "<br/>sciName jvg_value=>".$jvg_value;
		print_r($jvg);
	}

	ini_set('max_execution_time', 0);
	require_once("MerchantWebService.php");
	$merchantWebService = new MerchantWebService();

	$arg0 = new authDTO();
	
	include('config_adv.php');

	

	$arg1 = new paymentOrderRequest();
	//$arg1->sciName = "website scI adv";
	$arg1->sciName = $sciName;
	$arg1->orderId = $orderId;

	$findPaymentByOrderId = new findPaymentByOrderId();
	$findPaymentByOrderId->arg0 = $arg0;
	$findPaymentByOrderId->arg1 = $arg1;


	$findPaymentByOrderIdResponse = $merchantWebService->findPaymentByOrderId($findPaymentByOrderId);
	$results2=($findPaymentByOrderIdResponse->return);
		
	$status=$results2->cryptoCurrencyInvoiceStatus;
	$paymentStatus=$results2->paymentStatus;
	$transactionStatus=$results2->transactionStatus;
	$transactionAmount=$results2->transactionAmount;	
	$transactionCurrency=$results2->transactionCurrency;	
	
	 $results =  (array) $results2;
	
	 $message = $status;
	
	try {
		
		if($data['pq']){
			echo "<hr/>cryptoCurrencyInvoiceStatus==>".$results2->cryptoCurrencyInvoiceStatus; echo "<hr/>paymentStatus==>".$results2->paymentStatus; echo "<hr/>results2==>".json_encode($results2);
			
			 echo "<hr/>paymentOrderResult==>";
			
			
			//foreach ($results as $key=>$value) { echo "$key => $results[$key]\n"; }

			 print_r($results);
			
		}
		
	} catch (Exception $e) {
		$message =$e->getMessage();
		$message.=$e->getTraceAsString();
		//echo "ERROR MESSAGE => " . $e->getMessage() . "<br/>"; echo $e->getTraceAsString();
	}



//----------------------------------------------------------------

		unset($_SESSION['acquirer_action']);
		unset($_SESSION['acquirer_response']);
		unset($_SESSION['hkip_status']);
		unset($_SESSION['acquirer_status_code']);
		unset($_SESSION['acquirer_transaction_id']);
		unset($_SESSION['acquirer_descriptor']);
		unset($_SESSION['curl_values']);
		
		db_disconnect();

	if(isset($json_value['host_'.$td['type']])){
		$host_path=$json_value['host_'.$td['type']];
	}else{
		$host_path=$data['Host'];
	}
 
	
	if(isset($results)){
		$_SESSION['curl_values']=json_encode($results);
		
	}

//end: bank status ----------------------------------------------
		
		
//----------------------------------------------------------------		

		

		//if(isset($status)||isset($transactionStatus)){
			$_SESSION['acquirer_action']=1;
			$_SESSION['acquirer_transaction_id']=$results2->transactionId;
			$_SESSION['acquirer_descriptor']=$_SESSION['b_'.$td['type']]['billing_descriptor'];
			
			if($transactionStatus=="COMPLETED"||$transactionStatus=="CONFIRMED"||$status=="PAYMENT_RECEIVED"){ // //success
				$_SESSION['acquirer_response']=$message." Success";
				$_SESSION['hkip_status']=2;
				$_SESSION['acquirer_status_code']=2;

				if(!empty($transactionAmount))
				{
					if(strtoupper($transactionCurrency)=='BTC')
					{
						$t_amt = $transactionAmount;
						$p_amt = $ac_amount;
					}
					else
					{
						$d_amt = $transactionAmount-$ac_amount;
						
						$t_amt = round($transactionAmount);
						$p_amt = round($ac_amount);
						
						if($d_amt!=0) $_SESSION['acquirer_response'].= " (Diff. $d_amt)";
					}
					if(trim($t_amt)!=trim($p_amt) || trim($transactionCurrency)!=trim($ac_currency))
					{
						$_SESSION['acquirer_response']=$message." Under Pending - Reason: Transaction Amount: $ac_currency $ac_amount while received amount: $transactionCurrency $transactionAmount";
						$status_completed=false;
						
						$_SESSION['acquirer_status_code']=1;
					}
				}
			}
			elseif($transactionStatus=="CANCELED"||$status=="EXPIRED"){	//failed 
				$_SESSION['acquirer_response']=$message."Cancelled";
				$_SESSION['hkip_status']=-1;
				$_SESSION['acquirer_status_code']=-1;
			}
			else{ //pending
				$_SESSION['acquirer_response']=$message."Pending";
				$status_completed=false;
				$_SESSION['acquirer_status_code']=1;
				if((isset($_REQUEST['actionurl']))&&(!empty($_REQUEST['actionurl']))){
					$_SESSION['hkip_status']=$_REQUEST['actionurl']." Pending or Error";
				} 
				
				if((isset($_REQUEST['cron_tab']))&&($_REQUEST['cron_tab']=='cron_tab')){
					$data_tdate=date('YmdHis', strtotime($td['tdate']));
					$current_date_1h=date('YmdHis', strtotime("-1 hours"));
					if($data_tdate<$current_date_1h){
						$_SESSION['acquirer_status_code']=-1;
						$_SESSION['acquirer_response']=$_SESSION['acquirer_response']." - Cancelled"; 
					}
				} 
				
			}
			
		//}

//print_r($_GET);exit;

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
	
	
	
		
		
		
		if($_SESSION['acquirer_status_code']==2){ //success
			$callbacks_url = $host_path."/success{$data['ex']}?transID=$transID&action=hkip".$subQuery;
			
			if($data['pq']){
				echo '<br/><br/>1 (2) success callbacks_ur =>'.$callbacks_url;
			}
		}
		elseif($_SESSION['acquirer_status_code']==1){ //pending
			
			//$onclick='javascript:top.popupclose();'; 
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
			$callbacks_url = $host_path."/failed{$data['ex']}?transID=$transID&action=hkip".$subQuery; 
			
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
	
	
	
	
	
//-----------------------------------------------------------


	$email_from="website2 <info@website2.website>";
	$email_to=($data['testEmail_1']?$data['testEmail_1']:"mithilesh@bigit.io");
	$email_to_name="Dev Tech";
	$email_subject="Account Type 34 AdvCash - Mailgun Successfully Email has been received from  {$_SERVER["HTTP_HOST"]}";
	$email_message="<html><h1>Hello, {$_SERVER["HTTP_HOST"]}</h1><p>Mailgun Successfully Email has been received</p></html>";
	
	$email_message.= "<p>callbacks_url:</p><p>".$callbacks_url."</p>";
	
	if(isset($_SERVER)){
		$email_message.="<p><b>_SERVER</b>".json_encode($_SERVER)."</p>";
	}
	if(isset($_POST)){
		$email_message.="<p><b>_POST</b>".json_encode($_POST)."</p>";
	}
	if(isset($_GET)){
		$email_message.="<p><b>_GET</b>".json_encode($_GET)."</p>";
	}
	if(isset($_SESSION)){
		//$email_message.="<p><b>_SESSION</b>".json_encode($_SESSION)."</p>";
	}
	if($browserOs){
		$email_message.="<p><b>browserOs</b>".json_encode($browserOs)."</p>";
	}
	if($td){
		$email_message.="<p><b>transDetails</b>".json_encode($td)."</p>";
	}

	
	
	$sam['HostL']=1;
	
	if(isset($_REQUEST['action'])&&$_REQUEST['action']=='processed_redirect_status'){
		$response_mail=send_attchment_message($email_to,$email_to_name,$email_subject,$email_message,$sam);	
	}
		
	//echo "<hr/>response_mail=".$response_mail;
	//echo "<hr/>json_decode=".json_decode($response_mail,true);
	//print_r($response_mail);


//-----------------------------------------------------------

	
	
	
	if($is_admin==false){
		post_redirect($callbacks_url, $data_send); 
		
		if($data['pq']){
			echo '<br/><br/>4 is_admin false callbacks_ur =>'.$callbacks_url;
		}
		exit;
	}
	
	
	
	// admin status
	
	//json
		if((isset($_REQUEST['json']))&&(!empty($_REQUEST['json']))){
			$json["acquirer_status_code"]=$_SESSION['acquirer_status_code'];
			$json["callbacks_url"]=$callbacks_url;
			
			if($data['pq']){
				echo '<br/><br/>5 json  callbacks_ur =>';
				print_r($json);
			}
			
			header("Content-Type: application/json", true);
			echo json_encode($json);
			exit;
		}
	
		

	  if($is_admin){


			if((isset($_REQUEST['actionurl']))&&($_REQUEST['actionurl']=="hkipme"||$_REQUEST['actionurl']=="customer"||$_REQUEST['actionurl']=="admin_direct")){
				//echo $callbacks_url;
				if($_SESSION['acquirer_status_code']==1){
					
					if($data['pq']){
						echo '<br/><br/>6 pending actionurl '.$_REQUEST['actionurl'].'  callbacks_ur =>';
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
						
						//header("location:$callbacks_url");
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
			
			
		//$results=$results->params;
		
		if(is_array($results)){ 
			foreach($results as $key=>$value){
				if($key!="data" && $value!="Array" && !empty($value)){
					echo "<div class='dta1 key $key'>".$key."</div><div class='dta1 val'>".$value."</div>";
				}
				if(is_array($value)){
					echo "<div class='dta1 h1 key $key'>".$key."</div>";
					foreach($value as $key1=>$value1){
						if($key1!="data" && $value1!="Array" && !empty($value1)){
							echo "<div class='dta1 key $key1'>".$key1."</div><div class='dta1 val'>".$value1."</div>";
						}
					}
				}
			}
		}
		echo "</div>";
		
		

		//echo "<br/><br/>Info: ".$results['info'];
		//echo "<br/><br/>Status: ".$result_hkip['status'];
		echo "<br/><br/>order_status: ".$_SESSION['acquirer_status_code']." [".$_SESSION['acquirer_response']."]";
		echo "<br/><br/>pid: ".$_SESSION['acquirer_transaction_id'];
		echo "<br/><br/>billing_desc: ".$_SESSION['acquirer_descriptor'];
		echo "<br/><br/>respMsg: ".$_SESSION['acquirer_response'];
		echo "<br/><br/>mh_oid: ".$transID;
		echo "<br/><br/>site_id: ".$site_id;



	  }
	
	
	
	
//exit;






//----------------------------------------------------------------

	$email_from="website2 <info@website2.website>";
	$email_to=$data['testEmail_1'];
	$email_to_name="Dev Tech";
	$email_subject="Account Type 34 AdvCash - Mailgun Successfully Email has been received from  {$_SERVER["HTTP_HOST"]}";
	$email_message="<html><h1>Hello, {$_SERVER["HTTP_HOST"]}</h1><p>Mailgun Successfully Email has been received</p></html>";
	
	if(isset($_SERVER)){
		$email_message.="<p><b>_SERVER</b>".json_encode($_SERVER)."</p>";
	}
	if(isset($_POST)){
		$email_message.="<p><b>_POST</b>".json_encode($_POST)."</p>";
	}
	if(isset($_GET)){
		$email_message.="<p><b>_GET</b>".json_encode($_GET)."</p>";
	}
	if(isset($_SESSION)){
		$email_message.="<p><b>_SESSION</b>".json_encode($_SESSION)."</p>";
	}
	if($browserOs){
		$email_message.="<p><b>browserOs</b>".json_encode($browserOs)."</p>";
	}
	if($td){
		$email_message.="<p><b>transDetails</b>".json_encode($td)."</p>";
	}


	
exit;	
	
	$sam['HostL']=1;
	
	echo $response_mail=send_attchment_message($email_to,$email_to_name,$email_subject,$email_message,$sam);	
		
	echo "<hr/>response_mail=".$response_mail;
	echo "<hr/>json_decode=".json_decode($response_mail,true);
	print_r($response_mail);
	
	

//----------------------------------------------------------------
	
	

?>
