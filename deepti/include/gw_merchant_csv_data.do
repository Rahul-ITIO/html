<?
$data['CSV_DATA_TY']='merchant_csv_data';

$data['CSV_FIELD_LIST']= array('transID'=>'transID', 'status'=>'status', 'type_not_3'=>'Type Not Withdraw Rolling', 'fullname'=>'fullname', 'bill_email'=>'bill_email', 'amount'=>'Order Amount - amount', 'trans_amt'=>'Transaction Amount - trans_amt', 'buy_mdr_amt'=>'Discount Rate - buy_mdr_amt', 'buy_txnfee_amt'=>'Transaction Fee - buy_txnfee_amt', 'rolling_amt'=>'Rolling Fee - rolling_amt', 'mdr_cb_amt'=>'mdr_cb_amt', 'mdr_cbk1_amt'=>'mdr_cbk1_amt', 'mdr_refundfee_amt'=>'mdr_refundfee_amt', 'payable_amt_of_txn'=>'Payout Amount - payable_amt_of_txn', 'settelement_date'=>'Mature Date - settelement_date', 'mop'=>'mop', 'reference'=>'Ref.No.', 'website_id'=>'Website id', 'risk_ratio'=>'risk_ratio', 'bill_currency'=>'bill_currency', 'type_not_3'=>'type_not_3');

$request_arr=[];
if(isset($_REQUEST['date_2nd'])) $request_arr['date_2nd']=$_REQUEST['date_2nd'];

if(isset($request_arr)&&is_array($request_arr))
	$data['CSV_FIELD_LIST']= array_merge($data['CSV_FIELD_LIST'], $request_arr);

if(@$data['con_name']=='clk'){
	$clk_field_list7=['gst_amt'=>'GST Fee','rrn'=>'RRN'];
	$data['CSV_FIELD_LIST']= array_merge($data['CSV_FIELD_LIST'], $clk_field_list7);
}
	
// (type,Address,bill_city,State,country,bill_zip,Card Type Remove these fields from merchant download.)

	$field_list7_uncheck = array('bill_address','bill_city','bill_state','bill_zip','bill_phone','type','country','cardbin');
	
	if(@$data['con_name']=='clk'){
		$clk_field_list7_uncheck=['rrn'];
		$field_list7_uncheck = array_merge($field_list7_uncheck, $clk_field_list7_uncheck);
	}
	
	
//include('csv_data_filter.do');
include('gw_csv_data_filter.do');
exit;
?>