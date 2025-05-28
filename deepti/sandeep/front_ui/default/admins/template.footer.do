<? if(isset($data['ScriptLoaded'])){ ?>
<?
//$_SESSION['cronhost']=1;

if((isset($_SESSION['cronhost']))&&($data['localhosts']==false)&&(isset($_SESSION['adm_login'])))
{
	$_SESSION['cronhost']=null; unset($_SESSION['cronhost']);
	/*
	echo "<script>
			$(document).ready(function(){
				$('#modal_popup_form_popup').show();
			});
			window.open('{$data['Host']}/crons{$data['ex']}?pq=1&dtest=2', 'cronhost');
			window.parent.focus();
	</script>";
	*/
}
?>
<? $data['themeName']=((isset($data['themeName']) &&$data['themeName'])?$data['themeName']:'')?>
<? if(strpos($data['themeName'],'LeftPanel')!==false){ ?>
</div>
</div>
<!-- </div>-->
<? }else{ ?>
<? } ?>
<? if(!isset($data['HideMenu'])){ ?>
<!--  /////////// Start Footer Section /////////////////-->

<footer class="footer mt-auto clearfix">
  <div class="container-flex">
    <div class="b-example-divider"></div>
  </div>
</footer>
<? } ?>
<!--  /////////// End Footer Section /////////////////-->
<!--  /////////// Start Modal - For Merchant Detail /////////////////-->
<div class="modal" id="myModal2">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Merchant Detail
          <!--Heading-->
        </h4>
        <button type="button" class="btn-close myModal_close" value="myModal2" data-bs-dismiss="modal99"></button>
      </div>
      <!-- Modal body -->
      <div class="modal-body">
        <iframe src="" width="100%" height="600"></iframe>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-primary myModal_close" value="myModal2" data-bs-dismiss="modal99">Close</button>
      </div>
    </div>
  </div>
</div>
<!--  /////////// END Modal Section2 /////////////////-->
<!--  /////////// Start Modal Common /////////////////-->
<div class="modal" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">
          <!--Heading-->
        </h4>
        <button type="button" class="btn-close myModal_close" value="myModal" data-bs-dismiss="modal88"></button>
      </div>
      <!-- Modal body -->
      <div class="modal-body">
        <div class="spinner-border text-primary" role="status"> <span class="visually-hidden">Loading...</span> </div>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-primary myModal_close" value="myModal" data-bs-dismiss="modal88">Close</button>
      </div>
    </div>
  </div>
</div>
<!--  /////////// END Modal Common /////////////////-->
<!--  /////////// Start Modal Iframe /////////////////-->
<div class="modal" id="myModal3" style="z-index:99999">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">
          <!--Heading-->
        </h4>
        <button type="button" class="btn-close myModal_close" value="myModal3" data-bs-dismiss="modal13"></button>
      </div>
      <!-- Modal body -->
      <div class="modal-body">
        <iframe src="" width="100%" height="600"></iframe>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-primary myModal_close" value="myModal3" data-bs-dismiss="modal13">Close</button>
      </div>
    </div>
  </div>
</div>
<!--  /////////// END Modal Iframe /////////////////-->
<div class="modal" id="myModalfortrans">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">
          <!--Heading-->
        </h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <!-- Modal body -->
      <div class="modal-body">
        <iframe src="" width="100%" height="600"></iframe>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<!--  /////////// END Modal Iframe /////////////////-->
<div class="modal" id="myModal9">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">
          <!--Heading-->
        </h4>
        <button type="button" class="btn-close myModal_close" value="myModal9" data-bs-dismiss="modal88"></button>
      </div>
      <!-- Modal body -->
      <div class="modal-body">
        <div class="spinner-border text-primary" role="status"> <span class="visually-hidden">Loading...</span> </div>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-primary myModal_close" value="myModal9" data-bs-dismiss="modal88">Close</button>
      </div>
    </div>
  </div>
</div>
<script>
//==========Open Popup from merchant_modal====================

	$('.merchant_modal').on('click', function(e){
      e.preventDefault();
	  
	  //var rrr=$(this).attr('href');
	  //alert(rrr);
	  $('.modal-body iframe').attr('src',$(this).attr('href'));
      $('#myModal2').modal('show');
	  
	  $('#myModal2 .modal-dialog').css({"max-width":"90%"});
	  //$('.modal-title').html('Verify Email / Phone No.');
    });
	
	//====================New Popup  modal_from_url ====
	
	$('.modal_from_url').on('click', function(e){
      e.preventDefault();
	  
      $('#myModal').modal('show').find('.modal-body').load($(this).attr('href'));
	  $('#myModal .modal-dialog').css({"max-width":"800px"});
	  var g_title=$(this).attr('title');
	  if(g_title){
	  $('.modal-title').html(g_title);
	  }else{
	  $('.modal-title').html("Detail");
	  }
    });
	
	$('.modal_from_data_ihref').on('click', function(e){
      e.preventDefault();
	  
      $('#myModalfortrans').modal('show').find('.modal-body').load($(this).attr('data-ihref'));
	 
	  //$('.modal-title').html('Verify Email / Phone No.');
    });
    //====================New Popup modal_for_iframe =============
	
	  $('.modal_for_iframe').on('click', function(e){
      e.preventDefault();
	   //alert();
      $('.modal-body iframe').attr('src',$(this).attr('href'));
	  
      $('#myModal3').modal('show');
	  
	  $('#myModal3 .modal-dialog').css({"max-width":"80%"});
	  //$('#myModal3 .modal-title').html(Modtitle);
      });
	
	$('.myModal_close').on('click', function(e){
      e.preventDefault();
	  var theValues = '#'+$(this).val();
	  //alert(theValues);
      $(theValues).modal('hide');
    });
		
//==========End Open Popup from css==================== 
function popup_openv(url){
$('#myModal9').modal('show').find('.modal-body').load(url);
$('#myModal9 .modal-dialog').css({"max-width":"80%"});
}

 
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
		
      $('#myModal12').modal('show');
		
		//$('#myModal12').modal('show').find('.modal-body').load(urls);
        $('#myModal12 .modal-dialog').css({"max-width":"90%"});
		
}

