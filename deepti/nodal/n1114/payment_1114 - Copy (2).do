<?
//print_r($_REQUEST); 
//exit
$disp_div = ' style="display:none;"';

$_REQUEST['sq']=1;
$_GET['sq']=1;

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
$sq=1; 
//cmn


$data['transIDExit']=1;
$data['status_in_email']=1;
$data['devEmail']='arun@bigit.io';
	

if((isset($_REQUEST['pq']))&&(!empty($_REQUEST['pq'])))
{
	$data['pq']=$_REQUEST['pq'];
	$cp=1;
}
if(isset($_REQUEST['sq'])&&$_REQUEST['sq'])
{
	$sq=1;
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
$bank_master = select_tablef('`payout_id` IN (1114) ','bank_payout_table');
 

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
$senderName	= $siteid_set['senderName'];
$passCode	= $siteid_set['passCode'];
$bcID		= $siteid_set['bcID'];
$mobile		= $siteid_set['mobile'];

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
	$amount		= $wd_pay_amount_default_currency;
	$amount_get	= $wd_pay_amount_default_currency;

	$acquirer		= $td['acquirer'];
	$merID			= $td['merID'];
	$acquirer_ref 	= $td['acquirer_ref'];
	$status			= $td['trans_status'];
	$bill_email		= $td['bill_email'];
	$bill_phone		= $td['bill_phone'];
	$bill_zip		= $td['bill_zip'];
	$bill_city		= $td['bill_city'];
	$bill_state		= $td['bill_state'];

	$txn = $td['acquirer_response'];

//print_r($txn);exit;

	$acquirer_response	= jsondecode($txn,true);	//CONVERT $txt_value into an array
	$beneId		= $acquirer_response['id'];
	$bname		= @$acquirer_response['bname'];
	$baddress	= @$acquirer_response['baddress'];
	$bcountry	= @$acquirer_response['bcountry'];
	$bnameacc	= @$acquirer_response['bnameacc'];
	$baccount	= decrypts_string(json_encode(@$acquirer_response['baccount']),0);
	$btype		= @$acquirer_response['btype'];
	$brtgifsc	= @$acquirer_response['bswift'];		//$acquirer_response['brtgnum'];
	$bswift		= @$acquirer_response['bswift'];
	$required_currency	= @$acquirer_response['required_currency'];
	$full_address		= @$acquirer_response['full_address'];

	$verify_status		= @$acquirer_response['verify_status'];

	//$bankData	= select_banks($uid,$beneId);			// fetch data from bank table
	//$bank_bene_id= $bankData[0]['bank_bene_id'];

	$bankData = select_tablef("`id` ='$beneId'",'banks');
	$bank_bene_id= @$bankData['bank_bene_id'];
	
	$data['logs']['beneId']=$beneId;
	$data['logs']['bank_bene_id']=$bank_bene_id;
	
	/*
	echo "<br/>baccount=>".$baccount;
	echo "<br/>baccount=>";print_r(@$acquirer_response['baccount']);
	exit;
	*/
	if($cp)
	{
		echo "uid=>$uid<br /><br />beneId => $beneId<br />";
		echo "bank_bene_id=>$bank_bene_id<br /><br />Bank detail => ";
		print_r($bankData);
	}
	//$new_beneficiary = false;

	if(empty($bank_bene_id))
	{
		//$new_beneficiary=true;

		if(strpos($brtgifsc,'ICIC') !== false) $PayeeType = 'W';
		else $PayeeType = 'O';

		$postData['CrpId']		=$crpId;
		$postData['CrpUsr']		=$crpUsr;
		$postData['AGGR_ID']	=$aggrId;

		$postData['BnfName']	=$bnameacc;
	//	$postData['BnfNickName']=substr($bnameacc,0,4).substr($beneId,-3);
		$postData['BnfNickName']=create_nickname($bnameacc,$beneId);
		
		$postData['BnfAccNo']	=$baccount;
		$postData['PayeeType']	=$PayeeType;
		$postData['IFSC']		=$brtgifsc;
		$postData['URN']		=$urn;

		#############
		$bene_url = $bank_url."/Corporate/CIB/v1/BeneAddition";
		
		$data['logs']['bene_url']=$bene_url;
		$data['logs']['postData']=$postData;

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
		
		$data['logs']['postbody']=$postbody;
		$data['logs']['headers']=$headers;

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

		$bene_log = "\n\nBENED - ".time()."==============================\n";
		$bene_log .= 'FileName - '.$file_start."SKYWALK_CIB_CERT.cer\n\n";
		$bene_log .= 'URL - '.$bene_url."\n\n";
		$bene_log .= 'HEADER - '.json_encode($headers)."\n\n";
		$bene_log .= 'REQUEST - '.json_encode($postData)."\n\n";
		$bene_log .= 'REQUEST ENCRYPTED - '.json_encode($postbody)."\n\n";
		

		$bene_log.= "\n\nGUID - ".time()."==============================\n";
		$bene_log.= "RESPONSE - ".$raw_response."\n\n";
		$bene_log.= "RESPONSE DECRYPTED - ".$newsource."\n\n";
		
		$data['logs']['bene_log']=@$bene_log;
		
		if($cp)
		{
			echo "<br /><br />bene_log=".nl2br($bene_log);
		//	exit;
		}

		$response_arr = json_decode($newsource,1);
		
		$data['logs']['response_arr']=$response_arr;

		$acquirer_response['bene_response'] = isset($response_arr)&&$response_arr?$response_arr:(isset($newsource)&&$newsource?$newsource:$raw_response);

		if(isset($response_arr['Response'])&&$response_arr['Response']=='SUCCESS')
		{
			$BNF_ID = $response_arr['BNF_ID'];
			$update_banks_1 = "UPDATE `{$data['DbPrefix']}banks` SET `bank_bene_id`='{$BNF_ID}' WHERE `id`='{$beneId}' ";
			db_query($update_banks_1);
			
			$data['logs']['update_banks_1']=@$update_banks_1;
			
			$acquirer_response['message'] = "Beneficiary added successfully with Beneficiary Id $BNF_ID. Fund transfer to the newly added Beneficiary will not be allowed immediately. You can send fund after 30 Minutes";
		}
		else
		{
			$acquirer_response['message'] =$response_arr['Message'];
		}
	}
	
	
	$data['logs']['acquirer_response']=$acquirer_response;
	
//	if($new_beneficiary==false)
	if($bank_bene_id)
	{
		if(strpos($brtgifsc,'ICIC') !== false) $txnType = 'TPA';
		else $txnType = 'RGS';
	
		$sendRequest = array();
		if(isset($_REQUEST['method'])&&strtolower($_REQUEST['method'])=='neft')	// create payload if method is NEFT
		{
			$sendRequest['tranRefNo']		=$transID;
			$sendRequest['amount']			="$amount";
			$sendRequest['senderAcctNo']	=$senderAcctNo;
			$sendRequest['beneAccNo']		=$baccount;
			$sendRequest['beneName']		=$bnameacc;
			$sendRequest['beneIFSC']		=$brtgifsc;
			$sendRequest['narration1']		="Pay for $transID";	//"Test";	//to be discuss
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
			$sendRequest['UNIQUEID']		=$transID;
			$sendRequest['AMOUNT']			="$amount";
			$sendRequest['DEBITACC']		=$senderAcctNo;
			$sendRequest['CREDITACC']		=$baccount;
			$sendRequest['CURRENCY']		=$required_currency;
			$sendRequest['PAYEENAME']		=$bnameacc;
			$sendRequest['IFSC']			=$brtgifsc;
			$sendRequest['REMARKS']			="Pay for $transID";	//"Test";	//to be discuss
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
			$sendRequest['tranRefNo']		=$transID;
			$sendRequest['paymentRef']		="Pay for $transID";
			$sendRequest['amount']			="$amount";
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
			//print_r($sendRequest);
			$x_priority = '0100';
		}
		elseif(isset($_REQUEST['method'])&&strtolower($_REQUEST['method'])=='upi')	// create payload if method is UPI
		{
			$x_priority = '1000';
		}
	}
	##############
	
	
	$data['logs']['sendRequest']=$sendRequest;
	$data['logs']['amount']=$amount;
	$data['logs']['amount_get']=$amount_get;
	
	
	##############
	if($amount>$amount_get){
		echo "<br /><br /><h1>Amount: {$amount} can not proccess more than {$amount_get}</h1>";
		exit;
	}

	//cmn
	if($cp){
		echo "<br/><br/>_POST=>";print_r($_POST);
		//exit;
	}

	$jsn=$td['json_value'];
	$json_value=jsondecode($jsn,1,1);
	
//	print_r($sendRequest);exit;
}
elseif(($is_mer) || ($verify_by_admin)){
	$acquirer_ref='';

	$tid		= $_REQUEST['tid'];
	$actionurl	= $_SESSION['return_url'];
	
	$data['logs']['is_mer']=$is_mer;
	$data['logs']['verify_by_admin']=$verify_by_admin;
	$data['logs']['tid']=$tid;
	$data['logs']['actionurl']=$actionurl;

	if($verify_by_admin && empty($uid)) $uid = $_GET['uid'];
	
	$data['logs']['uid']=$uid;

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
	
	$data['logs']['bankData']=$bankData;

	#############

	if(empty($bank_bene_id))
	{
		if(strpos($ifsc,'ICIC') !== false) $PayeeType = 'W';
		else $PayeeType = 'O';

		$postData['CrpId']		=$crpId;
		$postData['CrpUsr']		=$crpUsr;
		$postData['AGGR_ID']	=$aggrId;

		$postData['BnfName']	=$bnameacc;
	//	$postData['BnfNickName']=substr($bnameacc,0,4).substr($tid,-3);
		$postData['BnfNickName']=create_nickname($bnameacc,$beneId);
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
		
		$data['logs']['bene_url']=@$bene_url;
		$data['logs']['newsource']=@$newsource;

		if(isset($response_arr['Response'])&&$response_arr['Response']=='SUCCESS')
		{
			$BNF_ID = $response_arr['BNF_ID'];
			$update_banks_2 = "UPDATE `{$data['DbPrefix']}banks` SET `bank_bene_id`='{$BNF_ID}' WHERE `id`='{$tid}' ";
			db_query($update_banks_2);
			
			$data['logs']['update_banks_2']=@$update_banks_2;
		}
	}

	// request for fund transfer or neft 

	if(strpos($ifsc,'ICIC') !== false) $txnType = 'TPA';
	else $txnType = 'RGS';

	$transID = gen_transID_f(0,$uid);//time();

	$sendRequest = array();
	$sendRequest['tranRefNo']		=$transID;
	$sendRequest['amount']			="$amount";
	$sendRequest['senderAcctNo']	=$senderAcctNo;
	$sendRequest['beneAccNo']		=$baccount;
	$sendRequest['beneName']		=$bnameacc;
	$sendRequest['beneIFSC']		=$ifsc;
	$sendRequest['narration1']		="Pay for $transID";		//to be discuss
	$sendRequest['crpId']			=$crpId;
	$sendRequest['crpUsr']			=$crpUsr;
	$sendRequest['aggrId']			=$aggrId;
	$sendRequest['urn']				=$urn;
	$sendRequest['aggrName']		=$aggrName;
	$sendRequest['txnType']			=$txnType;
	$sendRequest['WORKFLOW_REQD']	="Y";
	
	
	$data['logs']['postbody_2']=$postbody;
	$data['logs']['headers_2']=$headers;
	$data['logs']['response_arr_2']=$response_arr;
	$data['logs']['sendRequest']=$sendRequest;
	$data['logs']['amount_2']=$amount;


//	print_r($sendRequest);
}

