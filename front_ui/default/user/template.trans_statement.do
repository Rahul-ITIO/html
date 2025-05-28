<? if(isset($data['ScriptLoaded'])){ ?>
<style>

.prompt_dialog_layer {
    display: block;
    position: fixed;
    z-index: 9999999999999999999999999;
    width: 100%;
    height: 100%;
    background: #000;
    opacity: 0.5;
    top: 0;
    left: 0;
}
.prompt_dialog {display:block;position:absolute;z-index:999999999999;width:300px;    height:150px;background:#fff;opacity:1;border-radius:5px;left:50%;top:0%;margin:0px 0 0 -150px;border:2px #d2d2d2 solid;font-size:12px;}
.dialog_box2.glyphicons.remove_2 i:before {left: 0px;top: 1px;}



@media(max-width:900px){
	form .add_remark_submit {
		width: auto;
		margin: -2px 0 10px 0 !important;
	}
	
	.clients .widget-cl2 .btn.btn-icon.btn-primary.glyphicons.search{width: 30px !important;min-width: 30px !important;}
} 

@media(max-width:500px){
	.action_link .txt {
		position: relative;
		margin: -22px 0 -8px -25px;
	}
	.action_link a {
		position: relative;
		left: -25px;
	}
	.ui-dialog-titlebar-close.dialog_box2 {
		width: 60px;
		right: -10px !important;
		top: -10px !important;
	}
	
}
</style>

<style>
.pricecolor font[color="green"]{color:#FFCC00; }
.pricecolor font[color="red"]{color: #CC0000;}
</style>
<script>
function dialog_box2f(){
	//data-amount
	var confirm_amount="";
	
	var data_active = $('.dialog_refunded.active');
	var data_amount	= data_active.attr('data-amount');
	var datahref 	= $('.dialog_refunded.active').attr('data-href');
	
	//alert(datahref);
	
	if(datahref !== undefined){	
		data_active.attr('data-href',data_active.attr('data-href')+"&promptmsg="+data_active.attr('data-reason')+" for <font class=m_refund_amt>"+$('#dialog_box2 #confirm_amount').val()+"</font> from "+$('#dialog_box2 #order_amount').text()+" : "+$('#dialog_box2 #prompt_msg_input').val()+"&confirm_amount="+$('#dialog_box2 #confirm_amount').val());
		
		$('#modalpopup_form_popup').slideDown(900);
		
		$.ajax({url: data_active.attr('data-href'), success: function(result){
			//$("#modal_popup_iframe_div").html(result);
			$('#modalpopup_form_popup').slideUp(70);
			top.window.location.href="<?=$data['USER_FOLDER'];?>/<?=($data['FileName'])?>?action=select&type=-1&status=-1&keyname=19&searchkey=2";
		}});
		
		//newWindow=window.open(data_active.attr('data-href'), 'hform');
		
		//top.window.location.href=data_active.attr('data-href');

	}
	
	$("#dialog_box2").slideUp(200);

	
 }
$(document).ready(function(){

	$('.iframe_open').click(function(){	
		var subqry=$.trim($(this).text());
		var mid = $(this).attr('data-mid');
		if(mid !== undefined){subqry=$.trim(mid);}
		$('.mprofile').removeClass('mactive');
		$(this).addClass('mactive');
		
		var urls=$(this).attr('data-ihref')+"&actionuse=insert&hideAllMenu=1&bid="+subqry;
		$("#modalpopup_form_iframe_div").html("<div class='loading'>Now loading url.<br/><br/><img src='<?php echo $data['Host']?>/images/icons/loading_spin_icon.gif' style='width:270px;position:relative;top:-180px;'> <div class='waitxt plea1'>Please wait...</div></div>");
		var mprofiledata='<iframe name="dusframe" id="dusframe" src='+urls+' width="100%" height="580" scrolling="auto" frameborder="0" marginwidth="0" marginheight="0" style="width:98%!important;height:580!important;display:block;margin:20px auto;" ></iframe>';
		$.ajax({url:urls, success: function(result){
			$("#modalpopup_form_iframe_div").html(mprofiledata);
		}});
		
		$('#modalpopup_form_popup').slideDown(900);
    });
	
	
	
	$('.dialog_refunded').click(function() {
		$('#dialog_box2 #prompt_msg_input').val('');
		
		$('.dialog_refunded').removeClass('active');
		$("#dialog_box2").removeClass('active');
		$(this).addClass('active');
		$("#dialog_box2").addClass('active');
		
		tv=topInViewport(this);
		//alert('tv=>'+tv);
		
		<? if(isset($_REQUEST['searchkey'])){ ?>
			tv=tv-100;
		<? } ?>
		
		if(tv){ $(".dialog_box2_body_div").animate({top:tv,position:'absolute !important'}, 500); }
		
		$("#dialog_box2").slideDown(700);
		var datalabel = $(this).attr('data-label');
		
		//alert(datalabel);
		
		var data_active = $('.dialog_refunded.active');
		var data_amount	= data_active.attr('data-amount');
		
		$('#dialog_box2 #confirm_amount').val(data_amount);
		$('#dialog_box2 #order_amount').html(data_amount);
	
		if(datalabel !== undefined){
			$("#dialog_box2 #ui_id_1").html(datalabel);
		}
	});
	$('#dialog_box2 #prompt_msg_input').on('keyup',function(event){
		if(event.keyCode == 13){
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
	
	<? if(isset($_GET['csearch'])&&!empty($_GET['csearch'])){ ?>
		$('.acc3.advLdiv').trigger('click');
	<? } ?>
	
});
</script>
<div  class="container border my-2 bg-primary rounded">
<div class="heading-buttons vkg my-2">
  <!--<h3 class=""><i></i><?=prntext($data['PageName'])?></h3>-->
  <h4 class="float-start"><i class="<?=$data['fwicon']['mystatement'];?>"></i> 
  <? if($data['frontUiName']=="OPAL_IND"){ echo "Transactions";}else{ echo prntext($data['PageName']);}?>
  </h4>
	<?
		//include file for payin tras list as per json 
		$payin_trnslist_json_file_from_theme=("../front_ui/{$data['frontUiName']}/common/template.payin_trnslist_json".$data['iex']);
		
		$payin_trnslist_json_file_from_default=("../front_ui/default/common/template.payin_trnslist_json".$data['iex']);
		if(file_exists($payin_trnslist_json_file_from_theme)){
			include($payin_trnslist_json_file_from_theme);
		}elseif(file_exists($payin_trnslist_json_file_from_default)){
			include($payin_trnslist_json_file_from_default);
		}
	?>
  
 
    
  
  <div class="clearfix" style="clear: both;"></div>
</div>
<div class="widget widget-gray widget-body-white">
  <? if($post['action']=='select'){ ?>
  <?
  //include file for search form
  $search_form=("../front_ui/{$data['frontUiName']}/common/template.trans_search_form".$data['iex']);
	if(file_exists($search_form)){
		include($search_form);
	}
	 $cnttot=count($post['Transactions']);
  ?>
    <div class="table-responsive">
	
	
	
	
	  <?
		//include file for payin tras list as per json 
		$payin_trnslist_from_theme=("../front_ui/{$data['frontUiName']}/common/template.trnslist_dynamic".$data['iex']);
		
		$payin_trnslist_from_default=("../front_ui/default/common/template.trnslist_dynamic".$data['iex']);
		if(file_exists($payin_trnslist_from_theme)){
			include($payin_trnslist_from_theme);
		}elseif(file_exists($payin_trnslist_from_default)){
			include($payin_trnslist_from_default);
		}
	?>
	
	
	<?php if($cnttot == 0) { ?>
      <div><img title="No Transaction Found" src="<?=$data['Host']?>/images/not_transaction_found.png" style="width:100%;padding:0;" class="img-fluid" /></div>
      <? } ?>
	
      

		<div class="pagination" style="float:left; width:100%; text-align:center;" id="total_record_result">
		  <?php
      more_db_conf_pages('prev_pg');
			//if(!isset($_SESSION['total_record_result']))
			if(!isset($_GET['tscount']))
			{
			    // include file for pagination
				include("../include/pagination_new".$data['iex']);
				
				if(isset($_GET['page'])){$page=$_GET['page'];unset($_GET['page']);}else{$page=1;}
				$get=http_build_query($_GET);
				$url=$data['USER_FOLDER']."/{$data['FileName']}?".$get;
				$total = (int)$data['tr_count'];
				if(isset($_REQUEST['total_record'])&&$_REQUEST['total_record']<>""){ $data['MaxRowsByPage']=$_GET['total_record']; }
				short_pagination($data['MaxRowsByPage'],$page,$url,$data['last_record']);
			}
			else
			{
				include("../include/pagination_pg".$data['iex']);
				
				if(isset($_REQUEST['cl'])){unset($_REQUEST['cl']);}
				if(isset($_REQUEST['page'])){$page=$_REQUEST['page'];unset($_REQUEST['page']);}else{$page=1;}
				if(isset($_REQUEST['tscount'])){$tscount=$_REQUEST['tscount'];unset($_REQUEST['tscount']);}else {$tscount=0;}
				$get=http_build_query($_REQUEST);
			
//				$url="transactions".$data['ex']."?".$get;

				$url=$data['USER_FOLDER']."/{$data['FileName']}?".$get;

				if(isset($post['bid'])){$url.="&bid=".$post['bid'];}
				if(isset($post['type'])){$url.="&type=".$post['type'];}
				if(isset($post['status'])){$url.="&status=".$post['status'];}
				if(isset($post['action'])){$url.="&action=select";}
				if(isset($post['order'])){$url.="&order=".$post['order'];}
				if(isset($post['searchkey'])){$url.="&searchkey=".$post['searchkey'];}
				if(isset($_GET['page'])){$page=$_GET['page'];}else{$page=1;}
				if(isset($_REQUEST['total_record'])&&$_REQUEST['total_record']<>""){ $data['MaxRowsByPage']=$_GET['total_record']; }
				pagination($data['MaxRowsByPage'],$post['StartPage'],$url,$tscount);
			}
			//more_db_conf_pages();
      more_db_conf_pages('next_pg');
			?>
			</div>
			
      <? }elseif($post['action']=='details'){ ?>
	  <?php /*?>Unused details display old code not in use hide by vikash on 04/01/2023<?php */?>
      <?php /*?><div class="table-responsive">
        <table class=frame width=100% border=0 cellspacing=1 cellpadding=4>
          <tr>
            <td class=capl colspan=2><B>TRANSACTION DETAILS</B></td>
          </tr>
          <tr>
            <td class=capl colspan=2><HR></td>
          </tr>
          <tr>
            <td class=field width=50% nowrap>Date of Trade:</td>
            <td class=input width=50% nowrap><?=prndate($post['Transaction']['tdate'])?></td>
          </tr>
          <tr>
            <td class=field nowrap>Username,
              <?=prntext($data['Currency'])?>
              :</td>
            <td class=input nowrap><? if($post['Transaction']['userid']>0){ ?>
              <a href="userinfo<?=$data['ex']?>?id=<?=$post['Transaction']['userid']?><? if(isset($post['StartPage'])){ ?>&page=<?=$post['StartPage']?><? } ?>&action=view">
              <?=$post['Transaction']['username']?>
              </a>
              <? }else{ ?>
              <?=prntext($post['Transaction']['username'])?>
              <? } ?></td>
          </tr>
          <tr>
            <td class=field nowrap>Amount,
              <?=prntext($data['Currency'])?>
              :</td>
            <td class=input nowrap><?=$post['Transaction']['amount']?></td>
          </tr>
          <tr>
            <td class=field nowrap>Fee,
              <?=prntext($data['Currency'])?>
              :</td>
            <td class=input nowrap><?=prnfees($post['Transaction']['fees'])?></td>
          </tr>
          <tr>
            <td class=field nowrap>Paid,
              <?=prntext($data['Currency'])?>
              :</td>
            <td class=input nowrap><?=$post['Transaction']['nets']?></td>
          </tr>
          <tr>
            <td class=field nowrap>Type:</td>
            <td class=input nowrap><?=$post['Transaction']['type']?></td>
          </tr>
          <tr>
            <td class=field nowrap>Status:</td>
            <td class=input nowrap><?=$post['Transaction']['status']?></td>
          </tr>
          <tr>
            <td class=field nowrap>Description:</td>
            <td class=input><?=prntext($post['Transaction']['comments'])?></td>
          </tr>
          <? if($post['Transaction']['ecomments']){ ?>
          <tr>
            <td class=capl colspan=2 nowrap>ADDITIONAL INFORMATION</td>
          </tr>
          <tr>
            <td class=input colspan=2><br>
              <pre class=info><?=prntext($post['Transaction']['ecomments'])?>
</pre></td>
          </tr>
          <? } ?>
          <tr>
            <td class=capl colspan=2><B>BUYER'S DETAIL</B></td>
          </tr>
          <tr>
            <td class=capl colspan=2><HR></td>
          </tr>
          <tr>
            <td class=field nowrap>Customer Name:</td>
            <td class=input nowrap><? if($post['Transaction']['userid']>0){ ?>
              <a href="userinfo<?=$data['ex']?>?id=<?=$post['Transaction']['userid']?><? if(isset($post['StartPage'])){ ?>&page=<?=$post['StartPage']?><? } ?>&action=view">
              <?=$post['Transaction']['fullname']?>
              </a>
              <? }else{ ?>
              <?=prntext($post['Transaction']['fullname'])?>
              <? } ?></td>
          </tr>
          <tr>
            <td class=field nowrap>Customer Address:</td>
            <td class=input nowrap><?php if($post['Transaction']['bill_address']){ ?>
              <?=$post['Transaction']['bill_address']?>
              -
              <?=$post['Transaction']['bill_city']?>
              (
              <?=$post['Transaction']['bill_state']?>
              )
              <?=$post['Transaction']['bill_zip']?>
              <?php } ?></td>
          </tr>
          <tr>
            <td class=field nowrap>Last four digits of card used:</td>
            <td class=input nowrap><?php if($post['Transaction']['card']){ ?>
              <?php 
					$ccno = $post['Transaction']['card'];
					$string_ccno = substr($ccno,12,16);
					echo "XXXXXXXXXXXX".$string_ccno; ?>
              <?php } ?>
            </td>
          </tr>
          <tr>
            <td class=field nowrap>Phone number:</td>
            <td class=input nowrap><?=$post['Transaction']['bill_phone']?></td>
          </tr>
          <tr>
            <td class=field nowrap>Email bill_address:</td>
            <td class=input nowrap><?=$post['Transaction']['bill_email']?></td>
          </tr>
          <tr>
            <td class=capc colspan=8><? if($post['Transaction']['canrefund']){ ?>
              <a href="<?=$data['USER_FOLDER']?>/<?=($data['FileName']);?>?id=<?=$post['Transaction']['id']?><? if($post['StartPage']){ ?>&page=<?=$post['StartPage']?><? } ?>&action=refund" onClick="return cfmform()">REFUND</a>&nbsp;|&nbsp;
              <? } ?>
              <a href="javascript:history.back()">BACK</a></td>
          </tr>
        </table>
      </div><?php */?>
      <? }else if($post['action']=='search'){ ?>
	  <?php /*?>Unused search old code not in use hide by vikash on 04/01/2023<?php */?>
      <?php /*?><div class="table-responsive">
        <form method="post">
          <input type="hidden" name="action" value="<?=$post['action']?>">
          <input type="hidden" name="page" value="<?=$post['StartPage']?>">
          <table class="frame" width="100%" border="0" cellspacing="1" cellpadding="2">
            <tr>
              <td class=capc colspan=2>SEARCH OPTIONS</td>
            </tr>
            <tr>
              <td class=field nowrap><label for=field1>Search by the username
                <input type="radio" class="checkbox" id="field1" name="field" value="username" checked onClick="username.disabled=false;day.disabled=true;month.disabled=true;year.disabled=true">
                </label></td>
              <td class=input><input type="text" name="username" size="40" maxlength="255"></td>
            </tr>
            <tr>
              <td class=field nowrap><label for=field2>Search by the date
                <input type="radio" class="checkbox" id="field2" name="field" value="tdate" onClick="username.disabled=true;day.disabled=false;month.disabled=false;year.disabled=false">
                </label></td>
              <td class=input><select name="day" disabled>
                  <?=showselect($data['StatDays'], $post['day'])?>
                </select>
                &nbsp;
                <select name="month" disabled>
                  <?=showselect($data['StatMonth'], $post['month'])?>
                </select>
                &nbsp;
                <select name="year" disabled>
                  <?=showselect($data['StatYear'], $post['year'])?>
                </select></td>
            </tr>
            <tr>
              <td class=capc colspan=2><input type="submit" class="submit" name="cancel" value="BACK">
                &nbsp;
                <input type=submit class="submit" name="search" value="SEARCH NOW!"></td>
            </tr>
          </table>
        </form>
      </div><?php */?>
      <? } ?>
      
    </div>
  </div>
</div>
<div id="dialog_box2" class="hide" style="display:none;padding-bottom:100px;">
  <div class="prompt_dialog_layer"> </div>
  <div class="prompt_dialog dialog_box2_body_div p-2" style="height:225px;margin: 22px 0px 0px -150px;">
    <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix bg-primary rounded px-2 text-white" style="height:30px;line-height:30px;"><span id="ui_id_1" class="ui-dialog-title float-start" >Refunded</span>
    </div>
    <div class="my-2"> <span class="my-2">Order Amount : <b id="order_amount">0.00</b></span>
      <input type="text" id="confirm_amount" name="confirm_amount" value="" class="form-control"  placeholder="Enter Partial Refund" />
      <br />
      <input type="text" value="" name="prompt_msg_input" id="prompt_msg_input" class="form-control" placeholder="Enter Comment" />
      <br/>
      <div class="ui-dialog-buttonset" style="text-align:center;">
        <button id="confirm_amount_submit" type="submit" name="cardsend" value="CHECKOUT" class="submit btn btn-primary" ><i class="<?=$data['fwicon']['verified'];?>"></i> <b class="contitxt">Submit</b></button>
        <button type="submit" name="cardsend" value="CHECKOUT" class="dialog_box2 btn btn-primary" ><i class="<?=$data['fwicon']['check-cross'];?>"></i> <b class="contitxt">Cancel</b></button>
      </div>
    </div>
  </div>
</div></div>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
