var jlog=[];
function load_popup_jsonf(url,jsonValue="",jsonType="",myModalId="#myModal9"){
	if ((typeof jQuery !== 'undefined') && (url)) {
		$(myModalId).modal('show').find('.modal-body').load(url,{"json":jsonValue,"jsonType":jsonType});
		$(myModalId+' .modal-dialog').css({"max-width":"80%"});
	}
}
//copytext_f(this,'Pay URL');
//copytext_f(this,'Pay URL','data-value');
//copytext_f(this,'Pay URL','data-href','0');
function copytext_f(e,theLabel='',theAttr='data-value',prnt='1') {
	//alert($(e).attr('data-value')+"\n\nffff. ");
	
	var textField = document.createElement('textarea');
    textField.innerText = $(e).attr(theAttr);
    document.body.appendChild(textField);
    textField.select();
    textField.focus(); //SET FOCUS on the TEXTFIELD
    document.execCommand('copy');
    textField.remove();
	
	if(theLabel){
		theLabel=' - '+theLabel;
	}
	
	if(prnt=='1'){
		alert($(e).attr(theAttr)+"\n\nCopied. "+theLabel);
	}else{
		alert("Copied. "+theLabel);
	}
}
function ctc_f(e,theLabel='',theAttr='data-value',prnt='0') {
	
	copytext_f(e,theLabel,theAttr,prnt);
	
	/*
	textVar=$(e).attr(theAttr);
	if(theLabel){
		theLabel=' - '+theLabel;
	}
	var $txt = $('<textarea />');
	$txt.val(textVar)
		.css({ width: "1px", height: "1px" })
		.appendTo('body');
	$txt.select();
	if (document.execCommand('copy')) 
	{
		$txt.remove();
		alert(textVar+"\n\nCopied. "+theLabel);
	}
	
	*/
}
function ctcf(theText, theAttr = '', prnt='', theLabel='') {
	if(theAttr){
		textVar=$(theText).attr(theAttr);
	}
	else{
		textVar=$(theText).text();
	}
	if(theLabel){
		theLabel=' - '+theLabel;
	}
	var $txt = $('<textarea />');
	$txt.val(textVar)
		.css({ width: "1px", height: "1px" })
		.appendTo('body');
	$txt.select();
	if (document.execCommand('copy')) {
		$txt.remove();
		if(prnt){
			alert(textVar+"\n\nCopied. "+theLabel);
		}else{
			alert("Copied. "+theLabel);
		}
	}
}

function stringify_f(theValue){
	var theVal='';
	if (typeof theValue == 'object') { 
		theVal=JSON.stringify(theValue);
	}else{
		theVal=(theValue);
	}
	
	return theVal;
}
function nw(theUrl){
	window.open(theUrl, 'newDocument');return false;
}
function readonlyf(e,theInput){
	if(theInput){
		if($(e).hasClass('active')){
			$(theInput).removeAttr('readonly');
			$(e).removeClass("active");
			$(e).html("Read Only");
		}else{
			$(theInput).attr('readonly','readonly');
			$(e).addClass("active");
			$(e).html("Edit");
		}
	 } 
}
function showVarf(showcVar){
	if(showcVar){
		var showcVar_arr = showcVar.split(' ');
		for(var i = 0; i < showcVar_arr.length; i++)
		{
			if(showcVar_arr[i]){
				$('.'+showcVar_arr[i]+'').show(1000);
				$('.'+showcVar_arr[i]+'').addClass("active");
			}
		}
	 } 
}

function hideVarf(hidecVar){
	if(hidecVar){
		var hidecVar_arr = hidecVar.split(' ');
		for(var i = 0; i < hidecVar_arr.length; i++)
		{
			if(hidecVar_arr[i]){
				$('.'+hidecVar_arr[i]+'').hide(200);
				$('.'+hidecVar_arr[i]+'').removeClass("active");
			}
		}
	 }
}

	

