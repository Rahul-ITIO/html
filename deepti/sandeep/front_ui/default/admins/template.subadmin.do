<? if(isset($data['ScriptLoaded'])){?>

<div class="container rounded border my-1 vkg">
  <h4 class="my-2">
    <? if($post['action']=='insert'){ ?><i class="<?=$data['fwicon']['add-sub-admin'];?>"></i> Add New Sub Admin 
    <? }else{ ?><i class="<?=$data['fwicon']['edit'];?>"></i> Edit <?=@$_SESSION['sub_admin_rolesname']?> Subadmin Info
    <? }?>
  </h4>
 <? if((isset($data['Error'])&& $data['Error'])){ ?>
  <div class="container mt-3">
    <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error!</strong>
      <?=prntext($data['Error'])?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
  </div>
  <? } ?>
  <?

if($post['action']=='insert'||$post['action']=='update'){
if((!isset($_SESSION['login_adm']))&&(!$_SESSION['update_sub_admin_other_profile'])&&($_SESSION['sub_admin_id']!=$_GET['id'])&&($_GET['id'])){
	  //echo $data['OppsAdmin'];
?>
<div class="alert alert-danger" role="alert"><?=$data['OppsAdmin'];?></div>
<?
	  exit;	
	}
?>
  <script>
 /* // js for check user availibility*/
function checkAvailability() {
	$("#loaderIcon").show();
	$.ajax({
	url: "<?=$data['Host'];?>/include/check_availability<?=$data['ex']?>",
	data:'tbl=subadmin&username='+$("#username").val(),
	type: "POST",
	success:function(data){
		$("#user-availability-status").html(data);
		$("#loaderIcon").hide();
	},
	error:function (){}
	});
}

 /* // js for upload logo*/
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

 /* // js for Domain Name check*/
$(document).ready(function(){
	
	$('#domain_name').focusout(function(){
		var thisVal=$(this).val();
		
		
		if($.trim($('#domain_name').val()) == "") {
			alert('Domain Name can not empty!');
			return false;
		}else{
			
			var url_name="<?=$data['Admins']?>/subadmin<?=$data['ex'];?>?action=domain_name&domain_name="+thisVal;
			//alert(url_name+"\r\n"+thisVal);
			//window.open(url_name,'_blank');return false;
			$.ajax({
				url: url_name,
				type: 'POST',
				dataType: 'json', 
				data:{action:"domain_name", domain_name:thisVal, json:"1"},
				success: function(data){
				
					//alert(JSON.stringify(data));
					
					if(data["msg"]){
						$("#user-availability-status").html('<div class="btn btn-success" >'+data["msg"]+'</div>');
						$('#submit_button').slideDown(200);
						alert("Wow: "+data['msg']);
					}else{
						$("#user-availability-status").html('<div class="btn btn-danger" >'+data["Error"]+'</div>');
						$('#submit_button').slideUp(200);
						alert("Opps: "+data['Error']);
						
					}
					
				}
			});
		
		}	
	});
});	
</script>
<style>
#user-availability-status{width:100%;text-align:center;color:red;font-size:14px; margin-top:10px;}
.appbrand5.dlogo{overflow:hidden;width:185px;height:75px;}
.appbrand5.icoIcon{overflow:hidden;height:64px;}
.appbrand5 img.logoimg{margin-left:0;margin-bottom:10px;border-radius:3px;width:100%;padding:0;height:auto;max-height:75px}
.closeImg{position:relative;right:10px;;display:inline-block;vertical-align:middle;}
.tbl_exl {width: 80vw !important;}
</style>
 <div class="row">
  <div><?=(isset($post['json_log_history'])?json_log_view1($post['json_log_history'],'View Json Log','0','json_log','','100'):'');?></div>
  </div>
  <form method="post" enctype="multipart/form-data">
    <input type="hidden" name="action" value="<? if(isset($post['action'])) echo $post['action']?>">
    <input type="hidden" name="sid" value="<? if(isset($_GET['id'])) echo $_GET['id']?>">
    <div class="frame container ps-0" id="subadmin_nodify_for_css">
	
    <div id="user-availability-status"></div>
    <p align="center"><img src="<?php echo $data['Host'];?>/images/loader.gif" id="loaderIcon" style="display:none" /></p>
    <div class="row" id="subadmin_css22">
	
	<div class="row m-1 mb-2 bg-primary rounded ps-0">
      <? if((isset($_SESSION['login_adm'])&&$_SESSION['login_adm'])||(isset($_SESSION['gateway_assign_in_subadmin'])&&$_SESSION['gateway_assign_in_subadmin'])){ ?>
	<?  if(isset($post['multiple_subadmin_ids'])&&is_array($post['multiple_subadmin_ids'])) $post['multiple_subadmin_ids'] = implode(',',$post['multiple_subadmin_ids']); ?>
	  
      <div class="col-sm-12 row my-2 p-0">
	  <div class="col-sm-4 pe-0">
      <div><span class="input-group-text" style="height:50px;">Gateway Partners <? if(isset($post['multiple_subadmin_ids'])) echo $post['multiple_subadmin_ids']?></span></div>
		</div>
		<div class="col-sm-8 pe-0">  
          <select id="multiple_subadmin_ids" data-placeholder="Type gateway initials to select Gateway partner" multiple class="chosen-select form-select" name="multiple_subadmin_ids[]" >
            <?=showselect($data['Sponsors'], @$post['multiple_subadmin_ids'],1)?>

          </select>
		  </div>
        </div>
      
	  
      <? }?>
      <? if((isset($_SESSION['login_adm'])&&$_SESSION['login_adm'])||(isset($_SESSION['merchant_assign_in_subadmin'])&&$_SESSION['merchant_assign_in_subadmin'])){ ?>
	  <?  if(isset($post['multiple_merchant_ids'])&&is_array($post['multiple_merchant_ids'])) $post['multiple_merchant_ids'] = implode(',',$post['multiple_merchant_ids']); ?>
	  <div class="col-sm-12 row my-2 p-0">
      <div class="col-sm-4 pe-0">
      <div><span class="input-group-text" style="height:50px;">Merchant <? if(isset($post['multiple_merchant_ids'])) echo $post['multiple_merchant_ids']?></span></div>
	  </div>    
	  <div class="col-sm-8 pe-0">
	  <select id="multiple_merchant_ids" data-placeholder="Type merchant initials to select Merchant" multiple class="chosen-select form-select" name="multiple_merchant_ids[]" >
            <?=showselect($data['clientsList'], @$post['multiple_merchant_ids'],1)?>
          </select>
      </div>
      </div>
      <? }?>
	   <script>
						$(".chosen-select").chosen({
						  no_results_text: "Oops, nothing found!"
						});
					</script>
					
	 
<script>
$("#multiple_subadmin_ids_chosen").css("width", "100%");
$("#multiple_subadmin_ids_chosen").addClass("form-control");
$("#multiple_merchant_ids_chosen").css("width", "100%");
$("#multiple_merchant_ids_chosen").addClass("form-control");
</script>
	  </div>
     
      <div class="col-sm-6">
        <span class="form-label " id="basic-addon4" >Username: <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></span>
          <input type="text" class="form-control" name="username" id="username" value="<? if(isset($post['username'])) echo $post['username']?>" onBlur="checkAvailability()"  title="Username" placeholder="Username" required>
        </div>
      
      <div class="col-sm-6">
        <span class="form-label " id="basic-addon4" >
          <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['change_password'])&&$_SESSION['change_password']==1)){ ?>
          Password: <i class="<?=$data['fwicon']['star'];?>  text-danger"></i>
          <? }?>
          </span>
          <?php if ((isset($_GET['action'])&& $_GET['action']=="insert")){ ?>
          <input type="password" name="password"  class="form-control" title="Password" placeholder="Password" required>
          <? } else { ?>
          <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['change_password'])&&$_SESSION['change_password']==1)){ ?>
		  <br />

          <a href="<?=$data['Admins'];?>/password<?=$data['ex']?>?id=<?=$_GET['id']?>" class="btn btn-outline-secondary btn-sm" title="Change Password"><i class="<?=$data['fwicon']['unlock'];?>" title="Change"></i> </a>
          <? }?>
          <? } ?>
        </div>
     
      <div class="col-sm-6">
       <span class="form-label " id="basic-addon4" >Email: <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></span>
          <input type="text" name="email" value="<?=(isset($post['email'])?encrypts_decrypts_emails($post['email'],2):'');?>" class="form-control" title="Email address" placeholder="Email address" required>
        </div>
      
      <div class="col-sm-6">
        <span class="form-label " id="basic-addon4" >Full Name: <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></span>
          <input type="text" name="fullname" class="form-control" value="<? if(isset($post['fullname'])) echo $post['fullname']; elseif(isset($post['fname'])) echo $post['fname'];?>" title="Full Name" placeholder="Full Name" required>
        </div>
      
      <div class="col-sm-6 d-none">
        <span class="form-label " id="basic-addon4" >Last Name:</span>
          <input type="text" name="lname" class="form-control"  value="<? if(isset($post['lname'])) echo $post['lname']?>" title="Last Name" placeholder="Last Name" >
        </div>
     
      <? if(!isset($_SESSION['sub_admin_rolesname'])||$_SESSION['sub_admin_rolesname']!="Associate"){ ?> 
      <div class="col-sm-6">
        <span class="form-label " id="basic-addon4" >Role: <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></span>
          <select name="roles" id="roles" data-rel="chosen"  class="form-select" title="Roles" required>
            <? foreach($data['roles'] as $key=>$value){?>
                    	<option value="<?=$value['id']?>"<? if(isset($post['access_id'])&&$value['id']==$post['access_id']){?>  selected="selected" <? }?>><?=$value['rolesname']?></option>
                   <? }?>
          </select>
		  <?php if(isset($post['roles'])&&$post['roles']<>""){ ?>
          <script>$('#roles option[value="<?=prntext($post['roles'])?>"]').prop('selected','selected');</script>
		  <? }?>
        </div>
      
      <? }?>
      <div class="col-sm-6 d-none">
        <span class="form-label " id="basic-addon4" >Address:</span>
          <input type="text" name="address" class="form-control"  value="<? if(isset($post['address'])) echo $post['address']?>" placeholder="Address">
        </div>
      
      <div class="col-sm-6 d-none">
         <span class="form-label " id="basic-addon4" >City:</span>
          <input type="text" name="city" class="form-control"  value="<? if(isset($post['city'])) echo $post['city']?>" placeholder="City">
        </div>
     
      <div class="col-sm-6 d-none">
        <span class="form-label " id="basic-addon4" >Country:</span>
          <select name="country" class="form-select">
            <option selected="selected">Select Country</option>
            <option>
			<?=showselect($data['Countries'], (isset($post['country'])?$post['country']:''))?></option>
            </option>
          </select>
      </div>
      <div class="col-sm-6 d-none">
        <span class="form-label " id="basic-addon4" >State:</span>
          <input type="text" name="state"  class="form-control" value="<? if(isset($post['state'])) echo $post['state']?>" placeholder="State">
        </div>
     
      <div class="col-sm-6 d-none">
        <span class="form-label " id="basic-addon4" >Postal Code:</span>
          <input type="text" class="form-control" name="zip" value="<? if(isset($post['zip'])) echo $post['zip']?>" placeholder="Postal Code">
        </div>
     
      <div class="col-sm-6 d-none">
        <span class="form-label " id="basic-addon4" >Phone :</span>
          <input type="text" class="form-control" name="phone"  value="<? if(isset($post['phone'])) echo $post['phone']?>" placeholder="Phone">
        </div>
     
	  
	  <div class="col-sm-6">
    <span class="form-label " id="basic-addon4" >Front UI:</span>
      <select name="front_ui" id="front_ui" title="Select Front UI" class="form-select" onChange="change_template(this.value)" >
	    <option value="" required>Select Front UI</option>
        <?
							$uiList = glob('../front_ui/*');
							foreach($uiList as $uiName){
								$uiName=str_replace('../front_ui/','',$uiName);
								if(!in_array($uiName,[1=>"index.html"])){
								    $uiName1=ucfirst($uiName);
									echo "<option value='{$uiName}'>{$uiName1}</option>"; 
								}
							}
							?>
      </select>
	  <?php if(isset($post['front_ui'])&&$post['front_ui']<>""){ ?>
      <script>$('#front_ui option[value="<?=prntext($post['front_ui'])?>"]').prop('selected','selected');</script>
	  <? } ?>			
					
					</div>
	  

      <div class="col-sm-6 d-none">
        <span class="form-label " id="basic-addon4" >Bussiness URL:</span>
          <input type="text" class="form-control" name="bussiness_url" value="<? if(isset($post['bussiness_url'])) echo $post['bussiness_url']?>" placeholder="Bussiness URL">
        </div>
	   <div class="col-sm-6 d-none">
    <span class="form-label " id="basic-addon4" >Contact US URL:</span>
      <input type="text" class="form-control" name="associate_contact_us_url"  value="<? if(isset($post['associate_contact_us_url'])) echo $post['associate_contact_us_url']?>" placeholder="Contact US URL">
	   </div>
	  
	  
	  <? if(isset($_SESSION['login_adm'])){ ?>
	  
	  <div class="col-sm-6">
    <span class="form-label " id="basic-addon4" >Color Theme:</span>
<?php /*?>data-rel="chosen" onChange="change_color(this.value)"<?php */?>

<select name="upload_css" id="upload_css" class="form-select select_color" >

<option value="default"  id="default"  tbg-color="#FFFFFF" txt-color="#000000">Default</option>
<option value="mobikwik" id="mobikwik" tbg-color="#002447" txt-color="#FFFFFF" style="background:#002447;color:#FFFFFF;">Mobikwik</option>
<option value="stripe"   id="stripe"   tbg-color="#635BFF" txt-color="#FFFFFF"  style="background:#635BFF;color:#FFFFFF;">Stripe</option>
<option value="paytm"    id="paytm"    tbg-color="#00b9f5" txt-color="#FFFFFF"  style="background:#00b9f5;color:#FFFFFF;">Paytm</option>
<option value="cashfree" id="cashfree" tbg-color="#3b8894" txt-color="#FFFFFF"  style="background:#3b8894;color:#FFFFFF;">Cashfree</option>
<option value="razorpay" id="razorpay" tbg-color="#005bf2" txt-color="#FFFFFF"  style="background:#005bf2;color:#FFFFFF;">Razorpay</option>
<option value="phonepay" id="phonepay" tbg-color="#5F249F" txt-color="#FFFFFF"  style="background:#5F249F;color:#FFFFFF;">Phone Pay</option>
<?php /*?>
<option value="blue">Blue</option>
<option value="lightblue">Light Blue</option>
<option value="green">Green</option>
<option value="darkgreen">Dark Green</option>
<option value="orange">Orange</option>
<option value="magenta">Magenta</option>
<option value="yellow">Yellow</option>
<option value="darknavyblue">Dark Navy Blue</option>
<option value="pmc">Purple Multi Color</option>
<option value="vmc">Violet Multi Color</option>
<option value="quartz">Quartz</option>
<option value="opal">Opal</option>
<option value="OPAL_IND">OPAL_IND</option>
<?php */?>
</select>
	   <?php if(isset($post['upload_css'])&&$post['upload_css']<>""){ ?>
      <script>$('#upload_css option[value="<?=prntext($post['upload_css'])?>"]').prop('selected','selected');</script>
		<? } ?>			
					
					</div>
	  
	  <div class="col-sm-6">
    <span class="form-label " id="basic-addon4" >UI Panel:</span>
      <select name="front_ui_panel" id="front_ui_panel" class="form-select"   >
        <option value="Top_Panel">Top Panel</option>
        <option value="Left_Panel" selected="selected">Left Panel</option>
      </select>
	   <?php if(isset($post['front_ui_panel'])&&$post['front_ui_panel']<>""){ ?>
 <script> $('#front_ui_panel option[value="<?=prntext($post['front_ui_panel'])?>"]').prop('selected','selected'); </script>
       <? } ?>
		</div>
	  
      <? }?>
	  
 <? if($post['action']=="insert"){ ?>
      <div class="col-sm-6">
    <span class="form-label " id="basic-addon4" title="2 Way Auth. Access:" >2 Way Auth.:</span>
      <select name="google_auth_access" id="google_auth_access" class="form-select" data-rel="chosen" >
        <option value="">- 2 Way Auth. Yes/No -</option>
        <option value="2">De-activate</option>
        <option value="1">Activate</option>
        <option value="3">Bar-Code Reset</option>
      </select>
	  
<?php if(isset($post['google_auth_access'])&&$post['google_auth_access']<>""){?>
<script>$('#google_auth_access option[value="<?=prntext($post['google_auth_access'])?>"]').prop('selected','selected');</script> 
<? }?>
				</div>
      <? }?>
	  
