<?
$data['PageName']	= 'MESSAGE CENTER';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Message Center - '.$data['domain_name']; 
###############################################################################
if(!isset($_SESSION['adm_login'])){
		$_SESSION['adminRedirectUrl']=$data['urlpath'];
        header("Location:{$data['Admins']}/login".$data['ex']);
        echo('ACCESS DENIED.');
        exit;
}

if($post['action']=='autoSave'){
	if(!$post['subject']){
	  $data['Error']='Please Select or Enter Subject.';
		json_print ( $data ['Error'] );
	}elseif(!$post['comments']){
		$data['Error']='Please enter message.';
		json_print ( $data ['Error'] );
	}else{
		
		if($post['message_type_other']){
			$post['message_type']=$post['message_type_other'];
		}
	
		$status=92;$qr_update_set=""; $comments_email = "";
		//------------------------------------
		
		$rmk_user_name="";
	
		if(isset($_SESSION['login_adm'])&&$_SESSION['login_adm']&&(!isset($_SESSION['sub_admin_id']))){
				$filterid=-1413;
				$rmk_user_name="<font class=admin_name_log>Admin</font>";
		}else{
			$filterid=$_SESSION['sub_admin_id'];
			$rmk_user_name="<font class=name_log>".$_SESSION['sub_admin_fullname']."</font><font class=user_log>".$_SESSION['sub_admin_id']."</font>"."</font><font class=rol_log>".$_SESSION['sub_admin_rolesname']."</font>";
		}
		
		$uid=$filterid;
		
		$multiple_merchant_ids=$post['multiple_merchant_ids'];
		$json['multiple_merchant_ids']=$multiple_merchant_ids;
		
		$_SESSION['pra']=json_encode($multiple_merchant_ids);
		
		$json_value=jsonencode($json);
		
		
		$qr_update_set.=",`json_value`='{$json_value}'";
		
		
		
		$post['ticketid'] = (substr(number_format(time() * rand(111,999),0,'',''),0,12));
		$comments_date = date('Y-m-d H:i:s');
		$comments_date_2 = date('d-m-Y h:i:s A');
		$comments=addslashes($post['comments']);
		
		
		
		//------------------------------------
		$photograph_view=""; $join_photograph_file="";
		
		if(isset($post['publish'])&&$post['publish']&&$post['gid']){
			
			$message_slct=db_rows(
					"SELECT `admin_doc` FROM `{$data['DbPrefix']}support_tickets` WHERE `clientid`={$uid} AND `id`='{$post['gid']}'"
			);
			$more_photograph_upload = $message_slct[0]['admin_doc'];
			
			if($more_photograph_upload){
				$join_photograph_file=$more_photograph_upload.'_;'.$join_photograph_file;
			}
			
			$join_photograph_file=str_replace(array('_;_;','_;_;_;','_;_;_;_;'),'_;',$join_photograph_file);
				
			$join_photograph_file=ltrim($join_photograph_file,"_;");
			$join_photograph_file=rtrim($join_photograph_file,"_;");	
				
			
			if($join_photograph_file){
				$photo=explode('_;',$join_photograph_file);
				foreach($photo as $value_po){
					if($value_po){
						$photograph_view.="<div style=display: block;><div class=abcd><span onclick=uploadfile_viewf(this)><img src=".encode_imgf($data['Path']."/user_doc/".$value_po)."></span></div></div>";
					}
				}
			}
			
			
			if($photograph_view){
				$photograph_view="<div class=row style=margin:0;margin-top:25px><div id=formdiv style=float:left>".$photograph_view."</div></div>";
			}
			
			
			$status=91;
			
			$comments_email = "<div class=admin_msg_row><div class=rmk_row style=float:left;width:100%;><div class=rmk_msg>".$comments.$photograph_view."</div></div></div>";
			
			
			$comments = "<div class=admin_msg_row><div class=rmk_row><div class=rmk_date>".$comments_date_2."</div><div class=rmk_user_name style=display:none>".$rmk_user_name."</div><div class=rmk_msg>".$comments.$photograph_view."</div></div></div>";
			
			
			
			$qr_update_set.=",`date`='{$comments_date}'";
			
		}
		//------------------------------------
		
		
			
		
		
	// create draft ---------------------	
	
		if(!$post['gid']){
			db_query(
				"INSERT INTO `{$data['DbPrefix']}support_tickets`(".
				"`clientid`,".
				"`subject`,`date`,`comments`,`ticketid`,`message_type`,`status`,`json_value`".
				")VALUES(".
				"'{$uid}',".
				"'{$post['subject']}','{$comments_date}','{$comments}','{$post['ticketid']}','{$post['message_type']}',{$status},'{$json_value}'".
				")"
			);
			$newid=newid();
			
			$pra['newid']=$newid;
			$pra['ticketid']=$post['ticketid'];
			$pra['insert']="1";
			
			
		}
		else { 
		
			if(isset($post['publish'])&&$post['publish']){
				$pra['publish']="1";
			}else{
				db_query(
						"UPDATE `{$data['DbPrefix']}support_tickets` SET ".
						"`subject`='{$post['subject']}',`comments`='{$comments}',`message_type`='{$post['message_type']}',`status`={$status}".$qr_update_set.
						" WHERE `id`={$post['gid']} AND `clientid`={$uid} "
				);
			}
			
			$pra['newid']=$post['gid'];
			$pra['update']="1";
			
		}
		
		
		
	// new mail ---------------------	
		
	if(isset($post['publish'])&&$post['publish']){
		
		
        db_query(
                "DELETE FROM `{$data['DbPrefix']}support_tickets`".
                " WHERE `id`={$post['gid']}"
        );
		
		$email_status=$data['TicketStatus'][$status];
		$message_type=$data['MessageType'][$post['message_type']];
		
		if($post['message_type_other']){
			$message_type=$post['message_type_other'];
		}
		
		if($message_type){
			$post['subject']=$post['subject']." for ".$message_type;
		}
		
		foreach($multiple_merchant_ids as $key=>$value){
			
			/*
			$v_exp=explode('_;',$value);
			$uid=$v_exp[0];
			$user_id=$v_exp[1];
			$post['registered_email']=$v_exp[2];
			*/
			
			$get_clientid_details=select_tablef(" `id` IN ({$value})  ",'clientid_table',0,1,"`registered_email`,`username`");
			$uid=$value;
			$user_id=$get_clientid_details['username'];
			$registered_email=$get_clientid_details['registered_email'];
			$post['registered_email']=encrypts_decrypts_emails($registered_email,2);
			
			/*
			 echo "<br>id=>".$uid;
			 echo "<br>user_id=>".$user_id;
			 echo "<br>registered_email=>".$post['registered_email'];
			 echo "<hr/>";
			 */
			 
			
			$post['ticketid'] = (substr(number_format(time() * rand(111,999),0,'',''),0,12));
			
			
			db_query(
				"INSERT INTO `{$data['DbPrefix']}support_tickets`(".
				"`clientid`,".
				"`subject`,`date`,`comments`,`ticketid`,`message_type`,`status`,`admin_doc`,`read_remark`,`filterid`".
				")VALUES(".
				"'{$uid}',".
				"'{$post['subject']}','{$comments_date}','{$comments}','{$post['ticketid']}','{$post['message_type']}',{$status},'{$join_photograph_file}',1,{$filterid}".
				")"
			);
			$new_id=newid();
			
			$post['step']=1;
			$pra['newid']=$new_id;
			$pra['ticketid']=$post['ticketid'];
			//$pra['insert']="1";
			
			
			
			 $email_messages=$comments_email."<hr/><br/><p style=\"border-bottom:2px solid #969696;background:#ccc;padding:5px;padding-left:55px;font-size:14px;font-weight:bold;float:left;width:100%;clear:both;\">Ticket Details</p><p style=\"float:left;width:100%;clear:both;\">Ticket ID: {$post['ticketid']}</p><p style=\"float:left;width:100%;clear:both;\">Status: {$email_status}</p><p style=\"float:left;width:100%;clear:both;\">Message Type: {$message_type}</p><p style=\"float:left;width:100%;clear:both;\">Date: {$comments_date}</p>";
			 
			 
			$pst['tableid']=$new_id;
			$pst['clientid']=$uid;
			$pst['mail_type']="7";
			
			send_attchment_message($post['registered_email'],$post['registered_email'],$post['subject'],$email_messages,$pst);
			
			
		  }
		
		}
		
		
		include('message_count'.$data['ex']);
		
		
		
		json_print($pra);
		
	}
}
elseif($post['action']=='filesUpload'){
	
	$join_photograph_file='';
	
	$file_name=$_FILES['photograph_file']['name'];
	$doc_url = parse_url($file_name);
	$file_name_not_ext = pathinfo($doc_url['path'], PATHINFO_FILENAME);
	$ext  = pathinfo($doc_url['path'], PATHINFO_EXTENSION);
	
	 $ticketid=$post['message_id'];
	 $post['id']=$post['post_id'];
	
	if(($file_name)&&($_FILES["photograph_file"]["size"]>6000000)){ //1000000*6=6000000 (6MB)
		$data['Error']="File size should be less than 6MB";
		$pra['action']=$data['Error'];
	}elseif(($file_name)&&(!preg_match("/\.(jpg|jpeg|bmp|gif|png|pdf)$/", strtolower($file_name)))){
		$data['Error']="Unsupported file type ".$ext;
		$pra['action']=$data['Error'];
	}else{
		if($post['id']){
			
			 
				if(isset($_SESSION['login_adm'])&&$_SESSION['login_adm']){
					$filterid=-1413;
				}else{
					$filterid=$_SESSION['sub_admin_id'];
				}
				
				$uid=$filterid;
				
				
				$message_slct=db_rows(
						"SELECT * FROM `{$data['DbPrefix']}support_tickets` WHERE `id`='{$post['id']}' "
				);
				$message_get 	= $message_slct[0]['comments']; 
				$status_get 	= $message_slct[0]['status']; 
				$rmk_date		= date('d-m-Y h:i:s A');	
				$ticketid 		= $message_slct[0]['ticketid'];
				$more_photograph_upload = $message_slct[0]['admin_doc'];
				
				
				
				
				$updatelogo		= $post['photograph_file']; 
				$uploaded_doc	= $post['uploaded_photograph_file']; 
				
				$uploaddir 		= '../user_doc/';
				
				
				$fileName = date('Ymd')."_".($ticketid).'_'.($post['id'])."_".($uid)."_".md5(uniqid()) . ""."." .$ext;
				
				$bankdoc['file_name']=$file_name;
				$bankdoc['fileName']=$fileName;
				$bankdoc['fileTitle']=$file_name_not_ext;
				$bankdoc['fileExt']=$ext;
				
				
				$upload_file = $uploaddir . basename($fileName); 
				
				
				
				if (move_uploaded_file($_FILES['photograph_file']['tmp_name'], $upload_file)&&is_uploaded_file($_FILES['photograph_file']['tmp_name'])) { 
					
					
					
					if($uploaded_doc){unlink($uploaddir . basename($uploaded_doc));}
				}
				else {
					//$fileName = $uploaded_doc;
				}
				
				
				//$fileName=json_encode($bankdoc);
				
				$post['uploaded_photograph_file']=$fileName;
				
				$pra['fileName']=$fileName;
				$join_photograph_file .= $fileName . "_;";
				
				if($more_photograph_upload){
					$join_photograph_file=$more_photograph_upload.'_;'.$join_photograph_file;
				}
				
				$join_photograph_file=str_replace(array('_;_;','_;_;_;','_;_;_;_;'),'_;',$join_photograph_file);
				
				$join_photograph_file=ltrim($join_photograph_file,"_;");
				$join_photograph_file=rtrim($join_photograph_file,"_;");
				
				
				$db_query1="UPDATE `{$data['DbPrefix']}support_tickets`".
						" SET `admin_doc`='{$join_photograph_file}'".
						" WHERE `id`={$post['id']}";
				
				$_SESSION['db_query1']=$db_query1;
				
				db_query($db_query1,0);
		}
	}		
			
	
	$get=json_encode($_GET);
	$pst=json_encode($_POST);
	$bankdoc=json_encode($bankdoc);
	$pra['get']=$bankdoc;
	$pra['pst']=$pst;
	$pra['gid']=$post['gid'];
	$pra['action']=$post['action'];
	$_SESSION['pra']=$pst=json_encode($pra);
	json_print($pra);
	
}elseif($post['action']=='removeFiles'){
	$post['id']=$post['gid'];
	if($post['id']){
				
				
			$message_slct=db_rows(
					"SELECT * FROM `{$data['DbPrefix']}support_tickets` WHERE `id`='{$post['id']}'"
			);
			$message_get 	= $message_slct[0]['comments']; 
			$status_get 	= $message_slct[0]['status']; 
			$rmk_date		= date('d-m-Y h:i:s A');	
			$ticketid 		= $message_slct[0]['ticketid'];
			$more_photograph_upload = $message_slct[0]['admin_doc'];
				
				
			$join_photograph_file=str_replace($post['fileName'],'',$more_photograph_upload);
			$join_photograph_file=str_replace(array('_;_;','_;_;_;','_;_;_;_;'),'_;',$join_photograph_file);
			
			$join_photograph_file=ltrim($join_photograph_file,"_;");
			$join_photograph_file=rtrim($join_photograph_file,"_;");
			
				$db_query1="UPDATE `{$data['DbPrefix']}support_tickets`".
						" SET `admin_doc`='{$join_photograph_file}'".
						" WHERE `id`={$post['id']}";
				
				$_SESSION['db_query1']=$db_query1;
				
				db_query($db_query1,0);
				
				$uploaddir 		= '../user_doc/';
				
				if($post['fileName']){
					unlink($uploaddir . basename($post['fileName']));
				}
				
				$pra['file_s']=$join_photograph_file;
				
		}
	
	json_print($pra);
	
}

if($post['action']=='pr'){
	// localhost/ztswallet/mlogin/message_post_ajax.do?action=pr
	echo "<hr/>pra=>";
	echo $_SESSION['pra'];
	echo "<hr/>db_query1=>";
	echo $_SESSION['db_query1'];
}

?>

