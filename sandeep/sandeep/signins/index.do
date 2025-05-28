<?
###############################################################################
$data['PageName']='Dashboard';
$data['PageFile']='index';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'General Information Overview - '.$data['domain_name'];
###############################################################################
if(!isset($_SESSION['adm_login'])){
	$_SESSION['adminRedirectUrl']=$data['urlpath'];
	header("Location:{$data['Admins']}/login".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

?>
<?

###############################################################################
display('admins');
###############################################################################
?>
