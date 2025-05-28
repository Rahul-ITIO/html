<?php
//$data['cid']=null;

function check_mysql_services(){
	global $data;
		$email_from1="mySql <info@website2.website>";
		$email_to1="Mith <{$data['testEmail_1']}>";
		$email_to_name1="Dev Tech";
		$email_subject1=$_SERVER['SERVER_ADDR']." - ".($_SERVER['HTTP_X_FORWARDED_FOR']?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR'])." mySql Services have been stoped on {$_SERVER['HTTP_HOST']}";
		$email_message1="<html><h1>Hello, {$_SERVER["HTTP_HOST"]}</h1><p> have been stoped of mySql Services.</p></html>";
		
		
		$email_message1.="<p><b>Internet IP: </b>".($_SERVER['HTTP_X_FORWARDED_FOR']?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR'])."</p>";
		$email_message1.="<p><b>urlpath: </b>".$data['urlpath']."</p>";
		
		
		if(isset($_SERVER['HTTP_REFERER'])){
			$email_message1.="<p><b>HTTP_REFERER: </b>".$_SERVER['HTTP_REFERER']."</p>";
		}
		if(isset($_POST)){
			$email_message1.="<p><b>_POST: </b>".json_encode($_POST)."</p>";
		}
		if(isset($_GET)){
			$email_message1.="<p><b>_GET: </b>".json_encode($_GET)."</p>";
		}
		
		
		$sam1['HostL']=1;
		//$response_mail1=send_attchment_message($email_to1,$email_to_name1,$email_subject1,$email_message1,$sam1);	
		
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
		curl_setopt($ch, CURLOPT_USERPWD, 'api:bc73b879c7d3a32621334c4913981fb5-0e6e8cad-6a6fec66');
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

		curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
		curl_setopt($ch, CURLOPT_URL, 'https://api.mailgun.net/v3/email.website2.website/messages');
		curl_setopt($ch, CURLOPT_POSTFIELDS, array('from' => $email_from1,
												 'to' => $email_to1,
												 'subject' => $email_subject1,
												 'html' => $email_message1,
												 ));
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
		$response_mail1 = curl_exec($ch);
		curl_close($ch);
		//echo "<hr/>mailgun Result=".$response_mail1;
}

function db_connect(){
	global $data;
	if(isset($data['DbPort'])&&$data['DbPort']) $DbPort=(int)$data['DbPort'];
	else $DbPort=(int)'3306';
	
	$data['cid']=@pg_connect("host=".$data['Hostname'] . " port=".$DbPort . " dbname=".$data['Database']. " user=".$data['Username'] . " password=".$data['Password']."  ");
	
	//$data['cid']=@pg_connect("host=".$data['Hostname'] . " port=".$DbPort . " dbname=".$data['Database']. " user=".$data['Username'] . " password=".$data['Password']." options='--client_encoding=UTF8' ");
	
	

	/*
	if(!$data['cid']){
		
		if(pg_connect_errno()&&(isset($_GET['dtest']))) {
			echo "<hr/>pg_connect_error=> <span style='color:red;'>";
				printf("Connect failed: %s\n", pg_connect_error());
			echo "</span><br/><hr/>";
		}
		
		echo(
			'<font style="font:10px Verdana;color:#FF0000">'.die(pg_error()).
			".<br>Please contact to site administrator <a href=\"mailto:{$data['AdminEmail']}\">".
			"{$data['AdminEmail']}</a>.</font>"
		);
			
		
		if((!isset($_SESSION['mysql_stopf']))&&($data['localhosts']==false)){
			check_mysql_services();
		}else{
			$_SESSION['mysql_stopf']=true;
		}
		exit;
		
	}
	*/
	//@pg_select_db($data['Database'], $data['cid']);
	
	return $data['cid'];
}// End function



function db_disconnect(){
	global $data;
	return (bool)@pg_close($data['cid']);
}

function db_query($statement,$print=false){
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
	//var_dump($statement);
	$pg_query=$data['db_query']=@pg_query($data['cid'],$statement);
	
	
	//$data['affected_rows']= @pg_affected_rows($pg_query);
	$data['affected_rows']=1;
	
	$msc = microtime(true)-$msc;
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==3)) echo("-->Query took ".($msc * 1000)." ms<--<hr/>");
	
	if($pg_query !== FALSE)
	{
	  return $pg_query;
	  //return true;
	}else{
		return pg_last_error();
	}
	
	
}

function newid(){
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

function db_count($result){
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

function db_rows($statement,$print=false) {
	$result=array();global $db_counts, $data;
	
	$statement=str_ireplace(["`"],'"',$statement);
	//$statement=str_replace(["`","LIMIT 1"],'',$statement);
	
	if($print||(isset($_GET['dtest'])&&$_GET['dtest']==2)) echo("-->Default TimeZone=".date_default_timezone_get()."  Date Time=".date('d-m-Y h:i A')."<br/>{$statement}<br/><--");
	
	$msc = microtime(true);
	$query=db_query($statement);
	
	if(isset($query)&&$query){
		$count=db_count($query);
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


?>