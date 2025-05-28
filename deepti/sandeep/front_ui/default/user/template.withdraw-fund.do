<? if(isset($data['ScriptLoaded'])){
	$gpost=($_SESSION['uid_'.$_SESSION['uid']]);
	
###############################################################################
//Date of Modify : 26-11-2021 by Vikash
###############################################################################

?>
<style>
.betaVersion{height:77px;position:absolute;margin:-18px 0 0 -38px;z-index:9;left:50%;}
	
.input_col_1 input.checkbox {width:24px;position:relative;top:-9px;}
.input_col_1 .radios label {width: auto;}
.separator {/*margin:0px 0;display:block;clear:both;*/}
.remarkcoment{/*width:100% !important;min-height:60px !important;*/}

label{/*font-weight:bold;color:#000;*/}

.bank_radio {margin:0px 0 0 0!important;} 
.bTypeDiv{/*text-align:center;width:280px;display:block;margin:0 auto;background:#ccc;float:none;height:30px;padding:5px 15px;border-radius:3px;clear:both;border:1px solid #ececec;border-radius:4px;background: rgb(2,0,36);*/
/*background: linear-gradient(95deg, #059dff 15%, #6549d5 45%, #e33fa1 75%, #fb5343 100%) 98%/200% 100%;*/}
.bank_accord{/*width:92%!important;clear:both;float:left;border:1px solid #ececec;margin:5px 0;border-radius:4px;padding:0 13px;background: rgb(2,0,36);*/ background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(238,238,238,1) 0%, rgba(255,255,255,1) 30%, rgba(255,255,255,1) 70%, rgba(238,238,238,1) 100%);}
.widget-body.input_col_1 .span12 .bank_accord .bank_name label {/*width:80% !important;font-weight: normal;*/}
.bank_name{width:100%;}

.modalMsgContTxt{padding:10px 20px}
.modalMsgContTxt h4{margin:10px 0px}
.modalMsgContTxt p{font-size:16px;margin:10px 0 10px 0}

.submit_div{padding:0;height:50px;text-align:center;width:auto;float:none;display:inline-block}
/*#b_submit,#b_next,.submit_next, .backBtn {width:110px !important;margin:0;float:none;padding:11px 0;font-size:24px;height:40px}*/

.glyphicons.eye_open i:before {left:11px;top:6px;font-size:16px;}
.bank_details_col{/*width:30px;display:inline-block;padding:0 3px;background:#e1dede;line-height:28px;text-align:center;border-radius:3px;font-size:14px;margin:0 0 0 7px*/}

