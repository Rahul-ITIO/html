<?
$data['PageName']='CONFIRM YOUR E-MAIL ADDRESS';
$data['PageFile']='confirm';
$data['HideMenu']=true;
$data['HideAllMenu']=true;
###############################################################################
include('config.do');
$data['PageTitle'] = 'Confirm Your Email Address - '.$data['domain_name'];
###############################################################################
//$_SESSION['PostSent'];
//if ((isset($_GET['c']))&&(isset($_GET['u']))){
if (isset($_GET['c'])&&trim($_GET['c'])){
	$data['Email']=false;
	$eid=$_GET['c'];
	$user=$_GET['u'];
	
	$code_get=decode_f($_GET['c'],0);
	$code_jde=jsondecode($code_get,1,1);
	
	//print_r($code_jde);exit;
	
	if(isset($code_jde)&&$code_jde){
		$eid=$code_jde['c'];
		$user=$code_jde['u'];
		$tid=$code_jde['id'];
		$where_cond="  AND `id`='$tid' ";
	}else{
		$where_cond="";
	}
	$result = activate_email($user,$eid,$where_cond);
	if ($result=='CONFIRMATION_NOT_FOUND') {
		$data['error']="The confirmation code you entered is not valid.";
	}
	$_SESSION['PostSent']=5;
	$data['Email']=true;
}
//$post['clientid']= @$uid;
$post['clientid']=((isset($uid)&&$uid)?$uid:'');
if(isset($post['cid'])&&$post['cid']){
	/* if(!isset($post['email'])||empty($post['email'])){
		$cid=select_confirmation('', '', $post['cid']);
	}else{
		$cid=select_confirmation($post['cid'], $post['email']);
	}*/
	
	/*
	$cid1=trim(decryptres($post['cid']));
	echo "<br/>cid=>".$post['cid'];
	echo "<br/>cid1=>".$cid1;
	exit;*/
	
	
	 $cid=select_confirmation_new($post['cid']);
    if($cid>0){
  	  	$user = update_confirmation($cid);
		if($user){
			$_SESSION['user'] = $user;
			$_SESSION['PostSent'] = 1; 
		}
    }else{ 
	    if(!isset($_SESSION['user']) || empty($_SESSION['user']))
	    {
	    	$data['Error']='Incorrect confirmation URL.'; 
	    	$_SESSION['PostSent'] = '1';
	    }else{
	    	$_SESSION['user'] = '';
	    }
		$data['Error']='Incorrect confirmation URL.'; 
		 if(isset($_SESSION['PostSent'])) unset($_SESSION['PostSent']);
	}
	
}elseif(isset($post['confirm'])&&$post['confirm']){
	if(!$post['ccode']){
		$data['Error']='Please enter your confirmation code.';
	}elseif(!$cid&&!$eid){
		$data['Error']='Please enter a valid confirmation code.';
	}else{
		if($cid)update_confirmation($cid);
		elseif($eid){
			update_email_confirmation($eid);
			$data['Email']=true;
		}
		$data['PostSent']=true;
	}
}
###############################################################################
display('user');
###############################################################################
?>
