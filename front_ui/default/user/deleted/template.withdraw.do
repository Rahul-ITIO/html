<? if(isset($data['ScriptLoaded'])){ ?>
<style>
	
.input_col_1 input.checkbox {width:24px;position:relative;top:-9px;}
.input_col_1 .radios label {width: auto;}
.separator {margin:0px 0;display:block;clear:both;}
.remarkcoment{width:100% !important;min-height:60px !important;}

label{font-weight:bold;color:#000;}

.bank_radio {/*margin:0px 0 0 0!important;*/} 
.bank_accord{width:100%!important;clear:both;float:left;background:#ececec;margin:5px 0;border-radius:4px;padding:0 13px}
.widget-body.input_col_1 .span12 .bank_accord .bank_name label {width:38% !important;font-weight: normal;}

.modalMsgContTxt{padding:10px 20px}
.modalMsgContTxt h4{margin:10px 0px}
.modalMsgContTxt p{font-size:16px;margin:10px 0 10px 0}
.submit_div{padding:0px 0px;height:auto;text-align:center;width:100%;float:left}
#b_submit,#b_next,.submit_next{/*width:110px !important;margin:0;float:none;*//*padding:11px 0;*//*font-size:24px;height:40px*/}

.bank_details_col{width:50px;display:inline-block;padding:0 10px;background:#e1dede;line-height:28px;text-align:center;border-radius:3px;font-size:14px;margin:0 0 0 7px}

.modalpopup_cdiv td{border:0!important;padding:1px 5px;font-size:14px!important}
.modalpopup_body{border:2px solid #e37c18;width:500px;margin:-195px 0 0 -250px;}
.modalpopup_cdiv{float:left;width:96%;margin:3%;background:#fff;overflow:auto;max-height:366px}

@media (max-width:1024px){ 
	.bank_accord {width: 100% !important;clear:both;}
}

@media (max-width:760px){ 
	 #receiver_user_id {width:98% !important;}
	 .input_col_1 label {width: 55%;margin-top:0;margin-bottom:0;}
	 #amount_id {width:97% !important; margin:0 auto;margin-bottom:10px;float:left;}
	 .glyphicons.btn-action i::before{top:0 !important;left:55% !important;}
	 label[for="wire_fee"]{width:75% !important;}
	 label[for="requested_currency_id"]{margin-top:20px !important;}
	 label[for="amount_cnvrt"]{width:60% !important;}
	 #requested_currency_id{width:98% !important; margin:0 auto !important;}
	 label[for="amount_id"]{width:98%;}
}
@media (max-width:675px){ 
	  #amount_id {width:95% !important; margin:0 auto;margin-bottom:10px;float:left;}
}
@media (max-width:600px){ 
	 .input_col_1 label {width: 98%;margin-top:0;margin-bottom:0;}
	  #amount_id {width:95% !important; margin:0 auto;margin-bottom:10px;float:left;}
}
@media (max-width:460px){ 
	  #amount_id {width:94% !important; margin:0 auto;margin-bottom:10px;float:left;}
}
</style>
<script>
var subQueryString="";
var amountCh="";	
<? if ($_SESSION ['adm_login'] && isset ( $_GET ['admin'] ) && $_GET ['admin']) {
		$s_query=http_build_query($_GET);
	?>
	subQueryString="<?php echo $s_query;?>";		
<? } ?>

var wn='';
consub=0;
var bankCountNo='';
$(document).ready(function(){
	
	
	

	$('.bank_details_col').click(function(){
		var countNo=$(this).attr('data-count');
		
		var bankHtml=$('.bank_count_'+countNo).find('.bank_accord_div_table').html();
		var Modtitle=$('#bnkidx').html();
		$('.modal-title').css({"font-size":"12px"});
		$('#myModal .modal-dialog').css({"max-width":"600px"});
		$('#myModal .modal-title').html(Modtitle);
		
		$('#myModal .modal-body').html(bankHtml);
		
		$('#myModal').modal('show');
		
		//$('#modalpopup_cdiv').html(bankHtml);
		//$('#modalpopup').slideDown(1000);
	});
	
	$('.bank_accord').click(function(){
		
		var thisCheck = $(this).find(".bank_input").val();
		
		//alert('\r\n thisCheck: '+thisCheck);
		
		if($(this).find(".bank_input").hasClass('bank_2')){
			bankCountNo=$(this).attr('data-count');	
			$(this).find(".bank_input").prop('checked', true);
		}else{
			$(this).find(".bank_input").prop('checked', false);
			alert("We cannot process withdrawal for:\n \"" +$(this).find('label b').text()+ "\"\nKindly contact to support for further information\r\n");
			return false;
		}
		
		
		if($(this).hasClass('active')){
			
		}else{
			$('.bank_accord').removeClass('active');
			
			
			
			var rcb=$(this).next().find('.required_currency_bank').text();
			
			//$('#noteId').removeAttr("name");
			
			$('table #noteId').attr("name","notes1");
			
			//$("table #noteId").each(function() { $(this).removeAttr("name"); });
			
			$(this).next().find('#noteId').attr("name","note");
			
			$('#requested_currency_id option').removeAttr('selected');
			
			$("#requested_currency_id option[value='"+$(this).next().find('.required_currency_bank').text()+"']").prop('selected','selected');
			$("#requested_currency_id option[value='"+$(this).next().find('.required_currency_bank').text()+"']").attr("selected","selected");
			
			$('#requested_currency_id,#amount_id').removeClass('active_fn');
			$("#requested_currency_id").val(rcb).trigger('focusout');
			
			if(thisCheck=='crypto'){
				
			}
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
				url: "<?=$data['Members']?>/<?=$data['ThisPageUrl'];?>",
				type: "POST",
				dataType: 'json', 
				data: "action=receiver_profile&json=1&receiver_user_id="+$(this).val(),
				success: function(results){
					$('#receiver_user_id').addClass('active_fn');
					
					if(!results["receiver_jsn"]){
						alert(results);
					}else{
						setTimeout(function(){ 
							//$('#wire_fee_cnvrt').html(""+results["wire_fee"]);
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
			<? if($data['ThisPageLabel']=='Send'){ ?>
				amount=$('#amount_id').val();	
			<? }else{ ?>
				//amount="<?=$post['amount'];?>";
				amount=$('#amount_id').val();	
			<? } ?>
			
			
			
			var url_name="<?=$data['Members']?>/<?=$data['ThisPageUrl'];?>?action=convertamt"+subQueryString;
			
			//alert("\r\n | amount: "+amount+"\r\n | requested_currency: "+$('#requested_currency_id').val()+"\r\n | subQueryString: "+subQueryString+"\r\n | this value: "+$(this).val()+"\r\n | this url_name: "+url_name);
			
			var withdrawfee = $('.bank_count_'+bankCountNo).find('.withdrawFee_bank').text();
			var bnkVal=$("input[type='radio'].bank_input:checked").val();
			//alert(url_name+"\r\n"+withdrawfee);
			
			$.ajax({
				url: url_name,
				type: 'POST',
				dataType: 'json', 
				data:{action:"convertamt", amount:amount, withdraw_fee:withdrawfee, bank:bnkVal, json:"1", requested_currency:$('#requested_currency_id').val()},
				success: function(data){
					$('#requested_currency_id,#amount_id').addClass('active_fn');
					
					//myObj = JSON.parse(data);
					<? if(isset($_REQUEST['a'])&&$_REQUEST['a']=='c'){ ?>
						alert(JSON.stringify(data));
					<? } ?>
					
					if(!data["amount_jsn"]){
						alert("Opps: "+data['Error']);
					}else{
						setTimeout(function(){ 
							if(withdrawfee>0 && data["withdrawfee_calc"]){
								$('#withdrawFeeTextId').html(withdrawfee);
								$('#withdrawFeeCalcTextId').html(data["withdrawfee_calc"]);
								$('#withdrawFeeTextRowId').show();
							}else{
								$('#withdrawFeeTextRowId').hide();
							}
							
							$('#selectedAmtId').html(amount);
							$('#amount_cnvrt').html(""+data["amount_jsn"]);
							if(data["amount_total_jsn"]){
								//alert(data["amount_total_jsn"]);
								$('#totalAmtId').html(""+data["amount_total_jsn"]);
							}
							<? if($data['withdraw_gmfa']){ ?>
								if(data["amount_total_jsn"]){
								 $('.mfa_totalAmt').html("Total <?=$data['ThisPageLabel'];?> Amount : <b class='s24'> "+data["amount_total_jsn"]+" <?=prntext($post['ab']['account_curr'])?></b>");
								 $('.mfa_payoutAmt').html("Payout Amount : <b class='s24'> "+data["amount_jsn"]+"</b>");
								 $('.mfa_selectedBank').html("Current Bank : <b class='s24'> "+$('.bank_input_row_'+bankCountNo).find('label').html()+"</b>");
								}
							<? } ?>
							<? if($data['HideAllMenu']){ ?>
								//top.window.resizeIframes('iframe_withdrawal');
							<? } ?>
						}, 50);
					}
					
				}
			});
		
		}	
	});
	
	<? if($post['bank']){ ?>
		$("input[id='<?=$post['bank']?>bank']").eq(0).trigger("click");
	<? }else{ ?>
		//$("input[name='bank']").eq(0).trigger("click");
	<? } ?>
	
	
	<? if($data['bank_id']){ ?>
		$(".bank_accord input[value='<?=$data['bank_id']?>']").eq(0). prop("checked", true).trigger("click");
	<? } ?>
	
	
	
	$('#myFormReq1').bind('submit', function(){ 
		var retVal= confirm('OK!: Do you really want to submit the form?');
		if (retVal) {
			return true;
			//e.preventDefault();
			
		} else {			
			return false;
		}
	});
	
	<? if($data['HideAllMenu']){ ?>
		//top.window.resizeIframes('iframe_withdrawal');
	<? } ?>
	
	
	
	$("#a_submit").on("click", function(event) {
		
		$('#modalpopup_form_popup').show(200);
		<? if(isset($_SESSION['adm_login'])){ ?>
			subQueryString="?action=convertamt&amount="+$('#amount_id').val()+"&json=1&requested_currency="+$('#requested_currency_id').val();
			urls="<?=$data['Members']?>/<?=$data['ThisPageUrl'];?>"+subQueryString;
			if(wn){
				window.open(urls,'_blank');
				alert(urls);
			}
			
		<? } ?>
		var url_name="<?=$data['Members']?>/<?=$data['ThisPageUrl'];?>?action=convertamt"+subQueryString;
		
		$.ajax({
			url: url_name,
			type: "POST",
			dataType: 'json', 
			data:{action:"convertamt", amount:$('#amount_id').val(), json:"1", requested_currency:$('#requested_currency_id').val()},
			success: function(data){
				
				//myObj = JSON.parse(data);
				<? if(isset($_REQUEST['a'])&&$_REQUEST['a']=='c'){ ?>
					alert(JSON.stringify(data));
				<? } ?>
				
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
	
	$('#myFormReq').submit(function(e){ 
	  try {
		if($('#b_submit').hasClass('active')){
			return true;
		}else{ 
		 <? if($data['withdraw_gmfa']){ ?>
		  //alert('MFA');
		  $('#modal_with_div1').html($('#calculate_div_id').html());
		  $('#modal_mfa').show(200);
		 <? }else{ ?>
			$("#b_submit").attr("name","send");
			$('#b_submit').addClass('active');
			$('#modal_msg').show(200);
			
		  <? } ?>
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
<div  class="container border mb-2 mt-2 bg-white">

  <? if($post['step']<4){ ?>
  <form method="post" id="myFormReq">
    <input type="hidden" name="step" value="<?=$post['step']?>">
    <input type="hidden" id="consub" value="false">
    <? if($post['step']==1){ ?>
    <? if(!isset($data['HideAllMenu']) || empty($data['HideAllMenu'])){ ?>
    <div class="heading-buttons">
      <? if(($post['withdraw_option']==2)&&(isset($data['statement_withdraw']))){} ?>
      <div class="clearfix" style="clear: both;"></div>
    </div>
    <? } ?>
  <!--  <div class="separator"></div>
    <div class="well">-->
    <? if((isset($data['Error'])&& $data['Error'])){ ?>
    <div class="alert alert-warning alert-dismissible fade show" role="alert">
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      <strong>Error!</strong>
      <?=prntext($data['Error'])?>
    </div>
    <? } ?>
    <? if(!isset($data['submitFalse'])){ ?>
 <!--   <div class="tab-pane active" id="account-settings">
    <div class="widget widget-2">
    <div class="widget-head">-->
    <h4 class="heading my-2"><i class="<?=$data['fwicon']['coins'];?>"></i> Options of <?=$data['ThisTitle'];?></h4>
      
    
    <div class="breadcrumb" style="height:inherit;<?=((isset($data['HideAllMenu'])&&$data['HideAllMenu'])?"display:block !important;":"")?>">
      <? include("../include/summery_balance_link".$data['iex']);?>
      <div class="row col-sm-12 my-2 px-2 border-2">
        <div class="col-sm-3"> <i class="<?=$data['fwicon']['hand'];?>"></i> <a class="fund_3">Wire Fee : <b>
          <?=$post['ab']['account_curr_sys'];?>
          <?=$post['wire_fee'];?>
          </b></a> </div>
        <? if($data ['ThisPageLabel'] != 'Rolling'){ ?>
        <div class="col-sm-3"> <i class="<?=$data['fwicon']['hand'];?>"></i> <a class="fund_3">
          <?=$data['ThisPageLabel'];?>
          Minimum: <b>
          <?=$post['ab']['account_curr_sys'];?>
          <?=$post['withdraw_min_amt'];?>
          </b> </a></div>
        <? } ?>
        <? if($data['con_name']=='clk'&&isset($_SESSION['adm_login'])&&isset($_REQUEST['admin'])){ ?>
        <? if($post['total_mdr_amt']){ ?>
        <div class="col-sm-3"> <i class="<?=$data['fwicon']['hand'];?>"></i> <a class="fund_3">Total MDR Amt. : <b>
          <?=$post['ab']['account_curr_sys'];?>
          <?=$post['total_mdr_amt'];?>
          </b></a></div>
        <? } ?>
        <? if($post['total_mdr_txtfee_amt']){ ?>
        <div class="col-sm-3"> <i class="<?=$data['fwicon']['hand'];?>"></i> <a  class="fund_3">Transaction Fee : <b>
          <?=$post['ab']['account_curr_sys'];?>
          <?=$post['total_mdr_txtfee_amt'];?>
          </b></a></div>
        <? } ?>
        <? if($post['total_gst_fee']){ ?>
        <div class="col-sm-3"> <i class="<?=$data['fwicon']['hand'];?>"></i> <a  class="fund_3"></i> Total GST Fee @
          <?=$post['gst_fee'];?>
          : <b>
          <?=$post['ab']['account_curr_sys'];?>
          <?=$post['total_gst_fee'];?>
          </b></a></div>
        <? } ?>
        <? } ?>
      </div>
    </div>
 <!--   <div class="widget-body input_col_1" style="padding-bottom: 0;">
    <div class="row-fluid">-->
    <div class="span12">
    <? if($data['ThisPageLabel']=='Send'){ ?>

      <label for="receiver_user_id">Receiver User ID</label>
      <input required type="text" name="receiver_user_id" id="receiver_user_id" class="span4 form-control" value="<?=$post['receiver_user_id']?>" placeholder="Enter Receiver User ID" style="width:12%" />
      <span id="receiver_user_id_details" class="span8" style="width:55%"> </span> 
	  </div>
    <? } ?>
    <div class="separator" style="display:none;clear:both;float:left;width:100%;margin:10px 0 -10px 0;">
      <label for="wire_fee">Wire Fee</label>
      <b>
      <?=$post['ab']['account_curr_sys'];?>
      <?=$post['wire_fee'];?>
      </b>
      <div id="wire_fee_cnvrt">&nbsp;</div>
    </div>
    <?
$am=true;
if($post['amount']<1&&!isset($_GET['admin'])&&($data['ThisPageLabel']!='Send')){
$am=0;
	?>
    <div class="alert alert-danger alert-dismissible fade show" role="alert"> 
	<strong>Alert !</strong> <strong>In-sufficient balance: </strong> You have in-sufficient balance to initiate withdrawal. 
      Please contact <b>Support</b> for more information. </div>
    <? if(isset($data['HideAllMenu'])&&$data['HideAllMenu']){ ?>
    <script>
		top.window.resizeIframes('iframe_withdrawal');
		</script>
    <? } ?>
    <? exit;} ?>
    <? if($am==1){ ?>
    <div class="separator" style="display:block;clear:both;float:left;width:100%;"></div>
    <div class="separator"></div>
    <?php
$amt=$post['ab']['account_curr_sys'].$post ['summ_mature_amt'].' - (';
$amt.=$post['ab']['account_curr_sys'].$post['wire_fee'];

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
    <label> </label>
    <div id="calculate_div_id" class="g row" > <!--style="float:left;width:50%;"-->
      <div class="w30 col-sm-3">Selected <?=$data['ThisPageLabel'];?>&nbsp;Amount</div>
      <div class="w70 col-sm-3">: <b id="selectedAmtId"><?=($post['ab']['account_curr_sys'].$post['amount']);?></b>
        <?=prntext($post['ab']['account_curr'])?>
      </div>
      <font id="withdrawFeeTextRowId" class="hide">
	  <div class="col-sm-12 row">
      <div class="w30 col-sm-3">
        <?=$data['ThisPageLabel'];?>
        &nbsp;Fee <b id="withdrawFeeTextId"> </b>% </div>
      <div class="w70 col-sm-3">: <b id="withdrawFeeCalcTextId"> </b>
        <?=prntext($post['ab']['account_curr'])?>
      </div>
	  </div>
      </font>
      <? if($post['wire_fee']>0){ ?>
      <div class="w30 col-sm-3">Wire Fee</div>
      <div class="w70 col-sm-3">: <b>
        <?=($post['ab']['account_curr_sys'].$post['wire_fee'])?>
        </b></div>
      <? } ?>
      <? if($post['monthly_fee']>0){ ?>
      <div class="w30 col-sm-3">Monthly Fee</div>
      <div class="w70 col-sm-3">: <b>
        <?=($post['ab']['account_curr_sys'].$post['monthly_fee'])?>
        </b></div>
      <? } ?>
      <? if($post ['total_gst_fee']>0){ ?>
      <div class="w30 col-sm-3">GST Fee</div>
      <div class="w70 col-sm-3">: <b>
        <?=($post['ab']['account_curr_sys'].$post['total_gst_fee'])?>
        </b></div>
      <? } ?>
      <? if($post ['virtual_fee1']>0){ ?>
      <div class="w30 col-sm-3">Virtual Terminal Fee</div>
      <div class="w70 col-sm-3">: <b>
        <?=($post['ab']['account_curr_sys'].$post['virtual_fee1'])?>
        </b></div>
      <? } ?>
      <div class="w30 col-sm-3"> Total
        <?=$data['ThisPageLabel'];?>
        &nbsp;Amount</div>
      <div class="w70 col-sm-3">: <b id="totalAmtId">
        <?=($post['ab']['account_curr_sys'].$post['summ_mature_amt']);?>
        </b>
        <?=prntext($post['ab']['account_curr'])?>
      </div>
    </div>
	<div class="row">
	<div class="col-sm-3">
    <label for="amount_id" style="height:auto;clear:left;">
    <?=$data['ThisPageLabel'];?> &nbsp;Amount <?=prntext($post['ab']['account_curr'])?>
    
    <span style="display:none;overflow-wrap: break-word;word-wrap: break-word;margin: 0;" class="btn-action single glyphicons circle_question_mark" data-toggle="tooltip" data-placement="top" data-original-title="You can <?=$data['ThisPageLabel'];?> Mature Fund-{<?=($data['con_name']=='clk'?"GST FEE+":"");?>Wire Fee+Monthly Fee+Virtual Terminal Fee+Any Other charges (If Applicable) } i.e. (<?=$amt?>= <?=$post['amount'];?>)"><i class="<?=$data['fwicon']['circle-question'];?>"></i></span>
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
    </label>
	</div>
	<div class="col-sm-3">
   <?=$post['ab']['account_curr_sys'];?>
    
    
    <input required type="text" name="amount" id="amount_id" class="span10 form-control float-end" value="<?=$post['amount']?>"  style="width:90%" />
	</div>
	</div>
	
    <? if($data['ThisPageLabel']=='Withdraw'||$data['ThisPageLabel']=='Rolling'){/*?> disabled <?*/ } ?>
    <div class="my-3 row ">
	<div class="col-sm-3 my-2">
      <label for="amount_cnvrt">
      <? if($data['ThisPageLabel']=='Withdraw'){ ?>
      Your Payout Amount
      <? }else{ ?>
      Converted Currency
      <? } ?>
      </label>
	  </div><div class="col-sm-3 my-2">
      <b id="amount_cnvrt">&nbsp;</b>
	  </div>
	  
	  </div>
    <div class="separator"></div>
	<div class="row">
	<div class="col-sm-3">
    <label for="requested_currency_id">Requested Currency of
    <?=$data['ThisTitle'];?>
    </label>
	</div>
	<div class="col-sm-3">
    <select name="requested_currency" id="requested_currency_id"  class="form-select" placeholder="Requested Currency of <?=$data['ThisPageLabel'];?>">
		<?foreach ($data['AVAILABLE_CURRENCY'] as $k11) {?>
			<option value="<?=$k11?>"><?=$k11?></option>
		<?}?>
    </select>
    <script>
$('#requested_currency option[value="<?=prntext($post['requested_currency'])?>"]').prop('selected','selected');
</script>
    </div>
	</div>
    <div class="separator" style="display:block;clear:both;float:left;width:100%;height:20px;"></div>
    <? if($data['ThisPageLabel']=='Withdraw'||$data['ThisPageLabel']=='Rolling'){ ?>
    <? if($data['crypto']){ ?>
    <table  class="table">
      <tr>
        <td class="capl" style="background-color:#DDDDDD"><div class="bank_accord bank_input_row_crypto" data-count="crypto" style="clear:both !important;">
            <div class="bank_radio">
              <input required type="radio" name="bank" value='crypto' <? if($post['bank']=="crypto")
				{
				?>
					<? $bankchecked=true; ?> 
					checked
				<? } ?>
				 id="<?="crypto"?>bank" style="border:0" class="bank_2 bank_input form-check-input" >
              &nbsp; </div>
            <div class="bank_name">&nbsp;
              <label for="<?="crypto"?>bank"> <b>Crypto</b> </label>
            </div>
          </div>
          <div class="hide bank_accord_div" style="float:left;width:100%;display:none;">
<input type="hidden" name="display_bank_name" value='crypto' />
<textarea name="bank_get" placeHolder="Enter Crypto Details" class="form-control" style="height:150px;width:98%;"><?=$post['bank_get'];?>
</textarea>
            <div class="input required_currency_bank" style="display:none;">
              <?=($post['ab']['account_curr']);?>
            </div>
            <div class="hide bank_accord_div_textArea" style="float:left;width:100%;"> </div>
            <div class="hide bank_accord_div_table" style="float:left;width:100%;"> </div>
          </div></td>
      </tr>
    </table>
    <? } ?>
    <? $bnkInfo=array();if($post['BanksInfo']){ ?>
	<div class="container border border-primary border-3 my-2"	>
    <table class="table">
      <? $k=0;foreach($post['BanksInfo'] as $key=>$val){ $k++;$bnkInfo[$key]=$val;$bnkInfoJson=json_encode(array($key=>$val));$bnkInfoJson=str_replace(array('[',']'),array('',''),$bnkInfoJson);?>
      <tr>
        <td colspan=2 class="capl" style="background-color:#DDDDDD">
	
		
		  <div class="bank_accord bank_input_row_<?=($k);?>" data-count="<?=($k);?>">
            <!-- Start Bank Options -->
            <div class="bank_radio float-start my-2">
              <input required type="radio" name="bank" value='<?=$val['id'];?>' <? if(($val['id']==$post['bank']||strpos($post['bank'],'"id":"'.$val['id'].'"')!==false)||($data['bank_id']==$val['id']))
			{
			?>
				<? $bankchecked=true;?> 
				checked
			<? } ?>
			 id="<?=$val['id']?>bank" style="border:0" class="bank_<?=$val['primary']?> bank_input form-check-input" >
             </div>
            <div class="bank_name float-start">
              <div class="float-start my-2"><label for="<?=$val['id']?>bank"> <b><?=ucwords(strtolower(prntext($val['bname'])))?></b> (ending with <?=encode($val['baccount'],4);?>) </label></div>
              
             <div data-count="<?=($k);?>" class="bank_details_col btn btn-sm btn-primary my-2 float-start">View</div>
            </div>
            <!-- End Bank Options -->
          </div>
		  
          <div class="hide bank_accord_div bank_count_<?=($k);?>" style="float:left;width:100%;">
            <input type="hidden" name="display_bank_name" value='<?=prntext($val['bname']);?> (ending with <?=encode($val['baccount'],4);?>)' />
            <div class="bank_accord_div_textArea" >
              <textarea name="notes" id="noteId" placeholder="Add Comment" class="span11 remarkcoment form-control me-2"></textarea>
            </div>
            <div class="hide bank_accord_div_table" style="float:left;width:100%;">
              <? if($val['withdrawFee']){ ?>
              <div class="hide withdrawFee_bank" >
                <?=prntext($val['withdrawFee'])?>
              </div>
              <? } ?>
              <table  class="table table-primary table-striped">
                <? if($val['bname']){ ?>
                <tr>
                  <td class=field  width="45%">Bank Name:</td>
                  <td class=input ><b id="bnkidx">
                    <?=prntext($val['bname'])?>
                    </b></td>
                </tr>
                <? }if($val['baddress']){ ?>
                <tr>
                  <td class=field >Bank Address:</td>
                  <td class=input ><?=prntext($val['baddress'])?></td>
                </tr>
                <? }if($val['bcity']){ ?>
                <tr>
                  <td class=field >Bank City:</td>
                  <td class=input ><?=prntext($val['bcity'])?></td>
                </tr>
                <? }if($val['bzip']){ ?>
                <tr>
                  <td class=field >Bank ZIP Code:</td>
                  <td class=input ><?=prntext($val['bzip'])?></td>
                </tr>
                <? }if($val['bcountry']){ ?>
                <tr>
                  <td class=field >Bank Country:</td>
                  <td class=input ><?=prntext($data['Countries'][$val['bcountry']])?></td>
                </tr>
                <? }if($val['bstate']){ ?>
                <tr>
                  <td class=field >Bank State:</td>
                  <td class=input ><?=prntext($val['bstate'])?></td>
                </tr>
                <? }if($val['bphone']){ ?>
                <tr>
                  <td class=field >Bank Phone:</td>
                  <td class=input ><?=prntext($val['bphone'])?></td>
                </tr>
                <? }if($val['bnameacc']){ ?>
                <tr>
                  <td class=field >Account Holder's Name:</td>
                  <td class=input ><?=prntext($val['bnameacc'])?></td>
                </tr>
                <? }if($val['full_address']){ ?>
                <tr>
                  <td class=field >Full Address of Account Holder:</td>
                  <td class=input ><?=prntext($val['full_address'])?></td>
                </tr>
                <? }if($val['baccount']){ ?>
                <tr>
                  <td class=field >Account Number:</td>
                  <td class=input ><b style="font-size:14px;">
                    <?=encode($val['baccount'],4);?>
                    </b></td>
                </tr>
                <? }if($val['btype']){ ?>
                <tr>
                  <td class=field >Account Type:</td>
                  <td class=input ><?=prntext($data['BankAccountType'][$val['btype']])?></td>
                </tr>
                <? }if($val['required_currency']){ ?>
                <tr>
                  <td class=field >Requested Currency:</td>
                  <td class="input required_currency_bank" ><?=prntext($val['required_currency'])?></td>
                </tr>
                <? }if($val['brtgnum']){ ?>
                <tr>
                  <td class=field >9 Digits Routing Number:</td>
                  <td class=input ><?=prntext($val['brtgnum'])?></td>
                </tr>
                <? }if($val['bswift']){ ?>
                <tr>
                  <td class=field >S.W.I.F.T. Code:</td>
                  <td class=input ><?=prntext($val['bswift'])?></td>
                </tr>
                <? } ?>
              </table>
            </div>
          </div>
		  
  
		  
          <? } ?></td>
      </tr>
    </table>
	  </div>
    <? } ?>
    <? } ?>
    <div style="margin: 0; padding-right: 0; border:none; text-align:center; width:100%;">

      <span class="submit_div">
      <button id="b_next" type="submit" name="sends" value="<?=$data['ThisPageLabel'];?> NOW!" class="nopopup submitbtn btn btn-icon btn-primary my-2" autocomplete="off" style="width:250px !important" ><b class="contitxt">
      <i class="<?=$data['fwicon']['check-circle'];?>"></i> <?=$data['ThisPageLabel'];?>
      </b></button>
      </span> </div>
    <div class="modal_msg" id="modal_msg" style="display: none;">
      <div class="modal_msg_layer"> </div>
      <div class="modal_msg_body" style="width: 300px; height: 270px;"> <a class="modal_msg_close" onclick="document.getElementById('modal_msg').style.display='none';">×</a>
        <div id="modal_msg_body_div">
          <div class="modalMsgContTxt">
            <h4>Message</h4>
            <p><b>Do you want to process your?</b></p>
            <span class="submit_div">
            <button id="b_submit" type="submit" name="sends" value="<?=$data['ThisPageLabel'];?> NOW!" class="nopopup submitbtn btn btn-icon btn-primary glyphicons circle_ok  my-2" autocomplete="off" style="width:35%"><b class="contitxt"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Yes</b></button>
            </span> </div>
        </div>
        <a class="modal_msg_close2" onclick="document.getElementById('modal_msg').style.display='none';">Close</a></div>
    </div>
    <? } ?>
    <? } ?>
    <? }elseif($post['step']==2){ ?>
    Step 2
    <? } ?>
  </form>
  <? if($data['withdraw_gmfa']){
	$data['user_pass_gmfa']=1;
?>
  <? include('../include/device_confirmations'.$data['ex']);?>
  <? } ?>
</div>
<? }
?>

</div>
<?

}else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
