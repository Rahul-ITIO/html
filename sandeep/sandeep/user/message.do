<?
$data['PageName']	= 'MESSAGE CENTER';
$data['PageFile']	= 'merchant_messages';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Message Center - '.$data['domain_name']; 
###############################################################################
##########################Check Permission#####################################
if(isset($_SESSION['m_clients_role'])&&isset($_SESSION['m_clients_type'])&&!clients_page_permission('6',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }
###############################################################################
if(!isset($_SESSION['login'])||!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

if(isset($uid)&&is_info_empty($uid)){
	header("Location:{$data['USER_FOLDER']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

//$_SESSION['load_tab']='sent';

//echo $data['TicketFilter']['-4181'];

$post=select_info($uid, $post);
if(!isset($post['step'])||!$post['step']){$post['step']=1; }

###############################################################################

//print_r($post); print_r($uid); echo "=h1=";

###############################################################################
if(isset($post['action'])&&$post['action']=='closePopup'){
	$_SESSION['closePopup']=1;
	exit;
	
}elseif(isset($post['action'])&&$post['action']=='addmessage'){
	
	$comments_date=date('Y-m-d H:i:s');
	$qr_update_set="";
	
	
	$message_slct=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}support_tickets` WHERE `clientid`={$uid} AND `id`={$post['id']} LIMIT 1"
	);
	$message_get 	= $message_slct[0]['comments']; 
	$status_get 	= $message_slct[0]['status']; 
	$rmk_date		= date('d-m-Y h:i:s A');	
	$ticketid 		= $message_slct[0]['ticketid'];
	$more_photograph_upload = $message_slct[0]['more_photograph_upload'];	
	
	
	$uploaddir 		= '../user_doc';
	
	$photograph_view='';
	

	// add more doc  -----------------------
	// join_photograph_file *******************************************************
	$j_photograph = 0; //Variable for indexing uploaded image 
	$join_photograph_file = "";
	$target_path_photograph = $uploaddir."/"; //Declaring Path for uploaded images

	if(isset($_FILES['photograph_file'])){
		for ($i = 0; $i < count($_FILES['photograph_file']['name']); $i++) {//loop to get individual element from the array
	
	
			$validextensions_photograph = array("jpg","jpeg","bmp","gif","png","pdf");  //Extensions which are allowed
			$ext_photograph = explode('.', basename($_FILES['photograph_file']['name'][$i]));//explode file name from dot(.) 
			$file_extension_photograph = end($ext_photograph); //store extensions in the variable
			$file_names_photograph = date('Ymd')."_".($ticketid).'_'.($post['id'])."_".($uid)."_".md5(uniqid()) . ""."." .$ext_photograph[count($ext_photograph) - 1];
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
	}
	################
	if(isset($_POST['remove_photograph_file']))
	{
		$remove_photograph_file = $_POST['remove_photograph_file'];
		if($remove_photograph_file){
			foreach ($remove_photograph_file as $remove_photograph_files=>$value) {
				 unlink($target_path_photograph . basename($value));
			}
		}
	}		
	if(isset($_POST['update_photograph_file'])){
		$update_photograph_file = implode('_;', $_POST['update_photograph_file']);
		
		if(!empty($update_photograph_file)){
			$join_photograph_file = $update_photograph_file . '_;' . $join_photograph_file;
		}
	}
	
	//echo $join_photograph_file;

// add more doc end ----------------------------

if(isset($status_get)&&$status_get=="90"){}

	if(isset($join_photograph_file)&&$join_photograph_file){
		$photo=explode('_;',$join_photograph_file);
		foreach($photo as $value_po){
			if($value_po){
				$photograph_view.="<div style=display: block;><div class=abcd><span onclick=uploadfile_viewf(this)><img src=".encode_imgf($data['Path']."/user_doc/".$value_po)."></span></div></div>";
			}
		}
	}

	if(isset($photograph_view)&&$photograph_view){
		$photograph_view="<div class=row style=margin:0;margin-top:25px><div id=formdiv style=float:left>".$photograph_view."</div></div>";
	}

	if(isset($post['status'])&&$post['status']){
		if($post['status']=="111"){
			$post['status']=0;
		}
		$qr_update_set.=",`status`={$post['status']}";
	}
	
	if(isset($post['message_type'])&&$post['message_type']){
		$qr_update_set.=",`message_type`='{$post['message_type']}'";
	}
	
	if(isset($post['subject'])&&$post['subject']){
		$qr_update_set.=",`subject`='{$post['subject']}'";
	}
	
	
	if(isset($more_photograph_upload)&&$more_photograph_upload){
		$join_photograph_file=$more_photograph_upload.'_;'.$join_photograph_file;
	}
	
	$join_photograph_file=str_replace(array('_;_;','_;_;_;','_;_;_;_;'),'_;',$join_photograph_file);
	
	$message_upd = $message_get."<div class=merchant_msg_row><div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$post['comments'].$photograph_view."</div></div></div>";
	
	if(isset($status_get)&&$status_get=="90"){
		$qr_update_set.=",`date`='{$comments_date}'";
		//$message_upd = $message_get.$post['comments'];
	}
	
	$_SESSION['load_tab']='sent';
	$_SESSION['open_msg_id']=(isset($ticketid)?$ticketid:'');
		
	if(isset($post['comments'])&&$post['comments']){
		db_query(
			"UPDATE `{$data['DbPrefix']}support_tickets`".
			" SET `comments`='{$message_upd}',`more_photograph_upload`='{$join_photograph_file}'".$qr_update_set.
			" WHERE `clientid`={$uid} AND `id`={$post['id']}",0
		);
	}
	
	//exit;
	$post['comments']= ""; 
	$post['step']=1;
	$post['action']='select';
	
	
	header("location:".$data['USER_FOLDER']."/message".$data['ex']);
}elseif(isset($post['cancel'])&&$post['cancel']){
	$post['step']--;
}elseif(isset($post['action'])&&$post['action']=='update'){
       
	   global $data;
	    $id = $post['gid'];
		//echo "<div style='margin-top:100px;'></div>"; print_r($id);
		$echecks=db_rows(
                "SELECT * FROM `{$data['DbPrefix']}support_tickets`".
                " WHERE `clientid`={$uid}  AND `id`={$id} LIMIT 1"
        );
        $results=array();
		
		
		
        foreach($echecks as $key=>$value){
                foreach($value as $name=>$v) {
					$results[$key][$name]=$v;
					
					if(!$post[$key][$name]){
						$post[$key][$name]=$v;
					}
				}
        }
        
		
		//echo "<div style='margin-top:100px;'></div>"; print_r($post);
		
        $post['actn']='update';
        $post['step']++;
		
		
}elseif(isset($post['action'])&&$post['action']=='delete'){
		global $data;
		$gid = $post['gid'];
		/*
        db_query(
                "DELETE FROM `{$data['DbPrefix']}support_tickets`".
                " WHERE `id`={$gid}"
        );
		*/
}


	
//print_r($data['selectdatas']); print_r($uid); echo "=h2=";




###############################################################################

display('user');

###############################################################################

?>
