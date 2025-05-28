<?
if(!isset($data['CONFIGFILE'])){
  include('../config.do');
}

###############################################################################

if(!isset($_SESSION['login'])&&!isset($_SESSION['uid'])){
       echo('ACCESS DENIED!....');
       exit;
}

$uid=@$_SESSION['uid'];

?>
<!-- front_ui/OPAL_IND_UX/user/trans_balance_merchant_ajax.do -->
<?
//if($data['PageName']=="My Settlement")
  { 
	  
		  $total_settlement_processed_amt=0;
		  $total_mdr_amt=0;
		  $total_gst_amt=0;
		  
		  //fetch previous cros db if multiple connection 
		  
		  if(isset($data['PRVIOUS_BALANCE_DB_ENABLE'])&&$data['PRVIOUS_BALANCE_DB_ENABLE']=='Y'&&isset($data['IS_DBCON_DEFAULT'])&&$data['IS_DBCON_DEFAULT']=='Y'&&(!isset($_GET['pd']))) {
				$pbcd=fetch_prvious_balance_cross_db($_SESSION['uid']);
				if(isset($_GET['cp']))print_r($pbcd);
				$total_settlement_processed_amt=getNumericValue($pbcd['total_settlement_processed_amt']);
				$total_mdr_amt=getNumericValue($pbcd['total_mdr_amt']);
				$total_gst_amt=getNumericValue($pbcd['total_gst_amt']);
				$total_amt_refunded_prev=getNumericValue(@$pbcd['total_refund_amt']);
			}
	  
	  
    $uid=@$_SESSION['uid'];

    $wd_calc_version='v1';

    if(isset($data['wd_calc_version'])&&trim($data['wd_calc_version']))
      $wd_calc_version=$data['wd_calc_version'];
    

    if(isset($_REQUEST['a'])&&$_REQUEST['a']=='v2') $wd_calc_version='v2';


    if(isset($wd_calc_version)&&$wd_calc_version=='v1'){

      $trans_detail_array = fetch_trans_balance($_SESSION['uid']);	//FETCH all the transaction from zt_transactions table via membrer id 
      $deduction_array = ms_trans_balance_calc_d_new($_SESSION['uid'],'',0,$trans_detail_array);	//Fetch the transaction / calculation - Only deduction amount fetch of a clients 
    }
    elseif(isset($wd_calc_version)&&$wd_calc_version=='v2') {
      ##############################################################################
        // _wv2

        if((!isset($_SESSION['uid_wv2'.$uid]['trans_detail_array']))||(isset($_REQUEST['actionAjax'])))
        {
          $_SESSION['uid_wv2'.$uid]['trans_detail_array']=$trans_detail_array = fetch_trans_balance_wv2($uid);
        }
        $trans_detail_array=@$_SESSION['uid_wv2'.$uid]['trans_detail_array'];
        
        
        if((!isset($_SESSION['uid_wv2'.$uid]['deduction_array']))||(isset($_REQUEST['actionAjax'])))
        {
          //payout_trans_newf_wv2 trans_balance_newac ms_trans_balance_calc_d_new_wv2

          $_SESSION['uid_wv2'.$uid]['deduction_array']=ms_trans_balance_calc_d_new_wv2($_SESSION['uid'],'',0,@$trans_detail_array,@$data['last_withdraw']);	//Fetch the transaction / calculation - Only deduction amount fetch of a clients 

        }
        $deduction_array=@$_SESSION['uid_wv2'.$uid]['deduction_array'];

        
      ##############################################################################
    }
		
		//Dev Tech : 23-09-29 Real Time calculation fetch as a dynamic from 
		if(isset($wd_calc_version)&&$wd_calc_version=='v1') $post['ab']=$_SESSION['uid_'.$_SESSION['uid']]['ab']=$deduction_array;
		if(isset($wd_calc_version)&&$wd_calc_version=='v2') $post['ab']=$_SESSION['uid_wv2'.$_SESSION['uid']]['ab']=$deduction_array;
		

		$total_mdr 				= stringToNumber($deduction_array['total_mdr']);	//Total MDR
		$total_txn_fee 			= stringToNumber($deduction_array['total_txn_fee']);	//Total Transction Fee
		$total_txn_fee_failed	= stringToNumber($deduction_array['total_txn_fee_failed']);	//Total Transaction fee on failed transaction
		$total_amt_chargeback	= stringToNumber($deduction_array['total_amt_chargeback']);	//Total charge back amount
		$total_chargeback_fee	= stringToNumber($deduction_array['total_chargeback_fee']);	//total charge back fee
		$total_gst_fee			= stringToNumber(@$deduction_array['total_gst_fee']);	//total GST  fee
		$total_amt_refunded		= stringToNumber($deduction_array['total_amt_refunded']);	//Total refunded amount
		$total_amt_cbk1			= stringToNumber($deduction_array['total_amt_cbk1']);	//Total CBK1 amount
		
		if(isset($_GET['cp'])){
			echo "<br/>total_mdr=>".$total_mdr;
			echo "<br/>Prev. total_mdr_amt=>".$total_mdr_amt;
			echo "<br/>------------------------------";
			echo "<br/>total_gst_fee=>".$total_gst_fee;
			echo "<br/>Prev. total_gst_amt=>".$total_gst_amt;
			
		}
		
		//sum if value from previous db
		$total_mdr=$total_mdr+$total_mdr_amt;
		$total_gst_fee=$total_gst_fee+$total_gst_amt;
		 

		$total_deductions = $total_mdr+$total_txn_fee+$total_txn_fee_failed+$total_amt_chargeback+$total_chargeback_fee+$total_amt_refunded+$total_amt_cbk1+$total_gst_fee;	//sum of deduction
	
  //&a=v1&actionAjax=session&actionUI=deduction  
  if(isset($_REQUEST['actionAjax'])&&$_REQUEST['actionAjax']=='session'&&@$_REQUEST['actionUI']!='refundAmount')  
  {

      //Set deduction value via session via V1 
      if(isset($wd_calc_version)&&$wd_calc_version=='v1'){
        $deduction_array_ajax['total_deductions']=@$total_deductions;
        $deduction_array_ajax['total_mdr']=@$total_mdr;
        $deduction_array_ajax['total_gst_fee']=@$total_gst_fee;

          $deduction_array_ajax['total_amt_refunded']=prnpays_crncy2(getNumericValue(@$total_amt_refunded)+@$total_amt_refunded_prev,$post['default_currency']); // Refund Amount

        $_SESSION['uid_wv2'.$uid]['deduction_array_ajax']=@$deduction_array_ajax;
      }

      $payout_array_ajax['summ_mature']=@$post['ab']['summ_mature']; // Ready to Settle
      $payout_array_ajax['summ_withdraw']=prnpays_crncy2(getNumericValue($post['ab']['summ_withdraw'])+$total_settlement_processed_amt,$post['default_currency']); // Settlement Processed
      
      

		  $_SESSION['uid_wv2'.$uid]['payout_array_ajax']=@$payout_array_ajax;

  } 
	
  if(isset($_REQUEST['actionUI'])&&$_REQUEST['actionUI']=='deduction')  
  {
		?>
    <h6>
      <strong>
        <font color="red">
          <?=prnpays_crncy(-$total_deductions,'','',$deduction_array['account_curr']);	// show total deducted amount with currency?>
        </font>
      </strong>
    </h6>
    <h3>MDR:
      <?=prnpays_crncy(-$total_mdr,'','',$deduction_array['account_curr']);	// show total deducted amount with currency?>
      GST:
      <?=prnpays_crncy(-$total_gst_fee,'','',$deduction_array['account_curr']);	// show total GST fee with currency?>
    </h3>
<?  
  }
  elseif(isset($_REQUEST['actionUI'])&&$_REQUEST['actionUI']=='readyToSettle')  
  {
		?>
    <? if(isset($post['ab']['summ_mature'])) echo $post['ab']['summ_mature'];?>
<?  
  }
  elseif(isset($_REQUEST['actionUI'])&&$_REQUEST['actionUI']=='settlementProcessed')  
  {
		?>
    <? if(isset($post['ab']['summ_withdraw'])) echo prnpays_crncy2(getNumericValue($post['ab']['summ_withdraw'])+$total_settlement_processed_amt,$post['default_currency']);?>
<?  
  }
  elseif(isset($_REQUEST['actionUI'])&&$_REQUEST['actionUI']=='refundAmount')  
  {
		?>
    <? if(isset($total_amt_refunded)) echo prnpays_crncy2(getNumericValue(@$total_amt_refunded)+@$total_amt_refunded_prev,$post['default_currency']);?>
<?  
  }
  elseif(isset($_REQUEST['actionUI'])&&$_REQUEST['actionUI']=='readyToSettle_settlementProcessed')  
  {
		?>
   
   
<script type="text/javascript">
if(typeof jQuery == 'undefined') {
  document.write('<script type="text/javascript" src="<?=$data['Host']?>/js/jquery-3.6.0.min.js"><\/script>');        
} 

var readyToSettle = parent.window.$('#read_to_settle_3')
var settlementProcessed = parent.window.$('#settlementProcessed_3');

readyToSettle.html("<? if(isset($post['ab']['summ_mature'])) echo $post['ab']['summ_mature'];?>");
settlementProcessed.html("<? if(isset($post['ab']['summ_withdraw'])) echo prnpays_crncy2(getNumericValue($post['ab']['summ_withdraw'])+$total_settlement_processed_amt,$post['default_currency']);?>");
//alert(readyToSettle.html());
//alert(settlementProcessed.html());
  
</script>

<?  
  }
}?>


<?
if(isset($_REQUEST['actionAjax']))  db_disconnect();
?>