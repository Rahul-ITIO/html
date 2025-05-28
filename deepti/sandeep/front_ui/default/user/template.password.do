<? if(isset($data['ScriptLoaded'])){ 

$auth_pass_code="";
if(isset($_REQUEST['c'])&&$_REQUEST['c']){ $auth_pass_code=$_REQUEST['c']; }
?>
<style>
<? if(!isset($_SESSION['login'])||empty(trim($_SESSION['login']))){ ?>
.user_header_main {display: none;}
body .bg-white, #zink_id {margin: 0 auto;margin-top:-140px !important;position:relative;top:50%;}
.container.bg-white, #zink_id {max-width: 400px;}
.col-sm-3 {width:50%;}

<? } ?>
@media (max-width: 350px){
.col-sm-3 {width:100%;}
}
.valiglyph {display:none;}


    #passwordModal .modal-dialog {
     /*width: 500px !important;
     height:600px !important;*/
     }
	 .vkg.dropdown-toggle::after { position: absolute;top: 50%;right: 20px; }    
	 .vkg.dropdown-menu { min-width: 96% !important; }
	 .input-field input:focus+label, .input-field input:valid+label {left: 20px !important;}
	 
</style>

<? if(!$data['PostSent']){ ?>

<div id="zink_id" class="container mt-2 border bg-primary  text-white rounded" style="min-height: 260px;" >
  <div class="my-2 vkg clearfix_ice" >
    <h4><i class="<?=$data['fwicon']['shield'];?>" aria-hidden="true"></i> Security Settings<?=((isset($data['subUser'])&&$data['subUser'])?$data['subUser']:':: Update Password');?></h4>
	
	<p>You can change your password for security reasons or reset it if you forget it.</p>
	



    <? if((isset($_SESSION['action_success'])&& $_SESSION['action_success'])||(isset($data['Error'])&& $data['Error'])){ ?>
   <? if((isset($data['Error'])&& $data['Error'])){ ?>
    <div class="alert alert-danger alert-dismissible fade show mb-2" role="alert"> <strong>Error!</strong>
      <?=prntext($data['Error'])?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <? }else { ?>
    <div class="alert alert-success alert-dismissible fade show mb-2" role="alert">
      <?=($_SESSION['action_success']);?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
   
    <? } ?>
	<? } ?>
	
  </div>
  
  
  <div class="border rounded p-2 my-2 dropdown" style="max-width:500px; margin:0 auto;">

  <div class="vkg dropdown-toggle" style="width:calc(100% - 70px);" role="button" id="dropdownPassword" data-bs-toggle="dropdown" aria-expanded="false"><span class="loader-pass"><i class="<?=$data['fwicon']['check-circle'];?> text-success"></i></span>&nbsp;Password </div>

  <ul class="vkg dropdown-menu" aria-labelledby="dropdownPassword">
    <li><a class="dropdown-item password-action" data-value="1">Reset Password</a></li>
  </ul>
</div>


<div class="modal fade" id="passwordModal" aria-hidden="true" aria-labelledby="passwordModalLabel" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content bg-primary text-white">
      <div class="modal-header">
        <h5 class="modal-title" id="passwordModalLabel">Change / Update Password</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
	  <form method="post">
      <div class="modal-body">
	  <div class="toast-pass toast align-items-center text-message border-0 w-100 mb-2 fade hide" role="alert" aria-live="assertive" aria-atomic="true">
  <div class="d-flex">
    <div class="toast-body toast-body-msg-pass"></div>
    
    <button type="button" class="btn-close btn-close-white me-2 m-auto close_toast"  onclick="toastclose('.toast-pass')" data-bs-dismiss="toast-pass" aria-label="Close"></button>
  </div>
</div>
	  <div class="row border rounded">
	  <input type="hidden" name="auth_pass_code" id="auth_pass_code" value="<?=$auth_pass_code;?>" />
	     <? if(!isset($data['subUser'])&&empty($data['subUser'])){ ?>
			    
				<div class="col-sm-12 input-field mt-3">
				<input type="password" class="form-control" name="opass" id="password" autocomplete="off" required />
				<label for="password">Old Password</label>
				</div>
			    
		<? } ?>	
				
				<div class="col-sm-12 input-field mt-3"><input type="password" class="form-control" name="npass" id="password1" autocomplete="off" required />
				<label for="password1">New Password</label>
				</div>
			   
				
				
				<div class="col-sm-12 input-field my-3"><input type="password" class="form-control" name="cpass" id="password2" autocomplete="off" required />
				<label for="password2">Repeat Password</label>
				</div>
			    
			

<div class="row valiglyph my-2">
<div class="col-sm-12"><span id="8char" style="color:#FF0004;"><i class="<?=$data['fwicon']['circle-cross'];?>"></i></span> 10 Characters Long</div>
<div class="col-sm-12"><span id="ucase" style="color:#FF0004;"><i class="<?=$data['fwicon']['circle-cross'];?>"></i></span> One Uppercase Letter</div>
<div class="col-sm-12"><span id="lcase" style="color:#FF0004;"><i class="<?=$data['fwicon']['circle-cross'];?>"></i></span> One Lowercase Letter</div>
<div class="col-sm-12"><span id="num"  style="color:#FF0004;"><i class="<?=$data['fwicon']['circle-cross'];?>"></i></span> One Number</div>
<div class="col-sm-12"><span id="pwmatch"  style="color:#FF0004;"><i class="<?=$data['fwicon']['circle-cross'];?>"></i></span> Passwords Match</div>
</div>


                

		
		</div>
	   
	   
	   
      </div>
      <div class="modal-footer">
       
		<button class="btn btn-primary btn-sm submit-password" type="submit" name="change" value="Change Now!" ><i class="<?=$data['fwicon']['check-circle'];?>"></i> Submit</button>
		
      </div>
	  </form>
    </div>
  </div>
</div>

<script>

$("input[type=password]").keyup(function(){ 
    var ucase = new RegExp("[A-Z]+");
	var lcase = new RegExp("[a-z]+");
	var num = new RegExp("[0-9]+");
	
	if($("input[type=password]").length > 0){
		$(".valiglyph").css({"display":"flex"});
	}
	
	
	if($("#password1").val().length >= 10){
		$("#8char").removeClass("remove_2");
		$("#8char").addClass("ok_2 ");
		$("#8char").css("color","#00A41E");
		$('#8char i').attr('class','<?=$data['fwicon']['check-circle'];?> text-success');
	}else{
		$("#8char").removeClass("ok_2 ");
		$("#8char").addClass("remove_2");
		$("#8char").css("color","#FF0004");
		$('#8char i').attr('class','<?=$data['fwicon']['circle-cross'];?> text-danger');
		
	}
	
	if(ucase.test($("#password1").val())){
		$("#ucase").removeClass("remove_2");
		$("#ucase").addClass("ok_2 ");
		$("#ucase").css("color","#00A41E");
		$('#ucase i').attr('class','<?=$data['fwicon']['check-circle'];?> text-success');
	}else{
		$("#ucase").removeClass("ok_2 ");
		$("#ucase").addClass("remove_2");
		$("#ucase").css("color","#FF0004");
		$('#ucase i').attr('class','<?=$data['fwicon']['circle-cross'];?> text-danger');
	}
	
	if(lcase.test($("#password1").val())){
		$("#lcase").removeClass("remove_2");
		$("#lcase").addClass("ok_2 ");
		$("#lcase").css("color","#00A41E");
		$('#lcase i').attr('class','<?=$data['fwicon']['check-circle'];?> text-success');
	}else{
		$("#lcase").removeClass("ok_2 ");
		$("#lcase").addClass("remove_2");
		$("#lcase").css("color","#FF0004");
		$('#lcase i').attr('class','<?=$data['fwicon']['circle-cross'];?> text-danger');
	}
	
	if(num.test($("#password1").val())){
		$("#num").removeClass("remove_2");
		$("#num").addClass("ok_2 ");
		$("#num").css("color","#00A41E");
		$('#num i').attr('class','<?=$data['fwicon']['check-circle'];?> text-success');
	}else{
		
		$("#num").removeClass("ok_2 ");
		$("#num").addClass("remove_2");
		$("#num").css("color","#FF0004");
		$('#num i').attr('class','<?=$data['fwicon']['circle-cross'];?> text-danger');
	}
	
	if($("#password1").val() == $("#password2").val()){
	
	if($("#password1").val()==""){ return false;}
	
	
		$("#pwmatch").removeClass("remove_2");
		$("#pwmatch").addClass("ok_2 ");
		$("#pwmatch").css("color","#00A41E");
		$('#pwmatch i').attr('class','<?=$data['fwicon']['check-circle'];?> text-success');
	}else{
	
		$("#pwmatch").removeClass("ok_2 ");
		$("#pwmatch").addClass("remove_2");
		$("#pwmatch").css("color","#FF0004");
		$('#pwmatch i').attr('class','<?=$data['fwicon']['circle-cross'];?> text-danger');
	}
});
<? if(isset($post['npass'])&&$post['npass']){ ?>
$('input[type=password]').trigger('keyup');
<? } ?>

$(document).ready(function() {
	 $('#password1,#password2').bind('copy paste cut',function(e) { 
		 e.preventDefault(); //disable cut,copy,paste
		 alert('cut,copy & paste options are disabled !!');
	 });
});


$('.password-action').on('click', function () {
	$('#passwordModal').modal('show');
});

$('.submit-password').on('click', function () {

	$('.toast-pass').hide();

    var opass=$('#password').val();
	var npass=$('#password1').val();
	var cpass=$('#password2').val();
	var auth_pass_code=$('#auth_pass_code').val();
	var utype=1;
	
	    if(opass==''){
			alert('Please enter old password');
			$( "#password" ).focus();
			return false;
		}else if(npass==''){
		    alert('Please enter new password');
			$( "#password1" ).focus();
			return false;
		}else if(cpass==''){
		    alert('Please enter repeat password');
			$( "#password2" ).focus();
			return false;
		}else if(opass==npass){
		    alert('New password should not be same as old password.');
			$( "#password2" ).focus();
			return false;
		}else if(cpass!=npass){
		    alert('New password and repeat password not matched');
			$( "#password2" ).focus();
			return false;
		}else if(npass.search(/[a-z]/) < 0) { 
		    alert('Password must contain at least one lowercase letter');
			$( "#password1" ).focus();
			return false;
		}else if(npass.search(/[A-Z]/) < 0) { 
		    alert('Password must contain at least one uppercase letter');
			$( "#password1" ).focus();
			return false;
		}else if(npass.search(/[0-9]/) < 0) { 
		    alert('Password must contain at least one number');
			$( "#password1" ).focus();
			return false;
		}else if(npass.length < 10) { 
		    alert('Password must be at least 10 characters');
			$( "#password1" ).focus();
			return false;
		}
		

	$(".submit-password_XX").html("<i class='<?=$data['fwicon']['spinner'];?> fa-spin-pulse'></i>");
	
	//alert(1212);
	<?/*?>
	 $.ajax({
		url: "<?=$data['Host'];?>/include/change-password<?=$data['ex']?>",
		data:'opass='+opass+'&npass='+npass+'&cpass='+cpass+'&auth_pass_code='+auth_pass_code+'&utype='+utype,
		type: "POST",
		success:function(data){
		  //alert("data2=>"+data);
          data = ($.trim(data.replace(/[\t\n]+/g, '')));
		  if(data=="done"){
		  //alert(data);
		  
		  //window.location.href="<?=$data['USER_FOLDER']?>/?p=1";
		  window.location.href="<?=$data['USER_FOLDER']?>/logout<?=$data['ex']?>?p=1";
		  
		  //$('.toast-pass').show();
		  //$(".toast-body-msg-pass").html('Password updated successfully');
		  //$(".submit-password").hide();
		  }else{
		  //alert(data);
		  $('.toast-pass').show();
		  $(".toast-body-msg-pass").html('You entered wrong old password.');
		  $(".submit-password").html('<i class="<?=$data['fwicon']['check-circle'];?>"></i> Submit');
		  }
		},
			error:function (){}
	});
	<?*/?>
});

</script>
<? } ?>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
