<?
###############################################################################

$data['PageName']='Edit Your Two Factor Authentication';
$data['PageFile']='two-factor-authentication'; 
$data['PageFiles'][]=$data['PageFile']; 
###############################################################################
if(!isset($data['DISPLAY_MULTI'])){
	include('../config.do');
}
$data['PageTitle'] = 'Two Factor Authentication - '.$data['domain_name']; 
###############################################################################
if(!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}
###############################################################################
$post=select_info($uid, $post);
$data['InfoIsEmpty']=is_info_empty($uid);
###############################################################################

// Call page without header and footer page
if(isset($_GET['HideAllMenu'])&&$_GET['HideAllMenu']){
// echo $_GET['HideAllMenu'];
 $data['HideAllMenu']=true;
 $redirect_type="modal_js";
}
###############################################################################


if(isset($post['change2way'])&&$post['change2way']){
	if(!passwordCheck($uid,$post['currentPassword'])){
		 $data['Error']='You entered wrong password.';
	} 
	else{
		$twoGmfa=twoGmfa(0,$uid,$post['google_auth_access']);
		//echo "<br/>twoGmfa=><br/>"; 
		//echo $twoGmfa['secret'];
		//echo $twoGmfa['qrCodeUrl'];
		
		//exit;
		
		$_SESSION['mer_qrCodeUrl']=$twoGmfa['qrCodeUrl'];
		$_SESSION['mer_secret']=$twoGmfa['secret'];
		
		if($post['google_auth_access']==1||$post['google_auth_access']==3){

			$msg_mfa="Great... You have successfully Activated 2 Factor Authentication (2FA) for your account. Check your email (\"<b>".encrypts_decrypts_emails($post['email'],2,1)."</b>\") for further instructions.";
		}else{
			$msg_mfa="2 Factor Authentication (2FA) has been Deactivated. Your account is not secure anymore."; // Are you sure you want to Deactivate 2FA for your account?
		}
		
		$_SESSION['action_success']=$msg_mfa;
		header("Location:".$data['USER_FOLDER']."/".($data['DISPLAY_MULTI']?$data['DISPLAY_MULTI']:$data['PageFile']).$data['ex']);exit;
	}
}// End if Change2way
###############################################################################
if(!isset($data['DISPLAY_MULTI'])){
	display('user');
}
###############################################################################
?>
