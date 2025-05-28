<?
$data['CSV_DATA_TY']='merchant_csv_data'; 

$data['CSV_FIELD_LIST']= array('transID'=>'transID', 'status'=>'status', 'type_not_3'=>'Type Not Withdraw Rolling', 'fullname'=>'fullname', 'bill_email'=>'bill_email', 'bill_amt'=>'Bill Amount', 'trans_amt'=>'Transaction Amount - trans_amt', 'buy_mdr_amt'=>'Discount Rate - buy_mdr_amt', 'buy_txnfee_amt'=>'Transaction Fee - buy_txnfee_amt', 'rolling_amt'=>'Rolling Fee - rolling_amt', 'mdr_cb_amt'=>'mdr_cb_amt', 'mdr_cbk1_amt'=>'mdr_cbk1_amt', 'mdr_refundfee_amt'=>'mdr_refundfee_amt', 'payable_amt_of_txn'=>'Payout Amount - payable_amt_of_txn', 'settelement_date'=>'Mature Date - settelement_date', 'mop'=>'mop', 'reference'=>'Ref.No.', 'terNO'=>'TerNO', 'bill_currency'=>'bill_currency', 'type_not_3'=>'type_not_3', 'created_date'=>'Created Date');

$request_arr=[];
if(isset($_REQUEST['date_2nd'])) $request_arr['date_2nd']=$_REQUEST['date_2nd'];

if(isset($request_arr)&&is_array($request_arr))
	$data['CSV_FIELD_LIST']= array_merge($data['CSV_FIELD_LIST'], $request_arr);

//dev tech : 24-07-24 deffer runtime 
//if(isset($data['TIME_TO_COMPLETION_TRANSACTION_SECONDS'])&&@$data['TIME_TO_COMPLETION_TRANSACTION_SECONDS']=='Y')
	$data['CSV_FIELD_LIST']= array_merge($data['CSV_FIELD_LIST'], ['runtime'=>'Runtime']);

if(@$data['con_name']=='clk'){
	$clk_field_list7=['gst_amt'=>'GST Fee','rrn'=>'RRN','upa'=>'UPA'];
	$data['CSV_FIELD_LIST']= array_merge($data['CSV_FIELD_LIST'], $clk_field_list7);
}
	
// (type,Address,bill_city,State,country,bill_zip,Card Type Remove these fields from merchant download.)

	$field_list7_uncheck = array('bill_address','bill_city','bill_state','bill_zip','bill_phone','type','country','cardbin','risk_ratio');
	
	if(@$data['con_name']=='clk'){
		//$clk_field_list7_uncheck=['rrn'];
		$field_list7_uncheck = array_merge($field_list7_uncheck, $clk_field_list7_uncheck);
	}


	
//include('csv_data_filter.do');
if(isset($data['GW_CSV_DATA_FILTER_MORE_CONNECTION_WISE'])&&@$data['GW_CSV_DATA_FILTER_MORE_CONNECTION_WISE']=='Y')
	include('gw_csv_data_filter_more_connection_wise.do');

else include('gw_csv_data_filter.do');

exit;
?>