<?
//Dev Tech : 24-09-16  Master Transaction update for remaining balance , mature & immature rolling from json value table of additional 

/* 

http://localhost:8080/gw/tinclude/remaining_balance_transaction_update_master_table_wv2.do



ALTER TABLE zt_master_trans_table_3
    ADD COLUMN remaining_balance_amt double precision;

ALTER TABLE zt_master_trans_table_3
    ADD COLUMN mature_rolling_fund_amt double precision;

ALTER TABLE zt_master_trans_table_3
    ADD COLUMN immature_rolling_fund_amt double precision;




###################################

stptrading [11331], faciticltd [11532], invest [11479], ubuntu [11504], novotrades [11482], pearsoup [11521], venex [11471], gennarotv [11437], sweetwalk [11362], techma [11326], gennaro [11321], novatec [11359], excite [11318],admin [11311], grandcap [11319]





UPDATE public.zt_master_trans_table_3 SET remaining_balance_amt=834.98, mature_rolling_fund_amt=2024.50, immature_rolling_fund_amt=0.0 WHERE "transID" IN (2395713); grandcap [11319]




UPDATE public.zt_master_trans_table_3 SET remaining_balance_amt=-6708.66, mature_rolling_fund_amt=137.64, immature_rolling_fund_amt=109.32 WHERE "transID" IN (21592129); admin [11311],



UPDATE public.zt_master_trans_table_3 SET remaining_balance_amt=-7598.17, mature_rolling_fund_amt=2409.38, immature_rolling_fund_amt=0.00 WHERE "transID" IN (21638808); excite [11318]

UPDATE public.zt_master_trans_table_3 SET remaining_balance_amt=2103.95, mature_rolling_fund_amt=1147.50, immature_rolling_fund_amt=2.00 WHERE "transID" IN (22814354); novatec [11359]

UPDATE public.zt_master_trans_table_3 SET remaining_balance_amt=-2.34, mature_rolling_fund_amt=2503.16, immature_rolling_fund_amt=636.45 WHERE "transID" IN (22916148); gennaro [11321]


UPDATE public.zt_master_trans_table_3 SET remaining_balance_amt=-786.49, mature_rolling_fund_amt=5180.89, immature_rolling_fund_amt=1565.64 WHERE "transID" IN (23196011); techma [11326]


UPDATE public.zt_master_trans_table_3 SET remaining_balance_amt=-26.53, mature_rolling_fund_amt=1422.43, immature_rolling_fund_amt=302.11 WHERE "transID" IN (23294035); sweetwalk [11362]


UPDATE public.zt_master_trans_table_3 SET remaining_balance_amt=-71.37, immature_rolling_fund_amt=1349.68 WHERE "transID" IN (24340806); gennarotv [11437]
 
UPDATE public.zt_master_trans_table_3 SET remaining_balance_amt=-642.55 WHERE "transID" IN (214887125); venex [11471]
UPDATE public.zt_master_trans_table_3 SET immature_rolling_fund_amt=1635.88 WHERE "transID" IN (214887125); venex [11471]


UPDATE public.zt_master_trans_table_3 SET remaining_balance_amt=-47.97 WHERE "transID" IN (215381319); pearsoup [11521]
UPDATE public.zt_master_trans_table_3 SET immature_rolling_fund_amt=2233.86 WHERE "transID" IN (215381319); pearsoup [11521]

UPDATE public.zt_master_trans_table_3 SET immature_rolling_fund_amt=835.70 WHERE "transID" IN (215530916);
UPDATE public.zt_master_trans_table_3 SET immature_rolling_fund_amt=934.05 WHERE "transID" IN (215920538);
UPDATE public.zt_master_trans_table_3 SET immature_rolling_fund_amt=122.90 WHERE "transID" IN (216100801);

UPDATE public.zt_master_trans_table_3
	SET remaining_balance_amt=?, mature_rolling_fund_amt=?, immature_rolling_fund_amt=?
	WHERE "transID" IN (216100801);


SELECT remaining_balance_amt,mature_rolling_fund_amt,immature_rolling_fund_amt, * FROM "zt_master_trans_table_3" WHERE  ( "acquirer" IN (2,3) );
  


SELECT SUM(CAST(mature_rolling_fund_amt AS double precision)) AS mature_rolling_fund_amt FROM "zt_master_trans_table_3" WHERE  ("trans_status" NOT IN (0,9,10,2,22,23,24) )  AND ( "acquirer" IN (2,3) );









###################################################################################################################




##### PAYOUT FOR sum of all payout & mature payout query & immature payout query as per merchant wise 

payable_amt_of_txn, settelement_date, merID, trans_status

<<all withdraw fund

SELECT SUM(CAST(payable_amt_of_txn AS double precision)) AS all_payout_fund FROM "zt_master_trans_table_3" WHERE ( "merID" IN (11479)) AND   ("trans_status" IN (1,13) ) AND ( "acquirer" IN (2) );


<<all payout

SELECT SUM(CAST(payable_amt_of_txn AS double precision)) AS all_payout_fund FROM "zt_master_trans_table_3" WHERE ( "merID" IN (11479)) AND   ("trans_status" NOT IN (0,9,10,2,22,23,24) ) AND ( "acquirer" NOT IN (2,3) );

<<mature payout 

SELECT SUM(CAST(payable_amt_of_txn AS double precision)) AS payout_mature_fund FROM "zt_master_trans_table_3" WHERE ( "merID" IN (11479)) AND   ("trans_status" NOT IN (0,9,10,2,22,23,24) ) AND ( "settelement_date" <= NOW() ) AND ( "acquirer" NOT IN (2,3) );

<<immature payout

SELECT SUM(CAST(payable_amt_of_txn AS double precision)) AS payout_immature_fund FROM "zt_master_trans_table_3" WHERE ( "merID" IN (11479)) AND   ("trans_status" NOT IN (0,9,10,2,22,23,24) ) AND ( "settelement_date" > NOW() ) AND ( "acquirer" NOT IN (2,3) );




##### ROLLING FOR sum of all rolling & mature rolling query & immature rolling query as per merchant wise 

rolling_amt, rolling_date, rolling_delay


<<all withdraw rolling

SELECT SUM(CAST(payable_amt_of_txn AS double precision)) AS all_payout_fund FROM "zt_master_trans_table_3" WHERE ( "merID" IN (11479)) AND   ("trans_status" IN (1,13) ) AND ( "acquirer" IN (3) );


<<all rolling

SELECT SUM(CAST(rolling_amt AS double precision)) AS all_rolling_fund FROM "zt_master_trans_table_3" WHERE ( "merID" IN (11479)) AND  ("trans_status" NOT IN (0,9,10,2,22,23,24) )  AND ( "acquirer" NOT IN (2,3) );


<<mature rolling

SELECT SUM(CAST(rolling_amt AS double precision)) AS mature_rolling_fund FROM "zt_master_trans_table_3" WHERE ( "merID" IN (11479)) AND ("trans_status" NOT IN (0,9,10,2,22,23,24) ) AND ( "rolling_date" <= NOW() ) AND ( "acquirer" NOT IN (2,3) );

<<immature rolling

SELECT SUM(CAST(rolling_amt AS double precision)) AS immature_rolling_fund FROM "zt_master_trans_table_3" WHERE ( "merID" IN (11479)) AND ("trans_status" NOT IN (0,9,10,2,22,23,24) ) AND ( "rolling_date" > NOW() ) AND ( "acquirer" NOT IN (2,3) );




###################################################################################################################


*/