$auth_res		= array();
$transfer_res	= array();
$resFinalStatus = array();

if($cp)
{
	echo "txn_id=".$acquirer_ref;
}

$acquirer_ref="";
if(empty($acquirer_ref))
{
	if($bank_bene_id&&($status==13 || ($is_mer) || ($verify_by_admin)))
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

		if($cp)
		{
			echo "<br />RANDOMNO1=".$RANDOMNO1;
			echo "<br />RANDOMNO2=".$RANDOMNO2;
		}

		$iv = base64_encode($RANDOMNO2);
		$postbody= [
			"requestId" => $transID,
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

		$data['logs']['pay_url']=$pay_url;
		
		$log = "\n\nGUID - ".$transID."==============================\n";
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
		openssl_private_decrypt(base64_decode(@$request->encryptedKey), $key, $res);
		$encData = base64_decode(@$request->encryptedData); 
		$encData = openssl_decrypt(@$encData,"aes-128-cbc",$key,OPENSSL_PKCS1_PADDING);

		$newsource = substr(@$encData, 16); 

		$log.= "\n\nGUID - ".$transID."=========================================\n";
		$log.= "RESPONSE - ".$raw_response."\n\n";
		$log.= "RESPONSE DECRYPTED - ".$newsource."\n\n";
		
		
		$data['logs']['pay_log']=@$log;
		$data['logs']['newsource_2']=@$newsource;

		if($cp)
		{
			echo "<br /><br />LOG=".nl2br($log);
		//	exit;
		}
		$responseParam = json_decode($newsource,1);

		$check_status = "nodal/n1114/status_1114{$data['ex']}?transID=".$transID;
		$acquirer_response['bank_status']	= $check_status;

		//$acquirer_response['response'] = isset($responseParam)&&$responseParam?$responseParam:(isset($newsource)&&$newsource?$newsource:$raw_response);
		$acquirer_response['response'] = $responseParam;
		
		
		if($cp)
		{
			echo "<br /><br />responseParam=";print_r($responseParam);
		//	exit;
		}
//		echo "<div style='display:none'>LOG=".nl2br($log)."</div>";

		if(isset($_REQUEST['method'])&&$_REQUEST['method'])
			$acquirer_response['payment_method'] = $_REQUEST['method'];

		if((isset($responseParam['STATUS'])&&$responseParam['STATUS']=='SUCCESS')||(isset($responseParam['success'])&&$responseParam['success']=='1'))
		{
			$_GET['promptmsg']		= 'Withdraw Approved: ';
			$_GET['confirm_amount']	= $amount;
			$_GET['bid']			= (isset($uid)&&$uid)?$uid:$merID;
			$_GET['acquirer']			= $acquirer;

			update_trans_ranges(-1, 1, $td['id']);	// /FOR SUCCESS or accept

			if(strtolower($_REQUEST['method'])=='neft' || strtolower($_REQUEST['method'])=='rtgs')
			{	
				$REQID		= $responseParam['REQID'];
				$UNIQUEID	= $responseParam['UNIQUEID'];
				$UTRNUMBER	= $responseParam['UTRNUMBER'];
				$acquirer_ref 	= $UTRNUMBER;
			}
			elseif(strtolower($_REQUEST['method'])=='imps' || strtolower($_REQUEST['method'])=='upi')
			{	
				$TransRefNo	= $responseParam['TransRefNo'];
				$BankRRN	= $responseParam['BankRRN'];
				$acquirer_ref 	= $BankRRN;
			}

			$response_array_post=json_encode($acquirer_response, JSON_UNESCAPED_SLASHES);

			$acquirer_response['sendRequest'] = $sendRequest;

			$new_acquirer_response = json_encode($acquirer_response, JSON_UNESCAPED_SLASHES);

			$rmk_date=date('d-m-Y h:i:s A');
			$system_note_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$response_array_post." </div></div>".$td['system_note'];
		}
		elseif(isset($response_arr['STATUS'])&&$response_arr['STATUS']=='PENDING')
		{
			$_GET['promptmsg']		= 'Withdraw Pending: ';
			$_GET['confirm_amount']	= $amount;
			$_GET['bid']			= (isset($uid)&&$uid)?$uid:$merID;
			$_GET['acquirer']			= $acquirer;

			update_trans_ranges(-1, 0, $td['id']);	//FOR PENDING
		}
		else
		{
			$_GET['promptmsg']		= 'Cancelled: ';
			$_GET['confirm_amount']	= $amount;
			$_GET['bid']			= (isset($uid)&&$uid)?$uid:$merID;
			$_GET['acquirer']			= $acquirer;

			//$acquirer_response['response'] = isset($response_arr)&&$response_arr?$response_arr:$newsource;
			//update_trans_ranges(-1, 2, $td['id']);	//FOR FAIL or REJECT or CANCEL
		}

		if($cp)
		{
			echo "<br /><br />acquirer_response=";print_r($acquirer_response);
			//exit;
		}
//		$check_status = "nodal/n1114/status_1114{$data['ex']}?transID=".$transID;
//		$acquirer_response['bank_status']	= $check_status;

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
				
				$update_banks="UPDATE `{$data['DbPrefix']}banks` SET ".
					"`verify_amount`='{$amount}',verify_status='2',verify_date='".$data['TODAY_DATE_ONLY']."'".
					" WHERE `id`='{$tid}' ";
					
				db_query($update_banks,0);
				
				$_SESSION['sent_success']=$tid;
				$_SESSION['sent_tname']='banks';

				$_SESSION['action_success']="Verification amount successfully sent to account: <b>".encode($baccount,6)."</b>, please verify.";

				if($actionurl) {
					header("Location:{$actionurl}");exit;
				}
			}
			else{
				$update_authdata="UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` SET `acquirer_ref`='{$acquirer_ref}',`acquirer_response`='{$new_acquirer_response}',`system_note`='".$system_note_upd."' WHERE `id`='".$td['id']."'";
				
				db_query($update_authdata);
			}
		}
		
		
		$data['logs']['update_banks']=@$update_banks;
		$data['logs']['update_authdata']=@$update_authdata;
		$data['logs']['check_status_3']=@$check_status;
		$data['logs']['postbody_3']=@$postbody;
		$data['logs']['headers_3']=@$headers;
		$data['logs']['new_acquirer_response_3']=@$new_acquirer_response;
		$data['logs']['response_arr_3']=@$response_arr;
		$data['logs']['acquirer_ref_3']=@$acquirer_ref;
		$data['logs']['da_se']=@$da_se;
		$data['logs']['amount_3']=@$amount;
		$data['logs']['responseParam_3']=@$responseParam;
		
	}
}

// checking for not response than log save 
if(!is_array($responseParam))
{	
	$td['acquirer_response']=jsondecode($td['acquirer_response'],1,1);
	$acquirer_response_set_arr = array_merge($td['acquirer_response'],$acquirer_response);
	
	$acquirer_response_set = json_encode($acquirer_response_set_arr, JSON_UNESCAPED_SLASHES);
			
			$response_array_post=json_encode($acquirer_response, JSON_UNESCAPED_SLASHES);
			$rmk_date=date('d-m-Y h:i:s A');
			$system_note_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$response_array_post." </div></div>".$td['system_note'];
			
	$update_master_trans_table_last="UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` SET `acquirer_response`='{$acquirer_response_set}',`system_note`='".$system_note_upd."' WHERE `id`='".$td['id']."'";
				
	db_query($update_master_trans_table_last);
}
				
//authf($td['id'],'',$acquirer_response);


//email check for webhook etc 
	if(isset($data['status_in_email'])&&$data['status_in_email']){
		$send_attchment_message5=1;
		$data['gateway_push_notify']=$acquirer_response;
		include($data['Path'].'/payin/status_in_email'.$data['iex']);
		include($data['Path'].'/payin/res_insert'.$data['iex']);
	}
	
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