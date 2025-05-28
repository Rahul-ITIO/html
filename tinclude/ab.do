<?php
// http://localhost:8080/gw/tinclude/ab?merID=11319&dtest=2&qp=1
function print_mem()
{
   /* Currently used memory */
   $mem_usage = memory_get_usage();
   
   /* Peak memory usage */
   $mem_peak = memory_get_peak_usage();
   echo 'Memory Consumption is: <strong>' . round($mem_usage / 1048576,2) . ' MB</strong> of memory. | ';
   echo 'Peak usage: <strong>' . round($mem_peak / 1048576,2) . ' MB</strong> of memory.<br>';
}
print_mem();


$data['NO_SALT']=true;
$data['SponsorDomain']=true;
include('../config.do');

if(!isset($_SESSION['adm_login'])){
       echo('ACCESS DENIED.');
       exit;
}

$merID=0;

if(isset($_REQUEST['merID'])&&!empty($_REQUEST['merID'])&&$_REQUEST['merID']>0)
$merID=@$_REQUEST['merID'];


$payout_res=$post=trans_balance_wv3_custom($merID,2);
echo "<br/><br/>trans_balance_wv3_custom=>";
print_r($post);

echo "<br/><hr/><br/>";

include("../include/trans_balance_ui_withdraw_v3_custom".$data['iex']);


//echo "<br/>cid=>"; print_r($data['cid']);

//db_disconnect();	//disconnect DB connection
//ob_end_flush();		//Deletes the topmost output buffer and outputs all of its contents.
	
//@mysqli_close($data['cid']);
db_disconnect();

?>