<!DOCTYPE>
<html>
<head><style>.modal-body { padding: 5px; } </style></head>
<body>
<div class="container border" id="cssfortrpop">
	<div class="row my-2 mboxcss">
		<h6 class="vkg-underline-red">Beneficiary Detail</h6> 

		<div class="col-sm-3 my-1">Beneficiary Id</div>
		<div class="col-sm-9 my-1">: <?=$data['row']['bene_id'];?> </div>

		<div class="col-sm-3 my-1">Nickname</div>
		<div class="col-sm-9 my-1">: <?=$data['row']['beneficiary_nickname'];?> </div>

		<div class="col-sm-3 my-1">Beneficiary Name</div>
		<div class="col-sm-9 my-1">: <?=$data['row']['beneficiary_name'];?> </div>
		
		<div class="col-sm-3 my-1">Account Number</div>
		<div class="col-sm-9 my-1">: <?=$data['row']['account_number'];?> </div>

		<? 
		if(isset($data['row']['bank_name'])&&$data['row']['bank_name'])
		{?>
		<div class="col-sm-3 my-1">Bank Name</div>
		<div class="col-sm-9 my-1">: <?=$data['row']['bank_name'];?> </div>
		<? 
		}
		?>
		<div class="col-sm-3 my-1">Bank Code 1</div>
		<div class="col-sm-9 my-1">: <?=$data['row']['bank_code1'];?> </div>
		<? 
		if(isset($data['row']['bank_code2'])&&$data['row']['bank_code2'])
		{?>
		<div class="col-sm-3 my-1">Bank Code 2</div>
		<div class="col-sm-9 my-1">: <?=$data['row']['bank_code2'];?> </div>
		<? 
		}
		if(isset($data['row']['bank_code3'])&&$data['row']['bank_code3'])
		{
		?>
		<div class="col-sm-3 my-1">Bank Code 3</div>
		<div class="col-sm-9 my-1">: <?=$data['row']['bank_code3'];?> </div>
		<?
		}
		if(isset($data['row']['beneficiaryEmailId'])&&$data['row']['beneficiaryEmailId'])
		{
		?>
		<div class="col-sm-3 my-1">Beneficiary EmailId</div>
		<div class="col-sm-9 my-1">: <?=$data['row']['beneficiaryEmailId'];?> </div>
		<?
		}
		if(isset($data['row']['beneficiaryPhone'])&&$data['row']['beneficiaryPhone'])
		{
		?>
		<div class="col-sm-3 my-1">Beneficiary Phone</div>
		<div class="col-sm-9 my-1">: <?=$data['row']['beneficiaryPhone'];?> </div>
		<?
		}
		if(isset($data['row']['udf1'])&&$data['row']['udf1'])
		{
		?>
		<div class="col-sm-3 my-1">Other Field</div>
		<div class="col-sm-9 my-1">: <?=$data['row']['udf1'];?> </div>
		<?
		}
		if(isset($data['row']['udf2'])&&$data['row']['udf2'])
		{
		?>
		<div class="col-sm-3 my-1">Other Field</div>
		<div class="col-sm-9 my-1">: <?=$data['row']['udf2'];?> </div>
		<?
		}
		?>
		<div class="col-sm-3 my-1">Status</div>
		<div class="col-sm-9 my-1">: <?
			$statuscss=payout_status_class($data['BeneficiaryStatus'][$data['row']['status']]);
			?>
			<span class="badge rounded-pill bg-<?=$statuscss;?>"><?=$data['BeneficiaryStatus'][$data['row']['status']];?></span>
		</div> 		
	</div>

	<? if($post['is_admin_payout']){ ?>	
		<? if($data['row']['status']==0 || $data['row']['status']==3){ ?>
		<div class="row my-2">
			<a class="btn btn-success col-sm-2 m-2 btn-sm" href="javascript:void(0);" title="Approve this Transaction" role="button" onClick="_approve()">Permit</a>
			<a class="btn btn-danger col-sm-2 m-2 btn-sm" href="javascript:void(0);" title="Fail / Cancel this Transaction" role="button" onClick="_reject()">Reject</a>
		</div>
		<? } ?>
	<? } ?>
</div>
</body>
</html>
<script>
function _approve()
{
	var retVal= confirm('Are you sure, you want to Permit this Beneficiary?');
	if (retVal) {
	
		url = "<?=$data['Admins'];?>/beneficiary_list<?=$data['ex']?>?bid=<?=$data['row']['id'];?>&mid=<?=$data['row']['clientid'];?>&action=approved";
		location.href=url;
		return true;
	} else {			
		return false;
	}
}
function _reject()
{
	var retVal= confirm('Are you sure, you want to Reject this Beneficiary?');
	if (retVal) {
		url = "<?=$data['Admins'];?>/beneficiary_list<?=$data['ex']?>?bid=<?=$data['row']['id'];?>&mid=<?=$data['row']['clientid'];?>&action=fail";
		location.href=url;
		return true;
	} else {			
		return false;
	}
}
</script>
<? db_disconnect();?>