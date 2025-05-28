<?php
// /include/emails.php?name=dev

include('../config_db.do');

	$email_from="Dev <dev@bigit.io>";
	$email_to=$data['testEmail_1'];
	$email_to_name="Dev Tech";
	$email_subject="Mailgun Successfully Email has been received from {$_SERVER["HTTP_HOST"]}";
	$email_message="<html><h1>Hello, {$_SERVER["HTTP_HOST"]}</h1><p>Mailgun Successfully Email has been received</p></html>";
	
	if(isset($_SERVER)){
		$email_message.="<p><b>_SERVER</b>".json_encode($_SERVER)."</p>";
	}
	if(isset($_POST)){
		$email_message.="<p><b>_POST</b>".json_encode($_POST)."</p>";
	}
	if(isset($_GET)){
		$email_message.="<p><b>_GET</b>".json_encode($_GET)."</p>";
	}


	echo $response=send_attchment_message($email_to,$email_to_name,$email_subject,$email_message);	
		
	echo "<hr/>response=".$response;
	echo "<hr/>json_decode=".json_decode($response,true);
	print_r($response);
	
?>
