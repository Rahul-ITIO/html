<?
###############################################################################
$data['PageName']='E-MAIL TEMPLATES';
$data['PageFile']='mail-conf';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'E-mail Templates - '.$data['domain_name'];
###############################################################################
if(!$_SESSION['adm_login']){
	$_SESSION['adminRedirectUrl']=$data['urlpath'];
	header("Location:{$data['Admins']}/login".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}
###############################################################################
function delete_mail_template($key){
global $data;

$result=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}emails_templates`".
		" WHERE `key`='{$key}' LIMIT 1"
	);
	
db_query( "INSERT INTO `{$data['DbPrefix']}emails_templates_deleted` 
	(`tid`,`id`,`key`,`name`,`value`) VALUES
	('','{$result[0]['id']}','{$result[0]['key']}','{$result[0]['name']}','{$result[0]['value']}')
	");
	
	
db_query(
        "DELETE FROM `{$data['DbPrefix']}emails_templates`".
        " WHERE `key`='{$key}'"
        );

}
if(isset($post['read'])&&$post['read']){
	if(isset($post['template'])&&$post['template']){
		$mail=select_mail_template($post['template']);
		$post['subject']=stripslashes($mail['name']);
		$post['content']=stripslashes($mail['value']);
	}
}elseif(isset($post['send'])&&$post['send']){
	update_mail_template($post['template'], addslashes($post['subject']), addslashes($post['content']));
	$_SESSION['successmsg']="Email Template Update Successfully";
	
}elseif(isset($post['deletetemplate'])&&$post['deletetemplate']){
	delete_mail_template($post['template']);
	$post['template']="";
	$_SESSION['successmsg']="Email Template Deleted Successfully";
}
$post['Templates']=get_mail_templates();
###############################################################################
###############################################################################
display('admins');
###############################################################################
?>
