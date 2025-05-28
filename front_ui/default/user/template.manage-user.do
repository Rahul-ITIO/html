<? if(isset($data['ScriptLoaded'])){ ?>

<?php /*?> js Function for Copy Payment Link <?php */?>
<script>
/*fun for show hide listing detail section*/

$(document).ready(function(){

    $(".email_validate_input").keyup(function(){
		email_validatef(this,".validate_input_firstname","");
	});
	
	var email_subject_var="1";
	$("#storeType").change(function() {
	   var selectedItem = $(this).val();
	   var burl= $('option:selected', this).attr('data-burl');
	   var dba= $('option:selected', this).attr('data-dba');
	   if($("#email_subject").val()===""||$("#email_subject").val()==""||email_subject_var==""){
		//alert(burl+"\r\n"+dba);
		email_subject_var="";
		var email_subject = "You have got a payment request from";
		if(burl){email_subject += " - "+burl;}
		if(dba){email_subject += " - "+dba;}
		$("#email_subject").val(email_subject);
	   }
	   
	 
	});
});
</script>
<div id="zink_id" class="container bg-primary px-0">
  <form method="post" name="data">
    <input type="hidden" name="step" value="<?=$post['step']?>">
    <input type="hidden" name="uid" value="<?=(isset($post['uid'])&&$post['uid']);?>">
    <? if(isset($data['Error'])&&$data['Error']){ ?>
    <div class="container mt-2" style="max-width:540px;">
      <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error!</strong>
        <?=prntext($data['Error'])?>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
    </div>
    <? } ?>
    <? if(isset($_SESSION['action_success'])&&$_SESSION['action_success']){ ?>
    <div class="alert alert-success alert-dismissible fade show m-2 " role="alert"> <?php echo $_SESSION['action_success'];?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <? $_SESSION['action_success']=null; } ?>
    <? if($post['step']==1){ ?>
    <div class="container my-2 py-2 border rounded bg-primary">
      <div class="row vkg">
        <div class="col-sm-12 ">
          <h4 class="float-start"><i class="<?=$data['fwicon']['manage-user'];?>"></i> User Management</h4>
          <button class="btn btn-primary btn-sm float-end my-1" type="submit" name="send" value="Add New Sub Merchant!" title="Add A New Sub Merchant"><i class="<?=$data['fwicon']['circle-plus'];?>"></i></button>
        </div>
      </div>
	  
<div class="table-responsive-sm mwidthlist">
<table id="display-large-screen" class="table table-hover bg-primary text-white">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">User&nbsp;ID</th>
      <th scope="col">Full&nbsp;Name</th>
      <th scope="col">Email</th>
	  <th scope="col">Status</th>
	  <th scope="col">&nbsp;</th>
    </tr>
  </thead>
<? $j=1; foreach($data['selectdatas'] as $ind=>$value) { ?>
<?
$jsr=jsondecode($value['json_value']);
$str1 = trim($value['sub_client_role']);
$grole=explode(',',$str1);

$rolestring="<span class=''><div class='span_c'>";
if(in_array(1, $grole)){ $rolestring.=" <div class='text-start'><i class='".$data['fwicon']['check-double']." text-success'></i> Add/Edit Emails </div>"; }
if(in_array(2, $grole)){ $rolestring.=" <div class='text-start'><i class='".$data['fwicon']['check-double']." text-success'></i> Account Security </div>"; }
if(in_array(3, $grole)){ $rolestring.=" <div class='text-start'><i class='".$data['fwicon']['check-double']." text-success'></i> All Transaction </div>"; }
if(in_array(4, $grole)){ $rolestring.=" <div class='text-start'><i class='".$data['fwicon']['check-double']." text-success'></i> Block Transaction </div>"; }
if(in_array(5, $grole)){ $rolestring.=" <div class='text-start'><i class='".$data['fwicon']['check-double']." text-success'></i> Manage User </div>"; }
if(in_array(6, $grole)){ $rolestring.=" <div class='text-start'><i class='".$data['fwicon']['check-double']." text-success'></i> Message Center </div>"; }
if(in_array(7, $grole)){ $rolestring.=" <div class='text-start'><i class='".$data['fwicon']['check-double']." text-success'></i> My Bank Accounts </div>"; }
if(in_array(8, $grole)){ $rolestring.=" <div class='text-start'><i class='".$data['fwicon']['check-double']." text-success'></i> My Website </div>"; }
if(in_array(9, $grole)){ $rolestring.=" <div class='text-start'><i class='".$data['fwicon']['check-double']." text-success'></i> Profile </div>"; }
if(in_array(10, $grole)){ $rolestring.=" <div class='text-start'><i class='".$data['fwicon']['check-double']." text-success'></i> Recent Order Accounts </div>"; }
if(in_array(11, $grole)){ $rolestring.=" <div class='text-start'><i class='".$data['fwicon']['check-double']." text-success'></i> Request Funds </div>"; }
if(in_array(12, $grole)){ $rolestring.=" <div class='text-start'><i class='".$data['fwicon']['check-double']." text-success'></i> Send Fund </div>"; }
if(in_array(13, $grole)){ $rolestring.=" <div class='text-start'><i class='".$data['fwicon']['check-double']." text-success'></i> Settings Accounts </div>"; }
if(in_array(14, $grole)){ $rolestring.=" <div class='text-start'><i class='".$data['fwicon']['check-double']." text-success'></i> Statement </div>"; }
if(in_array(15, $grole)){ $rolestring.=" <div class='text-start'><i class='".$data['fwicon']['check-double']." text-success'></i> Test Transaction </div>"; }
if(in_array(16, $grole)){ $rolestring.=" <div class='text-start'><i class='".$data['fwicon']['check-double']." text-success'></i> Withdraw Funds </div>"; }
if(in_array(17, $grole)){ $rolestring.=" <div class='text-start'><i class='".$data['fwicon']['check-double']." text-success'></i> Success Ratio </div>"; }
if(in_array(18, $grole)){ $rolestring.=" <div class='text-start'><i class='".$data['fwicon']['check-double']." text-success'></i> Add Beneficiary </div>"; }
if(in_array(19, $grole)){ $rolestring.=" <div class='text-start'><i class='".$data['fwicon']['check-double']." text-success'></i> Upload Fund </div>"; }
if(in_array(20, $grole)){ $rolestring.=" <div class='text-start'><i class='".$data['fwicon']['check-double']." text-success'></i> Payout Transaction </div>"; }
if(in_array(21, $grole)){ $rolestring.=" <div class='text-start'><i class='".$data['fwicon']['check-double']." text-success'></i> Payout Statement </div>"; }
if(in_array(22, $grole)){ $rolestring.=" <div class='text-start'><i class='".$data['fwicon']['check-double']." text-success'></i> Payout Keys </div>"; }
if(in_array(23, $grole)){ $rolestring.=" <div class='text-start'><i class='".$data['fwicon']['check-double']." text-success'></i> Beneficiary List </div></div>"; }

$rolestring.="</span>";

if($value['active']==1){ $user_status="<span>Active</span>"; } else { $user_status="<span>Suspended</span>"; }


	 
?>
      <tr>
	  <th scope="row"><a data-bs-toggle="modal" data-count="<?=prntext($value['id'])?>" class="tr_open_on_modal text-decoration-none" data-bs-target="#myModal"><i class="<?=$data['fwicon']['display'];?> text-link" title="View details"></i></a></th>
	  <td><?=$value['username']?></td>
	  <td><?php 
		  if(isset($value['fullname'])&&$value['fullname']) echo ucwords($value['fullname']);
		  ?>
		  </td>
	  <td class="text-truncate"><?php echo encrypts_decrypts_emails(@$value['registered_email'],2);?></td>
	  <td><?=$user_status;?></td>
	  <td align="center">
	 
	  <div class="btn-group dropstart short-menu-auto-main"> <a data-bs-toggle="dropdown" aria-expanded="false"  title="Action" ><i class="<?=$data['fwicon']['action'];?> text-link"></i></a>
                <ul class="dropdown-menu dropdown-menu-icon pull-right" >
                  <li> <a class="dropdown-item" href="<?=$data['USER_FOLDER']?>/manage-user<?=$data['ex']?>?id=<?=$value['id']?>&action=update" title="Edit" ><i class="<?=$data['fwicon']['edit'];?> text-success float-start"></i> <span class="action_menu">Edit</span></a></li>
                  <li> <a class="dropdown-item" href="<?=$data['USER_FOLDER']?>/password<?=$data['ex']?>?id=<?=$value['id']?>&action=password"  title="Change Password" onclick="return confirm('Do you want to change password?');"><i class="<?=$data['fwicon']['unlock'];?> float-start text-white"></i> <span class="action_menu">Change Password</span></a></li>
                  <? if($value['active']==1){ ?>
                  <li> <a class="dropdown-item" href="<?=$data['USER_FOLDER']?>/manage-user<?=$data['ex']?>?id=<?=$value['id']?>&action=suspend"  title="Suspend" onclick="return confirm('Do you want to suspend?');"><i class="<?=$data['fwicon']['ban'];?> text-danger float-start"></i> <span class="action_menu">Suspend</span></a></li>
                  <? } ?>
                  <li> <a class="dropdown-item"  href="<?=$data['USER_FOLDER']?>/manage-user<?=$data['ex']?>?id=<?=$value['id']?>&action=delete"  title="Delete" onclick="return confirm('Do you want to delete?');"><i class="<?=$data['fwicon']['delete'];?> text-danger float-start"></i> <span class="action_menu">Delete</span></a></li>
                  <? if($value['active']==0){ ?>
                  <li> <a class="dropdown-item" href="<?=$data['USER_FOLDER']?>/manage-user<?=$data['ex']?>?id=<?=$value['id']?>&action=active" title="Activate" onclick="return confirm('Do you want to activate?');"><i class="<?=$data['fwicon']['check-circle'];?> float-start"></i> </a> <span class="action_menu">Activate</span></li>
                  <? } ?>
                </ul>
              </div>
     
	  </td>
   </tr>
   <tr class="hide">
     <td colspan="8">
	<div class="next_tr_<?=prntext($value['id']);?> hide row">
	<div class="mboxtitle hide">Sub Merchant : <?=@$value['username'];?> - <?=prntext(@$value['fullname']);?></div>
	<div class="col-sm-12 border rounded mb-2 mboxcss">
	     
			    <div class="row m-2">
				<div class="col-sm-3">User ID </div>
				<div class="col-sm-9">: <?=@$value['username'];?></div>
			    </div>

                <div class="row m-2">
				<div class="col-sm-3">Name </div>
				<div class="col-sm-9">: <?php  if(isset($value['fullname'])&&$value['fullname']) echo $value['fullname'];?></div>
		  
                </div>
		
                <div class="row m-2">
				<div class="col-sm-3">Email</div>
				<div class="col-sm-9 ">: <?=encrypts_decrypts_emails(@$value['registered_email'],2);?></div>
				</div>
		
				<div class="row m-2">
				<div class="col-sm-3">Status</div>
				<div class="col-sm-9">: <?=@$user_status;?></div>
				</div>
				
                <div class="row m-2">
				<div class="col-sm-3">Assign Work</div>
				<div class="col-sm-9"><?=@$rolestring;?></div>
                </div>
     </div>
    </div>
			 
    
		  </td>
        </tr>
   <? } ?>
</table>	  
 </div>    
	  
	  
    </div>
    <? }elseif($post['step']==2){ ?>
    <? if((isset($post['gid']) &&$post['gid'])){ ?>
    <input type="hidden" name="gid" value="<?=$post['gid']?>">
    <? }else{
	   
	}
	
  ?>
  
    <div class="container mt-2 mb-2 border rounded bg-primary vkg" >
      <h4 class="my-2"><i class="<?=$data['fwicon']['manage-user'];?>"></i> User Management - <?=$post['add_titileName'];?> Sub Merchant</h4>

      <div class="mb-3  px-2 row was-validated text-white">
        
		<div class="col-sm-4 px-2 ">
          <div class="col-sm-12 input-field mt-4">
          <input type="text" class="form-control is-invalid" name="fullname"  id="input_fullname" value="<?=((isset($post['subclientsuserfullname']) &&$post['subclientsuserfullname'])?$post['subclientsuserfullname']:'')?>"  title="Enter full name for sub merchant" data-bs-toggle="tooltip" data-bs-placement="bottom"  autocomplete="off" required /> <!--fname-->
		  <label for="input_fullname" >Enter full name for sub merchant</label>
        </div></div>
        <div class="col-sm-4 px-2 ">
          <div class="col-sm-12 input-field mt-4">
          
          <input type="email" class="form-control is-invalid" name="registered_email"  id="input_email" value="<?=((isset($post['subclientsuseremail']) &&$post['subclientsuseremail'])?encrypts_decrypts_emails($post['subclientsuseremail'],2):'')?>" autocomplete="off" title="Enter email address for sub merchant" data-bs-toggle="tooltip" data-bs-placement="bottom" required />
		  <label for="input_email">Enter email address for sub merchant</label>
        </div></div>
        <div class="col-sm-4 px-2 ">
          <div class="col-sm-12 input-field mt-4">
          
          <input type="text" class="form-control is-invalid" name="uname" id="input_uname" value="<?=((isset($post['subclientsusername']) &&$post['subclientsusername'])?$post['subclientsusername']:'')?>" title="Enter username for sub merchant" data-bs-toggle="tooltip" data-bs-placement="bottom" autocomplete="off" required />
		  <label for="input_uname">Enter Username For sub merchant</label>
        </div></div>
        <?/*?>
        <div class="col-sm-6 " style="display: <?=$post['field_disable'];?>;" >
		  <label for="Password" class="form-label">Password :</label>
            <input type="text" class="form-control" name="pass"  placeholder="Enter password" value="<?=$post['password']?>" autocomplete="off" style="display: <?=$post['field_disable'];?>;" title="Enter password" data-bs-toggle="tooltip" required />
          </div>
		<?*/?>
        <div class="col-sm-12">
          <div class="input-group my-2 px-2 row" id="manageuserforcss">
<?
$str = trim(isset($post['sub_client_role'])&&$post['sub_client_role']?$post['sub_client_role']:'');
$m_role=explode(',',$str);

//print_r($data['mrindex']);

if(isset($post['payout_request'])&&$post['payout_request']&&$post['payout_request']!=3){
	$mrindex_2=array(
		/*18=>'Add Beneficiary',*/
		19=>'Upload Fund',
		20=>'Payout Transaction',
		21=>'Payout Statement',
		22=>'Payout Keys',
		23=>'Beneficiary List',
	);
	//array_push($data['mrindex'],"Add Beneficiary","Upload Fund","Payout Transaction","Payout Statement","Payout Keys","Beneficiary List");
	$data['mrindex']=array_merge($data['mrindex'],$mrindex_2);

}

if($data['QRCODE_GATEWAY_DB']&&$data['QRCODE_GATEWAY_DB']&&isset($post['qrcode_gateway_request'])&&($post['qrcode_gateway_request']==1 || $post['qrcode_gateway_request']==2)){
	$mrindex_2=array(
		55=>'Soft Pos',
	);
	$data['mrindex']=array_merge($data['mrindex'],$mrindex_2);
}

//print_r($data['mrindex']);

foreach($data['mrindex'] as $mrval=>$mrtitle) {

if($mrtitle<>""){

echo '<div class="form-check form-switch col-sm-3"><input type="checkbox" name="role[]"  class="form-check-input"  value="'.$mrval.'"';
if (in_array($mrval, $m_role)){ echo "checked"; } 
echo ">";
echo "<label class='form-check-label text-white' for='flexCheckChecked'>".$mrtitle."&nbsp;</label></div>" ;
}
}
?>
          </div>
        </div>
        <div class="col-sm-12 m_role px-1 text-center">
          <button class="btn btn-primary btn-sm mb-3" type="submit" name="send" value="Submit"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Submit</button>
          <a href="<?=$data['USER_FOLDER']?>/manage-user<?=$data['ex']?>" class="btn btn-primary btn-sm mb-3"><i class="<?=$data['fwicon']['back'];?>"></i> Back</a></div>
      </div>
    </div>
    <? } ?>
  </form>
</div>

<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
