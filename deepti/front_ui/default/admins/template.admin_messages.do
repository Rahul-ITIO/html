<? if(isset($data['ScriptLoaded'])){ ?>
<div class="container border rounded my-1 vkg" >

<?php /*?>CSS for message listing <?php */?>
<link href="<?=$data['TEMPATH']?>/common/css/message.css" rel="stylesheet">

<? /*?><!--Listing Comes from template.message_ajax.do--><?php */?>
<style>
#wgtmsr option {width: 150 px;}
#filediv{ float: right !important;width: 80%  !important; }
.jqte { width: 100% !important; }
#file { width: 235px!important; }

.active .btn-primary {
background:var(--color-4) !important; 
color : var(--color-3) !important; 
}
/*-webkit-box-shadow: -3px -1px 3px 3px rgba(36,150,9,0.29); 
box-shadow: -3px -1px 3px 3px rgba(36,150,9,0.29);*/
}

    html #tabs { height:unset !important; }
	html #tabs label { width:unset !important;} 
    html #tabs label::before {display: contents !important; height: 0px !important;}
	/*#tabs .nav-link.active {background-color: #fff !important;}*/
	#tabs .nav-link {background-color: #fff !important;}
	html #tabs::after { background:unset !important; height:unset !important; }
</style>
  <input type="hidden" id="step_id" name="step" value="<?=$post['step']?>">
  <script>

var jqte_test='';
var setIn1=''; var setIn2='';
function stopDraftInterval() {
	  $('#publish_button').val('publish');
	  $('#publish_button').hide();
	  //alert('stopDraftInterval');
	  clearInterval(setIn1);
	  clearInterval(setIn2);
	  autoSave();
}
function clearAllInterval() {
	  clearInterval(setIn1);
	  clearInterval(setIn2);
}
function autoSvMsg() {
  //alert($('#autoSave').text());
   $('#autoSave').text('');  
}
function timeoutf(e) {
   setTimeout(function(){ $(e).text(''); }, 3000);
}
function autoSave(){ 
	
   var message_type = $('#message_type_post').val();  
   var subject = $('#subject_post').val(); 
   var comments = $('#comments_post').val();    
   var post_id = $('#post_id').val();
   var publish = $('#publish_button').val();
   var multiple_merchant_ids = $('#multiple_merchant_ids').val(); 
   var message_type_other = $('#message_type_other').val();   
  //var url_name="<?=$data['USER_FOLDER']?>/message_post_ajax<?=$data['ex']?>";
  
   var url_name="<?=$data['Admins'];?>/message_post_ajax<?=$data['ex']?>";
   if(subject != '' && comments != '')  
   {  
		$.ajax({  
			 url:url_name,  
			 type: "POST",
			 dataType: 'json', // text
			 data:{subject:subject, comments:comments, gid:post_id, message_type:message_type, publish:publish, action:"autoSave", multiple_merchant_ids:multiple_merchant_ids, message_type_other:message_type_other},  
			 success:function(data)  
			 {  
				 //alert("11=>"+data['newid']+'\r\nurls=>'+url_name);
				 $('#publish_button').val('');
				 
				 $("#inbox_count").html(data['inbox_count']);
				 $("#inbox_count_process").html(data['inbox_process']);
				 $("#draft_count").html(data['draft_count']);

				  if(data['Error']&&data['Error'] != ''){  
					   alert(data['Error']);
				  }
				  if(data['newid'] != ''){  
					   $('#post_id').val(data['newid']);  
					   //alert("22=>"+data);
					   if(data['ticketid']&&data['ticketid'] != ''){  
						   $('#message_id').val(data['ticketid']);  
						   //alert("22=>"+data);
					  }
					  $('#multiple_files_id #uploaddoc_img_text').show(1000);
					  $('#multiple_files_id .discardDraft').show(1000);
				  }
				  
				 if(data['publish']&&data['publish'] != ''){  
					$('#tabs label').eq(2).trigger("click");
				 }
					
				  $('#autoSave').text("Post save as draft");  
				   setIn2=setInterval(autoSvMsg, 5000);  
			 }  
		});  
   }            
}



