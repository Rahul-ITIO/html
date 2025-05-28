<?
if(isset($post['is_admin_payout'])) $is_admin_payout=$post['is_admin_payout'];
else $is_admin_payout="";


//$txn_currency = get_currency($post['row']['converted_transaction_currency']);
$json_log		= $post['row']['json_log'];
$txn_value		= $post['row']['txn_value'];
$accept_amount	= jsonvaluef($json_log,'accepted_amt');

$ord_amt = get_currency($post['row']['transaction_currency']).abs($post['row']['transaction_amount']);
$txn_amt = get_currency($post['row']['converted_transaction_currency']).abs($post['row']['converted_transaction_amount']);
$balance_amt = get_currency($post['row']['converted_transaction_currency']).abs($post['row']['available_balance']);

if($post['row']['transaction_amount']<0) $ord_amt ='<font color="red">-'.$ord_amt.'</font>';
if($post['row']['converted_transaction_amount']<0){
$txn_amt ='<font color="red">-'.$txn_amt.'</font>';
//	$ord_amt ='<font color="red">-'.$ord_amt.'</font>';
}
if($post['row']['available_balance']<0) $balance_amt ='<font color="red">-'.$balance_amt.'</font>';

if($post['row']['transaction_status']==0 || $post['row']['transaction_status']==3) $balance_amt = get_currency($post['row']['converted_transaction_currency']).'0';


if(isset($post['row']['beneficiary_id'])&&$post['row']['beneficiary_id'])
{
	$result_select=db_rows_2(
		"SELECT * FROM `{$data['DbPrefix']}payout_beneficiary`".
		" WHERE bene_id='{$post['row']['beneficiary_id']}' LIMIT 1",0
	);
//	print_r($result_select);
	$beneficiary_name	= @$result_select[0]['beneficiary_name'];
	$account_number		= @$result_select[0]['account_number'];
	$bank_name			= @$result_select[0]['bank_name'];
}
?>
<!DOCTYPE>
<html>
<head><style>.modal-body { padding: 5px; } </style>
<style>
.addrembtn{margin-top: -67px; margin-bottom:0px; width:100% !important;}
<!--.col-sm-6, row {margin-top:0px;}-->
.commentrow .title2{margin-top:5px;}

.addremarkform {
    display: none;
}

.listActive1, .listActive1 td, .listActive1 td, .listActive1 a, .listActive1 font {
 
}

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
button.btn-close {
position: absolute;
    right: 13px;
    z-index: 999999;
}
.modal-body .col-sm-9 {
    text-indent: -7px;
}
@media (max-width: 768px) {
    #cssfortrpop .col-sm-4 {
	flex-shrink: 0;
	width: 40%;
	max-width: 40%;
	}
	
	#cssfortrpop .col-sm-8 {
	flex-shrink: 0;
	width: 60%;
	max-width: 60%;
	}
}	
	
</style>
</head>
<body>
<div class="container border rounded" id="cssfortrpop">
	<div class="row my-2">
	
	
	<? 

	if(isset($_GET['admin'])&&$_GET['admin']){?>
		<div class="addrembtn px-0 vnextParent">
			<div class="rightlink text-end" style="width: 95%;clear: right;">
				<p onClick="rActive(this,'.vnextParent','.vnext','active');popup_openv('<?=$data['Admins'];?>/json_pretty_print<?=$data['ex']?>?json=<?=encryptres($json_log);?>');" id="targetvkg" class="modal_trans99 nomid88 btn btn-outline-success btn-sm my-2" data-href='<?=$data['Admins'];?>/json_pretty_print<?=$data['ex']?>?json=<?=encryptres($json_log);?>' title="Payload View" ><i class="<?=(isset($data['fwicon']['eye-solid'])?$data['fwicon']['eye-solid']:'fa fa-eye');?>"></i></p>
				<a class="btn btn-outline-warning btn-sm" data-bs-toggle="collapse" href="#collapsePayloadJson" role="button" aria-expanded="false" aria-controls="collapsePayloadJson" title="Payload Json"><i class="<?=(isset($data['fwicon']['eye-solid'])?$data['fwicon']['eye-solid']:'fa fa-eye');?>"></i></a>

				<a class="btn btn-outline-danger btn-sm" data-bs-toggle="collapse" href="#PayloadResponseJson" role="button" aria-expanded="false" aria-controls="PayloadResponseJson" title="Payload Response Json"><i class="<?=(isset($data['fwicon']['eye-solid'])?$data['fwicon']['eye-solid']:'fa fa-eye');?>"></i></a>



			</div>
		</div>
		<?
	}?>




