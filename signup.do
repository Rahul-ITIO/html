<? $data['PageName']='SIGN UP FOR YOUR FREE ACCOUNT TODAY';
$data['PageFile']='signup';
$data['HideMenu']=true;
$data['HideAllMenu']=true;
###############################################################################
include('config.do');
###############################################################################
$data['PageTitle'] = 'High Risk Merchant Account Sign up -  '.$data['domain_name'];

if(isset($_GET['r'])){
	echo "<br/>sponsor=>".$post['sponsor'];
	echo "<br/>sponsor _SESSION=>".$_SESSION['sponsor'];
	echo "<br/>sponsor_username=>".$_SESSION['sponsor_username'];
	echo "<br/>rid _COOKIE=>".$_COOKIE['rid'];
	echo "<br/>rid=>".$_GET['rid'];
}


if(isset($data['loginSingForgot'])&&$data['loginSingForgot']=="disable"){
	echo $data['loginSingForgotMsg'];
	exit;
}

// Get a key from https://www.google.com/recaptcha/admin/create
$publickey = "6Ld3c-YSAAAAAIIdQocSje_bq1a7Sti3QymRM5hw";
$privatekey = "6Ld3c-YSAAAAAJqrQBNAR_Qb40Mh4BveQ_q8bjv0";

# the response from reCAPTCHA
$resp = null;
# the error code from reCAPTCHA, if any
$error = null;

if(isset($_SESSION['login'])&&$_SESSION['login']){
	header("Location:{$data['Host']}/user/index".$data['iex']);
	echo('Logged In');
	exit;
}



if(!isset($_SESSION['token_sign'])){
    $_SESSION['token_sign'] = md5(uniqid(rand(), TRUE));
    $_SESSION['token_sign_time'] = time();
}
if(!isset($_SESSION['token_forgot'])){
    $_SESSION['token_forgot'] = md5(uniqid(rand(), TRUE));
    $_SESSION['token_forgot_time'] = time();
}



//if($post['action']=='go')optimize('common');
$domain_server=$_SESSION['domain_server'];

$refeneceId=3;
$domain_server=domain_serverf("","merchant");
//$domain_server=domain_serverf("checkdebit.net","merchant");
$_SESSION['domain_server']=$domain_server;
$domain_server=$_SESSION['domain_server'];

if($domain_server['STATUS']==true){
		 $refeneceId=$domain_server['sub_id'];
}

$json_action=false; $curl_validation=false; $http_referer_validation=true;
$username_alert='username';
			


