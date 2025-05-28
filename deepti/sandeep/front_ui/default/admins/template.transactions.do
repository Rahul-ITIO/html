<? if(isset($data['ScriptLoaded'])){	
$post['ViewMode']=='summary';
if(isset($post['ViewMode']) && $post['ViewMode']=='select'){ 
if(isset($_REQUEST['page'])) $curr_pg = $_REQUEST['page'];else $curr_pg=0;
}

function remove_string($removestr){

$removestr=str_replace('<font color="green">','',$removestr);
$removestr=str_replace("<font color='green'>","",$removestr);
$removestr=str_replace('</font>','',$removestr);
$removestr=str_replace("</font>","",$removestr);

return $removestr;
}
?>
<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['transaction_action_checkbox_csv'])&&$_SESSION['transaction_action_checkbox_csv']==1)||(isset($_SESSION['csv_multiple_merchant'])&&$_SESSION['csv_multiple_merchant']==1)){?>

<? if(isset($_REQUEST['date_1st'])&&$_REQUEST['date_1st']&&isset($_REQUEST['date_2nd'])&&$_REQUEST['date_2nd']) { ?>

<div class="modal" id="myModa30">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Download Filter Transaction in CSV Format</h4>
        <button type="button" class="btn-close myModal_close" value="myModa30" data-bs-dismiss="modal88"></button>
      </div>
      <!-- Modal body -->
      <div class="modal-body">
      <? include("../include/transaction-field-list".$data['iex']);
	//include("../include/transaction-csv-data".$data['iex']);
?>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-primary myModal_close" value="myModa30" data-bs-dismiss="modal88">Close</button>
      </div>
    </div>
  </div>
</div>

<? } ?>
<? } ?>
<?
if(isset($_GET['bid']))		$get_bid 	= $_GET['bid'];else $get_bid 		= 0;
if(isset($_GET['type']))	$get_type 	= $_GET['type'];else $get_type 		= 0;
if(isset($_GET['status']))	$get_status = $_GET['status'];else $get_status 	= 0;
if(isset($_GET['page'])) 	$get_page	= $_GET['page'];else $get_page 		= 0;
if(isset($_GET['order']))	$get_order	= $_GET['order'];else $get_order 	= 0;

?>
<script>
// js function for window width and height adjust 
//$( document ).ready(function() {
$(window).bind("load resize scroll",function(){
	$('body').addClass("remove_leftPanel");

	if ($( window ).width() < 769) {
	  //alert('screen width : '+$( window ).width());
	  //$('#sidebar').removeClass("active");  // disable on 12102022 by vikash
	}else{
		$('#sidebar').attr('class','bg-primary active');
		$('#content').attr('class','active');
		$('body').removeClass("is_leftPanel");
	}
});


</script>
<style>

#sidebar { width: 160px !important;}
#sidebar.active { min-width: 40px; }
#content.active { width: calc(100% - 40px) !important;}
/*#content { width:97% }*/

.paginationx {display: flex !important;}
.pagination ul>li>a, .pagination ul>li>span {
    float: left;
    padding: 4px 12px;
    line-height: 20px;
    text-decoration: none;
    background-color: #fff;
    border: 1px solid #ddd;
    border-left-width: 0;
}
ul.pagination2 li a.current, ul.pagination li a.current { 

}
.is_leftPanel #content {width:89% !important;}

a.hrefmodal.mt-2.mx-2.text-decoration-none {
    width: 100px;
    overflow: hidden;
    display: inline-block;
    white-space: nowrap;
    text-overflow: ellipsis;
}

a.hrefmodal.mt-2.mx-2.text-decoration-none {
    width: 99px;
    overflow: hidden;
    display: inline-block;
    white-space: nowrap;
    text-overflow: ellipsis; 
    float: left;
    margin: 0;
    margin-left: 6px !important;
    margin-top: 0 !important;
}

input.echeckid.mt-1.mx-2.float-start.form-check-input {
    float: left !important;
    max-width: 14px;
    min-width: 14px;
    margin-right: 0 !important;
    padding: 0;
}
.rowd2 {width: 93% ;}

.listActive1 a.hrefmodal { color:#CC0000;font-weight: 500;}

.is_leftPanel #content.active {
    width: 97% !important;
}
.dropdown-menu{ font-size:14px !important;}
@media (max-width: 999px) {
	.is_leftPanel #total_record_result {width: 91% !important;}
}
@media only screen and (max-width: 768px){
is_leftPanel .td_relative {width:100% !important;}
.is_leftPanel #content {width:100% !important;}
/*#content {width:100% !important;}*/
.is_leftPanel .td_relative { padding-right:0px !important;}
.is_leftPanel #transaction_display_divid {width:94% !important;}
.hk_sts .dta1 { width: 50% !important;}
}

@media only screen and (max-width: 400px){
.is_leftPanel #content { width: 100% !important; margin-left: 8px !important;}
.remove_leftPanel #content.active { width: calc(100% - 40px) !important;}
}

@media only screen and (max-width: 500px) and (min-width: 464px)  {
.rowd1  { clear:both !important;}
.hk_sts .dta1 { width: 100% !important; }
}


</style>
<style>
.tbl_exl2, .table-responsive {overflow-y: auto;min-height: 1000px;}
<?php if($data['themeName']!='LeftPanel'){ ?>
#transaction_display_divid {position:absolute;width:84%;float:right;z-index:999;right:2.5%;background:#fff;border-radius:3px;padding:10px;/*top:30px;*/left:0;}
<? } else { ?>
#transaction_display_divid {position:absolute;width:94%;float:right;z-index:999;right:2.5%;background:#fff;border-radius:3px;padding:10px;/*top:30px;*/left:0;}
<? } ?>

#transaction_display_divid .chosen-container {width: 100% !important;min-width: 300px !important;}

img.wltcf {width:24px !important;}

