<?
###############################################################################
$data['PageName']='Reset Password';
$data['SubHeading1']='Reset Password';
$data['ROOT_USER']='reset_password';
//$data['PageFile']='forgot'; 
$data['IsLogin']=true;
$data['HideMenu']=true;
$data['HideAllMenu']=true;
###############################################################################


###############################################################################
if(!isset($data['PageName'])||empty(trim($data['PageName'])))$data['PageName']='Reset Password';
if(!isset($data['SubHeading1'])||empty(trim($data['SubHeading1'])))$data['SubHeading1']='Password';
$data['PageFile']='forgot'; 
$data['IsLogin']=true;
$data['HideMenu']=true;
$data['HideAllMenu']=true;
###############################################################################



include('config.do');
if(!isset($data['PageTitle'])||empty(trim($data['PageTitle'])))$data['PageTitle'] = $data['PageName'].' - '.$data['domain_name'];
if(!isset($post['step']) || !$post['step']) $post['step']=1;
if(isset($data['loginSingForgot'])&&$data['loginSingForgot']=="disable"){
	echo $data['loginSingForgotMsg'];
	exit;
}
$reset_password=0;
if(isset($data['PRO_VER'])&&$data['PRO_VER']==3){
	$reset_password=1;
}
if(isset($data['ROOT_USER'])&&$data['ROOT_USER']=='reset_password'){
	$reset_password=1;
}
			
			
if(isset($_GET['sd']) && $_GET['sd']){
$_SESSION['action_sent_success']=null;
}

if(isset($_POST['email'])&&!isset($_POST['registered_email'])){
	$post['registered_email']=$_POST['registered_email']=$_POST['email'];
}

###############################################################################

$turl= $_SERVER['REQUEST_URI'];
if (strpos($turl, 'signins')>0 || isset($data['ROOT_PASSWORD'])&&trim($data['ROOT_PASSWORD']) ) {$tbl="subadmin";} else {$tbl='clientid_table';}

###############################################################################
$domain_server=domain_serverf("","merchant");
//$domain_server=domain_serverf("checkdebit.net","merchant");
$_SESSION['domain_server']=$domain_server;
$domain_server=$_SESSION['domain_server'];
$refeneceId=3;
if($domain_server['STATUS']==true){
	$refeneceId=$domain_server['sub_id'];
}

if(!isset($_SESSION['token_forgot'])){
    $_SESSION['token_forgot'] = md5(uniqid(rand(), TRUE));
    $_SESSION['token_forgot_time'] = time();
}

