<?
###############################################################################
$data['PageName']='ACCOUNT OVERVIEW';
$data['PageFile']='index';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'My Account - '.$data['domain_name']; 
###############################################################################
if(!isset($_SESSION['login'])){
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
} 

if(strpos($_SESSION['themeName'],'LeftPanel')!==false){
	header("Location:{$data['USER_FOLDER']}/welcome".$data['ex']);
	exit;
} else{
	header("Location:{$data['USER_FOLDER']}/dashboard".$data['ex']);
	exit;
}

exit;

?>