.modal_popup_popup_body hr {margin:0;height:1px;max-height:1px;display:block;color:#c61a1a;}

.flag_ td {height: inherit !important;}
	.hkip_status_id.a16 {float:left;margin:0px 0 0 -17px;background:#ccc;height:13px; position:relative;z-index:999999;}
.hkip_status_id.a16.glyphicons i:before {font-size:16px;margin:9px 0 0 8px !important;}
body .daterangeform, body #daterangediv {display:none1 !important;}
/*.rmk_row .rmk_msg {max-width: 900px;}*/
.admins.transactions.bnav #tr_cal_id .row100 {width:96%;}



#modal_popup_iframe_div {overflow:hidden;overflow-y: auto;height:100%;width:100%;}
.hk_sts {/*width:99%;padding:10px 5%;*/}
.hk_sts .rows {float:left;clear:both;width:100%;margin:14px 0;}
.hk_sts .dta1 {float:left;width:25%;line-height:18px;border-bottom:1px solid #ccc;}
.hk_sts .dta1.key{font-weight:bold;}
.hk_sts .dta1.key.h1 {width:100%;clear:both;background:#2d790d;border:0;font-size:14px;text-transform:uppercase;text-align:center;color:#fff;}
.hk_sts .upd_status,.hk_sts .notfound_status {float:left;clear:both;width:100%;text-align:center;margin:5px 0;line-height:30px;border-radius:3px;}
.hk_sts .upd_status {background-color:#dff0d8;font-size:14px;}
.hk_sts .notfound_status {background-color:#ffdede;font-size:14px;}

.reply_supports {margin:0px 0 3px 30%;text-transform:uppercase;font-weight:bold;background:#f00;color:#fff!important;padding:3px 10px;border-radius:3px;display:inline-block;}
.glyphicons.btn-icon i:before {width:36px;padding:5px 0 0;}

#payoutdaterange.glyphicons.btn-icon i:before {font-size:14px; width:30px; height:16px;}
#daterangediv {margin:5px 0; text-align:center; float:left; width:100%; display:black;}
.glyphicons.btn-icon{padding: 2px 7px 5px 35px;}
.payoutpdf_0 {display:inline-block;background: #e8e8e8;padding:5px 10px;border-radius:3px;margin: 5px 0;}
.payoutpdf:hover, .payoutpdf.active{background: #2c84a4;color: #ffef1d !important;}

.field {text-align:right; padding:0 20px 0 0;}
.nomanditory {display:black;}

 body input.search_textbx[type=text] {display:inline-block; }
select {width:83%;}
/*label {float: left;font-size: 14px !important;width: 30%;text-align: right;padding: 5px 2% 0 0;}*/
.mand {color:red;}

.leftsideadmin {display:none !important ;}

.ti {float:left; margin:0 10px 0 0; height:20px; }
.menuchk_div2 {position:relative;top:-3px;display:inline-block;margin:-6px 0 -5px 9px;}
.menuchk_div {padding:0;position:relative; }
/*.menuchk_div  .glyphicons.btn-icon i:before, .menuchk_div2  .glyphicons.btn-icon i:before {padding:2px 0 0;height:19px;   font-size:14px;margin:0 6px 0 -36px;position:relative;float:left;}
.menuchk_div  .glyphicons.btn-icon, .menuchk_div2  .glyphicons.btn-icon { padding: 0px 3px 0px 35px;height:20px;line-height:20px;margin:0;font-size:14px;}*/

/*table tr.flag_1, table tr.flag_1 td {background:#ff0 !important;} */
/*table tr.flag_3, table tr.flag_3 td {background:#fee6d3 !important; padding:5px 0 0 0 !important;}
table tr.flag_2 td {padding:5px 0 0 0 !important;}
table tr.flag_0, table tr.flag_0 td {padding:5px 0 0 0 !important;}

.trc_1 .ulmenu_dropdown {position:absolute;top:-20px;left:0px;   width:48px;padding:0;}
.trc_1.flag_0 .ulmenu_dropdown, .trc_1.flag_2 .ulmenu_dropdown {top:-8px;}

.trc_1 .glyphicons.hand_down i:before {
    left: 13px !important;
    top: 10px !important;
}
.trc_1 .glyphicons.hand_down i{
    width: 40px;
    height: 35px;
    float: left;
    padding: 0;
    margin: 0;
    position: relative;
    top: -5px;
    left: 3px;
}

.trc_1 .open>.dropdown-menu, .trc_1 > li.open> ul {
    top: 29px !important;
	right: -7px !important;
}

.trc_1 .topnav.pull-right.trs > li> a, .trc_1 .topnav.pull-right.trs > li.open> a {
    height: 34px !important;
    width: 45px !important;
    padding: 0 !important;
}

.trc_1 .topnav.pull-right.trs {
   
    width: 40px;
    float: left;
    margin: 0;
    padding: 0;
}*/


.lead_div {position:relative;}

.lead_title {position:absolute;top:17px;z-index:99;color:#222222;font-family:"Raleway", sans-serif;text-shadow:none;padding:0;margin:0;height:25px;font-weight:bold;font-size:14px;}
.progressbar {width:100%;margin-top:5px;margin-bottom:35px;position:relative;background-color:#EEEEEE;box-shadow:inset 0px 1px 1px rgba(0,0,0,.1);}
.proggress{height:8px;width:10px;background-color:#3498db;}
.percentCount{float:right;margin-top:0px;clear:both;font-weight:bold;font-family:Arial}


.check .daterangeform .btn-primary {background:#cab23d;color:#fff;}
.check .daterangeform .btn-primary:hover {background:#ffd60b;color:#fff;}
.card .daterangeform .btn-primary,.card .daterangeform .btn-primary:hover {background:#6de400;color:#fff;}

.card .topnav.pull-right.trs.inline > li > a {background:#ddffbd;}
.check .topnav.pull-right.trs.inline > li > a {background:#ffffb6;}

.commentrow{float:left;width:100%;}
.commentrow .title2{border-top:0;margin:12px 0 5px 0 !important;background:#ccc;padding:1px 1.0% 0px 1.0% !important; }

.ip_view {cursor:pointer;color:#6aa6d2;}

.flagtag{background:#e6e6e6;border-radius:3px;margin:0 3px;padding:0px 8px;color:#333;display:inline-block;line-height:20px;pointer-events:none;}

.content_holder {float:left;width:100%;overflow:hidden;}
.w981{width:100%;float: right;}
/*.w98 {width:92vw;float:left;padding:0 0 0 0;}*/

.strlink.active{background:red;color:#fff !important;}
.summary_main_div table tr:nth-child(1n) td.active{background: #f00;}

.prompt_dialog {display:none;position:fixed;z-index:9999999;width:300px;    height:150px;background:#fff;opacity:1;border-radius:5px;left:50%;top:50%;    margin:-75px 0 0 -150px;border:2px #d2d2d2 solid;}

.ip_count {float:left;width:26%;}
.ip_count .opn_tkt {float:inherit;text-align:center;margin:0;position:relative;  top:5px;background:red !important;color:#fff !important;}
.riskdivid {float:left;width:66%;}

</style>
<script>
var is_account="<?=$post['is_account'];?>";
function filteraction0(e){
	$('.payoutpdf0').removeClass('active');
	$(e).addClass('active');
	//alert($(e).parent().find('.pdfreportcl').attr('href'));
	//newWindow=window.open($(e).parent().find('.pdfreportcl').attr('href')+"&json=1", 'newWindow');
	
	$(e).next().attr('style','display:block !important;left:-3px !important;top:18px !important;');
	
	$.ajax({
		url: $(e).parent().find('.pdfreportcl').attr('href')+"&json=1",
		type: "POST",
		dataType: 'json', 
		data: 'action=pdfreport',
		success: function(results){
			$(e).parent().find('.pdfreportcl span').html(""+results["available_payout"]);
			if(results["settlement_link_view"]=="no"){
			$(e).parent().find('.settledcl').parent().remove();
			}
			if(results["completed_count"]=="0"){
				$(e).parent().find('.settledcl').parent().remove();
			}else{
				$(e).parent().find('.settledcl').parent().attr('data-completed',results["completed_trid"]);
				$(e).parent().find('.settledcl span').html("SETTLED <b>"+results["completed_count"]+"</b>");
			}
			//alert(results["completed_count"]);
		}
	});
	
	$.ajax({
		url: $(e).parent().find('.pdfreportcl_tr').attr('href')+"&json=1",
		type: "POST",
		dataType: 'json', 
		data: 'action=pdfreport',
		success: function(results){
			$(e).parent().find('.pdfreportcl_tr span').html(""+results["available_payout"]);
			if(results["settlement_link_view"]=="no"){
				$(e).parent().find('.settledcl').parent().remove();
			}
			if(results["completed_count"]=="0"){
				$(e).parent().find('.settledcl').parent().remove();
			}else{
				$(e).parent().find('.settledcl').parent().attr('data-completed',results["completed_trid"]);
				$(e).parent().find('.settledcl span').html("SETTLED <b>"+results["completed_count"]+"</b>");
			}
			//alert(results["completed_count"]);
		}
	});
	
	$.ajax({
		url: $(e).parent().find('.pdfreportcl_1').attr('href')+"&json=1",
		type: "POST",
		dataType: 'json', 
		data: 'action=pdfreport',
		success: function(results){
			$(e).parent().find('.pdfreportcl_1 span').html(""+results["available_payout"]);
			setTimeout(function(){ 
				if($(e).parent().find('.pdfreportcl b').text()==$(e).parent().find('.pdfreportcl_1 b').text()){
					$(e).parent().find('.tfcupdate span').html("EQUAL");
				}
			}, 200);
			
		}
	});
			
}
function filteraction(e){
	$('.payoutpdf').removeClass('active');
	$(e).addClass('active');
	
	if($(e).hasClass('settledcl')){
	
		var subparameter7 = $(e).attr('data-href');
		
		//alert(subparameter7);
		
		var promptmsg = prompt("Are you Sure to "+$(e).attr('data-label')+"!", "");
			if (promptmsg == null || promptmsg == ""){
				return false;
			} else {
				var thisurls = subparameter7+"&promptmsg="+$(e).attr('data-reason')+": "+promptmsg;
				//top.window.location.href=thisurls;
				$('#modal_popup_form_popup').slideDown(900);
				$.ajax({url: thisurls, success: function(result){
					//$("#modal_popup_iframe_div").html(result);
					$('#modal_popup_form_popup').slideUp(70);
				}});
				//return false;
			}
	}
	//settledcl
}

 var subparameter4 = "<?php echo $data['cmn_action'];?>";
 
function activeslide(){
	var active_a=$(".collapsea.atablink.active");
	var active_html=active_a.parent().parent().next().find('.collapseitem');
	var ids = active_a.attr('data-href');
	//var tabnames = active_a.attr('data-tabname');
	var dataurl = active_a.attr('data-url');
	var dataturl = active_a.attr('data-turl');
	//alert(active_a+"\r\n"+active_html+"\r\n"+ids+"\r\n"+dataurl+"\r\n"+dataturl);  
	if(dataturl !== undefined){
		//ajaxf2(dataturl+"&action=details",active_html.find('.content_holder'));
		loading_url(dataturl+"&action=details&admin=1",active_html.find('.content_holder'));
	}
	   
	   <? if(!isset($post['bid'])){?>
	   if(dataurl !== undefined){
		//$('.risk_main').remove();
		if(active_html.hasClass('riskactive')){
		
		}else{
			setTimeout(function(){
				$.ajax({url: dataurl, success: function(result){
					//$('#'+ids+' .'+tabnames).before(result);
					//$('#'+ids+' .riskdivid').prepend(result);
					active_html.find('.riskdivid').prepend(result); 
					active_html.addClass('riskactive');
				 }});
			 },300);
			
		}
	   }
	  <? }?>
	  
	 active_html.slideDown(900); 
	 //active_html.slideUp(100); 
}
 
function dialog_f(){
	var email_confirm="";
	if($('#dialog #email_confirm').is(':checked')){
		email_confirm="&email_confirm="+$('#dialog #email_confirm').is(':checked');
	}
	var data_active = $('.dialog_open.active');
	var datahref = $('.dialog_open.active').attr('data-href');
	if(datahref !== undefined){	
		data_active.attr('data-href',data_active.attr('data-href')+"&promptmsg="+data_active.attr('data-reason')+": "+$('#dialog #prompt_msg_input').val()+email_confirm);
		/*
		$('#modal_popup_popup').slideDown(900);
		
		$.ajax({url: data_active.attr('data-href'), success: function(result){
			//$("#modal_popup_iframe_div").html(result);
			$('#modal_popup_form_popup').slideUp(70);
		}});
		*/ 
		if(wn==1){
			window.open(data_active.attr('data-href'), '_blank');popupclose();return false;
		}else{
			$('#modal_popup_form_popup').slideUp(70);
			newWindow=window.open(data_active.attr('data-href'), 'hform');
		}
		
	}
	
	$("#dialog").slideUp(200);

}
 
function dialog_box2f(){
	//data-amount
	var confirm_amount="";
	
	var data_active = $('.dialog_refunded.active');
	var data_amount	= data_active.attr('data-amount');
	var datahref 	= $('.dialog_refunded.active').attr('data-href');
	var datatype 	= $('.dialog_refunded.active').attr('data-type');
	
	//alert('gggg33'); prompt_msg_input_refund promptmsg
	
	
	
	if(datahref !== undefined){	
		data_active.attr('data-href',data_active.attr('data-href')+"&promptmsg="+data_active.attr('data-reason')+": "+$('#dialog_box2 #prompt_msg_input_refund').val()+"&confirm_amount="+$('#dialog_box2 #confirm_amount').val());
		
		if(wn==1){
			window.open(data_active.attr('data-href'), '_blank');popupclose();return false;
		}
		
		
		if($('.dialog_refunded.active').hasClass('new_tab')){
			$('#modal_popup_popup').slideDown(70); 
			newWindow=window.open(data_active.attr('data-href'), 'hform');
			popupclose();
			return false;
		}
		
		if($('.dialog_refunded.active').hasClass('open_pop')){
		
		}else{
			popuploadig();
		}
		
			 
		$("#modal_popup_iframe_div").html("<div class='loading'>Now loading url is : "+data_active.attr('data-href')+".<br/><br/>Please wait...</div>");
		$('#modal_popup_popup').slideDown(70);
		$.ajax({url: data_active.attr('data-href'), success: function(result){
			
			$("#modal_popup_iframe_div").html(result);
			
			if($('.dialog_refunded.active').hasClass('open_pop')){
			
			}else{
				$('#modal_popup_popup').slideUp(70);
				popupclose();
			}
		
			
			
		}});
		
		//$('#modal_popup_popup').slideDown(900);	
		
		
			
		
		

	}
	
	//alert('666');
	$("#dialog_box2").slideUp(200);
	//popupclose();

	
 }
			
 var vc="1";
 
$(document).ready(function(){
	
	
	<? if(isset($_GET['cl'])){?>
		vc="2";
		$('#collapsible1_id').trigger('click');
	<? }?>
	
	$('.topnav_tr').click(function(){
		var collapsea_a= $(this).parent().parent().find('.collapsea.trids');
		if(collapsea_a.hasClass('active')){
		
		}else{
		 collapsea_a.trigger("click");
		}
	}); 
    $('.echektran .collapsea, .atablink').click(function(){
	   $('.addremarkform, .comtabdiv').slideUp(100);
	   var ids = $(this).attr('data-href');
	   var tabnames = $(this).attr('data-tabname');
	   var dataurl = $(this).attr('data-url');
	   var dataturl = $(this).attr('data-turl');
	  
	  if(dataturl !== undefined){
		if($('#'+ids).hasClass('turlactive')){
		
		}else{
		  //alert(dataturl+"&action=details");
		  //ajaxf2(dataturl+"&action=details",$('#'+ids+' .content_holder'));
		  loading_url(dataturl+"&action=details&admin=1",$('#'+ids+' .content_holder'));
		  $('#'+ids).addClass('turlactive');
		}
	   }
	   
	   <? if(!isset($post['bid'])){?>
	   if(dataurl !== undefined){
		//$('.risk_main').remove();
		if($('#'+ids).hasClass('riskactive')){
		
		}else{
			setTimeout(function(){
				$.ajax({url: dataurl, success: function(result){
					//$('#'+ids+' .'+tabnames).before(result);
					//$('#'+ids+' .riskdivid').prepend(result);
					$('#'+ids+' .riskdivid').prepend(result); 
					$('#'+ids).addClass('riskactive');
				 }});
			},300);
		}
	   }
	  <? }?>
	  
	  
	  
		if($(this).hasClass('active')){
			$('.collapseitem').removeClass('active');
			$('.collapsea, .atablink').removeClass('active');
			
			$('#'+ids).slideUp(150);
			$('#'+ids+' .'+tabnames).slideUp(200);
		} else {
		  $('.collapseitem').removeClass('active');
		  $('.collapsea, .atablink').removeClass('active');
		  //$('#'+ids).addClass('active');
		  $(this).addClass('active');
		  
		  $('.collapseitem').slideUp(100);
		  $('#'+ids).slideDown(600);
		  if(tabnames !== undefined){
			$('#'+ids+' .'+tabnames).slideDown(800);
		  }
		}
        
    });
	
	
	
		
	
	$(".echeckid, .echeckidall").click(function(){
		var valuesArray = $('.echeckid:checked').map(function () {  
			return this.value;
		}).get().join(",");
		
		if(valuesArray =="") {
			$('.menuchk_div').slideUp(100);
		}else{
		  //$('.menuchk_div').slideDown(600);
		  $('.menuchk_div').css('display','inline');
		}		
	});
	
	$(".actionlnk_xxx").click(function(){
		var valuesArray = $('.echeckid:checked').map(function () {  
			return this.value;
		}).get().join(",");
		
		var subparameter2 = "<?=$data['Admins'];?>/transactions<?=$data['ex']?>?action="+$(this).attr('data-action')+"&trange="+valuesArray+"<?php echo "&bid=".$get_bid."&type=".$get_type."&status=".$get_status."&page=".$get_page."&order=".$get_order;?>";
		var promptTxt="";
		if($(this).attr('data-label')==="Completed List"){
		   promptTxt="Sent to Bank by Batch no <?=date('Ymd')?> (Check Printed)";
		}else if($(this).attr('data-label')==="Settled List"){
		   promptTxt="Settled by SWIFT Reference";
		}else if($(this).attr('data-label')==="System will send reminder email to customer about the transaction"){
		   promptTxt="Reminder Reason";
		}else if($(this).attr('data-label')==="System will send authorization email to customer about the transaction"){
		   promptTxt="Reason of Authorization Email ";
		}else{
			promptTxt="";
		}
		
		var promptmsg = prompt("Are you Sure to "+$(this).attr('data-label')+"!", promptTxt);
			if (promptmsg == null || promptmsg == "") {
				//txt = "User cancelled the prompt.";
				//alert($(this).attr('data-href'));
				return false;
			} else {
				//txt = "Hello " + promptmsg + "! How are you today?";
				var thisurls = subparameter2+"&promptmsg="+$(this).attr('data-reason')+": "+promptmsg;
				
					$('#modal_popup_form_popup').slideDown(900);
					$.ajax({url: thisurls, success: function(result){
						//$("#modal_popup_iframe_div").html(result);
						$('#modal_popup_form_popup').slideUp(70);
					}});
				
				//top.window.location.href=thisurls;
				//return false;
			}
		
		
	});
	
	
	$(".actionlnk").click(function(){
		var valuesArray = $('.echeckid:checked').map(function () {  
			return this.value;
		}).get().join(",");
		
		//Creating Array to execute one by one
		var ary=new Array();
		ary = valuesArray.split(",");
		var count=ary.length;
		my_value="<center>Total Length: "+count+"</center>";
		my_value="<br><br><center>"+$(this).val()+" Total Length: "+count+"</center>";
		$('#modal_popup_iframe_div').html(my_value);
		
		var data_action=$(this).attr('data-action');

		var promptTxt="";
		
		var datareason = $(this).attr('data-reason');
		if(datareason !== undefined){ promptTxt=datareason; }
		
		var alertType="prompt";
		var dataAlert = $(this).attr('data-alert');
		if(dataAlert !== undefined){ alertType=dataAlert; }
		
		if($(this).attr('data-label')==="Completed List"){
		   promptTxt="Sent to Bank by Batch no <?=date('Ymd')?> (Check Printed)";
		}else if($(this).attr('data-label')==="Settled List"){
		   promptTxt="Settled by SWIFT Reference";
		}else if($(this).attr('data-label')==="System will send reminder email to customer about the transaction"){
		   promptTxt="Reminder Reason";
		}else if($(this).attr('data-label')==="System will send authorization email to customer about the transaction"){
		   promptTxt="Reason of Authorization Email ";
		}else{
			//promptTxt="";
		}
		
		if(alertType==="confirm"){
			var promptmsg = confirm("Are you Sure to "+$(this).attr('data-label')+"!");
		} else {
			var promptmsg = prompt("Are you Sure to "+$(this).attr('data-label')+"!", promptTxt);
		}
		
			if (promptmsg == null || promptmsg == "") {
				//txt = "User cancelled the prompt.";
				//alert($(this).attr('data-href'));
				return false;
			} else {
				//txt = "Hello " + promptmsg + "! How are you today?";
				var thisurl = "&promptmsg="+$(this).attr('data-reason')+": "+promptmsg;
					$('#modal_popup_popup').slideDown(900);
					popuploadig();
					
				
				var i=0;					
				function f() {
					c=i+1;
					//alert("ary=>"+ary[i]+", i=>"+i+", c=>"+c);
					if(data_action==='sendtobank' || data_action==='utrnstatus'){
						var subparameter2 = "<?=$data['Host'];?>/nodal/"+data_action+"<?=$data['ex']?>?action="+data_action+"&transID="+ary[i]+"<?php echo "&bid=".$get_bid."&type=".$get_type."&status=".$get_status."&page=".$get_page."&order=".$get_order?>&admin=1&actionurl=admin_direct";
					}else{
						var subparameter2 = "<?=$data['Admins'];?>/transactions<?=$data['ex']?>?action="+data_action+"&trange="+ary[i]+"<?php echo "&bid=".$get_bid."&type=".$get_type."&status=".$get_status."&page=".$get_page."&order=".$get_order?>";
					}
					
					thisurls=subparameter2+thisurl;
					
					
					
					response="<center><br>In Process... "+c+"<br><br><b>Do not close the window. Please wait...</b></center><br>";
					if (c==count){response="<center><br>All Process completed.<BR><BR>You may close the Window.</center>";}
					
					if(wn){
						popupclose();window.open(thisurls, '_blank');return false;
					}
					
					$.ajax({url: thisurls, success: function(result){
						//alert(thisurls);
						results="<center><br>Result=> <b>"+result+"</b><br></center><br>";
						$('#modal_popup_iframe_div').html(my_value+response+results);
						if( i < count ){setTimeout( f, 2000 );}
						
						if (c==count){
							setTimeout(function(){
								$('#modal_popup_popup').slideUp(70);
								popupclose();
							 }, 3000 );
						}
						
					}});
					
					i++;
					
				}// End Fnction F

				
				f();
			}
	});
	
	
	$('.transactions .search_textbxXXX').on('keyup',function(event){
	  if(event.keyCode == 13){
	   var keyname = $('#search_keyname').val();
		//alert(subparameter4);
		if(keyname==="9"){
			top.window.location.href="<?=$data['Admins']?>/merchant<?=$data['ex']?>?action=detail&type=active&id="+$(this).val(); // +"&type=-1&status=-1";
		}else if(keyname==="10"){
			top.window.location.href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?action=select&status=-1&type=-1&bid="+$(this).val(); // +"&type=-1&status=-1";
		}else{
			top.window.location.href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?"+"action=select&keyname="+keyname+"&searchkey="+$(this).val()+subparameter4; // +"&type=-1&status=-1";
		}
		$(this).click();
	  }
	});
	
	$(".viewthistrans").click(function(){
		var thisText = $(this).text().replace("R","");
		top.window.location.href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?"+"action=select&keyname=17&searchkey="+thisText+"&type=-1&status=-1";//+subparameter4;
	});
	
	$('.add_remark_submit').click(function(){
		$('#modal_popup_popup').slideDown(900);
	});
	
	$('.ip_view').each(function(){	
		$(this).replaceWith($('<a class="ip_viewa" target="geojson" href="http://www.geoplugin.net/json.gp?jsoncallback=' + $.trim($(this).text()) + '">' + $.trim($(this).text()) + '</a>'));
	});
	
	$('.ip_view1').click(function(){	
		var subqry=$.trim($(this).text());
		//var urls="http://www.geoplugin.net/json.gp?ip="+subqry;
		var urls="http://www.geoplugin.net/json.gp?jsoncallback="+subqry;
		$("#modal_popup_iframe_div").html("<div class='loading'>Now loading url is : "+urls+".<br/><br/>Please wait...</div>");
		
		$("#modal_popup_iframe_div").html('<iframe src='+urls+' width="100%" height="350" scrolling="no" frameborder="0" marginwidth="0" marginheight="0" style="width:98%!important;height:350px!important;display:block;margin:20px auto;" ></iframe>');
		/*
		$.ajax({type:"GET",async:false,url:urls,dataType:'jsonp', success: function(result){
			$("#modal_popup_iframe_div").html(result);
		}});
		*/
		$('#popup').slideDown(900);
    });
	
	$('.dialog_open').click(function() {
		var prompt_msg_value="";
		var datavalue = $(this).attr('data-value');
		if(datavalue !== undefined){
			prompt_msg_value=datavalue;
		}
		$('#dialog #prompt_msg_input').val(prompt_msg_value);
		$('#dialog #email_confirm').prop('checked', true);
		
		
		$('.dialog_open').removeClass('active');
		$("#dialog").removeClass('active');
		$(this).addClass('active');
		$("#dialog").addClass('active');
		$("#dialog").slideDown(700);
		var datalabel = $(this).attr('data-label');
		if(datalabel !== undefined){
			$("#dialog #ui_id_1").html(datalabel);
		}
	});
	
	$('#dialog #prompt_msg_input').on('keyup',function(event){
		if(event.keyCode == 13){
			dialog_f();
			$(this).click();
		}
	});
	
	$('#dialog #email_confirm_submit').click(function() {
		dialog_f();
	});
	
	$('#dialog .email_confirm_close').click(function() {
		$("#dialog").removeClass('active');
		$('.dialog_open').removeClass('active');
		$("#dialog").slideUp(200);
	});
	
	
	
	
	$('.dialog_refunded').click(function() {
		//alert('gggg00');
		$('#dialog_box2 #prompt_msg_input').val('');
		
		$('.dialog_refunded').removeClass('active');
		$("#dialog_box2").removeClass('active');
		$(this).addClass('active');
		$("#dialog_box2").addClass('active');
		$("#dialog_box2").slideDown(700);
		var datalabel = $(this).attr('data-label');
		
		var data_active = $('.dialog_refunded.active');
		var data_amount	= data_active.attr('data-amount');
		var datarefund = $(this).attr('data-refund');
		
		
		$('#dialog_box2 #confirm_amount').val(data_amount);
		$('#dialog_box2 #order_amount').html(data_amount);
	
		if(datalabel !== undefined){
			$("#dialog_box2 #ui_id_1").html(datalabel);
		}
		if(datarefund !== undefined && datarefund){
			$("#refund_req_id").html('');			
		}
		else
		{
			if($(this).hasClass('withdraw')||$(this).hasClass('type_2')||$(this).hasClass('type_3')){
				
			}else{

				$("#refund_req_id").html('Refund for this acquirer is not available. Do you want to proceed manual');
				$("#confirm_amount").hide();
				$("#prompt_msg_input_refund").hide();
			}
		}
	});
	$('#dialog_box2 #prompt_msg_input').on('keyup',function(event){
		//alert('gggg11');
		if(event.keyCode == 13){
			//alert('gggg22');
			dialog_box2f();
			$(this).click();
		}
	});
	$('#dialog_box2 #confirm_amount_submit').click(function() {
		dialog_box2f();
	});
	$('.dialog_box2').click(function() {
		$("#dialog_box2").removeClass('active');
		$('.dialog_refunded').removeClass('active');
		$("#dialog_box2").slideUp(200);
	});
	
	$('#dialog_box2 #confirm_amount').on('keyup',function(event){
		var order_amt=parseFloat($('#dialog_box2 #order_amount').text());
		if ($(this).val() > order_amt){
			alert("Please enter the amount less than or equal to "+order_amt);
			$(this).val(order_amt);
		}
		if ($(this).val() < 0){
			alert("Can not enter the amount not less than 0");
			$(this).val(order_amt);
		}
	});


		
	
	
	
});

var wn="";

function check_statusf(e,statusUrl='') {
	var transID=$(e).attr('data-transID');
	var acctype=$(e).attr('data-type');
	
	if(wn==1){
		popupclose();nw(statusUrl);exit;
	}
	
	$("#modal_popup_iframe_div").html("<div class='loading'>Now loading url is : "+statusUrl+" <br/><br/>Please wait...</div>");
	
	$.ajax({url: statusUrl, success: function(result){
		$("#modal_popup_iframe_div").html(result);
	}});
	
	$('#modal_popup_popup').slideDown(900);	
	
	
}

function checkwithdrawMin(e)
{
	var payout_amount = parseFloat($('.formDiv #payout_amount').val());
	var withdrawMin = parseFloat($('.formDiv #withdrawMin').val());
	var network_fee = parseFloat($('.formDiv #network_fee').val());
	
	
	
	if(payout_amount<withdrawMin && withdrawMin>0)
	{
		alert("Minimum Payout Amount is : "+withdrawMin);
		return false;
	}
	else if(payout_amount<network_fee && network_fee>0)
	{
		alert("Payout Amount should be more than Network Fee ("+parseFloat(network_fee).toFixed(2)+")");
		return false;
	}
	else
		document.getElementById('modal_popup_form').style.display='none';
	
	
	document.getElementById('modal_popup_popup').style.display='block';
	
	e.preventDefault();
	//return true;
}


function hkipstatus(e,theValue='') {
	
	var mhoids=$(e).attr('data-mhoid');
	var acctype=$(e).attr('data-type');
	var dataaction=$(e).attr('data-action');
	 //alert(mhoids);
	var site_id=mhoids.split("_");
	 site_id=site_id[4];
	//alert(site_id);
	
	
	var actionurl = "by_admin";
	if(dataaction !== undefined){
		actionurl = dataaction;
	}
	
	
	var subqry="?mh_oid="+mhoids+"&actionurl="+actionurl+"&type="+acctype;
	
	//subqry="";
	var urls="";
	if(acctype==22||acctype==21){
		urls="<?php echo $data['Host'];?>/update_status<?=$data['ex']?>"+subqry;
	}
	else if(acctype==26||acctype==27||acctype==28){
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		urls="<?php echo $data['Host'];?>/bankstatus<?=$data['ex']?>"+subqry;
		
		//window.open(urls, '_blank');
	}
	else if(acctype==14||acctype==15||acctype==16){
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		urls="<?=$data['Host'];?>/api/pay15/status_15<?=$data['ex']?>"+subqry;
		
		//window.open(urls, '_blank');
	}
	else if(acctype==24){
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		urls="<?php echo $data['Host'];?>/update_status24<?=$data['ex']?>"+subqry;
	}else if(acctype==9||acctype==10||acctype==11){
		urls="<?php echo $data['Host'];?>/include/update_status_ch<?=$data['ex']?>"+subqry;
	}
	else if(acctype==999929){
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1&limit1=1&pop=2";
		popuploadig();
		urls="<?php echo $data['Host'];?>/api/3d29/processed_list<?=$data['ex']?>"+subqry;
		popupclose();
		window.open(urls, '_blank');
		return false;
	}else if(acctype==29){
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1&limit1=1&pop=2";
		urls="<?php echo $data['Host'];?>/api/3d29/processed_list<?=$data['ex']?>"+subqry;
	}
	else if(acctype==30){
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		
		urls="<?php echo $data['Host'];?>/api/pay30/processed<?=$data['ex']?>"+subqry;
	}
	else if(acctype==31||acctype==32){
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		
		urls="<?php echo $data['Host'];?>/api/3d31/processed4<?=$data['ex']?>"+subqry;
	}
	else if(acctype==34||acctype==341||acctype==342){
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		
		urls="<?php echo $data['Host'];?>/api/34/processed_url<?=$data['ex']?>"+subqry;
	}
	else if((acctype==35)||(acctype>350&&acctype<375)){
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		
		urls="<?php echo $data['Host'];?>/api/pay35/processed<?=$data['ex']?>"+subqry;
	}
	else if((acctype==43)){
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		
		urls="<?php echo $data['Host'];?>/api/pay43/status<?=$data['ex']?>"+subqry;
	}else if((acctype==44)){
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		
		urls="<?php echo $data['Host'];?>/api/pay44/status<?=$data['ex']?>"+subqry;
	}else if((acctype==46)){
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		
		
		urls="<?php echo $data['Host'];?>/api/pay46/status46<?=$data['ex']?>"+subqry;
	}else if((acctype==48)){
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		
		urls="<?php echo $data['Host'];?>/api/pay48/status_48<?=$data['ex']?>"+subqry;
	}else if((acctype==52)||(acctype>520&&acctype<590)){
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		
		urls="<?php echo $data['Host'];?>/api/3d52/processed<?=$data['ex']?>"+subqry;
	}
	else if((acctype==60)){
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		
		urls="<?php echo $data['Host'];?>/api/pay60/status<?=$data['ex']?>"+subqry;
	}else if((acctype==601 || acctype==602|| acctype==603|| acctype==604)){
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		
		urls="<?php echo $data['Host'];?>/api/pay60/status601<?=$data['ex']?>"+subqry;
	}
	else if((acctype==61)||(acctype>610&&acctype<690)){
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		
		urls="<?php echo $data['Host'];?>/api/pay61/status<?=$data['ex']?>"+subqry;
	}
	else if(acctype==37){
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		
		urls="<?php echo $data['Host'];?>/api/pro37/processed<?=$data['ex']?>"+subqry;
	}
	else if((acctype==38)||(acctype>380&&acctype<410)){
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		
		urls="<?php echo $data['Host'];?>/api/proc38/processed<?=$data['ex']?>"+subqry;
	}
	else if(acctype==18){
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		
		urls="<?php echo $data['Host'];?>/api/pay18/processed<?=$data['ex']?>"+subqry;
	}
	else if(acctype==42){
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		
		urls="<?php echo $data['Host'];?>/api/pay42/processed<?=$data['ex']?>"+subqry;
	}
	else if(acctype==19){
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		
		urls="<?php echo $data['Host'];?>/api/pay19/processed<?=$data['ex']?>"+subqry;
	}
	else if(acctype==343){
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		
		urls="<?php echo $data['Host'];?>/api/pro343/processed<?=$data['ex']?>"+subqry;
	}
	else if(acctype==17||acctype==171){
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		
		urls="<?php echo $data['Host'];?>/api/cont17/processed<?=$data['ex']?>"+subqry;
	}
	else if(acctype>=1113){
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		
		urls="<?php echo $data['Host'];?>/nodal/n"+acctype+"/status_"+acctype+"<?=$data['ex']?>"+subqry;
	}
	else if(acctype==2){
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		if(theValue=='binance'){
			urls="<?php echo $data['Host'];?>/nodal/binance_status<?=$data['ex']?>"+subqry;
		}else{
			urls="<?php echo $data['Host'];?>/nodal/utrnstatus<?=$data['ex']?>"+subqry;
		}
	}else{
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		if(acctype==345 || acctype==346 || acctype==347){
			acctype=34;
		}
		urls="<?=$data['Host'];?>/api/pay"+acctype+"/status_"+acctype+"<?=$data['ex']?>"+subqry;
		
		//window.open(urls, '_blank');
	}
	
	
	
	//alert(urls);exit;
	//window.open(urls, '_blank');
	if(wn==1){
		window.open(urls, '_blank');popupclose();exit;
	}
	
	//$("#modal_popup_iframe_div").html("<div class='loading'>Now loading url is : "+urls+" <br/><br/>Please wait...</div>");
	
	$.ajax({url: urls, success: function(result){
		//$("#modal_popup_iframe_div").html(result);
		$('#myModal .modal-body').html(result);
		$('#myModal .modal-body').addClass("text-break");
		$('#myModal .modal-dialog').css({"max-width":"90%"});
		$('#myModal .modal-title').html("");
		$('#myModal').modal('show');
	}});
	
	//$('#modal_popup_popup').slideDown(900);	

}

/////////////// post_Withdraw - start (Function for send request as per MID - 

function post_Withdraw(e,theValue='') {

	var mhoids=$(e).attr('data-mhoid');
	var acctype=$(e).attr('data-type');
	var dataaction=$(e).attr('data-action');
	
	var actionurl = "by_admin";
	if(dataaction !== undefined){
		actionurl = dataaction;
	}

	var subqry="?mh_oid="+mhoids+"&actionurl="+actionurl+"&type="+acctype;

	var urls="";
	if(acctype==1111){	//hit binance API page
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		urls="<?php echo $data['Host'];?>/nodal/binance_status<?=$data['ex']?>"+subqry;
	}else if(acctype==1112){	//hit Cashfree Nodal API page
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";
		urls="<?php echo $data['Host'];?>/nodal/cashfree<?=$data['ex']?>"+subqry;
	}else{	//hit Bank pages as Bank
		subqry="?transID="+mhoids+"&actionurl="+actionurl+"&type="+acctype+"&admin=1";

		if(theValue.length>0) subqry=subqry+'&method='+theValue;

		urls="<?=$data['Host'];?>/nodal/n"+acctype+"/payment_"+acctype+"<?=$data['ex']?>"+subqry;
	}

	if(wn==1){
		window.open(urls, '_blank');popupclose();exit;
	}
	
	$.ajax({url: urls, success: function(result){
		$('#myModal .modal-body').html(result);
		$('#myModal .modal-body').addClass("text-break");
		$('#myModal .modal-dialog').css({"max-width":"90%"});
		$('#myModal .modal-title').html("");
		$('#myModal').modal('show');
	}});
}
//////////////post_Withdraw - end

function confirm2(e) {
	//alert($(e).attr('data-href')+"\r\n"+top.window.location.href);
    var txt;
	var promptvar = $(e).attr('data-prompt');
	
	var promptTxt = $(e).attr('data-reason');
	 
	if(promptvar !== undefined){
		var promptmsg = "noprompt";
	 }else{
	 //Are you Sure to
	    var promptmsg = prompt(" "+$(e).attr('data-label')+"!", promptTxt);
	}
    if (promptmsg == null || promptmsg == "") {
        //txt = "User cancelled the prompt.";
		//alert($(e).attr('data-href'));
		return false;
    } else {
        //txt = "Hello " + promptmsg + "! How are you today?";
		if(promptmsg=="noprompt"){
			
		}else{
			$(e).attr('data-href',$(e).attr('data-href')+"&promptmsg="+promptmsg);
		}
		//alert($(e).attr('data-href'));
		
		if(wn==1){
			window.open($(e).attr('data-href'), '_blank');popupclose();exit;
		}
		
		if($(e).hasClass('ajxstatus')){
			  $('#modal_popup_form_popup').slideDown(900);
				$.ajax({url: $(e).attr('data-href'), success: function(result){
					//$("#modal_popup_iframe_div").html(result);
					$('#modal_popup_form_popup').slideUp(70);
					activeslide();
				}});
		}else{
			top.window.location.href=$(e).attr('data-href');
		}
		//return false;
    }
   // document.getElementById("demo").innerHTML = txt;
   
}
function supportNoteCon(e) {
    var retVal = confirm("This will be visible to Merchant");
    if (retVal) {
       // alert("Do you want Support Note ?");
        return true;
    } else {
        $(e).prop('checked',false);
		$(e).parent().find('.systemNote').prop('checked',true);
        return false;
    }
}

function view_calc1(e) {
    <? if(!isset($_GET['cl'])){?>
		if(vc=="1"){
			vc=2;
			$('#collapsible1_id').trigger('click');
			window.location.href=window.location.href+'&cl=1';
			popuploadig();
		}
	<? }?>
}
function view_calc(e) {
    
	if(vc=="1"){
		vc=2;
		popuploadig();
		
		var thisUrls1="<?=$cl=str_replace('/transactions','/transaction_list_calc',$data['urlpath']);?>";

		$.ajax({url: thisUrls1, success: function(result){
			$(".tr_cal_id").html(result);
			popupclose();
		}});

		
	}
	
}
</script>

<div class="container border my-1 rounded" >

  <div class="table-responsive-sm00 vkg">
    

          <? if($post['ViewMode']=='select'){ ?>
          <div id="dialog" class="hide prompt_dialog">
            <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix" style="height:24px;line-height:24px;"><span id="ui_id_1" class="ui-dialog-title ms-2" style="color: #0071bc;margin: 0px 0 0;font-size: 14px !important;">Submit</span><a class="ui-dialog-titlebar-close ui-corner-all email_confirm_close" role="button" style="float:right;"><span class="ui-icon ui-icon-closethick mx-3"><i class="<?=$data['fwicon']['circle-cross'];?>"></i></span></a></div>
            <div  class="mx-2">
              <input type="text" value="" name="prompt_msg_input" id="prompt_msg_input" class="form-control  my-2" style="min-width:275px!important;" />
              <input type="checkbox" id="email_confirm" name="email_confirm" value="Yes" class="r2 form-check-input mb-2" />
              <label class="l2" for="email_confirm"> Email</label>
              <div class="ui-dialog-buttonset">
                <button id="email_confirm_submit" type="submit" name="cardsend" value="CHECKOUT" class="submit btn btn-icon btn-primary btn-sm" ><i class="<?=$data['fwicon']['check-circle'];?>"></i><b class="contitxt"> Submit</b></button>
                <button type="submit" name="cardsend" value="CHECKOUT" class="email_confirm_close btn btn-icon btn-primary btn-sm" ><i class="<?=$data['fwicon']['circle-cross'];?>"></i><b class="contitxt"> Cancel</b></button>
              </div>
            </div>
          </div>
          <div id="dialog_box2" class="hide prompt_dialog" style="height:210px;margin: -95px 0 0 -150px;">
            <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix" ><span id="ui_id_1" class="ui-dialog-title ms-2" style="color: #0071bc;margin: 0px 0 0;font-size: 14px !important;">Refunded</span><a class="ui-dialog-titlebar-close ui-corner-all dialog_box2" role="button" style="float:right;"><span class="ui-icon ui-icon-closethick mx-3" ><i class="<?=$data['fwicon']['circle-cross'];?>"></i></span></a></div>
            <div  class="mx-2"> Order Amount : <b id="order_amount">0.00</b>
              <input type="text" id="confirm_amount" name="confirm_amount" value="" class="form-control mt-2" style="min-width:275px!important;" placeholder="Enter Partial Refund" />
              <input type="text" value="" class="form-control mt-2" name="prompt_msg_input" id="prompt_msg_input_refund" style="min-width:275px!important;" placeholder="Enter Comment" />
              <div id="refund_req_id"></div>
              <div class="ui-dialog-buttonset my-2" >
                <button id="confirm_amount_submit" type="submit" name="cardsend" value="CHECKOUT" class="submit btn btn-icon btn-primary btn-sm" ><i class="<?=$data['fwicon']['check-circle'];?>"></i><b class="contitxt"> Submit</b></button>
                <button type="submit" name="cardsend" value="CHECKOUT" class="dialog_box2 btn btn-icon btn-primary btn-sm" ><i class="<?=$data['fwicon']['circle-cross'];?>"></i><b class="contitxt"> Cancel</b></button>
              </div>
            </div>
          </div>
          <table class="frame echektran" >
            <tr>
              <td class="row" style="position:relative;" ><div class="container col-sm-12 text-start my-2" >
                  <!--style="width:82vw;"-->
                  <div class="float-start">
                    <form method="post" name="displayOption" id="displayOption" style="margin:0; padding:0;" action="transactions<?=$data['ex'];?>" >
                      <input type="hidden" name="action" value="transaction_display"  />
                      <input type="hidden" name="rurl" value='<?=$data['urlpath'];?>'  />
                      <div class="" style="margin-top: -2px;">
                        <? if(isset($post['status']) && $post['status']<0){?>
                        <span  class="text-warning">All Transactions</span>
                        <? }else{?>
                        <span  class="text-warning"><?=ucwords($data['TransactionStatus'][$post['status']])?></span>
                        <? } ?>
                        <? if($data['tr_count']>0){?>: <?=$data['result_count'];?> of <?=$data['tr_count'];?> <? } ?>
                        
                        <a title="Transaction Display Option" data-bs-toggle="tooltip" data-bs-placement="right" class="btn btn-primary btn-sm" onclick="view_next3(this,'')"><i class="<?=$data['fwicon']['transaction-display-option'];?>"></i></a>
                        <div id="transaction_display_divid" class="hide" style="float:right;right:0;">
                          <select id="transaction_display" data-placeholder="Transaction Display Option"  multiple class="chosen-select chosen-rtl1 form-select" name="transaction_display[]">
                            <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_transaction_id'])&&$_SESSION['tr_transaction_id']==1)){?>
                            <option value="transaction_id" data-placeholder="Payment ID" title="Payment ID">Payment ID</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_mrid'])&&$_SESSION['tr_mrid']==1)){?>
                            <option value="mrid" data-placeholder="M.OrderId" title="M.OrderId">M.OrderId</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_names'])&&$_SESSION['tr_names']==1)){?>
                            <option value="names" data-holder="Customer Name" title="Customer Name">Customer Name</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_amount'])&&$_SESSION['tr_amount']==1)){?>
                            <option value="amount" data-holder="Order Amount" title="Order Amount">Order Amount</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_transaction_amt'])&&$_SESSION['tr_transaction_amt']==1)){?>
                            <option value="transaction_amt" data-holder="Trans.Amt." title="Trans.Amt.">Trans.Amt.</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_available_balance'])&&$_SESSION['tr_available_balance']==1)){?>
                            <option value="available_balance" data-holder="Balance" title="Balance">Balance</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_tdate'])&&$_SESSION['tr_tdate']==1)){?>
                            <option value="tdate" data-holder="Timestamp" title="Timestamp">Timestamp</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_cardtype'])&&$_SESSION['tr_cardtype']==1)){?>
                            <option value="cardtype" data-holder="Visa;MasterCard" title="Visa,MasterCard">Source - Card Type</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_reason'])&&$_SESSION['tr_reason']==1)){?>
                            <option value="reason" data-holder="Transaction-Bank Reason" title="Transaction-Bank Reason">Reason</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_type'])&&$_SESSION['tr_type']==1)){?>
                            <option value="type" data-holder="Acquirer No." title="Acquirer No.: 16;18:19;27;">Acquirer</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_status'])&&$_SESSION['tr_status']==1)){?>
                            <option value="status" data-holder="Status" title="Status: 0;1;2;">Status</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_receiver'])&&$_SESSION['tr_receiver']==1)){?>
                            <option value="receiver" data-holder="Receiver" title="Receiver">Receiver</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_txn_value'])&&$_SESSION['tr_txn_value']==1)){?>
                            <option value="txn_value" data-holder="Bank Response" title="Bank Response">Bank Response</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_json_value'])&&$_SESSION['tr_json_value']==1)){?>
                            <option value="json_value" data-holder="Post Json for Bank" title="Post Json for Bank">Post Json for Bank</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_currname'])&&$_SESSION['tr_currname']==1)){?>
                            <option value="currname" data-holder="Order Currency" title="Order Currency">Order Currency</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_remark'])&&$_SESSION['tr_remark']==1)){?>
                            <option value="remark" title="Note Merchant">Note Merchant</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_reply_remark'])&&$_SESSION['tr_reply_remark']==1)){?>
                            <option value="reply_remark" title="Note Support">Note Support</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_ccno'])&&$_SESSION['tr_ccno']==1)){?>
                            <option value="ccno" title="Card Number">Card Number</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_source_url'])&&$_SESSION['tr_source_url']==1)){?>
                            <option value="source_url" title="Source Url">Source Url</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_notify_url'])&&$_SESSION['tr_notify_url']==1)){?>
                            <option value="notify_url" title="Notify Url">Notify Url</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_success_url'])&&$_SESSION['tr_success_url']==1)){?>
                            <option value="success_url" title="Success Url">Success Url</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_failed_url'])&&$_SESSION['tr_failed_url']==1)){?>
                            <option value="failed_url" title="Failed Url">Failed Url</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_transID'])&&$_SESSION['tr_transID']==1)){?>
                            <option value="transID" title="Orderset">Orderset</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_system_note'])&&$_SESSION['tr_system_note']==1)){?>
                            <option value="system_note" title="Note System">Note System</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_mdr_amt'])&&$_SESSION['tr_mdr_amt']==1)){?>
                            <option value="mdr_amt" title="Discount Rate">Discount Rate</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_mdr_txtfee_amt'])&&$_SESSION['tr_mdr_txtfee_amt']==1)){?>
                            <option value="mdr_txtfee_amt" title="Transaction Fee">Transaction Fee</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_rolling_amt'])&&$_SESSION['tr_rolling_amt']==1)){?>
                            <option value="rolling_amt" title="Rolling Fee">Rolling Fee</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_mdr_cb_amt'])&&$_SESSION['tr_mdr_cb_amt']==1)){?>
                            <option value="mdr_cb_amt" title="Fee">Fee</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_mdr_cbk1_amt'])&&$_SESSION['tr_mdr_cbk1_amt']==1)){?>
                            <option value="mdr_cbk1_amt" title="Predispute Fee">Predispute Fee</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_mdr_refundfee_amt'])&&$_SESSION['tr_mdr_refundfee_amt']==1)){?>
                            <option value="mdr_refundfee_amt" title="Refund Fee">Refund Fee</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_payable_amt_of_txn'])&&$_SESSION['tr_payable_amt_of_txn']==1)){?>
                            <option value="payable_amt_of_txn" title="Payout Amount">Payout Amount</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_payout_date'])&&$_SESSION['tr_payout_date']==1)){?>
                            <option value="payout_date" title="Payout Date">Payout Date</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_risk_ratio'])&&$_SESSION['tr_risk_ratio']==1)){?>
                            <option value="risk_ratio" title="Risk Ratio">Risk Ratio</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_transaction_period'])&&$_SESSION['tr_transaction_period']==1)){?>
                            <option value="transaction_period" title="Transaction Period">Transaction Period</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_bank_processing_amount'])&&$_SESSION['tr_bank_processing_amount']==1)){?>
                            <option value="bank_processing_amount" title="Bank Processing Amount">Bank Processing Amount</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_bank_processing_curr'])&&$_SESSION['tr_bank_processing_curr']==1)){?>
                            <option value="bank_processing_curr" title="Bank Processing Currency">Bank Processing Currency</option>
                            <? }if((isset($_SESSION['login_json_value']))||(isset($_SESSION['tr_json_value'])&&$_SESSION['tr_json_value']==1)){?>
                            <option value="json_value" title="Json Value">Json Value</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_created_date'])&&$_SESSION['tr_created_date']==1)){?>
                            <option value="created_date" title="Created Date">Created Date</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_txn_id'])&&$_SESSION['tr_txn_id']==1)){?>
                            <option value="txn_id" data-placeholder="Bank Txn ID" title="Bank Txn ID">RefNo. Bank Txn ID</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_trname'])&&$_SESSION['tr_trname']==1)){?>
                            <option value="trname" data-holder="wd;wr;dp;cn;ch" title="wd;wr;dp;cn;ch">Payment Type</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_email_add'])&&$_SESSION['tr_email_add']==1)){?>
                            <option value="email_add" data-holder="Email for Transaction" title="Email for Transaction">Email</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_phone_no'])&&$_SESSION['tr_phone_no']==1)){?>
                            <option value="phone_no" data-holder="Phone for Transaction" title="Phone for Transaction">Phone</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_store_id'])&&$_SESSION['tr_store_id']==1)){?>
                            <option value="store_id" data-holder="Website ID" title="Website ID">Website ID</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_product_name'])&&$_SESSION['tr_product_name']==1)){?>
                            <option value="product_name" data-holder="Product Name" title="Product Name">Product Name</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_address'])&&$_SESSION['tr_address']==1)){?>
                            <option value="address" data-holder="Address" title="Address">Address</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_city'])&&$_SESSION['tr_city']==1)){?>
                            <option value="city" data-holder="City" title="City">City</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_state'])&&$_SESSION['tr_state']==1)){?>
                            <option value="state" data-holder="State" title="State">State</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_country'])&&$_SESSION['tr_country']==1)){?>
                            <option value="country" data-holder="Country" title="Country">Country</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_zip'])&&$_SESSION['tr_zip']==1)){?>
                            <option value="zip" data-holder="Zip" title="Zip">Zip</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_descriptor'])&&$_SESSION['tr_descriptor']==1)){?>
                            <option value="descriptor" data-holder="Descriptor" title="Descriptor">Descriptor</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_ip'])&&$_SESSION['tr_ip']==1)){?>
                            <option value="ip" data-holder="IP" title="IP">IP</option>
                            <? }if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_upa'])&&$_SESSION['tr_upa']==1)){?>
                            <option value="upa" data-holder="Unique Payment Address" title="Unique Payment Address">UPA</option>
                            <? }?>
                            <? if($data['con_name']=='clk'){?>
                            <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_gst_fee'])&&$_SESSION['tr_gst_fee']==1)){?>
                            <option value="gst_fee" data-holder="GST Fee" title="GST Fee">GST Fee</option>
                            <? } ?>
                            <? } ?>
							<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_rrn'])&&$_SESSION['tr_rrn']==1)){?>
								<option value="rrn" data-holder="RRN" title="RRN.">RRN</option>
							<? } ?>
                          </select>
                          <script>
				$("#transaction_display").val([<?=($_SESSION['transaction_display']);?>]).trigger("change"); 
				$("#transaction_display").trigger("chosen:updated");
				
			  </script>


<?php /*?><!--<div class="bg-light">-->
<input class="input_s btn btn-primary btn-sm my-2" type="submit" id="display_submit" name="display_submit" value="Submit"  />
<input class="input_s btn btn-primary btn-sm search multch select my-2" type="button" id="display_select_all" name="select_all" value="Select All"  />
<input class="input_s btn btn-primary btn-sm search multch deselect my-2" type="button" id="display_deselect_all" name="deselect_all" value="Deselect All"  /><?php */?>

<!--<div class="bg-light">-->
<button class="input_s btn btn-primary btn-sm my-2" type="submit" id="display_submit" name="display_submit" value="Submit" title="Submit" data-bs-toggle="tooltip" data-bs-placement="top"><i class="<?=$data['fwicon']['square-check'];?>" ></i></button>
<button class="input_s btn btn-primary btn-sm search multch select my-2" type="button" id="display_select_all" name="select_all" value="Select All" title="Select All" data-bs-toggle="tooltip" data-bs-placement="top"><i class="<?=$data['fwicon']['square-plus'];?>" ></i></button>
<button class="input_s btn btn-primary btn-sm search multch deselect my-2" type="button" id="display_deselect_all" name="deselect_all" value="Deselect All" title="Deselect All" data-bs-toggle="tooltip" data-bs-placement="top"><i class="<?=$data['fwicon']['square-minus'];?>" ></i></button>


<script>
$('.multch').each(function(index) {
console.log(index);
				
$(this).on('click', function(){
console.log($(this).parent().find('option').text());
$(this).parent().find('option').prop('selected', $(this).hasClass('select')).parent().trigger('chosen:updated');
	});
});
</script>
                        </div>
					<!--Button for Download Filter Transaction in CSV Format-->
						<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['transaction_action_checkbox_csv'])&&$_SESSION['transaction_action_checkbox_csv']==1)||(isset($_SESSION['csv_multiple_merchant'])&&$_SESSION['csv_multiple_merchant']==1)){?>
                    <? 
		if(isset($_REQUEST['date_1st'])&&$_REQUEST['date_1st']&&isset($_REQUEST['date_2nd'])&&$_REQUEST['date_2nd'])
		{?>
                    <button type="button"  data-bs-toggle="modal" data-bs-target="#myModa30" name="downloadcvs" value="filterTrCSV" class="btn btn-icon btn-primary btn-sm " style="" title="Download Transaction in CSV Format" ><i class="<?=$data['fwicon']['download'];?>" title="Download Transaction in CSV Format" data-bs-toggle="tooltip" data-bs-placement="right"></i></button>
                    <? }?>
                    <? }?>
                      </div>
                      <!--</div>-->
                    </form>
                  </div>
                  <div class="rowd1 float-start" style="margin-top: -10px !important;margin-left: 0.25rem!important;">
				  
                    <?php /*?><? if((isset($_SESSION['login_adm']))||(isset($_SESSION['transaction_action_checkbox_csv'])&&$_SESSION['transaction_action_checkbox_csv']==1)||(isset($_SESSION['csv_multiple_merchant'])&&$_SESSION['csv_multiple_merchant']==1)){?>
                    <? 
		if(isset($_REQUEST['date_1st'])&&$_REQUEST['date_1st']&&isset($_REQUEST['date_2nd'])&&$_REQUEST['date_2nd'])
		{?>
                    <button type="button"  data-bs-toggle="modal" data-bs-target="#myModa30" name="downloadcvs" value="filterTrCSV" class="btn btn-icon btn-primary btn-sm  mx-1 " style="" title="Download Transaction in CSV Format"><i class="<?=$data['fwicon']['download'];?>"></i></button>
                    <? }?>
                    <? }?><?php */?>
					
					
                    <? if(isset($post['MemberInfo']) && $post['MemberInfo']){?>
                    <label class="lbl-toggle btn btn-primary  btn-sm" id="collapsible3" onclick="vnext(this,'#collapsible3_content_html');<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['t_calculation_details'])&&$_SESSION['t_calculation_details']==1)){?>ajaxf1(this,'<?=$cl=str_replace('/transactions','/transaction_list_calc_new',$data['urlpath']);?>','#tr_cal_id3',false);<? }?>"><i class="<?=$data['fwicon']['calculator'];?> me-1" title="Calculations" data-bs-toggle="tooltip" data-bs-placement="top"></i></label>
                    <?php 
if((isset($_SESSION['login_adm']))||((isset($_SESSION['transaction_payout_manual'])&&$_SESSION['transaction_payout_manual']==1)||(isset($_SESSION['transaction_payout'])&&$_SESSION['transaction_payout']==1))){
?>
                    <label id="collapsible2" class="lbl-toggle btn btn-primary btn-sm" onclick="ajaxf1(this,'','#collapsible2_html')" title="Payout Filter Date Wise" data-bs-toggle="tooltip" data-bs-placement="top"><i class="<?=$data['fwicon']['money-check-dollar'];?>"></i> </label>
                    <? } ?>
                    <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['check_missing_calc'])&&$_SESSION['check_missing_calc']==1)){?>
                    <a href="<?=$data['Host']?>/include/check_missing_calc<?=$data['ex']?>?bid=<?=$post['bid'];?>" target="_blank" value="Check Missing Calculations" class="downloadcvs btn btn-primary btn-sm" style="display:inline-block;" title="Check Missing Calculations" data-bs-toggle="tooltip" data-bs-placement="top"><i class="<?=$data['fwicon']['search'];?>"></i></a>
                    <? } ?>
                    <?  if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_login'])&&$_SESSION['merchant_action_login']==1)){?>

					
<form method="post" target="_blank" action="<?=$data['Host'];?>/admin-merchant/login<?=$data['ex']?>" style="padding: 0;margin: 0;display: inline-block;">
<input type="hidden" name="bid" value="<?=$_GET['bid'];?>" />
<button type="submit" name="login" value="login" class="sub_logins11 btn btn-primary btn-sm my-2" title="Login" data-bs-toggle="tooltip" data-bs-placement="top" /><i class="<?=$data['fwicon']['login'];?> fa-fw"></i></button>
</form>

                    <? } ?>
                    <? } ?>
                    <span class="menuchk_div hide">
                    <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['transaction_action_checkbox_csv'])&&$_SESSION['transaction_action_checkbox_csv']==1)){?>
                    <? if($post['type']>8 && $post['type']<12){?>
                    <button type="button" name="downloadcvs" value="Download CSV" class="downloadcvs btn btn-icon btn-primary btn-sm" style="display:inline-block;"><i class="<?=$data['fwicon']['circle-down'];?>"></i> CSV</button>
                    <? }?>
                    <? }?>
                    <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['transaction_action_checkbox_completed'])&&$_SESSION['transaction_action_checkbox_completed']==1)){?>
                    <? if($_REQUEST['status']!=13){?>
                    <? /*?><button type="button" name="COMPLETEDALL" value="COMPLETED ALL"  data-action="completedall" data-label="Completed List" data-reason="" class="completedall actionlnk btn btn-icon btn-primary my-2 me-0" style="display:inline-block;"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Completed</button> <? */ ?>
                    <? }}?>
                    <? if($_REQUEST['status']!=13){?>
                    <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['transaction_action_checkbox_reminder'])&&$_SESSION['transaction_action_checkbox_reminder']==1)){?>
                    <span >
                    <button type="button" name="REMINDERSALL" value="REMINDERS ALL" data-action="reminders_range" data-label="System will send reminder email to customer about the transaction" data-reason="Reminder Reason" class=" remindersall actionlnk btn btn-icon btn-primary btn-sm my-2" style="display:inline-block;"><i class="<?=$data['fwicon']['share'];?>"></i> Reminders</button>
                    </span>
                    <? }?>
                    <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['transaction_action_checkbox_surprise'])&&$_SESSION['transaction_action_checkbox_surprise']==1)){?>
                    <span >
                    <button type="button" name="AUTHORIZATIONALL" value="AUTHORIZATION ALL" data-action="authorization_range" data-label="System will send authorization email to customer about the transaction" data-reason="Reason of Authorization Email " class=" authorizationall actionlnk btn btn-icon btn-primary btn-sm my-2" style="display:inline-block;"><i class="<?=$data['fwicon']['share'];?>"></i> Surprise</button>
                    </span>
                    <? }?>
                    <? }?>
                    <? if($data['con_name']=='clk'){?>
                    <span >
                    <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['transaction_action_checkbox_settled'])&&$_SESSION['transaction_action_checkbox_settled']==1)){?>
<?/*?>
		 <button type="button" name="SELLTEDAll" value="SELLTED ALL" data-action="selltedall" data-label="Settled List" data-reason="Settled by SWIFT Reference" class="returnedall actionlnk btn btn-icon btn-primary btn-sm" style="display:inline-block;"><i class="<?=$data['fwicon']['dollar-sign'];?>"></i>Sellted</button>
		 <?*/?>
                  <? if($_REQUEST['status']==13){?>
                  <button type="button" name="SendtoNodalBank" value="SendtoNodalBank" data-action="sendtobank" data-label="Send to Bank" data-alert="confirm"  data-reason="Settled by SWIFT Reference" class="returnedall actionlnk btn btn-icon btn-primary btn-sm" style="display:inline-block;"><i class="<?=$data['fwicon']['bank'];?>"></i>Send to Bank</button>
                  <? }?>
                  <? }?>
                  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['transaction_action_checkbox_utrn_status'])&&$_SESSION['transaction_action_checkbox_utrn_status']==1)){?>
                  <button type="button" name="UTRNStatus" value="UTRN Status" data-action="utrnstatus" data-label="UTRN Status" data-alert="confirm" data-reason="UTRN Status" class="returnedall actionlnk btn btn-icon btn-primary my-2 btn-sm" style="display:inline-block;"><i class="<?=$data['fwicon']['circle-info'];?>"></i>UTRN Status</button>
                  <? }?>
                  </span>
                  <? }?>
                  </span>
				  
					
                  </div>
		<?//link end  ?>		  
				  
                  <div class="rowd2 row"> <span class="mywrap-collabsible tog1" >
                    <? if(isset($post['MemberInfo']) && $post['MemberInfo']){?>
                    <div id="collapsible3_content_html" class="collapsible-content border bg-light rounded text-start" style="float:left;width:100%;overflow:inherit;max-height:inherit;display:none;">
                      <div id="collapsible3_html" class="content-inner" style="height:auto;float:left;width:97.6%;display:block;">
                        <!-- start Content-->
                        <div class="m-2"> <b style="margin:0 0 0 0px;">Transaction For Account:</b> <a <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_view'])&&$_SESSION['merchant_action_view']==1)){?> href="<?=$data['Admins']?>/merchant<?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&action=detail" <? }?> >
                          <?=$post['MemberInfo']['username']?>
                          |
                          <?=$post['MemberInfo']['available_balance']?>
                          |
                          <? if(isset($post['mfee'])) echo $post['mfee']?>
                          | <b>
                          <?=$post['MemberInfo']['available_balance']-@$post['mfee']?>
                          </b></a> | </div>
                        <br>
                        <!-- end Content-->
                        <div id="tr_cal_id3" class="tr_cal_id3" style="display:block !important;"> <img class="loading_img" src="<?=$data['Host'];?>/images/icons/ajax-loader.gif" style=" display:block;margin:5px auto 15px auto;height:25px;"> </div>
                      </div>
                    </div>
                    <?php 
if((isset($_SESSION['login_adm']))||((isset($_SESSION['transaction_payout_manual'])&&$_SESSION['transaction_payout_manual']==1)||(isset($_SESSION['transaction_payout'])&&$_SESSION['transaction_payout']==1))){
?>
                    <div class="collapsible-content">
                      <div id="collapsible2_html" class="content-inner border bg-light p-2" style=" display:none;height:inherit;min-height:70px;float:left;width:100%;">
                        <?
if(!empty($_GET['pfdate'])){
	$pfdate  = date('Y-m-d',strtotime($_GET['pfdate']));
}else{ 
	 $pfdate = date("Y-m-d",strtotime("-36 day",strtotime(date("Y-m-01",strtotime("now") ) )));
}

if(!empty($_GET['ptdate'])){
	$ptdate  = date('Y-m-d',strtotime($_GET['ptdate']));
	if(isset($payoutdays)&&$payoutdays){
		$fpdate = date("Y-m-d",strtotime("-{$payoutdays} day",strtotime($ptdate)));
		$ptdate = date("Y-m-d",strtotime("+6 day",strtotime($fpdate)));
	}	
}else{ 
  $ptdate = date('Y-m-d',strtotime("0 day",strtotime("now")));
}

?>
                        <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['transaction_payout'])&&$_SESSION['transaction_payout']==1)){?>
                        <div style="width:100%;float:left;">
                          <div class="daterangeform row" > <span style="display:none;">
                            <input type="radio" id="settled_query" checked="checked" name="fillter" class="echeckid_f fillter" value="settled_query" style="display:inline-block;min-width:24px;width:24px;float:none;box-shadow:0 0 0;margin:-3px 0 0 0;">
                            <label for="settled_query" style="width:auto;float:none;display:inline-block;">Settled</label>
                            <input type="radio" id="pdf_report" name="fillter" class="echeckid_f fillter" value="pdf_report" style="display:inline-block;min-width:24px;width:24px;float:none;box-shadow:0 0 0;margin:-3px 0 0 0;">
                            <label for="pdf_report" style="width:auto;float:none;display:inline-block;">Report</label>
                            </span>
                            <div class="col-md-4">
                              <input id="pfdate" name="pfdate" type="date" class="form-control  my-2" placeHolder="From dd-mm-yyyy" value="<?=$pfdate;?>" max="<?=date('Y-m-d');?>">
                            </div>
                            <div class="col-md-4">
                              <input id="ptdate" name="ptdate" type="date" class="form-control my-2" placeHolder="To dd-mm-yyyy" value="<?=$ptdate;?>" >
                            </div>
                            <div class="col-md-2">
                              <button id="payoutdaterange2" type="submit" name="payoutdaterange2" value="Payout" class="payoutdaterange2 btn btn-icon btn-primary my-2" ><i class="<?=$data['fwicon']['circle-down'];?>" title="Payout Date"></i> </button>
                            </div>
                            <div class="col-md-2 my-2" id="daterangediv2">
                              <ul class="topnav pull-right trs inline" style="padding-left:0px;list-style-type: none;">
                                <li class="dropdown text-start">
                                  <!--<a  class="glyphicons hand_down payoutpdf0 dropdown-toggle" onclick="filteraction0(this)" style="width:auto;margin-left:-3px;" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">Payout11
                      <?
					if(isset($_GET['ptdate'])&&$_GET['ptdate']){
						echo ": ".date('d-m-Y',strtotime($_GET['ptdate']));
					}
			?>
                      </a>-->
                                  <a class="btn btn-primary hand_down payoutpdf0" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown"  aria-expanded="false">
                                  <!--onclick="filteraction0(this)"-->
                                  Payout
                                  <?
					if(isset($_GET['ptdate'])&&$_GET['ptdate']){
						echo ": ".date('d-m-Y',strtotime($_GET['ptdate']));
					}
			?>
                                <i class="<?=$data['fwicon']['circle-down'];?>"></i></a>
                                <ul class="dropdown-menu pull-right" aria-labelledby="dropdownMenuButton1">
                                  <li><a onclick="filteraction(this)" target="selltedview" href="<? if(isset($trans_href)) echo $trans_href;?>?action=select<? if(isset($type)){?>&type=<?=$type?><? }?>&status=-1&keyname=223&searchkey=<? if(isset($post['TransactionDetails']['transaction_period'])) echo $post['TransactionDetails']['transaction_period'];?>&bid=<? if(isset($post['TransactionDetails']['receiver'])) echo $post['TransactionDetails']['receiver'];?>"  class="payoutpdf viewedcl dropdown-item"><i class="<?=$data['fwicon']['eye-solid'];?>"></i> <span>View </span></a></li>
                                  <? if(isset($paydLink)&&$paydLink){?>
                                  <li><a onclick="filteraction(this)" target="selltedview" data-action="selltedall" data-label="Settled List" data-reason="Settled by SWIFT Reference" data-href="<?=$data['Admins']?>/transactions/?bid=<?=$post['TransactionDetails']['receiver']?>&tp=<?=$post['TransactionDetails']['transaction_period']?>&id=<?=$post['TransactionDetails']['id']?><?php echo $common_get; ?>&action=payoutsellted&querytype=sellted" class="payoutpdf settledcl dropdown-item"><i class="<?=$data['fwicon']['check-circle'];?>"></i> <span>Settled</span></a></li>
                                  <? }?>
                                  <li title="Acquirer Table: Calculations"><a onclick="filteraction(this)" target="pdfreport" href="<?=$data['Host']?>/payout_report_fee_dynamic_ac_db<?=$data['ex']?>?bid=<?=$post['bid']?>&pfdate=<? if(isset($_GET['pfdate'])) echo $_GET['pfdate']?>&ptdate=<? if(isset($_GET['ptdate'])) echo $_GET['ptdate']?>" class="payoutpdf pdfreportcl dropdown-item"><i class="<?=$data['fwicon']['pdf'];?>"></i> <span>PDF Report-A/c.</span></a></li>
                                  <li title="Acquirer Transaction Flied: Calculations"><a onclick="filteraction(this)" target="pdfreport_dy" href="<?=$data['Host']?>/payout_report_fee_dynamic_tr_db<?=$data['ex']?>?bid=<?=$post['bid']?>&pfdate=<? if(isset($_GET['pfdate'])) echo $_GET['pfdate']?>&ptdate=<? if(isset($_GET['ptdate'])) echo $_GET['ptdate']?>" class="payoutpdf pdfreportcl_tr dropdown-item"><i class="<?=$data['fwicon']['pdf'];?>"></i> <span>PDF Report-D.Tr.</span></a></li>
                                  <li title="Payout Transaction Flied: Calculations"><a onclick="filteraction(this)" target="pdfreport_1" href="<?=$data['Host']?>/payout_report_transaction_db<?=$data['ex']?>?bid=<?=$post['bid']?>&pfdate=<? if(isset($_GET['pfdate'])) echo $_GET['pfdate']?>&ptdate=<? if(isset($_GET['ptdate'])) echo $_GET['ptdate']?>" class="payoutpdf pdfreportcl_1 dropdown-item"><i class="<?=$data['fwicon']['pdf'];?>"></i> <span>PDF Report-TR.</span></a></li>
                                  <li title="Multiple Report Not Match than Update "><a onclick="filteraction(this);popuploadig();" target="hform" href="<?=$data['Host']?>/transaction_fee_calculation<?=$data['ex']?>?bid=<? if(isset($post['TransactionDetails']['receiver'])) echo $post['TransactionDetails']['receiver'];?>&id=<? if(isset($post['TransactionDetails']['id'])) echo $post['TransactionDetails']['id'];?>&tp=<? if(isset($post['TransactionDetails']['transaction_period'])) echo $post['TransactionDetails']['transaction_period']; ?><?php if(isset($common_get)) echo $common_get; ?>&action=select&querytype=tfcupdate" class="payoutpdf tfcupdate dropdown-item"><i class="<?=$data['fwicon']['setting'];?>"></i> <span>Update </span></a></li>
                                </ul>
                              </li>
                            </ul>
                          </div>
                        </div>
                        <script>
	$(".payoutdaterange2").click(function(){
	  //alert($('#fpdate').val()+"\r\n"+$('#tpdate').val());
	    var is_account= "<?php echo $post['is_account'];?>";
	    var subparameter = "<?php echo "&bid=".@$_GET['bid']."&type=".@$_GET['type']."&status=".@$_GET['status']."&page=".@$_GET['page']."&action=".$_GET['action']."&order=".@$_GET['order']?>";
		//alert(subparameter);
		
		var pdate_url="transactions<?=$data['ex']?>?pfdate="+$('#pfdate').val()+"&ptdate="+$('#ptdate').val()+"&fillter="+$('.fillter:checked').val()+"&bid=<?=$post['bid']?>"+subparameter;
		
		newWindow2=window.open(pdate_url, 'newWindow2');
		newWindow2.focus();
		
	});
</script>
                        <? }?>
                        <?
