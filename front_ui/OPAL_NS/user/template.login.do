<?
?>
<? $domain_server=@$_SESSION['domain_server']; ?>
<? if(isset($data['ScriptLoaded'])){ ?>

<style>
body { background: var(--background-1) !important;
  width: auto; 
  height: auto; 
  font-weight: 400;
  font-style: normal;
  font-family: "Alike Angular", serif !important;
}


.main_box{
    box-sizing: border-box;
    background-color: #fff;
    overflow: visible;
	/*border-radius: 30px 0px 0px 30px;*/
	border-radius: 0px 30px 30px 30px;
	box-shadow: 0px 5px 10px 0px rgba(0, 0, 0, 0.5);
    border-color: <?=$_SESSION['background_gl5'];?>;
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
    font-size: 20px  !important;
}
h1.text-primary, h1.text-white  {
    font-size: 25px  !important;
}
.form-control, .input-group-text, .form-select {
    background: var(--color-3) !important;
}
.h5, h5 {
    font-size: 12px  !important;
}
</style>

<? if((!isset($data['PostSent']) || empty($data['PostSent']))){ ?>
<? if((!isset($data['CantLogin']) || empty($data['CantLogin']))){ ?>
<? if((isset($data['Error'])&& $data['Error'])){ ?>

<div class="container my-2" style="max-width:400px; margin:0 auto;"><!--style="max-width:400px;"-->
  <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error ! </strong>
    <?=prntext($data['Error'])?>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
</div>
<? } ?>

<? if((isset($_SESSION['errmsg'])&& $_SESSION['errmsg'])){ ?>

<div class="container my-2" style="max-width:400px; margin:0 auto;"><!--style="max-width:400px;"-->
  <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error ! </strong>
    <?=prntext($_SESSION['errmsg'])?>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
</div>
<? unset($_SESSION['errmsg']); } ?>

 <? if(isset($_SESSION['action_success'])){ ?>
	<div class="alert alert-success alert-dismissible fade show" role="alert">
      <?=($_SESSION['action_success']);?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
	 <? if(isset($_SESSION['action_success'])){$_SESSION['action_success']=0;unset($_SESSION['action_success']);} ?>
 <? }?>

<div class="container my-2" >
<div class="row my-2">

<div class="col-sm-7">
  <div class="container w-75">
  
    <? if($domain_server['LOGO']){ ?>
	<div class="text-start mt-3">
    <a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>" class="img-fluid"><img src="<?=encode_imgf($domain_server['LOGO']);?>" style="height:50px;"></a>
	</div>
    <? } ?>
	
	<div class="my-2 box_text">
	<h1 class="text-white">Apply your Merchant Account<br/>
	Accept card payments now
	</h1>
	<h4 class="my-2 text-vlight">It takes few minutes to register. Please keep the following details handy.</h4>
	</div>
	
	<div class="my-3 text-white"><i class="fas fa-check"></i> Legal name</div>
	<div class="my-3 text-white"><i class="fas fa-check"></i> Legal address</div>
	<div class="my-3 text-white"><i class="fas fa-check"></i> Company Name</div>
	
	</div>
  </div>
  
<!--<div class="container-sm my-2" style="max-width:400px; margin:0 auto;">-->
<div class="col-sm-5 ">


    <div class="main_box pull-up p-2">
	
	<? if(@$data['attempts']>=1) { ?>
	
        <div class="alert alert-warning my-2" role="alert"> Merchant Login (Attempt #
        <?=((isset($data['attempts'])&&$data['attempts'])?$data['attempts']:'')?>, Max. <?=prnintg($data['PassAtt'])?> ) 
        </div>
		
	<? } ?>
	
    
	<h2 class="my-2 text-center fs-5">Welcome Merchant !!</h2>
	<div class="col my-2 mx-3 text-center"> <a href="<?=$data['Host'];?>/reset-password<?=$data['ex']?>"> Reset password?</a> Not Merchant? <a href="<?=$data['Host']?>/signup<?=$data['ex']?>">Sign Up Here</a></div>
	
      <form method="post" autocomplete="off">
        <input type="hidden" name="token" id="token" value='<?=prntext($_SESSION['token_forgot'],0);?>' />
        <input type="hidden" name="token_sign" id="token_sign" value='<?=prntext($_SESSION['token_sign'],0);?>' />
		<div class="mx-3 row">
		
        <div class="row-fluid">
          <label for="staticEmail" class="col-sm-2 col-form-label"><strong>Username</strong></label>
          <div class="col-sm-12">
            <input type="text" class="form-control"  name="username" title="Username" placeholder="Enter Username"  value="<?php  if(isset($post['username'])){ echo prntext($post['username'],12);} ?>" autocomplete="off" required/>
          </div>
        </div>
        <div class="row-fluid">
          <label for="staticEmail" class="col-sm-2 col-form-label"><strong>Password</strong></label>
          <div class="col-sm-12">
            <input type="password" class="form-control" name="password" title="password" placeholder="Enter Password" value="" autocomplete="off" required/>
          </div>
        </div>
		
		<div class="row-fluid">
          
		<div class="form-check mt-2">
		<input class="form-check-input" type="checkbox" value="" id="flexCheckChecked" checked>
		<label class="form-check-label" for="flexCheckChecked">
		Remember Me
		</label>
		</div>

        </div>
        <div class="row-fluid">
          <div class="col-sm-12 text-center">
            <button class="btn btn-primary w-75 my-2" type="submit" name="send" value="Log Me In">Sign in</button>
          </div>
        </div>
        </div>
      </form>
    </div>


  <? $domain_server=$_SESSION['domain_server']; ?>
  
    <?php /*?><? if($domain_server['STATUS']==true){ ?>
	<div class="helpline my-2 ">
	<? if($domain_server['customer_service_no']){ ?><a href="tel:<?=$domain_server['customer_service_no'];?>" class="mx-2" title="Customer Service No."><i class="fas fa-headphones"></i> <?=$domain_server['customer_service_no'];?></a> <? } ?>
	<? if($domain_server['customer_service_email']){ ?><a target='_blank' title="Customer Service Email" href="mailto:<?=$domain_server['customer_service_email']?>?subject=I need help&body=Dear <?=$data['SiteName'];?>, I need your help about ..." class="mx-2" ><i class="fas fa-envelope"></i> <?=$domain_server['customer_service_email'];?></a><? } ?> 
	</div>
	<? } ?><?php */?>
	
</div>

</div>
</div>


<? }else{ ?>
<div class="container my-2 main_box" style="max-width:400px; margin:0 auto;">
  <h2 class="my-2 text-center fs-5">Suspicious Login Alert </h2>
  <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Restricted Area! </strong> <br />
    Enter Wrong login details <strong><?php echo $data['PassAtt'];?></strong> times. <br />
    Your accout is blocked for next <strong>30 minutes</strong> by now.

  </div>
  <div class="col text-center text-vdark"> <a href="<?=$data['Host'];?>/reset-password<?=$data['ex']?>">Reset password?</a> Not Merchant? <a href="<?=$data['Host']?>/signup<?=$data['ex']?>"> Register Here</a> </div>
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
</script>