<div class="text-end">

<a class="btn btn-primary btn-sm mx-1 my-2" data-bs-toggle="collapse" href="#collapseColor" role="button" aria-expanded="false" aria-controls="collapseColor"  ><i class="<?=$data['fwicon']['paint-roller'];?>" title="Advance Color" data-bs-toggle="tooltip" data-bs-placement="top"></i></a>

<a class="btn btn-primary btn-sm mx-1 my-2" data-bs-toggle="collapse" href="#collapseImage" role="button" aria-expanded="false" aria-controls="collapseImage"  title="Logo & Favicon" ><i class="<?=$data['fwicon']['image'];?>" title="Logo & Favicon" data-bs-toggle="tooltip" data-bs-placement="top"></i></a>

<a class="btn btn-primary btn-sm mx-1 my-2" data-bs-toggle="collapse" href="#collapseAdvance" role="button" aria-expanded="false" aria-controls="collapseAdvance"  title="Advance Setting" ><i class="<?=$data['fwicon']['setting'];?>" title="Advance Setting" data-bs-toggle="tooltip" data-bs-placement="top"></i></a>

</div>

<div class="collapse rounded border clearfix p-2 my-2" id="collapseColor">
<div class="col-sm-12 row p-0">	 

<?php 

$bgclr=(isset($bgclr)&&$bgclr)?$bgclr:'';