$transaction_payout_manual=0;
$post['is_account']="card";
if(((isset($_SESSION['login_adm']))||(isset($_SESSION['transaction_payout_manual'])&&$_SESSION['transaction_payout_manual']==1))&&($transaction_payout_manual)){?>
                        <div style="clear:both;width:100%;float:left;">
                          <div class="daterangeform" style="margin:14px 0 0 0;float: none;display: block;margin: 0 auto;width: 575px;">
                            <input id="fpdate" name="fpdate" type="date" placeHolder="From dd-mm-yyyy" value="<?=$fpdate;?>" max="<?=date('Y-m-d');?>" style="min-width:120px;margin:0px;height:25px;font-size:11px;line-height:16px;" >
                            <input id="tpdate" name="tpdate" type="date" placeHolder="To dd-mm-yyyy" value="<?=$tpdate;?>"  style="min-width:120px;margin:0px;height:25px;font-size:11px;line-height:16px;">
                            <button id="payoutdaterange" type="submit" name="payoutdaterange" value="Payout" class="payoutdaterange btn btn-icon btn-primary" style="display:inline-block; width:145; height: 25;font-size: 11px;text-transform: capitalize;"><i class="<?=$data['fwicon']['circle-down'];?>"></i>
                            <?=$post['is_account'];?>
                            Payout Date</button>
                          </div>
                          <div id="daterangediv" style="display:block;float: left;clear:both;width:100%;margin:14px 0 0 0;">
           <?php	
				
			function getMondaysInRange1($dateFromString, $dateToString, $is_account='')
			{
				$dateFrom = new \DateTime($dateFromString);
				$dateTo = new \DateTime($dateToString);
				$dates = array();
				//$is_account = $post['is_account'];

				if ($dateFrom > $dateTo) {
					return $dates;
				}
				
				if ((3 != $dateFrom->format('N'))) {
					//$dateFrom->modify('next Wednesday');
				}
				
				if (($is_account=="check")&&(3 != $dateFrom->format('N'))) {
					$dateFrom->modify('next Wednesday');
				}elseif(($is_account=="card")&&(1 != $dateFrom->format('N'))) {
					$dateFrom->modify('next Monday');
				}else{
					// $dateFrom->modify('next Wednesday');
				}

				while ($dateFrom <= $dateTo) {
					$dates[] = $dateFrom->format('Y-m-d');
					$dateFrom->modify('+1 week');
				}

				return $dates;
			}
			
			
			$fromDate 	= date("Y-m-d",strtotime("0 day",strtotime(date("Y-01-01",strtotime("now") ) )));
			$toDate 	= date("Y-m-d",strtotime("0 day",strtotime(date("Y-12-31",strtotime("now") ) )));
			
			$alldate	= array();


				$alldate 	= getMondaysInRange1($fromDate,$toDate,$post['is_account']);


			$common_get = "&type=".$_GET['type']."&status=".$_GET['status']."&page=".$_GET['page']."&order=".$_GET['order']."&is_account=".$post['is_account'];

			if(isset($post['is_account']) && ($post['is_account']=="card")){
				$report_file_name="cardreport";
			}else{
				$report_file_name="echeckreport";
			}


			if(!empty($_GET['pdate'])){
				echo " <a class='payoutpdf payoutpdf_0 active' >".date("D d-m-Y",strtotime($_GET['pdate']))."</a>  ";
			}else{ ?>
                            <ul class="topnav pull-right trs inline" style="margin:0;text-align:left;float:left;width:100%;">
                              <?php foreach($alldate as $key=>$value){ 
							$payDate=date("Ymd",strtotime($value));
							$currentDate=date("Ymd");
							if($payDate<=$currentDate){
								$paydLink=1;
							}else{
								$paydLink=0;
							}
					 ?>
                              <li class="dropdown"> <a data-toggle="dropdown" class="glyphicons hand_down payoutpdf0" onclick="filteraction0(this)"><?php echo date("D d-m-Y",strtotime($value)); ?> </a>
                                <ul class="dropdown-menu pull-right">
                                  <li><a onclick="filteraction(this)" target="selltedview" href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?bid=<?php echo $_GET['bid'];?>&pdate=<?php echo date("Y-m-d",strtotime($value));?><?php echo $common_get; ?>&action=select&querytype=selltedview" class="payoutpdf viewedcl"><i class="<?=$data['fwicon']['eye-solid'];?>"></i><span>View </span></a></li>
                                  <? if($paydLink){?>
                                  <li><a onclick="filteraction(this)" target="selltedview" data-action="selltedall" data-label="Settled List" data-reason="Settled by SWIFT Reference" data-href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?bid=<?php echo $_GET['bid'];?>&pdate=<?php echo date("Y-m-d",strtotime($value));?><?php echo $common_get; ?>&action=payoutsellted&querytype=sellted" class="payoutpdf settledcl "><i class="<?=$data['fwicon']['check-circle'];?>"></i><span>Settled</span></a></li>
                                  <? }?>
                                  <li><a onclick="filteraction(this)" target="pdfreport" href="<?=$data['Host']?>/<?=$report_file_name?><?=$data['ex']?>?bid=<?php echo $_GET['bid'];?>&pdate=<?php echo date("Y-m-d",strtotime($value));?>&type=<?php echo $_GET['type'];?>" class="payoutpdf pdfreportcl"><i class="<?=$data['fwicon']['pdf'];?>"></i><span>PDF Report</span></a></li>
                                  <li><a onclick="filteraction(this)" target="pdfreport_1" href="<?=$data['Host']?>/<?=$report_file_name?>_1<?=$data['ex']?>?bid=<?php echo $_GET['bid'];?>&pdate=<?php echo date("Y-m-d",strtotime($value));?>&type=<?php echo $_GET['type'];?>" class="payoutpdf pdfreportcl_1"><i class="<?=$data['fwicon']['pdf'];?>"></i><span>PDF Report</span></a></li>
                                  <li><a onclick="filteraction(this);popuploadig();" target="hform" href="<?=$data['Host']?>/transaction_fee_calculation<?=$data['ex']?>?bid=<?php echo $_GET['bid'];?>&pdate=<?php echo date("Y-m-d",strtotime($value));?><?php echo $common_get; ?>&action=select&querytype=tfcupdate" class="payoutpdf tfcupdate"><i class="<?=$data['fwicon']['setting'];?>"></i><span>Update </span></a></li>
                                </ul>
                              </li>
                              <?php } ?>
                            </ul>
                            <? } ?>
                          </div>
                          <?
			 $subparameter="&bid={$_REQUEST['bid']}&type={$_REQUEST['type']}&status={$_REQUEST['status']}&action={$_REQUEST['action']}&order={$_REQUEST['order']}&ex={$data['ex']}&is_account={$post['is_account']}&report_file_name={$report_file_name}";
			?>
                          <script>
			$(".payoutdaterange").click(function(){
			  //alert($('#fpdate').val()+"\r\n"+$('#tpdate').val());
				var is_account= "<?=$post['is_account'];?>";
				var subparameter = "<?=$subparameter;?>";
				//alert(subparameter);
				if(is_account==""){
					alert("Please filter the Account");
					document.csearch.type_csearch.focus();
				}else{
					$.ajax({url: "payout_date_range<?=$data['ex']?>?fpdate="+$('#fpdate').val()+"&tpdate="+$('#tpdate').val()+"&fillter="+$('.fillter:checked').val()+"&bid=<?=$post['bid']?>"+subparameter, success: function(result){
						$("#daterangediv").html(result);
					}});
				}
			});
			</script>
                        </div>
                        <? }?>
                      </div>
                    </div>
                    <? if(isset($_REQUEST['pfdate'])&&$_REQUEST['pfdate']){?>
                    <script>
	setTimeout(function(){ $('#collapsible2').trigger('click'); }, 1000);
</script>
                    <? }?>
                    <? 
		
		} 
		
		?>		
		
		
                    <? }?>
                  </div>
                </div>
				</div>
				</td>
            </tr>
          </table>
          <script>
  function toggle(source) {
  checkboxes = document.getElementsByName('echeckid[]');
  var checkBox = document.getElementById("vcheckid");
   if (checkBox.checked == true){
   //alert("display");
   //document.getElementById("bid").style.display = '';
   $(".echeckid").css("display", "");
   }
   else {
   //alert("hide");
   //$(".echeckid").css("display", "none");
   }
  
  for(var i=0, n=checkboxes.length;i<n;i++) {
  checkboxes[i].checked = source.checked;
  }
}
</script>

		  <div style="overflow: auto;">   <!--padding-right:246px;width: 100vw;float: left;-->
		  <div class="table-responsive-sm vkg">
          <table id="content22"  class="table table-striped" >  <!--frame22 echektran22-->
              <thead>
                <tr  class="border rounded">
                  <? if(in_array("transaction_id",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_transaction_id'])&&$_SESSION['tr_transaction_id']==1))){?>
                  <th scope="col"  class="text-start"> 
				  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['t_multiple_check_box'])&&$_SESSION['t_multiple_check_box']==1)){  ?>
                    <input type="checkbox" name="echeckid[]" id="vcheckid" onclick="toggle(this)" class="form-check-input echeckid1 echeckidall ">
                    <? }?>
				  </th>
				  
				  <th scope="col"  class="text-start">
				 
				  <div class="transaction-h1">
                    <a class="trPaymentId" href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?<? if(isset($post['bid']) && $post['bid']){?>bid=<?=$post['bid']?>&<? }?>page=<?=$curr_pg?>&type=<?=$post['type']?>&status=<?=$post['status']?>&action=select&order=id" title="Transaction / Payment Id" >Payment&nbsp;ID</a>
				  </div>
				  
				  <? if(in_array("mrid",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_mrid'])&&$_SESSION['tr_mrid']==1))){?>
				  <div class="transaction-h2">
					<a class="" title="Merchant Order Id" href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?<? if(isset($post['bid']) && $post['bid']){?>bid=<?=$post['bid']?>&<? } ?>page=<?=$curr_pg?>&type=<?=$post['type']?>&status=<?=$post['status']?>&action=select&order=mrid">M.&nbsp;Order&nbsp;ID</a> 
				  </div>
				 <? }?>
					</th>
                  <? }?><th scope="col" title="Action" data-bs-toggle="tooltip" data-bs-placement="top">
                  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['transaction_action_all'])&&$_SESSION['transaction_action_all']==1)){ ?>
                  <i class="<?=$data['fwicon']['circle-info'];?> text-link"></i>
                  <? }?>
                  </th>
                  
                  <th scope="col">
				  <? if(in_array("names",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_names'])&&$_SESSION['tr_names']==1))){?>
				  <div class="transaction-h1"><a href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?<? if(isset($post['bid']) && $post['bid']){?>bid=<?=$post['bid']?>&<? } ?>page=<?=$curr_pg?>&type=<?=$post['type']?>&status=<?=$post['status']?>&action=select&order=names" title="Customer Name">Customer&nbsp;Name</a> </div>
				  <? }?>
				  <? if(in_array("email_add",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_email_add'])&&$_SESSION['tr_email_add']==1))){?>
				  <div class="transaction-h2">Email</div>
				  <? } ?>
				  </th>
                  
                 
                  <th scope="col">
				   <? if(in_array("amount",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_amount'])&&$_SESSION['tr_amount']==1))){?>
				  <div class="transaction-h1">
				  <a href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?<? if(isset($post['bid']) && $post['bid']){?>bid=<?=$post['bid']?>&<? } ?>page=<?=$curr_pg?>&type=<?=$post['type']?>&status=<?=$post['status']?>&action=select&order=amount"  title="Order Amount">Order&nbsp;Amount</a>
				  </div>
				  <? }?>
				  
				  <? if(in_array("transaction_amt",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_transaction_amt'])&&$_SESSION['tr_transaction_amt']==1))){?>
				  <div class="transaction-h2">
				  <a href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?<? if(isset($post['bid']) && $post['bid']){?>bid=<?=$post['bid']?>&<? } ?>page=<?=$curr_pg?>&type=<?=$post['type']?>&status=<?=$post['status']?>&action=select&order=transaction_amt" class="text-muted transaction-h2" title="Transaction Amount" >Trans.&nbsp;Amount</a>
				  </div>
				  <? }?>
				  </th>
                  
                  
                 
                  <th scope="col" valign="top"> 
				  <? if(in_array("available_balance",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_available_balance'])&&$_SESSION['tr_available_balance']==1))){?>
				  <div class="transaction-h1">
				  <a href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?<? if(isset($post['bid']) && $post['bid']){?>bid=<?=$post['bid']?>&<? } ?>page=<?=$curr_pg?>&type=<?=$post['type']?>&status=<?=$post['status']?>&action=select&order=available_balance" title="Balance Amount">Balance</a>
				  </div>
				  <? }?>
				  </th>
                  
                  
                  <th scope="col">
				  <? if(in_array("tdate",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_tdate'])&&$_SESSION['tr_tdate']==1))){?>
				  <div class="transaction-h1">
				  <a href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?<? if(isset($post['bid']) && $post['bid']){?>bid=<?=$post['bid']?>&<? } ?>page=<?=$curr_pg?>&type=<?=$post['type']?>&status=<?=$post['status']?>&action=select&order=tdate" title="Transaction Date Time" >Timestamp </a>
				  </div>
				  <? }?>
				  <? if(in_array("created_date",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_created_date'])&&$_SESSION['tr_created_date']==1))){?>
                  <div class="transaction-h2">Created&nbsp;Date</div>
                  <? }?>
				  
				  </th>
                  <th scope="col" >
                  <? if(in_array("cardtype",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_cardtype'])&&$_SESSION['tr_cardtype']==1))){?>
                  <div class="transaction-h1">Source</div>
                  <? }?>
				  <? if(in_array("type",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_type'])&&$_SESSION['tr_type']==1))){?>
                  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['t_acquirer_view'])&&$_SESSION['t_acquirer_view']==1)){?>
                  <? if($post['type']<0){?>
				  <div class="transaction-h2">
                  <a href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?<? if(isset($post['bid']) && $post['bid']){?>bid=<?=$post['bid']?>&<? } ?>page=<?=$curr_pg?>&type=<?=$post['type']?>&status=<?=$post['status']?>&action=select&order=type">Acquirer</a>
				  </div>
                  <? }?>
                  <? }?>
                  <? }?>
				  
				  </th>

                 <th scope="col">
                  <? if(in_array("status",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_status'])&&$_SESSION['tr_status']==1))){?>
                  <? if($post['status']<0){?>
				  <div class="transaction-h1">
                  <a href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?<? if(isset($post['bid']) && $post['bid']){?>bid=<?=$post['bid']?>&<? } ?>page=<?=$curr_pg?>&type=<?=$post['type']?>&status=<?=$post['status']?>&action=select&order=status">Status</a>
				  </div>
                  <? }?>
                  <? }?>
				  <? if(in_array("reason",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_reason'])&&$_SESSION['tr_reason']==1))){?>
                  <div class="transaction-h2">Reason</div>
                  <? }?>
				  
				  </th>
				  <th scope="col" valign="top">
                  <? if(in_array("receiver",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_receiver'])&&$_SESSION['tr_receiver']==1))){?>
				  <div class="transaction-h1">
				  <a href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?<? if(isset($post['bid']) && $post['bid']){?>bid=<?=$post['bid']?>&<? } ?>page=<?=$curr_pg?>&type=<?=$post['type']?>&status=<?=$post['status']?>&action=select&order=receiver">Receiver</a>
				  </div>
                  <? }?>
                 </th>
				  
				  <th scope="col" title="Card Number" >
                  <? if(in_array("ccno",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_ccno'])&&$_SESSION['tr_ccno']==1))){?>
                  <div class="transaction-h1">Card&nbsp;Number</div>
				   <? }?>
				  <? if(in_array("upa",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_upa'])&&$_SESSION['tr_upa']==1))){?>
                  <div class="transaction-h2">UPA</div>
                  <? }?>
				  
                 
				  </th>
				  <th scope="col">
                  <? if(in_array("ip",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_ip'])&&$_SESSION['tr_ip']==1))){?>
                  <div class="transaction-h1">IP</div>
                  <? }?>
				  <? if(in_array("store_id",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_store_id'])&&$_SESSION['tr_store_id']==1))){?>
                  <div class="transaction-h2">Website&nbsp;ID</div>
                  <? }?>
				  </th>
<th scope="col" title="Ref No. of Bank Response"  valign="top">
                  <? if(in_array("txn_id",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_txn_id'])&&$_SESSION['tr_txn_id']==1))){?>
                  <div class="transaction-h1">Ref&nbsp;No.</div>
                  <? }?>
				  </th>
				  <th scope="col">
                  <? if(in_array("txn_value",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_txn_value'])&&$_SESSION['tr_txn_value']==1))){?>
                  <div class="transaction-h1">Bank&nbsp;Response</div>
                  <? }?>
				  <? if(in_array("json_value",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_json_value'])&&$_SESSION['tr_json_value']==1))){?>
                  <div class="transaction-h2">Post&nbsp;Josn</div>
                  <? }?>
				  </th>
                 
                  <th scope="col">
                  <? if(in_array("reply_remark",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_reply_remark'])&&$_SESSION['tr_reply_remark']==1))){?>
                  <div class="transaction-h1">Note&nbsp;Support</div>
                  <? }?>
				  <? if(in_array("system_note",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_system_note'])&&$_SESSION['tr_system_note']==1))){?>
                  <div class="transaction-h2">Note&nbsp;System</div>
                  <? }?>
				  
				  </th>
                <th scope="col">
                  <? if(in_array("source_url",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_source_url'])&&$_SESSION['tr_source_url']==1))){?>
                  <div class="transaction-h1">Source&nbsp;Url</div>
                  <? }?>
				  <? if(in_array("notify_url",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_notify_url'])&&$_SESSION['tr_notify_url']==1))){?>
                  <div class="transaction-h2">Notify&nbsp;Url</div>
                  <? }?>
				  
				  </th>
                 <th scope="col">
                  <? if(in_array("success_url",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_success_url'])&&$_SESSION['tr_success_url']==1))){?>
                  <div class="transaction-h1">Success&nbsp;Url</div>
                  <? }?>
				  <? if(in_array("failed_url",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_failed_url'])&&$_SESSION['tr_failed_url']==1))){?>
                  <div class="transaction-h2">Failed&nbsp;Url</div>
                  <? }?>
				  </th>
                <th scope="col">
                  <? if(in_array("mdr_amt",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_mdr_amt'])&&$_SESSION['tr_mdr_amt']==1))){?>
                  <div class="transaction-h1">Discount&nbsp;Rate</div>
                  <? }?>
				  <? if(in_array("gst_fee",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_gst_fee'])&&$_SESSION['tr_gst_fee']==1))&&($data['con_name']=='clk')){?>
                  <div class="transaction-h2">GST&nbsp;Fee</div>
                  <? }?>
				  
				  </th>
                  
				  <th scope="col" >
				  <? if(in_array("rrn",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_rrn'])&&$_SESSION['tr_rrn']==1))){?>
                  <div class="transaction-h1">RRN</div>
                  <? }?>
				  
				  <? if(in_array("mdr_txtfee_amt",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_mdr_txtfee_amt'])&&$_SESSION['tr_mdr_txtfee_amt']==1))){?>
                  <div class="transaction-h2">Transaction&nbsp;Fee</div>
                  <? }?>
				  
				  </th>
				  
                  
				  <th scope="col" >
                  <? if(in_array("rolling_amt",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_rolling_amt'])&&$_SESSION['tr_rolling_amt']==1))){?>
                  <div class="transaction-h1">Rolling&nbsp;Fee</div>
                  <? }?>
				  <? if(in_array("mdr_cb_amt",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_mdr_cb_amt'])&&$_SESSION['tr_mdr_cb_amt']==1))){?>
                  <div class="transaction-h2">CBK&nbsp;Fee</div>
                  <? }?>
				  
				  </th>
                  
				  <th scope="col" >
                  <? if(in_array("mdr_cbk1_amt",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_mdr_cbk1_amt'])&&$_SESSION['tr_mdr_cbk1_amt']==1))){?>
                  <div class="transaction-h1">Predispute&nbsp;Fee</div>
                  <? }?>
				  <? if(in_array("mdr_refundfee_amt",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_mdr_refundfee_amt'])&&$_SESSION['tr_mdr_refundfee_amt']==1))){?>
                  <div class="transaction-h2">Refund&nbsp;Fee</div>
                  <? }?>
				  </th>
                  
				  <th scope="col">
                  <? if(in_array("payable_amt_of_txn",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_payable_amt_of_txn'])&&$_SESSION['tr_payable_amt_of_txn']==1))){?>
                  <div class="transaction-h1">Payout&nbsp;Amt.</div>
                  <? } ?>
				  <? if(in_array("payout_date",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_payout_date'])&&$_SESSION['tr_payout_date']==1))){?>
                  <div class="transaction-h2">Payout&nbsp;Date</div>
                  <? }?>
				  </th>
                
                  <th scope="col">
                  <? if(in_array("risk_ratio",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_risk_ratio'])&&$_SESSION['tr_risk_ratio']==1))){?>
                  <div class="transaction-h1">Risk&nbsp;Ratio</div>
                  <? }?>
				  <? if(in_array("transaction_period",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_transaction_period'])&&$_SESSION['tr_transaction_period']==1))){?>
                  <div class="transaction-h2">Transaction&nbsp;Period</div>
                  <? }?>
				  </th>
                  <th scope="col" title="Bank Processing Amount" data-bs-toggle="tooltip" data-bs-placement="top" valign="top">
                  <? if(in_array("bank_processing_amount",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_bank_processing_amount'])&&$_SESSION['tr_bank_processing_amount']==1))){?>
                  <div class="transaction-h1">B.&nbsp;Proc.&nbsp;Amount</div>
                  <? }?>
				  </th>
				  <th scope="col">
                  <? if(in_array("bank_processing_curr",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_bank_processing_curr'])&&$_SESSION['tr_bank_processing_curr']==1))){?>
                  <div class="transaction-h1" title="Bank Processing Currency">Proc.&nbsp;Currency</div>
                  <? }?>
				  <? if(in_array("currname",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_currname'])&&$_SESSION['tr_currname']==1))){?>
                  <div class="transaction-h2" title="Bank Order Currency">Order&nbsp;Currency</div>
                  <? }?>
				  </th>
                  
				  <th scope="col">
                  <? if(in_array("transID",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_transID'])&&$_SESSION['tr_transID']==1))){?>
                  <div class="transaction-h1">Orderset</div>
                  <? }?>
				  <? if(in_array("trname",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_trname'])&&$_SESSION['tr_trname']==1))){?>
                  <div class="transaction-h2">Payment&nbsp;Type</div>
                  <? }?>
				  </th>
                  
                 <th scope="col"  valign="top">
                  <? if(in_array("phone_no",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_phone_no'])&&$_SESSION['tr_phone_no']==1))){?>
                  <div class="transaction-h1">Phone</div>
                  <? }?></th>
				  <th scope="col" valign="top">
                  <? if(in_array("product_name",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_product_name'])&&$_SESSION['tr_product_name']==1))){?>
                  <div class="transaction-h1">Product&nbsp;Name</div>
                  <? }?>
				  </th>
				  <th scope="col">
                  <? if(in_array("address",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_address'])&&$_SESSION['tr_address']==1))){?>
                  <div class="transaction-h1">Address</div>
                  <? }?>
				  <div class="transaction-h2">
				  <? if(in_array("city",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_city'])&&$_SESSION['tr_city']==1))){?>
                  City
                  <? }?>
				  
				  <? if(in_array("state",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_state'])&&$_SESSION['tr_state']==1))){?>
                  / State
                  <? }?>
				  </div>
				  </th>
                
				  <th scope="col">
                  <? if(in_array("country",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_country'])&&$_SESSION['tr_country']==1))){?>
                  <div class="transaction-h1">Country</div>
                  <? }?>
				   <? if(in_array("zip",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_zip'])&&$_SESSION['tr_zip']==1))){?>
                  <div class="transaction-h2">Zip</div>
                  <? }?>
				  </th>
                 <th scope="col" valign="top">
                  <? if(in_array("descriptor",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_descriptor'])&&$_SESSION['tr_descriptor']==1))){?>
                  <div class="transaction-h1">Descriptor</div>
                  <? }?>
				  
				  </th>
                </tr>
              </thead>
              <? $idx=0; if($data['TransactionsList']){?>
              <? foreach($data['TransactionsList'] as $key=>$value){ ?>

              <tr valign="top"  bgcolor=<?=$bgcolor?> >
                <? if(in_array("transaction_id",$_SESSION['transaction_display_arr'])){?>
                <td>				<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['t_multiple_check_box'])&&$_SESSION['t_multiple_check_box']==1)){ ?>
                  <input type="checkbox" name="echeckid[]" class="echeckid  float-start form-check-input" data-value="<?=$value['transaction_id']?>" value="<?=(($value['typenum']==2)?$value['transaction_id']."_".$value['id']:$value['id']);?>" style="display:none;">
                  <? }?></td>
				<td data-bs-toggle="tooltip" data-bs-placement="top" title="<?=$value['transaction_id'];?>">

                  <a class="hrefmodal mx-0 text-link transaction-list-h1" data-tid="<?=$value['transaction_id']?>" data-href="<?=($data['Host']."/transactions_get".$data['ex']."?id=".$value['id']."&uid=".((isset($post['bid'])&&$post['bid']>0)?$post['bid']:$value['receiver'])."&bid=".((isset($post['bid'])&&$post['bid']>0)?$post['bid']:$value['receiver'])).(isset($_GET['keyname'])?"&keyname={$_GET['keyname']}":"").(isset($_GET['bid'])?"&mview=admin":"");?>&action=details&admin=1&tempui=<?=$data['frontUiName']?>" title="<?=$value['transaction_id'];?>" >
                  <? 
			
			if($value['typenum']==2){ echo 'W'; }
			elseif($value['ostatus']=="3" || $value['ostatus']=="5" || $value['ostatus']=="6" || $value['ostatus']=="11" || $value['ostatus']=="12"){ echo 'R'; }?><?=substr($value['transaction_id'],0,14);?>
                  </a>
				  
				  <? if(in_array("mrid",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_mrid'])&&$_SESSION['tr_mrid']==1))){?>
				  <div title="<?=$value['mrid']?>" data-bs-toggle="tooltip" data-bs-placement="top" style="width:88px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" class="mx-0 transaction-list-h2"><?=$value['mrid']?></div>
                  <? }?>  
                  
				  
				  </td><td align="center">
                <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['transaction_action_all'])&&$_SESSION['transaction_action_all']==1)){ ?>
                <div style="position:relative">
                    <div class=""> <a  class="dropdown-toggle7" data-bs-toggle="dropdown" aria-expanded="false"><i class="<?=$data['fwicon']['circle-down'];?>"></i></a>
                      <ul class="dropdown-menu text-white">
  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['transaction_view_all'])&&$_SESSION['transaction_view_all']==1)){?>
  <li><a class="dropdown-item" href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?bid=<?=$value['receiver']?>&id=<?=$value['id']?><? if($post['StartPage']){?>&page=<?=$post['StartPage']?><? }?>&type=<?=$post['type']?>&status=<?=$post['status']?>&action=select" ><i class="<?=$data['fwicon']['eye-solid'];?>"></i> View </a></li>
  <? }?>
  <? if(($value['typenum']=="279999"&&$value['ostatus']==2)){?>
  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['t_status_confirm'])&&$_SESSION['t_status_confirm']==1)){?>
  <li><a data-reason="Are you Sure to Confirm" data-label="Why do you want to complete this transaction" onClick="confirm2(this);" data-href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?<? if(isset($post['bid']) && $post['bid']){?>bid=<?=$post['bid']?>&<? } ?>id=<?=$value['id']?><? if($post['StartPage']){?>&page=<?=$post['StartPage']?><? }?><? if($post['type']){?>&type=<?=$post['type']?><? }?>&action=confirm2" class="ajxstatus dropdown-item"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Confirm</a></li>
  <? }?>
  <? }?>
  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['edit_trans'])&&$_SESSION['edit_trans']==1)){?>
  <li><a class="iframe_open11 dropdown-item" data-mid="<?=$value['receiver']?>" data-href="<?=$idx;?>_toggle" data-tabname="" data-url="" data-ihref="<?=$data['Host'];?>/include/edit_transaction<?=$data['ex']?>?id=<?=$value['id']?>&admin=1" title="Edit|Delete|Cancelled Transaction" onClick="iframe_open_modal(this);" ><i class="<?=$data['fwicon']['edit'];?>"></i> Edit Trxn.</a></li>
  <? }?>
  <? 
						$txn_value_array = json_decode($value['txn_value'],1);
						if($value['typenum']==2){
							if($value['ostatus']==13){
								if(isset($txn_value_array['coins_network'])&&$txn_value_array['coins_network'])	//CHECK WITHDRAW REQUEST IS FOR Crypto Wallet or not - 
								{
								?>
  <li class='g_validate 16'><a data-mhoid="<?=$value['transaction_id'];?>_<?=$value['id'];?>" data-type="<?=$value['typenum'];?>" onClick="hkipstatus(this,'binance');" class="hkip_status_id dropdown-item" title="Withdraw Binance Cold Wallet Status"><i class="<?=$data['fwicon']['retweet'];?>"></i> Binance Post</a></li>
  <?
								}
								else
								{
									//FETCH ALL AVAILABLE ACTIVE BANK LIST IN CASH OF BANK NODAL -  
									$result_select=db_rows(
										" SELECT * FROM {$data['DbPrefix']}bank_payout_table".
										" WHERE payout_status='1' AND payout_type='6'".
										" ORDER BY id DESC"
									);
		
									$post['result_list'] = $result_select;
									foreach($post['result_list'] as $b_key=>$b_val)
									{
										$payout_json	= json_decode($b_val['payout_json'],1);
										$encode_processing_creds		= json_decode(decode_f($b_val['encode_processing_creds']),1);

										//CHECK AVAILABLE PAYMENT METHOD IF EXISTS - 
										if(isset($encode_processing_creds['method'])&&$encode_processing_creds['method']) {
											//$post_method = explode(",",$encode_processing_creds['method']);
											$post_method = $encode_processing_creds['method'];
											?>
  <li class='g_validate 17'><a class="hrefmodal mt-2 ms-1 text-decoration-none" style="white-space:nowrap;" data-tid="<?=$value['transaction_id']?>" data-href="<?=($data['Host']."/include/post_method".$data['ex']."?id=".$b_val['id']."&payout_id=".$b_val['payout_id']."&transaction_id=".$value['transaction_id']."&tid=".$value['id']."&uid=".((isset($post['bid'])&&$post['bid']>0)?$post['bid']:$value['receiver'])."&bid=".((isset($post['bid'])&&$post['bid']>0)?$post['bid']:$value['receiver'])).(isset($post_method)?"&post_method={$post_method}":"");?>&order_amt=<?=$value['amount']?>&checkout_level_name=<?=$payout_json['checkout_level_name'];?>&action=details&admin=1&tempui=<?=$data['frontUiName']?>" title="<?=$value['transaction_id'];?>"> <i class="<?=$data['fwicon']['bank'];?>"></i>
    <?=$payout_json['checkout_level_name'];?>
    Post</a></li>
  <?
											}
										else
										{
										//IF PAYMENT METHOD NOT AVAILABLE THEN NORMAL NODAL POST - 
										?>
  <li class='g_validate 18'><a data-mhoid="<?=$value['transaction_id'];?>_<?=$value['id'];?>" data-type="<?=$b_val['payout_id'];?>" onClick="post_Withdraw(this);" class="hkip_status_id dropdown-item" title="<?=$payout_json['checkout_level_name'];?> Post"><i class="<?=$data['fwicon']['bank'];?>"></i>
    <?=$payout_json['checkout_level_name'];?>
    Post</a></li>
  <?
										}
									}
								}
							}
							else
							{
								if(isset($txn_value_array['coins_network'])&&$txn_value_array['coins_network'])
								{
								?>
  <li class='g_validate 19'><a data-mhoid="<?=$value['transaction_id'];?>_<?=$value['id'];?>" data-type="<?=$value['typenum'];?>" onClick="hkipstatus(this,'binance');" class="hkip_status_id dropdown-item" title="Withdraw Binance Cold Wallet Status"><i class="<?=$data['fwicon']['retweet'];?>"></i> Binance Status</a></li>
  <? 
								}
								else
								{
									$bank_status=$txn_value_array['bank_status'];
									
									if($bank_status)
									{
										?>
  <li class='g_validate 11'><a class="hrefmodal mt-2 ms-1 text-decoration-none" style="white-space:nowrap;" data-tid="<?=$value['transaction_id']?>" data-href="<?=$data['Host'].'/'.$bank_status;?>&actionurl=details&admin=1&tempui=<?=$data['frontUiName']?>" title="<?=$value['transaction_id'];?>"> <i class="<?=$data['fwicon']['bank'];?>"></i>Status</a></li>
  <?
									}
									else
									{
									?>
  <li class='g_validate 12'><a data-mhoid="<?=$value['transaction_id'];?>_<?=$value['id'];?>" data-type="<?=$value['typenum'];?>" onClick="hkipstatus(this);" class="hkip_status_id dropdown-item" title="Withdraw Nodal Status"><i class="<?=$data['fwicon']['retweet'];?>"></i> Nodal Status</a></li>
  <?php
									}
								}
							}
						}?>
  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['t_bal_upd'])&&$_SESSION['t_bal_upd']==1)){?>
  <li> <a class="dropdown-item" data-mid="<?=$value['receiver']?>" data-href="<?=$idx;?>_toggle" data-tabname="" data-url="" data-ihref="<?=$data['Admins'];?>/transactions<?=$data['ex']?>?action=tran_bal_upd&bid=<?=$value['receiver']?>&id=<?=$value['id']?>&admin=1" title="Balance Field Re-update from this Transaction to Latest Transaction" data-opt="confirm|prompt" data-confirm="Balance Field Re-update" onClick="iframe_open_modal(this);" ><i class="<?=$data['fwicon']['balance'];?>"></i> T. Bal. Upd.</a> </li>
  <? }?>
  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['t_resub_echeck'])&&$_SESSION['t_resub_echeck']==1)){?>
  <? if((isset($value['trname'])&&$value['trname']=="ch") && (isset($value['wstatus'])&&$value['wstatus']==0)){ ?>
  <li><a class="iframe_open99 dropdown-item" data-mid="<?=$value['receiver']?>" data-href="<?=$idx;?>_toggle" data-tabname="" data-url=""  data-ihref="<?=$data['Host'];?>/user/echeckvt<?=$data['ex']?>?id=<?=$value['tableid']?>&bid=<?=$value['receiver']?>&admin=1&action=update&hideAllMenu=1" title="ReSubmit eCheck" onClick="iframe_open_modal(this);" ><i class="<?=$data['fwicon']['primary'];?>"></i> ReSub. eCheck</a></li>
  <? }?>
  <? }?>
  <? if($value['ostatus']==8){?>
  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['t_refund_accept'])&&$_SESSION['t_refund_accept']==1)){?>
  <li><a  data-amount="<?=$value['oamount']?>" data-reason="Refund Approved" data-label="Refunded Reason" data-type="<?=$value['typenum'];?>" data-refund="<?=(isset($data['t'][$value['typenum']]['refund'])?$data['t'][$value['typenum']]['refund']:'')?>"  data-href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?bid=<?=$value['receiver']?>&id=<?=$value['id']?>&type=<?=$value['typenum']?>&txn_id=<?=$value['txn_id'];?><? if($post['StartPage']){?>&page=<?=$post['StartPage']?><? }?>&action=refund" data-cond="1" class="dialog_refunded open_pop dropdown-item"><i class="<?=$data['fwicon']['rotate-right'];?>"></i> Accept</a></li>
  <? }?>
  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['t_refund_reject'])&&$_SESSION['t_refund_reject']==1)){?>
  <li><a data-reason="Refund Request Rejected" data-label="Why do you want to complete this transaction" onClick="confirm2(this);" data-href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?bid=<?=$value['receiver']?>&id=<?=$value['id']?>&type=<?=$value['typenum']?><? if($post['StartPage']){?>&page=<?=$post['StartPage']?><? }?>&action=confirm" class="ajxstatus dropdown-item"><i class="<?=$data['fwicon']['reject'];?>"></i> Reject</a></li>
  <? }?>
  <? }elseif($value['ostatus']==13||$value['ostatus']==14){?>
  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['t_withdraw_accept'])&&$_SESSION['t_withdraw_accept']==1)){?>
  <li><a data-amount="<?=$value['oamount']?>" data-reason="<?=$value['type']?> Approved" data-label="<?=$value['type']?> Approved" data-href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?bid=<?=$value['receiver']?>&id=<?=$value['id']?>&type=<?=$value['typenum']?><? if($post['StartPage']){?>&page=<?=$post['StartPage']?><? }?>&action=confirm" data-cond="1" class="dialog_refunded dropdown-item withdraw type_<?=$value['typenum']?> "><i class="<?=$data['fwicon']['rotate-right'];?>"></i> Accept</a></li>
  <? }?>
  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['t_withdraw_reject'])&&$_SESSION['t_withdraw_reject']==1)){?>
  <li><a data-reason="<?=$value['type']?> Request Rejected" data-label="<?=$value['type']?> Reason" onClick="confirm2(this);" data-href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?bid=<?=$value['receiver']?>&id=<?=$value['id']?>&type=<?=$value['typenum']?><? if($post['StartPage']){?>&page=<?=$post['StartPage']?><? }?>&action=cancel" class="ajxstatus dropdown-item"><i class="<?=$data['fwicon']['reject'];?>"></i> Reject</a></li>
  <? }?>
  <? }elseif($value['ostatus']==15||$value['ostatus']==16||$value['ostatus']==17){?>
  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['t_fund_reject'])&&$_SESSION['t_fund_reject']==1)){?>
  <li><a data-reason="This Fund Rejected" data-label="Fund Reason" onClick="confirm2(this);" data-href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?bid=<?=$post['bid']?>&id=<?=$value['id']?>&type=<?=$value['typenum']?><? if($post['StartPage']){?>&page=<?=$post['StartPage']?><? }?>&action=cancel" class="ajxstatus dropdown-item"><i class="<?=$data['fwicon']['reject'];?>"></i> Reject</a></li>
  <? }?>
  <? }else{?>
  <? if($value['ostatus']==0){?>
  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['t_status_confirm'])&&$_SESSION['t_status_confirm']==1)){?>
  <li><a data-reason="Are you Sure to Confirm" data-label="Why do you want to complete this transaction" onClick="confirm2(this);" data-href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?<? if(isset($post['bid']) && $post['bid']){?>bid=<?=$post['bid']?>&<? } ?>id=<?=$value['id']?><? if($post['StartPage']){?>&page=<?=$post['StartPage']?><? }?><? if($post['type']){?>&type=<?=$post['type']?><? }?>&action=confirm" class="ajxstatus dropdown-item"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Confirm</a></li>
  <? }?>
  <? }?>
  <? 
						//IF STATUS=1 THEN DON'T CANCEL, SO COMMENT ['ostatus']==1 -- 
						if($value['ostatus']==0 || /*$value['ostatus']==1 ||*/ $value['ostatus']==8){?>
  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['t_status_cancel'])&&$_SESSION['t_status_cancel']==1)){?>
  <li><a data-reason="Cancel Reason" data-label="Why do you want to cancel" onClick="confirm2(this);" data-href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?<? if(isset($post['bid']) && $post['bid']){?>bid=<?=$post['bid']?>&<? } ?>id=<?=$value['id']?><? if($post['StartPage']){?>&page=<?=$post['StartPage']?><? }?><? if($post['type']){?>&type=<?=$post['type']?><? }?>&action=cancel" class="ajxstatus dropdown-item"><i class="<?=$data['fwicon']['circle-cross'];?>"></i> Cancel</a></li>
  <? }?>
  <? }?>
  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['t_status_return'])&&$_SESSION['t_status_return']==1)){?>
  <? if($value['ostatus']==1 || $value['ostatus']==4  || $value['ostatus']==6 || $value['ostatus']==8){?>
  <? if($value['trname']=="ch"){?>
  <li><a data-reason="Returned Reason" data-label="RETURNED"  data-href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?<? if(isset($post['bid']) && $post['bid']){?>bid=<?=$post['bid']?>&<? } ?>id=<?=$value['id']?><? if($post['StartPage']){?>&page=<?=$post['StartPage']?><? }?><? if($post['type']){?>&type=<?=$post['type']?><? }?>&action=returned" class="dialog_open dropdown-item"><i class="<?=$data['fwicon']['return'];?>"></i> Return</a></li>
  <? }?>
  <? }?>
  <? }?>
  <? if($value['ostatus']==1 || $value['ostatus']==4  || $value['ostatus']==6 || $value['ostatus']==8){?>
  <? if($value['trname']=="cn"){?>
  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['t_status_chargeback'])&&$_SESSION['t_status_chargeback']==1)){?>
  <li><a data-reason="Chargeback Reason" data-label="Chargeback" data-href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?<? if(isset($post['bid']) && $post['bid']){?>bid=<?=$post['bid']?>&<? } ?>id=<?=$value['id']?><? if($post['StartPage']){?>&page=<?=$post['StartPage']?><? }?><? if($post['type']){?>&type=<?=$post['type']?><? }?>&action=chargeback" class="dialog_open dropdown-item"><i class="<?=$data['fwicon']['chargeback'];?>"></i> Chargeback</a></li>
  <? }?>
  <? }?>
  <? }?>
  <? if($value['ostatus']!=1&&(isset($_SESSION['login_adm']))||(isset($_SESSION['t_a_require'])&&$_SESSION['t_a_require']==1)){?>
  <li><a data-reason="Transaction documents has been requested from the merchant" data-label="System will send the email to merchant to request documents" onClick="confirm2(this);" data-href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?<? if(isset($post['bid']) && $post['bid']){?>bid=<?=$post['bid']?>&<? } ?>id=<?=$value['id']?><? if($post['StartPage']){?>&page=<?=$post['StartPage']?><? }?><? if($post['type']){?>&type=<?=$post['type']?><? }?>&action=action_require" class="ajxstatus dropdown-item"><i class="<?=$data['fwicon']['retweet'];?>"></i> A. Require</a></li>
  <? }?>
  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['t_add_remark'])&&$_SESSION['t_add_remark']==1)){?>
  <li><a data-href="<?=$idx;?>_toggle" data-tabname="addremarkform_tab" class="atablink dropdown-item"><i class="<?=$data['fwicon']['add-remark'];?>"></i> Add Remark</a></li>
  <? }?>
  <? if($value['typenum']!=2&&((isset($_SESSION['login_adm']))||(isset($_SESSION['t_cs_trans'])&&$_SESSION['t_cs_trans']==1))){?>
  <li><a class="iframe_open99 dropdown-item" data-mid="<?=$value['receiver']?>" data-href="<?=$idx;?>_toggle" data-tabname="" data-url="" data-ihref="<?=$data['Host'];?>/include/similar_transaction<?=$data['ex']?>?id=<?=$value['id']?>&admin=1" title="Create Similar Transaction" onClick="iframe_open_modal(this);"><i class="<?=$data['fwicon']['database'];?>"></i>&nbsp;C. S. Trxn.</a></li>
  <? }?>
  <? 
						//TEST TRANSACTION NOT ACTIVE IN CASE OF WITHDRAW - $value['typenum']!=2 CONDITION SET BY 
						if($value['typenum']!=2&&$value['ostatus']!=1&&((isset($_SESSION['login_adm']))||(isset($_SESSION['t_status_test'])&&$_SESSION['t_status_test']==1))){?>
  <li><a data-reason="Test Transaction" data-label="Do you want to Test this Transaction" onClick="confirm2(this);" data-href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?<? if(isset($post['bid']) && $post['bid']){?>bid=<?=$post['bid']?>&<? } ?>id=<?=$value['id']?><? if($post['StartPage']){?>&page=<?=$post['StartPage']?><? }?><? if($post['type']){?>&type=<?=$post['type']?><? }?>&action=testransaction" class="ajxstatus dropdown-item"><i class="<?=$data['fwicon']['test'];?>"></i> Test</a></li>
  <? }?>
  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['t_status_refunded'])&&$_SESSION['t_status_refunded']==1)){?>
  <? if($value['typenum']!=2&&($value['ostatus']==1 || $value['ostatus']==4  || $value['ostatus']==6 || $value['ostatus']==8)){?>
  <li><a data-amount="<?=$value['oamount']?>" data-reason="Refund Reason" data-label="Refund Reason" data-refund="<?=(isset($data['t'][$value['typenum']]['refund'])?$data['t'][$value['typenum']]['refund']:'')?>" data-href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?bid=<?=$value['receiver']?>&id=<?=$value['id']?><? if($post['StartPage']){?>&page=<?=$post['StartPage']?><? }?>&type=<?=$value['typenum']?>&action=refund_request" class="dialog_refunded open_pop dropdown-item type_<?=$value['typenum']?>"><i class="<?=$data['fwicon']['rotate-right'];?>"></i>
    <?=$value['typenum']?>
    Refund Req.</a></li>
  <? }?>
  <? }?>
  <? if(empty($value['transaction_flag']) || $value['transaction_flag']=="2"  || $value['transaction_flag']=="3"){ ?>
  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['t_status_flag'])&&$_SESSION['t_status_flag']==1)){?>
  <? }?>
  <? }else {?>
  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['t_status_unflag'])&&$_SESSION['t_status_unflag']==1)){?>
  <li><a data-reason="UnFlag Reason" data-label="UnFlag Reason" onClick="confirm2(this);" data-href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?<? if(isset($post['bid']) && $post['bid']){?>bid=<?=$post['bid']?>&<? } ?>id=<?=$value['id']?><? if($post['StartPage']){?>&page=<?=$post['StartPage']?><? }?><? if($post['type']){?>&type=<?=$post['type']?><? }?>&action=unflagransaction" class="ajxstatus dropdown-item"><i class="<?=$data['fwicon']['flag'];?>"></i> Unflag</a></li>
  <? }?>
  <? } ?>
  <? if($value['ostatus']==1 || $value['ostatus']==4  || $value['ostatus']==6 || $value['ostatus']==8){?>
  <? if($value['trname']=="cn"){?>
  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['t_status_pre_dispute'])&&$_SESSION['t_status_pre_dispute']==1)){?>
  <li><a data-reason="Pre Dispute Reason" data-value="Pre-Dispute Alert Received"  data-href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?<? if(isset($post['bid']) && $post['bid']){?>bid=<?=$post['bid']?>&<? } ?>id=<?=$value['id']?><? if($post['StartPage']){?>&page=<?=$post['StartPage']?><? }?><? if($post['type']){?>&type=<?=$post['type']?><? }?>&action=cbk1" class="dialog_open dropdown-item"><i class="<?=$data['fwicon']['rotate-right'];?>"></i> Pre Dispute</a></li>
  <? }?>
  <? }?>
  <? }?>
  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['transaction_status_update'])&&$_SESSION['transaction_status_update']==1)){?>
  <? if((isset($value['json_value_de']['status_'.$value['typenum']]))&&($value['json_value_de']['status_'.$value['typenum']])){?>
  <?php /*?><li class='g_validate 13'><a data-transID="<?=$value['transID'];?>_<?=$value['id'];?>" data-type="<?=$value['typenum'];?>" onClick="check_statusf(this,'<?=($data['Host']);?>/<?=($value['json_value_de']['status_'.$value['typenum']]);?>&actionurl=by_admin&admin=1&type=<?=($value['typenum']);?>');" class="hkip_status_id dropdown-item"><i class="<?=$data['fwicon']['retweet'];?>"></i> <?=$data['t'][$value['typenum']]['name1'];?> Status</a></li><?php */?>
  

  
  <li><a class="hrefmodal dropdown-item" data-tid="<?=$data['t'][$value['typenum']]['name1'];?> Status - <?=$value['transaction_id']?>" data-mid="<?=$value['receiver']?>" data-href="<?=($data['Host']);?>/<?=($value['json_value_de']['status_'.$value['typenum']]);?>&actionurl=by_admin&admin=1&type=<?=($value['typenum']);?>" title="<?=$data['t'][$value['typenum']]['name1'];?> Status" ><i class="<?=$data['fwicon']['retweet'];?>"></i> <?=$data['t'][$value['typenum']]['name1'];?> Status</a></li>
  
    
  <? }else{?>
  <? if($value['typenum']>4){?>
  <li class='g_validate 14'><a data-mhoid="<?=$value['transID'];?>_<?=$value['id'];?>" data-type="<?=$value['typenum'];?>" onClick="hkipstatus(this);" class="hkip_status_id dropdown-item"><i class="<?=$data['fwicon']['retweet'];?>"></i>
    <?=$data['t'][$value['typenum']]['name1'];?>
    Status</a></li>
  <? }?>
  <? }?>
  <? if($value['cardtype']=='amex'){?>
  <li class='g_validate 15'><a data-mhoid="<?=$value['transID'];?>_<?=$value['id'];?>" data-type="16" onClick="hkipstatus(this);" class="hkip_status_id dropdown-item"><i class="<?=$data['fwicon']['retweet'];?>"></i> Amex Status</a></li>
  <? }?>
  <? }?>
  <? }?>
