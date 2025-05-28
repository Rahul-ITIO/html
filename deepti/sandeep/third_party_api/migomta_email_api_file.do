<?
//$qp=1;

$post['json_value']['mail_api_name']='migomta';

##############################################

//$email_message=htmlentitiesf($email_message);
//$email_message=stripslashes($email_message);
//$email_message=str_replace(utf8_encode("Â"),"",$email_message);

/*
$email_message=ltrim($email_message,'"');
$email_message=rtrim($email_message,'"');
$email_message="'".($email_message)."'";
*/

$email_message=str_replace('\\', '', $email_message);
$email_message=addslashes($email_message);

$email_message=preg_replace('/\n+|\t+|\s+/',' ',$email_message);
$email_message=str_replace( array( "style='","'>" ), array( 'style="','">' ), $email_message);
$email_message=str_replace( array( "’","'","’","{","}","�" ), ' ', $email_message);

//$email_message=mb_detect_encoding($email_message, 'UTF-8');
//$email_message=mb_detect_encoding($email_message, ['ASCII', 'UTF-8', 'ISO-8859-1'], true);
//$email_message=filter_var($email_message, FILTER_SANITIZE_EMAIL);
//$email_message=html_entity_decode($email_message);

$email_subject=($email_subject);

//ob_start("prepare");


$dataEmail='{
    "to": ["'.$email_to.'"
],
    "from": "'.$email_reply.'",  
    "subject": "'.$email_subject.'",
    "html_body": "'.$email_message.'"
}';


/*
$dataEmail = <<<DATA
{
    "to": ["$email_to"
],
    "from": "$email_reply",  
    "subject": "$email_subject",
    "html_body": "$email_message"
}
DATA;
*/
$url_migomta = "https://sn4.migomta.one/api/v1/send/message";

$curl = curl_init($url_migomta);
curl_setopt($curl, CURLOPT_URL, $url_migomta);
curl_setopt($curl, CURLOPT_POST, true);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
$headers = array(
   "X-Server-API-Key: ".$mail_migomta_api,
   "Content-type: application/json",
);
curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
curl_setopt($curl, CURLOPT_POSTFIELDS, $dataEmail);
	//curl_setopt($curl, CURLOPT_MAXREDIRS, 10);
	//curl_setopt($curl, CURLOPT_TIMEOUT, 30);
//for debug only!
curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);

$result = curl_exec($curl);
curl_close($curl);

//ob_end_flush();ob_end_clean();	


//ob_end_flush();

if($qp)
{
	echo "<br/><br/>dataEmail1=><br/>".($dataEmail);echo "<br/><br/>";
	//echo "<br/><br/>dataEmail=><br/>";var_dump($dataEmail);echo "<br/><br/>";
}


//$dataEmail='';
##############################################

$json_decode=json_decode($result,true);

if(isset($json_decode['data']['messages'])){
	//unset($json_decode['data']['messages']);
} 


if(isset($json_decode['status'])&&$json_decode['status']=='success'){
	$result=json_encode($json_decode);
	$email_to_mask=mask_email($email_to);
	$result=str_ireplace($email_to, $email_to_mask, $result );
	$post['response_status']="Queued. Thank you.";
	if($qp)
	{	
		echo "<hr/>email_status=>".$json_decode['status'];
	}
}
else{
	$post['response_status']=$result;
	//echo "<br/><br/><hr/>result error=>".$result;exit;
}

if($qp)
{
	echo "<hr/>mail_api_name=>".$post['json_value']['mail_api_name'];
	echo "<hr/>email_url=>".$url_migomta;
	echo "<hr/>email_api_key=>".$mail_migomta_api;
	
	echo "<br/><br/><hr/>email_to=>".$email_to;
		//echo "<hr/>email_from=>".$email_from;
	echo "<hr/>email_reply=>".$email_reply;
	echo "<hr/>email_subject=>".$email_subject;
	echo "<hr/>email_message=>".$email_message;
	
	echo "<br/><br/><hr/>result=>".($result);
	//echo "<br/><br/><hr/>json_decode=>"; var_dump($json_decode);
}
?>