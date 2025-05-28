<?
?>
<? if(isset($data['ScriptLoaded'])){ ?>
<? if($post['step']==1){ ?>
<? if($data['Error']){ ?>

<div class="container mt-3" style="max-width:540px;">
  <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error!</strong>
    <?=prntext($data['Error'])?>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
</div>
<? } ?>
<div class="container-sm mt-5" >
  <div class="row">
    <!--<div class="col-sm-4"> &nbsp; </div>-->
    <div class="border rounded bg-white vkg p-2" style="max-width:400px; margin:0 auto;">
      <h4 class="my-2 text-primary">Forgotten Password</h4>
	<div class="vkg-main-border2"></div>
      <p>If you do not remember your password just supply your user name and we will send the password to your email.</p>
      <form method="post">
        <input type="hidden" name="token" value='<?=prntext($_SESSION['token_forgot'],12);?>' />
        <input type="hidden" name="step" value="<?=prntext($post['step'])?>">
        <div class="mb-3 row">
          <label for="staticEmail" class="col-sm-6 col-form-label"><strong>User Name</strong></label>
          <div class="col-sm-12">
            <input type="text" class="form-control"  name="email" title="User Name" placeholder="Enter Your User Name" value="<?=prntext($post['email'])?>" autocomplete="off" required/>
          </div>
        </div>
        <div class="mb-3 row">
          <div class="col-sm-12">
            <button class="btn btn-primary" id="btn-confirm" name="send" value="PLACE ORDER" type="submit" style="width:100%;">SEND ME THE PASSWORD</button>
          </div>
        </div>
        <div class="col text-center my-2 text-success"> <i class="fas fa-user-lock"></i> <a href="<?=$data['Host'];?>/login<?=$data['ex']?>"><strong>Login?</strong></a>  Not a clients? <i class="fas fa-user-plus"></i> <a href="<?=$data['Host']?>/signup<?=$data['ex']?>"><strong>Register Here</strong></a></div>
      </form>
    </div>
    <!--<div class="col-sm-4"> &nbsp; </div>-->
  </div>
</div>
<? }elseif($post['step']==5){ ?>
<? if($data['Error']){ ?>
<div class="container mt-3" style="max-width:540px;">
  <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error!</strong>
    <?=prntext($data['Error'])?>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
</div>
<? } ?>
<div class="container-sm mt-5" >
  <div class="row">
    <div class="col-sm-4"> &nbsp; </div>
    <div class="col-sm-4 border vkg">
	   <h2 class="mt-2 mb-2">Forgotten Password (STEP #2)</h2>
	<div class="vkg-main-border2"></div>
      <p>If you forget your password, we will ask your Company Name you submit below. Please, try to find a personal Company Name and Website URL which you know.</p>
      <form method="post">
        <input type="hidden" name="token" value='<?=prntext($_SESSION['token_forgot'],12);?>' />
        <input type=hidden name=step value="<?=prntext($post['step'])?>">
        <div class="mb-3 row">
          <label for="staticEmail" class="col-sm-4 col-form-label">Company Name (*):</label>
          <label for="staticEmail" class="col-sm-8 col-form-label"><font color=red><b>
          <?=prntext($post['question'])?>
          </b></font></label>
        </div>
        <div class="mb-3 row">
          <label for="staticEmail" class="col-sm-6 col-form-label">Website URL(*):</label>
          <div class="col-sm-12">
            <input type="text" class="form-control"  name="answer" placeholder="Enter Your User Name"  value="<?=prntext($post['answer'])?>" autocomplete="off" required/>
          </div>
        </div>
        <div class="mb-3 row">
          <div class="col-sm-6">
            <input type="submit" class="btn btn-primary" name="cancel" value="BACK" style="width:100%;">
          </div>
          <div class="col-sm-6">
            <input type="submit" class="btn btn-primary submit" name="send" value="CONTINUE">
          </div>
        </div>
        <div class="col text-center text-success text-success"> <i class="fas fa-user-lock"></i> <a href="<?=$data['Host'];?>/login<?=$data['ex']?>" class="my-2">Login?</a>  Not a clients? <a href="<?=$data['Host']?>/signup<?=$data['ex']?>" ><strong>Register</strong></a></div>
      </form>
    </div>
    <div class="col-sm-4"> &nbsp; </div>
  </div>
</div>
</center>
<? }elseif($post['step']==2){ ?>
<div class="container mt-3" style="max-width:540px;">
  <div class="alert alert-success alert-dismissible fade show" role="alert"> <strong>Success!</strong> New password has been sent to registered email ID:
    <?=$_SESSION['memail'];?>
  </div>
</div>
<div class="col text-center"> <a class="nopopup btn btn-outline-success" href="<?=$data['Host'];?>/login<?=$data['ex']?>">Login Now</a>&nbsp;<a class="nopopup btn btn-outline-secondary" href="<?=$data['Host'];?>/index<?=$data['ex']?>">Back Home</a> </div>


<? } ?>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
</div>