</ul>
                    </div>
                  </div>
                <? }?>
                <? }?>
               </td>
                
                <td align="center" title="Full Name: <?=prntext($value['names']);?>" data-bs-toggle="tooltip" data-bs-placement="top" nowrap>
				
				<? if(in_array("names",$_SESSION['transaction_display_arr'])){?>
				<div class="transaction-list-h1"><?=prntext(lf($value['names'],15,1));?> </div>               
				<? }?>
				
				<? if(in_array("email_add",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_email_add'])&&$_SESSION['tr_email_add']==1))){?>
                <div class="transaction-list-h2"><?=prntext($value['email_add']);?></div>
                <? }?>
				
				</td>
                <td align="center" class="pricecolor" nowrap>
				<? if(in_array("amount",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_amount'])&&$_SESSION['tr_amount']==1))){?>
                <? if(in_array("amount",$_SESSION['transaction_display_arr'])){?>
                <div class="transaction-list-h1"><?=$value['amount']?></div>
                <? }?>
				<? }?>
				<? if(in_array("transaction_amt",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_transaction_amt'])&&$_SESSION['tr_transaction_amt']==1))){?>
                <div class="transaction-list-h2"><?=$value['transaction_amt']?></div>
                <? }?>
				
				</td>
              <td align="center" class="pricecolor" nowrap>
                <? if(in_array("available_balance",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_available_balance'])&&$_SESSION['tr_available_balance']==1))){?>
                <div class="transaction-list-h1"><?=$value['available_balance']?></div>
                <? }?>
				</td>
				<td align="center" nowrap>
                <? if(in_array("tdate",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_tdate'])&&$_SESSION['tr_tdate']==1))){?>
                <div class="transaction-list-h1"><?=prndate($value['tdate'])?></div>
                <? }?>
				<? if(in_array("created_date",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_created_date'])&&$_SESSION['tr_created_date']==1))){?>
                <div class="transaction-list-h2"><?=prndate($value['created_date']);?></div>
                <? }?>
				
				</td><td align="center" valign="top" >
                <? if(in_array("cardtype",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_cardtype'])&&$_SESSION['tr_cardtype']==1))){?>
                <?
	   $fwimg=0;
	   $img="nocc.png";$txt='No Card Available';$sort="&ccard_type=-1";$style1="width:30px;height:auto;";
	   //echo $data['t'][$value['typenum']]['name2'];
	    
	   if(isset($data['t'][$value['typenum']]['logo'])&&$data['t'][$value['typenum']]['logo']){
			$img=$data['t'][$value['typenum']]['logo']."_logo.png";
			$txt=$data['t'][$value['typenum']]['name1'];
			$sort="&payment_type=cn";
			$style1="width:48px;height:auto;";
	   }
	   
	   if($value['cardtype']=='visa'){ 
	   $fwimg=1; $fwicon=$data['fwicon']['visa'];
	   $img="visacard.png";$txt='Visa Card';$sort="&ccard_type=Visa";}
	   elseif ($value['cardtype']=='jcb'){
	   $fwimg=1; $fwicon=$data['fwicon']['jcb'];
	   $img="jcb.png";$txt='JCB Card';$sort="&ccard_type=JCB";}
	   elseif ($value['cardtype']=='mastercard'){
	   $fwimg=1; $fwicon=$data['fwicon']['mastercard'];
	   $img="master.png";$txt='Master Card';$sort="&ccard_type=MasterCard";}
	   elseif ($value['cardtype']=='discover'){
	   $fwimg=1; $fwicon=$data['fwicon']['discover'];
	   $img="discover.png";$txt='Discover';$sort="&ccard_type=Discover";}
	   elseif ($value['cardtype']=='rupay'){$img="rupay.jpg";$txt='Rupay';$sort="&ccard_type=rupay";}
	   elseif ($value['cardtype']=='amex'){
	   $fwimg=1; $fwicon=$data['fwicon']['amex'];
	   $img="amex.png";$txt='Amex';$sort="&ccard_type=amex";}
	   
	   elseif ($data['t'][$value['typenum']]['name2']=="Debit Card"){
	   $fwimg=1; $fwicon=$data['fwicon']['creditcard'];
	   }
	   elseif (strstr($data['t'][$value['typenum']]['name1'],"QR")){
	   $fwimg=1; $fwicon=$data['fwicon']['qr-code'];
	   }
	   elseif ($data['t'][$value['typenum']]['name2']=="eWallets"){
	   $fwimg=1; $fwicon=$data['fwicon']['wallet'];
	   }
	   elseif ($data['t'][$value['typenum']]['name1']=="AdvCash"){
	   $fwimg=1; $fwicon=$data['fwicon']['AdvCash'];
	   }
	   elseif ($data['t'][$value['typenum']]['name2']=="Net Banking"){
	   $fwimg=1; $fwicon=$data['fwicon']['netbanking'];
	   }
	   elseif (strstr($data['t'][$value['typenum']]['name2'],"UPI")){
	   $fwimg=1; $fwicon='<img src="'.$data['bankicon']['upi-icon'].'" class="img-fluid img-hover" style="max-height:18px;">';
	   }
	   
	   
	   elseif ($value['cardtype']==-1){
	   $fwimg=1; $fwicon=$data['fwicon']['nocc'];
	   $img="nocc.png";$txt='No Card Available';$sort="&ccard_type=-1";
	   }
	   
	  
	  if($img=="nocc.png"){ $fwimg=1; $fwicon=$data['fwicon']['nocc']; }
	  
	   

	   if($value['t']=="Check Payment"){
		$img="echeck.png";$txt='echeck';$sort="&payment_type=ch";
	   }
	   elseif($value['t']=="Withdraw"){
		$img="wd.png";$txt='Withdraw';$sort="&payment_type=wd";
	   }
	   elseif($value['t']=="Deposit"){
		$img="deposit.png";$txt='Deposit';$sort="&payment_type=dp";
	   }
	   elseif($value['t']=="Withdraw Rolling"){
		$img="wr.png";$txt='Withdraw Rolling';$sort="&payment_type=wr";
	   }
	   
	   $sort=$data['Admins']."/transactions".$data['ex']."?action=select".$data['cmn_action'].$sort;
	   ?>
                  <a href="<?=$sort;?>" title="<?=$txt?>" data-bs-toggle="tooltip" data-bs-placement="top">
                  <? if($fwimg==0){ ?>
                  <img src="<?=$data['Host']?>/images/<?=$img?>" class="img-fluid img-hover" alt="<?=$txt?>" style="max-height:18px;">
                  <? }else{ echo $fwicon; ?>
                  <? } ?>
                  </a> 
                <? }?>
				<? if(in_array("type",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_type'])&&$_SESSION['tr_type']==1))){?>
                <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['t_acquirer_view'])&&$_SESSION['t_acquirer_view']==1)){?>
                <? if($post['type']<0){?>
                <div class="transaction-h2"><?=$value['type']?></div>
                <? }?>
                <? }?>
                <? }?>
				
				
				
				</td>

                 <td align="center" nowrap>
				 <div class="transaction-list-h1">
                <? if(in_array("status",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_status'])&&$_SESSION['tr_status']==1))){?>
                <? if($post['status']<0){?>
               <? if(isset($data['wdata1']) && $data['wdata1']=='5'){?>
                  <span class="transaction-list-h1" style="color:#00F">Pending</span>
                  <? }else {echo $value['status'];}?>                
                <? }?>
                <? }?>
				</div>
				<? if(in_array("reason",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_reason'])&&$_SESSION['tr_reason']==1))){?>
                <div class="transaction-list-h2" title="<?=$value['reason']?>" data-bs-toggle="tooltip" data-bs-placement="top" style="width:120px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
                    <?=str_replace("-","",$value['reason'])?>
                  </div>
                <? }?>
				
				</td>
				
				<td align="center" nowrap>
                <? if(in_array("receiver",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_receiver'])&&$_SESSION['tr_receiver']==1))){?>
                <? if($value['receiver']<0){?>
                  <div class="transaction-list-h1"><?=$value['recvuser']?></div>
                  <? }else{?>
				  <div class="transaction-list-h1">
                  <a <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_view'])&&$_SESSION['merchant_action_view']==1)){?> class="collapsea atablink mprofile text-link" data-mid="<?=$value['receiver']?>" data-href="<?=$idx;?>_toggle" data-tabname=""  data-url="<?=$data['Host'];?>/include/riskratioall<?=$data['ex']?>?uid=<?=$value['receiver']?>"   data-mhref="user<?=$data['ex']?>?<? if(isset($post['bid']) && $post['bid']){?>bid=<?=$post['bid']?>&<? } ?>id=<?=$value['receiver']?>&action=detail" <? }?> title="View Merchant Details" ><?=$value['recvuser']?></a>
				  </div>
                  
                  <? }?>                
                <? }?>
               </td>
				
				<td align="center" nowrap title="Card Number: <?=bclf($value['ccno'],$value['bin_no']);?>" data-bs-toggle="tooltip" data-bs-placement="top">
                <? if(in_array("ccno",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_ccno'])&&$_SESSION['tr_ccno']==1))){?>
                <div class="transaction-list-h1"><?=bclf($value['ccno'],$value['bin_no']);?></div>
                <? }?>
				
				<? if(in_array("upa",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_upa'])&&$_SESSION['tr_upa']==1))){?>
                <div class="transaction-list-h2"><?=$value['upa']?></div>
                <? }?>
				
				</td>
				<td align="center" nowrap>
                <? if(in_array("ip",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_ip'])&&$_SESSION['tr_ip']==1))){?>
				<div class="transaction-list-h1">
                <a onclick="iframe_open_modal(this);" class="dotdot nomid" data-ihref='<?=$data['Host'];?>/include/ips<?=$data['ex']?>?remote=<?=$value['ip']?>' title='IP: <?=prntext($value['ip']);?>' data-bs-toggle="tooltip" data-bs-placement="top"><?=prntext(lf($value['ip'],15,1));?></a>
				</div>
                  
                <? } ?>
				<? if(in_array("store_id",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_store_id'])&&$_SESSION['tr_store_id']==1))){?>
                <div class="transaction-list-h2"><?=$value['store_id']?></div>
                <? }?>
				
				</td>
                <td align="center" nowrap title="RefNo ID of Bank Response" >
                <? if(in_array("txn_id",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_txn_id'])&&$_SESSION['tr_txn_id']==1))){?>
                <div class="transaction-list-h1"><?=$value['txn_id']?></div>
                <? }?>
				</td>
				<td nowrap align="center">
                <? if(in_array("txn_value",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_txn_value'])&&$_SESSION['tr_txn_value']==1))){?>
                 <div class="transaction-list-h1">
				 <a  class="dotdot nomid text-link modal_for_iframe" href='<?=$data['Admins'];?>/json_pretty_print<?=$data['ex']?>?json=<?=encryptres($value['txn_value']);?>' >
                  <?=prntext(lf($value['txn_value'],15,1));?>
                  </a>
				  </div>
				  
                <? }?>
				<? if(in_array("json_value",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_json_value'])&&$_SESSION['tr_json_value']==1))){?>
              <div class="transaction-list-h2">
			  <a class="dotdot nomid text-link modal_for_iframe" href='<?=$data['Admins'];?>/json_pretty_print<?=$data['ex']?>?json=<?=encryptres($value['json_value']);?>' >
                  <?=prntext(lf($value['json_value'],15,1));?>
                </a>
				</div>
                <? }?>
				</td>
               
               <td align="center" nowrap>
			   
<? if(in_array("reply_remark",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_reply_remark'])&&$_SESSION['tr_reply_remark']==1))){?>
<div class="transaction-list-h1">
<a onclick="iframe_open_modal(this);" class="dotdot nomid text-link" data-ihref='<?=$data['Admins'];?>/json_pretty_print<?=$data['ex']?>?strip=skip&json=<?=encryptres($value['reply_remark']);?>' style="height:20px;" >Note Support</a>
</div>
<? } ?>
<? if(in_array("system_note",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_system_note'])&&$_SESSION['tr_system_note']==1))){?>
<div class="transaction-list-h2">
<a onclick="iframe_open_modal(this);" class="dotdot nomid" data-ihref='<?=$data['Admins'];?>/json_pretty_print<?=$data['ex']?>?strip=skip&json=<?=encryptres($value['system_note']);?>' style="height:20px;overflow:hidden;" >Sys.Note</a>
</div>
                <? }?>
				
				</td>
             <td align="center" >
<? if(in_array("source_url",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_source_url'])&&$_SESSION['tr_source_url']==1))){?>
<div class="transaction-list-h1">
<a class="dotdot nomid text-link modal_for_iframe" href='<?=$data['Admins'];?>/json_pretty_print<?=$data['ex']?>?strip=skip&json=<?=encryptres($value['source_url']);?>' ><?=prntext(lf($value['source_url'],15,1));?></a>
</div>
<? }?>
<? if(in_array("notify_url",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_notify_url'])&&$_SESSION['tr_notify_url']==1))){?>
<div class="transaction-list-h2">
<a class="dotdot nomid text-link modal_for_iframe" ihref='<?=$data['Admins'];?>/json_pretty_print<?=$data['ex']?>?strip=skip&json=<?=encryptres($value['notify_url']);?>' style="height:20px;overflow:hidden;" ><?=prntext(lf($value['notify_url'],15,1));?></a>
 </div>                 
                  
                <? }?>
				
				</td>
               <td align="center" nowrap >
                <? if(in_array("success_url",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_success_url'])&&$_SESSION['tr_success_url']==1))){?>
				<div class="transaction-list-h1">
                <a class="dotdot nomid text-link modal_for_iframe" href='<?=$data['Admins'];?>/json_pretty_print<?=$data['ex']?>?strip=skip&json=<?=encryptres($value['success_url']);?>' style="height:20px;overflow:hidden;" >
                  <?=prntext(lf($value['success_url'],15,1));?>
                  </a>
				</div>    
                <? }?>
				 <? if(in_array("failed_url",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_failed_url'])&&$_SESSION['tr_failed_url']==1))){?>
                <div class="transaction-list-h2">
				<a class="dotdot nomid text-link modal_for_iframe" href='<?=$data['Admins'];?>/json_pretty_print<?=$data['ex']?>?strip=skip&json=<?=encryptres($value['failed_url']);?>' style="height:20px;overflow:hidden;" >
                  <?=prntext(lf($value['failed_url'],15,1));?>
                  </a>
				</div>  
                <? }?>
				</td>
               <td align="center" nowrap>
                <? if(in_array("mdr_amt",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_mdr_amt'])&&$_SESSION['tr_mdr_amt']==1))){?>
                <div class="transaction-list-h1"><?=$value['mdr_amt'];?></div>
                <? }?>
				<? if(in_array("gst_fee",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_gst_fee'])&&$_SESSION['tr_gst_fee']==1))&&($data['con_name']=='clk')){?>
                <div class="transaction-list-h2"><?=$value['gst_fee'];?></div>
                <? }?>
				</td>
                
				<td align="center" nowrap>
				<? if(in_array("rrn",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_rrn'])&&$_SESSION['tr_rrn']==1))){?>
                <div class="transaction-list-h1"><?=$value['rrn'];?></div>
                <? }?>
				<? if(in_array("mdr_txtfee_amt",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_mdr_txtfee_amt'])&&$_SESSION['tr_mdr_txtfee_amt']==1))){?>
                <div class="transaction-list-h2"><?=$value['mdr_txtfee_amt'];?></div>
                <? }?>
				</td>
				
                
				<td align="center" nowrap >
                <? if(in_array("rolling_amt",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_rolling_amt'])&&$_SESSION['tr_rolling_amt']==1))){?>
                <div class="transaction-list-h1"><?=$value['rolling_amt'];?></div>
                <? }?>
				<? if(in_array("mdr_cb_amt",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_mdr_cb_amt'])&&$_SESSION['tr_mdr_cb_amt']==1))){?>
                <div class="transaction-list-h2"><?=$value['mdr_cb_amt'];?></div>
                <? }?>
				
				
				</td>
                
				
				<td align="center">
                <? if(in_array("mdr_cbk1_amt",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_mdr_cbk1_amt'])&&$_SESSION['tr_mdr_cbk1_amt']==1))){?>
                <div class="transaction-list-h1"><?=$value['mdr_cbk1_amt'];?></div>
                <? }?>
				<? if(in_array("mdr_refundfee_amt",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_mdr_refundfee_amt'])&&$_SESSION['tr_mdr_refundfee_amt']==1))){?>
                <div class="transaction-list-h1"><?=$value['mdr_refundfee_amt'];?></div>
                <? }?>
				</td>
                
				<td align="center">
                <? if(in_array("payable_amt_of_txn",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_payable_amt_of_txn'])&&$_SESSION['tr_payable_amt_of_txn']==1))){?>
                <div class="transaction-list-h1"><?=$value['payable_amt_of_txn'];?></div>
                <? }?>
				<? if(in_array("payout_date",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_payout_date'])&&$_SESSION['tr_payout_date']==1))){?>
                <div class="transaction-list-h2"><?=prndate($value['payout_date']);?></div>
                <? }?>
				</td>
                
                <td align="center" nowrap>
                <? if(in_array("risk_ratio",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_risk_ratio'])&&$_SESSION['tr_risk_ratio']==1))){?>
                <div class="transaction-list-h1"><?=$value['risk_ratio'];?></div>
                <? }?>
				<? if(in_array("transaction_period",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_transaction_period'])&&$_SESSION['tr_transaction_period']==1))){?>
                <div class="transaction-list-h2"><?=$value['transaction_period'];?></div>
                <? }?>
				
				</td>
                <td align="center" nowrap>
                <? if(in_array("bank_processing_amount",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_bank_processing_amount'])&&$_SESSION['tr_bank_processing_amount']==1))){?>
                <div class="transaction-list-h1"><?=$value['bank_processing_amount'];?></div>
                <? }?>
				
				</td>
				
				
				<td align="center" >
                <? if(in_array("bank_processing_curr",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_bank_processing_curr'])&&$_SESSION['tr_bank_processing_curr']==1))){?>
                <div class="transaction-list-h1"><?=$value['bank_processing_curr'];?></div>
                <? }?>
				<? if(in_array("currname",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_currname'])&&$_SESSION['tr_currname']==1))){?>
                <div class="transaction-list-h2"><?=$value['currname'];?></div>
                <? }?>
				
				</td>
				
                
				
				<td align="center" nowrap title="Orderset: <?=$value['transID'];?>" data-label="Orderset" data-bs-toggle="tooltip" data-bs-placement="top">
                <? if(in_array("transID",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_transID'])&&$_SESSION['tr_transID']==1))){
				?>
                <? if($value['transID']){ ?>
                  <div class="transaction-list-h1">
				  <a class="dotdot nomid modal_for_iframe" href='<?=$data['Admins'];?>/json_pretty_print<?=$data['ex']?>?json=<?=encryptres($value['transID']);?>'><?=prntext(lf($value['transID'],15,1));?></a>
				  </div>
                  <? } ?>
                <? } ?>
				
				<? if(in_array("trname",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_trname'])&&$_SESSION['tr_trname']==1))){?>
                <div class="transaction-list-h1"><?=$value['trname'];?></div>
                <? }?>
				
				</td>
                
               <td align="center" nowrap >
                <? if(in_array("phone_no",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_phone_no'])&&$_SESSION['tr_phone_no']==1))){?>
                <div class="transaction-list-h1"><?=prntext($value['phone_no']);?></div>
                <? }?>
				</td>
				<td align="center" nowrap>
                <? if(in_array("product_name",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_product_name'])&&$_SESSION['tr_product_name']==1))){?>
                <div class="transaction-list-h1"><a class="dotdot nomid modal_for_iframe" href='<?=$data['Admins'];?>/json_pretty_print<?=$data['ex']?>?json=<?=encryptres($value['product_name']);?>' ><?=prntext(lf($value['product_name'],15,1));?></a></div>
                  
                <? }?>
				</td>
				<td align="center" nowrap title="Address: <?=prntext($value['address']);?>" data-label="Address">
                <? if(in_array("address",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_address'])&&$_SESSION['tr_address']==1))){?>
				<div class="transaction-list-h1">
                <a class="dotdot nomid modal_for_iframe" href='<?=$data['Admins'];?>/json_pretty_print<?=$data['ex']?>?json=<?=encryptres($value['address']);?>' data-bs-toggle="tooltip" data-bs-placement="top"><?=prntext(lf($value['address'],15,1));?></a>
				</div>
                <? }?>
				<div class="transaction-list-h2">
				<? if(in_array("city",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_city'])&&$_SESSION['tr_city']==1))){?>
                <?=prntext($value['city']);?>
                <? }?>
				
				<? if(in_array("state",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_state'])&&$_SESSION['tr_state']==1))){?>
                / <?=prntext($value['state']);?>
                <? }?>
				</div>
				</td>
				
                
				<td align="center">
                <? if(in_array("country",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_country'])&&$_SESSION['tr_country']==1))){?>
                <div class="transaction-list-h1"><?=prntext($value['country']);?></div>
                <? }?>
				<? if(in_array("zip",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_zip'])&&$_SESSION['tr_zip']==1))){?>
                <div class="transaction-list-h2"><?=prntext($value['zip']);?></div>
                <? }?>
				</td>
                <td align="center" nowrap >
                <? if(in_array("descriptor",$_SESSION['transaction_display_arr'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['tr_descriptor'])&&$_SESSION['tr_descriptor']==1))){?>
                <div class="transaction-list-h1"><?=prntext($value['descriptor']);?></div>
                <? }?>
				</td>
              </tr>
			  
			  
			  
			  
              <?php /*?><tr class="trc_2">
                <td colspan="14" align=left><div class="collapseitem" id="<?=$idx;?>_toggle">
                    <div class="content_holder"> </div>
                  </div></td>
              </tr><?php */?>
              <? $idx++; } }?>
            </table>
		  </a>
			
    

		
          <div class="container pagination text-center" id="total_record_result">
            <?php
	//if(!isset($_SESSION['total_record_result']))
	if(!isset($_GET['tscount']))
	{
		
		include("../include/pagination_new".$data['iex']);
		
		
		
		if(isset($_REQUEST['cl'])){unset($_REQUEST['cl']);}
		
		if(isset($_REQUEST['page'])){$page=$_REQUEST['page'];unset($_REQUEST['page']);}else{$page=1;}
		if(isset($_REQUEST['last_page'])) unset($_REQUEST['last_page']);

		$get=http_build_query($_REQUEST);

//		$url="transactions".$data['ex']."?".$get;
		$url=$_SERVER['PHP_SELF']."?".$get;
		
		$total = (int)$data['tr_count'];
		
		//pagination(50,$page,$url,$total);
		
		if(isset($_GET['last_page']))
		{
			$page = $post['StartPage'];
		}
		
		short_pagination($data['MaxRowsByPage'],$page,$url,$data['last_record'],1);
	}
	else
	{
		include("../include/pagination_pg".$data['iex']);
	
		if(isset($_REQUEST['cl'])){unset($_REQUEST['cl']);}
		
		if(isset($_REQUEST['page'])){$page=$_REQUEST['page'];unset($_REQUEST['page']);}else{$page=1;}
		
		if(isset($_REQUEST['tscount'])){$tscount=$_REQUEST['tscount'];unset($_REQUEST['tscount']);}else {$tscount=0;}
		
		if(isset($_REQUEST['last_page'])) unset($_REQUEST['last_page']);
		
		$get=http_build_query($_REQUEST);

		$url="transactions".$data['ex']."?".$get;
			
		if(isset($post['bid'])){$url.="&bid=".$post['bid'];}
		//if(isset($post['type'])){$url.="&type=".$post['type'];}
		//if(isset($post['status'])){$url.="&status=".$post['status'];}
		//if(isset($post['action'])){$url.="&action=select";}
		//if(isset($post['order'])){$url.="&order=".$post['order'];}
		if(isset($post['searchkey'])){$url.="&searchkey=".$post['searchkey'];}
		
		if(isset($_GET['page'])){$page=$_GET['page'];}else{$page=1;}
	
		pagination(50,$post['StartPage'],$url,$tscount);
	}
?>
          </div>
		  
          <table class="frame" width="100%" border="0" cellspacing="1" cellpadding="4">
            <tr>
              <td class="capc" width="1%" valign="top" nowrap><? if($post['type']>8 && $post['type']<12){?>
                <script>
			$("<?=$data['ex']?>wnloadcvs").click(function(){
				var valuesArray = $('.echeckid:checked').map(function () {  
					//return this.value;
					return $(this).attr('data-value');
					//alert($(this).attr('data-value'));
				}).get().join(",");
				
				//alert(valuesArray);
				if(valuesArray =="") {
					alert("Please Select any one checkbox !");
				}else{
					newWindow=window.open("<?=$data['Host']?>/csv_data<?=$data['ex']?>?id="+valuesArray, 'newDocument');
				}

			});
			</script>
                <span class="dwn" id="dwn" style="display:none;"> </span>
                <? }?>
              </td>
            </tr>
          </table>
          <? }elseif($post['ViewMode']=='details'){?>
          <table class="frame" width="400" border="0" cellspacing="1" cellpadding="2">
            <tr>
              <td class="capl" colspan="2"><?=strtoupper($data['t'][$post['type']]['name1'])?>
                Transaction Detail</td>
            </tr>
            <tr>
              <td>Date:</td>
              <td><?=$post['TransactionDetails']['tdate']?></td>
            </tr>
            <tr>
              <td>Type:</td>
              <td><?=$post['TransactionDetails']['type']?></td>
            </tr>
            <tr>
              <td>Status:</td>
              <td><?=$post['TransactionDetails']['status']?></td>
            </tr>
            <tr>
              <td>Username:</td>
              <td><? if($post['TransactionDetails']['userid']<0){?>
                <?=$post['TransactionDetails']['username']?>
                <? }else{?>
                <a href="<?=$data['Admins']?>/merchant<?=$data['ex']?>?id=<?=$post['TransactionDetails']['userid']?>&action=select&order=<?=$post['order']?>">
                <?=$post['TransactionDetails']['username']?>
                </a>
                <? }?></td>
            </tr>
            <tr>
              <td>Amount:</td>
              <td><?=$post['TransactionDetails']['amount']?></td>
            </tr>
            <tr>
              <td>Fee:</td>
              <td><?=prnpays($post['TransactionDetails']['fees'])?></td>
            </tr>
            <tr>
              <td>Paid:</td>
              <td><?=$post['TransactionDetails']['nets']?></td>
            </tr>
            <tr>
              <td>Comments:</td>
              <td><?=$post['TransactionDetails']['comments']?></td>
            </tr>
            <tr>
              <td>Details:</td>
              <td><pre class="comms"><?=$post['TransactionDetails']['ecomments']?>
</pre>
              </td>
            </tr>
            <? if($post['wtype']){?>
            <? if($post['wtype']=='paypal'){?>
            <form method="post" action="https://www.paypal.com/cgi-bin/webscr" target=new>
            
            <input type="hidden" name="cmd" value="_xclick">
            <input type="hidden" name="business" value="<?=$post['payee']?>">
            <input type="hidden" name="item_name" value="Withdraw from my <?=$data['SiteName']?> account">
            <input type="hidden" name="no_shipping" value="1">
            <input type="hidden" name="no_note" value="1">
            <input type="hidden" name="amount" value="<?=prnsumm($post['total'])?>">
            <? }elseif($post['wtype']=='stormpay'){?>
            <form method="post" action="https://www.stormpay.com/stormpay/handle_gen.php" target=new>
            
            <input type="hidden" name="generic" value="1">
            <input type="hidden" name="payee_email" value="<?=$post['payee']?>">
            <input type="hidden" name="product_name" value="Withdraw from my <?=$data['SiteName']?> account">
            <input type="hidden" name="amount" value="<?=prnsumm($post['total'])?>">
            <input type="hidden" name="quantity" value="1">
            <input type="hidden" name="require_IPN" value="1">
            <? }elseif($post['wtype']=='netpay'){?>
            <form method="post" action="https://www.netpay.tv/cgi-bin/merchant/mpay.cgi" target=new>
            
            <input type="hidden" name="PAYEE_ACCOUNT" value="<?=$post['payee']?>">
            <input type="hidden" name="PAYEE_NAME" value="<?=$data['SiteName']?>">
            <input type="hidden" name="PAYMENT_AMOUNT" value="<?=prnsumm($post['total'])?>">
            <input type="hidden" name="MEMO" value="Withdraw from my <?=$data['SiteName']?> account">
            <input type="hidden" name="PRODUCT_NAME" value="Withdraw Funds">
            <? }elseif($post['wtype']=='egold'){?>
            <form method="post" action="https://www.e-gold.com/sci_asp/payments.asp" target=new>
            
            <input type="hidden" name="PAYEE_ACCOUNT" value="<?=$post['payee']?>">
            <input type="hidden" name="PAYEE_NAME" value="<?=$data['SiteName']?>">
            <input type="hidden" name="PAYMENT_UNITS" value="1">
            <input type="hidden" name="PAYMENT_METAL_ID" value="1">
            <input type="hidden" name="PAYMENT_AMOUNT" value="<?=prnsumm($post['total'])?>">
            <input type="hidden" name="MEMO" value="Withdraw from my <?=$data['SiteName']?> account">
            <input type="hidden" name="HASH" value="<?=md5("abdo".time().$data['sid'])?>">
            <input type="hidden" name="CHECKSUM" value="<?=time()?>">
            <input type="hidden" name="BAGGAGE_FIELDS" value="">
            <input type="hidden" name="PAYMENT_URL" value="<?=$data['Host']?>">
            <input type="hidden" name="NOPAYMENT_URL" value="<?=$data['Host']?>">
            <? }elseif($post['wtype']=='moneybookers'){?>
            <form method="post" action="https://www.moneybookers.com/app/payment.pl" target=new>
            
            <input type="hidden" name="pay_to_email" value="<?=$post['payee']?>">
            <input type="hidden" name="return_url" value="<?=$data['Host']?>">
            <input type="hidden" name="language" value="EN">
            <input type="hidden" name="amount" value="<?=prnsumm($post['total'])?>">
            <input type="hidden" name="currency" value="USD">
            <input type="hidden" name="detail1_description" value="Transaction Description:">
            <input type="hidden" name="detail1_text" value="Withdraw from my <?=$data['SiteName']?> account">
            <? }elseif($post['wtype']=='intgold'){?>
            <form method="post" action="https://intgold.com/cgi-bin/webshoppingcart.cgi" target=new>
            
            <input type="hidden" name="cmd" value="_xclick">
            <input type="hidden" name="SELLERACCOUNTID" value="<?=$post['payee']?>">
            <input type="hidden" name="METHOD" value=POST>
            <input type="hidden" name="RETURNPAGE" value=CGI>
            <input type="hidden" name="RETURNURL" value="<?=$data['Host']?>">
            <input type="hidden" name="CANCEL_RETURN" value="<?=$data['Host']?>">
            <input type="hidden" name="AMOUNT" value="<?=prnsumm($post['total'])?>">
            <input type="hidden" name="ITEM_NUMBER" value="1">
            <input type="hidden" name="ITEM_NAME" value="<?=$data['SiteName']?>">
            <input type="hidden" name="HASH" value="<?=md5("abdo".time().$data['sid'])?>">
            <? }elseif($post['wtype']=='ebullion'){?>
            <form method="post" name="atip" action="https://www2.e-bullion.com/atip/process.php" target=new>
            
            <input type="hidden" name="ATIP_PAYEE_ACCOUNT" value="<?=$post['payee']?>">
            <input type="hidden" name="ATIP_PAYMENT_UNIT" value="1">
            <input type="hidden" name="ATIP_PAYMENT_METAL" value="0">
            <input type="hidden" name="ATIP_PAYMENT_FIXED" value="0">
            <input type="hidden" name="ATIP_PAYMENT_AMOUNT" value="<?=prnsumm($post['total'])?>">
            <input type="hidden" name="ATIP_PAYER_FEE_AMOUNT" value="">
            <input type="hidden" name="ATIP_FORCED_PAYER_ACCOUNT" value="">
            <input type="hidden" name="ATIP_PAYEE_NAME" value="<?=$data['SiteName']?>">
            <input type="hidden" name="ATIP_SUGGESTED_MEMO" value="Withdraw from my <?=$data['SiteName']?> account">
            <input type="hidden" name="ATIP_BAGGAGE_FIELDS" value="">
            <? }elseif($post['wtype']=='pecunix'){?>
            <form method="post" action="https://pri.pecunix.com/money.refined" target=new>
            
            <input type="hidden" name="PAYEE_ACCOUNT" value="<?=$post['payee']?>">
            <input type="hidden" name="PAYMENT_AMOUNT" value="<?=prnsumm($post['total'])?>">
            <input type="hidden" name="PAYMENT_UNITS" value="USD">
            <input type="hidden" name="SUGGESTED_MEMO" value="Withdraw from my <?=$data['SiteName']?> account">
            <? }elseif($post['wtype']=='epaydirect'){?>
            <form method="post" action="https://www.epaydirect.net/handle.php" target=new>
            
            <input type="hidden" name="receiver" value="<?=$post['payee']?>">
            <input type="hidden" name="amount" value="<?=prnsumm($post['total'])?>">
            <input type="hidden" name="item_name" value="Withdraw from my <?=$data['SiteName']?> account">
            <? }elseif($post['wtype']=='evocash'){?>
            <form method="post" action="https://www.evocash.com/evoswift/index.cfm" target=new>
            
            <input type="hidden" name="receivingaccountid" value="<?=$post['payee']?>">
            <input type="hidden" name="pay_yes_url" value="<?=$data['Host']?>">
            <input type="hidden" name="pay_no_url" value="<?=$data['Host']?>">
            <input type="hidden" name="merchant_check_url" value="<?=$data['Host']?>">
            <input type="hidden" name="reference" value="<?=$data['SiteName']?>">
            <input type="hidden" name="memo" value="Withdraw from my <?=$data['SiteName']?> account">
            <input type="hidden" name="amount" value="<?=prnsumm($post['total'])?>">
            <? }elseif($post['wtype']=='goldmoney'){?>
            <form method="post" action="https://www.goldmoney.com/omi/omipmt.asp" target=new>
            
            <input type="hidden" name="OMI_MERCHANT_HLD_NO" value="<?=$post['payee']?>">
            <input type="hidden" name="OMI_MERCHANT_REF_NO" value="<?=md5("abdo".time().$data['sid'])?>">
            <input type="hidden" name="OMI_CURRENCY_CODE" value="840">
            <input type="hidden" name="OMI_CURRENCY_AMT" value="<?=prnsumm($post['total'])?>">
            <input type="hidden" name="OMI_SIM_MODE" value="0">
            <input type="hidden" name="OMI_MERCHANT_MEMO" value="Withdraw from my <?=$data['SiteName']?> account">
            <input type="hidden" name="OMI_SUCCESS_URL" value="<?=$data['Host']?>">
            <input type="hidden" name="OMI_SUCCESS_URL_METHOD" value="LINK">
            <input type="hidden" name="OMI_FAIL_URL" value="<?=$data['Host']?>">
            <input type="hidden" name="OMI_FAIL_URL_METHOD" value="LINK">
            <? }elseif($post['wtype']=='virtualgold'){?>
            <form method="post" action="https://virtualgold.net/sci_interface.php" target="new">
            
            <input type="hidden" name="ACCOUNT_NO" value="<?=$post['payee']?>">
            <input type="hidden" name="PAYMENT_TYPE" value="ONETIME">
            <input type="hidden" name="PRODUCT_NAME" value="Withdraw from my <?=$data['SiteName']?> account">
            <input type="hidden" name="PAYMENT_AMOUNT" value="<?=prnsumm($post['total'])?>">
            <input type="hidden" name="RETURN_URL" value="<?=$data['Host']?>">
            <input type="hidden" name="CANCEL_URL" value="<?=$data['Host']?>">
            <? }elseif($post['wtype']=='payemo'){?>
            <form method="post" action="https://www.emocorp.com/s/action/PaymentAction" target="new">
            
            <input type="hidden" name="merchant_email" value="<?=$post['payee']?>">
            <input type="hidden" name="merchant_name" value="Withdraw from my <?=$data['SiteName']?> account">
            <input type="hidden" name="amoun"t value="<?=prnsumm($post['total'])?>">
            <input type="hidden" name="return_url" value="<?=$data['Host']?>">
            <input type="hidden" name="cancel_url" value="<?=$data['Host']?>">
            <input type="hidden" name="reference" value="Withdraw from my <?=$data['SiteName']?> account">
            <? }elseif($post['wtype']=='western'){?>
            <form method="post" action="https://wumt.westernunion.com/asp/qcReceiver.asp" target="new">
            
            <? }elseif($post['wtype']=='coinbase'){?>
            <form method="post" action="https://www.coinbase.com/signin" target="blank">
            
            <? }elseif($post['wtype']=='moneygram'){?>
            <form method="post" action="https://www.emoneygram.com/" target="new">
              <? }?>
              <tr>
                <td>&nbsp;</td>
                <td align="center"><input type="submit" class="submit" value="PAY NOW"></td>
              </tr>
            </form>
            <? }?>
            <tr>
              <td class="capc" colspan="2"><a href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?<? if(isset($post['bid']) && $post['bid']){?>bid=<?=$post['bid']?>&<? } ?><? if($post['StartPage']){?>page=<?=$post['StartPage']?><? }?>&type=<?=$post['type']?>&status=<?=$post['status']?>&action=select&order=<?=$post['order']?>">Back</a>
                <? if($post['TransactionDetails']['ostatus']==0){?>
                | <a href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?<? if(isset($post['bid']) && $post['bid']){?>bid=<?=$post['bid']?>&<? } ?>id=<?=$post['TransactionDetails']['id']?><? if($post['StartPage']){?>&page=<?=$post['StartPage']?><? }?>&action=confirm" onClick="return cfmform()">Confirm</a>
                <? }?>
                <? if($post['TransactionDetails']['ostatus']==0||$post['TransactionDetails']['ostatus']==1){?>
                | <a href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?<? if(isset($post['bid']) && $post['bid']){?>bid=<?=$post['bid']?>&<? } ?>id=<?=$post['TransactionDetails']['id']?><? if($post['StartPage']){?>&page=<?=$post['StartPage']?><? }?>&action=cancel" onClick="return cfmform()">Cancel</a>
                <? }?></td>
            </tr>
          </table>
          <? }elseif($post['ViewMode']=='summary'){?>
          <form method="post">
            <input type="hidden" name="action" value="summary">
            <? if($post['day']>0&&$post['month']>0){?>
            <table class="table" width="100%" border="0" cellspacing="1" cellpadding="2">
              <tr>
                <td class="capl" colspan="30">Transaction Summary For
                  <?=$post['day']?>
                  <?=$data['StatMonth'][$post['month']]?>
                  <?=$post['year']?></td>
              </tr>
              <tr>
                <? foreach($data['TransactionType'] as $value){ ?>
                <td class="capc" colspan="2"><?=strtoupper($value)?></td>
                <? }?>
              </tr>
              <tr>
                <? foreach($data['TransactionType'] as $value){ ?>
                <td class="capr" width="7%">SUMM</td>
                <td class="capr" width="7%">FEE</td>
                <? }?>
              </tr>
              <tr>
                <? foreach($post['Daily'] as $value){?>
                <td align="right" nowrap><?=$value['Summ']?></td>
                <td align="right" nowrap><?=$value['Fees']?></td>
                <? }?>
              </tr>
            </table>
            <br>
            <br>
            <? }?>
            <? if($post['month']>0){ ?>
            <table class="table">
              <tr>
                <td class="capl" colspan="30">Transaction Summary For
                  <?=$data['StatMonth'][$post['month']]?>
                  <?=$post['year']?></td>
              </tr>
              <tr>
                <? foreach($data['TransactionType'] as $value){ ?>
                <td class="capc" colspan="2"><?=strtoupper($value)?></td>
                <? } ?>
              </tr>
              <tr>
                <? foreach($data['TransactionType'] as $value){ ?>
                <td class="capr" width="7%">SUMM</td>
                <td class="capr" width="7%">FEE</td>
                <? } ?>
              </tr>
              <tr>
                <? foreach($post['Monthly'] as $value){ ?>
                <td align="right" nowrap><?=$value['Summ']?></td>
                <td align="right" nowrap><?=$value['Fees']?></td>
                <? } ?>
              </tr>
            </table>
            <br>
            <br>
            <? }?>
            <table class="frame" width="100%" border="0" cellspacing="1" cellpadding="2">
              <tr>
                <td class="capl" colspan="30">Transaction Summary For
                  <?=$post['year']?>
                  YEAR</td>
              </tr>
              <tr>
                <? foreach($data['TransactionType'] as $value){ ?>
                <td class="capc" colspan="2"><?=strtoupper($value)?></td>
                <? }?>
              </tr>
              <tr>
                <? foreach($data['TransactionType'] as $value){ ?>
                <td class="capr" width="7%">SUMM</td>
                <td class="capr" width="7%">FEE</td>
                <? }?>
              </tr>
              <tr>
                <? foreach($post['Yearly'] as $value){ ?>
                <td align="right"><?=$value['Summ']?></td>
                <td align="right"><?=$value['Fees']?></td>
                <? } ?>
              </tr>
            </table>
            <br>
            <br>
            <table class="table" width="100%" border="0" cellspacing="1" cellpadding="2">
              <tr>
                <td class="capc"><select name="day" onChange="submit()" >
                    <?=showselect($data['StatDays'], $post['day'])?>
                  </select>
                  /
                  <select name="month" onChange="submit()">
                    <?=showselect($data['StatMonth'], $post['month'])?>
                  </select>
                  /
                  <select name="year" onChange="submit()">
                    <?=showselect($data['StatYear'], $post['year'])?>
                  </select></td>
              </tr>
            </table>
          </form>
          <? } ?>

  </div>
          </div>
</div>

<? }else{?>
SECURITY ALERT: Access Denied
<? }?>
