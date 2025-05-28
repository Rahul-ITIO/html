<?
$data['PageName']	= 'Add Beneficiary';
$data['PageFile']	= 'addbeneficiary';


###############################################################################
include('../config.do');
$data['PageTitle'] = 'Add Beneficiary - '.$data['domain_name'];

##########################Check Permission#####################################

//if(!clients_page_permission('18',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }

//if(isset($_SESSION['m_clients_role'])&&isset($_SESSION['m_clients_type'])&&!clients_page_permission('18',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }
###############################################################################

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

$success_count = $fail_count = $notmatch = $dup_count=0;
$dup_acc = $notmatch_acc="";
if(isset($_POST['send'])&&$_POST['send']=='submit_data'){

	$gateway_url	= $data['Host']."/payout/addbeneficiary".$data['ex'];

	$secret_key		= $post['apikey'];
	$payout_token	= $post['payout_token'];
	$secret_word	= $post['secret_word'];

	$acc_row = select_tablef("`id`='{$uid}' ",'clientid_table',0,1);
	$secret_key			= $acc_row['private_key'];
	$payout_secret_key	= json_decode($acc_row['payout_secret_key'],1)['decrypt']; //fetch from clients table
	$payout_token		= $acc_row['payout_token'];		//fetch from clients table

	if(isset($_FILES['file']) && $_FILES['file']['error'] === UPLOAD_ERR_OK) {

		//==============================Fetch Data From Excel=============================
		$file_ext	= pathinfo($_FILES['file']['name'], PATHINFO_EXTENSION);
		$file		= $_FILES['file']['tmp_name'];

		if(strpos($file_ext,'csv') !== false)
		{
			$handle = fopen($file, "r");
			$i=0;
			while(($filesop = fgetcsv($handle, 1000, ",")) !== false)
			{
				if($i==0)
				{
				}
				else
				{
					//print_r($filesop);exit;
					$pramPost=array();

					#################################################
					$pramPost['client_ip']	=(isset($_SERVER['HTTP_X_FORWARDED_FOR'])?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR']);
					$pramPost['beneficiary_nickname']	= $filesop[0];
					$pramPost['beneficiary_name']		= $filesop[1];
					$pramPost['account_number']			= $filesop[2];
					$pramPost['beneficiary_ac_repeat']	= $filesop[3];
					$pramPost['beneficiary_bank_name']	= $filesop[4];
					$pramPost['bank_code1']				= $filesop[5];
					$pramPost['bank_code2']				= $filesop[6];
					$pramPost['bank_code3']				= $filesop[7];
					$pramPost['beneficiaryEmailId']		= $filesop[8];
					$pramPost['beneficiaryPhone']		= $filesop[9];
					$pramPost['udf1']					= $filesop[10];
					$pramPost['udf2']					= $filesop[11];
					$pramPost['notify_url']				= $filesop[12];
					
					$pramPost["payout_secret_key"] = $post['secret_word'];
					
					if(isset($_SESSION['uid'])){
						$pramPost["mer_id"] = $_SESSION['uid'];
					}

					if($pramPost['account_number']==$pramPost['beneficiary_ac_repeat'])
					{
						$get_string=http_build_query($pramPost);

						if($get_string){

							$encrypted = data_encode_sha256($get_string,$secret_key,$payout_token);
							if($encrypted){
								$send_arr['pram_encode']=$encrypted.$payout_token;
								$bene_json	= use_curl($gateway_url,$send_arr);
								$bene_arr	= json_decode($bene_json,1);
								//cmn 
								//echo "<br/>payout_token=>".$payout_token;
								//echo "<br/>payout_token=>".$payout_token; print_r($bene_arr);exit;
								if($bene_arr['status']=='0004'){
									$_SESSION['Error'] = 'ACCESS DENIED!! Secret Word not match';
									header("Location:{$data['Host']}/user/beneficiaries{$data['ex']}");
									exit;
								}
								elseif($bene_arr['status']=='0011'){
									$_SESSION['Error'] = $bene_arr['reason'];
									header("Location:{$data['Host']}/user/beneficiaries{$data['ex']}");
									exit;
								}
								
								if($bene_arr['status']=='0000'){
									$success_count++;	//count success
								}
								elseif($bene_arr['status']=='0001'){
									$notmatch++;
									if($notmatch_acc) $notmatch_acc .= ", ";
									$notmatch_acc .=$bene_arr['account_number'];
								}elseif($bene_arr['status']=='0002'){
									$dup_count++;
									if($dup_acc) $dup_acc .= ", ";
									$dup_acc .=$bene_arr['account_number'];
								}
							}
						}
					}
					else {
						$notmatch++;
						if($notmatch_acc) $notmatch_acc .= ", ";
						$notmatch_acc .= $pramPost['account_number'];
					}
				}
				$i++;
			}
			if($success_count)$_SESSION['action_success']=$success_count.' beneficiary added successfully';
			if($fail_count)	$_SESSION['Error'] = $fail_count.' request failed';
			if($notmatch)	$_SESSION['Error'] = $notmatch.' Account number and repeat account number not matched ('.$notmatch_acc.')';
			if($dup_count)	$_SESSION['Error'] = $dup_count.' Beneficiary already exists. ('.$dup_acc.')';
		}
		else $_SESSION['Error'] = 'File not supported'; 

//		header("Location:{$data['Host']}/user/beneficiary_list{$data['ex']}");exit;
		header("Location:{$data['Host']}/user/beneficiaries{$data['ex']}");exit;
	}else{
		$data['Error']='Please Upload File.';
	}
}

#######################################
display('user');
#######################################
?>