function addmessages(e,theVal=''){
	
	if($(e).hasClass('active')){
		$('.addmessagelink').removeClass('active');
		$('.addmessageform').removeClass('active');
		
		$(e).parent().parent().parent().find('.addmessageform').slideUp(200);
		
		if(theVal){
			$(e).parent().parent().parent().find('.row_message').slideDown(500);
		}
	  
	} else {
	  $('.addmessagelink').removeClass('active');
	  $('.addmessageform').removeClass('active');
	  
	  $(e).parent().parent().parent().find('.addmessageform').addClass('active');
	  $(e).addClass('active');
	  
	  $('.addmessageform').slideUp(100);
	  $(e).parent().parent().parent().find('.addmessageform').slideDown(700);
	  
	  if(theVal){
		$(e).parent().parent().parent().find('.row_message').slideUp(200);
	  }
	  
	  if(jqte_test==''){
		  jqte_test='1';
		  $('.jqte-test').jqte();
	  }
	}
}

// for show / hide detail section on click on eye icon
function collapseaf(e,theId='',theStatus=''){
	$('tr').removeClass('actives1');
	$('tr').removeClass('actives2');
	
	// $(e).parent().parent().find('.statusa').html('555');
	
	var ids = $(e).attr('data-href');
	var ids2 = ids+"_v";
	if($(e).hasClass('active')){
		$('.collapseitem').removeClass('active');
		$('.collapsea').removeClass('active');
		$(e).parent().parent().removeClass('actives1');
		
		$('#'+ids).slideUp(200);
		$('#'+ids).parent().parent().removeClass('actives2');
		$('#'+ids2).slideUp(200);
		
	} else {
	  $('.collapseitem').removeClass('active');
	  $('.collapsea').removeClass('active');
	  //$('#'+ids).addClass('active');
	  $(e).addClass('active');
	  $(e).parent().parent().addClass('actives1');
	  
	if(theStatus==91){ 
		var thisurls="<?=$data['Admins']?>/message_ajax<?=$data['ex']?>";
			thisurls=thisurls+"?action=readNewEmail&id="+theId;
			//alert(thisurls);
		
		$.ajax({  
				 url:thisurls,  
				 type: "POST",
				 dataType: 'json', // text
				 data:{gid:theId, action:"readNewEmail"},  
				 success:function(data)  
				 {  
				 
					  $("#inbox_count").html(data['inbox_count']);
					  $("#inbox_count_process").html(data['inbox_process']);
					  $("#draft_count").html(data['draft_count']);
				 
					  if(data['Error']&&data['Error'] != ''){  
						   alert(data['Error']);
					  }else{
						  
						 // $(e).parent().parent().find('.statusa').html('555');
						  $(e).parent().parent().find('.statusa').html(data['status']);
						  $('#'+ids).parent().parent().find('.statusa_2').html(data['status']);
						  // alert(data['status']);
					  }
					   
					  $('#autoSave').text("Readable the message ");  
					  timeoutf('#autoSave'); 
				 }  
			});
	  }
	  
	  $('.collapseitem').slideUp(100);
	  $('#'+ids).slideDown(700);
	  $('#'+ids).parent().parent().addClass('actives2');
	  $('#'+ids2).slideDown(700);
	}
}
function closeMessage(e,theId='',theStatus=''){
	
	var thisurls="<?=$data['Admins']?>/message_ajax<?=$data['ex']?>";
			thisurls=thisurls+"?action=closeStatus&id="+theId;
			//alert(thisurls);
		
	$.ajax({  
		 url:thisurls,  
		 type: "POST",
		 dataType: 'json', // text
		 data:{gid:theId, action:"closeStatus"},  
		 success:function(data)  
		 {  
		 
		  $("#inbox_count").html(data['inbox_count']);
		  $("#inbox_count_process").html(data['inbox_process']);
		  $("#draft_count").html(data['draft_count']);
	 
		  if(data['Error']&&data['Error'] != ''){  
			   alert(data['Error']);
		  }else{
			 // $(e).parent().parent().find('.statusa').html('555');
			  $(e).parent().parent().find('.statusa').html(data['status']);
			  $(e).parent().parent().next().find('.statusa_2').html(data['status']);
			  $(e).parent().parent().next().find('.addmessageform').remove();
			  $(e).parent().parent().next().find('a.addmessagelink').remove();
			  $(e).parent().parent().find('.closeMessage').remove();
			  
			  // alert(data['status']);
		  }
		}
	});
			
}
var this_id='';
function start_common(){
	jqte_test=''; abc = 0;
	$('#step_id').val('1');
	clearAllInterval();
}
function sup_a(e){
	start_common();
	$('#tabs label').removeClass('active');
	$(e).addClass('active');
	
	
	 
	this_id=$(e).attr('id');
	this_id = this_id.replace(/tab/g, ""); 
	
	//alert(this_id);
	var thisurls="<?=$data['Admins']?>/message_ajax<?=$data['ex']?>";
	//alert(this_id+'\r\n'+thisurls);
	
	if(this_id=="5"){ //Home
		window.location.href="<?=$data['Admins']?>/index<?=$data['ex']?>";
		return false;
	}else if(this_id=="2"){
	  //alert('666');
	  
		newemailf();return false;
		
	}else{
		thisurls=thisurls+"?filter="+this_id;
	}
	wnf(thisurls);
	//alert(this_id); alert(thisurls);
	$.ajax({url: thisurls, success: function(result){
		$('.contentMsg').html(result);
		
		$('.sent_form_div').slideUp(200);
		$('.contentMsg').slideDown(700);
	
		//$('.jqte-test').jqte();
	}});
}
function status_msgf2(e='',theTab=0,statusId=0){
	this_id=theTab;
	setTimeout(function(){ 
		$('input[name="css-tabs"]').eq(theTab).prop("checked", true);
		$('#tabs label').removeClass('active');
		$('#tabs label').eq(theTab).addClass('active');
		if(theTab==1){
			$('.sent_form_div').slideDown(700);
			$('.contentMsg').slideUp(200);
		}else{
			$('.sent_form_div').slideUp(200);
			$('.contentMsg').slideDown(700);
		}
		
	  }, 100);
	  
	status_msgf('','',statusId);
	
}
function status_msgf(e,theNo='',eThis='',searchkey=''){
	//alert(theNo);
	var this_value='';
	
	if(eThis){
		this_value=eThis;
	}else if(theNo){
		this_value=theNo;
	}else{
		this_value=e.value;
	}
	 
	
	var thisurls="<?=$data['Admins']?>/message_ajax<?=$data['ex']?>";
		thisurls=thisurls+"?stf="+this_value+"&no="+this_id;
		//alert(thisurls);
	if(searchkey){
		thisurls=thisurls+"&searchkey="+searchkey;
	}
	
	//alert(thisurls);
	
	$.ajax({url: thisurls, success: function(result){
		$('.contentMsg').html(result);
	}});
}
function discardDraft(e,theId='',theType=''){
	if(theType){
		theId=$('#post_id').val();
	}
	var thisurls="<?=$data['Admins']?>/message_ajax<?=$data['ex']?>";
		thisurls=thisurls+"?action=removedraft&id="+theId;
		alert(thisurls);
	$.ajax({url: thisurls, success: function(result){
		$('.contentMsg').html(result);
		if(theType){
			$('#tabs label').eq(1).trigger("click");
		}
	}});
}
function editDraft(e,theId=''){
	var thisurls="<?=$data['Admins']?>/message_ajax<?=$data['ex']?>";
		thisurls=thisurls+"?action=editdraft&id="+theId;
		//alert(thisurls);
	
	$.ajax({  
			 url:thisurls,  
			 type: "POST",
			 dataType: 'json', // text
			 data:{gid:theId, action:"editdraft"},  
			 success:function(data)  
			 {  
				// alert("11=>"+data['newid']+'\r\nurls=>'+url_name);
				

				  if(data['Error']&&data['Error'] != ''){  
					   alert(data['Error']);
				  }else{
					  editDraftOpen(data);
				  }
				   
				  $('#autoSave').text("Edit save as draft");  
				  timeoutf('#autoSave'); 
			 }  
		}); 
		
}
function editDraftOpen(data){
	/*
	alert(data['post_id']);
	alert(data['message_type']);
	alert(data['subject']);
	alert(data['comments']);
	alert(data['ticketid']);
	*/
	
	newemailf(data['post_id'],data['message_type'],data['subject'],data['comments'],data['ticketid'],data['photograph_view'],data['multiple_merchant_ids'],data['message_type_other']);
	
}
var message_type_other_var="";
function message_typef(theValue){
	if(theValue==21){
		$('#message_type_other').val(message_type_other_var);
		$('#message_type_other').show(1500);
	}else{
		$('#message_type_other').hide(500);
		message_type_other_var=$('#message_type_other').val();
		$('#message_type_other').val('');
	}
}
function newemailf(post_id='',message_type='',subject='',comments='',message_id='',photograph_view='',multiple_merchant_ids='',message_type_other=''){
	/*
	alert(post_id);
	alert(message_type);
	alert(subject);
	alert(comments);
	alert(message_id);
	*/
	
	$("#multiple_files_id").trigger("reset");
	 document.getElementById("multiple_files_id").reset();
	 
	$('#multiple_files_id #post_id').val('');
	$('#multiple_files_id #message_id').val('');
	
	$('#multiple_files_id #publish_button').val('');
	$('#multiple_files_id .jqte_editor').html('');
	$('#multiple_files_id .file_div_upload').html('');
	$('#multiple_files_id .maindiv_view').html('');
	$('#multiple_files_id #multiple_merchant_ids').val([]).trigger("chosen:updated");
	//$('#multiple_files_id #multiple_merchant_ids').val(''); 
	
	$('#multiple_files_id .inputDivPar').addClass('unActive');

	
	
	$('#step_id').val('2');
	
	if(post_id !='' ){
		$('#multiple_files_id #post_id').val(post_id); 
	}
	if(subject !='' ){
		$('#multiple_files_id #subject_post').val(subject); 
	}
	if(comments !='' ){
		$('#multiple_files_id .jqte_editor').html(comments); 
	}
	if(message_id !='' ){
		$('#multiple_files_id #message_id').val(message_id); 
	}
	//alert(multiple_merchant_ids);
	if(multiple_merchant_ids !='' ){
		$("#multiple_files_id .chosen-select").val(multiple_merchant_ids).trigger("chosen:updated");
	}
	
	
	if(isNaN(message_type)){
		message_type_other_var=message_type_other;
		//$('#multiple_files_id #message_type_other').val(message_type_other);
		$('#message_type_post option[value="21"]').prop('selected','selected').trigger("change");
	}else{
		$('#multiple_files_id #message_type_other').hide();
		$('#message_type_post option[value="'+message_type+'"]').prop('selected','selected');
	}
	
	
	
	var nem='<div id="formdiv" style="float:left;"><label title="Upload Files" id="uploaddoc_img_text"  onclick="add_more_files(this,\'photograph_file\',\'1\')"  class="upload" ><i class="<?=$data['fwicon']['cloud-arrow'];?> fa-2x text-success"></i></label></div>';
	$('.contentMsg').slideUp(200);
	$('.sent_form_div').slideDown(700);
	$('#publish_button').show(1000);
		//$('.contentMsg').html(nem);
		
		$('.file_div_upload').html(nem);
		
		
		
		
		if(photograph_view !='' ){
			$('#multiple_files_id .maindiv_view').html(photograph_view);
			
			$('#multiple_files_id .inputDivPar').removeClass('unActive');
		}
		
		if(message_id !='' ){
		  $("#radio2").prop("checked", true);
		  $('#tabs label').removeClass('active');
		  $("#tabs #tab2").addClass('active');
		  $('#multiple_files_id .discardDraft').show(1000);
		}
		
		setIn1=setInterval(function(){   
           autoSave();   
      }, 10000);
	  
	
}


