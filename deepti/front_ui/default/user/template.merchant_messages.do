<? if(isset($data['ScriptLoaded'])){ ?>
<link href="<?=$data['TEMPATH']?>/common/css/table-responsive_999.css" rel="stylesheet">
<link href="<?=$data['TEMPATH']?>/common/css/message.css" rel="stylesheet">
<input type="hidden" id="step_id" name="step" value="<?=$post['step']?>">
<style>
#wgtmsr option {
   width: 150 px;
}
#filediv{
float: right !important;
width: 80%  !important; 
}
.jqte { width: 100% !important; }
#file { width: 245px!important; }

#activecss .active {
-webkit-box-shadow: -3px -1px 3px 3px rgba(36,150,9,0.29)!important;
box-shadow: -3px -1px 3px 3px rgba(36,150,9,0.29)!important;
}
</style>
<script>

var jqte_test='';
var setIn1=''; var setIn2='';
function stopDraftInterval() {
	  $('#publish_button').val('publish');
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
  //var url_name="<?=$data['USER_FOLDER']?>/message_post_ajax<?=$data['ex']?>";
   var url_name="<?=$data['USER_FOLDER']?>/message_post_ajax<?=$data['ex']?>";
   if(subject != '' && comments != '')  
   {  
		$.ajax({  
			 url:url_name,  
			 type: "POST",
			 dataType: 'json', // text
			 data:{subject:subject, comments:comments, gid:post_id, message_type:message_type, publish:publish, action:"autoSave"},  
			 success:function(data)  
			 {  
				 //alert("11=>"+data['newid']+'\r\nurls=>'+url_name);
				 
				 $("#inbox_count").html(data['inbox_count']);
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
function collapseaf(e,theId='',theStatus=''){
	$('tr').removeClass('actives1');
	$('tr').removeClass('actives2');
	
	// $(e).parent().parent().find('.statusa').html('555');
	
	var ids = $(e).attr('data-href');
	if($(e).hasClass('active')){
		$('.collapseitem').removeClass('active');
		$('.collapsea').removeClass('active');
		$(e).parent().parent().removeClass('actives1');
		
		$('#'+ids).slideUp(200);
		$('#'+ids).parent().parent().removeClass('actives2');
	} else {
	  $('.collapseitem').removeClass('active');
	  $('.collapsea').removeClass('active');
	  //$('#'+ids).addClass('active');
	  $(e).addClass('active');
	  $(e).parent().parent().addClass('actives1');
	  
	if(theStatus==91){ 
		var thisurls="<?=$data['USER_FOLDER']?>/message_ajax<?=$data['ex']?>";
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
	}
}
function closeMessage(e,theId='',theStatus=''){
	
	var thisurls="<?=$data['USER_FOLDER']?>/message_ajax<?=$data['ex']?>";
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
	var thisurls="<?=$data['USER_FOLDER']?>/message_ajax<?=$data['ex']?>";
	if(this_id=="5"){ //Home
		top.window.location.href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>";
		return false;
	}else if(this_id=="2"){
		newemailf();return false;
	}else{
		thisurls=thisurls+"?filter="+this_id;
	}
	//alert(this_id); alert(thisurls);
	$.ajax({url: thisurls, success: function(result){
		$('.contentMsg').html(result);
		//$('.jqte-test').jqte();
	}});
}
function status_msgf(e,theNo){
	
	var this_value=e.value;
	 
	
	var thisurls="<?=$data['USER_FOLDER']?>/message_ajax<?=$data['ex']?>";
		thisurls=thisurls+"?stf="+this_value+"&no="+this_id;
	
	$.ajax({url: thisurls, success: function(result){
		$('.contentMsg').html(result);
	}});
}
function discardDraft(e,theId='',theType=''){
	if(theType){
		theId=$('#post_id').val();
	}
	var thisurls="<?=$data['USER_FOLDER']?>/message_ajax<?=$data['ex']?>";
		thisurls=thisurls+"?action=removedraft&id="+theId;
		//alert(thisurls);
	$.ajax({url: thisurls, success: function(result){
		$('.contentMsg').html(result);
		if(theType){
			$('#tabs label').eq(1).trigger("click");
		}
	}});
}
function editDraft(e,theId=''){
	var thisurls="<?=$data['USER_FOLDER']?>/message_ajax<?=$data['ex']?>";
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
	
	newemailf(data['post_id'],data['message_type'],data['subject'],data['comments'],data['ticketid'],data['photograph_view']);
	
}
function newemailf(post_id='',message_type='',subject='',comments='',message_id='',photograph_view=''){
	/*
	alert(post_id);
	alert(message_type);
	alert(subject);
	alert(comments);
	alert(message_id);
	*/
	
	
	
	$('#step_id').val('2');
	var nem='<form id="multiple_files_id" method="post" enctype="multipart/form-data"><div class="row-fluid"><input type="hidden" name="post_id" value="'+post_id+'" id="post_id"><input type="hidden" name="message_id" value="'+message_id+'" id="message_id"> <div class="span12"><select name="message_type" id="message_type_post" class="form-select my-2" id="wgtmsr" required="" ><option selected="selected" disabled="disabled">Message Type</option><option value="1">Payout</option><option value="2">Technical Support for Integration</option><option value="4">Transaction Issue</option><option value="5">Password Security/2MFA Issue</option><option value="6">Complaint/Feedback</option><option value="21">Others</option></select><div class="separator"></div><input type=text name="subject" id="subject_post" placeholder="Enter The Full Subject" class="form-control" value="'+subject+'"  required /><div class="separator"></div><textarea class="form-control jqte-test" name="comments" id="comments_post" required rows="5" placeholder="Enter a Message" >'+comments+'</textarea><div class="separator"></div><div class="row"><div class="row_botton col-sm-4"><button type="button" id="publish_button" name="send" onclick="stopDraftInterval();" value="" class="btn btn-primary"><i class="fas fa-check-circle"></i> Submit</button><a class="discardDraft btn btn-primary mx-2" onclick="discardDraft(this,\''+post_id+'\',\'1\')" title="Discard Draft"><i class="far fa-times-circle"></i> Discard Draft</a></div><div class="autoSave col-sm-2" id="autoSave"></div><div class="col-sm-6 inputDivPar multiple_files unActive float-start"><div class="inputDivs"><div id="maindiv"><div id="formdiv" style="float:left;"><label title="Upload Files" id="uploaddoc_img_text" class="addMore2" onclick="add_more_files(this,\'photograph_file\',\'1\')"  ><i class="fas fa-cloud-upload-alt fa-2x text-success"></i></label></div></div><div class="maindiv_view" id="maindiv"></div></div> </div></div></div></form>';
		$('.contentMsg').html(nem);
		$('.jqte-test').jqte();
		
		$('#message_type_post option[value="'+message_type+'"]').prop('selected','selected');
		
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
	//$('.collapsea[data-id="'+theId+'"]').eq(0).scrollTop() + 100;
}

function ajax_remove_files(e,thePostId='') {
	//alert('111');
	var removeFile=$(e).attr('data-file');
	//alert(removeFile);
	
	var theId=$('#post_id').val();
	
	if(thePostId){
		theId=thePostId;
	}
	
	var thisurls="<?=$data['USER_FOLDER']?>/message_post_ajax<?=$data['ex']?>";
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
		
	var thisurls="<?=$data['USER_FOLDER']?>/message_post_ajax<?=$data['ex']?>";
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
   }else if(post_id == '') {
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
	
	/*var thisurls1="<?=$data['USER_FOLDER']?>/message_ajax<?=$data['ex']?>?all=1";
	$.ajax({url: thisurls1, success: function(result){
		$('.contentMsg').html(result);
	}});
	*/
	

	
	<? if(isset($_SESSION['load_tab'])&&$_SESSION['load_tab']=='sent'){ ?>
		$('#tabs label').eq(2).trigger("click");
		
	<? }else if(isset($_SESSION['load_tab'])&&$_SESSION['load_tab']=='inbox'){ ?>
		$('#tabs label').eq(0).trigger("click");
	<?
	}else{ ?>
		$('#tabs label').eq(0).trigger("click");
	<? } ?>
	
	
	$('.newemail').click(function(){
		$('#tabs label').eq(1).trigger("click");
    });
	
    
});
</script>

<div class="border my-2 rounded" >
		
		


<? if(isset($data['Error'])&&$data['Error']){ ?>
<div class="mt-3" style="max-width:540px;">
<div class="alert alert-danger alert-dismissible fade show" role="alert">
  <strong>Error!</strong> <?=prntext($data['Error'])?>
  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
</div>
<? } ?>


<? if(isset($data['sucess'])&&$data['sucess']){ ?>
<div class="alert alert-success alert-dismissible fade show" role="alert">
  <strong>Success!</strong> Your request add support ticket <?=prntext($post['subject'])?> (<?=$post['ticketid']?>).
  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<? } ?>
		
<? if($post['step']==1){ ?>


<div class="my-2 vkg" >
<h4 class="my-2"><i class="far fa-envelope fa-fw"></i> <strong>Messages</strong> <span id="textdisplat"> <b> - Inbox</b></span></h4>
<span> <!--style="display:none"-->
	<input id="radio1" type="radio" name="css-tabs" checked>
	<input id="radio2" type="radio" name="css-tabs">
	<input id="radio3" type="radio" name="css-tabs">
	<input id="radio4" type="radio" name="css-tabs">
	<input id="radio5" type="radio" name="css-tabs">
</span>	
  <div id="tabs">	
  <ul id="activecss" class="nav nav-tabs mx-1">
	
  <li class="nav-item mx-1">
  <label id="tab1" for="radio1" class="nav-link-inbox">
  
<!-- //============================================-->
<button type="button" class="btn btn-primary btn-sm inbox-clk">
  <i class="fas fa-envelope-open"></i> Inbox <span id="inbox_count" class="badge rounded-pill bg-danger"></span>
</button>

 <!-- //============================================-->
  
  </label>
  </li>
  
  <li class="nav-item mx-1">
    <label id="tab2" for="radio2" class="nav-link-new"> 
	 <!-- //============================================-->
<button type="button" class="btn btn-primary btn-sm new-clk">
  <i class="fas fa-edit"></i> New 
</button>
 <!-- //============================================-->
	
	</label>
  </li>
  
  <li class="nav-item mx-1">
   <label id="tab3" for="radio3" class="nav-link-sent"> 
    <!-- //============================================-->
<button type="button" class="btn btn-primary btn-sm sent-clk">
  <i class="fas fa-mail-bulk"></i> Sent <span id="sent_count" class="badge rounded-pill bg-danger"></span>
</button>
 <!-- //============================================-->
   </label>
   </li>
  
  <li class="nav-item mx-1">
  <label id="tab4" for="radio4" class="nav-link-draft"> 
 <!-- //============================================-->
<button type="button" class="btn btn-primary btn-sm draft-clk">
  <i class="fas fa-envelope-open-text"></i> Draft <span id="draft_count" class="badge rounded-pill bg-danger"></span>
</button>
 <!-- //============================================-->
  </label>
  </li>
  
  
</ul>
</div>	
	<div class="contentMsg" id="content"></div>
			
	
	




<script>
//$('#tabs label').eq(0).trigger("click");

	
</script>



<? }elseif($post['step']==2){ ?>
<? if($post['gid']){ ?>
<input type="hidden" name="gid" value="<?=$post['gid']?>">
<? } ?>


<div class="mt-5" style="max-width:400px; margin:0 auto;">
  <div class="row">

    <div class="col-sm-4 border">
<div class="alert alert-dark" role="alert"><i class="fas fa-cog"></i> Support Ticket</div>



    <div class="mb-3 row">
	  <label for="staticEmail" class="col-sm-6 col-form-label">Subject :: </label>
      <div class="col-sm-12">
		<input type="text" class="form-control"  name="subject" placeholder="Enter The Full Subject"  value="<?=prntext($post[0]['subject'])?>" autocomplete="off" required/>
		
	
      </div>
    </div>
	
	<div class="mb-3 row">
	  <label for="staticEmail" class="col-sm-6 col-form-label">Comments :: </label>
      <div class="col-sm-12">
		<textarea id="mustHaveId" class="form-control jqte-test" name="comments" rows="20" placeholder="Enter a Message" ><?=prntext($post[0]['comments'])?></textarea>
      </div>
    </div>
    
    <div class="mb-3 row">
      <div class="col-sm-12">
        <button class="btn btn-primary" id="btn-confirm" name="send" value="CONTINUE" type="submit" style="width:100%;">Send Me The Password</button>
      </div>
    </div>
	
	<div class="col text-center">
<i class="fas fa-user-lock"></i> <a href="<?=$data['Host'];?>/login<?=$data['ex']?>" class="btn btn-link">Submit</a>
	
	</div>
	

	</form>
    </div>

  </div>
</div>



						

<? } ?>

<link rel="stylesheet" type="text/css" href="<?=$data['Host']?>/js/jquery-te-1.4.0.css"/>
<script src="<?=$data['Host']?>/js/jquery-te-1.4.0.min.js"></script>




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
$(".inbox-clk").click(function(){ $("#textdisplat").html("<b> - Inbox</b>"); });
$(".new-clk").click(function(){ $("#textdisplat").html("<b> - New</b>"); });
$(".sent-clk").click(function(){ $("#textdisplat").html("<b> - Sent</b>"); });
$(".draft-clk").click(function(){ $("#textdisplat").html("<b> - Draft</b>"); });
</script>
</div>   

</div>
<? }else{ ?>SECURITY ALERT: Access Denied<? } ?> 


                             