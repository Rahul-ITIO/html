<?
//include/check_missing_calc.do?bid=27
include('../config.do');

$merID="";$uid="";

if(isset($_GET['bid'])&&$_GET['bid']){
	
	$merID=$_GET['bid'];
}

if(!isset($_SESSION['login_adm'])&&!isset($_SESSION['check_missing_calc'])){
       echo('ACCESS DENIED.');
       exit;
}
?>
<script>
function myConfirm(theValue,theUrl) {
  var result = confirm(theValue);
  if (result==true) {
	  window.location.href=theUrl;
   return true;
  } else {
   return false;
  }
}
</script>
<style>
body {height:100%;width:100%;margin:0 !important;padding:0;font-size:14px; font-family:"Courier";color:#333;}

/* start: table excel for transaction  */
.tbl_exl2 {width: 98vw;overflow:scroll;max-height: 2000px;margin:0 auto;float: left;clear:both;}
.tbl_exl2 table {position:relative;border:1px solid #ddd;border-collapse:collapse;max-width: inherit;}
.tbl_exl2 .trc_1 td {white-space:nowrap;}
.tbl_exl2 td, .tbl_exl2 th, .dtd {border:1px solid #ddd;padding: 8px 10px !important;text-align:center;}
.tbl_exl2 th {color:#000;background-color:#eee !important;position:sticky;top:-1px;z-index:93; &:first-of-type {left:0;z-index:95;} }
.tbl_exl2 tbody tr td:first-of-type{background-color: #eee !important;position:sticky;left:-1px;text-align:left;z-index:9;}
.dtd {display:table-cell;}
.tbl_exl2 tr:hover td {background:#dadada;}
.tbl_exl2 tr:hover td:first-of-type, .tbl_exl2 tr td:first-of-type, .tbl_exl2 td {padding: 0px 1px !important;}

.tbl_exl2 tr:hover td:first-of-type, .tbl_exl2 tr:hover td:hover, .tbl_exl2 tr:hover td, .tbl_exl2 tr:hover td div, .tbl_exl2 tr:hover .hover_tr  {background: #fff !important;}

.tbl_exl2 diff, .red_row td  {background:#7b0909;color:#fff !important;}

.rmk_row {clear:both;float:left; width:100%; border-top:1px dotted; padding:10px 0 1px 0; margin:10 0;}
.rmk_row .rmk_date {font-weight:bold; color:orange; float:left; width:30%;}
.rmk_row .rmk_msg {float:left; width:70%;line-height:20px;}

.red {color:#ff0000;}


</style>

<head>
<meta charset="UTF-8">
</head> 
<?

if($merID>0){
	$merID_sender= " ( `merID` IN ({$merID})  ) AND ";
}
else {
	 echo('Not found merID'); exit;
}

$payable_amt_of_txn_row=1;
$payable_amt_of_txn_row_update=0;

if(isset($_GET['payable_amt_of_txn_row_update'])&&$_GET['payable_amt_of_txn_row_update']){
	
	$payable_amt_of_txn_row_update=$_GET['payable_amt_of_txn_row_update'];
}
$not_match_fee_row=1;
$not_match_fee_row_update=0;

if(isset($_GET['not_match_fee_row_update'])&&$_GET['not_match_fee_row_update']){
	
	$not_match_fee_row_update=$_GET['not_match_fee_row_update'];
}


$not_trans_amt_row=1;
$not_trans_amt_row_update=0;

if(isset($_GET['not_trans_amt_row_update'])&&$_GET['not_trans_amt_row_update']){
	
	$not_trans_amt_row_update=$_GET['not_trans_amt_row_update'];
}		
		
if($payable_amt_of_txn_row){

	echo "<h3>Check in not match payable_amt_of_txn != (SUM( `buy_mdr_amt`+`buy_txnfee_amt`+`rolling_amt`+`mdr_cb_amt`+`mdr_cbk1_amt`+`mdr_refundfee_amt`+`payable_amt_of_txn`)) in trans_status 1 and 7 </h3><br/>";	
		

	$transactions_select = db_rows("SELECT `id`, 
	
	`transID`, `merID` , `acquirer`, `trans_status`, `bill_currency`,`bill_amt`, `trans_currency`,`trans_amt`, FORMAT(`buy_mdr_amt`,2) AS `buy_mdr_amt`,`buy_txnfee_amt`, FORMAT(`rolling_amt`,2) AS `rolling_amt`, `mdr_cb_amt`, `mdr_cbk1_amt`, `mdr_refundfee_amt`, FORMAT(`payable_amt_of_txn`,2) AS `payable_amt_of_txn` ".
	" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` ".
	" WHERE  ". $merID_sender . 
	"  (`trans_type` IN (11))  
	AND  ( `trans_status` IN (1,7) )
	GROUP BY `id` 
	HAVING 
	(FORMAT(SUM(`trans_amt`),2) <> FORMAT(SUM( `buy_mdr_amt`+`buy_txnfee_amt`+`rolling_amt`+`mdr_cb_amt`+`mdr_cbk1_amt`+`mdr_refundfee_amt`+`payable_amt_of_txn` ),2)) ".
	///" LIMIT 10 ". //CMN
	" ",1); 

	echo "<hr/>size=>".sizeof($transactions_select)."<br/><hr/>";
	
	//echo '<a href="'.$_SERVER['PHP_SELF'].'?payable_amt_of_txn_row_update=1&bid='.$merID.'">Update Difference Amount</a><br/><hr/>';
	
	$i=1;
	$diff_item = 0;
	$diff_trans_id=[];
	$rows="<div class='tbl_exl21'><table width='100%' border='0'>
		  <tr>
			<th>Sl. </th>
			<th>merID</th>
			<th>transID</th>
			<th>buy_mdr_amt</th>
			<th>buy_txnfee_amt</th>
			<th>rolling_amt</th>
			<th>trans_amt</th>
			<th>bill_amt</th>
			<th>payable_amt_of_txn</th>
			<th>payable_d</th>
			<th>diff</th>
		  </tr>";
	foreach($transactions_select as $key=>$value){
	
		//$json_value=json_decode($value['json_value'],true);
		
		
		
		$value['buy_mdr_amt'] 			= number_formatf_2($value['buy_mdr_amt']);
		$value['trans_amt'] 	= number_formatf_2($value['trans_amt']);
		$value['buy_txnfee_amt'] 	= number_formatf_2($value['buy_txnfee_amt']);
		$value['rolling_amt'] 		= number_formatf_2($value['rolling_amt']);
		$value['bill_amt'] 			= number_formatf_2($value['bill_amt']);
		$value['payable_amt_of_txn'] = number_formatf_2($value['payable_amt_of_txn']);
		
		$payable_d=($value['trans_amt'])-($value['buy_mdr_amt']+$value['buy_txnfee_amt']+$value['rolling_amt']);
		
		$diff=number_formatf_2(((double)$value['payable_amt_of_txn'])-((double)$payable_d));

		if(trim($value['payable_amt_of_txn'])!=trim($payable_d)){
			//echo $i.". merID=>".$value['merID']." | transID=>".$value['transID']." | buy_mdr_amt=>".$value['buy_mdr_amt']." | buy_txnfee_amt=>".$value['buy_txnfee_amt']." | rolling_amt=>".$value['rolling_amt']." | payable_amt_of_txn=><b style='color:orange'>".$value['payable_amt_of_txn']."</b> | trans_amt=>".$value['trans_amt'].$value['TOTAL']." | bill_amt=>".$value['bill_amt']." | payable_d=><b style='color:green'>".$payable_d."</b><br/>";
			
			if($diff>0 || $diff<(-0.99)) {
				$diff_item++;
				$diff_trans_id[] = $value['transID'];
				$updClass='red_row';
			}else{
				$updClass='';
			}
			
			$rows.="
			  <tr class='{$updClass}'>
				<td title='Sl.'>{$i}</td>
				<td title='merID'>{$value['merID']}</td>
				<td title='transID'>{$value['transID']}</td>
				<td title='buy_mdr_amt'>{$value['buy_mdr_amt']}</td>
				<td title='buy_txnfee_amt'>{$value['buy_txnfee_amt']}</td>
				<td title='rolling_amt'>{$value['rolling_amt']}</td>
				<td title='trans_amt'>{$value['trans_amt']}</td>
				<td title='bill_amt'>{$value['bill_amt']}</td>
				<td title='payable_amt_of_txn ".number_formatf_2($value['payable_amt_of_txn'])."'>".$value['payable_amt_of_txn']."</td>
				<td title='payable_d'>{$payable_d}</td>
				<td title='diff'>{$diff}</td>
			  </tr>
			";
			
			
			//cmn
			//if($value['transID']=="162102109423014757") $diff = 1;

			if($payable_amt_of_txn_row_update && ($diff>0 || $diff<(-0.99))){
			
			$sqlStmt= "UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`"." SET ".
				
					" 	`buy_mdr_amt`='{$value['buy_mdr_amt']}', 
						`buy_txnfee_amt`='{$value['buy_txnfee_amt']}',
						`rolling_amt`='{$value['rolling_amt']}',
						`mdr_cb_amt`='0',
						`mdr_cbk1_amt`='0',
						`mdr_refundfee_amt`='0',
						`payable_amt_of_txn`='{$payable_d}'".
						
					" WHERE `id`={$value['id']}";
				
				db_query($sqlStmt,1);
				
				//cmn
				echo "<br />Update=>$diff<br />$sqlStmt";
			}	
			$i++;
		}
	}
	
	$rows.="</table></div>";
	echo $rows;
	echo "<hr/>";
	
	if($diff_item>0)
	{
	?><a href="javascript:void(0)" onclick="myConfirm('Are you Sure to Update: <?=($diff_item)?> records?','<?=$_SERVER['PHP_SELF'];?>?payable_amt_of_txn_row_update=1&bid=<?=$merID?>');" style="text-transform:uppercase;font-weight:bold; font-size:16px; text-decoration:none; color:blue">Update Difference Amount: Records (<?=$diff_item;?>)</a>
	<hr />
	<br />
	<?
	print_r($diff_trans_id);echo '<hr />';
	}
}


if($not_trans_amt_row){

	echo "<h3 class='red'>Checking for Order Amount and Transaction Amount in trans_status 1 and 7 </h3><br/>";	

	$st_query = ' AND trans_status NOT IN(3, 5, 6, 8, 11, 12) ';
	if(isset($_REQUEST['rs'])&&$_REQUEST['rs']==1) $st_query = ' AND trans_status IN(3, 5, 6, 8, 11, 12) ';

	$transactions_select = db_rows("SELECT `id`, 
	
	`transID`, `merID` , `acquirer`, `trans_status`, `bill_currency`,`bill_amt`, (CAST(SUBSTR(`json_value`,POSITION('bill_amt' IN `json_value`)+8,10) as DOUBLE)) as jAmount,  `trans_currency`,`trans_amt`, FORMAT(`buy_mdr_amt`,2) AS `buy_mdr_amt`,`buy_txnfee_amt`, FORMAT(`rolling_amt`,2) AS `rolling_amt`, `mdr_cb_amt`, `mdr_cbk1_amt`, `mdr_refundfee_amt`, FORMAT(`payable_amt_of_txn`,2) AS `payable_amt_of_txn` ".
	" ,`bill_currency`,`bank_processing_curr`,`tdate` ".
	" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` ".
	" WHERE  ". $merID_sender . 
	"  ( `trans_type` IN (11) ) ".
	" AND bill_amt!=(CAST(SUBSTR(`json_value`,POSITION('bill_amt' IN `json_value`)+8,10) as DOUBLE)) ".$st_query.
	///" LIMIT 10 ". //CMN
	" ",1); 


	echo "<br />&nbsp; size=>".sizeof($transactions_select)."<br/><hr/>";

	if(!isset($_REQUEST['rs'])){
		$get=http_build_query($_REQUEST);
		$url="check_missing_calc".$data['ex']."?".$get;
		echo '&nbsp; <a class="red" href="'.$url.'&rs=1" style="text-transform:uppercase;font-weight:bold; font-size:16px; text-decoration:none;">AFTER REVERSE</a><br/><hr/>';
	}
	//echo '<a href="'.$_SERVER['PHP_SELF'].'?payable_amt_of_txn_row_update=1&bid='.$merID.'">Update Difference Amount</a><br/><hr/>';
	
	$i=1;
	$diff_item = 0;
	$diff_trans_id=[];
	$rows="<div class='tbl_exl21'><table width='100%' border='0'>
		  <tr>
			<th>Sl. </th>
			<th>merID</th>
			<th>transID</th>
			<th>buy_mdr_amt</th>
			<th>buy_txnfee_amt</th>
			<th>rolling_amt</th>
			<th>curr_tr.</th>
			<th>trans_amt</th>
			<th>bill_amt</th>
			<th>bill_currency</th>
			<th>payable_amt_of_txn</th>
			<th>payable_d</th>
			<th>diff</th>
		  </tr>";
	foreach($transactions_select as $key=>$value){
	
		//$json_value=json_decode($value['json_value'],true);
		
		
		
		$value['buy_mdr_amt'] 			= number_formatf_2($value['buy_mdr_amt']);
		$value['trans_amt'] 	= number_formatf_2($value['trans_amt']);
		$value['buy_txnfee_amt'] 	= number_formatf_2($value['buy_txnfee_amt']);
		$value['rolling_amt'] 		= number_formatf_2($value['rolling_amt']);
		$value['bill_amt'] 			= number_formatf_2($value['bill_amt']);
		$value['payable_amt_of_txn'] = number_formatf_2($value['payable_amt_of_txn']);
		
		$payable_d=($value['trans_amt'])-($value['buy_mdr_amt']+$value['buy_txnfee_amt']+$value['rolling_amt']);
		
		$diff=number_formatf_2(((double)$value['payable_amt_of_txn'])-((double)$payable_d));

		if(trim($value['payable_amt_of_txn'])!=trim($payable_d)){
			//echo $i.". merID=>".$value['merID']." | transID=>".$value['transID']." | buy_mdr_amt=>".$value['buy_mdr_amt']." | buy_txnfee_amt=>".$value['buy_txnfee_amt']." | rolling_amt=>".$value['rolling_amt']." | payable_amt_of_txn=><b style='color:orange'>".$value['payable_amt_of_txn']."</b> | trans_amt=>".$value['trans_amt'].$value['TOTAL']." | bill_amt=>".$value['bill_amt']." | payable_d=><b style='color:green'>".$payable_d."</b><br/>";
			
			if($diff>0 || $diff<(-0.99)) {
				$diff_item++;
				$diff_trans_id[] = $value['transID'];
				$updClass='red_row';
			}else{
				$updClass='';
			}
			
			$rows.="
			  <tr class='{$updClass}'>
				<td title='Sl.'>{$i}</td>
				<td title='merID'>{$value['merID']}</td>
				<td title='transID'>{$value['transID']}</td>
				<td title='buy_mdr_amt'>{$value['buy_mdr_amt']}</td>
				<td title='buy_txnfee_amt'>{$value['buy_txnfee_amt']}</td>
				<td title='rolling_amt'>{$value['rolling_amt']}</td>
				<td title='trans_currency'>{$value['trans_currency']}</td>
				<td title='trans_amt'>{$value['trans_amt']}</td>
				<td title='bill_amt'>{$value['bill_amt']}</td>
				<td title='bill_currency'>{$value['bill_currency']}</td>
				<td title='payable_amt_of_txn ".number_formatf_2($value['payable_amt_of_txn'])."'>".$value['payable_amt_of_txn']."</td>
				<td title='payable_d'>{$payable_d}</td>
				<td title='diff'>{$diff}</td>
			  </tr>
			";
			
			
			//cmn
			//if($value['transID']=="162102109423014757") $diff = 1;

			if($not_trans_amt_row_update && ($diff>0 || $diff<(-0.99))){
			
			$sqlStmt= "UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`"." SET ".
				
					" 	`buy_mdr_amt`='{$value['buy_mdr_amt']}', 
						`buy_txnfee_amt`='{$value['buy_txnfee_amt']}',
						`rolling_amt`='{$value['rolling_amt']}',
						`mdr_cb_amt`='0',
						`mdr_cbk1_amt`='0',
						`mdr_refundfee_amt`='0',
						`payable_amt_of_txn`='{$payable_d}'".
						
					" WHERE `id`={$value['id']}";
				
				//db_query($sqlStmt,1);
				
				//cmn
				echo "<br />Update=>$diff<br />$sqlStmt";
			}	
			$i++;
		}
	}
	
	$rows.="</table></div>";
	echo $rows;
	echo "<hr/>";
	
	if($diff_item>0)
	{
	?><a href="javascript:void(0)" onclick="myConfirm('Are you Sure to Update: <?=($diff_item)?> records?','<?=$_SERVER['PHP_SELF'];?>?payable_amt_of_txn_row_update=1&bid=<?=$merID?>');" style="text-transform:uppercase;font-weight:bold; font-size:16px; text-decoration:none; color:blue">Update Difference Amount: Records (<?=$diff_item;?>)</a>
	<hr />
	<br />
	<?
	print_r($diff_trans_id);echo '<hr />';
	}
}

	
if($not_match_fee_row){

	echo "<h3>Check in not match fee of buy_mdr_amt | buy_txnfee_amt | rolling_amt in trans_status 1 and 7  </h3><br/>";		

	$transactions_select = db_rows("SELECT `id`, 
	(SELECT `mdr_rate` FROM `{$data['DbPrefix']}mer_setting` AS `m` WHERE (`m`.`merID`=`merID`  AND  `acquirer_id`=`acquirer` ))  AS  `mdr_amt_d`,
	(SELECT `txn_fee_success` FROM `{$data['DbPrefix']}mer_setting` AS `m` WHERE (`m`.`merID`=`merID`  AND  `acquirer_id`=`acquirer` ))  AS  `mdr_txtfee_amt_d`,
	(SELECT `reserve_rate` FROM `{$data['DbPrefix']}mer_setting` AS `m` WHERE (`m`.`merID`=`merID`  AND  `acquirer_id`=`acquirer` ))  AS  `rolling_amt_d`,
	`transID`, `merID` , `acquirer`, `trans_status`, FORMAT(`payable_amt_of_txn`,2) AS `payable_amt_of_txn`, `bill_amt`, `trans_amt`, FORMAT(`trans_amt`-SUM( `buy_mdr_amt`+`buy_txnfee_amt`+`rolling_amt`+`mdr_cb_amt`+`mdr_cbk1_amt`+`mdr_refundfee_amt` ),2) AS `TOTAL`,
	
	FORMAT(SUM(`trans_amt`*(SELECT `mdr_rate` FROM `{$data['DbPrefix']}mer_setting` AS `m` WHERE (`m`.`merID`=`merID`  AND  `acquirer_id`=`acquirer` ))/100),2) AS `mdr_amt_c`, 
	
	FORMAT(`buy_mdr_amt`,2) AS `buy_mdr_amt`,`buy_txnfee_amt`, 
	
	FORMAT(SUM(`trans_amt`*(SELECT `reserve_rate` FROM `{$data['DbPrefix']}mer_setting` AS `m` WHERE (`m`.`merID`=`merID`  AND  `acquirer_id`=`acquirer` ))/100),2) AS `rolling_amt_c` , 
		
	FORMAT(`rolling_amt`,2) AS `rolling_amt`, 
	`mdr_cb_amt`, `mdr_cbk1_amt`, `mdr_refundfee_amt` ".
	" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` ".
	" WHERE  ". $merID_sender.
	" (`trans_type` IN (11))".
	" AND  ( `trans_status` IN (1,7) ) ".
	//" AND  (`trans_status`=1 OR `trans_status`=7 OR `trans_status`=3 OR `trans_status`=5 OR `trans_status`=6 OR `trans_status`=11 OR `trans_status`=12)".
	//" AND  (`merID`=24 )".
	" 
	GROUP BY `id` 
	HAVING 
	".
	" (FORMAT(SUM(`buy_mdr_amt`),2) <> FORMAT(SUM(`trans_amt`*(SELECT `mdr_rate` FROM `{$data['DbPrefix']}mer_setting` AS `m` WHERE (`m`.`merID`=`merID`  AND  `acquirer_id`=`acquirer` ))/100),2)) OR ".
	"  (FORMAT(SUM(`rolling_amt`),2) <> FORMAT(SUM(`trans_amt`*(SELECT `reserve_rate` FROM `{$data['DbPrefix']}mer_setting` AS `m` WHERE (`m`.`merID`=`merID`  AND  `acquirer_id`=`acquirer` ))/100),2))  ".
	
	"  OR ((`buy_txnfee_amt`) <> ((SELECT `txn_fee_success` FROM `{$data['DbPrefix']}mer_setting` AS `m` WHERE (`m`.`merID`=`merID`  AND  `acquirer_id`=`acquirer` )))) ".
	
	"",1); 

	echo "<hr/>size=>".sizeof($transactions_select)."<br/><hr/>";
	
	?>
	<a href="javascript:void(0)" onclick="myConfirm('Are you Sure to Update: <?=sizeof($transactions_select)?> records?','<?=$_SERVER['PHP_SELF'];?>?not_match_fee_row_update=1&bid=<?=$merID?>');" style="text-transform:uppercase;font-weight:bold; font-size:16px; text-decoration:none; color:blue" >Update Difference Amount: Records (<?=sizeof($transactions_select);?>)</a>
	<hr />
	<br />
	<?
	$i=1;
	foreach($transactions_select as $key=>$value){
	
		 $json_value=json_decode($value['json_value'],true);
		
		$payable_d=$value['trans_amt']-($value['mdr_amt_c']+$value['mdr_txtfee_amt_d']+$value['rolling_amt_c']);
		
		echo $i.". merID=>".$value['merID']." | id=>".$value['id']." | transID=>".$value['transID']." | trans_status=>".$value['trans_status']." | buy_mdr_amt=>".$value['buy_mdr_amt']." | mdr_amt_c=>".$value['mdr_amt_c']." | buy_txnfee_amt=>".$value['buy_txnfee_amt']." | mdr_txtfee_amt_d=>".$value['mdr_txtfee_amt_d']." | rolling_amt=>".$value['rolling_amt']." | rolling_amt_c=>".$value['rolling_amt_c']." | TOTAL=>".$value['TOTAL']." | bill_amt=>".$value['bill_amt']." | trans_amt=>".$value['trans_amt']." | TOTAL=>".$value['TOTAL']." | payable_d=>".$payable_d."<br/>";
			
		

		
		
		if($not_match_fee_row_update){
			
			$sqlStmt= "UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`"." SET ".
			
				" 	`buy_mdr_amt`='{$value['mdr_amt_c']}', 
					`buy_txnfee_amt`='{$value['mdr_txtfee_amt_d']}',
					`rolling_amt`='{$value['rolling_amt_c']}',
					`mdr_cb_amt`='0',
					`mdr_cbk1_amt`='0',
					`mdr_refundfee_amt`='0',
					`payable_amt_of_txn`='{$payable_d}'".
					
				" WHERE `id`={$value['id']}";
			db_query($sqlStmt,1);
			
			//cmn
			echo "<br />Update=>$diff<br />$sqlStmt";
		}	
		echo "<hr/>";
		$i++;
	}
}

if(isset($con)){
	mysqli_close($con);
}

?>

