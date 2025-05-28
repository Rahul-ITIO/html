<? if(isset($data['ScriptLoaded'])){ ?>
<style>
#transaction_display_divid {position:absolute;float:right;z-index:999;}
#transaction_display_divid .chosen-container {width: 100% !important;min-width: 300px !important;}
html .rowMultiColorX > tbody > tr:hover * {
	-webkit-filter: grayscale(1) invert(1);
	filter: grayscale(1) invert(1);
}
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
  <? unset($_SESSION['action_success']); } ?>

<? if(!isset($_SESSION['login_adm'])&&!isset($_SESSION['list_sub_admin'])){
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

<div class="col-sm-8"><h4 class="my-2"><i class="<?=$data['fwicon']['sub-admin-list'];?>"></i> Sub Admin List 
<!--========= For optional order listing==================-->
<a title="Transaction Display Option" data-bs-toggle="tooltip" data-bs-placement="right" class="btn btn-primary btn-sm" onclick="view_next3(this,'')"><i class="<?=$data['fwicon']['transaction-display-option'];?>"></i></a>
<? //$_SESSION['subadmin_display'];?>
<? //print_r($_SESSION['subadmin_display_arr']);?>

<?

$a1=array_keys($data['subadmin_listorder']);
 // print_r($a1);
$a2=@$_SESSION['subadmin_display_arr'];

$other_subadmin_listorder=[];
if(empty($_SESSION['subadmin_display_arr'])){
	$other_subadmin_listorder=$a1;
}else{
	if(isset($a1)&&is_array($a1)&&isset($a2)&&is_array($a2))
	$other_subadmin_listorder=array_diff($a1,$a2);

}


?>
<div id="transaction_display_divid" class="bg-body-secondary border rounded p-2 hide">

<select id="transaction_display" data-placeholder="Transaction Display Option" title="Transaction Display Option" multiple class="chosen-select chosen-rtl1 form-select" name="transaction_display[]">
        <? if(isset($_SESSION['subadmin_display_arr'])&&is_array($_SESSION['subadmin_display_arr'])){ 
			foreach($_SESSION['subadmin_display_arr'] as $val){ ?>
			<option value="<?=$val;?>" data-placeholder="<?=$val;?>" title="<?=$data['subadmin_listorder'][$val];?>"><?=$data['subadmin_listorder'][$val];?></option>
		<? }} ?>
		
		<? foreach($other_subadmin_listorder as $val){ ?>
		<option value="<?=$val;?>" data-placeholder="<?=$val;?>" title="<?=$data['subadmin_listorder'][$val];?>"><?=$data['subadmin_listorder'][$val];?></option>
		<? } ?>

</select>
	<script>
	<?if(isset($_SESSION['subadmin_display'])&&$_SESSION['subadmin_display']){?>
		$("#transaction_display").val([<?=($_SESSION['subadmin_display']);?>]).trigger("change"); 
	<?}?>
	$("#transaction_display").trigger("chosen:updated");
	</script>



<button class="input_s btn btn-primary btn-sm search multch select my-2" type="button" id="display_select_all" name="select_all" value="Select All" title="Select All" data-bs-toggle="tooltip" data-bs-placement="top"><i class="<?=$data['fwicon']['square-plus'];?>" ></i></button>
<button class="input_s btn btn-primary btn-sm search multch deselect my-2" type="button" id="display_deselect_all" name="deselect_all" value="Deselect All" title="Deselect All" data-bs-toggle="tooltip" data-bs-placement="top"><i class="<?=$data['fwicon']['square-minus'];?>" ></i></button>

<button class="btn btn-primary btn-sm search my-2" type="button" id="update_selected_chosen" title="SUBMIT" data-bs-toggle="tooltip" data-bs-placement="top"><i class="<?=$data['fwicon']['submit'];?>" ></i></button>


<script>
$('.multch').each(function(index) {
//console.log(index);
				
$(this).on('click', function(){
console.log($(this).parent().find('option').text());
$(this).parent().find('option').prop('selected', $(this).hasClass('select')).parent().trigger('chosen:updated');
	});
});
</script>
                        </div>
<!--===========================-->

</h4></div>


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
 <table class="table table-hover frame rowMultiColor">
  <thead>
      <tr class="bg-dark-subtle">
        
<?
$twice=1;
$h_css="h1";
if(isset($_SESSION['subadmin_display_arr'])&&is_array($_SESSION['subadmin_display_arr']))
{
	foreach($_SESSION['subadmin_display_arr'] as $val){ 
		if($data['subadmin_listorder'][$val]=="Action" ){ 
		$twice=1;
		?>
		<th scope="col" valign="top" ><div class="transaction-h1"><?=$data['subadmin_listorder'][$val];?></div></th>
		<? }elseif($data['subadmin_listorder'][$val]=="Check Box"){ $twice=1; ?>
		<th class="text-center" valign="top" scope="col" style="width:80px"><input type="checkbox" name="echeckid" id="echeckid" onclick="toggle(this)" class="admin_list form-check-input"> </th>
		<? }else{ if($twice==1){ echo '<th scope="col" valign="top">'; $h_css="h1";  }else{ $h_css="h2";}  ?>
		<div class="transaction-<?=$h_css;?>"><?=$data['subadmin_listorder'][$val];?></div>
		<? $twice++;
		if($twice==3){ echo '</th>'; $twice=1;}
		}
	}
} 
?>
        
      </tr>
	  </thead>
	  
     <? $c=0; foreach($data['subadmin'] as $key=>$value){
	    if($value['id']){
	 
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
	
	      
		  
<tr style="color:<?=$themecolor?>;background:<?=$themebgcolor?>;">
        
<?
$twice=1;
$h_css="h1";
if(isset($_SESSION['subadmin_display_arr'])&&is_array($_SESSION['subadmin_display_arr']))
{
	foreach($_SESSION['subadmin_display_arr'] as $val){ 
	if($data['subadmin_listorder'][$val]=="Action" ){ 
	$twice=1;
	?>
	<td scope="col" valign="top" ><div class="btn-group dropstart">
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
				
				<li><a href="<?=$data['Admins'];?>/listsubadmin<?=$data['ex']?>?id=<?=$value['id']?>&action=block_unlock" onclick='return confirm("Do you want unblock the user login now?");' title="Unlock the user login"  class="dropdown-item" style="color:<?=$themecolor?>;"><i class="<?=$data['fwicon']['unlock'];?> fa-fw"></i>  <span>Unlock</span></a></li>
				
			<? }else{ ?>
			
					<li><a href="<?=$data['Admins'];?>/listsubadmin<?=$data['ex']?>?id=<?=$value['id']?>&action=block_lock" onclick='return confirm("Do you want to block the user login for 30 Minutes?");' title="Block the user login for 30 Minutes" class="dropdown-item" style="color:<?=$themecolor?>;"><i class="<?=$data['fwicon']['lock'];?> fa-fw"></i> Block</a></li>
				
			<? } ?>
				 
				<li><a href="<?=$data['Admins']?>/subAdminLogin<?=$data['ex']?>?bid=<?=$value['id']?>" target="_blank"
				title="Click to Login" data-bs-toggle="tooltip" class="dropdown-item" style="color:<?=$themecolor?>;"><i class="<?=$data['fwicon']['login'];?> fa-fw"></i> Login</a></li> 
				
				<li><a href="<?=$data['Admins'];?>/history<?=$data['ex']?>?clients=<?=$value['id']?>&t=sadm" target="_blank"
				title="Click to Login" data-bs-toggle="tooltip" class="dropdown-item modal_from_url" style="color:<?=$themecolor?>;"><i class="<?=$data['fwicon']['user-role'];?> fa-fw"></i> IP History</a></li> 
				</ul>
			  </div></td>
	<? }elseif($data['subadmin_listorder'][$val]=="Check Box"){ $twice=1; ?>
	<td scope="col" class="text-center"><input class="admin_list clsradio form-check-input" id="<?=$value['id']?>" type="radio" name="bid" value="<?=$value['id']?>" style="display:none;" /></td>
	<? }else{ if($twice==1){ echo '<td scope="col" valign="top">'; $h_css="h1";  }else{ $h_css="h2";}  ?>
	<? if($data['subadmin_listorder'][$val]=="Role" ){ ?>
	<div class="transaction-list-<?=$h_css;?>">
	<? $get_role=select_tablef($where_pred="`id`={$value['access_id']}", $tbl="access_roles", $prnt=0, $limit=1, $select="`rolesname`");
	echo $get_role['rolesname'];
	?>
		</div>
		
	<? }elseif($data['subadmin_listorder'][$val]=="2FA" ){ ?>
	<? if(($value['google_auth_access']==2)||($value['google_auth_access']==0)){ ?>
				  <a href="<?=$data['Admins'];?>/listsubadmin<?=$data['ex']?>?id=<?=$value['id']?>&action=select&code=1" title="Click to Enable" style="color:<?=$themecolor?>;"  ><i class="<?=$data['fwicon']['circle-cross'];?> text-whiteX"></i></a>
				  <? }else { ?>
				   <a href="<?=$data['Admins'];?>/listsubadmin<?=$data['ex']?>?id=<?=$value['id']?>&action=select&code=2" title="Click to Disable" style="color:<?=$themecolor?>;" ><i class="<?=$data['fwicon']['verified'];?> text-whiteX"></i></a>
				  <? } ?>
				  <div id="codereset_<?=$value['id']?>" name="codereset" class="codereset"></div>
	<? }elseif($data['subadmin_listorder'][$val]=="Count Merchant" ){ ?>

	<div id="count_clients_admin_id_<?=$c;?>" title="View Total Merchants" data-bs-toggle="tooltip" data-bs-placement="left" class="transaction-list-h1">
	 <a class="restartfa" onClick="ajaxf1(this,'<?=$data['Host']?>/include/count_clients_admin<?=$data['ex'];?>?id=<?=$value['id'];?>&admin=1','#count_clients_admin_id_<?=$c;?>','1','2')" title="View Total Merchants"  style="color:<?=$themecolor?> !important;"><i class="<?=$data['fwicon']['rotate'];?>"></i></a>			  
	</div>
	<? }elseif($data['subadmin_listorder'][$val]=="Count Transaction" ){ ?>
	<div id="count_trans_sub_admin_id_<?=$c;?>" title="View Total Transaction" data-bs-toggle="tooltip" data-bs-placement="left" class="transaction-list-h1 mt-1">	  
				  <a class="restartfa" onClick="ajaxf1(this,'<?=$data['Host']?>/include/count_trans_sub_admin<?=$data['ex'];?>?id=<?=$value['id'];?>&admin=1','#count_trans_sub_admin_id_<?=$c;?>','1','2')" title="Click to View Total Merchants " style="color:<?=$themecolor?> !important;" ><i class="<?=$data['fwicon']['role-list'];?>"></i></a>
				  </div>
	<? }elseif($data['subadmin_listorder'][$val]=="Domain" ){ 
	if (strpos($data['Host'],'localhost'))
			{
				$link=$data['Admins'].'/subAdminLogin'.$data['ex'].'?bid='.$value['id'];
			}
			else 
			{
				if(isset($data['AdminFolder'])&&$data['AdminFolder']){
					$Admins='/'.$data['AdminFolder'];
				}
				else{
					$Admins='/signins';
				}
				$link='https://'.$value['domain_name'].$Admins.'/subAdminLogin'.$data['ex'].'?bid='.$value['id'];
			}


	?>
	<div class="transaction-list-<?=$h_css;?>"><a href="<?=$link?>" target="_blank" title="Domain Url" style="color:<?=$themecolor?> !important;"><?=$value[$val]?></a></div>
	<? }else{ ?>
	<div class="transaction-list-<?=$h_css;?>"><?=$value[$val]?></div>
	<? } ?>
	<? $twice++;
	if($twice==3){ echo '</td>'; $twice=1;}
	}
  } 
}
?>
        
      </tr>
	  
	  	  
	    <? } } ?>
	  
	</table>  

   
  </div>
  <script>
