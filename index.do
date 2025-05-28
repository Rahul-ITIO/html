<?
$data['PageName']='USER LOGIN';
$data['PageFile']='login';
$data['HideAllMenu']=true;
###############################################################################

include('config.do');

$data['PageTitle'] = 'Login - '.$data['domain_name']; 

if(isset($data['loginSingForgot'])&&$data['loginSingForgot']=="disable"){
	echo $data['loginSingForgotMsg'];
	exit;
}

if(($data['con_name']=='clk')&&(!isset($data['FrontUI']))){
	$data['PageFile']='login_clk';	
}
if(($_SERVER["HTTP_HOST"]=='192.168.1.6')&&(!isset($data['FrontUI']))){
	$data['PageFile']='login_sys';	
}
//$data['PageFile']='login_sys';	
//$data['PageFile']='login_clk';$data['con_name']='clk';


if(!isset($_SESSION['token_sign'])){
	$_SESSION['token_sign'] = md5(uniqid(rand(), TRUE));
	$_SESSION['token_sign_time'] = time();
}
if(isset($_REQUEST['pq'])){
	echo "<hr/>HTTP_REFERER=>".$_SERVER['HTTP_REFERER'];
}

if(!isset($_SESSION['token_forgot'])){
	$_SESSION['token_forgot'] = md5(uniqid(rand(), TRUE));
	$_SESSION['token_forgot_time'] = time();
}


###############################################################################

if(!isset($_SESSION['attempts'])) $_SESSION['attempts']=0;
###############################################################################
//require_once('user/recaptchalib'.$data['iex']);
//print_r($data['USEsmsPin']);

// Get a key from https://www.google.com/recaptcha/admin/create
$publickey = "6Ld3c-YSAAAAAIIdQocSje_bq1a7Sti3QymRM5hw";
$privatekey = "6Ld3c-YSAAAAAJqrQBNAR_Qb40Mh4BveQ_q8bjv0";

# the response from reCAPTCHA
$resp = null;
# the error code from reCAPTCHA, if any
$error = null;

$server_name=$_SERVER['SERVER_NAME'];

