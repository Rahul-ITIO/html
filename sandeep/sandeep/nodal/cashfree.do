<?php 
include('../config.do');
//cmn
$hardcode_test=0;
if($data['localhosts']==true){
	$hardcode_test=1;
}
if( ((strpos($_SERVER['HTTP_REFERER'],'signins/merchant_settlement')!==false) && (isset($post['curl'])&&$post['curl']=='byCurl') ) ) {
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

$data['pq']=0;$cp=0; 
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

if((isset($_SESSION['login_adm'])&&$_SESSION['login_adm']&&isset($_GET['admin'])&&$_GET['admin']) ||  ((strpos($_SERVER['HTTP_REFERER'],'signins/merchant_settlement')!==false) && (isset($post['curl'])&&$post['curl']=='byCurl') ) ) {
	$is_admin=true;
}

if(isset($_SESSION['login_adm'])&&$_SESSION['login_adm']&&isset($_GET['admin_verify'])&&$_GET['admin_verify']) {
	$verify_by_admin=true;
}


if(isset($_SESSION['login'])&&$_SESSION['login']&&isset($_GET['mer'])&&$_GET['mer']) {
	$is_mer=true;
}

//FETCH DATA FROM BANK TABLE
$bank_master = select_tablef('`payout_id` IN (1112) ','bank_payout_table');


$bjson = decode_f($bank_master['encode_processing_creds']);

$encode_processing_creds = json_decode($bjson,true);

//$encode_processing_creds=json_decode($bank_master['encode_processing_creds'],true);


if($bank_master['payout_prod_mode']==1) {
	$siteid_set=$encode_processing_creds['live'];
}
else {
	$siteid_set=$encode_processing_creds['test'];
}

$clientId	= $siteid_set['clientId'];
$clientSecret= $siteid_set['clientSecret'];
$baseurl	= $siteid_set['baseurl'];

$urls = array(
	'auth' => '/payout/v1/authorize',
	'getBene' => '/payout/v1/getBeneficiary/',
	'addBene' => '/payout/v1/addBeneficiary',
	'requestTransfer' => '/payout/v1/requestTransfer',
	'getTransferStatus' => '/payout/v1/getTransferStatus?transferId='
);

$header = array(
	'X-Client-Id: '.$clientId,
	'X-Client-Secret: '.$clientSecret, 
	'Content-Type: application/json',
);

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

	$acquirer_response	= jsondecode($txn,true);		//CONVER $txt_value into an array
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

	// Prompt via Post
	if(isset($_POST['payout_amount'])&&$_POST['payout_amount']){
		$amount	= abs($_POST['payout_amount']);
	}
	if(isset($_POST['coins_name'])&&$_POST['coins_name']){
		$bswift=$_POST['coins_name'];
	}
	if(isset($_POST['coins_network'])&&$_POST['coins_network']){
		$brtgnum=$_POST['coins_network'];
	}
	if(isset($_POST['coins_address'])&&$_POST['coins_address']){
		//$baccount=$_POST['coins_address'];
	}
	if(isset($_POST['coins_wallet_provider'])&&$_POST['coins_wallet_provider']){
		//$baddress=$_POST['coins_wallet_provider'];
	}

	##############

	$beneficiary = array(
		'beneId' => $beneId,
		'name' => $bname,
		'email' => $td['bill_email'],
		'phone' => $td['bill_phone'],
		'bankAccount' => $baccount,
		'ifsc' => $bswift,//$brtgifsc,
		'address1' => $full_address,
		//'bill_city' => $td['bill_city'],
		///'bill_state' => $td['bill_state'],
		//'pincode' => $td['bill_zip'],
	);
	$transfer = array(
		'beneId' => $beneId,///'JOHN18019',
		'amount' => $amount,
		'transferId' => $transactionId,
	);

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
	$baccount	= decrypts_string($bankData[0]['baccount'],0);
	$bnameacc	= $bankData[0]['bnameacc'];
	$bphone		= $bankData[0]['bphone'];
	//$brtgnum	= $bankData[0]['brtgnum'];
	$brtgnum	= $bankData[0]['bswift'];
	$baddress	= $bankData[0]['baddress'];

	$memData	= get_all_clients_new($uid);	//fetch data from clients table
	$mem_email	= $memData[$uid]['email'];
	$mem_phone	= $memData[$uid]['phone'];

	$random_number = mt_rand(1,99);

	$amount = "1.".(($random_number<10)?"0".$random_number:$random_number);

	$amount = number_format($amount,2);

	$beneficiary = array(
		'beneId' => $tid,
		'name' => $bnameacc,
		'email' => $mem_email,
		'phone' => $mem_phone,
		'bankAccount' => $baccount,
		'ifsc' => $brtgnum,
		'address1' => $baddress
	);
	if($cp)
	{
		echo'<hr />beneficiary==><br />';
		print_r($beneficiary);
	}

	$transfer = array(
		'beneId' => $tid,///'JOHN18019',
		'amount' => $amount,
		'transferId' =>  date('YmdHis')
	);
}

$auth_res		= array();
$transfer_res	= array();
$resFinalStatus = array();

if(empty($acquirer_ref)){			//IF txn_id IS NULL, THEN POST REQUEST FOR WITHDRAWAL

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

	if($cp)
	{
		echo "<br/><br/>response=><br />";
		print_r($rObj);
	}

	$cron_tab_array['authorize_toten']=$rObj;
	//cmn
	if($hardcode_test)
	{
		$rObj['subCode'] = 200;	//hard code for teting purpose
	}
	if($rObj['subCode'] == 200)
	{
		$auth_res['status']	= $rObj['status'];
		$auth_res['message']= $rObj['message'];
		$auth_res['token']	= $rObj['data']['token'];
		$auth_res['expiry']	= $rObj['data']['expiry'];

		//cmn
		if($hardcode_test){
			$auth_res['token']=1;	//hard code for teting purpose
		}

		if(!empty($auth_res['token']))
		{
			if(!$hardcode_test)
			{
				if(!getBeneficiary($auth_res['token']) ) addBeneficiary($auth_res['token']);
			}
			if($status==13 || ($is_mer) || ($verify_by_admin))
			{
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
			else
				$subCode = 200;

			//cmn
			if($hardcode_test){
				$subCode = 200;		//hard code for testing purpose
			}
			if($subCode == 200)
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

				//cmn
				if($cp){
					echo "<br />Object 2 Line no. 397==><br />";
					print_r($rObj2);
				}

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
		}

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