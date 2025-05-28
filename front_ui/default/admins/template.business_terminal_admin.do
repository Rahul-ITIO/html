<?
include('../include/fontawasome_icon'.$data['iex']); // for display fw icon on ajax call page
$clients_active_type = $_SESSION['MemberInfo']['active'];
$mtype = $data['MEMBER_TYPE'][$clients_active_type];

$store_url=$post['store_url'];
$store_name=$post['store_name'];

$is_admin=isset($post['is_admin'])&&$post['is_admin']?$post['is_admin']:'';
$post['type']=isset($post['type'])&&$post['type']?$post['type']:'';
?>

<div class="mt-2 table-responsive-sm">
<?
if((isset($_SESSION['login_adm']))||(isset($_SESSION[$mtype])&&$_SESSION[$mtype]==1))
{
?>
  <div class="text-end">
    <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_add_stores'])&&$_SESSION['merchant_action_add_stores']==1)){ ?>
    <a href="<?=$data['Admins'];?>/<?=$data['my_project']?><?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&action=insert_terminals&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" class="btn btn-icon btn-primary" title=" Add A New <?=($store_name);?>" ><i class="<?=$data['fwicon']['circle-plus'];?>"></i></a>
    <? } ?>
  </div>
  <? if($post['Terminals']){ ?>
	<table class="table table-hover">
		<thead>
			<tr><th scope="col">Name</th>
				<th scope="col">Url</th>
				<th scope="col">TerNO</th>
				<th scope="col">Public Key</td>
				<th scope="col">Status</th>
				<? 
				if(((isset($_SESSION['login_adm']))||(isset($_SESSION['templates_add_store'])&&$_SESSION['templates_add_store']==1)) ){
				?>
				<th scope="col">Templates</th>
				<? } ?>
				<? 
				if(((isset($_SESSION['login_adm']))||(isset($_SESSION['q_website_sold'])&&$_SESSION['q_website_sold']==1)) ){?>
				<th scope="col">Sold</th>
				<? } ?> 
				<? 
				if(((isset($_SESSION['login_adm']))||(isset($_SESSION['q_website_action'])&&$_SESSION['q_website_action']==1)) ){
				?>   
				<th scope="col">Action</th>
			<? } ?>      
			</tr>
		</thead>
    <? $idx=0;$k=0;foreach($post['Terminals'] as $value){$k++; ?>
    <tr>
      <td><b><?=($value['ter_name'])?></b></td>
      <td><span class="text-wrap"><?=($value['bussiness_url'])?></span></td>
      <td>
	  <? 
	  if(((isset($_SESSION['login_adm']))||(isset($_SESSION['q_website_id'])&&$_SESSION['q_website_id']==1)) ){
	  ?>
	  <a href="<?=$data['USER_FOLDER']?>/<?=($store_url);?><?=$data['ex']?>?admin=1&mid=<?=$post['MemberInfo']['id']?>&id=<?=$value['id']?>&action=view&bid=<?=$post['MemberInfo']['id']?>" title="View TerNO Details" class="modal_for_website badge rounded-pill bg-primary text-white"><?=($value['id'])?></a>
	  <? } else { ?>
	  <a title="View TerNO Details" class="badge rounded-pill bg-primary text-white"><?=($value['id'])?></a>
	  <? } ?>
	  </td>
	  
      <td><? if($value['public_key']<>""){ ?><a data-value="<?=(@$value['public_key'])?>" title="Copy Public Key - <?=(@$value['public_key'])?>" id="apic_<?=$k;?>" onclick="copytext_f(this,'Public Key for TerNO - <?=($value['id'])?>')" class="btn btn-icon btn-primary btn-sm show"><i class="<?=$data['fwicon']['copy'];?>"></i> </a><? } ?></td>
	  
	  
        <td>
	    <div class="float-end" style="width:30px;">
       <? if($value['active']==1){ ?>
       <i class="<?=$data['fwicon']['check-circle'];?> text-success m-1" title="<?=($value['id'])?> has been Approved"></i>
       <? }elseif($value['active']==3){ ?>
       <i class="<?=$data['fwicon']['circle-cross'];?> text-danger m-1" title="<?=prntext($value['id'])?> Not Activate Yet"></i>
       <? }elseif($value['active']==2){ ?>
       <i class="<?=$data['fwicon']['circle-cross'];?> text-danger m-1" title="<?=prntext($value['id'])?> Deleted"></i>
       <? }elseif($value['active']==4){ ?>
       <a <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_add_stores'])&&$_SESSION['merchant_action_add_stores']==1)){ ?>	href="<?=$data['Admins']?>/<?=$data['my_project']?><?=$data['ex']?>?bid=<?=$value['id'];?>&id=<?=$post['MemberInfo']['id']?>&action=approved_store&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" onClick="return confirm('Are you Sure to Approved this');" <? } ?>  title="Under review"> <i class="<?=$data['fwicon']['eye-solid'];?> m-1"></i> </a>
          <? }elseif($value['active']==5){ ?>
          <i class="<?=$data['fwicon']['clock'];?> text-success m-1" title="<?=prntext($value['id'])?> Awaiting Terminal"></i>
          <? }elseif($value['active']==6){ ?>
          <i class="<?=$data['fwicon']['ban'];?> m-1" title="Terminated"></i>
          <? }else{ ?>
          <i class="<?=$data['fwicon']['vector-square'];?> m-1" title="<?=prntext($value['id'])?> Not define yet"></i>
          <? } ?>
        </div>
        <div class="float-end hide-768" style=" width: calc(100% - 32px);">
          <select name="store_status" id="store_status_<?=$k;?>"  class="form-select form-select-sm">
            <option value="" disabled="" selected=""><?=($store_name);?> Status</option>
            <option value="1" disabled="">Approved </option>
            <option value="2" disabled="">Deleted </option>
            <option value="3" disabled="">Rejected</option>
            <option value="4" disabled="">Under review</option>
            <option value="5" disabled="">Awaiting Terminal</option>
            <option value="6" disabled="">Terminated</option>
          </select>
          <script>
		  $('#store_status_<?=$k;?> option[value="<?=$value['active']?>"]').prop('disabled','true');
		  $('#store_status_<?=$k;?> option[value="<?=$value['active']?>"]').removeAttr("disabled");
		  $('#store_status_<?=$k;?> option[value="<?=$value['active']?>"]').prop('selected','selected');
		  </script>
        </div>
		</td>
<? 
if(((isset($_SESSION['login_adm']))||(isset($_SESSION['templates_add_store'])&&$_SESSION['templates_add_store']==1)) ){
?>
      <td><select name="templates" id="templates<?=$k;?>" class="form-select form-select-sm" onClick="templatesf2(this,this.value)" onChange="templatesf(this.value,'<?=($value['id'])?>','<?=$_GET['id'];?>','<?=$post['MemberInfo']['sponsor'];?>');" style="max-width: 200px;">
          <option value="" disabled="" selected="">Templates</option>
          <?=showselect($data['tmp2'], $value['templates'])?>
        </select>
      </td>
      <? } ?>
	  
<?  
if(((isset($_SESSION['login_adm']))||(isset($_SESSION['q_website_sold'])&&$_SESSION['q_website_sold']==1)) ){
?>
      <td data-label="Sold : " nowrap><a class="restartfa" onClick="ajaxf1(this,'<?=$data['Admins']?>/<?=$data['my_project']?><?=$data['ex']?>?action=transcount&mid=<?=$post['MemberInfo']['id']?>&id=<?=$value['id']?>','#tracount_<?=$value['id']?>')" ><i class="<?=$data['fwicon']['rotate'];?>"></i></a>
        <div id="tracount_<?=$value['id']?>"> </div></td>
<? } ?>
<? 
if(((isset($_SESSION['login_adm']))||(isset($_SESSION['q_website_action'])&&$_SESSION['q_website_action']==1)) ){
?>
      <td>
	  
	  <div class="btn-group dropstart short-menu-auto-main"> <a data-bs-toggle="dropdown" aria-expanded="false"  title="Action"><i class="<?=$data['fwicon']['circle-down'];?> text-link"></i></a>
                <ul class="dropdown-menu dropdown-menu-icon pull-right text-center" >
				
				<li><a href="<?=$data['USER_FOLDER']?>/<?=($store_url);?><?=$data['ex']?>?admin=1&mid=<?=$post['MemberInfo']['id']?>&id=<?=$value['id']?>&action=view&bid=<?=$post['MemberInfo']['id']?><?=($data['is_admin_link']);?>" title="View <?=($store_name);?> Details" class="modal_for_website dropdown-item" ><i class='<?=$data['fwicon']['eye-solid'];?>'></i> </a></li>
				
<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_add_stores'])&&$_SESSION['merchant_action_add_stores']==1)){ ?>
        <li><a href="<?=$data['Admins'];?>/<?=$data['my_project']?><?=$data['ex']?>?bid=<?=$value['id'];?>&id=<?=$post['MemberInfo']['id']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>&action=update_terminals&type=<?=$post['type']?>" title="Edit" class="dropdown-item"><i class="<?=$data['fwicon']['edit'];?> text-success"></i></a></li>
		
		
		<li><a href="<?=$data['Admins'];?>/<?=$data['my_project']?><?=$data['ex']?>?bid=<?=$value['id'];?>&id=<?=$post['MemberInfo']['id']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>&action=delete_terminals&type=<?=$post['type']?>" onclick="return cfmform()" title="Delete" class=" dropdown-item"><i class="<?=$data['fwicon']['delete'];?> text-danger"></i></a></li>
	  
	  <li><a href="<?=$data['USER_FOLDER']?>/generate_code<?=$data['ex']?>?admin=1&bid=<?=$post['MemberInfo']['id']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>&id=<?=$value['id']?>&action=store" title="Generate Code" class="modal_for_website dropdown-item"><i class="<?=$data['fwicon']['code'];?>"></i></a></li>
        <? } ?>
				  


                </ul>
              </div>
	  
	        <!--
	  
        <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_add_stores'])&&$_SESSION['merchant_action_add_stores']==1)){ ?>
        <a href="<?=$data['Admins'];?>/<?=$data['my_project']?><?=$data['ex']?>?bid=<?=$value['id'];?>&id=<?=$post['MemberInfo']['id']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>&action=update_terminals&type=<?=$post['type']?>" title="Edit" class="mx-1"><i class="<?=$data['fwicon']['edit'];?> text-success"></i></a>&nbsp;<a href="<?=$data['Admins'];?>/<?=$data['my_project']?><?=$data['ex']?>?bid=<?=$value['id'];?>&id=<?=$post['MemberInfo']['id']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>&action=update_terminals&type=<?=$post['type']?>" onclick="return cfmform()" title="Delete" class="mx-1"><i class="<?=$data['fwicon']['delete'];?> text-danger"></i></a>&nbsp;
	  
	  <a href="<?=$data['USER_FOLDER']?>/generate<?=$data['ex']?>?admin=1&bid=<?=$post['MemberInfo']['id']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>&id=<?=$value['id']?>&action=store" title="Generate Code" class="modal_for_website mx-1"><i class="<?=$data['fwicon']['code'];?>"></i></a>
        <? } ?>-->
		
	  </td>
		<? } ?>
		</tr>
		<? $idx++;}?>
  </table>
<?
}
?>
</div>
<? 
}else
{
	include('../oops'.$data['iex']);
}
?>
<script>
//====================modal_iframe=============
	
	$('.modal_for_website').on('click', function(e){
      e.preventDefault();
	  //alert('show');
     // $('#myModal_web').modal('show').find('.modal-body').load($(this).attr('href'));
	  //$('#myModal_web .modal-dialog').css({"max-width":"80%"});
	  $('.modal-body iframe').attr('src',$(this).attr('href'));
      $('#myModal_web').modal('show');
	  $('#myModal_web .modal-dialog').css({"max-width":"95%"});
	  //$('.modal-title').html('View Website List');
    });
	

</script>
<!--  /////////// Start Modal Trans /////////////////-->
<div class="modal" id="myModal_web" style="display:none;">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title"><!--Heading--></h4>
        <button type="button" class="btn-close myModal_web_close"  data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <iframe src="" width="100%" height="600"></iframe>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger myModal_web_close"  data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
<!--  /////////// END Modal Trans /////////////////-->
