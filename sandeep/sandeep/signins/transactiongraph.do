<?
###############################################################################
$data['PageName']='Transaction STATISTIC Graph';
$data['PageFile']='transactiongraph';

###############################################################################
include('../config.do');
$data['PageTitle'] = 'Transaction Statistic Graph - '.$data['domain_name'];
if(!isset($_SESSION['adm_login'])){
	$_SESSION['adminRedirectUrl']=$data['urlpath'];
	header("Location:{$data['Admins']}/login".$data['ex']);
	echo('ACCESS DENIED.'); exit;
}

if(isset($_SESSION['sub_admin_rolesname'])&&$_SESSION['sub_admin_rolesname']=="Associate"){
	echo "Oops... Something went worng. <a href='index.do'> Click here to GO to Home.</a>";
	exit;
}
###############################################################################

if(!isset($post['action']))$post['action']='select';
if(!isset($post['type']))$post['type']=-1;
if(!isset($post['status']))$post['status']=-1;
if(isset($_GET['dt1'])){$post['dt1']=date('Y-m-d',strtotime($_GET['dt1']));}else {$post['dt1']='';}
if(isset($_GET['dt2'])){$post['dt2']=date('Y-m-d',strtotime($_GET['dt2']));}else {$post['dt2']='';}
if(!isset($_GET['ccard_type'])){$post['ccard_type']=-1;}else {$post['ccard_type']=strtolower($_GET['ccard_type']);}
if(!isset($_GET['trname'])){$post['trname']='';}else {$post['trname']=$_GET['trname'];}
$ccard_type=$post['ccard_type'];
$trname=$post['trname'];

if($post['type']>=0){
	$data['PageName'].=" [".strtoupper($data['t'][$post['type']]['name1'])."]";
}

$data['is_check']=false;$data['is_card']=false;$post['is_account']="";
if(isset($_GET['type']) && $_GET['type']>0){
	$acc_type=stf($_GET['type']);
	if(strpos($data['t'][$acc_type]['name2'],'Check') !== false){
		$data['is_check']=true;$post['is_account']="check";
	}
	if(strpos($data['t'][$acc_type]['name2'],'Card') !== false){
		$data['is_card']=true;$post['is_account']="card";
	}
}
$cmn_action = "";
if(isset($post['type'])){$cmn_action .= "&type=".stf($post['type']);}
if(isset($post['status'])){$cmn_action .= "&status=".$post['status'];}
if(isset($_GET['bid'])){$cmn_action .= "&bid=".$_GET['bid'];}
if(isset($_GET['StartPage'])){$cmn_action .= "&page=".$_GET['StartPage'];}
if(isset($_GET['order'])){$cmn_action .= "&order=".$_GET['order'];}
if((isset($_GET['is_account']))&&($_GET['is_account']!='')){$cmn_action .= "&is_account=".$_GET['is_account'];}
elseif((isset($post['is_account']))&&($post['is_account']!='')){$cmn_action .= "&is_account=".$post['is_account'];}

if((isset($post['trname']))&&($post['trname']!='')) {$cmn_action .= "&trname=".$post['trname'];}
if((isset($post['ccard_type']))&&($post['ccard_type']!='')) {$cmn_action .= "&ccard_type=".$post['ccard_type'];}
if((isset($post['dt1']))&&($post['dt1']!='')){$cmn_action .= "&dt1=".$post['dt1'];}
if((isset($post['dt2']))&&($post['dt2']!='')){$cmn_action .= "&dt2=".$post['dt2'];}

$re_url="location:{$data['Admins']}/transactiongraph{$data['ex']}?action=select$cmn_action";
$data['cmn_action']= $cmn_action;
$payoutdays="16";
if((isset($_GET['is_account']))&&($post['is_account']=="card" || $_GET['is_account']=="card")){$payoutdays="14";}

