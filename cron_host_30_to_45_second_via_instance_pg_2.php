#!/var/www/html
<?php
//$_REQUEST['pq']="0";

$_REQUEST['ts']="2";
$_REQUEST['li']="200";
$_REQUEST['page']="2";
//$_REQUEST['related']="2";
	$_REQUEST['related_qr_skip']="1";
	$_REQUEST['related_skip']="1";
	
$_REQUEST['cron_host_response']="cron_host_30_to_45_second_via_instance_pg_2.php";

if(isset($_REQUEST['q'])&&@$_REQUEST['q']) 
{
	$suq_1=http_build_query($_REQUEST);
	echo "<br/><br/>suq_1=>".$suq_1;
}

$data['rootPath']="/var/www/html/";

if(isset($_SERVER["HTTP_HOST"])&&($_SERVER["HTTP_HOST"]=='localhost'||$_SERVER["HTTP_HOST"]=='localhost:8080'||$_SERVER["HTTP_HOST"]=='localhost:98')){
	$data['rootPath']="D:/xampp/htdocs/gw/";
}

include('cron_host.do');
?>
