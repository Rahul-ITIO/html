<?
$data['PageName']	= 'Add Beneficiaries';
$data['PageFile']	= 'add-beneficiaries';

###############################################################################
include('../config.do');
$data['PageTitle'] = 'Add Beneficiaries - '.$data['domain_name']; 
##########################Check Permission#####################################

if(!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

###############################################################################
if(is_info_empty($uid)){
	header("Location:{$data['USER_FOLDER']}/profile".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

$post=select_info($uid, $post);
if(!isset($post['step']) || !$post['step'])$post['step']=1;

//$post=select_info($uid, $post);
//print_r($post);

if(!isset($post['step']) || !$post['step'])$post['step']=1;
					
###############################################################################


###############################################################################
//display('user');

if(isset($data['PageDisplay'])){
	display('user');
}else{
	showpage("user/template.add-beneficiaries".$data['iex']);exit;
}
###############################################################################
?>