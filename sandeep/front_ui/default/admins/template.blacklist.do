<? if(isset($data['ScriptLoaded'])){ ?>



<div class="container border my-1 rounded">
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

    <div class="container text-end px-0 vkg">
	<form method="post" name="data">
	  <h4 class="my-2 float-start"><i class="<?=$data['fwicon']['ban'];?>"></i> Black List</h4>
      <button type="submit" name="send" value="add_data" class="btn btn-primary float-end my-2 " title="Add A New Black List"><i></i><i class="<?=$data['fwicon']['circle-plus'];?>"></i></button>
	  </form>
    </div>
    <div class="container table-responsive-sm">
      <table class="table table-hover">
        <thead>
          <tr>
            <th scope="col">#</th>
            <th scope="col">Merchant</th>
            <th scope="col">Type</th>
            <th scope="col">Blacklist Value</th>
            <th scope="col">Remark</th>
            <th scope="col">Action</th>
          </tr>
        </thead>
        <? $j=1; 
		foreach($post['result_list'] as $key=>$value) {
		?>
        <tr valign="top">
          <td title="S#" data-label="S# - "><a data-bs-toggle="modal" data-count="<?=prntext($value['id'])?>" class="tr_open_on_modal text-decoration-none" data-bs-target="#myModal"><i class="<?=$data['fwicon']['display'];?> text-link" title="View details"></i></a></td>
          <td title="Merchant" data-label="Merchant" class="text-wrap"><? if(isset($value['clientid'])&&$value['clientid']) echo $value['clientid'];else echo "Common";?></td>
          <td title="Type" data-label="Type - "  nowrap><?=$value['blacklist_type'];?></td>
          <td title="Blacklist Value" data-label="Blacklist Value - " class="text-wrap" nowrap><?=$value['blacklist_value'];?></td>
          <td title="Remarks" data-label="Remarks - " class="text-wrap"  nowrap ><?=$value['remarks'];?></td>
          <td data-label="Action - " nowrap>
            <? if($value['status']==1)
			{
			?>
			
			<a href="<?=$data['Admins'];?>/blacklist<?=$data['ex']?>?bid=<?=$value['id'];?>&id=<?=isset($post['MemberInfo']['id'])&&$post['MemberInfo']['id']?$post['MemberInfo']['id']:''?>&action=delete_blkdatas&type=<?=(isset($post['type'])?$post['type']:'');?>&page=<?=(isset($post['StartPage'])?$post['StartPage']:'')?>" onclick="return cfmform()" class="<?=$data['fwicon']['delete'];?> text-danger fa-fw" title="Delete"><i></i></a>
			<?
			}
			else
			{
			?>
	<i class="<?=$data['fwicon']['pause'];?> text-danger fa-fw" title="Deleted" onclick="return confirm('Already Deleted')"></i>
			 <? } ?>
			<? if(isset($value['json_log_history'])&&$value['json_log_history']){?>
			<i class="<?=$data['fwicon']['circle-info'];?> text-info fa-fw" 
			onclick="popup_openv('<?=$data['Host']?>/include/json_log<?=$data['ex']?>?tableid=<?=$value['id'];?>&tablename=blacklist_data')" title="View Json History"></i>
			<? } ?>
          </td>
        </tr>
		
		<tr class="hide">
     <td colspan="8">
	<div class="next_tr_<?=prntext($value['id']);?> hide row">
	<div class="mboxtitle hide">Black List Detail : <?=$value['id'];?> - <?=prntext($value['blacklist_type']);?></div>
	<div class="col-sm-12 border rounded mb-2">
		 
		        <div class="row m-2">
				<div class="col-sm-3">Merchant </div>
				<div class="col-sm-9">: <? if(isset($value['clientid'])&&$value['clientid']) echo $value['clientid'];else echo "Common";?>                </div>
			    </div>
				
			    <div class="row m-2">
				<div class="col-sm-3">Type </div>
				<div class="col-sm-9">: <?=$value['blacklist_type'];?></div>
			    </div>

                <div class="row m-2">
				<div class="col-sm-3">Value </div>
				<div class="col-sm-9">: <?=$value['blacklist_value'];?></div>
                </div>
		
                <div class="row m-2">
				<div class="col-sm-3">Remark</div>
				<div class="col-sm-9 ">: <?=$value['remarks'];?></div>
				</div>
		

     </div>
    </div>
			 
    
		  </td>
        </tr>
        
        <? $j++; }?>
      </table>
	  <?
			$url="blacklist".$data['iex'];
			if(isset($data['total_record'])&&$data['total_record']) $total = $data['total_record'];
			else $total = 0;
			include("../include/pagination_new".$data['iex']);
			?>
			<? pagination_new($data['MaxRowsByPage'],$data['startPage'],$url,$total);?>
    </div>
    <? }elseif($post['step']==2){ ?>
	<form method="post" name="data">
    <? if(isset($post['gid'])&&$post['gid']){?>
	
    <input type="hidden" name="step" value="<?=$post['step']?>">
    <input type="hidden" name="gid" value="<?=$post['gid']?>">
    <input type="hidden" name="id" value="<?=$post['id']?>">
    <input type="hidden" name="action" value="update_db">
    <? }else{ ?>
    <input type="hidden" name="action" value="insert_blkdata">
	<input type="hidden" name="source" value="admin">
    <? }?>
    <script>document.write('<input type=hidden name=aurl value="'+top.window.document.location.href+'">');</script>
    <div class="row">
      <div class="container vkg px-0">
        <h4 class="my-2"><i class="<?=$data['fwicon']['calculator'];?>"></i> <? if(isset($post['gid'])&&$post['gid']){?> Edit <? } else { ?> Add New <? } ?> Black List</h4>
        <div class="vkg-main-border"></div>
      </div>
	  <?php if(!empty($data['error'])){ ?>
	<div class="col-sm-12 ps-0">
	<div class="alert alert-danger my-2" role="alert"><strong><?php echo $data['error'];?></strong></div>
    </div>
	<? } ?>

      <div class="col-sm-4 ps-0">
        <label for="Type" class="form-label mt-2">Type: <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></label>
        <select name="blacklist_type" id="blacklist_type" required="" autocomplete="off" class="form-select" title="Select blacklist type" data-bs-toggle="tooltip" data-bs-placement="bottom" >
          <option value="">Select Type</option>
          <option value="IP">IP</option>
          <option value="Country">Country</option>
          <option value="City">City</option>
          <option value="Email">Email</option>
          <option value="Card Number">Card No.</option>
          <option value="VPA">VPA</option>
          <option value="Mobile">Phone</option>
        </select>
		<?php if(isset($post['blacklist_type'])&&$post['blacklist_type']<>""){ ?>
          <script>$('#blacklist_type option[value="<?=prntext($post['blacklist_type'])?>"]').prop('selected','selected');</script>
		  <? }?>
      </div>
	  
	  <div class="col-sm-4 ps-0">
        <label for="Blacklist Value" class="form-label mt-2">Blacklist Value: <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></label>
      <input type="text" name="blacklist_value" placeholder="Blacklist Value" class="form-control" value="<? if(isset($post['blacklist_value'])) echo  $post['blacklist_value'];?>" title="Enter your blacklist value" data-bs-toggle="tooltip" data-bs-placement="bottom"  required />
      </div>
      
      <div class="col-sm-4 ps-0">
        <label for="Remark" class="form-label mt-2">Remark:</label>
       <input type="text" name="remarks" placeholder="Remark" class="form-control" value="<? if(isset($post['remarks'])) echo  $post['remarks'];?>" title="Enter your remark why blacklist value" data-bs-toggle="tooltip" data-bs-placement="bottom"  required />
      </div>
	  
	  
	  
	  <div class="col-sm-12 ps-0">
        <label for="Remark" class="form-label mt-2 w-100">Merchant List:</label>
<select id="merchant_list_id" data-placeholder="[MID] Username | M. Name" title="[MID] Username | M. Name" multiple class="chosen-select filter_option inherit_select_classes1 form-control" name="merchant_list_id[]" >
				  <?=showselect(((isset($_SESSION['merchant_details'])&&$_SESSION['merchant_details'])?$_SESSION['merchant_details']:''), ((isset($_REQUEST['merchant_details'])&&$_REQUEST['merchant_details'])?$_REQUEST['merchant_details']:''));?>
				</select>      
				</div>
	  
	  
      <div class="my-2 text-center row p-0">
        <div class="col-sm-12 my-2 ps-0 text-center remove-link-css">
          <button formnovalidate type="submit" name="send" value="CONTINUE"  class="btn btn-icon btn-primary"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Submit</button>
         <a href="<?=$data['Admins']?>/<?=$data['PageFile']?><?=$data['ex']?>" class="btn btn-icon btn-primary"><i class="<?=$data['fwicon']['back'];?>"></i> Back</a> </div>
      </div>
    </div>
	</form>
    <? }?>
  
</div>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? }?>
