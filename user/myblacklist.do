<?
###############################################################################
$data['PageName']='Black List Data';
$data['PageFile']='myblacklist';
###############################################################################

include('../config.do');
$data['PageTitle'] = 'Black List Data - '.$data['domain_name'];

##########################Check Permission#####################################
if(isset($_SESSION['m_clients_role'])&&isset($_SESSION['m_clients_type'])&&!clients_page_permission('1',$_SESSION['m_clients_role'],$_SESSION['m_clients_type']))
{ 
	header("Location:{$data['Host']}/index".$data['ex']);exit; 
}
###############################################################################
if((!isset($_SESSION['adm_login']) || !$_SESSION['adm_login'])&&(!isset($_SESSION['login'])&&!$_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}
$is_admin=false;
if(isset($_SESSION['adm_login'])&&$_SESSION['adm_login']&&isset($_GET['admin'])&&$_GET['admin']){
	$is_admin=true;
	$data['HideAllMenu']=true;
	$uid=$_GET['id'];
	$_SESSION['login']=$uid;
}
###############################################################################
if(is_info_empty($uid)&&$is_admin==false){
	header("Location:{$data['Host']}/user/profile".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

$post=select_info($uid, $post);
//$uid=$post['id'];
###############################################################################

if (!isset($_SESSION['token_email'])) {
	$_SESSION['token_email'] = md5(uniqid(rand(), TRUE));
	$_SESSION['token_email_time'] = time();
}

if(isset($post['addnow'])&&$post['addnow']) {
	
	if(isset($post['blacklist_value'])&&($post['blacklist_value'])&&isset($post['blacklist_type'])&&($post['blacklist_type']=='IP')){ 
		$valid_ip = (checkIPAddressf($post['blacklist_value'])); 
	}else{
		$valid_ip = false;
	}
	
	if(!isset($post['token'])||empty($post['token'])){ 
		$data['error']="Token not empty due to Cross-site request forgery (CSRF)";
	}
	elseif($_SESSION['token_email']!=$post['token']){ 
		$data['error']="Token mismatch due to Cross-site request forgery (CSRF)";
	}
	elseif(strpos($_SERVER['HTTP_REFERER'],'/myblacklist')===false){ 
		$data['error']="Account Takeover due to Cross-site request forgery (CSRF)";
	}elseif(isset($post['blacklist_value'])&&($post['blacklist_value'])&&isset($post['blacklist_type'])&&($post['blacklist_type']=='IP')&&$valid_ip == false){ 
		$data['error']="Please enter the correct IP Address in Blacklist Value";
	}
	else{
		if(empty($post['blacklist_type'])) $data['error']="You did not select Type.";
		elseif(empty($post['blacklist_value'])) $data['error']="You did not entered blacklist value.";
		else
		{

			$result=get_blacklist_details($uid, 'addnew', $post);

			/*
				//print_r($result);
				if(empty($result) && pg_last_error($data['cid'])) 
				{
					echo $data['error']=" | <div style=\"background:#bf0000;color:#e6e6e6;display:inline-block;padding:4px;border-radius:3px;font-weight:bold;\">".pg_last_error($data['cid'])."</div>";
				}
			*/

			if(isset($_REQUEST['qp']))  exit;

			if(isset($is_admin)&&$is_admin==true){
				echo "<script>
				 top.window.location.href='{$data['Admins']}/merchant{$data['ex']}?id={$_GET['id']}&action=detail';
				</script>";
			}
			else
			{
				if($result=='SUCCESS')
					$_SESSION['success']="Your data has been addedd successfully";
				else 
					$_SESSION['error']=$result;
				header("Location:{$data['USER_FOLDER']}/myblacklist".$data['ex']);exit;
			}
		}
	}
}
elseif(isset($_REQUEST['deletebtn'])&&$_REQUEST['deletebtn']) {

	if(isset($_REQUEST['token'])&&$_REQUEST['token']){ $post['token']=$_REQUEST['token']; }
	if(isset($_REQUEST['choice'])&&$_REQUEST['choice']){ $post['choice']=$_REQUEST['choice']; }

	if(!isset($post['token'])||empty($post['token'])){ 
		$data['error']="Token not empty due to Cross-site request forgery (CSRF)";
	}
	elseif($_SESSION['token_email']!=$post['token']){ 
		$data['error']="Token mismatch due to Cross-site request forgery (CSRF)";
	}
	// $_SERVER['HTTP_REFERER'] not get on Android App Case
	elseif(!empty($_SERVER['HTTP_REFERER']) && strpos($_SERVER['HTTP_REFERER'],'/myblacklist')===false){ 
		$data['error']="Account Takeover due to Cross-site request forgery (CSRF)";
	}
	else{
	
		if (!isset($post['choice'])||empty($post['choice'])) $data['error']="You did not select any list.";	
	
		else{

			$result=get_blacklist_details($uid, 'delete', $post);
			if(isset($is_admin)&&$is_admin==true){
				echo "<script>
				 top.window.location.href='{$data['Admins']}/merchant{$data['ex']}?id={$_GET['id']}&action=detail';
				</script>";
			}else{
				if($result>0) $_SESSION['success']="$result Record(s) Deleted Successfully";
				else $_SESSION['error']="No any records delete";

				header("Location:{$data['USER_FOLDER']}/myblacklist".$data['ex']);exit;
			}
		}
	}
}
$data['MaxRowsByPage']=50;
if(isset($_GET['page'])&&$_GET['page']) $page  = $_GET['page'];
else $page  = 1;

$data['startPage']	= $page;
$data['myblacklist']=get_blacklist_details($uid);
###############################################################################
display('user');
###############################################################################
?>