function viewAll(e,theId,theClass1=false,theClass2=false) {
	if($(e).hasClass('active')){
		$(e+' '+theId).slideUp(200);
		$(e).removeClass('active');
		if(theClass1){
		$(theClass1).removeClass('active');
		}
		if(theClass2){
			$(theClass2).removeClass('active');
		}
		$(e).html(' + EXPAND');
	}else{
		$(e+' '+theId).slideDown(500);
		$(e).addClass('active');
		if(theClass1){
			$(theClass1).addClass('active');
		}
		if(theClass2){
			$(theClass2).addClass('active');
		}
		$(e).html(' - COLLAPSE');
	}
	
}
function accordion_next() {
	$('.a_toggle').click(function(e) {
		e.preventDefault();
		$('.a_toggle').removeClass('activesh'); 
		let $this = $(this);
		if ($this.next().hasClass('show')) {
			$this.next().removeClass('show');
			$this.removeClass('activesh');
			$this.next().slideUp(350);
		} else {
			$this.parent().parent().find('.inner').removeClass('show');
			$this.parent().parent().find('.inner').slideUp(350);
			$this.next().toggleClass('show');
			
			$this.next().slideToggle(350);
			$this.addClass('activesh');
		} 
	});
}
//active_f('#collapsible8 a','activeTab','#collapsible8_html');
function active_f(onEvent='a',active='active',slide='',dActive='dActive') {
	if(onEvent){
		$(onEvent).click(function(e){
			let $this = $(this);
			if(active){
				$(onEvent).removeClass(active); 
				$this.addClass(active);
			}
			if(dActive){
				$(onEvent).addClass(dActive); 
				$this.removeClass(dActive);
			} 
			if(slide){
				$(slide).slideDown(200);
			}
		});
	}
}
function slide_next1(e,theId,parentNo) {
	//alert('theId: '+theId+'\r\parentNo: '+parentNo);
	$('.aq_div1').removeClass('active');
		if($(e).hasClass('active')){
				if(parentNo=="0"){
				$(e).find(theId).slideUp(200);
			} else if(parentNo=="1"){
				$(e).parent().find(theId).slideUp(200);
			} else if(parentNo=="2"){
				
				$(e).parent().parent().find(theId).slideUp(200);
				
			} else if(parentNo=="3"){
				$(e).parent().parent().parent().find(theId).slideUp(200);
			} else if(parentNo=="4"){
				$(e).parent().parent().parent().parent().find(theId).slideUp(200);
			} else if(parentNo=="5"){
				$(e).parent().parent().parent().parent().parent().find(theId).slideUp(200);
			} else if(parentNo=="6"){
				$(e).parent().parent().parent().parent().parent().parent().find(theId).slideUp(200);
			} else if(parentNo=="7"){
				$(e).parent().parent().parent().parent().parent().parent().parent().find(theId).slideUp(200);
			} else if(parentNo=="8"){
				$(e).parent().parent().parent().parent().parent().parent().parent().parent().find(theId).slideUp(200);
			} else if(parentNo=="9"){
				$(e).parent().parent().parent().parent().parent().parent().parent().parent().parent().find(theId).slideUp(200);
			} else if(parentNo=="10"){
				$(e).parent().parent().parent().parent().parent().parent().parent().parent().parent().parent().find(theId).slideUp(200);
			}
			$(e).removeClass('active');
	}else{
		if(parentNo=="0"){
			$(e).find(theId).slideDown(500);
		} else if(parentNo=="1"){
			$(e).parent().find(theId).slideDown(500);
		} else if(parentNo=="2"){
			$(e).parent().parent().find(theId).slideDown(500);
			$(e).parent().parent().parent().find('.aq_div1').addClass('active');
		} else if(parentNo=="3"){
			$(e).parent().parent().parent().find(theId).slideDown(500);
		} else if(parentNo=="4"){
			$(e).parent().parent().parent().parent().find(theId).slideDown(500);
			} else if(parentNo=="5"){
			$(e).parent().parent().parent().parent().parent().find(theId).slideDown(500);
			$(e).parent().parent().parent().parent().parent().parent().find('.aq_div1').addClass('active');
		} else if(parentNo=="6"){
			$(e).parent().parent().parent().parent().parent().parent().find(theId).slideDown(500);
		} else if(parentNo=="7"){
			$(e).parent().parent().parent().parent().parent().parent().parent().find(theId).slideDown(500);
		} else if(parentNo=="8"){
			$(e).parent().parent().parent().parent().parent().parent().parent().parent().find(theId).slideDown(500);
		} else if(parentNo=="9"){
			$(e).parent().parent().parent().parent().parent().parent().parent().parent().parent().find(theId).slideDown(500);
		} else if(parentNo=="10"){
			$(e).parent().parent().parent().parent().parent().parent().parent().parent().parent().parent().find(theId).slideDown(500);
		}
		$(e).addClass('active');
		
	}
	
}
function view_next3(e,theId=false,prev=false,label='') {
	if($(e).hasClass('active')){
			if(prev){
				$(e).prev().slideUp(200);
			}else{
				$(e).next().slideUp(200);
			}
			$(e).removeClass('active');
			if(label){
				$(e).html('Expand');
			}
	}else{
		if(prev){
			$(e).prev().slideDown(500);
		}else{
			$(e).next().slideDown(500);
		}
		$(e).addClass('active');
		if(label){
			$(e).html('Collapse');
		}
	}
	
}
function rActive(e,parentClass='',theIdClass='',active='') {
	if(parentClass){
		$(parentClass+' .active').removeClass('active');
	}
	if(theIdClass){
		$(theIdClass).slideUp(50);
	}
	if(active){
		$(e).addClass(active);
	}
}
function vnext(e,theId,parentClass='',theIdClass='') {
	if(parentClass){
		$(parentClass+' .active').removeClass('active');
	}
	if(theIdClass){
		$(theIdClass).slideUp(50);
	}
	if($(e).hasClass('active')){
		$(theId).slideUp(200);
		$(e).removeClass('active');
	}else{
		$(theId).slideDown(500);
		$(e).addClass('active');
	}
}
function textAreaAdjustf(theClass='') {
	$('textarea'+theClass).on('keyup keypress', function() {
		$(this).height(0);
		$(this).height(this.scrollHeight);
	});
	$('textarea'+theClass).trigger("keyup");
	//$('textarea').height(0);$('textarea').height(this.scrollHeight);$('textarea').trigger("keyup");
}
function view_tr_next3(e,theId=false) {
	if($(e).hasClass('active')){
			 var dataStylec= $(e).attr('data-stylec');
			 var dataCh= $(e).attr('data-ch');
			 if(dataCh !== undefined){
				//alert(dataCh);
				$('.modal_msg_body').animate({height:dataCh,'position':'absolute'}, 500); 
			 }
			 else if(dataStylec !== undefined){
				$('.modal_msg_body').attr('style',dataStylec); 
			 }
			$(e).parent().parent().find(theId).slideUp(200);
			$(e).removeClass('active');
	}else{
		
		var dataStylep= $(e).attr('data-stylep');
		var dataPh= $(e).attr('data-ph');
		 if(dataPh !== undefined){
			dataPh = dataPh.replace(/"/gi, '');
			//alert(dataPh);
			$('.modal_msg_body').animate({height:dataPh,'position':'absolute'}, 500); 
		 }
		 else if(dataStylep !== undefined){
			$('.modal_msg_body').attr('style',dataStylep); 
		 }
		$(e).parent().parent().find(theId).slideDown(500);
		$(e).addClass('active');
	}
	
}

function callback_send(e) {
	var mcb_notify_url=$(e).parent().parent().find('#mcb_notify_url').val();
	var mcb_redirect_url=$(e).parent().parent().find('#mcb_redirect_url').val();
	var mcb_body=$(e).parent().parent().find('#mcb_body').val();
	
	
	var urls = hostPath + "/direct_callback.do?mcb_body="+mcb_body+"&mcb_redirect_url="+mcb_redirect_url+"&mcb_notify_url="+mcb_notify_url;
	window.open(urls, '_blank');
	
}

function validateEmail(email) {
	var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,8})+$/; 
	return regex.test(email);
	}
