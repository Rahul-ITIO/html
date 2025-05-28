<? if(isset($data['ScriptLoaded'])){?>
<link href="<?=$data['TEMPATH']?>/common/css/table-responsive_999.css" rel="stylesheet">
<div class="container border bg-white">
  
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
    <style>
/*#content {min-height:600px;}
.bgc_10, .bgc_10 td {background:#ffffff !important;} 
.bgc_11, .bgc_11 td {background:#e8e7e7 !important;} 
.char_1, .char_1 td {background:#d1d1d1 !important;} 
.noti_1, .noti_1 td {background:#c1d5ac !important;}
.scru_1, .scru_1 td {background:#faf3b4 !important;}
textarea {background:#ffffff !important;} 

TD.field, .input {
    height: 35px;
    vertical-align: middle !important;
    padding-left: 5px !important;
}*/


/*.rightlink {float:right;font-size:14px;padding:10px 30px 0 0;font-weight: bold;}
.addmessageform, .viewdetaildiv {display:none;float:left;padding:20px;padding:0 4% 20px 4%;width:92%;border-bottom:2px solid #ccc;margin: 0 0 20px 0;}
a{cursor:pointer;}
.rmk_row {border-top:none !important; padding:0px 0 0px 0; margin:0px 0;}
.row_col3 {white-space:nowrap;float:left;width:96%;padding:4px 2%;font-weight:bold;background:#f3f3f3;margin:0px 0;border-top:1px solid #ccc;border-bottom:1px solid #ccc;}*/

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
function addmessages(e){
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
}

$(document).ready(function(){
    $('.echektran .collapsea').click(function(){
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
        
    });
	
	$('#category_filter').change(function(){
	   var thisVal = $(this).val();
		window.location.href="<?=$data['Admins']?>/gateway_category<?=$data['ex']?>?action="+thisVal;
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
<h4 class="my-2"><i class="<?=$data['fwicon']['table-list'];?>"></i> Category </h4>
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
    <div class="container table-responsive px-0"	>
      <table class="echektran" >
        <thead>
          <tr>
            <th width="10%">ID</th>
			 <?/*?>
            <th>Category Key</th>
			 <?*/?>
            <th width="30%">MCC Codes</th>
            <th>Category Name</th>
            <th>Comments</th>
			<?/*?>
            <th width="12%">Date</th>
			<?*/?>
            <th width="10%">Action</th>
          </tr>
        </thead>
        <? 
	
	$j=1; 
	
	foreach($post['result_list'] as $key=>$value) {
	
	?>
        <tr valign="top">
          <td title="ID" data-label="ID - "><a class="collapsea btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton1" data-href="<?=$j;?>_toggle">
            <?=$value['id'];?>
            </a> </td>
		 <?/*?>
          <td title="Category Key" data-label="Category Key - "><?=$value['category_key'];?></td>
		  <?*/?>
          <td title="MCC Codes" data-label="MCC Codes" ><span class="btn btn-abv-search"><?=$value['assign_id'];?></span>
          </td>
          <td title="Category Name" data-label="Category Name - "  nowrap><a class="collapsea text-wrap" data-href="<?=$j;?>_toggle" title="<?=$value['category_name']?>"><?=ucwords(strtolower($value['category_name']))?>
            
            </a></td>
		
          <td title="Comments" class="text-wrap" data-label="Comments - " nowrap ><?=ucfirst($value['comments'])?></td>
		  
		  <?/*?>
          <td title="Date" class="text-wrap" data-label="Date - " nowrap ><div title='Updated Date: <?=prndate($value['udate'])?>'>UD:
              <?=prndate($value['udate']);?>
            </div>
            <div title='Created Date: <?=prndate($value['cdate'])?>'>CD:
              <?=prndate($value['cdate']);?>
            </div></td>
		<?*/?>
          <td  title="Action" data-label="Action - " nowrap><? if((isset($_SESSION['login_adm']))||(isset($_SESSION['edit_salt'])&&$_SESSION['edit_salt']==1)){?>
            <a href="<?=$data['Admins'];?>/<?=$data['PageFile']?><?=$data['ex']?>?id=<?=$value['id']?>&action=update"><i class="<?=$data['fwicon']['edit'];?> text-success" title="Edit"></i></a>
            <? if(strpos($value['comments'],"Assign for All")!==false){?>
            <? } ?>
            <? } if((isset($_SESSION['login_adm']))||(isset($_SESSION['delete_salt'])&&$_SESSION['delete_salt']==1)){?>
            &nbsp;&nbsp;<a href="<?=$data['Admins'];?>/<?=$data['PageFile']?><?=$data['ex']?>?id=<?=$value['id']?>&action=delete" onclick="return confirm('Are you Sure to Delete');" title="Delete" ><i class="<?=$data['fwicon']['delete'];?> text-danger"></i></a>
            <? } ?>
          </td>
        </tr>
        <tr class="padding0 hide" id="<?=$j;?>_toggle_tr" >
          <td class="padding0 text-wrap" colspan="5" ><div class="collapseitem" id="<?=$j;?>_toggle">
             
              <div class="row listData">
<div class="text-start my-2 ms-3"><? echo json_log_view($value['json_log_history'],'View Json Log','0','json_log','','100');?></div>
                <div class="col_2" style="width:99%;">
                  <?	
						$mcc_code_0=explodef($value['mcc_code'],',',0);
						$mcc_code_get=$mcc_code_0." ".$data['t'][$mcc_code_0]['name1'];
						//echo $mcc_code_get;
						$json_arr=[];  $json_array_key=[];
						$json_value=isJsonEn($value['bank_salt']);
						$json_de=$json_value;
						$json_arr[$mcc_code_get]=$json_de;
						//$json_array_key=array_merge(['saltJson'],(array_keys($json_arr['saltJson'])));
						//print_r($json_array_key);
						$de_josn1=is_multi_label_arrayf($json_arr, $json_array_key,$mcc_code_get);
						echo "<div class='inputJsonDiv'>".$de_josn1."</div>";
						
					?>
                </div>
              </div>
             
            </div></td>
        </tr>
        <? $j++; } ?>
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
    <h4 class="my-2"><i class="<?=$data['fwicon']['table-list'];?>"></i> <?php if(isset($post['gid'])&&$post['gid']){ ?> Edit <? } else { ?> Add New <? } ?> Category System</h4>
    <div class="vkg-main-border"></div>
  </div>
  
    <div class="row">
	
	<div class="col-sm-12 ps-0">
	<?
	$data['mcc_codes']=["7995"=>"7995","4899"=>"4899","5967"=>"5967"];
	$mcc_code_ex=explode(",",$post['mcc_code']);
	foreach($mcc_code_ex as $k=>$v){
		if(!in_array($v,$data['mcc_codes'])) $data['mcc_codes'][$v]=$v;
	}
	?>
        <label for="mcc_code" class="form-label">MCC Codes :</label> 
          <select id="mcc_code" data-placeholder="Start typing the MCC Codes " multiple class="chosen-select form-control" name="mcc_code[]" style="clear:right;width:83%;" >
            <?=showselect($data['mcc_codes'], (isset($post['mcc_code'])?$post['mcc_code']:0),1)?>
          </select>
          
<script>
$(".chosen-select").chosen({
no_results_text: "Oops, nothing found!"
});
</script>
<script>
$("#mcc_code_chosen").css("width", "100%").css("background", "antiquewhite");
$("#mcc_code_chosen").addClass("form-control");
</script>
      </div>
	  
      <div class="col-sm-6 ps-0">
        <label for="Acquirer ID" class="form-label">Category Name:</label>
          <input type="text" class="form-control" name="category_name" id="category_name"   placeholder="Enter Category Name"  value="<? if(isset($post['category_name'])) echo $post['category_name'];?>" required>
        </div>
      <div class="col-sm-6 ps-0">
        <label for="comments" class="form-label">Note/Comments:</label>
          <input type="text" id="mustHaveId"  name="comments" id="comments"  class="form-control" placeholder="Enter Note/Comments" value="<? if(isset($post['comments'])) echo  $post['comments'];?>" required>
      </div>
      
      <!--============================Work Area==================-->
      <div><span id="user-availability-status"></span></div>
      <p><img src="LoaderIcon.gif" id="loaderIcon" style="display:none" /></p>
      <!--========================================================-->
      <div class="text-center row p-0">
        <div class="col-sm-6 my-2 ps-0">
          <button formnovalidate type="submit" name="send" value="CONTINUE"  onclick="return checkvalidation()" class="btn btn-icon btn-primary w-100"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Submit</button>
        </div>
        <div class="col-sm-6 ps-0 my-2"> <a href="<?=$data['Admins']?>/<?=$data['PageFile']?><?=$data['ex']?>" class="btn btn-icon btn-primary w-100"><i class="<?=$data['fwicon']['back'];?>"></i> Back</a> </div>
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
