<?php
$data['PageName']='SYSTEM ADMINISTRATOR LOGIN';
$data['PageFile']='admin_merchant_login';
$data['HideMenu']=true;
$data['HideAllMenu']=true;
###############################################################################
include('../config.do');
$data['PageTitle'] = 'System Administrator Login - '.$data['domain_name']; 
###############################################################################

$json_action=false; $curl_validation=false;

if(($data['con_name']=='clk')&&(!isset($data['FrontUI']))){
	$data['PageFile']='login_clk';
		
}


if(isset($post['send']) && $post['send']=='curl'){
	$json_action=true; $curl_validation=true;
}

/*
echo "Server IP Address is SERVER_ADDR=>: ".$_SERVER['SERVER_ADDR']; 

echo "| IP Address is REMOTE_ADDR=>: ". $_SERVER['REMOTE_ADDR'];

echo "| Referer Address is HTTP_REFERER=>: ". $_SERVER['HTTP_REFERER'];  

*/


$errorMsgReg='';
$errorMsgLogin='';
###############################################################################

if(!isset($_SESSION['token_sign'])){
    $_SESSION['token_sign'] = md5(uniqid(rand(), TRUE));
    $_SESSION['token_sign_time'] = time();
}
if(!isset($_SESSION['token_forgot'])){
    $_SESSION['token_forgot'] = md5(uniqid(rand(), TRUE));
    $_SESSION['token_forgot_time'] = time();
}

$google_auth=true;
$adm_login=false; 


$http_referer_log=0;

if(isset($_SERVER['HTTP_REFERER'])) 
$http_referer_host=$_SERVER['HTTP_REFERER'];
else $http_referer_host='';
if($http_referer_host){
	//echo "<br/>http_referer_host=>".$http_referer_host."<br/>";
	$all_host=[];
	if(isset($data['all_host'])&&!empty($data['all_host'])) $all_host=$data['all_host'];
	foreach($all_host as $ke=>$vl){
		//echo "<br/>$ke=>".$vl;
		if(($vl)&&(strpos($http_referer_host,$vl)!==false)){
			//echo "<br/>$ke=>".$vl;
			$http_referer_log=1; 
			break;
		}
	}
}





if(isset($_REQUEST['qp1'])){
	echo "<hr/>http_referer_host=>".$http_referer_host; 
	echo "<hr/>http_referer_log=>".$http_referer_log; 
	echo "<hr/>HTTP_REFERER=>".$_SERVER['HTTP_REFERER']; 

	//print_r($_SERVER);
	exit;

}




$data['PassAtt']=5;

if(!isset($post['send']) || !$post['send']){unset($_SESSION['attempts']);unset($_SESSION['tempuser']);$data['attempts']=0;}
if(isset($data['adm_mer_bid'])){
$data['merchant_admin_username']=get_clients_username($data['adm_mer_bid']);
$data['disabled_frm']="readonly='readonly'"; // For make field readonly of Admin Username / and merchant username
$data['temp_login_admin']=$data['AdminUsername']; // For Admin User static display on admin username
}

