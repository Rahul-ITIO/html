<?
###############################################################################
$data['PageName']='ACCOUNT OVERVIEW';
$data['PageFile']='index';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'My Account - '.$data['domain_name']; 
//echo "<br/>frontUiName=>".$data['frontUiName'];
###############################################################################
if(!isset($_SESSION['login'])){
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}
if(is_info_empty($uid)){
	header("Location:{$data['Host']}/user/profile".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

###############################################################################

$post=select_info($uid, $post);
//$_SESSION['user_permission_pro']=$post['user_permission'];
$_SESSION['edit_permission']=$post['edit_permission'];
$uid=$post['id'];
if(isset($post['profile_json'])&&$post['profile_json']){
	$post=array_merge($post,$post['profile_json']);
}
###############################################################################

///////////// Check required field are filled or missing //////////////
//if($data['frontUiName']=="default_UX"){ //default_UX

if((isset($post['fullname'])&&$post['fullname']) && (isset($post['registered_email'])&&$post['registered_email']) &&(isset($post['company_name'])&&$post['company_name']) && (isset($post['registered_address'])&&$post['registered_address'])){
	
}else{
	header("Location:{$data['Host']}/user/summary-account".$data['ex']);exit;
}

//}
###############################################################################
if(isset($_GET['open'])){
	unset($_SESSION['trInfo']);
}

// Redirect when admin merchant login throught payout module redirect to merchant payout module
if(isset($_SESSION['admin_dashboard_type'])&& $_SESSION['admin_dashboard_type']=="payout-dashboar"){
	$_SESSION['dashboard_type']="payout-dashboar";
	$_SESSION['admin_dashboard_type']="";
	unset($_SESSION['admin_dashboard_type']);
	header("Location:{$data['Host']}/user/summary".$data['ex']);
	exit;
}

###############################################################################
$post=select_info($uid, $post); 

$data['withdraw_gmfa']=0;
$gmfa=[];
if(isset($data['gmfa'])&&!empty($data['gmfa'])) $gmfa=$data['gmfa'];
if((in_array('withdraw',$gmfa))&&($post['google_auth_access']==1||$post['google_auth_access']==3)&&($post['google_auth_code'])){
	$data['withdraw_gmfa']=1;
}

$post['Emails']=get_clients_email($uid, false, false);
//$data['Balance']=select_balance($uid);

$post['default_currency_sys']=get_currency($post['default_currency']);
$post['default_currency_nm']=strtolower(get_currency($post['default_currency'],1));

//print_r($post['address']);

$_SESSION['m_username']=$post['username'];

//$_SESSION['user_permission']=$post['user_permission'];
$_SESSION['default_currency']=$post['default_currency'];
$_SESSION['user_type']="";
if(isset($post['user_permission']) && $post['user_permission']==1){
	$_SESSION['user_type']=1;
}

$front_ui_Left_Panel=0;

if((isset($data['frontUiName'])&&in_array($data['frontUiName'],array("ice","sys")))||(@$data['domain_server']['subadmin']['front_ui_panel']=='Left_Panel')){
	$front_ui_Left_Panel=1;	
}

if(isset($_REQUEST['dtest']))
{
	
	echo "<br/><br/><br/>frontUiName=>".$data['frontUiName']; echo "<br/><br/><br/>front_ui_Left_Panel=>".$front_ui_Left_Panel;
}

if(isset($front_ui_Left_Panel) && $front_ui_Left_Panel==0){
	if(strpos($_SESSION['themeName'],'LeftPanel')!==false){
		//echo "<hr/>themeName=>".$_SESSION['themeName'];
		$post_form=array();
		$post_form['merchant_details']=$uid;
		
		$trans_details=get_trans_graph($post_form);
		$post['count_result']=count($trans_details);
	   //print_r($trans_details);
		$post['total_amount']=0;
		$post['ids']=0;

		for($i=0;$i<count($trans_details);$i++){
			//$date_transaction[$i]	= date("Y-m-d", strtotime($trans_details[$i]['tdates']));
			$date_transaction[$i]	= $trans_details[$i]['tdates'];
			$transaction_amount[$i]	= (double)$trans_details[$i]['amounts'];
			$post['total_amount']	= $post['total_amount']+(double)$trans_details[$i]['amounts'];
			$post['ids']=$post['ids']+$trans_details[$i]['ids'];
		}
		// print_r($date_transaction);
		$post['date_transaction']=$date_transaction;
		$post['transaction_amount']=$transaction_amount;
		//print_r($transaction_amount);
	} else{
		if(isset($post['action']) && $post['action']=='upgrade_limit'){
			if(isset($post['change']) && $post['change']){
				if(!isset($post['fname']) || !$post['fname']){
					$data['Error']='Please enter your first name.';
				}elseif(!isset($post['lname']) || !$post['lname']){
					$data['Error']='Please enter your last name.';
				}else{
					upgrade_limit($uid,$post);
					header("location:".$data['USER_FOLDER']."/index.do");
				}
			}
		}
/*
			$success_at_list_one=db_rows(
				"SELECT `id`".
				" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
				" WHERE ".
				"  ( `trans_status`=1 ) ".
				"  AND  ( `merID`='{$uid}') ".
				"  ORDER BY tdate ".
				"  LIMIT 1 ".
				"  ",0
			);
			$post['success_1']=((isset($success_at_list_one[0]['id'])&&$success_at_list_one[0]['id'])?$success_at_list_one[0]['id']:'');
			//echo "<hr/>success_1=>".$post['success_1'];
			
			$min_tr=db_rows(
				"SELECT `id`".
				" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
				" WHERE ".
				" ( `merID`='{$uid}') ".
				" ORDER BY tdate ".
				" LIMIT 1 ".
				"  ",0
			);
			$post['min_tr']=((isset($min_tr[0]['id'])&&$min_tr[0]['id'])?$min_tr[0]['id']:'');
			//echo "<hr/>min_tr=>".$post['min_tr'];
			*/
			
			
			if(!isset($data['PRO_VER']))
			{
				$last_ticketid=db_rows(
					"SELECT `ticketid` FROM `{$data['DbPrefix']}support_tickets`".
					" WHERE `clientid`={$uid} AND `trans_status`=91 ".
					" ORDER BY `id` DESC LIMIT 1",0 //`date` DESC
				);
				
				$new_msg_count=db_rows(
					"SELECT COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}support_tickets`".
					" WHERE `clientid`='{$uid}' AND `trans_status`=91 ".
					" LIMIT 1",0 //`date` DESC
				);
				
				if((@$new_msg_count[0]['count']>0)&&(!isset($_SESSION['closePopup']))){
					$data['new_msg_count']=@$new_msg_count[0]['count'];
					$_SESSION['load_tab']='inbox';
					$_SESSION['open_msg_id']=@$last_ticketid[0]['ticketid'];					
				}
				$post['banks']=select_banks($uid,0,1);
				$post['WalletInfo']=select_coin_wallet($uid,0,1);
			}
			
		
				
		/*
		$post['Transactions']=get_transactions($uid, 'both', -1, -1, 0, 10);
		$post['LastTransaction']=$post['Transactions'][0];
		$post['PaysToUnregUSER_FOLDER']=get_unreg_clients_pay($uid);
		*/
		

		//print_r($post['ab']['summ_mature_amt']);

		//include('../include/riskratio_code.do');

	} 
	

}

$post['terminals']=select_terminals($uid,0,0,1);
	$data['store_size']=0;
	if(isset($post['terminals']) && $post['terminals']){
		foreach($post['terminals'] as $key=>$value){
			if(strpos($value['tarns_alert_email'],'007')!==false){
				$data['store_size']++;
			}
		}
	}
	$_SESSION['store_size']=$data['store_size'];
	
###############################################################################
if(isset($front_ui_Left_Panel) && $front_ui_Left_Panel==1){
	
	$where_pred=" ";
	if(isset($_REQUEST['wid']) && $_REQUEST['wid']){
		$wid=stf($_REQUEST['wid']);
		$where_pred=" AND `acquirer`='{$wid}' ";
	}
	
//	print_r($_SESSION['tr_sum_count']);
	//$_GET['dtest']=2;


	/*

	if(isset($data['WITHDRAW_INITIATE_SYSTEM_WV2'])&&$data['WITHDRAW_INITIATE_SYSTEM_WV2']=='Y'&&@$_REQUEST['a']!='v1') 
	{


	}
	elseif(!isset($_SESSION['tr_sum_count'])||$where_pred)
	{
	
		$noOfTransaction=db_rows(
			"SELECT SUM(`trans_amt`) AS `summ`, COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" WHERE  ( `merID`={$uid} )  AND ( `trans_status` IN (1,7) ) AND ( `trans_type` IN (11) )  {$where_pred}  LIMIT 1 ",0
			
		);
		$_SESSION['tr_sum_count']['noOfTransaction']=$post['noOfTransaction']=@$noOfTransaction[0]['count'];
		$_SESSION['tr_sum_count']['transactionAmount']=$post['transactionAmount']=number_formatf(@$noOfTransaction[0]['summ']);


		//====================
		$noOfTotalTransactions=db_rows(
			"SELECT COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" WHERE  ( `merID`={$uid} )  AND ( `trans_status` IN (1,2,7) ) AND ( `trans_type` IN (11) )  {$where_pred}  LIMIT 1 ",0
		);
		$_SESSION['tr_sum_count']['noOfTotalTransactions']=$post['noOfTotalTransactions']=@$noOfTotalTransactions[0]['count'];
		//=================================================
		
		
		$refundAmount=db_rows(
			"SELECT SUM(`trans_amt`) AS `summ`, COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" WHERE  ( `merID`='{$uid}' )  AND ( `trans_status` IN (3) )  AND ( `trans_type` IN (11) ) LIMIT 1 ",0
		);
		$_SESSION['tr_sum_count']['refundAmount']=$post['refundAmount']=number_formatf(@$refundAmount[0]['summ']);

		$settlements=db_rows(
			"SELECT SUM(`trans_amt`) AS `summ`, COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" WHERE  ( `merID`={$uid} )  AND ( `trans_status` IN (1,13) )  AND ( `acquirer` IN (2) ) LIMIT 1 ",0
		);
		$_SESSION['tr_sum_count']['settlements']=$post['settlements']=number_formatf(@$settlements[0]['summ']);

		
		$_SESSION['mNotificationCount']=$trans_reply_counts=get_trans_reply_counts($uid,'1,2');

	}
	
	if(isset($_SESSION['tr_sum_count'])){
		$post=array_merge($post,$_SESSION['tr_sum_count']);
	}
	

	*/

	$graph_dash=("graph_dash".$data['iex']);
	if(file_exists($graph_dash)){
		include($graph_dash);
	}
	
	
}	

if(isset($data['frontUiName'])&&!isset($_SESSION['message_open_count'])&&in_array($data['frontUiName'],["OPAL_IND_UX","OPAL_NS","OPAL_IND"]))
{
	
	$_SESSION['message_open_count']=support_tickets_count_by_status("$uid","open");
	$_SESSION['message_unread_count']=support_tickets_count_by_status("$uid","unread");
	$_SESSION['mNotificationCount']=$trans_reply_counts=get_trans_reply_counts($uid,'1,2');
}
###############################################################################


###############################################################################
display('user');
###############################################################################
?>
