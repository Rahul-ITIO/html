<?if(isset($data['ScriptLoaded'])){?><form method=post name=data>
<input type=hidden name=step value="<?=$post['step']?>">
<style>
.separator {display:none;}
.title2 {font: 400 11px/20px 'Open Sans', sans-serif !important;padding: 7px 1.5%;margin: 5px 0 0px 0;float: left;width: 97%;border-bottom: none;}
.echektran {width:95% !important; margin:0 auto !important;}
.collapsea {font: 600 16px/20px 'Open Sans'; cursor:pointer;font-size: 11px!important;}
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
@media(max-width:767px){.col1{width:52%;}.col_3{width:25%}.rmk_row{border-top:none!important;}}
</style>
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
<div id="content">
		<ul class="breadcrumb">
	<li><a href="exchange_rate.do?action=select&type=0" class="glyphicons home"><i></i>Exchange Rate</a></li>
	
</ul>



<div class="">


<?if($data['Error']){?>

<div class="alert alert-error">
							<button type="button" class="close" data-dismiss="alert">&times;</button>
							<strong>Error!</strong> <?=prntext($data['Error'])?>
						</div>


<?}?>

<?if($data['sucess']){?>
<div class="alert alert-success">
	<button type="button" class="close" data-dismiss="alert">&times;</button>
	<strong>Success!</strong> Your request add exchange rate <?=prntext($post['currency'])?> .<br><br>
</div>
<?}?>
			
<?if($post['step']==1){?>			
			<div style="width:285px;margin:10px auto;position:relative;top:10px;height:40px;"><button type=submit name=send value="Add A New Exchange Rate!"  class="btn btn-block btn-primary btn-icon glyphicons circle_plus"><i></i>Add A New Exchange Rate</button></div>
			
<div class="widget widget-gray widget-body-white">
		<div class="widget-body" style="padding: 10px 0;background:none repeat scroll 0 0 #FAFAFA">
                <table class="table table-bordered table-condensed echektran">
    <tr>
	<th bgcolor=#eee>ID</th>
	<th bgcolor=#eee>Account</th>
    <th bgcolor=#eee>Currency From</th>
	<th bgcolor=#eee>Currency To</th>
	<th bgcolor=#eee>Rate</th>
	<th bgcolor=#eee>Date</th>
	<th bgcolor=#eee>Action</th>
	
    </tr>

    <? $j=1; foreach($data['selectdatas'] as $ind=>$selectdata) {?>
    <tr>
	<td class=input width=10% nowrap><a class="collapsea" data-href="<?=$j;?>_toggle"><?=$selectdata['id']?></a></td>
	<td class=input width=10% nowrap>
		<?php
			$dname=date("D",strtotime($selectdata['date']));
			if($dname=="Mon"){echo "Card";}
			if($dname=="Wed"){echo "eCheck";}
			
		?>
	</td>
    <td class=input width=20% nowrap><a class="collapsea" data-href="<?=$j;?>_toggle"><?=$selectdata['currency']?></a></td>
	<td class=input width=20% nowrap><a class="collapsea" data-href="<?=$j;?>_toggle"><?=$selectdata['currency_to']?></a></td>
	<td class=input nowrap><?=$selectdata['currency_rate']?></td>
	<td class=input nowrap align=left><?=prndate($selectdata['date']);?></td>
	<td class=input width=10% align=left>
		<a href="exchange_rate.do?id=<?=$selectdata['id']?>&action=update">EDIT</a>|<a href="exchange_rate.do?id=<?=$selectdata['id']?>&action=delete" onclick="return confirm('Are you Sure to Delete');" >DELETE</a>
	</td>
	</tr>
	<tr class=padding0 >
	 <td class=padding0 colspan=7 >
	 <div class="collapseitem" id="<?=$j;?>_toggle">
	 
	 
			<div class=row_col3 style="display:none;">
				<div class=col1>ID : <?=$selectdata['id']?></div>
				<div class=col2>Date : <?=prndate($selectdata['date']);?></div>
				<div class=col_3>Status : <?=$data['TicketStatus'][$selectdata['status']];?></div>
				<div class=col4>
				<? if($selectdata['status'] !="2") { ?>
					<a class="addmessagelink" onclick="addmessages(this)"> Add Comments</a> 
				<? }?>
					
				</div>
			</div>
	
	 
		
			<div class=row style="display:none">
				<div class=col_2 style=width:100%;><b>Currency</b> : <?=$selectdata['currency']?></div>
			</div>
			<div class=title2><b>Comments/Note</b></div>
			<div class=row>
				<div class=col_2 style=width:100%;><?=$selectdata['comments']?></div>
			</div>
			<? if($selectdata['reply_comments']){ ?>
	<div class=title2><b>REPLY <? if(!empty($selectdata['currency_rate'])){ ?>[Date : <?=prndate($selectdata['currency_rate'])?>]<? } ?></b></div>
			<div class=row>
				<div class=col_2 style=width:100%;><?=$selectdata['reply_comments']?></div>
			</div>
			
			
			<?}?>
			
			
		</div>	
	 </td>
	</tr>
    <? $j++; }?>
	
	<tr><td class=capc colspan=7><center>
		
		<div style="width:285px"><button type=submit name=send value="Add A New Exchange Rate!"  class="btn btn-block btn-primary btn-icon glyphicons circle_plus"><i></i>Add A New Exchange Rate</button></div></center>
		
		</td></tr>
	
	
</table>
</div>
</div>


<?}elseif($post['step']==2){?>
<?if($post['gid']){?>
<input type=hidden name=gid value="<?=$post['gid']?>">
<input type=hidden name=id value="<?=$post['id']?>">
<input type=hidden name=action value="update_db">
<? }else{?>
<input type=hidden name=action value="insert">
<? }?>

<script>document.write('<input type=hidden name=aurl value="'+top.window.document.location.href+'">');</script>
		

<?
//	echo "2222====<div style='margin-top:100px;'></div>"; print_r($post);
?>


<div class="tab-pane active" id="account-settings">
			<div class="widget widget-2">
				<div class="widget-head">
					<h4 class="heading glyphicons settings"><i></i>Exchange Rate</h4>
				</div>
				<div class="widget-body" style="padding-bottom: 0;">
					<div class="row-fluid input_col_1">
						<div class="span12">
						
						
										<?php	
											
				function getMondaysInRange1($dateFromString, $dateToString, $days='')
				{
					$dateFrom = new \DateTime($dateFromString);
					$dateTo = new \DateTime($dateToString);
					$dates = array();

					if ($dateFrom > $dateTo) {
						return $dates;
					}
					

					if (3 != $dateFrom->format('N')) {
						$dateFrom->modify("next $days");
					}

					while ($dateFrom <= $dateTo) {
						$dates[] = $dateFrom->format('Y-m-d');
						$dateFrom->modify('+1 week');
					}

					return $dates;
				}
				$fromDate 	= date("Y-m-d",strtotime("-10 day",strtotime(date("Y-m-01",strtotime("now") ) )));
				$toDate 	= date("Y-m-d",strtotime("+2 month",strtotime("now")));
				$alldate 	= getMondaysInRange1($fromDate,$toDate,"Wednesday");
				$alldatem 	= getMondaysInRange1($fromDate,$toDate,"Monday");
				//$alldate = getMondaysInRange("2017-05-01","2017-06-31");

				
				?>
					<div class="separator"></div>
							<label for="currency">Payout Date: </label>
							<select name="date" id="date_payout" required>
							<option value="" disabled selected>Payout Date</option>
								<?php foreach($alldate as $key=>$value){ ?>
									<option value="<?php echo date("Y-m-d",strtotime($value));?>"><?php echo date("D d-m-Y",strtotime($value)); ?> (eCheck) </option>
								<?php } ?>
								<?php foreach($alldatem as $key=>$value){ ?>
									<option value="<?php echo date("Y-m-d",strtotime($value));?>"><?php echo date("D d-m-Y",strtotime($value)); ?> (Card) </option>
								<?php } ?>
							</select>
							<script>$('#date_payout option[value="<?php echo date("Y-m-d",strtotime($post[0]['date']));?>"]').prop('selected','selected');</script>
							
							
					</ul>	
				<? ?>
						
							<div class="separator"></div>
							<label for="currency">Currency From: </label>
							<select name="currency" id="currency" required>
							<option value="" disabled selected>Currency From</option>
								<?foreach ($data['AVAILABLE_CURRENCY'] as $k11) {?>
									<option value="<?=$k11?>"><?=$k11?></option>
								<?}?>
							</select>
							<script>$('#currency option[value="<?=prntext($post[0]['currency'])?>"]').prop('selected','selected');</script>
							
							
							<div class="separator"></div>
							<label for="currency_to">Currency To: </label>
							<select name="currency_to" id="currency_to" required>
							<option value="" disabled selected>Currency To</option>
							<?foreach ($data['AVAILABLE_CURRENCY'] as $k11) {?>
								<option value="<?=$k11?>"><?=$k11?></option>
							<?}?>
							</select>
							<script>$('#currency_to option[value="<?=prntext($post[0]['currency_to'])?>"]').prop('selected','selected');</script>
							
							<div class="separator"></div>	
							<label for="currency_rate">Currency Rate: </label>
							<input type=text name=currency_rate placeholder="Enter The Currency Rate" class="span10" value="<?=prntext($post[0]['currency_rate'])?>" style="height:30px;" />
							
							
							<div class="separator"></div>
							<label for="comments">Note/Comments: </label>
							<textarea id="mustHaveId" class="span12" name=comments rows="3" placeholder="Enter Note" style="width:60%;height:40px;"><?=prntext($post[0]['comments'])?></textarea>

							<div class="separator"></div>
							<label for="send"></label>
							<button type=submit name=send value="CONTINUE"  class="btn btn-icon btn-primary glyphicons circle_ok "><i></i>Submit</button>
							<div class="separator"></div><br/><br/>
						</div>


<?}?>

</form>

<?}else{?>SECURITY ALERT: Access Denied<?}?> 

</div>                                 