if(isset($post['header_bg_color'])&&strstr($post['header_bg_color'], "linear-gradient")) { 
$bgclr="background:".$post['header_bg_color'];
} elseif(isset($post['header_bg_color'])&& !strstr($post['header_bg_color'], "linear-gradient")) {
$bgclr="background-color:".$post['header_bg_color'];
 }
if($bgclr=="background-color:"){ $bgclr="background-color:".$data['subdomain_root_background_color']; }
if(isset($post['header_bg_color'])&&$post['header_bg_color']==""){ 
	$post['header_bg_color']=$data['subdomain_root_background_color'];
	$post['header_text_color']=$data['subdomain_root_text_color']."fff";
 }
 ?>
<h6>Header Design : </h6>
<div class="col-sm-6">
    <div class="input-group mb-3"> <span class="input-group-text col-sm-3" id="basic-addon4" style="padding:0px !important;" >
	<select name="header_color_type" id="header_color_type" class="form-select" >
        <option value="">Color Type</option>
		<option value="1">Pick Color</option>
        <option value="2">Color Range</option>

      </select></span><span class="input-group-text col-sm-2 text-center" id="hbc" ><? if(isset($post['header_bg_color'])) echo $post['header_bg_color']?></span>
<input type="text" name="header_bg_color" id="header_bg_color" title="Header Color" class="form-control" style="color:<? if(isset($post['header_text_color'])) echo $post['header_text_color']?>;<?=$bgclr;?>; height:auto;"  value="<? if(isset($post['header_bg_color'])) echo $post['header_bg_color']?>"  />

				
				</div>
      </div>
	  
	  
	  
	  <script type="text/javascript">
	  <!--header_color_type-->
	  
	   $('#header_color_type').on('change', function() {
	   var sss = $('#header_color_type').val();
	   if ( $('#header_color_type').val() == '1' ) {  $('#header_bg_color').attr('type', 'color'); } ;
	   if ( $('#header_color_type').val() == '2' ) {  $('#header_bg_color').attr('type', 'text');} ;
	   

    
	});
	
	  </script>
	  
