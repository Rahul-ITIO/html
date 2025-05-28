<?
if(!isset($data['CONFIGFILE'])){
    $data['NO_SALT']=true;
    $data['SponsorDomain']=true;
  include('../config.do');
}

###############################################################################

if(!isset($_SESSION['login'])&&!isset($_SESSION['uid'])){
       echo('ACCESS DENIED!....');
       exit;
}

$uid=@$_SESSION['uid'];
if(isset($_REQUEST['curr'])&&trim($_REQUEST['curr'])) $post['default_currency']=@$_REQUEST['curr']; 


$where_pred=" ";
if(isset($_REQUEST['wid']) && trim($_REQUEST['wid'])){
    $wid=stf($_REQUEST['wid']);
    //$where_pred=" AND `acquirer`='{$wid}' ";
    $where_pred=" AND `terNO`='{$wid}' ";
}

  

//Fetch the total trans amt & total refund amount via merchant wise 
if(isset($_REQUEST['actionAjax'])&&$_REQUEST['actionAjax']=='sessionTrans')
{
	
    $noOfTransaction=db_rows(
        "SELECT SUM(`trans_amt`) AS `summ`, COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
        " WHERE  ( `merID`={$uid} )  AND ( `trans_status` IN (1,7) ) AND ( `trans_type` IN (11) )  {$where_pred}  LIMIT 1 ",0
        
    );
    $_SESSION['tr_sum_count']['noOfTransaction']=$_SESSION['tr_sum_count']['noOfTransaction']=$post['noOfTransaction']=@$noOfTransaction[0]['count'];
    $_SESSION['tr_sum_count']['transactionAmount']=$post['transactionAmount']=number_formatf(@$noOfTransaction[0]['summ']);


    //====================
    $noOfTotalTransactions=db_rows(
        "SELECT COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
        " WHERE  ( `merID`={$uid} )  AND ( `trans_status` IN (1,2,7) ) AND ( `trans_type` IN (11) )  {$where_pred}  LIMIT 1 ",0
    );
    $_SESSION['tr_sum_count']['noOfTotalTransactions']=$post['noOfTotalTransactions']=@$noOfTotalTransactions[0]['count'];
    //=================================================
    
    
    $refundAmount=db_rows(
        "SELECT SUM(`trans_amt`) AS `summ`, COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
        " WHERE  ( `merID`='{$uid}' )  AND ( `trans_status` IN (3) )  AND ( `trans_type` IN (11) ) LIMIT 1 ",0
    );
    $_SESSION['tr_sum_count']['refundAmount']=$post['refundAmount']=number_formatf(@$refundAmount[0]['summ']);

    $settlements=db_rows(
        "SELECT SUM(`trans_amt`) AS `summ`, COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
        " WHERE  ( `merID`={$uid} )  AND ( `trans_status` IN (1,13) )  AND ( `acquirer` IN (2) ) LIMIT 1 ",0
    );
    $_SESSION['tr_sum_count']['settlements']=$post['settlements']=number_formatf(@$settlements[0]['summ']);

    
    $_SESSION['mNotificationCount']=$trans_reply_counts=get_trans_reply_counts($uid,'1,2');

    $_SESSION['uid_wv2'.$uid]=@$_SESSION['tr_sum_count'];

}


?>
<!-- finclude/total_trans_merchant_default_do -->

<?  
  
    
  if(isset($_REQUEST['actionUI'])&&($_REQUEST['actionUI']=='trans_amt_and_refund_amt'||$_REQUEST['actionUI']=='trans_amt_with_sales_volume'))  
  {
		?>
   
   
<script type="text/javascript">
if(typeof jQuery == 'undefined') {
  document.write('<script type="text/javascript" src="<?=$data['Host']?>/js/jquery-3.6.0.min.js"><\/script>');        
} 

var readyToSettle = parent.window.$('#trans_amt_3')
var refund_amt = parent.window.$('#refund_amt_3');
var settlements_amt = parent.window.$('#settlements_amt_3');
var noOfTransaction = parent.window.$('#noOfTransaction_3');

readyToSettle.html("<? if(isset($post['transactionAmount'])) echo $_SESSION['tr_sum_count']['transactionAmt']=prnpays_crncy2(getNumericValue($post['transactionAmount']),$post['default_currency']);?>");
refund_amt.html("<? if(isset($post['refundAmount'])) echo $_SESSION['tr_sum_count']['refundAmt']=prnpays_crncy2(getNumericValue($post['refundAmount']),$post['default_currency']);?>");
settlements_amt.html("<? if(isset($post['settlements'])) echo $_SESSION['tr_sum_count']['settlementsAmt']=prnpays_crncy2(getNumericValue($post['settlements']),$post['default_currency']);?>");
noOfTransaction.html("<? if(isset($post['noOfTransaction'])) echo $post['noOfTransaction'];?>");
//alert(readyToSettle.html());
//alert(refund_amt.html());
  
</script>

<?  
}

if(isset($_REQUEST['wid']) && trim($_REQUEST['wid'])) unset($_SESSION['tr_sum_count']);
?>


<?
if(isset($_REQUEST['actionAjax']))  db_disconnect();
?>