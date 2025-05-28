<? if(isset($data['ScriptLoaded'])){ ?>
<?
if((!isset($_SESSION['login_adm']))&&((!isset($_SESSION['transaction_reason']))||(isset($_SESSION['transaction_reason'])&&$_SESSION['transaction_reason']==0))){
?>
<div class="alert alert-danger alert-dismissible fade show m-2 text-center" role="alert">
  <strong>Access Denied</strong> 
  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<?
	exit;
}
?>

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
        
    });*/
    
});
</script>

<style>

#chosenv .chosen-single{
height: 34px !important;
}
#chosenv .chosen-container-single .chosen-single {
color: #000 !important;
line-height: 30px !important;
background-color: #fff !important;
background: #fff !important;
border: 1px solid #ced4da !important;
}
#chosenv .chosen-container-single .chosen-single div b {
background: url() no-repeat 0 2px !important;
}

</style>
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
	<div class="container vkg px-0">
        <div class="vkg-main-border"></div>
      </div>
	
    <div class="container px-1" style="padding-left: 0px !important;">
		<div class="row my-2" id="trans_reson_css">
		<div class="col-sm-3 px-0 vkg"><h4 class="my-1"><i class="<?=$data['fwicon']['reason'];?>"></i> Reason of Transaction <a data-ihref="<?=$data['Admins']?>/json_log_all<?=$data['ex']?>?tablename=reason_table" title="View Json Log History" onclick="iframe_open_modal(this);"><i class="<?=$data['fwicon']['circle-info'];?> text-danger fa-fw"></i></a></h4></div>
			<div class="col-sm-6 px-0">
			
				<div class="row col-sm-12">
				  <div class="col-sm-5">
					<input type="text" name="key" class="search_textbx form-control  my-1" placeholder="Search.."  value="<? if(isset($post['key'])&&$post['key']) echo prntext($post['key']);?>" onclick="return false;" autocomplete="off">
				  </div>
				  <div class="col-sm-5">
					<select name="key_name" id="searchkeyname" title="Select key name" class="filter_option form-select  my-1" autocomplete="off">
					  <option value="" selected="selected">Select</option>
					  <option value="category" data-placeholder="Category" title="Category">Category</option>
					  <option value="status_nm" data-placeholder="Status" title="Status">Status</option>
					  <option value="reason" data-placeholder="Reason" title="Reason">Reasons</option>
					  <option value="new_reasons" data-placeholder="New Reasons" title="New Reasons">New Reasons</option>
					  <option value="id" data-placeholder="Table ID" title="Table ID">ID</option>
					</select>
				  </div>
				  <div class="col-sm-2">
					<button type="submit" name="simple_search" value="filter" class="simple_search btn btn-primary  my-1"><i class="<?=$data['fwicon']['search'];?>"></i></button>
				  </div>
				</div>
				
				<?
				if(isset($post['key_name'])&&$post['key_name'])
				{?>
				<script> 
					$('#searchkeyname option[value="<?=prntext($post['key_name']);?>"]').prop('selected','selected'); 
				</script>
				
				<?
				}?>
			</div>
			
			
			
			<div class="col-sm-3 ps-0 text-end pe-0">
			<span class="btn btn-primary">Total : <?=$data['total_record']?></span>
			  <button type="submit" name="send" value="add_data" class="btn btn-primary my-1" title="Add New"><i class="<?=$data['fwicon']['circle-plus'];?>"></i></button>
			</div>
		</div>
    </div>
    <div class="container table-responsive-sm">
	  <? if(count($post['result_list'])!=0){ ?>
      <table class="table table-hover">
        <thead>
          <tr>
		    <th scope="col">#</th>
            <th scope="col"><a href="<?=$data['Admins']?>/<?=$data['PageFile']?><?=$data['ex']?>?m=<?=$data['m']?>&s=id">ID</a></th>
            <th scope="col"><a href="<?=$data['Admins']?>/<?=$data['PageFile']?><?=$data['ex']?>?m=<?=$data['m']?>&s=category">Category</a></th>
            <th scope="col"><a href="<?=$data['Admins']?>/<?=$data['PageFile']?><?=$data['ex']?>?m=<?=$data['m']?>&s=status_nm">Status</a></th>
            <th  scope="col"><a href="<?=$data['Admins']?>/<?=$data['PageFile']?><?=$data['ex']?>?m=<?=$data['m']?>&s=reason">Reasons</a></th>
            <th  scope="col"><a href="<?=$data['Admins']?>/<?=$data['PageFile']?><?=$data['ex']?>?m=<?=$data['m']?>&s=new_reasons">New Reasons</a></th>
            <th  scope="col">Action</th>
          </tr>
        </thead>
        <? $j=(($data['startPage']-1)*$data['MaxRowsByPage']); 
		
		foreach($post['result_list'] as $key=>$value) {
		?>
        <tr>
		<td><a data-bs-toggle="modal" data-count="<?=prntext($value['id'])?>" class="tr_open_on_modal text-decoration-none" data-bs-target="#myModal"><i class="<?=$data['fwicon']['display'];?> text-link" title="View details"></i></a></td>
         <td><? if(isset($value['id'])&&$value['id']) echo $value['id'];else echo "";?></td>
         <td><? if(isset($value['category'])&&$value['category']) echo $value['category'];else echo "";?></td>
         <td><?=$value['status_nm'];?> - <?=$value['status'];?></td>
         <td title="<?=$value['reason'];?>" data-bs-toggle="tooltip" data-bs-placement="top"><span class="d-inline-block text-truncate" style="max-width: 150px;" ><?=$value['reason'];?></span></td>
         <td title="<?=$value['new_reasons'];?>" data-bs-toggle="tooltip" data-bs-placement="top"><span class="d-inline-block text-truncate" style="max-width: 150px;" ><?=$value['new_reasons'];?></span></td>
         <td>
		 
		 <div class="btn-group dropstart short-menu-auto-main"> <a data-bs-toggle="dropdown" aria-expanded="false"  title="Action"><i class="<?=$data['fwicon']['action'];?> text-link"></i></a>
                <ul class="dropdown-menu dropdown-menu-icon pull-right" >
				
                  <li> <a class="dropdown-item" href="<?=$data['Admins'];?>/transaction_reason<?=$data['ex']?>?id=<?=$value['id'];?>&send=add_data&page=<?=(isset($post['StartPage'])?$post['StartPage']:'')?>" title="Edit" ><i class="<?=$data['fwicon']['edit'];?> text-success float-start"></i> <span class="action_menu">Edit</span></a></li>
                  
                  <li> <a class="dropdown-item"  href="<?=$data['Admins'];?>/transaction_reason<?=$data['ex']?>?id=<?=$value['id'];?>&action=delete_reasontrs&page=<?=(isset($post['StartPage'])?$post['StartPage']:'')?>" title="Delete"><i class="<?=$data['fwicon']['delete'];?> text-danger float-start"></i> <span class="action_menu">Delete</span></a></li>
			    <? if(isset($value['json_log_history'])&&$value['json_log_history']){?>
<li>			  
<a class="dropdown-item" onclick="popup_openv('<?=$data['Host']?>/include/json_log<?=$data['ex']?>?tableid=<?=$value['id'];?>&tablename=reason_table')" title="View Json History"><i class="<?=$data['fwicon']['circle-info'];?> text-info float-start"></i>  <span class="action_menu">Json History</span></a>
</li>
			    <? } ?>

                </ul>
              </div>
			  
			  

			
          </td>
        </tr>
		
		<tr class="hide">
     <td colspan="7">
	 <div class="next_tr_<?=prntext($value['id']);?> hide row">
	 <div class="mboxtitle hide">Reason of Transaction : <?=$value['id'];?></div>
	     <div class="col-sm-12 border rounded mb-2">
	            <div class="row m-2">
				<div class="col-sm-3">Category </div>
				<div class="col-sm-9">: <? if(isset($value['category'])&&$value['category']) echo $value['category'];else echo "";?></div>
			    </div>
				
				<div class="row m-2">
				<div class="col-sm-3">Status </div>
				<div class="col-sm-9">: <?=$value['status_nm'];?> - <?=$value['status'];?></div>
			    </div>
				
				<div class="row m-2">
				<div class="col-sm-3">	Reasons </div>
				<div class="col-sm-9">: <?=$value['reason'];?></div>
			    </div>
				
				<div class="row m-2">
				<div class="col-sm-3">	New Reasons </div>
				<div class="col-sm-9">: <?=$value['new_reasons'];?></div>
			    </div>
	     </div>
	   </div>
	 
	 
	 </td>
	 </tr>
        
        <?
		}?>
      </table>
	 
	  
	  <?
			if(isset($data['total_record'])&&$data['total_record']) $total = $data['total_record'];
			else $total = 0;
			if(isset($_REQUEST['page']))unset($_REQUEST['page']);
			
			$get=http_build_query($_REQUEST);
			
			$url="transaction_reason".$data['iex'];

			if($get) $url.='?'.$get;
			include("../include/pagination_new".$data['iex']);
			pagination_new($data['MaxRowsByPage'],$data['startPage'],$url,$total);
			?>
			
			 <? }else{ ?><div class="alert alert-danger text-center fw-bold" role="alert">No Records Found</div><? } ?>
	     
  

	  
    </div>
    <? }elseif($post['step']==2){ ?>
    <? if(isset($post['gid'])&&$post['gid']){?>
    <input type="hidden" name="gid" value="<?=$post['gid']?>">
    <input type="hidden" name="id" value="<?=$post['id']?>">
    <input type="hidden" name="action" value="insert_reasontr">
    <? }else{ ?>
    <input type="hidden" name="action" value="insert_reasontr">
	<input type="hidden" name="source" value="admin">
    <? }?>
    <script>document.write('<input type=hidden name=aurl value="'+top.window.document.location.href+'">');</script>
    <div class="row ">
      <div class="container vkg px-0 ">
		    <h4 class="my-2"><? if(isset($post['gid'])&&$post['gid']){ ?> <i class="<?=$data['fwicon']['edit'];?>"></i> Edit <? } else { ?> <i class="<?=$data['fwicon']['circle-plus'];?>"></i> Add New <? } ?> Reason of Transaction <? if(isset($post['gid'])&&$post['gid']){ ?><? if(isset($post['json_log_history'])&&$post['json_log_history']){?>
			<i class="<?=$data['fwicon']['circle-info'];?> text-info fa-fw" 
			onclick="popup_openv('<?=$data['Host']?>/include/json_log<?=$data['ex']?>?tableid=<?=$post['id'];?>&tablename=reason_table')" title="View Json History"></i>
			<? } ?> <? } ?></h4>
		  
      </div>
	  <? if(isset($data['error'])&&$data['error']<>""){ ?>
	<div class="col-sm-12 ps-0">
	<div class="alert alert-danger my-2" role="alert"><strong><?=$data['error'];?></strong></div>
    </div>
	<? } ?>
	<div class="row p-1 rounded mb-2">	
	  <div class="col-sm-3 ps-0" id="chosenv">
        <label for="category" class="form-label mt-2">Category:</label>
<select id="category" data-placeholder="Category" title="Category" class="chosen-select filter_option inherit_select_classes1 form-control" name="category" >
				<option value="Technical">Technical</option>
				<option value="Risk">Risk</option>
				<option value="Rejected">Rejected</option>
				<option value="Technical Test">Technical Test</option>
				</select>    
				<? if(isset($post['category'])&&$post['category']<>""){ ?>
          <script>$('#category option[value="<?=prntext($post['category'])?>"]').prop('selected','selected');</script>
		  <? }?>  
				</div>
					
      <div class="col-sm-3 ps-0">
        <label for="status_nm" class="form-label mt-2">Status:<i class="<?=$data['fwicon']['star'];?>  text-danger"></i></label>
        <select name="status_nm" id="status_nm" required="" autocomplete="off" class="form-select" title="Type" >
          <option value="">Select Status</option>
          
         <?
		  foreach($data['TransactionStatus'] as $k1=>$v1){
			 echo "<option value='{$k1}'>{$v1}</option>"; 
		  }
		 ?>
        </select>
		<? if(isset($post['status_nm'])&&$post['status_nm']<>""){ ?>
          <script>$('#status_nm option[value="<?=prntext($post['status_nm'])?>"]').prop('selected','selected');</script>
		  <? }?>
      </div>
	  
	  <div class="col-sm-3 ps-0">
        <label for="reason" class="form-label mt-2">Reason:<i class="<?=$data['fwicon']['star'];?>  text-danger"></i></label>
     
	  <textarea class="textAreaAdjust w-100 form-control" name="reason" id="reason" style="<?=$display_salt;?>; height:30px !important;"><? if(isset($post['reason'])) echo  $post['reason'];?></textarea>

      </div>
      
      <div class="col-sm-3 ps-0">
        <label for="new_reasons" class="form-label mt-2">New Reason:</label>
      
	  
	    <textarea class="textAreaAdjust w-100 form-control" name="new_reasons" id="new_reasons" style="<?=$display_salt;?>; height:30px !important;"><? if(isset($post['new_reasons'])) echo  $post['new_reasons'];?></textarea>
      </div>
	  
      <div class="my-2 text-center row p-0">
        <div class="col-sm-12 my-2 ps-0 remove-link-css text-center">
          <button formnovalidate type="submit" name="send" value="CONTINUE"  class="btn btn-icon btn-primary"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Submit</button>
         <a href="<?=$data['Admins']?>/<?=$data['PageFile']?><?=$data['ex']?>" class="btn btn-icon btn-primary"><i class="<?=$data['fwicon']['back'];?>"></i> Back</a> </div>
      </div>
	 </div> 
    </div>
    <? }?>
  </form>
</div>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? }?>
