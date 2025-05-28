<?

$data['transIDExit']=1;

/*
$data['status_in_email']=1;
$data['devEmail']='arun@itio.in';
$send_attchment_message5=1;
*/

if(!isset($_SESSION)) {
	session_start(); 
	//session_regenerate_id(true); 
}

if(isset($_REQUEST['transID'])&&$_REQUEST['transID']) $transID=$_SESSION['transID']=$_REQUEST['transID'];
		
$_REQUEST['actionurl']='notify';
$_REQUEST['action']='webhook';

echo $data['ok_webhook']="OK";

include("status_41.do");

?>