<?php
$address_con=$post['address_con'];
$card_con=$post['card_con'];
$is_admin=$post['is_admin'];
$rParam1=$post['rParam1'];
$json_value=$post['json_value'];
$json_value1=($post['json_value1']);
$bankName=$post['bankName'];
$upi_vpa_lable=$post['upi_vpa_lable'];
$upi_vpa=$post['upi_vpa'];

$trans_href=$post['trans_href'];
$trans_datah=$post['trans_datah'];
$trans_target=$post['trans_target'];
$trans_class=$post['trans_class'];


?>

<!DOCTYPE>
<html>

<style>
/*css for inline page title / underline / modal /button etc*/
.addrembtn{margin-top: -67px; margin-bottom:0px; width:100% !important;}
.commentrow .title2{margin-top:5px;}
.addremarkform {display: none;}
.listActive1, .listActive1 td, .listActive1 td, .listActive1 a, .listActive1 font {}

.rmk_date {
	float: unset;
    width: 112px;
    display: table-cell;
	}
.rmk_row {
	margin: 0px;
    padding: 0px;
    width: 100%;
    clear: both;
    display: table;
	}
	
.rmk_msg{
/*width:calc(100% - 180px)!important;
word-wrap: break-word !important;*/
}
.modal-body .row {
    --bs-gutter-x: 0rem !important;
}

button.btn-close {position: absolute;right: 13px;z-index: 999999;}
.modal-body .col-sm-9 {text-indent: -7px;}
.card { background:unset !important; background:var(--color-3)!important;}
<? if(strstr($_SESSION['root_background_color'],"gradient")){?>
.vkg-underline-red { border-bottom: 5px solid <?=$_SESSION['background_gd4'];?> !important; }
<? } else{ ?>
.vkg-underline-red { border-bottom: 5px solid var(--background-1)!important; }
<? } ?>
	
