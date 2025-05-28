<?
$config_root='config_root.do'; 
if(file_exists($config_root)){include($config_root);}
$transID='';
if(isset($_REQUEST['transID'])&&$_REQUEST['transID']) $transID=$_REQUEST['transID'];
elseif(isset($_REQUEST['orderset'])&&$_REQUEST['orderset']) $transID=$_REQUEST['orderset'];
elseif(isset($_SESSION['transID'])) $transID=$_SESSION['transID'];
elseif(isset($_SESSION['SA']['transID'])) $transID=$_SESSION['SA']['transID'];
$bankstatus=$data['Host']."/status".$data['ex']."?transID=".$transID;
if(isset($_GET['dtest'])&&$_GET['dtest']==2){
	//print_r($_SESSION);
	echo $bankstatus;
}
else{
	header("Location:".$bankstatus);exit;
}
?>
