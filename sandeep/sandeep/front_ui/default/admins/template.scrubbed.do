<? if(isset($data['ScriptLoaded'])){?>

<? if(isset($_GET['hideAllMenu'])&&$_GET['hideAllMenu']==1){ ?>
<style>
.container.border { border: unset !important; }
</style>
 <? } ?>
<script type="text/javascript">
function checkvalidation(){
	if (document.getElementById("scrubbed_period").value.trim() == "") {
		document.getElementById("scrubbed_period").focus();
		alert("Please Select scrubbed period!");
		return false;
	}
			
	
	if (document.getElementById("min_limit").value.trim() == "") {
		document.getElementById("min_limit").focus();
		alert("Please Enter Min Limit!");
		return false;
	}
		if (document.getElementById("max_limit").value.trim() == "") {
		document.getElementById("max_limit").focus();
		alert("Please Enter Max Limit!");
		return false;
	}
		if (document.getElementById("tr_scrub_success_count").value.trim() == "") {
		document.getElementById("tr_scrub_success_count").focus();
		alert("Please Enter Success Count!");
		return false;
	}
		if (document.getElementById("tr_scrub_failed_count").value.trim() == "") {
		document.getElementById("tr_scrub_failed_count").focus();
		alert("Please Enter Failed Count!");
		return false;
	}
}
</script>

<form method="post" name="data">
<input type="hidden" name="action" value="insert" />
<div class="my-2 bg-white vkg" >
<? if(isset($data['Error'])&&$data['Error']){?>
      <div class="alert alert-error">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        <strong>Error!</strong>
        <?=prntext($data['Error'])?>
      </div>
      <? } ?>
      <? if($_SESSION['action_success']){ ?>
      <div class="alert alert-success">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        <?php echo $_SESSION['action_success'];?> </div>
      <? $_SESSION['action_success']=null;} ?>
	  
<h4 class="m-2"><i class="<?=$data['fwicon']['setting'];?>"></i> Add Scrubbed </h4>
<div class="row m-1 text-start vkg border rounded" >  



				
		
<div class="row col-sm-6 my-2 ">
<div class="col-sm-5"><label for="salt_name" ><strong>Scrubbed Period: </strong></label></div>
<div class="col-sm-7"><select name="scrubbed_period" id="scrubbed_period" title="Scrubbed Period"  class="form-select" required>
            <option value="" disabled="" selected="">Scrubbed Period</option>
            <option value="1" <? if(in_array(1, $_SESSION['keyvalsess'])){?> disabled="disabled" <? } ?>>1 Day</option>
            <option value="7" <? if(in_array(7, $_SESSION['keyvalsess'])){?> disabled="disabled" <? } ?>>7 Days</option>
            <option value="15" <? if(in_array(15, $_SESSION['keyvalsess'])){?> disabled="disabled" <? } ?>>15 Days</option>
            <option value="30" <? if(in_array(30, $_SESSION['keyvalsess'])){?> disabled="disabled" <? } ?>>30 Days</option>
            <option value="90" <? if(in_array(90, $_SESSION['keyvalsess'])){?> disabled="disabled" <? } ?>>90 Days</option>
          </select></div>
</div>




<div class="row col-sm-6 my-2 ">
<div class="col-sm-5"><label for="salt_name"><strong>Min Trxn Limit: </strong>(<?=$_GET['curr'];?>)</label></div>
<div class="col-sm-7"><input type="number" name="min_limit" class="form-control" id="min_limit"  placeholder="Enter Min Limit" required></div>
</div>


<div class="row col-sm-6 my-2 ">
<div class="col-sm-5"><label for="comments"><strong>Max Trxn Limit: </strong>(<?=$_GET['curr'];?>): </label></div>
<div class="col-sm-7"><input type="number" class="form-control" id="max_limit"  name="max_limit" placeholder="Enter Max Limit" required></div>
</div> 

<div class="row col-sm-6 my-2 ">
<div class="col-sm-5"><label for="salt_name" ><strong>Min. Success Count:</strong></label></div>
<div class="col-sm-7"><input type="number" name="tr_scrub_success_count" id="tr_scrub_success_count" class="form-control" placeholder="Enter Min. Success Count" required></div>
</div>

<div class="row col-sm-6 my-2 ">
<div class="col-sm-5"><label for="comments" ><strong>Min. Failed Count: </strong></label></div>
<div class="col-sm-7"><input type="number" class="form-control" id="tr_scrub_failed_count"  name="tr_scrub_failed_count"  placeholder="Enter Min. Failed Count" required></div>
</div>
         

<div class="col-sm-12 text-center my-2">
<button type="submit" name="send" value="CONTINUE" onclick="return checkvalidation()" class="btn btn-primary" > <i class="<?=$data['fwicon']['check-circle'];?>"></i> Submit</button>
<?php /*?><a href="<?=$data['Admins']?>/<?=$data['PageFile']?><?=$data['ex']?>" class="btn btn-primary " ><i class="<?=$data['fwicon']['back'];?>"></i> Back</a><?php */?> </div>

          

  
</div></div>
</form>

<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
