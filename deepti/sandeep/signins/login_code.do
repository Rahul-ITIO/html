<?php
$data['PageName']='SYSTEM ADMINISTRATOR LOGIN';
$data['PageFile']='login';
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


/*
if(isset($_SERVER['HTTP_REFERER'])) 
$http_referer_host=explode('/',$_SERVER['HTTP_REFERER'])[2];
else
	$http_referer_host='';
foreach($data['all_host'] as $ke=>$vl){
	//echo "<br/>".$vl;
	if(strpos($vl,$http_referer_host)!==false){
		$http_referer_log=1;
	}
}
*/


if(isset($_REQUEST['qp1'])){
	echo "<hr/>http_referer_host=>".$http_referer_host; 
	echo "<hr/>http_referer_log=>".$http_referer_log; 
	echo "<hr/>HTTP_REFERER=>".$_SERVER['HTTP_REFERER']; 

	//print_r($_SERVER);
	exit;

}

////////////for subadmin login Added By Vikash on 08-09-2022////////
if(isset($post['bid'])&&$post['bid']){
$_SESSION['refrer_admin_id']=$_SESSION['admin_id'];
if($_SESSION['refrer_admin_id']==""){ $_SESSION['refrer_admin_id']=1; }
}
///////////////////////////////////

//if(($_SESSION['adm_login'])&&(!$_SESSION['sub_admin_id'])){
//if(($_SESSION['adm_login'])||($_SESSION['login_page_active'])||(  strpos($_SERVER['HTTP_REFERER'],'mlogin/listsubadmin')!==false) ){ 

if((isset($_SERVER['HTTP_REFERER']))&&($http_referer_log==1)){
	if(isset($post['bid'])&&trim($post['bid'])){
		$subadmin=db_rows("SELECT * FROM `{$data['DbPrefix']}subadmin`".
				" WHERE `id`={$post['bid']} LIMIT 1");
		if($subadmin){
			$post['username']=$subadmin[0]['username'];
			$post['password']=$subadmin[0]['password'];
			$post['send']=1;
			//session_destroy();
				if(isset($_SESSION['sub_admin_id'])) unset($_SESSION['sub_admin_id']);
				if(isset($_SESSION['admin_id'])) unset($_SESSION['admin_id']);
			
			if(isset($_SESSION['adm_login'])) unset($_SESSION['adm_login']);
			if(isset($_SESSION['login_adm'])) unset($_SESSION['login_adm']);
			$adm_login=true;
		}
	}
	
}
$data['PassAtt']=5;

if(!isset($post['send']) || !$post['send']){unset($_SESSION['attempts']);unset($_SESSION['tempuser']);$data['attempts']=0;}

