<?php 
$data['con_name']='clk';
if(isset($_REQUEST['fullname'])){
	$post['fullname']=stf($_REQUEST['fullname']);
}

if((isset($data['Error'])&& $data['Error'])){
	
	if($data['Error']=="Card Name missing from Bank Gateway." || $data['Error']=="Please enter valid sum for payment." ){ $data['Error']=""; } 
	
	if($data['Error']=="Name can not be empty." || $data['Error']=="Email address can not be empty & should be valid"){ 
	?>
	<script> 
	setTimeout(function(){ 
		$('.paymentMainDiv').hide();
		}, 1000); // Added By Vikash</script>
	<?
	}
}
?>

<div class="hide" style="display:none">

<div class="alert_msg_11" title="Wrong card number.">Wrong card number.</div>
<div class="alert_msg_2" title="No Payment Chanel Available to process this card">No Payment Chanel Available to process this card</div>
<div class="alert_msg_3" title="Please enter correct CVV">Please enter correct CVV and cannot empty </div>
</div>

<div class="clients_pro">
<? if((isset($_SESSION['login']))&&isset($post['action'])&&($post['action']=="vt")){?>
<? $c_style="style='float:none;'"; ?>
	<ul class="breadcrumb" style="text-align:left;">
		<li><a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>" class="glyphicons home"><i></i>
			<?=prntext($data['SiteName'])?>
			</a></li>
		<li class="divider"></li>
		<li>Moto</li>
	</ul>
<? }?>
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
var jsLuhnSkip =[<?=$data['jsLuhnSkip']?>];

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
	formObj.cardsave.disabled = true;  
	formObj.cardsave.value = 'Please Wait...';  
	return true;  
	*/
}
		
var merchant_pays="";
var afj="";
var merchant_pays_fee="";
<? if(isset($_SESSION['afj'])&&$_SESSION['afj']&&isset($_SESSION['merchant_pays_fee'])&&$_SESSION['merchant_pays_fee']){?>
	merchant_pays="1"; 
	afj=<?=$_SESSION['afj']?>;
	merchant_pays_fee="<?=$_SESSION['merchant_pays_fee'];?>";
<? } ?>

