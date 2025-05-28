<?
$data['PageName']='SEND MESSAGE TO ALL MERCHANT';

$data['PageFile']='mass-mail';

###############################################################################
include('../config.do');
$data['PageTitle'] = 'Send message to all merchant - '.$data['domain_name'];
###############################################################################

if(!isset($_SESSION['adm_login'])){
	$_SESSION['adminRedirectUrl']=$data['urlpath'];
	header("Location:{$data['Admins']}/login".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

###############################################################################

if(isset($post['send'])&&$post['send']){

	if(!$post['subject']){

		$data['Error']='Please enter subject text for your message.';

	}elseif(!$post['message']){

		$data['Error']='Please enter your message.';

	}else{
	   
	   $messages=nl2br(stripslashes($post['message']));
	   
	   //	 echo addslashes($messages);
	   if(isset($post['acquirer'])&&$post['acquirer']){
			$acquirer=$post['acquirer'];
	   }else{
			$acquirer="";
	   }
		$data['result']=send_mass_email($post['subject'], $messages, $post['rtype'], $acquirer);

		#$data['Error']='This feature does not work in the test mode.';

		$data['PostSent']=true;

	}

}

###############################################################################



###############################################################################

display('admins');

###############################################################################

?>