$("#month_list").change(function(e){
	if($("input.admin_list:radio[name='bid']").is(":checked")) {
		//alert($('input.admin_list:radio:checked').val());
		var subaminid=$('input.admin_list:radio:checked').val();
		window.location.href="../associatreport<?=$data['ex']?>?bid="+subaminid+"&pdate="+$(this).val();
		//document.associatreport.submit();
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
<script>
    $('#update_selected_chosen').click(function(){ 
	    var arr = []; 
		$("#transaction_display_chosen span").each(function(){
		arr.push($(this).text()); 
		});
		if(arr.length > 0){
		//salert(arr);
		var admin_id =1;
		//var arr=2;
				$.ajax({
				url: "<?=$data['Host'];?>/include/update_subadminlist_listing_order<?=$data['ex']?>",
				data:'titlelist='+arr+'&admin_id='+admin_id,
				success:function(data){
					data = ($.trim(data.replace(/[\t\n]+/g, '')));
					//alert(data);
					if(data=="done"){
						//alert("redirect");
						setTimeout(function(){ 
							location.reload(true);
						},100); 
					}
				},
				error:function (){}
				});
	
		}else{
		alert("No Any title Selected");
		return;
		}
		

		
        
    });
</script>
<!-- for chosen selected fields dragable Added By Vikash on 08052023-->
<script>
$(document).ready(function () {
    $("#transaction_display_chosen .chosen-choices").sortable({
        revert: true,
        /*update: function (event, ui) {
            // Some code to prevent duplicates
        }*/
    });
    $(".draggable").draggable({
        connectToSortable: '#transaction_display_chosen .chosen-choices',
        cursor: 'pointer',
        helper: 'clone',
        revert: 'invalid'
    });
});
</script>


</div>
<? } ?>
