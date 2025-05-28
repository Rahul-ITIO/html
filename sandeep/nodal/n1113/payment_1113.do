<?php
//print_r($_REQUEST); 
//exit;

include('../../config.do');
//cmn
$hardcode_test=0;
if($data['localhosts']==true){
	$hardcode_test=1;
}
if( (isset($_SERVER['HTTP_REFERER'])&&(strpos($_SERVER['HTTP_REFERER'],'signins/merchant_settlement')!==false) && (isset($post['curl'])&&$post['curl']=='byCurl'))) {
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

//-----------------------------------------------------
$onclick='javascript:top.popuploadig();popupclose2();';
$actionurl="";
$callbacks_url="";

$is_admin=false; 
$is_mer=false; 
$verify_by_admin = false;
$subQuery="";

if((isset($_SESSION['login_adm'])&&$_SESSION['login_adm']&&isset($_GET['admin'])&&$_GET['admin']) || (isset($_SERVER['HTTP_REFERER'])&&(strpos($_SERVER['HTTP_REFERER'],'signins/merchant_settlement')!==false) && (isset($post['curl'])&&$post['curl']=='byCurl'))) {
	$is_admin=true;
}

if(isset($_SESSION['login_adm'])&&$_SESSION['login_adm']&&isset($_GET['admin_verify'])&&$_GET['admin_verify']) {
	$verify_by_admin=true;
}

if(isset($_SESSION['login'])&&$_SESSION['login']&&isset($_GET['mer'])&&$_GET['mer']) {
	$is_mer=true;
}

//FETCH DATA FROM BANK TABLE
$bank_master = select_tablef('`payout_id` IN (1113) ','bank_payout_table');


$bjson = decode_f($bank_master['encode_processing_creds']);

$encode_processing_creds = json_decode($bjson,true);
//print_r($encode_processing_creds);
if($bank_master['payout_prod_mode']==1) {
	$siteid_set=$encode_processing_creds['live'];
	$bank_url = $bank_master['bank_payment_url'];
}
else {
	$siteid_set	= $encode_processing_creds['test'];
	$bank_url	= $bank_master['payout_uat_url'];
}

$merchantId	= $siteid_set['merchantId'];
$secretKey	= $siteid_set['secretKey'];

$check_status = $data['Host']."/nodal/n1113/status_1113{$data['ex']}?transID=".$transID;


//echo 'dddd';print_r($siteid_set);exit;
$acquirer_ref="";

$cron_tab_array=array();

if($is_admin){

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

	if(!empty($transID)){
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
	if($cp)
	{
		print_r($td);
		exit;
	}
	$td=$td[0];

	$json_value1=jsonencode1($td['json_value'],'',1);
	$json_value1=str_replace(array('[productName],'),'",',$json_value1);
	$json_value1=str_replace(array('[productName]},"'),'"},"',$json_value1);

	$jsv=json_decode($json_value1 ,1);
	$wd_pay_amount_default_currency=abs($jsv['wd_pay_amount_default_currency']);

	$id		= $td['id'];
//	$amount	= abs($td['transaction_amt']);
	$amount	= $wd_pay_amount_default_currency;
	$amount_get	= $wd_pay_amount_default_currency;

	$acquirer		= $td['acquirer'];
	$merID	= $td['merID'];
	$acquirer_ref		= $td['acquirer_ref'];
	$status		= $td['trans_status'];
	$bill_email	= $td['bill_email'];
	$bill_phone	= $td['bill_phone'];
	$bill_zip		= $td['bill_zip'];
	$bill_city		= $td['bill_city'];
	$bill_state		= $td['bill_state'];

	$txn=$td['acquirer_response'];

	$acquirer_response	= jsondecode($txn,true);	//CONVERT $txt_value into an array
	$beneId		= $acquirer_response['id'];
	$bname		= $acquirer_response['bname'];
	$baddress	= $acquirer_response['baddress'];
	$bcountry	= $acquirer_response['bcountry'];
	$bnameacc	= $acquirer_response['bnameacc'];
	$baccount	= decrypts_string(json_encode($acquirer_response['baccount']),0);
	$btype		= $acquirer_response['btype'];
	$brtgifsc	= $acquirer_response['brtgnum'];
	$bswift		= $acquirer_response['bswift'];
	$required_currency	= $acquirer_response['required_currency'];
	$full_address		= $acquirer_response['full_address'];

	$verify_status		= $acquirer_response['verify_status'];


	$Datetime	= date('Y-m-d h:i:sA');//Date & Time Format "2012-05-09 04:09:41AM";

	$sendRequest = array();
	$sendRequest['TransactionID']		=$transID;
	$sendRequest['Amount']				=$amount;
	$sendRequest['ClientIP']			=$_SERVER['REMOTE_ADDR'];
	$sendRequest['ReturnURI']			=$check_status;
	$sendRequest['MerchantCode']		=$merchantId;
	$sendRequest['secretKey']			=$secretKey;
	$sendRequest['CurrencyCode']		=$required_currency;
	$sendRequest['MemberCode']			=$beneId;
	$sendRequest['BankCode']			=$bswift;
	$sendRequest['toBankAccountName']	=$bnameacc;
	$sendRequest['toBankAccountNumber']	=$baccount;
	$sendRequest['TransactionDateTime']	=$Datetime;

	$dt	= date('YmdHis', strtotime($Datetime));

	##############
	if($amount>$amount_get){
		echo "<br /><br /><h1>Amount: {$amount} can not proccess more than {$amount_get}</h1>";
		exit;
	}

	//cmn
	if($cp){
		echo "<br/><br/>_POST=>";print_r($_POST);
		exit;
	}

	$jsn=$td['json_value'];
	$json_value=jsondecode($jsn,true);
	
//	print_r($sendRequest);exit;
}
elseif(($is_mer) || ($verify_by_admin)){
	$acquirer_ref='';

	$tid		= $_REQUEST['tid'];
	$actionurl	= $_SESSION['return_url'];

	if($verify_by_admin && empty($uid)) $uid = $_GET['uid'];

	$bankData	= select_banks($uid,$tid);			// fetch data from bank table
	$baccount	= $bankData[0]['baccount'];
	$bnameacc	= $bankData[0]['bnameacc'];
	$bphone		= $bankData[0]['bphone'];
	$ifsc		= strtoupper($bankData[0]['bswift']);
	$baddress	= $bankData[0]['baddress'];

	$random_number = mt_rand(1,99);
	$amount = "1.".(($random_number<10)?"0".$random_number:$random_number);
	$amount = number_format($amount,2);

	#############

	$transID = gen_transID_f(0,$uid);//time();

	$sendRequest = array();
	$sendRequest['TransactionID']		=$transID;
	$sendRequest['Amount']				=$amount;
	$sendRequest['ClientIP']			=$_SERVER['REMOTE_ADDR'];
	$sendRequest['ReturnURI']			=$check_status;
	$sendRequest['MerchantCode']		=$merchantId;
	$sendRequest['secretKey']			=$secretKey;
	$sendRequest['CurrencyCode']		=$required_currency;
	$sendRequest['MemberCode']			=$tid;
	$sendRequest['BankCode']			=$ifsc;
	$sendRequest['toBankAccountName']	=$bnameacc;
	$sendRequest['toBankAccountNumber']	=$baccount;
	$sendRequest['TransactionDateTime']	=$Datetime;

	$dt	= date('YmdHis', strtotime($Datetime));

//	print_r($sendRequest);
}

$auth_res		= array();
$transfer_res	= array();
$resFinalStatus = array();

if(empty($acquirer_ref)){

	if($status==13 || ($is_mer) || ($verify_by_admin))
	{
		$dt		= date('YmdHis', strtotime($Datetime));
		
		$hashkey= md5($sendRequest['MerchantCode'].$sendRequest['TransactionID'].$sendRequest['MemberCode'].$sendRequest['Amount'].$sendRequest['CurrencyCode'].$dt.$sendRequest['toBankAccountNumber'].$secretKey);
		
		$sendRequest['Key']=$hashkey;

		$request = http_build_query($sendRequest);
		
		$post_url = $bank_url."/".$sendRequest['MerchantCode'];
		
		
		$curl = curl_init();
		curl_setopt_array($curl, [
		CURLOPT_URL => $post_url,
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => "",
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 30,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => 'POST',
		CURLOPT_POSTFIELDS => $request,
		CURLOPT_HTTPHEADER => [
			"Content-Type: application/x-www-form-urlencoded"
		],
		]);
		
		
		$response = curl_exec($curl);
		
		//echo "Response => <br />".$response;
		
		$xml	= simplexml_load_string($response);
		$json	= json_encode($xml);
		$response_arr	= json_decode($json,TRUE);
		
		if(isset($qp)&&$qp)
		{
			echo "URL=> ".$post_url;
			echo "<br />Send Request=><br />";
			print_r($sendRequest);
			echo "<br />Response=><br />";
			print_r($response_arr);
			exit;
		}

		if(isset($response_arr['statusCode'])&&$response_arr['statusCode']=='000')
		{
			$_GET['promptmsg']		= 'Withdraw Approved: ';
			$_GET['confirm_amount']	= $amount;
			$_GET['bid']			= (isset($uid)&&$uid)?$uid:$merID;
			$_GET['acquirer']			= $acquirer;

			update_trans_ranges(-1, 1, $td['id']);	// /FOR SUCCESS or accept

			$REQID		= $response_arr['REQID'];
			$UNIQUEID	= $response_arr['UNIQUEID'];
			$UTRNUMBER	= $response_arr['UTRNUMBER'];
			$acquirer_ref 	= $UTRNUMBER;

			$acquirer_response['response_arr']	= $response_arr;
			

			$response_array_post=json_encode($acquirer_response, JSON_UNESCAPED_SLASHES);

			$acquirer_response['sendRequest'] = $sendRequest;

			$new_acquirer_response = json_encode($acquirer_response, JSON_UNESCAPED_SLASHES);

			$rmk_date=date('d-m-Y h:i:s A');
			$system_note_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$response_array_post." </div></div>".$td['system_note'];
		}
		elseif(isset($response_arr['statusCode'])&&$response_arr['statusCode']=='001')
		{
			$_GET['promptmsg']		= 'Withdraw Pending: ';
			$_GET['confirm_amount']	= $amount;
			$_GET['bid']			= (isset($uid)&&$uid)?$uid:$merID;
			$_GET['acquirer']			= $acquirer;

			update_trans_ranges(-1, 0, $td['id']);	//FOR SUCCESS or accept
		}
		else
		{
			$_GET['promptmsg']		= 'Cancelled: ';
			$_GET['confirm_amount']	= $amount;
			$_GET['bid']			= (isset($uid)&&$uid)?$uid:$merID;
			$_GET['acquirer']			= $acquirer;

			$acquirer_response['response'] = isset($response_arr)&&$response_arr?$response_arr:$raw_response;
			//update_trans_ranges(-1, 2, $td['id']);	//FOR FAIL or REJECT or CANCEL
		}

		$acquirer_response['bank_status']	= $check_status;

		if(!empty($acquirer_ref))
		{
			if($is_mer || ($verify_by_admin)){
				$da_se=array();
				$da_se['send']=$uid;
				$da_se['bid']=$uid;
				$da_se['curl']="byCurl";
				$da_se['admin']="1";
				$da_se['amount']=3;
				$da_se['bank']=$tid;
				$da_se['requested_currency']='INR';
				$da_se['ThisTitle']='NODAL_POST';
				$da_se['txt_id']=$acquirer_ref;
				$w_url=$data['USER_FOLDER']."/withdraw-frozen-fund{$data['ex']}?curl=1&admin=1&bid=".$uid;
				$wp_get=use_curl($w_url,$da_se);

				if($cp){echo "<br />Withdraw post==><br />";print_r($wp_get);}

				if($verify_by_admin)
				{
					$actionurl = urldecode($actionurl);
				}

				db_query(

					"UPDATE `{$data['DbPrefix']}banks` SET ".
					"`verify_amount`='{$amount}',verify_status='2',verify_date='".$data['TODAY_DATE_ONLY']."'".
					" WHERE `id`='{$tid}' ",0
				);
				$_SESSION['sent_success']=$tid;
				$_SESSION['sent_tname']='banks';

				$_SESSION['action_success']="Verification amount successfully sent to account: <b>".encode($baccount,6)."</b>, please verify.";

				header("Location:{$actionurl}");exit;
			}
			else{
				db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` SET `acquirer_ref`='{$acquirer_ref}',`acquirer_response`='{$new_acquirer_response}',`system_note`='".$system_note_upd."' WHERE `id`='".$td['id']."'");
			}
		}
	}
}

if(isset($_REQUEST['cron_tab'])&&$_REQUEST['cron_tab']){
	//print_r($cron_tab_array);
	header("Content-Type: application/json", true);
	$cron_tab_json = json_encode($cron_tab_array);
	echo $cron_tab_json;
	exit;
}

if(isset($acquirer_response)&&is_array($acquirer_response))
{
	echo "<br /><br /><div class='hk_sts'>";
	foreach($acquirer_response as $key=>$value){
		if($key!="data" && $value!="Array" && !empty($value) && !is_array($value)){
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
	echo '</div>';
}
exit;
//----------------------------------------------------------------
?>