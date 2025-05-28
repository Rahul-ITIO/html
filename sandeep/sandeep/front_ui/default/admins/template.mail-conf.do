<? if(isset($data['ScriptLoaded'])){
		
	if((!isset($_SESSION['login_adm']))&&(!$_SESSION['e_mail_templates'])){
	  echo $data['OppsAdmin'];
	  exit;
	}
	$av='';$at='';
	if(isset($_GET['a'])&&$_GET['a']){$av=$_GET['a'];}
	if(isset($_GET['t'])&&$_GET['t']){$at=$_GET['t'];}
?>

<div class="container border my-1 vkg px-0 rounded">
  <?php if(isset($_SESSION['successmsg'])&&$_SESSION['successmsg']){ ?>
  <div class="alert alert-success alert-dismissible fade show m-2" role="alert"> <strong>Success!</strong>
    <?=$_SESSION['successmsg'];?>
    .
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <?php unset($_SESSION['successmsg']);} ?>
  <div class="container vkg">
    <h4 class="my-2"><i class="<?=$data['fwicon']['email-template'];?>"></i> E-Mail Templates</h4>
  </div>
  <form method="post">
    <div class="row m-2 border rounded">
      <div class="col-sm-12">
        <h6 class="my-2">Please Select E-mail Template: <a data-ihref="<?=$data['Admins']?>/json_log_all<?=$data['ex']?>?tablename=emails" title="View Json Log History" onclick="iframe_open_modal(this);"><i class="<?=$data['fwicon']['circle-info'];?> text-danger fa-fw"></i></a></h6>
      </div>
      <div class="col-sm-9 my-2">
        <select name="template" id="templateId" class="form-select" title="Please Select E-mail Template"  required>
          <option value="">Select Email Template</option>
          <? if(isset($post['Templates'])&&$post['Templates']){ ?>
          <? foreach($post['Templates'] as $value){?>
          <option value="<?=$value['key']?>" <? if(isset($post['template'])&&$value['key']==$post['template']){?> selected<? } ?>> <?=$value['name']?> => <?=$value['key']?> </option>
          <? }?>
          <? }?>
        </select>
        <? if(isset($_REQUEST['a'])){ ?>
        <script>$('#templateId option[value="<?=$_REQUEST['a'];?>"]').prop('selected','selected');</script>
        <? }else{ ?>
        <script>$('#templateId option[value="<?=$post['template'];?>"]').prop('selected','selected');</script>
        <? } ?>
      </div>
      <div class="col-sm-3 my-2">
        <input class="btn btn-primary submit w-100" type="submit" name="read" value="Open Now">
      </div>
    </div>
  </form>
  <? if(isset($post['template'])&&$post['template']){ ?>
  <form method="post">
    <input type="hidden" name="template" value="<?=prntext($post['template'])?>" />
    <div class="row m-2 border  rounded">
      <div class="col-sm-12 my-2">
        <h6 class="my-2">Current Template is: <span class="text-danger">
          <?=prntext($post['template'])?>
          </span></h6>
      </div>
      <div class="col-sm-12 my-2">
        <div class="input-group"> <span class="input-group-text col-sm-3" id="basic-addon4">Subject :</span>
          <input type="text" name="subject" class="form-control" maxlength="255" required  value="<?=$post['subject']?>">
        </div>
      </div>
      <div class="col-sm-12 my-2">
        <textarea class="jqte-test" name="content" ><?=stripslashes($post['content'])?>
</textarea>
      </div>
      <div class="col-sm-12 my-2">
        <button class="btn btn-primary submit" type="submit" value="Submit" name="send"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Submit</button>
        <button class="btn btn-primary submit" type="submit" name="deletetemplate" onclick="return confirm('Are you Sure to Delete this Email Template');" value="Delete"><i class="<?=$data['fwicon']['delete'];?>"></i> Delete</button>
      </div>
    </div>
  </form>
  <? } ?>
</div>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
<?php /*?> include both file for Text Editor <?php */?>
<link rel="stylesheet" type="text/css" href="<?=$data['TEMPATH']?>/common/css/jquery-te-1.4.0.css"/>
<script src="<?=$data['TEMPATH']?>/common/js/jquery-te-1.4.0.min.js"></script>
<?php /*?>js for text editor <?php */?>
<script>
	$('.jqte-test').jqte();
	
	// settings of status
	var jqteStatus = true;
	$(".status").click(function()
	{
		jqteStatus = jqteStatus ? false : true;
		$('.jqte-test').jqte({"status" : jqteStatus})
	});
</script>
