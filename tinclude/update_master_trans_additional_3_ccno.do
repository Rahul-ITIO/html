<?
//Dev Tech : 24-01-25 Transaction insert from master table in additional 

/* 

http://localhost/gw/tinclude/update_master_trans_additional_3_ccno.do


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
		
			$data['MASTER_TRANS_TABLE']='master_trans_additional_3';
			
			
			
			$show_last_maid=0;
			
			//SELECT "t".* ,"ad".* FROM "zt_master_trans_table_3" AS "t" LEFT JOIN "zt_master_trans_additional_3" AS "ad" ON "t"."id" = "ad"."id_ad" WHERE ( "tdate" BETWEEN '2023-11-01 00:00:00' AND '2024-01-16 23:59:59' ) ORDER BY "t"."tdate" DESC LIMIT 51 OFFSET 0

			//if($find_count>0)
			{
				//`trans_status` NOT IN (9) 
				//( (JSON_UNQUOTE(JSON_EXTRACT(`json_value`, '$.ccno')) !='' ) ) 
				//( `json_value` LIKE '%ccno%' )
				//18628
				$slct=db_rows(
					"SELECT  * ".
					" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` WHERE (`json_value` != '[]' AND `json_value` != '{}' AND `json_value` IS NOT NULL ) AND ( `id_ad` < '116' ) ORDER BY `id_ad` DESC LIMIT 5 ",1
				);
				
				exit;
				//if($pq)	
				echo "<hr/>count=>".count($slct)."<br/><br/>";

					$j=0;
					
					foreach($slct as $key=>$value){
						$j++;
						
						//if($pq)	
						echo "<br/><br/><hr/>".$j.". transID_ad=>".$value['transID_ad']." id_ad=>".$value['id_ad']."";
					
						//echo $j.". json_value=>".$value['json_value']."<br/><hr/><br/>";
							
						$json_value=$value['json_value'];
						$ccno_1=jsonvaluef($json_value,"ccno");
						
						$show_last_maid=$value['id_ad'];
						$show_last_transID=$value['transID_ad'];
						
						if(!empty($ccno_1))
						{
							
							
							//start - make sure the query for master 
							
							//$msid='NULL';
							$msid=$value['id_ad'];
							
							
							if($value['ccno']=='') $ccno = 'null';
								
							else $ccno = "'".$ccno_1."'";	
									
							$qry_update_master="UPDATE  `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` ".
							" SET `ccno` ={$ccno} WHERE `id_ad`='{$value['id_ad']}' ";
								
							//if($pq) 
							echo "<br/><br/>qry_update_master=><br/>".$qry_update_master."<br/>";
							
							
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