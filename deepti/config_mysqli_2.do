<?
//$data['cid_2']=null;
function db_connect_2(){
	global $data;
	$data['cid_2']=@mysqli_connect($data['Hostname_2'], $data['Username_2'], $data['Password_2'],$data['Database_2']);


	if(!$data['cid_2']){
		echo(
			'<font style="font:10px Verdana;color:#FF0000">'.mysqli_error().
			".<br>Please contact to site administrator <a href=\"mailto:{$data['AdminEmail']}\">".
			"{$data['AdminEmail']}</a>.</font>"
		); 
		
		if((!isset($_SESSION['mysql_stopf_2']))&&($data['localhosts']==false)){
			check_mysql_services();
		}else{
			$_SESSION['mysql_stopf_2']=true;
		}
		exit;
		
	}
	//@mysqli_select_db($data['Database'], $data['cid_2']);
	
	return (bool)$data['cid_2'];
}// End function



function db_disconnect_2(){
	global $data;
	return (bool)@mysqli_close($data['cid_2']);
}

function db_query_2($statement,$print=false){
	global $data;
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==3)) echo("-->{$statement}<--<br>");
	$msc = microtime(true);
	//$mysql_query = mysqli_query($statement,$data['cid_2']);
	$mysql_query = @mysqli_query($data['cid_2'],$statement);
	
	$data['affected_rows']=mysqli_affected_rows($data['cid_2']);
	

	$msc = microtime(true)-$msc;
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==3)) echo("-->Query took ".($msc * 1000)." ms<--<hr/>");
	
	if($mysql_query !== FALSE)
	{
		
	  return $mysql_query;
		
	}else{
		
	//	echo mysqli_error($data['cid_2']);
		return mysqli_error($data['cid_2']);
	}
	
	
}

function newid_2(){
	global $data;
	return @mysqli_insert_id($data['cid_2']);
}

function db_count_2($result){
	return (int)@mysqli_num_rows($result);
}

function db_rows_2($statement,$print=false) {
	$result=array();global $db_count_2s, $data;
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==2)) echo("-->Default TimeZone=".date_default_timezone_get()."  Date Time=".date('d-m-Y h:i A')."<br/>{$statement}<br/><--");
	$msc = microtime(true);
	$query=db_query_2($statement);
	if(isset($query)&&$query){
		$count=db_count_2($query);
	}else{
		$count=0;
	}
	$db_count_2s=$count;
    $data['db_rows_2_count']=$count;
	$msc = microtime(true)-$msc;
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==2)) echo("{$count} total, Query took {$msc} seconds, ".($msc * 1000)." ms<--<hr/>");
	if($query&&$count)
	{
	   for($i=0; $i<$count; $i++){
			$record=@mysqli_fetch_array($query, MYSQLI_ASSOC);
			foreach($record as $key=>$value)
			{$result[$i][$key]=$value;}
		}
		
	}else{
		if(($print||(isset($_GET['dtest'])&&$_GET['dtest']==2)) && !$query){
			echo("<font style='color:red;'><br/>This table does not exist==><br/>").$statement."<br/><br/></font>";
		}
	}
	return $result;
}



?>