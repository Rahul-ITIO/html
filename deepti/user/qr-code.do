<? 
ob_start();
###############################################################################
$data['PageName']='QR Code';
$data['PageFile']='qr_code';
$data['PageFileName']='QR Code';

###############################################################################
include('../config.do');
$data['PageTitle'] = 'QR Code - '.$data['domain_name'];
###############################################################################

$is_admin=false;
if(isset($_SESSION['adm_login'])&&$_SESSION['adm_login']&&isset($_GET['admin'])&&$_GET['admin']){
	$is_admin=true;
	$data['HideAllMenu']=true;
	$uid=$_GET['id'];
	$_SESSION['login']=$uid;
}
if(!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}
###############################################################################
if(is_info_empty($uid)){
	header("Location:{$data['Host']}/user/profile".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}
###############################################################################
$post=select_info($uid, $post);
$softpos_get1=clientidf($uid,'softpos_setting');
if(isset($softpos_get1)&&is_array($softpos_get1))
	$post=array_merge($post,$softpos_get1);


// For Check Page view Permission
if($is_admin==false){
	include_once $data['Path'].'/include/qr-code-request'.$data['iex'];
}

if(!isset($post['step']) || !$post['step'])$post['step']=1;

$post['add_titileName']="Generate New ";
###############################################################################

// for store list
$where_pred=" AND (`active` IN (1) ) ";
$data['Store']=select_terminals($uid, 0, false, 0,$where_pred);
$data['store_size']=(count($data['Store']));
###############################################################################

// Function for send mail with attached pdf
function sent_qr_code_email($name, $email, $tableid ){
	global $data;
	$doc_path=$data['USER_FOLDER']."/qr-code-pdf".$data['ex']."?bid=".base64_encode($tableid);	//set PF path

	$post['fullname']=$name;
	$post['email']= $email;
	$post['bussiness_url']=$doc_path;

	if($tableid) send_email('SEND-QR-CODE',$post);	//send email
}

$adm_action='';
if(isset($post['gid'])&&$post['gid']&&isset($_GET['admin'])&&$_GET['admin']) 
	$adm_action = '&id='.$post['gid'].'&admin=1';

//update profile pic path
if(isset($_POST['profile_update']))
{
	db_query("UPDATE `{$data['DbPrefix']}softpos_setting` SET `profile_pic`='{$_POST['profile_pic']}' WHERE `id`='{$_POST['qrid']}'",0);							
	$pst['tableid']=$_POST['qrid'];
	$_SESSION['action_success']='Profile Image Updated';
	header("location:{$data['USER_FOLDER']}/qr-code".$data['ex']."?qrid=".$pst['tableid']."&action=display{$adm_action}");exit;
}

//for share Qr Code on Mail 
if(isset($_POST['send_mail'])){
	// Function for sent mail with attached define self page
	sent_qr_code_email($_REQUEST['pay_email'],$_REQUEST['pay_email'],$_REQUEST['qrid']); // Pass Name,Email,tableid

	
	$_SESSION['action_success']='QR Code Sent on Email ';
	$pst['tableid']=$_REQUEST['qrid'];
	
	
	$str= "{$data['USER_FOLDER']}/qr-code".$data['ex']."?qrid=".$pst['tableid']."&action=display{$adm_action}";
	?>
	<script>
	window.location.href='<?=$str;?>';
	</script>
	<?
	exit;
	header("location:{$data['USER_FOLDER']}/qr-code".$data['ex']."?qrid=".$pst['tableid']."&action=display{$adm_action}");exit;
}

//initially set clients detail none
$data['mem_det'] = 'style="display:none"';

if(isset($_POST['send'])||(isset($_POST['action'])&&$_POST['action']=='product')){
	$parameters=array();

	if(isset($post['step'])&&$post['step']==1){
		$post['step']++;
	}elseif(isset($post['step'])&&$post['step']==2){
		
		if(!isset($post['bid'])||!$post['bid']) $valid_req = true;
		else $valid_req = false;
		
		$data['mem_det'] = '';					//open clients's detail section
		
		if((!isset($post['softpos_terNO'])||!$post['softpos_terNO'])&&$valid_req){
			$data['Error']='Website should not be empty.';
		}elseif((!isset($post['product_name'])||!$post['product_name'])){
			$data['Error']='QR Code Title should not be empty.';
		}elseif((!isset($post['vpa'])||!$post['vpa'])&&$valid_req){
			$data['Error']='VPA should not be empty.';
		}elseif((!isset($post['qr_fullname'])||!$post['qr_fullname'])&&$valid_req){
			$data['Error']='Full name should not be empty.';
		}elseif((!isset($post['qr_email'])||!$post['qr_email'])&&$valid_req){
			$data['Error']='Email should not be empty.';
		}elseif((!isset($post['merchantAddressLine'])||!$post['merchantAddressLine'])&&$valid_req){
			$data['Error']='Address should not be empty.';
		}
	
		elseif((!isset($post['merchantCity'])||!$post['merchantCity'])&&$valid_req){
			$data['Error']='City should not be empty.';
		}elseif((!isset($post['merchantState'])||!$post['merchantState'])&&$valid_req){
			$data['Error']='State should not be empty.';
		}elseif((!isset($post['merchantPinCode'])||!$post['merchantPinCode'])&&$valid_req){
			$data['Error']='PinCode should not be empty.';
		}
	
		elseif((!isset($post['mobileNumber'])||!$post['mobileNumber'])&&$valid_req){
			$data['Error']='Mobile Number should not be empty.';
		}elseif((!isset($post['panNumber'])||!$post['panNumber'])&&$valid_req){
			$data['Error']='Pan Number should not be empty.';
		}elseif((!isset($post['settlementAcSameAsParent'])||!$post['settlementAcSameAsParent'])&&$valid_req){
			$data['Error']='Settlement type should not be empty.';
		}
		else{
			$json_value = array();
			if(!isset($post['bid'])||!$post['bid']){
				$validate=true;
				$acquirerIDsList	= select_tablef("`id`='{$post['softpos_terNO']}'",'terminal',0,1,'acquirerIDs');
				$acquirerIDs		= $acquirerIDsList['acquirerIDs'];

				if(empty($acquirerIDs)) 
				{
					$data['Error']="No acquirer exists";
					$validate=false;
				}
				else
				{
					$bank_g = select_tablef("`acquirer_id` iN ({$acquirerIDs}) AND `channel_type`='10'",'acquirer_table',0,1,'`acquirer_processing_creds`, `mer_setting_json`,`acquirer_id`, `acquirer_prod_mode`');


					if(isset($bank_g)&&$bank_g)
					{
						if(isset($post['vpa'])&&strpos($post['vpa'],'@icici') !== false)
						{
							$post['vpa'] = str_replace('.lp@icici','',$post['vpa']);
							$post['vpa'] = str_replace('@icici','',$post['vpa']);
						}
						$acquirer_id		= $bank_g['acquirer_id'];
						$acquirer_prod_mode	= $bank_g['acquirer_prod_mode'];
						$acquirer_processing_creds		= json_decode($bank_g['acquirer_processing_creds'],1);

						if($acquirer_prod_mode==1)	$siteid_set	= $acquirer_processing_creds['live'];
						else					$siteid_set	= $acquirer_processing_creds['test'];
						//print_r($siteid_set);

						$siteid_get['apiKey']		= @$siteid_set['apiKey'];
						$siteid_get['merchantId']	= @$siteid_set['merchantId'];
						$siteid_get['terminalId']	= @$siteid_set['terminalId'];
						$siteid_get['payerAccount']	= @$siteid_set['payerAccount'];
						$siteid_get['payerIFSC']	= @$siteid_set['payerIFSC'];
						$siteid_get['dmo_url']		= @$siteid_set['dmo_url'];
						
						##### ICICI DMO - START ########
						$postDataDMO = array();
						$postDataDMO['parentMerchantID']		=$siteid_get['merchantId'];
						$postDataDMO['merchantTerminalId']		=$siteid_get['terminalId'];
						$postDataDMO['accountNumber']			=$siteid_get['payerAccount'];
						$postDataDMO['ifscCode']				=$siteid_get['payerIFSC'];
		
						$postDataDMO['merchantType']			="ENTITY";
				
						$postDataDMO['merchantAliasName']		=@$post['qr_fullname'];
						$postDataDMO['merchantAddressLine']		=@$post['merchantAddressLine'];
						$postDataDMO['merchantCity']			=@$post['merchantCity'];
						$postDataDMO['merchantState']			=@$post['merchantState'];
						$postDataDMO['merchantPinCode']			=@$post['merchantPinCode'];
						$postDataDMO['mobileNumber']			=isMobileValid($post['mobileNumber']);
						$postDataDMO['panNumber']				=@$post['panNumber'];
						$postDataDMO['emailID']					=@$post['qr_email'];
				
						if(!isset($post['vpa_ext'])||empty($post['vpa_ext'])) $post['vpa_ext']=".lp@icici";

					//	$postDataDMO['virtualAddress']			=strtolower($post['vpa']).".lp@icici";
						$postDataDMO['virtualAddress']			=strtolower($post['vpa']).$post['vpa_ext'];
		
						$postDataDMO['onlineRefund']			="Y";
						$postDataDMO['smsNotifications']		="N";
						$postDataDMO['directPush']				="Y";//"N";
						$postDataDMO['merchantGenre']			="ONLINE";
						$postDataDMO['settlementAcSameAsParent']=(isset($siteid_get['settlementAcSameAsParent'])?(string)$siteid_get['settlementAcSameAsParent']:'Y');
						$postDataDMO['channel']					="EAZYPAY";

						$fp = fopen($data['Path'].'/payin/merchant-qr/Skywalk_PublicCerti.crt', 'r');

						$pub_key= fread($fp, 8192);
						fclose($fp);
				
						$RANDOMNO1 = "1212121234483448";
						$RANDOMNO2 = '1234567890123456';
						
						openssl_get_publickey($pub_key);
						
						openssl_public_encrypt($RANDOMNO1, $encrypted_key, $pub_key);
						$encrypted_data = openssl_encrypt(json_encode($postDataDMO), 'AES-128-CBC', $RANDOMNO1, OPENSSL_RAW_DATA, $RANDOMNO2);
						
						$reference=create_transaction_id($uid);
						$postbody= [
							"requestId" => $reference,
							"service" => "",
							"encryptedKey" => base64_encode($encrypted_key),
							"oaepHashingAlgorithm" => "NONE",
							"iv" => base64_encode($RANDOMNO2),
							"encryptedData" => base64_encode($encrypted_data),
							"clientInfo" => "",
							"optionalParam" => ""
						];
						
						$apiKey	= $siteid_get['apiKey'];
						$headers= array(
							"content-type: application/json", 
							"apikey:$apiKey"
						);
						
						$file = 'composite_log.txt';
						
						$log = "\n\nGUID - ".$reference."===========================\n";
						$log.= 'URL - '.$siteid_get['dmo_url']."\n\n";
						$log.= 'HEADER - '.json_encode($headers)."\n\n";
						$log.= 'REQUEST - '.json_encode($postDataDMO)."\n\n";
						$log.= 'REQUEST ENCRYPTED - '.json_encode($postbody)."\n\n";
						#$url=$siteid_get['dmo_url'];
						
						$curl = curl_init(@$url);
						curl_setopt($curl, CURLOPT_URL, $siteid_get['dmo_url']);
						curl_setopt($curl, CURLOPT_POST, true);
						curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
						curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
						curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($postbody));
						
						$raw_response = curl_exec($curl);
						$httpcode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
						$err = curl_error($curl);
						curl_close($curl);
						
						$request = json_decode($raw_response);
				
						$fp= fopen($data['Path'].'/payin/merchant-qr/live_privatekey.key',"r");
				
						$priv_key=fread($fp,4096);
						fclose($fp);
						$res = openssl_get_privatekey($priv_key, "");
						openssl_private_decrypt(base64_decode(@$request->encryptedKey), $key, $res);
						$encData	= base64_decode(@$request->encryptedData); 
						$encData	= openssl_decrypt(@$encData,"aes-128-cbc",$key,OPENSSL_PKCS1_PADDING);
						
						$newsource	= substr($encData, 16); 
						
						$log.= "\n\nGUID - ".$reference."==================================\n";
						$log.= "RESPONSE - ".$raw_response."\n\n";
						$log.= "RESPONSE DECRYPTED - ".$newsource."\n\n";

						//echo nl2br($log);exit;

						$response = json_decode($newsource,1);

						if(@$response['success']=="true")
						{
							$json_value['reference']		=$reference;
							$json_value['siteid_get']		=$siteid_get;
							$json_value['dmo_request']		=$postDataDMO;
							$json_value['dmo_response']		=$response;
							$json_value['eazypayMerchantID']=$response['eazypayMerchantID'];

							$validate=true;
						}
						else
						{
							if(isset($response['ActCode'])&&($response['ActCode'])||isset($response['message'])&&($response['message']))
								$data['Error']= $response['ActCode']. ' - '.$response['message'];
							else $data['Error']= $raw_response;
							
							$validate=false;
						}
						// dmo endpoint end
						##### ICICI DMO - END ########
					}
					else
					{
						$data['Error']="QR code not active";
						$validate=false;
					}
				}
				//$validate=1;
				if($validate)
				{
					$sqlStmt="INSERT INTO `{$data['DbPrefix']}softpos_setting`(".
				"`clientid`,`sub_merchantId`,`vpa`,`qr_fullname`,`qr_email`,`product_name`,`merchantAddressLine`,`merchantCity`,`merchantState`,`merchantPinCode`,`mobileNumber`,`panNumber`,`settlementAcSameAsParent`,`profile_pic`,`currency`,`softpos_terNO`,`softpos_status`,`json_value`".
					")VALUES(".	
					"'$uid','{$json_value['eazypayMerchantID']}','".encode_f($postDataDMO['virtualAddress'])."','{$post['qr_fullname']}','".encrypts_decrypts_emails($post['qr_email'],1)."','{$post['product_name']}','{$post['merchantAddressLine']}','{$post['merchantCity']}','{$post['merchantState']}','{$post['merchantPinCode']}','{$post['mobileNumber']}','".strtoupper($post['panNumber'])."','{$post['settlementAcSameAsParent']}','{$post['profile_pic']}','{$post['currency']}','{$post['softpos_terNO']}','1','".json_encode($json_value)."')";
					
					// remove `acquirer_id`, ,'{$acquirer_id}'

					//echo $sqlStmt;exit;
					db_query($sqlStmt,0);
	
					$related_id=newid();
	
					$pst['tableid']=$related_id;
					json_log_upd($pst['tableid'],'softpos_setting','Insert');
					$_SESSION['action_success']='QR Code Generated';
					$post['step']=3;
					header("location:{$data['USER_FOLDER']}/qr-code".$data['ex']."?qrid=".$pst['tableid']."&action=display{$adm_action}");exit;
				}
			} else {
				//$sqlStmt = "UPDATE `{$data['DbPrefix']}softpos_setting` SET ".								"`qr_fullname`='{$post['qr_fullname']}',`qr_email`='".encrypts_decrypts_emails($post['qr_email'],1)."',`profile_pic`='{$post['profile_pic']}',`product_name`='{$post['product_name']}',`currency`='{$post['currency']}',`merchantAddressLine`='{$post['merchantAddressLine']}',`merchantCity`='{$post['merchantCity']}',`merchantState`='{$post['merchantState']}',`merchantPinCode`='{$post['merchantPinCode']}',`mobileNumber`='{$post['mobileNumber']}' WHERE `id`='{$post['bid']}'"; 

				$sqlStmt = "UPDATE `{$data['DbPrefix']}softpos_setting` SET `product_name`='{$post['product_name']}',`profile_pic`='{$post['profile_pic']}' WHERE `clientid`={$uid} AND `id`='{$post['bid']}'"; 

				db_query($sqlStmt,0);

				$pst['tableid']=$post['bid'];
				json_log_upd($pst['tableid'],'softpos_setting','Update'); // Json Log History for Update
				$_SESSION['action_success']='QR Code Updated and Sent Your Email';
				//====================================
				sent_qr_code_email($post['qr_fullname'],$post['qr_email'],$pst['tableid']); // Pass Name,Email,tableid
				header("location:{$data['USER_FOLDER']}/qr-code".$data['ex']."?qrid=".$pst['tableid']."&action=display{$adm_action}");exit;
			}
			//====================================		
		}
		//exit;
	}
}