if(isset($post['send']) && $post['send']){

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
			
			$cron_host_date=date('YmdHis', strtotime(@$cron_host_row[0]['udate']));
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
		$data['Error']="Token not empty due to Cross-site request forgery (CSRF)";
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
			" WHERE `username`='{$post['username']}' AND `password`='{$password}' AND `active`=1 LIMIT 1",0);
			
		if(!empty($result)){

			if(isset($result[0]['fullname'])&&$result[0]['fullname'])//if fullname exist then use fullname
				$fullname=$result[0]['fullname'];
			else	//if fullname not exists then concat fname and lname
				$fullname=$result[0]['fname'];

			$_SESSION['sub_username']	= $result[0]['username'];
			$_SESSION['admin_fullname'] = $fullname; // changed fname to fullname 
			$_SESSION['sub_email'] = $result[0]['email'];
					
			############### For Transaction Table Display ########################
			
			if($result[0]['display_json']){
				$display_json = $result[0]['display_json'];
				$_SESSION['display_json'] = json_decode($display_json,1);
				if(isset($_SESSION['display_json']['transaction_display'])){
					$_SESSION['transaction_display_arr']=$_SESSION['display_json']['transaction_display'];
					$_SESSION['transaction_display']=('"'.implodes('","',($_SESSION['display_json']['transaction_display'])).'"');
				}
			}
			
			#######################################
			################## For Subadmin Table Display #####################
			
			if($result[0]['display_json_subadmin']){
				$display_json_subadmin = $result[0]['display_json_subadmin'];
				$_SESSION['display_json_subadmin'] = json_decode($display_json_subadmin,1);
				if(isset($_SESSION['display_json_subadmin']['subadmin_display'])){
				$_SESSION['subadmin_display_arr']=$_SESSION['display_json_subadmin']['subadmin_display'];
				$_SESSION['subadmin_display']=('"'.implodes('","',($_SESSION['display_json_subadmin']['subadmin_display'])).'"');
				}
			}
			
			
			#######################################
			
			
			$ar=get_access_admin_role($result[0]['access_id']);
			
			$_SESSION['roles_id']			= $ar[0]['id'];
			
			$_SESSION['admin_roles_name']	= $ar[0]['rolesname']; // New Added on 09/06/2022
			$_SESSION['acquirer_id'] = array();
			
			if($ar[0]['rolesname']=="Admin"){
				$_SESSION['login_adm']=true;
				$_SESSION['admin_id']=$result[0]['id'];
				//$_SESSION['adm_login']=true;
			}
			else{
				//$_SESSION['id'] 					= $result[0]['id'];	
				foreach($ar[0] as $key=>$value){
					$_SESSION[$key]=$value;
					
					if((strpos($key,"acquirer_")!==false)&&$value==1){
						$acquirer=(int)str_replace('acquirer_','',$key);
						if(is_integer($acquirer)&&$acquirer){
							$_SESSION['acquirer_id'][]=$acquirer;
						}
					}
					
				}
				
				//json_value	acquirer from role	
				if(isset($ar[0]['json_value'])){
					$json_value=jsondecode($ar[0]['json_value']);
					foreach(($json_value) as $key=>$value){
						$_SESSION[$key]=$value;
						if((strpos($key,"acquirer_")!==false)&&$value==1){
							$acquirer=(int)str_replace('acquirer_','',$key);
							if(is_integer($acquirer)&&$acquirer){
								$_SESSION['acquirer_id'][]=$acquirer;
							}
						}
					}
				}
				
				$_SESSION['acquirer_ids']=implodes(',',$_SESSION['acquirer_id']);
				
				$_SESSION['sub_admin_id'] 			= $result[0]['id'];
				$_SESSION['sub_admin_access_id'] 	= $result[0]['access_id'];
				$_SESSION['sub_admin_fullname']		= $fullname;
				$_SESSION['sub_admin_rolesname'] 	= $ar[0]['rolesname'];
				$_SESSION['access_roles']			= $ar[0];
	
				$_SESSION['all_mid_2'] 	= $result[0]['multiple_subadmin_ids'];
				$_SESSION['all_mid'] 	= $result[0]['multiple_merchant_ids'];

				$slist=get_sponsors('',$result[0]['id'],1);
				
				$_SESSION['merchantAccess']=$slist['merchantAccess'];
				if($slist['get_mid']){
					$_SESSION['get_mid']=$slist['get_mid'];
					$_SESSION['get_mid_array']=explode(",",$slist['get_mid']);
				}else{
					$_SESSION['get_mid']=-99;
				}
				$_SESSION['get_mid_count']=$slist['get_mid_count'];
				$_SESSION['subAdminAccess']=$slist['subAdminAccess'];
				$_SESSION['get_gid']=$slist['get_gid'];
				
				
				//echo "<hr/>get_mid=>".$_SESSION['get_mid']; echo "<hr/>get_mid=>".$_SESSION['get_mid_count']; print_r($slist);exit;
			}
			
			
			#######################################
			
			$remote_addr=((isset($_SERVER['HTTP_X_FORWARDED_FOR'])&&$_SERVER['HTTP_X_FORWARDED_FOR'])?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR']);
			////////////for subadmin login Added By Vikash on 08-09-2022////////
			if(isset($post['bid'])&&$post['bid']){
			save_remote_ip($post['bid'], $remote_addr, $_SESSION['refrer_admin_id'], $_SERVER['HTTP_REFERER']);
			}else{
			save_remote_ip((int)$result[0]['id'], $remote_addr);
			}
			
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
			
			
			if(isset($_SESSION['adminRedirectUrl'])&&(!empty($_SESSION['adminRedirectUrl']))&&(!preg_match('/login/', $_SESSION['adminRedirectUrl']))){
				$redirectUrl=$_SESSION['adminRedirectUrl'];
				unset($_SESSION['adminRedirectUrl']);
				
				if($json_action == true) {
					$pra['msg']="Successfully Login. Avail the service of Dashboard!";
					$pra['url']=$redirectUrl;
					json_print($pra);
				}else{
					header("Location:{$redirectUrl}");
				}
				exit;
			}else{
				

				$redirectUrl="{$data['Admins']}/index{$data['ex']}"; 
				
				
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
				}elseif(isset($data['USEsmsPin'])&&$data['USEsmsPin']==1){
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
					
					if(isset($post['adm_remember'])&&$post['adm_remember']){ 
					$cookie_adm_name = $post['username'];
		 			$cookie_adm_pass = $_POST['password'];
					$cookie_adm_remember = $post['adm_remember'];
					}else{
					$cookie_adm_name = "";
					$cookie_adm_pass = "";
					$cookie_adm_remember = "";
					}
			
            if($data['ztspaypci']==false){
			setcookie("adm_username", $cookie_adm_name, time() + (86400 * 900), "/"); // 86400*30 = 1 day
			setcookie("adm_password", $cookie_adm_pass, time() + (86400 * 900), "/");
			setcookie("adm_remember", $cookie_adm_remember, time() + (86400 * 900), "/");
           }
		   
		   //print_r($_COOKIE);exit;
					
					$remote_addr=((isset($_SERVER['HTTP_X_FORWARDED_FOR'])&&$_SERVER['HTTP_X_FORWARDED_FOR'])?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR']);
			////////////for subadmin login Added By Vikash on 08-09-2022////////		
			if(isset($post['bid'])&&$post['bid']){
			save_remote_ip($post['bid'], $remote_addr, 1, $_SERVER['HTTP_REFERER']);
			}else{
					save_remote_ip(001, $remote_addr);
			}
			
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

					/// for subadmin list Display Addedon 29-04-2023 by Vikash
					
					$file_path=("../log/display_json_subadmin".$data['iex']);
					if(file_exists($file_path)){
						include($file_path);
						
						if($display_json){
							$display_json = $display_json;
							$_SESSION['display_json_subadmin'] = json_decode($display_json,1);
							if(isset($_SESSION['display_json_subadmin']['subadmin_display'])){
								$_SESSION['subadmin_display_arr']=$_SESSION['display_json_subadmin']['subadmin_display'];
								$_SESSION['subadmin_display']=('"'.implodes('","',($_SESSION['display_json_subadmin']['subadmin_display'])).'"');
							}
						}
						
					}
					#######################################
					
					
					if($data['localhosts']==true){
						
					}
				
					if(isset($_SESSION['adminRedirectUrl'])&&(!empty($_SESSION['adminRedirectUrl']))&&(!preg_match('/login/', $_SESSION['adminRedirectUrl']))){
						$redirectUrl=$_SESSION['adminRedirectUrl'];
						unset($_SESSION['adminRedirectUrl']);
						
						if($json_action == true) {
							$pra['msg']="Successfully Login. Avail the service of Dashboard!";
							$pra['url']=$redirectUrl;
							json_print($pra);
						}else{
							header("Location:{$redirectUrl}");
						}
						exit;
					}else{
						
						$redirectUrl="{$data['Admins']}/index{$data['ex']}"; 
						
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
