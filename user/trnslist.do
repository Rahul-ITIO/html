<?

if(!isset($data['PageName'])){
	$data['PageName']='My Transaction';//trnslist
}
$data['PageFile']='trnslist';

###############################################################################
if(!isset($data['DISPLAY_MULTI'])){
	include('../config.do');
}

//$post=select_info($uid, $post);
//unset($post['status']);
###############################################################################
if(isset($data['frontUiName'])) $status_button=("../front_ui/{$data['frontUiName']}/common/status_button".$data['iex']);

if(isset($status_button)&&file_exists($status_button)){
	include($status_button);
}
$data['PageTitle'] = "My {$data['trnslist']} - ".$data['domain_name'];
if(!isset($data['FileName'])){
	$data['FileName']=$data['trnslist'].$data['ex'];
}

if($data['cqp']>0){
	echo "m_clients_role=>";
	print_r($_SESSION['m_clients_role']);
	
	echo "m_clients_type=>";
	print_r($_SESSION['m_clients_type']);
	
	//exit;
}

if(!isset($_SESSION['m_clients_role'])) $_SESSION['m_clients_role'] = '';
if(!isset($_SESSION['m_clients_type'])) $_SESSION['m_clients_type'] = '';
if(basename($_SERVER['PHP_SELF'])=="{$data['trnslist']}.do"){
	  if($data['cqp']==3) $header_position=1;
       elseif(!clients_page_permission('3',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }
}

if(strpos($urlpath,"recent_order")!==false){

	if($data['cqp']==3) $header_position=2;
	elseif(!clients_page_permission('10',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }
	//$data['PageName']='Recent Order';
	//$data['PageFile']=$data['trnslist'];
	$data['PageTitle'] = 'Recent Order - '.$data['domain_name'];
	$data['FileName']='recent_order'.$data['ex'];
}
else if(strpos($urlpath,"block_")!==false){

	if($data['cqp']==3) $header_position=3;
	elseif(!clients_page_permission('4',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }
	//$data['PageName']='Block Transaction';
	//$data['PageFile']=$data['trnslist'];
	$data['PageTitle'] = "Block {$data['trnslist']} - ".$data['domain_name'];
	$data['FileName']="block_".$data['trnslist'].$data['ex'];
}
else if(strpos($urlpath,"test_")!==false){
	
	if($data['cqp']==3) $header_position=4;
	elseif(!clients_page_permission('15',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ 
		header("Location:{$data['Host']}/index".$data['ex']);exit; 
	}
	//$data['PageName']='Test Transaction';
	//$data['PageFile']=$data['trnslist'];
	$data['PageTitle'] = "Test {$data['trnslist']} - ".$data['domain_name'];
	$data['FileName']="test_".$data['trnslist'].$data['ex'];
}
else if(strpos($urlpath,"statement")!==false){

	if($data['cqp']==3) $header_position=5;
	elseif(!clients_page_permission('14',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){
		header("Location:{$data['Host']}/index".$data['ex']);exit; 
	}
	//$data['PageName']='My Statement';
	$data['PageFile']='trans_statement';
	$data['PageTitle'] = 'My Statement - '.$data['domain_name'];
	$data['FileName']='trans_statement'.$data['ex'];
}
 else if((strpos($urlpath,"report")!==false)||(isset($data['DISPLAY_MULTI']))||(isset($data['NameOfFile']))){
 
	if($data['cqp']==3) $header_position=6;
	elseif(!clients_page_permission('16',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }
 
	//$data['PageName']='Reporting';
	//$data['PageFile']=$data['trnslist'];
	$data['PageTitle'] = 'My Report - '.$data['domain_name'];
	$data['FileName']='report'.$data['ex'];
	
	

	###############################################################
	$uid_session_true=0;
	if(!isset($_SESSION['start_date_date'])){
		$_SESSION['start_date_date']=$start_date_date=date('YmdHis');
	}
	
	$current_date_time=date('YmdHis', strtotime("-30 minutes"));

	// fetch auto system as a after last withdraw 
	if(isset($data['WITHDRAW_INITIATE_SYSTEM_WV2'])&&$data['WITHDRAW_INITIATE_SYSTEM_WV2']=='Y'&&@$_REQUEST['a']!='v1')
	{


		###############################################################

		if($_SESSION['start_date_date']<$current_date_time){
			$_SESSION['start_date_date']=$start_date_date=date('YmdHis');
			if(isset($_SESSION['uid_wv2'.$uid]['ab'])){
				unset($_SESSION['uid_wv2'.$uid]['ab']);
			}
			if(isset($_SESSION['uid_wv2'.$uid])){
				unset($_SESSION['uid_wv2'.$uid]);
			}
		}
		
		if(!isset($_SESSION['uid_wv2'.$uid]['ab'])){$uid_session_true=1;}
		elseif(!isset($_SESSION['uid_wv2'.$uid])){$uid_session_true=1;}
		
		//Re-check the balance via session 
		if(isset($_REQUEST['balance_check'])){$uid_session_true=1;}

		//immature fund v3 custom enable for weekly settlement optimizer
		if(isset($_SESSION['m_settlement_optimizer'])&&strtolower($_SESSION['m_settlement_optimizer'])=='weekly')
			$data['IMMATURE_FUND_V3_CUSTOM_ENABLE']='Y';

		//Check custom from settlement optimizer and Y is CUSTOM_SETTLEMENT_WD_V3
		if(isset($_SESSION['m_settlement_optimizer'])&&(strtolower($_SESSION['m_settlement_optimizer'])=='custom'||strtolower($_SESSION['m_settlement_optimizer'])=='weekly')&&isset($data['CUSTOM_SETTLEMENT_WD_V3'])&&$data['CUSTOM_SETTLEMENT_WD_V3']=='Y')
			 $custom_settlement_wd_v3=1;
		else $custom_settlement_wd_v3=0;
		
		if($uid_session_true){
			
			//$trans_detail_array = fetch_trans_balance($uid);
			//$_SESSION['uid_wv2'.$uid]['ab']=trans_balance_newac($uid,"","",$trans_detail_array);

			if($custom_settlement_wd_v3) 
			{
				
			
				$ab=trans_balance_wv3_custom($uid);
				$_SESSION['uid_wv2'.$uid]['ab']=$ab;
			}
			else 
			{
				$_SESSION['uid_wv2'.$uid]['trans_detail_array']=$trans_detail_array=fetch_trans_balance_wv2($uid);
				$_SESSION['uid_wv2'.$uid]['ab']=$post['ab']=trans_balance_newac_wv2($uid,"","",$trans_detail_array,@$data['last_withdraw']);
			}
			
		}
		
		
		if($custom_settlement_wd_v3) {
			$ab_uid=@$_SESSION['uid_wv2'.$uid]['ab'];
			$post=array_merge(@$post,@$ab_uid);
		}
		else $post['ab']=@$_SESSION['uid_wv2'.$uid]['ab'];
		###############################################################

	}
	else 
	{
	
		// fetch all data in merchant 
		###############################################################

		if($_SESSION['start_date_date']<$current_date_time){
			$_SESSION['start_date_date']=$start_date_date=date('YmdHis');
			if(isset($_SESSION['uid_'.$uid])){
				unset($_SESSION['uid_'.$uid]);
			}
		}
		
		if(!isset($_SESSION['uid_'.$uid])){$uid_session_true=1;}
		
		//Re-check the balance via session 
		if(isset($_REQUEST['balance_check'])){$uid_session_true=1;}
		
		if($uid_session_true){
			
			$trans_detail_array = fetch_trans_balance($uid);
			$_SESSION['uid_'.$uid]['ab']=trans_balance_newac($uid,"","",$trans_detail_array);
			
		}
		
		$post['ab']=$_SESSION['uid_'.$uid]['ab'];
		###############################################################
	}

	

}
if(isset($data['NameOfFile'])){
	$data['FileName']=$data['NameOfFile'].$data['ex'];
	$_SESSION['NameOfFile']=$data['FileName'];
} 
	
###############################################################################
if(!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	if($data['cqp']==3) $header_position=7;
	else
	{
		header("Location:{$data['Host']}/index".$data['ex']);
		echo('ACCESS DENIED.');
		exit;
	}
}
if(is_info_empty($uid)){
	//header("Location:{$data['Host']}/user/profile".$data['ex']);
	//echo('ACCESS DENIED.');
	//exit;
}
if(isset($header_position)){
	$_SESSION['header_position']=@$header_position;
	echo "header_position=>".@$header_position;
	//exit;
}

if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'){
	$mta=1;
	$mts="`ad`";
}
else{
	$mta=0;
	$mts="`t`";
}


if(isset($data['con_name']))
	$_SESSION['con_name']=$data['con_name'];
	
	//print_r($_SESSION['con_name']);
	
###############################################################################
if(!isset($post['StartPage']))$post['StartPage']=0;
###############################################################################
if(!isset($post['action']))$post['action']='select';
if(!isset($post['type']))$post['type']=-1;
if(!isset($post['status']))$post['status']=-1;
###############################################################################
$where='';
$post['SearchResult']=False;
if($post['action']=='search'){
	if($post['search']){
		if($post['field']=='username'){
			$suser=$post['username'];
			$sdate='';
			$post['SearchResult']=True;
		}elseif($post['field']=='tdate'){
			$suser='';
			//$sdate="{$post['year']}-{$post['month']}-{$post['day']}";
			$setdate = date('Y-m-d h:i:s',strtotime($post['date1']));
			$sdate="{$setdate}";
			$post['SearchResult']=True;
		}
		$post['action']='select';
	}elseif($post['cancel']){
		$post['StartPage']=$post['page'];
		$post['action']='select';
	}else{
		$now=getdate();
		if(!isset($post['month']))$post['month']=$now['mon'];
		if(!isset($post['day']))$post['day']=$now['mday'];
		if(!isset($post['year']))$post['year']=$now['year'];
		if(!$post['month'])$post['day']=0;

		$data['StatDays']=array();
		for($i=1;$i<=31;$i++)$data['StatDays'][$i]=$i;
		$data['StatMonth']=array();
		for($i=1;$i<=12;$i++)$data['StatMonth'][$i]=date('F', mktime(0,0,0,$i,1,0));
		$years=get_transactions_year();
		$data['StatYear']=array();
		for($i=$years['min'];$i<=$years['max'];$i++)$data['StatYear'][$i]=$i;
	}
}elseif($post['action']=='irefund'){
	update_trans_ranges($uid, 8, $post['gid'], '', false, false);
}elseif($post['action']=='refund'){
	//echo "<br/>uid=>".$uid; echo "<br/>gid=>".$post['gid'];
	update_trans_ranges($uid, 8, $post['gid'], '', true, false);
	$post['action']='select';
}elseif($post['action']=='reminders_range'){
	$trange = $_GET['trange'];
	update_trans_ranges($uid, 412, $trange, '', false, false);
}elseif($post['action']=='addremark'){

	$remark_slct=db_rows(
			"SELECT `mer_note`,`type` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` WHERE `id`={$post['gid']}"
	);
	$remark_get = $remark_slct[0]['mer_note']; 
	$type_get 	= $remark_slct[0]['type']; 
	
		
	$rmk_date=date('d-m-Y h:i:s A');
	
	$remark_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$post['mer_note']."</div></div>".$remark_get;
		
	if($post['mer_note']){
		db_query(
			"UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" SET `mer_note`='{$remark_upd}',`remark_status`=1".
			" WHERE `id`={$post['gid']}"
		);
	}
	

	exit;
	$post['action']='select';
}
###############################################################################
if(strpos($urlpath,"statement")!==false){
	//$post['ab']=account_balance($uid);
}

if($data['cqp']>0) echo "action select";

$custom_settlement_optimizer_v3=0;

if(@$data['NameOfFile']=='trans_withdraw-fund-list'&&isset($_SESSION['m_settlement_optimizer'])&&(strtolower($_SESSION['m_settlement_optimizer'])=='custom'||strtolower($_SESSION['m_settlement_optimizer'])=='weekly')){
	$custom_settlement_optimizer_v3=1;
	//echo "<br/>NameOfFile=>".$data['NameOfFile'];
}

if($post['action']=='select'){
		$where_0=array();
		$where=array();
		//$where[]=" (t.sender={$uid} OR t.merID={$uid})  ";
		/*
		$where[]=" (`t`.`merID` IN ({$uid})) AND (  `t`.`related_transID` IS NULL OR `t`.`related_transID`='' OR lower(`t`.`related_transID`) LIKE '%\"recent_failed_tid\":%'  OR `t`.`trans_status` NOT IN (2) ) ";
		 
		$reportdate = " AND (  `t`.`related_transID` IS NULL OR `t`.`related_transID`='' OR lower(`t`.`related_transID`) LIKE '%\"recent_failed_tid\":%' OR `t`.`trans_status` NOT IN (2)  ) "; 
		*/
		
		if($custom_settlement_optimizer_v3==0)
		{
			$where_0[]=" (`t`.`merID` IN ({$uid})) AND (  `t`.`related_transID` IS NULL OR `t`.`related_transID`='' OR `t`.`related_transID` LIKE '%\"recent_failed_tid\":%'  OR `t`.`trans_status` NOT IN (2) ) ";
			
			@$reportdate_0 = " AND (  `t`.`related_transID` IS NULL OR `t`.`related_transID`='' OR `t`.`related_transID` LIKE '%\"recent_failed_tid\":%' OR `t`.`trans_status` NOT IN (2)  ) "; 
		}
		else {
			@$reportdate_0 = "";
		}
		
		
		
		//$orderby=" t.id"; // bill_amt
		$orderby=" `t`.`tdate`"; // bill_amt
		
        if($post['status']>=0)$where[]=" (`t`.`trans_status`={$post['status']})";
        //if($post['type']>=0)$where[]=" (`t`.`acquirer`={$post['type']})";
		if((isset($post['type']))&& ($post['type']!=-1))
			{
				$where[]=" (`t`.`trans_type`='".$post['type']."')";
				$reportdate.=" AND (`t`.`trans_type`='".$post['type']."')";
				}
        //if($post['bid'])$where[]=" t.sender={$post['bid']} OR  t.merID={$post['bid']}";
		if(isset($post['order']))$orderby=" t.".$post['order']."";
		
		 
		$keyname=-1;if(isset($_GET['keyname'])){$keyname=$_GET['keyname'];}
		$searchkey="";if(isset($_GET['searchkey'])){$searchkey=trim($_GET['searchkey']);$searchkey=strtolower($searchkey);}
		
		if(isset($_GET['keyname'])&&($keyname>0)&&($searchkey)){
			if($keyname==1){
				@$reportdate .= " AND ( lower(t.transID) LIKE '%".$searchkey."%' )";
				$where[]	= " ( lower(t.transID) LIKE '%".$searchkey."%' ) ";
			}elseif($keyname==2){
				@$reportdate .= " AND ( lower(t.fullname) LIKE '%".$searchkey."%' )";
				$where[]	= " ( lower(t.fullname) LIKE '%".$searchkey."%' ) ";
			}elseif($keyname==3){
				@$reportdate .= " AND ( lower(t.bill_email) LIKE '%".$searchkey."%' )";
				$where[]	= " ( lower(t.bill_email) LIKE '%".$searchkey."%' ) ";
			}elseif($keyname==4){
				@$reportdate .= " AND ( lower(t.bill_amt) LIKE '%".$searchkey."%' )";
				$where[]	= " ( lower(t.bill_amt) LIKE '%".$searchkey."%' ) ";
			}elseif($keyname==5){
				@$reportdate .= " AND ( lower({$mts}.`bill_phone`) LIKE '%".$searchkey."%' )";
				$where[]	= " ( lower({$mts}.`bill_phone`) LIKE '%".$searchkey."%' ) ";
			}elseif($keyname==6){
				@$reportdate .= " AND ( lower(c.routing) LIKE '%".$searchkey."%' ) AND (t.transID=c.unique_id) "; // 
				$where[]	= " ( lower(c.routing) LIKE '%".$searchkey."%' ) ";
			}elseif($keyname==7){
				$searchkey=encryptres($searchkey);
				@$reportdate .= " AND ( lower(c.bankaccount) LIKE '%".$searchkey."%' ) AND (t.transID=c.unique_id) "; // 
				$where[]	= " ( lower(c.bankaccount) LIKE '%".$searchkey."%' ) ";
			}elseif($keyname==8){
				@$reportdate .= " AND ( ( lower(`t`.`acquirer`_ref) LIKE '%".$searchkey."%' ) OR ( lower(`t`.`acquirer`_response) LIKE '%".$searchkey."%' )  ) ";
				$where[]	= " ( ( lower(`t`.`acquirer`_ref) LIKE '%".$searchkey."%' ) OR ( lower(`t`.`acquirer`_response) LIKE '%".$searchkey."%' ) ) ";
			}elseif($keyname==11){
				@$reportdate .= " AND ( lower({$mts}.`bill_address`) LIKE '%".$searchkey."%' )";
				$where[]	= " ( lower({$mts}.`bill_address`) LIKE '%".$searchkey."%' ) ";
			}elseif($keyname==12){
				@$reportdate .= " AND ( lower({$mts}.`bill_city`) LIKE '%".$searchkey."%' )";
				$where[]	= " ( lower({$mts}.`bill_city`) LIKE '%".$searchkey."%' ) ";
			}elseif($keyname==13){
				@$reportdate .= " AND ( lower({$mts}.`bill_state`) LIKE '%".$searchkey."%' )";
				$where[]	= " ( lower({$mts}.`bill_state`) LIKE '%".$searchkey."%' ) ";
			}elseif($keyname==14){
				@$reportdate .= " AND ( lower({$mts}.`country`) LIKE '%".$searchkey."%' )";
				$where[]	= " ( lower({$mts}.`country`) LIKE '%".$searchkey."%' ) ";
			}elseif($keyname==15){
				@$reportdate .= " AND ( lower({$mts}.`bill_zip`) LIKE '%".$searchkey."%' )";
				$where[]	= " ( lower({$mts}.`bill_zip`) LIKE '%".$searchkey."%' ) ";
			}elseif($keyname==16){
				@$reportdate .= " AND ( lower({$mts}.`product_name`) LIKE '%".$searchkey."%' )";
				$where[]	= " ( lower({$mts}.`product_name`) LIKE '%".$searchkey."%' ) ";
			}elseif($keyname==18){
				@$reportdate .= " AND ( lower(`t`.`bill_ip`) LIKE '%".$searchkey."%' )";
				$where[]	= " ( lower(`t`.`bill_ip`) LIKE '%".$searchkey."%' ) ";
			}
			elseif($keyname==19){
				@$reportdate .= " AND ( `t`.`remark_status` IN (1,2,3) )";
				$where[]	= " ( `t`.`remark_status` IN (1,2,3) ) ";
				$orderby="`t`.`remark_status`=3, `t`.`remark_status`=1, `t`.`remark_status`=2";
			}
			elseif($keyname==115){
				@$reportdate .= " AND ( `t`.`terNO`=".$searchkey." )";
				$where[]	= " ( `t`.`terNO`=".$searchkey." ) ";
			}
			//echo "<br/>reportdate=>".$reportdate."<br/>";
		}
		
		if(isset($data['OptionNotification']) && $data['OptionNotification']){
			@$reportdate .= " AND ( `t`.`remark_status` IN (1,2) )";
			$where[]	= " ( `t`.`remark_status` IN (1,2) ) ";
			$orderby="`t`.`remark_status`=3, `t`.`remark_status`=1, `t`.`remark_status`=2";
		}
			
		if( (isset($_REQUEST['searchkey'])&&isset($_REQUEST['key_name'])&&$_REQUEST['searchkey']&&isset($_REQUEST['key_name'])&&$_REQUEST['key_name'])&&(!isset($_REQUEST['keyname'])||!$_REQUEST['keyname']) ){
			$search_key1=trim($_REQUEST['searchkey']);
			
			if (preg_match("/^[1-9][0-9]*$/", $search_key1)) {
				$searchkey=$search_key1;
			}else{
				$searchkey=strtolower($search_key1);
			}
				
			
			$kn=stf($_REQUEST['key_name']); 
			
			//echo "<br/>searchkey=>".$searchkey; echo "<br/>kn=>".$kn;
			
			if($kn=='bill_phone'||$kn=='product_name'||$kn=='upa'||$kn=='rrn'||$kn=='acquirer_ref'||$kn=='acquirer_response'||$kn=='descriptor'||$kn=='bin_no'||$kn=='ccno'||$kn=='ex_month'||$kn=='ex_year'||$kn=='trans_response'||$kn=='bill_phone'||$kn=='bill_address'||$kn=='bill_city'||$kn=='bill_state'||$kn=='bill_country'||$kn=='bill_zip'){
				
				@$reportdate .= " AND ( {$mts}.`{$kn}` IN ('{$search_key1}') )";
				$where[]	= " ( {$mts}.`{$kn}` IN ('{$search_key1}') ) ";
			}
			elseif($kn=='payable_amt_of_txn'||$kn=='bill_amt'||$kn=='trans_amt'||$kn=='buy_mdr_amt'||$kn=='buy_txnfee_amt'||$kn=='rolling_amt'||$kn=='mdr_cb_amt'||$kn=='mdr_cbk1_amt'||$kn=='mdr_refundfee_amt'||$kn=='bank_processing_bill_amt'||$kn=='available_balance'||$kn=='trans_status'){
				if($kn=='trans_status'){
					$ts_1=$data['TransactionStatus'];
					$ts=array_flip($ts_1);
					if(preg_match("/[a-z]/i", $searchkey)){
						$searchkey=$ts[ucfirst($searchkey)];
					}
				}
				@$reportdate .= " AND ( `t`.`{$kn}` IN ('{$searchkey}') )";
				$where[]	= " ( `t`.`{$kn}` IN ('{$searchkey}') ) ";
			}
			elseif($kn=='transID'||$kn=='bearer_token'||$kn=='acquirer'||$kn=='terNO'||$kn=='channel_type'||$kn=='remark_status'){
				@$reportdate .= " AND ( `t`.`{$kn}` IN ({$search_key1}) )";
				$where[]	= " ( `t`.`{$kn}` IN ({$search_key1}) ) ";
			}
			else{
				$searchkey=impf($search_key1,2);
				
				@$reportdate .= " AND ( `t`.`{$kn}` IN ({$searchkey}) )";
				$where[]	= " ( `t`.`{$kn}` IN ({$searchkey}) ) ";
				
				
			}
			
			
				
		}
		
		if(isset($_REQUEST['acquirer_type']) && $_REQUEST['acquirer_type']){
			$acquirer_type=implodef($_REQUEST['acquirer_type']);
			$reportdate.=" AND ( `type` IN ({$acquirer_type}) ) ";
			$where[]	= " ( `type` {$sort}IN ({$acquirer_type}) ) ";
		}
		
		
		
		/*
		if(isset($_GET['time_period'])){
			$date_1st="";$date_2nd="";
				if(isset($_GET['date_1st'])&&isset($_GET['date_2nd'])&&$_GET['date_1st']&&$_GET['date_2nd']){
					$date_1st=$_GET['date_1st'];
					$date_2nd=$_GET['date_2nd'];
					$date_2nd=date("Y-m-d",strtotime("+1 day",strtotime($_GET['date_2nd'])));
				}elseif($_GET['time_period']==2){
					$date_1st=date('Y-m-d');
					$date_2nd=date("Y-m-d",strtotime("+1 day"));
				}elseif($_GET['time_period']==3){
					$date_1st=date("Y-m-d",strtotime("-7 day"));
					$date_2nd=date("Y-m-d",strtotime("+1 day"));
				}elseif($_GET['time_period']==4){
					$date_1st=date("Y-m-d", strtotime("first day of this month"));
					$date_2nd=date("Y-m-d", strtotime("last day of this month"));
				}elseif($_GET['time_period']==5){
					$date_1st=date("Y-01-01");
					$date_2nd=date("Y-12-31");
				}
			if (($date_1st!='')&&($date_2nd!='')){
					@$reportdate .=" AND ( t.tdate BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d')) ";
					@$reportdate .=" AND (DATE_FORMAT('{$date_2nd}', '%Y%m%d')) )  ";
					
					
					$where[]	= " ( t.tdate BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d')) AND".
					" (DATE_FORMAT('{$date_2nd}', '%Y%m%d')) ) ";
				}
		}
		
		*/
		
		if(isset($_REQUEST['date_1st']) && isset($_REQUEST['date_2nd']) && $_REQUEST['date_1st']&&$_REQUEST['date_2nd']){
			$date_1st=(date('Y-m-d H:i:s',strtotime($_REQUEST['date_1st'])));
			$date_2nd=(date('Y-m-d H:i:s',strtotime($_REQUEST['date_2nd'])));
			//$_REQUEST['date_2nd']=(date('Y-m-d H:i:s',strtotime("+1 day",strtotime($_REQUEST['date_2nd']))));

			$date_2nd_24=(date('His',strtotime($_REQUEST['date_2nd'])));
			if($date_2nd_24=='000000'||$date_2nd_24=='235959'){
				$date_2nd=(date('Y-m-d 24:00:00',strtotime($_REQUEST['date_2nd'])));
				//echo "<br/>date_2nd_24=>".$date_2nd_24;
				//echo "<br/>date_2nd=>".$date_2nd;
			}
			
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
			
			$reportdate.=" AND ( {$sl_date} BETWEEN '{$date_1st}' AND '{$date_2nd}' )  "; 
			$where[]	= " ( {$sl_date} BETWEEN '{$date_1st}' AND '{$date_2nd}' )  ";
			
			
		}
		
		
		
		$s=(($where)?" AND ".implode(' AND ', $where)." ":"");
		$stf=1;if(strpos($s,"status")!==false){$stf=0;}
		$s1=$s.(($stf)?' AND ( `t`.`trans_status`=1 ) ':'');
		$s2=$s.(($stf)?' AND ( `t`.`trans_status`=2 ) ':'');
		
		$status_wise=1;
		if(isset($post['status'])&&$post['status']>0){
			$status_wise=0;
		}
		
			if(strpos($urlpath,"recent_order")!==false){
				// 
				@$reportdate .= " AND ( ( `t`.`trans_status` IN (0,1,3,4,5,6,7,8,11,12,13,14,15) ) OR ( `t`.`trans_status`=2 AND (lower({$mts}.`support_note`) LIKE '%do not honour%' OR lower({$mts}.`support_note`) LIKE '%[05]declined%' ) ) ) ";
				$where[]	= " ( ( `t`.`trans_status` IN (0,1,3,4,5,6,7,8,11,12,13,14,15) )  OR ( `t`.`trans_status`=2 AND (lower({$mts}.`support_note`) LIKE '%do not honour%' OR lower({$mts}.`support_note`) LIKE '%[05]declined%' ) ) ) ";
				//$s1=$s." AND ( `t`.`trans_status`=1 ) ";
				$s2=$s." AND ( `t`.`trans_status`=2 AND (lower({$mts}.`support_note`) LIKE '%do not honour%' OR lower({$mts}.`support_note`) LIKE '%[05]declined%' ) ) ";
			}else if(strpos($urlpath,"block_")!==false){

				@$reportdate .= " AND  ( ( `t`.`trans_status`=10 ) OR ( (`t`.`trans_status`=2) AND ( NOT ((lower({$mts}.`support_note`) LIKE '%do not honour%') OR (lower({$mts}.`support_note`) LIKE '%[05]declined%' )    ) ) ) ) ";
				$where[]	= " ( ( `t`.`trans_status`=10 ) OR ( (`t`.`trans_status`=2) AND ( NOT ((lower({$mts}.`support_note`) LIKE '%do not honour%') OR (lower({$mts}.`support_note`) LIKE '%[05]declined%' )    ) ) ) ) ";
				//$s1=$s." AND ( `t`.`trans_status`!=1 ) ";
				$s2=$s." AND ( (`t`.`trans_status`=2) AND ( NOT ((lower({$mts}.`support_note`) LIKE '%do not honour%') OR (lower({$mts}.`support_note`) LIKE '%[05]declined%' )    ) ) ) ";
			}else if(strpos($urlpath,"test_")!==false){
				@$reportdate .= " AND ( `t`.`trans_status`=9 ) ";
				$where[]	= " ( `t`.`trans_status`=9 ) ";
				$status_wise=0;
			}else if((strpos($urlpath,"report")!==false)||(isset($data['DISPLAY_MULTI']))||(isset($data['NameOfFile']))){
				@$reportdate .= " AND ( `t`.`acquirer`=2 ) "; $where[]	= " ( `t`.`acquirer`=2 ) ";
			}
			
	if(!isset($_GET['page'])) unset($_SESSION['total_record_result']);
		if(isset($_GET['records_per_page'])&&$_GET['records_per_page']){
			$data['MaxRowsByPage']=$_GET['records_per_page'];
		}else{
	$data['MaxRowsByPage']=50;		
		}			
	
	$_SESSION['query_post_pg'] = $_REQUEST;
	$_SESSION['MaxRowsByPage'] = $data['MaxRowsByPage'];

	$where=array_merge(@$where_0,@$where);
	$data['ct_query'] = ($where?" AND ".implode(' AND ', $where)." ":"");
/*echo"<br /><br />".	$count=get_trans_counts(($where)?" AND ".implode(' AND ', $where)." ":"");
	$data['tr_count']=$count;
	$data['total_count']=$count;
	for($i=0; $i<$count; $i+=$data['MaxRowsByPage'])$data['Pages'][]=$i;
*/
	
	//	echo "<br/><hr/><br/>reportdate=>".$reportdate."<br/><hr/><br/>";
	
	
	if(isset($_REQUEST['downloadcvs'])){
		$csv_qr="";
		if($post['status']!='-1') $csv_qr="  AND ( `t`.`trans_status`={$post['status']} )";
		//echo "<br/>ct_query=>".$data['ct_query'];
		$_SESSION['merchant_csv_qr']=$csv_qr.$reportdate;
		//echo "<br/>merchant_csv_qr=>".$_SESSION['merchant_csv_qr'];
		$request_arr=[];
		if(isset($_REQUEST['date_2nd'])) $request_arr['date_2nd']=$_REQUEST['date_2nd'];
		if(isset($_REQUEST['is_created_date_on'])&&@$_REQUEST['is_created_date_on']=='1')
					$request_arr['is_created_date_on']=$_REQUEST['is_created_date_on'];
		if(isset($data['DB_CON'])&&isset($data['GW_CSV_DATA_FILTER_MORE_CONNECTION_WISE'])&&@$data['GW_CSV_DATA_FILTER_MORE_CONNECTION_WISE']=='Y')
					$request_arr['db_more_connection']=@$data['GW_CSV_DATA_FILTER_MORE_CONNECTION_WISE'];

		if(isset($data['TIME_TO_COMPLETION_TRANSACTION_SECONDS'])&&@$data['TIME_TO_COMPLETION_TRANSACTION_SECONDS']=='Y'  &&  date("Ymd",strtotime($_REQUEST['date_2nd'])) >= date("Ymd",strtotime($data['RUNTIME_DB_DATE_2ND'])) )
					$request_arr['runtime']='Y';

		$request_arr_set=http_build_query($request_arr);
		if(isset($_REQUEST['a'])&&$_REQUEST['a']=='csv') $request_arr_set=$request_arr_set."&dtest=1&qp=1";
		header("Location:../include/merchant_csv_data".$data['ex']."?".$request_arr_set);exit;
	}
	
	
	
	$data['TransactionsList']=$post['Transactions']=mer_trans_list(
		$uid,
		'both',
		-1,
		$post['status'],
		$post['StartPage'],
		$data['MaxRowsByPage'],
		$reportdate_0.$reportdate." ORDER BY ".$orderby." DESC",
		'',
		'',
		$custom_settlement_optimizer_v3
	);
	
	
	if(isset($_REQUEST['dtest'])) {
		echo "<br/>00 last_record=>".$data['last_record'];
		echo "<br/>tr_count=>".$data['tr_count'];
	}
	
	//if(isset($data['tr_counts_q'])) $post['tr_counts_q']=$data['tr_counts_q'];
	
	
	

	$more_db_loop=1;
	
	//Dev Tech: 24-01-08 Fetch more db connection
	$maxRowsByPage=$data['MaxRowsByPage'];
	//$maxRowsByPage=50;
	if( $data['last_record'] < $maxRowsByPage && isset($data['DB_CON']) && !isset($_GET['DB_CON']) && function_exists('config_db_more_connection') && $more_db_loop )
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
		echo "<hr/><br/>DB_CON=>".$DB_CON;
		echo "<br/>db_ad=>".$db_ad;
		echo "<br/>db_mt=>".$db_mt;
		echo "<hr/>";
		*/
		
		$db_con_arr=$data['DB_CON'];
		
		
		if(isset($db_con_arr[$DB_CON]['MORE_ADDITIONAL'][$db_ad])) unset($db_con_arr[$DB_CON]['MORE_ADDITIONAL'][$db_ad]);
		if(isset($db_con_arr[$DB_CON]['MORE_MASTER'][$db_mt])) unset($db_con_arr[$DB_CON]['MORE_MASTER'][$db_mt]);
		//elseif($DB_CON>0&&isset($db_con_arr[$DB_CON])) unset($db_con_arr[$DB_CON]);
		
			
		//echo "<br/>count=>".count($db_con_arr[$DB_CON]['MORE_ADDITIONAL'])."<br/>";
		//print_r($db_con_arr);

		if(isset($_REQUEST['dtest'])) echo "<hr/><h4 style='font-size:22px!important;font-weight:bold;color:#3a8411;'>More DB Search :: connection_type=> ".@$data['connection_type']."</h4>";
		
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
						
						
						$data['TransactionsList1']=mer_trans_list(
							$uid,
							'both',
							-1,
							$post['status'],
							$post['StartPage'],
							$data['MaxRowsByPage'],
							$reportdate_0.$reportdate." ORDER BY ".$orderby." DESC"
						); 
						
						
						
						if(isset($_REQUEST['dtest'])) {
							echo "<br/>last_record=>".@$last_record;
							echo "<br/>tr_count=>".@$data['tr_count'];
						}
						
						
						if($data['TransactionsList']) $data['TransactionsList']=array_merge($data['TransactionsList'],$data['TransactionsList1']);
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
					
					$reportdate_mm=str_replace('`ad`.','`t`.',@$reportdate_0.@$reportdate);
					
					$data['TransactionsList1']=mer_trans_list(
						$uid,
						'both',
						-1,
						$post['status'],
						$post['StartPage'],
						$data['MaxRowsByPage'],
						$reportdate_mm." ORDER BY ".$orderby." DESC"
					);
					
					if(isset($_REQUEST['dtest'])) {
						echo "<br/>tr_count=>".$data['tr_count'];
					}
					
				
					
					if($data['TransactionsList']) $data['TransactionsList']=array_merge($data['TransactionsList'],$data['TransactionsList1']);
					elseif($data['TransactionsList1'])$data['TransactionsList']=$data['TransactionsList1'];
				
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
					
					$data['TransactionsList1']=mer_trans_list(
						$uid,
						'both',
						-1,
						$post['status'],
						$post['StartPage'],
						$data['MaxRowsByPage'],
						$reportdate_0.$reportdate." ORDER BY ".$orderby." DESC"
					); 
					
					if(isset($_REQUEST['dtest'])) {
						echo "<br/>last_record=>".$data['last_record'];
						echo "<br/>tr_count=>".$data['tr_count'];
					}
					
					$data['last_record']=$data['tr_count']=$data['last_record']+$last_record;
					
					if($data['TransactionsList']) $data['TransactionsList']=array_merge($data['TransactionsList'],$data['TransactionsList1']);
					elseif($data['TransactionsList1'])$data['TransactionsList']=$data['TransactionsList1'];
				
					$trs_count=count(@$data['TransactionsList']);
					if($trs_count>=$maxRowsByPage&&!isset($_REQUEST['all'])) break;
				
			}
			
			
			
			
		}
		
		if(isset($data['TransactionsList'])&&count($data['TransactionsList'])>0)
		{ 
			$data['MaxRowsByPage']=$data['last_record']=$data['tr_count']=count(@$data['TransactionsList']);
			$post['Transactions']=@$data['TransactionsList'];
		}
		
		//array_multisort(array_column($data['TransactionsList'], 'tdate'), SORT_ASC, $data['TransactionsList']);
		
		//if(function_exists('db_disconnect')) db_disconnect();
		//if(function_exists('db_disconnect_mysqli')) db_disconnect_mysqli();
		//if(function_exists('db_disconnect_psql')) db_disconnect_psql();
		
		//$data['Hostname']=$db_hostname_1;$data['Username']=$db_username_1;$data['Password']=$db_password_1;$data['Database']=$db_database_1;$data['DbPort']=$DbPort_1;$data['connection_type']=$connection_type_1;
		
		/*
		echo "<hr/><br/>==DB_CON=>".$DB_CON;
		echo "<br/>db_ad=>".$db_ad;
		echo "<br/>db_mt=>".$db_mt;
		echo "<hr/>";
		*/
		config_db_more_connection($DB_CON,$db_ad,$db_mt,1);
		
	}
	
	
	//if(isset($_REQUEST['dtest'])) echo "<hr/><h4 style='font-size:22px!important;font-weight:bold;color:#3a8411;'>More DB Search :: connection_type=> ".@$data['connection_type']."</h4>";
	
	// Search for custom settlement v3
	if(@$data['NameOfFile']!='trans_withdraw-fund-list' && $data['last_record'] < $maxRowsByPage && isset($_SESSION['m_settlement_optimizer'])&&(strtolower($_SESSION['m_settlement_optimizer'])=='custom'||strtolower($_SESSION['m_settlement_optimizer'])=='weekly')&&isset($data['CUSTOM_SETTLEMENT_WD_V3'])&&$data['CUSTOM_SETTLEMENT_WD_V3']=='Y')
	{
		if(isset($_REQUEST['dtest'])) echo "<hr/><h4 style='font-size:22px!important;font-weight:bold;color:#3a8411;'>V3 Search :: settlement_optimizer=> ".@$_SESSION['m_settlement_optimizer']."</h4>";

		$last_record=$data['last_record'];
			
			
			$post['Transactions1']=mer_trans_list(
				$uid,
				'both',
				-1,
				$post['status'],
				$post['StartPage'],
				$maxRowsByPage,
				$reportdate." ORDER BY ".$orderby." DESC",
				'',
				'',
				1
			);
			
			if(isset($_REQUEST['dtest'])) {
				echo "<br/>11 last_record=>".$data['last_record'];
				echo "<br/>tr_count=>".$data['tr_count'];
			}
			
			$data['last_record']=$data['tr_count']=$data['last_record']+$last_record;
			
			if(isset($_REQUEST['dtest'])) {
				echo "<br/>22 last_record=>".$data['last_record'];
				echo "<br/>tr_count=>".$data['tr_count'];
			}
			
			if($post['Transactions']) $post['Transactions']=array_merge(@$post['Transactions'],@$post['Transactions1']);
			elseif($post['Transactions1'])$post['Transactions']=@$post['Transactions1'];


	}
	
	
	
	// Fetch Backup db for above of 7 days trans
	
	//if((($data['last_record']==0&&$data['backUpDb']=='') || ((isset($_REQUEST['all'])) ) )&&isset($data['Database_3'])&&$data['Database_3']&&function_exists('db_connect_3'))
	/*
	if((($data['last_record'] < 49 && $data['backUpDb']=='') || ((isset($_REQUEST['all'])) ) )&&isset($data['Database_3'])&&$data['Database_3']&&function_exists('db_connect_3'))
		
	{
		
			$data['backUpDbSet']="`{$data['Database_3']}`.";
			
			$last_record=$data['last_record'];
			
			
			$post['Transactions1']=mer_trans_list(
				$uid,
				'both',
				-1,
				$post['status'],
				$post['StartPage'],
				$data['MaxRowsByPage'],
				$reportdate." ORDER BY ".$orderby." DESC"
			);
			
			if(isset($_REQUEST['dtest'])) {
				echo "<br/>11 last_record=>".$data['last_record'];
				echo "<br/>tr_count=>".$data['tr_count'];
			}
			
			$data['last_record']=$data['tr_count']=$data['last_record']+$last_record;
			
			if(isset($_REQUEST['dtest'])) {
				echo "<br/>22 last_record=>".$data['last_record'];
				echo "<br/>tr_count=>".$data['tr_count'];
			}
			
			if($post['Transactions']) $post['Transactions']=array_merge($post['Transactions'],$post['Transactions1']);
			elseif($post['Transactions1'])$post['Transactions']=$post['Transactions1'];
			
				
			
	}
	
	*/
	
	
	
	
	if(isset($data['OptionNotification']) && $data['OptionNotification']){
		$_SESSION['mNotificationCount']=$data['tr_count'];
	}
	
	
	$post['TStatusWise']="";
	/*if($status_wise){
		
		if($data['PageName']=='Block Transaction'){
			$s1_1="";
			$s1_2="";
		}else{
			$s1_1="<td>".get_trans_counts($s1)." </td>";
			$s1_2="<td><a class=strlink href=".$urlpath_s."status=1".$sumtrurl.">Completed</a></td>";
		}
		
		
		if($data['PageName']=='Regular Transaction'){
			$s9_10_1="";
			$s9_10_2="";
		}else{
			$s9_10_1="<td>".get_trans_counts($s.(($stf)?' AND ( `t`.`trans_status`=9 ) ':''))."</td>
		  <td>".get_trans_counts($s.(($stf)?' AND ( `t`.`trans_status`=10 ) ':''))."</td>";
			$s9_10_2=" <td><a class=strlink href=".$urlpath_s."status=9".$sumtrurl.">Test Transaction</a></td>
			  <td><a class=strlink href=".$urlpath_s."status=10".$sumtrurl.">Scrubbed</a></td>";
			
		}
	
		$tco="<tr>
		  <td>".$count." </td>
		  <td>".get_trans_counts($s.(($stf)?' AND ( `t`.`trans_status`=0 ) ':''))." </td>
		  ".$s1_1."
		  <td>".get_trans_counts($s2)." </td>
		  <td>".get_trans_counts($s.(($stf)?' AND ( `t`.`trans_status`=3 ) ':''))."</td>
		  <td>".get_trans_counts($s.(($stf)?' AND ( `t`.`trans_status`=4 ) ':''))."</td>
		  <td>".get_trans_counts($s.(($stf)?' AND ( `t`.`trans_status`=5 ) ':''))."</td>
		  <td>".get_trans_counts($s.(($stf)?' AND ( `t`.`trans_status`=6 ) ':''))."</td>
		  <td>".get_trans_counts($s.(($stf)?' AND ( `t`.`trans_status`=7 ) ':''))."</td>
		  <td>".get_trans_counts($s.(($stf)?' AND ( `t`.`trans_status`=8 ) ':''))."</td>
		  ".$s9_10_1."
		  <td>".get_trans_counts($s.(($stf)?' AND ( `t`.`trans_status`=11 ) ':''))."</td>
		</tr>";
		
		if(strpos($urlpath,"?")!==false){
			$urlpath_s=$urlpath."&";
		}else{
			$urlpath_s=$urlpath."?";
		}
		
	 if($data['PageName']=='Block Transaction'){
		$post['TStatusWise']="
	  <div class=summary_div>
		<table align=center border=1 cellspacing=0 cellpadding=3>
		<tr>
		  <td><a class=strlink href=".$urlpath_s."status=-1".$sumtrurl.">&nbsp ALL &nbsp</a></td>
		  <td><a class=strlink href=".$urlpath_s."status=2".$sumtrurl.">Cancelled</a></td>
		  <td><a class=strlink href=".$urlpath_s."status=10".$sumtrurl.">Scrubbed</a></td>
		</tr>
		<tr>
		  <td>".$count." </td>
		  <td>".get_trans_counts($s2)." </td>
		  <td>".get_trans_counts($s.(($stf)?' AND ( `t`.`trans_status`=10 ) ':''))."</td>
		</tr>
		</table>
		</div>
		";
	  }else{
	
		 $post['TStatusWise']="
		  <div class=summary_div>
			<table align=center border=1 cellspacing=0 cellpadding=3>
			<tr>
			  <td><a class=strlink href=".$urlpath_s."status=-1".$sumtrurl.">&nbsp ALL &nbsp</a></td>
			   <td><a class=strlink href=".$urlpath_s."status=0".$sumtrurl.">Pending</a></td>
				".$s1_2."
			  <td><a class=strlink href=".$urlpath_s."status=2".$sumtrurl.">Cancelled</a></td>
			  <td><a class=strlink href=".$urlpath_s."status=3".$sumtrurl.">Refunded</a></td>
			  <td><a class=strlink href=".$urlpath_s."status=4".$sumtrurl.">Settled</a></td>
			  <td><a class=strlink href=".$urlpath_s."status=5".$sumtrurl.">Chargeback</a></td>
			  <td><a class=strlink href=".$urlpath_s."status=6".$sumtrurl.">Returned</a></td>
			  <td><a class=strlink href=".$urlpath_s."status=7".$sumtrurl.">R. Completed</a></td>
			  <td><a class=strlink href=".$urlpath_s."status=8".$sumtrurl.">Refund Requested</a></td>
			  ".$s9_10_2."
			  <td><a class=strlink href=".$urlpath_s."status=11".$sumtrurl.">CBK1</a></td>
			</tr>
			".$tco."
			</table>
			</div>
			";
		}
	}
	*/
	
	
}elseif($post['action']=='details'){
	$post['Transaction']=get_transaction_detail($post['gid'], $uid);
	list($wtype, $total, $email, $ecomments)=explode("#", trim($post['Transaction']['ecomments']));
	if($wtype&&$total&&$email&&$ecomments)$post['Transaction']['ecomments']=$ecomments;
}
$post['ViewMode']=$post['action'];


	
$post=select_info($uid, $post);

if($data['cqp']==4) { echo "<br/> select_info => "; exit; }

/*
if(isset($data['con_name'])&&$data['con_name']=='clk'&&!isset($_SESSION['acquirer_type'])){
	$get_type=db_rows(
			"SELECT GROUP_CONCAT(DISTINCT(`type`)) AS `type` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` WHERE `merID`={$uid} LIMIT 1",0
	);
	//print_r($get_type[0]['type']);
	$_SESSION['acquirer_type']=explode(',',$get_type[0]['type']);
}
*/
	
if(isset($data['NameOfFile'])){
	$pro=select_info($uid, $post);
	$post=$pro;
	$data['withdraw_gmfa']=0; // 0
	if((in_array('withdraw',$data['gmfa']))&&($pro['google_auth_access']==1||$pro['google_auth_access']==3)&&($pro['google_auth_code'])){
		$data['withdraw_gmfa']=1;
	} 
	if($data['con_name']=='clk'){
		$data['withdraw_gmfa']=1;
	}
}

if($data['cqp']>0) echo "Start Layout 1";

###############################################################################
if(!isset($data['DISPLAY_MULTI'])){
	display('user');
}
###############################################################################
?>