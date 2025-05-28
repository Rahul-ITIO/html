<? if(isset($data['ScriptLoaded'])){?>
<? if((!isset($_SESSION['login_adm']))&&((!isset($_SESSION['email_zoho_etc']))||(isset($_SESSION['email_zoho_etc'])&&$_SESSION['email_zoho_etc']==0))){ ?>
<div class="alert alert-danger alert-dismissible fade show m-2 text-center" role="alert">
  <strong>Access Denied</strong> 
  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<? exit; } ?>
<input type="hidden" name="step" value="<?=$post['step']?>">
<style>
.collapsea {cursor:pointer;font-size: 14px!important;}
.collapsea.active {color: #ab0c0c;}
.echektran .collapse, .collapseitem {display:none;}
.echektran .collapse.in, .collapseitem.active  {display:block;}
.addmessageform, .viewdetaildiv {display:none;}
</style>
<?php /*?> include both file for Text Editor <?php */?>
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
var $email_frm_tmp_url="<?=$data['Host']?>/secure/email_frm<?=$data['ex']?>?msg_eml=";
$(document).ready(function(){
    $('.echektran .collapsea').click(function(){
	   var ids = $(this).attr('data-href');
	   var ids2 = ids+"_v";
		if($(this).hasClass('active')){
			$('.collapseitem').removeClass('active');
			$('.collapsea').removeClass('active');
			
			$('#'+ids).slideUp(200);
			$('#'+ids2).slideUp(200);
		} else {
		  $('.collapseitem').removeClass('active');
		  $('.collapsea').removeClass('active');
		  //$('#'+ids).addClass('active');
		  $(this).addClass('active');
		  
		 
		  var $msg_emlVar=$(this).parent().parent().next('tr').find('.msg_eml_divId');
		  //alert('=>'+$msg_emlVar.data('idno'));
			if($($msg_emlVar).hasClass('active')){
			
			}else{
				$msg_emlVar.html('<iframe is="x-frame-bypass" name="modal_popupframe" id="modal_popupframe" src="'+$email_frm_tmp_url+$msg_emlVar.data('idno')+'" width="100%" height="325" scrolling="auto" frameborder="0" marginwidth="0" marginheight="0" style="width:100%!important;height:325px!important;display:block;margin:5px auto;background:#fff;" ></iframe>');
				 $($msg_emlVar).addClass('active');
				 
			}
			
		  $('.collapseitem').slideUp(100);
		  $('#'+ids).slideDown(700);
		  $('#'+ids2).slideDown(700);
		}
        
    });
    
});
</script>
<div class="container border my-1 rounded">
<? if(isset($post['status'])&&$post['status']==0){ $mtitle="All"; }elseif(isset($post['status'])&&$post['status']==1){ $mtitle="Success"; }else{ $mtitle="Failed";}?>
  <div class="container vkg px-0">
    <h4 class="my-2"><i class="<?=$data['fwicon']['email-open'];?>"></i> <?=$mtitle;?>
      Emails ( <?=$data['result_count'];?> of <?=$data['result_total_count'];?> ) </h4>
  </div>
  
<? if((isset($data['Error'])&& $data['Error'])){ ?>
  <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error!</strong>
    <?=prntext($data['Error'])?>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
<? } ?>

<? if((isset($data['sucess'])&& $data['sucess'])){ ?>
  <div class="alert alert-success alert-dismissible fade show" role="alert"> strong>Success!</strong> Your request add support ticket
    <?=prntext($post['subject'])?>
    (
    <?=$post['ticketid']?>
    )
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
<? } ?>

  <? if($post['step']==1){?>
  <div class="widget widget-gray widget-body-white">
    <div class="widget-body mt-2 table-responsive-sm">
      <table class="table table-hover echektran">
        <thead>
          <tr>
		    <th scope="col">#</th>
            <th scope="col">MID</th>
            <th scope="col">Mail Type</th>
            <th scope="col">Subject</th>
            <th scope="col">Email To/From</th>
            <th scope="col">Response Status</th>
            <th scope="col">Date</th>
          </tr>
        </thead>
<? $j=1; foreach($data['selectdatas'] as $key=>$selectdata) {?>
<?php
$email_to_value=$selectdata['email_to'];
$email_from_value=$selectdata['email_from'];
$email_to_1=emtagf(encrypts_decrypts_emails($selectdata['email_to'],2),1);
?>
        <tr>
		 <td>
		  <? 
		  if(strstr($data['MailStatus'][$selectdata['status']],"Success Email")){ 
		  $iconclr="text-success";
		  $icontitle="Success Email";
		  }else if(strstr($data['MailStatus'][$selectdata['status']],"Failed Email")){ 
		  $iconclr="text-danger";
		  $icontitle="Failed Email";
		  }else{
		  $iconclr="text-warning";
		  $icontitle="Other Email";
		  }
		  ?>
            <a class="collapsea text-wrap" data-href="<?=$j;?>_toggle"><i class="<?=$data['fwicon']['display'];?> <?=$iconclr;?> text-link" title="View Detail - <?=$icontitle;?>"></i></a></td>
			
          <td><? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_view'])&&$_SESSION['merchant_action_view']==1)){?>
         <a class="collapsea mprofile badge rounded-pill bg-vdark <?=$selectdata['id'];?>" data-mid="<?=$selectdata['clientid']?>">
            <?=$selectdata['clientid']?>
            </a>
            <? }else{ ?>
            <a class="collapsea badge rounded-pill bg-vdark"  data-mid="<?=$selectdata['clientid']?>" ><?=$selectdata['clientid']?></a>
            <? }?></td>
          <td><?=$data['EmailType'][$selectdata['mail_type']]?></td>
          <td >
		  <span class="d-inline-block text-truncate" style="max-width: 150px;" title="<?=$selectdata['subject']?>" data-bs-toggle="tooltip" data-bs-placement="top">
            <?=$selectdata['subject']?>
			</span>
           </td>
          <td>
		  <span class="d-inline-block text-truncate" style="max-width: 140px;" title="To:<?=(encrypts_decrypts_emails($email_to_1,2,1));?> From: <?=(encrypts_decrypts_emails($email_from_value,2,1));?>" data-bs-toggle="tooltip" data-bs-placement="top">
			<b>To:</b> <?=(encrypts_decrypts_emails($email_to_1,2,1));?>&nbsp;<b>From:</b> <?=(encrypts_decrypts_emails($email_from_value,2,1));?>
			</span>
		</td>
          <td>
		  <span class="d-inline-block text-truncate" style="max-width: 150px;" title="<?=$selectdata['response_status']?>"><?=$selectdata['response_status']?></span>
		  </td>
          <td><?=prndate($selectdata['date']);?></td>
         
        </tr>
        <tr class="padding0 rounded" id="<?=$j;?>_toggle_v" style="display:none;">
          <td class="padding0" colspan=7 ><div class="collapseitem" id="<?=$j;?>_toggle">
              <div class="row_col3 row border text-danger rounded m-2 py-2">
                <div class="col-sm-3 text-start">
                  <h6>To : <?=(encrypts_decrypts_emails($email_to_1,2,1));?> </h6>
                </div>
                <div title="<?=prndate($selectdata['date']);?>" class="col-sm-3  text-start">
                  <h6>Date :
                    <?=prndate($selectdata['date']);?>
                  </h6>
                </div>
                <div class="col-sm-3  text-start">
                  <h6>Status :
                    <?=$data['MailStatus'][$selectdata['status']];?>
                  </h6>
                </div>
                <div class="col-sm-3  text-start">
                  <? if($selectdata['status'] !="2") { ?>
                  <? }?>
                  <a class="addmessagelink badge rounded-pill  btn btn-primary float-start" onclick="addmessages(this)">Resend</a>&nbsp;&nbsp;<a class="viewdetaillink badge rounded-pill  btn btn-primary float-start ms-2" onclick="viewdetails(this)">Details</a> </div>
              </div>
              <div id="addmessageform" class="addmessageform mx-2">
                <form action="<?=$data['Admins'];?>/emails<?=$data['ex']?>" method="post">
                  <input type="hidden" name="action" value="addmessage">
                  <input type="hidden" name="id" value='<?=$selectdata['id']?>'>
                  <input type="hidden" name="page" value='<?=$post['StartPage']?>'>
<script>document.write('<input type="hidden" name="aurl" value="'+top.window.document.location.href+'">');</script>
                  <div class="my-2">
                    <select name="status" id="status_<?=$j;?>" class="feed_input1 form-select" required style="width:100%!important; display:none;">
                      <option>Select Status</option>
                      <?foreach($data['MailStatus'] as $key=>$value){?>
                      <option value="<?=$key?>">
                      <?=$value?>
                      </option>
                      <? }?>
                    </select>
                  </div>
                  <div class="my-2">
                    <input type="text" class="form-control" name="subject" value="<?=$selectdata['subject']?>" style="width:100% !important;">
                  </div>
                  <script>
						$('#status_<?=$j;?> option[value="<?=prntext($selectdata['status'])?>"]').prop('selected','selected');
					</script>
                  <div class="my-2 text-start">
                    <textarea id="mustHaveId" class="span12 jqte-test form-control" name="comments" rows="5" placeholder="Enter a Message" style="width:100%; height:80px;"><?=stripslashes($selectdata['message']);?>
</textarea>
                  </div>
                  <div class="my-2 col-sm-12 row float-start text-center">
                    <button type="submit" name="addmessage" value="CONTINUE" class="btn btn-primary float-start" style="width:200px;display:block;margin:0 auto;"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Send Message</button>
                  </div>
                </form>
              </div>
              <div class="viewdetaildiv bg-white m-2" id="viewdetaildiv">
                <div class="row">
                  <div class="col-sm-2 text-start border rounded">
                    <h6>Mail DETAILS:
                      <?=$selectdata['id']?>
                    </h6>
                  </div>
                  <div class="col-sm-5 text-start border">
                    <h6>Message-Id:
                      <?=$selectdata['response_msg']?>
                    </h6>
                  </div>
                  <div class="col-sm-5 text-start border">
                    <h6>Mail FROM: <?=(encrypts_decrypts_emails($email_from_value,2,1));?>
                    </h6>
                  </div>
                  <div class="col-sm-12 text-start border">
                    <?
					if($selectdata['json_value']){
						$json_value=json_decode($selectdata['json_value'],true);
						if(isset($json_value['h:Reply-To'])&&$json_value['h:Reply-To']){
							$replyTo=jsonencode(@$json_value['h:Reply-To']);
							$json_value['h:Reply-To']=(encrypts_decrypts_emails(@$replyTo,2,1));
							echo "<b>h:Reply-To</b>=>".$json_value['h:Reply-To']."<br/>";
						}
						if(isset($json_value['from'])&&$json_value['from']){
							$jsn_from=jsonencode(@$json_value['from']);
							$json_value['from']=(encrypts_decrypts_emails(@$jsn_from,2,1));
							
						}
						if(isset($json_value['to'])&&$json_value['to']){
							
							//$jsn_to=jsonencode($json_value['to']);
							
							//$json_value['to']=(encrypts_decrypts_emails(@$jsn_to,2,1));
							
							unset($json_value['to']);
							
						}
						if(isset($json_value['post']['remail'])&&$json_value['post']['remail']){
							$jsn_remail=jsonencode(@$json_value['post']['remail']);
							$json_value['post']['remail']=(encrypts_decrypts_emails(@$jsn_remail,2,1));
							
						}
						print_r(jsonencode($json_value));
					}
					?>
                  </div>
                </div>
              </div>
              <div class="container"  style="clear:both;">
                <div class="row">
                  <div class="col-sm-4 text-start"><strong>Email To/From :</strong>
                    <?=(encrypts_decrypts_emails($email_to_1,2,1));?> / <?=(encrypts_decrypts_emails($email_from_value,2,1));?>
                  </div>
                  <div class="col-sm-4 text-start"><strong>Subject :</strong>
                    <?=$selectdata['subject']?>
                  </div>
                  <div class="col-sm-4 text-start"><strong>Email Message :</strong>
                    <?=$selectdata['id']?>
                  </div>
                  <div class="col-sm-12 text-start border bg-white rounded my-2">
                    <? 
					//$_SESSION['msg_eml'.$selectdata['id']]=($selectdata['message']);
					?>
                    <div class="msg_eml_divId m-2" data-idno="<?=$selectdata['id']?>">
                      <?=$selectdata['id']?>
                    </div>
                  </div>
                </div>
              </div>
              <? if(isset($selectdata['reply_comments'])&&$selectdata['reply_comments']){?>
              <div><strong>REPLY
                <? if(!empty($selectdata['reply_date'])){?>
                [Date :
                <?=prndate($selectdata['reply_date'])?>
                ]
                <? }?>
                </strong></div>
              <div class="row">
                <div class="col-sm-12" >
                  <pre style="float:left;width:96%;"><?=stripslashes($selectdata['reply_comments']);?>
</pre>
                </div>
              </div>
              <? }?>
            </div></td>
        </tr>
        <? $j++; }?>
      </table>
    </div>
  </div>
  <?php /*?>Below code used for Pagination with include file<?php */?>
  <!-- // 5 page:start -->
  <div class="pagination">
    <?php
		include("../include/pagination_pg".$data['iex']);
		
		if(isset($_GET['page'])){$page=$_GET['page'];unset($_GET['page']);}else{$page=1;}
		$get=http_build_query($_GET);
		$url=$data['Admins']."/emails{$data['ex']}?".$get;
		
		$total = (int)$data['result_total_count'];
		
		pagination(50,$page,$url,$total);
		
	?>
  </div>
  <!-- // 5 page:end -->
  <? } elseif($post['step']==2){ ?>
  <? if($post['gid']){ ?>
  <input type="hidden" name="gid" value="<?=$post['gid']?>">
  <? } ?>
</div>
<? }?>
<?php /*?>js for text editor <?php */?>
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
<? }else{ ?>
SECURITY ALERT: Access Denied
<? }?>
</div>