if(isset($post['action'])&& ( $post['action']=='update' || $post['action']=='display') ){

	$id = isset($post['bid'])&&$post['bid']?$post['bid']:'';
	if($post['action']=='display'){ $id =$_GET['qrid']; }

	$post['add_titileName']	='Update';
	$post['field_disable']	='none';

	$qrcode=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}softpos_setting`".
		" WHERE `clientid`={$uid} AND `id`={$id} LIMIT 1",0
	);
	
	$post=array_merge($post,$qrcode[0]);

	if($post['action']!='display'){	
		$post['actn']='update';
		$post['step']++;
	}
}elseif(isset($post['action'])&&$post['action']=='delete'){
	$bid = $post['bid'];

	db_query(
		"UPDATE `{$data['DbPrefix']}softpos_setting`".
		"SET `softpos_status`=2 WHERE `clientid`={$uid} AND `id`={$bid}"
	);
	json_log_upd($bid,'softpos_setting','Delete'); // Json Log History for Delete
	$_SESSION['action_success']='QR Code Deleted';
	header("location:{$data['USER_FOLDER']}/qr-code".$data['ex']."?{$adm_action}");exit;
}

if(isset($post['step'])&&$post['step']==1){

	//added by vikash			
	$result_select=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}softpos_setting`".
		" WHERE `clientid`={$uid}".
		(isset($primary)?" AND `primary`='{$primary}'":'').
		(isset($confirmed)?" AND `active`='{$confirmed}'":'').
		" AND `softpos_status`<> '2' ORDER BY `id` DESC",0
	);
	$data['selectdatas'] = $result_select;

	$cntdata=count($data['selectdatas']);
	if($cntdata==0){
		//$post['step']=2;
	}
}


###############################################################################
display('user');
###############################################################################
?>