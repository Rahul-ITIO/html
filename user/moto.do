<?
if(!isset($_SESSION)) {session_start();}
//$data['re_post']=true;
//$data['process_file']='moto';
//$data['process_file']='payme';
//$_POST['action']='vt';
$data['paylinkurl']='payme';
$_REQUEST['user']=$_SESSION['uid'];
$_POST['user']=$_SESSION['uid'];
$_POST['clientid']=$_SESSION['uid'];
$post['user']=$_SESSION['uid'];
$_SESSION['clientid']=$_SESSION['uid'];
$post['clientid']=$_SESSION['uid'];
//print_r($_SESSION['uid']);
//include('../config.do');
/*
$post['allStore']=select_products($_SESSION['clientid'],0,0,0,1);	//fetch data from products table of a clients
$post['storeSize']=sizeof($post['allStore']);

if($post['storeSize']<1){		//if rows less them 1, means no record exists and print following error code and messasge
	$data['Error']=95;
	$data['Message']="Not Store Available";
	error_print($data['Error'],$data['Message']);	//print error
}
elseif($post['storeSize']>1){	//if rows more than one then store total rows in chooseStore
	$post['chooseStore']=$post['storeSize'];
}elseif($post['storeSize']==1){	//if retrive only one row the store api_token
		$post['api_token']=$post['allStore'][0]['api_token'];
}

*/
			
include('../directapi.do');
?>