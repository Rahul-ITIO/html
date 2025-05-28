<?
error_reporting(-1); // reports all errors
if(!isset($_SESSION)) {session_start();}
$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
if($_SERVER['SERVER_NAME']=='localhost'){
	$_SERVER['SERVER_NAME']='localhost/gw';
}
$data['Host']=$protocol.$_SERVER['SERVER_NAME'];
	
header('Content-Type: application/octet-stream');
header('Content-Disposition: attachment; filename='.$_REQUEST['f']);
readfile($data['Host'].'/user_doc/'.$_REQUEST['f']); 
exit;
?>