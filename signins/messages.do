<?
$data['PageName']	= 'MESSAGE CENTER';
$data['PageFile']	= 'admin_messages';
$data['rootNoAssing']=1;
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

if((isset($_SESSION['login_adm']))||(isset($_SESSION['ticket_link'])&&$_SESSION['ticket_link']==1)){
	
}


if(!isset($post['step']) || empty($post['step'])){$post['step']=1; }

###############################################################################

//print_r($post); print_r($uid); echo "=h1=";

###############################################################################
if(isset($post['action']) && $post['action']=='addmessage'){
	
	$comments_date=date('Y-m-d H:i:s');
	$qr_update_set="";
	
	
	$message_slct=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}support_tickets` WHERE  `id`='{$post['id']}' LIMIT 1"
	);
	$uid			= $message_slct[0]['clientid'];
	$message_get 	= $message_slct[0]['comments']; 
	$status_get 	= $message_slct[0]['status']; 
	$rmk_date		= date('d-m-Y h:i:s A');	
	$ticketid 		= $message_slct[0]['ticketid'];
	$message_type_get= $message_slct[0]['message_type'];
	$more_photograph_upload = $message_slct[0]['admin_doc'];	
	
	
	$uploaddir 		= '../user_doc';
	
	$photograph_view='';
	
	$rmk_user_name="";
	
	if(isset($_SESSION['login_adm'])&&$_SESSION['login_adm']&&(!isset($_SESSION['sub_admin_id']))){
			$filterid=-1413;
			$rmk_user_name="<font class=admin_name_log>Admin</font>";
	}else{
		$filterid=$_SESSION['sub_admin_id'];
		$rmk_user_name="<font class=name_log>".$_SESSION['sub_admin_fullname']."</font><font class=user_log>".$_SESSION['sub_admin_id']."</font>"."</font><font class=rol_log>".$_SESSION['sub_admin_rolesname']."</font>";
	}
		
	$aid=$filterid;
	

	// add more doc  -----------------------
	// join_photograph_file *******************************************************
		$j_photograph = 0; //Variable for indexing uploaded image 
		$join_photograph_file = "";
		$target_path_photograph = $uploaddir."/"; //Declaring Path for uploaded images
	if(isset($_FILES['photograph_file']['name']) && !empty($_FILES['photograph_file']['name']))
	{
		for ($i = 0; $i < count($_FILES['photograph_file']['name']); $i++) {//loop to get individual element from the array
	
	
			$validextensions_photograph = array("jpg","jpeg","bmp","gif","png","pdf");  //Extensions which are allowed
			$ext_photograph = explode('.', basename($_FILES['photograph_file']['name'][$i]));//explode file name from dot(.) 
			$file_extension_photograph = end($ext_photograph); //store extensions in the variable
			$file_names_photograph = date('Ymd')."_".($ticketid).'_'.($post['id'])."_".($aid)."_".md5(uniqid()) . ""."." .$ext_photograph[count($ext_photograph) - 1];
			$target_path_photographs = $target_path_photograph . $file_names_photograph;//set the target path with a new name of image
	
			$j_photograph = $j_photograph + 1;//increment the number of uploaded images according to the files in array       
		  
		  //Approx.  100000 = 100kb files can be uploaded.
		  if (($_FILES["photograph_file"]["size"][$i] < 100000000) 
					&& in_array($file_extension_photograph, $validextensions_photograph)) {
				if (move_uploaded_file($_FILES['photograph_file']['tmp_name'][$i], $target_path_photographs)) {//if file moved to uploads folder
					
					$join_photograph_file .= $file_names_photograph . "_;";
					
				} else {//if file was not moved.
					
				}
			} else {//if file size and file type was incorrect.
				
				//echo "file size and file type was incorrect."; exit;
			}
		}
		
		
		$remove_photograph_file = $_POST['remove_photograph_file'];
		if(isset($remove_photograph_file) && $remove_photograph_file){
			foreach ($remove_photograph_file as $remove_photograph_files=>$value) {
				 unlink($target_path_photograph . basename($value));
			}
		}
		
		if(isset($_POST['update_photograph_file'])){
			$update_photograph_file = implode('_;', $_POST['update_photograph_file']);
			
			if(!empty($update_photograph_file)){
				$join_photograph_file = $update_photograph_file . '_;' . $join_photograph_file;
			}
		}
		
	}
		//echo $join_photograph_file;
	
	// add more doc end ----------------------------
	
	if(isset($status_get) && $status_get=="92"){
		
	}
	
		if(isset($join_photograph_file) && $join_photograph_file){
			$photo=explode('_;',$join_photograph_file);
			foreach($photo as $value_po){
				if(isset($value_po) && $value_po){
					$photograph_view.="<div style=display: block;><div class=abcd><span onclick=uploadfile_viewf(this)><img src=".encode_imgf($data['Path']."/user_doc/".$value_po)."></span></div></div>";
				}
			}
		}
		
		
		if(isset($photograph_view) && $photograph_view){
			$photograph_view="<div class=row style=margin:0;margin-top:25px><div id=formdiv style=float:left>".$photograph_view."</div></div>";
		}
	
	
	
	
	
	if(isset($post['status']) && $post['status']){
		if($post['status']=="111"){
			$post['status']=0;
		}
		$qr_update_set.=",`status`={$post['status']}";
	}
	
	if(isset($post['message_type']) && $post['message_type']){
		$qr_update_set.=",`message_type`='{$post['message_type']}'";
	}
	
	if(isset($post['subject']) && $post['subject']){
		//$qr_update_set.=",`subject`='{$post['subject']}'";
	}
	
	
	if(isset($more_photograph_upload) && $more_photograph_upload){
		$join_photograph_file=$more_photograph_upload.'_;'.$join_photograph_file;
	}
	
	$join_photograph_file=str_replace(array('_;_;','_;_;_;','_;_;_;_;'),'_;',$join_photograph_file);
	
	$join_photograph_file=ltrim($join_photograph_file,"_;");
	$join_photograph_file=rtrim($join_photograph_file,"_;");
	
	$message_upd = $message_get."<div class=admin_msg_row><div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_user_name style=display:none>".$rmk_user_name."</div><div class=rmk_msg>".$post['comments'].$photograph_view."</div></div></div>";
	
	$qr_update_set.=",`date`='{$comments_date}'";
	
	
	if(isset($status_get) && $status_get=="92"){
		$_SESSION['load_tab']='sent';
	}else{
		$_SESSION['load_tab']='inbox';
	}
	$_SESSION['open_msg_id']=$ticketid;
		
	if(isset($post['comments']) && $post['comments']){
		db_query(
			"UPDATE `{$data['DbPrefix']}support_tickets`".
			" SET `comments`='{$message_upd}',`admin_doc`='{$join_photograph_file}'".$qr_update_set.
			" WHERE `id`='{$post['id']}'",0
		);
	}
	
	
	
	if(isset($post['status']) && $post['status']==2){//close
		$email_status="No Action Required";
	}elseif(isset($post['status']) && $post['status']==1){//Process
		$email_status="Awaiting for merchant reply (Kindly login to your merchant portal and Add Remark)";
	}else{
		$email_status=$data['TicketStatus'][$post['status']];
	}
	
	if(!isset($post['status']) || empty($post['status'])){
		$email_status=$data['TicketStatus'][$status_get];
	}
	
	
	$messages="<div class=admin_msg_row><div class=rmk_msg>".$post['comments'].$photograph_view."</div></div><br/><br/>--<br/>".$message_get;
	
	$message_type=$data['MessageType'][$message_type_get];
	
	
	 $email_messages_1="<p style=\"float:left;width:100%;clear:both;\">Ticket ID: {$ticketid}</p><p style=\"float:left;width:100%;clear:both;\">Status: {$email_status}</p><p style=\"float:left;width:100%;clear:both;\">Message Type: {$message_type}</p><p style=\"float:left;width:100%;clear:both;\">Date: {$rmk_date}</p>";
	 
	 $email_messages=$messages."<hr/><br/><p style=\"border-bottom:2px solid #969696;background:#ccc;padding:5px;padding-left:55px;font-size:14px;font-weight:bold;float:left;width:100%;clear:both;\">Ticket Details</p>".$email_messages_1;
	 
	 
	$pst['tableid']=$post['id'];
	$pst['clientid']=$uid;
	$pst['mail_type']="7";
	
	send_attchment_message($post['email'],$post['email'],"Re: ".$post['subject'],$email_messages,$pst);
	
	$_SESSION['action_success']=$email_messages_1;
	
	header("location:".$data['Admins']."/messages{$data['ex']}");
	exit;
}elseif(isset($post['cancel']) && $post['cancel']){
	$post['step']--;
}elseif(isset($post['action']) && $post['action']=='update'){
       
	   global $data;
	    $id = $post['gid'];
		//echo "<div style='margin-top:100px;'></div>"; print_r($id);
		$echecks=db_rows(
                "SELECT * FROM `{$data['DbPrefix']}support_tickets`".
                " WHERE  AND `id`='{$id}' LIMIT 1"
        );
        $results=array();
		
		
		
        foreach($echecks as $key=>$value){
                foreach($value as $name=>$v) {
					$results[$key][$name]=$v;
					
					if(!isset($post[$key][$name]) || empty($post[$key][$name])){
						$post[$key][$name]=$v;
					}
				}
        }
        
		
		//echo "<div style='margin-top:100px;'></div>"; print_r($post);
		
        $post['actn']='update';
        $post['step']++;
		
		
}elseif(isset($post['action']) && $post['action']=='delete'){
		global $data;
		$gid = $post['gid'];
		/*
        db_query(
                "DELETE FROM `{$data['DbPrefix']}support_tickets`".
                " WHERE `id`={$gid}"
        );
		*/
}



//$_SESSION['Sponsors']=get_sponsors('','');//15
$_SESSION['clientsList']=get_sponsors_mem('',1,1);//15	





###############################################################################

display('admins');

###############################################################################

?>
