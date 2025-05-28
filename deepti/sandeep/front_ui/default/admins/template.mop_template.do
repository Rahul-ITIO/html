<? if(isset($data['ScriptLoaded'])){?>
<div class="container border vkg my-1 rounded">
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
	
}
</script>
  <script type="text/javascript">
function checkvalidation(){
	if (document.getElementById("mop_name").value.trim() == "") {
		document.getElementById("mop_name").focus();
		alert("Please Enter Name!");
		return false;
	}
			
	if (document.getElementById("mustHaveId").value.trim() == "") {
		document.getElementById("mustHaveId").focus();
		alert("Please Enter Comment!");
		return false;
	}
	if (document.getElementById("mop_code").value.trim() == "") {
		document.getElementById("mop_code").focus();
		alert("Please Select Aquirer ID!");
		return false;
	}
}
</script>
  <form method="post" name="data"  >
    <input type="hidden" name="step" value="<?=$post['step']?>">
    
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
<h4 class="my-2"><i class="<?=$data['fwicon']['money-check-dollar'];?>"></i> MOP Template (Mode of Payment) <a data-ihref="<?=$data['Admins']?>/json_log_all<?=$data['ex']?>?tablename=mop_table&mode=json_log" title="View Json Log History" onclick="iframe_open_modal(this);"><i class="fa-solid <?=$data['fwicon']['circle-info'];?> text-danger fa-fw"></i></a></h4>
</div>

      <div class="col-sm-4 my-2 ps-0">
        <select name="mop_filter" id="mop_filter" class="select_cs_21 form-select me-2 float-start" autocomplete="off" style="width: calc(100% - 50px);">
          <option value="Active" title="Show Data List of Active Only" >Active</option>
          <option value="deletedlist" title="Show Data List of Deleted Only" >Deleted</option>
          <option value="all" title="Show Data List of Active and Deleted" selected="selected">All</option>
        </select>
        <script>
			$('#mop_filter option[value="<?=($post['action'])?>"]').prop("selected", "selected");
		</script>
      
        <button type="submit" name="send" value="Add A New MOP!" title="Add A New MOP"  class="btn btn-primary"  style="width:40px"><i></i><i class="<?=$data['fwicon']['circle-plus'];?>"></i></button>
      </div>
    </div>
    <? } ?>
    <div class="container table-responsive">
      <table class="table table-hover">
        <thead>
          <tr>
            <th scope="col">MOP Name</th>
            <th scope="col">MOP Symbol</th>
            <th scope="col">Type</th>
            <th scope="col">Comments</th>
            <th scope="col">Action</th>
          </tr>
        </thead>
    <? 
	foreach($post['result_list'] as $key=>$value) {
		if($value['mop_type']==1) $mop_type='fa bootstrap icon';
		elseif($value['mop_type']==2) $mop_type='Image Name';
	?>
        <tr valign="top" class="rounded">
          <td><?=$value['mop_name'];?></td>

          <td>
			<span class="btn btn-abv-search text-start"><?=str_replace(['images8','bank8'],'bank',$value['assign_id']);?></span>   
			       
		  </td>

          <td><?=$mop_type;?></td>
          <td><?=$value['comments']?></td>
          <td>
		  
		  <div class="btn-group dropstart short-menu-auto-main"> <a data-bs-toggle="dropdown" aria-expanded="false"  title="Action"><i class="<?=$data['fwicon']['action'];?> text-link"></i></a>
                <ul class="dropdown-menu dropdown-menu-icon pull-right" >
				
                  <li> <a class="dropdown-item" href="<?=$data['Admins'];?>/<?=$data['PageFile']?><?=$data['ex']?>?id=<?=$value['id']?>&action=update"><i class="<?=$data['fwicon']['edit'];?> text-success float-start"></i> <span class="action_menu">Edit</span></a></a></li>

                  <li> <a class="dropdown-item"  href="<?=$data['Admins'];?>/<?=$data['PageFile']?><?=$data['ex']?>?id=<?=$value['id']?>&action=delete" onclick="return confirm('Are you Sure to Delete');" title="Delete"><i class="<?=$data['fwicon']['delete'];?> text-danger float-start"></i> <span class="action_menu">Delete</span></a></li>
				  
					<? if(isset($value['json_log_history'])&&$value['json_log_history']){?>
					<li> 
					<i class="<?=$data['fwicon']['circle-info'];?> text-info fa-fw" 
					onclick="popup_openv('<?=$data['Host']?>/include/json_log<?=$data['ex']?>?tableid=<?=$value['id'];?>&tablename=mop_table')" title="View Json History"></i>
					</li>
					<? } ?>

                </ul>
              </div>
			  
			 </td>
        </tr>
        
        <? } ?>
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
   	
	<div class=" container vkg px-0">
	
    <h4 class="my-2"><i class="<?=$data['fwicon']['money-check-dollar'];?>"></i> <?php if(isset($post['gid'])&&$post['gid']){ ?> Edit <? } else { ?> Add New <? } ?> MOP (Mode of Payment) <?php if(isset($post['gid'])&&$post['gid']){ ?> 
	<? if(isset($post['json_log_history'])&&$post['json_log_history']){?>
			<i class="<?=$data['fwicon']['circle-info'];?> text-info fa-fw" 
			onclick="popup_openv('<?=$data['Host']?>/include/json_log<?=$data['ex']?>?tableid=<?=$post['id'];?>&tablename=mop_table')" title="View Json History"></i>
			<? } ?>
	 <? } ?></h4>
    <div class="vkg-main-border"></div>
  </div>

    <div class="row bg-vlight p-1 rounded">
	  <div class="col-sm-3 ps-0">
        <label for="Acquirer ID" class="form-label">MOP Name:</label>
          <input type="text" class="form-control" placeholder="Enter MOP Name" name="mop_name" id="mop_name" value="<? if(isset($post['mop_name'])) echo $post['mop_name'];?>" required>
        </div>
		
	<div class="col-sm-3 ps-0">
	<?
	//$data['mop_codes']=["7995"=>"7995","4899"=>"4899","5967"=>"5967"];
	$data['mop_codes']=[];
	$mop_code_ex=explode(",",@$post['mop_code']);
	foreach($mop_code_ex as $k=>$v){
		if(!in_array($v,$data['mop_codes'])) $data['mop_codes'][$v]=$v;
	}
	
	?>
        <label for="mop_code" class="form-label w-100">MOP Symbol/Class Name/Image Name :</label> 
          <select id="mop_code" data-placeholder="Start typing the MOP Symbols " multiple class="chosen-select form-control" name="mop_code[]" style="clear:right;width:100%;" >
            <?//=showselect($data['mop_codes'], (isset($post['mop_code'])?$post['mop_code']:0),1)?>
			<optgroup label="FA-ICON">
			<?//=chosen_icon_f(1, $data['mop_codes']);?>
			
			<? foreach($data['fwicon'] as $ic9k => $ic9){if(stf($ic9)){?>
			<option title='<?=stf($ic9)?>' value='<?=stf($ic9)?>'><?=stf($ic9)?> </option><? }} ?>
			</optgroup>
			<optgroup label="MOP-IMG">
			<?//=chosen_icon_f(1, $data['mop_codes']);?>
			
			<? foreach($data['url-image'] as $ic9k => $ic9){if(stf($ic9)){?>
			<option title='<?=stf($ic9)?>' value='<?=stf($ic9)?>'><?=stf($ic9)?> </option><? }} ?>
			</optgroup>
			
			<optgroup label="IMG">
			<?//=chosen_icon_f(2, $data['mop_codes']);?>
			<?
				//$iconsList = glob($data['Path'].'/images/icons/*');
				$iconsList = $data['iconsList'];
				foreach($iconsList as $img_Name){
					$imgname=str_replace(['../images/icons/','../bank/','../bank/'],'',$img_Name);
					
					echo "<option title='{$img_Name}' value='{$imgname}'>{$imgname}</option>"; 
				}
			?>
			</optgroup>
          </select>
          
