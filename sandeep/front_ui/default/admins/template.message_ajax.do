<? //echo $post['inbox_count'];  ?>
<? include("../include/fontawasome_icon".$data['iex']); ?>
<!DOCTYPE>
<html>
<script>
window.document.getElementById("inbox_count").innerHTML="<?=$post['inbox_count'];?>";
window.document.getElementById("inbox_count_process").innerHTML="<?=$post['inbox_process'];?>";
window.document.getElementById("draft_count").innerHTML="<?=$post['draft_count'];?>";
window.document.getElementById("sent_count").innerHTML="<?=$post['sent_count'];?>";
</script>
<body>
<div class="table-responsive-sm">
<table class="table table-hover">
  <thead>
    <tr>
	<th scope="col">#</th>
	<th scope="col">MID</th>
	<th scope="col">UserId</th>
	<th scope="col">W.Partners</th>
	<th scope="col">Company</th>
    <th scope="col">Message ID</th>
    <th scope="col">Subject</th>
    <th scope="col">Date</th>
    <th scope="col">
	<? if(isset($_GET['filter'])&&$_GET['filter']==4){ ?>
	<strong>Status</strong>	
   <? }else{?>
   
<div class="btn-group">
<button type="button" class="btn btn-prime" data-bs-toggle="dropdown" aria-expanded="false" autocomplete="off"> <i class="<?=$data['fwicon']['circle-down'];?>"></i> </button>
<ul class="dropdown-menu">
<li class="text-center text-primary">Status</li>
<? foreach($data['TicketStatus'] as $key=>$value){ ?>
<li><a class="dropdown-item" onClick="status_msgf(this,'<?=$key;?>');"><?=$value?></a></li>
<? } ?>
            </ul>
          </div>
		  
<script> $('#status_msg option[value="<?=prntext(@$_GET['stf'])?>"]').prop('selected','selected'); </script>
	<? } ?>
	</th>
	 <th scope="col">&nbsp;</th>
  </tr>
</thead>
  <? 
  //print_r($data['ticketsList']);
  $j=1; foreach($data['ticketsList'] as $key=>$value) { 
      
	  $value['color']="";
	  $themebgcolor=$value['header_bg_color'];
	  $themecolor=$value['header_text_color'];
	  if($value['header_text_color']==""){ $value['header_text_color']="#000";}
	  if($value['header_bg_color']==""){ $value['header_bg_color']="#fff";}
  ?>
  <tr class="res_row trc_1"> 
  <td><a class="collapsea" data-href="<?=$j;?>_toggle" onClick="collapseaf(this,'<?=$value['id']?>','<?=$value['status']?>');" title="View"><i class="<?=$data['fwicon']['display'];?> text-link"></i></a></td>
	<td>
	
<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_view'])&&$_SESSION['merchant_action_view']==1)){ ?>
<a class="collapsea mprofile "  data-mid="<?=$value['clientid']?>" data-ihref="merchant<?=$data['ex']?>?action=detail&hideAllMenu=1&type=active&id=<?=$value['clientid']?>" onClick="iframe_open_modal(this)" data-href="<?=$j;?>_toggle" style="color:<?=$themecolor?>;"><?=$value['clientid']?></a> 
<!--change function iframe_openf(this) to  iframe_open_modal(this)-->
<? }else{ ?>
<a class="collapsea text-primary" data-href="<?=$j;?>_toggle" style="color:<?=$themecolor?>;"><?=$value['clientid']?></a>
<? } ?>

	
	
	</td>
	<td>
	
	<a  class=" text-wrap" <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_view'])&&$_SESSION['merchant_action_view']==1)){?> href="merchant<?=$data['ex']?>?id=<?=$value['clientid']?>&action=detail" target="_blank" <? } ?> style="color:<?=$themecolor?>;"><?=@$value['m']['username'];?></a>
	</td>
	
    <td><?=@$value['sponsor']?></td>
	<td><?=@$value['m']['company_name'];?></td>
    <td><?=$value['ticketid']?></td>
    <td><?=ucwords(substr($value['subject'],0,15))?></td>
    <td><?=prndate($value['date']);?></td>
    <td>
