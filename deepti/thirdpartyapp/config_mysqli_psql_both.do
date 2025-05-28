<?php

function db_connect_mysqli(){
	global $data;
	if(isset($data['DbPort'])&&$data['DbPort']) $DbPort=$data['DbPort'];
	else $DbPort='3306';  // 3306 3307
	
	
	$data['cid']=@mysqli_connect($data['Hostname'], $data['Username'], $data['Password'],$data['Database'],$DbPort);
	
	return (bool)$data['cid'];
}// End function



function db_disconnect_mysqli(){
	global $data;
	return (bool)@mysqli_close($data['cid']);
}

function db_query_mysqli($statement,$print=false){
	global $data;
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==3)) echo("-->{$statement}<--<br>");
	$msc = microtime(true);
	//$mysql_query = mysqli_query($statement,$data['cid']);
	$mysql_query = @mysqli_query($data['cid'],$statement);
	
	$data['affected_rows']=mysqli_affected_rows($data['cid']);
	

	$msc = microtime(true)-$msc;
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==3)) echo("-->Query took ".($msc * 1000)." ms<--<hr/>");
	
	if($mysql_query !== FALSE)
	{
		
	  return $mysql_query;
		
	}else{
		
	//	echo mysqli_error($data['cid']);
		return mysqli_error($data['cid']);
	}
	
	
}

function newid_mysqli(){
	global $data;
	return @mysqli_insert_id($data['cid']);
}

function db_count_mysqli($result){
	if(isset($_GET['dtest'])&&isset($_GET['dtest'])){
		echo "<hr/>mysqli_report=> <span style='color:red;'>";
			print_r($result);
		echo "</span><br/><hr/>";
	}
	if (is_array($result) || is_object($result))
	return (int)@mysqli_num_rows(@$result);
}

function db_rows_mysqli($statement,$print=false) {
	$result=array();global $db_counts, $data;
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==2)) echo("-->Default TimeZone=".date_default_timezone_get()."  Date Time=".date('d-m-Y h:i A')."<br/>{$statement}<br/><--");
	$msc = microtime(true);
	$query=db_query_mysqli($statement);
	if(isset($query)&&$query){
		$count=db_count_mysqli($query);
	}else{
		$count=0;
	}
	$db_counts=$count;
    $data['db_rows_count']=$count;
	$msc = microtime(true)-$msc;
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==2)) echo("{$count} total, Query took {$msc} seconds, ".($msc * 1000)." ms<--<hr/>");
	if($query&&$count)
	{
	   for($i=0; $i<$count; $i++){
			$record=@mysqli_fetch_array($query, MYSQLI_ASSOC);
			if (is_array($record) || is_object($record))
			{
				foreach($record as $key=>$value)
				{$result[$i][$key]=$value;}
			}
		}
		
	}else{
		if(($print||(isset($_GET['dtest'])&&$_GET['dtest']==2)) && !$query){
			echo("<font style='color:red;'><br/>This table does not exist==><br/>").$statement."<br/><br/></font>";
		}
	}
	return $result;
}

## mysqli - end ######






## mysqli default - start ######

function db_connect_mysqli_default($Hostname,$Database,$Username,$Password,$DbPort=3306){
	global $data;
	
	if(isset($_GET['ps'])&&$_GET['ps']='c')
	{
		echo "<br/>DB_CONNECT_MYSQLI_DEFAULT=><br/>";
		echo "Hostname: $Hostname, Username: $Username, Password: $Password,Database: $Database, DbPort:$DbPort";
		echo "<br/><br/>";
	}

	$data['cid_mysqli_default']=@mysqli_connect($Hostname, $Username, $Password,$Database,$DbPort);
	
	return (bool)$data['cid_mysqli_default'];
}// End function



function db_disconnect_mysqli_default(){
	global $data;
	return (bool)@mysqli_close($data['cid_mysqli_default']);
}

