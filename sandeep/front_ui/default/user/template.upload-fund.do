<? if(isset($data['ScriptLoaded'])){?>
<style>
#modal_mfa {display:none;}
</style>

<div id="zink_id">

<? include $data['Path']."/include/message".$data['iex'];?>

<? if($post['step']==1){ ?>

<div class="container my-2 py-2 border rounded" >
	<div class="row vkg">
		<div class="col-sm-12 ">
			<h4 class="float-start"><i class="<?=$data['fwicon']['arrow-right-arrow-left'];?>"></i> Batch Transfer</h4>
		</div>
	<? 
//	$data['view_balance']=1;
//	include "../front_ui/{$data['frontUiName']}/common/payout-menu".$data['iex'];
	include "../include/payout-menu".$data['iex'];
	?>
	</div>
<? 

$keyExists = 1;
if(empty($post['payout_secret_key'])){ 
	$keyExists = 0;?>

<div>
<span>Payout Secret Key Not Generated </span>
<a class="text-primary" title="Generate Secret Key" href="<?=$data['USER_FOLDER']?>/payout-keys<?=$data['ex']?>">[ <strong>Generate Payout Secret Key</strong> ]</a>
</div>
<? }
if(empty($post['payout_token'])){ 
	$keyExists = 0;?>
<div>
<span>Payout Token Not Generated </span>
<a class="text-primary" title="Generate Payout Token" href="<?=$data['USER_FOLDER']?>/payout-keys<?=$data['ex']?>">[ <strong>Generate Payout Token</strong> ]</a>
</div>

<? }
if(empty($post['apikey'])){ 
	$keyExists = 0;?>

<div>
<span>Api Key Not Generated </span>
<a class="text-primary" title="Generate  Api Key" href="<?=$data['USER_FOLDER']?>/payout-keys<?=$data['ex']?>">[ <strong>Generate Api Key</strong> ]</a>
</div>

<? }
if($keyExists){ ?>

 
  <form method="post" id="myPostForm" name="data" enctype="multipart/form-data">
  <div class="row px-2">
     <div class="col-sm-4 px-1">
            
             <input type="file" class="form-control px-2  my-2 fileUpload" style="height:35px;"  name="file" title="Upload File" required>
          
          </div><div class="col-sm-3 px-1">
				<input type="password" class="form-control px-2 my-2" style="height:35px;" name="secret_word" title="Secret Word" placeholder="Secret Word" required>
			</div>

	 <div class="col-sm-2">
    
      <button id="b_submit" class="btn btn-primary my-2 submit_data" type="su" name="" value="submit_data"><i class="<?=$data['fwicon']['cloud-arrow'];?>"></i> Upload</button>
  

	</div>
  </div>
  
  
  
		
		<?
		//if($data['withdraw_gmfa']){
			unset($data['FUND_STEP']);
			//$data['user_pass_gmfa']=1;
			$data['type_submit']=1;
		?>
			<? 
			include('../include/device_confirmations'.$data['iex']);?>
		<? //}?>
		
		
	<script>
		
		$(document).ready(function(){
			
			$('.submit_data').click(function(){
				if($('.fileUpload').val()==''){
					alert('File should not be empty. Please upload file.');
					return false;
				}else{
					$('#modal_mfa').show(1500); 
				}				
			});
			
			
			$('#myPostForm').submit(function(e){ 
			  try {
				 // alert(e.result);
				if($('#b_submit').hasClass('active')){
					return true;
				}else{ 
				 
					
				 <? if($data['withdraw_gmfa']){?>
				  //alert('MFA');
					//$('#modal_with_div1').html($('#calculate_div_id').html());
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
	

</form>
  <div class="row">
    <div class="col-sm-12 mt-4">
	<div><i class="<?=$data['fwicon']['eye'];?> text-info fa-fw" title="view"></i>  <a class="hrefmodal  text-decoration-none text-primary" style="white-space:nowrap;" data-tid="Payout Beneficiary List - <?=$post['id']?>" data-href="<?=($data['Host']."/include/payout_beneficiary_list".$data['ex']);?>?action=details&admin=1&tempui=<?=$data['frontUiName']?>" title="Payout Beneficiary List - <?=$post['id']?>" ><strong>View Beneficiary List</strong></a></div>
	<div><i class="<?=$data['fwicon']['download'];?> text-info fa-fw" title="Download"></i> Download csv file sample format (<a href="../include/uploadfundsheet.csv" title="Download CSV file" class="text-primary"><strong>Download Format </strong></a>) </div> 
	<div><i class="<?=$data['fwicon']['circle-info'];?> text-info fa-fw" title="Instructions"></i> Insert Data in Downloaded CSV Sheet format </div>
	<!--<div> - Convert .xlsx file to .csv file (<a href="https://cloudconvert.com/xlsx-to-csv" title="Click for Convert file Online" target="_blank" class="text-primary"><strong>click here for online convert </strong></a>)</div> -->
	<div><i class="<?=$data['fwicon']['cloud-arrow'];?> text-info fa-fw" title="Upload"></i> Upload Beneficiary List .csv File </div>
	
	 </div>
</div>


<? } ?>


</div>
<? } ?>

</div>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
