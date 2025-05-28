<? if(isset($data['ScriptLoaded'])){ ?>
<style>
/*for page css*/
.form-control.form-control-sm{ max-width:280px !important;}
#exampleModal90 .form-control.form-control-sm{ max-width:100% !important;}
</style>

<div class="container mt-2 mb-2 border bg-primary rounded vkg" >
<div class="my-2">
<div class="float-start w-50"><h4><i class="<?=$data['fwicon']['profile'];?> my-2"></i> Profile</h4></div>
<div class="float-end"><a href="<?=$data['Admins'];?>/history<?=$data['ex']?>?clients=<?=$post['id']?>" class="btn btn-primary btn-sm modal_from_url text-dark" title="&nbsp;"  target="_blank"><span title="Login IP History" data-bs-toggle="tooltip" data-bs-placement="left">IP History</span></a></div>
</div>

<? if(isset($_SESSION['success'])&&$_SESSION['success']<>''){ ?>
<div class="alert alert-success alert-dismissible fade show">
  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  <strong>Success:</strong> <?=$_SESSION['success'];?>
  </div>
 <? 
 unset($_SESSION['success']);
 } 
 ?>
<? if(isset($_SESSION['error'])&&$_SESSION['error']<>''){ ?>
<div class="alert alert-danger alert-dismissible fade show">
  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  <strong>Error:</strong> <?=$_SESSION['error'];?>
  </div>
 <? 
 unset($_SESSION['error']);
 } 
 ?>
<? 
	$ep=""; 
	if($data['is_admin']){
		$ep=""; 
	}elseif($_SESSION['edit_permission']=="1"){
		$ep="disabled='disabled'";
	}
	
?>
<? if(!$data['PostSent']){ ?>


<script>

	function upload_logo_xf(e){
		//alert($('#upload_logo').val());
		
		
		$('.upload_logo #upload_logo').html('');
		$('.upload_logo #upload_logo').val('').empty();

		//alert($('#upload_logo').val());
		$('.upload_logo .appbrand5').remove();
		$('.upload_logo .closeImg').remove();
		
	}
	function logo_path_xf(e){
		//alert($('#upload_logo').val());
		
		
		$('.logo_path #logo_path').html('');
		$('.logo_path #logo_path').val('').empty();

		//alert($('#upload_logo').val());
		$('.logo_path .appbrand5').remove();
		$('.logo_path .closeImg').remove();
		
	}

</script>

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

$(document).ready(function(){ 
	$(".user_type").click(function(){
		user_typef($(this).val());
	});
	$(".add_partners").click(function(){
		$('#modalpopup_add_partner').slideDown(900);
	});
	$(".remove_popup").click(function(){
		$('#modalpopup_add_partner').slideUp(100);
	});
	
	$(".document_type").change(function(){
		document_typef(this,$(this).val());
	});
	
	$(".same_business").click(function(){
		$('#business_address_bs').val($('#registered_address_bs').val());
	});
	
	
	
	$('#merchant_pays_fee').on("click keypress keyup keydown change input",function(e){
		$thisVal=$(this).val();
		if($thisVal<=100){
			$thisVal=(100-$thisVal);
			$('#from_pays_fee').text($thisVal);
		}else{
			alert('Can not add above 100');
		}
	});

	user_typef("<?=$post['user_type'];?>");
	
});
</script>




<div id="content99">

<div class="container-flex my-2 vkg" >

<?php /*?> Button for display login history<?php */?>
 <div class="clearfix" ></div>
  
  <form method="post" enctype="multipart/form-data">
    <input type="hidden" name="action" value="manage_profle">
	<input type="hidden" name="user_type" value="2">
    <input type="text" id="bill_country_name" name="bill_country_name" value="<?=((isset($post['bill_country_name']) &&$post['bill_country_name'])?$post['bill_country_name']:'')?>" style="display:none;">
    <input type="text" id="state_full_name" name="state_full_name" value="<?=((isset($post['state_full_name']) &&$post['state_full_name'])?$post['state_full_name']:'')?>" style="display:none;">
   
	
    <? if($data['InfoIsEmpty']){ ?>
    <div class="alert alert-warning alert-dismissible fade show" role="alert"> <strong>Alert!</strong> You need to fill the below details to complete the sign-up process.
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <? } ?>
	
    <div class="mb-3  border rounded bg-primary text-white" id="withdraw_fund_for_css">
	<h5 class="m-2"><i class="<?=$data['fwicon']['setting'];?>"></i> Account Settings</h5>
  <? if(isset($_SESSION['success'])&&$_SESSION['success']<>''){ ?>
  <div class="alert alert-success mx-2 alert-dismissible fade show" style="max-width:280px;">
  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  <strong>Success:</strong> <?=$_SESSION['success'];?>
  </div>
  <? unset($_SESSION['success']); } ?>
	<div class="row was-validated" style="max-width:350px;">
      
      
      <div class="col-sm-12 mx-2">
	  <div class="input-field mt-4" title="Username should be unique and can not change" data-bs-toggle="tooltip" data-bs-placement="bottom" >
	  
        <input name="text" type="text" disabled="disabled" class="form-control form-control-sm is-invalid" id="inputUsername" value="<?=prntext($post['username'])?>" <?=$ep;?>  required />
		<label for="inputUsername">Username : <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
		</div>
	  </div>
	  	<?
	if(isset($post['fullname'])&&$post['fullname']){
		$fullname = $post['fullname'];
	}else{ 
		$fullname = $post['fname']." ".$post['lname'];
		}
	?>
	  
		
      <div class="col-sm-12 mx-2"><div class="input-field mt-4">
        
        <input <?=$ep;?> type="text" name="fullname" id="pr_fullname" class="form-control form-control-sm" value="<?=prntext($fullname);?>" title="Enter full name" data-bs-toggle="tooltip" data-bs-placement="right" required />
		<label for="pr_fullname">Full Name : <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
      </div></div>
	  
	  
	<?/*?>
	
      <div class="col-sm-12 mx-2"><div class="input-field mt-4">
        
        <input <?=$ep;?> type="text" name="designation" id="pr_designation" class="form-control form-control-sm" value="<?=prntext($post['designation'])?>" title="Enter merchant's designation" data-bs-toggle="tooltip" data-bs-placement="right" required />
		<label for="pr_designation">Designation : <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
      </div></div>
    
      <div class="col-sm-12 mx-2"><div class="input-field mt-4">
        
        <input <?=$ep;?> type="text" name="phone" id="pr_phone" class="form-control form-control-sm" value="<?=prntext($post['phone'])?>" required title="Enter merchant's Contact number" data-bs-toggle="tooltip" data-bs-placement="right"  />
		<label for="pr_phone">Merchant's Contact : <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
      </div></div>
	

	
      <div class="col-sm-12 mx-2" style="max-width:305px;">
	  <div class="input-field select mt-4">
        
				
<select <?=$ep;?> name="merchant_ims_type" id="merchant_ims_type" class="form-select form-select-sm" autocomplete="off" title="Select merchant's im's type" data-bs-toggle="tooltip" data-bs-placement="right" required>
				<option value="">&nbsp;</option>
				<option value="Skype">Skype</option>
				<option value="Telegram">Telegram</option>
				<option value="WhatsApp">WhatsApp</option>
				</select>
				<label for="merchant_ims_type">Merchant IM'S : </label>
				<? if(isset($post['business_ims_type'])){?>
				<script>
				$('#merchant_ims_type option[value="<?=prntext($post['merchant_ims_type'])?>"]').prop('selected','selected');
				</script>
				<? } ?> 
				
				</div>
	</div>
				
				
	  <div class="col-sm-12 mx-2">
	  <div class="input-field mt-4">	
			<input <?=$ep;?> type="text" name="merchant_ims" id="pr_merchant_ims" class="form-control form-control-sm " value="<? if(isset($post['merchant_ims'])) echo prntext($post['merchant_ims'])?>" title="Enter merchant's im's id" data-bs-toggle="tooltip" data-bs-placement="right" required />
		<label for="pr_merchant_ims" >IM'S ID : </label>	
      </div>
	  </div>
      
      
    <?*/?>  
      
	  
	  
      
  
        
        <div class="col-sm-12 mx-2">
         <div class="input-field mt-4">
<input <?=$ep;?> type="text" name="company_name" id="pr_company" class="form-control form-control-sm" value="<? if(isset($post['company_name'])) echo prntext($post['company_name'])?>" title="Enter Company name" data-bs-toggle="tooltip" data-bs-placement="right"  required />
		  <label for="pr_company"> Company Name: <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
        </div>
		</div>
		
		
<div class="col-sm-12 mx-2">
<div class="input-field mt-4">


<input <?=$ep;?> type="text" name="registered_address" id="registered_address_bs"  class="form-control form-control-sm sml"  value="<?=@$post['registered_address']?>" title="Enter registered address" data-bs-toggle="tooltip" data-bs-placement="right" required/>
<label for="registered_address_bs"> Registered Address: <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>		  
</div>
</div>
        

<?/*?>	
		<div class="col-sm-12 mx-2">
       <div class="input-field mt-4">               
                       
                        <input <?=$ep;?> type="text" name="business_contact" id="business_contact" class="form-control form-control-sm w-100 sml"  value="<?=(isset($post['business_contact'])?$post['business_contact']:'');?>" title="Enter business contact" data-bs-toggle="tooltip" data-bs-placement="right" required />
 <label for="business_contact">Business Contact : <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>                    
</div></div>
					
					<div class="col-sm-12 mx-2" style="max-width:305px;">
                      
                        
						
                   <div class="input-field select mt-4">      
						<select <?=$ep;?> name="business_ims_type" id="business_ims_type" class="form-select form-select-sm float-start" autocomplete="off" title="Select ims type" data-bs-toggle="tooltip" data-bs-placement="right">
						<option value="">&nbsp;</option>
						<option value="Skype">Skype</option>
						<option value="Telegram">Telegram</option>
						<option value="WhatsApp">WhatsApp</option>
						</select>
			<label for="business_ims_type">IM'S Type : <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>			
		   <? if(isset($post['business_ims_type'])){?>
           <script>
			$('#business_ims_type option[value="<?=prntext($post['business_ims_type'])?>"]').prop('selected','selected');
		   </script>
		   <? } ?>
		           </div>
				   </div>
				   <div class="col-sm-12  mx-2">
				   <div class="input-field mt-4">
						 <input <?=$ep;?> type="text" name="business_ims" id="business_ims" class="form-control form-control-sm  sml float-start" value="<?=(isset($post['business_ims'])?$post['business_ims']:'');?>" title="Enter business im's id" data-bs-toggle="tooltip" data-bs-placement="right" required />
						 <label for="business_ims">IM'S ID : <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>		
					</div>	 
						 
						 </div> 
		<?*/?>	
						 </div>
                     
                      
                    
        
        <div class="form-actions ok text-left m-2 mt-4">
		<? if($ep<>"disabled='disabled'"){;?>
          <button <?=$ep;?> type="submit" name="change" value="CHANGE NOW!"  class="btn btn-icon btn-primary w-100" style="max-width:282px;"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Save changes</button>
		<? } ?>
		</div>
    <!--  </div>-->
    </div></div>
	
	<?  $prn_count=principal_count($_SESSION['uid']);//echo $prn_count;
	if($prn_count==1){
	?>
    <div id="add_partners_divId" >
      <h4 class="my-2" id="encoded_contact_person_info"><i class="<?=$data['fwicon']['user'];?>"></i> SPOC Information/Details</h4>
      
      
      <div id="add_partners_html" class="bg-primary row my-2" >
	    <?php /*?>Display Spoc Information from function<?php */?>
         <? spoc_view($_SESSION['uid']);?>
       </div>
	   <? if($ep==""){ ?>
      <div class="form-actions ok text-center my-2">
        <button <?=$ep;?> type="button" name="add_partners" value="CONTINUE"  data-bs-toggle="modal" data-bs-target="#exampleModal90" class="btn btn-primary"><i class="<?=$data['fwicon']['circle-plus'];?>"></i> Add SPOC</button>
      </div>
	   <? } ?>
	  
	  <!-- Button trigger modal -->




    </div>
	<? } ?>
  </form>
</div>
<?
if(!empty($post['encoded_contact_person_info'])){
	$post['fullname']="";
	$post['fname']="";
	$post['lname']="";
	$post['designation']="";
	$post['phone']="";
	$post['email']="";
	$post['birth_date']="";
	$post['address']="";
	$post['city']="";
	$post['state']="";
	$post['country']="";
	$post['zip']="";
	$post['document_type']="";
	$post['document_no']="";
	$post['upload_logo']="";
}
?>
  
  <div class="modal fade" id="exampleModal90" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" style="max-width: 80%; padding-top:50px;margin: auto;">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"><i class="<?=$data['fwicon']['circle-plus'];?>"></i> Add SPOC</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-0">
    <form id="add_principal_form" method="post" enctype="multipart/form-data">
      <div class="modalpopup_cdiv container">
        <input type="hidden" name="action" value="add_principal">
        <div class="row px-2 was-validated">
          
          <div class="col-sm-6 my-1">
           <div class="input-field mt-4">
            <input type="text" name="fullname" id="input_fullname" class="form-control form-control-sm" value="<? if(isset($post['fullname'])&&$post['fullname']) echo $post['fullname']; else prntext($post['fname']).' '.prntext($post['lname']);?>"  title="Enter your full name" data-bs-toggle="tooltip" data-bs-placement="right" required />
			 <label for="input_fullname">Full Name <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
           </div>
		  </div>

          <div class="col-sm-6 my-1">
           <div class="input-field mt-4">
       <input type="text" name="designation" id="input_designation" class="form-control form-control-sm" value="<? if(isset($post['designation'])) echo $post['designation']?>" title="Enter your designation" data-bs-toggle="tooltip" data-bs-placement="right" required />
	   <label for="input_designation">Designation <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
          </div>
		  </div>
          <div class="col-sm-6 my-1">
           <div class="input-field mt-4">
            <input type="text" name="phone" id="input_phone" class="form-control form-control-sm" value="<? if(isset($post['phone'])) echo $post['phone']?>" title="Enter your contact numner" data-bs-toggle="tooltip" data-bs-placement="right" required  />
			<label for="input_phone">Contact <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
          </div></div>
          <div class="col-sm-6 my-1 ">
		 
		  <span class="row">
		  <div class="col-sm-4">
		  <div class="input-field select mt-4">
			            <select name="ims_type" id="ims_type" class="form-select w-100" title="Enter ims type" data-bs-toggle="tooltip" data-bs-placement="right" autocomplete="off" required>
						<option value="">&nbsp;</option>
						<option value="Skype">Skype</option>
						<option value="Telegram">Telegram</option>
						<option value="WhatsApp">WhatsApp</option>
						</select>
						<label for="ims_type">IM'S Type <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
		   <? if(isset($post['ims_type'])){?>
           <script>
			$('#ims_type option[value="<?=prntext($post['ims_type'])?>"]').prop('selected','selected');
		   </script>
		   <? } ?>
			</div></div>
			<div class="col-sm-8">
			 <div class="input-field mt-4">
			<input type="text" name="email" value="<?=$post['email']?>" id="input_email" title="Enter ims value" data-bs-toggle="tooltip" data-bs-placement="right" required  class="form-control w-100"/>
			<label for="input_email">IM'S Type <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
          </div></div>
           </span> 
       
          </div>

<div class="col-sm-12 text-center my-2">
<button id="confirm_amount_submit" type="submit" name="cardsend" value="SUBMIT" class="submit btn btn-icon btn-primary"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Submit</button>
<button type="button" class="btn btn-primary" data-bs-dismiss="modal"><i class="<?=$data['fwicon']['circle-cross'];?>"></i> Close</button>
</div>
          <!-- END -->
        </div>
      </div>
    </form>

 
 </div>
      <div class="modal-footer">
        
      </div>
    </div>
  </div>
</div>

<? }else{ ?>


<div style="clear:both"></div>
  <h4 class="My-2" style=""><i class="<?=$data['fwicon']['circle-info'];?>"></i> My Information</h4>



<div class="alert alert-success alert-dismissible fade show">
  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  <strong>Success!</strong> Your Profile Information Has Been Updated. 
  </div>


<div class="text-center my-2 remove-link-css"><a href="<?=$data['USER_FOLDER']?>/profile<?=$data['ex']?>" class="btn btn-primary"><i class="<?=$data['fwicon']['profile'];?>" title="Back to Profile"></i></a> <a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>" class="btn btn-primary" title="Dashboard"><i class="<?=$data['fwicon']['home'];?>"></i></a></div>

</div>

<? } ?>
</div></div>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
