#!/var/www/html
<?php
//Dev Tech : 23-09-21 Trans is pending than expired without modify the tdate and notify is required than use suqery &notify=1

/*



http://localhost/gw/crons_expired.do?st=1&acquirer=104&li=2

http://localhost/gw/crons_expired?pq=1&acquirer=12&li=2

http://localhost/gw/crons_expired.do?st=1&notify=1&acquirer=104&li=2

http://localhost/gw/crons_expired.do?st=1&acquirer=104&li=2&day=4&day2=2

http://localhost/gw/crons_expired.do?st=1&acquirer=104&notAcquirer=42&li=2&day=4&day2=2
http://localhost/gw/crons_expired.do?st=1&acquirer=104&mid=27&li=2


For All Expired

http://localhost/gw/crons_expired.do?st=1&up1=30&li=2


*\/5 * * * * php /var/www/html/crons_expired.do
*\/5 * * * * /usr/bin/php /var/www/html/crons_expired.do > /dev/null 2>&1

*/

$data['NO_SALT']=1;
$data['SponsorDomain']=1;

$pq=1;
	
if(isset($_GET['pq'])&&$_GET['pq']) $pq=@$_GET['pq'];
if(isset($_GET['qp'])&&$_GET['qp']) $pq=@$_GET['qp'];

$php_self1=$_SERVER['PHP_SELF'];

if ((strpos ( $php_self1, "lampp/htdocs" ) !== false)||(strpos ( $php_self1, "www/html" ) !== false)) {
	$rootPhp="/var/www/html/";
	
	/*
		$hostHardCode='ipg.i15.tech';
		$data['Host']="https://".$hostHardCode;
		$_SERVER["HTTP_HOST"]=$hostHardCode;
	*/
	//$pq=0;
	$source="<b>Source - Cron Instance</b> via ";
}else{
	$rootPhp="";
	$source="<b>Source - Cron Host</b> via ";	
}
include($rootPhp.'config.do');

if($rootPhp==""&&!isset($_SESSION['adm_login'])){
	echo('ACCESS DENIED.');
	exit;
}
$acquirer=0;
$limit=' LIMIT 2 ';
$mid_query='';

if(isset($_GET['li'])&&$_GET['li']>0){
		$limit=' LIMIT '.$_GET['li'] .' ';
}

if(isset($_GET['acquirer'])&&$_GET['acquirer']>0){
		$acquirer=$_GET['acquirer'];
}

if(isset($_GET['mid'])&&$_GET['mid']>0){
		$mid_query .= "  AND  `merID` IN ({$_GET['mid']})  ";
}

