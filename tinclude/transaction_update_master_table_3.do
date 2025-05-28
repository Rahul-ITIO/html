<?
//Dev Tech : 24-01-06 Transaction insert from master table in additional 

/* 

http://localhost/gw/tinclude/transaction_update_master_table_3.do


*/

$data['NO_SALT']=1;
$data['SponsorDomain']=1;
include('../config.do');

if(!isset($_SESSION['adm_login']))
{
	echo('ACCESS DENIED.');
	exit;
}

$pq=0;
	
if(isset($_GET['pq'])&&$_GET['pq']) $pq=@$_GET['pq'];
if(isset($_GET['qp'])&&$_GET['qp']) $pq=@$_GET['qp'];



$acquirer=0;
$limit=' LIMIT 2 ';

$queryString='';

// Set default 30 day back from current date 
$day='30';
$day_1st = (int)$day+30; // duration of 30 days from assing backup days
//$day_1st = $day;
$date_2nd = date('Y-m-d',strtotime("-{$day} days"));

// Customise and over write to default 30 day back and current date 	
if(isset($_GET['day'])&&$_GET['day']){
	$day_1st=$_GET['day'];
	if(isset($_GET['day2'])&&$_GET['day2']&&$_GET['day2']<=$day_1st)
	{
		$day2=$_GET['day2'];
		$date_2nd=(date('Y-m-d',strtotime("-{$day2} days")));
	} 
}

$date_1st = date('Y-m-d',strtotime("-{$day_1st} days"));


$queryString .= "  AND  ( `tdate` BETWEEN (DATE_FORMAT('{$date_1st} 00:00:00', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$date_2nd} 23:59:59', '%Y%m%d%H%i%s')) )   ";


if(isset($_GET['noli'])){
		$limit='  ';
}
if(isset($_GET['li'])&&$_GET['li']>0){
		$limit=' LIMIT '.$_GET['li'] .' ';
}

if(isset($_GET['acquirer'])&&$_GET['acquirer']>0){
		$acquirer=$_GET['acquirer'];
}

if(isset($_GET['mid'])&&$_GET['mid']>0){
		$queryString .= "  AND  `merID` IN ({$_GET['mid']})  ";
}

/*
if((isset($_GET['notAcquirer']))&&($_GET['notAcquirer'])){
	$notAcquirer=','.$_GET['notAcquirer'];
	$queryString .= " AND (`acquirer` NOT IN (0,1,2,3,4,5,6,7,8,9,10,11,12{$notAcquirer}) ) ";
}
*/		



		//echo "<br/><br/>=>test555555";exit;






echo "<br/><br/><hr/><br/>{$pq}<==queryString==> ".$queryString;
			echo "<br/><br/><hr/>";
			
//if($pq==2) exit;


function qry_update_master($queryString='',$limit='')
{
	
	global $data; $pq=0;
	
	if(isset($_GET['pq'])&&$_GET['pq']) $pq=@$_GET['pq'];
	if(isset($_GET['qp'])&&$_GET['qp']) $pq=@$_GET['qp'];
	
	$backup_transIDs=[];
	if(!isset($_SESSION['backup_transIDs']))
		$_SESSION['backup_transIDs']=[];
	
	$notMatch_transIDs=[];
	if(!isset($_SESSION['notMatch_transIDs']))
		$_SESSION['notMatch_transIDs']=[];
	
	try {
		
		
		{
			
			
			if($pq==3) 
			exit;
		
			$data['MASTER_TRANS_TABLE']='master_trans_table_3';
			
			
			
			$show_last_maid=0;
			
			//if($find_count>0)
			{
				//`trans_status` NOT IN (9) 
				$slct=db_rows(
					"SELECT  * ".
					" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` ORDER BY `id` ASC ",1
				);

				//if($pq)	
				echo "<hr/>count=>".count($slct)."<br/><br/>";

					$j=0;
					
					foreach($slct as $key=>$value){
						$j++;
						
						if($pq)	
						echo $j.". transID=>".$value['transID'].", merID=>".$value['merID'].",  acquirer=>".$value['acquirer'].", id=>".$value['id'].", tdate=>".$value['tdate'].", trans_amt=>".$value['trans_amt'].", bill_amt=>".$value['bill_amt'].", trans_status=>".$value['trans_status']."<br/><hr/><br/>";
							
						
						
						$show_last_maid=$value['id'];
						$show_last_transID=$value['transID'];
						
						
						{
							
							
							//start - make sure the query for master 
							
							//$msid='NULL';
							$msid=$value['id'];
							
							
							if($value['payable_amt_of_txn1']=='') $payable_amt_of_txn1 = 'null';
								
							else $payable_amt_of_txn1 = "'".(double)$value['payable_amt_of_txn1']."'";	
									
							$qry_update_master="UPDATE  `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` ".
							" SET `payable_amt_of_txn` ={$payable_amt_of_txn1} WHERE `id`='{$value['id']}' ";
								
							//if($pq) 
							echo "<br/><hr/><br/>qry_update_master=><br/>".$qry_update_master."<br/>";
							
							
							$insert_id_master_db=db_query($qry_update_master,$pq);
							
							//exit;
							
							
						} //end - make sure the query for master 
						
						
						
						
					}
					
					
				
			}
			
						
			echo "<br/><hr/><br/>Show Last Table ID of Master Table => ".@$show_last_maid."<br/><br/>";
			echo "<br/><hr/><br/>Show Last transID of Master Table => ".@$show_last_transID."<br/><br/>";
			
			if($pq)
			{	
				/*
				echo "<br/><hr/><br/>transID=> ".count(@$backup_transIDs)."<br/>".implode(",",$backup_transIDs)."<br/><br/>";
				

				echo "<br/><br/><hr/><br/><==Backup TransIDs==> ".count(@$_SESSION['backup_transIDs'])."<br/>".implode(",",@$_SESSION['backup_transIDs']);
				echo "<br/><br/><hr/>";

				echo "<br/><hr/><br/>Not Match transID=> ".count(@$notMatch_transIDs)."<br/>".implode(",",$notMatch_transIDs)."<br/><br/>";

				echo "<br/><br/><hr/><br/><==Not Match TransIDs==> ".count(@$_SESSION['notMatch_transIDs'])."<br/>".implode(",",@$_SESSION['notMatch_transIDs']);
				*/
				echo "<br/><br/><hr/>";
			}
		}
	}
	catch(Exception $e) {
		echo '<=create_trans_for_backup=> ' .$e->getMessage();
	}
}



qry_update_master($queryString,$limit);

db_disconnect();

exit;


?>