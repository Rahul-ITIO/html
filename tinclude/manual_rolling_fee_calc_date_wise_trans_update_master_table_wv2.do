<?
//Dev Tech : 24-09-16  Master Transaction update for remaining balance , mature & immature rolling from json value table of additional 

/* 

http://localhost:8080/gw/tinclude/manual_rolling_fee_calc_date_wise_trans_update_master_table_wv2


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


//$queryString .= "  AND  ( `tdate` BETWEEN (DATE_FORMAT('{$date_1st} 00:00:00', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$date_2nd} 23:59:59', '%Y%m%d%H%i%s')) )   ";


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
				// "SELECT `t`.*  FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` AS `t` {$join_additional}   WHERE
                
                /* from localhost 
                $slct=db_rows(
					"SELECT `t`.*  FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` AS `t`   WHERE   ( `trans_status` IN (1) ) AND ( `t`.`tdate` BETWEEN '2022-02-25 00:00:00' AND '2025-03-31 24:00:00' ) ORDER BY `t`.`tdate` DESC  ",1
				);
                */

				$slct=db_rows(
					"SELECT `t`.*  FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` AS `t`   WHERE  ( `t`.`merID` IN (11587)) AND ( `trans_status` IN (1) ) AND ( `t`.`tdate` BETWEEN '2025-02-25 00:00:00' AND '2025-03-31 24:00:00' ) ORDER BY `t`.`tdate` DESC  ",1
				);
                
                
               
                
				//if($pq)	
				echo "<hr/>count=>".count($slct)."<br/><br/>";

                $j=0;
                
                foreach($slct as $key=>$value)
                {
                    $j++;

                    if($value['trans_amt']>0)
                    {
                            $rolling_amt=number_formatf_2((number_formatf_2($value['trans_amt'])*15)/100);
                            $buy_mdr_amt=number_formatf_2($value['buy_mdr_amt']);
                            $buy_txnfee_amt=number_formatf_2($value['buy_txnfee_amt']);
                            //$buy_mdr_amt=number_formatf_2((number_formatf_2($value['trans_amt'])*7.5)/100);
                            //$buy_txnfee_amt=0.40;
                
                            $payable_amt_of_txn=number_formatf_2(($value['trans_amt'])-($buy_mdr_amt+$buy_txnfee_amt+$rolling_amt));
                        
                        //if($pq)	
                        echo $j.". [id]=>".@$value['id'].", transID=>".@$value['transID'].",  acquirer=>".@$value['acquirer'].",  tdate=>".@$value['tdate'].", merID=>".@$value['merID'].", trans_amt=>".@$value['trans_amt'].", rolling_amt_@15%=>".@$rolling_amt.", buy_mdr_amt=>".@$buy_mdr_amt.", buy_txnfee_amt=>".@$buy_txnfee_amt.", PAYABLE_AMT_OF_TXN=>".@$payable_amt_of_txn.", previous_payable_amt_of_txn=>".@$value['payable_amt_of_txn']."<br/>";
                            
                        
                        
                        $show_last_maid=$value['id'];
                        $show_last_transID=$value['transID'];
                        
                        
                        {
                            
                            
                            //start - make sure the query for master 
                            
                          

                            $qry_update_master="UPDATE  `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` ".
                            " SET `rolling_amt` ='{$rolling_amt}', `payable_amt_of_txn` ='{$payable_amt_of_txn}'   WHERE `id`='{$value['id']}' ";

                            //if($pq) 
                            echo "<br/>qry_update_master=><br/>".$qry_update_master;
                            
                            
                           // $update_master_db=db_query($qry_update_master,1);
                            
                            echo "<br/><br/><hr/><br/>";

                            //exit;
                            
                            
                        } //end - make sure the query for master 
                        
                        
                        
                        
                    }
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