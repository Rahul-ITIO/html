<?
//Dev Tech : 23-12-02 Transaction insert from master table in additional 

/*
&noli=1 // Skip the Limit 

http://localhost/gw/transaction_insert_from_master_table_in_additional.do?pq=1&li=2&day=365&day2=30&maid=427

	http://localhost/gw/transaction_insert_from_master_table_in_additional?pq1=1&day=365&day2=0

http://localhost/gw/transaction_insert_from_master_table_in_additional.do.do?st=1&notify=1&acquirer=104&li=2

http://localhost/gw/transaction_insert_from_master_table_in_additional.do.do?st=1&acquirer=104&li=2&day=4&day2=2

http://localhost/gw/transaction_insert_from_master_table_in_additional.do.do?st=1&acquirer=104&notAcquirer=42&li=2&day=4&day2=2
http://localhost/gw/transaction_insert_from_master_table_in_additional.do.do?st=1&acquirer=104&mid=27&li=2


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


function create_trans_for_additional($queryString='',$limit='')
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
			
			
			if($pq==3) 
			exit;
		
			//if(!isset($data['MASTER_TRANS_TABLE_EXPORT_FROM'])) 
			$data['MASTER_TRANS_TABLE_EXPORT_FROM']='master_trans_table';
			
			$data['ASSIGN_MASTER_TRANS_ADDITIONAL']='master_trans_additional_3';
			$data['MASTER_TRANS_TABLE']='master_trans_table_3';
			
			$maid=0;
			if(isset($_GET['maid'])&&$_GET['maid']) {
				$maid=(int)$_GET['maid'];
				$queryString='';
			}
			else $maid=0;
			
			//&noli=1&maid=427
			
			$show_last_maid=0;
			
			//if($find_count>0)
			{
				//`trans_status` NOT IN (9) 
				$slct=db_rows(
					"SELECT  * ".
					" FROM `{$data['Database']}`.`{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE_EXPORT_FROM']}`".
					" WHERE ".
						" `id` > {$maid} ".$queryString.
						" ORDER BY `id` ASC ".$limit.
						//" ORDER BY `id` DESC ". // cmn
						//" LIMIT 5". // cmn
					" ",1
				);

				//if($pq)	
				echo "<hr/>count=>".count($slct)."<br/><br/>";

					$j=0;
					
					foreach($slct as $key=>$value){
						$j++;
						
						if($pq)	
						echo $j.". transID=>".$value['transID'].", merID=>".$value['merID'].",  acquirer=>".$value['acquirer'].", id=>".$value['id'].", tdate=>".$value['tdate'].", trans_amt=>".$value['trans_amt'].", bill_amt=>".$value['bill_amt'].", trans_status=>".$value['trans_status']."<br/><hr/><br/>";
							
						
						$array_keys = array_keys($value);
						
						$show_last_maid=$value['id'];
						$show_last_transID=$value['transID'];
						
						{
							
							
							//start - make sure the query for master 
							
							//$msid='NULL';
							$msid=$value['id'];
							
							
							$insert_para_master = "`id`, `transID`, `reference`, `bearer_token`, `tdate`, `bill_amt`, `bill_currency`, `trans_amt`, `trans_currency`, `acquirer`, `trans_status`, `merID`, `transaction_flag`, `fullname`, `bill_email`, `bill_ip`, `terNO`, `mop`, `channel_type`, `buy_mdr_amt`, `sell_mdr_amt`, `buy_txnfee_amt`, `sell_txnfee_amt`, `gst_amt`, `rolling_amt`, `mdr_cb_amt`, `mdr_cbk1_amt`, `mdr_refundfee_amt`, `available_rolling`, `available_balance`, `payable_amt_of_txn`, `fee_update_timestamp`, `remark_status`, `trans_type`, `settelement_date`, `settelement_delay`, `rolling_date`, `rolling_delay`, `risk_ratio`, `transaction_period`, `bank_processing_amount`, `bank_processing_curr`, `created_date`, `related_transID`";
							$insert_valu_master = "{$msid},'{$value['transID']}', '{$value['reference']}', '{$value['bearer_token']}', '{$value['tdate']}', '{$value['bill_amt']}', '{$value['bill_currency']}', '{$value['trans_amt']}', '{$value['trans_currency']}', '{$value['acquirer']}', '{$value['trans_status']}', '{$value['merID']}', '{$value['transaction_flag']}', '{$value['fullname']}', '{$value['bill_email']}', '{$value['bill_ip']}', '{$value['terNO']}', '{$value['mop']}', '{$value['channel_type']}', '{$value['buy_mdr_amt']}', '{$value['sell_mdr_amt']}', '{$value['buy_txnfee_amt']}', '{$value['sell_txnfee_amt']}', '{$value['gst_amt']}', '{$value['rolling_amt']}', '{$value['mdr_cb_amt']}', '{$value['mdr_cbk1_amt']}', '{$value['mdr_refundfee_amt']}', '{$value['available_rolling']}', '{$value['available_balance']}', '{$value['payable_amt_of_txn']}', '{$value['fee_update_timestamp']}', '{$value['remark_status']}', '{$value['trans_type']}', '{$value['settelement_date']}', '{$value['settelement_delay']}', '{$value['rolling_date']}', '{$value['rolling_delay']}', '{$value['risk_ratio']}', '{$value['transaction_period']}', '{$value['bank_processing_amount']}', '{$value['bank_processing_curr']}', '{$value['created_date']}', '{$value['related_transID']}'";
							
							/*
							if($pq) echo "<br/><hr/><br/>insert_para_master=><br/>".$insert_para_master;
							if($pq) echo "<br/><hr/><br/>insert_valu_master=><br/>".$insert_valu_master;
							exit;
							*/
							
									
							$qry_insert_master="INSERT INTO `{$data['Database']}`.`{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
							"(".$insert_para_master.")VALUES".
							"(".$insert_valu_master." )";
								
							//if($pq) 
							//	echo "<br/><hr/><br/>qry_insert_master=><br/>".$qry_insert_master."<br/>";
							
								
							$insert_id_master_db=db_query($qry_insert_master,$pq);
							$insert_id_master=newid();
							
							
							
						} //end - make sure the query for master 
						
						
						
						//start - make sure the query for additional 
						
						if($insert_id_master>0)
						{
							
							$insert_para_additional = "`id_ad`, `transID_ad`, `authurl`, `authdata`, `source_url`, `webhook_url`, `return_url`, `upa`, `rrn`, `acquirer_ref`, `acquirer_response`, `descriptor`, `mer_note`, `support_note`, `system_note`, `json_value`, `acquirer_json`, `json_log_history`, `payload_stage1`, `acquirer_creds_processing_final`, `acquirer_response_stage1`, `acquirer_response_stage2`, `bin_no`, `ccno`, `ex_month`, `ex_year`, `trans_response`, `bill_phone`, `bill_address`, `bill_city`, `bill_state`, `bill_country`, `bill_zip`, `product_name`";
							
							$insert_valu_additional = "'{$insert_id_master}','{$value['transID']}', '{$value['authurl']}', '{$value['authdata']}', '{$value['source_url']}', '{$value['webhook_url']}', '{$value['return_url']}', '{$value['upa']}', '{$value['rrn']}', '{$value['acquirer_ref']}', '{$value['acquirer_response']}', '{$value['descriptor']}', '{$value['mer_note']}', '{$value['support_note']}', '{$value['system_note']}', '{$value['json_value']}', '{$value['acquirer_json']}', '{$value['json_log_history']}', '{$value['payload_stage1']}', '{$value['acquirer_creds_processing_final']}', '{$value['acquirer_response_stage1']}', '{$value['acquirer_response_stage2']}', '{$value['bin_no']}', '{$value['ccno']}', '{$value['ex_month']}', '{$value['ex_year']}', '{$value['trans_response']}', '{$value['bill_phone']}', '{$value['bill_address']}', '{$value['bill_city']}', '{$value['bill_state']}', '{$value['bill_country']}', '{$value['bill_zip']}', '{$value['product_name']}'";
							
							/*
							if($pq) echo "<br/><hr/><br/>insert_para_additional=><br/>".$insert_para_additional;
							if($pq) echo "<br/><hr/><br/>insert_valu_additional=><br/>".$insert_valu_additional;
							exit;
							*/
							
									
							$qry_insert_additional="INSERT INTO `{$data['Database']}`.`{$data['DbPrefix']}{$data['ASSIGN_MASTER_TRANS_ADDITIONAL']}`".
							"(".$insert_para_additional.")VALUES".
							"(".$insert_valu_additional." )";
								
							//if($pq) 
							//echo "<br/><hr/><br/>qry_insert_additional=><br/>".$qry_insert_additional."<br/>";
							
								
							$insert_id_additional=db_query($qry_insert_additional,$pq);
							
							
						}
						//end - make sure the query for additional 
						
						
						
					}
					
					
				
			}
			
						
			echo "<br/><hr/><br/>Show Last Table ID of Master Table => ".$show_last_maid."<br/><br/>";
			echo "<br/><hr/><br/>Show Last transID of Master Table => ".$show_last_transID."<br/><br/>";
			
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



create_trans_for_additional($queryString,$limit);

db_disconnect();

exit;


?>