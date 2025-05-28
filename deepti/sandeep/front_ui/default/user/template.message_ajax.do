<? if(isset($data['ScriptLoaded'])){ ?>
<!DOCTYPE>
<html>
<script>
window.document.getElementById("inbox_count").innerHTML="<?=$data['inbox_count'];?>";
window.document.getElementById("sent_count").innerHTML="<?=$data['sent_count'];?>";
window.document.getElementById("draft_count").innerHTML="<?=$data['draft_count'];?>";
</script>
<body>
<div class="my-2 table-responsive">
<table class="echektran">
<thead>
  <tr>
    <th class="word-break" width="15%">Message ID</th>
    <th>Subject</th>
    <th width="18%" >Date</th>
    <th width="10%">
	<? if(isset($_GET['filter'])&&$_GET['filter']==4){ ?>
	<strong class="text-white">Status</strong>
<? }else{?>
	<select name="status_msg" id="status_msg" class="feed_input1 text-dark form-select form-select-sm" required onChange="status_msgf(this,'<?=$s_no;?>');" >
		<option value=''>Status</option>
		<? foreach($data['TicketStatus'] as $key=>$value){?>
			<option value="<?=$key?>"><?=$value?></option>
		<? } ?>
	</select>

	<script>
	 $('#status_msg option[value="<?=prntext($_GET['stf'])?>"]').prop('selected','selected');
	</script>
	<? } ?>
	</th>
	 <th width="110px">
		Action
	 </th>
  </tr>
 </thead>
  <? $j=1; foreach($data['ticketsList'] as $key=>$value) {?>
  <tr class="trc_1" valign="top">
    <td data-label="MID"><a class="collapsea" data-href="<?=$j;?>_toggle" data-id="<?=$value['ticketid']?>" onClick="collapseaf(this,'<?=$value['id']?>','<?=$value['status']?>');">
      <?=$value['ticketid']?>
      </a></td>
    <td  data-label="Subject"><a class="collapsea text-decoration-none" data-href="<?=$j;?>_toggle" onClick="collapseaf(this,'<?=$value['id']?>','<?=$value['status']?>');">
      <span class="text-break"><?=ucwords(strtolower($value['subject']))?></span>
      </a></td>
    <td data-label="Date" ><a title="<?=date("d-m-Y h:i A",strtotime($value['date']));?>"><?=date("d-m-Y h:i A",strtotime($value['date']));?></a></td>
    <td data-label="Status" align="center">
		
		<p class="statusa"><?=$data['TicketStatus'][$value['status']];?></p>
		
		
	</td>
	<td data-label="Action" class="input action_link" >
		
		<a class="collapsea" data-href="<?=$j;?>_toggle" onClick="collapseaf(this,'<?=$value['id']?>','<?=$value['status']?>');" title="View"><i class="fas fa-eye"></i></a>
		
		<? if($value['status']==90){?>
			<a  onClick="editDraft(this,'<?=$value['id']?>')" title="Edit Draft"><i class="fas fa-edit"></i></a>
			
			<a  onClick="discardDraft(this,'<?=$value['id']?>')" title="Discard Draft"><i class="far fa-trash-alt text-danger"></i></a>
			
		<? }elseif($value['status']==0){?>
			
			<a class="closeMessage" onClick="closeMessage(this,'<?=$value['id']?>')" title="Close"><i class="far fa-trash-alt text-danger"></i></a>
		<? }else{?>
			
		<? } ?>
		
		
	</td>
  </tr>
  <tr class="padding0 trc_2" >
    <td class="padding0" colspan="5" ><div class="collapseitem" id="<?=$j;?>_toggle">
        <div class="row_col3">
		   <div class="row_col31 row text-start">
           <div class="col-sm-4"><strong>MID</strong> : <?=$value['ticketid']?> </div>
           <div class="col-sm-4"><strong>Date</strong> : <?=date("d-m-Y h:i A",strtotime($value['date']));?></div>
           <div class="col-sm-3"><strong>Status</strong> : <?=$data['TicketStatus'][$value['status']];?></div>
 		  
		  <div class="col-sm-1 text-end pe-0">
          <? if($value['status'] !="2") { ?>
		  
		  <? if($value['status']=="90") { ?>
<a class="addmessagelink col4" onClick="addmessages(this,'draft')" style="width:62px;"><i class="fas fa-edit fa-2x" title="Edit"></i> </a>
		  <? }else{?>
<a class="addmessagelink col4" onClick="addmessages(this)"><i class="fas fa-envelope fa-2x text-primary" title="Reply Message"></i></a>
		  <? } ?>
		  
          <? } ?>
        </div>
		
		<div class="col-sm-12"><strong>Subject :</strong> <?=$value['subject']?>
            
			
			<? if($value['message_type']){?>
			
					<?
						if(is_numeric($value['message_type'])) {
							echo $data['MessageType'][$value['message_type']];
						}else{
							echo $value['message_type'];
						}
					?>
				
			<? } ?>
          </div>
		</div>
        <? if($value['status'] !="2") { ?>
		<div class="row">
        <div id="addmessageform col-sm-12 ps-0" class="addmessageform">
            <form action="message.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="addmessage">
            <input type="hidden" name="id" value="<?=$value['id']?>">
            <input type="hidden" name="page" value="<?=$post['StartPage']?>">
<div class="row">	
<? if($value['status']=="90"){ ?>
<div class="col-sm-12">

<select name="message_type" id="message_type_post_<?=$j;?>" class="feed_input1 form-select my-2" required="" style="width:100%!important;"><option selected="selected" disabled="disabled">Message Type</option><option value="1">Payout</option><option value="2">Technical Support for Integration</option><option value="4">Transaction Issue</option><option value="5">Password Security/2MFA Issue</option><option value="6">Complaint/Feedback</option><option value="21">Others</option></select>
<script> $('#message_type_post_<?=$j;?> option[value="<?=$value['message_type'];?>"]').prop('selected','selected');</script>
 
 <input type="text" name="subject" id="subject_post" placeholder="Enter The Full Subject" class="span10 form-control" value="<? echo $value['subject'];?>" style="width:100%!important; height:30px;" required="">

</div>
<? } ?>

<div class="col-sm-12">
			
            <textarea id="mustHaveId" class="span12 form-control jqte-test" name="comments" rows="5" placeholder="Enter a Message" style="width:100%; height:80px;"><? if($value['status']=="90") {echo $value['comments'];} ?></textarea>
</div>

<div class="col-sm-3">
			<select name="status" id="status_reply_id" class="status_reply_id form-select" style="width:146px!important;position:relative;z-index:999999;">
			  <? if($value['status']=="90") { ?>
				<option value="111" selected="selected">Status is Open</option>
			   <? }else{?>
				 <option value="">Select Status</option>
				  <option value="111">Open</option>
				  <option value="2">Close</option>
			  <? } ?>
			 
			</select>
</div>

<div class="col-sm-3">
			<div class="inputDivPar unActive">
			<div class="inputDivs" >
			  <div id="maindiv">
					<div id="formdiv" style="float:left;">
					<label title="Upload Files" id="uploaddoc_img_text" class="addMore2" onClick="add_more_files(this,'photograph_file[]')" ><i class="fas fa-cloud-upload-alt fa-2x" style="position:relative;top:2px;left:-33px;"></i></label>
					
					
			</div>
					
			  </div>
			</div>
		</div>
</div>

<div class="col-sm-6 text-start">			
<button type="submit" name="addmessage" value="CONTINUE" class="btn btn-primary"><i class="fas fa-check-circle "></i> Send Message</button>
</div>	

</div>		
          </form>
        </div>
		</div>
        <? } ?>
	
	  <div class='row_message row'>
  
		<div style="clear:both"></div>
        <div class="col-sm-12 text-start"><h6>Message Conversation :</h6></strong></div>
        <div class="row">
          <div class="col_2 col-sm-12 text-start border bg-light rounded" ><?=stripslashes($value['comments']);?></div>
           
			
          
        </div>
	</div>
	  <div class="row">
			<? if($value['more_photograph_upload']){
				$photo=explode1('_;',$value['more_photograph_upload']);
			  ?>
				  <div class='row' style="margin: 25px 0 0 0;">
					<div id="formdiv" style="float:left;">
					  <? foreach($photo as $value_po){ ?>
						<? if(isset($value_po)&&$value_po){?>
							<div style="display: block;float:left;width:auto;"><div class="abcd55"><? $pro_img=display_docfile("../user_doc/",$value_po);?><? if($value['status']=="90") { ?><img 66 class="img-thumbnail" onClick="ajax_remove_files(this,'<?=$value['id']?>')" id="img" src="<?=$data['Host']?>/images/x.png" alt="delete" data-file="<?=$value_po;?>"><? } ?></div>
							</div>
						<? } } ?>	
					</div>
				 </div>
			 <? } ?>
		</div>
		
        <? if($value['reply_comments']){ ?>
        <div class="row text-start"><h6>Reply
          <? if(!empty($value['reply_date'])){ ?>
          [Date :
          <?=date("d-m-Y h:i A",strtotime($value['reply_date']))?>
          ]
          <? } ?>
          </h6></div>
        <div class="row bg-warning">
          <div class="col_2 my-2 rounded">
            <pre class="p-2 rounded"><?=stripslashes($value['reply_comments']);?></pre>
          </div>
        </div>
        <? } ?>
      </div>
	  </div>
	  </td>
  </tr>
  <? $j++; } ?>
</table>
</div>

<!-- // 5 page:start -->
<div class="pagination pg_load" style="float:left; width:100%; text-align:center;">

	<?php
		include("../include/pagination_pg".$data['iex']);
		$s_no=((isset($s_no)&&$s_no)?$s_no:'');
		$url=$data['USER_FOLDER']."/message_ajax".$data['ex']."?tab=".$s_no;
		if(isset($_GET['filter'])){$url.="&filter=".$_GET['filter'];}else{$url.="&filter=".$s_no;}
		if(isset($post['type'])){$url.="&type=".$post['type'];}
		if(isset($post['status'])){$url.="&status=".$post['status'];}
		
		
		//if(isset($post['searchkey'])){$url.="&searchkey=".$post['searchkey'];}
		if(isset($_GET['page'])){$page=$_GET['page'];}else{$page=1;}
		if(isset($post['order'])){$url.="&order=".$post['order'];}
		
		$total = (int)$data['result_total_count'];
		
		pagination(50,$page,$url,$total);
		
    	

	?>
</div>
<script>
$('.pg_load a').click(function(){
	top.window.start_common();
	$(this).attr('data-ajaxf',$(this).attr('href'));
	$(this).removeAttr('href');
	
	var thisurls = $(this).attr('data-ajaxf');
	$.ajax({url: thisurls, success: function(result){
		$('.contentMsg').html(result);
	}});
	
});
</script>
</body>
</html>
<? 


 if(isset($_SESSION['load_tab'])){
	
	//echo "<hr/>load_tab=>".$_SESSION['load_tab']; echo "<hr/>open_msg_id=>".$_SESSION['open_msg_id'];
 
 
	if(isset($_SESSION['open_msg_id'])){
	echo "<script>
			setTimeout(function(){ 
				 window.open_msg_id('{$_SESSION['open_msg_id']}');
				}, 100);
				//alert('2');
		</script>";	
	}
		
	
	unset($_SESSION['load_tab']); 
 }

?>

<? }else{ ?>SECURITY ALERT: Access Denied<? } ?>            