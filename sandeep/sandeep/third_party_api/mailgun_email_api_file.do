<?
// Dev Tech : 22-12-30


	$post['json_value']['mail_api_name']='mailgun';
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
	curl_setopt($ch, CURLOPT_USERPWD, $mail_gun_api);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
  
	curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
	curl_setopt($ch, CURLOPT_URL, 'https://api.mailgun.net/v3/'.$mail_host.'/messages');
	curl_setopt($ch, CURLOPT_POSTFIELDS, $postArray);
	if(isset($post['HostL'])&&$post['HostL']==1){
		//curl_setopt($ch,CURLOPT_SSL_VERIFYPEER, false); curl_setopt($ch,CURLOPT_SSL_VERIFYHOST, false);
	}
	//curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
	$result = curl_exec($ch);
	curl_close($ch);
	
	$json_decode=json_decode($result,true);
	
	$post['response_status']=(isset($json_decode['message'])?$json_decode['message']:'');
	
?>