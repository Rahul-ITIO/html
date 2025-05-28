<?
$data['PageName']	= 'Send Fund';
$data['PageFile']	= 'send-fund';

###############################################################################
include('../config.do');
$data['PageTitle'] = 'Send Fund - '.$data['domain_name']; 
##########################Check Permission#####################################
/*if(!clients_page_permission('5',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }*/

/*if(isset($_SESSION['m_clients_role'])&&isset($_SESSION['m_clients_type'])&&!clients_page_permission('5',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }*/
###############################################################################
//$post['add_titileName']='Add ';

if(!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

###############################################################################
if(is_info_empty($uid)){
	header("Location:{$data['USER_FOLDER']}/profile".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

$post=select_info($uid, $post);

include_once $data['Path'].'/include/payout-request'.$data['iex'];

if(!isset($post['step']) || !$post['step'])$post['step']=1;
$post['Buttons']=get_files_list($data['SinBtnsPath']);

//$post=select_info($uid, $post);

$payout_account		= $post['payout_account'];
$payout_bank_detail	= get_payout_bank_detail($payout_account, 'payout_processing_currency');
$data['payout_default_curr']= $payout_bank_detail[0]['payout_processing_currency'];

if(!isset($post['step']) || !$post['step'])$post['step']=1;


###############################################################################
if($post['google_auth_code']=='') {
	header("Location:{$data['USER_FOLDER']}/two-factor-authentication{$data['ex']}");exit;
}
elseif(($post['google_auth_access']==1||$post['google_auth_access']==3)&&($post['google_auth_code'])) {
	$data['withdraw_gmfa']=1;
	$_SESSION['google_auth_code']=$google_auth_code=$post['google_auth_code'];
	$google_auth_access=$post['google_auth_access'];
	$authenticat_msg='and successfully authenticated';
}			
###############################################################################

//print_r($post); print_r($uid); echo "=h1=";

###############################################################################
//echo $_REQUEST['pdisplay'];


//echo $post['payout_account'];exit;
 
$bank_master	= select_tablef("`id` = '".$post['payout_account']."'",'bank_payout_table');
$ac_payout_id	= $bank_master['payout_id'];
$ac_default_curr= $bank_master['payout_processing_currency'];

$payout_dir = "p".$ac_payout_id;

if(file_exists($data['Path'].'/payout/'.$payout_dir.'/acq_'.$ac_payout_id.$data['iex']))
{
	$check_status = 'payout/'.$payout_dir.'/status_'.$ac_payout_id.$data['ex'];

	include_once $data['Path'].'/payout/'.$payout_dir.'/acq_'.$ac_payout_id.$data['iex'];
}
else {
	echo($data['Path'].'/payout/'.$payout_dir.'/acq_'.$ac_payout_id.$data['iex'].' is Missing');
	//echo('ACCESS DENIED....');
	exit;
}

if(isset($_POST['send'])&&$_POST['send']=='submit_data'){

	$gateway_url	=$data['Host']."/payout/sendpayout".$data['ex'];
	
	$secret_key		= $post['private_key'];
	$payout_token	= $post['payout_token'];


	//$payout_secret_key=json_decode($post['payout_secret_key'],1)['decrypt'];
	
	//echo decode_f($payout_secret_key);
	
	#######################################################
	//<!--default (fixed) value * default -->
		
	$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
	$referer=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
	
	$pramPost=array();
	
	$pramPost["payout_token"]=$payout_token; 
	
	#################################################
	
	$pramPost["client_ip"]	=(isset($_SERVER['HTTP_X_FORWARDED_FOR'])?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR']);
	$pramPost["action"]		="payout";
	$pramPost["source"]		="Payout-Encode";
	$pramPost["source_url"]	=$referer;

	$pramPost["payout_secret_key"]		= $post['payout_secret_key'];
	$pramPost["price"]					= $post['transaction_amount'];
	$pramPost["curr"]					= $post['curr'];//"INR";//$post['transaction_currency'];
	$pramPost["product_name"]			= 3;//"Send Fund";

	$pramPost['beneficiary_id']			= $post['beneficiary_id'];
	$pramPost["beneficiary_bank_name"]	= $post['beneficiary_bank_name'];
	$pramPost["beneficiary_name"]		= $post['beneficiary_name'];
	$pramPost["beneficiary_ac"]			= $post['beneficiary_ac'];
	$pramPost["beneficiary_ac_repeat"]	= $post['beneficiary_ac_repeat'];
	$pramPost["beneficiary_ifsc"]		= $post['bank_code1'];
	$pramPost["bank_code2"]		= $post['bank_code2'];
	$pramPost["bank_code3"]		= $post['bank_code3'];
	$pramPost["check_status"]	= $check_status;
	
	$pramPost['mer_id']			= $uid;
	$pramPost['pay_type']		= $ac_payout_id;
	$pramPost['request_id']		= create_transaction_id($uid);
//print_r($pramPost);exit;
//	$pramPost["notify_url"]="https://yourdomain.com/notify.php";
//	$pramPost["success_url"]="https://yourdomain.com/success.php";
//	$pramPost["error_url"]="https://yourdomain.com/failed.php";
	
	$get_string=http_build_query($pramPost);

	if($get_string){	
		$encrypted = data_encode_sha256($get_string,$secret_key,$payout_token);

		if($encrypted){
			//header("Location:{$gateway_url}?pram_encode={$encrypted}{$payout_token}");exit;
			$send_arr['pram_encode']=$encrypted.$payout_token;
			$fund_json	= use_curl($gateway_url,$send_arr);
			$fund_arr	= json_decode($fund_json,1);
//			print_r($fund_arr );exit;
			if($fund_arr['status']=='0000'){
			//	$_SESSION['action_success']	= "Request success sent!!!";
			
				if(isset($fund_arr['bankStatus'])&&$fund_arr['bankStatus']=='00')
					$_SESSION['action_success']	= $fund_arr['message'];
				else
					$_SESSION['Error']	= $fund_arr['message'];
				
				/*
				//I think no any of this query -  - 9-01-23
				$sqlStmt = "SELECT *FROM `{$data['DbPrefix']}payout_beneficiary` WHERE bene_id='{$pramPost['beneficiary_id']}' LIMIT 0,1";
				$ben_detail = db_rows_2($sqlStmt);
				$pramPost['bank_code1']			= $ben_detail[0]['bank_code1'];
				$pramPost['bank_code2']			= $ben_detail[0]['bank_code2'];
				$pramPost['bank_code3']			= $ben_detail[0]['bank_code3'];
				$pramPost['account_number']		= $ben_detail[0]['account_number'];
				$pramPost['beneficiary_name']	= $ben_detail[0]['beneficiary_name'];
				
				$pramPost['transaction_id']	=$fund_arr['transaction_id'];*/
			
			}
			else $_SESSION['Error'] = $fund_arr['reason'];
		}
		
		header("Location:{$data['Host']}/user/transfers{$data['ex']}");exit;
		
		/*if(isset($_REQUEST['pdisplay'])&&$_REQUEST['pdisplay']){
			header("Location:{$data['Host']}/user/transfers{$data['ex']}");exit;
			}else{
			header("Location:{$data['Host']}/user/payout-transaction{$data['ex']}");exit;
		}*/
	}
}

###############################################################################
if(isset($_REQUEST['pdisplay'])&&$_REQUEST['pdisplay']){
	showpage("user/template.send-fund".$data['iex']);exit;
}else{
	display('user');
}
###############################################################################

?>