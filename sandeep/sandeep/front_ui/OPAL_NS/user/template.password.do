<? if(isset($data['ScriptLoaded'])){ ?>


<style>
<?if(!isset($_SESSION['login'])||empty($_SESSION['login'])){?>
.user_header_main {display: none;}
body .bg-white {margin-top:52% !important;margin-left:60% !important;}
.container.bodycontainer {max-width: 400px;}
.col-sm-3 {width: 44%;}
<? } ?>
</style>

 
<? if(!$data['PostSent']){ ?>

<div class="container mt-2 border bg-white" >
  <div class="row my-2 vkg clearfix_ice" >
    <h4><i class="fas fa-shield-alt" aria-hidden="true"></i> Security Settings :: Update Password <?=((isset($data['subUser'])&&$data['subUser'])?$data['subUser']:'');?></h4>
    <? if((isset($_SESSION['action_success'])&& $_SESSION['action_success'])||(isset($data['Error'])&& $data['Error'])){ ?>
   <? if((isset($data['Error'])&& $data['Error'])){ ?>
    <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error!</strong>
      <?=prntext($data['Error'])?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <? }else { ?>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
      <?=($_SESSION['action_success']);?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <? if($_SESSION['action_success']){$_SESSION['action_success']=0;} ?>
    <? } ?>
    <? } ?>
  </div>
  <form method="post">
  <?if(!isset($data['subUser'])&&empty($data['subUser'])){?>
    <div class="mb-2 row">
      <label for="staticEmail" class="col-sm-4 col-form-label">Old Password:</label>
      <div class="col-sm-8">
        <input type="password" class="form-control" name="opass" id="password" placeholder="Old Password" value="<?=((isset($post['opass']) &&$post['opass'])?$post['opass']:'')?>" autocomplete="off" required />
      </div>
    </div>
<?}?>
    <div class="mb-2 row">
      <label for="staticEmail" class="col-sm-4 col-form-label">New Password:</label>
      <div class="col-sm-8">
        <input type="password" class="form-control" name="npass" id="password1" placeholder="New Password" value="<?=((isset($post['npass']) &&$post['npass'])?$post['npass']:'')?>" autocomplete="off" required />
      </div>
    </div>
    <div class="mb-2 row">
      <label for="staticEmail" class="col-sm-4 col-form-label">Repeat Password:</label>
      <div class="col-sm-8">
        <input type="password" class="form-control" name="cpass" id="password2" placeholder="Repeat Password" value="<?=((isset($post['cpass']) &&$post['cpass'])?$post['cpass']:'')?>" autocomplete="off" required />
      </div>
    </div>
    <div class="mb-2 row">
      <div class="col-sm-12">
        <button class="btn btn-primary  w-100" type="submit" name="change" value="CHANGE NOW!" ><i class="far fa-check-circle"></i> Submit</button>
      </div>
    </div>
<div class="row valiglyph my-2">
<div class="col-sm-3"><span id="8char" style="color:#FF0004;"><i class="fas fa-times"></i></span> 10 Characters Long</div>
<div class="col-sm-3"><span id="ucase" style="color:#FF0004;"><i class="fas fa-times"></i></span> One Uppercase Letter</div>
<div class="col-sm-3"><span id="lcase" style="color:#FF0004;"><i class="fas fa-times"></i></span> One Lowercase Letter</div>
<div class="col-sm-3"><span id="num"  style="color:#FF0004;"><i class="fas fa-times"></i></span> One Number</div>
<div class="col-sm-3"><span id="pwmatch"  style="color:#FF0004;"><i class="fas fa-times"></i></span> Passwords Match</div>
</div>
  </form>
</div>
<script>

$("input[type=password]").keyup(function(){
    var ucase = new RegExp("[A-Z]+");
	var lcase = new RegExp("[a-z]+");
	var num = new RegExp("[0-9]+");
	
	if($("#password1").val().length >= 10){
		$("#8char").removeClass("remove_2");
		$("#8char").addClass("ok_2 ");
		$("#8char").css("color","#00A41E");
		$('#8char i').attr('class','fas fa-check text-success');
	}else{
		$("#8char").removeClass("ok_2 ");
		$("#8char").addClass("remove_2");
		$("#8char").css("color","#FF0004");
		$('#8char i').attr('class','fas fa-times text-danger');
		
	}
	
	if(ucase.test($("#password1").val())){
		$("#ucase").removeClass("remove_2");
		$("#ucase").addClass("ok_2 ");
		$("#ucase").css("color","#00A41E");
		$('#ucase i').attr('class','fas fa-check text-success');
	}else{
		$("#ucase").removeClass("ok_2 ");
		$("#ucase").addClass("remove_2");
		$("#ucase").css("color","#FF0004");
		$('#ucase i').attr('class','fas fa-times text-danger');
	}
	
	if(lcase.test($("#password1").val())){
		$("#lcase").removeClass("remove_2");
		$("#lcase").addClass("ok_2 ");
		$("#lcase").css("color","#00A41E");
		$('#lcase i').attr('class','fas fa-check text-success');
	}else{
		$("#lcase").removeClass("ok_2 ");
		$("#lcase").addClass("remove_2");
		$("#lcase").css("color","#FF0004");
		$('#lcase i').attr('class','fas fa-times text-danger');
	}
	
	if(num.test($("#password1").val())){
		$("#num").removeClass("remove_2");
		$("#num").addClass("ok_2 ");
		$("#num").css("color","#00A41E");
		$('#num i').attr('class','fas fa-check text-success');
	}else{
		$("#num").removeClass("ok_2 ");
		$("#num").addClass("remove_2");
		$("#num").css("color","#FF0004");
		$('#num i').attr('class','fas fa-times text-danger');
	}
	
	if($("#password1").val() == $("#password2").val()){
	
	if($("#password1").val()==""){ return false;}
	
	
		$("#pwmatch").removeClass("remove_2");
		$("#pwmatch").addClass("ok_2 ");
		$("#pwmatch").css("color","#00A41E");
		$('#pwmatch i').attr('class','fas fa-check text-success');
	}else{
	
		$("#pwmatch").removeClass("ok_2 ");
		$("#pwmatch").addClass("remove_2");
		$("#pwmatch").css("color","#FF0004");
		$('#pwmatch i').attr('class','fas fa-times text-danger');
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
</script>
<? } ?>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