//alert('1111111');
function email_trumail_io(theEmail){
 var deliverable="Invalid";
 //alert(theEmail);
	$.ajax({
		url: "https://trumail.io/json/"+theEmail,
		type: "GET",
		dataType: 'json', 
		cache: false,
		crossDomain: true,
		headers: {"Content-Type":"text/plain; charset=utf-8", "Accept": "*", "Accept-Language":"es-ES,es;q=0.8"},	
		accepts: "application/json",
		contentType: "application/json",	
		success: function(results){
			//alert("address: "+results["address"]+", username: "+results["username"]+", deliverable: "+results["deliverable"]);
			if(results["deliverable"]==true||results["deliverable"]=="true"){
				var deliverable="Valid";
				alert(deliverable);
				//alert(deliverable+"\r\n"+results["deliverable"]);
				//return deliverable;
			}
		}
	});
	
	//return deliverable;
}
function email_validatef(e,firstname=false,lastname=false,status_value=false){	

	var emailVald=validateEmail($(e).val());
	//var urls=hostPath+"/email_validate.htm?email="+$(e).val();
	var urls=hostPath+"/include/email_validate3.do?ftype=zerobounce&email="+$(e).val();//email_validate.htm 	email_validate3.htm
	//var urls="https://api.zerobounce.net/services.asmx/validate?apikey=b09aef1541244c33935c306e8c002858&email="+$(e).val();
	
	var emailGet=$(e).val();
	$(e).removeClass("Valid Invalid Catch-all Unknown Spamtrap Abuse DoNotMail");
	//status - [Valid |Invalid |Catch-all |Unknown |Spamtrap |Abuse |DoNotMail]
	if(emailVald){ 
		if($(e).hasClass('Valid')){
			
		}else{
			//window.open(urls,'');
			$.ajax({
				url: urls,
				type: "POST",
				dataType: 'json', // json jsonp
				data: 'action=eamivald&email='+emailVald,
				//crossDomain : true,
				//xhrFields: {withCredentials: true},
				success: function(results){
					//$('.all_amt .rs_total_amt').text(results.trim());
					//alert("success results: "+results+", firstname: "+results["firstname"]+", lastname: "+results["lastname"]+", status: "+results["status"]+", gender: "+results["gender"]);
					//results["status"]=null;
					$(e).addClass(results["status"]);
					if(firstname){$(firstname).val(results["firstname"]);}
					if(lastname){$(lastname).val(results["lastname"]);}
					if(status_value){$(status_value).val(results["status"]);}
					if(results["status"]=="Valid"){
						$(e).removeClass("Invalid");
					}
				}
			});
		}
	}
}
function dashboarAjaxLoad_Div(id) {
	
	//alert(id+" \r\nfindLoad_Div:"+document.getElementById(id+"_frame").contentWindow.location.pathname);
	var thisfindLoad_Divs=eval("modal_popup1_frame.document.body.innerHTML");
	var s404=thisfindLoad_Divs.match(/HTTP Status 404/g) || thisfindLoad_Divs.match(/Please Try Again./g) || thisfindLoad_Divs.match(/Error 404/g) || thisfindLoad_Divs.match(/Object not found!/g);
	if(s404!=null){
		document.getElementById(id).innerHTML = '<div class="containerf"><h1> ...</h1></div>';
	}
	else{
		//alert(thisfindLoad_Divs);
		if(id){$(id).html(thisfindLoad_Divs);}
	}
 }
function ajaxf(urlPath,theId){
	//alert(window.location.hash.substr(1));
	if(urlPath!="about:blank" && urlPath!="blank" && urlPath!="/blank"){
		
	}

	if(urlPath!="about:blank" && urlPath!="blank" && urlPath!="/blank"){
		var frmBody='<img class="loading_img" src="'+hostPath+'/images/icons/ajax-loader.gif" style=" display:block;margin:0 auto;" /><iframe name="modal_popup1_frame" id="modal_popup1_frame" onload="dashboarAjaxLoad_Div(\''+theId+'\')" src="'+urlPath+'" style="display:none; width: 2px; height: 2px;" width="0" height="0" frameborder="0" scrolling="no" marginwidth="0" marginheight="0" security="none"></iframe>';
		if(theId){$(theId).html(frmBody);}
	}
}
var ajaxf2_id="";
function dashboarAjaxLoad_Div3(theHref=false,theAppend=false) {
	//alert(id+" \r\nfindLoad_Div:"+document.getElementById(id+"_frame").contentWindow.location.pathname);
	var thisfindLoad_Divs2=eval("modal_popup3_frame.document.body.innerHTML");
	var s404=thisfindLoad_Divs2.match(/HTTP Status 404/g) || thisfindLoad_Divs2.match(/Please Try Again./g) || thisfindLoad_Divs2.match(/Error 404/g) || thisfindLoad_Divs2.match(/Object not found!/g);
	if(s404!=null){
		if(ajaxf2_id){ajaxf2_id.html('<div class="containerf"><h1> ...</h1></div>');}
	}
	else{
		//alert(thisfindLoad_Divs2+',ajaxf2_id=>'+ajaxf2_id);
		if(theAppend){
			ajaxf2_id.append(thisfindLoad_Divs2);
			ajaxf2_id.find('.loading_img').remove();
			ajaxf2_id.find('#modal_popup2_frame').remove();
			modal_popup3_framehide();
		}else{
			if(ajaxf2_id){
				ajaxf2_id.html(thisfindLoad_Divs2);
				modal_popup3_framehide();
			}
		}
		
	}
 }
