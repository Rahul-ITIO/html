<? if(isset($data['ScriptLoaded'])){ ?>
<link href="<?=$data['TEMPATH']?>/common/css/table-responsive_999.css" rel="stylesheet">
<div id="zink_id" class="container border rounded  mt-2 mb-2 bg-vlight vkg" >
<script>
function myCopyFunction(theId,theLabel) {
  /* Get the text field */
  var copyText = document.getElementById(theId);

  /* Select the text field */
  copyText.select();

  /* Copy the text inside the text field */
  document.execCommand("copy");

  /* Alert the copied text */
  alert("Copied : " + theLabel);
}

$(document).ready(function(){
    $('.collapsea').click(function(){
	   var ids = $(this).attr('data-href');
		if($(this).hasClass('active')){
			$('.collapseitem').removeClass('active');
			$('.collapsea').removeClass('active');
			$('.divhide').css("display", "none");
			
			$('#'+ids).slideUp(200);
		} else {
		  $('.collapseitem').removeClass('active');
		  $('.collapsea').removeClass('active');
		  $('.divhide').css("display", "");
		  //$('#'+ids).addClass('active');
		  $(this).addClass('active');
		  
		  $('.collapseitem').slideUp(100);
		  $('#'+ids).slideDown(700);
		}
        
    });
    $(".email_validate_input").keyup(function(){
		email_validatef(this,".validate_input_firstname","");
	});
	
	var email_subject_var="1";
	$("#storeType").change(function() {
	   var selectedItem = $(this).val();
	   var burl= $('option:selected', this).attr('data-burl');
	   var dba= $('option:selected', this).attr('data-dba');
	   if($("#email_subject").val()===""||$("#email_subject").val()==""||email_subject_var==""){
		//alert(burl+"\r\n"+dba);
		email_subject_var="";
		var email_subject = "You have got a payment request from";
		if(burl){email_subject += " - "+burl;}
		if(dba){email_subject += " - "+dba;}
		$("#email_subject").val(email_subject);
	   }
	   
	 
	});
});
</script>
<div class="row vkg row clearfix_ice">
  <div class="col-sm-12 py-2">
    <h4 class="float-start"><i class="fa fa-paper-plane"></i>
      <?=$data['SOFT_POS_LABELS'];?>
    </h4>
  </div>
</div>
<form method="post" name="data" >
  <input type="hidden" name="step" value="<?=((isset($post['step']) &&$post['step'])?$post['step']:'')?>">
  <? if((isset($data['Error'])&& $data['Error'])){ ?>
  <div class="alert alert-danger alert-dismissible fade show" role="alert">
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    <strong>Error! </strong>
    <?=prntext($data['Error'])?>
  </div>
  <? } ?>
  <? if(isset($_SESSION['action_success'])&&$_SESSION['action_success']){ ?>
  <div class="alert alert-success alert-dismissible fade show" role="alert">
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    <?php echo $_SESSION['action_success'];?> </div>
  <? $_SESSION['action_success']=null;} ?>
  <? if($post['step']==1){ ?>
  <div class="ro col-sm-12 row"> <span class="float-end d-none d-sm-block text-end" style="width:calc(100% - 100px);"  > </span>
    <button type="submit" name="send" value="Create <?=$data['SOFT_POS_LABELS'];?>" class="btn btn-primary my-rpnsive-btn my-2 ms-2 float-end" style="width:40px;"><i class="fas fa-plus-circle" title="Create <?=$data['SOFT_POS_LABELS'];?>" ></i></button>
  </div>
  <div class="my-2  col-sm-12 table-responsive">
    Printable for Sof Pos 
  </div>
  </div>
  <? }elseif($post['step']==2){ ?>
  <? if(isset($post['gid'])&&$post['gid']){ ?>
  <input type="hidden" name="gid" value="<?=$post['gid']?>">
  <? }else{
	   
	}
  ?>
  <h4 class="heading glyphicons settings"><i></i>Create
    <?=$data['SOFT_POS_LABELS'];?>
  </h4>
  <div class="row">
    <? $k=0; if($data['Store']&&$data['store_size']>1){ ?>
    <div class="col my-2 px-1">
      <select name="softpos_terNO" id="storeType" class="form-control "  required>
        <option value="" disabled>Select Business</option>
        <?
				foreach($data['Store'] as $key=>$value){
			?>
        <option data-val="<?=$value['public_key'];?>" value="<?=$value['id'];?>">
        <?=$value['ter_name']?>
        </option>
        <? $k++; } ?>
      </select>
      <? if($post['softpos_terNO']){ ?>
      <script>
			$('#storeType option[value="<?=($post['softpos_terNO'])?>"]').prop("selected", "selected");
			$('#storeType option[value="<?=($post['softpos_terNO'])?>"]').attr("selected", "selected");
		</script>
      <? } ?>
    </div>
    <? } ?>
    <div class="col my-2 px-1">
      <input type="text" name="softpos_pa"  placeholder="PA: Enter The Payment Address" class="form-control col-sm-6" value="<?=prntext(isset($post['softpos_pa'])?$post['softpos_pa']:$post['username'])?>"  autocomplete="off" required  />
    </div>
    <div class="col my-2 px-1">
      <input type="text" name="softpos_pn"  placeholder="PN: Enter The Payment Name" class="form-control col-sm-6" value="<?=prntext(isset($post['softpos_pn'])?$post['softpos_pn']:$post['company_name'])?>"  autocomplete="off" required  />
    </div>
	<?/*?>
    <div class="col-sm-12 my-2 px-1">
      <textarea id="mustHaveId" class="form-control" name="comments" rows="2" placeholder="Enter a Message for the Receiver."><?=prntext(isset($post['comments'])?$post['comments']:'')?></textarea>
    </div>
	<?*/?>
    <div class="col-sm-12 my-2 text-center">
      <button type="submit" name="send" value="CONTINUE"  class="btn btn-icon btn-primary"><i class="far fa-check-circle"></i> Submit</button>
        <a href="<?=$data['urlpath']?>" class="btn btn-icon btn-primary" ><i class="fas fa-backward"></i> Back</a> </div>
    <? } ?>
  </div>
</form>
</div>
<!--</div>-->
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
