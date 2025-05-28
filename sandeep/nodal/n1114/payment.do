<?php 
include('../../config.do');
//cmn
$hardcode_test=0;
if($data['localhosts']==true){
	$hardcode_test=1;
}
if( (isset($_SERVER['HTTP_REFERER'])&&(strpos($_SERVER['HTTP_REFERER'],'signins/merchant_settlement')!==false) && (isset($post['curl'])&&$post['curl']=='byCurl') ) ) {
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
$bank_master = select_tablef('`payout_id` IN ('.$_SESSION['payout_id'].') ','bank_payout_table');
 

$bjson = decode_f($bank_master['encode_processing_creds']);

$encode_processing_creds = json_decode($bjson,true);

if($bank_master['payout_prod_mode']==1) {
	$siteid_set=$encode_processing_creds['live'];
	$bank_url = $bank_master['bank_payment_url'];
}
else {
	$siteid_set=$encode_processing_creds['test'];
	$bank_url = $bank_master['payout_uat_url'];
}

$cib		= $siteid_set['cib'];
$apiKey		= $siteid_set['apiKey'];
$crpId		= $siteid_set['crpId'];
$crpUsr		= $siteid_set['crpUsr'];
$aggrId		= $siteid_set['aggrId'];
$aggrName	= $siteid_set['aggrName'];
$urn		= $siteid_set['urn'];
$senderAcctNo= $siteid_set['senderAcctNo'];
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
		$transactionId=transIDf($transID,0); // transID
		//$tr_id=transIDf($transID,1); // table id

		$where_pred.=" (`transID`='{$transactionId}') AND ";
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

	$acquirer_response	= jsondecode($txn,true);		//CONVERT $txt_value into an array
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

	if(strpos($brtgifsc,'ICIC') !== false) $txnType = 'TPA';
	else $txnType = 'RGS';

	$sendRequest = array();
	$sendRequest['tranRefNo']		=$transactionId;
	$sendRequest['amount']			=$amount;
	$sendRequest['senderAcctNo']	=$senderAcctNo;
	$sendRequest['beneAccNo']		=$baccount;
	$sendRequest['beneName']		=$bnameacc;
	$sendRequest['beneIFSC']		=$brtgifsc;
	$sendRequest['narration1']		="Test";		//to be discuss
	$sendRequest['crpId']			=$crpId;
	$sendRequest['crpUsr']			=$crpUsr;
	$sendRequest['aggrId']			=$aggrId;
	$sendRequest['urn']				=$urn;
	$sendRequest['aggrName']		=$aggrName;
	$sendRequest['txnType']			=$txnType;
	$sendRequest['WORKFLOW_REQD']	="N";

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
}
elseif(($is_mer) || ($verify_by_admin)){
	$acquirer_ref='';

	$tid		= $_REQUEST['tid'];
	$actionurl	= $_REQUEST['actionurl'];

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

		$fp = fopen('SKYWALK_CIB_CERT.cer', 'r');
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
		
		json_encode($postbody);
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
		$fp= fopen("privatekey.key","r");
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
	
	$reference=time();

	$sendRequest = array();
	$sendRequest['tranRefNo']		=$reference;
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
}

$auth_res		= array();
$transfer_res	= array();
$resFinalStatus = array();