function dashboarAjaxLoad_Div2(theHref=false,theAppend=false) {
	//alert(id+" \r\nfindLoad_Div:"+document.getElementById(id+"_frame").contentWindow.location.pathname);
	var thisfindLoad_Divs2=eval("modal_popup2_frame.document.body.innerHTML");
	var s404=thisfindLoad_Divs2.match(/HTTP Status 404/g) || thisfindLoad_Divs2.match(/Please Try Again./g) || thisfindLoad_Divs2.match(/Error 404/g) || thisfindLoad_Divs2.match(/Object not found!/g);
	if(s404!=null){
		if(ajaxf2_id){ajaxf2_id.html('<div class="containerf"><h1> ...</h1></div>');}
	}
	else{
		//alert(thisfindLoad_Divs2);
		if(theAppend){
			ajaxf2_id.append(thisfindLoad_Divs2);
			ajaxf2_id.find('.loading_img').remove();
			ajaxf2_id.find('#modal_popup2_frame').remove();
		}else{
			ajaxf2_id.html(thisfindLoad_Divs2);
		}
		
	}
 }
function ajaxf2(urlPath,theId,theAppend=false){
	ajaxf2_id=theId;
	//alert(urlPath+"\r\n"+theId+"\r\n"+theAppend);
	if(urlPath!="about:blank" && urlPath!="blank" && urlPath!="/blank"){
		var frmBody='<img class="loading_img" src="'+hostPath+'/images/icons/ajax-loader.gif" style=" display:block;margin:0 auto;" /><iframe name="modal_popup2_frame" id="modal_popup2_frame" onload="dashboarAjaxLoad_Div2(this.contentWindow.location.href,'+theAppend+')" src="'+urlPath+'" style="display:none; width: 2px; height: 2px;" width="0" height="0" frameborder="0" scrolling="no" marginwidth="0" marginheight="0" security="none"></iframe>';
		//window.document.getElementById(theId).innerHTML=frmBody;
		
		if(theId){
			if(theAppend){
				theId.append(frmBody);
			}else{
				theId.html(frmBody);
				//$(theId).html(frmBody);
			}
		}
	}
}
function ip_viewf2(e,theUrl){
	var placeurl=$(e).parent().parent().find('.rmk_msg');
	//alert(theUrl+"\r\n"+placeurl+"\r\n"+placeurl.html());
	if($(e).hasClass('active')){
	}else{
		$(e).addClass('active');
		ajaxf2(theUrl,placeurl,1);
	}
}
function ip_viewf1(e,theUrl){
	var placeurl=$(e).parent().parent().find('.rmk_msg');
	//alert(theUrl+"\r\n"+placeurl+"\r\n"+placeurl.html());
	if($(e).hasClass('active')){
	}else{
		$(e).addClass('active');
		placeurl.append('<img class="loading_img" src="'+hostPath+'/images/icons/ajax-loader.gif" style=" display:block;margin:5px auto 15px auto;height:25px;" />');
		$.ajax({url: theUrl,success: function(result){
			placeurl.append(result);
			placeurl.find('.loading_img').remove();
			placeurl.find('#modal_popup2_frame').remove();
		}});
	}
}
function loading_imgf(theIds){
	if(theIds){
	theIds.html('<img class="loading_img" src="'+hostPath+'/images/icons/ajax-loader.gif" style=" display:block;margin:5px auto 15px auto;height:25px;" />');
	}
}
function loading_url(theUrl,theIds){
	loading_imgf(theIds);
	if(theIds){
		$.ajax({url: theUrl,success: function(result){theIds.html(result);}});
	}
}

function ajaxf1(e,theUrl,theIds,active=true,pop='0'){
	
	if(theIds&&theUrl){
		if($(e).hasClass('active_ajx')){
			
		} else {
		  $(e).addClass('active_ajx');
		  if(pop=='1'){popuploadig();}
		  else if(pop=='2'){loading_imgf($(theIds));}
		  $.ajax({url: theUrl,success: function(result){
			  if(pop=='3'){
				  $(e).html(result);
			  }else{
			  $(theIds).html(result);}
			   if(pop=='1'){popupclose();}
			  //$(theIds).slideDown(1200);
		   }});
		}
	}
	if(active){
		if($(e).hasClass('active')){
			$(e).removeClass('active');
			$(theIds).slideUp(300);
			$(theIds).parent().removeClass('active');			
		} else {
		  $(e).addClass('active');
		  $(theIds).slideDown(800);
		  $(theIds).parent().addClass('active');
		}
	}
}
function modal_popup3_frameshw(){ 
	$('.modal_popup3_frame_img_div').show();
}
function modal_popup3_framehide(){
	$('.modal_popup3_frame_img_div').hide();
}
function datahref(theUrl){
	modal_popup3_frameshw();
	ajaxf2_id=$("#ajx_body");
	$.ajax({url: theUrl+"&ajaxf=1",success: function(result){if($("#ajx_body")){$("#ajx_body").html(result);}}});
	//modal_popup3_frame.window.location.href=theUrl+"&ajaxf=1";
	//ajaxf2(theUrl+"&ajaxf=1",ajaxf2_id);
	//$('.adm_tr_3').remove();
}
function data_href(e){
	var data_hrefs = $(e).attr('data-href');
	if(data_hrefs !== undefined){
		datahref(data_hrefs);
	}
}
var wn='';
function wnf(theUrl){
	if(wn){
		window.open(theUrl+'&pq=1', '_blank');popupclose();return false;
	}
}


var vp='';
//display modal form
function hrefmodal(theUrl,data_tid,eThis=''){	
	
	wnf(theUrl);
	
	if(eThis){
		$('#content').find('tr').removeClass('listActive1');
		$(eThis).parent().parent().addClass('listActive1');
	}
	
	$('#modalpopup_form_popup').show();
	$.ajax({url: theUrl,success: function(result){
		 vp=topInViewport(eThis);
		 
		 
		 /*
		//alert(vp);
		$("#modalpopup_cdiv").html(result);
		$('#modalpopup_form_popup').hide();
		$('#modalpopup').show(300);
		*/
		$('#modalpopup_form_popup').hide();
		
		$('#myModal .modal-dialog').css({"max-width":"500px"});
		$('#myModal .modal-title').html(data_tid);
		
		$('#myModal .modal-body').html(result);
		
		$('#myModal').modal('show');
		
		
	}});
	
}

