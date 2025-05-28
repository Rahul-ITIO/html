<?
//Dev Tech : 23-09-21 Trans is pending than expired without modify the tdate and notify is required than use suqery &notify=1

/*


http://localhost/gw/crons_above_7days_revert.do?pq=1&li=2&day=365&day2=30

http://localhost/gw/crons_above_7days_revert.do?st=1&notify=1&acquirer=104&li=2

http://localhost/gw/crons_above_7days_revert.do?st=1&acquirer=104&li=2&day=4&day2=2

http://localhost/gw/crons_above_7days_revert.do?st=1&acquirer=104&notAcquirer=42&li=2&day=4&day2=2
http://localhost/gw/crons_above_7days_revert.do?st=1&acquirer=104&mid=27&li=2


*/

$data['NO_SALT']=1;
$data['SponsorDomain']=1;
include('config.do');

if(!isset($_SESSION['adm_login']))
{
	echo('ACCESS DENIED.');
	exit;
}

$pq=0;
	
if(isset($_GET['pq'])&&$_GET['pq']) $pq=@$_GET['pq'];
if(isset($_GET['qp'])&&$_GET['qp']) $pq=@$_GET['qp'];

$acquirer=0;
$limit=' LIMIT 5 ';
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


function create_trans_for_backup_revert($queryString='',$limit='')
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
		
		if(isset($data['Database_3'])&&$data['Database_3']&&function_exists('db_connect_3'))
		{
			
			// Fetch value like 30  for days of back from current date 
			if(isset($data['TRANS_BACKUP_DAYS'])&&!empty($data['TRANS_BACKUP_DAYS']))
				$day=@$data['TRANS_BACKUP_DAYS'];
			
			else $day='30'; // Set default 30 day back from current date 
			
			$day_1st = (int)$day+30; // duration of 30 days from assing backup days 
			//$day_1st = $day;
			$date_1st = date('Y-m-d',strtotime("-{$day_1st} days"));
			$date_2nd = date('Y-m-d',strtotime("-{$day} days"));
			
			

			if(empty($queryString))
				$queryString = "  AND  ( `tdate` BETWEEN (DATE_FORMAT('{$date_1st} 00:00:00', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$date_2nd} 23:59:59', '%Y%m%d%H%i%s')) )   ";
			
			$find_counts=db_rows_3(
				"SELECT  COUNT(`id`) AS `count`,  GROUP_CONCAT(`id`) AS `id`,  GROUP_CONCAT(`transID`) AS `transID` ".
				" FROM `{$data['Database_3']}`.`{$data['DbPrefix']}master_trans_table`".
				" WHERE ".
					"`trans_status` IN (1,2,9,10,22,23,24) AND `acquirer` NOT IN (0,1,2,3,4,5) ".$queryString.
					"  LIMIT 1 ",$pq
			);
			
			$find_count=@$find_counts[0]['count'];
			$find_id=@$find_counts[0]['id'];
			$find_transID=@$find_counts[0]['transID'];
			
			if($pq) {
				
				echo "<br/><br/><hr/><br/><b>FIND COUNTS</b>=>".$find_count."<br/>";
				echo "<br/><b>FIND ID</b>=><br/>".$find_id."<br/>";
				echo "<br/><b>FIND transID</b>=><br/>".$find_transID."<br/><br/><hr/><br/>";
			}
			
			if($pq==3) 
			exit;

			if($find_count>0){
				
				$slct=db_rows_3(
					"SELECT  * ".
					" FROM `{$data['Database_3']}`.`{$data['DbPrefix']}master_trans_table`".
					" WHERE ".
						"`trans_status` IN (1,2,9,10,22,23,24) AND `acquirer` NOT IN (0,1,2,3,4,5)   ".$queryString.
						" ORDER BY `id` ASC ".$limit.
						//" ORDER BY `id` DESC ". // cmn
						//" LIMIT 5". // cmn
					" ",$pq
				);

				if($pq)	echo "<hr/>count=>".count($slct)."<br/><br/>";

					$j=0;
					
					foreach($slct as $key=>$value){
						$j++;
						
						if($pq)	
						echo $j.". transID=>".$value['transID'].", merID=>".$value['merID'].",  acquirer=>".$value['acquirer'].", id=>".$value['id'].", tdate=>".$value['tdate'].", trans_amt=>".$value['trans_amt'].", bill_amt=>".$value['bill_amt'].", trans_status=>".$value['trans_status']."<br/><hr/><br/>";
							
						
						$array_keys = array_keys($value);
						$insert_para = "`".implode("`, `",$array_keys)."`";
						$insert_valu = "'".implode("','",$value)."'";
						
						/*
						if($pq) echo "<br/><hr/><br/>insert_para=><br/>".$insert_para;
						if($pq) echo "<br/><hr/><br/>insert_valu=><br/>".$insert_valu;
						exit;
						*/
						
								
						$qry_insert="INSERT INTO `{$data['Database']}`.`{$data['DbPrefix']}master_trans_table`".
						"(".$insert_para.")VALUES".
						"(".$insert_valu." )";
							
						//if($pq) echo "<br/><hr/><br/>qry_insert=><br/>".$qry_insert."<br/>";
						
							
						$insert_id=db_query($qry_insert,$pq);
						
						//end - make sure the query for backup 
						
						
						
						//start - make sure the delete query after backup 
						
						if(@$insert_id==@$value['id'])
						{
							db_query_3(
								 "DELETE FROM `{$data['Database_3']}`.`{$data['DbPrefix']}master_trans_table`".
								 " WHERE `id`='".$value['id']."'"
							);
							
							$backup_transIDs[]=$value['transID'];
							$_SESSION['backup_transIDs'][]=$value['transID'];
						} //end - make sure the delete query after backup 
						else
						{
							$notMatch_transIDs[]=$value['transID'];
							$_SESSION['notMatch_transIDs'][]=$value['transID'];
						}
						
					}
					
					
					
					// after backup data as per 7 days or previous day 
					
					
					
					//  json log update 
					$action_name='revert_backup_master_trans_table';
					$tableName='json_log';
					$json_log_arr=[];
					$json_log_arr['queryString']=$queryString;
					$json_log_arr['date_1st']=$date_1st;
					$json_log_arr['date_2nd']=$date_2nd;
					$json_log_arr['created_date']=(new DateTime())->format('Y-m-d H:i:s.u');
					$json_log_arr['transIDs_count']=count(@$backup_transIDs);
					$json_log_arr['transIDs']=implode(",",$backup_transIDs);
					$json_log_arr['not_match_transIDs_count']=count(@$notMatch_transIDs);
					$json_log_arr['not_match_transIDs']=implode(",",$notMatch_transIDs);
					
					if(!isset($transID)||empty($transID)) 
					{
						$tr_newtableid='';$merID='';$terNO='';$transID='';$reference='';$bill_amt='';$bill_email='';
					}
				
					//if(!is_array($json_log_arr)&&isset($_POST)) $json_log_arr=$_POST;
					
					//echo "<br/><hr/><br/>json_log_upd=> $tr_newtableid,$tableName,$action_name,$json_log_arr,$merID,$terNO,transID=>$transID,$reference,$bill_amt,$bill_email"; //exit;
				
					json_log_upd($tr_newtableid,$tableName,$action_name,$json_log_arr,$merID,$terNO,$transID,$reference,$bill_amt,$bill_email);
				
			}
			
			if($pq)
			{
				echo "<br/><hr/><br/>transID=> ".count(@$backup_transIDs)."<br/>".implode(",",$backup_transIDs)."<br/><br/>";

				echo "<br/><br/><hr/><br/><==Backup TransIDs==> ".count(@$_SESSION['backup_transIDs'])."<br/>".implode(",",@$_SESSION['backup_transIDs']);
				echo "<br/><br/><hr/>";

				echo "<br/><hr/><br/>Not Match transID=> ".count(@$notMatch_transIDs)."<br/>".implode(",",$notMatch_transIDs)."<br/><br/>";

				echo "<br/><br/><hr/><br/><==Not Match TransIDs==> ".count(@$_SESSION['notMatch_transIDs'])."<br/>".implode(",",@$_SESSION['notMatch_transIDs']);
				echo "<br/><br/><hr/>";
			}
		}
	}
	catch(Exception $e) {
		echo '<=create_trans_for_backup=> ' .$e->getMessage();
	}
}



create_trans_for_backup_revert($queryString,$limit);

db_disconnect();

exit;


?>