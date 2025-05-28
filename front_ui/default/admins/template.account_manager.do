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
	
	
	if (document.getElementById("manager_name").value.trim() == "") {
		document.getElementById("manager_name").focus();
		alert("Please Select Aquirer ID!");
		return false;
	}

    if (document.getElementById("contact_number").value.trim() == "") {
		document.getElementById("contact_number").focus();
		alert("Please Enter Name!");
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
    <? if((isset($_SESSION['login_adm']))){?>
    <div class="row  ps-0">
	
<div class="col-sm-8 my-2 ps-0">
<h4 class="my-2"><img src="../images/account_manager_icon_1.png" style="height:18px;" /> Account Manager <a data-ihref="<?=$data['Admins']?>/json_log_all<?=$data['ex']?>?tablename=account_manager&mode=json_log" title="View Json Log History" onclick="iframe_open_modal(this);"><i class="fa-solid <?=$data['fwicon']['circle-info'];?> text-danger fa-fw"></i></a></h4>
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
            <th scope="col"><i class="fa fa-fa-solid fa-user-check text-info fa-fade" title="Manager Name"></i> Manager Name</th>
            <th scope="col"><i class="fa fa-headphones text-info fa-fade" title="Contact"></i> Contact Number</th>
            <th scope="col"><i class="fa fa-envelope-open-text text-info fa-fade" title="Contact"></i> Email</th>
            
            <th scope="col"><i class="fa fa-headphones text-info fa-fade" title="BCC Name"></i> BCC Name</th>
            <th scope="col"><i class="fa fa-envelope-open-text text-info fa-fade" title="BCC Email"></i> BCC Email</th>
            
            <th scope="col"><i class="fa-brands fa-skype text-info fa-fade" title="Skype"></i> Skype Address</th>
            <th scope="col"><i class="fa-brands fa-whatsapp text-success fa-fade" title="WhatsApp"></i> Whatsapp No.</th>
            <th scope="col"><i class="fa-brands fa-telegram text-info fa-fade" title="Telegram"></i> Telegram No.</th>
            <th scope="col">Action</th>
          </tr>
        </thead>
    <? 
	foreach($post['result_list'] as $key=>$value) {
	?>
        <tr valign="top" class="rounded">
          <td><?=$value['manager_name'];?></td>
          <td><?=$value['contact_number'];?></td>
          <td><?=$value['email_id'];?></td>

          
          <td><?=@$value['bcc_name'];?></td>
          <td><?=@$value['bcc_email'];?></td>

          <td><?=$value['skype_id'];?></td>

          <td><?=$value['whatsapp_no'];?></td>
          <td><?=$value['telegram_no'];?></td>
          <td>
		  
		  <div class="btn-group dropstart short-menu-auto-main"> <a data-bs-toggle="dropdown" aria-expanded="false"  title="Action"><i class="<?=$data['fwicon']['action'];?> text-link"></i></a>
                <ul class="dropdown-menu dropdown-menu-icon pull-right" >
				
                  <li> <a class="dropdown-item" href="<?=$data['Admins'];?>/<?=$data['PageFile']?><?=$data['ex']?>?id=<?=$value['id']?>&action=update" title="Edit"><i class="<?=$data['fwicon']['edit'];?> text-success fa-fw float-start"></i> <span class="action_menu">Edit</span></a></li>

                  <li> <a class="dropdown-item"  href="<?=$data['Admins'];?>/<?=$data['PageFile']?><?=$data['ex']?>?id=<?=$value['id']?>&action=delete" onclick="return confirm('Are you Sure to Delete');" title="Delete"><i class="<?=$data['fwicon']['delete'];?> text-danger fa-fw float-start"></i> <span class="action_menu">Delete</span></a></li>
				  
					<? if(isset($value['json_log_history'])&&$value['json_log_history']){?>
					<li> 
					<i class="<?=$data['fwicon']['circle-info'];?> text-info fa-fw float-start  mx-1" 
					onclick="popup_openv('<?=$data['Host']?>/include/json_log<?=$data['ex']?>?tableid=<?=$value['id'];?>&tablename=account_manager')" title="View Json History"></i>
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
	
    <h4 class="my-2"><i class="<?=$data['fwicon']['recentorder'];?>"></i> <?php if(isset($post['gid'])&&$post['gid']){ ?> Edit <? } else { ?> Add New <? } ?> Account Manager <?php if(isset($post['gid'])&&$post['gid']){ ?> 
	<? if(isset($post['json_log_history'])&&$post['json_log_history']){?>
			<i class="<?=$data['fwicon']['circle-info'];?> text-info fa-fw" 
			onclick="popup_openv('<?=$data['Host']?>/include/json_log<?=$data['ex']?>?tableid=<?=$post['id'];?>&tablename=account_manager')" title="View Json History"></i>
			<? } ?>
	 <? } ?></h4>
    <div class="vkg-main-border"></div>
  </div>

    <div class="row  p-1 rounded">


    

	  <div class="col-sm-4 ps-0 mt-4">
        <label for="manager_name" class="form-label"><i class="fa fa-fa-solid fa-user-check text-info fa-fade" title="Manager Name"></i> Manager Name for Display of Merchant Dashboard:</label>
          <input type="text" class="form-control" name="manager_name" id="manager_name"   placeholder="Enter Manager Name"  value="<? if(isset($post['manager_name'])) echo $post['manager_name'];?>" required>
      </div>
		
 

	  <div class="col-sm-4 ps-0 mt-4">
        <label for="bcc_name" class="form-label"><i class="fa fa-fa-solid fa-user-check text-info fa-fade" title="BCC Name"></i> BCC Name:</label>
          <input type="text" class="form-control" name="bcc_name" id="bcc_name"   placeholder="Enter BCC Name"  value="<? if(isset($post['bcc_name'])) echo $post['bcc_name'];?>" required>
      </div>
		
      

	  <div class="col-sm-4 ps-0 mt-4">
        <label for="bcc_email" class="form-label"><i class="fa fa-fa-solid fa-envelope-open-text text-info fa-fade" title="BCC Email"></i> BCC Email:</label>
          <input type="text" class="form-control" name="bcc_email" id="bcc_email"   placeholder="Enter BCC Email"  value="<? if(isset($post['bcc_email'])) echo $post['bcc_email'];?>" required>
      </div>
		
      

	  <div class="col-sm-4 ps-0 mt-4">
        <label for="contact_number" class="form-label"><i class="fa fa-headphones text-info fa-fade" title="Contact"></i> Contact Number:</label>
          <input type="text" class="form-control" name="contact_number" id="contact_number"   placeholder="Enter Contact Number"  value="<? if(isset($post['contact_number'])) echo $post['contact_number'];?>" required>
      </div>
		
      

	  <div class="col-sm-4 ps-0 mt-4">
        <label for="email_id" class="form-label"><i class="fa fa-envelope-open-text text-info fa-fade" title="Email"></i> Email Address:</label>
          <input type="text" class="form-control" name="email_id" id="email_id"   placeholder="Enter Email Address"  value="<? if(isset($post['email_id'])) echo $post['email_id'];?>" required>
      </div>
		
      
    
      <div class="col-sm-4 ps-0 mt-4">
        <label for="skype_id" class="form-label"><i class="fa-brands fa-skype text-info fa-fade" title="Skype"></i> Skype Address:</label>
          <input type="text"  name="skype_id"  id="skype_id"  class="form-control" placeholder="Enter Skype Address" value="<? if(isset($post['skype_id'])) echo  $post['skype_id'];?>" required>
      </div>
      
    
      <div class="col-sm-4 ps-0 mt-4">
        <label for="whatsapp_no" class="form-label"><i class="fa-brands fa-whatsapp text-success fa-fade" title="WhatsApp"></i> Whatsapp Number:</label>
          <input type="text" id="whatsapp_no"  name="whatsapp_no"  class="form-control" placeholder="Enter Whatsapp Number" value="<? if(isset($post['whatsapp_no'])) echo  $post['whatsapp_no'];?>" required>
      </div>
      
    
      <div class="col-sm-4 ps-0 mt-4">
        <label for="telegram_no" class="form-label"><i class="fa-brands fa-telegram text-info fa-fade" title="Telegram"></i> Telegram Number:</label>
          <input type="text" id="telegram_no"  name="telegram_no"  class="form-control" placeholder="Enter Telegram Number" value="<? if(isset($post['telegram_no'])) echo  $post['telegram_no'];?>" required>
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
