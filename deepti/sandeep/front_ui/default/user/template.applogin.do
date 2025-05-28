<?php
include("domain_server.do");
$domain_server=$_SESSION['domain_server'];
//print_r($domain_server);
?>
<style>
body, .csstransitions, .signin_d, #wrapper, form, .body_contant, #content, .table_div, .container-fluid.fixed {background-color:#fff !important;background:#fff !important;}
.container-fluid.fixed {border:0 !important;background:none !important; }

.conten_div {position:fixed;z-index:99;left:50%;top:50%;width:200px;height:350px;margin:-175px 0 0 -100px;}

.well, .navbar.main {display:none;}

.well.signinform {display:block;
background: transparent;
}
.signin_h {display:none;}

.formsdiv {height:230px;display:block;width:200px;margin:0 auto;}
h4{font-weight:normal;font-size:10px;white-space:nowrap;margin:0px !important;}

.logoa img.logoimg {margin-left:3px;height:90px;margin-bottom:10px;}
.btn-primary {width:92%;border-radius:10px;}

.btn-primary.glyphicons i:before {
    display: inline-block;
    text-align: center;
    color: #fff;
    margin: 0px 5px 0 0;
    font-size: 16px;
    position: relative;
    top: 2px;
}
.w92{text-align: center;
    width: 92%;
    display: block;
    margin: 5px auto 0 auto;}
.signin_d{height:73px;}

<?if($data['Error']){?>
	.well.signinform {display:block;}
	.signin_h {display:none;}
<?}?>

