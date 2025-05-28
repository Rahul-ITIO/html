<? if(isset($data['ScriptLoaded']))
{
	global $uid;
?>
<link href="<?=$data['TEMPATH']?>/common/css/table-responsive.css" rel="stylesheet">

<div id="zink_id" class="container border my-2 bg-white rounded" >

<? include $data['Path']."/include/message".$data['iex'];?>

<?php if((!isset($_GET['action']) || $_GET['action']!='update') && (!isset($post['step']) || $post['step']!="2")){ ?>
<div class="row vkg row clearfix_ice">
	<div class="col-sm-12 py-2">
		<h4 class="float-start"><i class="fas fa-money-check-alt"></i> Payout Transaction</h4>
	</div>

	<?
	include_once $data['Path']."/include/payout-search".$data['iex'];

	$data['view_balance']=1;
	include_once $data['Path']."/include/payout-menu".$data['iex']; ?>
<? } ?>
<form method="post" name="data">
	<input type="hidden" name="step" value="<?=$post['step']?>">
	<? if($post['step']==1){ ?>
	<? if(isset($_SESSION['query_status'])&&$_SESSION['query_status']){ ?>
	<div class="container mt-2">
		<div class="alert alert-success alert-dismissible fade show" role="alert"><strong>Success!</strong>
		<?=$_SESSION['query_status']?>
		<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
	</div>	
</div>
<? unset($_SESSION["query_status"]);} ?>

	<div class="mb-2 table-responsive">
		<table>
		<? if($data['cntdata'] > 0 ){ ?>
			<span class="text-warning">Result show: </span><?=$data['rec_start'];?> - <?=$data['rec_end'];?> of <?=$data['total_record']?>
			<thead>
				<tr class="table table-dark table-hover"><th>Transaction ID</th>
					<th>M.OrderId</th>
					<th>Date</th>
					<th>Order Amount</th>
					<th>Trans Amount</th>
					<th>Trans Fee </th>
					<th>Balance</th>
					<th>Beneficiary Name </th>
					<th>Account Number</th>
					<!--<th width="80px">Type</th> -->
					<th width="100px">Status</th>
					<th>Reason</th></tr>
			</thead>
			
		<? }else { ?>
			<thead><tr><td colspan="11">Transaction Not Found</td></thead>
		<? } ?>
			<tbody>
			<? 
			$result_select=db_rows_2(
				"SELECT * FROM `{$data['DbPrefix']}payout_beneficiary`".
				" WHERE `clientid`='{$uid}' AND status='1'".
				" ORDER BY id",0
			);
	
			foreach ($result_select as $key => $val) {
				$bene_list[$val['bene_id']] = $val;
			}
			
			$idx=0;
			
			foreach($data['TransData'] as $value){
			
				$beneficiary_name=$account_number="";
				if(isset($value['beneficiary_id'])&&$value['beneficiary_id'])
				{
					$beneficiary_name	=@$bene_list[$value['beneficiary_id']]['beneficiary_name'];	
					$account_number		=@mask($bene_list[$value['beneficiary_id']]['account_number'],0,4);	
				}
			?>
				<tr valign="top" class="rounded"><td data-label="Transaction ID" title='<?=$value['transaction_id'];?>'><a class="hrefmodal mt-2 text-decoration-none" <? //style="white-space:nowrap;" ?> data-tid="<?=$value['transaction_id']?>" data-href="<?=($data['Host']."/include/payout_transactions_details".$data['ex']);?>?bid=<?=$value['id'];?>&mid=<?=$value['sub_client_id'];?>&action=details&tempui=<?=$data['frontUiName']?>" title="<?=$value['transaction_id'];?>" ><?=$value['transaction_id'];?></a></td>
				<td title="Mrid" data-label="M.OrderId :"><?=$value['mrid'];?></td>
					<td data-label="Date"><?=prndate($value['transaction_date'])?></td>
					<td data-label="Order Amount"><?=fetch_amtwithcurr($value['transaction_amount'],$value['transaction_currency']);?></td>
					<td data-label="Transaction Amount"><?=fetch_amtwithcurr($value['converted_transaction_amount'],$value['converted_transaction_currency']);?></td>
					<td data-label="Transaction Fee"><?=fetch_amtwithcurr($value['mdr_amt'],$value['converted_transaction_currency']);?></td>
					<td data-label="Balance"><?=fetch_amtwithcurr($value['available_balance'],$value['converted_transaction_currency']);?></td>
					<td data-label="Beneficiary Name"><? if($value['transaction_type']==1){ echo $value['sender_name']; } else { echo $beneficiary_name;}?></td>
					<td data-label="Account_number"><? echo $account_number;?></td>
					<td title="Status" data-label="Status : " nowrap> <? $statuscss=payout_status_class($data['SendFundStatus'][$value['transaction_status']]); ?> 
						<span class="badge rounded-pill bg-<?=$statuscss;?>"><?=$data['SendFundStatus'][$value['transaction_status']];?></span></td>
					<td title="Reason" data-label="Reason :"><?=$value['reason'];?></td></tr>
				<? $idx++; } ?>
			</tbody>
		</table>
		</div>

		<?

		include $data['Path']."/include/pagination_new".$data['iex'];

		$get=http_build_query($_REQUEST);

	//	$url="payout-transaction".$data['ex']."?".$get;
		$url=$_SERVER['PHP_SELF']."?".$get;

		if(isset($data['total_record'])&&$data['total_record']) $total = $data['total_record'];
		else $total = 0;
		
		pagination_new($data['MaxRowsByPage'],$data['startPage'],$url,$total);
		} ?>	
		<input type="hidden" id="memidx" value="<?=$post['id'];?>">
	</form>
</div>
<script>
function CopyToClipboard2(text) {
	text=$(text).html();
	//alert(text);
	var $txt = $('<textarea />');

	$txt.val(text)
		.css({ width: "1px", height: "1px" })
		.appendTo('body');

	$txt.select();

	if (document.execCommand('copy')) {
		$txt.remove();
		alert(text+"\n\nCopied.");
	}
}

$(document).ready(function(){
	$("#currbal").click(function(){
		var memidx = $("#memidx").val();
		$.ajax({
			type: "POST",
			url: "../include/payout-balance-request<?=$data['ex'];?>",
			data: { memid : memidx } 
		}).done(function(data){
			$("#currbal").html(data);
		});
	});
});
</script>

</div>
<? }else{ ?>
	SECURITY ALERT: Access Denied
<? } ?>
