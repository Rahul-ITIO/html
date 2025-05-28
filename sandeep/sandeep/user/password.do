<?
###############################################################################
$data['PageName']='EDIT YOUR PASSWORD AND SECURITY QUESTION';
$data['PageFile']='password'; 
$data['PageFiles'][]=$data['PageFile']; 
###############################################################################
if(!isset($data['DISPLAY_MULTI'])){
	if(isset($data['ROOT_USER'])){
		$root='';
	}else{
		$root='../';
	}
	include($root.'config.do');
}

if(isset($_GET['HideAllMenu'])&&$_GET['HideAllMenu']){
	$data['HideAllMenu']=true;
}

//echo "<br/>DISPLAY_MULTI=>".$data['DISPLAY_MULTI'];

$data['PageTitle'] = 'Security Information - '.$data['domain_name']; 
$parentUser=1;
$login_false=1;
$reset_password=0;
###############################################################################
if(isset($data['ROOT_USER'])&&$data['ROOT_USER']=='reset_password'){
	$login_false=0;$reset_password=1;
	if(isset($_GET['c'])&&trim($_GET['c'])){
		$ccode=(int)decode_f($_GET['c'],0);
		if($ccode>0){
			$info= select_client_table($ccode);
			if($info['id']==$ccode){
				$uid=$info['id'];
				$parentUser=0;
				$data['subUser']='::Reset Password';
			}
			
			$password_updated_date=date('YmdHis', strtotime("+1 hours",strtotime($info['password_updated_date'])));
			//$password_updated_date=date('YmdHis', strtotime("+3 minutes",strtotime($info['password_updated_date'])));
			$current_time=date('YmdHis');
			if($current_time<$password_updated_date){
				//echo "<br/>password_updated_date=>".$info['password_updated_date']."<br/><br/>".$info['id'];
				
				
			}else{
				
				$data['Error']="Your time has been expired please retry by Forgot Password ?";
				
				//echo $data['Error'];
				
			}
			
			
			
			//print_r($info); echo "<br/>ccode=>".$ccode;
		
		}
	}
	
	//exit;
}

if(!isset($_SESSION['login'])&&$login_false){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']); 	echo('ACCESS DENIED.'); exit;
}


###############################################################################

