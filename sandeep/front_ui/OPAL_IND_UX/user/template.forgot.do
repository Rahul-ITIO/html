<? if(isset($data['ScriptLoaded'])){ ?>
<? $domain_server=$_SESSION['domain_server']; ?>
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
	/*border-radius: 30px 0px 0px 30px;*/
	border-radius: 0px 30px 30px 30px;
	box-shadow: 0px 5px 10px 0px rgba(0, 0, 0, 0.5);
    border-color: <?=$_SESSION['background_gl5'];?>;
    border-style: solid;
    border-top-width: 20px;
    border-bottom-width: 1px;
	/*margin-top: 80px;*/
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

<? if($post['step']==1){ ?>
<div class="container-sm my-2" >
  <div class="row-fluid">
    <? if($domain_server['LOGO']){ ?>
	<div class="text-center my-4" style="max-width:400px; margin:0 auto; "><a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>" class="img-fluid"><img src="<?=encode_imgf($domain_server['LOGO']);?>" style="height:50px;"></a></div>
	<? } ?>
	

	
    <div class="container my-2" style="max-width:400px; margin:0 auto;">
	<div class="main_box pull-up  p-2">
      <h2 class="my-2 text-center fs-5">Forgot Password</h2>
	  <div class="col text-center my-2"> Already Have an Account? <a href="<?=$data['Host'];?>/login<?=$data['ex']?>">Sign-In.</a></div>
	  
				

 <? if(isset($_SESSION['action_sent_success'])&&$_SESSION['action_sent_success']){ ?>
		    <script>
		    $(document).ready(function(){
			setTimeout(function(){
			$("#myToast").show();
			}, 500);
		    });
			</script>
			
			<div class="row text-center ">
				<i class="<?=$data['fwicon']['tick-circle'];?> text-success fa-w-12 fa-3x mt-3 "></i>
			</div>
			
		<div class="my-2 fs-5 p-2 text-center">An email has been sent to the email <b><i><?=$_SESSION['memail'];?></i></b> address registered with user name: <b><i><?=@$_SESSION['registered_email']?></i></b>. You'll receive instructions on how to set a new password.</div>
		
		<div class="p-2">Check your spam or <a class="text-linkf resend-again pointer">resend</a> <span class="float-end"> <a href="<?=$data['Host'];?>/index<?=$data['ex']?>" title="Move to login" class="text-linkf">Return to sign in</a></span></div>
		
		<div class="p-2 hide">If you haven't received an registered email <?=$_SESSION['memail'];?> in 5 minutes, check your spam or <a class="text-linkf resend-again pointer">resend</a> <span class="float-end"> <a href="<?=$data['Host'];?>/index<?=$data['ex']?>" title="Move to login" class="text-linkf">Return to sign in</a></span></div>


		<? 
			$_SESSION['action_sent_success']=null; unset($_SESSION['action_sent_success']);
			
		} else if(isset($_SESSION['action_success'])&&$_SESSION['action_success']){ ?>
    <div class="alert alert-success alert-dismissible fade show my-2" role="alert"> <?php echo $_SESSION['action_success'];?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
	<script>
		$(document).ready(function(){
			//setTimeout(function(){ top.window.location.href="<?=$data['Host']?>/index<?=$data['ex']?>"; }, 6000);
		});
	</script>
	
    <? 
		$_SESSION['action_success']=null; unset($_SESSION['action_success']);
	} 
	else
	{  ?>
	

      <form method="post">
        <input type="hidden" name="token" value='<?=prntext(@$_SESSION['token_forgot'],12);?>' />
        <input type=hidden name=step value="<?=prntext(@$post['step'])?>">
        <div class="my-2 row-fluid">
          <div class="col-sm-12 px-4">
		   <label for="staticEmail" class="col-form-label"><strong>User Name</strong></label>
            <input type="text" class="form-control"  name="registered_email" title="User Name" placeholder="Enter Your User Name" value="<?=prntext(@$post['registered_email'])?>" autocomplete="off" required />
          </div>
        </div>
        <div class="my-2 row-fluid">
          <div class="col-sm-12 text-center">
            <button class="btn btn-primary w-75 my-2" id="btn-confirm" name="send" value="PLACE ORDER" type="submit">Send</button>
          </div>
        </div>
        
      </form>
	<? } ?>
	
	<div class="rounded align-items-center text-message border-0 w-100 mt-3 p-2 toast-box hide" role="alert" aria-live="assertive" aria-atomic="true" id="myToast1">
	  <div class="d-flex">
		
		<div class="toast-body hide">Password Reset Instruction sent to <?=$_SESSION['memail'];?></div>
		<button type="button" class="btn-close btn-close-white me-2 m-auto " onclick="toastclose('.toast-box')" data-bs-dismiss="toast" aria-label="Close"></button>
	  </div>
	</div>

   </div>
  
  </div>
</div>



<? } elseif($post['step']==5){ ?>


				<? if($data['Error']){ ?>
				<div class="container my-2">
				<div class="alert alert-danger alert-dismissible fade show mx-4" role="alert"> <strong>Error !</strong>
				<?=prntext(@$data['Error'])?>
				<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
				</div>
				</div>
				<? } ?>


  
    <div class="container my-2" style="max-width:400px; margin:0 auto;">
	<div class="main_box p-2">
	   <h2 class="my-2 text-center fs-5">Forgotten Password (STEP #2)</h2>
	   <div class="col text-center fw-bold">Already Have an Account? <a href="<?=$data['Host'];?>/login<?=$data['ex']?>">Sign-In.</a></div>
      <p class="m-2">If you forget your password, we will ask your Company Name you submit below. Please, try to find a personal Company Name and Website URL which you know.</p>
      <form method="post">
        <input type="hidden" name="token" value='<?=prntext(@$_SESSION['token_forgot'],12);?>' />
        <input type="hidden" name="step" value="<?=prntext(@$post['step'])?>">
        <div class="my-2 row">
          <label for="staticEmail" class="col-sm-6 col-form-label">Company Name (*):</label>
          <label for="staticEmail" class="col-sm-6 col-form-label"><font color=red><b><?=prntext(@$post['question'])?></b></font></label>
        </div>
        <div class="my-2 row">
          <label for="staticEmail" class="col-sm-6 col-form-label">Website URL(*):</label>
          <div class="col-sm-6 px-4">
          <input type="text" class="form-control"  name="answer" placeholder="Enter Your User Name"  value="<?=prntext(@$post['answer'])?>" autocomplete="off" required/>
          </div>
        </div>
        <div class="my-2 text-center">
            <button type="submit" class="btn btn-primary" name="cancel" value="Back"><i class="fas fa-backward"></i> Back </button>
            <button type="submit" class="btn btn-primary submit" name="send" value="Continue"><i class="far fa-check-circle"></i> Continue</button>
        </div>
        
      </form>
    </div>
</div>
</center>
<? }elseif($post['step']==2){ ?>
<div class="container my-2" style="max-width:400px; margin:0 auto;">
	<div class="main_box p-2">

<div class="container my-2" >
  <div class="alert alert-success alert-dismissible fade show" role="alert"> <strong>Success!</strong> New password has been sent to registered email ID: <?=$_SESSION['memail'];?>
  </div>
</div>
<div class="col text-center my-2"> <a class="nopopup btn btn-primary" href="<?=$data['Host'];?>/login<?=$data['ex']?>">Login Now</a>&nbsp;<a class="nopopup btn btn-primary" href="<?=$data['Host'];?>/index<?=$data['ex']?>"><i class="fas fa-backward"></i> Back</a> </div>

</div>
</div>


<? } ?>


<?//Dev Tech: Modal on footer ?>


<!--  /////////// Start Modal Section /////////////////-->
<div class="modal" id="myModal">
  <div class="modal-dialog" style="margin-top:50px !important;">
    <div class="modal-content bg-primary text-white">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Heading</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <div class="spinner-border text-primary" role="status">
  		<span class="visually-hidden">Loading...</span>
		</div>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>



<div class="modal" id="myModal9">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title"><!--Heading--></h4>
        <button type="button" class="btn-close myModal_close" value="myModal9" data-bs-dismiss="modal88"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <div class="spinner-border text-primary" role="status">
  <span class="visually-hidden">Loading...</span>
</div>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-primary myModal_close" value="myModal9" data-bs-dismiss="modal88">Close</button>
      </div>

    </div>
  </div>
</div>


<div class="modal" id="myModal12">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title"><!--Heading--></h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <div class="spinner-border text-primary" role="status">
  <span class="visually-hidden">Loading...</span>
</div>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>


<!--  /////////// END Modal Section /////////////////-->
<script> 
function iframe_openfvkg(e){
        var subqry=$.trim($(e).text());
		var mid = $(e).attr('data-mid');
		if(mid !== undefined){subqry=$.trim(mid);}
		$('.mprofile').removeClass('mactive');
		$(e).addClass('mactive');
		var urls_load="1";
		var urls=$(e).attr('data-ihref')+"&bid="+subqry;
		//alert(urls);
		$('#myModal12').modal('show').find('.modal-body').load(urls);
        $('#myModal12 .modal-dialog').css({"max-width":"80%"});
		
}


function popup_openv(url){
$('#myModal9').modal('show').find('.modal-body').load(url);
$('#myModal9 .modal-dialog').css({"max-width":"80%"});
}


    $('.myModal_close').on('click', function(e){
      e.preventDefault();
	  var theValues = '#'+$(this).val();
	  //alert(theValues);
      $(theValues).modal('hide');
    });
	
	
	function iframe_open_modal(e){

        var subqry=$.trim($(e).text());
		var mid = $(e).attr('data-mid');
		if(mid !== undefined){subqry=$.trim(mid);}
		$('.mprofile').removeClass('mactive');
		$(e).addClass('mactive');
		var urls_load="1";
		var urls=$(e).attr('data-ihref')+"&bid="+subqry;
		//alert(urls);
		//$('.modal-body iframe').attr('src',$(this).attr('href'));
		$('.modal-body iframe').attr('src',urls);
		
      $('#myModal90').modal('show');
		
		//$('#myModal12').modal('show').find('.modal-body').load(urls);
        //$('#myModal90 .modal-dialog').css({"max-width":"90%"});
		
}
$('.modal_from_url').on('click', function(e){
      e.preventDefault();
	  //alert($(this).attr('title'));
      $('#myModal').modal('show').find('.modal-body').load($(this).attr('href'));
	
	  $('#myModal .modal-title').html($(this).attr('title'));
    });	
	
   
	
	
	//====================New Popup modal_for_iframe =============
	
	  $('.modal_for_iframe').on('click', function(e){
      e.preventDefault();
	   //alert();
      $('.modal-body iframe').attr('src',$(this).attr('href'));
      $('#myModal90').modal('show');
	  $('#myModal90 .modal-dialog').css({"max-width":"80%"});

      });
	  
</script> 
<div class="modal" id="myModal90">
  <div class="modal-dialog" style="margin: auto !important;margin-top:50px !important;">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title"><!--Heading--></h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body" style="padding:0;">
        <iframe src="" width="100%" height="500"></iframe>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
<!--============Modal for convert url to Qrcode ==================-->





<?php /*?><? $domain_server=$_SESSION['domain_server'];?>
<? if($domain_server['STATUS']==true){ ?>

<!--<div class="footer_div" style="float:left;width:100%;clear:both;">
  <div class="container" style="text-align:center;width:100%;">
    <? if($domain_server['customer_service_no']){ ?>
    <a target='_blank' title="Customer Service No." class="nopopup associate glyphicons headphones "><i></i><span>
    <?=$domain_server['customer_service_no']?>
    </span></a>
    <? } ?>
    <? if($domain_server['customer_service_email']){ ?>
    <a  target='_blank' title="Customer Service Email" class="nopopup associate glyphicons envelope" href="mailto:<?=$domain_server['customer_service_email']?>?subject=I need help&body=Dear <?=$data['SiteName'];?>, I need your help about ..." ><i></i><span>
    <?=$domain_server['customer_service_email']?>
    </span></a>
    <? } ?>
    <? if($domain_server['bussiness_url']){ ?>
    <a target='_blank' href="<?=$domain_server['bussiness_url']?>" class="nopopup associate glyphicons microphone globe "><i></i><span>Website</span></a>
    <? } ?>
    <? if($domain_server['associate_contact_us_url']){ ?>
    <a target='_blank' href="<?=$domain_server['associate_contact_us_url']?>" class="nopopup associate glyphicons edit"><i></i><span>Contact US</span></a>
    <? } ?>
  </div>
</div>-->
<? } ?><?php */?>

<script>
/*for display tooltip message*/
var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
  return new bootstrap.Tooltip(tooltipTriggerEl)
})

