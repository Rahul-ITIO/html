<? $domain_server=$_SESSION['domain_server']; ?>
<? if(isset($data['ScriptLoaded'])){ ?>

<style> 

 .row {--bs-gutter-x: 1.5rem;}
 .col-form-label { font-weight: normal !important;}
 /*.input-field input:valid+label {left: 18px !important;}*/

</style>

<? if((!isset($data['PostSent']) || empty($data['PostSent']))){ ?>
<? if((!isset($data['CantLogin']) || empty($data['CantLogin']))){ ?>


<? if((isset($_SESSION['errmsg'])&& $_SESSION['errmsg'])){ ?>

<div class="container my-2" style="max-width:500px;"><!--style="max-width:400px;"-->
  <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error !! </strong>
    <?=prntext($_SESSION['errmsg'])?>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
</div>
<? unset($_SESSION['errmsg']); } ?>

 <? if(isset($_SESSION['action_success'])&&$_SESSION['action_success']){ ?>
 
 <div class="container my-2" style="max-width:500px;">
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

<div class="container-sm my-2" style="max-width:500px; margin:0 auto;">
 
  <div class="row-fluid mt-5">
<? if(($data['hdr_logo'])&&($domain_server['LOGO'])){ ?>
	<div class="text-start mb-2">
    <a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>" class="img-fluid"><img src="<?=encode_imgf($domain_server['LOGO']);?>" style="height:50px;"></a>
	</div>
    <? } ?>
	
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

    <div class="rounded-tringle pull-up77 bg-primary vkg p-2 rounded">
	<div class="both-side-margin">
			<? if(isset($data['attempts'])&&$data['attempts']>=1) { ?>
	    <div class="alert alert-danger my-2" role="alert">
         Merchant Login (Attempt #
        <?=((isset($data['attempts'])&&$data['attempts'])?$data['attempts']:'')?>, Max. <?=prnintg($data['PassAtt'])?> ) 
        </div>
		
	<? } ?>
	
    
	<div class="my-2 fs-5">Sign in</div>
	<!--<div class="vkg-main-border2"></div>-->
    <form method="post" autocomplete="off">
        <input type="hidden" name="token" id="token" value='<?=prntext($_SESSION['token_forgot'],0);?>' />
        <input type="hidden" name="token_sign" id="token_sign" value='<?=prntext($_SESSION['token_sign'],0);?>' />
        <div class="row-fluid">
          
          <div class="col-sm-12 input-field mt-4">
            <input type="text" class="form-control username"  name="username" title="Username" id="input_username"  value="<?php if(isset($_COOKIE["username"])) { echo $_COOKIE["username"]; } ?>" autocomplete="off" required/>
			<?php /*?>value="<?php  if(isset($post['username'])){ echo prntext($post['username'],12);} ?>"<?php */?>
			<label for="input_username">Enter username</label>
          </div>
        </div>
        <div class="row-fluid">

          <div class="col-sm-12 input-field mt-4">
            <input type="password" class="form-control float-start password" name="password" id="pass_log_id" title="Password"  value="<?php if(isset($_COOKIE["password"])) { echo $_COOKIE["password"]; } ?>" autocomplete="off" style="width:100%;" required/>
			<label for="pass_log_id">Enter password</label>
			<span toggle="#password-field" class="form-control55 text-center float-start text-center" style=" margin-left:-30px;"><i class="<?=$data['fwicon']['eye'];?> field_icon toggle-password text-link" style=" padding-top:11px;" title="Show password"></i></span>
			

          </div>
        </div>
		
		<div class="row-fluid form-check ">
    
    <label class="col-sm-12 col-form-label w-100 mt-2" for="exampleCheck1"><input type="checkbox" class="form-check-input" id="remember_me" name="remember" <?php if(isset($_COOKIE["password"])) { ?> checked="checked" <? } ?>> Remember me <span class="float-end">
<a href="<?=$data['Host'];?>/reset-password<?=$data['ex']?>" class="text-link" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="Click here to reset password">Reset password?</a></span></label>
  
          </div>
        
		
		
        <div class="mb-3 row-fluid">
          <div class="col-sm-12">
            <button class="btn btn-primary login_account" type="submit" name="send" value="Log Me In" style="width:100%;">Continue</button>
          </div>
        </div>
        <div class="col my-2 text-center">  Don't have an account? <a href="<?=$data['Host']?>/signup<?=$data['ex']?>" class="text-link">Sign up!</a></div>
      </form>
    </div>
    </div>
  </div>
  
    <? if($domain_server['STATUS']==true){ ?>
	<div class="helpline99 my-2 text-end">
	<? if($domain_server['customer_service_no']){ ?><a href="tel:<?=$domain_server['customer_service_no'];?>" class="mx-2 text-white" title="Customer Service No."><i class="<?=$data['fwicon']['headphones'];?>"></i> <?=$domain_server['customer_service_no'];?></a> <? } ?>
	<? if($domain_server['customer_service_email']){ ?><a target='_blank' title="Customer Service Email" href="mailto:<?=$domain_server['customer_service_email']?>?subject=I need help&body=Dear <?=$data['SiteName'];?>, I need your help about ..." class="mx-2 text-white" ><i class="<?=$data['fwicon']['email'];?>"></i> <?=$domain_server['customer_service_email'];?></a><? } ?> 
	</div>
	<? } ?>
</div>
<? }else{ ?>
<div class="container my-2 border bg-light text-dark" style="max-width:450px;">
  <h5>Suspicious Login Alert </h5>
  <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Restricted Area! </strong> <br />
    Enter Wrong login details <strong><?php echo $data['PassAtt'];?></strong> times. <br />
    Your accout is blocked for next <strong>30 minutes</strong> by now.

  </div>
  <div class="col text-center text-primary"><i class="<?=$data['fwicon']['eye'];?>"></i>  <a href="<?=$data['Host'];?>/reset-password<?=$data['ex']?>" class="btn btn-link">Reset Password?</a> Not Merchant? <a href="<?=$data['Host']?>/signup<?=$data['ex']?>"><i class="<?=$data['fwicon']['user-plus'];?>"></i> Register Here</a> </div>
</div>
<? } ?>
<? }else{ ?>
<? } ?>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
</div>
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