var backMerchantWebSiteUrl='';
<? if(isset($_SESSION['re_post']['return_failed_url'])&&$_SESSION['re_post']['return_failed_url']){ ?>
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
				var dataStyle=$('.ewalist.'+ewalistVar_arr[i]+'_div').attr('data-style');
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
	
  var curSym="";
  <? if(isset($_SESSION['curr_smbl'])&&$_SESSION['curr_smbl']){ ?>
	curSym="<?=$_SESSION['curr_smbl'];?>";
  <? } ?>
	
 var ccn_var;
 var card_validation='yes';
$(document).ready(function(){ 



	
	if(storeSize=='1'&&api_token){
		//alert('storeSize:'+storeSize+'\r\napi_token:'+api_token); 
		window.location.href=paymetAt+"&api_token="+api_token;
	}

	$("#storeType").change(function() {
		 var selectedItem = $(this).val();
		 var titles= $('option:selected', this).attr('data-title');
		
		 window.location.href=paymetAt+"&api_token="+selectedItem;
		
	});
	
	$('.ewalist input,.ewalist select, input.ewalist,select.ewalist').each(function(){
		$(this).attr("data-name",$(this).attr('name'));
	});
			
	$('.account_types').click(function(){
		$('body').addClass('active_pay');
		//$('.paymentMethodDiv').slideDown(100);
		$('.paymentMethodDiv').hide();
		$('.inputPaySetp3').slideDown(100);
		$('.inputSetp2').slideUp(100);
		$("#payhide").show();
		
		
		var ccn_array;
		var name_var = $(this).attr('data-name');
		var value_var = $(this).attr('data-value');
		ccn_var = $(this).attr('data-ccn');

		var ewalistVar= $(this).attr('data-ewList');
		 
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
			 $('#credit_cards').removeAttr('class');
			 $('#credit_cards').attr('class','img_'+ccn_array.length);
			 	
			//var ccn_array_length = (100/((ccn_array.length)-1))-1;
			//$('#credit_cards img').css({width:ccn_array_length+'%'});
		
			 $.each(ccn_array,function(i){
				 //alert(ccn_array[i]);
				 $('#credit_cards #'+ccn_array[i]).show();
			});
		 }
		
		
		
		if($(this).hasClass('active')){
			showPaymentMethod();
		} else {
			$('body').removeClass('active_option');
			$('.inputype.the_icon').removeClass('actives');
			$('.account_types').removeClass('active');
			
			$('.cname label[for="'+value_var+'"]').addClass('active');
			
			$(this).parent().addClass('actives');
			$(this).addClass('active');
		
			
			$('.checkOutOptions').show();

			$('.pay_div').slideUp(200);
			$('.'+name_var+'_div').slideDown(700);
			
			if($(this).attr('data-name')==="ewallets"){
				$('.checkedLabel').html(''+$(this).parent().find('.titleText').html());
			}
			else{
				$('.checkedLabel').html('<i class="fas fa-check-circle11 text-success11"></i> '+$(this).parent().find('.titleText').text());
			}
		
		}
		 
		 if($(this).attr('data-name')==="echeck"){
			$('#zts-echeck input[name="type"]').val(value_var);
		 }else{
			$('#payment_form_id input[name="midcard"]').val(value_var);
		 }
		 
		 
		if(ewalistVar !== undefined){
			$('.ewalist').hide();
			$('.ewalist').removeClass('active');
			$('.ewalist.'+ewalistVar+'_div').show();
			$('.ewalist.'+ewalistVar+'_div').addClass('active');
			
			ewalist_f($(this).parent().find('label'),ewalistVar,etypeVar);
			//ewalist_f($('.inputValidation'),ewalistVar,etypeVar);
			
			
			//start input name add
			
			$('.ewalist input,.ewalist select, input.ewalist,select.ewalist').each(function(){
				$(this).removeAttr("name");
			});
			
			$('.ewalist.active input,.ewalist.active select, input.ewalist.active,select.ewalist.active').each(function(){
				 dataInputName= $(this).attr('data-name');
				if((dataInputName !== undefined)&&(dataInputName)){
					$(this).attr("name",dataInputName);
				}
			});
			
			//end input name add
			
			$('.ewalist.active .required').each(function(){
				$(this).attr("required","required");
			});

			$('#payment_form_id_ewallets input[name="midcard"]').val(value_var);
		}
		
		//644
		
		if(value_var==644){
			$("#cardsend_submit").eq(0).trigger("click");
			//$("#payhide").eq(0).trigger("click");
			$('.paymentMethodDiv').slideDown(50);
			$('.cardHolder').hide(50);
		}
		
		 
		 
		 if($(this).attr('data-name')==="ewallets"){
		 $('#payment_form_id_ewallets input[name="midcard"]').val(value_var);
		 }
		 
		 if($(this).attr('data-name')==="ebanking"){
		 $('#payment_form_id_ewallets input[name="midcard"]').val(value_var);
		 }
		 
		 if($(this).attr('data-name')==="bhimupi"){
		 $('#payment_form_id_ewallets input[name="midcard"]').val(value_var);
		 }
		 
		 
		 if(curSym==''){
		 curSym=$(this).attr('data-currency');
		 }
		
		
		
		 $('#t_amt').html(curSym);
		 
		 $('.priceSys').html(curSym);
		 $('.currSymbl').html(curSym);
		 
		 
		 
		 
		 
		 $('.ewalletContDiv').hide(); 
		 $('.changeMeth').hide(); 
		//alert(name_var);
		if(name_var=='ewallets'){
			$('.ewallets_div').show();
			//$('.payNextList').addClass('actives');
			$('.changeMeth').show();
		}
		
		var type_var = $(this).attr('data-type');
		if((type_var !== undefined)&&(type_var==='ewalletList')){
			$('.payNextList').addClass('actives');
			
			
			if($('.payNextList').hasClass('actives')){
				
			}else{
				$('.ewalletContDiv').show();
				
			}
		}
		
		 
	});
	
	<? if($data['con_name']!='clk'){ ?>
		//$(".account_types").eq(0).trigger("click");
	<? } ?>
	
	
	$('.upisDiv').click(function(){
		$('.upisDiv').removeClass('active');
		$(this).addClass('active');
		
		var thisVal=$(this).find('.upis').text();
		
		$('.upisDropDown').find('option:contains("'+thisVal+'")', this).prop('selected', 'selected');
		$('.upisDropDown').find('option:contains("'+thisVal+'")', this).attr('selected', 'selected');

   });

	
	$('.walletsDiv').click(function(){
		$('.walletsDiv').removeClass('active');
		$(this).addClass('active');
		
		var thisVal=$(this).find('.wallets').text();
		
		$('.wDropDown').find('option:contains("'+thisVal+'")', this).prop('selected', 'selected');
		$('.wDropDown').find('option:contains("'+thisVal+'")', this).attr('selected', 'selected');

   });

	$('.inputSetp2').click(function(){
		$('.inputSetp2').slideUp(100);
		$('.contInputDiv').slideDown(100);
		$('.contInfoBar').slideUp(100);
		$('.paymentMainDiv').slideUp(0);
		$('#contSubmit').show(0);
		$('body').removeClass('active_pay');
	});	
	$('.inputPaySetp3').click(function(){
		$('.inputSetp2').slideDown(100);
		$('.inputPaySetp3').slideUp(100);
		showPaymentMethod();
	});
		
		$('#priceChange').click(function(){
		 
			$('#priceInputDiv').removeClass('activeInput');
			$('#priceChange').hide(200);
			$('.nextSt').hide(200);
			$('.sIn').show(800);
			
			$('.paymentMethodDiv').hide(50);
			$('.chkname').hide();
			$('#paymentMethodChange').hide(50);
			$('.checkOutOptions').hide();
			$('.contInfoBar').hide();
			
			$('.paymentMethodh4').html('Available Payment Method');
			$('.account_types').removeClass('active');
			$('.cname label').removeClass('active');
		
		});
		
	 $('#contSubmit').click(function(){
		 $('.inputSetp2').slideDown();
		 $('.contInputDivAlert').hide();
		 
		var fullName = $('.contInputDiv input[name="fullname"]').val(); 
		var phone = $('.contInputDiv input[name="bill_phone"]').val();
		var email = $('.contInputDiv input[name="email"]').val();
		
		var bill_street_1	= $('.contInputDiv input[name="bill_street_1"]').val();
		var bill_street_2	= $('.contInputDiv input[name="bill_street_2"]').val();
		var bill_country	= $('.contInputDiv input[name="bill_country"]').val();
		var bill_state		= $('.contInputDiv select[name="bill_state"] option:selected').val();
		var bill_city		= $('.contInputDiv input[name="bill_city"]').val();
		var bill_zip		= $('.contInputDiv input[name="bill_zip"]').val();

		var inputPurpose = $('.inputPurpose').val(); 
		var pric = $('.price90').val();	
		 
		 if(inputPurpose == '') {
			alert("Purpose of Payment can not Blank! Please enter the Purpose");
			$('.inputPurpose').focus();
			return false;
		 }else if(pric == '') {
			alert("Amount can not Blank! Please enter the Amount");
			$('.price90').focus();
			return false;
		 }else if(fullName == '') {
			alert("Full Name can not Blank! Please enter the Full Name.");
			$('.contInputDiv input[name="fullname"]').focus();
			return false;
		 }else if(phone == '') {
			alert("Phone Number not Blank! Please enter the Phone Number.");
			$('.contInputDiv input[name="bill_phone"]').focus();
			return false;
		 }else if(email == '') {
			alert("Email ID not Blank! Please enter the Email ID");
			$('.contInputDiv input[name="email"]').focus();
			return false;
			
		/*}else if(bill_street_1 == '') {
			alert("Address 1 not Blank! Please enter the Address 1");
			$('.contInputDiv input[name="bill_street_1"]').focus();
			return false;
		}else if(bill_country == '') {
			alert("Country not Blank! Please enter the Country");
			$('.contInputDiv input[name="bill_country"]').focus();
			return false;
		}else if(bill_state == '') {
			alert("State not Blank! Please enter the State");
			$('.contInputDiv input[name="bill_state"]').focus();
			return false;
		}else if(bill_city == '') {
			alert("City not Blank! Please enter the City");
			$('.contInputDiv input[name="bill_city"]').focus();
			return false;
		}else if(bill_zip == '') {
			alert("Pin / Zip Code not Blank! Please enter the Pin / Zip Code");
			$('.contInputDiv input[name="bill_zip"]').focus();
			return false;*/
		}else {
		 
			$('.errorDivId').hide();
			$('.contInputDiv').hide();
			$('.paymentMethodDiv').show();
			$('.chkname').show();
			$('.checkOutOptions').hide();
			$('.contInfoBar').show();
			$('.paymentMainDiv').slideDown(100);
			
			$('.fullNmBar').html($('.contInputDiv input[name="fullname"]').val());
			$('.mobileBar').html($('.contInputDiv input[name="bill_phone"]').val());
			$('.emailBar').html($('.contInputDiv input[name="email"]').val());
			
			$('.card-holder div').html($('.contInputDiv input[name="fullname"]').val());
			
			$('.checkOutOptions input[name="fullname"]').val($('.contInputDiv input[name="fullname"]').val());		
			
			$('.checkOutOptions input[name="bill_phone"]').val($('.contInputDiv input[name="bill_phone"]').val());
			
			$('.checkOutOptions input[name="email"]').val($('.contInputDiv input[name="email"]').val());
			
			$('.checkOutOptions input[name="bill_street_1"]').val($('.contInputDiv input[name="bill_street_1"]').val());
			$('.checkOutOptions input[name="bill_street_2"]').val($('.contInputDiv input[name="bill_street_2"]').val());
			$('.checkOutOptions input[name="bill_country"]').val($('.contInputDiv input[name="bill_country"]').val());
			$('.checkOutOptions input[name="bill_state"]').val($('.contInputDiv select[name="bill_state"] option:selected').val());
			$('.checkOutOptions input[name="bill_city"]').val($('.contInputDiv input[name="bill_city"]').val());
			$('.checkOutOptions input[name="bill_zip"]').val($('.contInputDiv input[name="bill_zip"]').val());
			
			$('.checkOutOptions input[name="product"]').val($('.contInputDiv input[name="product"]').val());
			
			$('.checkOutOptions input[name="price"]').val($('.contInputDiv input[name="price"]').val());
			checkPriceVal();
			}
		});
		
	$('.price90').focusout(function(){
		checkPriceVal();  
	});  
	
		$('#paymentMethodChange').click(function(){
		$('body').removeClass('active_pay');
			$(this).hide();
			$('.contInputDiv').hide(0);
			$('.paymentMethodDiv').show(50);
			$('.chkname').show(100);
			$('.checkOutOptions').hide(0);
			
			$('.paymentMethodh4').html('Available Payment Method');
			
			//$('.account_types').removeClass('active');
			//$('.cname label').removeClass('active');
		});
	 
	 //1
	 $('#priceSubmit').click(function(){
		
		var inputPurpose = $('.inputPurpose').val(); 
		var pric = $('.price90').val();	
		 
		 if(inputPurpose == '') {
			alert("Purpose of Payment can not Blank! Please enter the Purpose");
			$('.inputPurpose').focus();
			return false;
		 }else if(pric == '') {
			alert("Amount can not Blank! Please enter the Amount");
			$('.price90').focus();
			return false;
		 }else {
		 
			 if($('#priceInputDiv').hasClass('activeInput')){
				$('#priceInputDiv').removeClass('activeInput');
				$('#priceChange').hide();
				
				$('.nextSt').hide();
				$('.sIn').show();
			} else {
			
				 
					var amt_g=$('.price90').val();
					var amt_l='';
					
					
					if (amt_g.indexOf('.') <= 0) {
						amt_g=amt_g+".00";
					}
					
					if (amt_g.indexOf('.') >= 0) {
						 var amtg=amt_g.split(".");
						 amt_l=amtg[1];
						 amt_g=amtg[0];
						 
					}
					 
					 var crNm='₹';
					 
					if(curSym){
						crNm=curSym;
					}
		 
					 var crn=$('.price #t_amt').html();
					 if(crn){
					 crNm=crn;
					 }
				
				$('.checkOutOptions input[name="price"]').val(pric);
				
					$('#priceInputDiv').addClass('activeInput');
					$('#priceChange').show(700);
					
					$('.txtPurpose').html($('.inputPurpose').val());
					$('.txtAmount').html('<span class="currSymbl">'+crNm+'</span><span class="nPayb 88">'+amt_g+'</span>.'+amt_l);
					$('.nPay').html('<span class="currSymbl">'+crNm+'</span><span class="nPayb 99">'+amt_g+'</span>.'+amt_l);
					$('.submit_div .contitxt').html("<span style=''>Pay </span> "+'<span class="currSymbl">'+crNm+'</span><span class="nPayb 11">'+amt_g+'</span>.'+amt_l);
					
					$('.sIn').hide();
					$('.nextSt').show();
				}
		}
	});
	
	var billerEmpaty='';

	<? if(empty($post['fullname']) || empty($post['bill_phone']) || empty($post['email']) || ( isset($post['step']) && $post['step']==1 && isset($data['Error']) ) ){ ?>
			billerEmpaty='ok';	
	<? } ?>
				
	if(billerEmpaty==''){
		$('#contSubmit').trigger("click");
	}
		<? if(!isset($post['pricManual'])){ ?> 
			//$('#priceSubmit').trigger("click");
			if(billerEmpaty==''){
				$('#contSubmit').trigger("click");
			}
			
			var amt_g="<?=prnsum2($post['price']);?>";
			var amt_l='';
			if (amt_g.indexOf('.') <= 0) {
				amt_g="<?=prnsum2($post['price']);?>"+".00";
			}
			
			//if($('.author-info:contains("/")'){
			if (amt_g.indexOf('.') >= 0) {
				 var amtg=amt_g.split(".");
				 amt_l=amtg[1];
				 amt_g=amtg[0];
				 
			}
			 
			 var crNm='₹'; 
			 if(curSym){
				crNm=curSym;
			}
			 var crn=$('.priceSys #t_amt').html();
			 if(crn){
			 crNm=crn;
			 }
			
			 $('.nPay').html('<span class="currSymbl">'+crNm+'</span><span class="nPayb 22">'+amt_g+'</span>.'+amt_l);
			$('.txtAmount').html('<span class="currSymbl">'+crNm+'</span><span class="nPayb 33">'+amt_g+'</span>.'+amt_l);
			$('.submit_div .contitxt').html("<span style=''>Pay </span> "+'<span class="currSymbl">'+crNm+'</span><span class="nPayb 44">'+amt_g+'</span>.'+amt_l);
			
			
			$('.errorDivId').hide();
			$('.nextSt').show();
			
			if(billerEmpaty=='ok'){
			
				$('.contInputDiv').show();
				$('.paymentMethodDiv').hide();
				$('.paymentMainDiv').hide(); // Added By Vikash
			}else{	
				$('.contInputDiv').hide();
				$('.paymentMethodDiv').show();
				$('.paymentMainDiv').show(); // Added By Vikash
			}
			
			$('.chkname').show();
			$('.checkOutOptions').hide();
			$('.contInfoBar').show();

		<? } ?>

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
   

	//------------------------------

	$('.otherPaymentMethodLink').click(function(){
		$('.universalWisePay').removeClass('hide1');
		$('.countryWisePay').removeClass('hide1');
		
		$('.otherPaymentMethodLink').hide(50);
		$('.goBackPaymentMethodLink').show();
		
		if($('.payNextList').hasClass('actives')){
			$('.ewalletContDiv').show();	
		}
			
	});
	
	$('.goBackPaymentMethodLink').click(function(){
		$('.universalWisePay').addClass('hide1');
		$('.countryWisePay').removeClass('hide1');
		
		$('.otherPaymentMethodLink').show(50);
		$('.goBackPaymentMethodLink').hide(50);
		if($('.payNextList').hasClass('actives')){
			$('.ewalletContDiv').show();	
		}
	});

	$('#paymentMethodChange').click(function(){
		showPaymentMethod();
	});
	 

   //------------------------------
	
	<? if(isset($_SESSION['re_post']['failed_type'])&&$_SESSION['re_post']['failed_type']){ ?>
		
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
		$('.slidePaymentDiv').show(100);
		$('#paymentMainDiv').show(100);
		
		$('body').addClass('oops3');
		$('body').removeClass('oops2');
	});


   setTimeout(function(){
	$(".goog-te-combo option:first-child").text('English');
	$('.translateDiv').show(100);
   },2000); 
   
   
   //-------------------------------------------
   
   
   $('.payNextList').click(function(){
					
		$('.pay_div').hide(50);
		//$('.pay_div').show(50);
		$('.ebanking_div').hide(50);
		$('.bhimupi_div').hide(50);
		$('.evoilatecard_div').hide(50);
		$('.evoilatecard_div').hide(50);
		$('.paymentMethodDiv').hide();
		
		
		$('.checkOutOptions').show();
		$('.ewalletContDiv').show();
		$('.otherPaymentMethod2').show();
		$('.inputype').removeClass('actives');
		
		
		$(this).addClass('actives');
		$('label').removeClass('active');
		$(this).find('label').addClass('active');
		
		$('body').removeClass('active_option');
		$('body').addClass('active_pay');
		$('.checkedLabel').html('Wallets List');
		
		//alert($(".ewalletPayOption .account_types").length);
		if($(".ewalletPayOption .account_types").length==1){
			//alert($(".ewalletPayOption .account_types").eq(0).val());
			$(".ewalletPayOption .account_types").eq(0).trigger("click");
			
		}
		
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

function checkPriceVal(){
	var amt_g=$('.price90').val();
	var amt_l='';
	
	
	if (amt_g.indexOf('.') <= 0) {
		amt_g=amt_g+".00";
	}
	
	if (amt_g.indexOf('.') >= 0) {
		 var amtg=amt_g.split(".");
		 amt_l=amtg[1];
		 amt_g=amtg[0];
		 
	}
   
	var crNm="<?=get_currency($post['curr']?$post['curr']:$_SESSION['curr']);?>";
   
	if(curSym){
		crNm=curSym;
	}

   var crn=$('.price #t_amt').html();
   if(crn){
	 crNm=crn;
   }

	$('.checkOutOptions input[name="price"]').val(amt_g);

	$('#priceInputDiv').addClass('activeInput');
	//$('#priceChange').show(700);

	$('.txtPurpose').html($('.inputPurpose').val());
	$('.txtAmount').html('<span class="currSymbl">'+crNm+'</span><span class="nPayb 55">'+amt_g+'</span>.'+amt_l);
	$('.nPay').html('<span class="currSymbl">'+crNm+'</span><span class="nPayb 66">'+amt_g+'</span>.'+amt_l);
	$('.submit_div .contitxt').html("<span style=''>Pay </span> "+'<span class="currSymbl">'+crNm+'</span><span class="nPayb 77">'+amt_g+'</span>.'+amt_l);
}

function showPaymentMethod(){
	$('body').addClass('active_option');
	$('.inputype.the_icon').removeClass('actives');
	$('.account_types').removeClass('active');
}
</script>
  <? if(!empty($post['nick_name_check'])){ ?>
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
		
		for (var clients in data)
		{
			coltype = typeof data[clients];

			table.append($("<tr>")
					.append($("<td>").text(clients))
					.append($("<td>").text(data[clients]))
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
		/*
		var str = "";
		$('.key_input').each(function(){
		str += $(this).val();
		});
		str = str.replace(/\s/g, '');
		$("#number").val(str);
		*/
	}

	
	function stringHasTheWhiteSpaceOrNot(value){
		 return value.indexOf(' ') >= 0;
	}
	
	function limit(element, max, getId, nextId) {
		var thisValue = (element.value);
		
		var max_chars = max;
		if(thisValue.length > max_chars) {
			element.value = thisValue.substr(0, max_chars);
			//document.getElementById(nextId).focus();
		} 
		
		if(getId==='int16' && document.getElementById(getId).value.length>0){
			document.getElementById('expMonth').focus();
		}
		else if( (getId!='int16' ) && ( document.getElementById(nextId).value !='' )  && ( document.getElementById(getId).value.length > 0 ) ){
			conc();
			document.getElementById('expMonth').focus();
		}
		conc();
	}
	
	function keypressf(element, getId, nextId) {
		//limit(element, 1, getId, nextId);
		if(getId=='int16'){
			//alert(document.getElementById(getId).value);
			//document.getElementById('expMonth').focus();
		}else if(document.getElementById(getId).value.length==0 && document.getElementById(getId).value!=' ' && document.getElementById(nextId).value==''){
			document.getElementById(nextId).focus();
			conc();
			return true;
		}
		
	}
	

$(document).ready(function(){  

	$('.key_input2').on('paste', function(e) {
		alert($(this).val());
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
				///alert("2=>"+text);
				if (window.getSelection) {
					var newNode = document.createElement("span");
					newNode.innerHTML = text;
					window.getSelection().getRangeAt(0).insertNode(newNode);
				} else {
					document.selection.createRange().pasteHTML(text);
				}
				///alert("3=>"+text);
			}
		} else {
			text = clp.getData('text/plain') || "";
			if (text !== "") {
				text = text.replace(/<[^>]*>/g, "");
				//alert("4=>"+text);
				document.execCommand('insertText', false, text);
			}
		}
		//alert("5=>"+text+'\r\n1=>'+text[0]);
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
			//conc();
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
	
	if($("#number").val()!=''){
		$("#number").trigger('keyup');
	}
	
	<?if(isset($post['midcard'])&&trim($post['midcard'])&&$post['midcard']>0){?>
		$(".account_types[value='<?=$post['midcard']?>']").trigger("click"); 
	<?}?>

	
});	


</script>
<style>
.oops2 .hide2 {display:none;}
.modal_msg_close {position:absolute;z-index:99;float:right;right:0;top:0;width:30px;height:30px;font:800 40px/30px 'Open Sans';color:#fff!important;background:#f30606;text-align:center;border-radius:110%;overflow:hidden;cursor:pointer;}
.modal_msg_close2 {position:absolute;z-index:99;float:right;left:50%;bottom:6px;width:60px;height:30px;font:400 18px/30px 'Open Sans';color:#fff!important;background:#274382;text-align:center;border-radius:3px;overflow:hidden;cursor:pointer;margin:0 0 0 -30px;}


.modal_msg_body {top:50% !important;}
.modal_msg_body .suButton {width:50% !important;/*padding: 18px 0;border-radius:6px !important;*/}
.modal_msg_body .submit_div {width:50%;margin:0;}
.modal_msg_body #cardsend_submit {width:100% !important;}
.modalMsgContTxt p {font-size:16px;margin:5px 0;float:left;clear:both;width:100%;}

.emailBar{float:left;width:166px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.container-fluid.fixed {background:transparent;}
.paymentMethodh4{/*padding:5px 0 0 0;color:#898989;font-size:14px;clear:both;float:left;width:100%;margin:0;text-align:center;position:relative;*/}
.modalMsgContTxt {padding:10px 20px;}
.processall .modalMsgContTxt h4{margin: 10px 0px;}

.universalWisePay {display:block;}
html .universalWisePay.hide1 {display:none !important;}
#cardsend_submit i, .suButton i {display:none;}
#cardsend_submit, .suButton{/*width:100%;margin:0 auto;float:none;padding:10px 0;font-size:24px;border:2px solid #fff!important;border-radius:5px;*/}

html .modal_msg_body .suButton {/*padding: 13px 0;*/}


	
html body, body, .green, .blue {top:0 !important;background:#fff !important;background-color:#fff !important;height:100vh;}
body .w94,body input[type=text].w94{/*min-width:100%!important;width:100%!important;*/float:none;margin:0 auto;display:block}
.oops2{margin:0;padding:0;overflow:auto;width:100%;height:100%;background: url("<?php echo $data['Host'];?>/images/criss-cross.png");border-color:#d6e9c6;}
.oops2 .container-fluid.fixed {background: url("<?php echo $data['Host'];?>/images/criss-cross.png");}
.timerText{clear:both;width:100%;text-align:right;margin:0 0 10px}.timer{font-weight:700;font-size:18px}
.alertPaymentDiv{border:4px solid #ccc;padding:0 5% 30px;background:#fff;border-radius:10px; margin:0 auto;max-width:400px;}
.credit-card-box {width:340px;height:228px;position:relative;top:8px;left:0px;float:none;display:block;margin:auto;}
.credit-card-box.hover .flip {-webkit-transform:rotateY(180deg);transform:rotateY(180deg);}
.credit-card-box .front,
.credit-card-box .back {width:340px;height:210px;border-radius:15px;-webkit-backface-visibility:hidden;backface-visibility:hidden;position:absolute;color:#fff;
	top:0;left:0;text-shadow:0 1px 1px rgba(0, 0, 0, 0.3);box-shadow:0 1px 6px rgba(0, 0, 0, 0.3);background-image: linear-gradient(to right top, #092856, #002a66, #002b75, #012c84, #132b92);}

html #credit_cards img {width:12.6%;}
html #credit_cards.img_3 img { width: calc(100% / 3) !important;}
html #credit_cards.img_4 img { width: calc(100% / 4) !important;}
html #credit_cards.img_5 img { width: calc(100% / 5) !important;}
html #credit_cards.img_6 img { width: calc(100% / 6) !important;}
html #credit_cards.img_7 img { width: calc(100% / 7) !important;}
.credit-card-box .logo_card_icon {position:absolute;top: 17px;
right: 8px;width:256px; text-align: right;}
.credit-card-box .logo_card_icon svg {width:100%;height:auto;fill:#fff;}
.credit-card-box .front {z-index:2;-webkit-transform:rotateY(0deg);transform:rotateY(0deg);}
.credit-card-box .back {-webkit-transform:rotateY(180deg);transform:rotateY(180deg);}
.credit-card-box .back .logo_card_icon {top:185px;}
.credit-card-box .chip {position:absolute;width:60px;height:45px;top:12px;left:5px;background: url(<?=$data['Host'];?>/images/card-chip.png) -2px no-repeat;background-size:70px;border-radius:8px;}
.credit-card-box .chip::before {content:'';position:absolute;top:0;bottom:0;left:0;right:0;margin:auto;border:4px solid rgba(128, 128, 128, 0.1);width:80%;height:70%;border-radius:5px;}
.credit-card-box .strip {background:linear-gradient(135deg, #404040, #1a1a1a);position:absolute;width:100%;height:50px;top:30px;left:0;}
.credit-card-box .number {position:absolute;margin:0 auto;top:82px;left:19px;font-size:38px;}
.credit-card-box label {font-size:10px;letter-spacing:1px;text-shadow:none;text-transform:uppercase;font-weight:normal;opacity:0.5;display:block;margin-bottom:-4px;}
.credit-card-box .card-holder,
.credit-card-box .card-expiration-date {position:absolute;margin:0 auto;top:164px;left:13px;font-size:16px;text-transform:capitalize;}

.the-most {position:fixed;z-index:1;bottom:0;left:0;width:50vw;max-width:200px;padding:10px;}
.the-most img {max-width:100%;}

.merchant_logo {position: relative;top:-42px;margin-bottom:-25px;text-align: center;}
.merchant_logo img {height: 70px;}


body, .container-fluid.fixed {border:0px solid #dddddd;}

.totalHolder {position:relative;display:table-cell;width: 240px;background: <?=$_SESSION['background_g']?>;color:<?=$_SESSION['color_g'];?>;text-align: left;margin: 0 10px 0 0;line-height:250%;}
.title_2 {color:#fff !important;}
.totalHolder .b {text-align: left;color: <?=$_SESSION['background_gl7'];?>;margin: 10px 0 0 0;}
.totalHolder .txts {font-size: 20px;padding: 0 0 8px 0;margin: 0 0 7px 0;}
.totalHolder .txts.pro {max-height:100px;overflow:hidden;}
.dark1 {position:absolute;bottom:0;background: <?=$_SESSION['background_gd7'];?>;color: #fff;text-align: right;float: left;width: 100%;height: inherit;line-height: 230%;}
.amount_total {font-size: 40px !important;}
.pad10 {padding:10px;}
.paymentMainDiv {float:left;width:100%;display:none;clear:both;overflow:hidden;border-radius:0 0 20px 20px;}
.active_pay .paymentMainDiv {/*padding:20px 0;*/}
table{max-width:90%;}
.cardHolder {display:none;/*width:50%;margin:10px 0 10px;background:transparent;border-radius:0 0 20px 0;*/}
.ti, .capl {font-weight: normal !important;color: #023b80 !important;font-size: 24px;}
.result_view {font-size: 11px;}
INPUT.submit, .btn-primary {/*border-radius:0;color:#fff !important;background:#74278F!important;*/}
.processall TABLE, .processall TR, .processall TD, .processall TH {font-size: 11px;color: #666;background: none;}
.processall TD.field {padding: 8px;color: #444444;background-color: #F2F4F7;text-align: right;vertical-align: top;font-weight: bolder;}
.processall TD.input {line-height: 22px;background-color: #F2F4F7;vertical-align: top;padding: 4px;}
.processall TD.capl {background: url(<?=$data['Host'];?>/css/customisation/images/bg-headers.png) repeat scroll -50px center transparent;padding: 9px 0px;color: #fff;font-weight: normal;-webkit-border-top-left-radius: 3px;-webkit-border-top-right-radius: 3px;-moz-border-radius-topleft: 3px;-moz-border-radius-topright: 3px;border-top-left-radius: 3px;border-top-right-radius: 3px;font-size: 14px !important;}

.err_tr {padding:0 !important;margin:0 !important;}
.hide{display:none;}
.ctittle {float: left;padding-right: 10px;}
.cname {float:left;clear:both;width:100%;}
.cname .inputype {/*float:left;white-space: nowrap;margin: 0 12px 0 0;clear: both;*/}

.cname .inputgroup {float:left;white-space: nowrap;width:98%;}
.cname label {font-size:12px;white-space:nowrap;display:inline-block;line-height:18px;width:100%;text-align:center;}

.account_types.active {color:orange !important;}
label.active {color:orange !important;font-weight:bold;}
input.account_types {padding: 0;margin:0 5px 0 0;float:left;position:relative;height:18px;line-height:30px;min-width:30px;;background:transparent !important;border: 0px solid #CECECE;-moz-box-shadow: 0 0px 0px #E5E5E5 inset;-webkit-box-shadow: 0 0px 0px #E5E5E5 inset;box-shadow: 0 0 0px 0px #E5E5E5 inset;padding: 0;}
.clients_pro input.account_types{top:2px;background:transparent;} 
.payment_option {width:100%;padding:0;position:relative;}
.payment_option img {width:44px !important;}
.echeck_div, .pay_div {display:none;clear:both;float:left;width:100%;padding:0 2%;}

.processall {padding:0;}
.processall h4 {color: #023b80;font-size: 20px;font-weight: lighter;margin: 10px 5px;padding: 0;}
.pay_div .separator {margin: 0px 0 !important;float: left;width: 100%;height: 6px;}
.form-group {float: left;width: 100%;text-align:left;position:relative;}
INPUT, SELECT, TEXTAREA{
/*min-width:100%;max-width:100%;border:0!important;border-radius:0!important;font-family:'Inter',sans-serif!important;-webkit-box-shadow:inset 0 0 0 #000!important;-moz-box-shadow:inset 0 1px 1px rgba(0,0,0,0.075);box-shadow:inset 0 0 0 #000!important;-webkit-transition:border linear .2s,box-shadow linear .2s!important;-moz-transition:border linear .2s,box-shadow linear .2s!important;-o-transition:border linear .2s,box-shadow linear .2s!important;border-bottom:1px solid #c8bece!important;background:transparent!important*/}

.cardHolder INPUT, .cardHolder SELECT, .cardHolder TEXTAREA{/*height:50px!important;line-height:50px !important;padding:5px 10px 5px 25px; padding-left: 30px;*/ background:#eeeeee;}
.cardHolder SELECT {min-width:98%!important;}
div.processall {margin: 0px auto;border: 0px solid #dddddd;}


#form-input-errors {display:none; float:left; width:100%; text-align:center; color:red; font-size:12px; margin:10px 0 0 0;}
.transparent {opacity: 0.2;}
.has-error {background:#ff0000;border:1px solid #ff0000;}

.maindiv{  display:block; margin:auto; background:#eeeeee;min-height:250px;}
.leftdiv{width:46%;float:left;  height:100%; margin-left:5px;}
.rightdiv{width:46%;float:left;  height:100%}

.p{padding-left: 20px; color:black;}
.iconnocard{ /*width:49px; height:38px;*/ background:#fff url(<?=$data['Host'];?>/images/correctcardplease.png) 98% 6px no-repeat;background-size:8%; float:left; border: 1px solid #b80922 !important;}
.iconvisa{background:#fff url(<?=$data['Host'];?>/images/visa.png) 1% 10px no-repeat !important;background-size:10%!important;background-repeat:no-repeat;}
.iconmastercard{background:#fff url(<?=$data['Host'];?>/images/masdtercard.png) 1% 3px no-repeat !important;background-size:10%!important;background-repeat:no-repeat; background-size: 38px 25px!important;
}
.iconamex{background:#fff url(<?=$data['Host'];?>/images/amex.png) 0% 1px no-repeat !important;background-size:10%!important;background-repeat:no-repeat; }
.iconjcb{background:#fff url(<?=$data['Host'];?>/images/jcbcard.png) 0% 1px no-repeat !important;background-size:10%!important;background-repeat:no-repeat;}
.icondiscover{background:#fff url(<?=$data['Host'];?>/images/discover.png) 0% 1px no-repeat !important;background-size:10%!important;background-repeat:no-repeat;}
#credit_cards #jcb1{height:80px;position:relative;top:-17px;margin:0 0 -32px 0;}
.align{ margin-top:132px;}
.border{ width:38px; float:left;border-radius:6px; }
/*.alert {color: #fff; background: #f00; font-size: 18px; text-align: center; line-height: 30px; width: 100%; padding: 5px 0; margin: 5px 0 25px 0; border-radius: 3px; }*/
.p0 {padding: 0;}
.ecol4{width:44%;float:left;padding-left:9px;padding-top:5px;padding-bottom:5px;padding-right:10px; }


.ecol2.exp_cvv{float:left;width:97%;padding:0 0 0 1%;position:absolute;margin:0 auto;top:120px;left:5px;font-size:38px;line-height:normal;height:38px}

body #expMonth option[disabled] {background: <?=$_SESSION['background_gd8'];?> !important;background-color: <?=$_SESSION['background_gd8'];?> !important;color:#999 !important;}

body #expYear option[disabled] {background: <?=$_SESSION['background_gd8'];?> !important;background-color: <?=$_SESSION['background_gd8'];?> !important;color:#999 !important;}

select:focus,input[type="file"]:focus,input[type="radio"]:focus,input[type="checkbox"]:focus {outline-offset:0!important;outline-color:#60caff!important;border-radius:0!important;border:0;border-bottom:1px solid #e89600;outline:none!important}

<? if(isset($data['re_post'])&&$data['re_post']){ ?>
.merchant_logo {position: relative;top:-10px;margin-bottom:-5px;text-align: center;}
<? } ?>
.translateDiv{display:none;clear:both;width:105px;position:absolute;	z-index:99;float:right;margin:0 0px 10px 210px;background: url("<?php echo $data['Host'];?>/images/lang_4.png") <?=$_SESSION['background_g']?> no-repeat; background-size:18px; background-position:left;}
#google_translate_element {width: 85px;float:left;display:block;margin:0px 0 0 23px ;clear:both;overflow:hidden;height:40px; border:0 !important; }
#google_translate_element select {content: ''; border:0 !important; -webkit-appearance: menulist;-moz-appearance:menulist;padding: 0px 0px;font-weight:bold;color:#d07c00 !important;background: <?=$_SESSION['background_g']?>;color:<?=$_SESSION['color_g'];?> !important;margin:0 0 0 0px;}
#google_translate_element select:focus {outline: unset !important;}
.skiptranslate iframe {display:none !important;}
.oops2, .oops3{margin:0;padding:0;overflow:auto;width:100%;height:100%;background: url("<?=$data['Host'];?>/images/criss-cross.png");border-color: #d6e9c6;}
.oops2 .container-fluid.fixed, .oops3 .container-fluid.fixed {background: url("<?=$data['Host'];?>/images/criss-cross.png");}
.timerText2{clear:both;width:38px;text-align:right;margin:0 0 10px;position:relative;z-index:99}

/*.timerText{clear:both;width:100%;text-align:right;margin:0 0 10px}*/
.timer{font-weight:700;font-size:18px}
/*.alertPaymentDiv{width:80%;border:4px solid #ccc;padding:0 5% 30px;float:left;margin:30px 0 0 5%;background:#fff;border-radius:10px}*/

.input_key_div{display:block;width:100%;clear:both;padding:7px 0}
.credit-card-box .number{left:5px;top:78px;}
.number .key_input{width:18px !important;min-width:18px;max-width:18px;height:38px;outline:none !important;padding:0 0px;text-align:center;font-size:24px;letter-spacing:normal;font-weight:bold;border-radius:5px !important;border:1px solid #9d9d9d;display:inline-block;float:left;position:relative;z-index:9999;margin:0px 0px 0 1px;}
.number .key_input.bri{background:#dddddd;}

.number .key_input.lgt1 {margin:0 0px 0 0 !important;}
.number .key_input.rgt {margin:0 0 0 8px !important;}

.merchantLogo{position:relative;float:unset;margin:0;padding:2px;border-radius:4px;overflow:hidden;width:5%;display:table-cell;text-align:left;vertical-align:middle;}
.compAmt {float:unset;display:table-cell;padding:0 0 0 10px}
.merchantLogo img {height:56px;max-width:inherit;}
.company{float:left;height:inherit;line-height:NORMAL;padding:5px 0 4px;font-size:18px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-weight:600;text-transform:uppercase;text-align:left;clear:right;width:100%;}
.payingTo {font-weight:normal;position:relative;color:#fff;text-transform:uppercase;font-size:14px;letter-spacing:1px;margin-bottom:0;opacity:.8;padding-top:5px;text-align:left;}
.nPay.top {float:left;font-size:16px;margin-top: -10px;}
.nPay .nPayb {/*font-size:22px;*/}
	
.step_1 label {display:none;}
.capc {background: transparent !important;}
.payingMdiv {position: relative;
    float: left;
    font-weight: bold !important;
    background: #EBEBEB;
    border-radius: 5px 5px 5px 5px;
    display: table;
    vertical-align: top;
    width: 100%;
    min-width: 300px;
    border-color: #ffa800;
	border-style: solid;
	border-width: 1px!important;
	min-height: 60px;
	} 


.ecol2{width:100%;padding:5px;}


.content_top{/*width:360px;margin:10px auto*/}
.border_con {max-width: 760px; margin: 0 auto;/*border:0px solid #00a4f6;border-radius:20px;float:left;margin-bottom:48px;background:#fff;background-color: #ffffff;max-width:360px;-webkit-box-shadow:0px 2px 20px -10px rgb(0 0 0 / 30%);-moz-box-shadow:0px 2px 20px -10px rgba(0, 0, 0, 0.3);box-shadow:0px 2px 20px -10px rgb(0 0 0 / 30%);overflow:hidden;*/} 
.oops2 .border_con{border:0 solid #e6b688;border-radius:0 0 0 0;margin-bottom:0;background:transparent}


.checkOutOptions {display:none;}
.credit-card-box {left:2px;}

.inputype .glyphicons i:before {top:6px;font-size: 33px;color:#74278F;}
.card_icon_pay{ display:none;float:left;width:44px;height:40px;padding:0;margin:0}
.card_icon_pay i {font-size:24px;margin:7px 0 0;color:#74278F}
.titleLabel{/*margin-top:4px;white-space:nowrap;text-overflow:ellipsis;*/text-align:left;/*width:calc(100% - 60px)!important;font-weight:700;color:#5D008F;overflow:hidden;*/}
.titleText{/*margin-top:5px;font-weight:400;font-size:12px;color:#4a4a4a;display:block;white-space:normal;overflow:hidden;text-overflow:unset;text-align:left;max-width:162px*/}


.btn-primary{background:#37a6cd;border:1px solid #2a87a7;color:#fff;text-shadow:0 0 0 rgba(0,0,0,0.5)}	
.chkname {float:left;width:100%;}
.processall .paymentMethodDiv h4 {color:#023b80;font-size:16px;text-align:left;}
.paymentMethodDiv .cname .inputype:hover, .paymentMethodDiv .cname .inputype.actives {
	border:1px solid #fff;
	background:#ffa400 !important;
	color:#111111 !important;
}

.ewalletPayOption label:hover .titleText{
	color:#fff!important;
}	
.ewalletPayOption label:hover, .ewalletPayOption .cname .inputype.actives {
	border:1px solid #fff;
	background:#f5f5f6 !important;
	color:#fff!important;
}

.paymentMethodDiv .cname .inputype:hover *, .paymentMethodDiv .cname .inputype.actives * {color:#fff;cursor:pointer;}
.paymentMethodDiv .inputype * {cursor:pointer;}
.paymentMethodDiv .cname .inputype {width:100%;height:auto;border:1px solid #ccc;background:#fff;margin:-1px 0;padding:7px 15px;border-radius:0;border-left:0;border-right:0;position: relative;}
.inputype .fa-circle-right {position:absolute;top:10px;right:10px}
.paymentMethodDiv .cname label {font-weight:bold;width:100%;margin:0px 0 -3px 0;white-space: nowrap;text-overflow:ellipsis;overflow:hidden;}
.cname .inputgroup {float:left;width:100%;}
.paymentMethodDiv .cname {width:100%; }
.paymentMethodDiv input.account_types {display:none;}
.payOpt{float:left;width:94%;}
.nPayb {/*font-weight:bold;font-size:28px;*/}
.activeInput input[type=password], .activeInput input[type=text], input[type=email], .activeInput input[type=url], .priceInputDiv select, .activeInput label.input2, .activeInput 
.brec111 {float:left;width:94%;font-weight:normal;border-top:1px solid #ececec;border-bottom:1px solid #ececec;margin:10px 0 10px 3%;padding:3px 0 5px 0;font-size:16px;}

.brec {width: auto; 
  	   font-size: 16px;
	   text-align: center !important;
	   }

.contInputDiv .la12 {margin:14px 0 3px 2px;display:block;color:#C5C5C5;font-size:14px}
.activeInput .labelAmount {margin:20px 0 0 0;}
.txIn {float:left;width:94%;font-size:18px;font-weight:400;text-align:left;padding:0;color:#028cd1;}
.btn.next {margin: 0px auto;/*width:100%;margin:20px 0 15px;padding:14px 0;font-size:22px;border-radius:0;color:#fff!important;font-weight:400;background:#74278F!important;*/}
.glyphicons.btn-icon.next i:before {width:36px;height:33px;padding:17px 0 0;}
input[type=password], input[type=text], input[type=email], input[type=tel], input[type=url], select {/*font-size:16px;*/ background:#eeeeee;}
.la12 {float:left;width:100%;text-align:left;font-size:15px;margin:16px 0 0;cursor:none}
html .sIn {position:relative;float:left;width:100%;clear:both}
.rws {position:relative;float:left;width:100%;clear:both;}
.priceInputDiv, .contInputDivPlace{float:left;display:block;background:#F9F9F9;width:100%;}
.inpuIconDiv {position:relative;display:block;float:left;width:100%}
.inpuIconDiv .inpuIcon {top: 10px;left: 7px;}
.inpuIcon .fas{font-size:16px;}
.amount_total.price, .inpuIcon {display:block;position:absolute;/*z-index:1;left: -5px;top: 30px;float:left;width: 15px;background:transparent;height:47px;overflow:hidden;border-radius:3px 0 0 3px;font-size:28px!important;color:#8989a7;*/}
.inpuIcon.glyphicons i::before {top:3px;color:#8989a7;font-size:18px;left:3px}
.contInfoBar .inpuIcon{position:relative;width:20px;height:14px;margin:0;padding:0;display:block;}
.contInfoBar .inpuIcon.glyphicons i:before{top:0;color:#8989a7;font-size:14px;left:1px}
.inputSetp2,.inputPaySetp3 {display:none;}

.change{right:0px;display:none;overflow:hidden;/*position:relative;z-index:9999;left:25px;top:0px;float:left;width:100%;height:36px;line-height:25px;font-size:14px;font-weight:100;font-weight:normal;background-image:url(<?=$data['Host'];?>/images/back--v1.png); background-size:21px;background-repeat:no-repeat;background-position:20px 14px;*/}



.changeMeth {display:none;float:left;width:99%;text-align:center;font-size:16px;padding:0;background:var(--background-1)!important;border-radius:5px;color:#fff!important;margin:8px 0 0 4px;line-height:30px;}
.checkedLabel {clear:both;text-align:center;font-weight:700;margin:10px 0 0;float:left;width:99%;font-size:18px;}

.ewalletPayOption .inputype.the_icon{width:50%;}
.ewalletPayOption label{font-size:16px;max-width:100%;margin:9px 0 0;border:1px solid #ffa400;padding:11px;border-radius:5px;background:#fff;}
.ewalletPayOption .titleText{/*width:100%;float:left;max-width:100%;min-width:100%;font-size:16px;margin:0!important;*/}


.change2{position:absolute;font-size:16px;float:right;font-weight:700;margin:11px 0;right:7px;z-index:11;text-decoration:underline;color:#08c!important}
input[type=text].price90, html .input_con{/*float:left;width:100%!important;max-width:100%;min-width:100%;position:relative;z-index:5;padding: 2px 10px 2px 25px;border-radius:0px!important;*/}

html .inputBgW .input_con {float:left;width:85%!important;max-width:85%;min-width:85%;background:transparent!important;background-color:transparent!important}
.brec66{background:transparent;float:left;width:100%;text-align:left;padding:10px 0;color:#000;font-size:14px;font-weight:700;}
.contInputDiv {background:#fff;border-radius:20px;}
.imgIcn1 img {height: 40px !important;}
.imgIcn1 {padding:2px 20px;background:#fff;width:324px;position:relative;z-index:99;float:left;clear:both;text-align:center} 
.contInfoBar {float:left;width:96%;border-top:1px solid #ccc; margin:16px 0 6px 0;padding: 0 2%;text-align:left;}
.contInfoBar .fullNmBar {font-weight:bold;font-size:14px;margin:7px 0 0px 0;} 
.checkOutOptions .glyphicons.btn-icon.next i:before {width:36px;height:33px;padding:23px 0 0;}
.checkOutOptions .contitxt {/*width:100%;float:right;padding:0;text-align:center;position:relative;top:5px;*/}
.checkOutOptions .submit_div{margin-bottom:10px;}
.submit_div{width:100%;padding:0;margin:10px auto;height:auto;float:left;}
.upisDiv img {height:30px;display:inline-block;line-height:50px;vertical-align:middle;width:auto;/*margin:11px auto 0 auto;*/}


.banksDiv.active, .walletsDiv.active {background:<?=$_SESSION['background_gd5'];?>;color:#fff;}
.banksDiv, .walletsDiv, .upisDiv {display:table-cell;vertical-align:middle; text-align:center;width:45%;height:50px;line-height:50px;border:1px solid #ccc;border-radius:3px;float:left;margin:5px 13px 10px 0;background:#efefef;cursor:pointer;}



.banksDiv.active, .appLogoDiv.active {background:<?=$_SESSION['background_gd5'];?>;color:#fff;}
.banksDiv, .appLogoDiv, .upisDiv {display:table-cell;vertical-align:middle; text-align:center;width:46%;height:50px;line-height:50px;border:1px solid #ccc;border-radius:3px;float:left;margin:5px 13px 10px 0;background:#efefef;cursor:pointer;}	
.appLogoDiv img, .walletsDiv img { display: block;height: 40px !important; width:auto !important;margin: 0 auto}
.bankNm{padding-left:16px;font-size:16px;text-transform:uppercase;}
.banks_bank_1, .banks_sprite {background-image:url(<?=$data['Host']?>/images/banks-sprite.png);width:32px;display:inline-block;line-height:50px;position:relative;top:-2px;}
.banks_bank_1 {background-position:0 -42px;height:31px;}
.banks_bank_2 {background-position:-32px 0;height:38px;}
.banks_bank_3 {background-position:-64px 0;height:33px;}
.banks_bank_4 {background-position:-96px -29px;height:29px;}
.banks_bank_5 {background-position:0 -73px;height:28px;}
.banks_bank_6 {background-position:-64px -42px;height:31px;}
.banks_bank_7 {background-image:url(<?=$data['Host']?>/images/idfc_bank_logo.png);background-position:0;height:29px;background-size:30px;background-repeat:no-repeat;}

.contInputDivPlace ::placeholder {color:#8989a7;opacity:1;}
.contInputDivPlace :-ms-input-placeholder {color:#8989a7;}
.contInputDivPlace ::-ms-input-placeholder {color:#8989a7;}

.front ::placeholder {color:#fff;opacity:1;}
.front :-ms-input-placeholder {color:#fff;}
.front ::-ms-input-placeholder {color:#fff;}

.active_pay .content_top {max-width: 760px; margin: 0 auto;}
.active_pay .border_con {max-width:100%;width:100%;border-radius:0 0 0 20px;}
.active_pay .paymentMethodDiv {/*float:unset;width:50%;display:table-cell !important;vertical-align:top;*/}
.active_pay .cardHolder{display:block;/*width:100%;vertical-align:top;padding:0 10px;*/}
.paymentMethodDiv .cname .inputype {width:100%;float:unset;display:block;margin:2px auto;border-radius:5px;border:1px solid #ccc!important;position:relative;background: #eeeeee;}
.active_pay .paymentMethodh4, .active_pay .change2 {display:none;}
.active_pay .payment_option{padding:0 10px;background:transparent;}
.active_pay .payingLdiv {float:left;width:100%;display:table-cell;}
.active_pay .contInfoBar{float:right;width:32%;border-top:0;text-align:right;margin:0;padding:0 3px 0 0;}
.active_pay .contInfoBar div{float:right!important;width:100%!important;text-align:right;font-weight:normal;padding:0 26px 0 0 !important;display:table-cell!important;}
.active_pay .contInfoBar div.inpuIcon{float:right!important;width:20px!important;top:15px!important;padding:0!important;margin:-10px 0!important;}

.active_pay.active_option .paymentMethodDiv .cname .inputype{display:block;}

.backimg {height:30px;clear:both;margin:20px 0;float:left;text-align:center;width:100%;cursor:pointer;}
.backimg:hover {opacity:0.7;}


.block-form-py{/*background:#fff;*//*border-radius:8px;box-shadow:0 0 6px 0 #838383;height:inherit;margin:10px 0 20px;float:left;clear:both;width:100%*/}

.input_label{color:#C5C5C5;font-size:12px;}

.form-box { 
			border-radius: 5px 5px 5px 5px;
			box-shadow: 0px 5px 10px 0px rgb(0 0 0 / 50%);
			background: #fff;
		    padding:20px;
			float: left;
		  }
.btn-template {
    color: #111111;
    background-color: #fff7e8;
    border-color: #eadeb4;
	width:100%;
	font-weight:500;
	
	
}
.exp_date{width:50%;}
.exp_month{width:20%;}
@media (max-width: 999px){
	.modal_msg_body {
		left: 50%;
		top: 50% !important;
		margin: -100px 0 0 -151px;
	}

}

@media (max-width:759px){ 
	.active_pay .content_top {width:98%;}
	.banksDiv, .appLogoDiv, .upisDiv {width:100% !important;}
}


@media (max-width:550px){ 
	.ecol4{width:100%;padding:0;}
	.active_pay .paymentMainDiv, .active_pay .paymentMethodDiv, active_pay .cardHolder {/*display:block !important;*/width:100% !important;float:left;}
	.checkOutOptions{display:none;padding:0;float:left;width:100%;}
	.active_pay .paymentMethodDiv .cname .inputype{/*display:none;*/}
	.active_pay .paymentMethodDiv .cname .inputype.actives{display:block;}
	.active_pay .contInfoBar {float:left;width:100%;border-top:1px solid #fff;margin:18px 0 0 0;}
	.active_pay .contInfoBar div {text-align:left;padding:0 0 0 26px !important;width:94%!important;}
	.active_pay .contInfoBar div.inpuIcon {float:left!important;}
	.active_pay .cardHolder{float:left;width:100%; margin-top:0.5rem !important; margin-bottom:0.5rem !important;}
	.active_pay .paymentMethodh4, .active_pay .change2 {display:block;}
	.active_pay .paymentMainDiv {padding:0px 0;}
	.active_option .cardHolder {display:none;}
	.banksDiv, .appLogoDiv, .upisDiv {width:100% !important; }
	.exp_date{width:100%;}
	.exp_month{width:45%;}
}	
@media (max-width:400px){ 
.iconmastercard{ background-size: 38px 25px!important;}
}
</style>
<style>
.main-template-border { 
  box-sizing: border-box;
  /*width: 820px;
  height: 420px;*/
  background-color: #111111;
  overflow: visible;
  border-radius: 5px;
  border-color: #ffa800;
  border-style: solid;
/*  border-top-width: 2px;
  border-bottom-width: 11px;
  border-left-width: 10px;
  border-right-width: 2px;*/
  min-height:400px;
  border-width: 1px!important;
}
.inner-template-border{
   
  box-sizing: border-box;
  /*box-shadow: -15px 15px 2px 0px rgba(0, 0, 0, 0.25);*/
  overflow: visible;
  border-radius: 5px 5px 5px 5px;
  /* border-color: #ffa800;
  border-style: solid;
 border-top-width: 0px;
  border-bottom-width: 5px;
  border-left-width: 5px;
  border-right-width: 0px;*/
}
.p_title{
  letter-spacing: 0.9px;
  line-height: 1.2;
}
.p_text {

  letter-spacing: 0.9px;
  line-height: 1.2;
}
.p_id{
  letter-spacing: 0.9px;
  line-height: 1.2;
}

.p_id_text .titleLabel{
  letter-spacing: 0.9px;
  line-height: 1.2;
}
.form_field_title {

}
.title_underline {width: 130px;height: 7px;background-color: #4984b8;overflow: hidden; margin: 0 auto;}
.Pay_amount{
  letter-spacing: 0px;
  line-height: 1.2;
}
/*.inputcard input[name='ccno'] { }*/
.iconnull, .iconvisa{ 
    /*display: block;
    width: 100%;
    padding: 0.375rem 0.75rem;
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: #212529;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #ced4da;
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    border-radius: 0.25rem;
    transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
	min-height: calc(1.5em + (0.5rem + 2px));
    padding: 0.25rem 0.5rem;
    font-size: .875rem;
    border-radius: 0.2rem;
	margin-top: 0.25rem!important;
    margin-bottom: 0.25rem!important;*/

}
.iconnull:focus {
    color: #212529;
    background-color: #fff;
    border-color: #86b7fe;
    outline: 0;
    box-shadow: 0 0 0 0.25rem rgb(13 110 253 / 25%);
}
.frame{
 /* box-sizing: border-box;
  box-shadow: -15px 15px 2px 0px rgba(0, 0, 0, 0.25);
  overflow: visible;
  border-radius: 25px;
  border: 5px solid #4984b8;*/
width: 100%;
}
@media (max-width:550px){ 
	.brec { font-size: 14px !important; }
	.box_first{
           box-shadow: 5px 5px 5px 0px rgba(247, 142, 33, 0.2);
           background-color: rgba(73, 132, 184, 0.2);
           overflow: visible;
           border-radius: 15px;
		   padding:8px;
	      }
	.box_first br{ display:none; }
	.box_first .p_title{ font-size:14px; }
	.box_first .p_text{ font-size:18px; }
    .main-template-border {border-left-width: 2px!important;}
	.inner-template-border { 
	        box-shadow:unset;
			border-top-width: 0px;
    		border-bottom-width: 0px;
    		border-left-width: 0px;
    		border-right-width: 0px;
			border-radius: 25px 25px 25px 25px; 
			}
    .hide_mobile { /*display:none;*/ }
   
}

.facebook::before {
    font-family: "Font Awesome 5 Brands"; 
	font-weight: 400;
	content: "\f09a";
}
</style>
  <div class="processall">
	<div class="content_top" style="">
		<div class="border_con my-3">
<?
if(isset($_SESSION['action'])&&$_SESSION['action']=="vt"){
	$heading_1="VIRTUAL TERMINAL";
}else{
	$heading_1="BILLING INFORMATION";
}

?>
		 
		<? 
		$c_style3="hide"; 
		if($post['step']==1||isset($data['Error'])){ 
		
		$c_style2=''; 
		?>
		
		<? if($data['con_name']=='clk'){ ?>
		<? if(isset($_SESSION['re_post']['failed_reason'])){
		$c_style2="style='display:none;'"; 
		$c_style3="hide2"; 
		//$_SESSION['re_post']['failed_reason']='Do Not Honor Payment Failed.';
	 ?>
		<script language="javascript" type="text/javascript"> 
		window.opener.close();
	 </script>
 <div class="alertPaymentDiv text-center" > <i class=" fa-solid fa-circle-info text-danger fa-6x my-2"></i>
 
			
<div class="alert alert-danger" role="alert">
<strong>Payment Failed</strong> <br />
<?=prntext($_SESSION['re_post']['failed_reason']);?>
</div>
			
			<div class="timerText" >Payment Complete before the end of minutes : <span id="timer1" class="timer" style="">05:00</span></div>
			
			<a class="nopopup tryAgain btn btn-icon btn-primary" >Try Again </a> <a title="<?=$_SESSION['http_referer'];?>" class="nopopup merchantPage btn btn-icon btn-primary">Go Back </a> </div>
		<? } ?>
		<div class="slidePaymentDiv" <?=(isset($c_style2)?$c_style2:'');?>>
			<div class="payingMdiv bg-primary text-white">
			
					 
<div class="payingLdiv">
<? if(isset($_SESSION['merchant_logo'])&&$_SESSION['merchant_logo']){ ?>
<div class="merchantLogo text-start"> <img 111 src="<?=$_SESSION['merchant_logo'];?>" class="p-1" /> </div>
<? } ?>
<? if((isset($data['ADMIN_LOGO'])&&$data['ADMIN_LOGO']) && (isset($_SESSION['merchant_logo'])&&$_SESSION['merchant_logo'])){ ?>
<div class="merchantLogo text-end"> <img 222 src="<?=encode_imgf($data['ADMIN_LOGO']);?>" class="p-1" /> </div>
<? } ?>
			
<? if((isset($data['ADMIN_LOGO'])&&$data['ADMIN_LOGO']) && (!isset($_SESSION['merchant_logo'])|| empty($_SESSION['merchant_logo']))){ ?>
<div class="merchantLogo text-start"> <img 333 src="<?=encode_imgf($data['ADMIN_LOGO']);?>" class="p-1" /> </div>
<? } ?>
			
			
<?  if(isset($_SESSION['domain_server']['LOGO'])&&$_SESSION['domain_server']['LOGO']){ ?>
<!--<div class="merchantLogo text-center"> <img 333 src="<?=($_SESSION['domain_server']['LOGO']);?>" /> </div>-->
<? } ?>
				
				<!--<div class="compAmt" >
				<div class="payingTo" style="display:none;">Paying To:
					<? if(isset($theme_color)) echo $theme_color;?>
				</div>
				<? if(isset($data['re_post'])&&$data['re_post']){ ?>
				
				<? } ?>
				<? if(isset($_SESSION['re_post']['return_failed_url'])&&$_SESSION['re_post']['return_failed_url']){ ?>
				<div class="timerText2" ><span id="timer2" class="timer" style="">05:00</span></div>
				<? } ?>
				
				<? if(isset($_SESSION['mem']['user_type'])&&$_SESSION['mem']['user_type']==1){
				
					if(isset($_SESSION['mem']['fullname'])&&$_SESSION['mem']['fullname']) 
						$_SESSION['info_data']['company']=$_SESSION['mem']['fullname'];
					else
						$_SESSION['info_data']['company']=$_SESSION['mem']['fname'].' '.$_SESSION['mem']['lname'];	
				} ?>
				<div class="company" style="">
					<?=prntext($_SESSION['info_data']['company'])?>
				</div>
			
				<font style="font-size:12px;float:left;width:auto;font-weight:normal;">Amount Payable&nbsp;</font><div class="nPay top"><span class="currSymbl"><?=get_currency($post['curr']?$post['curr']:$_SESSION['curr']);?></span><span class="nPayb"><?=($post['price']=='0.00'?'1.00':$post['price']);?></span></div>
				</div>-->
			</div>

			
			
			</div>
		</div>
		
		
		
		<? if(isset($post['chooseStore'])&&$post['chooseStore']){ ?>
		<div class="ecol2 contInputDiv block-form-py main-template-border" style="float:left;display:block;margin:10px auto !important;width:100%;padding:2% 10%;">
			<label class="la12" style="margin:20px 0 0 8px;">Choose Website Type</label>
			<select name="storeType" id="storeType" class="form-select from-select-sm" >
			<option value="" selected="selected">Website Type</option>
			<?foreach($post['allStore'] as $key=>$val){ ?>
			<option data-title="<?=$val['id']?>" value="<?=$val['api_token']?>" >
			<?=$val['bussiness_url']?>
			<? if(isset($data['localhosts'])&&$data['localhosts']==true){ ?>
			|
			<?=$val['name']?>
			:
			<?=$val['api_token']?>
			<? } ?>
			</option>
			<? } ?>
			</select>
			<div style="clear:both;width:100%;height:10px;margin:10px 0;"></div>
		</div>
		<? }
		else{ 
			if( isset($post['step']) && $post['step']==1 && isset($data['Error']) ){
				$c_style3='';
			}
		?>
		<div class="nextSt contInputDiv inputBgW <?=(isset($c_style3)?$c_style3:'');?>"  >
			
			<div class="contInputDivPlace">
					
<?php /*?><? if((isset($data['Error'])&& $data['Error'])){ ?>

<div class="alert contInputDivAlert alert-danger alert-dismissible fade my-2 show" role="alert" >
<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
<strong>Error!</strong>
<?=prntext($data['Error'])?>
</div>

<? } ?><?php */?>
				
				<div class="my-2 main-template-border row">
				
				<div  class="col-sm-4">
				
				<div class="my-4 mx-2 box_first11 text-white"><span class="p_title">Paying To :</span><br>
                <span class="p_text my-4 ps-2">  <? echo($_SESSION['info_data']['company']);?></span>
				</div>
<? if(isset($_SESSION['info_data']['request_id_order'])&&$_SESSION['info_data']['request_id_order']){ ?>	
				<div class="my-4 mx-2 hide_mobile text-white"><span class="p_id my-4">Payment ID :</span> <span class="p_id_text my-4"><? echo($_SESSION['info_data']['request_id_order']);?></span></div>
				
        <? } ?>
</div>
				<div class="block-form-py bg-vlight inner-template-border col-sm-8 px-2 border-start border-warning"> 
				<?//=$data['Error'];?>
				<? if((isset($post['pricManual'])&&$post['pricManual'])||(empty($post['fullname']) || empty($post['bill_phone']) || empty($post['email'])  )){
					//|| isset($data['Error'])
					?>
				<style>
					#contSubmit {display:block!important}
				</style>
				<div class="brec m-2 fw-bold" >Payment Request Form</div>
				<div class="form-box">
					<div class="ecol2 row">
					<div  class="col-sm-4 form_field_title py-1">Name</div>
					<div  class="col-sm-8">
					<input class="form-control form-control-sm  py-1" placeholder='Enter Name' type="text" name="fullname" size="240" maxlength="240" value="<?=($post['fullname']?prntext($post['fullname']):prntext($_SESSION['re_post']['fullname']));?>" required  />
					</div>
					</div>
					<div class="ecol2 row">
					<div  class="col-sm-4 form_field_title py-1">Email</div>
					<div  class="col-sm-8">
					<input class="form-control form-control-sm  py-1" placeholder='Enter Email ID' type="text" name="email" size="30" maxlength="128" value="<?=($post['email']?prntext($post['email']):prntext($_SESSION['re_post']['email']));?>" required />
					</div>
					</div>
					<div class="ecol2 row">
					<div  class="col-sm-4 form_field_title py-1">Phone no</div>
					<div  class="col-sm-8">
					<input class="form-control form-control-sm  py-1" placeholder='Enter Mobile Number ' type="tel" name="bill_phone" size="30" maxlength="128" value="<?=($post['bill_phone']?prntext($post['bill_phone']):prntext($_SESSION['re_post']['bill_phone']));?>" style="font-size:16px;" required />
					
<input type="hidden" name="bill_street_1" value="<?=($post['bill_street_1']?prntext($post['bill_street_1']):prntext($_SESSION['re_post']['bill_street_1']));?>" />
<input type="hidden" name="bill_street_2" value="<?=($post['bill_street_2']?prntext($post['bill_street_2']):prntext($_SESSION['re_post']['bill_street_2']));?>" />
<input type="hidden" name="bill_country" value="<?=($post['bill_country']?prntext($post['bill_country']):prntext($_SESSION['re_post']['bill_country']));?>" />
<input type="hidden" name="bill_state" value="<?=($post['bill_state']?prntext($post['bill_state']):prntext($_SESSION['re_post']['bill_state']));?>" />
<input type="hidden" name="bill_city" value="<?=($post['bill_city']?prntext($post['bill_city']):prntext($_SESSION['re_post']['bill_city']));?>" />
<input type="hidden" name="bill_zip" value="<?=($post['bill_zip']?prntext($post['bill_zip']):prntext($_SESSION['re_post']['bill_zip']));?>" />
<input type="hidden" name="bill_country_name" value="<?=($post['bill_country_name']?prntext($post['bill_country_name']):prntext($_SESSION['re_post']['bill_country_name']));?>" />
					</div>
					</div>
					<div class="ecol2 row">
					<div  class="col-sm-4 form_field_title py-1">Purpose of Payment</div>
					<div  class="col-sm-8">
					<input class="form-control form-control-sm  py-1" placeholder='Enter Purpose of Payment ' type="text" name="product_name" size="30" maxlength="128" value="<?=($post['product_name']?prntext($post['product_name']):prntext($_SESSION['name']));?>" style="font-size:16px;" required />

					</div>
					</div>
					<div class="ecol2 row">
					<div  class="col-sm-4 form_field_title py-1">Amount</div>
					<div  class="col-sm-8">
					<input class="form-control form-control-sm  py-1 price90" placeholder='Enter Amount ' type="text" name="price" size="30" maxlength="128" value="<?=($post['price']?prntext($post['price']):prntext($_SESSION['re_post']['price']));?>" style="font-size:16px;" required />

					</div>
					</div>
					
<div class="text-center my-2">
<button id="contSubmit" type="button" value="CHANGE NOW!" class="submitbtn btn btn-sm next btn-template hide">Pay Now</button>
				</div>
					
				</div>	
					<? } ?>

				</div>
				
				</div>
				
                <div class="col-sm-12">
				 <div class="imgIcn1" style="display:none !important">
					 Powered by 
						<? if(isset($_SESSION['merchant_logo'])&&$_SESSION['merchant_logo']&&file_exists($_SESSION['merchant_logo'])){ ?>
							 <img 22 src="<?=encode_imgf($_SESSION['merchant_logo']);?>" /> 
						<? }elseif(isset($data['ADMIN_LOGO'])&&$data['ADMIN_LOGO']){ ?>
							<img 33 src="<?=encode_imgf($data['ADMIN_LOGO']);?>" /> 
						<? }elseif(isset($_SESSION['domain_server']['LOGO'])&&$_SESSION['domain_server']['LOGO']){ ?>
							<img 44 src="<?=encode_imgf($_SESSION['domain_server']['LOGO']);?>" /> 
						<? } ?>
					
				</div>
				 <?php /*?><div class="text-center my-2">
					<button id="contSubmit" type="button" value="CHANGE NOW!"  class="submitbtn btn btn-icon btn-primary next bg-primary text-white hide" >Pay &nbsp;&nbsp;<span class="nPay"><span class="currSymbl"><?=get_currency($post['curr']?$post['curr']:$_SESSION['curr']);?></span><span class="nPayb"><?=($post['price']=='0.00'?'1.00':$post['price']);?></span></span> </button>
				</div><?php */?>
			    </div>
			</div>
		</div>
		<div id="paymentMainDiv" class="paymentMainDiv" <?=(isset($c_style2)?$c_style2:'');?>>
		<div class="my-2 hide2 main-template-border row">
		<!--Div 4 Start Here-->
		<div class="col-sm-4">
				
				<div class="my-4 mx-2 box_first11 text-white"><span class="p_title">Paying To :</span><br>
                <span class="p_text my-4 ps-2">  <? echo($_SESSION['info_data']['company']);?></span>
				</div>
<? if(isset($_SESSION['info_data']['request_id_order'])&&$_SESSION['info_data']['request_id_order']){ ?>		
				<div class="my-4 mx-2 hide_mobile text-white"><span class="p_id my-4">Payment ID :</span> <span class="p_id_text my-4"><? echo($_SESSION['info_data']['request_id_order']);?></span></div>
				
<? } ?>
</div>
		<!--Div 8 Start Here-->
		
		<div class="paymentMethodDiv bg-white inner-template-border col-sm-8 px-2 border-start border-warning">
			
			<div class="payment_option">
			<? $currency_smbl=get_currency($_SESSION['curr']);?>
			<?php /*?><span class="paymentMethodh4">
				<a class="change inputSetp2" id="inputSetp2" title="Back"><i class="fa-solid fa-circle-arrow-left text-primary fa-2x  mt-2 fa-beat-fade66 " style="display: block;"></i></a>
				<a class="change inputPaySetp3" title="Back"><i class="fa-solid fa-circle-arrow-left text-primary fa-2x fa-beat-fade "  style="display: block;"></i></a>
			</span><?php */?> 
			<span id='result_view_chk' class='result_view'></span> <span id='result_view' class='result_view'> </span> 
			
			<div class="chkname bg-white my-3" >
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
					<? if(isset($value['checkout_level_name'])&&$value['checkout_level_name']){echo $value['checkout_level_name'];}else{ ?>
					Pay by Check
					<? } ?>
					</label>
					</div>
					<? }} ?>
				</div>
				</div>
				<? } ?>
				<div class="text-center text-center my-2 fw-bolder" style="font-size:18px;">Available Payment Methods</div>
				
				<div class="Pay_amount text-center my-2">Total Payable Amount: <span class="nPay"><span class="currSymbl"><?=get_currency($post['curr']?$post['curr']:$_SESSION['curr']);?></span><span class="nPayb"><?=($post['price']=='0.00'?'1.00':prnsum2($post['price']));?></span></span></div>
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
		<div class="inputype the_icon <?=countryCodeMatch2($post['country_two'],(isset($_SESSION["b_".$value['nick_name']]['countries'])?$_SESSION["b_".$value['nick_name']]['countries']:''),(isset($_SESSION["b_".$value['nick_name']]['countryCode'])?$_SESSION["b_".$value['nick_name']]['countryCode']:''),isset($_SESSION["b_".$value['nick_name']]['donotmachcountries'])?$_SESSION["b_".$value['nick_name']]['donotmachcountries']:'')?>">
					
			<input type="radio" value="<?=(isset($value['nick_name'])?$value['nick_name']:'');?>" id="<?=(isset($value['nick_name'])?$value['nick_name']:'');?>" required name="account_types" class="account_types" data-value="<?=(isset($value['nick_name'])?$value['nick_name']:'');?>" data-name="ecard" data-ccn="<?=(isset($_SESSION['b_'.$value['nick_name']]['account_custom_field_14'])?$_SESSION['b_'.$value['nick_name']]['account_custom_field_14']:'')?>" data-currency="<?=$pcrcy;?>" data-ewlist="<?=(isset($data['t'][$value['nick_name']]['name6']))?$data['t'][$value['nick_name']]['name6']:'';?>"  data-etype="<?=(isset($data['t'][$value['nick_name']]['name4']))?$data['t'][$value['nick_name']]['name4']:'';?>"  data-count='<? if(isset($_SESSION["b_".$value['nick_name']]['deCon'])) echo $_SESSION["b_".$value['nick_name']]['deCon'];?>' data-dnmc='<? if(isset($_SESSION["b_".$value['nick_name']]['donotmachcountries'])) echo $_SESSION["b_".$value['nick_name']]['donotmachcountries'];?>' style="display:none;" />
                        
						
									<? if(isset($value['checkout_level_name'])&&$value['checkout_level_name']){ $creditdebitcardtitle=$value['checkout_level_name'];}else{ 
			$creditdebitcardtitle="Visa, Master, Rupay, Amex, Discover [ ".$_SESSION['curr_transaction_amount']." ] ";
			} ?>
							
                        <label for="<?=(isset($value['nick_name'])?$value['nick_name']:'');?>" title="<?=$creditdebitcardtitle;?>">
						
						<div class="card_icon_pay">
							<i class="far fa-credit-card list-card"></i>
						</div>
						<div class="titleLabel">
							Credit / Debit Card
						</div>
						<div class="titleText" style="display:none;">
							<? if(isset($value['checkout_level_name'])&&$value['checkout_level_name']){echo $value['checkout_level_name'];}else{ ?>
							Visa, Master, Rupay, Amex, Discover [
							<?=$_SESSION['curr_transaction_amount'];?>
							]
							<? } ?>
						</div>
						<!--<i class="fa-regular fa-circle-right lclr"></i>-->
					</label>
					</div>
					<? }} ?>
				</div>
				</div>
				<? } ?>
				<? if(!empty($post['nick_name_net_banking'])){ ?>
				<div class="cname netBankCont">
				<div class="inputgroup">
					<? foreach($_SESSION['AccountInfo'] as $key=>$value){if(($value['nick_name']) &&  (strpos($data['t'][$value['nick_name']]['name2'],'Banking') !== false) && (in_array($value['nick_name'],$post['nick_name_net_banking_arr'])) && ($value['account_login_url']!="3")  ){
						
						 if(isset($_SESSION['curr'])&&$_SESSION['curr']){$pcrcy=$currency_smbl;}else{$pcrcy=$_SESSION['curr_tr_sys'];}
						
						 
						 if(isset($value['account_login_url'])&&$value['account_login_url']=="1"){$dataname="ewallets"; }
						 elseif(isset($value['account_login_url'])&&$value['account_login_url']=="2"){$dataname="evoilatecard"; }
					?>
					<div class="inputype <?=(isset($data['t'][$value['nick_name']]['logo'])?"the_icon":"")?> <?=countryCodeMatch2($post['country_two'],$_SESSION["b_".$value['nick_name']]['countries'],$_SESSION["b_".$value['nick_name']]['countryCode'])?> mt-0">
					<input type="radio" value="<?=$value['nick_name']?>" id="<?=$value['nick_name']?>" required name="account_types" class="account_types" data-value="<?=$value['nick_name']?>" data-name="<?=$dataname;?>" data-currency="<?=$pcrcy;?>" data-ewlist="<?=(isset($data['t'][$value['nick_name']]['name6']))?$data['t'][$value['nick_name']]['name6']:'';?>" style="display:none;" />
					
					<? if(isset($value['checkout_level_name'])&&$value['checkout_level_name']){ $netbankingtitle=$value['checkout_level_name'];}else{ 
				$netbankingtitle= "All Indian Banks [ ".$_SESSION['curr_transaction_amount']." ]"; } ?>	
					
					<label for="<?=$value['nick_name']?>" title="<?=$netbankingtitle;?>">
						
						<div class="card_icon_pay">
							<i class="card_icon_pay fas fa-university list-card"></i>
						</div>
						<div class="titleLabel">Net Banking</div>
						<div class="titleText" style="display:none;">
							<? if(isset($value['checkout_level_name'])&&$value['checkout_level_name']){echo $value['checkout_level_name'];}else{ ?>
							All Indian Banks [
							<?=$_SESSION['curr_transaction_amount'];?>
							]
							<? } ?>
						</div>

						<!--<i class="fa-regular fa-circle-right lclr"></i>-->
					</label>
					</div>
					<? }} ?>
				</div>
				</div>
				<? } ?>
				<? if((isset($post['nick_name_ewallets'])&&!empty($post['nick_name_ewallets']))){ ?>
				<div class="cname ewalletCont">
				<div class="inputgroup">
				
				
			<?/*?> <?*/?>
				<div class="inputype the_icon payNextList mt-0">
					<label title="All Wallet">
						<div class="card_icon_pay"><i class="fas fa-wallet"></i></div>
						<div class="titleLabel">Wallet</div>
						<div class="titleText"  style="display:none;">All Wallet</div>
						<!--<i class="fa-regular fa-circle-right lclr"></i>-->
					</label>
				</div>
				
			
				
				
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

						if($value['account_login_url']==1){
							$dataname="ewallets"; 
							$data_ccn=''; 
						}
						elseif($value['account_login_url']==2){
							$dataname="evoilatecard"; 
							$data_ccn='data-ccn="visa"';
						}
					?>
					<div class="inputype <?=(isset($data['t'][$value['nick_name']]['logo'])?"the_icon":"")?> <?=countryCodeMatch2($post['country_two'],isset($_SESSION["b_".$value['nick_name']]['countries'])?$_SESSION["b_".$value['nick_name']]['countries']:'',isset($_SESSION["b_".$value['nick_name']]['countryCode'])?$_SESSION["b_".$value['nick_name']]['countryCode']:'',isset($_SESSION["b_".$value['nick_name']]['donotmachcountries'])?$_SESSION["b_".$value['nick_name']]['donotmachcountries']:'')?> mt-0">
					<input type="radio" value="<?=$value['nick_name']?>" id="<?=$value['nick_name']?>" required name="account_types" class="account_types" data-value="<?=$value['nick_name']?>" data-name="<?=$dataname;?>" data-currency="<?=$pcrcy;?>" data-ewlist="<?=(isset($data['t'][$value['nick_name']]['name6']))?$data['t'][$value['nick_name']]['name6']:'';?>" data-count="<?=$_SESSION["b_".$value['nick_name']]['deCon'];?>" style="display:none;" <?=$data_ccn;?> />
					<label for="<?=$value['nick_name']?>">
						<div class="card_icon_pay">
							<i class="fas fa-money-check"></i>
							<img src="<?=$data['Host']?>/images/upi-icon.svg"  />
							<? /*?><img src="<?=$data['Host']?>/images/upi-icon.svg"  /><?*/?>
						</div>
						<div class="titleLabel"><?=(isset($data['t'][$value['nick_name']]['label']))?$data['t'][$value['nick_name']]['label']:'UPI Payment';?></div>
						<div class="titleText"  style="display:none;">
							<? if(isset($value['checkout_level_name'])&&$value['checkout_level_name']){echo $value['checkout_level_name'];}else{ ?>
							Google Pay, PhonePe, BHIM [
							<?=$_SESSION['curr_transaction_amount'];?>
							]
							<? } ?>
						</div>
						<!--<i class="fa-regular fa-circle-right lclr"></i>-->
					</label>
					</div>
					<? }} ?>
				</div>
				</div>
				<? } ?>
			</div>
			</div>
			
			

<?php /*?>
<?   if(((!empty($post['nick_name_ewallets']))||(!empty($post['nick_name_net_banking']))||(!empty($post['nick_name_upi'])))&&(!isset($_SESSION['mISO2']))){?>
  <div id="otherPaymentMethod"> 
  <a class="change hide btn btn-icon btn-primary otherPaymentMethodLink my-2 " id="otherPaymentMethodLink" style="display: block;"><i class="fa-solid fa-credit-card"></i> All Other Payment Method</a> 
  <a class="change hide btn btn-icon btn-primary goBackPaymentMethodLink my-2" id="goBackPaymentMethodLink" style="display: none;"><i class="fa-regular fa-circle-left lclr"></i> Go Back</a> </div>
<? } ?>

<?php */?>



		</div>
		<? } ?>
		<!--Div 8 Start Here-->
		<div class="cardHolder bg-white inner-template-border col-sm-8 px-4" <? if(isset($c_style)) echo $c_style;?> >
			<a class="changeMeth payNextList hide">Change Payment Method</a>
			

			<div class="checkedLabel"></div>
			<!--<div class="title_underline"></div>-->
			<div class="Pay_amount text-center">Total Payable Amount: <span class="nPay"><span class="currSymbl"><?=get_currency($post['curr']?$post['curr']:$_SESSION['curr']);?></span><span class="nPayb"><?=($post['price']=='0.00'?'1.00':prnsum2($post['price']));?></span></span></div>
			<div class="frame form-box my-2">
			
			<div class="checkOutOptions">
				<? if(!empty($post['nick_name_check'])){ ?>
				<div class="echeck_div pay_div">
					<form id="zts-echeck" method=post action="<?=$data['Host'];?>/echeckprocess<?=$data['ex']?>" onSubmit="return validateForm(this);">
					<div class="ecol2">
						<div style="display:none">
						<input type="hidden" name="type" value="">
						<input type="hidden" name="gid" value="<?=(isset($_SESSION['owner'])?$_SESSION['owner']:'');?>"/>
						<input type="hidden" name="bid" value="<?=(isset($post['bid'])?$post['bid']:'')?>"/>
						<input type="hidden" name="store_id" value="<?=(isset($post['store_id'])?$post['store_id']:'');?>"/>
						<input type="hidden" name="api_token" value="<?=(isset($post['api_token'])?$post['api_token']:'');?>"/>
						<input type="hidden" name="bill_country_name" id="bill_country_name" value="<?=(isset($post['bill_country_name'])?$post['bill_country_name']:'');?>"/>
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
						<input type="hidden" name="memo" value="<?=$data['SiteName']?>*<?=(isset($_SESSION['descriptor'])?$_SESSION['descriptor']:'');?>"/>
						</div>
						<div class="separator"></div>
						<input type=text name=purchaser_account id=purchaser_account  placeholder="Account No.*" class="span10" value="<?=(isset($post['purchaser_account'])?prntext($post['purchaser_account']):'');?>" required  />
						<div class="separator"></div>
						<input type=text name=purchaser_echecknumber id=purchaser_echecknumber  placeholder="Check No.*" class="span10" value="<?=(isset($post['purchaser_echecknumber'])?prntext($post['purchaser_echecknumber']):'');?>" required  />
						<div class="separator"></div>
						<input type=text name=bank_name id=bank_name  placeholder="Bank Name*" class="span10" value="<?=(isset($post['bank_name'])?prntext($post['bank_name']):'');?>" required  />
						<div class="separator"></div>
						<input type=text name=bank_address id=bank_address  placeholder="Bank Address*" class="span10" value="<?=(isset($post['bank_address'])?prntext($post['bank_address']):'');?>"/>
						<div class="separator"></div>
						<input type=text name=bank_city id=bank_city  placeholder="Bank City*" class="span10" value="<?=(isset($post['bank_city'])?prntext($post['bank_city']):'');?>" required  />
					</div>
					<div class="ecol2">
						<div class="separator"></div>
						<input type=text pattern="[0-9]{9}" name=purchaser_routing id=purchaser_routing   placeholder="Bank ABA No.*" class="span10" value="<?=(isset($post['purchaser_routing'])?prntext($post['purchaser_routing']):'');?>" required  />
						<div class="separator"></div>
						<select name="bank_state" id="bank_state" class="feed_input1 form-select" placeholder="Select Bank State" required>
						<? if(isset($post['bank_state'])&&$post['bank_state']){ ?>
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
						<input type=text name=bank_zipcode id=bank_zipcode  pattern="[0-9]{4,5}" placeholder="Bank Zip*" class="span10" value="<?=(isset($post['bank_zipcode'])?prntext($post['bank_zipcode']):'');?>" required  />
						<div class="separator"></div>
						<textarea name=comments cols=30 rows=3 placeholder="Note" style="height:75px;"><?=(isset($post['notes'])?prntext($post['notes']):'');?></textarea>
					</div>
					<div class="submit_div">
						<button type=submit name=change value="CHANGE NOW!"  class="submitbtn btn btn-icon btn-primary glyphicons circle_ok "><i></i>CONTINUE</button>
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
	
	if($data['con_name']=='clk'){
		$post['step']=2;
		$common_input="
		<div style=display:none>
		<input type=hidden name=product value='".$post['product']."'>
		<input type=hidden name=price value='".($post['price']?prntext($post['price']):prntext($_SESSION['re_post']['price']))."' >
		</div>";
	}
	$common_input .="
	<div style=display:none>
	<input type=hidden name=step value='".$post['step']."'>
	<input type=hidden name=fullname value='".$post['fullname']."'>
	<input type=hidden name=email value='".$post['email']."'>
	<input type=hidden name=bill_address value='".$post['bill_address']."'>
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
	<input type=hidden name=aurl value='".$post['aurl']."'>
	<input type=hidden name=source value='".trim($post['source'])."'>
	</div>"; 
	
	if(isset($data['Error'])&&$data['Error']&&isset($post['submit'])){
		$display_style="style='display:block;'";
	}else {
		$display_style="style='display:none;'";
	}
	?>
				<? if(!empty($post['nick_name_card']) || ( ($post['nick_name']) && ($_SESSION['post']['ewallets_test_card']==true)  )){ ?>
				<div class="cover_pay_div" style="position:relative;">
					<div class="ecard_div evoilatecard_div pay_div">
					<form id="payment_form_id" method=post  onsubmit="return validateForm(this);">
						<div style="display:none">
						<?=$common_input;?>
						<input type="hidden" name="midcard" value="" />
						<input type="hidden" name="cardtype" id="cardtype" value="<? if(isset($post['cardtype'])) echo $post['cardtype']?>">
						</div>
				<div class="brec mb-2 text-center text-dark">Enter Card details</div>
				<div class="block-form-py">
				
				<div class="number inpuIconDiv">
						<div class="form-group inputcard" id="card-number-field">
						 <!--<div class="inpuIcon"><i class="fas fa-credit-card"></i></div>-->
						 <input id="number" type="text" name="ccno" maxlength="19" placeholder="Card Number" value='<?=(isset($post['ccno'])&&$post['ccno'])?$post['ccno']:"";?>' class="form-control form-control-sm my-1" title="Enter Card Number" style="padding-left:45px !important;" autofocus  />
					</div>
					    <div class="logo_card_icon" style="width:100%;margin:6x 0 20px 0 !important;float:left;display:none!important;">
						<div class="form-group" id="credit_cards"> <img src="<?=$data['Host']?>/images/visa.jpg" id="visa" /> <img src="<?=$data['Host']?>/images/mastercard.jpg" id="mastercard" /> <img src="<?=$data['Host']?>/images/amex.jpg" id="amex" /> <img src="<?=$data['Host']?>/images/jcbcard.jpg" id="jcb" /> <img src="<?=$data['Host']?>/images/rupaycard.jpg" id="rupay" /> <img src="<?=$data['Host']?>/images/discover.jpg" id="discover" /> </div>
					</div>
							
		
					</div>
					
				<div class="inpuIconDiv">
				<div class="float-start p-1 exp_date">Expiry Date</div>
				<div class="float-start exp_month">
					
					<select id="expMonth" name="month" class="form-select form-select-sm my-1" required title="Select Month of Card Expiry">
						<option value="" disabled="disabled" selected=selected >Exp. Month</option>
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
				<div class="float-start text-center" style="width:10%;">/</div>
				<div class="float-start exp_month" >
				
					<select id="expYear" class="form-select form-select-sm my-1" name="year" required title="Select Year of Card Expiry">
						<option value="" disabled="disabled"  selected=selected>Exp. Year</option>
						<?
						for($yy = date('y');$yy<100;$yy++)
						{
						?><option value="<?=$yy?>"><?=$yy?></option><?
						}?>
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
				</div>
				
		
				
				<div class="inpuIconDiv">
					<div class="float-start p-1 exp_date" >CVV Number</div>
					<div class="float-start exp_date" >
					<input id="cvc" class="form-control form-control-sm my-1" type="password" name="ccvv" maxlength="4"  placeholder="CVC" value="<?=($post['ccno'])?$post['ccvv']:"";?>" required />
					</div>
				</div>
				
				</div>		
					<div class="card-holder" style="display:none">
						<label>Card holder</label>
						<div>
						<?=($post['fullname']?$post['fullname'].'':' ');?>
						</div>
					</div>
					
						
						<div class="ecol2" style="width: 96%;padding: 0;margin: 0 0 0 10px;">
						<textarea name=notes cols=30 rows=5 placeholder="Note" style="height:35px;margin:0px 0 5px 0;padding:0 5px;display:none;"><?=prntext($post['notes'])?></textarea>
						</div>
						<div class="hide error" id="form-input-errors" <?=$display_style;?>>
						<?=prntext($data['Error'])?>
						</div>
						<div class="separator"></div>
						<div style="clear:both"></div>
						<div class="submit_div">
						<button id="cardsend_submit" type=submit name=send123 value="CHANGE NOW!"  class="submitbtn btn btn-icon btn-template btn-sm"><b class="contitxt">Complete Payment</b></button>
					<? 
					if(isset($_SESSION['action'])&&$_SESSION['action']=="vt"){ ?>
						<style>.submitbck, .submitbtn {width:100% !important;margin:5px 0 !important;}</style>
						<button type=button value="BACK" onClick="javascript:goback();" class="submitbck back_button btn btn-icon btn-primary glyphicons left_arrow next" ><i></i><b class="contitxt1">Back to Merchant Store</b></button>
						<?
					} else { ?>
						<style>#cardsend_submit{width:100%;margin: 0 auto;float: none;}
						</style>
					<? } ?>
<script language="javascript" type="text/javascript"> 
	function goback(){window.location.href = window.location.href;}
</script>
						</div>
					</form>
					</div>
					<? } ?>
					
					<? if((isset($post['nick_name_ewallets'])&&!empty($post['nick_name_ewallets']))){ ?>
				<div class="hide cname ewalletCont ewalletContDiv ewalletPayOption" style="">
				<div class="inputgroup row mb-2">
				
				
                      <? 
		$outputArray_2 = array();
		foreach($_SESSION['AccountInfo'] as $key=>$value){
			if((isset($value['nick_name'])&&$value['nick_name']) && isset($data['t'][$value['nick_name']]['name2']) && ((strpos($data['t'][$value['nick_name']]['name2'],'eWallets') !== false)) && ( (in_array($value['nick_name'],@$post['nick_name_ewallets_arr']) ) || (in_array($value['nick_name'],$post['nick_name_net_banking_arr'])) ) && ($value['account_login_url']!="3") && (isset($_SESSION['b_'.$value['nick_name']]['bg_active'])&&$_SESSION['b_'.$value['nick_name']]['bg_active']>0) && (!in_array($value['nick_name'],$outputArray_2)) ) {
		  
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
					<div  class=" col-sm-4 p-1 inputype <?=(isset($data['t'][$value['nick_name']]['logo'])?"the_icon":"")?> <?=countryCodeMatch2($post['country_two'],isset($_SESSION["b_".$value['nick_name']]['countries'])?$_SESSION["b_".$value['nick_name']]['countries']:'',isset($_SESSION["b_".$value['nick_name']]['countryCode'])?$_SESSION["b_".$value['nick_name']]['countryCode']:'',isset($_SESSION["b_".$value['nick_name']]['donotmachcountries'])?$_SESSION["b_".$value['nick_name']]['donotmachcountries']:'')?>">
                        <input type="radio" value="<?=(isset($value['nick_name'])?$value['nick_name']:'');?>" id="<?=(isset($value['nick_name'])?$value['nick_name']:'');?>" required name="account_types" class="account_types" data-value="<?=(isset($value['nick_name'])?$value['nick_name']:'');?>" data-name="<?=(isset($dataname)?$dataname:'');?>" data-currency="<?=$pcrcy;?>" data-type="ewalletList" data-ewlist="<?=(isset($data['t'][$value['nick_name']]['name6']))?$data['t'][$value['nick_name']]['name6']:'';?>" data-etype="<?=(isset($data['t'][$value['nick_name']]['name4']))?$data['t'][$value['nick_name']]['name4']:'';?>"  data-count='<?=(isset($_SESSION["b_".$value['nick_name']]['deCon'])?$_SESSION["b_".$value['nick_name']]['deCon']:'');?>' data-dnmc='<? if(isset($_SESSION["b_".$value['nick_name']]['donotmachcountries'])) echo $_SESSION["b_".$value['nick_name']]['donotmachcountries'];?>' style="display:none;" <?=(isset($data_ccn)?$data_ccn:'');?> />
					<label for="<?=$value['nick_name']?>" style="float:left;width:100%;cursor:pointer;">
						
						
						<div class="titleText" >
						<? if(isset($data['t'][$value['nick_name']]['logo'])){?>
								<img src="<?=$data['Host']?>/images/<?=$data['t'][$value['nick_name']]['logo']?>_logo.png"  style="height:40px;" class="img-fluid" title="<?=$value['checkout_level_name'];?>"  />
							<? }else{ ?>
								<i class="fas fa-wallet"></i>
							<? } ?>
							
							<? if(isset($value['checkout_level_name'])&&$value['checkout_level_name']){//echo $value['checkout_level_name'];
							}else{ ?>
							<?php /*?>Pay with eWallets [
							<? if(isset($_SESSION['curr_transaction_amount'])) echo $_SESSION['curr_transaction_amount'];?>
							]<?php */?>
							<? } ?>
						</div>
						
					</label>
					</div>
					<? }} ?>
				</div>
				</div>
				<? } ?>
					
					
					<? if(isset($post['nick_name_ewallets'])&&(!empty($post['nick_name_ewallets']))||(isset($post['nick_name_net_banking'])&&!empty($post['nick_name_net_banking']))||(isset($post['nick_name_upi'])&&!empty($post['nick_name_upi']))){?>
					
					<div class="ewallets_div pay_div">
					<form id="payment_form_id_ewallets" method="post" onSubmit="return validateForm(this);">
						<div class="ecol2" style="width:100%">
						<div style="display:none">
							<?=$common_input;?>
							<input type="hidden" name="midcard" value="" />
						</div>
						<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'IndiaBankingCashLogo') !== false){?>
						  <div class="IndiaBankingCashLogo_div ewalist hide">
							<div class="banksDiv desImg 3044"><span class="banks_sprite banks_bank_1" style="vertical-align:middle;"></span><span class="bankNm txNm">SBI</span></div>
							<div class="banksDiv desImg 3022"><span class="banks_sprite banks_bank_2" style="vertical-align:middle;"></span><span class="bankNm txNm">ICICI</span></div>
							<div class="banksDiv desImg 3021"><span class="banks_sprite banks_bank_3" style="vertical-align:middle;"></span><span class="bankNm txNm">HDFC</span></div>
							<div class="banksDiv desImg 3003"><span class="banks_sprite banks_bank_4" style="vertical-align:middle;"></span><span class="bankNm txNm">Axis</span></div>
							<div class="banksDiv desImg 3032"><span class="banks_sprite banks_bank_5" style="vertical-align:middle;"></span><span class="bankNm txNm">Kotak</span></div>
							<div class="banksDiv desImg 3065"><span class="banks_sprite banks_bank_6" style="vertical-align:middle;"></span><span class="bankNm txNm">PNB</span></div>
						  </div>
						  <? } ?>
						  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'cashIndiaBankingList') !== false){?>
						  <div class="cashIndiaBankingList_div ewalist hide">
							<select class="w94 dropDwn hide required form-select from-select-sm " name="bank_code" id="bank_code" style="margin:5px 0;">
								<option value="" disabled="">Choose Bank</option>
								<option value="3087">AU Small Finance</option>
								<option value="3071">Axis Bank Corporate</option>
								<option value="3003">Axis Bank</option>
								<option value="3079">Bandhan Bank- Corporate banking</option>
								<option value="3088">Bandhan Bank - Retail Net Banking</option>
								<option value="3060">Bank of Baroda - Corporate</option>
								<option value="3005">Bank of Baroda - Retail Banking</option>
								<option value="3006">Bank of India</option>
								<option value="3061">Bank of India - Corporate</option>
								<option value="3007">Bank of Maharashtra</option>
								<option value="3080">Barclays Corporate- Corporate Banking - Corporate</option>
								<option value="3009">Canara Bank</option>
								<option value="3010">Catholic Syrian Bank</option>
								<option value="3011">Central Bank of India</option>
								<option value="3012">City Union Bank</option>
								<option value="3083">City Union Bank of Corporate</option>
								<option value="3017">DBS Bank Ltd</option>
								<option value="3062">DCB Bank - Corporate</option>	
								<option value="3018">DCB Bank - Personal</option>	
								<option value="3016">Deutsche Bank</option>
								<option value="3019">Dhanlakshmi Bank</option>
								<option value="3072">Dhanlaxmi Bank Corporate</option>
								<option value="3076">Equitas Small Finance Bank</option>
								<option value="3020">Federal Bank</option>
								<option value="3091">Gujarat State Co-operative Bank Limited</option>
								<option value="3084">HDFC Corporate</option>
								<option value="3021">HDFC Bank</option>
								<option value="3092">HSBC Retail Netbanking</option>
								<option value="3073">ICICI Corporate Netbanking</option>
								<option value="3022">ICICI Bank</option>
								<option value="3023">IDBI Bank</option>
								<option value="3024">IDFC Bank</option>
								<option value="3026">Indian Bank</option>
								<option value="3027">Indian Overseas Bank</option>
								<option value="3081">Indian Overseas Bank Corporate</option>
								<option value="3028">IndusInd Bank</option>
								<option value="3029">Jammu and Kashmir Bank</option>
								<option value="3030">Karnataka Bank Ltd</option>
								<option value="3031">Karur Vysya Bank</option>
								<option value="3032">Kotak Mahindra Bank</option>
								<option value="3064">Lakshmi Vilas Bank - Corporate</option>
								<option value="3033">Lakshmi Vilas Bank - Retail Net Banking</option>
								<option value="3082">PNB (Erstwhile Oriental Bank of Commerce) - Corporate</option>
								<option value="3037">Punjab & Sind Bank</option>
								<option value="3065">Punjab National Bank - Corporate</option>
								<option value="3038">Punjab National Bank - Retail Banking</option>
								<option value="3074">Ratnakar Corporate Banking</option>
								<option value="3039">RBL Bank</option>
								<option value="3040">Saraswat Bank</option>
								<option value="3075">Shamrao Vithal Bank Corporate</option>
								<option value="3041">Shamrao Vitthal Co-operative Bank</option>
								<option value="3086">Shivalik Bank</option>
								<option value="3042">South Indian Bank</option>
								<option value="3043">Standard Chartered Bank</option>
								<option value="3044">SBI - State Bank Of India</option>
								<option value="3066">State Bank of India - Corporate</option>
								<option value="3051">Tamil Nadu State Co-operative Bank</option>
								<option value="3052">Tamilnad Mercantile Bank Ltd</option>
								<option value="3090">The Surat People’s Co-operative Bank Limited</option>
								<option value="3054">UCO Bank</option>
								<option value="3055">Union Bank of India</option>
								<option value="3067">Union Bank of India - Corporate</option>
								<option value="3089">Utkarsh Small Finance Bank</option>
								<option value="3077">Yes Bank Corporate</option>
								<option value="3058">Yes Bank Ltd</option>
								<option value="3333">TEST Bank</option>
							</select>
							<input class="w94" type="text"  name="bank_code_text" style="margin:5px 0;display:none;" />
						  </div>
						  <?}?>

					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'IndiaBankingLogo') !== false){?>
                      <div class="IndiaBankingLogo_div ewalist hide">
                        <div class="banksDiv desImg SBIN"><span class="banks_sprite banks_bank_1" style="vertical-align:middle;"></span><span class="bankNm txNm" >SBI</span></div>
                        <div class="banksDiv desImg ICIC"><span class="banks_sprite banks_bank_2" style="vertical-align:middle;"></span><span class="bankNm txNm" >ICICI</span></div>
                        <div class="banksDiv desImg HDFC"><span class="banks_sprite banks_bank_3" style="vertical-align:middle;"></span><span class="bankNm txNm" >HDFC</span></div>
                        <div class="banksDiv desImg UTIB"><span class="banks_sprite banks_bank_4" style="vertical-align:middle;"></span><span class="bankNm txNm" >Axis</span></div>
                        <div class="banksDiv desImg KKBK"><span class="banks_sprite banks_bank_5" style="vertical-align:middle;"></span><span class="bankNm txNm" >Kotak</span></div>
                        <div class="banksDiv desImg PUNB_R"><span class="banks_sprite banks_bank_6" style="vertical-align:middle;"></span><span class="bankNm txNm" >PNB</span></div>
                      </div>
                      <?}?>

					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'qqxx') !== false){?>
                      <div class="qiwi_div ewalist hide"> <img src="<?=$data['Host']?>/images/qiwi_logo.png" id="qiwi" style="display:block;margin: 5px auto;" /> </div>
                      <?}?>

					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'emailEdit') !== false){?>
                      <div class="emailEdit_div ewalist hide">
                        <input type="text" name="email" class="w93p required" placeholder="RFC compliant email address of the account holder" title="RFC compliant email address of the account holder" value="<?=(isset($post['email'])?$post['email']:'');?>"  />
                      </div>
                      <?}?>

					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'ibanInput') !== false){?>
                      <div class="ibanInput_div ewalist hide">
                        <input type="text" name="iban" class="w93p required" placeholder="Enter Valid IBAN" title="Enter Valid IBAN" value="<?=(isset($post['iban'])?$post['iban']:'');?>" data-required="required" />
                      </div>
                      <?}?>

					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'bicInput') !== false){?>
                      <div class="bicInput_div ewalist hide">
                        <input type="text" name="bic" class="w93p" placeholder="Valid BIC (8 or 11 alphanumeric letters) of consumer’s bank" title="Valid BIC (8 or 11 alphanumeric letters) of consumer’s bank" value="<?=(isset($post['bic'])?$post['bic']:'');?>" />
                      </div>
                      <?}?>

					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'nationalidInput') !== false){?>
                      <div class="nationalidInput_div ewalist hide">
                        <input type="text" name="nationalid" class="w93p required" placeholder="Consumer's national id" data-required="required" value="<?=(isset($post['nationalid'])&&$post['nationalid']?$post['nationalid']:"");?>" />
                      </div>
                      <?}?>

					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'mobilephoneInput') !== false){?>
                      <div class="mobilephoneInput_div ewalist hide">
                        <input type="text" name="mobilephone" class="w93p required" placeholder="Valid international Russian mobile phone number identifying the QIWI destination account to pay" title="Valid international Russian mobile phone number identifying the QIWI destination account to pay out to (excluding plus sign or any other international prefixes, including a leading 7 for Russia, 11 digits in total, e.g. 71234567890)" data-required="required" value="<?=(isset($post['mobilephone'])&&$post['mobilephone']?$post['mobilephone']:(isset($post['bill_phone'])?$post['bill_phone']:''));?>" />
                      </div>
                      <?}?>

					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'siteIdInput') !== false){?>
                      <div class="siteIdInput_div ewalist hide">
                        <input type="text" name="siteId_input" class="w93p required" placeholder="Unique site identifier, forwarded to qiwi." title="Unique site identifier, forwarded to qiwi." data-required="required" value="<?=(isset($post['siteId_input'])?$post['siteId_input']:'');?>" />
                      </div>
                      <? }?>

					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'RevPayBankLogo') !== false){?>
                      <div class="RevPayBankLogo_div ewalist hide">
                        <div class="banksDiv desImg sprite SCB0216" title="Standard Chartered"><span class="imgs" style="vertical-align:middle;"><img src="<?=$data['Host']?>/images/standardChartered.png"  /></span><span class="bankNm txNm">Standard Chartered</span></div>
                        <div class="banksDiv desImg sprite HSBC0223" title="HSBC Bank Malaysia Berhad"><span class="imgs" style="vertical-align:middle;"><img src="<?=$data['Host']?>/images/HSBC.png" /></span><span class="bankNm txNm">HSBC Bank Malaysia Berhad</span></div>
                        <div class="banksDiv desImg sprite RHB0218" title="RHB Bank Berhad"><span class="imgs" style="vertical-align:middle;"><img src="<?=$data['Host']?>/images/RHB Bank.png" /></span><span class="bankNm txNm">RHB Bank Berhad</span></div>
                        <div class="banksDiv desImg sprite ABB0233" title="Affin Bank Berhad"><span class="imgs" style="vertical-align:middle;"><img src="<?=$data['Host']?>/images/Affin Bank Berhad.png" /></span><span class="bankNm txNm">Affin Bank Berhad</span></div>
                      </div>
                      <?}?>
					  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'RevPayList') !== false){?>
                      <div class="RevPayList_div ewalist hide">
                        <select class="w94 dropDwn required form-select from-select-sm" name="bankCode" id="bankCode" style="margin:5px 0;">
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
                      <?}?>
				<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'IsgNetBankingTopBank')!==false){?>
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
							<select class="w94 dropDwn required form-select from-select-sm" name="bankCode" id="bankCode" style="margin:5px 0;">
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
					  }
					  if(isset($post['t_name6'])&&strpos($post['t_name6'],'siteIdInput') !== false){?>
                      <div class="BrazilList_div ewalist hide">
                        <textarea name="address" class="w93p required" cols="30" rows="3" placeholder="Consumer's address" style="line-height:140%;height:55px;"><?=(isset($post['address'])&&$post['address']?$post['address']:(isset($post['bill_full_address'])?$post['bill_full_address']:''));?></textarea>

                        <input type="text" name="zipcode" class="w93p required" placeholder="Consumer's zip/postal code" value="<?=(isset($post['zipcode'])&&$post['zipcode']?$post['zipcode']:(isset($post['bill_zip'])?$post['bill_zip']:''));?>" />
                        <input type="date" name="dob" class="w93p" placeholder="Date of birth"  value="<?=(isset($post['dob'])?$post['dob']:'');?>" />
                      </div>
                      <?}?>

					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'IndiaBankingLogo') !== false){?>
                      <div class="IndiaBankingLogo_div ewalist hide">
                        <div class="banksDiv desImg SBIN"><span class="banks_sprite banks_bank_1" style="vertical-align:middle;"></span><span class="bankNm txNm" >SBI</span></div>
                        <div class="banksDiv desImg ICIC"><span class="banks_sprite banks_bank_2" style="vertical-align:middle;"></span><span class="bankNm txNm" >ICICI</span></div>
                        <div class="banksDiv desImg HDFC"><span class="banks_sprite banks_bank_3" style="vertical-align:middle;"></span><span class="bankNm txNm" >HDFC</span></div>
                        <div class="banksDiv desImg UTIB"><span class="banks_sprite banks_bank_4" style="vertical-align:middle;"></span><span class="bankNm txNm" >Axis</span></div>
                        <div class="banksDiv desImg KKBK"><span class="banks_sprite banks_bank_5" style="vertical-align:middle;"></span><span class="bankNm txNm" >Kotak</span></div>
                        <div class="banksDiv desImg PUNB_R"><span class="banks_sprite banks_bank_6" style="vertical-align:middle;"></span><span class="bankNm txNm" >PNB</span></div>
                      </div>
                      <? }?>
					  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'allPayIndiaBankingList')!== false){?>
                      <div class="allPayIndiaBankingList_div ewalist hide">
                        <select class="w94 dropDwn required form-select from-select-sm" name="bank_code" id="bank_code" style="margin:5px 0;" data-required="required">
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
                      <?}?>
					  <? include $data['Path'].'/include/dynamicui'.$data['iex'];?>
					  
					<? //BANK LIST AND LOGO FOR SABPAISA - ADDED ON 2-12 BY ?>
					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'sabPaisaBankLogo')!==false){?>
						<div class="sabPaisaBankLogo_div ewalist hide">
							
							
							<div class="banksDiv desImg 17"><span class="banks_sprite banks_bank_2" style="vertical-align:middle;"></span><span class="bankNm txNm" >ICICI</span></div>
							<div class="banksDiv desImg 26"><span class="banks_sprite banks_bank_5" style="vertical-align:middle;"></span><span class="bankNm txNm" >Kotak</span></div>
							<div class="banksDiv desImg 30"><span class="banks_sprite banks_bank_6" style="vertical-align:middle;"></span><span class="bankNm txNm" >PNB</span></div>
							<div class="banksDiv desImg 8006"><span class="banks_sprite banks_bank_7" style="vertical-align:middle;"></span><span class="bankNm txNm">IDFC</span></div>
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
					<div class="payuBankingLogo_div ewalist hide">
						<div class="banksDiv desImg SBIB"><span class="banks_sprite banks_bank_1" style="vertical-align:middle;"></span><span class="bankNm txNm" >SBI</span></div>
						<div class="banksDiv desImg ICIB"><span class="banks_sprite banks_bank_2" style="vertical-align:middle;"></span><span class="bankNm txNm" >ICICI</span></div>
						<div class="banksDiv desImg HDFB"><span class="banks_sprite banks_bank_3" style="vertical-align:middle;"></span><span class="bankNm txNm" >HDFC</span></div>
						<div class="banksDiv desImg AXIB"><span class="banks_sprite banks_bank_4" style="vertical-align:middle;"></span><span class="bankNm txNm" >Axis</span></div>
						<div class="banksDiv desImg 162B"><span class="banks_sprite banks_bank_5" style="vertical-align:middle;"></span><span class="bankNm txNm" >Kotak</span></div>
						<div class="banksDiv desImg PNBB"><span class="banks_sprite banks_bank_6" style="vertical-align:middle;"></span><span class="bankNm txNm" >PNB</span></div>
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
					if(isset($post['t_name6'])&&strpos($post['t_name6'],'grezpayBankingLogo')!==false){?>
					<div class="grezpayBankingLogo_div ewalist hide">
						<div class="banksDiv desImg 1030"><span class="banks_sprite banks_bank_1" style="vertical-align:middle;"></span><span class="bankNm txNm">SBI</span></div>
						<div class="banksDiv desImg 1013"><span class="banks_sprite banks_bank_2" style="vertical-align:middle;"></span><span class="bankNm txNm">ICICI</span></div>
						<div class="banksDiv desImg 1004"><span class="banks_sprite banks_bank_3" style="vertical-align:middle;"></span><span class="bankNm txNm">HDFC</span></div>
						<div class="banksDiv desImg 1005"><span class="banks_sprite banks_bank_4" style="vertical-align:middle;"></span><span class="bankNm txNm">AXIS</span></div>
						<div class="banksDiv desImg 1012"><span class="banks_sprite banks_bank_5" style="vertical-align:middle;"></span><span class="bankNm txNm">KOTAK</span></div>
						<!--<div class="banksDiv desImg 1091"><span class="banks_sprite banks_bank_1" style="vertical-align:middle;"></span><span class="bankNm txNm">ANDHRA</span></div>-->
					</div>
					<?
					}
					if(isset($post['t_name6'])&&strpos($post['t_name6'],'allPaygrezpayBankingList') !== false){?>
					<div class="allPaygrezpayBankingList_div ewalist hide">
						<select class="w94 dropDwn required form-select from-select-sm" name="bank_code" id="bank_code" style="margin:5px 0;" data-required="required">
							<option value="1000">Allahabad Bank</option>
							<option value="1091">Andhra Bank</option>
							<option value="1135">AU Small Finance Bank</option>
							<option value="1005">AXIS Bank</option>
							<option value="1093">Bank of Baroda Retail Accounts</option>
							<option value="1009">Bank of India</option>
							<option value="1064">Bank of Maharashtra</option>
							<option value="1025">Canara Bank</option>
							<option value="1094">Catholic Syrian Bank</option>
							<option value="1063">Central Bank of India</option>
							<option value="1043">City Union Bank</option>
							<option value="1034">Corporation Bank</option>
							<option value="1104">COSMOS Bank</option>
							<option value="1026">Deutsche Bank</option>
							<option value="1040">Development Credit Bank</option>
							<option value="1107">Dhanalaxmi Bank</option>
							<option value="1027">Federal Bank</option>
							<option value="1004">HDFC Bank</option>
							<option value="1013">ICICI Bank</option>
							<option value="1120">IDFC Bank</option>
							<option value="1069">Indian Bank</option>
							<option value="1049">Indian Overseas Bank</option>
							<option value="1054">Indusind Bank</option>
							<option value="1003">Industrial Development Bank of India</option>
							<option value="1041">Jammu and Kashmir Bank</option>
							<option value="1032">Karnataka Bank Ltd</option>
							<option value="1048">Karur vysya Bank</option>
							<option value="1012">Kotak Bank</option>
							<option value="1095">Lakshmi Vilas Bank</option>
							<option value="1042">Oriental Bank of Commerce</option>
							<option value="1129">Punjab National Bank</option>
							<option value="1053">Ratnakar Bank</option>
							<option value="1113">Shamrao Vithal Co-operative Bank</option>
							<option value="1045">South Indian Bank</option>
							<option value="1050">State Bank of Bikaner and Jaipur</option>
							<option value="1030">SBI - State Bank of India</option>
							<option value="1065">Tamilnad Mercantile Bank</option>
							<option value="1038">Union Bank of India</option>
							<option value="1046">United Bank of India</option>
							<option value="1044">Vijaya Bank</option>
							<option value="1001">Yes Bank</option>
							<option value="1103">UCO Bank</option>
						</select>
					<input class="w94" type="text" name="bank_code_text" style="margin:5px 0;display:none;" />
					</div>
					<? 
					}
					if(isset($post['t_name6'])&&strpos($post['t_name6'],'safexBankingLogo') !== false){?>
					<div class="safexBankingLogo_div ewalist hide">
						<div class="banksDiv desImg 1186"><span class="banks_sprite banks_bank_1" style="vertical-align:middle;"></span><span class="bankNm txNm" >Andhra</span></div>
						<div class="banksDiv desImg 1210"><span class="banks_sprite banks_bank_6" style="vertical-align:middle;"></span><span class="bankNm txNm" >PNB</span></div>
					</div>
					<?
					}
					if(isset($post['t_name6'])&&strpos($post['t_name6'],'safexBankingList') !== false){?>
					<div class="safexBankingList_div ewalist hide">
						<select class="w94 dropDwn required form-select from-select-sm" name="bank_code" id="bank_code" style="margin:5px 0;" data-required="required">
							<option value="1186">Andhra Bank</option>
							<option value="1220">Bank of India</option>
							<option value="1187">Bank Of Maharashtra</option>
							<option value="1189">Canara Bank</option>
							<option value="1190">Central Bank of India</option>
							<option value="1191">City Union Bank</option>
							<option value="1001">Cosmos Bank</option>
							<option value="1193">Dena Bank</option>
							<option value="1194">Deutsche Bank</option>
							<option value="1195">Development Credit Bank</option>
							<option value="1196">Dhanlaxmi Bank</option>
							<option value="1003">Equitas Small Finance Bank</option>
							<option value="1179">IDFC FIRST Bank</option>
							<option value="1197">Indian Bank</option>
							<option value="1198">Indian Overseas Bank</option>
							<option value="1199">IndusInd Bank</option>
							<option value="1200">Industrial Development Bank of India</option>
							<option value="48">Jammu and Kashmir Bank</option>
							<option value="1201">Janata Sahakari Bank Pune</option>
							<option value="1202">Karnataka Bank</option>
							<option value="1203">Karur Vysya - Corporate Netbanking</option>
							<option value="45">Kotak Bank</option>
							<option value="1204">Lakshmi Vilas Bank - Corporate Netbanking</option>
							<option value="1205">Lakshmi Vilas Bank - Retail Netbanking</option>
							<option value="1206">Nainital Bank</option>
							<option value="1309">PayTM Bank</option>
							<option value="1207">Punjab And Maharashtra Co-operative Bank Limited</option>
							<option value="1208">Punjab And Sind Bank</option>
							<option value="1209">Punjab National Bank - Corporate Banking</option>
							<option value="1210">PNB-Punjab National Bank - Retail Banking</option>
							<option value="1211">Saraswat bank</option>
							<option value="1212">Shamrao Vithal Co-operative Bank Ltd</option>
							<option value="601">South Indian Bank</option>
							<option value="1213">Syndicate Bank</option>
							<option value="1214">Tamilnad Mercantile Bank</option>
							<option value="1215">The Karur Vysya Bank</option>
							<option value="1217">UCO Bank</option>
							<option value="1218">Union Bank - Corporate Netbanking</option>
							<option value="1183">Union Bank Of India</option>
							<option value="2142">UNION BANK OF INDIA RETAIL</option>
							<option value="1219">United Bank of India</option>
							<option value="47">Yes Bank</option>
						</select>
					<input class="w94" type="text" name="bank_code_text" style="margin:5px 0;display:none;" />
					</div>
					<? 
					}
					if(isset($post['t_name6'])&&strpos($post['t_name6'],'IndiaBankingAtomLogo') !== false){?>
						  <div class="IndiaBankingAtomLogo_div ewalist hide">
							<div class="banksDiv desImg 1014"><span class="banks_sprite banks_bank_1" style="vertical-align:middle;"></span><span class="bankNm txNm">SBI</span></div>
							<div class="banksDiv desImg 1002"><span class="banks_sprite banks_bank_2" style="vertical-align:middle;"></span><span class="bankNm txNm">ICICI</span></div>
							<div class="banksDiv desImg 1006"><span class="banks_sprite banks_bank_3" style="vertical-align:middle;"></span><span class="bankNm txNm">HDFC</span></div>
							<div class="banksDiv desImg 1073"><span class="banks_sprite banks_bank_7" style="vertical-align:middle;"></span><span class="bankNm txNm">IDFC</span></div>
							<div class="banksDiv desImg 1013"><span class="banks_sprite banks_bank_5" style="vertical-align:middle;"></span><span class="bankNm txNm">Kotak</span></div>
							<div class="banksDiv desImg 1049"><span class="banks_sprite banks_bank_6" style="vertical-align:middle;"></span><span class="bankNm txNm">PNB</span></div>
						  </div>
						  <?}?>
						  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'atomIndiaBankingList') !== false){?>
						  <div class="atomIndiaBankingList_div ewalist hide">
							<select class="w94 dropDwn hide form-select from-select-sm" name="bank_code_at" id="bank_code" style="margin:5px 0;">
							  <option value="" disabled="">Choose Bank</option>
							  <option value="1075">Bank of Baroda Net Banking Corporate</option>
								<option value="1076">Bank of Baroda Net Banking Retail</option>
								<option value="1012">Bank of India</option>
								<option value="1033">Bank of Maharashtra</option>
								<option value="1030">Canara Bank NetBanking</option>
								<option value="1028">Central Bank of India</option>
								<option value="1031">CSB Bank</option>
								<option value="1027">DCB Bank</option>
								<option value="1024">Deutsche Bank</option>
								<option value="1038">Dhanlaxmi Bank</option>
								<option value="1063">Equitas Bank</option>
								<option value="1019">Federal Bank</option>
								<option value="1006">HDFC Bank</option>
								<option value="1002">ICICI Bank</option>
								<option value="1007">IDBI Bank</option>
								<option value="1073">IDFC FIRST Bank Limited</option>
								<option value="1026">Indian Bank</option>
								<option value="1029">Indian Overseas Bank</option>
								<option value="1015">Indusind Bank</option>
								<option value="1001">Jammu and Kashmir Bank</option>
								<option value="1072">Janata Sahakari Bank LTD Pune</option>
								<option value="1008">Karnataka Bank</option>
								<option value="1018">Karur Vysya Bank</option>
								<option value="1013">Kotak Mahindra Bank</option>
								<option value="1009">Lakshmi Vilas Bank NetBanking</option>
								<option value="1055">Punjab & Sind Bank</option>
								<option value="1077">Punjab National Bank - Corporate</option>
								<option value="1049">PNB - Punjab National Bank [Retail]</option>
								<option value="1066">RBL Bank</option>
								<option value="1051">Standard Chartered Bank</option>
								<option value="1014">SBI - State Bank of India</option>
								<option value="1044">Tamilnad Mercantile Bank</option>
								<option value="1057">UCO Bank</option>
								<option value="1016">Union Bank of India - Retail</option>
								<option value="1005">Yes Bank</option>
							</select>
							<input class="w94" type="text"  name="bank_code_text" style="margin:5px 0;display:none;" />
						  </div>
						  <?}?>
						  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'IndiaBankingIsgLogo') !== false){?>
						  <div class="IndiaBankingIsgLogo_div ewalist hide">
							<div class="banksDiv desImg 1014"><span class="banks_sprite banks_bank_1" style="vertical-align:middle;"></span><span class="bankNm txNm">SBI</span></div>
							<div class="banksDiv desImg 1002"><span class="banks_sprite banks_bank_2" style="vertical-align:middle;"></span><span class="bankNm txNm">ICICI</span></div>
							<div class="banksDiv desImg 1006"><span class="banks_sprite banks_bank_3" style="vertical-align:middle;"></span><span class="bankNm txNm">HDFC</span></div>
							<div class="banksDiv desImg 1073"><span class="banks_sprite banks_bank_7" style="vertical-align:middle;"></span><span class="bankNm txNm">IDFC</span></div>
							<div class="banksDiv desImg 1013"><span class="banks_sprite banks_bank_5" style="vertical-align:middle;"></span><span class="bankNm txNm">Kotak</span></div>
							<div class="banksDiv desImg 1049"><span class="banks_sprite banks_bank_6" style="vertical-align:middle;"></span><span class="bankNm txNm">PNB</span></div>
						  </div>
						  <?}?>
						  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'IsgIndiaBankingList') !== false){?>
						  <div class="IsgIndiaBankingList_div ewalist hide">
							<select class="w94 dropDwn hide form-select from-select-sm" name="bank_code_at" id="bank_code" style="margin:5px 0;">
							  <option value="" disabled="">Choose Bank</option>
							  <option value="2001">Demo</option>
							  <option value="1075">Bank of Baroda Net Banking Corporate</option>
								<option value="1076">Bank of Baroda Net Banking Retail</option>
								<option value="1012">Bank of India</option>
								<option value="1033">Bank of Maharashtra</option>
								<option value="1030">Canara Bank NetBanking</option>
								<option value="1028">Central Bank of India</option>
								<option value="1031">CSB Bank</option>
								<option value="1027">DCB Bank</option>
								<option value="1024">Deutsche Bank</option>
								<option value="1038">Dhanlaxmi Bank</option>
								<option value="1063">Equitas Bank</option>
								<option value="1019">Federal Bank</option>
								<option value="1006">HDFC Bank</option>
								<option value="1002">ICICI Bank</option>
								<option value="1007">IDBI Bank</option>
								<option value="1073">IDFC FIRST Bank Limited</option>
								<option value="1026">Indian Bank</option>
								<option value="1029">Indian Overseas Bank</option>
								<option value="1015">Indusind Bank</option>
								<option value="1001">Jammu and Kashmir Bank</option>
								<option value="1072">Janata Sahakari Bank LTD Pune</option>
								<option value="1008">Karnataka Bank</option>
								<option value="1018">Karur Vysya Bank</option>
								<option value="1013">Kotak Mahindra Bank</option>
								<option value="1009">Lakshmi Vilas Bank NetBanking</option>
								<option value="1055">Punjab & Sind Bank</option>
								<option value="1077">Punjab National Bank - Corporate</option>
								<option value="1049">PNB - Punjab National Bank [Retail]</option>
								<option value="1066">RBL Bank</option>
								<option value="1051">Standard Chartered Bank</option>
								<option value="1014">SBI - State Bank of India</option>
								<option value="1044">Tamilnad Mercantile Bank</option>
								<option value="1057">UCO Bank</option>
								<option value="1016">Union Bank of India - Retail</option>
								<option value="1005">Yes Bank</option>
							</select>
							<input class="w94" type="text"  name="bank_code_text" style="margin:5px 0;display:none;" />
						  </div>
						  <?}?>
						  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'upiIndiaLogo') !== false){?>
						  <div class="upiIndiaLogo_div ewalist hide">
							<div class="upisDiv desImg  BHIM" data-showc="upi_vpa" data-hidec="customerPhone"><img src="<?=$data['Host']?>/images/bhim.png" alt="BHIM" title="BHIM"><span class="upis txNm hide">BHIM</span></div>
							<div class="upisDiv desImg PhonePe" data-showc="upi_vpa" data-hidec="customerPhone"><img src="<?=$data['Host']?>/images/phonepe.png" alt="PhonePe" title="PhonePe"><span class="upis txNm hide">PhonePe</span></div>
							<div class="upisDiv desImg GooglePayTez" data-showc="customerPhone" data-hidec="upi_vpa"><img src="<?=$data['Host']?>/images/tez.png" alt="GooglePayTez" title="GooglePayTez"><span class="upis txNm hide">GooglePayTez</span></div>
							<div class="upisDiv desImg PayTm" data-showc="upi_vpa" data-hidec="customerPhone"><img src="<?=$data['Host']?>/images/paytm.png" alt="PayTm" title="PayTm"><span class="upis txNm hide">PayTm</span></div>
						  </div>
						  <?}?>
						  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'upiIndiaList') !== false){?>
						  <div class="upiIndiaList_div ewalist hide">
							<input class="w94 upi_vpa required form-control form-control-sm" type="text" placeholder="Enter Your UPI VPA" title="Enter Your UPI VPA" name="upi_vpa" id="upi_vpa" style="margin:5px 0;" />
							<input class="w94 form-control form-control-sm customerPhone required hide" type="text" placeholder="Enter your Google Pay 10 digit mobile number" title="Enter your Google Pay 10 digit mobile number" name="customerPhone" id="customerPhone" value="<?=(isset($post['customerPhone'])&&$post['customerPhone']?$post['customerPhone']:$post['bill_phone']);?>" style="margin:5px 0;display:none;" />
							<select class="w94 dropDwn required form-select from-select-sm" name="upi_vpa_lable" id="upi_vpa_lable" style="margin:5px 0; display:none;">
							  <option value="BHIM">BHIM</option>
							  <option value="PhonePe">PhonePe</option>
							  <option value="GooglePayTez">GooglePayTez</option>
							  <option value="PayTm">PayTm</option>
							</select>
						  </div>
						  <?}?>					
						  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'walletLogo')!==false){?>
						  <div class="walletLogo_div ewalist hide">
							<div class="walletsDiv desImg 4002"><img src="<?=$data['Host']?>/images/mobikwik-logo-new.png" alt="Mobikwik" title="Mobikwik" style="display:block;width: 100%;"><span class="wallets txNm hide">MobiKwik</span></div>
							<div class="walletsDiv desImg 4001"><img src="<?=$data['Host']?>/images/freecharge-logo-new.png" alt="FreeCharge" title="FreeCharge" style="display:block;width: 100%;"><span class="wallets txNm hide">FreeCharge</span></div>
							<div class="walletsDiv desImg 4004"><img src="<?=$data['Host']?>/images/jiomoney-logo-new.png" alt="JioMoney" title="JioMoney" style="display:block;width: 100%;"><span class="wallets txNm hide">JioMoney</span></div>
							<div class="walletsDiv desImg 4003"><img src="<?=$data['Host']?>/images/olamoney-logo-pp.png" alt="OlaMoney" title="OlaMoney" style="display:block;width: 100%;"><span class="wallets txNm hide">OlaMoney</span></div>
							<div class="walletsDiv desImg 4008"><img src="<?=$data['Host']?>/images/amazonpay_logo.png" alt="AmazonPay" title="AmazonPay" style="display:block;width:95%;margin:3px auto;"><span class="wallets txNm hide">AmazonPay</span></div>
							<div class="walletsDiv desImg 4009"><img src="<?=$data['Host']?>/images/phonepe.png" alt="PhonePe" title="PhonePe" style="display:block;width:95%;margin:3px auto;"><span class="wallets txNm hide">PhonePe</span></div>
						  </div>
						  <?}?>

					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'walletList') !== false){?>
						  <div class="walletList_div ewalist hide">
							<select class="w94 wDropDown dropDwn required form-select from-select-sm" name="wallet_code" id="wallet_code" style="margin:5px 0;">
							  <option value="4006">AirtelMoney</option>
							  <option value="4008">AmazonPay</option>
							  <option value="4001">FreeCharge</option>
							  <option value="4002">MobiKwik</option>
							  <option value="4003">OlaMoney</option>
							  <option value="4007">Paytm</option>
							  <option value="4009">PhonePe</option>
							  <option value="4004">JioMoney</option>
							</select>
							<input class="w94" type="text" name="wallet_code_text" style="margin:5px 0;display:none;" />
							<input class="w94" type="text" name="wallet_address" style="margin:5px 0;" placeholder="mobile@upi" />
						  </div>
						  <?}?>
						<!---- GREZPAY-->
						<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'grezpaywalletLogo') !== false){?>
						  <div class="grezpaywalletLogo_div ewalist hide">
							<div class="walletsDiv desImg 113"><img src="<?=$data['Host']?>/images/freecharge-logo-new.png" alt="FreeCharge" title="FreeCharge" style="display:block;width: 100%;"><span class="wallets txNm hide">FreeCharge</span></div>
							<div class="walletsDiv desImg 124"><img src="<?=$data['Host']?>/images/amazonpay_logo.png" alt="AmazonPay" title="AmazonPay" style="display:block;width:95%;margin:3px auto;"><span class="wallets txNm hide">AmazonPay</span></div>
							<div class="walletsDiv desImg 101"><img src="<?=$data['Host']?>/images/paytm.png" alt="PayTM" title="PayTM" style="display:block;width:95%;margin:3px auto;"><span class="wallets txNm hide">PayTM</span></div>
						  </div>
						  <? }?>
						  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'grezpaywalletList') !== false){?>
						  <div class="grezpaywalletList_div ewalist hide">
							<select class="w94 wDropDown dropDwn required form-select from-select-sm" name="wallet_code" id="wallet_code" style="margin:5px 0;">
							  <option value="124">AmazonPay</option>
							  <option value="113">FreeCharge</option>
							  <option value="101">PayTM</option>
							   <option value="115">Phonepe</option>
							    <option value="106">JioMoney</option>
							  <?
							  /*
							  //Payment Methods are not Live yet
							  <option value="102">Mobikwik</option>
							  <option value="103">AirtelMoney</option>
							  <option value="104">Vodafone Mpesa</option>
							  <option value="106">JioMoney</option>
							  <option value="107">OlaMoney</option>
							  <option value="115">PhonePe</option>
							  <option value="116">Oxigen</option>
							  <option value="123">SBI Buddy</option>
							  */?>
							</select>
						  </div>
						  <? }?>
						  <!---- PAYUMONEY-->
						  <div class="">
						<? 
						// Added new section for UPI INTENT - DIRECT (When user select particular app then direct re-direct to on that APP) - 
						if(isset($post['t_name6'])&&strpos($post['t_name6'],'upiAppListForIntent') !== false){?>
							<div class="upiAppListForIntent_div ewalist hide">
							<div class="walletsDiv desImg com.mobikwik_new"><img src="<?=$data['Host']?>/images/mobikwik-logo-new.png" alt="Mobikwik" title="Mobikwik" style="display:block;width: 100%;"><span class="wallets txNm hide">MobiKwik</span></div>
							<div class="walletsDiv desImg com.freecharge.android"><img src="<?=$data['Host']?>/images/freecharge-logo-new.png" alt="FreeCharge" title="FreeCharge" style="display:block;width: 100%;"><span class="wallets txNm hide">FreeCharge</span></div>
							<div class="walletsDiv desImg com.jio.myjio"><img src="<?=$data['Host']?>/images/jiomoney-logo-new.png" alt="JioMoney" title="JioMoney" style="display:block;width: 100%;"><span class="wallets txNm hide">JioMoney</span></div>
							<div class="walletsDiv desImg com.olacabs.olamoney"><img src="<?=$data['Host']?>/images/olamoney-logo-pp.png" alt="OlaMoney" title="OlaMoney" style="display:block;width: 100%;"><span class="wallets txNm hide">OlaMoney</span></div>
							<div class="walletsDiv desImg in.amazon.mShop.android.shopping"><img src="<?=$data['Host']?>/images/amazonpay_logo.png" alt="AmazonPay" title="AmazonPay" style="display:block;width:95%;margin:3px auto;"><span class="wallets txNm hide">AmazonPay</span></div>
							<div class="walletsDiv desImg com.phonepe.app"><img src="<?=$data['Host']?>/images/phonepe.png" alt="PhonePe" title="PhonePe" style="display:block;width:95%;margin:3px auto;"><span class="wallets txNm hide">PhonePe</span></div>
							</div>
						<? }
						// UPI values fetch from google play store - 
						// eg. https://play.google.com/store/apps/details?id=com.phonepe.app
						if(isset($post['t_name6'])&&strpos($post['t_name6'],'upiIntentInputList') !== false){?>
							<div class="upiIntentInputList_div ewalist hide">
								<select class="w94 wDropDown dropDwn required form-select from-select-sm" name="upi_code_intent" id="upi_code_intent" style="margin:5px 0;">
								<option value="com.myairtelapp">AirtelMoney</option>
								<option value="in.amazon.mShop.android.shopping">AmazonPay</option>
								<option value="com.freecharge.android">FreeCharge</option>
								<option value="com.mobikwik_new">MobiKwik</option>
								<option value="com.olacabs.olamoney">OlaMoney</option>
								<option value="net.one97.paytm">Paytm</option>
								<option value="com.phonepe.app">PhonePe</option>
								<option value="com.jio.myjio">JioMoney</option>
								<option value="com.google.android.apps.nbu.paisa.user">Google Pay</option>
								</select>
							</div>
							<? }?>
						</div>
						<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'payUwalletLogo') !== false){?>
						<div class="payUwalletLogo_div ewalist hide">
							<div class="walletsDiv desImg FREC"><img src="<?=$data['Host']?>/images/freecharge-logo-new.png" alt="FreeCharge" title="FreeCharge" style="display:block;width: 100%;"><span class="wallets txNm hide">FreeCharge</span></div>
							<?php /*?><div class="walletsDiv desImg AMZPAY"><img src="<?=$data['Host']?>/images/amazonpay_logo.png" alt="AmazonPay" title="AmazonPay" style="display:block;width:95%;margin:3px auto;"><span class="wallets txNm hide">AmazonPay</span></div><?php */?>
							<div class="walletsDiv desImg PAYTM"><img src="<?=$data['Host']?>/images/paytm.png" alt="PayTM" title="PayTM" style="display:block;width:95%;margin:3px auto;"><span class="wallets txNm hide">PayTM</span></div>
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
						<div class="SabPaisawalletLogo_div ewalist hide">
							<div class="walletsDiv desImg 503"><img src="<?=$data['Host']?>/images/amazonpay_logo.png" alt="AmazonPay" title="AmazonPay" style="display:block;width:95%;margin:3px auto;"><span class="wallets txNm hide">AmazonPay</span></div>
							
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


	
					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'upiAppListForCollect') !== false){?>
						<div class="upiAppListForCollect_div ewalist hide">
							<?
							if(!isMobileBrowser())
							{
								if(isset($post['t_name6'])&&strpos($post['t_name6'],'qrcodeadd')!==false){
								?>
								<div class="qrcodeadd_div ewalist hide appLogoDiv desImg qrcode"><img src="<?=$data['Host']?>/images/qr-code-logo.png" alt="QRcode" title="QRCode" style="display:block;width: 100%;" onclick="checkupi('qrcode')"><span class="wallets txNm hide">QRcode</span></div>
								<?
								}
							}?>
							<div class="appLogoDiv desImg bhim"><img src="<?=$data['Host']?>/images/bhim.png" alt="bhim" title="Bhim" style="display:block;width: 100%;" onclick="checkupi('bhim')"><span class="wallets txNm hide">Bhim</span></div>

							<div class="appLogoDiv desImg whatsapp"><img src="<?=$data['Host']?>/images/whatsapp-pay.png" alt="Whatsapp Pay" title="Whatsapp Pay" style="display:block;width: 100%;height:50px" onclick="checkupi('whatsapp')"><span class="wallets txNm hide">Whatsapp Pay</span></div>

							<div class="appLogoDiv desImg google"><img src="<?=$data['Host']?>/images/google_pay.png" alt="Google Pay" title="Google Pay" style="display:block;width: 100%;height:50px " onclick="checkupi('google')"><span class="wallets txNm hide">Google Pay</span></div>
							
							<div class="appLogoDiv desImg mobikwik"><img src="<?=$data['Host']?>/images/mobikwik-logo-new.png" alt="Mobikwik" title="Mobikwik" style="display:block;width: 100%;" onclick="checkupi('mobikwik')"><span class="wallets txNm hide">MobiKwik</span></div>

							<div class="appLogoDiv desImg freecharge"><img src="<?=$data['Host']?>/images/freecharge-logo-new.png" alt="FreeCharge" title="FreeCharge" style="display:block;width: 100%;" onclick="checkupi('freecharge')"><span class="wallets txNm hide">Freecharge</span></div>

							<div class="appLogoDiv desImg jio"><img src="<?=$data['Host']?>/images/jiomoney-logo-new.png" alt="JioMoney" title="JioMoney" style="display:block;width: 100%;" onclick="checkupi('jio')"><span class="wallets txNm hide">JioMoney</span></div>

							<div class="appLogoDiv desImg ola"><img src="<?=$data['Host']?>/images/olamoney-logo-pp.png" alt="OlaMoney" title="OlaMoney" style="display:block;width: 100%;" onclick="checkupi('ola')"><span class="wallets txNm hide">OlaMoney</span></div>

							<?/*?>
							<div class="appLogoDiv desImg amazon"><img src="<?=$data['Host']?>/images/amazonpay_logo.png" alt="AmazonPay" title="AmazonPay" style="display:block;width:95%;margin:3px auto;" onclick="checkupi('amazon')"><span class="wallets txNm hide">AmazonPay</span></div>
							<?*/?>

							<div class="appLogoDiv desImg phonepe"><img src="<?=$data['Host']?>/images/phonepe.png" alt="PhonePe" title="PhonePe" style="display:block;width:95%;margin:3px auto;" onclick="checkupi('phonepe')"><span class="wallets txNm hide">PhonePe</span></div>

							<div class="appLogoDiv desImg paytm"><img src="<?=$data['Host']?>/images/paytm_logo.png" alt="PayTm" title="PayTm" style="display:block;width:95%;margin:3px auto;" onclick="checkupi('paytm')"><span class="wallets txNm hide">PayTm</span></div>
						 
							<div class="appLogoDiv desImg other"><img src="<?=$data['Host']?>/images/other_logo.png" alt="Other" title="Other" style="display:block;width:95%;margin:3px auto; height: 57px;width:100px;" onclick="checkupi('other')"><span class="wallets txNm hide">Other</span></div>
						</div>

					<? }?>

					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'appWalletList') !== false){?>
						  <div class="appWalletList_div ewalist hide clearfix">
							<select class="w94 wDropDown dropDwn required form-select from-select-sm w-50 float-start" name="wallet_code_app" id="wallet_code_app" style="margin:0px 0; width:50% !important;min-width: 50%!important;" onchange="checkupi(this.value)" >
								<option value="" selected="selected">Choose</option>
								<option value="gpay">Google Pay</option>
								<option value="phonepe">PhonePe</option>
								<option value="ola">OlaMoney</option>
								<option value="paytm">PayTm</option>
								<option value="amazon">AmazonPay</option>
								<option value="airtel">Airtel</option>
								<option value="freecharge">Freecharge</option>
								<option value="mobikwik">MobiKwik</option>
								<option value="jio">JioMoney</option>

								<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'qrcodeadd') !== false){?>
								<option value="qrcode" class="qrcodeadd_div ewalist hide">QRcode</option>
								<option value="other" class="qrcodeadd_div ewalist hide">Other</option>
								<? }?>
							</select>
							<input type="text" class="w94 required form-control form-control-sm" id="bill_phone" name="bill_phone" style="margin:5px 0;display:none;" placeholder="mobile" value="<?=isMobileValid($post['bill_phone'])?>" />
							<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'qrcodeadd') !== false){?>
							<input type="text" class="qrcodeadd_div ewalist hide w94 form-control form-control-sm" id="upi_address" name="upi_address" style="margin:5px 0;display:none;width:50% !important;min-width: 50%!important;height: 35px;" placeholder="Enter UPI Address" value="" />
							<? }
							?>
						  </div>
						<? }?>

						<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'upiaddressInput') !== false){?>
						<input type="text" class="upiaddressInput_div ewalist hide w95 form-control form-control w-100 float-start clearfix" id="upi_address_input" name="upi_address" style="margin:0px 0;display:none;" placeholder="Enter full UPI Address" value="<?=(isset($post['upi_address'])?$post['upi_address']:$post['upi_address']);?>" />

					<? }?>
												
					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'upiaddress') !== false){?>


<!--//////////////-->
<style>
.gpay-main .static-menu {
    font-size: 15px;
    font-family: 'Avenir-Medium';
    padding: 5px 10px;
}
.payment-form .form-row {
    display: inline-block;
    width: 100%;
}
.gpay-main .static-menu input.menu-input-onesuffix {
    border: none;
    background: none;
    font-size: 15px;
    padding-top: 5.5px;
}
.static-menu .upi-inp {
    width: 50%;
}
.static-menu {
    border: 1px #ccc solid;
    -webkit-border-radius: 4px;
    -moz-border-radius: 4px;
    border-radius: 4px;
    background: #fff;
    height: 39px;
    padding: 13px 10px;
    position: relative;
    transition: all 400ms ease-in-out;
    width: 100%;
    font-family: 'Avenir-Book';
}
.gpay-main .static-menu input.menu-input {
     border: none;
     background: none;
     font-size: 14px;
     padding-top: 4px;
}

* {
    outline: 0px;
}

#upi2IdRow .sbm-option ul {
    list-style: none;
}

.static-menu .sbm-option {
    position: absolute;
    top: 36px;
    left: -1px;
    width: 100%;
    border-top: none;
    border-bottom: none;
    z-index: 1;
    background: #fff;
    border: 1px #ccc solid;
    -webkit-border-bottom-right-radius: 4px;
    -webkit-border-bottom-left-radius: 4px;
    -moz-border-radius-bottomright: 4px;
    -moz-border-radius-bottomleft: 4px;
    border-bottom-right-radius: 4px;
    border-bottom-left-radius: 4px;
    box-sizing: content-box;
}
#upi2IdRow .static-menu input.menu-input {
    border: none;
    background: none;
    font-size: 14px;
    padding-top: 4px;
}
#upi2IdRow  ul li {
    font-size: 16px;
    font-family: 'Avenir-Medium';
    line-height: normal;
    vertical-align: top;
}

#upi2IdRow ul li {
    margin: 0;
    padding: 10px 13px;
    border: none;
    border-bottom: solid 1px #cccccc;
    font-size: 14px;
    transition: none;
}
#upi2IdRow .gpay-adrate {
    font-size: 16px;
    font-weight: 900;
    line-height: normal;
    vertical-align: middle;
    display: inline-block;
    margin: 4px 0 0 0;
}
#upi2IdRow ul li:hover {
    background: var(--background-1);
    cursor: pointer;
    color: #ffffff;
    transition: none;
}
#upi2IdRow ol, ul { padding-left: 0px !important; }
#upi-data-list input { border:0px;background: none !important; }
#upi2IdRow ul li input:hover { background: var(--background-1) !important;}
dl, ol, ul {margin-bottom: 0px !important; }
</style>
<div class="common-payment-container upiaddress_div ewalist hide">
<div class="payment-form gpay-main">
<div id="upi2IdRow" class="form-row form-row-space border border-2 my-2">
<div class="static-menu">

<input type="text" tabindex="2" name="upi_address" class="upiaddress_div ewalist hide77 required text menu-input-onesuffix upi-inp" id="upi2Id" placeholder="Enter UPI ID" maxlength="120" value=""><span id="upi-suffix" class="gpay-adrate float-end "></span>
<input type="hidden" name="upi_address_suffix" id="upi-suffix-hidden" value="" />
</div>

<div class="sbm-option">
<ul id="upi-data-list" class="upi-data-list">
</ul>

</div>

</div>
</div>
</div>

<? }?>

					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'BBVAInstr') !== false){?>
                      <div class="BBVAInstr_div ewalist hide">
                        <ul>
                          <li>Selecciona la opción <b>"Cuenta y Ahorros"</b> </li>
                          <li>Selecciona <b>"Servicios Públicos" - "SafetyPay" </b> y moneda. </li>
                          <li>Ingrese tu <b>"Código de pago [TransactionID]"</b> </li>
                          <li>Selecciona la Cuenta o Tarjeta de Crédito de cargo, confirma el pago con tu clave SMS y ¡Listo! </li>
                        </ul>
                      </div>
                      <?} ?>

					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'TetherCoins_msg') !== false){?>
                      <div class="TetherCoins_msg_div ewalist modalMsg hide" data-style='width:300px;height:270px;' >
                        <div class="modalMsgCont" style="display:none !important">
                          <div class="modalMsgContTxt" >
                            <h4>
                            TetherCoins</h4>
                            <p><b>On the next screen you need to scan the QR code to pay by TetherCoins. Click Yes below when you are ready</b></p>
                            <span class="submit_div">
                            <button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-icon btn-template btn-sm glyphicons circle_ok " autocomplete="off" style='width:35%' onclick='checkValidity_tr_f();'><i></i><b class="contitxt">Yes</b></button>
                            </span> <a class='nopopup suButton btn btn-icon btn-primary' style='width:35%' onClick="view_tr_next3(this,'.noText3')" data-ph="430px" data-ch="270px">No</a>
                            <p class='hide noText3'>(If you do not have mobile application to scan QR code, you can still click on Yes above and we will share our BTC address which you can copy from next screen and send the exact payment to our btc address. )</p>
                          </div>
                        </div>
                      </div>
                      <?}?>

					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'BitCoins_msg') !== false){?>
                      <div class="BitCoins_msg_div ewalist modalMsg hide" data-style='width:300px;height:300px;' >
                        <div class="modalMsgCont" style="display:none !important">
                          <div class="modalMsgContTxt" >
                            <h4>
                            BitCoins</h4>
                            <p><b>On the next screen you need to scan the QR code to pay by BitCoin. Click Yes below when you are ready</b></p>
                            <span class="submit_div">
                            <button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-icon btn-template btn-sm glyphicons circle_ok " autocomplete="off" style='width:35%' onclick='checkValidity_tr_f();'><i></i><b class="contitxt">Yes</b></button>
                            </span> <a class='nopopup suButton btn btn-icon btn-primary' style='width:35%' onClick="view_tr_next3(this,'.noText3')" data-ph="430px" data-ch="270px">No</a>
                            <p class='hide noText3'>(If you do not have mobile application to scan QR code, you can still click on Yes above and we will share our BTC address which you can copy from next screen and send the exact payment to our btc address. )</p>
                          </div>
                        </div>
                      </div>
                      <? } ?>

					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'AdvCash_msg') !== false){?>
                      <div class="AdvCash_msg_div ewalist modalMsg hide" data-style='width:300px;height:220px;' >
                        <div class="modalMsgCont" style="display:none !important">
                          <div class="modalMsgContTxt" >
                            <h4>
                            AdvCash</h4>
                            <p><b>Do you already have ADVCASH eWallet Account?</b></p>
                            <span class="submit_div">
                            <button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-icon btn-template btn-sm glyphicons circle_ok " autocomplete="off" style='width:35%' onclick='checkValidity_tr_f();'><i></i><b class="contitxt">Yes</b></button>
                            </span> <a class='nopopup suButton btn btn-icon btn-primary' style='width:35%' onClick="view_tr_next3(this,'.noText3')" data-ph="400px" data-ch="200px">No</a>
                            <p class='hide noText3'>(If you do not have ADVCASH eWallet account, You can logon to advcash.com and create an account once your account is <a href='https://wallet.advcash.com/register' target='_blank'>created/verified</a> you can come back to us and complete the payment for your favourite merchant.)</p>
                          </div>
                        </div>
                      </div>
                      <?} ?>

					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'cashU_msg') !== false){?>
                      <div class="cashU_msg_div ewalist modalMsg hide" data-style='width:300px;height:270px;' >
                        <div class="modalMsgCont" style="display:none !important">
                          <div class="modalMsgContTxt" >
                            <h4>
                            CASHU</h4>
                            <p><b>Do you already have CASHU eWallet Account?</b></p>
                            <span class="submit_div">
                            <button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-icon btn-template btn-sm glyphicons circle_ok " autocomplete="off" style='width:35%' onclick='checkValidity_tr_f();'><i></i><b class="contitxt">Yes</b></button>
                            </span> <a class='nopopup suButton btn btn-icon btn-primary' style='width:35%' onClick="view_tr_next3(this,'.noText3')"  data-ph="430px" data-ch="270px">No</a>
                            <p class='hide noText3'>(If you do not have CASHU eWallet account, You can logon to cashu.com and create an account once your account is <a href='https://www.cashu.com/CLogin/registersForm?lang=en' target='_blank'>created/verified</a> you can come back to us and complete the payment for your favourite merchant.)</p>
                          </div>
                        </div>
                      </div>
                      <?} ?>
                      <div class="universal_msg_div ewalist modalMsg hide" data-style='width:300px;height:280px;' >
                        <div class="modalMsgCont" style="display:none !important">
                          <div class="modalMsgContTxt" >
                            <p><b>We are about to redirect you to bank page to authenticate this transactions in the next tab.</b></p>
                            <span class="submit_div">
                            <button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-icon btn-template btn-sm glyphicons circle_ok " autocomplete="off" style='width:35%' onclick='checkValidity_tr_f();'><i></i><b class="contitxt">Yes</b></button>
                            </span> <a class='nopopup suButton btn btn-icon btn-primary' style='width:35%' onClick="document.getElementById('modal_msg').style.display='none';">No</a>
                            <p>You can always switch back to this tab if transactions is not successful. </p>
                          </div>
                        </div>
                      </div>
					  

					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'BNPay_msg') !== false){?>
                      <div class="BNPay_msg_div ewalist modalMsg hide" data-style='width:340px;height:320px;' >
                        <div class="modalMsgCont" style="display:none !important">
                          <div class="modalMsgContTxt" >
                            <h4>
                            BINANCE</h4>
                            <p><b>Do you already have BINANCE Wallet?</b></p>
                            <span class="submit_div">
                            <button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-icon btn-template btn-sm" autocomplete="off" style='width:35%' onclick='checkValidity_tr_f();'><i class="far fa-check-circle"></i> <b class="contitxt">Yes</b></button>
                            </span> <a class='nopopup suButton btn btn-icon btn-primary' style='width:35%' onClick="view_tr_next3(this,'.noText3')" data-ph="400px" data-ch="200px">No</a>
                            <p class='hide noText3'>(If you do not have BINANCE Wallet, You can logon to binance.com and create an account once your account is <a href="https://accounts.binance.com/en/login" target="_blank"><strong>created/verified</strong></a> you can come back to us and complete the payment for your favourite merchant.)</p>
                          </div>
                        </div>
                      </div>
                      <? }?>

					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'universal_msg_17')!==false){?>
					  <div class="universal_msg_17_div ewalist modalMsg hide" data-style='width:340px;height:450px;margin:-160px 0px 0px -177px;' >
                        <div class="modalMsgCont" style="display:none !important">
                          <div class="modalMsgContTxt" >
                            <p><b>Important Message:</b><br />
							You are being redirected to our partner site <b>funpoint</b> to authorise this transaction. <br />
							On the next page you will see your order amount in NTD (New Taiwan Dollar) instead of USD. <b>Your card will be charged equivalent amount of your USD order in NTD only</b>. You can get back us to email for any assistance with this order.</b></p>
                            <span class="submit_div">
                            <button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-icon btn-template btn-sm glyphicons circle_ok " autocomplete="off" style='width:35%' onclick='checkValidity_tr_f();'><i></i><b class="contitxt">Yes</b></button>
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
                            <button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-icon btn-template btn-sm glyphicons circle_ok " autocomplete="off" style='width:35%' onclick='checkValidity_tr_f();'><i></i><b class="contitxt">Yes</b></button>
                            </span> <a class='nopopup suButton btn btn-icon btn-primary' style='width:35%' onClick="document.getElementById('modal_msg').style.display='none';">No</a>
                            <p>You can always switch back to this tab if transactions is not successful. </p>
                          </div>
                        </div>
                      </div>
					  <?
					  }?>
					  
						
						<div class="separator"></div>
						<div class="submit_div" style="padding:0;">
							<button id="cardsend_submit" type=submit name=send123 value="CHANGE NOW!"  class="submitbtn btn btn-icon btn-template btn-sm next"><b class="contitxt">CONTINUE</b></button>
						</div>
						
						<div class="modal_msg" id="modal_msg">
                        <div class="modal_msg_layer"> </div>
                        <div class="modal_msg_body"> <a class="modal_msg_close" onClick="document.getElementById('modal_msg').style.display='none';">×</a>
                          <div id="modal_msg_body_div"> </div>
                          <a class="modal_msg_close2" onClick="document.getElementById('modal_msg').style.display='none';">Close</a></div>
                      </div>
						
						</div>
					</form>
					</div>
					<? } ?>
					
					
					</div>
				<? } ?>
				
				
				
				</div>
				
			 
			 
			
				<a class="float-end my-2" title="Back to Available Payment Methods" style="clear:both;padding:0 10px 0 0;"><i class="fa-solid fa-circle-arrow-left text-primary fa-2x fa-beat-fade hide" id="payhide"></i></a>
				
					 <? if(((!empty($post['nick_name_ewallets']))||(!empty($post['nick_name_net_banking']))||(!empty($post['nick_name_upi'])))&&(!isset($_SESSION['mISO2']))){?>
				  <div class="hide otherPaymentMethod2" id="otherPaymentMethod"> 
				  <a class="change hide btn btn-icon btn-primary otherPaymentMethodLink my-2 w-75" id="otherPaymentMethodLink" style="display: block;">All Other Payment Method</a> 
				   </div>
				  
				  <? } ?>
				  
				<div style="clear:both"></div>
			 </div> 
				
	
	

				  
		
		<!--<a class="inputSetp2 backimg" style=""><i class="fas fa-backward"></i> Back</a>-->
		
		<? if((isset($post['pricManual'])&&$post['pricManual'])||(empty($post['fullname']) || empty($post['bill_phone']) || empty($post['email']) ))
		{
		?>
		<!--<a class="inputPaySetp3 backimg" ><i class="fas fa-backward"></i> Back</a>-->
		<?
		}
		?>
		</div>
		<?
		}
		?>
		</div>
		
		<?  