<div class="col-sm-4">
    <div class="input-group mb-3"> <span class="input-group-text col-sm-4 col-sm-5" id="basic-addon4" >
	Text Color : <v id="htc"><? if(isset($post['header_text_color'])) echo $post['header_text_color']?></v></span>
     <input type="color" name="header_text_color" id="header_text_color" title="Header Text Color" class="form-control form-control-color" style="height: auto;" value="<? if(isset($post['header_text_color'])) echo $post['header_text_color']?>"  />
		
				</div>
      </div>
	 
<div class="col-sm-2">
<!--<button name="dfd" onclick="javascript:default_header();">Reset Default Value</button>-->
<input type="button" class="btn btn-primary btn-sm" value="Reset Default Header" name="defaultheader" onclick="javascript:reset_default_color(1);" />
</div>

<script type="text/javascript">
 /* // js for blank filled color set default*/
function reset_default_color(act){

if(act==1){
alert("Empty Value of Header");
document.getElementById("header_bg_color").value="";
document.getElementById("header_text_color").value="";
document.getElementById("header_bg_color").style="";
}

if(act==2){
alert("Empty Value of Body");
document.getElementById("body_bg_color").value="";
document.getElementById("body_text_color").value="";
document.getElementById("body_bg_color").style="";
}

if(act==3){
alert("Empty Value of Heading");
document.getElementById("heading_bg_color").value="";
document.getElementById("heading_text_color").value="";
document.getElementById("heading_bg_color").style="";
}
//alert("done");
}
</script>
</div>

