<?
//Dev Tech : 23-09-21 Trans is pending than expired without modify the tdate and notify is required than use suqery &notify=1

/*


http://localhost/gw/crons_above_7days.do?pq=1&li=2&day=365&day2=30

http://localhost/gw/crons_above_7days.do?st=1&notify=1&acquirer=104&li=2

http://localhost/gw/crons_above_7days.do?st=1&acquirer=104&li=2&day=4&day2=2

http://localhost/gw/crons_above_7days.do?st=1&acquirer=104&notAcquirer=42&li=2&day=4&day2=2
http://localhost/gw/crons_above_7days.do?st=1&acquirer=104&mid=27&li=2


*/

$data['NO_SALT']=1;
$data['SponsorDomain']=1;
include('config.do');

if(!isset($_SESSION['adm_login']))
{
	echo('ACCESS DENIED.');
	exit;
}

$pq=0;
	
if(isset($_GET['pq'])&&$_GET['pq']) $pq=@$_GET['pq'];
if(isset($_GET['qp'])&&$_GET['qp']) $pq=@$_GET['qp'];

$acquirer=0;
$limit=' LIMIT 5 ';
$queryString='';

// Set default 30 day back from current date 
$day='30';
$day_1st = (int)$day+30; // duration of 30 days from assing backup days
//$day_1st = $day;
$date_2nd = date('Y-m-d',strtotime("-{$day} days"));

// Customise and over write to default 30 day back and current date 	
if(isset($_GET['day'])&&$_GET['day']){
	$day_1st=$_GET['day'];
	if(isset($_GET['day2'])&&$_GET['day2']&&$_GET['day2']<=$day_1st)
	{
		$day2=$_GET['day2'];
		$date_2nd=(date('Y-m-d',strtotime("-{$day2} days")));
	} 
}

$date_1st = date('Y-m-d',strtotime("-{$day_1st} days"));


$queryString .= "  AND  ( `tdate` BETWEEN (DATE_FORMAT('{$date_1st} 00:00:00', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$date_2nd} 23:59:59', '%Y%m%d%H%i%s')) )   ";


if(isset($_GET['li'])&&$_GET['li']>0){
		$limit=' LIMIT '.$_GET['li'] .' ';
}

if(isset($_GET['acquirer'])&&$_GET['acquirer']>0){
		$acquirer=$_GET['acquirer'];
}

if(isset($_GET['mid'])&&$_GET['mid']>0){
		$queryString .= "  AND  `merID` IN ({$_GET['mid']})  ";
}

/*
if((isset($_GET['notAcquirer']))&&($_GET['notAcquirer'])){
	$notAcquirer=','.$_GET['notAcquirer'];
	$queryString .= " AND (`acquirer` NOT IN (0,1,2,3,4,5,6,7,8,9,10,11,12{$notAcquirer}) ) ";
}
*/		



		//echo "<br/><br/>=>test555555";exit;






echo "<br/><br/><hr/><br/>{$pq}<==queryString==> ".$queryString;
			echo "<br/><br/><hr/>";
			
//if($pq==2) exit;
			
create_trans_for_backup($queryString,$limit);

db_disconnect();

exit;


?>