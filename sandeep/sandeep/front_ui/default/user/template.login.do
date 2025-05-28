<? $domain_server=$_SESSION['domain_server']; ?>
<? if(isset($data['ScriptLoaded'])){ ?>
<style> 

 .row {--bs-gutter-x: 1.5rem;}
 .col-form-label { font-weight: normal !important;}
 /*.input-field input:valid+label {left: 18px !important;}*/
 
 
.divider:after,
.divider:before {
	content: "";
	flex: 1;
	height: 1px;
	background: #eee;
}
.h-custom {
	height: calc(100% - 73px);
}
@media (max-width: 450px) {
	.h-custom {
		height: 100%;
	}
}

</style>
<section class="vh-100">
<div class="container-fluid h-custom">
  <div class="row d-flex justify-content-center align-items-center h-100">
    <div class="col-md-9 col-lg-6 col-xl-5"> <img src="<?=$data['Host']?>/images/draw2.webp" class="img-fluid" alt="Sample image"> </div>
    <? if((!isset($data['PostSent']) || empty($data['PostSent']))){ ?>
    <? if((!isset($data['CantLogin']) || empty($data['CantLogin']))){ ?>
	
    <? if((isset($_SESSION['errmsg'])&& $_SESSION['errmsg'])){ ?>
    <div class="containerX my-2" style="max-width:500px;">
      <!--style="max-width:400px;"-->
      <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error !! </strong>
        <?=prntext($_SESSION['errmsg'])?>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
    </div>
    <? unset($_SESSION['errmsg']); } ?>
	
	<div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
		<? if(($data['hdr_logo'])&&($domain_server['LOGO'])){ ?>
        <div class="text-start mt-0 -0 row w-100"> <a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>" class="img-fluid"><img src="<?=encode_imgf($domain_server['LOGO']);?>" style="height:50px;"></a> </div>
        <? } ?>
		
	
    <? if(isset($_SESSION['action_success'])&&$_SESSION['action_success']){ ?>
    <div class="containerX my-2" style="max-width:500px;">
      <div class="alert alert-success alert-dismissible fade show" role="alert">
        <?=($_SESSION['action_success']);?>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
    </div>
    <? if(isset($_SESSION['action_success'])){
				 $_SESSION['action_success']=0;
				 unset($_SESSION['action_success']);
				 } ?>
    <? }?>
    <? if(isset($data['attempts'])&&$data['attempts']>=1) { ?>
    <div class="alert alert-danger my-2" role="alert"> Merchant Login (Attempt #
      <?=((isset($data['attempts'])&&$data['attempts'])?$data['attempts']:'')?>
      , Max.
      <?=prnintg($data['PassAtt'])?>
      ) </div>
    <? } ?>
    
      <form method="post" autocomplete="off">
        <input type="hidden" name="token" id="token" value='<?=prntext($_SESSION['token_forgot'],0);?>' />
        <input type="hidden" name="token_sign" id="token_sign" value='<?=prntext($_SESSION['token_sign'],0);?>' />
        
        <? if((isset($data['Error'])&& $data['Error'])){ ?>
        <div class="toast align-items-center text-message border-0 w-100 mb-1 fade show" role="alert" aria-live="assertive" aria-atomic="true">
          <div class="d-flex">
            <div class="toast-body">
              <?=prntext($data['Error'])?>
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto close_toast"  onclick="toastclose('.toast')" data-bs-dismiss="toast" aria-label="Close"></button>
          </div>
        </div>
        <? } ?>
        <div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start">
          <p class="lead fw-normal mb-4 me-3">Sign in </p>
          <?/*?>
            <button type="button" class="btn btn-primary btn-floating mx-1">
              <i class="fab fa-facebook-f"></i>
            </button>

            <button type="button" class="btn btn-primary btn-floating mx-1">
              <i class="fab fa-twitter"></i>
            </button>

            <button type="button" class="btn btn-primary btn-floating mx-1">
              <i class="fab fa-linkedin-in"></i>
            </button>
			<?*/?>
        </div>
        <!-- User Name -->
        <div class="form-outline input-field mb-4">
          <input type="text" class="form-control form-control-lg" name="username" title="Username" id="input_username" value="<?=(isset($_COOKIE["username"])&&trim($_COOKIE["username"])?$_COOKIE["username"]:@$post["username"])?>" autocomplete="off" required />
          <label class="form-label" for="input_username">Enter username</label>
        </div>
        <!-- Password input -->
        <div class="form-outline input-field mb-3 position-relative">
          <input type="password" class="form-control form-control-lg" name="password" id="pass_log_id" title="Password"  value="<?=(isset($_COOKIE["password"])&&trim($_COOKIE["password"])?$_COOKIE["password"]:@$post["password"])?>" autocomplete="off" required />
          <label class="form-label" for="pass_log_id">Enter password</label>
          <span toggle="#password-field" class="position-absolute top-0 end-0" style="margin-right:30px;"><i class="<?=$data['fwicon']['eye'];?> field_icon toggle-password text-link" style=" padding-top:11px;" title="Show password"></i></span> </div>
        <div class="d-flex justify-content-between align-items-center">
          <!-- Checkbox -->
          <div class="form-check mb-0">
            <input class="form-check-input me-2" type="checkbox" value=""  id="remember_me" name="remember" <?php if(isset($_COOKIE["password"])) { ?> checked="checked" <? } ?> />
            <label class="form-check-label" for="remember_me"> Remember me </label>
          </div>
          <a href="<?=$data['Host'];?>/reset-password<?=$data['ex']?>"  class="text-body">Reset password?</a> </div>
        <div class="text-center text-lg-start mt-4 pt-2">
          
			  <button class="btn btn-primary login_account" type="submit" name="send" value="Log Me In" style="padding-left: 2.5rem; padding-right: 2.5rem;" >Login</button>
          <p class="small fw-bold mt-2 pt-1 mb-0">Don't have an account? <a href="<?=$data['Host']?>/signup<?=$data['ex']?>" class="link-primary">Sign up!</a></p>
        </div>
      </form>
    </div>
  </div>
</div>
<div
    class="d-flex flex-column flex-md-row text-center text-md-start justify-content-between py-4 px-4 px-xl-5 bg-primary">
  <!-- Copyright -->
  <div class="text-white mb-3 mb-md-0"> Copyright © 2023. All rights reserved. </div>
  <!-- Copyright -->
  <? if($domain_server['STATUS']==true){ ?>
  <div class="helpline99 my-0 text-end">
    <? if($domain_server['customer_service_no']){ ?>
    <a href="tel:<?=$domain_server['customer_service_no'];?>" class="mx-2 text-white" title="Customer Service No."><i class="<?=$data['fwicon']['headphones'];?>"></i>
    <?=$domain_server['customer_service_no'];?>
    </a>
    <? } ?>
    <? if($domain_server['customer_service_email']){ ?>
    <a target='_blank' title="Customer Service Email" href="mailto:<?=$domain_server['customer_service_email']?>?subject=I need help&body=Dear <?=$data['SiteName'];?>, I need your help about ..." class="mx-2 text-white" ><i class="<?=$data['fwicon']['email'];?>"></i>
    <?=$domain_server['customer_service_email'];?>
    </a>
    <? } ?>
  </div>
  <? } ?>
  <?/*?>
  <!-- Right -->
  <div> <a href="#!" class="text-white me-4"> <i class="fab fa-facebook-f"></i> </a> <a href="#!" class="text-white me-4"> <i class="fab fa-twitter"></i> </a> <a href="#!" class="text-white me-4"> <i class="fab fa-google"></i> </a> <a href="#!" class="text-white"> <i class="fab fa-linkedin-in"></i> </a> </div>
  <!-- Right -->
  <?*/?>
</div>
</section>
<? }else{ ?>
<div class="container my-2 border bg-light text-dark" style="max-width:450px;">
  <h5>Suspicious Login Alert </h5>
  <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Restricted Area! </strong> <br />
    Enter Wrong login details <strong><?php echo $data['PassAtt'];?></strong> times. <br />
    Your accout is blocked for next <strong>30 minutes</strong> by now. </div>
  <div class="col text-center text-primary"><i class="<?=$data['fwicon']['eye'];?>"></i> <a href="<?=$data['Host'];?>/reset-password<?=$data['ex']?>" class="btn btn-link">Reset Password?</a> Not Merchant? <a href="<?=$data['Host']?>/signup<?=$data['ex']?>"><i class="<?=$data['fwicon']['user-plus'];?>"></i> Register Here</a> </div>
</div>
<? } ?>
<? }else{ ?>
<? } ?>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
<script>
//alert("ooops");
//$('input,p,div,select,textarea').on("select mousedown mouseup dblclick mouseover etc", false);

$(document).ready(function(){
	$('.username').focusout(function(){
	//var reM = '#my&*^*&%*&$^%&$%^$ #name656565__: ^*&**&^%%$^&__# is Mithilesh###__';
	var reM = $( ".username" ).val();

	/*you can use given comment for slice the string sentence*/
	//str = reM.replace(/[0-9`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/\s]/gi,'').slice( 0,4 );

	str = reM.replace(/[` ~!@#$%^&*()|+\-=?;:'",<>\{\}\[\]\\\/]/gi,'');
	$( ".username" ).val(str);
	});
});



$('.toggle-password').on('click', function () {

    $(this).toggleClass("<?=$data['fwicon']['eye-slash'];?>");

    var input = $("#pass_log_id").attr("type");
     
    if (input == "password") {
        $("#pass_log_id").attr("type", "text");
		$(".toggle-password").attr("title", "Hide password");
    } else {
        $("#pass_log_id").attr("type", "password");
		$(".toggle-password").attr("title", "Show password");
    }
});


$('.login_account').on('click', function () {
	if(($('.username').val()=="") || ($('.password').val()=="")){
		alert("Please Enter Username and password");
		return;
	}
	$(".login_account").html("<i class='<?=$data['fwicon']['spinner']?> fa-spin-pulse'></i>");
});




</script>
<div>
