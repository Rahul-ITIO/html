<? if(isset($data['ScriptLoaded'])){ ?>
<? ((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>


<? if(!$data['PostSent']){ ?>
<div id="zink_id" class="container border mt-2 mb-2 bg-primary clearfix_ice rounded" >
  <form method="post">
    <input type="hidden" name="token" value='<?=prntext($_SESSION['token_email'],0);?>' />
    <div class="container mt-2 px-0" >
      <? 
	if(isset($_SESSION['msgerror'])){ ?>
      <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error !</strong>
        <?=$_SESSION['msgerror'];?>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
      <? unset($_SESSION['msgerror']);}
	
	if(isset($data['error'])){ ?>
      <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error !</strong>
        <?=prntext($data['error'])?>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
      <? }elseif((isset($_SESSION['msgaddnow'])) and (!isset($_SESSION['msgdeletebtn'])) ) { ?>
      <div class="alert alert-success alert-dismissible fade show" role="alert"> <strong>Success!</strong> Your new e-mail address has been successfully Added. Check your e-mail to activate it.
        <button type="button" class="btn-close" data-bs-dismiss="alert" onclick="removesess(1)" aria-label="Close"></button>
      </div>
      <? unset($_SESSION['msgaddnow']); }elseif(isset($_GET['c'])) { ?>
      <div class="alert alert-success alert-dismissible fade show" role="alert"> <strong>Success!</strong> Your new e-mail address has been sucessfully activated.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
      <? }elseif((isset($_POST['primbtn'])) or (isset($_SESSION['msgprimbtn']))) { ?>
      <div class="alert alert-success alert-dismissible fade show" role="alert"> <strong>Success!</strong> Your e-mail address has been sucessfully changed to primary.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
      <? unset($_SESSION['msgprimbtn']); } elseif((isset($_SESSION['msgdeletebtn']))) { ?>
      <div class="alert alert-success alert-dismissible fade show" role="alert"> <strong>Success!</strong> Your e-mail has been successfully deleted.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
      <? unset($_SESSION['msgdeletebtn']);unset($_SESSION['msgaddnow']); 
	} 
	
	?>
    </div>
    <? if(isset($post['addnow'])||isset($post['add'])) { ?>
    <div class="container-flex my-2 text-white was-validated" >
      <div class="my-2 vkg">
        <h4><i class="<?=$data['fwicon']['email'];?>"></i> Add New Email Address</h4>
        <div class="col-sm-12 input-field mt-4">
          <input type="email" class="form-control is-invalid" name="newmail"  value="<?=prntext(((isset($post['newmail']) &&$post['newmail'])?$post['newmail']:''));?>" autocomplete="off" title="Enter new email address" data-bs-toggle="tooltip" data-bs-placement="right" style="max-width:350px;" id="input_newmail" required/>
		  <label for="input_username">Email Address</label>
        </div>
      </div>
      <div class="my-2 row">
        <div class="col-sm-12 text-left m_role">
          <button class="btn btn-primary btn-sm" type="submit" name="addnow" value="Add" ><i class="<?=$data['fwicon']['check-circle'];?>" aria-hidden="true"></i> Submit</button>
          <a href="<?=$data['USER_FOLDER']?>/emails<?=$data['ex']?>" class="btn btn-primary btn-sm"><i class="<?=$data['fwicon']['back'];?>"></i> Back</a>
          <!--Add New Email-->
        </div>
      </div>
    </div>
    <? }else{ ?>
    <div class="container-flex my-2 table-responsive vkg" style="max-width:350px;">
      <h4 class="float-start my-2"><i class="<?=$data['fwicon']['email'];?>"></i> My Email Addresses</h4>
      <div class="float-end my-2 me-1">
        <button type="submit" name="add" value="Add New Email" class="btn btn-primary  btn-sm" title="Add New Email" data-bs-toggle="tooltip" data-bs-placement="right"><i class="<?=$data['fwicon']['circle-plus'];?>"></i></button>
      </div>

      <table class="table table-hover bg-primary text-white table table-hover bg-primary text-white clearfix" >
	  
	  <? if(count($data['emails'])!=0){ ?>
        <thead>
        <tr>
        <th scope="col">E-mail</th>
        <th scope="col">&nbsp;</th>
        </tr>
        </thead>
		
		<? }else{ ?>
		<thead>
        <tr>
        <th scope="col">
		<div class="my-2 ms-2 fs-5 text-start">Create an email</div>
		
		<div class="text-start my-2 ms-2" style="max-width:450px !important;">Create your email id for received updates on email </div>
		
		<button type="submit" name="add" value="Add new email" class="btn btn-primary my-2 ms-2 float-start" title="Add new email" data-bs-toggle="tooltip" data-bs-placement="right"><i class="<?=$data['fwicon']['circle-plus'];?>"></i> Add new email</button>
		
	
		</th>
		</tr>
		</thead>
		<? } ?>
		<tbody>
        <? foreach($data['emails'] as $ind=>$email) { ?>
        <tr>
		  <td><?=encrypts_decrypts_emails($email['email'],2,true, array(5,$email['id']));?></td>
          <td class="text-end"><a href="<?=$data['USER_FOLDER']?>/emails<?=$data['ex']?>?choice=<?=($email['id'])?>&deletebtn=1&token=<?=prntext($_SESSION['token_email'],0);?>&uid=<?=$email['clientid'];?>&admin=<?=(isset($_GET['admin'])?$_GET['admin']:'');?>"  onclick="return confirm('Do you want to delete this Email?');" title="Delete Email" class="mx-2"><i class="<?=$data['fwicon']['delete'];?> text-danger" aria-hidden="true"></i></a>
            <? if(!$email['active']){?>
            <a href="#" class="mx-2"><i class='<?=$data['fwicon']['primary'];?> text-warning' title='Not Active'></i></a>
            <? }elseif($email['primary']){ ?>
            <a href="#" class="mx-2"><i class='<?=$data['fwicon']['primary'];?> text-success ' title='Primary'></i></a>
            <? } else { ?>
            <a href="<?=$data['USER_FOLDER']?>/emails<?=$data['ex']?>?choice=<?=($email['id'])?>&primbtn=1&token=<?=prntext($_SESSION['token_email'],0);?>&uid=<?=$email['clientid'];?>&admin=<?=(isset($_GET['admin'])?$_GET['admin']:'');?>"  onclick="return confirm('Do you want to make this as your primary Email?');" class="mx-2"><i class='<?=$data['fwicon']['primary'];?> text-info' title='Make Primary'></i></a>
            <? } ?>
        </tr>
        <? } ?>
		</tbody>
      </table>
      <!-- Button Display -->
    </div>
    <!-- Button Display END-->
    <? } ?>
    <? } ?>
  </form>
</div>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
