<?

//ini_set('auto_detect_line_endings',true);


$mid="";$uid="";
if(isset($_GET['bid'])&&$_GET['bid']){
	$mid="[".$_GET['bid']."]";
	$uid=$_GET['bid'];
}

$filename = "transaction_Download_{$mid}_".date("Ymd").".csv";

$qprint=0;

$string_prefix= "'";
//$_GET['a']=1;

include('../config_db.do');

$is_adm_login=1; $merchant_csv_data=0;

######	merchant:start 	##################################	

if(isset($data['CSV_DATA_TY'])&&$data['CSV_DATA_TY']=='merchant_csv_data'){
	if(!isset($_SESSION['uid'])){
		echo('ACCESS DENIED.');
		exit;
	}
	$is_adm_login=0; $merchant_csv_data=1;
	$filename = "transaction_Download_{$_SESSION['m_company']}_".date("Ymd").".csv";
	$mid="[".$_SESSION['m_company']."]";
	$uid=$_SESSION['uid'];
	
	if(isset($data['CSV_FIELD_LIST'])&&$data['CSV_FIELD_LIST']){
		$csv_field_list=$data['CSV_FIELD_LIST'];
		foreach ($csv_field_list as $key1=>$val1)
		{
			$_POST[$key1]=1;
		}
	}

}
######	merchant:end 	##################################	

error_reporting(0);
set_time_limit(0);

if(isset($_REQUEST['fetch_limit'])){
	$fetch_limit = $_REQUEST['fetch_limit'];
}
if(!isset($fetch_limit)) $fetch_limit = 10000;

if(isset($_REQUEST['is_view_screen'])&&$_REQUEST['is_view_screen']==1){
	$is_view_screen=1;
	$string_prefix= "";	
}
elseif(isset($_GET['a'])&&$_GET['a']==1){
//if(isset($_GET['ptdate'])){
	$qprint=1;
	
}else{
	ob_start();

	$output = fopen('php://output', 'w');
	
	header("Content-Transfer-Encoding: binary");
}

//$clients=select_client_table($uid);
//print_r($clients);
//$manual_adjust_balance=$clients['manual_adjust_balance'];
	

function replaces_amt($fileds){
	//$fileds = str_replace(array(",","-","."),array(" ","",""),$fileds);
	//return number_formatf($fileds);
	return number_format((double)$fileds, '2', '.', '');
}

function replacesph($fileds){
	$filed = str_replace(array(",","-","."),array(" ","",""),$fileds);
	return $filed;
}
function replaces($fileds){
	$fileds = str_replace(array(",","-",".","'","’","<",">"),array(" "," ","","","","",""),$fileds);
	$fileds = preg_replace( '@^(<br\\b[^>]*/?>)+@i', '', $fileds );
	return $fileds;
}
function replaces2($fileds){
	$filed = str_replace(',',' ',$fileds);
	return $filed;
}
function replaces3($fileds){
	$filed = str_replace(',',' ',$fileds);
	return $filed;
}
function datef($date){
	if($date){
		$dates = date('m/d/Y');
		$dates = str_replace('-','/',$dates);
	}else {
		$dates = " ";
	}
	return $dates;
}

if(!isset($_SESSION['adm_login'])&&$is_adm_login){
	echo('ACCESS DENIED.');
	exit;
}

$csv_q="";
if((isset($_REQUEST['csv_q']))&&($_REQUEST['csv_q'])){
	$csv_q=$_REQUEST['csv_q'];	

	$csv_q=str_replace(array('COUNT(`t`.`id`) AS `trcount`','LIMIT 1'),array(' * ',' '),$csv_q);
	$r1="AND ( `merID` IN ({$uid}))";
	$csv_q=str_replace(array($r1),' ',$csv_q);
}




$csv_q=substr_replace($csv_q,'', strpos($csv_q, ' ORDER '));

$csv_q .= ' AND ( trans_status NOT IN (9,10) )';


