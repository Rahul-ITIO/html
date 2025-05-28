<? if(isset($data['ScriptLoaded'])){ ?>
<div class="container border my-1 rounded vkg">
  <form method="post" name="data">
    <input type="hidden" name="step" value="<?=$post['step']?>">
    <script>
var wn=0;

function dialog_box2_close() {
	popupclose();
	$('#dialog_box2').hide();
}
function templatesf(theId) {
  //alert(theValue+'\r\n'+theId+'\r\n'+theMid);
  
  var thisurls="<?=$data['Admins']?>/<?=$data['PageFile']?><?=$data['ex']?>";
			thisurls=thisurls+"?action=all_clients&gid="+theId;
	   //alert(thisurls);
	
	
	//alert(oldValue+"\r\n"+theValue+"\r\n"+box);
	
	
	var txt;
	var r = confirm("Are you sure add templates for All Merchant !");
	
	if(r==true) {
	  txt = "You pressed OK!";
	  
			popuploadig();	
			$('.modal_popup_form_popup_body').hide();
			$('#dialog_box2').show(1000);
			
			$('#baseRate_submit').click(function() {

				var baseRate_transaction_rate = $('#baseRate_transaction_rate').val();
				var baseRate_txn_fee = $('#baseRate_txn_fee').val();
				
				
				thisurls=thisurls+"&baseRate_transaction_rate="+baseRate_transaction_rate+"&baseRate_txn_fee="+baseRate_txn_fee;
				
				if(wn){
					//window.open(thisurls,'_blank'); return false;
				}
				
				$.ajax({  
					 url:thisurls,  
					 type: "POST",
					 dataType: 'json', // text
					 data:{gid:theId, baseRate_transaction_rate:baseRate_transaction_rate, baseRate_txn_fee:baseRate_txn_fee, action:"all_clients"},  
					 success:function(data){  
					 
					  if(data['Error']&&data['Error'] != ''){  
						   alert(data['Error']);
					  }else{
						  //popupclose();
						  dialog_box2_close();
						  //myObj = JSON.parse(this.responseText);
						  alert(JSON.stringify(data));
						  //alert(data);
					  }
					}
				});
			
			});
		
			
	}else{
	  txt = "You pressed Cancel!";
	  alert(txt);
	 // $('#'+box+' option[value="'+oldValue+'"]').prop('selected','selected');
   }
   return false;
}
		
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

</script>
    <? if((isset($data['Error'])&& $data['Error'])){ ?>
    <div class="alert alert-danger alert-dismissible my-2">
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      <strong>Error!</strong>
      <?=prntext($data['Error'])?>
    </div>
    <? }?>
    <? if((isset($_SESSION['action_success'])&& $_SESSION['action_success'])){ ?>
    <div class="alert alert-success alert-dismissible my-2">
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      <strong>Success!</strong>
      <?=$_SESSION['action_success'];?>
    </div>
    <? $_SESSION['action_success']=null; } ?>
    <? if($post['step']==1){ ?>
    <div class="container row text-end px-0 title_addnew_common">
      <div class="col-sm-6 my-2 ps-0 text-start">
        <div class="container vkg px-0">
          <h4 class="my-2"><i class="<?=$data['fwicon']['pricing-template'];?>"></i> Acquirer Template </h4>
          <div class="vkg-main-border"></div>
        </div>
      </div>
      <div class="col-sm-6 my-2 ps-0 text-end">
        <button type="submit" name="send" value="Add A New Acquirer Template!"  class="btn btn-primary" title="Add A New Acquirer Template"><i class="<?=$data['fwicon']['circle-plus'];?>"></i></button>
      </div>
    </div>
    <div class="container table-responsive-sm">
      <table class="table table-hover">
        <thead>
          <tr>
		    <th scope="col">#</th>
            <th scope="col">ID</th>
            <th scope="col">Acquirer</th>
            <th scope="col">Templates Name</th>
            <th scope="col" class="hide-768">Comments</th>
            <th scope="col" class="hide-768">Date</th>
            <th scope="col">Action</th>
          </tr>
        </thead>
        <? foreach($post['result_list'] as $key=>$value) {  
		$value['assign_id']=str_replace('<a class=flagtags>','',$value['assign_id']);
		$value['assign_id']=str_replace('</a>','',$value['assign_id']);
		?>
        <tr>
		<td><a data-bs-toggle="modal" data-count="<?=prntext($value['id'])?>" class="tr_open_on_modal text-decoration-none" data-bs-target="#myModal"><i class="<?=$data['fwicon']['display'];?> text-link" title="View details"></i></a></td>
          <td><?=$value['id'];?></td>
          <td title="<?=substr($value['assign_id'],6);?>" data-bs-toggle="tooltip" data-bs-placement="top"><span class="d-inline-block text-truncate" style="max-width: 150px;" ><?=substr($value['assign_id'],6);?></span></td>
          <td><?=$value['templates_name']?></td>
          <td title="<?=$value['comments'];?>" data-bs-toggle="tooltip" data-bs-placement="top" class="hide-768"><span class="d-inline-block text-truncate" style="max-width: 150px;" ><?=$value['comments']?></span></td>
          <td class="hide-768"><span title='Updated Date: <?=prndate($value['udate'])?>'><strong>UD: </strong>
            <?=prndate($value['udate'])?></span><br /><span title='Created Date: <?=prndate($value['cdate'])?>'><strong>CD: </strong> <?=prndate($value['cdate'])?> </span> </td>
            
          <td>
		  <div class="btn-group dropstart short-menu-auto-main"> <a data-bs-toggle="dropdown" aria-expanded="false"  title="Action"><i class="<?=$data['fwicon']['action'];?> text-link"></i></a>
                <ul class="dropdown-menu dropdown-menu-icon pull-right" >
				
                  <li> <a class="dropdown-item" href="<?=$data['Admins'];?>/<?=$data['PageFile']?><?=$data['ex']?>?id=<?=$value['id']?>&action=update" title="Edit" ><i class="<?=$data['fwicon']['edit'];?> text-success float-start"></i> <span class="action_menu">Edit</span></a></li>
                  
				  <? if(strpos($value['comments'],"Assign for All")!==false){ ?>
                  <li> <a class="dropdown-item"  onclick="templatesf('<?=$value['id']?>');" title="Assign for All Merchant"><i class="<?=$data['fwicon']['setting'];?> float-start"></i> <span class="action_menu">Assign</span></a></li>
				  <? } ?>
				  
			    <? if(isset($value['json_log_history'])&&$value['json_log_history']){?>
			      <li> 
			<a class="dropdown-item" onclick="popup_openv('<?=$data['Host']?>/include/json_log<?=$data['ex']?>?tableid=<?=$value['id'];?>&tablename=acquirer_group_template')" title="View Json History">
			<i class="<?=$data['fwicon']['circle-info'];?> text-info float-start"></i> <span class="action_menu">Json History</span></a>
			
			</li>
			    <? } ?>

                </ul>
              </div>
		  
	
          </td>
        </tr>
    <tr class="hide">
    <td colspan="7">
	 <div class="next_tr_<?=prntext($value['id']);?> hide row">
	 <div class="mboxtitle hide">Bank Detail : <?=$value['id'];?></div>
              <?php /*?><div class="row border bg-light my-2 text-start border text-white row_col3" style="display:none;">
                <div class="row col-sm-4 my-2" >
                  <div class="col-sm-4">ID:</div>
                  <div class="col-sm-8">
                    <? if(isset($value['id'])) echo $value['id']?>
                  </div>
                </div>
                <div class="row col-sm-4 my-2">
                  <div class="col-sm-4">Date :</div>
                  <div class="col-sm-8">
                    <? if(isset($value['date'])) echo ate("D d-m-Y h:i A",strtotime($value['date']));?>
                  </div>
                </div>
                <div class="row col-sm-4 my-2">
                  <div class="col-sm-4">Status :</div>
                  <div class="col-sm-8">
                    <? if(isset($value['status'])) echo $data['TicketStatus'][$value['status']];?>
                  </div>
                </div>
                <? if(!isset($value['status'])||$value['status'] !="2") { ?>
                <div class="row col-sm-12 my-2 text-end"> <a class="addmessagelink" onclick="addmessages(this)"> Add Comments</a> </div>
                <? }?>
              </div> <div class="row border bg-light my-2 text-start border text-white row_col3" style="display:none;">
                <div class="row col-sm-4 my-2" >
                  <div class="col-sm-4">Currency:</div>
                  <div class="col-sm-8">
                    <? if(isset($value['currency'])) echo $value['currency']?>
                  </div>
                </div>
                <div class="row col-sm-4 my-2">
                  <div class="col-sm-4">Bank User Id :</div>
                  <div class="col-sm-8">
                    <? if(isset($value['bank_user_id'])) echo $value['bank_user_id']?>
                  </div>
                </div>
                <div class="row col-sm-4 my-2">
                  <div class="col-sm-4">Comments/Note :</div>
                  <div class="col-sm-8">
                    <? if(isset($value['comments'])) echo $value['comments']?>
                  </div>
                </div>
              </div><?php */?>
			  
			  <div class="col-sm-12 border rounded mb-2">
			  
			    <div class="row m-2">
				<div class="col-sm-3">Acquirer </div>
				<div class="col-sm-9">: <?=$value['assign_id'];?></div>
			    </div>
				
				<div class="row m-2">
				<div class="col-sm-3">Templates Name </div>
				<div class="col-sm-9">: <?=$value['templates_name']?></div>
			    </div>
				
				<div class="row m-2">
				<div class="col-sm-3">Comments </div>
				<div class="col-sm-9">: <?=$value['comments'];?></div>
			    </div>
				
				<div class="row m-2">
				<div class="col-sm-3">Date </div>
				<div class="col-sm-9">: UD: <?=prndate($value['udate'])?>  &&
			                            CD: <?=prndate($value['cdate'])?> </div>
			    </div>
			  
			  
			  </div>
             
              <div class="col-sm-12 border rounded mb-2 p-2">
                <div>
                  <h6>Comments/Note ::</h6>
                  <p>
                    <? if(isset($value['comments'])) echo $value['comments']?>
                  </p>
                </div>
                <? if(isset($value['reply_comments'])&&$value['reply_comments']){ ?>
                <h6> REPLY
                  <? if(!empty($value['currency_rate'])){ ?>
                  [Date :
                  <?=prndate($value['currency_rate'])?>
                  ]
                  <? }?>
                </h6>
                <p>
                  <? if(isset($value['reply_comments'])) echo $value['reply_comments']?>
                </p>
                <? }?>
              </div>
			  
			  
            </div>
			
			</td>
        </tr>
        <? }?>
      </table>
    </div>
    <? }elseif($post['step']==2){ ?>
    <? if(isset($post['gid'])&&$post['gid']){?>
    <input type="hidden" name="gid" value="<?=$post['gid']?>">
    <input type="hidden" name="id" value="<?=$post['id']?>">
    <input type="hidden" name="action" value="update_db">
    <? }else{ ?>
    <input type="hidden" name="action" value="insert">
    <? }?>
    <script>document.write('<input type=hidden name=aurl value="'+top.window.document.location.href+'">');</script>
    <div class="row">
      <div class="container vkg px-0">
        <h4 class="my-2">
          <?php if(isset($post['gid'])&&$post['gid']){ ?>
          <i class="<?=$data['fwicon']['edit'];?>"></i> Edit
          <? } else { ?>
          <i class="<?=$data['fwicon']['circle-plus'];?>"></i> Add New
          <? } ?>
          Acquirer Template
          <?php if(isset($post['gid'])&&$post['gid']){ ?>
          <? if(isset($post['json_log_history'])&&$post['json_log_history']){?>
          <i class="<?=$data['fwicon']['circle-info'];?> text-info fa-fw" 
			onclick="popup_openv('<?=$data['Host']?>/include/json_log<?=$data['ex']?>?tableid=<?=$post['id'];?>&tablename=acquirer_group_template')" title="View Json History"></i>
          <? } ?>
          <? } ?>
        </h4>
        <div class="vkg-main-border"></div>
      </div>
      <div class="row rounded p-1 mb-2">
        <div class="col-sm-12 ps-0">
          <label for="Acquirer ID" class="form-label">Acquirer :</label>
          <select id="tid" data-placeholder="Begin typing a name to filter for Acquirer ID" multiple class="chosen-select form-control" name="tid[]" >
            <?=showselect($data['tid'], (isset($post['tid'])?$post['tid']:0),1)?>
          </select>
		<script>
			$(".chosen-select").chosen({
			no_results_text: "Oops, nothing found!"
			});
		</script>
		<script>
			$("#tid_chosen").css("width", "100%");
			$("#tid_chosen").addClass("bg-vlight44");
			$("#tid_chosen").addClass("form-control");
		</script>
        </div>
        <div class="col-sm-6 ps-0">
          <label for="Templates Name" class="form-label">Templates Name:</label>
          <textarea class="form-control" name="templates_name" id="templates_name" placeholder="Enter Templates Name"  title="Templates Name" required><? if(isset($post['templates_name'])) echo $post['templates_name'];?>
</textarea>
        </div>
        <div class="col-sm-6 ps-0">
          <label for="Note/Comments" class="form-label">Note/Comments:</label>
          <textarea id="mustHaveId" class="form-control" name="comments"  placeholder="Enter Note"  title="Note/Comments" required><? if(isset($post['comments'])) echo $post['comments'];?>
</textarea>
        </div>
        <div class="my-2 text-center row p-0">
          <div class="col-sm-12 my-2 ps-0 remove-link-css text-center">
            <button formnovalidate type="submit" name="send" value="CONTINUE"  class="btn btn-icon btn-primary"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Submit</button>
            <a href="<?=$data['Admins']?>/<?=$data['PageFile']?><?=$data['ex']?>" class="btn btn-icon btn-primary "><i class="<?=$data['fwicon']['back'];?>"></i> Back</a> </div>
        </div>
      </div>
    </div>
    <? }?>
  </form>
</div>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? }?>
