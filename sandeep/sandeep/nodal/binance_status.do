<?php 
//(0:Email Sent,1:Cancelled 2:Awaiting Approval 3:Rejected 4:Processing 5:Failure 6:Completed);

include('../config.do');

$cron_tab_array=array();

if(!isset($_SESSION['login_adm'])&&!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Admins']}/login".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

//-----------------------------------------------------------

	include "hardcode.php";	// INCLUDE FOR TESTING PURPOSE

	$data['pq']=0;
	$cp=0; 
	$hardcode_test=0;
	
	if($data['localhosts']==true){
		$hardcode_test=1;
	}

	if((isset($_REQUEST['pq']))&&(!empty($_REQUEST['pq'])))
	{
		$data['pq']=$_REQUEST['pq'];
		$cp=1;
	}

	$host_path=$data['Host'];

	$status="";

	$actionurl_get	="";
	$transID		="";
	$transID	=""; 
	$where_pred		=""; 
	$message		="";

	//-----------------------------------------------------------
	
	$onclick='javascript:top.popuploadig();popupclose2();';
	$actionurl="";
	$callbacks_url="";
		
	$is_admin=false; 
	$is_mer=false; 
	$verify_by_admin = false;
	$subQuery="";
	
	if(isset($_SESSION['login_adm'])&&$_SESSION['login_adm']&&isset($_GET['admin'])&&$_GET['admin']) {
		$is_admin=true;
	}

	if(isset($_SESSION['login_adm'])&&$_SESSION['login_adm']&&isset($_GET['admin_verify'])&&$_GET['admin_verify']) {
		$verify_by_admin=true;
		/*
		if(isset($_GET['id'])&&!empty($_GET['id'])){
			$uid=$_GET['id'];
		}
		*/
	}
	
	if(isset($_SESSION['login_adm'])&&$_SESSION['login_adm']&&isset($_GET['uid'])&&$_GET['uid']) {
		$verify_by_admin=true;
		if(isset($_GET['uid'])&&!empty($_GET['uid'])){
			$uid=$_GET['uid'];
		}
	}
	
	if(isset($_SESSION['login'])&&$_SESSION['login']&&isset($_GET['mer'])&&$_GET['mer']) {
		$is_mer=true;
	}
	
	//cmn
	//$is_mer=1;

//FETCH DATA FROM BANK TABLE 
//$bank_master = select_table_details(7001,'bank_payout_table');
$bank_master = select_tablef('`payout_id` IN (1111) ','bank_payout_table');

if($bank_master['payout_prod_mode']==1) $base_url = $bank_master['bank_payment_url'];
else $base_url = $bank_master['payout_uat_url'];

/*
$apikey		= $bank_master['siteid'];
$apisecret	= $bank_master['bank_api_token'];
$encode_processing_creds	= $bank_master['encode_processing_creds'];
*/
$bjson = decode_f($bank_master['encode_processing_creds']);

$encode_processing_creds = json_decode($bjson,true);

$bank_json_arr = json_decode($encode_processing_creds,1);

$apikey		= $bank_json_arr['siteid'];
$apisecret	= $bank_json_arr['bank_api_token'];

$history_json = $bank_master['history_json'];

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

	// $subQuery="&destroy=2&actionurl=$actionurl&cron_tab=ok_backURL";

	//-----------------------------------------------------------


	if(isset($_REQUEST['transID'])&&!empty($_REQUEST['transID'])){
		$transID=$_REQUEST['transID'];
		
		//$where_pred.=" (`transID`={$transID}) AND";
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
	//print_r($td);
	// exit;
	$td=$td[0];

	$json_value1=jsonencode1($td['json_value'],'',1);
	$json_value1=str_replace(array('[productName],'),'",',$json_value1);
	$json_value1=str_replace(array('[productName]},"'),'"},"',$json_value1);

	$jsv=json_decode($json_value1 ,1);
	$wd_pay_amount_default_currency=abs($jsv['wd_pay_amount_default_currency']);		


	$id		= $td['id'];
	//$amount	= abs($td['transaction_amt']);
	$amount	= $wd_pay_amount_default_currency;
	$amount_get	= $wd_pay_amount_default_currency;

	$acquirer	= $td['acquirer'];
	$merID	= $td['merID'];
	$acquirer_ref	= $td['acquirer_ref'];
	$status	= $td['trans_status'];

	$txn=$td['acquirer_response'];

	$acquirer_response	= jsondecode($txn,true);		//CONVER $txt_value into an array
	$bname		= $acquirer_response['bname'];
	$coins_name		= $acquirer_response['coins_name'];
	$coins_network	= $acquirer_response['coins_network'];
	$coins_address	= decrypts_string(json_encode($acquirer_response['coins_address']),0);
	$coins_wallet_provider	= $acquirer_response['coins_wallet_provider'];


	// new table coin_wallet
	if($acquirer_response['coins_name']){
		$bname="Crypto Wallet";
		$coins_name=$acquirer_response['coins_name'];
		$coins_network=$acquirer_response['coins_network'];
		$coins_address=decrypts_string($acquirer_response['coins_address'],0);
		$coins_wallet_provider=$acquirer_response['coins_wallet_provider'];
	}

	// Prompt via Post
	$network_fee = 0;
	if(isset($_POST['payout_amount'])&&$_POST['payout_amount']){
		$amount	= abs($_POST['payout_amount']);
	}
	if(isset($_POST['network_fee'])&&$_POST['network_fee']){
		$network_fee	= abs($_POST['network_fee']);
	}
	if(isset($_POST['coins_name'])&&$_POST['coins_name']){
		$coins_name=$_POST['coins_name'];
	}
	if(isset($_POST['coins_network'])&&$_POST['coins_network']){
		$coins_network=$_POST['coins_network'];
	}
	if(isset($_POST['coins_address'])&&$_POST['coins_address']){
		$coins_address=$_POST['coins_address'];
	}
	if(isset($_POST['coins_wallet_provider'])&&$_POST['coins_wallet_provider']){
		//$coins_wallet_provider=$_POST['coins_wallet_provider'];
	} 
	
	if($cp)
	{
		echo "_POST=><br />";
		print_r($_POST); 
	}

	if(($network_fee<$amount) && ($network_fee>0))
		$amount = ((float)$amount-(float)$network_fee);
	elseif(($network_fee>=$amount) && ($network_fee>0)){
		echo "<br/><br/><h1>Payout Amount: {$amount} should be more than Network Fee (".number_format($network_fee,2).")</h1>";
		exit;
	}

	$paramGet=[];
	$paramGet['amount']=$amount;
	$paramGet['bname']=$bname;
	$paramGet['coins_name']=$coins_name;
	$paramGet['coins_network']=$coins_network;
	$paramGet['coins_address']=$coins_address;
	$paramGet['coins_wallet_provider']=$coins_wallet_provider;

	if($amount>$amount_get){
		echo "<br /><br /><h1>Amount: {$amount} can not proccess more than {$amount_get}</h1>";
		exit;
	}

	//cmn
	//echo "<br/>paramGet=>";print_r($paramGet);echo "<br/><br/>_POST=>";print_r($_POST);exit;

	if($bname!='Crypto Wallet'&&!$acquirer_response['coins_name']){
		echo '<br /><br /><h1>Missing Crypto Wallet</h1>';
		exit;
	}

	$jsn=$td['json_value'];
	$json_value=jsondecode($jsn,true);

}
elseif(($is_mer) || ($verify_by_admin)){
	$acquirer_ref=0;

	$tid		= $_REQUEST['tid'];
	$actionurl	= $_REQUEST['actionurl'];
	
	if($verify_by_admin && empty($uid)) $uid = $_GET['uid'];

	$CryptoData	= select_coin_wallet($uid,$tid);

	$required_currency	= $CryptoData[0]['required_currency'];
	$coins_name			= $CryptoData[0]['coins_name'];
	$coins_address		= decrypts_string($CryptoData[0]['coins_address'],0);
	$coins_network		= $CryptoData[0]['coins_network'];
	

	$random_number = mt_rand(1,99);

	$amount = "10.".(($random_number<10)?"0".$random_number:$random_number);

	$amount = number_format($amount,2);
	
}
$history_record_count = 50;		//for store last 50 records 	
//$status=13;
if(empty($acquirer_ref)){			//IF txn_id IS NULL, THEN POST REQUEST FOR WITHDRAWAL

	//For Enable Fast Withdraw Switch (USER_DATA) -- START

	$timestamp = time()*1000; //get current timestamp in milliseconds
	
	$str = "timestamp=$timestamp";
	
	$signature = hash_hmac('sha256', $str, $apisecret);
	
	$params["signature"] = $signature;
	
	$endpoint	= "/sapi/v1/account/enableFastWithdrawSwitch";	
	$url =$base_url.$endpoint."?timestamp=$timestamp&signature=$signature";
	//echo $url;
	
	$ch = curl_init($url);
	curl_setopt($ch, CURLOPT_POST, 1);
	curl_setopt($ch, CURLOPT_HTTPHEADER, array("Content-Type: application/json", "X-MBX-APIKEY:".$apikey));
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	$response = curl_exec($ch);
	
	$responseParamList = json_decode($response,true);
	
	$cron_tab_array['responseParamList']=$responseParamList;
	
	if($data['pq'])
	{
		echo "<br/><br/>response=>".$response;
		echo "<br/><br/>responseParamList=>";
		var_dump($responseParamList);
	}
	
	$err = curl_error($ch);
	curl_close($ch);
	
	if($hardcode_test){
		//cmn
		$response=NULL;		// SET NULL FOR TESTING PURPOSE
	}

	if($responseParamList==NULL || empty($response)){
		
		// Enable Fast Withdraw Switch (USER_DATA) -- END

		###############
		
		//For Withdraw (USER_DATA) -- START

		/*
		if($coins_network=='TRC20'){ //"TRX";//"TRC20";
			$coins_network="TRX";
		}elseif($coins_network=='BEP20'){ //"TRX";//"TRC20";
			$coins_network="BSC";
		}
		*/

		$network_type = $bank_json_arr[$coins_network]['network_type'];

		$coin		= $coins_name;
		$address	= $coins_address;
		$amount		= $amount;//2;
		$network	= $network_type;//"TRX";//"TRC20";
		//for withdrawl
		$params = array (
			"coin" => $coin,
			"amount" => $amount,
			"address" => $address,
			"network" => $network,
		);
		
		$timestamp = time()*1000; //get current timestamp in milliseconds
		
		$str = "timestamp=$timestamp&coin=$coin&address=$address&amount=$amount&network=$network";
		
		$signature = hash_hmac('sha256', $str, $apisecret);
		
		$params["signature"] = $signature;
		
		$post_data = json_encode($params, JSON_UNESCAPED_SLASHES);
		
		$endpoint	= "/sapi/v1/capital/withdraw/apply";	
		$url =$base_url.$endpoint."?".$str."&signature=$signature";
		
		//echo $url;
		
		$ch = curl_init($url);
		curl_setopt($ch, CURLOPT_POST, 1);
		curl_setopt($ch, CURLOPT_HTTPHEADER, array("Content-Type: application/json", "X-MBX-APIKEY:".$apikey));
		curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		$response = curl_exec($ch);
		
		$responseParamList = json_decode($response,true);
		
		$cron_tab_array['withdraw_apply']=$responseParamList;
		
		if($data['pq'])
		{
			echo "<br/><br/>response2=>".$response;
			echo "<br/><br/>responseParamList2=>"; var_dump($responseParamList);
			echo "<br/><br/>post_data=>"; var_dump($post_data);
		}

		$err = curl_error($ch);
		curl_close($ch);

		if(isset($responseParamList['id'])) $txt_id = $responseParamList['id'];
		else $txt_id = "";
		
		if($hardcode_test){
		//cmn
			$txt_id = "156ec387f49b41df8724fa744fa82719";	// STATIC FOR TESTING PURPOSE
		}

	
		if(!empty($txt_id))
		{
			if($is_mer || $verify_by_admin){
	
				$da_se=array();
				$da_se['send']=$uid;
				$da_se['bid']=$uid;
				$da_se['curl']="byCurl";
				$da_se['admin']="1";
				$da_se['amount']=11;
				$da_se['bank']="c_".$tid;
				$da_se['requested_currency']='USD';
				$da_se['ThisTitle']='NODAL_POST';
				$da_se['txt_id']=$txt_id;
				$w_url=$data['USER_FOLDER']."/withdraw-frozen-fund{$data['ex']}?curl=1&admin=1&bid=".$uid;
				$wp_get=use_curl($w_url,$da_se);
	
				$wp=jsondecode($wp_get);
				$updateTid = $wp['clk']['wd_id'];
				//echo "<br/><br/>wd_id=><br/>".$wp['clk']['wd_id'];
				//echo "<br/><br/>clk=><br/>".$wp['clk']['transID'];
			
				$verify_amount = $amount;
				if($cp)
				{
					echo "wp_get=><br />";
					print_r($wp_get); 
					exit;
				}
	
	######################
	
				if(!$hardcode_test){
					$endpoint	= "/sapi/v1/capital/withdraw/history";	

					$timestamp = time()*1000; //get current timestamp in milliseconds

					$str = "timestamp=$timestamp";
					
					$signature = hash_hmac('sha256', $str, $apisecret);
					
					$params["signature"] = $signature;
					
					$url =$base_url.$endpoint."?timestamp=$timestamp&signature=$signature";
					
					$curl = curl_init();
					
					curl_setopt_array($curl, array(
						CURLOPT_URL => $url,
						CURLOPT_RETURNTRANSFER => true,
						CURLOPT_ENCODING => '',
						CURLOPT_MAXREDIRS => 10,
						CURLOPT_TIMEOUT => 0,
						CURLOPT_FOLLOWLOCATION => true,
						CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
						CURLOPT_CUSTOMREQUEST => 'GET',
						CURLOPT_HTTPHEADER => array(
							'Content-Type: application/json',
							'X-MBX-APIKEY: '.$apikey
						),
					));
					
					$response = curl_exec($curl);
					
					curl_close($curl);
					//echo $response;
				}
				else
					include "hardcode.php";	// INCLUDE FOR TESTING PURPOSE

				//echo $response;
				$responseParam = json_decode($response,true);
				
				$cron_tab_array['withdraw_history']=$responseParam;
				
				if($data['pq'])
				{
					echo "<br/><br/>withdraw_history=>";
					var_dump($responseParam);
				}
				
				//var_dump($responseParam);
			
				if (isset($responseParam) && count($responseParam)>0 )
				{
					$history_json_arr = array();
					$findid=false;
					for($i=0;$i<count($responseParam);$i++)
					{
						$res_address 		= $responseParam[$i]['address'];
						$res_amount 		= $responseParam[$i]['amount'];
						$res_applyTime 		= $responseParam[$i]['applyTime'];
						$res_coin 			= $responseParam[$i]['coin'];
						$res_id 			= $responseParam[$i]['id'];
						$res_withdrawOrderId= $responseParam[$i]['withdrawOrderId'];
						$res_network 		= $responseParam[$i]['network'];
						$res_transferType 	= $responseParam[$i]['transferType'];
						$res_status 		= $responseParam[$i]['status'];
						$res_transactionFee = $responseParam[$i]['transactionFee'];
						$res_confirmNo 		= $responseParam[$i]['confirmNo'];
						$res_txId 			= $responseParam[$i]['txId'];
				
						if($txt_id==$res_id)
						{
							$verify_amount = $res_amount;
							$findid=true;
							//break;
						}
						if($i<$history_record_count)
						{
							$history_json_arr[$res_id] = $responseParam[$i];
						}
						elseif($findid==true) break;
					}
					if($history_json_arr)
					{
						$history_json_de = json_encode($history_json_arr);
						$history_json_de = '{"withdraw_history":'.$history_json_de.'}';
						db_query(
							"UPDATE `{$data['DbPrefix']}bank_payout_table` SET ".
							"`history_json`='".($history_json_de)."'".
							" WHERE `payout_id`='1111' ",0
						);
					}
				}
				
				######################
				if($verify_by_admin)
				{
					$actionurl = urldecode($actionurl);
				}
				db_query(
					"UPDATE `{$data['DbPrefix']}coin_wallet` SET ".
					"`verify_amount`='{$verify_amount}',verify_status=2,verify_date='".TODAY_DATE_ONLY."', verify_tid='{$updateTid}'".
					" WHERE `id`='{$tid}' ",0
				);
				$_SESSION['sent_success']=$tid;
				$_SESSION['sent_tname']='coin_wallet';
				$_SESSION['coins_name']=$coins_name;
	
				$_SESSION['action_success']="Verification Amount sent to wallet address: <b>".encode($coins_address,6)."</b>, please verify.";
	
				header("Location:{$actionurl}");exit;
			}
			elseif($is_admin){
	
				$acquirer_response["post_request"]=$params;
				$new_acquirer_response = json_encode($acquirer_response, JSON_UNESCAPED_SLASHES);
	
				$rmk_date=date('d-m-Y h:i:s A');
				$system_note_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$txt_id." - Processing</div></div>".$td['system_note'];
				
				db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`"." SET `acquirer_ref`='{$txt_id}',`acquirer_response`='{$new_acquirer_response}',`system_note`='".$system_note_upd."', `trans_response`='Processing' WHERE `id`={$td['id']}");
	
				echo "<div class='hk_sts'><br /><div class='dta1 h1 key'>transID: $txt_id</div></div>";	
			}
		}
		else {
	//		var_dump($responseParamList);
			$code	= $responseParamList['code'];
			$msg	= $responseParamList['msg'];

			echo "<div class='hk_sts'><br /><div class='dta1 h1 key'>Error: ($code) $msg</div></div>";
	
			if($is_mer || $verify_by_admin)
			{
				$_SESSION['action_error']=$msg;

				header("Location:{$actionurl}");exit;
			}
		}
	}
	else {
		//var_dump($responseParamList);
		$code	= $responseParamList['code'];
		$msg	= $responseParamList['msg'];

		echo "<div class='hk_sts'><br /><div class='dta1 h1 key'>Error: ($code) $msg</div></div>";
		if($is_mer || $verify_by_admin)
		{
			$_SESSION['action_error']=$msg;

			header("Location:{$actionurl}");exit;
		}
	}
}
elseif($status==13 || $status==14) //$status!=1 && $status!=2 && 
{
	// CHECK TRANSACTION STATUS

	$check_live = true;

	if(isset($history_json) && $history_json)
	{
		$json = json_decode($history_json);
		foreach ($json->withdraw_history as $item) {
			if ($item->id == $acquirer_ref) {
				$res_address 		= $item->address;
				$res_amount 		= $item->amount;
				$res_applyTime 		= $item->applyTime;
				$res_coin 			= $item->coin;
				$res_id 			= $item->id;
				$res_withdrawOrderId= $item->withdrawOrderId;
				$res_network 		= $item->network;
				$res_transferType 	= $item->transferType;
				$res_status 		= $item->status;
				$res_transactionFee = $item->transactionFee;
				$res_confirmNo 		= $item->confirmNo;
				$res_txId 			= $item->txId;
				
				$response_array = array(
					"address"			=> $res_address,
					"amount"			=> $res_amount,
					"applyTime"			=> $res_applyTime,
					"coin"				=> $res_coin,
					"id"				=> $res_id,
					"withdrawOrderId"	=> $res_withdrawOrderId,
					"network"			=> $res_network,
					"transferType"		=> $res_transferType,
					"status"			=> $res_status,
					"transactionFee"	=> $res_transactionFee,
					"confirmNo"			=> $res_confirmNo,
					"txId"				=> $res_txId
				);
				if($res_status==1 || $res_status==3 || $res_status==5 || $res_status==6)
				{
					$check_live=false;

					if($res_status==6)
					{
						$_GET['promptmsg']		= 'Withdraw Approved: ';
		
						update_trans_ranges(-1, 1, $td['id']);	// /FOR SUCCESS or accept
					}
					elseif($res_status==1 || $res_status==3 || $res_status==5)
					{
						if($res_status==1)		$_GET['promptmsg'] = 'Cancelled: ';
						elseif($res_status==3)	$_GET['promptmsg'] = 'Rejected: ';
						else					$_GET['promptmsg'] = 'Fail: ';
	
						///update_trans_ranges(-1, 2, $td['id']);	// /FOR FAIL or REJECT or CANCEL
					}
					echo "<br /><br /><div class='hk_sts'>";
					if(is_array($response_array)){ 
						foreach($response_array as $key=>$value){
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
					echo '</div>';
				}
				break;
			}
		}
	}

	if($check_live == true)
	{
		$endpoint	= "/sapi/v1/capital/withdraw/history";	
	
		$timestamp = time()*1000; //get current timestamp in milliseconds
		
		$str = "timestamp=$timestamp";
		
		$signature = hash_hmac('sha256', $str, $apisecret);
		
		$params["signature"] = $signature;
		
		$url =$base_url.$endpoint."?timestamp=$timestamp&signature=$signature";
		
		$curl = curl_init();
	
		curl_setopt_array($curl, array(
			CURLOPT_URL => $url,
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_ENCODING => '',
			CURLOPT_MAXREDIRS => 10,
			CURLOPT_TIMEOUT => 0,
			CURLOPT_FOLLOWLOCATION => true,
			CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			CURLOPT_CUSTOMREQUEST => 'GET',
			CURLOPT_HTTPHEADER => array(
				'Content-Type: application/json',
				'X-MBX-APIKEY: '.$apikey
			),
		));
		
		$response = curl_exec($curl);
		
		curl_close($curl);
	
		if($hardcode_test){
			//cmn
			$txt_id = "156ec387f49b41df8724fa744fa82719";	// STATIC FOR TESTING PURPOSE
			include "hardcode.php";	// INCLUDE FOR TESTING PURPOSE
		}
	
		$responseParam = json_decode($response,true);
	
		$cron_tab_array['withdraw_history']=$responseParam;
					
		if($data['pq'])
		{
			echo "<br/><br/>withdraw_history=>";
			var_dump($responseParam);
		}
		
		var_dump($responseParam);
		//exit;
		if (isset($responseParam) && count($responseParam)>0 )
		{
			$history_json_arr = array();
			$findid=false;
			for($i=0;$i<count($responseParam);$i++)
			{
				$res_address 		= $responseParam[$i]['address'];
				$res_amount 		= $responseParam[$i]['amount'];
				$res_applyTime 		= $responseParam[$i]['applyTime'];
				$res_coin 			= $responseParam[$i]['coin'];
				$res_id 			= $responseParam[$i]['id'];
				$res_withdrawOrderId= $responseParam[$i]['withdrawOrderId'];
				$res_network 		= $responseParam[$i]['network'];
				$res_transferType 	= $responseParam[$i]['transferType'];
				$res_status 		= $responseParam[$i]['status'];
				$res_transactionFee = $responseParam[$i]['transactionFee'];
				$res_confirmNo 		= $responseParam[$i]['confirmNo'];
				$res_txId 			= $responseParam[$i]['txId'];
	
				if($acquirer_ref==$res_id)
				{
					$findid=true;

					$response_array = array(
						"address"			=> $res_address,
						"amount"			=> $res_amount,
						"applyTime"			=> $res_applyTime,
						"coin"				=> $res_coin,
						"id"				=> $res_id,
						"withdrawOrderId"	=> $res_withdrawOrderId,
						"network"			=> $res_network,
						"transferType"		=> $res_transferType,
						"status"			=> $res_status,
						"transactionFee"	=> $res_transactionFee,
						"confirmNo"			=> $res_confirmNo,
						"txId"				=> $res_txId
					);
					$acquirer_response["rec_response"] = $response_array;
	
					$tr_upd_order['responseParam']	= $response_array?$response_array:$response;	
					
					transactions_updates($td['id'], $tr_upd_order);
	
					echo "<br /><br /><div class='hk_sts'>";
					if(is_array($response_array)){ 
						foreach($response_array as $key=>$value){
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
					echo '</div>';
	
					//print_r($response_array);
					$new_acquirer_response = json_encode($acquirer_response, JSON_UNESCAPED_SLASHES);
					
					$response_array_post=json_encode($response_array, JSON_UNESCAPED_SLASHES);
					$rmk_date=date('d-m-Y h:i:s A');
					$system_note_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$response_array_post." </div></div>".$td['system_note'];
	
					db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`"." SET `acquirer_response`='{$new_acquirer_response}',`system_note`='".$system_note_upd."', `trans_response`='Processing' WHERE `id`={$td['id']}");
	
					if($res_status==6)
					{
						$_GET['promptmsg']		= 'Withdraw Approved: ';
						$_GET['confirm_amount']	= $amount;
						$_GET['bid']			= $merID;
						$_GET['acquirer']			= $acquirer;
		
						update_trans_ranges(-1, 1, $td['id']);	// /FOR SUCCESS or accept
					}
					elseif($res_status==1 || $res_status==3 || $res_status==5)
					{
						if($res_status==1)		$_GET['promptmsg'] = 'Cancelled: ';
						elseif($res_status==1)	$_GET['promptmsg'] = 'Rejected: ';
						else					$_GET['promptmsg'] = 'Fail: ';
	
						$_GET['confirm_amount']	= $amount;
						$_GET['bid']			= $merID;
						$_GET['acquirer']			= $acquirer;
	
						///update_trans_ranges(-1, 2, $td['id']);	// /FOR FAIL or REJECT or CANCEL
					}
					//exit;
				}
				if($i<$history_record_count)
				{
					$history_json_arr[] = $responseParam[$i];
				}
				elseif($findid==true) break;
			}
		}
	
		if($history_json_arr)
		{
			$history_json_de = json_encode($history_json_arr);
			$history_json_de = '{"withdraw_history":'.$history_json_de.'}';
			db_query(
				"UPDATE `{$data['DbPrefix']}bank_payout_table` SET ".
				"`history_json`='".($history_json_de)."'".
				" WHERE `payout_id`='1111' ",0
			);
		}
	}
	
	
	exit;
}
else
{
	echo "<br /><br /><div class='hk_sts'>";
	if(is_array($acquirer_response)){ 
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
	}
	echo '</div>';
}
exit;


//----------------------------------------------------------------
?>
