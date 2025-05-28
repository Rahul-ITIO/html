<? if(isset($data['ScriptLoaded'])){ ?>
<? include($data['Path'].'/include/fontawasome_icon'.$data['iex']); // include for display font awasome icon ?>
<style>
#modal_mfa {display:none;}
#beneficiary_list { font-size:30px !important; }
#chosenv .chosen-single{
height: 34px !important;

}
#chosenv .chosen-container-single .chosen-single {
color: #000 !important;
line-height: 30px !important;
background-color: #fff !important;
background: #fff !important;
border: 1px solid #ced4da !important;
}
#chosenv .chosen-container-single .chosen-single div b {
background: url() no-repeat 0 2px !important;
}
</style>

<!--Chosen Script-->
<script src="<?=$data['TEMPATH']?>/common/css/chosen/chosen.jquery.min.js"></script>
<link href="<?=$data['TEMPATH']?>/common/css/chosen/chosen.min.css" rel="stylesheet"/>
<div id="zink_id">

<? 
include $data['Path']."/include/message".$data['iex'];	// create a common page for error and success message - 
?>

<? if($post['step']==1){ 

	//fetch beneficiary details via clientid id - 
	$select_bene=db_rows_2(
		"SELECT * FROM `{$data['DbPrefix']}payout_beneficiary`".
		" WHERE `clientid`='{$post['id']}' AND status='1'".
		" ORDER BY beneficiary_nickname",0
	);
	//SEARCH SECTION
	?>



<div class="container my-2 py-2 border rounded" >

	
	
	<div class="row vkg">
		<div class="col-sm-12 ">
			<h4 class="float-start"><i class="<?=$data['fwicon']['arrow-right-arrow-left'];?>"></i> Quick Transfer</h4>
		</div>
	</div>
	
<div class="sfdiv my-3" id="adv_search_css">
		
			<div id="acquirer_type" class="input_s">
				<div id="chosenv">
				<select id="search_beneficiary" list="beneficiary_list" name="search_beneficiary" class="chosen-select filter_option inherit_select_classes1 form-select bg-dark" onChange="showBeneficiary(this)" required autocomplete="off" >
				<option value="" >Select Beneficiary</option>
				<? 
				foreach($select_bene as $key=>$value){
					if(isset($value['id'])&&$value['id']){ ?>
					<option value="<?=$value['bene_id'];?>" ><?=$value['bene_id'];?> - <?=$value['beneficiary_nickname'];?> - <?=$value['bank_name'];?></option>
					<? }
				} ?>
				</select>
				</div>

			</div>
		
	</div>
	
	<form method="post" name="data" autocomplete="off" id="myPostForm" action="<?=$data['Host']?>/user/send-fund<?=$data['ex']?>">
		<input type="hidden" name="step" value="<?=$post['step']?>">
		<input type="hidden" name="pdisplay" value="<?=$_REQUEST['pdisplay']?>">
		<input type="hidden" name="uid" value="<?=(isset($post['uid'])&&$post['uid']);?>">
		<input type="hidden" name="defaultcurrency" value="<?=$post['default_currency']?>">

		<input type="hidden" name="curr" id="curr" value="<?=$data['payout_default_curr'];?>" />
		<input type="hidden" name="beneficiary_id" id="beneficiary_id" value="">
		<input type="hidden" name="beneficiary_ac" id="beneficiary_ac" value="">
		<input type="hidden" name="beneficiary_ac_repeat" id="beneficiary_ac_repeat" value="">
		<input type="hidden" name="bank_code1" id="bank_code1" value="">
		<input type="hidden" name="bank_code2" id="bank_code2" value="">
		<input type="hidden" name="bank_code3" id="bank_code3" value="">
		<div class="sfdiv mb-3">

		<div class="form-floating mb-3 px-0">

  <input class="form-control" name="transaction_amount" id="transaction_amount" type="number" value=""  placeholder="Amount - How much do you want send?" onchange="setTwoNumberDecimal" min="0"  step="0.01" autocomplete="false" required  />
  <label for="transaction_amount">Amount to send (<?=$data['payout_default_curr'];?>) <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>


		</div>
		<div class="form-floating mb-3 px-0">
			<input class="form-control" name="beneficiary_name" id="beneficiary_name" type="text" value="" placeholder="Beneficiary Name" readonly="readonly" required>
			<label for="beneficiary_name">Beneficiary Name <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
		</div>
	
		<div class="form-floating mb-3 px-0">
			<input class="form-control" name="beneficiary_bank_name" id="beneficiary_bank_name" type="text" value="" placeholder="Bank Name" readonly="readonly" required>
			<label for="beneficiary_bank_name">Bank Name <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
		</div>
		<div class="form-floating mb-3 px-0">
			<input class="form-control" name="payout_secret_key" id="payout_secret_key" type="password" value=""  placeholder="Payout Secret Key" required >
			<label for="payout_secret_key">Payout Secret Key <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
			
			</div>

		<div class="col-sm-12 text-center ">
			<button id="b_submit" class="check_account btn btn-primary my-2 submit_data w-100" type="submit" name="send" value="submit_data"><i class="<?=$data['fwicon']['submit'];?>"></i> Submit</button>
		</div>
	</div>
	</form>
	<?
	//SETUP SECOND STEP SECURITY WITH MFA AND PASSWORD - 
	$data['user_pass_gmfa']=1;
	$data['type_submit']=1;
	include('../include/device_confirmations'.$data['iex']);
	?>
</div>
<? } ?>

</div>
<? if(isset($_REQUEST['pdisplay'])){;?>
<style>
.sfdiv .col-sm-4 { width:100% !important;max-width:100% !important;}
</style>

<? /*<script>$('#sfbutton').addClass('text-center');</script>*/?>
<script>$('#myModal .modal-body').css({"padding":"5px"});</script>

<? } ?>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>

<script language="javascript">

function showBeneficiary(e)	<? //fetch getBeneficiaryDetail by search beneficiary id?>
{
	beneId=$(e).val();
	//alert(beneId);
	var thisurls="../include/getBeneficiaryDetail<?=$data['ex']?>";
		thisurls=thisurls+"?beneId="+beneId;
	
	$.ajax({
		url:thisurls,  
		type: "POST",

		dataType: 'json', // text
		data:{beneId:beneId, action:"get_BeneficiaryDetail"},  
		success:function(data){ 
	
			if(data['Error']&&data['Error'] != ''){  
				alert(data['Error']);
			}else{
				
				$('#beneficiary_id').val(beneId);
				$('#beneficiary_bank_name').val(data['bank_name']);
				$('#beneficiary_name').val((data['beneficiary_name']));
				$('#beneficiary_ac').val((data['account_number']));
				$('#beneficiary_ac_repeat').val((data['account_number']));
				$('#bank_code1').val((data['bank_code1']));
				$('#bank_code2').val((data['bank_code2']));
				$('#bank_code3').val((data['bank_code3']));
			}
		}
	}); 
}
</script>

<script>
	
	$(document).ready(function(){
	
	$(".chosen-select").chosen({
	  no_results_text: "Oops, nothing found!"
	});
		
		$('.submit_data').click(function(){
		
			var transaction_amount=$('#transaction_amount').val();
			var payout_secret_key=$('#payout_secret_key').val();
			
			if(transaction_amount.length==0)
			{
				alert("Amount should not be empty!");
				return false;
			}
			else if(payout_secret_key.length==0)
			{
				alert("Payout Secret Key should not be empty!");
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