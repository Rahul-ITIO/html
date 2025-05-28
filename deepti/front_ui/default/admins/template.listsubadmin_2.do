<? if(isset($data['ScriptLoaded'])){ ?>

<style>
#transaction_display_divid {position:absolute;float:right;z-index:999;}
#transaction_display_divid .chosen-container {width: 100% !important;min-width: 300px !important;}
</style>
<script src="<?=$data['TEMPATH']?>/common/js/jquery-ui.min.js"></script>
<div class="container border my-1 vkg rounded">
  <? if((isset($_SESSION['action_success'])&& $_SESSION['action_success'])){ ?>
  <div class="container mt-3 px-0">
    <div class="alert alert-success alert-dismissible fade show" role="alert"> <strong>Success!</strong>
      <?=$_SESSION['action_success'];?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
  </div>
  <? $_SESSION['action_success']=""; } ?>

<? if(!$_SESSION['login_adm']&&!$_SESSION['list_sub_admin']){
		if($_SESSION['action_success']){
			$_SESSION['action_success']=0;
		}else{
			echo $data['OppsAdmin'];
		}
		exit;
}
if(isset($_SESSION['action_success'])&&$_SESSION['action_success']){ $_SESSION['action_success']=0;}
?>


<? if($post['action']=='select'){ ?>
<form name="associatreport" action="<?=$data['Host'];?>/associatreport<?=$data['ex']?>/" target="associatreport">
<div class="row">

<div class="col-sm-8"><h4 class="my-2"><i class="<?=$data['fwicon']['sub-admin-list'];?>"></i> Sub Admin List</h4></div>

<div class="col-sm-4">

            <select class="select_cs_2 form-select form-select-sm my-2 float-start mx-2" name="pdate" id="month_list" style="width: calc(100% - 50px);">
            <option value="" selected="selected" disabled>Select Month for Report</option>
            <?
			function monthlistf($month){
			$currentdate=date("Y-m-d");
			$monthget=date("Y-m-d",strtotime("$month month",strtotime($currentdate)));
			$monthName=date("Y-m-d",strtotime("first day of this month $monthget"));
			echo "<option value='".date("Y-m-d",strtotime($monthName))."'>".date("F, Y",strtotime($monthName))."</option>";
	        }
	
	monthlistf("-0");
	monthlistf("+1");monthlistf("+2");monthlistf("+3");
	monthlistf("-9");monthlistf("-8");monthlistf("-7");monthlistf("-6");monthlistf("-5");monthlistf("-4");monthlistf("-3");monthlistf("-2");monthlistf("-1");monthlistf("-10");
	
	?>
          </select>
<a  href="<?=$data['Admins'];?>/subadmin<?=$data['ex']?>?action=insert"  value="Add Sub Admin"  class="btn btn-primary btn-sm my-2" title="Add Sub Admin"><i></i><i class="<?=$data['fwicon']['circle-plus'];?>"></i></a></div>
</div>

  <? if($post['action']=='select'&& (isset($post['gid'])&&$post['gid'])){ 
  
  	if(isset($data['subadmin'][0]['fullname'])&&$data['subadmin'][0]['fullname'])
		$fullname = $data['subadmin'][0]['fullname'];
	else 
		$fullname = $data['subadmin'][0]['fname']." ".$data['subadmin'][0]['lname'];
  
  
  ?>
  <div class="row my-2">
		   <a href="<?=$data['Admins'];?>/listsubadmin<?=$data['ex'];?>?action=select" class="btn btn-primary" onclick="return confirm('Are you sure to clear <?=$data['subadmin'][0]['username'];?>?');">
		   
<?=$post['gid'];?> | <?=$data['subadmin'][0]['username'];?> | <?=$fullname;?> | <?=$data['subadmin'][0]['domain_name'];?> | <?=encrypts_decrypts_emails($data['subadmin'][0]['email'],2);?>  <i class="<?=$data['fwicon']['check-cross'];?> text-danger"></i>
		   </a>
  </div>
 <? } ?>
		  
		  
  <div class="table-responsive">

    <table class="table table-hover frame">
  <thead>
      <tr class="bg-dark-subtle">
        <th class="text-center" scope="col"><input type="checkbox" name="echeckid" id="echeckid" onclick="toggle(this)" class="admin_list form-check-input"> </th>
		<th scope="col"><div class="transaction-h1">Username</div><div class="transaction-h2">Full Name</div></th>
        <th scope="col"><div class="transaction-h1">Role</div><div class="transaction-h2">Domain</div></th>
		<th scope="col"><div class="transaction-h1">Front UI</div><div class="transaction-h2">Color</div></th>
		<th scope="col"><div class="transaction-h1"><span class="d-none d-sm-block">Count Merchant</span><span class="d-block d-sm-none" title="Count Merchant">C.M.</span></div><div class="transaction-h2"><span class="d-none d-sm-block">Count Transaction</span><span class="d-block d-sm-none" title="Count Transaction">C.T.</span></div></th>
		<th scope="col" valign="top"><div class="transaction-h1">2FA</div></th>
		<th scope="col" valign="top"><div class="transaction-h1">Action</div></th>
      </tr>
	  </thead>
	  
      <? $c=0; foreach($data['subadmin'] as $key=>$value){if($value['id']){
	  $c++;
	$csscolor=$value['upload_css'];
	
	$color='background-color:#fff !important;color:#000 !important;"';
	$color=find_css_color($csscolor,'#fff');
	$bgcolor=$color[1];
	$color=$color[0];
	
	  $themebgcolor=$value['header_bg_color'];
	  $themecolor=$value['header_text_color'];
	  if($value['header_text_color']==""){ $value['header_text_color']="#000";}
	  if($value['header_bg_color']==""){ $value['header_bg_color']="#fff";}
	  
	?>
	
      <tr class="flag_ rounded" valign="top" style="color:<?=$themecolor?>;background:<?=$themebgcolor?>;">
        <td scope="col" class="text-center"><input class="admin_list clsradio form-check-input" id="<?=$value['id']?>" type="radio" name="bid" value="<?=$value['id']?>" style="display:none;" />          </td>
<td scope="col" ><div class="transaction-list-h1"><?=$value['username']?> (<?=$value['id']?>)</div>
                 <div class="transaction-list-h2"><? if(isset($value['fullname'])&&$value['fullname']) echo $value['fullname'];
				else echo $value['fname'];?></div>          </td>		
<td data-label="User Type / Role - "  ><? $ar=db_rows(
			"SELECT `id`,`rolesname`".
			" FROM `{$data['DbPrefix']}access_roles`".
			" WHERE `id`={$value['access_id']} LIMIT 1"
		);
	?>    <? if(isset($ar[0]['rolesname'])){ ?> 
		  <div class="d-inline-block text-truncate transaction-list-h1" style="max-width: 80px;" title="<? echo $ar[0]['rolesname']?>" data-bs-toggle="tooltip" data-bs-placement="top"><? echo $ar[0]['rolesname']?></div>
		  <? } ?>        
		  <? 
		if (strpos($data['Host'],'localhost'))
		{
			$link=$data['Admins'].'/login'.$data['ex'].'?bid='.$value['id'];
		}
		else 
		{
			if(isset($data['AdminFolder'])&&$data['AdminFolder']){
				$Admins='/'.$data['AdminFolder'];
			}
			else{
				$Admins='/mlogin';
			}
			$link='https://'.$value['domain_name'].$Admins.'/login'.$data['ex'].'?bid='.$value['id'];
		}
		?>
		  <div class="transaction-list-h2"><a href="<?=$link?>" target="_blank" title="Click to Login" data-bs-toggle="tooltip" data-bs-placement="top" style="color:<?=$themecolor?> !important;"><?=$value['domain_name']?></a>&nbsp;</div>		  </td>
        
		<td scope="col"> 
			<div class="transaction-list-h1"><?=ucwords($value['front_ui'])?>&nbsp;</div>
			<div class="transaction-list-h2"><?=ucwords($value['upload_css'])?>&nbsp;</div>			</td>
		<?php 
if (isset($_SESSION['uid'])&&$_SESSION['uid']==$value['id']){$cplink="";}else {$cplink="?id=".$value['id'];}
?>

			  <td scope="col">
			  <div id="count_clients_admin_id_<?=$c;?>" title="View Total Merchants" data-bs-toggle="tooltip" data-bs-placement="left" class="transaction-list-h1">
			  <a class="restartfa" onClick="ajaxf1(this,'<?=$data['Host']?>/include/count_clients_admin<?=$data['ex'];?>?id=<?=$value['id'];?>&admin=1','#count_clients_admin_id_<?=$c;?>','1','2')" title="View Total Merchants"  style="color:<?=$themecolor?> !important;"><i class="<?=$data['fwicon']['rotate'];?>"></i></a>			  </div>	
			  
			  <div id="count_trans_sub_admin_id_<?=$c;?>" title="View Total Transaction" data-bs-toggle="tooltip" data-bs-placement="left" class="transaction-list-h1 mt-1">	  
			  <a class="restartfa" onClick="ajaxf1(this,'<?=$data['Host']?>/include/count_trans_sub_admin<?=$data['ex'];?>?id=<?=$value['id'];?>&admin=1','#count_trans_sub_admin_id_<?=$c;?>','1','2')" title="Click to View Total Merchants " style="color:<?=$themecolor?> !important;" ><i class="<?=$data['fwicon']['role-list'];?>"></i></a>
			  </a>			  </td>
		  <td data-label="2 Way Auth - " data-bs-toggle="tooltip" data-bs-placement="left" title="Click to Enable / Disable" >
		 <? if(($value['google_auth_access']==2)||($value['google_auth_access']==0)){ ?>
			  <a href="<?=$data['Admins'];?>/listsubadmin<?=$data['ex']?>?id=<?=$value['id']?>&action=select&code=1" title="Click to Enable" style="color:<?=$themecolor?>;"  ><i class="<?=$data['fwicon']['circle-cross'];?> text-white"></i></a>
			  <? }else { ?>
			   <a href="<?=$data['Admins'];?>/listsubadmin<?=$data['ex']?>?id=<?=$value['id']?>&action=select&code=2" title="Click to Disable" style="color:<?=$themecolor?>;" ><i class="<?=$data['fwicon']['verified'];?> text-white"></i></a>
              <? } ?>
			  <div id="codereset_<?=$value['id']?>" name="codereset" class="codereset"></div>			  </td>	  
        <td data-label="Action">
		
		<div class="btn-group dropstart">
            <a  data-bs-toggle="dropdown" aria-expanded="false" title="Action"><i class="<?=$data['fwicon']['action'];?>"></i></a>
            <ul class="dropdown-menu pull-right" style="color:<?=$themecolor?>;background:<?=$themebgcolor?>;"> <!--style="color:<?=$themecolor?>;background:<?=$themebgcolor?>"-->

              <li> <a href="<?=$data['Admins'];?>/subadmin<?=$data['ex']?>?id=<?=$value['id']?>&action=update&page=0" title="Edit"  class="dropdown-item" style="color:<?=$themecolor?>;"><i class="<?=$data['fwicon']['edit'];?> fa-fw"></i> <span>Edit</span></a></li>
             
			 <? if($value['active']==0){ ?>
			<li><a href="<?=$data['Admins'];?>/listsubadmin<?=$data['ex']?>?id=<?=$value['id']?>&action=active_status&sid=1" title="Click to Login Active Status" class="dropdown-item" style="color:<?=$themecolor?>;"><i class="<?=$data['fwicon']['circle-cross'];?> fa-fw"></i> <span>Status</span></a></li>
			<? }elseif($value['active']==1){ ?>
			<li><a href="<?=$data['Admins'];?>/listsubadmin<?=$data['ex']?>?id=<?=$value['id']?>&action=close_status&sid=0" title="Click to Login Close Status"  class="dropdown-item" style="color:<?=$themecolor?>;"><i class="<?=$data['fwicon']['check-circle'];?> fa-fw"></i>  <span>Status</span></a></li>
			<? } ?>
			
				
				<?
				
				//$df='Y-m-d H:i:s';
				$df='YmdHis';
				$gt=date($df,((int)$value['ip_block_admin_time']));
				$ct=date($df,(time())); 
				$c30=date($df,strtotime('-31 minutes',time()));
				if(isset($gt)&&isset($c30)&&$gt>$c30){
					
			?>
			
			<li><a href="<?=$data['Admins'];?>/listsubadmin<?=$data['ex']?>?id=<?=$value['id']?>&action=block_unlock" onclick='return confirm("Do you want to Block the login for 30min.?");' title="Can not Login : Block for 30min."  class="dropdown-item" style="color:<?=$themecolor?>;"><i class="<?=$data['fwicon']['lock'];?> fa-fw"></i>  <span>Blocked</span></a></li>
			
		<? }else{ ?>
		
				<li><a href="<?=$data['Admins'];?>/listsubadmin<?=$data['ex']?>?id=<?=$value['id']?>&action=block_lock" onclick='return confirm("Do you want to lock the login?");' title="You can able to Login" class="dropdown-item" style="color:<?=$themecolor?>;"><i class="<?=$data['fwicon']['lock'];?> fa-fw"></i> Active</a></li>
			
		<? } ?>
			 
			<li><a href="<?=$data['Admins']?>/login<?=$data['ex']?>?bid=<?=$value['id']?>" target="_blank"
			title="Click to Login" data-bs-toggle="tooltip" class="dropdown-item" style="color:<?=$themecolor?>;"><i class="<?=$data['fwicon']['login'];?> fa-fw"></i> Login</a></li> 
			
			<li><a href="<?=$data['Admins'];?>/history<?=$data['ex']?>?clients=<?=$value['id']?>&t=sadm" target="_blank"
			title="Click to Login" data-bs-toggle="tooltip" class="dropdown-item modal_from_url" style="color:<?=$themecolor?>;"><i class="<?=$data['fwicon']['user-role'];?> fa-fw"></i> IP History</a></li> 
            </ul>
          </div>		</td>
      </tr>
	<? }} ?>
    </table>
  </div>
  <script>
$("#month_list").change(function(e){
	if($("input.admin_list:radio[name='bid']").is(":checked")) {
		//alert($('input.admin_list:radio:checked').val());
		//var subaminid=$('input.admin_list:radio:checked').val();
		//window.location.href="../associatreport<?=$data['ex']?>?bid="+subaminid+"&pdate="+$(this).val();
		document.associatreport.submit();
	}else{
		alert("Please select SubAdmin ID");
	}

});

function getXMLHttp(){
  var xmlHttp
  try{
    //Firefox, Opera 8.0+, Safari
    xmlHttp = new XMLHttpRequest();
  }
  catch(e){
    //Internet Explorer
    try{
      xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
    }
    catch(e){
      try{
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
      }
      catch(e){
        alert("Your browser does not support AJAX!")
        return false;
      }
    }
  }
  return xmlHttp;
}

function AuthenticationReset(mid){


	var xmlHttp = getXMLHttp();  
	xmlHttp.onreadystatechange = function(){
	  if(xmlHttp.readyState == 4){
	  HandleResponsecodereset(xmlHttp.responseText,mid);
	  }
	}

  xmlHttp.open("GET", "<?=$data['Host']?>/include/ajax<?=$data['ex']?>?mid="+mid+"&action=resets", true); 
  xmlHttp.send(null);
}
function HandleResponsecodereset(response,mid){
	document.getElementById('codereset_'+mid).innerHTML = response;
	document.getElementById('codereset_'+mid).style.display="block";
}
function Closereset(mid){
document.getElementById('codereset_'+mid).style.display="none";
}
</script>
</form>


<? } ?>

<?php /*?>js use For Display tooltip<?php */?>

<script>
function toggle(){

   var checkBox = document.getElementById("echeckid");
   
   if (checkBox.checked == true){
   //alert("display");
   //document.getElementById("bid").style.display = '';
   $(".clsradio").css("display", "");
   }
   else {
   //alert("hide");
   $(".clsradio").css("display", "none");
   }
}
</script>

</div>
<? } ?>
