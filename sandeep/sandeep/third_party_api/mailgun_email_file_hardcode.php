<?php

// http://localhost/gw/third_party_api/mailgun_email_file_hardcode.php?name=devTech&price=10.50

function send_attchment_message1($email_to,$email_to_name,$email_subject,$email_message,$post='',$email_from='DevTech <devTech@e1pay.com>',$email_reply='info <info@e1pay.com>'){
	
	$curlopt_userpwd='api:bc73b879c7d3a32621334c4913981fb5-0e6e8cad-6a6fec66';
	$curlopt_url='https://api.mailgun.net/v3/noreply.e1pay.com/messages';

	$email_from_name=$email_from;
	if(strpos($email_from,'>')!==false){
		$email_from_name=explode('<',$email_from);$email_from_name=$email_from_name[1];
		$email_from_value=explode('>',$email_from_name);$email_from_value=$email_from_value[0];
		//echo "<hr/>email_from_value:".$email_from_value;
	}

	$email_to_value="$email_to_name <$email_to>";

	
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
	curl_setopt($ch, CURLOPT_USERPWD, $curlopt_userpwd);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

	curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
	curl_setopt($ch, CURLOPT_URL, $curlopt_url);
	curl_setopt($ch, CURLOPT_POSTFIELDS, array('from' => $email_from,
		 'to' => $email_to_value,
		 'h:Reply-To' => $email_reply,
		 'subject' => $email_subject,
		 'html' => $email_message
	));

	curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
	$result = curl_exec($ch);
	curl_close($ch);

	$json_decode=json_decode($result,true);

	if($post){
	  $post['subject']=$email_subject;
	  $post['message']=$email_message;
	  //$post['date']=date('Y-m-d H:i:s');
	  $post['date']=date('Y-m-d H:i:').(date('s')+fmod(microtime(true), 1));
	  $post['response_status']='';
	  $post['response_msg']=$result;
	  $post['status']='1';
	}
	// insert_email_details($post);

	return $result;
}


function sendmailbymailgun($to,$from,$subject,$html,$replyto){
   $mailgun_url='https://api.mailgun.net/v3/mail.ztspay.com';
   $mailgun_api='key-831f358fc91577a53525ae05797e957e';
	
	
	//$mailgun_url='https://api.mailgun.net/v3/mg.webpays.com';
	//$mailgun_api='bc73b879c7d3a32621334c4913981fb5-0e6e8cad-6a6fec66';
	
	$array_data = array(
		'from'=> $from,
		'Sender'=>'WebPays <info@webpays.com>',
		'to'=>'<'.$to.'>',
		'subject'=>$subject,
		'html'=>$html,
		'o:tracking'=>'yes',
		'o:tracking-clicks'=>'yes',
		'o:tracking-opens'=>'yes',
		'h:Reply-To'=>$replyto
    );
    $session = curl_init($mailgun_url.'/messages');
    curl_setopt($session, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
  	curl_setopt($session, CURLOPT_USERPWD, 'api:'.$mailgun_api);
    curl_setopt($session, CURLOPT_SERVER, true);
    curl_setopt($session, CURLOPT_POSTFIELDS, $array_data);
    curl_setopt($session, CURLOPT_HEADER, false);
    curl_setopt($session, CURLOPT_ENCODING, 'UTF-8');
    curl_setopt($session, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($session, CURLOPT_SSL_VERIFYPEER, false);
	
	$response = curl_exec($session);
	curl_close($session);
	$results = json_decode($response, true);

    return $results;
}// end function 




	if(isset($_SERVER['email_to'])){
		
		//$email_from=$_SERVER['email_from'];
		$email_to=$_SERVER['email_to'];
		$email_to_name="";
		$email_subject=$_SERVER['email_subject'];
		$email_message="<html>".$_SERVER['email_message']."</html>";
		if(strpos($email_to,";")!==false){
			$email_to_ex=explode(";",$email_to);
			
			foreach($email_to_ex as $value){
				
				//echo "value".$value."<hr/>";
				$response=send_attchment_message1($value,$email_to_name,$email_subject,$email_message); $response2=json_decode($response,true);
			}
			
			
		}else{

			$response=send_attchment_message1($email_to,$email_to_name,$email_subject,$email_message); $response2=json_decode($response,true);
		}
		
		//echo "<hr/>response=".$response;
	}else{
	
			
		$email_from="website2 <info@website2.website.com>";
		$email_to="dev@bigit.io";
		$email_to_name="Dev Tech Kumar";
		$email_subject="Mailgun Successfully Email has been received from website2.website";
		$email_message="<html><h1>Hello, website2.website</h1><p>Mailgun Successfully Email has been received</p></html>";

			if(isset($_SERVER)){
				$email_message.="<p><b>_SERVER</b>".json_encode($_SERVER)."</p>";
			}
			if(isset($_POST)){
				$email_message.="<p><b>_POST</b>".json_encode($_POST)."</p>";
			}
			if(isset($_GET)){
				$email_message.="<p><b>_GET</b>".json_encode($_GET)."</p>";
			}

		 $response=send_attchment_message1($email_to,$email_to_name,$email_subject,$email_message);	
		 
		
		$response=json_decode($response,true);
		print_r($response);
	
	}
	
	/*
	if(isset($response2)&&$response2){
		$pst['msg']="Your message has been successfully sent on ".$email_to;
	}else{
		$pst['msg']="Try again .";
	}
	header("Content-Type: application/json", true);
	echo $arrayEncoded2 = json_encode($pst,true); exit;
	*/
	
?>
