<?php

// Dev Tech : 24-05-10 below list of function are not use this project of GW because this function are re-modify as well as a function, table name and feild wise for collect this function unuse file

//to calculate payout settlement balance and period
function payout_trans_newf_wv2($uid=0,$type=2, $trans_detail_array=[])
{
	global $data;//, $trans_detail_array;

    // if trans_detail_array then not call function fetch_trans_balance_wv2
    if(isset($trans_detail_array)&&is_array($trans_detail_array)&&count($trans_detail_array)>0){

    }
	else $trans_detail_array = fetch_trans_balance_wv2($uid, $type);	//fetch transaction detail from fetch_trans_balance_wv2 function

	//Dev Tech : 24-08-13 bug fix descending for tdate wise

	$trans_detail_array_desc=$trans_detail_array;

	if(isset($trans_detail_array_desc)&&is_array($trans_detail_array_desc)) 
	array_multisort(array_column($trans_detail_array_desc, 'tdate'), SORT_DESC, $trans_detail_array_desc);
	
	$result=array();

	//Response of Last Withdraw 
	if(isset($data['last_withdraw'])&&$data['last_withdraw']) $result['wd']=$data['last_withdraw'];

	$qprint=0;
	if(isset($_REQUEST['qp']))
	{
		$qprint=1;
		echo "<br/><hr/><br/><h1><==payout_trans_newf_wv2==></h1><br/>";
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
	for($i=0;$i<count($trans_detail_array_desc);$i++)
	{
		$temp_trans_arr = $trans_detail_array_desc[$i];	//store one row in temp array
		
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


	//Dev Tech : 24-09-19 over right the w_start_date from last_withdraw_tdate
	if(isset($data['last_withdraw']['last_withdraw_tdate'])&&trim($data['last_withdraw']['last_withdraw_tdate']))
	{
		$w_start_date=trim($data['last_withdraw']['last_withdraw_tdate']);
	}
	elseif(isset($tran_id[0]['min_tdate'])&&trim($tran_id[0]['min_tdate']))
	{ //Dev Tech: 24-12-10 bug fix for missing tdate of success transaction if not found the withdraw 
		$w_start_date=trim($tran_id[0]['min_tdate']);
	}

	//$w_start_date=0;
	
	if (isset($w_start_date) && date('Ymd', strtotime($w_start_date)) === "19700101")
	{
		$w_start_date = date('Y-m-d',strtotime($w_end_date));
	}



	if($qprint)
	{
		echo "<hr/><b style='color:#026402;'>last_withdraw_transID=> ".@$data['last_withdraw']['last_withdraw_transID']."</b>";
		echo "<hr/><b style='color:#062377;'>last_withdraw_tdate=> ".@$data['last_withdraw']['last_withdraw_tdate']."</b>";
		echo "<hr/><b style='color:#9d7c05;'>first_success_tdate=> ".@trim($tran_id[0]['min_tdate'])."</b>";
		echo "<hr/><b style='color:#026402;'>w_start_date=> ".date('Y-m-d',strtotime($w_start_date))."</b>";
		echo "<hr/>w_end_date=> ".date('Y-m-d',strtotime($w_end_date));
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

	// Dev Tech : 25-04-25 bug fix for same month of start date and end date
	if(date('Ym', strtotime($w_start_date)) && date('Ym', strtotime($w_end_date)) && date('Ym', strtotime($w_start_date))==date('Ym', strtotime($w_end_date))){
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
		echo "<hr/><b>RESULT==></b>";
		print_r($result);
	}
	return $result;
}



//fetch all transaction details of a clients or all transactions.
function fetch_trans_balance_wv2($memId="", $acquirer=2, $json_frozen=0)
{
	global $data; $last_withdraw_date_between_till_timestamp=''; $tr_det_q_immature_query=1;

	//Select Data from master_trans_additional
	$join_additional=join_additional('t');
	if(!empty($join_additional)) $mts="`ad`";
	else $mts="`t`";

	$qprint=0;
	if(isset($_REQUEST['qp'])){
		$qprint=1;
		echo "<br/><hr/><br/><h1><==fetch_trans_balance_wv2==></h1><br/>";
	}
	
	$acquirer=(int)$acquirer;

	if(!empty($memId) && $memId>0){
		//$where_clouse = "(`merID` IN ({$memId}) )";	//fetch merID = memId

        //fetch merID = memId and 0-Pending,9-Test,10-Scrubbed,2-Declined,22-Expired,23-Cancelled,24-Failed is not in trans_status
		$where_clouse = "(`merID` IN ({$memId}) ) AND (`trans_status` NOT IN ({$data['TRANS_STATUS_NOT_IN']}) )";	

        
		
	}
	else
		$where_clouse = 1;
	//$where_clouse .= " AND status NOT IN (0,9,10) ";

	//if json_frozen is true then set condition for frozen_acquirer must be json value
	//if($json_frozen==1) $where_clouse .= " AND (`json_value` NOT LIKE '%frozen_acquirer%') ";
	
	//if($json_frozen==1) $where_clouse .= " AND ( CONVERT(`json_value` USING utf8) NOT LIKE '%frozen_acquirer%') ";


	//Dev Tech : 24-05-03 $data['WITHDRAW_INITIATE_TO_DATE_WISE']='Y'; //  Y - fetch for Withdrawal Date Wise : Not open in same like chrome browser. Open to different private/firefox browsers. via trans_withdraw-fund_datewise.do

	//if(isset($data['WITHDRAW_INITIATE_TO_DATE_WISE'])&&@$data['WITHDRAW_INITIATE_TO_DATE_WISE']=='Y')
	{

		if(@$qprint) 
		{ 
			echo "<br/>_POST=>";
			print_r($_POST);
			echo "<br/>resultLastWithdraw=><br/><br/><br/>";
			

		}

		$withdraw_append='';
		$withdraw_tdate_append='';

		if((isset($_POST['bid'])&&$_POST['bid']>0&&$_POST['bid']==$memId)&&(isset($_POST['withdraw_from_date'])||isset($_POST['withdraw_to_date'])))
		{
			$tr_det_q_immature_query=0;
			$resultLastWithdraw['FORM_POST_METHOD']=@$_POST;

			//if(isset($_POST['withdraw_transID'])&&trim($_POST['withdraw_transID']))  $withdraw_transID=@$_POST['withdraw_transID'];

			if(isset($_POST['withdraw_from_date'])&&trim($_POST['withdraw_from_date'])) 
				$withdraw_from_date=@$_POST['withdraw_from_date'];
			
			if(isset($_POST['withdraw_to_date'])&&trim($_POST['withdraw_to_date'])) 
				$withdraw_to_date=@$_POST['withdraw_to_date'];
			
			//fetch less then or equal tdate for withdraw query 
			if(isset($withdraw_to_date)&&trim($withdraw_to_date)){
				//$wd_to_date=date('Y-m-d H:i:s.u',strtotime($withdraw_to_date));
				$wd_to_date=$withdraw_to_date;
				$withdraw_tdate_append = " AND ( `tdate` <= '{$wd_to_date}' ) ";
				
				$resultLastWithdraw["last_withdraw_micro_current_date"]=$wd_to_date;
			}

			//$qprint=1;
			if(@$qprint) echo "<br/>get withdraw_to_date=><br/><br/><br/>";

			if(isset($withdraw_transID)&&trim($withdraw_transID)){
				// $withdraw_append=" ( `transID`={$withdraw_transID} ) "; 
			}
			// fetch from Admin via form fields 
			elseif(isset($withdraw_to_date)&&trim($withdraw_to_date)&&@$wd_to_date&&isset($withdraw_from_date)&&trim($withdraw_from_date)) 
			{
				//$withdraw_from_date=date('Y-m-d H:i:s',strtotime($withdraw_from_date));

				$last_withdraw_date_between_till_timestamp = " AND ( `settelement_date` BETWEEN '{$withdraw_from_date}' AND '{$wd_to_date}'  ) AND ( `acquirer` NOT IN (2,3) ) ";	//Mature query : fetch tdate wise as per last withdraw timestamp to till timestamp
			}
			elseif(isset($withdraw_to_date)&&trim($withdraw_to_date)&&@$wd_to_date) 
			{
				$last_withdraw_date_between_till_timestamp = " AND ( `settelement_date` <='{$wd_to_date}'  ) AND ( `acquirer` NOT IN (2,3) ) ";	//Mature query : fetch tdate wise as per last withdraw timestamp to till timestamp

				
			}

			$last_withdraw_date_between_till_timestamp_immature = " AND ( `settelement_date` > '{$wd_to_date}'  ) AND ( `acquirer` NOT IN (2,3) ) ";	//Immature query : fetch tdate wise as per last withdraw timestamp to till timestamp

		}else { // via system 
			$withdraw_append=" ( `t`.`merID`='{$memId}' ) AND ( `t`.`acquirer` IN ({$acquirer}) ) AND ( `t`.`trans_status` NOT IN (2) )   "; 
		}


		//fetch last withdraw / settlement

		if(trim($withdraw_append)) 
		{

			/*
			$fetch_last_withdraw=db_rows(
				"SELECT (`t`.`id`) AS `id`, (`t`.`transID`) AS `transID`, (`t`.`tdate`) AS `tdate`, ($mts.`json_value`) AS `json_value` ".
				" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` AS `t` {$join_additional}".
				" WHERE ".$withdraw_append." ".
				" ORDER BY `t`.`id` DESC LIMIT 1",$qprint
			);
			*/

			

			//Dev Tech : 24-09-16 REMAINING BALANCE WV2 is Y then start remaining balance 
			if(isset($data['REMAINING_BALANCE_WV2'])&&$data['REMAINING_BALANCE_WV2']=='Y')
				$last_withdraw_field=", (`t`.`remaining_balance_amt`) AS `remaining_balance_amt` , (`t`.`mature_rolling_fund_amt`) AS `mature_rolling_fund_amt` , (`t`.`immature_rolling_fund_amt`) AS `immature_rolling_fund_amt` ";

			else $last_withdraw_field="";

			
			$fetch_last_withdraw=db_rows(
                "SELECT (`t`.`id`) AS `id`, (`t`.`transID`) AS `transID`, (`t`.`acquirer`) AS `acquirer`, (`t`.`tdate`) AS `tdate` {$last_withdraw_field} ".
                " FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` AS `t`".
                " WHERE ".$withdraw_append." ".
                " ORDER BY `id` DESC LIMIT 1",$qprint
            );
			
			
			if(isset($fetch_last_withdraw)&&isset($fetch_last_withdraw[0]['transID'])&&is_array($fetch_last_withdraw))
			{

				//$resultLastWithdraw["previous_wd_transID"]=@$fetch_last_withdraw[0]['transID'];
				
				
				/*

				$json_value_de=jsondecode(@$fetch_last_withdraw[0]['json_value'],1);

				if(isset($json_value_de['remaining_balance'])&&!empty($json_value_de['remaining_balance']))
					$resultLastWithdraw["last_withdraw_remaining_balance"]=@$json_value_de['remaining_balance'];

				elseif(isset($json_value_de['remaining_balance '])&&!empty($json_value_de['remaining_balance ']))
					$resultLastWithdraw["last_withdraw_remaining_balance"]=@$json_value_de['remaining_balance '];

				*/
					
				//Dev Tech : 24-09-16 REMAINING BALANCE WV2 is Y then start remaining balance 
				if(isset($data['REMAINING_BALANCE_WV2'])&&$data['REMAINING_BALANCE_WV2']=='Y')
				{	

					$resultLastWithdraw["last_withdraw_remaining_balance"]=@$fetch_last_withdraw[0]['remaining_balance_amt'];

					$resultLastWithdraw["last_withdraw_mature_rolling_fund_amt"]=@$fetch_last_withdraw[0]['mature_rolling_fund_amt'];
					$resultLastWithdraw["last_withdraw_immature_rolling_fund_amt"]=@$fetch_last_withdraw[0]['immature_rolling_fund_amt'];

				}

				

				$resultLastWithdraw["last_withdraw_id"]=@$fetch_last_withdraw[0]['id'];
				$resultLastWithdraw["last_withdraw_acquirer"]=@$fetch_last_withdraw[0]['acquirer'];
				$resultLastWithdraw["last_withdraw_transID"]=@$fetch_last_withdraw[0]['transID'];	//transaction id
				$resultLastWithdraw["last_withdraw_tdate"]=$tdateLastWithdraw=@$fetch_last_withdraw[0]['tdate'];

				
				if(isset($withdraw_to_date)&&trim($withdraw_to_date)) { // fetch from Admin via form fields 
					//$withdraw_to_date=date('Y-m-d H:i:s',strtotime($withdraw_to_date));
					$withdraw_to_date=$withdraw_to_date;
				} 
				else { 
					//$withdraw_to_date=date("Y-m-d H:i:s",strtotime("-1 minutes",strtotime(micro_current_date()))); 
					$withdraw_to_date=micro_current_date(); // via 6 digit micro time after second 
				}
				
				$resultLastWithdraw["last_withdraw_micro_current_date"]=$last_withdraw_micro_current_date=$withdraw_to_date;	

				$last_withdraw_date_between_till_timestamp = " AND ( `settelement_date` BETWEEN '{$tdateLastWithdraw}' AND '{$last_withdraw_micro_current_date}'  ) AND ( `acquirer` NOT IN (2,3) ) ";	//fetch tdate wise as per last withdraw timestamp to till timestamp


				if(@$qprint)
				{
					//echo "<br/><hr/>Last Withdraw Json Value=><br/>"; print_r(@$json_value_de); echo "<br/><br/>";
					echo "<br/><b style='color:#0933b0;'>REMAINING_BALANCE_WV2=>".@$data['REMAINING_BALANCE_WV2']."</b>";
					echo "<br/><b style='color:#026402;'>last_withdraw_remaining_balance=>".@$resultLastWithdraw["last_withdraw_remaining_balance"]."</b><br/>";
					echo "<br/><b style='color:#0933b0;'>last_withdraw_transID=>".@$resultLastWithdraw["last_withdraw_transID"]."</b>";
					echo "<br/><b style='color:#026402;'>last_withdraw_acquirer=>".@$resultLastWithdraw["last_withdraw_acquirer"]."</b><br/>";
					
					echo "<br/><br/>";
				}
				

				//$tdateLastWithdraw=date('Y-m-d H:i:s.u',strtotime(@$fetch_last_withdraw[0]['tdate']));
				//$tdateLastWithdraw=fetchFormattedDate(@$fetch_last_withdraw[0]['tdate'],'Y-m-d H:i:s.u');
				//$tdateLastWithdraw=@$fetch_last_withdraw[0]['tdate'];
				
				// settelement_date	tdate

				
			}
			else
			{
					
				$resultLastWithdraw["last_withdraw_micro_current_date"]=$last_withdraw_micro_current_date=micro_current_date();

				$last_withdraw_date_between_till_timestamp = " AND ( `settelement_date` <= '{$last_withdraw_micro_current_date}'  ) AND ( `acquirer` NOT IN (2,3) ) "; //fetch tdate wise as per last withdraw timestamp to till timestamp

			}
		}
		


		//withdraw condition 
		if(isset($resultLastWithdraw)&&@$resultLastWithdraw){

			
				
			$last_withdraw_date_between_till_timestamp_immature = " AND ( `settelement_date` > '{$last_withdraw_micro_current_date}'  ) AND ( `acquirer` NOT IN (2,3) ) ";	//Immature query : fetch tdate wise as per last withdraw timestamp to till timestamp

			$data['last_withdraw']=$resultLastWithdraw;


			if(isset($resultLastWithdraw["last_withdraw_micro_current_date"])&&trim($resultLastWithdraw["last_withdraw_micro_current_date"]))
			$_SESSION['last_withdraw_micro_current_date_'.$memId]=$resultLastWithdraw["last_withdraw_micro_current_date"];



			if(@$qprint){
				echo "<br/>resultLastWithdraw Res.=><br/>";
				print_r($resultLastWithdraw);
				
				echo "<br/><br/><hr/><br/><br/>";
			}

		}


	}

	

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


	$trans_field=" `id`,
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
	".$gst_fee_sl;

	//Dev Tech : 24-09-16 REMAINING BALANCE WV2 is Y then start remaining balance 
	if(isset($data['REMAINING_BALANCE_WV2'])&&$data['REMAINING_BALANCE_WV2']=='Y')
	{
		@$trans_field.=", `remaining_balance_amt`, `mature_rolling_fund_amt`, `immature_rolling_fund_amt` ";
	}
	

	if(@$qprint)  echo "<br/><br/><br/><b>MATURE TRANSACTION QUERY=></b><br/><br/>";
	//,`support_note`
	//Mature transaction query 
	$tr_det_q=db_rows("SELECT 
		".$trans_field.
		" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
		" {$use_index}  WHERE ".$where_clouse.$last_withdraw_date_between_till_timestamp." ",$qprint
	);

	if(@$tr_det_q_immature_query==1)
	{

		if(@$qprint)  echo "<br/><br/><b>IMMATURE TRANSACTION QUERY=></b><br/><br/>";
		//Immature transaction query - Dev tech : 24-09-16
		$tr_det_q_immature=db_rows("SELECT 
			".$trans_field.
			" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" {$use_index}  WHERE ".@$where_clouse.@$last_withdraw_date_between_till_timestamp_immature." ",$qprint
		);

		// Transaction Array merge for mature & immature 
		//if(@$tr_det_q_immature&&@$tr_det_q)
		$tr_det_q=array_merge(@$tr_det_q,@$tr_det_q_immature);
	}

	
	//fetch the all withdraw (Fund and Rolling) list so that not required the query for tdate between 
	if(isset($fetch_last_withdraw)&&isset($fetch_last_withdraw[0]['transID'])&&is_array($fetch_last_withdraw))
	{
		if(@$qprint)  echo "<br/><br/><b>All Withdraw (Fund and Rolling) QUERY=></b><br/><br/>";

		$tr_withdraw_q=db_rows("SELECT 
			".$trans_field.
			" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" {$use_index}  WHERE  ".$where_clouse.$withdraw_tdate_append." AND ( `acquirer` IN (2,3) )  ",$qprint
		);

		// Array merge for Payout data and withdraw data 
		$tr_det_q=array_merge(@$tr_det_q,@$tr_withdraw_q);

	}
	
	

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

		//Dev Tech : 24-09-16 REMAINING BALANCE WV2 is Y then start remaining balance 
		if(isset($data['REMAINING_BALANCE_WV2'])&&$data['REMAINING_BALANCE_WV2']=='Y')
		{
			$val['remaining_balance_amt']		= getNumericValue($val['remaining_balance_amt']);
			$val['mature_rolling_fund_amt']		= getNumericValue($val['mature_rolling_fund_amt']);
			$val['immature_rolling_fund_amt']	= getNumericValue($val['immature_rolling_fund_amt']);
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
function trans_balance_newac_wv2($uid=0,$tr_id=0,$currentDate='', $trans_detail_array=[], $last_withdraw=[])
{
	global $data, $monthly_fee; 

	$now="now()";

	$result=array();
	$where_merID="";
	$current_date=$data['CURRENT_TIME'];	//date('Y-m-d H:i:s');

	$qprint=0;
	$account_curr="";
	$tdate_pd="";

	$qp=0;
	if(isset($_REQUEST['qp']))
	{
		$qprint=1;
		$qp=@$_REQUEST['qp'];
		echo "<br/><hr/><br/><h1><==trans_balance_newac_wv2==></h1><br/>";
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

	@$TODAY_DATE_ONLY = TODAY_DATE_ONLY;

	

	if(isset($last_withdraw['last_withdraw_micro_current_date'])&&!empty($last_withdraw['last_withdraw_micro_current_date'])){
		$TODAY_DATE_ONLY = @$last_withdraw['last_withdraw_micro_current_date'];
	}


	$TODAY_DATE_ONLY = dateReplace_2(@$TODAY_DATE_ONLY);

	if(isset($_REQUEST['qp']))
	{
		echo "<br/><hr/><br/><h4>date_1st</h4><br/>"; print_r(@$date_1st);
		echo "<br/><hr/><br/><h4>date_2nd</h4><br/>"; print_r(@$date_2nd);
		echo "<br/><hr/><br/><h4>TODAY_DATE_ONLY</h4><br/>"; print_r(@TODAY_DATE_ONLY);
		echo "<br/><hr/><br/><h4>last_withdraw_micro_current_date</h4><br/>"; print_r(@$TODAY_DATE_ONLY);
		echo "<br/><hr/><br/><h4><b style='color:#d07f00;'>trans_detail_array</b></h4><br/>"; print_r(@$trans_detail_array);

	}

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
		if(!empty($date_1st) && !empty($date_2nd))	// if first and second date exist check following conditions, if true then mature_con=true;
		{
			if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && !(($temp_trans_arr['trans_status']=="0" || $temp_trans_arr['trans_status']=="9" || $temp_trans_arr['trans_status']=="10")) && fetchFormattedDate($temp_trans_arr['settelement_date'])>=$date_1st && fetchFormattedDate($temp_trans_arr['settelement_date'])<=$date_2nd) {
				$mature_con=true;
			}
		}
		else
		{
			//if date not set (exists) the check following, if true then mature_con=true;
			if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && !(($temp_trans_arr['trans_status']=="0" || $temp_trans_arr['trans_status']=="9" || $temp_trans_arr['trans_status']=="10")) && fetchFormattedDate_2($temp_trans_arr['settelement_date'])<=$TODAY_DATE_ONLY) {
				$mature_con=true;
			}
		}
		
		//if true mature_con is true, then executive following section;
		if($mature_con)
		{
			if($tr_id>0){	//if transaction id greater than zero, means only one record to be fetch
				if($temp_trans_arr['id']==$tr_id)	//if request trans id found in array then fetch data and break the loop
				{
					$summ_mature	= getNumericValue($temp_trans_arr['payable_amt_of_txn']);
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
				$summ_mature += getNumericValue($temp_trans_arr['payable_amt_of_txn']);
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
		if($temp_trans_arr['merID']=="$uid" && ($temp_trans_arr['trans_type']==11) && !(($temp_trans_arr['trans_status']=="0" || $temp_trans_arr['trans_status']=="9" || $temp_trans_arr['trans_status']=="10")) && fetchFormattedDate_2($temp_trans_arr['settelement_date'])>$TODAY_DATE_ONLY)
		{
			if($tr_id>0){	//if transaction id greater than zero, means only one record to be fetch
				if($temp_trans_arr['id']==$tr_id)	//if request trans id found in array then fetch data and break the loop
				{
					$summ_immature	= getNumericValue($temp_trans_arr['payable_amt_of_txn']);	//payable transaction amount
					$count_immature	=1;	//set counter is 1
					break;
				}
			}
			else {
				$summ_immature += getNumericValue($temp_trans_arr['payable_amt_of_txn']);	//payable transaction amount add into summ_immature
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
				$summ_withdraw += getNumericValue($temp_trans_arr['bill_amt']);	//add amount into total withdraw	
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
				$summ_sended_fund += getNumericValue($temp_trans_arr['bill_amt']);	//transaction amount add in sended fund
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
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && $temp_trans_arr['trans_status']=="1" && fetchFormattedDate_2($temp_trans_arr['rolling_date'])<=$TODAY_DATE_ONLY) {

			if($tr_id>0){	//if transaction id greater than zero, means only one record to be fetch
				if($temp_trans_arr['id']==$tr_id)	//if request trans id found in array then fetch data and break the loop
				{
					$summ_mature_roll	= getNumericValue($temp_trans_arr['rolling_amt']); //rolling amount to sum of mature rolling
					$count_mature_roll	=1;	//set total counting 1
					break;
				}
			}
			else {
				$summ_mature_roll += getNumericValue($temp_trans_arr['rolling_amt']); //add rolling amount to sum of mature rolling
				$count_mature_roll++;	//increase counter
			}
		}
		// CALCULATION FOR	summ_mature rolling_amt -- END

		// CALCULATION FOR	summ_immature rolling_amt -- START
		if(($temp_trans_arr['merID']=="$uid") && ($temp_trans_arr['trans_type']==11) && $temp_trans_arr['trans_status']=="1" && fetchFormattedDate_2($temp_trans_arr['rolling_date'])>$TODAY_DATE_ONLY) {
			if($tr_id>0){	//if transaction id greater than zero, means only one record to be fetch
				if($temp_trans_arr['id']==$tr_id)	//if request trans id found in array then fetch data and break the loop
				{
					@$summ_immature_roll	= getNumericValue(@$temp_trans_arr['rolling_amt']); //rolling amount to sum of immature rolling
					$count_immature_roll	=1;	//set total counting 1
					break;
				}
			}
			else {
				@$summ_immature_roll += getNumericValue(@$temp_trans_arr['rolling_amt']); //add rolling amount to sum of immature rolling

				

				$count_immature_roll++;	//increase counter
			}
		}
		// CALCULATION FOR summ_immature rolling_amt -- END

		/*
		//Dev Tech : 24-09-17 SUM ROLLING from withdraw -- START
		if($temp_trans_arr['merID']=="$uid" && ( $temp_trans_arr['trans_type']==15 || $temp_trans_arr['trans_type']==16 ) && ($temp_trans_arr['trans_status']=="1" || $temp_trans_arr['trans_status']=="13") && (isset($data['REMAINING_BALANCE_WV2'])&&$data['REMAINING_BALANCE_WV2']=='Y') )
		{	
			$summ_mature_roll += getNumericValue($temp_trans_arr['mature_rolling_fund_amt']); //add sum of mature rolling _wv2

			$summ_immature_roll += getNumericValue($temp_trans_arr['immature_rolling_fund_amt']); //add sum of immature rolling _wv2

			if(isset($_REQUEST['qp']))
			{
				echo "<br/>mature_rolling_fund_amt=>".@$temp_trans_arr['mature_rolling_fund_amt'];
				echo "<br/>immature_rolling_fund_amt=>".@$temp_trans_arr['immature_rolling_fund_amt'];
				
			}
		}
		//SUM ROLLING from withdraw -- END

		*/


	}
	//END FOR LOOP


	if(isset($_REQUEST['qp']))
	{
		echo "<br/><hr/><br/><h4>This Time summ_mature_roll : {$summ_mature_roll}</h4>";
		echo "<br/><h4>This Time summ_immature_roll : {$summ_immature_roll}</h4>";
		echo "<br/><hr/><br/>";
	}


	//Dev Tech : 24-09-20 SUM ROLLING for all transaction query -- START
	if(isset($data['ROLLING_CALC_QUERY_WV2'])&&$data['ROLLING_CALC_QUERY_WV2']=='Y') 
	{
		if(@$qp) echo "<br/><hr/><h4 style='font-size:22px!important;font-weight:bold;color:#3a8411;'>MATURE rolling</h4>";


		$mature_rolling_date=" AND ( `rolling_date` <= '{$TODAY_DATE_ONLY}' ) ";

		$mature_rolling_qr=db_rows(
			" SELECT SUM(CAST(`rolling_amt` AS double precision)) AS `mature_rolling`  FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" WHERE ( `merID` IN ({$uid}) ) AND ( `trans_status` NOT IN ({$data['TRANS_STATUS_NOT_IN']}) )  AND ( `acquirer` NOT IN (2,3) )  ".
			$mature_rolling_date .
			" LIMIT 1 ",@$qp
		);

		$summ_mature_roll=@$mature_rolling_qr[0]['mature_rolling'];

		if(@$qp){
			echo "<br/><b style='color:#0933b0;'>Mature Rolling=>".number_formatf2(@$summ_mature_roll)."</b><br/>";
		}


		//immature rolling  query 		
		if(@$qp) echo "<br/><hr/><h4 style='font-size:22px!important;font-weight:bold;color:#3a8411;'>IMMATURE rolling</h4>";


		$imimmature_rolling_date=" AND ( `rolling_date` > '{$TODAY_DATE_ONLY}' ) ";

		$immature_rolling_qr=db_rows(
			" SELECT SUM(CAST(`rolling_amt` AS double precision)) AS `immature_rolling`  FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" WHERE ( `merID` IN ({$uid}) ) AND ( `trans_status` NOT IN ({$data['TRANS_STATUS_NOT_IN']}) )  AND ( `acquirer` NOT IN (2,3) )  ".
			$imimmature_rolling_date .
			" LIMIT 1 ",@$qp
		);

		$summ_immature_roll=@$immature_rolling_qr[0]['immature_rolling'];

		if(@$qp){
			echo "<br/><b style='color:#0933b0;'>Immature Rolling=>".number_formatf2(@$summ_immature_roll)."</b><br/>";
		}

	}

	//Dev Tech : 24-09-18 SUM ROLLING from last withdraw -- START
	elseif((isset($last_withdraw['last_withdraw_mature_rolling_fund_amt']) || isset($last_withdraw['last_withdraw_immature_rolling_fund_amt'])) && (isset($data['REMAINING_BALANCE_WV2'])&&$data['REMAINING_BALANCE_WV2']=='Y') )
	{	
		$summ_mature_roll += getNumericValue(@$last_withdraw['last_withdraw_mature_rolling_fund_amt'] - $summ_mature_roll); //add sum of mature rolling _wv2

		$summ_immature_roll += getNumericValue($last_withdraw['last_withdraw_immature_rolling_fund_amt']-$summ_immature_roll); //add sum of immature rolling _wv2

		if(isset($_REQUEST['qp']))
		{
			echo "<br/>last_withdraw_mature_rolling_fund_amt=>".@$last_withdraw['last_withdraw_mature_rolling_fund_amt'];
			echo "<br/>last_withdraw_immature_rolling_fund_amt=>".@$last_withdraw['last_withdraw_immature_rolling_fund_amt'];

			echo "<br/><hr/><br/><h4>- summ_mature_roll : {$summ_mature_roll}</h4>";
			echo "<br/><h4>- summ_immature_roll : {$summ_immature_roll}</h4>";
			echo "<br/><hr/><br/>";
			
		}
	}
	//SUM ROLLING from last withdraw -- END



	//Dev Tech : 24-09-11 Sum from last  withdraw remaining balance 
	//if(isset($last_withdraw['last_withdraw_remaining_balance'])&&trim($last_withdraw['last_withdraw_remaining_balance'])&&(!isset($last_withdraw['withdraw_from_date'])&&!isset($last_withdraw['withdraw_to_date'])))

	if(isset($last_withdraw['last_withdraw_remaining_balance'])&&trim($last_withdraw['last_withdraw_remaining_balance']))
	{
		$summ_mature=$summ_mature+number_formatf2($last_withdraw['last_withdraw_remaining_balance']);
	}





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

	//$total_summ_mature_amt=$total_summ_mature_amt+$summ_withdraw;	//calculate total mature amount and withdraw
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

	if(isset($_REQUEST['qp']))
	{
		echo "<br/><hr/><br/><h4>Result of trans_balance_newac_wv2</h4><br/>";
		print_r($result);
		echo "<br/><hr/><br/><h4>last_withdraw</h4><br/>";
		print_r($last_withdraw);
	}

	return $result;
}
################### A/C BALLANE account_balance_newac() -- END



//This functions used to update complete ledger of a clients.
function ms_trans_balance_calc_d_new_wv2($uid=0,$currentDate='',$tr_id=0,$trans_detail_array=[], $last_withdraw=[])
{
	//print_r($trans_detail_array);exit;
	global $data, $monthly_fee; 

	$result=array();
	$where_merID="";

	$current_date=date('Y-m-d H:i:s');
	$qprint=0;$account_curr="";$monthly_vt_fee="";
	if(isset($_REQUEST['qp']))
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



		//Dev Tech : 24-09-17 SUM ROLLING from withdraw -- START
		/*
		if($temp_trans_arr['merID']=="$uid" && ( $temp_trans_arr['trans_type']==15 || $temp_trans_arr['trans_type']==16 ) && ($temp_trans_arr['trans_status']=="1" || $temp_trans_arr['trans_status']=="13") && (isset($data['REMAINING_BALANCE_WV2'])&&$data['REMAINING_BALANCE_WV2']=='Y') )
		{	
			$summ_mature += getNumericValue($temp_trans_arr['mature_rolling_fund_amt']); //add sum of mature rolling _wv2

			$summ_immature += getNumericValue($temp_trans_arr['immature_rolling_fund_amt']); //add sum of immature rolling _wv2

			if(isset($_REQUEST['qp']))
			{
				echo "<br/>mature_rolling_fund_amt=>".@$temp_trans_arr['mature_rolling_fund_amt'];
				echo "<br/>immature_rolling_fund_amt=>".@$temp_trans_arr['immature_rolling_fund_amt'];
				
			}
		}
		*/
		//SUM ROLLING from withdraw -- END
		

	}	// END FOR LOOP


	//Dev Tech : 24-09-18 SUM ROLLING from last withdraw -- START
	if((isset($last_withdraw['last_withdraw_mature_rolling_fund_amt']) || isset($last_withdraw['last_withdraw_immature_rolling_fund_amt'])) && (isset($data['REMAINING_BALANCE_WV2'])&&$data['REMAINING_BALANCE_WV2']=='Y') )
	{	
		$summ_mature += getNumericValue(@$last_withdraw['last_withdraw_mature_rolling_fund_amt'] - $summ_mature); //add sum of mature rolling _wv2

		$summ_immature += getNumericValue($last_withdraw['last_withdraw_immature_rolling_fund_amt']-$summ_immature); //add sum of immature rolling _wv2

		if(isset($_REQUEST['qp']))
		{
			echo "<br/>last_withdraw_mature_rolling_fund_amt=>".@$last_withdraw['last_withdraw_mature_rolling_fund_amt'];
			echo "<br/>last_withdraw_immature_rolling_fund_amt=>".@$last_withdraw['last_withdraw_immature_rolling_fund_amt'];
			
		}
	}
	//SUM ROLLING from last withdraw -- END

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

	//Dev Tech : 24-09-11 Sum from last  withdraw remaining balance 
	if(isset($last_withdraw['last_withdraw_remaining_balance'])&&trim($last_withdraw['last_withdraw_remaining_balance']))
	{
		$total_success[0]['total_success']=number_formatf2($total_success[0]['total_success'])+number_formatf2($last_withdraw['last_withdraw_remaining_balance']);
	}

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

	//$total_payable_to_merchant=$total_payable_to_merchant+(double)$result['total_withdraw'];
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

	if(isset($_REQUEST['qp']))
	{
		echo "<br/><hr/><br/><h3>Result of ms_trans_balance_calc_d_new_wv2</h3><br/>";
		print_r($result);
		echo "<br/><hr/><br/><h3>last_withdraw</h3><br/>";
		print_r(@$last_withdraw);
	}
	return $result;
}


?>