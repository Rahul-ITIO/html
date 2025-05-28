<??>
<div class="col-sm-12 row py-2 text-end">
			<?/*?>
		<? if(((in_array(17, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
		<div class="col-sm-2 px-2">
		<a href="addbeneficiary<?=$data['ex'];?>" class="btn btn-primary btn-sm  m-2 w-100"> Add Beneficiary</a>
		</div>
		<? } ?>
		 <? if(((in_array(15, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?><div class="col-sm-2 px-2">
		<a href="upload-fund<?=$data['ex'];?>" class="btn btn-primary btn-sm  m-2 w-100"> Upload Fund</a>
		</div><? } ?>
		
		<? if(((in_array(19, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
		<div class="col-sm-2 px-2">
		<a href="payout-transaction<?=$data['ex'];?>" class="btn btn-primary btn-sm  m-2 w-100"> Transaction</a>
		</div>
		<? } ?>
		<? if(((in_array(20, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
		<div class="col-sm-2 px-2">
		 <a href="payout-statement<?=$data['ex'];?>" class="btn btn-primary btn-sm  m-2 w-100"> Statement</a>
		</div>
		<? } ?>
		<?*/?>
		<? if(isset($data['view_balance'])){
		?>
		<div class="col-sm-12 text-end">
			<span id="currbal" class="btn btn-primary text-white btn-sm  px-2 float-end" >View Balance</span>
		</div>
		<?
		}?>
	</div>
