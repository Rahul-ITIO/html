<?php
$data['SponsorDomain']=true;
$data['NO_SALT']=true;
include('../config.do');
if(!isset($_SESSION['adm_login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	echo('ACCESS DENIED.');
    exit;
}
if(isset($_GET['msg_eml'])&&$_GET['msg_eml']){
	$msg_eml=$_GET['msg_eml'];
	$message_row=select_tablef("`id`='{$msg_eml}'","email_details",0,1,"`message`");
	//print_r($message_row);
}

//if(!isset($_SESSION)) {session_start();}	
?>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
</head>

<body style="margin:0px;padding:0px;width:100%;height:100%;background:#fff;font:12px/14px Verdana,Tahoma,Trebuchet MS,Arial;color: #555555;">
<?php 
if(isset($_GET['msg'])&&$_GET['msg']){
	//echo  $_GET['msg'];
}
?>
<?php 
if(isset($_GET['msg_eml'])&&$_GET['msg_eml']){
	echo($message_row['message']);
}
?>
</body>
</html>