$('.close_button').on('click', function () {
$(".toast-box").hide();
});

</script>

<div class="modalpopup_form_popup hide" id="modalpopup_form_popup">
  <div class="modalpopup_form_popup_layer"> </div>
  <div class="modalpopup_form_popup_body">
    <div id="modalpopup_form_iframe_div"><i class="fa-solid fa-spinner fa-spin-pulse fa-5x text-loader"></i>
      <!--<div class='waitxt'>loading...</div>-->
      <div class="hide">
		<p style="font-size:16px;font-weight: bold;">Processing payment...</p>
		<p>This will take a few seconds</p>
      </div>
    </div>
  </div>
</div>

<div class="modalpopup_processing hide" id="modalpopup_processing_2">
  <div class="modalpopup_form_popup_layer" style="opacity:1;background:#ddd;"> </div>
  <a class="close_popup modal_popup_close processing_close" onClick="document.getElementById('modalpopup_processing').style.display='none';" style="color:#000!important;background:#fff;left: 20px;right: unset;top: 20px;position: absolute;z-index: 999999;">×</a>
  <div class="modalpopup_form_popup_body">
    <div id="modalpopup_processing_div" class="row p-0" >
	  <div class="row1 center">
		<i class="fa-solid fa-spinner fa-spin-pulse fa-5x text-loader"></i>
	  </div>
      <div class="row">
		<p style="font-size:16px;font-weight:bold;color:#3f3f3f;float: left;width:100%;clear:both;line-height:30px;padding:12px 0 0 0;">Processing payment...</p>
		<p style="font-size:12px;font-weight: normal;color:#3f3f3f;float:left;width:100%;clear:both;line-height: 14px;">This will take a few seconds</p>
      </div>
    </div>
	
  </div>