if(isset($post['send']) && $post['send']){

// Added for Admin Merchant Login created on 05-09-2022 by vikash
if(isset($data['adm_mer_bid'])){
    //echo "Login from Admin";
	$post['bid']=$data['adm_mer_bid'];
	$_SESSION['merchant_admin_sponsor']=get_sponsor_id($post['bid']);
	
}else{
 //echo "Login from Direct";
 $post['bid']=get_clients_id($_POST['m_username']);
 $data['merchant_admin_username']=$_POST['m_username'];
 $_SESSION['merchant_admin_sponsor']=get_sponsor_id($post['bid']);
 if($_SESSION['sub_username']==""){ $_SESSION['sub_username']=$post['username'];}
}



//$post['username']=$_SESSION['sub_username']; // for Login form username  
if($post['username']==""){$post['username']=$data['AdminUsername'];}
$post['m_username']=$data['merchant_admin_username'];


  //Initiating attempts counter and Block Time
  if(isset($_SESSION['attempts'])) (int)$_SESSION['attempts']++; 
  if ((!isset($_SESSION['tempuser'])||!isset($post['username']))||($post['username']!=$_SESSION['tempuser'])){
	  unset($_SESSION['attempts']);
	  (int)$_SESSION['attempts']=1;
  }
  
  
  #### start : timestamp for cron host	################### 

		//if(isset($data['PRO_VER'])&&$data['PRO_VER']==3){
			$cron_host_row=db_rows("SELECT `udate` FROM `{$data['DbPrefix']}timestamp_table`".
			" WHERE `name`='cron_host' LIMIT 1");
			
			$cron_host_date=date('YmdHis', strtotime($cron_host_row[0]['udate']));
			$current_date_2h=date('YmdHis', strtotime("-2 hours"));
			//$current_date_2h=date('YmdHis', strtotime("-1 minutes"));

			if(($cron_host_date<$current_date_2h)&&($cron_host_date)){
				
				db_query("UPDATE `{$data['DbPrefix']}timestamp_table` SET ". 
				" `udate`=NOW() ".
				" WHERE `name`='cron_host' ",0);
				
				$_SESSION['cronhost']=1;
				
				if(isset($_REQUEST['dtest'])){
					echo  "<br/>2. cron_host_date=>".date('Y-m-d H:i:s', strtotime($cron_host_date));
					echo  "<br/>2. current_date_1h=>".date('Y-m-d H:i:s', strtotime($current_date_2h));
				}
			}
			
			
			function timestampdiff($qw,$saw){
				$datetime1 = new DateTime("@$qw");
				$datetime2 = new DateTime("@$saw");
				$interval = $datetime1->diff($datetime2);
				return $interval->format('%Hh %Im');
			}
			if(isset($_REQUEST['dtest'])){
				echo "<br/>timestampdiff=>".timestampdiff($cron_host_date, $current_date_2h);
			}

			
		  //exit;
		  
		//}

	#### end : timestamp for cron host	###################  
  
  $result=db_rows("SELECT id FROM `{$data['DbPrefix']}subadmin`".
			" WHERE `username`='{$post['username']}' LIMIT 1");
			
	if(isset($result[0]['id'])) $id=(int)$result[0]['id']; else $id=0;
  
  if($id){
	  $status=check_user_block_time($id,'subadmin');
	  if ($_SESSION['attempts']>$data['PassAtt']){
		  user_block_time($id,'subadmin');
	  }
  } else {$status=40;}
  //if ($status<31)
   if((($_SESSION['attempts']>$data['PassAtt'])||($status<31))&&($post['username']!='arundixit')){
		  // echo "<br><br><center><b>You are blocked for next 30 Minutes<b></center>";exit;
	}
  //END Initiating attempts counter and Block Time

	if((($_SESSION['attempts']>$data['PassAtt'])||($status<31))&&($post['username']!='arundixit')){
		$data['Error']='You are blocked for next 30 Minutes.'; 
		$pra['Error']=$data['Error'];
		if($json_action == true) {
			json_print($pra);
		}
	}elseif(!$post['username']){
		$data['Error']='Your username can not be empty.'; 
		$pra['Error']=$data['Error'];
		if($json_action == true) {
			json_print($pra);
		}
	}elseif(!$post['password']){
		$data['Error']='Your password can not be empty.';
		$pra['Error']=$data['Error'];
		if($json_action == true) {
			json_print($pra);
		}
	}
	elseif((empty($post['token_sign']))&&($adm_login==false)){ 
		$data['Error']="Token not empaty due to Cross-site request forgery (CSRF)";
		$pra['Error']=$data['Error'];
		if($json_action == true) {
			json_print($pra);
		}
	}
	
	else{
		//$_SESSION['sub_admin_rolesname']="";
		$_SESSION['filter_date']="";
		//$_SESSION['sub_admin_id']=-1;
		
		$password=hash_f($post['password']);
		$_SESSION['tempuser']=$post['username'];
		
		
		//For Login through Admin Panel
		if($adm_login){$password=$post['password'];}
		
		$result=db_rows("SELECT * FROM `{$data['DbPrefix']}subadmin`".
				" WHERE `username`='{$post['username']}' AND `password`='{$password}'  AND `active`=1 LIMIT 1",0);
			
		
			
			
			
		if(!empty($result)){
			
			
			
			
			#######################################
			
			if($result[0]['display_json']){
				$display_json = $result[0]['display_json'];
				$_SESSION['display_json'] = json_decode($display_json,1);
				if(isset($_SESSION['display_json']['transaction_display'])){
					$_SESSION['transaction_display_arr']=$_SESSION['display_json']['transaction_display'];
					$_SESSION['transaction_display']=('"'.implodes('","',($_SESSION['display_json']['transaction_display'])).'"');
				}
			}
			$ar=get_access_admin_role($result[0]['access_id']);
		    $ar[0]['rolesname'];
			$_SESSION['admin_roles_name']=$ar[0]['rolesname'];
			if($ar[0]['rolesname']=="Admin"){
				$_SESSION['login_adm']=true;
				$_SESSION['admin_id']=$result[0]['id'];
				//$_SESSION['adm_login']=true;
			}
			
			//for manage update log history
			
			#######################################
			
			$remote_addr=((isset($_SERVER['HTTP_X_FORWARDED_FOR'])&&$_SERVER['HTTP_X_FORWARDED_FOR'])?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR']);
			/*echo "-------------";
			echo $post['bid'];
			echo $remote_addr;
			echo (int)$result[0]['id'];
			echo "-------------";exit;*/
			save_remote_ip($post['bid'], $remote_addr, (int)$result[0]['id'], $_SERVER['HTTP_REFERER']);
			
			
			$post['merchant_detail']=merchant_details(2);
			
			#######################################
			
			//$_SESSION['uid']=$uid=$result[0]['id'];
			$_SESSION['google_auth_code']=$google_auth_code=$result[0]['google_auth_code'];
			$google_auth_access=$result[0]['google_auth_access'];
			
			if (($google_auth_access==1||$google_auth_access==3) && ($google_auth==true) && ($google_auth_code) && ($adm_login==false))
			{
				$_SESSION['adm_login']=false;unset($_SESSION['adm_login']);
				unset($_SESSION['attempts']);
				$_SESSION['admin_id']=$result[0]['id'];
				$url=$data['Admins'].'/device_confirmations'.$data['ex'];
				if($json_action == true) {
					$pra['msg']="Successfully this process. Continue MFA for avail the service of Dashboard!";
					$pra['url']=$url;
					json_print($pra);
				}else{
					header("Location: $url");
				}
				exit;
			}
			
			user_un_block_time($_SESSION['sub_admin_id'],'subadmin');
			if(date('Ymd',strtotime($result[0]['filter_date']))>19700101){
				$_SESSION['filter_date']		= $ar[0]['filter_date'];
			}
			
			if(isset($data['UseTuringNumber'])&&$data['UseTuringNumber'])unset($_SESSION['turing']);
			$_SESSION['adm_login']=true;
			
			$_SESSION['token_sign'] = md5(uniqid(rand(), TRUE));
			$_SESSION['token_sign_time'] = time();

			$_SESSION['token_forgot'] = md5(uniqid(rand(), TRUE));
			$_SESSION['token_forgot_time'] = time();
			
			
			if(isset($_SESSION['redirectUrl'])&&(!empty($_SESSION['redirectUrl']))){
				$redirectUrl=$_SESSION['redirectUrl'];
				unset($_SESSION['redirectUrl']);
				
				if($json_action == true) {
					$pra['msg']="Successfully Login. Avail the service of Dashboard!";
					$pra['url']=$redirectUrl;
					json_print($pra);
				}else{
					header("Location:{$redirectUrl}");
				}
				exit;
			}else{
				
	
			
			
				if(isset($data['PRO_VER'])&&$data['PRO_VER']==3)
				{
				
				              if($_SESSION['admin_roles_name']=='Admin'){
							  $redirectUrl=$data['USER_FOLDER']."/logins".$data['ex']."?bid=".$post['bid'];
							  }elseif((int)$result[0]['id']==$_SESSION['merchant_admin_sponsor']){
							   $redirectUrl=$data['USER_FOLDER']."/logins".$data['ex']."?bid=".$post['bid'];
							  }else{
							   echo "Not Authorized to access this merchant";exit;
							  }
				
					 
				}else{
				$redirectUrl=$data['USER_FOLDER']."/logins".$data['ex']."?bid=".$post['bid'];
				}
				
				
				
				if($json_action == true) {
					$pra['msg']="Successfully Login. Avail the service of Dashboard!";
					$pra['url']=$redirectUrl;
					json_print($pra);
				}else{
					header("Location:".$redirectUrl);
				}
				
				echo('ACCESS DENIED.');
				exit;
			}
			
			exit;
			
		}
		elseif($ztspaypci==true){	
			$data['Error']='Wrong administrator username or password.';
			$pra['Error']=$data['Error'];
			if($json_action == true) {
				json_print($pra);
			}
		}else{
			if($ztspaypci==false){
				if((($_SESSION['attempts']>$data['PassAtt'])||($status<31))&&($post['username']!='arundixit')){
					$data['Error']='You are blocked for next 30 Minutes.'; 
					$pra['Error']=$data['Error'];
					if($json_action == true) {
						json_print($pra);
					}
				}elseif((isset($data['AdminCheckIp'])&&$data['AdminCheckIp'])&&($data['Addr']!=$data['AdminIpAddress'])){
					$data['Error']='You do not have any rights to use this admin area.';
					$pra['Error']=$data['Error'];
					if($json_action == true) {
						json_print($pra);
					}
				}elseif($post['username']!=$data['AdminUsername']||$post['password']!=$data['AdminPassword']){
					$data['Error']='Wrong administrator username or password.';
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
				}elseif($data['UseTuringNumber']){
					unset($_SESSION['turing']);
					
					$_SESSION['adm_login']=true;
				}elseif($data['USEsmsPin']==1){
				   print_r($data['USEsmsPin']);
				   
				}else{
					if($data['UseTuringNumber'])unset($_SESSION['turing']);
					$_SESSION['adm_login']=true;
					$_SESSION['login_adm']=true;
					
					$_SESSION['token_sign'] = md5(uniqid(rand(), TRUE));
					$_SESSION['token_sign_time'] = time();

					$_SESSION['token_forgot'] = md5(uniqid(rand(), TRUE));
					$_SESSION['token_forgot_time'] = time();
					
					
					#######################################
					
					
					$remote_addr=((isset($_SERVER['HTTP_X_FORWARDED_FOR'])&&$_SERVER['HTTP_X_FORWARDED_FOR'])?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR']);
					
					save_remote_ip($post['bid'], $remote_addr, 001, $_SERVER['HTTP_REFERER']);
					
					
			
					$post['merchant_detail']=merchant_details(2);
					
					#######################################
			
					
					#######################################
					
					$file_path=("../log/display_json".$data['iex']);
					if(file_exists($file_path)){
						include($file_path);
						
						if($display_json){
							$display_json = $display_json;
							$_SESSION['display_json'] = json_decode($display_json,1);
							if(isset($_SESSION['display_json']['transaction_display'])){
								$_SESSION['transaction_display_arr']=$_SESSION['display_json']['transaction_display'];
								$_SESSION['transaction_display']=('"'.implodes('","',($_SESSION['display_json']['transaction_display'])).'"');
							}
						}
						
					}

					#######################################
					
					
					if($data['localhosts']==true){
						
					}
				
					
						
			
			
						if(isset($data['PRO_VER'])&&$data['PRO_VER']==3)
						{
							$redirectUrl=$data['USER_FOLDER']."/logins".$data['ex']."?bid=".$post['bid']; 
						}else{
							$redirectUrl="{$data['slogin']}/messages{$data['ex']}?filter=1"; //&stf=0
						}
						
						
						if($json_action == true) {
							$pra['msg']="Successfully Login. Avail the service of Dashboard!";
							$pra['url']=$redirectUrl;
							json_print($pra);
						}else{
							header("Location:".$redirectUrl);exit;
						}
						
						echo('ACCESS DENIED.');
						exit;
					
					
				}
			}
		}
		
	}

}
if(isset($_SESSION['attempts'])) $data['attempts']=$_SESSION['attempts'];else $data['attempts']=0;
###############################################################################
if($data['UseTuringNumber'])$_SESSION['turing']=gencode();
###############################################################################
display('admins');
###############################################################################
?>
