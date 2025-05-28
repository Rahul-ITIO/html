<?
$data['PageName']	= 'Upload Funds';
$data['PageFile']	= 'upload-fund';

###############################################################################
include('../config.do');
$data['PageTitle'] = 'Upload Funds - '.$data['domain_name']; 
##########################Check Permission#####################################

/*if(!clients_page_permission('19',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }

if(isset($_SESSION['m_clients_role'])&&isset($_SESSION['m_clients_type'])&&!clients_page_permission('19',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }
*/
###############################################################################

if(!isset($_SESSION['uid'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

###############################################################################
if(is_info_empty($uid)){
	header("Location:{$data['USER_FOLDER']}/profile".$data['ex']);
	echo('ACCESS DENIED..');
	exit;
}

$post=select_info($uid, $post);

include_once $data['Path'].'/include/payout-request'.$data['iex'];

if(!isset($post['step']) || !$post['step'])$post['step']=1;
$post['Buttons']=get_files_list($data['SinBtnsPath']);

//$post=select_info($uid, $post);
//print_r($post);

if(!isset($post['step']) || !$post['step'])$post['step']=1;

###############################################################################
if($data['2FA_ENABLE']=='Y')
{
	if($post['google_auth_code']=='') {
		header("Location:{$data['USER_FOLDER']}/two-factor-authentication{$data['ex']}");exit;
	}
	elseif(($post['google_auth_access']==1||$post['google_auth_access']==3)&&($post['google_auth_code'])) {
		$data['withdraw_gmfa']=1;
		$_SESSION['google_auth_code']=$google_auth_code=$post['google_auth_code'];
		$google_auth_access=$post['google_auth_access'];
		$authenticat_msg='and successfully authenticated';
	}
}
###############################################################################
 
//fetch account number and processing currency from bank_payout_table via id mappped with clients - 
$bank_master	= select_tablef("`id` = '".$post['payout_account']."'",'bank_payout_table');
$ac_payout_id	= $bank_master['payout_id'];
$ac_default_curr= $bank_master['payout_processing_currency'];

$ac_payout_id	= 1112;

$payout_dir = "p".$ac_payout_id;	// add "P" in directory name

if(file_exists($data['Path'].'/payout/'.$payout_dir.'/acq_'.$ac_payout_id.$data['iex']))
{
	include_once $data['Path'].'/payout/'.$payout_dir.'/acq_'.$ac_payout_id.$data['iex'];

	$check_status = 'payout/'.$payout_dir.'/status_'.$ac_payout_id.$data['ex'];
}
else {
	echo($data['Path'].'/payout/'.$payout_dir.'/acq_'.$ac_payout_id.$data['iex'].' is Missing');
	//echo('ACCESS DENIED....');
	exit;
}

$success_count = $fail_count= $low_bal_count= $not_exist_count = $scrubbed_count = 0;
$invalid_bene_id = $invalid_mrid = $scrubbed_ids = "";

if(isset($_POST['send'])&&$_POST['send']=='submit_data'){

	$gateway_url	= $data['Host']."/payout/sendpayout".$data['ex'];

	$secret_key		= $post['private_key'];
	$payout_token	= $post['payout_token'];

	$protocol	= isset($_SERVER["HTTPS"])?'https://':'http://';
	$referer	= $protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];

	if(isset($_FILES['file']) && $_FILES['file']['error'] === UPLOAD_ERR_OK) {

		//==============================Fetch Data From Excel=============================
		$file_ext = pathinfo($_FILES['file']['name'], PATHINFO_EXTENSION);
		$file = $_FILES['file']['tmp_name'];
		$handle = fopen($file, "r");

		if(strpos($file_ext,'csv') !== false)
		{
			$acc_row = select_tablef("`id`='{$uid}' ",'clientid_table',0,1);
			$payoutFee	= $acc_row['payoutFee'];
			if(empty($payoutFee)) $payoutFee = "0.00";

			$i=0;
			while(($filesop = fgetcsv($handle, 1000, ",")) !== false)
			{
				if($i==0)
				{
				}
				else
				{
					##########
					$pramPost=array();

					$pramPost["payout_token"]=$payout_token; 

					#################################################

					$pramPost['client_ip']	=(isset($_SERVER['HTTP_X_FORWARDED_FOR'])?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR']);
					$pramPost['action']		='payout';
					$pramPost['source']		='Payout-Encode';
					$pramPost['source_url']	=$referer;
					$pramPost['ac_default_curr']= $ac_default_curr;

					$pramPost["payout_secret_key"]	= $post['secret_word'];
					$pramPost["check_status"]		= $check_status;

					//from excel sheet
					$pramPost['beneficiary_id']	= $filesop[0];
					$pramPost['price']			= $filesop[1];

					if(isset($filesop[2])&&$filesop[2]) $pramPost['curr'] = $filesop[2];
					else $pramPost['curr'] = $ac_default_curr;

					if(isset($filesop[3])&&$filesop[3]) $pramPost['remarks']	= $filesop[3]; 
					else $pramPost['remarks']	='';

					if(isset($filesop[4])&&$filesop[4]) $pramPost['narration']	= $filesop[4];
					else $pramPost['narration']= '';
					
					if(isset($filesop[5])&&$filesop[5]) $pramPost['request_id']	= $filesop[5];
					else $pramPost['request_id']= '';

					if(isset($filesop[6])&&$filesop[6]) $pramPost['source_url'] = $filesop[6];else $pramPost['source_url'] ="";
					if(isset($filesop[7])&&$filesop[7]) $pramPost['notify_url'] = $filesop[7];else $pramPost['notify_url'] ="";
					if(isset($filesop[8])&&$filesop[8]) $pramPost['success_url']= $filesop[8];else $pramPost['success_url'] ="";
					if(isset($filesop[9])&&$filesop[9]) $pramPost['failed_url'] = $filesop[9];else $pramPost['failed_url'] ="";

					$pramPost['product_name']	= 3;// 3 for SEND FUND
					$pramPost['mer_id']			= $uid;
					$pramPost['pay_type']		= $ac_payout_id;

					$get_string=http_build_query($pramPost);

					###########
					if($get_string){
						$encrypted = data_encode_sha256($get_string,$secret_key,$payout_token);
						if($encrypted){
							$send_arr['pram_encode']=$encrypted.$payout_token;
							$fund_json	= use_curl($gateway_url,$send_arr);
							$fund_arr	= json_decode($fund_json,1);

							//print_r($fund_arr);exit;
						
							if($fund_arr['status']=='0004'){
							//print_r($fund_arr);exit;
								$_SESSION['Error'] = $fund_arr['reason'];
								header("Location:{$data['Host']}/user/upload-fund{$data['ex']}");exit;
							}
							elseif($fund_arr['status']=='0005'){
							//print_r($fund_arr);exit;
								$_SESSION['Error'] = $fund_arr['reason'];
								header("Location:{$data['Host']}/user/upload-fund{$data['ex']}");exit;
							}
							elseif($fund_arr['status']=='0011'){
								$_SESSION['Error'] = $fund_arr['reason'];
								header("Location:{$data['Host']}/user/upload-fund{$data['ex']}");exit;
							}

							if(isset($fund_arr['transaction_id'])&&$fund_arr['transaction_id'])
								$transaction_id = $fund_arr['transaction_id'];

							if($fund_arr['status']=='0000'){
								$success_count++;
							}
							elseif($fund_arr['status']=='0001'){
								$low_bal_count++;
							}
							elseif($fund_arr['status']=='0002'){
								$fail_count++;
								if($invalid_mrid) $invalid_mrid .= ", ";
								$invalid_mrid .=$fund_arr['request_id'];
							}
							elseif($fund_arr['status']=='0003'){
								$not_exist_count++;
								if($invalid_bene_id) $invalid_bene_id .= ", ";
								$invalid_bene_id .=$fund_arr['bene_id'];
							}elseif($fund_arr['status']=='0008'){
								$fail_count++;
								if($invalid_mrid) $invalid_mrid .= ", ";
								$invalid_mrid .=$fund_arr['request_id'];
							}
							elseif($fund_arr['status']=='0010'){
								$scrubbed_count++;
								if($scrubbed_ids) $scrubbed_ids .= ", ";
								$scrubbed_ids .=$fund_arr['transaction_id'];
							}
						}
					}
				}
				$i++;
			}
		}
		else $_SESSION['Error'] = 'File Not supported';

		if($success_count)	$_SESSION['action_success']	= $success_count.' request accepted successfully';

		if($fail_count||$low_bal_count||$not_exist_count){
			$err = "";
			if($fail_count)		$err = $fail_count." request failed - ($invalid_mrid) already exists\n ";
			if($low_bal_count)	$err.= $low_bal_count." request failed - Low Balance\n ";
			if($not_exist_count)$err.= $not_exist_count." request failed - ($invalid_bene_id) Beneficiary not exists\n ";
			if($scrubbed_count)	$err.= $scrubbed_count." scrubbed - ($scrubbed_ids) ";

			$_SESSION['Error']	= $err;
		}
		header("Location:{$data['Host']}/user/transfers{$data['ex']}");exit;
	//	header("Location:{$data['Host']}/user/payout-transaction{$data['ex']}");exit;
	}else{
		$_SESSION['Error']='Please Upload File.';
	}
}

################
display('user');
################
?>