function document_typef(e,theValue){
	$(e).parent().parent().find('#document_no').removeAttr('placeHolder');
	$(e).parent().parent().find('#document_no').attr('placeHolder','Enter '+theValue+' No.');
	$(e).parent().parent().find('#updatelogo_labelId').html('Upload '+theValue);
}
function addremarks(e){
	if($(e).hasClass('active')){
		$('.addremarklink').removeClass('active');
		$('.addremarkform').removeClass('active');
		
		//Code By Mukul to manage height and top Dynamically
		var Bh=$('#modalpopup_body').height();
		var Ah=Bh-100+'px';
		//$(".modalpopup_body").animate({ top:'40%', height:Ah}, 500);
		$(".modalpopup_body").animate({ height:Ah}, 500);
		
		$(e).parent().parent().parent().find('.addremarkform').slideUp(200);
	} else {
	  $('.addremarklink').removeClass('active');
	  $('.addremarkform').removeClass('active');
	  
	  $(e).parent().parent().parent().find('.addremarkform').addClass('active');
	  $(e).addClass('active');
	  
	  $('.addremarkform').slideUp(100);
	  
	  
	  var Bh=$('#modalpopup_body').height();
	  var Ah=Bh+100+'px';
	 
	  //$(".modalpopup_body").animate({ top:'35%', height:Ah}, 500);
	  $(".modalpopup_body").animate({ height:Ah}, 100);
	  
	  $(e).parent().parent().parent().find('.addremarkform').slideDown(700);
	}
}
function iframe_openf(e){
		var subqry=$.trim($(e).text());
		var mid = $(e).attr('data-mid');
		if(mid !== undefined){subqry=$.trim(mid);}
		$('.mprofile').removeClass('mactive');
		$(e).addClass('mactive');
		var urls_load="1";
		var urls=$(e).attr('data-ihref')+"&bid="+subqry;
		if($(e).hasClass('nomid')){urls=$(e).attr('data-ihref'); }
		$("#modal_popup_iframe_div").html("<div class='loading'>Now loading url is : "+urls+".<br/><br/><img class='loading_img' src='"+hostPath+"/images/icons/ajax-loader.gif'> <div class='waitxt plea1'>Please wait...</div></div>");
		//alert(urls); return false;
	

		
		var data_confirm = $(e).attr('data-confirm');
		var data_prompt = $(e).attr('data-prompt');
		if(data_prompt !== undefined){
			urls_load="0";
			var promptmsg_frm = prompt("Are you Sure to "+data_prompt+"!", "");
			if(promptmsg_frm == null || promptmsg_frm == ""){
				urls_load="0";
				return false;
			}else{
				urls = urls+"&promptmsg="+promptmsg_frm;
				
				if (confirm('Are you Sure to OK : '+promptmsg_frm)) {
					urls_load="1"; // ok
				} else {
					urls_load="0"; // cancel
				}
			}
		}
		else if(data_confirm !== undefined){
			urls_load="0";
			if (confirm('Are you Sure to OK : '+data_confirm)) {
				urls_load="1"; // ok
			} else {
				urls_load="0"; // cancel
			}
		}
		else{
			urls_load="1";
		}
		
		
		
		
		if(urls_load=="1"){
			//alert(urls);
			var mprofiledata='<iframe name="openframe" id="openframe" src="'+urls+'" width="100%" height="485px" scrolling="auto" frameborder="0" marginwidth="0" marginheight="0" style="width:100%!important;height:478px!important;display:block;margin:20px auto;" ></iframe>';
			//alert(mprofiledata); 
			$("#modal_popup_iframe_div").html(mprofiledata);
			
			$('#modal_popup_popup').slideDown(900);
		}
		
		
		
		//$.ajax({url:urls, success: function(result){  $("#modal_popup_iframe_div").html(mprofiledata);  }});
		
		
}



function topInViewport(element) {
	//return $(element).offset().top >= $(window).scrollTop() && $(element).offset().top          <= $(window).scrollTop() + $(window).height();
	
	return $(element).offset().top >= $(window).scrollTop() && $(element).offset().top; 
}
 
function autoheightPopUp(e){
	
	//var Ah=(screen.height-150)+'px';
	$(e).removeAttr('style');
	
	var Bh=$('#modalpopup_cdiv').height();
	var Ah=Bh+60+'px';
	var mt='-'+(parseFloat(Ah)/2)+'px!important';
	
	var element =$('#modalpopup_cdiv');
	var autoTop ='-'+topInViewport('#modalpopup_cdiv')+'px'; 
	//alert(autoTop);
	$(e).animate({height:Ah,marginTop:autoTop,position:'absolute'}, 500);
}


function activeHerf(){
	var filename_a = window.location.href;
	//alert(filename_a);
	$('a[href="' + filename_a + '"]').parent().addClass('active_ap');
	$('a[href="' + filename_a + '"]').addClass('active_a');
	$('a[href="' + filename_a + '"]').parent().prev().addClass('activesh');
}


