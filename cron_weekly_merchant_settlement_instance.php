#!/var/www/html/
<?php
//  #!/var/www/html
//  #!/opt/homebrew/var/www
//$_REQUEST['pq']="0";

//$_REQUEST['a']='a'; //testing after comment 

//$data['HOST_REQUEST']='https://can-webhook.web1.one';


// Localhost in Mac
// 	php /opt/homebrew/var/www/gw/cron_weekly_merchant_settlement_instance.php
//  /opt/homebrew/opt/php@8.1/bin/php /opt/homebrew/var/www/gw/cron_weekly_merchant_settlement_instance.php


//Instance direct testing 
// /usr/bin/php /var/www/html/cron_weekly_merchant_settlement_instance.php

// Instance 10 sec
//  * * * * * sleep 10; /usr/bin/php /var/www/html/cron_weekly_merchant_settlement_instance.php > /var/log/apache2/cronlogfile2.log 2>&1
//Instance Cron job once a day is a commonly used cron schedule.
//0 0 * * *  /usr/bin/php /var/www/html/cron_weekly_merchant_settlement_instance.php > /var/log/apache2/cronlogfile2.log 2>&1


if(isset($_REQUEST['q'])&&@$_REQUEST['q']) 
{
	$suq_1=http_build_query($_REQUEST);
	echo "<br/><br/>suq_1=>".$suq_1;
}

$data['rootPath']="/var/www/html/";


$php_self1=@$_SERVER['PHP_SELF'];

//echo "\r\n\r\n<br/>php_self1=>".$php_self1; exit;

//$_REQUEST['dtest']=1;


// Testing in Localhost other wise comment bellow condition only 
//if ((strpos ( $php_self1, "var/www" ) !== false)||(strpos ( $php_self1, "www/html" ) !== false)) { $data['rootPath']="/opt/homebrew/var/www/gw/"; $_SERVER["HTTP_HOST"]='localhost:8080'; }

    

// Assing Private of Instance for secure cron as a whitelable 


$data['HideMenu']=true;
$data['NO_SALT']=true;
$data['SponsorDomain']=true;


$instancePrivateIP = gethostbyname(gethostname());
$data['secureCron']=$instancePrivateIP;



include(@$data['rootPath'].'config.do');


include(@$data['rootPath'].'signins/merchant_settlement.do');

db_disconnect();

exit;

?>
