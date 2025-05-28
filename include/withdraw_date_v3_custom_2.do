<?
$data['SUM_FUNCTION_ENABLE_IN_WV3_CUSTOM']='Y'; //If SUM_FUNCTION_ENABLE_IN_WV3_CUSTOM is set to 'Y' via sum_f, use SUM() without a query. Otherwise, use PostgreSQL's SUM(CAST(payable_amt_of_txn AS double precision)) for accurate aggregation.

if(isset($_REQUEST['su'])&&$_REQUEST['su']=='n') $data['SUM_FUNCTION_ENABLE_IN_WV3_CUSTOM']='N';

include('withdraw_date_v3_custom.do');

###############################################################################
?>