$(document).ready(function(){
	/*
	openFullscreen();
	$(document).fullScreen(true);
	setTimeout( function(){ $(document).fullScreen(true); }, 1000 );
	*/
	
	$('input,textarea').focusout(function(){
		if($(this).hasClass('nst')||$(this).hasClass('jqte-test')){
			
		}else{
			var input = $(this).val();
			str = input.replace(/(<([^>]+)>)/ig,'');
			//alert(str);
			$(this).val(str);
		}
	});
	
	$('.jqte-test').focusout(function(){
		if($(this).hasClass('nst')){
			
		}else{
			var input = $(this).val();
			str = input.replace("<script>","");
			str = str.replace("<\/script>","");
			$(this).val(str);
		}
	});
	
	$('form').attr('autocomplete','off');
	
	$(':input').on('click focus',function(){
		$(this).attr('autocomplete', 'off');
	});
	
	
	
	
	
	$("#go-button").on('click', function() {
        if(IsFullScreenCurrently())
            GoOutFullscreen();
        else
            //GoInFullscreen($("#demo-element").get(0));
			GoInFullscreen($("html").get(0));
    });
	
	
	
	
	
	$('.iframe_open').click(function(){
			iframe_openf(this);
    });
	
	
	$('.hrefmodal').click(function(){
		var data_href = $(this).attr('data-href');
		var data_tid = $(this).attr('data-tid');
		
		
		 if(data_href !== undefined){
			 hrefmodal(data_href,data_tid,this);
		 }
	});
	
	
	$('.datahref').click(function(){
		//alert('2222');
		var data_href = $(this).attr('data-href');
		 if(data_href !== undefined){
			 datahref(data_href);
			 //modal_popup3_frame.window.location.href=data_href+"&ajaxf=1";
			//ajaxf2(data_href+"&ajaxf=1",ajaxf2_id);
			//$('.adm_tr_3').remove();
		 }
	});
	
	
	activeHerf();
	
	
	//NProgress.start();NProgress.done();
	
	//$('.logout i').attr('style','visibility:hidden;');
	//alert(uid_var);
	
	//$('.logout i').attr('style','visibility:visible;');
		
		
	/*
	$('#e1').click(function() {
		NProgress.configure({ showSpinner: true });
		NProgress.set(0.2);
		NProgress.set(0.4);
		NProgress.set(0.6); 
		NProgress.set(0.8); 
		NProgress.set(1.0);				
	});
	$('#e2').click(function() {
		NProgress.configure({ showSpinner: true });
		NProgress.start();
		$('#nprogress .bar').css({'background': '#c0392b'});
		$('#nprogress .peg').css({'box-shadow': '0 0 10px #c0392b, 0 0 5px #c0392b'});
		$('#nprogress .spinner-icon').css({'border-top-color': '#c0392b', 'border-left-color': '#c0392b'});
		NProgress.done();
	});
	$('#e3').click(function() {
		NProgress.configure({ showSpinner: false });
		NProgress.start();
		$('#nprogress .bar').css({'background': '#16a085'});
		$('#nprogress .peg').css({'box-shadow': '0 0 10px #16a085, 0 0 5px #16a085'});
		$('#nprogress .spinner-icon').css({'border-top-color': '#16a085', 'border-left-color': '#16a085'});
		NProgress.done();
	});
	
	*/
	
	
	$('.acc3').click(function(){
		var showcVar= $(this).attr('data-showc');
		var hidecVar= $(this).attr('data-hidec'); 
		if(showcVar !== undefined){showVarf(showcVar); }
		if(hidecVar !== undefined){hideVarf(hidecVar); }
   });
	
	

	checkConstraints();	
	
	accordion_next(); 
	
	document.onkeyup=function(event){
	   if (event.keyCode === 27){
		 $('.modal_popup_popup').hide(100);
		 if (typeof popupclose === "function") {
			popupclose();
		 }
	   }
	}
	
	
	
		
	$('.filesUpload input[type="file"]').change(function(){
		filesUploadf(this);
	});
	
});


function getElmnt(elmntid){
	//loadobjs(getContextPaths+'/css/style.css');
    var elmnt = (document.getElementById)? document.getElementById(elmntid): (document.all)? document.all[elmntid]: (document.layers)? document.layers[elmntid]: null;
    if (elmnt == null) {elmnt = (document.getElementById)? parent.document.getElementById(elmntid): (document.all)? parent.document.all[elmntid]: (document.layers)? parent.document.layers[elmntid]: null};
    return elmnt;
}
function resizeIframes(frameid){

	//alert(frameid);
	var frame = getElmnt(frameid);
	var srcpath=frame.contentWindow.location.pathname;
		if(srcpath!="blank" || srcpath!="/blank"){
		    frame.height = "0";
		    var xtra = (navigator.userAgent.indexOf("IE") == "-1")?5:0;
		    var height = frame.contentWindow.document.body.scrollHeight;
		    //alert(height+"\r\n"+frame.name+"\r\n"+frame.contentWindow.location.pathname);
		    frame.height = height+xtra;
		    frame.scrolling='no';
		    frame.style.display="block";
		}

}


//compare 

function highlight(){    
	$(arguments).toggleClass('invalid',true);
}
function checkConstraints(e){
	//reset style before re-checking
	$('.compare td.invalid').toggleClass('invalid');
	//get rows as an array of array
	var rows = $('.compare tr').map(function(elem,i){
		return [$(this).children('.compare td').toArray()];
	}).toArray();        
	//loop through the rows
	for(var i = 0; i < rows.length; i++){
		cell = {};        
		for(var j = 0; j < rows[i].length; j++){
			if(cell[rows[i][j].innerText]) {  
				highlight(cell[rows[i][j].innerText], rows[i][j]);                
			} else {
				cell[rows[i][j].innerText] = rows[i][j];
			}
			if(i < rows.length - 1 && rows[i][j].innerText == rows[i+1][j].innerText) {               
			   highlight(rows[i][j],rows[i+1][j]);
			}            
		}        
	}
}


function diff_log(e,theNo){
	var thisNo=Number($(e).attr('data-no'));
	if((Number(theNo)-1)==thisNo){
		$(e).attr('data-no',0);
	}else{
		$(e).attr('data-no',thisNo+1);
	}
	
	//var thisNoGet=$(e).attr('data-no');
	var tbl=$(e).parent().parent().parent().parent().parent().parent().parent().parent().parent().parent().find('.tbl_exlHeightAuto');
	
	$(tbl).eq(0).animate( { scrollLeft: '+='+(($(e).parent().parent().parent().parent().find("diff").eq(thisNo).offset().left)-320) }, 1000);
}




