<?
if(isset($_REQUEST['transID'])&&$_REQUEST['transID']) $_REQUEST['transID']=$_REQUEST['transID'];
elseif(isset($_REQUEST['orderset'])&&$_REQUEST['orderset']) $_REQUEST['transID']=$_REQUEST['orderset'];
elseif(isset($_SESSION['transID'])) $_REQUEST['transID']=$_SESSION['transID'];
elseif(isset($_SESSION['SA']['transID'])) $_REQUEST['transID']=$_SESSION['SA']['transID'];
include('status.do');
?>