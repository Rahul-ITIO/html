<? if(isset($data['ScriptLoaded'])){?>
<div class="container border my-1 rounded vkg">
  
<script>
<?
	if(isset($_REQUEST['a'])&&$_REQUEST['a']=='p'){
		$k_typ='&a=p';
	}else{
		$k_typ='';
	}
?>
var k_typ="<?=stf($k_typ);?>";
function checkAvailability(gid,theAction='') {
	var valuesVar=$("#tid").chosen().val();
	//alert($(e).val()+'\r\n'+$("#tid").chosen().val());
	//alert(valuesVar+"\r\n"+valuesVar[0]+"\r\n"+valuesVar.length+'\r\n'+theAction);
	if(theAction=="edit"){
		var ajaxVar="OK";
	}else{
		if(valuesVar.length===1){
			var ajaxVar="OK";
		}else{
			var ajaxVar="false";
		}
	}
	if(ajaxVar=="OK"){
		//$("#loaderIcon").show();
		var thisUrl="<?=$data['Admins']?>/add_salt<?=$data['ex']?>?gid="+gid+k_typ;
		//alert(gid+'\r\n'+thisUrl);
		$.ajax({
			url:thisUrl,
			data:'tid='+valuesVar[0],
			type: "POST",
			success:function(data){
				$("#user-availability-status").html(data);
				//$("#loaderIcon").hide();
			},
			error:function (){}
		});
	}

}
</script>
  <script type="text/javascript">
function checkvalidation(){
	if (document.getElementById("salt_name").value.trim() == "") {
		document.getElementById("salt_name").focus();
		alert("Please Enter Name!");
		return false;
	}
			
	if (document.getElementById("mustHaveId").value.trim() == "") {
		document.getElementById("mustHaveId").focus();
		alert("Please Enter Comment!");
		return false;
	}
	if (document.getElementById("tid").value.trim() == "") {
		document.getElementById("tid").focus();
		alert("Please Select Aquirer ID!");
		return false;
	}
}
</script>
  <form method="post" name="data"  >
    <input type="hidden" name="step" value="<?=$post['step']?>">
    <style>


fieldset {background: #fff;float:left;float:left;width:97%;position:relative;left:1%;}
.fieldsetFocus {background:#e2f8db;}
.solast {background:yellow;}
.co2 > fieldset:focus-within {background:#e2f8db;}

.listData fieldset {border-radius:3px;border:1px solid #898989;margin:5px 0;-webkit-column-break-inside: avoid;page-break-inside:avoid;break-inside:avoid;padding:0 5px 7px 5px;}
fieldset fieldset {margin:1px 0;}
legend{background:#eaeaea;padding:2px 10px;font-size:16px;font-family:sans-serif;font-weight:700;border-radius:3px;margin:3px 0 10px 10px;width:auto;}
.m_row {display:block;width:100%;clear:both;}
.m_row input{width:92%;padding:3px 10px;border-radius:3px;border:1px solid #898989;height: 25px !important;}
.col_key {float:left;padding:3px 0;display:table-cell;width:calc(40% - 18px) !important;margin:3px;border:0px solid #ccc;border-radius:3px;}
.col_val{float:left;padding:3px 0;display:table-cell;margin:3px;border:0 solid #ccc;border-radius:3px}
.col_val {width: calc(58% - 18px)!important;}
fieldset .col_val {width:calc(60% - 18px)!important;}

.remove_row_del{float:left;padding:4px 0;display:block;width:calc(4% - 18px)!important;margin:3px 0;border:0 solid #ccc;border-radius:3px;height:20px;line-height:20px;overflow:hidden;min-width:20px;background:#ddd;text-align:center;font-size:16px;font-family:sans-serif;color:#333 !important;cursor:pointer;}

.co2{padding:0;-webkit-column-count:2;-moz-column-count:2;column-count:2;-webkit-column-gap:20px;-moz-column-gap:20px;column-gap:20px;-webkit-column-rule:1px solid #d3d3d3;-moz-column-rule:1px solid #d3d3d3;column-rule:1px solid #d3d3d3;clear:both}

fieldset fieldset  .co2 {-webkit-column-count:1;-moz-column-count:1;column-count:1;}

.addMore_row_del {display:block;width:100%;clear:both;text-align:right;}
.input_addMore_del{float:right;display:block;width:auto;margin:3px 0;border:0 solid #ccc;border-radius:3px;/*height:20px;*/line-height:20px;overflow:hidden;min-width:100px;background:#959595;text-align:center;font-size:16px;font-family:sans-serif;padding:5px 10px;color:#fff!important;cursor:pointer;/*position:relative;*/z-index:99;bottom:-14px;right:-14px;-webkit-column-break-inside: avoid;page-break-inside:avoid;break-inside:avoid;}
.input_addMore:hover,.remove_row:hover{background:#f28500;}

.key_title {margin:0 0 0 10px;}

/*@media(max-width:767px){.col1{width:52%;}.col_3{width:25%}.rmk_row{border-top:none!important;}}*/
</style>
    <script>
var wn=0;
function dialog_box2_close() {
	popupclose();
	$('#dialog_box2').hide();
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
/*function addmessages(e){
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
}*/

$(document).ready(function(){
    /*$('.echektran .collapsea').click(function(){
	   var ids = $(this).attr('data-href');
	   var idsnew = $(this).attr('data-href')+'_tr';
	   //alert(idsnew);
	   
		if($(this).hasClass('active')){
		
		//alert(1);
		
		
			$('.collapseitem').removeClass('active');
			$('.collapsea').removeClass('active');
			$('#'+idsnew).addClass('hide');
			
			$('#'+ids).slideUp(200);
		} else {
		//alert(2);
		  
		  $('.collapseitem').removeClass('active');
		  $('.collapsea').removeClass('active');
		  //$('#'+ids).addClass('active');
		  $(this).addClass('active');
		  $('#'+idsnew).removeClass('hide');
		  
		  $('.collapseitem').slideUp(100);
		  $('#'+ids).slideDown(700);
		}
        
    });*/
	
	$('#salt_filter').change(function(){
	   var thisVal = $(this).val();
		window.location.href="<?=$data['Admins']?>/salt_management<?=$data['ex']?>?action="+thisVal;
    });
	
	
	
    
});
</script>
    <? if((isset($data['Error'])&& $data['Error'])){ ?>
    <div class="alert alert-danger alert-dismissible my-2">
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      <strong>Error!</strong>
      <?=prntext($data['Error'])?>
    </div>
    <? } ?>
  <? if((isset($_SESSION['action_success'])&& $_SESSION['action_success'])){ ?>
    <div class="alert alert-success alert-dismissible my-2">
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      <!--<strong>Success!</strong>-->
      <?=$_SESSION['action_success'];?>
    </div>
    <? $_SESSION['action_success']=null; } ?>
    <? if($post['step']==1){?>
    <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['add_new_salt'])&&$_SESSION['add_new_salt']==1)){?>
    <div class="row  ps-0">
	
<div class="col-sm-8 my-2 vkg ps-0">
<h4 class="my-2"><i class="<?=$data['fwicon']['salt-management'];?>"></i> Salt Management <a data-ihref="<?=$data['Admins']?>/json_log_all<?=$data['ex']?>?tablename=salt_management&mode=json_log" title="View Json Log History" onclick="iframe_open_modal(this);"><i class="<?=$data['fwicon']['circle-info'];?> text-danger fa-fw"></i></a></h4>
</div>

      <div class="col-sm-4 my-2 ps-0">
        <select name="salt_filter" id="salt_filter" class="select_cs_21 form-select me-2 float-start" autocomplete="off" style="width: calc(100% - 50px);">
          <option value="Active" title="Show Data List of Active Only" >Active</option>
          <option value="deletedlist" title="Show Data List of Deleted Only" >Deleted</option>
          <option value="all" title="Show Data List of Active and Deleted" selected="selected">All</option>
        </select>
        <script>
			$('#salt_filter option[value="<?=($post['action'])?>"]').prop("selected", "selected");
		</script>
      
        <button type="submit" name="send" value="Add A New Salt!" title="Add A New Salt"  class="btn btn-primary"  style="width:40px"><i></i><i class="<?=$data['fwicon']['circle-plus'];?>"></i></button>
      </div>
    </div>
    <? } ?>
    <div class="container table-responsive-sm">
      <table class="table table-hover">
        <thead>
          <tr>
		    <th scope="col">#</th>
            <th scope="col">ID</th>
            <th scope="col">Salt Key</th>
            <th scope="col">Acquirer</th>
            <th scope="col">Salt Title</th>
            <th scope="col" class="hide-768">Comments</th>
            <th scope="col" class="hide-768">Date</th>
            <th scope="col">Action</th>
          </tr>
        </thead>
        <? 
	
	$j=1; 
	
	foreach($post['result_list'] as $key=>$value) {
	?>
        <tr>
		<td><a data-bs-toggle="modal" data-count="<?=prntext($value['id'])?>" class="tr_open_on_modal text-decoration-none" data-bs-target="#myModal"><i class="<?=$data['fwicon']['display'];?> text-link" title="View details"></i></a></td>
          <td><?=$value['id'];?></td>
          <td><?=$value['salt_key'];?></td>
          <td><span class="btn btn-abv-search"><?=$value['assign_id'];?></span></td>
          <td><?=ucwords(strtolower($value['salt_name']))?></td>
          <td class="hide-768"><?=ucfirst($value['comments'])?></td>
          <td class="hide-768"><div title='Updated Date: <?=prndate($value['udate'])?>'>UD:
              <?=prndate($value['udate'])?>
            </div>
            <div title='Created Date: <?=prndate($value['cdate'])?>'>CD:
              <?=prndate($value['cdate'])?>
            </div></td>
          <td>
		  
		  <div class="btn-group dropstart short-menu-auto-main"> <a data-bs-toggle="dropdown" aria-expanded="false"  title="Action"><i class="<?=$data['fwicon']['action'];?> text-link"></i></a>
                <ul class="dropdown-menu dropdown-menu-icon pull-right" >
				
				<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['edit_salt'])&&$_SESSION['edit_salt']==1)){?>
                  <li> <a class="dropdown-item" href="<?=$data['Admins'];?>/<?=$data['PageFile']?><?=$data['ex']?>?id=<?=$value['id']?>&action=update" title="Edit" ><i class="<?=$data['fwicon']['edit'];?> text-success float-start"></i> <span class="action_menu">Edit</span></a></li>
				<? } ?> 
                  
                <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['delete_salt'])&&$_SESSION['delete_salt']==1)){?>
                  <li> <a class="dropdown-item"  href="<?=$data['Admins'];?>/<?=$data['PageFile']?><?=$data['ex']?>?id=<?=$value['id']?>&action=delete" onclick="return confirm('Are you Sure to Delete');" title="Delete"><i class="<?=$data['fwicon']['delete'];?> text-danger float-start"></i> <span class="action_menu">Delete</span></a></li>
				<? } ?>  
			    <? if(isset($value['json_log_history'])&&$value['json_log_history']){?>
			      <li> 
				  <a class="dropdown-item" onclick="popup_openv('<?=$data['Host']?>/include/json_log<?=$data['ex']?>?tableid=<?=$value['id'];?>&tablename=salt_management')" title="View Json History"> 
			<i class="<?=$data['fwicon']['circle-info'];?> text-info float-start"></i> <span class="action_menu">Json History</span> 
			
			</a>
			</li>
			    <? } ?>

                </ul>
              </div>
			  
          </td>
        </tr>
        <tr class="hide">
    <td colspan="8">
	 <div class="next_tr_<?=prntext($value['id']);?> hide row">
	 <div class="mboxtitle hide">Salt Management : <?=$value['assign_id'];?></div>
              <?php /*?><div class="row_col3" style="display:none;">
                <div class="col1">ID :
                  <? if(isset($value['id'])) echo $value['id']?>
                </div>
                <div class=col2>Date :
                  <? if(isset($value['date'])) echo ate("D d-m-Y h:i A",strtotime($value['date']));?>
                </div>
                <div class=col_3>Status :
                  <? if(isset($value['status'])) echo $data['TicketStatus'][$value['status']];?>
                </div>
                <div class=col4>
                  <? if(!isset($value['status'])||$value['status'] !="2") { ?>
                  <a class="addmessagelink" onclick="addmessages(this)"> Add Comments</a>
                  <? } ?>
                </div>
              </div><?php */?>
              <?php /*?><div class="row listData">
<div class="text-start my-2 ms-3"><? echo json_log_view($value['json_log_history'],'View Json Log','0','json_log','','100');?></div><?php */?>
<div class="row border bg-light my-2 text-start rounded">

<div class="col-sm-12 m-2">ID : <?=$value['id'];?></div>
<div class="col-sm-12 m-2">Salt Key : <?=$value['salt_key'];?></div>
<div class="col-sm-12 m-2">Acquirer : <?=$value['assign_id'];?></div>
<div class="col-sm-12 m-2">Salt Title : <?=ucwords(strtolower($value['salt_name']))?></div>
<div class="col-sm-12 m-2">Comments : <?=ucfirst($value['comments'])?></div>
<div class="col-sm-12 m-2">Date : <?=prndate($value['udate'])?> (UD) && <?=prndate($value['cudate'])?> (CD)
</div>


                <div class="col-sm-12 m-2">
                
                  <?	
						$tid_0=explodef($value['tid'],',',0);
						$tid_get=$tid_0." ".$data['t'][$tid_0]['name1'];
						//echo $tid_get;
						$json_arr=[];  $json_array_key=[];
						$json_value=isJsonEn($value['bank_salt']);
						$json_de=$json_value;
						$json_arr[$tid_get]=$json_de;
						//$json_array_key=array_merge(['saltJson'],(array_keys($json_arr['saltJson'])));
						//print_r($json_array_key);
						$de_josn1=is_multi_label_arrayf($json_arr, $json_array_key,$tid_get);
						echo "<div class='inputJsonDiv'>".$de_josn1."</div>";
						
					?>
                </div>
              </div>
			  
			  
              <? if(isset($value['reply_comments'])&&$value['reply_comments']){ ?>
              <div class="title2"><b>Reply
                <? if(!empty($value['currency_rate'])){?>
                [Date : <?=date("d-m-Y h:i A",strtotime($value['currency_rate']))?> ]
                <? } ?>
                </b></div>
              <div class="row">
                <div class="col_2" style="width:100%;"><?=$value['reply_comments']?></div>
              </div>
              <? } ?>
            </div>
			
			</td>
        </tr>
        <?  } ?>
      </table>
    </div>


<? }elseif($post['step']==2){ ?>
<? if(isset($post['gid'])&&$post['gid']){ 
$postgid=$post['gid'];  
?>

    <input type='hidden' name='gid' value="<?=$post['gid']?>">
    <input type='hidden' name='id' value="<?=$post['id']?>">
	<input type='hidden' name='hideAllMenu' value="<? if(isset($_GET['hideAllMenu'])) echo $_GET['hideAllMenu']?>">
    <input type='hidden' name='action' value="update_db">
    <? }else{ ?>
    <input type="hidden" name="action" value="insert">
    <? } ?>
    <script>document.write('<input type=hidden name=aurl value="'+top.window.document.location.href+'">');</script>
	
	<div class=" container vkg px-0">
	  <h4 class="my-2"><? if(isset($post['gid'])&&$post['gid']){ ?> <i class="<?=$data['fwicon']['edit'];?>"></i> Edit <? } else { ?> <i class="<?=$data['fwicon']['circle-plus'];?>"></i> Add New <? } ?> Salt Management System <? if(isset($post['gid'])&&$post['gid']){ ?> 
	        <? if(isset($post['json_log_history'])&&$post['json_log_history']){?>
			<i class="<?=$data['fwicon']['circle-info'];?> text-info fa-fw" 
			onclick="popup_openv('<?=$data['Host']?>/include/json_log<?=$data['ex']?>?tableid=<?=$post['id'];?>&tablename=salt_management')" title="View Json History"></i>
			<? } ?>
	  
	  <? } ?></h4>
    <div class="vkg-main-border"></div>
  </div>
  
    <div class="row rounded p-1">
	
  
      <div class="col-sm-6 ps-0">
        <label for="Acquirer ID" class="form-label">Salt Title:</label>
          <input type="text" class="form-control" name="salt_name" id="salt_name"   placeholder="Enter Salt Title"  value="<? if(isset($post['salt_name'])) echo $post['salt_name'];?>" required>
        </div>
      <div class="col-sm-6 ps-0">
        <label for="Acquirer ID" class="form-label">Note/Comments:</label>
          <input type="text" id="mustHaveId"  name="comments"  class="form-control" placeholder="Enter Note/Comments" value="<? if(isset($post['comments'])) echo  $post['comments'];?>" required>
      </div>
      <div class="col-sm-12 ps-0">
        <label for="Acquirer ID" class="form-label">Acquirer:</label> 
          <select id="tid" data-placeholder="Start typing the acquirer ID " multiple class="chosen-select form-control" name="tid[]" onchange='checkAvailability(<?=(isset($post['gid'])&&$post['gid']?$postgid:'0');?>,"new")' style="clear:right;width:83%;" >
            <?//=showselectsalt($data['tid'], $post['tid'],1)?>
            <?=showselect($data['tid'], (isset($post['tid'])?$post['tid']:0),1)?>
          </select>
          
<? if(isset($post['gid'])&&$post['gid']){ ?>
<script type="text/javascript">
window.onload = function() {
checkAvailability(<?=($post['gid']?$postgid:'0');?>,"edit");
};
</script>
<? } ?>
<script>
$(".chosen-select").chosen({
no_results_text: "Oops, nothing found!"
});
</script>
<script>
$("#tid_chosen").css("width", "100%");
$("#tid_chosen").addClass("bg-vlight99 form-control");
//$("#tid_chosen").addClass("form-control");
</script>
      </div>
      <!--============================Work Area==================-->
      <div><span id="user-availability-status"></span></div>
      <p id="loaderIcon" style="display:none"><i class="fa-solid fa-spinner fa-spin-pulse fa-2x text-loader"></i></p>
      <!--========================================================-->
      <div class="text-center row p-0">
        <div class="col-sm-12 my-2 ps-0 remove-link-css">
          <button formnovalidate type="submit" name="send" value="CONTINUE"  onclick="return checkvalidation()" class="btn btn-icon btn-primary "><i class="<?=$data['fwicon']['check-circle'];?>"></i> Submit</button>
         <a href="<?=$data['Admins']?>/<?=$data['PageFile']?><?=$data['ex']?>" class="btn btn-icon btn-primary "><i class="<?=$data['fwicon']['back'];?>"></i> Back</a> </div>
      </div>
    </div>
    <? } ?>
  </form>
  <style>
#frmCheckUsername {border-top:#F0F0F0 2px solid;background:#FAF8F8;padding:10px;}
.demoInputBox{padding:7px; border:#F0F0F0 1px solid; border-radius:4px;}
.status-available{color:#2FC332;}
.status-not-available{color:#D60202;}
</style>
  <!--/////////////Js for Array//////////////////////////////-->
</div>

<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
