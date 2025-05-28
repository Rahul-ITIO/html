<?

if(isset($post['fullname'])&&$post['fullname']){ $_REQUEST['fullname']=$post['fullname']; }

?>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 

<div class="hide" style="display:none">
	<div class="alert_msg_2" title="No Payment Chanel Available to process this card">No Payment Chanel Available to process this card</div><div class="alert_msg_3" title="Please enter correct CVV">Please enter correct CVV and cannot empty </div>
</div>


<div class="member_pro my-2">
  <? if((isset($_SESSION['login']))&&($post['action']=="vt")){?>
  <? $c_style="style='float:none;'"; ?>
  <ul class="breadcrumb" style="text-align:left;">
    <li><a href="<?=$data['Members']?>/index<?=$data['ex']?>" ><i class="<?=$data['fwicon']['home'];?>"></i> <?=prntext($data['SiteName'])?></a></li>
    <li class="divider"></li>
    <li>Moto</li>
  </ul>
  <? } ?>
  <? 
  $browserOs1=browserOs("1"); $browserOs=json_encode($browserOs1); 
  $setBrowserName='safari'; //safari mozilla	chrome
  ?>
  <script language="javascript" type="text/javascript"> 
//window.name='nwTrPro';
var BrowserName="<?=$browserOs1['BrowserName'];?>";
var setBrowserName="<?=$setBrowserName?>"; //safari mozilla	chrome
//if(BrowserName=='mozilla'){ alert(BrowserName); }

var jsTestCardNumbers =[<?=$data['jsTestCardNumbers']?>];


function SlideBox(x,cmd) {		
	if ($('#'+x).is(":hidden")) {
		if(cmd){
			$(".error1").html('');
						
			$(".showfp").slideUp(900);			
			$('#'+x).slideDown(1000);	
		}
	}
}




if(window.name=='iframe'){
	$('body').addClass('htmlpopup');
	$('html').addClass('htmlpopup');
}




function mytext1(str)
{
	//alert(str);
	document.getElementById("cardsavefinal").value = str;
} 
    function validateForm(formObj) {
		
		/*
        formObj.send123.disabled = true;  
        formObj.send123.value = 'Please Wait...';          
        //formObj.cardsave.disabled = true;  
        //formObj.cardsave.value = 'Please Wait...';  
        return true;  
		*/
  
    }  
 var ccn_var;
	function showPaymentMethod(){
		$('#paymentMethodChange').hide(100);
		$('#otherPaymentMethod').show(100);
		$('.avai_h4').show(1000);
		$('.inputype').removeClass('hide');
		$('.inputype').removeClass('active');
		$('.account_types').removeClass('active');
		$('.pay_div').slideUp(100);
	}
	
	
var merchant_pays="";
var afj="";
var merchant_pays_fee="";
<? if(isset($_SESSION['afj'])&&$_SESSION['afj']&&$_SESSION['merchant_pays_fee']){?>
	merchant_pays="1"; 
	afj=<?=$_SESSION['afj']?>;
	merchant_pays_fee="<?=$_SESSION['merchant_pays_fee'];?>";
<? } ?>

var backMerchantWebSiteUrl='';
<? if(isset($_SESSION['re_post']['return_failed_url'])&&$_SESSION['re_post']['return_failed_url']){?>
	backMerchantWebSiteUrl="<?=$_SESSION['re_post']['return_failed_url'];?>";
<? } ?>


//merchantPage -----------
var merchantReturnVar='merchantReturnWebSiteOK';
function backMerchantWebSite(theValue){
	var retVal ='';
	if(theValue=='timeOut'){
		retVal = theValue;
	}else{
	 retVal = confirm("This action will redirect you on the merchant website.");
	}
	//alert(retVal);
    if (retVal) {
		var merchantWebSite = "<?=$data['Host'];?>/session_check<?=$data['ex'];?>?merchantWebSite="+merchantReturnVar;
		  //alert(merchantWebSite);
         //top.window.location.href=backMerchantWebSiteUrl;
		$('#modalpopup_form_popup').slideDown(900);
		
		$.ajax({url: merchantWebSite, success: function(result){
			//alert(result);
			top.window.location.href=backMerchantWebSiteUrl;
			$('#modalpopup_form_popup').slideUp(70);
		}});
		
        return true;
    } else {
        //alert(backMerchantWebSiteUrl);
		return false;
    }
			
}

function updateTimer() {
		timeLeft -= 1000;
		if (timeLeft > 0) {
			timer.text(msToTime(timeLeft));
			//alert('11if');
		} else {
			//window.location.reload(true);
			
		}
	}
function msToTime(s) {
	  var ms = s % 1000;
	  s = (s - ms) / 1000;
	  var secs = s % 60;
	  s = (s - secs) / 60;
	  var mins = s % 60;
	  var zero = secs <= 9 ? '0' : '';
	  return mins + ':' + zero + secs;
}
var timeLeft = 0;
var timer;

function ewalist_f(e,ewalistVar,etypeVar='',onShow='') {
	var onShowCheckVar='true';
	//alert('ewalistVar=>'+ewalistVar+'\r\netypeVar=>'+etypeVar+'\r\onShow=>'+onShow+'\r\onShowCheckVar=>'+onShowCheckVar);
	var ewalistVar_arr = ewalistVar.split(' ');
	for(var i = 0; i < ewalistVar_arr.length; i++)
	{
		if(ewalistVar_arr[i]){
			$('.ewalist.'+ewalistVar_arr[i]+'_div').show();
			$('.ewalist.'+ewalistVar_arr[i]+'_div').addClass('active'); 
			
			if($('.ewalist.'+ewalistVar_arr[i]+'_div').hasClass('modalMsg')){
				onShowCheckVar='false';
				var dataStyle= $('.ewalist.'+ewalistVar_arr[i]+'_div').attr('data-style');
				 if(dataStyle !== undefined){
					$('.modal_msg_body').attr('style',dataStyle); 
				 }
				 
				$('#modal_msg_body_div').html($('.ewalist.'+ewalistVar_arr[i]+'_div').find('.modalMsgCont').html());
				
				
				tv=topInViewport(e);
				//alert('150=>'+tv);
				if(tv){ $('.modal_msg_body').animate({top:tv,'position':'absolute'}, 500); }
				
				$('#modal_msg').show(100); 
				
				$('#payment_form_id_ewallets').attr('target','_blank');
				$('#payment_form_id_ewallets').addClass('nextTabTr');
				
			}
			
		}
	}
	
	if(etypeVar=='3D'&&onShow=='onSh'&&onShowCheckVar=='true'){
		//alert('ewalistVar=>'+ewalistVar+'\r\netypeVar=>'+etypeVar+'\r\onShow=>'+onShow+'\r\onShowCheckVar=>'+onShowCheckVar);
		var dataStyle= $('.ewalist.universal_msg_div').attr('data-style');
		 if(dataStyle !== undefined){
			$('.modal_msg_body').attr('style',dataStyle); 
		 }
		$('#modal_msg_body_div').html($('.ewalist.universal_msg_div').find('.modalMsgCont').html());
		
		
		tv=topInViewport(e);
		//alert('173=>'+tv);
		if(tv){ $('.modal_msg_body').animate({top:tv,'position':'absolute'}, 500); }
		
		
		$('#modal_msg').show(100); 
				
	}
	
	
}


var paymetAt = "<?=$data['Host'];?>/session_check<?=$data['ex'];?>?paymetAt=1";
 
var storeSize="<?=(isset($post['storeSize'])?$post['storeSize']:'');?>";	
var api_token="<?=(isset($post['api_token'])?$post['api_token']:'');?>";
	
var card_validation='yes';
$(document).ready(function(){
	
	if(storeSize=='1'&&api_token){
		//alert('storeSize:'+storeSize+'\r\napi_token:'+api_token); 
		window.location.href=paymetAt+"&api_token="+api_token;
	}

	$("#storeType").change(function() {
	   var selectedItem = $(this).val();
	   var titles= $('option:selected', this).attr('data-title');
	   
	   //$("#api_token").val(selectedItem); $("#store_id").val(titles);
	   
	   
	   window.location.href=paymetAt+"&api_token="+selectedItem;
	   //window.location.href=window.location.href+"&api_token="+selectedItem;
		// alert(selectedItem+'\r\n'+titles);
	   
	   //console.log(abc,selectedItem);
	});
	
	
    $('.account_types').click(function(){
	   var ccn_array;
	   var name_var = $(this).attr('data-name');
	   var value_var = $(this).attr('data-value');
			ccn_var = $(this).attr('data-ccn');
		
	   var ewalistVar= $(this).attr('data-ewlist');
	   
		$('#payment_form_id_ewallets').removeClass('nextTabTr');
		$('#payment_form_id_ewallets').removeAttr('target');
		
		var etypeVar= $(this).attr('data-etype');
		if((etypeVar !== undefined)&&(etypeVar==='3D')){
			$('#payment_form_id_ewallets').attr('target','_blank');
			$('#payment_form_id_ewallets').addClass('nextTabTr');
			
			$('#continue3dButton').hide();
			$('#continueValidationButton').show();
			
			
		}
	   
	    $('.required').each(function(){
			$(this).removeAttr("required");
		});
		
	   $('.cname label').removeClass('active');
	    //alert(ccn_var);
		 if(ccn_var!=null&&ccn_var!=''){
			ccn_array = ccn_var.split(",");
			if (ccn_var.toLowerCase().indexOf("rupay") >= 0){
				 card_validation='';
			}else{
				 card_validation='yes';
			}
		 }
	   $('#credit_cards img').hide();
	 
	   if(ccn_array!=null&&ccn_array!=''){
		   $.each(ccn_array,function(i){
			   //alert(ccn_array[i]);
			   $('#credit_cards #'+ccn_array[i]).show();
			});
	   }
	  
	   
	    if($(this).hasClass('active')){
			showPaymentMethod();
		} else {
			
			//alert("open box");
			$('.inputype').addClass('hide');
			$('.inputype').removeClass('active');
			$('.account_types').removeClass('active');
			$('.cname label[for="'+value_var+'"]').addClass('active');
			
			$('#paymentMethodChange').show(100);
			$('#otherPaymentMethod').hide(50);
			$('.avai_h4').hide(100);
			
			$(this).parent().removeClass('hide');
			$(this).parent().addClass('active');
			$(this).addClass('active');

			$('.pay_div').slideUp(100);
			$('.'+name_var+'_div').slideDown(700);
			
			if(merchant_pays){
			 
			 
				//alert(value_var+'\r\ txn_fee:'+afj[value_var]['txn_fee']+'\r\ nconvenience_fee:'+afj[value_var]['convenience_fee']+'\r\ order_amount:'+afj[value_var]['order_amount']+'\r\ total_amount:'+afj[value_var]['total_amount']);
				
				/* <<convenience_fee
				$('#orderAmount_txt').html($(this).attr('data-currency')+afj[value_var]['order_amount']);
				$('#conveniencFee_txt').html($(this).attr('data-currency')+afj[value_var]['convenience_fee']);
				$('#totalAmount_txt').html(afj[value_var]['total_amount']);
				$('#conveniencDivIp').show(1000);
				
				*/
			}
	  
		}
	   
	   if($(this).attr('data-name')==="echeck"){
		   $('#zts-echeck input[name="type"]').val(value_var);
	   }else{
		   $('#payment_form_id input[name="midcard"]').val(value_var);
	   }
	   
	   if($(this).attr('data-name')==="ewallets" || $(this).attr('data-name')==="ebanking"){
	   
		 if(ewalistVar !== undefined){
			$('.ewalist').hide();
			$('.ewalist').removeClass('active');
			$('.ewalist.'+ewalistVar+'_div').show();
			$('.ewalist.'+ewalistVar+'_div').addClass('active');
			
			ewalist_f($(this).parent().find('label'),ewalistVar,etypeVar);
			//ewalist_f($('.inputValidation'),ewalistVar,etypeVar);
			
			
			
			$('.ewalist.active .required').each(function(){
				$(this).attr("required","required");
			});

		 }
	     
		 $('#payment_form_id_ewallets input[name="midcard"]').val(value_var);
	   }
	   
	   if($(this).attr('data-name')==="ebanking"){
		 $('#payment_form_id_ebanking input[name="midcard"]').val(value_var);
	   }
	   
	   if($(this).attr('data-name')==="bhimupi"){
		 $('#payment_form_id_bhimupi input[name="midcard"]').val(value_var);
	   }
	   
		
       $('#t_amt').html($(this).attr('data-currency'));
    });
	
    //$(".account_types").eq(0).trigger("click");
	
	
	$('.inputValidation').click(function(){
		
		 var ewalistVar = $('.inputype.active .account_types').attr('data-ewlist');
		 var etypeVar= $('.inputype.active .account_types').attr('data-etype');
		 ewalist_f(this,ewalistVar,etypeVar,'onSh');
	});
	
	
	//------------------------------

	$('#otherPaymentMethodLink').click(function(){
		$('.universalWisePay').removeClass('hide1');
		$('.countryWisePay').removeClass('hide1');
		
		$('#otherPaymentMethodLink').hide(50);
		$('#goBackPaymentMethodLink').show(1000);
	});
	
	$('#goBackPaymentMethodLink').click(function(){
		$('.universalWisePay').addClass('hide1');
		$('.countryWisePay').removeClass('hide1');
		
		$('#otherPaymentMethodLink').show(1000);
		$('#goBackPaymentMethodLink').hide(50);
	});

	$('#paymentMethodChange').click(function(){
		showPaymentMethod();
	});
	 
	/*
	 $('.banksDiv').click(function(){
		$('.banksDiv').removeClass('active');
		$(this).addClass('active');
		
		var thisVal=$(this).find('.bankNm').text();
		
		$('.bankdropdown').find('option:contains("'+thisVal+'")', this).prop('selected', 'selected');
		$('.bankdropdown').find('option:contains("'+thisVal+'")', this).attr('selected', 'selected');

   });
   
   $('.bankdropdown').change(function(){
		var thisText=$(this).find('option:selected').val();
//alert(thisText);
		$('.banksDiv').removeClass('active');
		$('.banksDiv.'+thisText).addClass('active');
		
		

   });
   */
   
   //------------------------------
	
	<? if(isset($_SESSION['re_post']['failed_type'])&&$_SESSION['re_post']['failed_type']){?>
		
		$('.cname label').removeClass('active');
		$('.cname label[for="<?=$_SESSION['re_post']['failed_type'];?>"]').addClass('active');
		
		$('body').addClass('oops2');
		
		timer = $('.timer');
		//timer.text('07:00');
		//timeLeft = 899678; // 15 minutes = 59978.53333333333 * 15 ; 
		timeLeft = 299890;
		 
		setTimeout(function(){ 
			merchantReturnVar='TimeOut:merchantReturnWebSiteOK';
			//top.window.location.href=processed;
			backMerchantWebSite('timeOut');
			//alert(merchantReturnVar); 
		}, timeLeft);
		
		
		setInterval(updateTimer, 1000);
		
	<? } ?>
	


	$('.merchantPage').click(function(){
		 backMerchantWebSite('merchantClick');
	});
	
	$('.tryAgain').click(function(){
		$('.alertPaymentDiv').hide(50);
		$('.slidePaymentDiv').show(1000);
	});


   setTimeout(function(){
	$(".goog-te-combo option:first-child").text('English');
	$('.translateDiv').show(100);
   },2000); 
   
   
   //-------------------------------------------
   
   
	//desImg
	//txNm
	//dropDwn
	//data-showc="customerPhone" data-hidec="upi_vpa"

   
   $('.desImg').click(function(){
		$('.desImg').removeClass('active');
		$(this).addClass('active');
		var thisVal=$(this).find('.txNm').text();
		$('.dropDwn').find('option:contains("'+thisVal+'")', this).prop('selected', 'selected');
		//$('.dropDwn').find('option:contains("'+thisVal+'")', this).attr('selected', 'selected');
		
		var thisName=$('.dropDwn').find('option:contains("'+thisVal+'")', this).parent().attr('name');
		var thisText=$('.dropDwn').find('option:contains("'+thisVal+'")', this).text();
		//alert('thisName: '+thisName+'\r\nthisText: '+thisText);
		if($('input[name='+thisName+'_text]')){ $('input[name='+thisName+'_text]').val(thisText); }
		var showcVar= $(this).attr('data-showc');
		var hidecVar= $(this).attr('data-hidec'); 
		if(showcVar !== undefined){showcVar_f(showcVar); }
		if(hidecVar !== undefined){hidecVar_f(hidecVar); }
	});
   $('.dropDwn').change(function(){
		var thisName=$(this).attr('name');
		var thisText=$(this).find('option:selected').text();
		//alert('thisName: '+thisName+'\r\nthisText: '+thisText); 
		if($('input[name='+thisName+'_text]')){ $('input[name='+thisName+'_text]').val(thisText); }
		var thisVal=$(this).find('option:selected').val();
		$('.desImg').removeClass('active');
		$('.desImg.'+thisVal).addClass('active');
		
		var showcVar= $('.desImg.'+thisVal).attr('data-showc');
		var hidecVar= $('.desImg.'+thisVal).attr('data-hidec'); 
		if(showcVar !== undefined){showcVar_f(showcVar); }
		if(hidecVar !== undefined){hidecVar_f(hidecVar); }
		
		
   });
   
   
}); 



function showcVar_f(showcVar){
	if(showcVar){
		var showcVar_arr = showcVar.split(' ');
		for(var i = 0; i < showcVar_arr.length; i++)
		{
			if(showcVar_arr[i]){
				$('.'+showcVar_arr[i]+'').show();
				if($('.'+showcVar_arr[i]+'').hasClass('required')){
					$('.'+showcVar_arr[i]+'').attr("required","required");
				}
			}
		}
	 } 
}

function hidecVar_f(hidecVar){
	if(hidecVar){
		var hidecVar_arr = hidecVar.split(' ');
		for(var i = 0; i < hidecVar_arr.length; i++)
		{
			if(hidecVar_arr[i]){
				$('.'+hidecVar_arr[i]+'').hide();
				$('.'+hidecVar_arr[i]+'').removeAttr("required","required");
			}
		}
	 }
}


</script>
  <? if(!empty($post['nick_name_check'])){?>
  <script language="javascript" type="text/javascript"> 
	$(document).ready( function(){
		$("#purchaser_routing").keyup(function() {
			if($("#purchaser_routing").val().length===9){
			  doLookup($("#purchaser_routing").val()); 
			}
		});
		//$("#example-form").submit(function() { return false; });
		//$("#tryit").click(function() { $('#purchaser_routing').val('122242597'); $('#purchaser_routing').click() });
	});
	
	function doLookup(rn)
	{
		$("#result_view").empty().text("Looking up " + rn + "...");
		$("#result_view_chk").empty().html("");
		$.ajax({
			url: "https://www.routingnumbers.info/api/data.json?rn=" + rn,
			dataType: 'jsonp',
			success: onLookupSuccess
		});
	}

	function onLookupSuccess(data){
		//alert(data['message']);
	 if(data['message']=="OK"){
		$("#purchaser_routing").removeClass('error');
		$("#bank_name").val(data['customer_name']);
		//$('#bank_state option value:contains("'+data['state']+'")').attr('selected', 'selected');
		$('#bank_state option[value*="'+data['state']+'"]').prop('selected','selected');
		$("#bank_address").val(data['address']);
		
		$("#bank_city").val(data['city']);
		$("#bank_phone").val(data['telephone']);
		var zipcode=data['zip'].split("-");
		$("#bank_zipcode").val(zipcode[0]);
		
		
		
		//alert(data['customer_name']);alert(data['routing_number']);
		/*
		var table = $("<table>").attr("class", "table table-bordered");
		table.append($("<tr>").append($("<th>").text("Results").attr("colspan", "2")));
		
		for (var member in data)
		{
			coltype = typeof data[member];

			table.append($("<tr>")
					.append($("<td>").text(member))
					.append($("<td>").text(data[member]))
					);
		}
		$("#result_view").empty().append(table);*/
		$("#result_view").empty().text("Bank Information Validated!");
		$("#result_view_chk").empty().html("<img class='valid' src='<?=$data['Host'];?>/contact/images/valid.png' /> ");
	  }else{
	    $("#purchaser_routing").addClass('error');
		$("#result_view_chk").empty().html("<img class='valid' src='<?=$data['Host'];?>/contact/images/invalid.png' /> ");
		$("#result_view").empty().text("Bank Information Invalidated. Please enter correct Bank ABA/Routing No.");
	  }
	}
</script>
  <? } ?>

  <script language="javascript" type="text/javascript"> 
var keyInput = $('.key_input');

function conc(){
	var str = "";
	$('.key_input').each(function(){
		str += $(this).val();
	});
	str = str.replace(/\s/g, '');
	$("#number").val(str);
}

function stringHasTheWhiteSpaceOrNot(value){
	return value.indexOf(' ') >= 0;
}

function limit(element, max, getId, nextId) {
	var thisValue = (element.value);
	
	var max_chars = max;
	if(thisValue.length > max_chars) {
		element.value = thisValue.substr(0, max_chars);
	} 

	if(getId==='int16' && document.getElementById(getId).value.length>0){
		document.getElementById('expMonth').focus();
	}
	else if( (getId!='int16' ) && ( document.getElementById(nextId).value !='' ) && ( document.getElementById(getId).value.length > 0 ) ){
		conc();
		document.getElementById('expMonth').focus();
	}
	conc();
}

function keypressf(element, getId, nextId) {
	if(getId=='int16'){}
	else if(document.getElementById(getId).value.length==0 && document.getElementById(getId).value!=' ' && document.getElementById(nextId).value==''){
		document.getElementById(nextId).focus();
		conc();
		return true;
	}
}

$(document).ready(function(){

	$('.key_input2').on('paste', function(e) {
		//alert($(this).val());
		alert(document.execCommand("copy"));
		
	});

	$('.key_input').on('paste', function (e) {
		e.preventDefault();
		var text;
		var clp = (e.originalEvent || e).clipboardData;
		if (clp === undefined || clp === null) {
			text = window.clipboardData.getData("text") || "";
			if (text !== "") {
				text = text.replace(/<[^>]*>/g, "");
				if (window.getSelection) {
					var newNode = document.createElement("span");
					newNode.innerHTML = text;
					window.getSelection().getRangeAt(0).insertNode(newNode);
				} else {
					document.selection.createRange().pasteHTML(text);
				}
			}
		} else {
			text = clp.getData('text/plain') || "";
			if (text !== "") {
				text = text.replace(/<[^>]*>/g, "");
				document.execCommand('insertText', false, text);
			}
		}

		text=text.replace(/ /g,"");
		if(text.length==16){
			$('#int1').val(text[0]);
			$('#int2').val(text[1]);
			$('#int3').val(text[2]);
			$('#int4').val(text[3]);
			$('#int5').val(text[4]);
			$('#int6').val(text[5]);
			$('#int7').val(text[6]);
			$('#int8').val(text[7]);
			$('#int9').val(text[8]);
			$('#int10').val(text[9]);
			$('#int11').val(text[10]);
			$('#int12').val(text[11]);
			$('#int13').val(text[12]);
			$('#int14').val(text[13]);
			$('#int15').val(text[14]);
			$('#int16').val(text[15]);
		}
	});

	var key_input_val='';
	
	$('.key_input').on('click focus', function(e) {
		key_input_val=$(this).val();
		$(this).val('');
		$(this).attr('placeholder',key_input_val+'');
		
	});
	$('.key_input').on('focusout', function() {
		if($(this).val()===''||$(this).val()==''){
			$(this).val(key_input_val);
		}
	}); 

	var key_input_val2='';
	$('.key_input').on('mouseenter', function(e) {
		key_input_val2=$(this).val();
		$(this).val('');
		$(this).attr('placeholder',key_input_val2+'');
	});

	$('.key_input').on('mouseleave', function() {
		if(($(this).val()===''||$(this).val()=='')&&(key_input_val2)){
			$(this).val(key_input_val2);
			key_input_val2='';
		}
	}); 

	$("#cardsend_submit").click(function() {
		if(BrowserName==setBrowserName){ 
		
		}else{
			conc();
		}
	});

	$('.key_input').keyup(function(e){
		if(e.keyCode == 8){
			key_input_val2='';
			$(this).attr('placeholder','');
			var cId = 0;
			cId = parseInt(($(this).attr('id')).replace('int',''));
			key_input_val='';
			$(this).val('');
			var pId=(cId-1);
			if(pId>0){
				document.getElementById('int'+(pId)).focus();
			}
		}
	});
	<? if(isset($post['midcard'])&&trim($post['midcard'])&&$post['midcard']>0){ ?>
		$(".account_types[value='<?=$post['midcard']?>']").trigger("click"); 
	<? } ?>
});	
</script>

  <style>
  
 /* Start New CSS by vikash on 24-01-2023*/
  
	.inputWithIcon { position: relative; }
	.inputWithIcon i { position: absolute;right: 6px;top: 35px;color: #aaa;transition: 0.3s;font-size: 23px;}
	.iconrupay{background:#fff url(images/rupaycard.jpg) 99% 3px no-repeat;background-size:8%; float:left; }
    .jqclock{/*box-shadow: 0px 0px 5px Black;display:inline-block;*/font-size: 18px;}
	 /*body .btn-primary { color:#ffffff !important; }*/
	
  /* End New CSS by vikash on 24-01-2023*/ 
  
.row {--bs-gutter-x: 0 !important;}

.img-hover { font-size: 20px !important; }
.img-hover:hover { /*transform: scale(2.5);*/ } 
.modal_msg_close2 {position:absolute;z-index:99;float:right;left:50%;bottom:6px;width:60px;height:30px;font:400 18px/30px 'Open Sans';color:#fff!important;background:#274382;text-align:center;border-radius:3px;overflow:hidden;cursor:pointer;margin:0 0 0 -30px;}


.modalMsgContTxt {padding:10px 20px;}
.processall .modalMsgContTxt h4{margin: 10px 0px;}
.modalMsgContTxt p {font-size:16px; margin:10px 0 10px 0;}
.universalWisePay {display:block;}
.universalWisePay.hide1 {display:none;}
#cardsend_submit i, .suButton i {display:none;}
#cardsend_submit, .suButton { width:100%;}


body {top:0 !important; background:#ffffff !important;}

body .w94, body input[type=text].w94 {
    /*min-width: 94% !important;
    width: 94% !important;*/
    float: none;
    margin: 0 auto;
    display: block;
}
p { margin-top: 2px !important; margin-bottom: 2px !important; }

.oops2{margin:0;padding:0;overflow:auto;width:100%;height:100%;
    background: url("<?php echo $data['Host'];?>/images/criss-cross.png");
    border-color: #d6e9c6;
}

.oops2 .container-fluid.fixed {
    background: url("<?php echo $data['Host'];?>/images/criss-cross.png");
}

.timerText{
    /*clear: both;
    width: 100%;
    text-align: right;
    margin: 0 0 10px 0;*/
}
.timer{font-weight:bold;font-size:18px;}

.alertPaymentDiv {}

.credit-card-box {}
.credit-card-box.hover .flip {}
.credit-card-box .front,
.credit-card-box .back {}

.members.processall #credit_cards img {width:18.6%;}
.credit-card-box .logo_card_icon {position:absolute;top: 17px;
right: 8px;width:256px; text-align: right;}
.credit-card-box .logo_card_icon svg {width:100%;height:auto;fill:#fff;}
.credit-card-box .front {}
.credit-card-box .back {-webkit-transform:rotateY(180deg);transform:rotateY(180deg);}
.credit-card-box .back .logo_card_icon {top:185px;}
.credit-card-box .chip {position:absolute;width:60px;height:45px;top:12px;left:5px;background:linear-gradient(135deg, #ddccf0 0%, #d1e9f5 44%, #f8ece7 100%);border-radius:8px;}
.credit-card-box .chip::before {content:'';position:absolute;top:0;bottom:0;left:0;right:0;margin:auto;border:4px solid rgba(128, 128, 128, 0.1);width:80%;height:70%;border-radius:5px;}
.credit-card-box .strip {background:linear-gradient(135deg, #404040, #1a1a1a);position:absolute;width:100%;height:50px;top:30px;left:0;}
.credit-card-box .number {}
.credit-card-box label {}
.credit-card-box .card-expiration-date {}


.the-most {position:fixed;z-index:1;bottom:0;left:0;width:50vw;max-width:200px;padding:10px;}
.the-most img {max-width:100%;}

.merchant_logo {position:relative;top:13px;left:5px;margin-bottom:24px;text-align:center;}
.merchant_logo img {height: 70px;}
.submit_div {padding: 0px 0px;height:auto;}

<? if(isset($data['re_post'])&&$data['re_post']){?>
.merchant_logo {position: relative;top:-10px;margin-bottom:-5px;text-align: center;}
<? } ?>

.translateDiv{ max-width:200px;}

#google_translate_element {float:right;display:block;overflow:hidden;height:30px; border:0 !important; }


#google_translate_element select {
    content: ''; 
    -moz-appearance: menulist;
    background: var(--color-3);
    height: 23px;
}
			

#google_translate_element select:focus {outline: unset !important;}
.skiptranslate iframe {display:none !important;}
			


body, .container-fluid.fixed {border:0px solid #dddddd;}
div.processall {}
.totalHolder {position:relative;display:table-cell;background: <?=$s_background_g;?>;color:<?=$s_color_g;?>;text-align: left;margin: 0 10px 0 0;line-height:250%;vertical-align:top;}
.title_2 {color:#fff !important;}
.totalHolder .b {text-align: left;color: <?=$_SESSION['background_gl7'];?>;margin: 10px 0 0 0;}
.totalHolder .txts {font-size: 20px;padding: 0 0 8px 0;margin: 0 0 7px 0;}
.totalHolder .txts.pro {max-height:100px;overflow:hidden;}
.dark1 {position:absolute;bottom:0;background: <?=$_SESSION['background_gd7'];?>;color: #fff;text-align: right;float: left;width: 100%;height: inherit;line-height: 230%;}
.amount_total {font-size: 40px !important;}
.pad10 {padding:10px;}
.cardHolder {display:table-cell;background:#fff;}

.ti, .capl {}

.result_view {font-family: Verdana,Tahoma,Trebuchet MS,Arial;font-size: 11px;}

INPUT.submit, .btn-primary {}

.processall TABLE, .processall TR, .processall TD, .processall TH {font-family: Verdana,Tahoma,Trebuchet MS,Arial;font-size: 11px;color: #666;background: none;}

.processall TD.field {padding: 8px;color: #444444;background-color: #F2F4F7;text-align: right;vertical-align: top;font-weight: bolder;}
.processall TD.input {line-height: 22px;background-color: #F2F4F7;vertical-align: top;padding: 4px;}
.processall TD.capl {background: url(<?=$data['Host'];?>/css/customisation/images/bg-headers.png) repeat scroll -50px center transparent;padding: 9px 0px;color: #fff;font-weight: normal;-webkit-border-top-left-radius: 3px;-webkit-border-top-right-radius: 3px;-moz-border-radius-topleft: 3px;-moz-border-radius-topright: 3px;border-top-left-radius: 3px;border-top-right-radius: 3px;font-size: 14px !important;}


.err_tr {padding:0 !important;margin:0 !important;}
.hide{display:none;}
.ctittle {float: left;padding-right: 10px;}
.cname {float:left;clear:both;width:100%;}
.cname .inputype {float:left;white-space: nowrap;margin: 0 12px 0 0;clear: both;}

.cname .inputgroup {float:left;white-space: nowrap;width:100%;}
.cname p {margin-top: 0;margin-bottom: 1px;}
.cname label{font-size:12px;white-space:normal;display:inline-block;line-height:14px;text-align:center;text-overflow:initial;overflow:inherit;width:100%;padding: 3px 2px 0 2px;}

.account_types.active {color:orange !important;}
label.active {/*color:orange !important;*/font-weight:bold;}
input.account_types {padding: 0;margin:0 5px 0 0;float:left;position:relative;height:18px;line-height:30px;min-width:30px;;background:transparent !important;border: 0px solid #CECECE;-moz-box-shadow: 0 0px 0px #E5E5E5 inset;-webkit-box-shadow: 0 0px 0px #E5E5E5 inset;box-shadow: 0 0 0px 0px #E5E5E5 inset;padding: 0;}
.member_pro input.account_types{top:2px;background:transparent;} 
.payment_option {}
.echeck_div, .pay_div {display:none;clear:both;float:left;width:100%;}
.ecol2 {}
.processall {padding:0;}

.processall h4 {}
.pay_div .separator {margin: 0px 0 !important;float: left;width: 100%;height: 6px;}
.form-group {}
INPUT, SELECT, TEXTAREA {border-radius:4px !important;min-width: 98%;}

select, label.input2 {text-align: left;font-size: 13px;color: #333 !important;margin: 0;}
input[type=password] {}



#form-input-errors {display:none; float:left; width:100%; text-align:center; color:red; font-size:12px; margin:10px 0 0 0;}
.transparent {opacity: 0.5;}
.has-error {background:#ff0000;border:1px solid #ff0000;}

.maindiv{  display:block; margin:auto; background:#eeeeee;min-height:250px;}
 .leftdiv{width:46%;float:left;  height:100%; margin-left:5px;}
 .rightdiv{width:46%;float:left;  height:100%}
 
  .p{padding-left: 20px; color:black;}
  .iconnocard{ background:#fff url(images/correctcardplease.png) 98% 6px no-repeat;background-size:8%; float:left; border: 1px solid #b80922 !important;}
 
   #credit_cards #jcb1{height:80px;position:relative;top:-17px;margin:0 0 -32px 0;}
  .align{ margin-top:132px;}
  
  .p0 {padding: 0;}
  .ecol4 {}

#state_input_divid select, .country_listdiv select {}
body #card-number-field input[type="text"], body #card-number-field input[type="tel"]{}
body #expMonth option[disabled] {
	background: <?=$_SESSION['background_gd8'];?> !important;background-color: <?=$_SESSION['background_gd8'];?> !important;color:#fff !important;
}

body #expYear option[disabled] {
	background: <?=$_SESSION['background_gd8'];?> !important;background-color: <?=$_SESSION['background_gd8'];?> !important;color:#fff !important;
}


select:focus, input[type="file"]:focus, input[type="radio"]:focus, input[type="checkbox"]:focus {}




.checkOutOptions .glyphicons.btn-icon.next i:before {width:36px;height:33px;padding:23px 0 0;}
.checkOutOptions .contitxt {width:87%;float:right;padding:0;text-align:center;position:relative;top:5px;}
.checkOutOptions .submit_div{margin-bottom:10px;}

.upisDiv img {height:30px;display:inline-block;line-height:50px;vertical-align:middle;width:auto;margin:11px auto 0 auto;}
.upisDiv.active {background:#fff;color:#000; border:1px solid <?=$_SESSION['background_gd5'];?>; }

.banksDiv.active, .walletsDiv.active {background:<?=$_SESSION['background_gd5'];?>;color:#fff;}
.banksDiv, .walletsDiv, .upisDiv {/*width:46%;*/line-height:40px;/*border:1px solid #ccc;border-radius:3px;*/float:left;/*margin:5px 13px 10px 0;*/cursor:pointer; padding-left:8px}	
.bankNm{padding-left:16px;font-size:16px;/*text-transform:uppercase;*/}
.banks_bank_1, .banks_sprite {background-image:url(<?=$data['Host']?>/images/banks-sprite.png);width:32px;display:inline-block;line-height:50px;position:relative;top:-2px;}
.sprite .imgs{display:block;margin:5px auto 2px;width:100%;float:left}
.sprite .imgs img {display:block;margin:0px auto;height:40px;}
.sprite .bankNm{display:block;width:96%;float:left;padding:0 5px;font-size:14px;letter-spacing:normal;line-height:normal;margin:3px 0 0;white-space:nowrap;text-overflow:ellipsis;overflow:hidden}
.banksDiv.sprite{height: 75px;}
.banks_bank_1 {background-position:0 -42px;height:31px; margin-left:0px;}
.banks_bank_2 {background-position:-32px 0;height:38px;}
.banks_bank_3 {background-position:-64px 0;height:33px;}
.banks_bank_4 {background-position:-96px -29px;height:29px;}
.banks_bank_5 {background-position:0 -73px;height:28px;}
.banks_bank_6 {background-position:-64px -42px;height:31px;}

body .w93p {width:97%!important;min-width:97% !important;float:none;display:block;margin:10px auto;height:36px;line-height:36px;}
.change img {height:22px;vertical-align:middle;line-height30px;margin:0 10px 0 0;}
.change{display:none;}

.cname .inputype.the_icon.active {background:var(--color-4);/*color:#fff;*/display:block;}
.cname .inputype.the_icon {}

.icon_the_pay img{height:16px;}

.card_icon_pay{clear:both;width:100%;text-align:center;margin:3px 0 1px}
.card_icon_pay img{clear:both;height:22px;display:inline-block;margin:0 -2px}
.the_icon.active .card_icon_pay img {opacity:0.1;}




.input_key_div{display:block;width:100%;clear:both;padding:7px 0}

.credit-card-box .number{left:5px;top:78px;}
	
.number .key_input{width:17px !important;min-width:17px;height:38px;outline:none !important;padding:0 0px;text-align:center;font-size:24px;letter-spacing:normal;font-weight:bold;border-radius:5px !important;border:1px solid #9d9d9d;display:inline-block;float:left;position:relative;z-index:9999;margin:0px 0px}

.number .key_input.bri{background:#dddddd;}

.number .key_input.lgt {margin:0 0px 0 0 !important;}
.number .key_input.rgt {margin:0 0 0 8px !important;}

.mh360X {min-height:360px;}
.mh114X {min-height:114px;}
.bAdd {margin:2px 0 10px 0;}


@media (max-width:1049px){
	.ctittle {width:60px;white-space:nowrap;padding-right: 0px;}
	.ecol2,.ecol4{float:left;width:100%;margin:0 0 5px 0;}
	.cname .inputgroup {float:left;}
	div.processall {}
	.totalHolder {}
	.cardHolder {}
	.totalHolder .txts.pro {max-height:inherit;}
	.dark1 {position:relative;}
	
	.members.processall #credit_cards img {
		width: 23.6% !important;
	}
	.merchant_logo{position:relative;top:21px;margin-bottom:14px;text-align:center;}
	
	.totalHolder .b {margin: 0;width:auto;float:left;}
	.totalHolder .txts {font-size: 20px;padding: 0 0 0px 0;margin: 0;}
	.title_2 {display:none;}
	.totalHolder .txts{text-align: left;}
	.totalHolder .b {text-align: right;width: 32%;padding: 0 10px 0 0;}
	.bAdd {float:left;font-size:12px !important;font-weight:bold !important;}
	
    .translateDiv{top:0;margin:20px 0 0 0;}
	.mh360 {min-height:auto;}
	.mh114 {min-height:auto;}
}
@media (max-width: 999px){
	.modal_msg_body {
		left: 50%;
		top: 50% !important;
		margin: -100px 0 0 -151px;
	}

}
@media (max-width: 768px){
	#MainDivvkg .col-sm-6 {
		flex: 0 0 auto !important;
		width: 100% !important;
	}
}
@media (max-width:450px){ 
	.ecol4{width:100%;padding:0;}
}

@media (max-width:350px){ 
.number .key_input {width: 15px !important;min-width: 15px !important;font-size: 18px !important; }
}
</style>
  <style>
	.merchantLogo {/*position: relative;text-align: center;*/}
	.company {font-weight:bold;font-size:26px;text-align: center;color:<?=$s_color_g;?>;}
	.payingTo {font-size:14px;font-weight:normal;position:absolute;color:#959595;/*text-transform:uppercase*/;}
	.step_1 label {display:none;}
	.capc {background: transparent !important;}
	<? //if($post['step']==1||$data['con_name']=='clk'){?>
		.content_top {max-width: 700px;margin: auto;
    /*width:555px;margin-top: 10px; margin-bottom: 10px; margin-left: auto; margin-right: auto;*/}
		.border_con {/*border: 1px solid <?=$s_background_g;?>; border-radius: 5px 5px 0 0;*/}
	<? //} ?>
</style>


  <div class="processall container my-2">
    <div class="content_top" style="">
      <div class="capl hide bg-white" colspan="2" style="">
	  
        <h4>Paying To: <?=(isset($theme_color)?$theme_color:'');?> </h4>

        <? if(isset($_SESSION['merchant_logo'])&&$_SESSION['merchant_logo']){?>
        <div class="col-sm-12 text-center"><img src="<?=($_SESSION['merchant_logo']);?>" class="img-fluid" alt="Logo" style="max-width: 100px;"/> </div>
        <? } ?>
        <h4><?=prntext($_SESSION['info_data']['company'])?></h4>
        
      </div>
	  
      <div class="border_con border rounded rounded-payment px-0 m-2" >
    
<?
if(isset($_SESSION['action'])&&$_SESSION['action']=="vt"){
	$heading_1="VIRTUAL TERMINAL";
}else{
	$heading_1="BILLING INFORMATION";
}

?>

<? if($post['step']==2 || $post['step']==1){
$c_style2=''; 
?>
        <? if(isset($_SESSION['re_post']['failed_reason'])){
		$c_style2='style="display:none;"'; 
		//$_SESSION['re_post']['failed_reason']='Do Not Honor Payment Failed.';
	 ?>
        <script language="javascript" type="text/javascript"> 
		window.opener.close();
	 </script>
        <div class="col-sm-12 text-center py-2 alertPaymentDiv bg-vlight box-shadow"> 
		  <div class="show my-2 fs-5" role="alert">Payment Failed</div>
           
		   
		  <div class="col-sm-12 text-center px-2"> 
		<i class="<?=$data['fwicon']['circle-info'];?> fa-6x text-danger"></i>
         </div> 
          <div class="timerText text-center" >Payment Complete before the end of minutes : <span id="timer1" class="timer text-loader" style="">05:00</span></div>
          <a class="nopopup tryAgain btn btn-icon btn-primary my-2" ><i class="<?=$data['fwicon']['check-circle'];?>"></i> Try Again</a> 
		  <a title="<? if(isset($_SESSION['http_referer'])) echo $_SESSION['http_referer'];?>" class="nopopup merchantPage1 btn btn-icon btn-primary my-2" href="<? if(isset($_SESSION['http_referer'])) echo $_SESSION['http_referer'];?>" ><i class="<?=$data['fwicon']['back'];?>"></i> Go Back </a> 
		  
		  </div>
        <? } ?>
		
		
        <div id="MainDivvkg" class="row slidePaymentDiv" <?=$c_style2;?> >
          <? if($_SESSION['action']!="vt"){?>
          <div class="col-sm-6 bg-vlight px-2 rounded-payment">
		    <div class="row">
            <? if(isset($data['re_post'])&&$data['re_post']){?>
            <div class="translateDiv col-sm-12 m-0 bg-vlight ms-2">
			<i class="<?=$data['fwicon']['language'];?>  mx-2 language-collapse" title="Change language" style="margin-top:2px;font-size: 28px;"></i>
              <div id="google_translate_element" style="display:none;"></div>
              <script language="javascript" type="text/javascript"> 
			  function googleTranslateElementInit() {
			  new google.translate.TranslateElement({pageLanguage: 'en'}, 'google_translate_element');
			  }
			</script>
              <script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
              <? //setcookie('googtrans', '/en/hi');?>
              <? 
				if(isset($_SESSION['post']['checkout_language'])){
					setcookie('googtrans', '/en/'.$_SESSION['post']['checkout_language']);
				}
			?>
              
            </div>
            <? } ?>
			<!--// for display logo in left side-->
            <?php /*?><? if(isset($_SESSION['merchant_logo'])&&$_SESSION['merchant_logo']){?>
            <div class="merchantLogo text-center"> <img src="<?=($_SESSION['merchant_logo']);?>" class="img-fluid" alt="Logo" style="max-height:50px;"  /> </div>
            
			<? }elseif(isset($data['ADMIN_LOGO'])&&$data['ADMIN_LOGO']){ ?>
				<div class="merchantLogo text-center"> <img 222 src="<?=encode_imgf($data['ADMIN_LOGO']);?>"  class="img-fluid" alt="Logo" style="max-height:50px;" /> </div>
				
			<? }elseif(isset($_SESSION['domain_server']['LOGO'])&&$_SESSION['domain_server']['LOGO']){ ?>
				<div class="merchantLogo text-center"> <img 333 src="<?=($_SESSION['domain_server']['LOGO']);?>"  class="img-fluid" alt="Logo" style="max-height:50px;" /> </div>
			<? } ?><?php */?>
			
			
			</div>
			
            <div class="col-sm-12  row" v100>
				<div class="address">

<div class="text-center">
<!--<p class="text-center fw-bold my-2" style="font-size:18px;"><?=prntext($post['product'])?></p>-->
<!--!!------------!!-->
<div title="Server Time" id="jqclock" class="jqclock clocktime fw-light mx-2 text-center px-2 mb-1" data-time="<?php echo time(); ?>"></div>

<p class="text-center fw-bold my-2">Make a payment to <?=prntext($_SESSION['info_data']['company'])?></p>
<p class="shadow-none p-2 bg-light rounded fs-5"><?=$post['curr']?$post['curr']:$_SESSION['curr'];?> <?=($post['total']?$post['total']:$post['price'])?></p>

							
<div class="inputWithcheck mx-2"> <input class="form-control w-100 border border-2" style="background-color: #ffffff !important;width: 100% !important;" type="hidden" value="Pay <?=get_currency($post['curr']?$post['curr']:$_SESSION['curr']);?> <?=($post['total']?$post['total']:$post['price'])?> to <?=prntext($_SESSION['info_data']['company'])?>" readonly="">  </div>
                           
                        </div>
						
<?php
$border="";
$disp="none";
if((isset($post['fullname']))&&($post['fullname']) || (isset($post['bill_name']))&&($post['bill_name'])){ 
$border="border88";
$disp="";
}
?>
						
		<div class="row <?=$border;?> rounded m-2 p-2 text-start">
		
			
				
					<div style="display:<?=$disp;?>">
					<? if((isset($post['fullname']))&&($post['fullname'])){ ?><i class="<?=$data['fwicon']['profile'];?> px-1 fa-fw"></i> <?=($post['fullname']);?>
					<? }else{ ?>
						<i class="<?=$data['fwicon']['profile'];?> px-1 fa-fw"></i> <?=(isset($post['bill_name'])&&$post['bill_name']?prntext($post['bill_name']).', ':' ');?>
					<? } ?>
					</div>
					
					
<? if((isset($post['email']))&&($post['email'])){ ?>					
<div>
<?=(isset($post['email'])&&$post['email']?'<i class="'.$data['fwicon']['email'].' px-1 fa-fw"></i> '.$post['email'].'':'');?></div>
<? } ?>					
<? if((isset($post['bill_phone']))&&($post['bill_phone'])){ ?>					
<div>
<?=(isset($post['bill_phone'])&&$post['bill_phone']?'<i class="'.$data['fwicon']['mobile'].' px-1 fa-fw"></i> '.$post['bill_phone'].', ':' ');?>
</div>
<? } ?>						
					
			
					
		<?php /*?><h4 class="row my-2 text-start">Billing Address:</h4> <?php */?>
				
				
                    
					<?
					if(!isset($post['bill_full_address'])) $post['bill_full_address']='';

					$post['bill_full_address'].=(isset($post['bill_address'])&&$post['bill_address']?prntext($post['bill_address']).', ':' ');?>
					<? $post['bill_full_address'].=(isset($post['bill_city'])&&$post['bill_city']?prntext($post['bill_city']).', ':' ');?>
					<? $post['bill_full_address'].=(isset($post['bill_state'])&&$post['bill_state']?prntext($post['bill_state']).', ':' ');?>
					
					
<!--<i class="<?=$data['fwicon']['user-list'];?> p-1 fa-fw"></i>&nbsp;-->
<span class="my-2">

					<?=($post['bill_full_address']?prntext($post['bill_full_address']).'':' ');?>
					<?=(isset($post['country_two'])&&$post['country_two']?''.prntext($post['country_two']).' ':' ');?>
					<?=(isset($post['bill_zip'])&&$post['bill_zip']?' - '.prntext($post['bill_zip']).', ':' ');?>
</span>					
						
		</div>
		
                        <div class="d-flex flex-column dis px-2"></div>
                           
                        
                    </div>
            </div>
            
          </div>
          <? } ?>
          <div class="col-sm-6 rounded px-2 mb-2" <?=(isset($c_style)?$c_style:'');?>>
		  


<? if(isset($_SESSION['re_post']['return_failed_url'])&&$_SESSION['re_post']['return_failed_url']){?>
<div class="timerText p-1 text-end" >Payment Complete before the end of minutes : <span id="timer2" class="timer text-loader" style="">05:00</span></div>
<? } ?>
		  

				
<? if(isset($post['chooseStore'])&&$post['chooseStore']){?>
	<div class="col-sm-12 px-2">
	  <label class="col-sm-12 p-2"><strong>Choose Website Type</strong></label>
	  <select name="storeType" id="storeType" class="form-select" >
		<option value="" selected="selected">Website Type</option>
		<? foreach($post['allStore'] as $key=>$val){?>
		<option data-title="<?=$val['id']?>" value="<?=$val['api_token']?>" >
		<?=$val['bussiness_url']?>
		<? if($data['localhosts']==true){?>|<?=$val['name']?>:<?=$val['api_token']?><? } ?>
		</option>
		<? } ?>
	  </select>
	  <div style="clear:both;width:100%;height:10px;margin:10px 0;"></div>
	</div>
<? }elseif($post['step']==1){?>

<div class="row roubded text-start vkg">

			<? if($post['status_mem']!=0 && $post['status_mem']!=1 && $domain_match!="no" ){ ?>
              <form method="post" id="validateformid" onSubmit="return validateThisForm(this)" class="needs-validation was-validated" novalidate="">
                <div style="display:none">
                  <input type="hidden" name="step" value="<?=$post['step']?>">
                  <input type="hidden" name="bussiness_url" value="<?=(isset($post['bussiness_url'])?$post['bussiness_url']:'');?>"/>
                  <input type="hidden" name="status" value="<?=(isset($post['status_mem'])&&$post['status_mem']?$post['status_mem']:(isset($post['status'])?$post['status']:''));?>"/>
                  <input type="hidden" name="aurl" value="<?=(isset($post['aurl'])?$post['aurl']:'')?>"/>
                  <input type="hidden" name="midcard" value="<?=(isset($post['midcard'])?$post['midcard']:'');?>"/>
                  <input type="hidden" name="bill_country_name" id="bill_country_name" value="<?=(isset($post['bill_country_name'])?$post['bill_country_name']:'');?>"/>
                  <input type='hidden' name='member' value="<?=(isset($post['member'])?$post['member']:'');?>"/>
                  <input type='hidden' name='bid' value="<?=(isset($post['bid'])?$post['bid']:'');?>" />
                  <input type="hidden" name="cc_payment_mode" value="CC Payment" />
                  <input type="hidden" name="payment"  value="creditcard"  />
                </div>
                <div id="card" class="showfp text-center" style="max-width:500px;margin:auto;">
                  <? if(isset($_SESSION['action'])&&$_SESSION['action']=="vt" && isset($post['actionurl'])&&$post['actionurl']=="success"){?>
                  <div class="alert alert-secondary" role="alert"> <a href='<?=$data['Host'];?>/processall<?=$data['ex']?>?action=vt' type="button" class="close" data-dismiss="alert">&times;</a> <strong>Payment Successful! Transaction Id: <?=$_SESSION['transaction_id'];?>
                    and Price: <?=$_SESSION['price'];?> </strong> <br/>
                    <? if(isset($_SESSION['scrubbed_msg'])&&!empty($_SESSION['scrubbed_msg'])){?>
                    Transaction has been Scrubbed <?=$_SESSION['scrubbed_msg'];?>
                    <? } ?>
                  </div>
                  <? exit; } ?>
                  <? if(isset($_SESSION['action'])&&$_SESSION['action']=="vt" && isset($post['actionurl'])&&$post['actionurl']=="failed"){?>
                  <div class="alert alert-success"  role="alert"> <a href='<?=$data['Host'];?>/processall<?=$data['ex']?>?action=vt' type="button" class="close" data-dismiss="alert">&times;</a> <strong>Payment Failed.</strong>
                    <? if(isset($post['reason'])) echo $post['reason'];?>
                    <em>Sorry, your card issuer declined the transaction.</em> <br/>
                  </div>
                  <? exit;} ?>
				  
				<?php /*?><div class="alert alert-danger" role="alert"><?=prntext($data['Error'])?></div><?php */?>
				  
<?php /*?><div class="toast align-items-center text-message w-75 ms-2 toast-box show" role="alert" aria-live="assertive" aria-atomic="true" id="myToast">
  <div class="d-flex">
    <div class="toast-body">Missing required filled<? //=prntext($data['Error'])?></div>
    <button type="button" class="btn-close btn-close-white me-2 m-auto" onclick="toastclose('.toast')" data-bs-dismiss="toast" aria-label="Close"></button>
  </div>
</div><?php */?>

<? if(isset($_SESSION['merchant_logo'])&&$_SESSION['merchant_logo']){?>
            <div class="merchantLogo text-center mt-1"> <img src="<?=($_SESSION['merchant_logo']);?>" class="img-fluid" alt="Logo" style="max-height:50px;"  /> </div>
            
			<? }elseif(isset($data['ADMIN_LOGO'])&&$data['ADMIN_LOGO']){ ?>
				<div class="merchantLogo text-center mt-1"> <img 222 src="<?=encode_imgf($data['ADMIN_LOGO']);?>"  class="img-fluid" alt="Logo" style="max-height:50px;" /> </div>
				
			<? }elseif(isset($_SESSION['domain_server']['LOGO'])&&$_SESSION['domain_server']['LOGO']){ ?>
				<div class="merchantLogo text-center mt-1"> <img 333 src="<?=($_SESSION['domain_server']['LOGO']);?>"  class="img-fluid" alt="Logo" style="max-height:50px;" /> </div>
			<? } ?>
<? if(isset($post['product_name'])&&$post['product_name']){ ?>			
<p class="text-center fw-bold my-2" style="font-size:16px;">Payment for <?=$post['product_name'];?></p>
<? } ?>				  
				  
				  <div class='hide' id='form-input-errors'> </div>
                  
				<div class="step_1 my-2">
					<div style="clear:both;width:100%;float:left;">
					<?
						if(isset($post['product_name'])&&$post['product_name']){
							$post['product']=$post['product_name'];
						}
						if(!isset($post['price'])||empty($post['price'])||$post['price']=="0.00"){
							unset($post['price']);
							$post['price']='';
						}
						?>
                          <? if(empty($post['price'])||$post['price']=="0.00"){?>
                          <div class="ecol4">
                            <label style="font-weight:normal;padding-left:3px;">Price</label>
                            <input type="text" name="price" placeholder='Price' value="<?=$post['price']?>" required/>
                          </div>
                          <? } ?>
                        </div>
                        
                        <div id="contact_customer" class="row">
			<?
					if(isset($_SESSION['post_step0'])&&$_SESSION['post_step0']){
					echo $common_inputs_stp1 .="
					<div style=display:none>
					<input type='text' name='post_step0' value='".json_encode($_SESSION['post_step0'])."'>
					</div>"; 
					}
			?>
                          
                            <? if(!isset($post['product'])||empty($post['product'])){?>
							<div class="ecol4 col-sm-12 my-1">
                            <?php /*?><label style="font-weight:normal;padding-left:3px;">Purpose of Payment</label><?php */?>
                            <input type='text' name="product" placeholder='Purpose of Payment' class="form-control" value='<?=prntext($post['product']);?>'></div>
                            <? } ?>
<? if(!isset($post['fullname'])||empty($post['fullname'])){?>
<div class="ecol col-sm-12 my-1">
<input placeholder='Full Name' type='text' name='fullname' id="validationCustom01" class="form-control" value='<?=prntext($post['fullname']);?>' title="Enter your full name" data-bs-toggle="tooltip" data-bs-placement="bottom" required>
</div>
<? }else{ ?>
<input placeholder='Full Name' type='hidden' name='fullname' value='<?=prntext($post['fullname']);?>' required  >
<? } ?>

<? if(!isset($post['email'])||empty($post['email'])){?>
<div class="ecol4 col-sm-12 my-1">

<input placeholder="Email ID" type="email" name="email" class="form-control" value="<?=prntext($post['email']);?>" title="Enter your email id" data-bs-toggle="tooltip" data-bs-placement="bottom" required>
</div>
<? }else{ ?>
<input placeholder="Email ID" type="hidden" name="email" value="<?=prntext($post['email']);?>" required  >
<? } ?>
<? if(!isset($post['bill_phone'])||empty($post['bill_phone'])){?>
<div class="ecol4 col-sm-12 my-1">
<input placeholder="Phone" type="text" name="bill_phone" class="form-control" value="<?=prntext($post['bill_phone']);?>" title="Enter your phone number" data-bs-toggle="tooltip" data-bs-placement="bottom" required>
</div>
<? }else{ ?>
<input placeholder="Phone" type="hidden" name="bill_phone" value="<?=prntext($post['bill_phone']);?>" required>
<? } ?>
<? if(!isset($post['bill_street_1'])||empty($post['bill_street_1'])){?>
<div class="ecol4 col-sm-12 my-1">
<input placeholder="Street 1" type="text" name="bill_street_1" class="form-control" value="<?=prntext($post['bill_street_1']);?>" title="Enter your address street 1" data-bs-toggle="tooltip" data-bs-placement="bottom" required>
</div>
<? }else{ ?>
<input placeholder="Street 1" type="hidden" name="bill_street_1" value="<?=prntext($post['bill_street_1']);?>">
<? } ?>
<? if(!isset($post['bill_street_2'])||empty($post['bill_street_2'])){?>
<div class="ecol4 col-sm-12 my-1">
<input placeholder="Street 2" type="text" name="bill_street_2" class="form-control" value="<?=prntext($post['bill_street_2']);?>" title="Enter your address street 2" data-bs-toggle="tooltip" data-bs-placement="bottom" >
</div>
<? }else{ ?>
<input placeholder="Street 2" type="hidden" name="bill_street_2" value="<?=prntext($post['bill_street_2']);?>">
<? } ?>
<? if(!isset($post['bill_country'])||empty($post['bill_country'])){?>
<div class="ecol4 col-sm-12 my-1 country_listdiv">
<select name="bill_country" class="form-select" id="country_list" autocomplete="false" title="Enter select country" data-bs-toggle="tooltip" data-bs-placement="bottom" required>
                              <option value="" selected="selected">Select Country</option>
                              <option value="AND" data-val="AD_AND_020_Andorra">Andorra</option>
                              <option value="ARE" data-val="AE_ARE_008_United Arab Emirates">United Arab Emirates</option>
                              <option value="AFG" data-val="AF_AFG_010_Afghanistan">Afghanistan</option>
                              <option value="ATG" data-val="AG_ATG_012_Antigua and Barbuda">Antigua and Barbuda</option>
                              <option value="AIA" data-val="AI_AIA_016_Anguilla">Anguilla</option>
                              <option value="ALB" data-val="AL_ALB_024_Albania">Albania</option>
                              <option value="ARM" data-val="AM_ARM_031_Armenia">Armenia</option>
                              <option value="ANT" data-val="AN_ANT_032_Netherlands Antilles">Netherlands Antilles</option>
                              <option value="AGO" data-val="AO_AGO_036_Angola">Angola</option>
                              <option value="ATA" data-val="AQ_ATA_040_Antarctica">Antarctica</option>
                              <option value="ARG" data-val="AR_ARG_044_Argentina">Argentina</option>
                              <option value="ASM" data-val="AS_ASM_048_American Samoa">American Samoa</option>
                              <option value="AUT" data-val="AT_AUT_050_Austria">Austria</option>
                              <option value="AUS" data-val="AU_AUS_051_Australia">Australia</option>
                              <option value="ABW" data-val="AW_ABW_052_Aruba">Aruba</option>
                              <option value="ALA" data-val="AX_ALA_056_ALA Aland Islands">ALA Aland Islands</option>
                              <option value="AZE" data-val="AZ_AZE_060_Azerbaijan">Azerbaijan</option>
                              <option value="BIH" data-val="BA_BIH_064_Bosnia and Herzegovina">Bosnia and Herzegovina</option>
                              <option value="BRB" data-val="BB_BRB_068_Barbados">Barbados</option>
                              <option value="BGD" data-val="BD_BGD_070_Bangladesh">Bangladesh</option>
                              <option value="BEL" data-val="BE_BEL_072_Belgium">Belgium</option>
                              <option value="BFA" data-val="BF_BFA_074_Burkina Faso">Burkina Faso</option>
                              <option value="BGR" data-val="BG_BGR_076_Bulgaria">Bulgaria</option>
                              <option value="BHR" data-val="BH_BHR_084_Bahrain">Bahrain</option>
                              <option value="BDI" data-val="BI_BDI_086_Burundi">Burundi</option>
                              <option value="BEN" data-val="BJ_BEN_090_Benin">Benin</option>
                              <option value="BLM" data-val="BL_BLM_092_Saint-Barthélemy">Saint-Barthélemy</option>
                              <option value="BMU" data-val="BM_BMU_096_Bermuda">Bermuda</option>
                              <option value="BRN" data-val="BN_BRN_100_Brunei Darussalam">Brunei Darussalam</option>
                              <option value="BOL" data-val="BO_BOL_104_Bolivia">Bolivia</option>
                              <option value="BRA" data-val="BR_BRA_108_Brazil">Brazil</option>
                              <option value="BHS" data-val="BS_BHS_112_Bahamas">Bahamas</option>
                              <option value="BTN" data-val="BT_BTN_116_Bhutan">Bhutan</option>
                              <option value="BVT" data-val="BV_BVT_120_Bouvet Island">Bouvet Island</option>
                              <option value="BWA" data-val="BW_BWA_124_Botswana">Botswana</option>
                              <option value="BLR" data-val="BY_BLR_132_Belarus">Belarus</option>
                              <option value="BLZ" data-val="BZ_BLZ_136_Belize">Belize</option>
                              <option value="CAN" data-val="CA_CAN_140_Canada">Canada</option>
                              <option value="CCK" data-val="CC_CCK_144_Cocos (Keeling) Islands">Cocos (Keeling) Islands</option>
                              <option value="COD" data-val="CD_COD_148_Congo, (Kinshasa)">Congo, (Kinshasa)</option>
                              <option value="CAF" data-val="CF_CAF_152_Central African Republic">Central African Republic</option>
                              <option value="COG" data-val="CG_COG_156_Congo (Brazzaville)">Congo (Brazzaville)</option>
                              <option value="CHE" data-val="CH_CHE_158_Switzerland">Switzerland</option>
                              <option value="CIV" data-val="CI_CIV_162_Côte d'Ivoire">Côte d'Ivoire</option>
                              <option value="COK" data-val="CK_COK_166_Cook Islands">Cook Islands</option>
                              <option value="CHL" data-val="CL_CHL_170_Chile">Chile</option>
                              <option value="CMR" data-val="CM_CMR_174_Cameroon">Cameroon</option>
                              <option value="CHN" data-val="CN_CHN_175_China">China</option>
                              <option value="COL" data-val="CO_COL_178_Colombia">Colombia</option>
                              <option value="CRI" data-val="CR_CRI_180_Costa Rica">Costa Rica</option>
                              <option value="CUB" data-val="CU_CUB_184_Cuba">Cuba</option>
                              <option value="CPV" data-val="CV_CPV_188_Cape Verde">Cape Verde</option>
                              <option value="CXR" data-val="CX_CXR_191_Christmas Island">Christmas Island</option>
                              <option value="CYP" data-val="CY_CYP_192_Cyprus">Cyprus</option>
                              <option value="CZE" data-val="CZ_CZE_196_Czech Republic">Czech Republic</option>
                              <option value="DEU" data-val="DE_DEU_203_Germany">Germany</option>
                              <option value="DJI" data-val="DJ_DJI_204_Djibouti">Djibouti</option>
                              <option value="DNK" data-val="DK_DNK_208_Denmark">Denmark</option>
                              <option value="DMA" data-val="DM_DMA_212_Dominica">Dominica</option>
                              <option value="DOM" data-val="DO_DOM_214_Dominican Republic">Dominican Republic</option>
                              <option value="DZA" data-val="DZ_DZA_218_Algeria">Algeria</option>
                              <option value="ECU" data-val="EC_ECU_222_Ecuador">Ecuador</option>
                              <option value="EST" data-val="EE_EST_226_Estonia">Estonia</option>
                              <option value="EGY" data-val="EG_EGY_231_Egypt">Egypt</option>
                              <option value="ESH" data-val="EH_ESH_232_Western Sahara">Western Sahara</option>
                              <option value="ERI" data-val="ER_ERI_233_Eritrea">Eritrea</option>
                              <option value="ESP" data-val="ES_ESP_234_Spain">Spain</option>
                              <option value="ETH" data-val="ET_ETH_238_Ethiopia">Ethiopia</option>
                              <option value="FIN" data-val="FI_FIN_239_Finland">Finland</option>
                              <option value="FJI" data-val="FJ_FJI_242_Fiji">Fiji</option>
                              <option value="FLK" data-val="FK_FLK_246_Falkland Islands (Malvinas)">Falkland Islands (Malvinas)</option>
                              <option value="FSM" data-val="FM_FSM_248_Micronesia, Federated States of">Micronesia, Federated States of</option>
                              <option value="FRO" data-val="FO_FRO_250_Faroe Islands">Faroe Islands</option>
                              <option value="FRA" data-val="FR_FRA_254_France">France</option>
                              <option value="GAB" data-val="GA_GAB_258_Gabon">Gabon</option>
                              <option value="GBR" data-val="GB_GBR_260_United Kingdom">United Kingdom</option>
                              <option value="GRD" data-val="GD_GRD_262_Grenada">Grenada</option>
                              <option value="GEO" data-val="GE_GEO_266_Georgia">Georgia</option>
                              <option value="GUF" data-val="GF_GUF_268_French Guiana">French Guiana</option>
                              <option value="GGY" data-val="GG_GGY_270_Guernsey">Guernsey</option>
                              <option value="GHA" data-val="GH_GHA_275_Ghana">Ghana</option>
                              <option value="GIB" data-val="GI_GIB_276_Gibraltar">Gibraltar</option>
                              <option value="GRL" data-val="GL_GRL_288_Greenland">Greenland</option>
                              <option value="GMB" data-val="GM_GMB_292_Gambia">Gambia</option>
                              <option value="GIN" data-val="GN_GIN_296_Guinea">Guinea</option>
                              <option value="GLP" data-val="GP_GLP_300_Guadeloupe">Guadeloupe</option>
                              <option value="GNQ" data-val="GQ_GNQ_304_Equatorial Guinea">Equatorial Guinea</option>
                              <option value="GRC" data-val="GR_GRC_308_Greece">Greece</option>
                              <option value="SGS" data-val="GS_SGS_312_South Georgia and the South Sandwich Islands">South Georgia and the South Sandwich Islands</option>
                              <option value="GTM" data-val="GT_GTM_316_Guatemala">Guatemala</option>
                              <option value="GUM" data-val="GU_GUM_320_Guam">Guam</option>
                              <option value="GNB" data-val="GW_GNB_324_Guinea-Bissau">Guinea-Bissau</option>
                              <option value="GUY" data-val="GY_GUY_328_Guyana">Guyana</option>
                              <option value="HKG" data-val="HK_HKG_332_Hong Kong, SAR China">Hong Kong, SAR China</option>
                              <option value="HMD" data-val="HM_HMD_334_Heard and Mcdonald Islands">Heard and Mcdonald Islands</option>
                              <option value="HND" data-val="HN_HND_336_Honduras">Honduras</option>
                              <option value="HRV" data-val="HR_HRV_340_Croatia">Croatia</option>
                              <option value="HTI" data-val="HT_HTI_344_Haiti">Haiti</option>
                              <option value="HUN" data-val="HU_HUN_348_Hungary">Hungary</option>
                              <option value="IDN" data-val="ID_IDN_352_Indonesia">Indonesia</option>
                              <option value="IRL" data-val="IE_IRL_356_Ireland">Ireland</option>
                              <option value="ISR" data-val="IL_ISR_360_Israel">Israel</option>
                              <option value="IMN" data-val="IM_IMN_364_Isle of Man">Isle of Man</option>
                              <option value="IND" data-val="IN_IND_368_India">India</option>
                              <option value="IOT" data-val="IO_IOT_372_British Indian Ocean Territory">British Indian Ocean Territory</option>
                              <option value="IRQ" data-val="IQ_IRQ_376_Iraq">Iraq</option>
                              <option value="IRN" data-val="IR_IRN_380_Iran, Islamic Republic of">Iran, Islamic Republic of</option>
                              <option value="ISL" data-val="IS_ISL_384_Iceland">Iceland</option>
                              <option value="ITA" data-val="IT_ITA_388_Italy">Italy</option>
                              <option value="JEY" data-val="JE_JEY_392_Jersey">Jersey</option>
                              <option value="JAM" data-val="JM_JAM_398_Jamaica">Jamaica</option>
                              <option value="JOR" data-val="JO_JOR_400_Jordan">Jordan</option>
                              <option value="JPN" data-val="JP_JPN_404_Japan">Japan</option>
                              <option value="KEN" data-val="KE_KEN_408_Kenya">Kenya</option>
                              <option value="KGZ" data-val="KG_KGZ_410_Kyrgyzstan">Kyrgyzstan</option>
                              <option value="KHM" data-val="KH_KHM_414_Cambodia">Cambodia</option>
                              <option value="KIR" data-val="KI_KIR_417_Kiribati">Kiribati</option>
                              <option value="COM" data-val="KM_COM_418_Comoros">Comoros</option>
                              <option value="KNA" data-val="KN_KNA_422_Saint Kitts and Nevis">Saint Kitts and Nevis</option>
                              <option value="PRK" data-val="KP_PRK_426_Korea (North)">Korea (North)</option>
                              <option value="KOR" data-val="KR_KOR_428_Korea (South)">Korea (South)</option>
                              <option value="KWT" data-val="KW_KWT_430_Kuwait">Kuwait</option>
                              <option value="CYM" data-val="KY_CYM_434_Cayman Islands">Cayman Islands</option>
                              <option value="KAZ" data-val="KZ_KAZ_438_Kazakhstan">Kazakhstan</option>
                              <option value="LAO" data-val="LA_LAO_440_Lao PDR">Lao PDR</option>
                              <option value="LBN" data-val="LB_LBN_442_Lebanon">Lebanon</option>
                              <option value="LCA" data-val="LC_LCA_446_Saint Lucia">Saint Lucia</option>
                              <option value="LIE" data-val="LI_LIE_450_Liechtenstein">Liechtenstein</option>
                              <option value="LKA" data-val="LK_LKA_454_Sri Lanka">Sri Lanka</option>
                              <option value="LBR" data-val="LR_LBR_458_Liberia">Liberia</option>
                              <option value="LSO" data-val="LS_LSO_462_Lesotho">Lesotho</option>
                              <option value="LTU" data-val="LT_LTU_466_Lithuania">Lithuania</option>
                              <option value="LUX" data-val="LU_LUX_470_Luxembourg">Luxembourg</option>
                              <option value="LVA" data-val="LV_LVA_474_Latvia">Latvia</option>
                              <option value="LBY" data-val="LY_LBY_478_Libya">Libya</option>
                              <option value="MAR" data-val="MA_MAR_480_Morocco">Morocco</option>
                              <option value="MCO" data-val="MC_MCO_484_Monaco">Monaco</option>
                              <option value="MDA" data-val="MD_MDA_492_Moldova">Moldova</option>
                              <option value="MNE" data-val="ME_MNE_496_Montenegro">Montenegro</option>
                              <option value="MAF" data-val="MF_MAF_498_Saint-Martin (French part)">Saint-Martin (French part)</option>
                              <option value="MDG" data-val="MG_MDG_499_Madagascar">Madagascar</option>
                              <option value="MHL" data-val="MH_MHL_500_Marshall Islands">Marshall Islands</option>
                              <option value="MKD" data-val="MK_MKD_504_Macedonia, Republic of">Macedonia, Republic of</option>
                              <option value="MLI" data-val="ML_MLI_508_Mali">Mali</option>
                              <option value="MMR" data-val="MM_MMR_512_Myanmar">Myanmar</option>
                              <option value="MNG" data-val="MN_MNG_516_Mongolia">Mongolia</option>
                              <option value="MAC" data-val="MO_MAC_520_Macao, SAR China">Macao, SAR China</option>
                              <option value="MNP" data-val="MP_MNP_524_Northern Mariana Islands">Northern Mariana Islands</option>
                              <option value="MTQ" data-val="MQ_MTQ_528_Martinique">Martinique</option>
                              <option value="MRT" data-val="MR_MRT_530_Mauritania">Mauritania</option>
                              <option value="MSR" data-val="MS_MSR_533_Montserrat">Montserrat</option>
                              <option value="MLT" data-val="MT_MLT_540_Malta">Malta</option>
                              <option value="MUS" data-val="MU_MUS_548_Mauritius">Mauritius</option>
                              <option value="MDV" data-val="MV_MDV_554_Maldives">Maldives</option>
                              <option value="MWI" data-val="MW_MWI_558_Malawi">Malawi</option>
                              <option value="MEX" data-val="MX_MEX_562_Mexico">Mexico</option>
                              <option value="MYS" data-val="MY_MYS_566_Malaysia">Malaysia</option>
                              <option value="MOZ" data-val="MZ_MOZ_570_Mozambique">Mozambique</option>
                              <option value="NAM" data-val="NA_NAM_574_Namibia">Namibia</option>
                              <option value="NCL" data-val="NC_NCL_578_New Caledonia">New Caledonia</option>
                              <option value="NER" data-val="NE_NER_580_Niger">Niger</option>
                              <option value="NFK" data-val="NF_NFK_581_Norfolk Island">Norfolk Island</option>
                              <option value="NGA" data-val="NG_NGA_583_Nigeria">Nigeria</option>
                              <option value="NIC" data-val="NI_NIC_584_Nicaragua">Nicaragua</option>
                              <option value="NLD" data-val="NL_NLD_585_Netherlands">Netherlands</option>
                              <option value="NOR" data-val="NO_NOR_586_Norway">Norway</option>
                              <option value="NPL" data-val="NP_NPL_591_Nepal">Nepal</option>
                              <option value="NRU" data-val="NR_NRU_598_Nauru">Nauru</option>
                              <option value="NIU" data-val="NU_NIU_600_Niue">Niue</option>
                              <option value="NZL" data-val="NZ_NZL_604_New Zealand">New Zealand</option>
                              <option value="OMN" data-val="OM_OMN_608_Oman">Oman</option>
                              <option value="PAN" data-val="PA_PAN_612_Panama">Panama</option>
                              <option value="PER" data-val="PE_PER_616_Peru">Peru</option>
                              <option value="PYF" data-val="PF_PYF_620_French Polynesia">French Polynesia</option>
                              <option value="PNG" data-val="PG_PNG_624_Papua New Guinea">Papua New Guinea</option>
                              <option value="PHL" data-val="PH_PHL_626_Philippines">Philippines</option>
                              <option value="PAK" data-val="PK_PAK_630_Pakistan">Pakistan</option>
                              <option value="POL" data-val="PL_POL_634_Poland">Poland</option>
                              <option value="SPM" data-val="PM_SPM_638_Saint Pierre and Miquelon">Saint Pierre and Miquelon</option>
                              <option value="PCN" data-val="PN_PCN_642_Pitcairn">Pitcairn</option>
                              <option value="PRI" data-val="PR_PRI_643_Puerto Rico">Puerto Rico</option>
                              <option value="PSE" data-val="PS_PSE_646_Palestinian Territory">Palestinian Territory</option>
                              <option value="PRT" data-val="PT_PRT_652_Portugal">Portugal</option>
                              <option value="PLW" data-val="PW_PLW_654_Palau">Palau</option>
                              <option value="PRY" data-val="PY_PRY_659_Paraguay">Paraguay</option>
                              <option value="QAT" data-val="QA_QAT_660_Qatar">Qatar</option>
                              <option value="REU" data-val="RE_REU_662_Réunion">Réunion</option>
                              <option value="ROU" data-val="RO_ROU_663_Romania">Romania</option>
                              <option value="SRB" data-val="RS_SRB_666_Serbia">Serbia</option>
                              <option value="RUS" data-val="RU_RUS_670_Russian Federation">Russian Federation</option>
                              <option value="RWA" data-val="RW_RWA_674_Rwanda">Rwanda</option>
                              <option value="SAU" data-val="SA_SAU_678_Saudi Arabia">Saudi Arabia</option>
                              <option value="SLB" data-val="SB_SLB_682_Solomon Islands">Solomon Islands</option>
                              <option value="SYC" data-val="SC_SYC_686_Seychelles">Seychelles</option>
                              <option value="SDN" data-val="SD_SDN_688_Sudan">Sudan</option>
                              <option value="SWE" data-val="SE_SWE_690_Sweden">Sweden</option>
                              <option value="SGP" data-val="SG_SGP_694_Singapore">Singapore</option>
                              <option value="SHN" data-val="SH_SHN_702_Saint Helena">Saint Helena</option>
                              <option value="SVN" data-val="SI_SVN_703_Slovenia">Slovenia</option>
                              <option value="SJM" data-val="SJ_SJM_704_Svalbard and Jan Mayen Islands">Svalbard and Jan Mayen Islands</option>
                              <option value="SVK" data-val="SK_SVK_705_Slovakia">Slovakia</option>
                              <option value="SLE" data-val="SL_SLE_706_Sierra Leone">Sierra Leone</option>
                              <option value="SMR" data-val="SM_SMR_710_San Marino">San Marino</option>
                              <option value="SEN" data-val="SN_SEN_716_Senegal">Senegal</option>
                              <option value="SOM" data-val="SO_SOM_724_Somalia">Somalia</option>
                              <option value="SUR" data-val="SR_SUR_728_Suriname">Suriname</option>
                              <option value="SSD" data-val="SS_SSD_732_South Sudan">South Sudan</option>
                              <option value="STP" data-val="ST_STP_736_Sao Tome and Principe">Sao Tome and Principe</option>
                              <option value="SLV" data-val="SV_SLV_740_El Salvador">El Salvador</option>
                              <option value="SYR" data-val="SY_SYR_744_Syrian Arab Republic (Syria)">Syrian Arab Republic (Syria)</option>
                              <option value="SWZ" data-val="SZ_SWZ_748_Swaziland">Swaziland</option>
                              <option value="TCA" data-val="TC_TCA_752_Turks and Caicos Islands">Turks and Caicos Islands</option>
                              <option value="TCD" data-val="TD_TCD_756_Chad">Chad</option>
                              <option value="ATF" data-val="TF_ATF_760_French Southern Territories">French Southern Territories</option>
                              <option value="TGO" data-val="TG_TGO_762_Togo">Togo</option>
                              <option value="THA" data-val="TH_THA_764_Thailand">Thailand</option>
                              <option value="TJK" data-val="TJ_TJK_768_Tajikistan">Tajikistan</option>
                              <option value="TKL" data-val="TK_TKL_772_Tokelau">Tokelau</option>
                              <option value="TLS" data-val="TL_TLS_776_Timor-Leste">Timor-Leste</option>
                              <option value="TKM" data-val="TM_TKM_780_Turkmenistan">Turkmenistan</option>
                              <option value="TUN" data-val="TN_TUN_784_Tunisia">Tunisia</option>
                              <option value="TON" data-val="TO_TON_788_Tonga">Tonga</option>
                              <option value="TUR" data-val="TR_TUR_792_Turkey">Turkey</option>
                              <option value="TTO" data-val="TT_TTO_795_Trinidad and Tobago">Trinidad and Tobago</option>
                              <option value="TUV" data-val="TV_TUV_796_Tuvalu">Tuvalu</option>
                              <option value="TWN" data-val="TW_TWN_798_Taiwan, Republic of China">Taiwan, Republic of China</option>
                              <option value="TZA" data-val="TZ_TZA_800_Tanzania, United Republic of">Tanzania, United Republic of</option>
                              <option value="UKR" data-val="UA_UKR_804_Ukraine">Ukraine</option>
                              <option value="UGA" data-val="UG_UGA_807_Uganda">Uganda</option>
                              <option value="UMI" data-val="UM_UMI_818_US Minor Outlying Islands">US Minor Outlying Islands</option>
                              <option value="USA" data-val="US_USA_826_United States of America">United States of America</option>
                              <option value="URY" data-val="UY_URY_831_Uruguay">Uruguay</option>
                              <option value="UZB" data-val="UZ_UZB_832_Uzbekistan">Uzbekistan</option>
                              <option value="VAT" data-val="VA_VAT_833_Holy See (Vatican City State)">Holy See (Vatican City State)</option>
                              <option value="VCT" data-val="VC_VCT_834_Saint Vincent and Grenadines">Saint Vincent and Grenadines</option>
                              <option value="VEN" data-val="VE_VEN_840_Venezuela (Bolivarian Republic)">Venezuela (Bolivarian Republic)</option>
                              <option value="VGB" data-val="VG_VGB_850_British Virgin Islands">British Virgin Islands</option>
                              <option value="VIR" data-val="VI_VIR_854_Virgin Islands, US">Virgin Islands, US</option>
                              <option value="VNM" data-val="VN_VNM_858_Viet Nam">Viet Nam</option>
                              <option value="VUT" data-val="VU_VUT_860_Vanuatu">Vanuatu</option>
                              <option value="WLF" data-val="WF_WLF_862_Wallis and Futuna Islands">Wallis and Futuna Islands</option>
                              <option value="WSM" data-val="WS_WSM_876_Samoa">Samoa</option>
                              <option value="YEM" data-val="YE_YEM_882_Yemen">Yemen</option>
                              <option value="MYT" data-val="YT_MYT_887_Mayotte">Mayotte</option>
                              <option value="ZAF" data-val="ZA_ZAF_894_South Africa">South Africa</option>
                              <option value="ZMB" data-val="ZM_ZMB_004_Zambia">Zambia</option>
                              <option value="ZWE" data-val="ZW_ZWE_028_Zimbabwe">Zimbabwe</option>
                               </select>
</div>
<? }else{ ?>
<input placeholder="Country" type="hidden" name="bill_country" value="<?=prntext($post['bill_country']);?>">
<? } ?>
<? if(!isset($post['bill_state'])||empty($post['bill_state'])){?>
<div class="ecol4 col-sm-12 my-1">
                            <div id="state_input_divid">
     <select name="bill_state" id="state_list" class="form-select" title="Select your state" data-bs-toggle="tooltip" data-bs-placement="bottom" required >
                                <option value="" disabled="disabled" selected="selected">Select State</option>
                                <option value="AF">Afghanistan</option>
                                <option value="AL">Albania</option>
                                <option value="DZ">Algeria</option>
                                <option value="AS">American Samoa</option>
                                <option value="AD">Andorra</option>
                                <option value="AO">Angola</option>
                                <option value="AI">Anguilla</option>
                                <option value="AQ">Antarctica</option>
                                <option value="AG">Antigua And Barbuda</option>
                                <option value="AR">Argentina</option>
                                <option value="AM">Armenia</option>
                                <option value="AW">Aruba</option>
                                <option value="AU">Australia</option>
                                <option value="AT">Austria</option>
                                <option value="AZ">Azerbaijan</option>
                                <option value="BS">Bahamas</option>
                                <option value="BH">Bahrain</option>
                                <option value="BD">Bangladesh</option>
                                <option value="BB">Barbados</option>
                                <option value="BY">Belarus</option>
                                <option value="BE">Belgium</option>

                                <option value="BZ">Belize</option>
                                <option value="BJ">Benin</option>
                                <option value="BM">Bermuda</option>
                                <option value="BT">Bhutan</option>
                                <option value="BO">Bolivia</option>
                                <option value="BA">Bosnia And Herzegowina</option>
                                <option value="BW">Botswana</option>
                                <option value="BV">Bouvet Island</option>
                                <option value="BR">Brazil</option>
                                <option value="IO">British Indian Ocean Territory</option>
                                <option value="BN">Brunei Darussalam</option>
                                <option value="BG">Bulgaria</option>
                                <option value="BF">Burkina Faso</option>
                                <option value="BI">Burundi</option>
                                <option value="KH">Cambodia</option>
                                <option value="CM">Cameroon</option>
                                <option value="CA">Canada</option>
                                <option value="CV">Cape Verde</option>
                                <option value="KY">Cayman Islands</option>
                                <option value="CF">Central African Republic</option>
                                <option value="TD">Chad</option>
                                <option value="CL">Chile</option>
                                <option value="CN">China</option>
                                <option value="CX">Christmas Island</option>
                                <option value="CC">Cocos (Keeling) Islands</option>
                                <option value="CO">Colombia</option>
                                <option value="KM">Comoros</option>
                                <option value="CG">Congo</option>
                                <option value="CK">Cook Islands</option>
                                <option value="CR">Costa Rica</option>
                                <option value="HR">Croatia</option>
                                <option value="CU">Cuba</option>
                                <option value="CY">Cyprus</option>
                                <option value="CZ">Czech Republic</option>
                                <option value="DK">Denmark</option>
                                <option value="DJ">Djibouti</option>
                                <option value="DM">Dominica</option>
                                <option value="DO">Dominican Republic</option>
                                <option value="TL">Timor-Leste</option>
                                <option value="EC">Ecuador</option>
                                <option value="EG">Egypt</option>
                                <option value="SV">El Salvador</option>
                                <option value="GQ">Equatorial Guinea</option>
                                <option value="ER">Eritrea</option>
                                <option value="EE">Estonia</option>
                                <option value="ET">Ethiopia</option>
                                <option value="FK">Falkland Islands (Malvinas)</option>
                                <option value="FO">Faroe Islands</option>
                                <option value="FJ">Fiji</option>
                                <option value="FI">Finland</option>
                                <option value="FR">France</option>
                                <option value="GF">French Guiana</option>
                                <option value="PF">French Polynesia</option>
                                <option value="TF">French Southern Territories</option>
                                <option value="GA">Gabon</option>
                                <option value="GM">Gambia</option>
                                <option value="GE">Georgia</option>
                                <option value="DE">Germany</option>
                                <option value="GH">Ghana</option>
                                <option value="GI">Gibraltar</option>
                                <option value="GR">Greece</option>
                                <option value="GL">Greenland</option>
                                <option value="GD">Grenada</option>
                                <option value="GP">Guadeloupe</option>
                                <option value="GU">Guam</option>
                                <option value="GT">Guatemala</option>
                                <option value="GN">Guinea</option>
                                <option value="GW">Guinea-bissau</option>
                                <option value="GY">Guyana</option>
                                <option value="HT">Haiti</option>
                                <option value="HM">Heard And Mc Donald Islands</option>
                                <option value="HN">Honduras</option>
                                <option value="HK">Hong Kong</option>
                                <option value="HU">Hungary</option>
                                <option value="IS">Iceland</option>
                                <option value="IN">India</option>
                                <option value="ID">Indonesia</option>
                                <option value="IR">Iran</option>
                                <option value="IQ">Iraq</option>
                                <option value="IE">Ireland</option>
                                <option value="IL">Israel</option>
                                <option value="IT">Italy</option>
                                <option value="JM">Jamaica</option>
                                <option value="JP">Japan</option>
                                <option value="JO">Jordan</option>
                                <option value="KZ">Kazakhstan</option>
                                <option value="KE">Kenya</option>
                                <option value="KI">Kiribati</option>
                                <option value="KP">Korea</option>
                                <option value="KR">Republic Of Korea</option>
                                <option value="KW">Kuwait</option>
                                <option value="KG">Kyrgyzstan</option>
                                <option value="LA">Lao</option>
                                <option value="LV">Latvia</option>
                                <option value="LB">Lebanon</option>
                                <option value="LS">Lesotho</option>
                                <option value="LR">Liberia</option>
                                <option value="LY">Libyan Arab Jamahiriya</option>
                                <option value="LI">Liechtenstein</option>
                                <option value="LT">Lithuania</option>
                                <option value="LU">Luxembourg</option>
                                <option value="MO">Macao</option>
                                <option value="MK">Macedonia</option>
                                <option value="MG">Madagascar</option>
                                <option value="MW">Malawi</option>
                                <option value="MY">Malaysia</option>
                                <option value="MV">Maldives</option>
                                <option value="ML">Mali</option>
                                <option value="MT">Malta</option>
                                <option value="MH">Marshall Islands</option>
                                <option value="MQ">Martinique</option>
                                <option value="MR">Mauritania</option>
                                <option value="MU">Mauritius</option>
                                <option value="YT">Mayotte</option>
                                <option value="MX">Mexico</option>
                                <option value="FM">Micronesia</option>
                                <option value="MD">Moldova</option>
                                <option value="MC">Monaco</option>
                                <option value="MN">Mongolia</option>
                                <option value="MS">Montserrat</option>
                                <option value="MA">Morocco</option>
                                <option value="MZ">Mozambique</option>
                                <option value="MM">Myanmar</option>
                                <option value="NA">Namibia</option>
                                <option value="NR">Nauru</option>
                                <option value="NP">Nepal</option>
                                <option value="NL">Netherlands</option>
                                <option value="AN">Netherlands Antilles</option>
                                <option value="NC">New Caledonia</option>
                                <option value="NZ">New Zealand</option>
                                <option value="NI">Nicaragua</option>
                                <option value="NE">Niger</option>
                                <option value="NG">Nigeria</option>
                                <option value="NU">Niue</option>
                                <option value="NF">Norfolk Island</option>
                                <option value="MP">Northern Mariana Islands</option>
                                <option value="NO">Norway</option>
                                <option value="OM">Oman</option>
                                <option value="PK">Pakistan</option>
                                <option value="PW">Palau</option>
                                <option value="PA">Panama</option>
                                <option value="PG">Papua New Guinea</option>
                                <option value="PY">Paraguay</option>
                                <option value="PE">Peru</option>
                                <option value="PH">Philippines</option>
                                <option value="PN">Pitcairn</option>
                                <option value="PL">Poland</option>
                                <option value="PT">Portugal</option>
                                <option value="PR">Puerto Rico</option>
                                <option value="QA">Qatar</option>
                                <option value="RE">Reunion</option>
                                <option value="RO">Romania</option>
                                <option value="RU">Russian Federation</option>
                                <option value="RW">Rwanda</option>
                                <option value="KN">Saint Kitts And Nevis</option>
                                <option value="LC">Saint Lucia</option>
                                <option value="VC">Saint Vincent And The Grenadines</option>
                                <option value="WS">Samoa</option>
                                <option value="SM">San Marino</option>
                                <option value="ST">Sao Tome And Principe</option>
                                <option value="SA">Saudi Arabia</option>
                                <option value="SN">Senegal</option>
                                <option value="SC">Seychelles</option>
                                <option value="SL">Sierra Leone</option>
                                <option value="SG">Singapore</option>
                                <option value="SK">Slovakia </option>
                                <option value="SI">Slovenia</option>
                                <option value="SB">Solomon Islands</option>
                                <option value="SO">Somalia</option>
                                <option value="ZA">South Africa</option>
                                <option value="GS">South Georgia And The South Sandwich Islands</option>
                                <option value="ES">Spain</option>
                                <option value="LK">Sri Lanka</option>
                                <option value="SH">St. Helena</option>
                                <option value="PM">St. Pierre And Miquelon</option>
                                <option value="SD">Sudan</option>
                                <option value="SR">Suriname</option>
                                <option value="SJ">Svalbard And Jan Mayen Islands</option>
                                <option value="SZ">Swaziland</option>
                                <option value="SE">Sweden</option>
                                <option value="CH">Switzerland</option>
                                <option value="SY">Syrian Arab Republic</option>
                                <option value="TW">Taiwan</option>
                                <option value="TJ">Tajikistan</option>
                                <option value="TZ">Tanzania</option>
                                <option value="TH">Thailand</option>
                                <option value="TG">Togo</option>
                                <option value="TK">Tokelau</option>
                                <option value="TO">Tonga</option>
                                <option value="TT">Trinidad And Tobago</option>
                                <option value="TN">Tunisia</option>
                                <option value="TR">Turkey</option>
                                <option value="TM">Turkmenistan</option>
                                <option value="TC">Turks And Caicos Islands</option>
                                <option value="TV">Tuvalu</option>
                                <option value="UG">Uganda</option>
                                <option value="UA">Ukraine</option>
                                <option value="AE">United Arab Emirates</option>
                                <option value="GB">United Kingdom</option>
                                <option value="US">United States</option>
                                <option value="UM">United States Minor Outlying Islands</option>
                                <option value="UY">Uruguay</option>
                                <option value="UZ">Uzbekistan</option>
                                <option value="VU">Vanuatu</option>
                                <option value="VA">Vatican City State </option>
                                <option value="VE">Venezuela</option>
                                <option value="VN">Viet Nam</option>
                                <option value="VG">Virgin Islands (British)</option>
                                <option value="VI">Virgin Islands (U.S.)</option>
                                <option value="WF">Wallis And Futuna Islands</option>
                                <option value="EH">Western Sahara</option>
                                <option value="YE">Yemen</option>
                                <option value="RS">Serbia</option>
                                <option value="ZM">Zambia</option>
                                <option value="ZW">Zimbabwe</option>
                                <option value="AX">Aaland Islands</option>
                              </select>
                            </div>
                          </div>
<? }else{ ?>
<input placeholder="Country" type="hidden" name="bill_state" value="<?=prntext($post['bill_state']);?>">
<? } ?>						  
						  
						  
						  
                          <script language="javascript" type="text/javascript"> 
	function html_input(str){
		//alert(str);
		$('#state_input_divid').html(str);
	}
	function bill_statechangf(theValue){
		if(theValue=="Other"){
		 $('#state_input_divid').html('<input placeholder="State" type="text" id="state_list" name="bill_state" class="form-control"  value="" required>');		
		}
	}
	$("#country_list").change(function(e){
	
		/*var coun_opt_data = $('#country_list option[value="'+$(this).val()+'"]').attr('data-val');
		if(($(this).val().length===3) && (coun_opt_data!==undefined)){
			 //alert("\r\ndata1="+coun_opt_data);
			 $('#bill_country_name').val(coun_opt_data);

		}*/
	//alert($(this).val()+"\r\n"+$(this).find('option:selected').text()+"\r\n"+$(this).find('option:selected').attr('data-val'));
	 
	 var objValue=$(this).find('option:selected').text();
	 //alert(objValue);
	 
	 $('#bill_country_name').val($(this).find('option:selected').attr('data-val'));
	  
	 $('#state_input_divid').html('<input placeholder="State" type="text" id="state_list" name="bill_state" class="form-control" value="" required>');
	 var state_selected='<select onchange="bill_statechangf(this.value)" name="bill_state" id="state_list" class="form-select"  required><option value="" disabled="disabled" selected="selected">Select State</option>';
	 var state_selected2='<option value="Other">Other</option></select>';
	  if($(this).val()==="USA"){
		$('#state_input_divid').html(state_selected+'<option value="AL">Alabama</option><option value="AK">Alaska</option><option value="AS">American Samoa</option><option value="AZ">Arizona</option><option value="AR">Arkansas</option><option value="AF">Armed Forces Africa</option><option value="AA">Armed Forces Americas</option><option value="AC">Armed Forces Canada</option><option value="AE">Armed Forces Europe</option><option value="AM">Armed Forces Middle East</option><option value="AP">Armed Forces Pacific</option><option value="CA">California</option><option value="CO">Colorado</option><option value="CT">Connecticut</option><option value="DE">Delaware</option><option value="DC">District Of Columbia</option><option value="FM">Federated States Of Micronesia</option><option value="FL">Florida</option><option value="GA">Georgia</option><option value="GU">Guam</option><option value="HI">Hawaii</option><option value="ID">Idaho</option><option value="IL">Illinois</option><option value="IN">Indiana</option><option value="IA">Iowa</option><option value="KS">Kansas</option><option value="KY">Kentucky</option><option value="LA">Louisiana</option><option value="ME">Maine</option><option value="MH">Marshall Islands</option><option value="MD">Maryland</option><option value="MA">Massachusetts</option><option value="MI">Michigan</option><option value="MN">Minnesota</option><option value="MS">Mississippi</option><option value="MO">Missouri</option><option value="MT">Montana</option><option value="NE">Nebraska</option><option value="NV">Nevada</option><option value="NH">New Hampshire</option><option value="NJ">New Jersey</option><option value="NM">New Mexico</option><option value="NY">New York</option><option value="NC">North Carolina</option><option value="ND">North Dakota</option><option value="MP">Northern Mariana Islands</option><option value="OH">Ohio</option><option value="OK">Oklahoma</option><option value="OR">Oregon</option><option value="PA">Pennsylvania</option><option value="PR">Puerto Rico</option><option value="RI">Rhode Island</option><option value="SC">South Carolina</option><option value="SD">South Dakota</option><option value="TN">Tennessee</option><option value="TX">Texas</option><option value="UT">Utah</option><option value="VT">Vermont</option><option value="VI">Virgin Islands</option><option value="VA">Virginia</option><option value="WA">Washington</option><option value="WV">West Virginia</option><option value="WI">Wisconsin</option><option value="WY">Wyoming</option>'+state_selected2);
	  }else if($(this).val()==="CAN"){
		$('#state_input_divid').html(state_selected+'<option value="AB">Alberta</option><option value="BC">British Columbia</option><option value="MB">Manitoba</option><option value="NL">Newfoundland</option><option value="NB">New Brunswick</option><option value="NS">Nova Scotia</option><option value="NT">Northwest Territories</option><option value="NU">Nunavut</option><option value="ON">Ontario</option><option value="PE">Prince Edward Island</option><option value="QC">Quebec</option><option value="SK">Saskatchewan</option><option value="YT">Yukon Territory</option>'+state_selected2);
	  }else if($(this).val()==="AUS"){
		$('#state_input_divid').html(state_selected+'<option value="ACT">Australian Capital Territory</option><option value="NSW">New South Wales</option><option value="NT">Northern Territory</option><option value="QLD">Queensland</option><option value="SA">South Australia</option><option value="TAS">Tasmania</option><option value="VIC">Victoria</option><option value="WA">Western Australia</option>'+state_selected2);
	  }else if($(this).val()==="JPN"){
		$('#state_input_divid').html(state_selected+'<option value="HK">Hokkaido</option><option value="AO">Aomori</option><option value="IW">Iwate</option><option value="MY">Miyagi</option><option value="AK">Akita</option><option value="YM">Yamagata</option><option value="FK">Fukushima</option><option value="IB">Ibaragi</option><option value="TC">Tochigi</option><option value="GU">Gunma</option><option value="SI">Saitama</option><option value="CB">Chiba</option><option value="TK">Tokyo</option><option value="KN">Kanagawa</option><option value="NI">Niigata</option><option value="TY">Toyama</option><option value="IS">Ishikawa</option><option value="FI">Fukui</option><option value="YN">Yamanashi</option><option value="NG">Nagano</option><option value="GF">Gifu</option><option value="SZ">Shizuoka</option><option value="AI">Aichi</option><option value="ME">Mie</option><option value="SG">Shiga</option><option value="KT">Kyoto</option><option value="OS">Osaka</option><option value="HG">Hyogo</option><option value="NR">Nara</option><option value="WK">Wakayama</option><option value="TT">Tottori</option><option value="SM">Shimane</option><option value="OK">Okayama</option><option value="HR">Hiroshima</option><option value="YG">Yamaguchi</option><option value="TS">Tokushima</option><option value="KG">Kagawa</option><option value="EH">Ehime</option><option value="KC">Kouchi</option><option value="FO">Fukuoka</option><option value="SA">Saga</option><option value="NS">Nagasaki</option><option value="KM">Kumamoto</option><option value="OI">Ooita</option><option value="MZ">Miyazaki</option><option value="KS">Kagoshima</option>'+state_selected2);
	  }
	  
		else if(objValue==="India"){ var str=state_selected; str=str+'<option value="Andaman and Nicobar">Andaman and Nicobar</option><option value="Andhra Pradesh">Andhra Pradesh</option><option value="Arunachal Pradesh">Arunachal Pradesh</option><option value="Assam">Assam</option><option value="Bihar">Bihar</option><option value="Chandigarh">Chandigarh</option><option value="Chhattisgarh">Chhattisgarh</option><option value="Dadra and Nagar Haveli">Dadra and Nagar Haveli</option><option value="Daman and Diu">Daman and Diu</option><option value="Delhi">Delhi</option><option value="Goa">Goa</option><option value="Gujarat">Gujarat</option><option value="Haryana">Haryana</option><option value="Himachal Pradesh">Himachal Pradesh</option><option value="Jammu &amp; Kashmir">Jammu &amp; Kashmir</option><option value="Jharkhand">Jharkhand</option><option value="Karnataka">Karnataka</option><option value="Kerala">Kerala</option><option value="Lakshadweep">Lakshadweep</option><option value="Madhya Pradesh">Madhya Pradesh</option><option value="Maharashtra">Maharashtra</option><option value="Manipur">Manipur</option><option value="Meghalaya">Meghalaya</option><option value="Mizoram">Mizoram</option><option value="Nagaland">Nagaland</option><option value="Orissa">Orissa</option><option value="Pondicherry">Pondicherry</option><option value="Punjab">Punjab</option><option value="Rajasthan">Rajasthan</option><option value="Sikkim">Sikkim</option><option value="Tamil Nadu">Tamil Nadu</option><option value="Tripura">Tripura</option><option value="Uttar Pradesh">Uttar Pradesh</option><option value="Uttarakhand">Uttarakhand</option><option value="West Bengal">West Bengal</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Afghanistan"){ var str=state_selected; str=str+'<option value="Badakhshan">Badakhshan</option><option value="Badghis">Badghis</option><option value="Baghlan">Baghlan</option><option value="Balkh">Balkh</option><option value="Bamyan">Bamyan</option><option value="Daykundi">Daykundi</option><option value="Farah">Farah</option><option value="Faryab">Faryab</option><option value="Ghazni">Ghazni</option><option value="Ghor">Ghor</option><option value="Helmand">Helmand</option><option value="Herat">Herat</option><option value="Jowzjan">Jowzjan</option><option value="Kabul">Kabul</option><option value="Kandahar">Kandahar</option><option value="Kapisa">Kapisa</option><option value="Khost">Khost</option><option value="Konar">Konar</option><option value="Kunduz">Kunduz</option><option value="Laghman">Laghman</option><option value="Logar">Logar</option><option value="Nangarhar">Nangarhar</option><option value="Nimruz">Nimruz</option><option value="Nurestan">Nurestan</option><option value="Oruzgan">Oruzgan</option><option value="Paktia">Paktia</option><option value="Paktika">Paktika</option><option value="Panjshir">Panjshir</option><option value="Parvan">Parvan</option><option value="Samangan">Samangan</option><option value="Sare Pol">Sare Pol</option><option value="Takhar">Takhar</option><option value="Wardak">Wardak</option><option value="Zabol">Zabol</option>'; str=str+state_selected2; html_input(str);}	

		else if(objValue==="Aland Islands"){ var str=state_selected; str=str+'<option value="Brando">Brando</option><option value="Eckero">Eckero</option><option value="Finström">Finström</option><option value="Föglö">Föglö</option><option value="Geta">Geta</option><option value="Hammarland">Hammarland</option><option value="Jomala">Jomala</option><option value="Kumlinge">Kumlinge</option><option value="Kökar">Kökar</option><option value="Lemland">Lemland</option><option value="Lumparland">Lumparland</option><option value="Mariehamn">Mariehamn</option><option value="Saltvik">Saltvik</option><option value="Sottunga">Sottunga</option><option value="Sund">Sund</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Albania"){ var str=state_selected; str=str+'<option value="Tirana">Tirana</option><option value="Durres">Durres</option><option value="Elbasan">Elbasan</option><option value="Vlore">Vlore</option><option value="Shkoder">Shkoder</option><option value="Fier">Fier</option><option value="Korce">Korce</option><option value="Berat">Berat</option><option value="Lushnje">Lushnje</option><option value="Kavaje">Kavaje</option><option value="Pogradec">Pogradec</option><option value="Lac">Lac</option><option value="Gjirokaster">Gjirokaster</option><option value="Patos">Patos</option><option value="Kruje">Kruje</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Algeria"){ var str=state_selected; str=str+'<option value="Algiers">Algiers</option><option value="Wahran">Wahran</option><option value="Constantine">Constantine</option><option value="Warqla">Warqla</option><option value="Medea">Medea</option><option value="Adrar">Adrar</option><option value="Aflu">Aflu</option><option value="Birin">Birin</option><option value="Tuggurt">Tuggurt</option><option value="Timizart">Timizart</option><option value="Sidi Ali">Sidi Ali</option><option value="Tazmalt">Tazmalt</option><option value="Tigzirt">Tigzirt</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="American Samoa"){ var str=state_selected; str=str+'<option value="Tuamasaga ">Tuamasaga </option><option value="Aana">Aana</option><option value="Aiga-i-le-Tai ">Aiga-i-le-Tai </option><option value="Atua">Atua </option><option value="Vaa-o-Fonoti">Vaa-o-Fonoti </option><option value="Savaii">Savaii</option><option value="Faasaleleaga">Faasaleleaga</option><option value="Gagaemauga">Gagaemauga</option><option value="Gagaifomauga">Gagaifomauga</option><option value="Vaisigano">Vaisigano</option><option value="Satupaitea">Satupaitea </option><option value="Palauli">Palauli</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Andorra"){ var str=state_selected; str=str+'<option value="Andorra la Vella">Andorra la Vella</option><option value="Les Escaldes">Les Escaldes</option><option value="Encamp">Encamp</option><option value="Sant Julia De Loria">Sant Julia De Loria</option><option value="La Massana">La Massana</option><option value="Canillo">Canillo</option><option value="Ordino">Ordino</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Angola"){ var str=state_selected; str=str+'<option value="Luanda">Luanda</option><option value="Huambo">Huambo</option><option value="Lobito">Lobito</option><option value="Benguela">Benguela</option><option value="Kuito">Kuito</option><option value="Lubango">Lubango</option><option value="Malanje">Malanje</option><option value="Namibe">Namibe</option><option value="Soyo">Soyo</option><option value="Cabinda">Cabinda</option><option value="Uige">Uige</option><option value="Saurimo">Saurimo</option><option value="Sumbe">Sumbe</option><option value="Caluquembe">Caluquembe</option><option value="Caxito">Caxito</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Anguilla"){ var str=state_selected; str=str+'<option value="Bethel">Bethel</option><option value="Betty Hill">Betty Hill</option><option value="Blowing Point">Blowing Point</option><option value="Blowing Point Village">Blowing Point Village</option><option value="Bungalows">Bungalows</option><option value="Cannifist">Cannifist</option><option value="Cauls Bottom">Cauls Bottom</option><option value="Chalvilles">Chalvilles</option><option value="Crocus Hill">Crocus Hill</option><option value="Deep Waters">Deep Waters</option><option value="East End">East End</option><option value="East End Village">East End Village</option><option value="Ebenezer">Ebenezer</option><option value="George Hill">George Hill</option><option value="Island Harbour">Island Harbour</option><option value="Junks Hole">Junks Hole</option><option value="Little Dicks">Little Dicks</option><option value="Little Dix">Little Dix</option><option value="Long Bay">Long Bay</option><option value="Long Bay">Long Bay</option><option value="Long Ground">Long Ground</option><option value="Long Path">Long Path</option><option value="Lower South Hill">Lower South Hill</option><option value="Mahogany Tree">Mahogany Tree</option><option value="Mount Fortune">Mount Fortune</option><option value="North Hill Village">North Hill Village</option><option value="North Side">North Side</option><option value="Rey Hill">Rey Hill</option><option value="Saint Marys">Saint Marys</option><option value="Saint Mary’s">Saint Mary’s</option><option value="Sandy Ground”>Sandy Ground </option><option value="Shoal Bay”>Shoal Bay </option><option value="Shoal Village">Shoal Village</option><option value="South Hill Village">South Hill Village</option><option value="Stoney Ground">Stoney Ground</option><option value="The Copse">The Copse</option><option value="The Farrington">The Farrington</option><option value="The Forest">The Forest</option><option value="The Fountain">The Fountain</option><option value="The Quarter">The Quarter</option><option value="The Valley">The Valley</option><option value="Valley">Valley</option><option value="Wattices">Wattices</option><option value="Welches">Welches</option><option value="Welches Hill">Welches Hill</option><option value="West End">West End </option><option value="White Hill">White Hill</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Antarctica"){ var str=state_selected; str=str+'<option value="Ushuaia">Ushuaia</option><option value="Punta Arenas">Punta Arenas</option><option value="Rio Gallegos">Rio Gallegos</option><option value="Port-aux-francais">Port-aux-francais</option><option value="Comodoro Rivadavia">Comodoro Rivadavia</option><option value="Coihaique">Coihaique</option><option value="Bluff">Bluff</option><option value="Invercargill">Invercargill</option><option value="Owaka">Owaka</option><option value="Riverton">Riverton</option><option value="Woodlands">Woodlands</option><option value="Wallacetown">Wallacetown</option><option value="Wyndham">Wyndham</option><option value="Edendale">Edendale</option><option value="Kaitangata">Kaitangata</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Antigua and Barbuda"){ var str=state_selected; str=str+'<option value="All Saints">All Saints</option><option value="Liberta">Liberta</option><option value="Parham">Parham</option><option value="Carlisle">Carlisle</option><option value="Swetes">Swetes</option><option value="Codrington">Codrington</option><option value="Freetown">Freetown</option><option value="Old Road">Old Road</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Argentina"){ var str=state_selected; str=str+'<option value="Buenos Aires">Buenos Aires</option><option value="Cordoba">Cordoba</option><option value="Rosario">Rosario</option><option value="Mendoza">Mendoza</option><option value="Tucuman">Tucuman</option><option value="La Plata">La Plata</option><option value="Mar del Plata">Mar del Plata</option><option value="Salta">Salta</option><option value="San Juan">San Juan</option><option value="Santa Fe">Santa Fe</option><option value="Santiago del Estero">Santiago del Estero</option><option value="Resistencia">Resistencia</option><option value="Corrientes">Corrientes</option><option value="Neuquen">Neuquen</option><option value="Posadas">Posadas</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Armenia"){ var str=state_selected; str=str+'<option value="Yerevan">Yerevan</option><option value="Gyumri">Gyumri</option><option value="Vanadzor">Vanadzor</option><option value="Vagharshapat">Vagharshapat</option><option value="Hrazdan">Hrazdan</option><option value="Abovyan">Abovyan</option><option value="Kapan">Kapan</option><option value="Gavar">Gavar</option><option value="Artashat">Artashat</option><option value="Goris">Goris</option><option value="Masis">Masis</option><option value="Ashtarak">Ashtarak</option><option value="Sevan">Sevan</option><option value="Sisian">Sisian</option><option value="Spitak">Spitak</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Aruba"){ var str=state_selected; str=str+'<option value="Brasil">Brasil</option><option value="Bubali">Bubali</option><option value="Ceru Colorado">Ceru Colorado</option><option value="Cura Cabai">Cura Cabai</option><option value="Malmok">Malmok</option><option value="Madiki">Madiki</option><option value="Noord">Noord</option><option value="Oranjestad”>Oranjestad </option><option value="Pavia">Pavia</option><option value="Piedra Plat">Piedra Plat</option><option value="Ponton">Ponton</option><option value="Pos Chikitu">Pos Chikitu</option><option value="San Nicolas">San Nicolas</option><option value="Santa Cruz">Santa Cruz</option><option value="Savaneta">Savaneta</option><option value="Wayaca">Wayaca</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Australia"){ var str=state_selected; str=str+'<option value="Sydney">Sydney</option><option value="Melbourne">Melbourne</option><option value="Brisbane">Brisbane</option><option value="Perth">Perth</option><option value="Adelaide">Adelaide</option><option value="Gold Coast">Gold Coast</option><option value="Newcastle">Newcastle</option><option value="Canberra">Canberra</option><option value="Wollongong">Wollongong</option><option value="Hobart">Hobart</option><option value="Cairns">Cairns</option><option value="Geelong">Geelong</option><option value="Townsville">Townsville</option><option value="Albury">Albury</option><option value="Darwin">Darwin</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Austria"){ var str=state_selected; str=str+'<option value="Vienna">Vienna</option><option value="Graz">Graz</option><option value="Linz">Linz</option><option value="Salzburg">Salzburg</option><option value="Innsbruck">Innsbruck</option><option value="Klagenfurt">Klagenfurt</option><option value="Villach">Villach</option><option value="Wels">Wels</option><option value="Sankt Polten">Sankt Polten</option><option value="Dornbirn">Dornbirn</option><option value="Steyr">Steyr</option><option value="Wiener Neustadt">Wiener Neustadt</option><option value="Feldkirch">Feldkirch</option><option value="Bregenz">Bregenz</option><option value="Wolfsberg">Wolfsberg</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Azerbaijan"){ var str=state_selected; str=str+'<option value="Baku">Baku</option><option value="Qaracuxur">Qaracuxur</option><option value="Yevlax">Yevlax</option><option value="Mastaga">Mastaga</option><option value="Agdam">Agdam</option><option value="Xacmaz">Xacmaz</option><option value="Salyan">Salyan</option><option value="Hovsan">Hovsan</option><option value="Goycay">Goycay</option><option value="Kirovskiy">Kirovskiy</option><option value="Imisli">Imisli</option><option value="Lokbatan">Lokbatan</option><option value="Sabirabad">Sabirabad</option><option value="Buzovna">Buzovna</option><option value="Agdas">Agdas</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Bahamas"){ var str=state_selected; str=str+'<option value="Nassau">Nassau</option><option value="Freeport">Freeport</option><option value="Marsh Harbour">Marsh Harbour</option><option value="High Rock">High Rock</option><option value="Andros Town">Andros Town</option><option value="Clarence Town">Clarence Town</option><option value="Dunmore Town">Dunmore Town</option><option value="Rock Sound">Rock Sound</option><option value="Alice Town">Alice Town</option><option value="Cockburn Town">Cockburn Town</option><option value="Sweeting Cay">Sweeting Cay</option><option value="Matthew Town">Matthew Town</option><option value="Snug Corner">Snug Corner</option><option value="Nicholls Town">Nicholls Town</option><option value="Colonel Hill">Colonel Hill</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Bahrain"){ var str=state_selected; str=str+'<option value="Manama">Manama</option><option value="Riffa”>Riffa </option><option value="Muharraq">Muharraq</option><option value="Hamad Town”>Hamad Town </option><option value="Aali">Aali</option><option value="Isa Town">Isa Town</option><option value="Sitra">Sitra</option><option value="Budaiya”>Budaiya </option><option value="Jidhafs”>Jidhafs </option><option value="Al-Malikiyah">Al-Malikiyah</option><option value="Adliya">Adliya</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Bangladesh"){ var str=state_selected; str=str+'<option value="Dhaka">Dhaka</option><option value="Khulna">Khulna</option><option value="Rajshahi">Rajshahi</option><option value="Tungi">Tungi</option><option value="Rangpur">Rangpur</option><option value="Narsingdi">Narsingdi</option><option value="Barisal">Barisal</option><option value="Narayanganj">Narayanganj</option><option value="Dinajpur">Dinajpur</option><option value="Jamalpur">Jamalpur</option><option value="Sirajganj">Sirajganj</option><option value="Nawabganj">Nawabganj</option><option value="Pabna">Pabna</option><option value="Gazipur">Gazipur</option><option value="Satkhira">Satkhira</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Barbados"){ var str=state_selected; str=str+'<option value="Bridgetown">Bridgetown</option><option value="Speightstown">Speightstown</option><option value="Oistins">Oistins</option><option value="Bathsheba">Bathsheba</option><option value="Holetown">Holetown</option><option value="Crab Hill">Crab Hill</option><option value="Blackmans">Blackmans</option><option value="Greenland">Greenland</option><option value="Hillaby">Hillaby</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Belarus"){ var str=state_selected; str=str+'<option value="Minsk">Minsk</option><option value="Gomel">Gomel</option><option value="Hrodna">Hrodna</option><option value="Brest">Brest</option><option value="Pinsk">Pinsk</option><option value="Orsha">Orsha</option><option value="Mazyr">Mazyr</option><option value="Salihorsk">Salihorsk</option><option value="Lida">Lida</option><option value="Zlobin">Zlobin</option><option value="Slonim">Slonim</option><option value="Kobryn">Kobryn</option><option value="Vawkavysk">Vawkavysk</option><option value="Horki">Horki</option><option value="Navahrudak">Navahrudak</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Belgium"){ var str=state_selected; str=str+'<option value="Brussels">Brussels</option><option value="Antwerp">Antwerp</option><option value="Gent">Gent</option><option value="Charleroi">Charleroi</option><option value="Liege">Liege</option><option value="Brugge">Brugge</option><option value="Namur">Namur</option><option value="Leuven">Leuven</option><option value="Mons">Mons</option><option value="Aalst">Aalst</option><option value="Mechelen">Mechelen</option><option value="La Louviere">La Louviere</option><option value="Kortrijk">Kortrijk</option><option value="Hasselt">Hasselt</option><option value="Ostend">Ostend</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Belize"){ var str=state_selected; str=str+'<option value="Belize">Belize</option><option value="San Ignacio">San Ignacio</option><option value="Orange Walk">Orange Walk</option><option value="Belmopan">Belmopan</option><option value="Dangriga">Dangriga</option><option value="Corozal">Corozal</option><option value="San Pedro">San Pedro</option><option value="Benque Viejo">Benque Viejo</option><option value="Punta Gorda">Punta Gorda</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Benin"){ var str=state_selected; str=str+'<option value="Cotonou">Cotonou</option><option value="Abomey-Calavi">Abomey-Calavi</option><option value="Djougou">Djougou</option><option value="Parakou">Parakou</option><option value="Bohicon">Bohicon</option><option value="Kandi">Kandi</option><option value="Lokossa">Lokossa</option><option value="Ouidah">Ouidah</option><option value="Abomey">Abomey</option><option value="Natitingou">Natitingou</option><option value="Save">Save</option><option value="Nikki">Nikki</option><option value="Dogbo">Dogbo</option><option value="Cove">Cove</option><option value="Malanville">Malanville</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Bermuda"){ var str=state_selected; str=str+'<option value="Saint George">Saint George</option><option value="Hamilton">Hamilton</option><option value="Sunnyside">Sunnyside</option><option value="Camden">Camden</option><option value="Chelston">Chelston</option><option value="Mount Pleasant">Mount Pleasant</option><option value="Saint Georges">Saint Georges</option><option value="Saint Georges">Saint Georges</option><option value="Cashew”>Cashew </option><option value="Melrose">Melrose</option><option value="Tuckers">Tuckers</option><option value="Hog Bay">Hog Bay</option><option value="Scotts Hill">Scotts Hill</option><option value="Somerset">Somerset</option><option value="Flatts Village">Flatts Village</option><option value="Harrington Hundreds">Harrington Hundreds</option><option value="Hinson Hall">Hinson Hall</option><option value="The Flatts">The Flatts</option><option value="Hill View">Hill View</option><option value="Bethaven">Bethaven</option><option value="Warwick Camp">Warwick Camp</option><option value="North Shore">North Shore</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Bhutan"){ var str=state_selected; str=str+'<option value="Thimphu">Thimphu</option><option value="Phuntsholing">Phuntsholing</option><option value="Punakha">Punakha</option><option value="Samdrup Jongkhar">Samdrup Jongkhar</option><option value="Geylegphug">Geylegphug</option><option value="Jakar">Jakar</option><option value="Paro">Paro</option><option value="Tashigang">Tashigang</option><option value="Wangdiphodrang">Wangdiphodrang</option><option value="Taga Dzong">Taga Dzong</option><option value="Tongsa">Tongsa</option><option value="Damphu">Damphu</option><option value="Lhuntshi">Lhuntshi</option><option value="Pemagatsel">Pemagatsel</option><option value="Gasa">Gasa</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Bolivia"){ var str=state_selected; str=str+'<option value="Santa Cruz">Santa Cruz</option><option value="El Alto">El Alto</option><option value="La Paz">La Paz</option><option value="Cochabamba">Cochabamba</option><option value="Sucre">Sucre</option><option value="Oruro">Oruro</option><option value="Tarija">Tarija</option><option value="Potosi">Potosi</option><option value="Sacaba">Sacaba</option><option value="Montero">Montero</option><option value="Trinidad">Trinidad</option><option value="Riberalta">Riberalta</option><option value="Yacuiba">Yacuiba</option><option value="Quillacollo">Quillacollo</option><option value="Colcapirhua">Colcapirhua</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Bosnia and Herzegovina"){ var str=state_selected; str=str+'<option value="Sarajevo">Sarajevo</option><option value="Banja Luka">Banja Luka</option><option value="Zenica">Zenica</option><option value="Tuzla">Tuzla</option><option value="Mostar">Mostar</option><option value="Bihac">Bihac</option><option value="Bugojno">Bugojno</option><option value="Brcko">Brcko</option><option value="Bijeljina">Bijeljina</option><option value="Prijedor">Prijedor</option><option value="Trebinje">Trebinje</option><option value="Travnik">Travnik</option><option value="Doboj">Doboj</option><option value="Cazin">Cazin</option><option value="Velika Kladusa">Velika Kladusa</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Botswana"){ var str=state_selected; str=str+'<option value="Gaborone">Gaborone</option><option value="Francistown">Francistown</option><option value="Molepolole">Molepolole</option><option value="Maun">Maun</option><option value="Serowe">Serowe</option><option value="Kanye">Kanye</option><option value="Mahalapye">Mahalapye</option><option value="Mogoditshane">Mogoditshane</option><option value="Mochudi">Mochudi</option><option value="Lobatse">Lobatse</option><option value="Palapye">Palapye</option><option value="Ramotswa">Ramotswa</option><option value="Thamaga">Thamaga</option><option value="Moshupa">Moshupa</option><option value="Letlhakane">Letlhakane</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Bouvet Island"){ var str=state_selected; str=str+'<option value="N/A">N/A</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Brazil"){ var str=state_selected; str=str+'<option value="Sao Paulo">Sao Paulo</option><option value="Rio de Janeiro">Rio de Janeiro</option><option value="Salvador">Salvador</option><option value="Belo Horizonte">Belo Horizonte</option><option value="Brasilia">Brasilia</option><option value="Curitiba">Curitiba</option><option value="Manaus">Manaus</option><option value="Recife">Recife</option><option value="Belem">Belem</option><option value="Porto Alegre">Porto Alegre</option><option value="Goiania">Goiania</option><option value="Guarulhos">Guarulhos</option><option value="Campinas">Campinas</option><option value="Nova Iguacu">Nova Iguacu</option><option value="Maceio">Maceio</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="British Indian Ocean Territory"){ var str=state_selected; str=str+'<option value="Vancouver">Vancouver</option><option value="Perth">Perth</option><option value="Nairobi">Nairobi</option><option value="Vladivostok">Vladivostok</option><option value="Reykjavík">Reykjavík</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Brunei Darussalam"){ var str=state_selected; str=str+'<option value="Bandar Seri Begawan">Bandar Seri Begawan</option><option value="Kuala Belait">Kuala Belait</option><option value="Seria">Seria</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Bulgaria"){ var str=state_selected; str=str+'<option value="Sofia">Sofia</option><option value="Plovdiv">Plovdiv</option><option value="Varna">Varna</option><option value="Burgas">Burgas</option><option value="Ruse">Ruse</option><option value="Stara Zagora">Stara Zagora</option><option value="Pleven">Pleven</option><option value="Sliven">Sliven</option><option value="Dobric">Dobric</option><option value="Sumen">Sumen</option><option value="Pernik">Pernik</option><option value="Haskovo">Haskovo</option><option value="Pazardzik">Pazardzik</option><option value="Jambol">Jambol</option><option value="Blagoevgrad">Blagoevgrad</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Burkina Faso"){ var str=state_selected; str=str+'<option value="Ouagadougou">Ouagadougou</option><option value="Bobo Dioulasso">Bobo Dioulasso</option><option value="Koudougou">Koudougou</option><option value="Banfora">Banfora</option><option value="Ouahigouya">Ouahigouya</option><option value="Dedougou">Dedougou</option><option value="Kaya">Kaya</option><option value="Tenkodogo">Tenkodogo</option><option value="Ouargaye">Ouargaye</option><option value="Garango">Garango</option><option value="Dori">Dori</option><option value="Kongoussi">Kongoussi</option><option value="Kokologo">Kokologo</option><option value="Reo">Reo</option><option value="Diapaga">Diapaga</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Burundi"){ var str=state_selected; str=str+'<option value="Bujumbura">Bujumbura</option><option value="Muyinga">Muyinga</option><option value="Ruyigi">Ruyigi</option><option value="Gitega">Gitega</option><option value="Ngozi">Ngozi</option><option value="Rutana">Rutana</option><option value="Bururi">Bururi</option><option value="Makamba">Makamba</option><option value="Kayanza">Kayanza</option><option value="Muramvya">Muramvya</option><option value="Bubanza">Bubanza</option><option value="Karuzi">Karuzi</option><option value="Cankuzo">Cankuzo</option><option value="Kirundo">Kirundo</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Cambodia"){ var str=state_selected; str=str+'<option value="Phnum Penh">Phnum Penh</option><option value="Kampong Chhnang">Kampong Chhnang</option><option value="Kampong Cham">Kampong Cham</option><option value="Pousat">Pousat</option><option value="Phumi Samraong">Phumi Samraong</option><option value="Svay Rieng">Svay Rieng</option><option value="Sisophon">Sisophon</option><option value="Kampot">Kampot</option><option value="Kampong Thum">Kampong Thum</option><option value="Lumphat">Lumphat</option><option value="Senmonorom">Senmonorom</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Cameroon"){ var str=state_selected; str=str+'<option value="Douala">Douala</option><option value="Yaounde">Yaounde</option><option value="Garoua">Garoua</option><option value="Kousseri">Kousseri</option><option value="Bamenda">Bamenda</option><option value="Maroua">Maroua</option><option value="Bafoussam">Bafoussam</option><option value="Mokolo">Mokolo</option><option value="Ngaoundere">Ngaoundere</option><option value="Bertoua">Bertoua</option><option value="Edea">Edea</option><option value="Loum">Loum</option><option value="Kumba">Kumba</option><option value="Nkongsamba">Nkongsamba</option><option value="Mbouda">Mbouda</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Canada"){ var str=state_selected; str=str+'<option value="Toronto">Toronto</option><option value="Montreal">Montreal</option><option value="Vancouver">Vancouver</option><option value="Calgary">Calgary</option><option value="Ottawa">Ottawa</option><option value="Edmonton">Edmonton</option><option value="Hamilton">Hamilton</option><option value="Quebec">Quebec</option><option value="Winnipeg">Winnipeg</option><option value="Mississauga">Mississauga</option><option value="Kitchener">Kitchener</option><option value="London">London</option><option value="Windsor">Windsor</option><option value="Victoria">Victoria</option><option value="Halifax">Halifax</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Cape Verde"){ var str=state_selected; str=str+'<option value="Praia">Praia</option><option value="Mindelo">Mindelo</option><option value="Santa Maria">Santa Maria</option><option value="Sao Filipe">Sao Filipe</option><option value="Assomada">Assomada</option><option value="Tarrafal">Tarrafal</option><option value="Porto Novo">Porto Novo</option><option value="Ribeira Brava">Ribeira Brava</option><option value="Ponta do Sol">Ponta do Sol</option><option value="Vila do Maio">Vila do Maio</option><option value="Sal Rei">Sal Rei</option><option value="Pombas">Pombas</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Cayman Islands"){ var str=state_selected; str=str+'<option value="George Town">George Town</option><option value="West Bay">West Bay</option><option value="Bodden Town">Bodden Town</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Central African Republic"){ var str=state_selected; str=str+'<option value="Bangui">Bangui</option><option value="Carnot">Carnot</option><option value="Mbaiki">Mbaiki</option><option value="Berberati">Berberati</option><option value="Bimbo">Bimbo</option><option value="Bouar">Bouar</option><option value="Bambari">Bambari</option><option value="Nola,">Nola,</option><option value="Bria">Bria</option><option value="Bossangoa">Bossangoa</option><option value="Bozoum">Bozoum</option><option value="Bangassou">Bangassou</option><option value="Sibut">Sibut</option><option value="Paoua">Paoua</option><option value="Mobaye">Mobaye</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Chad"){ var str=state_selected; str=str+'<option value="Moundou">Moundou</option><option value="Sarh">Sarh</option><option value="Abeche">Abeche</option><option value="Kelo">Kelo</option><option value="Koumra">Koumra</option><option value="Pala">Pala</option><option value="Am Timan">Am Timan</option><option value="Bongor">Bongor</option><option value="Mongo">Mongo</option><option value="Doba">Doba</option><option value="Ati">Ati</option><option value="Lai">Lai</option><option value="Oum Hadjer">Oum Hadjer</option><option value="Bitkine">Bitkine</option><option value="Mao">Mao</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Chile"){ var str=state_selected; str=str+'<option value="Santiago">Santiago</option><option value="Antofagasta">Antofagasta</option><option value="Vina Del Mar">Vina Del Mar</option><option value="Valparaiso">Valparaiso</option><option value="Talcahuano">Talcahuano</option><option value="San Bernardo">San Bernardo</option><option value="Temuco">Temuco</option><option value="Iquique">Iquique</option><option value="Concepcion">Concepcion</option><option value="Rancagua">Rancagua</option><option value="Talca">Talca</option><option value="Arica">Arica</option><option value="Coquimbo">Coquimbo</option><option value="Puerto Montt">Puerto Montt</option><option value="La Serena">La Serena</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="China"){ var str=state_selected; str=str+'<option value="Beijing">Beijing</option><option value="Shanghai">Shanghai</option><option value="Hong Kong">Hong Kong</option><option value="Tianjin">Tianjin</option><option value="Wuhan">Wuhan</option><option value="Guangzhou">Guangzhou</option><option value="Shenzhen">Shenzhen</option><option value="Shenyang">Shenyang</option><option value="Chongqing">Chongqing</option><option value="New Taipei">New Taipei</option><option value="Nanjing">Nanjing</option><option value="Harbin">Harbin</option><option value="Taipei">Taipei</option><option value="Chengdu">Chengdu</option><option value="Changchun">Changchun</option><option value="Hangzhou">Hangzhou</option><option value="Jinan">Jinan</option><option value="Dalian">Dalian</option><option value="Taiyuan">Taiyuan</option><option value="Zhengzhou">Zhengzhou</option><option value="Qingdao">Qingdao</option><option value="Xiamen">Xiamen</option><option value="Quanzhou">Quanzhou</option><option value="Shijiazhuang">Shijiazhuang</option><option value="Kunming">Kunming</option><option value="Lanzhou">Lanzhou</option><option value="Kaohsiung">Kaohsiung</option><option value="Changsha">Changsha</option><option value="Nanchang">Nanchang</option><option value="Guiyang">Guiyang</option><option value="Mianyang">Mianyang</option><option value="Nanchong">Nanchong</option><option value="Neijiang">Neijiang</option><option value="Luzhou">Luzhou</option><option value="Anshan">Anshan</option><option value="Tangshan">Tangshan</option><option value="Anyang">Anyang</option><option value="Wuxi">Wuxi</option><option value="Jilin City">Jilin City</option><option value="Fushun">Fushun</option><option value="Fuzhou">Fuzhou</option><option value="Suzhou">Suzhou</option><option value="Baotou">Baotou</option><option value="Xuzhou">Xuzhou</option><option value="Hefei">Hefei</option><option value="Taichung">Taichung</option><option value="Handan">Handan</option><option value="Luoyang">Luoyang</option><option value="Nanyang">Nanyang</option><option value="Jingzhou">Jingzhou</option><option value="Nanning">Nanning</option><option value="Datong">Datong</option><option value="Shantou">Shantou</option><option value="Yantai">Yantai</option><option value="Huainan">Huainan</option><option value="Benxi">Benxi</option><option value="Changzhou">Changzhou</option><option value="Hohhot">Hohhot</option><option value="Liuzhou">Liuzhou</option><option value="Ningbo">Ningbo</option><option value="Shangqiu">Shangqiu</option><option value="Tainan">Tainan</option><option value="Weifang">Weifang</option><option value="Changde">Changde</option><option value="Hengyang">Hengyang</option><option value="Yiyang">Yiyang</option><option value="Xining">Xining</option><option value="Yinchuan">Yinchuan</option><option value="Baoding">Baoding</option><option value="Yichang">Yichang</option><option value="Xiangyang">Xiangyang</option><option value="Foshan">Foshan</option><option value="Macau">Macau</option><option value="Hsinchu">Hsinchu</option><option value="Taoyuan">Taoyuan</option><option value="Keelung">Keelung</option><option value="Chiayi">Chiayi</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Christmas Island"){ var str=state_selected; str=str+'<option value="Drumsite">Drumsite</option><option value="Flying Fish Cove">Flying Fish Cove</option><option value="Settlement">Settlement</option><option value="South Point">South Point</option><option value="The Settlement">The Settlement</option><option value="Waterfall">Waterfall</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Cocos (Keeling) Islands"){ var str=state_selected; str=str+'<option value="Bantam Village">Bantam Village</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Colombia"){ var str=state_selected; str=str+'<option value="Bogota">Bogota</option><option value="Cali">Cali</option><option value="Medellin">Medellin</option><option value="Barranquilla">Barranquilla</option><option value="Cartagena">Cartagena</option><option value="Cucuta">Cucuta</option><option value="Bucaramanga">Bucaramanga</option><option value="Pereira">Pereira</option><option value="Santa Marta">Santa Marta</option><option value="Ibague">Ibague</option><option value="Bello">Bello</option><option value="Pasto">Pasto</option><option value="Manizales">Manizales</option><option value="Neiva">Neiva</option><option value="Soledad">Soledad</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Comoros"){ var str=state_selected; str=str+'<option value="Moroni">Moroni</option><option value="Mutsamudu">Mutsamudu</option><option value="Fomboni">Fomboni</option><option value="Domoni">Domoni</option><option value="Mitsamiouli">Mitsamiouli</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Congo"){ var str=state_selected; str=str+'<option value="Brazzaville">Brazzaville</option><option value="Nkayi">Nkayi</option><option value="Loubomo">Loubomo</option><option value="Loandjili">Loandjili</option><option value="Madingou">Madingou</option><option value="Mossendjo">Mossendjo</option><option value="Gamboma">Gamboma</option><option value="Impfondo">Impfondo</option><option value="Sibiti">Sibiti</option><option value="Ouesso">Ouesso</option><option value="Owando">Owando</option><option value="Kinkala">Kinkala</option><option value="Djambala">Djambala</option><option value="Ewo">Ewo</option><option value="Matsanga">Matsanga</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Congo, The Democratic Republic Of The"){ var str=state_selected; str=str+'<option value="Bomassa">Bomassa</option><option value="Brazzaville">Brazzaville</option><option value="Diosso">Diosso</option><option value="Djambala">Djambala</option><option value="Ewo">Ewo</option><option value="Gamboma">Gamboma</option><option value="Impfondo">Impfondo</option><option value="Kayes">Kayes</option><option value="Kinkala">Kinkala</option><option value="Loubomo">Loubomo</option><option value="Madingo-Kayes">Madingo-Kayes</option><option value="Madingou">Madingou</option><option value="Makoua">Makoua</option><option value="Matsanga">Matsanga</option><option value="Mbinda">Mbinda</option><option value="Mossendjo">Mossendjo</option><option value="Ngamaba-Mfilou">Ngamaba-Mfilou</option><option value="Nkayi">Nkayi</option><option value="Owando">Owando</option><option value="Oyo">Oyo</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Cook Islands"){ var str=state_selected; str=str+'<option value="Avarua">Avarua</option><option value="Amuri">Amuri</option><option value="Omoka">Omoka</option><option value="Roto">Roto</option><option value="Tauhunu">Tauhunu</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Costa Rica"){ var str=state_selected; str=str+'<option value="San Jose">San Jose</option><option value="Limon">Limon</option><option value="San Francisco">San Francisco</option><option value="Alajuela">Alajuela</option><option value="Liberia">Liberia</option><option value="Paraiso">Paraiso</option><option value="Desamparados">Desamparados</option><option value="Puntarenas">Puntarenas</option><option value="Curridabat">Curridabat</option><option value="San Vicente">San Vicente</option><option value="Purral">Purral</option><option value="Turrialba">Turrialba</option><option value="San Miguel">San Miguel</option><option value="San Pedro">San Pedro</option><option value="San Rafael Abajo">San Rafael Abajo</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Cote DIvoire"){ var str=state_selected; str=str+'<option value="Abidjan">Abidjan</option><option value="Bouake">Bouake</option><option value="Daloa">Daloa</option><option value="Yamoussoukro">Yamoussoukro</option><option value="San-pedro">San-pedro</option><option value="Divo">Divo</option><option value="Korhogo">Korhogo</option><option value="Anyama">Anyama</option><option value="Abengourou">Abengourou</option><option value="Man">Man</option><option value="Gagnoa">Gagnoa</option><option value="Soubre">Soubre</option><option value="Agboville">Agboville</option><option value="Dabou">Dabou</option><option value="Bouafle">Bouafle</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Croatia"){ var str=state_selected; str=str+'<option value="Zagreb">Zagreb</option><option value="Split">Split</option><option value="Rijeka">Rijeka</option><option value="Osijek">Osijek</option><option value="Zadar">Zadar</option><option value="Slavonski Brod">Slavonski Brod</option><option value="Pula">Pula</option><option value="Sesvete">Sesvete</option><option value="Karlovac">Karlovac</option><option value="Varazdin">Varazdin</option><option value="Sibenik">Sibenik</option><option value="Sisak">Sisak</option><option value="Velika Gorica">Velika Gorica</option><option value="Vinkovci">Vinkovci</option><option value="Vukovar">Vukovar</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Cuba"){ var str=state_selected; str=str+'<option value="Santiago”>Santiago </option><option value="Camaguey">Camaguey</option><option value="Holguin">Holguin</option><option value="Guantanamo">Guantanamo</option><option value="Santa Clara">Santa Clara</option><option value="Bayamo">Bayamo</option><option value="Pinar Del Rio">Pinar Del Rio</option><option value="Cienfuegos">Cienfuegos</option><option value="Matanzas">Matanzas</option><option value="Manzanillo">Manzanillo</option><option value="Sancti Spiritus">Sancti Spiritus</option><option value="Palma Sorianoa">Palma Sorianoa</option><option value="Cardenas">Cardenas</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Cyprus"){ var str=state_selected; str=str+'<option value="Lemesos">Lemesos</option><option value="Larnaca">Larnaca</option><option value="Gazimagusa">Gazimagusa</option><option value="Nicosia">Nicosia</option><option value="Pafos">Pafos</option><option value="Girne">Girne</option><option value="Guzelyurt">Guzelyurt</option><option value="Aradippou">Aradippou</option><option value="Paralimni">Paralimni</option><option value="Lefka">Lefka</option><option value="Geri">Geri</option><option value="Ypsonas">Ypsonas</option><option value="Livadia">Livadia</option><option value="Dromolaxia">Dromolaxia</option><option value="Dipkarpaz">Dipkarpaz</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Czech Republic"){ var str=state_selected; str=str+'<option value="Prague">Prague</option><option value="Brno">Brno</option><option value="Ostrava">Ostrava</option><option value="Plzen">Plzen</option><option value="Olomouc">Olomouc</option><option value="Liberec">Liberec</option><option value="Ceske Budejovice">Ceske Budejovice</option><option value="Hradec Kralove">Hradec Kralove</option><option value="Usti">Usti</option><option value="Pardubice">Pardubice</option><option value="Havirov">Havirov</option><option value="Zlin">Zlin</option><option value="Kladno">Kladno</option><option value="Most">Most</option><option value="Karvina">Karvina</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Denmark"){ var str=state_selected; str=str+'<option value="Copenhagen">Copenhagen</option><option value="Arhus">Arhus</option><option value="Odense">Odense</option><option value="Aalborg">Aalborg</option><option value="Esbjerg">Esbjerg</option><option value="Randers">Randers</option><option value="Kolding">Kolding</option><option value="Vejle">Vejle</option><option value="Horsens">Horsens</option><option value="Roskilde">Roskilde</option><option value="Greve Strand">Greve Strand</option><option value="Naestved">Naestved</option><option value="Silkeborg">Silkeborg</option><option value="Fredericia">Fredericia</option><option value="Horsholm">Horsholm</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Djibouti"){ var str=state_selected; str=str+'<option value="Ali Sabieh">Ali Sabieh</option><option value="Tadjourah">Tadjourah</option><option value="Obock">Obock</option><option value="Dikhil">Dikhil</option><option value="Arta">Arta</option><option value="Holhol">Holhol</option><option value="Dorra">Dorra</option><option value="Galafi">Galafi</option><option value="Loyada">Loyada</option><option value="Alaili Dadda">Alaili Dadda</option><option value="As Ela">As Ela</option><option value="Assamo">Assamo</option><option value="Balho">Balho</option><option value="Chebelle">Chebelle</option><option value="Daimoli">Daimoli</option><option value="Daoudaouya">Daoudaouya</option><option value="Dorale">Dorale</option><option value="Doumera">Doumera</option><option value="Godoria">Godoria</option><option value="Khor Angar">Khor Angar</option><option value="Randa">Randa</option><option value="Ras Siyyan">Ras Siyyan</option><option value="Sagallou">Sagallou</option><option value="Yoboki">Yoboki</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Dominica"){ var str=state_selected; str=str+'<option value="Roseau">Roseau</option><option value="Portsmouth">Portsmouth</option><option value="Berekua">Berekua</option><option value="Marigot">Marigot</option><option value="Atkinson">Atkinson</option><option value="La Plaine">La Plaine</option><option value="Mahaut">Mahaut</option><option value="Castle Bruce">Castle Bruce</option><option value="Wesley">Wesley</option><option value="Coulihaut">Coulihaut</option><option value="Barroui">Barroui</option><option value="Pointe Michel">Pointe Michel</option><option value="Pont Casse">Pont Casse</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Dominican Republic"){ var str=state_selected; str=str+'<option value="Santo Domingo">Santo Domingo</option><option value="Santiago">Santiago</option><option value="Punta Cana">Punta Cana</option><option value="San Pedro De Macoris">San Pedro De Macoris</option><option value="La Romana">La Romana</option><option value="San Cristobal">San Cristobal</option><option value="San Francisco De Macoris">San Francisco De Macoris</option><option value="Higuey">Higuey</option><option value="Puerto Plata">Puerto Plata</option><option value="La Vega">La Vega</option><option value="Barahona">Barahona</option><option value="Bonao">Bonao</option><option value="San Juan de la Maguana">San Juan de la Maguana</option><option value="Dominican Republic">Dominican Republic</option><option value="Bajos de Haina">Bajos de Haina</option><option value="Bani">Bani</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Ecuador"){ var str=state_selected; str=str+'<option value="Guayaquil">Guayaquil</option><option value="Quito">Quito</option><option value="Cuenca">Cuenca</option><option value="Santo Domingo">Santo Domingo</option><option value="Machala">Machala</option><option value="Manta">Manta</option><option value="Portoviejo">Portoviejo</option><option value="Ambato">Ambato</option><option value="Riobamba">Riobamba</option><option value="Quevedo">Quevedo</option><option value="Loja">Loja</option><option value="Milagro, Ecuador">Milagro, Ecuador</option><option value="Ibarra, Ecuador">Ibarra, Ecuador</option><option value="Esmeraldas, Ecuador">Esmeraldas, Ecuador</option><option value="Babahoyo, Ecuador">Babahoyo, Ecuador</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Egypt"){ var str=state_selected; str=str+'<option value="Cairo">Cairo</option><option value="Alexandria">Alexandria</option><option value="Gizeh">Gizeh</option><option value="Port Said">Port Said</option><option value="Suez">Suez</option><option value="El Mahalla el Kubra">El Mahalla el Kubra</option><option value="Luxor">Luxor</option><option value="Asyut">Asyut</option><option value="Tanta">Tanta</option><option value="El Faiyum">El Faiyum</option><option value="smailia">smailia</option><option value="Aswan">Aswan</option><option value="Qena">Qena</option><option value="Sohag">Sohag</option><option value="Beni Suef">Beni Suef</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Western Sahara"){ var str=state_selected; str=str+'<option value="El Aaiún">El Aaiún</option><option value="Laayoune Plage">Laayoune Plage</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="El Salvador"){ var str=state_selected; str=str+'<option value="San Salvador">San Salvador</option><option value="Soyapango">Soyapango</option><option value="Santa Ana">Santa Ana</option><option value="Mejicanos">Mejicanos</option><option value="Nueva San Salvador">Nueva San Salvador</option><option value="Apopa">Apopa</option><option value="Delgado">Delgado</option><option value="Sonsonate">Sonsonate</option><option value="San Marcos">San Marcos</option><option value="Usulutan">Usulutan</option><option value="Cojutepeque">Cojutepeque</option><option value="Cuscatancingo">Cuscatancingo</option><option value="Zacatecoluca">Zacatecoluca</option><option value="San Martin">San Martin</option><option value="Ilopango">Ilopango</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Equatorial Guinea"){ var str=state_selected; str=str+'<option value="Bata">Bata</option><option value="Malabo">Malabo</option><option value="Ebebiyin">Ebebiyin</option><option value="Aconibe">Aconibe</option><option value="Anisoc">Anisoc</option><option value="Luba">Luba</option><option value="Evinayong">Evinayong</option><option value="Mongomo">Mongomo</option><option value="Micomeseng">Micomeseng</option><option value="Mbini">Mbini</option><option value="Acurenam">Acurenam</option><option value="Riaba">Riaba</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Eritrea"){ var str=state_selected; str=str+'<option value="Asmara">Asmara</option><option value="Addi Ugri">Addi Ugri</option><option value="Barentu">Barentu</option><option value="Ginda">Ginda</option><option value="Edd">Edd</option><option value="Teseney">Teseney</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Estonia"){ var str=state_selected; str=str+'<option value="Tallinn">Tallinn</option><option value="Tartu">Tartu</option><option value="Narva">Narva</option><option value="Kohtla-jarve">Kohtla-jarve</option><option value="Parnu">Parnu</option><option value="Viljandi">Viljandi</option><option value="Rakvere">Rakvere</option><option value="Sillamae">Sillamae</option><option value="Maardu">Maardu</option><option value="Kuressaare">Kuressaare</option><option value="Voru">Voru</option><option value="Valga">Valga</option><option value="Haapsalu">Haapsalu</option><option value="Johvi">Johvi</option><option value="Paide">Paide</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Ethiopia"){ var str=state_selected; str=str+'<option value="Addis Abeba">Addis Abeba</option><option value="Dire Dawa">Dire Dawa</option><option value="Nazret">Nazret</option><option value="Bahir Dar">Bahir Dar</option><option value="Gondar">Gondar</option><option value="Dese">Dese</option><option value="Awassa">Awassa</option><option value="Jimma">Jimma</option><option value="Debre Zeyit">Debre Zeyit</option><option value="Kembolcha">Kembolcha</option><option value="Harer">Harer</option><option value="Assela">Assela</option><option value="Debre Birhan">Debre Birhan</option><option value="Jijiga">Jijiga</option><option value="Ziway">Ziway</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Falkland Islands (Malvinas)"){ var str=state_selected; str=str+'<option value="Anson">Anson</option><option value="Bahia Fox">Bahia Fox</option><option value="Beaver Settlement">Beaver Settlement</option><option value="Black Rock">Black Rock</option><option value="Bluff Cove">Bluff Cove</option><option value="Bluff Cove Settlement">Bluff Cove Settlement</option><option value="Bombilia House">Bombilia House</option><option value="Burnside House">Burnside House</option><option value="Camp Verde">Camp Verde</option><option value="Campo Verde">Campo Verde</option><option value="Cantera de Arena">Cantera de Arena</option><option value="Ceritos">Ceritos</option><option value="Cerritos">Cerritos</option><option value="Chartres">Chartres</option><option value="Chartres Settlement">Chartres Settlement</option><option value="Cranmer">Cranmer</option><option value="Darwin">Darwin</option><option value="Darwin Settlement">Darwin Settlement</option><option value="Dos Lomas">Dos Lomas</option><option value="Douglas Settlement">Douglas Settlement</option><option value="Douglas Station">Douglas Station</option><option value="Dunnose Head">Dunnose Head</option><option value="Dunnose Head Settlement">Dunnose Head Settlement</option><option value="East Settlement">East Settlement</option><option value="Estancia House">Estancia House</option><option value="Evelyn Station">Evelyn Station</option><option value="Fitzroy">Fitzroy</option><option value="Fitzroy North">Fitzroy North</option><option value="Fitzroy Settlement">Fitzroy Settlement</option><option value="Fitzroy South">Fitzroy South</option><option value="Foam Creek House">Foam Creek House</option><option value="Goose Green">Goose Green</option><option value="Goose Green Settlement">Goose Green Settlement</option><option value="Green Patch">Green Patch</option><option value="Green Patch Settlement">Green Patch Settlement</option><option value="Hill Cove">Hill Cove</option><option value="Hope Cottage">Hope Cottage</option><option value="Horseshoe Bay">Horseshoe Bay</option><option value="Johnson Harbour Settlement">Johnson Harbour Settlement</option><option value="Johnson Harbour Settlement">Johnson Harbour Settlement</option><option value="Johnsons Harbour">Johnsons Harbour</option><option value="Keppel Settlement">Keppel Settlement</option><option value="Little Chartres">Little Chartres</option><option value="Lively Settlement">Lively Settlement</option><option value="Mariqueta">Mariqueta</option><option value="Mariquita">Mariquita</option><option value="Mid Rancho">Mid Rancho</option><option value="New Island Settlement">New Island Settlement</option><option value="North Arm">North Arm</option><option value="North Arm Settlement">North Arm Settlement</option><option value="Orqueta">Orqueta</option><option value="Pebble Island Farm">Pebble Island Farm</option><option value="Pebble Island Settlement">Pebble Island Settlement</option><option value="Piedra Sola">Piedra Sola</option><option value="Port Howard">Port Howard</option><option value="Port Louis">Port Louis</option><option value="Port Louis Settlement">Port Louis Settlement</option><option value="Port Louis South">Port Louis South</option><option value="Port Pattison">Port Pattison</option><option value="Port San Carlos">Port San Carlos</option><option value="Port San Carlos">Port San Carlos</option><option value="Port San Carlos”>Port San Carlos </option><option value="Port Stanley">Port Stanley</option><option value="Port Stephens">Port Stephens</option><option value="Port Stephens Settlement">Port Stephens Settlement</option><option value="Rincon Grande">Rincon Grande</option><option value="Rincon Grande Settlement">Rincon Grande Settlement</option><option value="Roy Cove">Roy Cove</option><option value="Roy Cove Landing Strip">Roy Cove Landing Strip</option><option value="Roy Cove Settlement">Roy Cove Settlement</option><option value="STANLEY">STANLEY</option><option value="Saint Louis">Saint Louis</option><option value="Salvador">Salvador</option><option value="Salvador Settlement">Salvador Settlement</option><option value="Salvador Settlement Corral">Salvador Settlement Corral</option><option value="San Carlos">San Carlos</option><option value="San Carlos Estate">San Carlos Estate</option><option value="San Carlos Settlement">San Carlos Settlement</option><option value="Sand Fountain">Sand Fountain</option><option value="Saunders Island Settlement">Saunders Island Settlement</option><option value="Sea Lion Island Landing Strip">Sea Lion Island Landing Strip</option><option value="Soledad">Soledad</option><option value="Spring Point">Spring Point</option><option value="Spring Point Settlement">Spring Point Settlement</option><option value="Stanley">Stanley</option><option value="Stanley Harbour">Stanley Harbour</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Faroe Islands"){ var str=state_selected; str=str+'<option value="Torshavn">Torshavn</option><option value="Klaksvik">Klaksvik</option><option value="Hoyvik">Hoyvik</option><option value="Argir">Argir</option><option value="Vagur">Vagur</option><option value="Vestmanna">Vestmanna</option><option value="Tvoroyri">Tvoroyri</option><option value="Sorvag">Sorvag</option><option value="Leirvik">Leirvik</option><option value="Strendur">Strendur</option><option value="Toftir">Toftir</option><option value="Saltangara">Saltangara</option><option value="Sandavagur">Sandavagur</option><option value="Hvalba">Hvalba</option><option value="Skali">Skali</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Fiji"){ var str=state_selected; str=str+'<option value="Ba">Ba</option><option value="Labasa">Labasa</option><option value="Lami">Lami</option><option value="Levuka">Levuka</option><option value="Nasinu">Nasinu</option><option value="Nausori">Nausori</option><option value="Savusavu">Savusavu</option><option value="Sigatoka">Sigatoka</option><option value="Tavua">Tavua</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Finland"){ var str=state_selected; str=str+'<option value="Helsinki">Helsinki</option><option value="Espoo">Espoo</option><option value="Tampere">Tampere</option><option value="Turku">Turku</option><option value="Oulu">Oulu</option><option value="Lahti">Lahti</option><option value="Kuopio">Kuopio</option><option value="Jyvaskyla">Jyvaskyla</option><option value="Pori">Pori</option><option value="Lappeenranta">Lappeenranta</option><option value="Vaasa">Vaasa</option><option value="Kotka">Kotka</option><option value="Joensuu">Joensuu</option><option value="Hameenlinna">Hameenlinna</option><option value="Porvoo">Porvoo</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="France"){ var str=state_selected; str=str+'<option value="Paris">Paris</option><option value="Marseille">Marseille</option><option value="Lyon">Lyon</option><option value="Toulouse">Toulouse</option><option value="Nice">Nice</option><option value="Nantes">Nantes</option><option value="Strasbourg">Strasbourg</option><option value="Montpellier">Montpellier</option><option value="Bordeaux">Bordeaux</option><option value="Rennes">Rennes</option><option value="Reims">Reims</option><option value="Lille">Lille</option><option value="Le Havre">Le Havre</option><option value="Saint-etienne">Saint-etienne</option><option value="Angers">Angers</option><option value="Grenoble">Grenoble</option><option value="Toulon">Toulon</option><option value="Dijon">Dijon</option><option value="Brest">Brest</option><option value="Le Mans">Le Mans</option><option value="Aix-en-Provence">Aix-en-Provence</option><option value="Amiens">Amiens</option><option value="Nimes">Nimes</option><option value="Clermont-Ferrand">Clermont-Ferrand</option><option value="Tours">Tours</option><option value="Limoges">Limoges</option><option value="Metz">Metz</option><option value="Villeurbanne">Villeurbanne</option><option value="Besancon">Besancon</option><option value="Orleans">Orleans</option><option value="Caen">Caen</option><option value="Mulhouse">Mulhouse</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="French Guiana"){ var str=state_selected; str=str+'<option value="Cayenne">Cayenne</option><option value="Matoury">Matoury</option><option value="Kourou">Kourou</option><option value="Macouria">Macouria</option><option value="Mana">Mana</option><option value="Apatou">Apatou</option><option value="Grand-Santi">Grand-Santi</option><option value="Sinnamary">Sinnamary</option><option value="Saint-Georges">Saint-Georges</option><option value="Roura">Roura</option><option value="Iracoubo">Iracoubo</option><option value="Camopi">Camopi</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="French Polynesia"){ var str=state_selected; str=str+'<option value="Faaa">Faaa</option><option value="Papeete">Papeete</option><option value="Punaauia">Punaauia</option><option value="Pirae">Pirae</option><option value="Mahina">Mahina</option><option value="Paea">Paea</option><option value="Papara">Papara</option><option value="Arue">Arue</option><option value="Afaahiti">Afaahiti</option><option value="Vaitape">Vaitape</option><option value="Mataiea">Mataiea</option><option value="Paopao">Paopao</option><option value="Papeari">Papeari</option><option value="Haapiti">Haapiti</option><option value="Uturoa">Uturoa</option><option value="Afareaitu">Afareaitu</option><option value="Toahotu">Toahotu</option><option value="Tiarei">Tiarei</option><option value="Vairao">Vairao</option><option value="Tautira">Tautira</option><option value="Teavaro">Teavaro</option><option value="Pueu">Pueu</option><option value="Papetoai">Papetoai</option><option value="Tevaitoa">Tevaitoa</option><option value="Hitiaa">Hitiaa</option><option value="Atuona">Atuona</option><option value="Faaone">Faaone</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="French Southern Territories"){ var str=state_selected; str=str+'<option value="Port-aux-francais">Port-aux-francais</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Gabon"){ var str=state_selected; str=str+'<option value="Libreville">Libreville</option><option value="Port-Gentil">Port-Gentil</option><option value="Oyem">Oyem</option><option value="Moanda">Moanda</option><option value="Mouila">Mouila</option><option value="Lambarene">Lambarene</option><option value="Tchibanga">Tchibanga</option><option value="Koulamoutou">Koulamoutou</option><option value="Makokou">Makokou</option><option value="Bitam">Bitam</option><option value="Tsogni">Tsogni</option><option value="Gamba">Gamba</option><option value="Mounana">Mounana</option><option value="Ntoum">Ntoum</option><option value="Nkan">Nkan</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Gambia"){ var str=state_selected; str=str+'<option value="Serekunda">Serekunda</option><option value="Brikama">Brikama</option><option value="Bakau">Bakau</option><option value="Farafenni">Farafenni</option><option value="Banjul">Banjul</option><option value="Lamin">Lamin</option><option value="Basse">Basse</option><option value="Sukuta">Sukuta</option><option value="Gunjur">Gunjur</option><option value="Kuntaur">Kuntaur</option><option value="Brufut">Brufut</option><option value="Sabi">Sabi</option><option value="Bansang">Bansang</option><option value="Gambissara">Gambissara</option><option value="Barra">Barra</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Georgia"){ var str=state_selected; str=str+'<option value="Atlanta">Atlanta</option><option value="Columbus">Columbus</option><option value="Savannah">Savannah</option><option value="Sandy Springs">Sandy Springs</option><option value="Macon">Macon</option><option value="Roswell">Roswell</option><option value="Albany">Albany</option><option value="Marietta">Marietta</option><option value="Warner Robins">Warner Robins</option><option value="Smyrna">Smyrna</option><option value="Valdosta">Valdosta</option><option value="North Atlanta">North Atlanta</option><option value="Redan">Redan</option><option value="Dunwoody">Dunwoody</option><option value="East Point">East Point</option><option value="Rome">Rome</option><option value="Alpharetta">Alpharetta</option><option value="Peachtree">Peachtree</option><option value="Gainesville">Gainesville</option><option value="Douglasville">Douglasville</option><option value="Dalton">Dalton</option><option value="Mableton">Mableton</option><option value="Lawrenceville">Lawrenceville</option><option value="Kennesaw">Kennesaw</option><option value="Hinesville">Hinesville</option><option value="Martinez">Martinez</option><option value="Tucker">Tucker</option><option value="Duluth">Duluth</option><option value="Statesboro">Statesboro</option><option value="Griffin">Griffin</option><option value="Newnan">Newnan</option><option value="Carrollton, GA">Carrollton, GA</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Germany"){ var str=state_selected; str=str+'<option value="Berlin">Berlin</option><option value="Hamburg">Hamburg</option><option value="Munich">Munich</option><option value="Cologne">Cologne</option><option value="Frankfurt">Frankfurt</option><option value="Dortmund">Dortmund</option><option value="Stuttgart">Stuttgart</option><option value="Dusseldorf">Dusseldorf</option><option value="Essen">Essen</option><option value="Bremen">Bremen</option><option value="Hanover">Hanover</option><option value="Duisburg">Duisburg</option><option value="Nuremberg">Nuremberg</option><option value="Leipzig">Leipzig</option><option value="Dresden">Dresden</option><option value="Bochum">Bochum</option><option value="Wuppertal">Wuppertal</option><option value="Bielefeld">Bielefeld</option><option value="Bonn">Bonn</option><option value="Mannheim">Mannheim</option><option value="Karlsruhe">Karlsruhe</option><option value="Munster">Munster</option><option value="Wiesbaden">Wiesbaden</option><option value="Gelsenkirchen">Gelsenkirchen</option><option value="Monchengladbach">Monchengladbach</option><option value="Augsburg">Augsburg</option><option value="Aachen">Aachen</option><option value="Chemnitz">Chemnitz</option><option value="Brunswick">Brunswick</option><option value="Krefeld">Krefeld</option><option value="Kiel">Kiel</option><option value="Halle">Halle</option><option value="Magdeburg">Magdeburg</option><option value="Oberhausen">Oberhausen</option><option value="Freiburg">Freiburg</option><option value="Lubeck">Lubeck</option><option value="Hagen">Hagen</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Ghana"){ var str=state_selected; str=str+'<option value="Accra">Accra</option><option value="Kumasi">Kumasi</option><option value="Tamale">Tamale</option><option value="Tema">Tema</option><option value="Teshie">Teshie</option><option value="Cape Coast">Cape Coast</option><option value="Obuasi">Obuasi</option><option value="Takoradi">Takoradi</option><option value="Sekondi">Sekondi</option><option value="Koforidua">Koforidua</option><option value="Nungua">Nungua</option><option value="Madina">Madina</option><option value="Sunyani">Sunyani</option><option value="Yendi">Yendi</option><option value="Ho">Ho</option><option value="Tafo">Tafo</option><option value="Wa">Wa</option><option value="Swedru">Swedru</option><option value="Ejura">Ejura</option><option value="Bawku">Bawku</option><option value="Nkawkaw">Nkawkaw</option><option value="Tarkwa">Tarkwa</option><option value="Techiman">Techiman</option><option value="Winneba">Winneba</option><option value="Bolgatanga">Bolgatanga</option>';	str=str+state_selected2; html_input(str);}	
		else if(objValue==="Gibraltar"){ var str=state_selected; str=str+'<option value=" Gibraltar"> Gibraltar</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Greece"){ var str=state_selected; str=str+'<option value="Athens">Athens</option><option value="Thessaloniki">Thessaloniki</option><option value="Patrai">Patrai</option><option value="Peristerion">Peristerion</option><option value="Iraklion">Iraklion</option><option value="Larisa">Larisa</option><option value="Kallithea">Kallithea</option><option value="Nikaia">Nikaia</option><option value="Kalamaria">Kalamaria</option><option value="Volos">Volos</option><option value="Akharnai">Akharnai</option><option value="Keratsinion">Keratsinion</option><option value="Nea Smirni">Nea Smirni</option><option value="Khalandrion">Khalandrion</option><option value="Aigaleo">Aigaleo</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Greenland"){ var str=state_selected; str=str+'<option value="Nuuk">Nuuk</option><option value="Sisimiut">Sisimiut</option><option value="Ilulissat">Ilulissat</option><option value="Qaqortoq">Qaqortoq</option><option value="Aasiaat">Aasiaat</option><option value="Paamiut">Paamiut</option><option value="Tasiilaq">Tasiilaq</option><option value="Narsaq">Narsaq</option><option value="Nanortalik">Nanortalik</option><option value="Qasigiannguit">Qasigiannguit</option><option value="Upernavik">Upernavik</option><option value="Kangaatsiaq">Kangaatsiaq</option><option value="Qaanaaq">Qaanaaq</option><option value="Illoqqortoormiut">Illoqqortoormiut</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Grenada"){ var str=state_selected; str=str+'<option value="Gouyave">Gouyave</option><option value="Grenville">Grenville</option><option value="Grenada">Grenada</option><option value="Hillsborough">Hillsborough</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Guadeloupe"){ var str=state_selected; str=str+'<option value="Les Abymes">Les Abymes</option><option value="Baie-Mahault">Baie-Mahault</option><option value="Le Gosier">Le Gosier</option><option value="Petit-Bourg">Petit-Bourg</option><option value="Sainte-Anne">Sainte-Anne</option><option value="Le Moule">Le Moule</option><option value="Sainte-Rose">Sainte-Rose</option><option value="Capesterre-Belle-Eau">Capesterre-Belle-Eau</option><option value="Lamentin">Lamentin</option><option value="Saint-francois">Saint-francois</option><option value="Basse-Terre">Basse-Terre</option><option value="Saint-Claude">Saint-Claude</option><option value="Trois-rivieres">Trois-rivieres</option><option value="Gourbeyre">Gourbeyre</option><option value="Petit-Canal">Petit-Canal</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Guam"){ var str=state_selected; str=str+'<option value="Agana Heights">Agana Heights</option><option value="Agat">Agat</option><option value="Asan-Maina">Asan-Maina</option><option value="Barrigada">Barrigada</option><option value="Chalan">Chalan</option><option value="Dededo">Dededo</option><option value="Inarajan">Inarajan</option><option value="Mangilao">Mangilao</option><option value="Merizo">Merizo</option><option value="Mongmong-Toto-Maite">Mongmong-Toto-Maite</option><option value="Piti">Piti</option><option value="Santa Rita">Santa Rita</option><option value="Sinajana">Sinajana</option><option value="Talofofo">Talofofo</option><option value="Tamuning”>Tamuning </option><option value="Umatac">Umatac</option><option value="Yigo">Yigo</option><option value="Yona">Yona</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Guatemala"){ var str=state_selected; str=str+'<option value="Guatemala">Guatemala</option><option value="Guatemala”>Guatemala </option><option value="Mixco">Mixco</option><option value="Villa Nueva">Villa Nueva</option><option value="Petapa">Petapa</option><option value="San Juan Sacatepequez">San Juan Sacatepequez</option><option value="Quetzaltenango">Quetzaltenango</option><option value="Villa Canales">Villa Canales</option><option value="Escuintla">Escuintla</option><option value="Chinautla">Chinautla</option><option value="Chimaltenango">Chimaltenango</option><option value="Chichicastenango">Chichicastenango</option><option value="Huehuetenango">Huehuetenango</option><option value="Amatitlan">Amatitlan</option><option value="Totonicapan">Totonicapan</option><option value="Santa Catarina Pinula">Santa Catarina Pinula</option><option value="Santa Lucia Cotzumalguapa">Santa Lucia Cotzumalguapa</option><option value="Puerto Barrios">Puerto Barrios</option><option value="San Francisco El Alto">San Francisco El Alto</option><option value="Coban">Coban</option><option value="San Jose Pinula">San Jose Pinula</option><option value="San Pedro Ayampuc">San Pedro Ayampuc</option><option value="Jalapa">Jalapa</option><option value="Solola">Solola</option><option value="Mazatenango">Mazatenango</option><option value="Chiquimula">Chiquimula</option><option value="San Pedro Sacatepequez">San Pedro Sacatepequez</option><option value="Antigua Guatemala">Antigua Guatemala</option><option value="Retalhuleu">Retalhuleu</option><option value="Zacapa">Zacapa</option><option value="Jutiapa, Guatemala">Jutiapa, Guatemala</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Guernsey"){ var str=state_selected; str=str+'<option value="Cheyenne">Cheyenne</option><option value="Laramie">Laramie</option><option value="Casper">Casper</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Guinea"){ var str=state_selected; str=str+'<option value="Conakry">Conakry</option><option value="Nzerekore">Nzerekore</option><option value="Kindia">Kindia</option><option value="Kankan">Kankan</option><option value="Kissidougou">Kissidougou</option><option value="Labe">Labe</option><option value="Siguiri">Siguiri</option><option value="Macenta">Macenta</option><option value="Mamou">Mamou</option><option value="Telimele">Telimele</option><option value="Tougue">Tougue</option><option value="Pita">Pita</option><option value="Boke">Boke</option><option value="Kouroussa">Kouroussa</option><option value="Beyla">Beyla</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Guinea-Bissau"){ var str=state_selected; str=str+'<option value="Bissau">Bissau</option><option value="Bafata">Bafata</option><option value="Gabu">Gabu</option><option value="Bissora">Bissora</option><option value="Bolama">Bolama</option><option value="Cacheu">Cacheu</option><option value="Bubaque">Bubaque</option><option value="Catio">Catio</option><option value="Mansoa">Mansoa</option><option value="Buba">Buba</option><option value="Quebo">Quebo</option><option value="Canchungo">Canchungo</option><option value="Farim">Farim</option><option value="Fulacunda">Fulacunda</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Guyana"){ var str=state_selected; str=str+'<option value="Georgetown">Georgetown</option><option value="Linden">Linden</option><option value="New Amsterdam">New Amsterdam</option><option value="Bartica">Bartica</option><option value="Skeldon">Skeldon</option><option value="Rosignol">Rosignol</option><option value="Ituni">Ituni</option><option value="Vreed en Hoop">Vreed en Hoop</option><option value="Fort Wellington">Fort Wellington</option><option value="Mahaicony">Mahaicony</option><option value="Mabaruma">Mabaruma</option><option value="Lethem">Lethem</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Haiti"){ var str=state_selected; str=str+'<option value="Port-au-Prince">Port-au-Prince</option><option value="Carrefour">Carrefour</option><option value="Delmas">Delmas</option><option value="Cap-haitien">Cap-haitien</option><option value="Petionville">Petionville</option><option value="Gonaives">Gonaives</option><option value="Saint-Marc">Saint-Marc</option><option value="Les Cayes">Les Cayes</option><option value="Verrettes">Verrettes</option><option value="Port-de-Pai">Port-de-Pai</option><option value="Jacmel">Jacmel</option><option value="Limbe">Limbe</option><option value="Jeremie">Jeremie</option><option value="Hinche">Hinche</option><option value="Petit Goave">Petit Goave</option><option value="Desdunes">Desdunes</option><option value="Dessalines">Dessalines</option><option value="Leogane">Leogane</option><option value="Ouanaminthe">Ouanaminthe</option><option value="Mirebalais">Mirebalais</option><option value="Grande Riviere Du Nord">Grande Riviere Du Nord</option><option value="Lascahobas">Lascahobas</option><option value="Pignon">Pignon</option><option value="Miragoane">Miragoane</option><option value="Saint-raphael">Saint-raphael</option><option value="Kenscoff">Kenscoff</option><option value="Derac">Derac</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Heard Island and Mcdonald Islands"){ var str=state_selected; str=str+'<option value="N/A">N/A</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Holy See (Vatican City State)"){ var str=state_selected; str=str+'<option value="Vatican City">Vatican City</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Honduras"){ var str=state_selected; str=str+'<option value="Tegucigalpa">Tegucigalpa</option><option value="San Pedro Sula">San Pedro Sula</option><option value="Choloma">Choloma</option><option value="La Ceiba">La Ceiba</option><option value="El Progreso">El Progreso</option><option value="Choluteca">Choluteca</option><option value="Comayagua">Comayagua</option><option value="Puerto Cortes">Puerto Cortes</option><option value="La Lima">La Lima</option><option value="Danli">Danli</option><option value="Siguatepeque">Siguatepeque</option><option value="Juticalpa">Juticalpa</option><option value="Catacamas">Catacamas</option><option value="Villanueva">Villanueva</option><option value="Tocoa">Tocoa</option><option value="Tela">Tela</option><option value="Santa Rosa De Copan">Santa Rosa De Copan</option><option value="Olanchito">Olanchito</option><option value="San Lorenzo">San Lorenzo</option><option value="Cofradia">Cofradia</option><option value="El Paraiso">El Paraiso</option><option value="La Paz">La Paz</option><option value="Yoro">Yoro</option><option value="Santa Barbara">Santa Barbara</option><option value="La Entrada">La Entrada</option><option value="Nacaome">Nacaome</option><option value="Intibuca">Intibuca</option><option value="Talanga">Talanga</option><option value="Guaimaca">Guaimaca</option><option value="Santa Rita">Santa Rita</option><option value="Sonaguera">Sonaguera</option><option value="Morazan">Morazan</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Hong Kong"){ var str=state_selected; str=str+'<option value="Aberdeen (Xianggangzi)">Aberdeen (Xianggangzi)</option><option value="Cheung Chau">Cheung Chau</option><option value="Discovery Bay”>Discovery Bay </option><option value="Fairview Park">Fairview Park</option><option value="Fanling - Sheung Shui">Fanling - Sheung Shui</option><option value="Hang Tau - Kam Tsin">Hang Tau - Kam Tsin</option><option value="Hung Shui Kiu">Hung Shui Kiu</option><option value="Kowloon”>Kowloon </option><option value="Kwai Chung">Kwai Chung</option><option value="Kwan Tei - Kan Tau">Kwan Tei - Kan Tau</option><option value="Ma On Shan">Ma On Shan</option><option value="Ma Wan (Park Island)">Ma Wan (Park Island)</option><option value="Pok Fu Lam">Pok Fu Lam</option><option value="Repulse Bay">Repulse Bay</option><option value="Sai Kung">Sai Kung</option><option value="Sha Tin">Sha Tin</option><option value="Shek Kong">Shek Kong</option><option value="Stanley (Chek Chue)">Stanley (Chek Chue)</option><option value="Tai Po">Tai Po</option><option value="Tai Po Tsai”>Tai Po Tsai </option><option value="Tai Tong">Tai Tong</option><option value="Tin Shui Wai">Tin Shui Wai</option><option value="Tseung Kwan">Tseung Kwan</option><option value="Tseun Wan (Quanwan)">Tseun Wan (Quanwan)</option><option value="Tsing Yi">Tsing Yi</option><option value="Tuen Mun">Tuen Mun</option><option value="Tung Chung (">Tung Chung (</option><option value="Victoria (Xianggang)">Victoria (Xianggang)</option><option value="Yuen Long">Yuen Long</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Hungary"){ var str=state_selected; str=str+'<option value="Budapest">Budapest</option><option value="Debrecen">Debrecen</option><option value="Miskolc">Miskolc</option><option value="Szeged">Szeged</option><option value="Pecs">Pecs</option><option value="Gyor">Gyor</option><option value="Nyiregyhaza">Nyiregyhaza</option><option value="Kecskemet">Kecskemet</option><option value="Szekesfehervar">Szekesfehervar</option><option value="Szombathely">Szombathely</option><option value="Szolnok">Szolnok</option><option value="Tatabanya">Tatabanya</option><option value="Kaposvar">Kaposvar</option><option value="Bekescsaba">Bekescsaba</option><option value="Zalaegerszeg">Zalaegerszeg</option><option value="Veszprem">Veszprem</option><option value="Erd">Erd</option><option value="Eger">Eger</option><option value="Sopron">Sopron</option><option value="Dunaujvaros">Dunaujvaros</option><option value="Nagykanizsa">Nagykanizsa</option><option value="Hodmezovasarhely">Hodmezovasarhely</option><option value="Salgotarjan">Salgotarjan</option><option value="Cegled">Cegled</option><option value="Ozd">Ozd</option><option value="Baja">Baja</option><option value="Szekszard">Szekszard</option><option value="Vac">Vac</option><option value="Papa">Papa</option><option value="Gyongyos">Gyongyos</option><option value="Kazincbarcika">Kazincbarcika</option><option value="Godollo">Godollo</option><option value="Gyula">Gyula</option><option value="Hajduboszormeny">Hajduboszormeny</option><option value="Kiskunfelegyhaza">Kiskunfelegyhaza</option><option value="Ajka">Ajka</option><option value="Oroshaza">Oroshaza</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Iceland"){ var str=state_selected; str=str+'<option value="Reykjavik">Reykjavik</option><option value="Kopavogur">Kopavogur</option><option value="Akureyri">Akureyri</option><option value="Keflavik">Keflavik</option><option value="Akranes">Akranes</option><option value="Selfoss">Selfoss</option><option value="Vestmannaeyjar">Vestmannaeyjar</option><option value="Grindavik">Grindavik</option><option value="Husavik">Husavik</option><option value="Borgarnes">Borgarnes</option><option value="Dalvik">Dalvik</option><option value="Stykkisholmur">Stykkisholmur</option><option value="Olafsvik">Olafsvik</option><option value="Vogar">Vogar</option><option value="Blonduos">Blonduos</option><option value="Bolungarvik">Bolungarvik</option><option value="Hvolsvollur">Hvolsvollur</option><option value="Hella">Hella</option><option value="Eyrarbakki">Eyrarbakki</option><option value="Hvammstangi">Hvammstangi</option><option value="Skagastrond">Skagastrond</option><option value="Stokkseyri">Stokkseyri</option><option value="Holmavik">Holmavik</option><option value="Hnifsdalur">Hnifsdalur</option><option value="Hellissandur">Hellissandur</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Indonesia"){ var str=state_selected; str=str+'<option value="Jakarta">Jakarta</option><option value="Surabaya">Surabaya</option><option value="Medan">Medan</option><option value="Bandung">Bandung</option><option value="Bekasi">Bekasi</option><option value="Tangerang">Tangerang</option><option value="Makasar">Makasar</option><option value="Semarang">Semarang</option><option value="Palembang">Palembang</option><option value="Depok">Depok</option><option value="Padang">Padang</option><option value="Bandar Lampung">Bandar Lampung</option><option value="Bogor">Bogor</option><option value="Malang">Malang</option><option value="Yogyakarta">Yogyakarta</option><option value="Banjarmasin">Banjarmasin</option><option value="Surakarta">Surakarta</option><option value="Pontianak">Pontianak</option><option value="Manado">Manado</option><option value="Balikpapan">Balikpapan</option><option value="Jambi">Jambi</option><option value="Denpasar">Denpasar</option><option value="Cimahi">Cimahi</option><option value="Ambon">Ambon</option><option value="Samarinda">Samarinda</option><option value="Pacet">Pacet</option><option value="Mataram">Mataram</option><option value="Tambun">Tambun</option><option value="Bengkulu">Bengkulu</option><option value="Jember">Jember</option><option value="Palu">Palu</option><option value="Kupang">Kupang</option><option value="Sukabumi">Sukabumi</option><option value="Tasikmalaya">Tasikmalaya</option><option value="Pekalongan">Pekalongan</option><option value="Cirebon">Cirebon</option><option value="Banda Aceh">Banda Aceh</option><option value="Tegal">Tegal</option><option value="Kendari">Kendari</option><option value="Kediri">Kediri</option><option value="Cibadak">Cibadak</option><option value="Binjai">Binjai</option><option value="Majalaya">Majalaya</option><option value="Purwokerto">Purwokerto</option><option value="Purwakarta">Purwakarta</option><option value="Loa Janan">Loa Janan</option><option value="Ciputat">Ciputat</option><option value="Ciampea">Ciampea</option><option value="Sumedang">Sumedang</option><option value="Cileungsi">Cileungsi</option><option value="Rengasdengklok">Rengasdengklok</option><option value="Karawang">Karawang</option><option value="Cibitung">Cibitung</option><option value="Parung">Parung</option><option value="Leuwiliang">Leuwiliang</option><option value="Indonesia">Indonesia</option><option value="Cibinong">Cibinong</option><option value="Brebes">Brebes</option><option value="Madiun">Madiun</option><option value="Pemalang">Pemalang</option><option value="Lembang">Lembang</option><option value="Probolinggo">Probolinggo</option><option value="Taman">Taman</option><option value="Pamulang">Pamulang</option><option value="Cikupa">Cikupa</option><option value="Salatiga">Salatiga</option><option value="Plumbon">Plumbon</option><option value="Banjaran">Banjaran</option><option value="Serang">Serang</option><option value="Lawang">Lawang</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Iran, Islamic Republic Of"){ var str=state_selected; str=str+'<option value="Tehran">Tehran</option><option value="Mashhad">Mashhad</option><option value="Esfahan">Esfahan</option><option value="Karaj">Karaj</option><option value="Tabriz">Tabriz</option><option value="Shiraz">Shiraz</option><option value="Qom">Qom</option><option value="Ahvaz">Ahvaz</option><option value="Kermanshah">Kermanshah</option><option value="Orumiyeh">Orumiyeh</option><option value="Rasht">Rasht</option><option value="Kerman">Kerman</option><option value="Zahedan">Zahedan</option><option value="Hamadan">Hamadan</option><option value="Arak">Arak</option><option value="Yazd">Yazd</option><option value="Ardabil">Ardabil</option><option value="Abadan">Abadan</option><option value="Zanjan">Zanjan</option><option value="Sanandaj">Sanandaj</option><option value="Qazvin">Qazvin</option><option value="Khorramshahr">Khorramshahr</option><option value="Khorramabad">Khorramabad</option><option value="Eslamshahr">Eslamshahr</option><option value="Khomeynishahr">Khomeynishahr</option><option value="Sari">Sari</option><option value="Borujerd">Borujerd</option><option value="Qarchak">Qarchak</option><option value="Gorgan">Gorgan</option><option value="Sabzevar">Sabzevar</option><option value="Najafabad">Najafabad</option><option value="Neyshabur">Neyshabur</option><option value="Bukan">Bukan</option><option value="Dezful">Dezful</option><option value="Sirjan">Sirjan</option><option value="Babol">Babol</option><option value="Amol">Amol</option><option value="Birjand">Birjand</option><option value="Bojnurd">Bojnurd</option><option value="Varamin">Varamin</option><option value="Saveh">Saveh</option><option value="Khoy">Khoy</option><option value="Maragheh">Maragheh</option><option value="Mahabad">Mahabad</option><option value="Bushehr">Bushehr</option><option value="Saqqez">Saqqez</option><option value="Rafsanjan">Rafsanjan</option><option value="Ilam">Ilam</option><option value="Miandoab">Miandoab</option><option value="Shahrud">Shahrud</option><option value="Gonbad-e Qabus">Gonbad-e Qabus</option><option value="Iranshahr, Iran">Iranshahr, Iran</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Ireland"){ var str=state_selected; str=str+'<option value="Dublin">Dublin</option><option value="Cork">Cork</option><option value="Limerick">Limerick</option><option value="Galway">Galway</option><option value="Waterford">Waterford</option><option value="Drogheda">Drogheda</option><option value="Dundalk">Dundalk</option><option value="Bray">Bray</option><option value="Swords">Swords</option><option value="Navan">Navan</option><option value="Ennis">Ennis</option><option value="Tralee">Tralee</option><option value="Kilkenny">Kilkenny</option><option value="Naas">Naas</option><option value="Sligo">Sligo</option><option value="Carlow">Carlow</option><option value="Newbridge">Newbridge</option><option value="Celbridge">Celbridge</option><option value="Wexford">Wexford</option><option value="Clonmel">Clonmel</option><option value="Mullingar">Mullingar</option><option value="Letterkenny">Letterkenny</option><option value="Athlone">Athlone</option><option value="Leixlip">Leixlip</option><option value="Malahide">Malahide</option><option value="Carrigaline">Carrigaline</option><option value="Castlebar">Castlebar</option><option value="Greystones">Greystones</option><option value="Tullamore">Tullamore</option><option value="Maynooth">Maynooth</option><option value="Balbriggan">Balbriggan</option><option value="Arklow">Arklow</option><option value="Cobh">Cobh</option><option value="Wicklow">Wicklow</option><option value="Ballina">Ballina</option><option value="Skerries">Skerries</option><option value="Enniscorthy">Enniscorthy</option><option value="Mallow">Mallow</option><option value="Tramore">Tramore</option><option value="Midleton">Midleton</option><option value="Shannon">Shannon</option><option value="Portmarnock">Portmarnock</option><option value="Longford">Longford</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Isle Of Man"){ var str=state_selected; str=str+'<option value="Castletown">Castletown</option><option value="Douglas">Douglas</option><option value="Peel">Peel</option><option value="Ramsey”>Ramsey </option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Israel"){ var str=state_selected; str=str+'<option value="Jerusalem">Jerusalem</option><option value="Tel Aviv">Tel Aviv</option><option value="Haifa">Haifa</option><option value="Ashdod">Ashdod</option><option value="Netanya">Netanya</option><option value="Bene Beraq">Bene Beraq</option><option value="Bat Yam">Bat Yam</option><option value="Ramat Gan">Ramat Gan</option><option value="Ashqelon">Ashqelon</option><option value="Kefar Sava">Kefar Sava</option><option value="Israel">Israel</option><option value="Bet Shemesh">Bet Shemesh</option><option value="Ramla">Ramla</option><option value="Nahariyya">Nahariyya</option><option value="Qiryat Atta">Qiryat Atta</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Italy"){ var str=state_selected; str=str+'<option value="Rome">Rome</option><option value="Milan">Milan</option><option value="Naples">Naples</option><option value="Turin">Turin</option><option value="Palermo">Palermo</option><option value="Genoa">Genoa</option><option value="Bologna">Bologna</option><option value="Florence">Florence</option><option value="Catania">Catania</option><option value="Bari">Bari</option><option value="Italy">Italy</option><option value="Verona">Verona</option><option value="Messina">Messina</option><option value="Padova">Padova</option><option value="Trieste">Trieste</option><option value="Brescia">Brescia</option><option value="Taranto">Taranto</option><option value="Reggio di Calabria">Reggio di Calabria</option><option value="Modena">Modena</option><option value="Prato">Prato</option><option value="Cagliari">Cagliari</option><option value="Perugia">Perugia</option><option value="Parma">Parma</option><option value="Leghorn">Leghorn</option><option value="Salerno">Salerno</option><option value="Foggia">Foggia</option><option value="Ravenna">Ravenna</option><option value="Rimini">Rimini</option><option value="Ferrara">Ferrara</option><option value="Syracuse">Syracuse</option><option value="Latina">Latina</option><option value="Monza">Monza</option><option value="Sassari">Sassari</option><option value="Pescara">Pescara</option><option value="Bergamo">Bergamo</option><option value="Forli">Forli</option><option value="Vicenza">Vicenza</option><option value="Terni">Terni</option><option value="Giugliano in Campania">Giugliano in Campania</option><option value="Trento">Trento</option><option value="Novara">Novara</option><option value="Ancona">Ancona</option><option value="Piacenza">Piacenza</option><option value="Arezzo">Arezzo</option><option value="Udine">Udine</option><option value="Andria">Andria</option><option value="Barletta">Barletta</option><option value="Brindisi">Brindisi</option><option value="Cesena">Cesena</option><option value="Pesaro">Pesaro</option><option value="Catanzaro">Catanzaro</option><option value="Bolzano">Bolzano</option><option value="La Spezia">La Spezia</option><option value="Torre del Greco">Torre del Greco</option><option value="Pistoia">Pistoia</option><option value="Varese">Varese</option><option value="Pisa">Pisa</option><option value="Guidonia">Guidonia</option><option value="Treviso">Treviso</option><option value="Pozzuoli">Pozzuoli</option><option value="Marsala">Marsala</option><option value="Lucca">Lucca</option><option value="Lecce">Lecce</option><option value="Busto Arsizio">Busto Arsizio</option><option value="Casoria">Casoria</option><option value="Caserta">Caserta</option><option value="Como">Como</option><option value="Gela">Gela</option><option value="Sesto San Giovanni">Sesto San Giovanni</option><option value="Cinisello Balsamo">Cinisello Balsamo</option><option value="Ragusa">Ragusa</option><option value="Grosseto">Grosseto</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Jamaica"){ var str=state_selected; str=str+'<option value="Kingston">Kingston</option><option value="Spanish Town">Spanish Town</option><option value="Portmore">Portmore</option><option value="Montego Bay">Montego Bay</option><option value="Mandeville">Mandeville</option><option value="May Pen">May Pen</option><option value="Half Way Tree">Half Way Tree</option><option value="Port Antonio">Port Antonio</option><option value="Ocho Rios">Ocho Rios</option><option value="Morant Bay">Morant Bay</option><option value="Port Maria">Port Maria</option><option value="Falmouth">Falmouth</option><option value="Bull Savanna">Bull Savanna</option><option value="Lucea">Lucea</option><option value="Bamboo">Bamboo</option><option value="Black River">Black River</option><option value="Anchovy">Anchovy</option><option value="Cambridge">Cambridge</option><option value="Maroon Town">Maroon Town</option><option value="Albert Town">Albert Town</option><option value="Discovery Bay">Discovery Bay</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Jersey"){ var str=state_selected; str=str+'<option value="N/a">N/a</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Jordan"){ var str=state_selected; str=str+'<option value="Amman">Amman</option><option value="Irbid">Irbid</option><option value="Madaba">Madaba</option><option value="Aydun">Aydun</option><option value="Kuraymah">Kuraymah</option><option value="Wadi Musa">Wadi Musa</option><option value="Suf">Suf</option><option value="Hawwarah">Hawwarah</option><option value="Judayta">Judayta</option><option value="Jawa">Jawa</option><option value="Kafr Yuba">Kafr Yuba</option><option value="Umm Nuwarah">Umm Nuwarah</option><option value="Sakib">Sakib</option><option value="Samma">Samma</option><option value="Kafr Asad">Kafr Asad</option><option value="Bayt Yafa">Bayt Yafa</option><option value="Busayra">Busayra</option><option value="Kafr Sawm">Kafr Sawm</option><option value="Sal">Sal</option><option value="Malka">Malka</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Kazakhstan"){ var str=state_selected; str=str+'<option value="Almaty">Almaty</option><option value="Shymkent">Shymkent</option><option value="Taraz">Taraz</option><option value="Astana">Astana</option><option value="Pavlodar">Pavlodar</option><option value="Oskemen">Oskemen</option><option value="Semey">Semey</option><option value="Aqtobe">Aqtobe</option><option value="Qostanay">Qostanay</option><option value="Petropavl">Petropavl</option><option value="Temirtau">Temirtau</option><option value="Atyrau">Atyrau</option><option value="Ekibastuz">Ekibastuz</option><option value="Zhezkazgan">Zhezkazgan</option><option value="Turkistan">Turkistan</option><option value="Balkhash">Balkhash</option><option value="Sarkand">Sarkand</option><option value="Kentau">Kentau</option><option value="Zhanaozen">Zhanaozen</option><option value="Shakhtinsk">Shakhtinsk</option><option value="Stepnogorsk">Stepnogorsk</option><option value="Zyryanovsk">Zyryanovsk</option><option value="Aksu">Aksu</option><option value="Zhitikara">Zhitikara</option><option value="Talgar">Talgar</option><option value="Shu">Shu</option><option value="Karatau">Karatau</option><option value="Arys">Arys</option><option value="Abay">Abay</option><option value="Aksay">Aksay</option><option value="Atbasar">Atbasar</option><option value="Zharkent">Zharkent</option><option value="Zhanatas">Zhanatas</option><option value="Ayagoz">Ayagoz</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Kenya"){ var str=state_selected; str=str+'<option value="Nairobi">Nairobi</option><option value="Mombasa">Mombasa</option><option value="Nakuru">Nakuru</option><option value="Eldoret">Eldoret</option><option value="Kisumu">Kisumu</option><option value="Thika">Thika</option><option value="Kitale">Kitale</option><option value="Malindi">Malindi</option><option value="Garissa">Garissa</option><option value="Bungoma">Bungoma</option><option value="Nyeri">Nyeri</option><option value="Meru">Meru</option><option value="Kilifi">Kilifi</option><option value="Ruiru">Ruiru</option><option value="Kakamega">Kakamega</option><option value="Wajir">Wajir</option><option value="Mumias">Mumias</option><option value="Busia">Busia</option><option value="Homa Bay">Homa Bay</option><option value="Naivasha">Naivasha</option><option value="Nanyuki">Nanyuki</option><option value="Narok">Narok</option><option value="Mandera">Mandera</option><option value="Kericho">Kericho</option><option value="Migori">Migori</option><option value="Embu">Embu</option><option value="Isiolo">Isiolo</option><option value="Nyahururu">Nyahururu</option><option value="Machakos">Machakos</option><option value="Rongai">Rongai</option><option value="Kisii">Kisii</option><option value="Molo">Molo</option><option value="Gilgil">Gilgil</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Kiribati"){ var str=state_selected; str=str+'<option value="Bairiki">Bairiki</option><option value="Taburao">Taburao</option><option value="Buariki">Buariki</option><option value="Temaraia">Temaraia</option><option value="Butaritari">Butaritari</option><option value="Utiroa">Utiroa</option><option value="Tabukiniberu">Tabukiniberu</option><option value="Rawannawi">Rawannawi</option><option value="Tabiauea">Tabiauea</option><option value="Rungata">Rungata</option><option value="Ijaki">Ijaki</option><option value="Binoinano">Binoinano</option><option value="Ooma">Ooma</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Korea, Democratic PeopleS Republic Of"){ var str=state_selected; str=str+'<option value="Seoul">Seoul</option><option value="Goyang">Goyang</option><option value="Busan">Busan</option><option value="Yongin">Yongin</option><option value="Incheon">Incheon</option><option value="Bucheon">Bucheon</option><option value="Daegu">Daegu</option><option value="Ansan">Ansan</option><option value="Daejeon">Daejeon</option><option value="Cheongju">Cheongju</option><option value="Gwangju">Gwangju</option><option value="Jeonju">Jeonju</option><option value="Ulsan">Ulsan</option><option value="Anyang">Anyang</option><option value="Suwon">Suwon</option><option value="Cheonan">Cheonan</option><option value="Changwon">Changwon</option><option value="Namyangju">Namyangju</option><option value="Seongnam">Seongnam</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Korea, Republic Of"){ var str=state_selected; str=str+'<option value="Seoul">Seoul</option><option value="Busan">Busan</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Kuwait"){ var str=state_selected; str=str+'<option value="Hawalli">Hawalli</option><option value="Doha">Doha</option><option value="Bayan">Bayan</option><option value="Kayfan, Kuwait">Kayfan, Kuwait</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Kyrgyzstan"){ var str=state_selected; str=str+'<option value="Karakol">Karakol</option><option value="Tokmak">Tokmak</option><option value="Ozgon">Ozgon</option><option value="Talas">Talas</option><option value=" Kyrgyzstan"> Kyrgyzstan</option><option value="Toktogul">Toktogul</option><option value="Isfana">Isfana</option><option value="Kyzyl-Suu">Kyzyl-Suu</option><option value="At-Bashi">At-Bashi</option><option value="Suluktu">Suluktu</option><option value="Tyup">Tyup</option><option value="Kemin">Kemin</option><option value="Batken">Batken</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Lao PeopleS Democratic Republic"){ var str=state_selected; str=str+'<option value="N/A">N/A</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Latvia"){ var str=state_selected; str=str+'<option value="Riga">Riga</option><option value="Daugavpils">Daugavpils</option><option value="Liepaja">Liepaja</option><option value="Jelgava">Jelgava</option><option value="Jurmala">Jurmala</option><option value="Ventspils">Ventspils</option><option value="Rezekne">Rezekne</option><option value="Valmiera">Valmiera</option><option value="Ogre">Ogre</option><option value="Tukums">Tukums</option><option value="Cesis">Cesis</option><option value="Salaspils">Salaspils</option><option value="Kuldiga">Kuldiga</option><option value="Olaine">Olaine</option><option value="Saldus">Saldus</option><option value="Talsi">Talsi</option><option value="Dobele">Dobele</option><option value="Kraslava">Kraslava</option><option value="Bauska">Bauska</option><option value="Ludza">Ludza</option><option value="Sigulda">Sigulda</option><option value="Livani">Livani</option><option value="Gulbene">Gulbene</option><option value="Madona">Madona</option><option value="Limbazi">Limbazi</option><option value="Aizkraukle">Aizkraukle</option><option value="Preili">Preili</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Lebanon"){ var str=state_selected; str=str+'<option value="Bayrut">Bayrut</option><option value="Beirut">Beirut</option><option value="Sur">Sur</option><option value="Juniyah">Juniyah</option><option value="Jubayl">Jubayl</option><option value="Riyaq">Riyaq</option><option value="Jazzin">Jazzin</option><option value="Jubb Jannin">Jubb Jannin</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Lesotho"){ var str=state_selected; str=str+'<option value="Maseru">Maseru</option><option value="Hlotse">Hlotse</option><option value="Mafeteng">Mafeteng</option><option value="Teyateyaneng">Teyateyaneng</option><option value="Quthing">Quthing</option><option value="Mokhotlong">Mokhotlong</option><option value="Thaba-Tseka">Thaba-Tseka</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Liberia"){ var str=state_selected; str=str+'<option value="Monrovia">Monrovia</option><option value="Gbarnga">Gbarnga</option><option value="Bensonville">Bensonville</option><option value="Harper">Harper</option><option value="Buchanan">Buchanan</option><option value="Zwedru">Zwedru</option><option value="Yekepa">Yekepa</option><option value="Ganta">Ganta</option><option value="Robertsport">Robertsport</option><option value="Tubmanburg">Tubmanburg</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Libyan Arab Jamahiriya"){ var str=state_selected; str=str+'<option value="Tripoli">Tripoli</option><option value="Benghazi">Benghazi</option><option value="Misratah">Misratah</option><option value="Tarhunah">Tarhunah</option><option value="Zuwarah">Zuwarah</option><option value="Ajdabiya">Ajdabiya</option><option value="Surt">Surt</option><option value="Sabha">Sabha</option><option value="Tubruq">Tubruq</option><option value="Sabratah">Sabratah</option><option value="Zlitan">Zlitan</option><option value="Darnah">Darnah</option><option value="Yafran">Yafran</option><option value="Nalut">Nalut</option><option value="Bani Walid">Bani Walid</option><option value="Marzuq">Marzuq</option><option value="Awbari">Awbari</option><option value="Waddan">Waddan</option><option value="Mizdah">Mizdah</option><option value="Surman">Surman</option><option value="Gat">Gat</option><option value="Masallatah">Masallatah</option><option value="Tukrah">Tukrah</option><option value="Hun">Hun</option><option value="Zaltan">Zaltan</option><option value="Suluq">Suluq</option><option value="Bardiyah">Bardiyah</option><option value="Awjilah">Awjilah</option><option value="Jadu">Jadu</option><option value="Jalu">Jalu</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Liechtenstein"){ var str=state_selected; str=str+'<option value="Schaan">Schaan</option><option value="Vaduz">Vaduz</option><option value="Triesen">Triesen</option><option value="Balzers">Balzers</option><option value="Eschen">Eschen</option><option value="Mauren">Mauren</option><option value="Triesenberg">Triesenberg</option><option value="Ruggell">Ruggell</option><option value="Gamprin">Gamprin</option><option value="Schellenberg">Schellenberg</option><option value="Planken">Planken</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Lithuania"){ var str=state_selected; str=str+'<option value="Vilnius">Vilnius</option><option value="Kaunas">Kaunas</option><option value="Klaipeda">Klaipeda</option><option value="Siauliai">Siauliai</option><option value="Panevezys">Panevezys</option><option value="Alytus">Alytus</option><option value="Marijampole">Marijampole</option><option value="Mazeikiai">Mazeikiai</option><option value="Jonava">Jonava</option><option value="Utena">Utena</option><option value="Kedainiai">Kedainiai</option><option value="Telsiai">Telsiai</option><option value="Ukmerge">Ukmerge</option><option value="Visaginas">Visaginas</option><option value="Taurage">Taurage</option><option value="Plunge">Plunge</option><option value="Kretinga">Kretinga</option><option value="Silute">Silute</option><option value="Radviliskis">Radviliskis</option><option value="Palanga">Palanga</option><option value="Druskininkai">Druskininkai</option><option value="Rokiskis">Rokiskis</option><option value="Gargzdai">Gargzdai</option><option value="Birzai">Birzai</option><option value="Kursenai">Kursenai</option><option value="Garliava">Garliava</option><option value="Elektrenai">Elektrenai</option><option value="Jurbarkas">Jurbarkas</option><option value="Vilkaviskis">Vilkaviskis</option><option value="Raseiniai">Raseiniai</option><option value="Naujoji Akmene">Naujoji Akmene</option><option value="Lentvaris">Lentvaris</option><option value="Anyksciai">Anyksciai</option><option value="Grigiskes">Grigiskes</option><option value="Prienai">Prienai</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Luxembourg"){ var str=state_selected; str=str+'<option value="Luxemburg">Luxemburg</option><option value="Dudelange">Dudelange</option><option value="Schifflange">Schifflange</option><option value="Bettembourg">Bettembourg</option><option value="Petange">Petange</option><option value="Ettelbruck">Ettelbruck</option><option value="Diekirch">Diekirch</option><option value="Strassen">Strassen</option><option value="Bertrange">Bertrange</option><option value="Belvaux">Belvaux</option><option value="Differdange">Differdange</option><option value="Mamer">Mamer</option><option value="Soleuvre">Soleuvre</option><option value="Wiltz">Wiltz</option><option value="Echternach">Echternach</option><option value="Rodange">Rodange</option><option value="Obercorn">Obercorn</option><option value="Bascharage">Bascharage</option><option value="Kayl">Kayl</option><option value="Grevenmacher">Grevenmacher</option><option value="Bereldange">Bereldange</option><option value="Mersch">Mersch</option><option value="Mondercange">Mondercange</option><option value="Remich">Remich</option><option value="Niedercorn">Niedercorn</option><option value="Mondorf-les-Bains">Mondorf-les-Bains</option><option value="Tetange">Tetange</option><option value="Bissen">Bissen</option><option value="Sandweiler">Sandweiler</option><option value="Sanem">Sanem</option><option value="Lamadelaine">Lamadelaine</option><option value="Bridel">Bridel</option><option value="Junglinster">Junglinster</option><option value="Wasserbillig">Wasserbillig</option><option value="Steinfort">Steinfort</option><option value="Helmsange">Helmsange</option><option value="Hesperange">Hesperange</option><option value="Leudelange">Leudelange</option><option value="Steinsel">Steinsel</option><option value="Itzig">Itzig</option><option value="Clemency">Clemency</option><option value="Lintgen">Lintgen</option><option value="Kehlen">Kehlen</option><option value="Vianden">Vianden</option><option value="Heisdorf">Heisdorf</option><option value="Eischen">Eischen</option><option value="Bergem">Bergem</option><option value="Niederanven">Niederanven</option><option value="Hautcharage">Hautcharage</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Macao"){ var str=state_selected; str=str+'<option value="N/A">N/A</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Macedonia, The Former Yugoslav Republic Of"){ var str=state_selected; str=str+'<option value="Skopje">Skopje</option><option value="Bitola">Bitola</option><option value="Kumanovo">Kumanovo</option><option value="Prilep">Prilep</option><option value="Tetovo">Tetovo</option><option value="Štip">Štip</option><option value="Veles">Veles</option><option value="Ohrid">Ohrid</option><option value="Kavadarci">Kavadarci</option><option value="Gostivar">Gostivar</option><option value="Strumica">Strumica</option><option value="Struga">Struga</option><option value="Kicevo">Kicevo</option><option value="Kocani">Kocani</option><option value="Radoviš">Radoviš</option><option value="Gevgelija">Gevgelija</option><option value="Kriva Palanka">Kriva Palanka</option><option value="Debar">Debar</option><option value="Negotino">Negotino</option><option value="Sveti Nikole">Sveti Nikole</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Madagascar"){ var str=state_selected; str=str+'<option value="Antananarivo">Antananarivo</option><option value="Toamasina">Toamasina</option><option value="Antsirabe">Antsirabe</option><option value="Fianarantsoa">Fianarantsoa</option><option value="Mahajanga">Mahajanga</option><option value="Toliary">Toliary</option><option value="Antanifotsy">Antanifotsy</option><option value="Ambovombe">Ambovombe</option><option value="Amparafaravola">Amparafaravola</option><option value="Taolanaro">Taolanaro</option><option value="Ambatondrazaka">Ambatondrazaka</option><option value="Mananara">Mananara</option><option value="Soavinandriana">Soavinandriana</option><option value="Mahanoro">Mahanoro</option><option value="Soanierana Ivongo">Soanierana Ivongo</option><option value="Faratsiho">Faratsiho</option><option value="Nosy Varika">Nosy Varika</option><option value="Vavatenina">Vavatenina</option><option value="Morondava">Morondava</option><option value="Amboasary">Amboasary</option><option value="Manakara">Manakara</option><option value="Antalaha">Antalaha</option><option value="Ikongo">Ikongo</option><option value="Manjakandriana">Manjakandriana</option><option value="Sambava">Sambava</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Malawi"){ var str=state_selected; str=str+'<option value="Lilongwe">Lilongwe</option><option value="Blantyre">Blantyre</option><option value="Zomba">Zomba</option><option value="Kasungu">Kasungu</option><option value="Mangochi">Mangochi</option><option value="Karonga">Karonga</option><option value="Salima">Salima</option><option value="Nkhotakota">Nkhotakota</option><option value="Liwonde">Liwonde</option><option value="Nsanje">Nsanje</option><option value="Rumphi">Rumphi</option><option value="Mzimba">Mzimba</option><option value="Balaka">Balaka</option><option value="Mchinji">Mchinji</option><option value="Mulanje">Mulanje</option><option value="Dedza">Dedza</option><option value="Luchenza">Luchenza</option><option value="Nkhata Bay">Nkhata Bay</option><option value="Monkey Bay">Monkey Bay</option><option value="Mwanza">Mwanza</option><option value="Mponela">Mponela</option><option value="Ntcheu">Ntcheu</option><option value="Chikwawa">Chikwawa</option><option value="Chitipa">Chitipa</option><option value="Ntchisi">Ntchisi</option><option value="Thyolo">Thyolo</option><option value="Dowa">Dowa</option><option value="Livingstonia">Livingstonia</option><option value="Chipoka">Chipoka</option><option value="Phalombe">Phalombe</option><option value="Chiradzulu">Chiradzulu</option><option value="Machinga">Machinga</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Malaysia"){ var str=state_selected; str=str+'<option value="Kuala Lumpur">Kuala Lumpur</option><option value="Klang">Klang</option><option value="Johor Bahru">Johor Bahru</option><option value="Ipoh">Ipoh</option><option value="Kuching">Kuching</option><option value="Petaling Jaya">Petaling Jaya</option><option value="Shah Alam">Shah Alam</option><option value="Kota Kinabalu">Kota Kinabalu</option><option value="Sandakan">Sandakan</option><option value="Seremban">Seremban</option><option value="Kuantan">Kuantan</option><option value="Tawau">Tawau</option><option value="Kuala Terengganu">Kuala Terengganu</option><option value="Kota Bahru">Kota Bahru</option><option value="Sungai Petani">Sungai Petani</option><option value="Miri">Miri</option><option value="Taiping">Taiping</option><option value="Alor Setar">Alor Setar</option><option value="Bukit Mertajam">Bukit Mertajam</option><option value="Sibu">Sibu</option><option value="Melaka">Melaka</option><option value="Kulim">Kulim</option><option value="Kluang">Kluang</option><option value="Sekudai">Sekudai</option><option value="Bandar Penggaram">Bandar Penggaram</option><option value="Bintulu">Bintulu</option><option value="Pasir Gudang">Pasir Gudang</option><option value="Bandar Maharani">Bandar Maharani</option><option value="Rawang">Rawang</option><option value="Ayer Itam">Ayer Itam</option><option value="Butterworth">Butterworth</option><option value="Lahad Datu">Lahad Datu</option><option value="Port Dickson">Port Dickson</option><option value="Cukai">Cukai</option><option value="Semenyih">Semenyih</option><option value="Putatan">Putatan</option><option value="Malaysia">Malaysia</option><option value="Banting">Banting</option><option value="Ulu Tiram">Ulu Tiram</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Maldives"){ var str=state_selected; str=str+'<option value="Male">Male</option><option value="Hithadhoo">Hithadhoo</option><option value="Kulhudhuffushi">Kulhudhuffushi</option><option value="Thinadhoo">Thinadhoo</option><option value="Naifaru">Naifaru</option><option value="Dhidhdhoo">Dhidhdhoo</option><option value="Eydhafushi">Eydhafushi</option><option value="Viligili">Viligili</option><option value="Mahibadhoo">Mahibadhoo</option><option value="Manadhoo">Manadhoo</option><option value="Kudahuvadhoo">Kudahuvadhoo</option><option value="Ugoofaaru">Ugoofaaru</option><option value="Funadhoo">Funadhoo</option><option value="Muli">Muli</option><option value="Felidhoo">Felidhoo</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Mali"){ var str=state_selected; str=str+'<option value="Bamako">Bamako</option><option value="Sikasso">Sikasso</option><option value="Mopti">Mopti</option><option value="Koutiala">Koutiala</option><option value="Kayes">Kayes</option><option value="Segou">Segou</option><option value="Nioro">Nioro</option><option value="Markala">Markala</option><option value="Kolokani">Kolokani</option><option value="Kati”>Kati </option><option value="Gao">Gao</option><option value="Bougouni">Bougouni</option><option value="Niono">Niono</option><option value="Tombouctou">Tombouctou</option><option value="Banamba">Banamba</option><option value="Nara">Nara</option><option value="Bafoulabe">Bafoulabe</option><option value="San">San</option><option value="Koulikoro">Koulikoro</option><option value="Djenne">Djenne</option><option value="Yorosso">Yorosso</option><option value="Kangaba">Kangaba</option><option value="Kidal">Kidal</option><option value="Dire">Dire</option><option value="Kolondieba">Kolondieba</option><option value="Goundam">Goundam</option><option value="Douentza">Douentza</option><option value="Tenenkou">Tenenkou</option><option value="Bandiagara">Bandiagara</option><option value="Kimparana">Kimparana</option><option value="Kita">Kita</option><option value="Sokolo">Sokolo</option><option value="Araouane">Araouane</option><option value="Taoudenni">Taoudenni</option><option value="Tessalit">Tessalit</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Malta"){ var str=state_selected; str=str+'<option value="Birkirkara">Birkirkara</option><option value="Qormi">Qormi</option><option value="Mosta">Mosta</option><option value="Zabbar">Zabbar</option><option value="Rabat">Rabat</option><option value="San Gwann">San Gwann</option><option value="Fgura">Fgura</option><option value="Zejtun">Zejtun</option><option value="Sliema">Sliema</option><option value="Zebbug">Zebbug</option><option value="Naxxar">Naxxar</option><option value="Attard">Attard</option><option value="Paola">Paola</option><option value="Zurrieq">Zurrieq</option><option value="Tarxien">Tarxien</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Marshall Islands"){ var str=state_selected; str=str+'<option value="Aen">Aen</option><option value="Airek">Airek</option><option value="Airekku-to">Airekku-to</option><option value="Ajeltake">Ajeltake</option><option value="Ajiltake">Ajiltake</option><option value="Ajurotaka">Ajurotaka</option><option value="Ajurotake">Ajurotake</option><option value="Aneaitok">Aneaitok</option><option value="Anearmej">Anearmej</option><option value="Anejet">Anejet</option><option value="Anekirea">Anekirea</option><option value="Aneloklab">Aneloklab</option><option value="Anetatabwuk">Anetatabwuk</option><option value="Arrak">Arrak</option><option value="Arurakku">Arurakku</option><option value="Bikoniing">Bikoniing</option><option value="Bioleen">Bioleen</option><option value="Bwokwen">Bwokwen</option><option value="Chapuchirochi">Chapuchirochi</option><option value="Chittakain">Chittakain</option><option value="Chittoin">Chittoin</option><option value="Djeboan">Djeboan</option><option value="Ebeye">Ebeye</option><option value="Enebingu">Enebingu</option><option value="Eneebingu To">Eneebingu To</option><option value="Enerein">Enerein</option><option value="Enesetto">Enesetto</option><option value="Enesetto-To">Enesetto-To</option><option value="Eneubing">Eneubing</option><option value="Enibung">Enibung</option><option value="Eniebing">Eniebing</option><option value="Enipin">Enipin</option><option value="Eniwataku">Eniwataku</option><option value="Eniwataku">Eniwataku</option><option value="Enubing">Enubing</option><option value="Enuebing">Enuebing</option><option value="Enyebing">Enyebing</option><option value="Ine">Ine</option><option value="Jabo">Jabo</option><option value="Jaboan">Jaboan</option><option value="Jabooru">Jabooru</option><option value="Jabor">Jabor</option><option value="Jaboru">Jaboru</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Martinique"){ var str=state_selected; str=str+'<option value="Fort-de-France">Fort-de-France</option><option value="Le Lamentin">Le Lamentin</option><option value="Le Robert">Le Robert</option><option value="Sainte-Marie">Sainte-Marie</option><option value="Le Francois">Le Francois</option><option value="Ducos">Ducos</option><option value="Saint-Joseph">Saint-Joseph</option><option value="La Trinite">La Trinite</option><option value="Riviere-pilote">Riviere-pilote</option><option value="Gros-Morne">Gros-Morne</option><option value="Sainte-Luce">Sainte-Luce</option><option value="Le Lorrain">Le Lorrain</option><option value="Le Marin">Le Marin</option><option value="Le Vauclin">Le Vauclin</option><option value="Les Trois-ilets">Les Trois-ilets</option><option value="Saint-Pierre">Saint-Pierre</option><option value="Basse-Pointe">Basse-Pointe</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Mauritania"){ var str=state_selected; str=str+'<option value="Nouakchott">Nouakchott</option><option value="Nouadhibou">Nouadhibou</option><option value="Atar">Atar</option><option value="Bababe">Bababe</option><option value="Maghama">Maghama</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Mauritius"){ var str=state_selected; str=str+'<option value="Port Louis">Port Louis</option><option value="Curepipe">Curepipe</option><option value="Quatre Bornes">Quatre Bornes</option><option value="Triolet">Triolet</option><option value="Goodlands">Goodlands</option><option value="Bel Air">Bel Air</option><option value="Mahebourg">Mahebourg</option><option value="Saint Pierre">Saint Pierre</option><option value="Le Hochet">Le Hochet</option><option value="Baie du Tombeau">Baie du Tombeau</option><option value="Bambous">Bambous</option><option value="Rose Belle">Rose Belle</option><option value="Chemin Grenier">Chemin Grenier</option><option value="Riviere Du Remparts">Riviere Du Remparts</option><option value="Grand Baie">Grand Baie</option><option value="Plaine Magnien">Plaine Magnien</option><option value="Pailles">Pailles</option><option value="Surinam">Surinam</option><option value="Lalmatie">Lalmatie</option><option value="New Grove">New Grove</option><option value="Riviere Des Anguilles">Riviere Des Anguilles</option><option value="Terre Rouge">Terre Rouge</option><option value="Petit Raffray">Petit Raffray</option><option value="Moka">Moka</option><option value="Montagne Blanche">Montagne Blanche</option><option value="Grand Bois">Grand Bois</option><option value="Long Mountain">Long Mountain</option><option value="Plaines des Papayes">Plaines des Papayes</option><option value="Brisee Verdiere">Brisee Verdiere</option><option value="Nouvelle France">Nouvelle France</option><option value="Grand Gaube">Grand Gaube</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Mayotte"){ var str=state_selected; str=str+'<option value="Mamoudzou">Mamoudzou</option><option value="Koungou">Koungou</option><option value="Dzaoudzi">Dzaoudzi</option><option value="Sada">Sada</option><option value="Bandraboua">Bandraboua</option><option value="Mtsamboro">Mtsamboro</option><option value="Tsingoni">Tsingoni</option><option value="Ouangani">Ouangani</option><option value="Chiconi">Chiconi</option><option value="Bandrele">Bandrele</option><option value="Chirongui">Chirongui</option><option value="Acoua">Acoua</option><option value="Boueni">Boueni</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Mexico"){ var str=state_selected; str=str+'<option value="Mexico”>Mexico </option><option value="Ecatepec">Ecatepec</option><option value="Guadalajara">Guadalajara</option><option value="Juarez">Juarez</option><option value="Puebla">Puebla</option><option value="Tijuana">Tijuana</option><option value="Nezahualcoyotl">Nezahualcoyotl</option><option value="Monterrey">Monterrey</option><option value="Leon">Leon</option><option value="Zapopan">Zapopan</option><option value="Naucalpan">Naucalpan</option><option value="Guadalupe">Guadalupe</option><option value="Merida">Merida</option><option value="Tlalnepantla">Tlalnepantla</option><option value="Chihuahua">Chihuahua</option><option value="San Luis Potosi">San Luis Potosi</option><option value="Aguascalientes">Aguascalientes</option><option value="Acapulco">Acapulco</option><option value="Saltillo">Saltillo</option><option value="Queretaro">Queretaro</option><option value="Mexicali">Mexicali</option><option value="Hermosillo">Hermosillo</option><option value="Morelia">Morelia</option><option value="Chimalhuacan">Chimalhuacan</option><option value="Culiacan">Culiacan</option><option value="Veracruz">Veracruz</option><option value="Cancun">Cancun</option><option value="Torreon">Torreon</option><option value="Lopez Mateos">Lopez Mateos</option><option value="San Nicolas De Los Garza">San Nicolas De Los Garza</option><option value="Toluca">Toluca</option><option value="Reynosa">Reynosa</option><option value="Tlaquepaque">Tlaquepaque</option><option value="Tuxtla Gutierrez">Tuxtla Gutierrez</option><option value="Cuautitlan Izcalli">Cuautitlan Izcalli</option><option value="Durango">Durango</option><option value="Matamoros">Matamoros</option><option value="Xalapa">Xalapa</option><option value="Tonala">Tonala</option><option value="Xico">Xico</option><option value="Villahermosa">Villahermosa</option><option value="Mazatlan">Mazatlan</option><option value="Apodaca">Apodaca</option><option value="Ixtapaluca">Ixtapaluca</option><option value="Nuevo Laredo">Nuevo Laredo</option><option value="Cuernavaca">Cuernavaca</option><option value="Irapuato">Irapuato</option><option value="Pachuca">Pachuca</option><option value="Coacalco">Coacalco</option><option value="Tampico">Tampico</option><option value="General Escobedo">General Escobedo</option><option value="Celaya">Celaya</option><option value="Tepic">Tepic</option><option value="Oaxaca">Oaxaca</option><option value="Obregon">Obregon</option><option value="Ensenada">Ensenada</option><option value="Puerto Vallarta">Puerto Vallarta</option><option value="Santa Catarina">Santa Catarina</option><option value="Los Reyes">Los Reyes</option><option value="Nicolas Romero">Nicolas Romero</option><option value="Tehuacan">Tehuacan</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Micronesia, Federated States Of"){ var str=state_selected; str=str+'<option value="N/A">N/A</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Moldova, Republic Of"){ var str=state_selected; str=str+'<option value="Chisinau">Chisinau</option><option value="Balti">Balti</option><option value="Tighina">Tighina</option><option value="Rabnita">Rabnita</option><option value="Orhei">Orhei</option><option value="Cahul">Cahul</option><option value="Ungheni">Ungheni</option><option value="Soroca">Soroca</option><option value="Comrat">Comrat</option><option value="Rascani">Rascani</option><option value="Drochia">Drochia</option><option value="Straseni">Straseni</option><option value="Edinet">Edinet</option><option value="Falesti">Falesti</option><option value="Slobozia">Slobozia</option><option value="Calarasi">Calarasi</option><option value="Vulcanesti">Vulcanesti</option><option value="Floresti">Floresti</option><option value="Dubasari">Dubasari</option><option value="Cimislia">Cimislia</option><option value="Rezina">Rezina</option><option value="Nisporeni">Nisporeni</option><option value="Taraclia">Taraclia</option><option value="Basarabeasca">Basarabeasca</option><option value="Camenca">Camenca</option><option value="Glodeni">Glodeni</option><option value="Dnestrovsc">Dnestrovsc</option><option value="Leova">Leova</option><option value="Briceni">Briceni</option><option value="Ocnita">Ocnita</option><option value="Donduseni">Donduseni</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Monaco"){ var str=state_selected; str=str+'<option value="La Condamine">La Condamine</option><option value="Fontvieille">Fontvieille</option><option value="Monaco-Ville">Monaco-Ville</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Mongolia"){ var str=state_selected; str=str+'<option value="Ulaanbaatar">Ulaanbaatar</option><option value="Erdenet">Erdenet</option><option value="Darhan">Darhan</option><option value="Ulaangom,">Ulaangom,</option><option value="Hovd">Hovd</option><option value="Moron">Moron</option><option value="Suhbaatar">Suhbaatar</option><option value="Bulgan">Bulgan</option><option value="Baruun-Urt">Baruun-Urt</option><option value="Mandalgovi">Mandalgovi</option><option value="Ondorhaan">Ondorhaan</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Montserrat"){ var str=state_selected; str=str+'<option value="Baker Hill">Baker Hill</option><option value="Banks">Banks</option><option value="Brades”>Brades </option><option value="Cavalla Hill">Cavalla Hill</option><option value="Cheap End">Cheap End</option><option value="Cork Hill">Cork Hill</option><option value="Cudjoe Head">Cudjoe Head</option><option value="Davy Hill">Davy Hill</option><option value="Drummonds">Drummonds</option><option value="Dyers">Dyers</option><option value="Farells Yard">Farells Yard</option><option value="Flemmings">Flemmings</option><option value="Geralds">Geralds</option><option value="Hope">Hope</option><option value="Judy Piece">Judy Piece</option><option value="Little Bay">Little Bay</option><option value="Look Out">Look Out</option><option value="Mongo Hill">Mongo Hill</option><option value="Old Towne">Old Towne</option><option value="Olveston">Olveston</option><option value="Plymouth”>Plymouth </option><option value="Saint Johns">Saint Johns</option><option value="Salem">Salem</option><option value="St Peters">St Peters</option><option value="Sweeneys">Sweeneys</option><option value="Woodlands">Woodlands</option><option value="Virgin Island">Virgin Island</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Morocco"){ var str=state_selected; str=str+'<option value="Casablanca">Casablanca</option><option value="Rabat">Rabat</option><option value="Fez">Fez</option><option value="Marrakesh">Marrakesh</option><option value="Tangier">Tangier</option><option value="Agadir">Agadir</option><option value="Kenitra">Kenitra</option><option value="Tetouan">Tetouan</option><option value="Asfi">Asfi</option><option value="Nador">Nador</option><option value="Tarudant">Tarudant</option><option value="Sidi Qasim">Sidi Qasim</option><option value="Tiznit">Tiznit</option><option value="Wazzan">Wazzan</option><option value="Azimur">Azimur</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Mozambique"){ var str=state_selected; str=str+'<option value="Maputo">Maputo</option><option value="Matola">Matola</option><option value="Beira">Beira</option><option value="Nampula">Nampula</option><option value="Chimoio">Chimoio</option><option value="Nacala">Nacala</option><option value="Quelimane">Quelimane</option><option value="Tete">Tete</option><option value="Xai-Xai">Xai-Xai</option><option value="Maxixe">Maxixe</option><option value="Lichinga">Lichinga</option><option value="Pemba">Pemba</option><option value="Dondo">Dondo</option><option value="Angoche">Angoche</option><option value="Inhambane">Inhambane</option><option value="Cuamba">Cuamba</option><option value="Montepuez">Montepuez</option><option value="Mocuba">Mocuba</option><option value="Chokwe">Chokwe</option><option value="Chibuto">Chibuto</option><option value="Mocambique">Mocambique</option><option value="Manjacaze">Manjacaze</option><option value="Manica">Manica</option><option value="Macia">Macia</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Myanmar"){ var str=state_selected; str=str+'<option value="Rangoon">Rangoon</option><option value="Mandalay">Mandalay</option><option value="Mawlamyine">Mawlamyine</option><option value="Bago">Bago</option><option value="Pathein">Pathein</option><option value="Monywa">Monywa</option><option value="Akyab">Akyab</option><option value="Meiktila">Meiktila</option><option value="Mergui">Mergui</option><option value="Taunggyi">Taunggyi</option><option value="Myingyan">Myingyan</option><option value="Dawei">Dawei</option><option value="Pyay">Pyay</option><option value="Henzada">Henzada</option><option value="Lashio">Lashio</option><option value="Pakokku">Pakokku</option><option value="Thaton">Thaton</option><option value="Maymyo">Maymyo</option><option value="Yenangyaung">Yenangyaung</option><option value="Toungoo">Toungoo</option><option value="Thayetmyo">Thayetmyo</option><option value="Pyinmana">Pyinmana</option><option value="Magway">Magway</option><option value="Myitkyina">Myitkyina</option><option value="Chauk">Chauk</option><option value="Mogok">Mogok</option><option value="Nyaunglebin">Nyaunglebin</option><option value="Mudon">Mudon</option><option value="Shwebo">Shwebo</option><option value="Sagaing">Sagaing</option><option value="Taungdwingyi">Taungdwingyi</option><option value="Syriam">Syriam</option><option value="Bogale">Bogale</option><option value="Pyapon">Pyapon</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Namibia"){ var str=state_selected; str=str+'<option value="Windhoek">Windhoek</option><option value="Rundu">Rundu</option><option value="Walvis Bay">Walvis Bay</option><option value="Oshakati">Oshakati</option><option value="Swakopmund">Swakopmund</option><option value="Katima Mulilo">Katima Mulilo</option><option value="Grootfontei">Grootfontei</option><option value="Rehoboth">Rehoboth</option><option value="Otjiwarongo">Otjiwarongo</option><option value="Okahandja">Okahandja</option><option value="Gobabis">Gobabis</option><option value="Keetmanshoop">Keetmanshoop</option><option value="Luderitz">Luderitz</option><option value="Mariental">Mariental</option><option value="Tsumeb">Tsumeb</option><option value="Khorixas">Khorixas</option><option value="Omaruru">Omaruru</option><option value="Bethanien">Bethanien</option><option value="Ongwediva">Ongwediva</option><option value="Usakos">Usakos</option><option value="Ondangwa">Ondangwa</option><option value="Oranjemund">Oranjemund</option><option value="Otjimbingwe">Otjimbingwe</option><option value="Karibib">Karibib</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Nauru"){ var str=state_selected; str=str+'<option value="Aiwo">Aiwo</option><option value="Anabar">Anabar</option><option value="Anetan">Anetan</option><option value="Anibare">Anibare</option><option value="Baitsi (Baiti)">Baitsi (Baiti)</option><option value="Boe">Boe</option><option value="Buada">Buada</option><option value="Denig (Denigomodu)">Denig (Denigomodu)</option><option value="Ewa">Ewa</option><option value="Ijuw">Ijuw</option><option value="Meneng">Meneng</option><option value="Nibok">Nibok</option><option value="NPC Settlement (Location)">NPC Settlement (Location)</option><option value="Uaboe">Uaboe</option><option value="Yaren">Yaren</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Nepal"){ var str=state_selected; str=str+'<option value="Kathmandu">Kathmandu</option><option value="Pokhara">Pokhara</option><option value="Lalitpur">Lalitpur</option><option value="Biratnagar">Biratnagar</option><option value="Birganj">Birganj</option><option value="Dharan">Dharan</option><option value="Bharatpur">Bharatpur</option><option value="Janakpur">Janakpur</option><option value="Dhangadhi">Dhangadhi</option><option value="Butwal">Butwal</option><option value="Mahendranagar">Mahendranagar</option><option value="Hetauda">Hetauda</option><option value="Bhaktapur">Bhaktapur</option><option value="Siddharthanagar">Siddharthanagar</option><option value="Nepalganj">Nepalganj</option><option value="Gulariya">Gulariya</option><option value="Itahari">Itahari</option><option value="Tikapur">Tikapur</option><option value="Kirtipur">Kirtipur</option><option value="Kalaiya">Kalaiya</option><option value="Tulsipur">Tulsipur</option><option value="Rajbiraj">Rajbiraj</option><option value="Lahan">Lahan</option><option value="Gaur">Gaur</option><option value="Siraha">Siraha</option><option value="Baglung">Baglung</option><option value="Tansen">Tansen</option><option value="Khandbari">Khandbari</option><option value="Dhankuta">Dhankuta</option><option value="Waling">Waling</option><option value="Malangwa">Malangwa</option><option value="Bhadrapur">Bhadrapur</option><option value="Ilam">Ilam</option><option value="Banepa">Banepa</option><option value="Jumla">Jumla</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Netherlands"){ var str=state_selected; str=str+'<option value="Amsterdam">Amsterdam</option><option value="Rotterdam">Rotterdam</option><option value="The Hague">The Hague</option><option value="Utrecht">Utrecht</option><option value="Eindhoven">Eindhoven</option><option value="Tilburg">Tilburg</option><option value="Almere">Almere</option><option value="Groningen">Groningen</option><option value="Breda">Breda</option><option value="Nijmegen">Nijmegen</option><option value="Apeldoorn">Apeldoorn</option><option value="Enschede">Enschede</option><option value="Haarlem">Haarlem</option><option value="Arnhem">Arnhem</option><option value="Zaanstad">Zaanstad</option><option value="Amersfoort">Amersfoort</option><option value="Haarlemmermeer">Haarlemmermeer</option><option value="Maastricht">Maastricht</option><option value="Dordrecht">Dordrecht</option><option value="Leiden">Leiden</option><option value="Zwolle">Zwolle</option><option value="Zoetermeer">Zoetermeer</option><option value="Emmen">Emmen</option><option value="Ede">Ede</option><option value="Delft">Delft</option><option value="Heerlen">Heerlen</option><option value="Alkmaar">Alkmaar</option><option value="Leeuwarden">Leeuwarden</option><option value="Venlo">Venlo</option><option value="Helmond">Helmond</option><option value="Deventer">Deventer</option><option value="Hilversum">Hilversum</option><option value="Hengelo">Hengelo</option><option value="Roosendaal">Roosendaal</option><option value="Purmerend">Purmerend</option><option value="Spijkenisse">Spijkenisse</option><option value="Amstelveen">Amstelveen</option><option value="Schiedam">Schiedam</option><option value="Almelo">Almelo</option><option value="Vlaardingen">Vlaardingen</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Netherlands Antilles"){ var str=state_selected; str=str+'<option value="Willemstad">Willemstad</option><option value="Sint Michiel">Sint Michiel</option><option value="Kralendijk">Kralendijk</option><option value="Barber">Barber</option><option value="Soto">Soto</option><option value="Nieuwpoort">Nieuwpoort</option><option value="Rincon">Rincon</option><option value="Oranjestad">Oranjestad</option><option value="Golden Rock">Golden Rock</option><option value="Westpunt">Westpunt</option><option value="The Bottom">The Bottom</option><option value="Windward Side">Windward Side</option><option value="Lagun">Lagun</option><option value="Hato">Hato</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="New Caledonia"){ var str=state_selected; str=str+'<option value="Noumea">Noumea</option><option value="Mont-Dore">Mont-Dore</option><option value="Dumbea">Dumbea</option><option value="We">We</option><option value="Paita">Paita</option><option value="Tadine">Tadine</option><option value="Poindimie">Poindimie</option><option value="Kone">Kone</option><option value="Bourail">Bourail</option><option value="Fayaoue">Fayaoue</option><option value="Poya">Poya</option><option value="Koumac">Koumac</option><option value="Ponerihouen">Ponerihouen</option><option value="Canala">Canala</option><option value="La Foa">La Foa</option><option value="Thio">Thio</option><option value="Touho">Touho</option><option value="Pouebo">Pouebo</option><option value="Hienghene">Hienghene</option><option value="Voh">Voh</option><option value="Ouegoa">Ouegoa</option><option value="Vao">Vao</option><option value="Yate">Yate</option><option value="Bouloupari">Bouloupari</option><option value="Pouembout">Pouembout</option><option value="Poum">Poum</option><option value="Moindou">Moindou</option><option value="Sarramea">Sarramea</option><option value="Farino">Farino</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="New Zealand"){ var str=state_selected; str=str+'<option value="Auckland">Auckland</option><option value="Christchurch">Christchurch</option><option value="North Shore">North Shore</option><option value="Wellington">Wellington</option><option value="Waitakere">Waitakere</option><option value="Hamilton">Hamilton</option><option value="Dunedin">Dunedin</option><option value="Tauranga">Tauranga</option><option value="Lower Hutt">Lower Hutt</option><option value="Palmerston North">Palmerston North</option><option value="Rotorua">Rotorua</option><option value="Hastings">Hastings</option><option value="Nelson">Nelson</option><option value="Napier">Napier</option><option value="Porirua">Porirua</option><option value="Whangarei">Whangarei</option><option value="New Plymouth">New Plymouth</option><option value="Invercargill">Invercargill</option><option value="Wanganui">Wanganui</option><option value="Gisborne">Gisborne</option><option value="Timaru">Timaru</option><option value="Taupo">Taupo</option><option value="Masterton">Masterton</option><option value="Levin">Levin</option><option value="Whakatane">Whakatane</option><option value="Tokoroa">Tokoroa</option><option value="Hawera">Hawera</option><option value="Queenstown">Queenstown</option><option value="Greymouth">Greymouth</option><option value="Waiuku">Waiuku</option><option value="Thames">Thames</option><option value="Kawerau">Kawerau</option><option value="Waitara">Waitara</option><option value="Otaki">Otaki</option><option value="Kerikeri">Kerikeri</option><option value="Foxton">Foxton</option><option value="Dargaville">Dargaville</option><option value="Waihi">Waihi</option><option value="Balclutha">Balclutha</option><option value="Wanaka">Wanaka</option><option value="Wairoa">Wairoa</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Nicaragua"){ var str=state_selected; str=str+'<option value="Managua">Managua</option><option value="Leon">Leon</option><option value="Chinandega">Chinandega</option><option value="Masaya">Masaya</option><option value="Granada">Granada</option><option value="Esteli">Esteli</option><option value="Tipitapa">Tipitapa</option><option value="Matagalpa">Matagalpa</option><option value="Bluefields">Bluefields</option><option value="Juigalpa">Juigalpa</option><option value="Nueva Guinea">Nueva Guinea</option><option value="El Viejo">El Viejo</option><option value="Ocotal">Ocotal</option><option value="Chichigalpa">Chichigalpa</option><option value="Diriamba">Diriamba</option><option value="Jinotega">Jinotega</option><option value="Nagarote">Nagarote</option><option value="Jalapa">Jalapa</option><option value="Jinotepe">Jinotepe</option><option value="Puerto Cabezas">Puerto Cabezas</option><option value="Rivas">Rivas</option><option value="San Rafael del Sur">San Rafael del Sur</option><option value="Boaco">Boaco</option><option value="Corinto">Corinto</option><option value="Sebaco">Sebaco</option><option value="La Paz Centro">La Paz Centro</option><option value="San Marcos">San Marcos</option><option value="Nandaime">Nandaime</option><option value="Somoto">Somoto</option><option value="Masatepe">Masatepe</option><option value="Mateare">Mateare</option><option value="Camoapa">Camoapa</option><option value="Santo Tomas">Santo Tomas</option><option value="Somotillo">Somotillo</option><option value="Ciudad Dario">Ciudad Dario</option><option value="San Carlos">San Carlos</option><option value="La Concepcion">La Concepcion</option><option value="Rio Blanco">Rio Blanco</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Niger"){ var str=state_selected; str=str+'<option value="Niamey">Niamey</option><option value="Zinder">Zinder</option><option value="Maradi">Maradi</option><option value="Agadez">Agadez</option><option value="ArlitTahoua">ArlitTahoua</option><option value="Dosso">Dosso</option><option value="Tessaoua">Tessaoua</option><option value="Gaya">Gaya</option><option value="Dogondoutchi">Dogondoutchi</option><option value="Diffa">Diffa</option><option value="Ayorou">Ayorou</option><option value="Madaoua">Madaoua</option><option value="Mayahi">Mayahi</option><option value="Tera">Tera</option><option value="Tibiri">Tibiri</option><option value="Dakoro">Dakoro</option><option value="Magaria">Magaria</option><option value="Tillabery">Tillabery</option><option value="Matameye">Matameye</option><option value="Illela">Illela</option><option value="Tanout">Tanout</option><option value="Goure">Goure</option><option value="Abalak">Abalak</option><option value="Aguie">Aguie</option><option value="Filingue">Filingue</option><option value="Maine-soroa">Maine-soroa</option><option value="Say">Say</option><option value="Kollo">Kollo</option><option value="Madarounfa">Madarounfa</option><option value="Keita">Keita</option><option value="Ouallam">Ouallam</option><option value="Bouza">Bouza</option><option value="Bilma">Bilma</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Nigeria"){ var str=state_selected; str=str+'<option value="Lagos">Lagos</option><option value="Kano">Kano</option><option value="Ibadan">Ibadan</option><option value="Kaduna">Kaduna</option><option value="Port Harcourt">Port Harcourt</option><option value="Benin">Benin</option><option value="Maiduguri">Maiduguri</option><option value="Zaria">Zaria</option><option value="Aba">Aba</option><option value="Jos">Jos</option><option value="Ilorin">Ilorin</option><option value="Oyo">Oyo</option><option value="Enugu">Enugu</option><option value="Abeokuta">Abeokuta</option><option value="Sokoto">Sokoto</option><option value="Onitsha">Onitsha</option><option value="Warri">Warri</option><option value="Oshogbo">Oshogbo</option><option value="Okene">Okene</option><option value="Calabar">Calabar</option><option value="Katsina">Katsina</option><option value="Akure">Akure</option><option value="Ife">Ife</option><option value="Iseyin">Iseyin</option><option value="Bauchi">Bauchi</option><option value="Ikorodu">Ikorodu</option><option value="Makurdi">Makurdi</option><option value="Minna">Minna</option><option value="Ede">Ede</option><option value="Ilesha">Ilesha</option><option value="Owo">Owo</option><option value="Umuahia">Umuahia</option><option value="Ondo">Ondo</option><option value="Damaturu">Damaturu</option><option value="Ikot Ekpene">Ikot Ekpene</option><option value="Iwo">Iwo</option><option value="Gombe">Gombe</option><option value="Jimeta">Jimeta</option><option value="Gusau">Gusau</option><option value="Mubi">Mubi</option><option value="Ikire">Ikire</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Niue"){ var str=state_selected; str=str+'<option value="Avatele">Avatele</option><option value="Hakupu">Hakupu</option><option value="Makefu">Makefu</option><option value="Namukulu">Namukulu</option><option value="Tuapa">Tuapa</option><option value="Liku">Liku</option><option value="Lakepa">Lakepa</option><option value="Mutalau">Mutalau</option><option value="Neiafu">Neiafu</option><option value="Pangai">Pangai</option><option value="Hihifo">Hihifo</option><option value="Ulutogia">Ulutogia</option><option value="Vailoa">Vailoa</option><option value="Siupapa">Siupapa</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Norfolk Island"){ var str=state_selected; str=str+'<option value="Kingston">Kingston</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Northern Mariana Islands"){ var str=state_selected; str=str+'<option value="Capital Hill">Capital Hill</option><option value="Chalan Kanoa">Chalan Kanoa</option><option value="Dandan">Dandan</option><option value="Garapan">Garapan</option><option value="Gualo Rai">Gualo Rai</option><option value="Kagman">Kagman</option><option value="Koblerville">Koblerville</option><option value="Navy Hill">Navy Hill</option><option value="San Antonio">San Antonio</option><option value="San Jose">San Jose</option><option value="San Vincente">San Vincente</option><option value="Songsong">Songsong</option><option value="Susupe">Susupe</option><option value="Tanapag">Tanapag</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Norway"){ var str=state_selected; str=str+'<option value="Oslo">Oslo</option><option value="Bergen">Bergen</option><option value="Stavanger">Stavanger</option><option value="Trondheim">Trondheim</option><option value="Drammen">Drammen</option><option value="Kristiansand">Kristiansand</option><option value="Tromso">Tromso</option><option value="Bodo">Bodo</option><option value="Larvik">Larvik</option><option value="Halden">Halden</option><option value="Harstad">Harstad</option><option value="Lillehammer">Lillehammer</option><option value="Molde">Molde</option><option value="Mo i Rana">Mo i Rana</option><option value="Horten">Horten</option><option value="Kongsberg">Kongsberg</option><option value="Gjovik">Gjovik</option><option value="Askoy">Askoy</option><option value="Kristiansund">Kristiansund</option><option value="Narvik">Narvik</option><option value="Honefoss">Honefoss</option><option value="Elverum">Elverum</option><option value="Askim">Askim</option><option value="Jessheimy">Jessheimy</option><option value="Alta">Alta</option><option value="Drobak">Drobak</option><option value="Steinkjer">Steinkjer</option><option value="Kongsvinger">Kongsvinger</option><option value="Leirvik">Leirvik</option><option value="Nesoddtangen">Nesoddtangen</option><option value="Mandal">Mandal</option><option value="Stjordalshalsen">Stjordalshalsen</option><option value="Mosjoen">Mosjoen</option><option value="Grimstad">Grimstad</option><option value="Egersund">Egersund</option><option value="Namsos">Namsos</option><option value="Brumunddal">Brumunddal</option><option value="Notodden">Notodden</option><option value="Levanger">Levanger</option><option value="Floro">Floro</option><option value="As">As</option><option value="Sogne">Sogne</option><option value="Verdalsora">Verdalsora</option><option value="Hammerfest">Hammerfest</option><option value="Fetsund">Fetsund</option><option value="Kopervik">Kopervik</option><option value="Orsta">Orsta</option><option value="Indre Arna">Indre Arna</option><option value="Holmestrand">Holmestrand</option><option value="Raufoss">Raufoss</option><option value="Klofta">Klofta</option><option value="Lillesand">Lillesand</option><option value="Fauske">Fauske</option><option value="Tananger">Tananger</option><option value="Hommersak">Hommersak</option><option value="Sandnessjoen">Sandnessjoen</option><option value="Flekkefjord">Flekkefjord</option><option value="Stavern">Stavern</option><option value="Vossevangen">Vossevangen</option><option value="Jorpeland">Jorpeland</option><option value="Odda">Odda</option><option value="Mysen">Mysen</option><option value="Tranby">Tranby</option><option value="Vestby">Vestby</option><option value="Volda">Volda</option><option value="Kragero">Kragero</option><option value="Vadso">Vadso</option><option value="Ulsteinvik">Ulsteinvik</option><option value="Fevik">Fevik</option><option value="Naerbo">Naerbo</option><option value="Rotnes">Rotnes</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Oman"){ var str=state_selected; str=str+'<option value="Salalah">Salalah</option><option value="Nizwa">Nizwa</option><option value="Ruwi">Ruwi</option><option value="Sur">Sur</option><option value="Muscat">Muscat</option><option value="Qurayyat">Qurayyat</option><option value="Ibra">Ibra</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Pakistan"){ var str=state_selected; str=str+'<option value="Karachi">Karachi</option><option value="Lahore">Lahore</option><option value="Faisalabad">Faisalabad</option><option value="Rawalpindi">Rawalpindi</option><option value="Multan">Multan</option><option value="Hyderabad">Hyderabad</option><option value="Peshawar">Peshawar</option><option value="Quetta">Quetta</option><option value="Islamabad">Islamabad</option><option value="Bahawalpur">Bahawalpur</option><option value="Sargodha">Sargodha</option><option value="Sialkot">Sialkot</option><option value="Sukkur">Sukkur</option><option value="Larkana">Larkana</option><option value="Shekhupura">Shekhupura</option><option value="Gujrat">Gujrat</option><option value="Mardan">Mardan</option><option value="Kasur">Kasur</option><option value="Wah">Wah</option><option value="Dera Ghazi Khan">Dera Ghazi Khan</option><option value="Sahiwal">Sahiwal</option><option value="Nawabshah">Nawabshah</option><option value="Mingaora">Mingaora</option><option value="Okara">Okara</option><option value="Mirpur Khas">Mirpur Khas</option><option value="Chiniot">Chiniot</option><option value="Kamoke">Kamoke</option><option value="Sadiqabad">Sadiqabad</option><option value="Burewala">Burewala</option><option value="Jacobabad">Jacobabad</option><option value="Muzaffargarh">Muzaffargarh</option><option value="Muridke">Muridke</option><option value="Jhelum">Jhelum</option><option value="Shikarpur">Shikarpur</option><option value="Khanewal">Khanewal</option><option value="Hafizabad">Hafizabad</option><option value="Kohat">Kohat</option><option value="Khanpur">Khanpur</option><option value="Khuzdar">Khuzdar</option><option value="Dadu">Dadu</option><option value="Gojra">Gojra</option><option value="Mandi Bahauddin">Mandi Bahauddin</option><option value="Daska">Daska</option><option value="Pakpattan">Pakpattan</option><option value="Bahawalnagar">Bahawalnagar</option><option value="Tando Adam">Tando Adam</option><option value="Khairpur">Khairpur</option><option value="Chishtian Mandi">Chishtian Mandi</option><option value="Abbottabad">Abbottabad</option><option value="Jaranwala">Jaranwala</option><option value="Ahmadpur”>Ahmadpur </option><option value="Vihari">Vihari</option><option value="Kamalia">Kamalia</option><option value="Kot Addu">Kot Addu</option><option value="Khushab">Khushab</option><option value="Wazirabad">Wazirabad</option><option value="Dera Ismail Khan">Dera Ismail Khan</option><option value="Chakwal">Chakwal</option><option value="Swabi">Swabi</option><option value="Lodhran">Lodhran</option><option value="Nowshera">Nowshera</option><option value="Charsadda">Charsadda</option><option value="Jalalpur Jattan">Jalalpur Jattan</option><option value="Mianwali">Mianwali</option><option value="Chaman">Chaman</option><option value="Hasilpur">Hasilpur</option><option value="Arifwala">Arifwala</option><option value="Attock">Attock</option><option value="Chichawatni">Chichawatni</option><option value="Bhakkar">Bhakkar</option><option value="Kharian">Kharian</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Palau"){ var str=state_selected; str=str+'<option value="Koror">Koror</option><option value="Meyungs">Meyungs</option><option value="Airai">Airai</option><option value="Kloulklubed">Kloulklubed</option><option value="Ngermechau">Ngermechau</option><option value="Melekeok">Melekeok</option><option value="Ngaramash">Ngaramash</option><option value="Imeong">Imeong</option><option value="Ulimang">Ulimang</option><option value="Ollei">Ollei</option><option value="Ngetkip">Ngetkip</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Palestinian Territory, Occupied"){ var str=state_selected; str=str+'<option value="N/A">N/A</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Panama"){ var str=state_selected; str=str+'<option value="San Miguelito">San Miguelito</option><option value="Tocumen">Tocumen</option><option value="David">David</option><option value="Arraijan">Arraijan</option><option value="Colon">Colon</option><option value="Las Cumbres">Las Cumbres</option><option value="La Chorrera">La Chorrera</option><option value="Pacora">Pacora</option><option value="Santiago">Santiago</option><option value="Chitre">Chitre</option><option value="Vista Alegre">Vista Alegre</option><option value="Chilibre">Chilibre</option><option value="Cativa">Cativa</option><option value="Nuevo Arraijan">Nuevo Arraijan</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Papua New Guinea"){ var str=state_selected; str=str+'<option value="Changuinola">Changuinola</option><option value="La Cabima">La Cabima</option><option value="Aguadulce">Aguadulce</option><option value="La Concepcion">La Concepcion</option><option value="Pedregal">Pedregal</option><option value="Veracruz">Veracruz</option><option value="Chepo">Chepo</option><option value="Anton">Anton</option><option value="Sabanitas">Sabanitas</option><option value="Penonome">Penonome</option><option value="Puerto Escondido">Puerto Escondido</option><option value="El Coco">El Coco</option><option value="Las Lomas">Las Lomas</option><option value="Pocri">Pocri</option><option value="Volcan">Volcan</option><option value="Ancon">Ancon</option><option value="Las Tablas">Las Tablas</option><option value="Guadalupe">Guadalupe</option><option value="Almirante">Almirante</option><option value="Sona">Sona</option><option value="Boquete">Boquete</option><option value="Guabito">Guabito</option><option value="Los Santos">Los Santos</option><option value="Puerto Pilon">Puerto Pilon</option><option value="Nata">Nata</option><option value="La Mitra">La Mitra</option><option value="Rio Hato">Rio Hato</option><option value="El Progreso">El Progreso</option><option value="Lidice">Lidice</option><option value="Potrero Grande">Potrero Grande</option><option value="Alto del Espino">Alto del Espino</option><option value="Rio Alejandro">Rio Alejandro</option><option value="Bocas del Toro">Bocas del Toro</option><option value="Bejuco">Bejuco</option><option value="Capira">Capira</option><option value="La Herradura">La Herradura</option><option value="Margarita">Margarita</option><option value="Pese">Pese</option><option value="Canoa">Canoa</option><option value="Buena Vista">Buena Vista</option><option value="Ocu">Ocu</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Paraguay"){ var str=state_selected; str=str+'<option value="Asuncion">Asuncion</option><option value="San Lorenzo">San Lorenzo</option><option value="Luque">Luque</option><option value="Capiata">Capiata</option><option value="Lambare">Lambare</option><option value="Fernando de la Mora">Fernando de la Mora</option><option value="Limpio">Limpio</option><option value="Nemby">Nemby</option><option value="Encarnacion">Encarnacion</option><option value="Mariano Roque Alonso">Mariano Roque Alonso</option><option value="Pedro Juan Caballero">Pedro Juan Caballero</option><option value="Itaugua">Itaugua</option><option value="Villa Elisa">Villa Elisa</option><option value="San Antonio">San Antonio</option><option value="Caaguazu">Caaguazu</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Peru"){ var str=state_selected; str=str+'<option value="Lima">Lima</option><option value="Arequipa">Arequipa</option><option value="Trujillo">Trujillo</option><option value="Chiclayo">Chiclayo</option><option value="Iquitos">Iquitos</option><option value="Huancayo">Huancayo</option><option value="Piura">Piura</option><option value="Chimbote">Chimbote</option><option value="Cusco">Cusco</option><option value="Pucallpa">Pucallpa</option><option value="Tacna">Tacna</option><option value="Juliaca">Juliaca</option><option value="Ica">Ica</option><option value="Sullana">Sullana</option><option value="Chincha Alta">Chincha Alta</option><option value="Huanuco">Huanuco</option><option value="Ayacucho">Ayacucho</option><option value="Cajamarca">Cajamarca</option><option value="Puno">Puno</option><option value="Chosica">Chosica</option><option value="Tumbes">Tumbes</option><option value="Talara">Talara</option><option value="Huaraz">Huaraz</option><option value="Cerro de Pasco">Cerro de Pasco</option><option value="Chulucanas">Chulucanas</option><option value="Huaral">Huaral</option><option value="Pisco">Pisco</option><option value="Catacaos">Catacaos</option><option value="Paita">Paita</option><option value="Abancay">Abancay</option><option value="Moquegua">Moquegua</option><option value="Huacho">Huacho</option><option value="Ilo">Ilo</option><option value="Tingo Maria">Tingo Maria</option><option value="Jaen">Jaen</option><option value="Tarma">Tarma</option><option value="Barranca">Barranca</option><option value="Moyobamba">Moyobamba</option><option value="Lambayeque">Lambayeque</option><option value="Picsi">Picsi</option><option value="Chepen">Chepen</option><option value="Yurimaguas">Yurimaguas</option><option value="Huancavelica">Huancavelica</option><option value="Sana">Sana</option><option value="Tambopata">Tambopata</option><option value="Juanjui">Juanjui</option><option value="Puerto Maldonado">Puerto Maldonado</option><option value="Nuevo Imperial">Nuevo Imperial</option><option value="Imperial">Imperial</option><option value="La Union">La Union</option><option value="Ferrenafe, Peru">Ferrenafe, Peru</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Philippines"){ var str=state_selected; str=str+'<option value="Manila">Manila</option><option value="Davao">Davao</option><option value="Cebu">Cebu</option><option value="Antipolo">Antipolo</option><option value="Zamboanga">Zamboanga</option><option value="Bacolod">Bacolod</option><option value="Cagayan de Oro">Cagayan de Oro</option><option value="Dasmarinas">Dasmarinas</option><option value="Dadiangas">Dadiangas</option><option value="Iloilo">Iloilo</option><option value="Bacoor">Bacoor</option><option value="Calamba">Calamba</option><option value="Angeles">Angeles</option><option value="Mandaue">Mandaue</option><option value="Cainta">Cainta</option><option value="Baguio">Baguio</option><option value="San Pedro">San Pedro</option><option value="Iligan">Iligan</option><option value="San Fernando">San Fernando</option><option value="Butuan">Butuan</option><option value="Lapu-Lapu">Lapu-Lapu</option><option value="Batangas">Batangas</option><option value="Taytay">Taytay</option><option value="Lucena">Lucena</option><option value="Cabanatuan">Cabanatuan</option><option value="Olongapo">Olongapo</option><option value="Binangonan">Binangonan</option><option value="Santa Rosa">Santa Rosa</option><option value="Lipa">Lipa</option><option value="San Pablo">San Pablo</option><option value="Malolos">Malolos</option><option value="Tacloban">Tacloban</option><option value="Mabalacat">Mabalacat</option><option value="Meycauayan">Meycauayan</option><option value="Tarlac">Tarlac</option><option value="Cotabato">Cotabato</option><option value="Tagum">Tagum</option><option value="Toledo">Toledo</option><option value="Puerto Princesa">Puerto Princesa</option><option value="Naga">Naga</option><option value="Marawi">Marawi</option><option value="Legaspi">Legaspi</option><option value="Kabankalan">Kabankalan</option><option value="Dagupan">Dagupan</option><option value="Baliuag">Baliuag</option><option value="San Mateo">San Mateo</option><option value="Montalban">Montalban</option><option value="Talisay">Talisay</option><option value="Pagadian">Pagadian</option><option value="Bulaon">Bulaon</option><option value="Cadiz">Cadiz</option><option value="Hagonoy">Hagonoy</option><option value="Koronadal">Koronadal</option><option value="Digos">Digos</option><option value="Tuguegarao">Tuguegarao</option><option value="Cavite">Cavite</option><option value="Dumaguete">Dumaguete</option><option value="Santiago">Santiago</option><option value="Santa Cruz">Santa Cruz</option><option value="Tanza">Tanza</option><option value="Urdaneta">Urdaneta</option><option value="Roxas">Roxas</option><option value="Jolo">Jolo</option><option value="Laoag">Laoag</option><option value="San Jose">San Jose</option><option value="Bocaue">Bocaue</option><option value="Los Banos">Los Banos</option><option value="Iriga">Iriga</option><option value="Dipolog">Dipolog</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Pitcairn"){ var str=state_selected; str=str+'<option value="N/A">N/A</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Poland"){ var str=state_selected; str=str+'<option value="Warsaw">Warsaw</option><option value="Cracow">Cracow</option><option value="Poznan">Poznan</option><option value="Gdansk">Gdansk</option><option value="Szczecin">Szczecin</option><option value="Bydgoszcz">Bydgoszcz</option><option value="Lublin">Lublin</option><option value="Katowice">Katowice</option><option value="Gdynia">Gdynia</option><option value="Czestochowa,">Czestochowa,</option><option value="Sosnowiec">Sosnowiec</option><option value="Radom">Radom</option><option value="Torun">Torun</option><option value="Kielce">Kielce</option><option value="Gliwice">Gliwice</option><option value="Zabrze">Zabrze</option><option value="Bytom">Bytom</option><option value="Olsztyn">Olsztyn</option><option value="Rzeszow">Rzeszow</option><option value="Ruda Slaska">Ruda Slaska</option><option value="Rybnik">Rybnik</option><option value="Tychy">Tychy</option><option value="Dabrowa Gornicza">Dabrowa Gornicza</option><option value="Opole">Opole</option><option value="Elblag">Elblag</option><option value="Gorzow Wielkopolski">Gorzow Wielkopolski</option><option value="Zielona Gora">Zielona Gora</option><option value="Tarnow">Tarnow</option><option value="Chorzow">Chorzow</option><option value="Kalisz">Kalisz</option><option value="Koszalin">Koszalin</option><option value="Legnica">Legnica</option><option value="Grudziadz">Grudziadz</option><option value="Jaworzno">Jaworzno</option><option value="Jelenia Gora">Jelenia Gora</option><option value="Nowy Sacz">Nowy Sacz</option><option value="Konin">Konin</option><option value="Piotrkow Trybunalski">Piotrkow Trybunalski</option><option value="Lubin">Lubin</option><option value="Siedlce">Siedlce</option><option value="Ostrowiec Swietokrzyski">Ostrowiec Swietokrzyski</option><option value="Ostrow Wielkopolski">Ostrow Wielkopolski</option><option value="Stargard Szczecinski">Stargard Szczecinski</option><option value="Pabianice">Pabianice</option><option value="Gniezno">Gniezno</option><option value="Kholm">Kholm</option><option value="Tomaszow Mazowiecki">Tomaszow Mazowiecki</option><option value="Stalowa Wola">Stalowa Wola</option><option value="Zamosc">Zamosc</option><option value="Kedzierzyn-Kozle">Kedzierzyn-Kozle</option><option value="Leszno">Leszno</option><option value="Zory">Zory</option><option value="Mielec">Mielec</option><option value="Tarnowskie Gory">Tarnowskie Gory</option><option value="Swidnica">Swidnica</option><option value="Tczew">Tczew</option><option value="Piekary Slaskie">Piekary Slaskie</option><option value="Raciborz">Raciborz</option><option value="Bedzin">Bedzin</option><option value="Zgierz">Zgierz</option><option value="Pruszkow">Pruszkow</option><option value="Starachowice">Starachowice</option><option value="Zawiercie">Zawiercie</option><option value="Legionowo">Legionowo</option><option value="Tarnobrzeg">Tarnobrzeg</option><option value="Skarzysko-Kamienna">Skarzysko-Kamienna</option><option value="Radomsko">Radomsko</option><option value="Skierniewice">Skierniewice</option><option value="Kutno">Kutno</option><option value="Starogard Gdanski">Starogard Gdanski</option><option value="Nysa">Nysa</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Portugal"){ var str=state_selected; str=str+'<option value="Lisbon">Lisbon</option><option value="Porto">Porto</option><option value="Amadora">Amadora</option><option value="Braga">Braga</option><option value="Setubal">Setubal</option><option value="Coimbra">Coimbra</option><option value="Queluz">Queluz</option><option value="Funchal">Funchal</option><option value="Vila Nova de Gaia">Vila Nova de Gaia</option><option value="Loures">Loures</option><option value="Rio de Mouro">Rio de Mouro</option><option value="Odivelas">Odivelas</option><option value="Aveiro">Aveiro</option><option value="Amora">Amora</option><option value="Corroios">Corroios</option><option value="Barreiro">Barreiro</option><option value="Rio Tinto">Rio Tinto</option><option value="Sao Domingos De Rana">Sao Domingos De Rana</option><option value="Evora">Evora</option><option value="Leiria">Leiria</option><option value="Faro">Faro</option><option value="Sesimbra">Sesimbra</option><option value="Guimaraes">Guimaraes</option><option value="Portimao">Portimao</option><option value="Cascais">Cascais</option><option value="Maia">Maia</option><option value="Almada">Almada</option><option value="Castelo Branco">Castelo Branco</option><option value="Alcabideche">Alcabideche</option><option value="Camara De Lobos">Camara De Lobos</option><option value="Arrentela">Arrentela</option><option value="Montijo">Montijo</option><option value="Santarem">Santarem</option><option value="Olhao">Olhao</option><option value="Povoa De Varzim">Povoa De Varzim</option><option value="Senhora da Hora">Senhora da Hora</option><option value="Marinha Grande">Marinha Grande</option><option value="Povoa De Santa Iria">Povoa De Santa Iria</option><option value="Guarda">Guarda</option><option value="Matosinhos">Matosinhos</option><option value="Gondomar">Gondomar</option><option value="Aguas Santas">Aguas Santas</option><option value="Vila do Conde">Vila do Conde</option><option value="Caldas da Rainha">Caldas da Rainha</option><option value="Canidelo">Canidelo</option><option value="Viseu">Viseu</option><option value="Sintra">Sintra</option><option value="Paco De Arcos">Paco De Arcos</option><option value="Sao Mamede De Infesta">Sao Mamede De Infesta</option><option value="Torres Vedras">Torres Vedras</option><option value="Oliveira do Douro">Oliveira do Douro</option><option value="Fanzeres">Fanzeres</option><option value="Beja">Beja</option><option value="Charneca de Caparica">Charneca de Caparica</option><option value="Carnaxide">Carnaxide</option><option value="Pinhal Novo">Pinhal Novo</option><option value="Estoril">Estoril</option><option value="Pontinha">Pontinha</option><option value="Loule">Loule</option><option value="Sao Joao Da Madeira">Sao Joao Da Madeira</option><option value="Bougado">Bougado</option><option value="Braganca">Braganca</option><option value="Valongo">Valongo</option><option value="Caparica">Caparica</option><option value="Belas">Belas</option><option value="Linda-a-Velha">Linda-a-Velha</option><option value="Laranjeiro">Laranjeiro</option><option value="Carcavelos">Carcavelos</option><option value="Camarate">Camarate</option><option value="Ponta Delgada">Ponta Delgada</option><option value="Entroncamento">Entroncamento</option><option value="Cova da Piedade">Cova da Piedade</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Puerto Rico"){ var str=state_selected; str=str+'<option value="San Juan">San Juan</option><option value="Carolina">Carolina</option><option value="Ponce">Ponce</option><option value="Caguas">Caguas</option><option value="Guaynabo">Guaynabo</option><option value="Mayaguez">Mayaguez</option><option value="Trujillo Alto">Trujillo Alto</option><option value="Arecibo">Arecibo</option><option value="Rio Grande">Rio Grande</option><option value="Fajardo">Fajardo</option><option value="Levittown">Levittown</option><option value="Vega Baja">Vega Baja</option><option value="Catano">Catano</option><option value="Guayama">Guayama</option><option value="Humacao">Humacao</option><option value="Yauco">Yauco</option><option value="Cayey">Cayey</option><option value="Candelaria">Candelaria</option><option value="Manati">Manati</option><option value="Aguadilla">Aguadilla</option><option value="Dorado">Dorado</option><option value="Isabela">Isabela</option><option value="San German">San German</option><option value="Vega Alta">Vega Alta</option><option value="Coamo">Coamo</option><option value="Hormigueros">Hormigueros</option><option value="San Sebastian">San Sebastian</option><option value="Corozal">Corozal</option><option value="Cabo Rojo">Cabo Rojo</option><option value="Utuado">Utuado</option><option value="Juana Diaz">Juana Diaz</option><option value="San Lorenzo">San Lorenzo</option><option value="Guanica">Guanica</option><option value="Gurabo">Gurabo</option><option value="Sabana Grande">Sabana Grande</option><option value="Aibonito">Aibonito</option><option value="Juncos">Juncos</option><option value="Canovanas">Canovanas</option><option value="Luquillo">Luquillo</option><option value="Arroyo">Arroyo</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Qatar"){ var str=state_selected; str=str+'<option value="Doha">Doha</option><option value="Khor">Khor</option><option value="Umm Bab">Umm Bab</option><option value="Abu Samrah">Abu Samrah</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Reunion"){ var str=state_selected; str=str+'<option value="Saint-Denis">Saint-Denis</option><option value="Saint-Paul">Saint-Paul</option><option value="Saint-Pierre">Saint-Pierre</option><option value="Le Tampon">Le Tampon</option><option value="Saint-andre">Saint-andre</option><option value="Saint-Louis">Saint-Louis</option><option value="Le Port">Le Port</option><option value="Saint-benoit">Saint-benoit</option><option value="Saint-Joseph">Saint-Joseph</option><option value="Sainte-Marie">Sainte-Marie</option><option value="Saint-Leu">Saint-Leu</option><option value="La Possession">La Possession</option><option value="Sainte-Suzanne">Sainte-Suzanne</option><option value="Bras-Panon">Bras-Panon</option><option value="Salazie">Salazie</option><option value="Les Trois-Bassins">Les Trois-Bassins</option><option value="Sainte-Rose">Sainte-Rose</option><option value="Cilaos">Cilaos</option><option value="Entre-Deux">Entre-Deux</option><option value="Saint-Philippe">Saint-Philippe</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Romania"){ var str=state_selected; str=str+'<option value="Bucharest">Bucharest</option><option value="Iasi">Iasi</option><option value="Cluj-Napoca">Cluj-Napoca</option><option value="Timisoara">Timisoara</option><option value="Craiova">Craiova</option><option value="Constanta">Constanta</option><option value="Galati">Galati</option><option value="Brasov">Brasov</option><option value="Ploiesti">Ploiesti</option><option value="Braila">Braila</option><option value="Oradea">Oradea</option><option value="Bacau">Bacau</option><option value="Arad">Arad</option><option value="Pitesti">Pitesti</option><option value="Sibiu">Sibiu</option><option value="Targu-Mures">Targu-Mures</option><option value="Baia Mare">Baia Mare</option><option value="Buzau">Buzau</option><option value="Botosani">Botosani</option><option value="Satu Mare">Satu Mare</option><option value="Ramnicu Valcea">Ramnicu Valcea</option><option value="Suceava">Suceava</option><option value="Focsani">Focsani</option><option value="Piatra Neamt">Piatra Neamt</option><option value="Drobeta-Turnu Severin">Drobeta-Turnu Severin</option><option value="Targu Jiu">Targu Jiu</option><option value="Tulcea">Tulcea</option><option value="Targoviste">Targoviste</option><option value="Bistrita">Bistrita</option><option value="Resita">Resita</option><option value="Slatina">Slatina</option><option value="Vaslui">Vaslui</option><option value="Calarasi">Calarasi</option><option value="Hunedoara">Hunedoara</option><option value="Giurgiu">Giurgiu</option><option value="Roman">Roman</option><option value="Barlad">Barlad</option><option value="Deva">Deva</option><option value="Alba Iulia">Alba Iulia</option><option value="Zalau">Zalau</option><option value="Turda">Turda</option><option value="Medias">Medias</option><option value="Slobozia">Slobozia</option><option value="Onesti">Onesti</option><option value="Alexandria">Alexandria</option><option value="Petrosani">Petrosani</option><option value="Medgidia">Medgidia</option><option value="Lugoj">Lugoj</option><option value="Pascani">Pascani</option><option value="Miercurea-Ciuc">Miercurea-Ciuc</option><option value="Tecuci">Tecuci</option><option value="Sighetu Marmatiei">Sighetu Marmatiei</option><option value="Mangalia">Mangalia</option><option value="Ramnicu Sarat">Ramnicu Sarat</option><option value="Campina">Campina</option><option value="Dej">Dej</option><option value="Campulung">Campulung</option><option value="Odorheiu Secuiesc">Odorheiu Secuiesc</option><option value="Mioveni">Mioveni</option><option value="Reghin">Reghin</option><option value="Fagaras">Fagaras</option><option value="Caracal">Caracal</option><option value="Navodari">Navodari</option><option value="Fetesti">Fetesti</option><option value="Curtea de Arges">Curtea de Arges</option><option value="Sighisoara">Sighisoara</option><option value="Dorohoi">Dorohoi</option><option value="Rosiori de Vede">Rosiori de Vede</option><option value="Lupeni">Lupeni</option><option value="Voluntari">Voluntari</option><option value="Sacele">Sacele</option><option value="Falticeni">Falticeni</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Russian Federation"){ var str=state_selected; str=str+'<option value="Moscow">Moscow</option><option value="Saint Petersburg">Saint Petersburg</option><option value="Novosibirsk">Novosibirsk</option><option value="Yekaterinburg">Yekaterinburg</option><option value="Nizhniy Novgorod">Nizhniy Novgorod</option><option value="Samara">Samara</option><option value="Omsk">Omsk</option><option value="Kazan">Kazan</option><option value="Rostov-na-Donu">Rostov-na-Donu</option><option value="Chelyabinsk">Chelyabinsk</option><option value="Ufa">Ufa</option><option value="Volgograd">Volgograd</option><option value="Perm">Perm</option><option value="Krasnoyarsk">Krasnoyarsk</option><option value="Saratov">Saratov</option><option value="Voronezh">Voronezh</option><option value="Tolyatti">Tolyatti</option><option value="Krasnodar">Krasnodar</option><option value="Ulyanovsk">Ulyanovsk</option><option value="Izhevsk">Izhevsk</option><option value="Yaroslavl">Yaroslavl</option><option value="Barnaul">Barnaul</option><option value="Vladivostok">Vladivostok</option><option value="Irkutsk">Irkutsk</option><option value="Khabarovsk">Khabarovsk</option><option value="Chkalov">Chkalov</option><option value="Novokuznetsk">Novokuznetsk</option><option value="Ryazan">Ryazan</option><option value="Tyumen">Tyumen</option><option value="Lipetsk">Lipetsk</option><option value="Penza">Penza</option><option value="Astrakhan">Astrakhan</option><option value="Makhachkala">Makhachkala</option><option value="Tomsk">Tomsk</option><option value="Kemerovo">Kemerovo</option><option value="Tula">Tula</option><option value="Kirov">Kirov</option><option value="Cheboksary">Cheboksary</option><option value="Kaliningrad">Kaliningrad</option><option value="Bryansk">Bryansk</option><option value="Ivanovo">Ivanovo</option><option value="Magnitogorsk">Magnitogorsk</option><option value="Kursk">Kursk</option><option value="Tver, Russia">Tver, Russia</option><option value="Nizhniy Tagil">Nizhniy Tagil</option><option value="Stavropol">Stavropol</option><option value="Ulan-Ude">Ulan-Ude</option><option value="Belgorod">Belgorod</option><option value="Arkhangelsk">Arkhangelsk</option><option value="Kurgan">Kurgan</option><option value="Kaluga">Kaluga</option><option value="Orel">Orel</option><option value="Sochi">Sochi</option><option value="Volzhskiy">Volzhskiy</option><option value="Smolensk">Smolensk</option><option value="Murmansk">Murmansk</option><option value="Vladikavkaz">Vladikavkaz</option><option value="Cherepovets">Cherepovets</option><option value="Vladimir">Vladimir</option><option value="Chita">Chita</option><option value="Saransk">Saransk</option><option value="Surgut">Surgut</option><option value="Vologda">Vologda</option><option value="Tambov">Tambov</option><option value="Nalchik">Nalchik</option><option value="Taganrog">Taganrog</option><option value="Kostroma">Kostroma</option><option value="Komsomolsk-na-Amure">Komsomolsk-na-Amure</option><option value="Sterlitamak">Sterlitamak</option><option value="Petrozavodsk">Petrozavodsk</option><option value="Bratsk">Bratsk</option><option value="Dzerzhinsk">Dzerzhinsk</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Rwanda"){ var str=state_selected; str=str+'<option value="Kigali">Kigali</option><option value="Butare">Butare</option><option value="Gitarama">Gitarama</option><option value="Ruhengeri">Ruhengeri</option><option value="Gisenyi">Gisenyi</option><option value="Byumba">Byumba</option><option value="Cyangugu">Cyangugu</option><option value="Nyanza">Nyanza</option><option value="Rwamagana">Rwamagana</option><option value="Kibuye">Kibuye</option><option value="Kibungo">Kibungo</option><option value="Gikongoro">Gikongoro</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Saint Helena"){ var str=state_selected; str=str+'<option value="Jamestown">Jamestown</option><option value="Georgetown">Georgetown</option><option value="Edinburgh">Edinburgh</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Saint Kitts and Nevis"){ var str=state_selected; str=str+'<option value="Basseterre">Basseterre</option><option value="Charlestown">Charlestown</option><option value="Sadlers">Sadlers</option><option value="Middle Island">Middle Island</option><option value="Cayon">Cayon</option><option value="Sandy Point">Sandy Point</option><option value="Mansion">Mansion</option><option value="Dieppe Bay">Dieppe Bay</option><option value="Monkey Hill">Monkey Hill</option><option value="Newcastle">Newcastle</option><option value="Gingerland">Gingerland</option><option value="Fig Tree">Fig Tree</option><option value="Cotton Ground">Cotton Ground</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Saint Lucia"){ var str=state_selected; str=str+'<option value="Castries">Castries</option><option value="Vieux Fort">Vieux Fort</option><option value="Micoud">Micoud</option><option value="Dennery">Dennery</option><option value="Soufriere">Soufriere</option><option value="Gros Islet">Gros Islet</option><option value="Laborie">Laborie</option><option value="Canaries">Canaries</option><option value="Cap Estate">Cap Estate</option><option value="Choiseul">Choiseul</option><option value="Choc">Choc</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Saint Pierre and Miquelon"){ var str=state_selected; str=str+'<option value="Saint-Pierre">Saint-Pierre</option><option value="Miquelon">Miquelon</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Saint Vincent and The Grenadines"){ var str=state_selected; str=str+'<option value="Kingstown">Kingstown</option><option value="Barroualie">Barroualie</option><option value="Georgetown">Georgetown</option><option value="Layou">Layou</option><option value="Biabou">Biabou</option><option value="Port Elizabeth">Port Elizabeth</option><option value="Chateaubelair">Chateaubelair</option><option value="Dovers">Dovers</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Samoa"){ var str=state_selected; str=str+'<option value="Apia">Apia</option><option value="Vaitele">Vaitele</option><option value="Faleula">Faleula</option><option value="Siusega">Siusega</option><option value="Malie">Malie</option><option value="Fasitoouta">Fasitoouta</option><option value="Vaiusu">Vaiusu</option><option value="Afega">Afega</option><option value="Nofoalii">Nofoalii</option><option value="Solosolo">Solosolo</option><option value="Leulumoega">Leulumoega</option><option value="Satapuala">Satapuala</option><option value="Falefa">Falefa</option><option value="Safotu">Safotu</option><option value="Gataivai">Gataivai</option><option value="Lotofaga">Lotofaga</option><option value="Lufilufi">Lufilufi</option><option value="Sapulu">Sapulu</option><option value="Samatau">Samatau</option><option value="Tufulele">Tufulele</option><option value="Sapapalii">Sapapalii</option><option value="Sili">Sili</option><option value="Faleatiu">Faleatiu</option><option value="Samalaeulu">Samalaeulu</option><option value="Toamua">Toamua</option><option value="Sagone">Sagone</option><option value="Sataua">Sataua</option><option value="Vaigaga">Vaigaga</option><option value="Lano">Lano</option><option value="Saipipi">Saipipi</option><option value="Lalomanu">Lalomanu</option><option value="Samusu">Samusu</option><option value="Taga">Taga</option><option value="Siutu">Siutu</option><option value="Saleilua">Saleilua</option><option value="Vaisala">Vaisala</option><option value="Saleaula">Saleaula</option><option value="Patamea">Patamea</option><option value="Faleapuna">Faleapuna</option><option value="Vaovai">Vaovai</option><option value="Auala">Auala</option><option value="Sasina">Sasina</option><option value="Falevao">Falevao</option><option value="Pata">Pata</option><option value="Saleaaumua">Saleaaumua</option><option value="Letogo">Letogo</option><option value="Salani">Salani</option><option value="Satitoa">Satitoa</option><option value="Saasaai">Saasaai</option><option value="Falealupo">Falealupo</option><option value="Vaiee">Vaiee</option><option value="Saaga">Saaga</option><option value="Aufaga">Aufaga</option><option value="Mulivai">Mulivai</option><option value="Fusi">Fusi</option><option value="Faiaai">Faiaai</option><option value="Vaipua">Vaipua</option><option value="Falelima">Falelima</option><option value="Salelesi">Salelesi</option><option value="Sapunaoa">Sapunaoa</option><option value="Lalomauga">Lalomauga</option><option value="Tafua">Tafua</option><option value="Lalomalava">Lalomalava</option><option value="Matatufu">Matatufu</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="San Marino"){ var str=state_selected; str=str+'<option value="Serravalle">Serravalle</option><option value="San Marino">San Marino</option><option value="Acquaviva">Acquaviva</option><option value="Chiesanuova">Chiesanuova</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Sao Tome and Principe"){ var str=state_selected; str=str+'<option value="São Tomé">São Tomé</option><option value="Santo Amaro">Santo Amaro</option><option value="Neves">Neves</option><option value="Santana">Santana</option><option value="Trindade">Trindade</option><option value="Santa Cruz">Santa Cruz</option><option value="Pantufo">Pantufo</option><option value="Guadalupe">Guadalupe</option><option value="Santo António">Santo António</option><option value="Santa Catarina">Santa Catarina</option><option value="Porto Alegre">Porto Alegre</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Saudi Arabia"){ var str=state_selected; str=str+'<option value="Riyadh">Riyadh</option><option value="Jeddah">Jeddah</option><option value="Mecca">Mecca</option><option value="Tabuk">Tabuk</option><option value="Buraydah">Buraydah</option><option value="Jubail">Jubail</option><option value="Abha">Abha</option><option value="Najran">Najran</option><option value="Jizan">Jizan</option><option value="Sakakah">Sakakah</option><option value="Sayhat">Sayhat</option><option value="Sabya">Sabya</option><option value="Tarut">Tarut</option><option value="Safwah">Safwah</option><option value="Buqayq">Buqayq</option><option value="Turayf">Turayf</option><option value="Umm Lajj">Umm Lajj</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Senegal"){ var str=state_selected; str=str+'<option value="Dakar">Dakar</option><option value="Thies">Thies</option><option value="Kaolack">Kaolack</option><option value="Ziguinchor">Ziguinchor</option><option value="Mbour">Mbour</option><option value="Saint-Louis">Saint-Louis</option><option value="Diourbel">Diourbel</option><option value="Louga">Louga</option><option value="Richard Toll">Richard Toll</option><option value="Tambacounda">Tambacounda</option><option value="Kolda">Kolda</option><option value="Mbacke">Mbacke</option><option value="Fatick">Fatick</option><option value="Tivaouane">Tivaouane</option><option value="Bignona">Bignona</option><option value="Kaffrine">Kaffrine</option><option value="Bambey">Bambey</option><option value="Dagana">Dagana</option><option value="Pout">Pout</option><option value="Velingara">Velingara</option><option value="Nioro">Nioro</option><option value="Kebemer">Kebemer</option><option value="Sedhiou">Sedhiou</option><option value="Mekhe">Mekhe</option><option value="Dahra">Dahra</option><option value="Kedougou">Kedougou</option><option value="Sokone">Sokone</option><option value="Guinguineo">Guinguineo</option><option value="Koungheul">Koungheul</option><option value="Khombole">Khombole</option><option value="Waounde">Waounde</option><option value="Matam">Matam</option><option value="Gossas">Gossas</option><option value="Linguere">Linguere</option><option value="Bakel">Bakel</option><option value="Goudomp">Goudomp</option><option value="Ourossogui">Ourossogui</option><option value="Marsassoum">Marsassoum</option><option value="Thiadiaye">Thiadiaye</option><option value="Oussouye">Oussouye</option><option value="Podor">Podor</option><option value="Diofior">Diofior</option><option value="Gandiaye">Gandiaye</option><option value="Ndioum">Ndioum</option><option value="Kanel">Kanel</option><option value="Thilogne">Thilogne</option><option value="Foundiougne">Foundiougne</option><option value="Passi">Passi</option><option value="Semme">Semme</option><option value="Kahone">Kahone</option><option value="Gollere">Gollere</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Serbia and Montenegro"){ var str=state_selected; str=str+'<option value="Belgrade">Belgrade</option><option value="Novi Sad">Novi Sad</option><option value="Nis">Nis</option><option value="Kragujevac">Kragujevac</option><option value="Subotica">Subotica</option><option value="Pec">Pec</option><option value="Zrenjanin">Zrenjanin</option><option value="Pancevo">Pancevo</option><option value="Cacak">Cacak</option><option value="Leskovac">Leskovac</option><option value="Smederevo">Smederevo</option><option value="Valjevo">Valjevo</option><option value="Kraljevo">Kraljevo</option><option value="Krusevac">Krusevac</option><option value="Vranje">Vranje</option><option value="Novi Pazar">Novi Pazar</option><option value="Uzice">Uzice</option><option value="Sabac">Sabac</option><option value="Sombor">Sombor</option><option value="Pozarevac">Pozarevac</option><option value="Pirot">Pirot</option><option value="Zajecar">Zajecar</option><option value="Bor">Bor</option><option value="Sremska Mitrovica">Sremska Mitrovica</option><option value="Borca">Borca</option><option value="Vrsac">Vrsac</option><option value="Jagodina">Jagodina</option><option value="Ruma">Ruma</option><option value="Backa Palanka">Backa Palanka</option><option value="Indija">Indija</option><option value="Prokuplje">Prokuplje</option><option value="Vrbas">Vrbas</option><option value="Becej">Becej</option><option value="Smederevska Palanka">Smederevska Palanka</option><option value="Paracin">Paracin</option><option value="Arandelovac">Arandelovac</option><option value="Gornji Milanovac">Gornji Milanovac</option><option value="Lazarevac">Lazarevac</option><option value="Obrenovac">Obrenovac</option><option value="Kaluderica">Kaluderica</option><option value="Mladenovac">Mladenovac</option><option value="Loznica">Loznica</option><option value="Veternik">Veternik</option><option value="Cuprija">Cuprija</option><option value="Senta">Senta</option><option value="Temerin">Temerin</option><option value="Apatin">Apatin</option><option value="Kula">Kula</option><option value="Futog">Futog</option><option value="Stara Pazova">Stara Pazova</option><option value="Priboj">Priboj</option><option value="Sremcica">Sremcica</option><option value="Nova Pazova">Nova Pazova</option><option value="Negotin">Negotin</option><option value="Trstenik">Trstenik</option><option value="Sid">Sid</option><option value="Vlasotince">Vlasotince</option><option value="Aleksinac, Serbia">Aleksinac, Serbia</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Seychelles"){ var str=state_selected; str=str+'<option value="Victoria">Victoria</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Sierra Leone"){ var str=state_selected; str=str+'<option value="Freetown">Freetown</option><option value="Koidu">Koidu</option><option value="Bo">Bo</option><option value="Kenema">Kenema</option><option value="Makeni">Makeni</option><option value="Lunsar">Lunsar</option><option value="Waterloo">Waterloo</option><option value="Port Loko">Port Loko</option><option value="Kabala">Kabala</option><option value="Yengema">Yengema</option><option value="Goderich">Goderich</option><option value="Magburaka">Magburaka</option><option value="Kailahun">Kailahun</option><option value="Rokupr">Rokupr</option><option value="Segbwema">Segbwema</option><option value="Koindu">Koindu</option><option value="Kambia">Kambia</option><option value="Bonthe">Bonthe</option><option value="Moyamba">Moyamba</option><option value="Motema">Motema</option><option value="Kamakwie">Kamakwie</option><option value="Mattru">Mattru</option><option value="Pendembu">Pendembu</option><option value="Blama">Blama</option><option value="Panguma">Panguma</option><option value="Lungi">Lungi</option><option value="Gandorhun">Gandorhun</option><option value="Barma">Barma</option><option value="Kukuna">Kukuna</option><option value="Boajibu">Boajibu</option><option value="Bunumbu">Bunumbu</option><option value="Rotifunk">Rotifunk</option><option value="Mambolo">Mambolo</option><option value="Masingbi">Masingbi</option><option value="Yamandu">Yamandu</option><option value="Hastings">Hastings</option><option value="Sumbuya">Sumbuya</option><option value="Pujehun">Pujehun</option><option value="Daru">Daru</option><option value="Baomae">Baomae</option><option value="Buedu">Buedu</option><option value="Kasiri">Kasiri</option><option value="Hangha">Hangha</option><option value="Largo">Largo</option><option value="Pepel">Pepel</option><option value="Peyima">Peyima</option><option value="Manowa">Manowa</option><option value="Simbakoro">Simbakoro</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Singapore"){ var str=state_selected; str=str+'<option value="Singapore">Singapore</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Slovakia"){ var str=state_selected; str=str+'<option value="Bratislava">Bratislava</option><option value="Kosice">Kosice</option><option value="Presov">Presov</option><option value="Nitra">Nitra</option><option value="Zilina">Zilina</option><option value="Banska Bystrica">Banska Bystrica</option><option value="Trnava">Trnava</option><option value="Martin">Martin</option><option value="Trencin">Trencin</option><option value="Poprad">Poprad</option><option value="Prievidza">Prievidza</option><option value="Zvolen">Zvolen</option><option value="Povazska Bystrica">Povazska Bystrica</option><option value="Nove Zamky">Nove Zamky</option><option value="Michalovce">Michalovce</option><option value="Spisska Nova Ves">Spisska Nova Ves</option><option value="Levice">Levice</option><option value="Komarno">Komarno</option><option value="Humenne">Humenne</option><option value="Bardejov">Bardejov</option><option value="Liptovsky Mikulas">Liptovsky Mikulas</option><option value="Ruzomberok">Ruzomberok</option><option value="Lucenec">Lucenec</option><option value="Cadca">Cadca</option><option value="Rimavska Sobota">Rimavska Sobota</option><option value="Partizanske">Partizanske</option><option value="Hlohovec">Hlohovec</option><option value="Dunajska Streda">Dunajska Streda</option><option value="Vranov">Vranov</option><option value="Brezno">Brezno</option><option value="Trebisov">Trebisov</option><option value="Snina">Snina</option><option value="Senica">Senica</option><option value="Kezmarok">Kezmarok</option><option value="Pezinok">Pezinok</option><option value="Banovce">Banovce</option><option value="Dolny Kubin">Dolny Kubin</option><option value="Roznava">Roznava</option><option value="Puchov">Puchov</option><option value="Handlova">Handlova</option><option value="Malacky">Malacky</option><option value="Kysucke Nove Mesto">Kysucke Nove Mesto</option><option value="Galanta">Galanta</option><option value="Zlate Moravce">Zlate Moravce</option><option value="Detva">Detva</option><option value="Skalica">Skalica</option><option value="Senec">Senec</option><option value="Revuca">Revuca</option><option value="Myjava">Myjava</option><option value="Svidnik">Svidnik</option><option value="Nova Dubnica">Nova Dubnica</option><option value="Sabinov">Sabinov</option><option value="Samorin">Samorin</option><option value="Sturovo, Slovakia">Sturovo, Slovakia</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Slovenia"){ var str=state_selected; str=str+'<option value="Ljubljana">Ljubljana</option><option value="Maribor">Maribor</option><option value="Celje">Celje</option><option value="Kranj">Kranj</option><option value="Velenje">Velenje</option><option value="Koper">Koper</option><option value="Novo Mesto">Novo Mesto</option><option value="Ptuj">Ptuj</option><option value="Trbovlje">Trbovlje</option><option value="Nova Gorica">Nova Gorica</option><option value="Kamnik">Kamnik</option><option value="Jesenice">Jesenice</option><option value="Murska Sobota">Murska Sobota</option><option value="Skofja Loka">Skofja Loka</option><option value="Domzale">Domzale</option><option value="Izola">Izola</option><option value="Kocevje">Kocevje</option><option value="Postojna">Postojna</option><option value="Logatec">Logatec</option><option value="Slovenj Gradec">Slovenj Gradec</option><option value="Ravne">Ravne</option><option value="Vrhnika">Vrhnika</option><option value="Krsko">Krsko</option><option value="Zagorje ob Savi">Zagorje ob Savi</option><option value="Slovenska Bistrica">Slovenska Bistrica</option><option value="Ajdovscina">Ajdovscina</option><option value="Litija">Litija</option><option value="Brezice">Brezice</option><option value="Grosuplje">Grosuplje</option><option value="Lucija">Lucija</option><option value="Radovljica">Radovljica</option><option value="Crnomelj">Crnomelj</option><option value="Hrastnik">Hrastnik</option><option value="Idrija">Idrija</option><option value="Menges">Menges</option><option value="Bled">Bled</option><option value="Medvode">Medvode</option><option value="Zalec">Zalec</option><option value="Ilirska Bistrica">Ilirska Bistrica</option><option value="Sevnica">Sevnica</option><option value="Slovenske Konjice">Slovenske Konjice</option><option value="Sezana">Sezana</option><option value="Rogaska Slatina">Rogaska Slatina</option><option value="Sentjur">Sentjur</option><option value="Ruse">Ruse</option><option value="Prevalje">Prevalje</option><option value="Piran">Piran</option><option value="Trzic">Trzic</option><option value="Sempeter, Slovenia">Sempeter, Slovenia</option><option value="Miklavz na Dravskem Polju">Miklavz na Dravskem Polju</option><option value="Tolmin">Tolmin</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Solomon Islands"){ var str=state_selected; str=str+'<option value="Honiara">Honiara</option><option value="Gizo">Gizo</option><option value="Auki">Auki</option><option value="Buala">Buala</option><option value="Tulagi">Tulagi</option><option value="Kirakira">Kirakira</option><option value="Lata">Lata</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Somalia"){ var str=state_selected; str=str+'<option value="Mogadishu">Mogadishu</option><option value="Hargeysa">Hargeysa</option><option value="Berbera">Berbera</option><option value="Kismayo">Kismayo</option><option value="Jamame">Jamame</option><option value="Bosaso">Bosaso</option><option value="Afgoye">Afgoye</option><option value="Garowe">Garowe</option><option value="Jawhar">Jawhar</option><option value="Jilib">Jilib</option><option value="Borama">Borama</option><option value="Barawe">Barawe</option><option value="Wanlaweyn">Wanlaweyn</option><option value="Eyl">Eyl</option><option value="Dinsor">Dinsor</option><option value="Qandala">Qandala</option><option value="Bandarbeyla">Bandarbeyla</option><option value="Xuddur">Xuddur</option><option value="Hobyo">Hobyo</option><option value="Afmadu">Afmadu</option><option value="Bereda">Bereda</option><option value="Mahadday Weyne">Mahadday Weyne</option><option value="Bargal">Bargal</option><option value="Wajid">Wajid</option><option value="Odweyne">Odweyne</option><option value="Bur Gabo">Bur Gabo</option><option value="Dujuma">Dujuma</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="South Africa"){ var str=state_selected; str=str+'<option value="Cape Town">Cape Town</option><option value="Durban">Durban</option><option value="Johannesburg">Johannesburg</option><option value="Soweto">Soweto</option><option value="Pretoria">Pretoria</option><option value="Port Elizabeth">Port Elizabeth</option><option value="Pietermaritzburg">Pietermaritzburg</option><option value="Benoni">Benoni</option><option value="Tembisa">Tembisa</option><option value="Vereeniging">Vereeniging</option><option value="Bloemfontein">Bloemfontein</option><option value="Boksburg">Boksburg</option><option value="Welkom">Welkom</option><option value="East London">East London</option><option value="Newcastle">Newcastle</option><option value="Krugersdorp">Krugersdorp</option><option value="Botshabelo">Botshabelo</option><option value="Brakpan">Brakpan</option><option value="Witbank">Witbank</option><option value="Richards Bay">Richards Bay</option><option value="Vanderbijlpark">Vanderbijlpark</option><option value="Verwoerdburg">Verwoerdburg</option><option value="Uitenhage">Uitenhage</option><option value="Paarl">Paarl</option><option value="Springs">Springs</option><option value="Somerset West">Somerset West</option><option value="Klerksdorp">Klerksdorp</option><option value="George">George</option><option value="Midrand">Midrand</option><option value="Westonaria">Westonaria</option><option value="Middelburg">Middelburg</option><option value="Vryheid">Vryheid</option><option value="Orkney">Orkney</option><option value="Kimberley">Kimberley</option><option value="Nigel">Nigel</option><option value="Bisho">Bisho</option><option value="Randfontein">Randfontein</option><option value="Worcester">Worcester</option><option value="Rustenburg">Rustenburg</option><option value="Pietersburg">Pietersburg</option><option value="Potchefstroom">Potchefstroom</option><option value="Brits">Brits</option><option value="Virginia">Virginia</option><option value="Nelspruit">Nelspruit</option><option value="Phalaborwa">Phalaborwa</option><option value="Queenstown">Queenstown</option><option value="Kroonstad">Kroonstad</option><option value="Bethal">Bethal</option><option value="Potgietersrus">Potgietersrus</option><option value="Mabopane">Mabopane</option><option value="Stellenbosch">Stellenbosch</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="South Georgia and The South Sandwich Islands"){ var str=state_selected; str=str+'<option value="Grytviken">Grytviken</option><option value="Stromness">Stromness</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Spain"){ var str=state_selected; str=str+'<option value="Madrid">Madrid</option><option value="Barcelona">Barcelona</option><option value="Valencia">Valencia</option><option value="Sevilla">Sevilla</option><option value="Zaragoza">Zaragoza</option><option value="Malaga">Malaga</option><option value="Murcia">Murcia</option><option value="Palma">Palma</option><option value="Las Palmas">Las Palmas</option><option value="Bilbao">Bilbao</option><option value="Alicante">Alicante</option><option value="Valladolid">Valladolid</option><option value="Cordoba">Cordoba</option><option value="Vigo">Vigo</option><option value="Gijon">Gijon</option><option value="Granada">Granada</option><option value="A Coruna">A Coruna</option><option value="Vitoria">Vitoria</option><option value="Badalona">Badalona</option><option value="Mostoles">Mostoles</option><option value="Fuenlabrada">Fuenlabrada</option><option value="Cartagena">Cartagena</option><option value="Sabadell">Sabadell</option><option value="Oviedo">Oviedo</option><option value="Alcala De Henares">Alcala De Henares</option><option value="Santa Cruz de Tenerife">Santa Cruz de Tenerife</option><option value="Leganes">Leganes</option><option value="Pamplona">Pamplona</option><option value="Jerez">Jerez</option><option value="Santander">Santander</option><option value="Almeria">Almeria</option><option value="Alcorcon">Alcorcon</option><option value="Burgos">Burgos</option><option value="Getafe">Getafe</option><option value="Salamanca">Salamanca</option><option value="Albacete">Albacete</option><option value="Huelva">Huelva</option><option value="Logrono">Logrono</option><option value="Cadiz">Cadiz</option><option value="Badajoz">Badajoz</option><option value="Tarragona">Tarragona</option><option value="Leon">Leon</option><option value="Jaen">Jaen</option><option value="Marbella">Marbella</option><option value="Mataro">Mataro</option><option value="Torrejon De Ardoz">Torrejon De Ardoz</option><option value="Algeciras">Algeciras</option><option value="Dos Hermanas">Dos Hermanas</option><option value="Alcobendas">Alcobendas</option><option value="Reus">Reus</option><option value="Telde">Telde</option><option value="Santiago de Compostela">Santiago de Compostela</option><option value="Caceres">Caceres</option><option value="San Fernando">San Fernando</option><option value="Parla">Parla</option><option value="Cornella">Cornella</option><option value="Lorca">Lorca</option><option value="Lugo">Lugo</option><option value="Coslada">Coslada</option><option value="Pozuelo De Alarcon">Pozuelo De Alarcon</option><option value="Talavera de la Reina">Talavera de la Reina</option><option value="Aviles">Aviles</option><option value="Guadalajara">Guadalajara</option><option value="El Puerto De Santa Maria">El Puerto De Santa Maria</option><option value="Ferrol">Ferrol</option><option value="Pontevedra">Pontevedra</option><option value="Palencia">Palencia</option><option value="Toledo">Toledo</option><option value="Ceuta">Ceuta</option><option value="Las Rozas de Madrid">Las Rozas de Madrid</option><option value="San Sebastian De Los Reyes">San Sebastian De Los Reyes</option><option value="Manresa">Manresa</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Sri Lanka"){ var str=state_selected; str=str+'<option value="Colombo">Colombo</option><option value="Moratuwa">Moratuwa</option><option value="Jaffna">Jaffna</option><option value="Negombo">Negombo</option><option value="Chavakachcheri">Chavakachcheri</option><option value="Kotte">Kotte</option><option value="Kandy">Kandy</option><option value="Trincomalee">Trincomalee</option><option value="Kalmunai">Kalmunai</option><option value="Galle">Galle</option><option value="Point Pedro">Point Pedro</option><option value="Batticaloa">Batticaloa</option><option value="Katunayaka">Katunayaka</option><option value="Valvedditturai">Valvedditturai</option><option value="Battaramulla">Battaramulla</option><option value="Dambulla">Dambulla</option><option value="Maharagama">Maharagama</option><option value="Kotikawatta">Kotikawatta</option><option value="Anuradhapura">Anuradhapura</option><option value="Vavuniya">Vavuniya</option><option value="Kolonnawa">Kolonnawa</option><option value="Hendala">Hendala</option><option value="Ratnapura">Ratnapura</option><option value="Matara">Matara</option><option value="Badulla">Badulla</option><option value="Kalutara">Kalutara</option><option value="Matale">Matale</option><option value="Homagama">Homagama</option><option value="Ragama">Ragama</option><option value="Beruwala">Beruwala</option><option value="Mulleriyawa">Mulleriyawa</option><option value="Kandana">Kandana</option><option value="Wattala">Wattala</option><option value="Peliyagoda">Peliyagoda</option><option value="Kelaniya">Kelaniya</option><option value="Kurunegala">Kurunegala</option><option value="Nuwara Eliya">Nuwara Eliya</option><option value="Gampola">Gampola</option><option value="Eravur">Eravur</option><option value="Weligama">Weligama</option><option value="Amparai">Amparai</option><option value="Kegalla">Kegalla</option><option value="Polonnaruwa">Polonnaruwa</option><option value="Hatton">Hatton</option><option value="Nawalapitiya">Nawalapitiya</option><option value="Kilinochchi">Kilinochchi</option><option value="Hambantota">Hambantota</option><option value="Monaragala">Monaragala</option><option value="Gampaha">Gampaha</option><option value="Horana">Horana</option><option value="Wattegama">Wattegama</option><option value="Mullaitivu">Mullaitivu</option><option value="Minuwangoda">Minuwangoda</option><option value="Bandarawela, Sri Lanka">Bandarawela, Sri Lanka</option><option value="Kuliyapitiya, Sri Lanka">Kuliyapitiya, Sri Lanka</option><option value="Haputale, Sri Lanka">Haputale, Sri Lanka</option><option value="Talawakele, Sri Lanka">Talawakele, Sri Lanka</option><option value="Kadugannawa, Sri Lanka">Kadugannawa, Sri Lanka</option><option value="Sigiriya, Sri Lanka">Sigiriya, Sri Lanka</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Sudan"){ var str=state_selected; str=str+'<option value="Umm Durman">Umm Durman</option><option value="Khartoum">Khartoum</option><option value="Kassala">Kassala</option><option value="Juba">Juba</option><option value="Kusti">Kusti</option><option value="Wad Madani">Wad Madani</option><option value="Malakal">Malakal</option><option value="Rabak">Rabak</option><option value="Sinnar">Sinnar</option><option value="Waw">Waw</option><option value="Kaduqli">Kaduqli</option><option value="Umm Ruwabah">Umm Ruwabah</option><option value="Sinjah">Sinjah</option><option value="Yambio">Yambio</option><option value="Yei">Yei</option><option value="Uwayl">Uwayl</option><option value="Gogrial">Gogrial</option><option value="Babanusah">Babanusah</option><option value="Sawakin">Sawakin</option><option value="Tandalti">Tandalti</option><option value="Kinanah">Kinanah</option><option value="Barbar">Barbar</option><option value="Tawkar">Tawkar</option><option value="Abu Jubayhah">Abu Jubayhah</option><option value="Torit">Torit</option><option value="Doka">Doka</option><option value="Tonj">Tonj</option><option value="Bara">Bara</option><option value="Abu Zabad">Abu Zabad</option><option value="Maridi">Maridi</option><option value="Talawdi">Talawdi</option><option value="Sinkat">Sinkat</option><option value="Marabba">Marabba</option><option value="Wagar">Wagar</option><option value="Yiroln">Yiroln</option><option value="Umm Kaddadah">Umm Kaddadah</option><option value="Tabat">Tabat</option><option value="Tambul">Tambul</option><option value="Ler">Ler</option><option value="Wad Rawah">Wad Rawah</option><option value="Marawi">Marawi</option><option value="Kutum">Kutum</option><option value="Tambura">Tambura</option><option value="Galgani">Galgani</option><option value="Umm Jarr">Umm Jarr</option><option value="Bentiu">Bentiu</option><option value="Kapoeta">Kapoeta</option><option value="Raga">Raga</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Suriname"){ var str=state_selected; str=str+'<option value="Paramaribo">Paramaribo</option><option value="Lelydorp">Lelydorp</option><option value="Nieuw Nickerie">Nieuw Nickerie</option><option value="Moengo">Moengo</option><option value="Meerzorg">Meerzorg</option><option value="Nieuw Amsterdam">Nieuw Amsterdam</option><option value="Marienburg">Marienburg</option><option value="Wageningen">Wageningen</option><option value="Albina">Albina</option><option value="Groningen">Groningen</option><option value="Brokopondo">Brokopondo</option><option value="Onverwacht">Onverwacht</option><option value="Totness">Totness</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Svalbard and Jan Mayen"){ var str=state_selected; str=str+'<option value="Longyearbyen">Longyearbyen</option><option value="Barentsburg">Barentsburg</option><option value="Ny-alesund">Ny-alesund</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Swaziland"){ var str=state_selected; str=str+'<option value="Manzini">Manzini</option><option value="Mbabane">Mbabane</option><option value="Big Bend">Big Bend</option><option value="Malkerns">Malkerns</option><option value="Nhlangano">Nhlangano</option><option value="Mhlume">Mhlume</option><option value="Hluti">Hluti</option><option value="Siteki">Siteki</option><option value="Lobamba">Lobamba</option><option value="Kwaluseni">Kwaluseni</option><option value="Bhunya">Bhunya</option><option value="Mhlambanyatsi">Mhlambanyatsi</option><option value="Hlatikulu">Hlatikulu</option><option value="Bulembu">Bulembu</option><option value="Kubuta">Kubuta</option><option value="Sidvokodvo">Sidvokodvo</option><option value="Lavumisa">Lavumisa</option><option value="Nsoko">Nsoko</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Sweden"){ var str=state_selected; str=str+'<option value="Stockholm">Stockholm</option><option value="Gothenburg">Gothenburg</option><option value="Malmo">Malmo</option><option value="Uppsala">Uppsala</option><option value="Vasteras">Vasteras</option><option value="Orebro">Orebro</option><option value="Linkoping">Linkoping</option><option value="Helsingborg">Helsingborg</option><option value="Jonkoping">Jonkoping</option><option value="Norrkoping">Norrkoping</option><option value="Lund">Lund</option><option value="Umea">Umea</option><option value="Gavle">Gavle</option><option value="Boras">Boras</option><option value="Sodertalje">Sodertalje</option><option value="Solna">Solna</option><option value="Eskilstuna">Eskilstuna</option><option value="Taby">Taby</option><option value="Karlstad">Karlstad</option><option value="Halmstad">Halmstad</option><option value="Vaxjo">Vaxjo</option><option value="Sundsvall">Sundsvall</option><option value="Lulea">Lulea</option><option value="Trollhattan">Trollhattan</option><option value="Ostersund">Ostersund</option><option value="Borlange">Borlange</option><option value="Upplands-vasby">Upplands-vasby</option><option value="Tumba">Tumba</option><option value="Falun">Falun</option><option value="Kalmar">Kalmar</option><option value="Skovde">Skovde</option><option value="Karlskrona">Karlskrona</option><option value="Kristianstad">Kristianstad</option><option value="Lidingo">Lidingo</option><option value="Skelleftea">Skelleftea</option><option value="Uddevalla">Uddevalla</option><option value="Motala">Motala</option><option value="Landskrona">Landskrona</option><option value="Ornskoldsvik">Ornskoldsvik</option><option value="Nykoping">Nykoping</option><option value="Karlskoga">Karlskoga</option><option value="Akersberga">Akersberga</option><option value="Vallentuna">Vallentuna</option><option value="Varberg">Varberg</option><option value="Trelleborg">Trelleborg</option><option value="Lidkoping">Lidkoping</option><option value="Marsta">Marsta</option><option value="Alingsas">Alingsas</option><option value="Angelholm">Angelholm</option><option value="Sandviken">Sandviken</option><option value="Pitea, Sweden">Pitea, Sweden</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Switzerland"){ var str=state_selected; str=str+'<option value="Zurich">Zurich</option><option value="Geneva">Geneva</option><option value="Basel">Basel</option><option value="Bern">Bern</option><option value="Lausanne">Lausanne</option><option value="Winterthur">Winterthur</option><option value="Luzern">Luzern</option><option value="Biel">Biel</option><option value="Thun">Thun</option><option value="La Chaux-de-Fonds">La Chaux-de-Fonds</option><option value="Koniz">Koniz</option><option value="Schaffhausen">Schaffhausen</option><option value="Fribourg">Fribourg</option><option value="Chur">Chur</option><option value="Neuchatel">Neuchatel</option><option value="Vernier">Vernier</option><option value="Uster">Uster</option><option value="Sion">Sion</option><option value="Emmen">Emmen</option><option value="Lugano">Lugano</option><option value="Kriens">Kriens</option><option value="Zug">Zug</option><option value="Yverdon">Yverdon</option><option value="Montreux">Montreux</option><option value="Dubendorf">Dubendorf</option><option value="Frauenfeld">Frauenfeld</option><option value="Dietikon">Dietikon</option><option value="Baar">Baar</option><option value="Meyrin">Meyrin</option><option value="Carouge">Carouge</option><option value="Wadenswil">Wadenswil</option><option value="Wetzikon">Wetzikon</option><option value="Allschwil">Allschwil</option><option value="Wettingen">Wettingen</option><option value="Kloten">Kloten</option><option value="Horgen">Horgen</option><option value="Jona">Jona</option><option value="Renens">Renens</option><option value="Gossau">Gossau</option><option value="Wil">Wil</option><option value="Kreuzlingen">Kreuzlingen</option><option value="Nyon">Nyon</option><option value="Bellinzona">Bellinzona</option><option value="Onex">Onex</option><option value="Baden">Baden</option><option value="Muttenz">Muttenz</option><option value="Pully">Pully</option><option value="Olten">Olten</option><option value="Littau">Littau</option><option value="Thalwil">Thalwil</option><option value="Adliswil">Adliswil</option><option value="Grenchen">Grenchen</option><option value="Vevey">Vevey</option><option value="Monthey">Monthey</option><option value="Regensdorf">Regensdorf</option><option value="Herisau">Herisau</option><option value="Steffisburg">Steffisburg</option><option value="Solothurn">Solothurn</option><option value="Binningen">Binningen</option><option value="Aarau">Aarau</option><option value="Burgdorf">Burgdorf</option><option value="Freienbach">Freienbach</option><option value="Pratteln">Pratteln</option><option value="Bulach">Bulach</option><option value="Sierre">Sierre</option><option value="Volketswil">Volketswil</option><option value="Langenthal">Langenthal</option><option value="Schwyz">Schwyz</option><option value="Martigny">Martigny</option><option value="Wohlen">Wohlen</option><option value="Locarno">Locarno</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Syrian Arab Republic"){ var str=state_selected; str=str+'<option value="Aleppo">Aleppo</option><option value="Damascus">Damascus</option><option value="Jaramana">Jaramana</option><option value="Duma">Duma</option><option value="Idlib">Idlib</option><option value="Tartus">Tartus</option><option value="Manbij">Manbij</option><option value="Salamiyah">Salamiyah</option><option value="Abu Kamal">Abu Kamal</option><option value="Jablah">Jablah</option><option value="Darayya">Darayya</option><option value="Nawa">Nawa</option><option value="Baniyas">Baniyas</option><option value="Masyaf">Masyaf</option><option value="Qatana">Qatana</option><option value="Yabrud">Yabrud</option><option value="Safita">Safita</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Taiwan, Province Of China"){ var str=state_selected; str=str+'<option value="Taipei">Taipei</option><option value="Kaohsiung">Kaohsiung</option><option value="Taichung">Taichung</option><option value="Tainan">Tainan</option><option value="Panchiao">Panchiao</option><option value="Hsinchu">Hsinchu</option><option value="Keelung">Keelung</option><option value="Chungho">Chungho</option><option value="Taoyuan">Taoyuan</option><option value="Sanchung">Sanchung</option><option value="Fengshan">Fengshan</option><option value="Tucheng">Tucheng</option><option value="Hsintien">Hsintien</option><option value="Yungkang">Yungkang</option><option value="Pingchen">Pingchen</option><option value="Hsichih">Hsichih</option><option value="Pingtung">Pingtung</option><option value="Yungho">Yungho</option><option value="Luchou">Luchou</option><option value="Tali">Tali</option><option value="Shulin">Shulin</option><option value="Pate">Pate</option><option value="Yangmei">Yangmei</option><option value="Tanshui">Tanshui</option><option value="Yuanlin">Yuanlin</option><option value="Taitung">Taitung</option><option value="Nantou">Nantou</option><option value="Chupei">Chupei</option><option value="Touliu">Touliu</option><option value="Sanhsia">Sanhsia</option><option value="Tsaotun">Tsaotun</option><option value="Kangshan">Kangshan</option><option value="Ilan">Ilan</option><option value="Chutung">Chutung</option><option value="Toufen">Toufen</option><option value="Miaoli">Miaoli</option><option value="Homei">Homei</option><option value="Puli">Puli</option><option value="Yingko">Yingko</option><option value="Tachi">Tachi</option><option value="Lukang">Lukang</option><option value="Chingshui">Chingshui</option><option value="Tachia">Tachia</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Tajikistan"){ var str=state_selected; str=str+'<option value="Dushanbe">Dushanbe</option><option value="Khujand">Khujand</option><option value="Kulob">Kulob</option><option value="Uroteppa">Uroteppa</option><option value="Konibodom">Konibodom</option><option value="Kofarnihon">Kofarnihon</option><option value="Tursunzoda">Tursunzoda</option><option value="Isfara">Isfara</option><option value="Panjakent">Panjakent</option><option value="Hisor">Hisor</option><option value="Boshkengash">Boshkengash</option><option value="Dangara">Dangara</option><option value="Farkhor">Farkhor</option><option value="Chkalovsk">Chkalovsk</option><option value="Moskovskiy">Moskovskiy</option><option value="Tugalan">Tugalan</option><option value="Yovon">Yovon</option><option value="Proletarsk">Proletarsk</option><option value="Vakhsh">Vakhsh</option><option value="Matcha">Matcha</option><option value="Gafurov">Gafurov</option><option value="Nau">Nau</option><option value="Adrasmon">Adrasmon</option><option value="Buston">Buston</option><option value="Shaartuz">Shaartuz</option><option value="Leningradskiy">Leningradskiy</option><option value="Asht">Asht</option><option value="Taboshar">Taboshar</option><option value="Garm">Garm</option><option value="Obigarm">Obigarm</option><option value="Dusti">Dusti</option><option value="Sovetskiy">Sovetskiy</option><option value="Garavuti">Garavuti</option><option value="Pakhtakoron">Pakhtakoron</option><option value="Rogun">Rogun</option><option value="Kirovskiy">Kirovskiy</option><option value="Orzu">Orzu</option><option value="Jilikul">Jilikul</option><option value="Shakhrinau">Shakhrinau</option><option value="Navabad">Navabad</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Tanzania, United Republic Of"){ var str=state_selected; str=str+'<option value="Dar es Salaam">Dar es Salaam</option><option value="Mwanza">Mwanza</option><option value="Zanzibar">Zanzibar</option><option value="Arusha">Arusha</option><option value="Mbeya">Mbeya</option><option value="Morogoro">Morogoro</option><option value="Tanga">Tanga</option><option value="Dodoma">Dodoma</option><option value="Kigoma">Kigoma</option><option value="Moshi">Moshi</option><option value="Tabora">Tabora</option><option value="Songea">Songea</option><option value="Musoma">Musoma</option><option value="Iringa">Iringa</option><option value="Katumba">Katumba</option><option value="Shinyanga">Shinyanga</option><option value="Mtwara">Mtwara</option><option value="Ushirombo">Ushirombo</option><option value="Kilosa">Kilosa</option><option value="Sumbawanga">Sumbawanga</option><option value="Bagamoyo">Bagamoyo</option><option value="Mpanda">Mpanda</option><option value="Bukoba">Bukoba</option><option value="Singida">Singida</option><option value="Uyovu">Uyovu</option><option value="Makambako">Makambako</option><option value="Buseresere">Buseresere</option><option value="Bunda">Bunda</option><option value="Ifakara">Ifakara</option><option value="Njombe">Njombe</option><option value="Lindi">Lindi</option><option value="Vwawa">Vwawa</option><option value="Nguruka">Nguruka</option><option value="Newala">Newala</option><option value="Gairo">Gairo</option><option value="Kasulu">Kasulu</option><option value="Tunduru">Tunduru</option><option value="Tunduma">Tunduma</option><option value="Masasi">Masasi</option><option value="Kahama">Kahama</option><option value="Kidodi">Kidodi</option><option value="Igunga">Igunga</option><option value="Missungwi">Missungwi</option><option value="Mlimba">Mlimba</option><option value="Mafinga">Mafinga</option><option value="Masumbwe">Masumbwe</option><option value="Chalinze">Chalinze</option><option value="Babati">Babati</option><option value="Biharamulo">Biharamulo</option><option value="Somanda">Somanda</option><option value="Korogwe">Korogwe</option><option value="Bariadi">Bariadi</option><option value="Kirando">Kirando</option><option value="Tarime">Tarime</option><option value="Tumbi">Tumbi</option><option value="Bugarama">Bugarama</option><option value="Mvomero">Mvomero</option><option value="Chanika">Chanika</option><option value="Kyela">Kyela</option><option value="Kibiti">Kibiti</option><option value="Kisesa">Kisesa</option><option value="Lukuledi">Lukuledi</option><option value="Mlandizi">Mlandizi</option><option value="Rujewa">Rujewa</option><option value="Ilula">Ilula</option><option value="Kibondo">Kibondo</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Thailand"){ var str=state_selected; str=str+'<option value="Bangkok">Bangkok</option><option value="Samut Prakan">Samut Prakan</option><option value="Nonthaburi">Nonthaburi</option><option value="Udon Thani">Udon Thani</option><option value="Chon Buri">Chon Buri</option><option value="Nakhon Ratchasima">Nakhon Ratchasima</option><option value="Hat Yai">Hat Yai</option><option value="Pak Kret">Pak Kret</option><option value="Si Racha">Si Racha</option><option value="Phra Pradaeng">Phra Pradaeng</option><option value="Lampang">Lampang</option><option value="Chiang Mai">Chiang Mai</option><option value="Khon Kaen">Khon Kaen</option><option value="Surat Thani">Surat Thani</option><option value="Thanyaburi">Thanyaburi</option><option value="Ubon Ratchathani">Ubon Ratchathani</option><option value="Nakhon Si Thammarat">Nakhon Si Thammarat</option><option value="Rayong">Rayong</option><option value="Khlong Luang">Khlong Luang</option><option value="Nakhon Pathom">Nakhon Pathom</option><option value="Phitsanulok">Phitsanulok</option><option value="Chanthaburi">Chanthaburi</option><option value="Nakhon Sawan">Nakhon Sawan</option><option value="Pattaya">Pattaya</option><option value="Yala">Yala</option><option value="Ratchaburi">Ratchaburi</option><option value="Phuket">Phuket</option><option value="Songkhla">Songkhla</option><option value="Ayutthaya">Ayutthaya</option><option value="Chiang Rai">Chiang Rai</option><option value="Bang Kruai">Bang Kruai</option><option value="Sakhon Nakhon">Sakhon Nakhon</option><option value="Krathum Baen">Krathum Baen</option><option value="Trang">Trang</option><option value="Sattahip">Sattahip</option><option value="Kanchanaburi">Kanchanaburi</option><option value="Nong Khai">Nong Khai</option><option value="Samut Sakhon">Samut Sakhon</option><option value="Lam Luk Ka">Lam Luk Ka</option><option value="Kamphaeng Phet">Kamphaeng Phet</option><option value="Chaiyaphum">Chaiyaphum</option><option value="Uttaradit">Uttaradit</option><option value="Lop Buri">Lop Buri</option><option value="Ban Pong">Ban Pong</option><option value="Phra Phutthabat">Phra Phutthabat</option><option value="Chumphon">Chumphon</option><option value="Klaeng">Klaeng</option><option value="Kalasin">Kalasin</option><option value="Suphan Buri">Suphan Buri</option><option value="Tha Maka">Tha Maka</option><option value="Maha Sarakham">Maha Sarakham</option><option value="Phetchabun">Phetchabun</option><option value="Hua Hin">Hua Hin</option><option value="Chachoengsao">Chachoengsao</option><option value="Pattani">Pattani</option><option value="Pak Chong">Pak Chong</option><option value="Narathiwat">Narathiwat</option><option value="Pran Buri">Pran Buri</option><option value="Surin">Surin</option><option value="Phetchaburi">Phetchaburi</option><option value="Chum Phae">Chum Phae</option><option value="Sadao">Sadao</option><option value="Mae Sot">Mae Sot</option><option value="Phatthalung">Phatthalung</option><option value="Warin Chamrap">Warin Chamrap</option><option value="Sungai Kolok">Sungai Kolok</option><option value="Tha Yang">Tha Yang</option><option value="Ban Phaeo">Ban Phaeo</option><option value="Lamphun">Lamphun</option><option value="Nong Khae">Nong Khae</option><option value="Mukdahan">Mukdahan</option><option value="Sukhothai">Sukhothai</option><option value="Ko Samui">Ko Samui</option><option value="Bang Lamung">Bang Lamung</option><option value="Roi Et">Roi Et</option><option value="Wichian Buri">Wichian Buri</option><option value="Phrae">Phrae</option><option value="Mae Chan">Mae Chan</option><option value="Sansai">Sansai</option><option value="Sam Phran">Sam Phran</option><option value="Photharam">Photharam</option><option value="Phichit">Phichit</option><option value="Det Udom">Det Udom</option><option value="Ban Phai">Ban Phai</option><option value="Tha Bo">Tha Bo</option><option value="Loei">Loei</option><option value="Samut Songkhram">Samut Songkhram</option><option value="Kathu">Kathu</option><option value="Amnat Charoen">Amnat Charoen</option><option value="Nakhon Phanom">Nakhon Phanom</option><option value="Satun">Satun</option><option value="Prachuap Khiri Khan">Prachuap Khiri Khan</option><option value="Prachin Buri">Prachin Buri</option><option value="Krabi">Krabi</option><option value="Yaring">Yaring</option><option value="Na Klang">Na Klang</option><option value="Kaeng Khoi">Kaeng Khoi</option><option value="Betong">Betong</option><option value="Bang Phae">Bang Phae</option><option value="Kumphawapi">Kumphawapi</option><option value="Kaeng Khlo">Kaeng Khlo</option><option value="Sa Kaeo">Sa Kaeo</option><option value="Bang Bo">Bang Bo</option><option value="Thung Song">Thung Song</option><option value="Ban Chang">Ban Chang</option><option value="Pathum Thani">Pathum Thani</option><option value="Nong Phai">Nong Phai</option><option value="Mae Sai">Mae Sai</option><option value="Ron Phibun">Ron Phibun</option><option value="Nong Han">Nong Han</option><option value="Ban Bung">Ban Bung</option><option value="Si Satchanalai">Si Satchanalai</option><option value="Phun Phin">Phun Phin</option><option value="Bang Pakong">Bang Pakong</option><option value="Chai Badan">Chai Badan</option><option value="Pak Phanang">Pak Phanang</option><option value="Nan">Nan</option><option value="Ranong">Ranong</option><option value="Tak">Tak</option><option value="Dok Kham Tai">Dok Kham Tai</option><option value="Pak Thong Chai">Pak Thong Chai</option><option value="Kamalasai">Kamalasai</option><option value="Chok Chai">Chok Chai</option><option value="Damnoen Saduak">Damnoen Saduak</option><option value="Tha Mai">Tha Mai</option><option value="Uthai Thani">Uthai Thani</option><option value="Nang Rong">Nang Rong</option><option value="Phanat Nikhom">Phanat Nikhom</option><option value="Taphan Hin">Taphan Hin</option><option value="Khanu Woralaksaburi">Khanu Woralaksaburi</option><option value="Yasothon">Yasothon</option><option value="Trat">Trat</option><option value="Nakhon Nayok">Nakhon Nayok</option><option value="Phayao">Phayao</option><option value="Kuchinarai">Kuchinarai</option><option value="Kabin Buri">Kabin Buri</option><option value="Sing Buri">Sing Buri</option><option value="Phibun Mangsahan">Phibun Mangsahan</option><option value="Song Phi Nong">Song Phi Nong</option><option value="Sawankhalok">Sawankhalok</option><option value="Ranot">Ranot</option><option value="Ban Dung">Ban Dung</option><option value="Phak Hai">Phak Hai</option><option value="Wiset Chai Chan">Wiset Chai Chan</option><option value="Tha Rua">Tha Rua</option><option value="Kui Buri">Kui Buri</option><option value="Bang Krathum">Bang Krathum</option><option value="Phan Thong">Phan Thong</option><option value="Khon Buri">Khon Buri</option><option value="Khao Yoi">Khao Yoi</option><option value="Thoen">Thoen</option><option value="Non Sung">Non Sung</option><option value="Ban Tak">Ban Tak</option><option value="Bang Len">Bang Len</option><option value="Chon Daen">Chon Daen</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Timor-Leste"){ var str=state_selected; str=str+'<option value="Dare">Dare</option><option value="Dili">Dili</option><option value="Metinaro">Metinaro</option><option value="Aileu">Aileu</option><option value="Ainaro">Ainaro</option><option value="Hato-Udo">Hato-Udo</option><option value="Maubara">Maubara</option><option value="Baucau">Baucau</option><option value="Bucoli">Bucoli</option><option value="Quelicai">Quelicai</option><option value="Laga">Laga</option><option value="Venilale">Venilale</option><option value="Balibo">Balibo</option><option value="Bobonaro">Bobonaro</option><option value="Lolotoe">Lolotoe</option><option value="Maliana">Maliana</option><option value="Fuiloro">Fuiloro</option><option value="Iliomar">Iliomar</option><option value="Laivai">Laivai</option><option value="Lautém">Lautém</option><option value="Lore">Lore</option><option value="Lospalos">Lospalos</option><option value="Luro">Luro</option><option value="Mehara">Mehara</option><option value="Tutuala">Tutuala</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Togo"){ var str=state_selected; str=str+'<option value="Kpalime">Kpalime</option><option value="Sokode">Sokode</option><option value="Kara">Kara</option><option value="Atakpame">Atakpame</option><option value="Bassar">Bassar</option><option value="Tsevie">Tsevie</option><option value="Aneho">Aneho</option><option value="Mango">Mango</option><option value="Dapaong">Dapaong</option><option value="Notse">Notse</option><option value="Tchamba">Tchamba</option><option value="Badou">Badou</option><option value="Niamtougou">Niamtougou</option><option value="Bafilo">Bafilo</option><option value="Vogan">Vogan</option><option value="Sotouboua">Sotouboua</option><option value="Tabligbo">Tabligbo</option><option value="Amlame">Amlame</option><option value="Kande">Kande</option><option value="Kpagouda">Kpagouda</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Tokelau"){ var str=state_selected; str=str+'<option value=""Atafu Village"">"Atafu Village"</option><option value=""Nukunonu"">"Nukunonu"</option><option value=""Fenua Fala"">"Fenua Fala"</option><option value="Fale">Fale</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Tonga"){ var str=state_selected; str=str+'<option value="Neiafu">Neiafu</option><option value="Vaini">Vaini</option><option value="Pangai">Pangai</option><option value="Hihifo">Hihifo</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Trinidad and Tobago"){ var str=state_selected; str=str+'<option value="San Fernando">San Fernando</option><option value="Arima">Arima</option><option value="Marabella">Marabella</option><option value="Point Fortin">Point Fortin</option><option value="Tunapuna">Tunapuna</option><option value="Sangre Grande">Sangre Grande</option><option value="Tacarigua">Tacarigua</option><option value="Arouca">Arouca</option><option value="Princes Town">Princes Town</option><option value="Siparia">Siparia</option><option value="Couva">Couva</option><option value="Penal">Penal</option><option value="Scarborough">Scarborough</option><option value="Mucurapo">Mucurapo</option><option value="Tabaquite">Tabaquite</option><option value="Debe">Debe</option><option value="Rio Claro">Rio Claro</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Tunisia"){ var str=state_selected; str=str+'<option value="Tunis">Tunis</option><option value="Safaqis">Safaqis</option><option value="Aryanah">Aryanah</option><option value="Susah">Susah</option><option value="Qabis">Qabis</option><option value="Qafsah">Qafsah</option><option value="Jarjis">Jarjis</option><option value="Bardaw">Bardaw</option><option value="Masakin">Masakin</option><option value="Tatawin">Tatawin</option><option value="Nabul">Nabul</option><option value="Bajah">Bajah</option><option value="Jundubah">Jundubah</option><option value="Manzil Bu Ruqaybah">Manzil Bu Ruqaybah</option><option value="Radis">Radis</option><option value="Sidi Bu Zayd">Sidi Bu Zayd</option><option value="Jammal">Jammal</option><option value="Qasr Hallal">Qasr Hallal</option><option value="Tawzar">Tawzar</option><option value="Manzil Tamim">Manzil Tamim</option><option value="Qurbah">Qurbah</option><option value="Tabulbah">Tabulbah</option><option value="Maqrin">Maqrin</option><option value="Matir">Matir</option><option value="Duz">Duz</option><option value="Silyanah">Silyanah</option><option value="Taburbah">Taburbah</option><option value="Sulayman">Sulayman</option><option value="Manubah">Manubah</option><option value="Naftah">Naftah</option><option value="Manzil Jamil">Manzil Jamil</option><option value="Subaytilah">Subaytilah</option><option value="Taklisah">Taklisah</option><option value="Bu Salim">Bu Salim</option><option value="Akkudah">Akkudah</option><option value="Qibili">Qibili</option><option value="Qurunbaliyah">Qurunbaliyah</option><option value="Tinjah">Tinjah</option><option value="Manzil Bu Zalafah">Manzil Bu Zalafah</option><option value="Talah">Talah</option><option value="Tabarqah">Tabarqah</option><option value="Tastur">Tastur</option><option value="Bin Qirdan">Bin Qirdan</option><option value="Tabursuq">Tabursuq</option><option value="Rafraf">Rafraf</option><option value="Zawiyat Susah">Zawiyat Susah</option><option value="Manzil Kamil">Manzil Kamil</option><option value="Jabinyanah">Jabinyanah</option><option value="Tazirkah">Tazirkah</option><option value="Harqalah">Harqalah</option><option value="Sabibah">Sabibah</option><option value="Jamnah">Jamnah</option><option value="Tuzah">Tuzah</option><option value="Jilmah">Jilmah</option><option value="Lamtah">Lamtah</option><option value="Sajanan">Sajanan</option><option value="Sidi Bin Nur">Sidi Bin Nur</option><option value="Qurbus">Qurbus</option><option value="Nibbar">Nibbar</option><option value="Quballat">Quballat</option><option value="Manzil Salim">Manzil Salim</option><option value="Kasra">Kasra</option><option value="Wadi Maliz">Wadi Maliz</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Turkey"){ var str=state_selected; str=str+'<option value="Istanbul">Istanbul</option><option value="Ankara">Ankara</option><option value="Izmir">Izmir</option><option value="Bursa">Bursa</option><option value="Adana">Adana</option><option value="Gaziantep">Gaziantep</option><option value="Konya">Konya</option><option value="Antalya">Antalya</option><option value="Mersin">Mersin</option><option value="Kayseri">Kayseri</option><option value="Eskisehir">Eskisehir</option><option value="Urfa">Urfa</option><option value="Malatya">Malatya</option><option value="Erzurum">Erzurum</option><option value="Samsun">Samsun</option><option value="Kahramanmaras">Kahramanmaras</option><option value="Van">Van</option><option value="Denizli">Denizli</option><option value="Batman">Batman</option><option value="Gebze">Gebze</option><option value="Sivas">Sivas</option><option value="Tarsus">Tarsus</option><option value="Trabzon">Trabzon</option><option value="Manisa">Manisa</option><option value="Esenyurt">Esenyurt</option><option value="Osmaniye">Osmaniye</option><option value="Corlu">Corlu</option><option value="Izmit">Izmit</option><option value="Kutahya">Kutahya</option><option value="Corum">Corum</option><option value="Siverek">Siverek</option><option value="Isparta">Isparta</option><option value="Iskenderun">Iskenderun</option><option value="Antakya">Antakya</option><option value="Viransehir">Viransehir</option><option value="Usak">Usak</option><option value="Aksaray">Aksaray</option><option value="Afyonkarahisar">Afyonkarahisar</option><option value="Inegol">Inegol</option><option value="Tokat">Tokat</option><option value="Edirne">Edirne</option><option value="Tekirdag">Tekirdag</option><option value="Karaman">Karaman</option><option value="Nazilli">Nazilli</option><option value="Ordu">Ordu</option><option value="Siirt">Siirt</option><option value="Erzincan">Erzincan</option><option value="Alanya">Alanya</option><option value="Turhal">Turhal</option><option value="Turgutlu">Turgutlu</option><option value="Zonguldak">Zonguldak</option><option value="Giresun">Giresun</option><option value="Karabuk">Karabuk</option><option value="Bolu">Bolu</option><option value="Ceyhan">Ceyhan</option><option value="Manavgat">Manavgat</option><option value="Bafra">Bafra</option><option value="Rize">Rize</option><option value="Eregli">Eregli</option><option value="Karakose">Karakose</option><option value="Ercis">Ercis</option><option value="Nigde">Nigde</option><option value="Luleburgaz">Luleburgaz</option><option value="Korfez">Korfez</option><option value="Nusaybin">Nusaybin</option><option value="Salihli">Salihli</option><option value="Kozan">Kozan</option><option value="Yozgat">Yozgat</option><option value="Canakkale">Canakkale</option><option value="Patnos">Patnos</option><option value="Akhisar">Akhisar</option><option value="Amasya">Amasya</option><option value="Mus">Mus</option><option value="Nizip">Nizip</option><option value="Kilis">Kilis</option><option value="Fatsa">Fatsa</option><option value="Cizre">Cizre</option><option value="Bingol">Bingol</option><option value="Elbistan">Elbistan</option><option value="Hakkari">Hakkari</option><option value="Unye">Unye</option><option value="Kars">Kars</option><option value="Midyat">Midyat</option><option value="Nevsehir">Nevsehir</option><option value="Silifke">Silifke</option><option value="Silopi">Silopi</option><option value="Bismil">Bismil</option><option value="Tatvan">Tatvan</option><option value="Kahta">Kahta</option><option value="Igdir">Igdir</option><option value="Sirnak">Sirnak</option><option value="Yuksekova">Yuksekova</option><option value="Mardin">Mardin</option><option value="Yalova">Yalova</option><option value="Gemlik">Gemlik</option><option value="Kastamonu">Kastamonu</option><option value="Kadirli">Kadirli</option><option value="Soke">Soke</option><option value="Ardesen">Ardesen</option><option value="Odemis">Odemis</option><option value="Cerkezkoy">Cerkezkoy</option><option value="Burdur">Burdur</option><option value="Silvan">Silvan</option><option value="Soma">Soma</option><option value="Ahlat">Ahlat</option><option value="Aksehir">Aksehir</option><option value="Sorgun">Sorgun</option><option value="Cubuk">Cubuk</option><option value="Fethiye">Fethiye</option><option value="Duzce">Duzce</option><option value="Bergama">Bergama</option><option value="Anamur">Anamur</option><option value="Dortyol">Dortyol</option><option value="Golcuk">Golcuk</option><option value="Zile">Zile</option><option value="Bozuyuk">Bozuyuk</option><option value="Mustafakemalpasa">Mustafakemalpasa</option><option value="Menemen">Menemen</option><option value="Silivri">Silivri</option><option value="Adilcevaz">Adilcevaz</option><option value="Ergani">Ergani</option><option value="Erbaa">Erbaa</option><option value="Orhangazi">Orhangazi</option><option value="Seydisehir">Seydisehir</option><option value="Merzifon">Merzifon</option><option value="Kavakli">Kavakli</option><option value="Carsamba">Carsamba</option><option value="Niksar">Niksar</option><option value="Keskin">Keskin</option><option value="Mut">Mut</option><option value="Bitlis">Bitlis</option><option value="Mugla">Mugla</option><option value="Suluova">Suluova</option><option value="Sebinkarahisar">Sebinkarahisar</option><option value="Tire">Tire</option><option value="Kulu">Kulu</option><option value="Suruc">Suruc</option><option value="Erdemli">Erdemli</option><option value="Cumra">Cumra</option><option value="Urla">Urla</option><option value="Akcaabat">Akcaabat</option><option value="Aliaga">Aliaga</option><option value="Kesan">Kesan</option><option value="Beysehir">Beysehir</option><option value="Birecik">Birecik</option><option value="Karacabey">Karacabey</option><option value="Sereflikochisar">Sereflikochisar</option><option value="Milas">Milas</option><option value="Edremit">Edremit</option><option value="Gonen">Gonen</option><option value="Islahiye">Islahiye</option><option value="Alasehir">Alasehir</option><option value="Bilecik">Bilecik</option><option value="Afsin">Afsin</option><option value="Uzumlu">Uzumlu</option><option value="Bodrum">Bodrum</option><option value="Yalvac">Yalvac</option><option value="Samandag">Samandag</option><option value="Burhaniye">Burhaniye</option><option value="Sungurlu">Sungurlu</option><option value="Besikduzu">Besikduzu</option><option value="Serik">Serik</option><option value="Talas">Talas</option><option value="Bulancak">Bulancak</option><option value="Uzunkopru">Uzunkopru</option><option value="Kestel">Kestel</option><option value="Develi">Develi</option><option value="Dinar">Dinar</option><option value="Yerkoy">Yerkoy</option><option value="Hendek">Hendek</option><option value="Safranbolu">Safranbolu</option><option value="Akcakoca">Akcakoca</option><option value="Simav">Simav</option><option value="Sinop">Sinop</option><option value="Goksun">Goksun</option><option value="Cay">Cay</option><option value="Marmaris">Marmaris</option><option value="Kemer">Kemer</option><option value="Sarkikaraagac">Sarkikaraagac</option><option value="Bor">Bor</option><option value="Gumushane">Gumushane</option><option value="Kurtalan">Kurtalan</option><option value="Of">Of</option><option value="Imamoglu">Imamoglu</option><option value="Bayburt">Bayburt</option><option value="Ortakoy">Ortakoy</option><option value="Kula">Kula</option><option value="Mimarsinan">Mimarsinan</option><option value="Biga">Biga</option><option value="Karamursel">Karamursel</option><option value="Kemalpasa">Kemalpasa</option><option value="Gorele">Gorele</option><option value="Kumluca">Kumluca</option><option value="Kozluk">Kozluk</option><option value="Bucak">Bucak</option><option value="Selcuk">Selcuk</option><option value="Tunceli">Tunceli</option><option value="Yakuplu">Yakuplu</option><option value="Yenisehir">Yenisehir</option><option value="Kaman">Kaman</option><option value="Gerede">Gerede</option><option value="Terme">Terme</option><option value="Kirac">Kirac</option><option value="Boyabat">Boyabat</option><option value="Malkara">Malkara</option><option value="Golkoy">Golkoy</option><option value="Eskil">Eskil</option><option value="Alaca">Alaca</option><option value="Babaeski">Babaeski</option><option value="Can">Can</option><option value="Malazgirt">Malazgirt</option><option value="Susehri">Susehri</option><option value="Mudurnu">Mudurnu</option><option value="Elmadag">Elmadag</option><option value="Gelibolu">Gelibolu</option><option value="Vezirkopru">Vezirkopru</option><option value="Susurluk">Susurluk</option><option value="Cayeli">Cayeli</option><option value="Devrek">Devrek</option><option value="Pasinler">Pasinler</option><option value="Gursu">Gursu</option><option value="Artvin">Artvin</option><option value="Tosya">Tosya</option><option value="Derik">Derik</option><option value="Emet">Emet</option><option value="Oltu">Oltu</option><option value="Mudanya">Mudanya</option><option value="Akdagmadeni">Akdagmadeni</option><option value="Idil">Idil</option><option value="Genc">Genc</option><option value="Iznik">Iznik</option><option value="Gediz">Gediz</option><option value="Tepecik">Tepecik</option><option value="Bozova">Bozova</option><option value="Demirci">Demirci</option><option value="Cine">Cine</option><option value="Cesme">Cesme</option><option value="Ardahan">Ardahan</option><option value="Cermik">Cermik</option><option value="Belen">Belen</option><option value="Emirdag">Emirdag</option><option value="Iskilip">Iskilip</option><option value="Hayrabolu">Hayrabolu</option><option value="Bahce">Bahce</option><option value="Catalca">Catalca</option><option value="Gurgentepe">Gurgentepe</option><option value="Horasan">Horasan</option><option value="Solhan">Solhan</option><option value="Suhut">Suhut</option><option value="Kumburgaz">Kumburgaz</option><option value="Hadimkoy">Hadimkoy</option><option value="Sile">Sile</option><option value="Selimpasa">Selimpasa</option><option value="Celaliye">Celaliye</option><option value="Gumusyaka">Gumusyaka</option><option value="Degirmen">Degirmen</option><option value="Canta">Canta</option><option value="Buyukcavuslu">Buyukcavuslu</option><option value="Agva">Agva</option><option value="Karacakoy">Karacakoy</option><option value="Durusu">Durusu</option><option value="Muratbey">Muratbey</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Turkmenistan"){ var str=state_selected; str=str+'<option value="Asgabat">Asgabat</option><option value="Turkmenabat">Turkmenabat</option><option value="Dasoguz">Dasoguz</option><option value="Balkanabat">Balkanabat</option><option value="Buzmeyin">Buzmeyin</option><option value="Kerki">Kerki</option><option value="Annau">Annau</option><option value="Gumdag">Gumdag</option><option value="Baherden">Baherden</option><option value="Boldumsaz">Boldumsaz</option><option value="Gazanjyk">Gazanjyk</option><option value="Gazojak">Gazojak</option><option value="Kaka">Kaka</option><option value="Sayat">Sayat</option><option value="Seydi">Seydi</option><option value="Farap">Farap</option><option value="Akdepe">Akdepe</option><option value="Murgab">Murgab</option>'; str=str+state_selected2; html_input(str);}	

		else if(objValue==="Turks and Caicos Islands"){ var str=state_selected; str=str+'<option value="Blue">Blue</option><option value="Bottle”>Bottle </option><option value="Cockburn">Cockburn</option><option value="Cockburn”>Cockburn </option><option value="Grace Bay Garden Loop">Grace Bay Garden Loop</option><option value="Balfour Town">Balfour Town</option><option value="Whitby">Whitby</option><option value="Kew">Kew</option><option value="Sandy Point">Sandy Point</option><option value="Lorimers">Lorimers</option><option value="Bambarra">Bambarra</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Tuvalu"){ var str=state_selected; str=str+'<option value="Asau">Asau</option><option value="Lolua">Lolua</option><option value="Tanrake">Tanrake</option><option value="Tonga">Tonga</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Uganda"){ var str=state_selected; str=str+'<option value="Kampala">Kampala</option><option value="Gulu">Gulu</option><option value="Lira">Lira</option><option value="Jinja">Jinja</option><option value="Mbarara">Mbarara</option><option value="Mbale">Mbale</option><option value="Mukono">Mukono</option><option value="Kasese">Kasese</option><option value="Masaka">Masaka</option><option value="Entebbe">Entebbe</option><option value="Njeru">Njeru</option><option value="Kitgum">Kitgum</option><option value="Arua">Arua</option><option value="Kabale">Kabale</option><option value="Tororo">Tororo</option><option value="Iganga">Iganga</option><option value="Soroti">Soroti</option><option value="Fort Portal">Fort Portal</option><option value="Busia">Busia</option><option value="Mityana">Mityana</option><option value="Hoima">Hoima</option><option value="Koboko">Koboko</option><option value="Lugazi">Lugazi</option><option value="Masindi">Masindi</option><option value="Pallisa">Pallisa</option><option value="Nebbi">Nebbi</option><option value="Paidha">Paidha</option><option value="Luwero">Luwero</option><option value="Kaberamaido">Kaberamaido</option><option value="Adjumani">Adjumani</option><option value="Bushenyi">Bushenyi</option><option value="Ibanda">Ibanda</option><option value="Wobulenzi">Wobulenzi</option><option value="Bugiri">Bugiri</option><option value="Pakwach">Pakwach</option><option value="Namasuba">Namasuba</option><option value="Kayunga">Kayunga</option><option value="Wakiso">Wakiso</option><option value="Kyenjojo">Kyenjojo</option><option value="Mubende">Mubende</option><option value="Kireka">Kireka</option><option value="Lukaya">Lukaya</option><option value="Kotido">Kotido</option><option value="Yumbe">Yumbe</option><option value="Kamwenge">Kamwenge</option><option value="Ntungamo">Ntungamo</option><option value="Bundibugyo">Bundibugyo</option><option value="Busembatia">Busembatia</option><option value="Buwenge">Buwenge</option><option value="Sironko">Sironko</option><option value="Hima">Hima</option><option value="Kiboga">Kiboga</option><option value="Moyo">Moyo</option><option value="Kanungu">Kanungu</option><option value="Kamuli">Kamuli</option><option value="Bombo">Bombo</option><option value="Apac">Apac</option><option value="Bugembe">Bugembe</option><option value="Kisoro">Kisoro</option><option value="Mayuge">Mayuge</option><option value="Bweyogerere">Bweyogerere</option><option value="Mpigi">Mpigi</option><option value="Kapchorwa">Kapchorwa</option><option value="Kaabong">Kaabong</option><option value="Ngora">Ngora</option><option value="Kumi">Kumi</option><option value="Katakwi">Katakwi</option><option value="Moroto">Moroto</option><option value="Kyotera">Kyotera</option><option value="Lyantonde">Lyantonde</option><option value="Kilembe">Kilembe</option><option value="Rakai">Rakai</option><option value="Kajansi">Kajansi</option><option value="Nakasongola">Nakasongola</option><option value="Kigorobya">Kigorobya</option><option value="Sembabule">Sembabule</option><option value="Kalangala">Kalangala</option><option value="Kagadi">Kagadi</option><option value="Amudat">Amudat</option><option value="Nakapiripirit">Nakapiripirit</option><option value="Muhororo">Muhororo</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="Ukraine"){ var str=state_selected; str=str+'<option value="Kiev">Kiev</option><option value="Kharkiv">Kharkiv</option><option value="Lvov">Lvov</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="United Arab Emirates"){ var str=state_selected; str=str+'<option value="Dubai">Dubai</option><option value="Abu Dhabi">Abu Dhabi</option><option value="Sharjah">Sharjah</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="United Kingdom"){ var str=state_selected; str=str+'<option value="London">London</option><option value="Birmingham">Birmingham</option><option value="Glasgow">Glasgow</option><option value="Belfast">Belfast</option><option value="Liverpool">Liverpool</option><option value="Leeds">Leeds</option><option value="Sheffield">Sheffield</option><option value="Edinburgh">Edinburgh</option><option value="Manchester">Manchester</option><option value="Leicester">Leicester</option><option value="Coventry">Coventry</option><option value="Kingston upon Hull">Kingston upon Hull</option><option value="Cardiff">Cardiff</option><option value="Bradford">Bradford</option><option value="Stoke-on-Trent">Stoke-on-Trent</option><option value="Wolverhampton">Wolverhampton</option><option value="Plymouth">Plymouth</option><option value="Nottingham">Nottingham</option><option value="Southampton">Southampton</option><option value="Reading">Reading</option><option value="Derby">Derby</option><option value="Dudley">Dudley</option><option value="Northampton">Northampton</option><option value="Portsmouth">Portsmouth</option><option value="Luton">Luton</option><option value="Newcastle upon Tyne">Newcastle upon Tyne</option><option value="Preston">Preston</option><option value="Aberdeen">Aberdeen</option><option value="Sunderland">Sunderland</option><option value="Norwich">Norwich</option><option value="Bournemouth">Bournemouth</option><option value="Walsall">Walsall</option><option value="Swansea">Swansea</option><option value="Southend-on-Sea">Southend-on-Sea</option><option value="Swindon">Swindon</option><option value="Oxford">Oxford</option><option value="Dundee">Dundee</option><option value="Poole">Poole</option><option value="Huddersfield">Huddersfield</option><option value="York">York</option><option value="Ipswich">Ipswich</option><option value="Blackpool">Blackpool</option><option value="Middlesbrough">Middlesbrough</option><option value="Bolton">Bolton</option><option value="Peterborough">Peterborough</option><option value="Stockport">Stockport</option><option value="Brighton">Brighton</option><option value="West Bromwich">West Bromwich</option><option value="Slough">Slough</option><option value="Gloucester">Gloucester</option><option value="Cambridge">Cambridge</option><option value="Watford">Watford</option><option value="Rotherham">Rotherham</option><option value="Newport">Newport</option><option value="Exeter">Exeter</option><option value="Eastbourne">Eastbourne</option><option value="Colchester">Colchester</option><option value="Crawley">Crawley</option><option value="Sutton Coldfield">Sutton Coldfield</option><option value="Blackburn">Blackburn</option><option value="Oldham">Oldham</option><option value="Cheltenham">Cheltenham</option><option value="Chelmsford">Chelmsford</option><option value="Saint Helens">Saint Helens</option><option value="Basildon">Basildon</option><option value="Gillingham">Gillingham</option><option value="Worcester">Worcester</option><option value="Worthing">Worthing</option><option value="Rochdale">Rochdale</option><option value="Basingstoke">Basingstoke</option><option value="Solihull">Solihull</option><option value="Bath">Bath</option><option value="Southport">Southport</option><option value="Maidstone">Maidstone</option><option value="Lincoln">Lincoln</option><option value="Hastings">Hastings</option><option value="Grimsby">Grimsby</option><option value="Darlington">Darlington</option><option value="Harrogate">Harrogate</option><option value="Hartlepool">Hartlepool</option><option value="Bedford">Bedford</option><option value="Londonderry">Londonderry</option><option value="Hemel Hempstead">Hemel Hempstead</option><option value="Stevenage">Stevenage</option><option value="Saint Albans">Saint Albans</option><option value="South Shields">South Shields</option><option value="Weston-super-Mare">Weston-super-Mare</option><option value="Halifax">Halifax</option><option value="Birkenhead">Birkenhead</option><option value="Chester">Chester</option><option value="Warrington">Warrington</option><option value="Wigan">Wigan</option><option value="High Wycombe">High Wycombe</option><option value="Stockton-on-Tees">Stockton-on-Tees</option><option value="Wakefield">Wakefield</option><option value="Gateshead">Gateshead</option><option value="Redditch">Redditch</option><option value="Bracknell">Bracknell</option><option value="Chatham">Chatham</option><option value="Hove">Hove</option><option value="Aylesbury">Aylesbury</option><option value="East Kilbride">East Kilbride</option><option value="Tamworth">Tamworth</option><option value="Nuneaton">Nuneaton</option><option value="Burnley">Burnley</option><option value="Paisley">Paisley</option><option value="Carlisle">Carlisle</option><option value="Scunthorpe">Scunthorpe</option><option value="Guildford">Guildford</option><option value="Lowestoft">Lowestoft</option><option value="Barnsley">Barnsley</option><option value="Grays">Grays</option><option value="Salford">Salford</option><option value="Gosport">Gosport</option><option value="Chesterfield">Chesterfield</option><option value="Crewe">Crewe</option><option value="Mansfield">Mansfield</option><option value="Shrewsbury">Shrewsbury</option><option value="Cannock">Cannock</option><option value="Ellesmere Port">Ellesmere Port</option><option value="Doncaster">Doncaster</option><option value="Bognor Regis">Bognor Regis</option><option value="Torquay">Torquay</option><option value="Stafford">Stafford</option><option value="Kingswood">Kingswood</option><option value="Royal Leamington Spa">Royal Leamington Spa</option><option value="Waterlooville">Waterlooville</option><option value="Ashford">Ashford</option><option value="Bangor">Bangor</option><option value="Aldershot">Aldershot</option><option value="Royal Tunbridge Wells">Royal Tunbridge Wells</option><option value="Bury">Bury</option><option value="Taunton">Taunton</option><option value="Margate">Margate</option><option value="Farnborough">Farnborough</option><option value="Runcorn">Runcorn</option><option value="Great Yarmouth">Great Yarmouth</option><option value="Maidenhead">Maidenhead</option><option value="Rhondda">Rhondda</option><option value="Loughborough">Loughborough</option><option value="Wallasey">Wallasey</option><option value="Littlehampton">Littlehampton</option><option value="Hereford">Hereford</option><option value="Bootle">Bootle</option><option value="Fareham">Fareham</option><option value="Morley">Morley</option><option value="Cheshunt">Cheshunt</option><option value="Bebington">Bebington</option><option value="Dartford">Dartford</option><option value="Kidderminster">Kidderminster</option><option value="Dewsbury">Dewsbury</option><option value="Stourbridge">Stourbridge</option><option value="Widnes">Widnes</option><option value="Sale">Sale</option><option value="Halesowen">Halesowen</option><option value="Clacton-on-Sea">Clacton-on-Sea</option><option value="Gravesend">Gravesend</option><option value="Eastleigh">Eastleigh</option><option value="Livingston">Livingston</option><option value="Washington">Washington</option><option value="Kettering">Kettering</option><option value="Crosby">Crosby</option><option value="Reigate">Reigate</option><option value="Dunstable">Dunstable</option><option value="Macclesfield">Macclesfield</option><option value="Barry">Barry</option><option value="Morecambe">Morecambe</option><option value="Staines">Staines</option><option value="Batley">Batley</option><option value="Horsham">Horsham</option><option value="Weymouth">Weymouth</option><option value="Bletchley">Bletchley</option><option value="Keighley">Keighley</option><option value="Corby">Corby</option><option value="Paignton">Paignton</option><option value="Wellingborough">Wellingborough</option><option value="Carlton">Carlton</option><option value="Cumbernauld">Cumbernauld</option><option value="Benfleet">Benfleet</option><option value="West Bridgeford">West Bridgeford</option><option value="Cwmbran">Cwmbran</option><option value="Long Eaton">Long Eaton</option><option value="Brentwood">Brentwood</option><option value="Llanelli">Llanelli</option><option value="Lancaster">Lancaster</option><option value="Canterbury">Canterbury</option><option value="Braintree">Braintree</option><option value="Neath">Neath</option><option value="Banbury">Banbury</option><option value="Folkestone">Folkestone</option><option value="Durham">Durham</option><option value="Salisbury">Salisbury</option><option value="Middleton">Middleton</option><option value="Havant">Havant</option><option value="Ayr">Ayr</option><option value="Lisburn">Lisburn</option><option value="Hinckley">Hinckley</option><option value="Welwyn Garden City">Welwyn Garden City</option><option value="Winchester">Winchester</option><option value="Sutton in Ashfield">Sutton in Ashfield</option><option value="Great Sankey">Great Sankey</option><option value="Yeovil">Yeovil</option><option value="Ashton-under-Lyne">Ashton-under-Lyne</option><option value="Wrexham">Wrexham</option><option value="Perth">Perth</option><option value="Leigh">Leigh</option><option value="Leatherhead">Leatherhead</option><option value="Greenock">Greenock</option><option value="Telford">Telford</option><option value="Kilmarnock">Kilmarnock</option><option value="Wallsend">Wallsend</option><option value="Christchurch">Christchurch</option><option value="Loughton">Loughton</option><option value="Northwich">Northwich</option><option value="Stretford">Stretford</option><option value="Altrincham">Altrincham</option><option value="Bridgend">Bridgend</option><option value="Newburn">Newburn</option><option value="Urmston">Urmston</option><option value="Sittingbourne">Sittingbourne</option><option value="Wokingham">Wokingham</option><option value="Swadlincote">Swadlincote</option><option value="Prescot">Prescot</option><option value="Inverness">Inverness</option><option value="Bexhill">Bexhill</option><option value="Worksop">Worksop</option><option value="Andover">Andover</option><option value="Coatbridge">Coatbridge</option><option value="North Shields">North Shields</option><option value="Kirkby">Kirkby</option><option value="Dunfermline">Dunfermline</option><option value="Skelmersdale">Skelmersdale</option><option value="Scarborough">Scarborough</option><option value="Glenrothes">Glenrothes</option><option value="Ramsgate">Ramsgate</option><option value="Bury Saint Edmunds">Bury Saint Edmunds</option><option value="Ilkeston">Ilkeston</option><option value="Whitley Bay">Whitley Bay</option><option value="Bridgwater">Bridgwater</option><option value="Arnold">Arnold</option><option value="Castleford">Castleford</option><option value="Great Malvern">Great Malvern</option><option value="Leyland">Leyland</option><option value="Eccles">Eccles</option><option value="Redcar">Redcar</option><option value="Abingdon">Abingdon</option><option value="Farnham">Farnham</option><option value="Trowbridge">Trowbridge</option><option value="Chester-le-Street">Chester-le-Street</option><option value="Tonbridge">Tonbridge</option><option value="Chippenham">Chippenham</option><option value="Herne Bay">Herne Bay</option><option value="Wilmslow">Wilmslow</option><option value="Mangotsfield">Mangotsfield</option><option value="Blyth">Blyth</option><option value="Chipping Sodbury">Chipping Sodbury</option><option value="Walkden">Walkden</option><option value="Tyldesley">Tyldesley</option><option value="Bicester">Bicester</option><option value="Boston">Boston</option><option value="Grantham">Grantham</option><option value="Billingham">Billingham</option><option value="Pontypool">Pontypool</option><option value="Radcliffe">Radcliffe</option><option value="Airdrie">Airdrie</option><option value="Accrington">Accrington</option><option value="Port Talbot">Port Talbot</option><option value="Exmouth">Exmouth</option><option value="Bridlington">Bridlington</option><option value="Bentley">Bentley</option><option value="Billericay">Billericay</option><option value="Felling">Felling</option><option value="Fleet">Fleet</option><option value="Letchworth">Letchworth</option><option value="Chorley">Chorley</option><option value="Hitchin">Hitchin</option><option value="Wigston">Wigston</option><option value="Leighton Buzzard">Leighton Buzzard</option><option value="Strood">Strood</option><option value="Coalville">Coalville</option><option value="Glossop">Glossop</option><option value="Pudsey">Pudsey</option><option value="Carrickfergus">Carrickfergus</option><option value="Newbury">Newbury</option><option value="Stirling">Stirling</option><option value="Wickford">Wickford</option><option value="Brighouse">Brighouse</option><option value="Aberdare">Aberdare</option><option value="Irvine">Irvine</option><option value="Darwen">Darwen</option><option value="Barnstaple">Barnstaple</option><option value="Falkirk">Falkirk</option><option value="Borehamwood">Borehamwood</option><option value="Prestwich">Prestwich</option><option value="Cleethorpes">Cleethorpes</option><option value="Beverley">Beverley</option><option value="Milton Keynes">Milton Keynes</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="United States"){ var str=state_selected; str=str+'<option value="New York">New York</option><option value="Los Angeles">Los Angeles</option><option value="Chicago">Chicago</option><option value="Houston">Houston</option><option value="Philadelphia">Philadelphia</option><option value="Phoenix">Phoenix</option><option value="San Diego">San Diego</option><option value="San Antonio">San Antonio</option><option value="Dallas">Dallas</option><option value="San Jose">San Jose</option><option value="Detroit">Detroit</option><option value="Jacksonville">Jacksonville</option><option value="Indianapolis">Indianapolis</option><option value="Columbus">Columbus</option><option value="San Francisco">San Francisco</option><option value="Austin">Austin</option><option value="Memphis">Memphis</option><option value="Fort Worth">Fort Worth</option><option value="Baltimore">Baltimore</option><option value="Charlotte">Charlotte</option><option value="El Paso">El Paso</option><option value="Milwaukee">Milwaukee</option><option value="Boston">Boston</option><option value="Seattle">Seattle</option><option value="Denver">Denver</option><option value="Washington">Washington</option><option value="Portland">Portland</option><option value="Las Vegas">Las Vegas</option><option value="Oklahoma City">Oklahoma City</option><option value="Nashville">Nashville</option><option value="Tucson">Tucson</option><option value="Albuquerque">Albuquerque</option><option value="Long Beach">Long Beach</option><option value="Sacramento">Sacramento</option><option value="Fresno">Fresno</option><option value="New Orleans">New Orleans</option><option value="Mesa">Mesa</option><option value="Cleveland">Cleveland</option><option value="Virginia Beach">Virginia Beach</option><option value="Kansas City">Kansas City</option><option value="Atlanta">Atlanta</option><option value="Omaha">Omaha</option><option value="Oakland">Oakland</option><option value="Honolulu">Honolulu</option><option value="Miami">Miami</option><option value="Tulsa">Tulsa</option><option value="Colorado Springs">Colorado Springs</option><option value="Minneapolis">Minneapolis</option><option value="Arlington">Arlington</option><option value="Wichita">Wichita</option><option value="Santa Ana">Santa Ana</option><option value="Raleigh">Raleigh</option><option value="Anaheim">Anaheim</option><option value="Tampa">Tampa</option><option value="Saint Louis">Saint Louis</option><option value="Pittsburgh">Pittsburgh</option><option value="Toledo">Toledo</option><option value="Cincinnati">Cincinnati</option><option value="Aurora">Aurora</option><option value="Riverside">Riverside</option><option value="Bakersfield">Bakersfield</option><option value="Stockton">Stockton</option><option value="Corpus Christi">Corpus Christi</option><option value="Newark">Newark</option><option value="Buffalo">Buffalo</option><option value="Anchorage">Anchorage</option><option value="Saint Paul">Saint Paul</option><option value="Lexington-Fayette">Lexington-Fayette</option><option value="Plano">Plano</option><option value="Saint Petersburg">Saint Petersburg</option><option value="Norfolk">Norfolk</option><option value="Louisville">Louisville</option><option value="Glendale">Glendale</option><option value="Henderson">Henderson</option><option value="Jersey City">Jersey City</option><option value="Chandler">Chandler</option><option value="Greensboro">Greensboro</option><option value="Birmingham">Birmingham</option><option value="Fort Wayne">Fort Wayne</option><option value="Scottsdale">Scottsdale</option><option value="Hialeah">Hialeah</option><option value="Madison">Madison</option><option value="Baton Rouge">Baton Rouge</option><option value="Chesapeake">Chesapeake</option><option value="Garland">Garland</option><option value="Modesto">Modesto</option><option value="Paradise">Paradise</option><option value="Chula Vista">Chula Vista</option><option value="Lubbock">Lubbock</option><option value="Rochester">Rochester</option><option value="Laredo">Laredo</option><option value="Akron">Akron</option><option value="Orlando">Orlando</option><option value="Durham">Durham</option><option value="Glendale">Glendale</option><option value="Fremont">Fremont</option><option value="San Bernardino">San Bernardino</option><option value="Reno">Reno</option><option value="Boise">Boise</option><option value="Montgomery">Montgomery</option><option value="Yonkers">Yonkers</option><option value="Spokane">Spokane</option><option value="Shreveport">Shreveport</option><option value="Tacoma">Tacoma</option><option value="Huntington Beach">Huntington Beach</option><option value="Grand Rapids">Grand Rapids</option><option value="Irving">Irving</option><option value="Winston-Salem">Winston-Salem</option><option value="Des Moines">Des Moines</option><option value="Richmond">Richmond</option><option value="Mobile">Mobile</option><option value="Irvine">Irvine</option><option value="Sunrise Manor">Sunrise Manor</option><option value="Oxnard">Oxnard</option><option value="Arlington">Arlington</option><option value="Columbus">Columbus</option><option value="Little Rock">Little Rock</option><option value="Newport News">Newport News</option><option value="Amarillo">Amarillo</option><option value="Salt Lake City">Salt Lake City</option><option value="Providence">Providence</option><option value="Worcester">Worcester</option><option value="Jackson">Jackson</option><option value="Aurora">Aurora</option><option value="Ontario">Ontario</option><option value="Knoxville">Knoxville</option><option value="Gilbert">Gilbert</option><option value="Fort Lauderdale">Fort Lauderdale</option><option value="Fontana">Fontana</option><option value="Santa Clarita">Santa Clarita</option><option value="Moreno Valley">Moreno Valley</option><option value="Rancho Cucamonga">Rancho Cucamonga</option><option value="Brownsville">Brownsville</option><option value="Huntsville">Huntsville</option><option value="Garden Grove">Garden Grove</option><option value="Overland Park">Overland Park</option><option value="North Las Vegas">North Las Vegas</option><option value="Spring Valley">Spring Valley</option><option value="Dayton">Dayton</option><option value="Tempe">Tempe</option><option value="Vancouver">Vancouver</option><option value="Pomona">Pomona</option><option value="Pembroke Pines">Pembroke Pines</option><option value="Santa Rosa">Santa Rosa</option><option value="Chattanooga">Chattanooga</option><option value="Tallahassee">Tallahassee</option><option value="Corona">Corona</option><option value="Rockford">Rockford</option><option value="Springfield">Springfield</option><option value="Hayward">Hayward</option><option value="Paterson">Paterson</option><option value="Springfield">Springfield</option><option value="Salinas">Salinas</option><option value="Hampton">Hampton</option><option value="Salem">Salem</option><option value="Kansas City">Kansas City</option><option value="Eugene">Eugene</option><option value="Torrance">Torrance</option><option value="Hollywood">Hollywood</option><option value="Pasadena">Pasadena</option><option value="Pasadena">Pasadena</option><option value="Naperville">Naperville</option><option value="Metairie">Metairie</option><option value="Syracuse">Syracuse</option><option value="Grand Prairie">Grand Prairie</option><option value="Lakewood">Lakewood</option><option value="Sioux Falls">Sioux Falls</option><option value="Peoria">Peoria</option><option value="Bridgeport">Bridgeport</option><option value="Escondido">Escondido</option><option value="Fullerton">Fullerton</option><option value="Palmdale">Palmdale</option><option value="Joliet">Joliet</option><option value="Orange">Orange</option><option value="Warren">Warren</option><option value="Coral Springs">Coral Springs</option><option value="Mesquite">Mesquite</option><option value="Cape Coral">Cape Coral</option><option value="Lancaster">Lancaster</option><option value="Fort Collins">Fort Collins</option><option value="Thousand Oaks">Thousand Oaks</option><option value="Alexandria">Alexandria</option><option value="Sterling Heights">Sterling Heights</option><option value="Sunnyvale">Sunnyvale</option><option value="Gainesville">Gainesville</option><option value="Concord">Concord</option><option value="El Monte">El Monte</option><option value="East Los Angeles">East Los Angeles</option><option value="New Haven">New Haven</option><option value="Fayetteville">Fayetteville</option><option value="Hartford">Hartford</option><option value="Elizabeth">Elizabeth</option><option value="Cedar Rapids">Cedar Rapids</option><option value="Topeka">Topeka</option><option value="Stamford">Stamford</option><option value="Carrollton">Carrollton</option><option value="Vallejo">Vallejo</option><option value="Simi Valley">Simi Valley</option><option value="Port Saint Lucie">Port Saint Lucie</option><option value="Toms River">Toms River</option><option value="Waco">Waco</option><option value="Columbia">Columbia</option><option value="Lansing">Lansing</option><option value="Flint">Flint</option><option value="Inglewood">Inglewood</option><option value="Springfield">Springfield</option><option value="Evansville">Evansville</option><option value="Abilene">Abilene</option><option value="Ann Arbor">Ann Arbor</option><option value="Olathe">Olathe</option><option value="West Valley City">West Valley City</option><option value="Peoria">Peoria</option><option value="Miramar">Miramar</option><option value="Roseville">Roseville</option><option value="Lafayette">Lafayette</option><option value="Bellevue">Bellevue</option><option value="Downey">Downey</option><option value="Clarksville">Clarksville</option><option value="Beaumont">Beaumont</option><option value="Independence">Independence</option><option value="Manchester">Manchester</option><option value="West Covina">West Covina</option><option value="Costa Mesa">Costa Mesa</option><option value="Norwalk">Norwalk</option><option value="Waterbury">Waterbury</option><option value="Clearwater">Clearwater</option><option value="Visalia">Visalia</option><option value="Antioch">Antioch</option><option value="Provo">Provo</option><option value="Fairfield">Fairfield</option><option value="Allentown">Allentown</option><option value="Richardson">Richardson</option><option value="Charleston">Charleston</option><option value="Burbank">Burbank</option><option value="Thornton">Thornton</option><option value="Pueblo">Pueblo</option><option value="Westminster">Westminster</option><option value="Cary">Cary</option><option value="South Bend">South Bend</option><option value="Lowell">Lowell</option><option value="Killeen">Killeen</option><option value="Edison">Edison</option><option value="Santa Clara">Santa Clara</option><option value="Norman">Norman</option><option value="Arvada">Arvada</option><option value="Highlands Ranch">Highlands Ranch</option><option value="Rialto">Rialto</option><option value="Cambridge">Cambridge</option><option value="Wichita Falls">Wichita Falls</option><option value="West Jordan">West Jordan</option><option value="Green Bay">Green Bay</option><option value="Denton">Denton</option><option value="Berkeley">Berkeley</option><option value="South Gate">South Gate</option><option value="Erie">Erie</option><option value="Billings">Billings</option><option value="Portsmouth">Portsmouth</option><option value="Daly City">Daly City</option><option value="Gresham">Gresham</option><option value="Elgin">Elgin</option><option value="Livonia">Livonia</option><option value="Gary">Gary</option><option value="Midland">Midland</option><option value="Everett">Everett</option><option value="Centennial">Centennial</option><option value="Davenport">Davenport</option><option value="Spring Hill">Spring Hill</option><option value="Compton">Compton</option><option value="Vacaville">Vacaville</option><option value="Rochester">Rochester</option><option value="Mission Viejo">Mission Viejo</option><option value="Columbia">Columbia</option><option value="Carson">Carson</option><option value="Dearborn">Dearborn</option><option value="Brockton">Brockton</option><option value="El Cajon">El Cajon</option><option value="Sandy Springs">Sandy Springs</option><option value="Elk Grove">Elk Grove</option><option value="High Point">High Point</option><option value="Macon">Macon</option><option value="New Bedford">New Bedford</option><option value="Kenosha">Kenosha</option><option value="Lewisville">Lewisville</option><option value="Albany">Albany</option><option value="West Palm Beach">West Palm Beach</option><option value="Orem">Orem</option><option value="Fall River">Fall River</option><option value="Vista">Vista</option><option value="Waukegan">Waukegan</option><option value="Wilmington">Wilmington</option><option value="Fargo">Fargo</option><option value="Lawton">Lawton</option><option value="Redding">Redding</option><option value="Boulder">Boulder</option><option value="Columbia">Columbia</option><option value="Odessa">Odessa</option>'; str=str+state_selected2; html_input(str);}	
		else if(objValue==="United States Minor Outlying Islands"){ var str=state_selected; str=str+'<option value="Johnston Island">Johnston Island</option><option value="Midway Island">Midway Island</option><option value="Wake Island">Wake Island</option>'; str=str+state_selected2; html_input(str);}
		
		
		else if(objValue==="Zimbabwe"){ var str=state_selected; str=str+'<option value="Bulawayo">Bulawayo</option><option value="Harare">Harare</option><option value="Manicaland">Manicaland</option><option value="Mashonaland Central">Mashonaland Central</option><option value="Mashonaland East">Mashonaland East</option><option value="Mashonaland East Province">Mashonaland East Province</option><option value="Mashonaland West">Mashonaland West</option><option value="Masvingo Province">Masvingo Province</option><option value="Matabeleland North">Matabeleland North</option><option value="Matabeleland South">Matabeleland South</option><option value="Matabeleland South Province">Matabeleland South Province</option><option value="Midlands Province">Midlands Province</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Zambia"){ var str=state_selected; str=str+'<option value="Central">Central</option><option value="Central Province">Central Province</option><option value="Copperbelt">Copperbelt</option><option value="Eastern Province">Eastern Province</option><option value="Luapula">Luapula</option><option value="Luapula Province">Luapula Province</option><option value="Lusaka">Lusaka</option><option value="Lusaka Province">Lusaka Province</option><option value="Muchinga">Muchinga</option><option value="Muchinga Province">Muchinga Province</option><option value="North-Western Province">North-Western Province</option><option value="Northern">Northern</option><option value="Northern Province">Northern Province</option><option value="Southern Province">Southern Province</option><option value="Western">Western</option><option value="Western Province">Western Province</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Yemen"){ var str=state_selected; str=str+'<option value="Aḑ Ḑāli‘">Aḑ Ḑāli‘</option><option value="Aden">Aden</option><option value="Al Hudaydah">Al Hudaydah</option><option value="Al Mahwit">Al Mahwit</option><option value="Dhamar">Dhamar</option><option value="Hadramawt">Hadramawt</option><option value="Ḩajjah">Ḩajjah</option><option value="Ibb">Ibb</option><option value="Laḩij">Laḩij</option><option value="Ma’rib">Ma’rib</option><option value="Muhafazat Abyan">Muhafazat Abyan</option><option value="Muhafazat Hadramawt">Muhafazat Hadramawt</option><option value="Omran">Omran</option><option value="Raymah">Raymah</option><option value="Sanaa">Sanaa</option><option value="Şa‘dah">Şa‘dah</option><option value="Shabwah">Shabwah</option><option value="Soqatra">Soqatra</option><option value="Ta‘izz">Ta‘izz</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Wallis and Futuna Islands"){ var str=state_selected; str=str+'<option value="Alo">Alo</option><option value="Circonscription dAlo">Circonscription dAlo</option><option value="Circonscription dUvea">Circonscription dUvea</option><option value="Circonscription de Sigave">Circonscription de Sigave</option><option value="Sigave">Sigave</option><option value="Uvea">Uvea</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Vanuatu"){ var str=state_selected; str=str+'<option value="Efate">Efate</option><option value="Malampa Province">Malampa Province</option><option value="Penama Province">Penama Province</option><option value="Sanma Province">Sanma Province</option><option value="Shefa Province">Shefa Province</option><option value="Tafea Province">Tafea Province</option><option value="Torba Province">Torba Province</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Viet Nam"){ var str=state_selected; str=str+'<option value="An Giang">An Giang</option><option value="Bac Lieu">Bac Lieu</option><option value="Ben Tre">Ben Tre</option><option value="Binh Thuan">Binh Thuan</option><option value="Can Tho">Can Tho</option><option value="Da Nang">Da Nang</option><option value="Dak Nong">Dak Nong</option><option value="Dien Bien">Dien Bien</option><option value="Dong Thap">Dong Thap</option><option value="Gia Lai">Gia Lai</option><option value="Ha Noi">Ha Noi</option><option value="Hai Duong">Hai Duong</option><option value="Hai Phong">Hai Phong</option><option value="Haiphong">Haiphong</option><option value="Hanoi">Hanoi</option><option value="Hau Giang">Hau Giang</option><option value="Ho Chi Minh">Ho Chi Minh</option><option value="Ho Chi Minh City">Ho Chi Minh City</option><option value="Hung Yen">Hung Yen</option><option value="Kon Tum">Kon Tum</option><option value="Lam Dong">Lam Dong</option><option value="Long An">Long An</option><option value="Nam Dinh">Nam Dinh</option><option value="Phu Tho">Phu Tho</option><option value="Quang Nam">Quang Nam</option><option value="Quảng Ngãi Province">Quảng Ngãi Province</option><option value="Quang Ninh">Quang Ninh</option><option value="Soc Trang">Soc Trang</option><option value="Son La">Son La</option><option value="Tây Ninh Province">Tây Ninh Province</option><option value="Thai Binh">Thai Binh</option><option value="Thai Nguyen">Thai Nguyen</option><option value="Thanh Hoa">Thanh Hoa</option><option value="Thanh Pho Can Tho">Thanh Pho Can Tho</option><option value="Thanh Pho GJa Nang">Thanh Pho GJa Nang</option><option value="Thanh Pho Ha Noi">Thanh Pho Ha Noi</option><option value="Thanh Pho Hai Phong">Thanh Pho Hai Phong</option><option value="Tien Giang">Tien Giang</option><option value="Tinh Ba Ria-Vung Tau">Tinh Ba Ria-Vung Tau</option><option value="Tinh Bac Giang">Tinh Bac Giang</option><option value="Tinh Bac Kan">Tinh Bac Kan</option><option value="Tinh Bac Lieu">Tinh Bac Lieu</option><option value="Tinh Bac Ninh">Tinh Bac Ninh</option><option value="Tinh Ben Tre">Tinh Ben Tre</option><option value="Tinh Binh Dinh">Tinh Binh Dinh</option><option value="Tinh Binh Duong">Tinh Binh Duong</option><option value="Tinh Binh GJinh">Tinh Binh GJinh</option><option value="Tinh Binh Phuoc">Tinh Binh Phuoc</option><option value="Tinh Binh Thuan">Tinh Binh Thuan</option><option value="Tinh Ca Mau">Tinh Ca Mau</option><option value="Tinh Cao Bang">Tinh Cao Bang</option><option value="Tinh Dien Bien">Tinh Dien Bien</option><option value="Tinh GJak Lak">Tinh GJak Lak</option><option value="Tinh GJong Nai">Tinh GJong Nai</option><option value="Tinh GJong Thap">Tinh GJong Thap</option><option value="Tinh Ha Giang">Tinh Ha Giang</option><option value="Tinh Ha Nam">Tinh Ha Nam</option><option value="Tinh Ha Tinh">Tinh Ha Tinh</option><option value="Tinh Hai Duong">Tinh Hai Duong</option><option value="Tinh Hoa Binh">Tinh Hoa Binh</option><option value="Tinh Hung Yen">Tinh Hung Yen</option><option value="Tinh Khanh Hoa">Tinh Khanh Hoa</option><option value="Tinh Kien Giang">Tinh Kien Giang</option><option value="Tinh Lai Chau">Tinh Lai Chau</option><option value="Tinh Lam GJong">Tinh Lam GJong</option><option value="Tinh Lang Son">Tinh Lang Son</option><option value="Tinh Lao Cai">Tinh Lao Cai</option><option value="Tinh Nam GJinh">Tinh Nam GJinh</option><option value="Tinh Nghe An">Tinh Nghe An</option><option value="Tinh Ninh Binh">Tinh Ninh Binh</option><option value="Tinh Ninh Thuan">Tinh Ninh Thuan</option><option value="Tinh Phu Tho">Tinh Phu Tho</option><option value="Tinh Phu Yen">Tinh Phu Yen</option><option value="Tinh Quang Binh">Tinh Quang Binh</option><option value="Tinh Quang Nam">Tinh Quang Nam</option><option value="Tinh Quang Ngai">Tinh Quang Ngai</option><option value="Tinh Quang Ninh">Tinh Quang Ninh</option><option value="Tinh Quang Tri">Tinh Quang Tri</option><option value="Tinh Soc Trang">Tinh Soc Trang</option><option value="Tinh Son La">Tinh Son La</option><option value="Tinh Tay Ninh">Tinh Tay Ninh</option><option value="Tinh Thai Binh">Tinh Thai Binh</option><option value="Tinh Thai Nguyen">Tinh Thai Nguyen</option><option value="Tinh Thanh Hoa">Tinh Thanh Hoa</option><option value="Tinh Thua Thien-Hue">Tinh Thua Thien-Hue</option><option value="Tinh Tien Giang">Tinh Tien Giang</option><option value="Tinh Tra Vinh">Tinh Tra Vinh</option><option value="Tinh Tuyen Quang">Tinh Tuyen Quang</option><option value="Tinh Vinh Long">Tinh Vinh Long</option><option value="Tinh Vinh Phuc">Tinh Vinh Phuc</option><option value="Tinh Yen Bai">Tinh Yen Bai</option><option value="Tuyen Quang">Tuyen Quang</option><option value="Đắk Lắk">Đắk Lắk</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Virgin Islands, US"){ var str=state_selected; str=str+'<option value="Saint Croix Island">Saint Croix Island</option><option value="Saint John Island">Saint John Island</option><option value="Saint Thomas Island">Saint Thomas Island</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Saint Vincent and Grenadines"){ var str=state_selected; str=str+'<option value="Grenadines">Grenadines</option><option value="Parish of Charlotte">Parish of Charlotte</option><option value="Parish of Saint Andrew">Parish of Saint Andrew</option><option value="Parish of Saint David">Parish of Saint David</option><option value="Parish of Saint George">Parish of Saint George</option><option value="Parish of Saint Patrick">Parish of Saint Patrick</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Uzbekistan"){ var str=state_selected; str=str+'<option value="Andijan">Andijan</option><option value="Bukhara">Bukhara</option><option value="Fergana">Fergana</option><option value="Jizzakh Province">Jizzakh Province</option><option value="Karakalpakstan">Karakalpakstan</option><option value="Namangan">Namangan</option><option value="Navoiy Province">Navoiy Province</option><option value="Nawoiy">Nawoiy</option><option value="Qashqadaryo">Qashqadaryo</option><option value="Samarqand Viloyati">Samarqand Viloyati</option><option value="Sirdaryo">Sirdaryo</option><option value="Surkhondaryo">Surkhondaryo</option><option value="Surxondaryo Viloyati">Surxondaryo Viloyati</option><option value="Toshkent">Toshkent</option><option value="Toshkent Shahri">Toshkent Shahri</option><option value="Toshkent Viloyati">Toshkent Viloyati</option><option value="Xorazm Viloyati">Xorazm Viloyati</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Uruguay"){ var str=state_selected; str=str+'<option value="Artigas">Artigas</option><option value="Canelones">Canelones</option><option value="Cerro Largo">Cerro Largo</option><option value="Colonia">Colonia</option><option value="Departamento de Durazno">Departamento de Durazno</option><option value="Departamento de Flores">Departamento de Flores</option><option value="Departamento de Montevideo">Departamento de Montevideo</option><option value="Departamento de Paysandu">Departamento de Paysandu</option><option value="Departamento de Rio Negro">Departamento de Rio Negro</option><option value="Departamento de Rivera">Departamento de Rivera</option><option value="Departamento de Rocha">Departamento de Rocha</option><option value="Departamento de Salto">Departamento de Salto</option><option value="Departamento de San Jose">Departamento de San Jose</option><option value="Departamento de Tacuarembo">Departamento de Tacuarembo</option><option value="Departamento de Treinta y Tres">Departamento de Treinta y Tres</option><option value="Durazno">Durazno</option><option value="Flores">Flores</option><option value="Florida">Florida</option><option value="Lavalleja">Lavalleja</option><option value="Maldonado">Maldonado</option><option value="Montevideo">Montevideo</option><option value="Rocha">Rocha</option><option value="San Jose">San Jose</option><option value="Soriano">Soriano</option><option value="Tacuarembo">Tacuarembo</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Tanzania, United Republic of"){ var str=state_selected; str=str+'<option value="Arusha">Arusha</option><option value="Dar es Salaam">Dar es Salaam</option><option value="Dar es Salaam Region">Dar es Salaam Region</option><option value="Dodoma">Dodoma</option><option value="Geita">Geita</option><option value="Iringa">Iringa</option><option value="Kagera">Kagera</option><option value="Katavi">Katavi</option><option value="Kigoma">Kigoma</option><option value="Kilimanjaro">Kilimanjaro</option><option value="Lindi">Lindi</option><option value="Manyara">Manyara</option><option value="Mara">Mara</option><option value="Mbeya">Mbeya</option><option value="Morogoro">Morogoro</option><option value="Mtwara">Mtwara</option><option value="Mwanza">Mwanza</option><option value="Njombe">Njombe</option><option value="Pemba North">Pemba North</option><option value="Pemba South">Pemba South</option><option value="Pwani">Pwani</option><option value="Ruvuma">Ruvuma</option><option value="Shinyanga">Shinyanga</option><option value="Simiyu">Simiyu</option><option value="Singida">Singida</option><option value="Tabora">Tabora</option><option value="Tanga">Tanga</option><option value="Zanzibar Central/South">Zanzibar Central/South</option><option value="Zanzibar Urban/West">Zanzibar Urban/West</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Taiwan, Republic of China"){ var str=state_selected; str=str+'<option value="Changhua">Changhua</option><option value="Chiayi">Chiayi</option><option value="Chiayi County">Chiayi County</option><option value="Fu-chien">Fu-chien</option><option value="Fukien">Fukien</option><option value="Hsinchu">Hsinchu</option><option value="Hsinchu County">Hsinchu County</option><option value="Hualien">Hualien</option><option value="Kaohsiung">Kaohsiung</option><option value="Keelung">Keelung</option><option value="Kinmen County">Kinmen County</option><option value="Lienchiang">Lienchiang</option><option value="Miaoli">Miaoli</option><option value="Nantou">Nantou</option><option value="New Taipei">New Taipei</option><option value="Penghu">Penghu</option><option value="Penghu County">Penghu County</option><option value="Pingtung">Pingtung</option><option value="Tai-pei">Tai-pei</option><option value="Tai-wan">Tai-wan</option><option value="Taichung City">Taichung City</option><option value="Tainan">Tainan</option><option value="Taipei">Taipei</option><option value="Taipei City">Taipei City</option><option value="Taitung">Taitung</option><option value="Taiwan">Taiwan</option><option value="Taoyuan">Taoyuan</option><option value="Yilan">Yilan</option><option value="Yunlin">Yunlin</option><option value="Yunlin County">Yunlin County</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Svalbard and Jan Mayen Islands"){ var str=state_selected; str=str+'<option value="Jan Mayen">Jan Mayen</option><option value="Svalbard">Svalbard</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Serbia"){ var str=state_selected; str=str+'<option value="Autonomna Pokrajina Vojvodina">Autonomna Pokrajina Vojvodina</option><option value="Belgrade">Belgrade</option><option value="Bor">Bor</option><option value="Branicevo">Branicevo</option><option value="Central Serbia">Central Serbia</option><option value="Danube">Danube</option><option value="Jablanica">Jablanica</option><option value="Kolubara">Kolubara</option><option value="Macva">Macva</option><option value="Morava">Morava</option><option value="Nisava">Nisava</option><option value="Pcinja">Pcinja</option><option value="Pirot">Pirot</option><option value="Podunavlje">Podunavlje</option><option value="Pomoravlje">Pomoravlje</option><option value="Rasina">Rasina</option><option value="Raska">Raska</option><option value="Sumadija">Sumadija</option><option value="Toplica">Toplica</option><option value="Vojvodina">Vojvodina</option><option value="Zajecar">Zajecar</option><option value="Zlatibor">Zlatibor</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Réunion"){ var str=state_selected; str=str+'<option value="Avirons">Avirons</option><option value="Bagatelle">Bagatelle</option><option value="Beaufond">Beaufond</option><option value="Bellemene">Bellemene</option><option value="Bernica-les Bas">Bernica-les Bas</option><option value="Bois De Nèfles">Bois De Nèfles</option><option value="Boucan Canot">Boucan Canot</option><option value="Bras-panon">Bras-panon</option><option value="Cilaos">Cilaos</option><option value="Entre-deux">Entre-deux</option><option value="Etang">Etang</option><option value="Étang-salé">Étang-salé</option><option value="Etang-Sale les Bains">Etang-Sale les Bains</option><option value="F. Sauger">F. Sauger</option><option value="Filaos">Filaos</option><option value="Grand Fond">Grand Fond</option><option value="Hermitage">Hermitage</option><option value="LEntre-Deux">LEntre-Deux</option><option value="LEtang">LEtang</option><option value="Létang-salé">Létang-salé</option><option value="LEtang-Sale les Bains">LEtang-Sale les Bains</option><option value="La Bretagne">La Bretagne</option><option value="La Chaloupe Saint-Leu">La Chaloupe Saint-Leu</option><option value="La Cour du Piton">La Cour du Piton</option><option value="La Grande Montee">La Grande Montee</option><option value="La Montagne">La Montagne</option><option value="La Plaine">La Plaine</option><option value="La Plaine Des Cafres">La Plaine Des Cafres</option><option value="La Plaine Des Palmistes">La Plaine Des Palmistes</option><option value="La Plaine-des-Palmistes">La Plaine-des-Palmistes</option><option value="La Possession">La Possession</option><option value="La Rivière">La Rivière</option><option value="La Riviere des Pluies">La Riviere des Pluies</option><option value="La Saline">La Saline</option><option value="Le Grand Tampon les Bas">Le Grand Tampon les Bas</option><option value="Le Guillaume">Le Guillaume</option><option value="Le Guillaume Jardin">Le Guillaume Jardin</option><option value="Le Petit Tampon">Le Petit Tampon</option><option value="Le Port">Le Port</option><option value="Le Tampon">Le Tampon</option><option value="Les Avirons">Les Avirons</option><option value="Les Trois Mares">Les Trois Mares</option><option value="Les Trois-bassins">Les Trois-bassins</option><option value="Ligne des Bambous">Ligne des Bambous</option><option value="Makes">Makes</option><option value="Petite Île">Petite Île</option><option value="Petite-Ile">Petite-Ile</option><option value="Piton">Piton</option><option value="Plaine Des Palmistes">Plaine Des Palmistes</option><option value="Plate">Plate</option><option value="Possession">Possession</option><option value="Ravine Des Cabris">Ravine Des Cabris</option><option value="Rivière">Rivière</option><option value="Saint Gilles">Saint Gilles</option><option value="Saint-andré">Saint-andré</option><option value="Saint-benoît">Saint-benoît</option><option value="Saint-Coeur">Saint-Coeur</option><option value="Saint-denis">Saint-denis</option><option value="Saint-Gilles les Bains">Saint-Gilles les Bains</option><option value="Saint-gilles-les Bains">Saint-gilles-les Bains</option><option value="Saint-joseph">Saint-joseph</option><option value="Saint-leu">Saint-leu</option><option value="Saint-louis">Saint-louis</option><option value="Saint-paul">Saint-paul</option><option value="Saint-Philippe">Saint-Philippe</option><option value="Saint-pierre">Saint-pierre</option><option value="Saint-Piorre">Saint-Piorre</option><option value="Sainte-anne">Sainte-anne</option><option value="Sainte-clotilde">Sainte-clotilde</option><option value="Sainte-marie">Sainte-marie</option><option value="Sainte-rose">Sainte-rose</option><option value="Sainte-suzanne">Sainte-suzanne</option><option value="Salazie">Salazie</option><option value="Saline">Saline</option><option value="Stella">Stella</option><option value="Tampon">Tampon</option><option value="Trois Bassins">Trois Bassins</option><option value="Trois-Bassins">Trois-Bassins</option><option value="Vincendo">Vincendo</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Palestinian Territory"){ var str=state_selected; str=str+'<option value="Al Khalil">Al Khalil</option><option value="Bethlehem">Bethlehem</option><option value="Gaza Strip">Gaza Strip</option><option value="Jenin">Jenin</option><option value="Ramallah">Ramallah</option><option value="Salfit">Salfit</option><option value="Tubas">Tubas</option><option value="Tulkarm">Tulkarm</option><option value="West Bank">West Bank</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Macedonia, Republic of"){ var str=state_selected; str=str+'<option value="Aracinovo">Aracinovo</option><option value="Berovo">Berovo</option><option value="Bitola">Bitola</option><option value="Bogdanci">Bogdanci</option><option value="Bogovinje">Bogovinje</option><option value="Cesinovo">Cesinovo</option><option value="Cucer-Sandevo">Cucer-Sandevo</option><option value="Debar">Debar</option><option value="Demir Hisar">Demir Hisar</option><option value="Demir Kapija">Demir Kapija</option><option value="Dolneni">Dolneni</option><option value="Gevgelija">Gevgelija</option><option value="Gostivar">Gostivar</option><option value="Gradsko">Gradsko</option><option value="Ilinden">Ilinden</option><option value="Jegunovce">Jegunovce</option><option value="Karbinci">Karbinci</option><option value="Karpos">Karpos</option><option value="Kavadarci">Kavadarci</option><option value="Kondovo">Kondovo</option><option value="Kratovo">Kratovo</option><option value="Kriva Palanka">Kriva Palanka</option><option value="Kuklis">Kuklis</option><option value="Kumanovo">Kumanovo</option><option value="Lozovo">Lozovo</option><option value="Makedonska Kamenica">Makedonska Kamenica</option><option value="Makedonski Brod">Makedonski Brod</option><option value="Negotino">Negotino</option><option value="Novaci">Novaci</option><option value="Novo Selo">Novo Selo</option><option value="Ohrid">Ohrid</option><option value="Opstina Aracinovo">Opstina Aracinovo</option><option value="Opstina Cucer-Sandevo">Opstina Cucer-Sandevo</option><option value="Opstina Delcevo">Opstina Delcevo</option><option value="Opstina Dojran">Opstina Dojran</option><option value="Opstina Karpos">Opstina Karpos</option><option value="Opstina Kicevo">Opstina Kicevo</option><option value="Opstina Kocani">Opstina Kocani</option><option value="Opstina Krusevo">Opstina Krusevo</option><option value="Opstina Lipkovo">Opstina Lipkovo</option><option value="Opstina Pehcevo">Opstina Pehcevo</option><option value="Opstina Probistip">Opstina Probistip</option><option value="Opstina Radovis">Opstina Radovis</option><option value="Opstina Stip">Opstina Stip</option><option value="Opstina Vevcani">Opstina Vevcani</option><option value="Pehcevo">Pehcevo</option><option value="Petrovec">Petrovec</option><option value="Plasnica">Plasnica</option><option value="Prilep">Prilep</option><option value="Resen">Resen</option><option value="Resen Municipality">Resen Municipality</option><option value="Rosoman">Rosoman</option><option value="Samokov">Samokov</option><option value="Star Dojran">Star Dojran</option><option value="Stip">Stip</option><option value="Struga">Struga</option><option value="Strumica">Strumica</option><option value="Studenicani">Studenicani</option><option value="Sveti Nikole">Sveti Nikole</option><option value="Tearce">Tearce</option><option value="Tetovo">Tetovo</option><option value="Valandovo">Valandovo</option><option value="Valandovo Municipality">Valandovo Municipality</option><option value="Veles">Veles</option><option value="Vinica">Vinica</option><option value="Zelino">Zelino</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Montenegro"){ var str=state_selected; str=str+'<option value="Andrijevica">Andrijevica</option><option value="Bar">Bar</option><option value="Berane">Berane</option><option value="Bijelo Polje">Bijelo Polje</option><option value="Budva">Budva</option><option value="Cetinje">Cetinje</option><option value="Danilovgrad">Danilovgrad</option><option value="Gusinje">Gusinje</option><option value="Herceg Novi">Herceg Novi</option><option value="Kotor">Kotor</option><option value="Mojkovac">Mojkovac</option><option value="Opstina Kolasin">Opstina Kolasin</option><option value="Opstina Niksic">Opstina Niksic</option><option value="Opstina Plav">Opstina Plav</option><option value="Opstina Pluzine">Opstina Pluzine</option><option value="Opstina Rozaje">Opstina Rozaje</option><option value="Opstina Savnik">Opstina Savnik</option><option value="Opstina Zabljak">Opstina Zabljak</option><option value="Petnjica">Petnjica</option><option value="Pljevlja">Pljevlja</option><option value="Podgorica">Podgorica</option><option value="Tivat">Tivat</option><option value="Ulcinj">Ulcinj</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Moldova"){ var str=state_selected; str=str+'<option value="Anenii Noi">Anenii Noi</option><option value="Balti">Balti</option><option value="Basarabeasca">Basarabeasca</option><option value="Bender">Bender</option><option value="Bender Municipality">Bender Municipality</option><option value="Briceni">Briceni</option><option value="Cahul">Cahul</option><option value="Cantemir">Cantemir</option><option value="Chisinau">Chisinau</option><option value="Chișinău Municipality">Chișinău Municipality</option><option value="Cimislia">Cimislia</option><option value="Criuleni">Criuleni</option><option value="Donduseni">Donduseni</option><option value="Drochia">Drochia</option><option value="Falesti">Falesti</option><option value="Floresti">Floresti</option><option value="Gagauzia">Gagauzia</option><option value="Glodeni">Glodeni</option><option value="Hincesti">Hincesti</option><option value="Ialoveni">Ialoveni</option><option value="Laloveni">Laloveni</option><option value="Leova">Leova</option><option value="Municipiul Balti">Municipiul Balti</option><option value="Municipiul Bender">Municipiul Bender</option><option value="Municipiul Chisinau">Municipiul Chisinau</option><option value="Nisporeni">Nisporeni</option><option value="Orhei">Orhei</option><option value="Raionul Calarasi">Raionul Calarasi</option><option value="Raionul Causeni">Raionul Causeni</option><option value="Raionul Dubasari">Raionul Dubasari</option><option value="Raionul Edineţ">Raionul Edineţ</option><option value="Raionul Ocniţa">Raionul Ocniţa</option><option value="Raionul Soroca">Raionul Soroca</option><option value="Raionul Stefan Voda">Raionul Stefan Voda</option><option value="Rezina">Rezina</option><option value="Riscani">Riscani</option><option value="Sîngerei">Sîngerei</option><option value="Soldanesti">Soldanesti</option><option value="Soroca">Soroca</option><option value="Stinga Nistrului">Stinga Nistrului</option><option value="Straseni">Straseni</option><option value="Taraclia">Taraclia</option><option value="Teleneşti">Teleneşti</option><option value="Ungheni">Ungheni</option><option value="Unitatea Teritoriala din Stinga Nistrului">Unitatea Teritoriala din Stinga Nistrului</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Libya"){ var str=state_selected; str=str+'<option value="Al Butnan">Al Butnan</option><option value="Al Jabal al Akhdar">Al Jabal al Akhdar</option><option value="Al Jafarah">Al Jafarah</option><option value="Al Jufrah">Al Jufrah</option><option value="Al Kufrah">Al Kufrah</option><option value="Al Marj">Al Marj</option><option value="Al Marqab">Al Marqab</option><option value="Al Wahat">Al Wahat</option><option value="An Nuqat al Khams">An Nuqat al Khams</option><option value="Az Zawiyah">Az Zawiyah</option><option value="Banghazi">Banghazi</option><option value="Darnah">Darnah</option><option value="Ghat">Ghat</option><option value="Jabal al Gharbi">Jabal al Gharbi</option><option value="Misratah">Misratah</option><option value="Murzuq">Murzuq</option><option value="Nalut">Nalut</option><option value="Sabha">Sabha</option><option value="Shabiyat al Butnan">Shabiyat al Butnan</option><option value="Shabiyat al Jafarah">Shabiyat al Jafarah</option><option value="Shabiyat al Wahat">Shabiyat al Wahat</option><option value="Shabiyat an Nuqat al Khams">Shabiyat an Nuqat al Khams</option><option value="Shabiyat az Zawiyah">Shabiyat az Zawiyah</option><option value="Shabiyat Banghazi">Shabiyat Banghazi</option><option value="Shabiyat Ghat">Shabiyat Ghat</option><option value="Shabiyat Misratah">Shabiyat Misratah</option><option value="Shabiyat Sabha">Shabiyat Sabha</option><option value="Shabiyat Wadi al Hayat">Shabiyat Wadi al Hayat</option><option value="Shabiyat Wadi ash Shati">Shabiyat Wadi ash Shati</option><option value="Sha`biyat Nalut">Sha`biyat Nalut</option><option value="Surt">Surt</option><option value="Tarhunah">Tarhunah</option><option value="Tripoli">Tripoli</option><option value="Wadi al Hayat">Wadi al Hayat</option><option value="Wadi ash Shati">Wadi ash Shati</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Iran, Islamic Republic of"){ var str=state_selected; str=str+'<option value="Alborz">Alborz</option><option value="Ardabil">Ardabil</option><option value="Azarbayjan-e Bakhtari">Azarbayjan-e Bakhtari</option><option value="Bakhtaran">Bakhtaran</option><option value="Bushehr">Bushehr</option><option value="Chahar Mahall va Bakhtiari">Chahar Mahall va Bakhtiari</option><option value="Chaharmahal and Bakhtiari">Chaharmahal and Bakhtiari</option><option value="East Azarbaijan">East Azarbaijan</option><option value="East Azerbaijan">East Azerbaijan</option><option value="Esfahan">Esfahan</option><option value="Fars">Fars</option><option value="Gilan">Gilan</option><option value="Golestan">Golestan</option><option value="Hamadan">Hamadan</option><option value="Hormozgan">Hormozgan</option><option value="Ilam">Ilam</option><option value="Ilam Province">Ilam Province</option><option value="Isfahan">Isfahan</option><option value="Kerman">Kerman</option><option value="Khorasan">Khorasan</option><option value="Khorasan-e Janubi">Khorasan-e Janubi</option><option value="Khorasan-e Razavi">Khorasan-e Razavi</option><option value="Khorasan-e Shemali">Khorasan-e Shemali</option><option value="Khuzestan">Khuzestan</option><option value="Kohkiluyeh va Buyer Ahmadi">Kohkiluyeh va Buyer Ahmadi</option><option value="Kordestan">Kordestan</option><option value="Lorestan">Lorestan</option><option value="Markazi">Markazi</option><option value="Mazandaran">Mazandaran</option><option value="Ostan-e Ardabil">Ostan-e Ardabil</option><option value="Ostan-e Azarbayjan-e Gharbi">Ostan-e Azarbayjan-e Gharbi</option><option value="Ostan-e Chahar Mahal va Bakhtiari">Ostan-e Chahar Mahal va Bakhtiari</option><option value="Ostan-e Esfahan">Ostan-e Esfahan</option><option value="Ostan-e Gilan">Ostan-e Gilan</option><option value="Ostan-e Golestan">Ostan-e Golestan</option><option value="Ostan-e Hamadan">Ostan-e Hamadan</option><option value="Ostan-e Ilam">Ostan-e Ilam</option><option value="Ostan-e Kermanshah">Ostan-e Kermanshah</option><option value="Ostan-e Khorasan-e Jonubi">Ostan-e Khorasan-e Jonubi</option><option value="Ostan-e Khorasan-e Shomali">Ostan-e Khorasan-e Shomali</option><option value="Ostan-e Khuzestan">Ostan-e Khuzestan</option><option value="Ostan-e Kohgiluyeh va Bowyer Ahmad">Ostan-e Kohgiluyeh va Bowyer Ahmad</option><option value="Ostan-e Kordestan">Ostan-e Kordestan</option><option value="Ostan-e Lorestan">Ostan-e Lorestan</option><option value="Ostan-e Qazvin">Ostan-e Qazvin</option><option value="Ostan-e Tehran">Ostan-e Tehran</option><option value="Qazvin">Qazvin</option><option value="Qom">Qom</option><option value="Razavi Khorasan">Razavi Khorasan</option><option value="Semnan">Semnan</option><option value="Semnan Province">Semnan Province</option><option value="Sistan and Baluchestan">Sistan and Baluchestan</option><option value="Sistan va Baluchestan">Sistan va Baluchestan</option><option value="Tehran">Tehran</option><option value="West Azerbaijan Province">West Azerbaijan Province</option><option value="Yazd">Yazd</option><option value="Zanjan">Zanjan</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Iraq"){ var str=state_selected; str=str+'<option value="Al Anbar">Al Anbar</option><option value="Al Basrah">Al Basrah</option><option value="An Najaf">An Najaf</option><option value="Anbar">Anbar</option><option value="Arbil">Arbil</option><option value="As Sulaymaniyah">As Sulaymaniyah</option><option value="At Tamim">At Tamim</option><option value="Babil">Babil</option><option value="Baghdad">Baghdad</option><option value="Basra">Basra</option><option value="Basra Governorate">Basra Governorate</option><option value="Dahuk">Dahuk</option><option value="Dhi Qar">Dhi Qar</option><option value="Dihok">Dihok</option><option value="Diyala">Diyala</option><option value="Karbala">Karbala</option><option value="Kirkuk">Kirkuk</option><option value="Mayorality of Baghdad">Mayorality of Baghdad</option><option value="Maysan">Maysan</option><option value="Muhafazat al Muthanna">Muhafazat al Muthanna</option><option value="Muhafazat al Qadisiyah">Muhafazat al Qadisiyah</option><option value="Muhafazat Arbil">Muhafazat Arbil</option><option value="Muhafazat as Sulaymaniyah">Muhafazat as Sulaymaniyah</option><option value="Muhafazat Babil">Muhafazat Babil</option><option value="Muhafazat Karbala">Muhafazat Karbala</option><option value="Muhafazat Kirkuk">Muhafazat Kirkuk</option><option value="Muhafazat Ninawa">Muhafazat Ninawa</option><option value="Muhafazat Wasit">Muhafazat Wasit</option><option value="Ninawa">Ninawa</option><option value="Nineveh">Nineveh</option><option value="Salah ad Din">Salah ad Din</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Isle of Man"){ var str=state_selected; str=str+'<option value="Andreas">Andreas</option><option value="Ballabeg">Ballabeg</option><option value="Ballasalla">Ballasalla</option><option value="Bride">Bride</option><option value="Castletown">Castletown</option><option value="Colby">Colby</option><option value="Conchan">Conchan</option><option value="Crosby">Crosby</option><option value="Dalby">Dalby</option><option value="Derbyhaven">Derbyhaven</option><option value="Douglas">Douglas</option><option value="Foxdale">Foxdale</option><option value="Glen Maye">Glen Maye</option><option value="Laxey">Laxey</option><option value="Maughold">Maughold</option><option value="Onchan">Onchan</option><option value="Peel">Peel</option><option value="Port Erin">Port Erin</option><option value="Port Saint Mary">Port Saint Mary</option><option value="Port Soderick">Port Soderick</option><option value="Ramsey">Ramsey</option><option value="Saint Johns">Saint Johns</option><option value="Saint Marks">Saint Marks</option><option value="Santon">Santon</option><option value="Sulby">Sulby</option><option value="Union Mills">Union Mills</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Hong Kong, SAR China"){ var str=state_selected; str=str+'<option value="Central and Western District">Central and Western District</option><option value="Eastern">Eastern</option><option value="Islands District">Islands District</option><option value="Kowloon City">Kowloon City</option><option value="Kwai Tsing">Kwai Tsing</option><option value="Kwun Tong">Kwun Tong</option><option value="North">North</option><option value="Sai Kung District">Sai Kung District</option><option value="Sha Tin">Sha Tin</option><option value="Sham Shui Po">Sham Shui Po</option><option value="Southern">Southern</option><option value="Tai Po District">Tai Po District</option><option value="Tsuen Wan District">Tsuen Wan District</option><option value="Tuen Mun">Tuen Mun</option><option value="Wan Chai">Wan Chai</option><option value="Wanchai">Wanchai</option><option value="Wong Tai Sin">Wong Tai Sin</option><option value="Yau Tsim Mong">Yau Tsim Mong</option><option value="Yuen Long District">Yuen Long District</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Micronesia, Federated States of"){ var str=state_selected; str=str+'<option value="State of Chuuk">State of Chuuk</option><option value="State of Kosrae">State of Kosrae</option><option value="State of Pohnpei">State of Pohnpei</option><option value="State of Yap">State of Yap</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Côte dIvoire"){ var str=state_selected; str=str+'<option value="Abidjan">Abidjan</option><option value="Bas-Sassandra">Bas-Sassandra</option><option value="Comoe">Comoe</option><option value="Denguele">Denguele</option><option value="District des Montagnes">District des Montagnes</option><option value="Goh-Djiboua">Goh-Djiboua</option><option value="Haut-Sassandra">Haut-Sassandra</option><option value="Lacs">Lacs</option><option value="Lagunes">Lagunes</option><option value="Montagnes">Montagnes</option><option value="Sassandra-Marahoue">Sassandra-Marahoue</option><option value="Savanes">Savanes</option><option value="Vallee du Bandama">Vallee du Bandama</option><option value="Woroba">Woroba</option><option value="Yamoussoukro Autonomous District">Yamoussoukro Autonomous District</option><option value="Zanzan">Zanzan</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Congo (Brazzaville)"){ var str=state_selected; str=str+'<option value="Bouenza">Bouenza</option><option value="Brazzaville">Brazzaville</option><option value="Cuvette-Ouest">Cuvette-Ouest</option><option value="Kouilou">Kouilou</option><option value="Lékoumou">Lékoumou</option><option value="Likouala">Likouala</option><option value="Niari">Niari</option><option value="Plateaux">Plateaux</option><option value="Pointe-Noire">Pointe-Noire</option><option value="Pool">Pool</option><option value="Sangha">Sangha</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Congo, (Kinshasa)"){ var str=state_selected; str=str+'<option value="Bandundu Province">Bandundu Province</option><option value="Bas Uele">Bas Uele</option><option value="Bas-Congo">Bas-Congo</option><option value="Bas-Uele">Bas-Uele</option><option value="Équateur">Équateur</option><option value="Haut Uele">Haut Uele</option><option value="Haut-Katanga">Haut-Katanga</option><option value="Haut-Uele">Haut-Uele</option><option value="Ituri">Ituri</option><option value="Kasai">Kasai</option><option value="Kasaï-Oriental">Kasaï-Oriental</option><option value="Katanga">Katanga</option><option value="Katanga Province">Katanga Province</option><option value="Kinshasa City">Kinshasa City</option><option value="Kwango">Kwango</option><option value="Kwilu">Kwilu</option><option value="Lomami">Lomami</option><option value="Lualaba">Lualaba</option><option value="Mai Ndombe">Mai Ndombe</option><option value="Mai-Ndombe">Mai-Ndombe</option><option value="Maniema">Maniema</option><option value="Nord Kivu">Nord Kivu</option><option value="Province du Haut-Katanga">Province du Haut-Katanga</option><option value="Province du Nord-Ubangi">Province du Nord-Ubangi</option><option value="Province du Sud-Ubangi">Province du Sud-Ubangi</option><option value="South Kivu Province">South Kivu Province</option><option value="Sud-Ubangi">Sud-Ubangi</option><option value="Tanganika">Tanganika</option><option value="Tanganyika">Tanganyika</option><option value="Tshopo">Tshopo</option><option value="Tshuapa">Tshuapa</option><option value="Upper Katanga">Upper Katanga</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="Saint-Barthélemy"){ var str=state_selected; str=str+'<option value="Grand Cul-de-Sac">Grand Cul-de-Sac</option><option value="Gustavia">Gustavia</option><option value="Toiny">Toiny</option>'; str=str+state_selected2; html_input(str);} 
		else if(objValue==="ALA Aland Islands"){ var str=state_selected; str=str+'<option value="Alands landsbygd">Alands landsbygd</option><option value="Finstroem">Finstroem</option><option value="Lemland">Lemland</option><option value="Mariehamns stad">Mariehamns stad</option><option value="Saltvik">Saltvik</option>'; str=str+state_selected2; html_input(str);} 

	});
	
	$('#country_list option[value="<?=$post['country_three']?>"]').prop('selected','selected');
	$('#country_list').trigger('change');
	
	
	if($('input[id="state_list"]')){
		$('#state_list').val("<?=$post['state_two']?>");
	}else{
		$('#state_list option[value="<?=$post['state_two']?>"]').prop('selected','selected');
	} 
	
	<? if(isset($data['paylinkurl'])&&$data['paylinkurl']=='payme'&&isset($post['bill_state'])&&$post['bill_state']){?>
		$('#state_input_divid').html('<input placeholder="State" type="text" id="state_list" name="bill_state" class="form-control"  value="<?=prntext($post['bill_state']);?>" >');
	<? } ?>
	
	function validateThisForm(e){
		if(e.fullname.value==""){
			 alert('Please Enter the Your Full Name');
			 e.fullname.focus();
			 return false;
		}else if(e.bill_phone.value==""){
			 alert('Please Enter the Your Phone No.');
			 e.bill_phone.focus();
			 return false;
		}else if(e.email.value==""){
			 alert('Please Enter the Your Email ID');
			 e.email.focus();
			 return false;
		}else if(e.bill_country.value==""){
			 alert('Please Select the Country');
			  e.bill_country.focus();
			 return false;
		}else if(e.bill_state.value==""){
			 alert('Please Select/Enter the State Name');
			 e.bill_state.focus();
			 return false;
		}else if(e.bill_zip.value==""){
			 alert('Please Enter the Zipcode');
			 e.bill_zip.focus();
			 return false;
		}
		
		if (e.checkValidity() == false){
			return false;
		}else{
		   // alert("submit");
			$('#modalpopup_form_popup').slideDown(900);
			return true;
		}
		e.preventDefault();
	}
	
	</script>
	
<? if(!isset($post['bill_city'])||empty($post['bill_city'])){?>
<div class="ecol4 col-sm-12 my-1">
<input placeholder="City" type="text" name="bill_city" class="form-control" value="<?=prntext($post['bill_city']);?>" title="Enter your bill city" data-bs-toggle="tooltip" data-bs-placement="bottom">
</div>
<? }else{ ?>
<input placeholder="City" type="hidden" name="bill_city" value="<?=prntext($post['bill_city']);?>">
<? } ?>
						  
<? if(!isset($post['bill_zip'])||empty($post['bill_zip'])){?>
<div class="ecol4 col-sm-12 my-1">
<input placeholder='Zip' type='text' name="bill_zip" class="form-control" value="<?=prntext($post['bill_zip']);?>" title="Enter your zip code" data-bs-toggle="tooltip" data-bs-placement="bottom" >
</div>
<? }else{ ?>
<input placeholder='Zip' type='hidden' name="bill_zip"  value="<?=prntext($post['bill_zip']);?>" >
<? } ?>


                          <div class="ecol2 col-sm-12 my-1"> </div>
                          <div style="display:none;">
                            <? if(isset($post['ccno'])){?>
                            <input type="hidden" name="ccno"  value="<?=prntext($post['ccno']);?>" />
                            <? } ?>
                            <? if(isset($post['month'])){?>
                            <input type="hidden" name="month" value="<?=prntext($post['month']);?>" />
                            <? } ?>
                            <? if(isset($post['year'])){?>
                            <input type="hidden" name="year" value="<?=prntext($post['year']);?>" />
                            <? } ?>
                            <? if(isset($post['ccvv'])){?>
                            <input type="hidden" name="ccvv" value="<?=prntext($post['ccvv']);?>" />
                            <? } ?>
                            <? if(isset($post['notes'])){?>
                            <input type="hidden" name="notes" value="<?=prntext($post['notes']);?>" />
                            <? } ?>
                          </div>
                        </div>
						
						</div>
                   

                      <div class="capc text-center my-2"><button id="cardsend_submit" type="submit" name="cardsend" value="CHECKOUT"  class="submit btn btn-icon btn-primary w-100 my-2"><i class="<?=$data['fwicon']['check-circle'];?>"></i> <b class="contitxt">Continue</b></button></div>

                </div>
              </form>
              <? } ?>
            
<? } elseif($post['step']==2){?>
<?php /*?><div class="row border rounded 44 bg-vdark m-2 text-start vkg">
		       <h4 class="row my-2 text-start">Billing Address:</h4> 
		<p class="text-white p-1">		
				
					
					<?if((isset($post['fullname']))&&($post['fullname'])){?>
						<?=($post['fullname']);?>
					<?}else{?>
						<?=(isset($post['bill_name'])&&$post['bill_name']?prntext($post['bill_name']).', ':' ');?>
					<?}?>
					<?
					if(!isset($post['bill_full_address'])) $post['bill_full_address']='';

					$post['bill_full_address'].=(isset($post['bill_address'])&&$post['bill_address']?prntext($post['bill_address']).', ':' ');?>
					<? $post['bill_full_address'].=(isset($post['bill_city'])&&$post['bill_city']?prntext($post['bill_city']).', ':' ');?>
					<? $post['bill_full_address'].=(isset($post['bill_state'])&&$post['bill_state']?prntext($post['bill_state']).', ':' ');?>
					
					

					<?=($post['bill_full_address']?prntext($post['bill_full_address']).'':' ');?>
					<?=(isset($post['country_two'])&&$post['country_two']?''.prntext($post['country_two']).' ':' ');?>
					<?=(isset($post['bill_zip'])&&$post['bill_zip']?' - '.prntext($post['bill_zip']).', ':' ');?>
					<?=(isset($post['bill_phone'])&&$post['bill_phone']?'Ph.: '.$post['bill_phone'].', ':' ');?>
					<?=(isset($post['email'])&&$post['email']?'Email: '.$post['email'].'':'');?>
					</p>		
		</div><?php */?>	
<? } ?>
				
		 
    
<? if($post['step']==2){?>		 
            
			  <div> 
			  
			  <? if(isset($_SESSION['merchant_logo'])&&$_SESSION['merchant_logo']){?>
            <div class="merchantLogo text-center mt-1"> <img src="<?=($_SESSION['merchant_logo']);?>" class="img-fluid" alt="Logo" style="max-height:50px;"  /> </div>
            
			<? }elseif(isset($data['ADMIN_LOGO'])&&$data['ADMIN_LOGO']){ ?>
				<div class="merchantLogo text-center mt-1"> <img 222 src="<?=encode_imgf($data['ADMIN_LOGO']);?>"  class="img-fluid" alt="Logo" style="max-height:50px;" /> </div>
				
			<? }elseif(isset($_SESSION['domain_server']['LOGO'])&&$_SESSION['domain_server']['LOGO']){ ?>
				<div class="merchantLogo text-center mt-1"> <img 333 src="<?=($_SESSION['domain_server']['LOGO']);?>"  class="img-fluid" alt="Logo" style="max-height:50px;" /> </div>
			<? } ?>
<? if(isset($post['product'])&&$post['product']){ ?>			
<p class="text-center fw-bold my-2" style="font-size:16px;">Payment for <?=prntext($post['product'])?></p>
<? } ?>	
			  
			  <div class="payment_option">
                  <? $currency_smbl=get_currency($_SESSION['curr']);?>
                 <?php /*?> <a class="change text-decoration-none hide text-start btn btn-primary my-2" id="paymentMethodChange" style="display: none;"><i class="<?=$data['fwicon']['circle-left'];?> mx-2"></i> Change Payment Method 22</a><?php */?>
				 
				 <a class="change hide" id="paymentMethodChange" style="display: none; float:right;"><i class="<?=$data['fwicon']['circle-left'];?> mx-2" title="Change Payment Method" data-bs-toggle="tooltip" data-bs-placement="left"></i></a>
				  
                  <h4 class="avai_h4 btn btn-sm btn-primary my-2 text-center w-100">How would you like to pay?<span id='result_view_chk' class='result_view'></span> <span id='result_view' class='result_view'> </span></h4>
                  <? if(!empty($post['nick_name_check'])){ ?>
                  <div class="cname" >
                    <div class="inputgroup">
                      <? foreach($_SESSION['AccountInfo'] as $key=>$value){if(($value['nick_name']) &&  (strpos($data['t'][$value['nick_name']]['name2'],'Check') !== false) && (in_array($value['nick_name'],$post['nick_name_check_arr'])) && ($value['account_login_url']!="3")  ){
		   if(!empty($value['processing_currency'])){$pc=explode(' ',$value['processing_currency']);$pcrcy=$pc[0];}else{$pcrcy="$";}
		   if(isset($_SESSION['curr'])&&$_SESSION['curr']){$pcrcy=$currency_smbl;}else{$pcrcy=$_SESSION['curr_tr_sys'];}
		?>
                      <div class="inputype">
                        <input type="radio" value="<?=$value['nick_name']?>" id="<?=$value['nick_name']?>" required name="account_types" class="account_types" data-value="<?=$value['nick_name']?>" data-name="echeck" data-currency="<?=$pcrcy;?>" />
                        <label for="<?=$value['nick_name']?>">
                        <? if(isset($value['checkout_level_name'])&&$value['checkout_level_name']){echo $value['checkout_level_name'];}else{?>
                        Pay by Check
                        <? } ?>
                        </label>
                      </div>
                      <? }} ?>
                    </div>
                  </div>
                  <? } ?>
                  <? 
	  if(isset($post['nick_name_card'])&&!empty($post['nick_name_card'])){?>
                  <div class="cname cardDiv">
                    <div class="inputgroup">
		<?
		
		$outputArray_1 = array();
		
		foreach($_SESSION['AccountInfo'] as $key=>$value){if((isset($value['nick_name'])&&$value['nick_name']) && isset($data['t'][$value['nick_name']]['name2']) && (strpos($data['t'][$value['nick_name']]['name2'],'Card') !== false) && (in_array($value['nick_name'],$post['nick_name_card_arr'])) && ($value['account_login_url']!="3") && ($_SESSION['b_'.$value['nick_name']]['bg_active']>0)  && (!in_array($value['nick_name'],$outputArray_1)) ) {
		  
			$outputArray_1[] = $value['nick_name'];

			
		   //if($_SESSION['curr']){$pcrcy=$currency_smbl;}else{$pcrcy=$pcrcy;}
		   if(isset($_SESSION['curr'])&&$_SESSION['curr']){$pcrcy=$currency_smbl;}else{$pcrcy=$_SESSION['curr_tr_sys'];}
		?>
			<div class="inputype the_icon <?=countryCodeMatch2($post['country_two'],(isset($_SESSION["b_".$value['nick_name']]['countries'])?$_SESSION["b_".$value['nick_name']]['countries']:''),(isset($_SESSION["b_".$value['nick_name']]['countryCode'])?$_SESSION["b_".$value['nick_name']]['countryCode']:''),isset($_SESSION["b_".$value['nick_name']]['donotmachcountries'])?$_SESSION["b_".$value['nick_name']]['donotmachcountries']:'')?> box-shadow my-1 w-100">
			<input type="radio" value="<?=(isset($value['nick_name'])?$value['nick_name']:'');?>" id="<?=(isset($value['nick_name'])?$value['nick_name']:'');?>" required name="account_types" class="account_types" data-value="<?=(isset($value['nick_name'])?$value['nick_name']:'');?>" data-name="ecard" data-ccn="<?=(isset($_SESSION['b_'.$value['nick_name']]['account_custom_field_14'])?$_SESSION['b_'.$value['nick_name']]['account_custom_field_14']:'')?>" data-currency="<?=$pcrcy;?>" data-ewlist="<?=(isset($data['t'][$value['nick_name']]['name6']))?$data['t'][$value['nick_name']]['name6']:'';?>"  data-etype="<?=(isset($data['t'][$value['nick_name']]['name4']))?$data['t'][$value['nick_name']]['name4']:'';?>"  data-count='<? if(isset($_SESSION["b_".$value['nick_name']]['deCon'])) echo $_SESSION["b_".$value['nick_name']]['deCon'];?>' data-dnmc='<? if(isset($_SESSION["b_".$value['nick_name']]['donotmachcountries'])) echo $_SESSION["b_".$value['nick_name']]['donotmachcountries'];?>' style="display:none;" />
                        <label for="<?=$value['nick_name']?>">
						<p class="text-center"><strong class="align-middle">
						<span class=" float-start align-middle" style=""><i class="<?=$data['fwicon']['credit-card'];?> "></i></span>
                        <? if(isset($value['checkout_level_name'])&&$value['checkout_level_name']){ echo $value['checkout_level_name'];}else{?>
                        Pay by Card [
                        <?=(isset($_SESSION['curr_transaction_amount'])?$_SESSION['curr_transaction_amount']:'');?>
                        ]
                        <? } ?> 
				<!--change image to icon by vikash on 20122022-->
				<span class=" float-end align-middle"  id="credit_cards" style="">
				<i class="<?=$data['fwicon']['visa_code'];?> text-info" title="visa" id="visa"></i>
				<i class="<?=$data['fwicon']['mastercard_code'];?> text-danger" title="mastercard" id="mastercard"></i>
				<i class="<?=$data['fwicon']['amex_code'];?> text-info" title="amex" id="amex"></i>
				<i class="<?=$data['fwicon']['jcb_code'];?> text-success" title="jcb" id="jcb"></i>
				<i class="<?=$data['fwicon']['discover_code'];?> text-secondary" title="discover" id="discover"></i>
				<img src="<?=$data['Host']?>/images/rupaycard.jpg" id="rupay" class="rounded" title="rupay" height="14px" 
				style="margin-bottom: 5px;" /> 
				<i class="<?=$data['fwicon']['angle-right'];?> ms-2"></i>
				</span>
								
								
								
								</strong>
						</p>
                        </label>
                      </div>
                      <? } } ?>
                      
                    </div>
                  </div>
                  <? } ?>
				<? if((isset($post['nick_name_ewallets'])&&!empty($post['nick_name_ewallets']))||(isset($post['nick_name_net_banking'])&&!empty($post['nick_name_net_banking']))){?>
				<div class="cname netBankEdiv">
					<div class="inputgroup">
					<? 
					$outputArray_2 = array();
					foreach($_SESSION['AccountInfo'] as $key=>$value){
						if((isset($value['nick_name'])&&$value['nick_name']) && isset($data['t'][$value['nick_name']]['name2']) && ((strpos($data['t'][$value['nick_name']]['name2'],'eWallets') !== false)||(isset($data['t'][$value['nick_name']]['name2']) && strpos($data['t'][$value['nick_name']]['name2'],'Banking') !== false)) && ( (in_array($value['nick_name'],@$post['nick_name_ewallets_arr']) ) || (in_array($value['nick_name'],$post['nick_name_net_banking_arr'])) ) && ($value['account_login_url']!="3") && (isset($_SESSION['b_'.$value['nick_name']]['bg_active'])&&$_SESSION['b_'.$value['nick_name']]['bg_active']>0) && (!in_array($value['nick_name'],$outputArray_2)) ) {
					  
						$outputArray_2[] = $value['nick_name'];

						if(isset($_SESSION['curr'])&&$_SESSION['curr']){$pcrcy=$currency_smbl;}else{$pcrcy=$_SESSION['curr_tr_sys'];}
					  
					   
					   if(isset($value['account_login_url'])&&$value['account_login_url']==1){
				$dataname="ewallets"; 
				$data_ccn=''; 
			}
			elseif(isset($value['account_login_url'])&&$value['account_login_url']==2){
				$dataname="evoilatecard"; 
				$data_ccn='data-ccn="visa"';
			}
					?>
                      <div class="inputype <?=(isset($data['t'][$value['nick_name']]['logo'])?"the_icon":"")?> <?=countryCodeMatch2($post['country_two'],isset($_SESSION["b_".$value['nick_name']]['countries'])?$_SESSION["b_".$value['nick_name']]['countries']:'',isset($_SESSION["b_".$value['nick_name']]['countryCode'])?$_SESSION["b_".$value['nick_name']]['countryCode']:'',isset($_SESSION["b_".$value['nick_name']]['donotmachcountries'])?$_SESSION["b_".$value['nick_name']]['donotmachcountries']:'')?> box-shadow my-1 w-100">
                        <input type="radio" value="<?=(isset($value['nick_name'])?$value['nick_name']:'');?>" id="<?=(isset($value['nick_name'])?$value['nick_name']:'');?>" required name="account_types" class="account_types" data-value="<?=(isset($value['nick_name'])?$value['nick_name']:'');?>" data-name="<?=(isset($dataname)?$dataname:'');?>" data-currency="<?=$pcrcy;?>" data-ewlist="<?=(isset($data['t'][$value['nick_name']]['name6']))?$data['t'][$value['nick_name']]['name6']:'';?>" data-etype="<?=(isset($data['t'][$value['nick_name']]['name4']))?$data['t'][$value['nick_name']]['name4']:'';?>"  data-count='<?=(isset($_SESSION["b_".$value['nick_name']]['deCon'])?$_SESSION["b_".$value['nick_name']]['deCon']:'');?>' data-dnmc='<? if(isset($_SESSION["b_".$value['nick_name']]['donotmachcountries'])) echo $_SESSION["b_".$value['nick_name']]['donotmachcountries'];?>' style="display:none;" <?=(isset($data_ccn)?$data_ccn:'');?> />
                        <label for="<?=(isset($value['nick_name'])?$value['nick_name']:'');?>" class="text-center">
                        
                        
                        <strong class="align-middle">
						<span class="float-start align-middle icon_the_pay">
						<? if($value['checkout_level_name']=="UPI Wallets"){ 
						echo '<i class="'.$data['fwicon']['wallet_code'].' text-dark" title="UPI Wallets"></i>';
						}elseif(strstr($value['checkout_level_name'],"Net Banking")){ 
						echo '<i class="'.$data['fwicon']['net_banking'].' text-info" title="Net Banking"></i>';
						}else{ 
						
						?>
						<img src="<?=$data['Host']?>/images/<?=$data['t'][$value['nick_name']]['logo'];?>_logo.png" title="<?=$value['checkout_level_name'];?>"  />
						<? } ?>
						</span>
						
						<? if(isset($value['checkout_level_name'])&&$value['checkout_level_name']){echo $value['checkout_level_name'];}else{?>
                        Pay with eWallets [ <?=(isset($_SESSION['curr_transaction_amount'])?$_SESSION['curr_transaction_amount']:'');?> ]
                        
                        <? } ?>
						
						<span class=" float-end align-middle" style="">
								<i class="<?=$data['fwicon']['angle-right'];?> ms-2"></i></span></strong>
                        </label>
                      </div>
                      <? }} ?>
                    </div>
                  </div>
                  <? } ?>
                  <? if(isset($post['nick_name_upi'])&&!empty($post['nick_name_upi'])){?>
                  <div class="cname upiDiv">
                    <div class="inputgroup">
                      <? 
					$outputArray_3 = array();
					foreach($_SESSION['AccountInfo'] as $key=>$value){if(isset($value['nick_name']) &&($value['nick_name']) && isset($data['t'][$value['nick_name']]['name2']) && (strpos($data['t'][$value['nick_name']]['name2'],'UPI') !== false) && (in_array($value['nick_name'],$post['nick_name_upi_arr'])) && ($value['account_login_url']!="3")  && (!in_array($value['nick_name'],$outputArray_3)) ) {
					
					$outputArray_3[] = $value['nick_name'];
					
					if(isset($_SESSION['curr'])&&$_SESSION['curr']){$pcrcy=$currency_smbl;}else{$pcrcy=$_SESSION['curr_tr_sys'];}
					
					
					if(isset($value['account_login_url'])&&$value['account_login_url']=="1"){$dataname="bhimupi"; }
		   elseif(isset($value['account_login_url'])&&$value['account_login_url']=="2"){$dataname="evoilatecard"; }
		?>
                      <div class="inputype">
                        <input type="radio" value="<?=(isset($value['nick_name'])?$value['nick_name']:'');?>" id="<?=(isset($value['nick_name'])?$value['nick_name']:'');?>" required name="account_types" class="account_types" data-value="<?=(isset($value['nick_name'])?$value['nick_name']:'');?>" data-name="<?=(isset($dataname)?$dataname:'');?>" data-currency="<?=$pcrcy;?>" />
                        <label for="<?=(isset($value['nick_name'])?$value['nick_name']:'');?>" >
                        <? if(isset($value['checkout_level_name'])&&$value['checkout_level_name']){echo $value['checkout_level_name'];}else{?>
                        Pay with Bhim UPI [
                        <?=(isset($_SESSION['curr_transaction_amount'])?$_SESSION['curr_transaction_amount']:'');?>
                        ]
                        <? } ?>
                        </label>
                      </div>
                      <? }} ?>
                    </div>
                  </div>
                  <? } ?>
                  <? if(((!empty($post['nick_name_ewallets']))||(!empty($post['nick_name_net_banking'])))&&(!isset($_SESSION['mISO2']))){?>
<div id="otherPaymentMethod" class="text-white"> 
<a class="change hide" id="otherPaymentMethodLink" style="display: block;color: var(--color-1)!important;">
<i class="<?=$data['fwicon']['credit-card'];?> mx-2"></i> All Other Payment Method</a> <a class="change hide" id="goBackPaymentMethodLink" style="display: none;color: var(--color-1)!important;"><i class="<?=$data['fwicon']['circle-left'];?> mx-2"></i> Go Back</a> </div>
                  <? } ?>
				  
				  
                </div>
                <? if(isset($post['nick_name_check'])&&!empty($post['nick_name_check'])){?>
                <div class="echeck_div pay_div row mx-2">
<form id="zts-echeck" method="post" action="<?=$data['Host'];?>/echeckprocess<?=$data['ex']?>" onSubmit="return validateForm(this);">
                    <div class="ecol2">
                      <div style="display:none">
                        <input type="hidden" name="type" value="">
						<input type="hidden" name="gid" value="<?=(isset($_SESSION['owner'])?$_SESSION['owner']:'');?>"/>
						<input type="hidden" name="bid" value="<?=(isset($post['bid'])?$post['bid']:'')?>"/>
						<input type="hidden" name="store_id" value="<?=(isset($post['store_id'])?$post['store_id']:'');?>"/>
						<input type="hidden" name="api_token" value="<?=(isset($post['api_token'])?$post['api_token']:'');?>"/>
						<input type="hidden" name="bill_country_name" id="bill_country_name" value="<?=(isset($post['bill_country_name'])?$post['bill_country_name']:'');?>"/>
						<input type="hidden" name="purchaser_fullname" value="<?=(isset($post['ccholder'])?$post['ccholder']:'');?>"/>
						<input type="hidden" name="purchaser_firstname" value="<?=(isset($post['ccholder'])?$post['ccholder']:'');?>"/>
						<input type="hidden" name="purchaser_lastname" value="<?=(isset($post['ccholder_lname'])?$post['ccholder_lname']:'');?>"/>
						<input type="hidden" name="transaction_amount" value="<?=(isset($post['total'])?prnsumm($post['total']):'');?>"/>
						<input type="hidden" name="purchaser_email" value="<?=(isset($post['email'])?$post['email']:'');?>"/>
						<input type="hidden" name="purchaser_address" value="<?=(isset($post['bill_address'])?$post['bill_address']:'')?>"/>
						<input type="hidden" name="purchaser_city" value="<?=(isset($post['bill_city'])?$post['bill_city']:'');?>"/>
						<input type="hidden" name="purchaser_state" value="<?=(isset($post['bill_state'])?$post['bill_state']:'');?>"/>
						<input type="hidden" name="purchaser_country" value="<?=(isset($post['bill_country'])?$post['bill_country']:'');?>"/>
						<input type="hidden" name="purchaser_zipcode" value="<?=(isset($post['bill_zip'])?$post['bill_zip']:'');?>"/>
						<input type="hidden" name="purchaser_phone" value="<?=(isset($post['bill_phone'])?$post['bill_phone']:'');?>"/>
						<input type="hidden" name="bank_phone" id="bank_phone" value="<?=(isset($post['bank_phone'])?$post['bank_phone']:'');?>"/>
						<input type="hidden" name="source" value="<?=(isset($post['source'])?$post['source']:'');?>"/>
                        <input type="hidden" name="memo" value="<?=$data['SiteName']?>*<?=$_SESSION['descriptor']?>"/>
                      </div>
                      <div class="separator"></div>
                      <input type="text" name="purchaser_account" id="purchaser_account"  placeholder="Account No.*" class="form-control" value="<?=(isset($post['purchaser_account'])?prntext($post['purchaser_account']):'');?>" required />
                      <div class="separator"></div>
                      <input type="text" name="purchaser_echecknumber" id="purchaser_echecknumber" placeholder="Check No.*" class="form-control" value="<?=(isset($post['purchaser_echecknumber'])?prntext($post['purchaser_echecknumber']):'');?>" required />
                      <div class="separator"></div>
                      <input type="text" name="bank_name" id="bank_name" placeholder="Bank Name*" class="form-control" value="<?=(isset($post['bank_name'])?prntext($post['bank_name']):'');?>" required />
                      <div class="separator"></div>
                      <input type="text" name="bank_address" id="bank_address"  placeholder="Bank Address*" class="form-control" value="<?=(isset($post['bank_address'])?prntext($post['bank_address']):'');?>"/>
                      <div class="separator"></div>
                      <input type="text" name="bank_city" id="bank_city"  placeholder="Bank City*" class="form-control" value="<?=(isset($post['bank_city'])?prntext($post['bank_city']):'');?>" required  />
                    </div>
                    <div class="ecol2">
                      <div class="separator"></div>
                      <input type="text" pattern="[0-9]{9}" name="purchaser_routing" id="purchaser_routing"   placeholder="Bank ABA No.*" class="form-control" value="<?=(isset($post['purchaser_routing'])?prntext($post['purchaser_routing']):'');?>" required  />
                      <div class="separator"></div>
                      <select name="bank_state" id="bank_state" class="feed_input1 form-select" placeholder="Select Bank State" >
                        <? if(isset($post['bank_state'])&&$post['bank_state']){?>
                        <option value="<?=prntext($post['bank_state'])?>" selected>
                        <?=prntext($post['bank_state'])?>
                        </option>
                        <? } ?>
                        <option value="" disabled>--Select Bank State*--</option>
                        <option value="AL-Alabama">Alabama</option>
                        <option value="AK-Alaska">Alaska</option>
                        <option value="AZ-Arizona">Arizona</option>
                        <option value="AR-Arkansas">Arkansas</option>
                        <option value="CA-California">California</option>
                        <option value="CO-Colorado">Colorado</option>
                        <option value="CT-Connecticut">Connecticut</option>
                        <option value="DE-Delaware">Delaware</option>
                        <option value="DC-District Of Columbia">District Of Columbia</option>
                        <option value="FL-Florida">Florida</option>
                        <option value="GA-Georgia">Georgia</option>
                        <option value="HI-Hawaii">Hawaii</option>
                        <option value="ID-Idaho">Idaho</option>
                        <option value="IL-Illinois">Illinois</option>
                        <option value="IN-Indiana">Indiana</option>
                        <option value="IA-Iowa">Iowa</option>
                        <option value="KS-Kansas">Kansas</option>
                        <option value="KY-Kentucky">Kentucky</option>
                        <option value="LA-Louisiana">Louisiana</option>
                        <option value="ME-Maine">Maine</option>
                        <option value="MD-Maryland">Maryland</option>
                        <option value="MA-Massachusetts">Massachusetts</option>
                        <option value="MI-Michigan">Michigan</option>
                        <option value="MN-Minnesota">Minnesota</option>
                        <option value="MS-Mississippi">Mississippi</option>
                        <option value="MO-Missouri">Missouri</option>
                        <option value="MT-Montana">Montana</option>
                        <option value="NE-Nebraska">Nebraska</option>
                        <option value="NV-Nevada">Nevada</option>
                        <option value="NH-New Hampshire">New Hampshire</option>
                        <option value="NJ-New Jersey">New Jersey</option>
                        <option value="NM-New Mexico">New Mexico</option>
                        <option value="NY-New York">New York</option>
                        <option value="NC-North Carolina">North Carolina</option>
                        <option value="ND-North Dakota">North Dakota</option>
                        <option value="OH-Ohio">Ohio</option>
                        <option value="OK-Oklahoma">Oklahoma</option>
                        <option value="OR-Oregon">Oregon</option>
                        <option value="PA-Pennsylvania">Pennsylvania</option>
                        <option value="RI-Rhode Island">Rhode Island</option>
                        <option value="SC-South Carolina">South Carolina</option>
                        <option value="SD-South Dakota">South Dakota</option>
                        <option value="TN-Tennessee">Tennessee</option>
                        <option value="TX-Texas">Texas</option>
                        <option value="UT-Utah">Utah</option>
                        <option value="VT-Vermont">Vermont</option>
                        <option value="VA-Virginia">Virginia</option>
                        <option value="WA-Washington">Washington</option>
                        <option value="WV-West Virginia">West Virginia</option>
                        <option value="WI-Wisconsin">Wisconsin</option>
                        <option value="WY-Wyoming">Wyoming</option>
                      </select>
                      <div class="separator"></div>
                      <input type="text" name="bank_zipcode" id="bank_zipcode"  pattern="[0-9]{4,5}" placeholder="Bank Zip*" class="form-control" value="<?=(isset($post['bank_zipcode'])?prntext($post['bank_zipcode']):'');?>" required  />
                      <div class="separator"></div>
<textarea class="form-control" name="comments" placeholder="Note" style="height:75px;"><?=(isset($post['notes'])?prntext($post['notes']):'');?></textarea>
                    </div>
					<div style="clear:both"></div>
                    <div class="submit_div text-center">
<button type="submit" name="change" value="CHANGE NOW!"  class="submitbtn btn btn-icon btn-primary my-2"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Continue </button>
                    </div>
</form>
                </div>
                <? } ?>
                <? 

			if(!isset($post['bill_country_name'])) $post['bill_country_name'] = '';
			if(!isset($post['payment'])) $post['payment'] = '';
			if(!isset($post['bill_fees'])) $post['bill_fees'] = '';
			if(!isset($post['bussiness_url'])) $post['bussiness_url'] = '';
			if(!isset($post['aurl'])) $post['aurl'] = '';
			if(!isset($post['source'])) $post['source'] = '';
			if(!isset($post['status_mem'])) $post['status_mem'] = '';
			
			$common_input ="
			<div style=display:none>
			<input type=hidden name=step value='".$post['step']."'>
			<input type=hidden name=email value='".$post['email']."'>
			<input type=hidden name=bill_address value='".$post['bill_address']."'>
			<input type=hidden name=bill_street_1 value='".$post['bill_street_1']."'>
			<input type=hidden name=bill_street_2 value='".$post['bill_street_2']."'>
			<input type=hidden name=bill_city value='".$post['bill_city']."'>
			<input type=hidden name=bill_state value='".$post['bill_state']."'>
			<input type=hidden name=bill_country value='".$post['bill_country']."'>
			<input type=hidden name=bill_country_name id=bill_country_name value='".$post['bill_country_name']."'>
			<input type=hidden name=bill_zip value='".$post['bill_zip']."'>
			<input type=hidden name=bill_phone value='".$post['bill_phone']."'>
			<input type=hidden name=payment_mode value='".$post['payment']."'>
			<input type=hidden name=bill_fees value='".$post['bill_fees']."'>
			<input type=hidden name=bussiness_url value='".$post['bussiness_url']."'>
			<input type=hidden name=status value='".($post['status_mem']?$post['status_mem']:$post['status'])."'>
			<input type=hidden name=source value='".trim($post['source'])."'>
			</div>"; 
			
			if(isset($post['fullname'])){
				$common_input .="
				<div style=display:none>
				<input type=hidden name=fullname value='".$post['fullname']."'>
				</div>"; 
			}
			
			
			if(isset($data['Error'])&&$data['Error']&&isset($post['submit'])){
				$display_style="style='display:block;'";
			}else {
				$display_style="style='display:none;'";
			}
			?>
                <? if((isset($post['nick_name_card'])&&!empty($post['nick_name_card'])) || (($post['nick_name']) && ($_SESSION['post']['ewallets_test_card']==true)  )){?>
                <div class="cover_pay_div" style="position:relative;">
                <div class="ecard_div evoilatecard_div pay_div">
					<form id="payment_form_id" method="post" onsubmit="return validateForm(this);">
                    <div style="display:none;">
                      <?=(isset($common_input)?$common_input:'');?>
                      <input type="hidden" name="midcard" value="" />
                      <input type="hidden" name="cardtype" id="cardtype" value="<? if(isset($post['cardtype'])) echo $post['cardtype']?>" />
                    </div>
                    <div class="credit-card-box">
                      <div class="flip">
                        <div class="front">
                         
							
                          <!--<div class="number">-->
                            
                            <div class="form-group my-2 input-icons-left99 inputWithIcon" id="card-number-field">
							<label for="Card Number" class="form-label">Card Number</label>
							<i id="input-card-icon" class="<?=$data['fwicon']['credit-card'];?> display-inner"></i>
                              <input id="number" type="tel" name="ccno" maxlength="19" size="30" placeholder="Card Number" value='<?=(isset($post['ccno'])&&$post['ccno'])?$post['ccno']:"";?>' class="iconvisa form-control form-control-sm" title="Card Number"  />
                            </div>
                            
                           
                          <!--</div>-->
						  <div class="form-group my-2">
							<label for="Card Number" class="form-label">Name</label>
							<div class="form-control form-control-sm" title="Card Holder Name"><?=(isset($post['fullname'])&&$post['fullname']?prntext($post['fullname']).'':'');?></div>
                            </div>
						  
						  
							
                          <div class="clearfix my-2">
						  
						    <div class="float-start" style="width:65px;">
							<label for="CVV" class="form-label">Expiry</label>
                           <select id="expMonth" name="month" class="form-select form-select-sm" required title="Select Month of Card Expiry" >
								<option value="" disabled="disabled" selected="selected">mm</option>
								<option value="01" title="Jan.">01</option>
								<option value="02" title="Feb.">02</option>
								<option value="03" title="Mar.">03</option>
								<option value="04" title="Apr.">04</option>
								<option value="05" title="May.">05</option>
								<option value="06" title="Jun.">06</option>
								<option value="07" title="Jul.">07</option>
								<option value="08" title="Aug.">08</option>
								<option value="09" title="Sept.">09</option>
								<option value="10" title="Oct.">10</option>
								<option value="11" title="Nov.">11</option>
								<option value="12" title="Dec.">12</option>
                            </select>
							<?
							if(isset($post['month'])&&$post['month'])
							{?>
							<script>
							$('#expMonth option[value="<?=$post['month']?>"]').prop('selected','selected');
							</script>
							<?
							}
							?>
							</div>
							<div class="float-start ps-1" style="width:65px;">
							<label for="CVV" class="form-label">&nbsp;&nbsp;</label>
                            <select id="expYear" name="year" class="form-select form-select-sm" required title="Select Year of Card Expiry">
                          <option value="" disabled="disabled"  selected="selected" >yy</option>
							<?
							for($yy = date('y');$yy<100;$yy++)
							{
							?><option value="<?=$yy?>"><?=$yy?></option><? } ?>
                            </select>
							<?
							if(isset($post['year'])&&$post['year'])
							{?>
							<script>
							$('#expYear option[value="<?=$post['year']?>"]').prop('selected','selected');
							</script>
							<?
							}?>
							</div>


                            <div class="CVV input-icons-right99 inputWithIcon" style="width:70px;float: right;">
							<label for="CVV" class="form-label">CVC <i class="<?=$data['fwicon']['question'];?>" style="font-size:12px;top: 6px;right: 20px;"  data-bs-toggle="tooltip" data-bs-original-title="Three digit CV code on the back of your card" data-bs-placement="left"></i></label>
							
                              <input id="cvc" type="password" name="ccvv" maxlength="4" size="30" placeholder="cvc" value="<?=(isset($post['ccvv'])&&$post['ccvv'])?$post['ccvv']:"";?>" class="form-control form-control-sm" required  title="Enter CVC of Credit Card No." >
                            <i class="<?=$data['fwicon']['credit-card'];?>"></i>
							</div>
							<!--$data['fwicon']['credit-card']-->
							
							
                          </div>
                          <?php /*?><div class="card-holder">
                            <!--<label>Card holder : </label>-->
                            <div class="mt-1"><span>Card Holder : </span>
                            <?=(isset($post['fullname'])&&$post['fullname']?prntext($post['fullname']).'':'');?>
                            </div>
                          </div><?php */?>
                        </div>
                      </div>
                    </div>
                    <div>
                      <!--<textarea name="notes" class="form-control" placeholder="Note"><? if(isset($post['notes'])) echo prntext($post['notes'])?></textarea>-->
                    </div>
                    <div class="hide error" id="form-input-errors" <? if(isset($display_style)) echo $display_style;?> >
                      <? if(isset($data['Error'])) echo prntext($data['Error'])?>
                    </div>
                    <div class="separator"></div>
                    <div style="clear:both"></div>
                    <div class="submit_div text-center">
                      <button id="cardsend_submit99" type="submit" name="send123" value="CHANGE NOW!" class="submitbtn btn btn-icon btn-primary w-100 my-2"><i class="<?=$data['fwicon']['check-circle'];?>"></i> <b class="contitxt">Complete Payment</b></button>
	<? 
	if(isset($_SESSION['action'])&&($_SESSION['action']=="vt" || $_SESSION['action']=="requestmoney")){?>
		<style>
			.submitbck, .submitbtn {width:100% !important;margin:5px 0 !important;}
		</style>
		<button type="button" value="BACK" onClick="javascript:goback();" class="submitbck back_button btn btn-icon btn-primary"><i class="<?=$data['fwicon']['back'];?>"></i> <b class="contitxt"> Back to Merchant Website</b></button>
    <?
	} else {?>
	<style> 
		/*#cardsend_submit i {display:none;}
		  #cardsend_submit{width:100%;margin:0;float:none;font-size:24px;}*//*padding:20px 0;
		*/
	</style>
	<? } ?>
	<script language="javascript" type="text/javascript"> 
	function goback(){	
		// Simulate a mouse click:
		window.location.href="<?=$data['Host'];?>/processall<?=$data['ex']?>?action=vt";
	}
	</script>
                    </div>
                  </form>
                </div>
				</div>
                <? } ?>
                <? if(isset($post['nick_name_ewallets'])&&(!empty($post['nick_name_ewallets']))||(isset($post['nick_name_net_banking'])&&!empty($post['nick_name_net_banking']))){?>
                <div class="ewallets_div pay_div">
                  <form id="payment_form_id_ewallets" method="post" onSubmit="return validateForm(this);">
                    <div class="ecol2" style="width:100%">
                      <div style="display:none">
                        <?=(isset($common_input)?$common_input:'');?>
						<input type="hidden" name="midcard" value="" />
                      </div>
                      <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'qqxx') !== false){?>
                      <div class="qiwi_div ewalist hide"> <img src="<?=$data['Host']?>/images/qiwi_logo.png" id="qiwi" style="display:block;margin: 5px auto;" /> </div>
                      <? } ?>
                      <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'emailEdit') !== false){?>
                      <div class="emailEdit_div ewalist hide">
                        <input type="text" name="email" class="w93p required" placeholder="RFC compliant email address of the account holder" title="RFC compliant email address of the account holder" value="<?=(isset($post['email'])?$post['email']:'');?>"/>
                      </div>
                      <? } ?>
                      <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'ibanInput') !== false){?>
                      <div class="ibanInput_div ewalist hide">
                        <input type="text" name="iban" class="w93p required" placeholder="Enter Valid IBAN" title="Enter Valid IBAN" value="<?=(isset($post['iban'])?$post['iban']:'');?>" data-required="required" />
                      </div>
                      <? } ?>
                      <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'bicInput') !== false){?>
                      <div class="bicInput_div ewalist hide">
                        <input type="text" name="bic" class="w93p" placeholder="Valid BIC (8 or 11 alphanumeric letters) of consumer’s bank" title="Valid BIC (8 or 11 alphanumeric letters) of consumer’s bank" value="<?=(isset($post['bic'])?$post['bic']:'');?>" />
                      </div>
                      <? } ?>
                      <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'nationalidInput') !== false){?>
                      <div class="nationalidInput_div ewalist hide">
                        <input type="text" name="nationalid" class="w93p required" placeholder="Consumer's national id" data-required="required" value="<?=(isset($post['nationalid'])&&$post['nationalid']?$post['nationalid']:"");?>" />
                      </div>
                      <? } ?>
                      <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'mobilephoneInput') !== false){?>
                      <div class="mobilephoneInput_div ewalist hide">
                        <input type="text" name="mobilephone" class="w93p required" placeholder="Valid international Russian mobile phone number identifying the QIWI destination account to pay" title="Valid international Russian mobile phone number identifying the QIWI destination account to pay out to (excluding plus sign or any other international prefixes, including a leading 7 for Russia, 11 digits in total, e.g. 71234567890)" data-required="required" value="<?=(isset($post['mobilephone'])&&$post['mobilephone']?$post['mobilephone']:(isset($post['bill_phone'])?$post['bill_phone']:''));?>" />
                      </div>
                      <? } ?>
                      <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'siteIdInput') !== false){?>
                      <div class="siteIdInput_div ewalist hide">
                        <input type="text" name="siteId_input" class="w93p required" placeholder="Unique site identifier, forwarded to qiwi." title="Unique site identifier, forwarded to qiwi." data-required="required" value="<?=(isset($post['siteId_input'])?$post['siteId_input']:'');?>" />
                      </div>
                      <? } ?>
					  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'payUwalletLogo') !== false){?>
						<div class="payUwalletLogo_div ewalist hide">
							<div class="walletsDiv col-sm-6 my-2 border rounded desImg FREC"><img src="<?=$data['Host']?>/images/freecharge-logo-new.png" alt="FreeCharge" title="FreeCharge" style="display:block;width: 100%;"><span class="wallets txNm hide">FreeCharge</span></div>
							<?php /*?><div class="walletsDiv desImg AMZPAY"><img src="<?=$data['Host']?>/images/amazonpay_logo.png" alt="AmazonPay" title="AmazonPay" style="display:block;width:95%;margin:3px auto;"><span class="wallets txNm hide">AmazonPay</span></div><?php */?>
							<div class="walletsDiv col-sm-6 my-2 border rounded desImg PAYTM"><img src="<?=$data['Host']?>/images/paytm.png" alt="PayTM" title="PayTM" style="display:block;width:95%;margin:3px auto;"><span class="wallets txNm hide">PayTM</span></div>
						</div>
						<? }?>
<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'payUwalletList') !== false){?>
						<div class="payUwalletList_div ewalist hide">
							<select class="w94 wDropDown dropDwn required form-select from-select-sm" name="wallet_code" id="wallet_code" style="margin:5px 0;">
								<?php /*?><option value="AMZPAY">AmazonPay</option><?php */?>
								<option value="FREC">FreeCharge</option>
								<option value="PAYTM">PayTM</option>
								<option value="JIOM">JioMoney</option>
								<option value="AMON">Airtel Money</option>
								<option value="OXYCASH">Oxigen</option>
								<option value="ITZC">ItzCash</option>
								<option value="PAYZ">HDFC PayZapp</option>
								<option value="OLAM">OlaMoney</option>
								<option value="YESW">Yes Bank</option>
								<option value="PHONEPE">PhonePe</option>
								<option value="mobikwik">MobiKwik</option>
								</select>
						</div>
					<? }?>
					
					<?	//sabpaisa - wallet - start?>
					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'SabPaisawalletLogo') !== false){?>
						<div class="SabPaisawalletLogo_div row ewalist hide">
							<div class="walletsDiv desImg col-sm-6 border rounded my-1 503"><img src="<?=$data['Host']?>/images/amazonpay_logo.png" alt="AmazonPay" title="AmazonPay" style="display:block;width:95%;margin:3px auto;"><span class="wallets txNm hide">AmazonPay</span></div>
							
						</div>
						<? }?>
<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'SabPaisawalletList') !== false){?>
						<div class="SabPaisawalletList_div ewalist hide">
							<select class="w94 wDropDown dropDwn required form-select from-select-sm" name="wallet_code" id="wallet_code" style="margin:5px 0;">
								<option value="503">AmazonPay</option>

								<?php /*?><option value="FREC">FreeCharge</option>
								<option value="PAYTM">PayTM</option>
								
								<option value="JIOM">JioMoney</option>
								<option value="AMON">Airtel Money</option>
								<option value="OXYCASH">Oxigen</option>
								<option value="ITZC">ItzCash</option>
								<option value="PAYZ">HDFC PayZapp</option>
								<option value="OLAM">OlaMoney</option>
								<option value="YESW">Yes Bank</option>
								<option value="PHONEPE">PhonePe</option>
								<option value="mobikwik">MobiKwik</option><?php */?>
								</select>
						</div>
						<? }?>
						<? //sabpaisa wallet - end?>
						
                      <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'RevPayBankLogo') !== false){?>
                      <div class="RevPayBankLogo_div ewalist hide">
                        <div class="banksDiv desImg sprite SCB0216" title="Standard Chartered"><span class="imgs" style="vertical-align:middle;"><img src="<?=$data['Host']?>/images/standardChartered.png"  /></span><span class="bankNm txNm">Standard Chartered</span></div>
                        <div class="banksDiv desImg sprite HSBC0223" title="HSBC Bank Malaysia Berhad"><span class="imgs" style="vertical-align:middle;"><img src="<?=$data['Host']?>/images/HSBC.png" /></span><span class="bankNm txNm">HSBC Bank Malaysia Berhad</span></div>
                        <div class="banksDiv desImg sprite RHB0218" title="RHB Bank Berhad"><span class="imgs" style="vertical-align:middle;"><img src="<?=$data['Host']?>/images/RHB Bank.png" /></span><span class="bankNm txNm">RHB Bank Berhad</span></div>
                        <div class="banksDiv desImg sprite ABB0233" title="Affin Bank Berhad"><span class="imgs" style="vertical-align:middle;"><img src="<?=$data['Host']?>/images/Affin Bank Berhad.png" /></span><span class="bankNm txNm">Affin Bank Berhad</span></div>
                      </div>
                      <? } ?>
					  <? //BANK LIST AND LOGO FOR SABPAISA - ADDED ON 2-12 BY RAJNESH ?>
					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'sabPaisaBankLogo')!==false){?>
						<div class="sabPaisaBankLogo_div row ewalist hide">
							
							
							<!--<div class="banksDiv desImg col-sm-6 border my-1 17"><span class="banks_sprite banks_bank_200" style="vertical-align:middle;"></span><span class="bankNm txNm" >ICICI 9</span></div>
							<div class="banksDiv desImg col-sm-6 border my- 26"><span class="banks_sprite banks_bank_500" style="vertical-align:middle;"></span><span class="bankNm txNm" >Kotak</span></div>
							<div class="banksDiv desImg col-sm-6 border my- 30"><span class="banks_sprite banks_bank_600" style="vertical-align:middle;"></span><span class="bankNm txNm" >PNB</span></div>
							<div class="banksDiv desImg col-sm-6 border my- 8006"><span class="banks_sprite banks_bank_700" style="vertical-align:middle;"></span><span class="bankNm txNm">IDFC</span></div>-->
							
							<div class="banksDiv col-sm-6 my-2 border rounded desImg SBIB"><span class="banks_sprite banks_bank_1" style="vertical-align:middle;"></span><span class="bankNm txNm" >SBI</span></div>
						<div class="banksDiv col-sm-6 my-2 border rounded desImg ICIB"><span class="banks_sprite banks_bank_2" style="vertical-align:middle;"></span><span class="bankNm txNm" >ICICI</span></div>
						<div class="banksDiv col-sm-6 my-2 border rounded desImg HDFB"><span class="banks_sprite banks_bank_3" style="vertical-align:middle;"></span><span class="bankNm txNm" >HDFC</span></div>
						<div class="banksDiv col-sm-6 my-2 border rounded desImg AXIB"><span class="banks_sprite banks_bank_4" style="vertical-align:middle;"></span><span class="bankNm txNm" >Axis</span></div>
						<div class="banksDiv col-sm-6 my-2 border rounded desImg 162B"><span class="banks_sprite banks_bank_5" style="vertical-align:middle;"></span><span class="bankNm txNm" >Kotak</span></div>
						<div class="banksDiv col-sm-6 my-2 border rounded desImg PNBB"><span class="banks_sprite banks_bank_6" style="vertical-align:middle;"></span><span class="bankNm txNm" >PNB</span></div>
						
						</div>
					<? }?>
					
					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'sabPaisaBankList') !== false){?>
						<div class="sabPaisaBankList_div ewalist hide">
							<select class="w94 dropDwn required form-select from-select-sm" name="bankCode" id="bankCode" style="margin:5px 0;">
								<option value="40">Bank of India</option>
								<option value="5">Bank of Maharashtra</option>
								<option value="8">Catholic Syrian Bank</option>
								<option value="9">Central Bank of India</option>
								<option value="6">City Union Bank</option>
								<option value="12">Deutsche Bank</option>
								<option value="13">Dhanlaxmi Bank</option>
								<option value="14">Equitas Bank</option>
								<option value="17">ICICI Bank</option>
								<option value="18">IDBI Bank</option>
								<option value="8006">IDFC FIRST Bank Limited</option>
								<option value="20">Indian Overseas Bank</option>
								<option value="21">Indusind Bank</option>
								<option value="8005">Janata Sahakari Bank LTD Pune</option>
								<option value="22">Jammu and Kashmir Bank</option>
								<option value="23">Karnataka Bank</option>
								<option value="24">Karur Vysya Bank</option>
								<option value="26">Kotak Mahindra Bank</option>
								<option value="25">Lakshmi Vilas Bank NetBanking</option>
								<option value="28">Punjab & Sind Bank</option>
								<option value="30">PNB -Punjab National Bank Retail</option>
								<option value="31">RBL Bank</option>
								<option value="36">Tamilnad Mercantile Bank</option>
								<option value="37">UCO Bank</option>
								<option value="38">Union Bank of India - Retail</option>
								<option value="41">Yes Bank</option>
							</select>
						<input class="w94" type="text"  name="bankCode_text" style="margin:5px 0;display:none;" />
						</div>
					<? }?>
					<? //BANK LIST AND LOGO FOR SABPAISA - END?>


				<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'payuBankingLogo') !== false){?>
					<div class="payuBankingLogo_div ewalist row  hide">
						<div class="banksDiv col-sm-6 my-2 border rounded desImg SBIB"><span class="banks_sprite banks_bank_1" style="vertical-align:middle;"></span><span class="bankNm txNm" >SBI</span></div>
						<div class="banksDiv col-sm-6 my-2 border rounded desImg ICIB"><span class="banks_sprite banks_bank_2" style="vertical-align:middle;"></span><span class="bankNm txNm" >ICICI</span></div>
						<div class="banksDiv col-sm-6 my-2 border rounded desImg HDFB"><span class="banks_sprite banks_bank_3" style="vertical-align:middle;"></span><span class="bankNm txNm" >HDFC</span></div>
						<div class="banksDiv col-sm-6 my-2 border rounded desImg AXIB"><span class="banks_sprite banks_bank_4" style="vertical-align:middle;"></span><span class="bankNm txNm" >Axis</span></div>
						<div class="banksDiv col-sm-6 my-2 border rounded desImg 162B"><span class="banks_sprite banks_bank_5" style="vertical-align:middle;"></span><span class="bankNm txNm" >Kotak</span></div>
						<div class="banksDiv col-sm-6 my-2 border rounded desImg PNBB"><span class="banks_sprite banks_bank_6" style="vertical-align:middle;"></span><span class="bankNm txNm" >PNB</span></div>
					</div>
					<?
					}
if(isset($post['t_name6'])&&strpos($post['t_name6'],'allPayPayuBankingList') !== false){?>
					<div class="allPayPayuBankingList_div ewalist hide">
						<select class="w94 dropDwn required form-select from-select-sm" name="bank_code_payu" id="bank_code_payu" style="margin:5px 0;" data-required="required">
							<option value="AIRNB">Airtel Payments Bank</option>
							<option value="AXIB">Axis NB</option>
							<option value="BOIB">Bank Of India</option>
							<option value="BOMB">Bank Of Maharashtra</option>
							<option value="BHNB">Bharat Co-Op Bank</option>
							<option value="CABB">Canara Bank</option>
							<option value="CSBN">Catholic Syrian Bank</option>
							<option value="CBIB">Central Bank of India</option>
							<option value="CUBB">City Union Bank</option>
							<option value="CRBP">Corporation Bank</option>
							<option value="CSMSNB">Cosmos Bank</option>
							<option value="DENN">Dena Bank</option>
							<option value="DSHB">Deutsche Bank</option>
							<option value="DCBB">Development Credit Bank</option>
							<option value="DLSB">Dhanlaxmi Bank</option>
							<option value="HDFB">HDFC Bank</option>
							<option value="ICIB">ICICI</option>
							<option value="IDFCNB">IDFC</option>
							<option value="INDB">Indian Bank</option>
							<option value="INOB">Indian Overseas Bank</option>
							<option value="INIB">IndusInd Bank</option>
							<option value="IDBB">Industrial Development Bank of India (IDBI)</option>
							<option value="JAKB">Jammu and Kashmir Bank</option>
							<option value="JSBNB">Janata Sahakari Bank Pune</option>
							<option value="KRKB">Karnataka Bank</option>
							<option value="KRVBC">Karur Vysya - Corporate Netbanking</option>
							<option value="162B">Kotak Mahindra Bank</option>
							<option value="LVCB">Lakshmi Vilas Bank - Corporate Netbanking</option>
							<option value="LVRB">Lakshmi Vilas Bank - Retail Netbanking</option>
							<option value="TBON">Nainital Bank</option>
							<option value="OBCB">Oriental Bank of Commerce</option>
							<option value="PMNB">Punjab And Maharashtra Co-operative Bank Limited</option>
							<option value="PSBNB">Punjab And Sind Bank</option>
							<option value="CPNB">Punjab National Bank - Corporate Banking</option>
							<option value="PNBB">Punjab National Bank - Retail Banking</option>
							<option value="SRSWT">Saraswat bank</option>
							<option value="SBIB">SBI Netbanking</option>
							<option value="SVCNB">Shamrao Vithal Co-operative Bank Ltd</option>
							<option value="SYNDB">Syndicate Bank</option>
							<option value="TMBB">Tamilnad Mercantile Bank</option>
							<option value="FEDB">The Federal Bank</option>
							<option value="KRVB">The Karur Vysya Bank</option>
							<option value="SOIB">The South Indian Bank</option>
							<option value="UCOB">UCO Bank</option>
							<option value="UBIBC">Union Bank - Corporate Netbanking</option>
							<option value="UBIB">Union Bank Of India</option>
							<option value="VJYB">Vijaya Bank</option>
						</select>
					<input class="w94" type="text" name="bank_code_text" style="margin:5px 0;display:none;" />
					</div>
					<? 
					}
					?>
                      <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'RevPayList') !== false){?>
                      <div class="RevPayList_div ewalist hide">
                        <select class="w94 dropDwn required" name="bankCode" id="bankCode" style="margin:5px 0;">
                          <option value="" selected="selected">Bank Name</option>
                          <option value="TEST0021">Test Bank</option>
                          <option value="ABB0233">Affin Bank Berhad</option>
                          <option value="ABMB0212">Alliance Bank Malaysia Berhad</option>
                          <option value="AMBB0209">AmBank Malaysia Berhad</option>
                          <option value="BIMB0340">Bank Islam Malaysia Berhad</option>
                          <option value="BKRM0602">Bank Kerjasama Rakyat Malaysia Berhad</option>
                          <option value="BMMB0341">Bank Muamalat Malaysia Berhad</option>
                          <option value="BSN0601">Bank Simpanan Nasional</option>
                          <option value="BCBB0235">CIMB Bank Berhad</option>
                          <option value="HLB0224">Hong Leong Bank Berhad</option>
                          <option value="HSBC0223">HSBC Bank Malaysia Berhad</option>
                          <option value="KFH0346">Kuwait Finance House (Malaysia) Berhad</option>
                          <option value="MB2U0227">Malayan Banking Berhad (M2U)</option>
                          <option value="MBB0228">Malayan Banking Berhad (M2E)</option>
                          <option value="OCBC0229">OCBC Bank Malaysia Berhad</option>
                          <option value="PBB0233">Public Bank Berhad</option>
                          <option value="RHB0218">RHB Bank Berhad</option>
                          <option value="SCB0216">Standard Chartered Bank</option>
                          <option value="UOB0226">United Overseas Bank</option>
                        </select>
                        <input class="w94" type="text"  name="bankCode_text" style="margin:5px 0;display:none;" />
                      </div>
                      <? } ?>
					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'IsgNetBankingTopBank') !== false){?>
					<div class="IsgNetBankingTopBank_div ewalist hide">
						<div class="banksDiv desImg sprite SCB0216" title="Standard Chartered"><span class="imgs" style="vertical-align:middle;"><img src="<?=$data['Host']?>/images/standardChartered.png"  /></span><span class="bankNm txNm">Standard Chartered</span></div>
						<div class="banksDiv desImg sprite HSBC0223" title="HSBC Bank Malaysia Berhad"><span class="imgs" style="vertical-align:middle;"><img src="<?=$data['Host']?>/images/HSBC.png" /></span><span class="bankNm txNm">HSBC Bank Malaysia Berhad</span></div>
						<div class="banksDiv desImg sprite RHB0218" title="RHB Bank Berhad"><span class="imgs" style="vertical-align:middle;"><img src="<?=$data['Host']?>/images/RHB Bank.png" /></span><span class="bankNm txNm">RHB Bank Berhad</span></div>
						<div class="banksDiv desImg sprite ABB0233" title="Affin Bank Berhad"><span class="imgs" style="vertical-align:middle;"><img src="<?=$data['Host']?>/images/Affin Bank Berhad.png" /></span><span class="bankNm txNm">Affin Bank Berhad</span></div>
					</div>
					<?
					}
					if(isset($post['t_name6'])&&strpos($post['t_name6'],'IsgNetBankingNameList') !== false){?>

						<div class="IsgNetBankingNameList_div ewalist hide">
							<select class="w94 dropDwn required" name="bankCode" id="bankCode" style="margin:5px 0;">
								<option value="" selected="selected">Bank Name</option>
								<option value="TEST0021">Test Bank</option>
								<option value="ABB0233">Affin Bank Berhad</option>
								<option value="ABMB0212">Alliance Bank Malaysia Berhad</option>
								<option value="AMBB0209">AmBank Malaysia Berhad</option>
								<option value="BIMB0340">Bank Islam Malaysia Berhad</option>
								<option value="BKRM0602">Bank Kerjasama Rakyat Malaysia Berhad</option>
								<option value="BMMB0341">Bank Muamalat Malaysia Berhad</option>
								<option value="BSN0601">Bank Simpanan Nasional</option>
								<option value="BCBB0235">CIMB Bank Berhad</option>
								<option value="HLB0224">Hong Leong Bank Berhad</option>
								<option value="HSBC0223">HSBC Bank Malaysia Berhad</option>
								<option value="KFH0346">Kuwait Finance House (Malaysia) Berhad</option>
								<option value="MB2U0227">Malayan Banking Berhad (M2U)</option>
								<option value="MBB0228">Malayan Banking Berhad (M2E)</option>
								<option value="OCBC0229">OCBC Bank Malaysia Berhad</option>
								<option value="PBB0233">Public Bank Berhad</option>
								<option value="RHB0218">RHB Bank Berhad</option>
								<option value="SCB0216">Standard Chartered Bank</option>
								<option value="UOB0226">United Overseas Bank</option>
							</select>
							<input class="w94" type="text" name="bankCode_text" style="margin:5px 0;display:none;"/>
						</div>
                      <?
					  } ?>
					 <?
					 ###### HELP 2 PAY - START
					if(isset($post['t_name6'])&&strpos($post['t_name6'],'help2payBankingList') !== false){

					include_once $data['Path'].'/api/pay70/bank_list_70'.$data['iex'];
						$country_two = $post['country_two'];
						?>

						<div class="help2payBankingList_div ewalist hide">
							<select class="w94 dropDwn required" name="bankCode" id="bankCode" style="margin:5px 0;">
							<option value="" selected="selected">Bank Name</option>
								<option value="TEST0021">Test Bank</option>
							<?
							foreach ($BankListArray as $key => $val) {
								$bcode	= $key;
								$bname	= $val['name'];
								$bctry	= $val['country'];
								

								if(isset($country_two)&&$country_two){
									if($country_two==$bctry)
									{
									$bcurr	= $val['curr'];
									?>
									<option value="<?=$bcode?>"><?=$bname?></option>
									<?
									}
								}
								else{
									?>
									<option value="<?=$bcode?>"><?=$bname?></option>
									<?
								}
							}
							?>
							</select>
							<input type="hidden" name="bank_curr" value="<?=$bcurr?>" />
							<input class="w94" type="text" name="bankCode_text" style="margin:5px 0;display:none;"/>
						</div>
                      <?
					  }
					   ###### HELP 2 PAY - END
					  ?>
                      <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'siteIdInput') !== false){?>
                      <div class="BrazilList_div ewalist hide">
                        <textarea name="address" class="w93p required" cols="30" rows="3" placeholder="Consumer's address" style="line-height:140%;height:55px;"><?=(isset($post['address'])&&$post['address']?$post['address']:(isset($post['bill_full_address'])?$post['bill_full_address']:''));?></textarea>
                        <input type="text" name="zipcode" class="w93p required" placeholder="Consumer's zip/postal code" value="<?=(isset($post['zipcode'])&&$post['zipcode']?$post['zipcode']:(isset($post['bill_zip'])?$post['bill_zip']:''));?>" />
                        <input type="date" name="dob" class="w93p" placeholder="Date of birth"  value="<?=(isset($post['dob'])?$post['dob']:'');?>" />
                      </div>
                      <? } ?>
                      <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'IndiaBankingLogo') !== false){?>
                      <div class="IndiaBankingLogo_div ewalist hide">
                        <div class="banksDiv desImg SBIN"><span class="banks_sprite banks_bank_1" style="vertical-align:middle;"></span><span class="bankNm txNm" >SBI</span></div>
                        <div class="banksDiv desImg ICIC"><span class="banks_sprite banks_bank_2" style="vertical-align:middle;"></span><span class="bankNm txNm" >ICICI</span></div>
                        <div class="banksDiv desImg HDFC"><span class="banks_sprite banks_bank_3" style="vertical-align:middle;"></span><span class="bankNm txNm" >HDFC</span></div>
                        <div class="banksDiv desImg UTIB"><span class="banks_sprite banks_bank_4" style="vertical-align:middle;"></span><span class="bankNm txNm" >Axis</span></div>
                        <div class="banksDiv desImg KKBK"><span class="banks_sprite banks_bank_5" style="vertical-align:middle;"></span><span class="bankNm txNm" >Kotak</span></div>
                        <div class="banksDiv desImg PUNB_R"><span class="banks_sprite banks_bank_6" style="vertical-align:middle;"></span><span class="bankNm txNm" >PNB</span></div>
                      </div>
                      <? } ?>
                      <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'allPayIndiaBankingList') !== false){?>
                      <div class="allPayIndiaBankingList_div ewalist hide">
                        <select class="w94 dropDwn required form-select" name="bank_code" id="bank_code" style="margin:5px 0;" data-required="required">
                          <option value="" selected="selected">Bank Name</option>
                          <option value="ABPB">Aditya Birla Idea Payments Bank</option>
                          <option value="AIRP">Airtel Payments Bank</option>
                          <option value="ALLA">Allahabad Bank</option>
                          <option value="ANDB">Andhra Bank</option>
                          <option value="BARB_R">Bank of Baroda - Retail Banking</option>
                          <option value="BBKM">Bank of Bahrein and Kuwait</option>
                          <option value="BKDN">Dena Bank</option>
                          <option value="BKID">Bank of India</option>
                          <option value="CBIN">Central Bank of India</option>
                          <option value="CIUB">City Union Bank</option>
                          <option value="CNRB">Canara Bank</option>
                          <option value="CORP">Corporation Bank</option>
                          <option value="COSB">Cosmos Co-operative Bank</option>
                          <option value="CSBK">Catholic Syrian Bank</option>
                          <option value="DBSS">Development Bank of Singapore</option>
                          <option value="DCBL">DCB Bank</option>
                          <option value="DEUT">Deutsche Bank</option>
                          <option value="DLXB">Dhanlaxmi Bank</option>
                          <option value="ESFB">Equitas Small Finance Bank</option>
                          <option value="FDRL">Federal Bank</option>
                          <option value="HDFC">HDFC Bank</option>
                          <option value="IBKL">IDBI</option>
                          <option value="ICIC">ICICI Bank</option>
                          <option value="IDFB">IDFC FIRST Bank</option>
                          <option value="IDIB">Indian Bank</option>
                          <option value="INDB">Indusind Bank</option>
                          <option value="IOBA">Indian Overseas Bank</option>
                          <option value="JAKA">Jammu and Kashmir Bank</option>
                          <option value="JSBP">Janata Sahakari Bank (Pune)</option>
                          <option value="KARB">Karnataka Bank</option>
                          <option value="KKBK">Kotak Mahindra Bank</option>
                          <option value="KVBL">Karur Vysya Bank</option>
                          <option value="LAVB_C">Lakshmi Vilas Bank - Corporate Banking</option>
                          <option value="LAVB_R">Lakshmi Vilas Bank - Retail Banking</option>
                          <option value="MAHB">Bank of Maharashtra</option>
                          <option value="NKGS">NKGSB Co-operative Bank</option>
                          <option value="ORBC">Oriental Bank of Commerce</option>
                          <option value="PMCB">Punjab & Maharashtra Co-operative Bank</option>
                          <option value="PSIB">Punjab & Sind Bank</option>
                          <option value="PUNB_R">PNB - Punjab National Bank - Retail Banking</option>
                          <option value="RATN">RBL Bank</option>
                          <option value="SBBJ">State Bank of Bikaner and Jaipur</option>
                          <option value="SBHY">State Bank of Hyderabad</option>
                          <option value="SBIN">SBI - State Bank of India</option>
                          <option value="SBMY">State Bank of Mysore</option>
                          <option value="SBTR">State Bank of Travancore</option>
                          <option value="SCBL">Standard Chartered Bank</option>

                          <option value="SIBL">South Indian Bank</option>
                          <option value="SRCB">Saraswat Co-operative Bank</option>
                          <option value="STBP">State Bank of Patiala</option>
                          <option value="SVCB">Shamrao Vithal Co-operative Bank</option>
                          <option value="SYNB">Syndicate Bank</option>
                          <option value="TMBL">Tamilnadu Mercantile Bank</option>
                          <option value="TNSC">Tamilnadu State Apex Co-operative Bank</option>
                          <option value="UBIN">Union Bank of India</option>
                          <option value="UCBA">UCO Bank</option>
                          <option value="UTBI">United Bank of India</option>
                          <option value="UTIB">Axis Bank</option>
                          <option value="VIJB">Vijaya Bank</option>
                          <option value="YESB">Yes Bank</option>
                        </select>
                        <input class="w94" type="text"  name="bank_code_text" style="margin:5px 0;display:none;" />
                      </div>
                      <? } ?>
                      <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'walletList') !== false){?>
                      <div class="walletList_div ewalist hide">
                        <select class="w94 wDropDown dropDwn required form-select" name="wallet_code" id="wallet_code" style="">
                          <option value="4006">AirtelMoney</option>
                          <option value="4008">AmazonPay</option>
                          <option value="4001">FreeCharge</option>
                          <option value="4002">MobiKwik</option>
                          <option value="4003">OlaMoney</option>
                          <?/*?><option value="4007">Paytm</option><?*/?>
                          <option value="4009">PhonePe</option>
                          <option value="4004">JioMoney</option>
                        </select>
                        <input class="w94" type="text"  name="wallet_code_text" style="margin:5px 0;display:none;" />
                      </div>
                      <? } ?>
                      <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'BBVAInstr') !== false){?>
                      <div class="BBVAInstr_div ewalist hide">
                        <ul>
                          <li>Selecciona la opción <b>"Cuenta y Ahorros"</b> </li>
                          <li>Selecciona <b>"Servicios Públicos" - "SafetyPay" </b> y moneda. </li>
                          <li>Ingrese tu <b>"Código de pago [TransactionID]"</b> </li>
                          <li>Selecciona la Cuenta o Tarjeta de Crédito de cargo, confirma el pago con tu clave SMS y ¡Listo! </li>
                        </ul>
                      </div>
                      <? } ?>
                      <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'TetherCoins_msg') !== false){?>
                      <div class="TetherCoins_msg_div ewalist modalMsg hide" data-style='width:300px;height:270px;' >
                        <div class="modalMsgCont" style="display:none !important">
                          <div class="modalMsgContTxt" >
                            <h4>
                            TetherCoins</h4>
                            <p><b>On the next screen you need to scan the QR code to pay by TetherCoins. Click Yes below when you are ready</b></p>
                            <span class="submit_div">
                            <button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-icon btn-primary" autocomplete="off" style='width:35%' onclick='checkValidity_tr_f();'><i class="<?=$data['fwicon']['check-circle'];?>"></i> <b class="contitxt">Yes</b></button>
                            </span> <a class='nopopup suButton btn btn-icon btn-primary' style='width:35%' onClick="view_tr_next3(this,'.noText3')" data-ph="430px" data-ch="270px">No</a>
                            <p class='hide noText3'>(If you do not have mobile application to scan QR code, you can still click on Yes above and we will share our BTC address which you can copy from next screen and send the exact payment to our btc address. )</p>
                          </div>
                        </div>
                      </div>
                      <? } ?>
                      <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'BitCoins_msg') !== false){?>
                      <div class="BitCoins_msg_div ewalist modalMsg hide" data-style='width:300px;height:270px;' >
                        <div class="modalMsgCont" style="display:none !important">
                          <div class="modalMsgContTxt" >
                            <h4>
                            BitCoins</h4>
                            <p><b>On the next screen you need to scan the QR code to pay by BitCoin. Click Yes below when you are ready</b></p>
                            <span class="submit_div">
                            <button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-icon btn-primary" autocomplete="off" style='width:35%' onclick='checkValidity_tr_f();'><i class="<?=$data['fwicon']['check-circle'];?>"></i> <b class="contitxt">Yes</b></button>
                            </span> <a class='nopopup suButton btn btn-icon btn-primary' style='width:35%' onClick="view_tr_next3(this,'.noText3')" data-ph="430px" data-ch="270px">No</a>
                            <p class='hide noText3'>(If you do not have mobile application to scan QR code, you can still click on Yes above and we will share our BTC address which you can copy from next screen and send the exact payment to our btc address. )</p>
                          </div>
                        </div>
                      </div>
                      <? } ?>
                      <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'AdvCash_msg') !== false){?>
                      <div class="AdvCash_msg_div ewalist modalMsg hide" data-style='width:300px;height:auto;' >
                        <div class="modalMsgCont" style="display:none !important">
                          <div class="modalMsgContTxt" >
                            <h4>
                            AdvCash</h4>
                            <p><b>Do you already have ADVCASH eWallet Account?</b></p>
                            <span class="submit_div">
                            <button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-icon btn-primary" autocomplete="off" style='width:48%' onclick='checkValidity_tr_f();'><i class="<?=$data['fwicon']['check-circle'];?>"></i> <b class="contitxt">Yes</b></button>
                            </span> <a class='nopopup suButton btn btn-icon btn-primary' style='width:48%' onClick="view_tr_next3(this,'.noText3')" data-ph="400px" data-ch="200px">No</a>
                            <p class='hide noText3'>(If you do not have ADVCASH eWallet account, You can logon to advcash.com and create an account once your account is <a href='https://wallet.advcash.com/register' target='_blank'>created/verified</a> you can come back to us and complete the payment for your favourite merchant.)</p>
                          </div>
                        </div>
                      </div>
                      <? } ?>
                      <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'cashU_msg') !== false){?>
                      <div class="cashU_msg_div ewalist modalMsg hide" data-style='width:300px;height:270px;' >
                        <div class="modalMsgCont" style="display:none !important">
                          <div class="modalMsgContTxt" >
                            <h4>
                            CASHU</h4>
                            <p><b>Do you already have CASHU eWallet Account?</b></p>
                            <span class="submit_div">
                            <button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-icon btn-primary" autocomplete="off" style='width:35%' onclick='checkValidity_tr_f();'><i class="<?=$data['fwicon']['check-circle'];?>"></i> <b class="contitxt">Yes</b></button>
                            </span> <a class='nopopup suButton btn btn-icon btn-primary' style='width:35%' onClick="view_tr_next3(this,'.noText3')"  data-ph="430px" data-ch="270px">No</a>
                            <p class='hide noText3'>(If you do not have CASHU eWallet account, You can logon to cashu.com and create an account once your account is <a href='https://www.cashu.com/CLogin/registersForm?lang=en' target='_blank'>created/verified</a> you can come back to us and complete the payment for your favourite merchant.)</p>
                          </div>
                        </div>
                      </div>
                      <? } ?>
                      <div class="universal_msg_div ewalist modalMsg hide" data-style='width:300px;height:auto;' >
                        <div class="modalMsgCont" style="display:none !important">
                          <div class="modalMsgContTxt" >
                         <p class="fw-bold mb-2">We are about to redirect you to bank page to authenticate this transactions in the next tab.</p>
                            <span class="submit_div">
                            <button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-icon btn-primary" autocomplete="off" style='width:48%' onclick='checkValidity_tr_f();'><i class="<?=$data['fwicon']['check-circle'];?>"></i> <b class="contitxt">Yes</b></button>
                            </span> <a class='nopopup suButton btn btn-icon btn-primary' style='width:48%' onClick="document.getElementById('modal_msg').style.display='none';">No</a>
                            <p class="my-2 ">You can always switch back to this tab if transactions is not successful. </p>
                          </div>
                        </div>
                      </div>
					  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'BNPay_msg') !== false){?>
                      <div class="BNPay_msg_div ewalist modalMsg hide" data-style='width:300px;height:auto;' >
                        <div class="modalMsgCont" style="display:none !important">
                          <div class="modalMsgContTxt" >
                            <h4>
                            BINANCE</h4>
                            <p><b>Do you already have BINANCE Wallet?</b></p>
                            <span class="submit_div">
                            <button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-icon btn-primary" autocomplete="off" style='width:48%' onclick='checkValidity_tr_f();'><i class="<?=$data['fwicon']['check-circle'];?>"></i> <b class="contitxt">Yes</b></button>
                            </span> <a class='nopopup suButton btn btn-icon btn-primary' style='width:48%' onClick="view_tr_next3(this,'.noText3')" data-ph="400px" data-ch="200px">No</a>
                            <p class='hide noText3'>(If you do not have BINANCE Wallet, You can logon to binance.com and create an account once your account is <a href="https://accounts.binance.com/en/login" target="_blank"><strong>created/verified</strong></a> you can come back to us and complete the payment for your favourite merchant.)</p>
                          </div>
                        </div>
                      </div>
                      <? }
					  
					  #Coinbase
					  ?>
					  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'Coinbase_msg') !== false){?>
                      <div class="Coinbase_msg_div ewalist modalMsg hide" data-style='width:300px;height:auto;' >
                        <div class="modalMsgCont" style="display:none !important">
                          <div class="modalMsgContTxt" >
                            <h4>Coinbase</h4>
                            <p><b>Do you already have Coinbase Wallet?</b></p>
                            <span class="submit_div">
                            <button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-icon btn-primary" autocomplete="off" style='width:48%' onclick='checkValidity_tr_f();'><i class="<?=$data['fwicon']['check-circle'];?>"></i> <b class="contitxt">Yes</b></button>
                            </span> <a class='nopopup suButton btn btn-icon btn-primary' style='width:48%' onClick="view_tr_next3(this,'.noText3')" data-ph="400px" data-ch="200px">No</a>
                            <p class='hide noText3'>(If you do not have Coinbase Wallet, You can logon to coinbase.com and create an account once your account is <a href="https://www.coinbase.com/signup" target="_blank"><strong>created/verified</strong></a> you can come back to us and complete the payment for your favourite merchant.)</p>
                          </div>
                        </div>
                      </div>
                      <? }?>
					  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'universal_msg_17') !== false){
					  
					//  print_r($data['domain_server']['subadmin']['customer_service_email']);
					  
					  ?>
					  <div class="universal_msg_17_div ewalist modalMsg hide" data-style='width:340px;height:450px;margin:-160px 0px 0px -177px;' >
                        <div class="modalMsgCont" style="display:none !important">
                          <div class="modalMsgContTxt" >
                            <p><b>Important Message:</b><br />
							You are being redirected to our partner site <b>flashfin (Flash Pay)</b> to authorise this transaction. <br />
							On the next page you will see your order amount in THB (Thai Baht) instead of <?=(isset($post['curr'])&&$post['curr'])?$post['curr']:'USD';?>. <b>Your card will be charged equivalent amount of your <?=(isset($post['curr'])&&$post['curr'])?$post['curr']:'USD';?> order in THB only</b>. You can get back to us via email 
							<?
							if(isset($data['domain_server']['subadmin']['customer_service_email'])&&$data['domain_server']['subadmin']['customer_service_email'])
								echo 'at <b>'.encrypts_decrypts_emails($data['domain_server']['subadmin']['customer_service_email'],2).'</b>';
							?>
							 for any assistance with this order.</b></p>
                            <span class="submit_div">
                            <button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-icon btn-primary glyphicons circle_ok " autocomplete="off" style='width:35%' onclick='checkValidity_tr_f();'><i></i><b class="contitxt">Yes</b></button>
                            </span> <a class='nopopup suButton btn btn-icon btn-primary' style='width:35%' onClick="document.getElementById('modal_msg').style.display='none';">No</a>
                            <p>You can always switch back to this tab if transactions is not successful. </p>
                          </div>
                        </div>
                      </div>
					  <? } ?>
					  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'n26_msg') !== false){?>
					  <div class="n26_msg_div ewalist modalMsg hide" data-style='width:300px;height:300px;' >
                        <div class="modalMsgCont" style="display:none !important">
                          <div class="modalMsgContTxt" >
                            <p><b>You will be redirected to our Partner (Picksell) website to create account and complete the payment via Bank Transfer. </b></p>
                            <span class="submit_div">
                            <button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-icon btn-primary" autocomplete="off" style='width:35%' onclick='checkValidity_tr_f();'><i class="<?=$data['fwicon']['check-circle'];?>"></i> <b class="contitxt">Yes</b></button>
                            </span> <a class='nopopup suButton btn btn-icon btn-primary' style='width:35%' onClick="document.getElementById('modal_msg').style.display='none';">No</a>
                            <p>You can always switch back to this tab if transactions is not successful. </p>
                          </div>
                        </div>
                      </div>
					  <?
					  }
					  ?>
                      <div class="submit_div hide" id="continueValidationButton">
                        <button id="cardsend_submit" type='button' name="send123" value="CHANGE NOW!"  class="inputValidation submitbtn btn btn-icon btn-primary my-2"><i class="<?=$data['fwicon']['check-circle'];?>"></i> <b class="contitxt">Continue</b></button>
                      </div>
                      <div class="submit_div" id="continue3dButton">
                        <button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!"  class="submitbtn btn btn-icon btn-primary my-2"><i class="<?=$data['fwicon']['check-circle'];?>"></i> <b class="contitxt">Continue</b></button>
                      </div>
					  
                      <div class="modal_msg" id="modal_msg">
                        <div class="modal_msg_layer"> </div>
                        <div class="modal_msg_body"> <a class="modal_msg_close_ux" onClick="document.getElementById('modal_msg').style.display='none';" title="Close">X</a>
                          <div id="modal_msg_body_div"> </div>

                          <!--<a class="modal_msg_close2" onClick="document.getElementById('modal_msg').style.display='none';">Close</a>--></div>
                      </div>
                    </div>
                  </form>
                </div>
                <? } ?>
				<div class="clearfix">
				 <?php /*?><a class="change hide box-shadow my-2 text-center" id="paymentMethodChange" style="display: none;"><i class="<?=$data['fwicon']['circle-left'];?> mx-2"></i> Change Payment Method</a><?php */?>
				</div> 
				 
				 
                </div>
				
             </div>
<? } ?>
           
         

        </div>
      </div>
	  </div>
	  
	  
<? } ?>
      
<?  
if(isset($_POST['payment']) && $_POST['payment']=='creditcard'){
?>
<script type="text/javascript" >
	SlideBox('card',false);
</script>
<?
}elseif(isset($_POST['payment']) && $_POST['payment']=='epayaccount'){ ?>
<script type="text/javascript" >
	SlideBox('epay',false);
</script>
<? } ?>
<? 
// if(!empty($post['nick_name_card'])){
?>
<script src="<?=$data['Host']?>/js/jquery.payform.min.js" charset="utf-8"></script>
<script language="javascript" type="text/javascript"> 
//alert("ok");
var cardNumber = $('#number');
var cardNumber2 = $('.key_input,#number');
var cardNumberField = $('#card-number-field');
var CVV = $("#cvc");
var mastercard = $("#mastercard");
var confirmButton = $('#cardsend_submit');
var visa = $("#visa");
var amex = $("#amex");
var jcb = $("#jcb");
var cardtype = $("#cardtype"); 
var cardLength=16;
var setCardLength_allcard=16;
var setCardLength_amex=15;
var cardLengthInput=0;

if(BrowserName==setBrowserName){ 
	cardLength=19;
	setCardLength_allcard=19;
	setCardLength_amex=18;
	//alert('BrowserName=>'+BrowserName+',cardLength=>'+cardLength+',setCardLength_amex=>'+setCardLength_amex+',setCardLength_allcard=>'+setCardLength_allcard); 
}

var $form = $('#payment_form_id');

var expMonth = $('#expMonth');
var expYear = $('#expYear');

function myTrim(x) {
  return x.replace(/^\s+|\s+$/gm,'');
}
function isBlank(str){
    return (!str || /^\s*$/.test(str));
}


function cardvalidorf(){

	cardNumber.payform('formatCardNumber');
   
    CVV.payform('formatCardCVC');
	
	
	expMonth.change(function(){
		expYear.focus();
	});
	expYear.change(function(){
		CVV.focus();
	});
	
    cardNumber2.on('keyup keypress change', function(e){
	//alert("keypress");return;
		var code = e.keyCode || e.which;

		cardtype.val($.payform.parseCardType(cardNumber.val()));
		
		if(cardtype.val() === "amex"){
			cardLength=setCardLength_amex;
			$('#int16').removeAttr('required');
			$('#int16').hide();
		} else {
			cardLength=setCardLength_allcard;
			$('#int16').attr('required','required');
			$('#int16').show();
		}
		
		
		if ( ( $.payform.validateCardNumber(cardNumber.val()) == false ) && ($.inArray(cardNumber.val().replace(/\s+/g, ''), jsTestCardNumbers ) > -1 )  ) {
            //cardNumberField.addClass('has-error');
			
			if(cardNumber.val().length<cardLength){
				//alert('BrowserName=>'+BrowserName+',cardLength=>'+cardLength+',setCardLength_amex=>'+setCardLength_amex+',setCardLength_allcard=>'+setCardLength_allcard+',cardNumber val=>'+cardNumber.val()+',cardNumber length =>'+cardNumber.val().length); 
				
				$form.find('#form-input-errors').css('display','block');
				$form.find('#form-input-errors').text("Wrong card number. Please enter correct!");
			}else{
				$('#form-input-errors').text("");
				$('#form-input-errors').css('display','none');
			}
			
			cardNumber.removeAttr('class');
			cardNumber.attr('class','iconnocard');
        } else {
            //cardNumberField.removeClass('has-error');
			$form.find('#form-input-errors').text("");
			$form.find('#form-input-errors').css('display','none');
			$("#cardsend_submit").prop('disabled', false);
			
            //cardNumberField.addClass('has-success');
			
			if(cardNumber.val().length === cardLength || cardNumber.val().length == cardLength) {
				 var val = $.payform.parseCardType(cardNumber.val());
				 var ccn_match = '';
				 if(val){
				   ccn_match = ccn_var.match(new RegExp(val, 'i'));
				 }
				 if(ccn_match){
					//alert('ccn_match'+"\r\n"+ccn_var);
				 }else{					//alert(cardNumber.val().length+"\r\n"+$.payform.parseCardType(cardNumber.val()));
				  //alert('No Payment Chanel Available to process this card.');
				  alert($('.alert_msg_2').text());
				}
			}
			var g_card_name=$.payform.parseCardType(cardNumber.val());
			cardNumber.attr('class','form-control');
			$('#input-card-icon').attr('class','');
			//alert(g_card_name);
			
			if(g_card_name=="mastercard"){
			$('#input-card-icon').attr('class','<?=$data['fwicon']['mastercard_code'];?> text-danger');
			
			}else if(g_card_name=="visa"){
			$('#input-card-icon').attr('class','<?=$data['fwicon']['visa_code'];?> text-info');
			
			}else if(g_card_name=="amex"){
			$('#input-card-icon').attr('class','<?=$data['fwicon']['amex_code'];?> text-info');
			
			}else if(g_card_name=="rupay"){ 
			$('#input-card-icon').attr('class','');
			cardNumber.attr('class','form-control icon'+$.payform.parseCardType(cardNumber.val()));
			
			}else if(g_card_name=="discover"){
			$('#input-card-icon').attr('class','<?=$data['fwicon']['discover_code'];?>');
			
			}else if(g_card_name=="jcb"){
			$('#input-card-icon').attr('class','<?=$data['fwicon']['jcb_code'];?> text-success');
			
			}else if(g_card_name=="dinersclub"){
			$('#input-card-icon').attr('class','<?=$data['fwicon']['diners_code'];?> text-danger');
			
			}else{
			$('#input-card-icon').attr('class','<?=$data['fwicon']['credit-card'];?>');
			}
			
			//cardNumber.attr('class','11 form-control icon'+$.payform.parseCardType(cardNumber.val()));
			// block card details by vikash on 24012023
			
        }
		
		cardLengthInput=cardNumber.val().length; 
		
		if($(this).hasClass('key_input')){
			if($(this).val().length === 1){
				if($(this).next().hasClass('key_input') && $(this).next().val().length == ''){
					$(this).next().focus();
				}
			}
			conc();
		}
		
		if(cardNumber.val().length === cardLength || cardNumber.val().length == cardLength) {
			//$('#form-input-errors').text("");
			//$('#form-input-errors').css('display','none');	
			expMonth.focus();
		}
		

		
		$('#credit_cards img').addClass('transparent');
		$('#credit_cards span').addClass('transparent');
		$('#credit_cards #'+$.payform.parseCardType(cardNumber.val())).removeClass('transparent');
		
		
		
		
		//e.preventDefault();
    });
	
	
	expMonth.focus(function(){
		//$('#form-input-errors').text("");
		$('#form-input-errors').css('display','none');	
	});
	
}

    $('#payment_form_id').submit(function(e) {
	 try {
		var $form = $('#payment_form_id');
		var cardNumber = $('#number');
		
		var isCardValid = $.payform.validateCardNumber(cardNumber.val());
        var isCvvValid = $.payform.validateCardCVC(CVV.val());
		
		if(cardNumber.val().length === cardLength){
				 var val = $.payform.parseCardType(cardNumber.val());
				 var ccn_match = ccn_var.match(new RegExp(val, 'i'));
				 if(ccn_match){
					//alert('ccn_match'+"\r\n"+ccn_var);
				 }else{					
				  //alert('No Payment Chanel Available to process this card');
				  alert($('.alert_msg_2').text());
				  cardNumber.focus();
				  return false;
				}
		}

       
        if ( ( !isCardValid ) && ($.inArray(cardNumber.val().replace(/\s+/g, ''), jsTestCardNumbers ) > -1 )  ) {
			//alert('11BrowserName=>'+BrowserName+',cardLength=>'+cardLength+',setCardLength_amex=>'+setCardLength_amex+',setCardLength_allcard=>'+setCardLength_allcard+',cardNumber val=>'+cardNumber.val()+',cardNumber length =>'+cardNumber.val().length); 
			
            alert("Wrong card number."); return false;
			
        }else if (!isCvvValid) {
            //alert("Wrong CVV");
			alert($('.alert_msg_3').text());
        } else {

			
			$("#cardsend_submit .contitxt").text('Please wait ...');
			$("#cardsend_submit").prop('disabled', true);
			
			//top.window.openFullscreen_2();
			
			$form.append('<input type="text" name="cardsend" style="display:none"  value="CHECKOUT" />');
				$('#modalpopup_form_popup').slideDown(900);
			//alert("Other Acc.="+$('#payment_form_id input[name="midcard"]').val());
			
			$form.get(0).submit();
			
			
		}
		
        e.preventDefault();
	   }
	   catch(err) {
		  alert('cardPayment=>'+err.message);
		  //document.getElementById("demo").innerHTML = err.message;
	   }
    });
	
	function checkValidity_tr_f(){
	 try {
		// alert('11111111');
		 var hasInput=false;
		 
		  $('.ewalist.active .required').each(function () {
			   if($(this).val()  == ""){
					hasInput=true;
			   }
		  }); 
		  if(hasInput==true){
				$('#modal_msg').hide(1000);
				alert("need input");
		  }else{
				//alert("good input");
		  } 
	   }
	   catch(err) {
		  alert('checkValidity=>'+err.message);
	   }
	} 
	
	
	$('#payment_form_id_ewallets').submit(function(e) { 
	  try {
		var $form = $('#payment_form_id_ewallets');
		$form.append('<input type="text" name="cardsend" style="display:none"  value="CHECKOUT" />'); 
		
		if($('#payment_form_id_ewallets').hasClass('nextTabTr')){
			if($('div').hasClass('modal_msg_body')){
			  $('#modal_msg_body_div').html($('.msgNextTabTrDiv').html()); 
			  $('.modal_msg_body').attr('style','width:300px;height:200px;margin:-100px 0 0 -150px;');
			}
		} else {
			$('#modalpopup_form_popup').slideDown(900);
		}
		$form.get(0).submit();
        e.preventDefault(); 

	   }
	   catch(err) {
		  alert('ewallets=>'+err.message);
	   }
    });
	
	$('#payment_form_id_ngDirectAccountDebit').submit(function(e) {
		var $form = $('#payment_form_id_ngDirectAccountDebit');
		$form.append('<input type="text" name="cardsend" style="display:none"  value="CHECKOUT" />');
		$('#modalpopup_form_popup').slideDown(900);

		$form.get(0).submit();
        e.preventDefault();
    });
	
	$('#payment_form_id_ngBankTransfer').submit(function(e) {
		var $form = $('#payment_form_id_ngBankTransfer');
		$form.append('<input type="text" name="cardsend" style="display:none"  value="CHECKOUT" />');
		$('#modalpopup_form_popup').slideDown(900);

		$form.get(0).submit();
        e.preventDefault();
    });
	
	$('#payment_form_id_ebanking').submit(function(e) {
		var $form = $('#payment_form_id_ebanking');
		$form.append('<input type="text" name="cardsend" style="display:none"  value="CHECKOUT" />');
		$('#modalpopup_form_popup').slideDown(900);

		$form.get(0).submit();
        e.preventDefault();
    });
	
	$('#payment_form_id_bhimupi').submit(function(e) {
		var $form = $('#payment_form_id_bhimupi');
		$form.append('<input type="text" name="cardsend" style="display:none"  value="CHECKOUT" />');
		$('#modalpopup_form_popup').slideDown(900);

		$form.get(0).submit();
        e.preventDefault();
    });
		
		
cardvalidorf();



if($('#number').val()!=''){	
	/*
	var rep_ccno = $( "#number" ).val();
		str_ccno = rep_ccno.replace(/(\d{4}(?!\s))/g, "$1 ");				
	$("#number").val(str_ccno.trim()); 
	$('#number').focus().val($('#number').val());
	$('#number').trigger("keyup");
	$('#number').trigger("keypress");
	*/
	
	
	//expMonth.trigger("change");
	$('#expMonth').focus();
	$('#expMonth').trigger("focus");
}

//$(".account_types").eq(0).trigger("click"); //send




$(document).keydown(function(e) {
    // ESCAPE key pressed
    if (e.keyCode == 27) {
        return false;
    }
	if(e.which === 122) {
        e.preventDefault();
		 return false;
    }
	
	
	if(e.ctrlKey && e.keyCode == 'E'.charCodeAt(0)){
		return false;
	}
	if(e.ctrlKey && e.shiftKey && e.keyCode == 'I'.charCodeAt(0)){
		return false;
	}
	if(e.ctrlKey && e.shiftKey && e.keyCode == 'J'.charCodeAt(0)){
		return false;
	}
	if(e.ctrlKey && e.keyCode == 'U'.charCodeAt(0)){
		return false;
	}
	if(e.ctrlKey && e.keyCode == 'S'.charCodeAt(0)){
		return false;
	}
	if(e.ctrlKey && e.keyCode == 'H'.charCodeAt(0)){
		return false;
	}
	if(e.ctrlKey && e.keyCode == 'A'.charCodeAt(0)){
		return false;
	}
	if(e.ctrlKey && e.keyCode == 'E'.charCodeAt(0)){
		return false;
	}
	
	if (e.keyCode == 123) {
		return false;
	}
	else if ((e.ctrlKey && e.shiftKey && e.keyCode == 73) || (e.ctrlKey && e.shiftKey && e.keyCode == 74)) {
		return false;
	}
	
});
</script>

<? if(isset($post['send'])&&$post['send']=="curl"){ ?>
<script language="javascript" type="text/javascript"> 
//$(".account_types").eq(2).trigger("click");
$('#payment_form_id input[name="ccno"]').trigger('keyup');
//$('#payment_form_id input[name=ccno]').keyup();
//cardvalidorf();
var $form = $('#payment_form_id');
$('#modalpopup_form_popup').slideDown(900);
$form.append('<input type="text" name="cardsend" style="display:none"  value="CHECKOUT" />');
$("#cardsend_submit .contitxt").text('Please wait ...');
//$form.get(0).submit();

</script>
<? } ?>
<script language="javascript" type="text/javascript"> 

$(document).on('keyup', "input#number",function () {
  var crdnumber = $(this).val().split(" ").join(""); // remove hyphens
  if (crdnumber.length > 0) { crdnumber = crdnumber.match(new RegExp('.{1,4}', 'g')).join(" "); }
  $(this).val(crdnumber);
  //alert($('#number').val());
});
       setTimeout(function(){ 
			//$('.goog-te-gadget').css("color", "var(--color-4)");
			$('.goog-logo-link').css("display", "none");
		},600); 
		
        $('.language-collapse').on('click', function () { 
			
			if($('#google_translate_element').css('display')=="none"){
			$('#google_translate_element').css("display", "");
			//$('.goog-te-combo').attr('size',1);
			
			//var se=$(".goog-te-combo");
            //se.show();
            //se[0].size=10;
			
			}else{
			$('#google_translate_element').css("display", "none");
			}
		
		});
		
//////////////////Start for watch display		
		// for header watch time format
function formatAMPM(date) {
	var hours = date.getHours();
	var minutes = date.getMinutes();
	var seconds = date.getSeconds();
	var ampm = hours >= 12 ? 'PM' : 'AM';
	hours = hours % 12;
	hours = hours ? hours : 12; // the hour '0' should be '12'
	hours = hours < 10 ? '0'+hours : hours;
	minutes = minutes < 10 ? '0'+minutes : minutes;
	seconds = seconds < 10 ? '0'+seconds : seconds;
	var strTime = hours + ':' + minutes + ':' + seconds + ' ' + ampm;
	return strTime;
}

function format24(date) {
    var hours = date.getHours();
	var minutes = date.getMinutes();
	var seconds = date.getSeconds();
	var ampm = hours >= 12 ? 'PM' : 'AM';
	hours = hours % 24;
	hours = hours ? hours : 0; // the hour '0' should be '12'
	hours = hours < 10 ? '0'+hours : hours;
	minutes = minutes < 10 ? '0'+minutes : minutes;
	seconds = seconds < 10 ? '0'+seconds : seconds;
	var wicon = "";/*<i class='<?=$data['fwicon']['clock'];?>' aria-hidden='true'></i> */
	//alert (wicon);
	var strTime = wicon + hours + ' : ' + minutes + ' : ' + seconds + '  ' +  ampm;
	return strTime;
}


		
		<? if(isset($data['TimeZone'])&&$data['TimeZone']){?>
			var d = new Date().toLocaleString("en-US", {timeZone: "<?=$data['TimeZone'];?>"});
		<? }else{ ?>
			var d = new Date().toLocaleString("en-US", {timeZone: "Asia/Singapore"});
		<? } ?>
		d = new Date(d);
		 //document.getElementById("jqclock").innerHTML = formatAMPM(d);
		// $('#jqclock').html(formatAMPM(d));
		 //var clocktitle = format24_caption(d).concat(" GMT+8");
		 //$('#jqclock').attr('title',clocktitle);

		 $('#jqclock').html(format24(d));
	
	setInterval(function() {
			
		<? if(isset($data['TimeZone'])&&$data['TimeZone']){?>
			var d = new Date().toLocaleString("en-US", {timeZone: "<?=$data['TimeZone'];?>"});
		<? }else{ ?>
			var d = new Date().toLocaleString("en-US", {timeZone: "Asia/Singapore"});
		<? } ?>
		d = new Date(d);
		 //document.getElementById("jqclock").innerHTML = formatAMPM(d);
		 //$('#jqclock').attr('title',formatAMPM(d));
		 //var clocktitle = format24_caption(d).concat(" GMT+8");
		 //$('#jqclock').attr('title',clocktitle);
		 $('#jqclock').html(format24(d));
				
	}, 1000); 
	   
</script>

    </div>
	  </div>
  </div>
</div>
</div>