<div class="col-sm-12 row p-0">	 

<?php 


if(isset($post['body_bg_color'])&&strstr($post['body_bg_color'], "linear-gradient")) { 
$bgclr="background:".$post['body_bg_color'];
} elseif(isset($post['body_bg_color'])&& !strstr($post['body_bg_color'], "linear-gradient")) {
$bgclr="background-color:".$post['body_bg_color'];
 } ?>
<h6>Body Design :  </h6>
<div class="col-sm-6">
    <div class="input-group mb-3"> <span class="input-group-text col-sm-3" id="basic-addon4" style="padding:0px !important;" >
	<select name="body_color_type" id="body_color_type" class="form-select" >
        <option value="">Color Type</option>
		<option value="1">Pick Color</option>
        <option value="2">Color Range</option>

      </select></span><span class="input-group-text col-sm-2 text-center" id="bbc" ><? if(isset($post['body_bg_color'])) echo $post['body_bg_color']?></span>
<input type="text" name="body_bg_color" id="body_bg_color" title="Body Color" class="form-control" 
style="color:<? if(isset($post['body_text_color'])) echo $post['body_text_color']?>;<?=$bgclr;?>; height:auto;"  value="<? if(isset($post['body_bg_color'])) echo $post['body_bg_color']?>"  />

				
				</div>
      </div>
	  
	  
	  
	  <script type="text/javascript">
	  <!--body_color_type-->
	  
	   $('#body_color_type').on('change', function() {
	   var sss = $('#body_color_type').val();
	   if ( $('#body_color_type').val() == '1' ) {  $('#body_bg_color').attr('type', 'color'); } ;
	   if ( $('#body_color_type').val() == '2' ) {  $('#body_bg_color').attr('type', 'text');} ;
	   

    
	});
	
	  </script>
	  
<div class="col-sm-4">
    <div class="input-group mb-3"> <span class="input-group-text col-sm-4 col-sm-5" id="basic-addon4" >
	Text Color : <? if(isset($post['body_text_color'])) echo $post['body_text_color']?></span>
     <input type="color" name="body_text_color" id="body_text_color" title="Body Text Color" class="form-control form-control-color" style="height: auto;" value="<? if(isset($post['body_text_color'])) echo $post['body_text_color']?>" />
				
				</div>
      </div>
	  
<div class="col-sm-2">
<input type="button" class="btn btn-primary btn-sm" value="Reset Default Body" name="defaultbody" onclick="javascript:reset_default_color(2);" />
</div>

</div>

<div class="col-sm-12 row p-0">	 

<?php 


if(isset($post['heading_bg_color'])&&strstr($post['heading_bg_color'], "linear-gradient")) { 
$bgclr="background:".$post['heading_bg_color'];
} elseif(isset($post['heading_bg_color'])&& !strstr($post['heading_bg_color'], "linear-gradient")) {
$bgclr="background:".$post['heading_bg_color'];
 } ?>
<h6>Heading Design :  </h6>
<div class="col-sm-6">
    <div class="input-group mb-3"> <span class="input-group-text col-sm-3" id="basic-addon4" style="padding:0px !important;" >
	  <select name="heading_color_type" id="heading_color_type" class="form-select" >
        <option value="">Color Type</option>
		<option value="1">Pick Color</option>
        <option value="2">Color Range</option>
      </select></span><span class="input-group-text col-sm-2 text-center" title="<? if(isset($post['heading_bg_color'])) echo $post['heading_bg_color'];?>" ><? if(isset($post['heading_bg_color'])) echo substr($post['heading_bg_color'],0,10)?></span>
<input type="text" name="heading_bg_color" id="heading_bg_color" title="Heading Color" class="form-control" style="color:<? if(isset($post['heading_text_color'])) echo $post['heading_text_color']?>;<?=$bgclr;?>; height:auto;"  value="<? if(isset($post['heading_bg_color'])) echo $post['heading_bg_color']?>" />

				
				</div>
      </div>
	  
	  
	  
	  <script type="text/javascript">
	  <!--heading_color_type-->
	  
	   $('#heading_color_type').on('change', function() {
	   var sss = $('#heading_color_type').val();
	   if ( $('#heading_color_type').val() == '1' ) {  $('#heading_bg_color').attr('type', 'color'); } ;
	   if ( $('#heading_color_type').val() == '2' ) {  $('#heading_bg_color').attr('type', 'text');} ;
	   

    
	});
	
	  </script>
	  
<div class="col-sm-4">
    <div class="input-group mb-3"> <span class="input-group-text col-sm-4 col-sm-5" id="basic-addon4" >
	Text Color : <? if(isset($post['heading_text_color'])) echo $post['heading_text_color']?></span>
     <input type="color" name="heading_text_color" id="heading_text_color" title="Heading Text Color" class="form-control form-control-color" style="height: auto;" value="<? if(isset($post['heading_text_color'])) echo $post['heading_text_color']?>" />
				
				</div>
      </div>
	  
	  <div class="col-sm-2">
<input type="button" class="btn btn-primary btn-sm" value="Reset Default Heading" name="defaultheading" onclick="javascript:reset_default_color(3);" />
</div>

</div>
</div>


