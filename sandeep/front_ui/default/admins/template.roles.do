<? if(isset($data['ScriptLoaded'])){ ?>
<style>

/*for inline page css show hide data and box formatting*/
frame td {
    margin-bottom: 0% !important;
    background: none !important;
}
label {
    display: block;
    margin-bottom: 0px;
	margin: 0 0 0 0px;
}
.clone1{padding: 0 5px;}
.frame td {
    margin-bottom: 0% !important;
}

.filterHide, .tab_sl_3 {display: none;}
.filterActive {display: block;}
.tab_link3 {cursor: pointer;width:192px;}


.checkbox_table {position:relative;}
.subSelect {position:absolute;left:-30px;}
.subUnSelect {position:absolute;left:-90px;}
.table-primary {
	--bs-table-bg: <?=$_SESSION['background_gl7']?>;
	color: <?=$_SESSION['background_gd7'];?>;
	border-color: <?=$_SESSION['background_gd3'];?>;
	}
.table-striped>tbody>tr:nth-of-type(odd) {
    --bs-table-accent-bg: <?=$_SESSION['background_gl6']?>;
    color: <?=$_SESSION['background_gd7'];?>;
}
.form-check-input:checked {
    background-color: <?=$_SESSION['background_gd3'];?>;
    border-color: <?=$_SESSION['background_gd3'];?>;
}
</style>
<?php if($post['action']=='insert'){ ?>
<style>
.subUnSelect { display:none;}
</style>
<?php } ?>
<script>
/*// js for hide show on checkbox*/
function checkbox_table(groupCheckbox){
	var mychecked = $('.checkbox_table.'+groupCheckbox).find('input:checked').length;
	
	//alert(mychecked);
	
	if (mychecked==0) {
		$('.'+groupCheckbox).prop('checked', false);
	}else{
		$('.'+groupCheckbox).prop('checked', true);
	}
	
	
	$('input[type="checkbox"]').on('change', function() {
		$('input[data-radio="' + $(this).attr('data-radio') + '"]').not(this).prop('checked', false);
	});
	
	
	
}
$(function(){ 
	$('.checkbox_table').each(function() {
		var groupCheckbox=$(this).attr('data-checkbox');
		$(this).find('input[type="checkbox"]').attr('onclick','checkbox_table(\''+groupCheckbox+'\')');
		
		
		var mychecked = $('.checkbox_table.'+groupCheckbox).find('input:checked').length;
		//alert(mychecked);
		
		if (mychecked==0) {
			$('.'+groupCheckbox).attr('checked', false);
		}else{
			$('.'+groupCheckbox).attr('checked', true);
		}
		
	});
	
	
	
	$('.tab_link3').click(function(){
		if($(this).hasClass('tb_active')){
			$(this).next().find('.tab_sl_3').slideUp(200);
			$(this).removeClass('tb_active');
		}else{
			$(this).next().find('.tab_sl_3').slideDown(800);
			$(this).addClass('tb_active');
		}
		
	});
	$('.homeAllMenu').click(function(){
		if($(this).hasClass('tb_active_m')){
			$('.tab_link3').removeClass('tb_active');
			$('.tab_sl_3').slideUp(500);
			$('#colapse_icon').removeClass('<?=$data['fwicon']['search-minus'];?>  text-primary');
			$('#colapse_icon').addClass('<?=$data['fwicon']['search-plus'];?>  text-primary');
			$(this).removeClass('tb_active_m');
		}else{
			$('.tab_sl_3').slideDown(500);
			$('.tab_link3').addClass('tb_active');
			$('#colapse_icon').removeClass('<?=$data['fwicon']['search-plus'];?>  text-primary');
			$('#colapse_icon').addClass('<?=$data['fwicon']['search-minus'];?>  text-primary');
			$(this).addClass('tb_active_m');
		}
		
		
	});
	
	$('.checkall').click(function () {          
		$(".roleList :checkbox").attr("checked", true);
		$('.tab_sl_3').slideDown(500);
		$('.tab_link3').addClass('tb_active');
	});
	// Uncheck All
	$('.uncheckall').click(function () {            
		$(".roleList :checkbox").attr("checked", false);
	});
	
	$('.subSelect').click(function () { 
		var $thisParent=$(this).parent().parent().parent().parent();
		if($(this).hasClass('active')){
			$(this).html('<i class="<?=$data['fwicon']['search-plus'];?>"></i>');
			$(this).removeClass('active');
			$thisParent.find('.notChecked').attr("checked", false);
		}else{
			$(this).html('<i class="<?=$data['fwicon']['search-minus'];?>"></i>');
			$(this).addClass('active');
			$thisParent.find('.notChecked').attr("checked", true);
		}
		
	});
	
	$('.subUnSelect').click(function () { 
		var $thisParent=$(this).parent().parent().parent().parent();
		
		if($(this).hasClass('active')){
			$(this).html('<i class="<?=$data['fwicon']['search-plus'];?>"></i>');
			$(this).removeClass('active');
			$thisParent.find('.default').attr("checked", true);
		}else{
			$(this).html('<i class="<?=$data['fwicon']['search-minus'];?>"></i>');
			$(this).addClass('active');
			$thisParent.find('.checkbox').attr("checked", false);
		}
	});
	
	$('.checkbox_table input[type="checkbox"]').addClass('notChecked');
	$('.checkbox_table input:checked').removeClass('notChecked');
	$('.checkbox_table input:checked').addClass('default');
	
	//if($('.checkbox_table input').is(':checked')) { }
});
</script>
<div class="container border my-1 rounded vkg">
  <h4 class="my-2"><i class="<?=$data['fwicon']['create-roles'];?>"></i>
    <? if($post['action']=='insert'){?> Create Roles <? }else{ ?> Update Roles <? } ?>
  </h4>

 <? if((isset($data['Error'])&& $data['Error'])){ ?>
  <div class="container mt-3">
    <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error!</strong>
      <?=prntext($data['Error'])?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
  </div>
  <? } ?>
  <? if($post['action']=='insert'||$post['action']=='update'){ 
  
  //print_r($post);
  ?>
  <div class="row-fluid">
    <div class="col-sm-12 text-center border border-2 bg-primary my-2 rounded" style="margin:0 auto;">
      <div class="col-sm-12 text-end">
        <div class="py-2 px-2"> 
		<a class="homeAllMenu btn btn-outline-success btn-sm" ><i id="colapse_icon" class="<?=$data['fwicon']['search-plus'];?> text-primary"></i> View All </a> 
		<a class="checkall btn btn-outline-danger btn-sm"><i class="<?=$data['fwicon']['search-plus'];?>"></i> All Checked</a> 
		<a class="uncheckall btn btn-outline-warning btn-sm"><i class="<?=$data['fwicon']['search-minus'];?>"></i> All Unchecked</a> 
		
		</div>
      </div>
      <form method="post">
        <input type="hidden" name="action" value="<?=(isset($post['action'])?$post['action']:'')?>">
        <input type="hidden" name="rid" value="<?=(isset($post['id'])?$post['id']:'')?>">
        <table class="table table-primary table-striped text-start">
          <tr>
            <td class="field" nowrap-for-del>Role Name (*):</td>
            <td class="input" nowrap-for-del><input class="form-control" type="text" name="rolesname"  value="<? if(isset($data['access_roles'][0]['rolesname'])) echo $data['access_roles'][0]['rolesname']?>">            </td>
          </tr>
          <tr>
            <td class="field tab_link3" nowrap-for-del>Merchant Access :
              <input type="checkbox" id="merchant_access_group" class="checkbox form-check-input group_set merchant_access_group form-check-input float-end" <? if(isset($data['access_roles'][0]['merchant_access_group'])&&$data['access_roles'][0]['merchant_access_group']==1){ echo 'checked="checked"';}?> name="merchant_access_group" value="1"  /></td>
            <td class="input" nowrap-for-del><div class="tab_sl_3">
                <table class="checkbox_table merchant_access_group text-start" data-checkbox="merchant_access_group">
                  <tr>
                    <td><input id="merchant_access_all" type="checkbox" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['merchant_access_all'])&&$data['access_roles'][0]['merchant_access_all']==1){ echo 'checked="checked"';}?> name="merchant_access_all" value="1" data-radio="merchant_access" /></td>
                    <td class="clone1">:</td>
                    <td><label for="merchant_access_all">All</label></td>
                  </tr>
                  <tr>
                    <td><input id="merchant_access_multiple" type="checkbox" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['merchant_access_multiple'])&&$data['access_roles'][0]['merchant_access_multiple']==1){ echo 'checked="checked"';}?> name="merchant_access_multiple" value="1" data-radio="merchant_access" /></td>
                    <td class="clone1">:</td>
                    <td><label for="merchant_access_multiple">Multiple</label></td>
                  </tr>
                  <tr>
                    <td><input id="merchant_access_individual" type="checkbox" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['merchant_access_individual'])&&$data['access_roles'][0]['merchant_access_individual']==1){ echo 'checked="checked"';}?> name="merchant_access_individual" value="1" data-radio="merchant_access" /></td>
                    <td class="clone1">:</td>
                    <td><label for="merchant_access_individual">Individual</label></td>
                  </tr>
                </table>
              </div></td>
          </tr>
          <tr>
            <td class="field tab_link3" nowrap-for-del>Sub-admin Access :
              <input type="checkbox" id="sub_admin_access_group" class="checkbox form-check-input group_set sub_admin_access_group float-end" <? if(isset($data['access_roles'][0]['sub_admin_access_group'])&&$data['access_roles'][0]['sub_admin_access_group']==1){ echo 'checked="checked"';}?> name="sub_admin_access_group" value="1"  /></td>
            <td class="input" nowrap-for-del><div class="tab_sl_3">
                <table class="checkbox_table sub_admin_access_group" data-checkbox="sub_admin_access_group">
                  <tr>
                    <td><input id="subadmin_access_all" type="checkbox" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['subadmin_access_all'])&&$data['access_roles'][0]['subadmin_access_all']==1){ echo 'checked="checked"';}?> name="subadmin_access_all" value="1" data-radio="subadmin_access" /></td>
                    <td class="clone1">:</td>
                    <td><label for="subadmin_access_all">All</label></td>
                  </tr>
                  <tr>
                    <td><input id="subadmin_access_multiple" type="checkbox" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['subadmin_access_multiple'])&&$data['access_roles'][0]['subadmin_access_multiple']==1){ echo 'checked="checked"';}?> name="subadmin_access_multiple" value="1" data-radio="subadmin_access" /></td>
                    <td class="clone1">:</td>
                    <td><label for="subadmin_access_multiple">Multiple</label></td>
                  </tr>
                  <tr>
                    <td><input id="subadmin_access_individual" type="checkbox" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['subadmin_access_individual'])&&$data['access_roles'][0]['subadmin_access_individual']==1){ echo 'checked="checked"';}?> name="subadmin_access_individual" value="1" data-radio="subadmin_access" /></td>
                    <td class="clone1">:</td>
                    <td><label for="subadmin_access_individual">Individual</label></td>
                  </tr>
                </table>
              </div></td>
          </tr>
          <tr>
            <td class="field tab_link3 roleList" nowrap-for-del>Search Header:
              <input type="checkbox" id="search_header_group" class="checkbox form-check-input group_set search_header_group float-end" <? if(isset($data['access_roles'][0]['search_header_group'])&&$data['access_roles'][0]['search_header_group']==1){ echo 'checked="checked"';}?> name="search_header_group" value="1"  /></td>
            <td class="input" nowrap-for-del><div class="tab_sl_3">
                <table class="roleList checkbox_table search_header_group" data-checkbox="search_header_group">
                  <tr>
                    <td><input type="checkbox" id="search_header" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['search_header'])&&$data['access_roles'][0]['search_header']==1){ echo 'checked="checked"';}?> name="search_header" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="search_header">Search</label></td>
                  </tr>
                </table>
              </div></td>
          </tr>
          <tr>
            <td class="field tab_link3 roleList" nowrap-for-del>Withdrawal :
              <input type="checkbox" id="withdrawal_group" class="checkbox form-check-input group_set withdrawal_group float-end" <? if(isset($data['access_roles'][0]['withdrawal_group'])&&$data['access_roles'][0]['withdrawal_group']==1){ echo 'checked="checked"';}?> name="withdrawal_group" value="1"  /></td>
            <td class="input" nowrap-for-del><div class="tab_sl_3">
                <table class="roleList checkbox_table withdrawal_group" data-checkbox="withdrawal_group">
                  <tr>
                    <td><input type="checkbox" id="m_withdrawal" class="checkbox form-check-input" <? if(isset($post['m_withdrawal'])&&$post['m_withdrawal']==1){ echo 'checked="checked"';}?> name="json_value[m_withdrawal]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="m_withdrawal">Withdrawal</label></td>
                  </tr>
                </table>
              </div></td>
          </tr>
          <tr>
            <td class="field tab_link3 roleList" nowrap-for-del>Quick Search Header :
              <input type="checkbox" id="quick_search_group" class="checkbox form-check-input group_set quick_search_group float-end" <? if(isset($data['access_roles'][0]['quick_search_group'])&&$data['access_roles'][0]['quick_search_group']==1){ echo 'checked="checked"';}?> name="quick_search_group" value="1"  /></td>
            <td class="input" nowrap-for-del><div class="tab_sl_3">
                <table class="roleList checkbox_table quick_search_group" data-checkbox="quick_search_group">
                  <tr>
                    <td><input type="checkbox" id="q_txn_id" class="checkbox form-check-input" <? if(isset($post['q_txn_id'])&&$post['q_txn_id']==1){ echo 'checked="checked"';}?> name="json_value[q_txn_id]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="q_txn_id">TransID</label>
                      <a class="subSelect" title="Checked All This"><i class="<?=$data['fwicon']['search-plus'];?> text-primary"></i></a> <a class="subUnSelect" title="Unchecked All This"><i class="<?=$data['fwicon']['search-minus'];?> text-primary"></i></a></td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="q_name" class="checkbox form-check-input" <? if(isset($post['q_name'])&&$post['q_name']==1){ echo 'checked="checked"';}?> name="json_value[q_name]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="q_name">Full Name</label></td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="q_email_merchants" class="checkbox form-check-input" <? if(isset($post['q_email_merchants'])&&$post['q_email_merchants']==1){ echo 'checked="checked"';}?> name="json_value[q_email_merchants]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="q_email_merchants">Email (Merchants)</label></td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="q_email_transaction" class="checkbox form-check-input" <? if(isset($post['q_email_transaction'])&&$post['q_email_transaction']==1){ echo 'checked="checked"';}?> name="json_value[q_email_transaction]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="q_email_transaction">Bill Email (Transaction)</label></td>
                  </tr>
				  
				  <tr>
                    <td><input type="checkbox" id="q_t_notification" class="checkbox form-check-input" <? if(isset($post['q_t_notification'])&&$post['q_t_notification']==1){ echo 'checked="checked"';}?> name="json_value[q_t_notification]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="q_t_notification">Email (T. Notification/CSE) </label></td>
                  </tr>
				  
				  
				  <tr>
                    <td><input type="checkbox" id="q_email" class="checkbox form-check-input" <? if(isset($post['q_email'])&&$post['q_email']==1){ echo 'checked="checked"';}?> name="json_value[q_email]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="q_email" title="Primary Email for Merchant Profile">E-mail (Merchant Profile)</label></td>
                  </tr>
				  
				  
                  <tr>
                    <td><input type="checkbox" id="q_price" class="checkbox form-check-input" <? if(isset($post['q_price'])&&$post['q_price']==1){ echo 'checked="checked"';}?> name="json_value[q_price]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="q_price">Bill Amt</label></td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="q_phone" class="checkbox form-check-input" <? if(isset($post['q_phone'])&&$post['q_phone']==1){ echo 'checked="checked"';}?> name="json_value[q_phone]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="q_phone">Bill Phone</label></td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="q_m_orderid" class="checkbox form-check-input" <? if(isset($post['q_m_orderid'])&&$post['q_m_orderid']==1){ echo 'checked="checked"';}?> name="json_value[q_m_orderid]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="q_m_orderid">Reference</label></td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="q_reason" class="checkbox form-check-input" <? if(isset($post['q_reason'])&&$post['q_reason']==1){ echo 'checked="checked"';}?> name="json_value[q_reason]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="q_reason">Trans Response</label></td>
                  </tr>
                  
                  <tr>
                    <td><input type="checkbox" id="q_mid" class="checkbox form-check-input" <? if(isset($post['q_mid'])&&$post['q_mid']==1){ echo 'checked="checked"';}?> name="json_value[q_mid]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="q_mid">MerID</label></td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="q_m_login" class="checkbox form-check-input" <? if(isset($post['q_m_login'])&&$post['q_m_login']==1){ echo 'checked="checked"';}?> name="json_value[q_m_login]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="q_m_login">Merchant Login</label></td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="q_m_list" class="checkbox form-check-input" <? if(isset($post['q_m_list'])&&$post['q_m_list']==1){ echo 'checked="checked"';}?> name="json_value[q_m_list]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="q_m_list">Merchant List</label></td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="q_mailgun_email" class="checkbox form-check-input" <? if(isset($post['q_mailgun_email'])&&$post['q_mailgun_email']==1){ echo 'checked="checked"';}?> name="json_value[q_mailgun_email]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="q_mailgun_email">MailGun Email</label></td>
                  </tr>
				  <? /* ?>
                  <tr>
                    <td><input type="checkbox" id="q_message" class="checkbox form-check-input" <? if(isset($post['q_message'])&&$post['q_message']==1){ echo 'checked="checked"';}?> name="json_value[q_message]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="q_message">Message</label></td>
                  </tr>
				  
				   <? */ ?>
                  <tr>
                    <td><input type="checkbox" id="q_website_sold" class="checkbox form-check-input" <? if(isset($post['q_website_sold'])&&$post['q_website_sold']==1){ echo 'checked="checked"';}?> name="json_value[q_website_sold]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="q_website_sold">Business Sold</label></td>
                  </tr>
				  
				  <tr>
                    <td><input type="checkbox" id="q_website_action" class="checkbox form-check-input" <? if(isset($post['q_website_action'])&&$post['q_website_action']==1){ echo 'checked="checked"';}?> name="json_value[q_website_action]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="q_website_action">Business Action</label></td>
                  </tr>
				  
				  <tr>
                    <td><input type="checkbox" id="q_website_id" class="checkbox form-check-input" <? if(isset($post['q_website_id'])&&$post['q_website_id']==1){ echo 'checked="checked"';}?> name="json_value[q_website_id]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="q_website_id">Business ID</label></td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="q_website" class="checkbox form-check-input" <? if(isset($post['q_website'])&&$post['q_website']==1){ echo 'checked="checked"';}?> name="json_value[q_website]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="q_website">Business</label></td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="q_dba_brand_name" class="checkbox form-check-input" <? if(isset($post['q_dba_brand_name'])&&$post['q_dba_brand_name']==1){ echo 'checked="checked"';}?> name="json_value[q_dba_brand_name]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="q_dba_brand_name">DBA/Brand Name</label></td>
                  </tr>
                 
                  <tr>
                    <td><input type="checkbox" id="q_user_name" class="checkbox form-check-input" <? if(isset($post['q_user_name'])&&$post['q_user_name']==1){ echo 'checked="checked"';}?> name="json_value[q_user_name]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="q_user_name">Username</label></td>
                  </tr>
                  <?php /*?>
				  <tr>
                    <td><input type="checkbox" id="q_first_name" class="checkbox form-check-input" <? if(isset($post['q_first_name'])&&$post['q_first_name']==1){ echo 'checked="checked"';}?> name="json_value[q_first_name]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="q_first_name">First name</label></td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="q_last_name" class="checkbox form-check-input" <? if(isset($post['q_last_name'])&&$post['q_last_name']==1){ echo 'checked="checked"';}?> name="json_value[q_last_name]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="q_last_name">Last name</label></td>
                  </tr>
				  <?php */?>
                  
                  <tr>
                    <td><input type="checkbox" id="q_company_name" class="checkbox form-check-input" <? if(isset($post['q_company_name'])&&$post['q_company_name']==1){ echo 'checked="checked"';}?> name="json_value[q_company_name]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="q_company_name" title="Company Name">Business Name</label></td>
                  </tr>
                </table>
              </div></td>
          </tr>
          <tr>
            <td class="field tab_link3 roleList" nowrap-for-del>Email Menu:
              <input type="checkbox" id="email_menu_group" class="checkbox form-check-input group_set email_menu_group float-end" <? if(isset($data['access_roles'][0]['email_menu_group'])&&$data['access_roles'][0]['email_menu_group']==1){ echo 'checked="checked"';}?> name="email_menu_group" value="1"  /></td>
            <td class="input" nowrap-for-del><div class="tab_sl_3">
                <table class="roleList checkbox_table email_menu_group" data-checkbox="email_menu_group">
                  <tr>
                    <td><input type="checkbox" id="email_zoho_etc" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['email_zoho_etc'])&&$data['access_roles'][0]['email_zoho_etc']==1){ echo 'checked="checked"';}?> name="email_zoho_etc" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="email_zoho_etc">Email</label>                    </td>
                  </tr>
                </table>
              </div></td>
          </tr>
          <tr>
            <td class="field tab_link3 roleList" nowrap-for-del>Merchant Action :
              <input type="checkbox" id="clients_action_group" class="checkbox form-check-input group_set clients_action_group float-end" <? if(isset($data['access_roles'][0]['clients_action_group'])&&$data['access_roles'][0]['clients_action_group']==1){ echo 'checked="checked"';}?> name="clients_action_group" value="1"  /></td>
            <td class="input" nowrap-for-del><div class="tab_sl_3">
                <table class="roleList checkbox_table clients_action_group" data-checkbox="clients_action_group">
                  <tr>
                    <td><input type="checkbox" id="merchant_action_view" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['merchant_action_view'])&&$data['access_roles'][0]['merchant_action_view']==1){ echo 'checked="checked"';}?> name="merchant_action_view" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="merchant_action_view">Merchant View</label>
                      <a class="subSelect" title="Checked All This"><i class="<?=$data['fwicon']['search-plus'];?> text-primary"></i></a> <a class="subUnSelect" title="Unchecked All This"><i class="<?=$data['fwicon']['search-minus'];?> text-primary"></i></a> </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="merchant_action_edit" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['merchant_action_edit'])&&$data['access_roles'][0]['merchant_action_edit']==1){ echo 'checked="checked"';}?> name="merchant_action_edit" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="merchant_action_edit">Merchant Edit</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="merchant_action_login" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['merchant_action_login'])&&$data['access_roles'][0]['merchant_action_login']==1){ echo 'checked="checked"';}?> name="merchant_action_login" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="merchant_action_login">Merchant Login</label>                    </td>
                  </tr>
				  
