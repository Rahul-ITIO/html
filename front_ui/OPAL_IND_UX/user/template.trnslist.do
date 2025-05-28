<? if(isset($data['ScriptLoaded'])){ ?>
<link href="<?=$data['TEMPATH']?>/common/css/table-responsive_999.css" rel="stylesheet">
<style>
.settle_withdraw , .settle_withdraw2 {display:none !important;}

.pricecolor font[color="green"]{color:#FFCC00;  !important;}
.pricecolor font[color="red"]{color: #CC0000; !important;}
html .s_section select.form-select{-webkit-appearance:none !important;-moz-appearance:none !important;}

[type="date"] {background: #fff url(<?=$data['Host']?>/images/calendar_2.png) 94% 50% no-repeat;background-color: rgb(255, 255, 255);background-color: rgb(255, 255, 255);background-size:18px;}
[type="date"]::-webkit-inner-spin-button {display: none;  width:0px;}
[type="date"]::-webkit-calendar-picker-indicator {opacity: 0; width:30px !important; min-width:30px !important;} 

.datepicker-toggle{float:left;display:inline-block;position:relative;width:18px;height:19px}.datepicker-toggle-button{position:absolute;left:0;top:0;width:100%;height:100%;background:#fff url(<?=$data['Host']?>/images/calendar_2.png);background-size:100%}.datepicker-input{position:absolute;left:0;top:0;width:100%;height:100%;opacity:0;cursor:pointer;box-sizing:border-box}.datepicker-input::-webkit-calendar-picker-indicator{position:absolute;left:0;top:0;width:100%;height:100%;margin:0;padding:0;cursor:pointer}

.rounded-tringle { height: 100px !important;}

</style>
<script>
var NameOfFile ="";	
	<? if(isset($data['NameOfFile'])){ ?>
		NameOfFile ="<?=$data['NameOfFile'];?>";		
	<? } ?>
$(document).ready(function(){
	<?if(isset($_GET['csearch'])&&!empty($_GET['csearch'])){?>
		$('.acc3.advLdiv').trigger('click');
	<?}?>
});
</script>


<div class="container border rounded my-2 row pe-0 me-0">

<div class="heading-buttons vkg1 my-2 "><h4 class="px-2">
<? if($data['PageName']=="My Settlement"){?>
<i class="fa-solid fa-handshake"></i>
<? }else{ ?>
<i class="fas fa-clipboard-list"></i>
<? } ?>
 
<? if($data['PageName']=='statement'){ echo "All Transaction";}else{ echo prntext($data['PageName']);}?></h4>
    

</div>

    <div class="row pe-0" >
	     
      <? if($post['action']=='select'){ ?>
	     <!-- End Transaction Search Bar -->
	
 
   

	<?if($data['PageName']=="My Settlement")
  { 

    $data['CONFIGFILE']=1;
    $data['wd_calc_version']='v2';
	  
    // include trans_balance_merchant_opal_ind_ux_ajax.do
    $trans_balance_merchant_opal_ind_ux_ajax=$data['Path'].'/include/trans_balance_merchant_opal_ind_ux_ajax'.$data['iex'];
    if(file_exists($trans_balance_merchant_opal_ind_ux_ajax)){include($trans_balance_merchant_opal_ind_ux_ajax);}

      /*
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
			}
      */
	  ?>
	
       <div class="row p-0">
	    <div class="col-sm-3 my-2 text-center">
          <div class="card card1 rounded-tringle mx-1 bg-white text-dark">
            <div class="card-body">
              <div class="text-card text-start">
                <h3 class="text-opal">Account Balance</h3>
                <h6><strong><? if(isset($post['ab']['summ_total'])) echo $post['ab']['summ_total'];?></strong></h6>
                <h3>Available</h3>
              </div>
            </div>
          </div>
        </div>
		
        <div class="col-sm-3 my-2 text-center">
          <div class="card card1 rounded-tringle mx-1 bg-white text-dark">
            <div class="card-body">
                <?
              if(isset($_GET['cp'])){
                echo "<br/>Set.Proc.=>".$post['ab']['summ_withdraw'];
                echo "<br/>Prev. Set.Proc.=>".$total_settlement_processed_amt;
                
              }
              ?>
		
              <div class="text-card text-start">
           <h3 class="text-opal">Settlement Processed</h3>
           <h6><strong><? if(isset($post['ab']['summ_withdraw'])) echo prnpays_crncy2(getNumericValue($post['ab']['summ_withdraw'])+$total_settlement_processed_amt,$post['default_currency']);?></strong></h6>
		   <h3>Transactions Settled.</h3>
              </div>
            </div>
          </div>
        </div>
		
		<? 
    /*
    $uid=@$_SESSION['uid'];

    $wd_calc_version='v2';

    if(isset($_REQUEST['a'])&&$_REQUEST['a']=='v1') $wd_calc_version='v1';
    elseif(isset($_REQUEST['a'])&&$_REQUEST['a']=='v2') $wd_calc_version='v2';


    if(isset($wd_calc_version)&&$wd_calc_version=='v1'){

      $trans_detail_array = fetch_trans_balance($_SESSION['uid']);	//FETCH all the transaction from zt_transactions table via membrer id 
      $deduction_array = ms_trans_balance_calc_d_new($_SESSION['uid'],'',0,$trans_detail_array);	//Fetch the transaction / calculation - Only deduction amount fetch of a clients 
    }
    elseif(isset($wd_calc_version)&&$wd_calc_version=='v2') {
      ##############################################################################
        // _wv2
      
        //withdraw v2 function 
        //$function_gw_wv2=$data['Path'].'/function_gw/function_gw_wv2'.$data['iex'];
        //if(file_exists($function_gw_wv2)){include($function_gw_wv2);}	

        if(!isset($_SESSION['uid_wv2'.$uid]['trans_detail_array']))
        {
          $_SESSION['uid_wv2'.$uid]['trans_detail_array']=$trans_detail_array = fetch_trans_balance_wv2($uid);
        }
        $trans_detail_array=@$_SESSION['uid_wv2'.$uid]['trans_detail_array'];
        
        
        if(!isset($_SESSION['uid_wv2'.$uid]['deduction_array']))
        {
          //payout_trans_newf_wv2 trans_balance_newac ms_trans_balance_calc_d_new_wv2

          $_SESSION['uid_wv2'.$uid]['deduction_array']=ms_trans_balance_calc_d_new_wv2($_SESSION['uid'],'',0,@$trans_detail_array);	//Fetch the transaction / calculation - Only deduction amount fetch of a clients 

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
		
    */

    //If session value from ajax 
		$deduction_array_ajax=[];
    if(isset($_SESSION['uid_wv2'.$uid]['deduction_array_ajax'])) $deduction_array_ajax=@$_SESSION['uid_wv2'.$uid]['deduction_array_ajax'];
		
		?>
        <div class="col-sm-3 my-2 text-center ">
          <div class="card card1 rounded-tringle mx-1 bg-white text-dark">
            <div class="card-body cursor-pointer"
    onClick="ajaxf1(this,'<?=@$data['Host']?>/include/trans_balance_merchant_opal_ind_ux_ajax<?=@$data['ex'];?>?a=v1&actionAjax=session&actionUI=deduction','#total_total_deductions_calc_2','1','2')"
    title="Click here for view the Total Deductions" data-bs-toggle="tooltip" data-bs-placement="top">
              <div class="text-card text-start cursor-pointer">
                <h3 class="text-opal cursor-pointer">Total Deductions</h3>
                <div id="total_total_deductions_calc_2">
                  <?if(isset($deduction_array_ajax['total_deductions'])&&trim($deduction_array_ajax['total_deductions'])){?>
                    <h6><strong><font color="red">
                    <?=prnpays_crncy(-@$deduction_array_ajax['total_deductions'],'','',$deduction_array['account_curr']);	// show total deducted amount with currency?>
                    </font></strong></h6>
                    <h3>MDR: <?=prnpays_crncy(-@$deduction_array_ajax['total_mdr'],'','',$deduction_array['account_curr']);	// show total deducted amount with currency?> 
                    GST: <?=prnpays_crncy(-@$deduction_array_ajax['total_gst_fee'],'','',$deduction_array['account_curr']);	// show total GST fee with currency?>
                    </h3>
                  <?}else{?>
                    <i class="<?=@$data['fwicon']['view'];?>"></i>
                  <?}?>
                </div>
              </div>
            </div>
          </div>
        </div>
		<div class="col-sm-3 my-2 text-center ">
          <div class="card card1 rounded-tringle mx-1 bg-white text-dark">
            <div class="card-body">
              <div class="text-card text-start">
                <h3 class="text-opal">Pending Settlement</h3>
                <h6><strong><? if(isset($post['ab']['summ_immature'])) echo $post['ab']['summ_immature'];?></strong></h6>
				<div>&nbsp;</div>
              </div>
            </div>
          </div>
        </div>
	  </div>
	  
	  <div class="row p-0">
	      <div class="col-sm-12 mb-2 text-center">
          <div class="card card1 rounded-tringle mx-1 bg-white text-dark">
            <div class="card-body">
              <div class="text-card row">
           <div class="w-75 text-start">
		  <div class="text-opal"><i class="fa-solid fa-wallet"></i> <strong >Ready to Settle</strong></div>
		  <div class="ms-3"><strong><? if(isset($post['ab']['summ_mature'])) echo $post['ab']['summ_mature'];?></strong></div>
		  <div class="ms-3">(As on <?=date("d M Y");?>)</div>
		  </div>
		       <div class="w-25"><? if(isset($data['NameOfFile'])){ ?>
          <? if($data['withdraw_gmfa']){ 
            
            if(isset($data['WITHDRAW_INITIATE_SYSTEM_WV2'])&&$data['WITHDRAW_INITIATE_SYSTEM_WV2']=='Y'&&@$_REQUEST['a']!='o')
            {
              $trans_withdraw_url='trans_withdraw-fund_system_v2';
            }
            else $trans_withdraw_url='trans_withdraw-fund';
            
            ?>
          <a href="<?=$data['USER_FOLDER']?>/<?=@$trans_withdraw_url?><?=$data['ex']?>" 
						onClick="javascript:$('#modalpopup_form_popup').show(200);"  class="btn btn-primary mt-3 text-dark" style=" background-color:#ffa800 !important;" title="Settle Now"><i class="fa-solid fa-handshake"></i> Settle Now</a>
          <? }else{ ?>
          <a onClick="confirm_2mfa('You are required to Activate 2 Factor Authentication (2FA) to access the withdrawal section. Click on OK button to setup 2 Factor Authontication (2FA) now.','<?=$data['USER_FOLDER']?>/two-factor-authentication<?=$data['ex']?>');" class="btn btn-primary text-dark my-1" style=" background-color:#ffa800 !important;" title="Settle Now"><i class="fa-solid fa-handshake"></i> Settle Now</a>
          <? } ?>
          <? }?></div>
              </div>
            </div>
          </div>
        </div>
		  </div>
	  
	<?
  }?>


<!-- Transaction Search Bar -->
	 
  <?
  //search form
  $search_form=("../front_ui/{$data['frontUiName']}/common/template.search_form".$data['iex']);
	if(file_exists($search_form)){
		include($search_form);
	}
	else{
		$search_form=("../front_ui/default/common/template.search_form".$data['iex']);
		if(file_exists($search_form)){
			include($search_form);
		}
	}
  ?>
  
  
 
  <div style="clear:both;"></div>
  
  <div class="widget-bodyx row">
 
	
    <? if(isset($_SESSION['action_success'])&&$_SESSION['action_success']){ ?>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
      <?=$_SESSION['action_success'];?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <? $_SESSION['action_success']=0; } 
	  $cnttot=count($post['Transactions']);
	  ?>
	  
	  
    <div class="table-responsive">
	
	
	
	
	  <?
		//include file for payin tras list as per json 
		$payin_trnslist_from_theme=("../front_ui/{$data['frontUiName']}/common/template.trnslist_dynamic".$data['iex']);
		
		$payin_trnslist_from_default=("../front_ui/default/common/template.trnslist_dynamic".$data['iex']);
		if(file_exists($payin_trnslist_from_theme)){
			include($payin_trnslist_from_theme);
		}elseif(file_exists($payin_trnslist_from_default)){
			include($payin_trnslist_from_default);
		}
	?>
	
	
	
	  
	  
      <?php if($cnttot == 0) { ?>
      <div><img title="No Transaction Found" src="<?=$data['Host']?>/images/not_transaction_found.png" style="width:100%;padding:0;" class="img-fluid" /></div>
      <? } ?>
      
      <div class="pagination" style="float:left; width:100%; text-align:center;" id="total_record_result">
        <?php
			//if(!isset($_SESSION['total_record_result']))
			more_db_conf_pages('prev_pg');	
			if(!isset($_GET['tscount']))
			{
				include("../include/pagination_new".$data['iex']);
				
				if(isset($_GET['page'])){$page=$_GET['page'];unset($_GET['page']);}else{$page=1;}
				$get=http_build_query($_GET);
				$url=$data['USER_FOLDER']."/{$data['FileName']}?".$get;
				$total = (int)$data['tr_count'];
				short_pagination($data['MaxRowsByPage'],$page,$url,$data['last_record']);
			}
			else
			{
				include("../include/pagination_pg".$data['iex']);
				
				
				if(isset($_REQUEST['cl'])){unset($_REQUEST['cl']);}
				
				if(isset($_REQUEST['page'])){$page=$_REQUEST['page'];unset($_REQUEST['page']);}else{$page=1;}
				if(isset($_REQUEST['tscount'])){$tscount=$_REQUEST['tscount'];unset($_REQUEST['tscount']);}else {$tscount=0;}
			
				$get=http_build_query($_REQUEST);
			
                // $url="transactions".$data['ex']."?".$get;

				$url=$data['USER_FOLDER']."/{$data['FileName']}?".$get;

				if(isset($post['bid'])){$url.="&bid=".$post['bid'];}
				if(isset($post['type'])){$url.="&type=".$post['type'];}
				if(isset($post['status'])){$url.="&status=".$post['status'];}
				if(isset($post['action'])){$url.="&action=select";}
				if(isset($post['order'])){$url.="&order=".$post['order'];}
				if(isset($post['searchkey'])){$url.="&searchkey=".$post['searchkey'];}
				
				if(isset($_GET['page'])){$page=$_GET['page'];}else{$page=1;}
				
				pagination($data['MaxRowsByPage'],$post['StartPage'],$url,$tscount);
			}
			
			more_db_conf_pages('next_pg');
			//more_db_conf_pages();
			
			?>

      </div>
    </div>
  </div>
  <? if(isset($data['NameOfFile'])){ ?>
  <div style="float:left;clear:both;width:100%;text-align:center;">
    <script> 
	function confirm_2mfa(theTitle,theUrl){
	let is2mfa = confirm(theTitle);
	if(is2mfa){
	window.location.href=theUrl;
	}
	}
</script>
  </div>
  <? } ?>
  
	
      <? }elseif($post['action']=='details'){ ?>
      <div class="table-responsive">
        <table>
          <tr>
            <td class="capl" colspan="2"><B>Transaction Details</B></td>
          </tr>
          <tr>
            <td class="capl" colspan="2"><HR></td>
          </tr>
          <tr>
            <td class="field" width="50%" nowrap>Date of Trade:</td>
            <td class="input" width="50%" nowrap><?=prndate($post['Transaction']['tdate'])?></td>
          </tr>
          <tr>
            <td class="field" nowrap>Username,
              <?=prntext($data['Currency'])?>
              :</td>
            <td class="input" nowrap><? if($post['Transaction']['userid']>0){ ?>
              <a href="userinfo<?=$data['ex']?>?id=<?=$post['Transaction']['userid']?><? if(isset($post['StartPage'])){ ?>&page=<?=$post['StartPage']?><? } ?>&action=view">
              <?=$post['Transaction']['username']?>
              </a>
              <? }else{ ?>
              <?=prntext($post['Transaction']['username'])?>
              <? } ?></td>
          </tr>
          <tr>
            <td class="field" nowrap>Amount,
              <?=prntext($data['Currency'])?>
              :</td>
            <td class="input" nowrap><?=$post['Transaction']['amount']?></td>
          </tr>
          <tr>
            <td class="field" nowrap>Fee,
              <?=prntext($data['Currency'])?>
              :</td>
            <td class="input" nowrap><?=prnfees($post['Transaction']['fees'])?></td>
          </tr>
          <tr>
            <td class="field" nowrap>Paid,
              <?=prntext($data['Currency'])?>
              :</td>
            <td class="input" nowrap><?=$post['Transaction']['nets']?></td>
          </tr>
          <tr>
            <td class="field" nowrap>Type:</td>
            <td class="input" nowrap><?=$post['Transaction']['type']?></td>
          </tr>
          <tr>
            <td class="field" nowrap>Status:</td>
            <td class="input" nowrap><?=$post['Transaction']['status']?></td>
          </tr>
          <tr>
            <td class="field" nowrap>Description:</td>
            <td class="input"><?=prntext($post['Transaction']['comments'])?></td>
          </tr>
          <? if($post['Transaction']['ecomments']){ ?>
          <tr>
            <td class="capl" colspan="2" nowrap>ADDITIONAL INFORMATION</td>
          </tr>
          <tr>
            <td class="input" colspan="2"><br>
              <pre class=info><?=prntext($post['Transaction']['ecomments'])?>
</pre></td>
          </tr>
          <? } ?>
          <tr>
            <td class="capl" colspan="2"><B>BUYER'S DETAIL</B></td>
          </tr>
          <tr>
            <td class="capl" colspan="2"><HR></td>
          </tr>
          <tr>
            <td class="field" nowrap>Customer Name:</td>
            <td class="input" nowrap><? if($post['Transaction']['userid']>0){ ?>
              <a href="userinfo<?=$data['ex']?>?id=<?=$post['Transaction']['userid']?><? if(isset($post['StartPage'])){ ?>&page=<?=$post['StartPage']?><? } ?>&action=view">
              <?=$post['Transaction']['names']?>
              </a>
              <? }else{ ?>
              <?=prntext($post['Transaction']['names'])?>
              <? } ?></td>
          </tr>
          <tr>
            <td class="field" nowrap>Customer Address:</td>
            <td class="input" nowrap><?php if($post['Transaction']['address']){ ?>
              <?=$post['Transaction']['address']?>
              -
              <?=$post['Transaction']['city']?>
              (
              <?=$post['Transaction']['state']?>
              )
              <?=$post['Transaction']['zip']?>
              <?php } ?></td>
          </tr>
          <tr>
            <td class="field" nowrap>Last four digits of card used:</td>
            <td class="input" nowrap><?php if($post['Transaction']['card']){ ?>
              <?php 
					$ccno = $post['Transaction']['card'];
					$string_ccno = substr($ccno,12,16);
					echo "XXXXXXXXXXXX".$string_ccno; ?>
              <?php } ?>
            </td>
          </tr>
          <tr>
            <td class="field" nowrap>Phone number:</td>
            <td class="input" nowrap><?=$post['Transaction']['phone_no']?></td>
          </tr>
          <tr>
            <td class="field" nowrap>Email address:</td>
            <td class="input" nowrap><?=$post['Transaction']['email_add']?></td>
          </tr>
          <tr>
            <td class="capc" colspan="8"><? if($post['Transaction']['canrefund']){ ?>
              <a href="<?=$data['USER_FOLDER']?>/<?=$data['FileName']?>?id=<?=$post['Transaction']['id']?><? if($post['StartPage']){ ?>&page=<?=$post['StartPage']?><? } ?>&action=refund" onclick="return cfmform()">REFUND</a>&nbsp;|&nbsp;
              <? } ?>
              <a href="javascript:history.back()">BACK</a></td>
          </tr>
        </table>
      </div>
      <? }else if($post['action']=='search'){ ?>
      <form method="post">
        <input type="hidden" name="action" value="<?=$post['action']?>">
        <input type="hidden" name="page" value="<?=$post['StartPage']?>">
        <div class="table-responsive">
          <table>
            <tr>
              <td class="capc" colspan="2">SEARCH OPTIONS</td>
            </tr>
            <tr>
              <td class="field" nowrap><label for=field1>Search by the username
                <input type="radio" class="checkbox" id="field1" name="field" value="username" checked onclick="username.disabled=false;day.disabled=true;month.disabled=true;year.disabled=true">
                </label></td>
              <td class="input"><input type="text" name="username" size="40" maxlength="255"></td>
            </tr>
            <tr>
              <td class="field" nowrap><label for=field2>Search by the date
                <input type="radio" class="checkbox" id="field2" name="field" value="tdate" onclick="username.disabled=true;day.disabled=false;month.disabled=false;year.disabled=false">
                </label></td>
              <td class="input"><select name="day" class="form-select" disabled>
                  <?=showselect($data['StatDays'], $post['day'])?>
                </select>
                &nbsp;
                <select name="month" class="form-select" disabled>
                  <?=showselect($data['StatMonth'], $post['month'])?>
                </select>
                &nbsp;
                <select name="year" class="form-select" disabled>
                  <?=showselect($data['StatYear'], $post['year'])?>
                </select></td>
            </tr>
            <tr>
              <td class="capc" colspan="2"><input type="submit" class="submit" name="cancel" value="BACK">
                &nbsp;
                <input type="submit" class="submit" name="search" value="SEARCH NOW!"></td>
            </tr>
          </table>
        </div>
      </form>
      <? } ?>
     
   </div> 



<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
