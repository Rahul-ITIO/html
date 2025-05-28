<?
###############################################################################
$data['PageName']='EDIT YOUR PASSWORD';
$data['PageFile']='password'; 
$data['rootNoAssing']=1;
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Security Information - '.$data['domain_name']; 
###############################################################################

if(!isset($_SESSION['adm_login'])){
	$_SESSION['adminRedirectUrl']=$data['urlpath'];
	header("Location:{$data['Admins']}/login".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

###############################################################################


	$validation=1;
	if(isset($_SESSION['login_adm'])&&$_SESSION['login_adm']){
		$validation=0;
	}
	
	if(!isset($_GET['id'])&&!isset($_SESSION['login_adm'])&&isset($_SESSION['sub_admin_id'])){
		$id=$_SESSION['sub_admin_id'];
	}elseif(isset($_GET['id'])&&$_GET['id']) {
			$id=$_GET['id'];
	}else{
		$id=0;
	}
	
	if($id>0){	
		$result=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}subadmin`".
			" WHERE `id`={$id} LIMIT 1"
		);		
		$clients=$result[0];
		if($clients){
			foreach($clients as $key=>$value)if(!isset($post[$key]))$post[$key]=$value;
		}
	}

###############################################################################

//echo "<br/><br/>password=>";exit;
/*
if($post['change2way']){
	
	
	global $data;
	if($id){
		$qry="select password from `{$data['DbPrefix']}subadmin` where id={$id} limit 1 ";
		$result=db_rows($qry);
		$pass=$result[0]['password'];
	}
	$tbl='subadmin';
	if ((strpos($turl, 'id=')) && ($_SESSION['adm_login']==true)){
			
			update_clients_password($id, $new_password, $previous_passwords, false,$post['google_auth_access'],$tbl);
			
		}else{
		if ($pass!=hash_f($post['currentPassword']))
			{$data['Error']='You entered wrong old password.';}
		else {update_clients_password($id, $new_password, $previous_passwords, false,$post['google_auth_access'],$tbl);}
		}// end if not admin
}// End if Change2way

*/

if(isset($post['change2way'])&&$post['change2way']){
	
	if((!passwordCheck($id,$post['currentPassword'],'subadmin'))&&($validation)){
		 $data['Error']='You entered wrong password.';
	} 
	else{
		
		$twoGmfa=twoGmfa($id,0,$post['google_auth_access']);
		//echo "<br/>change2way=>".$id;echo "<br/>google_auth_access=>".$post['google_auth_access'];exit;
		//echo "<br/>twoGmfa=><br/>"; print_r($twoGmfa);exit;
		if($post['google_auth_access']==1||$post['google_auth_access']==3){
			$msg_mfa="Great... You have successfully Activated 2 Factor Authentication (2FA) for your account. Check your email (\"<b>".mask_email(trim($post['email']))."</b>\") for further instructions.";
		}else{
			$msg_mfa="2 Factor Authentication (2FA) has been Deactivated. Your account is not secure anymore."; // Are you sure you want to Deactivate 2FA for your account?
		}
		
		$_SESSION['action_success']="<strong></strong>  ".$msg_mfa;
		if(isset($_GET)){
			$subqr='?'.http_build_query($_GET);
		}else{
			$subqr='';
		}
		header("Location:".$data['Admins']."/password".$data['ex'].$subqr);exit;
	}
}// End if Change2way
elseif(isset($post['change'])&&$post['change']){
	$password=$_POST['npass'];
	
	//$current_password=hash('sha256', $post['password']);
	$current_password=@$post['password'];
	$old_password=hash_f(@$post['opass']);
	$new_password=hash_f(@$post['npass']);
	/*if ($_SESSION['adm_login']==true){
		$old_password=$post['opass']='1';
		}*/
	
	if(!$post['npass']&&!$post['cpass']){
		$data['Error']='Please enter your old and new password for changing.';
	}elseif((!@$post['opass'])&&($validation)){
		$data['Error']='Please enter your old password.';
	}elseif(!$post['npass']){
		$data['Error']='Please enter your new password.';
	}elseif(strlen($post['npass'])<$data['PassLen']){
		$data['Error']="Your password must be at least {$data['PassLen']} characters long.";
	}elseif($current_password==$new_password){
		$data['Error']='New password should not be same as old password.';
	}elseif(!$post['cpass']){
		$data['Error']='Please re-enter your new password.';
	}
	elseif(!preg_match("#[0-9]+#",$password)) {
        $data['Error'] = "Your Password Must Contain At Least 1 Number";
    }
    elseif(!preg_match("#[A-Z]+#",$password)) {
        $data['Error'] = "Your Password Must Contain At Least 1 Capital Letter";
    }
    elseif(!preg_match("#[a-z]+#",$password)) {
       $data['Error'] = "Your Password Must Contain At Least 1 Lowercase Letter";
    }
	elseif(($current_password!=$old_password)&&($validation)){
		$data['Error']='You entered wrong old password.';
	}elseif($post['npass']!=$post['cpass']){
		$data['Error']='Your password and confirmation should be not different.';
	}elseif($post['username']==$post['npass']){
		$data['Error']='Your password can not be same as your username.';
	}elseif(strpos($post['previous_passwords'],$new_password)!==false){		
		$data['Error']='You can not use your 5 previous password. Kindly choose an unique password';
	}else{
		$post['previous_passwords'];
		$post_pass['prev_pass1']=jsonvaluef($post['previous_passwords'],"prev_pass1");
		$post_pass['prev_pass2']=jsonvaluef($post['previous_passwords'],"prev_pass2");
		$post_pass['prev_pass3']=jsonvaluef($post['previous_passwords'],"prev_pass3");
		$post_pass['prev_pass4']=jsonvaluef($post['previous_passwords'],"prev_pass4");
		$post_pass['prev_pass5']=jsonvaluef($post['previous_passwords'],"prev_pass5");
		
		$npass=hash_f($post['npass']);
		
		if(!$post_pass['prev_pass1']){
			$post_pass['prev_pass1']=$npass;
		}elseif(!$post_pass['prev_pass2']){
			$post_pass['prev_pass2']=$npass;
		}elseif(!$post_pass['prev_pass3']){
			$post_pass['prev_pass3']=$npass;
		}elseif(!$post_pass['prev_pass4']){
		$post_pass['prev_pass4']=$npass;
		}elseif(!$post_pass['prev_pass5']){
		$post_pass['prev_pass5']=$npass;
		}elseif($post_pass['prev_pass5']){
			$post_pass['prev_pass1']=$post_pass['prev_pass2'];
			$post_pass['prev_pass2']=$post_pass['prev_pass3'];
			$post_pass['prev_pass3']=$post_pass['prev_pass4'];
			$post_pass['prev_pass4']=$post_pass['prev_pass5'];
			$post_pass['prev_pass5']=$npass;
		}	
		$previous_passwords=json_encode($post_pass);
		
		
		$tbl='subadmin';
		$new_password=$npass;
		
		if(isset($_GET['dtest'])){
			echo "<br/>_POST npass=>".$_POST['npass'];
			echo "<br/>npass=>".$post['npass'];
			echo "<br/>new_password=>".$new_password;
			//exit;
		}
		
		update_clients_password($id, $new_password, $previous_passwords, false,$post['google_auth_access'],$tbl);
		//update_clients_question($uid, $post['question'], $post['answer']);
		$data['PostSent']=true;
		
	}
}
###############################################################################
display('admins');
###############################################################################
?>