<tr>
	<td><input type="checkbox" id="merchant_action_add_principal_profile" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['merchant_action_add_principal_profile'])&&$data['access_roles'][0]['merchant_action_add_principal_profile']==1){ echo 'checked="checked"';}?> name="merchant_action_add_principal_profile" value="1" /></td>
	<td class="clone1">:</td>
	<td><label for="merchant_action_add_principal_profile">SPOC Information</label>                    </td>
</tr>
  
<tr>
  <td><input type="checkbox" id="role_mer_withdrawl" class="checkbox form-check-input" <? if(isset($post['role_mer_withdrawl'])&&$post['role_mer_withdrawl']==1){ echo 'checked="checked"';}?> name="json_value[role_mer_withdrawl]" value="1" /></td>
  <td class="clone1">:</td>
  <td><label for="role_mer_withdrawl">Withdrawl</label></td>
</tr>

<tr>
  <td><input type="checkbox" id="role_mer_frozen_balance" class="checkbox form-check-input" <? if(isset($post['role_mer_frozen_balance'])&&$post['role_mer_frozen_balance']==1){ echo 'checked="checked"';}?> name="json_value[role_mer_frozen_balance]" value="1" /></td>
  <td class="clone1">:</td>
  <td><label for="role_mer_frozen_balance">Frozen Balance</label></td>
