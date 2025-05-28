<? if(isset($data['ScriptLoaded'])){?>
<link href="<?=$data['TEMPATH']?>/common/css/table-responsive.css" rel="stylesheet">
<div id="zink_id" class="bg-white">

<? include $data['Path']."/include/message".$data['iex'];?>
<? if($post['step']==1){ ?>

<div class="container my-2 py-2 border rounded" >
	<div class="row vkg">
		<div class="col-sm-12 ">
			<h4><i class="fa-solid fa-file-lines fa-fw"></i> Statement</h4>
		</div>

	</div>
<div >

 

<div class="py-3">All Success transfers including batch are shown here. <?php /*?><a href="#" class="text-info">Know more </a><?php */?></div>


<?
//search form by Vikash
$search_form=("../front_ui/{$data['frontUiName']}/common/template.payout_search_form".$data['iex']);
	if(file_exists($search_form)){
	include($search_form);
	}else{
	$search_form=("../front_ui/default/common/template.payout_search_form".$data['iex']);
	if(file_exists($search_form)){
	include($search_form);
	}
	}
  ?> 

  
<? if(isset($data['TransData'])&&count($data['TransData'])>0){?>
<span class="text-warning">Result show: </span><?=$data['rec_start'];?> - <?=$data['rec_end'];?> of <?=$data['total_record']?>
<? }?>
	<div class="mb-2 table-responsive p-list">
	<table>
	
		<thead>
			<tr class="table table-dark table-hover"><th>Payment ID</th>
				<th>M.OrderId</th>
				<th>Order Amount</th>
				<th>Trans Amount</th>
				<th>Trans Fee </th>
				<th>Balance</th>
				<th>Timestamp</th>
				<th width="100px">Status</th></tr>
		</thead>

		<tbody>
		<? 
		if(isset($data['TransData'])&&count($data['TransData'])>0){
		$result_select=db_rows_2(
			"SELECT * FROM `{$data['DbPrefix']}payout_beneficiary`".
			" WHERE `clientid`='{$uid}' AND status='1'".
			" ORDER BY id",0
		);

		foreach ($result_select as $key => $val) {
			$bene_list[$val['id']] = $val;
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
				<td title="Mrid" data-label="M.OrderId"><?=$value['mrid'];?></td>
				
				<td data-label="Order Amount"><?=fetch_amtwithcurr($value['transaction_amount'],$value['transaction_currency']);?></td>
				<td data-label="Transaction Amount"><?=fetch_amtwithcurr($value['converted_transaction_amount'],$value['converted_transaction_currency']);?></td>
				<td data-label="Transaction Fee"><?=fetch_amtwithcurr($value['mdr_amt'],$value['converted_transaction_currency']);?></td>
				<td data-label="Balance"><?=fetch_amtwithcurr($value['available_balance'],$value['converted_transaction_currency']);?></td>
				<td data-label="Timestamp"><?=prndate($value['transaction_date'])?></td>
				<td data-label="Status"><? if($value['transaction_status']==0){ $tstatus="Pending"; $tstatuscss="bg-warning"; }elseif($value['transaction_status']==1){ $tstatus="Success"; $tstatuscss="bg-success"; }else{ $tstatus="Failed"; $tstatuscss="bg-danger";} ?><span class="badge rounded-pill <?=$tstatuscss;?>"> <?=$tstatus;?> </span></td></tr>
			<? $idx++; } ?>
		    <? }else{ ?>
			<tr valign="top" class="rounded"><td title="No record exists" colspan="8"><div class="alert alert-danger" role="alert">No record exists</div></td></tr>
			<?
			}
			?>
		</tbody>
	</table>
	</div>

	<style>
		.pagination {margin: 10px 0 5px 0 !important;}
		html ul.pagination2 li a.current, html ul.pagination li a.current {font-weight:bold;background:var(--background-1)!important;color:#fff !important;border-radius:3px;}
		html ul.pagination {width:fit-content;float:unset;margin:10px auto!important;padding:0 0 10px!important;height:fit-content;}
		html ul.pagination li {float:left;}
		html ul.pagination li a {padding:5px 10px; margin:0 2px; border:1px solid var(--background-1); }
		</style>
		<?

		include $data['Path']."/include/pagination_new".$data['iex'];

		$get=http_build_query($_REQUEST);

		$url=$_SERVER['PHP_SELF']."?".$get;
	
		if(isset($data['total_record'])&&$data['total_record']) $total = $data['total_record'];
		else $total = 0;
		
		pagination_new($data['MaxRowsByPage'],$data['startPage'],$url,$total);
		?>
	

	


</div>


</div>
<? } ?>

</div>
<script>$('#myModal90 .modal-dialog').css({"max-width":"500px"});</script>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
