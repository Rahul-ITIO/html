<?
include('../config.do');

###############################################################################

if(!isset($_SESSION['login'])&&!isset($_SESSION['adm_login'])){
	header("Location:{$data['USER_FOLDER']}/login{$data['ex']}");
	echo('ACCESS DENIED.');
	exit;
}elseif((isset($_SESSION['view_mask_email']))&&(!isset($_SESSION['view_mask_email']))){
	// header("Location:{$data['USER_FOLDER']}/login{$data['ex']}"); echo('ACCESS DENIED.'); exit;
	echo('ACCESS DENIED.');
	exit;
}

$is_admin=false;
if($_SESSION['adm_login']&&isset($_GET['admin'])&&$_GET['admin']){
	$is_admin=true;
	//echo "<hr/>is_admin=>".$is_admin;
}
if(isset($_REQUEST['id'])&&isset($_REQUEST['deletedmail']))
{
	$select=select_table_details($_REQUEST['id'],'clientid_table',0);

	if($select['deleted_email']){
		echo $deleted_email_list=encrypts_decrypts_emails($select['deleted_email'],2);
	}
}
else
{
	$tbl=$_REQUEST['tbl'];
	$tblid=$_REQUEST['tblid'];
	
	$table_name = $data['define_table_list'][$tbl][0];
	$field_name = $data['define_table_list'][$tbl][1];
	
	$sqlStmt = "SELECT $field_name FROM `{$data['DbPrefix']}$table_name` WHERE `id`='{$tblid}' LIMIT 1";
	
	$q = db_rows($sqlStmt);
	
	if(isset($q[0])){
		 $email=$q[0][$field_name];
		//echo "<br/>";
		echo encrypts_decrypts_emails($email,2);
	}
	
}
db_disconnect();

?>