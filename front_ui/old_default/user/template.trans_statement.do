<? if(isset($data['ScriptLoaded'])){ ?>
<style>
/*[type="date"] {
  background:#fff url(<?=$data['Host'];?>/images/calendar_2.png)  97% 50% no-repeat ;
}
[type="date"]::-webkit-inner-spin-button {
  display: none;
}
[type="date"]::-webkit-calendar-picker-indicator {
  opacity: 0;
}*/
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

<?php /*?>.action_link .itxv {display:none;}
.action_link a {
    width: 40px;
    height: 30px;
    margin: 0;
    padding: 0;
    text-align: center;
    
    border-radius: 3px;
    display: inline-block;
	
	background: rgb(156,156,156);
background: radial-gradient(circle, rgba(156,156,156,1) 0%, rgba(255,255,255,1) 0%, rgba(156,156,156,1) 100%);
}
.action_link a.glyphicons i::before{
	top: 5px;
    left: 11px;
    font-size: 20px;
}

#content td, #content th {padding: 5px 2px;}



html .s_section select.form-select{-webkit-appearance:none !important;-moz-appearance:none !important;}

[type="date"] {background: #fff url(<?=$data['Host']?>/images/calendar_2.png) 94% 50% no-repeat;background-color: rgb(255, 255, 255);background-color: rgb(255, 255, 255);background-size:18px;}
[type="date"]::-webkit-inner-spin-button {display: none;  width:0px;}
[type="date"]::-webkit-calendar-picker-indicator {opacity: 0; width:30px !important; min-width:30px !important;} 

.datepicker-toggle{float:left;display:inline-block;position:relative;width:18px;height:19px}.datepicker-toggle-button{position:absolute;left:0;top:0;width:100%;height:100%;background:#fff url(<?=$data['Host']?>/images/calendar_2.png);background-size:100%}.datepicker-input{position:absolute;left:0;top:0;width:100%;height:100%;opacity:0;cursor:pointer;box-sizing:border-box}.datepicker-input::-webkit-calendar-picker-indicator{position:absolute;left:0;top:0;width:100%;height:100%;margin:0;padding:0;cursor:pointer}<?php */?>

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
  <h4><i class="<?=$data['fwicon']['mystatement'];?>"></i> 
  <? if($data['frontUiName']=="OPAL_IND"){ echo "Transactions";}else{ echo prntext($data['PageName']);}?></h4>
    
  
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
  ?>
    <div class="table-responsive-sm">
       <table class="table table-hover bg-primary text-white">
	   <? if(count($post['Transactions'])!=0){ ?>
        <thead>
          <tr>
            <th scope="col">TransID</th>
            <th scope="col">Reference</th>
            <th scope="col">Customer&nbsp;Name</th>
            <th scope="col">Bill&nbsp;Amt.</th>
            <th scope="col">Trans&nbsp;Amt</th>
            <th scope="col">Date</th>
            <th scope="col">Status</th>
            <th scope="col">Action</th>
			<? if($data['con_name']=='clk'){ ?>
			<th scope="col">MDR</th>
			<th scope="col">GST</th>
			<th scope="col">UPA</th>
			<th scope="col">Card Number</th>
			<? $cspan=12; }else{ $cspan=8;} ?>
          </tr>
        </thead>
		<? }else{ ?>
<div class="alert alert-secondary alert-dismissible fade show" role="alert">
  <strong>No statement - </strong> When you add or receive payments, they will appear here. 
  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
		<? } ?>
        <tbody>
          <? if($post['Transactions']){$idx=1;foreach($post['Transactions'] as $value){ ?>
          <tr>
            <td nowrap title="Payment ID" ><a class="hrefmodal text-wrap text-link" data-tid="<?=$value['transID']?>" data-href="<?=$data['Host'];?>/trnslist_get<?=$data['ex']?>?id=<?=$value['id']?><? if(isset($post['StartPage'])){ ?>&page=<?=$post['StartPage']?><? } ?>&action=details" style="white-space:nowrap;">
              <?=$value['transID']?>
              </a></td>
            <td nowrap title="Order Id" ><?=$value['reference']?></td>
            <td nowrap title="Customer Name"><?=$value['fullname']?></td>
            <td nowrap title="Bill Amt." class="pricecolor"><?=$value['bill_amt']?></td>
            <td nowrap title="Trans.Amt.-(<?=$_SESSION['default_currency']?>)" class="pricecolor"><?php echo $value['trans_amt'];?></td>
            <?/*?><td nowrap title="Balance-(<?=$_SESSION['default_currency']?>)"><?=$value['available_balance']?></td> <?*/?>
            <td nowrap title="Date"><?=prndate($value['tdate'])?></td>
            
            <td nowrap title="Status"><?=$value['trans_status']?></td>
            <td nowrap title="Action" >
			  
			  <a class="hrefmodal" data-href="<?=$data['Host'];?>/trnslist_get<?=$data['ex']?>?id=<?=$value['id']?><? if(isset($post['StartPage'])){ ?>&page=<?=$post['StartPage']?><? } ?>&action=details" data-tid="<?=$value['transID']?>"  title="view"  ><i class="<?=$data['fwicon']['eye-solid'];?>"></i></a>
			  
              <?  if($value['trans_type']=="ch"){ ?>
              <a onclick="iframe_openfvkg(this);" class="glyphicons" data-mid="<?=$value['merID']?>" data-href="<?=$idx;?>_toggle" data-tabname="" data-url="" data-ihref="<?=$data['USER_FOLDER'];?>/echeckvt<?=$data['ex']?>?actionuse=1&hideAllMenu=1&id=<?=$value['tableid']?>&action=update"  title="Duplicate Transaction"><i class="<?=$data['fwicon']['clone'];?>"></i></a>
              <? if($value['ostatus']==0){ ?>
              <a data-reason="Cancel Reason" onclick="return confirm('Are you Sure to CANCEL this')" href="<?=$data['USER_FOLDER']?>/<?=($data['FileName']);?>?id=<?=$value['id']?><? if($post['StartPage']){ ?>&page=<?=$post['StartPage']?><? } ?>&type=<?=$value['typenum'];?>&action=cancel" class="ajxstatus" title="Cancel"><i class="<?=$data['fwicon']['clone'];?>"></i><!--<span class='itxv'>Cancel</span>--></a>
              <? } ?>
              <? } ?>
              <? if((isset($data['t'][$value['typenum']]['refund'])&&$data['t'][$value['typenum']]['refund'])&&($value['ostatus']==1 || $value['ostatus']==4  || $value['ostatus']==6 || $value['ostatus']==8)){ ?>
              <a data-amount="<?=$value['oamount']?>" data-reason="Refund Request" data-href="<?=$data['USER_FOLDER']?>/<?=($data['FileName']);?>?id=<?=$value['id']?><? if($post['StartPage']){ ?>&page=<?=$post['StartPage']?><? } ?><? if($post['type']){ ?>&type=<?=$post['type']?><? } ?>&action=refund" class="dialog_refunded" title="Refund"><i class="<?=$data['fwicon']['rotate-right'];?> mx-1"></i></a>
              <? } ?>
			  
			  <? if((isset($value['json_value_de']['status_'.$value['typenum']]))&&($value['json_value_de']['status_'.$value['typenum']]) && ($value['ostatus']==0)){ ?>
					<a href="<?=($data['Host']);?>/<?=($value['json_value_de']['status_'.$value['typenum']]);?>&actionurl=admin_direct&admin=1&type=<?=($value['typenum']);?>&redirecturl=<?php echo $data['USER_FOLDER'];?>/<?=($data['FileName']);?>" target='hform' class="hkip_status_id" title="Update"><i class="<?=$data['fwicon']['retweet'];?>"></i></a>
			  <? } ?>
				 
				
              
              <? 
			  if(isset($value['canrefund'])&&$value['canrefund'])
			  { ?>
              <a href="<?=$data['USER_FOLDER']?>/<?=($data['FileName']);?>?id=<?=$value['id']?><? if(isset($post['StartPage'])){ ?>&page=<?=$post['StartPage']?><? } ?>&action=refund" onClick="return cfmform()" title="Refund">Refund</a>
              <? } ?>            </td>
			<? if($data['con_name']=='clk'){ ?>
			<td nowrap title="MDR"><?=$value['buy_mdr_amt']?></td>
			<td nowrap title="GST"><?=$value['gst_amt']?></td>
			<td nowrap title="UPA"><?=$value['upa']?></td>
			<td nowrap title="Card Number"><?=bclf($value['ccno'],$value['bin_no']);?></td>
			<? } ?>

          </tr>
          <? $idx++;}}else{ ?>
          <tr>
            <td class="error" colspan="<?=$cspan;?>" align="center" style="padding:0;"><img title="NO TRANSACTIONS FOUND" src="<?=$data['Host']?>/images/not_transaction_found.png" style="width:100%;padding:0;" /> </td>
          </tr>
          <? } ?>
      </table>
      

		<div class="pagination" style="float:left; width:100%; text-align:center;" id="total_record_result">
		  <?php
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
      </center>
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