if(isset($_GET['up1'])&&$_GET['up1']==30){
		
		db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` SET `trans_status`='22' WHERE `trans_status` IN (0) AND `tdate` <= now() - interval 30 minute {$limit} ",1);
		
		exit;
}
else if(isset($_GET['up1'])&&$_GET['up1']==10){
		
		db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` SET `trans_status`='22' WHERE `trans_status` IN (0) AND `tdate` < now() - interval 10 minute {$limit} ", $pq);
		
		exit;
}else if(isset($_GET['up1'])&&$_GET['up1']==5){
		
		db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` SET `trans_status`='22' WHERE `trans_status` IN (0) AND `tdate` < now() - interval 5 minute {$limit} ", $pq);
		
		exit;
}

if((isset($_GET['notAcquirer']))&&($_GET['notAcquirer'])){
	$notAcquirer=','.$_GET['notAcquirer'];
	$mid_query .= " AND (`acquirer` NOT IN (0,1,2,3,4,5,6,7,8,9,10,11,12{$notAcquirer}) ) ";
}

$day='1';
if(isset($_GET['day'])&&$_GET['day']){
	$day=$_GET['day'];

	$date_1st=(date('Y-m-d',strtotime("-{$day} days")));
	$date_2nd=date('Y-m-d');
	
	if(isset($_GET['day2'])&&$_GET['day2']&&$_GET['day2']<=$day)
	{
		$day2=$_GET['day2'];
		$date_2nd=(date('Y-m-d',strtotime("-{$day2} days")));
	}
	 
	$mid_query .= "  AND  ( ( `tdate` BETWEEN (DATE_FORMAT('{$date_1st} 00:00:00', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$date_2nd} 23:59:59', '%Y%m%d%H%i%s')) ) )  ";

}
			

$transID=[];
if(!isset($_SESSION['t_id_all']))
		$_SESSION['t_id_all']=[];

//echo "<br/><br/>=>test555555";exit;

// manual calculation update as per mid


//if($acquirer>0)

{
	//for host base 
	if($rootPhp==""){
		
		$acquirer_all=db_rows(
			"SELECT GROUP_CONCAT(DISTINCT(`acquirer`)) AS `acquirer`  ".
			" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" WHERE ".
				"`trans_status` IN (0) ", $pq
		);
		
		if($pq) echo "<br/><br/><hr/><br/><b>ALL ACQUIRER</b>=><br/>".$acquirer_all[0]['acquirer']."<br/><br/><br/><br/>";
		
		$mid_query .= "  AND  ( `acquirer` IN ({$acquirer}) )  ";
		
	}
	
	
	// Get trans_auto_expired above 0 and acquirer_status is 1 & 2  from acquirer_table  
	$acq=[];
	$acquirer_table=db_rows(
		"SELECT `acquirer_id`,`trans_auto_expired` FROM {$data['DbPrefix']}acquirer_table".
		" WHERE  `trans_auto_expired` > 0 AND `acquirer_status` IN (1,2)  ",$pq
	);
	foreach($acquirer_table as $key=>$value){
		$acq[$value['acquirer_id']]=$value; 	//store all values in array
	}
	
	
	//Select Data from master_trans_additional
	$join_additional=join_additional('i');
	if(!empty($join_additional)) $mts="`ad`";
	else $mts="`t`";
	
	//if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y') $mts="`ad`"; else $mts="`t`";

	$slct=db_rows(
		"SELECT `t`.`settelement_date`,`t`.`settelement_delay`,`t`.`transID`,`t`.`merID`,`t`.`acquirer`,`id`,`t`.`tdate`,`t`.`trans_amt`,`t`.`bill_amt`,`t`.`trans_status`,`t`.`bank_processing_amount`,`t`.`bill_email`,`t`.`bill_currency`,{$mts}.`trans_response`,{$mts}.`webhook_url`,{$mts}.`system_note` ".
		" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` AS `t`".
		" {$join_additional} WHERE ".
			" ( `t`.`trans_status` IN (0) ) ".$mid_query.
			" ".$limit.
			//" ORDER BY `id` DESC ". // cmn
			//" LIMIT 5". // cmn
		" ",$pq
	);

	if($pq) echo "<hr/>count=>".count($slct)."<br/><br/>";

		$j=0;
		foreach($slct as $key=>$value){
			$j++;
			
				
				if($pq) 
				echo $j.". transID=>".$value['transID'].", merID=>".$value['merID'].",  acquirer=>".$value['acquirer'].", id=>".$value['id'].", tdate=>".$value['tdate'].", trans_amt=>".$value['trans_amt'].", bill_amt=>".$value['bill_amt'].", trans_status=>".$value['trans_status']."<br/>";
				
				$data_tdate=date('YmdHis', strtotime($value['tdate']));
				
				$current_date_30m=date('YmdHis', strtotime("-30 minutes"));
				
				
				$acq_trans_auto_expired=@$acq[$value['acquirer']]['trans_auto_expired'];
				
				$current_from_acq_trans_auto_expired=date('YmdHis', strtotime("-$acq_trans_auto_expired minutes"));
				
				
				
				$current_date_10m=date('YmdHis', strtotime("-10 minutes"));
				
				
				$current_date_10m=date('YmdHis', strtotime("-10 minutes"));
				$current_date_5m=date('YmdHis', strtotime("-5 minutes"));
				
				
				//`rolling_amt`='{$value['rolling_amt']}',
					if(preg_match("/(Do not honour|devtext|Excess single payment)/i", $value['trans_response'])){
						$status_set='2';
						$status_text='Declined';
					}elseif(preg_match("/(The same IP|devtext)/i", $value['trans_response'])){
						$status_set='23';
						$status_text='Cancelled';
					}else{
						$status_set='22';
						$status_text='Expired';
					}
					
					
					
					$system_note = "<div class=rmk_row><div class=rmk_date>".date('d-m-Y h:i:s A')."</div><div class=rmk_msg> {$source}System  <a class=flagtag><b>{$status_text}</b></a></div></div>".$value['system_note'];
					
					if($pq) echo "<br/><br/>status_set=>".$status_set." | ".$status_text.", Trans Auto Expired=>".$acq_trans_auto_expired.", tdate=>".date('Y-m-d H:i:s', strtotime($data_tdate)).", Auto Expired Time=>".date('Y-m-d H:i:s', strtotime($current_from_acq_trans_auto_expired)).", Current Date=>".date('Y-m-d H:i:s')."<br/><br/>";
					
					
					//echo "<br/><br/>trans_response=>".$value['trans_response'];echo "<br/><br/>status_set=>".$status_set;exit;
					
					
				$query_upd="UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`"." SET ".
					"	
					`trans_status`='{$status_set}', `system_note`='{$system_note}' ".
					" WHERE `id`={$value['id']}";
				
				if($pq) echo "<br/>query_upd=>".$query_upd."<br/>";
					
					
				
				if( ($data_tdate<=$current_from_acq_trans_auto_expired )  ){ 
					db_query($query_upd,$pq);
					$update_condition=1;
				}
				
				/*
				if( ($data_tdate<=$current_date_10m ) && ( isset($_REQUEST['st'])) ){ 
					db_query($query_upd,$pq);
					$update_condition=1;
				}
				elseif( ($data_tdate<=$current_date_30m )  )
				{
					db_query($query_upd,1);
					$update_condition=1;
				}
				*/
				else {
					$update_condition=0;
				}

				//echo "<hr/>";
				
				
			if($update_condition==1){
				$transID[]=$value['transID'];
				$_SESSION['t_id_all'][]=$value['transID'];
			}
			
			#########  notify value	##################################
			
			if(isset($_GET['notify'])&&$_GET['notify']&&$update_condition==1){
					
				if(!isset($status_set) || empty($status_set) ) {
					$order_status=$value['order_status'];
				}else {
					$order_status=$status_set;
				}
				
				$jsonarray_all["order_status"]=$order_status;
				if($value['order_status']==8){
					$jsonarray_all["status"]="Request Processed";
				}else{
					$jsonarray_all["status"]=$data['TransactionStatus'][$order_status];
				}
				
				$jsonarray_all["bill_amt"]=$value['bill_amt'];
				$jsonarray_all["transID"]=$value['transID'];
				//$jsonarray_all["descriptor"]=$value['descriptor'];
				$jsonarray_all["tdate"]=$value['tdate'];
				$jsonarray_all["bill_currency"]=get_currency($value['bill_currency'],1);
				$jsonarray_all["trans_response"]=$value['trans_response'];
				$jsonarray_all["reference"]=$value['reference'];
				if($value['mop']){
					$jsonarray_all["mop"]=$value['mop'];
				}
				
				
				$webhook_url=$value['webhook_url'];
				if(!empty($webhook_url)){
					/*
					if(strpos($webhook_url,'?')!==false){
						$webhook_url=$webhook_url."&".http_build_query($jsonarray_all);
					}else{
						$webhook_url=$webhook_url."?".http_build_query($jsonarray_all);
					}
					*/
					$jsonarray_all['webhook']="webhook_by_s2s";		
					$chs = curl_init();
						curl_setopt($chs, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);
					curl_setopt($chs, CURLOPT_URL, $webhook_url);
					curl_setopt($chs, CURLOPT_HEADER, FALSE); // FALSE || true || 
						curl_setopt($chs, CURLOPT_MAXREDIRS, 10);
					curl_setopt($chs, CURLOPT_RETURNTRANSFER, 1);
					curl_setopt($chs, CURLOPT_SSL_VERIFYHOST, 0);
					curl_setopt($chs, CURLOPT_SSL_VERIFYPEER, 0);
					curl_setopt($chs, CURLOPT_POST, true);
					curl_setopt($chs, CURLOPT_POSTFIELDS, http_build_query($jsonarray_all));
					curl_setopt($chs, CURLOPT_TIMEOUT, 10);
					$notify_res = curl_exec($chs);
					curl_close($chs);
					
					#######	save notificatio response	#############
					if($value['id']&&$value['id']>0){
						//$return_notify_json='{"notify_code":"00","notify_msg":"received"}'; echo ($return_notify_json); exit;
				
						$notify_de = json_decode($notify_res,true);
						if(isset($notify_de)&&is_array($notify_de)){
							//print_r($notify_de);
							if($notify_de['notify_msg']=='received'){
								$tr_upd_notify['CRONS_BRIDGE']['MERCHANT_RECEIVE']='NOTIFY_RECEIVE';
							}
						}	
						$tr_upd_notify['CRONS_BRIDGE']['NOTIFY_STATUS']='DONE';
						$tr_upd_notify['CRONS_BRIDGE']['time']=prndates(date('Y-m-d H:i:s'));
						$tr_upd_notify['CRONS_BRIDGE']['NOTIFY_SEND_SOURCE']='crons_notify';
						$tr_upd_notify['CRONS_BRIDGE']['RES']=$jsonarray_all;
						
						$tr_upd_notify['system_note']='<b>Source - crons_notify</b> | Current Status : <b>'.$jsonarray_all["status"].'</b> status sent on '.$webhook_url;
						//$tr_upd_notify['CRONS_BRIDGE']['get_info']=htmlentitiesf($notify_res);
						
						
						//exit;
					
						if($pq) {
							echo "<br/><hr/><br/>{$j}. transID=> ".$value['transID'];
							echo "<br/><br/>webhook_url=> ".$webhook_url;
							echo "<br/><br/>jsonarray_all=> "; print_r($jsonarray_all);
							echo "<br/><br/>tr_upd_notify=> "; print_r($tr_upd_notify);
							
							echo "<br/><br/>";
						}
					
					}
					
				}else{
					
					$tr_upd_notify['NOTIFY_FAILED_TIME']=prndate(date('Y-m-d H:i:s'));
					$tr_upd_notify['NOTIFY_FAILED_SOURCE']='crons_notify';
					$tr_upd_notify['NOTIFY_FAILED']='Missing notify url';
					$tr_upd_notify['system_note']='<b>Source - crons_notify</b>  | Notify skipped as log found | Current Status : <b>'.$jsonarray_all["status"].'</b> status as <b>notify url missing</b>';
					
					if($pq) echo "<br/><hr/><br/>{$j}. NOT FOUND webhook_url => ".$value['transID'];
				}
				
				
				
				trans_updatesf($value['id'], $tr_upd_notify);
			
				
			} //End to notify 
				
				
			
		}

db_disconnect();

	if($pq) {
		
		echo "<br/><hr/><br/>transID=> ".count($transID)."<br/>".implode(",",$transID)."<br/><br/>";
		
		echo "<br/><br/><hr/><br/><==All t_id==> ".count($_SESSION['t_id_all'])."<br/>".implode(",",$_SESSION['t_id_all']);
			echo "<br/><br/><hr/>";
			
	}

	exit;
}

?>