###############################################################################
if($post['action']=='select'){
	if(isset($post['bid'])&&$post['bid']){
		$post['MemberInfo']=get_clients_info($post['bid']);

		$uid=$post['bid'];	

		if(isset($_GET['cl'])){
			include('../include/riskratio_code'.$data['iex']);
		}

		if(!@$post['MemberInfo'])unset($post['bid']);

		$MaxRowsByPage=100;
	}else{
		$MaxRowsByPage=50;
	}

	$where=array();
	$orderby=" `t`.`tdate`"; // amount

	$reportdate = ""; 
	$keyname=-1;if(isset($_GET['keyname'])){$keyname=$_GET['keyname'];}
	$searchkey="";if(isset($_GET['searchkey'])){$searchkey=trim($_GET['searchkey']);$searchkey=strtolower($searchkey);}

	if(isset($post['trans_status'])&&$post['trans_status']>=0)$where[]=" (t.trans_status={$post['trans_status']})";
	
	$type=1;
	if($post['type']=='35s'){
		$post['type']=-10;
		$reportdate .= " AND ( t.acquirer IN (35,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380) )";
		$where[]	= " ( t.acquirer IN (35,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380) ) ";
		$type=0;
	}
	elseif($post['type']=='38s'){
		$post['type']=-10;
		$reportdate .= " AND ( t.acquirer IN (38,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410) )";
		$where[]	= " ( t.acquirer IN (38,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410) ) ";
		$type=0;
	}
	elseif($post['type']=='34s'){
		$post['type']=-10;
		$reportdate .= " AND ( t.acquirer IN (34,341,342,343,344,345,346,347,348,349,350) )";
		$where[]	= " ( t.acquirer IN (34,341,342,343,344,345,346,347,348,349,350) ) ";
		$type=0;
	}
	elseif($post['type']=='37s'){
		$post['type']=-10;
		$reportdate .= " AND ( t.acquirer IN (37,371,372,373,374,375,376,377,378,379,380) )";
		$where[]	= " ( t.acquirer IN (37,371,372,373,374,375,376,377,378,379,380) ) ";
		$type=0;
	}
	elseif($post['type']=='latestApi'){
		$post['type']=-10;
		$reportdate .= " AND ( t.acquirer IN (34,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410) )";
		$where[]	= " ( t.acquirer IN (34,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410) ) ";
		$type=0;
	}
	elseif(($post['type']>=0)&&($type)){
		
		$where[]=" (t.acquirer={$post['type']}) ";
	}
	
	if(isset($post['bid']) && $post['bid']){
		$where[]=" (t.sender={$post['bid']} OR t.receiver={$post['bid']})";
		if(isset($_GET['ptdate'])&&$_GET['ptdate']){

			$ptdate=date('Y-m-d',strtotime($_GET['ptdate']));

			if(isset($_GET['pfdate'])&&$_GET['pfdate']){
				$ptdate=array();
				$ptdate['date_1st']=date('Y-m-d',strtotime($_GET['pfdate']));
				$ptdate['date_2nd']=date('Y-m-d',strtotime($_GET['ptdate']));
			}
			if(isset($_GET['cl'])){
				$post['ab']=account_balance($post['bid'],"",$ptdate);
				$post['mbt']=account_trans_balance_calc($post['bid'],$ptdate);
				$post['mbt_d']=account_trans_balance_calc_d($post['bid'],$ptdate);
			}
		}else{
			if(isset($_GET['cl'])){
				$post['ab']=account_balance($post['bid']);
				$post['mbt']=account_trans_balance_calc($post['bid']);
				$post['mbt_d']=account_trans_balance_calc_d($post['bid']);
			}
		}
	}
	if(isset($post['order'])&&!empty($post['order']))$orderby=" t.".$post['order']."";
	
	if((($post['status']<0)&&(!isset($post['bid']))&&(!isset($_GET['keyname']))) ){
		$fpdate = date("Y-m-d",strtotime("-10 day",strtotime(date("Y-m-d"))));
		$tpdate = date("Y-m-d",strtotime("+2 day",strtotime(date("Y-m-d"))));
		if(($post['type']>0)){$fpdate = date("Y-m-d",strtotime("-30 day",strtotime(date("Y-m-d"))));}
	} 

	if(isset($_GET['keyname'])&&($keyname>0)&&($searchkey)){
		if($keyname==1){
			if(strpos($searchkey,',')!==false){
				$reportdate .= " AND ( t.transaction_id IN (".$searchkey.") )";
				$where[]	= " ( t.transaction_id IN (".$searchkey.") ) ";
			}else{
				$reportdate .= " AND ( t.transaction_id IN (".$searchkey.") )";
				$where[]	= " ( t.transaction_id IN (".$searchkey.") ) ";
			}
		}elseif($keyname==2){
			$que=queryArrayf($searchkey,'t.names','LIKE','OR',';',0);
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}elseif($keyname==3){
			$que=queryArrayf($searchkey,'t.email_add','LIKE','OR',';');
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}elseif($keyname==4){
			$que=queryArrayf($searchkey,'t.amount','LIKE','OR',';');
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}elseif($keyname==5){
			$que=queryArrayf(isMobileValid($searchkey),'t.phone_no','LIKE','OR',';');
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}elseif($keyname==6){
			$que=queryArrayf($searchkey,'t.routing_aba','LIKE','OR',';');
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}elseif($keyname==7){
			$searchkey=encryptres($searchkey);
			$que=queryArrayf($searchkey,'t.bankaccount','LIKE','OR',';');
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}elseif($keyname==8){
			//txn_value
			$que=queryArrayf($searchkey,'t.txn_id','LIKE','OR',';');
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}elseif($keyname==82){ //Reason
			$q_82=queryArrayf($searchkey,'t.reason','LIKE','OR',';',0);
			$reportdate .= " AND ({$q_82}) ";
			$where[]	= " ( {$q_82} ) ";
		}elseif($keyname==83){ //M.OrderId
			$que=" ( t.mrid IN ('{$searchkey}') )";
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}elseif($keyname==11){
			$que=queryArrayf($searchkey,'t.address','LIKE','OR',';',0);
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}elseif($keyname==12){
			$que=queryArrayf($searchkey,'t.city','LIKE','OR',';');
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}elseif($keyname==13){
			$que=queryArrayf($searchkey,'t.state','LIKE','OR',';');
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";				
		}elseif($keyname==14){
			$que=queryArrayf($searchkey,'t.country','LIKE','OR',';');
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";	
		}elseif($keyname==15){
			$que=queryArrayf($searchkey,'t.zip','LIKE','OR',';');
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}elseif($keyname==16){
			$que=queryArrayf($searchkey,'t.product_name','LIKE','OR',';');
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}elseif($keyname==17){
			$reportdate .= " AND ( lower(t.reply_remark) LIKE '%".$searchkey."%' OR lower(t.transaction_id) LIKE '%".$searchkey."%' )";
			$where[]	= " ( lower(t.reply_remark) LIKE '%".$searchkey."%' OR lower(t.transaction_id) LIKE '%".$searchkey."%' ) ";
		}elseif($keyname==18){
			$que=queryArrayf($searchkey,'t.ip','LIKE','OR',';');
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}
		elseif($keyname==19){
			$que=" ( t.remark_status IN ({$searchkey}) )";
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}
		elseif($keyname==20){
			$que=queryArrayf($searchkey,'t.payable_amt_of_txn','LIKE','OR',';');
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}elseif($keyname==115){
			$que=" ( t.terNO IN ({$searchkey}) )";
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}
		elseif($keyname==223){
			$wmp=withdraw_max_prev($post['bid'],$post['gid']);
			
			$created_date_prev=date('Ymd',strtotime($wmp['tdate']));
			$created_date=date("Ymd",strtotime("+1 day",strtotime($wmp['c_tdate'])));
			
			$reportdate .= " AND (t.settelement_date BETWEEN (DATE_FORMAT('{$created_date_prev}', '%Y%m%d')) AND (DATE_FORMAT('{$created_date}', '%Y%m%d'))) AND ((t.trans_status NOT IN (0)) AND (t.trans_status NOT IN (9)) AND (t.trans_status NOT IN (10))) ";
			$where[]	= " (t.settelement_date BETWEEN (DATE_FORMAT('{$created_date_prev}', '%Y%m%d')) AND (DATE_FORMAT('{$created_date}', '%Y%m%d'))) AND ((t.trans_status NOT IN (0)) AND (t.trans_status NOT IN (9)) AND (t.trans_status NOT IN (10))) ";
		}
		elseif($keyname==224){
			$reportdate .= " AND (t.trans_status NOT IN (0)) AND (t.trans_status NOT IN (9)) AND (t.trans_status NOT IN (10)) AND (t.payable_amt_of_txn IS NULL)";
			$where[]	= " (t.trans_status NOT IN (0)) AND (t.trans_status NOT IN (9)) AND (t.trans_status NOT IN (10)) AND (t.payable_amt_of_txn IS NULL) ";
		}
	}

	if((!empty($_GET['pdate']))&&(isset($post['bid']))){
		$pdate	= date('Y-m-d',strtotime($_GET['pdate']));
		$fpdate = date("Y-m-d",strtotime("-$payoutdays day",strtotime($pdate))); //17 
		$tpdate = date("Y-m-d",strtotime("+7 day",strtotime($fpdate)));	// 8
		
		$reportdate = " AND ( t.tdate between '".$fpdate."' AND '".$tpdate."' ) ";
		$where[]= " ( t.tdate between '".$fpdate."' AND '".$tpdate."' ) ";
	}elseif(isset($_GET['ptdate'])&&$_GET['ptdate']){

		$date_2nd=date("Ymd",strtotime("+1 day",strtotime($_GET['ptdate'])));
		
		if(isset($_GET['pfdate'])&&$_GET['pfdate']){
			$date_1st=date("Ymd",strtotime("+0 day",strtotime($_GET['pfdate'])));
		}else{
			$date_1st=date("Ymd",strtotime("+0 day",strtotime($date_2nd)));
		}

		$reportdate .=" AND ( ((t.settelement_date BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d')) AND (DATE_FORMAT('{$date_2nd}', '%Y%m%d'))) AND ( (t.trans_status NOT IN (0)) AND (t.trans_status NOT IN (9)) AND (t.trans_status NOT IN (10)) )) OR ((t.settelement_date NOT BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d')) AND (DATE_FORMAT('{$date_2nd}', '%Y%m%d'))) AND ( (t.trans_status NOT IN (0)) AND (t.trans_status NOT IN (9)) AND (t.trans_status NOT IN (10)) ))) ";

		$where[]	= " ( ((t.settelement_date BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d')) AND (DATE_FORMAT('{$date_2nd}', '%Y%m%d'))) AND ( (t.trans_status NOT IN (0)) AND (t.trans_status NOT IN (9)) AND (t.trans_status NOT IN (10)) )) OR ((t.settelement_date NOT BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d')) AND (DATE_FORMAT('{$date_2nd}', '%Y%m%d'))) AND ( (t.trans_status NOT IN (0)) AND (t.trans_status NOT IN (9)) AND (t.trans_status NOT IN (10)) ))) ";
	} 

	if(isset($_GET['payment_type'])&& $_GET['payment_type']=="apm"){
		$reportdate .= " AND (( t.acquirer>33 ) AND ( t.acquirer<410 ))";
		$where[]	= " (( t.acquirer>33 ) AND ( t.acquirer<410 )) ";
	}elseif(isset($_GET['payment_type'])&& $_GET['payment_type']=="pf"){
		$reportdate .= " AND ( t.related_id IS NOT NULL AND t.related_id!='' )";
		$where[]	= " ( t.related_id IS NOT NULL AND t.related_id!='' ) ";
	}elseif(isset($_GET['payment_type'])&& $_GET['payment_type']){
		$searchkey=$_GET['payment_type'];
		$reportdate .= " AND ( t.trname='".$searchkey."' )";
		$where[]	= " ( t.trname='".$searchkey."' ) ";
	}
			
	($ccard_type<0?'':$where[]=" (t.mop='".$ccard_type."')");
	($ccard_type<0?'':$reportdate.=" AND (t.mop='".$ccard_type."')");
	
	if(($post['dt1']!='')&& ($post['dt1']!='1970-01-01')){
		$where[]=" ( t.tdate between '".$post['dt1']."' AND '".$post['dt2']."' ) ";
		$reportdate.=" AND ( t.tdate between '".$post['dt1']."' AND '".$post['dt2']."' ) ";
		}else {$post['dt1']=$post['dt2']='';}

	if ($trname=='cn'){$reportdate.=" AND (t.trname='cn')";$where[]=" ( t.trname='cn' )";}
	if ($trname=='ch'){$reportdate.=" AND (t.trname='ch')";$where[]=" ( t.trname='ch' )";}
	
	###########################################

	if(isset($_REQUEST['sortingType']) && $_REQUEST['sortingType']==2){$sort='NOT ';$sortImp='AND';}
	else{$sort='';$sortImp='OR';}

	if((isset($_SESSION['sub_admin_id']))&&($_SESSION['get_mid']!='M. All')){
		$get_mid=$_SESSION['get_mid'];
	}
		
	if(isset($_REQUEST['merchant_details']) && $_REQUEST['merchant_details']){
		$merchant_details=implodef($_REQUEST['merchant_details']);
		$reportdate.=" AND ( `merID` {$sort}IN ({$merchant_details})) ";
		$where[]	= " ( `merID` {$sort}IN ({$merchant_details})) ";
	}

	if(isset($_REQUEST['storeid']) && $_REQUEST['storeid']){
		$storeid=implodef($_REQUEST['storeid']);
		$reportdate.=" AND ( `terNO` {$sort}IN ({$storeid}) ) ";
		$where[]	= " ( `terNO` {$sort}IN ({$storeid}) ) ";
	}
	if(isset($_REQUEST['acquirer_type']) && $_REQUEST['acquirer_type']){
		$acquirer_type=implodef($_REQUEST['acquirer_type']);
		$reportdate.=" AND ( `acquirer` {$sort}IN ({$acquirer_type}) ) ";
		$where[]	= " ( `acquirer` {$sort}IN ({$acquirer_type}) ) ";
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
		$ccard_types=('"'.implodef($_REQUEST['ccard_types'],'","').'"');
		$reportdate.=" AND ( `mop` {$sort}IN ({$ccard_types}) ) ";
		$where[]	= " ( `mop` {$sort}IN ({$ccard_types}) ) ";
	}

	if(isset($_REQUEST['search_key']) && isset($_REQUEST['key_name']) && $_REQUEST['search_key']&&$_REQUEST['key_name']){
		$kn=stf($_REQUEST['key_name']);
		$search_key=(implodef($_REQUEST['search_key'],';'));

		$search_key2=$_REQUEST['search_key'];
		$search_key2=('"'.implodef($search_key2,'","').'"');
		
		if($kn=='payable_amt_of_txn'||$kn=='bill_amt'||$kn=='trans_amt'||$kn=='buy_mdr_amt'||$kn=='buy_txnfee_amt'||$kn=='rolling_amt'||$kn=='mdr_cb_amt'||$kn=='mdr_cbk1_amt'||$kn=='mdr_refundfee_amt'||$kn=='bank_processing_amount'||$kn=='available_balance'){
			$que3= $kn." {$sort}IN ({$search_key2}) ";
		}else{
			$que3=queryArrayf($search_key,$kn,$sort.'LIKE',$sortImp,';',0);
		}
		$reportdate .= " AND ({$que3}) ";
		$where[]	= " ({$que3}) ";
	}

	if(isset($_REQUEST['date_1st']) && isset($_REQUEST['date_2nd']) && $_REQUEST['date_1st']&&$_REQUEST['date_2nd']){
		$date_1st=(date('Y-m-d H:i:s',strtotime($_REQUEST['date_1st'])));
		$date_2nd=(date('Y-m-d H:i:s',strtotime($_REQUEST['date_2nd'])));

		if($_REQUEST['time_period']==5){
			$sl_date=' `settelement_date` ';
		}else{
			$sl_date=' `tdate` ';
		}

		$reportdate.=" AND ( {$sl_date} {$sort}BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$date_2nd}', '%Y%m%d%H%i%s')) ) "; 
		$where[]	= " ( {$sl_date} {$sort}BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$date_2nd}', '%Y%m%d%H%i%s')) ) ";
	}

	###########################################
	
	if(!isset($_GET['page'])) unset($_SESSION['total_record_result']);

	$data['MaxRowsByPage']=0;
	$_SESSION['MaxRowsByPage'] = $data['MaxRowsByPage'];

	$data['ct_query'] = ($where?" AND ".implode(' AND ', $where)." ":"");

	if(isset($_REQUEST) && $_REQUEST)
	{
		$data['TransactionsList']=adm_trans_list(
			(isset($post['bid']) && $post['bid'])?$post['bid']:0,
			'both',
			$post['type'],
			$post['status'],
			$post['StartPage'],
			$data['MaxRowsByPage'], 
			$reportdate." ORDER BY ".$orderby,
			"ASC"
		); 
		if(isset($data['tr_counts_q'])) $post['tr_counts_q']=$data['tr_counts_q'];
	}
}

$post['ViewMode']=$post['action'];

###############################################################################
display('admins');
###############################################################################
?>