</div>

<script>

<?if(isset($_SESSION['adm_login']) || isset($_SESSION['login'])){?>

function activeslide(){
	var active_a=$(".collapsea.active");
	var active_html=active_a.parent().parent().next().find('.collapseitem');
	var ids = active_a.attr('data-href');
	//var tabnames = active_a.attr('data-tabname');
	var dataurl = active_a.attr('data-url');
	var dataturl = active_a.attr('data-turl');
	//alert(active_a+"\r\n"+active_html+"\r\n"+ids+"\r\n"+dataurl+"\r\n"+dataturl);  
	if(dataturl !== undefined){
		dataturl="<?=$data['Host']?>/transactions_get<?=$data['ex'];?>?id="+dataturl+"&action=details";
		ajaxf2(dataturl,active_html.find('.content_holder'));
	}
	  
	 active_html.slideDown(900); 
}

<?}?>

function popuploadig(){
	$('#modalpopup_form_popup').slideDown(900);
}
function popupclose(){
	$('#modalpopup_form_popup').slideUp(70);
	$('.popup_close').slideUp(70);
	$('#modalpopup_popup').slideUp(70);
	if($('#add_principal_form')[0]){$('#add_principal_form')[0].reset();}
}
function hformf(thisValue){
	
	if(thisValue.contentWindow.location.href=="about:blank"){
		//alert(thisValue.contentWindow.location.href);
	}else{
		$('#modalpopup_form_popup').slideDown(900);
		setTimeout(function(){ 
			$('#modalpopup_form_popup').slideUp(100); 
			//activeslide();
			popupclose();
		},400); 
	}
}

