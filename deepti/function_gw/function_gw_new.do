<?php

// Dev Tech : 23-02-12 below list of function are not use this project of GW because this function are re-modify as well as a function, table name and feild wise for collect this function unuse file


function get_payout_bank_detail($tid="", $fields='*')
{
	global $data;
	$qprint=0;
	if(isset($_GET['qp'])){
		$qprint=1;
		echo "<hr/><==get_payout_bank_detail==><hr/>";
	}
	if(!empty($tid)) $where_clause = " WHERE `id`='$tid'";
	else $where_clause = "";

	$result = db_rows("SELECT $fields FROM `{$data['DbPrefix']}bank_payout_table` $where_clause ORDER BY id",$qprint
	);
	return $result;
}




function getTerminalidf($mid,$ajax){
	global $data; $results=[];
	//echo "<br/>mid2=>".$_REQUEST['mid'];
	if (empty($mid)){$mid=-1;}
	$qry="select `id`,`ter_name`,`merID` FROM `{$data['DbPrefix']}terminal` WHERE `merID` IN ({$mid})";
	//echo $qry."<br>";
	$result=db_rows($qry);
	
	if($ajax==3){
		foreach ($result as $value) {
			$results[$value['id']]="[{$value['id']}] {$value['ter_name']} [{$value['merID']}]";
		}
		
		return $results;
	}else{
	
	$c=count($result);
	if (empty($result)){echo "<center><strong>No Business Registered.</strong></center>";return false;}
	//else {
		//echo 'store->'.$_POST['terNO'];
	?>
	<select name="terNO" id="terNO">
		<option value=''>Select Business ID</option>
        <?php
		$i=0;
		 foreach ($result as $value) { 
			 if ($value['id']!=''){
		 	if ($_POST['terNO']== $value['id']){$selected="selected";}else {$selected='';}
			$i++;
		 ?>
		 <option value="<?php echo $value['id'];?>" <?=$selected;?>>[<?php echo $value['id']."] ".$value['ter_name'];?></option>
		 <?php
			 }
			
		}
		if ($_POST['terNO']==0){$selected='selected';}else {$selected=NULL;}
		if ($c>1){echo "<option value='0' ".$selected.">All Business ID</option>";}
		?>
	</select>
    
	<?php
	}

}// end function


function getacquireridsf($wid,$ajax){
	global $data; $results=[];$midcard=''; $q=0; if(isset($_REQUEST['q'])){$q=1;}
	//echo "<br/>wid=>".$_REQUEST['wid'];
	if ($wid){
		$result=db_rows("SELECT `acquirerIDs` FROM `{$data['DbPrefix']}terminal` WHERE `id` IN ({$wid})",$q);
		foreach ($result as $value) {
			$acquirerID.=",".$value['acquirerIDs'];
			
		}
		$acquirerIDs=explode(",",$acquirerID.",");
		$acquirerIDs=array_unique($acquirerIDs);
		sort($acquirerIDs);
		if($ajax==1){
			foreach($acquirerIDs as $val){
				$results[$val]="[{$val}] {$data['acquirer_list'][$val]}";
			} 
			
		}
		
		return $results;
	}
}


function terminal_review_counts($uid=0,$where_pred='',$group_by=''){
	global $data; $results=array();
	
	if($uid>0){
		//$where_pred=" AND (t.merID='{$uid}')";
	}
	
	if(((isset($_SESSION['sub_admin_id']))&&($_SESSION['get_mid']!='M. All'))){
		$get_mid=$_SESSION['get_mid'];

		$where_pred .="  AND  ( merID IN ({$get_mid}) )  {$group_by}   ";
	}

	$result=db_rows(
		" SELECT COUNT(id) AS `count`, ".group_concat_return('`merID`',0)." AS `merID` ".
		" FROM {$data['DbPrefix']}terminal".
		" WHERE ".$where_pred.
		" limit 1 ",0
	);
	$results['count']=@$result[0]['count']; 
	$results['merID']=@$result[0]['merID']; 
	
	return $results; 
}


function getQrAcquirerList()
{
	global $data;
	
	$ac_nos = '';
	//fetch list of acquirer_id from acquirer_table mapped with 10-QR India
	$sqlStmt = "SELECT `acquirer_id` FROM `{$data['DbPrefix']}acquirer_table` WHERE `channel_type`='10' ORDER BY acquirer_id";
	$bank_q= db_rows($sqlStmt,0);

	if(isset($bank_q))
	{
		foreach($bank_q as $key => $val)
		{
			if($ac_nos) $ac_nos .= ',';
			$ac_nos .= $val['acquirer_id'];
		}
	}
	return $ac_nos;
}

//The used to retrive total transactions via defined condition
function trans_count_where_pred($where_pred){
	global $data;
	//echo $where_pred;
	$result=db_rows(
		"SELECT count(DISTINCT `id`) as cnt ".
		" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` ".
		" WHERE $where_pred ",0
	);
	return $result[0]['cnt'];	//return total number of transactions
}


//Fetch the last withdrawal detail of a merchant.
function withdraw_max_prevf($uid=0,$tid=0,$clk_status=0){
	global $data;$qprint=0;
	$result=array();
	$not_status=" AND ( NOT( `trans_status` IN (2) ) ) ";
	//if($clk_status){ $not_status=" ";}
	
	//fetch transaction detail
	$c_withdraw_max=db_rows(
		"SELECT `id`, `transID`, `tdate`, `created_date`".
		" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
		" WHERE ( `merID`='{$uid}' ) AND ( `id`='{$tid}' ) ".
		" LIMIT 1",$qprint
	); 
	
	$c_created_date=$c_withdraw_max[0]['created_date'];
	
	$result=ms_max_settelement_period($uid,$c_created_date);	//fetch settlement period
	
	$result["c_id"]=$c_withdraw_max[0]['id'];
	$result["c_transID"]=$c_withdraw_max[0]['transID'];	//transaction id
	$result["c_tdate"]=$c_withdraw_max[0]['tdate'];						//transaction update date
	$result["c_created_date"]=$c_withdraw_max[0]['created_date'];		//transaction create date
	
	//fetch last withdraw / settlement
	$t_withdraw_max=db_rows(
		"SELECT (`id`) AS `id`, (`transID`) AS `transID`, (`tdate`) AS `tdate`".
		" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
		" WHERE ( `merID`='{$uid}' ) AND ( `acquirer`=2 ) {$not_status} AND ( `id`<'{$tid}' ) ".
		" ORDER BY `id` DESC LIMIT 1",$qprint
	);
	
	$result["previous_wd_transID"]=@$t_withdraw_max[0]['transID'];
	
	//if no record found via above query then execute following query
	if(@$t_withdraw_max[0]['id']==null){
		$t_withdraw_max=db_rows(
			"SELECT `id`,`transID`, `tdate`".
			" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" WHERE ( `merID`='{$uid}' ) ".
			" ORDER BY `id` ASC LIMIT 1",$qprint
		);
	}
	
	$result["id"]=$t_withdraw_max[0]['id'];
	$result["transID"]=$t_withdraw_max[0]['transID'];	//transaction id
	$result["tdate"]=$t_withdraw_max[0]['tdate'];					//transaction date
	
	//Select Data from master_trans_additional
	$join_additional=join_additional('i');
	if(!empty($join_additional)) $mts="`ad`";
	else $mts="`t`";

	//fetch order bill_amt and json of a transaction
	$remaining_balance_prev=db_rows(
		"SELECT `t`.`bill_amt`,{$mts}.`json_value` ".
		" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` AS `t`".
		" {$join_additional} WHERE ( `t`.`id`='".$result['id']."') ". //`t`.`transID`='".$result['transID']."' AND 
		" ORDER BY `t`.`id` ASC ",$qprint //LIMIT 1
	);
	$remaining_balance_prev=$remaining_balance_prev[0];		//bill_amt
	$json_value_de=json_decode($remaining_balance_prev['json_value'],1);	//decoded json
	
	//calc remaining balance
	$result["remaining_balance_prev"]=number_formatf2((double)@$json_value_de['mature_fund']-(double)str_replace_minus($remaining_balance_prev['bill_amt']));
	
	
	return $result;
}



function ms_virtual_fee($uid){
        global $data; $result=array();
        $account=db_rows(
			"SELECT SUM(`virtual_fee`) AS `summ`, COUNT(id) AS `count` FROM `{$data['DbPrefix']}mer_setting`".
			" WHERE `merID`='{$uid}' AND `moto_status`='1' AND `acquirer_processing_mode`='1'". 
			" LIMIT 1");
	   $result['virtual_fee']=@$account[0]['summ'];
	   $result['virtual_count']=@$account[0]['count'];
       return $result;
}


//retrive maximum settlement days (period)
function ms_max_settelement_period($uid=0,$cdate=''){
	global $data; $dt=date("Y-m-d H:i:s");
	if($cdate){
		$dt=date("Y-m-d H:i:s",strtotime($cdate)); 
	}
	$result=array();
	//fetch minimum and maximum settlement period
	$max_settelement_period=db_rows(
		"SELECT MAX(`settelement_delay`) AS `settelement_delay`, MIN(`settelement_delay`) AS `min_settelement_period`".
		" FROM `{$data['DbPrefix']}mer_setting`".
		" WHERE `merID`='{$uid}'".
		" LIMIT 1",0
	);
	if($max_settelement_period[0]['min_settelement_period']){
		$result['min_settelement_period']=$max_settelement_period[0]['min_settelement_period'];	//minimum settlement period from DB
	}else{
		$result['min_settelement_period']=1;	//minimum settlement period default 1 day
	}
	$result['max_settelement_period']=$max_settelement_period[0]['settelement_delay'];	//maximum settlement period from DB

	$result['min_ptdate'] = date("Y-m-d H:i:s",strtotime("-{$result['min_settelement_period']} day",strtotime($dt)));	//minimum payout date
	$result['max_ptdate'] = date("Y-m-d H:i:s",strtotime("-{$result['max_settelement_period']} day",strtotime($dt)));	//maximum payout date
	
	return $result;	//return
}


//function for retrieve mer settings detail of a merchant
function fetch_ms_info($memId)
{
	global $data;
	$qprint=0;
	if(isset($_GET['qp'])){
		$qprint=1;
		echo "<hr/><==fetch_ms_info==><hr/>";
	}

	if(!empty($memId)) $where_clause = "AND `merID`='$memId'";
	else $where_clause = "";

	$result = db_rows(
		"SELECT `id`, `merID`, `acquirer_id`, `mdr_rate`, `txn_fee_success`, `reserve_rate`, `min_limit`, `max_limit`, `monthly_fee`, `virtual_fee`, `refund_fee`, `charge_back_fee_1`, `charge_back_fee_2`, `charge_back_fee_3`,`txn_fee_failed`,`cbk1` FROM `{$data['DbPrefix']}mer_setting` 
		WHERE `acquirer_id`!='' $where_clause ORDER BY acquirer_id",$qprint
	);

	$ac_detail_arr = array();
	foreach ($result as $key => $val) {
		$ac_detail_arr[$val['acquirer_id']] = $val;
	}
	return $ac_detail_arr;
}


//This function gw_used to manage the complete ledger of a clients.
function ms_trans_balance_calc_new($uid=0, $trans_detail_array=[],$currentDate='',$tr_id=0)
{
	global $data, $monthly_fee;	//define global variables

	//initilized the aaray and variables
	$result=array();
	$where_merID="";

	$current_date=date('Y-m-d H:i:s');
	$qprint=0;
	$account_curr	= "";
	$tdate_pd		= "";
	$monthly_vt_fee	= "";

	if(isset($_GET['qp'])){
		$qprint=1;
		echo "<hr/><==ms_trans_balance_calc_new==><hr/>";
	}

	$date_1st=TODAY_DATE_ONLY;	//store current date as a first date

	$date_2nd=$date_2nd_3="";

//	$date_2nd=date("Y-m-d",strtotime("+1 day",strtotime($date_1st)));

	if($currentDate){	//if $currentDate not empty then initilized date 1, date 2 and date 2-3

		if(is_array($currentDate)){
			$date_1st=date("Y-m-d",strtotime($currentDate['date_1st']));
			$date_2nd=date("Y-m-d",strtotime($currentDate['date_2nd']));
			$date_2nd_3=date("Y-m-d",strtotime("+1 day",strtotime($currentDate['date_2nd'])));
		}else {
			$date_1st=date("Y-m-d",strtotime($currentDate));
			$date_2nd=$date_1st;
			$date_2nd_3=date("Y-m-d",strtotime("+1 day",strtotime($date_1st)));
		}
		$tdate_pd="";
	}

	//if $uid (clients id) not empty then initilized currency, fee and balance etc of a clients 
	if($uid>0){
		$where_merID	=" AND ( `merID`='{$uid}' ) ";	//use uid as a merID
		

		$clients			=select_client_table($uid);		//fetch details of a client
		$account_curr	=$clients['default_currency'];
		$monthly_vt_fee	=$clients['monthly_fee'];

//		$monthly_fee=payout_trans_new($uid, 2, $trans_detail_array);
		$result['monthly_vt_fee']		= $monthly_fee['total_monthly_fee'];
		$result['monthly_vt_fee_max']	= $monthly_fee['per_monthly_fee'];
		$result['count_monthly_vt_fee']	= $monthly_fee['total_month_no'];
		$result['manual_adjust_balance']= $monthly_fee['manual_adjust_balance'];
	}

	//if transaction id define (exists) then fetch only transaction via id
	if($tr_id>0){
		$t_min_id=db_rows(
			"SELECT MIN(`id`) AS `id`".
			" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" WHERE `merID`='{$uid}'".
			" LIMIT 1",$qprint
		);

		$t_min_id=$t_min_id[0]['id'];

		$where_merID .=" AND ( `id`='{$tr_id}' ) ";
		

	//	initilized fee as blank
		$result['monthly_vt_fee']="";
		$result['monthly_vt_fee_max']="";
		$result['count_monthly_vt_fee']="";
		$result['manual_adjust_balance']="";
	}

	//Sales Volume mature
	$m_total_success	= 0;
	$m_total_mdr		= 0;
	$m_total_rolling	= 0;
	$m_count_id			= 0;

	//Sales Volume _immature
	$im_total_success	= 0;
	$im_total_mdr		= 0;
	$im_total_rolling	= 0;
	$im_count_id		= 0;

	//After Reserve rolling_amt mature
	$total_after_reserve_rolling	= 0;
	$after_res_roll_count_id		= 0;

	//After Reserve rolling_amt _immature
	$total_after_reserve_rolling_immature	= 0;
	$after_res_roll_count_id_im				= 0;

	//Failed
	$total_failed_sum		= 0;
	$total_failed_count_id	= 0;

	//Transaction mature
	$total_txn_fee_sum		= 0;
	$total_txn_fee_count_id	= 0;
	$min_id					= 0;
	$max_id					= 0;
	$min_tdate				= "";
	$max_tdate				= "";
	$min_payout_date		= "";
	$max_payout_date		= "";
	$mature_rolling			= 0;

	//Transaction _immature
	$total_txn_fee_sum_immature	= 0;
	$total_txn_fee_count_id_immature = 0;
	$min_id_immature			= 0;
	$max_id_immature			= 0;
	$min_tdate_immature			= "";
	$max_tdate_immature			= "";
	$min_payout_date_immature	= "";
	$max_payout_date_immature	= "";
	$mature_rolling_immature	= 0;

	//Chargeback	mature
	$total_amt_chargeback		= 0;
	$total_chargeback_fee		= 0;
	$count_id_chargeback_mature	= 0;

	//Chargeback	mature
	$total_amt_chargeback_immature	= 0;
	$total_chargeback_fee_immature	= 0;
	$count_id_chargeback_immature	= 0;

	//Return mature
	$total_amt_returned		= 0;
	$total_returned_fee		= 0;
	$count_id_return_mature	= 0;

	//Return _immature
	$total_amt_returned_immature	= 0;
	$total_returned_fee_immature	= 0;
	$count_id_return_mature_immature= 0;

	//Refund mature
	$total_amt_refunded_mature	= 0;
	$mdr_refundfee_amt_mature	= 0;
	$count_id_refund_mature		= 0;

	//Refund _immature
	$total_amt_refunded_immature	= 0;
	$mdr_refundfee_amt_immature		= 0;
	$count_id_refund_immature		= 0;

	//CBK1 mature
	$total_amt_cbk1	= 0;
	$total_cbk1_fee	= 0;
	$count_id_cbk1	= 0;

	//CBK1 _immature
	$total_amt_cbk1_immature	= 0;
	$total_cbk1_fee_immature	= 0;
	$count_id_cbk1_immature		= 0;

	//rolling Volume mature
	$summ_withdraw	= 0;
	$count_withdraw	= 0;

	//Withdraw Amount mature
	$total_withdraw		= 0;
	$count_id_withdraw	= 0;

	//Send Fund mature
	$total_send_fund	= 0;
	$count_id_send_fund	= 0;

	//Received Fund total_received_fund mature
	$summ_received_fund		= 0;
	$count_received_fund	= 0;

	//Rolling mature
	$summ_mature	= 0;
	$count_mature	= 0;

	//Rolling _immature
	$summ_immature	= 0;
	$count_immature	= 0;

	for($i=0;$i<count($trans_detail_array);$i++)
	{
		$temp_trans_arr = $trans_detail_array[$i];

		//Sales Volume mature -------------------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && (($temp_trans_arr['trans_status']=="1" || $temp_trans_arr['trans_status']=="7" || $temp_trans_arr['trans_status']=="8")) && fetchFormattedDate($temp_trans_arr['settelement_date'])<=TODAY_DATE_ONLY) {

		//date_comparison($temp_trans_arr['settelement_date'], TODAY_DATE_ONLY)

			$m_total_success	+=$temp_trans_arr['trans_amt'];
			$m_total_mdr		+=$temp_trans_arr['buy_mdr_amt'];
			$m_total_rolling	+=$temp_trans_arr['rolling_amt'];
			$m_count_id++;
		}
		//Sales Volume mature -------------------------END

		//Sales Volume _immature -------------------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && (($temp_trans_arr['trans_status']=="1" || $temp_trans_arr['trans_status']=="7" || $temp_trans_arr['trans_status']=="8")) && fetchFormattedDate($temp_trans_arr['settelement_date'])>TODAY_DATE_ONLY) {

			$im_total_success	+=$temp_trans_arr['trans_amt'];
			$im_total_mdr		+=$temp_trans_arr['buy_mdr_amt'];
			$im_total_rolling	+=$temp_trans_arr['rolling_amt'];
			$im_count_id++;
		}
		//Sales Volume _immature -------------------------END

		//After Reserve rolling_amt mature ---------3,5,6,11,12----------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && (($temp_trans_arr['trans_status']=="3" || $temp_trans_arr['trans_status']=="5" || $temp_trans_arr['trans_status']=="6" || $temp_trans_arr['trans_status']=="11" || $temp_trans_arr['trans_status']=="12")) && fetchFormattedDate($temp_trans_arr['settelement_date'])<=TODAY_DATE_ONLY) {

			$total_after_reserve_rolling +=$temp_trans_arr['rolling_amt'];
			$after_res_roll_count_id++;
		}
		//After Reserve rolling_amt mature-------------------------END

		//After Reserve rolling_amt _immature --------3,5,6,11,12-----------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && (($temp_trans_arr['trans_status']=="3" || $temp_trans_arr['trans_status']=="5" || $temp_trans_arr['trans_status']=="6" || $temp_trans_arr['trans_status']=="11" || $temp_trans_arr['trans_status']=="12")) && fetchFormattedDate($temp_trans_arr['settelement_date'])>TODAY_DATE_ONLY) {

			$total_after_reserve_rolling_immature	+=$temp_trans_arr['rolling_amt'];
			$after_res_roll_count_id_im++;
		}
		//After Reserve rolling_amt _immature -------------------------END

		//Failed----------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && $temp_trans_arr['trans_status']=="2") {

			$total_failed_sum	+=$temp_trans_arr['bill_amt'];
			$total_failed_count_id++;
		}
		//Failed----------------------END

		//Transaction mature---------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && fetchFormattedDate($temp_trans_arr['settelement_date'])<=TODAY_DATE_ONLY) {

			$total_txn_fee_sum	+=$temp_trans_arr['buy_txnfee_amt'];
			$total_txn_fee_count_id++;

			if($min_id>$temp_trans_arr['id'] || $min_id==0)		// fetch minimum id
				$min_id=$temp_trans_arr['id'];

			if($max_id<$temp_trans_arr['id'])					// fetch maxium id
				$max_id=$temp_trans_arr['id'];

			if($min_tdate>$temp_trans_arr['tdate'] || empty($min_tdate))		// fetch minimum tdate
				$min_tdate=$temp_trans_arr['tdate'];

			if($max_tdate<$temp_trans_arr['tdate'])		// fetch maxium tdate
				$max_tdate=$temp_trans_arr['tdate'];

			if($min_payout_date>$temp_trans_arr['settelement_date'] || empty($min_payout_date)) // fetch minimum settelement_date
				$min_payout_date=$temp_trans_arr['settelement_date'];

			if($max_payout_date<$temp_trans_arr['settelement_date']) // fetch maxium settelement_date
				$max_payout_date=$temp_trans_arr['settelement_date'];

			if($mature_rolling<$temp_trans_arr['rolling_date']) // fetch maxrolling_period_date
				$mature_rolling=$temp_trans_arr['rolling_date'];
		}
		//Transaction mature----------------------END

		//Transaction _immature---------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && fetchFormattedDate($temp_trans_arr['settelement_date'])>TODAY_DATE_ONLY) {

			$total_txn_fee_sum_immature	+=$temp_trans_arr['buy_txnfee_amt'];
			$total_txn_fee_count_id_immature++;

			if($min_id_immature>$temp_trans_arr['id'] || $min_id==0)		// fetch minimum id
				$min_id_immature=$temp_trans_arr['id'];

			if($max_id_immature<$temp_trans_arr['id'])					// fetch maxium id
				$max_id_immature=$temp_trans_arr['id'];

			if($min_tdate_immature>$temp_trans_arr['tdate'] || empty($min_tdate_immature))		// fetch minimum tdate
				$min_tdate_immature=$temp_trans_arr['tdate'];

			if($max_tdate_immature<$temp_trans_arr['tdate'])		// fetch maxium tdate
				$max_tdate_immature=$temp_trans_arr['tdate'];

			if($min_payout_date_immature>$temp_trans_arr['settelement_date'] || empty($min_payout_date_immature)) // fetch minimum settelement_date
				$min_payout_date_immature=$temp_trans_arr['settelement_date'];

			if($max_payout_date_immature<$temp_trans_arr['settelement_date']) // fetch maxium settelement_date
				$max_payout_date_immature=$temp_trans_arr['settelement_date'];

			if($mature_rolling_immature<$temp_trans_arr['rolling_date']) // fetch maxrolling_period_date
				$mature_rolling_immature=$temp_trans_arr['rolling_date'];
		}
		//Transaction _immature----------------------END

		//Chargeback mature----------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && ($temp_trans_arr['trans_status']=="5") && fetchFormattedDate($temp_trans_arr['settelement_date'])<=TODAY_DATE_ONLY) {

			$total_amt_chargeback	+=$temp_trans_arr['trans_amt'];
			$total_chargeback_fee	+=$temp_trans_arr['mdr_cb_amt'];
			$count_id_chargeback_mature++;
		}
		//Chargeback mature------------------END

		//Chargeback _immature----------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && ($temp_trans_arr['trans_status']=="5") && fetchFormattedDate($temp_trans_arr['settelement_date'])>TODAY_DATE_ONLY) {

			$total_amt_chargeback_immature	+=$temp_trans_arr['trans_amt'];
			$total_chargeback_fee_immature	+=$temp_trans_arr['mdr_cb_amt'];
			$count_id_chargeback_immature++;
		}
		//Chargeback _immature------------------END

		//Return mature----------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==12) && ($temp_trans_arr['trans_status']=="6") && fetchFormattedDate($temp_trans_arr['settelement_date'])<=TODAY_DATE_ONLY) {

			$total_amt_returned	+=$temp_trans_arr['total_amt_returned'];
			$total_returned_fee	+=$temp_trans_arr['total_returned_fee'];
			$count_id_return_mature++;
		}
		//Return mature------------------END

		//Return _immature----------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==12) && ($temp_trans_arr['trans_status']=="6") && fetchFormattedDate($temp_trans_arr['settelement_date'])>TODAY_DATE_ONLY) {

			$total_amt_returned_immature	+=$temp_trans_arr['total_amt_returned'];
			$total_returned_fee_immature	+=$temp_trans_arr['total_returned_fee'];
			$count_id_return_mature_immature++;
		}
		//Return _immature------------------END

		//Refund mature ---------3,12----------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && (($temp_trans_arr['trans_status']=="3" || $temp_trans_arr['trans_status']=="12")) && fetchFormattedDate($temp_trans_arr['settelement_date'])<=TODAY_DATE_ONLY) {

			$total_amt_refunded_mature	+=$temp_trans_arr['trans_amt'];
			$mdr_refundfee_amt_mature	+=$temp_trans_arr['mdr_refundfee_amt'];
			$count_id_refund_mature++;
		}
		//Refund mature-----------------------END

		//Refund mature ---------3,12----------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && (($temp_trans_arr['trans_status']=="3" || $temp_trans_arr['trans_status']=="12")) && fetchFormattedDate($temp_trans_arr['settelement_date'])>TODAY_DATE_ONLY) {

			$total_amt_refunded_immature	+=$temp_trans_arr['trans_amt'];
			$mdr_refundfee_amt_immature		+=$temp_trans_arr['mdr_refundfee_amt'];
			$count_id_refund_immature++;
		}
		//Refund mature-----------------------END

		//CBK1 mature ---------11----------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && ($temp_trans_arr['trans_status']=="11") && fetchFormattedDate($temp_trans_arr['settelement_date'])<=TODAY_DATE_ONLY) {

			$total_amt_cbk1	+=$temp_trans_arr['trans_amt'];
			$total_cbk1_fee	+=$temp_trans_arr['mdr_cbk1_amt'];
			$count_id_refund_mature++;
			$count_id_cbk1++;
		}
		//CBK1 mature-----------------------END

		//CBK1 _immature ---------11---------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && ($temp_trans_arr['trans_status']=="11") && fetchFormattedDate($temp_trans_arr['settelement_date'])>TODAY_DATE_ONLY) {

			$total_amt_cbk1_immature	+=$temp_trans_arr['trans_amt'];
			$total_cbk1_fee_immature	+=$temp_trans_arr['mdr_cbk1_amt'];
			$count_id_cbk1_immature++;
		}
		//CBK1 _immature-----------------------END

		//rolling Volume mature ---------1,14----------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==16) && ($temp_trans_arr['trans_status']=="1" || $temp_trans_arr['trans_status']=="14")) {

			$summ_withdraw	+=$temp_trans_arr['bill_amt'];
			$count_withdraw++;
		}
		//rolling Volume mature -----------------------END

		//Withdraw Amount mature ---------1,13----------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==15) && ($temp_trans_arr['trans_status']=="1" || $temp_trans_arr['trans_status']=="13")) {

			$total_withdraw	+=$temp_trans_arr['bill_amt'];
			$count_id_withdraw++;
		}
		//Withdraw Amount mature -----------------------END

		//Send Fund mature ---------1,15----------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==19) && ($temp_trans_arr['trans_status']=="1" || $temp_trans_arr['trans_status']=="15")) {

			$total_send_fund	+=$temp_trans_arr['bill_amt'];
			$count_id_send_fund++;
		}
		//Send Fund mature -----------------------END

		//Received Fund total_received_fund mature ---------1,15----------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==19) && ($temp_trans_arr['trans_status']=="1" || $temp_trans_arr['trans_status']=="15")) {

			$summ_received_fund	+=$temp_trans_arr['bill_amt'];
			$count_received_fund++;
		}
		//Send Fund mature -----------------------END

		//Rolling mature ---------1----------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && ($temp_trans_arr['trans_status']=="1") && fetchFormattedDate($temp_trans_arr['rolling_date'])<=TODAY_DATE_ONLY) {

			$summ_mature	+=$temp_trans_arr['rolling_amt'];
			$count_mature++;
		}
		//Rolling mature-----------------------END

		//Rolling _immature ---------1----------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && ($temp_trans_arr['trans_status']=="1") && fetchFormattedDate($temp_trans_arr['rolling_date'])>TODAY_DATE_ONLY) {

			$summ_immature	+=$temp_trans_arr['rolling_amt'];
			$count_immature++;
		}
		//Rolling _immature-----------------------END

	}	//END MAIN FOR LOOP

	//Sales Volume mature -------------------------
	$total_success[0]['total_success']	= $m_total_success;
	$total_success[0]['total_mdr']		= $m_total_mdr;
	$total_success[0]['total_rolling']	= $m_total_rolling;
	$total_success[0]['count_id']		= $m_count_id;

	//Sales Volume _immature --------------------------
	$total_success_immature[0]['total_success']	= $im_total_success;
	$total_success_immature[0]['total_mdr']		= $im_total_mdr;
	$total_success_immature[0]['total_rolling']	= $im_total_rolling;
	$total_success_immature[0]['count_id']		= $im_count_id;

	//After Reserve rolling_amt mature --------------------------
	$after_reserve_rolling[0]['total_after_reserve_rolling']	= $total_after_reserve_rolling;
	$after_reserve_rolling[0]['count_id']						= $after_res_roll_count_id;

	//After Reserve rolling_amt _immature --------------------------
	$after_reserve_rolling_immature[0]['total_after_reserve_rolling_immature']	= $total_after_reserve_rolling_immature;
	$after_reserve_rolling_immature[0]['count_id']	= $after_res_roll_count_id_im;

//Failed --------------------------
	$total_failed[0]['total_failed']	= $total_failed_sum;
	$total_failed[0]['count_id']		= $total_failed_count_id;

	//Transaction mature--------------------------
	$total_txn_fee[0]['total_txn_fee']	= $total_txn_fee_sum;
	$total_txn_fee[0]['count_id']		= $total_txn_fee_count_id;
	$total_txn_fee[0]['min_id']			= $min_id;
	$total_txn_fee[0]['max_id']			= $max_id;
	$total_txn_fee[0]['min_tdate']		= $min_tdate;
	$total_txn_fee[0]['max_tdate']		= $max_tdate;
	$total_txn_fee[0]['min_payout_date']= $min_payout_date;
	$total_txn_fee[0]['max_payout_date']= $max_payout_date;
	$total_txn_fee[0]['mature_rolling']	= $mature_rolling;

	//Transaction _immature--------------------------
	$total_txn_fee_immature[0]['total_txn_fee_immature']	= $total_txn_fee_sum_immature;
	$total_txn_fee_immature[0]['count_id']			= $total_txn_fee_count_id_immature;
	$total_txn_fee_immature[0]['min_id']			= $min_id_immature;
	$total_txn_fee_immature[0]['max_id']			= $max_id_immature;
	$total_txn_fee_immature[0]['min_tdate']			= $min_tdate_immature;
	$total_txn_fee_immature[0]['max_tdate']			= $max_tdate_immature;
	$total_txn_fee_immature[0]['min_payout_date']	= $min_payout_date_immature;
	$total_txn_fee_immature[0]['max_payout_date']	= $max_payout_date_immature;
	$total_txn_fee_immature[0]['mature_rolling']	= $mature_rolling_immature;

	//Chargeback mature --------------------------
	$chargeback[0]['total_amt_chargeback']	= $total_amt_chargeback;
	$chargeback[0]['total_chargeback_fee']	= $total_chargeback_fee;
	$chargeback[0]['count_id']				= $count_id_chargeback_mature;

	//Chargeback _immature --------------------------
	$chargeback_immature[0]['total_amt_chargeback_immature']	= $total_amt_chargeback_immature;
	$chargeback_immature[0]['total_chargeback_fee_immature']	= $total_chargeback_fee_immature;
	$chargeback_immature[0]['count_id']							= $count_id_chargeback_immature;

	//Return mature --------------------------
	$return[0]['total_amt_returned']	= $total_amt_returned;
	$return[0]['total_returned_fee']	= $total_returned_fee;
	$return[0]['count_id']				= $count_id_return_mature;

	//Return _immature --------------------------
	$return_immature[0]['total_amt_returned']	= $total_amt_returned_immature;
	$return_immature[0]['total_returned_fee']	= $total_returned_fee_immature;
	$return_immature[0]['count_id']				= $count_id_return_mature_immature;

	//Refund mature --------------------------
	$refund[0]['total_amt_refunded']	= $total_amt_refunded_mature;
	$refund[0]['total_refunded_fee']	= $mdr_refundfee_amt_mature;
	$refund[0]['count_id']				= $count_id_refund_mature;

	//Refund _immature --------------------------
	$refund_immature[0]['total_amt_refunded']	= $total_amt_refunded_immature;
	$refund_immature[0]['total_refunded_fee']	= $mdr_refundfee_amt_immature;
	$refund_immature[0]['count_id']				= $count_id_refund_immature;

	//CBK1 mature --------------------------
	$cbk1[0]['total_amt_cbk1']	= $total_amt_cbk1;
	$cbk1[0]['total_cbk1_fee']	= $total_cbk1_fee;
	$cbk1[0]['count_id']		= $count_id_cbk1;

	//CBK1 _immature --------------------------
	$cbk1_immature[0]['total_amt_cbk1']	= $total_amt_cbk1_immature;
	$cbk1_immature[0]['total_cbk1_fee']	= $total_cbk1_fee_immature;
	$cbk1_immature[0]['count_id']		= $count_id_cbk1_immature;

	//rolling Volume mature --------------------------
	$withdraw_rolling[0]['summ_withdraw']	= $summ_withdraw;
	$withdraw_rolling[0]['count_withdraw']	= $count_withdraw;

	//Withdraw Amount mature --------------------------
	$withdraw[0]['total_withdraw']	= $total_withdraw;
	$withdraw[0]['count_id']		= $count_id_withdraw;

	//Send Fund mature --------------------------
	$send_fund[0]['total_send_fund']= $total_send_fund;
	$send_fund[0]['count_id']		= $count_id_send_fund;

	//Received Fund total_received_fund mature --------------------------
	$received_fund[0]['summ_received_fund']	= $summ_received_fund;
	$received_fund[0]['count_received_fund']= $count_received_fund;
	
	//Rolling mature --------------------------
	$mature_roll[0]['summ_mature']	= $summ_mature;
	$mature_roll[0]['count_mature']	= $count_mature;

	//Rolling _immature --------------------------
	$immature_roll[0]['summ_immature']	= $summ_immature;
	$immature_roll[0]['count_immature']	= $count_immature;

	################ CALCULATION SECTION ############

	//Sales Volume	trans_amt
	$result['total_success']=number_formatf2($total_success[0]['total_success']);

	//Discount Rate	buy_mdr_amt
	$result['total_mdr']=number_formatf($total_success[0]['total_mdr']);

	//Holdback Reserve	rolling_amt
	$result['total_rolling']=($total_success[0]['total_rolling']);

	//success count	count_id
	$result['success_count']=$total_success[0]['count_id'];

	//Sales Volume	trans_amt
	$result['total_success_immature']=number_formatf2($total_success_immature[0]['total_success']);

	//Discount Rate	buy_mdr_amt
	$result['total_mdr_immature']=number_formatf($total_success_immature[0]['total_mdr']);

	//Holdback Reserve	rolling_amt
	$result['total_rolling_immature']=number_formatf($total_success_immature[0]['total_rolling']);

	//success count	count_id
	$result['success_count_immature']=$total_success_immature[0]['count_id'];

	$result['total_after_reserve_rolling']=number_formatf($after_reserve_rolling[0]['total_after_reserve_rolling']);

	//After Reserve	rolling_amt
	$result['total_after_reserve_rolling_immature']=number_formatf($after_reserve_rolling_immature[0]['total_after_reserve_rolling_immature']);

	//Failed Volume		amount
	$result['total_failed']=number_formatf2($total_failed[0]['total_failed']);

	//Failed Volume count		count_id
	$result['failed_count']=$total_failed[0]['count_id'];

	//Transaction Fee	buy_txnfee_amt
	$result['total_txn_fee']=number_formatf($total_txn_fee[0]['total_txn_fee']);

	//Transaction Fee count	count_id
	$result['total_txn_fee_count']=$total_txn_fee[0]['count_id'];

	//Transaction Payout Date
	$result['mature_fund']=$total_txn_fee[0]['max_payout_date'];

	//Rolling Payout Date	rolling_date
	$result['mature_rolling']=($total_txn_fee[0]['mature_rolling']);

	//Transaction Payout Date
	$result['min_id']=$total_txn_fee[0]['min_id'];
	$result['max_id']=$total_txn_fee[0]['max_id'];
	$result['min_tdate']=$total_txn_fee[0]['min_tdate'];
	$result['max_tdate']=$total_txn_fee[0]['max_tdate'];
	$result['min_payout_date']=$total_txn_fee[0]['min_payout_date'];
	$result['max_payout_date']=$total_txn_fee[0]['max_payout_date'];

	//Transaction _immature--------------------------

	//Transaction Fee	buy_txnfee_amt
	$result['total_txn_fee_immature']=number_formatf($total_txn_fee_immature[0]['total_txn_fee_immature']);
	//Transaction Fee count	count_id
	$result['total_txn_fee_immature_count']=$total_txn_fee_immature[0]['count_id'];

	//Chargeback	mature --------------------------

	//Chargeback	trans_amt
	$result['total_amt_chargeback']=number_formatf($chargeback[0]['total_amt_chargeback']);

	//Chargeback Fee	mdr_cb_amt
	$result['total_chargeback_fee']=number_formatf($chargeback[0]['total_chargeback_fee']);

	//Chargeback count	count_id
	$result['chargeback_count']=$chargeback[0]['count_id'];

	//Chargeback	_immature --------------------------
	//Chargeback	trans_amt
	$result['total_amt_chargeback_immature']=number_formatf2($chargeback_immature[0]['total_amt_chargeback_immature']);

	//Chargeback Fee	mdr_cb_amt
	$result['total_chargeback_fee_immature']=number_formatf($chargeback_immature[0]['total_chargeback_fee_immature']);

	//Chargeback count	count_id
	$result['chargeback_count_immature']=$chargeback_immature[0]['count_id'];

	//Return mature --------------------------

	//Return		trans_amt
	$result['total_amt_returned']=number_formatf2($return[0]['total_amt_returned']);

	//Return Fee	mdr_refundfee_amt
	$result['total_returned_fee']=number_formatf($return[0]['total_returned_fee']);

	//Return count	count_id
	$result['return_count']=$return[0]['count_id'];

	//Return	_immature --------------------------
	//Return		trans_amt
	$result['total_amt_returned_immature']=number_formatf2($return_immature[0]['total_amt_returned']);

	//Return Fee	mdr_refundfee_amt
	$result['total_returned_fee_immature']=number_formatf($return_immature[0]['total_returned_fee']);

	//Return count	count_id
	$result['return_count_immature']=$return_immature[0]['count_id'];

	//Refund mature --------------------------
	//Refund	trans_amt
	$result['total_amt_refunded']=number_formatf2($refund[0]['total_amt_refunded']);

	//Refund Fee	mdr_refundfee_amt
	$result['total_refunded_fee']=number_formatf($refund[0]['total_refunded_fee']);

	//Refund count
	$result['refunded_count']=$refund[0]['count_id'];

	//Refund _immature --------------------------
	//Refund	trans_amt
	$result['total_amt_refunded_immature']=number_formatf2($refund_immature[0]['total_amt_refunded']);

	//Refund Fee	mdr_refundfee_amt
	$result['total_refunded_fee_immature']=number_formatf($refund_immature[0]['total_refunded_fee']);

	//Refund count
	$result['refunded_count_immature']=$refund_immature[0]['count_id'];

	//CBK1 mature --------------------------
	//CBK1		trans_amt
	$result['total_amt_cbk1']=number_formatf2($cbk1[0]['total_amt_cbk1']);

	//CBK1 Fee	mdr_refundfee_amt
	$result['total_cbk1_fee']=number_formatf($cbk1[0]['total_cbk1_fee']);

	//CBK1 count
	$result['cbk1_count']=$cbk1[0]['count_id'];

	//CBK1 _immature -----------------------

	//CBK1		trans_amt
	$result['total_amt_cbk1_immature']=number_formatf2($cbk1_immature[0]['total_amt_cbk1']);

	//CBK1 Fee	mdr_refundfee_amt
	$result['total_cbk1_fee_immature']=number_formatf($cbk1_immature[0]['total_cbk1_fee']);

	//CBK1 count
	$result['cbk1_count_immature']=$cbk1_immature[0]['count_id'];

	//rolling Volume mature --------------------------

	$result['summ_withdraw_roll']=number_formatf2((double)$withdraw_rolling[0]['summ_withdraw']);
	$result['count_withdraw_roll']=$withdraw_rolling[0]['count_withdraw'];

	//amount | Withdraw Amount | s:1,13 | t:wd

	//Withdraw Amount	amount
	$result['summ_withdraw_amt_1']=str_replace("-","",$withdraw[0]['total_withdraw']);
	$result['total_withdraw']=$withdraw[0]['total_withdraw'];
	//Withdraw count	count_id
	$result['withdraw_count']=$withdraw[0]['count_id'];

	//amount | Send Fund | s:1,15 | t:af

	//Send Fund	amount
	$result['total_send_fund']=$send_fund[0]['total_send_fund'];
	//Send Fund	count_id
	$result['send_fund_count']=$send_fund[0]['count_id'];
	$result['summ_send_fund_amt']=str_replace("-","",$send_fund[0]['total_send_fund']);

	// received_fund
	$result['total_received_fund']=str_replace("-","",$received_fund[0]['summ_received_fund']);
	$result['summ_received_fund']=$received_fund[0]['summ_received_fund'];
	$result['received_fund_count']=$received_fund[0]['count_received_fund'];
	$result['summ_received_fund_amt']=(double)$result['total_received_fund'];

	//Monthly Maintenance Fee
	$result['monthly_maintenance_fee']="";

	$result['summ_withdraw_amt_1']=str_replace("-","",(double)$result['total_withdraw']);
	$result['summ_withdraw_amt']=$result['total_withdraw']+$result['total_send_fund'];
	$result['summ_withdraw']=prnpays_crncy($result['total_withdraw'],'','',$account_curr);
	$result['count_withdraw']=$result['withdraw_count']+$result['send_fund_count'];

	//buy_txnfee_amt
	$total_all_fee=$result['total_mdr']+$result['total_rolling']-$result['total_after_reserve_rolling']+$result['total_txn_fee']-$result['total_amt_chargeback']-$result['total_chargeback_fee']-$result['total_amt_returned'] -$result['total_returned_fee']-$result['total_amt_refunded']-$result['total_refunded_fee']-$result['total_amt_cbk1']-$result['total_cbk1_fee'];

	$result['summ_mature_1']=number_formatf2((double)$result['total_success']-$total_all_fee);

	if($result['monthly_maintenance_fee']){
		$total_all_fee=$total_all_fee+$result['monthly_maintenance_fee'];
	}

	//calc mature

	$total_payable_to_merchant=(double)$result['total_success']-(double)$total_all_fee;

	$total_payable_to_merchant=$total_payable_to_merchant+(double)$result['total_withdraw'];
	$total_payable_to_merchant=$total_payable_to_merchant+(double)$result['total_send_fund'];
	$total_payable_to_merchant=$total_payable_to_merchant-$result['summ_received_fund'];

	if($result['manual_adjust_balance']){
		$total_payable_to_merchant=$total_payable_to_merchant+$result['manual_adjust_balance'];
	}

	$result['summ_mature_amt']=$total_payable_to_merchant;

	$result['summ_mature']=prnpays_crncy($result['summ_mature_amt'],'','',$account_curr);

	$result['count_mature']=$result['success_count']-$result['success_count_immature'];

	// calc _immature
	$total_all_fee_immature=$result['total_mdr_immature']+$result['total_rolling_immature']-$result['total_after_reserve_rolling_immature']+$result['total_txn_fee_immature']-$result['total_amt_chargeback_immature']-$result['total_chargeback_fee_immature']-$result['total_amt_returned_immature'] -$result['total_returned_fee_immature']-$result['total_amt_refunded_immature']-$result['total_refunded_fee_immature']-$result['total_amt_cbk1_immature']-$result['total_cbk1_fee_immature'];

	//calc immature
	$total_payable_to_merchant_immature=(double)$result['total_success_immature']-(double)$total_all_fee_immature;

	$result['summ_immature_amt']=$total_payable_to_merchant_immature;

	$result['summ_immature']=prnpays_crncy($result['summ_immature_amt'],'','',$account_curr);
	$result['count_immature']=$result['success_count_immature'];

	//calc total balance
	$summ_total=$result['summ_immature_amt']+$result['summ_mature_amt'];
	$result['summ_total_amt']=$summ_total;
	$result['summ_total']=prnpays_crncy($summ_total,'','',$account_curr);
	$result['count_total']=$result['count_immature']+$result['count_mature'];

	####### ROLLING ########

	//Rolling mature --------------------------

	$result['summ_mature_roll']=number_formatf2((double)$mature_roll[0]['summ_mature']+$result['summ_withdraw_roll']);
	$result['count_mature_roll']=$mature_roll[0]['count_mature']-$result['count_withdraw_roll'];

	//Rolling _immature --------------------------

	$result['summ_immature_roll']=number_formatf((double)$immature_roll[0]['summ_immature']);
	$result['count_immature_roll']=$immature_roll[0]['count_immature'];

	// total rolling calc

	$result['summ_total_roll']=number_formatf2($result['summ_immature_roll']+$result['summ_mature_roll']);
	$result['count_total_roll']=$result['count_immature_roll']+$result['count_mature_roll'];
	$result['account_curr']=$account_curr;
	$result['account_curr_sys']=get_currency($account_curr);

	if(isset($_GET['qp'])){
		print_r($result);
	}

	return $result;
}




//This functions used to update complete ledger of a clients.
function ms_trans_balance_calc_d_new($uid=0,$currentDate='',$tr_id=0,$trans_detail_array=[])
{
	//print_r($trans_detail_array);exit;
	global $data, $monthly_fee; 

	$result=array();
	$where_merID="";

	$current_date=date('Y-m-d H:i:s');
	$qprint=0;$account_curr="";$monthly_vt_fee="";
	if(isset($_GET['qp']))
	{
		$qprint=1;
		echo "<hr/><==account_trans_balance_calc==><hr/>";
	}

	$acc_table_data = fetch_ms_info($uid);		//fetch data from a/c table of a clients

	$date_1st=date('Y-m-d');

	$date_2nd=date("Y-m-d",strtotime("+1 day",strtotime($date_1st)));

	$query_set=true;

	//check current date, if exists then assign date_1st, 2nd and 2nd_3 of behafe of current date
	if($currentDate){
		if(is_array($currentDate)){
			$date_1st=date("Ymd",strtotime($currentDate['date_1st']));
			$date_2nd=date("Ymd",strtotime($currentDate['date_2nd']));
			$date_2nd_3=date("Y-m-d",strtotime("+1 day",strtotime($currentDate['date_2nd'])));
		}else {
			$date_1st=date("Ymd",strtotime($currentDate));
			$date_2nd=$date_1st;
			$date_2nd_3=date("Y-m-d",strtotime("+1 day",strtotime($date_1st)));
		}
	}

	// ----------------------

	//if uid define and not empty then received clients information behalf of $uid
	if($uid>0){
		$where_merID=" AND ( `merID`='{$uid}' ) ";
		$clients			= select_client_table($uid);		//fetch client detail
		$account_curr=$clients['default_currency'];
		$monthly_vt_fee=$clients['monthly_fee'];

	//	$monthly_fee=payout_trans_new($uid, 2, $trans_detail_array);
		$result['monthly_vt_fee']			= @$monthly_fee['total_monthly_fee'];
		$result['monthly_vt_fee_max']		= @$monthly_fee['per_monthly_fee'];
		$result['count_monthly_vt_fee']		= @$monthly_fee['total_month_no'];
		$result['manual_adjust_balance']	= @$monthly_fee['manual_adjust_balance'];
	}

	//if tr_id is exist then execute data only tr_id
	if($tr_id>0){
		$t_min_id=db_rows(
			"SELECT MIN(`id`) AS `id`".
			" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" WHERE `merID`='{$uid}'".
			" LIMIT 1",$qprint
		);

		$t_min_id=$t_min_id[0]['id'];

		$where_merID .=" AND ( `id`='{$tr_id}' ) ";


		$result['monthly_vt_fee']="";
		$result['monthly_vt_fee_max']="";
		$result['count_monthly_vt_fee']="";
		$result['manual_adjust_balance']="";
	}

	$pr=0;
	if(isset($_GET['pr'])&&$_GET['pr']==1){
		$pr=1;
	}elseif(isset($_GET['pr'])&&$_GET['pr']==2){
		$pr=1;$qprint=1;
	}

	############### --- START CALCULATION VIA LOOP -- ##########

	//Failed ------------------------
	$sum_total_failed	= 0;
	$failed_count		= 0;

	//Chargeback mature ----------------------
	$total_amt_chargeback	= 0;
	$chargeback_count		= 0;

	//Chargeback _immature --------------------------
	$total_amt_chargeback_immature	= 0;
	$chargeback_count_immature		= 0;

	//Return mature ----------------------
	$total_amt_returned		= 0;
	$returned_count_mature	= 0;

	//return_immature_immature -------------------------
	$total_amt_return_immature	= 0;
	$returned_count_immature	= 0;

	//rolling Volume mature ------------------
	$summ_withdraw	= 0;
	$count_withdraw	= 0;

	//Withdraw Amount mature ---------
	$total_withdraw			= 0;
	$total_withdraw_count	= 0;

	//Send Fund mature -------------------
	$total_send_fund	= 0;
	$send_fund_count	= 0;

	//Received Fund	mature ---
	$summ_received_fund		= 0;
	$count_received_fund	= 0;

	//Rolling mature -----------------
	$summ_mature	= 0;
	$count_mature	= 0;

	//Rolling _immature ------------------
	$summ_immature	= 0;
	$count_immature	= 0;

	//Sales Volume mature
	$m_total_success	= 0;
	$m_total_mdr		= 0;
	$m_total_rolling	= 0;
	$m_count_id			= 0;

	//Sales Volume _immature
	$im_total_success	= 0;
	$im_total_mdr		= 0;
	$im_total_rolling	= 0;
	$im_count_id		= 0;

	//After Reserve rolling_amt mature
	$total_after_reserve_rolling	= 0;
	$after_res_roll_count_id		= 0;

	//After Reserve rolling_amt _immature
	$total_after_reserve_rolling_immature	= 0;
	$after_res_roll_count_id_im				= 0;

	//Transaction mature
	$total_txn_fee_sum		= 0;
	$total_txn_fee_count_id	= 0;
	$min_id					= 0;
	$max_id					= 0;
	$min_tdate				= "";
	$max_tdate				= "";
	$min_payout_date		= "";
	$max_payout_date		= "";
	$mature_rolling			= 0;

	//Transaction _immature
	$total_txn_fee_sum_immature	= 0;
	$total_txn_fee_count_id_immature = 0;
	$min_id_immature			= 0;
	$max_id_immature			= 0;
	$min_tdate_immature			= "";
	$max_tdate_immature			= "";
	$min_payout_date_immature	= "";
	$max_payout_date_immature	= "";
	$mature_rolling_immature	= 0;

	//Transaction mature txn failed ----------------------
	$sum_failed_txn_mature	= 0;
	$failed_count_mature	= 0;

	//Transaction _immature txn failed -------------------------
	$sum_failed_txn_immature	= 0;
	$failed_count_immature		= 0;

	//Chargeback mature---------------
	$sum_chargeback1_mature		= 0;
	$chargeback1_count_mature	= 0;

	$sum_chargeback2_mature		= 0;
	$chargeback2_count_mature	= 0;

	$sum_chargeback3_mature		= 0;
	$chargeback3_count_mature	= 0;

	//Chargeback immature------------
	$sum_chargeback1_immature	= 0;
	$chargeback1_count_immature	= 0;

	$sum_chargeback2_immature	= 0;
	$chargeback2_count_immature	= 0;

	$sum_chargeback3_immature	= 0;
	$chargeback3_count_immature	= 0;

	//Return mature --------------------
	$return_charge_back_fee1_mature	= 0;
	$return_count1_mature			= 0;

	$return_charge_back_fee2_mature	= 0;
	$return_count2_mature			= 0;

	$return_charge_back_fee3_mature	= 0;
	$return_count3_mature			= 0;

	//Return _imimmature -------------------------
	$return_charge_back_fee1_immature	= 0;
	$return_count1_immature				= 0;

	$return_charge_back_fee2_immature	= 0;
	$return_count2_immature				= 0;

	$return_charge_back_fee3_immature	= 0;
	$return_count3_immature				= 0;

	//Refund mature ----------------------
	$sum_refund_mature		= 0;
	$fee_refund_mature		= 0;
	$count_refund_mature	= 0;

	//Refund immature --------------------------
	$sum_refund_immature	= 0;
	$fee_refund_immature	= 0;
	$count_refund_immature	= 0;

	//CBK1 mature ----------------
	$total_amt_cbk1_mature		= 0;
	$total_cbk1_fee_mature		= 0;
	$total_cbk1_count_mature	= 0;

	//CBK1 _immature --------------------------
	$total_amt_cbk1_immature	= 0;
	$total_cbk1_immature_fee	= 0;
	$total_cbk1_immature_count	= 0;

	//fetch total gst fee
	$total_gst_fee	= 0;
	$total_gst_count= 0;
	for($i=0;$i<count($trans_detail_array);$i++)
	{
		$temp_trans_arr = $trans_detail_array[$i];

		$trans_type = $temp_trans_arr['acquirer'];

		//Failed -------------------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && ($temp_trans_arr['trans_status']=="2")) 
		{
			$sum_total_failed	+=$temp_trans_arr['bill_amt'];
			$failed_count++;
		}
		//Failed 

		//Chargeback mature -------------------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && ($temp_trans_arr['trans_status']=="5") && (fetchFormattedDate($temp_trans_arr['settelement_date'])<=TODAY_DATE_ONLY)) 
		{
			$total_amt_chargeback	+=$temp_trans_arr['trans_amt'];
			$chargeback_count++;
		}
		//Chargeback mature

		//Chargeback _immature -------------------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && ($temp_trans_arr['trans_status']=="5") && (fetchFormattedDate($temp_trans_arr['settelement_date'])>TODAY_DATE_ONLY)) 
		{

			$total_amt_chargeback_immature	+=$temp_trans_arr['trans_amt'];
			$chargeback_count_immature++;
		}
		//Chargeback _immature

		//Return mature ---------START :: NOTE : settelement_date condtion was not in query added extra
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==12) && ($temp_trans_arr['trans_status']=="6") && (fetchFormattedDate($temp_trans_arr['settelement_date'])<=TODAY_DATE_ONLY)) 
		{
			$total_amt_returned	+=$temp_trans_arr['trans_amt'];
			$returned_count_mature++;
		}
		//Return mature

		//Return _immature -------------------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==12) && ($temp_trans_arr['trans_status']=="6") && (fetchFormattedDate($temp_trans_arr['settelement_date'])>TODAY_DATE_ONLY)) 
		{
			$total_amt_return_immature	+=$temp_trans_arr['trans_amt'];
			$returned_count_immature++;
		}
		//Return _immature

		//GST Fee -------------------------START
		if((isset($data['con_name'])&&$data['con_name']=='clk') && ($temp_trans_arr['merID']=="$uid"||$temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11)) 
		{
			
			$total_gst_fee	+=$temp_trans_arr['gst_amt'];
			$total_gst_count++;
		}
		///GST Fee
		//Rolling Volume mature -------------------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==16) && ($temp_trans_arr['trans_status']=="1" || $temp_trans_arr['trans_status']=="14")) 
		{
			$summ_withdraw	+=$temp_trans_arr['bill_amt'];
			$count_withdraw++;
		}
		//Rolling Volume mature 

		//Withdraw Amount mature -------------------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==15) && ($temp_trans_arr['trans_status']=="1" || $temp_trans_arr['trans_status']=="13")) 
		{
			$total_withdraw	+=$temp_trans_arr['bill_amt'];
			$total_withdraw_count++;
		}
		//Withdraw Amount mature

		//Send Fund mature -------------------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==19) && ($temp_trans_arr['trans_status']=="1" || $temp_trans_arr['trans_status']=="15")) 
		{
			$total_send_fund	+=$temp_trans_arr['bill_amt'];
			$send_fund_count++;
		}
		//Send Fund mature

		//Received Fund mature -------------------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==19) && ($temp_trans_arr['trans_status']=="1" || $temp_trans_arr['trans_status']=="15")) 
		{
			$summ_received_fund	+=$temp_trans_arr['bill_amt'];
			$count_received_fund++;
		}
		//Received Fund mature

		//Rolling mature ---------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && ($temp_trans_arr['trans_status']=="1") && fetchFormattedDate($temp_trans_arr['rolling_date'])<=TODAY_DATE_ONLY) 
		{
			$summ_mature	+=$temp_trans_arr['rolling_amt'];
			$count_mature++;
		}
		//Rolling mature ---------END

		//Rolling _immature ---------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && ($temp_trans_arr['trans_status']=="1") && fetchFormattedDate($temp_trans_arr['rolling_date'])>TODAY_DATE_ONLY) 
		{
			$summ_immature	+=$temp_trans_arr['rolling_amt'];
			$count_immature++;
		}
		//Rolling _immature ---------END

		//Sales Volume mature -------------------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && (($temp_trans_arr['trans_status']=="1" || $temp_trans_arr['trans_status']=="7" || $temp_trans_arr['trans_status']=="8")) && fetchFormattedDate($temp_trans_arr['settelement_date'])<=TODAY_DATE_ONLY) 
		{
			$m_total_success	+=$temp_trans_arr['trans_amt'];

			$m_total_mdr		+= ((($temp_trans_arr['trans_amt'])*getNumericValue($acc_table_data[$trans_type]['mdr_rate']))/100);

			$m_total_rolling	+= ((($temp_trans_arr['trans_amt'])*getNumericValue($acc_table_data[$trans_type]['reserve_rate']))/100);

			$m_count_id++;
		}
		//Sales Volume mature -------------------------END

		//Sales Volume _immature -------------------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && (($temp_trans_arr['trans_status']=="1" || $temp_trans_arr['trans_status']=="7" || $temp_trans_arr['trans_status']=="8")) && fetchFormattedDate($temp_trans_arr['settelement_date'])>TODAY_DATE_ONLY) 
		{
			$im_total_success	+=$temp_trans_arr['trans_amt'];

			$im_total_mdr		+= ((($temp_trans_arr['trans_amt'])*getNumericValue($acc_table_data[$trans_type]['mdr_rate']))/100);

			$im_total_rolling	+= ((($temp_trans_arr['trans_amt'])*getNumericValue($acc_table_data[$trans_type]['reserve_rate']))/100);

			$im_count_id++;
		}
		//Sales Volume _immature -------------------------END

		//After Reserve rolling_amt mature ---------3,5,6,11,12----------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && ($temp_trans_arr['trans_status']=="3" || $temp_trans_arr['trans_status']=="5" || $temp_trans_arr['trans_status']=="6" || $temp_trans_arr['trans_status']=="11" || $temp_trans_arr['trans_status']=="12") && fetchFormattedDate($temp_trans_arr['settelement_date'])<=TODAY_DATE_ONLY) 
		{
			$total_after_reserve_rolling += ((($temp_trans_arr['trans_amt'])*getNumericValue($acc_table_data[$trans_type]['reserve_rate']))/100);
			$after_res_roll_count_id++;
		}
		//After Reserve rolling_amt mature-------------------------END

		//After Reserve rolling_amt _immature --------3,5,6,11,12-----------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && ($temp_trans_arr['trans_status']=="3" || $temp_trans_arr['trans_status']=="5" || $temp_trans_arr['trans_status']=="6" || $temp_trans_arr['trans_status']=="11" || $temp_trans_arr['trans_status']=="12") && fetchFormattedDate($temp_trans_arr['settelement_date'])>TODAY_DATE_ONLY) 
		{
			$total_after_reserve_rolling_immature += ((($temp_trans_arr['trans_amt'])*getNumericValue($acc_table_data[$trans_type]['reserve_rate']))/100);
			$after_res_roll_count_id_im++;
		}
		//After Reserve rolling_amt _immature -------------------------END

		//Transaction mature---------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && ($temp_trans_arr['trans_status']=="1" || $temp_trans_arr['trans_status']=="7" || $temp_trans_arr['trans_status']=="8") && fetchFormattedDate($temp_trans_arr['settelement_date'])<=TODAY_DATE_ONLY) 
		{
			$total_txn_fee_sum	+=getNumericValue($acc_table_data[$trans_type]['txn_fee_success']);
			$total_txn_fee_count_id++;

			if($min_id>$temp_trans_arr['id'] || $min_id==0)		// fetch minimum id
				$min_id=$temp_trans_arr['id'];

			if($max_id<$temp_trans_arr['id'])					// fetch maxium id
				$max_id=$temp_trans_arr['id'];

			if($min_tdate>$temp_trans_arr['tdate'] || empty($min_tdate))		// fetch minimum tdate
				$min_tdate=$temp_trans_arr['tdate'];

			if($max_tdate<$temp_trans_arr['tdate'])		// fetch maxium tdate
				$max_tdate=$temp_trans_arr['tdate'];

			if($min_payout_date>$temp_trans_arr['settelement_date'] || empty($min_payout_date)) // fetch minimum settelement_date
				$min_payout_date=$temp_trans_arr['settelement_date'];

			if($max_payout_date<$temp_trans_arr['settelement_date']) // fetch maxium settelement_date
				$max_payout_date=$temp_trans_arr['settelement_date'];

			if($mature_rolling<$temp_trans_arr['rolling_date']) // fetch maxrolling_period_date
				$mature_rolling=$temp_trans_arr['rolling_date'];
		}
		//Transaction mature----------------------END

		//Transaction _immature---------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && ($temp_trans_arr['trans_status']=="1" || $temp_trans_arr['trans_status']=="7" || $temp_trans_arr['trans_status']=="8") && fetchFormattedDate($temp_trans_arr['settelement_date'])>TODAY_DATE_ONLY) 
		{
			$total_txn_fee_sum_immature	+=getNumericValue($acc_table_data[$trans_type]['txn_fee_success']);
			$total_txn_fee_count_id_immature++;

			if($min_id_immature>$temp_trans_arr['id'] || $min_id_immature==0)		// fetch minimum id
				$min_id_immature=$temp_trans_arr['id'];

			if($max_id_immature<$temp_trans_arr['id'])					// fetch maxium id
				$max_id_immature=$temp_trans_arr['id'];

			if($min_tdate_immature>$temp_trans_arr['tdate'] || empty($min_tdate_immature))		// fetch minimum tdate
				$min_tdate_immature=$temp_trans_arr['tdate'];

			if($max_tdate_immature<$temp_trans_arr['tdate'])		// fetch maxium tdate
				$max_tdate_immature=$temp_trans_arr['tdate'];

			if($min_payout_date_immature>$temp_trans_arr['settelement_date'] || empty($min_payout_date_immature)) // fetch minimum settelement_date
				$min_payout_date_immature=$temp_trans_arr['settelement_date'];

			if($max_payout_date_immature<$temp_trans_arr['settelement_date']) // fetch maxium settelement_date
				$max_payout_date_immature=$temp_trans_arr['settelement_date'];

			if($mature_rolling_immature<$temp_trans_arr['rolling_date']) // fetch maxrolling_period_date
				$mature_rolling_immature=$temp_trans_arr['rolling_date'];
		}
		//Transaction _immature----------------------END

		//Transaction _mature txn failed -------------------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && ($temp_trans_arr['trans_status']=="2") && fetchFormattedDate($temp_trans_arr['settelement_date'])<=TODAY_DATE_ONLY) 
		{
			if(isset($acc_table_data[$trans_type]['txn_fee_failed']))
			{
				$sum_failed_txn_mature += getNumericValue($acc_table_data[$trans_type]['txn_fee_failed']);
				$failed_count_mature++;
			}
		}
		//Transaction _mature txn failed-------------------------END

		//Transaction _immature txn failed -------------------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && ($temp_trans_arr['trans_status']=="2") && fetchFormattedDate($temp_trans_arr['settelement_date'])>TODAY_DATE_ONLY) 
		{
			$sum_failed_txn_immature += getNumericValue($acc_table_data[$trans_type]['txn_fee_failed']);
			$failed_count_immature++;
		}
		//Transaction _immature txn failed-------------------------END

		//Chargeback mature -------------------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && ($temp_trans_arr['trans_status']=="5") && fetchFormattedDate($temp_trans_arr['settelement_date'])<=TODAY_DATE_ONLY) 
		{
			if($temp_trans_arr['risk_ratio']>"0" && $temp_trans_arr['risk_ratio']<="1")
			{
				$sum_chargeback1_mature += getNumericValue($acc_table_data[$trans_type]['charge_back_fee_1']);
				$chargeback1_count_mature++;
			}
			elseif($temp_trans_arr['risk_ratio']>"1" && $temp_trans_arr['risk_ratio']<="3")
			{
				$sum_chargeback2_mature += getNumericValue($acc_table_data[$trans_type]['charge_back_fee_2']);
				$chargeback2_count_mature++;
			}
			elseif($temp_trans_arr['risk_ratio']>"3" && $temp_trans_arr['risk_ratio']<="100")
			{
				$sum_chargeback3_mature += getNumericValue($acc_table_data[$trans_type]['charge_back_fee_3']);
				$chargeback3_count_mature++;
			}
		}
		//Chargeback mature-------------------------END

		//Chargeback mature -------------------------START
		elseif(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && ($temp_trans_arr['trans_status']=="5") && fetchFormattedDate($temp_trans_arr['settelement_date'])>TODAY_DATE_ONLY) 
		{
			if($temp_trans_arr['risk_ratio']>"0" && $temp_trans_arr['risk_ratio']<="1")
			{
				$sum_chargeback1_immature += getNumericValue($acc_table_data[$trans_type]['charge_back_fee_1']);
				$chargeback1_count_immature++;
			}
			elseif($temp_trans_arr['risk_ratio']>"1" && $temp_trans_arr['risk_ratio']<="3")
			{
				$sum_chargeback2_immature += getNumericValue($acc_table_data[$trans_type]['charge_back_fee_2']);
				$chargeback2_count_immature++;
			}
			elseif($temp_trans_arr['risk_ratio']>"3" && $temp_trans_arr['risk_ratio']<="100")
			{
				$sum_chargeback3_immature += getNumericValue($acc_table_data[$trans_type]['charge_back_fee_3']);
				$chargeback3_count_immature++;
			}
		}
		//Chargeback _immature-------------------------END

		//Return mature -------------------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==12) && ($temp_trans_arr['trans_status']=="6") && fetchFormattedDate($temp_trans_arr['settelement_date'])<=TODAY_DATE_ONLY) 
		{
			if($temp_trans_arr['risk_ratio']>"0" && $temp_trans_arr['risk_ratio']<="10")
			{
				$return_charge_back_fee1_mature += getNumericValue($acc_table_data[$trans_type]['charge_back_fee_1']);
				$return_count1_mature++;
			}
			elseif($temp_trans_arr['risk_ratio']>"10" && $temp_trans_arr['risk_ratio']<="20")
			{
				$return_charge_back_fee2_mature += getNumericValue($acc_table_data[$trans_type]['charge_back_fee_2']);
				$return_count2_mature++;
			}
			elseif($temp_trans_arr['risk_ratio']>"30" && $temp_trans_arr['risk_ratio']<="100")
			{
				$return_charge_back_fee3_mature += getNumericValue($acc_table_data[$trans_type]['charge_back_fee_3']);
				$return_count3_mature++;
			}
		}
		//Return mature-------------------------END

		//Return mature -------------------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==12) && ($temp_trans_arr['trans_status']=="6") && fetchFormattedDate($temp_trans_arr['settelement_date'])>TODAY_DATE_ONLY) 
		{
			if($temp_trans_arr['risk_ratio']>"0" && $temp_trans_arr['risk_ratio']<="10")
			{
				$return_charge_back_fee1_immature += getNumericValue($acc_table_data[$trans_type]['charge_back_fee_1']);
				$return_count1_immature++;
			}
			elseif($temp_trans_arr['risk_ratio']>"10" && $temp_trans_arr['risk_ratio']<="20")
			{
				$return_charge_back_fee2_immature += getNumericValue($acc_table_data[$trans_type]['charge_back_fee_2']);
				$return_count2_immature++;
			}
			elseif($temp_trans_arr['risk_ratio']>"30" && $temp_trans_arr['risk_ratio']<="100")
			{
				$return_charge_back_fee3_immature += getNumericValue($acc_table_data[$trans_type]['charge_back_fee_3']);
				$return_count3_immature++;
			}
		}
		//Return mature-------------------------END

		//Refund mature -------------------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && ($temp_trans_arr['trans_status']=="3" || $temp_trans_arr['trans_status']=="12") && fetchFormattedDate($temp_trans_arr['settelement_date'])<=TODAY_DATE_ONLY) 
		{
			$sum_refund_mature += $temp_trans_arr['trans_amt'];
			$fee_refund_mature += getNumericValue($acc_table_data[$trans_type]['refund_fee']);
			$count_refund_mature++;
		}
		//Refund mature -------------------------END

		//Refund immature -------------------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && ($temp_trans_arr['trans_status']=="3" || $temp_trans_arr['trans_status']=="12") && fetchFormattedDate($temp_trans_arr['settelement_date'])>TODAY_DATE_ONLY) 
		{
			$sum_refund_immature += $temp_trans_arr['trans_amt'];
			$fee_refund_immature += getNumericValue($acc_table_data[$trans_type]['refund_fee']);
			$count_refund_immature++;
		}
		//Refund immature -------------------------END

		//CBK1 mature -------------------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && ($temp_trans_arr['trans_status']=="11") && fetchFormattedDate($temp_trans_arr['settelement_date'])<=TODAY_DATE_ONLY) 
		{
			$total_amt_cbk1_mature += $temp_trans_arr['trans_amt'];
			$total_cbk1_fee_mature += getNumericValue($acc_table_data[$trans_type]['cbk1']);
			$total_cbk1_count_mature++;
		}
		//CBK1 mature -------------------------END

		//CBK1 _immature -------------------------START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && ($temp_trans_arr['trans_status']=="11") && fetchFormattedDate($temp_trans_arr['settelement_date'])>TODAY_DATE_ONLY) 
		{
			$total_amt_cbk1_immature += $temp_trans_arr['trans_amt'];
			$total_cbk1_immature_fee += getNumericValue($acc_table_data[$trans_type]['cbk1']);
			$total_cbk1_immature_count++;
		}
		//CBK1 _immature -------------------------END

	}	// END FOR LOOP

	//TRANSFERE ALL SUM, COUNT TO ARRAY ACCORDINGLY

	//Failed ------------------------
	$total_failed[0]['total_failed']	= $sum_total_failed;
	$total_failed[0]['count_id']		= $failed_count;

	//Chargeback mature --------------------------
	$chargeback[0]['total_amt_chargeback']	= $total_amt_chargeback;
	$chargeback[0]['count_id']	= $chargeback_count;

	//Chargeback _immature --------------------------
	$chargeback_immature[0]['total_amt_chargeback_immature']	= $total_amt_chargeback_immature;
	$chargeback_immature[0]['count_id']	= $chargeback_count_immature;

	//Return mature --------------------------
	$return[0]['total_amt_returned']	= $total_amt_returned;
	$return[0]['count_id']	= $returned_count_mature;

	if(isset($data['con_name'])&&$data['con_name']=='clk'){
		$return[0]['total_gst_fee']		= $total_gst_fee;
		$return[0]['total_gst_count']	= $total_gst_count;
	}

	//return_immature_immature -------------------------
	$return_immature[0]['total_amt_return_immature']	= $total_amt_return_immature;
	$return_immature[0]['count_id']	= $returned_count_immature;

	//rolling Volume mature --------------------------
	$withdraw_rolling[0]['summ_withdraw']	= $summ_withdraw;
	$withdraw_rolling[0]['count_withdraw']	= $count_withdraw;

	//Withdraw Amount mature --------------------------
	$withdraw[0]['total_withdraw']	= $total_withdraw;
	$withdraw[0]['count_id']		= $total_withdraw_count;

	//Send Fund mature --------------------------
	$send_fund[0]['total_send_fund']= $total_send_fund;
	$send_fund[0]['count_id']		= $send_fund_count;

	//Received Fund	mature --------------------------
	$received_fund[0]['summ_received_fund']		= $summ_received_fund;
	$received_fund[0]['count_received_fund']	= $count_received_fund;

	//Rolling mature --------------------------
	$mature_roll[0]['summ_mature']	= $summ_mature;
	$mature_roll[0]['count_mature']	= $count_mature;

	//Rolling _immature --------------------------
	$immature_roll[0]['summ_immature']	= $summ_immature;
	$immature_roll[0]['count_immature']	= $count_immature;

	//Sales Volume mature -------------------------
	$total_success[0]['total_success']	= $m_total_success;
	$total_success[0]['total_mdr']		= $m_total_mdr;
	$total_success[0]['total_rolling']	= $m_total_rolling;
	$total_success[0]['count_id']		= $m_count_id;

	//Sales Volume _immature --------------------------
	$total_success_immature[0]['total_success']	= $im_total_success;
	$total_success_immature[0]['total_mdr']		= $im_total_mdr;
	$total_success_immature[0]['total_rolling']	= $im_total_rolling;
	$total_success_immature[0]['count_id']		= $im_count_id;

	//After Reserve rolling_amt mature --------------------------
	$after_reserve_rolling[0]['total_after_reserve_rolling']	= $total_after_reserve_rolling;
	$after_reserve_rolling[0]['count_id']						= $after_res_roll_count_id;

	//After Reserve rolling_amt _immature --------------------------
	$after_reserve_rolling_immature[0]['total_after_reserve_rolling_immature']	= $total_after_reserve_rolling_immature;
	$after_reserve_rolling_immature[0]['count_id']	= $after_res_roll_count_id_im;

	//Transaction mature--------------------------
	$total_txn_fee[0]['total_txn_fee']	= $total_txn_fee_sum;
	$total_txn_fee[0]['count_id']		= $total_txn_fee_count_id;
	$total_txn_fee[0]['min_id']			= $min_id;
	$total_txn_fee[0]['max_id']			= $max_id;
	$total_txn_fee[0]['min_tdate']		= $min_tdate;
	$total_txn_fee[0]['max_tdate']		= $max_tdate;
	$total_txn_fee[0]['min_payout_date']= $min_payout_date;
	$total_txn_fee[0]['max_payout_date']= $max_payout_date;
	$total_txn_fee[0]['mature_rolling']	= $mature_rolling;

	//Transaction _immature--------------------------
	$total_txn_fee_immature[0]['total_txn_fee_immature']	= $total_txn_fee_sum_immature;
	$total_txn_fee_immature[0]['count_id']			= $total_txn_fee_count_id_immature;
	$total_txn_fee_immature[0]['min_id']			= $min_id_immature;
	$total_txn_fee_immature[0]['max_id']			= $max_id_immature;
	$total_txn_fee_immature[0]['min_tdate']			= $min_tdate_immature;
	$total_txn_fee_immature[0]['max_tdate']			= $max_tdate_immature;
	$total_txn_fee_immature[0]['min_payout_date']	= $min_payout_date_immature;
	$total_txn_fee_immature[0]['max_payout_date']	= $max_payout_date_immature;
	$total_txn_fee_immature[0]['mature_rolling']	= $mature_rolling_immature;

	//Transaction mature txn failed -------------------------
	$total_txn_fee_failed[0]['total_txn_fee_failed']	= $sum_failed_txn_mature;
	$total_txn_fee_failed[0]['count_id']				= $failed_count_mature;

	//Transaction _immature txn failed -------------------------
	$total_txn_fee_failed_immature[0]['total_txn_fee_failed_immature']	= $sum_failed_txn_immature;
	$total_txn_fee_failed_immature[0]['count_id']						= $failed_count_immature;

	//Chargeback mature -------------------------
	$chargeback1[0]['charge_back_fee_1']	= $sum_chargeback1_mature;
	$chargeback1[0]['count_id']				= $chargeback1_count_mature;

	$chargeback2[0]['charge_back_fee_2']	= $sum_chargeback2_mature;
	$chargeback2[0]['count_id']				= $chargeback2_count_mature;

	$chargeback3[0]['charge_back_fee_3']	= $sum_chargeback3_mature;
	$chargeback3[0]['count_id']				= $chargeback3_count_mature;

	//Chargeback immature -------------------------
	$chargeback_immature1[0]['charge_back_fee_1']	= $sum_chargeback1_immature;
	$chargeback_immature1[0]['count_id']			= $chargeback1_count_immature;

	$chargeback_immature2[0]['charge_back_fee_2']	= $sum_chargeback2_immature;
	$chargeback_immature2[0]['count_id']			= $chargeback2_count_immature;

	$chargeback_immature3[0]['charge_back_fee_3']	= $sum_chargeback3_immature;
	$chargeback_immature3[0]['count_id']			= $chargeback3_count_immature;

	//Return mature --------------------------
	$return1[0]['charge_back_fee_1']	= $return_charge_back_fee1_mature;
	$return1[0]['count_id']				= $return_count1_mature;

	$return2[0]['charge_back_fee_2']	= $return_charge_back_fee2_mature;
	$return2[0]['count_id']				= $return_count2_mature;

	$return3[0]['charge_back_fee_3']	= $return_charge_back_fee3_mature;
	$return3[0]['count_id']				= $return_count3_mature;

	//Return _imimmature --------------------------
	$return_immature1[0]['charge_back_fee_1']	= $return_charge_back_fee1_immature;
	$return_immature1[0]['count_id']			= $return_count1_immature;

	$return_immature2[0]['charge_back_fee_2']	= $return_charge_back_fee2_immature;
	$return_immature2[0]['count_id']			= $return_count2_immature;

	$return_immature3[0]['charge_back_fee_3']	= $return_charge_back_fee3_immature;
	$return_immature3[0]['count_id']			= $return_count3_immature;

	//Refund mature --------------------------
	$refund[0]['total_amt_refunded']	= $sum_refund_mature;
	$refund[0]['total_refunded_fee']	= $fee_refund_mature;
	$refund[0]['count_id']				= $count_refund_mature;

	//Refund immature --------------------------
	$refund_immature[0]['total_amt_refund_immature']	= $sum_refund_immature;
	$refund_immature[0]['total_refund_immature_fee']	= $fee_refund_immature;
	$refund_immature[0]['count_id']						= $count_refund_immature;

	//CBK1 mature -------------------------
	$cbk1[0]['total_amt_cbk1']	= $total_amt_cbk1_mature;
	$cbk1[0]['total_cbk1_fee']	= $total_cbk1_fee_mature;
	$cbk1[0]['count_id']		= $total_cbk1_count_mature;

	//CBK1 _immature --------------------------
	$cbk1_immature[0]['total_amt_cbk1_immature']	= $total_amt_cbk1_immature;
	$cbk1_immature[0]['total_cbk1_immature_fee']	= $total_cbk1_immature_fee;
	$cbk1_immature[0]['count_id']					= $total_cbk1_immature_count;

	###################### --- END CALCULATION VIA LOOP -- #########################

	if($pr){echo "<hr/>total_success=>";print_r($total_success);echo "<hr/>";}

	//Sales Volume	trans_amt
	$result['total_success']=number_formatf2($total_success[0]['total_success']);

	//Discount Rate	buy_mdr_amt
	$result['total_mdr']=number_formatf($total_success[0]['total_mdr']);

	//Holdback Reserve rolling_amt
	$result['total_rolling']=($total_success[0]['total_rolling']);

	//success count	count_id
	$result['success_count']=$total_success[0]['count_id'];

	//Sales Volume _immature --------------------------
	if($query_set){

		if($pr){echo "<hr/>total_success_immature=>";print_r($total_success_immature);echo "<hr/>";}

		//Sales Volume		trans_amt
		$result['total_success_immature']=number_formatf2($total_success_immature[0]['total_success']);

		//Discount Rate		buy_mdr_amt
		$result['total_mdr_immature']=number_formatf($total_success_immature[0]['total_mdr']);

		//Holdback Reserve	rolling_amt
		$result['total_rolling_immature']=number_formatf($total_success_immature[0]['total_rolling']);

		//success count	count_id
		$result['success_count_immature']=$total_success_immature[0]['count_id'];
	}

	if($pr){echo "<hr/>after_reserve_rolling=>";print_r($after_reserve_rolling);echo "<hr/>";}

	//After Reserve	rolling_amt
	$result['total_after_reserve_rolling']=number_formatf($after_reserve_rolling[0]['total_after_reserve_rolling']);

	if($query_set){
		//After Reserve	rolling_amt
		$result['total_after_reserve_rolling_immature']=number_formatf($after_reserve_rolling_immature[0]['total_after_reserve_rolling_immature']);
	}

	//Failed ------------------------
	if($pr){echo "<hr/>total_failed=>";print_r($total_failed);echo "<hr/>";}

	//Failed Volume		amount
	$result['total_failed']=number_formatf2($total_failed[0]['total_failed']);

	//Failed Volume count	count_id
	$result['failed_count']=$total_failed[0]['count_id'];

	//Transaction mature------------------------

	if($pr){echo "<hr/>total_txn_fee=>";print_r($total_txn_fee);echo "<hr/>";}

	//Transaction Fee	buy_txnfee_amt
	$result['total_txn_fee']=number_formatf($total_txn_fee[0]['total_txn_fee']);

	//Transaction Fee count		count_id
	$result['total_txn_fee_count']=$total_txn_fee[0]['count_id'];

	//Transaction Payout Date
	$result['mature_fund']=$total_txn_fee[0]['max_payout_date'];

	//Rolling Payout Date	rolling_date
	$result['mature_rolling']=number_formatf($total_txn_fee[0]['mature_rolling']);

	//Transaction Payout Date
	$result['min_id']=$total_txn_fee[0]['min_id'];
	$result['max_id']=$total_txn_fee[0]['max_id'];
	$result['min_tdate']=$total_txn_fee[0]['min_tdate'];
	$result['max_tdate']=$total_txn_fee[0]['max_tdate'];
	$result['min_payout_date']=$total_txn_fee[0]['min_payout_date'];
	$result['max_payout_date']=$total_txn_fee[0]['max_payout_date'];

	//Transaction mature txn _failed -------------------------

	if($pr){echo "<hr/>total_txn_fee_failed=>";print_r($total_txn_fee_failed);echo "<hr/>";}

	//Transaction Fee	buy_txnfee_amt
	$result['total_txn_fee_failed']=number_formatf($total_txn_fee_failed[0]['total_txn_fee_failed']);

	//Transaction Fee count		count_id
	$result['total_txn_fee_count_failed']=$total_txn_fee_failed[0]['count_id'];

	if($query_set){

		//Transaction _immature--------------------------

		if($pr){echo "<hr/>total_txn_fee_immature=>";print_r($total_txn_fee_immature);echo "<hr/>";}

		//Transaction Fee	buy_txnfee_amt

		$result['total_txn_fee_immature']=number_formatf($total_txn_fee_immature[0]['total_txn_fee_immature']);

		//Transaction Fee count		count_id
		$result['total_txn_fee_immature_count']=$total_txn_fee_immature[0]['count_id'];

		//Transaction _failed _immature ------------------------

		if($pr){echo "<hr/>total_txn_fee_failed_immature=>";print_r($total_txn_fee_failed_immature);echo "<hr/>";}

		//Transaction Fee	buy_txnfee_amt
		$result['total_txn_fee_failed_immature']=number_formatf($total_txn_fee_failed_immature[0]['total_txn_fee_failed_immature']);

		//Transaction Fee count		count_id
		$result['total_txn_fee_failed_immature_count']=$total_txn_fee_failed_immature[0]['count_id'];
	}

	//Chargeback mature --------------------------

	if($pr){echo "<hr/>chargeback=>";print_r($chargeback);echo "<hr/>";}

	//Chargeback	trans_amt
	$result['total_amt_chargeback']=number_formatf2($chargeback[0]['total_amt_chargeback']);

	//Chargeback count	count_id
	$result['chargeback_count']=$chargeback[0]['count_id'];

	if($pr){echo "<hr/>chargeback1=>";print_r($chargeback1);echo "<hr/>";}
	if($pr){echo "<hr/>chargeback2=>";print_r($chargeback2);echo "<hr/>";}
	if($pr){echo "<hr/>chargeback3=>";print_r($chargeback3);echo "<hr/>";}

	//Chargeback Fee	mdr_cb_amt 3 tire
	$result['total_chargeback_fee']=number_formatf($chargeback1[0]['charge_back_fee_1']+$chargeback2[0]['charge_back_fee_2']+$chargeback3[0]['charge_back_fee_3']);

	if($pr){echo "<hr/>total_chargeback_fee=>".$result['total_chargeback_fee'];echo "<hr/>";}

	//Chargeback _immature --------------------------
	if($pr){echo "<hr/>chargeback_immature=>";print_r($chargeback_immature);echo "<hr/>";}

	//Chargeback	trans_amt
	$result['total_amt_chargeback_immature']=number_formatf2($chargeback_immature[0]['total_amt_chargeback_immature']);

	//Chargeback count	count_id
	$result['chargeback_immature_count']=$chargeback_immature[0]['count_id'];

	if($pr){echo "<hr/>chargeback_immature1=>";print_r($chargeback_immature1);echo "<hr/>";}
	if($pr){echo "<hr/>chargeback_immature2=>";print_r($chargeback_immature2);echo "<hr/>";}
	if($pr){echo "<hr/>chargeback_immature3=>";print_r($chargeback_immature3);echo "<hr/>";}

	//Chargeback Fee	mdr_cb_amt 3 tire
	$result['total_chargeback_immature_fee']=number_formatf($chargeback_immature1[0]['charge_back_fee_1']+$chargeback_immature2[0]['charge_back_fee_2']+$chargeback_immature3[0]['charge_back_fee_3']);

	if($pr){echo "<hr/>total_chargeback_immature_fee=>".$result['total_chargeback_immature_fee'];echo "<hr/>";}

	//Return immature --------------------------

	//Return	trans_amt
	$result['total_amt_returned']=number_formatf2($return[0]['total_amt_returned']);

	//Return count	count_id
	$result['return_count']=$return[0]['count_id'];

	if($pr){echo "<hr/>return1=>";print_r($return1);echo "<hr/>";}
	if($pr){echo "<hr/>return2=>";print_r($return2);echo "<hr/>";}
	if($pr){echo "<hr/>return3=>";print_r($return3);echo "<hr/>";}

	//Return Fee	mdr_refundfee_amt
	$result['total_returned_fee']=number_formatf($return1[0]['charge_back_fee_1']+$return2[0]['charge_back_fee_2']+$return3[0]['charge_back_fee_3']);

	if($pr){echo "<hr/>total_returned_fee=>".$result['total_returned_fee'];echo "<hr/>";}

	//return_immature_immature -------------------------

	if($pr){echo "<hr/>return_immature=>";print_r($return_immature);echo "<hr/>";}

	//return_immature	trans_amt
	$result['total_amt_return_immature']=number_formatf2($return_immature[0]['total_amt_return_immature']);

if(isset($data['con_name'])&&$data['con_name']=='clk'){
	$result['total_gst_fee']=$return[0]['total_gst_fee'];
}
	//return_immature count	count_id
	$result['return_immature_count']=$return_immature[0]['count_id'];

	if($pr){echo "<hr/>return_immature1=>";print_r($return_immature1);echo "<hr/>";}
	if($pr){echo "<hr/>return_immature2=>";print_r($return_immature2);echo "<hr/>";}
	if($pr){echo "<hr/>return_immature3=>";print_r($return_immature3);echo "<hr/>";}

	//return_immature Fee	mdr_refundfee_amt
	$result['total_return_immature_fee']=number_formatf($return_immature1[0]['charge_back_fee_1']+$return_immature2[0]['charge_back_fee_2']+$return_immature3[0]['charge_back_fee_3']);

	if($pr){echo "<hr/>total_return_immature_fee=>".$result['total_return_immature_fee'];echo "<hr/>";}

	//Refund mature --------------------------

	if($pr){echo "<hr/>refund=>";print_r($refund);echo "<hr/>";}

	//Refund	trans_amt
	$result['total_amt_refunded']=number_formatf2($refund[0]['total_amt_refunded']);

	//Refund Fee	mdr_refundfee_amt
	$result['total_refunded_fee']=number_formatf($refund[0]['total_refunded_fee']);

	//Refund count
	$result['refunded_count']=$refund[0]['count_id'];

	//Refund _immature --------------------------

	if($pr){echo "<hr/>refund_immature=>";print_r($refund_immature);echo "<hr/>";}

	//Refund	trans_amt
	$result['total_amt_refund_immature']=number_formatf2($refund_immature[0]['total_amt_refund_immature']);

	//Refund Fee	mdr_refundfee_amt
	$result['total_refund_immature_fee']=number_formatf($refund_immature[0]['total_refund_immature_fee']);

	//Refund count
	$result['refund_immature_count']=$refund_immature[0]['count_id'];

	//CBK1 mature -------------------------

	if($pr){echo "<hr/>cbk1=>";print_r($cbk1);echo "<hr/>";}

	//CBK1		trans_amt
	$result['total_amt_cbk1']=number_formatf2($cbk1[0]['total_amt_cbk1']);

	//CBK1 Fee	mdr_cbk1_amt cbk1
	$result['total_cbk1_fee']=number_formatf($cbk1[0]['total_cbk1_fee']);

	//CBK1 count
	$result['cbk1_count']=$cbk1[0]['count_id'];

	//CBK1 _immature --------------------------

	if($pr){echo "<hr/>cbk1_immature=>";print_r($cbk1_immature);echo "<hr/>";}

	//CBK1		trans_amt
	$result['total_amt_cbk1_immature']=number_formatf2($cbk1_immature[0]['total_amt_cbk1_immature']);

	//CBK1 Fee	mdr_cbk1_amt cbk1_immature
	$result['total_cbk1_immature_fee']=number_formatf($cbk1_immature[0]['total_cbk1_immature_fee']);

	//CBK1 count
	$result['cbk1_immature_count']=$cbk1_immature[0]['count_id'];

	//rolling Volume mature --------------------------

	$result['summ_withdraw_roll']	= number_formatf2((double)$withdraw_rolling[0]['summ_withdraw']);
	$result['count_withdraw_roll']	= $withdraw_rolling[0]['count_withdraw'];

	//amount | Withdraw Amount | s:1,13 | t:wd
	//Withdraw Amount mature --------------------------

	if($pr){echo "<hr/>withdraw=>";print_r($withdraw);echo "<hr/>";}

	//Withdraw Amount	amount
	$result['summ_withdraw_amt_1']=str_replace("-","",$withdraw[0]['total_withdraw']);
	$result['total_withdraw']=$withdraw[0]['total_withdraw'];
	//Withdraw count	count_id
	$result['withdraw_count']=$withdraw[0]['count_id'];

	//Send Fund mature --------------------------

	if($pr){echo "<hr/>send_fund=>";print_r($send_fund);echo "<hr/>";}

	//Send Fund	amount
	$result['total_send_fund']=$send_fund[0]['total_send_fund'];
	//Send Fund	count_id
	$result['send_fund_count']=$send_fund[0]['count_id'];
	$result['summ_send_fund_amt']=str_replace("-","",$send_fund[0]['total_send_fund']);

	//Received Fund total_received_fund mature --------------------------

	if($pr){echo "<hr/>received_fund=>";print_r($received_fund);echo "<hr/>";}

	// received_fund
	$result['total_received_fund']=str_replace("-","",$received_fund[0]['summ_received_fund']);
	$result['summ_received_fund']=$received_fund[0]['summ_received_fund'];
	$result['received_fund_count']=$received_fund[0]['count_received_fund'];
	$result['summ_received_fund_amt']=(double)$result['total_received_fund'];

	//primary account:virtual_fee | Monthly Maintenance Fee | first day in month get query
	//Monthly Maintenance Fee
	$result['monthly_maintenance_fee']="";

	$result['summ_withdraw_amt_1']=str_replace("-","",(double)$result['total_withdraw']);
	$result['summ_withdraw_amt']=$result['total_withdraw']+$result['total_send_fund'];
	$result['summ_withdraw']=prnpays_crncy($result['total_withdraw'],'','',$account_curr);
	$result['count_withdraw']=$result['withdraw_count']+$result['send_fund_count'];

	//fee for mature amount
	$total_all_fee=((
		$result['total_mdr']
		+$result['total_rolling']
		+$result['total_txn_fee']
		+$result['total_txn_fee_failed']
	)
	-
	(
		$result['total_after_reserve_rolling']
		+$result['total_amt_chargeback']
		-$result['total_chargeback_fee']
		+$result['total_amt_returned']
		-$result['total_returned_fee']
		+$result['total_amt_refunded']
		-$result['total_refunded_fee']
		+$result['total_amt_cbk1']
		-$result['total_cbk1_fee']
	));

	$result['summ_mature_1']=number_formatf2((double)$result['total_success']-$total_all_fee);

	if($result['monthly_maintenance_fee']){
		$total_all_fee=$total_all_fee+$result['monthly_maintenance_fee'];
	}

	//calc mature amt

	$total_payable_to_merchant=(double)$result['total_success']-(double)$total_all_fee;

	$total_payable_to_merchant=$total_payable_to_merchant+(double)$result['total_withdraw'];
	$total_payable_to_merchant=$total_payable_to_merchant+(double)$result['total_send_fund'];
	$total_payable_to_merchant=$total_payable_to_merchant-$result['summ_received_fund'];
	if($result['manual_adjust_balance']){
		$total_payable_to_merchant=$total_payable_to_merchant+$result['manual_adjust_balance'];
	}

	if($pr){echo "<hr/>manual_adjust_balance=>".$result['manual_adjust_balance'];echo "<hr/>";}

	$result['summ_mature_amt']=$total_payable_to_merchant;

	$result['summ_mature']=prnpays_crncy($result['summ_mature_amt'],'','',$account_curr);

	$result['count_mature']=$result['success_count']-$result['success_count_immature'];

	if($pr){
	//total_amt_refunded
		$brs="<br/>";
		echo $brs."<hr/>total_all_fee=>";
		echo $brs."((";
		echo $brs."+total_mdr=>".$result['total_mdr'];
		echo $brs."+total_rolling=>+".$result['total_rolling'];
		echo $brs."+total_txn_fee=>+".$result['total_txn_fee'];
		echo $brs."+total_txn_fee_failed=>+".$result['total_txn_fee_failed'];
		echo $brs.")
	-
	(";
		echo $brs."+total_after_reserve_rolling=>".$result['total_after_reserve_rolling'];
		echo $brs."+total_amt_chargeback=>+".$result['total_amt_chargeback'];
		echo $brs."-total_chargeback_fee=>-".$result['total_chargeback_fee'];
		echo $brs."+total_amt_returned=>+".$result['total_amt_returned'];
		echo $brs."-total_returned_fee=>-".$result['total_returned_fee'];
		echo $brs."+total_amt_refunded=>+".$result['total_amt_refunded'];
		echo $brs."-total_refunded_fee=>-".$result['total_refunded_fee'];
		echo $brs."+total_amt_cbk1=>+".$result['total_amt_cbk1'];
		echo $brs."-total_cbk1_fee=>-".$result['total_cbk1_fee'];

		echo $brs."))<hr/>";
		echo $brs."sum total_all_fee=".$total_all_fee;

		echo $brs."+total_success=>".(double)$result['total_success'];
		echo $brs."-total_all_fee=>-".$total_all_fee;
		echo $brs."+total_withdraw=>-".$result['total_withdraw'];
		echo $brs."+total_send_fund=>+".$result['total_send_fund'];
		echo $brs."-summ_received_fund=>-".$result['summ_received_fund'];
		echo $brs."+manual_adjust_balance=>+".$result['manual_adjust_balance'];
		echo $brs."sum summ_mature_amt=".$total_payable_to_merchant;

		echo $brs."immature fee";
		echo $brs."+total_mdr_immature=>+".$result['total_mdr_immature'];
		echo $brs."+total_rolling_immature=>+".$result['total_rolling_immature'];
		echo $brs."+total_after_reserve_rolling_immature=>+".$result['total_after_reserve_rolling_immature'];
		echo $brs."+total_txn_fee_immature=>+".$result['total_txn_fee_immature'];
		echo $brs."+total_txn_fee_failed_immature=>+".$result['total_txn_fee_failed_immature'];
	}

	if($query_set){
		//fee for immature amount
		$total_all_fee_immature=((
			$result['total_mdr_immature']
			+$result['total_rolling_immature']
			+$result['total_txn_fee_immature']
			+$result['total_txn_fee_failed_immature']
		)
		-
		(
			$result['total_after_reserve_rolling_immature']
			+$result['total_amt_chargeback_immature']
			-$result['total_chargeback_immature_fee']
			+$result['total_amt_return_immature']
			-$result['total_return_immature_fee']
			+$result['total_amt_refund_immature']
			-$result['total_refund_immature_fee']
			+$result['total_amt_cbk1_immature']
			-$result['total_cbk1_immature_fee']
		));

		//calc immature
		$total_payable_to_merchant_immature=(double)$result['total_success_immature']-(double)$total_all_fee_immature;

		$result['summ_immature_amt']=$total_payable_to_merchant_immature;

		$result['summ_immature']=prnpays_crncy($result['summ_immature_amt'],'','',$account_curr);
		$result['count_immature']=$result['success_count_immature'];
	}

	//calc total balance
	$summ_total=$result['summ_immature_amt']+$result['summ_mature_amt'];
	$result['summ_total_amt']=$summ_total;
	$result['summ_total']=prnpays_crncy($summ_total,'','',$account_curr);
	$result['count_total']=$result['count_immature']+$result['count_mature'];

	//rolling

	//Rolling mature --------------------------

	$result['summ_mature_roll']	= number_formatf2((double)$mature_roll[0]['summ_mature']+$result['summ_withdraw_roll']);
	$result['count_mature_roll']= $mature_roll[0]['count_mature']-$result['count_withdraw_roll'];

	//Rolling _immature --------------------------

	$result['summ_immature_roll']=number_formatf((double)$immature_roll[0]['summ_immature']);
	$result['count_immature_roll']=$immature_roll[0]['count_immature'];

	// total rolling calc
	$result['summ_total_roll']=number_formatf($result['summ_immature_roll']+$result['summ_mature_roll']);
	$result['count_total_roll']=$result['count_immature_roll']+$result['count_mature_roll'];
	$result['account_curr']=$account_curr;
	$result['account_curr_sys']=get_currency($account_curr);

	if(isset($_GET['qp']))
	{
		echo "<hr>Result==><hr>";
		print_r($result);
	}
	return $result;
}


//to calculate payout settlement balance and period
function payout_trans_newf($uid=0,$type=2)
{
	global $data;//, $trans_detail_array;

	$trans_detail_array = fetch_trans_balance($uid, 1);	//fetch transaction detail from fetch_trans_balance function
	
	$result=array();

	$qprint=0;
	if(isset($_GET['qp']))
	{
		$qprint=1;
		echo "<hr/><==payout_trans_newf==><hr/>";
		print_r($trans_detail_array);
		echo "<br/><hr/><br/>";
	}

	$max_settelement_period=ms_max_settelement_period($uid);	//fetch settlement period from account table
	$result['min_settelement_period']=$max_settelement_period['min_settelement_period'];	//minimum days for selltement
	$result['max_settelement_period']=$max_settelement_period['max_settelement_period'];	//maximum days for selltement
	$result['min_ptdate']=$max_settelement_period['min_ptdate'];	//minimum payout date
	$result['max_ptdate']=$max_settelement_period['max_ptdate'];	//maximum payout date
	//$result['max_ptdate']=$data['CURRENT_TIME'];

	//define variable with zero (0) for further use
	$t_withdraw_max=$t_max_id=$t_min_id=0;

	for($i=0;$i<count($trans_detail_array);$i++)	//loop for fetch row-by-day transaction data
	{
		$temp_trans_arr = $trans_detail_array[$i];	//store one row in temp array

		//if status not equal 2 & uid and type matched then execute following section
		if($temp_trans_arr['merID']=="$uid" && $temp_trans_arr['acquirer']==$type && $temp_trans_arr['trans_status']!='2')
		{
			//transfer current id to max withdraw id if max withdraw id is less than current id
			if($t_withdraw_max<$temp_trans_arr['id'])
				$t_withdraw_max=$temp_trans_arr['id'];
		}
	}

	for($i=0;$i<count($trans_detail_array);$i++)
	{
		$temp_trans_arr = $trans_detail_array[$i];	//store one row in temp array

		//if payout date and time is earlier than TODAY, the execute following section
		if(($temp_trans_arr['merID']=="$uid") && $temp_trans_arr['settelement_date']<=$data['CURRENT_TIME'])
		{
			//transfer current id to max id if max id is less than current id then re-initialized t_max_id
			if($t_max_id<$temp_trans_arr['id'])
				$t_max_id=$temp_trans_arr['id'];
		}
	}

	$next_month=1;	//initilized next_month is 1
	if(empty($t_withdraw_max)){	//withdraw max id is empty nthen execute following section

		for($i=0;$i<count($trans_detail_array);$i++)
		{
			$temp_trans_arr = $trans_detail_array[$i];	//store one row in temp array

			//if uid match with merID or send then check t_min_id is greater than currnet id or t_min_id is empty (means first row) then re-initialized t_min_id
			if(($temp_trans_arr['merID']=="$uid"))
			{
				if($t_min_id>$temp_trans_arr['id'] || $t_min_id==0)
					$t_min_id=$temp_trans_arr['id'];
			}
		}
		$t_withdraw_max=$t_min_id;	//set t_min_id as a withdraw max
		$next_month=0;
	}

	$result['transaction_period']=$t_withdraw_max." AND ".$t_max_id;	//set period 
	
	if(@$t_max_id>0)
	$transaction_period_id=" AND ( `id` BETWEEN ".$result['transaction_period']." )";
	else $transaction_period_id="";
	
	
	if($qprint==1){
		echo "<hr/>transaction_period=> ".$result['transaction_period'];
		echo "<hr/>next_month=> ".$next_month;
	}

	//13 Withdraw Requested
	$max_withdraw_id = $max_withdraw_trans_id=0;	//initialized variables with ZERO (0)

	for($i=0;$i<count($trans_detail_array);$i++)
	{
		$temp_trans_arr = $trans_detail_array[$i];	//store one row in temp array

		
		if($temp_trans_arr['merID']=="$uid" && $temp_trans_arr['acquirer']==$type && ($temp_trans_arr['trans_status']!='2'))	//status otherthan 2
		{
			if($max_withdraw_id<$temp_trans_arr['id'])	//max_withdraw_id is less than current id then max_withdraw_id re-initialized
				$max_withdraw_id=$temp_trans_arr['id'];

			if($max_withdraw_trans_id<$temp_trans_arr['transID'])	//max_withdraw_trans_id is less than current transID then max_withdraw_trans_id re-initialized
				$max_withdraw_trans_id=$temp_trans_arr['transID'];
		}
	}

	//store values into result array for return
	$result['withdraw_requested']=$max_withdraw_id;
	$result['previous_transID']=$max_withdraw_trans_id;

	//get Acquire
	$virtual_fee=ms_virtual_fee($uid);
	$result['virtual_fee']=$virtual_fee['virtual_fee'];			//virtual fee
	$result['virtual_count']=$virtual_fee['virtual_count'];		//virtual counter

	//clients info
	$result['monthly_vt_fee']=0;
	$clients			=select_client_table($uid);	//fetch client information
	$account_curr	=$clients['default_currency'];	//client's default currency
	$monthly_vt_fee	=$clients['monthly_fee'];		//client's monthly fee

	$result['per_monthly_fee']=$monthly_vt_fee;		//client's monthly fee store into result
	$result['manual_adjust_balance']=$clients['manual_adjust_balance'];	//manual adjustable balance

	//get transaction ids
	$tran_id=db_rows(
		"SELECT ".group_concat_return('`terNO`',1)." AS `terNO`, ".group_concat_return('`trans_type`',1)." AS `trans_type`, COUNT(`id`) AS `count`, MIN(`id`) AS `min_id`, MAX(`id`) AS `max_id`, MIN(`tdate`) AS `min_tdate`, MAX(`tdate`) AS `max_tdate`, MIN(`fee_update_timestamp`) AS `min_feetime`, MAX(`fee_update_timestamp`) AS `max_feetime`".
			" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" WHERE ( `merID`='{$uid}' ) AND ( (".date_format_return('`settelement_date`',1).") <= (".date_format_return('now()',1).") ) AND (`trans_status` NOT IN (9,10)) ".$transaction_period_id.
			" LIMIT 1",$qprint
			
			// AND ( `json_value` NOT LIKE '%frozen_acquirer%' )
	);

	// for Withdraw
	//$result['wd']['wd_tran_id']	=$tran_id[0]['tid'];
	$result['wd']['wd_terNO']	=$tran_id[0]['terNO'];	//store or website idd
	$result['wd']['wd_trans_type']		=$tran_id[0]['trans_type'];		//trans_type
	$result['wd']['wd_count']		=$tran_id[0]['count'];		//total records
	$result['wd']['wd_min_id']		=$tran_id[0]['min_id'];		//minimum tid
	$result['wd']['wd_max_id']		=$tran_id[0]['max_id'];		//maximum tid
	$result['wd']['wd_min_tdate']	=$tran_id[0]['min_tdate'];	//minimum transaction date
	$result['wd']['wd_max_tdate']	=$tran_id[0]['max_tdate'];	//maximum transaction date
	$result['wd']['wd_max_created']	=$data['CURRENT_TIME'];		//date('Y-m-d H:i:s');

	if(isset($data['statement_withdraw'])){
		$result['wd']['wd_max_ptdate']=$result['max_ptdate'];	//maximum payout date
		$result['wd']['wd_max_settelement_period']=$result['max_settelement_period'];	//maximum settlement period
	}
	$result['wd']['wd_min_feetime']=$tran_id[0]['min_feetime'];	//minimum fee_update_timestamp
	$result['wd']['wd_max_feetime']=$tran_id[0]['max_feetime'];	//maximum fee_update_timestamp

	if($qprint==1){
		echo "<hr/>tran_id=> ";
		print_r($tran_id);
		echo "<br/><hr/>";
	}

	//get month for monthly fee
	$w_start_date = "";	//initilized w_start_date with null
	for($i=0;$i<count($trans_detail_array);$i++)
	{
		$temp_trans_arr = $trans_detail_array[$i];	//store one row in temp array
		
		if($qprint==1){
			echo "<br/><br/>000 id=>".$temp_trans_arr['id'];
			echo "<br/>000 transID=>".$temp_trans_arr['transID'];
			echo "<br/>000 merID=>".$temp_trans_arr['merID'];
			echo "<br/>000 max_withdraw_trans_id=>".$max_withdraw_trans_id;
			echo "<br/>000 t_withdraw_max=>".$t_withdraw_max;
			echo "<br/>000 trans_status=>".$temp_trans_arr['trans_status'];
			echo "<br/>000 acquirer=>".$temp_trans_arr['acquirer'];
		}
		
		if($temp_trans_arr['id']=="$t_withdraw_max"&&$max_withdraw_trans_id>0)	//if not find previous withdraw than get first successful transaction then set start date with current created date and break loop
		{
			$w_start_date = $temp_trans_arr['created_date'];
			if($qprint==1) echo "<br/>11w_start_date=>".$w_start_date;
			break;
		}
		elseif($temp_trans_arr['trans_status']=="1")	//if withdraw max id is match with current id then set start date with current created date and break loop
		{
			$w_start_date = $temp_trans_arr['created_date'];
			if($qprint==1) echo "<br/>22w_start_date=>".$w_start_date;
			break;
		}
	}
	//$w_start_date = date("Y-m-d",strtotime("+$next_month month",strtotime($w_start_date)));

	$w_end_date = $w_end_payout_date = "";//initilized withdraw end date and W-payout end date with null
	for($i=0;$i<count($trans_detail_array);$i++)
	{
		$temp_trans_arr = $trans_detail_array[$i];	//store one row in temp array

		//if t_max_id is match with current id then re-initilized withdraw end date and W-payout end date and break loop
		if($temp_trans_arr['id']=="$t_max_id")
		{
			$w_end_date			= $temp_trans_arr['tdate'];
			$w_end_payout_date	= $temp_trans_arr['settelement_date'];
			break;
		}
	}

	$w_end_date=$result['min_ptdate'];	//minimu payout date
	$w_end_payout_date=$w_end_date;		//withdraw end payout date

	if($qprint==1){
		echo "<hr/>w_start_date=> ".date('d-m-Y',strtotime($w_start_date));
		echo "<hr/>w_end_date=> ".date('d-m-Y',strtotime($w_end_date));
	}

	$a = date('Y-m-d',strtotime($w_start_date));	//initilized date from
	$b = date('Y-m-d',strtotime($w_end_date));		//initilized date to	

	$result['date_from']=$a;		// date from
	$result['date_to']=$b;			// date to
	$result['date_to_payout']=$w_end_payout_date;	//payout end date

	//initilized first date of the month if max withdraw id is empty otherwise first date of next month
	if(empty($max_withdraw_id)){
		$a = date('Y-m-d',strtotime("first day of this month",strtotime($w_start_date)));
	}else{
		$a = date('Y-m-d',strtotime("first day of next month",strtotime($w_start_date)));
	}

	//$b = date('Y-m-d',strtotime($w_end_date));
	$b = date('Y-m-d');	//initilized current date as to (till) date
	$result['wd']['wd_monthly_date_from']=$a;
	$result['wd']['wd_monthly_date_to']=$b;
	
	
	$i = date("Ym", strtotime($a));
	$j=0;
	while($i <= date("Ym", strtotime($b))){
		$i."<br/>";
		if(substr($i, 4, 2) == "12"){
			$i = (date("Y", strtotime($i."01")) + 1)."01";
		}else{
			$i++;
		}
		$j++;
	}

	$result['total_month_no']=$j;
	$result['total_monthly_fee']=$result['per_monthly_fee']*$result['total_month_no'];
	if($qprint==1){
		echo "<hr/>result==> ";
		print_r($result);
	}
	return $result;
}



//fetch all transaction details of a clients or all transactions.
function fetch_trans_balance($memId="", $json_frozen=0)
{
	global $data;

	$qprint=0;
	if(isset($_GET['qp'])){
		$qprint=1;
		echo "<hr/><==fetch_trans_balance==><hr/>";
	}

	if(!empty($memId) && $memId>0){
		$where_clouse = "(`merID` IN ({$memId}) )";	//fetch merID = memId
	}
	else
		$where_clouse = 1;
	//$where_clouse .= " AND status NOT IN (0,9,10) ";

	//if json_frozen is true then set condition for frozen_acquirer must be json value
	//if($json_frozen==1) $where_clouse .= " AND (`json_value` NOT LIKE '%frozen_acquirer%') ";
	
	//if($json_frozen==1) $where_clouse .= " AND ( CONVERT(`json_value` USING utf8) NOT LIKE '%frozen_acquirer%') ";

	//if clk project then fetch gst fee 
	if(isset($data['con_name'])&&$data['con_name']=='clk'){
		$gst_fee_sl=", `gst_amt` ";
	}else{
		$gst_fee_sl="";
	}
	
	if($data['connection_type']=='PSQL') 
		$use_index="";
	else
		$use_index="USE INDEX (merID)";
	
	//,`support_note`
	$tr_det_q=db_rows("SELECT `id`,
		`acquirer`,
		`trans_status`,
		`merID`,
		`settelement_date`,
		`transID`,
		`terNO`,
		`trans_type`,
		`tdate`,
		`fee_update_timestamp`,
		`created_date`,
		`payable_amt_of_txn`,
		`bill_amt`,
		`mdr_refundfee_amt`,
		`rolling_amt`,
		`buy_mdr_amt`,
		`rolling_date`,
		`transaction_period`,
		`settelement_delay`,
		`available_rolling`,
		`available_balance`,
		`trans_amt`,
		`buy_txnfee_amt`,
		`mdr_cb_amt`,
		`mdr_cbk1_amt`,
		`risk_ratio`,
		`related_transID`
		".$gst_fee_sl.
		" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
		" {$use_index}  WHERE ".$where_clouse." ",$qprint
//		" WHERE ".$where_clouse." ORDER BY id",$qprint
	);
	
	array_multisort(array_column($tr_det_q, 'id'), SORT_ASC, $tr_det_q);
	
	$all_trans_list = array();
	$i =0;
	foreach ($tr_det_q as $key => $val) {

		//fetch only numeric values of the following fields
		$val['payable_amt_of_txn']	= getNumericValue($val['payable_amt_of_txn']);
		$val['bill_amt']			= getNumericValue($val['bill_amt']);
		$val['mdr_refundfee_amt']	= getNumericValue($val['mdr_refundfee_amt']);
		$val['rolling_amt']			= getNumericValue($val['rolling_amt']);
		$val['available_balance']	= getNumericValue($val['available_balance']);
		$val['available_rolling']	= getNumericValue($val['available_rolling']);
		$val['trans_amt']		= getNumericValue($val['trans_amt']);
		$val['terNO']			= getNumericValue($val['terNO']);
		$val['buy_mdr_amt']				= getNumericValue($val['buy_mdr_amt']);
		$val['buy_txnfee_amt']		= getNumericValue($val['buy_txnfee_amt']);
		$val['mdr_cb_amt']			= getNumericValue($val['mdr_cb_amt']);
		$val['mdr_cbk1_amt']		= getNumericValue($val['mdr_cbk1_amt']);
		$val['risk_ratio']			= getNumericValue($val['risk_ratio']);

		if(isset($data['con_name'])&&$data['con_name']=='clk'){
			$val['gst_amt']			= getNumericValue($val['gst_amt']);	//for clk
		}

		//if the value related_transID is NULL then set empty
		if(isset($val['related_transID'])&&$val['related_transID']==NULL)	$val['related_transID']	= "";
		
		//if the value support_note is NULL then set empty
		//if(isset($val['support_note'])&&$val['support_note']==NULL)	$val['support_note']= "";

		$all_trans_list[$i++] = $val;
	}

	return $all_trans_list;
}




################### NEW FUCTION FOR CHECK A/C BALLANE -- START --
//to calculate all type of balance and total records.
function trans_balance_newac($uid=0,$tr_id=0,$currentDate='', $trans_detail_array=[])
{
	global $data, $monthly_fee; 

	$now="now()";

	$result=array();
	$where_merID="";
	$current_date=$data['CURRENT_TIME'];	//date('Y-m-d H:i:s');

	$qprint=0;
	$account_curr="";
	$tdate_pd="";

	if(isset($_GET['qp'])){
		$qprint=1;
		echo "<hr/><==trans_balance_newac==><hr/>";
	}
	if($currentDate){
		$now="'".$currentDate."'";
	}
	// start: daily or date range ----------------------
	$date_1st = $date_2nd = "";
	if(is_array($currentDate)){	//if currentDate is exists then store into date_1st and and date_2nd

		$date_1st=$currentDate['date_1st'];

		$date_2nd=date("Y-m-d",strtotime("+1 day",strtotime($currentDate['date_2nd'])));
		$now="'".$date_1st."'";

		$tdate_pd="";
	}
	// end: daily or date range ----------------------

	// ----------------------

	if($uid>0){
		$where_merID=" AND ( `merID`='{$uid}' ) ";	//set merID condition
		$clients=select_client_table($uid);	//fetch clients detail
		$account_curr=$clients['default_currency'];	//fetch default currency of clients

		$result['monthly_vt_fee']			= isset($monthly_fee['total_monthly_fee'])?$monthly_fee['total_monthly_fee']:0;	//total_monthly_fee
		$result['monthly_vt_fee_max']		= isset($monthly_fee['per_monthly_fee'])?$monthly_fee['per_monthly_fee']:0;	//per_monthly_fee
		$result['count_monthly_vt_fee']		= isset($monthly_fee['total_month_no'])?$monthly_fee['total_month_no']:0;	//total_month_no
		$result['manual_adjust_balance']	= isset($monthly_fee['manual_adjust_balance'])?$monthly_fee['manual_adjust_balance']:0;	//manual_adjust_balance
	};

	if($tr_id>0){
		$where_merID .=" AND ( `id`='{$tr_id}' ) ";
	}

	// Amt. Balance query

	//set initially null for comparision
	$summ_mature = $count_mature = $min_id = $max_id = $summ_immature = $count_immature = 0;
	$min_tdate = $max_tdate = $min_feetime = $max_feetime = "";

	//set all counting and total initially 0
	$summ_withdraw				= 0;
	$count_withdraw				= 0;
	$summ_sended_fund			= 0;
	$count_sended_fund			= 0;
	$summ_received_fund			= 0;
	$count_received_fund		= 0;
	$refunded_amount			= 0;
	$mdr_refundfee_amt			= 0;
	$refunded_count				= 0;
	$summ_withdraw_roll			= 0;
	$count_withdraw_roll		= 0;

	$sum_payable_amt_mature		= 0;
	$sum_payable_count_mature	= 0;

	$summ_immature_roll			= 0;
	$count_immature_roll		= 0;
	$summ_mature_roll			= 0;
	$count_mature_roll			= 0;
	$summ_refunded_roll			= 0;
	$count_refunded_roll		= 0;

	for($i=0;$i<count($trans_detail_array);$i++)	//loop for fetch all transaction detail row by row
	{
		$temp_trans_arr = $trans_detail_array[$i];	//copy row into temp transaction array

		$mature_con=false;

		//MATURE FUND - START
		if(!empty($date_1st) && !empty($date_2nd))	// if first and second date exist check following conditions, if true then $mature_con=true;
		{
			if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && !(($temp_trans_arr['trans_status']=="0" || $temp_trans_arr['trans_status']=="9" || $temp_trans_arr['trans_status']=="10")) && fetchFormattedDate($temp_trans_arr['settelement_date'])>=$date_1st && fetchFormattedDate($temp_trans_arr['settelement_date'])<=$date_2nd) {
				$mature_con=true;
			}
		}
		else
		{
			//if date not set (exists) the check following, if true then $mature_con=true;
			if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && !(($temp_trans_arr['trans_status']=="0" || $temp_trans_arr['trans_status']=="9" || $temp_trans_arr['trans_status']=="10")) && fetchFormattedDate($temp_trans_arr['settelement_date'])<=TODAY_DATE_ONLY) {
				$mature_con=true;
			}
		}
		
		//if true $mature_con is true, then executive following section;
		if($mature_con)
		{
			if($tr_id>0){	//if transaction id greater than zero, means only one record to be fetch
				if($temp_trans_arr['id']==$tr_id)	//if request trans id found in array then fetch data and break the loop
				{
					$summ_mature	=$temp_trans_arr['payable_amt_of_txn'];
					$count_mature	=1;
					$min_id			=$temp_trans_arr['id'];
					$max_id			=$temp_trans_arr['id'];
					$min_tdate		=$temp_trans_arr['tdate'];
					$max_tdate		=$temp_trans_arr['tdate'];
					$min_feetime	=$temp_trans_arr['fee_update_timestamp'];
					$max_feetime	=$temp_trans_arr['fee_update_timestamp'];

					break;
				}
			}
			else {
				$summ_mature +=$temp_trans_arr['payable_amt_of_txn'];
				$count_mature++;

				if($min_id>$temp_trans_arr['id'] || $min_id==0)		// fetch minimum id
					$min_id=$temp_trans_arr['id'];

				if($max_id<$temp_trans_arr['id'])					// fetch maxium id
					$max_id=$temp_trans_arr['id'];

				if($min_tdate>$temp_trans_arr['tdate'] || empty($min_tdate))		// fetch minimum tdate
					$min_tdate=$temp_trans_arr['tdate'];

				if($max_tdate<$temp_trans_arr['tdate'])		// fetch maxium tdate
					$max_tdate=$temp_trans_arr['tdate'];

				if($min_feetime>$temp_trans_arr['fee_update_timestamp']) // fetch minimum fee_update_timestamp
					$min_feetime=$temp_trans_arr['fee_update_timestamp'];

				if($max_feetime<$temp_trans_arr['fee_update_timestamp']) // fetch maxium fee_update_timestamp
					$max_feetime=$temp_trans_arr['fee_update_timestamp'];
			}
		}
		//MATURE FUND - END

		//IMMATURE FUND - START
		if($temp_trans_arr['merID']=="$uid" && ($temp_trans_arr['trans_type']==11) && !(($temp_trans_arr['trans_status']=="0" || $temp_trans_arr['trans_status']=="9" || $temp_trans_arr['trans_status']=="10")) && fetchFormattedDate($temp_trans_arr['settelement_date'])>TODAY_DATE_ONLY)
		{
			if($tr_id>0){	//if transaction id greater than zero, means only one record to be fetch
				if($temp_trans_arr['id']==$tr_id)	//if request trans id found in array then fetch data and break the loop
				{
					$summ_immature	=$temp_trans_arr['payable_amt_of_txn'];	//payable transaction amount
					$count_immature	=1;	//set counter is 1
					break;
				}
			}
			else {
				$summ_immature +=$temp_trans_arr['payable_amt_of_txn'];	//payable transaction amount add into summ_immature
				$count_immature++;	//increase counter
			}
		}
		//IMMATURE FUND - END

		//SUM WITHDRAWAL -- START
		if($temp_trans_arr['merID']=="$uid" && $temp_trans_arr['trans_type']==15 && ($temp_trans_arr['trans_status']=="1" || $temp_trans_arr['trans_status']=="13"))
		{
			if($tr_id>0){	//if transaction id greater than zero, means only one record to be fetch
				if($temp_trans_arr['id']==$tr_id)	//if request trans id found in array then fetch data and break the loop
				{
					$summ_withdraw	=$temp_trans_arr['bill_amt'];	//amount add in withdraw
					$count_withdraw	=1;
					break;
				}
			}
			else {
				$summ_withdraw +=$temp_trans_arr['bill_amt'];	//add amount into total withdraw	
				$count_withdraw++;	//increase counter
			}
		}
		//SUM WITHDRAWAL -- END

		//SUM summ_sended_fund -- START
		if($temp_trans_arr['merID']=="$uid" && $temp_trans_arr['trans_type']==19 && ($temp_trans_arr['trans_status']=="1" || $temp_trans_arr['trans_status']=="15"))
		{
			if($tr_id>0){	//if transaction id greater than zero, means only one record to be fetch
				if($temp_trans_arr['id']==$tr_id)	//if request trans id found in array then fetch data and break the loop
				{
					$summ_sended_fund	=$temp_trans_arr['bill_amt'];	//transaction amount add in sended fund
					$count_sended_fund	=1;	//set total counting 1
					break;
				}
			}
			else {
				$summ_sended_fund +=$temp_trans_arr['bill_amt'];	//transaction amount add in sended fund
				$count_sended_fund++;	//increase counter
			}
		}
		//SUM summ_sended_fund -- END

		//SUM summ_received_fund -- START
		if($temp_trans_arr['merID']=="$uid" && $temp_trans_arr['trans_type']==19 && ($temp_trans_arr['trans_status']=="1" || $temp_trans_arr['trans_status']=="15"))
		{
			if($tr_id>0){	//if transaction id greater than zero, means only one record to be fetch
				if($temp_trans_arr['id']==$tr_id)	//if request trans id found in array then fetch data and break the loop
				{
					$summ_received_fund	=$temp_trans_arr['bill_amt'];	//total received amount	
					$count_received_fund=1;	//set total counting 1
					break;
				}
			}
			else {
				$summ_received_fund +=$temp_trans_arr['bill_amt'];	//add total received amount
				$count_received_fund++;	//increase counter
			}
		}
		//SUM summ_received_fund -- END

		//SUM refunded_amt -- START
		if($temp_trans_arr['merID']=="$uid" && ($temp_trans_arr['trans_type']==11) && ($temp_trans_arr['trans_status']=="3" || $temp_trans_arr['trans_status']=="5" || $temp_trans_arr['trans_status']=="6" || $temp_trans_arr['trans_status']=="11" || $temp_trans_arr['trans_status']=="12"))
		{
			if($tr_id>0){	//if transaction id greater than zero, means only one record to be fetch
				if($temp_trans_arr['id']==$tr_id)	//if request trans id found in array then fetch data and break the loop
				{
					$refunded_amount	= $temp_trans_arr['payable_amt_of_txn'];	// for refunded
					$mdr_refundfee_amt	= $temp_trans_arr['mdr_refundfee_amt'];		// for mdr refund
					$refunded_count		= 1;	//set total counting 1

					//for rolling
					$summ_refunded_roll	= $temp_trans_arr['rolling_amt'];		//for rolling
					$count_refunded_roll= 1;	//set total counting 1
					break;
				}
			}
			else {
				$refunded_amount +=$temp_trans_arr['payable_amt_of_txn'];	// for refunded
				$mdr_refundfee_amt +=$temp_trans_arr['mdr_refundfee_amt'];	// for mdr refund
				$refunded_count++;	//increase counter

				//for rolling
				$summ_refunded_roll	+= getNumericValue($temp_trans_arr['rolling_amt']);	//for rolling
				$count_refunded_roll++;	//increase counter
			}
		}
		//SUM refunded_amt -- END

		//SUM rolling_amt -- START
		if($temp_trans_arr['merID']=="$uid" && $temp_trans_arr['acquirer']=="3" && ($temp_trans_arr['trans_status']=="1" || $temp_trans_arr['trans_status']=="14"))
		{
			if($tr_id>0){	//if transaction id greater than zero, means only one record to be fetch
				if($temp_trans_arr['id']==$tr_id)	//if request trans id found in array then fetch data and break the loop
				{
					$summ_withdraw_roll	=$temp_trans_arr['rolling_amt'];	//for rolling amount
					$count_withdraw_roll=1;	//set total counting 1
					break;
				}
			}
			else {
				$summ_withdraw_roll +=$temp_trans_arr['rolling_amt'];	//add rolling amount to withdrawl rolling
				$count_withdraw_roll++;	//increase counter
			}
		}
		//SUM rolling_amt -- END

		//SUM payable_amt_of_txn -- START
		if(($temp_trans_arr['merID']=="$uid") && !(($temp_trans_arr['trans_status']=="0" || $temp_trans_arr['trans_status']=="9" || $temp_trans_arr['trans_status']=="10")))
		{
			if($tr_id>0){	//if transaction id greater than zero, means only one record to be fetch
				if($temp_trans_arr['id']==$tr_id)	//if request trans id found in array then fetch data and break the loop
				{
					$sum_payable_amt_mature	= $temp_trans_arr['payable_amt_of_txn'];	//add payable amount
					$sum_payable_count_mature	=1;	//set total counting 1
					break;
				}
			}
			else {
				$sum_payable_amt_mature +=$temp_trans_arr['payable_amt_of_txn'];	//add payable amount to mature payable amount
				$sum_payable_count_mature++;	//increase counter
			}
		}
		//SUM payable_amt_of_txn -- END

		// CALCULATION FOR	summ_mature rolling_amt -- START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && $temp_trans_arr['trans_status']=="1" && fetchFormattedDate($temp_trans_arr['rolling_date'])<=TODAY_DATE_ONLY) {

			if($tr_id>0){	//if transaction id greater than zero, means only one record to be fetch
				if($temp_trans_arr['id']==$tr_id)	//if request trans id found in array then fetch data and break the loop
				{
					$summ_mature_roll	=$temp_trans_arr['rolling_amt']; //rolling amount to sum of mature rolling
					$count_mature_roll	=1;	//set total counting 1
					break;
				}
			}
			else {
				$summ_mature_roll +=$temp_trans_arr['rolling_amt']; //add rolling amount to sum of mature rolling
				$count_mature_roll++;	//increase counter
			}
		}
		// CALCULATION FOR	summ_mature rolling_amt -- END

		// CALCULATION FOR	summ_immature rolling_amt -- START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && $temp_trans_arr['trans_status']=="1" && fetchFormattedDate($temp_trans_arr['rolling_date'])>TODAY_DATE_ONLY) {
			if($tr_id>0){	//if transaction id greater than zero, means only one record to be fetch
				if($temp_trans_arr['id']==$tr_id)	//if request trans id found in array then fetch data and break the loop
				{
					$summ_immature_roll		=$temp_trans_arr['rolling_amt']; //rolling amount to sum of immature rolling
					$count_immature_roll	=1;	//set total counting 1
					break;
				}
			}
			else {
				$summ_immature_roll +=$temp_trans_arr['rolling_amt']; //add rolling amount to sum of immature rolling
				$count_immature_roll++;	//increase counter
			}
		}
		// CALCULATION FOR summ_immature rolling_amt -- END
	}
	//END FOR LOOP

	//copy all above mature transaction into an array
	$mature[0]['summ_mature']	= $summ_mature;
	$mature[0]['count_mature']	= $count_mature;
	$mature[0]['min_id']		= $min_id;
	$mature[0]['max_id']		= $max_id;
	$mature[0]['min_tdate']		= $min_tdate;
	$mature[0]['max_tdate']		= $max_tdate;
	$mature[0]['min_feetime']	= $min_feetime;
	$mature[0]['max_feetime']	= $max_feetime;

	//store total immature into an array
	$immature[0]['summ_immature']	= $summ_immature;
	$immature[0]['count_immature']	= $count_immature;

	//store total withdraw into an array
	$withdraw[0]['summ_withdraw']	= $summ_withdraw;
	$withdraw[0]['count_withdraw']	= $count_withdraw;

	//store total send fund into an array
	$sended_fund[0]['summ_sended_fund']		= $summ_sended_fund;
	$sended_fund[0]['count_sended_fund']	= $count_sended_fund;

	//store total received fund into an array
	$received_fund[0]['summ_received_fund'] = $summ_received_fund;
	$received_fund[0]['count_received_fund']= $count_received_fund;

	//store total refunded amount and mdr into an array
	$refunded_amt[0]['refunded_amt']		= $refunded_amount;
	$refunded_amt[0]['mdr_refundfee_amt']	= $mdr_refundfee_amt;
	$refunded_amt[0]['refunded_count']		= $refunded_count;

	//store total withdraw rolling into an array
	$withdraw_roll[0]['summ_withdraw']	= $summ_withdraw_roll;
	$withdraw_roll[0]['count_withdraw']	= $count_withdraw_roll;

	//store total payable amount (mature) into an array
	$sum_payable_amt_of_txn[0]['sum_payable_amt_of_txn']= $sum_payable_amt_mature;
	$sum_payable_amt_of_txn[0]['count_mature']			= $sum_payable_count_mature;

	//store total immature rolling into an array
	$immature_roll[0]['summ_immature']	= $summ_immature_roll;
	$immature_roll[0]['count_immature']	= $count_immature_roll;

	//store total mature rolling into an array
	$mature_roll[0]['summ_mature']		= $summ_mature_roll;
	$mature_roll[0]['count_mature']		= $count_mature_roll;

	//store total refunded rolling into an array
	$refunded_roll[0]['summ']	= $summ_refunded_roll;
	$refunded_roll[0]['count']	= $count_refunded_roll;


	################ CALCULATION SECTION ############
	$result['summ_mature_2']=number_formatf2($mature[0]['summ_mature']);	//convert summ mature in formatted number system and store into result array
	$result['count_mature_2']=$mature[0]['count_mature'];	//total transaction count

	$result['summ_withdraw_roll']=number_formatf2((double)$withdraw_roll[0]['summ_withdraw']);	//convert summ withdraw rolling in formatted number system and store into result array
	$result['count_withdraw_roll']=$withdraw_roll[0]['count_withdraw'];	//total transaction count

	$summ_withdraw=(double)$withdraw[0]['summ_withdraw']; //convert sum of withdraw in float
	$result['summ_withdraw_amt_1']=str_replace("-","",$summ_withdraw);	//remove '-' if exists in amount
	$result['summ_withdraw_amt']=$summ_withdraw; //sum of withdrawl amount
	$result['summ_withdraw']	=prnpays_crncy($summ_withdraw,'','',$account_curr);
	$result['count_withdraw']	=$withdraw[0]['count_withdraw']; //total transaction count

	$summ_sended_fund=(double)$sended_fund[0]['summ_sended_fund'];		//convert sum of fund into float
	$result['summ_send_fund_amt']=str_replace("-","",$summ_sended_fund);//remove '-' if exists
	$result['summ_sended_fund_amt']=$summ_sended_fund;	//add into array

	//summ_received_fund_amt
	$summ_received_fund=(double)$received_fund[0]['summ_received_fund'];	//convert sum of received fund in float
	$result['summ_received_fund_amt']=str_replace("-","",$summ_received_fund);	//remove '-' if exists
	$result['summ_received_fund']=prnpays_crncy($summ_received_fund,'','',$account_curr);
	$result['count_received_fund']=$received_fund[0]['count_received_fund'];	//total transaction count

	//sum of immature amount
	$summ_immature=(double)$immature[0]['summ_immature'];
	$result['summ_immature_amt']=$summ_immature;
	$result['summ_immature']=prnpays_crncy($summ_immature,'','',$account_curr);
	$result['count_immature']=$immature[0]['count_immature'];	//total transaction count

	//sum of mature amount
	$total_summ_mature_amt=(double)$mature[0]['summ_mature'];
	$result['summ_mature_1']=number_formatf2($total_summ_mature_amt);

	$total_summ_mature_amt=$total_summ_mature_amt+$summ_withdraw;	//calculate total mature amount and withdraw
	$total_summ_mature_amt=$total_summ_mature_amt+$result['summ_sended_fund_amt']; //add send fund amount

	//if manual adjustable balance available then add into mature amount
	if($result['manual_adjust_balance']){
		$total_summ_mature_amt=$total_summ_mature_amt+$result['manual_adjust_balance'];
	}

	$total_summ_mature_amt=$total_summ_mature_amt-$summ_received_fund;	//subtract received amount from total mature amount

	$result['summ_mature_amt']=$total_summ_mature_amt;	//total mature amount

	$result['summ_mature']=prnpays_crncy($result['summ_mature_amt'],'','',$account_curr);	//fetch amount with currency
	$result['count_mature']=$mature[0]['count_mature']-$result['count_withdraw'];	//total transaction count

	//Account Balance calc
	$summ_total=($summ_immature+$result['summ_mature_amt']);	//total amount (mature + immature)

	$result['summ_total_amt']=number_formatf2($summ_total);		//fetch fix number format
	$result['summ_total']=prnpays_crncy($summ_total,'','',$account_curr);	//fetch amount with currency
	$result['count_total']=$result['count_immature']+$result['count_mature'];	//total records (mature and immature)

	$result['sum_payable_amt_of_txn']=number_formatf2((double)$sum_payable_amt_of_txn[0]['sum_payable_amt_of_txn']);
	$result['count_payable_amt_of_txn']=number_formatf2((double)$sum_payable_amt_of_txn[0]['count_mature']);

	//copy all above mature transaction into result for Withdraw
	$result['wd']['mature_count']=$mature[0]['count_mature'];
	//$result['wd']['mature_tid']=$mature[0]['tid'];
	$result['wd']['mature_min_id']=$mature[0]['min_id'];
	$result['wd']['mature_max_id']=$mature[0]['max_id'];
	$result['wd']['mature_min_tdate']=$mature[0]['min_tdate'];
	$result['wd']['mature_max_tdate']=$mature[0]['max_tdate'];
	$result['wd']['mature_min_feetime']=$mature[0]['min_feetime'];
	$result['wd']['mature_max_feetime']=$mature[0]['max_feetime'];

	//Rolling
	$result['summ_refunded_roll']=(double)$refunded_roll[0]['summ'];
	$result['count_refunded_roll']=$refunded_roll[0]['count'];

	//sum of immature
	$immature_roll[0]['summ_immature'];
	$result['summ_immature_roll']=number_formatf2((double)$immature_roll[0]['summ_immature']);	//number format
	$result['count_immature_roll']=$immature_roll[0]['count_immature'];	//immature count

	//sum of mature rolling in defined number format
	$result['summ_mature_roll']=number_formatf2((double)$mature_roll[0]['summ_mature']+$result['summ_withdraw_roll']);

	$result['count_mature_roll']=$mature_roll[0]['count_mature']-$result['count_withdraw_roll'];	//mature rolling count

	$result['summ_total_roll']=number_formatf2($result['summ_immature_roll']+$result['summ_mature_roll']);
	$result['count_total_roll']=$result['count_immature_roll']+$result['count_mature_roll']-$result['count_refunded_roll'];		//total rolling count (mature+immature - refund)
	$result['account_curr']=$account_curr;
	$result['account_curr_sys']=get_currency($account_curr);	//account default currnecy

	if(isset($_GET['qp'])){
		print_r($result);
	}

	return $result;
}
################### A/C BALLANE account_balance_newac() -- END

//if multiple db than fetch balance from previous as a cross db 
function fetch_prvious_balance_cross_db($uid,$project_type='')
{
	global $data; $result=array();
	
	if(!empty(trim($project_type))) $project_type =" AND `project_type`='{$project_type}' ";
	
	$account=db_rows(
		"SELECT SUM(`total_current_balance_amt`) AS `total_current_balance_amt`, SUM(`total_settlement_processed_amt`) AS `total_settlement_processed_amt`, SUM(`total_deductions_amt`) AS `total_deductions_amt`, SUM(`total_mdr_amt`) AS `total_mdr_amt`, SUM(`total_gst_amt`) AS `total_gst_amt`, COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}prvious_balance_db`".
		" WHERE `clientid`='{$uid}' {$project_type}  ". 
		" LIMIT 1");
		
   $result['total_current_balance_amt']=@$account[0]['total_current_balance_amt'];
   $result['total_settlement_processed_amt']=@$account[0]['total_settlement_processed_amt'];
   $result['total_deductions_amt']=@$account[0]['total_deductions_amt'];
   $result['total_mdr_amt']=@$account[0]['total_mdr_amt'];
   $result['total_gst_amt']=@$account[0]['total_gst_amt'];
   $result['count_id']=@$account[0]['count'];
   
   return $result;
}

function m_bal_update_trans($uid=0,$tid=0,$cond=''){
	global $data;$qprint=1;
	$result=array();
	
	
	$fetch_from_tras=" AND ( `id`='{$tid}' ) ";
	
	/*
	echo "uid=>".$uid."<br/><br/>";
	echo "tid=>".$tid."<br/><br/>";
	echo "cond=>".$cond."<br/><br/>";
	echo "GET=>";
	print_r(@$_GET);
	echo "<br/><br/>";
	*/
	
	
	if($cond=='update_available_balance'&&$uid>0){
		
		echo "<script>top.$('#modal_popup_form_popup').slideDown(900);</script>";
			
		$psTbl=select_tablef("`clientid` IN ({$uid})",'payin_setting',0,1,'`available_refresh_tranid`');
		$refresh_tranid=@$psTbl['available_refresh_tranid'];
		
		if(!empty(trim($refresh_tranid)))
		$fetch_from_tras=" AND ( `transID`='{$refresh_tranid}' ) ";
		
		else $fetch_from_tras=" ORDER BY `id` ASC ";
		
		$tid=0;$qprint=0;
		
		//echo "fetch_from_tras=>".$fetch_from_tras."<br/><br/>"; echo "tid=>".$tid."<br/><br/>";
		
		$_GET['tr_bal_upd']='submit';
		
		
	}
	
	if(isset($_GET['qp']))$qprint=$_GET['qp'];
	if(isset($_GET['pq']))$qprint=$_GET['pq'];
	
	
	//fetch last transactions detail
	$c_tra=db_rows(
		"SELECT `id`, `transID`, `tdate`, `available_balance`, `payable_amt_of_txn`".
		" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
		" WHERE ( `merID`='{$uid}' ) ".$fetch_from_tras.
		" LIMIT 1",$qprint
	);
	//print_r($c_tra);
	if($cond=='update_available_balance'&&$uid>0)
		$tid=(int)@$c_tra[0]['id'];
	
	$tdate=date('Y-m-d H:i:s',strtotime(@$c_tra[0]['tdate']));	//transaction date

	//echo "<hr/>tdate=>".$tdate;
	
	//fetch last available balance and fetch required data from transactions table till transaction date which define above 
	
	
	
	$pre_tra=last_available_balance_and_rolling($tid,$tdate,$uid,$qprint,1);
			
	$last_tr_bal=number_formatf2($pre_tra['last_available_balance']);	// available balance
	$last_available_rolling=number_formatf2($pre_tra['last_available_rolling']);	// available rolling
	
	
	if(isset($_GET['all_merchant_wise_update'])&&$_GET['all_merchant_wise_update']){
		$last_tr_bal=0.00;
	}
	
	elseif(isset($_GET['promptmsg'])&&$_GET['promptmsg']){
		$last_tr_bal=$_GET['promptmsg'];
	}
	
	//--------------------------------------------------------
	
	$available_balance=$last_tr_bal+(double)@$c_tra[0]['payable_amt_of_txn'];	//calc available balance
	
	$sq="";
	if(isset($_GET['sq'])){
		@$sq="<input type='hidden' name='sq' value='1' />";
	}
	if(isset($_GET['id'])&&$_GET['id']>0){
		@$sq.="<input type='hidden' name='id' value='".$_GET['id']."' />";
	}
	if(isset($_GET['bid'])&&$_GET['bid']>0){
		@$sq.="<input type='hidden' name='bid' value='".$_GET['bid']."' />";
	}
	//form 
	$form="
		<form action='".$data['urlpath']."' method='get' target='_blank' >
			<input type='hidden' name='admin' value='1' />
			<input type='hidden' name='action' value='tran_bal_upd' />
			{$sq}
			<input type='text' name='promptmsg' value='$last_tr_bal' />
			<input type='submit' name='tr_bal_upd' value='Submit' />
		</form>
	";
	
	if($qprint){
		echo "<hr/><br/><h3>Previous</h3>";
		echo @$pre_tra['last_transID']." pre_tra available_balance=>".$last_tr_bal; echo "<br/>payable_amt_of_txn=>".@$c_tra[0]['payable_amt_of_txn']; echo "<br/>Start available_balance=>".$available_balance; echo "<hr/>Selected transID =>".@$c_tra[0]['transID']; echo "<hr/>pre_tra transID=>".@$pre_tra['last_transID']; echo "<br/><br/><br/>".$form."<br/><br/><br/>";
		$data['SKIP_AVAILABLE_BALANCE_AND_ROLLING']='N';
		$current_tra=available_balance_and_rolling($tid,$tdate,$uid,1);
		echo "<hr/><br/><h3>Recent Balance</h3>";
		echo "Top transID=>".@$current_tra['current_transID'];
		echo "<br/><br/>Current available balance=>".@$current_tra['current_available_balance'];
		echo "<br/><br/>Current available rolling=>".@$current_tra['current_available_rolling'];
		echo "<br/><br/><br/><hr/>";
	}
	//--------------------------------------------------------
	
	
	$date_1st=date('Y-m-d H:i:s',strtotime(@$c_tra[0]['tdate']));	//transaction date as date 1
	$date_2nd=date("Y-m-d H:i:s",strtotime("+1 day",strtotime(date('Y-m-d'))));	//date 2, day after today
	$tdate_pd=" AND ( `tdate` BETWEEN ('{$date_1st}') AND ('{$date_2nd}') ) ";	//transaction period
	
	//fetch transaction list of a merchant according conditions
	$tra_list=db_rows("SELECT `id`,`acquirer`,`payable_amt_of_txn`,`available_balance`,`merID`,`tdate`,`trans_status`,`transID` ".
		" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
		" WHERE ( `merID`='{$uid}' ) ".
		//" AND ( `trans_status` NOT IN (0,9,10)) ".
		" AND ( `trans_status` NOT IN (0,9,10)) AND `acquirer` NOT IN (3) ".
		$tdate_pd." ORDER BY tdate ASC ",$qprint);
			
	/*
	$post_en=replacepost(prntext(json_encode($tra_list)));
	if($post_en){
			$tra_list=json_decode($post_en,1);
	}
	*/
	if($qprint) echo "<hr/>count =>".count($tra_list)."<hr/>";
	
	$i=1;$nmc=1;$mc=1;
	
	if(isset($_GET['tr_bal_upd'])){		//if $_GET['tr_bal_upd'] is set, then update balance via execute following section
		$tran_bal_upd_total='';
		$available_refresh_tranid='';
		foreach($tra_list as $key=>$value){
			
			if(empty($value['payable_amt_of_txn'])) $payable_amt_of_txn = 0;
			else $payable_amt_of_txn=$value['payable_amt_of_txn'];

			$last_tr_bal=($last_tr_bal+$payable_amt_of_txn);
			
			$last_tr_bal=number_format((double)$last_tr_bal, '2', '.', '');
			$tran_bal_upd_total=$last_tr_bal;
			$available_refresh_tranid=$value['transID'];

			//Add Fund af
			/*
			if($value['merID']==$uid&&$value['type']==4){ 
					
				$json_value				=json_decode($value['json_value'],true);
				$json_value['merID_last_available_balance']=$last_tr_bal;
				
				$json_value_set=json_encode($json_value);
				$db_upd1=" `json_value`='{$json_value_set}' ";
				
			}else{
				$db_upd1=" `available_balance`='{$last_tr_bal}' ";
			}
			*/
			
			$db_upd1=" `available_balance`='{$last_tr_bal}' ";
			
			if((isset($_GET['sq']))&&($value['available_balance']!=$last_tr_bal)){
				
				$difference=number_format((double)((double)$value['available_balance']-(double)$last_tr_bal), '2', '.', '');
				
				if($qprint)
				echo "Not Match Count=>".$i."., merID=>".$value['merID'].", acquirer=>".$value['acquirer'].", id=>".$value['id'].", tdate=>".$value['tdate'].", trans_status=>".$value['trans_status'].", transID=>".$value['transID'].", payable_amt_of_txn=>".$value['payable_amt_of_txn'].", available_balance=>".$value['available_balance'].", tr_bal=>".$last_tr_bal."<br/>".", difference=>".$difference."<br/>";
			}else{
				
				if($qprint)
				echo $i.". merID=>".$value['merID'].", acquirer=>".$value['acquirer'].", id=>".$value['id'].", tdate=>".$value['tdate'].", trans_status=>".$value['trans_status'].", transID=>".$value['transID'].", payable_amt_of_txn=>".$value['payable_amt_of_txn'].", available_balance=>".$value['available_balance'].", tr_bal=>".$last_tr_bal."<br/>";
			}
			
			if(isset($_GET['sq'])){
				
			}else{
				db_query(
					"UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
					" SET ".$db_upd1.
					" WHERE `id`='".$value['id']."'",$qprint
				);
			}
			
			if((isset($_GET['sq']))&&($value['available_balance']!=$last_tr_bal)){
				$nmc++;
			}else{
				$mc++;
			}
			
			$i++;
		}
		if(isset($_GET['action'])&&$_GET['action']=='refresh_tran_available_balance')
			$query_upd=" ,`available_refresh_tranid`='{$available_refresh_tranid}' ";
		else $query_upd="";
		
		if($tran_bal_upd_total){
			db_query(
				"UPDATE `{$data['DbPrefix']}payin_setting`".
				" SET `available_balance`='{$tran_bal_upd_total}' {$query_upd}  WHERE `clientid`='{$uid}' ",$qprint
			);
		}
	}
	
	if(!isset($_GET['a']))
	db_disconnect();
	
	if($cond=='update_available_balance'&&$uid>0){
		$msg="Successfully ({$i}) updated and last vailable balance : <b>".@$tran_bal_upd_total."</b>";
		//echo $_SESSION['action_success']=stf($msg);
		echo $msg;
			
		echo "<script>
				setTimeout(function() {
					top.window.popupclose();
					top.$('#myModal12').modal('hide');
					//top.window.location.reload();
					//top.$('#modal_popup_form_popup').slideDown(900);
				}, 1500);
			</script>";
		if(isset($_GET['a'])&&$_GET['a']=='u'){
			
		}
		else exit;
	}
	
	if($qprint)
	{
		echo "<hr/>Merchant Id=>".$uid;
		echo "<hr/>is Not Match Count=>".$nmc;
		echo "<hr/>is Match Count=>".$mc;
		
		echo "<br/><br/><br/><br/>";
		//exit;
	}
	//return $result;
}



function get_trans_graph($post,$grfType=1,$subAdminId=''){
	global $data; $q=0; 
	//$count_id='COUNT(`id`)';
	$count_id='COUNT(*)';
	
	//Select Data from master_trans_additional
	$join_additional=join_additional('t');
	if(!empty($join_additional)) $mts="`ad`";
	else $mts="`t`";

	
	
	//Dev Tech : 23-10-16 Modify for grfType wise because no need to function of create_graphQ , create_graphStore 
	// grfType=1 for group by `t`.`tdate`
	// grfType=2 for group by `t`.`merID`
	// grfType=3 for group by `t`.`terNO`
	
	$where_pred=""; $order_by=" `t`.`tdate` DESC "; 
	
	if(isset($_REQUEST['dtest'])&&$_REQUEST['dtest']){
		echo "<br/><br/>post request1=> ";
		print_r($post);
	}
	
	
	if(isset($_REQUEST['q'])){$q=1;}
	
	
	//echo "<br/>sortingType=>".$post['sortingType'];
	//print_r($post['sortingType']);

	//set sorting if defined
	if(isset($post['sortingType'])&&$post['sortingType']==2){$sort='NOT ';$sortImp='AND';}else{$sort='';$sortImp='OR';}
	
	
	//check login id
	if((isset($_SESSION['sub_admin_id']))&&($_SESSION['get_mid']!='M. All')){
		$get_mid=$_SESSION['get_mid'];
		//$where_pred.=" AND ( `merID` IN ({$get_mid})  ) ";
	}
	
	if(trim($subAdminId)){
		
		$ct=select_tablef("`sponsor` IN ({$subAdminId}) AND `active`=1 ",'clientid_table',0,1," {$count_id} AS `count`, ".group_concat_return('`id`',0)." AS `ids` ");
		
		$where_pred.=" AND ( `t`.`merID` {$sort}IN ({$ct['ids']}) ) ";
		
		$data['clientid_count']=@$ct['count'];
		
		if(isset($_REQUEST['dtest'])&&$_REQUEST['dtest']||@$q){
			echo "<br/> merID=> ".$ct['ids']."<hr/> "; 
			echo "<br/> Total Clients => ".$ct['count']."<hr/> "; 
			echo "<br/> grfType=> ".$grfType.", subAdminId=> ".$subAdminId; 
		}
	}

	
	
	//make query as per grfType
	if($grfType==1){ // group by `t`.`tdate`
		$order_by=" `t`.`tdate` DESC "; 
		
		//group by month and year
		//$g_tdate	=" CONCAT(DATE_FORMAT(`t`.`tdate`, '%b-%Y'),' (',{$count_id},')') `tdates`";
		
		//$g_tdate	=" CONCAT(".date_format_return('`t`.`tdate`',3).",' (',{$count_id},')') `tdates`";
		
		if($data['connection_type']=='PSQL') {
			$g_tdate	=" CONCAT(to_char(date_trunc('month', `t`.`tdate`), 'Mon-YY'),' (',{$count_id},')') `tdates`";
			$group_by	=" GROUP BY DATE_TRUNC('month', `t`.`tdate`), DATE_TRUNC('year', `t`.`tdate`) ";	
			$order_by='';
		}		
		else {
			$g_tdate	=" CONCAT(DATE_FORMAT(`t`.`tdate`, '%b-%Y'),' (',{$count_id},')') `tdates`";
			$group_by	=" group by monthname(`t`.`tdate`), year(`t`.`tdate`) ";	
		}		
	}
	elseif($grfType==2){ // group by `merID`
		$order_by=" `t`.`merID` "; 
		
		$g_tdate	=" CONCAT(`t`.`merID`,' (',{$count_id},')') `merID_ct`";
		//$g_tdate	=" `t`.`terNO`";
		$group_by	=" GROUP BY `t`.`merID` ";		//group by clientid id (merchant id)
	}
	elseif($grfType==3){ // group by `merID`
		$order_by=" `t`.`terNO` "; 
		
		$g_tdate	=" CONCAT(`t`.`terNO`,' (',{$count_id},')') `terNO_ct`";
		$group_by	=" GROUP BY `t`.`terNO` ";
	}
	
	
	
	
	//merchant details
	if(isset($post['merchant_details'])&&$post['merchant_details'])
	{
		$post['merchant_details']=implodef($post['merchant_details']);	//array to string
		$where_pred.=" AND ( `t`.`merID` {$sort}IN ({$post['merchant_details']}) ) ";
	}
	
	//store / website id
	if(isset($post['storeid'])&&$post['storeid']){
		$post['storeid']=implodef($post['storeid']);	//array to string
		$where_pred.=" AND ( `t`.`terNO` {$sort}IN ({$post['storeid']}) ) ";
	}
	
	//acquirer type
	if(isset($post['acquirer'])&&$post['acquirer']){
		$post['acquirer']=implodef($post['acquirer']);	//array to string
		$where_pred.=" AND ( `t`.`acquirer` {$sort}IN ({$post['acquirer']}) ) ";
	}else{
		$where_pred.=" AND ( `t`.`acquirer` NOT IN (0,1,2,3,4,5) ) ";
	}
	
	//payment status
	if(isset($post['payment_status'])&&$post['payment_status']){
		$post['payment_status']=implodef($post['payment_status']);	//array to string
		$where_pred.=" AND ( `t`.`trans_status` {$sort}IN ({$post['payment_status']}) ) ";
	}
	
	//credit / debit card type
	if(isset($post['ccard_types'])&&$post['ccard_types']){
		if(is_array($post['ccard_types'])){
			$post['ccard_types']=('"'.implodes('","',$post['ccard_types']).'"');	//array to string
		}
		
		$where_pred.=" AND ( `t`.`mop` {$sort}IN ({$post['ccard_types']}) ) ";
	}
	
	//create query when search by key
	if(isset($_REQUEST['search_key'])&&isset($_REQUEST['key_name'])&&$_REQUEST['search_key']&&$_REQUEST['key_name']){
		//$search_key=(implodef($post['search_key'],';'));
		//$que=queryArrayf($search_key,$post['key_name'],$sort.'LIKE',$sortImp,';');
		
		$kn=stf($_REQUEST['key_name']);
		$search_key=(implodes(';',$_REQUEST['search_key'])); //array to string contact with semicolon(;)
		
		$search_key2=$search_key1=$_REQUEST['search_key'];
		//$search_key2=('"'.implodes('","',$search_key2).'"');	//array to string
		$search_key2=("'".implodef($search_key2,"','")."'");
		//print_r($search_key2);
		
		if($kn=='bill_phone'||$kn=='product_name'||$kn=='authurl'||$kn=='authdata'||$kn=='source_url'||$kn=='webhook_url'||$kn=='return_url'||$kn=='upa'||$kn=='rrn'||$kn=='acquirer_ref'||$kn=='acquirer_response'||$kn=='descriptor'||$kn=='mer_note'||$kn=='support_note'||$kn=='system_note'||$kn=='json_value'||$kn=='acquirer_json'||$kn=='json_log_history'||$kn=='payload_stage1'||$kn=='acquirer_creds_processing_final'||$kn=='acquirer_response_stage1'||$kn=='acquirer_response_stage2'||$kn=='bin_no'||$kn=='ccno'||$kn=='ex_month'||$kn=='ex_year'||$kn=='trans_response'||$kn=='bill_phone'||$kn=='bill_address'||$kn=='bill_city'||$kn=='bill_state'||$kn=='bill_country'||$kn=='bill_zip'){
			$que= "{$mts}.`".$kn."` {$sort}IN ({$search_key2}) ";
		}
		elseif($kn=='payable_amt_of_txn'||$kn=='bill_amt'||$kn=='trans_amt'||$kn=='buy_mdr_amt'||$kn=='buy_txnfee_amt'||$kn=='rolling_amt'||$kn=='mdr_cb_amt'||$kn=='mdr_cbk1_amt'||$kn=='mdr_refundfee_amt'||$kn=='bank_processing_amount'||$kn=='available_balance'){
			$que= "`t`.`".$kn."` {$sort}IN ({$search_key2}) ";
			
		}
		elseif($kn=='transID'||$kn=='bearer_token'||$kn=='acquirer'||$kn=='trans_status'||$kn=='merID'||$kn=='terNO'||$kn=='channel_type'||$kn=='trans_type'||$kn=='settelement_delay'||$kn=='rolling_delay'||$kn=='remark_status'){
			$que= "`t`.`".$kn."` {$sort}IN ({$search_key1})  ";
		}
		elseif($kn=='descriptor'||$kn=='json_value'||$kn=='acquirer_response'){
			$que=queryArrayf($search_key,$kn,$sort.'LIKE',$sortImp,';',2);
		}
		else{
			//$que=queryArrayf($search_key,$kn,$sort.'LIKE',$sortImp,';');
			$search_key2=impf($search_key1,2);
			$que= "`t`.`".$kn."` {$sort}IN ({$search_key2})  ";
				
			//create query
		}
		$where_pred .= " AND ({$que}) ";
	}

	//if time period time then create query between time period (two dates)
	if(isset($post['time_period'])&&$post['time_period']&&$grfType==1){
		if($post['time_period']==1){
			$g_tdate=" CONCAT(DAYNAME(`t`.`tdate`), ' | ', DATE_FORMAT(`t`.`tdate`, '%Y/%m/%d'), ' | (',{$count_id},')') `tdates`";

			$group_by=" GROUP BY WEEKDAY(`t`.`tdate`) ";

			$where_pred.=" AND ( WEEKDAY(`t`.`tdate`)<9 ) ";

		}elseif($post['time_period']==2){
			//$g_tdate=" CONCAT(DATE_FORMAT(`t`.`tdate`, '%b %Y'),' (',{$count_id},')') `tdates`";
			//$group_by=" group by monthname(tdate), year(tdate) ";
			
			if($data['connection_type']=='PSQL') {
				$g_tdate	=" CONCAT(to_char(date_trunc('month', `t`.`tdate`), 'Mon-YY'),' (',{$count_id},')') `tdates`";
				$group_by	=" GROUP BY DATE_TRUNC('month', `t`.`tdate`), DATE_TRUNC('year', `t`.`tdate`) ";	
				$order_by='';
			}		
			else {
				$g_tdate	=" CONCAT(DATE_FORMAT(`t`.`tdate`, '%b-%Y'),' (',{$count_id},')') `tdates`";
				$group_by	=" group by monthname(`t`.`tdate`), year(`t`.`tdate`) ";	
			}
			
			
			
		}elseif($post['time_period']==3){
			$g_tdate=" CONCAT(DATE_FORMAT(`t`.`tdate`, '%Y'),' (',{$count_id},')') `tdates`";
	
			$group_by=" group by year(tdate) ";
		}elseif($post['time_period']==4||$post['time_period']==6||$post['time_period']==7){
			$g_tdate=" CONCAT(DATE_FORMAT(`t`.`tdate`, '%Y/%m/%d'),' (',{$count_id},')') `tdates`";

			$group_by=" group by date(tdate) ";
		}elseif($post['time_period']==5){
			//$g_tdate=" CONCAT(DATE_FORMAT(`settelement_date`, '%Y/%m/%d'),' (',{$count_id},')') `tdates`";
			//$group_by=" group by date(tdate) ";
			
			if($data['connection_type']=='PSQL') {
				$g_settelement_date	=" CONCAT(to_char(date_trunc('month', `t`.`settelement_date`), 'Mon-YY'),' (',{$count_id},')') `settelement_dates`";
				$group_by	=" GROUP BY DATE_TRUNC('month', `t`.`settelement_date`), DATE_TRUNC('year', `t`.`settelement_date`) ";	
				$order_by='';
			}		
			else {
				$g_settelement_date	=" CONCAT(DATE_FORMAT(`t`.`settelement_date`, '%b-%Y'),' (',{$count_id},')') `settelement_dates`";
				$group_by	=" group by monthname(`t`.`settelement_date`), year(`t`.`settelement_date`) ";	
			}
		}
	}
	elseif(isset($post['time_period'])&&$post['time_period']&&$grfType==2){
		if($post['time_period']==1){
			$g_tdate	=" CONCAT(`t`.`merID`,' (',{$count_id},')') `merID_ct`";

			$group_by=" GROUP BY `t`.`merID` ";

			$where_pred.=" AND ( WEEKDAY(`t`.`tdate`)<9 ) ";

		}elseif($post['time_period']==2){
			$g_tdate	=" CONCAT(`t`.`merID`,' (',{$count_id},')') `merID_ct`";

			$group_by=" GROUP BY `t`.`merID` ";
		}elseif($post['time_period']==3){
			$g_tdate	=" CONCAT(`t`.`merID`,' (',{$count_id},')') `merID_ct`";
	
			$group_by=" GROUP BY `t`.`merID` ";
		}elseif($post['time_period']==4||$post['time_period']==6||$post['time_period']==7){
			$g_tdate	=" CONCAT(`t`.`merID`,' (',{$count_id},')') `merID_ct`";

			$group_by=" GROUP BY `t`.`merID` ";
		}elseif($post['time_period']==5){
			$g_tdate	=" CONCAT(`t`.`merID`,' (',{$count_id},')') `merID_ct`";

			$group_by=" GROUP BY `t`.`merID` ";
		}
	}
	elseif(isset($post['time_period'])&&$post['time_period']&&$grfType==3){
		if($post['time_period']==1){
			$g_tdate	=" CONCAT(`t`.`terNO`,' (',{$count_id},')') `terNO_ct`";

			$group_by=" GROUP BY `t`.`terNO` ";

			$where_pred.=" AND ( WEEKDAY(`t`.`tdate`)<9 ) ";

		}elseif($post['time_period']==2){
			$g_tdate	=" CONCAT(`t`.`terNO`,' (',{$count_id},')') `terNO_ct`";

			$group_by=" GROUP BY `t`.`terNO` ";
		}elseif($post['time_period']==3){
			$g_tdate	=" CONCAT(`t`.`terNO`,' (',{$count_id},')') `terNO_ct`";
	
			$group_by=" GROUP BY `t`.`terNO` ";
		}elseif($post['time_period']==4||$post['time_period']==6||$post['time_period']==7){
			$g_tdate	=" CONCAT(`t`.`terNO`,' (',{$count_id},')') `terNO_ct`";

			$group_by=" GROUP BY `t`.`terNO` ";
		}elseif($post['time_period']==5){
			$g_tdate	=" CONCAT(`t`.`terNO`,' (',{$count_id},')') `terNO_ct`";

			$group_by=" GROUP BY `t`.`terNO` ";
		}
	}
	
	
	if(isset($post['date_1st'])&&$post['date_1st']&&isset($post['date_2nd'])&&$post['date_2nd']){
		$post['date_1st'] = (date('Y-m-d H:i:s',strtotime($post['date_1st'])));
		$post['date_2nd'] = (date('Y-m-d H:i:s',strtotime($post['date_2nd'])));
		//$post['date_2nd']=(date('Y-m-d H:i:s',strtotime("+1 day",strtotime($post['date_2nd']))));

		//if time period value is 5 means, fetch data according payout date
		if(isset($post['time_period'])&&$post['time_period']==5){
			$sl_date='`settelement_date`';
		}else{
			$sl_date='`t`.`tdate`';
		}
		//create query
		//$where_pred.=" AND ( {$sl_date} {$sort}BETWEEN (DATE_FORMAT('{$post['date_1st']}', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$post['date_2nd']}', '%Y%m%d%H%i%s')) ) ";
		
		$where_pred.=" AND ( {$sl_date} {$sort}BETWEEN '{$post['date_1st']}' AND '{$post['date_2nd']}' ) ";
	}
	
	
	
	$where_pred.=$group_by;		//merge query
	
	if(isset($_REQUEST['dtest'])&&$_REQUEST['dtest']){
		echo "<br/><br/>post request=> ";
		print_r($post);
		
		echo "<br/><br/>where_pred=> ".$where_pred."<br/><br/>";
	}
	
	if(!empty($order_by)) $order_by=" ORDER BY ".$order_by;
	
	//fetch data from transactions table
	$depositeData=db_rows("SELECT ".$g_tdate.", SUM(`t`.`trans_amt`) AS `amounts`, {$count_id} AS `ids` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`  AS `t` {$join_additional}  WHERE `t`.`tdate` IS NOT NULL ".$where_pred." {$order_by} ",$q); 
	return $depositeData;
}



function get_clients_listf($active=0, $start=0, $count=0, $online=false, $order=0,$join='',$where='',$in_id=''){
	global $data;
	$qp=0;
	if(isset($_GET['t'])&&$_GET['t']==2){
		$qp=1;
	}
	
	if($start>0){
		$start=$count*($start-1);
	}
	
	$limit=($start?($count?" LIMIT {$start},{$count}":" LIMIT {$start}"):
		($count?" LIMIT {$count}":''));
		
	$orderby =" ORDER BY m.id ";
	$sortmode=" DESC ";
	$trans_table="";$trans_table_count="";$trans_table_cn=false;
	
	$group_by='';
	
	if($order==1){ 
		$trans_table_cn=true;
		$orderby = " AND (t.merID=m.id OR t.sender=m.id) and m.sub_client_id GROUP BY m.id ORDER BY counts ";
	}elseif($order==11){ 
		$orderby = " AND (`m`.`tr_count` IS NOT NULL) AND (`m`.`tr_count` NOT IN (0)) ORDER BY  `m`.`tr_count`+0 ";
	}elseif($order==2){
		$trans_table_cn=true;
		$orderby = " AND (t.merID!=m.id) GROUP BY m.id ORDER BY counts ";
		$sortmode=" ASC ";
	}elseif($order==21){ 
		$orderby = " AND (`m`.`tr_count` IS NOT NULL) ORDER BY  `m`.`tr_count`+0 ";
		
	}elseif($order==3){
		$trans_table_cn=true;
		$orderby = " AND NOT EXISTS (select null from {$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']} AS t1 where t1.merID = m.id) GROUP BY m.id ORDER BY counts ";
		$sortmode=" ASC ";
	}elseif($order==31){ 
		$orderby = " AND (`m`.`tr_count` IS NOT NULL) AND (`m`.`tr_count` NOT IN (0)) ORDER BY  `m`.`tr_count`+0 ";
		$sortmode=" ASC ";
	}elseif($order==4){ 
		$orderby = " AND (m.ip_block_clients='0') ORDER BY m.id ";
		$sortmode=" DESC ";
	}elseif($order==41){ 
		$orderby = " AND (`m`.`tr_count` IS NULL) OR (`m`.`tr_count` IN (0)) ORDER BY  `m`.`tr_count`+0 ";
		$sortmode=" DESC ";
	}
	
	/*
	if(isset($_SESSION['sub_admin_id'])&&isset($_SESSION['sub_admin_rolesname'])&&$_SESSION['sub_admin_rolesname']=="Associate"){
	  $orderby = " AND (m.sponsor={$_SESSION['sub_admin_id']} ) ORDER BY m.id ";
	}
	*/
	
	
	
	if($trans_table_cn==true){
		$trans_table=", {$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']} AS t";
		$trans_table_count=",COUNT(t.id) AS counts";
	}
	
	if($join){
		 $orderby = " GROUP BY m.id ORDER BY m.id ";
		 
		 $group_by=' GROUP BY m.id ';
	}
	
	
	if(((isset($_SESSION['sub_admin_id']))&&($_SESSION['get_mid']!='M. All'))||($in_id)){
		if((isset($_SESSION['get_mid']))&&($_SESSION['get_mid']!='M. All')){
			$in_id=((isset($_SESSION['get_mid'])&&$_SESSION['get_mid'])?$_SESSION['get_mid']:'0');
		}
		$orderby=($in_id?"  AND  ( id IN ({$in_id}) ) ":"")." {$group_by} ORDER BY m.id   ";
	}
	
	
	//Filter clients list for seleced sponsor - MID
		if ((isset($_REQUEST['mid']))&& ($_REQUEST['mid']!='')){
			$where="WHERE m.sponsor=".$_REQUEST['mid']." AND (m.active='{$active}')  AND m.sub_client_id IS NULL"; //add AND m.sub_client_id IS NULL 
			$active= '';
		}else {
		  if($active==5){   // condation 
			$active="WHERE m.sub_client_id IS NOT NULL AND  "; //add AND m.sub_client_id IS NULL 
		  }elseif($active==6){   // condation 
			$active="WHERE "; //add AND m.sub_client_id IS NULL 
		  }elseif($active==7){   /// condation for Live Payout Merchant  08-09-2022
		  $active="WHERE m.payout_request=1 AND  "; 
		  }elseif($active==8){   // condation for Test Payout Merchant  08-09-2022
		  $active="WHERE m.payout_request=2 AND  "; 
		  }elseif($active==9){   // condation for Inactive Payout Merchant  08-09-2022
		  $active="WHERE m.payout_request=3 AND  "; 
		  }else{
			$active="WHERE (m.active='{$active}') AND m.sub_client_id IS NULL AND "; //add AND m.sub_client_id IS NULL 
			}
		}
		
	$limit=query_limit_return($limit);
	
	$where=trim($where);
	$where=ltrim($where,"AND");
	$where=rtrim($where,"AND");
	
	//Dev Tech : 2024-03-02 bug fix 
	if(isset($active)&&empty($where)) {
		$active=trim($active);
		$active=rtrim($active,"AND");
	}
	
	if(isset($_REQUEST['dtest']))echo "<br/>active=>".$active."<br/><br/>";
	if(isset($_REQUEST['dtest']))echo "<br/>where=>".$where."<br/><br/>";
	
	$q="SELECT m.*".$trans_table_count." FROM {$data['DbPrefix']}clientid_table AS m".$trans_table.$join.
			" ".$active." ".$where.
			" ".$orderby.$sortmode." {$limit}";
			
	$q=trim($q);
	if(isset($_REQUEST['dtest']))echo "<br/>q_0=>".$q;
	
	$q=str_ireplace(["WHERE 1 AND ","WHERE AND"],"WHERE ",$q);
	
	if(isset($_REQUEST['dtest']))echo "<br/>q_1=>".$q."<br/><br/>";
		
	$get_clientid_details=db_rows($q,$qp);
	
	// ASC || DESC
	
	$data['result_count']=($start+count($get_clientid_details));
	
	$result=array();
	//$account_type_all="";
	foreach($get_clientid_details as $key=>$value){
		$result[$key]=$value;
		
		if($data['PageFile']!='merchant_list'){
			
			$trans=db_rows(
				"SELECT COUNT(*) AS `count`".
				" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
				" WHERE `merID`='".$result[$key]['id']."' LIMIT 1",0
			);
			$result[$key]['transactions']=@$trans[0]['count'];
			$result[$key]['candelete']=@$trans[0]['count']<2;
			$result[$key]['email']=get_clients_email($result[$key]['id'],true,true);
			
		
		}else{
			$result[$key]['transactions']=$value['tr_count'];
		}
		
		//$result[$key]['total_lead']=0;
			
		
	//sponsor_theme : color and domain apply dynamic
	$sponsor_theme=sponsor_theme($value['sponsor']);
	$result[$key]['color']=$sponsor_theme['color'];
	$result[$key]['domainName']=$sponsor_theme['domainName'];
	
	// For theme color option 
	$result[$key]['header_bg_color']=$sponsor_theme['header_bg_color'];
	$result[$key]['header_text_color']=$sponsor_theme['header_text_color'];
	$result[$key]['body_bg_color']=$sponsor_theme['body_bg_color'];
	$result[$key]['body_text_color']=$sponsor_theme['body_text_color'];
	$result[$key]['heading_bg_color']=$sponsor_theme['heading_bg_color'];
	$result[$key]['heading_text_color']=$sponsor_theme['heading_text_color'];
	
		$stores=db_rows("SELECT COUNT(*) AS `count`, ".group_concat_return('`id`',0)." AS `id`".
			" FROM `{$data['DbPrefix']}terminal` ".
			" WHERE `merID`='".$result[$key]['id']."'".
			" limit 1",0
		);
		$result[$key]['store_count']=@$stores[0]['count'];
		$result[$key]['terNO']=@$stores[0]['id'];
		
		if($data['PageFile']!='merchant_list'){
		
			
			$ratio=get_riskratio_trans($result[$key]['id'],'',true);

			$result[$key]['total_lead']=(isset($ratio['total_ratio'])?$ratio['total_ratio']:0);
			$result[$key]['retrun_trans']=(isset($ratio['retrun_count'])?$ratio['retrun_count']:0);
			$result[$key]['completed_trans']=(isset($ratio['completed_count'])?$ratio['completed_count']:0);
			$result[$key]['settled_trans']=(isset($ratio['settled_count'])?$ratio['settled_count']:0);
			$result[$key]['completed_and_settled']=(isset($ratio['completed_and_settled'])?$ratio['completed_and_settled']:0);
			
			$result[$key]['lead_class']=(isset($ratio['lead_class'])?$ratio['lead_class']:'');
			$result[$key]['lead_color']=(isset($ratio['lead_color'])?$ratio['lead_color']:'');

			if($result[$key]['sponsor']){
				$result[$key]['sname']=
					get_clients_username($result[$key]['sponsor']).'<br>('.
					get_clients_email($result[$key]['sponsor'],true,true).')'
				;
			}else $result[$key]['sname']='N/A';
		}else{
			$ratio=jsondecode($value['card_ratio_json'],1);
			$result[$key]['total_lead']=(isset($ratio['total_ratio'])?$ratio['total_ratio']:0);
			$result[$key]['retrun_trans']=(isset($ratio['retrun_count'])?$ratio['retrun_count']:0);
			$result[$key]['completed_trans']=(isset($ratio['completed_count'])?$ratio['completed_count']:0);
			$result[$key]['settled_trans']=(isset($ratio['settled_count'])?$ratio['settled_count']:0);
			$result[$key]['completed_and_settled']=(isset($ratio['completed_and_settled'])?$ratio['completed_and_settled']:0);
			
			$result[$key]['lead_class']=(isset($ratio['lead_class'])?$ratio['lead_class']:'');
			$result[$key]['lead_color']=(isset($ratio['lead_color'])?$ratio['lead_color']:'');
	  }
	}
	return $result;
}




//Merge two arrays and return into json format.
function json_value_trf($postArray='',$getArray='', $skip=0){
	
	$json_post	=array();
	$json_get=jsondecode($getArray, 1,1);

	if(isset($postArray['processed_acquirer_type'])&&$postArray['processed_acquirer_type']){
		if($json_get['type_history']){
			$json_get['type_history']=$json_get['type_history'].",".$postArray['processed_acquirer_type'];
		}else{
			$json_get['type_history']=$postArray['processed_acquirer_type'];
		}
	}
	
	
	if($json_get){
		$json_post=$json_get;
		if(isset($json_get)&&isset($postArray)) $json_post=array_merge($json_get,$postArray);

		if(isset($postArray['processed_acquirer_type'])&&$postArray['processed_acquirer_type']){
			$json_post['processed_acquirer_type']=$postArray['processed_acquirer_type'];
		}
	}
	$json_value=jsonencode($json_post, $skip);
	return $json_value;
	
}

//Update trans detail including request and response in Json format. Also update payment reference number (acquirer_ref) and descriptor.
function trans_updatesf($id, $post='', $skip=1, $transID=0){
	
	global $data; $where_pred=""; $acquirer_ref=""; $qprint=0; $select_fields=''; $txt_q=""; $txt_q_2=""; $rmk_date=date('d-m-Y h:i:s A');

	if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'){
		if($id){$where_pred =" (`id_ad`='{$id}') AND ";}
		if($transID>0){$where_pred =" (`transID_ad`='{$transID}') AND ";}
		$master_trans_db=$data['ASSIGN_MASTER_TRANS_ADDITIONAL'];
	}
	else {
		if($id){$where_pred =" (`id`='{$id}') AND ";}
		if($transID>0){$where_pred =" (`transID`='{$transID}') AND ";}
		$master_trans_db=$data['MASTER_TRANS_TABLE'];
	}
	
	
	if(isset($_GET['qp'])){$qprint=1;}
	$where_pred=substr_replace($where_pred,'', strrpos($where_pred, 'AND'), 3);

	if(isset($post['system_note'])&&trim($post['system_note'])){
		$select_fields .=', `system_note`';
	}
	$tranSelect=db_rows(
		"SELECT `json_value` {$select_fields} FROM `{$data['DbPrefix']}{$master_trans_db}`".
		" WHERE ".$where_pred." LIMIT 1",$qprint
	);
	$tranSelect=$tranSelect[0];
	
	$json_value=json_value_trf($post,$tranSelect['json_value'], $skip);
	
	
	if(isset($post['system_note'])&&trim($post['system_note'])){
		
		$current_ip=(isset($_SERVER['HTTP_X_FORWARDED_FOR'])&&$_SERVER['HTTP_X_FORWARDED_FOR']?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR']);
		if(strpos($current_ip,',')!==false&&!empty($current_ip)){
			$current_ip=explode1(',',$current_ip)[0];
		}
		elseif(isset($_SESSION['client_ip'])){
			$current_ip=$_SESSION['client_ip'];
		}
	
		$system_note = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$post['system_note']." ( From IP Address: <font class=ip_view>".$current_ip."</font> )"." </div></div>".$tranSelect['system_note'];
		
		$txt_q .= ", `system_note`='".$system_note."'";
		
		//if(isset($json_value['system_note'])) unset($json_value['system_note']);
	}
	
	if(!empty($json_value)){ 
		if(is_string($json_value)) 
			$json_value=str_replace('amp;','',$json_value);
		$txt_q .= ", `json_value`='".$json_value."'"; 
	}
	
	if(!empty($post['acquirer_ref']) && isset($post['acquirer_ref'])){ $txt_q .= ", `acquirer_ref`='".$post['acquirer_ref']."'"; }
	
	if(!empty($post['related']) && isset($post['related'])){ $txt_q .= ", `related`='".$post['related']."'"; }
	
	if(!empty($post['rrn']) && isset($post['rrn'])){ $txt_q .= ", `rrn`='".$post['rrn']."'"; }
	
	if(!empty($post['descriptor']) && isset($post['descriptor'])){ $txt_q .= ", `descriptor`='".$post['descriptor']."'"; }
	
	if(!empty($post['upa']) && isset($post['upa'])){ $txt_q .= ", `upa`='".$post['upa']."'"; }
	
		
	
	if(!empty($post['ccno']) && isset($post['ccno'])){ $txt_q .= ", `ccno`='".$post['ccno']."'"; }
	
	if(!empty($post['bin_no']) && isset($post['bin_no'])){ $txt_q .= ", `bin_no`='".$post['bin_no']."'"; }
	
	if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'&&@$data['MASTER_TRANS_TABLE'])
	{
		
		if(!empty($post['mop'])&&isset($post['mop']))
			$txt_q_2 .= ", `mop`='".$post['mop']."'";
	
		
		if(!empty($txt_q_2)) 
		{
			if($id){$where_pred_2 =" (`id`='{$id}') AND ";}
			if($transID>0){$where_pred_2 =" (`transID`='{$transID}') AND ";}
			$where_pred_2=substr_replace($where_pred_2,'', strrpos($where_pred_2, 'AND'), 3);
			
			$txt_q_2=ltrim($txt_q_2,',');
			db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` SET ".$txt_q_2." WHERE ".@$where_pred_2." ",$qprint);
		}
		
	}else {
		if(!empty($post['mop'])&&isset($post['mop']))
			$txt_q .= ", `mop`='".$post['mop']."'"; 
	}
	
	if(!empty($txt_q)) 
	{
		$txt_q=ltrim($txt_q,',');
		db_query("UPDATE `{$data['DbPrefix']}{$master_trans_db}` SET ".$txt_q." WHERE ".$where_pred." ",$qprint);
	}
}

//Update acquirer type
function tran_type_updf($id, $type=''){
	global $data; $qprint=0;

	if(isset($_GET['qp'])){$qprint=1;}

	$pst=array();

	if($type){
		$pst['processed_acquirer_type']=$type;
	}
	trans_updatesf($id, $pst);	//update json

	
	
}

//Dev Tech : 23-04-06 authf update authurl and authdata
function authf($id, $authurl='', $authdata='', $transID=0){
	global $data; $where_pred="";  $qprint=0; $txt_q=""; 
	
	if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'){
		if($id){$where_pred =" (`id_ad`='{$id}') AND ";}
		if($transID>0){$where_pred =" (`transID_ad`='{$transID}') AND ";}
		$master_trans_db=$data['ASSIGN_MASTER_TRANS_ADDITIONAL'];
	}
	else {
		if($id){$where_pred =" (`id`='{$id}') AND ";}
		if($transID>0){$where_pred =" (`transID`='{$transID}') AND ";}
		$master_trans_db=$data['MASTER_TRANS_TABLE'];
	}
	
	
	if(isset($_GET['qp'])){$qprint=1;}
	$where_pred=substr_replace($where_pred,'', strrpos($where_pred, 'AND'), 3);
	
	
	if(!empty($authurl)){ 
		if(isset($authurl)&&is_array($authurl)){
			$authurl=jsonencode($authurl,1,1);
		}
		$txt_q .= ", `authurl`='".$authurl."'"; 
	}
	if(!empty($authurl)){ 
		if(isset($authdata)&&is_array($authdata)){
			$authdata=jsonencode($authdata,1,1);
		}
	
		$txt_q .= ", `authdata`='".$authdata."'"; 
	}
	
	
	if(!empty($txt_q)&&!empty($where_pred)) {
		$txt_q=ltrim($txt_q,',');
		
		db_query("UPDATE `{$data['DbPrefix']}{$master_trans_db}` SET ".$txt_q." WHERE ".$where_pred." ",$qprint);
	}
}


//Dev Tech : 23-07-12 db_trf update payload_stage1, acquirer_creds_processing_final, acquirer_response_stage1 and acquirer_response_stage2
function db_trf($id, $field='', $value='', $transID=0){
	global $data; $where_pred="";  $qprint=0; $txt_q=""; 
	
	if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'){
		if($id){$where_pred =" (`id_ad`='{$id}') AND ";}
		if($transID>0){$where_pred =" (`transID_ad`='{$transID}') AND ";}
		$master_trans_db=$data['ASSIGN_MASTER_TRANS_ADDITIONAL'];
	}
	else {
		if($id){$where_pred =" (`id`='{$id}') AND ";}
		if($transID>0){$where_pred =" (`transID`='{$transID}') AND ";}
		$master_trans_db=$data['MASTER_TRANS_TABLE'];
	}
	

	if(isset($_GET['qp'])){$qprint=1;}
	$where_pred=substr_replace($where_pred,'', strrpos($where_pred, 'AND'), 3);
	
	
	if(!empty($field)&&!empty($value)&&($field=='acquirer_response_stage1'||$field=='acquirer_response_stage2')){ 
		if(isset($value)&&is_array($value)){
			$value=jsonencode($value,1,1);
		}
		$value=encode64f($value);
		$txt_q .= ", `{$field}`='".$value."'"; 
	}
	else if(!empty($field)&&!empty($value)){ 
		if(isset($value)&&is_array($value)){
			$value=jsonencode($value,1,1);
		}
		$txt_q .= ", `{$field}`='".$value."'"; 
	}
	
	
	
	if(!empty($txt_q)&&!empty($where_pred)) {
		$txt_q=ltrim($txt_q,',');
		
		db_query("UPDATE `{$data['DbPrefix']}{$master_trans_db}` SET ".$txt_q." WHERE ".$where_pred." ",$qprint);
	}
}

function get_trans_reply_counts($uid=0,$reply_status=0){
	global $data;
	$where_pred="";
	if($uid>0){
	//	$where_pred=" AND (`t`.`merID` IN ({$uid}) OR `t`.`sender` IN ({$uid}) )";
		$where_pred=" AND (`t`.`merID` IN ({$uid}))";
	}
	$result=db_rows(
		" SELECT COUNT(`t`.`id`) AS `count`".
		" FROM {$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']} AS `t`".
		" WHERE (`t`.`remark_status` IN ({$reply_status})) ".$where_pred.
		" LIMIT 1",0
	);
	if(isset($result[0])) return $result[0]['count']; 
	else return 0;
}


function get_counts_transf($uid, $dir='both', $extra='1'){
global $data;	
	
	$result=get_trans_count(
		' WHERE '.($uid>0?set_tr_acquirer($uid, $dir).
		($extra?" AND {$extra}":''):($extra?" {$extra}":''))
	);
	$data['getrcount']=$result;
	return $result;
}

function common_trans_detail($id, $uid){
	global $data; $prnt=0;
	
	//as per request connection if multiple 
	if(isset($data['DB_CON'])&&isset($_REQUEST['DBCON'])&&trim($_REQUEST['DBCON'])&&function_exists('config_db_more_connection'))
	{
		$DBCON=(isset($_REQUEST['DBCON'])?$_REQUEST['DBCON']:"");
		$dbad=(isset($_REQUEST['dbad'])?$_REQUEST['dbad']:"");
		$dbmt=(isset($_REQUEST['dbmt'])?$_REQUEST['dbmt']:"");
		config_db_more_connection($DBCON,$dbad,$dbmt);
		
	}
	
	//Select Data from master_trans_additional
	$join_additional=join_additional();
	
	$q="SELECT * FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` {$join_additional}  WHERE `id`='{$id}' LIMIT 1";
	
	
	if(isset($data['Database_3'])&&$data['Database_3']&&function_exists('db_connect_3')&&count($trans)==0){
		$q="SELECT * FROM `{$data['Database_3']}`.`{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` {$join_additional}  WHERE `id`='{$id}' LIMIT 1";
	}
	
	$trans=db_rows($q,$prnt);
		
	$trans=$trans[0];
	if($trans){
		
		if(isset($_GET['bid'])&&$_GET['bid']>0){
			$uid=$_GET['bid'];
			$merID=$_GET['bid'];
		}else{
			if(isset($trans['acquirer'])&&($trans['acquirer']==2||$trans['acquirer']==3)){
				$merID=$trans['merID'];
			}else{
				$merID=$trans['merID'];
			}
			
			
		}
	
		//$dir=(bool)($trans['merID']!=$uid);
		$dir=1;
		$result['id']=$trans['id'];
		$result['direction']=$dir?'FROM':'TO';
		$result['sender']=$trans['merID'];
		$result['senduser']=prnuser($trans['merID']);
		$result['merID']=$merID;
		$result['recvuser']=prnuser($merID);
		$result['userid']=$dir?$trans['merID']:$merID;
		$result['username']=prnuser($result['userid']);
		
		$result['json_value']=$trans['json_value'];
		$json_value2=$trans['json_value'];
		//$json_value=str_replace(array('"{"','"}"'),array('{"','"}'),$json_value);
		$json_value=jsondecode($json_value2,true);
		$result['json_value1']=$json_value;
		
		/*
		echo "<br/><br/>json_value2====>".$json_value2;
		echo "<br/><br/>json_value====>";
		print_r($json_value);
		*/
		
		
		if($trans['acquirer']==4){ //fund
			
			$result['oamount']=$dir?-$trans['bill_amt']:$trans['bill_amt'];
			$trans_amt=$dir?str_replace("-","",$trans['trans_amt']):$trans['trans_amt'];
			
			if($trans['trans_status']==2){
				$status=$dir?'18':'19';
			}else{
				$status=$dir?'16':'17';
			}

			
			$payable_amt_of_txn=$dir?str_replace("-","",$trans['payable_amt_of_txn']):$trans['payable_amt_of_txn'];
			
			
			$available_balance=$dir?$json_value['merID_last_available_balance']:$trans['available_balance'];
			
			$trans_currency=$trans['trans_currency'];
			$trans_currency_payable=$trans['bill_currency'];
			
			
			$result['payout_curr']=$trans_currency;
			$result['payable_amt_of_txn']=prnpays_crncy2((double)$payable_amt_of_txn,$trans_currency);
			
			
		}elseif($trans['acquirer']==2||$trans['acquirer']==3){ // withdraw
			$payable_amt_of_txn=(double)$trans['trans_amt'];
			
			$result['oamount']=$dir?$trans['bill_amt']:-$trans['bill_amt'];
			
			$trans_amt=(double)$trans['payable_amt_of_txn'];
			$available_balance=(double)$trans['available_balance'];
			
			$status=$trans['trans_status'];
			
			//$trans_currency=$trans['bill_currency'];
			$trans_currency=$trans['trans_currency'];
			$trans_currency_payable=$trans['trans_currency'];
			
			if($status!=2){
			
				$result['other_fee']=$trans_amt-((double)$payable_amt_of_txn+(double)$trans['buy_txnfee_amt']);
				$result['other_fee2']=prnpays_crncy2((double)$result['other_fee'],$trans_currency);
				
				if($json_value['wd_account_curr']!=@$json_value['wd_requested_bank_currency']){
					
					$result['wd_payable_amt_of_txn_from']=$json_value['wd_payable_amt_of_txn_from'];
					$result['wd_payable_amt_of_txn_from2']=prnpays_crncy2(-(double)$result['wd_payable_amt_of_txn_from'],$trans_currency);
					
					$result['wd_requested_bank_currency']=@$json_value['wd_requested_bank_currency'];
					$result['wd_account_curr']=@$json_value['wd_account_curr'];
					
					$result['rates']=@$json_value['rates'];
					
					
				}
				
				
if(!isset($json_value['wd_total_monthly_fee'])) $json_value['wd_total_monthly_fee'] = 0;
if(!isset($json_value['wd_wire_fee'])) $json_value['wd_wire_fee'] = 0;
if(!isset($json_value['withdrawfee_calc'])) $json_value['withdrawfee_calc'] = 0;
if(!isset($json_value['wd_virtual_fee'])) $json_value['wd_virtual_fee'] = 0;
if(!isset($json_value['total_gst_fee'])) $json_value['total_gst_fee'] = 0;
if(!isset($json_value['total_mdr_txtfee_amt'])) $json_value['total_mdr_txtfee_amt'] = 0;
if(!isset($json_value['gst_amt'])) $json_value['gst_amt'] = 0;
				
				$result['fee_details']=(double)$json_value['wd_total_monthly_fee']+(double)$json_value['wd_wire_fee']+number_formatf_2($json_value['withdrawfee_calc'])+(double)$json_value['wd_virtual_fee']+(double)$json_value['total_gst_fee'];
				$result['fee_details2']=ltrim(($json_value['total_gst_fee']?"Total GST Fee : <b> ".(double)$json_value['total_gst_fee']."</b>  ":"").($json_value['wd_total_monthly_fee']?" + Total Monthly Fee: <b>  ".(double)$json_value['wd_total_monthly_fee']."</b>":"").($json_value['wd_wire_fee']?" + Wire Fee: <b>".(double)$json_value['wd_wire_fee']."</b>":"").($json_value['withdrawfee_calc']?" + Withdraw Fee: <b>".(double)$json_value['withdrawfee_calc']."</b>":"").($json_value['wd_virtual_fee']?" + Virtual Fee: <b>".(double)$json_value['wd_virtual_fee']."</b>":""),' + ');
				
				
				$result['payout_curr']=$trans['bank_processing_curr'];
				$result['payable_amt_of_txn']=prnpays_crncy2((double)$payable_amt_of_txn,$trans['bank_processing_curr']);
				
				
			}else{
			
				$result['payout_curr']=$trans_currency;
				$result['payable_amt_of_txn']=prnpays_crncy2((double)$payable_amt_of_txn,$trans_currency);
			}
			/*
			if($trans['upa']==991){
				$result['upa']=decode_f(jsonvaluef($trans['acquirer_response'],'decrypt')).' / '.jsonvaluef($trans['acquirer_response'],'bswift');
			}
			*/
		}else{
			$result['oamount']=$dir?$trans['bill_amt']:-$trans['bill_amt'];
			
			$payable_amt_of_txn=$dir?$trans['payable_amt_of_txn']:-$trans['payable_amt_of_txn'];
			
			$trans_amt=$trans['trans_amt'];
			$available_balance=$trans['available_balance'];
			
			$status=$trans['trans_status'];
			
			$trans_currency=$trans['trans_currency'];
			$trans_currency_payable=$trans['bill_currency'];
			
			$result['payout_curr']=$trans_currency;
			$result['payable_amt_of_txn']=prnpays_crncy2((double)$payable_amt_of_txn,$trans_currency);
			
			
			
		}
		
		$result['upa']=($trans['upa']);
		
		$result['pay_txn']=$payable_amt_of_txn;
		
		
		$result['trans_status']=
			"<font color=".get_status_color($status).">".
			$data['TransactionStatus'][$status].
			'</font>'
		;
		
		
		$result['order_amount']=$trans['bill_amt'];
		$result['bill_amt']=prnpays_crncy2($result['oamount'],$trans['bill_currency']);
		/*
		$result['ofees']=$trans['sender']>0&&$trans['sender']==$uid&&$trans['merID']>0?-$trans['bill_amt']:$trans['bill_amt']-$trans['fees'];
		$result['fees_m']=prnpays($result['ofees']);
		$result['ofees1']=$trans['sender']>0&&$trans['sender']==$uid&&$trans['merID']>0?$trans['bill_amt']-$trans['fees']:-$trans['bill_amt'];
		$result['fees_m1']=prnpays($result['ofees1']);
		$result['mfees']=$trans['sender']>0&&$trans['sender']==$uid&&$trans['merID']>0?-($trans['bill_amt']-$trans['fees']):$trans['bill_amt']-$trans['fees'];
		$result['fees_o']=prnpays($result['mfees']);
		*/
		
		$result['tdate']=prndate($trans['tdate']);
		//$result['period']=$trans['period'];
		$result['ostatus']=@$trans['trans_status'];
		$result['acquirer']=@$data['acquirer_list'][$trans['acquirer']];
		if($trans['channel_type']>0&&isset($data['channel'][$trans['channel_type']]['name1'])){
			$result['t']=strtoupper($data['channel'][$trans['channel_type']]['name1']);
		}else{
			$result['t']='';
		}
		
		if(isset($trans['rrn'])){ $result['rrn']=$trans['rrn']; }
		
		$result['typenum']=$trans['acquirer'];
		$result['transID']=$trans['transID'];
		$result['bill_phone']=$trans['bill_phone'];
		$result['bill_email']=$trans['bill_email'];
		$result['fullname']=$trans['fullname'];
		$result['bill_address']=$trans['bill_address'];
		$result['bill_city']=$trans['bill_city'];
		$result['bill_state']=$trans['bill_state'];
		$result['bill_country']=$trans['bill_country'];
		$result['bill_zip']=$trans['bill_zip'];
		$result['product_name']=$trans['product_name'];
		$result['mop']=$trans['mop'];
		//$result['card']=$trans['ccno'];
		//$result['card']=decryptres($trans['ccno']);
		$result['card']=($trans['ccno']);
		
		//$result['c']= card_decrypts256($trans['ccno']);
		//$result['fees_o_txt']=$result['mfees'];
		$result['mer_note']=$trans['mer_note'];
		$result['support_note']=$trans['support_note'];
		$result['acquirer_ref']=$trans['acquirer_ref'];
		$result['acquirer_response']=$trans['acquirer_response'];
		$result['transaction_flag']=$trans['transaction_flag'];
		$result['source_url']=$trans['source_url'];
		$result['webhook_url']=$trans['webhook_url'];
		$result['return_url']=$trans['return_url'];
		
		
		//$result['orderset']=$trans['orderset'];
		
		$result['system_note']=$trans['system_note'];
		
		$result['curr_nam']=$trans['bill_currency'];
		$result['related_transID']=$trans['related_transID'];
		$result['trans_response']=$trans['trans_response'];
		$result['reference']=$trans['reference'];
		
		
		
		
		
		$result['trans_currency']=$trans_currency;
		
		//$result['buy_mdr_amt']=number_formatf($trans['buy_mdr_amt']);
		$result['buy_mdr_amt']=prnpays_crncy2((double)$trans['buy_mdr_amt'],$trans_currency);
		
		$result['mdr_amt2']=prnpays_crncy2((double)$result['buy_mdr_amt'],$trans_currency);
		
		$result['buy_txnfee_amt']=number_formatf($trans['buy_txnfee_amt']);
		$result['mdr_txtfee_amt2']=prnpays_crncy2((double)$result['buy_txnfee_amt'],$trans_currency);
		
		$result['rolling_amt']=number_formatf($trans['rolling_amt']);
		$result['rolling_amt2']=prnpays_crncy2((double)$result['rolling_amt'],$trans_currency);
		
		$result['mdr_cb_amt']=number_formatf($trans['mdr_cb_amt']);
		
		$result['mdr_cb_amt2']=prnpays_crncy2((double)$result['mdr_cb_amt'],$trans_currency);
		
		$result['mdr_cbk1_amt']=number_formatf($trans['mdr_cbk1_amt']);
		
		$result['mdr_cbk1_amt2']=prnpays_crncy2((double)$result['mdr_cbk1_amt'],$trans_currency);
		
		
		$result['mdr_refundfee_amt']=number_formatf($trans['mdr_refundfee_amt']);
		
		$result['mdr_refundfee_amt2']=prnpays_crncy2((double)$result['mdr_refundfee_amt'],$trans_currency);
		
		$result['trans_amt']=number_formatf($trans_amt);
		$result['transaction_amount']=prnpays_crncy2((double)$trans_amt,$trans_currency);
		$result['available_rolling']=number_formatf($trans['available_rolling']);
		
		$result['available_balance_amt']=number_formatf($available_balance);
		$result['available_balance']=prnpays_crncy2((double)$available_balance,$trans_currency);
		
		
		$result['bank_processing_amount']=$trans['bank_processing_amount'];
		$result['bank_processing_curr']=$trans['bank_processing_curr'];
		
		
		$result['fee_update_timestamp']=$trans['fee_update_timestamp'];
		$result['descriptor']=$trans['descriptor'];
		$result['bill_ip']=$trans['bill_ip'];
		$result['trans_amt']=$trans['trans_amt'];
		$result['remark_status']=$trans['remark_status'];
		
		
		$result['orderid']=($trans['reference']);
		//$result['orderid']=ordersetf($trans['orderset'],3);
		$result['terNO']=$trans['terNO'];
		$result['transaction_period']=$trans['transaction_period'];
		$result['settelement_date']=prndate($trans['settelement_date']);
		
		if(isset($trans['bin_no'])&&$trans['bin_no']){$result['bin_no']=$trans['bin_no'];}
		if(isset($trans['ex_month'])&&$trans['ex_month']){$result['ex_month']=$trans['ex_month'];}
		if(isset($trans['ex_year'])&&$trans['ex_year']){$result['ex_year']=$trans['ex_year'];}
		if(isset($trans['json_log_history'])&&$trans['json_log_history']){$result['json_log_history']=$trans['json_log_history'];}
		
		
		
		$clients_info=mer_settings($trans['merID'], 0, true, $trans['acquirer']); 
		$account_get=select_terminals($trans['merID'], $trans['terNO'], true);
		if($account_get){
			
			if($account_get[0]['bussiness_url']){
				$result['bussiness_url']=$account_get[0]['bussiness_url'];
			}
			if($account_get[0]['dba_brand_name']){
				$result['dba_brand_name']=$account_get[0]['dba_brand_name'];
			}
		}
		
		if(empty($_SESSION['adm_login'])&&$_SESSION['login']&&$trans['remark_status']==2){
			db_query(
				"UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
				" SET `remark_status`=3".
				" WHERE `id`='".$trans['id']."'"
			);
		}
		
		if($trans['bill_ip']){
			$count_ip=db_rows("(SELECT COUNT(id) AS ip_count FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` WHERE `bill_ip`='{$trans['bill_ip']}' LIMIT 1)");
			$result['ip_count']=$count_ip[0]['ip_count'];
		}else{
			$result['ip_count']="";
		}
		
		
		
		$result['ch_id']="";
			
	/*
		$data['wdatatype']= $trans['acquirer'];
		$data['wstatus']= $trans['trans_status']; 
		
		if($trans['fees']>0&&($trans['acquirer']==1||$trans['acquirer']==2||($dir&&($trans['acquirer']==0||$trans['acquirer']==3)))){
			$result['ofees']=-$trans['fees'];
		}else{
			$result['ofees']=0;
		}
		$result['fees']=prnfees($result['ofees']);
		$result['fees_dir']=prnpays_fee($trans['sender']>0&&$trans['sender']==$uid&&$trans['merID']>0?-$trans['fees']:0);
		$result['onets']=$trans['sender']>0&&$trans['sender']==$uid&&$trans['merID']>0?$trans['bill_amt']:$trans['bill_amt']-$trans['fees'];
		$result['nets']=prnpays($result['onets'], false);
		$result['comments']=prntext($trans['comments']);
		$result['ecomments']=prntext($trans['ecomments']);
		$result['canview']=($trans['acquirer']>=0&&$trans['acquirer']<=3);
		$result['canrefund']=can_refund($trans['id'], $uid);
	*/
	
	}
	
	
	return $result;
}



function set_tr_acquirer($uid, $dir,$as=''){
	global $data;
	switch($dir){
		case 'both':
			return "( {$as}`merID` = '{$uid}')";
		case 'incoming':
			return "( {$as}`merID` = '{$uid}')";
		case 'outgoing':
			return "( {$as}`merID` = '{$uid}')";
	}
	return '';
}

//function for get trans at merchant level
function mer_trans_list($uid, $dir='both', $acquirer=-1, $trans_status=-1, $start=0, $count=0, $order='', $suser='', $sdate='', $backUpDb=''){

	global $data,$post; 
	
	if(isset($data['backUpDbSet'])&&!empty($data['backUpDbSet']))
		$backUpDb=$data['backUpDbSet'];
	
	$data['backUpDb']=$backUpDb;	//if backUpDb name
	
	$qp=0; 
	if(isset($_REQUEST['q'])){$qp=1;}

	if(!empty($suser)||!empty($sdate)){
		$start=0;
		$count=0;
	}
	
	if($start>0){
		$start=$count*($start-1);	//calculate start page 
	}
	
	$pg_limit = $count;
	if($count){
		//$limit = $count+1;
		$limit = $count++;		//set limit
	}

	//create query as per limit set
	$limit=($start?($count?" LIMIT {$start},{$count}":" LIMIT 0,{$start}"):
	($count?" LIMIT 0,{$count}":''));
		
	$limit=query_limit_return($limit);
		
	$trans_status_qry=" ( `t`.`trans_status`={$trans_status} ) ";
	//fetch data from echeck
	$echeck="";
	if(strpos($order,"c.")!==false){
		$order = str_replace('ORDER BY','GROUP BY `t`.`tdate` ORDER BY',$order);
		$echeck=", `{$data['DbPrefix']}echeck` AS `c`";
	}else{
		$echeck="";
	}
	
	$mid_query="";
	if((isset($_SESSION['sub_admin_id']))&&($_SESSION['get_mid']!='M. All')){
		$get_mid=$_SESSION['get_mid'];

		$mid_query.=" AND ( `t`.`merID` IN ({$get_mid})) ";
	}
	
	//Select Data from master_trans_additional
	$join_additional=join_additional('t');
	if(!empty($join_additional)) $ad=',`ad`.*';
	else $ad='';
	
	
	
	//fetch data from transaction, use inner join with clients and subadmin
	if ((isset($_REQUEST['mid'])) && ($_REQUEST['mid']!='') && (!empty($_SESSION['login_adm'])) ){
		$q ="SELECT `t`.* ";
		$q.=" FROM (`{$data['DbPrefix']}clientid_table` AS `m`";
		$q.=" INNER JOIN `{$data['DbPrefix']}subadmin` AS `s` ON";
		$q.=" `m`.`sponsor` = `s`.`id`)";
		$q.=" INNER JOIN {$backUpDb}`{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` AS `t` ON";
		$q.=" (`m`.`id` = `t`.`merID`)";
		$q.=" WHERE (`m`.`sponsor`='".$_REQUEST['mid']."')";
		$q.=" {$order} {$limit}";
	}
	else {	//fetch data from transaction
		$q1	="SELECT `t`.*  {$ad} ";
		$q1.=" FROM {$backUpDb}`{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` AS `t{$echeck}`";
		$q1.=$join_additional;
		
		$q2	=$mid_query;
		$q2.=($uid?" AND ".set_tr_acquirer($uid, $dir,"`t`."):'');
		$q2.=($acquirer<0?'':" AND ( `t`.`acquirer` IN ({$acquirer}) ) ");
		$q2.=($trans_status<0?'':" AND ".$trans_status_qry);
		$q2.=" {$order} {$limit}";
		
//		echo $q2;exit;
		
		if(strpos($q2,'AND') !== false)
		{
			$q2=substr_replace($q2,'', strpos($q2, 'AND'), 3);
			$q = $q1.' WHERE '.$q2;
		}
		else
			$q = $q1." ". $q2;
	}
	$trans=db_rows($q, $qp);	//execute query and fetch rows from transactions table 
	
	$data['tr_counts_q'] = $q;	//store query into data array
	
	$data['last_record']=count($trans);	//total records found

	$data['result_count']=((int)$start+(int)count($trans));


	$pgn = $post['StartPage']-1;
	
	if($pgn<0) $pgn = 0;
	
	$start_rec = ($pgn)*$data['MaxRowsByPage']+1;	//first record of the page
	
	if($data['last_record']>$data['MaxRowsByPage'])	//check last record is greater than page or not
		$end_rec = ($pgn)*$data['MaxRowsByPage']+$data['MaxRowsByPage']; //calculate last record of page
	else 
		$end_rec = $start_rec+$data['last_record']-1;

	$data['start_rec']	= $start_rec;	//first record of a page into data array
	$data['end_rec']	= $end_rec;		//last record of a page into data array
	
	$data['result_count']	= $start_rec;	//first record of a page into data array
	$data['tr_count']		= $end_rec;		//last record of a page into data array


	$clients_list=get_all_clients_new($uid);		//fetch clients list 
	
	$result=array();

	$sno=1;
	foreach($trans as $key=>$value){	//fetch all data row by row

		if(isset($_GET['bid']) && $_GET['bid']>0){
			$uid=$_GET['bid'];
			$merID=$_GET['bid'];				
		}else{
			if($value['acquirer']==2||$value['acquirer']==3){
				$merID=$value['merID'];		
			}else{
				$merID=$value['merID'];	//merID
			}
		}
		$dir=1;
		//$dir=(bool)($value['sender']!=$uid);	//sender true of false
		$dir_r=(bool)($value['merID']==$uid);	//merID true of false
		$result[$key]['id']=$value['id'];	//table id
		$result[$key]['direction']=$dir?'FROM':'TO';	//set direction depend on dir true or false
		//$result[$key]['sender']=$value['sender'];	//sender
		$result[$key]['merID'] = $merID;	//merID

		//$result[$key]['senduser'] = $value['sender'] > 0 ? $clients_list[$value['sender']]['username'] : 'system';	//sender username

		$result[$key]['recvuser'] = $merID > 0 ? @$clients_list[$merID]['username'] : 'system';	//merID username

		//$result[$key]['userid']	= $dir ? $value['sender'] : $merID;	//user id
		//$result[$key]['username'] = $result[$key]['userid'];	//username via user id

		$json_value_de=jsondecode($value['json_value'],1,1);	//json into array

		if($value['acquirer']==4){ // fund
			$result[$key]['oamount']=$dir?-$value['bill_amt']:$value['bill_amt'];
			$trans_amt=$dir?str_replace("-","",$value['trans_amt']):$value['trans_amt'];

			if($value['trans_status']==2){
				$trans_status=$dir?'18':'19';	//received Cancelled 18 and send Cancelled 19
			}else{
				$trans_status=$dir?'16':'17';	//received fund 16 and send fund 17
			}

			$json_value=jsondecode($value['json_value'],1,1);
			$available_balance=$dir?$json_value['merID_last_available_balance']:$value['available_balance'];

			$trans_currency=$value['trans_currency'];

		}
		elseif($value['acquirer']==2||$value['acquirer']==3){ // withdraw

			$result[$key]['oamount']=$dir?$value['bill_amt']:-$value['bill_amt'];
			
			$trans_amt=$value['payable_amt_of_txn'];
			$available_balance=$value['available_balance'];

			if(isset($json_value_de['frozen_acquirer'])&&is_array($json_value_de)&&$json_value_de&&trim($json_value_de['frozen_acquirer'])=='Frozen Balance'){
				$trans_status=20;
			}elseif(isset($json_value_de['frozen_acquirer'])&&is_array($json_value_de)&&$json_value_de&&trim($json_value_de['frozen_acquirer'])=='Frozen Rolling'){
				$trans_status=21;
			}else{
				$trans_status=$value['trans_status'];
			}

			$trans_currency=$value['bill_currency'];
			$result[$key]['bill_email']	=encrypts_decrypts_emails($value['bill_email'],2,true);
		}
		else{
			$result[$key]['oamount']=$dir?$value['bill_amt']:-$value['bill_amt'];
			$trans_amt=$value['trans_amt'];
			$available_balance=$value['available_balance'];

			$trans_status=$value['trans_status'];

			$trans_currency=$value['trans_currency'];	//transaction amount with curr
			$result[$key]['bill_email']	=$value['bill_email'];			//email bill_address
		}
		
		//fetch multiple db 
		if(isset($data['DB_CON'])&&function_exists('config_db_more_check_link'))
		{
			$check_link=config_db_more_check_link(@$data['DBCON'],@$data['dbad'],@$data['dbmt']);
			
			$result[$key]['dbad_link'] =@$check_link['dbad_link'];
			$result[$key]['dbad_link_2'] =@$check_link['dbad_link_2'];
			
		}
		
		
		$result[$key]['bill_amt']=prnpays_crncy2($result[$key]['oamount'],$value['bill_currency']);	//order amount
		
		$result[$key]['trans_amt']=prnpays_crncy2((double)$trans_amt,$trans_currency);	//transaction amount with currency

		$result[$key]['available_balance']=prnpays_crncy2((double)$available_balance,$trans_currency);	//available_balance with currency

		$result[$key]['buy_txnfee_amt']=trprnpays($value['buy_txnfee_amt'], false);	//mdr fee amount
		$result[$key]['payable_amt_of_txn']=trprnpays($value['payable_amt_of_txn'], false);	//payable amt

		$data['wdatatype']= $value['acquirer'];	//transaction acquirer
		$data['wtrans_status']= $value['trans_status']; //trans_status
		$result[$key]['trans_status']=
			"<font color=".get_status_color($trans_status).">".
			$data['TransactionStatus'][$trans_status].
			'</font>'
		;

		$result[$key]['json_value_de']=$json_value_de;
		if(isset($json_value_de['post']['fullname'])&&$json_value_de['post']['fullname']){
			$result[$key]['fullname']=$json_value_de['post']['fullname'];	//fullname
		}else{
			$result[$key]['fullname']=$value['fullname'];	//fullname
		}

		$result[$key]['tdate']				=prndate($value['tdate']);	//trans date
		$result[$key]['period']				=isset($value['period'])?$value['period']:'';	//period
		
		
		$result[$key]['acquirer']			=(isset($data['acquirer_name'][$value['acquirer']])?$data['acquirer_name'][$value['acquirer']]:''); 
		
		if($value['channel_type']>0){
			$result[$key]['t']				=((isset($data['channel'][$value['channel_type']]['name1'])&&$data['channel'][$value['channel_type']]['name1'])?strtoupper($data['channel'][$value['channel_type']]['name1']):''); //name 2 from api_lable
		}else{
			$result[$key]['t']='';
		}
		
		$result[$key]['ostatus']			=$value['trans_status'];	
		$result[$key]['typenum']			=$value['acquirer'];	//transaction acquirer
		
		if(isset($value['rrn']))
		{
			$result[$key]['rrn']			=$value['rrn'];
		}
		
		$result[$key]['transID']			=$value['transID'];	//transaction id or payment id
		$result[$key]['bill_phone']			=$value['bill_phone'];		//cust phone number
		//emaild id
		if($value['acquirer']==2||$value['acquirer']==3||$value['acquirer']==4)
			$result[$key]['bill_email']		=encrypts_decrypts_emails($value['bill_email'],2,true);
		else
		$result[$key]['bill_email']			=$value['bill_email'];
		
		$result[$key]['bearer_token']			=$value['bearer_token'];	
		$result[$key]['bill_address']		=$value['bill_address'];	//cust bill_address
		$result[$key]['bill_city']			=$value['bill_city'];	//cust bill_city
		$result[$key]['bill_state']			=$value['bill_state'];	//cust bill_state
		$result[$key]['bill_country']		=$value['bill_country'];	//cust country code
		$result[$key]['transaction_flag']	=$value['transaction_flag'];	//transaction_flag
		$result[$key]['bill_zip']			=$value['bill_zip'];		//bill_zip or pincode
		$result[$key]['product_name']		=$value['product_name'];//product title or name
		$result[$key]['mop']				=$value['mop'];	//card acquirer
		$result[$key]['card']				=$value['ccno'];		//card number

		$result[$key]['mer_note']			=$value['mer_note'];			//mer_note
		$result[$key]['support_note']		=$value['support_note'];	//reply mer_note
		$result[$key]['acquirer_ref']		=$value['acquirer_ref'];			//payment ref number
		$result[$key]['acquirer_response']	=$value['acquirer_response'];		//txn value in json
		$acquirer_response_de						=jsondecode($value['acquirer_response'],1,1);	//txn value in array
		$result[$key]['acquirer_response_de']		=$acquirer_response_de;
		
		
		if(isset($_SESSION['transaction_display_arr'])&&(in_array("ccno",$_SESSION['transaction_display_arr']))){
			$result[$key]['ccno']=card_decrypts256($value['ccno']);
		}
		
		$result[$key]['card']				=$value['ccno'];
		$result[$key]['mop']				=$value['mop'];	
		$result[$key]['upa']				=$value['upa'];	
		
		// Dev Tech : 23-01-10 compare modify 
		if(isset($value['gst_amt'])){
			$result[$key]['gst_amt']=$value['gst_amt']; //gst fee
		}
		if(isset($value['rrn'])){
			$result[$key]['rrn']=$value['rrn'];  //rrn
		}
		
		$result[$key]['terNO']				=$value['terNO'];	//store or webist eid
		$result[$key]['json_value']			=$value['json_value'];	//json value
		$result[$key]['bill_ip']			=$value['bill_ip'];			//client bill_ip
		$result[$key]['buy_mdr_amt']		=$value['buy_mdr_amt'];		//mdr amount
		$result[$key]['return_url']			=$value['return_url'];	//success url
		$result[$key]['rolling_amt']		=$value['rolling_amt'];	//rolling amount
		$result[$key]['mdr_cb_amt']			=$value['mdr_cb_amt'];	//mdr charge back amt
		$result[$key]['mdr_cbk1_amt']		=$value['mdr_cbk1_amt'];	//mdr charge back1 amt
		$result[$key]['mdr_refundfee_amt']	=$value['mdr_refundfee_amt'];	//mdr refunded fee
		$result[$key]['settelement_date']	=$value['settelement_date'];		//payout date
		$result[$key]['created_date']		=$value['created_date'];	//transaction date
		$result[$key]['risk_ratio']			=$value['risk_ratio'];		//risk ratio
		$result[$key]['transaction_period']	=$value['transaction_period'];	//trans period
		$result[$key]['bank_processing_amount']=$value['bank_processing_amount'];	//bank processing amt
		$result[$key]['bank_processing_curr']=$value['bank_processing_curr'];	//bank processing currnecy
		$result[$key]['bill_currency']		=$value['bill_currency'];		//currency name in 3 char
		$result[$key]['descriptor']			=$value['descriptor'];		//payment descriptor

		$result[$key]['source_url']			=$value['source_url'];		//source url
		$result[$key]['webhook_url']		=$value['webhook_url'];		//notify or callback url
		//$result[$key]['orderset']			=$value['orderset'];		//order set
		$result[$key]['system_note']		=$value['system_note'];		//system name
		$result[$key]['trans_type']			=$value['trans_type'];			//transaction name
		$result[$key]['reference']			=$value['reference'];			//merchant ref id
		$result[$key]['ostatus']			=$value['trans_status'];			
		$result[$key]['channel_type']		=$value['channel_type'];
        $result[$key]['trans_response']		=$value['trans_response'];			//trans_response
		$result[$key]['related_transID']	=$value['related_transID'];		//related transaction id
		$result[$key]['bin_no']				=$value['bin_no'];			//card bin number
		$result[$key]['gst_amt']			=$value['gst_amt'];			//gst fee for Indian
		$result[$key]['upa']				=$value['upa'];				//upa

		$result[$key]['canview']			=($value['acquirer']>=0&&$value['acquirer']<=3);
		//$result[$key]['canrefund']		=can_refund($value['id'], $uid);

		//if(isset($_SESSION['transaction_display_arr'])&&(in_array("ccno",$_SESSION['transaction_display_arr'])))
		{
			$result[$key]['ccno']=card_decrypts256($value['ccno']);	//decrpyts card with sha256
		}
		if($pg_limit==$sno++) {break;}	//break loop if transaction more than page limit
	}
	return $result;	//return all transaction rows
}

function adm_trans_list($uid, $dir='both', $acquirer=-1, $trans_status=-1, $start=0, $count=0, $order='', $sort = 'DESC', $suser='', $sdate='', $backUpDb=''){

	global $data,$post; 
	
	if(isset($data['backUpDbSet'])&&!empty($data['backUpDbSet']))
		$backUpDb=$data['backUpDbSet'];
	
	$data['backUpDb']=$backUpDb;	//if backUpDb name
	
	
	$newstart = $newlimit = 0;
	//calculate page number, start record of a page and total records etc
	if(isset($_GET['tscount']))
	{
		$curr_page	= @$_GET['page'];
		$tscount	= @$_GET['tscount'];
		$tpage		= ceil($tscount/$count);

		if($tpage>2000)	//if total page greater than 2000
		{
			$midpage = ceil($tpage/2);
			if($curr_page>$midpage)
			{
				$sort = 'ASC';
				$newstart	= ($tpage-$curr_page)*$count;

				if($tpage==$curr_page) {
					$newlimit	= $tscount-(($curr_page-1)*$count);
				}
				else {
					$ext = ($tscount%$count);
					if($ext>0) $newstart = $newstart-($count-$ext);
					$newlimit	= $count;
				}
			}
		}
	}

	$qp=0; 
	if(isset($_REQUEST['q'])){$qp=1;}

	if(!empty($suser)||!empty($sdate)){
		$start=0;
		$count=0;
	}
	
	if($start>0){
		$start=$count*($start-1);	//calculate start page 
	}
	
	$pg_limit = $count;
	if($count){
		//$limit = $count+1;
		$limit = $count++;
	}

	//create query as per limit set
	if($newlimit)
	{
		$limit=($newstart?($newlimit?" LIMIT {$newstart},{$newlimit}":" LIMIT 0,{$newstart}"):
		($newlimit?" LIMIT 0,{$newlimit}":''));
	}
	else
	{
		$limit=($start?($count?" LIMIT {$start},{$count}":" LIMIT 0,{$start}"):
		($count?" LIMIT 0,{$count}":''));
	}	
	
	$limit=query_limit_return($limit);
	
	$trans_status_qry=" ( t.trans_status={$trans_status} ) ";
	$echeck="";
	if(strpos($order,"c.")!==false){
		$order = str_replace('ORDER BY','GROUP BY t.tdate ORDER BY',$order);
		$echeck=", `{$data['DbPrefix']}echeck` AS `c`";
	}else{
		$echeck="";
	}
	
	$mid_query="";
	if((isset($_SESSION['sub_admin_id']))&&($_SESSION['get_mid']!='M. All')){
		$get_mid=$_SESSION['get_mid'];
		
		$mid_query.=" AND ( `t`.`merID` IN ({$get_mid})) ";
	}
	
	//Select Data from master_trans_additional
	$join_additional=join_additional('t');
	if(!empty($join_additional)) $ad=',`ad`.*';
	else $ad='';
		
	
	//fetch data from transaction, use inner join with clients and subadmin
	if ((isset($_REQUEST['mid'])) && ($_REQUEST['mid']!='') && (!empty($_SESSION['login_adm'])) ){
		$q ="SELECT `t`.* ";
		$q.=" FROM (`{$data['DbPrefix']}clientid_table` AS `m`";
		$q.=" INNER JOIN `{$data['DbPrefix']}subadmin` AS `s` ON";
		$q.=" `m`.`sponsor` = `s`.`id`)";
		$q.=" INNER JOIN {$backUpDb}`{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` AS `t` ON";
		$q.=" (`m`.`id` = `t`.`merID`)";
		$q.=" WHERE (`m`.`sponsor`='".$_REQUEST['mid']."')";
		$q.=" {$order} {$sort} {$limit}";
	}
	else {	//fetch data from transaction
		$q1="SELECT `t`.* {$ad} ";
		$q1.=" FROM {$backUpDb}`{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` AS `t{$echeck}`";
		$q1.=$join_additional;
		
		$q2	=$mid_query;
		$q2.=($uid?" AND ".set_tr_acquirer($uid, $dir,"`t`."):'');
		$q2.=($acquirer<0?'':" AND ( `t`.`acquirer` IN ({$acquirer}) ) ");
		$q2.=($trans_status<0?'':" AND ".$trans_status_qry);
		$q2.=" {$order} {$sort} {$limit}";

//		echo $q2;exit;

		if(strpos($q2,'AND') !== false)
		{
			$q2	= substr_replace($q2,'', strpos($q2, 'AND'), 3);
			$q	= $q1.' WHERE '.$q2;
		}
		else
			$q	= $q1." ". $q2;
	}
	
	//echo "<br/><br/>q=><br/>".$q."<br/><br/>";
	
	if(isset($_REQUEST['a'])&&$_REQUEST['a']=='cn2'&&isset($_SESSION['login_adm'])) {
		$qp=1;
	
		echo "<hr/><br/><==adm_trans_list==><br/>";
		echo "<br/>DBCON=>".@$data['DBCON']."<br/>";
		echo "<br/>dbad=>".@$data['dbad']."<br/>";
		echo "<br/>dbmt=>".@$data['dbmt']."<br/>";
		echo "<br/>connection_type=>".@$data['connection_type']."<br/>";
		echo "<br/>Hostname=>".@$data['Hostname']."<br/>";
		echo "<br/>Username=>".@$data['Username']."<br/>";
		echo "<br/>Password=>".@$data['Password']."<br/>";
		echo "<br/>Database=>".@$data['Database']."<br/>";
		
	}					
	
	$trans=db_rows($q,$qp);
	
	$data['tr_counts_q'] = $q;	//store query into data array
	
//	print_r($trans);
	if($newlimit)
	{
		array_multisort(array_column($trans, 'tdate'), SORT_DESC, $trans);	//sort by tdate in desc
	}
	$data['last_record']=count($trans);	//total records found
	
	
	/*
	// Check Backup db for above of 7 days trans
	if($data['last_record']==0&&$backUpDb==''&&isset($data['Database_3'])&&$data['Database_3']&&function_exists('db_connect_3')){
			echo "<br/>last_record=>".$data['last_record'];
			adm_trans_list($uid, $dir, $acquirer, $trans_status, $start, $count, $order, $sort, $suser, $sdate, '`above7daysmastertrans`.');
	}
	*/

	$data['result_count']=((int)$start+(int)count($trans));

	$pgn = $post['StartPage']-1;
	
	if($pgn<0) $pgn = 0;
	
	$start_rec = ($pgn)*$data['MaxRowsByPage']+1;	//first record of the page
	
	if($data['last_record']>$data['MaxRowsByPage'])	//check last record is greater than page or not
		$end_rec = ($pgn)*$data['MaxRowsByPage']+$data['MaxRowsByPage']; //calculate last record of page
	else 
		$end_rec = $start_rec+$data['last_record']-1;

	$data['start_rec']	= $start_rec;		//first record of a page into data array
	$data['end_rec']	= $end_rec;			//last record of a page into data array
	
	$data['result_count'] = $start_rec;		//first record of a page into data array
	$data['tr_count'] = $end_rec;			//last record of a page into data array

	$clients_list = get_all_clients_new();	//fetch clients list
	
	if(isset($_REQUEST['cli'])&&$_REQUEST['cli']==1){
		//print_r($clients_list);
	}

	$result=array();

	$sno=1;
	foreach($trans as $key=>$value){		//fetch all data row by row
		/*
		if(isset($_GET['bid']) && $_GET['bid']>0){
			$uid=$_GET['bid'];
			$merID=$_GET['bid'];			//merID
		}else{
			if($value['acquirer']==2||$value['acquirer']==3){
				$merID=$value['merID'];		//sender
			}else{
				$merID=$value['merID'];	//merID
			}
		}
		*/
		$merID=(int)$value['merID'];	//merID
		
		//$dir=(bool)($value['sender']!=$uid);		//sender true of false
		$dir=1;		//sender true of false
		//$dir_r=(bool)($value['merID']==$uid);	//merID true of false
		$result[$key]['id']=$value['id'];			//table id
		$result[$key]['direction']=$dir?'FROM':'TO';//set direction depend on dir true or false
		//$result[$key]['sender']	=$value['merID'];	//sender
		$result[$key]['merID'] = $merID;		//merID
		
		
		//fetch multiple db 
		if(isset($data['DB_CON'])&&function_exists('config_db_more_check_link'))
		{
			$check_link=config_db_more_check_link(@$data['DBCON'],@$data['dbad'],@$data['dbmt']);
			
			$result[$key]['dbad_link'] =@$check_link['dbad_link'];
			$result[$key]['dbad_link_2'] =@$check_link['dbad_link_2'];
			
		}
		

		//$result[$key]['senduser'] = $value['merID'] > 0 ? $clients_list[$value['sender']]['username'] : 'system';	//sender username

		$result[$key]['recvuser'] = ((isset($merID)&&$merID) > 0 ? (isset($clients_list[$merID]['username'])?$clients_list[$merID]['username'] : 'system') : 'system');	//merID username

		$result[$key]['userid'] = $merID;	//user id
		$result[$key]['username'] = $result[$key]['userid'];			//username via user id

		$json_value_de=jsondecode($value['json_value'],1,1);			//json into array

		if($value['acquirer']==4){ // fund
			$result[$key]['oamount']=$dir?-$value['bill_amt']:$value['bill_amt'];
			$trans_amt=$dir?str_replace("-","",$value['trans_amt']):$value['trans_amt'];

			if($value['trans_status']==2){
				$trans_status=$dir?'18':'19';	//received Cancelled 18 and send Cancelled 19
			}else{
				$trans_status=$dir?'16':'17';	//received fund 16 and send fund 17
			}

			$json_value=jsondecode($value['json_value'],1,1);	//convert json into array
			$available_balance=$dir?$json_value['merID_last_available_balance']:$value['available_balance'];	//available_balance

			$trans_currency=$value['trans_currency'];	//transaction amount

		}
		elseif($value['acquirer']==2||$value['acquirer']==3){ // withdraw

			$result[$key]['oamount']=$dir?$value['bill_amt']:-$value['bill_amt'];

			$trans_amt	=$value['payable_amt_of_txn'];
			$available_balance	=$value['available_balance'];

			if(isset($json_value_de['frozen_acquirer'])&&is_array($json_value_de)&&$json_value_de&&trim($json_value_de['frozen_acquirer'])=='Frozen Balance'){
				$trans_status=20;
			}elseif(isset($json_value_de['frozen_acquirer'])&&is_array($json_value_de)&&$json_value_de&&trim($json_value_de['frozen_acquirer'])=='Frozen Rolling'){
				$trans_status=21;
			}else{
				$trans_status=$value['trans_status'];
			}

			$trans_currency=$value['bill_currency'];
		}
		else{
			$result[$key]['oamount']=$dir?$value['bill_amt']:-$value['bill_amt'];
			$trans_amt=$value['trans_amt'];
			$available_balance=$value['available_balance'];

			$trans_status=$value['trans_status'];

			$trans_currency=$value['trans_currency'];		//transaction amount with curr
		}
		
		$result[$key]['bill_amt']=prnpays_crncy2($result[$key]['oamount'],$value['bill_currency']);	//order amount
		
		$result[$key]['trans_amt']=prnpays_crncy2((double)$trans_amt,$trans_currency);	//transaction amount with currency

		$result[$key]['tamount']=$value['trans_amt'];	//transaction amount

		$result[$key]['available_balance']=prnpays_crncy2((double)$available_balance,$trans_currency);	//available_balance with currency

		$result[$key]['buy_txnfee_amt']=trprnpays($value['buy_txnfee_amt'], false);	//mdr fee amount
		$result[$key]['payable_amt_of_txn']=trprnpays($value['payable_amt_of_txn'], false);	//payable amt

		$data['wdatatype']= $value['acquirer'];	//transaction acquirer
		$data['wtrans_status']= $value['trans_status'];	//trans_status
		$result[$key]['trans_status']=
			"<font color=".get_status_color($trans_status).">".
			$data['TransactionStatus'][$trans_status].
			'</font>'
		;

		$result[$key]['json_value_de']=$json_value_de;
		if(isset($json_value_de['post']['fullname'])&&$json_value_de['post']['fullname']){
			$result[$key]['fullname']=$json_value_de['post']['fullname'];	//fullname
		}else{
			$result[$key]['fullname']=$value['fullname'];	//fullname
		}

		$result[$key]['tdate']				=prndate($value['tdate']);	//trans date
		$result[$key]['period']				=isset($value['period'])?$value['period']:'';	//period
		$result[$key]['otrans_status']		=$value['trans_status'];	//trans_status
		if(isset($data['acquirer_list'][$value['acquirer']])){
			$result[$key]['acquirer']		=$data['acquirer_list'][$value['acquirer']]; 
		}else{
			$result[$key]['acquirer']		='';
		}
		if($value['channel_type']>0){
			$result[$key]['t']				=strtoupper(@$data['channel'][@$value['channel_type']]['name1']); //name 2 from api_lable
		}else{
			$result[$key]['t']='';
		}
		$result[$key]['typenum']		=$value['acquirer'];		//transaction acquirer
		$result[$key]['transID']		=$value['transID'];	//transaction id or payment id
		$result[$key]['bill_phone']		=$value['bill_phone'];		//cust phone number

		//emaild id
		if($value['acquirer']==2||$value['acquirer']==3||$value['acquirer']==4)
			$result[$key]['bill_email']		=encrypts_decrypts_emails($value['bill_email'],2,true);
		else
			$result[$key]['bill_email']		=$value['bill_email'];
	
		$result[$key]['bearer_token']			=$value['bearer_token'];	
		$result[$key]['bill_address']			=$value['bill_address'];	//cust bill_address
		$result[$key]['bill_city']				=$value['bill_city'];	//cust bill_city
		$result[$key]['bill_state']				=$value['bill_state'];	//cust bill_state
		$result[$key]['bill_country']			=$value['bill_country'];	//cust country code
		$result[$key]['transaction_flag']	=$value['transaction_flag'];	//transaction_flag
		$result[$key]['bill_zip']				=$value['bill_zip'];		//bill_zip or pincode
		$result[$key]['product_name']		=$value['product_name'];//product title or name
		

		$result[$key]['mer_note']				=$value['mer_note'];			//mer_note
		$result[$key]['support_note']		=$value['support_note'];	//reply mer_note
		$result[$key]['acquirer_ref']				=$value['acquirer_ref'];			//payment ref number
		$result[$key]['acquirer_response']			=$value['acquirer_response'];		//txn value in json
		$acquirer_response_de						=jsondecode($value['acquirer_response'],1,1);	//txn value in array
		$result[$key]['acquirer_response_de']		=$acquirer_response_de;
		
		
		if(isset($_SESSION['transaction_display_arr'])&&(in_array("ccno",$_SESSION['transaction_display_arr']))){
			$cc_number=card_decrypts256($value['ccno']);
			$result[$key]['ccno']=bclf($cc_number,$value['bin_no']);
		}
		
		$result[$key]['card']				=$value['ccno'];
		$result[$key]['mop']				=$value['mop'];	
		$result[$key]['upa']				=$value['upa'];	
		
		// Dev Tech : 23-01-10 compare modify 
		if(isset($value['gst_amt'])){
			$result[$key]['gst_amt']=$value['gst_amt']; //gst fee
		}
		if(isset($value['rrn'])){
			$result[$key]['rrn']=$value['rrn'];  //rrn
		}
		
		
		
		
		$result[$key]['json_log_history']	=$value['json_log_history'];
		$result[$key]['terNO']				=$value['terNO'];
		$result[$key]['json_value']			=$value['json_value'];
		$result[$key]['bill_ip']			=$value['bill_ip'];//internet bill_ip
		$result[$key]['buy_mdr_amt']		=number_formatf2($value['buy_mdr_amt']);			
		$result[$key]['sell_mdr_amt']		=number_formatf2($value['sell_mdr_amt']);			
		$result[$key]['return_url']			=$value['return_url'];		//success url
		$result[$key]['rolling_amt']		=$value['rolling_amt'];		//rolling amount
		$result[$key]['mdr_cb_amt']			=$value['mdr_cb_amt'];		//mdr charge back amt
		$result[$key]['mdr_cbk1_amt']		=$value['mdr_cbk1_amt'];	//mdr charge back1 amt
		$result[$key]['mdr_refundfee_amt']	=$value['mdr_refundfee_amt'];	//mdr refunded fee
		$result[$key]['settelement_date']		=$value['settelement_date'];		//payout date
		$result[$key]['created_date']		=$value['created_date'];	//transaction date
		$result[$key]['risk_ratio']			=$value['risk_ratio'];		//risk ratio
		$result[$key]['transaction_period']	=$value['transaction_period'];	//trans period
		$result[$key]['bank_processing_amount']=$value['bank_processing_amount'];	//bank processing amt
		$result[$key]['bank_processing_curr']=$value['bank_processing_curr'];	//bank processing currnecy
		$result[$key]['bill_currency']			=$value['bill_currency'];		//currency name in 3 char
		$result[$key]['descriptor']			=$value['descriptor'];		//payment descriptor

		$result[$key]['source_url']			=$value['source_url'];		//source url
		$result[$key]['webhook_url']			=$value['webhook_url'];		//notify or callback url
		//$result[$key]['orderset']			=$value['orderset'];		//order set
		//$result[$key]['tableid']			=$value['tableid'];			//table id
		$result[$key]['system_note']		=$value['system_note'];		//system name
		$result[$key]['trans_type']			=$value['trans_type'];			
		$result[$key]['reference']			=$value['reference'];			
		$result[$key]['ostatus']			=$value['trans_status'];			
		$result[$key]['channel_type']		=$value['channel_type'];			
		
		//$result[$key]['rrn']				=$value['rrn'];			

		//trans_response
		$result[$key]['trans_response']		=tr_reasonf($value['trans_response']);
		$result[$key]['related_transID']	=$value['related_transID'];		//related transaction id
		$result[$key]['bin_no']				=@$value['bin_no'];			//bin no (first six digit of cc
		$result[$key]['ex_month']			=@$value['ex_month'];		//card expiry month
		$result[$key]['ex_year']			=@$value['ex_year'];		//card expiry year

		$result[$key]['canview']			=($value['acquirer']>=0&&$value['acquirer']<=3);
		//$result[$key]['canrefund']			=can_refund($value['id'], $uid);	//no any use

		if($pg_limit==$sno++) {break;}
	}
	return $result;	//return transction detail
}


function update_trans_ranges($uid, $status, $trange='', $paydate='',  $update_tr=true,  $adm_login=true, $json_value='')
{
	global $data; $result=[];
	
	$is_multiple_cross_db=false;
	
	//as per request connection if multiple 
	if(isset($data['DB_CON'])&&isset($_REQUEST['DBCON'])&&trim($_REQUEST['DBCON'])&&function_exists('config_db_more_connection'))
	{
		
		$is_multiple_cross_db=1;
		$DBCON=(isset($_REQUEST['DBCON'])?$_REQUEST['DBCON']:"");
		$dbad=(isset($_REQUEST['dbad'])?$_REQUEST['dbad']:"");
		$dbmt=(isset($_REQUEST['dbmt'])?$_REQUEST['dbmt']:"");
	}
	
	
	$wheres = "";$cpost=array();
	$status_name=$data['TransactionStatus'][$status];
	$status_email=$status;
	$admin_name="Admin";


	if($uid>0){
		$wheres .= " ( `merID`='{$uid}' ) AND ";
		$user=get_clients_info($uid);
		if(isset($user['fullname'])&&$user['fullname'])	//check if fullname exists then use fullname
			$name=$user['fullname'];
		else
			$name="{$user['fname']} {$user['lname']}";	//if fullname not exists then add fname+lname

		$name=" by {$name} ({$user['username']}) - ( From IP Address: <font class=ip_view>".$data['Addr']."</font> )";
		$name2=" by {$user['username']} - ( From IP: <font class=ip_view>".$data['Addr']."</font> )";
		$admin_name=$name2;
	}else{
		$name=' by System ';
	}
	
	if($adm_login==true){
		if(isset($_SESSION['sub_username'])&&$_SESSION['sub_username']){
			$admin_name = " by ".$_SESSION ['sub_username']." ".$_SESSION['sub_admin_fullname'];
		}else{
			$admin_name = 'by Admin';
		} 
		$admin_name="{$admin_name} - ( From IP: <font class=ip_view>".$data['Addr']."</font> )";
		$name=$admin_name;
	}
	
	$new_trano = "";
	$tr_status_set = "Transaction <font color=".get_status_color($status).">".$status_name."</font> ".$name;
	$remark_fld="`support_note`";
	$remark_status = "";
	
	if($uid>0 && $adm_login==false && ($status==8||$status==13)){
		$tr_status_set="<font color=".get_status_color($status).">".$status_name."</font> ".$name;
		$remark_fld="`mer_note`";
		$remark_status = " `remark_status`='1' ";
	}
	
	
	
	if(!empty($_GET['promptmsg'])){$promptmsg="<font color=".get_status_color($status).">".$_GET['promptmsg']."</font> ";}else{$promptmsg="";}
	
	if($status==1){
		$tr_status_set = $tr_status_set." - ".$promptmsg;
	}elseif($status==512||$status==513){
		$tr_status_set = $promptmsg;
	}elseif($status==611||$status==612||$status==712){ // flag and unflag
		$tr_status_set = $promptmsg.$admin_name;
	}else{
		$tr_status_set = $promptmsg." - ".$tr_status_set;
	}
	
	if($uid>0 && $adm_login==false && $status==2){
		$tr_status_set="Transaction <font color=".get_status_color($status).">".$status_name."</font> ".$name2;
		$remark_fld="`mer_note`";
		
	}
	
	
	
	switch($status){
		case 1:
			$wheres .= "  ( `trans_status` IN (0,8,13,14) )  AND  ";
			$remark_status = " `remark_status`='2' ";
			break;
		case 4:
			$wheres .= " ( `trans_status` IN (1) )  AND ";
			break;
		case 712:
			$wheres .= " ( `trans_status` IN (1) ) AND ";
			break;
		case 512:
			$wheres .= " ( `trans_status` IN (1,4,8) )  AND ";
			break;
		case 412: // reminder by Merchant
			$wheres .= " ( `trans_status` IN (1,4) ) AND ";
			$tr_status_set="Send reminder email to customer about the transaction ".$name2;
			break;
			
	}
	
	if(!empty($trange)){
		$wheres .= " ( `id` IN ({$trange}) ) ";
	}elseif(!empty($paydate)){
		$wheres .= $paydate;		
	}
	
	//echo "<hr/>".$wheres."<hr/>";
	
	
	//Select Data from master_trans_additional
	$join_additional=join_additional();
	
	$tresult=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` {$join_additional} WHERE {$wheres} ",0
	);
	
	
	foreach($tresult as $key=>$value){
		
		$result['transID']=$value['transID'];
	
		$order_bill_amt=$value['trans_amt'];
		if(empty($order_bill_amt)) $order_bill_amt=$value['bill_amt'];
		
		if($value['trans_status']==1){
			$cpost['trans_status']=1;
		}
		
		switch($status){
			case 3:
				if((isset($_GET['confirm_bill_amt']))&&($_GET['confirm_bill_amt']<$value['bill_amt'])){
					$status=12;
					$status_name="Refunded for ".$_GET['confirm_bill_amt']." from ".$value['bill_amt'];
					$order_bill_amt=$_GET['confirm_bill_amt'];
					$promptmsg=str_replace("Refunded Reason:","Partial Refund Reason:",$promptmsg);
				}
				$remark_status = " `remark_status`='2' ";
			break;
			case 8:
				if((isset($_GET['confirm_bill_amt']))&&($_GET['confirm_bill_amt']<$value['bill_amt'])&&(!isset($_SESSION['login']))){
					//$status=12;
					$remark_fld="`mer_note`";
					$tr_status_set="<font color=".get_status_color($status)."> Partial Refund Request for ".$_GET['confirm_bill_amt']." from ".$value['bill_amt']." </font> ".$tr_status_set;
					$order_bill_amt=$_GET['confirm_bill_amt'];
					$promptmsg="Partial Refund Reason: ".$_GET['confirm_bill_amt'];
				}
				$remark_status = " `remark_status`='1' ";
			break;
		}
		
		
		
		$tr_id 				= $value['id']; 
		$remark_get 		= $value['support_note']; 
		$type_get 			= $value['acquirer'];
		$type_ch 			= '12';
		
		$status_get 		= $value['trans_status'];
		$transID_get 		= $value['transID'];
		//$tableid_get 		= $value['tableid'];
		$system_note_get 	= $value['system_note'];
		$merchant_note_get	= $value['mer_note'];
		$returnedStatus		= " - Transation <font color=".get_status_color($status).">".$status_name." by System</font> with Previous Order No. <a class=viewthistrans>" .$value['transID']."</a>";
		
		if($uid>0 && $adm_login==false && ($status==8||$status==13)){
			$remark_get		= $value['mer_note'];
		}
		
		if($type_get==2||$type_get==3||$type_get==4){
			$remark_status = " `remark_status`='2' ";
		}
		
			
		
		
	
		if($json_value&&$json_value['ar_transID']){
			$transactioncode = $json_value['ar_transID'];
			$today 			 = $json_value['ar_tdate'];
			$now			 = "'".$json_value['ar_tdate']."'";
		}else{
			$transactioncode = $type_get.date("ymdHis");
			$today 			 = date('Y-m-d H:i:s',time());
			$now			 = "'".date('Y-m-d H:i:s')."'";
		}
	
	
		
		$rmk_date=date('d-m-Y h:i:s A');
		
		
		
		if(isset($_GET['promptmsg'])){
			$trans_response=explode(': ',$_GET['promptmsg']);
			if(isset($trans_response[1])&&$trans_response[1]){
				$trans_response=$trans_response[1];
			}else{
				$trans_response=$_GET['promptmsg'];
			}
		}else{
			$trans_response="NA";
		}
		
	
		if($adm_login){
			
			$cqp=$data['cqp'];
			
			if($status==6 || $status==3 || $status==5 || $status==11 || $status==12){
				
				//as per request connection for default - latest 
				if(isset($data['DB_CON'])&&isset($data['DBCON_DEFAULT'])&&trim($data['DBCON_DEFAULT'])&&function_exists('config_db_more_connection')&&$is_multiple_cross_db==1)
				{
					$DBCON_DEFAULT=(isset($data['DBCON_DEFAULT'])?$data['DBCON_DEFAULT']:"");
					$dbad_default=(isset($data['dbad_default'])?$data['dbad_default']:"");
					$dbmt_default=(isset($data['dbmt_default'])?$data['dbmt_default']:"");
					//sleep(1);
					config_db_more_connection($DBCON_DEFAULT,$dbad_default,$dbmt_default);
					sleep(1);
					
				}

				
				$related_transID="";
				
				$returnedStatus_insrt = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$promptmsg." ".$returnedStatus." </div></div>".$remark_get;
				
				if(isset($data['con_name'])&&$data['con_name']=='clk'){
					$insert_qr_1=",`gst_amt` ";
					$insert_qr_2=",'{$value['gst_amt']}' ";
				}else{
					$insert_qr_1=" ";
					$insert_qr_2=" ";
				}
			
			
			if(empty(trim($value['bill_amt']))) $value['bill_amt']='0.00';
			if(empty(trim($value['buy_mdr_amt']))) $value['buy_mdr_amt']='0.00';
			if(empty(trim($value['buy_txnfee_amt']))) $value['buy_txnfee_amt']='0.00';
			if(empty(trim($value['rolling_amt']))) $value['rolling_amt']='0.00';
			if(empty(trim($value['mdr_cb_amt']))) $value['mdr_cb_amt']='0.00';
			if(empty(trim($value['mdr_cbk1_amt']))) $value['mdr_cbk1_amt']='0.00';
			if(empty(trim($value['mdr_refundfee_amt']))) $value['mdr_refundfee_amt']='0.00';
			//if(empty(trim($value['available_rolling']))) $value['available_rolling']='0.00';
			//if(empty(trim($value['available_balance']))) $value['available_balance']='0.00';
			//if(empty(trim($value['payable_amt_of_txn']))) $value['payable_amt_of_txn']='0.00';
			if(empty(trim($value['trans_amt']))) $value['trans_amt']='0.00';
			if(empty(trim($value['bank_processing_amount']))) $value['bank_processing_amount']='0.00';
			
			
			
			if(empty($value['bin_no'])) $value['bin_no']='null';
			elseif(!empty($value['bin_no'])) $value['bin_no']="'".$value['bin_no']."'";
			if(empty($value['acquirer_response'])) $value['acquirer_response']='null';
			elseif(!empty($value['acquirer_response'])) $value['acquirer_response']="'".$value['acquirer_response']."'";
			if(empty($value['json_value'])) $value['json_value']='null';
			elseif(!empty($value['json_value'])) $value['json_value']="'".$value['json_value']."'";
				
			$additional_fld=$master_fld=", `bill_address`, `bill_city`, `bill_state`, `bill_zip`, `ccno`,`bin_no`, `bill_phone`,`product_name`,`support_note`,`acquirer_ref`,`acquirer_response`,`source_url`,`webhook_url`,`return_url`,`bill_country`,`system_note`,`descriptor`,`json_value`,`upa`,`rrn`,`payload_stage1`,`acquirer_creds_processing_final`,`acquirer_response_stage1`,`acquirer_response_stage2`,`trans_response` " ;
			
			$additional_data=$master_data=", '{$value['bill_address']}','{$value['bill_city']}','{$value['bill_state']}','{$value['bill_zip']}','{$value['ccno']}',{$value['bin_no']},'{$value['bill_phone']}','{$value['product_name']}','{$returnedStatus_insrt}','{$value['acquirer_ref']}',{$value['acquirer_response']},'{$value['source_url']}','{$value['webhook_url']}','{$value['return_url']}','{$value['bill_country']}','{$value['system_note']}','{$value['descriptor']}',{$value['json_value']},'{$value['upa']}','{$value['rrn']}','{$value['payload_stage1']}','{$value['acquirer_creds_processing_final']}','{$value['acquirer_response_stage1']}','{$value['acquirer_response_stage2']}','{$trans_response}' " ;
			
			if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y')
			{
				$master_fld=''; $master_data='';
			}
				
				// acquirer_ref
				db_query(
					"INSERT INTO `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
					"(`tdate`,`transID`,`merID`,`bill_amt`,`acquirer`,`trans_status`, `fullname`, `bill_email`,`mop`,`bearer_token`,`bill_currency`,`transaction_flag`,`rolling_amt`,`buy_mdr_amt`,`buy_txnfee_amt`,`mdr_cb_amt`,`mdr_cbk1_amt`,`mdr_refundfee_amt`,`bill_ip`,`trans_amt`,`trans_type`,`reference`,`terNO`,`settelement_date`,`settelement_delay`,`rolling_date`,`rolling_delay`,`trans_currency`,`risk_ratio`,`transaction_period`,`bank_processing_amount`,`bank_processing_curr`{$master_fld}{$insert_qr_1})VALUES(".
					"{$now},'{$transactioncode}','{$value['merID']}','{$value['bill_amt']}','{$value['acquirer']}',".
					"'{$status}','{$value['fullname']}','{$value['bill_email']}','{$value['mop']}','{$value['bearer_token']}','{$value['bill_currency']}','{$value['transaction_flag']}','{$value['rolling_amt']}','{$value['buy_mdr_amt']}','{$value['buy_txnfee_amt']}','{$value['mdr_cb_amt']}','{$value['mdr_cbk1_amt']}','{$value['mdr_refundfee_amt']}','{$value['bill_ip']}','{$order_bill_amt}','{$value['trans_type']}','{$value['reference']}','{$value['terNO']}','{$value['settelement_date']}','{$value['settelement_delay']}','{$value['rolling_date']}','{$value['rolling_delay']}','{$value['trans_currency']}','{$value['risk_ratio']}','{$value['transaction_period']}','{$value['bank_processing_amount']}','{$value['bank_processing_curr']}' ".$master_data.$insert_qr_2.
					" )",$data['cqp']
				);
				
				if(isset($data['DB_CON'])&&isset($data['DBCON_DEFAULT'])&&trim($data['DBCON_DEFAULT'])&&function_exists('config_db_more_connection')&&$is_multiple_cross_db==1)
				sleep(1);
					
				$transactions_newid=newid();
				
				
				$transactioncode = gen_transID_f(@$transactions_newid,$value['acquirer'],1);
				
				//insert data to new table for master_trans_additional and this value is Y  
				if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'&&$transactions_newid>0){
					db_query("INSERT INTO `{$data['DbPrefix']}{$data['ASSIGN_MASTER_TRANS_ADDITIONAL']}` (`id_ad`,`transID_ad` ".$additional_fld.")VALUES".
					"('{$transactions_newid}','{$transactioncode}' ".$additional_data.")",$data['cqp']);
					$tableName=$data['ASSIGN_MASTER_TRANS_ADDITIONAL'];
				}
				
				if($data['cqp']==9) exit;
				
				$tr_status_set = $promptmsg." - Transation has been <font color=".get_status_color($status).">".$status_name." by System</font> with your New Order No. <a class=viewthistrans>R".$transactioncode."</a>";
				
				
				calculation_trans_fee($transactions_newid);
				$calculation_tr_fee_upd=false;
				$status=7;
				//echo "<hr/>transactions_newid=>".$transactions_newid;
			}else {
				$calculation_tr_fee_upd=true;
			}
		}
		$master_update_default = " `trans_status`='{$status}', ".$remark_status;
		
		
		
		// updt_defulat_status is additional_update
		
		if($status_email==512||$status_email==513||$status_email==712){$master_update_default =$updt_defulat_status =""; }
		
		$remark_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$tr_status_set." </div></div>".$remark_get;
		
		$system_note_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$tr_status_set." </div></div>".$system_note_get;
		
		$merchant_note_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$tr_status_set." </div></div>".$merchant_note_get;
		
		@$updt_defulat_status .= $remark_fld."='{$remark_upd}' "; 
		
		
		if($value['acquirer']==2||$value['acquirer']==3||$value['acquirer']==4){
			$updt_defulat_status .= ",`trans_response`='{$trans_response}' ";
		}
		
		
		if($uid>0 && $status_email==412){ //reminder by Merchant
		  $updt_defulat_status = " `mer_note`='".$merchant_note_upd."' ";
		  $master_update_default ='';
		}
		elseif($status_email==611){
			$updt_defulat_status = " `system_note`='".$system_note_upd."' ";
			$master_update_default = " `transaction_flag`='1' ";
		}
		elseif($status_email==612||$status_email==712){
			$updt_defulat_status = " `system_note`='".$system_note_upd."' ";
			$master_update_default = " `transaction_flag`='2' ";
		}
		elseif($status_email==512){$updt_defulat_status = " `support_note`='".$remark_upd."' ";}
		
		
	//as per request connection if multiple 
	if(isset($is_multiple_cross_db)&&$is_multiple_cross_db==1) {
		config_db_more_connection(@$DBCON,@$dbad,@$dbmt);
		sleep(1);
	}
		
	
		
		// updt_defulat_status is additional_update and 
		$additional_update=$master_update=$updt_defulat_status;
			
		if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'){
			$master_update='';
			$additional_update=trim($additional_update);
			$additional_update=ltrim($additional_update,',');
			$additional_update=rtrim($additional_update,',');
			db_query("UPDATE `{$data['DbPrefix']}{$data['ASSIGN_MASTER_TRANS_ADDITIONAL']}` SET ".$additional_update." WHERE `id_ad`='".$tr_id."' ",0); 
		}
		
			
		if($update_tr&&($master_update_default||$master_update)){
			$master_update_set=$master_update_default.$master_update;
			$master_update_set=trim($master_update_set);
			$master_update_set=rtrim($master_update_set,',');
			$master_update_set=ltrim($master_update_set,',');
			
			db_query(
				"UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
				" SET ".$master_update_set.
				" WHERE `id`='{$tr_id}'",0
			);
		}
		
		
		if($status==512||$status==513||$status==611||$status==612||$status==412||$status==712||$status==8||(isset($type_get)&&$type_get==2&&isset($status_get)&&$status_get==13)){
			$calculation_tr_fee_upd=false;
		}
	
	
	/*
	echo "<hr/>now =>".$now;	
		echo "<hr/>calculation_tr_fee_upd =>".$calculation_tr_fee_upd;
	echo "<hr/>status =>".$status;
	echo "<hr/>tr_id =>".$tr_id;
	echo "<hr/>trange=>".$trange; 
	echo "<hr/>update_tr=>".$update_tr; 
	print_r($tresult);
	echo "<hr/>wheres =>".$wheres;
	exit;
	*/
		
		if($value['acquirer']==3&&$status==2){
			$calculation_tr_fee_upd=true;
		}
	
	
	//as per request connection for default - latest 
	if(isset($data['DB_CON'])&&isset($data['DBCON_DEFAULT'])&&trim($data['DBCON_DEFAULT'])&&function_exists('config_db_more_connection')&&isset($DBCON_DEFAULT)&&isset($is_multiple_cross_db)&&$is_multiple_cross_db==1) 
	{
		config_db_more_connection(@$DBCON_DEFAULT,@$dbad_default,@$dbmt_default);
		sleep(1);
	}
		
	


		if(isset($calculation_tr_fee_upd)&&$calculation_tr_fee_upd==true){
			
			
			calculation_trans_fee($tr_id,"",false,"",$cpost);
		}
		
		
	//email 
	  if(empty($json_value)){
		if($tresult){
			$clients_info 		= select_client_table($value['merID']);
			$terminal_info 		= select_terminal_details($value['terNO'],$value['merID']);
			$prompt_msg_post	= "";
			
			
			$curr=$value['bill_currency'];
			$curr_sys=get_currency($curr);
			$curr_name=get_currency($curr,1);
			
			
			//transaction currency detail
			$curr_trans			=$value['trans_currency'];
			if($curr_trans)
			{
				$curr_sys_trans	=get_currency($curr_trans);
				$curr_name_trans=get_currency($curr_trans,1);
			}
			else
			{
				$curr_sys_trans	=get_currency($curr);
				$curr_name_trans=get_currency($curr,1);
			}
			if(isset($promptmsg)&&$promptmsg){$prompt_msg=explode('Reason:',$promptmsg);$prompt_msg_post=@$prompt_msg[1];}
			
			$post['email_header']="Self";
			
			$post['product_name']=$value['product_name'];
			$post['transID']=$value['transID'];
			
			//Dev Tech : 23-06-01 bug fix for macth the trans currency 
			$post['bill_amt_currency']=$post['amount_currency']=$order_bill_amt." ".$curr_name_trans;		//order bill_amt with curr
			//$post['bill_amt_currency']=$order_bill_amt." ".$curr_name;		//order bill_amt with curr
		
			
			$post['trans_bill_amt_curr']=$order_bill_amt." ".$curr_name_trans; //transaction bill_amt with curr
			if($value['bank_processing_amount']){
				$curr_name_proc=get_currency($value['bank_processing_curr'],1);
				$post['bill_amt_currency']=$order_bill_amt." ".$curr_name." - (".$value['bank_processing_amount']." ".$curr_name_proc.")";
				$post['trans_bill_amt_curr']=$order_bill_amt." ".$curr_name_trans." - (".$value['bank_processing_amount']." ".$curr_name_proc.")";
			}
			$post['currency_bill_amt']=$curr_sys_trans."".$order_bill_amt." "." ";
			$post['customer_name']=$value['fullname']." ";
			
			$post['customer_email']=$value['bill_email'];
			$post['customer_phone']=$value['bill_phone']." ";
			
			$post['tdate']=date('l jS F, Y', strtotime($value['tdate']));
			$post['current_date']=date('l jS F, Y');
			
			$post['descriptor']=$value['descriptor']." ";

					
			$post['mop']=$value['mop']." ";
			$ccno_de="";
			if(trim($value['ccno'])){$ccno_de=card_decrypts256($value['ccno']);}
			$post['card_no']=$ccno_de." ";
						
			$post['disputed_reason']=$prompt_msg_post." ";
			
			$post['merchant_service_no']=@$terminal_info['customer_service_no']." ";
			
			
			$post['contact_us_url']=@$terminal_info['merchant_contact_us_url']." ";
			$post['bussiness_url']=@$terminal_info['bussiness_url']." ";
			$post['dba']=@$terminal_info['dba_brand_name']." ";
			
		
			$post['emailadr']=(@$terminal_info['customer_service_email']?encrypts_decrypts_emails(@$terminal_info['customer_service_email'],2):" ");
			if(!trim($post['emailadr'])){
				$post['emailadr']=encrypts_decrypts_emails(@$clients_info['registered_email'],2);
			}
			
			/*
			echo '<br/><br/>emailadr=>'.$post['emailadr'];
			echo '<br/><br/>registered_email=>'.$clients_info['registered_email']; 
			echo '<br/><br/>customer_service_email=>'.$terminal_info['customer_service_email']; 
			exit;
			*/
	
			if(!trim($post['dba']))
			{
				if(isset($terminal_info['name'])&&$terminal_info['name']) 
					$post['dba']=$terminal_info['name']." ";
				elseif(isset($clients_info['company_name'])&&$clients_info['company_name'])
					$post['dba']=$clients_info['company_name']." ";
			}
			if(isset($clients_info['fullname'])&&$clients_info['fullname'])	//if fullname exist then use fullname
				$post['merchant_name']=$clients_info['fullname'];
			else	//if fullname not exists then concat fname and lname
			$post['merchant_name']=$clients_info['fname']." ".$clients_info['lname'];
			
			if(@$terminal_info['customer_service_email']&&@$terminal_info['customer_service_no']){
				$customer_emailadr_and_service_no=encrypts_decrypts_emails(@$terminal_info['customer_service_email'],2).' / '.@$terminal_info['customer_service_no'];
			}else{
				$customer_emailadr_and_service_no=$post['emailadr'];
			}
			$post['customer_emailadr_and_service_no']=$customer_emailadr_and_service_no;
		
		
			if(isset($terminal_info['bussiness_url'])&&trim($terminal_info['bussiness_url'])&&trim($value['descriptor'])){
				$bussiness_url_descriptor=@$terminal_info['bussiness_url'].' - ('.$value['descriptor'].')';
			}elseif(trim($value['descriptor'])){
				$bussiness_url_descriptor=$value['descriptor'];
			}else{
				$bussiness_url_descriptor=@$terminal_info['bussiness_url'];
			}
			$post['bussiness_url_descriptor']=$bussiness_url_descriptor;
		
		
		}
		
		
		$post['merID']=$post['clientid']=$value['merID'];
		$post['tableid']=$tr_id;
		switch($status_email){
			case 3: //Refunded to Merchant and Customer
				
				$array_3_mer[]=["n"=>"Customer Name","v"=>$post['customer_name']]; 
				$array_3_mer[]=["n"=>"Customer’s E-Mail","v"=>$post['customer_email']]; 
				$array_3_mer[]=["n"=>"Customer’s Phone No.","v"=>$post['customer_phone']]; 
				$array_3_mer[]=["n"=>"Refund Amount","v"=>$post['trans_bill_amt_curr']]; 	//change order currency to transaction currency on 
				$array_3_mer[]=["n"=>"Refund Reason","v"=>$post['disputed_reason']]; 
				$post['ctable1']=c_table($array_3_mer,'100%');
				
				$post['email']=$post['emailadr'];
				send_email('MERCHANT-EMAIL-TRANSACTIONS-REFUND', $post);
				
				$array_3_cust[]=["n"=>"Order Reference No.","v"=>$post['transID']]; 
				$array_3_cust[]=["n"=>"Payment method","v"=>$post['mop']]; 
				$array_3_cust[]=["n"=>"Order date","v"=>$post['tdate']]; 
				$array_3_cust[]=["n"=>"Refund date","v"=>$post['current_date']]; 
				$array_3_cust[]=["n"=>"Refund Amount","v"=>$post['trans_bill_amt_curr']];  	//change order currency to transaction currency on 
				$post['ctable2']=c_table($array_3_cust,'100%');
				$post['email']=$post['customer_email'];
				send_email('CUSTOMER-EMAIL-TRANSACTIONS-REFUNDED', $post);
			break;
			case 12: // Partial Refund to Merchant and Customer
				$post['email']=$post['emailadr'];
				send_email('MERCHANT-EMAIL-TRANSACTIONS-REFUND', $post);
				$post['email']=$post['customer_email'];
				send_email('CUSTOMER-EMAIL-TRANSACTIONS-REFUNDED', $post);
			break;
			case 5: //Chargeback    
				$array_5[]=["n"=>"Customer Name","v"=>$post['customer_name']]; 
				$array_5[]=["n"=>"Customer’s E-Mail","v"=>$post['customer_email']]; 
				$array_5[]=["n"=>"Customer’s Phone No.","v"=>$post['customer_phone']]; 
				$array_5[]=["n"=>"Disputed Amount","v"=>$post['trans_bill_amt_curr']];  	//change order currency to transaction currency on 
				$array_5[]=["n"=>"Disputed Reason","v"=>$post['disputed_reason']]; 
				$post['ctable1']=c_table($array_5,'100%');
				
				$post['email']=$post['emailadr'];
				if(isset($_GET['email_confirm'])){
					send_email('MERCHANT-EMAIL-TRANSACTIONS-CHARGEBACK-RECEIVED', $post);
				}
			break;
			case 6: //Returned 
				
				$array_6[]=["n"=>"Customer Name","v"=>$post['customer_name']]; 
				$array_6[]=["n"=>"Customer’s E-Mail","v"=>$post['customer_email']]; 
				$array_6[]=["n"=>"Customer’s Phone No.","v"=>$post['customer_phone']]; 
				$array_6[]=["n"=>"Transaction Amount","v"=>$post['trans_bill_amt_curr']]; 	//change order currency to transaction currency on 
				$array_6[]=["n"=>"Return Reason","v"=>$post['disputed_reason']]; 
				$post['ctable1']=c_table($array_6,'100%');
				
				$post['email']=$post['emailadr'];
				if(isset($_GET['email_confirm'])){
					send_email('MERCHANT-EMAIL-TRANSACTIONS-RETURN', $post);
				}
			break;
			case 712: //Authorization
				//$post['email']=email_first_letter_remove($post['customer_email']);
				$array_712[]=["n"=>"Name","v"=>$post['customer_name']]; 
				$array_712[]=["n"=>"Transaction Date","v"=>$post['tdate']]; 
				$array_712[]=["n"=>"Payment Source","v"=>$post['mop'].$post['card_no']]; 
				$array_712[]=["n"=>"Transaction Descriptor","v"=>$post['descriptor']]; 
				$array_712[]=["n"=>"Transaction Amount","v"=>$post['trans_bill_amt_curr']]; 	//change order currency to transaction currency on 
				$array_712[]=["c"=>"<a href='{$post['bussiness_url']}' style='text-decoration:none;color:#0047af;'>Merchant Contact Information</a>"]; 
				$array_712[]=["n"=>"Merchant Phone No.","v"=>$post['merchant_service_no']];
				$array_712[]=["n"=>"Merchant Email","v"=>$post['emailadr']];
				$post['ctable1']=c_table($array_712,'80%');
				
				$post['email']=$post['customer_email'];
				send_email('MERCHANT-EMAIL-AUTHORIZATION-REQUIRED', $post);
			break;
			case 11: //CBK1
				
				$array_11[]=["n"=>"Customer Name","v"=>$post['customer_name']]; 
				$array_11[]=["n"=>"Customer’s E-Mail","v"=>$post['customer_email']]; 
				$array_11[]=["n"=>"Customer’s Phone No.","v"=>$post['customer_phone']]; 
				$array_11[]=["n"=>"Transaction Amount","v"=>$post['trans_bill_amt_curr']]; 	//change order currency to transaction currency on  
				$post['ctable1']=c_table($array_11,'100%');
				
				$post['email']=$post['emailadr'];
				if(isset($_GET['email_confirm'])){
					send_email('MERCHANT-EMAIL-TRANSACTIONS-CBK1', $post);
				}
			break;
			case 512: //reminder
				$array_512[]=["c"=>"<a style='color:#668cff;font-size:20px;display:block;width:100%;padding:5px 0 15px 0;'>Your Order Details</a>"];
				$array_512[]=["n"=>"Order Date","v"=>$post['tdate']]; 
				$array_512[]=["n"=>"Order Reference No.","v"=>$post['transID']]; 
				$array_512[]=["n"=>"Order Amount","v"=>$post['mop'].$post['currency_bill_amt']]; 
				
				$array_512[]=["c"=>"<a href='{$post['bussiness_url']}' style='color:#668cff;font-size:20px;display:block;width:100%;padding:5px 0 15px 0;'>Merchant Contact Information</a>"]; 
				$array_512[]=["n"=>"Merchant Phone No.","v"=>$post['merchant_service_no']];
				$array_512[]=["n"=>"Merchant Email","v"=>$post['emailadr']];
				$post['ctable1']=c_table($array_512,'100%');
				
				$post['email']=$post['customer_email'];
				send_email('MERCHANT-EMAIL-TRANSACTIONS-REMINDER', $post);
			break;
			case 412: //reminder by Merchant
				$array_512[]=["c"=>"<a style='color:#668cff;font-size:20px;display:block;width:100%;padding:5px 0 15px 0;'>Order Details:</a>"];
				$array_512[]=["n"=>"Order Date","v"=>$post['tdate']]; 
				$array_512[]=["n"=>"Order Reference No.","v"=>$post['transID']]; 
				$array_512[]=["n"=>"Order Amount","v"=>$post['mop'].$post['currency_bill_amt']]; 
				
				$array_512[]=["c"=>"<a href='{$post['bussiness_url']}' style='color:#668cff;font-size:20px;display:block;width:100%;padding:5px 0 15px 0;'>Support Information</a>"]; 
				//$array_512[]=["n"=>"Merchant Phone No.","v"=>$post['merchant_service_no']];
				//$array_512[]=["n"=>"Merchant Email","v"=>$post['emailadr']];
				$post['ctable1']=c_table($array_512,'100%');
				$post['email']=$post['customer_email'];
				send_email('MERCHANT-EMAIL-TRANSACTIONS-REMINDER', $post);
			break;
			case 513: //action_require
				$post['email']=$post['emailadr'];
				send_email('MERCHANT-EMAIL-TRANSACTIONS-CARD-ACTION-REQUIRE', $post);
			break;
		}
		
		
		if($status_email==3||$status_email==5||$status_email==6||$status_email==11||$status_email==12){
			$webhook_url = "{$data['Host']}/fetch_trnsStatus{$data['ex']}?bid={$tr_id}&notify=1";
			//header("location:$webhook_url");
		}
	  }
	}
	return $result;
}

//Calculate all types trans fee / rate. 
function calculation_trans_fee($trange,$uids=0,$all=false,$pdate='',$cpost=''){
	global $data; $wheres = ""; $all_id=""; $qp=$data['cqp'];
	$sortmode=" DESC ";
	//echo "<hr/>trange:".$trange;echo "<hr/>uids:".$uids;echo "<hr/>all:".$all;echo "<hr/>";
	if($qp) echo "<hr/><==fun calculation_trans_fee=><br/>";

	$any_completed=false;
	
	//Dev Tech : 23-11-27 fix bug 
	
	/*
	if($uids>0){
		$wheres .= " ( `merID`='{$uids}' ) AND ";
	
		//check any success transaction available or not of a clients
		$completed_tr=db_rows(
			"SELECT `trans_status` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" WHERE ( `merID`='{$uids}' ) AND ( `trans_status`=1 ) ".
			" ORDER BY `id` DESC LIMIT 1"//,true
		);

		if($completed_tr){
			$any_completed=true;		//if found row then at $any_completed yes
		}
	}
	
	*/
	
	if(!empty($trange)){
		$wheres .= " `id` IN ($trange) ";	//create query' condition
	}

	//if calculate all, then clients's available_balance and available_rolling set zero
	if($all){
		$sortmode=" ASC ";
		$wheres = " ( `merID`='{$uids}' ) ";
		db_query(
			"UPDATE `{$data['DbPrefix']}payin_setting`".
			" SET `available_balance`='0', `available_rolling`='0' ".
			" WHERE `clientid`='{$uids}'",$qp
		);
		
		//exit;
	}
	
	
	if($pdate){
		$payoutdays=14;	//default payout days 14
		$type_whr="";$trans_status_2_whr="";$type_ch="";
		
		
		$type_whr=" (`trans_type` IN (11)) AND ";
		$trans_status_2_whr="";
		
		$pdate		= date('Y-m-d',strtotime($pdate));	//payout date
		$frmpdate	= date("Y-m-d",strtotime("-$payoutdays day",strtotime($pdate)));	//from date - 14 or 16 days before payout date
		$topdate	= date("Y-m-d",strtotime("+7 day",strtotime($frmpdate)));	//to payout date, 7 days later to from date
		$topdate_rtn= date("Y-m-d",strtotime("+7 day",strtotime($topdate)));	//to payout date ret, 14 days later to from date

		//make query
		$wheres		= $type_whr." (`merID`='{$uids}') AND ((tdate between '".$frmpdate."' AND '".$topdate."' AND (`trans_status` IN (1".$trans_status_2_whr.",4,7,14))) OR (tdate between '".$topdate."' AND '".$topdate_rtn."' AND (`trans_status` IN (3,5,6,11,12)))) ";
		
	}
	
	//Select Data from master_trans_additional
	//$join_additional=join_additional();
		
		
	//fetch data from transactions table
	$select_transactions=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
		"  WHERE ".$wheres.
		" ORDER BY `id` {$sortmode}",$qp
	);
	
	

	$post['select_transactions']=$select_transactions;	//store all transactions into $post array
	
	//echo "<br/>select_transactions=>";print_r($select_transactions); 
	
	//exit;
	
	//-------------------------------------------------------------	

	//$clients_list=get_all_clients_new();	//retrive all clients data 
	
	$postionNo = '';
	$i=1;
	foreach($post['select_transactions'] as $key=>$value){		//execute all trans row by row
		if($value){
			//-------------------------------------------------------
		
			$uid=$value['merID'];
			
			
			
			
			$tdate=date('Ymd',strtotime($value['tdate']));
			$cdate=date('Ymd');
			
			
			
			//Fetch json_value, system_note 
			if(($value['trans_status']==2&&$value['trans_type']==19)||(trim($value['reference'])=='')||($tdate!=$cdate)||((isset($json_value['ar_tdate'])&&$json_value['ar_tdate'])||(isset($_REQUEST['tdateSkip'])))){
				$json_value_find=1;
			}
			else $json_value_find=0;

			
			//Get 
			if($json_value_find==1){
				if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'){
					$maTransAd=select_tablef("`id_ad` IN ({$value['id']})",$data['ASSIGN_MASTER_TRANS_ADDITIONAL'],0,1,'`json_value`,`system_note`,`support_note`');
					$json_value=jsondecode($maTransAd['json_value'],true);	//json to array
					
					$value['system_note']=$maTransAd['system_note'];
				}
				else
				$json_value=jsondecode($value['json_value'],true);	//json to array
			}
			else $json_value=[];
			
			
			
			
			if($value['related_transID']){
				$related_transID=jsondecode($value['related_transID'],true);
			}else{
				$related_transID=array();
			}
			
			
			$update_query=""; $update_query_add=""; $update_clients_query="";
			
			// Dev Tech : 23-09-29 default currency fetch first from trans_currency is empty than fetch from clients's default currency 
			if(trim($value['trans_currency'])){
				$default_currency = trim($value['trans_currency']);	//fetch trans_currency for default currency
			}
			else {
				
				// fetch from clients's default currency 
				$default_currency_from_clientid=select_tablef("`id` IN ({$uid})",'clientid_table',0,1,'`default_currency`');
				
				$default_currency = trim($default_currency_from_clientid['default_currency']);	//clients's default currency
			}
			
			
			
			//Dev Tech : 23-09-29 start - fetch last available balance , available_rolling
			
			$prev_trans_bal_rol=available_balance_and_rolling($value['id'],$value['tdate'],$uid);
			
			$last_available_balance=number_formatf2($prev_trans_bal_rol['current_available_balance']);	// available balance
			$last_available_rolling=number_formatf2($prev_trans_bal_rol['current_available_rolling']);	// available rolling
			
			
			if($value['acquirer']==4){
				
				//received fund fetch via reference
			
				$prev_receiver_trans_bal_rol=available_balance_and_rolling($value['id'],$value['tdate'],$value['reference']);
				
				$last_available_balance_merID=number_formatf2($prev_receiver_trans_bal_rol['current_available_balance']);	// received available balance
				$last_available_rolling_merID=number_formatf2($prev_receiver_trans_bal_rol['current_available_rolling']);	// received available rolling

			}
			
			
			
			//fetch acquirer detail
			$merchant_setting=db_rows(
				"SELECT * FROM `{$data['DbPrefix']}mer_setting`".
				" WHERE `merID`='{$uid}' AND `acquirer_id`='".$value['acquirer']."' ".
				" LIMIT 1",$qp
			);
			
			$accounts=[];
			if($merchant_setting)
			{
				$accounts=$merchant_setting[0];
			}else{
				//if no data found in acquirer then fetch from bank_gateway table
				$acqTbl=select_tablef("`acquirer_id` IN ({$value['acquirer']})",'acquirer_table',0,1,'`mer_setting_json`');
				
				if(isset($acqTbl['mer_setting_json'])&&$acqTbl['mer_setting_json'])  $accounts=jsondecode($acqTbl['mer_setting_json'],1);
				
				//$accounts=$accounts_get[0];
			}
			//------------------------------------------------------
			
			
			if((isset($accounts['mdr_visa_rate']))&&(isset($value['mop']))&&$value['mop']=='visa'&&$accounts['mdr_visa_rate']){
				$mdr_rate=stringToNumber($accounts['mdr_visa_rate']);	//mdr for visa card
			}elseif((isset($accounts['mdr_mc_rate']))&&(isset($value['mop']))&&$value['mop']=='mastercard'&&$accounts['mdr_mc_rate']){
				$mdr_rate=$accounts['mdr_mc_rate'];	//mdr for master card
			}elseif((isset($accounts['mdr_amex_rate']))&&(isset($value['mop']))&&$value['mop']=='amex'&&$accounts['mdr_amex_rate']){
				$mdr_rate=$accounts['mdr_amex_rate'];		//mdr for amex
			}elseif((isset($accounts['mdr_jcb_rate']))&&(isset($value['mop']))&&$value['mop']=='jcb'&&$accounts['mdr_jcb_rate']){
				$mdr_rate=stringToNumber($accounts['mdr_jcb_rate']);		//mdr for jcb
			}else{
				$mdr_rate=stringToNumber(@$accounts['mdr_rate']);	//default mdr
			}
			
			
			//Dev Tech : 23-11-28 Bug fix 
			//total success count for fee 
			
			if(@$accounts['txn_fee_failed'])		
				$txn_fee_success_or_failed=@$accounts['txn_fee_failed'];	//failed transaction fee
			else $txn_fee_success_or_failed=@$accounts['txn_fee_success'];		//trans fee
			
			$txn_fee_success_or_failed=number_formatf2($txn_fee_success_or_failed);
					
			if($data['con_name']=='clk'){
				$trans_count=11;
			}elseif($value['acquirer']!=4&&(	(($value['trans_status']==2)&&($value['trans_type']==11)&&($cpost)&&($cpost['trans_status']==1)) || (($value['trans_status']==2)&&($value['trans_type']==11)&&(empty($cpost))) )&&$txn_fee_success_or_failed>0)
			{
				$trans_counts=db_rows(
					"SELECT COUNT(*) as `count` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
					" WHERE (`merID`='{$uid}') AND (`trans_status`=1) AND (`trans_type` IN (11)) ".
					" LIMIT 1",$qp
				);
				$trans_count=@$trans_counts[0]['count'];
			}
			else $trans_count=0;
			
			$trans_count_no=10;
			
			
			//-------------------------------------------------------
			if($data['con_name']=='clk'){
				$ratio=[];	//fetch charge fee
				$post['total_lead']='';
				$total_ratio='';
				$risk_type='';
			}
			else {
				$ratio=get_riskratio_trans($uid,$value['acquirer']);	//fetch charge fee
				//$ratio=riskratio($uid,'',true,'',$value['acquirer']);
				//$ratio=riskratio($uid,$value['acquirer']);
				$post['total_lead']=$ratio['total_ratio'];
				$total_ratio=$ratio['total_ratio'];
				$charge_back_fee=stringToNumber($ratio['charge_back_fee']);	//remove non-numeric chars
				$risk_type=$ratio['risk_type'];
				// Risk Ratio			risk_ratio_check 
				// Chargeback Ratio		chargeback_ratio_card
			}
			
			///currency name
			if($value['bill_currency']){
				if(strpos($value['bill_currency']," ")!==false){
					$curr_ex=explode(' ',$value['bill_currency']); 
					$currency_from=$curr_ex[1];
				}else{
					$currency_from=$value['bill_currency'];
				}
			}
			
			if(trim($value['trans_currency'])) $trans_currency=trim($value['trans_currency']);
			else $trans_currency=$default_currency;
			
			if(trim($currency_from)==trim($trans_currency)){
				$bill_amt_converted = $value['bill_amt'];	//default currency and trans currency are same, then execute order bill_amt
			}else{
				if($value['trans_status']==3||$value['trans_status']==5||$value['trans_status']==6||$value['trans_status']==12||$value['trans_status']==11)
					$bill_amt_converted = $value['trans_amt'];	
				else
					$bill_amt_converted = currencyConverter($currency_from,$trans_currency,$value['bill_amt']);		//convert ammount
			}
			
			//$bill_amt_converted = $value['bill_amt'];
			//-------------------------------------------------------
				
			$bill_amt_converted = stringToNumber($bill_amt_converted);	//use as a numeric
			//if((empty($value['trans_amt']))||(!empty($pdate))){$amt_cond=true;}else{$amt_cond=false;}
			
			
			$payout_current_date = date('Y-m-d H:i:s');	//today payout date
			$payout_date_after_reverse =", `settelement_date`='{$payout_current_date}' ";	//for query

			
			if(($value['trans_status']==1||$value['trans_status']==4||$value['trans_status']==7)&&($value['trans_type']!=15&&$value['trans_type']!=16)){ // completed and isnot withdraw
				//call function gw_for calculate mdr bill_amt - added  on 12-10
				$dis_rate	= calculate_mdr_amount($bill_amt_converted, $accounts, $value['mop']);
				//$dis_rate	= ($bill_amt_converted/100)*$mdr_rate;	
				$rol_fee	= ($bill_amt_converted/100)*stringToNumber($accounts['reserve_rate']);
				
				if(isset($data['con_name'])&&$data['con_name']=='clk'&&isset($accounts['gst_rate'])&&$accounts['gst_rate']){
					
					$gst_fee_cal = (($dis_rate/100)*stringToNumber($accounts['gst_rate'])); //calc gst fee
					$gst_amt = number_formatf2($gst_fee_cal,4);	//defined number format
					$gst_fee_set=", `gst_amt`='".$gst_amt."' ";	//for query
					
				}else{
					
					$gst_fee_set="";
					$gst_amt=0;
				}
				
				//calculate total fee
				$this_fee_total	= ($dis_rate+$accounts['txn_fee_success']+$rol_fee+$gst_amt);

				$trans_amt=number_formatf($bill_amt_converted); //trans amt in defined number format
				
				$payable_amt_of_txn=number_formatf2(($bill_amt_converted)-number_formatf($this_fee_total));		//calculate payable transaction amt
				
				// Y : Skip the available balance and rolling check for update fee
				if(isset($data['SKIP_AVAILABLE_BALANCE_AND_ROLLING'])&&$data['SKIP_AVAILABLE_BALANCE_AND_ROLLING']=='Y'){
					$available_balance=0;	//available balance
					$available_rolling=0;	//available rolling
				}
				else 
				{
					$available_balance=number_formatf2($last_available_balance+$payable_amt_of_txn);	//available balance
					$available_rolling=number_formatf2($last_available_rolling+$rol_fee);	//available rolling
				}
				
				
				
				//paymentflow: update related_transID for success by admin or cron or manually
				if( ($json_value_find==1)&&trim($value['reference'])==''&&isset($json_value['re_post']) && isset($json_value['post']['id_order'])){
					if($json_value['post']['id_order']){
						$id_order_upd = ", `reference`='".$json_value['post']['id_order']."' ";
					}
					
				}else{
					$id_order_upd='';
				}
				
				//echo "<br/>id_order_upd=>".$id_order_upd; 
				
				
				$settelement_period_get=(int)$value['settelement_delay'];	//settelement period
				$payout_date_get = date('Y-m-d H:i:s', strtotime('+'.$settelement_period_get.' days'));
				$payout_date_set =", `settelement_date`='{$payout_date_get}' ";	//for query
				
				if(!trim($value['trans_currency']))
					$trans_currency_set =", `trans_currency`='{$trans_currency}' ";	//for query
				else $trans_currency_set ='';
					
				//query
				$update_query .=" `trans_amt`='".$trans_amt."',`buy_mdr_amt`='".$dis_rate."', `buy_txnfee_amt`='".$accounts['txn_fee_success']."', `rolling_amt`='".$rol_fee."', `mdr_cb_amt`='0', `mdr_cbk1_amt`='0', `mdr_refundfee_amt`='0', `payable_amt_of_txn`='".$payable_amt_of_txn."', `available_balance`='".$available_balance."', `available_rolling`='".$available_rolling."', `risk_ratio`='".$total_ratio."' ".$gst_fee_set.$id_order_upd.$payout_date_set.$trans_currency_set;
				
				
				
				$update_clients_query.="`available_balance`='".$available_balance."', `available_rolling`='".$available_rolling."' ";	//for query
				
				$all_id.=$value['id'].",";
				$postionNo.="postionNo=>1=>s".$value['trans_status'];
			}
			elseif(($value['trans_status']==5)){ // Chargeback 

				$rol_fee	= ($bill_amt_converted/100)*$charge_back_fee;	//chargeback fee
				
				
				$trans_amt=stringToNumber($bill_amt_converted);
				$payable_amt_of_txn=-(number_formatf2(($trans_amt)+ ($charge_back_fee) + stringToNumber($value['rolling_amt'])));		//calculate payable transaction amt
				
				$available_balance=$last_available_balance+($payable_amt_of_txn);	//available balance
				
				$available_rolling=($last_available_rolling - number_formatf($rol_fee));	//available rolling
				
				
				//update query
				$update_query .=" `bill_amt`='-".$value['bill_amt']."',`trans_amt`='-".$trans_amt."',`buy_mdr_amt`='0', `buy_txnfee_amt`='0', `rolling_amt`='-".$value['rolling_amt']."', `mdr_cb_amt`='-".$charge_back_fee."', `mdr_cbk1_amt`='0', `mdr_refundfee_amt`='0', `payable_amt_of_txn`='".$payable_amt_of_txn."', `available_balance`='".$available_balance."', `available_rolling`='".$available_rolling."', `risk_ratio`='".$total_ratio."' ".$payout_date_after_reverse;
				
				$update_clients_query.="`available_balance`='".$available_balance."', `available_rolling`='".$available_rolling."' ";
				$all_id.=$value['id'].","; 
				$postionNo.="postionNo=>2=>s".$value['trans_status'];
			}
			elseif(($value['trans_status']==6)){ // Returned 

				$rol_fee	= ($bill_amt_converted/100)*$charge_back_fee;	//chargeback fee
				
				
				$trans_amt=number_formatf($bill_amt_converted);
				$payable_amt_of_txn=-(number_formatf2($trans_amt+number_formatf($charge_back_fee) + number_formatf($value['rolling_amt'])));		//calculate payable transaction amt
				
				$available_balance=$last_available_balance+($payable_amt_of_txn);	//available balance
				
				$available_rolling=($last_available_rolling - number_formatf($rol_fee));	//available rolling

				//update query
				$update_query .=" `bill_amt`='-".$value['bill_amt']."',`trans_amt`='-".$trans_amt."',`buy_mdr_amt`='0', `buy_txnfee_amt`='0', `rolling_amt`='-".$value['rolling_amt']."', `mdr_cb_amt`='0', `mdr_cbk1_amt`='0', `mdr_refundfee_amt`='-".$charge_back_fee."', `payable_amt_of_txn`='".$payable_amt_of_txn."', `available_balance`='".$available_balance."', `available_rolling`='".$available_rolling."', `risk_ratio`='".$total_ratio."' ".$payout_date_after_reverse;
				
				$update_clients_query.="`available_balance`='".$available_balance."', `available_rolling`='".$available_rolling."' ";
				$all_id.=$value['id'].","; 
				$postionNo.="postionNo=>3=>s".$value['trans_status'];
			}
			
			elseif(($value['trans_status']==2)&&($value['trans_type']==15)){
				// cancelled in withdraw
				
				//$txn_fee_success=number_formatf($value['fees']);		//transaction fee
				
				$return_bill_amt=str_replace("-","",$value['bill_amt']);	//total return bill_amt
							
				$available_balance=$last_available_balance+($return_bill_amt);	//available balance
				
				//update query
				$update_query .=" `trans_amt`='{$value['bill_amt']}',`trans_currency`='{$value['bill_currency']}', `buy_mdr_amt`='0', `buy_txnfee_amt`='0', `rolling_amt`='0', `mdr_cb_amt`='0', `mdr_cbk1_amt`='0', `mdr_refundfee_amt`='0', `payable_amt_of_txn`='0', `available_balance`='".$available_balance."', `risk_ratio`='".$total_ratio."'"; 
				
				$update_clients_query.="`available_balance`='".$available_balance."' ";
				$all_id.=$value['id'].",";
				
				
				$postionNo.="postionNo=>4=>s".$value['trans_status'];
				
				
			}elseif(($value['trans_status']==2)&&($value['trans_type']==19)){ // Cancelled manually in Fund 
				
				$trans_amt=str_replace("-","",$value['trans_amt']);	//transaction bill_amt	
				
				$bill_amt=str_replace("-","",$value['bill_amt']);		//order bill_amt
				
				$trans_amt=number_formatf($bill_amt_converted);	//transaction bill_amt
				
				
				$available_balance_sender=$last_available_balance+$bill_amt;	//sender' available balance
				
				$available_balance_merID=$last_available_balance_merID-$bill_amt;	//merID' available balance
				
				$json_value['merID_last_available_balance']=$available_balance_merID;	//merID' available balance for json
				
				$json_value_enc=json_encode($json_value);	//json encode
				
				// query update for master_trans_additional
				$update_query_add.=$update_query_mas=", `json_value`='{$json_value_enc}'  ";
				
				if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'){
					$update_query_mas='';
				}
				
				//update query
				$update_query .=" `bill_amt`='".$bill_amt."',`trans_amt`='".$trans_amt."', `buy_mdr_amt`='0', `buy_txnfee_amt`='0', `rolling_amt`='0', `mdr_cb_amt`='0', `mdr_cbk1_amt`='0', `mdr_refundfee_amt`='0', `payable_amt_of_txn`='0', `available_balance`='".$available_balance_sender."', `risk_ratio`='".$total_ratio."' ".$update_query_mas; 
				
				$update_clients_query.="`available_balance`='".$available_balance_sender."' ";
				
				$update_clients_query_merID.="`available_balance`='".$available_balance_merID."' ";

				$all_id.=$value['id'].",";

				$postionNo.="postionNo=>5=>s".$value['trans_status'];
				
			}
			elseif(($value['trans_status']==2)&&($value['trans_type']==11)&&($cpost)&&($cpost['trans_status']==1)){ // success to Cancelled manually in card and check 
				
				
				if($trans_count>$trans_count_no){	
					if($accounts['txn_fee_failed']){
						$txn_fee_success=$accounts['txn_fee_failed'];	//failed transaction fee
					}else{
						$txn_fee_success='0.00';			//trans fee
						//$txn_fee_success=$accounts['txn_fee_success'];			//trans fee
					}
				}else{
					$txn_fee_success="0.00";
				}
				
				
				$trans_amt=number_formatf($bill_amt_converted);	//transaction bill_amt
				
				$payable_amt_of_txn=number_formatf2($txn_fee_success);		//calculate payable transaction amt
				
				$available_balance=$last_available_balance-($value['payable_amt_of_txn']+$txn_fee_success);	//available balance
						

				//update query
				$update_query .=" `trans_amt`='0',`buy_mdr_amt`='0', `buy_txnfee_amt`='".$txn_fee_success."', `rolling_amt`='0', `mdr_cb_amt`='0', `mdr_cbk1_amt`='0', `mdr_refundfee_amt`='0', `payable_amt_of_txn`='-".$payable_amt_of_txn."', `available_balance`='".$available_balance."', `risk_ratio`='".$total_ratio."' "; 
				
				$update_clients_query.="`available_balance`='".$available_balance."' ";
				$all_id.=$value['id'].",";
				
				
				$postionNo.="postionNo=>6=>s".$value['trans_status'];
				
			}
			elseif(($value['trans_status']==2)&&($value['trans_type']==11)&&(empty($cpost))){ // Cancelled in card 
				
			
				
				if($trans_count>$trans_count_no){
					if($accounts['txn_fee_failed']){
						$txn_fee_success=$accounts['txn_fee_failed'];	//failed transaction fee
					}else{
						$txn_fee_success='0.00';	//transaction fee
						//$txn_fee_success=$accounts['txn_fee_success'];	//transaction fee
					}
				}else{
					$txn_fee_success="0.00";
				}
				
				$trans_amt=number_formatf($bill_amt_converted);	//transaction bill_amt
				
				
				$payable_amt_of_txn=number_formatf2($txn_fee_success);	//payable transaction bill_amt
				
				$available_balance=number_formatf2($last_available_balance-$txn_fee_success);	//available balance
				
				//update query
				$update_query .=" `trans_amt`='0',`buy_mdr_amt`='0', `buy_txnfee_amt`='".$txn_fee_success."', `rolling_amt`='0', `mdr_cb_amt`='0', `mdr_cbk1_amt`='0', `mdr_refundfee_amt`='0', `payable_amt_of_txn`='-".$payable_amt_of_txn."', `available_balance`='".$available_balance."', `risk_ratio`='".$total_ratio."' "; 
				
				$update_clients_query.="`available_balance`='".$available_balance."' ";
				$all_id.=$value['id'].",";
				
				$postionNo.="postionNo=>7=>s".$value['trans_status'];
				
				
			}
			elseif(($value['trans_status']==3) || ($value['trans_status']==12)){ // Refunded 

				$rol_fee	= ($bill_amt_converted/100)*$accounts['reserve_rate'];	//rolling fee
				
				
				$trans_amt=number_formatf($bill_amt_converted);	//transaction bill_amt
				$payable_amt_of_txn=-(number_formatf2(($trans_amt) + number_formatf($accounts['refund_fee']) + number_formatf($value['rolling_amt'])));	//calculate payable transaction amt
				
				$available_balance=number_formatf2($last_available_balance+($payable_amt_of_txn));	//available balance
				
				$available_rolling=($last_available_rolling - $rol_fee);	//available rolling

				//query for update
				$update_query .=" `bill_amt`='-".$value['bill_amt']."',`trans_amt`='-".$trans_amt."',`buy_mdr_amt`='0', `buy_txnfee_amt`='0', `rolling_amt`='-".$value['rolling_amt']."', `mdr_cb_amt`='0', `mdr_cbk1_amt`='0', `mdr_refundfee_amt`='-".$accounts['refund_fee']."', `payable_amt_of_txn`='".$payable_amt_of_txn."', `available_balance`='".$available_balance."', `available_rolling`='".$available_rolling."', `risk_ratio`='".$total_ratio."' ".$payout_date_after_reverse;
				
				$update_clients_query.="`available_balance`='".$available_balance."', `available_rolling`='".$available_rolling."' ";
				$all_id.=$value['id'].","; 
				
				$postionNo.="postionNo=>9=>s".$value['trans_status'];
			}
			elseif(($value['trans_status']==12)){ // Partial Refund 

				$rol_fee	= ($bill_amt_converted/100)*$accounts['reserve_rate'];	//rolling fee

				$trans_amt=number_formatf($bill_amt_converted);	//transaction bill_amt

				$payable_amt_of_txn=-(number_formatf2(($trans_amt)+ number_formatf($accounts['refund_fee']) + number_formatf($value['rolling_amt'])));	//calculate payable transaction amt
				
				$available_balance=number_formatf2($last_available_balance+($payable_amt_of_txn));	//available balance
				
				$available_rolling=($last_available_rolling - $rol_fee);	//available rolling
				
				//query for update
				$update_query .=" `bill_amt`='-".$value['bill_amt']."',`trans_amt`='-".$trans_amt."',`buy_mdr_amt`='0', `buy_txnfee_amt`='0', `rolling_amt`='-".$value['rolling_amt']."', `mdr_cb_amt`='0', `mdr_cbk1_amt`='0', `mdr_refundfee_amt`='-".$accounts['refund_fee']."', `payable_amt_of_txn`='".$payable_amt_of_txn."', `available_balance`='".$available_balance."', `available_rolling`='".$available_rolling."', `risk_ratio`='".$total_ratio."' ".$payout_date_after_reverse;
				
				$update_clients_query.="`available_balance`='".$available_balance."', `available_rolling`='".$available_rolling."' ";
				$all_id.=$value['id'].","; 
				
				$postionNo.="postionNo=>10=>s".$value['trans_status'];
			}
			elseif(($value['trans_status']==11)){ // CBK1 

				$rol_fee	= ($bill_amt_converted/100)*$accounts['reserve_rate'];	//rolling fee
				
				
				$trans_amt=number_formatf($bill_amt_converted);
				$payable_amt_of_txn=-(number_formatf2(($trans_amt)+number_formatf($accounts['cbk1']) + number_formatf($value['rolling_amt'])));	//calculate payable transaction amt
				
				$available_balance=number_formatf2($last_available_balance+($payable_amt_of_txn));	//available balance
				
				$available_rolling=($last_available_rolling - $rol_fee);	//available rolling
				
				//query for update
				$update_query .=" `bill_amt`='-".$value['bill_amt']."',`trans_amt`='-".$trans_amt."',`buy_mdr_amt`='0', `buy_txnfee_amt`='0', `rolling_amt`='-".$value['rolling_amt']."', `mdr_cb_amt`='0', `mdr_cbk1_amt`='-".$accounts['cbk1']."', `mdr_refundfee_amt`='0', `payable_amt_of_txn`='".$payable_amt_of_txn."', `available_balance`='".$available_balance."', `available_rolling`='".$available_rolling."', `risk_ratio`='".$total_ratio."' ".$payout_date_after_reverse;
				
				$update_clients_query.="`available_balance`='".$available_balance."', `available_rolling`='".$available_rolling."' ";
				$all_id.=$value['id'].","; 
				
				$postionNo.="postionNo=>11=>s".$value['trans_status'];
				
			}elseif(($value['trans_status']==13)){ // Withdraw Requested 
				
				
				$txn_fee_success=number_formatf($value['fees']);		//transaction fee
				
				$trans_amt=number_formatf($bill_amt_converted);	//transaction bill_amt
				$payable_amt_of_txn=-(number_formatf2(($trans_amt)+number_formatf($txn_fee_success)));	//calculate payable transaction amt
								
				$available_balance=number_formatf2($last_available_balance-(($trans_amt)+number_formatf($txn_fee_success)));	//Available balance

				//query for update
				$update_query .=" `trans_amt`='".$trans_amt."',`buy_mdr_amt`='0', `buy_txnfee_amt`='".$txn_fee_success."', `rolling_amt`='0', `mdr_cb_amt`='0', `mdr_cbk1_amt`='0', `mdr_refundfee_amt`='0', `payable_amt_of_txn`='".$payable_amt_of_txn."', `available_balance`='".$available_balance."', `risk_ratio`='".$total_ratio."' "; 
				
				$update_clients_query.="`available_balance`='".$available_balance."' ";
				$all_id.=$value['id'].","; 
				
				
				
				$postionNo.="postionNo=>12=>s".$value['trans_status'];
				
			}elseif(($value['trans_status']==14)){ // Withdraw Rolling 

				$txn_fee_success=number_formatf($value['fees']);	//transaction fee
				$bill_amt=number_formatf($bill_amt_converted);	//bill_amt
				
				$trans_amt=$bill_amt+$txn_fee_success;			//transaction bill_amt
				
				$available_rolling=number_formatf2($last_available_rolling - $trans_amt);	//available rolling
				
				//query for update
				$update_query .=" `trans_amt`='".$trans_amt."',`buy_mdr_amt`='', `buy_txnfee_amt`='', `rolling_amt`='".$trans_amt."', `mdr_cb_amt`='', `mdr_cbk1_amt`='', `mdr_refundfee_amt`='', `available_rolling`='".$available_rolling."', `risk_ratio`='".$total_ratio."' "; 
				
				$update_clients_query.="`available_rolling`='".$available_rolling."' ";
				$all_id.=$value['id'].","; 
				
				$postionNo.="postionNo=>13=>s".$value['trans_status'];
				
			}elseif(($value['trans_status']==2)&&($value['trans_type']==16)){
				
				// canceled in rolling withdraw
				
				$txn_fee_success=number_formatf($value['fees']);	//transaction fee
				
				$return_bill_amt=str_replace("-","",$value['bill_amt']);	//return bill_amt
							
				//$available_balance=$last_available_balance+($return_bill_amt);
				
				$available_rolling=$last_available_rolling+($return_bill_amt);	//available rolling
				
				//query for update
				$update_query .=" `trans_amt`='{$value['bill_amt']}',`trans_currency`='{$value['bill_currency']}', `buy_mdr_amt`='0', `buy_txnfee_amt`='0', `rolling_amt`='0', `mdr_cb_amt`='0', `mdr_cbk1_amt`='0', `mdr_refundfee_amt`='0', `payable_amt_of_txn`='0', `available_balance`='".$available_rolling."', `risk_ratio`='".$total_ratio."', `rolling_amt`='0', `available_rolling`='".$available_rolling."' "; 
				
				$update_clients_query.="`available_rolling`='".$available_rolling."' ";
				$all_id.=$value['id'].",";

				$postionNo.="postionNo=>14=>s".$value['trans_status'];
			} 
			
			//cmn echo
			//echo $postionNo;exit;
			
			if(isset($_REQUEST['action'])&&$_REQUEST['action']=='notify')
				$notify_msg=" | Notify Received from the {$value['acquirer']}";
			else $notify_msg='';
			
			
			if($all==false){
				if((isset($json_value['ar_tdate'])&&$json_value['ar_tdate'])||(isset($_REQUEST['tdateSkip']))){
					$rmk_date=date('d-m-Y h:i:s A');
					$remark_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg> Transaction Calculation for Re-check and Re-updated by System.{$notify_msg}</div></div>".$value['system_note'];
					
					// query update for master_trans_additional
					if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y')
						$update_query_add .=", `system_note`='".$remark_upd."' ";
					else $update_query .=", `system_note`='".$remark_upd."' ";
					
				}
				else{
					if($tdate!=$cdate){
						//update mer_note / system note
						$rmk_date=date('d-m-Y h:i:s A');
						$remark_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg> Transaction Calculation Updated by System.{$notify_msg}</div></div>".$value['system_note'];
						
						
						// query update for master_trans_additional
						if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y')
							$update_query_add .=", `system_note`='".$remark_upd."' ";
						else $update_query .=", `system_note`='".$remark_upd."' ";
						
					}
					
					//$update_query .=", `tdate`=NOW() ";
					//$tdate_micro=date('Y-m-d H:i:s'.substr((string)microtime(), 1, 6));
					$tdate_micro=micro_current_date();
					
					$update_query .=", `tdate`='{$tdate_micro}' ";
				}
			}
			
			
			
			
			//$now_micro=date('Y-m-d H:i:').(date('s')+fmod(microtime(true), 1));
			//$now_micro=date('Y-m-d H:i:s'.substr((string)microtime(), 1, 6));
			$now_micro=micro_current_date();
			
			if($update_query){
				$update_query .=", `fee_update_timestamp`='{$now_micro}' ";
			}
			
			if($update_clients_query){
				$umq=", ";
			}else{
				$umq=" ";
			} 
			
			if($ratio){
				$ratio_json=json_encode($ratio,1);
			}else{
				$ratio_json='';
			}
			
			if($risk_type=="Risk Ratio"){
				
				
			}elseif($risk_type=="Chargeback Ratio"){
				$update_clients_query .=$umq." `chargeback_ratio_card`='{$total_ratio}' ";
				
				//$update_clients_query .=$umq." `chargeback_ratio_card`='{$total_ratio}' ";
			}
			
			$update_query=ltrim($update_query,',');
			// update Query	
			db_query(
				"UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
				" SET ".$update_query.
				" WHERE `id`='".$value['id']."'",$qp
			);
			
			
			if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'&&isset($update_query_add)&&$update_query_add){
				$update_query_add=ltrim($update_query_add,',');
				// update table master_trans_additional via json_value,
				db_query(
					"UPDATE `{$data['DbPrefix']}{$data['ASSIGN_MASTER_TRANS_ADDITIONAL']}`".
					" SET ".$update_query_add.
					" WHERE `id_ad`='".$value['id']."'",$qp
				);
			}
			
			
			if($value['acquirer']==4){
				//send fund
				db_query(
					"UPDATE `{$data['DbPrefix']}payin_setting`".
					" SET ".$update_clients_query.
					" WHERE `clientid`='".$value['merID']."'",$qp
				);
				
				
				//received fund
				db_query(
					"UPDATE `{$data['DbPrefix']}clientid_table`".
					" SET ".$update_clients_query_merID.
					" WHERE `clientid`='".$value['merID']."'",$qp
				);
				//$wd_created_date=$json_value['wd_created_date'];
				//$ptdate=date('Y-m-d',strtotime($wd_created_date));
				
				/*
				$ds_sender=daily_trans_statement_amt($value['sender'],date('Y-m-d',strtotime($value['tdate'])));
				$ds_sender2=daily_trans_statement_amt($value['sender'],$ptdate);
				
				$ds_merID=daily_trans_statement_amt($value['merID'],date('Y-m-d',strtotime($value['tdate'])));
				$ds_merID2=daily_trans_statement_amt($value['merID'],$ptdate);
				
				*/
			
			}else{
			
				if(trim($update_clients_query)){
					db_query(
						"UPDATE `{$data['DbPrefix']}payin_setting`".
						" SET ".$update_clients_query.
						" WHERE `clientid`='{$uid}'",$qp
					);
				}
				
				/*
				if(($value['trans_status']==1||$value['trans_status']==2)&&($value['trans_type']==15)){
					$ds1=daily_trans_statement_amt($uid,date('Y-m-d',strtotime($value['tdate'])));
					$wd_created_date=$json_value['wd_created_date'];
					$ptdate=date('Y-m-d',strtotime($wd_created_date));
					$ds=daily_trans_statement_amt($uid,$ptdate);
				}
				*/
			}
			
			
			//email for missing calculation for charge back or refunded etc 
			
			if(($value['trans_status']==3) || ($value['trans_status']==12)){ 
				// Refunded for missing calc 
				$mdr_refundfee_amt_gt=number_formatf(str_replace_minus($accounts['refund_fee']));
				if( $mdr_refundfee_amt_gt <= 0 ){	
					$notify_subAdmin_email=1;
					//$array_notify[]=["n"=>"Refunded Fee","v"=>$accounts['refund_fee'].' '.$trans_currency];
				}
			}elseif($value['trans_status']==11){ // CB for missing calc 
				$cbk1_gt=number_formatf(str_replace_minus($accounts['cbk1']));
				if( $cbk1_gt <= 0 ){	
					$notify_subAdmin_email=1;
				}
			}elseif($value['trans_status']==5){ 
				// Chargeback for missing calc
				$mdr_cb_amt_gt=number_formatf(str_replace_minus($charge_back_fee));
				if( $mdr_cb_amt_gt <= 0 ){	
					$notify_subAdmin_email=1;
				}
			}else {
				$notify_subAdmin_email=0;
			}
						
			// 
			if(isset($notify_subAdmin_email)&&$notify_subAdmin_email==1){
				// if mdr_refundfee_amt 
				$pst['merID']=$uid;
				$pst['tableid']=$value['id'];
				$pst['transID']=$value['transID'];
				$pst['trans_status']=$data['TransactionStatus'][$value['trans_status']];
				$pst['mail_type']="16";
				//$pst['email']='';
				$data['customer_service_email_subAdmin']=1; // Get customer_service_email from SubAdmin
				//$data['testEmail_1_developer']=1; // Send email for developer
				
				$array_notify[]=["n"=>"Transaction ID","v"=>$value['transID']];
				$array_notify[]=["n"=>"Status","v"=>$data['TransactionStatus'][$value['trans_status']]];
				$array_notify[]=["n"=>"Transaction Amount","v"=>$value['trans_amt'].' '.$trans_currency];
				$array_notify[]=["n"=>"Rolling Amt","v"=>$value['rolling_amt'].' '.$trans_currency];
				$array_notify[]=["n"=>"Email","v"=>$value['bill_email']];
				$pst['ctable1']=c_table($array_notify,'95%');
				
				//update mer_note/system note
				$rmk_date=date('d-m-Y h:i:s A');
				$remark_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg><font color=red> Transaction has been missing calculation</font></div></div>".$value['system_note'];

				$update_remark =" `system_note`='".$remark_upd."' ";
				
				if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'&&isset($update_remark)&&$update_remark){
					$update_query_add=ltrim($update_query_add,',');
					db_query(
						"UPDATE `{$data['DbPrefix']}{$data['ASSIGN_MASTER_TRANS_ADDITIONAL']}`".
						" SET ".$update_remark.
						" WHERE `id_ad`='".$value['id']."'",$qp
					);
					$update_remark ="";
				}
				
				
				if(!empty($update_remark)){
					db_query(
						"UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
						" SET ".$update_remark.
						" WHERE `id`='".$value['id']."'",$qp
					);
				}
	
				send_email('NOTIFY_SUBADMIN_MISSIGN_CALCULATION', $pst);
			
				echo $_SESSION['adm_msg_failed']=$value['transID']. " Transaction has been missing calculation";
			}
			
		}
	}
	if($qp) echo "<br/>postionNo=>".$postionNo;
	//exit;
	$all_id_exp = explode(',' ,$all_id); $count =count($all_id_exp); 
	return $count."=".$all_id;
}

//Fetch the all detail from acquirer.
function mer_settings($uid, $id=0, $single=false, $acquirer_id=''){
	global $data; $prnt=0;
	if($acquirer_id) $acquirer_id=impf($acquirer_id,2);
	
	$q="SELECT * FROM `{$data['DbPrefix']}mer_setting`".
		" WHERE `merID`='{$uid}'".
		($acquirer_id?" AND `acquirer_id` IN ({$acquirer_id}) AND `acquirer_processing_mode` IN ('1','2') ":'').
		($id?" AND `id`='{$id}'":'').($single?" LIMIT 1":' ORDER BY acquirer_display_order IS NULL ASC, acquirer_display_order ASC, acquirer_id ASC ');
	
	$account=db_rows($q,$prnt);
	
	$result=array();
	foreach($account as $key=>$value){
		foreach($value as $name=>$v)$result[$key][$name]=$v;
	}
	return $result;
}

function select_mer_setting($uid, $id=0, $single=false, $account_type=''){
	global $data;
	$account=db_rows(
		"SELECT `a`.* FROM {$data['DbPrefix']}mer_setting AS `a`, {$data['DbPrefix']}clientid_table AS `m`".
		" WHERE ( (`a`.`merID`='{$uid}') OR (`a`.`merID`=`m`.`sponsor` AND `a`.`sponsor`='{$uid}'))".
		($account_type?" AND `a`.`acquirer_id`='{$account_type}'":'').
		($id?" AND `a`.`id`='{$id}'":'').($single?" GROUP BY `a`.`id` ORDER BY `a`.`acquirer_id` LIMIT 1":' GROUP BY `a`.`id` ORDER BY `a`.`acquirer_display_order` IS NULL ASC, `a`.`acquirer_display_order` ASC, `a`.`acquirer_id` ASC '),0
	);
	$result=array();
	foreach($account as $key=>$value){
		foreach($value as $name=>$v)$result[$key][$name]=$v;
	}
	return $result;
}

function count_mer_setting($uid, $acquirer_id, $d_status=true){
	global $data;
	$uid;
	$acquirer_id;
	$count_duplicate=db_rows(
		"SELECT COUNT(`id`) AS `trcount` FROM `{$data['DbPrefix']}mer_setting`".
		" WHERE `merID`='{$uid}'".
		" AND `acquirer_id`='{$acquirer_id}' LIMIT 1 ",0
	);
	$count_duplicate=(int)$count_duplicate[0]['trcount'];
	
	if($count_duplicate > 0){ $d_status=true; }else{$d_status=false; }
	
	return $d_status;
}

function create_mer_setting($post, $uid, $notify=true){
	global $data;
	$encrypt_email="";
	if(!$post['acquirer_display_order']){
		$post['acquirer_display_order']=0;		//setup acquirer_display_order 0 if not assign
	}
	
	if(isset($data['con_name'])&&$data['con_name']=='clk'){
		
		$post['gst_rate']=((isset($post['acq']['gst_rate'])&&$post['acq']['gst_rate'])?$post['acq']['gst_rate']:((isset($data['domain_server']['as']['gst_fee'])&&$data['domain_server']['as']['gst_fee'])?$data['domain_server']['as']['gst_fee']:"18"));
		
		$post['gst_rate']=number_formatf2(@$post['gst_rate']);
		
		$insert_qr_1=",`gst_rate` ";
		$insert_qr_2=", '{$post['gst_rate']}' ";		//insert GST fee if con_name is clk (Indian)
	}else{
		$insert_qr_1=" ";
		$insert_qr_2=" ";
	}
	
	$scrubbed_json=json_encode(@$post['scrubbed_json']);
	 
	if(!empty($post['encrypt_email'])){$encrypt_email=implodes(",",$post['encrypt_email']);}
	if(!empty($post['card_type'])){$card_type=implodes(",",$post['card_type']);}
	
	$post['merID']= $uid;
	
	if(empty($post['acquirer_id'])&&!empty($post['acquirer_name'])){$post['acquirer_id']=$post['acquirer_name'];}
	
	
	$post['virtual_fee']=number_formatf2(@$post['virtual_fee']);
	$post['monthly_fee']=number_formatf2(@$post['monthly_fee']);
	$post['refund_fee']=number_formatf2(@$post['refund_fee']);
	$post['mdr_visa_rate']=number_formatf2(@$post['mdr_visa_rate']);
	$post['mdr_mc_rate']=number_formatf2(@$post['mdr_mc_rate']);
	$post['mdr_jcb_rate']=number_formatf2(@$post['mdr_jcb_rate']);
	$post['mdr_amex_rate']=number_formatf2(@$post['mdr_amex_rate']);
	$post['mdr_range_rate']=number_formatf2(@$post['mdr_range_rate']);
	$post['mdr_range_amount']=number_formatf2(@$post['mdr_range_amount']);
	$post['txn_fee_failed']=number_formatf2(@$post['txn_fee_failed']);
	$post['charge_back_fee_1']=number_formatf2(@$post['charge_back_fee_1']);
	$post['charge_back_fee_2']=number_formatf2(@$post['charge_back_fee_2']);
	$post['charge_back_fee_3']=number_formatf2(@$post['charge_back_fee_3']);
	
	db_query(
			"INSERT INTO `{$data['DbPrefix']}mer_setting`(".
			"`merID`,`acquirer_id`,`txn_fee_success`,`mdr_rate`,`acquirer_processing_currency`,`min_limit`,`acquirer_processing_mode`,".
			"`max_limit`,`scrubbed_period`,`trans_count`,`reserve_rate`,`virtual_fee`,".
			"`acquirer_processing_json`,`salt_id`,`charge_back_fee_1`,`charge_back_fee_2`,`charge_back_fee_3`,`encrypt_email`,`cbk1`,`moto_status`,".
			"`checkout_label_web`,`refund_fee`,`mdr_visa_rate`,`mdr_mc_rate`,`mdr_jcb_rate`,`mdr_amex_rate`,`mdr_range_rate`,`mdr_range_type`,`mdr_range_amount`,".
			"`monthly_fee`,`assignee_type`,`sponsor`,`checkout_label_mobile`,`settelement_delay`,`reserve_delay`,`txn_fee_failed`,`tr_scrub_success_count`,`tr_scrub_failed_count`,`acquirer_display_order`,`scrubbed_json`".$insert_qr_1.
			
			")VALUES(".
			"{$uid},'{$post['acquirer_id']}','{$post['txn_fee_success']}','{$post['mdr_rate']}',".
			"'{$post['acquirer_processing_currency']}','{$post['min_limit']}','{$post['acquirer_processing_mode']}',".
			"'{$post['max_limit']}','{$post['scrubbed_period']}',".
			"'{$post['trans_count']}','{$post['reserve_rate']}','{$post['virtual_fee']}',".
			"'{$post['acquirer_processing_json']}','{$post['salt_id']}','{$post['charge_back_fee_1']}','{$post['charge_back_fee_2']}','{$post['charge_back_fee_3']}','{$encrypt_email}','{$post['cbk1']}','{$post['moto_status']}',".
			"'{$post['checkout_label_web']}','{$post['refund_fee']}','{$post['mdr_visa_rate']}','{$post['mdr_mc_rate']}','{$post['mdr_jcb_rate']}','{$post['mdr_amex_rate']}','{$post['mdr_range_rate']}','{$post['mdr_range_type']}','{$post['mdr_range_amount']}',".
			"'{$post['monthly_fee']}','{$post['assignee_type']}',{$post['sponsor']},'{$post['checkout_label_mobile']}','{$post['settelement_delay']}','{$post['reserve_delay']}','{$post['txn_fee_failed']}','{$post['tr_scrub_success_count']}','{$post['tr_scrub_failed_count']}','{$post['acquirer_display_order']}','{$scrubbed_json}'{$insert_qr_2})",$data['cqp']
	);
	if(@$data['cqp']==9) exit;
	$newid=newid();
	json_log_upd($newid,'mer_setting','Insert'); // for json log history
	
	
	return $newid;
		
}

function update_mer_setting($post, $gid, $uid, $notify=true){
        global $data;
		$encrypt_email="";
		
	
		//Dev Tech : 23-01-17 modify 
        if(isset($post['scrubbed_json'])&&$post['scrubbed_json']) { 	
			$scrubbed_json=jsonencode($post['scrubbed_json']);
		}
		else {$scrubbed_json='';}
		
		$card_type='';
		
		if(empty($post['acquirer_display_order']))$post['acquirer_display_order']='3';
		if(!empty($post['acquirer_processing_json']))$post['acquirer_processing_json']=stripslashes($post['acquirer_processing_json']);
		

		if(!empty($post['encrypt_email'])){$encrypt_email=implodes(",",$post['encrypt_email']);}
		//$card_type=$post['card_type'];
		if(!empty($post['card_type'])){$card_type=implodes(",",$post['card_type']);}
	
	$post['virtual_fee']=number_formatf2(@$post['virtual_fee']);
	$post['monthly_fee']=number_formatf2(@$post['monthly_fee']);
	$post['refund_fee']=number_formatf2(@$post['refund_fee']);
	$post['mdr_visa_rate']=number_formatf2(@$post['mdr_visa_rate']);
	$post['mdr_mc_rate']=number_formatf2(@$post['mdr_mc_rate']);
	$post['mdr_jcb_rate']=number_formatf2(@$post['mdr_jcb_rate']);
	$post['mdr_amex_rate']=number_formatf2(@$post['mdr_amex_rate']);
	$post['mdr_range_rate']=number_formatf2(@$post['mdr_range_rate']);
	$post['mdr_range_amount']=number_formatf2(@$post['mdr_range_amount']);
	$post['txn_fee_failed']=number_formatf2(@$post['txn_fee_failed']);
	$post['charge_back_fee_1']=number_formatf2(@$post['charge_back_fee_1']);
	$post['charge_back_fee_2']=number_formatf2(@$post['charge_back_fee_2']);
	$post['charge_back_fee_3']=number_formatf2(@$post['charge_back_fee_3']);
	
		
		if($_SESSION['adm_login']){
		  $adm_updt=",`txn_fee_success`='{$post['txn_fee_success']}',".
                "`mdr_rate`='{$post['mdr_rate']}',`acquirer_processing_currency`='{$post['acquirer_processing_currency']}',".
                "`min_limit`='{$post['min_limit']}',`acquirer_processing_mode`='{$post['acquirer_processing_mode']}',".
                "`max_limit`='{$post['max_limit']}',`acquirer_id`='{$post['acquirer_id']}',".
                "`scrubbed_period`='{$post['scrubbed_period']}',`trans_count`='{$post['trans_count']}',".
                "`reserve_rate`='{$post['reserve_rate']}',`monthly_fee`='{$post['monthly_fee']}',".
				"`acquirer_processing_json`='{$post['acquirer_processing_json']}',`salt_id`='{$post['salt_id']}',`charge_back_fee_1`='{$post['charge_back_fee_1']}',`charge_back_fee_2`='{$post['charge_back_fee_2']}',`charge_back_fee_3`='{$post['charge_back_fee_3']}',`encrypt_email`='{$encrypt_email}',`cbk1`='{$post['cbk1']}',`moto_status`='{$post['moto_status']}',".
				"`refund_fee`='{$post['refund_fee']}',".
				"`mdr_visa_rate`='{$post['mdr_visa_rate']}',`mdr_mc_rate`='{$post['mdr_mc_rate']}',`mdr_jcb_rate`='{$post['mdr_jcb_rate']}',`mdr_amex_rate`='{$post['mdr_amex_rate']}',`mdr_range_rate`='{$post['mdr_range_rate']}',`mdr_range_type`='{$post['mdr_range_type']}',`mdr_range_amount`='{$post['mdr_range_amount']}',".
				"`virtual_fee`='{$post['virtual_fee']}',`checkout_label_mobile`='{$post['checkout_label_mobile']}',`settelement_delay`='{$post['settelement_delay']}',`reserve_delay`='{$post['reserve_delay']}',`txn_fee_failed`='{$post['txn_fee_failed']}',`tr_scrub_success_count`='{$post['tr_scrub_success_count']}',`tr_scrub_failed_count`='{$post['tr_scrub_failed_count']}',`acquirer_display_order`='{$post['acquirer_display_order']}',`scrubbed_json`='{$scrubbed_json}'";
			
				if(isset($post['gst_rate'])){
					$post['gst_rate']=number_formatf2(@$post['gst_rate']);
					$adm_updt.=",`gst_rate`='{$post['gst_rate']}'";
				}
			
		} else {
		  $adm_updt="";
		}
		
		
        db_query(
                "UPDATE `{$data['DbPrefix']}mer_setting` SET ".
				"`checkout_label_web`='{$post['checkout_label_web']}'".$adm_updt.
                " WHERE `id`='{$gid}'",$data['cqp']
        );
		if(@$data['cqp']==9) exit;
		json_log_upd($gid,'mer_setting','Update');	//update json log history
}

function delete_mer_setting($gid){
	global $data;
	$dresult=db_rows("SELECT * FROM `{$data['DbPrefix']}mer_setting` WHERE `id`='{$gid}' LIMIT 1 ");
	$data['JSON_INSERT']=1;
	json_log_upd($gid,'mer_setting','Delete',$dresult,$dresult[0]['merID']);	//update json log history
	db_query(
		"DELETE FROM `{$data['DbPrefix']}mer_setting`".
		" WHERE `id`='{$gid}' ;"
	);
	
	if($data['connection_type']=='PSQL'){
		db_query(
			"SELECT setval('zt_mer_setting_id_seq', (SELECT MAX(id) FROM zt_mer_setting)+1);"
		);
	}
}

function scrubbed_trans($uid,$account_type,$trans_id='',$email=''){
	global $data,$post;

	$tran_db=false; $scrubbed_msg=""; $status_upd="";
	$sc_amt_sum=0; $sc_tr_count=0;
	$shw_msg="";

	$blk_scrubbed = blacklist_scrubbed($uid);
	if(isset($blk_scrubbed[0])&&$blk_scrubbed[0]) { $tran_db=true;$status_upd=" `trans_status`=10, ";}
	if(isset($blk_scrubbed[1])&&$blk_scrubbed[1]) $shw_msg=", ".$blk_scrubbed[1];

	if(!$tran_db){
	//$account=mer_settings($uid, 0, true, $account_type);
	$account=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}mer_setting`".
		" WHERE `merID`='{$uid}'".
		" AND `acquirer_id`='{$account_type}' AND (`assignee_type`='1') LIMIT 1 "
	);
	
	$account_type=(int)$account_type;
	
	$get_clientid_details=select_client_table($uid);
	
	$accounts = array();
	if(isset($account[0])&&$account[0])
	{
		$accounts = $account[0];
	}
	else
	{
		$bank_gateway=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}acquirer_table`".
			" WHERE `acquirer_id`='{$account_type}' AND (`acquirer_status`='2') LIMIT 1 "
		);
		if(isset($bank_gateway[0])&&isset($bank_gateway[0]['acquirer_json'])&&$bank_gateway[0]&&$bank_gateway[0]['acquirer_json'])
		{
			$accounts = jsondecode(@$bank_gateway[0]['acquirer_json'],1,1);
		}
	}

	$min_limit=((isset($accounts['min_limit']) && trim($accounts['min_limit']))?(double)$accounts['min_limit']:1);
	$max_limit=((isset($accounts['max_limit']) && trim($accounts['max_limit']))?(double)$accounts['max_limit']:500);
	$trn_count=((isset($accounts['trans_count']) && trim($accounts['trans_count']))?(int)$accounts['trans_count']:7);
	$trn_success_count=((isset($accounts['tr_scrub_success_count']) && trim($accounts['tr_scrub_success_count']))?(int)$accounts['tr_scrub_success_count']:2);
	$trn_failed_count=((isset($accounts['tr_scrub_failed_count']) && trim($accounts['tr_scrub_failed_count']))?(int)$accounts['tr_scrub_failed_count']:5);
	//$pro_curres=$accounts['acquirer_processing_currency'];
	$scrubbed_period=((isset($accounts['scrubbed_period']) && trim($accounts['scrubbed_period']))?(int)$accounts['scrubbed_period']:1);
	

	
	
	$pro_curre=get_currency($get_clientid_details['default_currency']);
	
	$result=array();
	
	
	$status_upd=" `trans_status`=10, ";
	
	
	if(($scrubbed_period>0)&&(!empty($max_limit))&&(!empty($email))){
		$cdate 	= date('Y-m-d');
		if($scrubbed_period==1)
		{
			$fpdate = date("Y-m-d 00:00:00");
			$tpdate = date("Y-m-d 23:59:59");
		}
		else
		{
			$dayfrom = $scrubbed_period-1;
			$fpdate = date("Y-m-d",strtotime("-$dayfrom day",strtotime($cdate)));
		$tpdate = date("Y-m-d",strtotime("+1 day",strtotime($cdate)));
		}
		$sc_tr=db_rows(
			"SELECT COUNT(`id`) AS `trcount`".
			" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" WHERE (`merID`='{$uid}') AND ( `acquirer`='{$account_type}' ) AND (`trans_status` IN (1,2,7,22,23,24)) AND `trans_type` IN (11) AND ( `bill_email`='{$email}' ) ". 
			" AND (created_date between '{$fpdate}' AND '{$tpdate}') LIMIT 1",0
		);
		$sc_tr_count=(int)$sc_tr[0]['trcount'];
		
		$sc_amt_all=db_rows(
				"SELECT SUM(`trans_amt`) AS `summ`".
			" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" WHERE (`merID`='{$uid}') AND ( `acquirer`='{$account_type}' ) AND ( `trans_status`=1 ) AND `trans_type` IN (11) AND ( `bill_email`='{$email}' ) ". //
			//" AND (tdate between '{$fpdate}' AND '{$tpdate}') LIMIT 1",0
			" AND (created_date between '{$fpdate}' AND '{$tpdate}') LIMIT 1",0
		);
		
		$sc_amt_sum=(double)@$sc_amt_all[0]['summ'];
		
		//echo $sc_amt_sum;exit;
		
		$last_amts=db_rows(
			"SELECT `bill_amt`,`transID` ".
			" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" WHERE (`merID`='{$uid}') AND ( `bill_email`='{$email}' ) ".
			" ORDER BY `id` DESC LIMIT 1",0
		);
		$last_amt=@$last_amts[0]['bill_amt'];	
		
		
		$sc_tr_completed=db_rows(
			"SELECT COUNT(`id`) AS `trcount`".
			" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" WHERE (`merID`='{$uid}') AND ( `acquirer`='{$account_type}' ) AND (`trans_status`=1) AND ( `bill_email`='{$email}' ) ". //
	//			" AND (tdate between '{$fpdate}' AND '{$tpdate}') LIMIT 1",0
				" AND (created_date between '{$fpdate}' AND '{$tpdate}') LIMIT 1",0
		);
		$sc_tr_completed_count=(int)$sc_tr_completed[0]['trcount'];
		
		$sc_tr_cancelled=db_rows(
			"SELECT COUNT(`id`) AS `trcount`".
			" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" WHERE (`merID`='{$uid}') AND ( `acquirer`='{$account_type}' ) AND (`trans_status`=2) AND ( `bill_email`='{$email}' ) ". //
		//		" AND (tdate between '{$fpdate}' AND '{$tpdate}') LIMIT 1",0
				" AND (created_date between '{$fpdate}' AND '{$tpdate}') LIMIT 1",0
		);
		$sc_tr_cancelled_count=(int)@$sc_tr_cancelled[0]['trcount'];
		 		
	}
	
	
	
		if($sc_amt_sum<=0){$sc_amt_sum=$last_amt;}else {$sc_amt_sum+=$last_amt;}
	
	
	
		//if($last_amt >= $min_limit){}else
	
		if($last_amt < $min_limit) {	// Min limit
			$shw_msg .= ", Min. transaction amount allowed ".$pro_curre.$min_limit." on your mid";
			$tran_db=true;
		}
		elseif($max_limit < $sc_amt_sum){	// Max limit
			$shw_msg .= ", Max. transaction amount allowed ".$pro_curre.$max_limit." on your mid";
			$tran_db=true;
		} 
		elseif($trn_count <= $sc_tr_count){	//Transaction Count
			$shw_msg .= ", Max. transactions allowed within (".$scrubbed_period." days) : ".$trn_count." on your mid";
			$tran_db=true;
		}
		elseif($trn_success_count <= $sc_tr_completed_count){	//Min. Success Count
			$shw_msg .= ", Max. Success transactions allowed within ({$scrubbed_period} days) : {$sc_tr_completed_count} from {$trn_success_count} on your mid";
			$tran_db=true;
		}
		elseif($trn_failed_count <= $sc_tr_cancelled_count){	//Min. Failed Count
			$shw_msg .= ", Max. Declined transactions allowed within ({$scrubbed_period} days) : {$sc_tr_cancelled_count} from {$trn_failed_count} on your mid";
			$tran_db=true;
		}
	
	
	}
	
	//$tran_db=true;	
	if($tran_db){
		$shw_msg=ltrim($shw_msg,", ");
		$scrubbed_msg=". Scrubbed Reason : ".$shw_msg;
		if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'){
			$trans=db_rows(
					"SELECT `support_note` FROM `{$data['DbPrefix']}{$data['ASSIGN_MASTER_TRANS_ADDITIONAL']}` WHERE `transID_ad`='{$trans_id}' LIMIT 1",0
			);
		}
		else {
			$trans=db_rows(
					"SELECT `support_note` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` WHERE `merID`='{$uid}' AND `transID`='{$trans_id}' LIMIT 1",0
			);
		}
		$remark_get	= @$trans[0]['support_note']; 
		
		
		$rmk_date=date('d-m-Y h:i:s A');
		
		$tr_status_set="Transaction has been Scrubbed ".$scrubbed_msg; // 
		$remark_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$tr_status_set." </div></div>".$remark_get;
		
		
		// query update for master_trans_additional
		$additional_update=$master_update=", `support_note`='{$remark_upd}',`trans_response`='{$shw_msg}' ";
		
		
		if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'){
			$master_update='';
			$additional_update=ltrim($additional_update,',');
			db_query("UPDATE `{$data['DbPrefix']}{$data['ASSIGN_MASTER_TRANS_ADDITIONAL']}` SET ".$additional_update." WHERE `transID_ad`='{$trans_id}' "); 
		}
		
		
		db_query(
			"UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" SET ".$status_upd." `transaction_flag`='3' ".$master_update.// flag scrubbed
			" WHERE `merID`='{$uid}' AND `transID`='{$trans_id}'"
		);
	}
	
	$result['scrubbed_status']=$tran_db;
	$result['scrubbed_msg']=$scrubbed_msg;
	
	/*
	$result['scrubbed_period']=$scrubbed_period;
	$result['post_amt']=$last_amt;
	$result['min_limit']=$min_limit;
	$result['db_amt_sum']=$sc_amt_sum;
	$result['max_limit']=$max_limit;
	
	$result['trn_count']=$trn_count;
	$result['db_amt_count']=$sc_tr_count;
	$result['uid']=$uid;$result['trans_id']=$trans_id;$result['email']=$email;$result['account_type']=$account_type;
		
	
	*/
	
	$_SESSION['scrubbed_msg']=$scrubbed_msg;
	
	
	return $result;
}

function unique_id_tr_trans($trid){
	global $data;$get_unique_id=false;
	$result=db_rows(
		"SELECT transID ".
		" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
		" WHERE `transID`='{$trid}' ".
		" ORDER BY `id` DESC LIMIT 1"
	);
	if($result[0]['transID']==$trid){
		$trid=$trid."1";
	}
	return $trid; 
}

function join_additional($t=''){
	global $data;
	
	if(isset($_REQUEST['a'])&&$_REQUEST['a']=='cn'&&isset($_SESSION['login_adm']))
		echo "<br/>MASTER_TRANS_ADDITIONAL==>".$data['MASTER_TRANS_ADDITIONAL']."<br/>";

	if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'){
		if($t=='t')
			$join_additional=" LEFT JOIN `{$data['DbPrefix']}{$data['ASSIGN_MASTER_TRANS_ADDITIONAL']}` AS `ad` ON `t`.`id` = `ad`.`id_ad` ";
		elseif($t=='i')
			$join_additional=" INNER JOIN `{$data['DbPrefix']}{$data['ASSIGN_MASTER_TRANS_ADDITIONAL']}` AS `ad` ON `t`.`id` = `ad`.`id_ad` ";
		else
			$join_additional=" LEFT JOIN `{$data['DbPrefix']}{$data['ASSIGN_MASTER_TRANS_ADDITIONAL']}` ON `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`.`id` = `{$data['DbPrefix']}{$data['ASSIGN_MASTER_TRANS_ADDITIONAL']}`.`id_ad` ";
	}
	else $join_additional='';
	
	return $join_additional; 
}


//Dev Tech : 23-11-27 modify new transaction use on paymentapi 
### -10##########
function create_new_trans($merID, $bill_amt, $acquirer, $trans_status,$fullname='', $bill_address='', $bill_city='', $bill_state='', $bill_zip='', $bill_email='', $ccno='', $bill_phone='', $product_name='', $source_url=''){
	global $transID;
	global $data; global $tr_newtableid; 
	global $trcode; global $tr_orderset; $qp=0;
	
	if(isset($_GET['cqp'])&&$_GET['cqp']==5) $qp=$_GET['cqp'];
	
	try {
		
		//$transID = $acquirer.date('ymdHis').rand(10000,99999);
		$transID = $acquirer.(new DateTime())->format('dHisu');
		$trans_type='11';
		$reference=$_SESSION['reference'];
		$terNO=$_SESSION['terNO'];


		if(isset($_SESSION['settelement_delay'])){
			$settelement_delay=(int)$_SESSION['settelement_delay'];
		}else{
			if($data['con_name']=='clk'){
				$settelement_delay=0;
			}else{
				$settelement_delay=180;
			}
		}
 
		$settelement_date=date('Y-m-d H:i:s',strtotime("+$settelement_delay day",strtotime(date('Y-m-d H:i:s'))));
		
		if(isset($_SESSION['rolling_delay'])){
			$rolling_delay=(int)$_SESSION['rolling_delay'];
		}else{
			if($data['con_name']=='clk'){
				$rolling_delay=0;
			}else{
				$rolling_delay=180;
			}
		}
		
		$rolling_date=date('Y-m-d H:i:s',strtotime("+$rolling_delay day",strtotime(date('Y-m-d H:i:s'))));
		
		
		$trans_currency=$_SESSION['trans_currency']; // fetch clients's default currency into session trans_currency
		
		
		$acquirer_json=mer_settings($merID, 0, true, $acquirer); 
		
		if($acquirer_json){
			unset($acquirer_json[0]['json_log_history']);
			$acquirer_json=jsonencode($acquirer_json[0]);
			//$acquirer_json=($acquirer_json[0]);
		}else{
			$acquirer_json="{}";
		}
		
		
		
		$mop=$_SESSION['info_data']['mop'];
		$source_type=$data['SiteName']." ";$bill_country="";
		$webhook_url="";$bill_currency="";$bank_processing_amount="0.00";$bank_processing_curr="";
		if(isset($_SESSION['info_data']['country'])&&!empty($_SESSION['info_data']['country'])){$bill_country=$_SESSION['info_data']['country'];}
		if((isset($_SESSION['source']))&&($_SESSION['source'])){$source_type=$data['SiteName']." ".$_SESSION['source'];}
		
		if(isset($_SESSION['webhook_url_get'])&&!empty($_SESSION['webhook_url_get'])){$webhook_url=$_SESSION['webhook_url_get']; }
		
		$return_url='';
		if(isset($_SESSION['return_url_get'])&&!empty($_SESSION['return_url_get'])){$return_url=$_SESSION['return_url_get']; }
		
		
		if(isset($_SESSION['bill_currency'])&&!empty($_SESSION['bill_currency'])){$bill_currency=$_SESSION['bill_currency']; }
		
		if(isset($_SESSION['bank_processing_amount'])&&!empty($_SESSION['bank_processing_amount'])){$bank_processing_amount=number_formatf2($_SESSION['bank_processing_amount']);}
		if(isset($_SESSION['bank_processing_curr'])&&!empty($_SESSION['bank_processing_curr'])){$bank_processing_curr=$_SESSION['bank_processing_curr']; }
		
		
		
		if($ccno){
			$_SESSION['bin_no']		=substr($ccno,0,6);

			$cbin=card_binf($ccno);
			if(isset($cbin['bank_name'])&&$cbin['bank_name']){
				$_SESSION['json_value']['bin_bank_name']=$cbin['bank_name'];
			}
			if(isset($cbin['josn']['phone'])&&$cbin['josn']['phone']){
				$_SESSION['json_value']['bin_phone']=$cbin['josn']['phone'];
			}
			if(isset($cbin['josn']['website'])&&$cbin['josn']['website']){
				$_SESSION['json_value']['bin_website']=$cbin['josn']['website'];
			}
			if(isset($cbin['josn']['scheme'])&&$cbin['josn']['scheme']){
				$_SESSION['json_value']['scheme']=$cbin['josn']['scheme'];
			}
			
			$ccno=card_encrypts256($ccno);
		}
		
		
		$json_value="";
		if((isset($_SESSION['json_value']))&&(!empty($_SESSION['json_value']))){
			$_SESSION['json_value']['assignTransID']=$transID;
			$_SESSION['json_value']['post']['TIMESTAMP']=prndates(date('Y-m-d H:i:s'));
			$json_value= jsonencode($_SESSION['json_value']);
		}
		
		//echo '<br/>json_value=>'.$json_value;	exit;
		
		$rmk_date=date('d-m-Y h:i:s A');
		
		if(isset($_SESSION['login'])&&$_SESSION['login']){
			$resource_name = " Virtual Terminal ";
		} else {
			$resource_name = $source_type." ";
		}
		$bill_ip=$data['Addr'];
		if(isset($_SESSION['bill_ip'])){
			$bill_ip=$_SESSION['bill_ip'];
		}
		
		$request_uri='';
		if(isset($_SESSION['request_uri'])){
			$request_uri=" - <font class=request_uri_1>".$_SESSION['request_uri']."</font>";
		}
		
		$bill_ip_note = "Transaction created by ".$resource_name." ( From IP Address: <font class=ip_view>".$bill_ip."</font> )".$request_uri;
		$system_note = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg> ".$bill_ip_note." </div></div>";
		
		
		$trans_response='';$support_note='';$descriptor='';
		if($trans_status==9||(isset($_SESSION['json_value']['is_test'])&&$_SESSION['json_value']['is_test']=="9")){
			if(isset($_SERVER['SERVER_NAME'])){
				$descriptor='Test*'.$_SERVER['SERVER_NAME'];
			}
			if(isset($_SESSION['json_value']['is_test'])&&$_SESSION['json_value']['is_test']=="9"){
				$is_pending='in Pending mode';
			}else{
				$is_pending='succeeded';
			}
			$trans_response='Test Transaction succeeded';
			$support_note="<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg> Test Transaction {$is_pending}, we do not charge any fees for testing transaction </div></div>";
		}
		
		$orderset='';
		
		$bin_fld = $bin_data="";
		if(isset($data['BIN_EX_DATA']) && $data['BIN_EX_DATA']==1)
		{
			if(isset($_SESSION['bin_no'])&&$_SESSION['bin_no'])
			{
				$bin_fld	= ",`bin_no`";
				$bin_data	= ",'".$_SESSION['bin_no']."'"; 
			}
			if(isset($_SESSION['ex_month'])&&trim($_SESSION['ex_month']))
			{
				$bin_fld	.= ",`ex_month`";
				$bin_data	.= ",'".exp_encrypts256($_SESSION['ex_month'])."'"; 
			}
			if(isset($_SESSION['ex_year'])&&trim($_SESSION['ex_year']))
			{
				$bin_fld	.= ",`ex_year`";
				$bin_data	.= ",'".exp_encrypts256($_SESSION['ex_year'])."'"; 
			}
		}
		
		if(isset($_SESSION['bearer_token_id'])&&trim($_SESSION['bearer_token_id'])){
			$bearer_token=$_SESSION['bearer_token_id'];
		}else{
			$bearer_token=0;
		}
		
		if(isset($_SESSION['b_'.$acquirer]['channel_type'])&&trim($_SESSION['b_'.$acquirer]['channel_type'])){
			$channel_type=$_SESSION['b_'.$acquirer]['channel_type'];
		}else{
			$channel_type='';
		}
		
		$tdate_micro=micro_current_date();
		
		$additional_fld=$master_fld=",`support_note`,`system_note`,`json_value`,`acquirer_json`,`payload_stage1`, `ccno`,`source_url`,`webhook_url`,`return_url`,`descriptor`,`trans_response`, `bill_address`,`bill_city`,`bill_state`,`bill_country`,`bill_zip`,`bill_phone`,`product_name` ".$bin_fld ;
		
		$additional_data=$master_data=",'{$support_note}','{$system_note}','{$json_value}','{$acquirer_json}','{$json_value}','{$ccno}','{$source_url}','{$webhook_url}','{$return_url}','{$descriptor}','{$trans_response}','{$bill_address}','{$bill_city}','{$bill_state}','{$bill_country}','{$bill_zip}','{$bill_phone}','{$product_name}'".$bin_data ;
		
		
		if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'){
			$master_fld=''; $master_data='';
		}
		
		//`trans_response`,`bill_phone`,`bill_address`,`bill_city`,`bill_state`,		`bill_country`,`bill_zip`,`product_name`,
			
		$qry="INSERT INTO `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			"(`tdate`,`transID`,`merID`,`bill_amt`,`acquirer`,`trans_status`, `fullname`,`bill_email`,".
			"`mop`,`bill_currency`,`bill_ip`,`trans_type`,`reference`,`terNO`,`settelement_delay`,`settelement_date`,`rolling_delay`,`rolling_date`,`trans_currency`,`bank_processing_amount`,`bank_processing_curr`,`channel_type`,`bearer_token` ".$master_fld.")VALUES".
			"('{$tdate_micro}','{$transID}','{$merID}','{$bill_amt}','{$acquirer}','{$trans_status}','".$fullname."','".$bill_email."','".$mop."','".$bill_currency."','".$bill_ip."','".$trans_type."','".$reference."','".$terNO."','".$settelement_delay."','".$settelement_date."','".$rolling_delay."','".$rolling_date."','".$trans_currency."','".$bank_processing_amount."','".$bank_processing_curr."','".$channel_type."','".$bearer_token."' ".$master_data." )";
			 
	 
		
			if($data['localhosts']==true){
				//$ccno=$_POST['ccno'];
			}
			
		
		//echo $qry;exit;
		
		if($merID>0)
		{
			db_query($qry,$qp);
			$tr_newtableid=newid();
		}else{
			$tr_newtableid=0;
		}
		
		$transID = gen_transID_f($tr_newtableid,$acquirer);
		
		$trcode=$_SESSION['transID_arr'][]=$_SESSION['transID']=$transID;
		
		/*
		$orderset=$trcode."_".$_SESSION['trans_orderset'];
		$_SESSION['orderset']=$orderset;
		$tr_orderset=$orderset;
		*/
		
		if($tr_newtableid>0){	
			db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` SET `transID`=".$transID."  WHERE (`id`='{$tr_newtableid}') ",$qp);
			
			$tableName=$data['MASTER_TRANS_TABLE'];
			//$action_name='Bearer Token';
			
			//insert data to new table for master_trans_additional 
			if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'){
				db_query("INSERT INTO `{$data['DbPrefix']}{$data['ASSIGN_MASTER_TRANS_ADDITIONAL']}` (`id_ad`,`transID_ad` ".$additional_fld.")VALUES".
				"('{$tr_newtableid}','{$transID}' ".$additional_data.")",$qp);
				$tableName=$data['ASSIGN_MASTER_TRANS_ADDITIONAL'];
			}
			
		}else {
			$tableName='json_log';
			
		}
		
		$action_name=$bearer_token;
		
		if(isset($data['json_log_upd_payin_processing'])&&$data['json_log_upd_payin_processing']=='Y')
		{
		
			$json_log_arr=[];
			$json_log_row=select_tablef(" `action_name`='{$bearer_token}' ORDER BY `id` DESC ",'json_log',0,1);
			if(isset($json_log_row['json_log_history'])&&$json_log_row['json_log_history'])
			$json_log_arr=jsondecode($json_log_row['json_log_history'],1,1);
			$json_log_arr['assignViaLogTransID']=$transID;
		
			//if(!is_array($json_log_arr)&&isset($_POST)) $json_log_arr=$_POST;
			
			//echo "<br/><hr/><br/>json_log_upd=> $tr_newtableid,$tableName,$action_name,$json_log_arr,$merID,$terNO,transID=>$transID,$reference,$bill_amt,$bill_email"; //exit;
		
			json_log_upd($tr_newtableid,$tableName,$action_name,$json_log_arr,$merID,$terNO,$transID,$reference,$bill_amt,$bill_email);
			
			if ($tr_newtableid>0){
				wh_log("Query Saved Successfully . ID-".$tr_newtableid.' | bill_email: '.$bill_email.' | Fullname: '.$fullname.' | transID: '.$transID);
			}else {
				$ccno='';
				//$qry=$qry_p1.$ccno.$qry_p2;
				//wh_log($qry,'apilog',1);
				//wh_log("Query Failed, Not Saved.".' | bill_email: '.$bill_email.' | Fullname: '.$fullname.' | transID: '.$transID,'apilog',1);
			}
			
			
		}
		//exit;
		
		//Dev Tech: 23-10-27 create transaction for backup like 7 day before 
		if(isset($data['Database_3'])&&$data['Database_3']&&function_exists('db_connect_3')&&function_exists('create_trans_for_backup')&&isset($data['create_trans_for_backup'])&&$data['create_trans_for_backup']=='Y')
		{
			create_trans_for_backup();
		}
		
		
		
		
		$_SESSION['tr_newid']=$tr_newtableid;
		//$_SESSION['tr_orderset']=$orderset."_".$tr_newtableid;
		
		//exit; 
	}
	catch(Exception $e) {
		echo '<=create_new_trans=> ' .$e->getMessage();
	}
}

function insert_terminal($uid, $post,$admin=false){
	global $data;
	$db_query="";$post_data="";
	if($admin){
		if(isset($post['acquirerIDs'])&&$post['acquirerIDs']){$post['acquirerIDs']=implodes(',',$post['acquirerIDs']);}
		
		if(isset($post['select_mcc'])&&$post['select_mcc']){$post['select_mcc']=implodes(',',$post['select_mcc']);}
		
		$db_query="`active`,`acquirerIDs`,`terNO_json_value`,`checkout_theme`,`select_mcc`,";
		$post_data="{$post['active']},'{$post['acquirerIDs']}','{$post['terNO_json_value']}','{$post['checkout_theme']}','{$post['select_mcc']}',";
	}else{
		$db_query="`active`,";
		$post_data="4,";
		
	}
	
	$tarns_alert_email="";
		if(!empty($post['tarns_alert_email'])){$tarns_alert_email=implodes(",",$post['tarns_alert_email']);}
		if(!empty($post['terminal_type'])){$post['terminal_type']=implodes(",",$post['terminal_type']);}
	db_query(
		"INSERT INTO `{$data['DbPrefix']}terminal`(".
		"`merID`,".
		"`ter_name`,`terminal_type`,`return_url`,`webhook_url`,`business_description`,`business_nature`,".$db_query."`bussiness_url`,`tarns_alert_email`,`mer_trans_alert_email`,`dba_brand_name`,`customer_service_no`,`customer_service_email`,`merchant_term_condition_url`,`merchant_refund_policy_url`,`merchant_privacy_policy_url`,`merchant_contact_us_url`,`merchant_logo_url`".
		")VALUES(".
		"'{$uid}',".
		"'{$post['ter_name']}','{$post['terminal_type']}','{$post['return_url']}',".
		"'{$post['webhook_url']}','{$post['business_description']}','{$post['business_nature']}',".$post_data."'{$post['bussiness_url']}','{$tarns_alert_email}','".encrypts_decrypts_emails($post['mer_trans_alert_email'],1)."','{$post['dba_brand_name']}','{$post['customer_service_no']}','".encrypts_decrypts_emails($post['customer_service_email'],1)."','{$post['merchant_term_condition_url']}','{$post['merchant_refund_policy_url']}','{$post['merchant_privacy_policy_url']}','{$post['merchant_contact_us_url']}','{$post['merchant_logo_url']}')",0
	);
	$id=newid();
	$data['c_id']=$id;
	json_log_upd($id,'terminal','Update');	//update json log history
	api_public_key($uid,$id);

	//exit;
}


function update_terminal($id,$post,$admin=false){
	global $data; $q=0; if(isset($_REQUEST['q'])){$q=$_REQUEST['q'];}
	$post_data="";
	
	$select=select_table_details($id,'terminal',0);
	$deleted_bussiness_url=[];
	if($select['deleted_bussiness_url']){
		//echo $select['deleted_bussiness_url'];
		$deleted_bussiness_url=jsondecode($select['deleted_bussiness_url'],1);
		$deleted_bussiness_url;
	}
	if($post['bussiness_url']&&!in_array($post['bussiness_url'],$deleted_bussiness_url)){
		$deleted_bussiness_url[]=$post['bussiness_url'];
		$deleted_bussiness_url=jsonencode($deleted_bussiness_url);
		$post_data.="`deleted_bussiness_url`='{$deleted_bussiness_url}',";
	}
	
	if($admin){
		if(isset($post['acquirerIDs'])&&$post['acquirerIDs']){$post['acquirerIDs']=implodes(',',$post['acquirerIDs']);}
		if(isset($post['select_mcc'])&&$post['select_mcc']){$post['select_mcc']=implodes(',',$post['select_mcc']);}
		$post_data.="`active`='{$post['active']}',`acquirerIDs`='{$post['acquirerIDs']}',`curling_access_key`='{$post['curling_access_key']}',`terNO_json_value`='{$post['terNO_json_value']}',`checkout_theme`='{$post['checkout_theme']}',`select_mcc`='{$post['select_mcc']}',";
	}
	$tarns_alert_email="";
		if(!empty($post['tarns_alert_email'])){$tarns_alert_email=implodes(",",$post['tarns_alert_email']);}
		
		if(!empty($post['terminal_type'])){$post['terminal_type']=implodes(",",$post['terminal_type']);}
	db_query(
		"UPDATE `{$data['DbPrefix']}terminal` SET ".
		"`ter_name`='{$post['ter_name']}',`terminal_type`='{$post['terminal_type']}',".
		"`return_url`='{$post['return_url']}',`webhook_url`='{$post['webhook_url']}',".
		"`business_description`='{$post['business_description']}',`business_nature`='{$post['business_nature']}',".$post_data."`bussiness_url`='{$post['bussiness_url']}',`tarns_alert_email`='{$tarns_alert_email}',`mer_trans_alert_email`='".encrypts_decrypts_emails($post['mer_trans_alert_email'],1)."',`dba_brand_name`='{$post['dba_brand_name']}',`customer_service_no`='{$post['customer_service_no']}',`customer_service_email`='".encrypts_decrypts_emails($post['customer_service_email'],1)."',`merchant_term_condition_url`='{$post['merchant_term_condition_url']}',`merchant_refund_policy_url`='{$post['merchant_refund_policy_url']}',`merchant_privacy_policy_url`='{$post['merchant_privacy_policy_url']}',`merchant_contact_us_url`='{$post['merchant_contact_us_url']}',`merchant_logo_url`='{$post['merchant_logo_url']}'".
		" WHERE `id`='{$id}'",$q
	);

	json_log_upd($id,'terminal','Update');	//update json log history
	if($q==2){
		exit;
	}
}

function update_status_terminal($id, $where_pred){
	global $data;
	db_query(
		"UPDATE `{$data['DbPrefix']}terminal` SET {$where_pred}".
		" WHERE `id`='{$id}'"
	);
	json_log_upd($id,'terminal','Status');	//update json log history
}

function update_sold_terminal($id, $quantity){
	global $data;
	db_query(
		"UPDATE `{$data['DbPrefix']}terminal` SET `XX`='{$quantity}'".
		" WHERE `id`='{$id}'"
	);
}

function api_public_key($uid,$id){
	global $data;
	$encryp=$uid."_".$id."_".date('YmdHis');
	$public_key=encryptres($encryp);
	db_query(
		"UPDATE `{$data['DbPrefix']}terminal` SET `public_key`='{$public_key}'".
		" WHERE `id`='{$id}'"//,true
	);
	return $public_key;
	//echo "<br/>encryp=>".$encryp; echo "<br/>public_key=>".$public_key; exit;
}

function delete_terminal($id){
	global $data;
	db_query(
		"UPDATE `{$data['DbPrefix']}terminal` SET".
		" `active`=2".
		" WHERE `id`='{$id}' ",0
	);
	json_log_upd($id,'terminal','Delete');	//update json log history
}






//FILE2: config_db.do

//fetch all terminal list
// FINAL OLd_NEW: select_products	select_terminals
function select_terminals($uid, $id=0, $single=false, $active=0,$where_pred=''){
	global $data; $prnt=0;
	$q="SELECT * FROM `{$data['DbPrefix']}terminal`".
		" WHERE `merID`='{$uid}' ".$where_pred.
		($id?" AND `id`='{$id}'":'').($active?" AND `active`='{$active}'":'').($single?" LIMIT 1":'');

	$terminals=db_rows($q,$prnt);
	
	$result=array();
	foreach($terminals as $key=>$value){
		foreach($value as $name=>$v){
			$result[$key][$name]=$v;
		}
		
	}
	return $result;
}
//Fetch all detail of a business via terminal id. 
// select_terminal_details
function select_terminal_details($id,$uid=0,$public_key=''){
	global $data;
	$where_pred="";
	if($public_key){
		$where_pred.=" AND `public_key`='{$public_key}' "; //if public_key not empty then create query accordingly
	}
	if($uid){
		$where_pred.=" AND `merID`='{$uid}' "; //if uid not empty then create query accordingly
	}
	//fetch store detail
	$result=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}terminal`".
		" WHERE `id`='{$id}' ".$where_pred." LIMIT 1",0
	);
	
	if(isset($result[0])) return $result[0];	//return
}

//to generate transID based of tid, acquirer and date of seconds
function gen_transID_f($id=0,$acquirer=0,$upd=0){
	global $data; 
	$transID = $acquirer.$id.date("s");
	//update transID 
	if($upd&&$id){
		db_query(
			"UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" SET `transID`='{$transID}'".
			" WHERE `id`='{$id}'",0
		);
	}
	return $transID;
}


//Calculate chargeback fee of a merchant. And define riskratio range as per chargeback percentage.
function get_riskratio_trans($uid,$account_type=0,$card=true,$dateRange=''){
	global $data; 
	$results=array();
	$results['uid']=$uid;$results['account_type']=$account_type;
	$results['risk_type']="All Accounts";
	
	//Initialized variables with null or empty
	$account_type_check	="";
	$account_type_card	="";

	$charge_back_fee_1	="";
	$charge_back_fee_2	="";
	$charge_back_fee_3	="";
	
	$status_return=" `trans_status` IN (5)  ";	//status 5 means chargeback
	$account_type_whr = " AND ( `trans_type` IN (11) )";
	
	if(empty($account_type)){	//if account type is null or empty then fetch data from account table by id
		$mer_settings=mer_settings($uid);
		foreach($mer_settings as $key=>$value){
			$account_type_card=$value['acquirer_id'];
		}
		if($account_type_card){
			$account_type=$account_type_card;
		}
	}
	
	

	if($account_type){
		$accounts_info=mer_settings($uid, 0, true, $account_type);	//fetch acquirer data 
		
		if($accounts_info){
			$charge_back_fee_1=$accounts_info[0]['charge_back_fee_1'];	//charge back fee 1
			$charge_back_fee_2=$accounts_info[0]['charge_back_fee_2'];	//charge back fee 2
			$charge_back_fee_3=$accounts_info[0]['charge_back_fee_3'];	//charge back fee 3
		}
		elseif( !isset($accounts_info) || empty($accounts_info) ){	//if data not avaiable in acquirer then fetch from bank gateway
			$bgt=select_tablef(" `acquirer_id` IN ({$account_type}) ",'acquirer_table',0,1,'`mer_setting_json`');
			$accounts=jsondecode(@$bgt['mer_setting_json'],1);	//acquirer json
			
			if(@$accounts['charge_back_fee_1']) $charge_back_fee_1=@$accounts['charge_back_fee_1'];		//charge back fee 1
			if(@$accounts['charge_back_fee_2']) $charge_back_fee_2=@$accounts['charge_back_fee_2'];		//charge back fee 2
			if(@$accounts['charge_back_fee_3']) $charge_back_fee_3=@$accounts['charge_back_fee_3'];	//charge back fee 3
			
			if(isset($_GET['dtest'])){
				echo "<br/><br/>charge_back_fee_1=> ".$charge_back_fee_1;
				echo "<br/><br/>charge_back_fee_2=> ".$charge_back_fee_2;
				echo "<br/><br/>charge_back_fee_3=> ".$charge_back_fee_3."<br/><br/>";
				print_r($accounts);
				echo "<br/><br/>";
			}
		}
		
		$card=true;$results['risk_type']="Chargeback Ratio";	//chargeback for online payment
		$account_type_whr = " AND ( `trans_type` IN (11) ) ";
	}
	
	if($card==false){
		$status_return=" `trans_status` IN (6)  ";	//check returned 
	}
	
	//$results['account_type']=$account_type;$results['status_return']=$status_return; $results['account_type_whr']=$account_type_whr;

	//total chargeback transactions
	$qry_tr_returns = db_rows("SELECT COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` WHERE (`merID`='{$uid}' ) AND (".$status_return.") ".$account_type_whr.$dateRange." LIMIT 1",0);
	if($qry_tr_returns){
		$results['return_count']=$qry_tr_returns[0]['count'];
	}

	//total success/complete transactions
	$qry_tr_completeds = db_rows("SELECT COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` WHERE (`merID`='{$uid}' ) AND (`trans_status` IN (1) ) ".$account_type_whr.$dateRange." LIMIT 1",0);
	if($qry_tr_completeds){
		$results['completed_count']=$qry_tr_completeds[0]['count'];
	}

	//total settled transactions USE INDEX (payin_2) 
	$qry_tr_settleds = db_rows("SELECT COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` WHERE (`merID`='{$uid}' ) AND (`trans_status` IN (4)) ".$account_type_whr.$dateRange." LIMIT 1",0);
	if($qry_tr_settleds){
		$results['settled_count']=$qry_tr_settleds[0]['count'];
	}
	
	$micro_count=0;
	
	//total transactions
	$com_setld=(@$results['completed_count']+@$results['settled_count']+@$micro_count);
	$total_ratio=0;
	if($com_setld>0 && $results['return_count']){
		$total_ratio=(($results['return_count']*100)/($com_setld));		//calculate total ratio
	}
	
	$results['completed_and_settled']=$com_setld;	//total success and settle transactions
	
	$results['total_ratio']=number_formatf2($total_ratio);	//converted into defined number format
	//$results['total_ratio']=number_formatf($total_ratio);
	//$results['total_ratio']=($total_ratio);
	$results['charge_back_fee']=0;
	
	//if($card==true)
	{ // in case of card
		if($results['total_ratio']>=0&&$results['total_ratio']<=0.50){$results['lead_class']="lead_green";$results['lead_color']="#3cd632";$results['charge_back_fee']=$charge_back_fee_1;}
		elseif($results['total_ratio']>0.50 && $results['total_ratio']<=1){$results['lead_class']="lead_red";$results['lead_color']="#DA4453";$results['charge_back_fee']=$charge_back_fee_2;}
		elseif($results['total_ratio']>1 ){$results['lead_class']="lead_darkred";$results['lead_color']="#ab0c0c";$results['charge_back_fee']=$charge_back_fee_3;}
	}	
	
	//$results['account_type']=$account_type;
	return $results;	//return
}


#####start-df##################################################

define("CURRENT_TIME", date("Y-m-d H:i:s"));//set current date & time in constant variable for further use
define("TODAY_DATE_ONLY", date("Y-m-d"));	//set today date in constant variable for further use

$data['CURRENT_TIME']	= CURRENT_TIME;		//set current time into $data array
$data['TODAY_DATE_ONLY']= TODAY_DATE_ONLY;	//set today date into $data array

//array for clients type
$data['MEMBER_TYPE']=array("0"=>"suspended",
	"1"=>"active",
	"2"=>"closed"
);

//array for define Indian bank four char code as ISO
$data['AVAILABLE_BANKLIST']=array("UTIB"=>"Axis Bank",
	"BDBL"=>"Bandhan Bank",
	"BARB"=>"Bank of Baroda",
	"BKID"=>"Bank of India",
	"MAHB"=>"Bank of Maharashtra",
	"CNRB"=>"Canara Bank",
	"CBIN"=>"Central Bank of India",
	"CITI"=>"Citibank India",
	"CIUB"=>"City Union Bank",
	"CSBK"=>"CSB Bank",
	"DCBL"=>"DCB Bank",
	"DEUT"=>"Deutsche Bank",
	"DLXB"=>"Dhanlaxmi Bank",
	"FDRL"=>"Federal Bank",
	"HDFC"=>"HDFC Bank",
	"HSBC"=>"HSBC Bank India",
	"ICIC"=>"ICICI Bank",
	"IDBI"=>"IDBI Bank",
	"IDFC"=>"IDFC First Bank",
	"IDIB"=>"Indian Bank",
	"IOBA"=>"Indian Overseas Bank",
	"INDB"=>"IndusInd Bank",
	"JAKA"=>"Jammu & Kashmir Bank",
	"KARB"=>"Karnataka Bank",
	"KVBL"=>"Karur Vysya Bank",
	"KKBK"=>"Kotak Mahindra Bank",
	"NTBL"=>"Nainital Bank",
	"PSIB"=>"Punjab and Sind Bank",
	"PUNB"=>"Punjab National Bank",
	"RATN"=>"RBL Bank",
	"SIBL"=>"South Indian Bank",
	"SCBL"=>"Standard Chartered Bank",
	"SBIN"=>"State Bank of India",
	"TMBL"=>"Tamilnad Mercantile Bank",
	"UCBA"=>"UCO Bank",
	"UBIN"=>"Union Bank of India",
	"YESB"=>"Yes Bank"
);

$data['SEARCH_KEYNAME']=array(
	"1"=>"Transaction ID",
	"2"=>"Customer Name",
	"3"=>"Email for Transaction",
	"4"=>"Price for Transaction",
	"5"=>"Phone for Transaction",
	"6"=>"routing_aba",
	"7"=>"bankaccount",
	"8"=>"Bank Reference Number",
	"9"=>"Go to Merchant Profile",
	"10"=>"Go to Merchant Transactions",
	"11"=>"address for Transactions",
	"12"=>"city for Transactions",
	"13"=>"state for Transactions",
	"14"=>"country for Transactions",
	"15"=>"zip for Transactions",
	"16"=>"product_name for Transactions",
	"17"=>"support_note for Transactions",
	"18"=>"bill_ip for Transactions",
	"19"=>"remark_status for Transactions",
	"20"=>"payable_amt_of_txn for Transactions",
	"31"=>"Custom Search for MailGun Email",
	"32"=>"Custom Search for Message",
	"82"=>"Transaction-Bank Reason",
	"83"=>"Tran.M.OrderId",
	"91"=>"Go to Merchant Auto Login",
	"115"=>"store_id",
	"223"=>"settelement_date and status 0, 9, and 10",
	"224"=>"status 0, 9, 10 and payable_amt_of_txn IS NULL",
	"311"=>"Email for Merchants",
	"312"=>"Website ID",
	"313"=>"Website in Website",
	"314"=>"DBA/Brand Name in Website",
	"315"=>"Email: T. Notification/CSE"
);
//define status array for payout system
$data['SendFundStatus']=array(
	0=>'Pending',
	1=>'Success',
	2=>'Failed',
	3=>'Processing',
	9=>'Test',
	10=>'Scrubbed'
);

//define BeneficiaryStatus for payout system
$data['BeneficiaryStatus']=array(
	0=>'Pending',
	1=>'Approved',
	2=>'Blocked',
	3=>'Under Process',
);

//define array for payout type
$data['payoutProduct']=array(
	1=>'Payout',
	2=>'Add Fund',
	3=>'Send Fund',
);

//define table name with email field name for encyption
$data['define_table_list'] = array(
	1	=> array("transactions","bill_email"),
	2	=> array("mer_setting","customer_service_email"),
	21	=> array("mer_setting","transaction_notification_email"),
	3	=> array("email_details","email_to"),
	31	=> array("email_details","email_from"),
	4	=> array("clientid_table","registered_email"),
	41	=> array("clientid_table","service_email"),
	5	=> array("clientid_emails","email"),
	6	=> array("subadmin","customer_service_email"),
	61	=> array("subadmin","customer_service_email"),
	7	=> array("terminal","mer_trans_alert_email"),
	71	=> array("terminal","customer_service_email"),
);

//function for check mobile validation
function isMobileValid($mob,$isd='')
{
	if(empty($mob)) return false;

	$mob = $isd.substr($mob, -10);	//cut mobile number last 10 digit and add ISD code if exists
	return $mob;
}

//function for compare two dates
function date_comparison($main_date, $date1, $date2='', $comp_type="mature")
{
	$main_date = fetchFormattedDate($main_date);
	if($comp_type=="mature")
	{
		if(!empty($date1) && !empty($date2))
		{
			if($main_date>=$date1 && $main_date<=$date2) return true;
			else return false;
		}
		else{
			if($main_date<=$date1) return true;
			else return false;
		}
	}elseif($comp_type=="immature")
	{
		if(!empty($date1) && !empty($date2))
		{
			if(!($main_date>=$date1 && $main_date<=$date2)) return true;
			else return false;
		}
		else{
			if($main_date>$date1) return true;
			else return false;
		}
	}
	return false;
}





//The function return total number of records of a table with specified condition, default fetch all records
function getTotalRecords($tbl, $where_clause=1, $field="`id`"){
	global $data;
	$qprint=0;
	if(isset($_GET['qp'])){
		$qprint=1;
		echo "<hr/><==getTotalRecords==><hr/>";
	}
	$result=db_rows(
		"SELECT $field FROM `{$data['DbPrefix']}{$tbl}`".
		" WHERE $where_clause",$qprint
	);
	return sizeof($result);
}

//get only numeric value include 0-9, +,-, and dot (.)
function getNumericValue($value)
{
	$tmpValue = "";
	$value	= trim($value);
	$length	= strlen($value);

	$minus=$plus=$dot=0;
	if($length>0)
	{
		$i=0;
		$chars = str_split($value);
		foreach($chars as $val){
			if($val >= 0 && $val <= 9){
				$tmpValue .= $val;
			}
			elseif($val=='-' || $val=='+' || $val=='.')		
			{
				if($val=='-'&&$minus=='0'&&$i=='0')
				{
					$tmpValue .= $val;
					$minus=1;
				}
				elseif($val=='+'&&$plus=='0'&&$i=='0')
				{
					$tmpValue .= $val;
					$plus=1;
				}
				elseif($val=='.'&&$dot=='0'&&$i<($length-1))
				{
					$tmpValue .= $val;
					$dot=1;
				}
			}
			$i++;
		}
	}
	if($tmpValue=='-')		$tmpValue = 0;
	if($tmpValue=='+')		$tmpValue = 0;
	if($tmpValue=='.')		$tmpValue = 0;
	if(empty($tmpValue))	$tmpValue = 0;

	return $tmpValue;
}

//function for return date in specify format.
function fetchFormattedDate($date, $format="Y-m-d")	
{
	$formattedDate = "";
	
	//echo "<br/>fetchFormattedDate=>".$date;
	
	if(empty($date) || $date=='0000-00-00') return;	// if date is empty or 0000-00-00 then return null

	$formattedDate = date("$format", strtotime($date));

	return $formattedDate;
}

//function for return date in specify format.
function fetchFormattedDate_f($date,$format="Ymd")	
{
	$formattedDate = "";
	//echo "<br/>fetchFormattedDate2=>".$date;
	if(empty($date) || $date=='0000-00-00') return;	// if date is empty or 0000-00-00 then return null
	$formattedDate = date("$format", strtotime($date));
	return $formattedDate;
}




function create_header($token){		// THIS FUNCTION FOR CASHFREE - Header for reuqest post
	global $header;
	$headers = $header;
	if(!is_null($token)){

		array_push($headers, 'Authorization: Bearer '.$token);
	}
	return $headers;
}

function post_helper($action, $data, $token){		// THIS FUNCTION FOR CASHFREE

	global $baseurl, $urls, $cp,$actionurl,$is_mer;
	$finalUrl = $baseurl.$urls[$action];
	$headers = create_header($token);


	//$cp=1;


	if($cp){
		echo "<br />post_helper function addBeneficiary==><br />";
		print_r($data);
	}

	$ch = curl_init();
	curl_setopt($ch, CURLOPT_POST, 1);
	curl_setopt($ch, CURLOPT_URL, $finalUrl);
	curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	if(!is_null($data)) curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data)); 

	$r = curl_exec($ch);

	if(curl_errno($ch)){
		print('error in posting');
		print(curl_error($ch));
		die();
	}
	curl_close($ch);
	$rObj = json_decode($r, true);

	//cmn
	if($cp){
		echo "<br />post_helper function CASHFREE==><br />";
		print_r($rObj);
	}

//	if($rObj['status'] != 'SUCCESS' || $rObj['subCode'] != '200') throw new Exception('incorrect response: '.$rObj['message']);
	//return $rObj;

	if($rObj['status'] == 'SUCCESS' || $rObj['subCode'] == '200' || $rObj['subCode'] == '201')
		return $rObj;

	if($is_mer)
	{
		$_SESSION['action_error']=$rObj["message"];
		header("Location:{$actionurl}");exit;
	}
}

function process_request($finalUrl, $token){		// THIS FUNCTION FOR CASHFREE
	$headers = create_header($token);

	global $actionurl,$is_mer;

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

	$rObj = json_decode($r, true);


//cmn
//	echo "finalUrl=$finalUrl<br />token=$token<br />getBeneficiary==>response<hr>";
//	print_r($rObj);
	
	
	//if($rObj['status'] != 'SUCCESS' || $rObj['subCode'] != '200') throw new Exception('incorrect response: '.$rObj['message']);
	//	return $rObj;

	if($rObj['status'] == 'SUCCESS' || $rObj['subCode'] == '200' || $rObj['subCode'] == '201')
		return $rObj;

	if($is_mer)
	{
		$msg = trim($rObj["message"]);
		
		if($rObj['subCode']=="404" || $msg=="Beneficiary does not exist") return;
	
		$_SESSION['action_error']=$rObj['subCode']." ".$rObj["message"];
		header("Location:{$actionurl}");exit;
	}
}
function getBeneficiary($token){		// THIS FUNCTION FOR CASHFREE
	global $baseurl, $urls, $beneficiary;
	$beneId		= $beneficiary['beneId'];
	$finalUrl	= $baseurl.$urls['getBene'].$beneId;
	$response	= process_request($finalUrl, $token);
	
	//cmn
	//echo "beneId=$beneId<br />getBeneficiary==>response<hr>";
	//print_r($response);
	
	if($response) return true;
	else return false;
}

#add beneficiary
function addBeneficiary($token){		// THIS FUNCTION FOR CASHFREE

	global $beneficiary,$cp;

	$cp=0;
	//cmn
	if($cp){
		echo "<br />beneficiary post CASHFREE ==><br />";
		print_r($beneficiary);
	}
	
	$response = post_helper('addBene', $beneficiary, $token);

	//cmn
	if($cp)
	{
		echo "<br />beneficiary response CASHFREE ==><br />";
		print_r($response);
	}
	if($response) return true;
	else return false;
}

function affected_rows($rows, $msg="")
{
	if($rows)
	{
		if(empty($msg)) 	// if $msg is empty then show default message as given below
		{
			$_SESSION['action_success']="<b>$rows</b> Record Updated Successfully!!!";
		}
		else
		{
			$_SESSION['action_success']=$msg;	//show dynamic message if any changes in DB
		}
	}
	else
	{
		$_SESSION['action_success']='No any changes';	// if no any affected or no any changes in DB
	}
}

//func for fetch only numeric value (number) from a string
function stringToNumber($value)
{
	$tmpValue = "";				//Initialized the variable tmpValue with null
	$value	= trim($value);		//remove extra blank space from left and right
	$length	= strlen($value);	//calculate the lenght (number of char) of a value

	$dot = $minus = $plus = false;	//Initialized the variable of dot, minus and plus with default false
	
	if($length>0)	//check length of string
	{
		$chars = str_split($value);	//split string to characters
		$i=0;
		foreach($chars as $val)		//execute char via char
		{
			if($val>='0' && $val<='9')	//check value, if between 0-9, then added in tmpValue
			{
				$tmpValue .= $val;
			}
			elseif($val=='.' && $dot==false && $i<($length-1))	//check if char is DOT(.), if yes then it should not be last character, then add in tmpValue and change $dot value to true, means only one dot allow in numeric value
			{ 
				$tmpValue .= $val;
				$dot=true;
			}
			elseif($val=='-' && $minus==false && $i==0)	//check if char is minus(-) symbol, if yes then it must be first character, then add in tmpValue and change $minus value to true, means only one '-' allow in numeric value
			{ 
				$tmpValue .= $val;
				$minus=true;
			}
			elseif($val=='+' && $plus==false && $i==0)	//check if char is plus(+) symbol, if yes then it must be first character, then add in tmpValue and change $plus value to true, means only one '+' allow in numeric value
			{ 
				$tmpValue .= $val;
				$plus=true;
			}
			$i++;
		}
	}
	if($tmpValue=='-')		$tmpValue = 0;	//check if only minus (-) symbol in string then return ZERO(0)
	if($tmpValue=='+')		$tmpValue = 0;	//check if only plus (+) symbol in string then return ZERO(0)
	if($tmpValue=='.')		$tmpValue = 0;	//check if only dot (.) symbol in string then return ZERO(0)
	if(empty($tmpValue))	$tmpValue = 0;	//check if tmpValue is empty then return ZERO(0)

	return $tmpValue;	//return numeric value
}

//print array recursively 
function display_nested_array($results)
{
	if(is_array($results)){ 
		foreach($results as $key=>$value){
			if(!is_array($value) && !empty($value)){
				echo "<div class='col-sm-4 text-break fw-bold $key'>".create_title($key)."</div>
				      <div class='col-sm-8 text-break val'>".$value."</div>";
			}
			
			if(is_array($value)){ //if value is array then again call same function recursively
				echo "<div class='col-sm-12 my-2 px-2 rounded text-light blue-area fw-bold $key'>".create_title($key)."</div>";
				display_nested_array($value);
			}
		}
	}
}
function encrypts_decrypts_emails($emailId, $type, $mass=false, $email_det=array())	//type 1,3 for encrypts while type 2 for decrypts
{
	global $data;
	
	if($emailId){
		if($type==1||$type==3) {	//section for encryption
			$emailId_lo = strtolower(trim($emailId));	//change email into lower chars
			if(filter_var($emailId_lo, FILTER_VALIDATE_EMAIL) || isset($data['skipemailvalidation']) || $type==3) {
			
				if(strpos($emailId_lo,'decrypt')!==false){	//check emailId already encrypted or not
					
				}else{
					//$emailId = exp_encrypts256($emailId_lo);
					$emailId = encode_f($emailId_lo);	//encrypt emailId
				}
				
			}
		//	echo 'fail';exit;
			return $emailId;
		}
		elseif($type==2) {
			if(strpos($emailId,'decrypt')!==false){	//check email id encrypted or not, if yes the decrypt
				//$emailId = exp_decrypts256(stripslashes($emailId));
				$emailId = decode_f(stripslashes($emailId));	//decrypt email
			}
			if($mass==true){	//if mass is true the show emailId with mass (start and end chars display)
				$emailId=prntext(mask_email($emailId));

				//check login with admin or view_mask_email roll define then view full email id
				if(((isset($_SESSION['login_adm']))||(isset($_SESSION['view_mask_email'])&&$_SESSION['view_mask_email']==1)) && $email_det)
				{
					$det_list = "tbl=".$email_det[0]."&tblid=".$email_det[1];
					
					$emailId = '<a onClick="ajaxf1(this, \''.$data['Admins'].'/check-email'.$data['ex'].'?'.$det_list.'\', 2, 1,3);" class="nomid">'.$emailId.'</a>';
				
				}
			}
			return strtolower($emailId);	//return encrypted / decrypted email id
		}
	}
	return;
}
//function to use fetch clients email id from clients_emails table
function getclientsEmailId($id)
{
	global $data;
	$result=db_rows(
		"SELECT `email` FROM `{$data['DbPrefix']}clientid_emails`".
		" WHERE `id`='{$id}'",0
	);
	return $result[0]['email'];
}
//get only encrpted value from a string
function get_encrypted_value($value)
{
	$str = substr($value, strpos($value, '":"')+3);
	$str = substr($str, 0, strpos($str, '","key'));

	return $str;
}
//function to remove extra comma from string if exists two consecutive commas
function remove_extra_comma($str)
{
	if($str)
	{
		while(strpos($str,',,')!==false)
		{
			$str = str_replace(',,', ',',$str);
		}
	}
	return $str;
}

//function to fetch / execute all black list detail
function get_blacklist_details($uid, $action='list', $post=array()){
	global $data;

	$limit = "";
	if(isset($data['MaxRowsByPage'])&&isset($data['startPage']))
	{
		$start = ($data['startPage']-1)*$data['MaxRowsByPage'];	//set start rows of a page
		$limit = " LIMIT $start, ".$data['MaxRowsByPage'];		//set limit of per page
	}

	$qprint=0;
	if(isset($_REQUEST['qp'])) $qprint=1;

	if(!empty($uid)) $q = "`clientid`='{$uid}' AND "; else $q="";	//make query

	if(isset($_GET['key_name'])&&$_GET['key_name'])
	{
		$data['key_name'] = $_GET['key_name'];
		$q .= "`blacklist_type`='{$data['key_name']}' AND ";	//make query
	}
	if(isset($_GET['key'])&&$_GET['key'])
	{
		$data['key'] = $_GET['key'];
		$q .= "`blacklist_value` LIKE '%{$data['key']}%' AND ";	//make query
	}

	if($action=='list')	//if action is list then fetch full active black list data
	{
		if($limit)
		{
			$countQ=db_rows(
				"SELECT count(id) AS count FROM `{$data['DbPrefix']}blacklist_data`".
				" WHERE $q `status`='1' ORDER BY blacklist_type LIMIT 1",$qprint
			);
			$data['total_record'] = $countQ[0]['count'];
		}

		$result=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}blacklist_data`".
			" WHERE $q `status`='1' ORDER BY blacklist_type".$limit,$qprint
		);
		return $result;
	}
	elseif($action=='list_del')	//if action is list_del, then fetch all previous active blacklist data
	{
		if($limit)
		{
			$countQ=db_rows(
				"SELECT count(id) AS count FROM `{$data['DbPrefix']}blacklist_data`".
				" WHERE $q `status`='2' ORDER BY blacklist_type LIMIT 1",$qprint
			);
			$data['total_record'] = $countQ[0]['count'];
		}
		$result=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}blacklist_data`".
			" WHERE $q `status`='2' ORDER BY blacklist_type".$limit,$qprint
		);
		return $result;
	}
	elseif($action=='list_all')	//if action is list all, means fetch all data
	{
		if(!empty($uid)) $q = "WHERE `clientid`='{$uid}' "; else $q="";

		if($limit)
		{
			$countQ=db_rows(
				"SELECT count(id) AS count FROM `{$data['DbPrefix']}blacklist_data`".
				" $q ORDER BY blacklist_type LIMIT 1",$qprint
			);
			$data['total_record'] = $countQ[0]['count'];
		}

		$result=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}blacklist_data`".
			" $q ORDER BY blacklist_type".$limit,$qprint
		);
		return $result;
	}
	elseif($action=='addnew')	//if action is addnew, then add new entry in blacklist table
	{
		//if(empty($uid)) $uid = 0;
		//if merchant selected then explode via comma (,)
		if(!empty($uid)) { $post['merchant_list_id'] = explode(",",$uid);}

		$blacklist_type	= trim($post['blacklist_type']);
		$blacklist_value= trim($post['blacklist_value']);
		$remarks		= trim($post['remarks']);
		$source			= $post['source'];

		if(isset($post['source'])&&$post['source']=='admin' && empty($post['merchant_list_id'])){
			$post['merchant_list_id'] = explode(",",0);
		}
		//echo $count_merchant = count($post['merchant_list_id']);exit;
		
		foreach ($post['merchant_list_id'] as $value) {
			$uid=$value;	//user merchant id as uid
	
			$result=db_query(
				"INSERT INTO `{$data['DbPrefix']}blacklist_data`(".
				"`clientid`,`blacklist_type`,`blacklist_value`,`remarks`,`created_date`".
				")VALUES(".
				"'{$uid}','{$blacklist_type}','{$blacklist_value}','{$remarks}','{$data['CURRENT_TIME']}'".
				")",$qprint
			);
			$newid=newid();	//fetch newely added id
			json_log_upd($newid,'blacklist_data','update'); // update json log history
			if ($newid){
				if($blacklist_type=="IP") createiplist_file();	//if blacklist type is IP the rewrite .htaccess
				//return 'SUCCESS';
			} 
			else {
				//check duplicate entry
				$chk_record=db_rows(
					"SELECT * FROM `{$data['DbPrefix']}blacklist_data`".
					" WHERE `clientid`='{$uid}' AND `blacklist_type`='{$blacklist_type}' AND `blacklist_value` ='{$blacklist_value}' LIMIT 1",$qprint
				);
				$blkid		= $chk_record[0]['id'];
				$blkstatus	= $chk_record[0]['status'];
				if($blkstatus==1){
					$result = "Records already exists";
				}
				else {
					$sqlStmt = "UPDATE `{$data['DbPrefix']}blacklist_data` SET `remarks` ='{$remarks}', `status`='1' WHERE `id`='{$blkid}'";
					db_query($sqlStmt,$qprint);
					
					$result = "SUCCESS";
				}
			}
		}
		return $result;
	}
	elseif($action=='delete')	//if action is delete then change status is 2, not permanently deleted
	{
		$delrec = 0;
		if(isset($post['choice']))
		{
			if(is_array($post['choice']))
			{
				foreach ($post['choice'] as $key => $val)
				{
					$sqlStmt = "UPDATE `{$data['DbPrefix']}blacklist_data` SET `status`='2' WHERE `id`='{$val}'";
					db_query($sqlStmt,$qprint);
					json_log_upd($val,'blacklist_data','Delete'); // update json log history
					if($data['affected_rows']) $delrec++;
				}
			}
			else
			{
				$sqlStmt = "UPDATE `{$data['DbPrefix']}blacklist_data` SET `status`='2' WHERE `id`='{$post['choice']}'";
				db_query($sqlStmt,$qprint);
				json_log_upd($post['choice'],'blacklist_data','Delete'); // update json log history
				if($data['affected_rows']) $delrec++;
			}
		}
		if($delrec) createiplist_file();	// rewrite .htaccess
		return $delrec;
	}
	return;
}
//function to check scrubbed via blacklist
function blacklist_scrubbed($uid)
{
	global $data,$post;
	
	$tran_db=false; 
	$scrubbed_msg="";

	//Initialized variables with null or empty
	$client_ip = $client_ccno = $client_email = $client_country = $client_city = $client_phone = $client_vpa = "";

	//client bill_ip
	if(isset($_SESSION['client_ip'])&&$_SESSION['client_ip'])	$client_ip		= $_SESSION['client_ip'];
	//credit card
	if(isset($post['ccno'])&&$post['ccno'])						$client_ccno	= $post['ccno'];
	//email id
	if(isset($post['email'])&&$post['email'])					$client_email	= $post['email'];
	//country
	if(isset($post['bill_country'])&&$post['bill_country'])		$client_country	= $post['bill_country'];
	//city
	if(isset($post['bill_city'])&&$post['bill_city'])			$client_city	= $post['bill_city'];
	//phone/mobile
	if(isset($post['bill_phone'])&&$post['bill_phone'])			$client_phone	= $post['bill_phone'];

	//upi address
	if(isset($post['upi_vpa'])&&$post['upi_vpa'])				$client_vpa		= $post['upi_vpa'];
	elseif(isset($post['upi_address'])&&$post['upi_address'])	$client_vpa		= $post['upi_address'];

	//fetch black list
	//$blackListData = get_blacklist_details($uid);
	
	//fetch blacklist data 
	$blackListData=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}blacklist_data`".
		" WHERE `clientid` IN ('0','$uid') AND `status`='1' ORDER BY blacklist_type",0
	);

	if($blackListData)
	{
		foreach ($blackListData as $key => $val) {
			$blacklist_type	= $val['blacklist_type'];	//black list type - eg. bill_ip, city, email etc
			$blacklist_value= $val['blacklist_value'];

			//check IP address
			if($blacklist_type=="IP"&&$client_ip)
			{
				if($client_ip==$blacklist_value)	//check via IP
				{
					$scrubbed_msg = "This IP address is black listed";
					$tran_db=true;
					break;
				}
			}
			//check Country address
			if($blacklist_type=="Country"&&$client_country)
			{
				if($client_country==$blacklist_value)	//check via Country
				{
					$scrubbed_msg = "This COUNTRY is black listed";
					$tran_db=true;
					break;
				}
			}
			//check CITY address
			if($blacklist_type=="City"&&$client_city)
			{
				if($client_city==$blacklist_value)		//check via City
				{
					$scrubbed_msg = "This CITY is black listed";
					$tran_db=true;
					break;
				}
			}
			//check EMAIL address
			if($blacklist_type=="Email"&&$client_email)
			{
				if($client_email==$blacklist_value)		//check via client email
				{
					$scrubbed_msg = "This EMAIL is black listed";
					$tran_db=true;
					break;
				}
			}
			//check CARD NUMBER address
			if($blacklist_type=="Card Number"&&$client_ccno)
			{
				if($client_ccno==$blacklist_value)		//check via Credit Card
				{
					$scrubbed_msg = "This CARD is black listed";
					$tran_db=true;
					break;
				}
			}
			//check UPI/VPA address
			if($blacklist_type=="VPA"&&$client_vpa)
			{
				if($client_vpa==$blacklist_value)		//check via UPA
				{
					$scrubbed_msg = "This VPA address is black listed";
					$tran_db=true;
					break;
				}
			}
			//check MOBILE address
			if($blacklist_type=="Mobile"&&$client_phone)
			{
				if($client_phone==$blacklist_value)		//check via Mobile/phone
				{
					$scrubbed_msg = "This PHONE/MOBILE number is black listed";
					$tran_db=true;
					break;
				}
			}
		}
	}
	
	return array($tran_db,$scrubbed_msg);
}

//function to use create .htaacess files with blocked IPs
function createiplist_file()
{
	global $data;

	$qprint=0;
	if(isset($_REQUEST['qp'])) $qprint=1;
	
	$result=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}blacklist_data`".
		" WHERE `status`='1' ORDER BY blacklist_type",$qprint
	);
	
	$iplist = '<? $blkiplist="';
	foreach ($result as $key => $val) {
		$blacklist_type	= $val['blacklist_type'];
		$blacklist_value= $val['blacklist_value'];
		if($blacklist_type=="IP"&&$blacklist_value)
		{
			$iplist .= "\t\tDeny from ".$blacklist_value."\n";
		}
	}
	$iplist .= '";?>';

	$folder=$data['Path'].'/log/';

	$file=@fopen($folder."iplist".$data['iex'], "w");

	if($file){
		@fwrite($file, $iplist); 
		@fclose($file);
		use_curl($data['Host']."/create_htaccess".$data['ex']);
	}
}

//function to use show note system
function print_note_system($string)
{
	if(empty($string)) return;

	$strarr = explode("<div class=rmk_date>", trim($string));
	
	
	$newstr = "";
	for($i=0;$i<count($strarr);$i++)
	{
		//$str = strip_tags($strarr[$i]);
		$str = trim($strarr[$i]);

		if($str)
		{
			$date	= substr($str,0,22);
			$str	= substr($str,22);
			
			$dateArr = explode(" ", trim($date));
			
			$dd=substr($dateArr[0],0,2);
			$mm=substr($dateArr[0],3,2);
			$yy=substr($dateArr[0],6,4);
	
			if(is_numeric($dd)&&is_numeric($mm)&&is_numeric($yy))
			{
				$date = "$yy-$mm-$dd ".$dateArr[1]." ".$dateArr[2];
			
				$new_date= prndate($date);
				$newstr .='<div class="rmk_row"><div class="rmk_date" title="'.$date.'">'.$new_date.$str.'</div>';
			}
		}
	}
	return $newstr;
	
}



//function to used for return currency with specific color code, if value is negative the red, else green
function fetch_amtwithcurr($summ, $Currency, $splus=true,$curname=0){
	if($summ)
	{
		if($summ<0)$color='red';else $color='green';	//check $summ, if negative the red, else green
		if($curname)
		{
			return
				"<font color='{$color}'>".
				get_currency($Currency,$curname).' '.($summ>=0?($splus?'+':''):'-').prnsumm($summ).
				'</font>'
			;
		}
		else{
			return
				"<font color='{$color}'>".
				($summ>=0?($splus?'+':''):'-').get_currency($Currency,$curname).prnsumm($summ).
				'</font>'
			;
		}
	}
	else return '--';
}

//function to generate transaction id
function create_transID($field1='', $field2='')
{
	$acquirer_ref = '';
	
	if($field1) $acquirer_ref = $field1;
	if($field2) $acquirer_ref .= $field2;
	//$acquirer_ref .= date('Ymd').'_'.time();
	$acquirer_ref .= time();
	
	return $acquirer_ref;
}

//function to encode string with AES-256-CBC (base64_encode)
function data_encode_sha256($string,$secret_key,$payout_token) {
	$output = false;
	$encrypt_method = "AES-256-CBC";
	$iv = substr(hash('sha256', $payout_token), 0, 16);
	$output = rtrim(strtr(base64_encode(openssl_encrypt($string, $encrypt_method, $secret_key, 0, $iv)), '+/', '-_'), '=');
	return $output;
}

//function to decode string with AES-256-CBC (base64_encode)
function data_decode_sha256($string,$secret_key,$payout_token) {
	$output = false;
	$encrypt_method = "AES-256-CBC";
	$iv = substr( hash( 'sha256', $payout_token ), 0, 16 );
	$output = openssl_decrypt( base64_decode( $string ), $encrypt_method, $secret_key, 0, $iv );
	return $output;
}

function decode_json_acc($json,$acc=0)
{
	$txn_array = json_decode($json,1);

    $acc_no=(isset($acc_no)&&$acc_no?$acc_no:'');
	if(isset($txn_array['baccount'])&&$txn_array['baccount']){
		$txn_array['baccount']=decrypts_string(json_encode($txn_array['baccount']),0);
		$acc_no="A/c.: ".$txn_array['baccount'];
	}
	if(isset($txn_array['coins_address'])&&$txn_array['coins_address']){
		$txn_array['coins_address']=decrypts_string(json_encode($txn_array['coins_address']),0);
		$acc_no="Address: ".$txn_array['coins_address'];
	}
	if($acc){
		return $acc_no;
	}

	$json = json_encode($txn_array);
	//return $txn_array['baccount'];
	return $json;
}

function create_nickname($str1,$str2)
{
	$string = substr($str1,0,4).substr($str2,-3);
	
	$string = str_replace(' ', '', $string); // Removes all blank spaces.
	
	return preg_replace("/[^a-zA-Z0-9]+/", "", $string);// Removes special chars.
}

//function for calculate MDR amount -  (12-10-2022)
function calculate_mdr_amount($amount, $accounts, $cardType='')
{
	$mdr_rate=0;

	if($cardType=='visa'&&$accounts['mdr_visa_rate'])	// check if card type is visa and visa rate exists then calculate on mdr_visa_rate 
	{
		$mdr_rate=stringToNumber($accounts['mdr_visa_rate']);
	}
	elseif($cardType=='mastercard'&&$accounts['mdr_mc_rate'])	// check if card type is mastercard and mastercard rate exists then calculate on mdr_mc_rate 
	{
		$mdr_rate=$accounts['mdr_mc_rate'];
	}
	elseif($cardType=='amex'&&$accounts['mdr_amex_rate'])	// check if card type is amex and amex rate exists then calculate on mdr_amex_rate 
	{
		$mdr_rate=$accounts['mdr_amex_rate'];
	}
	elseif($cardType=='jcb'&&$accounts['mdr_jcb_rate'])	// check if card type is jcb and jcb rate exists then calculate on mdr_jcb_rate 
	{
		$mdr_rate=stringToNumber($accounts['mdr_jcb_rate']);
	}
	else	//else calculate on default transaction rate
	{
		$mdr_rate=stringToNumber($accounts['mdr_rate']);
	}

	//check MDR define as range then execute this section
	if($accounts['mdr_range_rate']&&$accounts['mdr_range_type']&&$accounts['mdr_range_amount'])
	{
		if($accounts['mdr_range_type']==1)
		{
			if(stringToNumber($amount_converted)<=stringToNumber($accounts['mdr_range_amount'])){
				$mdr_rate = $accounts['mdr_range_rate'];
			}
		}
		elseif($accounts['mdr_range_type']==2)
		{
			if(stringToNumber($amount_converted)>=stringToNumber($accounts['mdr_range_amount'])) {
				$mdr_rate = $accounts['mdr_range_rate'];
			}
		}
		elseif($accounts['mdr_range_type']==3)
		{
			if(stringToNumber($accounts['mdr_range_amount'])==stringToNumber($amount_converted)){
				$mdr_rate = $accounts['mdr_range_rate'];
			}
		}
	}
	$dis_rate = ($amount/100)*$mdr_rate;	//calculate MDR amount

	return $dis_rate;	//return MDR Amount
}

//fetch the exact name of your browsing device 
function fetchDeviceName()
{
	$isAndroid	= is_numeric(strpos(strtolower($_SERVER["HTTP_USER_AGENT"]), "android")); 
	$isIPhone	= is_numeric(strpos(strtolower($_SERVER["HTTP_USER_AGENT"]), "iphone")); 
	$isIPad		= is_numeric(strpos(strtolower($_SERVER["HTTP_USER_AGENT"]), "ipad")); 
	
	if(isset($_REQUEST['os'])&&trim($_REQUEST['os'])&&$_REQUEST['os']=='device_android'){
		$isAndroid=1;
	}
	elseif(isset($_REQUEST['os'])&&trim($_REQUEST['os'])&&$_REQUEST['os']=='device_ios'){
		$isIPhone=1;
	}
	
	if($isAndroid) return 'android';
	elseif($isIPhone || $isIPad) return 'ios';
	return '';
}  
  
//to check mobile compatible 
function isMobileBrowser()
{
	if(preg_match('/iPhone|iPod|iPad|android|blackberry|webos/', $_SERVER['HTTP_USER_AGENT']))
		return true;
	else
		return false;
}

//function to check browsing device
function isMobileDevice() {
	if(isset($_REQUEST['os'])&&trim($_REQUEST['os'])&&($_REQUEST['os']=='device_android' || $_REQUEST['os']=='device_ios')){
		return true;
	}
	else 
	{
		//return preg_match("/(android|avantgo|blackberry|bolt|boost|cricket|docomo|fone|hiptop|mini|mobi|palm|phone|pie|tablet|up\.browser|up\.link|webos|wos)/i", $_SERVER["HTTP_USER_AGENT"]);
		return preg_match("/(iPhone|iPod|iPad|android|avantgo|blackberry|bolt|boost|cricket|docomo|fone|hiptop|mini|mobi|palm|phone|pie|tablet|up\.browser|up\.link|webos|wos)/i", @$_SERVER["HTTP_USER_AGENT"]);
	}
}

if(isMobileDevice()){
	$data['deviceType'] = "M";
}
else {
	$data['deviceType'] = "W";
}

#####end-df####################################################














#### Dev Tech : 23-05-31 start - modify table for clilent,paying,payout #########


//fetch all clients list or specific clients for further use
function get_all_clients_new($Id=0)
{
	global $data;
	$qprint=0;
	if(isset($_GET['qp'])){
		$qprint=1;
		echo "<hr/><==get_all_clients==><hr/>";
	}
	if(!empty($Id)) {
		//fetch via id & clientid wise from clientid_table, payin_setting, payout_setting is not use if exist else fetch all records
	
			//	$where_clause = " WHERE `c`.`id`='{$Id}' AND `p`.`clientid`='{$Id}' AND `s`.`clientid`='{$Id}' ";	
		$where_clause = " WHERE `c`.`id` IN ({$Id})  ";
		
	} else $where_clause = "";
	
	$q="SELECT `c`.`id`,`c`.`username`,`c`.`registered_email`,`c`.`payout_request`,`c`.`default_currency`, `p`.`available_balance`,`p`.`available_rolling` ". 
		" FROM `{$data['DbPrefix']}clientid_table`  AS `c` ".
		//", `{$data['DbPrefix']}payin_setting`  AS `p`, `{$data['DbPrefix']}payout_setting`  AS `s` ".
		" INNER JOIN `{$data['DbPrefix']}payin_setting` AS `p` ON (`c`.`id`=`p`.`clientid`) ".
				//" INNER JOIN `{$data['DbPrefix']}payout_setting`  AS `s`  ON (`c`.`id`=`s`.`clientid`) ".
		//" $where_clause GROUP BY `c`.`id` ORDER BY `c`.`id`",$qprint
		" $where_clause  ORDER BY `c`.`id`";

	$result=db_rows($q,$qprint);
	
	$clients_list = array();
	foreach ($result as $key => $val) {
		$val['email'] = $val['registered_email'] = encrypts_decrypts_emails($val['registered_email'], 2);	//encrypts email before add in array 
		$clients_list[$val['id']] = $val;
	}
	return $clients_list;
}


############# PAYOUT SCRUBBED
function payout_scrubbed($uid,$payout_type,$trans_id=''){
	global $data,$post;

	$tran_db		=false; 
	$scrubbed_msg	=""; 
	$status_upd		="";
	$sc_amt_sum		=0; 
	$sc_tr_count	=0;
	$shw_msg		="";

	if(!$tran_db){
		
		$clients=select_client_table($uid);
		
		$accounts = array();
		
		if(isset($clients)&&$clients)
		{
			$accounts = jsondecode($clients['json_value'],1);
		}
		else
		{
			$bank_gateway=db_rows(
				"SELECT * FROM `{$data['DbPrefix']}bank_payout_table`".
				" WHERE `acquirer_id`='{$payout_type}' AND (`acquirer_status`='2') LIMIT 1 "
			);
			if(isset($bank_gateway[0])&&$bank_gateway[0])
			{
				$accounts = jsondecode($bank_gateway[0]['mer_setting_json'],1);
			}
		}

		$min_limit			=((isset($accounts['min_limit']) && trim($accounts['min_limit']))?(double)$accounts['min_limit']:1);
		$max_limit			=((isset($accounts['max_limit']) && trim($accounts['max_limit']))?(double)$accounts['max_limit']:500);

		$trn_success_count	=((isset($accounts['tr_scrub_success_count']) && trim($accounts['tr_scrub_success_count']))?(int)$accounts['tr_scrub_success_count']:2);
		$trn_failed_count	=((isset($accounts['tr_scrub_failed_count']) && trim($accounts['tr_scrub_failed_count']))?(int)$accounts['tr_scrub_failed_count']:5);
		$scrubbed_period	=((isset($accounts['scrubbed_period']) && trim($accounts['scrubbed_period']))?(int)$accounts['scrubbed_period']:1);

		$result=array();
		
		$status_upd=" `transaction_status`=10, ";

		if(($scrubbed_period>0)&&(!empty($max_limit))){
			$cdate = date('Y-m-d');
			if($scrubbed_period==1)
			{
				$fpdate = date("Y-m-d 00:00:00");
				$tpdate = date("Y-m-d 23:59:59");
			}
			else
			{
				$dayfrom= $scrubbed_period-1;
				$fpdate = date("Y-m-d",strtotime("-$dayfrom day",strtotime($cdate)));
				$tpdate	= date("Y-m-d",strtotime("+1 day",strtotime($cdate)));
			}
	
			$sc_amt_all=db_rows_2(
				"SELECT SUM(`converted_transaction_amount`) AS `summ`".
				" FROM `{$data['DbPrefix']}payout_transaction`".
				" WHERE `sub_client_id`='{$uid}' AND `transaction_type`='2' AND `transaction_status` ='1'". 
				" AND (created_date between '{$fpdate}' AND '{$tpdate}') LIMIT 1",0
			);
			
			$sc_amt_sum	= (double)$sc_amt_all[0]['summ'];
			$sc_amt_sum = abs($sc_amt_sum);

			$last_amts=db_rows_2(
				"SELECT `transaction_amount`,`transID` ".
				" FROM `{$data['DbPrefix']}payout_transaction`".
				" WHERE (`sub_client_id`='{$uid}') AND transID='{$trans_id}'".
				" LIMIT 1",0
			);
			$last_amt=abs($last_amts[0]['transaction_amount']);

			$sc_tr_completed=db_rows_2(
				"SELECT COUNT(`id`) AS `trcount`".
				" FROM `{$data['DbPrefix']}payout_transaction`".
				" WHERE `sub_client_id`='{$uid}' AND `transaction_type`='2' AND `transaction_status` ='1'". 
				" AND (created_date between '{$fpdate}' AND '{$tpdate}') LIMIT 1",0
			);
			$sc_tr_completed_count=(int)$sc_tr_completed[0]['trcount'];
			
			$sc_tr_cancelled=db_rows_2(
				"SELECT COUNT(`id`) AS `trcount`".
				" FROM `{$data['DbPrefix']}payout_transaction`".
				" WHERE `sub_client_id`='{$uid}' AND `transaction_type`='2' AND `transaction_status` ='2'". 
				" AND (created_date between '{$fpdate}' AND '{$tpdate}') LIMIT 1",0
			);
			$sc_tr_cancelled_count=(int)$sc_tr_cancelled[0]['trcount'];
		}

		if($sc_amt_sum<=0){$sc_amt_sum=$last_amt;}else {$sc_amt_sum+=$last_amt;}

		if($last_amt < $min_limit) 
		{
			$shw_msg .= ", Min. transaction amount allowed ".$min_limit." on your mid";
			$tran_db=true;
		}
		elseif($max_limit < $sc_amt_sum)
		{
			$shw_msg .= ", Max. transaction amount allowed ".$max_limit." on your mid";
			$tran_db=true;
		} 
		elseif($trn_success_count <= $sc_tr_completed_count){
			$shw_msg .= ", Max. Success transactions allowed within ({$scrubbed_period} days) : {$sc_tr_completed_count} from {$trn_success_count} on your mid";
			$tran_db=true;
		}
		elseif($trn_failed_count <= $sc_tr_cancelled_count){
			$shw_msg .= ", Max. Declined transactions allowed within ({$scrubbed_period} days) : {$sc_tr_cancelled_count} from {$trn_failed_count} on your mid";
			$tran_db=true;
		}
	}

	if($tran_db){
		$shw_msg=ltrim($shw_msg,", ");
		$scrubbed_msg=". Scrubbed Reason : ".$shw_msg;
		$trans=db_rows_2(
			"SELECT * FROM `{$data['DbPrefix']}payout_transaction` WHERE `sub_client_id`='{$uid}' AND `transID`='{$trans_id}' LIMIT 1",0
		);
		$remark_get	= $trans[0]['support_note']; 

		$rmk_date=date('d-m-Y h:i:s A');

		$tr_status_set	= "Transaction has been Scrubbed ".$scrubbed_msg;
		$remark_upd		= "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$tr_status_set." </div></div>".$remark_get;

		db_query_2(
			"UPDATE `{$data['DbPrefix']}payout_transaction`".
			" SET ".$status_upd." `support_note`='{$remark_upd}', `reason`='{$shw_msg}' ".
			" WHERE `sub_client_id`='{$uid}' AND `transID`='{$trans_id}'"
		);
	}

	$result['scrubbed_status']	=$tran_db;
	$result['scrubbed_msg']		=$scrubbed_msg;
	return $result;
}


function trans_countsf($where=''){
	global $data;
	$qp=0;
	if(isset($_GET['qp'])){
		$qp=1;
	}
	
	$mid_query="";
	if((isset($_SESSION['sub_admin_id']))&&($_SESSION['get_mid']!='M. All')){
		$get_mid=$_SESSION['get_mid'];
		$mid_query.=" AND ( t.merID IN ({$get_mid} ) ) ";
	}
	
	if ((isset($_REQUEST['mid']))&& ($_REQUEST['mid']!='') && (!empty($_SESSION['login_adm']))){
			$q =" SELECT COUNT(t.id) AS `trcount`";
			$q.=" FROM ({$data['DbPrefix']}clientid_table ";
			$q.=" INNER JOIN {$data['DbPrefix']}subadmin ON ";
			$q.=" {$data['DbPrefix']}clientid_table.sponsor = {$data['DbPrefix']}subadmin.id) ";
			$q.=" INNER JOIN {$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']} as t ON ";
			$q.=" ({$data['DbPrefix']}clientid_table.id = t.merID)  ";
			$q.=" WHERE ({$data['DbPrefix']}clientid_table.sponsor=".$_REQUEST['mid'].")";
			$q.=" LIMIT 1";
			$data['tr_counts_q']=$q;
			$cont_trans=db_rows($q,$qp);
	}
	else {
		
		
		$q0 = $mid_query.$where;
		
		if(strpos($q0,'AND') !== false)
		{
			$q0=" WHERE ".substr_replace($q0,'', strpos($q0, 'AND'), 3);
		}
		
		//Select Data from master_trans_additional
		$join_additional=join_additional('t');

		$q2="SELECT COUNT(*) AS `trcount` FROM {$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']} AS `t` {$join_additional} ".$q0." LIMIT 1";
		
		
		$data['tr_counts_q']=$q2;
		$cont_trans=db_rows($q2,$qp);
		
	}
	
	$data['trcounts']=$cont_trans[0]['trcount'];
	return $cont_trans[0]['trcount'];
}

function update_epn_info($post, $sid){
	global $data;
	db_query(
		"UPDATE `{$data['DbPrefix']}clientid_table` SET ".
		"`epn_key`='{$post['epn_key']}',".
		"`epn_id`='{$post['epn_id']}'".
		" WHERE `id`='{$sid}'"
	);
}
function deleted_profile_email($uid,$email){
	global $data;
	if(isset($data['email_val'])&&$data['email_val']&&empty($email)){
		$email=$data['email_val'];
	}
	$select=select_table_details($uid,'clientid_table',0);
	$deleted_email=[];
	if($select['deleted_email']){
		$deleted_email_list=encrypts_decrypts_emails($select['deleted_email'],2);
		if($deleted_email_list)
		{
			$deleted_email = explode(",",$deleted_email_list);
		}
	}
	if($email&&!in_array($email,$deleted_email)){
		$deleted_email[]=encrypts_decrypts_emails($email,2);
		
		$deleted_email_list = implode(",",$deleted_email);
		$data['skipemailvalidation']=1;
		
		$deleted_email = encrypts_decrypts_emails($deleted_email_list,1);
		db_query(
			"UPDATE `{$data['DbPrefix']}clientid_table` SET ".
			" `deleted_email`='".$deleted_email."' ".
			" WHERE `id`='{$uid}'",0
		);
	}
	//exit;
}

function update_private_info($post, $uid){
	global $data;
	db_query(
		"UPDATE `{$data['DbPrefix']}clientid_table` SET ".
		"`username`='{$post['username']}',`password`='{$post['password']}',".
		"`email`='".encrypts_decrypts_emails($post['email'],1)."' WHERE `id`='{$uid}'"
	);
}

function set_default_email($gid){
	global $data;
	$emails=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}clientid_emails`".
		" WHERE `id`='{$gid}' LIMIT 1"
	);
	if(isset($emails[0])&&$emails[0]){
		db_query(
			 "INSERT INTO `{$data['DbPrefix']}clientid_emails`(".
			 "`clientid`,`email`,`status`".
			 ")VALUES(".
			 "{$emails[0]['clientid']},'".get_clients_email($emails[0]['clientid'])."',2)"
		);
		db_query(
			 "UPDATE `{$data['DbPrefix']}clientid_table`".
			 " SET `email`='{$emails[0]['email']}'".
			 " WHERE `id`='".$emails[0]['clientid']."'"
		);
		db_query(
			 "DELETE FROM `{$data['DbPrefix']}clientid_emails`".
			 " WHERE `id`='".$emails[0]['id']."'"
		);
	}
}

//this function currently is not using
function Block_User(){ 
	global $data;
	$ipdata=db_rows("SELECT `id`,`last_login_ip`,`username` FROM `{$data['DbPrefix']}clientid_table`");
	return $ipdata;
}

//The function set_ip_block_clients() is used to block a clients for 30 minutes after continuously fail to login with wrong username/password.
function set_ip_block_clients($uid,$ip_block_clients){	
	global $data;
	//set IP into ip_block
	db_query("UPDATE `{$data['DbPrefix']}clientid_table`"." SET `ip_block_clients`='{$ip_block_clients}' WHERE `id`='{$uid}'");
	json_log_upd($uid,'clientid_table','Block'); // for json log history
}


function create_payin_setting($clientid){

	global $data;

	//Initialized variables
	$last_login_ip=$_SERVER['REMOTE_ADDR']; 	//login IP
	$payinTableId=""; 
	
	//if connection name is clk then used following fee structure (default)
	if($data['con_name']=='clk'){
		$settlement_fixed_fee='1';				//wire fee
		$settlement_min_amt='1';		//minimum withdraw amount require
		$monthly_fee='1';			//monthly fee
		$withdraw_max_amt='20000';	//maximum withdraw amount allow
		$frozen_balance='100';		//frozen balance
		$gst_fee='18.00';			//GST fee 
	}else{
		$settlement_fixed_fee='100';			//wire fee
		$settlement_min_amt='5000';	//minimum withdraw amount require
		$monthly_fee='350';			//monthly fee
		$withdraw_max_amt='20000';	//maximum withdraw amount allow
		$frozen_balance='100';		//frozen balance
		$gst_fee='0.00';			//GST fee (null)
	}
	
	//if fee structure and transaction limit exists in $data, then update above assign limits
	if(isset($data['domain_server']['as']['withdraw_max_amt'])&&$data['domain_server']['as']['withdraw_max_amt']){
		$withdraw_max_amt=$data['domain_server']['as']['withdraw_max_amt']; //maximum withdraw amount allow
	}
	if(isset($data['domain_server']['as']['monthly_fee'])&&$data['domain_server']['as']['monthly_fee']){
		$monthly_fee=$data['domain_server']['as']['monthly_fee'];	//monthly fee
	}
	if(isset($data['domain_server']['as']['settlement_fixed_fee'])&&$data['domain_server']['as']['settlement_fixed_fee']){
		$settlement_fixed_fee=$data['domain_server']['as']['settlement_fixed_fee'];	//wire fee
	}
	if(isset($data['domain_server']['as']['settlement_min_amt'])&&$data['domain_server']['as']['settlement_min_amt']){
		$settlement_min_amt=$data['domain_server']['as']['settlement_min_amt'];	//minimum withdraw amount require
	} 
	if(isset($data['domain_server']['as']['frozen_balance'])&&$data['domain_server']['as']['frozen_balance']){
		$frozen_balance=$data['domain_server']['as']['frozen_balance'];	//frozen balance
	}
	if(isset($data['domain_server']['as']['gst_fee'])&&$data['domain_server']['as']['gst_fee']){
		$gst_fee=$data['domain_server']['as']['gst_fee'];	//GST fee
	}
	

	if($clientid>0){
		db_query(
			"INSERT INTO `{$data['DbPrefix']}payin_setting`(".
			"`clientid`,`payin_status`,`settlement_fixed_fee`,`settlement_min_amt`,`monthly_fee`,`frozen_balance`".
			")VALUES(".
			"{$clientid},'2','{$settlement_fixed_fee}','{$settlement_min_amt}','{$monthly_fee}','{$frozen_balance}')",0
		);
		$payinTableId=newid();	//fetch newly added client id
	}
		
	return $payinTableId;	//return all detail of a clients
}

//The function update_confirmation() is used to update all transaction fee and limits of new confirm user. Remove more than five days old records from confirms table. Move the data of a user from confirms table to clients table. Also insert email detail into clients_emails table. Send a SIGNUP email to MEMBER.
function update_confirmation($cid){

	global $data;

	//Initialized variables
	$last_login_ip=$_SERVER['REMOTE_ADDR']; 	//login IP
	$merID=""; 
	
	
	if(isset($data['domain_server']['as']['default_currency'])&&$data['domain_server']['as']['default_currency']){
		$post['default_currency']=$data['domain_server']['as']['default_currency'];	//default currency
	}elseif(!isset($_POST['default_currency'])&&$data['con_name']=='clk'){
		$post['default_currency']='INR';	//if default_currency is null and con_name is clk then set default Currency INR
	}elseif(!isset($_POST['default_currency']) || empty($_POST['default_currency'])){
		$post['default_currency']='USD';	//if default_currency is null and con_name non-clk then set default Currency USD
	}
	
	if(isset($data['UseExtRegFormNew'])){ $data['UseExtRegForm']=1; }
	
	//echo $last_login_ip; 
	//delete 5-day old data from confirms table
	db_query(
		"DELETE FROM `{$data['DbPrefix']}unregistered_clientid`".
		" WHERE (TO_DAYS(NOW())-TO_DAYS(`created_date`)>=5)"
	);
	
	//fetch all available data from confirms table
	$confirm=db_rows("SELECT * FROM `{$data['DbPrefix']}unregistered_clientid` WHERE (`id`='{$cid}')",0);
	$confirm=$confirm[0];
	
	if($confirm){
		foreach($confirm as $key=>$value){
			$confirm[$key] = @addslashes($value);
		}
	}	
	
	$reset_password=1;
	
	//$newpass=hash('sha256',$confirm['newpass']);
	//$newpass=hash_f($confirm['newpass']);
	//$newpass=($confirm['newpass']);
	
	$generate_newpass=generate_password(10);	//generate 10 characters password
	$newpass=hash_f($generate_newpass); 		//encrypt via hash 

	//if new user then store all data into clients main table
	if($confirm['newuser']){
			
		$confirm['newmail'] = stripslashes($confirm['newmail']);

		db_query(
			"INSERT INTO `{$data['DbPrefix']}clientid_table`(".
			"`sponsor`,`username`,`password`,`registered_email`,`fullname`,`last_login_ip`,`password_updated_date`,`ip_block_client`,`active`,`created_date`,`status`,`default_currency`".
			")VALUES(".
			"{$confirm['sponsor']},'{$confirm['newuser']}','{$newpass}','{$confirm['newmail']}','{$confirm['newfullname']}','{$last_login_ip}',now(),'1','1','".date('Y-m-d H:i:s')."','2','{$post['default_currency']}')",0
		); 
		$merID=newid();	//fetch newly added client id
		
		if($merID>0){
			create_payin_setting($merID);
		}
		
		
		$code=gencode();	//to generate a unique code
		
		if($reset_password==1){
			//[confcode]
			$post['ccode']=$data['ccode']=encode_f($merID,0);
		}else{
			//$query_upd=" `password`='{$hash_password}', ";
		}
		
		/*
		//if security question is exists then update question in DB for security purpose
		if(isset($confirm['sub_sponsor'])&&$confirm['sub_sponsor']&&$merID){
			$sub_sponsor=jsondecode(stripslashes($confirm['sub_sponsor']),1); 
			if(isset($sub_sponsor['sponsor_id'])&&$sub_sponsor['sponsor_id']){
				$subadmin=db_rows(
					"SELECT * FROM `{$data['DbPrefix']}subadmin`".
					" WHERE `id`='".$sub_sponsor['sponsor_id']."' LIMIT 1",0
				); 
				$multiple_merchant_ids	= $subadmin[0]['multiple_merchant_ids'].$merID.',';
				$multiple_merchant_ids	= remove_extra_comma($multiple_merchant_ids);
				db_query(
					"UPDATE `{$data['DbPrefix']}subadmin`".
					" SET `multiple_merchant_ids`='{$multiple_merchant_ids}'".
					" WHERE `id`='".$sub_sponsor['sponsor_id']."'",0
				);
			} 
		}
		*/
		
		//insert data into clients_emails
		db_query("INSERT INTO `{$data['DbPrefix']}clientid_emails` 
			(`clientid`,`email`,`active`,`primary`) VALUES
			('{$merID}','{$confirm['newmail']}',1,1)",0
		);

		//delete row from confirms table after move to clients main table
		db_query(
			"DELETE FROM `{$data['DbPrefix']}unregistered_clientid`".
			" WHERE (`id`='".$confirm['id']."')"
		);
		
		$post['username']=$confirm['newuser'];		//username
		//$post['password']=$confirm['newpass'];
		$post['password']=$generate_newpass;		//generated password
		
		$post['email']	=encrypts_decrypts_emails($confirm['newmail'],2);	//decrypts email id
		$post['tableid']=$merID;		//clients id
		$post['mail_type']="14";		//email type 14 for new sign-up
		$post['email_header']=1;		//email header on
		//$post['email_br']=1;
		$post['email_he_on']=1;			//email header on
		
		$post['clientid']=$merID;		//clients id as clientid id
		
		if($merID&&$post['password']){
			//send_email('SIGNUP-TO-MEMBER', $post);	//send sign-up email
			
			//echo "<br/>code=>".$code; echo "<br/>merID=>".$merID;

			
			if($data['ReferralPays']){
				$post['mail_type']="15";	//email type 15, if new user sign-up by a referrer
				$post['email']=get_clients_email($confirm['sponsor']);
				//send_email('DOWNLINE-CHANGE', $post);
			}
			//$tmpays=get_unreg_clients_pay($merID,'RECEIVER');
			//if(isset($tmpays[0])&&$tmpays[0]) update_unreg_clients_pays($merID);	
		}
	}
	return $merID;	//return all detail of a clients
}

//The function update_email_confirmation() is used to update email status.
function update_email_confirmation($eid){
	global $data;
	//update status
	db_query(
		"UPDATE `{$data['DbPrefix']}clientid_emails`".
		" SET `confirm`='', `status`=2".
		" WHERE `id`='{$eid}'"
	);
}

//In the function payout_status_class(), you can set status CSS class as per status.
function payout_status_class($gstatus){
	global $data;

	if($gstatus=='Pending'){
		$statuscss="info";		//class name for Pending transactions
	}elseif($gstatus=='Success' || $gstatus=='Approved'){
		$statuscss="success";		//class name for Success transactions
	}elseif($gstatus=='Processing'){
		$statuscss="warning";		//class name for in-complete transactions
	}else{
		$statuscss="danger";		//class name for failed transactions
	}
	return $statuscss;	//return CSS class
}

//No any use. Use 9-10 places in merchant.do, but all places are commented
function get_clients_count_where_pred($where_pred, $join=''){
	global $data;
	$result=db_rows(
		"SELECT COUNT(`{$data['DbPrefix']}clientid_table`.`id`) AS `count`".
		" FROM `{$data['DbPrefix']}clientid_table` ".$join.
		" WHERE $where_pred ".
		" LIMIT 1",0
	);
	if(isset($result[0])) return $result[0]['count']; 
	else return 0;
}


//The function is_user_available() is used to check username availability
function is_user_available($username){
	global $data;
	
	//check in confirms (temp) table
	$confirms=db_rows(
		"SELECT `id` FROM `{$data['DbPrefix']}unregistered_clientid`".
		" WHERE(`newuser`='{$username}') LIMIT 1"
	);

	//check in clients table
	$get_clientid_details=db_rows(
		"SELECT `id` FROM `{$data['DbPrefix']}clientid_table`".
		" WHERE(`username`='{$username}') LIMIT 1"
	);
	return (bool)(!$confirms&&!$get_clientid_details);		//return true/false
}


//The make_email_prim() is used to set email as primary email
function make_email_prim($uid, $email, $eid=0){
	global $data;
//	$oldprim=get_clients_email($uid,true);

	if($eid) $email = getclientsEmailId($eid);	//fetch email id from clients_emails

	//verify email id is correct or not
	if(verify_email(encrypts_decrypts_emails($email,2))) return 'INVALID_EMAIL_ADDRESS';

	$emails=get_email_details($uid,false,false);	//fetch all emails LIST from clients_emails

	foreach ($emails as $addr){	//execute all email row-by row
		if($addr['email']==$email && $addr['primary']) return 'ALREADY_PRIMARY';	//check is email already primary
		elseif($addr['email']==$email && !$addr['active']) return 'EMAIL_NOT_ACTIVE';	//check is email active or not
		elseif($addr['email']==$email){
			/* un-prim old, make prim new*/
			db_query("UPDATE {$data['DbPrefix']}clientid_emails SET `primary`=0 WHERE `clientid`='{$uid}'");	//reset all primary email as non primary
			db_query("UPDATE {$data['DbPrefix']}clientid_emails SET `primary`=1 WHERE `clientid`='{$uid}' AND id='{$eid}'", 0);	//set email to primary
			
			//update primary email into clients table
			if($eid&&$email&&$uid>0) 
			{
				$_GET['email']=$email;
				db_query("UPDATE {$data['DbPrefix']}clientid_table SET `registered_email`='{$email}' WHERE `id`='{$uid}'");
				db_query("UPDATE {$data['DbPrefix']}clientid_emails SET `email`='{$email}' WHERE `id`='{$eid}'");
			}
			json_log_upd($uid,'clientid_table','action'); // for json log history 
			$_SESSION['token_email'] = md5(uniqid(rand(), TRUE));
			$_SESSION['token_email_time'] = time();
			
			return 'SUCCESS';	//return success
		}
	}
	return 'EMAIL_NOT_FOUND';
}


//The get_user_id() is used to fetch id / clientid id of a clients by username or email
function get_user_id($unoremail){
	global $data;
	if(verify_email($unoremail)){
	// here we know its the username
		$result=db_rows(
			"SELECT `id` FROM `{$data['DbPrefix']}clientid_table`".
			" WHERE (`username`='{$unoremail}') AND `active`=1 LIMIT 1");
		return $result[0]['id'];	//return id
	} else {
	//... here the email address
		$result=db_rows(
			"SELECT `clientid` FROM `{$data['DbPrefix']}clientid_emails` e, ".
			"`{$data['DbPrefix']}clientid_table` m".
			" WHERE (e.`email`='{$unoremail}' AND m.`active`=1)".
			" LIMIT 1");
		return $result[0]['clientid'];		//return clientid	
	}
}

//The get_sponsors_mem() is used to fetch sponsors clients
function get_sponsors_mem($uid,$json=0,$sponsorList=0){

	global $data; $where_pred="";
	
	//create query according $uid
	if($uid){		
		$where_pred =($uid?" WHERE `id`<>{$uid} AND `sponsor`<>{$uid}":'');
	}
	
	//check login type and create query according login_id/mid
	if((isset($_SESSION['sub_admin_id']))&&($_SESSION['get_mid']!='M. All')){
		$get_mid	= $_SESSION['get_mid'];

		$where_pred = " WHERE (`id` IN ({$get_mid})) ";
	}

	//fetch required data from clients table
	$get_clientid_details=db_rows(
		"SELECT `id`,`username`,`registered_email`".
		" FROM `{$data['DbPrefix']}clientid_table`".
		$where_pred
	);
	$result=array('--');
	$result[999999999]="Default Select 0";
	$k=0;
	
	//access all data via loop and store into an array 
	foreach($get_clientid_details as $key=>$value){
		if($json){
			$result[$value['id']]="{$value['id']} | {$value['username']} | ".encrypts_decrypts_emails($value['registered_email'],2,1);
		}else{
			$result[$value['id']]="{$value['id']} | ".encrypts_decrypts_emails($value['registered_email'],2,1);
		}
		$k++;
	}
	return $result;	//return array
}



function get_sponsors($uid,$associateid,$allMid=0){
	global $data; $qp=0;
	if(isset($_GET['sp'])){
		$qp=1;
	}
	
	//fetch subadmin detail
	$subadmin=db_rows(
		"SELECT `id`,`username`,`front_ui`,`email`,`access_id`,`multiple_merchant_ids`,`multiple_subadmin_ids`".
		" FROM `{$data['DbPrefix']}subadmin`".
		//($uid?" WHERE `access_id`='{$uid}' ":'').
		($uid?" WHERE `access_id`='{$uid}' OR `multiple_merchant_ids` LIKE '%,{$uid},%' OR `multiple_subadmin_ids` LIKE '%,{$uid},%' ":'').
		($associateid?" WHERE `id`='{$associateid}' LIMIT 1":''),$qp
	);
	$result=array('--');
	
	foreach($subadmin as $value){
		$ar=get_access_admin_role($value['access_id']);	//fetch access roll
		$result[$value['id']]="{$value['id']} | {$value['username']} | ".($value['front_ui']?"{$value['front_ui']}":"default")." | ".encrypts_decrypts_emails($value['email'],2)." | ".(isset($ar[0]['rolesname'])?$ar[0]['rolesname']:'')." ".(isset($ar[0]['merchantAccess'])&&$ar[0]['merchantAccess']?" | {$ar[0]['merchantAccess']}":"").(isset($ar[0]['subAdminAccess'])&&$ar[0]['subAdminAccess']?" | {$ar[0]['subAdminAccess']}":"")." ";
	}
	
	//if subadmin not empty then define roles
	if($allMid&&isset($subadmin[0])&&$subadmin[0]){
		$result['merchantAccess']=$ar[0]['merchantAccess'];		//merchant Access roles
		$result['subAdminAccess']=$ar[0]['subAdminAccess'];		//subadmin Access roles

		$where_pred="";$multiple_merchant_ids="";
		$sponsor=$subadmin[0]['id'];
		if($ar[0]['merchantAccess']=="M. Multiple"){
			//$where_pred.=" OR `multiple_subadmin_ids` LIKE '%,{$sponsor},%'";
			$multiple_merchant_ids .= $subadmin[0]['multiple_merchant_ids'];	//merchant id list
		}

		if($ar[0]['subAdminAccess']=="G. Multiple"){
			$multiple_subadmin_ids=$sponsor.$subadmin[0]['multiple_subadmin_ids'];
			$multiple_subadmin_ids=uniqueValue($multiple_subadmin_ids,',');
			$sid1=$multiple_subadmin_ids['v'];
			
			//fetch total records from subadmin with group_concat_return multiple_merchant_ids
			$sub_multi=db_rows(
				"SELECT COUNT(`id`) AS `count`, ".group_concat_return('`id`',0)." AS `id`, ".group_concat_return('`multiple_merchant_ids`',0)." AS `multiple_merchant_ids`, ".group_concat_return('`multiple_subadmin_ids`',0)." AS `multiple_subadmin_ids`".
				" FROM `{$data['DbPrefix']}subadmin`".
				" WHERE `id` IN ({$sid1}) ".
				" LIMIT 1",$qp
			);
			
			$mm_1=$sub_multi[0]['multiple_merchant_ids'];	//merchant id list
			$gm_1=$sub_multi[0]['multiple_subadmin_ids'];	//subadmin id list
	
			$add_id1 = $sponsor.$mm_1.$gm_1;	//merge all ids - sponsor ids, merchant id & subadmin ids
			$add_id2 = uniqueValue($add_id1,',');
			$sponsor = $add_id2['v'];
			
			$result['get_gid_count']=$add_id2['c'];
			$result['get_gid']		=$add_id2['v'];

			if($qp){
				echo "<hr/>mm_1=>".$mm_1;
				echo "<hr/>gm_1=>".$gm_1;
				//echo "<hr/>sponsor=>".$sponsor;

				echo "<hr/>multiple_subadmin_ids=>".$multiple_subadmin_ids['v'];
				echo "<hr/>sponsor + multiple_subadmin_ids=>".$sponsor;
			}
		}
		
		//total sponsor count from clients table
		$get_clientid_details_spo=db_rows(
			" SELECT COUNT(`id`) AS `count`, ".group_concat_return('`id`',1)." AS `id`, ".group_concat_return('`sponsor`',1)." AS `sponsor` ".
			" FROM `{$data['DbPrefix']}clientid_table`".
			" WHERE `sponsor` IN ({$sponsor}) ".$where_pred.
			" LIMIT 1",$qp
		);
		
		$get_mids=$get_clientid_details_spo[0]['id'].$multiple_merchant_ids;
		$uVal=uniqueValue($get_mids,',');
		
		if($qp){
			echo "<hr/>get id count=>".$sponsor;
			echo "<hr/>get id count=>".$get_mid=$get_clientid_details_spo[0]['count'];
			echo "<hr/>multiple_merchant_ids from clients=>".$get_clientid_details_spo[0]['id'];
			echo "<hr/>multiple_merchant_ids from subadmin=>".$multiple_merchant_ids;
			
			echo "<hr/>get_mids=>".$get_mids;
				
			print_r($uVal);

			echo "<hr/>clients_spo=>";
			print_r($get_clientid_details_spo[0]);
		}
		
		if($ar[0]['subAdminAccess']=='G. Multiple'){
			
		}
		
		if($ar[0]['merchantAccess']=='M. Individual'){		//merchant Individual
			$uVal['c']=1;$uVal['v']=$associateid;
		}

		if(empty($ar[0]['merchantAccess'])||empty($ar[0]['subAdminAccess'])){	//merchant or subadmin access
			$uVal['c']=0;$uVal['v']=-1;
		}

		if($ar[0]['merchantAccess']=='M. All'){
			$uVal['c']="M. All";$uVal['v']="M. All";
		}

		$result['get_mid_count']=$uVal['c'];
		$result['get_mid']		=$uVal['v'];
	}

	return $result;	//return array
}



//This function is used to get username of a clients 
function get_clients_username($uid){
	global $data; $prnt=0;
	if($uid<0)return 'system';	//if $uid is empty then return system
	
	//fetch username from clients table
	$q="SELECT `username` FROM `{$data['DbPrefix']}clientid_table`".
		" WHERE `id`='{$uid}' LIMIT 1";

	$result=db_rows($q,$prnt);
	
	if(isset($result[0]['username'])){
		return $result[0]['username'];	//return username
	}
}

//This function is used to get clients table id via username
function get_clients_id_byusername($uid){
	global $data;
	if($uid<0)return 'system';	//if $uid is empty then return system

	//fetch id from clients table
	$result=db_rows("SELECT `id` FROM `{$data['DbPrefix']}clientid_table` WHERE `username`='$uid' LIMIT 1");

	if(isset($result[0]['id'])) return $result[0]['id'];	//return id
}
//This function is currently not using
function save_remote_ipadd($bill_ip,$attempts,$today){
	global $data;
	db_query(
		"INSERT INTO `{$data['DbPrefix']}login_attempts` (IpAddress, attempts, date_last_use) VALUES('$bill_ip','$attempts', '$today')"
	);
}
//This function is currently not using
function save_remote_ipaddress($bill_ip){
	global $data;
	$result=db_rows(
		"SELECT `date_last_use` FROM `{$data['DbPrefix']}login_attempts` WHERE `IpAddress`='{$bill_ip}'"
	);
	$tommorow = date("d/m/y");
	if(isset($result[0]['date_last_use'])&&$result[0]['date_last_use']==$tommorow)
		return false;
	else
		return true;
}
//This function is used to get clients' name via id
function get_clients_name($uid){
	global $data;
	if($uid<0)return 'system';	//if $uid is empty then return system
	

	$result=db_rows(
		"SELECT `fullname` FROM `{$data['DbPrefix']}clientid_table`".
		" WHERE `id`='{$uid}' LIMIT 1");
	
	if(isset($result[0]['fullname'])&&$result[0]['fullname']) return $result[0]['fullname'];	//return fullname
	
}



//The get_clients_info() is used to fetch full information of a clients
function get_clients_info($uid){
	global $data;
	if($uid){
		//fetch data from clients table
		$result=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}clientid_table`".
			" WHERE `id`='{$uid}' LIMIT 1");
			
		$result=$result[0];
		$payin_setting_get=clientidf($uid);
		if(isset($payin_setting_get)&&is_array($payin_setting_get)&&isset($result)&&is_array($result))
			$result=array_merge($result,$payin_setting_get);
		
		
		//fetch data from clients_emails table
		$result['emails']=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}clientid_emails`".
			" WHERE `clientid`='{$uid}'");
			//" WHERE `clientid`='{$uid}' AND `email`<>'{$result[0]['email']}'");

		return $result;	//return full information in array
	}
}

//The get_clients_status() is used to fetch status of a clients
function get_clients_status($uid){
	global $data;
	//fetch status from clients table
	$result=db_rows(
		"SELECT `status` FROM `{$data['DbPrefix']}clientid_table`".
		" WHERE `id`='{$uid}' LIMIT 1"
	);
	return $result[0]['status'];	//return status
}


//to check clients exists with specific username and password
function is_clients_found($username, $password){
	return (bool)get_clients_id($username, $password);
}

//to check specific clients is active or not
function is_clients_active($username,$tbl='clientid_table'){
	return (bool)get_clients_id($username, '', '`active`=1',false,$tbl);
}

//The set_clients_status() is used to update clients status
function set_clients_status($uid, $active){
	global $data;
	
	//update clients status
	db_query(
		"UPDATE `{$data['DbPrefix']}clientid_table`".
		" SET `active`=".(int)$active.
		" WHERE `id`='{$uid}'"
	);
	json_log_upd($uid,'clientid_table','Status');	//update json log history
}

//The set_clients_approve() is used to update clients permission
function set_clients_approve($uid, $edit_permission){
	global $data;
	
	//update permission
	db_query(
		"UPDATE `{$data['DbPrefix']}clientid_table`".
		" SET `edit_permission`=".$edit_permission.
		" WHERE `id`='{$uid}'"
	);
	json_log_upd($uid,'clientid_table','action');	//update json log history
}

//The principal_update() is used to update encoded_contact_person_info of a clients
function principal_update($uid,$post,$update='',$action=''){
	global $data;
	
	//fetch exists encoded_contact_person_info
	$principal_db=db_rows(
		"SELECT `encoded_contact_person_info` FROM `{$data['DbPrefix']}clientid_table`".
		" WHERE `id`='{$uid}' LIMIT 1"//,true
	);
	$principal_get= $principal_db[0]['encoded_contact_person_info'];	//encoded_contact_person_info
	
	if($update){
		$encoded_contact_person_info=str_replace($update,$post,$principal_get);
	}elseif($action=="delete"){
		$encoded_contact_person_info=str_replace($update,'',$principal_get);
	}else{
		$encoded_contact_person_info=$post."_;".$principal_get;
	}
	$encoded_contact_person_info=str_replace('_;_;','',$encoded_contact_person_info);
	
	//update encoded_contact_person_info
	db_query(
		"UPDATE `{$data['DbPrefix']}clientid_table`".
		" SET `encoded_contact_person_info`='{$encoded_contact_person_info}'".
		" WHERE `id`='{$uid}'"//,true
	);
	json_log_upd($uid,'clientid_table','SPOC Update'); // for json log history
	/*
	$decryptres = decryptres($encoded_contact_person_info);
	$pr=explode('_;',$decryptres);
	
	//$pr=explode('_;',$encoded_contact_person_info);
	print_r($pr);
	echo "<hr/>".$pr['phone'];
	exit;*/
}

//This function currently is not using
function principal_view_sil($uid=0,$admin=false,$class='dta1'){
	global $data;
	$principal_db=db_rows(
		"SELECT `encoded_contact_person_info` FROM `{$data['DbPrefix']}clientid_table`".
		" WHERE `id`='{$uid}' LIMIT 1"//,true
	);
	$encoded_contact_person_info= $principal_db[0]['encoded_contact_person_info'];
	$principal_exp=explode('_;',$encoded_contact_person_info);
	//echo "<hr/>count=".count($principal_exp);
	
	if($admin){
		$path=$data['Host']."/include/verify{$data['ex']}?actionType=admin&id=".$uid;
	}else{
		$path=$data['Host']."/include/verify{$data['ex']}?id=".$uid;
	}

	$i=1;
	foreach($principal_exp as $principal_value){
		if($principal_value){
			$value = decryptres($principal_value);
			//echo "<hr/>".$i;
			$key=$i;
			$email_verify=jsonvaluef($value,"email_verify");
			$phone_verify=jsonvaluef($value,"phone_verify");
			if($email_verify=="Verified"){
				$email_ver="<span title='Email have been Verified' class='glyphicons ok_2' style='color: rgb(0, 164, 30);'><i></i></span>";
			}else{
				if($admin){
				 $email_ver="<a target='_blank' href='".$path."&action=verification&type=email&bid=".$principal_value."' class='verify_input'>".$email_verify."</a>";
				}else{
					$email_ver="";
				}
			}
			
			if($phone_verify=="Verified"){
				$phone_ver="<span title='Phone have been Verified' class='glyphicons ok_2' style='color: rgb(0, 164, 30);'><i></i></span>";
			}else{
				if($admin){
					$phone_ver="<a target='_blank' href='".$path."&action=verification&type=phone&bid=".$principal_value."' class='verify_input'>".$phone_verify."</a>";
				}else{
					$phone_ver="";
				}
			}
			
			echo "<div class='rows row'>";
			if($admin){
				echo '<div class="pull_right"><a href="clients'.$data['ex'].'?bid='.$principal_value.'&id='.$uid.'&action=update_principal&type='.(isset($post['type'])?$post['type']:'').'">EDIT</a>|<a href="clients'.$data['ex'].'?bid='.$principal_value.'&id='.$uid.'&action=update_delete&type='.(isset($post['type'])?$post['type']:'').'" onclick="return cfmform()">DELETE</a></div>';
			}
				echo "<div class='col-sm-2 mb-3 bg-light border dta1 key $key'><strong>First Name :</strong> </div><div class='col-sm-2 mb-3 dta1 val'>".jsonvaluef($value,"fname")." </div>";
				echo "<div class='col-sm-2 mb-3 bg-light border dta1 key $key'><strong>Last Name : </strong></div><div class='col-sm-2 mb-3 dta1 val'>".jsonvaluef($value,"lname")." </div>";
				echo "<div class='col-sm-2 mb-3 bg-light border dta1 key $key'><strong>Designation : </strong></div><div class='col-sm-2 mb-3 dta1 val'>".jsonvaluef($value,"designation")." </div>";
				echo "<div class='col-sm-2 mb-3 bg-light border dta1 key $key'><strong>Phone : </strong></div><div class='col-sm-2 mb-3 dta1 val'>".jsonvaluef($value,"phone").$phone_ver."</div>";
				echo "<div class='col-sm-2 mb-3 bg-light border dta1 key $key'><strong>Date of birth : </strong></div><div class='col-sm-2 mb-3 dta1 val'>".jsonvaluef($value,"birth_date")." </div>";
				echo "<div class='col-sm-2 mb-3 bg-light border dta1 key $key'><strong>Email : </strong></div><div class='col-sm-2 mb-3 dta1 val'>".jsonvaluef($value,"email"). $email_ver ."</div>";
				echo "<div class='col-sm-2 mb-3 bg-light border dta1 key $key'><strong>Gender : </strong></div><div class='col-sm-2 mb-3 dta1 val'>".jsonvaluef($value,"gender")." </div>";
				echo "<div class='col-sm-2 mb-3 bg-light border dta1 key $key'><strong>Residential Address1: </strong></div><div class='col-sm-2 mb-3 dta1 val'>".jsonvaluef($value,"address")." </div>";
				echo "<div class='col-sm-2 mb-3 bg-light border dta1 key $key'><strong>City : </strong></div><div class='col-sm-2 mb-3 dta1 val'>".jsonvaluef($value,"city")." </div>";
				echo "<div class='col-sm-2 mb-3 bg-light border dta1 key $key'><strong>State : </strong></div><div class='col-sm-2 mb-3 dta1 val'>".jsonvaluef($value,"state")." </div>";
				echo "<div class='col-sm-2 mb-3 bg-light border dta1 key $key'><strong>Country : </strong></div><div class='col-sm-2 mb-3 dta1 val'>".jsonvaluef($value,"country")." </div>";
				echo "<div class='col-sm-2 mb-3 bg-light border dta1 key $key'><strong>Zip : </strong></div><div class='col-sm-2 mb-3 dta1 val'>".jsonvaluef($value,"zip")." </div>";
				echo "<div class='col-sm-2 mb-3 bg-light border dta1 key $key'><strong>Document : </strong></div><div class='col-sm-2 mb-3 dta1 val'>".jsonvaluef($value,"document_type")." </div>";
				echo "<div class='col-sm-2 mb-3 bg-light border dta1 key $key'><strong>Document No : </strong></div><div class='col-sm-2 mb-3 dta1 val'>".jsonvaluef($value,"document_no")." </div>";
				echo "<div class='col-sm-2 mb-3 bg-light border dta1 key $key'><strong>Attached : </strong></div><a href='".$data['Host']."/user_doc/".jsonvaluef($value,"upload_logo")."' class='col-sm-2 mb-3 dta1 val' target='_blank'>View </a>";
				echo "<div class='col-sm-2 mb-3 bg-light border dta1 key $key'><strong>Created Date : </strong></div><div class='col-sm-2 mb-3 dta1 val'>".date('d/m/y H:iA',strtotime(jsonvaluef($value,"cdate")))." </div>";
			echo "</div>";
			$i++;
		}
	}
	//exit;
}

//This function is used to view encoded_contact_person_info info of a clients (only name,email,phone and designation)
function spoc_view($uid=0,$admin=false,$rows=''){
	global $data; $result=[];
	
	// for call dynamic fw icon
	if(empty($data['fwicon']['edit'])){$data['fwicon']['edit']="fas fa-edit";}
	if(empty($data['fwicon']['delete'])){$data['fwicon']['delete']="fas fa-trash-alt";}
	
	//fetch encoded_contact_person_info values from clients table
	$principal_db=db_rows(
		"SELECT `encoded_contact_person_info` FROM `{$data['DbPrefix']}clientid_table`".
		" WHERE `id`='{$uid}' LIMIT 1"//,true
	);
	$encoded_contact_person_info= $principal_db[0]['encoded_contact_person_info'];
	$principal_exp=explode('_;',$encoded_contact_person_info);	//explode explode via _;
	//echo "<hr/>count=".count($principal_exp);
	((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');
	
	if($admin){	//check $admin is TRUE or FALSE
		$path=$data['Host']."/include/verify{$data['ex']}?actionType=admin&id=".$uid;
	}else{
		$path=$data['Host']."/include/verify{$data['ex']}?id=".$uid;
	}
	
	
	
	$i=1;
	foreach($principal_exp as $principal_value){	//execute all rows one by one
		if($principal_value){
			$i++;
			
			$value = decryptres($principal_value);	//decrypt the encoded_contact_person_info value

			$key=$i;

			$fullname = jsonvaluef($value,"fullname");	//fetch fullname
			
			if($rows && $rows <= $i ){
				$result['fullname']=$fullname;
				$result['designation']=jsonvaluef($value,"designation");
				$result['phone']=jsonvaluef($value,"phone");
				$result['email']=jsonvaluef($value,"email").' '.get_ims_icon(jsonvaluef($value,"ims_type"));
				
				break;
			}
			
			
		//print values
		echo '<div class="col-sm-6 my-1">
		<div class="card rounded-3 shadow-sm border-primary">
			<div class="card-header py-3 text-white bg-primary border-primary">
			<h3 class="my-0 fs-6 text-white">SPOC Info : '.$fullname;
			if(isset($admin)&&$admin){  
				echo '<div class="col-sm-12 mb-3 text-end pull_right">'.'<a class="m-1" href="merlist'.$data['ex'].'?bid='.$principal_value.'&id='.$uid.'&action=update_principal'.$data['is_admin_link'].'&type='.(isset($post['type'])?$post['type']:'').'"><i class="'.$data['fwicon']['edit'].' text-white" title="Edit SPOC"></i></a>'.'<a href="merlist'.$data['ex'].'?bid='.$principal_value.'&id='.$uid.'&action=update_delete'.$data['is_admin_link'].'&type='.(isset($post['type'])?$post['type']:'').'" class="m-1" onclick="return cfmform()"><i class="'.$data['fwicon']['delete'].' text-white" title="Delete SPOC"></i></a></div>';
			}
$disp="";			
if(jsonvaluef($value,"email")==""){ $disp="hide"; }			
			
			echo '</h3>
		</div>
		<div class="card-body">
			<div class="row cardalignment">
			
				<div class="col-sm-2 text-start" title="Full Name">Name</div>
				<div class="col-sm-4 text-start">: '.$fullname.'</div>
				  
				  
				<div class="col-sm-2 text-start" title="Designation">Designation</div>
				<div class="col-sm-4 text-start">: '.jsonvaluef($value,"designation").'  </div>
				
				<div class="col-sm-2 text-start"  title="Contact Number">Contact</div>
				<div class="col-sm-4 text-start">: '.jsonvaluef($value,"phone").' </div>
				
				<div class="col-sm-2 text-start '.$disp.'" title="IM’S">IM’S</div>
				<div class="col-sm-4 text-start '.$disp.'">: '.jsonvaluef($value,"email").' '.get_ims_icon(jsonvaluef($value,"ims_type")).' </div>
				 
				 </div> 
			</div>
		</div>
	  </div>';
				

			
			
			
		}
	}
	
	if($rows) return $result;
	
	//exit;
}

//This function is used to view full encoded_contact_person_info info of a clients )
function principal_view($uid=0,$admin=false,$class='dta1'){
	global $data;
	//fetch encoded_contact_person_info values from clients table
	$principal_db=db_rows(
		"SELECT `encoded_contact_person_info` FROM `{$data['DbPrefix']}clientid_table`".
		" WHERE `id`='{$uid}' LIMIT 1"//,true
	);
	$encoded_contact_person_info= $principal_db[0]['encoded_contact_person_info'];
	$principal_exp=explode('_;',$encoded_contact_person_info);	//explode explode via _;
	//echo "<hr/>count=".count($principal_exp);
	((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');
	
	if($admin){	//check $admin is TRUE or FALSE
		$path=$data['Host']."/include/verify{$data['ex']}?actionType=admin&id=".$uid;
	}else{
		$path=$data['Host']."/include/verify{$data['ex']}?id=".$uid;
	}
	
	
	
	$i=1;
	foreach($principal_exp as $principal_value){	//execute all rows one by one
		if($principal_value){
			$value = decryptres($principal_value);	//decrypt the encoded_contact_person_info value
			//echo "<hr/>".$i;
			$key=$i;
			$email_verify=jsonvaluef($value,"email_verify");	//email
			$phone_verify=jsonvaluef($value,"phone_verify");	//phone

			if($email_verify=="Verified"){	//check email verified or not
$email_ver="<span title='Email have been Verified' style='color: rgb(0, 164, 30);'><i class='fas fa-times'></i></span>";
			}else{
				if($admin){	//if email not verified and admin true, then send verification email
				 $email_ver="<a target='_blank' href='".$path."&action=verification&type=email&bid=".$principal_value."' class='verify_input'>".$email_verify."</a>";
				}else{
					$email_ver="";
				}
			}
			
			if($phone_verify=="Verified"){	//check Phone verified or not
				$phone_ver="<span title='Phone have been Verified' style='color: rgb(0, 164, 30);'><i class='fas fa-times'></i></span>";
			}else{
				if($admin){	//if Phone not verified and admin true, then send verification email
					$phone_ver="<a target='_blank' href='".$path."&action=verification&type=phone&bid=".$principal_value."' class='verify_input'>".$phone_verify."</a>";
				}else{
					$phone_ver="";
				}
			}
			
			echo "<div class='row princ_bg border border-info m-2 px-2'>";
			if(isset($admin)&&$admin){  
				echo '<div class="col-sm-12 mb-3 text-end pull_right11">'./*.'<a class="m-1" href="merlist'.$data['ex'].'?bid='.$principal_value.'&id='.$uid.'&action=update_principal'.$data['is_admin_link'].'&type='.(isset($post['type'])?$post['type']:'').'"><i class="fas fa-edit text-info"></i></a>'.*/'<a href="merlist'.$data['ex'].'?bid='.$principal_value.'&id='.$uid.'&action=update_delete'.$data['is_admin_link'].'&type='.(isset($post['type'])?$post['type']:'').'" class="m-1" onclick="return cfmform()"><i class="fas fa-trash-alt text-danger"></i></a></div>';
			}
			$fullname = jsonvaluef($value,"fullname");	//fetch fullname
				
			

		//print all values
				echo "<div class='col-sm-3 my-2 dta1 key $key'><strong>Name :</strong> </div>
				<div class='col-sm-3 my-2 dta1 val'>&nbsp;".$fullname." </div>";
				
				echo "<div class='col-sm-3 my-2 dta1 key $key'><strong>Designation : </strong></div><div class='col-sm-3 my-2 dta1 val'>&nbsp;".jsonvaluef($value,"designation")." </div>";
				
				echo "<div class='col-sm-3 my-2 dta1 key $key'><strong>Phone : </strong></div>
				<div class='col-sm-3 my-2 dta1 val'>&nbsp;".jsonvaluef($value,"phone")." [ ".$phone_ver." ]</div>";
				
				echo "<div class='col-sm-3 my-2 dta1 key $key'><strong>Date of birth : </strong></div>
				<div class='col-sm-3 my-2 dta1 val'>&nbsp;".jsonvaluef($value,"birth_date")." </div>";
				
				echo "<div class='col-sm-3 my-2 dta1 key $key'><strong>Email : </strong></div>
				<div class='col-sm-3 my-2 dta1 val'>&nbsp;".encrypts_decrypts_emails(jsonvaluef($value,"email"),2,1)." [ ".$email_ver." ]</div>";
				
				
				echo "<div class='col-sm-3 my-2 dta1 key $key'><strong>Gender : </strong></div>
				<div class='col-sm-3 my-2 dta1 val'>&nbsp;".jsonvaluef($value,"gender")." </div>";
				
				echo "<div class='col-sm-3 my-2 dta1 key $key'><strong>Residential Address : </strong></div>
				<div class='col-sm-3 my-2 dta1 val'>&nbsp;".jsonvaluef($value,"address")." </div>";
				
				echo "<div class='col-sm-3 my-2 dta1 key $key'><strong>City : </strong></div>
				<div class='col-sm-3 my-2 dta1 val'>&nbsp;".jsonvaluef($value,"city")." </div>";
				
				echo "<div class='col-sm-3 my-2 dta1 key $key'><strong>State : </strong></div>
				<div class='col-sm-3 my-2 dta1 val'>&nbsp;".jsonvaluef($value,"state")." </div>";
				
				echo "<div class='col-sm-3 my-2 dta1 key $key'><strong>Country : </strong></div>
				<div class='col-sm-3 my-2 dta1 val'>&nbsp;".jsonvaluef($value,"country")." </div>";
				
				echo "<div class='col-sm-3 my-2 dta1 key $key'><strong>Zip : </strong></div>
				<div class='col-sm-3 my-2 dta1 val'>&nbsp;".jsonvaluef($value,"zip")." </div>";
				
				echo "<div class='col-sm-3 my-2 dta1 key $key'><strong>Document : </strong></div>
				<div class='col-sm-3 my-2 dta1 val'>&nbsp;".jsonvaluef($value,"document_type")." </div>";
				
				echo "<div class='col-sm-3 my-2 dta1 key $key'><strong>Document No. : </strong></div>
				<div class='col-sm-3 my-2 dta1 val'>&nbsp;".jsonvaluef($value,"document_no")." </div>";
				
				echo "<div class='col-sm-3 my-2 dta1 key $key'><strong>Created Date : </strong></div>
				<div class='col-sm-3 my-2 dta1 val'>&nbsp;".date('d/m/y H:iA',strtotime(jsonvaluef($value,"cdate")))." </div>";
			
				echo "<div class='row'><div class='col-sm-3 my-2 dta1 key $key'><strong>Attached : </strong></div> 
				<div class='col-sm-3 my-2 dta1 val'>".display_docfile("../user_doc/",jsonvaluef($value,"upload_logo"))."</div></div> ";
			
			echo "</div>";
			$i++;
		}
	}
	
	
	//exit;
}



//This function is used to total number of encoded_contact_person_info of a clients
function principal_count($uid){
	global $data;
	$result=db_rows(
		"SELECT COUNT(`id`) as total FROM `{$data['DbPrefix']}clientid_table`".
		" WHERE (`id`='{$uid}') AND (`encoded_contact_person_info` IS NOT NULL OR `encoded_contact_person_info` != '_;' OR `encoded_contact_person_info` != '')"
	);
	return $result[0]['total'];
}

//This function is used to verify encoded_contact_person_info
function select_principal($uid=0,$match='',$admin=false){
	global $data;$decrypt="";
	$principal_db=db_rows(
		"SELECT `encoded_contact_person_info` FROM `{$data['DbPrefix']}clientid_table`".
		" WHERE `id`='{$uid}' LIMIT 1"//,true
	);
	$principal_get= $principal_db[0]['encoded_contact_person_info'];
	//$principal_exp=explode($match.'_;',$principal_get);$principal_match=str_replace('_;','',$principal_exp[1]);
	
	if(strpos($principal_get,$match)!==false){
		$decryptres = decryptres($match);
		$decrypt=str_replace(array('{"','"}'),array('','","'),$decryptres);
	}
	return $decrypt;
}
//no use of this function but call from some pages so don't remove from here
function verify_email_phone($uid=0,$post=[],$action='',$otp='',$admin=false){
	global $data;
	
}
//This function currently not in used
function set_clients_status_ex($uid, $status){
	global $data;
	db_query(
		"UPDATE `{$data['DbPrefix']}clientid_table`".
		" SET `status`='{$status}'".
		" WHERE `id`='{$uid}'"
	);
	json_log_upd($uid,'clientid_table','action');	//update log
}
//This function is used to get clients status
function get_clients_status_ex($uid){
	global $data;
	//fetch status of a clients
	$record=db_rows(
		"SELECT `status` FROM `{$data['DbPrefix']}clientid_table`".
		" WHERE `id`='{$uid}' LIMIT 1"
	);
	if(isset($record[0]['status'])) return $record[0]['status'];	//return status if found
	
	return;	//return
}
//This function currently not in used
function set_clients_inactive($username){
	global $data;
	set_clients_status(get_clients_id($username), false);
}
//This function is used to delete clients profile
function delete_clients($uid){
	global $data;
  // For Delete subadmin added by vikash on 03/10/2022 
  $dresult=db_rows("SELECT * FROM `{$data['DbPrefix']}clientid_table` WHERE `id`='{$uid}'");
  $data['JSON_INSERT']=1;
  json_log_upd($gid,'clientid_table','Delete',$dresult,'');	//update log
	//permanently delete from DB
	db_query(
		"DELETE FROM `{$data['DbPrefix']}clientid_table` WHERE `id`='{$uid}'"
	);
}


//This function is used to update last login detail -- last login time and IP of a clients
function set_last_access($username){
	global $data;
	db_query(
		"UPDATE `{$data['DbPrefix']}clientid_table`".
		" SET `last_login_date`='".date("Y-m-d H:i:s")."',".
		"`last_login_ip`='{$_SERVER['REMOTE_ADDR']}'".
		" WHERE `id`=".get_clients_id($username)
	);
}
//This function is used to update last access time of a clients
function set_last_access_date($uid, $reset=false){
	global $data;
	if(!$reset)$curr=date("Y-m-d H:i:s");else $curr=0;
	db_query(
		"UPDATE `{$data['DbPrefix']}clientid_table`".
		" SET `last_login_date`='{$curr}'".
		" WHERE `id`='{$uid}'"
	);
}

//currenly this function not in use
function is_valid_mail($email){
	global $data;
	$result=db_rows(
		"SELECT `id` FROM `{$data['DbPrefix']}clientid_table`".
		" WHERE `email`='{$email}' LIMIT 1"
	);
	$emails=db_rows(
		"SELECT `id` FROM `{$data['DbPrefix']}clientid_emails`".
		" WHERE(`email`='{$email}') LIMIT 1"
	);
	return (bool)($result&&!$emails);
}
//This function is used to fetch security question / answer of a clients via email id
function get_clients_by_email($email){
	global $data;
	//To fetch password, question and answer of a clients via email id
	$result=db_rows(
		"SELECT `password`,`question`,`answer` FROM `{$data['DbPrefix']}clientid_table`".
		" WHERE `email`='{$email}'"
	);
	//If no record return from above query then first fetch clients id via email from clients_emails table then fetch password, question and answer of a clients via email id
	if(!$result){
		$emails=db_rows(
			"SELECT `clientid` FROM `{$data['DbPrefix']}clientid_emails`".
			" WHERE `email`='{$email}' LIMIT 1"
		);
		if($emails){
			$result=db_rows(
				"SELECT `password`,`question`,`answer` FROM `{$data['DbPrefix']}clientid_table`".
				" WHERE `id`='".$emails[0]['clientid']."'"
			);
		}
	}
	return $result[0];	//return password, question and answer
}
function is_info_empty($uid){
	global $data;
	/*
	$result=db_rows(
		"SELECT `edit_permission`".
		" FROM `{$data['DbPrefix']}clientid_table`".
		" WHERE `id`='{$uid}' LIMIT 1"
	);
	return (bool)$result[0]['edit_permission'];
	*/
}
function select_info($uid, $post){
	global $data;$result=array();
	$result=$post;
	$clients=get_clients_info($uid);
	if(!$clients){
		$_SESSION['uid']=0;
		$_SESSION['login']=false;
		header("Location:{$data['Host']}/index{$data['ex']}");
		echo('!ACCESS DENIED.');
		exit;
	}
	foreach($clients as $key=>$value)if(!isset($post[$key]))$result[$key]=$value;
	unset($result['json_value']);
	if($clients['json_value']){
		$result['profile_json']=jsondecode($clients['json_value'],1);
	}
	
	if(!$result['active']){
		$_SESSION['uid']=0;
		$_SESSION['login']=false;
		header("Location:{$data['Host']}/index{$data['ex']}");
		echo('!!ACCESS DENIED.');
		exit;
	}
	
	return $result;
}

function twoGmfa($sid=0,$mid=0,$code=0,$post=NULL){
	global $data;$secret='';$result=[];$pst=[];$tbl='clientid_table';$sitename='';$sub_id=0;$id=0;$qprint=0; $sponsorJsn=0;
	if($mid>0){ // clients
		$tbl='clientid_table';$id=$mid;
	}elseif($sid>0){
		$tbl='subadmin';$id=$sid;
		$sub_id=$sid;
		$sponsorJsn=1; 
		//$sitename=$sitename.':Admin';
	}
	
	$p=sponsor_themef($sid,$mid,$sponsorJsn);
	//print_r($p['clients']);
	if($p){
		if($sitename){
			$sitename=@$p['as']['SiteName'];
		}else{
			//$sitename=$data['SiteName'];
		}
		
		$email	=@$p['subadmin']['email'];
		$username=@$p['subadmin']['username'];
		
		if(isset($p['subadmin']['fullname'])&&$p['subadmin']['fullname'])	//check if fullname exists then use fullname
			$fullname=@$p['subadmin']['fullname'];
		else	//if fullname not exists then add fname+lname
			$fullname=@$p['subadmin']['fname']." ".@$p['subadmin']['lname'];
		
		if($mid>0){ // clients
			$email=@$p['clients']['email'];
			$username=@$p['clients']['username'];

			if(isset($p['clients']['fullname'])&&$p['clients']['fullname'])
				$fullname=@$p['clients']['fullname'];
			else
				$fullname=@$p['clients']['fname']." ".@$p['clients']['lname'];
		}
		
		if($code==1||$code==3){
			include($data['Path'].'/googleLib/GoogleAuthenticator'.$data['iex']);
			$ga = new GoogleAuthenticator();
			$secret = $ga->createSecret();
			$_SESSION['secret']=$secret;
			$result['secret']=$secret;
			
			//$qrLabel=$username." (".$sitename.")";
			
			$qrCodeUrl = $ga->getQRCodeGoogleUrl($username,$secret,$sitename);
			$_SESSION['qrCodeUrl']=$qrCodeUrl;
			$result['qrCodeUrl']=$qrCodeUrl;
			$eml=1;
		}else {
			$eml=0;
		}
		
		$query="UPDATE `{$data['DbPrefix']}{$tbl}` SET `google_auth_code`='{$secret}', `google_auth_access`='{$code}' WHERE `id`='{$id}' ";
		$_SESSION['query']=$query;
		db_query($query,$qprint);
		
		json_log_upd($id,$tbl,'2FA Activate'); // for json log history
		
		
		if($eml){
			$pst['clientid']=$id;
			$pst['username']=$username;
			$pst['email']=encrypts_decrypts_emails($email,2);
			$pst['fullname']=$fullname;
			$pst['sitename']=$sitename;
			$pst['text5']=$qrCodeUrl;
			$pst['text6']=$secret;
			$pst['email_header']=1;
			//$pst['prnt']=1;
			if(isset($_REQUEST['e'])){
				print_r($pst);
			}
			
			send_email('2FA-ACTIVATION-RESET-REQUEST',$pst,$sponsorJsn);	//DONE
		}
		
		
		$result=array_merge($result,$pst);
		
	}
	return $result;
}
function Google_Code_Generate($uid,$tbl=''){
			global $data;
			if ($tbl=='subadmin'){
				$sitename=$data['SiteName'].':Admin';
				
			}else{ // clients
				$admin_site_json=sponsor_json($uid);
				$sitename=$data['SiteName'];
			}
			include('../class/userClass'.$data['ex']);
			$userClass = new userClass();
			$userDetails=$userClass->userDetails($uid,$tbl);
			$email=$userDetails['email'];
			require_once ('../googleLib/GoogleAuthenticator'.$data['ex']);
			$ga = new GoogleAuthenticator();
			$secret = $ga->createSecret();
			
			$qrCodeUrl = $ga->getQRCodeGoogleUrl($email,$secret,$sitename);
			$_SESSION['qrCodeUrl']=$qrCodeUrl;
			return $secret;
}

function update_clients_password($uid, $password, $previous_passwords='',$notify=true,$google_auth_access='',$tbl='clientid_table'){
	global $data;
	$twoHourBack=date('Y-m-d H:i:s',strtotime('-2 hours'));
	$password ="`password`='{$password}',`password_updated_date`='{$twoHourBack}' ";

	if($previous_passwords){
		$password.=",`previous_passwords`='{$previous_passwords}'";
	}

	$qry="UPDATE `{$data['DbPrefix']}{$tbl}` SET ".
	$password.
	" WHERE `id`='{$uid}'";
	//echo $qry; exit;
	db_query($qry,0);
	
	if($notify){
		$post['clientid']=$uid;
		$post['username']=get_clients_username($uid);
		$post['email']=get_clients_email($uid);
		//send_email('UPDATE-MEMBER-PROFILE', $post);		//done
	}
}


function generate_private_key($uid){
	global $data;
	
	$get_clientid_details 				= select_client_table($uid);
	/*
	$secret_key['mid']		= "{$get_clientid_details['id']}";
	$secret_key['username']	= $get_clientid_details['username'];
	//$secret_key['date']		= date('Y-m-d H:i:s');
	$secret_key 			= json_encode($secret_key);
	//$secret_key 			= hash('sha256',$secret_key);
	*/
	$secret_key=$get_clientid_details['id']."_".date('YmdHis');
	
	$secret_key 			= encryptres($secret_key);
	$_SESSION['generate_private_'.$uid]=$secret_key;
	db_query(
		"UPDATE `{$data['DbPrefix']}clientid_table` SET `private_key`='{$secret_key}'".
		" WHERE `id`='{$uid}'",0
	);
	return $secret_key;
	//echo "<br/>secret_key=>".$secret_key; exit;
}

function get_referrals_count($uid){
	global $data;
	$result=db_rows(
		"SELECT COUNT(`id`) as total FROM `{$data['DbPrefix']}clientid_table`".
		" WHERE `sponsor`='{$uid}'"
	);
	return $result[0]['total'];
}
function optimize($uid){
	global $data;
	$fp=@fopen("{$data['Path']}/{$uid}{$data['ex']}", 'w+');
	@fwrite($fp, '');
	@fclose($fp);
}

function get_referrals($uid, $start=0, $count=0){
	global $data;
	$limit=($start?($count?" LIMIT {$start},{$count}":" LIMIT {$start}"):
		($count?" LIMIT {$count}":''));
	$get_clientid_details=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}clientid_table`".
		" WHERE `sponsor`='{$uid}' ORDER BY `cdate` DESC{$limit}"
	);
	$result=array();
	foreach($get_clientid_details as $key=>$value){
		$result[$key]['id']=$value['id'];
		$result[$key]['cdate']=prndate($value['cdate']);
		$result[$key]['username']=prnuser($value['id']);

		if(isset($value['fullname'])&&$value['fullname'])	//if fullname exist then use fullname
			$result[$key]['fullname']=$value['fullname'];
		
		$result[$key]['email']=$result[$key]['registered_email']=prntext(@$value['registered_email']);
		$result[$key]['referrals']=get_referrals_count($value['id']);
		$result[$key]['payments']=get_transactions_count(
			$value['id'], 'both', '`type`=0 AND `status`=1'
		);
		$result[$key]['earned']=prnpays(calculate_downline($uid, 1));
	}
	return $result;
}


//currently this function not in use 
function create_auto_account($autopost){
	global $data;
	$last_login_ip=$_SERVER['REMOTE_ADDR'];
	$emailArray = explode("@",trim($autopost['email']));
	$username = $emailArray[0];
	$nameArray = explode(" ",trim($autopost['ccholder']));
	if(count($nameArray)>1){
		$fname = $nameArray[0];
		$lname = $nameArray[1];    
    }
    else{
		$fname = $nameArray[0];
		$lname = '';
    }
	$Autopassword =rand();
	db_query(
		"INSERT INTO `{$data['DbPrefix']}clientid_table`(".
		"`username`,`password`,`registered_email`,`fullname`,`last_login_ip`,`active`,`created_date`".
		")VALUES(".
		"'{$username}','{$Autopassword}','{$autopost['email']}','{$autopost['fullname']}','{$last_login_ip}','1','".date('Y-m-d H:i:s')."')"
	);
	$code=gencode();
	$merID=newid();
	db_query("INSERT INTO `{$data['DbPrefix']}clientid_emails` 
	(`clientid`,`email`,`active`,`primary`) VALUES
	('{$merID}','".encrypts_decrypts_emails($autopost['email'],1)."',1,1)
	");
	
	$post['clientid']=$merID;
	$post['username']=$username;
	$post['password']=$Autopassword;
	$post['email']=$autopost['email'];
	send_email('SIGNUP-TO-MEMBER', $post);		//done
}


function send_mass_email($subject, $message, $active=-1, $acquirer=''){
	global $data;

	$get_clientid_details=db_rows(
		"SELECT `id`,`username`,`email`,`fullname`".
		" FROM `{$data['DbPrefix']}clientid_table`".
		($active<0?'':" WHERE `active`='{$active}'")
	);

	$msg="Mass Mailing from {$data['SiteName']} ";

/*
	$htmlheader = "<table border='0' cellspacing='0' cellpadding='0' width='100%' style='width: 100.0%; background: #C0C1C3'><tbody><tr><td style='padding: 0cm 0cm 0cm 0cm'><div align='center'><table border='0' cellspacing='0' cellpadding='0' width='600' style='width: 450.0pt'><tbody><tr><td style='padding: 0cm 0cm 0cm 0cm'><p align='right' style='text-align: right; line-height: 13.5pt'><span style='font-size: 8.5pt; font-family: &quot;Arial&quot;,sans-serif; color: #908F8F'>&nbsp;</span></p></td></tr></tbody></table></div></td></tr><tr><td style='padding: 0cm 0cm 0cm 0cm'><div align='center'><table border='0' cellspacing='0' cellpadding='0' width='600' style='width: 450.0pt'><tbody><tr><td style='padding: 0cm 0cm 0cm 0cm'><div align='center'><table border='0' cellspacing='0' cellpadding='0' width='100%' style='width: 100.0%; background: white'><tbody><tr><td style='padding: 1cm 1cm 01m 1cm;background-color:#696969;'><p style='line-height: 20.0pt'><span style='font-size: 10.0pt; font-family: &quot;Arial&quot;,sans-serif; color: #2E2E2E;'><img border='0' width='600' height='115' style='width: 1.25in; height: .5in' id='_x0000_i1025' src='{$data['domain_logo']}' alt='Digital Currency Exchange'><!-- o ignored --></span></p></td></tr><tr><td style='padding: 0cm 0cm 0cm 0cm'><table border='0' cellspacing='0' cellpadding='0' width='100%' style='width: 100.0%; background: white'><tbody><tr><td width='25' style='width: 18.75pt; padding: 0cm 0cm 0cm 0cm'></td><td style='padding: 20px 0cm 0cm 0cm'>";
	$htmlfooter = "<span style='font-size: 7.5pt; font-family: &quot;Arial&quot;,sans-serif; color: #2E2E2E'>You can also contact us anytime at <a href='mailto:{$data['AdminEmail']}' onclick='return rcmail.command('compose','{$data['AdminEmail']}',this)' rel='noreferrer'><span style='color: #9C220C'>{$data['AdminEmail']}</span></a>. <!-- o ignored --></span></p></td><td width='25' style='width: 18.75pt; padding: 0cm 0cm 0cm 0cm'></td></tr></tbody></table></td></tr><tr><td style='padding: 0cm 0cm 0cm 0cm'><p style='line-height: 20.0pt'><span style='font-size: 10.0pt; font-family: &quot;Arial&quot;,sans-serif; color: #2E2E2E'><map name='MicrosoftOfficeMap0'><area shape='Rect' coords='162, 8, 189, 36' href='https://twitter.com/' target='_blank' rel='noreferrer'><area shape='Rect' coords='127, 7, 155, 36' href='https://www.facebook.com//' target='_blank' rel='noreferrer'></map><img border='0' width='600' height='47' style='width: 6.25in; height: .4916in' id='_x0000_i1026' src='{$data['Host']}/images/email-footer.jpg' usemap='#MicrosoftOfficeMap0'><!-- o ignored --></span></p></td></tr><tr><td style='padding: 0cm 0cm 0cm 0cm'><table border='0' cellspacing='0' cellpadding='0' width='100%' style='width: 100.0%; background: #C0C1C3'><tbody><tr><td width='25' style='width: 18.75pt; padding: 0cm 0cm 0cm 0cm'></td><td style='padding: 0cm 0cm 0cm 0cm'><p style='line-height: 13.0pt'><span style='font-size: 8.5pt; font-family: &quot;Arial&quot;,sans-serif; color: #8D8C8C'>Please note: This e-mail message was sent from a notification-only address that cannot accept incoming e-mail -- visit <a href='{$data['Host']}' target='_blank' rel='noreferrer'><span style='color: #8D8C8C'>{$data['domain_name']}</span></a> if you need assistance.<!-- o ignored --></span></p><p style='line-height: 13.0pt'><span style='font-size: 8.5pt; font-family: &quot;Arial&quot;,sans-serif; color: #8D8C8C'>Copyright 2018 {$data['SiteName']}. All Rights Reserved.<!-- o ignored --></span></p></td><td width='25' style='width: 18.75pt; padding: 0cm 0cm 0cm 0cm'></td></tr></tbody></table></td></tr></tbody></table></div></td></tr></tbody></table></div></td></tr></tbody></table></td><td width='25' style='width: 18.75pt; padding: 0cm 0cm 0cm 0cm'></td></tr></tbody></table></td></tr></tbody></table></div></td></tr></tbody></table></div></td></tr></tbody></table>";

	$headers = "MIME-Version: 1.0\r\n";
	$headers.= "Content-type: text/html; charset=utf-8\r\n";
	$headers.= "From: {$data['AdminEmail']}\r\n";
	*/
	
	$i=0;
	$emailList="";
	if($acquirer){
		foreach($get_clientid_details as $value){
			//$messages	=	$htmlheader.$message.$htmlfooter;
			$messages	=	$message;
			$ms_get=mer_settings($value['id'], 0, true, $acquirer);
			
			//echo "<br/>ms_get=>"; print_r($ms_get);
			//if(isset($ms_get)&&($ms_get)&&isset($ms_get['id'])&&$ms_get['id'])
			if(isset($ms_get)&&($ms_get))
			{
				//mail($value['email'],$subject,$messages,$headers);
				
				$post['clientid']=$value['id'];
				$post['tableid']=$ms_get[0]['id'];
				$post['mail_type']="2";
				$emailList.=$email=encrypts_decrypts_emails($value['email'],2).", ";
				if(!isset($_GET['etest'])){
				 send_attchment_message($email,$email,$subject,$messages,$post);
				 }
				$i++;
			}
		}
	}else{
		foreach($get_clientid_details as $value){
			//$messages	=	$htmlheader.$message.$htmlfooter; 
			$messages	=	$message;
			//mail($value['email'],$subject,$messages,$headers);
			$post['clientid']=$value['id'];
			$post['tableid']=$value['id'];
			$post['mail_type']="3";
			//$emailList.=$email=$value['email'].", ";
			$emailList.=$email=encrypts_decrypts_emails($value['email'],2).", ";
			if(!isset($_GET['etest'])){
				send_attchment_message($email,$email,$subject,$messages,$post);
			}
			$i++;
		}
	}
	$result=array();
	$result['count']=$i;
	$result['emailList']=$emailList;
	return $result;
}


function get_clients_count($active=0,$order=0,$join='',$where='',$in_id=''){
	global $data;
	$orderby="";
	
	if(((isset($_SESSION['sub_admin_id']))&&($_SESSION['get_mid']!='M. All'))||($in_id)){
		
		if((isset($_SESSION['get_mid']))&&($_SESSION['get_mid']!='M. All')){
			$in_id=((isset($_SESSION['get_mid'])&&$_SESSION['get_mid'])?$_SESSION['get_mid']:'0');
		}
		$orderby=($in_id?" AND ( id IN ({$in_id}) ) ":"").($where?" ORDER BY count ":" ");
	}
	
	$count_id="`id`";
	if($where){
		$count_id="`{$data['DbPrefix']}clientid_table`.`id`";
		$join=str_replace("m.","`{$data['DbPrefix']}clientid_table`.",$join);
		$where=str_replace("m.","`{$data['DbPrefix']}clientid_table`.",$where);
		//$orderby = " GROUP BY $count_id ";
		// $orderby = " ORDER BY count ";
		
	}
	
	if ((isset($_REQUEST['mid']))&& ($_REQUEST['mid']!='')){
		//$where="WHERE sponsor=".$_REQUEST['mid'];
		$where="WHERE sponsor='".$_REQUEST['mid']."' AND (active='{$active}') ";
		$active= '';
	}else {
	    if($active==5){    // condation 
			$active="WHERE 1 ";
		}else{
			$active="WHERE (active='{$active}')";
		}
	}
		
	
	$q= "SELECT COUNT($count_id) AS `count`";
	$q.=" FROM `{$data['DbPrefix']}clientid_table`".$join;
	$q.=" ".$active." ".$where.$orderby;
	$q.=" LIMIT 1";
	
	$result=db_rows($q,0);
	if(isset($result[0])) return $result[0]['count']; 
	else return 0; 
}

function upgrade_limit($uid,$post){	
	global $data;
	db_query("UPDATE `{$data['DbPrefix']}clientid_table`"." SET `amount_transaction_limit`='{$post['amount_transaction_limit']}' WHERE `id`='{$uid}'");
}


function get_email_details_count($status=0,$filterid=0){
	global $data;
	
	$sponsor_qr="";$sponsor_tbl="";
	if((isset($_SESSION['sub_admin_id']))&&($_SESSION['get_mid']!='M. All')){
		
		$get_mid=$_SESSION['get_mid'];
		
		$sponsor_qr="  AND  ( m.id IN ({$get_mid}) )   "; //GROUP BY m.id ORDER BY count
		
		$sponsor_tbl=", {$data['DbPrefix']}clientid_table AS m";
	}
	
	
	
	$result=db_rows(
		"SELECT COUNT(s.id) AS `count` FROM {$data['DbPrefix']}email_details AS s".$sponsor_tbl.
		" WHERE s.status='{$status}' ".$sponsor_qr.
		" ORDER BY s.id DESC LIMIT 1"//,true
	);
	if(isset($result[0])) return $result[0]['count']; 
	else return 0;
}


function daily_trans_statement_amt($uid=0,$currentDate='', $checkBatchDate=''){
	global $data; $result=array();
	$qprint=0; $where_clients=""; $where_statement="";
	if(isset($_GET['qp'])){
		$qprint=1;
		echo "<hr/><==daily_trans_statement_amt==><hr/>";
	}
	
	if($uid>0){
		$where_clients=" WHERE `id`='{$uid}' ";
		$where_statement=" AND `clientid`='{$uid}' ";
	}
	
	$date_1st=date('Y-m-d');
	if($currentDate){
		$date_1st=date("Y-m-d",strtotime($currentDate));
		$date_2nd=$date_1st;
	}
	
	$date_range=$date_1st;
	$date_2nd_qry=date("Y-m-d",strtotime("+1 day",strtotime($date_1st)));
	
	if(is_array($currentDate)){
		//print_r($currentDate);
		$date_1st=date("Y-m-d",strtotime($currentDate['date_1st']));		
		$date_2nd=date("Y-m-d",strtotime($currentDate['date_2nd']));		
		
		$date_2nd_qry=date("Y-m-d",strtotime("+1 day",strtotime($currentDate['date_2nd'])));
		
		$date_range['date_1st']=$date_1st;
		$date_range['date_2nd']=$date_2nd;
	}
	
	
	
	
	
	//print_r($date_range);
	
	$max_cdate=db_rows(
		"SELECT MAX(`batch_date`) AS `cdate`, MAX(`id`) AS `max_id`, MIN(`id`) AS `min_id`".
		" FROM `{$data['DbPrefix']}daily_tras_statement`".
		" WHERE ( `batch_date` BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d')) AND (DATE_FORMAT('{$date_2nd_qry}', '%Y%m%d')) )  ".
		$where_statement.
		" LIMIT 1",0
	);	

	$result['max_cdate']=$max_cdate[0]['cdate'];
	//$result['max_id']=$max_cdate[0]['max_id'];
	$result['min_id']=$max_cdate[0]['min_id'];
	
	//echo "<hr/>max_cdate=>".$result['max_cdate']; echo "<hr/>batch_date=>".date("Ymd",strtotime($date_1st)).$uid;
	//exit;
	
	
	
	if((empty($result['max_cdate']))&&(!empty($checkBatchDate))){
		if($uid>0){
			$ab=account_trans_balance($uid,$date_range,"");
			$result['ab']=$ab;
			$post=$result['ab'];
			$post['batch_date']=$date_1st;
			daily_trans_statement_insert($uid,$post);		
		}else{
			$get_clientid_details=db_rows(
				"SELECT id FROM `{$data['DbPrefix']}clientid_table`".
				" ".$where_clients." "
			);
			foreach($get_clientid_details as $key=>$value){
				$uid=$value['id'];
				$ab=account_trans_balance($uid,$date_range,"");
				$result['ab']=$ab;
				$post=$result['ab'];
				$post['batch_date']=$date_1st;
				daily_trans_statement_insert($uid,$post);
			}
			$result['clients']=count($get_clientid_details);
		}
	
	}else{
	/*
	echo "<hr/>checkBatchDate=>".$checkBatchDate."<hr/>";
	echo "<hr/>checkBatchDate=>".$date_range."<hr/>";
	echo "<hr/>uid=>".$uid."<hr/>";echo "<hr/>batch_date=>".$post['batch_date']."<hr/>";
	*/
		if($uid>0){
			$ab=account_trans_balance($uid,$date_range,"");
			$result['ab']=$ab;
			$post=$result['ab'];
			$post['batch_date']=$date_1st;
			daily_trans_statement_update($result['min_id'],$post);		
		}
	}
	
	
	
	
   return $result;
}

function daily_statement_amt($uid=0,$currentDate=''){
	global $data; $result=array();
	$qprint=0; $where_clients=""; $where_statement="";
	if(isset($_GET['qp'])){
		$qprint=1;
		echo "<hr/><==payout_trans==><hr/>";
	}
	
	if($uid>0){
		$where_clients=" WHERE `id`='{$uid}' ";
		$where_statement=" AND `clientid`='{$uid}' ";
	}
	
	$date_1st=date('Y-m-d');
	if($currentDate){
		$date_1st=date("Y-m-d",strtotime($currentDate));
	}
	
	$date_2nd=date("Y-m-d",strtotime("+1 day",strtotime($date_1st)));
	
	if(is_array($currentDate)){
		//print_r($currentDate);
		$date_1st=date("Y-m-d",strtotime($currentDate['date_1st']));		
		$date_2nd=date("Y-m-d",strtotime("+1 day",strtotime($currentDate['date_2nd'])));
	}
	
	
	
	$date_range['date_1st']=$date_1st;
	$date_range['date_2nd']=$date_2nd;
	
	//print_r($date_range);
	
	$max_cdate=db_rows(
		"SELECT MAX(`batch_date`) AS `cdate`".
		" FROM `{$data['DbPrefix']}daily_statement`".
		" WHERE ( `batch_date` BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d')) AND (DATE_FORMAT('{$date_2nd}', '%Y%m%d')) )  ".
		$where_statement.
		" LIMIT 1",0
	);	

	$result['max_cdate']=$max_cdate[0]['cdate'];
	
	//echo "<hr/>max_cdate=>".$result['max_cdate']; echo "<hr/>batch_date=>".date("Ymd",strtotime($date_1st)).$uid;
	//exit;
	
	
	if(empty($result['max_cdate'])){
		if($uid>0){
			$ab=account_balance($uid,"",$date_range);
			$result['ab']=$ab;
			$post=$result['ab'];
			$post['batch_date']=$date_1st;
			daily_statement_insert($uid,$post);		
		}else{
			$get_clientid_details=db_rows(
				"SELECT id FROM `{$data['DbPrefix']}clientid_table`".
				" ".$where_clients." "
			);
			foreach($get_clientid_details as $key=>$value){
				$uid=$value['id'];
				$ab=account_balance($uid,"",$date_range);
				$result['ab']=$ab;
				$post=$result['ab'];
				$post['batch_date']=$date_1st;
				daily_statement_insert($uid,$post);
			}
			$result['clients']=count($get_clientid_details);
		}
	
	}
	
	
	
	
   return $result;
}

function codedisable($mid,$tbl){
	global $data;
	
	$qry="UPDATE `{$data['DbPrefix']}{$tbl}`"." SET `google_auth_access`=2, `google_auth_code`=''  WHERE `id`='{$mid}'";
	$check=db_query($qry);
	json_log_upd($mid,$tbl,'2FA De Activate'); // for json log history
}// end function
function merchant_details($ajax=0){
	global $data;
	
	$query_mid ="";
	if((isset($_SESSION['sub_admin_id']))&&($_SESSION['get_mid']!='M. All')){
		$get_mid=$_SESSION['get_mid'];
		
		$query_mid ="  AND  ( id IN ({$get_mid}) )  ";

	}
	
	$sql= "SELECT `id`,`username`,`fullname` FROM `{$data['DbPrefix']}clientid_table` WHERE `sub_client_id` is NULL {$query_mid} ORDER BY username,fullname,id ASC";
	$result=db_rows($sql);
	//$_SESSION['sql']=$sql;
	if($ajax==2){
		$merchant_details=[];
		sort($result);
		foreach ($result as $key=>$value) { 
			if(!empty($value['username'])){

				$fullname=$value['fullname'];

				$merchant_details[$value['id']]="[{$value['id']}] {$value['username']} | {$fullname}";
			}
		}
		$result=$merchant_details;
		$_SESSION['merchant_details']=$result;
	}
	
	return $result;
}// End Function

function sub_admin_details($ajax=0){
	global $data;
	
	$query_mid ="";
	if((isset($_SESSION['sub_admin_id']))&&($_SESSION['get_mid']!='M. All')){
		$get_mid=$_SESSION['get_mid'];
		
		//$query_mid ="  WHERE  ( id IN ({$get_mid}) )  ";

	}
	
	$sql= "SELECT `id`,`username`,`fullname` FROM `{$data['DbPrefix']}subadmin` {$query_mid}  ORDER BY username,fullname,id ASC";
	$result=db_rows($sql);
	//$_SESSION['sql']=$sql;
	if($ajax==1||$ajax==2){
		$sub_admin=[];
		sort($result);
		foreach ($result as $key=>$value) { 
			if(!empty($value['username'])){

				$fullname=$value['fullname'];
				
				$ct=select_tablef("`sponsor` IN ({$value['id']}) AND active=1 ",'clientid_table',0,1," COUNT(`id`) AS `count`, ".group_concat_return('`id`',0)." AS `ids` ");
				
				if($ajax==1){
					$sub_admin[$ct['ids']]="Total Mer: {$ct['count']} | {$value['id']} | {$value['username']} | {$fullname}";
				}
				else {
					$sub_admin[$value['id']]="Total Mer: {$ct['count']} | {$value['id']} |  {$value['username']} | {$fullname}";
				}
				
			}
		}
		$result=$sub_admin;
		$_SESSION['sub_admin']=$result;
	}
	
	return $result;
}// End Function

function getuserimage($user,$ajax){
	
	global $data;
	$sql= "SELECT id,upload_logo FROM `{$data['DbPrefix']}clientid_table` where `id`='".$user."' limit 1";
	$result=db_rows($sql);
	$id=$result['0']['id'];
	$logo=$result['0']['upload_logo'];
	$ext=get_file_extention($logo);
	
	$logo=$data['Host']."/user_doc/".$logo;
	$encrypted_logo = encrypt_decrypt('encrypt', $logo);

		
	if (file_exists("../user_doc/".$result['0']['upload_logo'])){
	
	if (($ext=="jpe")||($ext=="jpg")||($ext=="png")||($ext=="jpeg")||($ext=="gif")){
		?><a href="<?=$data['Host'];?>/userimg<?=$data['ex']?>?img=<?=$encrypted_logo;?>" target="_blank" style="display:inline-block;margin:0 10px 0 0;width:100px;overflow:hidden;"><img src="<?=$logo?>" style="height:40px;" /></a>
    <? }
	else if ($ext=="pdf"){
		?><a href="<?=$logo;?>" title="Download PDF" alt="Download PDF" target="_blank" style="display:inline-block;margin:0 10px 0 0;width:100px;overflow:hidden;"><img src="<?=$data['Host']?>/images/pdf.png" style="height:40px;" /></a>
    <? }else	{
		?><a href="<?=$logo;?>" title="Download the Document" alt="Download the Document" target="_blank" style="display:inline-block;margin:0 10px 0 0;width:100px;overflow:hidden;"><img src="<?=$data['Host']?>/images/download.png" style="height:40px;" /></a>
    <? }// End if file extention	
	}
	
	
	else {
	?>
	<a href="<?=$data['Host']?>/images/No_image_available.svg" target="_blank" style="display:inline-block;margin:0 10px 0 0;width:100px;overflow:hidden;">
	<img src="<?=$data['Host']?>/images/No_image_available.svg" style="height:40px;" /></a>
	<?
	}
	
}// End Function




//The function is_mail_available() is used to check registered email availability
function is_mail_available($email){
	global $data;

	//fetch email list from confirms table
	$confirms=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}unregistered_clientid`"
		//" WHERE(`newmail`='{$email}') LIMIT 1"
	);

	//fetch email list from clients table
	$get_clientid_details=db_rows(
		"SELECT *FROM `{$data['DbPrefix']}clientid_table`"
		//" WHERE(`email`='{$email}') LIMIT 1"
	);

	//fetch email list from clients_emails table
	$emails=db_rows(
		"SELECT *FROM `{$data['DbPrefix']}clientid_emails`"
		//" WHERE(`email`='{$email}') LIMIT 1"
	);
	$emailList	= array();

	//store all emails in an array after decrypt
	if(isset($confirms)){
		foreach ($confirms as $key=>$value) {
			$emailList[] = encrypts_decrypts_emails($value['newmail'], 2);
		}
	}
	if(isset($get_clientid_details)){
		foreach ($get_clientid_details as $key=>$value) {
			$emailList[] = encrypts_decrypts_emails($value['email'], 2);
		}
	}
	if(isset($emails)){
		foreach ($emails as $key=>$value) {
			$emailList[] = encrypts_decrypts_emails($value['email'], 2);
		}
	}
	
	if (in_array(strtolower($email), $emailList))
	{
		return false;	//return false if email already exists
	}
	else
	{
		return true;	//return true if email not registered
	}
	//return (bool)(!$confirms&&!$get_clientid_details&&!$emails);
}

//The upgrade_tr_countf() used to update number of transaction of a merchant.
function upgrade_tr_countf($uid=0){	
	global $data;
	/*
	if($uid>0){
		//fetch total count from clients table
		$get_clientid_details_sl=db_rows(
			"SELECT `id`,`tr_count` FROM `{$data['DbPrefix']}clientid_table`".
			" WHERE `id`='{$uid}' LIMIT 1"//,true
		);
		$get_clientid_details_sl=$get_clientid_details_sl[0];
		$tr_count=((int)$get_clientid_details_sl['tr_count']+1);	//increase total count
		
		//update counter
		db_query("UPDATE `{$data['DbPrefix']}clientid_table` SET `tr_count`='{$tr_count}' WHERE `id`='{$uid}'");
	}
	*/
}




#### Dev Tech : 23-05-31 end - modify table for clilent,paying,payout #########

















//print_r($data['acquirer_refund']);
// Added and updated  from old backup  on 05042023
//Fetch number of transaction and total amount of a merchant via website. (Only success and refund)
function select_sold($uid,$store_id){
	global $data;
	$result=array();
	$where_pred="";
	
	if($uid>0){
		$where_pred=" AND `merID`='{$uid}' ";
	}
	$trans=db_rows("SELECT SUM(`trans_amt`) AS `summ`, COUNT(`id`) AS `count`".
		" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
		" WHERE (`trans_status` IN (1,7) ) AND `acquirer` IN ({$store_id}) ".$where_pred." LIMIT 1",0);
	
	$result['sold']=prnsum2($trans[0]['summ']);
	$result['count']=$trans[0]['count'];
	return $result;
}

// Added and updated  from old backup  on 11042023
//function to generate transaction id
function create_transaction_id($field1='', $field2='')
{
	$txn_id = '';
	
	if($field1) $txn_id = $field1;
	if($field2) $txn_id .= $field2;
	//$txn_id .= date('Ymd').'_'.time();
	$txn_id .= time();
	
	return $txn_id;
}
// For remove special char and make first char on uppercase
function create_title($str)
{
	$str=ucwords(str_replace([':', '  ', '-', '_'],' ',$str));
	return $str;
}










function create_client_info($post, $admin=false){
	global $data;
	//print_r($post);exit;

	if((!isset($post['default_currency'])||!$post['default_currency'])&&$data['con_name']=='clk'){
		$post['default_currency']='INR';
	}
	
	if((!isset($post['country'])||!$post['country'])&&$data['con_name']=='clk'){
		$country='IN';
	}else $country=(isset($post['country'])&&$post['country']?$post['country']:'');
	
	if(isset($_POST['action'])){ unset($_POST['action']);}
	if(isset($_POST['send'])){ unset($_POST['send']);}
	if(isset($_POST['tab_name'])){ unset($_POST['tab_name']);}
	if(isset($_POST['gid'])){ unset($_POST['gid']);}
	if(isset($_POST['StartPage'])){ unset($_POST['StartPage']);}

	$json_value=json_encode($_POST);
	
//	echo $json_value;exit;
	if(isset($post['registered_email'])&&$post['registered_email'])
		$post_email = encrypts_decrypts_emails($post['registered_email'],3);
	else $post_email = "";
//echo $post_email.'---'.$post['registered_email'];exit;
	if($admin){
		$is_active='1';
		$adm_fld=",`status`,`ip_block_client`,`edit_permission`,`default_currency`,`description`";
		$adm_pst=",'2','1','{$post['edit_permission']}','{$post['default_currency']}','{$post['description']}'";
		
		$adm_fld_3="";
		$adm_pst_3="";
		$payin_status='2';
	} else {
		$is_active='0';
		$adm_fld="";
		$adm_pst="";
		
		$adm_fld_3="";
		$adm_pst_3="";
		$payin_status='1';
	}
	
	
	
	
	$password=hash_f($post['password']);
	$insertSql = "INSERT INTO `{$data['DbPrefix']}clientid_table`(".
		"`sponsor`,`username`,`password`,`registered_email`,`active`,".
		"`fullname`,`company_name`,`json_value`,`country`".$adm_fld.
		")VALUES(".
		"{$post['sponsor']},'{$post['username']}','{$password}',".
		"'{$post_email}','{$is_active}','{$post['fullname']}',".
		"'{$post['company_name']}','{$json_value}','{$country}'".$adm_pst.
		")";
		
	//echo $insertSql;exit;
	db_query($insertSql,0);
	$newid=newid();
	
	if($newid>0){
		create_payin_setting($newid);
	}
	
	json_log_upd($newid,'clientid_table','insert'); // for json log history
	$post['uid']=$newid;
	$post['clientid']=$newid;
	$post['email_he_on']=1;
	
	db_query("INSERT INTO `{$data['DbPrefix']}clientid_emails` 
	(`clientid`, `email`, `active`, `primary`, `verifcode`) VALUES
	('{$newid}','{$post_email}',1,1,'')
	",0);
	
	
	if($admin&&$post['registered_email']&&$newid){
		$post['email']=$post['registered_email'];
		send_email('SIGNUP-TO-MEMBER', $post);		//done
	}
	//print_r($post);exit;
	return $newid;
}
function update_client_info($post, $uid, $notify=false, $admin=false){
	global $data;
	$set_update="";
	$get_clientid_details_tbl=select_table_details($uid,'clientid_table',0);
	$profile_json=jsondecode($get_clientid_details_tbl['json_value']);

	$json_value=keym_f($_POST,$profile_json);
	
	if(isset($json_value['description']))unset($json_value['description']);
	if(isset($json_value['description_history']))unset($json_value['description_history']);
	$post=array_merge($post,$json_value);
	$json_value=jsonencode($json_value);
	
	//print_r($get_clientid_details_tbl['json_value']);echo "<br/><br/>profile_json post=><br/>";print_r($profile_json);
	//echo "<br/><br/>json_value post=><br/>".$json_value;exit;
	
	if(!isset($post['sponsor']) || !$post['sponsor'])	$post['sponsor']=0;
	$post['clientid']= $uid;
	
	if((!isset($post['default_currency'])||!$post['default_currency'])&&$data['con_name']=='clk'){
		$post['default_currency']='INR';
	}
	
	if($admin){
		$set_update.=",`default_currency`='{$post['default_currency']}',`edit_permission`='{$post['edit_permission']}',`registered_address`='{$post['registered_address']}',`sponsor`='".$post['sponsor']."' ";
	}else{
		
		if((!isset($post['default_currency'])||!$post['default_currency'])&&$data['con_name']=='clk'){
			$set_update.=",`default_currency`='{$post['default_currency']}'";
		}
	}
	
	if((isset($post['country'])&&trim($post['country']))&&$data['con_name']!='clk'){
		$set_update.=",`country`='{$post['country']}'";
	}

	@db_query(
		"UPDATE `{$data['DbPrefix']}clientid_table` SET ".
		"`company_name`='{$post['company_name']}',".
		"`fullname`='{$post['fullname']}',".
		"`json_value`='{$json_value}',".
		"`description`='{$post['description']}'".$set_update.
		" WHERE `id`='{$uid}'",0
	);
	if(isset($post['exist_email'])&&$post['exist_email'])
	{
		deleted_profile_email($uid,$post['exist_email']);
	}
	json_log_upd($uid,'clientid_table','action');	//update json log history
	//exit;
	if($notify){
		$post['clientid']=($uid);
		$post['email']=get_clients_email($uid);
		//send_email('UPDATE-MEMBER-PROFILE', $post);	//done
	}
	//exit;
}


// label_namef : label name make first letter uppercase in a UILabel
function label_namef($string) {
	$string =(preg_replace('/([^A-Z])([A-Z])/', "$1 $2", $string));
    $string =ucwords(strtolower($string));
    foreach (array('-','_',' ', '\'') as $delimiter) {
      if (strpos($string, $delimiter)!==false) {
        $string =implode(' ', array_map('ucfirst', explode($delimiter, $string)));
      }
    }
    return $string;
}


//The use of payout_idf() function is fetch payout id from a bank_payout_table
function payout_idf($payout_id=0, $list=1, $limit=1){
	global $data; $result=array(); $where_apend="";
	
	if($payout_id>0&&$limit>0) $where_apend=" WHERE `payout_id`='{$payout_id}'  LIMIT 1   ";
	
	//fetch for encode_processing_creds
	$select_pt=db_rows(
		"SELECT `payout_id`,`payout_status`,`payout_prod_mode`,`encode_processing_creds` FROM `{$data['DbPrefix']}bank_payout_table` {$where_apend}  ",0
	);
	
	array_multisort(array_column($select_pt, 'payout_status'), SORT_DESC, $select_pt);	//sort array via acquirer_status
	
	foreach($select_pt as $key=>$value){
		$json_epc_de=decode_f($value['encode_processing_creds']);
		$json_epc=jsondecode($json_epc_de,1,1);
		
		if($list==1&&isset($json_epc)&&is_array($json_epc)){
			$result[$value['payout_id']]['json']=$json_epc;
			$result[$value['payout_id']]['payout_status']=$value['payout_status'];
			$result[$value['payout_id']]['payout_prod_mode']=$value['payout_prod_mode'];
			$result[$value['payout_id']]['payout_id']=$value['payout_id'];
		}
	}
	//sort(array_unique($result['payout_id']));
	return $result;		
}






#####  Acquirer Label	########################################


//The icon_option_list_f() use for fetch the mop from icon_table
function chosen_icon_f($list=0, array $icon_code=[]){
	$icon_option_list=[]; 
	foreach($icon_code as $key=>$value){
		if($list==1){
			if(strpos($value,'fa-')!==false){
				$icon_option="<option title='{$value}' value='{$value}'>{$value} | ICON</option>";
			}
			
		}elseif($list==2){
			if(strpos($value,'fa-')!==false){
				
			}else{
				$icon_option="<option title='../images/icons/{$value}' value='{$value}'>{$value}</option>";
			}
			 
		}elseif($list==3){
			if(strpos($value,'fa-')!==false){
				$icon_option="<option title='{$value}' value='{$value}'>{$value} </option>";
			}else{
				$icon_option="<option title='../images/icons/{$value}' value='{$value}'>{$value}</option>";
			}
		}
		
		$icon_option_list[]=$icon_option;
	}
	
	return implode('',$icon_option_list); 
}

//The mop_option_list_f() use for fetch the mop from mop_table
function mop_option_list_f($list=0, $mop_name=''){
	global $data; $result=array(); $mop_option_list=[]; $mop_list=[];
	
	if(trim($mop_name)&&strpos($mop_name,',')!==false){
		$mop_name = implode("','" , array_unique(explode(",",$mop_name)));
	}
	
	$select_db=db_rows(
		"SELECT `id`,`mop_name`,`mop_code` FROM `{$data['DbPrefix']}mop_table`".
		" WHERE `mop_status` IN (1) ".($mop_name?" AND `mop_name` IN ('{$mop_name}') ":""),0
	);
	foreach($select_db as $key=>$value){
		if($list==1){
			if(strpos($value['mop_code'],'fa-')!==false){
				$mop_option="<option title='{$value['mop_code']}' value='{$value['mop_name']}'>{$value['mop_name']} </option>";
			}elseif(strpos($value['mop_code'],'http')!==false){
				 $mop_option="<option title='{$value['mop_code']}' value='{$value['mop_name']}'>{$value['mop_name']}</option>";
			}else{
				$mop_option="<option title='../bank/{$value['mop_code']}' value='{$value['mop_name']}'>{$value['mop_name']}</option>";
			}
			$mop_option_list[]=$mop_option;
		}elseif($list==2){
			if(strpos($value['mop_code'],'fa-')!==false){
				 $symbol="<i title='{$value['mop_name']}' class='{$value['mop_code']} text-primary' style='font-size:20px;vertical-align:middle;'></i>";
			}elseif(strpos($value['mop_code'],'http')!==false){
				 $symbol="<img title='{$value['mop_name']}' src='{$value['mop_code']}' class='img-fluid' style='height:18px;vertical-align:middle;' />";
			 }else{
				  $symbol="<img title='{$value['mop_name']}' src='{$data['Host']}/bank/{$value['mop_code']}' class='img-fluid' style='height:18px;vertical-align:middle;' />";
			 }
			 $mop_list[]="{$symbol}";
			 
		}elseif($list==3){
			$result['mop_code'][$value['mop_name']]=$value['mop_name'].' | '.$value['mop_code'];
		}
		
	}
	
	if($list==1){
		return implode('',$mop_option_list); 
	}
	elseif($list==2){
		return implode('',$mop_list); 
	}
	else{
		return $result;
	}
}


//The mcc_code_listf() used for fetch acquirer_id and mer_setting_json detail of an account.
function gw_mcc_code_listf($acquirer_id=0){
	global $data; $result=array();

	//fetch data from acquirer_table
	$select_pt=db_rows(
		"SELECT `id`,`acquirer_id`,`mer_setting_json` FROM `{$data['DbPrefix']}acquirer_table`".
		" WHERE `acquirer_status` NOT IN (0) ".($acquirer_id?" AND `acquirer_id` IN ({$acquirer_id}) ":""),0
	);
	$result['mcc_codes']=[];
	
	//fetch data row-by-row
	foreach($select_pt as $key=>$value){
		$mer_setting_json=jsondecode($value['mer_setting_json'],1,1);		//decode json to array
		if(isset($mer_setting_json['mcc_code'])&&$mer_setting_json['mcc_code']){
			$result['mcc_codes'][$value['acquirer_id']]=$value['acquirer_id']." - ".merchant_categoryf(implodef($mer_setting_json['mcc_code']));
		}
	}
	
	return $result['mcc_codes'];	//return MCC Codes
}

//Acquirer wise popup msg get if mobile value other than web
function acquirer_popup_msg_f($acquirer_id){
	$popup_msg='';
	if(isMobileDevice()&&isset($_SESSION["b_".$acquirer_id]['aLj']['popup_msg_mobile'])&&trim($_SESSION["b_".$acquirer_id]['aLj']['popup_msg_mobile'])){
		$popup_msg=$_SESSION["b_".$acquirer_id]['aLj']['popup_msg_mobile'];
	}elseif(isset($_SESSION["b_".$acquirer_id]['aLj']['popup_msg_web'])&&trim($_SESSION["b_".$acquirer_id]['aLj']['popup_msg_web'])){
		$popup_msg=$_SESSION["b_".$acquirer_id]['aLj']['popup_msg_web'];
	}
	
	return $popup_msg;
}

//Acquirer wise logo get if mobile value other than web
function acquirer_logo_f($acquirer_id){
	$logo='';
	if(isMobileDevice()&&isset($_SESSION["b_".$acquirer_id]['aLj']['logo_mobile'])&&trim($_SESSION["b_".$acquirer_id]['aLj']['logo_mobile'])){
		$logo=$_SESSION["b_".$acquirer_id]['aLj']['logo_mobile'];
	}elseif(isset($_SESSION["b_".$acquirer_id]['aLj']['logo_web'])&&trim($_SESSION["b_".$acquirer_id]['aLj']['logo_web'])){
		$logo=$_SESSION["b_".$acquirer_id]['aLj']['logo_web'];
	}
	
	return $logo;
}

//Acquirer wise label get if mobile value other than web
function acquirer_label_f($web,$mobile,$acquirer_id){
	$label='';
	if(isMobileDevice()&&trim($mobile)){
		$label=$mobile;
	}elseif(trim($web)){
		$label=$web;
	}elseif(isMobileDevice()&&isset($_SESSION["b_".$acquirer_id]['aLj']['checkout_label_mobile'])&&trim($_SESSION["b_".$acquirer_id]['aLj']['checkout_label_mobile'])){
		$label=$_SESSION["b_".$acquirer_id]['aLj']['checkout_label_mobile'];
	}elseif(isset($_SESSION["b_".$acquirer_id]['aLj']['checkout_label_web'])&&trim($_SESSION["b_".$acquirer_id]['aLj']['checkout_label_web'])){
		$label=$_SESSION["b_".$acquirer_id]['aLj']['checkout_label_web'];
	}
	
	return ucfirst($label);
}


//The use of acquirer_tablef() function is fetch acquirer id from a acquirer_table
function acquirer_tablef($list=0){
	global $data; $result=array();
	
	//fetch all account numbers
	$select_pt=db_rows(
		"SELECT `acquirer_status`,`acquirer_id`,`acquirer_name`,`channel_type`,`acquirer_refund_policy`,`default_acquirer` FROM `{$data['DbPrefix']}acquirer_table` WHERE `acquirer_status` NOT IN (0) ",0
	);
	array_multisort(array_column($select_pt, 'acquirer_status'), SORT_DESC, $select_pt);	//sort array via acquirer_status
	$result['acquirer_id']=["2","3","6"];
	$result['acquirer_list'][2]="2 | Withdraw | WD";
	$result['acquirer_list'][3]="3 | Withdraw Rolling | WR";
	$result['acquirer_list'][4]="4 | Fund| AF";
	foreach($select_pt as $key=>$value){
		if($list==1){
			$result['acquirer_list'][$value['acquirer_id']]=$value['acquirer_id']. ' | '.$value['acquirer_name'].' | '.strtoupper($data['channel'][$value['channel_type']]['name1']);
		}elseif($list==2){
			$result['acquirer_name'][$value['acquirer_id']]=$value['acquirer_name'];
		}elseif($list==3){
			$result['acquirer_channel'][$value['acquirer_id']]=strtoupper($data['channel'][$value['channel_type']]['name1']);
		}elseif($list==4){
			$result['acquirer_channel_name'][$value['acquirer_id']]=($data['channel'][$value['channel_type']]['name2']);
		}elseif($list==7){
			if(trim($value['acquirer_refund_policy'])&&in_array($value['acquirer_refund_policy'],["Full Refund only","Full & Partial Both","Full Refund","Partial Refund"])){
				$result['acquirer_refund'][$value['acquirer_id']]=$value['acquirer_refund_policy'];
			}
		}elseif($list==8){
			$result['acquirer_refund_list'][$value['acquirer_id']]=$value['acquirer_refund_policy'];
		}elseif($list==9){
			$result['default_acquirer'][$value['acquirer_id']]=$value['default_acquirer'];
		}else{
			$result['acquirer_id'][]=$value['acquirer_id'];
			//$result['d'][$key]=$value; $result[$value['id']]=$value;
		}
	}
	//sort(array_unique($result['acquirer_id']));
	return $result;		
}

//fetch acquirer refund list from acquirer_refund_policy
function acquirer_refund_list(){
	if(!isset($_SESSION['actDb_refund_list']))
	{
		$actDb_refund_list=@acquirer_tablef(8);
		$_SESSION['actDb_refund_list']=$actDb_refund_list['acquirer_refund_list'];
	}
	if(isset($_SESSION['actDb_refund_list'])) 
	return $data['acquirer_refund_list']=$_SESSION['actDb_refund_list'];
}

//if admin then fetch acquirer id
if((!isset($_SESSION['actDb_acq']))&&(isset($_SESSION['adm_login'])))
{
	$actDb_acq=@acquirer_tablef();
	$_SESSION['actDb_acq']=$actDb_acq['acquirer_id'];
}
if(isset($_SESSION['actDb_acq'])) $data['acquirer_id']=$_SESSION['actDb_acq'];

//if admin then fetch acquirer list wise of acquirer id,acquirer name,acquirer type
if((!isset($_SESSION['actDb_list']))&&(isset($_SESSION['adm_login'])))
{
	$actDb_list=@acquirer_tablef(1);
	$_SESSION['actDb_list']=$actDb_list['acquirer_list'];
}
if(isset($_SESSION['actDb_list'])) $data['acquirer_list']=$_SESSION['actDb_list'];


//if admin then fetch acquirer name list 
if((!isset($_SESSION['actDb_name']))&&(isset($_SESSION['adm_login'])))
{
	$actDb_name=@acquirer_tablef(2);
	$_SESSION['actDb_name']=$actDb_name['acquirer_name'];
}
if(isset($_SESSION['actDb_name'])) $data['acquirer_name']=$_SESSION['actDb_name'];

//if admin then fetch acquirer channel
if((!isset($_SESSION['actDb_channel']))&&(isset($_SESSION['adm_login'])))
{
	$actDb_channel=@acquirer_tablef(3);
	$_SESSION['actDb_channel']=$actDb_channel['acquirer_channel'];
}
if(isset($_SESSION['actDb_channel'])) $data['acquirer_channel']=$_SESSION['actDb_channel'];

//if admin then fetch acquirer channel name
if((!isset($_SESSION['actDb_channel_name']))&&(isset($_SESSION['adm_login'])))
{
	$actDb_channel_name=@acquirer_tablef(4);
	$_SESSION['actDb_channel_name']=$actDb_channel_name['acquirer_channel_name'];
}
if(isset($_SESSION['actDb_channel_name'])) $data['acquirer_channel_name']=$_SESSION['actDb_channel_name'];

//if admin then fetch acquirer refund list from acquirer_refund_policy
if((!isset($_SESSION['actDb_refund']))&&(isset($_SESSION['adm_login'])))
{
	$actDb_refund=@acquirer_tablef(7);
	$_SESSION['actDb_refund']=$actDb_refund['acquirer_refund'];
}

if(isset($_SESSION['actDb_refund'])) $data['acquirer_refund']=$_SESSION['actDb_refund'];

//if admin then fetch default_acquirer
if((!isset($_SESSION['actDb_default_acquirer']))&&(isset($_SESSION['adm_login'])))
{
	$actDb_default_acquirer=@acquirer_tablef(9);
	$_SESSION['actDb_default_acquirer']=$actDb_default_acquirer['default_acquirer'];
}

function default_acquirer_id_fetch($id=0){
	
	if(!isset($_SESSION['actDb_default_acquirer'])) {
		$actDb_default_acquirer=@acquirer_tablef(9);
		$_SESSION['actDb_default_acquirer']=$actDb_default_acquirer['default_acquirer'];
	}
		
	if(isset($_SESSION['actDb_default_acquirer'][$id])&&@$_SESSION['actDb_default_acquirer'][$id])
		$default_acquirer_id=@$_SESSION['actDb_default_acquirer'][$id];
	else $default_acquirer_id=$id;
	return $default_acquirer_id;
}


?>