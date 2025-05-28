<? if(isset($data['ScriptLoaded'])){?>
<style>
body { background: var(--background-1) !important;
  width: auto; 
  height: auto; 
  font-weight: 400;
  font-style: normal;
  font-family: "Alike Angular", serif !important;
}
h1.text-primary {
    font-size: 36px;
}

.main_box{
    box-sizing: border-box;
    background-color: #fff;
    overflow: visible;
    border-radius: 30px 0px 30px 0px;
    border-color: <?=$_SESSION['background_gd5'];?>;
    border-style: solid;
    border-top-width: 20px;
    border-bottom-width: 1px;
	margin-top: 80px;
}
.box_text {
 
  font-size: 30px;
  letter-spacing: 0px;
  line-height: 1.2;
}
.h4, h4 {
    font-size: calc(1.275rem + .3vw) !important;
}
h1.text-primary {
    font-size: 25px  !important;
}
.form-control, .input-group-text, .form-select {
    background: var(--color-3) !important;
}
.h5, h5 {
    font-size: 12px  !important;
}
</style>

<?
//cmn 
	//$data['ccode']=encode_f('272',0); echo "<br/>ccode=>".$data['ccode']; $_SESSION['PostSent']=1;
?>
<? if((isset($data['Error'])&& $data['Error'] && !isset($data['ccode']) ) || ( !isset($_REQUEST['cid']) && !isset($_REQUEST['confirm'])  ) ){ ?>
	<div class="container my-2 main_box" style="max-width:400px;">
	  <div class="alert alert-danger alert-dismissible fade show my-2" role="alert">
		  <strong>Error!</strong> <?=prntext((@$data['Error'])?$data['Error']:'Incorrect confirmation URL');?>
		  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		</div>
	</div>
<? } ?>
  
<?php if((isset($data['Email'])&&$data['Email']==true)&& (($_SESSION['PostSent']==5))){ ?>

<div class="container my-2 main_box" style="max-width:540px;">
  <h2 class="mt-2 mb-2">Confirm Your Email </h2>
	<div class="vkg-main-border2"></div>
  <? if($data['Error']){ ?>
  
  <div class="alert alert-danger alert-dismissible fade show" role="alert">
  <strong>Error!</strong> <?=prntext($data['Error'])?>
  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>

  <? }else { ?>
 
	<div class="alert alert-success alert-dismissible fade show" role="alert">
    <strong>Congrats!</strong> You have successfully activated your newly added e-mail address.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>

  <? } ?>
</div>
<?php
exit;
}
?>
<? if(isset($_SESSION['PostSent'])&&$_SESSION['PostSent']!=1){ ?>
<div class="container my-2 main_box" style="max-width:400px;">

  <h2 class="my-2 text-center fs-5">Confirm Your Email </h2>
  <form method="post">
    <div class="my-2 row">
      <label for="staticEmail" class="col-sm-12 col-form-label">Please Enter Your Confirmation Code</label>
      <div class="col-sm-12">
        <input type="text" class="form-control" name="cid"  value="<?=((isset($post['cid']) &&$post['cid'])?$post['cid']:'')?>" autocomplete="off" required/>
      </div>
    </div>
    <div class="my-2 row">
      <div class="col-sm-12">
        <button class="btn btn-primary" type="submit" name="confirm" value="CONTINUE REGISTRATION!" style="width:100%;">Continue</button>
      </div>
    </div>
  </form>


</div>

<? }elseif(isset($_SESSION['PostSent'])&&$_SESSION['PostSent']==1){ ?>
<div class="container my-2 main_box" style="max-width:400px;">
  <h2 class="my-2 text-center fs-5">Your Account Has Been Created</h5>
  <div class="alert bg-vlight alert-dismissible fade show" role="alert"> <strong>Congrats! You have successfully registered. </strong>
    <p><br/>We are redirecting to <b><i> reset password</i></b> and continue the authorization process ... </p>
	
	
	<?
	if(isset($data['ccode'])&&trim($data['ccode'])){
		?>
		<script>
			setTimeout( function(){ 
				top.window.location.href="<?=$data['Host']?>/reset_password<?=$data['ex']?>?c=<?=$data['ccode']?>";
			},3000 );
		</script>
	<?}
	?>

	
	<div class="col text-center my-2 hide"> <a class="nopopup btn btn-primary " href="<?=$data['Host']?>/">Login</a> </div>
  </div>
  
</div>
<? } ?>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
