<??>
<style> 
 .admins .jqclock, 
 .tranStatDIVbar1 {display:none !important;} 
 .col-form-label {
  font-weight: normal !important;
 }

body { 
	background:var(--background-1) !important;
} 
</style>
<style> .row {--bs-gutter-x: 1.5rem;} </style>
<? $domain_server=$_SESSION['domain_server']; ?>
<? if(isset($data['ScriptLoaded'])){ ?>


<div class="container-sm my-2 position-absolute top-50 start-50 translate-middle" style="max-width:480px; margin:0 auto; margin-top: -60px !important">

  <div class="row-fluid mt-5">
	<? if(($data['hdr_logo'])&&($domain_server['LOGO'])){ ?>
	<div class="text-start mb-2">
	<a class="img-fluid"><img src="<?=encode_imgf($domain_server['LOGO']);?>" style="height:50px;"></a>
	</div>
	<? } ?>
	<?php if((isset($data['Error'])) && ($data['Error']!='')){?>
<div class="toast align-items-center text-message border-0 w-100 mb-1 fade show" role="alert" aria-live="assertive" aria-atomic="true">
  <div class="d-flex">
    <div class="toast-body">
    <?=prntext($data['Error'])?>
    </div>
    <button type="button" class="btn-close btn-close-white me-2 m-auto close_toast" onclick="toastclose('.toast')" data-bs-dismiss="toast" aria-label="Close"></button>
  </div>
</div>
	<? } ?>
    <div class="rounded-tringle pull-up77 rounded bg-primary vkg p-2">
	<div class="both-side-margin">
	<div class="my-2 fs-5">Sign in</div>
    <form method="post" autocomplete="off">
    <input type="hidden" name="token" id="token" value='<?=prntext($_SESSION['token_forgot'],0);?>' />
    <input type="hidden" name="token_sign" id="token_sign" value='<?=prntext($_SESSION['token_sign'],0);?>' />
        <div class="my-2 row-fluid">
          
          <div class="col-sm-12 input-field mt-4">
            <input type="text" class="form-control username"  name="username" title="Username" id="input_username" value="<?php if(isset($_COOKIE["adm_username"])) { echo $_COOKIE["adm_username"]; } ?>" autocomplete="disabled" required />
			<label for="input_username">Enter username</label>
			
          </div>
        </div>
        <div class="my-2 row-fluid">
           <?php /*?><span class="float-end">
<a href="<?=$data['Admins'];?>/forgot<?=$data['ex']?>?l=m"  class="text-link" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="Click here to reset password">Reset password?</a></span><?php */?>

          <div class="col-sm-12 input-field mt-4">
            <input type="password" class="form-control float-start password" name="password" title="password" id="pass_log_id" value="<?php if(isset($_COOKIE["adm_password"])) { echo $_COOKIE["adm_password"]; } ?>" autocomplete="disabled" required />
			<label for="pass_log_id">Enter password</label>
			<span toggle="#password-field" class="form-control55 text-center float-start text-center" style=" margin-left:-30px;"><i class="<?=$data['fwicon']['eye'];?> field_icon toggle-password text-link" style=" padding-top:11px;" title="Show password"></i></span>
          </div>
<label class="col-sm-12 col-form-label w-100 mt-2" for="exampleCheck1"><input type="checkbox" class="form-check-input" id="adm_remember" name="adm_remember" <?php if(isset($_COOKIE["adm_remember"])) { ?> checked="checked" <? } ?>> Remember me 

<?php /*?>
<span class="float-end">
<a href="<?=$data['Admins'];?>/forgot<?=$data['ex']?>?l=m"  class="text-link" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="Click here to reset password">Reset password?</a></span>
<?php */?>

</label>
        </div>
		<? if($data['UseTuringNumber']){ ?>
		<div class="my-2 row-fluid">
          <label for="staticEmail" class="col-sm-2 col-form-label"><strong>Turing Number:</strong></label>
          <div class="col-sm-12">
		  <img class="turing" src="<?=$data['Host']?>/turing.do" width="78" height="15" border="1" align="absmiddle">&nbsp;
            <input type="text" class="form-control" name="turing" title="turing" placeholder="Turing Number:" />
          </div>
        </div>
		<? } ?>
		
        <div class="my-2 row-fluid">
		
          <div class="col-sm-12 my-4">
           <button class="btn btn-primary my-2 login_account" type="submit" name="send" value="LOGIN NOW!" style="width:100%;">Admin Login</button>
          </div>
        </div>
        
      </form>
	  
	  
    </div>
	
	</div>

  </div>
</div>
<script>
$('.login_account').on('click', function () {

	if(($('.username').val()=="") || ($('.password').val()=="")){
	alert("Please Enter Username and password");
	return;
	}
	$(".login_account").html("<i class='<?=$data['fwicon']['spinner'];?> fa-spin-pulse'></i>");
});


$(document).ready(function(){
     setTimeout(function(){
       
        //$('#input_username').trigger('click');
       // $('#pass_log_id').trigger('click');
        $('body').trigger('click');
		 $('#input_username,#pass_log_id,body').trigger('focusout');
    }, 500);
	
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
</script>


<? }else{ ?>SECURITY ALERT: Access Denied <? } ?>
