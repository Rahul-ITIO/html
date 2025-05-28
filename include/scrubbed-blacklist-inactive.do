<?
//function to check scrubbed via blacklist
function blacklist_scrubbed($uid)
{
	global $data,$post;

	$tran_db=false; 
	$scrubbed_msg="";

	//Initialized variables with null or empty
	$client_ip = $client_ccno = $client_email = $client_country = $client_city = $client_phone = $client_vpa = "";

	//client ip
	if(isset($_SESSION['client_ip'])&&$_SESSION['client_ip'])
		$client_ip		= $_SESSION['client_ip'];

	//credit card
	if(isset($post['ccno'])&&$post['ccno'])
		$client_ccno	= $post['ccno'];

	//email id
	if(isset($post['bill_email'])&&$post['bill_email'])
		$client_email	= $post['bill_email'];

	//country
	if(isset($post['bill_country'])&&$post['bill_country'])
		$client_country	= $post['bill_country'];

	//city
	if(isset($post['bill_city'])&&$post['bill_city'])
		$client_city	= $post['bill_city'];

	//phone/mobile
	if(isset($post['bill_phone'])&&$post['bill_phone'])
		$client_phone	= $post['bill_phone'];

	//upi address
	if(isset($post['upi_vpa'])&&$post['upi_vpa'])
		$client_vpa		= $post['upi_vpa'];
	elseif(isset($post['upi_address'])&&$post['upi_address'])
		$client_vpa		= $post['upi_address'];

	//fetch black list
	//$blackListData = get_blacklist_details($uid);

	//fetch blacklist data 
	$blackListData=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}blacklist_data`".
		" WHERE `owner` IN ('0','1','$uid') AND `trans_status`='1' ORDER BY blacklist_type",0
	);

	if($blackListData)
	{
		foreach ($blackListData as $key => $val) {
			$blacklist_type	= $val['blacklist_type'];	//black list type - eg. ip, city, email etc
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
					$scrubbed_msg = "This Country is black listed";
					$tran_db=true;
					break;
				}
			}

			//check CITY address
			if($blacklist_type=="City"&&$client_city)
			{
				if($client_city==$blacklist_value)		//check via City
				{
					$scrubbed_msg = "This City is black listed";
					$tran_db=true;
					break;
				}
			}

			//check EMAIL address
			if($blacklist_type=="Email"&&$client_email)
			{
				if($client_email==$blacklist_value)		//check via client email
				{
					$scrubbed_msg = "This Email is black listed";
					$tran_db=true;
					break;
				}
			}

			//check CARD NUMBER address
			if($blacklist_type=="Card Number"&&$client_ccno)
			{
				if($client_ccno==$blacklist_value)		//check via Credit Card
				{
					$scrubbed_msg = "This Card is black listed";
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
					$scrubbed_msg = "This Phone/Mobile number is black listed";
					$tran_db=true;
					break;
				}
			}
		}
	}

	return array($tran_db,$scrubbed_msg);
}

//This function is used to check multiple scrubbed of a transaction
function multi_scrubbed($uid,$account_type,$trans_id,$email,$scrubbed_json,$get_clientid_details){
	global $data;

	//Initialized variables with null or empty value
	$tran_db		=false; 
	$scrubbed_msg	=""; 
	$status_upd		="";
	$sc_amt_sum		=0; 
	$sc_tr_count	=0;
	$shw_msg		="";

	//if json for multi scrubbed exists then execute following section
	if($scrubbed_json){
		$dcscrubbed = jsondecode($scrubbed_json);	//json to array

		$pro_curre=get_currency($get_clientid_details['default_currency']);	//default processing currency of a clients

		foreach($dcscrubbed as $key=>$value){	//check all defined scrubbed
			$accounts['scrubbed_period']		=$value['scrubbed_period'];		//fetch scrubbed period - should be 7, 15, 30 or 90 days
			//$accounts['min_limit']				=$value['min_limit'];	//fetch minimum transaction amount
			$accounts['max_limit']				=$value['max_limit'];	//fetch maximum transaction amount
			$accounts['tr_scrub_success_count']	=$value['tr_scrub_success_count'];	//total success allow
			//$accounts['tr_scrub_failed_count']	=$value['tr_scrub_failed_count'];	//total failed allow

			//check min_limit , if not then assgin default 1
			//$min_limit=((isset($accounts['min_limit']) && trim($accounts['min_limit']))?(double)$accounts['min_limit']:1);

			//check max_limit , if not then assgin default 500
			$max_limit=((isset($accounts['max_limit']) && trim($accounts['max_limit']))?(double)$accounts['max_limit']:500);

			//check total transaction allowed, if not then assgin default 7
			//$trn_count=((isset($accounts['transaction_count']) && trim($accounts['transaction_count']))?(int)$accounts['transaction_count']:7);

			//check total success transaction allowed, if not then assgin default 2
			$trn_success_count=((isset($accounts['tr_scrub_success_count']) && trim($accounts['tr_scrub_success_count']))?(int)$accounts['tr_scrub_success_count']:2);

			//check total failed transaction allowed, if not then assgin default 5
			//$trn_failed_count=((isset($accounts['tr_scrub_failed_count']) && trim($accounts['tr_scrub_failed_count']))?(int)$accounts['tr_scrub_failed_count']:5);

			//check scrubbed_period, if not then assgin default 1 day
			$scrubbed_period=((isset($accounts['scrubbed_period']) && trim($accounts['scrubbed_period']))?(int)$accounts['scrubbed_period']:1);


			$result=array();		//Initialized array to return result

			$status_upd=" `trans_status`=10, ";		//set status 10 for scrubbed

			//if scrubbed period and max limit and email are exists then execute scrubbed section
			if(($scrubbed_period>0)&&(!empty($max_limit))&&(!empty($email))){
				$cdate = date('Y-m-d');		//fetch current date
				if($scrubbed_period==1)		//if scrubbed_period is one means check only today transaction
				{
					$fpdate = date("Y-m-d 00:00:00");	//set from date
					$tpdate = date("Y-m-d 23:59:59");	//set to date
				}
				else //if scrubbed_period is Greater-than 1, then create from and to date accordin period
				{
					$dayfrom= $scrubbed_period-1;
					$fpdate = date("Y-m-d",strtotime("-$dayfrom day",strtotime($cdate)));
					$tpdate	= date("Y-m-d",strtotime("+1 day",strtotime($cdate)));
				}

				//query to fetch total transactions number
				/*$sc_tr=db_rows(
					"SELECT COUNT(`id`) AS `trcount`".
					" FROM `{$data['DbPrefix']}transactions`".
					" WHERE (`merID`='{$uid}') AND ( `acquirer`='{$account_type}' ) AND (`trans_status` IN (1,2,7,22,23,24)) AND `trans_type` IN ('ch', 'cn') AND ( `bill_email`='{$email}' ) ". 
					" AND (created_date between '{$fpdate}' AND '{$tpdate}') LIMIT 1",0
				);
				$sc_tr_count=(int)$sc_tr[0]['trcount'];
				*/
				//query to fetch amount of success transactions
				$sc_amt_all=db_rows(
					"SELECT SUM(`trans_amt`) AS `summ`".
					" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
					" WHERE (`merID`='{$uid}') AND ( `acquirer`='{$account_type}' ) AND ( `trans_status`=1 ) AND `trans_type` IN ('ch', 'cn') AND ( `bill_email`='{$email}' ) ".
					" AND (created_date between '{$fpdate}' AND '{$tpdate}') LIMIT 1",0
				);

				$sc_amt_sum=(double)$sc_amt_all[0]['summ'];

				//fetch the amount of current transaction
				$last_amts=db_rows(
					"SELECT `bill_amt`,`transID` ".
					" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
					" WHERE (`merID`='{$uid}') AND ( `bill_email`='{$email}' ) ".
					" ORDER BY `id` DESC LIMIT 1",0
				);
				$last_amt=$last_amts[0]['amount'];

				//query to fetch total success transactions
				$sc_tr_completed=db_rows(
					"SELECT COUNT(`id`) AS `trcount`".
					" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
					" WHERE (`merID`='{$uid}') AND ( `acquirer`='{$account_type}' ) AND (`trans_status`=1) AND ( `bill_email`='{$email}' ) ". 
					" AND (created_date between '{$fpdate}' AND '{$tpdate}') LIMIT 1",0
				);
				$sc_tr_completed_count=(int)$sc_tr_completed[0]['trcount'];

				//query to fetch total failed transactions
				$sc_tr_cancelled=db_rows(
					"SELECT COUNT(`id`) AS `trcount`".
					" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
					" WHERE (`merID`='{$uid}') AND ( `acquirer`='{$account_type}' ) AND (`trans_status`=2) AND ( `bill_email`='{$email}' ) ".
						" AND (created_date between '{$fpdate}' AND '{$tpdate}') LIMIT 1",0
				);
				$sc_tr_cancelled_count=(int)$sc_tr_cancelled[0]['trcount'];
			}

			//add current transaction amount in total success amount
			if($sc_amt_sum<=0){$sc_amt_sum=$last_amt;}else {$sc_amt_sum+=$last_amt;}

			//to check scrubbed condition
			/*if($last_amt < $min_limit) {
				$shw_msg .= ", Min. transaction amount allowed ".$pro_curre.$min_limit." on your mid";
				$tran_db=true;
			}
			else*/
			if($max_limit < $sc_amt_sum){
				$shw_msg .= ", Max. transaction amount allowed ".$pro_curre.$max_limit." on your mid";
				$tran_db=true;
			} 
/*			elseif($trn_count <= $sc_tr_count){
				$shw_msg .= ", Max. transactions allowed within (".$scrubbed_period." days) : ".$trn_count." on your mid";
				$tran_db=true;
			}
*/			elseif($trn_success_count <= $sc_tr_completed_count){
				$shw_msg .= ", Max. Success transaction allowed within ({$scrubbed_period} days) : {$sc_tr_completed_count} from {$trn_success_count} on your mid";
				$tran_db=true;
			}
			/*elseif($trn_failed_count <= $sc_tr_cancelled_count){
				$shw_msg .= ", Max. Declined transactions allowed within ({$scrubbed_period} days) : {$sc_tr_cancelled_count} from {$trn_failed_count} on your mid";
				$tran_db=true;
			}*/
			//if any of above condition is true, it means scrubbed found, so don't check further and break
			if($tran_db) break;
		}
	}

	//if trans db is true, it means transaction is scrubbed then update transaction status alognwith remark and transaction type
	if($tran_db){
		$shw_msg=ltrim($shw_msg,", ");
		$scrubbed_msg="Scrubbed Reason : ".$shw_msg;

		//query to fetch transaction remark and type if already exists
		$trans=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` WHERE `merID`='{$uid}' AND `transID`='{$trans_id}' LIMIT 1",0
		);
		$remark_get	= $trans[0]['support_note']; 	//reply remark
		$type_get	= $trans[0]['type'];		 	//type

		if($type_get==11) { 	//if type is 11 then remark date before 5 hours
			$rmk_date=date('d-m-Y h:i A',strtotime('-5 hour',strtotime(date('d-m-Y h:i:s A'))));
		}else{
			$rmk_date=date('d-m-Y h:i:s A');	//remark date as server date
		}
		//scrcubbed message
		$tr_status_set	= "Transaction has been Scrubbed. ".$scrubbed_msg;
		$remark_upd		= "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$tr_status_set." </div></div>".$remark_get;

		//query to update transaction status, type and reply remark
		db_query(
			"UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" SET ".$status_upd." `transaction_flag`=3, `support_note`='{$remark_upd}', `trans_response`='{$shw_msg}' ".
			" WHERE `merID`='{$uid}' AND `transID`='{$trans_id}'"
		);
	}

	$result['scrubbed_status']	=$tran_db;		//transaction status
	$result['scrubbed_msg']		=$scrubbed_msg;	//scrubbed message if scrubbed

	return $result;		//return result in array
}
//This function is used to check transaction is scrubbed or not
function scrubbed($uid,$account_type,$trans_id='',$email=''){

	global $data,$post;

	//Initialized variables with null or empty value
	$tran_db=false; 
	$scrubbed_msg=""; 
	$status_upd="";
	$sc_amt_sum=0; 
	$sc_tr_count=0;
	$shw_msg="";

	$blk_scrubbed = blacklist_scrubbed($uid); //check data in blacklist, if found then set trans scrubbed

	if(isset($blk_scrubbed[0])&&$blk_scrubbed[0]) { $tran_db=true;$status_upd=" `trans_status`=10, ";}
	if(isset($blk_scrubbed[1])&&$blk_scrubbed[1]) $shw_msg=", ".$blk_scrubbed[1];

	if(!$tran_db){
		//$account=select_accounts($uid, 0, true, $account_type);
		//fetch acquirer detail
		$account=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}mer_setting`".
			" WHERE `merID`='{$uid}'".
			" AND `acquirer_id`='{$account_type}' AND (`assignee_type`='1' OR `assignee_type` = '') LIMIT 1 "
		);

		$account_type=(int)$account_type;

		$get_clientid_details=select_clients_details($uid);	//fetch clients detail

		$accounts = array();
		if(isset($account[0])&&$account[0])
		{
			$accounts = $account[0];
		}
		else
		{
			//fetch data from bank gateway table
			$bank_gateway=db_rows(
				"SELECT * FROM `{$data['DbPrefix']}acquirer_table`".
				" WHERE `acquirer_id`='{$account_type}' AND (`acquirer_status`='2') LIMIT 1 "
			);
			if(isset($bank_gateway[0])&&$bank_gateway[0])
			{
				$accounts = jsondecode($bank_gateway[0]['mer_setting_json'],1);
			}
		}
//	echo $accounts['min_limit'];
//	print_r($accounts);
//	exit;
		$min_limit=((isset($accounts['min_limit']) && trim($accounts['min_limit']))?(double)$accounts['min_limit']:1);	//minimum transaction limit, default 1
		$max_limit=((isset($accounts['max_limit']) && trim($accounts['max_limit']))?(double)$accounts['max_limit']:500);	//maximum transaction limit, default 500
		$trn_count=((isset($accounts['transaction_count']) && trim($accounts['transaction_count']))?(int)$accounts['transaction_count']:7);	//maximum trans allowed, default value 7
		$trn_success_count=((isset($accounts['tr_scrub_success_count']) && trim($accounts['tr_scrub_success_count']))?(int)$accounts['tr_scrub_success_count']:2);	//maximum success trans allowed, default value 2
		$trn_failed_count=((isset($accounts['tr_scrub_failed_count']) && trim($accounts['tr_scrub_failed_count']))?(int)$accounts['tr_scrub_failed_count']:5);	//maximum failed trans allowed, default value 5

		$scrubbed_period=((isset($accounts['scrubbed_period']) && trim($accounts['scrubbed_period']))?(int)$accounts['scrubbed_period']:1);	//scrubbed period, default value 1 day

		$pro_curre=get_currency($get_clientid_details['default_currency']);	//default currency

		$result=array();

		$status_upd=" `trans_status`=10, ";	//status 10 for scrubbed

		if(($scrubbed_period>0)&&(!empty($max_limit))&&(!empty($email))){
			$cdate	= date('Y-m-d');
			if($scrubbed_period==1)	//if scrubbed period is one day, then check trans within 24hrs
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

			//total transactions
			$sc_tr=db_rows(
				"SELECT COUNT(`id`) AS `trcount`".
				" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
				" WHERE (`merID`='{$uid}') AND (`acquirer`='{$account_type}' ) AND (`trans_status` IN (1,2,7,22,23,24)) AND `trans_type` IN ('ch', 'cn') AND (`bill_email`='{$email}' ) ". 
				// " WHERE (`merID`='{$uid}') AND ( `acquirer`='{$account_type}' ) AND (`trans_status` IN (0,1,2)) AND `trans_type` IN ('ch', 'cn') AND ( `bill_email`='{$email}' ) ". 
				//" AND (tdate between '{$fpdate}' AND '{$tpdate}') LIMIT 1",0
				" AND (created_date between '{$fpdate}' AND '{$tpdate}') LIMIT 1",0
			);
			$sc_tr_count=(int)$sc_tr[0]['trcount'];

			//fetch value of success transactions
			$sc_amt_all=db_rows(
				"SELECT SUM(`trans_amt`) AS `summ`".
				" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
				" WHERE (`merID`='{$uid}') AND ( `acquirer`='{$account_type}' ) AND ( `trans_status`=1 ) AND `trans_type` IN ('ch', 'cn') AND ( `bill_email`='{$email}' ) ". //
				//" AND (tdate between '{$fpdate}' AND '{$tpdate}') LIMIT 1",0
				" AND (created_date between '{$fpdate}' AND '{$tpdate}') LIMIT 1",0
			);

			$sc_amt_sum=(double)$sc_amt_all[0]['summ'];

			//value of last transaction 
			$last_amts=db_rows(
				"SELECT `bill_amt`,`transID` ".
				" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
				" WHERE (`merID`='{$uid}') AND ( `bill_email`='{$email}' ) ".
				" ORDER BY `id` DESC LIMIT 1",0
			);
			$last_amt=$last_amts[0]['amount'];

			//total success transactions
			$sc_tr_completed=db_rows(
				"SELECT COUNT(`id`) AS `trcount`".
				" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
				" WHERE (`merID`='{$uid}') AND ( `acquirer`='{$account_type}' ) AND (`trans_status`=1) AND ( `bill_email`='{$email}' ) ". 
		//			" AND (tdate between '{$fpdate}' AND '{$tpdate}') LIMIT 1",0
					" AND (created_date between '{$fpdate}' AND '{$tpdate}') LIMIT 1",0
			);
			$sc_tr_completed_count=(int)$sc_tr_completed[0]['trcount'];

			//total failed transactions
			$sc_tr_cancelled=db_rows(
				"SELECT COUNT(`id`) AS `trcount`".
				" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
				" WHERE (`merID`='{$uid}') AND ( `acquirer`='{$account_type}' ) AND (`trans_status`=2) AND ( `bill_email`='{$email}' ) ". //
			//		" AND (tdate between '{$fpdate}' AND '{$tpdate}') LIMIT 1",0
					" AND (created_date between '{$fpdate}' AND '{$tpdate}') LIMIT 1",0
			);
			$sc_tr_cancelled_count=(int)$sc_tr_cancelled[0]['trcount'];
		}

		//Total value of success transaction
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
		elseif(isset($accounts['maximum_trans_limit'])&&$accounts['maximum_trans_limit']&&$accounts['maximum_trans_limit']<$last_amt){	//Check with per transaction limit
			$shw_msg .= ", This transaction has exceeded the max allowable limit per transaction ".$pro_curre.$accounts['maximum_trans_limit'];
			$tran_db=true;
		}
		elseif(isset($accounts['maximum_volume'])&&$accounts['maximum_volume']){// if maximum_volume define
			//fetch value of success of this acquirer of a merchant
			$amt_all=db_rows(
				"SELECT SUM(`trans_amt`) AS `summ`".
				" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
				" WHERE (`merID`='{$uid}') AND ( `acquirer`='{$account_type}' ) AND ( `trans_status`=1 ) AND `trans_type` IN ('ch', 'cn') ".
				" AND (created_date between '{$fpdate}' AND '{$tpdate}') LIMIT 1",0
			);
			$amt_volume=(double)$amt_all[0]['summ'];

			//Total value of success transaction
			if($amt_volume<=0){$amt_volume=$last_amt;}else {$amt_volume+=$last_amt;}

			if($accounts['maximum_volume']<$amt_volume)
			{
				$shw_msg .= ", Volume Cap exceeded ".$pro_curre.$accounts['maximum_volume'];
				$tran_db=true;
			}
		} 
	}

	//$tran_db=true;

	//if transaction is scrubbled then set message as scrubbed reason and update remark, status etc.
	if($tran_db){
		$shw_msg=ltrim($shw_msg,", ");
		$scrubbed_msg="Scrubbed Reason : ".$shw_msg;
		$trans=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` WHERE `merID`='{$uid}' AND `transID`='{$trans_id}' LIMIT 1",0
		);
		$remark_get	= $trans[0]['support_note']; 
		$type_get	= $trans[0]['acquirer'];

		if($type_get=="11" || $type_get==11) { 
			$rmk_date=date('d-m-Y h:i A',strtotime('-5 hour',strtotime(date('d-m-Y h:i:s A'))));
		}else{
			$rmk_date=date('d-m-Y h:i:s A');
		}
		$tr_status_set="Transaction has been Scrubbed. ".$scrubbed_msg; 
		$remark_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$tr_status_set." </div></div>".$remark_get;
		db_query(
			"UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" SET ".$status_upd." `transaction_flag`=3, `support_note`='{$remark_upd}', `trans_response`='{$shw_msg}' ".// flag scrubbed
			" WHERE `merID`='{$uid}' AND `transID`='{$trans_id}'"
		);
	}
	else
	{
		//if the transaction not scrubbed then check in multi scrubbed
		if(isset($accounts['scrubbed_json'])&&$accounts['scrubbed_json'])
		{
			$scrubbed_json=$accounts['scrubbed_json'];	//scrubbed setting from json if exits

			//function call to check multi scrubbed
			$multi_scrubbed	=multi_scrubbed($uid,$account_type,$trans_id,$email,$scrubbed_json,$get_clientid_details);
			$tran_db		=$multi_scrubbed['scrubbed_status'];		//scrubbed status
			$scrubbed_msg	=$multi_scrubbed['scrubbed_msg'];			//scrubbed reason
		}
		if($tran_db==false)	//if transaction still not scrubbed after check in multi scrubbed then check with maximum valume both acquirer level and merchant+acquirer level
		{
			//fetch data from bank gateway table
			$bank_gateway=db_rows(
				"SELECT * FROM `{$data['DbPrefix']}acquirer_table`".
				" WHERE `acquirer_id`='{$account_type}' AND (`acquirer_status`='2') LIMIT 1 "
			);
			if(isset($bank_gateway[0])&&$bank_gateway[0])
			{
				$accounts = jsondecode($bank_gateway[0]['mer_setting_json'],1);

				//check maximum volume set for acquirer or not
				if(isset($accounts['maximum_volume'])&&$accounts['maximum_volume'])
				{
					//fetch value of success of this acquirer of a merchant
					$amt_all=db_rows(
						"SELECT SUM(`trans_amt`) AS `summ`".
						" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
						" WHERE (`acquirer`='{$account_type}') AND (`trans_status`=1) AND `trans_type` IN ('ch','cn')".
						" AND (created_date between '{$fpdate}' AND '{$tpdate}') LIMIT 1",0
					);
					$amt_volume=(double)$amt_all[0]['summ'];

					//Total value of success transaction
					if($amt_volume<=0){$amt_volume=$last_amt;}else {$amt_volume+=$last_amt;}

					if($accounts['maximum_volume']<$amt_volume)
					{
						$shw_msg .= ", Acquirer has Reached Daily allowable Limit ".$pro_curre.$accounts['maximum_volume'];
						$tran_db=true;
					}
				}
			}
		}
	}

	$result['scrubbed_status']	=$tran_db;
	$result['scrubbed_msg']		=$scrubbed_msg;

	//print_r($result);exit;

	$_SESSION['scrubbed_msg']=$scrubbed_msg;	//Assign scrubbed message in $_SESSION

	return $result;	//return scrubbed result
}
?>