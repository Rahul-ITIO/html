<? if(isset($data['ScriptLoaded'])){?>
<?
if((!isset($_SESSION['login_adm']))&&($_SESSION['sub_admin_id']!=$_GET['id'])&&($_GET['id'])){
  echo $data['OppsAdmin'];
  exit;
}
?>

<div class="container border bg-primary text-white my-1 rounded" >
  <div class=" container vkg">
    <h4 class="my-2"><i class="<?=$data['fwicon']['shield'];?>"></i> Security Settings :: Update Password</h4>
    <div class="vkg-main-border"></div>
  </div>
  <div class="row my-2  border m-1 rounded" >
    
	<? if ((isset($data['Error'])) && (!isset($post['change2way']))){ ?>
	<div class="row">
    <div class="alert alert-danger alert-dismissible fade show my-2" role="alert">
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      <strong>Error!!</strong>
      <?=prntext($data['Error'])?>
    </div>
	</div>
    <? } ?>
    <? if(!$data['PostSent']){ ?>
    <form method="post">
      <div class="tab-pane active row-fluid" id="account-settings">
        <?php 
$turl= $_SERVER['REQUEST_URI'];


	

if(!strpos($turl, 'id=')){
 ?>
        <div class="my-2 row">
          <label for="staticEmail" class="col-sm-4 col-form-label">Old Password:</label>
          <div class="col-sm-8">
            <input type="password" name="opass" id="password" class="form-control" value="<? if(isset($post['opass'])) echo $post['opass']?>" oninvalid="this.setCustomValidity('Please Enter Old Password')" oninput="setCustomValidity('')" required />
          </div>
        </div>
        <? }?>
        <div class="my-2 row">
          <label for="staticEmail" class="col-sm-4 col-form-label">New Password:</label>
          <div class="col-sm-8">
            <input type="password" name="npass" id="password1" class="form-control" value="<? if(isset($post['npass'])) echo $post['npass']?>" oninvalid="this.setCustomValidity('Please Enter New Password')" oninput="setCustomValidity('')" required />
          </div>
        </div>
        <div class="my-2 row">
          <label for="staticEmail" class="col-sm-4 col-form-label">Confirm Password:</label>
          <div class="col-sm-8">
            <input type="password" name="cpass" id="password2" class="form-control" value="<? if(isset($post['cpass'])) echo $post['cpass']?>" oninvalid="this.setCustomValidity('Please Enter Confirm Password')" oninput="setCustomValidity('')" required />
          </div>
        </div>
        <div class="my-2 row">
          <div class="col-sm-12 text-center">
            <button type="submit" name="change" value="CHANGE NOW!"  class="btn btn-icon btn-primary"><i class="far fa-check-circle"></i> Save changes</button>
          </div>
        </div>
        <div class="row valiglyph my-2">
          <div class="col-sm-2"><span id="8char" style="color:#FF0004;"><i class="<?=$data['fwicon']['circle-cross'];?>"></i></span> 10 Characters Long</div>
          <div class="col-sm-2"><span id="ucase" style="color:#FF0004;"><i class="<?=$data['fwicon']['circle-cross'];?>"></i></span> One Uppercase Letter</div>
          <div class="col-sm-2"><span id="lcase" style="color:#FF0004;"><i class="<?=$data['fwicon']['circle-cross'];?>"></i></span> One Lowercase Letter</div>
          <div class="col-sm-2"><span id="num"  style="color:#FF0004;"><i class="<?=$data['fwicon']['circle-cross'];?>"></i></span> One Number</div>
          <div class="col-sm-4"><span id="pwmatch"  style="color:#FF0004;"><i class="<?=$data['fwicon']['circle-cross'];?>"></i></span> Passwords Match</div>
        </div>
      </div>
    </form>
    <script>

$("input[type=password]").keyup(function(){
    var ucase = new RegExp("[A-Z]+");
	var lcase = new RegExp("[a-z]+");
	var num = new RegExp("[0-9]+");
	
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
	   if($("#password1").val() ==""){ return false;}
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
<? if(isset($post['npass'])&&$post['npass']){?>
$('input[type=password]').trigger('keyup');
<? }?>

$(document).ready(function() {
	 $('#password1,#password2').bind('copy paste cut',function(e) { 
		 e.preventDefault(); //disable cut,copy,paste
		 alert('cut,copy & paste options are disabled !!');
	 });
});
</script>
  </div>
  <div class=" container vkg">
    <h4 class="my-2"><i class="<?=$data['fwicon']['shield'];?>"></i> 2 Way Authentication Access</h4>
    <div class="vkg-main-border"></div>
  </div>
  <div class="well row border vkg m-1 my-2 rounded">
    <form method="post">
      <div class="row-fluid">
        <? if(isset($post['change2way'])&&$post['change2way']){?>
        <?php if ($data['Error']) {?>
        <div class="alert alert-danger alert-dismissible fade show my-2" role="alert">
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
          <strong>Error!</strong>
          <?=prntext($data['Error'])?>
        </div>
        <? }else { ?>
        <div class="alert alert-success alert-dismissible fade show my-2" role="alert">
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
          <?php
		 if ($post['google_auth_access']==2){
		 ?>
          <strong>Success!</strong> 2-Step Authentication Status Updated.
          <?php }else  {?>
          <strong>Success!</strong> 2-Step Authentication Access (Google) Has Been Updated. Kindly scan in 'Google Authenticator' app in mobile. Because it show in one time as per your request.
          <?php } ?>
        </div>
        <? }?>
        <? 
		
		  if($_SESSION['qrCodeUrl']){
		  if ((!strpos($turl, 'id=')) && ($_SESSION['adm_login']!=true)){?>
        <div id="img" style="text-align: center;"> <img src='<?php echo $_SESSION['qrCodeUrl'];?>' /> </div>
        <? unset($_SESSION['qrCodeUrl']); }?>
        <? }
	}
	?>
        <?php


	if (!strpos($turl, 'id=')){
?>
        <div class="my-2 row">
          <div class="col-sm-4 col-form-label">Current Password:</div>
          <div class="col-sm-8">
            <input type="password" name="currentPassword" id="currentPassword" class="form-control" value="<? if(isset($post['currentPassword'])) echo $post['currentPassword']?>" title="Current Password" oninvalid="this.setCustomValidity('Please Enter Current Password')" oninput="setCustomValidity('')" required />
          </div>
        </div>
        <? } ?>
        <div class="my-2 row">
          <div class="col-sm-4 col-form-label">Authentication (Google):</div>
          <div class="col-sm-8">
            <select name="google_auth_access" id="google_auth_access" data-rel="chosen" class="form-select" style="height:36px" >
              <option value="">- 2 Way Auth. Yes/No -</option>
              <option value="2">De-activate</option>
              <option value="1">Activate</option>
              <option value="3">QR-Code Reset</option>
            </select>
            <br>
            <!--<small><a href="#2step">(Click to know more about 2-step authentication.)</a></small>-->
               <?
				if(isset($post['google_auth_access']))
				{
				?>
				<script>
                    $('#google_auth_access option[value="<?=prntext($post['google_auth_access'])?>"]').prop('selected','selected');
                </script>
				<?
				}
				?>
          </div>
        </div>
        <div class="my-2 row">
          <div class="col-sm-12 text-center">
            <button type="submit" name="change2way" value="CHANGE NOW!"  class="btn btn-icon btn-primary"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Save changes</button>
          </div>
        </div>
      </div>
    </form>
    
  </div>
  <!--<div id="2step" class="step2 m-1 my-2">
  <div class=" container vkg">
    <h4 class="my-2"><i class="fab fa-google"></i> Google 2-Step Authentication</h4>
    <div class="vkg-main-border"></div>
  </div>
      <div class="mx-2">
      <p>With 2-Step Verification (also known as two-factor authentication), you add an extra layer of security to your account. After you enable it, you’ll sign in to your account in two steps using:</p>
      <p> <strong>(1)</strong> For Sign-in (Log-in), you'll enter your password as usual.<br>
        <strong>(2)</strong> A Security key will be sent to your phone and you need to enter that key into the system.</p>
      <p>To use the 2-step authentication, you need to download the <a href="https://en.wikipedia.org/wiki/Google_Authenticator" target="_blank"><strong>'Google Authenticator'</strong></a> mobile app to your phone. After enabling the 2-setp authentication from your account, for the first time when you do login, a QR code will be displayed and you will have to scan the code through that APP. By next time, the QR code will not be displayed, but the Security Key will be sent to your downlaoded APP.</p>
      <p>To reset the QR code and/or to disable the code, you may process the request from inside your account's security area. Every time, you enable the 2-step authentication code, the QR code will be re-set.</p>
      <p>To know more about, you may visit following links:</p>
      <p><strong>1) Why You need it:</strong> <a href="https://www.google.com/landing/2step/" target="_blank">https://www.google.com/landing/2step/</a></br>
        <strong>2) How it works:</strong> <a href="https://www.google.com/landing/2step/#tab=how-it-works" target="_blank">https://www.google.com/landing/2step/#tab=how-it-works</a><br>
        <strong>3)YouTube Video:</strong> <a href="https://www.youtube.com/watch?v=mVIxzH4EWmA" target="_blank">https://www.youtube.com/watch?v=mVIxzH4EWmA</a> </p>
      <center>
        <h4>Get Google Authenticator APP on your phone</h4>
        <a href="https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&hl=en"
         target="_blank"><img class="app" src="../images/android.png" width="150" /></a> &nbsp;&nbsp; <a href="https://itunes.apple.com/us/app/google-authenticator/id388497605?mt=8"
         target="_blank"><img class='app' src="../images/iphone.png" width="150" /></a>
      </center>
	  </div>
	  
    </div>-->
</div>
</div>
<? }else{ ?>
<div class="container border bg-white" >
  <div class="row mt-2 vkg border" >
    <h4><i class="<?=$data['fwicon']['shield'];?>" aria-hidden="true"></i> <a href="<?=$data['Admins'];?>/index<?=$data['ex']?>"><i class="fas fa-home"></i>
      <?=prntext($data['SiteName'])?>
      Edit Profile</a></h4>
    <div class="alert alert-success alert-dismissible fade show" role="alert"> <strong>Success!</strong> Password Updated.
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <div class="container my-2"> <a class="btn btn-primary" href="<?=$data['Admins'];?>/password<?=$data['ex']?>">Back</a> <a class="btn btn-primary" href="<?=$data['Admins'];?>/index<?=$data['ex']?>">Account Overview</a> </div>
  </div>
</div>
<? }?>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
