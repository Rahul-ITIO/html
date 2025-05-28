<?
###############################################################################
$data['PageName']='CREATE ROLES';
$data['PageFile']='roles';
$data['rootNoAssing']=1;
###############################################################################
include('../config.do');

$data['PageTitle'] = 'Create Roles - '.$data['domain_name'];
###############################################################################
if(!$_SESSION['adm_login']){
		$_SESSION['adminRedirectUrl']=$data['urlpath'];
        header("Location:{$data['Admins']}/login".$data['ex']);
        echo('ACCESS DENIED.');
        exit;
}

if(!$_SESSION['login_adm']){
	echo('ACCESS DENIED.');
	exit;
}

include('../include/sub_admin_role_function'.$data['iex']);

###############################################################################
if(!$post['action'])$post['action']='select';


###############################################################################
if($post['action']=='insert'||$post['action']=='update'){

if($post['action']=='update'){$edit_roles_info=get_edit_roles_list($_GET['id']);
	$data['access_roles']=$edit_roles_info;
	//print_r($edit_roles_info);
	$data['json_value']=jsondecode(@$edit_roles_info[0]['json_value'],1,1);
}


//echo "print_r access_roles=>"; print_r($data['access_roles']);
if(isset($data['access_roles'][0])){
	foreach(($data['access_roles'][0]) as $key=>$value){
		if(!isset($post[$key])||!$post[$key])$post[$key]=$value;
	}
}

//json_value
if(isset($data['access_roles'][0]['json_value'])){
	$json_value=jsondecode($data['access_roles'][0]['json_value']);
	foreach(($json_value) as $key=>$value){
		if(!isset($post[$key])||!$post[$key])$post[$key]=(int)$value;
	}
}


        if(isset($post['send'])&&$post['send']){
                if($post['action']=='insert'&&!is_user_available($post['rolesname'])){
                        $data['Error']='Sorry but this Roles Name already taken.';
                }elseif(!$post['rolesname']){
                        $data['Error']='Please enter Roles Name.';
                }else{ 
					$post=get_post();
					//echo "<hr/>json_value1=>".$post['json_value'];
					
					$post['json_value']=jsonencode($post['json_value']);
					if($post['action']=='insert'){
						$edit_roles_info=get_edit_roles_list(0,1);
						$data['access_roles']=$edit_roles_info;
					}
					
					foreach($data['access_roles'][0] as $key=>$value){
						if(!isset($post[$key])||!$post[$key]) $post[$key]=0;
					}
					
					//json_value
					if(isset($data['access_roles'][0]['json_value'])){
						$json_value=jsondecode($data['access_roles'][0]['json_value']);
						foreach(($json_value) as $key=>$value){
							if(!isset($post[$key])||!$post[$key]) $post[$key]=(int)$value;
						}
					}
					
					/*
					echo "<hr/>merchant_action_view post=>".$post['merchant_action_view'];
					echo "<hr/>merchant_action_view _POST=>".$_POST['merchant_action_view'];
					echo "<hr/>print_r _POST=> ";
					print_r($_POST);
					
					echo "<hr/>print_r post=> ";
					print_r($post);
					exit;
					*/
					
					//foreach($_POST as $key=>$value)$post[$key]=replacepost($value);
					//echo "<hr/>json_value2=>".$post['json_value'];
					
                        if($post['action']=='insert'){
                                $post['gid']=$post['id']=insert_roles_info($post);
								
								if(isset($post['id'])&&$post['id']>0){
									$_SESSION['roleupdstatus']="Roles Added Successfully";
									header("Location:{$data['Admins']}/listroles{$data['ex']}?action=select");exit;
								}else{
									$data['Error']='Sorry for requesting data not inserted properly';
									
									//echo $data['Error'];
								}
                                
                        }else{
						
							update_roles_info($post, $post['rid']);
							if($data['affected_rows']==1){
								$_SESSION['roleupdstatus']="<b><i>".$post['rolesname']."</i></b> - Roles are Updated Successfully";
							}
							header("Location:{$data['Admins']}/listroles{$data['ex']}?action=select");exit;
                        }
                        //update_card_info($post, $post['gid'], false);
                        //update_bank_info($post, $post['gid'], false);
                        $post['PostSent']=true;
                }
        }elseif(isset($post['cancel'])&&$post['cancel']){
                $post['action']='select';
        }
}elseif($post['action']=='duplicate'){
	
	$edit_roles_info=get_edit_roles_list($_GET['id']);
	$post2=$edit_roles_info[0];
	
	$post2['rolesname']=$post2['rolesname']." Copy";
	insert_roles_info($post2);
	$_SESSION['roleupdstatus']="Roles Copied Successfully";
    header("Location:{$data['Admins']}/listroles{$data['ex']}?action=select");
}
###############################################################################
//$data['SystemBalance']=select_balance(-1);
###############################################################################
display('admins');
###############################################################################
?>