if(empty($acquirer_ref)){

	if($status==13 || ($is_mer) || ($verify_by_admin))
	{
		$pay_url = $bank_url."/v1/composite-payment";

		$fp = fopen('rsaapikey.cer', 'r');
		$pub_key= fread($fp, 8192);
		fclose($fp);
		
		$RANDOMNO1 = "1212121234483448";
		$RANDOMNO2 = '1234567890123456';
		
		openssl_get_publickey($pub_key);
		
		openssl_public_encrypt($RANDOMNO1, $encrypted_key, $pub_key);
		$encrypted_data = openssl_encrypt(json_encode($postData), 'AES-128-CBC', $RANDOMNO1, OPENSSL_RAW_DATA, $RANDOMNO2);
		
		$postbody= [
			"requestId" => $reference,
			"service" => "",
			"encryptedKey" => base64_encode($encrypted_key),
			"oaepHashingAlgorithm" => "NONE",
			"iv" => base64_encode($RANDOMNO2),
			"encryptedData" => base64_encode($encrypted_data),
			"clientInfo" => "",
			"optionalParam" => ""
		];
		
		if($sendRequest['amount']<200000) $x_priority="0010";	// FOR NEFT
		else $x_priority="0001";	//for RTGS

		$headers = array(
			"content-type: application/json", 
			"apikey:$apiKey",
			"x-priority: $x_priority"  //1000 for upi, 0100 for imps, 0010 for neft, 0001 for rtgs
		);
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
		$fp= fopen("privatekey.key","r");
		$priv_key=fread($fp,8192);
		fclose($fp);
		$res = openssl_get_privatekey($priv_key, "");
		openssl_private_decrypt(base64_decode($request->encryptedKey), $key, $res);
		$encData = base64_decode($request->encryptedData); 
		$encData = openssl_decrypt($encData,"aes-128-cbc",$key,OPENSSL_PKCS1_PADDING);
		
		$newsource = substr($encData, 16); 

		$response_arr = json_decode($newsource,1);
		
		if(isset($response_arr['STATUS'])&&$response_arr['STATUS']=='SUCCESS')
		{
			$REQID		= $response_arr['REQID'];
			$UNIQUEID	= $response_arr['UNIQUEID'];
			$UTRNUMBER	= $response_arr['UTRNUMBER'];
			$acquirer_ref = $UTRNUMBER;


			$acquirer_response['response_arr'] = $response_arr;
	
			$response_array_post=json_encode($acquirer_response, JSON_UNESCAPED_SLASHES);
	
			$acquirer_response['sendRequest'] = $sendRequest;
	
			$new_acquirer_response = json_encode($acquirer_response, JSON_UNESCAPED_SLASHES);
	
			$rmk_date=date('d-m-Y h:i:s A');
			$system_note_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$response_array_post." </div></div>".$td['system_note'];
		}

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
				db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`"." SET `acquirer_ref`='{$acquirer_ref}',`acquirer_response`='{$new_acquirer_response}',`system_note`='".$system_note_upd."' WHERE `id`='".$td['id']."'");
			}
		}







	###################
		$cf_data = $transfer;
	
		$finalUrl	= $baseurl.$urls['requestTransfer'];
		$headers	= create_header($auth_res['token']);
	
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_POST, 1);
		curl_setopt($ch, CURLOPT_URL, $finalUrl);
		curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		if(!is_null($cf_data)) curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($cf_data)); 
	
		$r = curl_exec($ch);
	
		if(curl_errno($ch)){
			print('error in posting');
			print(curl_error($ch));
			die();
		}
		curl_close($ch);
		$rObj1 = json_decode($r, true);
	
		$cron_tab_array['requestTransfer']=$rObj1;
	
		//cmn
		if($cp){
			echo "<br />Object 1 Line no. 341==><br />";
			print_r($rObj1);
		}
		$subCode = $rObj1['subCode'];
	
		$transfer_res['status']			= $rObj1['status'];
		$transfer_res['message']		= $rObj1['message'];
		$transfer_res['referenceId']	= $rObj1['data']['referenceId'];
		$transfer_res['utr']			= $rObj1['data']['utr'];
		$transfer_res['acknowledged']	= $rObj1['data']['acknowledged'];
	
		if($transfer_res['status']=='PENDING')
		{
			$_GET['promptmsg']		= 'Withdraw Pending: ';
			$_GET['confirm_amount']	= $amount;
			$_GET['bid']			= $merID;
			$_GET['acquirer']			= $acquirer;
	
			if((!$is_mer) && (!$verify_by_admin)){
				update_trans_ranges(-1, 0, $td['id']);	// /FOR SUCCESS or accept
			}
		}
	}

	if(!empty($txt_id))
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
			$da_se['txt_id']=$txt_id;
			$w_url=$data['USER_FOLDER']."/withdraw-frozen-fund{$data['ex']}?curl=1&admin=1&bid=".$uid;
			$wp_get=use_curl($w_url,$da_se);

			if($cp){echo "<br />Withdraw post== LINE no. 455=><br />";print_r($wp_get);}

			if($verify_by_admin)
			{
				$actionurl = urldecode($actionurl);
			}

			db_query(
				"UPDATE `{$data['DbPrefix']}banks` SET ".
				"`verify_amount`='{$amount}', verify_status='2', verify_date='".$data['TODAY_DATE_ONLY']."'".
				" WHERE `id`='{$tid}' ",0
			);
			$_SESSION['sent_success']=$tid;
			$_SESSION['sent_tname']='banks';

			$_SESSION['action_success']="Verification Amount successfully sent to account: <b>".encode($baccount,6)."</b>, please verify.";

			header("Location:{$actionurl}");exit;
		}
		else{
			db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`"." SET `acquirer_ref`='{$txt_id}',`acquirer_response`='{$new_acquirer_response}',`system_note`='".$system_note_upd."' WHERE `id`='".$td['id']."'");
		}
	}













	//IF txn_id IS NULL, THEN POST REQUEST FOR WITHDRAWAL

	//	FOR GET TOKEN -- START
	$cf_data = NULL;

	$finalUrl = $baseurl.$urls['auth'];
	$headers = create_header("");

	$ch = curl_init();
	curl_setopt($ch, CURLOPT_POST, 1);
	curl_setopt($ch, CURLOPT_URL, $finalUrl);
	curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	if(!is_null($cf_data)) curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($cf_data)); 

	$r = curl_exec($ch);

	if(curl_errno($ch)){
		print('error in posting');
		print(curl_error($ch));
		die();
	}
	curl_close($ch);
	$rObj = json_decode($r, true);

	if($cp)
	{
		echo "<br/><br/>response=><br />";
		print_r($rObj);
	}

	$cron_tab_array['authorize_toten']=$rObj;
	//cmn
	if($hardcode_test)
	{
		$rObj['subCode'] = 200;	//hard code for testing purpose
	}
	if($rObj['subCode'] == 200)
	{
		$auth_res['status']	= $rObj['status'];
		$auth_res['message']= $rObj['message'];
		$auth_res['token']	= $rObj['data']['token'];
		$auth_res['expiry']	= $rObj['data']['expiry'];

		$acquirer_response['auth_res']		= $auth_res;
		$acquirer_response['transfer_res']	= $transfer_res;
		$acquirer_response['resFinalStatus']= $resFinalStatus;

		$response_array_post=json_encode($acquirer_response, JSON_UNESCAPED_SLASHES);

		$acquirer_response['request_post'] = $transfer;

		$new_acquirer_response = json_encode($acquirer_response, JSON_UNESCAPED_SLASHES);

		$rmk_date=date('d-m-Y h:i:s A');
		$system_note_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$response_array_post." </div></div>".$td['system_note'];

		$txt_id = $resFinalStatus['referenceId'];

		//cmn
		if($hardcode_test){
			$txt_id = 21111100;		//hard code for testing purpose
		}
		if($resFinalStatus['status']=='SUCCESS')
		{
			$_GET['promptmsg']		= 'Withdraw Approved: ';
			$_GET['confirm_amount']	= $amount;
			$_GET['bid']			= $merID;
			$_GET['acquirer']			= $acquirer;

			update_trans_ranges(-1, 1, $td['id']);	// /FOR SUCCESS or accept
		}
		elseif($resFinalStatus['status']=='PENDING')
		{
			$_GET['promptmsg']		= 'Withdraw Pending: ';
			$_GET['confirm_amount']	= $amount;
			$_GET['bid']			= $merID;
			$_GET['acquirer']			= $acquirer;

			update_trans_ranges(-1, 0, $td['id']);	// /FOR SUCCESS or accept
		}
		else
		{
			$_GET['promptmsg'] = 'Cancelled: ';

			$_GET['confirm_amount']	= $amount;
			$_GET['bid']			= $merID;
			$_GET['acquirer']			= $acquirer;

			//update_trans_ranges(-1, 2, $td['id']);	// /FOR FAIL or REJECT or CANCEL
		}
	}
	else
	{
		if(($is_mer) || ($verify_by_admin)){
			$actionurl = urldecode($actionurl);
			$_SESSION['action_error']=$rObj["message"];
			header("Location:{$actionurl}");exit;
		}
		//$acquirer_response[]=$rObj;
	}
}
else
{
	//	FOR GET TOKEN -- START
	$cf_data = null;

	$finalUrl = $baseurl.$urls['auth'];
	$headers = create_header("");

	$ch = curl_init();
	curl_setopt($ch, CURLOPT_POST, 1);
	curl_setopt($ch, CURLOPT_URL, $finalUrl);
	curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	if(!is_null($cf_data)) curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($cf_data)); 

	$r = curl_exec($ch);

	if(curl_errno($ch)){
		print('error in posting');
		print(curl_error($ch));
		die();
	}
	curl_close($ch);
	$rObj = json_decode($r, true);

	if($data['pq'])
	{
		echo "<br/><br/>response=><br />";
		print_r($rObj);
	}

	$cron_tab_array['authorize_toten']=$rObj;
	if($rObj['subCode'] == 200)
	{
		$auth_res['status']	= $rObj['status'];
		$auth_res['message']= $rObj['message'];
		$auth_res['token']	= $rObj['data']['token'];
		$auth_res['expiry']	= $rObj['data']['expiry'];

		if(!empty($auth_res['token']))
		{
			// for check status
			$headers = create_header($auth_res['token']);

			$finalUrl = $baseurl.$urls['getTransferStatus'].$transfer['transferId'];

			$ch = curl_init();
			curl_setopt($ch, CURLOPT_URL, $finalUrl);
			curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

			$r = curl_exec($ch);

			if(curl_errno($ch)){
				print('error in posting');
				print(curl_error($ch));
				die();
			}
			curl_close($ch);

			$rObj2 = json_decode($r, true);

			$cron_tab_array['getTransferStatus']=$rObj2;
			//print_r($rObj2);
			if($rObj2['subCode'] == 200 || $rObj2['subCode'] == 201)
			{
				$resFinalStatus['status']		= $rObj2['status'];
				$resFinalStatus['message']		= $rObj2['message'];
				$resFinalStatus['referenceId']	= $rObj2['data']['transfer']['referenceId'];
				$resFinalStatus['bankAccount']	= $rObj2['data']['transfer']['bankAccount'];
				$resFinalStatus['ifsc']			= $rObj2['data']['transfer']['ifsc'];
				$resFinalStatus['beneId']		= $rObj2['data']['transfer']['beneId'];
				$resFinalStatus['amount	']		= $rObj2['data']['transfer']['amount'];
				$resFinalStatus['status1']		= $rObj2['data']['transfer']['status'];
				$resFinalStatus['utr']			= $rObj2['data']['transfer']['utr'];
				$resFinalStatus['addedOn']		= $rObj2['data']['transfer']['addedOn'];
				$resFinalStatus['processedOn']	= $rObj2['data']['transfer']['processedOn'];
				$resFinalStatus['transferMode']	= $rObj2['data']['transfer']['transferMode'];
				$resFinalStatus['acknowledged']	= $rObj2['data']['transfer']['acknowledged'];
				$resFinalStatus['phone']		= $rObj2['data']['transfer']['phone'];
			}
			else
			{
				$acquirer_response[]=$rObj2;
			}
		}
		$acquirer_response['auth_res']		= $auth_res;
		$acquirer_response['transfer_res']	= $transfer_res;
		$acquirer_response['resFinalStatus']= $resFinalStatus;

		$response_array_post=json_encode($acquirer_response, JSON_UNESCAPED_SLASHES);

		$acquirer_response['request_post']	= $transfer;

		$new_acquirer_response = json_encode($acquirer_response, JSON_UNESCAPED_SLASHES);

		$rmk_date=date('d-m-Y h:i:s A');
		$system_note_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$response_array_post." </div></div>".$td['system_note'];

		$txt_id = $resFinalStatus['referenceId'];

		db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`"." SET `acquirer_ref`='{$txt_id}',`acquirer_response`='{$new_acquirer_response}',`system_note`='".$system_note_upd."' WHERE `id`='".$td['id']."'");

		if($resFinalStatus['status']=='SUCCESS' && $rObj2['subCode'] == 200)
		{
			$_GET['promptmsg']		= 'Withdraw Approved: '.$resFinalStatus['message'];
			$_GET['confirm_amount']	= $amount;
			$_GET['bid']			= $merID;
			$_GET['acquirer']			= $acquirer;

			update_trans_ranges(-1, 1, $td['id']);	// /FOR SUCCESS or accept
		}
		elseif($resFinalStatus['status']=='PENDING' && ($rObj2['subCode'] == 201 || $rObj2['subCode'] == 202))	// for ref https://docs.cashfree.com/reference/standard-transfer-sync
		{
			$_GET['promptmsg']		= 'Withdraw Pending: ';
			$_GET['confirm_amount']	= $amount;
			$_GET['bid']			= $merID;
			$_GET['acquirer']			= $acquirer;

			update_trans_ranges(-1, 0, $td['id']);	// /FOR SUCCESS or accept
		}
		else
		{
			$_GET['promptmsg'] = 'Cancelled: ';

			$_GET['confirm_amount']	= $amount;
			$_GET['bid']			= $merID;
			$_GET['acquirer']			= $acquirer;

			//update_trans_ranges(-1, 2, $td['id']);	// /FOR FAIL or REJECT or CANCEL
		}
	}
	else
	{
		if($is_mer)
		{
			$_SESSION['action_error']=$rObj["message"];
			header("Location:{$actionurl}");exit;
		}
		$acquirer_response[]=$rObj;
	}
}
//else{
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
						echo "<div class='dta1 key $key1'>".$key1."</div><div class='dta1 val'>".$value1."</div>";
					}
				}
			}
		}
		echo '</div>';
	}
//}
exit;


//----------------------------------------------------------------
?>