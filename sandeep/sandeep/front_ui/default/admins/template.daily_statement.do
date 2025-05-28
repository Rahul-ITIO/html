<? if(isset($data['ScriptLoaded'])){ ?>
<input type="hidden" name="step" value="<?=$post['step']?>">
<style>
.title2 {padding: 7px 1.5%;margin: 5px 0 0px 0;float: left;width: 97%;border-bottom: none;}
.echektran {width:95% !important; margin:0 auto !important;}
.collapsea { cursor:pointer;font-size: 11px!important;}
.collapsea.active {color: #ab0c0c;}
.echektran .collapse, .collapseitem {display:none;}
.echektran .collapse.in, .collapseitem.active  {display:block;}
.padding0 {padding:0 !important; margin:0 !important;}
.row {clear: both; float: right; width: 99%; padding: 0px 0.5%; font-size: 11px; /*border-bottom: 1px solid #d7d8da;*/ }
.row:nth-child(odd) {/*background:#e7e7e7;*/}
.row:nth-child(even) {}
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
@media(max-width:767px){.col1{width:52%;}.col_3{width:25%}.rmk_row{border-top:none!important;}}
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


<?if($data['Error']){?>

<div class="alert alert-error">
							<button type="button" class="close" data-dismiss="alert">&times;</button>
							<strong>Error!</strong> <?=prntext($data['Error'])?>
						</div>


<? } ?>

<?if($data['sucess']){?>
<div class="alert alert-success">
	<button type="button" class="close" data-dismiss="alert">&times;</button>
	<strong>Success!</strong> Your request add <?=$data['PageName'];?>  <?=prntext($post['subject'])?> (<?=$post['ticketid']?>).<br><br>
</div>
<? } ?>

<div style="width:100%; float:left;padding-top: 10px;text-align: center;">
	<a href="<?=$data['Admins'];?>/daily_statement.do?action=insert_patch_date_wise&bid=40&ptdate=2018-10-30" class="btn btn-icon btn-primary circle_plus" >Insert Date Wise </a>
	<a href="<?=$data['Admins'];?>/daily_statement.do?action=insert_all" class="btn btn-icon btn-primary circle_plus" >All Merchant </a>
	
	<select name="merchant_details" id="merchant_details" style="width: 230px;font-size: 11px;" onchange='GetStoreID();'>
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
		
		<select id="time_period" name='time_period' onChange="show_date_field();"
		 style=" width: 145px; font-size: 11px;" >
			<option  selected value='SELECT DATE RANGE' >-TIME FRAME-</option>
			<option  value='1' >THIS WEEK</option>
			<option  value='2' >THIS MONTH</option></option>
			<option  value='3' >THIS YEAR</option>
		</select>
		
		<input type="date" size="8" id="date1" class="datepicker1"   name='date_1st'  placeholder='START DATE' value='<?php echo $_POST["date_1st"] ?>' autocomplete="off" style="height:30px !important"/>
		
		<input type="date" size="8" id="date2"  class="datepicker2"  name='date_2nd' 
		 placeholder='END DATE'
		  value='<?php echo ($_POST["date_2nd"]);?>' 
		   autocomplete="off" style="height:30px !important"/>
	
		<input type="submit" id ="SEARCH" name="SEARCH" value="SUBMIT" class="btn btn-icon btn-primary circle_plus" />
		
	</div>


<?if($post['step']==1){?>			
			
<div class="widget widget-gray widget-body-white">
		<div class="widget-body" style="padding: 10px 0;background:none repeat scroll 0 0 #FAFAFA">
                <table class="table table-bordered table-condensed echektran">
    <tr>
	<th bgcolor=#eee>MID/User Name</th>
	<th bgcolor=#eee>Account Balance </th>
    <th bgcolor=#eee>Mature Fund</th>
		<th bgcolor=#eee>Immature Fund </th>
		<th bgcolor=#eee>Withdraw</th>
	
	<th bgcolor=#eee>Company</th>
	<th bgcolor=#eee>Date</th>
		<th bgcolor=#eee>BatchDate</th>
	<th bgcolor=#eee>Action</th>
	
    </tr>

    <? $j=1; foreach($data['selectdatas'] as $ind=>$selectdata) {?>
    <tr>
	<td class="input" width=3% nowrap><a class="collapsea mprofile" data-mid="<?=$selectdata['clientid']?>" data-href="<?=$j;?>_toggle"><?=$selectdata['clientid']?>|<?=$selectdata['username']?></a></td>
<td class="input" width=10% nowrap><a class="collapsea" data-href="<?=$j;?>_toggle"><?=$selectdata['balance_amt']?></a></td>
    <td class="input" width=3%><a class="collapsea" data-href="<?=$j;?>_toggle"><?=$selectdata['mature_amt']?></a></td>
	<td class="input" width=3%><a class="collapsea" data-href="<?=$j;?>_toggle"><?=$selectdata['immature_amt']?></a></td>
	<td class="input" width=3%><a class="collapsea" data-href="<?=$j;?>_toggle"><?=$selectdata['withdraw_amt']?></a></td>
	<td class="input" ><?=$selectdata['company_name']?></td>
	<td class="input" nowrap align=left><?=date("d-m-Y h:i A",strtotime($selectdata['cdate']));?></td>
	<td class="input" nowrap align=left><?=$selectdata['batch_date'];?></td>
	<td class="input" width=10% align=left><?=$data['TicketStatus'][$selectdata['status']];?></td>
	</tr>
	<tr class="padding0">
	 <td class="padding0" colspan="9" >
	 <div class="collapseitem" id="<?=$j;?>_toggle">
	 
	 
			<div class=row_col3>
				<div class=col1>BatchDate : <?=$selectdata['batch_date']?></div>
				<div class=col2>Date : <?=date("d-m-Y h:i A",strtotime($selectdata['cdate']));?></div>
				<div class=col_3>Status : <?=$data['TicketStatus'][$selectdata['status']];?></div>
				<div class=col4>
				<? if($selectdata['status'] !="2") { ?>
					<a class="addmessagelink" onclick="addmessages(this)">REPLY MESSAGE</a> |
				<? } ?>
					<a class="viewdetaillink" onclick="viewdetails(this)">MERCHANT DETAILS</a> 
				</div>
			</div>
	<? if($selectdata['status'] !="2") { ?>
	 
		
		
	 <div id=addmessageform class=addmessageform>
		
		<form action="support-ticket.do" method=post>
			<input type=hidden name=action value="addmessage">
			<input type=hidden name=id value="<?=$selectdata['id']?>">
			<input type=hidden name=email value="<?=$selectdata['email']?>">
			<input type=hidden name=subject value="<?=$selectdata['ticketid']?> - <?=$selectdata['subject']?>">
			<input type=hidden name=page value="<?=$post['StartPage']?>">
			<script>document.write('<input type=hidden name=aurl value="'+top.window.document.location.href+'">');</script>
					
					<div class="separator"></div>		
					<select name="status" id="status_<?=$j;?>" class="feed_input1" required style="width:100%!important;">
						<option>Select Status</option>
						<?foreach($data['TicketStatus'] as $key=>$value){?>
							<option value="<?=$key?>"><?=$value?></option>
						<? } ?>
					</select>

					<script>
						$('#status_<?=$j;?> option[value="<?=prntext($selectdata['status'])?>"]').prop('selected','selected');
					</script>

					<div class="separator"></div>
					<textarea id="mustHaveId" class="span12 jqte-test" name=comments rows="5" placeholder="Enter a Message" style="width:100%; height:80px;"><?=prntext($post['comments'])?></textarea>

					<div class="separator"></div>
					<button type=submit name=addmessage value="CONTINUE"  class="btn btn-icon btn-primary glyphicons circle_ok "><i></i>SEND MESSAGE</button>
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
			<div class=title2><b>MERCHANT DETAILS</b></div>
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
				<div class=col_2 style=width:100%;><b>Subject</b> : <?=$selectdata['subject']?></div>
			</div>
			<div class=title2><b>MERCHANT MESSAGE</b></div>
			<div class=row>
				<div class=col_2 style=width:100%;><pre style="float:left;width:96%;"><?=stripslashes($selectdata['comments']);?></pre></div>
			</div>
			<?if($selectdata['reply_comments']){?>
	<div class=title2><b>REPLY <?if(!empty($selectdata['reply_date'])){?>[Date : <?=date("d-m-Y h:i A",strtotime($selectdata['reply_date']))?>]<? } ?></b></div>
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
		
		pagination(50,$page,$url,$total);
		
    	

	?>
</div>
<!-- // 5 page:end -->

<? }elseif($post['step']==2){?>
<?if($post['gid']){?>
<input type=hidden name=gid value="<?=$post['gid']?>">
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


</div></div>
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
<? }else{?>SECURITY ALERT: Access Denied<? } ?> 

</div>                                 