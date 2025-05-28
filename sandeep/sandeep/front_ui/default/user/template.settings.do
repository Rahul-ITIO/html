<? if(isset($data['ScriptLoaded'])){ ?>
<? if(!$data['PostSent']){ ?>
<script>
$(document).ready(function(){ 
	
	$('#merchant_pays_fee').on("click keypress keyup keydown change input",function(e){
		$thisVal=$(this).val();
		if($thisVal<=100){
			$thisVal=(100-$thisVal);
			$('#from_pays_fee').text($thisVal);
		}else{
			alert('Can not add above 100');
		}
	});
	
	
	$('#merchant_pays_fee').trigger('click');
	

	
	
});
</script>
<div id="zink_id" class="container my-2 border bg-white">
<div class="container my-2">
  <? if($data['error']){ ?>
  <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error! </strong>
    <?=prntext($data['Error'])?>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <? }elseif(isset($_POST['change'])) { ?>
  <div class="alert alert-success alert-dismissible fade show" role="alert"> <strong>Success!</strong> Your Change of Setting Information Has Been Updated.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <? }elseif(isset($_GET['c'])) { ?>
  <div class="alert alert-success alert-dismissible fade show" role="alert"> <strong>Success!</strong> Your new e-mail address has been sucessfully activated.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <? }elseif(isset($_POST['primbtn'])) { ?>
  <div class="alert alert-success alert-dismissible fade show" role="alert"> <strong>Success!</strong> Your default e-mail address has been sucessfully changed.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <? }elseif(isset($_POST['deletebtn'])) { ?>
  <div class="alert alert-success alert-dismissible fade show" role="alert"> <strong>Success!</strong> Your e-mail has been successfully deleted.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <? } ?>
</div>
<? if(isset($_GET['addnew'])||isset($post['add'])) { ?>
<div class="container-sm my-2 border vkg" >
  <h4><i class="<?=$data['fwicon']['email-open'];?>"></i> Add A New Email Address</h4>
  <form method="post">
    <div class="mb-3 row">
      <label for="staticEmail" class="col-sm-2 col-form-label">Your new e-mail address:</label>
      <div class="col-sm-12">
        <input type="email" class="form-control" name="newmail" placeholder="Email" value="" autocomplete="off" required/>
      </div>
    </div>
    <div class="mb-3 row">
      <div class="col-sm-12">
        <button class="btn btn-primary" type="submit" name="addnow" value="Add" style="width:100%;">Add</button>
      </div>
    </div>
  </form>
</div>
<? }else{ ?>

 <div class="row vkg my-2 clearfix_ice"> 
  <h4><i class="<?=$data['fwicon']['setting'];?>"></i> Settings</h4>
  </div>
<div class="container-sm border my-2 " >

  <form method="post">
      <div  id="cssforsetting" class="row my-2">
      <label for="staticEmail" class="col-sm-3 col-form-label fs-6">Block/ Whitelisted IP : </label>
      <div class="col-sm-9">
        <input <?=$ep;?> type="text" class="form-control" name="setting[whitelisted_ip]" id="whitelisted_ip"  placeholder="IP ex.: 207.174.213.22" value="<?=prntext($post['json_setting']['whitelisted_ip'])?>" autocomplete="off" required/>
      </div>
    </div>
	
      <div class="row mb-3">
      <div class="col-sm-3 fs-6 col-form-label">Fees : </div>
      <div class="col-sm-9">
        <p class="font-monospace">In this block you can customize commission fee and find out how much in percentage terms you will pay (merchant) and how much a client (customer).<br/>
          For example: The buyer will pay 43%, and the merchant 57% of the total transaction fee.</p>
      </div>
	  </div>
	  
      <div class="row mb-3">
        <div class="col-sm-3">
          <label for="staticEmail" class="col-sm-12 col-form-label fs-6">Customer pays : </label>
        </div>
        <div class="col-sm-9">
          <div class="input-group mb-2"> 
		  <span class="input-group-text" id="basic-addon1">Fee :</span>
            <input <?=$ep;?> type="text" class="form-control" name="setting[merchant_pays_fee]" id="merchant_pays_fee"  placeholder="Fee ex.: 50" value="<?=prntext($post['json_setting']['merchant_pays_fee'])?>" autocomplete="off" required/>
            <span class="input-group-text" id="basic-addon1">%</span> </div>
			
			<div class="font-monospace">&nbsp;and Merchant pays <span style="font-weight:bold;"><span id="from_pays_fee"></span> %</span> of total fees</div>
        </div>
      </div>
      <div class="row mb-3">
        <div class="col-sm-12">
          <button class="btn btn-primary" type="submit" name="change" value="CHANGE NOW!" >
		  <i class="far fa-check-circle"></i> Submit</button>
        </div>
      </div>
    
  </form>
</div>
<? } ?>
<? } ?>
</div>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