if(isset($_POST['payment'])&&$_POST['payment']=='creditcard'){	
?>
<script type="text/javascript" >
SlideBox('card',false);
</script>
<?
}elseif(isset($_POST['payment'])&&$_POST['payment']=='epayaccount'){ ?>
<script type="text/javascript" >
SlideBox('epay',false);
</script>
<? } ?>
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

cardLength=19;
setCardLength_allcard=19;
setCardLength_amex=18;

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
		
		if ( card_validation == 'yes' ) {
			if ( ( $.payform.validateCardNumber(cardNumber.val()) == false ) && ( ($.inArray(cardNumber.val().replace(/\s+/g, ''), jsTestCardNumbers ) === -1) && ($.inArray(cardNumber.val().replace(/\s+/g, '').substring(0, 6), jsLuhnSkip ) === -1)  )  ) {
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
				cardNumber.attr('class','form-control form-control-sm my-1 w-100 iconnocard');
			} else {
				//cardNumberField.removeClass('has-error');
				$form.find('#form-input-errors').text("");
				$form.find('#form-input-errors').css('display','none');
				$("#cardsend_submit").prop('disabled', false);
				
				//cardNumberField.addClass('has-success');
				
				if((cardNumber.val().length === cardLength || cardNumber.val().length == cardLength) && ( ($.inArray(cardNumber.val().replace(/\s+/g, ''), jsTestCardNumbers ) === -1) && ($.inArray(cardNumber.val().replace(/\s+/g, '').substring(0, 6), jsLuhnSkip ) === -1)  ) ) {
					 var val = $.payform.parseCardType(cardNumber.val());
					 var ccn_match = '';
					 if(val){
						 ccn_match = ccn_var.match(new RegExp(val, 'i'));
					 }
					 if(ccn_match){
						//alert('ccn_match'+"\r\n"+ccn_var);
					 }else{
						alert($('.alert_msg_2').text());
					}
				}
				cardNumber.attr('class','form-control form-control-sm my-1 icon'+$.payform.parseCardType(cardNumber.val()));
				
			}
			
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
		$('#credit_cards #'+$.payform.parseCardType(cardNumber.val())).removeClass('transparent');
		
		
		
		
		//e.preventDefault();
	});
	
	
	expMonth.focus(function(){
		$('#form-input-errors').css('display','none');	
	});
	
}

	$('#payment_form_id').submit(function(e) {
	 try {
		var $form = $('#payment_form_id');
		var cardNumber = $('#number');
		
		//////////////////////HHHHHHHHHHHHhh///////////
		
		
		var isCardValid = $.payform.validateCardNumber(cardNumber.val());
		var isCvvValid = $.payform.validateCardCVC(CVV.val());
		
		if ( card_validation == 'yes' ) {
			
			if( (cardNumber.val().length === cardLength) && ( ($.inArray(cardNumber.val().replace(/\s+/g, ''), jsTestCardNumbers ) === -1) && ($.inArray(cardNumber.val().replace(/\s+/g, '').substring(0, 6), jsLuhnSkip ) === -1)  ) ){
					 var val = $.payform.parseCardType(cardNumber.val());
					 var ccn_match = ccn_var.match(new RegExp(val, 'i'));
					 if(ccn_match){
						//alert('ccn_match'+"\r\n"+ccn_var);
					 }else{	
						//alert("222="+cardNumber.val().replace(/\s+/g, '')+$('.alert_msg_2').text());
						alert($('.alert_msg_2').text());
						cardNumber.focus();
						return false;
					}
			}

			 
			if ( ( !isCardValid ) && ( ($.inArray(cardNumber.val().replace(/\s+/g, ''), jsTestCardNumbers ) === -1) && ($.inArray(cardNumber.val().replace(/\s+/g, '').substring(0, 6), jsLuhnSkip ) === -1)  )  ) {
				//alert('11BrowserName=>'+BrowserName+',cardLength=>'+cardLength+',setCardLength_amex=>'+setCardLength_amex+',setCardLength_allcard=>'+setCardLength_allcard+',cardNumber val=>'+cardNumber.val()+',cardNumber length =>'+cardNumber.val().length); 
				
				//alert("Wrong card number.");
				alert($('.alert_msg_11').text());
				return false;
				
			}else if (!isCvvValid) {
				alert("Wrong CVV");
			} else {

				
				$("#cardsend_submit .contitxt").text('Please wait ...');
				$("#cardsend_submit").prop('disabled', true);
				
				//top.window.openFullscreen_2();
				
				$form.append('<input type="text" name="cardsend" style="display:none"  value="CHECKOUT" />');
					$('#modalpopup_form_popup').slideDown(900);
				//alert("Other Acc.="+$('#payment_form_id input[name="midcard"]').val());
				$form.get(0).submit();
				
				
			}
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
			
			
			function checkupi(val)
			{
				//$('#upi_address_suffix').show(800);
				$('#upi_address').attr('placeholder','Enter UPI Address');
				$('#upi_address').attr('value','');
				$('.upi-li-list').remove(); ///Added By Vikash
				$('#upi-suffix').show(); ///Added By Vikash
				$('#upi-suffix').removeClass('dropdown-toggle'); ///Added By Vikash 
				
				if(val=='qrcode')
				{
					$('#upi_address').hide();
					$('#upi_address').removeAttr('required');
					$('#upi_address').val('');
				}
				else 
				{
					$('#upi_address').show(800);
					$('#upi_address').attr('required','required');
					/*if(val) {
						$('#upi_address').val('@'+val);
					}
					*/
					//alert(val);
					
					if(val=='phonepe')
					{

                        $('#upi-suffix').html('@ybl');//Added By Vikash//////////
						$('#upi-suffix-hidden').val('@ybl');//Added By Vikash//////////
						$('#upi-suffix').addClass('dropdown-toggle'); ///Added By Vikash

					}else if(val=='mobikwik')
					{
						$('#upi-suffix').html('@ikwik');	///Added By Vikash////	
						$('#upi-suffix-hidden').val('@ikwik');//Added By Vikash//////////				
					}else if(val=='amazon')
					{
						$('#upi-suffix').html('@apl');	///Added By Vikash////	
						$('#upi-suffix-hidden').val('@apl');//Added By Vikash//////////	
					
					}
					else if(val=='google')
					{
						$('#upi-suffix').html('@okicici');//Added By Vikash//////////
						$('#upi-suffix-hidden').val('@okicici');//Added By Vikash//////////	
						$('#upi-suffix').addClass('dropdown-toggle'); ///Added By Vikash
					}
					else if(val=='bhim')
					{
						$('#upi-suffix').html('@upi');///Added By Vikash////
						$('#upi-suffix-hidden').val('@upi');//Added By Vikash//////////								
					}
					else if(val=='whatsapp')
					{
						$('#upi-suffix').html('@icici');//Added By Vikash//////////
						$('#upi-suffix-hidden').val('@icici');//Added By Vikash//////////	
						$('#upi-suffix').addClass('dropdown-toggle'); ///Added By Vikash
					}else 
					{
						$('#upi-suffix').html('@'+val);///Added By Vikash////
						if(val=='other'){
							$('#upi-suffix-hidden').val(''); // add mithilesh 
						}else{
							$('#upi-suffix-hidden').val('@'+val);//Added By Vikash//////////	
						}
						
						if((val=='paytm') || (val=='jio') || (val=='freecharge'))
						{
						
							$('#upi_address, #upi2Id').attr('placeholder','Enter your mobile number');
							<? 
							if(isset($post['bill_phone'])&&$post['bill_phone']) 
							{
							?>
							$('#upi_address, #upi2Id').attr('value','<?=isMobileValid($post['bill_phone']);?>');
							<?
							}
							?>
						}
					}
				}
				if(val=='other'){
					$('#upi_address').val('');
					//$('#upi_address_suffix').hide();
					$('#upi-suffix').hide();
				}
			}

			$(document).ready(function() {
			
			//$('#upi_address_suffix').hide();
			
			$(".account_types").click(function(){
				if($(".cardHolder")){
					$(".cardHolder").css("display", "");
				}
				
				$("#payhide").show();
			});
			
			$(".inputype.the_icon.payNextList").click(function(){
				if($(".cardHolder")){$(".cardHolder").css("display", "");}
				$("#payhide").show();
			});
			
			$("#payhide,#goBackPaymentMethodLink").click(function(){
				if($(".cardHolder")){$(".cardHolder").css("display", "none");}
				$(".paymentMethodDiv").show(800);
			});
			
		
			setTimeout(function(){
				$('#number').removeClass('iconvisa');
				$('#number').addClass('iconvisa form-control form-control-sm my-1');
			}, 1000);
			
			
			$('#upi2Id').on("input", function() {
				var dInput = this.value;
				console.log(dInput);
				//alert(dInput);
				$('.upi-inp').val(dInput);
			});
			
			$("#upi-suffix").click(function(){
			  var upival = $("#upi-suffix").html();
			 // alert(upival);
			if(upival=="@ybl" || upival=="@ibl" || upival=="@axl" ){
			  
			var listdata='<li class="upi-li-list" onclick="livalclick1(\'@ybl\')"><span class="gpay-adrate float-end upi-select">@ybl</span><input readonly="" class="text menu-input upi-inp" value=""></li><li class="upi-li-list" onclick="livalclick1(\'@ibl\')"><span class="gpay-adrate float-end upi-select" >@ibl</span><input readonly="" class="text menu-input upi-inp" value=""></li><li class="upi-li-list" onclick="livalclick1(\'@axl\')"><span class="gpay-adrate float-end upi-select">@axl</span><input readonly="" class="text menu-input upi-inp" value=""></li>';
			$('#upi-data-list').html(listdata);
			
			  
			} else if(upival=="@okicici" || upival=="@okhdfcbank" || upival=="@oksbi" || upival=="@okaxis"){
			  
			var listdata='<li class="upi-li-list" onclick="livalclick1(\'@okicici\')"><span class="gpay-adrate float-end upi-select" >@okicici</span><input readonly="" class="text menu-input upi-inp" value=""></li><li class="upi-li-list" onclick="livalclick1(\'@okhdfcbank\')"><span class="gpay-adrate float-end upi-select">@okhdfcbank</span><input readonly="" class="text menu-input upi-inp" value=""></li><li class="upi-li-list" onclick="livalclick1(\'@oksbi\')"><span class="gpay-adrate float-end upi-select" >@oksbi</span><input readonly=""  class="text menu-input upi-inp" value=""></li><li class="upi-li-list" onclick="livalclick1(\'@okaxis\')"><span class="gpay-adrate float-end upi-select">@okaxis</span><input readonly=""  class="text menu-input upi-inp" value=""></li>';
			$('#upi-data-list').html(listdata);
			
			} else if(upival=="@icici" || upival=="@waaxis" || upival=="@wahdfcbank" || upival=="@wasbi"){
			  
			var listdata='<li class="upi-li-list" onclick="livalclick1(\'@icici\')"><span class="gpay-adrate float-end upi-select">@icici</span><input readonly=""  class="text menu-input upi-inp" value=""></li><li class="upi-li-list" onclick="livalclick1(\'@waaxis\')"><span class="gpay-adrate float-end upi-select">@waaxis</span><input readonly=""  class="text menu-input upi-inp" value=""></li><li class="upi-li-list" onclick="livalclick1(\'@wahdfcbank\')"><span class="gpay-adrate float-end upi-select" >@wahdfcbank</span><input readonly=""  class="text menu-input upi-inp" value=""></li><li class="upi-li-list" onclick="livalclick1(\'@wasbi\')"><span class="gpay-adrate float-end upi-select">@wasbi</span><input readonly=""  class="text menu-input upi-inp" value=""></li>';
			$('#upi-data-list').html(listdata);
			  }else{}
			  
			});
			
			//setTimeout(livalclick, 1000);
});

			function livalclick1(val){
				$("#upi-suffix").html(val); 
				$('#upi-suffix-hidden').val(val);
				$('.upi-li-list').remove();
			}
			
			</script>

			</div>
		</div>
	</div>
</div>
