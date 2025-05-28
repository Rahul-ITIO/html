<? 
$data['PageName']='TRANSACTIONS STATISTIC';	//define page name or h1 title of a page
$data['PageFile']='trnslist';			//define template name
$data['HideLeftSide']=true;					//if true then hide left menu

###############################################################################



include('../config.do');

//if(isset($_GET['date_label'])) $_GET['date_label']=prntext($_GET['date_label']);
if(isset($_REQUEST['date_label'])) $_REQUEST['date_label']=prntext($_REQUEST['date_label']);
/*
$get_val=[];
if(isset($_GET)&&count($_GET)>0){
	foreach($_GET as $key=>$value){
		if(($value && is_string($value) ) && (in_array($key, $strip_get_skip['strip_get_skip']))){
			//$_REQUEST[$key]=($value);
		}else{
			$get_val[$key]=prntext($value);
			//unset($_REQUEST[$key]);
		}
	}
	//$_REQUEST=$_GET=array_merge($_REQUEST,$get_val);
}
*/

//$data['skip_connection_type']='Y';
//define list of TransactionStatus, use only for ruby theme
if(isset($data['frontUiName'])) $status_button=("../front_ui/{$data['frontUiName']}/common/status_button".$data['iex']);
else $status_button='';

//include status button file if exists
if(file_exists($status_button)){
	include($status_button);
}

if(!isset($_SESSION['test_merchant']))
{
	$test_merchant=$_SESSION['test_merchant']=select_tablef(" `active`='1' AND `status`='2' AND `sub_client_id` IS NULL  ORDER BY `id` ASC  ",'clientid_table',0,1,"`username`,`id`,`default_currency`,`private_key`");
}
//$data['test_merchant_user']=$_SESSION['test_merchant']['username'];
//print_r($_SESSION['test_merchant']);

// Dev Tech : 23-05-29 fetch the data from Bank Payout Table for option of Withdraw
if(!isset($_SESSION['data_bank_payout_table'])){
	$result_select_bpt=db_rows(
		" SELECT * FROM {$data['DbPrefix']}bank_payout_table".
		" WHERE payout_status='1' AND payout_type='6'".
		" ORDER BY id DESC"
	);

	$_SESSION['data_bank_payout_table']=$result_select_bpt;
}
//print_r($_SESSION['data_bank_payout_table']);

$dtest=0;
if(isset($_GET['dtest'])) $dtest=@$_GET['dtest'];

