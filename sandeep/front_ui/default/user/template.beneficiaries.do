<? if(isset($data['ScriptLoaded'])){
$gid=isset($gid)&&$gid?$gid:$post['id'];
?>
<?php /*?>include for table responsive on mobile<?php */?>
<div id="zink_id">

<? if($post['step']==1){ ?>

<div class="container my-2 py-2 border rounded" >
	<div class="row vkg">
		<div class="col-sm-12 ">
			<h4><i class="<?=$data['fwicon']['user-double'];?> fa-fw"></i> Beneficiaries</h4>
		</div>

	</div>
<div>



<div class="row payout_search_css">
<div class="col-sm-8 text-start py-2" >
All Beneficiaries are shown here. <?php /*?><a href="#" class="text-info">Know more </a><?php */?>

</div>

<div class="col-sm-4 dropdown text-end dropstart pe-2">
  
  <a class="text-primary btn btn-primary btn-sm my-2" id="Bendropid" data-bs-toggle="dropdown" aria-expanded="false" title="Add New Beneficiaries" ><i class="<?=$data['fwicon']['circle-plus'];?>"></i></a>
  
<ul class="dropdown-menu" aria-labelledby="Bendropid">
    <li><a class="dropdown-item hrefmodal" data-tid="Add Beneficiaries - <?=$gid;?>" data-href="<?=($data['Host']."/user/add-beneficiaries".$data['ex']);?>?action=details&tempui=<?=$data['frontUiName']?>&HideAllMenu=1" title="Add Beneficiaries"><i class="<?=$data['fwicon']['user'];?> fa-fw text-primary"></i> Single Add</a></li>
	
    <li><a class="dropdown-item" href="<?=($data['Host']."/user/addbeneficiary".$data['ex']);?>"><i class="<?=$data['fwicon']['user-double'];?> fa-fw text-primary"></i> Batch Upload</a></li>
  </ul>


</div>
</div>

<?php /*?>for display success / Failed Message<?php */?>
<? include $data['Path']."/include/message".$data['iex'];?>

<div class="clearfix"></div>
		<div class="col-sm-12 bg-primary border rounded mb-2 px-2">
			<form method="get">
				<div class="row bene-search">
					<div class="col-sm-3 my-1">
<input type="text" class="form-control form-control-sm" placeholder="Beneficiary ID" name="bene_id"  autocomplete="off">
					</div>
					<div class="col-sm-3 my-1">
<input type="text" class="form-control  form-control-sm" placeholder="Beneficiary Name" name="beneficiary_name"  autocomplete="off">
					</div>
					<div class="col-sm-3 my-1">
<input type="text" class="form-control form-control-sm" placeholder="Bank Name" name="bank_name" autocomplete="off">
					</div>
					<div class="col-sm-3 my-1">
					<input type="text" class="form-control form-control-sm float-start" placeholder="Bank Code" name="bank_code"  autocomplete="off" style="width: calc(100% - 36px) !important;">
					<button type="submit" class="btn btn-primary btn-sm s_validation float-start" style="width:36px;"><i class="<?=$data['fwicon']['search'];?>" title="Search"></i></button>
					
					</div>
					

				</div>
			</form>
		</div>

	

	
<div class="alert alert-light fw-bold" role="alert">
  Result show: </span><?=$data['rec_start'];?> - <?=$data['rec_end'];?> of <?=$data['total_record']?> ::  
<? 
$seperator=" <i class='".$data['fwicon']['hand']."'></i>";
if(isset($_REQUEST['bene_id'])&&$_REQUEST['bene_id']){ echo $seperator." Beneficiary ID : ".$_REQUEST['bene_id']; }
if(isset($_REQUEST['beneficiary_name'])&&$_REQUEST['beneficiary_name']){ echo $seperator." Beneficiary Name : ".$_REQUEST['beneficiary_name']; }

if(isset($_REQUEST['bank_name'])&&$_REQUEST['bank_name']){ echo $seperator." Bank Name : ".$_REQUEST['bank_name']; }
if(isset($_REQUEST['bank_code'])&&$_REQUEST['bank_code']){ echo $seperator." Bank Code : ".$_REQUEST['bank_code']; }
  
?>
</div>


<? if($data['total_record'] > 0) { ?>

	<div class="mb-2 table-responsive">
	<table class="table table-striped">
		<thead>
			<tr class="bg-dark-subtle">
				    <th scope="col"><div class="transaction-h1">Beneficiary&nbsp;ID</div><div class="transaction-h2">Pulling&nbsp;Time</div></th>
					<th scope="col"><div class="transaction-h1">Beneficiary&nbsp;Name</div><div class="transaction-h2">Nickname</div></th>
					<th scope="col"><div class="transaction-h1">Bank&nbsp;Name</div><div class="transaction-h2">A/C&nbsp;Number</div></th>
					<th scope="col"><div class="transaction-h1">Bank&nbsp;Code&nbsp;1</div><div class="transaction-h2">Bank&nbsp;Code&nbsp;2</div></th>
					<th scope="col" valign="top"><div class="transaction-h1">Bank Code 3</div></th>
				</tr>
			</thead>
			<tbody>
				<? 
				if(isset($post['bene_list'])&&count($post['bene_list'])>0){
				foreach($post['bene_list'] as $key=>$val){ ?> 
				    <tr valign="top" class="rounded">
				    <td valign="top">
				<div class="transaction-list-h1"><?=$val['bene_id'];?></div>
				<div class="text-bg-info px-1 rounded transaction-list-h2" style="width: max-content;" title="Pulling Time"><?=get_pulling_status($val['created_date']);?></div></td>
					<td valign="top">
					<div class="transaction-list-h1"><?=$val['beneficiary_name'];?></div>
					<div class="transaction-list-h2"><?=$val['beneficiary_nickname'];?></div>
					</td>
					<td valign="top">
					<div class="transaction-list-h1"><?=$val['bank_name'];?></div>
					<div class="transaction-list-h2"><?=mask($val['account_number'],0,4);?></div>
					</td>
					<td valign="top">
					<div class="transaction-list-h1"><?=$val['bank_code1'];?></div>
					<div class="transaction-list-h2"><?=$val['bank_code2'];?></div>	
					</td>
					<td valign="top"><div class="transaction-list-h1"><?=$val['bank_code3'];?></div></td></tr>
				<? } 
				}else{
				?>  
				
				<? } ?>
			</tbody>
		</table>
		</div>
		
<? }else{ ?>		
		
<div class="alert alert-danger" role="alert">No record exists</div>
		
<? } ?>	
		<?
        // include file for pagination
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
<?php /*?>set modal popup width<?php */?>
<script>$('#myModal90 .modal-dialog').css({"max-width":"500px"});</script>
<? }else{ ?>
	SECURITY ALERT: Access Denied
<? } ?>
