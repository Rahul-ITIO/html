<?
###############################################################################
$data['PageName']='Store';
$data['PageFile']='payment_button'; 
###############################################################################
include('../config.do');
$data['PageTitle'] = 'My Banking Information - '.$data['domain_name'];
###############################################################################
if(!$_SESSION['login']){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

###############################################################################
if(is_info_empty($uid)){
        header("Location:{$data['Host']}/user/profile".$data['ex']);
        echo('ACCESS DENIED.');
        exit;
}

if((strpos($data['urlpath'],$data['MYWEBSITEURL'])!==false)||($data['MYWEBSITEURL'])){
	$data['PageName']=$data['MYWEBSITE'];
	$data['PageFileName']=$data['MYWEBSITEURL'];
	//$data['PageFile']=$data['MYWEBSITEURL'];
	$data['PageTitle'] = 'My '.$data['MYWEBSITE'].' - '.$data['domain_name'];
	$data['FileName']=$data['PageFile'].$data['ex'];
	
}


###############################################################################
$post=select_info($uid, $post);

if(!isset($post['step']))$post['step']=1;
############################################################################### 
if($post['step']==1)$data['Products']=select_terminals($uid, 0);
//print_r($data['Products']);

###############################################################################
display('user');
###############################################################################
?>