if($data['localhosts']==true){ }
else 
{
	
	
	//$up1=15;
	$up1=30;
	if($data['connection_type']=='PSQL') 
	{
		$qr_interval= "'{$up1} minute' ";
		$qr_interval_2= "'1 minute'";
	}
	else
	{ 
		$qr_interval= "{$up1} minute";
		$qr_interval_2= "1 minute";
	}

	if(isset($data['TRANS_EXPIRED_VIA_ADMIN_DASHBOARD'])&&$data['TRANS_EXPIRED_VIA_ADMIN_DASHBOARD']=='auto_expired_30_min'){
		db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` SET `trans_status`=22 WHERE `trans_status` IN (0) AND `tdate` <= now() - interval {$qr_interval}; ",$dtest);
	}
	elseif(isset($data['TRANS_EXPIRED_VIA_ADMIN_DASHBOARD'])&&$data['TRANS_EXPIRED_VIA_ADMIN_DASHBOARD']=='acquirer_table_wise')
	{
		//UPDATE `zt_master_trans_table_4` AS `t`, `zt_acquirer_table` AS `a` SET `t`.`trans_status`='22'  WHERE `t`.`trans_status` IN (0) AND  `t`.`acquirer`=`a`.`acquirer_id`  AND `t`.`tdate` < now() - interval `a`.`trans_auto_expired` minute LIMIT 5;

		// UPDATE zt_master_trans_table_4 t SET trans_status = '22' FROM zt_acquirer_table a WHERE t.trans_status IN (0) AND t.acquirer = a.acquirer_id AND t.tdate < now() - (a.trans_auto_expired * INTERVAL '1 minute');

		// UPDATE zt_master_trans_table_4 t SET trans_status = '22' FROM zt_acquirer_table a WHERE t.trans_status IN (0) AND t.acquirer = a.acquirer_id AND t.tdate < now() - (INTERVAL '1 minute' * a.trans_auto_expired );


		//db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` t  SET `trans_status` = '22' FROM `{$data['DbPrefix']}acquirer_table` a WHERE t.`trans_status` IN (0)  AND  t.`acquirer` = a.`acquirer_id`  AND  t.`tdate` <= now() - (INTERVAL {$qr_interval_2} * a.trans_auto_expired);",$dtest);
		
		db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` t  SET `trans_status` = '22' FROM `{$data['DbPrefix']}acquirer_table` a WHERE t.`trans_status` IN (0)  AND  t.`acquirer` = a.`acquirer_id`  AND  t.`tdate` <= now() - (a.trans_auto_expired * INTERVAL {$qr_interval_2});",$dtest);

	}
	
}

//function for close modal popup 
function closeModal($theId,$transID=0){
	global $data;
	//close modal popup
	echo"
	 <script>
	 popupclose();
	 top.window.document.getElementById('modal_popup_form_popup').style.display='none';
	 </script>
	";
	//if transID exists then show only transaction 
	if($transID>0){
		$topUrl=$data['Admins']."/{$data['trnslist']}{$data['ex']}?action=select&acquirer=-1&status=-1&keyname=1&searchkey=".$transID;
		echo"
		 <script>
		 popuploadig();
		 top.window.location.href='$topUrl';
		 </script>
		";
	}
}
$data['PageTitle'] = 'Transactions - '.$data['domain_name'];	//define page title name
###############################################################################
//check login with admin or not, if not login with admin then re-direct to login page
if(!isset($_SESSION['adm_login'])){
	$_SESSION['adminRedirectUrl']=$data['urlpath'];	//store current url into session for redirect after login
	header("Location:{$data['Admins']}/login".$data['ex']);
	echo('ACCESS DENIED.'); exit;
}
###############################################################################

if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'){
	$mta=1;
	$mts="`ad`";
}
else{
	$mta=0;
	$mts="`t`";
}

###############################################################################

//this section use for nodal account 1111 (binance nodal), if not set then fetch the data from bank table and store into $_SESSION
if(!isset($_SESSION['nodal_bank_1111']))
{
	$bank_master = select_tablef("`payout_id` IN ('1111') ","bank_payout_table");
	if(isset($bank_master['encode_processing_creds'])&&$bank_master['encode_processing_creds']){
		$bank_json1	= $bank_master['encode_processing_creds'];
		$bank_json_arr = jsondecode($bank_json1,1);
		$_SESSION['nodal_bank_1111'] = $bank_json_arr;
	}
}
############# Remove html tages and blank spaces from acquirer
if(isset($_GET['acquirer'])){ $_GET['acquirer']=strip_tags_d($_GET['acquirer']); } 
//if($_GET)get_request1();
 
if(!isset($_SESSION['merchant_details'])){
	$post['merchant_detail']=merchant_details(2);	//fetch merchant details
}

//defines the default values of the following variables if not set or empty values
if(!isset($post['action']))$post['action']='select';
if(!isset($post['acquirer']))$post['acquirer']=-1;
if(!isset($post['status']))$post['status']=-1;
if(isset($_GET['dt1'])){$post['dt1']=date('Y-m-d',strtotime($_GET['dt1']));}else {$post['dt1']='';}
if(isset($_GET['dt2'])){$post['dt2']=date('Y-m-d',strtotime($_GET['dt2']));}else {$post['dt2']='';}
if(!isset($_GET['ccard_type'])){$post['ccard_type']=-1;}else {$post['ccard_type']=strtolower($_GET['ccard_type']);}
if(!isset($_GET['trans_type'])){$post['trans_type']='';}else {$post['trans_type']=$_GET['trans_type'];}
$ccard_type=$post['ccard_type'];
$trans_type=$post['trans_type'];
if($post['acquirer']>=0){
	$data['PageName'].= " [".($data['acquirer_list'][$post['acquirer']])."]";
}


//initialize the variable with default values
$data['is_check']=false;$data['is_card']=false;$post['is_account']="";
if(isset($_GET['acquirer']) && $_GET['acquirer']>0){
 $acc_type=strip_tags_d($_GET['acquirer']);
	$data['is_card']=true;$post['is_account']="card";
}
//create url string depend on current search result
 $cmn_action = "";
 if(isset($post['acquirer'])){			$cmn_action .= "&acquirer=".strip_tags_d($post['acquirer']);}
 if(isset($post['status'])){		$cmn_action .= "&status=".$post['status'];}
 if(isset($_GET['bid'])){			$cmn_action .= "&bid=".$_GET['bid'];}
 if(isset($_GET['StartPage'])){		$cmn_action .= "&page=".$_GET['StartPage'];}
 if(isset($_GET['order'])){			$cmn_action .= "&order=".$_GET['order'];}
 if((isset($_GET['is_account']))&&($_GET['is_account']!='')){
	 	$cmn_action .= "&is_account=".$_GET['is_account'];
		}
	elseif((isset($post['is_account']))&&($post['is_account']!='')){
		$cmn_action .= "&is_account=".$post['is_account']; 
	}
		
 if((isset($post['trans_type']))&&($post['trans_type']!='')){ 		$cmn_action .= "&trans_type=".$post['trans_type'];}
if((isset($post['ccard_type']))&&($post['ccard_type'])){$cmn_action .="&ccard_type=".$post['ccard_type'];}
 if((isset($post['dt1']))&&($post['dt1']!='')){    		$cmn_action .= "&dt1=".$post['dt1'];}
 if((isset($post['dt2']))&&($post['dt2']!='')){    		$cmn_action .= "&dt2=".$post['dt2'];}
 
//create re-direct url
 $re_url="location:{$data['Admins']}/{$data['trnslist']}{$data['ex']}?action=select$cmn_action";
$data['cmn_action']= $cmn_action;	//store url string into $data array
$payoutdays="16";	//define default payout days 16

//if account acquirer is card then define default payout days 14
 if((isset($_GET['is_account']))&&($post['is_account']=="card" || $_GET['is_account']=="card")){$payoutdays="14";}

###############################################################################

//as per request connection if multiple 
if(isset($data['DB_CON'])&&isset($_REQUEST['DBCON'])&&trim($_REQUEST['DBCON'])&&function_exists('config_db_more_connection'))
{
	$DBCON=(isset($_REQUEST['DBCON'])?$_REQUEST['DBCON']:"");
	$dbad=(isset($_REQUEST['dbad'])?$_REQUEST['dbad']:"");
	$dbmt=(isset($_REQUEST['dbmt'])?$_REQUEST['dbmt']:"");
	config_db_more_connection($DBCON,$dbad,$dbmt);
	
}

###############################################################################


//if withdraw accepted the execute this section
if($post['action']=='confirm'){	
	//echo "<hr/>update_trans_ranges=>";exit;
	//update transaction and change transaction status from Withdraw Requested to Withdraw Approved
	
	if(isset($_REQUEST['type'])&&in_array($_REQUEST['type'],[2,3,4])&&isset($_REQUEST['csov3'])&&$_REQUEST['csov3']==1&&isset($data['CUSTOM_SETTLEMENT_OPTIMIZER_V3'])&&isset($data['CUSTOM_SETTLEMENT_WD_V3'])&&$data['CUSTOM_SETTLEMENT_WD_V3']=='Y'){
		$custom_settlement_optimizer_v3=1;
		$master_trans_table_set=$data['CUSTOM_SETTLEMENT_OPTIMIZER_V3'];
	}
	else{
		 $custom_settlement_optimizer_v3=0;
		 $master_trans_table_set=$data['MASTER_TRANS_TABLE'];
	}
	
	

	//$res=update_trans_ranges(-1, 1, $post['gid']);
	$res=update_trans_ranges(-1, 1, $post['gid'], '',  1,  1, '', $custom_settlement_optimizer_v3);

	$_SESSION['action_success']=" Transaction Update successfully ";

	// Dev Tech : 24-05-15 settlement webhook url 
	if(@$_REQUEST['type']==2||@$_REQUEST['type']==3||@$_REQUEST['type']==4){
		$promptmsg=@$_REQUEST['promptmsg'];
		
		if(isset($_REQUEST['qp']))  echo "<br/>promptmsg=>".@$promptmsg;

		if(isset($_SESSION['adm_login'])){
			if(isset($_SESSION['sub_username'])&&$_SESSION['sub_username']){
				$sub_username = $_SESSION ['sub_username'];
			}else{
				$sub_username = 'Admin';
			} 
			
		}
		
		//$timestamp=@$data['settlement_webhook_array']['timestamp'];
		$timestamp=micro_current_date();;
		
		$settlement_webhook_array['transID']=@$data['settlement_webhook_array']['transID'];
		$settlement_webhook_array['username']=@$sub_username;
			$settlement_webhook_array['timestamp']=@$timestamp;
			$settlement_webhook_array['settlement_amount']=@$data['settlement_webhook_array']['settlement_amount'];
			$settlement_webhook_array['settlement_currency']=@$data['settlement_webhook_array']['settlement_currency'];
		$settlement_webhook_array['message']=@$promptmsg;

		if(isset($_REQUEST['qp'])) 
		{ 
			echo "<br/>settlement_webhook_url=>".@$settlement_webhook_url;
		  	echo "<br/>settlement_webhook_json".json_encode(@$settlement_webhook_array);
		}

		$settlement_webhook_url=@$data['settlement_webhook_url'];
		if(isset($settlement_webhook_url)&&trim($settlement_webhook_url)&&!empty($settlement_webhook_url)) use_curl(@$settlement_webhook_url, @$settlement_webhook_array);
		//
	}
	//echo "<br/>settlement_webhook_url=>".@$settlement_webhook_url; exit;

	
	//check software version if version is 3 and second (payout) database exists then execute this section
	if((isset($data['PRO_VER']))&&($data['PRO_VER']==3)&&(isset($data['Database_2'])&&$data['Database_2']))
	{

		//fetch the full data of a transaction
		$trans_result=select_tablef("`id` IN ({$_REQUEST['id']})",$master_trans_table_set,0,1);
		$data['json_value']=jsondecode(@$trans_result['json_value']);
		
		
		if(in_array($trans_result['acquirer'],[2,3,4])) 
		{
		
			//fetch the data from clients table
			$memers_row = select_tablef("`id` IN ({$trans_result['merID']})",'clientid_table',0,1," `payout_request`");

			//payout request from clientid table
			$payout_request= @$memers_row['payout_request'];	

			//payout account from payout setting table
			$ps_row = select_tablef("`clientid` IN ({$trans_result['merID']})",'payout_setting',0,1," `payout_account`");

			$payout_account= @$ps_row['payout_account'];		//mapped payout account


			if($payout_request==1)	//if payout request activate the update data into payout table
			{
				$bank_data	= select_tablef("`id` IN ({$payout_account})",'bank_payout_table',0,1," `payout_processing_currency`");
				$payout_processing_currency= $bank_data['payout_processing_currency'];	//fetch payout default currency from bank table

				//if requested currency and default currency are not matched then convert amount into default currency
				if(isset($data['json_value']['wd_requested_bank_currency'])&&$data['json_value']['wd_requested_bank_currency']!=$payout_processing_currency)
				{
					$currencyConverter	= currencyConverter($data['json_value']['wd_requested_bank_currency'], $payout_processing_currency, $data['json_value']['wd_payable_amt_of_txn_to'],0,1);
					$json["currencyConverter"]	= $currencyConverter;
					$trans_amt = $currencyConverter['converted_amount'];	//updated transaction amount
				}
				else
					$trans_amt = $data['json_value']['wd_payable_amt_of_txn_to'];	//original trans amt

				#### - NEW CODE WITHOUT CURL - START

				//fetch payout available_balance from payout_transaction table
				$bal_detail = db_rows_2(
					"SELECT available_balance FROM `{$data['DbPrefix']}payout_transaction`" .
					" WHERE `sub_client_id`='{$trans_result['merID']}' AND `transaction_status`='1' ORDER BY transaction_date DESC LIMIT 1",0
				);
				
				//if balance available then store into available_balance, otherwise set available_balance is 0
				if(isset($bal_detail[0]['available_balance'])){
					$available_balance = $bal_detail[0]['available_balance'];
				}
				else 
					$available_balance = 0;
				
				$available_balance += getNumericValue($trans_amt);	//add transaction amt into balance
				
				$transID	= gen_transID_f($trans_result['merID']);
				
				//create sql query for insert data into payout_transaction table
				$sqlStmt = "INSERT INTO `{$data['DbPrefix']}payout_transaction`(".
				"`transID`, `sub_client_id`, `transaction_type`, `transaction_for`, `transaction_date`, `transaction_currency`, `transaction_amount`, `converted_transaction_currency`, `converted_transaction_amount`, `available_balance`,`sender_name`, `remarks`, `transaction_status`, `related_transID`, `created_date`".
					")VALUES(".
						"'$transID', '{$trans_result['merID']}', '1', '1', '".CURRENT_TIME."','{$data['json_value']['wd_requested_bank_currency']}', '{$data['json_value']['wd_payable_amt_of_txn_to']}', '{$payout_processing_currency}', '{$trans_amt}', '$available_balance','{$trans_result['fullname']}', 'Withdraw For Payout', '1', ".
					"'{$trans_result['transID']}', '".CURRENT_TIME."'".
					")";
				
				//echo "<br /><br />$sqlStmt";
				//exit;
				
				//check transaction in payout transaction already exists or not
				$find_duplicate=db_rows_2(
					"SELECT `related_transID` FROM `{$data['DbPrefix']}payout_transaction`".
					" WHERE `related_transID`='{$trans_result['transID']}' LIMIT 1",0//,true
				);
				
				//if fetch one row with same transaction means already exists 
				if(isset($find_duplicate[0]['related_transID'])&&$find_duplicate[0]['related_transID'])
				{
				
					$msg='Failed! Transaction Failed Duplicate Entry';
				}
				else
				{
					//else insert data into payout transaction table
					db_query_2($sqlStmt);
					$newid=newid_2();	//fetch inserted id
					if($newid)
					{
						$msg='Success! Payout Added successfully - Transaction ID : '.$newid;
					}
				}
			
				#### - NEW CODE WITHOUT CURL - END
				?>
				<script> 
					alert("<?=@$msg;?>");
				popupclose();
				</script>
				<?
				//$redurl = "{$data['Admins']}/payout-transaction{$data['ex']}";
				//header("Location:".$redurl);
				exit;
			}
		}
	}
	exit;
//=================New Condation

}elseif($post['action']=='upd_status'){	//change status of transaction
	//echo $post['upd_status'];
	//echo $post['gid'];
	//echo $post['actual_status'];
	
	update_trans_ranges(-1, $post['upd_status'], $post['gid']);	//update status of a transaction
	$_SESSION['action_success']='Trans Status update Successfully';
	header("Location:{$data['Admins']}/{$data['trnslist']}".$data['ex']);
	exit;
	
	
}elseif($post['action']=='upd_response_amt'){	//change status transaction and update response amount as a transaction amount if difference between request and response amount


	######################################################################

		// Swich to more db connection via include/u_78.do?pq=1&DB_CON=2&db_ad=1

		$dbad_link_2='';
		if((isset($data['DB_CON'])&&isset($_REQUEST['DB_CON'])&&$_REQUEST['DB_CON'])&&(!isset($data['IS_DBCON_DEFAULT'])|| $data['IS_DBCON_DEFAULT']!='Y')){

			$DB_CON=@$_REQUEST['DB_CON'];
			$db_ad=@$_REQUEST['db_ad'];
			$db_mt=@$_REQUEST['db_mt'];

			$link_db=config_db_more_check_link($DB_CON,$db_ad,$db_mt);
			$dbad_link_2=$link_db['dbad_link_2'];
			//$dbad_link_2 .=$link_db['dbad_link'].$link_db['dbad_link_2'];

			
		}

	########################################################

	$admin_user_name='';
	if(isset($_SESSION['adm_login'])){
		if(isset($_SESSION['sub_username'])&&$_SESSION['sub_username']){
			$admin_name = " by ".@$_SESSION ['sub_username']." ".@$_SESSION['sub_admin_fullname'];
			$admin_user_name=@$_SESSION ['sub_username']."_".@$_SESSION['sub_admin_fullname'];
		}else{
			$admin_name = 'by Admin';
			$admin_user_name='Admin';
		} 
		$admin_name="{$admin_name} - ( From IP: <font class=ip_view>".$data['Addr']."</font> )";
		$name=$admin_name;
	}

	
		/*echo "<br />1--".$post['upd_status'];
		echo "<br />2--".$post['gid'];
		echo "<br />3--".$post['actual_status'];
		echo "<br />4--".$post['new_remark'];
	    echo "<br />4--".$post['new_amount'];*/
	
	
	$append_qry='';
	if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'){
		$tst=select_tablef("`id`='{$post['gid']}'",$data['MASTER_TRANS_TABLE'],0,1,'`bank_processing_amount`,`bill_amt`,`trans_status`,`transID`,`acquirer`');
		
		$tst_ad=select_tablef("`id_ad`='{$post['gid']}'",$data['ASSIGN_MASTER_TRANS_ADDITIONAL'],0,1,'`support_note`,`json_value`');
		
		if(isset($tst)&&isset($tst_ad))
			$tst=array_merge($tst,$tst_ad);
		
	}
	else {
		$tst=select_tablef("`id`='{$post['gid']}'",$data['MASTER_TRANS_TABLE'],0,1,'`support_note`,`bank_processing_amount`,`bill_amt`,`trans_status`,`transID`,`acquirer`,`json_value`');
	}
	
	//$bank_processing_amount=$tst['bank_processing_amount'];
	//$diff=$bank_processing_amount-$post['new_amount'];

	$rmk_date=date('d-m-Y h:i:s A');
	
	//$post['new_remark'].="<br />Difference between transaction Bill Amt ($bank_processing_amount) and updated Bill Amt ({$post['new_amount']}) is <b>$diff</b>";
	
	$current_status=$data['TransactionStatus'][$tst['trans_status']];
	$upd_status=$data['TransactionStatus'][$post['upd_status']];
	
	$trans_response=$upd_status." - ".$post['new_remark'];

	if(isset($post['new_amount'])&&$post['new_amount']>0)
	{	
		$post['new_amount']=number_formatf2($post['new_amount']);
		$append_qry=" `bill_amt`='".$post['new_amount']."', ";
		
		$post['new_remark']="Trans is Bill Amt ({$tst['bill_amt']}) and received Bill Amt ({$post['received_amount']}). Trans is Bill Amt updated to (<b>{$post['new_amount']}</b>) | current trans_status ({$current_status}) and updated to (<b>{$upd_status}</b>)".((isset($post['new_remark'])&&$post['new_remark'])?" | <i><b>".$post['new_remark']."</b></i>":'')." via $name.";
		
	}
	else
	{
		$post['new_remark']="Trans is current trans_status ({$current_status}) and updated to (<b>{$upd_status}</b>)".((isset($post['new_remark'])&&$post['new_remark'])?" | <i><b>".$post['new_remark']."</b></i>":'')." via $name.";
	}
	

	$remark_upd	= "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$post['new_remark']." </div></div>".$tst['support_note'];
	



	
	// query update for master_trans_additional
	$additional_update=$master_update=", `support_note`='{$remark_upd}', `trans_response`='{$trans_response}' ";
	
	if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'){
		$master_update='';
		$additional_update=ltrim($additional_update,',');
		db_query("UPDATE `{$data['DbPrefix']}{$data['ASSIGN_MASTER_TRANS_ADDITIONAL']}` SET ".$additional_update." WHERE `id_ad`='".$post['gid']."' ",0); 
	}
	
	$sqlStmt = "UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` SET ".$append_qry." `trans_status`='0' ".$master_update." WHERE `id`='".$post['gid']."' ";
	//echo $sqlStmt;exit;
	db_query($sqlStmt,0);
	
	
	
	//echo "<br/><br/>remark_upd=>"; print_r($remark_upd); echo "<br/><br/>_POST=>"; print_r($_POST); echo "<br/><br/>new_remark=>".$post['new_remark']; exit;
	
	if($tst['trans_status']==1&&in_array($post['upd_status'],["22","23","10"]))
	{
		$upd_status_get=$post['upd_status'];
		$post['upd_status']=2;
	}
	
	//Dev Tech : 23-12-16 Webhook and email update via callback as a retrun url 
	
	$acquirer_status_code=@$_POST['upd_status'];
	if(isset($_POST['upd_status'])&&$_POST['upd_status']==1) $acquirer_status_code=2; //success
	elseif(isset($_POST['upd_status'])&&$_POST['upd_status']==0) $acquirer_status_code=1; //pending
	elseif(isset($_POST['upd_status'])&&$_POST['upd_status']==2) $acquirer_status_code=-1; //failed
	//else $acquirer_status_code=-1; //other wise failed

	$data_send=array();
	$data_send['transID']=$transID=@$tst['transID'];
	$data_send['acquirer_action']=1;
	$data_send['acquirer_response']=$trans_response;
	$data_send['acquirer_status_code']=@$acquirer_status_code;
	//$data_send['acquirer_transaction_id']=(isset($_SESSION['acquirer_transaction_id'])?$_SESSION['acquirer_transaction_id']:'');
	//$data_send['acquirer_descriptor']=(isset($_SESSION['acquirer_descriptor'])?$_SESSION['acquirer_descriptor']:'');
	$data_send['acquirer']=@$tst['acquirer'];
	
		//$data_send['cron_tab']='cron_tab';
		//$data_send['admin']='1';

	$data_send['cron_host_response']=@$admin_user_name;
	$data_send['cron_tab']='cron_tab';
	$data_send['action']='webhook';
	$data_send['acquirer_retrun_json_response']='Y';
	//$data_send['CURLOPT_HEADER']='1';

	$data_send['session_destroy']='N';
	
	
	//pq
	//$_SESSION=array_merge($_SESSION,$data_send);$data_send['CURLOPT_HEADER']='1';
	
	if(isset($tst['json_value'])&&@$tst['json_value']){
		$json_value_gt=jsondecode(@$tst['json_value'],1,1);
		if(isset($json_value_gt['hostUrl']))$hostUrl=@$json_value_gt['hostUrl'];
	}
	
	if(isset($hostUrl)&&trim($hostUrl)) $host_path=$hostUrl;
	else $host_path=$data['Host'];
	
	$r2=''; 
	
	/*
	$subQuery="&destroy=2&actionurl=admin_direct&cron_tab=cron_tab";
	
	if(isset($_SESSION['DB_CON']))
		$subQuery .= "&DB_CON=".@$_SESSION['DB_CON'];
	if(isset($_SESSION['db_ad']))
		$subQuery .= "&db_ad=".@$_SESSION['db_ad'];
	if(isset($_SESSION['db_mt']))
		$subQuery .= "&db_mt=".@$_SESSION['db_mt'];
	
	//$subQuery .= "&a=cs&dtest=2&cqp=1";
	*/
		
	@$subQuery='&action=webhook&session_destroy=N&destroy=2&acquirer_retrun_json_response=Y&cron_tab=cron_tab&cron_host_response='.@$admin_user_name.@$dbad_link_2;
	
	$data_send = strip_tags_d($data_send);
	
	$return_url = $host_path."/return_url{$data['ex']}?transID=".$transID.$subQuery;
	
	$return_url=str_replace(" ","+",$return_url);

	//echo "<br/><br/>data_send=>"; print_r($data_send); echo "<br/><br/>_POST=>"; print_r($_POST); echo "<br/><br/>return_url=>".$return_url; exit;

if(isset($post['re_direct_url'])&&trim($post['re_direct_url'])) 
	$re_direct_url=curl_url_replace_f($post['re_direct_url']);
else { 
	$re_direct_url="{$data['Admins']}/{$data['trnslist']}".$data['ex'];
	$re_direct_url=curl_url_replace_f($re_direct_url);
}

if(isset($_REQUEST['qp'])||isset($_REQUEST['dtest']))
{
	$re_direct_url='';
	echo "<br/><br/>re_direct_url=>"; print_r($re_direct_url); 
	echo "<br/><br/>data_send=>"; print_r($data_send); 
}
else {
	include($data['Path']."/payin/loading_icon".$data['iex']);
}

$data_send_json_encode=json_encode(@$data_send);
echo "
<div id='trans_url_load_content_2'></div>
<script src='{$data['Host']}/js/jquery-3.6.0.min.js'></script>
<script>
var re_direct_url='{$re_direct_url}';
$(document).ready(function() {
$('#trans_url_load_content_2').load('{$return_url}', {$data_send_json_encode}, function(responseText_2, statusTxt_2, jqXHR_2){
	console.log('responseText_2'); console.log(responseText_2);
	if(re_direct_url){ top.window.location.href=re_direct_url; }
	
});
});
</script>
";
	

	//if(!empty($return_url)&&trim($return_url)) $use_curl=use_curl($return_url,$data_send);
	
	if(isset($_REQUEST['qp'])||isset($_REQUEST['dtest']))
	{
		 exit;
	}
	

/*
	update_trans_ranges(-1, $post['upd_status'], $post['gid']);	//update trans_status of a transaction
	
	if($tst['trans_status']==1&&in_array($upd_status_get,["22","23","10"])&&isset($upd_status_get))
	{
		$sqlStmt2 = "UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` SET `trans_status`='{$upd_status_get}'  WHERE `id`='".$post['gid']."' ";
		db_query($sqlStmt2,0);
	}
	
	
*/	
	
	
	
	//if(isset($post['re_direct_url'])&&trim($post['re_direct_url'])) header("Location:{$post['re_direct_url']}");
	//else header("Location:{$data['Admins']}/{$data['trnslist']}".$data['ex']);
	exit;
	
	
//=================End New Condation
}elseif($post['action']=='transaction_display'){	//update subadmin json
	
	$_SESSION['transaction_display_arr']=$post['transaction_display'];
	
	$_SESSION['transaction_display']=('"'.implodes('","',($post['transaction_display'])).'"');
	$_SESSION['display_json']['transaction_display']=[implodes('","',($post['transaction_display']))];
	$display_json=json_encode($_SESSION['display_json']);
	
	echo "<br/><br/>transaction_display_arr=>"; print_r($_SESSION['transaction_display_arr']); echo "<br/><br/>";
	echo "<br/><br/>display_json=>".$display_json."<br/><br/>";
	exit;
	
	if(isset($_SESSION['admin_id'])&&$_SESSION['admin_id']){
		$admin_id=$_SESSION['admin_id'];
	}else{
		$admin_id=$_SESSION['sub_admin_id'];
	}
	
	if($admin_id){
		db_query(
			"UPDATE `{$data['DbPrefix']}subadmin`".
			" SET `display_json`='{$display_json}'".
			" WHERE `id`={$admin_id}"
		);
	}else{
		
		$str_w=
			"<?\n".
			"##############################\n".
			"\$display_json='{$display_json}';\n".
			"##############################\n".
			
		"?>"
		;
		$file=@fopen("../log/display_json{$data['iex']}", "w");
		if($file){
			@fwrite($file, stripslashes($str_w)); 
			@fclose($file);
		}else{
			$data['Message']='Update configuration parameters failed. Check write permissions for file "display_json'.$data['ex'].'".';
		}
		
	}
	
	//echo "<br/>rurl=>".$post['rurl'];
	
	header("Location:".$post['rurl']);
	exit;
	
}elseif($post['action']=='confirm2'){	//change status to confirm/approve
		db_query(
			"UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" SET `trans_status`=0".
			" WHERE `id`='{$post['gid']}'"
		);
		update_trans_ranges(-1, 1, $post['gid']);		//update status of a transaction
		exit;
}elseif($post['action']=='cancel'){	//change status to cancel / decline
		//if($post['acquirer']==2){		}
		
		

		if(isset($_REQUEST['type'])&&in_array($_REQUEST['type'],[2,3,4])&&isset($_REQUEST['csov3'])&&$_REQUEST['csov3']==1&&isset($data['CUSTOM_SETTLEMENT_OPTIMIZER_V3'])&&isset($data['CUSTOM_SETTLEMENT_WD_V3'])&&$data['CUSTOM_SETTLEMENT_WD_V3']=='Y'){
			$custom_settlement_optimizer_v3=1;
			
		}
		else{
			 $custom_settlement_optimizer_v3=0;
			 
		}
		
		
	
		//update_trans_ranges(-1, 2, $post['gid']);		//update status of a transaction
		$canc=update_trans_ranges(-1, 2, $post['gid'], '',  1,  1, '', $custom_settlement_optimizer_v3);

		exit;
}elseif($post['action']=='tran_bal_upd'){
		m_bal_update_trans($_GET['bid'], $_GET['id']);		//update balance
		exit;
}elseif($post['action']=='refresh_tran_available_balance'){
		//$_GET['tr_bal_upd']='submit';
		m_bal_update_trans($_GET['bid'], 0,'update_available_balance');		//update balance
		exit;
}elseif($post['action']=='update_tr_count'){	//update total transaction of a merchant
		echo "NA.NA";
		exit;
}elseif($post['action']=='update_clients_balance'){	//update clients balance
		db_query("UPDATE `{$data['DbPrefix']}clientid_table`"." SET `available_balance`='{$_GET['balance']}',`available_rolling`='{$_GET['rolling_bal']}' WHERE `id`={$post['bid']}");
		exit;
}elseif($post['action']=='manual_adjust_balance'){	//manually adjust balance and update if any difference
		$mab_size="1";
		$clients=select_client_table($post['bid']);
		if(!empty($clients['manual_adjust_balance_json']))
		{
		$mab_json_get=$clients['manual_adjust_balance_json'];
		$mab_json_get=json_decode($mab_json_get,true);
		}
		else $mab_json_get = array();
	
		$mab_json_get_count=count($mab_json_get);
		if($mab_json_get_count){
			$mab_size=(prnsum($mab_json_get_count)+prnsum($mab_size));
		}
		
		
		
		$mabj[$mab_size]['balance_amount']=$post['balance_amount'];
		$mabj[$mab_size]['note']=$post['balance_note'];
		$mabj[$mab_size]['cdate']=date('Y-m-d H:i:s');
		if($mab_json_get){$mabj=array_merge($mab_json_get,$mabj);}
		$mab_json=json_encode($mabj);
		db_query("UPDATE `{$data['DbPrefix']}payin_setting`"." SET `manual_adjust_balance`='{$post['balance_amount']}',`manual_adjust_balance_json`='{$mab_json}' WHERE `clientid`='".$post['bid']."'");
		header("location:".$post['aurl']);
		exit;
}elseif($post['action']=='cbk1'){
		update_trans_ranges(-1, 11, $post['gid']);
		exit;
}elseif($post['action']=='refund'){	//refund process section
		$refund_qry=true;
		//$tr_st=$td=	select_table_details($post['gid'],$data['MASTER_TRANS_TABLE'],0);	//fetch data from master_trans_table 
		$tr_st=$td=trans_db($post['gid']);	//fetch data from master_trans_table 
		
		$transID=$td['transID'];//reply_remark
		$system_note=$td['system_note'];//reply_remark
		
		$jsn=@$td['json_value'];

		$json_value=jsondecode($jsn,true,1);
		if(isset($json_value['post'])&&isset($json_value['get'])&&is_array($json_value['post'])&&is_array($json_value['get']))
					$json_value['post']=array_merge($json_value['post'],$json_value['get']);
		if(isset($json_value)&&is_array($json_value)) $json_value=htmlTagsInArray($json_value);
		
		
		$paramsInfo=array();
		//$paramsInfo['refundCurrency']=$td['bill_currency'];
		$paramsInfo['refundCurrency']=$td['bank_processing_curr'];
		$paramsInfo['refundAmount']=$td['bill_amt'];
		$paramsInfo['busCurrency']=$td['bill_currency']; //bank_processing_curr

		if($td['bank_processing_amount']!="0.00"&&!empty($td['bank_processing_amount'])){
			$paramsInfo['refundAmount']=$td['bank_processing_amount'];
		}else{
			$paramsInfo['refundAmount']=$td['bill_amt'];
		}
		$acquirer_ref=$td['acquirer_ref'];
		$refundAmount=$paramsInfo['refundAmount'];


		echo "<br/><br/>transID=>".$transID."<br/><br/>";
		
		if(isset($_REQUEST['dtest'])||isset($_REQUEST['pq'])||isset($_REQUEST['qp']))
		{  $qp=1; }
		
		if(isset($tr_st)&&is_array($tr_st)){
						
			$jsn_tr=@$tr_st['json_value'];
			//if(isset($qp)&&$qp){ echo "<hr>jsn_tr=><br />"; echo $jsn_tr;}
			$json_value_tr=jsondecode($jsn_tr,true,1);
			if(isset($json_value_tr)&&is_array($json_value_tr)) $json_value_tr=htmlTagsInArray($json_value_tr);
			if(isset($tr_st['acquirer_creds_processing_final'])&&trim($tr_st['acquirer_creds_processing_final']))
				$acquirer_creds_processing_final=jsondecode($tr_st['acquirer_creds_processing_final'],1,1);

			if(isset($acquirer_creds_processing_final)&&is_array($acquirer_creds_processing_final)){
				$apJson = $acquirer_creds_processing_final;
				$step_apc_get='1. acquirer_creds_processing_final';
			}else if(isset($json_value_tr['acquirer_processing_json'])&&is_array($json_value_tr['acquirer_processing_json'])){
				$apJson = $json_value_tr['acquirer_processing_json'];
				$step_apc_get='2. acquirer_processing_json';
			}elseif(isset($json_value_tr['acquirer_processing_creds'])&&is_array($json_value_tr['acquirer_processing_creds'])){
				$apJson = $json_value_tr['acquirer_processing_creds'];
				$step_apc_get='3. acquirer_processing_creds';
			}

			//echo "<hr>apJson=><br />";print_r($apJson);
			$apc_get=@$apJson;
			if(isset($qp)&&$qp){
				
				echo '<div type="button" class="btn btn-success my-2" style="background: #fff2d4;color:#2c2c2c;padding:5px 10px;border-radius:2px;margin:10px auto;width:fit-content;display:block;max-width:99%;">';
				
				echo "<hr>step apc_get=> ".@$step_apc_get;
				echo "<hr>apc_get=><br />";print_r(@$apc_get);
				
				if($qp==2) { 
					echo "<hr>json_value=><br />"; print_r(htmlentitiesf(@$json_value_tr)); 
				}
				
				echo '<br/><br/></div>';
			}

		}
		
		
		$post['acquirer']=@$_REQUEST['acquirer'];
		
		//if account acquirer is not empty then fetch refund url from bank gateway table
		if($post['acquirer']>0){
			$bank_getway_db=db_rows(
				"SELECT * FROM {$data['DbPrefix']}acquirer_table".
				" WHERE `acquirer_id`=".$post['acquirer'].
				" ORDER BY id DESC LIMIT 1"
			);
			$bank_get=$acquirer_table=$bank_getway_db[0];
			//$acquirer_descriptor=$bank_get['acquirer_descriptor'];
			$bank_mer_setting_json_arr=jsondecode($bank_get['mer_setting_json'],1,1);
		}
		
		$default_acquirer=@$bank_get['default_acquirer'];
		
		$acquirer_prod_mode=@$bank_get['acquirer_prod_mode'];
		$acquirer_uat_url=@$bank_get['acquirer_uat_url'];
		$acquirer_status_url=@$bank_get['acquirer_status_url'];
		
		$acquirer_refund_url=@$bank_get['acquirer_refund_url'];
		
		
		
		//if trans_status is 8 (refund requested) then define respective refund path
		if($tr_st['trans_status']==8){
			
			//Dev Tech : 23-08-26 Dynamic refund url set 
			if(isset($bank_get['acquirer_refund_policy'])&&in_array($bank_get['acquirer_refund_policy'],["Full Refund only","Full & Partial Both","Manual Processing"])){
				
				//refund url
				$refund_url_file=$data['Path']."/payin/pay{$default_acquirer}/refund_{$default_acquirer}".$data['iex'];
				if(file_exists($refund_url_file)){
					//echo "<br/><br/>find refund_url_file=>".$refund_url_file;
					include($refund_url_file);
				}
				else {
					echo "<br/><br/>not found refund_url_file=>".$refund_url_file;
					//exit;
				}
				
			}
			
			//exit;
			
			if(isset($live_refund_status)&&@$live_refund_status=='N')
			{
				
				$post_reply="Update Refund Manually";
				$refund_qry=false;
				if(isset($_GET['update_refund_manually'])){
					$refund_qry=true;
					$live_refund_status='Y';
				}else{
					
					$refund_qry_db=false;

					$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
					$urlpath=$protocol.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
				?>
					<a target="hform" onclick="javascript:top.popuploadig();" href="<?=$urlpath."&update_refund_manually=1";?>" class="upd_status" style="outline:0px !important;color:rgb(0, 102, 204);text-decoration:none;cursor:pointer;float:none;display: block;clear:both;width:90%;text-align:center;margin:100px auto 15px auto;line-height:30px;border-radius:3px;background-color:rgb(223, 240, 216);font-size:16px;font-family:'Open Sans', sans-serif;font-style:normal;font-variant-ligatures: normal;font-variant-caps:normal;font-weight: 400;letter-spacing: normal;orphans:2;text-indent:0px;text-transform:none;white-space: normal;widows:2;word-spacing:0px;-webkit-text-stroke-width:0px;">Update Refund Manually</a>
					
				<? exit;
				}	
				
			}
			
			if(isset($live_refund_status)&&@$live_refund_status=='Y')
			{
				
				if(isset($_SESSION['adm_login'])){
					if(isset($_SESSION['sub_username'])&&$_SESSION['sub_username']){
						$admin_name = " by ".$_SESSION ['sub_username']." ".$_SESSION['sub_admin_fullname'];
					}else{
						$admin_name = 'by Admin';
					} 
					$admin_name="{$admin_name} - ( From IP: <font class=ip_view>".$data['Addr']."</font> )";
					
				}
				
				$reply_date=date('d-m-Y h:i:s A');
				$reply_remark = "<div class=rmk_row><div class=rmk_date>".$reply_date."</div><div class=rmk_msg>".@$post_reply." via ".@$admin_name."</div></div>".@$system_note;
			
				// query update for master_trans_additional
				$additional_update=$master_update="`system_note`='{$reply_remark}'";
				
				if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y')
				{
					$master_update='';
					$additional_update=ltrim($additional_update,',');
					db_query("UPDATE `{$data['DbPrefix']}{$data['ASSIGN_MASTER_TRANS_ADDITIONAL']}` SET ".$additional_update." WHERE `id_ad`='".$post['gid']."' ",0); 
				}
				else 
				{
					db_query(
						"UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
						" SET ".$master_update.
						" WHERE `id`={$post['gid']}"
					);
				}
			}
			
			echo "<br/><br/>refund_qry=>".$refund_qry;
			if(isset($live_refund_status)) echo "<br/><br/>live_refund_status=>".$live_refund_status;
			
			//fee calculate and reverse trans 
			if($refund_qry==true || (isset($live_refund_status)&&@$live_refund_status=='Y')){
				update_trans_ranges(-1, 3, $post['gid']);
			}
			
			//exit;
			
			if(isset($live_refund_status)&&@$live_refund_status=='Y')
			{
			?>
				<a onclick="javascript:top.popupclose();" class="upd_status" style="outline:0px !important;color:rgb(0, 102, 204);text-decoration:none;cursor:pointer;float:none;display: block;clear:both;width:90%;text-align:center;margin:100px auto 15px auto;line-height:30px;border-radius:3px;background-color:rgb(223, 240, 216);font-size:16px;font-family:'Open Sans', sans-serif;font-style:normal;font-variant-ligatures: normal;font-variant-caps:normal;font-weight: 400;letter-spacing: normal;orphans:2;text-indent:0px;text-transform:none;white-space: normal;widows:2;word-spacing:0px;-webkit-text-stroke-width:0px;">Refund Successful</a>
				<script>
					setTimeout(function(){ 
						top.popupclose();
					},900); 
				</script>
			<?}

		
		}else{
			echo "This transaction is already refunded!!!";
			//print_r($tr_st['status']);
			exit;
		}
		exit;
}elseif($post['action']=='returned'){	//update status to returned (6)
		update_trans_ranges(-1, 6, $post['gid']);
		exit;
}elseif($post['action']=='refund_request'){	//update status to refund request (8)
		$get_sts=update_trans_ranges(-1, 8, $post['gid']);
		closeModal($post['gid'],$get_sts['transID']);
		exit;
}elseif($post['action']=='reminder'){	//update status reminder
		update_trans_ranges(-1, 512, $post['gid']);
		//header($re_url);
}elseif($post['action']=='reminders_range'){		//update status reminder
		$trange = $_GET['trange'];
		update_trans_ranges(-1, 512, $trange);
		exit;
		//header($re_url);
}elseif($post['action']=='authorization_range'){	//update authorization_range (712)
		$trange = $_GET['trange'];
		update_trans_ranges(-1, 712, $trange);
		exit;
		//header($re_url);
}elseif($post['action']=='action_require'){		//update status to action require (513)
        //update_transaction_status(-1, $post['gid'], 513);
		update_trans_ranges(-1, 513, $post['gid']);
		//header($re_url);
}elseif($post['action']=='testransaction'){		//set status as Test transaction (9)
        //update_transaction_status(-1, $post['gid'], 9);
		update_trans_ranges(-1, 9, $post['gid']);
		//header($re_url);
}elseif($post['action']=='chargeback'){	//update charge back
	//$tr_chargeback=	select_table_details($post['gid'],$data['MASTER_TRANS_TABLE'],0);	//fetch transaction detail
	$tr_chargeback=select_tablef("`id` IN ({$post['gid']})",$data['MASTER_TRANS_TABLE'],0,1,'`trans_status`'); //fetch trans_status from transaction table 
					
	//print_r($tr_chargeback['trans_status']); echo "<br/>gid=>".$post['gid'];exit;
	
	if($tr_chargeback['trans_status']==1){
		update_trans_ranges(-1, 5, $post['gid']);	//if status 1 (success) update charge back (status 5)
		db_disconnect();
		
		//as per request connection if multiple 
		if(isset($data['DB_CON'])&&isset($_REQUEST['DBCON'])&&trim($_REQUEST['DBCON'])&&function_exists('config_db_more_connection'))
		{
			db_disconnect_psql();
			db_disconnect_mysqli();
		}
		exit;
	}elseif($tr_chargeback['trans_status']==5||$tr_chargeback['trans_status']==7){	// if status 5 or 7 means already chargeback
		echo "This transaction is already chargeback!!!";
		exit;
	}else{
		echo "Oops.. refresh your page. ";
		exit;
	}
}elseif($post['action']=='completedall'){	//update detail as transaction complete (status 1 success)
		$trange = $_GET['trange'];
        //update_transaction_status(-1, $post['gid'], 1, $trange);
		//update_transaction_range(1, $trange);
		update_trans_ranges(-1, 1, $trange);
		//header($re_url);
}elseif($post['action']=='selltedall'){	//update settlement
		$trange = $_GET['trange'];
        //update_transaction_status(-1, $post['gid'], 4, $trange);
		//update_transaction_range(4, $trange);
		update_trans_ranges(-1, 4, $trange);
		//header($re_url);
}elseif($post['action']=='payoutsellted'){	//update payout settlement
		$trange = $_GET['trange'];
        //update_transaction_status(-1, $post['gid'], 4, $trange);
		if(!empty($_GET['pdate']) && !empty($post['bid'])){
			$pdate  = date('Y-m-d',strtotime($_GET['pdate']));
			$frmpdate = date("Y-m-d",strtotime("-$payoutdays day",strtotime($pdate)));//-17
			$topdate = date("Y-m-d",strtotime("+7 day",strtotime($frmpdate)));//+8
			
			$type_whr="";
			if((isset($_GET['acquirer'])&&!empty($_GET['acquirer']))&&($_GET['acquirer']==11)){
				$type_whr=" `acquirer`=11 AND ";
			}elseif((isset($_GET['acquirer'])&&!empty($_GET['acquirer']))&&($_GET['acquirer']!=11)){
				$type_whr=" `acquirer`!=11 AND ";
			}
			
			$payoutsellt = $type_whr." `merID`={$post['bid']} AND tdate between '".$frmpdate."' AND '".$topdate."' ";
			
			//echo $payoutsellt; 
			//update_transaction_range(4, '', $payoutsellt, $post['bid']);
			update_trans_ranges($post['bid'], 4, '', $payoutsellt);
		}
}elseif($post['action']=='flagransaction'){		//flag transaction (status 611)
		update_trans_ranges(-1, 611, $post['gid']);
}elseif($post['action']=='unflagransaction'){	//unflag transaction (status 612)
		update_trans_ranges(-1, 612, $post['gid']);
}elseif($post['action']=='wd_view_acc'){	//update json log
		json_log_upd($post['gid'],$data['trnslist'],'action');
		//echo "wd_view_acc: ".$post['gid'];
		exit;
}
###############################################################################
if($post['action']=='select'){	//if action is select then create search query
        if(isset($post['bid'])&&$post['bid']){
	   		$post['MemberInfo']=get_clients_info($post['bid']);	//fetch clients info
		 	//print_r($post['MemberInfo']);
		 	//print_r($post['MemberInfo']['settlement_optimizer']);
		 	$_SESSION['settlement_optimizer']=$post['settlement_optimizer']=@$post['MemberInfo']['settlement_optimizer'];
			
			$uid=$post['bid'];	

					

			$acquirer_map=[];

			if (isset($_REQUEST['acquirer']) && $_REQUEST['acquirer'] && $_REQUEST['acquirer'] !== "-1") {
				// Check if acquirer is an array; if not, convert it to an array
				$acquirer_map = is_array($_REQUEST['acquirer']) ? $_REQUEST['acquirer'] : [$_REQUEST['acquirer']];
				
				// Convert all values to integers
				$acquirer_map = array_map('intval', $acquirer_map);
				
				
			} 

			// Check if the array contains either 2 or 3
			if((isset($acquirer_map)&&(in_array(2,$acquirer_map,true)||in_array(3,$acquirer_map,true)))&&(isset($data['CUSTOM_SETTLEMENT_WD_V3'])&&$data['CUSTOM_SETTLEMENT_WD_V3']=='Y')&&(isset($post['settlement_optimizer'])&&(strtolower($post['settlement_optimizer'])=='custom'||strtolower($post['settlement_optimizer'])=='weekly'))) {
				//print_r($_REQUEST['acquirer']);
				$custom_settlement_wd_v3=1;
			} 
			else $custom_settlement_wd_v3=0;

			

			if(isset($data['custom_settlement_wd_v3_is_1'])&&@$data['custom_settlement_wd_v3_is_1']==1)
				@$custom_settlement_wd_v3=@$data['custom_settlement_wd_v3_is_1'];

			if(isset($_REQUEST['dtest']))
			{
				echo "<hr/><h4 style='font-size:22px!important;font-weight:bold;color:#3a8411;'>settlement_optimizer=> ".@$post['settlement_optimizer']."</h4>";
				echo "<br/><br/>The custom_settlement_wd_v3=>".@$custom_settlement_wd_v3;
				echo "<br/><br/>CUSTOM_SETTLEMENT_WD_V3=>".@$data['CUSTOM_SETTLEMENT_WD_V3'];
				echo "<br/><br/>acquirer_map=>";print_r(@$acquirer_map);
				echo "<br/><hr/><br/>";
			}
			

			
			
			if(isset($_GET['cl'])){
				include('../include/riskratio_code'.$data['iex']);
			}
			
			if(!$post['MemberInfo'])unset($post['bid']);
			
		$MaxRowsByPage=100;	//set maximum rows in page
        }else{
		$MaxRowsByPage=50;	//set maximum rows in page
		}
		//echo 'bid: '.$post['bid'];exit;
        $where=array();
		$orderby=" `t`.`tdate`"; // amount
		
		$reportdate = ""; 
		$keyname=-1;if(isset($_GET['keyname'])){$keyname=$_GET['keyname'];}
		$searchkey="";if(isset($_GET['searchkey'])){$searchkey=trim($_GET['searchkey']);$searchkey=strtolower($searchkey);}

        if($post['status']>=0)$where[]=" (t.trans_status={$post['status']})";
		
	//make the query string
		$acquirer=1;
		if($post['acquirer']=='35s'){
			$post['acquirer']=-10;
			$reportdate .= " AND ( t.acquirer IN (35,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380) )";
			$where[]	= " ( t.acquirer IN (35,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380) ) ";
			$acquirer=0;
		}
		elseif($post['acquirer']=='38s'){
			$post['acquirer']=-10;
			$reportdate .= " AND ( t.acquirer IN (38,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410) )";
			$where[]	= " ( t.acquirer IN (38,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410) ) ";
			$acquirer=0;
		}
		elseif($post['acquirer']=='34s'){
			$post['acquirer']=-10;
			$reportdate .= " AND ( t.acquirer IN (34,341,342,343,344,345,346,347,348,349,350) )";
			$where[]	= " ( t.acquirer IN (34,341,342,343,344,345,346,347,348,349,350) ) ";
			$acquirer=0;
		}
		elseif($post['acquirer']=='37s'){
			$post['acquirer']=-10;
			$reportdate .= " AND ( t.acquirer IN (37,371,372,373,374,375,376,377,378,379,380) )";
			$where[]	= " ( t.acquirer IN (37,371,372,373,374,375,376,377,378,379,380) ) ";
			$acquirer=0;
		}
		elseif($post['acquirer']=='latestApi'){
			$post['acquirer']=-10;
			$reportdate .= " AND ( t.acquirer IN (34,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410) )";
			$where[]	= " ( t.acquirer IN (34,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410) ) ";
			$acquirer=0;
		}
        elseif(($post['acquirer']>=0)&&($acquirer)){
			
			$where[]=" (t.acquirer={$post['acquirer']}) ";
		}
		
        if(isset($post['bid']) && $post['bid']){
//			$where[]=" (t.sender={$post['bid']} OR t.merID={$post['bid']})";
			$where[]=" (t.`merID`='".$post['bid']."')";
			if(isset($_GET['ptdate'])&&$_GET['ptdate']){
				
				$ptdate=date('Y-m-d',strtotime($_GET['ptdate']));
				
				
				if(isset($_GET['pfdate'])&&$_GET['pfdate']){
					$ptdate=array();
					$ptdate['date_1st']=date('Y-m-d',strtotime($_GET['pfdate']));
					$ptdate['date_2nd']=date('Y-m-d',strtotime($_GET['ptdate']));
				}
				
				if(isset($_GET['cl'])){
				$post['ab']=account_balance($post['bid'],"",$ptdate);	//fetch account balance with in period
				$post['mbt']=account_trans_balance_calc($post['bid'],$ptdate);	//calculate account balance with in period
				$post['mbt_d']=account_trans_balance_calc_d($post['bid'],$ptdate);	//calculate account rolling balance with in period
				}
			}else{
				if(isset($_GET['cl'])){
				$post['ab']=account_balance($post['bid']);	//fetch account balance
				$post['mbt']=account_trans_balance_calc($post['bid']);	//calculate account balance
				$post['mbt_d']=account_trans_balance_calc_d($post['bid']);	//calculate account rolling balance
				}
			
				/*
				$monthly_fee=payout_trans($post['bid']);
				$post['mfee']=$monthly_fee['total_monthly_fee'];
				$post['monthly_vt_fee_max']=$monthly_fee['per_monthly_fee'];
				$post['count_monthly_vt_fee']=$monthly_fee['total_month_no'];
				*/
			}
			
		}
		if(isset($post['order'])&&!empty($post['order']))$orderby=" t.".$post['order']."";
		
		if( (($post['status']<0)&&(!isset($post['bid']))&&(!isset($_GET['keyname']))) ){
			$fpdate = date("Y-m-d",strtotime("-10 day",strtotime(date("Y-m-d"))));
			$tpdate = date("Y-m-d",strtotime("+2 day",strtotime(date("Y-m-d"))));
			if(($post['acquirer']>0)){$fpdate = date("Y-m-d",strtotime("-30 day",strtotime(date("Y-m-d"))));}
			
		} 
		
	// create query string as search keyname and searchkey - 
	// Note: keyname array defined in function_raj.do
		if(isset($_GET['keyname'])&&($keyname>0)&&($searchkey)){
			if($keyname==1){
				if(strpos($searchkey,',')!==false){
					$reportdate .= " AND ( t.transID IN (".$searchkey.") )";
					$where[]	= " ( t.transID IN (".$searchkey.") ) ";
				}else{
					$reportdate .= " AND ( t.transID IN (".$searchkey.") )";
					$where[]	= " ( t.transID IN (".$searchkey.") ) ";
				}
			}elseif($keyname==2){
				$que=queryArrayf($searchkey,'`t`.`fullname`','LIKE','OR',';',0);
				$reportdate .= " AND ({$que}) ";
				$where[]	= " ( {$que}  ) ";
			}elseif($keyname==3){
				//$que=queryArrayf($searchkey,'t.bill_email','LIKE','OR',';');
				
				$search_key2=impf($searchkey,2);
				$que= "`t`.`bill_email` IN ({$search_key2})  ";
				
				$reportdate .= " AND ({$que}) ";
				$where[]	= " ( {$que}  ) ";
			}elseif($keyname==4){
				$que=queryArrayf($searchkey,'`t`.`amount`','LIKE','OR',';');
				$reportdate .= " AND ({$que}) ";
				$where[]	= " ( {$que}  ) ";
			}elseif($keyname==5){
				$que=queryArrayf(isMobileValid($searchkey),"{$mts}.`bill_phone`",'LIKE','OR',';');
				$reportdate .= " AND ({$que}) ";
				$where[]	= " ( {$que}  ) ";
			}elseif($keyname==6){
				$que=queryArrayf($searchkey,"{$mts}.`routing_aba`",'LIKE','OR',';');
				$reportdate .= " AND ({$que}) ";
				$where[]	= " ( {$que}  ) ";
			}elseif($keyname==7){
				$searchkey=encryptres($searchkey);
				$que=queryArrayf($searchkey,"{$mts}.`bankaccount`",'LIKE','OR',';');
				$reportdate .= " AND ({$que}) ";
				$where[]	= " ( {$que}  ) ";
			}elseif($keyname==8){
				//acquirer_response
				$que=queryArrayf($searchkey,"{$mts}.acquirer_ref",'LIKE','OR',';');
				$reportdate .= " AND ({$que}) ";
				$where[]	= " ( {$que}  ) ";
			}elseif($keyname==82){ //Reason
				$q_82=queryArrayf($searchkey,"{$mts}.`trans_response`",'LIKE','OR',';',0);
				$reportdate .= " AND ({$q_82}) ";
				$where[]	= " ( {$q_82}  ) ";
			}elseif($keyname==83){ //M.OrderId
				$que=" ( t.reference IN ('{$searchkey}') )";
				$reportdate .= " AND ({$que}) ";
				$where[]	= " ( {$que}  ) ";
			}elseif($keyname==11){
				$que=queryArrayf($searchkey,"{$mts}.`bill_address`",'LIKE','OR',';',0);
				$reportdate .= " AND ({$que}) ";
				$where[]	= " ( {$que}  ) ";
			}elseif($keyname==12){
				$que=queryArrayf($searchkey,"{$mts}.`bill_city`",'LIKE','OR',';');
				$reportdate .= " AND ({$que}) ";
				$where[]	= " ( {$que}  ) ";
			}elseif($keyname==13){
				$que=queryArrayf($searchkey,"{$mts}.`bill_state`",'LIKE','OR',';');
				$reportdate .= " AND ({$que}) ";
				$where[]	= " ( {$que}  ) ";				
			}elseif($keyname==14){
				$que=queryArrayf($searchkey,"{$mts}.`country`",'LIKE','OR',';');
				$reportdate .= " AND ({$que}) ";
				$where[]	= " ( {$que}  ) ";	
			}elseif($keyname==15){
				$que=queryArrayf($searchkey,"{$mts}.bill_zip",'LIKE','OR',';');
				$reportdate .= " AND ({$que}) ";
				$where[]	= " ( {$que}  ) ";
			}elseif($keyname==16){
				$que=queryArrayf($searchkey,"{$mts}.`product_name`",'LIKE','OR',';');
				$reportdate .= " AND ({$que}) ";
				$where[]	= " ( {$que}  ) ";
			}elseif($keyname==17){
				$reportdate .= " AND ( lower({$mts}.`support_note`) LIKE '%".$searchkey."%' OR `t`.`transID` IN ({$searchkey})  )";
				$where[]	= " ( lower({$mts}.`support_note`) LIKE '%".$searchkey."%' OR `t`.`transID` IN ({$searchkey})  ) ";
			}elseif($keyname==18){
				$que=queryArrayf($searchkey,'`t`.`bill_ip`','LIKE','OR',';');
				$reportdate .= " AND ({$que}) ";
				$where[]	= " ( {$que}  ) ";
			}
			elseif($keyname==19){
				$que=" ( `t`.`remark_status` IN ({$searchkey}) )";
				$reportdate .= " AND ({$que}) ";
				$where[]	= " ( {$que}  ) ";
			}
			elseif($keyname==20){
				$que=queryArrayf($searchkey,'`t`.`payable_amt_of_txn`','LIKE','OR',';');
				$reportdate .= " AND ({$que}) ";
				$where[]	= " ( {$que}  ) ";
			}elseif($keyname==115){
				//$que=queryArrayf($searchkey,'t.terNO','LIKE','OR',';');
				$que=" ( `t`.`terNO` IN ({$searchkey}) )";
				$reportdate .= " AND ({$que}) ";
				$where[]	= " ( {$que}  ) ";
			}
			elseif($keyname==223){
				$wmp=withdraw_max_prevf(@$post['bid'],@$post['gid'],@$custom_settlement_wd_v3);
				
				$created_date_prev=date('Ymd',strtotime($wmp['tdate']));
				$created_date=date("Ymd",strtotime("+1 day",strtotime($wmp['c_tdate'])));
				
				$reportdate .= " AND (t.settelement_date BETWEEN (DATE_FORMAT('{$created_date_prev}', '%Y%m%d')) AND (DATE_FORMAT('{$created_date}', '%Y%m%d'))) AND ((t.trans_status NOT IN (0)) AND (t.trans_status NOT IN (9)) AND (t.trans_status NOT IN (10))) ";
				$where[]	= " (t.settelement_date BETWEEN (DATE_FORMAT('{$created_date_prev}', '%Y%m%d')) AND (DATE_FORMAT('{$created_date}', '%Y%m%d'))) AND ((t.trans_status NOT IN (0)) AND (t.trans_status NOT IN (9)) AND (t.trans_status NOT IN (10)))  ";
			}
			elseif($keyname==224){
				$reportdate .= " AND (t.trans_status NOT IN (0)) AND (t.trans_status NOT IN (9)) AND (t.trans_status NOT IN (10)) AND (t.payable_amt_of_txn IS NULL)";
				$where[]	= " (t.trans_status NOT IN (0)) AND (t.trans_status NOT IN (9)) AND (t.trans_status NOT IN (10)) AND (t.payable_amt_of_txn IS NULL) ";
			}
		}
		
		if((!empty($_GET['pdate']))&&(isset($post['bid']))){
			$pdate  = date('Y-m-d',strtotime($_GET['pdate']));
			$fpdate = date("Y-m-d",strtotime("-$payoutdays day",strtotime($pdate))); //17 
			$tpdate = date("Y-m-d",strtotime("+7 day",strtotime($fpdate)));	// 8
			
			$reportdate = "  AND ( t.tdate between '".$fpdate."' AND '".$tpdate."' )   ";
			$where[]= " ( t.tdate between '".$fpdate."' AND '".$tpdate."' ) ";
		}elseif(isset($_GET['ptdate'])&&$_GET['ptdate']){
		
				
				$date_2nd=date("Ymd",strtotime("+1 day",strtotime($_GET['ptdate'])));
				
				if(isset($_GET['pfdate'])&&$_GET['pfdate']){
					$date_1st=date("Ymd",strtotime("+0 day",strtotime($_GET['pfdate'])));
				}else{
					$date_1st=date("Ymd",strtotime("+0 day",strtotime($date_2nd)));
				}
				
				
	
				$reportdate .=" AND ( ((t.settelement_date BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d')) AND (DATE_FORMAT('{$date_2nd}', '%Y%m%d')))  AND  ( (t.trans_status NOT IN (0)) AND (t.trans_status NOT IN (9)) AND (t.trans_status NOT IN (10)) ))   OR   ((t.settelement_date NOT BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d')) AND (DATE_FORMAT('{$date_2nd}', '%Y%m%d')))  AND  ( (t.trans_status NOT IN (0)) AND (t.trans_status NOT IN (9)) AND (t.trans_status NOT IN (10)) ))  ) ";
				
				
				$where[]	= "  ( ((t.settelement_date BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d')) AND (DATE_FORMAT('{$date_2nd}', '%Y%m%d')))  AND  ( (t.trans_status NOT IN (0)) AND (t.trans_status NOT IN (9)) AND (t.trans_status NOT IN (10)) ))   OR   ((t.settelement_date NOT BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d')) AND (DATE_FORMAT('{$date_2nd}', '%Y%m%d')))  AND  ( (t.trans_status NOT IN (0)) AND (t.trans_status NOT IN (9)) AND (t.trans_status NOT IN (10)) ))  ) ";
				
				
			} 
		
		if(isset($_GET['payment_type'])&& $_GET['payment_type']=="apm"){
			$reportdate .= " AND (( t.acquirer>33 ) AND ( t.acquirer<410 ))";
			$where[]	= " (( t.acquirer>33 ) AND ( t.acquirer<410 )) ";
		}elseif(isset($_GET['payment_type'])&& $_GET['payment_type']=="pf"){
			$reportdate .= " AND ( t.related_transID IS NOT NULL AND t.related_transID!='' )";
			$where[]	= " ( t.related_transID IS NOT NULL AND t.related_transID!='' ) ";
		}elseif(isset($_GET['payment_type'])&& $_GET['payment_type']){
			$searchkey=$_GET['payment_type'];
			$reportdate .= " AND ( t.trans_type='".$searchkey."' )";
			$where[]	= " ( t.trans_type='".$searchkey."' ) ";
				
		}
		
		
		
		
				
		($ccard_type<0?'':$where[]=" (t.mop='".$ccard_type."')");
		($ccard_type<0?'':$reportdate.=" AND (t.mop='".$ccard_type."')");
		
	//if Date 1 (dt1) not empty or not 1-1-70 (empty) then check transaction between two dates
		if(($post['dt1']!='')&& ($post['dt1']!='1970-01-01')){
			$where[]="  ( t.tdate between '".$post['dt1']."' AND '".$post['dt2']."' )   ";
			$reportdate.="  AND ( t.tdate between '".$post['dt1']."' AND '".$post['dt2']."' )   ";
	}else {$post['dt1']=$post['dt2']='';}	//else set both date empty
		
		
	//condition for trans_type
		if ($trans_type=='cn'){$reportdate.=" AND (t.trans_type='cn')";$where[]="  ( t.trans_type='cn' )";}
		if ($trans_type=='ch'){$reportdate.=" AND (t.trans_type='ch')";$where[]="  ( t.trans_type='ch' )";}
		
		
		
		
		
		
		###########################################
		
		
		if(isset($_REQUEST['sortingType']) && $_REQUEST['sortingType']==2){$sort='NOT ';$sortImp='AND';}
		else{$sort='';$sortImp='OR';}
	
		if((isset($_SESSION['sub_admin_id']))&&($_SESSION['get_mid']!='M. All')){
			$get_mid=$_SESSION['get_mid'];
		}
		
		if(isset($_REQUEST['merchant_details']) && $_REQUEST['merchant_details']){
			$merchant_details=implodef($_REQUEST['merchant_details']);
			if($merchant_details){
				if(isset($data['OWNER_ID']) && $data['OWNER_ID']==1)
				{
					$reportdate.=" AND ( `merID` {$sort}IN ({$merchant_details})) ";
					$where[]	= " ( `merID` {$sort}IN ({$merchant_details})) ";
				}
				else
				{
					$reportdate.=" AND ( `merID` {$sort}IN ({$merchant_details})  OR  `sender` {$sort}IN ({$merchant_details})  ) ";
					$where[]	= " ( `merID` {$sort}IN ({$merchant_details})  OR  `sender` {$sort}IN ({$merchant_details})  ) ";
				}
			
			}
		}
		if(isset($_REQUEST['storeid']) && $_REQUEST['storeid']){
			$storeid=implodef($_REQUEST['storeid']);
			$reportdate.=" AND ( `terNO` {$sort}IN ({$storeid}) ) ";
			$where[]	= " ( `terNO` {$sort}IN ({$storeid}) ) ";
		}
		if(isset($_REQUEST['acquirer']) && $_REQUEST['acquirer']&& $_REQUEST['acquirer']<>"-1"){
			$acquirer=implodef($_REQUEST['acquirer']);
			$reportdate.=" AND ( `acquirer` {$sort}IN ({$acquirer}) ) ";
			$where[]	= " ( `acquirer` {$sort}IN ({$acquirer}) ) ";
		}
		if(isset($_REQUEST['payment_status']) && $_REQUEST['payment_status']){
			$payment_status=implodef($_REQUEST['payment_status']);
			
		
			
			$payment_status=str_replace(array('wd','wr','dp','cn','ch'),'',$payment_status);
			$payment_status=str_replace(array(',,'),'',$payment_status);
			$payment_status=rtrim($payment_status,",");
			$payment_status=ltrim($payment_status,","); 
			
			
			
			if($payment_status>=0){
				$reportdate.=" AND ( `trans_status` {$sort}IN ({$payment_status}) ) ";
				$where[]	= " ( `trans_status` {$sort}IN ({$payment_status}) ) ";
			}
			
			
			$payment_type=[];
			$payment_status_array2=$_REQUEST['payment_status'];
			
			if(in_array("wd",$payment_status_array2)){$payment_type[]='wd';}
			if(in_array("wr",$payment_status_array2)){$payment_type[]='wr';}
			if(in_array("dp",$payment_status_array2)){$payment_type[]='dp';}
			if(in_array("cn",$payment_status_array2)){$payment_type[]='cn';}
			if(in_array("ch",$payment_status_array2)){$payment_type[]='ch';}
			
			
			if($payment_type){
				$payment_type=('"'.implodef($payment_type).'"');
				$reportdate.=" AND ( t.trans_type {$sort}IN ({$payment_type}) ) ";
				$where[]	= " ( t.trans_type {$sort}IN ({$payment_type}) ) "; 
			}
		}
		if(isset($_REQUEST['ccard_types']) && $_REQUEST['ccard_types']){
			$ccard_types=("'".implodef($_REQUEST['ccard_types'],"','")."'");
			$reportdate.=" AND ( `mop` {$sort}IN ({$ccard_types}) ) ";
			$where[]	= " ( `mop` {$sort}IN ({$ccard_types}) ) ";
		}
		if(isset($_REQUEST['search_key']) && isset($_REQUEST['key_name']) && $_REQUEST['search_key']&&$_REQUEST['key_name']){
			$kn=stf($_REQUEST['key_name']);
			$search_key=(implodef($_REQUEST['search_key'],';'));
			
			$search_key1=$_REQUEST['search_key'];
			$search_key2=$_REQUEST['search_key'];
			$search_key2=("'".implodef($search_key2,"','")."'");
			//print_r($search_key2);  reference
			
			if($kn=='bill_phone'||$kn=='product_name'||$kn=='authurl'||$kn=='authdata'||$kn=='source_url'||$kn=='webhook_url'||$kn=='return_url'||$kn=='upa'||$kn=='rrn'||$kn=='acquirer_ref'||$kn=='acquirer_response'||$kn=='descriptor'||$kn=='mer_note'||$kn=='support_note'||$kn=='system_note'||$kn=='json_value'||$kn=='acquirer_json'||$kn=='json_log_history'||$kn=='payload_stage1'||$kn=='acquirer_creds_processing_final'||$kn=='acquirer_response_stage1'||$kn=='acquirer_response_stage2'||$kn=='bin_no'||$kn=='ccno'||$kn=='ex_month'||$kn=='ex_year'||$kn=='trans_response'||$kn=='bill_phone'||$kn=='bill_address'||$kn=='bill_city'||$kn=='bill_state'||$kn=='bill_country'||$kn=='bill_zip'){
				$que3= "{$mts}.`".$kn."` {$sort}IN ({$search_key2})  ";
			}
			elseif($kn=='payable_amt_of_txn'||$kn=='bill_amt'||$kn=='trans_amt'||$kn=='buy_mdr_amt'||$kn=='buy_txnfee_amt'||$kn=='rolling_amt'||$kn=='mdr_cb_amt'||$kn=='mdr_cbk1_amt'||$kn=='mdr_refundfee_amt'||$kn=='bank_processing_amount'||$kn=='available_balance'){
				$que3= "`t`.`".$kn."` {$sort}IN ({$search_key2})  ";
			}
			
			elseif($kn=='transID'||$kn=='bearer_token'||$kn=='acquirer'||$kn=='trans_status'||$kn=='merID'||$kn=='terNO'||$kn=='channel_type'||$kn=='trans_type'||$kn=='settelement_delay'||$kn=='rolling_delay'||$kn=='remark_status'){
				//$search_key2=impf($search_key1,2);
				//$que3= $kn." {$sort}IN ({$search_key2})  ";
				$que3= "`t`.`".$kn."` {$sort}IN ({$search_key1})  ";
			}
			
			elseif($kn=='descriptor'||$kn=='json_value'||$kn=='acquirer_response'){
				$que3=queryArrayf($search_key,$kn,$sort.'LIKE',$sortImp,';',2);
			}
			else{
				//$que3=queryArrayf($search_key,$kn,$sort.'LIKE',$sortImp,';',0);
				$search_key2=impf($search_key1,2);
				$que3= "`t`.`".$kn."` {$sort}IN ({$search_key2})  ";
				
			}
			$reportdate .= " AND ({$que3}) ";
			$where[]	= " ({$que3}) ";
		}
		
		if(isset($_REQUEST['time_period']) && $_REQUEST['time_period']){
			/*
			if($_REQUEST['time_period']==1){
				$g_tdate=" CONCAT(DAYNAME(`tdate`),' (',COUNT(`id`),')')  `tdates`";
				
				$group_by=" GROUP BY WEEKDAY(`tdate`)  ";

				$reportdate.=" AND ( WEEKDAY(`tdate`)<9 )  ";
				
			}elseif($_REQUEST['time_period']==2){
				$g_tdate=" CONCAT(DATE_FORMAT(`tdate`, '%b %Y'),' (',COUNT(`id`),')')  `tdates`";
				$group_by=" group by monthname(tdate), year(tdate) ";
			}elseif($_REQUEST['time_period']==3){
				$g_tdate=" CONCAT(DATE_FORMAT(`tdate`, '%Y'),' (',COUNT(`id`),')')  `tdates`";
		
				$group_by=" group by year(tdate) ";
			}
			*/
		}
		
		if(isset($_REQUEST['date_1st']) && isset($_REQUEST['date_2nd']) && $_REQUEST['date_1st']&&$_REQUEST['date_2nd']){
			$date_1st=(date('Y-m-d H:i:s',strtotime($_REQUEST['date_1st'])));
			$date_2nd=(date('Y-m-d H:i:s',strtotime($_REQUEST['date_2nd'])));
			
			$date_2nd_24=(date('His',strtotime($_REQUEST['date_2nd'])));
			if($date_2nd_24=='000000'||$date_2nd_24=='235959'){
				$date_2nd=(date('Y-m-d 24:00:00',strtotime($_REQUEST['date_2nd'])));
				//echo "<br/>date_2nd_24=>".$date_2nd_24;
				//echo "<br/>date_2nd=>".$date_2nd;
			}

			//$_REQUEST['date_2nd']=(date('Y-m-d H:i:s',strtotime("+1 day",strtotime($_REQUEST['date_2nd']))));
			
			if(isset($_REQUEST['is_created_date_on'])&&@$_REQUEST['is_created_date_on']=='1'){
				$sl_date=' `t`.`created_date` ';
			}elseif(isset($_REQUEST['key_name'])&&@$_REQUEST['key_name']=='created_date'){
				$sl_date=' `t`.`created_date` ';
			}elseif(isset($_REQUEST['key_name'])&&@$_REQUEST['key_name']=='settelement_date'){
				$sl_date=' `t`.`settelement_date` ';
			}elseif(isset($_REQUEST['settelement'])&&@$_REQUEST['time_period']==5){
				$sl_date=' `t`.`settelement_date` ';
			}else{
				$sl_date=' `t`.`tdate` ';
			}
			
			/*
			
			$reportdate.=" AND ( {$sl_date} {$sort}BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$date_2nd}', '%Y%m%d%H%i%s')) )  "; 
			$where[]	= " ( {$sl_date} {$sort}BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$date_2nd}', '%Y%m%d%H%i%s')) ) ";
			
			*/
			
			$reportdate.=" AND ( {$sl_date} {$sort}BETWEEN '{$date_1st}' AND '{$date_2nd}' )  "; 
			$where[]	= " ( {$sl_date} {$sort}BETWEEN '{$date_1st}' AND '{$date_2nd}' )  ";
			
			
		}
		
		
		
		###########################################
		
		
		if(!isset($_GET['page'])) unset($_SESSION['total_record_result']);


		$data['MaxRowsByPage']=50;
		$_SESSION['MaxRowsByPage'] = $data['MaxRowsByPage'];

		$data['ct_query'] = ($where?" AND ".implode(' AND ', $where)." ":"");

//		if(isset($_GET['tscount'])) $count = $_GET['tscount'];
//		elseif(isset($_SESSION['total_record_result'])) $count = $_SESSION['total_record_result'];

		$_SESSION['query_post_pg'] = $_REQUEST;

		/*
        $count=get_trans_counts(($where)?" AND ".implodes(' AND ', $where)." ":"");
		$post['tr_counts_q']=$data['tr_counts_q'];
		if(isset($_GET['t_c_q'])){
			echo $post['tr_counts_q'];
		}
		$data['tr_count']=$count;
        for($i=0; $i<$count; $i+=$data['MaxRowsByPage']){$data['Pages'][]=$i;}
		*/







	//	set starting page 0 if not not set
	if(!isset($post['StartPage']) || !$post['StartPage']) $post['StartPage'] =0;
	//fetch the all transaction via query created in above (function adm_trans_list() defined ) 
    $d_order=(isset($_REQUEST['d_order'])&&$_REQUEST['d_order']?$_REQUEST['d_order']:'DESC');
	$data['TransactionsList']=adm_trans_list(
			(isset($post['bid']) && $post['bid'])?$post['bid']:0,
			'both',
			$post['acquirer'],
			$post['status'],
			$post['StartPage'],
			$data['MaxRowsByPage'], 
			$reportdate." ORDER BY ".$orderby,
			$d_order,
			'',
			'',
			@$custom_settlement_wd_v3
        ); 
	
	$data['tr_counts_q_csv']=$post['tr_counts_q']=@$data['tr_counts_q'];
	





	//Dev Tech: 25-01-25 modify || 24-01-08 Fetch more db connection

	$more_db_loop=1;

	//if(isset($data['custom_settlement_wd_v3_is_1'])&&@$data['custom_settlement_wd_v3_is_1']==1&&@$data['last_record']>5)  $more_db_loop=0;
	if(isset($data['custom_settlement_wd_v3_is_1'])&&@$data['custom_settlement_wd_v3_is_1']==1)  $more_db_loop=0;

	if(isset($_REQUEST['dtest']))
	{
	 	echo "<br/><hr/><br/>last_record=>".@$data['last_record'];
	 	echo "<br/>custom_settlement_wd_v3_is_1=>".@$data['custom_settlement_wd_v3_is_1'];
	 	echo "<br/>more_db_loop=>".@$more_db_loop;
	}
	
	
	$last_record=0;
	$maxRowsByPage=$data['MaxRowsByPage'];
	//$maxRowsByPage=50;
	if( $data['last_record'] < $maxRowsByPage && isset($data['DB_CON']) && !isset($_GET['DB_CON']) && function_exists('config_db_more_connection') && $more_db_loop==1 )
	{
		//$data['skip_connection_type']='Y';
		
		//$db_hostname_1=$data['Hostname'];$db_username_1=$data['Username'];$db_password_1=$data['Password'];$db_database_1=$data['Database'];$DbPort_1=$data['DbPort'];$connection_type_1=$data['connection_type'];
		
		
		$DB_CON=@$_SESSION['DB_CON'];
		$db_ad=@$_SESSION['db_ad'];
		$db_mt=@$_SESSION['db_mt'];
		
		
		
		/*
		if(isset($_SESSION['DB_CON'])) unset($_SESSION['DB_CON']); 
		if(isset($_SESSION['db_mt'])) unset($_SESSION['db_mt']); 
		if(isset($_SESSION['db_ad'])) unset($_SESSION['db_ad']);
		*/
		
		/*
		echo "<br/>DB_CON=>".$DB_CON;
		echo "<br/>db_ad=>".$db_ad;
		echo "<br/>db_mt=>".$db_mt;
		echo "<hr/>";
		*/
		
		$db_con_arr=$data['DB_CON'];
		
		
		if(isset($db_con_arr[$DB_CON]['MORE_ADDITIONAL'][$db_ad])) unset($db_con_arr[$DB_CON]['MORE_ADDITIONAL'][$db_ad]);
		if(isset($db_con_arr[$DB_CON]['MORE_MASTER'][$db_mt])) unset($db_con_arr[$DB_CON]['MORE_MASTER'][$db_mt]);
		//elseif($DB_CON>0&&isset($db_con_arr[$DB_CON])) unset($db_con_arr[$DB_CON]);
		
			
		//echo "<br/>count=>".count($db_con_arr[$DB_CON]['MORE_ADDITIONAL'])."<br/>";
		if(isset($_REQUEST['dtest'])) echo "<hr/><h4 style='font-size:22px!important;font-weight:bold;color:#3a8411;'>More DB Search :: connection_type=> ".@$data['connection_type']."</h4>";
		//print_r($db_con_arr);
		
		$singal_db_con='Y';
		
		foreach($db_con_arr as $k4 => $v4){ 
		
			if(isset($v4['MORE_ADDITIONAL'])&&(isset($data['MASTER_TRANS_ADDITIONAL']))){
				foreach($v4['MORE_ADDITIONAL'] as $ak4 => $av4){
					$singal_db_con='N';
					config_db_more_connection($k4,$ak4,'',1);
												
						if(isset($_REQUEST['a'])&&$_REQUEST['a']=='cn2'&&isset($_SESSION['login_adm']))
						{
							echo "<br/>AD Database=>".@$data['Database']."<br/>";
							echo "<br/>DBCON=>".@$data['DBCON']."<br/>";
							echo "<br/>dbad=>".@$data['dbad']."<br/>";
							echo "<br/>dbmt=>".@$data['dbmt']."<br/>";
							echo "<br/>connection_type=>".@$data['connection_type']."<br/>";
							echo "<br/>Hostname=>".@$data['Hostname']."<br/>";
							echo "<br/>Username=>".@$data['Username']."<br/>";
							echo "<br/>Password=>".@$data['Password']."<br/>";
							echo "<br/>Database=>".@$data['Database']."<br/>";
							echo "<br/>MASTER_TRANS_ADDITIONAL=>".@$data['MASTER_TRANS_ADDITIONAL']."<br/>";
							echo "<br/>MASTER_TRANS_TABLE=>".@$data['MASTER_TRANS_TABLE']."<br/>";
							echo "<br/>ASSIGN_MASTER_TRANS_ADDITIONAL=>".@$data['ASSIGN_MASTER_TRANS_ADDITIONAL']."<br/>";
						}
						
						if(isset($_REQUEST['dtest'])) {
							echo "<br/>MA=>".$k4."_".$ak4."_".$av4['NAME'];
							echo "<br/>tr_count=>".$data['tr_count'];
						}
						
						
						
						$trs_count=count(@$data['TransactionsList']);
						if($trs_count>=$maxRowsByPage&&!isset($_REQUEST['all'])) break;
						
						
						$data['TransactionsList1']=adm_trans_list(
							(isset($post['bid']) && $post['bid'])?$post['bid']:0,
							'both',
							$post['acquirer'],
							$post['status'],
							$post['StartPage'],
							$data['MaxRowsByPage'], 
							$reportdate." ORDER BY ".$orderby,
							$d_order
						); 
						
						if(isset($_REQUEST['dtest'])) {
							echo "<br/>last_record=>".$last_record;
							echo "<br/>tr_count=>".$data['tr_count'];
						}
						
						
						if($data['TransactionsList']) $data['TransactionsList']=array_merge($data['TransactionsList'],@$data['TransactionsList1']);
						elseif($data['TransactionsList1'])$data['TransactionsList']=$data['TransactionsList1'];
						
						$trs_count=count(@$data['TransactionsList']);
						if($trs_count>=$maxRowsByPage&&!isset($_REQUEST['all'])) break;
						
				}
			}

			if(isset($v4['MORE_MASTER'])){
				
				foreach($v4['MORE_MASTER'] as $mk4 => $mv4)
				{
					$singal_db_con='N';
					config_db_more_connection($k4,'',$mk4,1);
					//echo "<br/>MT Database=>".@$data['Database']."<br/>";
				
					if(isset($_REQUEST['dtest'])) {
						echo "<br/>MM=>".$k4."_".$mk4."_".$mv4['NAME'];
						echo "<br/>tr_count=>".$data['tr_count'];
					}
					
				
					$trs_count=count(@$data['TransactionsList']);
					if($trs_count>=$maxRowsByPage&&!isset($_REQUEST['all'])) break;
					
					$reportdate_mm=str_replace('`ad`.','`t`.',$reportdate);

					$data['TransactionsList1']=adm_trans_list(
						(isset($post['bid']) && $post['bid'])?$post['bid']:0,
						'both',
						$post['acquirer'],
						$post['status'],
						$post['StartPage'],
						$data['MaxRowsByPage'], 
						$reportdate_mm." ORDER BY ".$orderby,
						$d_order
					); 
					
					if(isset($_REQUEST['dtest'])) {
						echo "<br/>last_record=>".$data['last_record'];
						echo "<br/>tr_count=>".$data['tr_count'];
					}
					
					$data['last_record']=$data['tr_count']=$data['last_record']+$last_record;
					
					if($data['TransactionsList']) $data['TransactionsList']=array_merge($data['TransactionsList'],@$data['TransactionsList1']);
					elseif($data['TransactionsList1'])$data['TransactionsList']=@$data['TransactionsList1'];
				
					$trs_count=count(@$data['TransactionsList']);
					if($trs_count>=$maxRowsByPage&&!isset($_REQUEST['all'])) break;
				}
				
				
			}
			
			
			if(isset($singal_db_con)&&$singal_db_con=='Y'&&isset($mv4['NAME'])&&trim($mv4['NAME']))
			{
			
				config_db_more_connection($k4,'','',1);
				//echo "<br/>Only Database=>".@$data['Database']."<br/>";
				
					if(isset($_REQUEST['dtest'])) {
						echo "<br/>MM=>".$k4."_".$mk4."_".$mv4['NAME'];
						echo "<br/>tr_count=>".$data['tr_count'];
					}
					
					$trs_count=count(@$data['TransactionsList']);
					if($trs_count>=$maxRowsByPage&&!isset($_REQUEST['all'])) break;
					
					$data['TransactionsList1']=adm_trans_list(
						(isset($post['bid']) && $post['bid'])?$post['bid']:0,
						'both',
						$post['acquirer'],
						$post['status'],
						$post['StartPage'],
						$data['MaxRowsByPage'], 
						$reportdate." ORDER BY ".$orderby,
						$d_order
					); 
					
					if(isset($_REQUEST['dtest'])) {
						echo "<br/>tr_count=>".$data['tr_count'];
					}
					
					
					if($data['TransactionsList']) $data['TransactionsList']=array_merge($data['TransactionsList'],@$data['TransactionsList1']);
					elseif($data['TransactionsList1'])$data['TransactionsList']=@$data['TransactionsList1'];
				
					$trs_count=count(@$data['TransactionsList']);
					if($trs_count>=$maxRowsByPage&&!isset($_REQUEST['all'])) break;
				
			}
			
			
			
			
		}
		
		$data['last_record']=$data['tr_count']=count(@$data['TransactionsList']);
		
		//array_multisort(array_column($data['TransactionsList'], 'tdate'), SORT_ASC, $data['TransactionsList']);
		
		//if(function_exists('db_disconnect')) db_disconnect();
		//if(function_exists('db_disconnect_mysqli')) db_disconnect_mysqli();
		//if(function_exists('db_disconnect_psql')) db_disconnect_psql();
		
		//$data['Hostname']=$db_hostname_1;$data['Username']=$db_username_1;$data['Password']=$db_password_1;$data['Database']=$db_database_1;$data['DbPort']=$DbPort_1;$data['connection_type']=$connection_type_1;
		
		config_db_more_connection($DB_CON,$db_ad,$db_mt,1);
		
	}
	
	
	
	
	// Search for custom settlement v3
	if(($data['last_record'] < 40) && (isset($data['CUSTOM_SETTLEMENT_WD_V3'])&&@$data['CUSTOM_SETTLEMENT_WD_V3']=='Y'&&@$custom_settlement_wd_v3==0) && (isset($_REQUEST['date_2nd'])) )
		
	{
			
			
			$last_record=$data['last_record'];
			if(isset($_REQUEST['dtest'])) {
				echo "<br/>last_record=>".$data['last_record'];
				echo "<br/>tr_count=>".$data['tr_count'];
			}
			
			$data['TransactionsList1']=adm_trans_list(
				(isset($post['bid']) && $post['bid'])?$post['bid']:0,
				'both',
				$post['acquirer'],
				$post['status'],
				$post['StartPage'],
				$data['MaxRowsByPage'], 
				$reportdate." ORDER BY ".$orderby,
				$d_order,
				'',
				'',
				1//custom_settlement_wd_v3
			); 
			
			if(isset($_REQUEST['dtest'])) {
				echo "<br/>last_record=>".$data['last_record'];
				echo "<br/>tr_count=>".$data['tr_count'];
			}
			
			$data['last_record']=$data['tr_count']=$data['last_record']+$last_record;
			
			if($data['TransactionsList']) $data['TransactionsList']=array_merge($data['TransactionsList'],@$data['TransactionsList1']);
			elseif($data['TransactionsList1'])$data['TransactionsList']=@$data['TransactionsList1'];
			
				
			
	}
	
	
	//array_multisort(array_column(@$data['TransactionsList'], 'tdate'), SORT_DESC, @$data['TransactionsList']);
	
	
	// Fetch Backup db for above of 7 days trans
	
	//if((($data['last_record']==0&&$data['backUpDb']=='') || ((isset($_REQUEST['all'])) ) )&&isset($data['Database_3'])&&$data['Database_3']&&function_exists('db_connect_3'))
		
	/*
	if((($data['last_record'] < 49 && $data['backUpDb']=='') || ((isset($_REQUEST['all'])) ) )&&isset($data['Database_3'])&&$data['Database_3']&&function_exists('db_connect_3'))
		
	{
			$data['backUpDbSet']="`{$data['Database_3']}`.";
			
			$last_record=$data['last_record'];
			if(isset($_REQUEST['dtest'])) {
				echo "<br/>last_record=>".$data['last_record'];
				echo "<br/>tr_count=>".$data['tr_count'];
			}
			
			$data['TransactionsList1']=adm_trans_list(
				(isset($post['bid']) && $post['bid'])?$post['bid']:0,
				'both',
				$post['acquirer'],
				$post['status'],
				$post['StartPage'],
				$data['MaxRowsByPage'], 
				$reportdate." ORDER BY ".$orderby,
				$d_order
			); 
			
			if(isset($_REQUEST['dtest'])) {
				echo "<br/>last_record=>".$data['last_record'];
				echo "<br/>tr_count=>".$data['tr_count'];
			}
			
			$data['last_record']=$data['tr_count']=$data['last_record']+$last_record;
			
			if($data['TransactionsList']) $data['TransactionsList']=array_merge($data['TransactionsList'],$data['TransactionsList1']);
			elseif($data['TransactionsList1'])$data['TransactionsList']=$data['TransactionsList1'];
			
				
			
	}
	*/
	
	//if(isset($data['tr_counts_q'])) $post['tr_counts_q']=$data['tr_counts_q'];	//total number of rows
		
}elseif($post['action']=='details'){	//fetch full detail of a transaction
        $post['TransactionDetails']=get_transaction_detail($post['gid'], -1);
		list($wtype, $total, $email, $ecomments)=explode("#", $post['TransactionDetails']['ecomments']);
        if($wtype&&$total&&$email&&$ecomments){
                $post['TransactionDetails']['ecomments']=$ecomments;
                $post['wtype']=$wtype;
                $post['payee']=$email;
                $post['total']=$total;
        }
}elseif($post['action']=='summary'){	//fetch the summary of a transaction

		//date section start
        $now=getdate();
        if(!isset($post['month']))$post['month']=$now['mon'];
        if(!isset($post['day']))$post['day']=$now['mday'];
        if(!isset($post['year']))$post['year']=$now['year'];
        if(!$post['month'])$post['day']=0;

        $data['StatDays']=array('--');
        for($i=1;$i<=31;$i++)$data['StatDays'][$i]=$i;
        $data['StatMonth']=array('--');
        for($i=1;$i<=12;$i++)$data['StatMonth'][$i]=strtoupper(date('F', mktime(0,0,0,$i,1,0)));
        $years=get_transactions_year();
        $data['StatYear']=array();
        for($i=$years['min'];$i<=$years['max'];$i++)$data['StatYear'][$i]=$i;
		//date section end

        $dateA=mktime(0, 0, 0, $post['month'], $post['day'], $post['year']);	//create from as dateA
        $dateB=mktime(0, 0, 0, $post['month'], $post['day']+1, $post['year']);	//create next day as dateB
        $post['Daily']=get_transactions_summary($dateA, $dateB);				//fetch data of a day

        $dateA=mktime(0, 0, 0, $post['month'], 1, $post['year']);	//create from as dateA
        $dateB=mktime(0, 0, 0, $post['month']+1, 1, $post['year']);	//create next month as dateB
        $post['Monthly']=get_transactions_summary($dateA, $dateB);	//fetch data of a month

        $dateA=mktime(0, 0, 0, 1, 1, $post['year']);				//create from as dateA
        $dateB=mktime(0, 0, 0, 1, 1, $post['year']+1);				//create after year as dateB
        $post['Yearly']=get_transactions_summary($dateA, $dateB);	//fetch data of an year
}elseif($post['action']=='addremark'){	//add mer_note / system note of a transaction
	
	//select previous added mer_note and system note
	$remark_slct=db_rows(
			"SELECT `support_note`,`acquirer`,`system_note` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` WHERE `id`={$post['gid']}"
	);
	$remark_get = $remark_slct[0]['support_note']; 
	$type_get 	= $remark_slct[0]['acquirer']; 
	$system_note_get = $remark_slct[0]['system_note'];
	
	
	$rmk_date=date('d-m-Y h:i:s A');
	
	$byusername=" - Admin";
	if(isset($_SESSION['sub_admin_id'])){
		$byusername=" - ".$_SESSION['username'];
	}
	
	//add update new mer_note / reply
	$remark_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$post['mer_note'].$byusername."</div></div>".$remark_get;
	$system_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$post['mer_note'].$byusername."</div></div>".$system_note_get;
		
	$db_upd1=" `support_note`='{$remark_upd}',`remark_status`=2 ";
	if($post['reply_type']=="system"){
		$db_upd1=" `system_note`='{$system_upd}', `remark_status`=2  ";
	}
	
	//update mer_note
	if($post['mer_note']){
		db_query(
			"UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" SET ".$db_upd1.
			" WHERE `id`='{$post['gid']}'"
		);
	}
	$post['action']='select';
	
	$reurl=$post['aurl'];
	echo"
	 <script>
		top.window.document.getElementById('modal_popup_form_popup').style.display='none';
	 </script>
	";
	//header("Location:$reurl");
	//exit;
}
$post['ViewMode']=$post['action'];
###############################################################################

display('admins');
###############################################################################
?>