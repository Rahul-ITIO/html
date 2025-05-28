<?
$data['PageName']='SUB ADMIN INFORMATION OVERVIEW';
$data['PageFile']='subadmin';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Sub Admin Information Overview - '.$data['domain_name'];
###############################################################################
if(!isset($_SESSION['adm_login'])){
	$_SESSION['adminRedirectUrl']=$data['urlpath'];
	header("Location:{$data['Admins']}/login".$data['iex']);
	echo('ACCESS DENIED.');
	exit;
}
###############################################################################
if(!isset($post['action'])||!$post['action'])$post['action']='select';

###############################################################################

$sid=0;
if((!isset($post['gid'])||!$post['gid'])&&!isset($_SESSION['login_adm'])){
	$post['gid']=$_SESSION['sub_admin_id'];
	$post['action']='update';
	$post['roles']=$_SESSION['sub_admin_access_id'];
	
}




if(isset($post['action'])&&$post['action']=='domain_name'){
	$subadmin_select=db_rows(
		"SELECT `domain_name` FROM `{$data['DbPrefix']}subadmin`".
		" WHERE `domain_name`='{$post['domain_name']}' ORDER BY `id` ASC LIMIT 1",0
	);
	if(isset($subadmin_select[0]['domain_name'])&&$subadmin_select[0]['domain_name']){
		$json['Error']=$subadmin_select[0]['domain_name'].' Not Available';
	}else{
		$json['msg']=$post['domain_name'].' Available';
	}
	json_print($json);	exit;
	
}elseif(isset($post['action'])&&($post['action']=='insert'||$post['action']=='update')){
	
	if(!$_SESSION['login_adm']&&!$_SESSION['update_sub_admin_other_profile']){
	  if($post['action']=='update'){
		$sid=$_SESSION['roles_id'];
	  }
	}
	
	$data['roles']=get_roles_list($sid);
	
       
        if($post['action']=='update'){
		
			//$edit_subadmin_info=get_edit_subadmin_list($_GET['id']);
			//$data['edit_subadmin']=$edit_subadmin_info;

			$id = $post['gid'];
			$subadmin=db_rows(
				"SELECT * FROM `{$data['DbPrefix']}subadmin`".
				" WHERE `id`={$id} LIMIT 1"
			);
			/*
			$results=array();
			foreach($subadmin as $key=>$value){
					foreach($value as $name=>$v)$results[$key][$name]=$v;
			}
			if($results)foreach($results[0] as $key=>$value)if(!$post[$key])$post[$key]=$value;
			*/
			
		
			$pst=keym_f(@$_POST,@$subadmin[0]);
			//if(isset($_POST)){$pst=keym_f($_POST,$subadmin[0]);} else{$pst=$subadmin[0];}
			
			if(isset($post)&&is_array($post)&&isset($pst)&&is_array($pst))
			$post=array_merge($post,$pst);


			//Dev Tech: 24-12-31 List for Account manager ID 
			if((isset($data['ACCOUNT_MANAGER_ENABLE'])&&@$data['ACCOUNT_MANAGER_ENABLE']=='Y')&&((isset($_SESSION['login_adm']))||(isset($_SESSION['account_manager'])&&$_SESSION['account_manager']==1))){
				$post['account_manager_option']=account_manager_id();
			}

				
			//print_r($data['Sponsors']);
 
			//print_r($results);
			//exit;
		
		
		}
		
		
        if(isset($post['send'])&&$post['send']){
			
			$validation_updatelogo=$_FILES['updatelogo']['name'];
			$doc_url_updatelogo = parse_url($validation_updatelogo);
			$validation_updatelogo_not_ext = pathinfo($doc_url_updatelogo['path'], PATHINFO_FILENAME);
			$ext_updatelogo  = pathinfo($doc_url_updatelogo['path'], PATHINFO_EXTENSION);
			
			$validation_logo_path=(isset($_FILES['logo_path']['name'])?$_FILES['logo_path']['name']:'');
			$doc_url_logo_path = parse_url($validation_logo_path);
			$validation_logo_path_not_ext = pathinfo($doc_url_logo_path['path'], PATHINFO_FILENAME);
			$ext_logo_path  = pathinfo($doc_url_logo_path['path'], PATHINFO_EXTENSION);
				
				
				
				if($post['action']=='insert'&&!is_user_available($post['username'])){
					$data['Error']='Sorry but this username already taken.';
				}elseif(!$post['username']){
					$data['Error']='Please enter username.';
				}
				/*elseif(!$post['password']){
					$data['Error']='Please enter password.';
				}*/
				elseif(!isset($post['email'])||!$post['email']){
					$data['Error']='Please enter email.';
				}elseif(verify_email($post['email'])){
					$data['Error']='Please enter valid e-mail address.';
				}elseif(!isset($post['fullname'])||!$post['fullname']){
					$data['Error']='Please enter name.';
				}
				/*
				elseif(!isset($post['lname'])||!$post['lname']){
					$data['Error']='Please enter your last name.';
				}
				*/
				elseif(!isset($post['roles'])||!$post['roles']){
					$data['Error']='Please select user Roles.';
				/*}
				elseif(!$post['address']){
					$data['Error']='Please enter address where you live.';
				}elseif(!$post['city']){
					$data['Error']='Please enter city where you live.';
				}elseif(!$post['country']){
					$data['Error']='Please enter country where you live.';
				}elseif(!$post['state']){
					$data['Error']='Please enter state where you live.';
				}elseif(!$post['zip']){
					$data['Error']='Please enter your postal code.';
				}elseif(!$post['phone']){
					$data['Error']='Please enter your telephone number.';
				*/
                }
				elseif((isset($validation_updatelogo)&&$validation_updatelogo)&&($_FILES["updatelogo"]["size"]>6000000)){ //1000000*6=6000000 (6MB)
					$data['Error']="File size should be less than 6MB";	
				}elseif(($validation_updatelogo)&&(!preg_match("/\.(jpg|jpeg|bmp|gif|png|docx|xlsx|pdf|CSV)$/", $validation_updatelogo))){
					$data['Error']="Unsupported file type ".$ext_updatelogo;
				}elseif(($validation_logo_path)&&($_FILES["logo_path"]["size"]>6000000)){ //1000000*6=6000000 (6MB)
					$data['Error']="File size should be less than 6MB";	
				}elseif(($validation_logo_path)&&(!preg_match("/\.(jpg|jpeg|bmp|gif|png|docx|xlsx|pdf|CSV|ico)$/", $validation_logo_path))){
					$data['Error']="Unsupported file type ".$ext_logo_path;
				}else{
					
					//if($_POST)$post=get_post();
					
					if(isset($_POST['domain_name'])&&$_POST['domain_name']&&$data['localhosts']==true){
						$_SESSION["http_host_loc"]=$_POST['domain_name'];
						
					}
					
					
					
					$subadmin_max=db_rows(
						"SELECT max(`id`) AS `maxid` FROM `{$data['DbPrefix']}subadmin`".
						" LIMIT 1"
					);
					
					$max_id=$subadmin_max[0]['maxid'];
					
					
					
					if(!empty($max_id)){$maxId=(int)$max_id+1;} elseif(empty($max_id)){$maxId=$max_id;}
					
					if($post['action']=='insert'){
					//echo "<hr/>2=".$maxId;
					}else{$maxId=$post['sid'];}
					
					
					$uploaddir 		= '../user_doc/';
					
					
					//upload_logo
					$upload_logo_unlink	= $post['upload_logo']; 
					if(isset($_POST['upload_logo'])){ $post['upload_logo']=$_POST['upload_logo']; }
					$updatelogo		= @$post['updatelogo']; 
					$upload_logo	= @$post['upload_logo']; 
					
	
					$fileName_upload_logo	= $maxId.'_'.$_FILES['updatelogo']['name'];
					$updatelogo_file = $uploaddir . basename($fileName_upload_logo); 
					
					
					if((empty($upload_logo))&&($upload_logo_unlink)){
						unlink($uploaddir . basename($upload_logo_unlink));
					}
					
					if (move_uploaded_file($_FILES['updatelogo']['tmp_name'], $updatelogo_file)) { 
						unlink($uploaddir . basename($upload_logo_unlink));
					} else {
						$fileName_upload_logo = $upload_logo;
					}
					
					$post['upload_logo']=$fileName_upload_logo;

					//logo_path
					$logo_path_unlink	= $post['logo_path']; 
					if(isset($_POST['logo_path'])){ $post['logo_path']=$_POST['logo_path']; }
					$update_logo_path	= @$post['update_logo_path']; 
					$logo_path			= @$post['logo_path']; 
					
	
					$fileName_logo_path	= $maxId.'_'.$_FILES['update_logo_path']['name'];
					$update_logo_path_file = $uploaddir . basename($fileName_logo_path); 
					
					if((empty($logo_path))&&($logo_path_unlink)){
						unlink($uploaddir . basename($logo_path_unlink));
					}
					
					if (move_uploaded_file($_FILES['update_logo_path']['tmp_name'],$update_logo_path_file)) { 
						unlink($uploaddir . basename($logo_path_unlink));
					} else {
						$fileName_logo_path = $logo_path;
					}
					
					$post['logo_path']=$fileName_logo_path;
					
					//print_r($post); exit;
					
					/*
					if(!isset($_POST['front_ui'])){ $post['front_ui']=$post['front_ui']; }
					if(!isset($_POST['upload_css'])){ $post['upload_css']=$post['upload_css']; }
					if(!isset($_POST['domain_active'])){ $post['domain_active']=$post['domain_active']; }
					*/
					
					//if(isset($_POST['upload_css'])){ $post['upload_css']=$_POST['upload_css']; }
					//if(isset($_POST['domain_name'])){ $post['domain_name']=$_POST['domain_name']; }
					
					
					/*
					echo "<hr/>uploaddir=".$uploaddir;
					echo "<hr/>fileName=".$fileName;
					echo "<hr/>updatelogo_file=".$updatelogo_file; 
					exit;*/
				
				 if(!isset($post['access_id']) || empty(trim($post['access_id']))) $post['access_id']=0;
				 
				// if(!isset($_POST['active']) || empty(trim($_POST['active']))) $post['active']=0;
				 
				 if(!isset($post['notice_type']) || empty(trim($post['notice_type']))) $post['notice_type']=0;
				 if(!isset($post['domain_active']) || empty(trim($post['domain_active']))) $post['domain_active']=0;
				
					
				if(isset($_POST['dashboard_notice'])){ $post['dashboard_notice']=$_POST['dashboard_notice']; }
                        if($post['action']=='insert'){
                                //$post['gid']=$post['id']=insert_subadmin_info($post);
								$check=false;
								$check=insert_subadmin_info($post);
								$tabid=$data['sinsid'];	
								json_log_upd($tabid,'subadmin','Insert');
								$sid=$check;
								$_SESSION['action_success']="Sub Admin Added successfully!";
								if ( $check==true){
                                header("location:{$data['Admins']}/listsubadmin{$data['ex']}?action=select&id=".$post['sid']);exit;}
                        }else{
							
							
                                update_subadmin_info($post, $post['sid']);
								if(isset($post['sid'])){
								//echo $tabid=$post['sid'];exit;				
                                //json_log_upd($tabid,'subadmin');
								
								json_log_upd($post['sid'],'subadmin','Update');
								
								}
								$_SESSION['action_success']="Sub Admin updated successfully!";
								
                                header("location:{$data['Admins']}/listsubadmin{$data['ex']}?action=select&id=".$post['sid']);exit;
								$sid=$post['sid'];
                               
                        } 
						if($sid&&$_POST['google_auth_access']){
							$twoGmfa=twoGmfa($sid,0,$_POST['google_auth_access']);
						}
                        //update_card_info($post, $post['gid'], false);
                        //update_bank_info($post, $post['gid'], false);
                        $post['PostSent']=true;
                }
        }elseif(isset($post['cancel'])&&$post['cancel']){
                $post['action']='select';
        }
		
		
		$data['Sponsors']=get_sponsors('','');//15
		$data['clientsList']=get_sponsors_mem('');//15
		//print_r($data['clientsList']);
}


###############################################################################
//$data['SystemBalance']=select_balance(-1);

 
###############################################################################
display('admins');
###############################################################################
?>