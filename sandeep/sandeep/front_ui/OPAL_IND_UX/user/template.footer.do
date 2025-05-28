<??>
</div>
<? if(isset($data['themeName'])&&strpos(@$data['themeName'],'LeftPanel')!==false){ ?>
<!--</div>-->	<!--</div>  -->  

<? }else{ ?>

<? } ?>

<? if(!isset($data['HideAllMenu'])&&!isset($data['HideMenu'])){ ?>
<!--  /////////// Start Footer Section /////////////////-->
<?php /*?><div  style="clear:both"></div>
<footer class="footer mt-auto">
  <div class="container-flex">
  <div class="container-flex user_header_main">
  <div class="container">
  <footer class="d-flex flex-wrap justify-content-between align-items-center mt-1 border-top">
   
   
    <p  class="col-md-12 mb-0 user_footer_align1"><a href="javascript:void(0)" class="text-decoration-none">&nbsp;&nbsp;<!--<?=prntext($data['SiteName'])?> &copy; <?=date("Y");?> - <?=(date("Y") + 1);?></a>--> </p>



  </footer>
</div></div>
 
	<div class="b-example-divider text-center" style="border-radius: 11px; padding-top:12px;">
	<? if($_SESSION['subadmin_customer_service_no']){ ?>
	<a href="tel:<?=@$_SESSION['subadmin_customer_service_no'];?>" class="mx-2 text-white" title="Customer Service No."><i class="fas fa-headphones"></i> <?=@$_SESSION['subadmin_customer_service_no'];?></a> <? } ?>
	<? if($_SESSION['subadmin_customer_service_email']){ ?>
	<a target='_blank' title="Customer Service Email" href="mailto:<?=encrypts_decrypts_emails($_SESSION['subadmin_customer_service_email'],2);?>?subject=I need help&body=Dear <?=@$data['SiteName'];?>, I need your help about ..." class="mx-2 text-white" ><i class="fas fa-envelope"></i> <?=encrypts_decrypts_emails($_SESSION['subadmin_customer_service_email'],2);?></a>
	<? } ?>
	</div>
  </div>
</footer><?php */?>
<!--  /////////// End Footer Section /////////////////-->
<? } ?>

<?
$header_title_qr = array("qr_dashboard", "qr_code", "qr_transactions");
if(in_array($data['PageFile'], $header_title_qr)){?>

<script>
$(document).ready(function () {
$('.qr_active_id').click();

});

</script>
<? } ?>


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



<? $domain_server=@$_SESSION['domain_server'];?>
<? if(@$domain_server['STATUS']==true){ ?>

<!--<div class="footer_div" style="float:left;width:100%;clear:both;">
  <div class="container" style="text-align:center;width:100%;">
    <? if(@$domain_server['customer_service_no']){ ?>
    <a target='_blank' title="Customer Service No." class="nopopup associate glyphicons headphones "><i></i><span>
    <?=@$domain_server['customer_service_no']?>
    </span></a>
    <? } ?>
    <? if(@$domain_server['customer_service_email']){ ?>
    <a  target='_blank' title="Customer Service Email" class="nopopup associate glyphicons envelope" href="mailto:<?=@$domain_server['customer_service_email']?>?subject=I need help&body=Dear <?=@$data['SiteName'];?>, I need your help about ..." ><i></i><span>
    <?=@$domain_server['customer_service_email']?>
    </span></a>
    <? } ?>
    <? if(@$domain_server['bussiness_url']){ ?>
    <a target='_blank' href="<?=@$domain_server['bussiness_url']?>" class="nopopup associate glyphicons microphone globe "><i></i><span>Website</span></a>
    <? } ?>
    <? if(@$domain_server['associate_contact_us_url']){ ?>
    <a target='_blank' href="<?=@$domain_server['associate_contact_us_url']?>" class="nopopup associate glyphicons edit"><i></i><span>Contact US</span></a>
    <? } ?>
  </div>
</div>-->
<? }  ?>

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


<div class="modalpopup_processing hide" id="modalpopup_processing">
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
		dataturl="<?=@$data['Host']?>/transactions_get<?=@$data['ex'];?>?id="+dataturl+"&action=details";
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

<div class="modal_popup3_frame_img_div" style="display:none;"> <img class="modal_popup3_frame_img" id="modal_popup3_frame_img" src="<?=@$data['Host']?>/images/icons/ajax-loader.gif" /> </div>

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
    <div class="switchTb_loader" style="text-align:center;height:40px;overflow:hidden;position:relative;"> <img class="modal_popup3_frame_img" id="modal_popup3_frame_img" src="<?=@$data['Host']?>/images/loader.gif" style="position: relative;top:-30px;" /> </div>
  </div>
</div>

</body>
</html>