function db_query_mysqli_default($statement,$print=false){
	global $data;
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==3)) echo("-->{$statement}<--<br>");
	$msc = microtime(true);
	//$mysql_query = mysqli_query($statement,$data['cid_mysqli_default']);
	$mysql_query = @mysqli_query($data['cid_mysqli_default'],$statement);
	
	$data['affected_rows']=mysqli_affected_rows($data['cid_mysqli_default']);
	

	$msc = microtime(true)-$msc;
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==3)) echo("-->Query took ".($msc * 1000)." ms<--<hr/>");
	
	if($mysql_query !== FALSE)
	{
		
	  return $mysql_query;
		
	}else{
		
	//	echo mysqli_error($data['cid_mysqli_default']);
		return mysqli_error($data['cid_mysqli_default']);
	}
	
	
}

function newid_mysqli_default(){
	global $data;
	return @mysqli_insert_id($data['cid_mysqli_default']);
}

function db_count_mysqli_default($result){
	if(isset($_GET['dtest'])&&isset($_GET['dtest'])){
		echo "<hr/>mysqli_report=> <span style='color:red;'>";
			print_r($result);
		echo "</span><br/><hr/>";
	}
	if (is_array($result) || is_object($result))
	return (int)@mysqli_num_rows(@$result);
}

function db_rows_mysqli_default($statement,$print=false) {
	$result=array();global $db_counts, $data;
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==2)) echo("-->Default TimeZone=".date_default_timezone_get()."  Date Time=".date('d-m-Y h:i A')."<br/>{$statement}<br/><--");
	$msc = microtime(true);
	$query=db_query_mysqli_default($statement);
	if(isset($query)&&$query){
		$count=db_count_mysqli_default($query);
	}else{
		$count=0;
	}
	$db_counts=$count;
    $data['db_rows_count']=$count;
	$msc = microtime(true)-$msc;
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==2)) echo("{$count} total, Query took {$msc} seconds, ".($msc * 1000)." ms<--<hr/>");
	if($query&&$count)
	{
	   for($i=0; $i<$count; $i++){
			$record=@mysqli_fetch_array($query, MYSQLI_ASSOC);
			if (is_array($record) || is_object($record))
			{
				foreach($record as $key=>$value)
				{$result[$i][$key]=$value;}
			}
		}
		
	}else{
		if(($print||(isset($_GET['dtest'])&&$_GET['dtest']==2)) && !$query){
			echo("<font style='color:red;'><br/>This table does not exist==><br/>").$statement."<br/><br/></font>";
		}
	}
	return $result;
}

## mysqli - end ######












## psql - start ######


function db_connect_psql(){
	global $data;
	if(isset($data['DbPort'])&&$data['DbPort']) $DbPort=(int)$data['DbPort'];
	else $DbPort=(int)'5432'; // 5432  3306
	
	$data['cid']=@pg_connect("host=".$data['Hostname'] . " port=".$DbPort . " dbname=".$data['Database']. " user=".$data['Username'] . " password=".$data['Password']."  ");
	
	//$data['cid']=@pg_connect("host=".$data['Hostname'] . " port=".$DbPort . " dbname=".$data['Database']. " user=".$data['Username'] . " password=".$data['Password']." options='--client_encoding=UTF8' ");
	
	return $data['cid'];
}// End function



function db_disconnect_psql(){
	global $data;
	return (bool)@pg_close($data['cid']);
}

function db_query_psql($statement,$print=false){
	global $data;
	
	$msc = microtime(true);
	if(is_string($statement)) 
	{
		$statement=str_replace(["`"],'"',$statement);
		
		//INSERT INTO
		$statement_lower = strtolower($statement);
		if(strpos($statement_lower, 'insert into') !== false && strpos($statement_lower, 'master_trans_additional') !== false)
			$statement.=' RETURNING id_ad; ';
		
		elseif(strpos($statement_lower, 'insert into') !== false)
			$statement.=' RETURNING id; ';
	
		if($print||(isset($_GET['dtest'])&&$_GET['dtest']==3)) 
		echo("-->{$statement}<--<br>");
	}
	/*
	$statement=trim($statement);
	$statement=ltrim($statement,'"');
	$statement=rtrim($statement,'"');
	*/
	//var_dump($statement);
	
	$pg_query_row=@$data['db_query']=@pg_query($data['cid'],$statement);
	
	
	//$data['affected_rows']= @pg_affected_rows($pg_query_row);
	$data['affected_rows']=1;
	
	$msc = microtime(true)-$msc;
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==3)) echo("-->Query took ".($msc * 1000)." ms<--<hr/>");
	
	if($pg_query_row !== FALSE)
	{
	  return $pg_query_row;
	  //return true;
	}else{
		return pg_last_error();
	}
	
	
}

