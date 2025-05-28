<? if(isset($data['ScriptLoaded'])){ ?>

<style>
#sidebar .activmainmenu{margin: unset !important;}
.list-unstyled .activmainmenu i { margin-left: unset !important; }
</style>

<div class="container border my-1 rounded">
<?php /*?>include for Display Success / failed Message<?php */?>
<? include $data['Path']."/include/message".$data['iex'];?>

<? if($post['step']==1){ ?>
	<div class="container text-end px-0 vkg">
		<h4 class="my-2 float-start"><i class="<?=$data['fwicon']['transaction'];?>"></i> Payout Transaction</h4>
	</div>
    <?php /*?>include for search box<?php */?>
	<div class="clearfix"></div>
	<?
	$search_form=("../front_ui/{$data['frontUiName']}/common/template.admin_payout_search_form".$data['iex']);
	if(file_exists($search_form)){
	include($search_form);
	}
    ?>
	<? if(isset($_REQUEST['records_per_page'])){ ?>
	
<div class="alert alert-light fw-bold" role="alert">
  Result show: </span><?=$data['rec_start'];?> - <?=$data['rec_end'];?> of <?=$data['total_record']?> Search By :: 
<? 
$seperator=" <i class='".$data['fwicon']['hand']."'></i>";
if(isset($_REQUEST['key_name'])&&$_REQUEST['key_name']=="transaction_id"){ echo $seperator." TransID : ".$_REQUEST['searchkey']; }

if(isset($_REQUEST['key_name'])&&$_REQUEST['key_name']=="mrid"){ echo $seperator." Reference : ".$_REQUEST['searchkey']; }


if(isset($_REQUEST['date_1st'])&&$_REQUEST['date_1st']){ echo $seperator." Date Range : ".$_REQUEST['date_1st']." To ".$_REQUEST['date_2nd']; }

if(isset($_REQUEST['status'])&&$_REQUEST['status']){ echo $seperator." Status : ".$data['SendFundStatus'][$_REQUEST['status']]; }
if(isset($_REQUEST['records_per_page'])&&$_REQUEST['records_per_page']){ echo $seperator." Record Per Page : ".$_REQUEST['records_per_page']; }
  
?>
</div>

<? } ?>
	
	<div class="table-responsive my-1">
	<? if($data['cntdata'])
	{
	?>
	<?php /*?><span class="text-warning">Result show: </span><?=$data['rec_start'];?> - <?=$data['rec_end'];?> of <?=$data['total_record']?><?php */?>
	<table class="table table-striped">
		<thead>
			<tr class="bg-dark-subtle">
			    <th valign="top" style="width:110px"><div class="transaction-h1">TransID</div><div class="transaction-h2">Reference</div></th>
				<th valign="top"><i class="<?=$data['fwicon']['circle-info'];?> text-link"></i></th>
				<th valign="top"><div class="transaction-h1">Full&nbsp;Name</div><div class="transaction-h2">A/C&nbsp;Number</div></th>
				<th valign="top"><div class="transaction-h1">Bill Amt</div><div class="transaction-h2">Trans.&nbsp;Amount</div></th>
				<th valign="top"><div class="transaction-h1">Available&nbsp;Balance</div></th>
				<th valign="top"><div class="transaction-h1">Timestamp</div><div class="transaction-h2">Created&nbsp;Date</div></th>
				<th valign="top"><div class="transaction-h1">Username</div></th>
				<th valign="top"><div class="transaction-h1">Trans Type</div><div class="transaction-h2">Trans&nbsp;Status</div></th>
				<th valign="top"><div class="transaction-h1">Trans&nbsp;Response</div></th>
				</tr>
		</thead>
		<? 
		$j=1; 

		$result_select=db_rows_2(
			"SELECT * FROM `{$data['DbPrefix']}payout_beneficiary`".
			" WHERE status='1'".
			" ORDER BY id",0
		);

		foreach ($result_select as $key => $val) {
			$bene_list[$val['bene_id']] = $val;
		}

		foreach($post['result_list'] as $key=>$value) {
			$beneficiary_name=$account_number="";
			if(isset($value['beneficiary_id'])&&$value['beneficiary_id'])
			{
		//		echo $value['beneficiary_id']." ";
				$beneficiary_name	=@$bene_list[$value['beneficiary_id']]['beneficiary_name'];	
				$account_number		=@mask($bene_list[$value['beneficiary_id']]['account_number'],0,4);	
			}
			
			$memb=select_tablef("`id`='{$value['sub_client_id']}'",'clientid_table',0,1,"`username`,`company_name`");

			$ord_amt = get_currency($value['transaction_currency']).abs($value['transaction_amount']);
			$txn_amt = get_currency($value['converted_transaction_currency']).abs($value['converted_transaction_amount']);
			$balance_amt = get_currency($value['converted_transaction_currency']).abs($value['available_balance']);
	
			if($value['transaction_amount']<0)	$ord_amt ='<font color="red">-'.$ord_amt.'</font>';
			if($value['converted_transaction_amount']<0){
				$txn_amt ='<font color="red">-'.$txn_amt.'</font>';
			}
			if($value['available_balance']<0)	$balance_amt ='<font color="red">-'.$balance_amt.'</font>';

			if($value['transaction_status']==0 || $value['transaction_status']==3) $balance_amt = get_currency($value['converted_transaction_currency']).'0';


			$check_status = jsonvaluef($value['json_log'],'check_status');
			
			if(isset($value['reason'])&&$value['reason']) 
				$reason_remark=$value['reason'];
			else $reason_remark = $value['remarks'];
		?>
			<tr valign="top"><td>
				<a class="hrefmodal text-link transaction-list-h1" style="white-space:nowrap;" data-tid="<?=$value['transaction_id']?>" data-href="<?=($data['Host']."/include/payout_transactions_details".$data['ex']);?>?bid=<?=$value['id'];?>&mid=<?=$value['sub_client_id'];?>&action=details&admin=1&tempui=<?=$data['frontUiName']?>" title="<?=$value['transaction_id'];?>" ><span class="d-inline-block text-truncate" style="width:90px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;"  title="<?=$value['transaction_id'];?>"><?=$value['transaction_id'];?></span></a>
				
				
<div title="<?=$value['mrid'];?>" data-bs-toggle="tooltip" data-bs-placement="top" style="width:90px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" class="mx-0 transaction-list-h2"><?=$value['mrid'];?></div>
                    
                  
				
				</td>
				<td valign="top">
				<? 
				if(isset($check_status)&&$check_status&&$value['transaction_status']!=9)
				{?>
				<div style="position:relative">
					<div class=""><a class="dropdown-toggle7" data-bs-toggle="dropdown" aria-expanded="false"><i class="<?=$data['fwicon']['circle-down'];?>" title="Action"></i></a>
						<ul class="dropdown-menu"><li><a class="dropdown-item hrefmodal" data-href="<?=($data['Host']."/".$check_status);?>?bid=<?=$value['id'];?>&mid=<?=$value['sub_client_id'];?>&transaction_id=<?=$value['transaction_id']?>&action=details&admin=1&tempui=<?=$data['frontUiName']?>" title="<?=$value['transaction_id'];?>"><i class="<?=$data['fwicon']['hand'];?>"></i> Status</a></li></ul>
					</div>
				</div><?
				}?>
				<? if(isset($value['json_log_history'])&&$value['json_log_history']){?>
			<i class="<?=$data['fwicon']['circle-info'];?> text-info" 
			onclick="popup_openv('<?=$data['Host']?>/include/json_log<?=$data['ex']?>?tableid=<?=$value['id'];?>&tablename=payout_transaction&type=1')" title="View Json History"></i>
			<? } ?>
				</td>
				
				<td valign="top">
				<div class="transaction-list-h1"><? if($value['transaction_type']==1){ echo $value['sender_name']; } else { echo $beneficiary_name;}?></div>
				<div class="transaction-list-h2"><? echo $account_number;?></div>
				</td>
				
				<td valign="top">
				<div class="transaction-list-h1"><?=$ord_amt;?></div>
				<div class="transaction-list-h2"><?=$txn_amt;?></div>
				</td>
				<td valign="top"><div class="transaction-list-h1"><?=$balance_amt;?></div></td>
				<td valign="top">
				<div class="transaction-list-h1"><?=prndate($value['transaction_date'])?></div>
				<div class="transaction-list-h2"><?=prndate($value['created_date'])?></div>
				</td>
				<td valign="top"><div class="transaction-list-h1"><?=@$memb['username'];?></div></td>
				
				
				<td valign="top"> 
		<? $statuscss=payout_status_class($data['SendFundStatus'][$value['transaction_status']]); ?> 
		
		
		<? if($value['transaction_type']==1){ $clrcode="success"; $pcode="Credit"; }else{$clrcode="danger"; $pcode="Debit";}?>
		<span class="text-bg-<?=$clrcode;?> px-1 rounded transaction-list-h1" title="Type"><?=$pcode;?></span>
		
		<div class="text-bg-<?=$statuscss;?> px-1 rounded transaction-list-h2 " title="Statue" style="width: max-content;"><?=$data['SendFundStatus'][$value['transaction_status']];?></div>
				</td>
				<td valign="top"><span class="d-inline-block text-truncate transaction-list-h2" style="max-width: 70px;" title="<?=$reason_remark;?>" data-bs-toggle="tooltip" data-bs-placement="left"><?=substr($reason_remark,0,15);?></span></td>
				
			</tr></tr>
			<? $j++; }?>
		</table>


		<?
		// include for pagination
		include $data['Path']."/include/pagination_new".$data['iex'];

		$get=http_build_query($_REQUEST);

//		$url="payout-transaction".$data['ex']."?".$get;
		$url=$_SERVER['PHP_SELF']."?".$get;
	
		if(isset($data['total_record'])&&$data['total_record']) $total = $data['total_record'];
		else $total = 0;
		
		pagination_new($data['MaxRowsByPage'],$data['startPage'],$url,$total);

	}
	else
	{
		?><div class="alert alert-danger my-2" role="alert"><strong>No Records exists</strong></div><?
	}
	?>		
	</div>
	<? }elseif($post['step']==2){ ?>
		<? if(isset($post['gid'])&&$post['gid']){}else{}?>
	<? }?>
</div>
<? }else{ ?>
	SECURITY ALERT: Access Denied
<? }?>
