<? if(isset($data['ScriptLoaded'])){ ?>
<div id="zink_id" >

<? include $data['Path']."/include/message".$data['iex'];?>
<? if($post['step']==1){ ?>

<div class="container my-2 py-2 border rounded" >
	<div class="row">
		<div class="col-sm-12 ">
			<h4><i class="<?=$data['fwicon']['mystatement'];?> fa-fw"></i> Statement</h4>
		</div>

	</div>


 

<div class="py-3">All Success transfers including batch are shown here. <?php /*?><a href="#" class="text-info">Know more </a><?php */?></div>

<div class="clearfix"></div>
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
<div class="alert alert-light fw-bold" role="alert">
  Result show: </span><?=$data['rec_start'];?> - <?=$data['rec_end'];?> of <?=$data['total_record']?> :: 
<? }?>
<? 
$seperator=" <i class='".$data['fwicon']['hand']."'></i>";
if(isset($_REQUEST['key_name'])&&$_REQUEST['key_name']=="transaction_id"){ echo $seperator." TransID : ".$_REQUEST['searchkey']; }
if(isset($_REQUEST['key_name'])&&$_REQUEST['key_name']=="mrid"){ echo $seperator." Reference : ".$_REQUEST['searchkey']; }
if(isset($_REQUEST['date_1st'])&&$_REQUEST['date_1st']){ echo $seperator." Date Range : ".$_REQUEST['date_1st']." To ".$_REQUEST['date_2nd']; }

if(isset($_REQUEST['records_per_page'])&&$_REQUEST['records_per_page']){ echo $seperator." Record Per Page : ".$_REQUEST['records_per_page']; }
  
?>
</div>

<? if(isset($data['total_record'])&& ($data['total_record'] > 0)){ ?>

	<div class="table-responsive my-1 p-list">
	<table class="table table-striped">
	
		<thead>
		<tr class="bg-dark-subtle"><th valign="top"><div class="transaction-h1">TransID</div><div class="transaction-h2">Reference</div></th>
			<th valign="top"><div class="transaction-h1">Bill&nbsp;Amt</div><div class="transaction-h2">Trans&nbsp;Amount</div></th>
			<th valign="top"><div class="transaction-h1">Trans&nbsp;Fee</div></th>
			<th valign="top"><div class="transaction-h1">Available Balance</div></th>
			<th valign="top"><div class="transaction-h1">Timestamp</div><div class="transaction-h2">Created&nbsp;Date</div></th>
			<th valign="top"><div class="transaction-h1">Trans&nbsp;Status</div></th>
		</tr>
		</thead>

		<tbody>
		<?
        if(isset($data['TransData'])&&count($data['TransData'])>0){ 
		$uid=$post['id'];
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
				$beneficiary_name	=@$bene_list[$value['beneficiary_id']]['beneficiary_name'];	
				$account_number		=@mask($bene_list[$value['beneficiary_id']]['account_number'],0,4);	
			}
		?>
			<tr valign="top" class="rounded">
			
			<td valign="top">
			
			<a class="hrefmodal mt-2 text-link transaction-list-h1" <? //style="white-space:nowrap;" ?> data-tid="<?=$value['transaction_id']?>" data-href="<?=($data['Host']."/include/payout_transactions_details".$data['ex']);?>?bid=<?=$value['id'];?>&mid=<?=$value['sub_client_id'];?>&action=details&tempui=<?=$data['frontUiName']?>" title="<?=$value['transaction_id'];?>" ><?=$value['transaction_id'];?></a>
			
<div title="<?=$value['mrid'];?>" data-bs-toggle="tooltip" data-bs-placement="top" style="width:90px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" class="mx-0 transaction-list-h2"><?=$value['mrid'];?></div>			
			
			</td>
				
				<td valign="top">
<div class="transaction-list-h1"><?=fetch_amtwithcurr($value['transaction_amount'],$value['transaction_currency']);?></div>
<div class="transaction-list-h2"><?=fetch_amtwithcurr($value['converted_transaction_amount'],$value['converted_transaction_currency']);?></div>
				</td>
				<td valign="top"><div class="transaction-list-h1"><?=fetch_amtwithcurr($value['mdr_amt'],$value['converted_transaction_currency']);?></div></td>
				<td valign="top"><div class="transaction-list-h1"><?=fetch_amtwithcurr($value['available_balance'],$value['converted_transaction_currency']);?></div></td>
				<td valign="top">
				<div class="transaction-list-h1"><?=prndate($value['transaction_date'])?></div>
				<div class="transaction-list-h2"><?=prndate($value['created_date'])?></div></td>
				<td valign="top">
				<div class="transaction-list-h1">
				<? if($value['transaction_status']==0){ $tstatus="Pending"; $tstatuscss="bg-warning"; }elseif($value['transaction_status']==1){ $tstatus="Success"; $tstatuscss="bg-success"; }else{ $tstatus="Failed"; $tstatuscss="bg-danger";} ?><span class="badge rounded-pill <?=$tstatuscss;?>"> <?=$tstatus;?> </span>
				</div>
				</td></tr>
			<? $idx++; } ?>
		    
		    <? }else{ ?>
			<tr valign="top" class="rounded"><td title="No record exists" colspan="8"><div class="alert alert-danger" role="alert">No record exists</div></td></tr>
			<?
			}
			?>
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
	
<? }else{ ?>
  <div class="alert alert-danger my-2" role="alert"><strong>No Records exists</strong></div>
<? } ?>
	


</div>



<? } ?>

</div>
<script>$('#myModal90 .modal-dialog').css({"max-width":"500px"});</script>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