<script>

<?
$mop_name_ex=explode(",",@$post['mop_code']);
if(isset($mop_name_ex)&&$mop_name_ex){?>
	chosen_more_value_f("mop_code",[<?=('"'.implodes('", "',$mop_name_ex).'"');?>]);
<? } ?>
			
$("#mop_code_chosen").css("width", "100%").css("background", "#ffffff");
//$("#mop_code_chosen").addClass("form-control");
</script>
      </div>
	  
	 <div class="col-sm-3 ps-0 hide">
	  <label for="mop_type" class="form-label w-100">MOP Type :</label> 
          <select id="mop_type" name="mop_type" class="form-control" placeholder="Enter MOP Name" style="clear:right;" >
           <option value='1'>fa bootstrap icon</option>
           <option value='2'>Image Name</option>
          </select>
          
		<script>
		//$("#mop_type").css("width", "100%").css("background", "#ffffff");
		//$("#mop_code_chosen").addClass("form-control");
		$('#mop_type option[value="<?=(isset($post['mop_type'])?$post['mop_type']:'')?>"]').prop('selected','selected');
		</script>
      </div>
	  
    
      <div class="col-sm-3 ps-0">
        <label for="comments" class="form-label">Note/Comments:</label>
          <input type="text" id="mustHaveId"  name="comments"  class="form-control" placeholder="Enter Note/Comments" value="<? if(isset($post['comments'])) echo  $post['comments'];?>" required>
      </div>
      
      <!--============================Work Area==================-->
      <div><span id="user-availability-status"></span></div>
      <p><img src="LoaderIcon.gif" id="loaderIcon" style="display:none" /></p>
      <!--========================================================-->
      <div class="text-center row ">
        <div class="col-sm-12 my-2  m_role text-center">
          <button formnovalidate type="submit" name="send" value="CONTINUE"  onclick="return checkvalidation()" class="btn btn-icon btn-primary"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Submit</button>
       <a href="<?=$data['Admins']?>/<?=$data['PageFile']?><?=$data['ex']?>" class="btn btn-icon btn-primary"><i class="<?=$data['fwicon']['back'];?>"></i> Back</a> </div>
      </div>
    </div>
    <? } ?>
  </form>

  <!--/////////////Js for Array//////////////////////////////-->
</div>

<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
