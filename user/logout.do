<?
###############################################################################
$data['PageFile']='logout'; 
$data['PageName']='Sign Out';
$data['PageTitle']='Sign Out'; 
$data['IsLogin']=true;
$data['HideMenu']=true;
$data['HideAllMenu']=true;
$data['NO_SALT']=true;
###############################################################################
include('../config.do');
if(!isset($post['step']) || !$post['step']) $post['step']=1;

if(isset($_SESSION['uid'])&&$_SESSION['uid'])
set_last_access_date($_SESSION['uid'], true);


###############################################################################
display('user');
###############################################################################
?>