</script>

<div style="display:none!important;width:0!important;height:0!important">
  <iframe onload="hformf(this)" name="hform" id="hform" src="about:blank" width="0" height="0" scrolling="no" frameborder="0" marginwidth="0" marginheight="0" style="display:none!important;width:0!important;height:0!important" ></iframe>
</div>

<div class="modalpopup popup_close" id="modalpopup" style="display: none;">
  <div class="modalpopup_form_popup_layer"> </div>
  <div class="modalpopup_body absoluteX" id="modalpopup_body"> <a class="close_popup modal_popup_close" onClick="document.getElementById('modalpopup').style.display='none';">×</a>
    <div class="modalpopup_cdiv" id="modalpopup_cdiv"> </div>
  </div>
</div>

<div class="modal_popup3_frame_img_div" style="display:none;"> <img class="modal_popup3_frame_img" id="modal_popup3_frame_img" src="<?=$data['Host']?>/images/icons/ajax-loader.gif" /> </div>

<div class="modal_popup_popup" id="modal_popup_popup">
  <div class="modal_popup_popup_layer"> </div>
  <div class="modal_popup_popup_body"> <a class="modal_popup_popup_close" onclick="document.getElementById('modal_popup_popup').style.display='none';">&times;</a>
    <div id="modal_popup_iframe_div">
      <iframe src="about:blank" name="modal_popup_iframe" id="modal_popup_iframe" frameborder="0" marginwidth="0" marginheight="0" class="modal_popup_iframe" width="100%" height="520"></iframe>
    </div>
  </div>
</div>

<div class=modal_popup_popup id=modal_popup_popup2>
  <div class=modal_popup_popup_layer> </div>
  <div class=modal_popup_popup_body2>
    <div id=modal_popup_popup_body2Id class=modal_popup_html2> </div>
    <div class=modal_popup_html3> </div>
  </div>
</div>

<div class="msgNextTabTrDiv" style="display:none !important;text-align:center">
  <div class="modalMsgContTxt" >
    <p class='switchTb' style="text-align:center">Please switch to the next tab to complete the payment.</p>
    <div class="switchTb_loader" style="text-align:center;height:40px;overflow:hidden;position:relative;"> <img class="modal_popup3_frame_img" id="modal_popup3_frame_img" src="<?=$data['Host']?>/images/loader.gif" style="position: relative;top:-30px;" /> </div>
  </div>
</div>



<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
</div>
