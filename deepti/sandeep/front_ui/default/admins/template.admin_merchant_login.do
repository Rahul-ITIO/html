<??>

<style> 
 .admins .jqclock, 
 .tranStatDIVbar1 {display:none !important;} 
 .col-form-label {
  font-weight: normal !important;
 }
</style>
<style> .row {--bs-gutter-x: 1.5rem;} </style>

<? if(isset($data['ScriptLoaded'])){ ?>

<?php if((isset($data['Error'])) && ($data['Error']!='')){?>
<div class="container my-2" style="max-width:540px;">
  <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error! </strong>
    <?=prntext($data['Error'])?>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
</div>
	<? } ?>
<div class="container-sm my-2" style="max-width:500px; margin:0 auto;">
  <div class="row-fluid mt-5">
	<? if(isset($data['hdr_logo'])&&isset($domain_server['LOGO'])&&($data['hdr_logo'])&&($domain_server['LOGO'])){ ?>
	<div class="text-start mb-2">
	<a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>" class="img-fluid"><img src="<?=encode_imgf($domain_server['LOGO']);?>" style="height:50px;"></a>
	</div>
	<? } ?>
	
    <div class="rounded-tringle pull-up77 rounded bg-primary vkg p-2">
      
	<div class="both-side-margin">
    
	<div class="my-2 fs-5">Admin Merchant Login</div>
	
<form method="post">
<input type="hidden" name="token" id="token" value='<?=prntext($_SESSION['token_forgot'],0);?>' />
<input type="hidden" name="token_sign" id="token_sign" value='<?=prntext($_SESSION['token_sign'],0);?>' />
        <div class="my-2 row-fluid">
          <label for="staticEmail" class="col-sm-12 col-form-label"><strong class="f-waight">Admin Username</strong></label>
          <div class="col-sm-12">
            <input type="text" class="form-control"  name="username" title="Username" placeholder="Username"  value="<?=prntext(((isset($_SESSION['sub_username'])&&$_SESSION['sub_username'])?$_SESSION['sub_username']:$data['temp_login_admin']),12);?>" autocomplete="off" id="input_username"  <?=$data['disabled_frm'];?> />
			<label for="input_username">Admin Username</label>
          </div>
        </div>
		<div class="my-2 row-fluid">
          <label for="staticEmail" class="col-sm-12 col-form-label"><strong class="f-waight">Merchant Username</strong></label>
          <div class="col-sm-12">
            <input type="text" class="form-control"  name="m_username" title="Merchant Username" placeholder="Merchant Username"  value="<?=prntext(((isset($post['m_username'])&&$post['m_username'])?$post['m_username']:$data['merchant_admin_username']),12);?>" autocomplete="off" required <?=$data['disabled_frm'];?>  />
          </div>
        </div>
        <div class="my-2 row-fluid">
          <label for="staticEmail" class="col-sm-12 col-form-label"><strong class="f-waight">Admin Password</strong></label>
          <div class="col-sm-12">
            <input type="password" class="form-control" name="password" title="password" placeholder="Password" value="<?=prntext(((isset($post['password'])&&$post['password'])?$post['password']:''),12);?>" autocomplete="off" required/>
          </div>
        </div>
		
        <div class="my-2 row-fluid">
          <div class="col-sm-12">
           <button class="btn btn-primary my-2 submit_loader" type="submit" name="send" value="LOGIN NOW!" style="width:100%;">Sign in</button>
          </div>
        </div>
        
      </form>
    </div>

  </div>
</div>
<script>
$('.submit_loader').on('click', function () {
$(".submit_loader").html("<i class='<?=$data['fwicon']['spinner']?> fa-spin-pulse'></i>");
});
</script>


<? }else{ ?>SECURITY ALERT: Access Denied <? } ?>