function newid_psql(){
	global $data;
	//return @pg_insert_id($data['cid']);
	$db_query=@$data['db_query'];
	//var_dump($db_query);
	if (is_array($db_query) || is_object($db_query)){
		$fch = @pg_fetch_row(@$db_query);
		return @$fch[0];
	}
	//return @pg_last_oid($data['cid']);
}

function db_count_psql($result){
	/*
	if(isset($_GET['dtest'])&&isset($_GET['dtest'])){
		$result1=pg_fetch_assoc($result);
		echo "<hr/>pg_report=> <span style='color:red;'>";
			print_r($result1);
		echo "</span><br/><hr/>";
	}
	*/
	if (is_array($result) || is_object($result))
	return (int)@pg_num_rows(@$result);
}

function db_rows_psql($statement,$print=false) {
	$result=array();global $db_counts, $data;
	
	$statement=str_ireplace(["`"],'"',$statement);
	//$statement=str_replace(["`","LIMIT 1"],'',$statement);
	
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==2)) echo("-->Default TimeZone=".date_default_timezone_get()."  Date Time=".date('d-m-Y h:i A')."<br/>{$statement}<br/><--");
	
	$msc = microtime(true);
	$query=db_query_psql($statement);
	
	if(isset($query)&&$query){
		$count=db_count_psql($query);
	}else{
		$count=0;
	}
	$db_counts=$count;
    $data['db_rows_count']=$count;
	$msc = microtime(true)-$msc;
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==2)) echo("{$count} total, Query took {$msc} seconds, ".($msc * 1000)." ms<--<hr/>");
	
	
	
	$results_rows = $query;
	
	if(isset($_SESSION['login_adm'])&&isset($_GET['dtest'])&&$_GET['dtest']==3){
		echo "<div class='tbl_exl td_relative my-2' style='overflow:auto;float: left;width:96vw;min-height:100px;'><table width='100%' border='0' cellspacing='1' cellpadding='0'>\n";
		for($lt = 0; $lt < pg_num_rows($results_rows); $lt++) {
			echo "<tr>\n";
			for($gt = 0; $gt < pg_num_fields($results_rows); $gt++) {
				echo "<td title='" . @pg_field_name(@$results_rows, $gt) . "' >" . @pg_result($results_rows, $lt, $gt) . "</td>\n";
			}
			echo "</tr>\n";
		}
		echo "</table></div>\n";
	}
	
	
	if($query&&$count)
	{
	   for($i=0; $i<$count; $i++)
	   {
			$record=@pg_fetch_array($query, NULL,  PGSQL_ASSOC);
			if (is_array($record) || is_object($record))
			{
				foreach($record as $key=>$value)
				{$result[@$i][$key]=$value;}
			}
		}
		
	}
	else{
		if(($print||(isset($_GET['dtest'])&&$_GET['dtest']==2)) && !$query){
			echo("<font style='color:red;'><br/>This table does not exist==><br/>").$statement."<br/><br/></font>";
		}
	}
	return $result;
}


## psql - end ######











## psql default - start ######


function db_connect_psql_default($Hostname,$Database,$Username,$Password,$DbPort=5432){
	global $data;
	
	if(isset($_GET['ps'])&&$_GET['ps']='c')
	{
		echo "<br/>DB_CONNECT_PSQL_DEFAULT=><br/>";
		echo "host=".$Hostname . " port=".$DbPort . " dbname=".$Database. " user=".$Username . " password=".$Password."  ";
		echo "<br/><br/>";
	}
	
	$data['cid_psql_default']=@pg_connect("host=".$Hostname . " port=".$DbPort . " dbname=".$Database. " user=".$Username . " password=".$Password."  ");
	
	return $data['cid_psql_default'];
}// End function


function db_disconnect_psql_default(){
	global $data;
	return (bool)@pg_close($data['cid_psql_default']);
}