function open_msg_id(theId){
	//alert(theId);
	$('.collapsea[data-id="'+theId+'"]').eq(0).trigger("click");
	$('.collapsea[data-id="'+theId+'"]').eq(0).scrollTop() + 100;
}

function ajax_remove_files(e,thePostId='') {
	//alert('111');
	var removeFile=$(e).attr('data-file');
	//alert(removeFile);
	
	var theId=$('#post_id').val();
	
	if(thePostId){
		theId=thePostId;
	}
	
	var thisurls="<?=$data['Admins']?>/message_post_ajax<?=$data['ex']?>";
		thisurls=thisurls+"?action=removeFiles&id="+theId;
		//alert(thisurls);
	
	$.ajax({  
			 url:thisurls,  
			 type: "POST",
			 dataType: 'json', // text
			 data:{gid:theId, action:"removeFiles", fileName:removeFile},  
			 success:function(data)  
			 {  
				// alert("11=>"+data['newid']+'\r\nurls=>'+url_name);
				
				  if(data['Error']&&data['Error'] != ''){  
					   alert(data['Error']);
				  }else{
					  $(e).parent().hide();
					  //alert("file_s=>"+data['file_s']);
					  if(thePostId){
							
					  }else{
						  $('#autoSave').text("file Removed !!"); 
						  timeoutf('#autoSave');
					  }
				  }
				   
				 
			 }  
		}); 
		
	
	
}