<? if(isset($data['TicketStatus'][$value['status']])&&$data['TicketStatus'][$value['status']]){ ?>	
<a class="fw-bold" style="color:<?=$themecolor?>;"><?=str_replace("008000","0d6efd",$data['TicketStatus'][$value['status']]);?></a>
<? } ?>
		
	</td>
	<td class="input action_link">
		
		
		<? if($value['status']!=92){?>
			<a onClick="editDraft(this,'<?=$value['id']?>')" title="Edit Draft"><i class="<?=$data['fwicon']['edit'];?>"></i></a>
		<? } ?>
		
		
	</td>
  </tr>
  <tr class="padding0 trc_2" id="<?=$j;?>_toggle_v" style="display:none;" >
    <td class="padding0" colspan="10" >
	<div class="collapseitem" id="<?=$j;?>_toggle">
        <div class="row-fluid">
		 <div class="row">
		 
          <div class="col-sm-4 text-start"><strong>MID:</strong> <?=$value['ticketid']?></div>
          <div class="col-sm-4 text-start"><strong>Date :</strong> <?=prndate($value['date']);?></div>
          <div class="col-sm-4 text-start"><strong>Status :</strong> <a class="statusa_2"><?=$data['TicketStatus'][$value['status']];?></a></div>
		  
		  </div>
		  
		   <div class='mx-2'>
          <?   if($value['status'] !="2") { ?>
			   
			   
			   <? if($value['status']=="92") { ?>
				<a class="addmessagelink btn btn-block btn-primary float-end m-2" onClick="addmessages(this,'draft')" ><i class="<?=$data['fwicon']['edit'];?> text-success"></i> Edit</a>
			   <? }else{?>
				<a class="addmessagelink btn btn-primary float-end m-2" onClick="addmessages(this)"><i class="<?=$data['fwicon']['messages'];?>"></i> Reply Message</a>
			  <? } ?>
			  
			  
          <? } ?>
		  <a class="viewdetaillink link_5 btn btn-primary float-end m-2" onClick="viewdetails(this)" ><i class="<?=$data['fwicon']['merchant'];?>"></i> Merchant Details</a>
		  <div class="clearfix"></div>
        </div>
		
		
		</div>
        <? if($value['status'] !="2") { ?>
        
		<div class="row my-2">
        <div id="addmessageform" class="addmessageform  col-sm-12">
            <form action="<?=$data['Admins'];?>/messages<?=$data['ex']?>" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="addmessage">
            <input type="hidden" name="id" value="<?=$value['id']?>">
			<input type="hidden" name="email" value="<?=encrypts_decrypts_emails(@$value['m']['registered_email'],2);?>">
			<input type="hidden" name="subject" value="<?=$value['subject']?>">
            <input type="hidden" name="page" value="<?=$post['StartPage']?>">
<div class="row border bg-primary my-2 rounded">	
<? if($value['status']=="92"){ ?>
<div class="col-sm-12">

<select name="message_type" id="message_type_post_<?=$j;?>" class="feed_input1 form-select my-2" required="" style="width:100%!important;"><option selected="selected" disabled="disabled">Message Type</option><option value="1">Payout</option><option value="2">Technical Support for Integration</option><option value="4">Transaction Issue</option><option value="5">Password Security/2MFA Issue</option><option value="6">Complaint/Feedback</option><option value="21">Others</option></select>
<script> $('#message_type_post_<?=$j;?> option[value="<?=$value['message_type'];?>"]').prop('selected','selected');</script>
 
 <input type="text" name="subject" id="subject_post" placeholder="Enter The Full Subject" class="span10 form-control" value="<? echo $value['subject'];?>" style="width:100%!important; height:30px;" required="">

</div>
<? } ?>

<div class="col-sm-12 my-2">
			
            <textarea id="mustHaveId" class="span12 form-control jqte-test" name="comments" rows="5" placeholder="Enter a Message" style="width:100%; height:80px;"><? if($value['status']=="92") {echo $value['comments'];} ?></textarea>
</div>

<div class="col-sm-3 mb-2">
			<select name="status" id="status_reply_id" class="status_reply_id form-select" style="width:146px!important;position:relative;z-index:999999;">
			 <? if($value['status']=="92") { ?>
				<option value="111" selected="selected">Status is Open</option>
			   <? }else{?>
				 <option value="">Select Status</option>
				  <option value="111">Open</option>
				  <option value="1">Process</option>
				  <option value="2">Close</option>
				  <option value="4">Read</option>
				  <option value="91">New Mail</option>
				  <option value="92">Drafts</option>
			  <? } ?>
			 
			</select>
</div>

<div class="col-sm-3">
			<div class="inputDivPar unActive">
			<div class="inputDivs" >
			  <div id="maindiv">
					<div id="formdiv" style="float:left;">
					<label title="Upload Files" id="uploaddoc_img_text" class="addMore2" onClick="add_more_files(this,'photograph_file[]')" ><i class="<?=$data['fwicon']['cloud-arrow'];?> fa-2x" style="position:relative;top:2px;left:-33px; display:none"></i></label>
					
					
			</div>
					
			  </div>
			</div>
		</div>
</div>

<div class="col-sm-6 text-start">			
<button type="submit" name="addmessage" value="CONTINUE"  class="btn btn-primary"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Send Message</button>
</div>	

</div>		
          </form>
        </div>
		</div>
        <? } ?>
		
	<div class="viewdetaildiv text66 border m-2 rounded " id="viewdetaildiv">
		<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_view'])&&$_SESSION['merchant_action_view']==1)){
		if(isset($value['m']['fullname'])&&$value['m']['fullname'])
			$fullname = @$value['m']['fullname'];
		else 
			$fullname = @$value['m']['fname']." ".@$value['m']['lname'];
		?>
			<h5 class="text-start m-2">Merchant Details</h5>
			<div class="row m-2">
				<div class="col-sm-6 text-start">Company: <?=@$value['m']['company_name'];?></div>

				<div class="col-sm-6 text-start">Full Name : <?=$fullname;?></div>

				<div class="col-sm-6 text-start">Username : <a href="merchant<?=$data['ex']?>?id=<?=$value['clientid']?>&action=detail" target="_blank"  ><?=@$value['m']['username'];?></a></div>

				<div class="col-sm-6 text-start">Phone : <?=@$value['m']['phone'];?></div>
				

				<div class="col-sm-6 text-start">Email : <?=encrypts_decrypts_emails(@$value['m']['registered_email'],2);?></div>

				<div class="col-sm-6 text-start">Address : 
