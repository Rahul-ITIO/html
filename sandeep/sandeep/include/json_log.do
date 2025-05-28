<? 
include('../config.do');
if(!isset($_SESSION['adm_login'])){ echo('ACCESS DENIED.'); exit; }

$tableid=@$_REQUEST['tableid'];
$tablename=@$_REQUEST['tablename'];

$type=isset($_REQUEST['type'])&&$_REQUEST['type']?$_REQUEST['type']:'';
if($type==1){
	$json_result = select_tablep("`id` ='{$tableid}'",$tablename); // For fetch payout db
}
elseif(isset($_REQUEST['clientid'])&&$_REQUEST['clientid']){
	$json_result = select_tablef("`clientid` ='{$tableid}'",$tablename); // fetch for clientid wise in table
}
else{
	$json_result = select_tablef("`id` ='{$tableid}'",$tablename); // For fetch Main db
}
echo "<h2> Json Log History : </h2>";
echo json_log_popup(@$json_result['json_log_history']);

?>