function ajax_files(e) {
	// event.preventDefault();
	 
	var post_id=$('#post_id').val();
		
	var thisurls="<?=$data['Admins']?>/message_post_ajax<?=$data['ex']?>";
			thisurls=thisurls+"?action=filesUpload&id="+post_id;
			
	var form = $('#multiple_files_id')[0];

	// Create an FormData object 
	var data = new FormData(form);
	//data.append("action":"filesUpload");

	// If you want to add an extra field for the FormData
	//data.append("CustomField", "This is some extra data, testing");
	
	
   var subject = $('#subject_post').val(); 
   var comments = $('#comments_post').val();    
   var publish = $('#publish_button').val();   
  
   
   if(subject == '') {
		alert("Subject can not Blank! Please enter the Subject");
		//subject.focus();
		return false;
   }else if(comments == '') {
		alert("Message can not Blank! Please enter the Message");
		//comments.focus();
		return false;
   }else if(post_id == '') {
		alert("Please wait 8 seconds");
		//comments.focus();
		return false;
   }else {	   
		
		$.ajax({
			type: "POST",
			enctype: 'multipart/form-data',
			url: thisurls,
			data: data,
			processData: false,
			contentType: false,
			cache: false,
			//timeout: 600000,
			success: function (data) {
				//alert(data['fileName']);
				if(data['fileName'] !='' ){
					$(e).parent().find('#img').attr('data-file',data['fileName']);
				}
				//alert("get=>"+data['get']+'\r\fileName=>'+data['fileName']+'\r\pst=>'+data['pst']+'\r\gid=>'+data['gid']+'\r\action=>'+data['action']);
			   // $("#result").text(data);
				//console.log("SUCCESS : ", data);
				//$("#btnSubmit").prop("disabled", false);

			},
			error: function (e) {

				//$("#result").text(e.responseText);
				console.log("ERROR : ", e);
			   // $("#btnSubmit").prop("disabled", false);

			}
		});
   }
    
}
function ajax_files_valid(e) {
   var post_id = $('#post_id').val(); 
   var subject = $('#subject_post').val(); 
   var comments = $('#comments_post').val();    
   var publish = $('#publish_button').val();   
  
   
   if(subject == '') {
		alert("Subject can not Blank! Please enter the Subject");
		//subject.focus();
		return false;
   }else if(comments == '') {
		alert("Message can not Blank! Please enter the Message");
		//comments.focus();
		return false;
   }
   else if(post_id == '') {
		alert("Please wait 8 seconds");
		//comments.focus();
		return false;
   }
}



