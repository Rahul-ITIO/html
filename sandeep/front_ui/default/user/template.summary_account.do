<? if(isset($data['ScriptLoaded'])){ 

// Check Profile Edit Permission
    $ep=""; 
	if(isset($data['is_admin'])&&$data['is_admin']){
		$ep=isset($ep)&&$ep?$ep:'';; 
		$bn=isset($bn)&&$bn?$bn:'';
	}elseif($post['edit_permission']=="1"){
		$ep="disabled='disabled'";
		$bn="v";
	}


  
// For Check Spoc status is null
if(isset($post['encoded_contact_person_info'])&&$post['encoded_contact_person_info']&&$post['encoded_contact_person_info']!='_;'){
$mb_spoc='<i class="'.$data['fwicon']['check-circle'].' text-success"></i> Filled required spoc information <i class="'.$data['fwicon']['circle-plus'].'  float-end pointer summary_accounts  text-link" title="Click to add new SPOC information" data-tid="d3"  data-bs-toggle="tooltip" data-bs-placement="right"></i>';
}else{
$mb_spoc='<i class="'.$data['fwicon']['circle-info'].' text-danger"></i> Missing required spoc information <i class="'.$data['fwicon']['edit'].'  float-end pointer summary_accounts  text-link" title="Click to edit new SPOC information" data-tid="d3"  data-bs-toggle="tooltip" data-bs-placement="right"></i>';
}
  


  
// For Check business Desc Status
if((isset($post['fullname'])&&$post['fullname']) && (isset($post['designation'])&&$post['designation']) && (isset($post['phone'])&&$post['phone']) &&(isset($post['company_name'])&&$post['company_name']) && (isset($post['business_contact'])&&$post['business_contact']) && (isset($post['registered_address'])&&$post['registered_address'])){
 $mb_desc_status='<i class="'.$data['fwicon']['check-circle'].' text-success"></i> Filled required business details <i class="'.$data['fwicon']['edit'].'  float-end pointer summary_accounts text-link" title="Click to edit business details" data-tid="d2" data-bs-toggle="tooltip" data-bs-placement="right"></i>';
$buss_details="Summary";
}else{
$mb_desc_status='<i class="'.$data['fwicon']['circle-info'].' text-danger"></i> Missing required business details <i class="'.$data['fwicon']['edit'].'  float-end pointer summary_accounts  text-link" title="Click to edit business details" data-tid="d2" data-bs-toggle="tooltip" data-bs-placement="right"></i>';
 $buss_details="";
}

//For Open business Desc section when data not filled or summary page when data filled

 if($buss_details==""){ $dbd="show"; $summ=""; $showhide=".show_d2";
 }else{ $dbd=""; $summ="show"; $showhide=".show_d5"; }
 
  
  // for chech 2FA status
  if(($post['google_auth_access']==2) || ($post['google_auth_access']==0) || ($post['google_auth_access_withut_json']==2) || ($post['google_auth_access_withut_json']==0)){
  $qstatus="De-activate";$qicon=$data['fwicon']['circle-cross']." text-danger";
  $mb_2fa='<i class="'.$data['fwicon']['circle-cross'].' text-danger"></i> Two-step authentication de-activate <i class="'.$data['fwicon']['edit'].'  float-end pointer summary_accounts  text-link" title="Click to Update Two-step authentication" data-tid="d4" data-bs-toggle="tooltip" data-bs-placement="right"></i>';
  }else{ 
  $qstatus="Activated";$qicon=$data['fwicon']['check-circle']." text-success";
  $mb_2fa='<i class="'.$data['fwicon']['check-circle'].' text-success"></i> Two-step authentication activated <i class="'.$data['fwicon']['edit'].'  float-end pointer summary_accounts  text-link" title="Click to de-activate / reset two step authentication" data-tid="d4" data-bs-toggle="tooltip" data-bs-placement="right"></i>';
  }
 



if($primary_bank=banks_primary($post['id'])){ 
//print_r($primary_bank);
$primary_bank['bname'];
$primary_bank['baddress'];
$primary_bank['required_currency'];
$primary_bank['baddress'];
decrypts_string($primary_bank['baccount'],1,2,4);
$mb_bank_status='<i class="'.$data['fwicon']['check-circle'].' text-success"></i> Bank account Added <a href="'.$data['USER_FOLDER'].'/bank'.$data['ex'].'?HideAllMenu=1"  class="'.$data['fwicon']['eye-solid'].'  float-end pointer modal_for_iframe  text-link" title="Click to  view added bank account" data-tid="d4" data-bs-toggle="tooltip" data-bs-placement="right"></a>';

}elseif($primary_bank=banks_primary($post['id'],'coin_wallet')){

$primary_bank['coins_wallet_provider'];
decrypts_string($primary_bank['coins_address']);
$primary_bank['required_currency'];
$primary_bank['coins_network'];

$mb_bank_status='<i class="'.$data['fwicon']['check-circle'].' text-success"></i> Coin wallet Added <a href="'.$data['USER_FOLDER'].'/bank'.$data['ex'].'?HideAllMenu=1"  class="'.$data['fwicon']['edit'].'  float-end pointer modal_for_iframe  text-link" title="Click to  add bank account" data-tid="d4" data-bs-toggle="tooltip" data-bs-placement="right"></a>';
}else{

$mb_bank_status='<i class="'.$data['fwicon']['circle-info'].' text-danger"></i> Missing bank details information <a href="'.$data['USER_FOLDER'].'/bank'.$data['ex'].'?HideAllMenu=1"  class="'.$data['fwicon']['edit'].'  float-end pointer modal_for_iframe  text-link" title="Click to add bank account" data-tid="d4" data-bs-toggle="tooltip" data-bs-placement="right"></a>';
}



?>

<div id="zink_id" class="container mt-2 mb-2 rounded border bg-primary text-white vkg" >
  <h4 class="mt-2"><i class="<?=$data['fwicon']['account-summary'];?>"></i> Account Summary</h4>
  <div class="row vkg clearfix_ice my-2">
  
  <div class="col-sm-3"><div class="accordion" id="accordionExample">
	
  <div class="accordion-item">
    <h2 class="accordion-header" id="headingOne">
      <span class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
         Verify Your Business
      </span>
    </h2>
    <div id="collapseOne" class="accordion-collapse collapse <?=$dbd;?>" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
      <div class="accordion-body">
       <!--<a title="Add your business Proprietor" class="text-link pointer summary_accounts" data-tid="d1"> <i class=""></i> Business Proprietor</a> <br />-->
	   <a title="Add your business details" class="text-link pointer summary_accounts" data-tid="d2"><i class="<?=$data['fwicon']['circle-dot'];?>"></i> Business Details</a> <br />
       <a title="Add your business representative" class="text-link pointer summary_accounts" data-tid="d3"> <i class="<?=$data['fwicon']['circle-dot'];?>"></i> Spoc Info</a> <br />
      </div>
    </div>
  </div>
  
  <div class="accordion-item">
    <h2 class="accordion-header" id="headingTwo">
      <span class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="true" aria-controls="collapseOne">
        Add Your Bank
      </span>
    </h2>
    <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
      <div class="accordion-body">
        <a href="<?=$data['USER_FOLDER']?>/bank<?=$data['ex']?>?HideAllMenu=1" title="Add your bank account" class="text-link  modal_for_iframe"><i class="<?=$data['fwicon']['circle-dot'];?>"></i> Bank Account</a> <br />
        <a href="<?=$data['USER_FOLDER']?>/bank<?=$data['ex']?>?HideAllMenu=1" title="Add your crypto wallet" class="text-link modal_for_iframe"><i class="<?=$data['fwicon']['circle-dot'];?>"></i> Crypto Wallet</a> <br />
		
      </div>
    </div>
  </div>
  
  <div class="accordion-item">
    <h2 class="accordion-header" id="headingThree">
      <span class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="true" aria-controls="collapseOne">
        Secure Your Account
      </span>
    </h2>
   <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
      <div class="accordion-body">
        <a title="Two-step authentication" class="text-link pointer summary_accounts" data-tid="d4"><i class="<?=$data['fwicon']['circle-dot'];?>"></i> Two-step authentication</a> <br />
		<a href="<?=$data['USER_FOLDER']?>/password<?=$data['ex']?>?HideAllMenu=1" title="Update Password" class="text-link modal_for_iframe"><i class="<?=$data['fwicon']['circle-dot'];?>"></i> Update Password</a> <br />
      </div>
    </div>
  </div>
  
  <div class="accordion-item">
    <h2 class="accordion-header" id="headingFour">
      <span class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="true" aria-controls="collapseOne">
        Review and finish
      </span>
    </h2>
    <div id="collapseFour" class="accordion-collapse collapse <?=$summ;?>" aria-labelledby="headingFour" data-bs-parent="#accordionExample">
      <div class="accordion-body">
        <a title="Review and finish" class="text-link pointer summary_accounts" data-tid="d5"><i class="<?=$data['fwicon']['circle-dot'];?>"></i> Summary</a> <br />
      </div>
    </div>
  </div>
  
    </div>
     </div>
    <div class="col-sm-9">
	<div class="border99 mx-3 rounded">

     <!--For Owner Details-->
	 <div class=" row vkg hide_all_div show_d1">
		<?/*?>
		<div class="row py-1 rounded">
			<div class="mb-2 fs-5 hide-title">Add your business Proprietor</div>
			
			<div class="col-sm-12 px-2 clearfix" style="max-width:450px !important;">
			<span>Due to regulatory guidelines, we're required to collect information on anyone who has significant ownership of your business.</span>
				<label for="blacklist_value" class="col-sm-12 col-form-label">Name: </label>
				<div class="col-sm-12">
					<input type="text" id="fullname" name="fullname" class="form-control form-control-sm" placeholder="Owner Name" value="<?=prntext(@$post['fullname'])?>" required="">
				</div>
				
				<label for="remarks" class="col-sm-12 col-form-label">Designation:</label>
				<div class="col-sm-12">
					<input type="text" id="designation" name="designation" class="form-control form-control-sm" placeholder="Designation" value="<?=prntext(@$post['designation'])?>" required="">
				</div>
				
				<label for="remarks" class="col-sm-12 col-form-label">Contact:</label>
				<div class="col-sm-12">
					<input type="text" id="phone" name="phone" class="form-control form-control-sm" placeholder="Contact" value="<?=prntext($post['phone'])?>" required="">
				</div>
				
				<a class="btn btn-primary btn-sm my-2 w-100">Continue</a>
			</div>

			
	
		</div>
		<?*/?>
	</div>
	<?
	    if(isset($post['fullname'])&&$post['fullname']){
			$fullname = $post['fullname'];
	    }
	?>
	 <!--For Business Details-->
	 
	<? if((isset($_SESSION['action_success'])&& $_SESSION['action_success'])||(isset($data['Error'])&& $data['Error'])){ ?>
   <? if((isset($data['Error'])&& $data['Error'])){ ?>
    <div class="alert alert-danger alert-dismissible fade show mb-2" role="alert"> <strong>Error!</strong>
      <?=prntext($data['Error'])?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <? }else { ?>
    <div class="alert alert-success alert-dismissible fade show mb-2" role="alert">
      <?=@$_SESSION['action_success']?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
	
		 <? unset($_SESSION['action_success']);?>
    <? } ?>
	<? } ?>
	
	 <div class="row vkg hide_all_div show_d2">
		<div class="row py-1 rounded was-validated">
			<?
				if($post['edit_permission']=="1"){ ?>
					<i class="<?=@$data['fwicon']['tick-circle'];?> text-success fa-w-16 fa-3x my-2" data-bs-toggle="tooltip" data-bs-placement="left" title="Business details has been approved. Can't editable. " ></i>
		
				<? }?>
			<div class="mb-2 fs-5 hide-title">Tell us more about your business</div>
			
			<div class="col-sm-12 px-2 clearfix" style="max-width:450px !important;">
			<span>Fill details to help us in understanding your business better and meet the requirements of regulators, financial partners and our Services Agreement.</span>
			

				
				<div class="col-sm-12">
				   <div class="input-field mt-4">
					<input <?=$ep;?> type="text" id="fullname" name="fullname" class="form-control form-control-sm"  value="<?=prntext($post['fullname'])?>" required="" data-bs-toggle="tooltip" data-bs-placement="right" title="Enter Full name">
					<label for="fullname">Full Name <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></label>
				   </div>
				</div>
				
				<div class="col-sm-12">
				   <div class="input-field mt-4">
					<input <?=$ep;?> type="text" id="company_name" name="company_name" class="form-control form-control-sm"  value="<? if(isset($post['company_name'])) echo prntext($post['company_name'])?>" required="" data-bs-toggle="tooltip" data-bs-placement="right" title="Enter Company name">
			<label for="company_name">Company Name <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></label>
				 </div>
				</div>
				
				
				<div class="col-sm-12">
				   <div class="input-field mt-4">
					<input <?=$ep;?> type="text" id="registered_address" name="registered_address" class="form-control form-control-sm" value="<?=@$post['registered_address']?>" required="" data-bs-toggle="tooltip" data-bs-placement="right" title="Enter Registered address">
		<label for="registered_address" >Registered Address <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></label>
				 </div>
				</div>
				
				
			<?/*?>	

				<div class="col-sm-12">
				   <div class="input-field mt-4">
					<input <?=$ep;?> type="text" id="designation" name="designation" class="form-control form-control-sm"  value="<?=prntext($post['designation'])?>" required="" data-bs-toggle="tooltip" data-bs-placement="right" title="Enter designation">
					<label for="designation">Designation <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></label>
				 </div>
				</div>
				
				

				<div class="col-sm-12">
				   <div class="input-field mt-4">
					<input <?=$ep;?> type="text" id="phone" name="phone" class="form-control form-control-sm"  value="<?=prntext($post['phone'])?>" required="" data-bs-toggle="tooltip" data-bs-placement="right" title="Enter contact number">
				<label for="phone">Contact Number <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></label>
				 </div>
				</div>
				
				

				
				

				<div class="col-sm-12">
				   <div class="input-field mt-4">
					<input <?=$ep;?> type="text" id="business_contact" name="business_contact" class="form-control form-control-sm"  value="<?=(isset($post['business_contact'])?$post['business_contact']:'');?>" required="" data-bs-toggle="tooltip" data-bs-placement="right" title="Enter business contact">
			<label for="business_contact" >Business Contact <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></label>
				 </div>
				</div>
				
			<?*/?>	
				<?
				if($post['edit_permission']=="1"){ ?>
					
		
				<? } else {?>
					<a class="btn btn-primary btn-sm mt-4 w-100 submit_business_desc<?=@$bn;?>"><span class="loader-icon">Continue</span></a>
				
				<? } ?>
			</div>

			
	
		</div> 
	</div>
	
	 <!--For Spoc Information-->
	 <div class="row vkg hide_all_div show_d3">
		<div class="row py-1 rounded was-validated">
			<div class="mb-2 fs-5 hide-title">Add your spoc information</div>
			
			<div class="col-sm-12 px-2 clearfix" style="max-width:450px !important;">
			<span>Fill details to help us in understanding your business better and meet the requirements of regulators, financial partners and our Services Agreement.</span>
				
				<div class="col-sm-12">
				<div class="input-field mt-4">
					<input type="text" id="spoc_fname" name="fullname" class="form-control form-control-sm"  value="" required data-bs-toggle="tooltip" data-bs-placement="right" title="Enter spoc name">
					
					<label for="spoc_fname">Spoc Name: <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></label>
				</div>
				</div>
				
				
				<div class="col-sm-12">
				<div class="input-field mt-4">
					<input type="text" id="spoc_designation" name="designation" class="form-control form-control-sm"  value="" required="" data-bs-toggle="tooltip" data-bs-placement="right" title="Enter spoc designation">
					<label for="spoc_designation">Spoc Designation: <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></label>
				</div></div>
				
				
				<div class="col-sm-12">
				<div class="input-field mt-4">
					<input type="text" id="spoc_phone" name="phone" class="form-control form-control-sm" value="" required="" data-bs-toggle="tooltip" data-bs-placement="right" title="Enter spoc contact number">
					<label for="spoc_phone">Spoc Contact: <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></label>
				</div></div>
				
				
				<div class="col-sm-12">
					<div class="input row">
		  <div class="col-sm-4 pe-0">
		  <div class="input-field select mt-4">
			            <select name="ims_type" id="ims_type" class="form-select" autocomplete="off" data-bs-toggle="tooltip" data-bs-placement="right" title="Select IM'S type" required>
						<option value="">&nbsp;</option>
						<option value="Skype">Skype</option>
						<option value="Telegram">Telegram</option>
						<option value="WhatsApp">WhatsApp</option>
						</select>
						<label for="ims_type">IM'S Type : <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></label>
			</div></div>
			
			<div class="col-sm-8">
			<div class="input-field mt-4">
			<input type="text" id="spoc_email" name="email" value=""  class="form-control" data-bs-toggle="tooltip" data-bs-placement="right" title="Enter IM'S id" required />
			<label for="spoc_email">IM'S id : <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></label>
          </div>
		  </div>
		  
		  </div>
				</div>
				
				<a class="btn btn-primary btn-sm mt-4 w-100 submit_spoc"><span class="loader-icon">Continue</span></a>
			</div>

			
	
		</div> 
	</div>
	
	 <!--For Two-step authentication-->
     <div class="row vkg hide_all_div show_d4">
		<div class="row py-1 rounded">
			<div class="mb-2 fs-5 hide-title">Keep your account secure</div>
			
			<div class="col-sm-12 px-2 clearfix" style="max-width:450px !important;">
			<span>Requires two-step authentication in order to keep your account secure. By using either your phone or an authenticator app in addition to your password, you ensure that no one else can log in to your account.</span>
			
     <div class="border rounded bg-white p-2 my-2 dropdown " style="max-width:450px;">
	 <a href="<?=$data['USER_FOLDER']?>/two-factor-authentication<?=$data['ex']?>?HideAllMenu=1" title="Two-step authentication" class="text-link modal_for_iframe" style="margin-top:50px; margin-bottom:50px;">
     <div class="vkg dropdown-toggle55" ><span class="loader-icon"><i class="<?=$qicon;?>"></i></span>&nbsp;Authenticator app - <?=$qstatus;?> </div>
	 </a>
	 </div>

	
	</div>
	
	</div>
	
	
	</div>
	
	 <!--For Review and finish up authentication-->
     <div class="hide_all_div show_d5">
		<div class="row py-1 rounded">
			<div class="mb-2 fs-5 hide-title">Review and Update</div>
			
			<div class="col-sm-12 px-2 clearfix" style="max-width:450px !important;">
			<span>You're almost ready to start exploring. Take a moment to review and confirm your information.</span>
	 
	 

	 
	 <div class="my-2 fs-6 fw-bold hide-title">Business Details</div>	
     <div class="border rounded  p-2 my-2" style="max-width:450px;">
     <div class="vkg dropdown-toggle55" ><?=$mb_desc_status;?></div>
	 </div>
	 
	 <div class="my-2 fs-6 fw-bold hide-title">Spoc Info</div>	
     <div class="border rounded  p-2 my-2" style="max-width:450px;">
     <div class="vkg dropdown-toggle55" ><?=$mb_spoc;?></div>
	 </div>
	 
	 <div class="my-2 fs-6 fw-bold hide-title">Bank Account</div>	
     <div class="border rounded  p-2 my-2" style="max-width:450px;">
     <div class="vkg dropdown-toggle55" ><?=$mb_bank_status;?></div>
	 </div>
	 
	 <div class="my-2 fs-6 fw-bold hide-title">Two-step authentication</div>	
     <div class="border rounded  p-2 my-2" style="max-width:450px;">
     <div class="vkg dropdown-toggle55" ><?=$mb_2fa;?></div>
	 </div>

	
	</div>
	
	</div>
	
	
	</div>

			
	
		</div> 
	</div>
	
  </div>
</div>


<script>

$('.hide_all_div').hide();
$('<?=$showhide;?>').show();


$('.summary_accounts').on('click', function () {
var data_tid = $(this).attr('data-tid');

var divid ='show_'+ data_tid;
var theValues = '.'+ divid;
//alert(theValues);
$('.hide_all_div').hide();
$(theValues).show();

});




// For update business description
$('.submit_business_desc').on('click', function () {

	var fullname=$('#fullname').val();
	var company_name=$('#company_name').val();
	var registered_address=$('#registered_address').val();
	
	if(fullname==''){
		alert('Please enter fullname');
		$('#fullname').focus();
		return false;
	}else if(company_name==''){
		alert('Please enter company name');
		$('#company_name').focus();
		return false;
	}else if(registered_address==''){
		alert('Please enter registered address');
		$('#registered_address').focus();
		return false;
	}
	else 
	{
		$(".loader-icon").html("<i class='<?=$data['fwicon']['spinner'];?> fa-spin-pulse'></i>");	

		$.ajax({
		url: "<?=$data['Host'];?>/include/business-details-update<?=$data['ex']?>",
		data:'fullname='+fullname+'&company_name='+company_name+'&registered_address='+registered_address,
		type: "POST",
		success:function(data){
			//alert(data);
			  if(data=="done"){
			  $(".loader-icon").html('<i class="<?=$data['fwicon']['check-circle'];?> text-white"></i> Business details Updated..');
			  
				 setTimeout(function(){ 
				 //alert("redirect");
				 location.reload(true);
				 },1500); 
			  }
		},
		error:function (){}
		});
	}
});


// For add Spoc Info
$('.submit_spoc').on('click', function () {




    var spoc_fname=$('#spoc_fname').val();
	var spoc_designation=$('#spoc_designation').val();
	var spoc_phone=$('#spoc_phone').val();
	var ims_type=$('#ims_type').val();
	var spoc_email=$('#spoc_email').val();

        if(spoc_fname==''){
			alert('Please enter name');
			$('#spoc_fname').focus();
			return false;
		}else if(spoc_designation==''){
		    alert('Please enter designation');
			$('#spoc_designation').focus();
			return false;
		}else if(spoc_phone==''){
		    alert('Please enter contact no');
			$('#spoc_phone').focus();
			return false;
		}else if(ims_type==''){
		    alert('Please select ims type');
			$('#ims_type').focus();
			return false;
		}else if(spoc_email==''){
		    alert('Please enter ims');
			$('#spoc_email').focus();
			return false;
		}
		
    $(".loader-icon").html("<i class='<?=$data['fwicon']['spinner'];?> fa-spin-pulse'></i>");		

	$.ajax({
	url: "<?=$data['Host'];?>/include/business-details-update<?=$data['ex']?>",
	data:'ims_type='+ims_type+'&fullname='+spoc_fname+'&designation='+spoc_designation+'&phone='+spoc_phone+'&email='+spoc_email,
	type: "POST",
	success:function(data){
	//alert(data);
	  if(data=="done"){
	  $(".loader-icon").html('<i class="<?=$data['fwicon']['check-circle'];?> text-white"></i> Spoc Information Added..');
	     setTimeout(function(){ 
	     //alert("redirect");
		 location.reload(true);
	     },1500);
	  }
	},
	error:function (){}
	});
	
});


</script>

<? if($buss_details==""){ ?>

<script> 
$('.menu-summary').click(function () {return false;}); 
$('.menu-summary').css("background-color", "#6c757d"); 

$('.menu-summary').on('click', function () {
alert("Menu not activated. Please complete your business details");
//Menu will actived after complete your business details
});
</script>

<? } ?>


<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