######### merchant csv query :starts	################################
if($merchant_csv_data&&isset($_SESSION['merchant_csv_qr'])&&$_SESSION['merchant_csv_qr']){
	$csv_mqr = " SELECT t.* FROM {$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']} AS `t` WHERE ( `t`.`merID` IN ({$_SESSION['uid']}) ) ";
	$csv_q = $csv_mqr.$_SESSION['merchant_csv_qr'];
	//echo $csv_q;exit;
}
######### merchant csv query :end	################################


if(isset($_POST['type_not_3']) && !empty($_POST['type_not_3'])){
	$csv_q .= ' AND ( acquirer NOT IN (3) )';
}



//$rows = db_rows($csv_q." ORDER BY `t`.`tdate` DESC ",$qprint); 

/*
$rows = db_rows($csv_q,$qprint); 

$sizeof=sizeof($rows);
if($qprint){
	print_r($rows);echo $sizeof;exit;
}*/

	$sub_q = "";

	$HeadingArr[] = "Sl.{$mid}";
	
	if(isset($_POST['transID']) && !empty($_POST['transID'])){
		$HeadingArr[] = "transID";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "transID";
	}
	if(isset($_POST['reference']) && !empty($_POST['reference'])) {
		$HeadingArr[] = "Reference";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "reference";
	}
	if(isset($_POST['tdate']) && !empty($_POST['tdate'])) {
		$HeadingArr[] = "Tdate";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "tdate";
	}
	if(isset($_POST['fullname']) && !empty($_POST['fullname'])) {
		$HeadingArr[] = "Full Name";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "fullname";
	}
	if(isset($_POST['bill_phone']) && !empty($_POST['bill_phone'])) {
		$HeadingArr[] = "Bill Phone";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "bill_phone";
	}
	if(isset($_POST['bill_email']) && !empty($_POST['bill_email'])) {
		$HeadingArr[] = "Bill Email";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "bill_email";
	}
	
	
	
	
	
	
	
	if(isset($_POST['trans_status']) && !empty($_POST['trans_status'])) {
		$HeadingArr[] = "Trans Status";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "trans_status";
	}
	if(isset($_POST['acquirer']) && !empty($_POST['acquirer'])) {
		$HeadingArr[] = "Acquirer";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "acquirer";
	}
	
	
	if(isset($_POST['bill_amt']) && !empty($_POST['bill_amt'])) {
		$HeadingArr[] = "Order Amount";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "bill_amt";
	}
	if(isset($_POST['trans_amt']) && !empty($_POST['trans_amt'])) {
		$HeadingArr[] = "Transaction Amount";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "trans_amt";
	}
	
	
	
	
	if(isset($_POST['buy_mdr_amt']) && !empty($_POST['buy_mdr_amt'])) {
		$HeadingArr[] = "Buy MDR Amt";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "buy_mdr_amt";
	}
	if(isset($_POST['buy_txnfee_amt']) && !empty($_POST['buy_txnfee_amt'])) {
		$HeadingArr[] = "Buy Txnfee Amt";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "buy_txnfee_amt";
	}
	if(isset($_POST['rolling_amt']) && !empty($_POST['rolling_amt'])) {
		$HeadingArr[] = "Rolling Amt";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "rolling_amt";
	}
	if(isset($_POST['mdr_cb_amt']) && !empty($_POST['mdr_cb_amt'])) {
		$HeadingArr[] = "MDR CB Amt";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "mdr_cb_amt";
	}
	if(isset($_POST['mdr_cbk1_amt']) && !empty($_POST['mdr_cbk1_amt'])) {
		$HeadingArr[] = "MDR CBK1 Amt";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "mdr_cbk1_amt";
	}
	if(isset($_POST['mdr_refundfee_amt']) && !empty($_POST['mdr_refundfee_amt'])) {
		$HeadingArr[] = "MDR Refundfee Amt";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "mdr_refundfee_amt";
	}
	if(isset($_POST['payable_amt_of_txn']) && !empty($_POST['payable_amt_of_txn'])) {
		$HeadingArr[] = "Payout Amount";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "payable_amt_of_txn";
	}
	if(isset($_POST['available_balance']) && !empty($_POST['available_balance'])) {
		$HeadingArr[] = "Available Balance";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "available_balance";
	}
	if(isset($_POST['settelement_date']) && !empty($_POST['settelement_date'])) {
		$HeadingArr[] = "Settlement Date";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "settelement_date";
	}
	if(isset($_POST['rolling_date']) && !empty($_POST['rolling_date'])) {
		$HeadingArr[] = "Rolling Date";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "rolling_date";
	}
	if(isset($_POST['merID']) && !empty($_POST['merID'])) {
		$HeadingArr[] = "MerID";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "merID";
	}
	
	if(isset($_POST['bill_address']) && !empty($_POST['bill_address'])) {
		$HeadingArr[] = "Bill Address";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "bill_address";
	}
	if(isset($_POST['bill_city']) && !empty($_POST['bill_city'])) {
		$HeadingArr[] = "Bill City";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "bill_city";
	}
	if(isset($_POST['bill_state']) && !empty($_POST['bill_state'])) {
		$HeadingArr[] = "Bill State";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "bill_state";
	}
	if(isset($_POST['bill_country']) && !empty($_POST['bill_country'])) {
		$HeadingArr[] = "Bill Country";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "bill_country";
	}
	if(isset($_POST['bill_zip']) && !empty($_POST['bill_zip'])) {
		$HeadingArr[] = "Bill Zip";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "bill_zip";
	}
	
	if(isset($_POST['mop']) && !empty($_POST['mop'])) {
		$HeadingArr[] = "MOP";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "mop";
	}
	if(isset($_POST['upa']) && !empty($_POST['upa'])) {
		$HeadingArr[] = "UPA";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "upa";
	}
	if(isset($_POST['terNO']) && !empty($_POST['terNO'])) {
		$HeadingArr[] = "TerNO";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "terNO";
	}
	if(isset($_POST['rrn']) && !empty($_POST['rrn'])) {
		$HeadingArr[] = "RRN";
		if($sub_q) $sub_q .= ", ";
		$sub_q .= "rrn";
	}
	if(isset($_POST['gst_amt']) && !empty($_POST['gst_amt'])) {
		$HeadingArr[] = "GST Fee";
		if($sub_q) $sub_q .= ", ";
		$sub_q .= "gst_amt";
	}
	
	
	if(isset($_POST['trans_type']) && !empty($_POST['trans_type'])) {
		$HeadingArr[] = "Trans Type";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "trans_type";
	}
	
	
	if(isset($_POST['risk_ratio']) && !empty($_POST['risk_ratio'])) {
		$HeadingArr[] = "Risk Ratio";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "risk_ratio";
	}
	if(isset($_POST['bill_currency']) && !empty($_POST['bill_currency'])) {
		$HeadingArr[] = "Bill Currency";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "bill_currency";
	}
	if(isset($_POST['acquirer_ref']) && !empty($_POST['acquirer_ref'])) {
		$HeadingArr[] = "Acquirer Ref";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "acquirer_ref";
	}
	if(isset($_POST['table_id']) && !empty($_POST['table_id'])) {
		$HeadingArr[] = "Table ID";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "id";
	}
	
	if(isset($_POST['cardbin']) && !empty($_POST['cardbin'])) {
		$HeadingArr[] = "Card Detail";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "ccno, bin_no";
	}
	if(isset($_POST['af_transID']) && !empty($_POST['af_transID'])) {
		$HeadingArr[] = "af_transID";

	}
	if(isset($_POST['Additional Transaction']) && !empty($_POST['af_status'])) {
		$HeadingArr[] = "Additional Trans Status";
	}
	if(isset($_POST['af_t_id']) && !empty($_POST['af_t_id'])) {
		$HeadingArr[] = "Additional Table Id";

	}
	if(isset($_POST['created_date']) && !empty($_POST['created_date'])) {
		$HeadingArr[] = "Created Date";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "created_date";
	}
	if(isset($_POST['bill_ip']) && !empty($_POST['bill_ip'])) {
		$HeadingArr[] = "Bill IP";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "bill_ip";
	}
	
	if(isset($_POST['trans_response']) && !empty($_POST['trans_response'])) {
		$HeadingArr[] = "Trans Response";

		if($sub_q) $sub_q .= ", ";
		$sub_q .= "trans_response";
	}

	if(isset($is_view_screen) && $is_view_screen ==1)
	{
		$total_column=count($HeadingArr);
		echo '<table><thead>
		<tr>';
		for($tab_h=0;$tab_h<$total_column;$tab_h++)
		{
			echo '<th>'.$HeadingArr[$tab_h].'</th>';
		}
		echo '</tr>
		</thead>
		<tbody>';
	}
	else
	{
		fputcsv($output, $HeadingArr);
	}

