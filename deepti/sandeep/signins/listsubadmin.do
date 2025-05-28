<?
###############################################################################
$data['PageName']='SUB ADMIN LIST';
$data['PageFile']='listsubadmin';
//$data['PageFile']='listsubadmin_2';
$data['rootNoAssing']=1;
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Sub Admin List - '.$data['domain_name'];
###############################################################################
if(!$_SESSION['adm_login']){
		$_SESSION['adminRedirectUrl']=$data['urlpath'];
        header("Location:{$data['Admins']}/login".$data['ex']);
        echo('ACCESS DENIED.');
        exit;
}
###############################################################################
if(!$post['action'])$post['action']='select';

if(isset($_SESSION['login_adm'])&&$_SESSION['login_adm']==1){
	$_SESSION['login_page_active']=1;
}

###############################################################################
if ((isset($_GET['code'])) && (!empty($_GET['code']))){
	$code=$_GET['code'];
	$ajax=false;
	if (($code==1)||($code==3)){codereset($_GET['id'],'subadmin',$ajax);}
	if ($code==2){codedisable($_GET['id'],'subadmin');}
}
    
if($post['action']=='select')
{
	$where_pred='';
	
	if(isset($post['gid'])&&$post['gid']){
		$where_pred=" WHERE id={$post['gid']} ORDER BY id DESC LIMIT 1 ";
	}
	// echo "<br/>where_pred=>".$where_pred;
	 
	 $data['subadmin']=get_subadmin_list($where_pred);
	 
	 //print_r($data['subadmin']);
	 $sum = 0;
	//for($i = 1; $i <= 9; $i++){unset($data['subadmin'][$i]['id']);$sum = $sum + $i;}
}
elseif($_GET['action']=='delete_subadmin' && $_GET['id'])
{ 
	delete_subadmin_roles($_GET['id']);
     header("Location:{$data['Admins']}/listsubadmin{$data['ex']}?action=select"); 
}
elseif(($_GET['action']=='active_status'||$_GET['action']=='close_status') && ($_GET['id']))
{ 
	if($_GET['action']=='active_status'){
		$active=1;
	}else{
		$active=0;
	}
	db_query(
			 "UPDATE `{$data['DbPrefix']}subadmin`".
			 " SET `active`={$active}".
			 " WHERE `id`={$_GET['id']} ",0
	);
	json_log_upd($_GET['id'],'subadmin','Status'); 
	//exit;			
    header("Location:{$data['Admins']}/listsubadmin{$data['ex']}?action=select"); exit;
}elseif(($_GET['action']=='block_lock'||$_GET['action']=='block_unlock') && ($_GET['id']))
{ 
	
	$df='Y-m-d H:i:s';
	//$df='YmdHis';	
	
	if($_GET['action']=='block_lock'){
		$ip_block_admin_time=time();
		$action_success='Successfully block the user login for 30 Minutes.';
		//$ip_block_admin_time=date($df,strtotime('+0 minutes',time()));
		//echo "<hr/>1=>".date('Y-m-d H:i:s',($ip_block_admin_time));
	}elseif($_GET['action']=='block_unlock'){
		$ip_block_admin_time=date($df,strtotime('-31 minutes',time()));
		$action_success='Successfully unblock the user. Now the user  can login!';
		//echo "<hr/>2=>".$ip_block_admin_time;
	}
	
	db_query(
			 "UPDATE `{$data['DbPrefix']}subadmin`".
			 " SET `ip_block_admin_time`='{$ip_block_admin_time}'".
			 " WHERE `id`={$_GET['id']} ",0
	);
	
	if(isset($data['affected_rows'])&&@$action_success)
		$_SESSION['action_success']=@$action_success;
	
	json_log_upd($_GET['id'],'subadmin','Block'); 
	//exit;			
    header("Location:{$data['Admins']}/listsubadmin{$data['ex']}?action=select");exit;
}

###############################################################################
display('admins');
###############################################################################
?>