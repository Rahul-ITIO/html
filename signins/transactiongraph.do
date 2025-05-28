<?
###############################################################################
$data['PageName']='Transaction STATISTIC Graph';
$data['PageFile']='transactiongraph';

###############################################################################
include('../config.do');
set_time_limit(0);
//ini_set('memory_limit', '20000M');

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

if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'){
	$mta=1;
	$mts="`ad`";
}
else{
	$mta=0;
	$mts="`t`";
}

###############################################################################

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
if(isset($post['status'])){$cmn_action .= "&status=".$post['status'];}
if(isset($_GET['bid'])){$cmn_action .= "&bid=".$_GET['bid'];}
if(isset($_GET['StartPage'])){$cmn_action .= "&page=".$_GET['StartPage'];}
if(isset($_GET['order'])){$cmn_action .= "&order=".$_GET['order'];}
 if((isset($_GET['is_account']))&&($_GET['is_account']!='')){
	 	$cmn_action .= "&is_account=".$_GET['is_account'];
		}
	elseif((isset($post['is_account']))&&($post['is_account']!='')){
		$cmn_action .= "&is_account=".$post['is_account']; 
	}

 if((isset($post['trans_type']))&&($post['trans_type']!='')){ 		$cmn_action .= "&trans_type=".$post['trans_type'];}
if((isset($post['ccard_type']))&&($post['ccard_type'])){$cmn_action .="&ccard_type=".$post['ccard_type'];}
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
		}
	}
	if(isset($post['order'])&&!empty($post['order']))$orderby=" t.".$post['order']."";
	
	if((($post['status']<0)&&(!isset($post['bid']))&&(!isset($_GET['keyname']))) ){
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
			$where[]	= " ( {$que} ) ";
		}elseif($keyname==3){
				//$que=queryArrayf($searchkey,'t.bill_email','LIKE','OR',';');
				
				$search_key2=impf($searchkey,2);
				$que= "`t`.`bill_email` IN ({$search_key2})  ";
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}elseif($keyname==4){
				$que=queryArrayf($searchkey,'`t`.`amount`','LIKE','OR',';');
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}elseif($keyname==5){
				$que=queryArrayf(isMobileValid($searchkey),"{$mts}.`bill_phone`",'LIKE','OR',';');
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}elseif($keyname==6){
				$que=queryArrayf($searchkey,"{$mts}.`routing_aba`",'LIKE','OR',';');
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}elseif($keyname==7){
			$searchkey=encryptres($searchkey);
				$que=queryArrayf($searchkey,"{$mts}.`bankaccount`",'LIKE','OR',';');
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}elseif($keyname==8){
				//acquirer_response
				$que=queryArrayf($searchkey,"{$mts}.acquirer_ref",'LIKE','OR',';');
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}elseif($keyname==82){ //Reason
				$q_82=queryArrayf($searchkey,"{$mts}.`trans_response`",'LIKE','OR',';',0);
			$reportdate .= " AND ({$q_82}) ";
			$where[]	= " ( {$q_82} ) ";
		}elseif($keyname==83){ //M.OrderId
				$que=" ( t.reference IN ('{$searchkey}') )";
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}elseif($keyname==11){
				$que=queryArrayf($searchkey,"{$mts}.`bill_address`",'LIKE','OR',';',0);
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}elseif($keyname==12){
				$que=queryArrayf($searchkey,"{$mts}.`bill_city`",'LIKE','OR',';');
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}elseif($keyname==13){
				$que=queryArrayf($searchkey,"{$mts}.`bill_state`",'LIKE','OR',';');
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";				
		}elseif($keyname==14){
				$que=queryArrayf($searchkey,"{$mts}.`country`",'LIKE','OR',';');
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";	
		}elseif($keyname==15){
				$que=queryArrayf($searchkey,"{$mts}.bill_zip",'LIKE','OR',';');
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}elseif($keyname==16){
				$que=queryArrayf($searchkey,"{$mts}.`product_name`",'LIKE','OR',';');
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}elseif($keyname==17){
				$reportdate .= " AND ( lower({$mts}.`support_note`) LIKE '%".$searchkey."%' OR `t`.`transID` IN ({$searchkey})  )";
				$where[]	= " ( lower({$mts}.`support_note`) LIKE '%".$searchkey."%' OR `t`.`transID` IN ({$searchkey})  ) ";
		}elseif($keyname==18){
				$que=queryArrayf($searchkey,'`t`.`bill_ip`','LIKE','OR',';');
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}
		elseif($keyname==19){
				$que=" ( `t`.`remark_status` IN ({$searchkey}) )";
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}
		elseif($keyname==20){
				$que=queryArrayf($searchkey,'`t`.`payable_amt_of_txn`','LIKE','OR',';');
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}elseif($keyname==115){
				//$que=queryArrayf($searchkey,'t.terNO','LIKE','OR',';');
				$que=" ( `t`.`terNO` IN ({$searchkey}) )";
			$reportdate .= " AND ({$que}) ";
			$where[]	= " ( {$que} ) ";
		}
		elseif($keyname==223){
				$wmp=withdraw_max_prevf($post['bid'],$post['gid']);
			
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
		$where[]=" ( t.tdate between '".$post['dt1']."' AND '".$post['dt2']."' ) ";
		$reportdate.=" AND ( t.tdate between '".$post['dt1']."' AND '".$post['dt2']."' ) ";
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
		$reportdate.=" AND ( `merID` {$sort}IN ({$merchant_details})) ";
		$where[]	= " ( `merID` {$sort}IN ({$merchant_details})) ";
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

	if(isset($_REQUEST['date_1st']) && isset($_REQUEST['date_2nd']) && $_REQUEST['date_1st']&&$_REQUEST['date_2nd']){
		$date_1st=(date('Y-m-d H:i:s',strtotime($_REQUEST['date_1st'])));
		$date_2nd=(date('Y-m-d H:i:s',strtotime($_REQUEST['date_2nd'])));

		if(@$_REQUEST['time_period']==5){
			$sl_date=' `settelement_date` ';
		}else{
			$sl_date=' `tdate` ';
		}

			/*
		$reportdate.=" AND ( {$sl_date} {$sort}BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$date_2nd}', '%Y%m%d%H%i%s')) ) "; 
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

	if(isset($_REQUEST) && $_REQUEST)
	{
		$data['TransactionsList']=adm_trans_list(
			(isset($post['bid']) && $post['bid'])?$post['bid']:0,
			'both',
			$post['acquirer'],
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