<div class="collapse rounded border clearfix p-2 my-2 row" id="collapseImage">

	 <? if(isset($_SESSION['login_adm'])){ ?> 
	  
	  <div class="col-sm-6 upload_logo">
     <span class="form-label" id="basic-addon4" >Upload Logo:(w:185px,h:75px)</span>
      <? if(isset($post['upload_logo'])&&$post['upload_logo']) { ?>
      <input type="file" class="file form-control my-2" name="updatelogo" id="updatelogo" style="height:34px;max-width:96px; " data-bs-toggle="tooltip" data-bs-placement="top" title="Select path to Upload Logo:(width:185px,height:75px)"/>
<textarea name="upload_logo" id="upload_logo" style="display:none !important"><?=(isset($post['upload_logo'])?$post['upload_logo']:'');?></textarea>
        <div  class="appbrand5 dlogo logoa 2" style="display:inline-block !important"><? $pro_img=display_docfile("../user_doc/",$post['upload_logo']);?>
        <a onclick="upload_logo_xf(this)" class="closeImg" style="margin-top: -50px;"><i class="<?=$data['fwicon']['circle-cross-solid'];?> text-danger"></i></a></div>
        <? }else{ ?>
        <input type="file" class="file form-control my-2" name="updatelogo" style="max-width:96px; " data-bs-toggle="tooltip" data-bs-placement="top" title="Select path to Upload Logo:(width:185px,height:75px)"/>
<textarea name="upload_logo" id="upload_logo" style="display:none !important"><? if(isset($post['upload_logo'])) echo $post['upload_logo']?></textarea>
        <? }?>
	  </div>
    
	  
	  
	  <div class="col-sm-6 logo_path">
    <span class="form-label" id="basic-addon4" >Upload Favicon (ICO):(w:64px,h:64px)</span>
      <? if(isset($post['logo_path'])&&$post['logo_path']) { ?>
        <input type="file" class="file form-control my-2" name="update_logo_path" id="update_logo_path" style="height:34px; max-width:96px; "  data-bs-toggle="tooltip" data-bs-placement="top" title="Select path to Upload Favicon ICO File:(width:64px,height:64px)"/>
        <textarea name="logo_path" id="logo_path" style="display:none !important"><?=(isset($post['logo_path'])?$post['logo_path']:'');?>
</textarea>
             <?php						
	         if(!empty($post['logo_path'])&&file_exists('../user_doc/'.$post['logo_path']))
			 {
			 ?>
             <div  class="appbrand5 icoIcon logoa 2" style="display:inline-block !important"><? $pro_img=display_docfile("../user_doc/",$post['logo_path']);?>
		
        <a onclick="logo_path_xf(this)" class="closeImg float-end"><i class="<?=$data['fwicon']['circle-cross-solid'];?> text-danger"></i></a></div>
		     <?php } ?>
			 
		
		
		
        <? }else{ ?>
        <input type="file" class="file form-control my-2" name="update_logo_path" style="max-width:96px;" data-bs-toggle="tooltip" data-bs-placement="top" title="Select path to Upload Favicon ICO File:(width:64px,height:64px)"  />
<textarea name="logo_path" id="logo_path" style="display:none !important"><? if(isset($post['logo_path'])) echo $post['logo_path']?></textarea>
        <? }?>
	  </div>
     
	  <? }?>
	  
	  <div class="col-sm-4" style="display:none">
        <div class="input-group mb-3"> <span class="input-group-text col-sm-4" id="basic-addon4" >Upload CSS:</span>
          <input type="text" name="upload_css1" value="<? if(isset($post['upload_css'])) echo $post['upload_css']?>">
        </div>
      </div>
</div>	  
  

<div class="collapse rounded border clearfix p-2 my-2" id="collapseAdvance">

  <div class="row pb-2">
      <div class="col-sm-6">
    <span class="form-label " id="basic-addon4" >Domain Name:</span>
      <input type="text" name="domain_name" id="domain_name" class="form-control" value="<? if(isset($post['domain_name'])) echo $post['domain_name']?>" placeholder="Domain Name">
	  </div>
     
      <div class="col-sm-6">
    <span class="form-label " id="basic-addon4" >Domain Status:</span>
      <select name="domain_active" id="domain_active" class="form-select" data-rel="chosen"  >
        <option value="">Domain Status</option>
        <option value="1">Live</option>
        <option value="2">Inactive</option>
      </select>
	  <?php if(isset($post['domain_active'])&&$post['domain_active']<>""){ ?>
      <script>$('#domain_active option[value="<?=prntext($post['domain_active'])?>"]').prop('selected','selected');</script>
		<? }?>
		
      </div>
	  
      <div class="col-sm-6">
        <span class="form-label " id="basic-addon4" title="Support No." >Support No. :</span>
          <input type="text" class="form-control" name="customer_service_no" value="<? if(isset($post['customer_service_no'])) echo $post['customer_service_no']?>"  placeholder="Support No.">
        </div>
     
	  
      <div class="col-sm-6">
        <span class="form-label " id="basic-addon4" title="Support Email" >Support Email:</span>
          <input type="text" class="form-control" name="customer_service_email"  value="<?=(isset($post['customer_service_email'])?encrypts_decrypts_emails($post['customer_service_email'],2):'');?>" placeholder="Support Email">
        </div>
     
	