<!-- start: slider  -->	



		
<div class="collapse" id="PayloadResponseJson">
<div class="card card-body my-2"><?=$txn_value;?></div>
</div>
<div class="collapse" id="collapsePayloadJson">
<div class="card card-body my-2"><?=$json_log;?></div>
</div>

<!-- end: slider  -->	



	
     
	
	
		<h6 class="vkg-underline-red">Payout Transaction Detail</h6> 

		<div class="col-sm-4">Payment ID </div>
		<div class="col-sm-8">: <?=$post['row']['transaction_id'];?> </div>

		<div class="col-sm-4">Date</div>
		<div class="col-sm-8">: <?=prndate($post['row']['transaction_date']);?> </div>

		<div class="col-sm-4">Order Amount</div>
		<div class="col-sm-8">: <?=$ord_amt;?></div>
		
		<div class="col-sm-4">Trans. Amount</div>
		<div class="col-sm-8">: <?=$txn_amt;?> 
			<? if($accept_amount) echo '('.get_currency($post['row']['transaction_currency']).abs($accept_amount).')';?></div>

		<div class="col-sm-4">Trans. Fee</div>
		<div class="col-sm-8">: <?=fetch_amtwithcurr($post['row']['mdr_amt'],$post['row']['converted_transaction_currency']);?> (<?=$post['row']['mdr_percentage']?>%)</div>	
		
		<div class="col-sm-4">Payout Amount</div>
		<div class="col-sm-8">: <?=fetch_amtwithcurr($post['row']['payout_amount'],$post['row']['converted_transaction_currency']);?></div>
		
		<div class="col-sm-4">Available Balance</div>
		<div class="col-sm-8">: <?=fetch_amtwithcurr($post['row']['available_balance'],$post['row']['converted_transaction_currency']);?></div>

		<div class="col-sm-4">Merchant</div>
		<div class="col-sm-8">: <?=$post['row']['company_name'];?></div>

		<? if($post['row']['transaction_type']==1){ ?>	
			<div class="col-sm-4">Sender Name</div>
			<div class="col-sm-8">: <?=$post['row']['sender_name'];?></div>
				
		<? } else {
			if(isset($beneficiary_name)&&$beneficiary_name)
			{?>
				<div class="col-sm-4">Beneficiary Name</div>
				<div class="col-sm-8">: <?=$beneficiary_name;?></div>
			<?
			}
			if(isset($account_number)&&$account_number)
			{?>
				<div class="col-sm-4">Bank Account Number</div>
				<div class="col-sm-8">: <?=mask($account_number,0,4);?></div>
			<?
			}
			if(isset($bank_name)&&$bank_name)
			{?>
				<div class="col-sm-4">Bank</div>
				<div class="col-sm-8">: <?=$bank_name;?></div>
			<?
			}
		} ?>
		<div class="col-sm-4">Type</div>
		<div class="col-sm-8">: <? if($post['row']['transaction_type']==1){ echo "Credit"; }else{ echo "Debit";} ?> </div>

		<?
		if(isset($post['row']['remarks'])&&$post['row']['remarks'])
		{
		?>
			<div class="col-sm-4">Remarks</div>
			<div class="col-sm-8">: <?=$post['row']['remarks'];?></div>
		<?
		}
		if(isset($post['row']['narration'])&&$post['row']['narration'])
		{
		?>
			<div class="col-sm-4">Narration</div>
			<div class="col-sm-8">: <?=$post['row']['narration'];?></div>
		<?
		}

		if(isset($post['row']['transaction_for'])&&$post['row']['transaction_for'])
		{?>
			<div class="col-sm-4">Transaction For</div>
			<div class="col-sm-8">: <?=$data['payoutProduct'][$post['row']['transaction_for']];?></div>
		<? 
		}
		if(isset($post['row']['related_transaction_id'])&&$post['row']['related_transaction_id'])
		{?>
			<div class="col-sm-4">Related Transaction</div>
			<div class="col-sm-8">: <?=$post['row']['related_transaction_id'];?></div>
		<?
		}?>

		<div class="col-sm-4">Status</div>
		<div class="col-sm-8">: <?
			$statuscss=payout_status_class($data['SendFundStatus'][$post['row']['transaction_status']]);
			//echo $data['SendFundStatus'][$post['row']['transaction_status']];
			?>
			<span class="badge rounded-pill bg-<?=$statuscss;?>"><?=$data['SendFundStatus'][$post['row']['transaction_status']];?></span>
		</div>
		<input type="hidden" name="order_amount" id="order_amount" value="<?=$post['row']['transaction_amount'];?>">
		<input type="hidden" name="transaction_for" id="transaction_for" value="<?=$post['row']['transaction_for'];?>">
 		
	</div>

	<? if($is_admin_payout){ ?>	
		<? if($post['row']['transaction_status']==0 || $post['row']['transaction_status']==3){ ?>
		<div class="row my-2">
		<?
		if(isset($post['row']['transaction_for'])&&$post['row']['transaction_for']=="2")
		{?>
			<div class="col-sm-4">Accepted Amount</div>
			<div class="col-sm-8">: <input type="number" id="accepted_amt" name="accepted_amt" placeholder="Enter Accepted amount"  class="form-control form-control-sm float-end my-1" style="width:calc(100% - 10px);" maxlength="20" value="<?=$post['row']['transaction_amount'];?>" ></div>
		<? } ?>
		<div class="col-sm-4">Remark</div>
			<div class="col-sm-8">: <input type="text" style="width:calc(100% - 10px);" class="form-control  form-control-sm float-end my-1" id="remarks" name="remarks" placeholder="Remark" maxlength="100"></div>
		</div>
		<div class="row my-2">
			<a class="btn btn-success col-sm-2 m-2 btn-sm" href="javascript:void(0);" title="Approve this Transaction" role="button" onClick="_approve()">Accept</a>
			<a class="btn btn-danger col-sm-2 m-2 btn-sm" href="javascript:void(0);" title="Fail / Cancel this Transaction" role="button" onClick="_reject()" >Reject</a>
		</div>
		<? } ?>
	<? } ?>
	</div><?
		if(isset($post['row']['support_notes'])&&$post['row']['support_notes'])
		{?>	
		<div class="m-2">
		<h6 class="vkg-underline-red">Note Support</h6> 

			<div class="col-sm-12"><?=$post['row']['support_notes'];?></div>
		</div><?
		}?>
