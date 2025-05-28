<?php
include('../config.do');

$currency_input = 5;
//currency codes : http://en.wikipedia.org/wiki/ISO_4217
$currency_from = "USD";
$currency_to = "INR";
$getway=false;
if(isset($_GET['a'])){
	$currency_input =$_GET['a'];
}
if(isset($_GET['fr'])){
	$currency_from =$_GET['fr'];
}
if(isset($_GET['to'])){
	$currency_to =$_GET['to'];
}
if(isset($_GET['g'])){
	$getway=true;
}

//	http://localhost/ztswallet/include/currency_convert.do?a=5&fr=USD&to=INR
//http://localhost/ztswallet/include/currency_convert.do?a=5&fr=USD&to=INR
//http://localhost/ztswallet/include/currency_convert.do?a=100&fr=AUD&to=USD&g=1



echo "<hr/>";
$currencys = currencyConverter($currency_from,$currency_to,$currency_input,$getway,1);


echo "<hr/>print_r=><br/>";
print_r($currencys);

?>