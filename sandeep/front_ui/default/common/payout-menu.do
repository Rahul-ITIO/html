<div class="col-sm-12 row py-2 text-end">
        <!--<div class="col-sm-2 px-2">
		<a href="add-fund<?=$data['ex'];?>" class="btn btn-primary btn-sm   m-2 w-100"> Add Fund</a>
		</div> --><div class="col-sm-2 px-2">
		<a href="addbeneficiary<?=$data['ex'];?>" class="btn btn-primary btn-sm  m-2 w-100"> Add Beneficiary</a>
		</div><div class="col-sm-2 px-2">
		<a href="upload-fund<?=$data['ex'];?>" class="btn btn-primary btn-sm  m-2 w-100"> Upload Fund</a>
		</div><div class="col-sm-2 px-2">
		<a href="payout-transaction<?=$data['ex'];?>" class="btn btn-primary btn-sm  m-2 w-100"> Transaction</a>
		</div><div class="col-sm-2 px-2">
		<a href="payout-statement<?=$data['ex'];?>" class="btn btn-primary btn-sm  m-2 w-100"> Statement</a>
		</div>
		
		<? if(isset($data['view_balance'])){
		?>
		<div class="col-sm-2 px-2 px-2">
			<span id="currbal" class="btn btn-primary text-white btn-sm  m-2 w-100" >View Balance</span>
		</div>
		<?
		}?>
	</div>
