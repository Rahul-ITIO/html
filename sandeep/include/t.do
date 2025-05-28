<?php
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



include('../config.do');

if(!isset($_SESSION['adm_login'])){
       echo('ACCESS DENIED.');
       exit;
}


$settelement_delay='20.60';
echo "<br/><br/>settelement_delay=>".$settelement_delay;
echo "<br/><br/>settelement_delay=>".(int)$settelement_delay;

$acquirer_id=impf("38,'478'".',"48"',2);
echo "<br/><br/>acquirer_id=>".$acquirer_id;

exit;



$tdate_micro=micro_current_date();

$insert_qr1 = "INSERT INTO db_test (date,msg) VALUES ('{$tdate_micro}','db tedfdf {$tdate_micro}') ";

$db_query=db_query($insert_qr1,1); 

$insert_last_id =newid();
echo "<br/><br/>insert_last_id=>".$insert_last_id."<br/><br/>";


$db_query=pg_fetch_assoc($db_query); 
echo "<hr/>Result=>"; 
print_r($db_query);



exit;

 // Create a sample table
  //pg_query("CREATE TABLE test_6 (a INTEGER) WITH OIDS");
	
	$tdate_micro=micro_current_date();
	
  // Insert some data into it
 // $res = pg_query("INSERT INTO db_test (id,msg) VALUES ('1','db tedfdf')");
  //$res = pg_query("INSERT INTO db_test (date,msg) VALUES ('{$tdate_micro}','db tedfdf {$tdate_micro}') RETURNING Currval('db_test_id_seq') ");
  $res = pg_query("INSERT INTO db_test (date,msg) VALUES ('{$tdate_micro}','db tedfdf {$tdate_micro}') RETURNING id; ");

  $oid = pg_last_oid($res);
  
  $fch = pg_fetch_row($res);
  echo "<br/><br/>fch=>";
	print_r($fch);
  
  echo "<br/><br/>Last id=>".$fch[0]."<br/><br/>";
  echo "<br/><br/>oid=>".$oid."<br/><br/>";
 // echo "<br/><br/>pg_getlastoid=>".pg_getlastoid()."<br/><br/>";

exit;

//echo "<br/>cid1=>".@$data['cid'];

function findStrf1($str, $arr) {  
    foreach ($arr as &$s){
       if(strpos($str, $s) !== false){
			return $s; //return true;break;
	   }
    }
    return false;
}

$queryArray1=["UPDATE","DELETE","INSERT","ALTER"];

$p='';
if((isset($_GET['qr'])&&($_GET['qr']))||(isset($_POST['qr'])&&($_POST['qr']))){
	$q=$_REQUEST['qr'];
	$p=$q;
	$q_str = str_ireplace(array('update','delete','insert','alter'), array('UPDATE','DELETE','INSERT','ALTER'), $q );
	$isNotQuery=findStrf1($q_str, $queryArray1);
	//echo "<br/><br/>q_str=>".$q_str."<br/><br/>"; echo "<br/><br/>isNotQuery=>".$isNotQuery."<br/><br/>";
	if($isNotQuery){
		echo "Not Allow this Query";
	}else{
		$db_query=db_query($q,1); echo "<hr/>Result=>"; print_r($db_query);
	}
	
	
}elseif((isset($_GET['s'])&&($_GET['s']))||(isset($_POST['s'])&&($_POST['s']))){
	$s=$_REQUEST['s'];
	$p=$s;
	
	$q_str = str_ireplace(array('update','delete','insert','alter'), array('UPDATE','DELETE','INSERT','ALTER'), $s );
	$isNotQuery=findStrf1($q_str, $queryArray1);
	
	if($isNotQuery){
		echo "Not Allow this Query";
	}else{
		$db_rows1=db_rows($s,1);
	}
	
	
	
	if((isset($_GET['p'])&&($_GET['p']))||(isset($_POST['p'])&&($_POST['p']))){
		echo "<hr/>Result=>";
		print_r($db_rows1);
	}
	
}


echo "<br/>cid=>"; print_r($data['cid']);

//db_disconnect();	//disconnect DB connection
//ob_end_flush();		//Deletes the topmost output buffer and outputs all of its contents.
	
//@mysqli_close($data['cid']);
db_disconnect();

?>