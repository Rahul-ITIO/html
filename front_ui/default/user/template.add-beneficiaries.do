<? if(isset($data['ScriptLoaded'])){ ?>
<style>
#modal_mfa {display:none;}
</style>
<div id="zink_id">

<? include($data['Path'].'/include/fontawasome_icon'.$data['iex']); // include for display font awasome icon ?>
<? 

include $data['Path']."/include/message".$data['iex'];	// create a common page for error and success message - 

if($post['step']==1){ ?>	
	<form method="post" name="data" id="myPostForm">
	<div class="container my-2 py-2 border rounded" >
		<div class="row vkg">
			<div class="col-sm-12 mb-2">
				<h4 class="float-start"><i class="fa fa-user"></i> Beneficiary  
					
				- Single Add</h4>
			</div>
		</div>
		
			<input type="hidden" name="step" value="<?=$post['step']?>">
			<input type="hidden" name="uid" value="<?=(isset($gid)&&$gid?$uid:'');?>">
			<div class="mb-3">
				<div class="form-floating mb-3 px-0">
					<select class="form-control" name="bank_code3" id="beneficiary_type" onchange="beneficiary_typef(this.value)" required>
						<option value="Bank Account" default>Bank Account</option>
						<option value="Crypto Wallet" >Crypto Wallet</option>
					</select>
					<label for="beneficiary_type">Beneficiary Type <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
				</div>
				<div class="form-floating mb-3 px-0">
					<input class="form-control" name="beneficiary_nickname" id="beneficiary_nickname" type="text" placeholder="Nick Name" autocomplete="off" value="<?=(isset($post['beneficiary_nickname'])?$post['beneficiary_nickname']:'');?>" required/>
					<label for="beneficiary_nickname">Nick Name <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
				</div>
				<div class="form-floating mb-3 px-0">
			<input class="form-control required" id="beneficiary_name" name="beneficiary_name" type="text"  placeholder="Beneficiary Name" autocomplete="off" value="" />
			<label for="beneficiary_name">Beneficiary Name <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
				</div>
				<div class="form-floating mb-3 px-0">
					<input class="form-control" name="account_number" id="account_number" type="password" placeholder="Account Number" autocomplete="off" value="" required>
					<label for="account_number"><font id="account_number_label">Account Number</font> <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
				</div>
				<div class="form-floating mb-3 px-0"> 
					<input class="form-control" name="repeated_account_number" id="repeated_account_number" type="text" placeholder="Repeat Account Number" autocomplete="off" required>
					<label for="repeated_account_number"><font id="repeated_account_number_label">Repeat Account Number</font>  <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
				</div>
				<div class="form-floating mb-3 px-0">
					<input type="text" class="form-control" name="bank_name" id="bank_name" placeholder="Bank Name" required>
					<label for="bank_name"><font id="bank_name_label">Bank Name</font> <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
				</div>
				
				<div class="form-floating mb-3 px-0">
					<input type="text" class="form-control" name="bank_code1" id="bank_code1" placeholder="Bank Code 1" autocomplete="off" required>
					<label for="bank_code1"><font id="bank_code1_label">Bank Code</font>  <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
				</div>
				
				<div class="form-floating mb-3 px-0">
					<input type="text" class="form-control" name="bank_code2" id="bank_code2" placeholder="Bank Code 2" autocomplete="off">
					<label for="bank_code2"><font id="bank_code2_label">Bank Code 2</font>  </label>
				</div>
				<?/*?>
				<div class="form-floating mb-3 px-0">
					<input type="text" class="form-control" name="bank_code3" placeholder="Bank Code 3" autocomplete="off">
					<label for="bank_code3">Bank Code 3</label>
				</div>
				
				<?*/?>

				<div class="form-floating mb-3 px-0">
					<input type="email" class="form-control" name="beneficiaryEmailId" id="f_email" placeholder="Beneficiary Email Id:" autocomplete="off">
					<label for="f_email">Beneficiary Email Id</label>
				</div>
				<div class="form-floating mb-3 px-0">
					<input type="text" class="form-control" name="beneficiaryPhone" id="f_phone" placeholder="Beneficiary Phone" autocomplete="off">
					<label for="f_phone">Beneficiary Phone</label>
				</div>
				<div class="form-floating mb-3 px-0">
					<input type="text" class="form-control" name="udf1" id="f_udf1" placeholder="UDF" autocomplete="off">
					<label for="f_udf1">UDF 1 </label>
				</div>
				<div class="form-floating mb-3 px-0">
					<input type="text" class="form-control" name="udf2" id="f_udf2" placeholder="UDF" autocomplete="off">
					<label for="f_udf2">UDF 2 </label>
				</div>
				<div class="col-sm-12 text-center w-100">
					<button id="b_submit" class="check_account btn btn-primary submit_data w-100" type="submit" name="send" value="submit_data"><i class="<?=$data['fwicon']['submit'];?>"></i> Submit</button>
				</div>
			</div>
		
	</div>
	</form>
		<?
	//SETUP SECOND STEP SECURITY WITH MFA AND PASSWORD - 

	//if($data['withdraw_gmfa']){
		unset($data['FUND_STEP']);
		$data['user_pass_gmfa']=1;
		$data['type_submit']=1;
	?>
		<? 
		include('../include/device_confirmations'.$data['iex']);?>
	<? //}?>
		
<? } ?>
</div>
<script>
	$('#myModal .modal-body').css({"padding":"5px"});

	function beneficiary_typef(theVal){
		//alert(theVal);
		if(theVal==="Bank Account")
		{
			//alert("Account");
			//$('#bank_code1').attr('required','required');
			$('#account_number_label').html('Account Number');
			$('#repeated_account_number_label').html('Repeated Account Number');
			$('#bank_name_label').html('Bank Name');
			$('#bank_code1_label').html('Bank Code');
			$('#bank_code2_label').html('Bank Code 2');
		}
		else if(theVal==="Crypto Wallet")
		{
			//alert("Wallet");
			//$('#bank_code1').removeAttr('required');
			$('#account_number_label').html('Beneficiary Crypto Wallet Address');
			$('#repeated_account_number_label').html('Repeated Beneficiary Crypto Wallet Address');
			$('#bank_name_label').html('Network Name');
			$('#bank_code1_label').html('Wallet Provider');
			$('#bank_code2_label').html('Coins');
		}
	}
	
	$(document).ready(function(){
		
		$('.submit_data').click(function(){
		
			var beneficiary_nickname=$('#beneficiary_nickname').val();
			var beneficiary_name	=$('#beneficiary_name').val();
			var bank_name			=$('#bank_name').val();
			var bank_code1			=$('#bank_code1').val();
			var account_number		=$('#account_number').val();
			var repeated_account_number=$('#repeated_account_number').val();

			if(beneficiary_nickname.length==0)
			{
				alert("Nick Name should not be empty!");
				return false;
			}
			else if(beneficiary_name.length==0)
			{
				alert("Beneficiary Name should not be empty!");
				return false;
			}
			else if(account_number.length==0)
			{
				alert("Account Number should not be empty!");
				return false;
			}
			else if(repeated_account_number.length==0)
			{
				alert("Repeat Account Number should not be empty!");
				return false;
			}
			else if(account_number != repeated_account_number){
				alert("Account Number and Repeated Account Number Not Matched");
				return false;
			}
			else if(bank_name.length==0)
			{
				alert("Bank Name should not be empty!");
				return false;
			}
			else if(bank_code1.length==0)
			{
				alert("Bank Code 1 should not be empty!");
				return false;
			}
			else{
				$('#modal_mfa').show(1500); 
			}
		});
		
		
		$('#myPostForm').submit(function(e){ 
			try {
				if($('#b_submit').hasClass('active')){
					return true;
				}else{
				 <? if($data['withdraw_gmfa']){?>
					$('#modal_mfa').show(200); 
				 <? }else{?>
					$("#b_submit").attr("name","send");
					$('#b_submit').addClass('active');
					$('#modal_msg').show(200);
					
					<? }?>
					return false;
				}
				e.preventDefault(); 
			}
			catch(err) {
				alert('MESSAGE=>'+err.message);
			}
		});

		document.onkeyup=function(event){
			if (event.keyCode === 27){
				closeMsg();
			}
		}
	});
</script>
<? }else{ ?>
	SECURITY ALERT: Access Denied
<? } ?>