.modalpopup_cdiv td{border:0!important;padding:1px 5px;font-size:14px!important}
.modalpopup_body{border:2px solid #e37c18;width:500px;margin:-195px 0 0 -250px;}
.modalpopup_cdiv{float:left;width:96%;margin:3%;background:#fff;overflow:auto;max-height:366px} 

.g .w30{float:left;padding:0;display:table-cell;width:calc(30% - 6px)!important;margin:0;clear:left;}
.g .w70{float:left;padding:0;display:table-cell;width:calc(70% - 6px)!important;margin:0}


.g .w30{width:190px !important;}
.g .w70{width:130px !important;clear:right;}
.calculate_div_id{/*width:100%!important;display:block!important;margin:20px auto!important;*/}
.input_col_1 label {width:100%;}
.paySumAmt{font-size:40px;/*line-height:40px;display:block;height:auto;*//*margin:10px 0 10px;width:100%*/}
.mfa_selectedBank .paySumAmt{font-size:18px;width:auto;display:inline-block;margin:0}


.mobileLayout {/*float:none;display:block;width:320px;margin:10px auto;background:#fff;*/}
.paySum {/*text-align:right;margin-top:20px;*/} 

.selectOption {/*width:100%!important;line-height:40px;padding:3px 10px;height:50px!important;font-size:16px;font-weight:bold;*/text-transform: capitalize;}
.selectOption option {/*width:100%!important;line-height:40px;padding:3px 10px;font-size:14px;*/}

<? if($post['step']==3){?>
	.mobileLayoutDiv{width:755px;float:none;display:table;margin:0 auto;border:1px solid #ccc;border-radius:5px;}
	.mobileLayout.col1{/*display:table-cell;float:none;width:400px;padding:15px;margin:0 5px 0 0;vertical-align:middle;border-radius:3px;background: rgb(2,0,36);
background: linear-gradient(180deg, rgba(2,0,36,1) 0%, rgba(238,238,238,1) 0%, rgba(255,255,255,1) 30%, rgba(255,255,255,1) 70%, rgba(238,238,238,1) 100%);*/}
	.mobileLayout.col2 {/*float:left;width:320px;padding:0 10px;*/}

	@media (max-width:1023px){ 
		.mobileLayoutDiv{width:320px;margin:0 auto;}
		.mobileLayout.col1{/*display:block;margin:0 0 0 0;*/}
		.mobileLayout.col2{display:block;float:none;}
	}
  <? }?>
  

@media (max-width:1024px){ 
	.mobileLayoutDiv{/*width:320px;margin:0 auto;*/}
	.bank_accord {/*width: 91% !important;clear:both;*/} 
	.modalpopup_body{position:fixed;width:90%!important;display:block;margin:0 auto!important;float:none;left:5%;top:50%;height:inherit;margin-top:-195px!important}
}

@media (max-width:760px){ 
	 #receiver_user_id {width:98% !important;}
	 .input_col_1 label {width: 55%;margin-top:0;margin-bottom:0;}
	 #amount_id {/*width:97% !important; margin:0 auto;margin-bottom:10px;float:left;*/}
	 .glyphicons.btn-action i::before{top:0 !important;left:55% !important;}
	 label[for="settlement_fixed_fee"]{width:75% !important;}
	 label[for="requested_currency_id"]{margin-top:20px !important;}
	 /*label[for="amount_cnvrt"]{width:60% !important;}*/ 
	 label[for="amount_id"]{width:98%;}
}
@media (max-width:675px){ 
	  #amount_id {/*width:95% !important; margin:0 auto;margin-bottom:10px;float:left;*/}
}
@media (max-width:600px){ 
	 .input_col_1 label {width: 98%;margin-top:0;margin-bottom:0;}
	  #amount_id {/*width:95% !important; margin:0 auto;margin-bottom:10px;float:left;*/} 
	  
	body .modal_mfa_msg_body{width:312px;height:400px;margin:-200px 0 0 -156px} 
	html body .key_input{width:32px!important;min-width:32px;height:54px!important;line-height:54px}
} 


@media (max-width:440px){ 
	#CryptoWallet_id{clear:left;}
	.mobileLayoutDiv, .mobileLayout{/*width:90%!important;*/}
	.bTypeDiv {/*width:89%;height:auto !important;float:left !important;margin:0 !important;*/}
	.g .w30, .g .w70 {width:99% !important;display:contents;}
}
</style>
<script>
var subQueryString="";
var amountCh="";	
<? if (isset($_SESSION ['adm_login']) && isset ( $_GET ['admin'] ) && $_GET ['admin']) {
		$s_query=http_build_query($_GET);
	?>
	subQueryString="&"+"<?php echo $s_query;?>";		
<? } ?>

var wn='';
consub=0;
var bankCountNo='';
var bankVal='';
$(document).ready(function(){
	
	
	

	$('.bank_details_col').click(function(){
		var countNo=$(this).attr('data-count');
		
		var bankHtml=$('.bank_count_'+countNo).find('.bank_accord_div_table').html();
		//$('#modalpopup_cdiv').html(bankHtml);
		//$('#modalpopup').slideDown(1000);
		
		var Modtitle="Account Details";
		$('#myModal .modal-dialog').css({"max-width":"600px"});
		$('#myModal .modal-content').addClass("bg-primary text-white");
		$('#myModal .modal-title').html(Modtitle);
		$('#myModal .modal-body').html(bankHtml);
		$('#myModal').modal('show');
	});
	
	$('.bank_accord').click(function(){
		
		var thisCheck = $(this).find(".bank_input").val();
		
		//alert('\r\n thisCheck: '+thisCheck);
		
		if($(this).find(".bank_input").hasClass('bank_2')){
			bankCountNo=$(this).attr('data-count');	
			$(this).find(".bank_input").prop('checked', true);
		}else{
			$(this).find(".bank_input").prop('checked', false);
			alert("We cannot process withdrawal for:\r\n \"" +$(this).find('label b').text()+ "\" \r\nKindly contact to support for further information\r\n");
			return false;
		}
		
		
		if($(this).hasClass('active')){
			
		}else{
			$('.bank_accord').removeClass('active');
			
			
			
			var rcb=$(this).next().find('.required_currency_bank').text();
			
			//$('#noteId').removeAttr("name");
			
			$('table #noteId').attr("name","notes1");
			
			//$("table #noteId").each(function() { $(this).removeAttr("name"); });
			
			$(this).next().find('.bank_accord_div_textArea').show();
			$(this).next().find('#noteId').attr("name","note");
			
			
			$('#requested_currency_id option').removeAttr('selected');
			
			$("#requested_currency_id option[value='"+$(this).next().find('.required_currency_bank').text()+"']").prop('selected','selected');
			$("#requested_currency_id option[value='"+$(this).next().find('.required_currency_bank').text()+"']").attr("selected","selected");
			
			
			
			$('#requested_currency_id,#amount_id').removeClass('active_fn');
			$("#requested_currency_id").val(rcb).trigger('focusout');
			
			if(thisCheck=='crypto'){
				
			}
			
			
			$('#inputBankName').val($('.bank_input_row_'+bankCountNo).find('label').text());
			$('.fa_selectedBank .s24').html($('.bank_input_row_'+bankCountNo).find('label').html());
			
			$('.bank_accord_div').slideUp(200);
			$(this).next().slideDown(1000);
			$(this).addClass('active');
			
			
			
			
			
		}
	});
	
	$('#receiver_user_id').focusout(function(){
		//alert($(this).val());
		if($('#receiver_user_id').hasClass('active_fn')){
			
		}else{
			$('#receiver_user_id_details').html(""+$(this).val())
			//alert("<?=$post['amount'];?>"+"\r\n"+$('#amount_id').val());
			
			$.ajax({
				url: "<?=$data['USER_FOLDER']?>/<?=$data['ThisPageUrl'];?>",
				type: "POST",
				dataType: 'json', 
				data: "action=receiver_profile&json=1&receiver_user_id="+$(this).val(),
				success: function(results){
					$('#receiver_user_id').addClass('active_fn');
					
					if(!results["receiver_jsn"]){
						alert(results);
					}else{
						setTimeout(function(){ 
							//$('#wire_fee_cnvrt').html(""+results["settlement_fixed_fee"]);
							$('#receiver_user_id_details').html(""+results["receiver_jsn"]);
						}, 50);
					}
					
				}
			});
		}
			
	});
	
	
	
	
	<? if(isset($_GET['admin'])&&isset($post['receiver_user_id'])&&$post['receiver_user_id']){ ?>
		$('#receiver_user_id').trigger('focusout');		
	<? } ?>
	
	$('#requested_currency_id,#amount_id').change(function(){
		$('#requested_currency_id,#amount_id').removeClass('active_fn');
	});
	
	$('#receiver_user_id').change(function(){
		$('#receiver_user_id').removeClass('active_fn');
	});
	
	$('#amount_id').focusout(function(){
		if($('#amount_id').val()==amountCh){
			$('#requested_currency_id,#amount_id').addClass('active_fn');
		}
	});
	
	$('#requested_currency_id,#amount_id').focusout(function(){
		amountCh=$('#amount_id').val();
		//alert("<?=$post['amount'];?>"+"\r\n"+$(this).val());
		//alert("<?=$post['amount'];?>"+"\r\n"+$('#amount_id').val());
		if($('#requested_currency_id,#amount_id').hasClass('active_fn')){
			
		}else{
			var amount=""; 
			<? if($data['ThisPageLabel']=='Send'){?>
				amount=$('#amount_id').val();	
			<? }else{ ?>
				//amount="<?=$post['amount'];?>";
				amount=$('#amount_id').val();	
			<? }?>
			
			
			
			var url_name="<?=$data['USER_FOLDER']?>/<?=$data['ThisPageUrl'];?>?action=convertamt"+subQueryString;
			
			
			
			
			//alert("\r\n | amount: "+amount+"\r\n | requested_currency: "+$('#requested_currency_id').val()+"\r\n | subQueryString: "+subQueryString+"\r\n | this value: "+$(this).val()+"\r\n | this url_name: "+url_name);
			
			var withdrawfee = $('.bank_count_'+bankCountNo).find('.withdrawFee_bank').text();
			var bnkVal=$("#bankList_id option:selected").val();
			//alert(url_name+"\r\n"+withdrawfee);
			
			if(wn){
				nw(url_name);
			}
			
			$.ajax({
				url: url_name,
				type: 'POST',
				dataType: 'json', 
				data:{action:"convertamt", amount:amount, withdraw_fee:withdrawfee, bank:bnkVal, json:"1", requested_currency:$('#requested_currency_id').val()},
				success: function(data){
					$('#requested_currency_id,#amount_id').addClass('active_fn');
					
					//myObj = JSON.parse(data);
					<? if(isset($_REQUEST['a'])&&$_REQUEST['a']=='c'){?>
						alert(JSON.stringify(data));
					<? }?>
					//alert(JSON.stringify(data));
					
					if(!data["amount_jsn"]){
						<? if($data['is_admin']==0){?>
							$('.nextProcess').slideUp(200);
						<? }?>
						alert("Opps: "+data['Error']);
					}else{
						setTimeout(function(){ 
							<? if($data['is_admin']==0){?>
								$('.nextProcess').slideDown(1500);
							<? }?>
							if(withdrawfee>0 && data["withdrawfee_calc"]){
								$('#withdrawFeeTextId').html(withdrawfee);
								$('#withdrawFeeCalcTextId').html(data["withdrawfee_calc"]);
								
								$('#inputWithdrawFee').val(withdrawfee);
								$('#inputWithdrawFeeCalc').val(data["withdrawfee_calc"]);
								
								$('#withdrawFeeTextRowId').show();
							}else{
								$('#inputWithdrawFee').val('');
								$('#inputWithdrawFeeCalc').val('');
								
								$('#withdrawFeeTextRowId').hide();
							}
							
							if(data["amount_differs"]){
								$('#selectedAmtId').html(data["amount_differs"]);
								$('.payGetAmt').html(data["amount_differs"]);
								$('.inputAmount_differs').val(data["amount_differs"]);
							}else{
								$('#selectedAmtId').html(amount);
								$('.payGetAmt').html(amount);
								$('.inputAmount_differs').val('');
							}
							$('#amount_cnvrt').html(""+data["amount_jsn"]);
							
							$('.fa_totalAmt .s24').html(""+data["amount_jsn"]);
							$('.inputCovertedAmt').val(data["amount_jsn"]);
							if(data["amount_total_jsn"]){
								//alert(data["amount_total_jsn"]);
								$('#totalAmtId').html(""+data["amount_total_jsn"]);
								$('#inputTotalOriginalAmt').val(data["amount_total_jsn"]);
							}
							<? if($data['withdraw_gmfa']){?>
								if(data["amount_total_jsn"]){
								 $('.mfa_totalAmt').html("Total <?=$data['ThisPageLabel'];?> Amount : <b class='s24'> "+data["amount_total_jsn"]+" <?=prntext($post['ab']['account_curr'])?></b>");
								 $('.mfa_payoutAmt').html("Payout Amount : <b class='s24'> "+data["amount_jsn"]+"</b>");
								 $('.mfa_selectedBank').html("Current Bank : <b class='s24'> "+$('.bank_input_row_'+bankCountNo).find('label').html()+"</b>");
								}
							<? }?>
							<? if(isset($data['HideAllMenu'])&&$data['HideAllMenu']){?>
								//top.window.resizeIframes('iframe_withdrawal');
							<? }?>
						}, 10);
					}
					
				}
			});
		
		}	
	});
	
	
	$('#bankList_id').click(function(){
		var selectedThis = $(this).find("option:selected");
		bankVal = selectedThis.val();
	});
	
	$('#bankList_id').change(function(){
		var selectedThis = $(this).find("option:selected");
		var thisVal = selectedThis.val();
		var thisText = selectedThis.text();
		//alert('thisVal: '+thisVal+'\r\n thisText: '+thisText+'\r\n pev bankVal: '+bankVal);
		if(thisVal==='addNewBank'||thisVal==='addCryptoWallet'){
			//alert(thisVal);	
			window.location.href="<?=$data['USER_FOLDER']?>/bank<?=$data['ex']?>?action="+thisVal;
			return false;
		}else if(selectedThis.hasClass('bank_2')){
			bankCountNo=thisVal;	
		}else{
			$('#bankList_id option[value="'+bankVal+'"]').prop('selected','selected');
			//alert('thisVal: '+thisVal+'\r\n thisText: '+thisText+'\r\n pev bankVal: '+bankVal);
			
			alert("We cannot process withdrawal for:\r\n \"" +selectedThis.text()+ "\" \r\nKindly contact to support for further information\r\n");
			return false;
		}
		
		$('#typeBank').show();
		$('.bank_accord').removeClass('active');
		$('.bank_accord').slideUp(500);
		
		 
		
		var rcb=$('.bank_count_'+bankCountNo).find('.required_currency_bank').text();
		$('#requested_currency_id option').removeAttr('selected');
		$("#requested_currency_id option[value='"+rcb+"']").prop('selected','selected');
		$("#requested_currency_id option[value='"+rcb+"']").attr("selected","selected");
		
		$('#requested_currency_id,#amount_id').removeClass('active_fn');
		$("#requested_currency_id").val(rcb).trigger('focusout');
		
		
		$('#inputBankName').val(thisText);
		$('.fa_selectedBank .s24').html(thisText);
		
		
		$('.bank_input_row_'+bankCountNo).slideDown(1000);
		$('.bank_input_row_'+bankCountNo).addClass('active');
			
		
	});
	
	
	
	<? if(isset($post['bank_back'])&&$post['bank_back']){ ?>
		setTimeout(function(){ 
				$('#bankList_id option[value="<?=$post['bank_back']?>"]').prop('selected','selected').trigger("change");	
			}, 20);
	<? }elseif($data['bank_id']){?>
		setTimeout(function(){ 
			$("#bankType_id").eq(0).trigger("click");
		}, 30);
	<? }elseif(isset($post['bank'])&&$post['bank']){ ?>
		setTimeout(function(){ 
				$('#bankList_id option[value="<?=$post['bank']?>"]').prop('selected','selected').trigger("change");	
			}, 20);
	<? }?>
	
	$('#myFormReq1').bind('submit', function(){ 
		var retVal= confirm('OK!: Do you really want to submit the form?');
		if (retVal) {
			return true;
			//e.preventDefault();
			
		} else {			
			return false;
		}
	});
	
	<? if(isset($data['HideAllMenu'])&&$data['HideAllMenu']){?>
		//top.window.resizeIframes('iframe_withdrawal');
	<? }?>
	
	
	
	$("#a_submit").on("click", function(event) {
		
		$('#modalpopup_form_popup').show(200);
		<? if(isset($_SESSION['adm_login'])){?>
			subQueryString="?action=convertamt&amount="+$('#amount_id').val()+"&json=1&requested_currency="+$('#requested_currency_id').val();
			urls="<?=$data['USER_FOLDER']?>/<?=$data['ThisPageUrl'];?>"+subQueryString;
			if(wn){
				window.open(urls,'_blank');
				alert(urls);
			}
			
		<? }?>
		var url_name="<?=$data['USER_FOLDER']?>/<?=$data['ThisPageUrl'];?>?action=convertamt"+subQueryString;
		
		$.ajax({
			url: url_name,
			type: "POST",
			dataType: 'json', 
			data:{action:"convertamt", amount:$('#amount_id').val(), json:"1", requested_currency:$('#requested_currency_id').val()},
			success: function(data){
				
				//myObj = JSON.parse(data);
				<? if(isset($_REQUEST['a'])&&$_REQUEST['a']=='c'){?>
					alert(JSON.stringify(data));
				<? }?>
				
				if(!data["amount_jsn"]){
					alert("Opps : "+data['Error']);
				}else{
					setTimeout(function(){
					
						var retVal= confirm("Do you want to process your <?=$data['ThisTitle'];?><?=$data['prompt_msg'];?> ?");
							if (retVal) {
								consub="true";
								$('#a_submit').hide(500);
								$("#b_submit").attr("name","send");
								$('#b_submit').trigger("click");
								return true;
							} else {
								consub="false";
								$("#b_submit").attr("name","sends");
								$('#modalpopup_form_popup').hide(100);
								return false;
							}
							
						$('#consub').val(consub);	 
						//event.preventDefault();
						
					}, 10);
				}
				
			}
		});
		
		//event.preventDefault();
	});
	
	$('.modal_msg_close,.modal_msg_close2,.modal_mfa_msg_close2,.modal_mfa_msg_close').click(function(){
		closeMsg();
	});
	
	$('#b_submit').click(function(){
		$('#modal_msg').hide(200);
		$('#modalpopup_form_popup').show(200);
	});
	
	$('.back_button').click(function(){
		$('#modalpopup_form_popup').show(200);
		$('#backFormReq').submit();
		
	});
	
	$('#myFormReq').submit(function(e){ 
	  try {
		 // alert(e.result);
		if($('#b_submit').hasClass('active')){
			return true;
		}else{ 
		 
		 
			
		 <? if($data['withdraw_gmfa']){?>
		  //alert('MFA');
			$('#modal_with_div1').html($('#calculate_div_id').html());
			$('#modal_mfa').show(200); 
		 <? }else{?>
			$("#b_submit").attr("name","send");
			$('#b_submit').addClass('active');
			$('#modal_msg').show(200);
			
		  <? }?>
			return false;
		}
		e.preventDefault(); 
	   }
	   catch(err) {
		  alert('MESSAGE=>'+err.message);
	   }
	});
	
	document.onkeyup=function(event){
	   if (event.keyCode === 27){
		 closeMsg();
	   }
	}
	
	$('.backButton1').click(function(){
		$("form").removeAttr("id");
		$("form").attr("id","backButton");
		//$('#myFormReq').submit();
		alert($("form").attr("id"));
	}); 
	
	<? if($data['is_admin']==1){?>
		top.window.$('#modal_popup_form_popup').hide(100);
	<? }?>
	
});

function closeMsg(){
	
	$("#b_submit").attr("name","sends");
	$('#b_submit').removeClass('active');
	$('#modal_msg').hide(200);
	$('#modal_mfa').hide(200);
}
function validateThisForm(event){
	if($('#consub').val()==="false"||$('#consub').val()=="false"){
		alert($('#consub').val());
		$("#a_submit").trigger("click");
		return false;
	}else{
		var $form = $('#myFormReq');
		$form.append('<input type="text" name="send" style="display:none"  value="submit" />');
		$("#b_submit").attr("name","send");
		$form.get(0).submit();
		return true;
	}
	event.preventDefault();
}


</script>

<div class="container bg-primary border my-2 vkg clearfix_ice rounded ">


<? if($post['step']<6){?>
<form method="post"  <? if($post['step']>3){?> id="myFormReq" <? }?> >
  <input type="hidden" name="step" value="<?=$post['step']?>">
  <input type="hidden" id="consub" value="false">
  <input type="hidden" name="inputTotalOriginalAmt" id="inputTotalOriginalAmt" value="<?=((isset($_POST['inputTotalOriginalAmt']) &&$post['inputTotalOriginalAmt'])?$post['inputTotalOriginalAmt']:'')?>">
  <?if($post['step']>3){?> 
	<?if(isset($_POST['bank'])){?> 
		<?if(isset($_POST['BankType'])&&$_POST['BankType']=='999'){?>
			<input type="hidden" name="bank" id="bank_id" value="crypto">
		<?}else{?>
			<input type="hidden" name="bank" id="bank_id" value="<?=$_POST['bank']?>">
		<?}?>
	<?}?>
	<?if(isset($_POST['BankType'])){?> 
	 <input type="hidden" name="BankType" id="BankType_back" value="<?=$_POST['BankType']?>">
	 <?}?>
	<? if(isset($_POST['requested_currency'])){?> 
			<input type="hidden" name="requested_currency" id="requested_currency_id" value="<?=((isset($_POST['requested_currency']) &&$_POST['requested_currency'])?$_POST['requested_currency']:'')?>">
	<? }?>
	<? if(isset($_POST['note'])){?> 
			<input type="hidden" name="note" id="comments_id" value="<?=((isset($_POST['note']) &&$_POST['note'])?$_POST['note']:'')?>">
	<? }?>
  <? }?>
  <?if($post['step']>2){?> 
	   <? if(isset($_POST['amount'])){?> 
			<input type="hidden" name="amount"  id="amount_id" value="<?=((isset($_POST['amount']) &&$_POST['amount'])?$_POST['amount']:'')?>">
	   <? }?>
		
		
		
<input type="hidden" name="inputBankName" id="inputBankName" value="<?=((isset($_POST['inputBankName']) &&$_POST['inputBankName'])?$_POST['inputBankName']:'')?>">
<input type="hidden" name="inputCovertedAmt" id="inputCovertedAmt" class="inputCovertedAmt" value="<?=((isset($_POST['inputCovertedAmt']) &&$_POST['inputCovertedAmt'])?$_POST['inputCovertedAmt']:'')?>">
<input type="hidden" name="inputAmount_differs" id="inputAmount_differs" class="inputAmount_differs" value="<?=((isset($_POST['inputAmount_differs']) &&$_POST['inputAmount_differs'])?$_POST['inputAmount_differs']:'')?>">
<input type="hidden" name="inputWithdrawFee" id="inputWithdrawFee" class="inputWithdrawFee" value="<?=((isset($_POST['inputWithdrawFee']) &&$_POST['inputWithdrawFee'])?$_POST['inputWithdrawFee']:'')?>">
<input type="hidden" name="inputWithdrawFeeCalc" id="inputWithdrawFeeCalc" class="inputWithdrawFeeCalc" value="<?=((isset($_POST['inputWithdrawFeeCalc']) &&$_POST['inputWithdrawFeeCalc'])?$_POST['inputWithdrawFeeCalc']:'')?>">
		
<? }?>
  
<? /*?>   
   <? if(!isset($data['HideAllMenu']) || empty($data['HideAllMenu'])){ ?>
  
  <div class="heading-buttons">
    <h1>
      <?=$data['ThisTitle'];?> <img src="<?=$data['Host']?>/images/betaVersion.png" class="betaVersion" />
    </h1>
    <? if(($post['withdraw_option']==2)&&(isset($data['statement_withdraw']))){}?>
  </div>
  <? }?>
  <? */?>   

  
  
 
<? if((isset($data['Error'])&& $data['Error'])){ ?>
  
  <div class="alert alert-danger alert-dismissible fade show" role="alert">
  <strong>Alert !</strong> <?=prntext($data['Error'])?>
  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>

  <? }?>


    <h4 class="my-2"><i class="<?=$data['fwicon']['bitcoin'];?>"></i> Options of <?=$data['ThisTitle'];?></h4>
      
    



  
 
  
   
 
  <? if($post['step']==1){ //step1 ?>
  <div class="breadcrumb" style="height:inherit;<?=(($data ['HideAllMenu'])?"display:block !important;":"")?>">
   <? include("../include/summery_balance_link".$data['iex']);?>
   <div class="row100 funda col-sm-12 px-0 row"><a class="fund_3 col-sm-3 text-decoration-none"><i class="<?=$data['fwicon']['hand'];?>"></i> Wire Fee : <b>
      <?=$post['ab']['account_curr_sys'];?>
      <?=$post['settlement_fixed_fee'];?>
      </b></a>
      <? if($data ['ThisPageLabel'] != 'Rolling'){?>
      <a  class="fund_3 col-sm-3  text-decoration-none"><i class="<?=$data['fwicon']['hand'];?>"></i> 
      <?=$data['ThisPageLabel'];?>
      Minimum: <b>
      <?=$post['ab']['account_curr_sys'];?>
      <?=$post['settlement_min_amt'];?>
      </b> </a>
      <? }?>
      <? if($data['con_name']=='clk'&&isset($_SESSION['adm_login'])&&isset($_REQUEST['admin'])){?>
		  <? if(isset($post['total_mdr_amt'])&&$post['total_mdr_amt']){?>
		  <a  class="fund_3 col-sm-3  text-decoration-none"><i class="<?=$data['fwicon']['hand'];?>"></i> Total MDR Amt. : <b>
		  <?=$post['ab']['account_curr_sys'];?>
		  <?=$post['total_mdr_amt'];?>
		  </b></a>
		  <? }?>
		  <? if(isset($post['total_mdr_txtfee_amt'])&&$post['total_mdr_txtfee_amt']){?>
		  <a  class="fund_3 col-sm-3 text-decoration-none"><i class="<?=$data['fwicon']['hand'];?>"></i> Transaction Fee : <b>
		  <?=$post['ab']['account_curr_sys'];?>
		  <?=$post['total_mdr_txtfee_amt'];?>
		  </b></a>
		  <?  }?>
		  <? if(isset($post['total_gst_fee'])&&$post['total_gst_fee']){?>
		  <a  class="fund_3 col-sm-3  text-decoration-none"><i class="<?=$data['fwicon']['hand'];?>"></i> Total GST Fee @
		  <?=$post['gst_fee'];?>
		  : <b>
		  <?=$post['ab']['account_curr_sys'];?>
		  <?=$post['total_gst_fee'];?>
		  </b></a>
		  <? }?>
      <? }?>
    </div>
  </div>
 
    <? }?>

  <?
   if(isset($_POST['inputAmount_differs'])&&$_POST['inputAmount_differs']){
	   $vAmt=$_POST['inputAmount_differs'];
   }elseif(isset($_POST['amount'])&&$_POST['amount']){
	   $vAmt=$_POST['amount'];
   }else{
	   $vAmt=$post['amount'];
   }
   
   if(isset($_POST['inputWithdrawFee'])&&$_POST['inputWithdrawFee']){
	   $withdrawFeeText_row='display:block';
   }else{
	   $withdrawFeeText_row='';
   }
  ?>
  
<div class="row px-1" >

<? //echo $post['step'];?>

 
  
<div class="mobileLayout col1 border col-sm-6 rounded"  style="background: linear-gradient(to bottom, <?=$_SESSION['background_gl5'];?> 0%, <?=$data['tc']['hd_b_l_9'];?> 100%);">   
 <!-- ///////////////////-->
  <div id="calculate_div_id" class="g calculate_div_id my-2 p-2 row">
	<div class="col-sm-12  my-2 px-2"><i class="<?=$data['fwicon']['circle-right'];?>"></i> <?=$data['ThisPageLabel'];?>&nbsp;Amount : <b id="selectedAmtId">
      <?=($post['ab']['account_curr_sys'].number_formatf_2($vAmt));?>
      </b> <?=prntext($post['ab']['account_curr']);?></div>
  
	<font id="withdrawFeeTextRowId" class="col-sm-12 my-2 px-2 row hide" style=" <?=$withdrawFeeText_row;?> ">
	<div><i class="<?=$data['fwicon']['circle-right'];?>"></i> <?=$data['ThisPageLabel'];?>&nbsp;Fee <b id="withdrawFeeTextId"><? if(isset($_POST['inputWithdrawFee'])) echo $_POST['inputWithdrawFee']?> </b>% : <b id="withdrawFeeCalcTextId"><? if(isset($_POST['inputWithdrawFeeCalc'])) echo $_POST['inputWithdrawFeeCalc']?></b> <?=prntext($post['ab']['account_curr']);?></div>
		
	</font>
	

    <? if($post['settlement_fixed_fee']>0){?>
    <div class="col-sm-12 my-2 px-2"><i class="<?=$data['fwicon']['circle-right'];?>"></i> Settlement Wire Fee :<b><?=($post['ab']['account_curr_sys'].number_formatf_2($post['settlement_fixed_fee']));?></b></div>

    <? }?>

    <? if($post['monthly_fee']>0){?>
    <div class="col-sm-12 my-2 px-2"><i class="<?=$data['fwicon']['circle-right'];?>"></i> Monthly Maintenance Fee @<?=($gpost['payout']['per_monthly_fee']);?>X<?=($gpost['payout']['total_month_no']);?>: <b>
      <?=($post['ab']['account_curr_sys'].number_formatf_2($post['monthly_fee']));?>
      </b></div>
    <? }?>
    <? if((isset($post['total_gst_fee'])&&$post['total_gst_fee']?$post['total_gst_fee']:'') >0){?>
    <div class="col-sm-12  my-2 px-2"><i class="<?=$data['fwicon']['circle-right'];?>"></i> GST Fee: <b><?=($post['ab']['account_curr_sys'].number_formatf2($post['total_gst_fee'],4));?></b></div>

    <? }?>
  
	<? if((isset($post['virtual_fee1'])&&$post['virtual_fee1']?$post['virtual_fee1']:'') >0){?>
    <div class="col-sm-12 my-2 px-2"><i class="<?=$data['fwicon']['circle-right'];?>"></i> Virtual Terminal Fee: <b><?=($post['ab']['account_curr_sys'].number_formatf_2($post['virtual_fee1']));?></b></div>

    <? }?>

    <div class="col-sm-12  my-2 px-2"><i class="<?=$data['fwicon']['circle-right'];?>"></i> Gross Settlement Amount: <b id="totalAmtId">
      <?=($post['ab']['account_curr_sys'].(isset($_POST['inputTotalOriginalAmt'])&&$_POST['inputTotalOriginalAmt']?number_formatf_2($_POST['inputTotalOriginalAmt']):number_formatf_2($post['summ_mature_amt'])));?>
      </b> <?=prntext($post['ab']['account_curr'])?></div>
  </div>
 
   <? if($post['step']>2){?> 
     <div class="paySum text-end m-2 p-2 border border-success rounded-3" >
		<div class="fa_payoutAmt">Total <?=$data['ThisPageLabel'];?> Amount : <b class="s24 payGetAmt"><?=number_formatf_2($vAmt);?></b> <b> <?=prntext($post['ab']['account_curr'])?> </b></div>
		<div class="fa_totalAmt">Payout Amount : <b class="s24 paySumAmt text-danger fs-4"><?=(isset($_POST['inputCovertedAmt'])?$_POST['inputCovertedAmt']:'')?></b></div>
		<div class="fa_selectedBank">Current Bank : <b class="s24"><?=(isset($_POST['inputBankName'])?$_POST['inputBankName']:'')?> </b></div>
	</div>
  <? }?>
   </div>
  <? if($post['step']==2){ //step2 ?>
 
 
  <? if(!isset($data['submitFalse'])){?>
  
  

  <? if($data['ThisPageLabel']=='Send'){?>
  <div style="margin-top: 10px !important;">
    <label for="receiver_user_id">Receiver User ID</label>
    <input required type="text" name="receiver_user_id" id="receiver_user_id" class="span4" value="<?=$post['receiver_user_id']?>" placeholder="Enter Receiver User ID" style="width:12%" />
    <span id="receiver_user_id_details" class="span8" style="width:55%"> </span> </div>
  <? }?>
  <div class="separator" style="display:none;clear:both;float:left;width:100%;margin:10px 0 -10px 0;">
    <label for="settlement_fixed_fee">Wire Fee </label>
    <b>
    <?=$post['ab']['account_curr_sys'];?>
    <?=number_formatf_2($post['settlement_fixed_fee']);?>
    </b>
    <div id="wire_fee_cnvrt">&nbsp;</div>
  </div>
  <?
$am=true;
if($post['amount']<1&&!isset($_GET['admin'])&&($data['ThisPageLabel']!='Send')){
$am=0;
	?>
  <div class='row border' style="clear:both;">

	
	<div class="alert alert-danger my-2 alert-dismissible fade show" role="alert">
  <strong>In-sufficient balance: </strong> You have in-sufficient balance to initiate withdrawal. 
    Please contact <b>Support</b> for more information.
  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
  </div>
  <? if(isset($data['HideAllMenu'])&&$data['HideAllMenu']){ ?>
  <script>
		top.window.resizeIframes('iframe_withdrawal');
		</script>
  <? }?>
  <? exit;}?>
  <? if($am==1){?>


  <?php
$amt=$post['ab']['account_curr_sys'].$post ['summ_mature_amt'].' - (';
$amt.=$post['ab']['account_curr_sys'].$post['settlement_fixed_fee'];

if (isset($post['monthly_fee']) && ($post['monthly_fee']!='')){
$amt.='+'.$post['monthly_fee'];}

if (isset($post['total_gst_fee']) && ($post['total_gst_fee']!='')){
$amt.='+'.$post['total_gst_fee'];}

if (isset($post['virtual_fee']) && ($post['virtual_fee']!='')){
$post['virtual_fee1']=$post['virtual_fee'];
$post['virtual_fee']=$post['ab']['account_curr_sys'].'0';
$amt.='+'.$post['virtual_fee'];
}


//$amt.='+'.$post['virtual_fee'];
$amt.=')';

?>
 
<div class="row" >


 
 <div class="col-sm-12">
 
          <div class="input-group my-2 p-2"> 
		  <span class="input-group-text" id="basic-addon1"><label for="amount_id" style="height:auto;clear:left;"><?=$data['ThisPageLabel'];?>&nbsp;Amount
  <?=prntext($post['ab']['account_curr'])?>
  <span style="display:none;overflow-wrap: break-word;word-wrap: break-word;margin: 0;" class="btn-action single glyphicons circle_question_mark" data-toggle="tooltip" data-placement="top" data-original-title="You can <?=$data['ThisPageLabel'];?> Mature Fund-{<?=($data['con_name']=='clk'?"GST FEE+":"");?>Wire Fee+Monthly Fee+Virtual Terminal Fee+Any Other charges (If Applicable) } i.e. (<?=$amt?>= <?=$post['amount'];?>)"><i></i></span>
  <div style="display:none;word-wrap: break-word;margin: 0 0 10px 0;float: left;color: #9e9b9b;background: #fff;font-weight: normal;line-height: 140%;" class="btn-action single">You can
    <?=$data['ThisPageLabel'];?>
    Mature Fund-{
    <?=($data['con_name']=='clk'?"GST FEE+":"");?>
    Wire Fee+Monthly Fee+Virtual Terminal Fee+Any Other charges (If Applicable) } <br/>
    i.e. (<b>
    <?=$amt?>
    =
    <?=$post['amount'];?>
    </b>) </div>
  </label></span>
          <span class="input-group-text" id="basic-addon1"><?=$post['ab']['account_curr_sys'];?></span>
            <input required type="text" name="amount" id="amount_id" class="form-control" value="<?=(isset($_POST['amount'])?number_formatf_2($_POST['amount']):number_formatf_2($post['amount']));?>"  />
             </div>
        </div>
 
 </div> 
  
  <? if($data['ThisPageLabel']=='Withdraw'||$data['ThisPageLabel']=='Rolling'){/*?> disabled <?*/ }?>
  <div class="separator my-3 text-end pe-4">
    <label for="amount_cnvrt">
    <? if($data['ThisPageLabel']=='Withdraw'){?>
    Your Payout Amount
    <? }else{?>
    Converted Currency
    <? }?>
    </label> :: 
    <b id="amount_cnvrt" class="text-danger fs-4"></b></div>
  
   <input type="hidden" name="requested_currency" id="requested_currency_id" value="<?=prntext($post['ab']['account_curr'])?>">
   
					  
	<script>
	 $(document).ready(function(){
		 $("#amount_id").trigger("focusout");
	 });
	</script>			  
  <? }?>
  <? }?>
 <!--</div>-->


 <? }if($post['step']==3){ //step3 ?>
 <script>
 $(document).ready(function(){
	
	
	$("input[type='radio'].bType").click(function() {
		$('#bankList_id option[value=""]').prop('selected','selected');
		$('.bank_accord').removeClass('active');
		$('.bank_accord').slideUp(200);
		$('#withdrawFeeTextRowId').hide(500);
		$('#bankList_label').show();
		$('#bankList_id').show();
		$('.fa_selectedBank').show();
		
		$('#bankList_id').attr('required','required');
		if($(this).is(':checked')) {
			if ($(this).val() == '992') {
				//alert($(this).val());
				$('#requested_currency_id option').removeAttr('selected');
				$('#bankList_label').html('Select Crypto Wallet');
				$('.newBankAdd').text('Add New Crypto Wallet');
				$('.newBankAdd').val('addCryptoWallet');			
				$('.fa_totalAmt .paySumAmt, .fa_selectedBank .s24').html('');
				$('#bankList_id .crypto_list').show(500);
				$('#bankList_id .bank_list').hide();
				
				//$('#typeBank').show(1000); $('#typeCrypto').hide(500);
				
			}else if ($(this).val() == '999' || $(this).val() == '993') {
				//alert($(this).val());
				$('#bankList_label').hide();
				$('#bankList_id').hide();
				$('.fa_selectedBank').hide();
				$('#bankList_id').removeAttr('required');
				$("input[value='crypto']").trigger('click');
				//$("input[value='crypto']").prop('checked', true);
				$('#typeBank').slideUp(500); $('#typeCrypto').slideDown(1000);
			}else{ 
				//alert("Kindly select bank");
				$('#bankList_label').html('Select Bank Account');
				$('.newBankAdd').text('Add New Bank');
				$('.newBankAdd').val('addNewBank');
				$('#bankList_id .bank_list').show(500);
				$('#bankList_id .crypto_list').hide();
				
				<? if($data['bank_id']){?>
					$('#bankList_id option').removeAttr('selected');
					$('#bankList_id option[value="<?=$data['bank_id']?>"]').prop('selected','selected').trigger("change");	
				<? }?>
				
				
				//$('#typeBank').show(1000); $('#typeCrypto').hide(500);
				
			}
		}
	});
	
	<? if(isset($_POST['BankType'])&&$_POST['BankType']){?>
		$("input[value='<?=prntext($_POST['BankType']);?>'].bType").prop('checked', true).trigger("click");
		
		<? if($_POST['BankType']=='992'){?>
			//$('#bankList_id .crypto_list').show();
			 //$("#CryptoWallet_id").trigger("click");
		<? }elseif($_POST['BankType']=='999'){?>
			// $("#999_id").trigger("click");
		<? }else{?>
			//$('#bankList_id .bank_list').show();
			//$("#bankType_id").trigger("click");
		<? }?>
		
	<? }?>
	<? if(isset($_POST['bank'])&&$_POST['bank']){?>
		//$("input[id='<?=$_POST['bank']?>bank']").eq(0).trigger("click");
		
	<? }?>

});
 </script>
 
	 
<div class="mobileLayout col2 col-sm-6 border bg-light px-2 text-start float-end" style="background: linear-gradient(to bottom, <?=$_SESSION['background_gl7'];?> 0%, <?=$_SESSION['background_gl5'];?> 100%);">
	
  <div class="bTypeDiv rounded-pill py-2 my-2 text-center bg-primary text-white d-flex justify-content-center" >
  
  
	  <input type="radio" name="BankType" id="bankType_id" class="bType  form-check-input mx-2" value="991" checked1 required  /> 
	  <label for="bankType_id" >Bank Account</label>
	
		<? if($data['con_name']=='clk'){?>
			
		<? }else{?>	
	
		  <input type="radio" name="BankType" id="CryptoWallet_id" class="bType  form-check-input mx-2" value="992"  required />
		  <label for="CryptoWallet_id"   >Crypto Wallet</label>
		  
			 <?if(isset($post['payout_request'])&&$post['payout_request']&&in_array($post['payout_request'],["1","2"])){?>
			  <input type="radio" name="BankType" id="PayoutModule_id" class="bType  form-check-input mx-2" value="993"  required />
			  <label for="PayoutModule_id"   >Payout</label>
			<?}?>
			
		  <input type="radio" name="BankType" id="999_id" class="bType form-check-input mx-2" value="999"  required />
		  <label for="999_id" >Other</label>
		<? }?>	
		
	 </div>
 
	
  <? if($data['ThisPageLabel']=='Withdraw'||$data['ThisPageLabel']=='Rolling'){?>

<? if(isset($data['crypto1'])&&$data['crypto1']){?>
<div id="typeCrypto" class="hide">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
      <td class="capl" style="background-color:#DDDDDD">
        <div class="bank_accord bank_input_row_crypto" data-count="crypto" style="clear:both !important;">
          <div class="bank_radio">
            <input required type="radio" name="bank" value='crypto' <? if($post['bank']=="crypto")
				{
				?>
					<? $bankchecked=true;?> 
					checked
				<? }?>
				 id="<?="crypto"?>bank" style="border:0" class="bank_2 bank_input" >
            &nbsp; </div>
          <div class="bank_name">&nbsp;
            <label for="<?="crypto"?>bank"> <b>Crypto</b> </label>
          </div>
        </div>
        <div class="hide bank_accord_div" style="float:left;width:100%;display:none;">
<input type="hidden" name="display_bank_name" value='crypto' />
<textarea name="bank_get" placeHolder="Enter Crypto Details" style="height:150px;width:98%;"><?=$post['bank_get'];?></textarea>
<div class="input required_currency_bank" style="display:none;"><?=($post['ab']['account_curr']);?></div>
<div class="hide bank_accord_div_textArea" style="float:left;width:100%;"></div>
			<div class="hide bank_accord_div_table" style="float:left;width:100%;">
			
			</div>
        </div>
      </td> 
	</tr>	
</table>
</div>
  <? }?>



  <label for="bankList_id" id="bankList_label" class="my-2 fw-bold" >Select </label>
  <select name="bank" id="bankList_id" class="selectOption form-select my-2" required >
    <option value="" selected>Select</option>
	<? $k=0;foreach($post['BanksInfo'] as $key=>$val){$k++;$bnkInfo[$key]=$val;$bnkInfoJson=json_encode(array($key=>$val));$bnkInfoJson=str_replace(array('[',']'),array('',''),$bnkInfoJson);
	if((isset($val['bname'])&&$val['bname']=='Crypto Wallet')||(isset($val['coins_name'])&&$val['coins_name'])){$crypto_wallet=1; $iconAcc='crypto'; }else{$crypto_wallet=0; $iconAcc='bank';}	
	if(isset($val['coins_name'])&&$val['coins_name']){
		$val['id']="c_".$val['id'];
		$val['bname']="Crypto Wallet - ".$val['coins_name'];
		$val['bswift']=$val['coins_name'];
		$val['brtgnum']=$val['coins_network'];
		$val['baccount']=$val['coins_address'];
		$val['baddress']=$val['coins_wallet_provider'];
	}
	?>
    <option value='<?=$val['id'];?>' data-id="<?=$val['id']?>bank" class="hide <?=($iconAcc);?>_list bank_<?=$val['primary']?>"  ><b style="font-weight:bold"><?=ucwords(strtolower(prntext($val['bname'])))?></b> (... <?=encode(decrypts_string($val['baccount']),6,0);?>)</option>
    <? }?>
	<option value="" class="newBankAdd" >Add New Bank</option>
  </select>
  



  <? $bnkInfo=array();if($post['BanksInfo']){?>
  <div id="typeBank" class="hide">

   <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <? $k=0;foreach($post['BanksInfo'] as $key=>$val){$k++;$bnkInfo[$key]=$val;$bnkInfoJson=json_encode(array($key=>$val));$bnkInfoJson=str_replace(array('[',']'),array('',''),$bnkInfoJson);
	if((isset($val['bname'])&&$val['bname']=='Crypto Wallet')||(isset($val['coins_name'])&&$val['coins_name'])){$crypto_wallet=1; $iconAcc='crypto'; }else{$crypto_wallet=0; $iconAcc='bank';}	
	
	if(isset($val['coins_name'])&&$val['coins_name']){
		$val['id']="c_".$val['id'];
		$val['bname']="Crypto Wallet - ".$val['coins_name'];
		$val['bswift']=$val['coins_name'];
		$val['brtgnum']=$val['coins_network'];
		$val['baccount']=$val['coins_address'];
		$val['baddress']=$val['coins_wallet_provider'];
	}
	
	?>
    <tr>
      <td colspan=2 class="capl">
        <div class="hide bank_accord bank_input_row_<?=($val['id']);?> <?=($iconAcc);?>_list" data-count="<?=($val['id']);?>" style="clear:both !important;">
           <!--Start Bank Options -->
          <div class="bank_radio" style="display:none;">
            <input type="radio" name="bank1" value='<?=$val['id'];?>' 		<?if(((isset($post['bank']))&&($val['id']==$post['bank']||strpos($post['bank'],'"id":"'.$val['id'].'"')!==false))||($data['bank_id']==$val['id']))
			{
			?>
				<? $bankchecked=true;?> 
				checked
			<? }?>
			 id="<?=$val['id']?>bank" style="border:0" class="bank_<?=$val['primary']?> bank_input" >
            &nbsp; </div>
          <div class="bank_name text-center rounded fw-bold py-2 mb-2">&nbsp;
            <label for="<?=$val['id']?>bank" class="w-50 float-start text-end"><b><?=ucwords(strtolower(prntext($val['bname'])))?></b> (... <?=encode(decrypts_string($val['baccount']),6,0);?>) </label>
			<div data-count="<?=($val['id']);?>" class="bank_details_col nopopup w-25 float-start text-start ps-4"><i class="<?=$data['fwicon']['eye'];?> text-primary img-hover"></i></div>
          </div>
           <!--End Bank Options -->
        </div>
		
        <div class="hide bank_accord_div bank_count_<?=($val['id']);?>" style="float:left;width:100%;">
		
         <input type="hidden" name="display_bank_name" value='<?=prntext($val['bname']);?> (ending with <?=encode(decrypts_string($val['baccount']),4);?>)' />
		  
		 
		 <div class="hide bank_accord_div_table" style="float:left;width:100%;">
		 
		 <? if($val['withdrawFee']){?>
			<div class="hide withdrawFee_bank" ><?=prntext($val['withdrawFee'])?></div>
		 <? }?>
		 
		 <? if($crypto_wallet==1){?>
		 <div class="hide required_currency_bank" ><?=prntext($val['required_currency'])?></div>
		 
			<table  class="table table-striped v">
            <? if($val['bswift']){?>
            <tr>
              <td class="field"  width="45%">Coins:</td>
              <td class="input" ><b style=""><?=prntext($val['bswift'])?></b></td>
            </tr>
            <? }if($val['brtgnum']){?>
            <tr>
              <td class="field" >Network:</td>
              <td class="input" ><?=prntext($val['brtgnum'])?></td>
            </tr>
			<? }if($val['baccount']){?>
            <tr>
              <td class="field" >Address:</td>
              <td class="input" ><b style="font-size:18px;"><?=(encode(decrypts_string($val['baccount']),6));?></b></td>
            </tr>
			<? }if($val['baddress']){?>
            <tr>
              <td class="field" >Wallet Provider:</td>
              <td class="input" ><?=prntext($val['baddress'])?></td>
            </tr>
			<? }if($val['withdrawFee']){?>
            <tr>
              <td class="field" >Withdraw Fee:</td>
              <td class="input" ><?=prntext($val['withdrawFee'])?>% <?=prntext($post['ab']['account_curr'])?></td>
            </tr>
			
			<? }?>
		   </table>
		 <? }else{?>
		 
          <table class="table table-striped">
            <? if($val['bname']){?>
            <tr>
              <td class="field"  width="45%">Bank Name:</td>
              <td class="input" ><b style="" class="bnamex"><?=prntext($val['bname'])?></b></td>
            </tr>
            <? }if($val['baddress']){?>
            <tr>
              <td class="field" >Bank Address:</td>
              <td class="input" ><?=prntext($val['baddress'])?></td>
            </tr>
            <? }if($val['bcity']){?>
            <tr>
              <td class="field" >Bank City:</td>
              <td class="input" ><?=prntext($val['bcity'])?></td>
            </tr>
            <? }if($val['bzip']){?>
            <tr>
              <td class="field" >Bank ZIP Code:</td>
              <td class="input" ><?=prntext($val['bzip'])?></td>
            </tr>
            <? }if($val['bcountry']){?>
            <tr>
              <td class="field" >Bank Country:</td>
              <td class="input" ><?=prntext($data['Countries'][$val['bcountry']])?></td>
            </tr>
            <? }if($val['bstate']){?>
            <tr>
              <td class="field" >Bank State:</td>
              <td class="input" ><?=prntext($val['bstate'])?></td>
            </tr>
            <? }if($val['bphone']){?>
            <tr>
              <td class="field" >Bank Phone:</td>
              <td class="input" ><?=prntext($val['bphone'])?></td>
            </tr>
            <? }if($val['bnameacc']){?>
            <tr>
              <td class="field" >Account Holder's Name:</td>
              <td class="input" ><?=prntext($val['bnameacc'])?></td>
            </tr>
            <? }if($val['full_address']){?>
            <tr>
              <td class="field" >Full Address of Account Holder:</td>
              <td class="input" ><?=prntext($val['full_address'])?></td>
            </tr>
            <? }if($val['baccount']){?>
            <tr>
              <td class="field" >Account Number:</td>
              <td class="input" ><b style="font-size:18px;"><?=encode(decrypts_string($val['baccount']),4);?></b></td>
            </tr>
            <? }if($val['btype']){?>
            <tr>
              <td class="field" >Account Type:</td>
              <td class="input" ><?=prntext($data['BankAccountType'][$val['btype']])?></td>
            </tr>
            <? }if($val['required_currency']){?>
            <tr>
              <td class="field" >Requested Currency:</td>
              <td class="input required_currency_bank" ><?=prntext($val['required_currency'])?></td>
            </tr>
            <? }if($val['brtgnum']){?>
            <tr>
              <td class="field" >9 Digits Routing Number:</td>
              <td class="input" ><?=prntext($val['brtgnum'])?></td>
            </tr>
            <? }if($val['bswift']){?>
            <tr>
              <td class="field" >S.W.I.F.T. Code:</td>
              <td class="input" ><?=prntext($val['bswift'])?></td>
            </tr>
            <? }?>
          </table>
		 <? }?>
        </div>
        </div>
        <? }?></td>
    </tr>
  </table>
  <? }?>
  </div>
  
  <? }?>


	<textarea name="note" placeholder="Add Comments" class="span11 remarkcoment form-control"><?=(isset($post['note'])?prntext($post['note']):'')?></textarea>


  <label for="requested_currency_id"  class="fw-bold my-2">Requested Currency of <?=$data['ThisTitle'];?></label>
  <select name="requested_currency" id="requested_currency_id" placeholder="Requested Currency of <?=$data['ThisPageLabel'];?>" class="form-select my-2">
	<?foreach ($data['AVAILABLE_CURRENCY'] as $k11) {?>
		<option value="<?=$k11?>"><?=$k11?></option>
	<?}?>
  </select>
  <script>
$('#requested_currency option[value="<?=prntext($post['requested_currency'])?>"]').prop('selected','selected');
</script>

 </div>
<!--  </div>-->	
  <? }elseif($post['step']==4){ //step4 ?>
  
 
		<? if(isset($_POST['requested_currency'])){?> 
			<input type="hidden" name="requested_currency" id="requested_currency_id" value="<?=$_POST['requested_currency']?>">
	    <? }?>
		
	  
	 

	<div class="modal_msg" id="modal_msg" style="display: none;">
	<div class="modal_msg_layer"> </div>
	<div class="modal_msg_body" style="width: 300px; height: 270px;"> <a class="modal_msg_close" onclick="document.getElementById('modal_msg').style.display='none';">×</a>
	  <div id="modal_msg_body_div">
		<div class="modalMsgContTxt">
		<h4>Message</h4>
		<p><b>Do you want to process your?</b></p>
		<span class="submit_div">
		<button id="b_submit" type="submit" name="sends" value="<?=$data['ThisPageLabel'];?> NOW!" class="nopopup submitbtn btn btn-icon btn-primary glyphicons circle_ok " autocomplete="off" style="width:100%"><b class="contitxt">Yes</b></button>
		</span> 
		</div>
	   </div>
	  <a class="modal_msg_close2" onclick="document.getElementById('modal_msg').style.display='none';">Close</a></div>
	</div>
		
		<?
		//print_r($data['withdraw_gmfa']);
		if($data['withdraw_gmfa'])
		{
			$data['user_pass_gmfa']=1;
		?>
			<? include('../include/device_confirmations'.$data['ex']);?>
		<? }
		//print_r($data['withdraw_gmfa']);
		?>
		
	<script>
		function selectLoadAmt(){
			<? if($data['withdraw_gmfa']){?>
			 $('.mfa_selectedBank').html($('.paySum').html());
			<? }?>
		}
		$(document).ready(function(){
			selectLoadAmt();
			
			$('.submitProcess').click(function(){
				selectLoadAmt();  
			});
		});
	</script>

 <? }?>
 
<!--////////Button/////////-->
 
<div class="text-center" style="clear: both;">
		<span class="submit_div" style="margin-top:20px;">
		 <? if($post['step']==4){ ?>
			<button id="b_next" type="submit" name="submitProcess" value="<?=$data['ThisPageLabel'];?> NOW!" class="submitProcess nopopup nextProcess submitbtn btn btn-icon btn-primary final" autocomplete="off"  ><b class="contitxt">
			<? if($data['withdraw_gmfa']){?>
				<i class="far fa-check-circle"></i> Authenticate
			<? }else{?>
				<? if(isset($data['ButtonLabel'])&&$data['ButtonLabel']){?>
					<?=$data['ButtonLabel'];?>
				<? }else{?>
					<?=$data['ThisPageLabel'];?>
				<? }?>
				
			<? }?>
			</b></button>
		 <? }else{?>
			<button id="b_next" type="submit" name="steps" value="<?=$data['ThisPageLabel'];?> NOW!" class="nopopup nextProcess submitbtn btn btn-icon btn-primary" autocomplete="off"><b class="contitxt"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Continue</b></button>
		 <? }?>
		</span> 
		
		<? if($post['step']==2){ ?>
			<a href="<?=$data['USER_FOLDER']?>/withdraw-fund-list<?=$data['ex']?>" 
		onClick="javascript:$('#modalpopup_form_popup').show(200);" class="nopopup back_button submitbtn btn btn-icon btn-primary" autocomplete="off"  ><b class="contitxt"><i class="<?=$data['fwicon']['back'];?>"></i> Back</b></a>
		<? }else{?>
			<button type="submit" name="backButton" value="backButton" class="backButton nopopup backBtn btn btn-icon btn-primary" form="backFormReq"  ><i class="<?=$data['fwicon']['back'];?>"></i> Back</button>
		<? }?>
		

	</div>

	
	  
</form>

<form method="post" id="backFormReq" style="display:none;" >
<div style="display:none;">
  <input type="hidden" name="step" value="<?=$post['step']?>">
  <input type="hidden" name="BankType" id="BankType_back" value="<?=(isset($_POST['BankType'])?$_POST['BankType']:'')?>">
  <input type="hidden" name="bank" id="bank_id_back" value="<?=(isset($_POST['bank'])?$_POST['bank']:'')?>">
  <input type="hidden" name="bank_back" id="bank_id_back" value="<?=(isset($_POST['bank'])?$_POST['bank']:'')?>">
  <input type="hidden" name="bank_get" id="bank_get_back" value="<?=(isset($_POST['bank_get'])?$_POST['bank_get']:'')?>">
  <textarea name="note" id="note_back" style="display:none;" ><?=(isset($_POST['note'])?$_POST['note']:'')?></textarea>
  <textarea name="comments" id="comments_back" style="display:none;" ><?=(isset($_POST['comments'])?$_POST['comments']:'')?></textarea>
  <input type="hidden" name="requested_currency" id="requested_currency_id_back" value="<?=(isset($_POST['requested_currency'])?$_POST['requested_currency']:'')?>">
  <input type="hidden" name="inputTotalOriginalAmt" id="inputTotalOriginalAmt_back" value="<?=(isset($_POST['inputTotalOriginalAmt'])?$_POST['inputTotalOriginalAmt']:'')?>">
  <input type="hidden" name="requested_currency" id="requested_currency_id_back" value="<?=(isset($_POST['requested_currency'])?$_POST['requested_currency']:'')?>">
  <input type="hidden" name="amount"  id="amount_id_back" value="<?=(isset($_POST['amount'])?$_POST['amount']:'')?>">
  <input type="hidden" name="inputBankName" id="inputBankName_back" value="<?=(isset($_POST['inputBankName'])?$_POST['inputBankName']:'')?>">
  <input type="hidden" name="inputCovertedAmt" class="inputCovertedAmt" id="inputCovertedAmt_back" value="<?=(isset($_POST['inputCovertedAmt'])?$_POST['inputCovertedAmt']:'')?>">


  <button id="b_next" type="submit" name="backButton" value="backButton" class=" nopopup submitbtn btn btn-icon btn-primary glyphicons circle_ok " autocomplete="off" style="width:90px !important;font-size:16px;" >BACK</button>

  
</div>
</form>



</div></div>
<? } ?>

<? }else{?>
SECURITY ALERT: Access Denied
<? }?>