</style>
</head>
<body>
<div class="container22 my-0  t_row" id="cssfortrpop">
<? if($post['ViewMode']=='details'){ ?>
		<? if($post['TransactionDetails']['ch_id']){
		  
		 ?>
	
	<div class="row">
    <div class="col-sm-12">
			<div id="addremarkform" class="addremarkform comtabdiv addremarkform_tab vnext">
			  <form method="post"  action=<?=$trans_href;?>  target="hform">
				<input type="hidden" name="action" value="addremark">
				<input type="hidden" name="gid" value="<?=$post['TransactionDetails']['id']?>">
				<input type="hidden" name="page" value="<?=$post['StartPage']?>">
				
				<textarea required name="remark" placeholder="Leave your Message" class="span11 remarkcoment form-control" cols=40 rows=6 style="width:89%;height:50px;float:left;margin-right:10px"><?=prntext($post['remark'])?></textarea>
				<? if($is_admin&&((isset($_SESSION['login_adm']))||(isset($_SESSION['t_add_remark'])&&$_SESSION['t_add_remark']==1))){ ?>
				<div class="replytype is_admin">
				  <input type="radio" name="reply_type" value="support" id="support<?=$post['TransactionDetails']['id']?>"  style="min-width:16px;" checked="checked" >
				  <label for="support<?=$post['TransactionDetails']['id']?>">&nbsp;&nbsp;Support Note</label>
				  <br/>
				  <input type="radio" name="reply_type" value="system" id="system<?=$post['TransactionDetails']['id']?>" style="min-width:16px;">
				  <label for="system<?=$post['TransactionDetails']['id']?>">&nbsp;&nbsp;System Note</label>
				</div>
				<? } ?>
				<button type=submit name=send value="CONTINUE"  class="add_remark_submit btn btn-icon btn-primary glyphicons circle_ok pull-left" style="float:left;margin:7px 0 0 0px;"><i></i>Add Remark</button>
			  </form>
			</div>
	</div>
	
	 <div class="col-sm-12 border rounded">
			<div class="row m-2">
			  <h6 class="vkg-underline-red">Transaction Details</h6>
			   <div class="row">
				<div class="col-sm-3">Store Details </div>
				<div class="col-sm-9">:
				<? if($is_admin){ ?>
				  <a onClick="iframe_open_modal(this);" class="database_plus" data-mid="<?=$post['TransactionDetails']['receiver']?>" data-href="" data-tabname="" data-url="" data-ihref="<?=$data['Host'];?>/user/store<?=$data['ex']?>?admin=1&mid=<?=$post['TransactionDetails']['receiver']?>&id=<?=$post['TransactionDetails']['store_id']?>&action=view" title="View Store Details" ><?=$post['TransactionDetails']['store_id']?></a>
				 <? }else{ ?>
					<a class="database_plus" href="<?=$data['Host'];?>/user/store<?=$data['ex']?>?id=<?=$post['TransactionDetails']['store_id']?>&action=view" target="_blank" title="View Store Details" ><?=$post['TransactionDetails']['store_id']?></a>
				 <? } ?>
				  
				  
				  <? if($post['TransactionDetails']['bussiness_url']){ ?>
					 (<?=$post['TransactionDetails']['bussiness_url']?>)
				  <? } ?>
				  
				</div>
			  </div>
			  <? if($is_admin){ ?>
			  
			  <div class="row is_admin">
				<div class="col-sm-3">Source Url</div>
				<div class="col-sm-9 text-break">:
				  <?=$post['TransactionDetails']['source_url']?><? if($post['TransactionDetails']['tableid']){ ?>&tableid=<?=$post['TransactionDetails']['tableid']?> <? } ?>
				</div>
			  </div>
			  
			  <? if((isset($post['TransactionDetails']['bussiness_url'])&&$post['TransactionDetails']['bussiness_url'])){ ?>

				<div class="col-sm-3">Business URL</div>
				<div class="col-sm-9">: <? if($is_admin){ ?>
				  <a <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_add_stores'])&&$_SESSION['merchant_action_add_stores']==1)){ ?> onClick="iframe_open_modal(this);" class="database_plus" data-mid="<?=$post['TransactionDetails']['receiver']?>" data-href="" data-tabname="" data-url="" data-ihref="<?=$data['Host'];?>/user/store<?=$data['ex']?>?admin=1&mid=<?=$post['TransactionDetails']['receiver']?>&id=<?=$post['TransactionDetails']['store_id']?>&action=view&gid=<?=$post['TransactionDetails']['receiver']?>&tempui=<?=$data['frontUiName']?>" <? } ?> title="View Store Details" >
				  <span class="badge bg-primary text-white"><?=$post['TransactionDetails']['store_id']?></span></a>
				 <? }else{ ?>
					<? if((strpos($_SESSION['themeName'],'LeftPanel')!==false)&&($is_admin==false)){ ?>
		
					<? }else{ ?>
	
					<a  >
					 <?=$post['TransactionDetails']['store_id']?></a>
					<? } ?>
				 <? } ?>
				 
				  
				  <? if($post['TransactionDetails']['bussiness_url']){ ?>
					 (<?=$post['TransactionDetails']['bussiness_url']?>)
				  <? } ?>
				  
				</div>

			  <? } ?>
			  
				  <? if($post['TransactionDetails']['dba_brand_name']){ ?>
					  <div class="row is_admin">
						<div class="col-sm-3">DBA/Brand</div>
						<div class="col-sm-9">: <?=$post['TransactionDetails']['dba_brand_name']?>
						</div>
					  </div>
				  <? } ?>
			  <div class="row is_admin" style="display:none;background:#e4e3e3;">
						<div class="row">
							<div class="col-sm-3">ID</div>
							<div class="col-sm-9">: <?=$post['TransactionDetails']['id']?>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-3">Store Details</div>
							<div class="col-sm-9">: <?=$post['TransactionDetails']['store_id']?>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-3">Notify Url</div>
							<div class="col-sm-9">: <?=$post['TransactionDetails']['notify_url']?>
							</div>
						</div>
						
						<div class="row">
							<div class="col-sm-3">Success Url</div>
							<div class="col-sm-9">: <?=$post['TransactionDetails']['success_url']?>
							</div>
					  </div>
					  <div class="row">
						<div class="col-sm-3">Failed Url</div>
						<div class="col-sm-9">: <?=$post['TransactionDetails']['failed_url']?>
						</div>
					  </div>
				 </div>
			  <? } ?>
			  <? if($is_admin){ ?>
			  <div class="row txn_detail is_admin">
				<div class="col-sm-3">Date of Transaction</div>
				<div class="col-sm-9">: <?=prndate($post['TransactionDetails']['tdate'])?>
				</div>
			  </div>
			  <? } ?>
			  <div class="row">
				<div class="col-sm-3">Payment Type</div>
				<div class="col-sm-9">: <?=$data['t'][$post['TransactionDetails']['typenum']]['name2']?>
				</div>
			  </div>
			  <div class="row">
				<div class="col-sm-3">Full Name</div>
				<div class="col-sm-9">: <?
					if(isset($post['TransactionDetails']['ch_fullname'])&&$post['TransactionDetails']['ch_fullname'])
						echo $post['TransactionDetails']['ch_fullname'];
					else
					{?>
						<?=$post['TransactionDetails']['ch_fname'];?>
						<?=$post['TransactionDetails']['ch_lname'];?>
					<?
					}?>
				</div>
			  </div>
			  <div class="row">
				<div class="col-sm-3">Address</div>
				<div class="col-sm-9">: <?=str_replace(',',' ',$post['TransactionDetails']['ch_address'])?>
				  <?=str_replace(',',' ', $post['TransactionDetails']['ch_address2'])?>
				</div>
			  </div>
			  <div class="row">
				<div class="col-sm-3">City</div>
				<div class="col-sm-9">: <?=$post['TransactionDetails']['ch_city']?>
				</div>
			  </div>
			  <div class="row">
				<div class="col-sm-3">State</div>
				<div class="col-sm-9">: <? $pur_state = explode('-',$post['TransactionDetails']['ch_state']); ?>
				  <?=$pur_state[1]?>
				  [
				  <?=$pur_state[0]?>
				  ] </div>
			  </div>
			  <div class="row">
				<div class="col-sm-3">Zip Code</div>
				<div class="col-sm-9">: <?=$post['TransactionDetails']['ch_zip']?>
				</div>
			  </div>
			  <div class="row">
				<div class="col-sm-3">Buyer Phone</div>
				<div class="col-sm-9">: <a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select&type=11&status=-1&keyname=5&searchkey=<?=$post['TransactionDetails']['ch_phone']?>">
				  <?=$post['TransactionDetails']['ch_phone']?>
				  </a></div>
			  </div>
			  <div class="row">
				<div class="col-sm-3">Buyer Email</div>
				<div class="col-sm-9">: <a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select&type=11&status=-1&keyname=3&searchkey=<?=$post['TransactionDetails']['ch_email']?>">
				  <?=$post['TransactionDetails']['ch_email']?>
				  </a></div>
			  </div>
			  
			  <? if($post['TransactionDetails']['txn_id']&&$is_admin&&((isset($_SESSION['login_adm']))||(isset($_SESSION['txn_detail'])&&$_SESSION['txn_detail']==1))){ ?>
			  <div class="row">
				<div class="col-sm-3">Acquirer Id</div>
				<div class="col-sm-9">: <?=$post['TransactionDetails']['txn_id']?>
				</div>
			  </div>
			  <? } ?>
			  
			 
			  
			  <div class="row">
				<div class="col-sm-3">Descriptor</div>
				<div class="col-sm-9">: <?=$post['TransactionDetails']['ch_memo']?>
				</div>
			  </div>
			 
			</div>
	</div> 
	
	 <div class="col-sm-12 border rounded my-2">
			<div class="row m-2">
			  <h6 class="vkg-underline-red">Buyer'S Bank Detail</h6>
			  <div class="row" >
				<div class="col-sm-3">ABA No.</div>
				<div class="col-sm-9">: <a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select&type=11&status=-1&keyname=6&searchkey=<?=$post['TransactionDetails']['ch_routing']?>">
				  <?=$post['TransactionDetails']['ch_routing']?>
				  </a></div>
			  </div>
			  <div class="row" >
				<div class="col-sm-3">Bank Name </div>
				<div class="col-sm-9">: <?=$post['TransactionDetails']['ch_bank_name']?>
				</div>
			  </div>
			  <div class="row" >
				<div class="col-sm-3">Bank Address</div>
				<div class="col-sm-9">: <?=str_replace(',',' ', $post['TransactionDetails']['ch_bank_address'])?>
				</div>
			  </div>
			  <div class="row" >
				<div class="col-sm-3">Bank City</div>
				<div class="col-sm-9">: <?=$post['TransactionDetails']['ch_bank_city']?>
				</div>
			  </div>
			  <div class="row" >
				<div class="col-sm-3">Bank State</div>
				<div class="col-sm-9">: <?=$post['TransactionDetails']['ch_bank_state']?>
				</div>
			  </div>
			  <div class="row" >
				<div class="col-sm-3">Buyer'S Bank Detail</div>
				<div class="col-sm-9">: <?=$post['TransactionDetails']['ch_bank_zipcode']?>
				</div>
			  </div>
			  <? if($post['TransactionDetails']['ch_bank_phone']){ ?>
				<div class="row" >
				  <div class="col-sm-3">Bank Phone</div>
				  <div class="col-sm-9">: <?=$post['TransactionDetails']['ch_bank_phone']?>
				  </div>
				</div>
				<? } ?>
			  <div class="row" >
				<div class="col-sm-3">Account No.</div>
				<div class="col-sm-9">: <? if(isset($_SESSION['login_adm'])){ ?> 
				  <a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select&type=11&status=-1&keyname=7&searchkey=<?=$post['TransactionDetails']['ch_bankaccount']?>">
					<?=$post['TransactionDetails']['ch_bankaccount']?>
				  </a>
				<? }else{ ?>
					<? if((isset($_SESSION['t_bank_account_in_check'])&&$_SESSION['t_bank_account_in_check']==1)){ ?>
						<?php if($post['TransactionDetails']['ch_bankaccount']){echo ccnois($post['TransactionDetails']['ch_bankaccount']);} ?>
					<? } ?>
				<? } ?>
				  
				  
				 
				</div>
			  </div>
			  <div class="row" >
				<div class="col-sm-3">Check No.</div>
				<div class="col-sm-9">: <?=$post['TransactionDetails']['ch_echecknumber']?>
				</div>
			  </div>
			  
			  
			   <div class="row" >
				<div class="col-sm-3">Order Amount (<?=$post['TransactionDetails']['curr_nam']?>)</div>
				<div class="col-sm-9">: <a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select<? if(isset($type)){ ?>&type=<?=$type?><? } ?>&status=-1&keyname=4&searchkey=<?=$post['TransactionDetails']['oamount']?>">
				  <?=$post['TransactionDetails']['amount']?>
				  </a></div>
			  </div>
			 
	<? if(($is_admin)&&((isset($_SESSION['login_adm']))||(isset($_SESSION['t_calculation_row'])&&$_SESSION['t_calculation_row']==1))){ ?>
			 
			  <? if($post['TransactionDetails']['transaction_amt']){ ?>
				  <div class="row" >
					<div class="col-sm-3">Transaction Amount (<?=$post['TransactionDetails']['curr_transaction_amount']?>)</div>
					<div class="col-sm-9">: <?=$post['TransactionDetails']['transaction_amount'];?></div>
				  </div>
			 <? } ?>
			  <? if($post['TransactionDetails']['mdr_amt']&&$post['TransactionDetails']['mdr_amt']!="0"){ ?>
				  <div class="row" >
					<div class="col-sm-3">Discount Rate (<?=$post['TransactionDetails']['curr_transaction_amount']?>)</div>
					<div class="col-sm-9">: <?=$post['TransactionDetails']['mdr_amt2'];?></div>
				  </div>
			 <? } ?>
			 <? if($post['TransactionDetails']['mdr_txtfee_amt']&&$post['TransactionDetails']['mdr_txtfee_amt']!="0"){ ?>
				  <div class="row" >
					<div class="col-sm-3">Transaction Fee (<?=$post['TransactionDetails']['curr_transaction_amount']?>)</div>
					<div class="col-sm-9">: <?=$post['TransactionDetails']['mdr_txtfee_amt2'];?></div>
				  </div>
			 <? } ?>
			 <? if($post['TransactionDetails']['rolling_amt']&&$post['TransactionDetails']['rolling_amt']!="0"){ ?>
				  <div class="row" >
					<div class="col-sm-3">Rolling Fee (<?=$post['TransactionDetails']['curr_transaction_amount']?>)</div>
					<div class="col-sm-9">: <?=$post['TransactionDetails']['rolling_amt2'];?></div>
				  </div>
			 <? } ?>
			 <? if($post['TransactionDetails']['mdr_cbk1_amt']&&$post['TransactionDetails']['mdr_cbk1_amt']!="0"){ ?>
				  <div class="row" >
					<div class="col-sm-3">Predispute Fee (<?=$post['TransactionDetails']['curr_transaction_amount']?>)</div>
					<div class="col-sm-9">: <?=$post['TransactionDetails']['mdr_cbk1_amt2'];?></div>
				  </div>
			 <? } ?>
			 <? if($post['TransactionDetails']['mdr_refundfee_amt']&&$post['TransactionDetails']['mdr_refundfee_amt']!="0"){ ?>
				  <div class="row" >
					<div class="col-sm-3"><?=$data['TransactionStatus'][$post['TransactionDetails']['ostatus']];?> Fee (<?=$post['TransactionDetails']['curr_transaction_amount']?>)</div>
					<div class="col-sm-9">: <?=$post['TransactionDetails']['mdr_refundfee_amt2'];?></div>
				  </div>
			 <? } ?>
			 <? if($post['TransactionDetails']['mdr_cb_amt
']&&$post['TransactionDetails']['mdr_cb_amt']!="0"){ ?>
				  <div class="row" >
					<div class="col-sm-3"><?=$data['TransactionStatus'][$post['TransactionDetails']['ostatus']];?> Fee (<?=$post['TransactionDetails']['curr_transaction_amount']?>)</div>
					<div class="col-sm-9">: <?=$post['TransactionDetails']['mdr_cb_amt2'];?></div>
				  </div>
			 <? } ?>
			 <? if((isset($post['TransactionDetails']['pay_txn'])&&$post['TransactionDetails']['pay_txn'])){ ?>
			  <div class="row" >
				<div class="col-sm-3">Payout Amount. (<?=$post['TransactionDetails']['curr_transaction_amount']?>)</div>
				<div class="col-sm-9">: <a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select<? if(isset($type)){ ?>&type=<?=$type?><? } ?>&status=-1&keyname=20&searchkey=<?=$post['TransactionDetails']['payable_amt_of_txn']?>">
				  <?=$post['TransactionDetails']['payable_amt_of_txn']?>
				  </a></div>
			  </div>
			 <? } ?>
			 
			<? if($post['TransactionDetails']['available_balance_amt']){ ?>
				  <div class="row" >
					<div class="col-sm-3">Balance (<?=$post['TransactionDetails']['curr_transaction_amount']?>)</div>
					<div class="col-sm-9">: <b><?=$post['TransactionDetails']['available_balance'];?></b></div>
				  </div>
			<? } ?>
			<? if($post['TransactionDetails']['payout_date']){ ?>
				<div class="row" >
					<div class="col-sm-3">Mature Date</div>
					<div class="col-sm-9">: <b><?=prndate($post['TransactionDetails']['payout_date']);?></b></div>
				</div>
			<? } ?>
	<? } ?>	  
			  <div class=nomanditory>
				<? if($post['TransactionDetails']['ch_company_name']){ ?>
				<div class="row" >
				  <div class="col-sm-3">Company Name </div>
				  <div class="col-sm-9">: <?=$post['TransactionDetails']['ch_company_name']?>
				  </div>
				</div>
				<? } if($post['TransactionDetails']['ch_employee_number']){ ?>
				<div class="row" >
				  <div class="col-sm-3">Employee No.</div>
				  <div class="col-sm-9">: <?=$post['TransactionDetails']['ch_employee_number']?>
				  </div>
				</div>
				<? } if($post['TransactionDetails']['ch_client_location']){ ?>
				<div class="row" >
				  <div class="col-sm-3">Client Location</div>
				  <div class="col-sm-9">: <?=$post['TransactionDetails']['ch_client_location']?>
				  </div>
				</div>
				<? } if($post['TransactionDetails']['ch_middle_initial']){ ?>
				<div class="row" >
				  <div class="col-sm-3">Middle Initial</div>
				  <div class="col-sm-9">: <?=$post['TransactionDetails']['ch_middle_initial']?>
				  </div>
				</div>
				<? } if($post['TransactionDetails']['ch_other_phone_number']){ ?>
				<div class="row" >
				  <div class="col-sm-3">Other Ph. No.</div>
				  <div class="col-sm-9">: <?=$post['TransactionDetails']['ch_other_phone_number']?>
				  </div>
				</div>
				<? } if($post['TransactionDetails']['ch_bank_fax']){ ?>
				<div class="row" >
				  <div class="col-sm-3">Bank Fax</div>
				  <div class="col-sm-9">: <?=$post['TransactionDetails']['ch_bank_fax']?>
				  </div>
				</div>
				<? } if($post['TransactionDetails']['ch_nsf']){ ?>
				<div class="row" >
				  <div class="col-sm-3">NSF</div>
				  <div class="col-sm-9">: <?=$post['TransactionDetails']['ch_nsf']?>
				  </div>
				</div>
				<? } if($post['TransactionDetails']['ch_tax_id']){ ?>
				<div class="row" >
				  <div class="col-sm-3">Tax ID</div>
				  <div class="col-sm-9">: <?=$post['TransactionDetails']['ch_tax_id']?>
				  </div>
				</div>
				<? } if($post['TransactionDetails']['ch_date_of_birth']){ ?>
				<div class="row" >
				  <div class="col-sm-3">Date of Birth</div>
				  <div class="col-sm-9">: <?=$post['TransactionDetails']['ch_date_of_birth']?>
				  </div>
				</div>
				<? } if($post['TransactionDetails']['ch_id_number']){ ?>
				<div class="row" >
				  <div class="col-sm-3">ID No.</div>
				  <div class="col-sm-9">: <?=$post['TransactionDetails']['ch_id_number']?>
				  </div>
				</div>
				<? } if($post['TransactionDetails']['ch_id_state']){ ?>
				<div class="row" >
				  <div class="col-sm-3">ID State</div>
				  <div class="col-sm-9">: <?=$post['TransactionDetails']['ch_id_state']?>
				  </div>
				</div>
				<? } ?>
			  </div>
			   <? if($is_admin){ ?>
			  <div class="row ip_count is_admin">
				<div class="col-sm-12">IP: <a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select<? if(isset($type)){ ?>&type=<?=$type?><? } ?>&status=-1&keyname=18&searchkey=<?=$post['TransactionDetails']['ip']?>">
				  <?=prntext($post['TransactionDetails']['ip']);?> <b class="opn_tkt"><?=prntext($post['TransactionDetails']['ip_count']);?></b>
				  </a></div>
			  </div>
			  <? } ?>
			  <div class="riskdivid"></div>
			  <? if(($is_admin)&&((isset($_SESSION['login_adm']))||(isset($_SESSION['transaction_payout'])&&$_SESSION['transaction_payout']==1))){ ?>
			   <div class="rows" >
				   <? if($post['TransactionDetails']['typenum']==2){ ?>
					<a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select<? if(isset($type)){ ?>&type=<?=prntext($type);?><? } ?>&status=-1&keyname=223&searchkey=<?=prntext($post['TransactionDetails']['transaction_period']);?>&bid=<?=prntext($post['TransactionDetails']['receiver']);?>">View Withdrawal </a>
				   <? } ?>
				   <? if($_GET['keyname']==224){ ?>
					<a target="hform" class="" href="<?=$data['Host'];?>/transaction_fee_calculation<?=$data['ex']?>?action=select&id=<?=prntext($post['TransactionDetails']['id']);?>&bid=<?=prntext($post['TransactionDetails']['receiver']);?>">Update Transaction Calculation </a>
				   <? } ?>
				</div>
			  <? } ?>
			</div>
	</div>

	</div>
			
			 <? if($post['TransactionDetails']['txn_value']&&$is_admin&&((isset($_SESSION['login_adm']))||(isset($_SESSION['txn_detail'])&&$_SESSION['txn_detail']==1))){ ?>
			  <div class="row txn_detail">
				<div title="Txn Detail" class="col-sm-12 text-break">
				  <?=prntext($post['TransactionDetails']['txn_value']);?>
				  
				</div>
			  </div>
			  <? } ?>
			  
			<div class='commentrow' style="clear:both;float:left;width:100%;">
			  <? if($post['TransactionDetails']['system_note']&&$is_admin&&((isset($_SESSION['login_adm']))||(isset($_SESSION['note_system'])&&$_SESSION['note_system']==1))){ ?>
			  
			  <h6 class="vkg-underline-red">Note System</h6>
			  <div class="col-sm-6 is_admin" style="width:98%; padding:0px 1% 6px 1%;margin:0 0 10px 0;">
				<?=$post['TransactionDetails']['system_note'];?>
			  </div>
			  <? } ?>
			  <? if($post['TransactionDetails']['ch_comments']){ ?>
			  <h6 class="vkg-underline-red">Customer Comment</h6>
			  <div class="col-sm-6" style="width:98%; padding:0px 1% 6px 1%;margin:0 0 -8px 0;">
				<?=prntext($post['TransactionDetails']['ch_comments']);?>
			  </div>
			  <? } ?>
			  <? if($post['TransactionDetails']['remark']){ ?>
			  <h6 class="vkg-underline-red">Note Merchant : </h6>
			  
			  <div class="col-sm-6" style="width:98%; padding:0px 1% 6px 1%;margin:0 0 -8px 0;">
				<? if($post['TransactionDetails']['remark_status']==1&&$is_admin&&((isset($_SESSION['login_adm']))||(isset($_SESSION['t_add_remark'])&&$_SESSION['t_add_remark']==1)) ){ ?>
					<a class="addremarklink reply_supports is_admin" onClick="addremarks(this)">Reply Now</a>
				<? } ?>
				<?=prntext($post['TransactionDetails']['remark']);?>
			  </div>
			  <? } ?>
			  <? if($post['TransactionDetails']['reply_remark']){ ?>
			  
			   <h6 class="vkg-underline-red">Note Support</h6>
			  <div class="col-sm-12" style="width:98%; padding:0px 1% 6px 1%;margin:0 0 10px 0;">
				<? if($post['TransactionDetails']['remark_status']==2&&empty($is_admin)){ ?>
					<a class="reply_supports " >Review Reply</a>
				<? } ?>
				
				<?=$post['TransactionDetails']['reply_remark']?>
			  </div>
			  <? } ?>
			</div>
		<? }else{ ?>
		<div class="row">
			<div class="addrembtn px-0 vnextParent">
			  <div class="rightlink text-end" style="width: 95%;clear: right;">
				<? if((isset($post['TransactionDetails']['canrefund'])&&$post['TransactionDetails']['canrefund'])){ ?>
					<a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?id=<?=$post['TransactionDetails']['id']?><? if(isset($post['StartPage'])){ ?>&page=<?=$post['StartPage']?><? } ?>&action=refund" onClick="return confirm('Are you Sure to REFUND the Amount of <?=$post['TransactionDetails']['fees_o_txt'];?> and Transaction id is <?=$post['TransactionDetails']['transaction_id'];?>');">Refund</a> |
				<? } ?>
	

				<? if(($is_admin)&&((isset($_SESSION['login_adm']))||(isset($_SESSION['json_post_view']))&&$_SESSION['json_post_view']==1)){?>	
					<p onClick="rActive(this,'.vnextParent','.vnext','active');collapse_close_all('targetvkg');popup_openv1('<?=$data['Admins'];?>/json_pretty_print<?=$data['ex']?>','<?=encryptres($json_value1);?>');" id="targetvkg" class="modal_trans99 nomid88 btn btn-outline-success btn-sm my-2"  title="Payload View" ><i class="<?=$data['fwicon']['eye-solid'];?>"></i></p>

					<!--<a class=" btn btn-outline-warning view_json99 btn-sm" onClick="vnext(this,'.postjson_div','.vnextParent','.vnext')" title="Payload Json"><i class="<?=$data['fwicon']['eye-solid'];?>"></i></a>-->
					<a class="btn btn-outline-warning btn-sm" data-bs-toggle="collapse" href="#collapsePayloadJson" id="collapsePayloadJsonlavel" role="button" aria-expanded="false" aria-controls="collapsePayloadJson" title="Payload Json" onClick="collapse_close_all('collapsePayloadJson')"><i class="<?=$data['fwicon']['eye-solid'];?>"></i></a>
					
					
				<? } ?>


				<? if(($is_admin)&&((isset($_SESSION['login_adm']))||(isset($_SESSION['txn_detail']))&&$_SESSION['txn_detail']==1)){?>	
					<? $txn_value1=jsonencode1($post['TransactionDetails']['txn_value'],'',1);?>
					<a onClick="rActive(this,'.vnextParent','.vnext','active');collapse_close_all('acqresp');popup_openv1('<?=$data['Admins'];?>/json_pretty_print<?=$data['ex']?>','<?=encryptres($txn_value1);?>');" class="nomid btn btn-outline-danger btn-sm my-2"  title="Acquier Response" id="acqresp"><i class="<?=$data['fwicon']['eye-solid'];?>"></i></a>

					
<a class="btn btn-outline-danger btn-sm" data-bs-toggle="collapse" href="#collapseAcquierResponseJson" id="collapseAcquierResponseJsonlavel" role="button" aria-expanded="false" aria-controls="collapseAcquierResponseJson" title="Acquier Response Json" onClick="collapse_close_all('collapseAcquierResponseJson')"><i class="<?=$data['fwicon']['eye-solid'];?>"></i></a>
					
				<? } ?>

				<? if((($is_admin)&&(in_array($post['TransactionDetails']['typenum'],["2","3", "4", "5"])))&&((isset($_SESSION['login_adm']))||(isset($_SESSION['decode_json_acc'])&&$_SESSION['decode_json_acc']==1))){ ?>
					<a onClick="vnext(this,'.acquier_tesponse_json1','.vnextParent','.vnext');ajaxf1(this,'<?=$data['Admins']?>/transactions<?=$data['ex']?>?action=wd_view_acc&id=<?=$_REQUEST['id']?>&viewaction=viewAccountOrAddress','.acquier_tesponse_json_log','1');" class="btn btn-outline-warning view_json99 btn-sm" title="Bank Decode"><i class="<?=$data['fwicon']['eye-solid'];?>"></i></a>
				<? } ?>
 
<? if((($is_admin)&&(!in_array($post['TransactionDetails']['typenum'],[0=>"2",1=>"3",2=>"4",3=>"5",4=>"6"])))&&((isset($_SESSION['login_adm']))||(isset($_SESSION['role_push_notify'])&&$_SESSION['role_push_notify']==1))){ ?>

					 
<a class="btn btn-outline-secondary btn-sm" data-bs-toggle="collapse" href="#collapsePushNotify" id="collapsePushNotifylavel" role="button" aria-expanded="false" aria-controls="collapsePushNotify" title="Push Notify" onClick="collapse_close_all('collapsePushNotify')"><i class="<?=$data['fwicon']['eye-solid'];?>"></i></a>
					 
				<? } ?>	 
					 
<a class="addremarklink btn btn-outline-primary btn-sm my-2" id="addremarklinklavel" onClick="addremarks(this);collapse_close_all('addremarklinklavel')" title="Add Remark"><i class="<?=$data['fwicon']['edit'];?> text-success" data-bs-toggle="collapse" href="#collapseAddremark" role="button" aria-expanded="false" aria-controls="collapseAddremark"></i></a> 


				
				</div>
			</div>






<!-- start: slider  -->	

<? if((($is_admin)&&(!in_array($post['TransactionDetails']['typenum'],[0=>"2",1=>"3",2=>"4",3=>"5",4=>"6"])))&&((isset($_SESSION['login_adm']))||(isset($_SESSION['role_push_notify'])&&$_SESSION['role_push_notify']==1))){ ?>
<div class="collapse"  id="collapsePushNotify">		
<div class="card card-body my-2">

		<div class='f'>
						<div class="w_98 g row">
						
		<span class='col-sm-12 text-start '><h6>Notify Url :</h6></span><span class='col-sm-12' ><textarea name="mcb_notify_url" id='mcb_notify_url' class="form-control"><?=$post['TransactionDetails']['notify_url']?></textarea>
						</span>
						
						</div>
						<? if($post['TransactionDetails']['ostatus']==1){ ?>
						<div class="w_98 g row"><span class='col-sm-12 text-start' ><h6>Success Url :</h6></span>
						
						<span class='col-sm-12' ><textarea name="mcb_redirect_url" id='mcb_redirect_url' class="form-control" ><?=$post['TransactionDetails']['success_url']?></textarea></span></div>
						<? }else{ ?>
						<div class="w_98 g row"><span class='col-sm-12 text-start' ><h6>Failed Url :</h6></span>
						<span class='col-sm-12' ><textarea name="mcb_redirect_url" id='mcb_redirect_url' class="form-control" ><?=$post['TransactionDetails']['failed_url']?></textarea></span></div>
						
						
						<? } ?>
						</div>
		<div class="my-2"><textarea name="mcb_body" id='mcb_body' class="form-control"><?=json_encode($rParam1);?></textarea></div>
				
<a class="btn btn-primary btn-sm my-2 float-end" onClick="callback_send(this)">Submit</a>	
<div class="clearfix"></div>	
</div>
</div>		
<? } ?>		
		
		
<? if(($is_admin)&&((isset($_SESSION['login_adm']))||(isset($_SESSION['json_post_view']))&&$_SESSION['json_post_view']==1)){?>


<div class="collapse" id="collapsePayloadJson">
<div class="card card-body my-2"><?=htmlentitiesf($json_value1);?></div>
</div>


<? } ?>


<? if(($is_admin)&&((isset($_SESSION['login_adm']))||(isset($_SESSION['txn_detail']))&&$_SESSION['txn_detail']==1)){?>
	
<div class="collapse" id="collapseAcquierResponseJson">
<div class="card card-body my-2"><?=$txn_value1=jsonencode1($post['TransactionDetails']['txn_value'],'',1);?></div>
</div>

<? }


 if(($is_admin)&&((isset($_SESSION['login_adm']))||(isset($_SESSION['txn_detail']))&&$_SESSION['txn_detail']==1)){?>	
<div class="col-sm-12 mb-2 border rounded bg-light p-2 text-break acquier_tesponse_json1 vnext" style="display:none">
<div class="acquier_tesponse_json_log1">
	<? if($post['TransactionDetails']['json_log_history']){?>	
			  <div class="m-2" style="float:left;width:100%;clear:both !important;">
			  <? echo json_log_view($post['TransactionDetails']['json_log_history'],'wd_view_acc', 0,'','','99%');?>
			  </div>

	 <? } ?>
 </div>
<?
echo $txn_value = decode_json_acc($post['TransactionDetails']['txn_value'],1);
?></div>
<? }
 ?>

<!-- end: slider  -->	



	
    <div class="col-sm-12 ">
	<div class="text-center text-danger" id="gmsg"></div>
			<div id="addremarkform" class="addremarkform comtabdiv addremarkform_tab vnext border rounded my-2 px-2">
			  <form method="post" target="hform">
				<input type="hidden" name="action" value="addremark">
				<input type="hidden" name="gid" id="p_gid" value="<?=$post['TransactionDetails']['id']?>">
				<input type="hidden" name="page" value="<?=$post['StartPage']?>">
<div class="row mx-0">	

<div class="col-sm-12">			
<textarea required name="remark" id="gdesc" placeholder="Add Remark" class="form-control remarkcoment my-2"><?=prntext(((isset($post['remark']) &&$post['remark'])?$post['remark']:''));?></textarea>
</div>				
 <div class="col-sm-9">
<? if($is_admin&&((isset($_SESSION['login_adm']))||(isset($_SESSION['t_add_remark'])&&$_SESSION['t_add_remark']==1))){ ?>
<div class="replytype is_admin ms-2">
 <input type="radio" name="reply_type" value="support" id="support<?=$post['TransactionDetails']['id']?>" checked="checked" >
<label for="support<?=$post['TransactionDetails']['id']?>" >&nbsp;&nbsp;Support Note</label>
				  
<input type="radio" name="reply_type" value="system" id="system<?=$post['TransactionDetails']['id']?>" >
<label for="system<?=$post['TransactionDetails']['id']?>" >&nbsp;&nbsp;System Note </label>

</div>
				
<? } ?>
</div>
				
<div class="col-sm-3 text-end">				
<a name="send" id="sub_remark" value="CONTINUE"  class="add_remark_submit btn btn-primary btn-sm mb-2"><i class="<?=$data['fwicon']['circle-plus'];?>"></i> Submit</a>
</div>			  
</div>			  
			  
			  </form>
			</div>
	</div> 
	<div class="col-sm-12 border rounded mb-2">
			<div class="row m-2">
			 <h6 class="vkg-underline-red">Buyer's Detail</h6> 
			
				<div class="col-sm-3">Name</div>
				<div class="col-sm-9">: <a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select<? if(isset($type)){ ?>&type=<?=$type?><? } ?>&status=-1&keyname=2&searchkey=<?=$post['TransactionDetails']['names']?>">
				  <?=$post['TransactionDetails']['names']?>
				  </a></div>
				  
				  
				<div class="col-sm-3">Phone</div>
				<div class="col-sm-9">: <a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select<? if(isset($type)){ ?>&type=<?=$type?><? } ?>&status=-1&keyname=5&searchkey=<?=$post['TransactionDetails']['phone_no']?>">
				  <?=$post['TransactionDetails']['phone_no']?>
				  </a></div>

				<div class="col-sm-3">Email</div>
				<div class="col-sm-9 ">: 
				
				
				<?
				if($post['TransactionDetails']['typenum']==2||$post['TransactionDetails']['typenum']==3||$post['TransactionDetails']['typenum']==4)
				{
					echo encrypts_decrypts_emails($post['TransactionDetails']['email_add'],2,true);
				
				}
				else
				{
				
				?>
				
				<a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select<? if(isset($type)){?>&type=<?=$type?><? } ?>&status=-1&keyname=3&searchkey=<?=$post['TransactionDetails']['email_add']?>"> <?=($post['TransactionDetails']['email_add']);?>
				  </a>
				  <? } ?>
				  </div>

			  
			  <?php if($post['TransactionDetails']['upa']){ ?>
			    <div class="col-sm-3">UPA</div>
				<div class="col-sm-9">: <?=$post['TransactionDetails']['upa'];?>
				</div> 
			   <? } ?>
			  
			  <?php if($post['TransactionDetails']['card']){ ?>
				<div class="col-sm-3">Card No.</div>
				<div class="col-sm-9">: <? $cc_number = card_decrypts256($post['TransactionDetails']['card']);?>
				<?=bclf($cc_number,$post['TransactionDetails']['bin_no']);?>
				
		
	   
				
				
				</div> 
				
				<? if((isset($json_value['bin_bank_name'])&&$json_value['bin_bank_name'])){ ?>
				<div class="col-sm-3">Issuing Bank</div>
				<div class="col-sm-9">: <?=prntext($json_value['bin_bank_name']);?>
					 <?=prntext($json_value['bin_phone']?', '.$json_value['bin_phone']:'');?></div> 
				<? } ?>
				
			  <? } ?>
			  
			  <?php if($post['TransactionDetails']['json_value'] && $bankName){ ?>
				<div class="col-sm-3">Bank Name</div>
				<div class="col-sm-9">: <?=$bankName;?></div>
				
			  <? } ?>
			  
			  <?php if($post['TransactionDetails']['json_value'] && $upi_vpa_lable){ ?>
				<div class="col-sm-3">UPI</div>
				<div class="col-sm-9">: <?=$upi_vpa_lable;?> : <?=$upi_vpa;?></div>
				  
			  
			  <? } ?>
			  
			  

			 <?php if($post['TransactionDetails']['cardtype']){ ?>
				<div class="col-sm-3">Card Type</div>
				<div class="col-sm-9" style="text-transform:capitalize;text-indent: 0px;margin-left: -7px;">: 
	   <?php
$fwimg=0;
$getimg=$post['TransactionDetails']['cardtype'];		
$img="nocc.png";$txt='No Card Available';$sort="&ccard_type=-1";
if ($getimg=='visa'){$fwimg=1; $fwicon=$data['fwicon']['visa']; $img="visacard.png";$txt='Visa Card';}
if ($getimg=='jcb'){$fwimg=1; $fwicon=$data['fwicon']['jcb']; $img="jcb.png";$txt='JCB Card';}
if ($getimg=='mastercard'){$fwimg=1; $fwicon=$data['fwicon']['mastercard'];$img="master.png";$txt='Master Card';}
if ($getimg=='discover'){$fwimg=1; $fwicon=$data['fwicon']['discover'];$img="discover.png";$txt='Discover';}
if ($getimg=='rupay'){$img="rupay.jpg";$txt='Rupay';}
if ($getimg=='amex'){$fwimg=1; $fwicon=$data['fwicon']['amex'];$img="amex.png";$txt='American Express';}
if ($getimg==-1){$fwimg=1; $fwicon=$data['fwicon']['nocc'];$img="nocc.png";$txt='No Card Available';}
if($img=="nocc.png"){ $fwimg=1; $fwicon=$data['fwicon']['nocc']; }
?>
<? if($fwimg==0){ ?>
	  <img src="<?=$data['Host']?>/images/<?=$img?>" style="max-height:18px;" class="img-thumbnail55" alt="<?=$txt?>" title="<?=$txt?>">
<? }else{ echo $fwicon;} ?>
			

	  

				<!--<?=$post['TransactionDetails']['cardtype']?>--></div>
			  <? } ?>


                <?php if($address_con){ ?>
			  
				<div class="col-sm-3">Address</div>
				<div class="col-sm-9">: <!--<a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select<? if(isset($type)){ ?>&type=<?=$type?><? } ?>&status=-1&keyname=11&searchkey=<?=$post['TransactionDetails']['address']?>">-->
				  <?=$post['TransactionDetails']['address']?>
				  <!--</a>-->,<!-- <a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select<? if(isset($type)){ ?>&type=<?=$type?><? } ?>&status=-1&keyname=12&searchkey=<?=$post['TransactionDetails']['city']?>">-->
				  <?=$post['TransactionDetails']['city']?>
				  <!--</a>-->, <!--<a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select<? if(isset($type)){ ?>&type=<?=$type?><? } ?>&status=-1&keyname=13&searchkey=<?=$post['TransactionDetails']['state']?>">-->
				  <?=$post['TransactionDetails']['state']?>
				  <!--</a>-->, <!--<a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select<? if(isset($type)){ ?>&type=<?=$type?><? } ?>&status=-1&keyname=14&searchkey=<?=$post['TransactionDetails']['country']?>">-->
				  <?=$post['TransactionDetails']['country']?>
				  <!--</a>--> - <!--<a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select<? if(isset($type)){ ?>&type=<?=$type?><? } ?>&status=-1&keyname=15&searchkey=<?=$post['TransactionDetails']['zip']?>">-->
				  <?=$post['TransactionDetails']['zip']?>
				  <!--</a>--></div>
			   <? } ?>
			   <? if($is_admin){ ?>
			 
				<div class="col-sm-3">IP  </div>
				<div class="col-sm-9">: <a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select<? if(isset($type)){ ?>&type=<?=$type?><? } ?>&status=-1&keyname=18&searchkey=<?=$post['TransactionDetails']['ip']?>">
				  <?=$post['TransactionDetails']['ip']?> <span class="badge bg-primary px-2" title="View Transacrtion From This IP"><?=$post['TransactionDetails']['ip_count']?></span>
				  </a></div>
			  
			  <? } ?>
			  
			  <?php if($post['TransactionDetails']['related_id']){ 
					$related_id=jsondecode($post['TransactionDetails']['related_id'],1);
					if(isset($related_id['success_transaction_id'])){
						$related_id_success=$related_id['success_transaction_id'];
				   } 
				  }
				?>
			  
			  
			  <? if(($is_admin)&&((isset($_SESSION['login_adm']))||(isset($_SESSION['json_post_view']))&&$_SESSION['json_post_view']==1)){ ?>

						
						<?php if(isset($related_id)){ ?>
						 <div class="row">
							<div class="col-sm-6" >
							  <? if(isset($related_id_success)){ ?>
							  <a  href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?action=select&type=-1&status=-1&keyname=1&searchkey=<?=$related_id_success;?><?=(isset($_GET['mview'])?"&bid=".$post['TransactionDetails']['receiver']:"");?>" class="btn btn-primary view_json glyphicons file" style="float:left;width:100%;"><i></i><span>VIEW <?=$related_id_success;?> SUCCESS</span></a>
							  <? } ?>
							</div>
						  </div>
						<? } ?>
				<? } ?>
			  

			  <div class="riskdivid"></div>
			  <? if(($is_admin)&&((isset($_SESSION['login_adm']))||(isset($_SESSION['transaction_payout'])&&$_SESSION['transaction_payout']==1))){ ?>
			   <div class="row" >
				   <? if($post['TransactionDetails']['typenum']==2){ ?>
				   
				   <div class="col-sm-6 my-2">
					<a class="<?=$trans_class;?> btn btn-primary rounded w-100 btn-sm" <?=$trans_datah;?> href="<?=$trans_href;?>?action=select<? if(isset($type)){ ?>&type=<?=$type?><? } ?>&keyname=223&searchkey=<?=$post['TransactionDetails']['transaction_period']?>&bid=<?=$post['TransactionDetails']['receiver']?>&id=<?=$post['TransactionDetails']['id']?>&pay_type=2"> View Withdrawal </a>
					</div>
					
					
					
					<? $report_file_name="payout_report";?>
					<div class="col-sm-6">
					<div class="btn-group w-100">
<button type="button" class="btn btn-primary my-2 rounded btn-sm" data-bs-toggle="dropdown" aria-expanded="false" autocomplete="off">
<i class="<?=$data['fwicon']['eye-solid'];?>"></i> Payout</button>
<ul class="dropdown-menu">
<li><a onClick="filteraction(this)" target="selltedview" href="<?=$trans_href;?>?action=select<?=$post['wd_payout_date'];?><? if(isset($type)){ ?>&type=<?=$type?><? } ?>&keyname=223&bid=<?=$post['TransactionDetails']['receiver']?>&id=<?=$post['TransactionDetails']['id']?>&pay_type=2" class="dropdown-item"><i class="<?=$data['fwicon']['eye-solid'];?>"></i> <span>View </span></a></li>

<? if($paydLink){ ?>
<li><a onClick="filteraction(this)" target="selltedview_wd" data-action="selltedall" data-label="Settled List" data-reason="Settled by SWIFT Reference" data-href="transactions.htm?bid=<?=$post['TransactionDetails']['receiver']?>&tp=<?=$post['TransactionDetails']['transaction_period']?>&id=<?=$post['TransactionDetails']['id']?><?php echo $common_get;?>&action=payoutsellted&querytype=sellted" class="dropdown-item"><i></i><span>OK SETTLED</span></a></li>
<? } ?>

<? if($data['con_name']!='clk'){ ?>
<li><a onClick="filteraction(this)" target="pdfreport_wd" href="<?=$data['Host']?>/dynamic_ac_reporting<?=$data['ex']?>?bid=<?=$post['TransactionDetails']['receiver']?>&id=<?=$post['TransactionDetails']['id']?>" class="dropdown-item"><i class="<?=$data['fwicon']['pdf'];?>"></i> File PDF REPORT-A/c.</a></li>
<? } ?>

<li><a onClick="filteraction(this)" target="pdfreport_1_wd" href="<?=$data['Host']?>/transaction_db_reporting<?=$data['ex']?>?bid=<?=$post['TransactionDetails']['receiver']?>&id=<?=$post['TransactionDetails']['id']?>" class="dropdown-item"><i class="<?=$data['fwicon']['pdf'];?>"></i> File PDF REPORT-TR.</a></li>

<? if($data['con_name']!='clk'){ ?>
<li><a onClick="filteraction(this);popuploadig();" target="hform" href="../transaction_fee_calculation<?=$data['ex']?>?bid=<?=$post['TransactionDetails']['receiver']?>&id=<?=$post['TransactionDetails']['id']?>&tp=<?=$post['TransactionDetails']['transaction_period']?><?php echo $common_get; ?>&action=select&querytype=tfcupdate" class="dropdown-item"><i class="<?=$data['fwicon']['setting'];?>"></i> Update</a></li>
<? } ?>							
							

  </ul>
</div>
                    </div>

					
				   <? } ?>
				   <? if(isset($_GET['keyname'])&&$_GET['keyname']==224){ ?>
					<a target="hform" class="" href="<?=$data['Host'];?>/transaction_fee_calculation<?=$data['ex']?>?action=select&id=<?=$post['TransactionDetails']['id']?>&bid=<?=$post['TransactionDetails']['receiver']?>">Update Transaction Calculation </a>
				   <? } ?>
				</div>
			  <? } ?>
			</div>
	</div>
	<div class="col-sm-12 border rounded">
			<div class="row m-2">
			  <h6 class="vkg-underline-red">Transaction Details</h6>
			   
			  <? if(($is_admin)&&((isset($_SESSION['login_adm']))||(isset($_SESSION['source_url'])&&$_SESSION['source_url']==1))){ ?>
				  <div class="row is_admin">
					<div class="col-sm-3 ">Source Url </div>
					<div class="col-sm-9 text-break">: <?=$post['TransactionDetails']['source_url']?><? if($post['TransactionDetails']['tableid']){ ?>&tableid=<?=$post['TransactionDetails']['tableid']?><? } ?>
					</div>
				  </div>
			<? } ?>		  
				  <? if((isset($post['TransactionDetails']['bussiness_url'])&&$post['TransactionDetails']['bussiness_url'])){ ?>

				<div class="col-sm-3">Business URL</div>
				<div class="col-sm-9">: <? if($is_admin){ ?>
				  <a <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_add_stores'])&&$_SESSION['merchant_action_add_stores']==1)){ ?> onClick="iframe_open_modal(this);" class="database_plus" data-mid="<?=$post['TransactionDetails']['receiver']?>" data-href="" data-tabname="" data-url="" data-ihref="<?=$data['Host'];?>/user/store<?=$data['ex']?>?admin=1&mid=<?=$post['TransactionDetails']['receiver']?>&id=<?=$post['TransactionDetails']['store_id']?>&action=view&gid=<?=$post['TransactionDetails']['receiver']?>&tempui=<?=$data['frontUiName']?>" <? } ?> title="View Store Details" >
				  <span class="badge bg-primary text-white"><?=$post['TransactionDetails']['store_id']?></span></a>
				 <? }else{ ?>
					<? if((strpos($_SESSION['themeName'],'LeftPanel')!==false)&&($is_admin==false)){ ?>
		
					<? }else{ ?>
	
					<a  >
					 <?=$post['TransactionDetails']['store_id']?></a>
					<? } ?>
				 <? } ?>
				 
				  
				  <? if($post['TransactionDetails']['bussiness_url']){ ?>
					 (<?=$post['TransactionDetails']['bussiness_url']?>)
				  <? } ?>
				  
				</div>

			  <? } ?>
			
					
				  
			
			  <? if(($is_admin)&&(isset($_SESSION['login_adm']))){ ?>
				  <div class="row is_admin" style="display:none;background:#e4e3e3;">

							<div class="col-sm-3">ID</div>
							<div class="col-sm-9">: <?=$post['TransactionDetails']['id']?></div>

							<div class="col-sm-3">Store Id</div>
							<div class="col-sm-9">: <?=$post['TransactionDetails']['store_id']?></div>

							<div class="col-sm-3">RRN</div>
							<div class="col-sm-9">: <?=$post['TransactionDetails']['rrn']?></div>

							<div class="col-sm-3">Notify Url </div>
							<div class="col-sm-9">: <?=$post['TransactionDetails']['notify_url']?></div>

							<div class="col-sm-3">Success Url</div>
							<div class="col-sm-9">: <?=$post['TransactionDetails']['success_url']?></div>

						    <div class="col-sm-3">Failed Url</div>
						    <div class="col-sm-6">: <?=$post['TransactionDetails']['failed_url']?></div>
				 </div>
			  <? } ?>
			  
			  
		
				<div class="col-sm-3">Status</div>
				<div class="col-sm-9">: <?=$post['TransactionDetails']['status']?> 
				  <? if(($post['TransactionDetails']['typenum']==9930)&&($post['TransactionDetails']['ostatus']!=1)){ ?>
				  <? $jsn=$post['TransactionDetails']['json_value1']['q_order']['g']['result'];
				  ?>
					<a target="_blank" class="<?=$trans_class;?>" href="<?=$data['Host'];?>/api/3d30/resend<?=$data['ex']?>?action=resend&transID=<?=$post['TransactionDetails']['transID'];?>_<?=$post['TransactionDetails']['id'];?>&admin=1"><b>Resend</b></a>
				  <? } ?>
				</div>
		
			  <? if($post['TransactionDetails']['reason']){ ?>
			  
				<div class="col-sm-3">Response</div>
				<div class="col-sm-9">: <?=$post['TransactionDetails']['reason']?></div>

			  <? } ?>
			 
			<? if(($is_admin)&&(isset($_SESSION['login_adm']))){ ?>			 
			  <? if($post['TransactionDetails']['dba_brand_name']){ ?>
					  <div class="row is_admin">
						<div class="col-sm-3 ">DBA/Brand</div>
						<div class="col-sm-9">: <?=$post['TransactionDetails']['dba_brand_name']?>
						</div>
					  </div>
				  <? } ?>
			<? } ?>
			
			  <? if($post['TransactionDetails']['product_name']){ ?>

				<div class="col-sm-3">Product Name</div>
				<div class="col-sm-9">: <a class="<?=$trans_class;?> text-white" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select<? if(isset($type)){ ?>&type=<?=$type?><? } ?>&status=-1&keyname=16&searchkey=<?=$post['TransactionDetails']['product_name']?>">
				  <?=$post['TransactionDetails']['product_name']?>
				  </a></div>

			  <? } ?>
	<? if($is_admin){ ?>
	
		<div style="clear:both;display:none" class="row my-2">
	<? }else{ ?>
		<div class="row">
	<? } ?>
			  <? if($post['TransactionDetails']['txn_value']&&$is_admin&&((isset($_SESSION['login_adm']))||(isset($_SESSION['txn_detail'])&&$_SESSION['txn_detail']==1))){ ?>
			  <? if($post['TransactionDetails']['txn_id']){ ?>
 				<div class="col-sm-3">Bank Ref No. </div>
				<div class="col-sm-9">: <?=$post['TransactionDetails']['txn_id']?></div>
				  
				
				
 			  <? } ?>

			 
			 
			
		<? } ?>

			  <? if($post['TransactionDetails']['descriptor']){ ?>
			  
 				<div class="col-sm-3">Trans Descriptor</div>
				<div class="col-sm-9">: <?=$post['TransactionDetails']['descriptor']?></div>
				

			  <? } ?>
			  
			  
<div class="col-sm-3">Order Amt.(<?=$post['TransactionDetails']['curr_nam']?>) </div>
<div class="col-sm-9">: <a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select<? if(isset($type)){ ?>&type=<?=$type?><? } ?>&status=-1&keyname=4&searchkey=<?=$post['TransactionDetails']['oamount']?>"><?=$post['TransactionDetails']['amount']?>
<? if(($is_admin)&&($post['TransactionDetails']['bank_processing_amount'])&&(isset($_SESSION['login_adm']))){ ?>
 (<?=$post['TransactionDetails']['bank_processing_amount']?> <?=$post['TransactionDetails']['bank_processing_curr']?>)<? } ?></a></div>
			 
			 
	<? if((($is_admin)&&((isset($_SESSION['login_adm']))||(isset($_SESSION['t_calculation_row'])&&$_SESSION['t_calculation_row']==1)))||(($_SESSION['login'])&&($post['TransactionDetails']['typenum']==2))){ ?>
	
			  <? if($post['TransactionDetails']['transaction_amt']){ ?>
			  
<div class="col-sm-3" title="Transaction Amount">Trans. Amt.(<?=$post['TransactionDetails']['curr_transaction_amount']?>) </div>
<div class="col-sm-9">: <?=$post['TransactionDetails']['transaction_amount'];?></div>

			 <? } ?>
			 <? if($post['TransactionDetails']['mdr_amt']&&$post['TransactionDetails']['mdr_amt']!="0"){ ?>
				 
				 
<div class="col-sm-3 " title="Discount Rate">Disc. Rate(<?=$post['TransactionDetails']['curr_transaction_amount']?>)</div>
<div class="col-sm-9">: <?=$post['TransactionDetails']['mdr_amt2'];?></div>
				  
				  
			 <? } ?>
			 <? if($post['TransactionDetails']['mdr_txtfee_amt']&&$post['TransactionDetails']['mdr_txtfee_amt']!="0"){ ?>

<div class="col-sm-3 " title="Transaction Fee">Trans. Fee(<?=$post['TransactionDetails']['curr_transaction_amount']?>)</div>
<div class="col-sm-9">: <?=$post['TransactionDetails']['mdr_txtfee_amt2'];?> <? if($post['TransactionDetails']['fee_details']){ ?> = <em>( <?=$post['TransactionDetails']['fee_details2'];?> )</em>

		 <? } ?>
					

				  </div>
			 <? } ?>
			 <? if($post['TransactionDetails']['rolling_amt']&&$post['TransactionDetails']['rolling_amt']!="0"){ ?>
				 
				 
<div class="col-sm-3 ">Rolling Fee(<?=$post['TransactionDetails']['curr_transaction_amount']?>)</div>
<div class="col-sm-9">: <?=$post['TransactionDetails']['rolling_amt2'];?></div>
				  
				  
			 <? } ?>
			 <? if($post['TransactionDetails']['mdr_cbk1_amt']&&$post['TransactionDetails']['mdr_cbk1_amt']!="0"){ ?>
				
				
<div class="col-sm-3 ">Predispute Fee(<?=$post['TransactionDetails']['curr_transaction_amount']?>)</div>
<div class="col-sm-9">: <?=$post['TransactionDetails']['mdr_cbk1_amt2'];?></div>
				 
				 
			 <? } ?>
			 <? if($post['TransactionDetails']['mdr_refundfee_amt']&&$post['TransactionDetails']['mdr_refundfee_amt']!="0"){ ?>
				
				
<div class="col-sm-3 "><?=$data['TransactionStatus'][$post['TransactionDetails']['ostatus']];?> Fee(<?=$post['TransactionDetails']['curr_transaction_amount']?>)</div>
<div class="col-sm-9">: <?=$post['TransactionDetails']['mdr_refundfee_amt2'];?></div>
				 
				 
			 <? } ?>
			<? if($post['TransactionDetails']['mdr_cb_amt']&&$post['TransactionDetails']['mdr_cb_amt']!="0"){ ?>
				
				
<div class="col-sm-3 "><?=$data['TransactionStatus'][$post['TransactionDetails']['ostatus']];?> Fee(<?=$post['TransactionDetails']['curr_transaction_amount']?>)</div>
<div class="col-sm-9">: <?=$post['TransactionDetails']['mdr_cb_amt2'];?></div>
				  
				  
			 <? } ?>
			 <? if($post['TransactionDetails']['pay_txn']){ ?>
			
<div class="col-sm-3 " title="Payout Amount">Pay. Amt.(<?=$post['TransactionDetails']['payout_curr']?>)</div>
<div class="col-sm-9">: <? if(isset($post['TransactionDetails']['wd_payable_amt_of_txn_from'])&&$post['TransactionDetails']['wd_payable_amt_of_txn_from']){ ?>
				   <?=$post['TransactionDetails']['wd_payable_amt_of_txn_from2']?> =
				<? } ?>
				
				<a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select<? if(isset($type)){ ?>&type=<?=$type?><? } ?>&status=-1&keyname=20&searchkey=<?=$post['TransactionDetails']['payable_amt_of_txn']?>">
				  <?=$post['TransactionDetails']['payable_amt_of_txn']?>
				  </a></div>
			  
			 <? } ?>
			 
			 <? if(isset($post['TransactionDetails']['rates'])&&$post['TransactionDetails']['rates']){ ?>
				
					<div class="col-sm-3">Exchange Rate </div>
					<div class="col-sm-9">: <?=$post['TransactionDetails']['rates']?></div>
				
			 <? } ?>
			 
			 
			 
			<? if(isset($post['TransactionDetails']['available_balance_amt'])&&$post['TransactionDetails']['available_balance_amt']){ ?>
				 
					<div class="col-sm-3 ">Balance (<?=$post['TransactionDetails']['curr_transaction_amount']?>)</div>
					<div class="col-sm-9">: <b><?=$post['TransactionDetails']['available_balance'];?></b></div>
				 
			<? } ?>
			<? if(isset($post['TransactionDetails']['payout_date'])&&$post['TransactionDetails']['payout_date']){ ?>
				
					<div class="col-sm-3 ">Mature Date</div>
					<div class="col-sm-9">: <b><?=prndate($post['TransactionDetails']['payout_date']);?></b></div>
				
			<? } ?>
			
			
		<? if(isset($post['TransactionDetails']['wd_account_curr'])&&$post['TransactionDetails']['wd_account_curr']){ ?>
				
					<div class="col-sm-3 ">Account Currency</div>
					<div class="col-sm-9">: <?=$post['TransactionDetails']['wd_account_curr'];?></div>
				
				<? } ?>
				
				<? if(isset($post['TransactionDetails']['wd_requested_bank_currency'])&&$post['TransactionDetails']['wd_requested_bank_currency']){ ?>
				
					<div class="col-sm-3 ">Withdrawal Currency</div>
					<div class="col-sm-9">: <?=$post['TransactionDetails']['wd_requested_bank_currency'];?></div>
				 
				<? } ?>
			 
<? } ?>			  
			  <? if($is_admin&&((isset($_SESSION['login_adm']))||(isset($_SESSION['t_a_require'])&&$_SESSION['t_a_require']==1))){ ?>
			
					<div class="col-sm-3  ">Acquirer</div>
					<div class="col-sm-9">: <?=$post['TransactionDetails']['type']?></div>
			
			   <? } ?>
		  
			<? if(isset($post['TransactionDetails']['comments'])&&$post['TransactionDetails']['comments']){ ?>  
				<div class="col-sm-3">Description</div>
				<div class="col-sm-9">: <?=$post['TransactionDetails']['comments']?><br><?=$post['TransactionDetails']['ecomments']?></div>
			<? } ?>
	</div>
	 <? if($is_admin==true){ ?>
		<a class="btn btn-primary btn-sm view_json99 w-100" onClick="view_next3(this,'','prv')" >Expand </a>
	 <? } ?>
			</div>
	

<div class='commentrow99 row mx-2'>
			
<? if($post['TransactionDetails']['system_note']&&$is_admin&&((isset($_SESSION['login_adm']))||(isset($_SESSION['note_system'])&&$_SESSION['note_system']==1))){ ?>

<h6 class="vkg-underline-red">Note System</h6>
			  
<div class="col-sm-12 is_admin text-break clearfix"><?=print_note_system($post['TransactionDetails']['system_note'])?>


				<?php if(isset($related_id)){ ?>
					
					<div>
					<div class="col-sm-12" ><a href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?action=select&type=-1&status=-1&keyname=1&searchkey=<?=$post['TransactionDetails']['transaction_id']?><?=(isset($_GET['mview'])?"&bid=".$post['TransactionDetails']['receiver']:"");?>" style=" clear:both" class="btn btn-primary view_json99"><i></i><span>SORTING</span></a></div>
					<div class="rmk_msg text-break clearfix"><?=$post['TransactionDetails']['related_id']?></div>
					</div>
						 
					<? } ?>
						
			  <? } ?>
<? if((isset($post['TransactionDetails']['ch_comments'])&&$post['TransactionDetails']['ch_comments'])){ ?>
			  <h6 class="my-2">Customer Comment :: </h6>
			  
			  
			  <? } ?>
<? if($post['TransactionDetails']['remark']){ ?>
			  
			  <h6 class="vkg-underline-red">Note Merchant</h6>
			 <div class="col-sm-12 hide" id="jq_div"><div class="rmk_row"><div class="rmk_date jq_date" title=""></div><div class="rmk_msg jq_desc"></div></div></div>
			  <div class="col-sm-12"><? if($post['TransactionDetails']['remark_status']==1&&$is_admin&&((isset($_SESSION['login_adm']))||(isset($_SESSION['t_add_remark'])&&$_SESSION['t_add_remark']==1))){ ?>
					<!--<a class="addremarklink reply_supports is_admin " onClick="addremarks(this)">Reply Now</a>-->
				<? } ?>
				<?=print_note_system($post['TransactionDetails']['remark'])?>
			  
			  <? } ?>
			 
		
			 <? if($is_admin==true){ ?>

				<? if($post['TransactionDetails']['reply_remark']){ ?>

				 <h6 class="vkg-underline-red">Note Support</h6>
				 <div class="col-sm-12"><? if($post['TransactionDetails']['remark_status']==2&&empty($is_admin)){ ?>
						<a class="reply_supports">Review Reply</a>
					<? } ?>
					
				  </div>
				 <div class="col-sm-12 mx-2"><?=print_note_system($post['TransactionDetails']['reply_remark'])?></div>
				   
				  <? } ?>
			  
			  <? } ?>
			  
			
	
	<? } ?>
	<? } ?>
	</div>
	</div></div>
	
	</div>
</div>
<script>
	$(".viewthistrans").click(function(){
		var thisText = $(this).text().replace("R","");
		
		top.window.location.href="transactions<?=$data['ex']?>?"+"action=select&keyname=17&searchkey="+thisText+"&type=-1&status=-1&bid=<? if(isset($post['bid'])) echo $post['bid']?>";
	});
	
	$('.add_remark_submit').click(function(){
		//$('#form_popup').slideDown(900);
	});
	<? if($is_admin){ ?>
	$('.ip_view').each(function(){	
		//$(this).replaceWith($('<a class="ip_viewa" onClick="ip_viewf1(this,\'<?=$data['Host']?>/include/ips<?=$data['ex']?>?remote=' + $.trim($(this).text()) + '\')">' + $.trim($(this).text()) + '</a>'));
		$(this).replaceWith($('<a class="ip_viewa" onClick="ip_viewf1(this,\'<?=$data['Host']?>/third_party_api/ips<?=$data['ex']?>?remote=' + $.trim($(this).text()) + '\')">' + $.trim($(this).text()) + '</a>'));	<? // fetch IP detail from rapid api - added on 6-10 ()?>
	});
	/*$('.ip_view').click(function(){	
		var ipurl="<?=$data['Host']?>/include/ips<?=$data['ex']?>?remote=" + $.trim($(this).text());
		var placeurl=$(this).parent().parent().find('.rmk_msg');
		alert(ipurl+"\r\n"+placeurl+"\r\n"+placeurl.html());
		ajaxf2(ipurl,placeurl,1);
	});*/
	<? } ?>
</script>

<? if($post['TransactionDetails']['remark_status']==2&&$_SESSION['login']&&$is_admin==false&&$data['frontUiName']=='ice'){ ?>
<? $_SESSION['mNotificationCount']=$trans_reply_counts=trans_reply_counts($_SESSION['uid'],'1,2');?>
<script>
setTimeout(function(){ 
	if($("#treply_opn_count")){
		$("#treply_opn_count").html("<?=$trans_reply_counts;?>");
	}
}, 200);
</script>
<? } ?>
</body>
</html>

<?php /*?>js for Add remark / show / hide transaction detail popup top icon click display<?php */?>
<script>
var frontUiName="<?=$data['frontUiName']?>";
function topInViewport1(element) {
	return $(element).offset().top >= $(window).scrollTop() && $(element).offset().top; 
}
 
function autoheightPopUp1(e,contentBody=''){
	//var Ah=(screen.height-150)+'px';
	$(e).removeAttr('style');
	
	var Bh=$(contentBody).height();
	var Ah=Bh+60+'px';
	//alert(frontUiName);
	if (typeof top.window.NameOfFile !== "undefined" && top.window.NameOfFile=="withdraw-fund-list" ) {
		vp=vp-77;
	 //alert('\r\n marginTop=>'+vp+'\r\n height=>'+Ah+'\r\n NameOfFile=>'+top.window.NameOfFile);
	} 
	
	if(frontUiName=='ruby'){
		vp=vp-40;
	}

	var vp_1=vp+20+'px'; 
	
	
	$(e).animate({height:Ah,marginTop:vp_1}, 1000);
}
<? if($is_admin==false){ ?>
$(document).ready(function(){
	autoheightPopUp1('.modalpopup_body','#modalpopup_cdiv');
	
	
	
});
<? } ?>

$("#sub_remark").click(function(){
var gdata=$("#gdesc").val();
var gid=$("#p_gid").val();
  $.ajax({
		type: "POST",
		url: "../include/add_remarks<?=$data['ex'];?>",
		data: { gdata: gdata, gid : gid } 
	}).done(function(data){
		//alert(data);
		$("#gmsg").html("<b>Data Submitted Successfully</b>!");
		$("#gdesc").val("");
		
	});
});


function collapse_close_all(gdata){
//alert(gdata);

if(gdata=="collapsePayloadJson"){
$('#collapseAcquierResponseJson').removeClass('show');
$('#collapsePushNotify').removeClass('show');
$('#addremarkform').css('display', 'none');

$('#collapseAcquierResponseJsonlavel').attr("aria-expanded","false");
$('#collapsePushNotifylavel').attr("aria-expanded","false");
$('#addremarklinklavel').attr("aria-expanded","false");
$('#addremarklinklavel').removeClass('active');

}else if(gdata=="collapseAcquierResponseJson"){
$('#collapsePayloadJson').removeClass('show');
$('#collapsePushNotify').removeClass('show');
$('#addremarkform').css('display', 'none');


$('#collapsePayloadJsonlavel').attr("aria-expanded","false");
$('#collapsePushNotifylavel').attr("aria-expanded","false");
$('#addremarklinklavel').attr("aria-expanded","false");
$('#addremarklinklavel').removeClass('active');

}else if(gdata=="collapsePushNotify"){
$('#collapsePayloadJson').removeClass('show');
$('#collapseAcquierResponseJson').removeClass('show');
$('#addremarkform').css('display', 'none');

$('#collapsePayloadJsonlavel').attr("aria-expanded","false");
$('#collapseAcquierResponseJsonlavel').attr("aria-expanded","false");
$('#addremarklinklavel').attr("aria-expanded","false");
$('#addremarklinklavel').removeClass('active');

}else if(gdata=="addremarklinklavel"){
$('#collapsePayloadJson').removeClass('show');
$('#collapseAcquierResponseJson').removeClass('show');
$('#collapsePushNotify').removeClass('show');

$('#collapsePayloadJsonlavel').attr("aria-expanded","false");
$('#collapseAcquierResponseJsonlavel').attr("aria-expanded","false");
$('#collapsePushNotifylavel').attr("aria-expanded","false");

}else if(gdata=="targetvkg"){
$('#targetvkg').attr("aria-expanded","false");
$('#targetvkg').removeClass('active');

$('#collapsePayloadJsonlavel').attr("aria-expanded","false");
$('#collapseAcquierResponseJsonlavel').attr("aria-expanded","false");
$('#collapsePushNotifylavel').attr("aria-expanded","false");
$('#addremarklinklavel').attr("aria-expanded","false");

}else if(gdata=="acqresp"){
$('#acqresp').attr("aria-expanded","false");
$('#acqresp').removeClass('active');

$('#collapsePayloadJsonlavel').attr("aria-expanded","false");
$('#collapseAcquierResponseJsonlavel').attr("aria-expanded","false");
$('#collapsePushNotifylavel').attr("aria-expanded","false");
$('#addremarklinklavel').attr("aria-expanded","false");
}
//$('#addremarkform').css('display', 'none');
//$('#'+gdata).addClass('show');
}

function popup_openv1(url,json1=''){
	if(json1){
		$('#myModal9').modal('show').find('.modal-body').load(url,{"json":json1});
	}else{
		$('#myModal9').modal('show').find('.modal-body').load(url);
	}
	$('#myModal9 .modal-dialog').css({"max-width":"80%"});
}

</script>
<? db_disconnect();?>