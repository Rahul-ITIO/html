<? if(isset($data['ScriptLoaded'])){
if(isset($_SESSION['uid'])&&$_SESSION['uid']) $uid = $_SESSION['uid'];
$gid=isset($gid)&&$gid?$gid:$post['id'];
?>
<?php /*?>include for table responsive on mobile<?php */?>
<div id="zink_id">

<? if($post['step']==1){ ?>

<div class="container my-2 py-2 border rounded">
	<div class="row vkg">
		<div class="col-sm-12 ">
			<h4><i class="<?=$data['fwicon']['arrow-right-arrow-left'];?> fa-fw"></i> Transfers</h4>
		</div>

	</div>
<div>



<div class="row payout_search_css">
<div class="col-sm-8 text-start py-2">
All transfers including batch are shown here.  <?php /*?><a href="#" class="text-info">Know more </a><?php */?>
</div>

<div class="col-sm-4 dropdown dropstart text-end pe-2">
  <a class="text-primary btn btn-primary btn-sm my-2" id="Bendropid" data-bs-toggle="dropdown" aria-expanded="false" title="Fund Transfer" ><i class="<?=$data['fwicon']['circle-plus'];?>"></i></a>
  
<ul class="dropdown-menu" aria-labelledby="Bendropid">
    <li><a class="dropdown-item hrefmodal" data-tid="Quick Transfer - <?=$gid;?>" data-href="<?=($data['Host']."/user/send-fund".$data['ex']);?>?action=details&tempui=<?=$data['frontUiName']?>&HideAllMenu=1&pdisplay=pop"><i class="<?=$data['fwicon']['message-to-send'];?> fa-fw text-primary"></i> Quick Transfer</a></li>
	
    <li><a class="dropdown-item" href="<?=($data['Host']."/user/upload-fund".$data['ex']);?>"><i class="<?=$data['fwicon']['batch-transfer'];?> fa-fw text-primary"></i> Batch Transfer</a></li>
  </ul>


</div>
</div>
<?php /*?>for display success / Failed Message<?php */?> 
<? include $data['Path']."/include/message".$data['iex'];?>

<?
//Include file for search form
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
<div class="alert alert-light fw-bold" role="alert">
  Result show: </span><?=$data['rec_start'];?> - <?=$data['rec_end'];?> of <?=$data['total_record']?> :: 
<? 
$seperator=" <i class='".$data['fwicon']['hand']."'></i>";
if(isset($_REQUEST['key_name'])&&$_REQUEST['key_name']=="transaction_id"){ echo $seperator." TransID : ".$_REQUEST['searchkey']; }
if(isset($_REQUEST['key_name'])&&$_REQUEST['key_name']=="mrid"){ echo $seperator." Reference : ".$_REQUEST['searchkey']; }
if(isset($_REQUEST['date_1st'])&&$_REQUEST['date_1st']){ echo $seperator." Date Range : ".$_REQUEST['date_1st']." To ".$_REQUEST['date_2nd']; }
if(isset($_REQUEST['status'])&&$_REQUEST['status']<>""){ echo $seperator." Status : ".$data['SendFundStatus'][$_REQUEST['status']]; }

if(isset($_REQUEST['records_per_page'])&&$_REQUEST['records_per_page']){ echo $seperator." Record Per Page : ".$_REQUEST['records_per_page']; }
  
?>
</div>
<? if(isset($data['total_record'])&& ($data['total_record'] > 0)){ ?>

	<div class="table-responsive my-1 p-list">
	<table class="table table-striped">
		
			<thead>
				<tr class="bg-dark-subtle">
				    <th valign="top"><div class="transaction-h1">TransID</div><div class="transaction-h2">Reference</div></th>
					<th valign="top"><div class="transaction-h1">Beneficiary&nbsp;Name</div><div class="transaction-h2">A/C&nbsp;Number</div></th>
					<th valign="top"><div class="transaction-h1">Bill&nbsp;Amt</div><div class="transaction-h2">Trans.&nbsp;Amount</div></th>
					<th valign="top"><div class="transaction-h1">Trans&nbsp;Fee </div></th>
					<th valign="top"><div class="transaction-h1">Available&nbsp;Balance</div></th>
					<th valign="top"><div class="transaction-h1">Timestamp</div><div class="transaction-h2">Created&nbsp;Date</div></th>
					<th valign="top"><div class="transaction-h1">Trans Status</div></th>
					<th valign="top"><div class="transaction-h1">Trans Response</div></th></tr>
					</tr>
			</thead>
	
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
			
			foreach($data['TransData'] as $value)
			{
				$check_status = jsonvaluef($value['json_log'],'check_status');

				$beneficiary_name=$account_number="";
				if(isset($value['beneficiary_id'])&&$value['beneficiary_id'])
				{
					$beneficiary_name	=@$bene_list[$value['beneficiary_id']]['beneficiary_name'];	
					$account_number		=@mask($bene_list[$value['beneficiary_id']]['account_number'],0,4);	
				}
				if(isset($value['reason'])&&$value['reason']) 
					$reason_remark=$value['reason'];
				else $reason_remark = $value['remarks'];
			?>
				<tr class="rounded"><td valign="top">
				
				
				<a class="hrefmodal mt-2 text-link transaction-list-h1" <? //style="white-space:nowrap;" ?> data-tid="<?=$value['transaction_id']?>" data-href="<?=($data['Host']."/include/payout_transactions_details".$data['ex']);?>?bid=<?=$value['id'];?>&mid=<?=$value['sub_client_id'];?>&action=details&tempui=<?=$data['frontUiName']?>" title="<?=$value['transaction_id'];?>" ><span class="d-inline-block text-truncate" style="max-width: 90px;" title="<?=$value['transaction_id'];?>"><?=$value['transaction_id'];?></span></a>
				<div title="<?=$value['mrid'];?>" data-bs-toggle="tooltip" data-bs-placement="top" style="width:90px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" class="mx-0 transaction-list-h2"><?=$value['mrid'];?></div>		
				
				</td>
				<td  valign="top"><div class="transaction-list-h1"><? if($value['transaction_type']==1){ echo $value['sender_name']; } else { echo $beneficiary_name;}?></div>
				<div class="transaction-list-h2"><? echo $account_number;?></div></td>
					
					<td  valign="top"><div class="transaction-list-h1"><?=fetch_amtwithcurr($value['transaction_amount'],$value['transaction_currency']);?></div>
<div class="transaction-list-h2"><?=fetch_amtwithcurr($value['converted_transaction_amount'],$value['converted_transaction_currency']);?></div></td>

					<td valign="top"><?=fetch_amtwithcurr($value['mdr_amt'],$value['converted_transaction_currency']);?></td>
					<td valign="top"><?=fetch_amtwithcurr($value['available_balance'],$value['converted_transaction_currency']);?></td>
					<td valign="top"><div class="transaction-list-h1"><?=prndate($value['transaction_date'])?></div>
				<div class="transaction-list-h2"><?=prndate($value['created_date'])?></div></td>
					
					<td valign="top"> 
					<? $statuscss=payout_status_class($data['SendFundStatus'][$value['transaction_status']]); ?> 
					<span class="badge rounded-pill bg-<?=$statuscss;?>" id="statusdisplay" data-bs-toggle="dropdown" aria-expanded="false"><?=$data['SendFundStatus'][$value['transaction_status']];?></span>

					<? 
					if($value['transaction_status']=='0'&&isset($check_status)&&$check_status)
					{
					?>
					<ul class="dropdown-menu" aria-labelledby="statusdisplay">
						<li><a class="dropdown-item hrefmodal" data-tid="<?=$gid;?>" data-href="<?=($data['Host']."/".$check_status);?>?bid=<?=$value['id'];?>&mid=<?=$value['sub_client_id'];?>&transaction_id=<?=$value['transaction_id']?>&action=details&tempui=<?=$data['frontUiName']?>"><i class="<?=$data['fwicon']['hand'];?> fa-fw text-primary"></i> Status</a></li>
						</ul>
					<?
					}?>
					</td>
					<td  valign="top"><span class="d-inline-block text-truncate" itle="<?=$value['mrid'];?>" data-bs-toggle="tooltip" data-bs-placement="left" style="max-width: 70px;" title="<?=$reason_remark;?>"><?=$reason_remark;?></span></td>
			  </tr>
			<? $idx++; } ?>
			
			</tbody>
		</table>
	  </div>

		<?
        // include file for pagination
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


</div>
<? } ?>

</div>
<?php /*?>set modal popup width<?php */?>
<script>$('#myModal90 .modal-dialog').css({"max-width":"500px"});</script>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
