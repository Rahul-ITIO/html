<?
$data['PageName']='EDIT YOUR INFORMATION';
$data['PageFile']='profile';
###############################################################################
include('../config.do');

$data['PageTitle'] = 'My Profile - '.$data['domain_name']; 
##########################Check Permission#####################################
/*if(!clients_page_permission('9',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }*/

if(isset($_SESSION['m_clients_role'])&&isset($_SESSION['m_clients_type'])&&!clients_page_permission('9',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }
###############################################################################



if(!isset($_SESSION['adm_login'])&&!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}


$is_admin=false;
if(isset($_SESSION['adm_login'])&&$_SESSION['adm_login']&&isset($_GET['admin'])&&$_GET['admin']){
	$is_admin=true;
	$data['HideAllMenu']=true;
	if(isset($_GET['id'])){
		$uid=$_GET['id'];
	}elseif(isset($_SESSION['login'])){
		$uid=$_SESSION['login'];
	}
}
$data['is_admin']=$is_admin;
###############################################################################

if(strpos($_SESSION['themeName'],'LeftPanel')!==false){
	
	
	$post['Banks']=select_banks($uid);
	
	
}


if(isset($_REQUEST['actionName'])&&$_REQUEST['actionName']=='filesUploadAction'){
	$_SESSION['filesUpload']=array_merge($_FILES,$_POST);
	
	$res='';$pra=[];
	$fileParamName=@$_POST['filename'];
	$files=@$_FILES['fileupload'];
	$tmp_name=@$files['tmp_name'];
	
	$file_name=@$files['name'];
	$doc_url = parse_url($file_name);
	$file_name_not_ext = pathinfo($doc_url['path'], PATHINFO_FILENAME);
	$ext  = pathinfo($doc_url['path'], PATHINFO_EXTENSION);
	
	$file_type=strtolower($file_name);

	
	if(($file_name)&&($files["size"]>6000000)){ //1000000*6=6000000 (6MB)
		$pra['Error']="File size should be less than 6MB";
	}elseif(($file_name)&&(!preg_match("/\.(doc|docx|jpg|jpeg|bmp|gif|png)$/", strtolower($file_type)))){
		$pra['Error']="Unsupported file type ".$ext;
	}else{
	
		$name=($uid)."_".$fileParamName."_".md5(uniqid())."_".$file_name;

		$uploaddir 		= '../user_doc/';
		$destination = $uploaddir . basename($name); 
		
		$_POST[$fileParamName]=$name;

		$res=move_uploaded_file($tmp_name, $destination);
	}
	
	if(isset($res) && $res) { 
		update_client_info($post, $uid);
		$pra['download']=$name;
		$pra['ext']=strtolower($ext);
		$pra['src']=$data['Host']."/user_doc/".$name;
		$msg='Uploaded successfully';
	}
	else {
		$msg='Error';
	}
	//echo $msg;
	
	$pra['msg']=$msg;
	
	//$pra['gid']=$post['gid'];
	//$pra['action']=$post['action'];
	$_SESSION['filesUpload']['pra']=$pra;
	
	//json_print($pra);
	
	header("Content-Type: application/json", true);	
	echo $arrayEncoded2 = jsonencode($pra);
	exit;
	
}

if(isset($post['action'])&&$post['action']=='delemail'){

        delete_email_info($post['gid']);

}elseif(isset($post['action'])&&$post['action']=='view_principal'){
		//header("Content-Type: application/json", true);	
        principal_view($uid);
		//exit;

}elseif(isset($post['action'])&&$post['action']=='setdefault'){

        set_default_email($post['gid']);

}elseif(isset($post['action'])&&$post['action']=='sendemail'){

        send_email_request($post['gid']);

        $data['PostSent']=false;

        $data['EmailSent']=true;

}elseif(isset($post['action'])&&$post['action']=='manage_profle'){
###############################################################################
	$defaultValidation=1;
	if(isset($post['change']) && $post['change']){
		//print_r($post);exit;
		$file_name=@$_FILES['updatelogo']['name'];
		$doc_url = parse_url($file_name);
		$file_name_not_ext = pathinfo($doc_url['path'], PATHINFO_FILENAME);
		$ext  = pathinfo($doc_url['path'], PATHINFO_EXTENSION);
		
		if(isset($post['validation'])&&($post['validation']=='step1-2' || $post['validation']=='step3')){$defaultValidation=0;}
			
			
		if(!$post['company_name']&&$defaultValidation){
				$data['Error']='Please choose company name.';
		}elseif((!$post['fullname'])&&$defaultValidation){
				$data['Error']='Please enter your name.';
		}elseif(!$post['registered_address']&&$defaultValidation){
				$data['Error']='Please enter registered address where you live.';
		}
		/*
		elseif(!$post['phone']&&$defaultValidation){
				$data['Error']='Please enter your telephone number.';
		}
		*/
		elseif(($file_name)&&($_FILES["updatelogo"]["size"]>6000000)&&$defaultValidation){ //1000000*6=6000000 (6MB)
			$data['Error']="File size should be less than 6MB";	
		}elseif(($file_name)&&(!preg_match("/\.(jpg|jpeg|bmp|gif|png|docx|xlsx|pdf|CSV)$/", strtolower($file_name)))&&$defaultValidation){
			$data['Error']="Unsupported file type ".$ext;
		}else{
			
			$maxId=$uid."_".$post['fullname']."_".@$post['document_type']."_".time().mt_rand(0,9999999);
			
			
			$uploaddir 		= '../user_doc/';
				
				
			//upload_logo
			if(isset($post['upload_logo']) && !empty($post['upload_logo']))
			{
				$upload_logo_unlink	= $post['upload_logo']; 
				if(isset($_POST['upload_logo'])){ $post['upload_logo']=$_POST['upload_logo']; }
				//$updatelogo		= $post['updatelogo']; 
				$upload_logo	= $post['upload_logo']; 
			}			

			$fileName_upload_logo	= $maxId.'_'.$_FILES['updatelogo']['name'];
			$updatelogo_file = $uploaddir . basename($fileName_upload_logo); 
			
			
			if((empty($upload_logo))&&(isset($upload_logo_unlink)&&$upload_logo_unlink)){
				unlink($uploaddir . basename($upload_logo_unlink));
			}
			
			if (move_uploaded_file($_FILES['updatelogo']['tmp_name'], $updatelogo_file)) { 
				unlink($uploaddir . basename(@$upload_logo_unlink));
			} else {
				$fileName_upload_logo = (isset($upload_logo)&&$upload_logo?$upload_logo:'');
			}
			
			$post['upload_logo']=$fileName_upload_logo;
			if($post['upload_logo']){$_POST['upload_logo']=$post['upload_logo'];}
			
			$post['user_permission']=$_SESSION['user_permission_pro'];
			if($post['user_permission']){$_POST['user_permission']=$post['user_permission'];}
			
			update_client_info($post, $uid);
            $_SESSION['success']="Profile has been updated";
			
			if($is_admin==true){
				/*
				echo "<script>
				 top.window.location.href='{$data['Admins']}/merchant{$data['ex']}?id={$_GET['id']}&action=detail';
				</script>";
				*/
			}

			$data['InfoIsEmpty']=false;

			$data['PostSent']=true;

            header("Location:{$data['USER_FOLDER']}/profile".$data['ex']);exit;
		}
		
	}
}elseif(isset($post['action'])&&$post['action']=='add_principal'){
		include('../include/add_principal'.$data['iex']);
        //principal_update($uid,$parameterstr);
		principal_update($uid,$encryptres_principal);
		if($is_admin==true){
			echo "<script>
			 top.window.location.href='{$data['Admins']}/merchant{$data['ex']}?id={$_GET['id']}&action=detail';
			</script>";
			//header("location:{$data['Admins']}/transactions{$data['ex']}?action=select&type=2&status=-1");
		}else{
		if($_SESSION['error']==""){
		    $_SESSION['success']='Spoc Added Sucessfully.';
		  }
			header("location:".$data['USER_FOLDER']."/profile{$data['ex']}?#spoc");exit;
		}
}

if(isset($post['addemail'])&&$post['addemail']){
        if(!$post['newemail']){
                $data['Error']='Please enter email.';
        }elseif(!is_mail_available($post['newemail'])){
                $data['Error']='Sorry but this e-mail address already taken.';
        }elseif(verify_email($post['newemail'])){
                $data['Error']='Please enter valid clients e-mail address.';
        }else{
                insert_email_info($post['newemail'],$uid);
                $data['PostSent']=false;
                $data['EmailSent']=true;
        }

}

###############################################################################
$post=select_info($uid, $post);
$_SESSION['user_permission_pro']=@$post['user_permission'];
$_SESSION['edit_permission']=$post['edit_permission'];
if(isset($post['profile_json'])&&$post['profile_json']){
	$post=array_merge($post,$post['profile_json']);
}
$post['emails']=prnclientsemails($uid);
$data['InfoIsEmpty']=is_info_empty($uid);
$post['kycSclt']=sel_verifi($uid,1,'clientid_table');
//$post['kycList']=sel_verifi($uid,0,'clientid_table');


###############################################################################
//print_r($post);
//print_r($post['json_value']);
if(isset($_REQUEST['p'])&&$_REQUEST['p']==1){
	print_r($post['profile_json']);
}
display('user');

###############################################################################

?>