#!/var/www/html
<?php
//$_REQUEST['pq']="0";

//$_REQUEST['a']='a'; //testing after comment 

$data['HOST_REQUEST']='https://can-webhook.web1.one';

$_REQUEST['cron_host_response']="cron_token_canara_instance_1.php";
$_REQUEST['acquirer_id']='83';

$_REQUEST["bill_amt"]="13.13";
$_REQUEST["bill_currency"]="INR";
$_REQUEST["product_name"]="Refresh Token ".@$_REQUEST['cron_host_response'];

$_REQUEST["fullname"]="Refresh Token";
$_REQUEST["bill_email"]="devops@itio.in";

if(isset($_REQUEST['q'])&&@$_REQUEST['q']) 
{
	$suq_1=http_build_query($_REQUEST);
	echo "<br/><br/>suq_1=>".$suq_1;
}

$data['rootPath']="/var/www/html/";

if(isset($_SERVER["HTTP_HOST"])&&($_SERVER["HTTP_HOST"]=='localhost'||$_SERVER["HTTP_HOST"]=='localhost:8080'||$_SERVER["HTTP_HOST"]=='localhost:98')){
	$data['rootPath']="D:/xampp/htdocs/gw/";
}

include('cron_token_canara.do');
?>