<div class="col-sm-12">
<h6 class="my-2"><strong>Dashboard Notice</strong></h6>
<input class="form-check-input" type="radio" name="notice_type" value="1" id="image_drop" <? if(isset($post['notice_type'])&&($post['notice_type']==1)){ ?>  checked="checked" <? }?>>
<label class="form-check-label fw-bold" for="flexRadioDefault1"> Image Url</label>
<input class="form-check-input" type="radio" name="notice_type" id="text_drop" value="2" <? if(isset($post['notice_type'])&&$post['notice_type']==2){ ?>  checked="checked" <? }?> >
<label class="form-check-label fw-bold" for="flexRadioDefault1"> Text</label>
    
  
<textarea name="dashboard_notice" id="dashboard_notice" class="form-control my-2" style="height:30px;"  placeholder="Dashboard Notice"><? if(isset($post['dashboard_notice'])&&$post['dashboard_notice']){ ?><?=$post['dashboard_notice']?><? }?></textarea>
</div>
	

 <? if(isset($_SESSION['login_adm'])){ ?> 
	  <div class="col-sm-12 hide">
	  <h6>Custom CSS</h6>
<textarea  name="custom_css" rows="3" class="form-control" placeholder="Custom CSS"><? if(isset($post['custom_css'])&&$post['custom_css']){ ?><?=$post['custom_css']?><? }?></textarea>
	  </div>
	  
	  <div class="col-sm-12">
	  <h6>More Details for (MailGun, Host, Fee, Project) In Json Format <a class="btn btn-icon btn-sm btn-primary right active my-1" onclick="readonlyf(this,'#more_details')">Edit</a></h6>
<?
		if($data['con_name']=='clk'){
			$settlement_fixed_fee='1';
			$settlement_min_amt='1';
			$monthly_fee='1';
			$withdraw_max_amt='20000';
			$frozen_balance='100';
			$gst_fee='18.00';
			$default_currency='INR';
		}else{
			$settlement_fixed_fee='100';
			$settlement_min_amt='5000';
			$monthly_fee='350';
			$withdraw_max_amt='20000';
			$frozen_balance='100';
			$gst_fee='0.00';
			$default_currency='USD';
			
		}
$more_details='{
	"mailgun_from":"Info<info@test.com>",
	"SiteName":"test.com",
	"Host":"https://test.com",
	"mail_gun_api":"",
	"mail_api_host":"",
	"reply_to":"noreply<info@test.com>"
	"default_currency":"'.$default_currency.'",
	"withdraw_max_amt":"'.$withdraw_max_amt.'",
	"monthly_fee":"'.$monthly_fee.'",
	"settlement_fixed_fee":"'.$settlement_fixed_fee.'",
	"settlement_min_amt":"'.$settlement_min_amt.'",
	"frozen_balance":"'.$frozen_balance.'",
	"gst_fee":"'.$gst_fee.'"
 }';
		?>
<textarea class="nst form-control" rows="8"  name="more_details" id="more_details"  readonly><?php if(isset($post['more_details'])&&$post['more_details']){
echo $post['more_details'];}else{echo $more_details; }?></textarea>
</div>
	  
	  <? }?>
	  
	  <div class="col-sm-12">
	  <h6>Description</h6>
<textarea  class="widget-body form-control w-100" rows="3" name="description" autocomplete="off"  placeholder="Description"><? if(isset($post['description'])) echo $post['description']?></textarea>
	  </div>  
  
 </div>
  
  
</div>
	 
	  
<div class="col-sm-12 my-2 activesh text-center">
	  <button class="btn btn-primary my-2" type="submit" id="submit_button" name="send" value="Submit"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Submit</button>&nbsp;
	  <a class="btn btn-primary active_a my-2" href="<?=$data['Admins']?>/listsubadmin<?=$data['ex']?>?action=select"><i class="<?=$data['fwicon']['back'];?>"></i> Back </a>
	  </div>
    
      
    </div>
</div>
  </form>
</div>
<script type="text/javascript">
$(".select_color").change(function () {
			
var ctype = $(".select_color").val();
var ctype_id ='#'+ctype;
var tbgcolor = $(ctype_id).attr('tbg-color');
var txtcolor = $(ctype_id).attr('txt-color');


 $("#header_bg_color").val(tbgcolor);
 $("#hbc").html(tbgcolor);
 $("#header_bg_color").css("color", txtcolor).css("background", tbgcolor).css("height", "auto");
 $("#header_text_color").val(txtcolor);
 $("#htc").html(txtcolor); 
 $('#front_ui_panel option[value="Left_Panel"]').prop('selected','selected');
 
});


