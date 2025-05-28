<?
###############################################################################
$data['PageName']='E-Mails';
$data['PageFile']='emails';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'My Emails - '.$data['domain_name'];
###############################################################################
##########################Check Permission#####################################
if(isset($_SESSION['m_clients_role'])&&isset($_SESSION['m_clients_type'])&&!clients_page_permission('1',$_SESSION['m_clients_role'],$_SESSION['m_clients_type']))
{ 
	header("Location:{$data['Host']}/index".$data['ex']);exit; 
}
###############################################################################
if((!isset($_SESSION['adm_login']) || !$_SESSION['adm_login'])&&(!isset($_SESSION['login'])&&!$_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}
$is_admin=false;
if(isset($_SESSION['adm_login'])&&$_SESSION['adm_login']&&isset($_GET['admin'])&&$_GET['admin']){
	$is_admin=true;
	$data['HideAllMenu']=true;
	$uid=$_GET['id'];
	$_SESSION['login']=$uid;
}
###############################################################################
if(is_info_empty($uid)&&$is_admin==false){
	header("Location:{$data['Host']}/user/profile".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

$post=select_info($uid, $post);
//$uid=$post['id'];
###############################################################################

if (!isset($_SESSION['token_email'])) {
    $_SESSION['token_email'] = md5(uniqid(rand(), TRUE));
    $_SESSION['token_email_time'] = time();
}

/*
if(isset($_SERVER['HTTP_REFERER'])){
	echo "<br/><br/>token_email=>".$_SESSION['token_email'];
	echo "<br/><br/>urlpath=>".$data['urlpath'];
	echo "<br/><br/>HTTP_REFERER=>".$_SERVER['HTTP_REFERER'];
	if(strpos($_SERVER['HTTP_REFERER'],'/emails')===false){ 
		echo "<br/><br/>Account Takeover due to Cross-site request forgery (CSRF)";
	}
	if(isset($_POST)){
		exit;
	}
}
*/

if(isset($post['addnow'])&&$post['addnow']) {
	
	if(!isset($post['token'])||empty($post['token'])){ 
		$data['error']="Token not empty due to Cross-site request forgery (CSRF)";
	}
	elseif($_SESSION['token_email']!=$post['token']){ 
		$data['error']="Token mismatch due to Cross-site request forgery (CSRF)";
	}
	elseif(strpos($_SERVER['HTTP_REFERER'],'/emails')===false){ 
		$data['error']="Account Takeover due to Cross-site request forgery (CSRF)";
	}
	else{
	
		$result=add_email($uid,$post['newmail'],$is_admin);

		if (empty($post['newmail'])) $data['error']="You did not write the e-mail address.";
		elseif($result=='INVALID_EMAIL_ADDRESS') $data['error']="The e-mail address you entered is invalid.";
		elseif($result=='EMAIL_EXISTS') $data['error']="The e-mail address you entered is in use in the system.";
		elseif($result=='TOO_MANY_EMAILS') $data['error']="You cannot add more than {$data['maxemails']} e-mail addresses";
		elseif($result=='DB_ERROR') $data['error']="Duplicate Email ID / A temporary error occured, please try again later";

     
	/* get the confirmation code from the url (link in email)*/
		if(isset($is_admin)&&$is_admin==true){
			echo "<script>
			 top.window.location.href='{$data['Admins']}/merchant{$data['ex']}?id={$_GET['id']}&action=detail';
			</script>";
		}elseif($result=='SUCCESS'){
		
		    $_SESSION['msgaddnow']="Email Added Successfully";
			header("Location:{$data['USER_FOLDER']}/emails".$data['ex']);exit;
		}else{
	    
		    $_SESSION['msgerror']=$data['error'];
			header("Location:{$data['USER_FOLDER']}/emails".$data['ex']);exit;
		}
	}
}elseif(isset($_GET['c'])) {
	$code=$_GET['c'];
	$uid=$_GET['u'];
	$result=activate_email($uid,$code);
	if ($result=='CONFIRMATION_NOT_FOUND') $data['error']="No such pending confirmation to proceed.";
	unset($_GET);
}
elseif(isset($_REQUEST['primbtn'])&&$_REQUEST['primbtn']) {

if(isset($_REQUEST['token'])&&$_REQUEST['token']){ $post['token']=$_REQUEST['token']; }
if(isset($_REQUEST['choice'])&&$_REQUEST['choice']){ $post['choice']=$_REQUEST['choice']; }

	if(!isset($post['token'])||empty($post['token'])){ 
		$data['error']="Token not empty due to Cross-site request forgery (CSRF)";
	}
	elseif($_SESSION['token_email']!=$post['token']){ 
		$data['error']="Token mismatch due to Cross-site request forgery (CSRF)";
	}
	elseif(strpos($_SERVER['HTTP_REFERER'],'/emails')===false){ 
		$data['error']="Account Takeover due to Cross-site request forgery (CSRF)";
	}
	else{
		$result=make_email_prim($uid,"",@$post['choice']);
		json_log_upd($post['choice'],'clients_emails');
		
		if (empty($post['choice'])) $data['error']="You did not select an e-mail address";	
		elseif($result=='INVALID_EMAIL_ADDRESS') $data['error']="The e-mail address you selected is invalid.";
		elseif($result=='ALREADY_PRIMARY') $data['error']="The e-mail address you selected is already your primary address.";
		elseif($result=='EMAIL_NOT_ACTIVE') $data['error']="The e-mail address you selected is not active, please activate it and re-try.";
		elseif($result=='EMAIL_NOT_FOUND') $data['error']="The e-mail address you selected is not found in the system.";
		
		if(isset($is_admin)&&$is_admin==true){
			if($result=='SUCCESS'){
		    	$_SESSION['success']='Your default e-mail address has been sucessfully changed!';
			}
			echo "<script>
			 top.window.location.href='{$data['Admins']}/merchant{$data['ex']}?id={$_GET['id']}&action=detail';
			</script>";
		}elseif($result=='SUCCESS'){
		    $_SESSION['msgprimbtn']="change";
			$_SESSION['success']='Your default e-mail address has been sucessfully changed!';
			header("Location:{$data['USER_FOLDER']}/emails".$data['ex']);exit;
		}
	}
}elseif(isset($_REQUEST['deletebtn'])&&$_REQUEST['deletebtn']) {
    
    if(isset($_REQUEST['token'])&&$_REQUEST['token']){ $post['token']=$_REQUEST['token']; }
    if(isset($_REQUEST['choice'])&&$_REQUEST['choice']){ $post['choice']=$_REQUEST['choice']; }

	if(!isset($post['token'])||empty($post['token'])){ 
		$data['error']="Token not empty due to Cross-site request forgery (CSRF)";
	}
	elseif($_SESSION['token_email']!=$post['token']){ 
		$data['error']="Token mismatch due to Cross-site request forgery (CSRF)";
	}
	// $_SERVER['HTTP_REFERER'] not get on Android App Case
	elseif(!empty($_SERVER['HTTP_REFERER']) && strpos($_SERVER['HTTP_REFERER'],'/emails')===false){ 
		$data['error']="Account Takeover due to Cross-site request forgery (CSRF)";
	}
	else{
		
		$result=delete_clients_email($uid,@$post['choice']);

		if (!isset($post['choice'])||empty($post['choice'])) $data['error']="You did not select an e-mail address";	
		elseif($result=='INVALID_EMAIL_ADDRESS') $data['error']="The e-mail address you selected is invalid.";
		elseif($result=='EMAIL_NOT_FOUND') $data['error']="The e-mail address you selected is not found in the system.";
		elseif($result=='CANNOT_DELETE_PRIMARY') $data['error']="You cannot delete the primary e-mail address.";
		
		if(isset($is_admin)&&$is_admin==true){
			echo "<script>
			 top.window.location.href='{$data['Admins']}/merchant{$data['ex']}?id={$_GET['id']}&action=detail';
			</script>";
		}elseif($result=='SUCCESS'){
		    $_SESSION['msgaddnow']="";
		    $_SESSION['msgdeletebtn']="Email Delete Successfully";
			header("Location:{$data['USER_FOLDER']}/emails".$data['ex']);exit;
		}
		
	}
}
$data['emails']=get_email_details($uid, false, false);
###############################################################################
display('user');
###############################################################################
?>