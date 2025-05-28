<?php

		$encryptres_principal ="";
		
		$file_name=@$_FILES['updatelogo']['name'];
		$ext = substr($file_name, strpos($file_name,'.'), strlen($file_name)-1);
		
		if(($file_name)&&($_FILES["updatelogo"]["size"]>6000000)){ //1000000*6=6000000 (6MB)
				$data['Error']="File size should be less than 6MB";	
				$_SESSION['error']="File size should be less than 6MB";	
		}elseif(($file_name)&&(!preg_match("/\.(jpg|jpeg|bmp|gif|png|docx|xlsx|pdf|CSV)$/", $file_name))){
				$data['Error']="Unsupported file type ".$ext;
				$_SESSION['error']="Unsupported file type ".$ext;
		}else{

			$fullname = str_replace(" ", "", $post['fullname']);

			$maxId = $uid."_".$fullname."_".@$post['document_type']."_".time().mt_rand(0,9999999);
			
			$updatelogo		= @$post['updatelogo']; 
			$upload_logo	= @$post['upload_logo']; 
			$uploaddir 		= '../user_doc/';

			$fileName	= $maxId.'_'.@$_FILES['updatelogo']['name'];
			$updatelogo_file = $uploaddir . basename($fileName); 
			
			
			//if(isset($_FILES['updatelogo']['tmp_name'])&&$upload_logo)unlink($uploaddir . basename($upload_logo));
			
			if (move_uploaded_file(@$_FILES['updatelogo']['tmp_name'], $updatelogo_file)) { 
				if($upload_logo){unlink($uploaddir . basename($upload_logo));}
			} else {
				$fileName = $upload_logo;
			}
			
			@$post['upload_logo']=$fileName;
			
		
			$parameters=array();
			if(isset($post['fullname'])&&$post['fullname'])	$parameters['fullname']=$post['fullname'];
			
			$parameters['designation']=@$post['designation'];
			$parameters['phone']=@$post['phone'];
			//$parameters['phone_verify']="Verify";
			$parameters['email']=@$post['email'];
			$parameters['ims_type']=@$post['ims_type'];
			$parameters['birth_date']=@$post['birth_date'];
			
			$parameters['gender']=@$post['gender'];
			$parameters['address']=@$post['address'];
			$parameters['city']=@$post['city'];
			$parameters['state']=@$post['state'];
			$parameters['country']=@$post['country'];
			$parameters['zip']=@$post['zip'];
			$parameters['document_type']=@$post['document_type'];
			$parameters['document_no']	=@$post['document_no'];
			$parameters['upload_logo']	=@$post['upload_logo'];

			$parameters['cdate']=date('YmdHis');
			
			if(isset($post['phone_verify_no'])&&$post['phone_verify_no']==$_SESSION['phone_verify_no']){
				$parameters['phone_verify']="Verified";
			}elseif(@$post['phone_verify']){
				$parameters['phone_verify']=@$post['phone_verify'];
			}else{
				$parameters['phone_verify']="Verify";
			}
			
			if(isset($post['email_verify_no'])&&$post['email_verify_no']==$_SESSION['email_verify_no']){
				$parameters['email_verify']="Verified";
			}elseif(@$post['email_verify']){
				$parameters['email_verify']=@$post['email_verify'];
			}else{
				$parameters['email_verify']="Verify";
			}
			
			$parameterstr=implode('_,',$parameters);
			
			$parameterstr=json_encode($parameters);
			$encryptres_principal = encryptres($parameterstr);
	}
?>