function db_query_psql_default($statement,$print=false){
	global $data;
	
	$msc = microtime(true);
	if(is_string($statement)) 
	{
		$statement=str_replace(["`"],'"',$statement);
		
		//INSERT INTO
		$statement_lower = strtolower($statement);
		if(strpos($statement_lower, 'insert into') !== false && strpos($statement_lower, 'master_trans_additional') !== false)
			$statement.=' RETURNING id_ad; ';
		
		elseif(strpos($statement_lower, 'insert into') !== false)
			$statement.=' RETURNING id; ';
	
		if($print||(isset($_GET['dtest'])&&$_GET['dtest']==3)) 
		echo("-->{$statement}<--<br>");
	}
	/*
	$statement=trim($statement);
	$statement=ltrim($statement,'"');
	$statement=rtrim($statement,'"');
	*/
	//var_dump($statement);
	
	$pg_query_row=@$data['db_query']=@pg_query($data['cid_psql_default'],$statement);
	
	
	//$data['affected_rows']= @pg_affected_rows($pg_query_row);
	$data['affected_rows']=1;
	
	$msc = microtime(true)-$msc;
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==3)) echo("-->Query took ".($msc * 1000)." ms<--<hr/>");
	
	if($pg_query_row !== FALSE)
	{
	  return $pg_query_row;
	  //return true;
	}else{
		return pg_last_error();
	}
	
	
}

function newid_psql_default(){
	global $data;
	//return @pg_insert_id($data['cid_psql_default']);
	$db_query=@$data['db_query'];
	//var_dump($db_query);
	if (is_array($db_query) || is_object($db_query)){
		$fch = @pg_fetch_row(@$db_query);
		return @$fch[0];
	}
	//return @pg_last_oid($data['cid_psql_default']);
}

function db_count_psql_default($result){
	/*
	if(isset($_GET['dtest'])&&isset($_GET['dtest'])){
		$result1=pg_fetch_assoc($result);
		echo "<hr/>pg_report=> <span style='color:red;'>";
			print_r($result1);
		echo "</span><br/><hr/>";
	}
	*/
	if (is_array($result) || is_object($result))
	return (int)@pg_num_rows(@$result);
}

function db_rows_psql_default($statement,$print=false) {
	$result=array();global $db_counts, $data;
	
	$statement=str_ireplace(["`"],'"',$statement);
	//$statement=str_replace(["`","LIMIT 1"],'',$statement);
	
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==2)) echo("-->Default TimeZone=".date_default_timezone_get()."  Date Time=".date('d-m-Y h:i A')."<br/>{$statement}<br/><--");
	
	$msc = microtime(true);
	$query=db_query_psql_default($statement);
	
	if(isset($query)&&$query){
		$count=db_count_psql_default($query);
	}else{
		$count=0;
	}
	$db_counts=$count;
    $data['db_rows_count']=$count;
	$msc = microtime(true)-$msc;
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==2)) echo("{$count} total, Query took {$msc} seconds, ".($msc * 1000)." ms<--<hr/>");
	
	
	
	$results_rows = $query;
	
	if(isset($_SESSION['login_adm'])&&isset($_GET['dtest'])&&$_GET['dtest']==3){
		echo "<div class='tbl_exl td_relative my-2' style='overflow:auto;float: left;width:96vw;min-height:100px;'><table width='100%' border='0' cellspacing='1' cellpadding='0'>\n";
		for($lt = 0; $lt < pg_num_rows($results_rows); $lt++) {
			echo "<tr>\n";
			for($gt = 0; $gt < pg_num_fields($results_rows); $gt++) {
				echo "<td title='" . @pg_field_name(@$results_rows, $gt) . "' >" . @pg_result($results_rows, $lt, $gt) . "</td>\n";
			}
			echo "</tr>\n";
		}
		echo "</table></div>\n";
	}
	
	
	if($query&&$count)
	{
	   for($i=0; $i<$count; $i++)
	   {
			$record=@pg_fetch_array($query, NULL,  PGSQL_ASSOC);
			if (is_array($record) || is_object($record))
			{
				foreach($record as $key=>$value)
				{$result[@$i][$key]=$value;}
			}
		}
		
	}
	else{
		if(($print||(isset($_GET['dtest'])&&$_GET['dtest']==2)) && !$query){
			echo("<font style='color:red;'><br/>This table does not exist==><br/>").$statement."<br/><br/></font>";
		}
	}
	return $result;
}


## psql - end ######

?>