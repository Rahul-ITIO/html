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
	if (document.getElementById("category_name").value.trim() == "") {
		document.getElementById("category_name").focus();
		alert("Please Enter Name!");
		return false;
	}
			
	if (document.getElementById("mustHaveId").value.trim() == "") {
		document.getElementById("mustHaveId").focus();
		alert("Please Enter Comment!");
		return false;
	}
	if (document.getElementById("mcc_code").value.trim() == "") {
		document.getElementById("mcc_code").focus();
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
<h4 class="my-2"><i class="<?=$data['fwicon']['merchant-category'];?>"></i> Merchant Category <a data-ihref="<?=$data['Admins']?>/json_log_all<?=$data['ex']?>?tablename=merchant_category&mode=json_log" title="View Json Log History" onclick="iframe_open_modal(this);"><i class="fa-solid <?=$data['fwicon']['circle-info'];?> text-danger fa-fw"></i></a></h4>
</div>

      <div class="col-sm-4 my-2 ps-0">
        <select name="category_filter" id="category_filter" class="select_cs_21 form-select me-2 float-start" autocomplete="off" style="width: calc(100% - 50px);">
          <option value="Active" title="Show Data List of Active Only" >Active</option>
          <option value="deletedlist" title="Show Data List of Deleted Only" >Deleted</option>
          <option value="all" title="Show Data List of Active and Deleted" selected="selected">All</option>
        </select>
        <script>
			$('#category_filter option[value="<?=($post['action'])?>"]').prop("selected", "selected");
		</script>
      
        <button type="submit" name="send" value="Add A New Category!" title="Add A New Category"  class="btn btn-primary"  style="width:40px"><i></i><i class="<?=$data['fwicon']['circle-plus'];?>"></i></button>
      </div>
    </div>
    <? } ?>
    <div class="container table-responsive">
      <table class="table table-hover">
        <thead>
          <tr>
            <th scope="col">Category Name</th>
            <th scope="col">MCC Code</th>
            <th scope="col">Comments</th>
            <th scope="col">Action</th>
          </tr>
        </thead>
    <? 
	foreach($post['result_list'] as $key=>$value) {
	?>
        <tr valign="top" class="rounded">
          <td><?=$value['category_name'];?></td>

          <td><span class="btn btn-abv-search"><?=$value['assign_id'];?></span>          </td>

          <td><?=$value['comments'];?></td>
          <td>
		  
		  <div class="btn-group dropstart short-menu-auto-main"> <a data-bs-toggle="dropdown" aria-expanded="false"  title="Action"><i class="<?=$data['fwicon']['action'];?> text-link"></i></a>
                <ul class="dropdown-menu dropdown-menu-icon pull-right" >
				
                  <li> <a class="dropdown-item" href="<?=$data['Admins'];?>/<?=$data['PageFile']?><?=$data['ex']?>?id=<?=$value['id']?>&action=update" title="Edit"><i class="<?=$data['fwicon']['edit'];?> text-success fa-fw float-start"></i> <span class="action_menu">Edit</span></a></li>

                  <li> <a class="dropdown-item"  href="<?=$data['Admins'];?>/<?=$data['PageFile']?><?=$data['ex']?>?id=<?=$value['id']?>&action=delete" onclick="return confirm('Are you Sure to Delete');" title="Delete"><i class="<?=$data['fwicon']['delete'];?> text-danger fa-fw float-start"></i> <span class="action_menu">Delete</span></a></li>
				  
					<? if(isset($value['json_log_history'])&&$value['json_log_history']){?>
					<li> 
					<i class="<?=$data['fwicon']['circle-info'];?> text-info fa-fw float-start  mx-1" 
					onclick="popup_openv('<?=$data['Host']?>/include/json_log<?=$data['ex']?>?tableid=<?=$value['id'];?>&tablename=merchant_category')" title="View Json History"></i>
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
	
    <h4 class="my-2"><i class="<?=$data['fwicon']['recentorder'];?>"></i> <?php if(isset($post['gid'])&&$post['gid']){ ?> Edit <? } else { ?> Add New <? } ?> Merchant Category <?php if(isset($post['gid'])&&$post['gid']){ ?> 
	<? if(isset($post['json_log_history'])&&$post['json_log_history']){?>
			<i class="<?=$data['fwicon']['circle-info'];?> text-info fa-fw" 
			onclick="popup_openv('<?=$data['Host']?>/include/json_log<?=$data['ex']?>?tableid=<?=$post['id'];?>&tablename=merchant_category')" title="View Json History"></i>
			<? } ?>
	 <? } ?></h4>
    <div class="vkg-main-border"></div>
  </div>

    <div class="row  p-1 rounded">
	  <div class="col-sm-4 ps-0">
        <label for="Acquirer ID" class="form-label">Category Name:</label>
          <input type="text" class="form-control" name="category_name" id="category_name"   placeholder="Enter Category Name"  value="<? if(isset($post['category_name'])) echo $post['category_name'];?>" required>
        </div>
		
	<div class="col-sm-4 ps-0">
	<?
	//$data['mcc_codes']=["7995"=>"7995","4899"=>"4899","5967"=>"5967"];
	$post['mcc_code']=isset($post['mcc_code'])&&$post['mcc_code']?$post['mcc_code']:'';
	$data['mcc_codes']=[];
	$mcc_code_ex=explode(",",$post['mcc_code']);
	foreach($mcc_code_ex as $k=>$v){
		if(!in_array($v,$data['mcc_codes'])) $data['mcc_codes'][$v]=$v;
	}
	?>
        <label for="mcc_code" class="form-label w-100">MCC Code :</label> 
          <select id="mcc_code" data-placeholder="Start typing the MCC Codes " multiple class="chosen-select form-control" name="mcc_code[]" style="clear:right;width:83%;" >
            <?=showselect($data['mcc_codes'], (isset($post['mcc_code'])?$post['mcc_code']:0),1)?>
          </select>
          
<script>
$("#mcc_code_chosen").css("width", "100%").css("background", "#ffffff");
//$("#mcc_code_chosen").addClass("form-control");
</script>
      </div>
	  
    
      <div class="col-sm-4 ps-0">
        <label for="comments" class="form-label">Note/Comments:</label>
          <input type="text" id="mustHaveId"  name="comments"  class="form-control" placeholder="Enter Note/Comments" value="<? if(isset($post['comments'])) echo  $post['comments'];?>" required>
      </div>
      
      <!--============================Work Area==================-->
      <div><span id="user-availability-status"></span></div>
      <p><img src="LoaderIcon.gif" id="loaderIcon" style="display:none" /></p>
      <!--========================================================-->
      <div class="text-center row ">
        <div class="col-sm-12 my-2  remove-link-css text-center">
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
