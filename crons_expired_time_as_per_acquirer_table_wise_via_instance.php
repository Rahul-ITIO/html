#!/var/www/html
<?php
//$_REQUEST['pq']="1";
//$_REQUEST['log']="1";

//$_REQUEST['up1']="10";
$_REQUEST['up1']="acquirer_table_wise"; // acquirer_table_wise is expired all pending transaction as per acquirer table wise 

$_REQUEST['cron_host_response']="crons_expired_time_as_per_acquirer_table_wise_via_instance.php";

if(isset($_REQUEST['q'])&&@$_REQUEST['q']) 
{
	$suq_1=http_build_query($_REQUEST);
	echo "<br/><br/>suq_1=>".$suq_1;
}

$data['rootPath']="/var/www/html/";
    $_SERVER["HTTPS"]='on';
$data['HideMenu']=true;
$data['NO_SALT']=true;
$data['SponsorDomain']=true;


if(isset($_SERVER["HTTP_HOST"])&&($_SERVER["HTTP_HOST"]=='localhost'||$_SERVER["HTTP_HOST"]=='localhost:8080'||$_SERVER["HTTP_HOST"]=='localhost:98'||isset($_SESSION["http_host_loc"]))){
	$data['rootPath']="D:/xampp/htdocs/gw/";
}


include('crons_expired.do');
?>
