<? if(isset($data['ScriptLoaded'])){?>

<div class="row border vkg rounded mx-0 my-1">

<? if(isset($_SESSION['roleupdstatus'])&&$_SESSION['roleupdstatus']){ ?>
<div class="px-2">
<div class="alert alert-success alert-dismissible fade show my-2" role="alert">
  <strong>Success!</strong> <?=$_SESSION['roleupdstatus'];?>
  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
</div>
<? unset($_SESSION['roleupdstatus']); } ?>

<div class="container vkg px-0">
<h4 class="m-2"><i class="<?=$data['fwicon']['role-list'];?>"></i> Roles List <a data-ihref="<?=$data['Admins']?>/json_log_all<?=$data['ex']?>?tablename=access_roles" title="View Json Log History" onclick="iframe_open_modal(this);"><i class="<?=$data['fwicon']['circle-info'];?> text-danger fa-fw"></i></a></h4>
</div>

<?
	if(!$_SESSION['login_adm']&&!$_SESSION['subadmin_list_role_view']){
		echo $data['OppsAdmin'];
		exit;
	}
?>
<? if($post['action']=='select'){?>
<div class="tbl_exl td_relative my-2" style="overflow: auto;float: left; width:90vw;"><!--width:100%;-->

<?
 $c=1;
 foreach($data['acquirer_list'] as $key1=>$value1 ){
	if((int)$value1>0){$c++;?>
	
 <? }}?>


<table id="content_tab" width="100%" border="0" cellspacing="1" cellpadding="0">
	<thead>
	<tr>
      <th rowspan="2">Role Name</th>
      <th colspan="3" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Merchant Access">Merchant Access</th>
      <th colspan="3" class="thbold" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Sub-Admin Access">Sub Admin Access</th>
      <th rowspan="2" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Search Header">Search Header </th>
      <th rowspan="2" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Email Menu">Email Menu</th>
      <th colspan="24" class="thbold" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Merchant Action">Merchant Action</th>
      <th colspan="7" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Merchant Menu">Merchant Menu</th>
      <th colspan="9" class="thbold" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Sub Admin Menu">Sub Admin Menu </th>
      <th colspan="9" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Templates Menu">Templates Menu</th>
      <th colspan="11" class="thbold" data-bs-toggle="tooltip" data-bs-placement="bottom" title="">Admin Menu</th>
      <th colspan="36" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Transaction Action">Transaction Action </th>
	  <th colspan="<?=$c;?>" class="thbold" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Acquirer">Acquirer </th>
	  <th rowspan="2" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Action">Action</th>
    </tr>
	
	<tr>
      <th>All</th>
	
      <th>Multiple</th>
      <th>Individual</th>
      <th>All</th>
      <th>Multiple</th>
      <th>Individual</th>
      <th>View</th>
      <th>Edit</th>
      <th>Login</th>
	  <th>Password-Reset</th>
	  <th>M.Edit</th>
	  <th>SPOC Information  </th>
	  <th>Business  </th>
	  <th>Acquirer </th>
	  <th>Add Associate in Acquirer</th>
	  <th>Status Action</th>
	  <th>Bank Account</th>
	  
<th>Merchant Store View</th>
<th>Merchant Gp View Id</th>
<th>Merchant Risk Ratio Bar</th>
<th>Merchant Total Transaction</th>
<th>Merchant Current Balance</th>
<th>Merchant Two Way Authentication</th>
<th>Merchant Add Email</th>
<th>Merchant Profile Status Approve</th>
<th>Merchant U. Document View</th>
<th>Merchant Ip History</th>
<th>Merchant Bank Edit Permission</th>
<th>Merchant Bank Add Edit</th>
<th>Merchant Acquirer Add Edit</th>
	  <th>Active</th>
      <th>Suspended</th>
      <th>Closed</th>
      <th>Pending</th>
      <th>Search</th>
      <th>Add new</th>
      <th>Terminated</th>
      <th>Add Sub Admin </th>
      <th>List Sub Admin</th>
      <th>Create Roles</th>
      <th>List of Roles</th>
	  
	  	<th>Gateway Assign In Subadmin</th>
		<th>Merchant Assign In Subadmin</th>
		<th>Update Sub Admin Self Profile</th>
		<th>Update Sub Admin Other Profile</th>
		<th>Subadmin List Role View</th>
	  
        <th>Acquirer Templates</th>
        <th>Black List</th>
        <th>E-Mail Templates</th>
      <th>Graphical Staticstics</th>
      <th>Merchant Category</th>
      <th>MOP Template</th>
      <th>Salt Management</th>
      <th>Transaction Reason</th>
      <th>Transaction Staticstics</th>
      <th>Acquirer</th>
      <th>Bank Table</th>
      <th>Change Password</th>
      <th>Glossary</th>
      <th>Mass Mailing</th>
      <th>Test Mass Mailing</th>
	  	<th>Subadmin Pdf Report Link</th>
		<th>Subadmin Profile Link</th>
		<th>Useful Link</th>
		<th>Notification</th>
        <th>Support Messages</th>
        <th>C. Reminder</th>
      <th>C. Surprise</th>
      <th>C. CSV</th>
      <th>Update M. Balance </th>
      <th>Action Link </th>
      <th>Edit Trans.</th>
      <th>T.Bal.Upd.</th>
      <th>Note System</th>
      <th>Txn Detail</th>
      <th>Json P. View</th>
      <th>Balance Adjust</th>
      <th>Payout </th>
	  
	  <th>Search Transaction List</th>
<th>Transaction Status Update</th>
<th>Transaction View All</th>
<th>T Refund Accept</th>
<th>T Refund Reject</th>
<th>T Withdraw Accept</th>
<th>T Withdraw Reject</th>
<th>T Fund Reject</th>
<th>T Status Confirm</th>
<th>T Status Cancel</th>
<th>T Status Return</th>
<th>T Status Chargeback</th>
<th>T A Require</th>
<th>T Add Remark</th>
<th>T Cs Trans</th>
<th>T Status Test</th>
<th>T Status Refunded</th>
<th>T Status Flag</th>
<th>T Status Unflag</th>
<th>T Status Pre Dispute</th>
<th>T Calculation Details</th>
<th>T Calculation Row</th>
<th>T Multiple Check Box</th>
<th>T Acquirer View</th>
<th>All Transaction </th>
	  
	  
<?
	foreach($data['acquirer_list'] as $key1=>$value1 ){
	?>
		<th data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value1;?>" ><b style="color:#ea6100;"><?=$value1;?></b>&nbsp; </th>
	 
 <? }?>
    </tr>
	</thead>
    <tbody>
    <? foreach($data['roles'] as $key=>$value){
		 //json_value
		$json_value=jsondecode($value['json_value']);
	?>
	
    <tr class="role_data_row">
     <td align="center" valign="top" class="rolesname_data" ><?=$value['rolesname']?>
		<? if($_SESSION['login_adm']){?>
		  <div class="roleActionDiv float-end">
			<a class="edit" href="<?=$data['Admins'];?>/roles<?=$data['ex']?>?id=<?=$value['id']?>&action=update"><i class="<?=$data['fwicon']['edit'];?> text-success" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Edit"></i></a>		  </div>
		<? } ?>	 </td>
      <td valign="top" align="center" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | All"><? if($value['merchant_access_all']){?>
        <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
        -
        <? } ?></td>
      <td valign="top" align="center" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Multiple"><? if($value['merchant_access_multiple']){?>
        <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
        -
        <? } ?></td>
      <td valign="top" align="center" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Individual"><? if($value['merchant_access_individual']){?>
        <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
        -
        <? } ?></td>
      <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | All"><? if($value['subadmin_access_all']){?>
          <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
          <? }else{ ?>
        -
  <? } ?></td>
      <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Multiple"><? if($value['subadmin_access_multiple']){?>
          <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
          <? }else{ ?>
        -
  <? } ?></td>
      <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Individual"><? if($value['subadmin_access_individual']){?>
          <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
          <? }else{ ?>
        -
  <? } ?></td>
      <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Search Header "><? if($value['search_header']){?>
          <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
          <? }else{ ?>
        -
  <? } ?></td>
      
      <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Email Menu"><? if($value['email_zoho_etc']){?>
          <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
          <? }else{ ?>
        -
  <? } ?></td>
      <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | View"><? if($value['merchant_action_view']){?>
          <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
        -
        <? } ?></td>
      <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Edit"><? if($value['merchant_action_edit']){?>
          <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
        -
        <? } ?></td>
      <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Login"><? if($value['merchant_action_login']){?><i class="<?=$data['fwicon']['check-circle'];?> text-info"></i><? }else{ ?>-<? } ?></td>
	  
	<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Password-Reset"><? if($value['merchant_action_password_reset']){?>
	    <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
	  <? }else{ ?>
	  -
	  <? } ?></td>
	<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | M.Edit"><? if($value['merchant_action_m_edit']){?>
        <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
	  -
  <? } ?></td>
	<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | SPOC Information "><? if($value['merchant_action_add_principal_profile']){?>
        <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
	  -
  <? } ?></td>
	<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Business"><? if($value['merchant_action_add_stores']){?>
        <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
	  -
  <? } ?></td>
	<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Acquirer"><? if($value['merchant_action_add_account']){?><i class="<?=$data['fwicon']['check-circle'];?> text-info"></i><? }else{ ?>-<? } ?></td>
	<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Add Associate in Acquirer"><? if($value['merchant_action_add_associate_account']){?><i class="<?=$data['fwicon']['check-circle'];?> text-info"></i><? }else{ ?>-<? } ?></td>
	<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Status Action"><? if($value['merchant_action_status_action']){?><i class="<?=$data['fwicon']['check-circle'];?> text-info"></i><? }else{ ?>-<? } ?></td>
	<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Bank Account"><? if($value['merchant_action_bank_account']){?><i class="<?=$data['fwicon']['check-circle'];?> text-info"></i><? }else{ ?>-<? } ?></td>
	
	
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Merchant Store View"><? if($value['clients_store_view']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Merchant Gp View Id"><? if($value['clients_gp_view_id']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Merchant Risk Ratio Bar"><? if($value['clients_risk_ratio_bar']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Merchant Total Transaction"><? if($value['clients_total_transaction']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Merchant Current Balance"><? if($value['clients_current_balance']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Merchant Two Way Authentication"><? if($value['clients_two_way_authentication']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Merchant Add Email"><? if($value['clients_add_email']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Merchant Profile Status Approve"><? if($value['clients_profile_status_approve']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Merchant" ><? if($value['clients_uploaded_document_view']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Merchant Ip History"><? if($value['clients_ip_history']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Merchant Bank Edit Permission"><? if($value['clients_bank_edit_permission']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Merchant Bank Add Edit"><? if($value['clients_bank_add_edit']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Merchant Acquirer Add Edit"><? if($value['clients_acquirer_add_edit']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
		
      <td valign="top" align="center" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Active"><? if($value['active']){?>
        <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
        -
        <? } ?></td>
      <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Suspended"><? if($value['suspended']){?>
        <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
        -
        <? } ?></td>
      <td valign="top" align="center" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Closed"><? if($value['closed']){?>
        <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
        -
        <? } ?></td>
      <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Pending"><? if($value['online']){?>
        <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
        -
        <? } ?></td>
      <td valign="top" align="center" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Search"><? if($value['search']){?>
        <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
        -
        <? } ?></td>
      <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Add new"><? if($value['addnew']){?>
        <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
        -
        <? } ?></td>
      <td valign="top" align="center" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Terminated"><? if($value['block']){?>
        <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
        -
        <? } ?></td>
      <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Add Sub Admin"><? if($value['add_sub_admin']){?>
        <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
        -
        <? } ?></td>
      <td valign="top" align="center" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | List Sub Admin"><? if($value['list_sub_admin']){?>
        <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
        -
        <? } ?></td>
      <td valign="top" align="center" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Create Roles"><? if($value['create_roles']){?>
        <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
        -
        <? } ?></td>
      <td valign="top" align="center" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | List of Roles"><? if($value['list_of_roles']){?>
        <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
        -
        <? } ?></td>
		
		<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Gateway Assign In Subadmin"><? if($value['gateway_assign_in_subadmin']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Merchant Assign In Subadmin"><? if($value['merchant_assign_in_subadmin']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Update Sub Admin Self Profile"><? if($value['update_sub_admin_self_profile']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Update Sub Admin Other Profile"><? if($value['update_sub_admin_other_profile']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Subadmin List Role View"><? if($value['subadmin_list_role_view']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
		
      <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Acquirer Template"><? if(isset($json_value['acquirer_template'])){?>
          <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
          <? }else{ ?>
        -
  <? } ?></td>
      <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Black List"><? if(isset($json_value['black_list'])){?>
          <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
          <? }else{ ?>
        -
  <? } ?></td>
      <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | E-Mail Templates"><? if($value['e_mail_templates']){?>
        <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
        -
        <? } ?></td>
      <td valign="top" align="center" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Graphical Staticstics"><? if($value['graphical_staticstics']){ ?>
        <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
        -
        <? } ?></td>
      
      <td valign="top" align="center" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Merchant Category"><? if(isset($json_value['merchant_category'])){?>
        <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
        -
        <? } ?></td>
      <td valign="top" align="center" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Mop Templates"><? if(isset($json_value['mop_table'])){?>
        <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
        -
        <? } ?></td>
      <td valign="top" align="center" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Salt Management">
	  <? if(isset($json_value['salt_management'])&&$json_value['salt_management']){ ?>
        <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
        -
        <? } ?></td>
      <td valign="top" align="center" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Transaction Reason"><? if(isset($json_value['transaction_reason'])){?>
        <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
        -
        <? } ?></td>
      <td valign="top" align="center" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Transaction Staticstics"><? if(isset($json_value['transaction_staticstics'])){?>
        <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
        -
        <? } ?></td>
      <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Acquirer"><? if($value['bank_gateway_table']){?>
          <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
          <? }else{ ?>
        -
  <? } ?></td>
  
      <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Bank Table"><? if(isset($json_value['bank_payout_table'])){?>
          <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
          <? }else{ ?>
        -
  <? } ?></td>
      
      <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Change Password"><? if($value['change_password']){?>
          <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
          <? }else{ ?>
        -
  <? } ?></td>
      <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | General Option"><? if(@$value['glossary']){?>
          <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
          <? }else{ ?>
        -
  <? } ?></td>
      <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Mass Mailing"><? if($value['mass_mailing']){?>
          <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
          <? }else{ ?>
        -
  <? } ?></td>
      <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Test Mass Mailing"><? if($value['test_mass_mailing']){?>
        <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
        <? }else{ ?>
        -
        <? } ?></td>
		<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Subadmin Pdf Report Link"><? if($value['subadmin_pdf_report_link']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
        <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Subadmin Profile Link"><? if($value['subadmin_profile_link']){?>
            <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
            <? }else{ ?>
          -
  <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | 	
Useful Link"><? if(isset($json_value['useful_link'])&&$json_value['useful_link']){?>
            <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
            <? }else{ ?>
          -
  <? } ?></td>
        <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Notification">
		<? if(isset($json_value['admin_notification'])&&$json_value['admin_notification']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
        <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Support Messages">
		<? if(isset($json_value['support_messages'])&&$json_value['support_messages']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
        <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | C. Reminder"><? if($value['transaction_action_checkbox_reminder']){?><i class="<?=$data['fwicon']['check-circle'];?> text-info"></i><? }else{ ?>-<? } ?></td>
	  <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | C. Surprise"><? if($value['transaction_action_checkbox_surprise']){?>
	      <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
	    <? }else{ ?>
	    -
	    <? } ?></td>
	  <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | C. CSV"><? if($value['transaction_action_checkbox_csv']){?><i class="<?=$data['fwicon']['check-circle'];?> text-info"></i><? }else{ ?>-<? } ?></td>
	  <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Update M. Balance"><? if($value['update_clients_balance']){?>
	      <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
	    <? }else{ ?>
	    -
	    <? } ?></td>
	  <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Action All"><? if($value['transaction_action_all']){?><i class="<?=$data['fwicon']['check-circle'];?> text-info"></i><? }else{ ?>-<? } ?>	  </td>
	  <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Edit Trans."><? if($value['edit_trans']){?>
          <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
          <? }else{ ?>
	    -
  <? } ?></td>
	  <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | T.Bal.Upd."><? if($value['t_bal_upd']){?>
          <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
          <? }else{ ?>
	    -
  <? } ?></td>
	  <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Note System"><? if($value['note_system']){?>
          <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
          <? }else{ ?>
	    -
  <? } ?></td>
	  <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Txn Detail"><? if($value['txn_detail']){?>
          <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
          <? }else{ ?>
	    -
  <? } ?></td>
	  <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Json P. View"><? if($value['json_post_view']){?>
          <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
          <? }else{ ?>
	    -
  <? } ?></td>
	  <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Balance Adjust"><? if($value['balance_adjust']){?>
	      <i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
	    <? }else{ ?>
	    -
	    <? } ?></td>
	  <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Payout"><? if($value['transaction_payout']){?><i class="<?=$data['fwicon']['check-circle'];?> text-info"></i><? }else{ ?>-<? } ?></td>
	  
	  <td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Search Transaction List"><? if($value['search_transaction_list']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Transaction Status Update"><? if($value['transaction_status_update']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | Transaction View All"><? if($value['transaction_view_all']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | T Refund Accept"><? if($value['t_refund_accept']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | T Refund Reject"><? if($value['t_refund_reject']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | T Withdraw Accept"><? if($value['t_withdraw_accept']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | T Withdraw Reject"><? if($value['t_withdraw_reject']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | T Fund Reject"><? if($value['t_fund_reject']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | T Status Confirm"><? if($value['t_status_confirm']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | T Status Cancel"><? if($value['t_status_cancel']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | T Status Return"><? if($value['t_status_return']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | T Status Chargeback"><? if($value['t_status_chargeback']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | T A Require"><? if($value['t_a_require']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | T Add Remark"><? if($value['t_add_remark']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | T Cs Trans"><? if($value['t_cs_trans']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | T Status Test"><? if($value['t_status_test']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | T Status Refunded"><? if($value['t_status_refunded']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | T Status Flag"><? if($value['t_status_flag']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | T Status Unflag"><? if($value['t_status_unflag']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | T Status Pre Dispute"><? if($value['t_status_pre_dispute']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | T Calculation Details"><? if($value['t_calculation_details']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | T Calculation Row"><? if($value['t_calculation_row']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | T Multiple Check Box"><? if($value['t_multiple_check_box']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | T Acquirer View"><? if($value['t_acquirer_view']){?>
<i class="<?=$data['fwicon']['check-circle'];?> text-info"></i>
<? }else{ ?> - <? } ?></td>
<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | All Transaction "><? if($value['transaction_all_link']){?><i class="<?=$data['fwicon']['check-circle'];?> text-info"></i><? }else{ ?>-<? } ?>	  </td>
<? foreach($data['acquirer_list'] as $key2=>$value2 ){  ?>

	<td align="center" valign="top" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<?=$value['rolesname']?> | <?=$value2;?>"><? if(is_array($json_value) && array_key_exists('acquirer_'.$key2, $json_value)){?><b style="color:#ea6100;"><?=$value2;?></b> <? }else{ ?>-<? }?></td>

 <? } ?>
      <td align="center" valign="top" title="<?=$value['rolesname']?> | Action" nowrap>
		<div class="btn-group dropstart"> <a data-bs-toggle="dropdown" aria-expanded="false"  data-bs-placement="bottom" title="Action"><i class="<?=$data['fwicon']['circle-down'];?> text-link"></i></a>
                <ul class="dropdown-menu dropdown-menu-icon pull-right" >
                 
				  <? if($_SESSION['login_adm']){?>
				  
				  <li> <a class="dropdown-item" href="<?=$data['Admins'];?>/roles<?=$data['ex']?>?id=<?=$value['id']?>&action=duplicate" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Duplicate"><i class="<?=$data['fwicon']['clone'];?>"></i> Duplicate</a></li>
				  
				  <li> <a class="dropdown-item" href="<?=$data['Admins'];?>/roles<?=$data['ex']?>?id=<?=$value['id']?>&action=update" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Edit" ><i class="<?=$data['fwicon']['edit'];?> text-success"></i> Edit</a></li>
				  
                  <li> <a class="dropdown-item"  href="<?=$data['Admins'];?>/listroles<?=$data['ex']?>?id=<?=$value['id']?>&action=delete_roles" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Delete" onClick="return cfmform()"><i class="<?=$data['fwicon']['delete'];?> text-danger"></i> Delete</a></li>
				  
				  <? } ?>	 
				  
			<? if(isset($value['json_log_history'])&&$value['json_log_history']){?>
			<li> 
			<i class="<?=$data['fwicon']['circle-info'];?> text-info fa-fw" 
			onclick="popup_openv('<?=$data['Host']?>/include/json_log<?=$data['ex']?>?tableid=<?=$value['id'];?>&tablename=access_roles')" data-bs-toggle="tooltip" data-bs-placement="bottom" title="View Json History"></i>			</li>
			<? } ?>
                </ul>
              </div>		</td>
    </tr>
    <? } ?>
	</tbody>
  </table>
</div>
<? } ?>
<div style="clear:both"></div>
</div>
<? } ?>