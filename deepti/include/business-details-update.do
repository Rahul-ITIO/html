<?
include('../config.do');
if(!isset($_SESSION['login'])){
	echo('ACCESS DENIED.');
	exit;
}

// for resend forgot password link
if(!empty($_REQUEST["company_name"])) {
	
	$id=$_SESSION['uid'];
	
	$fullname=@$_REQUEST["fullname"];
	$company_name=@$_REQUEST["company_name"];
	$registered_address=@$_REQUEST["registered_address"];
	
	/*
	$business_contact=@$_REQUEST["business_contact"];
	$designation=@$_REQUEST["designation"];
	$phone=@$_REQUEST["phone"];
	*/

	$get_clientid_details_tbl=select_table_details($id,'clientid_table',0);
	$profile_json=jsondecode($get_clientid_details_tbl['json_value']);
	
	$json_value=keym_f($_REQUEST,$profile_json);
	$json_value=jsonencode($json_value);
	
	$tbl='clientid_table';
	$query=" UPDATE `{$data['DbPrefix']}{$tbl}` SET `fullname` = '{$_REQUEST['fullname']}', `company_name`='{$company_name}', `registered_address`='{$registered_address}',`json_value` = '{$json_value}' WHERE `id`='{$id}' ";

	db_query($query);
	
	
	json_log_upd($id,$tbl,'Update'); // for json log history
	
	$_SESSION['action_success']='Business details Updated!';
	echo "done";
}


elseif(!empty($_REQUEST["ims_type"])) {
	
	
	
	$id			=$post['uid']=$uid=$_SESSION['uid'];
	$fullname	=$post['fullname']=$_REQUEST["fullname"];
	$designation=$post['designation']=$_REQUEST["designation"];
	$phone		=$post['phone']=$_REQUEST["phone"];
	$ims_type	=$post['ims_type']=$_REQUEST["ims_type"];
	$email		=$post['email']=$_REQUEST["email"];
	
	include('add_principal'.$data['iex']);
	
	$post['bid']=principal_update($id,$encryptres_principal);
	echo "done";

	////////////////////////Insert Principle Pending /////////////////////
}
?>