if(isset($post['gid'])&&$post['gid']){

	$subUser=select_tablef(" `sub_client_id`={$uid} AND `id`={$post['gid']} ",'clientid_table',0,1,'`id`,`username`,`fullname`');
	if(isset($subUser['id'])&&$subUser['id']&&$post['gid']==$subUser['id']){
		//echo "gid=>".$post['gid'];
		
		if(isset($subUser['fullname'])&&$subUser['fullname']) $fullname = @$subUser['fullname'];
		//else $fullname = $subUser['fname'].' '.$subUser['lname'];
	
		$uid=@$subUser['id'];
		$data['subUser']=" for User Name : {$subUser['id']} | Full Name : {$fullname}";
		$parentUser=0;
	}else{
		echo $data['Error']='Incorrect User';exit;
	}
	
}
$post=select_info($uid, $post);
$data['InfoIsEmpty']=is_info_empty($uid);
###############################################################################
if(isset($post['change'])&&$post['change']){
	$password=$_POST['npass'];
	
	$current_password	=(isset($post['password'])?$post['password']:'');
	
	$old_password	= (isset($post['opass'])?hash_f($post['opass']):'');
	$new_password	= (isset($post['npass'])?hash_f($post['npass']):'');
	
	if(isset($data['Error'])&&$data['Error']){
		
	}elseif(((!isset($post['opass'])||!$post['opass'])&&(!isset($post['npass'])||!$post['npass'])&&(!isset($post['cpass'])||!$post['cpass']))&&(isset($parentUser)&&$parentUser==1)){
		$data['Error']='Please enter your old and new password to update.';
	}elseif((!isset($post['opass'])||!$post['opass'])&&(isset($parentUser)&&$parentUser==1)){
		$data['Error']='Please enter your old password.';
	}elseif(!isset($post['npass'])||!$post['npass']){
		$data['Error']='Please enter your new password.';
	}elseif(strlen($post['npass'])<$data['PassLen']){
		$data['Error']="Your password must be at least {$data['PassLen']} characters long.";
	//}elseif($post['npass']==$post['opass']){
	}elseif($current_password==$new_password){
		$data['Error']='New password should not be same as old password.';
	}elseif(!isset($post['cpass'])||!$post['cpass']){
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
	//elseif($post['password']!=$post['opass']){
	elseif(($current_password!=$old_password)&&($parentUser==1)){
		$data['Error']='You entered wrong old password.';
	}elseif($post['npass']!=$post['cpass']){
		$data['Error']='Your password and confirmation should be not different.';
	}elseif($post['username']==$post['npass']){
		$data['Error']='Your password can not be same as your username.';
	//}elseif(strpos($post['previous_passwords'],$post['npass'])!==false){
	}elseif(strpos($post['previous_passwords'],$new_password)!==false){		
		$data['Error']='You can not use your 10 previous password. Kindly choose an unique password';
	}else{
	
		
		//echo "<br/>".$post['password'];
		$post['previous_passwords'];
		$post_pass['prev_pass1']=jsonvaluef($post['previous_passwords'],"prev_pass1");
		$post_pass['prev_pass2']=jsonvaluef($post['previous_passwords'],"prev_pass2");
		$post_pass['prev_pass3']=jsonvaluef($post['previous_passwords'],"prev_pass3");
		$post_pass['prev_pass4']=jsonvaluef($post['previous_passwords'],"prev_pass4");
		$post_pass['prev_pass5']=jsonvaluef($post['previous_passwords'],"prev_pass5");
		$post_pass['prev_pass6']=jsonvaluef($post['previous_passwords'],"prev_pass6");
		$post_pass['prev_pass7']=jsonvaluef($post['previous_passwords'],"prev_pass7");
		$post_pass['prev_pass8']=jsonvaluef($post['previous_passwords'],"prev_pass8");
		$post_pass['prev_pass9']=jsonvaluef($post['previous_passwords'],"prev_pass9");
		$post_pass['prev_pass10']=jsonvaluef($post['previous_passwords'],"prev_pass10");
		
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
		}elseif(!$post_pass['prev_pass6']){
			$post_pass['prev_pass6']=$npass;
		}elseif(!$post_pass['prev_pass7']){
			$post_pass['prev_pass7']=$npass;
		}elseif(!$post_pass['prev_pass8']){
			$post_pass['prev_pass8']=$npass;
		}elseif(!$post_pass['prev_pass9']){
			$post_pass['prev_pass9']=$npass;
		}elseif(!$post_pass['prev_pass10']){
			$post_pass['prev_pass10']=$npass;
		}elseif($post_pass['prev_pass10']){
			$post_pass['prev_pass1']=$post_pass['prev_pass2'];
			$post_pass['prev_pass2']=$post_pass['prev_pass3'];
			$post_pass['prev_pass3']=$post_pass['prev_pass4'];
			$post_pass['prev_pass4']=$post_pass['prev_pass5'];
			$post_pass['prev_pass5']=$post_pass['prev_pass6'];
			$post_pass['prev_pass6']=$post_pass['prev_pass7'];
			$post_pass['prev_pass7']=$post_pass['prev_pass8'];
			$post_pass['prev_pass8']=$post_pass['prev_pass9'];
			$post_pass['prev_pass9']=$post_pass['prev_pass10'];
			$post_pass['prev_pass10']=$npass;
		}	
		$previous_passwords=json_encode($post_pass);
	
		$tbl='clientid_table';
		$new_password=$npass;
		update_clients_password($uid, $new_password, $previous_passwords, true, $post['google_auth_access'],$tbl);
		//update_clients_question($uid, $post['question'], $post['answer']);
		$data['PostSent']=true;
		
		$_SESSION['action_success']="<strong>Success!</strong> Your Password Has Been Updated.";
		if($parentUser==0){
			$data['PageFile']='manage-user';
		}
		if($reset_password==1){
			$data['PageFile']='index';
		}
		header("Location:".$data['USER_FOLDER']."/".($data['DISPLAY_MULTI']?$data['DISPLAY_MULTI']:$data['PageFile']).$data['ex']);exit;
		
	}
}
//echo "<br/>DISPLAY_MULTI=>".$data['DISPLAY_MULTI']; echo "<br/>login_false=>".$login_false;
###############################################################################
if(!isset($data['DISPLAY_MULTI'])){
	display('user');
}
###############################################################################
?>
