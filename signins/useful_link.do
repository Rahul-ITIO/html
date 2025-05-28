<?
#########################################################################
$data['PageName']='USEFUL LINK';
$data['PageFile']='useful_link'; 
##########################################################################
include('../config.do');
if(isset($data['domain_server']['as']['useful_link'])&&$data['domain_server']['as']['useful_link']){
	$data['PageFile']=$data['domain_server']['as']['useful_link']; 
}

$data['PageTitle'] = 'Security Information - '.$data['domain_name']; 
###############################################################################
if((!isset($_SESSION['adm_login']))&&(!isset($_SESSION['useful_link']))){
	$_SESSION['adminRedirectUrl']=$data['urlpath'];
	header("Location:{$data['Admins']}/login".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}
#########################################################################
if(!isset($_SESSION['test_merchant'])){
	@$test_merchant=@$_SESSION['test_merchant']=select_tablef(" `active`='1' AND `status`='2' AND `sub_client_id` IS NULL  ORDER BY `id` ASC  ",'clientid_table',0,1,"`username`,`id`,`default_currency`,`private_key`");
}
if(isset($_SESSION['test_merchant']['username'])) $data['test_merchant_user']=@$_SESSION['test_merchant']['username'];
//echo "<br/>test_merchant_user=>".$data['test_merchant_user'];



if(isset($_GET)&&isset($_GET['admin'])){
	
	if(isset($_GET)&&isset($_GET['id'])){	
		db_query(
			"DELETE FROM `{$data['DbPrefix']}unregistered_clientid`".
			" WHERE `id`='{$_GET['id']}'",1
		);
		if($data['connection_type']=='PSQL'){
			db_query(
				"SELECT setval('{$data['DbPrefix']}unregistered_clientid_id_seq', (SELECT MAX(`id`) FROM `{$data['DbPrefix']}unregistered_clientid`)+1);",0
			);
		}
	}

	$select=db_rows(
		"SELECT * FROM {$data['DbPrefix']}unregistered_clientid".
		//" WHERE `id` IS NOT NULL ".$status." ".$sponsor_qr.
		" ORDER BY id DESC "//,true
	);
	
	print_r($select);

}
	

display('admins');
#########################################################################
?>