$(document).ready(function(){
	/*
    $('.echektran .collapsea').click(function(){
	   collapseaf(this);
    });
	*/
	$('#tabs label').click(function(){
		sup_a(this); 
    });
	
	/*var thisurls1="<?=$data['Admins']?>/message_ajax<?=$data['ex']?>?all=1";
	$.ajax({url: thisurls1, success: function(result){
		$('.contentMsg').html(result);
	}});
	*/
	<? if(isset($_GET['stf'])){ ?>
		
		<? if(isset($_GET['tab'])&&$_GET['tab']){ ?>
		 setTimeout(function(){ 
		    $('input[name="css-tabs"]').eq(<?=(int)$_GET['tab'];?>).prop("checked", true);
			$('#tabs label').removeClass('active');
			$('#tabs label').eq(<?=(int)$_GET['tab'];?>).addClass('active');
			
		  }, 100);
		
		<? }?>
		
		
		status_msgf('','',"<?=(int)$_GET['stf'];?>",'<?=stf(isset($_REQUEST['searchkey'])&&$_REQUEST['searchkey']?prntext($_REQUEST['searchkey']):'');?>');
		
	<? }else if(isset($_GET['tab'])&&$_GET['tab']){ ?>
		$('#tabs label').eq(<?=(int)$_GET['tab'];?>).trigger("click");
	<? }else if(isset($_SESSION['load_tab'])&&$_SESSION['load_tab']=='sent'){ ?>
		$('#tabs label').eq(2).trigger("click");
		
	<? }else if(isset($_SESSION['load_tab'])&&$_SESSION['load_tab']=='inbox'){ ?>
		$('#tabs label').eq(0).trigger("click");
	<? }else{ ?>
		$('#tabs label').eq(0).trigger("click");
	<? }?>
	
	$('.newemail').click(function(){
		$('#tabs label').eq(1).trigger("click");
    });
	
    
});







