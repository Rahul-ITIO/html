<?
$data['PageName']	= 'MESSAGE CENTER';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Message Center - '.$data['domain_name']; 
###############################################################################
if(!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']);
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
		
		$post['ticketid'] = (substr(number_format(time() * rand(111,999),0,'',''),0,12));
		$comments_date = date('Y-m-d H:i:s');
		$comments_date_2 = date('d-m-Y h:i:s A');
		$comments=addslashes($post['comments']);
		
		
		$status=90;$qr_update_set="";
		//------------------------------------
		$photograph_view=""; $join_photograph_file="";
		
		if(isset($post['publish'])&&$post['publish']&&$post['gid']){
			
			$message_slct=db_rows(
					"SELECT `more_photograph_upload` FROM `{$data['DbPrefix']}support_tickets` WHERE `clientid`={$uid} AND `id`={$post['gid']} LIMIT 1"
			);
			$more_photograph_upload = $message_slct[0]['more_photograph_upload'];
			
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
			
			
			$status=0;
			$comments = "<div class=merchant_msg_row><div class=rmk_row><div class=rmk_date>".$comments_date_2."</div><div class=rmk_msg>".$comments.$photograph_view."</div></div></div>";
			$qr_update_set=",`date`='{$comments_date}'";
			
		}
		//------------------------------------
		
		
		
		
		
			
		if(!$post['gid']){
			db_query(
				"INSERT INTO `{$data['DbPrefix']}support_tickets`(".
				"`clientid`,".
				"`subject`,`date`,`comments`,`ticketid`,`message_type`,`status`".
				")VALUES(".
				"'{$uid}',".
				"'{$post['subject']}','{$comments_date}','{$comments}','{$post['ticketid']}','{$post['message_type']}',{$status}".
				")"
			);
			$newid=newid();
			
			$pra['newid']=$newid;
			$pra['ticketid']=$post['ticketid'];
			$pra['insert']="1";
			
			
		}
		else { 
		
			
			db_query(
					"UPDATE `{$data['DbPrefix']}support_tickets` SET ".
					"`subject`='{$post['subject']}',`comments`='{$comments}',`message_type`='{$post['message_type']}',`status`={$status}".$qr_update_set.
					" WHERE `id`={$post['gid']} AND `clientid`={$uid} "
			);
			
			$pra['newid']=$post['gid'];
			$pra['update']="1";
			if(isset($post['publish'])&&$post['publish']){
				$pra['publish']="1";
			}
		}
		
		include('message_count.do');
		
		
		
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
				
				$message_slct=db_rows(
						"SELECT * FROM `{$data['DbPrefix']}support_tickets` WHERE `clientid`={$uid} AND `id`={$post['id']} LIMIT 1"
				);
				$message_get 	= $message_slct[0]['comments']; 
				$status_get 	= $message_slct[0]['status']; 
				$rmk_date		= date('d-m-Y h:i:s A');	
				$ticketid 		= $message_slct[0]['ticketid'];
				$more_photograph_upload = $message_slct[0]['more_photograph_upload'];
				
				
				
				
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
						" SET `more_photograph_upload`='{$join_photograph_file}'".
						" WHERE `clientid`={$uid} AND `id`={$post['id']}";
				
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
					"SELECT * FROM `{$data['DbPrefix']}support_tickets` WHERE `clientid`={$uid} AND `id`={$post['id']} LIMIT 1"
			);
			$message_get 	= $message_slct[0]['comments']; 
			$status_get 	= $message_slct[0]['status']; 
			$rmk_date		= date('d-m-Y h:i:s A');	
			$ticketid 		= $message_slct[0]['ticketid'];
			$more_photograph_upload = $message_slct[0]['more_photograph_upload'];
				
			$_SESSION['remove_file']=$post['fileName'];
			
			$join_photograph_file=str_replace($post['fileName'],'',$more_photograph_upload);
			$join_photograph_file=str_replace(array('_;_;','_;_;_;','_;_;_;_;'),'_;',$join_photograph_file);
			
			$join_photograph_file=ltrim($join_photograph_file,"_;");
			$join_photograph_file=rtrim($join_photograph_file,"_;");
			
			
				$db_query1="UPDATE `{$data['DbPrefix']}support_tickets`".
						" SET `more_photograph_upload`='{$join_photograph_file}'".
						" WHERE `clientid`={$uid} AND `id`={$post['id']}";
				
				$_SESSION['db_query1']=$db_query1;
				
				db_query($db_query1,0);
				
				$pra['file_s']=$join_photograph_file;
				
				$uploaddir 		= '../user_doc/';
				if($post['fileName']){
					unlink($uploaddir . basename($post['fileName']));
				}
				
		}
	
	json_print($pra);
	
}

if($post['action']=='pr'){
	echo "<hr/>pra=>";
	echo $_SESSION['pra'];
	echo "<hr/>db_query1=>";
	echo $_SESSION['db_query1'];
	
	echo "<hr/>remove_file=>";
	echo $_SESSION['remove_file'];
	
	$post['fileName']=$_SESSION['remove_file'];
	$uploaddir 		= '../user_doc/';
				
	if($post['fileName']){
		unlink($uploaddir . basename($post['fileName']));
	}
	
}

?>

