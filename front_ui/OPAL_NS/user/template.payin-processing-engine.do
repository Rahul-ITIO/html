<? 
$data['con_name']='clk';
if(isset($_REQUEST['fullname'])){
	$post['fullname']=stf($_REQUEST['fullname']);
}
//echo $SiteName=$_SESSION['domain_server']['as']['SiteName'];
//print_r($_SESSION);
//print_r($post);

//$_SESSION['re_post']['failed_reason']='Do Not Honor Payment Failed.';

$billerEmpaty='';

/*
if(isset($data['domain_server']['subadmin']['customer_service_email'])&&$data['domain_server']['subadmin']['customer_service_email'])
	$customer_service_email=$_SESSION['customer_service_email']=encrypts_decrypts_emails($data['domain_server']['subadmin']['customer_service_email'],2);
								
echo 'at <b>'.$_SESSION['customer_service_email'].'</b>';
*/
?>

<script language="javascript" type="text/javascript">  
var billerEmpaty='';
var billerAddressEmpaty='';

function heightCalcf_2(){
	setTimeout(function(){ 
		heightCalcf('.processall');
	}, 900);
	
	setTimeout(function(){ 
		heightCalcf('.processall');
	}, 1500);
}

$(document).ready(function(){ 

	heightCalcf_2();
	
	<? if((isset($data['CHECKOUT_OPAL_NS_ADDRESS_ENABLE'])&&@$data['CHECKOUT_OPAL_NS_ADDRESS_ENABLE']=='Y')&&(empty($post['fullname']) || empty($post['bill_phone']) || empty($post['bill_email']) || empty($post['bill_address']) || empty($post['bill_state']) || empty($post['bill_city']) || empty($post['bill_country']) || empty($post['bill_zip']) ) ){?>
			billerEmpaty='ok';	
			billerAddressEmpaty='Y';
	<? $billerEmpaty='Y'; } elseif(empty($post['fullname']) || empty($post['bill_phone']) || empty($post['bill_email']) ){?>
			billerEmpaty='ok';	
	<? $billerEmpaty='Y'; } ?>
	
	
	$('.account_types').click(function(){
		
		
		
		var channelVar= $(this).attr('data-channel');
		
		if((channelVar !== undefined)&&(channelVar==='2' || channelVar==='3')){
			$(".toast-box").slideDown(1400);
			$('.submit_div.m-button').show();
		}
		else if((channelVar !== undefined)&&(channelVar==='9')){
			
			$('.submit_div.m-button').hide();
			$('.is_channel').show();
			$('.is_not_channel').hide();
		}
		else{
			$('.is_channel').hide();
			$('.is_not_channel').show();
			
			$('.submit_div').show();
		}
		
		if(transID){
		
		// Hide for stop alert 
			  /*let payChange = "Are your sure change payment option!!!";
			  //if (confirm(payChange) == true) {
			  if (confirm(payChange) == true) {
				//payChange = "You pressed OK!";
				spinner_hide_f();
			  } else {
				//payChange = "You canceled!";
				return false;
			  }*/
		}
		
		/*
		if($('div').hasClass('actionajax')){
			$('.actionajax').val('');
		}
		*/
		
		$('.actionajax').val('');
		$('.mop_ajax_checkout').val('');
	
		$('.submit_div .contitxt').html("<span style='' class='loader-btn'>Pay</span>");
		var ccn_array;
		var name_var = $(this).attr('data-name');
		var value_var = $(this).attr('data-value');
		ccn_var = $(this).attr('data-ccn');

		var ewalistVar= $(this).attr('data-ewlist');

		$('.upi_qr_border_div').hide();
		$('.upi_qr_border_'+value_var).show();
		
		$('#payment_form_id_ewallets').removeClass('nextTabTr');
		//$('#payment_form_id_ewallets').removeAttr('target');
		
		var etypeVar= $(this).attr('data-etype');
		if((etypeVar !== undefined)&&(etypeVar==='3D')){
			//$('#payment_form_id_ewallets').attr('target','payin_win');
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

		$('.account_types').removeClass('active');

		$('.cname label[for="'+value_var+'"]').addClass('active');
		$(this).addClass('active');
		
		$('.checkOutOptions').show();
		
		<? if(isset($data['con_name'])&&$data['con_name']=='clk'){?>
		   //alert("999999999999");
			$('#paymentMethodChange').show();
			$('.chkname').hide();
			$('.next_icon_v').hide();
			$('.paymentMethodh4').html($(this).next().html());
			$('.back_action').hide();
			$('.heading2_ind').hide();
			$('.paymentMethodDiv').addClass("label_active");
				$('.paymentMethodh4 .heading2_ind , .paymentMethodh4 .back_action').show();
		<? } ?>
        //alert(name_var);
		$('.pay_div').slideUp(300); //200
		$('.'+name_var+'_div').slideDown(400); //700
		
		
		$('#payment_form_id input[name="acquirer"]').val(value_var);
	
		/*
		if(ewalistVar !== undefined){
			
			$('.ewalist').hide();
			$('.ewalist').removeClass('active');
			$('.ewalist.'+ewalistVar+'_div').show();
			$('.ewalist.'+ewalistVar+'_div').addClass('active');
			
			var ewalistVar_arr = ewalistVar.split(' ');
			for(var i = 0; i < ewalistVar_arr.length; i++)
			{
				if(ewalistVar_arr[i]){
					$('.ewalist.'+ewalistVar_arr[i]+'_div').show();
					$('.ewalist.'+ewalistVar_arr[i]+'_div').addClass('active');
				}
			}
			
			
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
			
		}
		*/
		
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

			$('#payment_form_id_ewallets input[name="acquirer"]').val(value_var);
		}
		
		//644
		
		if(value_var==644){
			$("#cardsend_submit").eq(0).trigger("click");
			//$("#payhide").eq(0).trigger("click");
			$('.paymentMethodDiv').slideDown(50);
			$('.cardHolder').hide(50);
		}
		

		if($(this).attr('data-name')==="ewallets"){
			$('#payment_form_id_ewallets input[name="acquirer"]').val(value_var);
		}
		
		if($(this).attr('data-name')==="ebanking"){
			$('#payment_form_id_ebanking input[name="acquirer"]').val(value_var);
		}
		
		if($(this).attr('data-name')==="bhimupi"){
			$('#payment_form_id_bhimupi input[name="acquirer"]').val(value_var);
		}

		if(curSym==''){
			curSym=$(this).attr('data-currency');
		}

		$('#t_amt').html(curSym);
		$('.bill_amtSys').html(curSym);
		$('.currSymbl').html(curSym);
		
		
		//11 bt
		if((channelVar !== undefined)&&(channelVar==='11')){
			$('.submit_div.m-button').hide();
			if($(this).hasClass('submited')){
				
			} else {
				
				$(this).addClass('submited');
				
				ajaxFormf(channelVar,'bt');
				
				/*
				setTimeout(function(){
					$("#payment_form_id_ewallets").submit(); 
				},300);
				setTimeout(function(){
					$('#modalpopup_form_popup').hide(); 
				},400); 
				*/

			}
			//$(".toast-box").slideDown(1400);
		}
		else if((channelVar !== undefined)&&(channelVar==='9'||channelVar==='10')){
			// Intent Auto hit 
			if( $('div').hasClass('intent_push') ){
				//alert('intent_push===');
				$('.intent_push').addClass('active');
				generate_intent_array_urlf();
			}
		}
		
		heightCalcf_2();
		
		
	});


	$('#bill_amtChange').click(function(){

			$('#bill_amtInputDiv').removeClass('activeInput');
			$('#bill_amtChange').hide(200);
			$('.nextSt').hide(200);
			$('.sIn').show(800);
			
			$('.paymentMethodDiv').hide(50);
			$('.chkname').hide();
			$('#paymentMethodChange').hide(50);
			$('.checkOutOptions').hide();
			$('.contInfoBar').hide();
			
			$('.paymentMethodh4').html('CARDS, UPI & MORE');
			$('.account_types').removeClass('active');
			$('.cname label').removeClass('active');
	});

	$('#contSubmit').click(function(){
		
		heightCalcf_2();
		
		var fullName = $('.contInputDiv input[name="fullname"]').val(); 
		var phone = $('.contInputDiv input[name="bill_phone"]').val();
		var email = $('.contInputDiv input[name="bill_email"]').val();
		
		var bill_address = $('.contInputDiv input[name="bill_address"]').val();
		var bill_city = $('.contInputDiv input[name="bill_city"]').val();
		var bill_state = $('.contInputDiv input[name="bill_state"]').val();
		var bill_zip = $('.contInputDiv input[name="bill_zip"]').val();
		var bill_country = $('.contInputDiv input[name="bill_country"]').val();

		if(fullName == '') {
			alert("Full Name can not Blank! Please enter the Full Name.");
			$('.contInputDiv input[name="fullname"]').focus();
			return false;
		}else if(phone == '') {
			alert("Phone Number not Blank! Please enter the Phone Number.");
			$('.contInputDiv input[name="bill_phone"]').focus();
			return false;
		}else if(email == '') {
			alert("Email ID not Blank! Please enter the Email ID");
			$('.contInputDiv input[name="bill_email"]').focus();
			return false;
		}else if(!isEmailAddr(email)) {
			alert("Please enter a complete email address in the form: yourname@yourdomain.com");
			$('.contInputDiv input[name="bill_email"]').focus();
			return false;
		}else if(billerAddressEmpaty == 'Y' && bill_address == '') {
			alert("Bill Address not Blank! Please enter the Bill Address");
			$('.contInputDiv input[name="bill_address"]').focus();
			return false;
		}else if(billerAddressEmpaty == 'Y' && bill_city == '') {
			alert("Bill City not Blank! Please enter the Bill City");
			$('.contInputDiv input[name="bill_city"]').focus();
			return false;
		}else if(billerAddressEmpaty == 'Y' && bill_state == '') {
			alert("Bill State not Blank! Please enter the Bill State");
			$('.contInputDiv input[name="bill_state"]').focus();
			return false;
		}else if(billerAddressEmpaty == 'Y' && bill_country == '') {
			alert("Bill Country not Blank! Please enter the Bill Country");
			$('.contInputDiv input[name="bill_country"]').focus();
			return false;
		}else if(billerAddressEmpaty == 'Y' && bill_zip == '') {
			alert("Bill Zip not Blank! Please enter the Bill Zip");
			$('.contInputDiv input[name="bill_zip"]').focus();
			return false;
		}else {
			$('.errorDivId').hide(200);
			$('.contInputDiv').hide(200);
			$('.paymentMethodDiv').show(800);
			$('.chkname').show(800);
			$('.checkOutOptions').hide(100);
			$('.contInfoBar').show(100);
			$('.fullNmBar').html('<i class="<?=@$data['fwicon']['profile'];?> px-2 py-1"></i> ' + $('.contInputDiv input[name="fullname"]').val());
			$('.mobileBar').html('<i class="<?=@$data['fwicon']['mobile'];?> px-2 py-1 "></i> ' + $('.contInputDiv input[name="bill_phone"]').val());
			$('.emailBar').html('<i class="<?=@$data['fwicon']['email'];?> px-2 py-1 "></i> ' + $('.contInputDiv input[name="bill_email"]').val());
			$('.card-holder div').html($('.contInputDiv input[name="fullname"]').val());
			
			$('.checkOutOptions input[name="fullname"]').val($('.contInputDiv input[name="fullname"]').val());		
			
			$('.checkOutOptions input[name="bill_phone"]').val($('.contInputDiv input[name="bill_phone"]').val());
			
			$('.checkOutOptions input[name="bill_email"]').val($('.contInputDiv input[name="bill_email"]').val());

			if(billerAddressEmpaty == 'Y') {
				$('.checkOutOptions input[name="bill_address"]').val($('.contInputDiv input[name="bill_address"]').val());
				$('.checkOutOptions input[name="bill_city"]').val($('.contInputDiv input[name="bill_city"]').val());
				$('.checkOutOptions input[name="bill_state"]').val($('.contInputDiv input[name="bill_state"]').val());
				$('.checkOutOptions input[name="bill_zip"]').val($('.contInputDiv input[name="bill_zip"]').val());
				$('.checkOutOptions input[name="bill_country"]').val($('.contInputDiv input[name="bill_country"]').val());
			}
			
			var product= $('.bill_amtInputDiv input[name="product"]').val();
			if(typeof(product) != 'undefined' && product != null && product !='')
			{
				$('.checkOutOptions input[name="product"]').val(product);
			}

			var bill_amt= $('.bill_amtInputDiv input[name="bill_amt"]').val();
			if(typeof(bill_amt) != 'undefined' && bill_amt != null && bill_amt !='')
			{
				$('.checkOutOptions input[name="bill_amt"]').val(bill_amt);
			}
			
			if($(".account_types").length == 1){
				setTimeout(function(){ 
					$(".account_types").eq(0).trigger("click");
				}, 10); 
			}

			allow_block_country_f();
		}
	});

	$('#paymentMethodChange').click(function(){
	       // alert("11111111");
			$('.contInputDiv').hide(200);
			$('.paymentMethodDiv').show(800);
			$('.chkname').show(200);
			$('.checkOutOptions').hide(100);
			
			$('.paymentMethodh4').html('CARDS, UPI & MORE');
			$('#paymentMethodChange').hide(50);
			$('.back_action').show();
			$('.heading2_ind').show();
			$('.paymentMethodDiv').removeClass("label_active");

			//$('.account_types').removeClass('active');
			//$('.cname label').removeClass('active');
			
			$('#modalpopup_processing').hide(10);
			$('#modalpopup_processing_for_pending').hide(10);
			 /*== clear all time Interval ==*/
			//clearIntervalf();

			heightCalcf_2();
			
	});

	//1
	$('#bill_amtSubmit').click(function(){
		
		var inputPurpose = $('.inputPurpose').val(); 
		var pric = $('.bill_amt90').val();	
		
		if(inputPurpose == '') {
			alert("Purpose of Payment can not Blank! Please enter the Purpose");
			$('.inputPurpose').focus();
			return false;
		}else if(pric == '') {
			alert("Amount can not Blank! Please enter the Amount");
			$('.bill_amt90').focus();
			return false;
		}else {
		
			if($('#bill_amtInputDiv').hasClass('activeInput')){
				$('#bill_amtInputDiv').removeClass('activeInput');
				$('#bill_amtChange').hide(200);
				
				$('.nextSt').hide(200);
				$('.sIn').show(800);
			} else {
					var amt_g=$('.bill_amt90').val();
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
		
					var crn=$('.bill_amt #t_amt').html();
					if(crn){
						crNm=crn;
					}
				
				$('.checkOutOptions input[name="bill_amt"]').val(pric);
				
				$('#bill_amtInputDiv').addClass('activeInput');
				$('#bill_amtChange').show(700);
				
				$('.txtPurpose').html($('.inputPurpose').val());
				$('.txtAmount').html('<span class="currSymbl">'+crNm+'</span> <span class="nPayb">'+amt_g+'</span>.'+amt_l);
				$('.nPay').html('<span class="currSymbl">'+crNm+'</span> <span class="nPayb">'+amt_g+'</span>.'+amt_l);
				$('.submit_div .contitxt').html("<span style='' class='loader-btn 11'>Pay </span> "+' <span class="currSymbl">'+crNm+'</span> <span class="nPayb">'+amt_g+'</span>.'+amt_l);

				$('.sIn').hide(); 
				$('.nextSt').show();
				var fullName = $('.contInputDiv input[name="fullname"]').val(); 
		        var phone = $('.contInputDiv input[name="bill_phone"]').val();
		        var email = $('.contInputDiv input[name="bill_email"]').val();
				
				
				
				if((fullName=="")||(phone=="")||(email=="") ){ 
				
				}else{ 
				$('#contSubmit').trigger("click");
				}
				
				
			

				
				
			}
		}
	});
	
	
	
				
		<? if(!isset($post['pricManual'])){?> 
			//$('#bill_amtSubmit').trigger("click");
			//$('#contSubmit').trigger("click");
			
			var amt_g="<?=@$post['bill_amt'];?>";
			var amt_l='';
			if (amt_g.indexOf('.') <= 0) {
				amt_g="<?=@$post['bill_amt'];?>"+".00";
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
			var crn=$('.bill_amtSys #t_amt').html();
			if(crn){
				crNm=crn;
			}

			$('.nPay').html('<span class="currSymbl">'+crNm+'</span> <span class="nPayb">'+amt_g+'</span>.'+amt_l);
		 	$('.txtAmount').html('<span class="currSymbl">'+crNm+'</span> <span class="nPayb">'+amt_g+'</span>.'+amt_l);
			$('.submit_div .contitxt').html("<span style='' class='loader-btn'>Pay </span>");

			$('.errorDivId').hide(200);
			$('.nextSt').show(100);
			
			if(billerEmpaty=='ok'){
				$('.contInputDiv').show(200);
				$('.paymentMethodDiv').hide(200);
			}else{	
				$('.contInputDiv').hide(200);
				$('.paymentMethodDiv').show(800);
			}
			
			$('.chkname').show(800);
			$('.checkOutOptions').hide(100);
			$('.contInfoBar').show(100);
			
		<? } ?>		



	//-------------------------------------------
	
	
	
	if(billerEmpaty==''){
		$('#bill_amtSubmit').trigger("click");
	}

	if($(".account_types").length == 1 && billerEmpaty==''){
		//$(".account_types").length;
		setTimeout(function(){ 
			$(".account_types").eq(0).trigger("click");
		}, 100); 
		
		//alert($(".account_types").length);
	}
	
	
	
	
});


</script>


<?
	//Dev Tech : 23-07-25 start include for common script for qr,intent,collect,wallets,netbanking and common function  ----  

	$payin_processing_engine_common_script=$data['Path']."/front_ui/default/common/payin_processing_engine_common_script".$data['iex'];
	 
	if(file_exists($payin_processing_engine_common_script)){
		include($payin_processing_engine_common_script);
	}
?>
 
 

<div class="container clients_pro">
<? if((isset($_SESSION['login']))&&(isset($post['action'])&&$post['action']=="vt")){?>
  <? $c_style="style='float:none;'"; ?>
  <ul class="breadcrumb" style="text-align:left;">
	<li><a href="<?=@$data['USER_FOLDER'].'/index'.$data['ex'];?>" class="glyphicons home"><i></i>
	  <?=prntext(@$data['SiteName'])?>
	  </a></li>
	<li class="divider"></li>
	<li>Moto</li>
  </ul>
  <? } ?>
	

 


 
<script language="javascript" type="text/javascript"> 
var keyInput = $('.key_input');

	function conc(){
		/*var str = "";
		$('.key_input').each(function(){
			str += $(this).val();
		});
		str = str.replace(/\s/g, '');
		$("#number").val(str);*/
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
	
	<? if(isset($post['acquirer'])&&trim($post['acquirer'])&&$post['acquirer']>0){?>
		$(".account_types[value='<?=@$post['acquirer']?>']").trigger("click"); 
	<? } ?>
	
});	

