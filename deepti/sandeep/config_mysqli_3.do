<?php
//$data['cid_3']=null;

//$data['create_trans_for_backup']='Y'; // Y is permission for create backup in trans master table via backup data base db 
	
$data['TRANS_BACKUP_DAYS']='30'; // 30 Days before for create backup from trans master table via backup data base db 
	
$data['Hostname_3']='172.31.10.183'; // localhost
$data['Username_3']='nextdbuser32';	 // mysql user name for db3
$data['Password_3']='zqG2JZML9TRQnma%samtDpFbyzKtk'; // mysql db_password for db3
//$data['Database_3']='dbtranstablebackup';	// database 3 name

function db_connect_3(){
	global $data;
	$data['cid_3']=@mysqli_connect($data['Hostname_3'], $data['Username_3'], $data['Password_3'],$data['Database_3']);


	if(!$data['cid_3']){
		echo(
			'<font style="font:10px Verdana;color:#FF0000">'.mysqli_error().
			".<br>Please contact to site administrator <a href=\"mailto:{$data['AdminEmail']}\">".
			"{$data['AdminEmail']}</a>.</font>"
		); 
		
		if((!isset($_SESSION['mysql_stopf_3']))&&($data['localhosts']==false)){
			check_mysql_services();
		}else{
			$_SESSION['mysql_stopf_3']=true;
		}
		exit;
		
	}
	//@mysqli_select_db($data['Database'], $data['cid_3']);
	
	return (bool)$data['cid_3'];
}// End function



function db_disconnect_3(){
	global $data;
	return (bool)@mysqli_close($data['cid_3']);
}

function db_query_3($statement,$print=false){
	global $data;
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==3)) echo("-->{$statement}<--<br>");
	$msc = microtime(true);
	//$mysql_query = mysqli_query($statement,$data['cid_3']);
	$mysql_query = @mysqli_query(@$data['cid_3'],$statement);
	
	$data['affected_rows']=mysqli_affected_rows(@$data['cid_3']);
	

	$msc = microtime(true)-$msc;
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==3)) echo("-->Query took ".($msc * 1000)." ms<--<hr/>");
	
	if($mysql_query !== FALSE)
	{
		
	  return $mysql_query;
		
	}else{
		
	//	echo mysqli_error($data['cid_3']);
		return mysqli_error($data['cid_3']);
	}
	
	
}

function newid_3(){
	global $data;
	return @mysqli_insert_id($data['cid_3']);
}

function db_count_3($result){
	return (int)@mysqli_num_rows($result);
}

function db_rows_3($statement,$print=false) {
	$result=array();global $db_count_3s, $data;
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==2)) echo("-->Default TimeZone=".date_default_timezone_get()."  Date Time=".date('d-m-Y h:i A')."<br/>{$statement}<br/><--");
	$msc = microtime(true);
	$query=db_query_3($statement);
	if(isset($query)&&$query){
		$count=db_count_3($query);
	}else{
		$count=0;
	}
	$db_count_3s=$count;
    $data['db_rows_3_count']=$count;
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