/***********  multi file uploder *********************************************************************/

var abc = 0; //Declaring and defining global increement variable
function mltifileupldf(){
//To add new input file field dynamically, on click of "Add More Files" button below function will be executed
    $('#formdiv #add_more').click(function() {
        $(this).before($("<div/>", {id: 'filediv'}).fadeIn('slow').append(
                $("<input/>", {name: 'file[]', type: 'file', onchange: 'imageIsChange(this)', id: 'file'}),        
                $("")
                ));
		imageIsChange(this);
    });

	 $('#formdiv #menu_add_more').click(function() {
        $(this).before($("<div/>", {id: 'filediv'}).fadeIn('slow').append(
                $("<input/>", {name: 'menu_file[]', type: 'file', onchange: 'imageIsChange(this)', id: 'file'}),        
                $("")
                ));

    });

//To preview image     
    

}

function add_more_files(e,theInputs,theFun=''){
	if(theFun){
		ajax_files_valid(e);
	}
	$('input[type="file"]').removeClass('mfile');
	
	var name = $(e).parent().parent().parent().parent().parent().find(".mfile").val();
	$(e).parent().parent().parent().parent().parent().find('.inputDivPar').removeClass('unActive');
	var file_1=$(e).parent().parent().parent().parent().parent().find('.mfile').length;
	//alert(file_1);
	
	$(e).before($("<div/>", {id: 'filediv'}).fadeIn('slow').append(
		$("<input/>", {name: theInputs, type: 'file', class: 'mfile form-control my-1 file_'+abc, onchange: 'imageIsChange(this,'+theFun+')', id: 'file'}),        
		$("")
	));
	
	if (!name)
	{
		$(e).parent().parent().parent().parent().parent().find(".mfile").focus().trigger('click');
	}
	
}

function add_more_files2(e,theInputs,theFun=''){
	if(theFun){
		ajax_files_valid(e);
	}
	$('input[type="file"]').removeClass('mfile');
	
	var name = $(e).parent().parent().parent().parent().parent().find(".mfile").val();
	$(e).parent().parent().parent().parent().parent().find('.inputDivPar').removeClass('unActive');
	var file_1=$(e).parent().parent().parent().parent().parent().find('.mfile').length;
	//alert(file_1);
	
	$(e).before($("<div/>", {id: 'filediv'}).fadeIn('slow').append(
		$("<input/>", {name: theInputs, type: 'file', class: 'mfile form-control my-1 file_'+abc, onchange: 'imageIsChange(this,'+theFun+')', id: 'file', accept: 'image/*', capture: 'camera'}),        
		$("")
	));
	
	if (!name)
	{
		$(e).parent().parent().parent().parent().parent().find(".mfile").focus().trigger('click');
	}
	
}


//following function will executes on change event of file input to select different file
//var hostPath='';	
/*
$('body').bind('change', '#formdiv #file', function(){
	if (this.files && this.files[0]) {
		 abc += 1; //increementing global variable by 1
		
		var z = abc - 1;
		var x = $(this).parent().find('#previewimg' + z).remove();
		$(this).before("<div id='abcd"+ abc +"' class='abcd'><span onclick='uploadfile_viewf(this)'><img id='previewimg" + abc + "' src=''/></span></div>");
	   
		var reader = new FileReader();
		reader.onload = imageIsLoaded;
		reader.readAsDataURL(this.files[0]);
	   
		$(this).hide();
		$("#formdiv #abcd"+ abc).append($("<img/>", {id: 'img', src: hostPath+'/images/x.png', alt: 'delete'}).click(function() {
		$(this).parent().parent().remove();
		}));
	}
});
*/

function setTwoNumberDecimal(event) {
    this.value = parseFloat(this.value).toFixed(2);
}

function imageIsChange(e,theFun='') {
	//alert(e.name+'\r\n'+theFun);
        if (e.files && e.files[0]) {
		 abc += 1; //increementing global variable by 1
		
		var z = abc - 1;
		var x = $(e).parent().find('#previewimg' + z).remove();
		$(e).before("<div id='abcd"+ abc +"' class='abcd'><span onclick='uploadfile_viewf(this)'><img id='previewimg" + abc + "' src=''/></span></div>");
	   
		var reader = new FileReader();
		reader.onload = imageIsLoaded;
		reader.readAsDataURL(e.files[0]);
	   
		$(e).hide();
		$("#formdiv #abcd"+ abc).append($("<img/>", {id: 'img', src: hostPath+'/images/x.png', alt: 'delete'}).click(function() {
			if(theFun){
				ajax_remove_files(this);
				$(e).parent().hide();
			}else{
				$(e).parent().remove();
			}
		}));
		
		if(theFun){
			ajax_files(e);
		}
	}
};



function imageIsLoaded(e) {
        $('#formdiv #previewimg' + abc).attr('src', e.target.result);
};

$('#upload').click(function(e) {
	var name = $(":file").val();
	if (!name)
	{
		alert("First Image Must Be Selected");
		e.preventDefault();
	}
});

function moreDelf(e){
	$(e).parent().parent().css('display','none');
	$(e).parent().parent().find('.remove_file').val($(e).parent().parent().find('.update_file').val());
	$(e).parent().parent().find('.update_file').val('');
}
function uploadfile_viewf(theValue,fileType='img',Modtitle='Document'){
	//alert('uploadfile_viewf'+'/r/n'+$(theValue).find('img').attr('src'));
	if(fileType=='img'){
		var thisImgSrcVar='<div class="uploadfile_fullView"><img src="'+$(theValue).find('img').attr('src')+'" style="max-width: 96%;padding: 5px;margin: 10px auto;float: none;display: block;" /></div>';
	}else{
		var thisImgSrcVar='<div class="uploadfile_fullView"><iframe name="openframe" id="openframe" src="'+fileType+'" width="100%" height="485px" scrolling="auto" frameborder="0" marginwidth="0" marginheight="0" style="width:100%!important;height:478px!important;display:block;margin:20px auto;" ></iframe></div>';
		
	}
	//alert(thisImgSrcVar);
	//window.open($(theValue).find('img').attr('src'),"_blank");
	
	//$('#modal_popup_iframe_div').html(thisImgSrcVar);
	//$('#modal_popup_popup').slideDown(1000);
	
	//var Modtitle='Bank Document'; .modal-dialog { max-width: 90%;
	$('#myModal .modal-dialog').css({"max-width":"90%"});
	$('#myModal .modal-title').html(Modtitle);
	
	$('#myModal .modal-body').html(thisImgSrcVar);
		
	$('#myModal').modal('show');
	
	
	
}



