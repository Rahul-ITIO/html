<?
//$data['cid']=null;
function db_connect(){
	global $data;
	$data['cid']=@mysqli_connect($data['Hostname'], $data['Username'], $data['Password'],$data['Database']);

	
	if(!$data['cid']){
		echo(
			'<font style="font:10px Verdana;color:#FF0000">'.mysqli_error().
			".<br>Please contact to site administrator <a href=\"mailto:{$data['AdminEmail']}\">".
			"{$data['AdminEmail']}</a>.</font>"
		);
		exit;
	}
	//@mysqli_select_db($data['Database'], $data['cid']);
	
	return (bool)$data['cid'];
}// End function



function db_disconnect(){
	global $data;
	return (bool)@mysqli_close($data['cid']);
}

function db_query($statement,$print=false){
	global $data;
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==3)) echo("-->{$statement}<--<br>");
	$msc = microtime(true);
	//$mysql_query = mysqli_query($statement,$data['cid']);
	$mysql_query = mysqli_query($data['cid'],$statement);
	
	$msc = microtime(true)-$msc;
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==3)) echo("-->Query took ".($msc * 1000)." ms<--<hr/>");
	return $mysql_query;
}

function newid(){
	global $data;
	return @mysqli_insert_id($data['cid']);
}

function db_count($result){
	return (int)@mysqli_num_rows($result);
}

function db_rows($statement,$print=false) {
	$result=array();global $db_counts;
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==2)) echo("-->Default TimeZone=".date_default_timezone_get()."  Date Time=".date('d-m-Y h:i A')."<br>{$statement}<--<br>");
	$msc = microtime(true);
	$query=db_query($statement);
	$count=db_count($query);
	$db_counts=$count;
	$msc = microtime(true)-$msc;
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==2)) echo("-->{$count} total, Query took {$msc} seconds, ".($msc * 1000)." ms<--<hr/>");
	for($i=0; $i<$count; $i++){
		$record=@mysqli_fetch_array($query, MYSQLI_ASSOC);
		//$record=@mysqli_fetch_array($query, MYSQL_ASSOC);
		foreach($record as $key=>$value)
		{$result[$i][$key]=$value;}
	}
	return $result;
}
?>