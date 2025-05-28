<? if(isset($data['ScriptLoaded'])){ ?>

<div id="zink_id">

      
	<? include($data['Path'].'/include/fontawasome_icon'.$data['iex']); // include for display font awasome icon ?>
	<? include $data['Path']."/include/message".$data['iex'];?>

	<? if($post['step']==1){ ?>
	
	<div class="container my-2 py-2 border rounded" >
		<div class="row mb-3">
			<div class="col-sm-12 ">
				<h4 class="float-start"><i class="<?=$data['fwicon']['fund-sources'];?>"></i> Add Fund Sources</h4>
			</div>
		</div>
		<form method="post" name="data" action="<?=$data['Host']?>/user/add-fund<?=$data['ex']?>">
			<input type="hidden" name="step" value="<?=$post['step']?>">
			<input type="hidden" name="pdisplay" value="<?=$_REQUEST['pdisplay']?>">
			<input type="hidden" name="uid" value="<?=(isset($post['uid'])&&$post['uid']?$post['uid']:'');?>">
<div class="mb-3 sfdiv">
			
			
				<div class="form-floating mb-3 px-0">
					
					<select class="form-select" name="transaction_currency" id="transaction_currency" required>
						<option value="" disabled="" selected="">Select Currency</option>
					<? foreach ($data['AVAILABLE_CURRENCY'] as $k11) { ?>
						<option value="<?=$k11?>"><?=$k11?></option>
					<? } ?>
              </select>
			  <label for="transaction_currency">Currency <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
					 <script>
					$('#transaction_currency option[value="<?=$_POST['transaction_currency'];?>"]').prop('selected','selected');
					</script>
					</div>
					
					
<div class="form-floating mb-3 px-0">
<input type="number" class="form-control" name="transaction_amount" id="f_amount"  placeholder="Deposit Amount" value="" onchange="setTwoNumberDecimal" min="0" step="0.01" required/>
<label for="f_amount">Amount <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
</div>
				
	
				
<div class="form-floating mb-3 px-0">
<input type="text" class="form-control" name="sender_name" id="f_sender_name" value="" placeholder="Sender Name" required>
<label for="f_sender_name">Sender Name <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
</div>
				
<div class="form-floating mb-3 px-0">
<input type="text" class="form-control" name="remarks" id="f_remarks"  value="" placeholder="Remarks" required>
<label for="f_remarks">Remarks <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
</div>
				
				<?php 
				/*?>
				<div class="col-sm-12 p-1">
					<label for="Sender Name" class="form-label">Account Number* :</label>
					<input class="form-control" name="account_number" id="account_number" type="password" placeholder="Account Number" title="Account Number" autocomplete="off" value="" required>
				</div>
				<div class="col-sm-12 p-1">
					<label for="Remarks" class="form-label">Bank Name*:</label>
					<input type="text" class="form-control" name="bank_name" id="bank_name" title="Bank Name" placeholder="Bank Name" autocomplete="off" required>
				</div><div class="col-sm-2 p-1">
					<label for="Remarks" class="form-label">Secret Word*:</label>
					<input type="password" class="form-control" name="secret_word" title="Secret Word" placeholder="Secret Word" autocomplete="off" required>
				</div><?php */?>
				
				<div id="sfbutton" class="col-sm-12">
					<button class="btn btn-primary w-100" type="submit" name="send" value="submit_data"><i class="<?=$data['fwicon']['submit'];?>"></i> Submit</button>
				</div>
			</div>
		</form>
	</div>
<? } ?>
</div>

<? if(isset($_REQUEST['pdisplay'])){;?>
<style>
.sfdiv .col-sm-2, .sfdiv .col-sm-3  { width:100% !important;max-width:100% !important;}
</style>

<script>$('#sfbutton').addClass('text-center');</script>
<script>$('#myModal .modal-body').css({"padding":"5px"});</script>

<? } ?>

<? }else{ ?>
	SECURITY ALERT: Access Denied
<? } ?>