function collectFormData(fields) {
    var formData = new FormData();

    for (var i = 0; i < fields.length; i++) {
        var $item = $(fields[i]);

        if ($item.attr('type') =="file"){
            var file = $('input[type=file]')[0].files[0];
            formData.append( $item.attr('name') , file);

        } else {
            formData.append( $item.attr('name') , $item.val());
        }
    }
    return formData;
}

const inputFileObjec=[];
const inputFileObjec2=[];

function filesUploadf(e){
	
	var thisInput = $(e);
	var file_name = thisInput.attr('name');
	var file_value = thisInput.val();
	var index_dot = file_value.lastIndexOf(".")+1;
	var ext = file_value.substr(index_dot);
	ext = ext.toLowerCase();
	//alert('filesUploadf:'+file_value);//return false;
	if(file_value=='') {
		alert('Please upload image');
	}
	else if(!(ext=='doc' || ext=='docx' || ext=='jpg' || ext=='jpeg' || ext=='png' || ext=='bmp')) {
		alert('Please upload jpg or png image only');
	}	//Image validation end
	else {
		//formdata object to send file upload data
		var formData = new FormData();
		formData.append('filename',file_name);
		formData.append('fileupload',thisInput[0].files[0], file_value);
		
		var thisurls=hostPath+"/user/profile.do?actionName=filesUploadAction";	
		
		$.ajax({
			type: "POST",
			scriptCharset: "utf-8",
			enctype: 'multipart/form-data',
			url: thisurls,
			data: formData,
			processData: false,
			contentType: false,
			cache: false,
			//timeout: 600000,
			success: function (data) {
				 //alert(JSON.stringify(data));
				if(data['Error']){
					alert(data['Error']);
				}else if(data['msg'] =='Error' ){
					alert(data);
				}else{
					if(data['src']){
						if($('#'+file_name+'_view')){
							$('#'+file_name+'_view').html('<img src='+data['src']+' >');
						}
						if($('#'+file_name+'_download')){
							$('#'+file_name+'_download').attr('target', '_blank');
							$('#'+file_name+'_download').attr('href', hostPath+"/include/file_download.do?f="+data['download']);
						}
					}
					alert(data['msg']);
				}
				
			},
			error: function (e) {
				alert(e);
				console.log("ERROR : ", e);
			}
		});
	
	}
}

// for IP History View
function view(script, width, height){var scr=window.open(script,"wnd","channelmode=no,directories=no,fullscreen=no,width="+width+",height="+height+",location=no,menubar=no,resizable=no,scrollbars=yes,status=no,titlebar=yes,toolbar=0");}function cfmform(){return confirm("Are you sure?");}var marked_row=new Array;function setPointer(theRow,theRowNum,theAction,theDefaultColor,thePointerColor,theMarkColor){var theCells=null;if((thePointerColor==''&&theMarkColor=='')||typeof(theRow.style)=='undefined'){return false;}if(typeof(document.getElementsByTagName)!='undefined'){theCells=theRow.getElementsByTagName('td');}else if(typeof(theRow.cells)!='undefined'){theCells=theRow.cells;}else{return false;}var rowCellsCnt=theCells.length;var domDetect=null;var currentColor=null;var newColor=null;if(typeof(window.opera)=='undefined'&&typeof(theCells[0].getAttribute)!='undefined'){currentColor=theCells[0].getAttribute('bgcolor');domDetect=true;}else{currentColor=theCells[0].style.backgroundColor;domDetect=false;}if(currentColor==''||currentColor.toLowerCase()==theDefaultColor.toLowerCase()){if(theAction=='over'&&thePointerColor!=''){newColor=thePointerColor;}else if(theAction=='click'&&theMarkColor!=''){newColor=theMarkColor;marked_row[theRowNum]=true;}}else if(currentColor.toLowerCase()==thePointerColor.toLowerCase()&&(typeof(marked_row[theRowNum])=='undefined'||!marked_row[theRowNum])){if(theAction=='out'){newColor=theDefaultColor;}else if(theAction=='click'&&theMarkColor!=''){newColor=theMarkColor;marked_row[theRowNum]=true;}}else if(currentColor.toLowerCase()==theMarkColor.toLowerCase()){if(theAction=='click'){newColor=(thePointerColor!='')?thePointerColor:theDefaultColor;marked_row[theRowNum]=(typeof(marked_row[theRowNum])=='undefined'||!marked_row[theRowNum])?true:null;}}if(newColor){var c=null;if(domDetect){for(c=0;c<rowCellsCnt;c++){theCells[c].setAttribute('bgcolor',newColor,0);}}else{for(c=0;c<rowCellsCnt;c++){theCells[c].style.backgroundColor=newColor;}}}return true;}
function change_ln(ln_name){
	SetCookie('ln',ln_name,100);
	window.location.reload()
}


function SetCookie(cookieName,cookieValue,nDays) {
 var today = new Date();
 var expire = new Date();
 if (nDays==null || nDays==0) nDays=1;
 expire.setTime(today.getTime() + 3600000*24*nDays);
 document.cookie = cookieName+"="+escape(cookieValue)
                 + ";expires="+expire.toGMTString();
}

