<?php
include('../config.do');
if($_SESSION['m_username']){ $username=$_SESSION['m_username'];
}elseif($_SESSION['username']){ $username=$_SESSION['username']; }

global $data; 
//echo "--------";exit;
if(!empty($_POST["vid"])) {
     $id=$_POST["vid"];
     $code=$_POST["google_auth_access"];
     $tbl='clientid_table';
     $sitename=$_SESSION['domain_server']['as']['SiteName'];
	 $secret="";
//echo $data['Path'].'/googleLib/GoogleAuthenticator'.$data['iex'];
            if($code==1||$code==3){
			include($data['Path'].'/googleLib/GoogleAuthenticator'.$data['iex']);
			$ga = new GoogleAuthenticator();
			$secret = $ga->createSecret();
			$_SESSION['secret']=$secret;
			$result['secret']=$secret;
			
			$qrCodeUrl = $ga->getQRCodeGoogleUrl($username,$secret,$sitename);
			$_SESSION['qrCodeUrl']=$qrCodeUrl;
			$result['qrCodeUrl']=$qrCodeUrl;
			}


            $query="UPDATE `{$data['DbPrefix']}{$tbl}` SET `google_auth_code`='{$secret}', `google_auth_access`='2' WHERE `id`='{$id}' ";
	db_query($query,0);
	        //json_log_upd($id,$tbl,'2FA Activate'); // for json log history
	        $_SESSION['qrCodeMessage']=$code;
			echo "done";
	
}

$url=$data['USER_FOLDER'];
$_SESSION['googleCode_err']=NULL;
if(isset($_POST['code'])&&$_POST['code'])
{
   
	$code=$_POST['code'];
	$secret=isset($_POST['secret'])&&$_POST['secret']?$_POST['secret']:'';
	
	if(isset($_SESSION['google_auth_code'])&&!isset($_POST['secret'])) 
		$secret=$_SESSION['google_auth_code'];
	
	require_once '../googleLib/GoogleAuthenticator.do';
	$ga = new GoogleAuthenticator();
	$checkResult = $ga->verifyCode($secret, $code, 8);    // 2 = 2*30sec clock tolerance
	
		if ($checkResult) {
			$_SESSION['login']=true;
			$_SESSION['merchant']=true;
			$username=$_SESSION['m_username'];
			$id=$_SESSION['uid'];
			set_last_access($username);
			save_remote_ip((int)$_SESSION['uid'], $_SERVER["REMOTE_ADDR"]);
			user_un_block_time($_SESSION['uid']);
			unset ($_SESSION['showcode']);
			if($data['UseTuringNumber'])unset($_SESSION['turing']);			
			if(isset($_POST['redirect_url'])&&$_POST['redirect_url'])
			{
				$url=@$_POST['redirect_url'];
				header("Location:$url"); exit;
			}elseif(isset($_SESSION['redirect_url'])&&isset($_SERVER['HTTP_REFERER'])){
			 redirect_post($_SESSION['redirect_url'], $_SESSION['send_data']);
			}else{
			 $tbl='clientid_table';
			 $query="UPDATE `{$data['DbPrefix']}{$tbl}` SET  `google_auth_access`='1' WHERE `id`='{$id}' ";
	         db_query($query);
			 json_log_upd($id,$tbl,'2FA Activate'); // for json log history
			 $_SESSION['qrCodeActiveMessage']="Activated";
			 unset($_SESSION['qrCodeMessage']);
			 unset($_SESSION['secret']);
			 unset($_SESSION['qrCodeUrl']);
			 echo  "done";
			}
			
		}else {
			if(isset($_POST['ui_url'])&&$_POST['ui_url'])
			{
			   $_SESSION['googleCode_err']="Wrong Code. Try again.";
				//$url=$url.'/device_confirmations'.$data['ex'];
				$url=@$_POST['ui_url'];
				header("Location:$url"); exit;
			}
			else echo  "Wrong Code. Try again.";
		}

}


?>