$http_referer_validation=true;
if(isset($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
	$http_referer_validation=false;
}
	
###############################################################################

$json_action=false; $curl_validation=false;


if(isset($post['send']) && $post['send']=='sendbycurl'){
	$json_action=true;
	$curl_validation=true;
	
}

if(isset($uid)) $post['clientid']= $uid;

if(isset($post['registered_email'])) $post['registered_email']=trim($post['registered_email']); else $post['registered_email']='';

if(isset($post['cancel'])&&$post['cancel']){
	if($_SESSION['registered_email']){
		$post['registered_email']=$_SESSION['registered_email'];
		unset($_SESSION['registered_email']);
	}
	(int)$post['step']--;
}elseif(isset($post['send']) && $post['send']){
	if($post['step']==1){
	//	if(!$post['registered_email']||verify_email($post['registered_email'])){
		if(!$post['registered_email']){
			$data['Error']='Invalid User Name.';
			$pra['Error']=$data['Error'];
			if($json_action == true) {
				json_print($pra);
			}
		}elseif(empty($post['token'])){ 
			$data['Error']="Token not empty due to Cross-site request forgery (CSRF)";
			$pra['Error']=$data['Error'];
			if($json_action == true) {
				json_print($pra);
			}
		}
		elseif($_SESSION['token_forgot']!=$post['token']){ 
			$data['Error']="Token mismatch due to Cross-site request forgery (CSRF)";
			$pra['Error']=$data['Error'];
			if($json_action == true) {
				json_print($pra);
			}
		}
		/*elseif((strpos($_SERVER['HTTP_REFERER'],'/forgot')===false||strpos($_SERVER['HTTP_REFERER'],'/reset-password')===false)&&($http_referer_validation == true)){ 
			$data['Error']="Account Takeover due to Cross-site request forgery (CSRF)";
			$pra['Error']=$data['Error'];
			if($json_action == true) {
				json_print($pra);
			}
		}*/elseif(!get_clients_id($post['registered_email'],'', '',false,$tbl)){
			$data['Error']='User Name not found.';
			$pra['Error']=$data['Error'];
			if($json_action == true) {
				json_print($pra);
			}
		}elseif(!is_clients_active($post['registered_email'],$tbl)){
                $data['Error']='This user was not found in the system. Or is inactive, banned or closed.';
				$pra['Error']=$data['Error'];
				if($json_action == true) {
					json_print($pra);
				}
        }elseif((!is_sponsor_clients($post['registered_email'],$refeneceId)) && ($data['localhosts']==false)){
                $data['Error']='This user was not found in the system.';
				$pra['Error']=$data['Error'];
				if($json_action == true) {
					json_print($pra);
				}
        }else{
			
			$restorePassword=1; $daily_password_count='';
			
			$_SESSION['registered_email']=trim(str_replace("  ", " ", $post['registered_email']));
			
			$userId = get_clients_id($post['registered_email'],'', '',false,$tbl);
			$info 	= select_client_table($userId,$tbl);
			
			$daily_password_count_info=$info['daily_password_count'];
			$daily_password_count_info=json_decode($daily_password_count_info,1);
			
			//print_r($daily_password_count_info);
			
			if($daily_password_count_info&&$daily_password_count_info['date']&&$daily_password_count_info['count']){
				$dp_date=$daily_password_count_info['date'];
				$dp_count=(int)$daily_password_count_info['count'];
				
				if(($dp_count<5)&&(date('Ymd')==date('Ymd',strtotime($dp_date)))){
					
					$dp_count=$dp_count+1;
					
				}elseif(($dp_count>4)&&(date('Ymd')==date('Ymd',strtotime($dp_date)))){
					$restorePassword=0;
					$data['Error']='Oops daily limit 5 on your mid';
					$pra['Error']=$data['Error'];
					if($json_action == true) {
						json_print($pra);
					}
				}else{
					$dp_date=date('Y-m-d H:i:s');
					$dp_count='1';
				}
				
				
				$daily_password_count_json['date']=$dp_date;
				$daily_password_count_json['count']="{$dp_count}";
				$daily_password_count_json=json_encode($daily_password_count_json);
				$daily_password_count=" ,`daily_password_count`='{$daily_password_count_json}' ";
			}else{
				$daily_password_count_json['date']=date('Y-m-d H:i:s');
				$daily_password_count_json['count']='1';
				$daily_password_count_json=json_encode($daily_password_count_json);
				$daily_password_count=" ,`daily_password_count`='{$daily_password_count_json}' ";
			}
			
			if($restorePassword==1){
				//generate new random password and update into DB
				$newpassword=generate_password(10);
				$hash_password=hash_f($newpassword);
				
				//$info=get_clients_by_email($_SESSION['registered_email']);
				
				
				
				
				
				if($reset_password==1){
					$query_upd="";
					//[confcode]
					$post['ccode']=$post['confcode']=encode_f($info['id'],0);
					$_SESSION['s_ccode']=$post['ccode'];
				}else{
					$query_upd=" `password`='{$hash_password}', ";
				}
				
				// update password into DB;
				//$tbl='clientid_table';
				
				db_query("UPDATE `{$data['DbPrefix']}{$tbl}` SET ".
				$query_upd.	
				"`password_updated_date`=now()".$daily_password_count.
				" WHERE `id`={$info['id']}"
				);
				
				// Hide registered_email address
				$info['registered_email'] = encrypts_decrypts_emails(trim($info['registered_email']),2);
				
				$_SESSION['memail']=mask_email($info['registered_email']);
				
				/*
				$str=trim($info['registered_email']); 
				$length= strlen($str);
				$f1=strpos ($str,'@');
				$s1=substr($str, 0, 2);
				$s2=substr($str, ($f1-2), $length);
				$_SESSION['memail']=$s1."****".$s2;
				*/
				
				//$_SESSION['memail']=$info['registered_email'];
				$post['registered_email']=($info['registered_email']);
				$_SESSION['cemail']=($info['registered_email']); // for resend registered_email
				//$post['password']=$info['password'];
				$post['password']=$newpassword;
				$post['username']=$info['username'];
				$_SESSION['cusername']=$info['username']; // for resend registered_email
				if(isset($info['fullname'])&&$info['fullname'])	//if fullname exist then use fullname
					$post['fullname']==$info['fullname'];
				else	//if fullname not exists then concat fname and lname
				$post['fullname']=$info['fname']." ".$info['lname'];
				$post['uid']=$info['id'];
				$_SESSION['cuid']=$info['id']; // for resend registered_email
				
				if(empty($post['fullname'])){
					$post['fullname']=$info['username'];
				}
				
				
				$post['tableid']=$post['uid'];
				$post['mail_type']="15";
				$post['email_header']=1;
				$post['email_br']=1;
				
				
				/*
				echo "<hr/>registered_email=>".$post['registered_email'];
				echo "<hr/>password=>".$post['password'];
				echo "<hr/>username=>".$post['username'];
				exit;
				*/
				
				if($reset_password==1){
					send_email('CONFIRM-RESET-PASSWORD', $post);
					$pra['msg']="Success! We have sent a link to generate new password on your registered registered_email in ".$_SESSION['memail'];
					//$_SESSION['action_success']=$pra['msg'];
                    $_SESSION['action_sent_success']=$pra['msg'];
					$redirect_this_url='reset-password';
				}else{
					send_email('RESTORE-PASSWORD', $post);
					$pra['msg']="Success! New password has been sent to registered registered_email ID: ".$_SESSION['memail'];
					$_SESSION['action_success']=$pra['msg'];
					$redirect_this_url='forgot';
				}
				
				
				$_SESSION['token_forgot'] = md5(uniqid(rand(), TRUE));
				$_SESSION['token_forgot_time'] = time();
	
	
				(int)$post['step']++;
				
				
				
				//$_SESSION['action_success']=$pra['msg'];
			}
			
			
			
			if($json_action == true) {
				json_print($pra);exit;
			}elseif(!$data['Error']){
				header("Location:".$data['Host']."/".$redirect_this_url.$data['ex']);exit;
			}
			
		}
	}elseif($post['step']==5){
		$info=get_clients_by_email($_SESSION['registered_email']);
		if(!$post['answer']||($post['answer']!=$info['answer'])){
			$data['Error']='Please enter a valid security answer.';
		}else{
			$post['registered_email']=$_SESSION['registered_email'];
			$post['password']=$info['password'];
			send_email('RESTORE-PASSWORD', $post);
			unset($_SESSION['registered_email']);
			(int)$post['step']++;
		}
	}elseif($post['step']==2){
		unset($_SESSION['registered_email']);
		unset($post['step']);
	}
}
###############################################################################
if(isset($_SESSION['registered_email']) && $_SESSION['registered_email']){
	//$info=get_clients_by_email($_SESSION['registered_email']);
	//$post['question']=$info['question']; 
}
###############################################################################
display('user');
###############################################################################
?>
