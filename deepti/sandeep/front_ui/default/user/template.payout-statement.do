<? if(isset($data['ScriptLoaded'])){
	global $uid;
?>
<link href="<?=$data['TEMPATH']?>/common/css/table-responsive.css" rel="stylesheet">

<div id="zink_id" class="container border my-2 bg-white rounded" >
<?php if((!isset($_GET['action']) || $_GET['action']!='update') and (!isset($post['step']) || $post['step']!="2")){ ?>
<div class="row vkg row clearfix_ice">
	<div class="col-sm-12 py-2">
		<h4 class="float-start"><i class="fas fa-money-check-alt"></i> Payout Statement </h4>
		<? if(!isset($_GET['admin'])) { ?>
		<div class="float-end"><a class="btn btn-danger btn-sm mb-1" href="payout-statement-pdf<?=$data['ex'];?>?bid=<?=$post['id'];?>" title="Download Payout Statement" target="_blank" style="float: right;" download=""><i class="far fa-file-pdf text-light"></i></a>
	</div>
	<? } ?>
	<? 
	include_once $data['Path']."/include/payout-search".$data['iex'];
	$data['view_balance']=1;
	//include "../front_ui/{$data['frontUiName']}/common/payout-menu".$data['iex']; 
	include "../include/payout-menu".$data['iex']; ?>
	</div>
</div>
<? } ?>

<? if($post['step']==1){ ?>
	<? if(isset($_SESSION['query_status'])&&$_SESSION['query_status']){ ?>
	<div class="container mt-2">
		<div class="alert alert-success alert-dismissible fade show" role="alert"><strong>Success!</strong>
			<?=$_SESSION['query_status']?>
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		</div>
	</div>
	<? unset($_SESSION["query_status"]);} ?>
	<?
	/*
	<div class="row bg-light my-2">
		<div class="col-md-8 my-2 px-2">
			<form method="get">
				<div class="row">
					<div class="col-md-5 px-2">
						<div class="form-group row">
							<label for="inputEmail3" class="col-sm-4 col-form-label">Start Date</label>
							<div class="col-sm-8">
								<input type="date" class="form-control" name="start_date" required="">
							</div>
						</div>
					</div>
					<div class="col-md-5 px-2">
						<div class="form-group row">
							<label for="inputEmail3" class="col-sm-4 col-form-label">End Date</label>
							<div class="col-sm-8">
								<input type="date" class="form-control" name="end_date" required="">
							</div>
						</div>
					</div>
					<div class="col-md-2 px-2">
						<button type="submit" class="btn btn-primary float-end">Search</button>
					</div>									
				</div>
			</form>
		</div>
		<div class="col-md-4 my-2">
			<form method="get">
				<div class="input-group form-row">
					<input type="text" class="form-control" placeholder="Search..." required="" name="value" autocomplete="off" value="">
					<select class="form-control" name="type">
						<option value="transaction_id">Transection No</option>
					</select>
					<div class="input-group-append">											
						<button class="btn btn-primary" type="submit"><i class="fas fa-search"></i></button>
					</div>
				</div>
			</form>
		</div>
	</div>
	*/?>
<?php $total_count=count($data['TransData']); ?>
	<div class="mb-2 table-responsive">
	<table>
	<? // if($total_count > 0 ){ ?>
	<? if($data['cntdata'] > 0 ){ ?>
			<span class="text-warning">Result show: </span><?=$data['rec_start'];?> - <?=$data['rec_end'];?> of <?=$data['total_record']?>
		<thead>
			<tr class="table table-dark table-hover"><th>Transaction ID</th>
				<th>Date</th>
				<th>Order Amount</th>
				<th>Trans Amount</th>
				<th>Trans Fee </th>
				<th>Balance</th>
				<th>Beneficiary Name </th>
				<th>Account Number</th>
				<!--<th width="80px">Type</th> -->
				<th width="100px">Status</th></tr>
		</thead>
		<? }else { ?>
		
		<thead>
			<tr><th colspan="9">Statement Not Found</th>

		</thead>
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
		$idx = 0;
		foreach($data['TransData'] as $value){
		
			$beneficiary_name=$account_number="";
			if(isset($value['beneficiary_id'])&&$value['beneficiary_id'])
			{
				$beneficiary_name	=$bene_list[$value['beneficiary_id']]['beneficiary_name'];	
				$account_number		=mask($bene_list[$value['beneficiary_id']]['account_number'],0,4);	
			}
		?>
			<tr valign="top" class="rounded"><td data-label="Transaction ID" title='<?=$value['transaction_id'];?>'><a class="hrefmodal mt-2 text-decoration-none" <? //style="white-space:nowrap;" ?> data-tid="<?=$value['transaction_id']?>" data-href="<?=($data['Host']."/include/payout_transactions_details".$data['ex']);?>?bid=<?=$value['id'];?>&mid=<?=$value['sub_client_id'];?>&action=details&tempui=<?=$data['frontUiName']?>" title="<?=$value['transaction_id'];?>" ><?=$value['transaction_id'];?></a></td>
				<td data-label="Date"><?=prndate($value['transaction_date'])?></td>
				<td data-label="Order Amount"><?=fetch_amtwithcurr($value['transaction_amount'],$value['transaction_currency']);?></td>
				<td data-label="Transaction Amount"><?=fetch_amtwithcurr($value['converted_transaction_amount'],$value['converted_transaction_currency']);?></td>
				<td data-label="Transaction Fee"><?=fetch_amtwithcurr($value['mdr_amt'],$value['converted_transaction_currency']);?></td>
				<td data-label="Balance"><?=fetch_amtwithcurr($value['available_balance'],$value['converted_transaction_currency']);?></td>
				<td data-label="Beneficiary Name"><? if($value['transaction_type']==1){ echo $value['sender_name']; } else { echo $beneficiary_name;}?></td>
				<td data-label="Account_number"><? echo $account_number;?></td>
				<td data-label="Status"><? if($value['transaction_status']==0){ $tstatus="Pending"; $tstatuscss="bg-warning"; }elseif($value['transaction_status']==1){ $tstatus="Success"; $tstatuscss="bg-success"; }else{ $tstatus="Failed"; $tstatuscss="bg-danger";} ?><span class="badge rounded-pill <?=$tstatuscss;?>"> <?=$tstatus;?> </span></td></tr>
			<? $idx++; 
		} ?>
		</tbody>
	</table>
	</div>
	
		<?

		include $data['Path']."/include/pagination_new".$data['iex'];

		$get=http_build_query($_REQUEST);

		$url=$_SERVER['PHP_SELF']."?".$get;
	
		if(isset($data['total_record'])&&$data['total_record']) $total = $data['total_record'];
		else $total = 0;
		
		pagination_new($data['MaxRowsByPage'],$data['startPage'],$url,$total);
		?>
	
<? } ?>
<input type="hidden" id="memidx" value="<?=$post['id'];?>">
</form>
<script>
$(document).ready(function(){
	$("#currbal").click(function(){
		var memidx = $("#memidx").val();
		$.ajax({
			type: "POST",
			url: "../include/payout-balance-request<?=$data['ex'];?>",
			data: { memid : memidx } 
		}).done(function(data){
			//alert(data);
			$("#currbal").html(data);
		});
	});
});
</script>
</div>

<? }else{ ?>
	SECURITY ALERT: Access Denied
<? } ?>