#recaptcha_response_field{
	background-color: #ffffff !important;
	min-width:153px;
}
@media(max-width:767px){#use{height:12px;}#pas{width:80%!important;}.pull-right{float:left;padding-bottom:10px;}.md{padding:25px 0!important;}}
</style>
<script type="text/javascript">
$(document).ready(function(){ 
	
	$(".signin").click(function(){
		$('.signinform').slideDown(1500);
		$(".signin_h").slideUp(100);
	});
	
	
    //alert(screen.width+" x "+screen.height);
});
/*
$(window).bind("load resize scroll",function(e){
	
});*/
$(window).on("load resize scroll",function(e){
    $("#content").attr('style','min-height: '+screen.height+'px;');
});
</script>
<link rel=stylesheet type=text/css href="http://propertycarrots.com/epaycustom/css/style.css">
<link rel="stylesheet" type="text/css" href="http://propertycarrots.com/epaycustom/css/keyboard.css">
<script type="text/javascript" language="JavaScript" src="http://propertycarrots.com/epaycustom/js/keyboard.js"></script>
<?if(isset($data['ScriptLoaded'])){?>
<?if(!$data['PostSent']){?>
<?if(!isset($data['CantLogin'])){?>
<form method=post>
<div id="wrapper">
<div id="menu" class="hidden-phone">
  <div id="menuInner">
    <ul>
    </ul>
  </div>
</div>
<div id="content" style="min-height: 680px;">
<div class="conten_div">
<div class="separator"></div>
<div class="heading-buttons tophead" style="text-align:center;"> <a class="appbrand logoa" style="display:block !important;"><img src="<?=$domain_server['LOGO'];?>" class="logoimg"></a>
  <h4 class=""><i></i> Log In To Your Merchant Dashboard</h4>
  <div class="clearfix" style="clear: both;"></div>
</div>
<div class="formsdiv">
<div class="signinform">
<? if(isset($data['pinsmssend'])) {  ?>
<div class="widget widget-4">
  <div class="widget-head">
    <h4 class="heading">Restricted area </h4>
  </div>
</div>
<?if($data['Error']){?>
<div class="alert alert-error">
  <button type="button" class="close" data-dismiss="alert">&times;</button>
  <strong>Error!</strong>
  <?=prntext($data['Error'])?>
</div>
<?}?>
<form method=post>
  <input type="hidden" name=username size=10 maxlength=128 value="<?=prntext($post['username'])?>">
  <input type="hidden" style="background:none;width:60%;" name=password size=10 maxlength=128 value="<?=prntext($post['password'])?>">
  <div class="uniformjs">
    <label for="Username">Varification PIN send on your registered phone number</label>
    <br />
    <label for="Username">Enter Generated PIN (*):</label>
    <input type=text name=sessionpin  style="background:none" placeholder="Enter Pin Here" class="input-block-level span4" value="<?=prntext($post['sessionpin'])?>">
  </div>
  <button class="btn btn-primary" type="submit"  name=validate value="Log Me In">VALIDATE & LOGIN</button>
</form>
<? die();}  ?>
<?if(isset($data['Error'])){?>
<div class="alert alert-error">
  <button type="button" class="close" data-dismiss="alert">&times;</button>
  <strong>Error!</strong>
  <?=prntext($data['Error'])?>
</div>
<?}?>
<?/*?><div class="widget widget-4">
			<div class="widget-head">
				<h4 class="heading">Restricted area 11</h4>
			</div>
		</div>
                     <?*/?>
<div class="heading-buttons" style="padding:10px 0 15px 0;;" >
  <div class="w92" style="display:none;" > <a href="" class="btn btn-block btn-default" style="padding:7px;font-size:11px;"> MERCHANT LOGIN (ATTEMPT #
    <?=prnintg($data['attempts'])?>
    , MAX.
    <?=prnintg($data['PassAtt'])?>
    ) </a> </div>
  <h4 class="glyphicons unlock form-signin-heading" style="display:none"><i></i> Please sign in </h4>
  <div class="w92" style="margin-top:25px;">
    <div class="uniformjs">
      <label for="Username" style="display:none">Username / MID</label>
      <input type="text" style="background:none;height:40px;border-radius: 10px;width:100% !important;" name="username" id="use" placeholder="Username" class="input-block-level span4" value="<?if(isset($post['username'])){echo prntext($post['username']);}?>" />
      <label for="Password" style="display:none">Password</label>
      <input type="password" style="background:none;height:40px;border-radius: 10px;width:100% !important;" name="password"  id="pas" class="keyboardInput input-block-level span4" placeholder="Password" value="<?if(isset($post['username'])){echo prntext($post['password']);}?>" />
      <label class="checkbox" style="text-align:left; display:none !important;">
      <input type="checkbox" value="remember-me" checked style="display:none">
      Remember me</label>
    </div>
  </div>
  <div style="margin:0;text-align:center;">
    <button class="btn btn-primary glyphicons unlock" type="submit" name="send" value="Log Me In" style="margin-top:13px;"><i></i>SIGN IN</button>
  </div>
  </form>
</div>
</div>
</div>
</div>
</div>
<?}else{?>
<div id="wrapper" style="height:480px">
<div id="menu" class="hidden-phone">
  <div id="menuInner">
    <ul>
    </ul>
  </div>
</div>
<div id="content">
  <ul class="breadcrumb">
    <li><a href="<?=$data['Host']?>/welcomeapp<?=$data['ex']?>" class="glyphicons home"><i></i>
      <?=prntext($data['SiteName'])?>
      </a></li>
    <li class="divider"></li>
    <li>Login</li>
  </ul>
  <div class="separator"></div>
  <div class="heading-buttons">
    <h3 class=""><i></i> Log In To Your Merchanr Dashboard</h3>
    <div class="clearfix" style="clear: both;"></div>
  </div>
  <div class="separator"></div>
  <div class="well" style="background:#fff;margin-bottom:0px">
    <?if($data['Error']){?>
    <div class="alert alert-error">
      <button type="button" class="close" data-dismiss="alert">&times;</button>
      <strong>Error!</strong>
      <?=prntext($data['Error'])?>
    </div>
    <?}?>
    <div class="widget widget-4">
      <div class="widget-head">
        <h4 class="heading">Restricted area </h4>
      </div>
    </div>
    <div class="alert alert-error">
      <button type="button" class="close" data-dismiss="alert">&times;</button>
      <strong>Error!</strong> You have entered a wrong password 3 times. Forgot Your Password? Click the link below to be reminded. </div>
    <?}?>
  </div>
  <div class="signin_d">
    <div class="form-actions signin_h" style="margin:0;text-align: center;"> <a class="btn btn-primary signin glyphicons unlock" value="Log Me In"><i></i>SIGN IN</a> </div>
  </div>
  <div class="form-actions" style="margin:0;text-align:center;display:none;"> <a class="btn btn-primary forgotpassword glyphicons keys" value="Forgot Password"><i></i> FORGOT PASSWORD?</a> </div>
  <?}else{?>
  <?}?>
  <?}else{?>
  SECURITY ALERT: Access Denied
  <?}?>
</div>