<?php /*?>

// set selected template color
function change_color55(clr){

alert(clr);
//var ctype = $("#razorpay").attr('color');
//var ctype $('option[value="razorpay"]').attr('color');
alert(ctype);
if(clr=="blue"){
 
 $("#header_bg_color").val("#5555AE");
 $("#hbc").html("#5555AE");
 $("#header_bg_color").css("color", "#ffffff").css("background", "#5555AE").css("height", "auto");
 $("#header_text_color").val("#ffffff");
 $("#htc").html("#ffffff");
 

}else if(clr=="green"){

 $("#header_bg_color").val("#37a238");
 $("#hbc").html("#37a238");
 $("#header_bg_color").css("color", "#ffffff").css("background", "#37a238").css("height", "auto");
 $("#header_text_color").val("#ffffff");
 $("#htc").html("#ffffff");

}else if(clr=="darkgreen"){

 $("#header_bg_color").val("#8fa895");
 $("#hbc").html("#8fa895");
 $("#header_bg_color").css("color", "#ffffff").css("background", "#8fa895").css("height", "auto");
 $("#header_text_color").val("#ffffff");
 $("#htc").html("#ffffff");

}else if(clr=="orange"){

 $("#header_bg_color").val("#ff9800");
 $("#hbc").html("#ff9800");
 $("#header_bg_color").css("color", "#ffffff").css("background", "#ff9800").css("height", "auto");
 $("#header_text_color").val("#ffffff");
 $("#htc").html("#ffffff");

}else if(clr=="magenta"){

 $("#header_bg_color").val("#DAB2C1");
 $("#hbc").html("#DAB2C1");
 $("#header_bg_color").css("color", "#ffffff").css("background", "#DAB2C1").css("height", "auto");
 $("#header_text_color").val("#ffffff");
 $("#htc").html("#ffffff");
 
}else if(clr=="yellow"){

 $("#header_bg_color").val("#ffeb3b");
 $("#hbc").html("#ffeb3b");
 $("#header_bg_color").css("color", "#ffffff").css("background", "#ffeb3b").css("height", "auto");
 $("#header_text_color").val("#ffffff");
 $("#htc").html("#ffffff");
 
}else if(clr=="darknavyblue"){

 $("#header_bg_color").val("#192b33");
 $("#hbc").html("#192b33");
 $("#header_bg_color").css("color", "#ffffff").css("background", "#192b33").css("height", "auto");
 $("#header_text_color").val("#ffffff");
 $("#htc").html("#ffffff");
}else if(clr=="lightblue"){

 $("#header_bg_color").val("#0071bc");
 $("#hbc").html("#0071bc");
 $("#header_bg_color").css("color", "#ffffff").css("background", "#0071bc").css("height", "auto");
 $("#header_text_color").val("#ffffff");
 $("#htc").html("#ffffff");
}else if(clr=="pmc"){

 $("#header_bg_color").val("linear-gradient(to right,#0019dc,#490dcb,#6201bb,#7100ac,#7a009e);");
 $("#hbc").html("linear-gradient(to right,#0019dc,#490dcb,#6201bb,#7100ac,#7a009e);");
$("#header_bg_color").css("color", "#ffffff").css("background", "linear-gradient(to right,#0019dc,#490dcb,#6201bb,#7100ac,#7a009e)").css("height", "auto");
 $("#header_text_color").val("#ffffff");
 $("#htc").html("#ffffff");
 
 }else if(clr=="vmc"){

 $("#header_bg_color").val("linear-gradient(355deg, rgba(57,103,216,1) 18%, rgba(11,119,169,1) 45%, rgba(138,74,247,1) 74%)");
 $("#hbc").html("linear-gradient(355deg, rgba(57,103,216,1) 18%, rgba(11,119,169,1) 45%, rgba(138,74,247,1) 74%)");
$("#header_bg_color").css("color", "#ffffff").css("background", "linear-gradient(355deg, rgba(57,103,216,1) 18%, rgba(11,119,169,1) 45%, rgba(138,74,247,1) 74%)").css("height", "auto");
 $("#header_text_color").val("#ffffff");
 $("#htc").html("#ffffff");
 
  }else if(clr=="quartz"){

 $("#header_bg_color").val("#d9b849");
 $("#hbc").html("#37a238");
 $("#header_bg_color").css("color", "#ffffff").css("background", "#d9b849").css("height", "auto");
 $("#header_text_color").val("#000000");
 $("#htc").html("#000000");
 

 
 }else if(clr=="opal"){

 $("#header_bg_color").val("linear-gradient(180deg, #4984B8 0%, rgba(255, 255, 255, 0.75) 100%)");
 $("#hbc").html("linear-gradient(180deg, #4984B8 0%, rgba(255, 255, 255, 0.75) 100%)");
$("#header_bg_color").css("color", "#ffffff").css("background", "linear-gradient(180deg, #4984B8 0%, rgba(255, 255, 255, 0.75) 100%)").css("height", "auto");
 $("#header_text_color").val("#ffffff");
 $("#htc").html("#ffffff");
 
 }else if(clr=="OPAL_IND"){
 $("#header_bg_color").val("#111111");
 $("#hbc").html("#111111");
 $("#header_bg_color").css("color", "#ffffff").css("background", "#111111").css("height", "auto");
 $("#header_text_color").val("#ffffff");
 $("#htc").html("#ffffff");
 
 $("#body_bg_color").val("#f5f5f6");
 $("#bbc").html("#f5f5f6");
 $("#body_bg_color").css("color", "#000000").css("background", "#f5f5f6").css("height", "auto");
 
}else{
 $("#header_bg_color").val("#ffffff");
 $("#hbc").html("#ffffff");
 $("#header_bg_color").css("color", "#ffffff").css("background", "#ffffff").css("height", "auto");
 $("#header_text_color").val("#000000");
 $("#htc").html("#000000"); 
}



}

<?php */?>
// set selected template color
function change_template(template){
$('#upload_css option[value="default"]').prop('selected','selected');
$('#front_ui_panel option[value="Left_Panel"]').prop('selected','selected');

 var tbgcolor="#ffffff";
 var txtcolor="#000000";

 $("#header_bg_color").val(tbgcolor);
 $("#hbc").html(tbgcolor);
 $("#header_bg_color").css("color", txtcolor).css("background", tbgcolor).css("height", "auto");
 $("#header_text_color").val(txtcolor);
 $("#htc").html(txtcolor); 
 $('#front_ui_panel option[value="Left_Panel"]').prop('selected','selected');
 
}


$('#text_drop').click(function() {
  $("#dashboard_notice").css("height", "100px");                      
});
$('#image_drop').click(function() {
 $("#dashboard_notice").css("height", "30px");                      
});
</script>
<? }?>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? }?>