exit;

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
		
			//$data['MASTER_TRANS_TABLE']='master_trans_table_3';
			
			//Select Data from master_trans_additional
            $join_additional=join_additional('t');
            if(!empty($join_additional)) $mts="`ad`";
            else $mts="`t`";
            
			
			$show_last_maid=0;
			
			//if($find_count>0)
			{
				//`trans_status` NOT IN (9) 
				$slct=db_rows(
					"SELECT (`t`.`id`) AS `id`, (`t`.`transID`) AS `transID`, (`t`.`tdate`) AS `tdate`, (`t`.`acquirer`) AS `acquirer`, ($mts.`json_value`) AS `json_value`, ($mts.`source_url`) AS `source_url` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` AS `t` {$join_additional}   WHERE ( `acquirer` IN (2,3) )  ORDER BY `id` ASC ",1
				);

				//if($pq)	
				echo "<hr/>count=>".count($slct)."<br/><br/>";

					$j=0;
					
					foreach($slct as $key=>$value){
						$j++;


                        $json_value_de=jsondecode(@$value['json_value'],1);


                        //remaining_balance_amt,mature_rolling_fund_amt,immature_rolling_fund_amt

                        if(isset($json_value_de['remaining_balance '])&&!empty($json_value_de['remaining_balance ']))
                            $remaining_balance_amt=@$json_value_de['remaining_balance '];
                        elseif(isset($json_value_de['remaining_balance'])&&!empty($json_value_de['remaining_balance']))
                            $remaining_balance_amt=@$json_value_de['remaining_balance'];
                        else{
                            $remaining_balance_amt='0.00';
                        }


                            $mature_rolling_fund_amt=@$json_value_de['mature_rolling_fund'];
                            $immature_rolling_fund_amt=@$json_value_de['immature_rolling_fund'];


						
						//if($pq)	
						echo $j.". transID=>".@$value['transID'].",  acquirer=>".@$value['acquirer'].", id=>".@$value['id'].", tdate=>".@$value['tdate'].", REMAINING_BALANCE_AMT=>".@$remaining_balance_amt.", mature_rolling_fund_amt=>".@$mature_rolling_fund_amt.", immature_rolling_fund_amt=>".@$immature_rolling_fund_amt.", source_url=>".@$value['source_url']."<br/>";
							
						
						
						$show_last_maid=$value['id'];
						$show_last_transID=$value['transID'];
						
						
						{
							
							
							//start - make sure the query for master 
							
                            //v2
                            /*
							if(strpos($value['source_url'],"system_v2")!==false)
                            {

							    $qry_update_master="UPDATE  `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` ".
							" SET `remaining_balance_amt` ='{$remaining_balance_amt}', `mature_rolling_fund_amt` ='{$mature_rolling_fund_amt}', `immature_rolling_fund_amt` ='{$immature_rolling_fund_amt}'   WHERE `id`='{$value['id']}' ";

                            }
                            else{
                                $qry_update_master="UPDATE  `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` ".
							" SET `remaining_balance_amt` ='{$remaining_balance_amt}'  WHERE `id`='{$value['id']}' ";
                            }
							*/	

                            $qry_update_master="UPDATE  `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` ".
							" SET `remaining_balance_amt` ='{$remaining_balance_amt}', `mature_rolling_fund_amt` ='{$mature_rolling_fund_amt}', `immature_rolling_fund_amt` ='{$immature_rolling_fund_amt}'   WHERE `id`='{$value['id']}' ";

							//if($pq) 
							echo "<br/>qry_update_master=><br/>".$qry_update_master;
							
							
							$update_master_db=db_query($qry_update_master,1);
							
                            echo "<br/><br/><hr/><br/>";

							//exit;
							
							
						} //end - make sure the query for master 
						
						
						
						
					}
					
					
				
			}
			
						
			echo "<br/><hr/><br/>Show Last Table ID of Master Table => ".@$show_last_maid."<br/><br/>";
			echo "<br/><hr/><br/>Show Last transID of Master Table => ".@$show_last_transID."<br/><br/>";
			
			if($pq)
			{	
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