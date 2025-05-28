<? if(isset($data['ScriptLoaded'])){?>

<?
//cmn 
	//$data['ccode']=encode_f('272',0); echo "<br/>ccode=>".$data['ccode']; $_SESSION['PostSent']=1;
?>
<? if((isset($data['Error'])&& $data['Error'] && !isset($data['ccode']) ) || ( !isset($_REQUEST['cid']) && !isset($_REQUEST['confirm'])  ) ){ ?>
<div class="container my-2 bg-light text-dark vkg" style="max-width:440px;">

  <div class="alert alert-danger alert-dismissible fade show" role="alert">
  <strong>Error!</strong> <?=prntext((@$data['Error'])?$data['Error']:'Incorrect confirmation URL');?>
  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
</div>

  <? } ?>
  

<?php if((isset($data['Email'])&&$data['Email']==true)&& (($_SESSION['PostSent']==5))){ ?>
	
	<div class="container-sm my-2" style="max-width:500px; margin:0 auto;">
    <div class="row-fluid mt-5">
    <div class="rounded-tringle pull-up77 bg-white vkg p-2 rounded">
	<div class="both-side-margin">
    <div class="my-2 fs-5">Confirm Your Email</div>
  
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
    </div>
    </div>
    </div>
<?php
exit;
}
?>
<? if(isset($_SESSION['PostSent'])&&$_SESSION['PostSent']!=1){ ?>
<div class="container my-2 border bg-light text-dark vkg" style="max-width:540px;">

  <h2 class="my-2">Confirm Your Email </h2>
	<div class="vkg-main-border2"></div>
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
<div class="container-sm my-2" style="max-width:500px; margin:0 auto;">
  
  
 
  <div class="row-fluid mt-5">
  
  <div class="rounded-tringle pull-up77 bg-white vkg p-2 rounded">
	<div class="both-side-margin">
	
	
  <div class="my-2 fs-5">Your Account Has Been Created</div>
  <div> <strong>Congrats! You have successfully registered. </strong>
     <p><br/>We are redirecting to <b><i> reset password</i></b> and continue the authorization process ... </p>
  </div>
  
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
	
  <div class="col text-center my-2 hide"> <a class="nopopup btn btn-outline-secondary" href="<?=$data['Host']?>/">Login</a> </div>
 	</div>
	</div> 
  
</div>

</div>

<? } ?>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
