<? if(isset($data['ScriptLoaded'])){ ?><? if(!$data['PostSent']){ ?>

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


<style>
.well{border-top:0px; border-radius:3px;}
.row-fluid [class*="span"]{float:left;}
.verified, .primary {float:none;display:inline-block;}
.action .glyphicons i::before{font-size:18px;margin-left:-2px; margin-top:12px;}

@media(max-width:767px)
{
	.well{width:100%;}
	#btnic{float:left;}.heading-buttons{padding-bottom:10px !important;}
}
</style>

<div class="container border my-1 rounded" >

<? if($data['error']){ ?>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
<strong>Error!</strong> <?=prntext($data['error'])?>
</div>

<? }elseif(isset($_POST['change'])) { ?>
<div class="alert alert-success alert-dismissible fade show" role="alert">
<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
<strong>Success ! </strong> Your Change of Setting Information Has Been Updated.
</div>
<? }elseif(isset($_GET['c'])) { ?>
<div class="alert alert-success alert-dismissible fade show" role="alert">
<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
<strong>Success!</strong> Your new e-mail address has been sucessfully activated.
</div>

<? }elseif(isset($_POST['primbtn'])) { ?>

<div class="alert alert-success alert-dismissible fade show" role="alert">
<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
<strong>Success!</strong> Your default e-mail address has been sucessfully changed.
</div>

<? }elseif(isset($_POST['deletebtn'])) { ?>

<div class="alert alert-success alert-dismissible fade show" role="alert">
<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
<strong>Success!</strong> Your e-mail has been successfully deleted.
</div>

<? }?>

<? if(isset($_GET['addnew'])||isset($post['add'])) { ?>
<h4 class="my-2"><i class="<?=$data['fwicon']['circle-plus'];?>"></i> Add A New Email Address</h4>


<label for="newmail">Your new e-mail address:</label>
<form method="post">
<input type="text" name="newmail" class="form-control" value="" />
<button type="submit" name="addnow" value="Add"  class="btn btn-primary my-2 w-25"><i class="<?=$data['fwicon']['circle-plus'];?>"></i> Add</button>
</form>

</div>
<? }else{ ?>
               
<div class="vkg">
<h4 class="mt-2 mb-2"><i class="<?=$data['fwicon']['setting'];?>"></i> <?=prntext($data['PageName'])?> Settings</h4>
</div>

	
	
<div class="mt-2 table-responsive-sm">

<table class="table table-hover">
  <thead>
    <tr>
      <th>Block IP</th>
      <th>Customer Name</th>
      <th>Email</th>
      <th>Price</th>
      <th>Website ID</th>
      <th>Date</th>
      <th>Action</th>
    </tr>
  </thead>
  <? $idx=0;foreach($post['arr'] as $ke=>$va){ $bgcolor=$idx%2?'#EEEEEE':'#E7E7E7'?>
  <tr>
    <td data-label="Block IP"><?=prntext($va['ip'])?></td>
    <td data-label="Customer Name"><?=prntext($va['request']['ccholder'])?> <?=prntext($va['request']['ccholder_lname'])?></td>
    <td data-label="Email"><?=prntext($va['request']['email'])?></td>
    <td data-label="Price"><?=prntext($va['request']['price'])?></td>
    <td data-label="Website ID"><?=prntext($va['request']['store_id'])?></td>
    <td data-label="Date"><?=prntext($va['date']);?></td>
    <td data-label="Action" class="action">
	<a href="<?=$data['USER_FOLDER']?>/ip_settings<?=$data['ex']?>?id=<?=prntext($va['ip'])?>&action=delete" onClick="return confirm('Are you Sure to Remove Block IP');" title="Delete"><i class="<?=$data['fwicon']['delete'];?>"></i> Remove Block IP</a>
    </td>
  </tr>
  <? $idx++; }?>
</table>


</div>


<div class="my-2 text-end">			   
	
	<a href="<?=$data['Host'];?>/create_htaccess<?=$data['ex'];?>" class="btn btn-primary w-25" target="hform" style="float:none;display:block;"><i class="<?=$data['fwicon']['check-plus'];?>"></i> Remove Block IP</a>
</div>	

	


</div>
<? }?>
<? }?>
<? }else{ ?>SECURITY ALERT: Access Denied<? }?>


                                    