/*for display tooltip message*/
var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
  return new bootstrap.Tooltip(tooltipTriggerEl)
})

$('.close_button').on('click', function () {
$(".toast-box").hide();
});

</script>
<div class="modal" id="myModal12">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">
          <!--Heading-->
        </h4>
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
<!--///////////// For Deleted ///////////////////////-->
<div class="modal_popup_popup hide" id="modal_popup_popup">
  <div class="modal_popup_popup_layer"> </div>
  <div class="modal_popup_popup_body"> <a class="modal_popup_popup_close" onclick="document.getElementById('modal_popup_popup').style.display='none';">&times;</a>
    <div id="modal_popup_iframe_div">
      <iframe src="about:blank" name="modal_popup_iframe" id="modal_popup_iframe" frameborder="0" marginwidth="0" marginheight="0" class="modal_popup_iframe" width="100%" height="400"></iframe>
    </div>
  </div>
</div>
<style>
.modal_popup_form_popup {display:none; position:fixed;z-index:999999; top:0; left:0;}.modal_popup_form_popup_layer {display:block; position:fixed; z-index:999999; width:100%; height:100%; background:#000; opacity:0.2; top:0; left:0; }.modal_popup_form_popup_body {display:block; position:fixed; z-index:9999999;left:50%;top:50%;width:300px;height:260px;margin:-130px 0 0 -150px;opacity:1;border-radius:5px;color:#fff;text-align:center;overflow:hidden; }.modal_popup_form_popup_close {position: absolute; z-index: 99; float: right; right: -20px; top: -20px; width:40px; height:40px; font: 800 40px/40px 'Open Sans'; color:#fff !important; background:#f30606; text-align:center; border-radius:110%; overflow:hidden; cursor: pointer;}.waitxt{font-size: 14px;margin:10px 0 0 0;background:#444;color:#fff;padding:3px;border-radius:3px;white-space:nowrap;position:absolute;z-index:3;bottom:0px;width:100%;}
</style>
<div class="modal_popup_form_popup" id="modal_popup_form_popup">
  <div class="modal_popup_form_popup_layer"> </div>
  <div class="modal_popup_form_popup_body">
    <div id="modal_popup_form_iframe_div"><i class="fa-solid fa-spinner fa-spin-pulse fa-5x text-loader"></i>
      <!--<div class='waitxt'>loading...-->
        <div></div>
      </div>
    </div>
  </div>
</div>


<div class="modalpopup_form_popup" id="modalpopup_form_popup">
  <div class="modalpopup_form_popup_layer"> </div>
  <div class="modalpopup_form_popup_body">
    <div id="modalpopup_form_iframe_div"><i class="fa-solid fa-spinner fa-spin-pulse fa-5x text-loader"></i>
      <!--<div class='waitxt'>loading...</div>-->
        <div>
      </div>
    </div>
  </div>
</div>
<script>
function popuploadig(){
	$('#modal_popup_form_popup').slideDown(900);
}
function popupclose(){
	$('#modal_popup_form_popup').slideUp(70);
	$('#modal_popup_popup').slideUp(70);
	
}
function popupclose2(){
	setTimeout(function(){ 
		$('#modal_popup_form_popup').slideUp(100); 
		activeslide();
		top.window.popupclose();
		
	},1500); 
}
function hformf(thisValue){
	//alert(thisValue.contentWindow.location.href);
	if(thisValue.contentWindow.location.href=="about:blank"){
		//alert(thisValue.contentWindow.location.href);
	}else{
		$('#modal_popup_form_popup').slideDown(900);
		setTimeout(function(){ 
			$('#modal_popup_form_popup').slideUp(100); 
			activeslide();
			top.window.popupclose();
			parent.window.popupclose();
		},1000); 
	}
}

</script>
<div style="display:none!important;width:0!important;height:0!important">
  <iframe onload="hformf(this)" name="hform" id="hform" src="about:blank" width="0" height="0" scrolling="no" frameborder="0" marginwidth="0" marginheight="0" style="display:none!important;width:0!important;height:0!important" ></iframe>
  <iframe name="modal_popup3_frame" id="modal_popup3_frame" onLoad="return  dashboarAjaxLoad_Div3(this.contentWindow.location.href,false);" src="about:blank" style="display:none!important; width: 0px; height: 0px;" width="0" height="0" frameborder="0" scrolling="no" marginwidth="0" marginheight="0" security="none"></iframe>
</div>
<div class="modalpopup popup_close" id="modalpopup" style="display: none;">
  <div class="modalpopup_form_popup_layer"> </div>
  <div class="modalpopup_body absolute" id="modalpopup_body"> <a class="close_popup modal_popup_close" onClick="document.getElementById('modalpopup').style.display='none';">×</a>
    <div class="modalpopup_cdiv" id="modalpopup_cdiv"> </div>
  </div>
</div>
<div class="modal_popup3_frame_img_div" style="display:none;"><i class="fa-solid fa-spinner fa-spin-pulse fa-5x text-loader"></i></div>
</body>
</html>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