$i=1;

$af_transID="";
$af_status="";
$af_t_id="";

if(isset($sub_q)&&$sub_q) $csv_q = str_replace("t.*", $sub_q, $csv_q);

$_SESSION['csv_q']=$csv_q;

$trans_id=true;
for($q_num = 0;$q_num<100;$q_num++)
{
	$start = $q_num*$fetch_limit;
	$sqlStmt = $csv_q ." LIMIT $start, $fetch_limit";
//echo "<br />".$sqlStmt;
//exit;


	$rows = db_rows($sqlStmt,$qprint); 
	
	//$sizeof=sizeof($rows);
	if($qprint){
		//echo $sizeof;
		print_r($rows);exit;
	}
	
	if(!isset($rows[0]) || empty($rows[0]) || $trans_id==false)
	{
		break;
	}
		// loop over the rows, outputting them
	foreach($rows as $key=>$row){

		if(!isset($row['transID']) || empty($row['transID']))
			$trans_id=false;

		if($row['merID']==$uid&&$row['acquirer']==4){ //Add Fund af
			$bill_amt					= str_replace_minus($row['bill_amt']);
			$trans_amt		= str_replace_minus($row['trans_amt']);
			$payable_amt_of_txn		= str_replace_minus($row['payable_amt_of_txn']);
			$json_value				=json_decode($row['json_value'],true);
			$available_balance		=$json_value['receiver_last_available_balance'];
		}else{
			$bill_amt					= $row['bill_amt'];
			$trans_amt		= $row['trans_amt'];
			$available_balance		= $row['available_balance'];
			$payable_amt_of_txn		= ($row['payable_amt_of_txn']);
		}
	
		$dataset = array();
		
		//if(!(empty($_POST['rolling_amt']) && $row['acquirer']==3))
		{
			$dataset[] .= $i;
			if(isset($_POST['transID']) && !empty($_POST['transID']))
				$dataset[] .= $string_prefix.$row['transID'];
			if(isset($_POST['reference']) && !empty($_POST['reference']))
			{
				if($row['reference'])
					$dataset[] .= $string_prefix.replaces($row['reference']);
				else
					$dataset[] .= '';
			}
			if(isset($_POST['tdate']) && !empty($_POST['tdate']))
				$dataset[] .= date("Y-m-d",strtotime($row['tdate']));
			if(isset($_POST['fullname']) && !empty($_POST['fullname']))
				$dataset[] .= replaces($row['fullname']);
			if(isset($_POST['bill_phone']) && !empty($_POST['bill_phone']))
			{
				if($row['bill_phone'])
					$dataset[] .= $string_prefix.replacesph($row['bill_phone']);
				else
					$dataset[] .= '';
			}
			if(isset($_POST['bill_email']) && !empty($_POST['bill_email']))
			{
				$dataset[] .= encrypts_decrypts_emails($row['bill_email'],2);
			}
			
			
			
			
			
			
			if(isset($_POST['trans_status']) && !empty($_POST['trans_status']))
				if(isset($row['trans_status']) && isset($data['TransactionStatus'][$row['trans_status']]))
				{
					$dataset[].=$row['trans_status']." ".$data['TransactionStatus'][$row['trans_status']];
				}
				else
					$dataset[] .= '';
			if(isset($_POST['acquirer']) && !empty($_POST['acquirer']))
				$dataset[] .= $row['acquirer'];
				//$dataset[] .= $row['acquirer']." ".$data['t'][$row['acquirer']]['name1'];
			
			if(isset($_POST['bill_amt']) && !empty($_POST['bill_amt']))
				$dataset[] .= replaces_amt($bill_amt);
			if(isset($_POST['trans_amt']) && !empty($_POST['trans_amt']))
				$dataset[] .= replaces_amt($trans_amt);
			
			
			
			
			if(isset($_POST['buy_mdr_amt']) && !empty($_POST['buy_mdr_amt']))			
				$dataset[] .= replaces_amt($row['buy_mdr_amt']);
			if(isset($_POST['buy_txnfee_amt']) && !empty($_POST['buy_txnfee_amt']))
				$dataset[] .= replaces_amt($row['buy_txnfee_amt']);
			if(isset($_POST['rolling_amt']) && !empty($_POST['rolling_amt']))
				$dataset[] .= replaces_amt($row['rolling_amt']);
			if(isset($_POST['mdr_cb_amt']) && !empty($_POST['mdr_cb_amt']))			
				$dataset[] .= replaces_amt($row['mdr_cb_amt']);
			if(isset($_POST['mdr_cbk1_amt']) && !empty($_POST['mdr_cbk1_amt']))
				$dataset[] .= replaces_amt($row['mdr_cbk1_amt']);
			if(isset($_POST['mdr_refundfee_amt']) && !empty($_POST['mdr_refundfee_amt']))
				$dataset[] .= replaces_amt($row['mdr_refundfee_amt']);			
			if(isset($_POST['payable_amt_of_txn']) && !empty($_POST['payable_amt_of_txn']))
				$dataset[] .= replaces_amt($payable_amt_of_txn);
			if(isset($_POST['available_balance']) && !empty($_POST['available_balance']))
				$dataset[] .= replaces_amt($available_balance);
			if(isset($_POST['settelement_date']) && !empty($_POST['settelement_date']))
				$dataset[] .= date("Y-m-d",strtotime($row['settelement_date']));
			if(isset($_POST['rolling_date']) && !empty($_POST['rolling_date']))
			{
				if($row['rolling_date']!=NULL)
					$dataset[] .= date("Y-m-d",strtotime($row['rolling_date']));
				else
					$dataset[] .= '';
			}
			if(isset($_POST['merID']) && !empty($_POST['merID']))
				$dataset[] .= ($row['merID']." ");
			if(isset($_POST['bill_address']) && !empty($_POST['bill_address']))
				$dataset[] .= replaces($row['bill_address']." ");
			if(isset($_POST['bill_city']) && !empty($_POST['bill_city']))
				$dataset[] .= replaces($row['bill_city']);
			if(isset($_POST['bill_state']) && !empty($_POST['bill_state']))
				$dataset[] .= replaces($row['bill_state']);
			if(isset($_POST['bill_country']) && !empty($_POST['bill_country']))
				$dataset[] .= replacesph($row['bill_country']);
			if(isset($_POST['bill_zip']) && !empty($_POST['bill_zip']))
				$dataset[] .= replaces($row['bill_zip']);
			
			if(isset($_POST['mop']) && !empty($_POST['mop']))
				$dataset[] .= replaces($row['mop']);
			if(isset($_POST['upa']) && !empty($_POST['upa']))		
				$dataset[] .= $string_prefix.($row['upa']);
			if(isset($_POST['terNO']) && !empty($_POST['terNO']))
				$dataset[] .= replaces($row['terNO']);
			if(isset($_POST['rrn']) && !empty($_POST['rrn']))		
				$dataset[] .= $string_prefix.($row['rrn']);
			if(isset($_POST['gst_amt']) && !empty($_POST['gst_amt']))		
				$dataset[] .= replaces_amt($row['gst_amt']);
			
			
			
			if(isset($_POST['trans_type']) && !empty($_POST['trans_type']))
				$dataset[] .= replaces($row['trans_type']);
			
			
			if(isset($_POST['risk_ratio']) && !empty($_POST['risk_ratio']))
				$dataset[] .= replaces($row['risk_ratio']);
			if(isset($_POST['bill_currency']) && !empty($_POST['bill_currency']))
				$dataset[] .= replaces($row['bill_currency']);
			if(isset($_POST['acquirer_ref']) && !empty($_POST['acquirer_ref']))
				$dataset[] .= $string_prefix.($row['acquirer_ref']);
			if(isset($_POST['table_id']) && !empty($_POST['table_id']))
				$dataset[] .= replaces($row['id']);
			
			
			if(isset($_POST['cardbin']) && !empty($_POST['cardbin'])) {
				
				if(isset($row['ccno'])&&$row['ccno'])
				{
					$cc_number = card_decrypts256($row['ccno']);
					if(isset($row['bin_no'])&&$row['bin_no'])
					{
						$cc_number = substr_replace($cc_number,$row['bin_no'],0,6);
					}
					$dataset[] .= $cc_number;
				}
				else
				{
					$dataset[] .= '';
				}
			}
			if(isset($_POST['af_transID']) && !empty($_POST['af_transID']))
				$dataset[] .= ($af_transID);
			if(isset($_POST['Additional Transaction']) && !empty($_POST['af_status']))
				$dataset[] .= ($af_status);
			if(isset($_POST['af_t_id']) && !empty($_POST['af_t_id']))
				$dataset[] .= ($af_t_id);
			
			if(isset($_POST['created_date']) && !empty($_POST['created_date']))
				$dataset[] .= ($row['created_date']);
			if(isset($_POST['bill_ip']) && !empty($_POST['bill_ip']))
				$dataset[] .= ($row['bill_ip']);
			$i++;
			
			if(isset($is_view_screen) && $is_view_screen ==1)
			{
				echo '<tr>';
				for($inner_col=0;$inner_col<$total_column;$inner_col++)
				{
					echo '<td>'.$dataset[$inner_col].'</td>';
				}
				echo '</tr>';
			}
			else
			{
				fputcsv($output, $dataset);
			}
		}
	}
}
if(isset($is_view_screen) && $is_view_screen ==1)
{
	echo '</tbody></table>';
}
else
{
	
	// Get size of output after last output data sent
	$streamSize = ob_get_length();
	
	//Close the filepointer
	fclose($output);
	
	// Send the raw HTTP headers
	//header('Content-Type: text/csv');
	header('Content-Encoding: UTF-8');
	header('Content-type: text/csv; charset=UTF-8');
	header("Content-Disposition: attachment; filename=".$filename."");
	header('Expires: 0');
	header("Pragma: public");
	header('Cache-Control: no-cache');
	
	//header ('Content-length: '.filesize($filename));
	
	// force download
	header("Content-Type: application/force-download");
	header("Content-Type: application/octet-stream");
	header("Content-Type: application/download");
	
	// Flush (send) the output buffer and turn off output buffering
	ob_end_flush();

	/*
	if($sizeof&&$manual_adjust_balance){
		//fputcsv($output, array('', '', '', '', '', '', '', '', '', '', '', '', '', 'Manual Adjust Balance', "{$manual_adjust_balance}"));
	}
	*/
}

exit;
//ini_set('auto_detect_line_endings',false);
?>