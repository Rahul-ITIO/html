<?
$data['PageName']='EDIT USER PASSWORD';
$data['PageFile']='passwordreset'; 
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
if(isset($post['send'])||isset($_GET['bid'])){
	
	
	//Get user details
	if(isset($_GET['bid'])&&!empty($_GET['bid'])){
		$info= select_client_table($_GET['bid']);
		$post['username']=$info['username'];
		$post['uid']=$info['id'];
		
		if(isset($info['fullname'])&&$info['fullname'])	//if fullname exist then use fullname
			$fullname=$info['fullname'];
		else	//if fullname not exists then concat fname and lname
			$fullname=$info['fname'].' '.$info['lname'];

		$post['fullname']=$fullname;
		$id=$post['uid'];
	}//end if - Get user details	
			
			//generate new random password and update into DB
			$newpassword=generate_password(10);
			$hash_password=hash_f($newpassword);
			
			
			$reset_password=1;
			/*
			if(isset($data['PRO_VER'])&&$data['PRO_VER']==3){
				$reset_password=1;
			}
			*/			
			if($reset_password==1){
				$query_upd="";
				//[confcode]
				$post['ccode']=$post['confcode']=encode_f($info['id'],0);
			}else{
				$query_upd=" `password`='{$hash_password}', ";
			}
			
			// update password into DB;
			$tbl='clientid_table';
			
			db_query("UPDATE `{$data['DbPrefix']}{$tbl}` SET ".
			$query_upd.		
			" `password_updated_date`=now()".
			" WHERE `id`={$info['id']}",0
			);
			json_log_upd($info['id'],$tbl,'Password Reset'); // for json log history
			// Hide email address
			/*
			$str=$info['registered_email'];
			$length= strlen($str);
			$f1=strpos ($str,'@');
			$s1=substr($str, 0, 2);
			$s2=substr($str, ($f1-2), $length);
			$_SESSION['memail']=$s1."****".$s2;
			
			*/
			
			
			//$_SESSION['memail']=$info['registered_email'];
			$post['email']=encrypts_decrypts_emails(trim($info['registered_email']),2);
			$_SESSION['memail']=mask_email($post['email']);
			//$post['password']=$info['password'];
			$post['password']=$newpassword;
			$post['username']=$info['username'];


			if(isset($info['fullname'])&&$info['fullname'])	//if fullname exist then use fullname
				$post['fullname']=$info['fullname'];
			else	//if fullname not exists then concat fname and lname
				$post['fullname']=$info['fname']." ".$info['lname'];
	
			$post['uid']=$info['id'];
			
			if(empty($post['fullname'])){
				$post['fullname']=$info['username'];
			}
			
			$post['clientid']=$post['uid'];
			$post['tableid']=$post['uid'];
			$post['mail_type']="15";
			$post['email_header']=1;
			$post['email_br']=1;
			
			
			if($reset_password==1){
				send_email('CONFIRM-RESET-PASSWORD', $post);
				$pra['msg']="Success! New password can be generate via link with confirm the code has been sent to registered email ID: ".$_SESSION['memail'];
			}else{
				send_email('RESTORE-PASSWORD', $post);
				$pra['msg']="Success! New password has been sent to registered email ID: ".$_SESSION['memail'];
			}
			
			$_SESSION['action_success_merchant']=$pra['msg'];
			if(isset($_SESSION['action_success_merchant']))
			{
				if(isset($post['send'])) unset($post['send']);
				if(isset($_GET['bid'])) unset($_GET['bid']);
				echo "<script>
					top.window.location.href=top.window.location.href;
					//top.window.location.reload();
					 //top.window.popupclose();
					</script>";
				exit;
			}
	
	
	

}

###############################################################################
//display('admins');
###############################################################################

?>