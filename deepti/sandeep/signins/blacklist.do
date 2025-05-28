<?
$data['PageName']	= 'BLACKLIST';
$data['PageFile']	= 'blacklist';

$data['rootNoAssing']=1; 
###############################################################################
include('../config.do');
$data['PageTitle'] = $data['PageName'].' - '.$data['domain_name'];
###############################################################################

if((!isset($_SESSION['adm_login']))&&(!isset($_SESSION['sub_admin_id']))){
	$_SESSION['adminRedirectUrl']=$data['urlpath'];
	header("Location:{$data['slogin']}/login".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

if(!isset($post['action'])||!$post['action']){$post['action']='select'; $post['step']=1; }
if(!isset($post['step'])||!$post['step']){$post['step']=1; }

###############################################################################

if(isset($post['send'])&&($post['send']=='add_data')){
$post['step']=2;
}
if(isset($post['action'])&&($post['action']=='insert_blkdata')){
	
	if(isset($post['blacklist_value'])&&($post['blacklist_value'])&&isset($post['blacklist_type'])&&($post['blacklist_type']=='IP')){ 
		$valid_ip = (checkIPAddressf($post['blacklist_value'])); 
	}else{
		$valid_ip = false;
	}
	if(empty($post['blacklist_type'])){
		$data['error']="You did not select Type.";
	} 
	elseif(empty($post['blacklist_value'])){
		$data['error']="You did not entered blacklist value.";
	} 
	elseif(isset($post['blacklist_value'])&&($post['blacklist_value'])&&isset($post['blacklist_type'])&&($post['blacklist_type']=='IP')&&$valid_ip == false){ 
		$data['error']="Please enter the correct IP Address in Blacklist Value";
	}
	/*elseif(isset($post['source'])&&$post['source']=='admin' && empty($post['merchant_list_id'])){
		$data['error']="You did not select Merchant.";
	}*/
	else
	{
			$result=get_blacklist_details(0, 'addnew', $post);
			
			if($result=='SUCCESS')
			$_SESSION['action_success']="Your data has been addedd successfully";
			else 
				$_SESSION['action_error']=$result;
			header("Location:{$data['Admins']}/blacklist".$data['ex']."?step=1&gid=0");exit;
		}

	
}

elseif($post['action']=='delete_blkdatas'){
	if(isset($post['bid'])&&$post['bid'])
	{
		$del_post['choice'][]=$post['bid'];
		get_blacklist_details(0, 'delete', $del_post);

		$_SESSION['action_success']="Successfully Deleted";

		header("Location:{$data['Admins']}/blacklist".$data['ex']."?step=1&gid=0");exit;
	}
}

if($post['step']==1){
	$data['MaxRowsByPage']=50;

	if(isset($_GET['page'])&&$_GET['page']) $page  = $_GET['page'];
	else $page  = 1;

	$data['startPage']	=$page;
	$post['result_list'] = get_blacklist_details(0, 'list_all');
}

###############################################################################

display('admins');

###############################################################################

?>