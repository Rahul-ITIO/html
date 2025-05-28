<?
// secure/header_location_test.do

if(!isset($data['config_root'])){
	$config_root='../config_root.do';
	if(file_exists($config_root)){include($config_root);}
	//echo "<br/>Host1=>".$data['Host']; echo "<br/>urlpath1=>".$urlpath;
}

$payaddress='https://aws-cc-uat.web1.one/payin/pay103/reprocess_103?transID=103111519201';
$payaddress='https://www.google.com/';

echo "<br/><hr/>payaddress=><br/>";

print_r($payaddress);
echo "<br/><hr/>";

header("Location:".$payaddress);
?>