<? if(isset($data['ScriptLoaded'])){ ?>

<div class="container border mt-2 mb-2 bg-white" >
<? if(!$data['PostSent']){ ?>
<script>
//.user_type
function user_typef(theValue){
	//alert(theValue);
	$('.business_div').slideUp(200);
	$('#add_partners_divId').slideUp(100);
	if(theValue=="2"){
		$('.business_div').slideDown(1500);
		$('#add_partners_divId').slideDown(900);
	}
	
}
function document_typef(e,theValue){
	$(e).parent().parent().find('#document_no').removeAttr('placeHolder');
	$(e).parent().parent().find('#document_no').attr('placeHolder','Enter '+theValue+' No.');
	$(e).parent().parent().find('#updatelogo_labelId').html('Upload '+theValue);
}
$(document).ready(function(){ 
	$(".user_type").click(function(){
		//user_typef($(this).val());
	});
	
	
});
</script>


<form method="post">
  
  <? if($data['Error']){ ?>
  <div class="alert alert-danger alert-dismissible fade show" role="alert">
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    <strong>Error!</strong><?=prntext($data['Error'])?>
  </div>
  <? } ?>

    <h4 class="my-2"><i></i>Updates settings</h4>
  
  <div class="row my-2">
  <div class="col-sm-6">
    <label for="FirstName">Increase Transaction Amount in <?=$data['cur'][1];?></label>
    <select name="amount_transaction_limit" id="amount_transaction_limit" class="form-select">
      <option value="" selected="">Select Transaction Amount in <?=$data['cur'][1];?></option>
      <option value="900">900</option>
      <option value="1800">1800</option>
    </select>
    <script>$('#amount_transaction_limit option[value="<?=$post['amount_transaction_limit']?>"]').prop('selected','selected');			</script>
	</div>
	<div class="col-sm-6">
    <label for="FirstName">Increase Withdrawal Amount in <?=$data['cur'][1];?></label>
    <select name="amount_withdrawal_limit" id="amount_withdrawal_limit" class="form-select">
      <option value="" selected="">Select Withdrawal Amount in <?=$data['cur'][1];?></option>
      <option value="900">900</option>
      <option value="1800">1800</option>
    </select>
<script>$('#amount_withdrawal_limit option[value="<?=$post['amount_withdrawal_limit']?>"]').prop('selected','selected');	</script>
</div>
 
  <div class="col-sm-12 my-2" >
    <button id="confirm_amount_submit" type="submit" name="change" value="CHANGE NOW" class="submit btn btn-icon btn-primary"><i class="<?=$data['fwicon']['check-circle'];?>"></i> <b class="contitxt">Submit</b></button>
    <button type="button" name="cancel" value="BACK" class="dialog_box2 btn btn-icon btn-primary remove_popup"><i class="<?=$data['fwicon']['circle-cross'];?>"></i> <b class="contitxt">Cancel</b></button>
  </div>
   </div>
</form>
<? }elseif($post['action']=='success'){ ?>


  <h4 class="my-2"> My Updates</h3>

  <div class="alert alert-success alert-dismissible fade show" role="alert">
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    <strong>Success!</strong> Your Information Has Been Updated. </div>


  <div class="my-2 text-center"><a href="<?=$data['USER_FOLDER']?>/updates<?=$data['ex']?>">Back</a>&nbsp;|&nbsp;<a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>">Account Overview</a>
 </div> 
  <? } ?>
</div>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
