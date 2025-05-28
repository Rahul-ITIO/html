<? ?>
<style>
@media (max-width: 550px){
.bene-search .col { flex: 1 0 50%;}
}
</style>
<div class="container border my-1 rounded" id="cssfortrpop">
<?php /*?>include for Display Success / failed Message<?php */?>
<? include $data['Path']."/include/message".$data['iex'];?>
<div class="class="container text-end px-0 vkg"">
	<h4 class="my-2 float-start"><i class="<?=$data['fwicon']['user-double'];?>"></i> Payout Beneficiary List</h4>
</div>
	<div class="clearfix"></div>
		<div class="col-sm-12 bg-primary border rounded mb-2">
			<form method="get">
				<div class="row bene-search">
					<div class="col px-1">
<input type="text" class="form-control form-control-sm mx-1 my-1" placeholder="Beneficiary ID" name="bene_id" id="bene_id" autocomplete="off">
					</div>
					<div class="col px-1">
<input type="text" class="form-control  form-control-sm mx-1 my-1" placeholder="Beneficiary Name" name="beneficiary_name" id="beneficiary_name" autocomplete="off">
					</div>
					<div class="col">
<input type="text" class="form-control form-control-sm mx-1 my-1" placeholder="Bank Name" name="bank_name" id="bank_name" autocomplete="off">
					</div>
					<div class="col px-1">
					<input type="text" class="form-control form-control-sm float-start mx-1  my-1" placeholder="Bank Code" name="bank_code" id="bank_code" autocomplete="off" style="width: calc(100% - 50px) !important;">
					<button type="submit" class="btn btn-primary btn-sm s_validation float-start my-1" style="width:36px;"><i class="<?=$data['fwicon']['search'];?>" title="Search"></i></button>
					
					</div>
					

				</div>
			</form>
		</div>
	
	
