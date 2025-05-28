<? if(isset($data['ScriptLoaded'])){ ?>
<? if(isset($_GET['etest'])){ $testLabel="Test "; }else{ $testLabel=""; }?>

<div class="container border mt-1 vkg rounded">
  <h4 class="my-2"><i class="<?=$data['fwicon']['email-mass'];?>"></i> <?=$testLabel?> Message To Send</h4>

  <? if(isset($data['Error'])&&$data['Error']){?>
  <div class="container my-2">
    <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error!</strong>
      <?=prntext($data['Error'])?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
  </div>
  <? } ?>
  <? if(!$data['PostSent']){?>
  <form method="post">
    <div class="row-fluid my-2">
      <div class="col-sm-12 my-2">
        <h6> <?=$testLabel?> Subject</h6>
        <input type="text" name="subject" value="<? if(isset($post['subject'])) echo $post['subject']?>" placeholder="Enter Subject" class="form-control" required>
      </div>
      <div class="col-sm-12 my-2">
        <h6> <?=$testLabel?> Message</h6>
<textarea name="message" class="jqte-test form-control"><? if(isset($post['message'])) echo $post['message']?></textarea>
      </div>
      <div class="col-sm-6 my-2">
        <select name="acquirer" class="form-select" required>
          <option value="" selected>Select Acquirer</option>
            <?
			foreach($data['acquirer_list'] as $key=>$value){ 
			
		    ?>
          <option value="<?=$key;?>" title="<?=$value;?>"><?=$value;?></option>
            <? 
			
			} 
			?>
        </select>
      </div>
      <div class="row my-2"  id="massmailforcss">
        <div class="col-sm-4 px-0">
          <input class="checkbox form-check-input" type="radio" id="rtypea" name="rtype" value="-1" checked>
          Send Message to all Merchants </div>
        <div class="col-sm-4 px-0">
          <input class="checkbox form-check-input" type="radio" id="rtypeb" name="rtype" value="1" >
          Send Message only to Active Merchants </div>
        <div class="col-sm-4 px-0">
          <input class="checkbox form-check-input" type="radio" name="rtype" value="0">
          Send Message only to Suspended Merchants </div>
      </div>
      <div class="col-sm-12  my-2 text-start">
        <button type="submit" class="btn btn-primary submit" name="send" value="Send Now"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Submit </button>
      </div>
    </div>
  </form>
  <? }else{ ?>
  <div class="alert alert-primary my-2" role="alert">Your Message was sent.
    <p>Total Mail List count: <?=$data['result']['count'];?></p>
    <p><?=$data['result']['emailList'];?></p>
  </div>
  <? if(isset($_GET['etest'])){ $etest="?etest=1"; }else{ $etest=""; } ?>
  <div class="container my-2 ps-0"> <a class="btn btn-primary" href="<?=$data['Admins'];?>/mass-mail<?=$data['ex']?><?=$etest;?>"><i class="<?=$data['fwicon']['back'];?>"></i> Back</a> </div>
  <? } ?>
</div>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>

<?php /*?>supporting files and functions for text editor<?php */?>
<link rel="stylesheet" type="text/css" href="<?=$data['TEMPATH']?>/common/css/jquery-te-1.4.0.css"/>
<script src="<?=$data['TEMPATH']?>/common/js/jquery-te-1.4.0.min.js"></script>
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
