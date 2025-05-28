<?
###############################################################################
$data['PageName']='BANK INFORMATION';
$data['PageFile']='bank'; 
###############################################################################
include('../config.do');
$data['PageTitle'] = 'My Banking Information - '.$data['domain_name'];
##########################Check Permission#####################################
/*if(!clients_page_permission('7',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }*/

if(isset($_SESSION['m_clients_role'])&&isset($_SESSION['m_clients_type'])&&!clients_page_permission('7',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }
###############################################################################
###############################################################################
if(!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
        header("Location:{$data['Host']}/index".$data['ex']);
        echo('ACCESS DENIED.');
        exit;
}
###############################################################################
if(isset($_GET['HideAllMenu'])&&$_GET['HideAllMenu']){
	// echo $_GET['HideAllMenu'];
	 $data['HideAllMenu']=true;
	 $redirect_type="modal_js";
	 $post['step']=2;
}
###############################################################################
if(is_info_empty($uid)){
        header("Location:{$data['Host']}/user/profile".$data['ex']);
        echo('ACCESS DENIED.');
        exit;
}
###############################################################################
$post=select_info($uid, $post);

if(!isset($post['step']) || !$post['step'])$post['step']=1;
############################################################################### 

if(isset($data['con_name'])&&$data['con_name']=='clk'){
	$post['swift_con']='IFSC';
	$ovalidation=false;
}else{
	$post['swift_con']='SWIFT';
	$ovalidation=true;
}

$post['ovalidation']=$ovalidation;


//if(isset($_REQUEST['HideAllMenu'])&&isset($_REQUEST['action'])&&$_REQUEST['action']&&in_array($_REQUEST['action'],["addCryptoWallet","addNewBank"])) $post['send']=1;


// insert_bank_info  add bank function line 38 to 118

if(isset($post['send'])&&$post['send'])
{

	$bankAccVald=1;
	
	if(isset($post['bname'])&&$post['bname']=='Crypto Wallet'){$bankAccVald=0;}
	
	$cryptoWalle=false;
	if(isset($post['insertType'])&&$post['insertType']=="Crypto Wallet")
	{
		$cryptoWalle=true;
	}
	$validation=false;
	
	$file_name=(isset($_FILES['bankdoc']['name'])?$_FILES['bankdoc']['name']:'');
	$doc_url = parse_url($file_name);
	$file_name_not_ext = pathinfo($doc_url['path'], PATHINFO_FILENAME);
	$ext  = pathinfo($doc_url['path'], PATHINFO_EXTENSION);
	
        if(isset($post['step'])&&$post['step']==1){ 
			$post['step']++;
        }elseif(isset($post['step'])&&$post['step']==2){

			if($cryptoWalle){
				if(!isset($post['coins_name'])||!$post['coins_name']){
					$data['Error']='Please select name of coins.';
				}elseif(!isset($post['coins_network'])||!$post['coins_network']){
					$data['Error']='Please select Network.';
				}elseif(!isset($post['coins_address'])||!$post['coins_address']){
					$data['Error']='Please enter coin address.';
				}elseif(!isset($post['coins_wallet_provider'])||!$post['coins_wallet_provider']){
					$data['Error']='Please enter Wallet Provider.';
				}
				else $validation=true;
			}
			else//if($post['insertType']=='Bank Account')
			{
				if(((!isset($post['bnameacc']))||(empty($post['bnameacc'])))&&($bankAccVald==1)){
					$data['Error']='Please enter account holder&rsquo;s name';
				}elseif(((!isset($post['full_address']))||(empty($post['full_address'])))&&($bankAccVald==1)){
					$data['Error']='Please enter account holder&rsquo;s address.';
				}elseif((!isset($post['baccount']))||(empty($post['baccount']))){
					$data['Error']='Please enter account number (IBAN No.).';
				}elseif(((!isset($post['brtgnum']))||(empty($post['brtgnum'])))&&($ovalidation==true)){
					$data['Error']='Please enter bank short code (Routing/ Branch Code/ IFSC etc).';
				}elseif((!isset($post['bswift']))||(empty($post['bswift']))){
					$data['Error']="Please enter {$post['swift_con']} code your bank.";
				}elseif((!isset($post['bname']))||(empty($post['bname']))){
					$data['Error']='Please enter name of your bank.';
				}elseif((!isset($post['required_currency']))||(empty($post['required_currency']))){					
					$data['Error']='Please select required currency.';
				}elseif(!isset($post['baddress'])||(empty($post['baddress']))){
				
					$data['Error']='Please enter address of your bank.';
				}/*elseif(!$post['bcity']){
                        $data['Error']='Please enter city of your bank.';
                }elseif(!$post['bzip']){
                        $data['Error']='Please enter postal code of your bank.';
						}elseif(!$post['bcountry']){
                        $data['Error']='Please choose country of your bank.';
                }elseif(!$post['bphone']){
                        $data['Error']='Please enter telephone number of your bank.';
                }*/
				elseif(!isset($post['baccount'])||(empty($post['baccount']))){
                        $data['Error']='Please enter account number.';
                }
				else $validation=true;
			}
			

			if($validation==true)
			{
				if(isset($file_name)&&($file_name)&&($_FILES["bankdoc"]["size"]>6000000)){ //1000000*6=6000000 (6MB)
					$data['Error']="File size should be less than 6MB";	
				}elseif(isset($file_name)&&($file_name)&&(!preg_match("/\.(jpg|jpeg|bmp|gif|png|PNG|pdf)$/", $file_name))){
					$data['Error']="Unsupported file type ".$ext;
				}else{
					
				
					if($cryptoWalle){
						$maxId=$uid."_".$post['coins_name']."_".time().mt_rand(0,9999999);
					}else{
						$maxId=$uid."_".$post['bnameacc']."_".$post['bswift']."_".time().mt_rand(0,9999999);
					}
				
					$updatelogo		= (isset($post['bankdoc'])?$post['bankdoc']:''); 
					$upload_logo	= (isset($post['upload_logo'])?$post['upload_logo']:'');
					$uploaddir 		= '../user_doc/';

					$fileName	= $maxId.'_'.$_FILES['bankdoc']['name'];
					$updatelogo_file = $uploaddir . basename($fileName); 
					
					if (move_uploaded_file($_FILES['bankdoc']['tmp_name'], $updatelogo_file)) { 
						if($upload_logo){unlink($uploaddir . basename($upload_logo));}
					} else {
						$fileName = $upload_logo;
					}
					
					$post['upload_logo']=$fileName;
				
				if($cryptoWalle){
					if(!isset($post['gid'])||!$post['gid']){ 
						insert_coin_wallet_info($post, $uid);
						if($data['cwnewid']){
							$tabid=$data['cwnewid'];
							$_SESSION['action_success']="Crypto Wallet Added Successfully";	
						}
					}else{ 
						if(isset($_SESSION['bank_primary'])&&$_SESSION['bank_primary']!="2"){
							update_coin_wallet_info($post, $post['gid'], $uid);
							$tabid=$post['gid'];
							//$_SESSION['action_success']="Crypto Wallet Update Successfully";			
						}
					}
				}
				else{
			
					if(!isset($post['gid'])||!$post['gid']) {
						insert_bank_info($post, $uid);
						if($data['bnknewid']){
							$tabid=$data['bnknewid'];
							$_SESSION['action_success']="Bank Added Successfully";	
							//json_log_upd($tabid,'banks'); Remove and add on function by vikash on 29092022
						}					
					}else{ 
						if(isset($_SESSION['bank_primary'])&&$_SESSION['bank_primary']!="2"){
							update_bank_info($post, $post['gid'], $uid);
							$tabid=$post['gid'];
							//$_SESSION['action_success']="Bank Update Successfully";		
							//json_log_upd($tabid,'banks'); Remove and add on function by vikash on 29092022
						}
					}
				}
				$post['step']--;
				//$_SESSION["query_status"]=1;
				header("location:{$data['USER_FOLDER']}/bank{$data['ex']}?");
				exit;
			}
		}
	}
}
elseif(isset($post['cancel'])&&$post['cancel'])$post['step']--;
if((isset($post['action'])&&$post['action']=='update')&&(!isset($data['Error'])||empty($data['Error']))){

		$cryptoWalle=false;
		if(isset($_GET['insertType'])&&$_GET['insertType']=='Crypto Wallet')
		{
			$cryptoWalle=true;
		}
	
		if($cryptoWalle)
		{
			$bank = select_coin_wallet($uid, $post['gid'], true);
		}		
        else {
			$bank=select_banks($uid, $post['gid'], true);
		}

        foreach($bank[0] as $key=>$value)if(!isset($post[$key])||!$post[$key])$post[$key]=$value;
        $post['actn']='update';
        $post['step']++;
}if((isset($post['action'])&&$post['action']=='bank_account_primary')&&(!isset($data['Error'])||empty($data['Error']))){
        //$bank=select_banks($uid, $post['gid'], true);
		db_query(
				"UPDATE `{$data['DbPrefix']}banks` SET ".
				"`bank_account_primary`=0 ".
				" WHERE `clientid`='{$uid}' ",0
		);
		db_query(
				"UPDATE `{$data['DbPrefix']}banks` SET ".
				"`bank_account_primary`=1 ".
				" WHERE `id`='".$post['gid']."' AND `clientid`='{$uid}' ",0
		);
		$_SESSION['query_status']=1;			
        header("Location:{$data['USER_FOLDER']}/bank".$data['ex']);exit;
}if((isset($post['action'])&&$post['action']=='crypto_wallet_primary')&&(!isset($data['Error'])||empty($data['Error']))){
	//$bank=select_banks($uid, $post['gid'], true);
	db_query(
		"UPDATE `{$data['DbPrefix']}coin_wallet` SET ".
		"`bank_account_primary`=0 ".
		" WHERE `clientid`='{$uid}' ",0
	);
	db_query(
		"UPDATE `{$data['DbPrefix']}coin_wallet` SET ".
		"`bank_account_primary`=1 ".
		" WHERE `id`='".$post['gid']."' AND `clientid`='$uid' ",0
	);
	$_SESSION['query_status']=1;			
	header("Location:{$data['USER_FOLDER']}/bank".$data['ex']);exit;
}elseif(isset($post['action'])&&($post['action']=='addNewBank'||$post['action']=='addCryptoWallet')){
	$post['step']++;
}elseif(isset($post['action'])&&$post['action']=='delete'){
	$bank = delete_bank($post['gid'],1);
	if(isset($bank['success'])&&$bank['success']){
		//$_SESSION['action_success']=' '.$bank['success'];
		header("Location:{$data['USER_FOLDER']}/bank".$data['ex']);exit;
		//$data['Error']='Please enter account holder&rsquo;s address.';
	}
}elseif(isset($post['action'])&&$post['action']=='deleteCrypto'){
	$bank=delete_crpto($post['gid'],1);
	if(isset($bank['success'])&&$bank['success']){
		//$_SESSION['action_success']=' '.$bank['success'];
		header("Location:{$data['USER_FOLDER']}/bank".$data['ex']);exit;
	}
}elseif((isset($post['action'])&&$post['action']=='sent_verification_amt')&&(!isset($data['Error'])||empty($data['Error']))){
	$tname	= trim($post['tname']);
	if($tname=='coin_wallet'){
		header("Location:{$data['Host']}/nodal/binance_status".$data['ex']."?mer=1&tid={$post['gid']}&actionurl={$data['USER_FOLDER']}/bank".$data['ex']);
	}
	else{ 
		$sqlStmt = "SELECT b.`payout_id` as payout_id FROM `{$data['DbPrefix']}clientid_table` a, `{$data['DbPrefix']}bank_payout_table` b WHERE a.`id`='{$uid}' and a.`payout_account`=b.`id` LIMIT 0,1";
	
		$acc_q=db_rows($sqlStmt,0);
		
		if(isset($acc_q[0]['payout_id'])&&$acc_q[0]['payout_id'])
		{
			$payout_id=$acc_q[0]['payout_id'];
			$file = "n".$payout_id."/payment_".$payout_id.$data['ex'];

			$_SESSION['payout_id']=$payout_id;
			$_SESSION['return_url']=$data['USER_FOLDER']."/bank".$data['ex'];
			
			header("Location:{$data['Host']}/nodal/$file?mer=1&tid={$post['gid']}");
		}
		else
		{
			header("Location:{$data['Host']}/nodal/cashfree".$data['ex']."?mer=1&tid={$post['gid']}&actionurl={$data['USER_FOLDER']}/bank".$data['ex']);
		}
	}	
	exit;

}elseif((isset($post['action'])&&$post['action']=='verify_account')&&(!isset($data['Error'])||empty($data['Error']))){

	$gid	= $_REQUEST['gid'];
	$amount	= trim($post['amount']);
	$tname	= trim($post['tname']);

	if($tname=='coin_wallet')
	{
		$amtData = select_coin_wallet($uid,$gid);
		$verify_tid		= $amtData[0]['verify_tid'];
	}
	else
		$amtData = select_banks($uid,$gid);

	$verify_amount = $amtData[0]['verify_amount'];	

	if($verify_amount==$amount)
	{
		update_status_bank($gid, "`primary`=2, verify_status=1", $tname);
		$_SESSION['action_success']="Verification successfully";
		if(isset($verify_tid) && $verify_tid) update_transaction_ranges(-1, 1, $verify_tid);	
	}
	else
	{
		$_SESSION['action_error']="Invalid amount";
	}
	if(isset($_SESSION['sent_success']))	unset($_SESSION['sent_success']);
	if(isset($_SESSION['sent_tname']))		unset($_SESSION['sent_tname']);
	if(isset($_SESSION['coins_name']))		unset($_SESSION['coins_name']);
	//$_SESSION['query_status']=1;
	header("Location:{$data['USER_FOLDER']}/bank".$data['ex']);exit;
}
if(isset($post['step'])&&$post['step']==1){
	$data['Banks']	= select_banks($uid);
	$data['Crypto']	= select_coin_wallet($uid);

	$data['b_result_count']=sizeof($data['Banks'])+sizeof($data['Crypto']);


	$total_verify1 = getTotalRecords("banks", "`clientid`='{$uid}' AND `verify_date`='".$data['TODAY_DATE_ONLY']."'");

	$total_verify2 = getTotalRecords("coin_wallet", "`clientid`='{$uid}' AND `verify_date`='".$data['TODAY_DATE_ONLY']."'");

	$data['total_verify'] = (int)$total_verify1+(int)$total_verify2;
}
###############################################################################
display('user');
###############################################################################
?>
