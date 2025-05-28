<?php
//print_r($_REQUEST); 
//exit;

include('../../config.do');
//cmn
$hardcode_test=0;
if($data['localhosts']==true){
	$hardcode_test=1;
}
if( (isset($_SERVER['HTTP_REFERER'])&&(strpos($_SERVER['HTTP_REFERER'],'mlogin/payout_request')!==false) && (isset($post['curl'])&&$post['curl']=='byCurl'))) {
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

$actionurl_get=$orderset=$transaction_id=$where_pred=$message="";

//-----------------------------------------------------
$onclick='javascript:top.popuploadig();popupclose2();';
$actionurl="";
$callbacks_url="";

$is_admin=false; 
$is_mer=false; 
$verify_by_admin = false;
$subQuery="";

if((isset($_SESSION['login_adm'])&&$_SESSION['login_adm']&&isset($_GET['admin'])&&$_GET['admin']) || (isset($_SERVER['HTTP_REFERER'])&&(strpos($_SERVER['HTTP_REFERER'],'mlogin/payout_request')!==false) && (isset($post['curl'])&&$post['curl']=='byCurl'))) {
	$is_admin=true;
}

if(isset($_SESSION['login_adm'])&&$_SESSION['login_adm']&&isset($_GET['admin_verify'])&&$_GET['admin_verify']) {
	$verify_by_admin=true;
}

if(isset($_SESSION['login'])&&$_SESSION['login']&&isset($_GET['mer'])&&$_GET['mer']) {
	$is_mer=true;
}

//FETCH DATA FROM BANK TABLE
$bank_master = select_tablef('`account_no` IN (1114) ','bank_table');


$bjson = decode_f($bank_master['bank_json']);

$bank_json = json_decode($bjson,true);

if($bank_master['account_mode']==1) {
	$siteid_set=$bank_json['live'];
	$bank_url = $bank_master['bank_payment_url'];
	$file_start = "live_";
}
else {
	$siteid_set=$bank_json['test'];
	$bank_url = $bank_master['bank_payment_test_url'];
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
$senderName	= $siteid_set['senderName'];
$passCode	= $siteid_set['passCode'];
$bcID		= $siteid_set['bcID'];
$mobile		= $siteid_set['mobile'];

$txn_id="";

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

	if(isset($_REQUEST['transaction_id'])&&!empty($_REQUEST['transaction_id'])){
		$transaction_id=$_REQUEST['transaction_id'];
	}
	if(isset($_REQUEST['actionurl'])&&!empty($_REQUEST['actionurl'])){
		$actionurl_get=$_REQUEST['actionurl'];
	}

	if((isset($_REQUEST['orderset'])&&!empty($_REQUEST['orderset']))){
		if(!empty($_REQUEST['orderset'])){
			$orderset=$_REQUEST['orderset'];
		}
	}

	if(!empty($orderset)){
		$transaction_id=ordersetf($orderset,0); // transaction_id
		$tr_id=ordersetf($orderset,1); // table id

		$where_pred.=" (`transaction_id`='{$transaction_id}') AND ";
		if(!empty($tr_id)){
			$where_pred.=" (`id`='{$tr_id}') AND";
		}
	}

	// transactions get ----------------------------

	$where_pred=substr_replace($where_pred,'', strrpos($where_pred, 'AND'), 3);

	$td=db_rows(
		"SELECT * ". 
		" FROM `{$data['DbPrefix']}transactions`".
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

	$type		= $td['type'];
	$receiver	= $td['receiver'];
	$txn_id		= $td['txn_id'];
	$status		= $td['status'];
	$email_add	= $td['email_add'];
	$phone_no	= $td['phone_no'];
	$zip		= $td['zip'];
	$city		= $td['city'];
	$state		= $td['state'];


	$txn=$td['txn_value'];

	$txn_value	= jsondecode($txn,true);	//CONVERT $txt_value into an array
	$beneId		= $txn_value['id'];
	$bname		= $txn_value['bname'];
	$baddress	= $txn_value['baddress'];
	$bcountry	= $txn_value['bcountry'];
	$bnameacc	= $txn_value['bnameacc'];
	$baccount	= decrypts_string(json_encode($txn_value['baccount']),0);
	$btype		= $txn_value['btype'];
	$brtgifsc	= $txn_value['bswift'];//$txn_value['brtgnum'];
	$bswift		= $txn_value['bswift'];
	$required_currency	= $txn_value['required_currency'];
	$full_address		= $txn_value['full_address'];

	$verify_status		= $txn_value['verify_status'];

	if(strpos($brtgifsc,'ICIC') !== false) $txnType = 'TPA';
	else $txnType = 'RGS';

	$sendRequest = array();
	if(isset($_REQUEST['method'])&&strtolower($_REQUEST['method'])=='neft')	// create payload if method is NEFT
	{
		$sendRequest['tranRefNo']		=$transaction_id;
		$sendRequest['amount']			="$amount";
		$sendRequest['senderAcctNo']	=$senderAcctNo;
		$sendRequest['beneAccNo']		=$baccount;
		$sendRequest['beneName']		=$bnameacc;
		$sendRequest['beneIFSC']		=$brtgifsc;
		$sendRequest['narration1']		="Test";	//"Test";	//to be discuss
		$sendRequest['crpId']			=$crpId;
		$sendRequest['crpUsr']			=$crpUsr;
		$sendRequest['aggrId']			=$aggrId;
		$sendRequest['urn']				=$urn;
		$sendRequest['aggrName']		=$aggrName;
		$sendRequest['txnType']			=$txnType;
		$sendRequest['WORKFLOW_REQD']	="Y";
		
		$x_priority = '0010';
	}
	elseif(isset($_REQUEST['method'])&&strtolower($_REQUEST['method'])=='rtgs')	// create payload if method is RTGS
	{
		$sendRequest['UNIQUEID']		=$transaction_id;
		$sendRequest['AMOUNT']			=$amount;
		$sendRequest['DEBITACC']		=$senderAcctNo;
		$sendRequest['CREDITACC']		=$baccount;
		$sendRequest['CURRENCY']		=$required_currency;
		$sendRequest['PAYEENAME']		=$bnameacc;
		$sendRequest['IFSC']			=$brtgifsc;
		$sendRequest['REMARKS']			="";	//"Test";	//to be discuss
		$sendRequest['CORPID']			=$crpId;
		$sendRequest['USERID']			=$crpUsr;
		$sendRequest['AGGRID']			=$aggrId;
		$sendRequest['URN']				=$urn;
		$sendRequest['AGGRNAME']		=$aggrName;
		$sendRequest['TXNTYPE']			=$txnType;
		$sendRequest['WORKFLOW_REQD']	="Y";
		
		$x_priority = '0001';
	}
	elseif(isset($_REQUEST['method'])&&strtolower($_REQUEST['method'])=='imps')	// create payload if method is IMPS
	{
		
		$sendRequest = array();
		$sendRequest['tranRefNo']		=$transaction_id;
		$sendRequest['paymentRef']		="Pay for $transaction_id";
		$sendRequest['amount']			=$amount;
		$sendRequest['senderName']		=$senderName;
		$sendRequest['beneAccNo']		=$baccount;
		$sendRequest['beneIFSC']		=$brtgifsc;
		$sendRequest['bcID']			=$bcID;
		$sendRequest['passCode']		=$passCode;
		$sendRequest['crpId']			=$crpId;
		$sendRequest['crpUsr']			=$crpUsr;
		$sendRequest['aggrId']			=$aggrId;
		$sendRequest['urn']				=$urn;
		$sendRequest['localTxnDtTime']	=date('YmdHis');
		$sendRequest['mobile']			=$mobile;
		$sendRequest['retailerCode']	="rcode";
		
		$x_priority = '0100';
	}
	elseif(isset($_REQUEST['method'])&&strtolower($_REQUEST['method'])=='upi')	// create payload if method is UPI
	{
		$x_priority = '1000';
	}

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
	$txn_id='';

	$tid		= $_REQUEST['tid'];
	$actionurl	= $_SESSION['return_url'];

	if($verify_by_admin && empty($uid)) $uid = $_GET['uid'];

	$bankData	= select_banks($uid,$tid);			// fetch data from bank table
	$baccount	= $bankData[0]['baccount'];
	$bnameacc	= $bankData[0]['bnameacc'];
	$bphone		= $bankData[0]['bphone'];
	$ifsc		= strtoupper($bankData[0]['bswift']);
	$baddress	= $bankData[0]['baddress'];
	$bank_bene_id= $bankData[0]['bank_bene_id'];

	$random_number = mt_rand(1,99);
	$amount = "1.".(($random_number<10)?"0".$random_number:$random_number);
	$amount = number_format($amount,2);

	#############

	if(empty($bank_bene_id))
	{
		if(strpos($ifsc,'ICIC') !== false) $PayeeType = 'W';
		else $PayeeType = 'O';

		$postData['CrpId']		=$crpId;
		$postData['CrpUsr']		=$crpUsr;
		$postData['AGGR_ID']	=$aggrId;

		$postData['BnfName']	=$bnameacc;
		$postData['BnfNickName']=substr($bnameacc,0,4).substr($tid,-3);
		$postData['BnfAccNo']	=$baccount;
		$postData['PayeeType']	=$PayeeType;
		$postData['IFSC']		=$ifsc;
		$postData['URN']		=$urn;

		#############
		$bene_url = $bank_url."/Corporate/CIB/v1/BeneAddition";

		$fp = fopen($file_start.'SKYWALK_CIB_CERT.cer', 'r');
		$pub_key= fread($fp, 8192);
		fclose($fp);

		$RANDOMNO1 = "1212121234483448";
		$RANDOMNO2 = '1234567890123456';

		openssl_get_publickey($pub_key);

		openssl_public_encrypt($RANDOMNO1, $encrypted_key, $pub_key);
		$encrypted_data = openssl_encrypt(json_encode($postData), 'AES-128-CBC', $RANDOMNO1, OPENSSL_RAW_DATA, $RANDOMNO2);

		$postbody= [
			"service" => "",
			"encryptedKey" => base64_encode($encrypted_key),
			"oaepHashingAlgorithm" => "NONE",
			"iv" => base64_encode($RANDOMNO2),
			"encryptedData" => base64_encode($encrypted_data),
			"clientInfo" => "",
			"optionalParam" => ""
		];

		//echo json_encode($postbody);
		//die;

		$headers = array(
			"content-type: application/json", 
			"apikey:$cib",
			"x-priority: 0010" //1000 for upi, 0100 for imps, 0010 for neft, 0001 for rtgs
		);

		$curl = curl_init($bene_url);
		curl_setopt($curl, CURLOPT_URL, $bene_url);
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
		openssl_private_decrypt(base64_decode($request->encryptedKey), $key, $res);
		$encData = base64_decode($request->encryptedData); 
		$encData = openssl_decrypt($encData,"aes-128-cbc",$key,OPENSSL_PKCS1_PADDING);

		$newsource = substr($encData, 16);
		$response_arr = json_decode($newsource,1);

		if(isset($response_arr['Response'])&&$response_arr['Response']=='SUCCESS')
		{
			$BNF_ID = $response_arr['BNF_ID'];
			$sqlStmt = "UPDATE `{$data['DbPrefix']}banks` SET `bank_bene_id`='{$BNF_ID}' WHERE `id`='{$tid}' ";
			db_query($sqlStmt);
		}
	}

	// request for fund transfer or neft 

	if(strpos($ifsc,'ICIC') !== false) $txnType = 'TPA';
	else $txnType = 'RGS';

	$transaction_id = gen_transID_f(0,$uid);//time();

	$sendRequest = array();
	$sendRequest['tranRefNo']		=$transaction_id;
	$sendRequest['amount']			=$amount;
	$sendRequest['senderAcctNo']	=$senderAcctNo;
	$sendRequest['beneAccNo']		=$baccount;
	$sendRequest['beneName']		=$bnameacc;
	$sendRequest['beneIFSC']		=$ifsc;
	$sendRequest['narration1']		="Test";		//to be discuss
	$sendRequest['crpId']			=$crpId;
	$sendRequest['crpUsr']			=$crpUsr;
	$sendRequest['aggrId']			=$aggrId;
	$sendRequest['urn']				=$urn;
	$sendRequest['aggrName']		=$aggrName;
	$sendRequest['txnType']			=$txnType;
	$sendRequest['WORKFLOW_REQD']	="N";

//	print_r($sendRequest);
}

$auth_res		= array();
$transfer_res	= array();
$resFinalStatus = array();

if(isset($_GET['sq'])&&$_GET['sq'])
{
	echo "txn_id=".$txn_id;
}

$txn_id="";
if(empty($txn_id)){
	if($status==13 || ($is_mer) || ($verify_by_admin))
	{
		$pay_url = $bank_url."/v1/composite-payment";

		$fp = fopen($file_start.'rsaapikey.cer', 'r');
		$pub_key= fread($fp, 8192);
		fclose($fp);

		$RANDOMNO1 = "1212121234483448";
		$RANDOMNO2 = "1234567890123456";

		//print_r($sendRequest);

		openssl_get_publickey($pub_key);

		openssl_public_encrypt($RANDOMNO1, $encrypted_key, $pub_key);
		$encrypted_data = openssl_encrypt(json_encode($sendRequest), 'AES-128-CBC', $RANDOMNO1, OPENSSL_RAW_DATA, $RANDOMNO2);

		if(isset($_GET['sq'])&&$_GET['sq'])
		{
			echo "<br />RANDOMNO1=".$RANDOMNO1;
			echo "<br />RANDOMNO2=".$RANDOMNO2;
			
			$iv = base64_encode($RANDOMNO2);
		}

		$postbody= [
			"requestId" => $transaction_id,
			"service" => "",
			"encryptedKey" => base64_encode($encrypted_key),
			"oaepHashingAlgorithm" => "NONE",
			"iv" => $iv,
			"encryptedData" => base64_encode($encrypted_data),
			"clientInfo" => "",
			"optionalParam" => ""
		];

		if(empty($x_priority))
		{
			if($sendRequest['amount']<200000) $x_priority="0010";	// FOR NEFT
			else $x_priority="0001";	//for RTGS
		}
		$headers = array(
			"content-type: application/json", 
			"apikey:$apiKey",
			"x-priority: $x_priority"	//1000 for upi, 0100 for imps, 0010 for neft, 0001 for rtgs
		);

		$log = "\n\nGUID - ".$transaction_id."==============================\n";
		$log .= 'FileName - '.$file_start."rsaapikey.cer\n\n";
		$log .= 'URL - '.$pay_url."\n\n";
		$log .= 'HEADER - '.json_encode($headers)."\n\n";
		$log .= 'REQUEST - '.json_encode($sendRequest)."\n\n";
		$log .= 'REQUEST ENCRYPTED - '.json_encode($postbody)."\n\n";

		$curl = curl_init($pay_url);
		curl_setopt($curl, CURLOPT_URL, $pay_url);
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
		openssl_private_decrypt(base64_decode($request->encryptedKey), $key, $res);
		$encData = base64_decode($request->encryptedData); 
		$encData = openssl_decrypt($encData,"aes-128-cbc",$key,OPENSSL_PKCS1_PADDING);

		$newsource = substr($encData, 16); 

		$log.= "\n\nGUID - ".$transaction_id."=========================================\n";
		$log.= "RESPONSE - ".$raw_response."\n\n";
		$log.= "RESPONSE DECRYPTED - ".$newsource."\n\n";

		if(isset($_GET['sq'])&&$_GET['sq'])
		{
			echo "<br /><br />LOG=".nl2br($log);
		//	exit;
		}
		$response_arr = json_decode($newsource,1);

		$txn_value = $response_arr;
		
		if(isset($_GET['sq'])&&$_GET['sq'])
		{
			echo "<br /><br />response_arr=";print_r($response_arr);
		//	exit;
		}
		
		if(isset($response_arr['STATUS'])&&$response_arr['STATUS']=='SUCCESS')
		{
			$_GET['promptmsg']		= 'Withdraw Approved: ';
			$_GET['confirm_amount']	= $amount;
			$_GET['bid']			= (isset($uid)&&$uid)?$uid:$receiver;
			$_GET['type']			= $type;

			update_transaction_ranges(-1, 1, $td['id']);	// /FOR SUCCESS or accept

			$REQID		= $response_arr['REQID'];
			$UNIQUEID	= $response_arr['UNIQUEID'];
			$UTRNUMBER	= $response_arr['UTRNUMBER'];
			$txn_id 	= $UTRNUMBER;

			$txn_value['response_arr']	= $response_arr;

			$response_array_post=json_encode($txn_value, JSON_UNESCAPED_SLASHES);

			$txn_value['sendRequest'] = $sendRequest;

			$new_txn_value = json_encode($txn_value, JSON_UNESCAPED_SLASHES);

			$rmk_date=date('d-m-Y h:i:s A');
			$system_note_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$response_array_post." </div></div>".$td['system_note'];
		}
		elseif(isset($response_arr['STATUS'])&&$response_arr['status']=='PENDING')
		{
			$_GET['promptmsg']		= 'Withdraw Pending: ';
			$_GET['confirm_amount']	= $amount;
			$_GET['bid']			= (isset($uid)&&$uid)?$uid:$receiver;
			$_GET['type']			= $type;

			update_transaction_ranges(-1, 0, $td['id']);	//FOR SUCCESS or accept
		}
		else
		{
			$_GET['promptmsg']		= 'Cancelled: ';
			$_GET['confirm_amount']	= $amount;
			$_GET['bid']			= (isset($uid)&&$uid)?$uid:$receiver;
			$_GET['type']			= $type;

			$txn_value['response'] = isset($response_arr)&&$response_arr?$response_arr:$newsource;
			//update_transaction_ranges(-1, 2, $td['id']);	//FOR FAIL or REJECT or CANCEL
		}

		if(isset($_GET['sq'])&&$_GET['sq'])
		{
			echo "<br /><br />txn_value=";print_r($txn_value);
			//exit;
		}
		$check_status = "nodal/n1114/status_1114{$data['ex']}?orderset=".$transaction_id;
		$txn_value['bank_status']	= $check_status;

		if(!empty($txn_id))
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
				$da_se['txt_id']=$txn_id;
				$w_url=$data['Members']."/withdraw-frozen-fund{$data['ex']}?curl=1&admin=1&bid=".$uid;
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
				db_query("UPDATE `{$data['DbPrefix']}transactions` SET `txn_id`='{$txn_id}',`txn_value`='{$new_txn_value}',`system_note`='".$system_note_upd."' WHERE `id`='".$td['id']."'");
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
/*
if(isset($txn_value)&&is_array($txn_value))
{
	echo "<br /><br /><div class='hk_sts'>";
	foreach($txn_value as $key=>$value){
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
*/
exit;
//----------------------------------------------------------------
?>