</body>
</html>
<script>
function _approve()
{
	var retVal= confirm('Are you sure, you want to Approve this Transaction?');
	if (retVal) {

		var remarks		=document.getElementById("remarks").value;
		url = "<?=$data['Admins'];?>/payout-transaction<?=$data['ex']?>?bid=<?=$post['row']['id'];?>&mid=<?=$post['row']['sub_client_id'];?>&order_curr=<?=$post['row']['transaction_currency'];?>&order_amt=<?=$post['row']['transaction_amount'];?>&action=approved"+"&remarks="+remarks;

		var order_amount	=document.getElementById("order_amount").value;

		var transaction_for	=document.getElementById("transaction_for").value;
//alert(url);return false;
		if(transaction_for=='2')
		{
			var accepted_amt=document.getElementById("accepted_amt").value;
			
		
			if(accepted_amt.length==0)
			{
				alert("Accpeted Amount Should not be empty");
				return false;
			}
			else 
			{
				var lnum = new Number(accepted_amt);
				var hnmu = new Number(order_amount);
				if(lnum>hnmu)
				{
					alert("Accpeted amount must be less than or equal to order amount");
					return false;
				}
				else url=url+"&accepted_amt="+accepted_amt
			}
		}
		
		location.href=url;
		return true;
	} else {			
		return false;
	}
	
}
function _reject()
{
	var retVal= confirm('Are you sure, you want to Cancel this Transaction?');
	if (retVal) {
	
		var remarks=document.getElementById("remarks").value;  
		
		url = "<?=$data['Admins'];?>/payout-transaction<?=$data['ex']?>?bid=<?=$post['row']['id'];?>&mid=<?=$post['row']['sub_client_id'];?>&remarks="+remarks+"&action=fail";
		
		location.href=url;
		return true;
	} else {			
		return false;
	}
}
</script>
<? db_disconnect();?>