function viewdetails(e){
	if($(e).hasClass('active')){
		$('.viewdetaillink').removeClass('active');
		$('.viewdetaildiv').removeClass('active');
		
		$(e).parent().parent().parent().find('.viewdetaildiv').slideUp(200);
	} else {
	  $('.viewdetaillink').removeClass('active');
	  $('.viewdetaildiv').removeClass('active');
	  
	  $(e).parent().parent().parent().find('.viewdetaildiv').addClass('active');
	  $(e).addClass('active');
	  
	  $('.viewdetaildiv').slideUp(100);
	  $(e).parent().parent().parent().find('.viewdetaildiv').slideDown(700);
	}
}
</script>
  <link rel="stylesheet" type="text/css" href="<?=$data['Host']?>/js/jquery-te-1.4.0.css"/>
  <script src="<?=$data['Host']?>/js/jquery-te-1.4.0.min.js"></script>
  
  
 <div class="container mt-2 mb-2" > 
  
<? if((isset($data['Error'])&& $data['Error'])){ ?>
  <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error!</strong>
    <?=prntext($data['Error'])?>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <? }?>

  <? if((isset($data['sucess'])&& $data['sucess'])){ ?>
  <div class="alert alert-success alert-dismissible fade show" role="alert"> <strong>Success!</strong> Your request add support ticket
    <?=prntext($post['subject'])?>
    (
    <?=$post['ticketid']?>
    ).
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <? }?>
  
   <? if(isset($_SESSION['action_success'])&&$_SESSION['action_success']){ ?>
  

    <div class="alert alert-success alert-dismissible fade show"  style="height:250px;" role="alert">
       <strong>Success!</strong> <?=$_SESSION['action_success']?>
	  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
    </div>

  <? unset($_SESSION["action_success"]); 
  } ?>
  </div>
  <? if($post['step']==1){ ?>
  <div class="container my-1" > 
  
  <div class="container my-1 vkg px-0">
    <h4 class="my-3"><i class="<?=$data['fwicon']['support'];?>"></i> Support Messages <span id="textdisplat"></span></h4>
  </div>
  
  <span>
    <!--style="display:none"-->
    <input id="radio1" type="radio" name="css-tabs" checked>
    <input id="radio2" type="radio" name="css-tabs">
    <input id="radio3" type="radio" name="css-tabs">
    <input id="radio4" type="radio" name="css-tabs">
    <input id="radio5" type="radio" name="css-tabs">
    </span>
    <div id="tabs">
      <ul class="nav nav-tabs">
        <li class="nav-item">

<label id="tab1" for="radio1" class="nav-link p-0 ms-2"> 

<!-- //============================================-->		  
<button type="button" class="btn btn-primary btn-sm inbox-clk">
<i class="<?=$data['fwicon']['inbox-mail'];?>"></i> Inbox <span id="inbox_count" class="badge rounded-pill bg-danger"></span>
</button>
<span class="counts" id="inbox_count_process" title="Process" style="margin-top:20px; display:none"></span>		  
<!-- //============================================-->

</label>

</li>
        <li class="nav-item">
          <label id="tab2" for="radio2" class="nav-link p-0"> 
		  
<!-- //============================================-->		  
<button type="button" class="btn btn-primary btn-sm new-clk">
<i class="<?=$data['fwicon']['new-mail'];?>"></i> New &nbsp;&nbsp;&nbsp; <span class="badge rounded-pill bg-danger invisible ">0</span>
</button>
<!-- //============================================-->		  
		  
		  </label>
        </li>
        <li class="nav-item">
          <label id="tab3" for="radio3" class="nav-link p-0">
		  
<!-- //============================================-->
<button type="button" class="btn btn-primary btn-sm sent-clk">
<i class="<?=$data['fwicon']['sent-mail'];?>"></i> Sent <span id="sent_count" class="badge rounded-pill bg-danger"></span>
</button>
<!-- //============================================-->
		  
		   
		   
		   </label>
        <li class="nav-item">
          <label id="tab4" for="radio4" class="nav-link p-0">
		  
<!-- //============================================-->
<button type="button" class="btn btn-primary btn-sm draft-clk">
<i class="<?=$data['fwicon']['draft-mail'];?>"></i> Draft <span id="draft_count" class="badge rounded-pill bg-danger"></span>
</button>
 <!-- //============================================--> 
		   
		   
		   </label>
      </ul>
    </div>
    <div class="contentMsg" id="content"></div>
    <!--add new message-->
    <div class="sent_form_div">
      <form id="multiple_files_id" method="post" enctype="multipart/form-data">
        <div class="row-fluid pad2000 row33">
          <input type="hidden" name="post_id" value="" id="post_id">
          <input type="hidden" name="message_id" value="" id="message_id">
          <div class="col-sm-12 my-2">
            <select name="message_type" id="message_type_post" class="feed_input1 form-select" required=""  onchange="message_typef(this.value)">
              <option selected="selected" disabled="disabled">Message Type</option>
              <? foreach($data['MessageType'] as $key=>$value){ ?>
              <option value="<?=$key;?>">
              <?=$value;?>
              </option>
              <? } ?>
            </select>
            </select>
            <div class="col-sm-12 my-2">
              <input type="text" name="message_type_other" id="message_type_other" placeholder="Enter Message Type" class="form-control"  required />
            </div>
            <? if((isset($_SESSION['login_adm'])&&$_SESSION['login_adm'])||(isset($_SESSION['merchant_assign_in_subadmin'])&&$_SESSION['merchant_assign_in_subadmin'])){ ?>
            <? } ?>
            <div class="col-sm-12 my-2">
              <select id="multiple_merchant_ids" data-placeholder="Begin typing a name to filter for merchant" multiple class="chosen-select form-select" name="multiple_merchant_ids[]" >
                <?=showselect($_SESSION['clientsList'],'',1)?>
              </select>
              <script>
					$(".chosen-select").chosen({
					  no_results_text: "Oops, nothing found!"
					});
				</script>
            </div>
            <div class="col-sm-12 my-2">
              <input type="text" name="subject" id="subject_post" placeholder="Enter The Full Subject" class="form-control" required />
            </div>
            <div class="col-sm-12 my-2">
              <textarea class="form-control comments_post" name="comments" id="comments_post" required rows="5" placeholder="Enter a Message" ></textarea>
              <script>
			$('.comments_post').jqte();
		 </script>
            </div>
            <div class="row_botton row ">
              <div class="col-sm-8 p-0">
                <button type="button" id="publish_button" name="send" onclick="stopDraftInterval();" value=""   class="btn btn-primary my-2"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Submit</button>
                <a class="discardDraft my-2 btn btn-danger" onclick="discardDraft(this,'','1')" title="Discard Draft"><i class="<?=$data['fwicon']['delete'];?>"></i> Delete</a> </div>
              <div class="col-sm-4 p-0">
                <div class="inputDivPar multiple_files unActive">
                  <div class="inputDivs">
                    <div class="file_div_upload" id="maindiv"></div>
                    <div class="maindiv_view" id="maindiv"></div>
                  </div>
                </div>
              </div>
              <div class="col-sm-12 p-0 text-success">
                <div class="autoSave" id="autoSave"></div>
              </div>
            </div>
          </div>
        </div>
      </form>
    </div>
    </main>
  </div>

<? }elseif($post['step']==2){ ?>
<? if($post['gid']){ ?>
<input type="hidden" name="gid" value="<?=$post['gid']?>">
<? }?>
<div class="container mt-5" style="max-width:400px; margin:0 auto;">
  <div class="row">
    <div class="col-sm-4 border rounded">
      <div class="alert alert-dark" role="alert"><i class="<?=$data['fwicon']['setting'];?>"></i> Support Ticket</div>
      <div class="mb-3 row">
        <label for="staticEmail" class="col-sm-6 col-form-label">Subject :: </label>
        <div class="col-sm-12">
          <input type="text" class="form-control"  name="subject" placeholder="Enter The Full Subject"  value="<?=prntext($post[0]['subject'])?>" autocomplete="off" required/>
        </div>
      </div>
      <div class="mb-3 row">
        <label for="staticEmail" class="col-sm-6 col-form-label">Comments :: </label>
        <div class="col-sm-12">
          <textarea id="mustHaveId" class="form-control jqte-test" name="comments" rows="5" placeholder="Enter a Message" ><?=prntext($post[0]['comments'])?></textarea>
        </div>
      </div>
      <div class="mb-3 row">
        <div class="col-sm-12">
          <button class="btn btn-primary" id="btn-confirm" name="send" value="CONTINUE" type="submit" style="width:100%;">Send me the password</button>
        </div>
      </div>
      <div class="col text-center"> <i class="<?=$data['fwicon']['user-lock'];?>"></i> <a href="<?=$data['Host'];?>/login<?=$data['ex']?>" class="btn btn-link">Submit</a> </div>
      </form>
    </div>
  </div>
</div>
<? }?>

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
<script>
$("#multiple_merchant_ids_chosen").css("width", "100%");
$("#multiple_merchant_ids_chosen").addClass("form-control");
</script>

<script>
$(".inbox-clk").click(function(){ $("#textdisplat").html("<b> - Inbox</b>"); });
$(".new-clk").click(function(){ $("#textdisplat").html("<b> - New</b>"); });
$(".sent-clk").click(function(){ $("#textdisplat").html("<b> - Sent</b>"); });
$(".draft-clk").click(function(){ $("#textdisplat").html("<b> - Draft</b>"); });
</script>

</div>
<?

 }else{ ?>
SECURITY ALERT: Access Denied
<? }?>