<? if(isset($_REQUEST['bene_id'])){ ?>
	
<div class="alert alert-light fw-bold" role="alert">
  Result show: </span><?=$data['rec_start'];?> - <?=$data['rec_end'];?> of <?=$data['total_record']?> Search By ::  
<? 
$seperator=" <i class='".$data['fwicon']['hand']."'></i>";
if(isset($_REQUEST['bene_id'])&&$_REQUEST['bene_id']){ echo $seperator." Beneficiary ID : ".$_REQUEST['bene_id']; }
if(isset($_REQUEST['beneficiary_name'])&&$_REQUEST['beneficiary_name']){ echo $seperator." Beneficiary Name : ".$_REQUEST['beneficiary_name']; }

if(isset($_REQUEST['bank_name'])&&$_REQUEST['bank_name']){ echo $seperator." Bank Name : ".$_REQUEST['bank_name']; }
if(isset($_REQUEST['bank_code'])&&$_REQUEST['bank_code']){ echo $seperator." Bank Code : ".$_REQUEST['bank_code']; }
  
?>
</div>

<? } ?>
	
	<? if($data['cntdata'])
	{
	?>
	<div class="container table-responsive my-1 px-0">
		<?php /*?><span class="text-warning">Result show: </span><?=$data['rec_start'];?> - <?=$data['rec_end'];?> of <?=$data['total_record']?><?php */?>
		
<table class="table table-striped">
		<thead>
		<tr class="bg-dark-subtle">
		<th scope="col"><div class="transaction-h1">Beneficiary&nbsp;ID</div><div class="transaction-h2">Pulling&nbsp;Time</div></th>
		<?php /*?><th scope="col" title="Action"><i class="<?=$data['fwicon']['circle-info'];?>"></i></th><?php */?>
		<th scope="col"><div class="transaction-h1">Beneficiary&nbsp;Name</div><div class="transaction-h2">Nickname</div></th>
		<th scope="col"><div class="transaction-h1">Bank&nbsp;Name</div><div class="transaction-h2">A/C&nbsp;Number</div></th>
		<th scope="col"><div class="transaction-h1">Bank&nbsp;Code&nbsp;1</div><div class="transaction-h2">Bank&nbsp;Code&nbsp;2</div></th>
		<th scope="col" valign="top"><div class="transaction-h1">Bank&nbsp;Code&nbsp;3</div></th>
		<th scope="col"><div class="transaction-h1">Status</div><div class="transaction-h2">Json Log</div></th>
		</tr>
		</thead>
			<tbody>
				<? foreach($post['bene_list'] as $key=>$val){ ?> 
				<tr class="rounded"><td data-label="&nbsp;Beneficiary Id">
				
				<a class="hrefmodal transaction-list-h1 text-link" data-tid="<?=$val['bene_id'];?> - <?=$val['beneficiary_name'];?>" data-href="<?=($data['Host']."/include/beneficiary_details".$data['ex']);?>?bid=<?=$val['id'];?>&action=details&admin=1&tempui=<?=$data['frontUiName']?>" title="Beneficiary ID"><?=$val['bene_id'];?></a>
				<div class="text-bg-info px-1 rounded transaction-list-h2" style="width: max-content;" title="Pulling Time"><?=get_pulling_status($val['created_date']);?></div>
				  
				</td>
					<?php /*?><td data-label="&nbsp;Action"><div style="position:relative">
                    <div class=""> <a  class="dropdown-toggle7" data-bs-toggle="dropdown" aria-expanded="false"><i class="--"></i></a>
                      <ul class="dropdown-menu">
					  
<li><a class="dropdown-item" href="#"><i class="--"></i> Status</a></li>

<li><a class="dropdown-item" href="#"></i><i class="--"></i> Remark</a></li>
                      </ul>
                    </div>
                  </div></td><?php */?>
					<td valign="top">
					<div class="transaction-list-h1"><?=$val['beneficiary_name'];?></div>
					<div class="transaction-list-h2"><?=$val['beneficiary_nickname'];?></div>					</td>
					<td valign="top">
					<div class="transaction-list-h1"><?=$val['bank_name'];?></div>
					<div class="transaction-list-h2"><?=mask($val['account_number'],0,4);?></div>					</td>
					<td valign="top">
					<div class="transaction-list-h1"><?=$val['bank_code1'];?></div>
					<div class="transaction-list-h2"><?=$val['bank_code2'];?></div>					</td>
					<td valign="top"><div class="transaction-list-h1"><?=$val['bank_code3'];?></div></td>
					<td valign="top">
					<div class="transaction-list-h1"><?=$data['BeneficiaryStatus'][$val['status']]?></div>
					<div class="transaction-list-h2">
					<? if(isset($val['json_log_history'])&&$val['json_log_history']){?>
			<i class="<?=$data['fwicon']['circle-info'];?> text-info fa-fw" 
			onclick="popup_openv('<?=$data['Host']?>/include/json_log<?=$data['ex']?>?tableid=<?=$val['id'];?>&tablename=payout_beneficiary&type=1')" title="View Json History"></i>
			<? } ?>
					</div>					</td>
			  </tr>
				<? } ?>
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
	}
	else {
	?>
	
		<div class="alert alert-danger my-2" role="alert"><strong>No Records exists</strong></div>
	<?	
		}
	?>
	</div> 



<script>
$(document).ready(function(){
	$('#myModal .modal-dialog').css({"max-width":"90%"});
});
</script>

<script>
/*js for search validation*/
$(".s_validation").click(function() {

   var sbene_id=$("#bene_id").val();
   var sbeneficiary_name=$("#beneficiary_name").val();
   var sbank_name=$("#bank_name").val();
   var sbank_code=$("#bank_code").val();
   var saccount_number=$("#account_number").val();
   
   if((sbene_id=="") && (sbeneficiary_name=="") && (sbank_name=="") && (sbank_code=="") && (saccount_number=="")){
   alert("Please Enter any Search Keyword ");
   return false;
   }
  
});

</script>

<? //db_disconnect();?>