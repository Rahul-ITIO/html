<?
//Dev Tech : 24-03-29 Transaction - scrubbed check 

/* 

// http://localhost:8080/gw/tinclude/scrubbed_trans_check.do?cquirer=102


http://localhost/gw/tinclude/scrubbed_trans_check.do?clientid=11311&acquirer=102&transID=1023833001&bill_email=test1939@test.com


*/

$data['NO_SALT']=1;
$data['SponsorDomain']=1;
include('../config.do');



$pq=0;

$clientid=$_SESSION['clientid'];
$acquirer=102;
$transID=@$_SESSION['transID'];
$bill_email=@$_SESSION['re_post']['bill_email'];

if(isset($_GET['clientid'])&&$_GET['clientid']) $clientid=@$_GET['clientid'];
if(isset($_GET['acquirer'])&&$_GET['acquirer']) $acquirer=@$_GET['acquirer'];
if(isset($_GET['transID'])&&$_GET['transID']) $transID=@$_GET['transID'];
if(isset($_GET['bill_email'])&&$_GET['bill_email']) $bill_email=@$_GET['bill_email'];

$jsonView=[];
$jsonView['clientid']=$clientid;
$jsonView['acquirer']=$acquirer;
$jsonView['transID']=$transID;
$jsonView['bill_email']=$bill_email;

echo "<br/><hr/><br/>jsonView=><br/>".json_encode($jsonView);

echo "<br/><hr/>";



if(isset($_GET['pq'])&&$_GET['pq']) $pq=@$_GET['pq'];
if(isset($_GET['qp'])&&$_GET['qp']) $pq=@$_GET['qp'];

$scrubbed=scrubbed_trans($clientid,$acquirer,$transID,$bill_email);

echo "<br/><hr/><br/>scrubbed=><br/>";

print_r($scrubbed);

echo "<br/><hr/>";

db_disconnect();

exit;


?>