<?
include('../config.do');
$data['PageTitle'] = 'Logout - '.$data['domain_name'];
###############################################################################
#if(!$_SESSION['adm_login']){
#	header("Location:{$data['Host']}");
#	exit;
#}
###############################################################################



unset($_SESSION);

unset($_SESSION['adm_login']);
unset($_SESSION['admin_theme_color']);
unset($_SESSION['tempuser']);
unset($_SESSION['login_adm']);
unset($_SESSION['adm_login']);

//print_r($_SESSION); exit;

session_unset();
session_destroy();
setcookie('session_id', null, time() - 1);
setcookie('session_key', null, time() - 1);

/*
if(isset($data['AdminFolder'])&&$data['AdminFolder']){
	$adm_upth=$data['AdminFolder'];
}else{
	$adm_upth="login";
}
*/
$adm_upth="login";
header("Location:{$data['Admins']}/{$adm_upth}".$data['ex']);
echo('ACCESS DENIED.');
exit;
###############################################################################
?>