if(isset($data['con_name'])&&$data['con_name']=='clk'){
	$curl_validation=true;
	//$username_alert='Mobile Number';
	$username_alert='User Name';
}
if(isset($post['send'])&&isset($data['con_name'])&&$data['con_name']=='clk'&&$post['send']=='signupbycurl'){
//if($data['con_name']=='clk'){
	$json_action=true;
	
	if(isset($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
		$http_referer_validation=false;
	}
	
}


//echo $refeneceId;
if(isset($post['send'])&&$post['send']){
	//$post=isset($post)&&$post?$post:'';
	
	$password=isset($post['password'])&&$post['password']?$post['password']:'';
	
	//cmn
	//$post['newuser']='temp'.md5(uniqid(rand(), true));
	
	if(empty($post['token_sign'])){ 
		$data['Error']="Token not empty due to Cross-site request forgery (CSRF)";
		$pra['Error']=$data['Error'];
		if($json_action == true) {
			json_print($pra);
		}
	}
	elseif($_SESSION['token_sign']!=$post['token_sign']){ 
		$data['Error']="Token mismatch due to Cross-site request forgery (CSRF)";
		$pra['Error']=$data['Error'];
		if($json_action == true) {
			json_print($pra);
		}
	}
	elseif((strpos($_SERVER['HTTP_REFERER'],'/signup')===false)&&($http_referer_validation == true)){ 
		$data['Error']="Account Takeover due to Cross-site request forgery (CSRF)".$_SERVER['HTTP_X_REQUESTED_WITH'];
		$pra['Error']=$data['Error'];
		if($json_action == true) {
			json_print($pra);
		}
	}elseif(!$post['newuser']){
		$data['Error']="Your {$username_alert} can not be empty.";
		$pra['Error']=$data['Error'];
		if($json_action == true) {
			json_print($pra);
		}
	}elseif(verify_username($post['newuser'])){
		$data['Error']="For your {$username_alert} you can use only next letters [A..Z, a..z, 0..9].";
		$pra['Error']=$data['Error'];
		if($json_action == true) {
			json_print($pra);
		}
	}elseif(((!($post['newmail']))||(!verify_email2($post['newmail'])))&&($curl_validation == true)){
		$data['Error']='Please enter your valid e-mail address.';
		$pra['Error']=$data['Error'];
		if($json_action == true) {
			json_print($pra);
		}
    }elseif(!is_user_available($post['newuser'])){
		$data['Error']="Sorry but this {$username_alert} - {$post['newuser']} already exists. Please change.";
		$pra['Error']=$data['Error'];
		if($json_action == true) {
			json_print($pra);
		}
	}/*elseif(!is_mail_available($post['newmail'])){
		
		$data['Error']='Sorry but this e-mail address already exists. Please change.';
		$pra['Error']=$data['Error'];
		if($json_action == true) {
			json_print($pra);
		}
		
	}*/
	elseif(($post['newmail']) && (!verify_email2($post['newmail']))&&($curl_validation == true)){
		$data['Error']='Please enter your valid e-mail address.';
		$pra['Error']=$data['Error'];
		if($json_action == true) {
			json_print($pra);
		}
    }
	/*
	elseif(!$post['password'] && $curl_validation == true){
		$data['Error']='Please enter your password.';
		$pra['Error']=$data['Error'];
		if($json_action == true) {
			json_print($pra);
		}
	}
	elseif(!preg_match("#[0-9]+#",$password) && $curl_validation == true) {
        $data['Error'] = 'Your Password Must Contain At Least 1 Number';
		$pra['Error']=$data['Error'];
		if($json_action == true) {
			json_print($pra);
		}
    }
	elseif(!preg_match("#[A-Z]+#",$password) && $curl_validation == true) {
        $data['Error'] = "Your Password Must Contain At Least 1 Capital Letter";
		$pra['Error']=$data['Error'];
		if($json_action == true) {
			json_print($pra);
		}
    }
	elseif(!preg_match("#[a-z]+#",$password) && $curl_validation == true) {
       $data['Error'] = "Your Password Must Contain At Least 1 Lowercase Letter";
	   $pra['Error']=$data['Error'];
		if($json_action == true) {
			json_print($pra);
		}
    }
	elseif((strlen($password)<10) && ($curl_validation==true) ){
       $data['Error'] = "Your Password Must be min. 10 Characters Long";
	    $pra['Error']=$data['Error'];
		if($json_action == true) {
			json_print($pra);
		}
    }
	*/
	else{
		
		
		
		if($json_action == true) {
			
		}else{
			//$post['password']=generate_password(10);
		} 
		
		if(isset($_SESSION['sponsor_id'])&&$_SESSION['sponsor_id']&&$_SESSION['sponsor_username']){
			$get_sponsor['sponsor_id']=$_SESSION['sponsor_id'];
			$get_sponsor['sponsor_username']=$_SESSION['sponsor_username'];
			$get_sponsor['sponsor_host']=$data['Host'];
			$get_sponsor['sponsor_parentId']=$refeneceId;
			$get_sponsor['sponsor_parentUserName']=$domain_server['sub_username'];
			$post['sub_sponsor']=jsonencode($get_sponsor);
		}
		
		$post['password']=((isset($post['password'])&&$post['password'])?$post['password']:'');
		$post['sub_sponsor']=((isset($post['sub_sponsor'])&&$post['sub_sponsor'])?$post['sub_sponsor']:'');
		$post['newansw']=((isset($post['newansw'])&&$post['newansw'])?$post['newansw']:'');
		$post['fullname']=((isset($post['fullname'])&&$post['fullname'])?$post['fullname']:'');
		
		
		$_SESSION['newmail']=@$post['newmail'];
		
		$newid=create_confirmation(
			@$post['newuser'],
			@$post['newmail'],
			@$post['fullname'],
			@$refeneceId,
			@$post['sub_sponsor']
		);
		
		/*
		$newid=create_confirmation(
			@$post['newuser'],
			@$post['password'],
			@$post['sub_sponsor'],
			@$post['newansw'],
			@$post['newmail'],
			
//			@$post['newlname'],
			@$post['newcompany'],
			@$post['newregnum'],
			@$post['newdrvnum'],
			@$post['newaddress'],
			@$post['newcity'],
			@$post['newcountry'],
			@$post['newstate'],
			@$post['newzip'],
			@$post['newphone'],
			@$post['newfax'],
			@$refeneceId
		);
		*/
		
		$post['cnf_newid']=$newid; // for resend email call by ajax & jquery
		
		unset($_SESSION['turing']);
		
		$_SESSION['token_sign'] = md5(uniqid(rand(), TRUE));
		$_SESSION['token_sign_time'] = time();

		$_SESSION['token_forgot'] = md5(uniqid(rand(), TRUE));
		$_SESSION['token_forgot_time'] = time();
		
		
		
		$data['PostSent']=true;
		
		$pra['msg']="You have successfully singup. Please check your email and verify for Sign In";
		
		if($json_action == true) {
			json_print($pra);
		}
		
	}
}else{
	if($data['UseTuringNumber'])$_SESSION['turing']=gencode();
}

###############################################################################
display('user');
###############################################################################
?>