</script>

<style>
.inputgroup .text-muted {word-wrap:break-word;white-space:initial;max-width:98%;display:inline-block;}
.heading2_ind {font-size:10px;font-weight:400;display:inline-block;clear:both;width:100%;padding-left:43px;float:left;}

.img5 img{max-height:5px;}
.img10 img{max-height:10px;}
.img15 img{max-height:15px;}
.img20 img{max-height:20px;}
.img30 img{max-height:30px;}
.img35 img{max-height:35px;}
.blur_layer {position:absolute; z-index:99; width:100%;height:100%;backdrop-filter: blur(1px);}
				
.or_1 {height:3px;background:#020024;background:linear-gradient(90deg,rgba(2,0,36,1) 0%,rgba(218,0,203,1) 0%,rgba(204,204,204,1) 0%,rgba(255,255,255,1) 0%,rgba(255,255,255,1) 25%,rgba(197,196,198,1) 50%,rgba(255,255,255,1) 75%,rgba(255,255,255,1) 100%);}

.modalpopup_processing .modalpopup_form_popup_layer {background:var(--background-1)!important;display:block;position:fixed;z-index:9;width:100%;min-height:250px;opacity:0.4!important;top:-250px;left:0;margin:0;float:left;}

.modalpopup_processing  .modalpopup_form_popup_body{display:block;position:absolute;z-index:9999999;left:0;top:-200px;min-width:375px;height:400px;margin:0 auto;opacity:1;border-radius:5px;color:#333;text-align:center;    overflow:unset;}

.mx_button_row {margin:0 -3px;}
.mx_button_1{border: 0;border-top: 1px solid var(--color-4);border-right: 1px solid var(--color-4);width:49%;border-radius:0;padding:10px 0;font-size:16px !important;}		
.mx_button_2{border: 0;border-top: 1px solid var(--color-4);width:49%;border-radius:0;margin:0;margin-left:-3px;padding:10px 0;font-size:16px !important;}	

.walletsDiv.desImg ,.appLogoDiv2.desImg {height:36px;cursor:pointer !important;}
.walletsDiv img, .appLogoDiv img{height:30px!important;width:auto!important;display:block!important;margin:7px auto!important;line-height:50px;vertical-align:middle}

.banksDiv.active, .walletsDiv.active , .appLogoDiv2.active {background:#1c511c;color:#fff;}
.banksDiv, .walletsDiv, .appLogoDiv2, .upisDiv {display:table-cell;vertical-align:middle; text-align:center;width:48%;height:36px;line-height:50px;border:1px solid #ccc;border-radius:3px;float:left;margin:2px;cursor:pointer;}
	
.banksDiv:nth-child(2n), .walletsDiv:nth-child(2n), .appLogoDiv2:nth-child(2n), .upisDiv:nth-child(2n) {
   margin: 2px 4px 2px 0px; 
}
	
.banksDiv:nth-child(1n), .walletsDiv:nth-child(1n), .appLogoDiv2:nth-child(1n), .upisDiv:nth-child(1n) {
  margin: 2px 0px 2px 4px;
}


/*html .upi_qr_row.active .upi_qr_text {margin-top:1rem!important;}*/

 body { background:#ffffff !important; }
.row {--bs-gutter-x: 0rem !important; }
    
 p { margin-top: 2px !important; margin-bottom: 2px !important; }
.logo-img { max-height: 55px; vertical-align:middle;}
.icon-position {position: absolute;margin-top: 0px;margin-left: -5px;}
.back_action { width:20px;margin-top: 5px; margin-left: 5px; }
.heading2_ind {font-size: 10px;font-weight: 400;}
.toast:not(.showing):not(.show) { opacity: unset !important;}
.toast {width: 100%;}
.b-example-divider {height: 2rem !important; background-color: #2a82d7 !important;color: #ffffff !important;border-width:unset !important;}
.bank_img { height: 24px; margin-bottom: 3px;margin-top: 10px;}
.qr_img { filter: blur(5px); margin: 15px;}
.upi_qr_img { /*filter: blur(2px);*/ height:125px;}
.upi_qr_border {

  background:
    linear-gradient(to right, #2a82d7 2px, transparent 2px) 0 0,
    linear-gradient(to right, #2a82d7 2px, transparent 2px) 0 100%,
    linear-gradient(to left, #2a82d7 2px, transparent 2px) 100% 0,
    linear-gradient(to left, #2a82d7 2px, transparent 2px) 100% 100%,
    linear-gradient(to bottom, #2a82d7 2px, transparent 2px) 0 0,
    linear-gradient(to bottom, #2a82d7 2px, transparent 2px) 100% 0,
    linear-gradient(to top, #2a82d7 2px, transparent 2px) 0 100%,
    linear-gradient(to top, #2a82d7 2px, transparent 2px) 100% 100%;

  background-repeat: no-repeat;
  background-size: 20px 20px;
  height:150px;
  
  }

.wallet_img { height: 30px;}
.desImg{ height: 86px; cursor:pointer !important; line-height:82%; }
.unset .desImg{ height: unset !important;}
.desImg.active{background-color: #c7d7e7 !important; border-bottom: 2px solid #2a82d7 !important;} 

.walletLogo_div .desImg.active{background-color: #eeea82 !important; border-bottom: 2px solid #2a82d7 !important;}

.input-field.select label{top:-10px !important;font-size: 10px!important;} 
.input-field select:focus+label, .input-field select:valid+label { position: absolute;top: -10px;left: 6px;font-size: 10px;padding: 0px 2px;/*background-color: var(--bs-body-bg) !important;color: var(--bs-body-color) !important;*/ }
.fa-xl { line-height: unset !important; vertical-align:unset !important;margin-top: -3px }
.icon-toggle::after { font-family: "Font Awesome 6 Free"; font-weight: 900; content: "\f0d7"; padding: 2px;}
.modal_msg_close { position: unset; 
     z-index: unset;  
     right: unset;
     top: unset;
     width: unset;
     height: unset;
     color: #000000 !important;
     background: unset;
     text-align: unset;
     border-radius: unset; 
     overflow: unset;
     cursor: unset;
	}
	
.modal_msg_body {width: 300px;height: auto !important;/*margin: -100px 0 0 -150px !important;*/}

div.image_text_center {
    position: relative }
div.image_text_center p {
    margin: 0;
    position: absolute;
    top: 45%;
    left: 50%;
    margin-right: -50%;
    transform: translate(-50%, -50%) }


	.btn-slide {
    color: #fff;
    border: 3px solid <?=@$btn_clrs?>;
    background-image: linear-gradient(30deg, <?=@$btn_clrs?> 50%, transparent 50%);
    background-size: 350px;
    background-repeat: no-repeat;
    background-position: 0%;
    -webkit-transition: background 300ms ease-in-out;
    transition: background 300ms ease-in-out;
    }
    .btn-slide:hover {
    background-position: 100%;
    color: <?=@$btn_clrs?>;
	}

/*////For change header and button color//////////*/

.inputWithIcon { position: relative; }
.inputWithIcon i { position: absolute;right: 5px;top: 4px;color: #aaa;transition: 0.3s;font-size: 26px;}
.iconrupay{background:#fff url(images/rupaycard.jpg) 99% 3px no-repeat;background-size:8%; float:left; }  
.form-label { font-weight: unset !important;} 
.form-check { min-height:unset !important;}
.accordion-button { background-color: #ffffff !important; color: #000000 !important;padding: 0px 10px !important; font-size:unset !important;}
.accordion-body{ padding: 0px 10px !important;}
.accordion-button:not(.collapsed) { background-color: #ffffff !important;color: #000000 !important; }
    

.payment-form .form-row{display:inline-block;width:100%}
.gpay-main .static-menu input.menu-input-onesuffix{border:none;background:none;font-size:15px;padding-top:5.5px}
.static-menu .upi-inp{width:50%}
.static-menu{border:1px #ccc solid;-webkit-border-radius:4px;-moz-border-radius:4px;border-radius:4px;background:#fff;height:36px;padding:6px 10px;position:relative;transition:all 400ms ease-in-out;width:100%;font-family:'Avenir-Book'}
.gpay-main .static-menu input.menu-input{border:none;background:none;font-size:14px;padding-top:4px}
*{outline:0}
#upi2IdRow .sbm-option ul{list-style:none}
.static-menu .sbm-option{position:absolute;top:36px;left:-1px;width:100%;border-top:none;border-bottom:none;z-index:1;background:#fff;border:1px #ccc solid;-webkit-border-bottom-right-radius:4px;-webkit-border-bottom-left-radius:4px;-moz-border-radius-bottomright:4px;-moz-border-radius-bottomleft:4px;border-bottom-right-radius:4px;border-bottom-left-radius:4px;box-sizing:content-box}
#upi2IdRow .static-menu input.menu-input{border:none;background:none;font-size:14px;padding-top:4px}
#upi2IdRow ul li{font-size:16px;font-family:'Avenir-Medium';line-height:normal;vertical-align:top;margin:0;padding:10px 13px;border:none;border-bottom:solid 1px #ccc;font-size:14px;transition:none}
#upi2IdRow ol,ul{padding-left:0!important}
#upi-data-list input{border:0;background:none!important}
#upi2IdRow ul li input:hover{background:var(--background-1)!important}
dl,ol,ul{margin-bottom:0!important}
#upi2IdRow INPUT{width:50%!important;min-width:50%!important;max-width:50%!important;border:unset!important}

#credit_cards img {height:30px;}

.modalMsgContTxt {padding:10px 20px; text-align:center;}
.processall .modalMsgContTxt h4{margin: 10px 0px;}
.universalWisePay {display:block;}
.universalWisePay.hide1 {display:none;}
#cardsend_submit i, .suButton i {display:none;}
#cardsend_submit .fa-spin-pulse {display:block !important;}	
body{top:0!important}


/*.oops2{margin:0;padding:0;overflow:auto;width:100%;height:100%;
	background: url("<?php echo $data['Host'];?>/images/criss-cross.png");
	border-color: #d6e9c6;
}*/



.clients.processall #credit_cards img {width:12.6%;}
.credit-card-box .strip {background:linear-gradient(135deg, #404040, #1a1a1a);position:absolute;width:100%;height:50px;top:30px;left:0;}
.credit-card-box .number {position:absolute;margin:0 auto;top:82px;left:19px;font-size:38px;}
.credit-card-box .card-holder,
.credit-card-box .card-expiration-date {position:absolute;margin:0 auto;top:164px;left:13px;font-size:16px;text-transform:capitalize;}
.the-most {position:fixed;z-index:1;bottom:0;left:0;width:50vw;max-width:200px;padding:10px;}
.the-most img {max-width:100%;}
.merchant_logo {position: relative;top:-42px;margin-bottom:-25px;text-align: center;}
.merchant_logo img {height: 70px;}
.submit_div {border-radius: 0.25rem!important;border: 1px solid #dee2e6!important;}
    
    

body, .container-fluid.fixed {border:0px solid #dddddd;}
.totalHolder {position:relative;display:table-cell;width: 240px;background: <?=@$_SESSION['background_g']?>;color:<?=@$_SESSION['color_g'];?>;text-align: left;margin: 0 10px 0 0;line-height:250%;}
.title_2 {color:#fff !important;}
.totalHolder .b {text-align: left;color: <?=@$_SESSION['background_gl7'];?>;margin: 10px 0 0 0;}
.totalHolder .txts {font-size: 20px;padding: 0 0 8px 0;margin: 0 0 7px 0;}
.totalHolder .txts.pro {max-height:100px;overflow:hidden;}
.dark1 {position:absolute;bottom:0;background: <?=@$_SESSION['background_gd7'];?>;color: #fff;text-align: right;float: left;width: 100%;height: inherit;line-height: 230%;}
.amount_total {/*font-size: 40px !important;*/}
.pad10 {padding:10px;}
.fs10 {font-size:10px !important;}
.ti, .capl {font-weight: normal !important;color: #023b80 !important;font-size: 24px;}

.result_view {font-family: Verdana,Tahoma,Trebuchet MS,Arial;font-size: 11px;}

.processall TD.field {padding: 8px;color: #444444;background-color: #F2F4F7;text-align: right;vertical-align: top;font-weight: bolder;}
.processall TD.input {line-height: 22px;background-color: #F2F4F7;vertical-align: top;padding: 4px;}
.processall TD.capl {background: url(<?=@$data['Host'];?>/css/customisation/images/bg-headers.png) repeat scroll -50px center transparent;padding: 9px 0px;color: #fff;font-weight: normal;-webkit-border-top-left-radius: 3px;-webkit-border-top-right-radius: 3px;-moz-border-radius-topleft: 3px;-moz-border-radius-topright: 3px;border-top-left-radius: 3px;border-top-right-radius: 3px;font-size: 14px !important;}

/*.showfp{display:none;}*/
.err_tr {padding:0 !important;margin:0 !important;}
.hide{display:none;}
.ctittle {float: left;padding-right: 10px;}
.cname label {font-size:12px;width:100%;white-space:nowrap;display:inline-block;padding:5px;}
.account_types.active {color:orange !important;}
input.account_types {padding: 0;margin:0 5px 0 0;float:left;position:relative;height:18px;line-height:30px;min-width:30px;;background:transparent !important;border: 0px solid #CECECE;-moz-box-shadow: 0 0px 0px #E5E5E5 inset;-webkit-box-shadow: 0 0px 0px #E5E5E5 inset;box-shadow: 0 0 0px 0px #E5E5E5 inset;padding: 0;}
.clients_pro input.account_types{top:2px;background:transparent;} 
.payment_option img {height: 15px !important;margin-top: 3px !important;}
.upi_qr img {height: 25px !important;}
.echeck_div, .pay_div {display:none;clear:both;float:left;width:100%;background:#fff;}
.pay_div .separator {margin: 0px 0 !important;float: left;width: 100%;height: 6px;}
#form-input-errors {display:none; float:left; width:100%; text-align:center; color:red; font-size:12px; margin:10px 0 0 0;}
.transparent {opacity: 0.2;}
.has-error {background:#ff0000;border:1px solid #ff0000;}
.maindiv{  display:block; margin:auto; background:#eeeeee;min-height:250px;}
.leftdiv{width:46%;float:left;  height:100%; margin-left:5px;}
.rightdiv{width:46%;float:left;  height:100%}

.p{padding-left: 20px; color:black;}
#credit_cards #jcb1{height:80px;position:relative;top:-17px;margin:0 0 -32px 0;}
.align{ margin-top:132px;}
.p0 {padding: 0;}
.ecol4{width:44%;float:left;padding-left:9px;padding-top:5px;padding-bottom:5px;padding-right:10px; }


#expMonth option[disabled] {color: #ffffff;background-color: #2a82d7;}
#expYear option[disabled] {color: #ffffff;background-color: #2a82d7;}
	    



<? if(isset($data['re_post'])&&$data['re_post']){?>
.merchant_logo {position: relative;top:-10px;margin-bottom:-5px;text-align: center;}
<? } ?>

.translateDiv{display:none;clear:both;width:105px;position:absolute;	z-index:99;float:right;margin:0 0px 10px 210px;background: url("<?php echo $data['Host'];?>/images/lang_4.png") <?=@$_SESSION['background_g']?> no-repeat; background-size:18px; background-position:left;}

#google_translate_element {
    width: 18px;
    overflow: hidden;
    margin-top: -16px;
    margin-left: 2px;
    height: 11px;
}
    
.goog-te-gadget-icon {
    /*background-image: url("<?php echo $data['Host'];?>/images/language-translator-ind.png")!important;*/
    /*background-position: 0px 0px;*/
    height: 0px!important;
    /*width: 32px!important;*/
    margin-right: 8px!important;
    //     OR
    display: none;
}

.goog-te-gadget-simple  {
  background-color: rgba(255,255,255,0.20)!important;
  border: 1px solid rgba(255,255,255,0.50) !important;
  /*padding: 8px!important;
  border-radius: 4px!important;
  font-size: 1rem!important;
  line-height:2rem!important;
  display: inline-block;
  cursor: pointer;
  zoom: 1;*/
}

#google_translate_element select {content: ''; border:0 !important; -webkit-appearance: menulist;-moz-appearance:menulist;padding: 0px 0px;font-weight:bold;color:#d07c00 !important;background: <?=@$_SESSION['background_g']?>;color:<?=@$_SESSION['color_g'];?> !important;margin:0 0 0 0px;}
#google_translate_element select:focus {outline: unset !important;}
.skiptranslate iframe {display:none !important;}
.skiptranslate iframe { background:#CC0000 !important;}
.input_key_div{display:block;width:100%;clear:both;padding:7px 0}
.credit-card-box .number{left:5px;top:78px}
.number .key_input{width:17px !important;min-width:17px;height:38px;outline:none !important;padding:0 0px;text-align:center;font-size:24px;letter-spacing:normal;font-weight:bold;border-radius:5px !important;border:1px solid #9d9d9d;display:inline-block;float:left;position:relative;z-index:9999;margin:0px 0px}
.number .key_input.bri{background:#dddddd;}
.number .key_input.lgt {margin:0 0px 0 0 !important;}
.number .key_input.rgt {margin:0 0 0 8px !important;}

.language-adj{width:20px !important;}
@media (max-width:1049px){
	.ctittle {width:60px;white-space:nowrap;padding-right: 0px;}
	 div.processall {width:100% !important;float:none;margin:-10px auto 30px auto;}
	.totalHolder {display:block;width:100%;margin:0 10px 0 0;height:inherit;}
	.totalHolder .txts.pro {max-height:inherit;}
	.dark1 {position:relative;}
	.clients.processall #credit_cards img { width: 23.6% !important; }
	.merchant_logo{position:relative;top:21px;margin-bottom:14px;text-align:center;}
	.totalHolder .b {margin: 0;width:auto;float:left;}
	.totalHolder .txts {font-size: 20px;padding: 0 0 0px 0;margin: 0;}
	.title_2 {display:none;}
	.totalHolder .txts{text-align: left;}
	.totalHolder .b {text-align: right;width: 32%;padding: 0 10px 0 0;}
	.bAdd {float:left;font-size:12px !important;font-weight:bold !important;} 
	.translateDiv{top:0;margin:20px 0 0 0;}
}

@media (max-width:500px){ 
	.language-adj{ margin-top:2px !important; }
	.mt2px{ margin-top:5px !important; }
}

@media (max-width:450px){ 
	.ecol4{width:100%;padding:0;}
}
@media (min-width: 200px){
    .col-sm-4 {
    flex: 0 0 auto !important;
    width: 33.33333333% !important;
	}
	.col-sm-6 {
    flex: 0 0 auto !important;
    width: 50% !important;
    }
}
</style>
<style>
	.merchantLogo {position: relative;text-align: center;}
	.merchantLogo img {height: 70px;}
	.company_name {font-weight:bold;font-size:26px;text-align: center;color:<?=@$_SESSION['color_g'];?>;float:left;height:inherit;width:100%;line-height:30px;padding:5px 0 10px 0;}

	.payingTo {font-size:14px;font-weight:normal;position:absolute;color:#959595;text-transform:uppercase;margin:5px;}
	
	.step_1 label {display:none;}
	.capc {background: transparent !important;}
	
	

	<? if(isset($data['con_name'])&&$data['con_name']=='clk'){?>
		.checkOutOptions {display:none;}
		
	<? } ?>
	
	
/*.cname .inputgroup {float:left;width:100%;}*/
.inputgroup .inputype:hover, .appLogoDiv:hover{ background:#f2f4f9;}
.paymentMethodDiv input.account_types {display:none;}
.payOpt{float:left;width:94%;}
	
.contInputDiv .la12 {margin:6px 0 3px 6px; display:none;}
.activeInput .labelAmount {margin:20px 0 0 0;}
.txIn {float:left;width:94%;font-size:18px;font-weight:bold;text-align:left;padding:0 0 0 2%;}
.la12 {float:left;width:100%;text-align:left;font-size:15px;margin:16px 0 3px 6px;cursor:none;}
.amount_total.bill_amt {/*float:left;width:12%;background:#dedfe0;height:36px;overflow:hidden;border-radius:3px 0 0 3px;font-size:28px !important;*/}

.amount_total.bill_amt #t_amt {/*position:relative;top:-1px;*/}

.upisDiv img {height:30px;display:inline-block;line-height:50px;vertical-align:middle;width:auto;margin:11px auto 0 auto;}
.upisDiv.active {background:#fff;color:#000; border:1px solid <?=@$_SESSION['background_gd5'];?>; }
.banksDiv.active, .appLogoDiv.active {background:<?=@$_SESSION['background_gd5'];?>;color:#fff;}
.appLogoDiv.active .form-check-input {
									   appearance: none;
                                       -webkit-appearance: none;
                                       border-radius: 50%;
                                       background: var(--link-color-template);
                                       border: 3px solid #FFF;
                                       box-shadow: 0 0 0 1px var(--link-color-template);
	                                  }
	
	
	
.banks_bank_1, .banks_sprite {background-image:url(<?=@$data['Host']?>/images/banks-sprite.png);width:32px;display:inline-block;line-height:50px;position:relative;top:-2px;}
.banks_bank_1 {background-position:0 -42px;height:31px;}
.banks_bank_2 {background-position:-32px 0;height:38px;}
.banks_bank_3 {background-position:-64px 0;height:33px;}
.banks_bank_4 {background-position:-96px -29px;height:29px;}
.banks_bank_5 {background-position:0 -73px;height:28px;}
.banks_bank_6 {background-position:-64px -42px;height:31px;}
.banks_bank_7 {background-image:url(<?=@$data['Host']?>/images/idfc_bank_logo.png);background-position:0;height:29px;background-size:30px;background-repeat:no-repeat;}

</style>


 
  <div class="processall border rounded rounded-tringle position-absolute top-50 start-50 translate-middle sticky-sm-top " style="max-width:375px;margin:0 auto;width:100% !important;">
	<div class="content_top " >
		<? if(isset($_SESSION['re_post']['failed_reason'])){
		$c_style2='style="display:none;"'; 
		//$_SESSION['re_post']['failed_reason']='Do Not Honor Payment Failed.';
		unset($_SESSION['re_post']['failed_reason']);
	?>
		<div class="col-sm-12 text-center py-2 alertPaymentDiv"> 
		  <div class="show my-2 fs-5" role="alert">Payment Failed</div>
           
		   
		  <div class="col-sm-12 text-center px-2 my-3"> 
		  <i class="<?=@$data['fwicon']['circle-info'];?> fa-6x text-danger"></i>
          </div> 
          <div class="timerText text-center my-3" >Payment Complete before the end of minutes  <br />
<span id="timer1" class="timer text-center" style="">05:00</span></div>
          <a class="nopopup tryAgain btn btn-primary my-2" ><i class="<?=@$data['fwicon']['check-circle'];?>"></i> Try Again</a> 
		  <a title="<? if(isset($_SESSION['http_referer'])) echo $_SESSION['http_referer'];?>" class="nopopup merchantPage btn btn-primary my-2" ><i class="<?=@$data['fwicon']['back'];?>"></i> Go Back </a> 
		  
		  </div>
		  
		  <script>
			if(opener.transID != ''){window.close();}
		  </script>
		   
		<? } ?>
		
		<div id="nextOptionDivId" class="border_con" <?=isset($c_style2)?$c_style2:'';?> >
		
		<?
			if(isset($_SESSION['action'])&&$_SESSION['action']=="vt"){
				$heading_1="Virtual Terminal";
			}else{
				$heading_1="Billing Information";
			}

		if((isset($post['step'])&&$post['step']==2)||(isset($data['con_name'])&&$data['con_name']=='clk')){
		
		?>
		<? if(isset($data['con_name'])&&$data['con_name']=='clk'){
		?>
		
		<div class="slidePaymentDiv99 row border rounded payment-header" >
		<div class="row">
		
		<? if(isset($_SESSION['merchant_logo_url'])&&$_SESSION['merchant_logo_url']){ ?>
			<div class="col rounded image_text_center" style="max-width:85px;" >
			<p class="p-1"><img src="<?=(@$_SESSION['merchant_logo_url']);?>" class="img-thumbnail " alt="Logo"/></p>
			</div>
        <? }else if(isset($_SESSION['dba_brand_name'])&&@$_SESSION['dba_brand_name']){ ?>
		    <div class="col border border-2 m-2 rounded image_text_center fw-bold" style="max-width:55px;" >
			<p><?=prntext(substr(@$_SESSION['dba_brand_name'],0,1))?></p>
			</div>
		<? }else{ ?>
		    <div class="col border border-2 m-2 rounded image_text_center  fw-bold" style="max-width:55px;" >
			<p><?=prntext(substr(@$_SESSION['ter_name'],0,1))?></p>
			</div>
		<? }?>
		
		
		
		
		
		<div class="col p-1">
		<div>
		<div class="fw-bold fs-6 font-monospace clrs float-start ps-1" style=" width: calc(100% - 26px);">Paying to <?=prntext(@$_SESSION['ter_name'])?> 
		</div>

<!-- start : google translate -->

		<div class="float-start text-end language-adj"><i class="<?=@$data['fwicon']['language'];?> language-collapse" title=" language" style="font-size:15px;" ></i><div id="google_translate_element"></div>
		
	<?php /*?>Supporting Files for Language Translator	
	<script language="javascript" type="text/javascript"> 
	function googleTranslateElementInit() {
	//new google.translate.TranslateElement({pageLanguage: 'en', includedLanguages: 'en,bn,gu,hi,kn,mr,ta,te,', layout: google.translate.TranslateElement.InlineLayout.SIMPLE}, 'google_translate_element');

	new google.translate.TranslateElement({pageLanguage: 'en', layout: google.translate.TranslateElement.InlineLayout.SIMPLE}, 'google_translate_element');

	
	}
	</script>
	<script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
<?php */?>

<script type="text/javascript">
    function googleTranslateElementInit() {
        /*
Get the current browser language.
*/
var langBrowser = navigator.language || navigator.userLanguage;

/* If the language contains a region code, get only the 2-character lang code. For example en-US -> en. */
var currentBLang = langBrowser.split('-')[0];

      new google.translate.TranslateElement({
        pageLanguage: 'en',
      }, 'google_translate_element');
      if (currentBLang != "en"){
      setTimeout(function() {
        // Set the default language to Spanish
        var selectElement = document.querySelector('#google_translate_element select');
        selectElement.value = currentBLang;
        selectElement.dispatchEvent(new Event('change'));
      }, 1000);
    }
    }
  </script>

<script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>

<!-- end : google translate -->


	<?php /*?>End Supporting Files for Language Translator	<?php */?>	
		</div>
		</div>
		<div class="fw-bold fs-6 font-monospace ps-1 clearfix nPay"><span class="w-50"><?=get_currency($post['curr']?$post['curr']:$_SESSION['curr']);?><?=(@$post['total']?$post['total']:$post['bill_amt'])?></span> <span class="w-50 float-end text-end"><? if(isset($_SESSION['re_post']['return_failed_url'])&&$_SESSION['re_post']['return_failed_url']){?>
			<div class="timerText2 text-end" ><span id="timer2" class="timer" style="222">05:00</span></div>
			<? } ?></span></div>
		</div>
		</div>
		
			<div class="payingMdiv99 ">
			<? if(isset($_SESSION['mem']['user_type'])&&$_SESSION['mem']['user_type']==1){
			   $_SESSION['info_data']['company_name']=$_SESSION['mem']['fname'].' '.$_SESSION['mem']['lname'];	
			} ?>
		
			</div>
		</div>
		<? if(isset($post['chooseStore'])&&$post['chooseStore']){?>
		<div class="ecol2 m-2 input-field select my-3" style="min-height: 200px;">
		 	
			<select name="storeType" id="storeType" class="form-select form-select-lg" >
			<option value="" selected="selected">Choose Business Type</option>
			<? foreach($post['allStore'] as $key=>$val){ ?>
			<option data-title="<?=@$val['id']?>" value="<?=@$val['public_key']?>" >
			<?=@$val['bussiness_url']?>
			<? if(isset($data['localhosts'])&&$data['localhosts']==true){?>
			|
			<?=@$val['name']?>
			:
			<?=@$val['public_key']?>
			<? } ?>
			</option>
			<? } ?>
			</select>
			<label for="storeType">Select a website type</label>
			
		
		<? }
	else{?>
		<div class="ecol2 bill_amtInputDiv px-2">
		<?
			if(isset($data['Error'])&&$data['Error']){
				$display_style="style='display:block;'";
			}else {
				$display_style="style='display:none;'";
			}
			
	
			if(isset($_POST['product'])){
				$post['product']=$_POST['product'];
			}
		?>
		<div class="hide error errorDivId" id="form-input-errors" <?=@$display_style;?>>
			<?//=prntext(@$data['Error'])?>
		</div>
		
		  <? if(isset($post['pricManual'])&&$post['pricManual']){?>
		  <div class="sIn">
			<input type="text" name="product" placeholder='Purpose of Payment!' class="inputPurpose form-control my-2" value="<?=(@$_SESSION['product']?$_SESSION['product']:'Payment For')?>">
		  </div>
		  
		  <? } ?>
		  
		  
		  <? if(isset($post['pricManual'])&&$post['pricManual']){?>
		  <div class="sIn">
			<?php /*?><div class="amount_total bill_amt"><font id="t_amt">₹</font></div>
			<input class="bill_amt90 form-control " type="text" name="bill_amt" placeholder='Bill Amount' value="<?=(@$post['bill_amt']=='0.00'?'1.00':$post['bill_amt']);?>" required/><?php */?>
			
			<div class="input-group mb-3">
  <span class="input-group-text" id="basic-addon1"><font id="t_amt"><?=(isset($_SESSION['curr_tr_sys'])?$_SESSION['curr_tr_sys']:'₹');?></font></span>
  <input type="text" class="bill_amt90 form-control" name="bill_amt" placeholder='Bill Amount' value="<?=(@$post['bill_amt']=='0.00'?'1.00':$post['bill_amt']);?>" required aria-label="Username" aria-describedby="basic-addon1">
</div>
		  </div>
		  <? } ?>
		  
		  <div class="bill_amtSys" style="display:none;"><font id="t_amt"></font></div>
		  <? if(isset($post['pricManual'])&&$post['pricManual']){?>
		  <button id="bill_amtSubmit" type="button" value="CHANGE NOW!"  class="submitbtn btn btn-primary w-100 mb-2  next sIn"><i></i><b class="contitxt loader-btn">Pay</b></button>
		  <? } ?>
		  
			 
		</div>
		<div class="nextSt contInputDiv mx-2 hide was-validated">


		  <!--<div class="brec">Your Details > Payment</div>-->
		<? if((isset($post['pricManual'])&&$post['pricManual'])||(@$billerEmpaty=='Y')){?>
		
		 <!-- <div class="separator" style="clear:both"></div>-->
		 
			<div class="input-field my-3">
				<input type="text" name="fullname"
					value="<?=(@$post['fullname']?prntext(@$post['fullname']):prntext(@$_SESSION['re_post']['fullname']));?>"
					id="input_fullname" title="Full Name" minlength="3" class="form-control is-invalid" required>
				<label for="input_fullname">Full Name</label>
			</div>
			<script>
				if (($('#input_fullname').val()) != "") {
					$("#input_fullname").removeClass('is-invalid').addClass('is-valid');
				}
			</script>

			<div class="input-field my-3">
				<input type="text" name="bill_phone"
					value="<?=(@$post['bill_phone']?prntext(@$post['bill_phone']):prntext(@$_SESSION['re_post']['bill_phone']));?>"
					id="input_mobile" title="Mobile Number" minlength="10" class="form-control is-invalid" required>
				<label for="input_mobile">Mobile Number</label>
			</div>
			<script>
				if (($('#input_mobile').val()) != "") {
					$("#input_mobile").removeClass('is-invalid').addClass('is-valid');
				}
			</script>

			<div class="input-field my-3">
				<input type="email" name="bill_email" size="30" maxlength="128"
					value="<?=(isset($post['bill_email'])&&$post['bill_email']?prntext(@$post['bill_email']):prntext(@$_SESSION['re_post']['bill_email']));?>"
					id="input_mail" title="Email Address" class="form-control is-invalid my-1" required>
				<label for="input_mail">Email Address</label>
			</div>
			<script>
				if (($('#input_mail').val()) != "") {
					$("#input_mail").removeClass('is-invalid').addClass('is-valid');
				}
			</script>

			<? 
			// Enable the Address 
			if((isset($data['CHECKOUT_OPAL_NS_ADDRESS_ENABLE'])&&@$data['CHECKOUT_OPAL_NS_ADDRESS_ENABLE']=='Y'))
			{
				?>
				<div class="input-field my-3">
					<input type="text" name="bill_address"
						value="<?=(@$post['bill_address']?prntext(@$post['bill_address']):prntext(@$_SESSION['re_post']['bill_address']));?>"
						id="input_bill_address" title="Bill Address" minlength="2" class="form-control is-invalid" required>
					<label for="input_bill_address">Bill Address </label>
				</div>
				<script>
					if (($('#input_bill_address').val()) != "") {
						$("#input_bill_address").removeClass('is-invalid').addClass('is-valid');
					}
				</script>

				<div class="input-field my-3">
					<input type="text" name="bill_city"
						value="<?=(@$post['bill_city']?prntext(@$post['bill_city']):prntext(@$_SESSION['re_post']['bill_city']));?>"
						id="input_bill_city" title="Bill City" minlength="2" class="form-control is-invalid" required>
					<label for="input_bill_city">Bill City</label>
				</div>
				<script>
					if (($('#input_bill_city').val()) != "") {
						$("#input_bill_city").removeClass('is-invalid').addClass('is-valid');
					}
				</script>


				<div class="input-field my-3">
					<?/*?>
						<select name="bill_country" minlength="2" class="form-select form-control is-invalid" id="country_list" autocomplete="false" title="Enter select country" data-bs-toggle="tooltip" data-bs-placement="bottom" required >
					<?*/?>
					<input type="text" name="bill_country"
						value="<?=(@$post['bill_country']?prntext(@$post['bill_country']):prntext(@$_SESSION['re_post']['bill_country']));?>"
						id="country_list" list="input_bill_country" title="Bill Country" minlength="2" class="form-control is-invalid" required>
						
					<label for="country_list">Bill Country</label>
					
					<datalist id="input_bill_country" >
							<option value="AND" data-val="AD_AND_020_Andorra">(AND) - Andorra</option>
                              <option value="ARE" data-val="AE_ARE_008_United Arab Emirates">(ARE) - United Arab Emirates</option>
                              <option value="AFG" data-val="AF_AFG_010_Afghanistan">(AFG) - Afghanistan</option>
                              <option value="ATG" data-val="AG_ATG_012_Antigua and Barbuda">(ATG) - Antigua and Barbuda</option>
                              <option value="AIA" data-val="AI_AIA_016_Anguilla">(AIA) - Anguilla</option>
                              <option value="ALB" data-val="AL_ALB_024_Albania">(ALB) - Albania</option>
                              <option value="ARM" data-val="AM_ARM_031_Armenia">(ARM) - Armenia</option>
                              <option value="ANT" data-val="AN_ANT_032_Netherlands Antilles">(ANT) - Netherlands Antilles</option>
                              <option value="AGO" data-val="AO_AGO_036_Angola">(AGO) - Angola</option>
                              <option value="ATA" data-val="AQ_ATA_040_Antarctica">(ATA) - Antarctica</option>
                              <option value="ARG" data-val="AR_ARG_044_Argentina">(ARG) - Argentina</option>
                              <option value="ASM" data-val="AS_ASM_048_American Samoa">(ASM) - American Samoa</option>
                              <option value="AUT" data-val="AT_AUT_050_Austria">(AUT) - Austria</option>
                              <option value="AUS" data-val="AU_AUS_051_Australia">(AUS) - Australia</option>
                              <option value="ABW" data-val="AW_ABW_052_Aruba">(ABW) - Aruba</option>
                              <option value="ALA" data-val="AX_ALA_056_ALA Aland Islands">(ALA) - ALA Aland Islands</option>
                              <option value="AZE" data-val="AZ_AZE_060_Azerbaijan">(AZE) - Azerbaijan</option>
                              <option value="BIH" data-val="BA_BIH_064_Bosnia and Herzegovina">(BIH) - Bosnia and Herzegovina</option>
                              <option value="BRB" data-val="BB_BRB_068_Barbados">(BRB) - Barbados</option>
                              <option value="BGD" data-val="BD_BGD_070_Bangladesh">(BGD) - Bangladesh</option>
                              <option value="BEL" data-val="BE_BEL_072_Belgium">(BEL) - Belgium</option>
                              <option value="BFA" data-val="BF_BFA_074_Burkina Faso">(BFA) - Burkina Faso</option>
                              <option value="BGR" data-val="BG_BGR_076_Bulgaria">(BGR) - Bulgaria</option>
                              <option value="BHR" data-val="BH_BHR_084_Bahrain">(BHR) - Bahrain</option>
                              <option value="BDI" data-val="BI_BDI_086_Burundi">(BDI) - Burundi</option>
                              <option value="BEN" data-val="BJ_BEN_090_Benin">(BEN) - Benin</option>
                              <option value="BLM" data-val="BL_BLM_092_Saint-Barthélemy">(BLM) - Saint-Barthélemy</option>
                              <option value="BMU" data-val="BM_BMU_096_Bermuda">(BMU) - Bermuda</option>
                              <option value="BRN" data-val="BN_BRN_100_Brunei Darussalam">(BRN) - Brunei Darussalam</option>
                              <option value="BOL" data-val="BO_BOL_104_Bolivia">(BOL) - Bolivia</option>
                              <option value="BRA" data-val="BR_BRA_108_Brazil">(BRA) - Brazil</option>
                              <option value="BHS" data-val="BS_BHS_112_Bahamas">(BHS) - Bahamas</option>
                              <option value="BTN" data-val="BT_BTN_116_Bhutan">(BTN) - Bhutan</option>
                              <option value="BVT" data-val="BV_BVT_120_Bouvet Island">(BVT) - Bouvet Island</option>
                              <option value="BWA" data-val="BW_BWA_124_Botswana">(BWA) - Botswana</option>
                              <option value="BLR" data-val="BY_BLR_132_Belarus">(BLR) - Belarus</option>
                              <option value="BLZ" data-val="BZ_BLZ_136_Belize">(BLZ) - Belize</option>
                              <option value="CAN" data-val="CA_CAN_140_Canada">(CAN) - Canada</option>
                              <option value="CCK" data-val="CC_CCK_144_Cocos (Keeling) Islands">(CCK) - Cocos (Keeling) Islands</option>
                              <option value="COD" data-val="CD_COD_148_Congo">(COD) -  (Kinshasa) Congo	 (Kinshasa)</option>
                              <option value="CAF" data-val="CF_CAF_152_Central African Republic">(CAF) - Central African Republic</option>
                              <option value="COG" data-val="CG_COG_156_Congo (Brazzaville)">(COG) - Congo (Brazzaville)</option>
                              <option value="CHE" data-val="CH_CHE_158_Switzerland">(CHE) - Switzerland</option>
                              <option value="CIV" data-val="CI_CIV_162_Côte d"Ivoire">(CIV) - Côte d"Ivoire</option>
                              <option value="COK" data-val="CK_COK_166_Cook Islands">(COK) - Cook Islands</option>
                              <option value="CHL" data-val="CL_CHL_170_Chile">(CHL) - Chile</option>
                              <option value="CMR" data-val="CM_CMR_174_Cameroon">(CMR) - Cameroon</option>
                              <option value="CHN" data-val="CN_CHN_175_China">(CHN) - China</option>
                              <option value="COL" data-val="CO_COL_178_Colombia">(COL) - Colombia</option>
                              <option value="CRI" data-val="CR_CRI_180_Costa Rica">(CRI) - Costa Rica</option>
                              <option value="CUB" data-val="CU_CUB_184_Cuba">(CUB) - Cuba</option>
                              <option value="CPV" data-val="CV_CPV_188_Cape Verde">(CPV) - Cape Verde</option>
                              <option value="CXR" data-val="CX_CXR_191_Christmas Island">(CXR) - Christmas Island</option>
                              <option value="CYP" data-val="CY_CYP_192_Cyprus">(CYP) - Cyprus</option>
                              <option value="CZE" data-val="CZ_CZE_196_Czech Republic">(CZE) - Czech Republic</option>
                              <option value="DEU" data-val="DE_DEU_203_Germany">(DEU) - Germany</option>
                              <option value="DJI" data-val="DJ_DJI_204_Djibouti">(DJI) - Djibouti</option>
                              <option value="DNK" data-val="DK_DNK_208_Denmark">(DNK) - Denmark</option>
                              <option value="DMA" data-val="DM_DMA_212_Dominica">(DMA) - Dominica</option>
                              <option value="DOM" data-val="DO_DOM_214_Dominican Republic">(DOM) - Dominican Republic</option>
                              <option value="DZA" data-val="DZ_DZA_218_Algeria">(DZA) - Algeria</option>
                              <option value="ECU" data-val="EC_ECU_222_Ecuador">(ECU) - Ecuador</option>
                              <option value="EST" data-val="EE_EST_226_Estonia">(EST) - Estonia</option>
                              <option value="EGY" data-val="EG_EGY_231_Egypt">(EGY) - Egypt</option>
                              <option value="ESH" data-val="EH_ESH_232_Western Sahara">(ESH) - Western Sahara</option>
                              <option value="ERI" data-val="ER_ERI_233_Eritrea">(ERI) - Eritrea</option>
                              <option value="ESP" data-val="ES_ESP_234_Spain">(ESP) - Spain</option>
                              <option value="ETH" data-val="ET_ETH_238_Ethiopia">(ETH) - Ethiopia</option>
                              <option value="FIN" data-val="FI_FIN_239_Finland">(FIN) - Finland</option>
                              <option value="FJI" data-val="FJ_FJI_242_Fiji">(FJI) - Fiji</option>
                              <option value="FLK" data-val="FK_FLK_246_Falkland Islands (Malvinas)">(FLK) - Falkland Islands (Malvinas)</option>
                              <option value="FSM" data-val="FM_FSM_248_Micronesia">(FSM) -  Federated States of Micronesia	 Federated States of</option>
                              <option value="FRO" data-val="FO_FRO_250_Faroe Islands">(FRO) - Faroe Islands</option>
                              <option value="FRA" data-val="FR_FRA_254_France">(FRA) - France</option>
                              <option value="GAB" data-val="GA_GAB_258_Gabon">(GAB) - Gabon</option>
                              <option value="GBR" data-val="GB_GBR_260_United Kingdom">(GBR) - United Kingdom</option>
                              <option value="GRD" data-val="GD_GRD_262_Grenada">(GRD) - Grenada</option>
                              <option value="GEO" data-val="GE_GEO_266_Georgia">(GEO) - Georgia</option>
                              <option value="GUF" data-val="GF_GUF_268_French Guiana">(GUF) - French Guiana</option>
                              <option value="GGY" data-val="GG_GGY_270_Guernsey">(GGY) - Guernsey</option>
                              <option value="GHA" data-val="GH_GHA_275_Ghana">(GHA) - Ghana</option>
                              <option value="GIB" data-val="GI_GIB_276_Gibraltar">(GIB) - Gibraltar</option>
                              <option value="GRL" data-val="GL_GRL_288_Greenland">(GRL) - Greenland</option>
                              <option value="GMB" data-val="GM_GMB_292_Gambia">(GMB) - Gambia</option>
                              <option value="GIN" data-val="GN_GIN_296_Guinea">(GIN) - Guinea</option>
                              <option value="GLP" data-val="GP_GLP_300_Guadeloupe">(GLP) - Guadeloupe</option>
                              <option value="GNQ" data-val="GQ_GNQ_304_Equatorial Guinea">(GNQ) - Equatorial Guinea</option>
                              <option value="GRC" data-val="GR_GRC_308_Greece">(GRC) - Greece</option>
                              <option value="SGS" data-val="GS_SGS_312_South Georgia and the South Sandwich Islands">(SGS) - South Georgia and the South Sandwich Islands</option>
                              <option value="GTM" data-val="GT_GTM_316_Guatemala">(GTM) - Guatemala</option>
                              <option value="GUM" data-val="GU_GUM_320_Guam">(GUM) - Guam</option>
                              <option value="GNB" data-val="GW_GNB_324_Guinea-Bissau">(GNB) - Guinea-Bissau</option>
                              <option value="GUY" data-val="GY_GUY_328_Guyana">(GUY) - Guyana</option>
                              <option value="HKG" data-val="HK_HKG_332_Hong Kong">(HKG) -  SAR China Hong Kong	 SAR China</option>
                              <option value="HMD" data-val="HM_HMD_334_Heard and Mcdonald Islands">(HMD) - Heard and Mcdonald Islands</option>
                              <option value="HND" data-val="HN_HND_336_Honduras">(HND) - Honduras</option>
                              <option value="HRV" data-val="HR_HRV_340_Croatia">(HRV) - Croatia</option>
                              <option value="HTI" data-val="HT_HTI_344_Haiti">(HTI) - Haiti</option>
                              <option value="HUN" data-val="HU_HUN_348_Hungary">(HUN) - Hungary</option>
                              <option value="IDN" data-val="ID_IDN_352_Indonesia">(IDN) - Indonesia</option>
                              <option value="IRL" data-val="IE_IRL_356_Ireland">(IRL) - Ireland</option>
                              <option value="ISR" data-val="IL_ISR_360_Israel">(ISR) - Israel</option>
                              <option value="IMN" data-val="IM_IMN_364_Isle of Man">(IMN) - Isle of Man</option>
                              <option value="IND" data-val="IN_IND_368_India">(IND) - India</option>
                              <option value="IOT" data-val="IO_IOT_372_British Indian Ocean Territory">(IOT) - British Indian Ocean Territory</option>
                              <option value="IRQ" data-val="IQ_IRQ_376_Iraq">(IRQ) - Iraq</option>
                              <option value="IRN" data-val="IR_IRN_380_Iran">(IRN) -  Islamic Republic of Iran	 Islamic Republic of</option>
                              <option value="ISL" data-val="IS_ISL_384_Iceland">(ISL) - Iceland</option>
                              <option value="ITA" data-val="IT_ITA_388_Italy">(ITA) - Italy</option>
                              <option value="JEY" data-val="JE_JEY_392_Jersey">(JEY) - Jersey</option>
                              <option value="JAM" data-val="JM_JAM_398_Jamaica">(JAM) - Jamaica</option>
                              <option value="JOR" data-val="JO_JOR_400_Jordan">(JOR) - Jordan</option>
                              <option value="JPN" data-val="JP_JPN_404_Japan">(JPN) - Japan</option>
                              <option value="KEN" data-val="KE_KEN_408_Kenya">(KEN) - Kenya</option>
                              <option value="KGZ" data-val="KG_KGZ_410_Kyrgyzstan">(KGZ) - Kyrgyzstan</option>
                              <option value="KHM" data-val="KH_KHM_414_Cambodia">(KHM) - Cambodia</option>
                              <option value="KIR" data-val="KI_KIR_417_Kiribati">(KIR) - Kiribati</option>
                              <option value="COM" data-val="KM_COM_418_Comoros">(COM) - Comoros</option>
                              <option value="KNA" data-val="KN_KNA_422_Saint Kitts and Nevis">(KNA) - Saint Kitts and Nevis</option>
                              <option value="PRK" data-val="KP_PRK_426_Korea (North)">(PRK) - Korea (North)</option>
                              <option value="KOR" data-val="KR_KOR_428_Korea (South)">(KOR) - Korea (South)</option>
                              <option value="KWT" data-val="KW_KWT_430_Kuwait">(KWT) - Kuwait</option>
                              <option value="CYM" data-val="KY_CYM_434_Cayman Islands">(CYM) - Cayman Islands</option>
                              <option value="KAZ" data-val="KZ_KAZ_438_Kazakhstan">(KAZ) - Kazakhstan</option>
                              <option value="LAO" data-val="LA_LAO_440_Lao PDR">(LAO) - Lao PDR</option>
                              <option value="LBN" data-val="LB_LBN_442_Lebanon">(LBN) - Lebanon</option>
                              <option value="LCA" data-val="LC_LCA_446_Saint Lucia">(LCA) - Saint Lucia</option>
                              <option value="LIE" data-val="LI_LIE_450_Liechtenstein">(LIE) - Liechtenstein</option>
                              <option value="LKA" data-val="LK_LKA_454_Sri Lanka">(LKA) - Sri Lanka</option>
                              <option value="LBR" data-val="LR_LBR_458_Liberia">(LBR) - Liberia</option>
                              <option value="LSO" data-val="LS_LSO_462_Lesotho">(LSO) - Lesotho</option>
                              <option value="LTU" data-val="LT_LTU_466_Lithuania">(LTU) - Lithuania</option>
                              <option value="LUX" data-val="LU_LUX_470_Luxembourg">(LUX) - Luxembourg</option>
                              <option value="LVA" data-val="LV_LVA_474_Latvia">(LVA) - Latvia</option>
                              <option value="LBY" data-val="LY_LBY_478_Libya">(LBY) - Libya</option>
                              <option value="MAR" data-val="MA_MAR_480_Morocco">(MAR) - Morocco</option>
                              <option value="MCO" data-val="MC_MCO_484_Monaco">(MCO) - Monaco</option>
                              <option value="MDA" data-val="MD_MDA_492_Moldova">(MDA) - Moldova</option>
                              <option value="MNE" data-val="ME_MNE_496_Montenegro">(MNE) - Montenegro</option>
                              <option value="MAF" data-val="MF_MAF_498_Saint-Martin (French part)">(MAF) - Saint-Martin (French part)</option>
                              <option value="MDG" data-val="MG_MDG_499_Madagascar">(MDG) - Madagascar</option>
                              <option value="MHL" data-val="MH_MHL_500_Marshall Islands">(MHL) - Marshall Islands</option>
                              <option value="MKD" data-val="MK_MKD_504_Macedonia">(MKD) -  Republic of Macedonia	 Republic of</option>
                              <option value="MLI" data-val="ML_MLI_508_Mali">(MLI) - Mali</option>
                              <option value="MMR" data-val="MM_MMR_512_Myanmar">(MMR) - Myanmar</option>
                              <option value="MNG" data-val="MN_MNG_516_Mongolia">(MNG) - Mongolia</option>
                              <option value="MAC" data-val="MO_MAC_520_Macao">(MAC) -  SAR China Macao	 SAR China</option>
                              <option value="MNP" data-val="MP_MNP_524_Northern Mariana Islands">(MNP) - Northern Mariana Islands</option>
                              <option value="MTQ" data-val="MQ_MTQ_528_Martinique">(MTQ) - Martinique</option>
                              <option value="MRT" data-val="MR_MRT_530_Mauritania">(MRT) - Mauritania</option>
                              <option value="MSR" data-val="MS_MSR_533_Montserrat">(MSR) - Montserrat</option>
                              <option value="MLT" data-val="MT_MLT_540_Malta">(MLT) - Malta</option>
                              <option value="MUS" data-val="MU_MUS_548_Mauritius">(MUS) - Mauritius</option>
                              <option value="MDV" data-val="MV_MDV_554_Maldives">(MDV) - Maldives</option>
                              <option value="MWI" data-val="MW_MWI_558_Malawi">(MWI) - Malawi</option>
                              <option value="MEX" data-val="MX_MEX_562_Mexico">(MEX) - Mexico</option>
                              <option value="MYS" data-val="MY_MYS_566_Malaysia">(MYS) - Malaysia</option>
                              <option value="MOZ" data-val="MZ_MOZ_570_Mozambique">(MOZ) - Mozambique</option>
                              <option value="NAM" data-val="NA_NAM_574_Namibia">(NAM) - Namibia</option>
                              <option value="NCL" data-val="NC_NCL_578_New Caledonia">(NCL) - New Caledonia</option>
                              <option value="NER" data-val="NE_NER_580_Niger">(NER) - Niger</option>
                              <option value="NFK" data-val="NF_NFK_581_Norfolk Island">(NFK) - Norfolk Island</option>
                              <option value="NGA" data-val="NG_NGA_583_Nigeria">(NGA) - Nigeria</option>
                              <option value="NIC" data-val="NI_NIC_584_Nicaragua">(NIC) - Nicaragua</option>
                              <option value="NLD" data-val="NL_NLD_585_Netherlands">(NLD) - Netherlands</option>
                              <option value="NOR" data-val="NO_NOR_586_Norway">(NOR) - Norway</option>
                              <option value="NPL" data-val="NP_NPL_591_Nepal">(NPL) - Nepal</option>
                              <option value="NRU" data-val="NR_NRU_598_Nauru">(NRU) - Nauru</option>
                              <option value="NIU" data-val="NU_NIU_600_Niue">(NIU) - Niue</option>
                              <option value="NZL" data-val="NZ_NZL_604_New Zealand">(NZL) - New Zealand</option>
                              <option value="OMN" data-val="OM_OMN_608_Oman">(OMN) - Oman</option>
                              <option value="PAN" data-val="PA_PAN_612_Panama">(PAN) - Panama</option>
                              <option value="PER" data-val="PE_PER_616_Peru">(PER) - Peru</option>
                              <option value="PYF" data-val="PF_PYF_620_French Polynesia">(PYF) - French Polynesia</option>
                              <option value="PNG" data-val="PG_PNG_624_Papua New Guinea">(PNG) - Papua New Guinea</option>
                              <option value="PHL" data-val="PH_PHL_626_Philippines">(PHL) - Philippines</option>
                              <option value="PAK" data-val="PK_PAK_630_Pakistan">(PAK) - Pakistan</option>
                              <option value="POL" data-val="PL_POL_634_Poland">(POL) - Poland</option>
                              <option value="SPM" data-val="PM_SPM_638_Saint Pierre and Miquelon">(SPM) - Saint Pierre and Miquelon</option>
                              <option value="PCN" data-val="PN_PCN_642_Pitcairn">(PCN) - Pitcairn</option>
                              <option value="PRI" data-val="PR_PRI_643_Puerto Rico">(PRI) - Puerto Rico</option>
                              <option value="PSE" data-val="PS_PSE_646_Palestinian Territory">(PSE) - Palestinian Territory</option>
                              <option value="PRT" data-val="PT_PRT_652_Portugal">(PRT) - Portugal</option>
                              <option value="PLW" data-val="PW_PLW_654_Palau">(PLW) - Palau</option>
                              <option value="PRY" data-val="PY_PRY_659_Paraguay">(PRY) - Paraguay</option>
                              <option value="QAT" data-val="QA_QAT_660_Qatar">(QAT) - Qatar</option>
                              <option value="REU" data-val="RE_REU_662_Réunion">(REU) - Réunion</option>
                              <option value="ROU" data-val="RO_ROU_663_Romania">(ROU) - Romania</option>
                              <option value="SRB" data-val="RS_SRB_666_Serbia">(SRB) - Serbia</option>
                              <option value="RUS" data-val="RU_RUS_670_Russian Federation">(RUS) - Russian Federation</option>
                              <option value="RWA" data-val="RW_RWA_674_Rwanda">(RWA) - Rwanda</option>
                              <option value="SAU" data-val="SA_SAU_678_Saudi Arabia">(SAU) - Saudi Arabia</option>
                              <option value="SLB" data-val="SB_SLB_682_Solomon Islands">(SLB) - Solomon Islands</option>
                              <option value="SYC" data-val="SC_SYC_686_Seychelles">(SYC) - Seychelles</option>
                              <option value="SDN" data-val="SD_SDN_688_Sudan">(SDN) - Sudan</option>
                              <option value="SWE" data-val="SE_SWE_690_Sweden">(SWE) - Sweden</option>
                              <option value="SGP" data-val="SG_SGP_694_Singapore">(SGP) - Singapore</option>
                              <option value="SHN" data-val="SH_SHN_702_Saint Helena">(SHN) - Saint Helena</option>
                              <option value="SVN" data-val="SI_SVN_703_Slovenia">(SVN) - Slovenia</option>
                              <option value="SJM" data-val="SJ_SJM_704_Svalbard and Jan Mayen Islands">(SJM) - Svalbard and Jan Mayen Islands</option>
                              <option value="SVK" data-val="SK_SVK_705_Slovakia">(SVK) - Slovakia</option>
                              <option value="SLE" data-val="SL_SLE_706_Sierra Leone">(SLE) - Sierra Leone</option>
                              <option value="SMR" data-val="SM_SMR_710_San Marino">(SMR) - San Marino</option>
                              <option value="SEN" data-val="SN_SEN_716_Senegal">(SEN) - Senegal</option>
                              <option value="SOM" data-val="SO_SOM_724_Somalia">(SOM) - Somalia</option>
                              <option value="SUR" data-val="SR_SUR_728_Suriname">(SUR) - Suriname</option>
                              <option value="SSD" data-val="SS_SSD_732_South Sudan">(SSD) - South Sudan</option>
                              <option value="STP" data-val="ST_STP_736_Sao Tome and Principe">(STP) - Sao Tome and Principe</option>
                              <option value="SLV" data-val="SV_SLV_740_El Salvador">(SLV) - El Salvador</option>
                              <option value="SYR" data-val="SY_SYR_744_Syrian Arab Republic (Syria)">(SYR) - Syrian Arab Republic (Syria)</option>
                              <option value="SWZ" data-val="SZ_SWZ_748_Swaziland">(SWZ) - Swaziland</option>
                              <option value="TCA" data-val="TC_TCA_752_Turks and Caicos Islands">(TCA) - Turks and Caicos Islands</option>
                              <option value="TCD" data-val="TD_TCD_756_Chad">(TCD) - Chad</option>
                              <option value="ATF" data-val="TF_ATF_760_French Southern Territories">(ATF) - French Southern Territories</option>
                              <option value="TGO" data-val="TG_TGO_762_Togo">(TGO) - Togo</option>
                              <option value="THA" data-val="TH_THA_764_Thailand">(THA) - Thailand</option>
                              <option value="TJK" data-val="TJ_TJK_768_Tajikistan">(TJK) - Tajikistan</option>
                              <option value="TKL" data-val="TK_TKL_772_Tokelau">(TKL) - Tokelau</option>
                              <option value="TLS" data-val="TL_TLS_776_Timor-Leste">(TLS) - Timor-Leste</option>
                              <option value="TKM" data-val="TM_TKM_780_Turkmenistan">(TKM) - Turkmenistan</option>
                              <option value="TUN" data-val="TN_TUN_784_Tunisia">(TUN) - Tunisia</option>
                              <option value="TON" data-val="TO_TON_788_Tonga">(TON) - Tonga</option>
                              <option value="TUR" data-val="TR_TUR_792_Turkey">(TUR) - Turkey</option>
                              <option value="TTO" data-val="TT_TTO_795_Trinidad and Tobago">(TTO) - Trinidad and Tobago</option>
                              <option value="TUV" data-val="TV_TUV_796_Tuvalu">(TUV) - Tuvalu</option>
                              <option value="TWN" data-val="TW_TWN_798_Taiwan">(TWN) -  Republic of China Taiwan	 Republic of China</option>
                              <option value="TZA" data-val="TZ_TZA_800_Tanzania">(TZA) -  United Republic of Tanzania	 United Republic of</option>
                              <option value="UKR" data-val="UA_UKR_804_Ukraine">(UKR) - Ukraine</option>
                              <option value="UGA" data-val="UG_UGA_807_Uganda">(UGA) - Uganda</option>
                              <option value="UMI" data-val="UM_UMI_818_US Minor Outlying Islands">(UMI) - US Minor Outlying Islands</option>
                              <option value="USA" data-val="US_USA_826_United States of America">(USA) - United States of America</option>
                              <option value="URY" data-val="UY_URY_831_Uruguay">(URY) - Uruguay</option>
                              <option value="UZB" data-val="UZ_UZB_832_Uzbekistan">(UZB) - Uzbekistan</option>
                              <option value="VAT" data-val="VA_VAT_833_Holy See (Vatican City State)">(VAT) - Holy See (Vatican City State)</option>
                              <option value="VCT" data-val="VC_VCT_834_Saint Vincent and Grenadines">(VCT) - Saint Vincent and Grenadines</option>
                              <option value="VEN" data-val="VE_VEN_840_Venezuela (Bolivarian Republic)">(VEN) - Venezuela (Bolivarian Republic)</option>
                              <option value="VGB" data-val="VG_VGB_850_British Virgin Islands">(VGB) - British Virgin Islands</option>
                              <option value="VIR" data-val="VI_VIR_854_Virgin Islands">(VIR) -  US Virgin Islands	 US</option>
                              <option value="VNM" data-val="VN_VNM_858_Viet Nam">(VNM) - Viet Nam</option>
                              <option value="VUT" data-val="VU_VUT_860_Vanuatu">(VUT) - Vanuatu</option>
                              <option value="WLF" data-val="WF_WLF_862_Wallis and Futuna Islands">(WLF) - Wallis and Futuna Islands</option>
                              <option value="WSM" data-val="WS_WSM_876_Samoa">(WSM) - Samoa</option>
                              <option value="YEM" data-val="YE_YEM_882_Yemen">(YEM) - Yemen</option>
                              <option value="MYT" data-val="YT_MYT_887_Mayotte">(MYT) - Mayotte</option>
                              <option value="ZAF" data-val="ZA_ZAF_894_South Africa">(ZAF) - South Africa</option>
                              <option value="ZMB" data-val="ZM_ZMB_004_Zambia">(ZMB) - Zambia</option>
                              <option value="ZWE" data-val="ZW_ZWE_028_Zimbabwe">(ZWE) - Zimbabwe</option>
                    </datalist>

					
				</div>
				<script>
					if (($('#input_bill_country').val()) != "") {
						$("#input_bill_country").removeClass('is-invalid').addClass('is-valid');
					}
				</script>

				

				<div class="input-field my-3">
					<input type="text" name="bill_state"
						value="<?=(@$post['bill_state']?prntext(@$post['bill_state']):prntext(@$_SESSION['re_post']['bill_state']));?>"
						id="state_list" list="state_input_divid" title="Bill State" minlength="2" class="form-control is-invalid" required>
					<label for="state_list">Bill State</label>
					
					<datalist id="state_input_divid" >
					</datalist>

				</div>
				<script>
					if (($('#state_list').val()) != "") {
						$("#state_list").removeClass('is-invalid').addClass('is-valid');
					}
				</script>


				<div class="input-field my-3">
					<input type="text" name="bill_zip"
						value="<?=(@$post['bill_zip']?prntext(@$post['bill_zip']):prntext(@$_SESSION['re_post']['bill_zip']));?>"
						id="input_bill_zip" title="Bill Zip" minlength="2" class="form-control is-invalid" required>
					<label for="input_bill_zip">Bill Zip</label>
				</div>
				<script>
					if (($('#input_bill_zip').val()) != "") {
						$("#input_bill_zip").removeClass('is-invalid').addClass('is-valid');
					}
				</script>
		  	<? 
				
				// Java script value for List of Country and State 
				
				$country_state_common_script=$data['Path']."/front_ui/default/common/country_state_common_script".$data['iex'];
							 
				if(file_exists($country_state_common_script)){
					include($country_state_common_script);
				}
			} 
			?> 
			
			
		<? } ?>
		  
		  <button id="contSubmit" type="button" value="CHANGE NOW!" class="submitbtn btn btn-primary w-100 mb-2 next"><i></i><b class="contitxt">Next</b></button>
		</div>
		<div class="paymentContainerDiv">
		<div class="paymentMethodDiv hide">
		  <div class="payment_option m-2">
			<? 
			//print_r($_POST);
			if(isset($_SESSION['curr'])) $currency_smbl=get_currency($_SESSION['curr']);
			else $currency_smbl='';
			?>
			<h4 class=""><span class="paymentMethodh4">CARDS, UPI & MORE</span> <span id='result_view_chk' class='result_view'></span> <span id='result_view' class='result_view'> </span> <a class="change hide float-start me-3" id="paymentMethodChange" ><i class="<?=@$data['fwicon']['return'];?> fa-xl fa-fw" title="Change Payment Method"></i></a></h4>
			<div class="chkname" >
			
			<!-- 2D,3D,CARD_PAYMENT -->  

			  <? if(isset($post['acquirer_id_card'])&&!empty($post['acquirer_id_card'])){?>
                  <div class="cname cardDiv">
                    <div class="inputgroup">
		<?
		
		$outputArray_1 = array();
		
		
		foreach($_SESSION['AccountInfo'] as $key=>$value){if((isset($value['acquirer_id'])&&$value['acquirer_id']) && isset($_SESSION['b_'.$value['acquirer_id']]['channel_type']) && (in_array($value['acquirer_id'],$post['acquirer_id_card_arr'])) && ($value['acquirer_processing_mode']!="3") && ($_SESSION['b_'.$value['acquirer_id']]['acquirer_status']>0)  && (!in_array($value['acquirer_id'],$outputArray_1)) ) {
		  
			$outputArray_1[] = $value['acquirer_id'];

			
		   //if($_SESSION['curr']){$pcrcy=$currency_smbl;}else{$pcrcy=$pcrcy;}
		   if(isset($_SESSION['curr'])&&$_SESSION['curr']){$pcrcy=$currency_smbl;}else{$pcrcy=$_SESSION['curr_tr_sys'];}
					?>
				  <div class="inputype the_icon <?=countryCodeMatch2(@$post['country_two'],(isset($_SESSION["b_".$value['acquirer_id']]['countries'])?$_SESSION["b_".$value['acquirer_id']]['countries']:''),(isset($_SESSION["b_".$value['acquirer_id']]['processing_countries'])?$_SESSION["b_".$value['acquirer_id']]['processing_countries']:''),isset($_SESSION["b_".$value['acquirer_id']]['block_countries'])?$_SESSION["b_".$value['acquirer_id']]['block_countries']:'')?> border rounded my-1 mb-1 w-100">
				  
					<input type="radio" value="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" id="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" required name="account_types" class="account_types" data-value="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" data-name="ecard" data-ccn="<?=(isset($_SESSION['b_'.$value['acquirer_id']]['mop'])?@$_SESSION['b_'.$value['acquirer_id']]['mop']:'')?>" data-currency="<?=@$pcrcy;?>" data-ewlist="<?=acquirer_popup_msg_f($value['acquirer_id'])?>"  data-etype="2D"  data-channel='<?=(isset($_SESSION["b_".$value['acquirer_id']]['channel_type'])?$_SESSION["b_".$value['acquirer_id']]['channel_type']:'');?>'   data-count='<? if(isset($_SESSION["b_".$value['acquirer_id']]['deCon'])) echo $_SESSION["b_".$value['acquirer_id']]['deCon'];?>' data-dnmc='<? if(isset($_SESSION["b_".$value['acquirer_id']]['block_countries'])) echo $_SESSION["b_".$value['acquirer_id']]['block_countries'];?>' data-pco='<? if(isset($_SESSION["b_".$value['acquirer_id']]['processing_countries'])) echo $_SESSION["b_".$value['acquirer_id']]['processing_countries'];?>'  style="display:none;" />
					<label for="<?=@$value['acquirer_id']?>" class="pointer">
						<strong class="text-muted ">
						<span class="back_action float-start me-3" style=""><i class="<?=@$data['fwicon']['credit-card'];?> text-info"></i><i class="<?=@$data['fwicon']['credit-card'];?> icon-position "></i></span>
                        <? 
						//Get Icon from mop of acquirer id wise 
						$mop_get=$_SESSION["b_".$value['acquirer_id']]['mop'];
						if(@$mop_get)$mop_icon=mop_option_list_f(2,$mop_get).' ';
						else $mop_icon='';
						//echo "<br/>mop_get=>".$mop_get;

						//Get sub label name of acquirer id wise 
						if(isset($data['CHECKOUT_SUBLABEL_NAME'])&&$data['CHECKOUT_SUBLABEL_NAME']=='Y'&&acquirer_logo_f($value['acquirer_id']))
							$sub_label_name=@$mop_icon.acquirer_logo_f($value['acquirer_id']);
						else $sub_label_name=@$mop_icon.'Visa, MasterCard, RuPay & More';

						if(acquirer_label_f(@$value['checkout_label_web'],@$value['checkout_label_mobile'],$value['acquirer_id'])){echo acquirer_label_f(@$value['checkout_label_web'],@$value['checkout_label_mobile'],$value['acquirer_id']);
						 echo "<div class='heading2_ind'>{$sub_label_name}</div>";}else{?>
                        Pay by Card [
                        <?=(isset($_SESSION['curr_transaction_amount'])?$_SESSION['curr_transaction_amount']:'');?>
                        ]
                        <? } ?> 
								
								</strong>
						
                        </label>
				  </div>
				  <? }} ?>
				</div>
			  </div>
			  <? } ?>


			
			  <? /* if(isset($post['nick_name_net_banking'])&&!empty($post['nick_name_net_banking'])){?>
			  <div class="cname netBankCont">
				<div class="inputgroup">
				  <? foreach($_SESSION['AccountInfo'] as $key=>$value){
				  if(isset($value['acquirer_id'])&&(@$value['acquirer_id']) && (strpos(@$_SESSION['b_'.$value['acquirer_id']]['channel_type'],'Banking') !== false) && (in_array(@$value['acquirer_id'],@$post['nick_name_net_banking_arr'])) && (@$value['account_login_url']!="3")  ){
					  
						if(isset($_SESSION['curr'])&&$_SESSION['curr']){$pcrcy=$currency_smbl;}else{$pcrcy=$_SESSION['curr_tr_sys'];}
					  
						
						if(isset($value['account_login_url'])&&$value['account_login_url']=="1"){$dataname="ewallets"; }
						elseif(isset($value['account_login_url'])&&$value['account_login_url']=="2"){$dataname="evoilatecard"; }
					?>
				  <div class="inputype <?=(isset($data['t'][$value['acquirer_id']]['logo'])?"the_icon":"")?> <?=countryCodeMatch2(@$post['country_two'],(isset($_SESSION["b_".$value['acquirer_id']]['countries'])?$_SESSION["b_".$value['acquirer_id']]['countries']:''),(isset($_SESSION["b_".$value['acquirer_id']]['countryCode'])?$_SESSION["b_".$value['acquirer_id']]['countryCode']:''))?> border rounded my-1 w-100" >
					<input type="radio" value="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" id="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" required name="account_types" class="account_types" data-value="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" data-name="<?=@$dataname;?>" data-currency="<?=@$pcrcy;?>" data-submitmsg="intent_submitMsg<?=(isset($data['t'][$value['acquirer_id']]['submitMsg']))?$data['t'][$value['acquirer_id']]['submitMsg']:'';?>" data-ewlist="<?=(isset($data['t'][$value['acquirer_id']]['name6']))?$data['t'][$value['acquirer_id']]['name6']:'';?>" data-etype="<?=(isset($data['t'][$value['acquirer_id']]['name4']))?$data['t'][$value['acquirer_id']]['name4']:'';?>" data-channel='<?=(isset($_SESSION["b_".$value['acquirer_id']]['channel_type'])?$_SESSION["b_".$value['acquirer_id']]['channel_type']:'');?>'    style="display:none;" />
					<label for="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" class="pointer">
                        
                        
                        <strong class="text-muted">
						<span class="back_action float-start icon_the_pay me-3">
						<? if($value['checkout_level_name']=="UPI Wallets"){ 
						echo '<i class="'.$data['fwicon']['wallet_code'].' text-dark" title="UPI Wallets !!!"></i>';
						}elseif(strstr($value['checkout_level_name'],"Net Banking") || strstr($value['checkout_level_name'],"NB")){ 
						echo '<i class="'.$data['fwicon']['net_banking'].' text-info" title="Net Banking !!!"></i>
						<i class="'.$data['fwicon']['net_banking'].' icon-position" title="Net Banking !!!"></i>';
						}else{ 
						
						?>
						<img src="<?=@$data['Host']?>/images/<?=@$data['t'][$value['acquirer_id']]['logo'];?>_logo.png" title="<?=@$value['checkout_level_name'];?>"  />
						<? } ?>
						</span>
						
						<? if(isset($value['checkout_level_name'])&&$value['checkout_level_name']){echo $value['checkout_level_name']; echo "<div class='heading2_ind'>All indian banks</div>";}else{?>
                        Pay with eWallets [ <?=(isset($_SESSION['curr_transaction_amount'])?$_SESSION['curr_transaction_amount']:'');?> ]
                        
                        <? } ?>
						
						        
								
								</strong>
                        </label>
				  </div>
				  <? }} ?>
				</div>
			  </div>
			  <? }*/ ?>
			  
			  
			  
			  <!-- QR,UPI,INTENT,COLLECT,WALLET,NETBANKING,NETWORK_PAYMENT,BANK_TRANSFER -->
			  
			  <? if((isset($post['acquirer_id_ewallets'])&&!empty($post['acquirer_id_ewallets']))||(isset($post['acquirer_id_net_banking'])&&!empty($post['acquirer_id_net_banking']))||(isset($post['acquirer_id_upi'])&&!empty($post['acquirer_id_upi']))){?>
				<div class="cname netBankEdiv">
					<div class="inputgroup">
					<? 
					//wallet & net banking 
					$acq_cnt=0;
					$acq_typ="";
					$outputArray_2 = array();
					//echo count($_SESSION['AccountInfo'])."444444";
					
					//print_r($_SESSION['AccountInfo'][26]);
					
					foreach($_SESSION['AccountInfo'] as $key=>$value){
					
					
					
						if((isset($value['acquirer_id'])&&$value['acquirer_id']) && ( (isset($post['acquirer_id_ewallets_arr'])&&in_array($value['acquirer_id'],@$post['acquirer_id_ewallets_arr']) ) || (isset($post['acquirer_id_net_banking_arr'])&&in_array($value['acquirer_id'],@$post['acquirer_id_net_banking_arr'])) || (isset($post['acquirer_id_upi_arr'])&&in_array($value['acquirer_id'],@$post['acquirer_id_upi_arr'])) ) && ($value['acquirer_processing_mode']!="3") && (isset($_SESSION['b_'.$value['acquirer_id']]['acquirer_status'])&&$_SESSION['b_'.$value['acquirer_id']]['acquirer_status']>0) && (!in_array($value['acquirer_id'],$outputArray_2)) ) {
					  
					  //echo "<br/>acquirer_id=>".$value['acquirer_id'];
					  
					  
						$outputArray_2[] = $value['acquirer_id'];

						if(isset($_SESSION['curr'])&&$_SESSION['curr']){$pcrcy=$currency_smbl;}else{$pcrcy=$_SESSION['curr_tr_sys'];}
					  
					   
						if(isset($value['acquirer_processing_mode'])&&$value['acquirer_processing_mode']==1){
							$dataname="ewallets"; 
							$data_ccn=''; 
						}
						elseif(isset($value['acquirer_processing_mode'])&&$value['acquirer_processing_mode']==2){
							$dataname="evoilatecard"; 
							$data_ccn='data-ccn="visa"';
						}
						
						
				
					
					?>
				  <div class="inputype the_icon  <?=countryCodeMatch2(@$post['country_two'],isset($_SESSION["b_".$value['acquirer_id']]['countries'])?$_SESSION["b_".$value['acquirer_id']]['countries']:'',isset($_SESSION["b_".$value['acquirer_id']]['processing_countries'])?$_SESSION["b_".$value['acquirer_id']]['processing_countries']:'',isset($_SESSION["b_".$value['acquirer_id']]['block_countries'])?$_SESSION["b_".$value['acquirer_id']]['block_countries']:'')?> border rounded my-1 mb-1 w-100">
					<input type="radio" value="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" id="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" required name="account_types" class="account_types" data-value="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" data-name="<?=(isset($dataname)?$dataname:'');?>" data-currency="<?=@$pcrcy;?>" data-submitmsg="intent_submitMsg" data-ewlist="<?=acquirer_popup_msg_f($value['acquirer_id'])?>" data-etype="3D" data-channel='<?=(isset($_SESSION["b_".$value['acquirer_id']]['channel_type'])?$_SESSION["b_".$value['acquirer_id']]['channel_type']:'');?>'  data-count='<?=(isset($_SESSION["b_".$value['acquirer_id']]['deCon'])?$_SESSION["b_".$value['acquirer_id']]['deCon']:'');?>' data-dnmc='<? if(isset($_SESSION["b_".$value['acquirer_id']]['block_countries'])) echo $_SESSION["b_".$value['acquirer_id']]['block_countries'];?>' data-pco='<? if(isset($_SESSION["b_".$value['acquirer_id']]['processing_countries'])) echo $_SESSION["b_".$value['acquirer_id']]['processing_countries'];?>' style="display:none;" <?=(isset($data_ccn)?$data_ccn:'');?> />
					<label for="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" class="pointer">
                        
                        
                        <strong class="text-muted">
						<span class="back_action float-start icon_the_pay me-3">
						<? 

                       

                        $pmt_type=$data['channel'][$_SESSION['b_'.$value['acquirer_id']]['channel_type']]['name1'];
						//echo $pmt_type;
						

						//Get Icon from mop of acquirer id wise 
						$mop_get=$_SESSION["b_".$value['acquirer_id']]['mop'];
						if(@$mop_get)$mop_icon=mop_option_list_f(2,$mop_get).' ';
						else $mop_icon='';
						//echo "<br/>mop_get=>".$mop_get;

						//Get sub label name of acquirer id wise 
						if(isset($data['CHECKOUT_SUBLABEL_NAME'])&&$data['CHECKOUT_SUBLABEL_NAME']=='Y'&&acquirer_logo_f($value['acquirer_id']))
							$sub_label_name=@$mop_icon.acquirer_logo_f($value['acquirer_id']);
						else $sub_label_name='';


                       
					   if($pmt_type=="wa"){ 
							if(trim($sub_label_name)) $sub_title=$sub_label_name; 
							else $sub_title=@$mop_icon."PhonePe Paytm Amazon & More";
							echo '<i class="'.$data['fwicon']['wallet_code'].' text-info" title="UPI Wallets"></i> <i class="'.$data['fwicon']['wallet_code'].' text-dark icon-position" title="UPI Wallets"></i>';
						}elseif($pmt_type=="nb"){ 
							if(trim($sub_label_name)) $sub_title=$sub_label_name; 
							else $sub_title=@$mop_icon."All Indian Bank	";
							
							echo '<i class="'.$data['fwicon']['net_banking'].' text-info" title="Net Banking"></i> <i class="'.$data['fwicon']['net_banking'].' icon-position" title="Net Banking "></i>';
						}elseif($pmt_type=="bt"){ 
							if(trim($sub_label_name)) $sub_title=$sub_label_name; 
							else $sub_title=@$mop_icon.'<span style="position:relative;top:4px;margin:0 5px 0 0;">'.@$mop_icon.'<i class="'.$data['fwicon']['net_banking'].' icon-position" title="Bank Transfer "></i></span> Bank Transfer';
							echo $data['fwicon']['bt'];
						}elseif($pmt_type=="np"){ 
							if(trim($sub_label_name)) $sub_title=$sub_label_name; 
							else $sub_title=@$mop_icon.'<span style="position:relative;top:4px;margin:0 5px 0 0;"><i class="'.$data['fwicon']['ethereum_code'].' icon-position" title="Network Payment "></i></span> Network Payment';
							//echo $data['fwicon']['ethereum'];
							?>
								
								<img src="<?=@$data['bankicon']['cryptocurrency']?>" title="<?=@$value['checkout_label_web'];?>"  />
							
						<?
						}elseif($pmt_type=="qr"){ 
							if(trim($sub_label_name)) $sub_title=$sub_label_name; 
							else $sub_title=@$mop_icon."<img src='".$data['bankicon']['google-pay-svg']."' alt='google-pay'>&nbsp;<img src='".$data['bankicon']['phonepe-svg']."' alt='phonepe'>&nbsp;<img src='".$data['bankicon']['paytm-svg']."' alt='paytm'> & More";
							echo '<i class="'.$data['fwicon']['qrcode'].' text-info" title="QR"></i> <i class="'.$data['fwicon']['qrcode'].' icon-position" title="QR"></i>';
						}elseif($pmt_type=="upiqr"){ 
							$sub_title_0='<span style="position:relative;top:4px;margin:0 5px 0 0;"><i class="'.$data['fwicon']['qrcode'].' text-info" title="UPI Payment"></i> <i class="'.$data['fwicon']['qrcode'].' icon-position" title="UPI Payment"></i></span>';
							if(trim($sub_label_name)) $sub_title=$sub_label_name; 
							else $sub_title=@$mop_icon.$sub_title_0."<img src='".$data['bankicon']['google-pay-svg']."' alt='google-pay'>&nbsp;<img src='".$data['bankicon']['phonepe-svg']."' alt='phonepe'>&nbsp;<img src='".$data['bankicon']['paytm-svg']."' alt='paytm'> & More"; ?>
							
								<img src="<?=@$data['bankicon']['upi-icon']?>" title="<?=@$value['checkout_label_web'];?>"  />
							
						<?
						}elseif($pmt_type=="upi"){ 
							if(trim($sub_label_name)) $sub_title=$sub_label_name; 
							else $sub_title="<img src='".$data['bankicon']['google-pay-svg']."' alt='google-pay'>&nbsp;<img src='".$data['bankicon']['phonepe-svg']."' alt='phonepe'>&nbsp;<img src='".$data['bankicon']['paytm-svg']."' alt='paytm'> & More"; ?>
							
								<img src="<?=@$data['bankicon']['upi-icon']?>" title="<?=@$value['checkout_label_web'];?>"  />
							
						<?
						}
						
						//echo $sub_title;
						?>
							
						</span>
						
<? if(acquirer_label_f(@$value['checkout_label_web'],@$value['checkout_label_mobile'],$value['acquirer_id'])){echo acquirer_label_f(@$value['checkout_label_web'],@$value['checkout_label_mobile'],$value['acquirer_id']); echo "<div class='heading2_ind'>".@$sub_title."</div>";}else{?>
                        
Pay with eWallets [ <?=(isset($_SESSION['curr_transaction_amount'])?$_SESSION['curr_transaction_amount']:'');?> ]
                        
<? } ?>
						
						
						</strong>
                        </label>
                      </div>
                      <? $acq_cnt ++; }  ?>
					  
					  <? } ?>
					  <?
					    // Check payment mode qr and single acquirer than redirect to Qr Pages
					    //echo $acq_cnt; echo $pmt_type;
					   if((isset($acq_cnt)&&$acq_cnt==1)&&(isset($pmt_type)&&$pmt_type=="qr")){
					   ?>
					   <!--<script>
					   
					   setTimeout(
						function() 
						{
						$(".account_types").trigger( "click" );
						}, 500);
                      </script>-->
					   <?
					   }
					  ?>
                    </div>
                  </div>
                  <? } ?>
			  
			  <? /*if(isset($post['nick_name_upi'])&&!empty($post['nick_name_upi'])){?>
			  <div class="cname upiCont">
				<div class="inputgroup">
				  <? foreach($_SESSION['AccountInfo'] as $key=>$value){if((@$value['acquirer_id']) &&  (strpos(@$_SESSION['b_'.$value['acquirer_id']]['channel_type'],'UPI') !== false) && (in_array(@$value['acquirer_id'],@$post['nick_name_upi_arr'])) && (@$value['account_login_url']!="3")){
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
				  <div class="inputype <?=(isset($data['t'][$value['acquirer_id']]['logo'])?"the_icon":"")?> <?=countryCodeMatch2(@$post['country_two'],(isset($_SESSION["b_".$value['acquirer_id']]['countries'])?$_SESSION["b_".$value['acquirer_id']]['countries']:''),(isset($_SESSION["b_".$value['acquirer_id']]['countryCode'])?$_SESSION["b_".$value['acquirer_id']]['countryCode']:''))?> border rounded p-2 my-1 w-100">
					<input type="radio" value="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" id="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" required name="account_types" class="account_types" data-value="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" data-name="<?=(isset($dataname)?$dataname:'');?>" data-currency="<?=@$pcrcy;?>" data-submitmsg="intent_submitMsg" data-ewlist="<?=acquirer_popup_msg_f($value['acquirer_id'])?>" data-etype="3D" data-channel='<?=(isset($_SESSION["b_".$value['acquirer_id']]['channel_type'])?$_SESSION["b_".$value['acquirer_id']]['channel_type']:'');?>'   data-count='<?=(isset($_SESSION["b_".$value['acquirer_id']]['deCon'])?$_SESSION["b_".$value['acquirer_id']]['deCon']:'');?>' data-dnmc='<? if(isset($_SESSION["b_".$value['acquirer_id']]['block_countries'])) echo $_SESSION["b_".$value['acquirer_id']]['block_countries'];?>' data-pco='<? if(isset($_SESSION["b_".$value['acquirer_id']]['processing_countries'])) echo $_SESSION["b_".$value['acquirer_id']]['processing_countries'];?>' style="display:none;" <?=(isset($data_ccn)?$data_ccn:'');?> />
					<label for="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" class="pointer">
					
					<label for="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>">
					<? if(isset($data['t'][$value['acquirer_id']]['logo'])){?>
					<div class="icon_the_pay"> <img src="<?=@$data['Host']?>/images/<?=@$data['t'][$value['acquirer_id']]['logo'];?>_logo.png"  /> </div>
					<? } ?>
					<? if(isset($value['checkout_level_name'])&&$value['checkout_level_name']){echo $value['checkout_level_name'];}else{?>
					Pay with eWallets [
					<?=@$_SESSION['curr_transaction_amount'];?>
					]
					<? } ?>
					</label>
				  </div>
				  <? }} ?>
				</div>
			  </div>
			  <? }*/ ?>


			</div>
		  </div>
		</div>
		<? } ?>
		<div class="cardHolder" <? if(isset($c_style)) echo $c_style;?>>
		<table class="frame" width="100%" border="0" cellspacing="1" cellpadding="4">
		  <tr><td colspan="2" style="background:<?=@$_SESSION['background_gl7'];?>;margin:0;padding:0;position: relative;"><div class="checkOutOptions">
				
	<?
	if(isset($data['con_name'])&&$data['con_name']=='clk'){
		$post['step']=2;
		$common_input="
		<div style='display:none'>
		<input type='hidden' name='product' value='".@$post['product']."'>
		<input type='hidden' name='bill_amt' value='".@$post['bill_amt']."'>
		</div>";
	}
	if(!isset($post['bill_country_name'])) $post['bill_country_name'] = '';
	if(!isset($post['payment'])) $post['payment'] = '';
	if(!isset($post['bill_fees'])) $post['bill_fees'] = '';
	if(!isset($post['bussiness_url'])) $post['bussiness_url'] = '';
	if(!isset($post['aurl'])) $post['aurl'] = '';
	if(!isset($post['source'])) $post['source'] = '';
	if(!isset($post['status_mem'])) $post['status_mem'] = '';

	$common_input .="
	<div style=display:none>
	<input type='hidden' name='step' value='".@$post['step']."'>
	<input type='hidden' name='fullname' value='".@$post['fullname']."'>
	<input type='hidden' name='bill_email' value='".@$post['bill_email']."'>
	<input type='hidden' name='bill_address' value='".@$post['bill_address']."'>
	<input type='hidden' name='bill_city' value='".@$post['bill_city']."'>
	<input type='hidden' name='bill_state' value='".@$post['bill_state']."'>
	<input type='hidden' name='bill_country' value='".@$post['bill_country']."'>
	<input type='hidden' name='bill_country_name' id=bill_country_name value='".@$post['bill_country_name']."'>
	<input type='hidden' name='bill_zip' value='".@$post['bill_zip']."'>
	<input type='hidden' name='bill_phone' value='".@$post['bill_phone']."'>
	<input type='hidden' name='payment_mode' value='".@$post['payment']."'>
	<input type='hidden' name='bill_fees' value='".@$post['bill_fees']."'>
	<input type='hidden' name='bussiness_url' value='".@$post['bussiness_url']."'>
	<input type='hidden' name='status' value='".(@$post['status_mem']?@$post['status_mem']:@$post['status'])."'>
	<input type='hidden' name='aurl' value='".@$post['aurl']."'>
	<input type='hidden' name='source' value='".@$post['source']."'>
	<input type='hidden' name='actionajax' class='actionajax' value='".((isset($post['actionajax'])&&trim($post['actionajax']))?$post['actionajax']:'')."'>
	<input type='hidden' name='mop' class='mop_ajax_checkout' value='".((isset($post['mop'])&&trim($post['mop']))?$post['mop']:'')."'>
	</div>"; 
	
	if(isset($post['t_name6'])&&strpos($post['t_name6'],'ajaxBin') !== false){
		$common_input .="
		<div style='display:none'>
			<input type='hidden' name='payment_method' id='payment_method' value='".@$post['payment_method']."'>
		</div>"; 
	}
	
	if(isset($data['Error'])&&$data['Error']&&isset($post['submit'])){
		$display_style="style='display:block;'";
	}else {
		$display_style="style='display:none;'";
	}
	?>
	<? if((isset($post['acquirer_id_card'])&&!empty($post['acquirer_id_card'])) || ((@$post['acquirer_id']) && ($_SESSION['post']['ewallets_test_card']==true)  )){?>
				<div class="cover_pay_div" style="position:relative;">
				  <div class="ecard_div evoilatecard_div pay_div p-2">
					<form id="payment_form_id" method="post"  onsubmit="return validateForm(this);" target="payin_win" >
					  <div style="display:none">
						<?=@$common_input;?>
						<input type="hidden" name="acquirer" value=''>
						<input type="hidden" name="cardtype" id="cardtype" value="<?=(isset($post['cardtype'])?$post['cardtype']:'')?>">
					  </div>
					  <div class="credit-card-box label_active rounded pb-1">
                      <div class="flip">
                        <div class="front">
                         
							
                          <!--<div class="number">-->
                            
                            <div class="form-group my-4 " id="card-number-field">
							
<div class="input-field inputWithIcon">
<i id="input-card-icon" class="<?=@$data['fwicon']['credit-card'];?> display-inner"></i>
					<input type="tel" name="ccno" value="<?=(isset($post['ccno'])&&$post['ccno'])?$post['ccno']:"";?>" id="number" class="iconvisa form-control text-muted " pattern=".{16,21}" required  >
                    <label for="number" >Card Number</label>
                  </div>
							</div>
							
                          <div class="clearfix my-2">
						  
						    <div class="float-start input-field" style="width:80px;">
							
                           <select id="expMonth" name="month" class="form-select text-muted" required title="Select Month of Card Expiry" >
								<option value="" disabled="disabled" selected="selected">&nbsp;&nbsp;</option>
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
							<label for="expMonth" translate="no">MM</label>
							<?
							if(isset($post['month'])&&$post['month'])
							{?>
							<script>
							$('#expMonth option[value="<?=@$post['month']?>"]').prop('selected','selected');
							</script>
							<?
							}
							?>
							</div>
							<div class="float-start input-field mx-2" style="width:80px;">
							
                            <select id="expYear" name="year" class="form-select text-muted" required title="Select Year of Card Expiry">
                          <option value="" disabled="disabled"  selected="selected" >&nbsp;&nbsp;</option>
							<?
							for($yy = date('y');$yy<100;$yy++)
							{
							?><option value="<?=@$yy?>"><?=@$yy?></option><? } ?>
                            </select>
							<label for="expYear" translate="no">YY</label>
							<?
							if(isset($post['year'])&&$post['year'])
							{?>
							<script>
							$('#expYear option[value="<?=@$post['year']?>"]').prop('selected','selected');
							</script>
							<?
							}?>
							
							</div>


                            <div class="CVV input-field " style="width:70px;float: right;">
							
                              <input id="cvc" type="password" name="ccvv" maxlength="4"   value="<?=(isset($post['ccvv'])&&$post['ccvv'])?$post['ccvv']:"";?>"  class="form-control text-muted" required  title="It's a 3 digit code printed on the back of your card." >
                            <label for="cvc" translate="no">CVV</label>
							</div>
                          </div>
                        </div>
                      </div>
                    </div>
					  
					
					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'cardEMI') !== false){ ?>
					
					<div class="cardEMI_div ewalist hide">
						<div class="ecol2" style="width: 96%;padding: 0;margin: 0 0 0 10px;">
							<input type="text" name="card_bank_name" class="w94" placeholder="Bank Name" style="margin: 5px 0;" value="<? if(isset($post['card_bank_name'])) echo prntext(@$post['card_bank_name']);?>">
							
						<select class="w94 wDropDown dropDwn required" name="emi_tenure" id="emi_tenure" style="margin:5px 0;">
								<option value="">--Select Tenure--</option>
								<option value="3">3</option>
								<option value="6">6</option>
								<option value="9">9</option>
								<option value="12">12</option>
								<option value="18">18</option>
								<option value="24">24</option>
							</select>
						</div>
					</div>
					<?
					} ?>
					<div class="hide error" id="form-input-errors" <?=@$display_style;?>><?=prntext(@$data['Error'])?></div>
					  
					  <div class="submit_div text-muted m-button clearfix my-4">
					  
						<div class="float-start text-center w-50"><div class="w-100 fw-bold nPay" style="font-size:13px;"><?=@$currency_smbl;?> <?=(@$post['total']?$post['total']:$post['bill_amt'])?></div><div class="account-pop pointer text-link" style="font-size:10px;" title="View Payment Details">View Details</div> </div><button id="cardsend_submit" type="submit" name="send123" value="Change Now"  class="submitbtn btn btn-slide w-50 float-end next"><b class="contitxt">Complete Payment</b></button>
					<? 
					if(isset($_SESSION['action'])&&($_SESSION['action']=="vt" || $_SESSION['action']=="requestmoney")){
						/*
						?>
					<style>
						.submitbck, .submitbtn {width:100% !important;margin:5px 0 !important;}
					</style>
					<button type=button value="BACK" onClick="javascript:goback();" class="submitbck back_button btn btn-primary  left_arrow next"><i></i><b class="contitxt">Back to Merchant Store</b></button>
					<?
					*/
					} else {?>
						<style> 
						#cardsend_submit{/*width:96%;margin: 0 auto;float: none;*/}
						</style>
					<? } ?>
						<script language="javascript" type="text/javascript"> 
							function goback(){	
							// Simulate a mouse click:
							window.location.href = "<?=@$data['Host'];?>/processall<?=@$data['ex']?>?action=vt";
							}
						</script>
					  </div>
					</form>
				  </div>
				  <? } ?>
				  
				  
				  <? if(isset($post['acquirer_id_ewallets'])&&(!empty($post['acquirer_id_ewallets']))||(isset($post['acquirer_id_net_banking'])&&!empty($post['acquirer_id_net_banking']))||(isset($post['acquirer_id_upi'])&&!empty($post['acquirer_id_upi']))){?>
				  <div class="ewallets_div pay_div">
					<form id="payment_form_id_ewallets" name="payment_form_id_ewallets" method="post" onSubmit="return validateForm(this);" target="payin_win">
					  <div class="ecol2" style="width:100%">
						<div style="display:none">
						  <?=@$common_input;?>
						  <input type="hidden" name="acquirer" value="14">
						</div>
						
						<div class="text-center m-2">
							<?
							//Dev Tech : 23-10-16 start universal theme include for common1 ----  
						
							$payin_processing_engine_theme_universal=$data['Path']."/front_ui/default/common/payin_processing_engine_theme_universal".$data['iex'];
							 
							if(file_exists($payin_processing_engine_theme_universal)){
								include($payin_processing_engine_theme_universal);
							}
							
						?>
												
						<?
								//Dev Tech : 23-07-19 start ind theme include for common1 ----  
							
								$payin_processing_engine_theme_ind=$data['Path']."/front_ui/default/common/payin_processing_engine_theme_ind".$data['iex'];
								 
								if(file_exists($payin_processing_engine_theme_ind)){
									include($payin_processing_engine_theme_ind);
								}
							?>	


														
												
						</div>
					</form>
				  </div>
				  <? } ?>
				  
				  </div>
				<? } ?>
			  </div></td></tr>
		</table>
	  </div>
	
	  </div>
	    <? }elseif(isset($post['step'])&&$post['step']==4){?>
	  This email address belong to active merchant, You can not send a payment by using this email address. Please change the email address and try again with the payment method.<br/>
	  <br/>
	  <b><font style="color:red;">Please note:</font> Your card has been not charged for this payment.</b>
	  <? if(isset($_SESSION['sendConfirm'])&&$_SESSION['sendConfirm']) { ?>
	  Your account has been created successfully. <br />
	  A verification link has been sent to your account. <br />
	  Please check your mail and verify your account.
	  <? unset($_SESSION['sendConfirm']); } ?>
	  <? if(isset($_SESSION['sendConfirmemail'])&&$_SESSION['sendConfirmemail']) { ?>
	  Your account has been created successfully. <br />
	  A verification link has been sent to your account. <br />
	  Please check your mail and verify your account.
	  <? unset($_SESSION['sendConfirmemail']); } ?>
	  <? }elseif(isset($post['step'])&&$post['step']==3){?>
	  Your card details are incorrect. Please try again.
	  <? }elseif(isset($post['step'])&&$post['step']==6){?>
	  Due to some merchant issue this transaction is not proceed.
	  <? }elseif(isset($post['step'])&&$post['step']==7){?>
	  Due to some issue this transaction is not proceed.
	  <? } ?>
	  <? if(isset($post['step'])&&$post['step']==5){ ?>
	  <div id="card" class="showfp">
		<input type="hidden" name="cc_payment_mode" value="CC Payment" />
		<input type="hidden" name="payment"  value="creditcard"  />
		<table class="frame" width="100%" border="0" cellspacing="1" cellpadding="4" >
		  <tr><td class="capl" colspan="2"><? if(!isset($post['action'])||$post['action']!='donation'){?>
			  PURCHASE ITEM
			  <? }else{?>
			  MAKE A DONATION
			  <? } ?></td></tr>
		  <tr><td class="field" width="340" nowrap><? if(!isset($post['action'])||$post['action']!='donation'){?>
			  Pay
			  <? }else{?>
			  Donate
			  <? } ?>
			  To:</td>
			<td class="input"><?=prntext(@$post['clients'])?></td></tr>
		  <tr><td class="field" nowrap>Status:</td>
			<td class="input"><font color=#FF0000><b>
			  <? if(!isset($post['status_mem'])||$post['status_mem']==0){?>
			  UNVERIFIED
			  <? }elseif(isset($post['status_mem'])&&$post['status_mem']==1){?>
			  VERIFIED
			  <? }else{?>
			  CERTIFIED
			  <? } ?>
			  </b></font></td></tr>
		  <tr><td class="field" nowrap><? if(!isset($post['action'])||$post['action']!='donation'){?>
			  Product/Service
			  <? }else{?>
			  Donate Towards
			  <? } ?>
			  :</td>
			<td class="input"><?=prntext(@$post['product'])?></td></tr>
		  <tr><td class="field"><? if(!isset($post['action'])||$post['action']!='donation'){?>
			  Bill Amount:
			  <? }else{?>
			  Amount,
			  <?=prntext(@$data['Currency'])?>
			  <? } ?></td>
			<td class="input"><? if(!isset($post['action'])||$post['action']!='donation'){?>
			  <?=prntext(@$data['Currency'])?>
			  <?=prnsumm($post['bill_amt'])?>
			  <? }else{?>
			  <input type="text" name="bill_amt" size="10" maxlength="8" value="<?=prnsumm($post['bill_amt'])?>">
			  <? } ?></td></tr>
		  <? if(!isset($post['action'])||$post['action']!='donation'){?>
		  <? if(isset($post['quantity'])&&$post['quantity']>0){?>
		  <tr><td class="field">Quantity:</td>
			<td class="input"><?=prnintg($post['quantity'])?></td></tr>
		  <? } ?>
		  <? if(isset($post['setup'])&&$post['setup']>0){?>
		  <tr><td class="field">Setup Fee:</td>
			<td class="input"><?=prntext(@$data['Currency'])?>
			  <?=prnsumm($post['setup'])?></td></tr>
		  <? } ?>
		  <? if(isset($post['tax'])&&$post['tax']>0){?>
		  <tr><td class="field">Tax:</td>
			<td class="input"><?=prntext(@$data['Currency'])?>
			  <?=prnsumm($post['tax'])?></td></tr>
		  <? } ?>
		  <? if(isset($post['shipping'])&&$post['shipping']>0){?>
		  <tr><td class="field">Shipping/Handling:</td>
			<td class="input"><?=prntext(@$data['Currency'])?>
			  <?=prnsumm($post['shipping'])?></td></tr>
		  <? } ?>
		  <? if(isset($post['period'])&&$post['period']>0){?>
		  <tr><td class="field">Duration:</td>
			<td class="input"><?=prnintg($post['period'])?>
			  day(s)</td></tr>
		  <? } ?>
		  <? if(isset($post['trial'])&&$post['trial']>0){?>
		  <tr><td class="field">Trial Period:</td>
			<td class="input"><?=prnintg($post['trial'])?>
			  day(s)</td></tr>
		  <? } ?>
		  <? if(isset($post['comments'])&&$post['comments']){?>
		  <tr><td class="field">Description:</td>
			<td class="input"><?=prntext(@$post['comments'])?></td></tr>
		  <? } ?>
		  <? } ?>
		  <tr><td class="field">Transection Fee:</td>
			<td class="capc" style="text-align:left"><?=prntext(@$data['Currency'])?>
			  <?php echo ($post['total']/100)*1;?></td></tr>
		  <tr><td class="field">Total Product Bill Amount:</td>
			<td class="capc" style="text-align:left"><?=prntext(@$data['Currency'])?>
			  <?=prnsumm($post['total'])?></td></tr>
		  <tr><td class="field">Total Paid:</td>
			<td class="capc" style="text-align:left"><?=prntext(@$data['Currency'])?>
			  <?php echo $post['total']+(($post['total']/100)*$data['PaymentPercent']); ?></td></tr>
		  <tr><td class="capr" colspan="2"></td></tr>
		  <tr><td class="capl" colspan="2">Credit Card Information</td></tr>
		  <? if(isset($data['Error'])&&$data['Error']){?>
		  <tr><td colspan=2 class="error"><?=prntext(@$data['Error'])?></td></tr>
		  <? } ?>
		  <tr><td class="field" style="width:330px;">Credit Card Holder Name.:</td>
			<td class="input"><input type="text" name="fullname" size="30" maxlength="128" value="<? if(isset($post['fullname'])) echo $post['fullname']?>">
			</td></tr>
		  <tr><td class="field" style="width:330px;">Credit Card No.:</td>
			<td class="input"><input type="text" name="ccno" maxlength="24" size="30" value="<? if(isset($post['cnumber'])) echo $post['cnumber']?>">
			</td></tr>
		  <tr><td class="field">CVC:</td>
			<td class="input"><input type="password" name="ccvv" maxlength="4" size="30" value="<? if(isset($post['ccvv'])) echo $post['ccvv']?>"></td></tr>
		  <tr><td class="field">Exp Date:</td>
			<td class="input"><select name="month" id="exMonth" style="min-width:100px;">
					<option value="01">January</option>
					<option value="02">February</option>
					<option value="03">March</option>
					<option value="04">April</option>
					<option value="05">May</option>
					<option value="06">June</option>
					<option value="07">July</option>
					<option value="08">August</option>
					<option value="09">September</option>
					<option value="10">October</option>
					<option value="11">November</option>
					<option value="12">December</option>
				</select>
				<?
				if(isset($post['month'])&&$post['month'])
				{?>
				<script>
				$('#exMonth option[value="<?=@$post['month']?>"]').prop('selected','selected');
				</script>
				<?
				}
				?>
				<select name="year" id="exYear" style="min-width:100px;">
				<?
				for($yy = date('y');$yy<(date('y')+20);$yy++)
				{
				?>
					<option value="<?=@$yy?>"><?=@$yy?></option>
				<?
				} ?>
				</select>
				<?
				if(isset($post['year'])&&$post['year'])
				{?>
				<script>
				$('#exYear option[value="<?=@$post['year']?>"]').prop('selected','selected');
				</script>
				<?
				} ?>
			</td></tr>
		  <tr><td class="field">Email ID:</td>
			<td class="input"><input type="text" name="email" size="30" maxlength="128" value="<? if(isset($post['bill_email'])) echo $post['bill_email']?>"></td></tr>
		  <tr><td class="field">Re-enter Email ID:</td>
			<td class="input"><input type="text" name="email_re_enter" size="30" maxlength="128" value="<? if(isset($post['email_re_enter'])) echo $post['email_re_enter']?>"></td></tr>
		  <tr><td class="capl" colspan="2">Billing Information</td></tr>
		  <tr><td class="field">Name:</td>
			<td class="input"><input type="text" name="bill_name" size="30" maxlength="128" value="<? if(isset($post['bill_name'])) echo $post['bill_name']?>"></td></tr>
		  <tr><td class="field">Bill address:</td>
			<td class="input"><input type="text" name="bill_address" size="30" maxlength="128" value="<? if(isset($post['bill_address'])) echo $post['bill_address']?>"></td></tr>
		<?/*?>  
		  <tr><td class="field">Street 2:</td>
			<td class="input"><input type="text" name="bill_street_2" size="30" maxlength="128" value="<? if(isset($post['bill_street_2'])) echo $post['bill_street_2']?>"></td></tr>
		<?*/?>
		  <tr><td class="field">City:</td>
			<td class="input"><input type="text" name="bill_city" size="30" maxlength="128" value="<? if(isset($post['bill_city'])) echo $post['bill_city']?>"></td></tr>
		  <tr><td class="field">State:</td>
			<td class="input"><!--<input type="text" name="bill_state" size="30" maxlength="128" value="<//?=$post['bill_state']?>">-->
			  <select name="bill_state" style="width:100px;"></select>
			  
			</td></tr>
		  <tr><td class="field">Zip:</td>
			<td class="input"><input type="text" name="bill_zip" size="30" maxlength="128" value="<? if(isset($post['bill_zip'])) echo $post['bill_zip']?>"></td></tr>
		  <tr><td class="field">Phone:</td>
			<td class="input"><input type="text" name="bill_phone" size="30" maxlength="128" value="<? if(isset($post['bill_phone'])) echo $post['bill_phone']?>"></td></tr>
		  <tr><td class="capc" colspan=2><? if(isset($post['step'])&&$post['step']==1){?>
			  <input class="submit" type="button" value="BACK" onClick="document.location.href='<? if(isset($post['ucancel'])) echo $post['ucancel']?>'">
			  &nbsp;
			  <? } ?>
			  <input class="submit" type="submit" name="integration-type" value="CONTINUE">
			</td></tr>
		</table>
	  </div>
	  <? } ?>
	  
<?php /*?>=======For Generate default Qr Code for display in UPI =========<?php */?>
<? 
/*
$qr_pa="7065491021@paytm";
$qr_pn="1111";
$qr_tr="1111";
$qr_cu=@$post['curr']?$post['curr']:@$_SESSION['curr'];
$qr_am=@$post['total']?$post['total']:@$post['bill_amt'];

$url_qr = "upi://pay?pa=$qr_pa&pn=$qr_pn&tr=$qr_tr&cu=$qr_cu&am=$qr_am"; // Hardcoading Dummy Data
$url_qr = urlencode($url_qr);
*/
?>
<div class="display_qr_on_upi hide"><img src="https://quickchart.io/chart?chs=150x150&cht=qr&chl=<?=@$url_qr;?>&choe=UTF-8"></div>
<?php /*?>===================================<?php */?>
	  
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
<script src="<?=@$data['Host'].'/js/jquery.payform.min.js'?>" charset="utf-8"></script>


<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'ajaxBin') !== false){?>
<script language="javascript" type="text/javascript"> 
ajaxBinVar=1;
//alert("ajaxBin=>ok");
function ajaxBinCf(theBinNo)
{
	var url_bin="<?=@$data['Host']?>/third_party_api/apibinRespose.do?josn=1&cb="+theBinNo;
	if(wn){
		nw(url_bin);
	}
	
	$.ajax({
		url: url_bin,
		type: 'POST',
		dataType: 'json', 
		data:{action:"ajaxBin", cb:theBinNo},
		success: function(data){
			//myObj = JSON.parse(data);
			//alert(JSON.stringify(data));
			if(data["type"]){
				//alert("cards type => "+data["cards"]["type"]);
				if($('#payment_method')){
					$('#payment_method').val(data["type"]);
				}
			}else{
				$('#payment_method').val('');
				//alert("Opps: "+JSON.stringify(data)+" , BinNo.=> "+theBinNo);
			}
			
		}
	});

}	
</script>
<? } ?>

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
var cardLength=19;
var setCardLength_allcard=19;
var setCardLength_amex=18;
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
				  if( ($.inArray(cardNumber.val().replace(/\s+/g, ''), jsTestCardNumbers ) === -1) && ($.inArray(cardNumber.val().replace(/\s+/g, '').substring(0, 6), jsLuhnSkip ) === -1)  ) {
					//alert("Msg1=>"+$('.alert_msg_2').text());
					alert($('.alert_msg_2').text());
				  }
				}
			}
			var g_card_name=$.payform.parseCardType(cardNumber.val());
			cardNumber.attr('class','form-control');
			$('#input-card-icon').attr('class','');
			//alert(g_card_name);
			
			if(g_card_name=="mastercard"){
				$('#input-card-icon').attr('class','<?=@$data['fwicon']['mastercard_code'];?> text-danger');
			
			}else if(g_card_name=="visa"){
				$('#input-card-icon').attr('class','<?=@$data['fwicon']['visa_code'];?> text-info');
			
			}else if(g_card_name=="amex"){
				$('#input-card-icon').attr('class','<?=@$data['fwicon']['amex_code'];?> text-info');
			
			}else if(g_card_name=="rupay"){ 
				$('#input-card-icon').attr('class','');
				cardNumber.attr('class','form-control icon'+$.payform.parseCardType(cardNumber.val()));
			
			}else if(g_card_name=="discover"){
				$('#input-card-icon').attr('class','<?=@$data['fwicon']['discover_code'];?>');
			
			}else if(g_card_name=="jcb"){
				$('#input-card-icon').attr('class','<?=@$data['fwicon']['jcb_code'];?> text-success');
			
			}else if(g_card_name=="dinersclub"){
				$('#input-card-icon').attr('class','<?=@$data['fwicon']['diners_code'];?> text-danger');
			
			}else{
				$('#input-card-icon').attr('class','<?=@$data['fwicon']['credit-card'];?>');
			}
			
			//cardNumber.attr('class','11 form-control icon'+$.payform.parseCardType(cardNumber.val()));
			// block card details  on 24012023
			
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
		
		   var card_trim=cardNumber.val();
			 card_trim = card_trim.replaceAll(" ", "");
			 
		if(card_trim.length === cardLength || card_trim.length == cardLength) {
			//$('#form-input-errors').text("");
			//$('#form-input-errors').css('display','none');	
			//alert(99999999999999999999999999);
			expMonth.focus();
		}else if(card_trim.length < 13 ) {
			$('#number').focus();
		}
		

		
		$('#credit_cards img').addClass('transparent');

		$('#credit_cards span').addClass('transparent');
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
		
		var channelVar= $('.account_types.active').attr('data-channel');
		if(channelVar==3){
			var mopVar = 'DC';
		}
		else {
			var mopVar = 'CC';
		}
		
		//alert("channelVar=> "+channelVar+", mopVar=> "+mopVar); return false;
		
		var isCardValid = $.payform.validateCardNumber(cardNumber.val());
		var isCvvValid = $.payform.validateCardCVC(CVV.val());
		
		var ewlistVar= $('.account_types.active').attr('data-ewlist');

		if ( card_validation == 'yes' ) {

			if( (cardNumber.val().length === cardLength) && ( ($.inArray(cardNumber.val().replace(/\s+/g, ''), jsTestCardNumbers ) === -1) && ($.inArray(cardNumber.val().replace(/\s+/g, '').substring(0, 6), jsLuhnSkip ) === -1)  ) ){
					 var val = $.payform.parseCardType(cardNumber.val());
					 var ccn_match = ccn_var.match(new RegExp(val, 'i'));
					 if(ccn_match){
						//alert('ccn_match'+"\r\n"+ccn_var);
					 }else{					
						//alert('No Payment Chanel Available to process this card');
						//alert("Msg2=>"+$('.alert_msg_2').text());
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
			
                //alert("submit0000");

				$("#cardsend_submit .contitxt").html("<i class='<?=@$data['fwicon']['spinner'];?> fa-spin-pulse'></i> ");
				$("#cardsend_submit").prop('disabled', true);
				
				

				//top.window.openFullscreen_2();

				$form.append('<input type="text" name="integration-type" style="display:none"  value="CHECKOUT" />');

				//$('#modalpopup_form_popup').slideDown(900);
				//alert("Other Acc.="+$('#payment_form_id input[name="acquirer"]').val());
				
				if( (ewlistVar !== undefined) && (ewlistVar) && (ewlistVar.match('noajax|redirect|newtab')) && ($.inArray(cardNumber.val().replace(/\s+/g, ''), jsTestCardNumbers ) === -1)  )
				{
					pendingCheckStartf('reStart'); 
					$form.get(0).submit();
				}
				else {
					//alert("card_validation1=> "+card_validation+", ewlistVar=> "+ewlistVar);
					ajaxFormf(channelVar, mopVar, 'payment_form_id'); return false;
				
				}
				
				//pendingCheckStartf('reStart'); $form.get(0).submit();
				
			}
		} else {
			 
			$("#cardsend_submit .contitxt").html("<i class='<?=@$data['fwicon']['spinner'];?> fa-spin-pulse'></i> ");
			$("#cardsend_submit").prop('disabled', true);
             $('#modalpopup_form_popup').slideDown(900);

			$form.append('<input type="text" name="integration-type" style="display:none"  value="CHECKOUT" />');
				
				
			//alert("Other Acc.="+$('#payment_form_id input[name="acquirer"]').val());
			
			if( (ewlistVar !== undefined) && (ewlistVar) && (ewlistVar.match('noajax|redirect|newtab')) && ( $.inArray(cardNumber.val().replace(/\s+/g, ''), jsTestCardNumbers ) === -1 )  )
			{
				pendingCheckStartf('reStart'); 
				$form.get(0).submit();
			}
			else {
				
				//alert("card_validation2=> "+card_validation+", ewlistVar=> "+ewlistVar);
				
				ajaxFormf(channelVar, mopVar, 'payment_form_id'); return false;
			}
				
			//pendingCheckStartf('reStart'); $form.get(0).submit();
			
		}
		e.preventDefault();
		}
		catch(err) {
		  alert('cardPayment=>'+err.message);
		  //document.getElementById("demo").innerHTML = err.message;
		}
	});
	
	function checkValidity_tr_f(thaCond=''){
	 try {
		 //alert('11111111');
		 var hasInput=false;
		 
		 if(thaCond=='hideCloseButton'){
			 $('.modal_msg.active .modal_msg_close').hide();
			 $('.modal_msg.active .modal_msg_close2').hide();
		 }
		 
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
				if($('.modalMsgContTxt div').hasClass('bankStatus')){
					setTimeout(function(){ 
						$('.bankStatus').show(1000);
						$('.redirectBankPage').hide(500);
					}, 10000); // after
				}
				
		  } 
		}
		catch(err) {
		  alert('checkValidity=>'+err.message);
		}
	} 
	
$('#payment_form_id_ewallets').submit(function(e) { 
	try {
		var $form = $('#payment_form_id_ewallets');
		$form.append('<input type="text" name="integration-type" style="display:none"  value="CHECKOUT" />'); 
		
		var channelVar= $('.account_types.active').attr('data-channel');
		if(channelVar==6){
			var mopVar = 'NB';
		}
		else if(channelVar==9){
			var mopVar = 'UPICOLLECT';
		}
		else if(channelVar==10){
			var mopVar = 'QRINTENT';
		}
		else {
			var mopVar = 'WALLET';
		}
		
		var ewlistVar= $('.account_types.active').attr('data-ewlist');
		
		/***== popup position control for center wise	==*/
		var submitmsgVar= $('.account_types.active').attr('data-submitmsg');
		var dataStyle=$('.'+submitmsgVar+'_div').attr('data-style');
		$('.modal_msg_body').attr('style','');
		if(dataStyle !== undefined){
			$('.modal_msg_body').attr('style',dataStyle); 
		}
		
		//alert(ewlistVar);
		
		/*if( ($('.account_types').hasClass('active')) && (ewlistVar !== undefined) && (ewlistVar) && (ewlistVar.match('qrcodeadd|qracq_')) ){ 
			generate_qr_codef();
			return false;
		}
		else */
		if( ($('.account_types').hasClass('active')) && (ewlistVar !== undefined) && (ewlistVar) && (ewlistVar.match('appIntent_submitMsg|appIntent_')) && ( $('.mop_ajax_checkout').val()==='QRINTENT') ){
			if( $('.actionajax').val()==='ajaxIntentArrayUrl') {
				generate_intent_array_urlf();
			}
			else {
				generate_intent_urlf();
			}
			return false;
		}
		else if(($('.account_types').hasClass('active')) && (submitmsgVar !== undefined) && (submitmsgVar) && (submitmsgVar == 'intent_submitMsg') && ( $('.submitMsg').hasClass(submitmsgVar+'_div') )  ){
			//alert(submitmsgVar);
			
			/*
			$('#payment_form_id_ewallets').attr('target','payin_win');
			
			$('#modal_msg_body_div').html($('.'+submitmsgVar+'_div .modalMsgCont').html()); 
			$('#modal_msg').show(100);
			
			
			if($('#modal_msg').hasClass('active')){
				//return true;
			}else{ 
				//cmn
				
				$('#modal_msg').addClass('active');
				return false;
			}
			*/
		}
		else if($('#payment_form_id_ewallets').hasClass('nextTabTr')){
			if($('div').hasClass('modal_msg_body')){
			  $('#modal_msg_body_div').html($('.msgNextTabTrDiv').html()); 
			  $('.modal_msg_body').attr('style','');
			}
		} else {
			$('#modalpopup_form_popup').slideDown(900);
		}
		
		/*
		if( ($('.account_types').hasClass('active')) && (submitmsgVar !== undefined) && (submitmsgVar) && (submitmsgVar == 'intent_submitMsgOffPopuMsgInMobile')  ){
			$('#payment_form_id_ewallets').attr('target','_top');
		}
		*/
		
		//transID='';varTransID='';
		//$('#payment_form_id_ewallets').attr('target','payin_win');
		
		if( (ewlistVar !== undefined) && (ewlistVar) && (ewlistVar.match('noajax|redirect|newtab'))  )
		{
			pendingCheckStartf('reStart'); 
			$form.get(0).submit();
		}		
		else {

			ajaxFormf(channelVar, mopVar, 'payment_form_id_ewallets'); return false;
		}
		e.preventDefault(); 
	}
	catch(err) {
	  alert('ewallets=>'+err.message);
	}
});
	
	
	
	$('#payment_form_id_ngBankTransfer').submit(function(e) {
		var $form = $('#payment_form_id_ngBankTransfer');
		$form.append('<input type="text" name="integration-type" style="display:none"  value="CHECKOUT" />');
		$('#modalpopup_form_popup').slideDown(900);
		$form.get(0).submit();
		e.preventDefault();
	});
	
	$('#payment_form_id_ebanking').submit(function(e) {
		var $form = $('#payment_form_id_ebanking');
		$form.append('<input type="text" name="integration-type" style="display:none"  value="CHECKOUT" />');
		$('#modalpopup_form_popup').slideDown(900);
		$form.get(0).submit();
		e.preventDefault();
	});
	
	$('#payment_form_id_bhimupi').submit(function(e) {
		var $form = $('#payment_form_id_bhimupi');
		$form.append('<input type="text" name="integration-type" style="display:none"  value="CHECKOUT" />');
		$('#modalpopup_form_popup').slideDown(900);
		$form.get(0).submit();
		e.preventDefault();
	});

$(document).ready(function(){ 
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
		
		
		
		if(ajaxBinVar){
			ajaxBinCf(cardNumber.val().replace(/\s+/g, '').substring(0, 6));
		}
		
		//alert(cardNumber.val().replace(/\s+/g, '').substring(0, 6));
				
	}
	
	$('.modal_msg_close , .modal_msg_close3 , .modal_msg_close2').click(function(){
		modal_msg_close();
	});
	//modal_msg_close
	
	$('.upi_qr_border,.upi_qr_border_div').click(function(){
		if(!$(this).hasClass('active')){
			generate_qr_codef();
		}
    });
	
	$('.paid_qrcode_link').click(function(){
		//alert('transID=>'+transID+', varTransID:=>'+varTransID);
		//fetch_trnsStatusf(varTransID,'paidCheck');
		$('.paid_qrcode_link').attr('onclick',"fetch_trnsStatusf('"+varTransID+"','paidCheck')");
    });	
	
	$('.paid_upiIntent_link').click(function(){
		//alert('transID=>'+transID+', varTransID:=>'+varTransID);
		//$('.paid_upiIntent_link').attr('onclick',"fetch_trnsStatusf('"+varTransID+"','paidCheck');modal_msg_close();");
    });

});
//$(".account_types").eq(0).trigger("click"); //send

function modal_msg_close(){
	$('#modal_msg').hide();
	$('#modal_msg').removeClass('active');
	$('.modal_msg_body').removeAttr('style');
	spinner_hide_f();
	//alert('666666');
}

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
$form.append('<input type="text" name="integration-type" style="display:none"  value="CHECKOUT" />');
$("#cardsend_submit .contitxt").text('Please wait ...');
//$form.get(0).submit();
</script>

<? } ?>


		</div>
	
	</div> <!-- payEEED paymentContainerDiv -->
	


			
<div class="toast toast-box hide" role="alert" aria-live="assertive" aria-atomic="true">
  <div class="toast-header"> <strong class="me-auto">View Details</strong>
    <button type="button" class="btn-close toast_button" data-bs-dismiss=".toast-box" aria-label="Close"></button>
  </div>
  <div class="toast-body">
    <? if(isset($_SESSION['bearer_token_id']) && $_SESSION['bearer_token_id'] ) { ?>
    <div class="text-muted fw-bold mx-2 fs10">Bearer Token : <? echo $_SESSION['bearer_token_id']?> </div>
    <? } ?>
    <div class="fullNmBar">
      <? if(isset($post['fullname']) && $post['fullname'] ) { ?>
      <i class="<?=@$data['fwicon']['profile'];?> px-2 py-1 fa-fw"></i>&nbsp;&nbsp;<? echo $post['fullname']?>
      <? } ?>
    </div>
    <div class="emailBar">
      <? if(isset($post['bill_email']) && $post['bill_email'] ) { ?>
      <i class="<?=@$data['fwicon']['email'];?> px-2 py-1 fa-fw"></i>&nbsp;&nbsp;<? echo $post['bill_email']?>
      <? } ?>
    </div>
    <div class="mobileBar">
      <? if(isset($post['bill_phone']) && $post['bill_phone'] ) { ?>
      <i class="<?=@$data['fwicon']['mobile'];?> px-2 py-1 fa-fw"></i>&nbsp;&nbsp;<? echo $post['bill_phone']?>
      <? } ?>
    </div>
    <? if(isset($post['bill_address']) && $post['bill_address'] ) { ?>
    <div class="text-muted fw-bold mx-2 fs10">Address : <? echo @$post['bill_address']?> <? echo @$post['bill_city']?> <? echo @$post['bill_state']?> <? echo @$post['bill_country']?> </div>
    <? } ?>
    <?php /*?> <? if(isset($post['product_name'])&&$post['product_name']){ ?>			
<div class="my-2 text-center"><span class="text-muted fw-bold">Payment for <?=@$post['product_name'];?></span></div>
<? } ?><?php */?>
  </div>
</div>
<div class="toast bill_amt-toast-box hide" role="alert" aria-live="assertive" aria-atomic="true">
  <div class="toast-header"> <strong class="me-auto">Order Summary</strong>
    <button type="button" class="btn-close toast_button" data-bs-dismiss=".bill_amt-toast-box" aria-label="Close"></button>
  </div>
  <div class="toast-body">
    <table class="table">
      <tbody>
        <tr class="fw-lighter">
          <td>Bill Amount</td>
          <td class="text-end px-2"><?=@$post['curr']?$post['curr']:$_SESSION['curr'];?>
            <?=(@$post['total']?$post['total']:$post['bill_amt'])?></td>
        </tr>
        <tr>
          <td>Total Amount</td>
          <td class="text-end px-2"><?=@$post['curr']?$post['curr']:$_SESSION['curr'];?>
            <?=(@$post['total']?$post['total']:$post['bill_amt'])?></td>
        </tr>
      </tbody>
    </table>
  </div>
</div>
<footer class="footer mt-auto">
  <div class="container-flex">
    <div class="b-example-divider align-middle p-2 rounded-bottom" style="height:auto !important;float:left;width:100%;">
      <div class="float-start account-pop pointer py-2 mt2px" title="View Details">View Details <i class="<?=@$data['fwicon']['angle-up'];?> align-middle mx-1"></i></div>
      <div class="float-end py-2 mt2px">Powered by 
	  <? 
	$poweredby="";
	
	// $_SESSION['domain_server']['subadmin']['domain_name'] use for display domain 
	if(isset($_SESSION['domain_server']['as']['SiteName'])&& $_SESSION['domain_server']['as']['SiteName']){
	$poweredby.='<span class="font-monospace fw-bold">'.prntext(@$_SESSION['domain_server']['as']['SiteName']).'<span>';
	}
	
	
	if(isset($_SESSION['domain_server']['subadmin']['upload_logo'])&& $_SESSION['domain_server']['subadmin']['upload_logo']){ 
	$poweredby.='<img src="'.encode_imgf($_SESSION['domain_server']['LOGO']).'" class="logo-img rounded" alt="Logo" style="max-height: 20px;"/>';
	}
	
	?>
	<?=@$poweredby;?> &nbsp;
      </div>
    </div>
  </div>
</footer>

<script>
$(document).ready(function(){ 

    // For Show account tost box 
	$('.account-pop').on('click', function () { 
		$(".toast-box").toggle();
    });
	
	// For Show bill_amt tost box 
	$('.bill_amt-pop').on('click', function () { 
		$(".bill_amt-toast-box").toggle();
    });
	
	$('.toast_button').click(function(){
		var fdata = $(this).attr("data-bs-dismiss");
		$(fdata).hide();
    });
	
	$(".view_all_upi").click(function(){
		$(".view_all_upi").hide();
		$(".view_upi").toggle();
    });
	
	// For i have paid button refresh
	
	$(".button_refresh").click(function(){
		
		    $('.button_refresh').html('<i class="fa-solid fa-spinner fa-spin-pulse text-success"></i>');
			
			setTimeout(
            function() 
            {
            $('.button_refresh').html('I have paid');
            }, 1000);
    });

	
    // For Hide language translator loader 
   setTimeout(function(){
	   $(".skiptranslate").next().css( "display", "none" );
	   let head = $(".skiptranslate").contents().find("head");
	   let css = '<style> .indicator{ padding-right: 5px !important;} </style>';
	   $(head).append(css);
   },2000); 
   
   $("#field").keypress(function(e) {
    if (!valid)
        e.preventDefault();
   });
   
});  
   



</script>

	
	</div>
	
	

	
	
</div>



<?//Dev Tech : 23-07-07 Popup for pending message  ?>
<div class="modalpopup_processing hide" id="modalpopup_processing_for_pending" style="position:relative;z-index:999999;" >
	<div class="position-absolute1 buttom-50 start-50 translate-middle" style="min-width: 375px;max-width:400px;margin:0 auto;position: fixed;bottom:0;z-index:999;">
	  <div class="modalpopup_form_popup_layer"> </div>
	  
	  <div class="modalpopup_form_popup_body row bg-light" style="top:-240px;">
	  
	  <a class="close_popup modal_popup_close processing_close" onClick="document.getElementById('modalpopup_processing_for_pending').style.display='none';" style="color:#000!important;background:#fff;right: 10px;top:0px;position:absolute;z-index:999999;border:0px solid #ff0000;">×</a>
	  
		<div id="modalpopup_processing_for_pending_div" class="row p-0" >
		 
		    
		    <div class="sploop hide1">
			  <div class="row1 center">
				<i class="fa-solid fa-spinner fa-spin-pulse fa-2x text-loader"></i>
			  </div>
			  <div class="row">
				<p class="hide"  style="font-size:16px;font-weight:bold;color:#3f3f3f;float: left;width:100%;clear:both;line-height:30px;padding:0px 0 0 0;">Processing for pending payment...</p>
				<p class="pen_bod1 bg-light" style="font-size:12px;font-weight: normal;color:#3f3f3f;float:left;width:100%;clear:both;line-height: 14px;">This will take a few seconds</p>
				<p class="pen_bod"> </p>
				
			  </div>
			</div>
			
			
			
			
		</div>
		
	  </div>
  </div>
</div>



<?//Dev Tech : 23-07-07 Popup for processing message  ?>
<div class="modalpopup_processing hide" id="modalpopup_processing">
	<div class="position-absolute1 buttom-50 start-50 translate-middle" style="min-width: 375px;max-width: 400px;margin:0 auto;position: fixed;bottom: 0;">
	  <div class="modalpopup_form_popup_layer"> </div>
	  
	  <div class="modalpopup_form_popup_body row">
	  
	  <a class="close_popup modal_popup_close processing_close" onClick="document.getElementById('modalpopup_processing').style.display='none';" style="color:#000!important;background:#fff;left: 10px;top:-40px;position:absolute;z-index:999999;right:unset;">×</a>
	  
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
</div>


