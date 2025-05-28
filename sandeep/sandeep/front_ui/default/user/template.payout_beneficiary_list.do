<?
// include for display font awasome icon
include($data['Path'].'/include/fontawasome_icon'.$data['iex']);
?>

<style>
	.modal-body { padding: 5px; } 
	.modal-dialog { width:1000px !important;}

</style>


<div id="zink_id" class="container border rounded my-2" >
	<div class="vkg row my-2">
	<? include $data['Path']."/include/message".$data['iex'];?>
		<h4 class="float-start"><i class="<?=$data['fwicon']['user-double'];?>"></i> Payout Beneficiary List</h4>
		
		<? if($data['cntdata'] > 0 ){ ?>
		
			<div class="text-primary my-2 fw-bold">Result show: </span><?=$data['rec_start'];?> - <?=$data['rec_end'];?> of <?=$data['total_record']?></div>
		<div class="mb-2 table-responsive">
	<table class="table table-striped">
		<thead>
			<tr class="bg-dark-subtle">
			        <th scope="col" valign="top"><div class="transaction-h1">Beneficiary&nbsp;ID</div><div class="transaction-h2">Pulling&nbsp;Time</div></th>
					<th scope="col" valign="top"><div class="transaction-h1">Beneficiary&nbsp;Name</div><div class="transaction-h2">Nickname</div></th>
					<th scope="col" valign="top"><div class="transaction-h1">Bank&nbsp;Name</div><div class="transaction-h2">A/C&nbsp;Number</div></th>
					<th scope="col" valign="top"><div class="transaction-h1">Bank&nbsp;Code&nbsp;1</div><div class="transaction-h2">Bank&nbsp;Code&nbsp;2</div></th>
					<th scope="col" valign="top"><div class="transaction-h1">Bank Code 3</div></th></tr>
			</thead>
			<tbody>
				<? foreach($data['bene_list'] as $key=>$val){ ?> 
				<tr class="rounded">
				    <td  valign="top">
					<div class="transaction-list-h1"><?=$val['bene_id'];?></div>
				    <div class="text-bg-info px-1 rounded transaction-list-h2" style="width: max-content;" title="Pulling Time"><?=get_pulling_status($val['created_date']);?></div>
					</td>
					<td  valign="top">
					<div class="transaction-list-h1"><?=$val['beneficiary_name'];?></div>
					<div class="transaction-list-h2"><?=$val['beneficiary_nickname'];?></div>
					</td>
					<td  valign="top">
					<div class="transaction-list-h1"><?=$val['bank_name'];?></div>
					<div class="transaction-list-h2"><?=mask($val['account_number'],0,4);?></div>
					</td>
					<td  valign="top">
					<div class="transaction-list-h1"><?=$val['bank_code1'];?></div>
					<div class="transaction-list-h2"><?=$val['bank_code2'];?></div>	
					</td>
					<td  valign="top"><div class="transaction-list-h1"><?=$val['bank_code3'];?></div></td></tr>
				<? } ?>
			</tbody>
		</table></div>
		<?
		}
		else
		{?>
		<div class="alert alert-danger">
			No any beneficiary exists.
		</div>
		<? }
		?>
		 
	</div>
	
		<?

		include $data['Path']."/include/pagination_new".$data['iex'];

		$get=http_build_query($_REQUEST);

		$url=$_SERVER['PHP_SELF']."?".$get;
	
		if(isset($data['total_record'])&&$data['total_record']) $total = $data['total_record'];
		else $total = 0;
		
		pagination_new($data['MaxRowsByPage'],$data['startPage'],$url,$total);
		?>
</div>

<script>
$(document).ready(function(){
	$('#myModal .modal-dialog').css({"max-width":"90%"});
});
</script>
<? db_disconnect();?>