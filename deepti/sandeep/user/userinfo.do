<?
###############################################################################
$data['PageName']='MEMBER INFORMATION';
$data['PageFile']='userinfo'; 
###############################################################################
include('../config.do');
$data['PageTitle'] = 'User Information - '.$data['domain_name'];
###############################################################################
if(!$_SESSION['login']){
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}
if(is_info_empty($uid)){
	header("Location:{$data['Host']}/user/profile.do");
	echo('ACCESS DENIED.');
	exit;
}
###############################################################################
$post=select_info($uid, $post);
$post['useremails']=prnclientsemails($post['gid']);
$post['Profile']=get_clients_info($post['gid']);
###############################################################################
display('user');
###############################################################################
?>
