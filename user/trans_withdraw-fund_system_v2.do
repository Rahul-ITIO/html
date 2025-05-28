<?
$data['FUND_STEP']=4;
//$data ['ThisPageUrl'] = 'trans_withdraw-fund';
$data['ThisPageUrl'] = 'trans_withdraw-fund_system_v2';
$data['WITHDRAW_INITIATE_TO_DATE_WISE']='Y';
//include('trans_withdraw.do'); 

###############################################################################
//Dev Tech : 24-05-10

###############################################################################
$data ['PageName'] = 'WITHDRAW FUNDS FROM MY ACCOUNT';
$data ['PageFile'] = 'withdraw';
// ##############################################################################

include ('../config.do');


//withdraw v2 function 
//$function_gw_wv2=$data['Path'].'/function_gw/function_gw_wv2'.$data['iex'];
//if(file_exists($function_gw_wv2)){include($function_gw_wv2);}	


$data['crypto']=0;
$data['withdraw_gmfa']=0; $authenticat_msg='';
##########################Check Permission#####################################
if(!isset($_SESSION['m_clients_role'])) $_SESSION['m_clients_role'] = '';
if(!isset($_SESSION['m_clients_type'])) $_SESSION['m_clients_type'] = '';
if(!clients_page_permission('12',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }
###############################################################################
$statement_withdraw_true=0; $post_session_check=1;
if(isset($data['statement_withdraw'])){
	$statement_withdraw_true=1;
}
$json=[];
function json_print3($json_array,$json=true){
	header("Content-Type: application/json", true);	
	echo $arrayEncoded2 = json_encode($json_array);
	exit;
}

if(!isset($data['PageTitle'])){
	$data ['PageTitle'] = 'Withdraw - ' . $data ['domain_name'];
}
if(!isset($data['ThisPageLabel'])){
	$data ['ThisPageLabel'] = 'Withdraw';
}
if(!isset($data['ThisTitle'])){
	$data ['ThisTitle'] = 'Withdraw Funds V2';
}
if(!isset($data['ThisPageUrl'])){
	$data ['ThisPageUrl'] = 'withdraw'.$data['ex'];
}elseif(isset($data['ThisPageUrl'])&&$data['ThisPageUrl']){
	$data ['ThisPageUrl'] = $data['ThisPageUrl'].$data['ex'];
}

if(!isset($data['type'])){
	$post['type']=2;
}

$qp=0;
if(isset($_GET['cqp'])&&$_GET['cqp']==5) $qp=$_GET['cqp'];

$data['prompt_msg']=''; $noFeeRequired=0;


// ##############################################################################
$is_admin=false; $is_nodal_post=0; $arrear_summ_mature_validation=1;
if( (isset($_SERVER['HTTP_REFERER'])) && ((strpos($_SERVER['HTTP_REFERER'],'include/csv_data_click')!==false) || (strpos($_SERVER['HTTP_REFERER'],'signins/merchant_settlement')!==false) ) ){
	
	$_SESSION['adm_login']=true;
	$adm_login=true;
	
	$auto_amt_clk=true;
	$_GET['admin']=1;
	
	$arrear_summ_mature_validation=0;
	
	//cmn
	//$_POST['amount']=3;
	
	
	
}
elseif( (isset($_SERVER['HTTP_REFERER'])) &&  ((strpos($_SERVER['HTTP_REFERER'],'nodal/cashfree')!==false) || (strpos($_SERVER['HTTP_REFERER'],'nodal/binance_status')!==false)  || (strpos($_SERVER['HTTP_REFERER'],'signins/merchant_settlement')!==false) ) && (isset($post['curl'])&&$post['curl']=='byCurl')  )
{  // high risk code for nodal 99
	$noFeeRequired=1;
	$auto_amt_clk=true;

	
	$is_admin=true;
	$data['withdraw_gmfa']=0;
	$data ['HideAllMenu'] = true;
	$uid = $post['bid'];
	$_SESSION['login'] = $uid;
	$_SESSION['uid'] = $uid;
	
	if(isset($_SESSION['uid_wv2'.$uid])){
		unset($_SESSION['uid_wv2'.$uid]);
	}
	
	$uid_session_true=0;$is_nodal_post=1;
	
	if(isset($post['ThisTitle'])&&$post['ThisTitle']){
		$data ['ThisTitle'] = $post['ThisTitle'];
		$json_values['STATUS_TYPE']=$post['ThisTitle'];
		
	}
	
	//cmn nodal query
	//if($data['con_name']=='clk') $post['requested_currency']='INR';
	
	$clk_arr['nodal_curl']=$_POST;
	

	//print_r($_POST); echo "curl=>".$post['curl'];
}


if((!isset($_SESSION ['adm_login'])&&!isset($_SESSION ['login']))&&($post_session_check)){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header ( "Location:{$data['Host']}/index".$data['ex'] );
	echo ('ACCESS DENIED.');
	exit ();
}



if (isset($_SESSION ['adm_login']) && isset ( $_GET['admin'] ) && $_GET['admin']) {
	$is_admin=true;
	$data['withdraw_gmfa']=0;
	$data ['HideAllMenu'] = true;
	$uid = $post['bid'];
	$_SESSION['login'] = $uid;
	$_SESSION['uid'] = $uid;

	if (isset ( $_GET ['fund_name'] )) {
		$data ['ThisTitle'] = $_GET ['fund_name'];
	}

	if (isset ( $_GET ['ruid'] )) {
		$info = select_client_table ( $_GET ['ruid'] );
		$post['receiver_user_id'] = $info ['username'];
	}
}

$data['is_admin']=$is_admin;

##############################################################################

$frozen_acquirer=0; 
if(isset($data['FROZEN_ACQUIRER'])&&$data['FROZEN_ACQUIRER']&&$data['is_admin']) {
	$frozen_acquirer=1;	$noFeeRequired=1;
	if(!isset($data['ThisTitle'])){
		$data ['ThisTitle'] = 'Frozen Balance ';
	}

	$json_values['frozen_acquirer']=$data['ThisTitle'];
}
$data['frozenAcquirer']=$frozen_acquirer;

##############################################################################


if (strpos ( $urlpath, "statement_withdraw" ) !== false) {
	$data ['PageName'] = 'STATEMENT WITHDRAW FUND';
	$data ['PageFile'] = 'withdraw';
	$data ['PageTitle'] = 'Statement Withdraw - ' . $data ['domain_name'];
	$data ['ThisPageLabel'] = 'Withdraw';
	$data ['ThisTitle'] = 'Statement Withdraw Funds';
	$data ['ThisPageUrl'] = 'statement_withdraw'.$data['ex'];
}
elseif ( (strpos ( $urlpath, "withdraw-fund" ) !== false) || (isset($data['FUND_STEP'])&&$data['FUND_STEP']==4) ) {
	$data ['PageFile'] = 'withdraw-fund';
	$data['crypto']=1;
	if((!isset($post['step'])||!$post['step'])&&$is_admin==false){
		$post['step']=2;
	}
	if(isset($post['steps'])){
		$post['step']++;
		if($post['step']==4){
			//$data['withdraw_gmfa']=1;
		}
	}elseif(isset($post['backButton'])){
		$post['step']--;
	}
}
elseif (strpos ( $urlpath, "send_fund" ) !== false) {
	$post['type']=4;
	$data ['PageName'] = 'SEND FUND';
	$data ['PageFile'] = 'withdraw';
	$data ['PageTitle'] = 'Send Fund - ' . $data ['domain_name'];
	$data ['ThisPageLabel'] = 'Send';
	$data ['ThisTitle'] = 'Send Funds';
	$data ['ThisPageUrl'] = 'send_fund'.$data['ex'];
}
elseif (strpos ( $urlpath, "withdraw_rolling" ) !== false) {
	$post['type']=3;
	$data ['PageName'] = 'WITHDRAW ROLLING';
		$data ['PageFile'] = 'withdraw';
	$data ['PageTitle'] = 'Withdraw Rolling - ' . $data ['domain_name'];
	$data ['ThisPageLabel'] = 'Rolling';
	$data ['ThisTitle'] = 'Withdraw Rolling';
		$data ['ThisPageUrl'] = 'withdraw_rolling'.$data['ex'];
}

	//$json_values['clk']=$clk_arr;json_print3($json_values);exit;
	
if($data ['PageFile'] == 'withdraw'){
	echo "ACCESS DENIED.."; exit;	
}

if(isset($data['type'])&&$data['type']){
	$post['type']=$data['type'];
}

/*
if (is_info_empty ( $uid )) {
	$get_q='';if(isset($_GET)){$get_q="?".http_build_query($_GET);}
	header("Location:{$data['Host']}/user/profile{$data['ex']}{$get_q}");
	echo ('ACCESS DENIED.');
	exit ();
}
*/
##############################################################################



##############################################################################

$uid_session_true=0;
if(!isset($_SESSION['start_date_date'])){
	$_SESSION['start_date_date']=$start_date_date=date('YmdHis');
}
$current_date_time=date('YmdHis', strtotime("-30 minutes"));
if($_SESSION['start_date_date']<$current_date_time){
	$_SESSION['start_date_date']=$start_date_date=date('YmdHis');
	$uid_session_true=0;
	if(isset($_SESSION['uid_wv2'.$uid])){
		unset($_SESSION['uid_wv2'.$uid]);
	}
}

if(!isset($_SESSION['uid_wv2'.$uid])){
	$uid_session_true=1;
}

##############################################################################

$cp=0;

if(isset($_GET['cp'])){
	$cp=1;
}


if(!isset($post['step'])||!$post['step'])$post['step']=1; 

$json_prnt["action"]=(isset($_POST['action'])?$_POST['action']:'');
$json_prnt["amount"]=(isset($_POST['amount'])?$_POST['amount']:'0');
$json_prnt["s_amount"]=(isset($_SESSION['uid_wv2'.$uid]['s_amount'])?$_SESSION['uid_wv2'.$uid]['s_amount']:'0');
$json["condition"]=$json_prnt; 

$convertamtAction=0;
if(isset($data['is_admin'])&&$data['is_admin']){
	$convertamtAction=1;
}
elseif(isset($_POST['amount'])&&isset($_SESSION['uid_wv2'.$uid]['s_amount'])&&$_SESSION['uid_wv2'.$uid]['s_amount']>=$_POST['amount']){
	$convertamtAction=1;
}

//if(($_POST['action']=='convertamt')){
if((isset($_POST['action'])&&$_POST['action']=="convertamt")&&($convertamtAction)&&(isset($_POST['amount']))&&(isset($_SESSION['uid_wv2'.$uid]['s_amount']))){
 	  
	$from_currency_2 = $_SESSION['uid_wv2'.$uid]['ab']['account_curr'];
	$to_currency_2 = $_POST['requested_currency'];
	$amount_get=$_POST['amount'];
	$withdraw_fee=$_POST['withdraw_fee'];
	if($noFeeRequired) {
		$withdraw_fee=0;
		$json["frozen_acquirer"]=$noFeeRequired;
	}
	$json["withdraw_fee"]=$withdraw_fee;
	
	$json["action"]=$_POST['action'];
	$json["from_currency_2"]=$from_currency_2;
	$json["to_currency_2"]=$to_currency_2;
	$json["amount_2"]=$amount_get;
	$json["s_summ_mature_amt"]=number_formatf_2($_SESSION['uid_wv2'.$uid]['s_summ_mature_amt']); 
	$json["summ_mature_amt"]=number_formatf_2($_SESSION['uid_wv2'.$uid]['ab']['summ_mature_amt']); 
	
	if($withdraw_fee>0){
		/*
		$json["withdraw_fee_on_amount_jsn"]=$withdraw_fee_on_amount=number_formatf_2($amount_get-$_SESSION['uid_wv2'.$uid]['s_cal_total_fee']); // Gross Settlement Amount - all fee for amount of withdraw fee
		
		if($data['cqp']==4) $json["withdraw_fee_on_amount_jsn"]=$withdraw_fee_on_amount=$amount_get;
		*/
		
		$json["withdrawfee_calc"]=number_formatf_2(($amount_get*$withdraw_fee)/100);
	}else{
		$json["withdrawfee_calc"]=0.00;
	}
	
	$json["amount_total_jsn"]=number_formatf_2($amount_get+$_SESSION['uid_wv2'.$uid]['s_cal_total_fee']+$json["withdrawfee_calc"]); // Gross Settlement Amount
	if($json["amount_total_jsn"]>$json["s_summ_mature_amt"]){
		$amount_get=number_formatf_2($amount_get-$json["withdrawfee_calc"]);
		$json["amount_differs"]=$amount_get;
		$json["amount_total_jsn"]=number_formatf_2($amount_get+$_SESSION['uid_wv2'.$uid]['s_cal_total_fee']+$json["withdrawfee_calc"]); // Gross Settlement Amount
	}
	
	
	
	if ($from_currency_2 == $to_currency_2) {
		$json["amount_jsn"]=number_format ( ( double ) $amount_get, '2', '.', '' ) . " " . $to_currency_2;
		$json["amount_jsn_eq"]=$json["amount_jsn"];
	} else {
		$currencyConverter_2=currencyConverter($from_currency_2,$to_currency_2,$amount_get,0,1);
		
		$json["currencyConverter"]=$currencyConverter_2;
		//print_r($currencyConverter_2);exit;
		
		$amt_2=$currencyConverter_2['converted_amount'];
		
		//json_print3($json);	exit;
		
		if($amt_2>0){
			$json["amount_jsn"]=number_format((double)$amt_2, '2', '.', '') . " " . $to_currency_2;
			$json["amount_jsn_2"]=$json["amount_jsn"];
		}else{
			unset($json["amount_jsn"]);
			$da['clk']['Error']='Currency Converter Missing. Please Contact to Support Team.';
			$json['Error']=$da['clk']['Error'];
			
		}
	} 
	
	
	
	json_print3($json);	exit;
}
 
//print_r($_SESSION['uid_wv2'.$uid]);
 

$post = select_info ( $uid, $post ); 


//Dev Tech : 23-09-29 Enable for settlement optimizer as paying setting

if(isset($data['settlement_optimizer_available'])&&$data['settlement_optimizer_available']=='Y'){
	if((isset($post['settlement_optimizer'])&&trim($post['settlement_optimizer'])&&$post['settlement_optimizer']=='manually')||($is_admin&&isset($post['settlement_optimizer'])&&trim($post['settlement_optimizer'])&&(strtolower($post['settlement_optimizer'])=='manually'||strtolower($post['settlement_optimizer'])=='custom'||strtolower($post['settlement_optimizer'])=='weekly'||strtolower($post['settlement_optimizer'])=='no_settlement'))){
		
	}else {
		if($is_admin) echo strtoupper(@$post['settlement_optimizer']).' : ';
		echo "Missing Settlement Optimizer";exit;
	}
}
//print_r($post);

if($cp){
	echo "<br/>payout_request=>".$post['payout_request'];
	echo "<hr/>json=>"; print_r($json);
}

//print_r($post);


/*
if((in_array('withdraw',$data['gmfa']))&&($post['google_auth_access']==2)&&($post['google_auth_code']=='')&&($is_admin==false)) {
	header("Location:{$data['USER_FOLDER']}/two-factor-authentication{$data['ex']}");
}
elseif((in_array('withdraw',$data['gmfa']))&&($post['google_auth_access']==1||$post['google_auth_access']==3)&&($post['google_auth_code'])&&($is_admin==false)) {
	$data['withdraw_gmfa']=1;
	$_SESSION['google_auth_code']=$google_auth_code=$post['google_auth_code'];
	$google_auth_access=$post['google_auth_access'];
	$authenticat_msg='and successfully authenticated';
}
*/
/*
echo "<br/>con_name=>".$data['con_name']='';
echo "<br/>noFeeRequired=>".$noFeeRequired;
*/
if(((strpos( $urlpath, "withdraw-fund" )!==false) || (strpos( $urlpath, "withdraw_rolling" )!==false) || ($noFeeRequired) )&&($data['con_name']!='clk')) {
	
	
	//if((in_array('withdraw',$data['gmfa']))&&($post['google_auth_access']==2)&&($post['google_auth_code']=='')&&($is_admin==false)) {
	if((in_array('withdraw',$data['gmfa']))&&($post['google_auth_code']=='')&&($is_admin==false)) {
		header("Location:{$data['USER_FOLDER']}/two-factor-authentication{$data['ex']}");exit;
	}
	
	
	
	if($post['step']>2){
		if((in_array('withdraw',$data['gmfa']))&&($post['google_auth_access']==1||$post['google_auth_access']==3)&&($post['google_auth_code'])&&($is_admin==false)) {
			$data['withdraw_gmfa']=1;
			$_SESSION['google_auth_code']=$google_auth_code=$post['google_auth_code'];
			$google_auth_access=$post['google_auth_access'];
			$authenticat_msg='and successfully authenticated';
		}
	}
	/*
	echo "<br/>withdraw_gmfa=>".$data['withdraw_gmfa'];
	echo "<br/>step=>".$post['step'];
	echo "<br/>con_name111=>".$data['con_name'];
	echo "<br/>is_admin=>".$is_admin;
	*/
}



//$data['withdraw_gmfa']=0;


/*
echo "<br/>withdraw_gmfa=>".$data['withdraw_gmfa'];
echo "<br/>google_auth_access=>".$post['google_auth_access'];
echo "<br/>google_auth_code=>".$post['google_auth_code'];
*/

if(isset($post['json_log_history'])){ unset($post['json_log_history']); }
if(isset($post['json_value'])){ unset($post['json_value']); }
if(isset($post['daily_password_count'])){ unset($post['daily_password_count']); }

//if(($post['withdraw_option']==2)&&(isset($data['statement_withdraw']))){ $statement_withdraw_true=1; }

//echo "<hr/>post=>";print_r($post);
$clk_arr['mid']=$uid;
$clk_arr['username']=$post['username'];
$clk_arr['company_name']=$post['company_name'];




$post['BanksInfo'] = select_banks($uid);
$post['WalletInfo'] = select_coin_wallet($uid);
if($post['WalletInfo']&&$post['BanksInfo']){
	$post['BanksInfo'] =array_merge($post['BanksInfo'],$post['WalletInfo']);
}elseif($post['WalletInfo']){
	$post['BanksInfo'] =$post['WalletInfo'];
}
$data['b_result_count']=count($post['BanksInfo']);
//echo $data['b_result_count'];
unset($post['BanksInfo']['json_log_history']);
$post['SBP']=banks_primary($uid);
$data['bank_id']=(isset($post['SBP']['id'])?$post['SBP']['id']:'');
$clk_arr['bank_id']=(isset($post['SBP']['id'])?$post['SBP']['id']:'');
$clk_arr['bname']=(isset($post['SBP']['bname'])?$post['SBP']['bname']:'');
$clk_arr['bswift']=(isset($post['SBP']['bswift'])?$post['SBP']['bswift']:'');
$clk_arr['baccount']=(isset($post['SBP']['baccount'])?$post['SBP']['baccount']:'');



//2:Coins [2 OR 3]
if(isset($data['DEFAULT_NODAL'])&&($data['DEFAULT_NODAL']==2 || $data['DEFAULT_NODAL']==3)){
	$post['CBP']=banks_primary($uid,'coin_wallet');
}

if($statement_withdraw_true){
	if(isset($post['ptdate'])&&$post['ptdate']){
		$payout_date_to=date('Y-m-d',strtotime($post['ptdate']));
	}	
}else{
	$payout_date_to='';
}


if(!isset($_SESSION['uid_wv2'.$uid]['trans_detail_array']))
{
	$_SESSION['uid_wv2'.$uid]['trans_detail_array']=$trans_detail_array = fetch_trans_balance_wv2($uid,@$post['type']);
}
$trans_detail_array=@$_SESSION['uid_wv2'.$uid]['trans_detail_array'];

if(!isset($_SESSION['uid_wv2'.$uid]['payout']))
{
	
	//$_SESSION['uid_wv2'.$uid]['payout']=$payout = payout_trans2($uid,$payout_date_to,$post['type']);
	
	//$_SESSION['uid_wv2'.$uid]['payout']=$payout = payout_trans_newf($uid,$post['type']);

	//$_SESSION['uid_wv2'.$uid]['trans_detail_array']=$trans_detail_array = fetch_trans_balance_wv2($uid);

	$_SESSION['uid_wv2'.$uid]['payout']=$payout = payout_trans_newf_wv2($uid,$post['type'],@$trans_detail_array);
	
}

$payout = $_SESSION['uid_wv2'.$uid]['payout'];

//cmn
//echo "<br/>payout=>";print_r($payout);


if($statement_withdraw_true){
	
	$post['max_ptdate']=$payout['max_ptdate'];
	
	if($cp){
		echo "<br/>max_ptdate==>".$post['max_ptdate'];
		echo "<br/>wd_min_tdate==>".$payout['wd']['wd_min_tdate'];
	}
	
	if(!isset($post['pfdate'])||!$post['pfdate']){
		$post['pfdate']=date('Y-m-d',strtotime($payout['wd']['wd_min_tdate']));
	}
	if(!isset($post['ptdate'])||!$post['ptdate']){
		$post['ptdate']=date('Y-m-d',strtotime($post['max_ptdate']));
	}
	
	
	
	if (!isset($payout['wd']['wd_min_tdate'])||!$payout['wd']['wd_min_tdate']) {
		$data ['Error'] = 'Payout Date From is missing';
		$data['submitFalse']='false';
		if ($json_action == true) {
			$da['Error']=$data ['Error'];
			json_print3($da);exit;
		}
	}elseif (!$post['pfdate']) {
		$data ['Error'] = 'Please Select to Payout Date From';
		$data['submitFalse']='false';
		if ($json_action == true) {
			$da['Error']=$data ['Error'];
			json_print3($da);exit;
		}
	}elseif (!$post['ptdate']) {
		$data ['Error'] = 'Please Select to Payout Date To';
		$data['submitFalse']='false';
		if ($json_action == true) {
			$da['Error']=$data ['Error'];
			json_print3($da);exit;
		}
	}
	elseif (date('Ymd',strtotime($post['pfdate']))>date('Ymd',strtotime($post['ptdate']))) {
		$data ['Error'] = 'Payout Date From can not greater than Payout Date To '.date('d-m-Y',strtotime($post['ptdate']));
		$data['submitFalse']='false';
		if ($json_action == true) {
			$da['Error']=$data ['Error'];
			json_print3($da);exit;
		}
	} 
	elseif (date('Ymd',strtotime($post['ptdate']))>date('Ymd',strtotime($post['max_ptdate']))) {
		$data ['Error'] = 'Payout Date To can not greater than '.date('d-m-Y',strtotime($post['max_ptdate']));
		$data['submitFalse']='false';
		if ($json_action == true) {
			$da['Error']=$data ['Error'];
			json_print3($da);exit;
		}
	}
	elseif (date('Ymd',strtotime($post['pfdate']))>date('Ymd',strtotime($post['max_ptdate']))) {
		$data ['Error'] = 'Payout Date From can not greater than '.date('d-m-Y',strtotime($post['max_ptdate']));
		$data['submitFalse']='false';
		if ($json_action == true) {
			$da['Error']=$data ['Error'];
			json_print3($da);exit;
		}
	} 
	elseif (date('Ymd',strtotime($post['pfdate']))<date('Ymd',strtotime($payout['wd']['wd_min_tdate']))) {
		$data ['Error'] = 'Payout Date From can not less than '.date('d-m-Y',strtotime($payout['wd']['wd_min_tdate']));
		$data['submitFalse']='false';
		if ($json_action == true) {
			$da['Error']=$data ['Error'];
			json_print3($da);exit;
		}
	} 
	
	 
	
	if((isset($post['pfdate'])&&$post['pfdate'])&&(isset($post['ptdate'])&&$post['ptdate'])){
		$date_from_to=array();
		$date_from_to['date_1st']=date('Y-m-d',strtotime($post['pfdate']));
		$date_from_to['date_2nd']=date('Y-m-d',strtotime($post['ptdate']));
	}
	
}else{
	$date_from_to='';
}


if($cp){
	echo "<hr/>payout=>";print_r($payout);
}


if($uid_session_true)
{
	if(isset($post['action'])&&$post['action'] != "convertamt"){
		//echo "1_ab";
		//include('../api/include/loading_icon.do');
	}
	 
	//$_SESSION['uid_wv2'.$uid]['ab']=$post['ab']=ms_trans_balance_calc_new($uid);
	
	//$trans_detail_array = fetch_trans_balance($uid);
	
	if(isset($_SESSION['uid_wv2'.$uid]['trans_detail_array']))$trans_detail_array = $_SESSION['uid_wv2'.$uid]['trans_detail_array'];
	else $trans_detail_array = fetch_trans_balance_wv2($uid,@$post['type']);
	

	//print_r($data['last_withdraw']);

	//$_SESSION['uid_wv2'.$uid]['ab']=$post['ab']=trans_balance_newac($uid,"","",$trans_detail_array);	
	$post['ab']=trans_balance_newac_wv2($uid,"","",$trans_detail_array,@$data['last_withdraw']);

	/*
	//Dev Tech : 24-09-11 Replus via last withdraw remaining balance
	if(isset($payout['wd']['last_withdraw_remaining_balance'])&&!empty($payout['wd']['last_withdraw_remaining_balance']))
	{

		if($cp) echo "<br/><hr/><br/>summ_mature_amt=>".$post['ab']['summ_mature_amt'];

		$post['ab']['summ_mature_amt']=number_formatf_2(@$post['ab']['summ_mature_amt'])+number_formatf_2(@$payout['wd']['last_withdraw_remaining_balance']);

		if($cp)
		{
			echo "<br/>last_withdraw_remaining_balance=>".@$payout['wd']['last_withdraw_remaining_balance'];
			echo "<br/>Now summ_mature_amt=>".$post['ab']['summ_mature_amt'];
			echo "<br/><hr/><br/>";
		}

	}
	*/
	
	$_SESSION['uid_wv2'.$uid]['ab']=$post['ab'];
	
	//echo "<br/>trans_detail_array=>"; print_r($trans_detail_array);
	
}


$post['ab']=@$_SESSION['uid_wv2'.$uid]['ab'];



if($cp)
{
	echo "<br/>last_withdraw_remaining_balance=>".@$payout['wd']['last_withdraw_remaining_balance'];
	echo "<br/>summ_mature_amt=>".$post['ab']['summ_mature_amt'];
	echo "<br/><hr/><br/>";
}

//$post['ab'] = account_balance ( $uid );
//echo "<hr/>ab=>";print_r($post['ab']);

$json_values['mature_fund'] = $post['ab']['summ_mature_amt'];
$json_values['account_balance'] = $post['ab']['summ_total_amt'];
$json_values['immature_fund'] = $post['ab']['summ_immature_amt'];
$json_values['total_withdraw_made'] = $post['ab']['summ_withdraw_amt'];

$json_values['mature_rolling_fund'] = $post['ab']['summ_mature_roll'];
$json_values['rolling_balance'] = $post['ab']['summ_total_roll'];
$json_values['immature_rolling_fund'] = $post['ab']['summ_immature_roll'];
$json_values['withdraw_rolling_fund'] = $post['ab']['summ_withdraw_roll'];


//echo "<hr/>json_values=>"; print_r($json_values);


$data ['emails'] = get_email_details ( $uid, 1, 1 );
$post['primary'] = @$data ['emails'] [0] ['email'];
//print_r($post['primary']);

// all fee not add noFeeRequired
if($noFeeRequired) {
	$post['settlement_fixed_fee']=0;
	$post['monthly_fee']=0;
	$post['virtual_fee']=0;
	$post['cal_total_fee']=0;
	$post['frozen_balance']=0;
}
	

// for test
// $post['amount']=($post['amount']/4);
// $post['ab']['summ_mature_amt']=($post['ab']['summ_mature_amt']/4);

//$post['last_available_balance'] = $post['available_balance'];
$post['last_available_balance'] = $json_values['account_balance'];
// $post['available_rolling']=$post['available_rolling'];

// echo "<hr/>uid=>".$uid;echo "<hr/>last_available_balance=>".$post['last_available_balance'];

// payout_trans


$post['virtual_fee'] = $payout['virtual_fee'];
$post['withdraw_requested'] = $payout['withdraw_requested'];
$post['previous_transID'] = $payout['previous_transID'];
//echo "<hr/>withdraw_requested=>".$post['withdraw_requested'];
$transaction_period = $payout['transaction_period'];
$post['monthly_fee_rate'] = $post['monthly_fee'];

// echo "<hr/>total_month_no=>".$payout['total_month_no']; echo "<hr/>monthly_fee=>".$post['monthly_fee'];


//Dev Tech : 24-08-13 Bug fix if previous withdraw then next month will be start the fee calc
if(isset($payout['previous_transID'])&&trim($payout['previous_transID'])&&$payout['previous_transID']>0&&isset($payout['total_month_no'])&&@$payout['total_month_no']>0)
{
	//echo "<hr/>total_month_no 1=>".$payout['total_month_no'];
	//$payout['total_month_no']=@$payout['total_month_no']-1;
	//echo "<hr/>total_month_no 2=>".$payout['total_month_no'];
}



$post['monthly_fee'] = $payout['total_month_no'] * $post['monthly_fee'];

if($cp){
	echo "<br/><h2><b>CALC TOTAL MONTHLY FEE=></b>".@$post['monthly_fee']."</h2><br/><br/>";
	echo "<br/><h2><b>total_month_no=></b>".@$payout['total_month_no']."</h2><br/>";
}


$post['summ_mature_amt']=number_format ( ( double ) $post['ab']['summ_mature_amt'], '2', '.', '' );



$post['cal_total_fee']=($post['settlement_fixed_fee'] + $post['monthly_fee'] + $post['virtual_fee'] );

$post['amount']= (($post['ab'] ['summ_mature_amt']) - $post['cal_total_fee']);
$post['pay_amount'] = (($post['ab'] ['summ_mature_amt']) - $post['cal_total_fee']);

$post['amount']= number_format ( ( double ) $post['amount'], '2', '.', '' );
$post['ab']['summ_mature_amt'] = number_format ( ( double ) $post['summ_mature_amt'], '2', '.', '' );



//print_r($post['ab']['summ_immature_roll']);
// rolling check 
$post['rolling_res']=($post['ab']['summ_immature_amt'])-($post['ab']['summ_immature_roll']);
$post['after_rolling_amt']=$post['amount']-$post['rolling_res'];
	
//echo "<hr/>is_admin=>".$is_admin;
if (($data['ThisPageLabel']=='Withdraw'||$data['ThisPageLabel']=='Send')) {
	
	
	if($post['ab']['summ_immature_amt']>=$post['ab']['summ_immature_roll']&&$post['rolling_res']){
		if($cp){
			echo "<br/>rolling reserve=>".$post['rolling_res'];
		}
		$post['rolling_reserve']=$post['rolling_res'];
	}else{
		
		$post['rolling_hold']=str_replace('-','',$post['rolling_res']);
		//$post['cal_total_fee']=$post['cal_total_fee']+$post['rolling_hold'];
		
		$json_values['amount_first'] = $post['amount'];
		
		if($post['frozen_balance']){
			
			//Dev Tech : 23-06-26 subtract the amount of rolling_hold  than re calculation as per frozen_balance
			//$post['amount']=$post['amount']+$post['rolling_hold'];
			
			$json_values['total_rolling_hold'] = $post['rolling_hold'];
			$json_values['frozen_balance'] = $post['frozen_balance'];
			$post['rolling_hold'] = (($post['rolling_hold']*$post['frozen_balance'])/100);
			
		}
		
		$json_values['rolling_hold'] = $post['rolling_hold'];
		
		
		$post['amount']=$post['amount']-$post['rolling_hold'];
		$post['pay_amount']=$post['amount'];
		
		$json_values['pay_amount'] = $post['amount'];
	
		$post['summ_mature_amt']= number_format ( ( double ) $post['amount']+$post['cal_total_fee'], '2', '.', '' );
		
		
		if($is_admin==true){
			$post['arrear']=$json_values['amount_first'];
			$post['arrear_summ_mature_amt']=$post['arrear']+$post['cal_total_fee'];
			
			$data['prompt_msg']=' Arrear Amount: '.$post['arrear'].', Arrear without any fee: '.$post['arrear_summ_mature_amt'].', Amount: '.$post['amount'];
			
			//echo "<br/>arrear=>".$post['arrear']; echo "<br/>arrear_without_any_fee=>".$post['arrear_summ_mature_amt'];
		}
		
			
		if($cp){
			echo "<br/>amount=>".$post['amount'];
			echo "<br/>cal_total_fee=>".$post['cal_total_fee'];
			echo "<br/>rolling_hold=>".$post['rolling_hold'];
			echo "<br/>summ_mature_amt after roll=>".$post['summ_mature_amt'];
			echo "<br/>last_withdraw_remaining_balance=>".@$payout['wd']['last_withdraw_remaining_balance'];
			echo "<br/>json_values=>";print_r($json_values);
		}

	}
	
	
	if($is_admin==true){
		if(!isset($post['arrear_summ_mature_amt'])){
			$post['arrear_summ_mature_amt']=$post['summ_mature_amt'];
		}
			
		if ((($post['amount']) <= (( double ) $post['settlement_min_amt'])) && ($data['ThisPageLabel']=='Withdraw') ) {
				
				$data['prompt_msg'].= " is  Withdraw Minimum: {$post['settlement_min_amt']}";
				
		}
	}
	
	if($cp){
		echo "<br/>amount=>".$post['amount'];
		echo "<br/>cal_total_fee=>".$post['cal_total_fee'];
		echo "<br/>rolling_hold=>".$post['rolling_hold'];
		echo "<br/>summ_mature_amt after roll=>".$post['summ_mature_amt'];
		echo "<br/>prompt_msg=>".$data['prompt_msg'];
		
		echo "<br/>arrear=>".$post['arrear']; echo "<br/>arrear_without_any_fee=>".$post['arrear_summ_mature_amt'];
	}
	
}




// echo "<hr/>amount=>".$post['amount'];echo "<hr/>summ_mature_amt=>".$post['ab']['summ_mature_amt'];

// save to json_value

// $json_values['wd_tran_id']=$payout['tran_id'];
// $json_values['wd_terNO']=$payout['terNO'];
// $json_values['wd_trans_type']=$payout['trans_type'];

if(isset($payout['last_withdraw_tdate'])&&trim($payout['last_withdraw_tdate'])) $json_values['last_withdraw_tdate'] = $payout['last_withdraw_tdate'];
if(isset($payout['last_withdraw_micro_current_date'])&&trim($payout['last_withdraw_micro_current_date'])) $json_values['last_withdraw_micro_current_date'] = $payout['last_withdraw_micro_current_date'];

$json_values['wd_transaction_period'] = $payout['transaction_period'];
$json_values['wd_date_from'] = $payout['date_from'];
$json_values['wd_date_to'] = $payout['date_to'];
$json_values['wd_total_month_no'] = $payout['total_month_no'];
$json_values['wd_monthly_fee'] = $post['monthly_fee_rate'];
	
$json_values['wd_account_curr'] = $post['ab']['account_curr'];


	
$json_values['wd_virtual_count'] = $payout['virtual_count'];
$json_values['wd_created_date'] = date ( 'Y-m-d 00:00:00' );
// $json_values=array_merge($json_values,$payout['wd']);

if(!isset($post['ab']['wd'])){
	$post['ab']['wd']=[];
}
$json_values = array_merge ( $json_values, $post['ab']['wd'], $payout['wd'] );
//echo "<hr/>json_values=>"; print_r($json_values);

/*
 * echo "<hr/>['ab']['wd'] =>"; print_r($post['ab']['wd']); echo "<hr/>payout['wd'] =>"; print_r($payout['wd']); $json_value=json_encode($json_values); echo "<hr/>json_value=>".$json_value;
 *
 */

// ##############################################################################

 
 
// echo "<hr/>amount=>".($post['amount']+$post['settlement_fixed_fee']+$post['monthly_fee']);
// echo "<hr/>settlement_min_amt=>".((double)$post['settlement_min_amt']);

$merID_pro = true;


if (isset($post['receiver_user_id'])&&$post['receiver_user_id']) {
	$userId = get_clients_id ( $post['receiver_user_id'] );
	$info = select_client_table ( $userId );
	if ($info) {

		$post['merID_id'] = $info ['id'];
		$post['merID_last_available_balance'] = $info ['available_balance'];

		$ps ['merID_id'] = $info ['id'];
		$ps ['merID_last_available_balance'] = $info ['available_balance'];
		$j_info = json_encode ( $ps );

		if ($info ['user_type'] == 2) {
			$inf_name = "Company: " . $info ['company_name'];
		} else {
			if(isset($info['fullname'])&&$info['fullname'])	//if fullname exist then use fullname
				$inf_name = "Name: " . $info['fullname'];
			else	//if fullname not exists then concat fname and lname
				$inf_name = "Name: " . $info ['fname'] . " " . $info ['lname'];
		}
		// $json["receiver_jsn"]=$inf_name."<br/>Email: ".$info['email'].$j_info;
		$json ["receiver_jsn"] = $inf_name . "<br/>Email: " . $info ['email'];
	} else {
		$json ["receiver_jsn"] = "Error";
		$json ["rError"] = "Error";
	}

	if (isset($post['action'])&&$post['action'] == "receiver_profile") {
		json_print3 ( $json );
		exit ();
	}
}






if (isset($data['ThisPageLabel'])&&$data['ThisPageLabel']=='Send') {
	
	$post['settlement_fixed_fee'] = 0;
	$post['monthly_fee'] = 0;
	$post['virtual_fee'] = 0;
	$post['cal_total_fee']=0;
	
	$post['summ_mature_amt']=number_format ( ( double ) $post['ab'] ['summ_mature_amt'], '2', '.', '' );
	if(isset($_POST['amount'])) $post['amount']= number_format((double)$_POST['amount'], '2', '.', '' );
	else $post['amount']= 0;

	$post['pay_amount'] = $post['amount'];
}
elseif ($data ['ThisPageLabel'] == 'Rolling') {

	
	$post['monthly_fee'] = 0;
	$post['virtual_fee'] = 0;
	$post['cal_total_fee']=$post['settlement_fixed_fee'];
	
	
	
	$post['summ_mature_amt']=number_format ( ( double )$post['ab'] ['summ_mature_roll'], '2', '.', '' );
	
	$summ_mature_roll=$post['ab'] ['summ_mature_roll']-$post['settlement_fixed_fee'];
	
	$post['amount']= number_format ( ( double ) $summ_mature_roll, '2', '.', '' );
	$post['pay_amount'] = number_format ( ( double ) $summ_mature_roll, '2', '.', '' );
}

// http://localhost/ztswallet/user/withdraw?bid=37&admin=1&a=100.00
// hard code amount
if ($is_admin) {
	if (isset ( $_GET ['a'] ) && $_GET ['a']) {
		// $post['amount']=$_GET['a'];$post['pay_amount']=$post['amount']; $post['ab']['summ_mature_amt']=$post['amount'];
	}
}

// $post['pay_amount']=$post['amount'];

// echo "<hr/>amount=>".$post['amount'];echo "<hr/>pay_amount=>".$post['pay_amount'];

// $post['amount']=100;$post['pay_amount']=100;$post['ab']['summ_mature_amt']=$post['amount'];$post['settlement_fixed_fee']=0;$post['monthly_fee']=0;$post['virtual_fee']=0;


$req_amt['amount']=$post['amount'];
$req_amt['settlement_fixed_fee']=$post['settlement_fixed_fee'];
$req_amt['monthly_fee']=$post['monthly_fee'];
$req_amt['virtual_fee']=$post['virtual_fee'];
$req_amt['cal_total_fee']=$post['cal_total_fee'];

if($cp){
  echo "<br/>req_amt=>";print_r($req_amt); echo "<br/>amount=>".($req_amt['amount'] + $req_amt['settlement_fixed_fee'] + $req_amt['monthly_fee'] + $req_amt['virtual_fee']);
  
	//echo "<br/>ab=>";print_r($post['ab']);
	echo "<br/>summ_immature_amt:  Immature Fund=>".$post['ab']['summ_immature_amt'];
	echo "<br/>summ_total_roll: - Rolling Balance=>".$post['ab']['summ_total_roll'];
	
	echo "<br/>post amount=>".$post['amount'];
	echo "<br/>rolling_res=>".$post['rolling_res'];

	echo "<br/>after_rolling_amt=>".$post['after_rolling_amt'];
		
		
}


if($is_nodal_post==1){
	$post['bank']=$clk_arr['bank_id'];
	
	if(!isset($post['requested_currency']))
	$post['requested_currency']=(isset($post['SBP']['required_currency'])?$post['SBP']['required_currency']:'INR');
	
	if(!isset($post['amount'])&&isset($json_values['pay_amount']))
	$post['amount']=$json_values['pay_amount'];
}
	
	
//clk --------------------------
if( $is_admin == true && isset($auto_amt_clk) && $auto_amt_clk== true && $noFeeRequired==0) {
	$amount=number_formatf2($json_values['mature_fund']);
	
	if($amount>1){
		$json_action=true;
		$post['send']=1;
	}else{
		
		$da['clk']['Error']='Cannot proceed because insufficient balance.';
		json_print3($da);exit;
		
	}
	
	$post['bank']=$post['SBP']['id'];
	
	$post['ab']['account_curr']="INR";
	$post['requested_currency']="INR";
	
	/*
	$post['pay_amount']=$amount; 
	$post['ab']['summ_mature_amt']=$amount;
	$_POST['amount']=$amount;
	$clk_arr['payout_amount']=$amount;
	
	$post['amount']=$amount;
	*/
	
	$post_clk_cal=true; 
	
	
}

//echo "<br/>cccccc auto_amt_clk=>".$auto_amt_clk;

// if nodal is on $auto_amt_clk
if(isset($auto_amt_clk)&&$auto_amt_clk==1){
	$post['bank']=$clk_arr['bank_id'];
	
	if(!isset($post['requested_currency']))
	$post['requested_currency']=(isset($post['SBP']['required_currency'])?$post['SBP']['required_currency']:'INR');
	
	if(!isset($_POST['amount'])&&isset($json_values['pay_amount'])) {
		$post['amount']=$_POST['amount']=$json_values['pay_amount'];
	}
	elseif(!isset($_POST['amount'])&&isset($post['amount'])) {
		$post['amount']=$_POST['amount']=$post['amount'];
	}
	
	//echo "<br/>cccccc amount=>".$_POST['amount'];

	
}

if((strpos($data['urlpath'],'user/withdraw')!==false)&&($data['con_name']=='clk')){
	$post_clk_cal=true; 
}

//Dev Tech : 24-05-15 not need below condition 
   
/*

if( isset($post_clk_cal) && $post_clk_cal== true ) 
{
	
	$json_values['gst_fee_applicable'] = 'yes';
	
	
	// $post['settlement_fixed_fee']="0"; $post['monthly_fee']="0"; $post['virtual_fee']="0"; $post['cal_total_fee']="0";
	
	
	$gst_fee_calc_start=1;
	
	$previous_wd_date_to=date("Ymd",strtotime("0 day",strtotime($json_values['wd_date_from'])));
	$today_wd_date_to=date('Ymd');
	if(isset($payout['previous_transID'])&&$payout['previous_transID']>0&&isset($json_values['wd_date_to'])&&$json_values['wd_date_from']&&$previous_wd_date_to==$today_wd_date_to){
		$gst_fee_calc_start=0;
	}


 if($gst_fee_calc_start){
	 
	//cmnt
	//$wd_created_date_prev=date('Y-m-d 00:00:00',strtotime($json_values['wd_date_from']));
	
	$wd_created_date_prev=date('Y-m-d 00:00:00',strtotime("+1 day",strtotime($json_values['wd_date_from'])));
	
	//cmnt
	//$wd_created_date=date("Y-m-d 23:59:59",strtotime("0 day",strtotime($json_values['wd_date_to'])));
	$wd_created_date=date("Y-m-d 23:59:59");
	$json_values['wd_created_date']=$wd_created_date;

	$qprint=0;
	
	if($cp){
		$qprint=1;
	}
	
	$payout_mature=db_rows(
		"SELECT SUM(`buy_mdr_amt`) AS `buy_mdr_amt`, SUM(`buy_txnfee_amt`) AS `buy_txnfee_amt`, SUM(`gst_amt`) AS `gst_fee`, COUNT(`id`) AS `ids` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
		" WHERE ( `merID` IN ({$uid}) )  AND (`trans_status` IN (1,4,7,8)) AND ( `trans_type` IN (11) )  AND  (`settelement_date` BETWEEN (DATE_FORMAT('{$wd_created_date_prev}', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$wd_created_date}', '%Y%m%d%H%i%s'))) ORDER BY `id` ASC LIMIT 1 ",$qprint
	); 
 }
 
	if($cp){
		echo "<hr/>payout_mature=><br/>";
		print_r(@$payout_mature);
		echo "<br/><hr/>";
	}
	
	$gst_fee=@$post['gst_fee'];
	
	if($noFeeRequired){
		
	}else{
		
		//if(!$gst_fee){ $da['clk']['Error']='Cannot proceed because GST FEE is not specified'; json_print3($da);exit; }
	
	
		if(isset($payout_mature)&&$payout_mature){
			$total_dis_rate=(double)$payout_mature[0]['buy_mdr_amt']; //Discount Rate 
			$buy_txnfee_amt=(double)$payout_mature[0]['buy_txnfee_amt']; //Transaction Fee
			
			
			
			$cal_total_fee=(double)($post['settlement_fixed_fee'] + $post['monthly_fee'] + $post['virtual_fee'] + $total_dis_rate + $buy_txnfee_amt );
			//$total_gst_fee=(($cal_total_fee*$gst_fee)/100);
			
			
			$total_gst_fee = number_formatf2($payout_mature[0]['gst_fee'],4);
			
			$post['total_gst_fee'] = $total_gst_fee;
			
			$json_values['total_charges_fee_id_count'] = $payout_mature[0]['ids'];
			$post['total_mdr_amt'] = number_formatf2($total_dis_rate,4);
			$json_values['total_mdr_amt'] = $post['total_mdr_amt'];
			
			//$post['total_mdr_txtfee_amt'] = number_formatf2($buy_txnfee_amt,4);
			$post['total_mdr_txtfee_amt'] = number_formatf2($cal_total_fee,4);
			$json_values['total_mdr_txtfee_amt'] = $post['total_mdr_txtfee_amt'];
			
				//$json_values['gst_fee'] = $gst_fee;
			$json_values['total_gst_fee'] = $post['total_gst_fee'];
			$post['cal_total_fee']=(double)($post['settlement_fixed_fee'] + $post['monthly_fee'] + $post['virtual_fee']); //+$post['total_gst_fee']
			
			$amount=((number_formatf2($json_values['mature_fund'],4)) - $post['cal_total_fee']);
			
			$clk_arr['total_mdr_amt']=$post['total_mdr_amt']; //Discount Rate 
			$clk_arr['total_mdr_txtfee_amt']=$post['total_mdr_txtfee_amt']; //Transaction Fee
			$clk_arr['settlement_fixed_fee']=$post['settlement_fixed_fee']; //Settlement Wire Fee
			$clk_arr['monthly_fee']=$post['monthly_fee']; //Monthly Maintance Fee
			$clk_arr['virtual_fee']=$post['virtual_fee']; //Virtual Fee
				//$clk_arr['gst_fee']=$post['gst_fee'];
			$clk_arr['total_gst_fee']=$post['total_gst_fee'];
			
		} 
		
		if($amount){
			$post['pay_amount']=$amount; 
			$post['summ_mature_amt']= number_format ( ( double ) $amount+$post['cal_total_fee'], '2', '.', '' );
			$clk_arr['payout_amount']=$amount;
			$post['amount']=$amount;
			if( isset($auto_amt_clk) && $auto_amt_clk== true) {
				$_POST['amount']=$amount;
				$post['ab']['summ_mature_amt']=$amount;
			}
		}
		
	}
	
	if($cp){
		echo "<hr/>clk_arr=><br/>";
		print_r($clk_arr);
		echo "<br/><hr/>";
	}
  
	//cmn
	//echo "<br/>summ_mature_amt=>".$post['summ_mature_amt'];
	//echo "<br/>cal_total_fee=>".$post['cal_total_fee'];
	//echo "<br/>amount=>".$post['amount'];
	

	
}

*/

//if(isset($amount)) $clk_arr['payout_amount']=$amount;




// all fee not add 

	$json_values['wd_wire_fee'] = $post['settlement_fixed_fee'];
	$json_values['wd_total_monthly_fee'] = $post['monthly_fee'];
	$json_values['wd_virtual_fee'] = $post['virtual_fee'];
	$json_values['cal_total_fee'] = $post['cal_total_fee'];
	
	if($cp){
		echo "<br/>json_values all=>";
		print_r($json_values);
		
		echo "<br/><br/><br/>amount=>".$post['amount'];
		echo "<br/><br/><br/>is pay_amount=>".$json_values['pay_amount'];
	}

if(!isset($_POST['amount'])&&!isset($_SESSION['uid_wv2'.$uid]['s_amount'])){
	$_SESSION['uid_wv2'.$uid]['s_amount']=$post['amount'];
} 
$_SESSION['uid_wv2'.$uid]['s_cal_total_fee']=$post['cal_total_fee'];
$_SESSION['uid_wv2'.$uid]['s_summ_mature_amt']=$post['summ_mature_amt'];

if($is_nodal_post){
	/*
	$post['ab']['summ_mature_amt']=4.00;
	$post['ab']['summ_mature']=4.00;
	$post['ab']['summ_total']=4.00;
	$json_action=true;
	*/
}

//echo $data ['ThisPageLabel']; // 1066

if((isset($post['send'])&&$post['send'])||(isset($post['action'])&&$post['action']=="convertamt")){
	$json_action = false;

	if (isset($post['action'])&&$post['action'] == "convertamt") {
		$json_action = true;
	}
	
	$json["action"]=(isset($post['action'])?$post['action']:'');
			
	// $post['LastWithdraw']=get_transactions($uid, 'outgoing', 2, 1, 0, 1); $post['LastWithdraw']=$post['LastWithdraw'][0];

	if ($post['step'] == 1||$post['step'] == 4) {

		if (isset ( $_GET['admin'] ) && isset ( $_GET ['a'] ) && $_GET ['a']) {
			// $amount=$_GET['a'];$post['amount']=$amount; $post['pay_amount']=$amount; $post['ab']['summ_mature_amt']=$amount;
		}
		$amount_get=number_formatf_2(@$_POST['amount']);
		$json_values["withdraw_on_amount"]=$amount_get;
		
		$clk_arr['bank']=$post['bank'];
		
		if(isset($post['bank'])&&$post['bank']&&($post['bank']!='crypto')){
			$json["bank_id"]=$post['bank'];
			$json["cal_total_fee1"]=$post['cal_total_fee'];
			
			$bank_gets = select_banks($uid, $post['bank'], 1);
			$bank_get = $bank_gets[0];
			//$json['bank_get']=$bank_get;
			
			$withdraw_fee=number_formatf_2($bank_get['withdrawFee']);
			if($noFeeRequired) {
				$withdraw_fee=0;
			}
			$json["withdraw_fee"]=$withdraw_fee;
			
			$json_values["withdraw_fee"]=$withdraw_fee."%";
			
			
			if($withdraw_fee>0){
						
				/*
				
				$json["withdraw_fee_on_amount_jsn"]=$withdraw_fee_on_amount=number_formatf_2($amount_get-$_SESSION['uid_wv2'.$uid]['s_cal_total_fee']); // Gross Settlement Amount - all fee for amount of withdraw fee
		
				if($data['cqp']==4) $json["withdraw_fee_on_amount_jsn"]=$withdraw_fee_on_amount=$amount_get;
				
				*/
				
				$json["withdrawfee_calc"]=number_formatf_2(($amount_get*$withdraw_fee)/100);
				$json_values['withdrawfee_calc']=$json["withdrawfee_calc"];
			}else{
				$json["withdrawfee_calc"]=0.00;
			}
			
			$json["amount_total_jsn"]=number_formatf_2($amount_get+$_SESSION['uid_wv2'.$uid]['s_cal_total_fee']+$json["withdrawfee_calc"]); // Gross Settlement Amount
			$json["s_summ_mature_amt"]=number_formatf_2($_SESSION['uid_wv2'.$uid]['s_summ_mature_amt']); 
			if($json["amount_total_jsn"]>$json["s_summ_mature_amt"]){
				$amount_get=number_formatf_2($amount_get-$json["withdrawfee_calc"]);
				$_POST['amount']=$amount_get;
				$json["amount_differs"]=$amount_get;
				$json["amount_total_jsn"]=number_formatf_2($amount_get+$_SESSION['uid_wv2'.$uid]['s_cal_total_fee']+$json["withdrawfee_calc"]); // Gross Settlement Amount
			}
			
			$post['cal_total_fee']=$post['cal_total_fee']+$json["withdrawfee_calc"];
			
			unset($bank_get['json_log_history']);
			
			if(isset($bank_get['baccount'])&&$bank_get['baccount'])
				$bank_get['baccount']=encrypts_string($bank_get['baccount']);
			if(isset($bank_get['coins_address'])&&$bank_get['coins_address'])
				$bank_get['coins_address']=encrypts_string($bank_get['coins_address']);

			$post['bank_get']=jsonencode(array_val_f($bank_get));
			$clk_arr['bank_id']=@$json["bank_id"];
			//$clk_arr['bank_get']=$post['bank_get'];
		}
		if(!isset($json["amount_total_jsn"])){
			$json["amount_total_jsn"]=number_formatf_2($amount_get+$post['cal_total_fee']); // Gross Settlement Amount
		}
		$json_values['cal_total_fee'] = $post['cal_total_fee'];
		
		//json_print3($json);exit;
		
		$amount = ((double)@$_POST['amount'] + $post['cal_total_fee']);
		$amount = number_format ( (double)$amount, '2', '.', '' );
		
		//$post['pay_amount']=$_POST['amount'];
		
		
		$post['amount']=@$_POST['amount'];
		$post['pay_amount']=@$_POST['amount'];
		
		
		

		if (isset ( $_GET['admin'] ) && isset ( $_GET ['a'] ) && $_GET ['a']) {
			$post['summ_mature_amt']= $amount;
		}

		if (!isset($_POST['amount'])) {
			$data ['Error'] = 'Please enter valid amount for transferring.';
			if ($json_action == true) {
				//json_print3 ( $data ['Error'] );
				$da['Error']=$data ['Error'];
				json_print3($da);exit;
			}
		} elseif ((!isset($post['receiver_user_id'])) && ($json_action == false) && ($data ['ThisPageLabel'] == 'Send')) {
			$data ['Error'] = 'Please Enter Receiver User ID';
		} elseif ((isset($json ["receiver_jsn"])&&$json ["receiver_jsn"] == "Error") && ($json_action == false) && ($data ['ThisPageLabel'] == 'Send')) {
			$data ['Error'] = 'Please Enter Currect User Id in Receiver User ID';
		} elseif ((($amount) <= (( double ) $post['settlement_min_amt'])) && ($data['ThisPageLabel']=='Withdraw') && ($is_admin==false) ) {
			
				$data ['Error'] = "We can not process your request of ".$data ['ThisTitle']." as your mature fund-(Wire fee+Monthly fee+Virtual Terminal Fee) should be more than Withdrawal Minimum : {$post['settlement_min_amt']}.";
				if ($json_action == true) {
					//json_print3 ( $data ['Error'] );
					$da['Error']=$data ['Error'];
					json_print3($da);exit;
				}
			
		} elseif (($amount > $post['summ_mature_amt']) && ($data ['ThisPageLabel'] == 'Withdraw'||$data ['ThisPageLabel'] == 'Rolling') && ($is_admin==false) ) {
			$data ['Error'] = "The _maximum/{$data ['ThisTitle']} amount + wire fee + virtual terminal fee of funds you may {$data ['ThisTitle']} is {$post['ab']['account_curr_sys']}" . ($amount) . " in your Mature Fund " . $post['ab'] ['account_curr_sys'] . $post['summ_mature_amt'];
			if ($json_action == true) {
				//json_print3 ( $data ['Error'] );
				$da['Error']=$data ['Error'];
				json_print3($da);exit;
			}
		}elseif ((prnsum2($amount) > prnsum2(@$post['arrear_summ_mature_amt'])) && ($data ['ThisPageLabel'] == 'Withdraw') && ($is_admin==true) && ($noFeeRequired==0) && ($arrear_summ_mature_validation==1) ) {
			$data ['Error'] = "_The maximum/{$data ['ThisTitle']} amount + wire fee + virtual terminal fee of funds you may {$data ['ThisTitle']} is {$post['ab']['account_curr_sys']}" . ($amount) . " in your Mature Fund " . $post['ab'] ['account_curr_sys'] . prnsum2($post['arrear_summ_mature_amt']);
			if ($json_action == true) {
				json_print3 ( $data ['Error'] );
			}
		} elseif (((!select_banks($uid, @$post['bank'], 1)) && ($json_action == false) && ($data ['ThisPageLabel'] == 'Withdraw'||$data ['ThisPageLabel'] == 'Rolling')&&($post['bank']!='crypto')&&($is_nodal_post==0))) {
			//echo "<br/>BankType=>".$_POST['BankType']; // CryptoCurrency
			$data ['Error'] = 'Please select Bank.';
			if ($json_action == true) {
				json_print3 ( $data ['Error'] );
			}
		} elseif (isset($post['bank'])&&(select_banks($uid, $post['bank'], 1, 1)!=2) && ($json_action == false) && ($data ['ThisPageLabel'] == 'Withdraw'||$data ['ThisPageLabel'] == 'Rolling')&&($post['bank']!='crypto') && ($noFeeRequired==0) ) {
			$data ['Error'] = 'We cannot process '.$data ['ThisTitle'].' for:<div><b> "' .$post['display_bank_name']. '"</b> </div>Kindly contact to support for further information';
		} else {
			
			
			$from_Currency = $post['ab']['account_curr'];
			$to_Currency = $post['requested_currency'];
			// $amount_convert=$post['amount']-$post['settlement_fixed_fee'];

			// $post['pay_amount']=$post['amount'];

			$json_values['wd_pay_amount_default_currency'] = $post['pay_amount'];
			
			

			if ($from_Currency == $to_Currency) {
				$json ["amount_jsn"] = number_format ( ( double ) $post['pay_amount'], '2', '.', '' ) . " " . $to_Currency;
				$trans_amt = number_format ( ( double ) $post['pay_amount'], '2', '.', '' );
			} else {
				$currencyConverter = currencyConverter ( $from_Currency, $to_Currency, $post['pay_amount'], 0 , 1);
				
				//print_r($currencyConverter);exit;
				
				$amt=$currencyConverter['converted_amount'];
				
				if($amt>0){
					$json ["amount_jsn"] = number_format ( ( double ) $amt, '2', '.', '' ) . " " . $to_Currency;
					$trans_amt = number_format ( ( double ) $amt, '2', '.', '' );
					
					$json_values = array_merge ( $json_values, $currencyConverter );
				}else{
					unset($json["amount_jsn"]);
					$da['clk']['Error']='Currency Converter Missing. Please Contact to Support Team.';
					$json['Error']=$da['clk']['Error'];
					if($json_action == true){
						json_print3($json);exit;
					}
				}
			}
		
			$json ["amount"] = $post['amount'];

			$json ["pay_amount"] = number_format ( ( double ) $post['pay_amount'], '2', '.', '' );
			$json ["from_Currency"] = $from_Currency;
			$json ["requested_currency"] = $to_Currency;
			
			$json_values['wd_payable_amt_of_txn_from'] = number_format ( ( double ) $post['pay_amount'], '2', '.', '' );
			$json_values['wd_payable_amt_of_txn_to']=$clk_arr['settlementAmt']=$trans_amt;
			
			$clk_arr['settlementFromCurrency']=$from_Currency;
			$clk_arr['settlementCurrency']=$to_Currency;
			  

			if(($json_action == true) && (!isset($auto_amt_clk))) {
				json_print3 ( $json );
			}
			
			if($cp){
				echo "<hr/>amount=>".$amount;
				echo "<hr/>summ_mature_amt=>".$post['summ_mature_amt'];
				echo "<hr/>amount=>".$_POST['amount'];
				echo "<hr/>_POST pay_amount=>".$_POST['pay_amount'];
				echo "<hr/>post pay_amount=>".$post['pay_amount'];
				echo "<hr/>json=>"; print_r($json);
				
				//exit;
			}

			$json_values['wd_requested_bank_currency'] = $to_Currency;
			
			if($payout['previous_transID']){
				$json_values['previous_wd_transID'] = $payout['previous_transID'];
			}
			$json_values['remaining_balance'] = ( double )$post['ab']['summ_mature_amt'] - ( double )$amount;
			

			$wire_fee_amt = number_format ( ( double ) ($post['cal_total_fee']), '2', '.', '' );
			$amount_double = number_format ( ( double ) $amount, '2', '.', '' );

			if(isset($post['fullname'])&&$post['fullname'])	//if fullname exist then use fullname
				$fullname = $post['fullname'];
			

			$email = $post['primary'];

			if(!isset($post['bank_get'])) $post['bank_get']='';
			$acquirer_response = $post['bank_get'];
			
			$product_name = "";

			//$rmk_date = date ( 'd-m-Y H:i:s A' ); 
			$rmk_date=date('d-m-Y h:i:s A');
			
			unset($clk_arr['baccount']);
			
			
			if($is_admin==true){
				if(isset($_SESSION['sub_username'])&&$_SESSION['sub_username']){
					$resource_name = $_SESSION ['sub_username'];
				}else{
					$resource_name = 'Admin';
				}
			}else{
				$resource_name = $_SESSION ['m_username'];
			}

			$support_note = $data['ThisPageLabel']." Transaction created ".$authenticat_msg." by " . $resource_name . " ( From IP Address: <font class=ip_view>" . $data ['Addr'] . "</font> )";
			$remark_upd = "<div class=rmk_row><div class=rmk_date>" . $rmk_date . "</div><div class=rmk_msg> " . $support_note . " </div></div>";

			$source_url = $_SERVER ['HTTP_REFERER'];
			$mop = "";
			$webhook_url = "";
			$return_url = "";
			$failed_url = "";
			$country = $post['country'];


			$current_ip = $data ['Addr'];

			$reference = "";
			$settelement_delay = "";
			$settelement_date = "";
			$rolling_delay = "";
			$rolling_date = "";
			// $trans_currency=$post['ab']['account_curr'];
			$trans_currency = $post['ab']['account_curr'];
			// $bill_currency=$post['ab']['account_curr'];
			$bill_currency = $from_Currency;
			$bank_processing_curr = $to_Currency;
			$buy_txnfee_amt = $wire_fee_amt;

			$merID_last_available_balance = "";
			
			
			
			
			
			//clk 
			if( $is_admin == true && isset($auto_amt_clk) && $auto_amt_clk== true) {
				$json_values['clk']=$clk_arr;
				
				//cmn
				//$json_values_clk=array_merge($json_values); json_print3 ( $json_values_clk );exit;
			}
			
				
			
			

			if ($data ['ThisPageLabel'] == 'Send') {

				$merID_last_available_balance = $post['merID_last_available_balance'] + $amount_double;

				db_query( "UPDATE `{$data['DbPrefix']}clientid_table`" . " SET `available_balance`='" . $merID_last_available_balance . "' " . " WHERE `id`='".$post['merID_id']."'", 0 );

				$json_values['merID_last_available_balance'] = $merID_last_available_balance;
			}

			$json_value = jsonencode ( $json_values );

			$system_note = "<div class=rmk_row><div class=rmk_date>" . $rmk_date . "</div><div class=rmk_msg> " . $post['bank_get'] . " </div></div>";
			
			if($noFeeRequired) {
				$system_note .= "<div class=rmk_row><div class=rmk_date>" . $rmk_date . "</div><div class=rmk_msg> {$data['ThisTitle']}</div></div>";
			}

			$payable_amt_of_txn = $trans_amt;
			
			
			$rolling_amt='0.00';
			$available_rolling_tr='0.00';
			 
			$available_rolling="";
			
			if(isset($post['txt_id']) && !empty($post['txt_id'])) 
				$acquirer_ref =$post['txt_id'];
			else 
				$acquirer_ref = "";
			
			$reference='NA';

			if ($data ['ThisPageLabel'] == 'Send') {
				$sender = $uid;
				$merID = $reference = $post['merID_id'];
				$type = 4;
				$status = 15;
				$mop = "AF";
				// $amount=$amount_double;
				$trans_type = 19;
			}elseif ($data ['ThisPageLabel'] == 'Rolling') {
				$sender = $uid;
				$merID = - 3;
				$type = 3; $status = 14;
				//$type = 2; $status = 13;

				$trans_type = 16;
				$mop = "WR";
				
			
				//$last_available_rolling = $post['available_rolling'] - $amount_double;
				
				$last_available_rolling = $json_values['rolling_balance']  - $amount_double;
				
				

				$rolling_amt="-" . $amount_double;
				$available_rolling_tr=$last_available_rolling;
				
			}  else {
				// $sender=-2;$merID=$uid;
				$sender = $uid;
				$merID = - 2;
				$type = 2;
				$status = 13;

				$trans_type = 15;
				$mop = "WD";
			}
			
			$transactioncode = $type . date ( "ymdHis" );

			//$transactioncode = unique_id_tr ( $transactioncode );

			$amount = "-" . $amount_double;

			$last_available_balance = $post['last_available_balance'] - $amount_double;

			$last_available_balance = number_formatf_2($last_available_balance);

			if($cp){
			  echo "<hr/>amount=>".$amount;
			  echo "<hr/>amount_double=>".$amount_double;
			  echo "<hr/>trans_amt=>".$trans_amt;
			  echo "<hr/>last_available_balance=>".$last_available_balance;
			  exit;
			}
			
			
			
			
			if ($data ['ThisPageLabel'] == 'Rolling') {
				$last_available_balance = $last_available_rolling;
				
				db_query( "UPDATE `{$data['DbPrefix']}payin_setting`" .
					" SET `available_rolling`='{$last_available_rolling}' " .
					" WHERE `clientid`='{$uid}'", 0 );
			}
			else{
				db_query( "UPDATE `{$data['DbPrefix']}payin_setting`" . 
					" SET `available_balance`='{$last_available_balance}' " . 
					" WHERE `clientid`='{$uid}'", 0 );
			}
			 

			
			
		$trans_response=$data['ThisTitle'];
		
		$upa=@$post['BankType'];

			$query_own1 = $query_own2 = "";
			
			
			if($sender>0)
			{
				$merID=$sender;
			}
			
		  
			
			
			$channel_type=8; //  wd Withdraw
			if($type==3){
				$channel_type=9; // wr Withdraw Rolling
			}
		
			
			if(empty($acquirer_response)) $acquirer_response='null';
			
			
			$bill_amt=$amount;
			$trans_status=$status;
			$acquirer=$type;

            if(isset($bank_get)&&isset($bank_get['settlement_webhook_url'])&&trim($bank_get['settlement_webhook_url'])) 
            $webhook_url=@$bank_get['settlement_webhook_url'];	
            else $webhook_url='';
			
			if(isset($_SESSION['last_withdraw_micro_current_date_'.$uid]))
			$tdate_micro=$_SESSION['last_withdraw_micro_current_date_'.$uid];
			else $tdate_micro=micro_current_date();
		
			$additional_fld=$master_fld=",`acquirer_ref`,`acquirer_response`,`product_name`,`support_note`,`source_url`,`system_note`,`json_value`,`trans_response`,`upa`,`webhook_url` " ;
			
			$additional_data=$master_data=",'{$acquirer_ref}','{$acquirer_response}','{$product_name}','{$remark_upd}','{$source_url}','{$system_note}','{$json_value}','{$trans_response}','{$upa}','{$webhook_url}' " ;
			
			
			if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'){
				$master_fld=''; $master_data='';}
			
			//Dev Tech : 24-09-16 REMAINING BALANCE WV2 is Y then start remaining balance 
			if(isset($data['REMAINING_BALANCE_WV2'])&&$data['REMAINING_BALANCE_WV2']=='Y')
			{
				@$master_fld .=",`remaining_balance_amt`,`mature_rolling_fund_amt`,`immature_rolling_fund_amt` "; 
				@$master_data .=",'".@$json_values['remaining_balance']."','".@$json_values['mature_rolling_fund']."','".@$json_values['immature_rolling_fund']."' " ;
			}
				
			$sqlStmt = "INSERT INTO `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`" . "(`tdate`,`merID`,`bill_amt`,`acquirer`,`trans_status`, `fullname`,`reference`,`transID`,`mop`,`bill_currency`,`bank_processing_curr`,`bill_ip`,`trans_type`,`trans_currency`,`buy_txnfee_amt`,`remark_status`,`trans_amt`,`payable_amt_of_txn`,`transaction_period`,`available_balance`,`settelement_date`,`rolling_amt`,`available_rolling`,`channel_type` ".$master_fld.$query_own1.")
			VALUES" . 
			"('{$tdate_micro}','{$uid}','" . $bill_amt . "','{$acquirer}',{$trans_status}," . "'" . $fullname . "','" . $reference  . "','{$transactioncode}','" . $mop . "','" . $bill_currency . "','" . $bank_processing_curr . "','" . $current_ip . "','" . $trans_type . "','" . $trans_currency . "','-" . $buy_txnfee_amt . "'," .  "'1','" . "-" . $trans_amt . "','" . "" . $amount . "','" . $transaction_period . "','" . $last_available_balance . "','{$tdate_micro}','".$rolling_amt."','".$available_rolling_tr."','".$channel_type."'".$master_data.$query_own2." )";
			
			//echo $sqlStmt;exit;
			db_query($sqlStmt, $qp);

			$tr_newtableid = newid();
			
			
				
			//$transactioncode = $type.substr($tr_newtableid,-5).date("is");
			
			$transactioncode = gen_transID_f($tr_newtableid,$type);
			
			$transaction_update_query='';
			
			//nodel account 
			if( ( isset($post_clk_cal) ) && ( $post_clk_cal== true ) && ($data['ThisPageLabel']=='Withdraw') ) {
				//include('../nodal/n74753/nodel_account_74753_post.do');
			}
			
			
			if($tr_newtableid){	
				db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` SET `transID`='".$transactioncode."' ".$transaction_update_query." WHERE (`id`='{$tr_newtableid}') ",$qp);
				
				$tableName=$data['MASTER_TRANS_TABLE'];
				
				//insert data to new table for master_trans_additional and this value is Y  
				if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'){
					db_query("INSERT INTO `{$data['DbPrefix']}{$data['ASSIGN_MASTER_TRANS_ADDITIONAL']}` (`id_ad`,`transID_ad` ".$additional_fld.")VALUES".
					"('{$tr_newtableid}','{$transactioncode}' ".$additional_data.")",$qp);
					$tableName=$data['ASSIGN_MASTER_TRANS_ADDITIONAL'];
				}
				
                json_log_upd($tr_newtableid,$tableName);

			}
			
			$clk_arr['wd_id']=$tr_newtableid;
			$clk_arr['transID']=$transactioncode;

            
            #######################################################

			
            //unset array value after create the withdraw for v1

			if(isset($_SESSION['uid_'.$uid]['trans_detail_array'])) unset($_SESSION['uid_'.$uid]['trans_detail_array']);
			if(isset($_SESSION['uid_'.$uid]['ab'])) unset($_SESSION['uid_'.$uid]['ab']);
			if(isset($_SESSION['uid_'.$uid]['payout'])) unset($_SESSION['uid_'.$uid]['payout']);
            if(isset($_SESSION['uid_'.$uid]['deduction_array_ajax'])) unset($_SESSION['uid_'.$uid]['deduction_array_ajax']);
            if(isset($_SESSION['uid_'.$uid]['payout_array_ajax'])) unset($_SESSION['uid_'.$uid]['payout_array_ajax']);

			
			if(isset($_SESSION['uid_'.$uid])){
				unset($_SESSION['uid_'.$uid]);
			}


            //unset array value after create the withdraw for v2

			if(isset($_SESSION['uid_wv2'.$uid]['trans_detail_array'])) unset($_SESSION['uid_wv2'.$uid]['trans_detail_array']);
			if(isset($_SESSION['uid_wv2'.$uid]['ab'])) unset($_SESSION['uid_wv2'.$uid]['ab']);
			if(isset($_SESSION['uid_wv2'.$uid]['payout'])) unset($_SESSION['uid_wv2'.$uid]['payout']);
            if(isset($_SESSION['uid_wv2'.$uid]['deduction_array_ajax'])) unset($_SESSION['uid_wv2'.$uid]['deduction_array_ajax']);
            if(isset($_SESSION['uid_wv2'.$uid]['payout_array_ajax'])) unset($_SESSION['uid_wv2'.$uid]['payout_array_ajax']);

			
			if(isset($_SESSION['uid_wv2'.$uid])){
				unset($_SESSION['uid_wv2'.$uid]);
			}
			
			if(isset($_SESSION['last_withdraw_micro_current_date_'.$uid]))
				unset($_SESSION['last_withdraw_micro_current_date_'.$uid]);
			

			#######################################################
			
			//clk
			
			if( $is_admin == true && isset($auto_amt_clk) && $auto_amt_clk== true) {
				//unset($json_values['clk']);
				$json_values['clk']=$clk_arr;
				//$json_values_clk=array_merge($clk_arr);
				json_print3($json_values);exit;
			}
			
			if($qp==5) exit;
			
			// batch transaction
			
			/*
			$ptdate = date ( 'Y-m-d' );
			$ds = daily_trans_statement_amt ( $uid, $ptdate );

			if ($data ['ThisPageLabel'] == 'Send') {
				$ds = daily_trans_statement_amt ( $post['merID_id'], $ptdate );
			}
			*/
			

			// calculation_tr_fee($tr_newtableid,$uid);

			// echo "<br/>".$tr_newtableid;
			// exit;
			
			$_SESSION['action_success']='Success : We will be process the '.$data ['ThisTitle'].' - '.$transactioncode.' within 4 working days';
			
			

			if ($is_admin == true) {
				echo "<script>
				 top.window.location.href=top.window.location.href;
				</script>";
				
			} else {
				header("Location:{$data['USER_FOLDER']}/".$_SESSION['NameOfFile']);exit;
			}
			$post['step']++;
		}
	}  
} elseif (isset($post['cancel'])&&$post['cancel'])
	$post['step']--;

if ($data ['ThisPageLabel'] == 'Send') {
	if (isset ( $_POST['amount'] )) {
		$post['amount']= $_POST['amount'];
	} else {
		$post['amount']= "";
	}
}

//display ('user');exit;

if(isset($data['is_admin'])&&$data['is_admin'])
{
	$clients_active_type = @$_SESSION['MemberInfo']['active'];
	$mtype = @$data['MEMBER_TYPE'][$clients_active_type];

	// ##############################################################################
	if((isset($_SESSION['login_adm']))||(isset($_SESSION[$mtype])&&$_SESSION[$mtype]==1))
	{
		display ( 'user' );
	}
	else include('../oops'.$data['iex']);
	// ##############################################################################
}else{
	display ( 'user' );
}


?>