</tr>
<tr>
  <td><input type="checkbox" id="role_mer_frozen_rolling" class="checkbox form-check-input" <? if(isset($post['role_mer_frozen_rolling'])&&$post['role_mer_frozen_rolling']==1){ echo 'checked="checked"';}?> name="json_value[role_mer_frozen_rolling]" value="1" /></td>
  <td class="clone1">:</td>
  <td><label for="role_mer_frozen_rolling">Frozen Rolling</label></td>
</tr>
<tr>
  <td><input type="checkbox" id="role_mer_qr_code" class="checkbox form-check-input" <? if(isset($post['role_mer_qr_code'])&&$post['role_mer_qr_code']==1){ echo 'checked="checked"';}?> name="json_value[role_mer_qr_code]" value="1" /></td>
  <td class="clone1">:</td>
  <td><label for="role_mer_qr_code">QR Code</label></td>
</tr>

	

	
				  
                  <tr>
                    <td><input type="checkbox" id="merchant_action_password_reset" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['merchant_action_password_reset'])&&$data['access_roles'][0]['merchant_action_password_reset']==1){ echo 'checked="checked"';}?> name="merchant_action_password_reset" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="merchant_action_password_reset">Password-Reset</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="merchant_action_m_edit" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['merchant_action_m_edit'])&&$data['access_roles'][0]['merchant_action_m_edit']==1){ echo 'checked="checked"';}?> name="merchant_action_m_edit" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="merchant_action_m_edit">Merchant Edit</label>                    </td>
                  </tr>
					<tr><td><input type="checkbox" id="view_mask_email" class="checkbox form-check-input" <? if(isset($post['view_mask_email'])&&$post['view_mask_email']==1){ echo 'checked="checked"';}?> name="json_value[view_mask_email]" value="1" /></td>
						<td class="clone1">:</td>
						<td><label for="view_mask_email">View Encoded Email</label></td></tr>
                  <tr>
                    <td><input type="checkbox" id="addNew_GatewayId" class="checkbox form-check-input" <? if(isset($post['addNew_GatewayId'])&&$post['addNew_GatewayId']==1){ echo 'checked="checked"';}?> name="json_value[addNew_GatewayId]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="addNew_GatewayId">List of Gateway Id for Add New Merchant</label>                    </td>
                  </tr>
                  
                  <tr>
                    <td><input type="checkbox" id="clients_store_view" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['clients_store_view'])&&$data['access_roles'][0]['clients_store_view']==1){ echo 'checked="checked"';}?> name="clients_store_view" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='clients_store_view'>Merchant Business View</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="merchant_action_add_stores" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['merchant_action_add_stores'])&&$data['access_roles'][0]['merchant_action_add_stores']==1){ echo 'checked="checked"';}?> name="merchant_action_add_stores" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="merchant_action_add_stores">Modify Business</label>                    </td>
                  </tr>
				  

<tr>
  <td><input type="checkbox" id="role_mer_payin_setting_view" class="checkbox form-check-input" <? if(isset($post['role_mer_payin_setting_view'])&&$post['role_mer_payin_setting_view']==1){ echo 'checked="checked"';}?> name="json_value[role_mer_payin_setting_view]" value="1" /></td>
  <td class="clone1">:</td>
  <td><label for="role_mer_payin_setting_view"> Payin Setting View </label></td>
</tr>
<tr>
  <td><input type="checkbox" id="role_mer_payin_setting_edit" class="checkbox form-check-input" <? if(isset($post['role_mer_payin_setting_edit'])&&$post['role_mer_payin_setting_edit']==1){ echo 'checked="checked"';}?> name="json_value[role_mer_payin_setting_edit]" value="1" /></td>
  <td class="clone1">:</td>
  <td><label for="role_mer_payin_setting_edit"> Payin Setting Edit </label></td>
</tr>
<tr>
  <td><input type="checkbox" id="role_mer_softpos_setting_view" class="checkbox form-check-input" <? if(isset($post['role_mer_softpos_setting_view'])&&$post['role_mer_softpos_setting_view']==1){ echo 'checked="checked"';}?> name="json_value[role_mer_softpos_setting_view]" value="1" /></td>
  <td class="clone1">:</td>
  <td><label for="role_mer_softpos_setting_view"> Softpos Setting View </label></td>
</tr>
<tr>
  <td><input type="checkbox" id="role_mer_softpos_setting_edit" class="checkbox form-check-input" <? if(isset($post['role_mer_softpos_setting_edit'])&&$post['role_mer_softpos_setting_edit']==1){ echo 'checked="checked"';}?> name="json_value[role_mer_softpos_setting_edit]" value="1" /></td>
  <td class="clone1">:</td>
  <td><label for="role_mer_softpos_setting_edit"> Softpos Setting Edit </label></td>
</tr>

<tr>
  <td><input type="checkbox" id="role_mer_payout_setting_view" class="checkbox form-check-input" <? if(isset($post['role_mer_payout_setting_view'])&&$post['role_mer_payout_setting_view']==1){ echo 'checked="checked"';}?> name="json_value[role_mer_payout_setting_view]" value="1" /></td>
  <td class="clone1">:</td>
  <td><label for="role_mer_payout_setting_view"> Payout Gateway View </label></td>
</tr>
<tr>
  <td><input type="checkbox" id="role_mer_payout_setting_edit" class="checkbox form-check-input" <? if(isset($post['role_mer_payout_setting_edit'])&&$post['role_mer_payout_setting_edit']==1){ echo 'checked="checked"';}?> name="json_value[role_mer_payout_setting_edit]" value="1" /></td>
  <td class="clone1">:</td>
  <td><label for="role_mer_payout_setting_edit"> Payout Gateway Edit </label></td>
