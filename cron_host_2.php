#!/bin/bash
<?php
// PATH=/opt/someApp/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
//$_REQUEST['pq']="0";

//$_REQUEST['ts']="1";
//$_REQUEST['li']="100";

$_REQUEST['ts']="1";
$_REQUEST['li']="100";

	$_REQUEST['related_qr_skip']="1";
	$_REQUEST['related_skip']="1";
	$_REQUEST['cron_host_response']="cron_host_2 | 30 to 20 seconds ";

$suq_1=http_build_query($_REQUEST);

if(isset($_REQUEST['q'])&&@$_REQUEST['q'])
echo "<br/><br/>suq_1=>".$suq_1;

$data['rootPath']="/var/www/html/";

if(isset($_SERVER["HTTP_HOST"])&&($_SERVER["HTTP_HOST"]=='localhost'||$_SERVER["HTTP_HOST"]=='localhost:8080'||$_SERVER["HTTP_HOST"]=='localhost:98'||isset($_SESSION["http_host_loc"]))){
	$data['rootPath']="D:/xampp/htdocs/gw/";
}

//$data['cron_account_type']='42';
include('cron_host.do');
?>
