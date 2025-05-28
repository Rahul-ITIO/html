<?
if(!isset($_SESSION))
	session_start();

$data['CSV_DATA_TY']='merchant_csv_data';

$field_list79 = array('transID'=>'transID', 'reference'=>'Reference', 'tdate'=>'tdate', 'fullname'=>'Full Name', 'bill_phone'=>'Bill Phone', 'bill_email'=>'Bill email', 'trans_status'=>'Trans Status', 'bill_amt'=>'Bill Amount', 'trans_amt'=>'Trans Amt', 'buy_mdr_amt'=>'Buy MDR Amt', 'buy_txnfee_amt'=>'Buy Txnfee Amt', 'rolling_amt'=>'Rolling Amt', 'mdr_cb_amt'=>'MDR CB Amt', 'mdr_cbk1_amt'=>'MDR CBK1 Amt', 'mdr_refundfee_amt'=>'MDR Refundfee Amt', 'payable_amt_of_txn'=>'Payout Amount', 'bill_currency'=>'Bill Currency','mop'=>'MOP', 'terNO'=>'TerNO');


if(isset($data['con_name'])&&$data['con_name']=='clk' || isset($_SESSION['con_name'])&&$_SESSION['con_name']=='clk'){
	$field_list_clk=['upa'=>'VPA','rrn'=>'RRN','gst_amt'=>'GST Amt'];
	$field_list79 = array_merge($field_list79,$field_list_clk);
}

//print_r($_SESSION['con_name']);

$data['CSV_FIELD_LIST']= $field_list79;

//print_r($data['CSV_FIELD_LIST']);

include('csv_data_filter.do');
exit;
?>