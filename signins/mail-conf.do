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

if(isset($_GET['a'])&&$_GET['a']&&!isset($post['read'])&&!isset($post['send'])&&!isset($post['add'])){
    $post['template']=$_GET['a'];
    $post['read']=1;
  }
 
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

		if($data['connection_type']=='PSQL'){
			db_query(
				"SELECT setval('".$data['DbPrefix']."emails_templates_id_seq', (SELECT MAX(id) FROM ".$data['DbPrefix']."emails_templates)+1);",0
			);
		}

}

if(isset($post['action'])&&$post['action']=='delete_reset') {

	if($data['connection_type']=='PSQL'){
		db_query(
			"SELECT setval('".$data['DbPrefix']."emails_templates_id_seq', (SELECT MAX(id) FROM ".$data['DbPrefix']."emails_templates)+1);",1
		);
	}

}elseif(isset($post['add'])&&$post['add']){
	if($data['connection_type']=='PSQL'){
		$post['subject']=stripslashes(@$post['subject']);
		$post['content']=stripslashes(@$post['content']);
	}
	else {
		$post['subject']=addslashes(@$post['subject']);
		$post['content']=addslashes(@$post['content']);
	}

	db_query( "INSERT INTO `{$data['DbPrefix']}emails_templates` 
	(`key`,`name`,`value`) VALUES ('{$post['template_key']}','{$post['subject']}','{$post['content']}')");

	$post['template']=$post['template_key'];
	
	if(isset($post['action'])&&$post['action']=='add')unset($post['action']);
	if(isset($_GET['action'])&&$_GET['action']=='add')unset($_GET['action']);

	$_SESSION['successmsg']="Email Template Create Successfully :: ".$post['template_key'];

	$redirect=$data['Admins']."/".$data['PageFile'].$data['ex']."?a=".$post['template_key'];
	header("Location:".$redirect);exit;
	
	
}elseif(isset($post['read'])&&$post['read']){
	if(isset($post['template'])&&$post['template']){
		$mail=select_mail_template($post['template']);
		$post['subject']=stripslashes($mail['name']);
		$post['content']=stripslashes($mail['value']);
	}
}elseif(isset($post['send'])&&$post['send']){
	if($data['connection_type']=='PSQL'){
		$post['subject']=stripslashes(@$post['subject']);
		$post['content']=stripslashes(@$post['content']);
	}
	else {
		$post['subject']=addslashes(@$post['subject']);
		$post['content']=addslashes(@$post['content']);
	}

	update_mail_template($post['template'],$post['subject'],$post['content']);
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
