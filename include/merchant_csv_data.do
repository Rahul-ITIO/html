<?
if(!isset($_SESSION))
	session_start();

$data['CSV_DATA_TY']='merchant_csv_data';

$field_list79 = array('transID'=>'transID', 'reference'=>'Reference', 'tdate'=>'Updated Timestamp', 'fullname'=>'Full Name', 'bill_phone'=>'Bill Phone', 'bill_email'=>'Bill email', 'trans_status'=>'Trans Status', 'bill_amt'=>'Bill Amount', 'trans_amt'=>'Trans Amt', 'buy_mdr_amt'=>'Buy MDR Amt', 'buy_txnfee_amt'=>'Buy Txnfee Amt', 'rolling_amt'=>'Rolling Amt', 'mdr_cb_amt'=>'MDR CB Amt', 'mdr_cbk1_amt'=>'MDR CBK1 Amt', 'mdr_refundfee_amt'=>'MDR Refundfee Amt', 'payable_amt_of_txn'=>'Payout Amount', 'bill_currency'=>'Bill Currency','mop'=>'MOP', 'terNO'=>'TerNO');


if(isset($_REQUEST['is_created_date_on'])&&trim($_REQUEST['is_created_date_on']))
$field_list79 = array_merge($field_list79,['created_date'=>'Created Timestamp']);

if(isset($data['con_name'])&&$data['con_name']=='clk' || isset($_SESSION['con_name'])&&$_SESSION['con_name']=='clk'){
	$field_list_clk=['upa'=>'VPA','rrn'=>'RRN','gst_amt'=>'GST Amt'];
	$field_list79 = array_merge($field_list79,$field_list_clk);
}

//print_r($_SESSION['con_name']);

$data['CSV_FIELD_LIST']= $field_list79;

//dev tech : 24-07-24 deffer runtime 
//if(isset($data['TIME_TO_COMPLETION_TRANSACTION_SECONDS'])&&@$data['TIME_TO_COMPLETION_TRANSACTION_SECONDS']=='Y')
if(isset($_REQUEST['runtime'])&&trim($_REQUEST['runtime'])&&$_REQUEST['runtime']=='Y')
$data['CSV_FIELD_LIST']= array_merge($data['CSV_FIELD_LIST'], ['runtime'=>'Runtime']);


//print_r($data['CSV_FIELD_LIST']);



if(isset($_REQUEST['db_more_connection'])&&trim($_REQUEST['db_more_connection'])&&$_REQUEST['db_more_connection']=='Y')
	include('gw_csv_data_filter_more_connection_wise.do');

else include('gw_csv_data_filter.do');


//include('csv_data_filter.do');

exit;
?>