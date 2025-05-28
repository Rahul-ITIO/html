<? if(isset($data['ScriptLoaded'])){ ?>
<link href="<?=$data['TEMPATH']?>/common/css/table-responsive.css" rel="stylesheet">
<input type="hidden" name="step" value="<?=$post['step']?>">
<style>
.actn_ul {list-style:none;margin:0;padding:0;}
.actn_ul li {position:relative;}
.actn a {float:left !important;width:auto;height:inherit;position:relative;}
.actn .glyphicons i:before {font-size:14px;top:-2px;background:#fff;
padding:5px 7px;border-radius:3px;box-shadow:3px 3px 3px 1px rgba(0,0,0,0.75);}
.actn .glyphicons:hover i:before {background:#e37c18;color:#fff;}
/*.title2 {padding: 7px 1.5%;margin: 5px 0 0px 0;float: left;width: 97%;border-bottom: none;}
.echektran {width:95% !important; margin:0 auto !important;}
.collapsea { cursor:pointer;font-size: 11px!important;}
.collapsea.active {color: #ab0c0c;}
.echektran .collapse, .collapseitem {display:none;}
.echektran .collapse.in, .collapseitem.active  {display:block;}
.padding0 {padding:0 !important; margin:0 !important;}
.row {clear: both; float: right; width: 99%; padding: 0px 0.5%; font-size: 11px; /*border-bottom: 1px solid #d7d8da; }*/
.row:nth-child(odd) {/*background:#e7e7e7;*/}
.row:nth-child(even) {}*/
.col_1 {float:left; width:10%;padding:1%;}
.col_2 {float:left; width:85%;padding:5px 10px 3px;}
.col1 {width: 24%; float:left;}
.col2 {width: 24%; float:left;text-align:center;}
.col_3 {width: 24%; float:left;text-align:center;}
.col4 {width: 24%; float:left;text-align:right;}

.rightlink {float:right;font-size:14px;padding:10px 30px 0 0;font-weight: bold;}
.addmessageform, .viewdetaildiv {display:none;float:left;padding:20px;padding:0 4% 20px 4%;width:92%;border-bottom:2px solid #ccc;margin: 0 0 20px 0;}
a{cursor:pointer;}
.rmk_row {border-top:none !important; padding:0px 0 0px 0; margin:0px 0;}
.row_col3 {white-space:nowrap;float:left;width:96%;padding:4px 2%;font-weight:bold;background:#f3f3f3;margin:0px 0;/*border-top:1px solid #ccc;*/border-bottom:1px solid #ccc;}
.rmk_row .rmk_date {width: 26%;}
@media(max-width:767px){

/*.col1{width:52%;}.col_3{width:25%}.rmk_row{border-top:none!important;}*/

}
</style>

<link rel="stylesheet" type="text/css" href="<?=$data['Host']?>/js/jquery-te-1.4.0.css"/>
<script src="<?=$data['Host']?>/js/jquery-te-1.4.0.min.js"></script>


<script>
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
function addmessages(e){
	if($(e).hasClass('active')){
		$('.addmessagelink').removeClass('active');
		$('.addmessageform').removeClass('active');
		
		$(e).parent().parent().parent().find('.addmessageform').slideUp(200);
	} else {
	  $('.addmessagelink').removeClass('active');
	  $('.addmessageform').removeClass('active');
	  
	  $(e).parent().parent().parent().find('.addmessageform').addClass('active');
	  $(e).addClass('active');
	  
	  $('.addmessageform').slideUp(100);
	  $(e).parent().parent().parent().find('.addmessageform').slideDown(700);
	}
}
$(document).ready(function(){
    $('.echektran .collapsea').click(function(){
	   var ids = $(this).attr('data-href');
		if($(this).hasClass('active')){
			$('.collapseitem').removeClass('active');
			$('.collapsea').removeClass('active');
			
			$('#'+ids).slideUp(200);
		} else {
		  $('.collapseitem').removeClass('active');
		  $('.collapsea').removeClass('active');
		  //$('#'+ids).addClass('active');
		  $(this).addClass('active');
		  
		  $('.collapseitem').slideUp(100);
		  $('#'+ids).slideDown(700);
		}
        
    });
    
});
</script>
<div class="container border bg-white">
<div class=" container vkg">
  <h4 class="my-2"><a href="support-ticket.do?action=select&type=0" ><i class="<?=$data['fwicon']['home'];?>"></i> <?=$data['PageName'];?> (<?=$data['result_count'];?> of <?=$data['result_total_count'];?>)</a> </h4>
  <div class="vkg-main-border"></div>
  </div>
	

<div class="well">


<? if($data['Error']){ ?>

<div class="alert alert-danger alert-dismissible fade show" role="alert">
<strong>Error!</strong> <?=prntext($data['Error'])?>
<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>


<? } ?>

<? if($data['sucess']){ ?>
<div class="alert alert-warning alert-dismissible fade show" role="alert">
<strong>Success!</strong> Your request add <?=$data['PageName'];?>  <?=prntext($post['subject'])?> (<?=$post['ticketid']?>).
<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<? } ?>
<? if($post['bid']>0){ ?>
	<? include("../include/mb_page.do");?>

<? } ?>

<div style="width:100%; float:left;padding-top: 10px;text-align: center;display:none1;">
	<a href="<?=$data['Admins'];?>/daily_trans_statement.do?action=insert_patch_date_wise&bid=40&ptdate=2018-10-30" class="btn btn-icon btn-primary circle_plus" >Insert Date Wise </a>
	<a href="<?=$data['Admins'];?>/daily_trans_statement.do?action=insert_all" class="btn btn-icon btn-primary circle_plus" >All Merchant </a>
	
	<a href="<?=$data['Admins'];?>/daily_trans_statement.do?action=merchant_date_wise&mid=" class="btn btn-icon btn-primary circle_plus">Merchants' All Date Wise </a>
	
	<select name="merchant_details" id="merchant_details" class="form-select" style="width: 230px;font-size: 11px;" onchange='GetStoreID();'>
			<option value="">Select Merchant</option>
			<?php
			$result=$post['merchant_details'];
			sort($result);
			 foreach ($result as $value) { 
				if ($value['id']!=''){
					if ($_POST['merchant_details']== $value['id']){$selected="selected";}else {$selected='';}
					if(isset($value['fullname'])&&$value['fullname'])
					$fullname = $value['fullname'];
				    else 
					$fullname = $value['fname']." ".$value['lname'];
					
			 ?>
					<option value="<?php echo $value['id'];?>" <?=$selected;?>>[<?php echo $value['id']."] ".$value['username']." |".$fullname;?></option>
			 <?php
					}
			}
			?>
		</select>
		
<select id="time_period" name='time_period' class="form-select" onChange="show_date_field();" style=" width: 145px; font-size: 11px;" >
<option  selected value='SELECT DATE RANGE' >-TIME FRAME-</option>
<option  value='1' >THIS WEEK</option>
<option  value='2' >THIS MONTH</option></option>
<option  value='3' >THIS YEAR</option>
</select>
		
<input type="date" size="8" id="date1" class="datepicker1 form-control"   name='date_1st'  placeholder='START DATE' 
value='<?php echo $_POST["date_1st"] ?>' autocomplete="off" style="height:30px !important"/>
		
<input type="date" size="8" id="date2"  class="datepicker2 form-control"  name='date_2nd' placeholder='END DATE' value='<?php echo ($_POST["date_2nd"]);?>' autocomplete="off" style="height:30px !important"/>
<input type="submit" id ="SEARCH" name="SEARCH" value="SUBMIT" class="btn btn-primary" />
</div>


<? if($post['step']==1){ ?>			
			
<div class="widget widget-gray widget-body-white">
<div class="widget-body" style="padding: 10px 0;background:none repeat scroll 0 0 #FAFAFA">
<div class="table-responsive">

    <table class="table table-bordered table-condensed echektran">
    <tr>
	<th bgcolor="#eee">MID/User&nbsp;Name</th>
	<th bgcolor="#eee">Payable&nbsp;Amt</th>
    <th bgcolor="#eee">Success&nbsp;Amt</th>
	<th bgcolor="#eee">Failed&nbsp;Amt</th>
	<th bgcolor="#eee">Monthly&nbsp;Vt</th>
	<th bgcolor="#eee">Company</th>
	<th bgcolor="#eee">Date</th>
	<th bgcolor="#eee">BatchDate</th>
	<th bgcolor="#eee">Action</th>
    </tr>

    <? $j=1; foreach($data['selectdatas'] as $ind=>$selectdata) { ?>
    <tr>
	<td class="input" width=3% nowrap data-label="MID/User Name"><a class="collapsea mprofile" data-mid="<?=$selectdata['clientid']?>" data-href="<?=$j;?>_toggle"><?=$selectdata['clientid']?>|<?=$selectdata['username']?></a></td>
	<td class="input" width=10% nowrap data-label="Payable Amt"><a class="collapsea" data-href="<?=$j;?>_toggle"><?=$selectdata['total_payable_to_merchant']?></a></td>
    <td class="input" width=3% data-label="Success Amt"><a class="collapsea" data-href="<?=$j;?>_toggle"><?=$selectdata['total_success_of_batch']?></a></td>
		 <td class="input" width=3% data-label="Failed Amt"><a class="collapsea" data-href="<?=$j;?>_toggle"><?=$selectdata['total_failed_of_batch']?></a></td>
		 <td class="input" width=3% data-label="Monthly Vt"><a class="collapsea" data-href="<?=$j;?>_toggle"><?=$selectdata['monthly_vt_fee']?></a></td>
	<td class="input" data-label="Company"><?=$selectdata['company_name']?></td>
	<td class="input" nowrap align="left" data-label="Date"><?=prndate($selectdata['cdate']);?></td>
	<td class="input" nowrap align="left" data-label="BatchDate"><a href="daily_trans_statement.do?bdate=<?=date("Y-m-d",strtotime($selectdata['batch_date']));?>&action=select"  title="Sorting to Batch Date Wise" class=""><?=date("Y-m-d",strtotime($selectdata['batch_date']));?></a></td>
	<td class="input actn" width=10% align="left" data-label="BatchDate">
		<a data-href="<?=$j;?>_toggle" title="View" class="collapsea"><i class="<?=$data['fwicon']['eye'];?>"></i></a>
		<a href="daily_trans_statement.do?bid=<?=$selectdata['clientid']?>&action=select" title="Sorting to Merchant Wise"><i class="<?=$data['fwicon']['thumbs-up'];?>"></i></a>
		<a href="daily_trans_statement.do?bid=<?=$selectdata['clientid']?>&ptdate=<?=date("Y-m-d",strtotime($selectdata['batch_date']));?>&action=insert_patch_date_wise" title="Update by Batch Date Wise for This Merchant" ><i class="<?=$data['fwicon']['retweet'];?>"></i></a>
		
		
		
	</td>
	</tr>
	<tr class="padding0" >
	 <td class="padding0" colspan="9" >
	 <div class="collapseitem" id="<?=$j;?>_toggle" style="overflow:hidden;">
	 
	 
			    <div class=row_col3>
				<div class=col1>BatchDate : <?=prndate($selectdata['batch_date']);?></div>
				<div class=col2>Date : <?=prndate($selectdata['cdate']);?></div>
				<div class=col_3>  : </div>
				<div class=col4>
<? if($selectdata['status'] !="2") { ?><a class="addmessagelink" onclick="addmessages(this)">Reply Message</a> | <? } ?>
<a class="viewdetaillink" onclick="viewdetails(this)">Merchant Details</a> </div></div>
<? if($selectdata['status'] !="2") { ?>
	 
		
		
	 <div id=addmessageform class=addmessageform>
		
		<form action="support-ticket.do" method=post>
			<input type="hidden" name="action" value="addmessage">
			<input type="hidden" name="id" value="<?=$selectdata['id']?>">
			<input type="hidden" name="email" value="<?=$selectdata['email']?>">
			<input type="hidden" name="subject" value="<?=$selectdata['ticketid']?> - <?=$selectdata['subject']?>">
			<input type="hidden" name="page" value="<?=$post['StartPage']?>">
			<script>document.write('<input type=hidden name=aurl value="'+top.window.document.location.href+'">');</script>
					
					<div class="separator"></div>		
					<select name="status" id="status_<?=$j;?>" class="feed_input1" required style="width:100%!important;">
						<option>Select Status</option>
						<? foreach($data['TicketStatus'] as $key=>$value){ ?>
							<option value="<?=$key?>"><?=$value?></option>
						<? } ?>
					</select>

					<script>
						$('#status_<?=$j;?> option[value="<?=prntext($selectdata['status'])?>"]').prop('selected','selected');
					</script>

					<div class="separator"></div>
					<textarea id="mustHaveId" class="span12 jqte-test" name=comments rows="5" placeholder="Enter a Message" style="width:100%; height:80px;"><?=prntext($post['comments'])?></textarea>

					<div class="separator"></div>
<button type=submit name=addmessage value="CONTINUE"  class="btn btn-icon btn-primary"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Send Message</button>
		</form>
		</div>
	 <? } ?>
	 	 <?
		    if(isset($selectdata['fullname'])&&$selectdata['fullname'])
			$fullname = $selectdata['fullname'];
		    else 
			$fullname = $selectdata['fname']." ".$selectdata['lname'];
	     ?>
	 
		<div class=viewdetaildiv id=viewdetaildiv>
			<div class=title2><b>Merchant Details</b></div>
			<div class=row>
				<div class=col_1>Company</div>
				<div class=col_2><?=$selectdata['company_name']?></div>
			</div>
			<div class=row>
				<div class=col_1>Full Name</div>
				<div class=col_2><?=$fullname;?></div>
			</div>
			<div class=row>
				<div class=col_1>Username</div>
				<div class=col_2><a href="<?=$data['Admins'];?>/merchant<?=$data['ex'];?>?id=<?=$selectdata['clientid']?>&action=detail"><?=$selectdata['username']?></a></div>
			</div>
			<div class=row>
				<div class=col_1>Phone</div>
				<div class=col_2><?=$selectdata['phone']?></div>
			</div>
			<div class=row>
				<div class=col_1>Email</div>
				<div class=col_2><?=$selectdata['email']?></div>
			</div>
			<div class=row>
				<div class=col_1>Address</div>
				<div class=col_2><?=$selectdata['address']?>, <?=$selectdata['city']?>, <?=$selectdata['state']?>, <?=$selectdata['country']?>, <?=$selectdata['zip']?></div>
			</div>
		
		</div>
			
			<div class=row>
				<div class="po15x">
				  <div class="dta1 key 1">Total Failed </div>
				  <div class="dta1 val"><?=$selectdata['total_failed_of_batch'];?> &nbsp;</div>
				  <div class="dta1 key 1">Total Success</div>
				  <div class="dta1 val"><?=$selectdata['total_success_of_batch'];?> &nbsp;</div>
				  <div class="dta1 key 1">MDR</div>
				  <div class="dta1 val"><?=$selectdata['total_mdr_of_batch'];?> &nbsp;</div>
				  <div class="dta1 key 1">Rolling</div>
				  <div class="dta1 val"><?=$selectdata['total_rolling_of_batch'];?> &nbsp;</div>
				  
				  
				  <div class="dta1 key 1">Txn Fee </div>
				  <div class="dta1 val"><?=$selectdata['total_txn_fee_of_batch'];?> &nbsp;</div>
				  <div class="dta1 key 1">Chargeback Amt.</div>
				  <div class="dta1 val"><?=$selectdata['total_amt_chargeback_of_batch'];?> &nbsp;</div>
				  <div class="dta1 key 1">Chargeback Fee</div>
				  <div class="dta1 val"><?=$selectdata['total_chargeback_fee_of_batch'];?> &nbsp;</div>
				  <div class="dta1 key 1">Returned Amt.</div>
				  <div class="dta1 val"><?=$selectdata['total_amt_returned_of_batch'];?> &nbsp;</div>
				  <div class="dta1 key 1">Returned Fee</div>
				  <div class="dta1 val"><?=$selectdata['total_returned_fee_of_batch'];?> &nbsp;</div>
				  <div class="dta1 key 1">Refunded Amt.</div>
				  <div class="dta1 val"><?=$selectdata['total_amt_refunded_of_batch'];?> &nbsp;</div>
				  <div class="dta1 key 1">Refunded Fee</div>
				  <div class="dta1 val"><?=$selectdata['total_refunded_fee_of_batch'];?> &nbsp;</div>
				  <div class="dta1 key 1">CBK1 Amt.</div>
				  <div class="dta1 val"><?=$selectdata['total_amt_cbk1_of_batch'];?> &nbsp;</div>
				  <div class="dta1 key 1">CBK1 Fee</div>
				  <div class="dta1 val"><?=$selectdata['total_cbk1_fee_of_batch'];?> &nbsp;</div>
				  <div class="dta1 key 1">Withdraw Amt.</div>
				  <div class="dta1 val"><?=$selectdata['total_withdraw_of_batch'];?> &nbsp;</div>
				  <div class="dta1 key 1">Total Send Fund </div>
				  <div class="dta1 val"><?=$selectdata['total_send_fund_of_batch'];?> &nbsp;</div>
				  <div class="dta1 key 1">Total Received Fund</div>
				  <div class="dta1 val"><?=$selectdata['total_received_fund_of_batch'];?> &nbsp;</div>
				  <div class="dta1 key 1">Monthly VT Fee</div>
				  <div class="dta1 val"><?=$selectdata['monthly_vt_fee'];?> &nbsp;</div>
				  <div class="dta1 key 1">Mature Fund Date</div>
				  <div class="dta1 val"><?=$selectdata['mature_fund_date_of_day'];?> &nbsp;</div>
				  <div class="dta1 key 1">Total Payable to Merchant</div>
				  <div class="dta1 val"><?=$selectdata['total_payable_to_merchant'];?> &nbsp;</div>
				  <div class="dta1 key 1">Total Withdraw Rolling</div>
				  <div class="dta1 val"><?=$selectdata['total_withdraw_rolling_of_batch'];?> &nbsp;</div>
				  <div class="dta1 key 1">Total Payable Rolling to Merchant</div>
				  <div class="dta1 val"><?=$selectdata['total_payable_rolling_to_merchant'];?> &nbsp;</div>
				  <div class="dta1 key 1">Mature Rolling Date</div>
				  <div class="dta1 val"><?=$selectdata['mature_rolling_date_of_day'];?> &nbsp;</div>
				  <div class="dta1 key 1">Batch Date</div>
				  <div class="dta1 val"><?=date("Y-m-d",strtotime($selectdata['batch_date']));?> &nbsp;</div>
				  <div class="dta1 key 1">Created Date</div>
				  <div class="dta1 val"><?=$selectdata['cdate'];?> &nbsp;</div>
				  <div class="dta1 key 1">Updated Date</div>
				  <div class="dta1 val"><?=$selectdata['udate'];?> &nbsp;</div>
				  <div class="dta1 key 1">Status</div>
				  <div class="dta1 val"><?=$selectdata['status'];?> &nbsp;</div>
				 
				  

				</div>
			</div> 
			
			<div class=row>
				<div class=col_2 style=width:100%;><pre style="float:left;width:96%;"><?=stripslashes($selectdata['comments']);?></pre></div>
			</div>
			<? if($selectdata['reply_comments']){ ?>
	<div class=title2><b>Reply <? if(!empty($selectdata['reply_date'])){ ?>[Date : <?=prndate($selectdata['reply_date'])?>]<? } ?></b></div>
			<div class=row>
				<div class=col_2 style=width:100%;><pre style="float:left;width:96%;"><?=stripslashes($selectdata['reply_comments']);?></pre></div>
			</div>
			
			
			<? } ?>
			
			
		</div>	
	 </td>
	</tr>
    <? $j++; } ?>
	<?/*?>
	<tr><td class=capc colspan=5><center>
		
		<div style="width:285px"><button type=submit name=send value="ADD NEW SUPPORT TICKET!"  class="btn btn-block btn-primary btn-icon glyphicons circle_plus"><i></i>Add A New Support Ticket</button></div>
		
		</td></tr>
	<?*/?>
	
</table>

</div>
</div>
</div>

<!-- // 5 page:start -->
<div class="pagination" style="float:left; width:100%; text-align:center;">

	<?php
		includef("../include/pagination_pg.do");
		
		$url=$data['FileName']."?";
		if(isset($post['action'])){$url.="&action=".$post['action'];}
		if(isset($post['type'])){$url.="&type=".$post['type'];}
		if(isset($post['status'])){$url.="&status=".$post['status'];}
		//if(isset($post['searchkey'])){$url.="&searchkey=".$post['searchkey'];}
		if(isset($_GET['page'])){$page=$_GET['page'];}else{$page=1;}
		if(isset($post['order'])){$url.="&order=".$post['order'];}
		
		$total = (int)$data['result_total_count'];
		
		pagination(100,$page,$url,$total);
		
    	

	?>
</div>
<!-- // 5 page:end -->

<? }elseif($post['step']==2){ ?>
<? if($post['gid']){ ?>
<input type="hidden" name="gid" value="<?=$post['gid']?>">
<? } ?>

<?
//	echo "2222====<div style='margin-top:100px;'></div>"; print_r($post);
?>


<div class="tab-pane active" id="account-settings">
			<div class="widget widget-2">
				<div class="widget-head">
					<h4 class="heading glyphicons settings"><i></i>Support Ticket</h4>
				</div>
				<div class="widget-body" style="padding-bottom: 0;">
					<div class="row-fluid">
						<div class="span9">
						
							<div class="separator"></div>		
							<input type=text name=subject placeholder="Enter The Full Subject" class="span10" value="<?=prntext($post[0]['subject'])?>" style="width:100%!important; height:30px;" />
							
							<div class="separator"></div>
							<textarea id="mustHaveId" class="span12 jqte-test" name=comments rows="5" placeholder="Enter a Message" style="width:100%; height:80px;"><?=prntext($post[0]['comments'])?></textarea>

							<div class="separator"></div>
							<button type=submit name=send value="CONTINUE"  class="btn btn-icon btn-primary glyphicons circle_ok "><i></i>Submit</button>
						</div>


<? } ?>



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
<? }else{ ?>SECURITY ALERT: Access Denied<? } ?> 

</div>    

               </div>    
			   
			   </div>
</div>
</center></div>                         