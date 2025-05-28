#!/var/www/html
<?php
//$_REQUEST['pq']="0";

$_REQUEST['ts']="11";
$_REQUEST['li']="100";
//$_REQUEST['is']="30";
$_GET['cron_host_response']="cron_host_05_to_20_second.do";
$_REQUEST['cron_host_response']="cron_host_05_to_20_second.do";


if(isset($_REQUEST['q'])&&@$_REQUEST['q']) 
{
	$suq_1=http_build_query($_REQUEST);
	echo "<br/><br/>suq_1=>".$suq_1;
}

$data['rootPath']="/var/www/html/";

if(isset($_SERVER["HTTP_HOST"])&&($_SERVER["HTTP_HOST"]=='localhost'||$_SERVER["HTTP_HOST"]=='localhost:8080'||$_SERVER["HTTP_HOST"]=='localhost:98'||isset($_SESSION["http_host_loc"]))){
	$data['rootPath']="D:/xampp/htdocs/gw/";
}

include('cron_host.do');
?>
