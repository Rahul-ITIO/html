<?
include('../config.do');

if(!empty($_POST["email"])) {
$email=$_POST["email"];
$tid=$_POST["tid"];
$query="WHERE `id` = '{$tid}' ";

    $confirm=db_rows("SELECT `newfullname`,`confirm`,`newuser` FROM `{$data['DbPrefix']}unregistered_clientid` {$query} LIMIT 1");
    $newfullname	=$confirm[0]['newfullname'];
    $newuser		=$confirm[0]['newuser'];
    $result			=$confirm[0]['confirm'];

    $post['tableid']=$tid;
	$post['mail_type']="13";
	$post['email_header']=1;
	$post['email_br']=1;
	$post['ccode']=encryptres($result); //encrypt_res
	$post['email']=$email;
	$post['fullname']=$newfullname;
	$post['email_he_on']=1;
	$post['password']=$newpass;
	$post['username']=$newuser;
    $post['chash']=encryptres($result); //encrypt_res
	
	if($result){
		send_email('CONFIRM-TO-MEMBER', $post);	//done
		echo "Email resent to ".$email;
	}else{
	    //echo "Email not sent, try again ";
	}
	

}else{
   //echo "Technical error, please try aftersometime ";
}

// for resend Reset password link
if(!empty($_POST["ccode"])) {
//echo $_POST["ccode"];
//echo $_POST["cemail"];

if($_SESSION['mail_count']==""){
$_SESSION['mail_count']=1;
}else if($_SESSION['mail_count']>4){
echo "Maximum number of try. Please try another 2 hours";exit;
}else{
$_SESSION['mail_count']++;
}



    $post['mail_type']="13";
	$post['email_header']=1;
	$post['email_br']=1;
	$post['ccode']=trim($_POST["ccode"]); //encrypt_res
	$post['email']=trim($_POST["cemail"]);
	$post['username']=trim($_POST["cusername"]);
	$post['uid']=trim($_POST["cuid"]);
	$post['email_he_on']=1;


send_email('CONFIRM-RESET-PASSWORD', $post);
echo $_SESSION['mail_count']." Password reset instruction resent to ".$_POST["cemail"];
}




?>