</tr>

                  <tr>
                    <td><input type="checkbox" id="merchant_action_add_account" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['merchant_action_add_account'])&&$data['access_roles'][0]['merchant_action_add_account']==1){ echo 'checked="checked"';}?> name="merchant_action_add_account" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="merchant_action_add_account">Acquirer</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="clients_acquirer_add_edit" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['clients_acquirer_add_edit'])&&$data['access_roles'][0]['clients_acquirer_add_edit']==1){ echo 'checked="checked"';}?> name="clients_acquirer_add_edit" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='clients_acquirer_add_edit'>Merchant Acquirer Add/Edit</label>                    </td>
                  </tr>
				  <tr><td><input type="checkbox" class="checkbox form-check-input" id="merchant_acquirer_label"  <? if(isset($post['merchant_acquirer_label'])&&$post['merchant_acquirer_label']==1){ echo 'checked="checked"';}?> name="json_value[merchant_acquirer_label]" value="1" /></td>
						<td class="clone1">:</td>
						<td><label for="merchant_acquirer_label">Merchant Acquirer Label</label></td></tr>
                  <tr>
                    <td><input type="checkbox" id="merchant_action_add_associate_account" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['merchant_action_add_associate_account'])&&$data['access_roles'][0]['merchant_action_add_associate_account']==1){ echo 'checked="checked"';}?> name="merchant_action_add_associate_account" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="merchant_action_add_associate_account">Add Associate in Acquirer</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="merchant_action_status_action" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['merchant_action_status_action'])&&$data['access_roles'][0]['merchant_action_status_action']==1){ echo 'checked="checked"';}?> name="merchant_action_status_action" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="merchant_action_status_action">Merchant Status Action</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="merchant_action_bank_account" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['merchant_action_bank_account'])&&$data['access_roles'][0]['merchant_action_bank_account']==1){ echo 'checked="checked"';}?> name="merchant_action_bank_account" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="merchant_action_bank_account">Add Bank Account</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="clients_gp_view_id" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['clients_gp_view_id'])&&$data['access_roles'][0]['clients_gp_view_id']==1){ echo 'checked="checked"';}?> name="clients_gp_view_id" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='clients_gp_view_id'>Merchant Gp View Id</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="clients_risk_ratio_bar" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['clients_risk_ratio_bar'])&&$data['access_roles'][0]['clients_risk_ratio_bar']==1){ echo 'checked="checked"';}?> name="clients_risk_ratio_bar" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='clients_risk_ratio_bar'>Merchant Risk Ratio Bar</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="clients_total_transaction" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['clients_total_transaction'])&&$data['access_roles'][0]['clients_total_transaction']==1){ echo 'checked="checked"';}?> name="clients_total_transaction" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='clients_total_transaction'>Merchant Total Transaction</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="clients_current_balance" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['clients_current_balance'])&&$data['access_roles'][0]['clients_current_balance']==1){ echo 'checked="checked"';}?> name="clients_current_balance" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='clients_current_balance'>Merchant Current Balance</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="clients_two_way_authentication" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['clients_two_way_authentication'])&&$data['access_roles'][0]['clients_two_way_authentication']==1){ echo 'checked="checked"';}?> name="clients_two_way_authentication" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='clients_two_way_authentication'>Merchant Two Way Authentication</label>                    </td>
                  </tr>
                  
                  
                  <tr>
                    <td><input type="checkbox" id="clients_add_email" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['clients_add_email'])&&$data['access_roles'][0]['clients_add_email']==1){ echo 'checked="checked"';}?> name="clients_add_email" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='clients_add_email'>Merchant Add Email</label>                    </td>
                  </tr>
                  
                  <tr>
                    <td><input type="checkbox" id="clients_profile_status_approve" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['clients_profile_status_approve'])&&$data['access_roles'][0]['clients_profile_status_approve']==1){ echo 'checked="checked"';}?> name="clients_profile_status_approve" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='clients_profile_status_approve'>Merchant Profile Status Approve</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="clients_uploaded_document_view" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['clients_uploaded_document_view'])&&$data['access_roles'][0]['clients_uploaded_document_view']==1){ echo 'checked="checked"';}?> name="clients_uploaded_document_view" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='clients_uploaded_document_view'>Merchant Uploaded Document View</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="clients_ip_history" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['clients_ip_history'])&&$data['access_roles'][0]['clients_ip_history']==1){ echo 'checked="checked"';}?> name="clients_ip_history" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='clients_ip_history'>Merchant Ip History</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="clients_bank_edit_permission" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['clients_bank_edit_permission'])&&$data['access_roles'][0]['clients_bank_edit_permission']==1){ echo 'checked="checked"';}?> name="clients_bank_edit_permission" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='clients_bank_edit_permission'>Merchant Bank Edit Permission</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="clients_bank_add_edit" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['clients_bank_add_edit'])&&$data['access_roles'][0]['clients_bank_add_edit']==1){ echo 'checked="checked"';}?> name="clients_bank_add_edit" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='clients_bank_add_edit'>Merchant Bank Add Edit</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="templates_add_store" class="checkbox form-check-input" <? if(isset($post['templates_add_store'])&&$post['templates_add_store']==1){ echo 'checked="checked"';}?> name="json_value[templates_add_store]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='templates_add_store'>Templates Add in Business</label>                    </td>
                  </tr>
                </table>
              </div></td>
          </tr>
          <tr>
            <td class="field tab_link3 roleList" nowrap-for-del>Merchant Menu :
              <input type="checkbox" id="clients_menu_group" class="checkbox form-check-input group_set clients_menu_group float-end" <? if(isset($data['access_roles'][0]['clients_menu_group'])&&$data['access_roles'][0]['clients_menu_group']==1){ echo 'checked="checked"';}?> name="clients_menu_group" value="1"  /></td>
            <td class="input" nowrap-for-del><div class="tab_sl_3">
                <table class="roleList checkbox_table clients_menu_group" data-checkbox="clients_menu_group">
                  <tr>
                    <td><input type="checkbox" id="active" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['active'])&&$data['access_roles'][0]['active']==1){ echo 'checked="checked"';}?>  name="active" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="active">Active</label>
                      <a class="subSelect" title="Checked All This"><i class="<?=$data['fwicon']['search-plus'];?> text-primary"></i></a> <a class="subUnSelect" title="Unchecked All This"><i class="<?=$data['fwicon']['search-minus'];?> text-primary"></i></a> </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="suspended" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['suspended'])&&$data['access_roles'][0]['suspended']==1){ echo 'checked="checked"';}?>  name="suspended" value="1"  /></td>
                    <td class="clone1">:</td>
                    <td><label for="suspended">Suspended</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="closed" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['closed'])&&$data['access_roles'][0]['closed']==1){ echo 'checked="checked"';}?> name="closed" value="1"  /></td>
                    <td class="clone1">:</td>
                    <td><label for="closed">Closed</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="online" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['online'])&&$data['access_roles'][0]['online']==1){ echo 'checked="checked"';}?>  name="online" value="1"  /></td>
                    <td class="clone1">:</td>
                    <td><label for="online">Pending</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="search" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['search'])&&$data['access_roles'][0]['search']==1){ echo 'checked="checked"';}?>  name="search" value="1"  /></td>
                    <td class="clone1">:</td>
                    <td><label for="search">Search</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="addnew" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['addnew'])&&$data['access_roles'][0]['addnew']==1){ echo 'checked="checked"';}?>  name="addnew" value="1"  /></td>
                    <td class="clone1">:</td>
                    <td><label for="addnew">Add New</label></td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="block" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['block'])&&$data['access_roles'][0]['block']==1){ echo 'checked="checked"';}?> name="block" value="1"  /></td>
                    <td class="clone1">:</td>
                    <td><label for="block">Terminated</label></td>
                  </tr>
                </table>
              </div></td>
          </tr>
          <tr>
            <td class="field tab_link3 roleList" nowrap-for-del>Sub Admin Menu:
              <input type="checkbox" id="sub_admin_menu_group" class="checkbox form-check-input group_set sub_admin_menu_group float-end" <? if(isset($data['access_roles'][0]['sub_admin_menu_group'])&&$data['access_roles'][0]['sub_admin_menu_group']==1){ echo 'checked="checked"';}?> name="sub_admin_menu_group" value="1"  /></td>
            <td class="input" nowrap-for-del><div class="tab_sl_3">
                <table class="roleList checkbox_table sub_admin_menu_group" data-checkbox="sub_admin_menu_group">
                  <tr>
                    <td><input type="checkbox" id="add_sub_admin" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['add_sub_admin'])&&$data['access_roles'][0]['add_sub_admin']==1){ echo 'checked="checked"';}?>  name="add_sub_admin" value="1"  /></td>
                    <td class="clone1">:</td>
                    <td><label for="add_sub_admin">Add Sub Admin</label>
                      <a class="subSelect" title="Checked All This"><i class="<?=$data['fwicon']['search-plus'];?> text-primary"></i></a> <a class="subUnSelect" title="Unchecked All This"><i class="<?=$data['fwicon']['search-minus'];?> text-primary"></i></a> </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="list_sub_admin" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['list_sub_admin'])&&$data['access_roles'][0]['list_sub_admin']==1){ echo 'checked="checked"';}?>  name="list_sub_admin" value="1"  /></td>
                    <td class="clone1">:</td>
                    <td><label for="list_sub_admin">List Sub Admin</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="create_roles" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['create_roles'])&&$data['access_roles'][0]['create_roles']==1){ echo 'checked="checked"';}?>  name="create_roles" value="1"  /></td>
                    <td class="clone1">:</td>
                    <td><label for="create_roles">Create Roles</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="list_of_roles" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['list_of_roles'])&&$data['access_roles'][0]['list_of_roles']==1){ echo 'checked="checked"';}?>  name="list_of_roles" value="1"  /></td>
                    <td class="clone1">:</td>
                    <td><label for="list_of_roles">List of Roles</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="gateway_assign_in_subadmin" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['gateway_assign_in_subadmin'])&&$data['access_roles'][0]['gateway_assign_in_subadmin']==1){ echo 'checked="checked"';}?> name="gateway_assign_in_subadmin" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='gateway_assign_in_subadmin'>Gateway Assign In Subadmin</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="merchant_assign_in_subadmin" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['merchant_assign_in_subadmin'])&&$data['access_roles'][0]['merchant_assign_in_subadmin']==1){ echo 'checked="checked"';}?> name="merchant_assign_in_subadmin" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='merchant_assign_in_subadmin'>Merchant Assign In Subadmin</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="update_sub_admin_self_profile" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['update_sub_admin_self_profile'])&&$data['access_roles'][0]['update_sub_admin_self_profile']==1){ echo 'checked="checked"';}?> name="update_sub_admin_self_profile" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='update_sub_admin_self_profile'>Update Sub Admin Self Profile</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="update_sub_admin_other_profile" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['update_sub_admin_other_profile'])&&$data['access_roles'][0]['update_sub_admin_other_profile']==1){ echo 'checked="checked"';}?> name="update_sub_admin_other_profile" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='update_sub_admin_other_profile'>Update Sub Admin Other Profile</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="subadmin_list_role_view" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['subadmin_list_role_view'])&&$data['access_roles'][0]['subadmin_list_role_view']==1){ echo 'checked="checked"';}?> name="subadmin_list_role_view" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='subadmin_list_role_view'>Subadmin List Role View</label>                    </td>
                  </tr>
                </table>
              </div></td>
          </tr>
          <tr>
            <td class="field tab_link3 roleList" nowrap-for-del>Templates Menu:
              <input type="checkbox" id="templates_menu_group" class="checkbox form-check-input group_set templates_menu_group float-end" <? if(isset($data['access_roles'][0]['templates_menu_group'])&&$data['access_roles'][0]['templates_menu_group']==1){ echo 'checked="checked"';}?> name="templates_menu_group" value="1"  /></td>
            <td class="input" nowrap-for-del><div class="tab_sl_3">
                <table class="roleList checkbox_table templates_menu_group" data-checkbox="templates_menu_group">
				
				  <tr><td><input type="checkbox" class="checkbox form-check-input" id="acquirer_template" <? if(isset($post['acquirer_template'])&&$post['acquirer_template']==1){ echo 'checked="checked"';}?> name="json_value[acquirer_template]" value="1" /></td>
						
						<td class="clone1">:</td>
						<td><label for="acquirer_template">Acquirer Templates</label></td></tr>
				  <tr><td><input type="checkbox" id="black_list" class="checkbox form-check-input" <? if(isset($post['black_list'])&&$post['black_list']==1){ echo 'checked="checked"';}?> name="json_value[black_list]" value="1" /></td>
						<td class="clone1">:</td>
						<td><label for="black_list">Black List</label></td></tr>	
                  <tr>
                    <td><input type="checkbox" id="e_mail_templates" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['e_mail_templates'])&&$data['access_roles'][0]['e_mail_templates']==1){ echo 'checked="checked"';}?>  name="e_mail_templates" value="1"  /></td>
                    <td class="clone1">:</td>
                    <td><label for="e_mail_templates">E-Mail Templates</label>
                      <a class="subSelect" title="Checked All This"><i class="<?=$data['fwicon']['search-plus'];?> text-primary"></i></a> <a class="subUnSelect" title="Unchecked All This"><i class="<?=$data['fwicon']['search-minus'];?> text-primary"></i></a> </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="graphical_staticstics" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['graphical_staticstics'])&&$data['access_roles'][0]['graphical_staticstics']==1){ echo 'checked="checked"';}?>  name="graphical_staticstics" value="1"  /></td>
                    <td class="clone1">:</td>
                    <td><label for="graphical_staticstics">Graphical Staticstics</label>                    </td>
                  </tr>
				  <tr>
                    <td><input type="checkbox" id="merchant_category" class="checkbox form-check-input" <? if(isset($post['merchant_category'])&&$post['merchant_category']==1){ echo 'checked="checked"';}?> name="json_value[merchant_category]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="merchant_category">Merchant Category</label>                    </td>
                  </tr>
				  <tr>
                    <td><input type="checkbox" id="mop_table" class="checkbox form-check-input" <? if(isset($post['mop_table'])&&$post['mop_table']==1){ echo 'checked="checked"';}?> name="json_value[mop_table]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="merchant_category">MOP Template</label>                    </td>
                  </tr>
				  <tr><td><input type="checkbox" class="checkbox form-check-input" id="salt_management"  <? if(isset($post['salt_management'])&&$post['salt_management']==1){ echo 'checked="checked"';}?> name="json_value[salt_management]" value="1" /></td>
						<td class="clone1">:</td>
						<td><label for="salt_management">Salt Management</label></td></tr>
				  <tr><td><input type="checkbox" class="checkbox form-check-input" id="transaction_reason"  <? if(isset($post['transaction_reason'])&&$post['transaction_reason']==1){ echo 'checked="checked"';}?> name="json_value[transaction_reason]" value="1" /></td>
						<td class="clone1">:</td>
						<td><label for="transaction_reason">Transaction Reason</label></td></tr>
			      <tr><td><input type="checkbox" class="checkbox form-check-input" id="transaction_staticstics"  <? if(isset($post['transaction_staticstics'])&&$post['transaction_staticstics']==1){ echo 'checked="checked"';}?> name="json_value[transaction_staticstics]" value="1" /></td>
						<td class="clone1">:</td>
						<td><label for="transaction_staticstics">Transaction Staticstics</label></td></tr>
				  
				  
				  
				
                </table>
              </div></td>
          </tr>
          <tr>
            <td class="field tab_link3 roleList" nowrap-for-del>Admin Menu:
              <input type="checkbox" id="admin_menu_group" class="checkbox form-check-input group_set admin_menu_group float-end" <? if(isset($data['access_roles'][0]['admin_menu_group'])&&$data['access_roles'][0]['admin_menu_group']==1){ echo 'checked="checked"';}?> name="admin_menu_group" value="1"  />            </td>
            <td class="input" nowrap-for-del><div class="tab_sl_3">
                <table class="roleList checkbox_table admin_menu_group" data-checkbox="admin_menu_group">
				
						
						
                  <tr>
                    <td><input type="checkbox" id="acquirer_table" class="checkbox form-check-input" <? if(isset($post['acquirer_table'])&&$post['acquirer_table']==1){ echo 'checked="checked"';}?>  name="json_value[acquirer_table]" value="1"  /></td>
                    <td class="clone1">:</td>
                    <td><label for="acquirer_table">Acquirer</label>
                      <a class="subSelect" title="Checked All This"><i class="<?=$data['fwicon']['search-plus'];?> text-primary"></i></a> <a class="subUnSelect" title="Unchecked All This"><i class="<?=$data['fwicon']['search-minus'];?> text-primary"></i></a> </td>
                  </tr>
				  
				  <tr><td><input type="checkbox" id="bank_table" class="checkbox form-check-input" <? if(isset($post['bank_table'])&&$post['bank_table']==1){ echo 'checked="checked"';}?> name="json_value[bank_table]" value="1" /></td>
						<td class="clone1">:</td>
						<td><label for="bank_table">Bank Table</label></td></tr>
						
						
				  
						
				  
						
						
                  <tr>
                    <td><input type="checkbox" id="change_password" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['change_password'])&&$data['access_roles'][0]['change_password']==1){ echo 'checked="checked"';}?>  name="change_password" value="1"  /></td>
                    <td class="clone1">:</td>
                    <td><label for="change_password">Change Password</label>                    </td>
                  </tr>
				  
				   <tr>
                    <td><input type="checkbox" id="glossary" class="checkbox form-check-input" <? if(isset($post['glossary'])&&$post['glossary']==1){ echo 'checked="checked"';}?> name="json_value[glossary]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='glossary'>Glossary</label>                    </td>
                  </tr>
                  
				  
                  <tr>
                    <td><input type="checkbox" id="mass_mailing" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['mass_mailing'])&&$data['access_roles'][0]['mass_mailing']==1){ echo 'checked="checked"';}?>  name="mass_mailing" value="1"  /></td>
                    <td class="clone1">:</td>
                    <td><label for="mass_mailing">Mass Mailing</label>                    </td>
                  </tr>
				  
				  <tr>
                    <td><input type="checkbox" id="admin_notification" class="checkbox form-check-input" <? if(isset($post['admin_notification'])&&$post['admin_notification']==1){ echo 'checked="checked"';}?> name="json_value[admin_notification]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="admin_notification">Notification</label>                    </td>
                  </tr>
                  
                  <tr>
                    <td><input type="checkbox" id="subadmin_pdf_report_link" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['subadmin_pdf_report_link'])&&$data['access_roles'][0]['subadmin_pdf_report_link']==1){ echo 'checked="checked"';}?> name="subadmin_pdf_report_link" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='subadmin_pdf_report_link'>Subadmin Pdf Report Link</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="subadmin_profile_link" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['subadmin_profile_link'])&&$data['access_roles'][0]['subadmin_profile_link']==1){ echo 'checked="checked"';}?> name="subadmin_profile_link" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='subadmin_profile_link'>Subadmin Profile Link</label>                    </td>
                  </tr>
				  
				  <tr>
                    <td><input type="checkbox" id="support_messages" class="checkbox form-check-input" <? if(isset($post['support_messages'])&&$post['support_messages']==1){ echo 'checked="checked"';}?> name="json_value[support_messages]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='support_messages'>Support Messages</label>                    </td>
                  </tr>
				  
				  <tr>
                    <td><input type="checkbox" id="test_mass_mailing" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['test_mass_mailing'])&&$data['access_roles'][0]['test_mass_mailing']==1){ echo 'checked="checked"';}?>  name="test_mass_mailing" value="1"  /></td>
                    <td class="clone1">:</td>
                    <td><label for="test_mass_mailing">Test Mass Mailing</label>                    </td>
                  </tr>
                  
                  <tr>
                    <td><input type="checkbox" id="useful_link" class="checkbox form-check-input" <? if(isset($post['useful_link'])&&$post['useful_link']==1){ echo 'checked="checked"';}?> name="json_value[useful_link]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='useful_link'>Useful Link</label>                    </td>
                  </tr>
                  
				  
				  
				  
                </table>
              </div></td>
          </tr>
          <tr>
            <td class="field tab_link3 roleList" nowrap-for-del>Transaction Action :
              <input type="checkbox" id="transaction_action_group" class="checkbox form-check-input group_set transaction_action_group float-end" <? if(isset($data['access_roles'][0]['transaction_action_group'])&&$data['access_roles'][0]['transaction_action_group']==1){ echo 'checked="checked"';}?> name="transaction_action_group" value="1"  /></td>
            <td class="input" nowrap-for-del><div class="tab_sl_3">
                <table class="roleList checkbox_table transaction_action_group" data-checkbox="transaction_action_group">
                  <tr>
                    <td><input type="checkbox" id="t_multiple_check_box" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['t_multiple_check_box'])&&$data['access_roles'][0]['t_multiple_check_box']==1){ echo 'checked="checked"';}?> name="t_multiple_check_box" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='t_multiple_check_box'>Multiple Check Box</label>
                      <a class="subSelect" title="Checked All This"><i class="<?=$data['fwicon']['search-plus'];?> text-primary"></i></a> <a class="subUnSelect" title="Unchecked All This"><i class="<?=$data['fwicon']['search-minus'];?> text-primary"></i></a> </td>
                  </tr>
                  <tr>
				  <? /* ?>
                  <tr>
                    <td><input type="checkbox" id="transaction_action_checkbox_completed" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['transaction_action_checkbox_completed'])&&$data['access_roles'][0]['transaction_action_checkbox_completed']==1){ echo 'checked="checked"';}?> name="transaction_action_checkbox_completed" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="transaction_action_checkbox_completed">C. Completed</label></td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="transaction_action_checkbox_settled" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['transaction_action_checkbox_settled'])&&$data['access_roles'][0]['transaction_action_checkbox_settled']==1){ echo 'checked="checked"';}?> name="transaction_action_checkbox_settled" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="transaction_action_checkbox_settled">C. Settled</label>
                    </td>
                  </tr>
				  <? */ ?>
                  <tr>
                    <td><input type="checkbox" id="transaction_action_checkbox_reminder" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['transaction_action_checkbox_reminder'])&&$data['access_roles'][0]['transaction_action_checkbox_reminder']==1){ echo 'checked="checked"';}?> name="transaction_action_checkbox_reminder" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="transaction_action_checkbox_reminder">C. Reminder</label></td>
                  </tr>
                  <tr>
                  <tr>
                    <td><input type="checkbox" id="transaction_action_checkbox_surprise" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['transaction_action_checkbox_surprise'])&&$data['access_roles'][0]['transaction_action_checkbox_surprise']==1){ echo 'checked="checked"';}?> name="transaction_action_checkbox_surprise" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="transaction_action_checkbox_surprise">C. Surprise</label></td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="transaction_action_checkbox_csv" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['transaction_action_checkbox_csv'])&&$data['access_roles'][0]['transaction_action_checkbox_csv']==1){ echo 'checked="checked"';}?> name="transaction_action_checkbox_csv" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="transaction_action_checkbox_csv">C. CSV</label></td>
                  </tr>
				  
				  <tr>
                    <td><input type="checkbox" id="csv_multiple_merchant" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['t_status_unflag'])&&isset($post['csv_multiple_merchant'])&&$post['csv_multiple_merchant']==1){ echo 'checked="checked"';}?> name="json_value[csv_multiple_merchant]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='csv_multiple_merchant'>CSV download for Multiple Merchant</label></td>
                  </tr>
				  
                  <tr>
                    <td><input type="checkbox" id="update_clients_balance" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['update_clients_balance'])&&$data['access_roles'][0]['update_clients_balance']==1){ echo 'checked="checked"';}?> name="update_clients_balance" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="update_clients_balance">Update M. Balance</label></td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="transaction_action_all" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['transaction_action_all'])&&$data['access_roles'][0]['transaction_action_all']==1){ echo 'checked="checked"';}?> name="transaction_action_all" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="transaction_action_all">Action Link</label></td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="edit_trans" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['edit_trans'])&&$data['access_roles'][0]['edit_trans']==1){ echo 'checked="checked"';}?> name="edit_trans" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="edit_trans">Edit Trans.</label></td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="t_bal_upd" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['t_bal_upd'])&&$data['access_roles'][0]['t_bal_upd']==1){ echo 'checked="checked"';}?> name="t_bal_upd" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="t_bal_upd">T.Bal.Upd.</label></td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="note_system" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['note_system'])&&$data['access_roles'][0]['note_system']==1){ echo 'checked="checked"';}?> name="note_system" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="note_system">Note System</label></td>
                  </tr>
				   <tr>
                    <td><input type="checkbox" id="json_post_view" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['json_post_view'])&&$data['access_roles'][0]['json_post_view']==1){ echo 'checked="checked"';}?> name="json_post_view" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="json_post_view">Payload Json</label></td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="txn_detail" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['txn_detail'])&&$data['access_roles'][0]['txn_detail']==1){ echo 'checked="checked"';}?> name="txn_detail" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="txn_detail">Acquier Response Json</label></td>
                  </tr>
				  <tr>
                    <td><input type="checkbox" id="decode_json_acc" class="checkbox form-check-input" <? if(isset($post['decode_json_acc'])&&$post['decode_json_acc']==1){ echo 'checked="checked"';}?> name="json_value[decode_json_acc]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="decode_json_acc">Bank Decode</label></td>
                  </tr>
				  <tr>
                    <td><input type="checkbox" id="role_push_notify" class="checkbox form-check-input" <? if(isset($post['role_push_notify'])&&$post['role_push_notify']==1){ echo 'checked="checked"';}?> name="json_value[role_push_notify]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="role_push_notify">Push Notify</label></td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="balance_adjust" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['balance_adjust'])&&$data['access_roles'][0]['balance_adjust']==1){ echo 'checked="checked"';}?> name="balance_adjust" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="balance_adjust">Balance Adjust</label></td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="transaction_payout" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['transaction_payout'])&&$data['access_roles'][0]['transaction_payout']==1){ echo 'checked="checked"';}?> name="transaction_payout" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="transaction_payout">Payout</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="search_transaction_list" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['search_transaction_list'])&&$data['access_roles'][0]['search_transaction_list']==1){ echo 'checked="checked"';}?> name="search_transaction_list" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='search_transaction_list'>Search Transaction List</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="transaction_status_update" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['transaction_status_update'])&&$data['access_roles'][0]['transaction_status_update']==1){ echo 'checked="checked"';}?> name="transaction_status_update" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='transaction_status_update'>Transaction Status Update</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="transaction_view_all" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['transaction_view_all'])&&$data['access_roles'][0]['transaction_view_all']==1){ echo 'checked="checked"';}?> name="transaction_view_all" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='transaction_view_all'>Transaction View All</label>                    </td>
                  </tr>
                  
                  <tr>
                    <td><input type="checkbox" id="t_refund_accept" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['t_refund_accept'])&&$data['access_roles'][0]['t_refund_accept']==1){ echo 'checked="checked"';}?> name="t_refund_accept" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='t_refund_accept'>Refund Accept</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="t_refund_reject" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['t_refund_reject'])&&$data['access_roles'][0]['t_refund_reject']==1){ echo 'checked="checked"';}?> name="t_refund_reject" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='t_refund_reject'>Refund Reject</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="t_withdraw_accept" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['t_withdraw_accept'])&&$data['access_roles'][0]['t_withdraw_accept']==1){ echo 'checked="checked"';}?> name="t_withdraw_accept" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='t_withdraw_accept'>Withdraw Accept</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="t_withdraw_reject" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['t_withdraw_reject'])&&$data['access_roles'][0]['t_withdraw_reject']==1){ echo 'checked="checked"';}?> name="t_withdraw_reject" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='t_withdraw_reject'>Withdraw Reject</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="t_fund_reject" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['t_fund_reject'])&&$data['access_roles'][0]['t_fund_reject']==1){ echo 'checked="checked"';}?> name="t_fund_reject" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='t_fund_reject'>Fund Reject</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="t_status_confirm" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['t_status_confirm'])&&$data['access_roles'][0]['t_status_confirm']==1){ echo 'checked="checked"';}?> name="t_status_confirm" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='t_status_confirm'>Status Confirm</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="t_status_cancel" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['t_status_cancel'])&&$data['access_roles'][0]['t_status_cancel']==1){ echo 'checked="checked"';}?> name="t_status_cancel" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='t_status_cancel'>Status Cancel</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="t_status_return" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['t_status_return'])&&$data['access_roles'][0]['t_status_return']==1){ echo 'checked="checked"';}?> name="t_status_return" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='t_status_return'>Status Return</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="t_status_chargeback" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['t_status_chargeback'])&&$data['access_roles'][0]['t_status_chargeback']==1){ echo 'checked="checked"';}?> name="t_status_chargeback" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='t_status_chargeback'>Status Chargeback</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="t_a_require" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['t_a_require'])&&$data['access_roles'][0]['t_a_require']==1){ echo 'checked="checked"';}?> name="t_a_require" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='t_a_require'>A Require</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="t_add_remark" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['t_add_remark'])&&$data['access_roles'][0]['t_add_remark']==1){ echo 'checked="checked"';}?> name="t_add_remark" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='t_add_remark'>Add Remark</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="t_cs_trans" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['t_cs_trans'])&&$data['access_roles'][0]['t_cs_trans']==1){ echo 'checked="checked"';}?> name="t_cs_trans" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='t_cs_trans'>Cs Trans</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="t_status_test" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['t_status_test'])&&$data['access_roles'][0]['t_status_test']==1){ echo 'checked="checked"';}?> name="t_status_test" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='t_status_test'>Status Test</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="t_status_refunded" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['t_status_refunded'])&&$data['access_roles'][0]['t_status_refunded']==1){ echo 'checked="checked"';}?> name="t_status_refunded" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='t_status_refunded'>Status Refunded</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="t_status_flag" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['t_status_flag'])&&$data['access_roles'][0]['t_status_flag']==1){ echo 'checked="checked"';}?> name="t_status_flag" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='t_status_flag'>Status Flag</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="t_status_unflag" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['t_status_unflag'])&&$data['access_roles'][0]['t_status_unflag']==1){ echo 'checked="checked"';}?> name="t_status_unflag" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='t_status_unflag'>Status Unflag</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="t_status_pre_dispute" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['t_status_pre_dispute'])&&$data['access_roles'][0]['t_status_pre_dispute']==1){ echo 'checked="checked"';}?> name="t_status_pre_dispute" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='t_status_pre_dispute'>Status Pre Dispute</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="t_calculation_details" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['t_calculation_details'])&&$data['access_roles'][0]['t_calculation_details']==1){ echo 'checked="checked"';}?> name="t_calculation_details" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='t_calculation_details'>Calculation Details</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="t_calculation_row" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['t_calculation_row'])&&$data['access_roles'][0]['t_calculation_row']==1){ echo 'checked="checked"';}?> name="t_calculation_row" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='t_calculation_row'>Calculation Row</label>                    </td>
                  </tr>
                  <td><input type="checkbox" id="t_acquirer_view" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['t_acquirer_view'])&&$data['access_roles'][0]['t_acquirer_view']==1){ echo 'checked="checked"';}?> name="t_acquirer_view" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='t_acquirer_view'>Acquirer View</label>                    </td>
                  </tr>
                  
                  <tr>
                    <td><input type="checkbox" id="source_url" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['t_status_unflag'])&&isset($post['source_url'])&&$post['source_url']==1){ echo 'checked="checked"';}?> name="json_value[source_url]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for='source_url'>Source Url</label>                    </td>
                  </tr>
                </table>
              </div></td>
          </tr>
          <tr>
            <td class="field tab_link3 roleList" nowrap-for-del>Acquirer :
              <input type="checkbox" id="acquirer_group" class="checkbox form-check-input group_set acquirer_group float-end" <? if(isset($data['access_roles'][0]['acquirer_group'])&&$data['access_roles'][0]['acquirer_group']==1){ echo 'checked="checked"';}?> name="acquirer_group" value="1"  /></td>
            <td class="input" nowrap-for-del><div class="tab_sl_3">
                <table class="roleList checkbox_table acquirer_group" data-checkbox="acquirer_group">
                  <tr>
                    <td><input type="checkbox" id="transaction_all_link" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['transaction_all_link'])&&$data['access_roles'][0]['transaction_all_link']==1){ echo 'checked="checked"';}?> name="transaction_all_link" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="transaction_all_link">All Transaction</label>
                      <a class="subSelect" title="Checked All This"><i class="<?=$data['fwicon']['search-plus'];?> text-primary"></i></a> <a class="subUnSelect" title="Unchecked All This"><i class="<?=$data['fwicon']['search-minus'];?> text-primary"></i></a></td>
                  </tr>
 <?
 $i=$sum = 0;
 
 foreach($data['acquirer_list'] as $key=>$value ){
	$i++;
	$sum = $sum + $i; if(!in_array($key,$data['remove_t'])){ ?>
                  <tr>
                    <td><input type="checkbox" id="acquirer_<?=$key;?>" class="checkbox form-check-input" <? if(isset($data['json_value'])&&is_array($data['json_value']) && array_key_exists('acquirer_'.$key, $data['json_value'])){ echo 'checked="checked"';}?> name="json_value[acquirer_<?=$key;?>]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td title="<?=$value;?>"><label for="acquirer_<?=$key;?>">
						<?=$value;?>
                  </label></td>
                  </tr>
                  <? } } ?>
                </table>
              </div>
              <table style="display:none">
                <tr>
                  <td><input type="checkbox" id="custom_field_11" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_11'])&&$data['access_roles'][0]['custom_field_11']==1){ echo 'checked="checked"';}?> name="custom_field_11" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_11'>Custom Field 11</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_12" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_12'])&&$data['access_roles'][0]['custom_field_12']==1){ echo 'checked="checked"';}?> name="custom_field_12" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_12'>Custom Field 12</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_13" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_13'])&&$data['access_roles'][0]['custom_field_13']==1){ echo 'checked="checked"';}?> name="custom_field_13" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_13'>Custom Field 13</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_14" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_14'])&&$data['access_roles'][0]['custom_field_14']==1){ echo 'checked="checked"';}?> name="custom_field_14" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_14'>Custom Field 14</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_15" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_15'])&&$data['access_roles'][0]['custom_field_15']==1){ echo 'checked="checked"';}?> name="custom_field_15" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_15'>Custom Field 15</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_16" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_16'])&&$data['access_roles'][0]['custom_field_16']==1){ echo 'checked="checked"';}?> name="custom_field_16" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_16'>Custom Field 16</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_17" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_17'])&&$data['access_roles'][0]['custom_field_17']==1){ echo 'checked="checked"';}?> name="custom_field_17" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_17'>Custom Field 17</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_18" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_18'])&&$data['access_roles'][0]['custom_field_18']==1){ echo 'checked="checked"';}?> name="custom_field_18" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_18'>Custom Field 18</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_19" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_19'])&&$data['access_roles'][0]['custom_field_19']==1){ echo 'checked="checked"';}?> name="custom_field_19" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_19'>Custom Field 19</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_20" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_20'])&&$data['access_roles'][0]['custom_field_20']==1){ echo 'checked="checked"';}?> name="custom_field_20" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_20'>Custom Field 20</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_21" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_21'])&&$data['access_roles'][0]['custom_field_21']==1){ echo 'checked="checked"';}?> name="custom_field_21" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_21'>Custom Field 21</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_22" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_22'])&&$data['access_roles'][0]['custom_field_22']==1){ echo 'checked="checked"';}?> name="custom_field_22" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_22'>Custom Field 22</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_23" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_23'])&&$data['access_roles'][0]['custom_field_23']==1){ echo 'checked="checked"';}?> name="custom_field_23" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_23'>Custom Field 23</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_24" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_24'])&&$data['access_roles'][0]['custom_field_24']==1){ echo 'checked="checked"';}?> name="custom_field_24" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_24'>Custom Field 24</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_25" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_25'])&&$data['access_roles'][0]['custom_field_25']==1){ echo 'checked="checked"';}?> name="custom_field_25" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_25'>Custom Field 25</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_26" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_26'])&&$data['access_roles'][0]['custom_field_26']==1){ echo 'checked="checked"';}?> name="custom_field_26" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_26'>Custom Field 26</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_27" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_27'])&&$data['access_roles'][0]['custom_field_27']==1){ echo 'checked="checked"';}?> name="custom_field_27" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_27'>Custom Field 27</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_28" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_28'])&&$data['access_roles'][0]['custom_field_28']==1){ echo 'checked="checked"';}?> name="custom_field_28" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_28'>Custom Field 28</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_29" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_29'])&&$data['access_roles'][0]['custom_field_29']==1){ echo 'checked="checked"';}?> name="custom_field_29" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_29'>Custom Field 29</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_30" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_30'])&&$data['access_roles'][0]['custom_field_30']==1){ echo 'checked="checked"';}?> name="custom_field_30" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_30'>Custom Field 30</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_31" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_31'])&&$data['access_roles'][0]['custom_field_31']==1){ echo 'checked="checked"';}?> name="custom_field_31" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_31'>Custom Field 31</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_32" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_32'])&&$data['access_roles'][0]['custom_field_32']==1){ echo 'checked="checked"';}?> name="custom_field_32" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_32'>Custom Field 32</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_33" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_33'])&&$data['access_roles'][0]['custom_field_33']==1){ echo 'checked="checked"';}?> name="custom_field_33" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_33'>Custom Field 33</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_34" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_34'])&&$data['access_roles'][0]['custom_field_34']==1){ echo 'checked="checked"';}?> name="custom_field_34" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_34'>Custom Field 34</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_35" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_35'])&&$data['access_roles'][0]['custom_field_35']==1){ echo 'checked="checked"';}?> name="custom_field_35" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_35'>Custom Field 35</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_36" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_36'])&&$data['access_roles'][0]['custom_field_36']==1){ echo 'checked="checked"';}?> name="custom_field_36" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_36'>Custom Field 36</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_37" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_37'])&&$data['access_roles'][0]['custom_field_37']==1){ echo 'checked="checked"';}?> name="custom_field_37" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_37'>Custom Field 37</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_38" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_38'])&&$data['access_roles'][0]['custom_field_38']==1){ echo 'checked="checked"';}?> name="custom_field_38" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_38'>Custom Field 38</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_39" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_39'])&&$data['access_roles'][0]['custom_field_39']==1){ echo 'checked="checked"';}?> name="custom_field_39" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_39'>Custom Field 39</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_40" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_40'])&&$data['access_roles'][0]['custom_field_40']==1){ echo 'checked="checked"';}?> name="custom_field_40" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_40'>Custom Field 40</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_41" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_41'])&&$data['access_roles'][0]['custom_field_41']==1){ echo 'checked="checked"';}?> name="custom_field_41" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_41'>Custom Field 41</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_42" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_42'])&&$data['access_roles'][0]['custom_field_42']==1){ echo 'checked="checked"';}?> name="custom_field_42" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_42'>Custom Field 42</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_43" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_43'])&&$data['access_roles'][0]['custom_field_43']==1){ echo 'checked="checked"';}?> name="custom_field_43" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_43'>Custom Field 43</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_44" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_44'])&&$data['access_roles'][0]['custom_field_44']==1){ echo 'checked="checked"';}?> name="custom_field_44" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_44'>Custom Field 44</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_45" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_45'])&&$data['access_roles'][0]['custom_field_45']==1){ echo 'checked="checked"';}?> name="custom_field_45" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_45'>Custom Field 45</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_46" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_46'])&&$data['access_roles'][0]['custom_field_46']==1){ echo 'checked="checked"';}?> name="custom_field_46" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_46'>Custom Field 46</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_47" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_47'])&&$data['access_roles'][0]['custom_field_47']==1){ echo 'checked="checked"';}?> name="custom_field_47" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_47'>Custom Field 47</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_48" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_48'])&&$data['access_roles'][0]['custom_field_48']==1){ echo 'checked="checked"';}?> name="custom_field_48" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_48'>Custom Field 48</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_49" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_49'])&&$data['access_roles'][0]['custom_field_49']==1){ echo 'checked="checked"';}?> name="custom_field_49" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_49'>Custom Field 49</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_50" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_50'])&&$data['access_roles'][0]['custom_field_50']==1){ echo 'checked="checked"';}?> name="custom_field_50" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_50'>Custom Field 50</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_51" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_51'])&&$data['access_roles'][0]['custom_field_51']==1){ echo 'checked="checked"';}?> name="custom_field_51" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_51'>Custom Field 51</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_52" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_52'])&&$data['access_roles'][0]['custom_field_52']==1){ echo 'checked="checked"';}?> name="custom_field_52" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_52'>Custom Field 52</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_53" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_53'])&&$data['access_roles'][0]['custom_field_53']==1){ echo 'checked="checked"';}?> name="custom_field_53" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_53'>Custom Field 53</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_54" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_54'])&&$data['access_roles'][0]['custom_field_54']==1){ echo 'checked="checked"';}?> name="custom_field_54" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_54'>Custom Field 54</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_55" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_55'])&&$data['access_roles'][0]['custom_field_55']==1){ echo 'checked="checked"';}?> name="custom_field_55" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_55'>Custom Field 55</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_56" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_56'])&&$data['access_roles'][0]['custom_field_56']==1){ echo 'checked="checked"';}?> name="custom_field_56" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_56'>Custom Field 56</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_57" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_57'])&&$data['access_roles'][0]['custom_field_57']==1){ echo 'checked="checked"';}?> name="custom_field_57" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_57'>Custom Field 57</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_58" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_58'])&&$data['access_roles'][0]['custom_field_58']==1){ echo 'checked="checked"';}?> name="custom_field_58" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_58'>Custom Field 58</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_59" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_59'])&&$data['access_roles'][0]['custom_field_59']==1){ echo 'checked="checked"';}?> name="custom_field_59" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_59'>Custom Field 59</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_60" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_60'])&&$data['access_roles'][0]['custom_field_60']==1){ echo 'checked="checked"';}?> name="custom_field_60" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_60'>Custom Field 60</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_61" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_61'])&&$data['access_roles'][0]['custom_field_61']==1){ echo 'checked="checked"';}?> name="custom_field_61" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_61'>Custom Field 61</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_62" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_62'])&&$data['access_roles'][0]['custom_field_62']==1){ echo 'checked="checked"';}?> name="custom_field_62" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_62'>Custom Field 62</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_63" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_63'])&&$data['access_roles'][0]['custom_field_63']==1){ echo 'checked="checked"';}?> name="custom_field_63" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_63'>Custom Field 63</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_64" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_64'])&&$data['access_roles'][0]['custom_field_64']==1){ echo 'checked="checked"';}?> name="custom_field_64" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_64'>Custom Field 64</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_65" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_65'])&&$data['access_roles'][0]['custom_field_65']==1){ echo 'checked="checked"';}?> name="custom_field_65" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_65'>Custom Field 65</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_66" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_66'])&&$data['access_roles'][0]['custom_field_66']==1){ echo 'checked="checked"';}?> name="custom_field_66" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_66'>Custom Field 66</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_67" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_67'])&&$data['access_roles'][0]['custom_field_67']==1){ echo 'checked="checked"';}?> name="custom_field_67" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_67'>Custom Field 67</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_68" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_68'])&&$data['access_roles'][0]['custom_field_68']==1){ echo 'checked="checked"';}?> name="custom_field_68" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_68'>Custom Field 68</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_69" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_69'])&&$data['access_roles'][0]['custom_field_69']==1){ echo 'checked="checked"';}?> name="custom_field_69" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_69'>Custom Field 69</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_70" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_70'])&&$data['access_roles'][0]['custom_field_70']==1){ echo 'checked="checked"';}?> name="custom_field_70" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_70'>Custom Field 70</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_71" class="checkbox form-check-input" <? if(isset($data['access_roles'][0]['custom_field_71'])&&$data['access_roles'][0]['custom_field_71']==1){ echo 'checked="checked"';}?> name="custom_field_71" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_71'>Custom Field 71</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_72" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_72'])&&$data['access_roles'][0]['custom_field_72']==1){ echo 'checked="checked"';}?> name="custom_field_72" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_72'>Custom Field 72</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_73" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_73'])&&$data['access_roles'][0]['custom_field_73']==1){ echo 'checked="checked"';}?> name="custom_field_73" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_73'>Custom Field 73</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_74" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_74'])&&$data['access_roles'][0]['custom_field_74']==1){ echo 'checked="checked"';}?> name="custom_field_74" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_74'>Custom Field 74</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_75" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_75'])&&$data['access_roles'][0]['custom_field_75']==1){ echo 'checked="checked"';}?> name="custom_field_75" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_75'>Custom Field 75</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_76" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_76'])&&$data['access_roles'][0]['custom_field_76']==1){ echo 'checked="checked"';}?> name="custom_field_76" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_76'>Custom Field 76</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_77" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_77'])&&$data['access_roles'][0]['custom_field_77']==1){ echo 'checked="checked"';}?> name="custom_field_77" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_77'>Custom Field 77</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_78" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_78'])&&$data['access_roles'][0]['custom_field_78']==1){ echo 'checked="checked"';}?> name="custom_field_78" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_78'>Custom Field 78</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_79" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_79'])&&$data['access_roles'][0]['custom_field_79']==1){ echo 'checked="checked"';}?> name="custom_field_79" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_79'>Custom Field 79</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_80" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_80'])&&$data['access_roles'][0]['custom_field_80']==1){ echo 'checked="checked"';}?> name="custom_field_80" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_80'>Custom Field 80</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_81" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_81'])&&$data['access_roles'][0]['custom_field_81']==1){ echo 'checked="checked"';}?> name="custom_field_81" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_81'>Custom Field 81</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_82" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_82'])&&$data['access_roles'][0]['custom_field_82']==1){ echo 'checked="checked"';}?> name="custom_field_82" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_82'>Custom Field 82</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_83" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_83'])&&$data['access_roles'][0]['custom_field_83']==1){ echo 'checked="checked"';}?> name="custom_field_83" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_83'>Custom Field 83</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_84" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_84'])&&$data['access_roles'][0]['custom_field_84']==1){ echo 'checked="checked"';}?> name="custom_field_84" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_84'>Custom Field 84</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_85" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_85'])&&$data['access_roles'][0]['custom_field_85']==1){ echo 'checked="checked"';}?> name="custom_field_85" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_85'>Custom Field 85</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_86" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_86'])&&$data['access_roles'][0]['custom_field_86']==1){ echo 'checked="checked"';}?> name="custom_field_86" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_86'>Custom Field 86</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_87" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_87'])&&$data['access_roles'][0]['custom_field_87']==1){ echo 'checked="checked"';}?> name="custom_field_87" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_87'>Custom Field 87</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_88" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_88'])&&$data['access_roles'][0]['custom_field_88']==1){ echo 'checked="checked"';}?> name="custom_field_88" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_88'>Custom Field 88</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_89" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_89'])&&$data['access_roles'][0]['custom_field_89']==1){ echo 'checked="checked"';}?> name="custom_field_89" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_89'>Custom Field 89</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_90" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_90'])&&$data['access_roles'][0]['custom_field_90']==1){ echo 'checked="checked"';}?> name="custom_field_90" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_90'>Custom Field 90</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_91" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_91'])&&$data['access_roles'][0]['custom_field_91']==1){ echo 'checked="checked"';}?> name="custom_field_91" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_91'>Custom Field 91</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_92" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_92'])&&$data['access_roles'][0]['custom_field_92']==1){ echo 'checked="checked"';}?> name="custom_field_92" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_92'>Custom Field 92</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_93" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_93'])&&$data['access_roles'][0]['custom_field_93']==1){ echo 'checked="checked"';}?> name="custom_field_93" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_93'>Custom Field 93</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_94" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_94'])&&$data['access_roles'][0]['custom_field_94']==1){ echo 'checked="checked"';}?> name="custom_field_94" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_94'>Custom Field 94</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_95" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_95'])&&$data['access_roles'][0]['custom_field_95']==1){ echo 'checked="checked"';}?> name="custom_field_95" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_95'>Custom Field 95</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_96" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_96'])&&$data['access_roles'][0]['custom_field_96']==1){ echo 'checked="checked"';}?> name="custom_field_96" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_96'>Custom Field 96</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_97" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_97'])&&$data['access_roles'][0]['custom_field_97']==1){ echo 'checked="checked"';}?> name="custom_field_97" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_97'>Custom Field 97</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_98" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_98'])&&$data['access_roles'][0]['custom_field_98']==1){ echo 'checked="checked"';}?> name="custom_field_98" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_98'>Custom Field 98</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_99" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_99'])&&$data['access_roles'][0]['custom_field_99']==1){ echo 'checked="checked"';}?> name="custom_field_99" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_99'>Custom Field 99</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_100" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_100'])&&$data['access_roles'][0]['custom_field_100']==1){ echo 'checked="checked"';}?> name="custom_field_100" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_100'>Custom Field 100</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_101" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_101'])&&$data['access_roles'][0]['custom_field_101']==1){ echo 'checked="checked"';}?> name="custom_field_101" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_101'>Custom Field 101</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_102" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_102'])&&$data['access_roles'][0]['custom_field_102']==1){ echo 'checked="checked"';}?> name="custom_field_102" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_102'>Custom Field 102</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_103" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_103'])&&$data['access_roles'][0]['custom_field_103']==1){ echo 'checked="checked"';}?> name="custom_field_103" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_103'>Custom Field 103</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_104" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_104'])&&$data['access_roles'][0]['custom_field_104']==1){ echo 'checked="checked"';}?> name="custom_field_104" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_104'>Custom Field 104</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_105" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_105'])&&$data['access_roles'][0]['custom_field_105']==1){ echo 'checked="checked"';}?> name="custom_field_105" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_105'>Custom Field 105</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_106" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_106'])&&$data['access_roles'][0]['custom_field_106']==1){ echo 'checked="checked"';}?> name="custom_field_106" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_106'>Custom Field 106</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_107" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_107'])&&$data['access_roles'][0]['custom_field_107']==1){ echo 'checked="checked"';}?> name="custom_field_107" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_107'>Custom Field 107</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_108" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_108'])&&$data['access_roles'][0]['custom_field_108']==1){ echo 'checked="checked"';}?> name="custom_field_108" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_108'>Custom Field 108</label>                  </td>
                </tr>
                <tr>
                  <td><input type="checkbox" id="custom_field_109" class="checkbox form-check-input" <?  if(isset($data['access_roles'][0]['custom_field_109'])&&$data['access_roles'][0]['custom_field_109']==1){ echo 'checked="checked"';}?> name="custom_field_109" value="1" /></td>
                  <td class="clone1">:</td>
                  <td><label for='custom_field_109'>Custom Field 109</label>                  </td>
                </tr>
              </table></td>
          </tr>
          <tr>
		  
		  <!--//////////////Pending from here////////////////-->
            <td class="field tab_link3 roleList" nowrap nowrap-for-del>Transaction Display Option :
              <input type="checkbox" id="transaction_search_data_group" class="checkbox form-check-input group_set transaction_search_data_group float-end" <? if(isset($data['access_roles'][0]['transaction_search_data_group'])&&$data['access_roles'][0]['transaction_search_data_group']==1){ echo 'checked="checked"';}?> name="transaction_search_data_group" value="1"  /></td>
            <td class="input" nowrap-for-del><div class="tab_sl_3">
                <table class="roleList checkbox_table transaction_search_data_group" data-checkbox="transaction_search_data_group">
 
				  <? 
				  asort($data['trnslist_listorder']);
				  foreach($data['trnslist_listorder'] as $key => $val) { ?>
                  <tr>
                    <td><input type="checkbox" id="tr_<?=$key;?>" class="checkbox form-check-input" <? if(isset($post["tr_{$key}"])&&$post["tr_{$key}"]==1){ echo 'checked="checked"';}?> name="json_value[tr_<?=$key;?>]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="tr_<?=$key;?>"><?=$val;?></label>
					<? if($key=="acquirer"){?>
	<a class="subSelect" title="Checked All This"><i class="<?=$data['fwicon']['search-plus'];?> text-primary"></i></a> 
	<a class="subUnSelect" title="Unchecked All This"><i class="<?=$data['fwicon']['search-minus'];?> text-primary"></i></a>
					<? }?>
					
                      </td>
                  </tr>
                  <? } ?>

                </table>
              </div></td>
          </tr>
          <tr>
            <td class="field tab_link3 roleList" nowrap-for-del>Salt Management :
              <input type="checkbox" id="salt_management_group" class="checkbox form-check-input group_set salt_management_group float-end" <? if(isset($data['access_roles'][0]['salt_management_group'])&&$data['access_roles'][0]['salt_management_group']==1){ echo 'checked="checked"';}?> name="salt_management_group" value="1"  /></td>
            <td class="input" nowrap-for-del><div class="tab_sl_3">
                <table class="roleList checkbox_table salt_management_group" data-checkbox="salt_management_group">
                  <tr>
                    <td><input type="checkbox" id="salt_management1" class="checkbox form-check-input" <? if(isset($post['salt_management'])&&$post['salt_management']==1){ echo 'checked="checked"';}?> name="json_value[salt_management]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="salt_management1">Salt Management Link in Admin</label>
                      <a class="subSelect" title="Checked All This"><i class="<?=$data['fwicon']['search-plus'];?> text-primary"></i></a> <a class="subUnSelect" title="Unchecked All This"><i class="<?=$data['fwicon']['search-minus'];?> text-primary"></i></a> </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="add_new_salt" class="checkbox form-check-input" <? if(isset($post['add_new_salt'])&&$post['add_new_salt']==1){ echo 'checked="checked"';}?> name="json_value[add_new_salt]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="add_new_salt">Add New Salt</label>                    </td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="edit_salt" class="checkbox form-check-input" <? if(isset($post['edit_salt'])&&$post['edit_salt']==1){ echo 'checked="checked"';}?> name="json_value[edit_salt]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="edit_salt">Edit Salt</label></td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="parameter_edit_salt" class="checkbox form-check-input" <? if(isset($post['parameter_edit_salt'])&&$post['parameter_edit_salt']==1){ echo 'checked="checked"';}?> name="json_value[parameter_edit_salt]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="parameter_edit_salt">Parameter Edit Salt</label></td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="delete_salt" class="checkbox form-check-input" <? if(isset($post['delete_salt'])&&$post['delete_salt']==1){ echo 'checked="checked"';}?> name="json_value[delete_salt]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="delete_salt">Delete Salt</label></td>
                  </tr>
                  <tr>
                    <td><input type="checkbox" id="add_listed_salt_in_acquirer" class="checkbox form-check-input" <? if(isset($post['add_listed_salt_in_acquirer'])&&$post['add_listed_salt_in_acquirer']==1){ echo 'checked="checked"';}?> name="json_value[add_listed_salt_in_acquirer]" value="1" /></td>
                    <td class="clone1">:</td>
                    <td><label for="add_listed_salt_in_acquirer">Add Listed Salt in Acquirer</label></td>
                  </tr>
                </table>
              </div></td>
          </tr>

		<tr><td class="field tab_link3 roleList" nowrap-for-del>Payout Management :
				<input type="checkbox" id="payout_management_group" class="checkbox form-check-input group_set payout_management_group float-end" <? if(isset($data['access_roles'][0]['payout_management_group'])&&$data['access_roles'][0]['payout_management_group']==1){ echo 'checked="checked"';}?> name="payout_management_group" value="1" /></td>
			<td class="input" nowrap-for-del><div class="tab_sl_3">
				<table class="roleList checkbox_table payout_management_group" data-checkbox="payout_management_group">
				<tr><td><input type="checkbox" id="payout_gateway_admin" class="checkbox form-check-input" <? if(isset($post['payout_gateway_admin'])&&$post['payout_gateway_admin']==1){ echo 'checked="checked"';}?> name="json_value[payout_gateway_admin]" value="1" /></td>
						<td class="clone1">:</td>
						<td><label for="payout_gateway_admin"> Payout Gateway Link</label></td></tr>
					<?php /*?><tr><td><input type="checkbox" id="addbeneficiary" class="checkbox form-check-input" <? if(isset($post['addbeneficiary'])&&$post['addbeneficiary']==1){ echo 'checked="checked"';}?> name="json_value[addbeneficiary]" value="1" /></td>
						<td class="clone1">:</td>
						<td><label for="addbeneficiary">Add Beneficiary</label>
							<a class="subSelect" title="Checked All This"><i class="<?=$data['fwicon']['search-plus'];?>"></i></a> <a class="btn btn-primary subUnSelect" title="Unchecked All This"><i class="<?=$data['fwicon']['search-minus'];?>"></i></a></td></tr>
					<tr><td><input type="checkbox" id="upload_fund" class="checkbox form-check-input" <? if(isset($post['upload_fund'])&&$post['upload_fund']==1){ echo 'checked="checked"';}?> name="json_value[upload_fund]" value="1" /></td>
						<td class="clone1">:</td>
						<td><label for="upload_fund">Upload Fund</label></td></tr><?php */?>
					<tr><td><input type="checkbox" id="payout_transaction" class="checkbox form-check-input" <? if(isset($post['payout_transaction'])&&$post['payout_transaction']==1){ echo 'checked="checked"';}?> name="json_value[payout_transaction]" value="1" /></td>
						<td class="clone1">:</td>
						<td><label for="payout_transaction">All Transaction</label></td></tr>
					<tr><td><input type="checkbox" id="payout_statement" class="checkbox form-check-input" <? if(isset($post['payout_statement'])&&$post['payout_statement']==1){ echo 'checked="checked"';}?> name="json_value[payout_statement]" value="1" /></td>
						<td class="clone1">:</td>
						<td><label for="payout_statement">Payout Statement</label></td></tr>
					<tr><td><input type="checkbox" id="beneficiary_list" class="checkbox form-check-input" <? if(isset($post['beneficiary_list'])&&$post['beneficiary_list']==1){ echo 'checked="checked"';}?> name="json_value[beneficiary_list]" value="1" /></td>
						<td class="clone1">:</td>
						<td><label for="beneficiary_list">Beneficiary List</label></td></tr>
					<tr><td><input type="checkbox" id="live_merchant" class="checkbox form-check-input" <? if(isset($post['live_merchant'])&&$post['live_merchant']==1){ echo 'checked="checked"';}?> name="json_value[live_merchant]" value="1" /></td>
						<td class="clone1">:</td>
						<td><label for="live_merchant">Merchant Live</label></td></tr>
					<tr><td><input type="checkbox" id="test_merchant" class="checkbox form-check-input" <? if(isset($post['test_merchant'])&&$post['test_merchant']==1){ echo 'checked="checked"';}?> name="json_value[test_merchant]" value="1" /></td>
						<td class="clone1">:</td>
						<td><label for="test_merchant">Merchant Test</label></td></tr>
					<tr><td><input type="checkbox" id="inactive_merchant" class="checkbox form-check-input" <? if(isset($post['inactive_merchant'])&&$post['inactive_merchant']==1){ echo 'checked="checked"';}?> name="json_value[inactive_merchant]" value="1" /></td>
						<td class="clone1">:</td>
						<td><label for="inactive_merchant">Merchant Inactive</label></td></tr>
					<tr><td><input type="checkbox" id="show_payout_request" class="checkbox form-check-input" <? if(isset($post['show_payout_request'])&&$post['show_payout_request']==1){ echo 'checked="checked"';}?> name="json_value[show_payout_request]" value="1" /></td>
						<td class="clone1">:</td>
						<td><label for="show_payout_request">Payout Request</label></td></tr>

					<tr><td><input type="checkbox" id="show_payout_fee" class="checkbox form-check-input" <? if(isset($post['show_payout_fee'])&&$post['show_payout_fee']==1){ echo 'checked="checked"';}?> name="json_value[show_payout_fee]" value="1" /></td>
						<td class="clone1">:</td>
						<td><label for="show_payout_fee">Payout Fee</label></td></tr>

					<tr><td><input type="checkbox" id="show_payout_account" class="checkbox form-check-input" <? if(isset($post['show_payout_account'])&&$post['show_payout_account']==1){ echo 'checked="checked"';}?> name="json_value[show_payout_account]" value="1" /></td>
						<td class="clone1">:</td>
						<td><label for="show_payout_account">Payout A/C</label></td></tr>

					<tr><td><input type="checkbox" id="show_payout_keys" class="checkbox form-check-input" <? if(isset($post['show_payout_keys'])&&$post['show_payout_keys']==1){ echo 'checked="checked"';}?> name="json_value[show_payout_keys]" value="1" /></td>
						<td class="clone1">:</td>
						<td><label for="show_payout_keys">Payout Keys</label></td></tr>
				</table>
			</div></td></tr>
			<tr><td title="Role Description" class="input" nowrap-for-del colspan="2"><textarea id="role_description" name="role_description" class="form-control"><? if(isset($data['access_roles'][0]['role_description'])) echo $data['access_roles'][0]['role_description'];?></textarea></td></tr>
			<tr><td colspan=2 ><div class="py-2"><button class="submit btn btn-primary" type="submit" name="send" value="Submit"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Submit</button>
				<a href="<?=$data['Admins'];?>/listroles<?=$data['ex'];?>" class="btn btn-primary"><i class="<?=$data['fwicon']['back'];?>"></i> Back</a></div> </td></tr>
			</table>
		</form>
		</div>
	</div>
  <? } ?>
</div>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
