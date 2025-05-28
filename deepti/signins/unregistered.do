<?
#########################################################################
$data['PageName']='UN-REGISTERED MERCHANT';
$data['PageFile']='unregistered'; 
$data['rootNoAssing']=1; 
##########################################################################
include('../config.do');
$data['PageTitle'] = 'Security Information - '.$data['domain_name']; 
###############################################################################
if(!isset($_SESSION['login_adm'])){
	$_SESSION['adminRedirectUrl']=$data['urlpath'];
	header("Location:{$data['Admins']}/login".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}
#########################################################################

if(!isset($post['step'])||!$post['step']){
	//$post['action']='select';
}

//zt_confirms
//update_confirmation

// /mlogin/useful_link.do?admin=1&id=

if(isset($post['action'])&&$post['action']=='delete'){
  
	if(isset($_GET)&&$_GET['id']){	
		db_query(
			"DELETE FROM `{$data['DbPrefix']}unregistered_clientid`".
			" WHERE `id`={$_GET['id']}",0
		);
	}
	header("Location:{$data['Admins']}/unregistered{$data['ex']}");
	$post['step']=1;
	$post['action']='select';
	exit;
}

$post['step']=1;


$select=db_rows(
	"SELECT * FROM {$data['DbPrefix']}unregistered_clientid".
	//" WHERE `id` IS NOT NULL ".$status." ".$sponsor_qr.
	" ORDER BY id DESC ",0
);

$post['sl_confirms']=$select;
//print_r($select);

display('admins');
#########################################################################
?>