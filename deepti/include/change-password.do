<?
include('../config.do');

// for change password merchant
if(!empty($_POST["opass"])) {

  $id=((isset($_SESSION['uid'])&&$_SESSION['uid'])?$_SESSION['uid']:'');
  $opass=hash_f($_POST["opass"]);
  $npass=$_POST["npass"];
  $auth_pass_code=$_POST["auth_pass_code"];
  
  if(isset($auth_pass_code)&& $auth_pass_code){
  
	  $ccode=(int)decode_f($auth_pass_code,0);
	  $info= select_client_table($ccode);
	  //if($info['id']==$ccode){
	  $uid=$info['id'];
	  //}
	  $id=$uid;
	  
  }
  
  
  //$cpass=$_POST["cpass"];
  //$utype=$_POST["utype"];
 
 $memb=select_tablef("`id`='{$id}'",'clientid_table',0,1,"`password`,`previous_passwords`");
 $current_password=$memb['password'];
 if(isset($auth_pass_code)&& $auth_pass_code){
 $opass=$memb['password'];
 }
 $post['previous_passwords']=$memb['previous_passwords'];

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
 
			if($current_password==$opass){
				$tbl='clientid_table';
				$new_password=$npass;
				$google_auth_access=@$post['google_auth_access'];
				
				update_clients_password($uid, $new_password, $previous_passwords, true, $google_auth_access,$tbl);
				$data['PostSent']=true;
				echo "done";exit;
			
			}else{
				echo "You entered wrong old password.";exit;
			
			}
 

}


?>