<?=(@$value['m']['address']?$value['m']['address'].', ':"");?>
<?=(@$value['m']['city']?$value['m']['city'].', ':"");?>
<?=(@$value['m']['state']?$value['m']['state'].', ':"");?>
<?=(@$value['m']['country']?$value['m']['country'].' - ':"");?>
<?=(@$value['m']['zip']?$value['m']['zip'].'':"");?>
				</div>
			</div>
			<? } ?>
		</div>
	
	  <div class='row_message border m-2 rounded'>
        <div class='row pe-2'>
          <div class="col-sm-12 text-start" style=""><strong>Subject : </strong><?=$value['subject']?>
            
			
			<? if($value['message_type']){?>
				<div class='messageType11 btn btn-outline-danger btn-sm my-2'>
					<?
						if(is_numeric($value['message_type'])) {
							echo $data['MessageType'][$value['message_type']];
						}else{
							echo $value['message_type'];
						} ?>
				</div>
			<? } ?>
          </div>
        </div>
        <h5 class="text-start m-2">Message Conversation : </h5>
        <div class="row pe-2">
          <div class="col-sm-26 ">
            <pre class="text-wrap"><?=stripslashes($value['comments']);?></pre>
			
          </div>
        </div>
	</div>
	<div class="row">
			<? if($value['more_photograph_upload']){
				$photo=explode('_;',$value['more_photograph_upload']);
			  ?>
				  <div class='row merchant_doc' style="margin:0px;background:#e8e8e8;padding:5px;border-radius:5px;border:2px solid #fff;">
				  <h4 style="font-size:16px;margin:0 5px;">Uploaded by Merchant </h4>
					<div id="formdiv" style="float:left;">
					  <?foreach($photo as $value_po){?>
						<? if($value_po){?>
							<div style="display: block;float:left;width:auto;"><div class="abcd55"><? $pro_img=display_docfile("../user_doc/",$value_po);?><? if($value['status']=="92") { ?><img onClick=ajax_remove_files(this,'<?=$value['id']?>') id=img src=<?=$data['Host']?>/images/x.png alt=delete data-file="<?=$value_po;?>"><? } ?></div>
							</div>
						<? }} ?>	
					</div>
				 </div>
			 <? } ?>
			 
			 <? if($value['admin_doc']){
				$admin_doc=explode('_;',$value['admin_doc']);
			  ?>
				  <div class='row admin_doc' style="margin:25px 0;background:#eff7ff;padding:5px;border-radius:5px;border:2px solid #fff;">
				  <h4 style="font-size:16px;margin:0 5px;">Uploaded by Admin </h4>
					<div id="formdiv" style="float:left;">
					  <?foreach($admin_doc as $admin_doc_po){?>
						<? if($admin_doc_po){?>
							<div style="display: block;float:left;width:auto;"><div class="abcd55"><? $pro_img=display_docfile("../user_doc/",$value_po);?><? if($value['status']=="92") { ?><img onClick=ajax_remove_files(this,'<?=$value['id']?>') id=img src=<?=$data['Host']?>/images/x.png alt=delete data-file="<?=$admin_doc_po;?>"><? } ?></div>
							</div>
						<? }} ?>	
					</div>
				 </div>
			 <? } ?>
		</div>
		
        <? if($value['reply_comments']){?>
        <h3>Reply
          <? if(!empty($value['reply_date'])){?>
          [Date :
          <?=prndate($value['reply_date'])?>
          ]
          <? } ?>
          </h3>
        <div class="row">
          <div class="col-sm-12" >
            <pre style="float:left;width:95%;background:#e4e4e4;"><?=stripslashes($value['reply_comments']);?>
			</pre>
          </div>
        </div>
        <? } ?>
      </div></td>
  </tr>
  <? $j++; } ?>