$json_action=false; $curl_validation=false; $http_referer_validation=true;
if(isset($post['send']) && $post['send']=='curl'){
	$json_action=true; $curl_validation=true;
	
	if(isset($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
		$http_referer_validation=false;
	}
}


if(strpos($_SERVER['REQUEST_URI'],"/mlogin")!==false){
	header("Location:{$data['Admins']}/login".$data['ex']);
	exit;
}

if(!isset($post['send'])){ unset($_SESSION['attempts']);}
function redirect_post_use($url, array $data)
{
    ?>
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <script type="text/javascript">
            function closethisasap() {
                document.forms["redirectpost"].submit();
            }
        </script>
    </head>
    <body onLoad="closethisasap();">
    <form name="redirectpost" method="post" action="<?php echo $url; ?>">
        <?php
        if ( !is_null($data) ) {
            foreach ($data as $k => $v) {
                echo '<input type="hidden" name="' . $k . '" value="' . $v . '"> ';
            }
        }
        ?>
    </form>
    </body>
    </html>
    <?php
    exit;
}

if(isset($_SESSION['login']) && $_SESSION['login']){
	header("Location:{$data['Host']}/user/index".$data['ex']);
	exit;
}
//$countryName=getLocationInfoByIp($_SERVER['REMOTE_ADDR']);


$domain_server=domain_serverf("","merchant");

//$domain_server=domain_serverf("localhost.net","merchant");
$_SESSION['domain_server']=$domain_server;
$domain_server=$_SESSION['domain_server'];
//print_r($domain_server);

$refeneceId=3;
if($domain_server['STATUS']==true){
	$refeneceId=$domain_server['sub_id'];
}

$cross_domain_valid=1;

$cross_domain_login=["localhost"];
//print_r($cross_domain_login);
if(isset($server_name)&&$server_name&&in_array($server_name,$cross_domain_login)){
	$cross_domain_valid=0;
}



$today=date("d/m/y");

$data['PassAtt']=10;

if(isset($post['validate']) && $post['validate']){
if($_SESSION['CSESID']&&$_SESSION['CSESID']!=''){
	if($_SESSION['CSESID']!=$_POST['sessionpin']){
		$data['Error']="Please enter valid PIN";
        $data['pinsmssend']=true;
	}else {
    		unset($_SESSION['attempts']); 
			$_SESSION['uid']=get_clients_id($post['username'], $post['password']);
			$_SESSION['login']=true;
			set_last_access($post['username']);
			save_remote_ip((int)$_SESSION['uid'], $_SERVER["REMOTE_ADDR"]); 
			if($data['UseTuringNumber'])unset($_SESSION['turing']); 
            $data['pinsmssend'] = false;
            unset($_SESSION['CSESID']);
			$url=("{$data['Host']}/user/index".$data['ex']);
			if($json_action == true) {
				$pra['msg']="Direct successfully Login. Avail the service of Dashboard!";
				$pra['url']=$url;
				json_print($pra);
			}else{
				header("Location:$url");
			}
			exit;
    }
   
   (int)$_SESSION['attempts']++;   	
}

}

else if(isset($post['send']) && $post['send']){	
	// checking if user blocked temporary for 30 minutes
	 if(is_clients_active($post['username'],'clientid_table')){
		  $uid=get_clients_id($post['username']);
		  $status=check_user_block_time($uid,'clientid_table');
	  }
	  else {$status=31;}
  	
	(int)$_SESSION['attempts']++;
	$post['password']=hash_f($post['password']);
	//if ($_SESSION['attempts']==1){$_SESSION['username']=$post['username'];}

	if (isset($_SESSION['username'])&&$_SESSION['username']!=$post['username']){
		$_SESSION['attempts']=1;
		$_SESSION['username']=@$post['username'];
	}
	
	if(($_SESSION['attempts']<$data['PassAtt'])&&($status>30)){
        if(!$post['username']){
                $data['Error']='Your username can not be empty.';
				$pra['Error']=$data['Error'];
				if($json_action == true) {
					json_print($pra);
				}
        }
		elseif(empty($post['token_sign'])){ 
			$data['Error']="Token not empty due to Cross-site request forgery (CSRF)";
			$pra['Error']=$data['Error'];
			if($json_action == true) {
				json_print($pra);
			}
		}
		/*
		elseif($_SESSION['token_sign']!=$post['token_sign']){ 
			//$pr='| s_token_sign: '.$_SESSION['token_sign'].' | p_token_sign: '.$post['token_sign'];
			$data['Error']=$data['SiteName']." utilizes cookies to verify and secure our Merchants on the Dashboard. A key security cookie is missing from your device. Please ensure that cookies are enabled in your browser, refresh the Sign In page and try again.".$pr;
			$pra['Error']=$data['Error'];
			if($json_action == true) {
				json_print($pra);
			}
		} 
		*/
		/*
		elseif((((strpos($_SERVER['HTTP_REFERER'],'/index')===false)||(strpos($_SERVER['HTTP_REFERER'],'/login')===false))&&($http_referer_validation == true))&&($data['con_name']=='clk')){ 
			$data['Error']="Account Takeover due to Cross-site request forgery (CSRF)".$_SERVER['HTTP_X_REQUESTED_WITH'];
			$pra['Error']=$data['Error'];
			if($json_action == true) {
				json_print($pra);
			}
		}
		*/
		elseif(!$post['password']){
                $data['Error']='Your password can not be empty.';
				$pra['Error']=$data['Error'];
				if($json_action == true) {
					json_print($pra);
				}
        }elseif($data['UseTuringNumber']&&(!$post['turing']||strtoupper($post['turing'])!=$_SESSION['turing'])){
				$data['Error']='Please enter valid turing number.';
				$pra['Error']=$data['Error'];
				if($json_action == true) {
					json_print($pra);
				}
        }elseif(isset($data['USEsmsPin']) && $data['USEsmsPin']==1){
      
    	}elseif(!is_clients_active($post['username'],'clientid_table')){
                $data['Error']='Invalid Login details.';
				$pra['Error']=$data['Error'];
				if($json_action == true) {
					json_print($pra);
				}
        }
		
		elseif( (!is_sponsor_clients($post['username'],$refeneceId))  && ( $data['con_name']!='clk' ) && ($cross_domain_valid) ){
               $data['Error']='This user was not found in the system.';
			   $pra['Error']=$data['Error'];
				if($json_action == true) {
					json_print($pra);
				}
        }
		elseif(!is_clients_found($post['username'], $post['password'])){
           $data['Error']='Your have entered a wrong username or password.';
		   	$pra['Error']=$data['Error'];
			if($json_action == true) {
				json_print($pra);
			}
       /* }elseif(is_clients_login_same_country($post['username'], $post['password'])!=$countryName){
          $data['Error']='Your have No access at this time.';
		  	$pra['Error']=$data['Error'];
			if($json_action == true) {
				json_print($pra);
			}
			
			*/
        } 
		/*elseif(is_clients_block($post['username'])==0){
           $data['Error']="Your have BLOCK at this time.";
		   $pra['Error']=$data['Error'];
			if($json_action == true) {
				json_print($pra);
			}
        }
		*/
		else{
						
			
			
			$_SESSION['google_auth']=false;
			
			##########################################
					
        	unset($_SESSION['CSESID']);
			
			if(isset($post['remember'])&&$post['remember']){
				$cookie_name = $post['username'];
				$cookie_pass = $_POST['password'];
				$cookie_remember = $post['remember'];
			}else{
				$cookie_name = "";
				$cookie_pass = "";
				$cookie_remember = "";
			}
			//echo $cookie_remember;exit;
            if($data['ztspaypci']==false){
			setcookie("username", $cookie_name, time() + (86400 * 900), "/"); // 86400*30 = 1 day
			setcookie("password", $cookie_pass, time() + (86400 * 900), "/");
			setcookie("remember", $cookie_remember, time() + (86400 * 900), "/");
           }
           
			
			$result=db_rows("SELECT `username`,`google_auth_access`,`google_auth_code`,`sub_client_id`,`sub_client_role`,`registered_email`,`fullname`,`company_name`,`json_value` FROM `{$data['DbPrefix']}clientid_table` WHERE `username`='".$post['username']."'",0);
			$result=$result[0];
			//$phone=$result['phone'];
			$_SESSION['google_auth_code']=$google_auth_code=$result['google_auth_code'];
			$google_auth_access=$result['google_auth_access'];
			
			$login_type=true;
			
			$_SESSION['m_first_name']=$result['fullname'];
		
            $_SESSION['m_company']=$result['company_name'];



			
			$member_json_value=jsondecode(@$result['json_value']);
	
			//Dev Tech: 24-12-31 view from Account manager ID 
			if(isset($_SESSION['m_acc_man'])) unset($_SESSION['m_acc_man']);
			if(isset($data['ACCOUNT_MANAGER_ENABLE'])&&@$data['ACCOUNT_MANAGER_ENABLE']=='Y'){
				$_SESSION['m_acc_man']=account_manager_fetch(@$member_json_value['account_manager_id'],2);
			}
			
			
			
			//echo $result['username'];exit;
			if(!isset($result['username']) || $result['username']==""){
				$_SESSION['errmsg']="Wrong Username / Password";
				header("Location:{$data['Host']}/user/index".$data['ex']);
				exit;
			}
			
			$post['username']=prntext($post['username']);
			$_SESSION['m_username']=$post['username'];
			//$post['password']=prntext($post['password']);
			
			if($result['sub_client_id']){  //change by vikash
				$_SESSION['m_clients_id']=$result['sub_client_id'];
				$_SESSION['m_clients_role']=$result['sub_client_role'];
				$_SESSION['m_clients_type']="Sub Member";
				$_SESSION['m_clients_name']=$post['username'];
				
				$_SESSION['uid']=$uid=$result['sub_client_id'];
			}else{
				$_SESSION['uid']=$uid=get_clients_id($post['username'], $post['password']);
			}
			

			//Info of payin setting
			$ps_get=select_tablef(" `clientid`={$uid} ",'payin_setting',0,1,"`settlement_optimizer`,`payin_theme`,`available_balance`,`available_rolling`,`monthly_fee`,`settlement_fixed_fee`,`settlement_min_amt`,`frozen_balance`");

			if(@$ps_get['settlement_optimizer']) $_SESSION['m_settlement_optimizer']=@$ps_get['settlement_optimizer'];


						
			##### unset array value withdraw ##################################################
				
				//unset array value withdraw for v1

				if(isset($_SESSION['uid_'.$uid]['trans_detail_array'])) unset($_SESSION['uid_'.$uid]['trans_detail_array']);
				if(isset($_SESSION['uid_'.$uid]['ab'])) unset($_SESSION['uid_'.$uid]['ab']);
				if(isset($_SESSION['uid_'.$uid]['payout'])) unset($_SESSION['uid_'.$uid]['payout']);
				if(isset($_SESSION['uid_'.$uid]['deduction_array_ajax'])) unset($_SESSION['uid_'.$uid]['deduction_array_ajax']);
				if(isset($_SESSION['uid_'.$uid]['payout_array_ajax'])) unset($_SESSION['uid_'.$uid]['payout_array_ajax']);

				
				if(isset($_SESSION['uid_'.$uid])){
					unset($_SESSION['uid_'.$uid]);
				}


				//unset array value withdraw for v2 and v2 use in v3

				if(isset($_SESSION['uid_wv2'.$uid]['trans_detail_array'])) unset($_SESSION['uid_wv2'.$uid]['trans_detail_array']);
				if(isset($_SESSION['uid_wv2'.$uid]['ab'])) unset($_SESSION['uid_wv2'.$uid]['ab']);
				if(isset($_SESSION['uid_wv2'.$uid]['payout'])) unset($_SESSION['uid_wv2'.$uid]['payout']);
				if(isset($_SESSION['uid_wv2'.$uid]['deduction_array_ajax'])) unset($_SESSION['uid_wv2'.$uid]['deduction_array_ajax']);
				if(isset($_SESSION['uid_wv2'.$uid]['payout_array_ajax'])) unset($_SESSION['uid_wv2'.$uid]['payout_array_ajax']);

				
				if(isset($_SESSION['uid_wv2'.$uid])){
					unset($_SESSION['uid_wv2'.$uid]);
				}
				
				if(isset($_SESSION['last_withdraw_micro_current_date_'.$uid]))
					unset($_SESSION['last_withdraw_micro_current_date_'.$uid]);
				

			#######################################################
					

			

			//unset pagination form multi connection 
			if(isset($_SESSION['next_pg'])) unset($_SESSION['next_pg']);
			if(isset($_SESSION['prev_pg'])) unset($_SESSION['prev_pg']);
			
			
			set_last_access($post['username']);
			
			$remote_addr=((isset($_SERVER['HTTP_X_FORWARDED_FOR'])&&$_SERVER['HTTP_X_FORWARDED_FOR'])?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR']);
			
			save_remote_ip((int)$_SESSION['uid'], $remote_addr);
			
			
			/*
			######	ip email to merchant : start 	##########################
			
			
				$post['email']= encrypts_decrypts_emails(trim($result['registered_email']),2);
				$post['username']=$result['username'];
				$post['fullname']=$result['fullname'];
				$post['uid']=$uid;
				
				
				$post['tableid']=$uid;
				$post['mail_type']="17";
				$post['email_header']=1;
				$post['email_br']=1;
				
				send_email('IP-ADDRESS-CONFIRMATION', $post);
				
			######	ip email to merchant : end 	##########################
			
			*/
			
			
			
			
			// google auth code		
			if(($uid)&&($google_auth_access==1||$google_auth_access==3)&&($google_auth_code)){
				
				unset($_SESSION['attempts']);
				$_SESSION['google_auth']=true;
				$url=$data['USER_FOLDER'].'/device_confirmations'.$data['ex'];
				if($json_action == true) {
					$pra['msg']="Successfully this process. Continue MFA for avail the service of Dashboard!";
					$pra['url']=$url;
					json_print($pra);
				}else{
					header("Location: $url");
				}
				exit;
			}
			unset($_SESSION['attempts']);
			
			
			
			$_SESSION['merchant']=true;
			$_SESSION['login']=true; 
			
			$_SESSION['token_sign'] = md5(uniqid(rand(), TRUE));
			$_SESSION['token_sign_time'] = time();

			$_SESSION['token_forgot'] = md5(uniqid(rand(), TRUE));
			$_SESSION['token_forgot_time'] = time();




			
			user_un_block_time($_SESSION['uid'],'clientid_table');
			if($data['UseTuringNumber'])unset($_SESSION['turing']);
			if(isset($_SESSION['redirect_url'])&&isset($_SERVER['HTTP_REFERER'])){
			 redirect_post_use($_SESSION['redirect_url'], $_SESSION['send_data']);
			}else{
				if(isset($_GET['redirect_url'])&&(!empty($_GET['redirect_url']))){
					echo"
					<script>
						top.window.location.href='{$_GET['redirect_url']}';
					</script>
					";
					exit;
				}elseif(isset($_SESSION['redirectUrl'])&&(!empty($_SESSION['redirectUrl']))){
					$redirectUrl=$_SESSION['redirectUrl'];
					unset($_SESSION['redirectUrl']);
					
					if($json_action == true) {
						$pra['msg']="Successfully Login. Avail the service of Dashboard!";
						$pra['url']=$redirectUrl;
						json_print($pra);
					}else{
						header("Location: $redirectUrl");
					}
					exit;
					
				}else{
					$url=("{$data['Host']}/user/index".$data['ex']);
					
					if($json_action == true) {
						$pra['msg']="Successfully Login. Avail the service of Dashboard!";
						$pra['url']=$url;
						json_print($pra);
					}else{
						header("Location: $url");
					}
					exit;
				}
			}
			echo('ACCESS DENIED.');
			exit;

        }

        

   }else{

      if(is_clients_active($post['username'],'clientid_table')){
		  $uid=get_clients_id($post['username']);
		  user_block_time($uid,'clientid_table');
	  }
	  
	  if($data['UseTuringNumber'])unset($_SESSION['turing']);
     	//unset($_SESSION['attempts']);
      $data['CantLogin']=true;

   }

}

if(isset($_SESSION['attempts'])) $data['attempts']=$_SESSION['attempts'];

###############################################################################

if(isset($data['UseTuringNumber']) && $data['UseTuringNumber']) $_SESSION['turing']=gencode();

if(!isset($_COOKIE["remember"])) {
    //echo "Cookie named : '" . $_COOKIE["username"] . "' is not set!";
} else {
    //echo "<hr/>Cookie : '" . $_COOKIE["username"] . "' is set!<br>";
    //echo "<hr/>Value is User Name : " . $_COOKIE["username"];
	//echo "<hr/>Value is User Pass : " . $_COOKIE["password"];
	
	//$post['username']=$_COOKIE["username"];
	//$post['password']=$_COOKIE["password"];
	//$post['remember']=$_COOKIE["remember"];
}

//echo "<hr/>HTTP_COOKIE=>".$_SERVER['HTTP_COOKIE'];

display('user');
###############################################################################

?>

