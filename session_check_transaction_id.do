<?
error_reporting(0); // reports all errors
if(!isset($_SESSION)) {session_start();}

$config_root='config_root.do'; 
if(file_exists($config_root)){include($config_root);}
$transID='';
if(isset($_REQUEST['transID'])&&$_REQUEST['transID']) $transID=$_REQUEST['transID'];
elseif(isset($_SESSION['transID'])) $transID=$_SESSION['transID'];
elseif(isset($_SESSION['SA']['transID'])) $transID=$_SESSION['SA']['transID'];
//$bankstatus=$data['Host']."/bankstatus".$data['ex']."?transID=".$transID;
$jsonarray_all['transID']=$transID;
if(isset($_REQUEST['trn'])&&$_REQUEST['trn']){
	header('Content-Type: application/json; charset=utf-8'); 
	echo json_encode($jsonarray_all, JSON_UNESCAPED_UNICODE);exit;
}
?>