</table>


<!-- // 5 page:start -->
<div class="pagination pg_load text-center my-1">

	<?php
		includef("../include/pagination_pg".$data['iex']);
		$s_no=(isset($s_no)&&$s_no?$s_no:'');
		$url=$data['Admins']."/message_ajax".$data['ex']."?tab=".$s_no;
		if(isset($_GET['filter'])){$url.="&filter=".$_GET['filter'];}else{$url.="&filter=".$s_no;}
		if(isset($post['type'])){$url.="&type=".$post['type'];}
		if(isset($post['status'])){$url.="&status=".$post['status'];}
		
		
		//if(isset($post['searchkey'])){$url.="&searchkey=".$post['searchkey'];}
		if(isset($_GET['page'])){$page=$_GET['page'];}else{$page=1;}
		if(isset($post['order'])){$url.="&order=".$post['order'];}
		
		$total = (int)$data['result_total_count'];
		
		
		//echo $page."---------".$url."---------".$total;
		pagination(50,$page,$url,$total);

	?>
</div>

</div>
<script>
$('.pg_load a').click(function(){
	window.start_common();
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
	
	if(isset($_SESSION['open_msg_id'])){
	echo "<script> window.open_msg_id('{$_SESSION['open_msg_id']}'); </script>";
	}
	unset($_SESSION['load_tab']); 
 } ?>