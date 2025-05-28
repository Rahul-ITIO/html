<?
###############################################################################
$data['PageName']='ROLES LIST';
$data['PageFile']='listroles';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Roles List - '.$data['domain_name'];
###############################################################################
if(!$_SESSION['adm_login']){
		$_SESSION['adminRedirectUrl']=$data['urlpath'];
        header("Location:{$data['Admins']}/login".$data['iex']);
        echo('ACCESS DENIED.');
        exit;
}
###############################################################################
if(!isset($post['action']) || empty($post['action']))$post['action']='select';


###############################################################################

    
if($post['action']=='select')
{
	 $data['roles']=get_roles_list();
	 
		 //json_value
	if(isset($data['access_roles'][0]['json_value'])){
		$json_value=jsondecode($data['access_roles'][0]['json_value']);
		foreach(($json_value) as $key=>$value){
			if(!$post[$key])$post[$key]=(int)$value;
		}
	}
}

if(isset($_GET['action'])&&$_GET['action'] =='delete_roles' && $_GET['id'])
{ 
	if(!isset($_SESSION['login_adm'])){ echo $data['OppsAdmin']; exit; }
	delete_access_roles($_GET['id']);
    header("Location:{$data['Admins']}/listroles{$data['ex']}?action=select"); 
}
###############################################################################

###############################################################################
display('admins');
###############################################################################
?>