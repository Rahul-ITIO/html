<?
$data['PageName']='MEMBER LOGIN';
$data['PageFile']='login';
###############################################################################
if(!isset($_SESSION)){session_start();}
include('../config.do');
$data['PageTitle'] = 'Login - '.$data['domain_name'];
###############################################################################
unset($_SESSION['attempts']);
unset($_SESSION['login']);
unset($_SESSION['uid']);

if(!isset($_SESSION['attempts'])) $_SESSION['attempts']=0;

###############################################################################
//require_once('recaptchalib.php');
//print_r($data['USEsmsPin']);

// Get a key from https://www.google.com/recaptcha/admin/create
$publickey = "6Ld3c-YSAAAAAIIdQocSje_bq1a7Sti3QymRM5hw";
$privatekey = "6Ld3c-YSAAAAAJqrQBNAR_Qb40Mh4BveQ_q8bjv0";

# the response from reCAPTCHA
$resp = null;
# the error code from reCAPTCHA, if any
$error = null;

$adm_login=false;

$http_referer_log=0;
$http_referer_host=explode('/',$_SERVER['HTTP_REFERER'])[2];
$all_host=[];
if(isset($data['all_host'])&&!empty($data['all_host'])) $all_host=$data['all_host'];
foreach($all_host as $ke=>$vl){
	//echo "<br/>".$vl;
	if(strpos($vl,$http_referer_host)!==false){
		$http_referer_log=1;
	}
}

if(isset($_REQUEST['qp1'])){
	echo "<hr/>http_referer_host=>".$http_referer_host; 
	echo "<hr/>http_referer_log=>".$http_referer_log; 
	echo "<hr/>HTTP_REFERER=>".$_SERVER['HTTP_REFERER']; 

	//print_r($_SERVER);
	exit;

}

//if(($_SESSION['adm_login'])||($_SESSION['login_page_active'])||( ($_SERVER['SERVER_ADDR']==$data['SERVER_ADDR']||$_SERVER['SERVER_ADDR']==$data['SERVER_ADDR_PRA']) && ((strpos($_SERVER['HTTP_REFERER'],'mlogin/clients')!==false)||(strpos($_SERVER['HTTP_REFERER'],'mlogin/transactions')!==false)) )){

//if(((strpos($_SERVER['HTTP_REFERER'],'mlogin/clients')!==false)||(strpos($_SERVER['HTTP_REFERER'],'mlogin/transactions')!==false))){

if((isset($_SERVER['HTTP_REFERER']))&&($http_referer_log==1)){
	
	$adm_login=true;
}


if(isset($_GET['lqp'])){
	echo "<hr/>adm_login=>".$_SESSION['adm_login'];
	echo "<hr/>login_page_active=>".$_SESSION['login_page_active'];
	
	echo "<hr/>SERVER_ADDR=>".$_SERVER['SERVER_ADDR'];
	echo "<hr/>HTTP_REFERER=>".$_SERVER['HTTP_REFERER'];
	
	echo "<hr/>adm_login=>".$adm_login;
	
	echo "<hr/>_SERVER=>";
	print_r($_SERVER);
	
	//echo "<hr/>_SESSION=>";print_r($_SESSION);
	
	exit;
	
}


if($adm_login==false&&$data['localhosts']==false){
        header("Location:{$data['USER_FOLDER']}/login.do");
        echo('ACCESS DENIED.');
        exit;
}
//$countryName=getLocationInfoByIp($_SERVER['REMOTE_ADDR']);


$attempts= $_SESSION['attempts'];
$today=date("d/m/y");

if((isset($post['send'])&&$post['send'])||isset($_GET['bid'])){
	
	if(isset($_GET['bid'])&&!empty($_GET['bid'])){
		$info 		= select_client_table($_GET['bid']);
		//print_r($info);exit;
		//$post['email']=$info['email'];
		$post['password']=$info['password'];
		$post['username']=$info['username'];
		//$post['password']=$info['password'];
		$post['uid']=$info['id'];
	}	
			
	
   if($_SESSION['attempts']<$data['PassAtt']-1){

		if(!isset($post['username'])&&!$post['username']){
                $data['Error']='Your username can not be empty.';
		}elseif(!isset($post['password'])&&!$post['password']){
                $data['Error']='Your password can not be empty.';
		}elseif((isset($data['UseTuringNumber'])&&$data['UseTuringNumber'])&&(!isset($post['turing'])||!$post['turing']||strtoupper($post['turing'])!=$_SESSION['turing'])){
				$data['Error']='Please enter valid turing number.';
		}elseif(isset($data['USEsmsPin'])&&$data['USEsmsPin']==1){
      
    	}elseif(!is_clients_active($post['username'])){

                $data['Error']='This clients was not found in the system. Or is inactive, banned or closed.';

        }elseif(!is_clients_found($post['username'], $post['password'])){
           $data['Error']='Your have entered a wrong username or password.';
       // }elseif(is_clients_login_same_country($post['username'], $post['password'])!=$countryName){
          // $data['Error']='Your have No access at this time.';
        } 
		/*
		elseif(is_clients_block($post['username'])==0){
           $data['Error']="Your Account has been TERMINATED. Please contact {$data['AdminEmail']} for assistance";
        }
		*/
		else{
        	
        	unset($_SESSION['CSESID']);
        	
           
				
            if($data['UseSmsPin']){    
                if(!$_SESSION['CSESID']&&$_SESSION['CSESID']==''){  
                    include('sessionpin'.$data['iex']);  
                    display('clients'); 
                    //die();   
                }
			}
			unset($_SESSION['attempts']);
			
			if(!(isset($info['fullname'])&&$info['fullname'])) $info['fullname'] = $info['fname'];
			$post['username']=prntext($post['username']);
			$_SESSION['m_username']=$post['username'];
			$_SESSION['m_first_name']=$info['fullname'];
            $_SESSION['m_company']=$info['company_name'];
			
			$_SESSION['uid']=$uid=get_clients_id($post['username'], $post['password']);

			$_SESSION['login']=true; 
			
			//unset pagination form multi connection 
			if(isset($_SESSION['next_pg'])) unset($_SESSION['next_pg']);
			if(isset($_SESSION['prev_pg'])) unset($_SESSION['prev_pg']);
			
			//unset if total withdraw 
			
			if(isset($_SESSION['uid_'.$uid])){
				unset($_SESSION['uid_'.$uid]);
			}
			
			
			$unset_session_1=["load_tab","open_msg_id","store_size","wid","tr_sum_count","gid","create_graph"];
	
			unset_sessionf($unset_session_1);
	

			//set_last_access($post['username']);

			//save_remote_ip((int)$_SESSION['uid'], $_SERVER["REMOTE_ADDR"]);

			if($data['UseTuringNumber'])unset($_SESSION['turing']);
          	
			if(isset($data['PRO_VER'])&&$data['PRO_VER']==3)
			{
				header("Location:{$data['USER_FOLDER']}/index".$data['ex']);
			}else{
				header("Location:{$data['Host']}/user/welcomeapp".$data['ex']);
			}

			echo('ACCESS DENIED.');

			exit;

        }

        (int)$_SESSION['attempts']++;

   }else{

      if($data['UseTuringNumber'])unset($_SESSION['turing']);

      unset($_SESSION['attempts']);

      $data['CantLogin']=true;

   }

}

$data['attempts']=$_SESSION['attempts'];

###############################################################################

if($data['UseTuringNumber'])$_SESSION['turing']=gencode();

###############################################################################

display('user');

###############################################################################

?>