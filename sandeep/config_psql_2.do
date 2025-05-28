<?
//$data['cid_2']=null;

## psql default - start ######


function db_connect_2($Hostname='',$Database='',$Username='',$Password='',$DbPort=5432){
	global $data;
	
	if(isset($data['Hostname_2'])&&trim($data['Hostname_2']))$Hostname=$data['Hostname_2'];
	if(isset($data['Database_2'])&&trim($data['Database_2']))$Database=$data['Database_2'];
	if(isset($data['Username_2'])&&trim($data['Username_2']))$Username=$data['Username_2'];
	if(isset($data['Password_2'])&&trim($data['Password_2']))$Password=$data['Password_2'];
	if(isset($data['DbPort_2'])&&trim($data['DbPort_2']))$DbPort=$data['DbPort_2'];
	
	if(isset($_GET['ps'])&&$_GET['ps']='c')
	{
		echo "<br/>DB_CONNECT_PSQL_DEFAULT=><br/>";
		echo "host=".$Hostname . " port=".$DbPort . " dbname=".$Database. " user=".$Username . " password=".$Password."  ";
		echo "<br/><br/>";
	}
	
	$data['cid_2']=@pg_connect("host=".$Hostname . " port=".$DbPort . " dbname=".$Database. " user=".$Username . " password=".$Password."  ");
	
	return $data['cid_2'];
}// End function


function db_disconnect_2(){
	global $data;
	return (bool)@pg_close($data['cid_2']);
}

function db_query_2($statement,$print=false){
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
	
	$pg_query_row=@$data['db_query']=@pg_query($data['cid_2'],$statement);
	
	
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
		 //echo pg_last_error($data['cid_2']);
	}
	
	
}

function newid_2(){
	global $data;
	//return @pg_insert_id($data['cid_2']);
	$db_query=@$data['db_query'];
	//var_dump($db_query);
	if (is_array($db_query) || is_object($db_query)){
		$fch = @pg_fetch_row(@$db_query);
		return @$fch[0];
	}
	//return @pg_last_oid($data['cid_2']);
}

function db_count_2($result){
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

function db_rows_2($statement,$print=false) {
	$result=array();global $db_counts, $data;
	
	$statement=str_ireplace(["`"],'"',$statement);
	//$statement=str_replace(["`","LIMIT 1"],'',$statement);
	
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==2)) echo("-->Default TimeZone=".date_default_timezone_get()."  Date Time=".date('d-m-Y h:i A')."<br/>{$statement}<br/><--");
	
	$msc = microtime(true);
	$query=db_query_2($statement);
	
	if(isset($query)&&$query){
		$count=db_count_2($query);
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