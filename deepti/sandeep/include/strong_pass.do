<?php
//http://localhost/ztswallet/include/strong_pass.do?c=32
if(session_id() == '' || !isset($_SESSION)) {
	session_start();
}
include('security_function.do');
$chr=32;
if(isset($_GET['c'])){
	$chr=$_GET['c'];
}
echo "<hr/>Strong Password= ".$publicKey = genRandString($chr);
?>
