<?php
// #!/var/www/html

//Dev Tech : 23-09-21 Trans is pending than expired without modify the tdate and notify is required than use suqery &notify=1

/*



http://localhost/gw/crons_expired.do?st=1&acquirer=104&li=2

http://localhost/gw/crons_expired?pq=1&acquirer=12&li=2

http://localhost/gw/crons_expired.do?st=1&notify=1&acquirer=104&li=2

http://localhost/gw/crons_expired.do?st=1&acquirer=104&li=2&day=4&day2=2

http://localhost/gw/crons_expired.do?st=1&acquirer=104&notAcquirer=42&li=2&day=4&day2=2
http://localhost/gw/crons_expired.do?st=1&acquirer=104&mid=27&li=2


For All Expired

http://localhost/gw/crons_expired?st=1&up1=10&li=2

// UPDATE "zt_master_trans_table_3" SET "trans_status"=22 WHERE "trans_status" IN (0) AND "tdate" <= now() - interval '10 minute' ;


*\/5 * * * * php /var/www/html/crons_expired.do
*\/5 * * * * /usr/bin/php /var/www/html/crons_expired.do > /dev/null 2>&1

*/

$data['NO_SALT']=1;
$data['SponsorDomain']=1;

$pq=0;
	
if(isset($_REQUEST['pq'])&&$_REQUEST['pq']) $pq=@$_REQUEST['pq'];
if(isset($_REQUEST['qp'])&&$_REQUEST['qp']) $pq=@$_REQUEST['qp'];

$php_self1=$_SERVER['PHP_SELF'];


if ((strpos ( $php_self1, "lampp/htdocs" ) !== false)||(strpos ( $php_self1, "www/html" ) !== false)) {
	$rootPhp="/var/www/html/";
	
	/*
		$hostHardCode='ipg.i15.tech';
		$data['Host']="https://".$hostHardCode;
		$_SERVER["HTTP_HOST"]=$hostHardCode;
	*/
	//$pq=0;
	$source="<b>Source - Cron Instance</b> via ";
}else{
	$rootPhp="";
	$source="<b>Source - Cron Host</b> via ";	
}

if(isset($data['rootPath'])){
	$rootPhp=$data['rootPath'];
}

include($rootPhp.'config.do');

$acquirer=0;
$limit=' LIMIT 2 ';
$mid_query='';

if(isset($_REQUEST['li'])&&$_REQUEST['li']>0){
		$limit=' LIMIT '.$_REQUEST['li'] .' ';
}

if(isset($_REQUEST['acquirer'])&&$_REQUEST['acquirer']>0){
		$acquirer=$_REQUEST['acquirer'];
}

if(isset($_REQUEST['mid'])&&$_REQUEST['mid']>0){
		$mid_query .= "  AND  `merID` IN ({$_REQUEST['mid']})  ";
}

if(isset($_REQUEST['up1'])&&$_REQUEST['up1']=='n')
{ // all pending to be expired 
		
		db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` SET `trans_status`=22 WHERE `trans_status` IN (0); ",$pq);
		
		db_disconnect();
		exit;
}
elseif(isset($_REQUEST['up1'])&&$_REQUEST['up1']=='acquirer_table_wise')
{ // acquirer table wise
		
	if(isset($pq)&&$pq) echo "<br/><br/>NOW=>".@(new DateTime())->format('Y-m-d H:i:s.u')."<br/><br/>";

	if($data['connection_type']=='PSQL')  $qr_interval_2= "'1 minute'";
	else $qr_interval_2= "1 minute";
	
	// UPDATE zt_master_trans_table_4 t SET trans_status = '22' FROM zt_acquirer_table a WHERE t.trans_status IN (0) AND t.acquirer = a.acquirer_id AND t.tdate < now() - (INTERVAL '1 minute' * a.trans_auto_expired );

	// UPDATE zt_master_trans_table_4 t SET trans_status = '22' FROM zt_acquirer_table a WHERE t.trans_status IN (0) AND t.acquirer = a.acquirer_id AND t.tdate < now() - (a.trans_auto_expired * INTERVAL '1 minute');

	db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` t  SET `trans_status` = '22' FROM `{$data['DbPrefix']}acquirer_table` a WHERE t.`trans_status` IN (0)  AND  t.`acquirer` = a.`acquirer_id`  AND  t.`tdate` <= now() - (a.trans_auto_expired * INTERVAL {$qr_interval_2});",$pq);
	
	db_disconnect();
	exit;

}
elseif(isset($_REQUEST['up1'])&&$_REQUEST['up1']>0)
{ // minute wise 
	if(@$pq) echo "<br/><br/>NOW=>".@(new DateTime())->format('Y-m-d H:i:s.u')."<br/><br/>";
		
		$up1=(int)$_REQUEST['up1'];
		if($data['connection_type']=='PSQL')
			$qr_interval= "'{$up1} minute' ";
			//$qr_interval= "'{$up1} minute' ORDER BY id {$limit}";
		else $qr_interval= "{$up1} minute {$limit}";
		
		db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` SET `trans_status`=22 WHERE `trans_status` IN (0) AND `tdate` <= now() - interval {$qr_interval}; ",$pq);
		
		db_disconnect();
		exit;
}

exit;
?>