<?

if(!isset($data['PageName'])){
	$data['PageName']='new_acbalance';
}
$data['PageFile']='new_acbalance';

###############################################################################
if(!isset($data['DISPLAY_MULTI'])){
	include('../config.do');
}


###############################################################################
$status_button=("../front_ui/{$data['frontUiName']}/common/status_button".$data['iex']);
if(file_exists($status_button)){
	include($status_button);
}
$data['PageTitle'] = 'My new_acbalance - '.$data['domain_name'];
if(!isset($data['FileName'])){
	$data['FileName']='new_acbalance'.$data['ex'];
}


$data['PageFile']='new_acbalance';
$data['PageTitle'] = 'My Report - '.$data['domain_name'];
$data['FileName']='new_acbalance'.$data['ex'];

###############################################################
$uid_session_true=0;
if(!isset($_SESSION['start_date_date'])){
	$_SESSION['start_date_date']=$start_date_date=date('YmdHis');
}
$current_date_time=date('YmdHis', strtotime("-55 minutes"));
if($_SESSION['start_date_date']<$current_date_time){
	$_SESSION['start_date_date']=$start_date_date=date('YmdHis');
	if(isset($_SESSION['uid_'.$uid])){
		unset($_SESSION['uid_'.$uid]);
	}
}
if(!isset($_SESSION['uid_'.$uid])){$uid_session_true=1;}

if(isset($_GET['dtest'])){
	$uid_session_true=1;
}	
if($uid_session_true){
	//$_SESSION['uid_'.$uid]['ab']=$post['ab']=account_balance_newac($uid,"",$date_from_to);
}

$trans_detail_array = fetch_balance($uid);
$monthly_fee	= payout_trans_new($uid);


$_SESSION['uid_'.$uid]['ab']=$post['ab']=account_balance_newac($uid,"",$date_from_to, $trans_detail_array);	

$post['ab']=$_SESSION['uid_'.$uid]['ab'];

$post['mbt']	= account_trans_balance_calc_new($uid, $trans_detail_array, $ptdate);

$post['mbt_d']	= account_trans_balance_calc_d_new($uid,$ptdate,0,$trans_detail_array);



//$post['mbt']=account_trans_balance_calc($post['bid']);
//$post['mbt_d']=account_trans_balance_calc_d($post['bid']);
//$post['ab']=account_balance($post['bid']);


//include "../include/mb_page.do";
###############################################################################
display('user');
###############################################################################
?>