<?

include('../include/fontawasome_icon'.$data['iex']); // for display fw icon on ajax call page
$is_admin=isset($post['is_admin'])&&$post['is_admin']?$post['is_admin']:'';
$post['type']=isset($post['type'])&&$post['type']?$post['type']:'';

$clients_active_type = $_SESSION['MemberInfo']['active'];
$mtype = $data['MEMBER_TYPE'][$clients_active_type];
?>
<style>
.is_leftPanel .td_relative {width:calc(98vw - 280px) !important;}
@media only screen and (max-width: 768px){
.is_leftPanel .td_relative {width:98% !important;}
}
</style>


<?
if((isset($_SESSION['login_adm']))||(isset($_SESSION[$mtype])&&$_SESSION[$mtype]==1))
{
?>


<div class="container my-2 text-end px-0">
<div class="my-2 float-start">
<a data-ihref="<?=$data['Admins']?>/json_log_all<?=$data['ex']?>?tablename=banks&mode=json_log" title="View Bank Json Log History" onclick="iframe_open_modal(this);"><i class="<?=$data['fwicon']['circle-info'];?> text-danger fa-fw fa-2x"></i></a>

<a data-ihref="<?=$data['Admins']?>/json_log_all<?=$data['ex']?>?tablename=coin_wallet&mode=json_log" title="View Coin Wallet Json Log History" onclick="iframe_open_modal(this);"><i class="<?=$data['fwicon']['circle-info'];?> text-danger fa-fw fa-2x"></i></a>
</div>
<div class="btn btn-sm btn-primary my-2">Total : <?=$data['b_result_count'];?> </div>	
<a href="<?=$data['Admins'];?>/<?=$data['MER']?><?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&action=insert_bank<?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" class="btn btn-sm btn-primary my-2" title="Add New Bank Account"><i class="<?=$data['fwicon']['circle-plus'];?>"></i></a>	
</div>

<div>

<? if((count($post['BanksInfo'])==0) && (count($post['WalletInfo'])==0)) { ?>
<!--<div class="alert alert-danger alert-dismissible fade show mx-2 text-center" role="alert">
  <strong>No Bank Information Found!</strong> 
  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>-->
<? } ?>

<? if($post['BanksInfo']){ ?>
<? foreach($post['BanksInfo'] as $key=>$val){
if($val['bname']=='Crypto Wallet'){$crypto_wallet=1;$bankType=0;$iconAcc='crypto'; }else{$crypto_wallet=0;$bankType=1;$iconAcc='bank';}	
?>
	
	
	
	</div>	
	
	
	<div class="border m-1 v11 rounded">

		<? if($bankType){ ?>
<h4 class="text-start m-2 p-2 rounded-pill text-white border border-primary" > <i class="<?=$data['fwicon']['bank'];?> "></i> Personal Information</h4>
		<? }else{ ?>
<h4 class="text-start my-2 p-2 rounded-pill text-white border border-primary"> <i class="<?=$data['fwicon']['bitcoin'];?> "></i> Crypto Wallet</h4>
		<? } ?>
<div class="m-2 td_relative" style="width:98%;overflow:auto">  
	  <? echo $jsonVewB=json_log_view($val['json_log_history'],'View Json Log','0','json_log','','100'); ?>
	  
</div>
	  
	  <!--Edit Permission Display -->
		  <div class="mx-2">
		    Edit Permission:
		 
		  <? if($val['primary']=="2"){ ?>
				<a <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_bank_edit_permission'])&&$_SESSION['clients_bank_edit_permission']==1)){ ?> href="<?=$data['Admins'];?>/<?=$data['MER']?><?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&bid=<?=$val['id']?>&action=bank_primary_disable<?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" onclick='return confirm("Do you want to un-approve the bank details?");' <? } ?>  title='Approved' class="text-decoration-none"><i class="<?=$data['fwicon']['primary'];?>"></i> <b>Approved</b></a> <small style="color:Black;">(Lock the Data)</small>
			<? }else{ ?>
					<a <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_bank_edit_permission'])&&$_SESSION['clients_bank_edit_permission']==1)){ ?> href="<?=$data['Admins'];?>/<?=$data['MER']?><?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&bid=<?=$val['id']?>&action=bank_primary_enable<?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" onclick='return confirm("Do you want to approve the bank details?");' <? } ?> title="Un-Approved"  class="text-decoration-none"><i class="<?=$data['fwicon']['primary'];?>"></i> <b>Un-Approved</b></a> <small >(Unlock the Data)</small>
			<? } ?>
			
			
			Primary:
		 
		  <? if($val['bank_account_primary']){ ?>
				<a title='Bank Account Primary'><i class="<?=$data['fwicon']['key'];?> text-success"></i> <b>Primary</b></a> 
			<? }else{ ?>
					<a <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_bank_edit_permission'])&& $_SESSION['clients_bank_edit_permission']==1)){ ?> href="<?=$data['Admins'];?>/<?=$data['MER']?><?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&bid=<?=$val['id']?>&action=bank_account_primary<?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" onclick='return confirm("Are you Sure to Set Primary for Bank Account : <?=prntext($val['bname'])?>");' <? } ?> title="Set to Primary" class="text-decoration-none"><i class="<?=$data['fwicon']['primary'];?> text-info"></i> <b>Set to Primary</b></a> 
					
					<? if($val['verify_status']=='0' && $val['primary']!="2")
					{?>
						<a <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_bank_edit_permission'])&&$_SESSION['clients_bank_edit_permission']==1)){?> href="<?=$data['Admins'];?>/<?=$data['MER']?><?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&bid=<?=$val['id']?>&action=sent_verification_amt&tname=bank<?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" onclick='return confirm("Are you Sure to Sent Verfication Request for A/C: <?=decrypts_string($val['baccount'])?>");' <? }?> title="Send Verify Amount"><i class="<?=$data['fwicon']['unlock'];?> text-danger"></i> <b>Send Verify Amount</b></a>
					<? }
					elseif($val['verify_status']=='1')
					{?>
						<i class="<?=$data['fwicon']['key'];?> text-success"></i><b> Verified</b>
					<?
					}elseif($val['verify_status']=='2')
					{?>
					<i class="<?=$data['fwicon']['unlock'];?> text-danger"></i>
					<a onclick="verifyAmountFunction('<?=$val['id']?>', '<?=$val['clientid']?>', 'banks')"><b> Verify Amount</b></a>
					<?
					}?>
					
					
			<? } ?>
		  </div>
		  <!--End Edit Permission Display -->

		<? if($bankType){ ?>
		 
		  <div class="row m-1 text-start">
		
		<?php
		if (!empty($val['bnameacc'])){
		?>
			<div class="col-sm-4 my-2"><strong>Account Holder's Name: </strong> <?=$val['bnameacc']?></div>
		<? } ?>
		
		<?php
		if (!empty($val['full_address'])){
		?>
			<div class="col-sm-4 my-2"><strong>Full Address: </strong><?=$val['full_address']?></div>
		<? } ?>
		
		<?php
		if (!empty($val['baccount'])){
		?>
			<div class="col-sm-4 my-2"><strong>Account Number<? if($post['ovalidation']){ ?> / IBAN No<? } ?> :</strong> <?=decrypts_string($val['baccount'])?></div>
		<? } ?>
		
		 </div>
		
      
	     <div class="row m-1 text-start admin_header_main">
	  <h4>Bank Information</h4>
		<?php
		if ((!empty($val['brtgnum']))){
		?>
			<div class="col-sm-4 my-2"><strong>Bank Routing Code :</strong> <?=$val['brtgnum']?></div>
		<? } ?>
		
		
		<?php
		if (!empty($val['bswift'])){
		?>
		<div class="col-sm-4 my-2"><strong><?=$post['swift_con'];?> Code :</strong> <?=$val['bswift']?></div>
		<? } ?>
		
		
		<?php
		if (!empty($val['bname'])){
		?>
		<div class="col-sm-4 my-2"><strong>Bank Name : </strong><?=$val['bname']?></div>
		<? } ?>
		
		<?php
		if (!empty($val['baddress'])){
		?>
		<div class="col-sm-4 my-2"><strong>Bank Address : </strong><?=$val['baddress']?></div>
		<? } ?>
		
		<?php
		if (!empty($val['bphone'])){
		?>
		<div class="col-sm-4 my-2"><strong>Bank Phone : </strong><?=$val['bphone']?></div>
		<? } ?>
		
		<?php
		if (!empty($val['btype'])){
		?>
		<div class="col-sm-4 my-2"><strong>Account Type : </strong><?=$data['BankAccountType'][$val['btype']]?></div>
		<? } ?>
		
		<?php
		if (!empty($val['adiinfo'])){
		?>
		<div class="col-sm-4 my-2"><strong>Additional Information : </strong><?=$val['adiinfo']?></div>

		<? } ?>
		
		<?php
		if (!empty($val['required_currency'])){
		?>
		<div class="col-sm-4 my-2"> <strong>Requested Currency : </strong><?=$val['required_currency']?></div>
		<? } ?>
		
		<? if($val['withdrawFee']){ ?>
		 <div class="col-sm-4 my-2"><strong>Withdraw Fee :</strong> <?=$val['withdrawFee']?> %</div>
	    <? } ?>
		
		
		
		
		
		<?php
		if (!empty($val['intermediary'])){
		?>
		<div class="col-sm-4 my-2"><strong>Intermediary <?=$post['swift_con'];?> Code :</strong><?=$val['intermediary']?></div>
		<? } ?>
		
		

		<?php
		if (!empty($val['intermediary_bank_address'])){
		?>
		<div class="col-sm-4 my-2"><strong>Intermediary Bank Address : </strong><?=$val['intermediary_bank_address']?></div>
		<? } ?>
		
		
		<?php
		if (!empty($val['intermediary_bank_name'])){
		?>
		<div class="col-sm-4 my-2"><strong>Intermediary Bank Name :</strong><?=$val['intermediary_bank_name']?></div>
		<? } ?>
		
		<div class="col-sm-4 my-2"><strong>Bank Document: </strong></div>
		<div class="col-sm-4 my-2">	<? $pro_img=display_docfile("../user_doc/", $val['bank_doc']); ?></div>
		
		<? if($val['settlement_webhook_url']){ ?>
		 <div class="col-sm-12 my-2"><strong>Settlement Webhook Url :</strong> <?=$val['settlement_webhook_url']?></div>
	    <? } ?>

		</div>
		
		
		
	<? }else{ //Crypto Wallet ?>
		
		 
		  <div class="row m-1 text-start admin_header_main">
	      <h4>Crypto Wallet Information</h4>
			 
			 
			  <? if($val['bswift']){ ?>
				  <div class="col-sm-4 my-2"><strong>Coins:</strong> <?=$val['bswift']?> </div>
			  <? } ?>
			  <? if($val['brtgnum']){ ?>
				  <div class="col-sm-4 my-2"><strong>Network: </strong><?=$val['brtgnum']?> </div>
			  <? } ?>
			  <? if($val['baccount']){ ?>
				  <div class="col-sm-4 my-2"><strong>Address: </strong><?=decrypts_string($val['baccount'])?> </div>
			  <? } ?>
			  <? if($val['baddress']){ ?>
				  <div class="col-sm-4 my-2"><strong>Wallet Provider: </strong><?=$val['baddress']?> </div>
			  <? } ?>
			  <? if($val['required_currency']){ ?>
				  <div class="col-sm-4 my-2"><strong>Requested Currency: </strong><?=$val['required_currency']?> </div>
			  <? } ?>
			   <? if($val['withdrawFee']){ ?>
				  <div class="col-sm-4 my-2"><strong>Withdraw Fee: </strong><?=$val['withdrawFee']?> %</div>
			  <? } ?>
			  
		
			  
			  <div class="col-sm-4 my-2"><strong>Bank Document:</strong></div>
			  
			  <div class="col-sm-4 my-2"><? $pro_img=display_docfile("../user_doc/", $val['bank_doc']); ?></div>
			</div>
			

	<? } ?>


  
<div class="container text-center my-2">
  
  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_bank_add_edit'])&&$_SESSION['clients_bank_add_edit']==1)){ ?>
   <? if($val['status']==0){ ?>  
   
   <a href="<?=$data['Admins'];?>/<?=$data['MER']?><?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&action=insert_bank&type=<?=(isset($post['type'])?$post['type']:'');?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" class="btn btn-primary btn-sm my-2" title="Add New Bank"><i class="<?=$data['fwicon']['circle-plus'];?>"></i></a>
   
   <a href="<?=$data['Admins'];?>/<?=$data['MER']?><?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&bid=<?=$val['id']?>&action=update_bank&type=<?=(isset($post['type'])?$post['type']:'');?>&insertType=Bank Account<?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" class="btn btn-primary btn-sm my-2" title="Edit"><i class="<?=$data['fwicon']['edit'];?> text-success"></i></a>
   
    <a href="<?=$data['Admins'];?>/<?=$data['MER']?><?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&bid=<?=$val['id']?>&action=delete_bank&type=<?=(isset($post['type'])?$post['type']:'');?>&deleteType=Bank Account<?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" onClick="return confirm('Are you Sure to DELETE this')"  class="btn btn-primary btn-sm my-2"><i class="<?=$data['fwicon']['delete'];?> text-danger" title="Delete"></i></a>
	
	</div>
	
    <? } ?>
	
	<? } ?>
	</div>
	
	

	
	<? } ?>
    

	
	
	<? }else{ ?>

      
<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_bank_add_edit'])&&$_SESSION['clients_bank_add_edit']==1)){ ?>
      <div class="text-center">
	  

		
		<? if($post['BanksInfo']){ ?>
		 | <a href="<?=$data['Admins'];?>/<?=$data['MER']?><?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&bid=<?=$val['id']?>&action=update_bank&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>">EDIT</a> 
			
			<? if(isset($_SESSION['login_adm'])){ ?>
				| <a href="<?=$data['Admins'];?>/<?=$data['MER']?><?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&bid=<?=$val['id']?>&action=delete_bank&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" onClick="return confirm('Are you Sure to DELETE this')">DELETE<?=$val['status'];?></a>
			 <? } ?>
		 <? } ?>
      <? } ?>



    <? } ?>
  
 <!-- </div>-->
	<? if($post['WalletInfo'])
		{
		
		
			foreach($post['WalletInfo'] as $key=>$val)
			{
				$crypto_wallet=1;
				$bankType=0;
				$iconAcc='crypto'; 
			?>
				
				
				<div class="border m-1 admin_header_main v11 rounded">

<h4 class="text-start m-2 p-2 rounded-pill text-white border border-warning"> <i class="<?=$data['fwicon']['bitcoin'];?> text-warning"></i> Crypto Wallet</h4>
<div class="m-2 td_relative" style="width:98%;overflow:auto"> 		
<? echo $jsonVewB=json_log_view($val['json_log_history'],'View Json Log','0','json_log','','100'); ?>
</div>		
					<!--Edit Permission Display -->
					<div class="mx-2">Edit Permission:
				 
				  <? if($val['primary']=="2"){?>
						<a <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_bank_edit_permission'])&&$_SESSION['clients_bank_edit_permission']==1)){?> href="<?=$data['Admins'];?>/<?=$data['MER']?><?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&bid=<?=$val['id']?>&action=crypto_primary_disable" onclick='return confirm("Do you want to un-approve the bank details?");' <? }?>  title='APPROVED'><i class="<?=$data['fwicon']['lock'];?> text-success"></i> <b>Approved</b></a> <small style="color:Black;">(Lock the Data)</small>
					<? }else{?>
							<a <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_bank_edit_permission'])&&$_SESSION['clients_bank_edit_permission']==1)){?> href="<?=$data['Admins'];?>/<?=$data['MER']?><?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&bid=<?=$val['id']?>&action=crypto_primary_enable" onclick='return confirm("Do you want to approve the bank details?");' <? }?> title="UN-APPROVED"><i class="<?=$data['fwicon']['primary'];?> text-danger"></i> <b>Un-Approved</b></a> <small >(Unlock the Data)</small>
					<? }?>
		
					Primary:
				 
<? if($val['bank_account_primary']){?>
<a title='Bank Account Primary'><i class="<?=$data['fwicon']['key'];?> text-success"></i><b> Primary</b></a> 
<? }else{?>
<a <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_bank_edit_permission'])&&$_SESSION['clients_bank_edit_permission']==1)){?> href="<?=$data['Admins'];?>/<?=$data['MER']?><?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&bid=<?=$val['id']?>&action=crypto_wallet_primary" onclick='return confirm("Are you Sure to Set Primary for Account : <?=prntext($val['coins_name'])?>");' <? }?> title="Set to Primary"><i class="<?=$data['fwicon']['primary'];?> text-info"></i><b> Set to Primary</b></a> 

<? if($val['verify_status']=='0' && $val['coins_name']=='USDT' && ($val['coins_network']=='BEP20' || $val['coins_network']=='TRC20') && $val['primary']!="2")
				{?>
					<a <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_bank_edit_permission'])&&$_SESSION['clients_bank_edit_permission']==1)){?> href="<?=$data['Admins'];?>/<?=$data['MER']?><?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&bid=<?=$val['id']?>&action=sent_verification_amt&tname=coin_wallet" onclick='return confirm("Are you Sure to Sent Verfication Request for A/C: <?=decrypts_string($val['coins_address'])?>");' <? }?> title="Send Verify Amount"><i class="<?=$data['fwicon']['unlock'];?> text-danger"></i><b> Send Verify Amount</b></a>
				<? }
				elseif($val['verify_status']=='1')
					{?>
						<b><i class="<?=$data['fwicon']['check-circle'];?> text-success"></i> Verified</b>
					<?
					}
					elseif($val['verify_status']=='2')
					{?>
					<i class="<?=$data['fwicon']['unlock'];?> text-danger"></i>
					<a onclick="verifyAmountFunction('<?=$val['id']?>', '<?=$val['clientid']?>')"><b> Verify Amount</b></a>
					<?
					}?>			
				  </div>




					<? }?>
				  
				  <!--End Edit Permission Display -->
				
				 
				  
	
				  
<div class="row m-1 text-start">
<h4>Crypto Wallet Information</h4>
			 
<? if($val['coins_name']){?>			 
<div class="col-sm-4 my-2"><strong>Coins:</strong> <?=$val['coins_name']?> </div>
<? } ?>
<? if($val['coins_network']){ ?>
<div class="col-sm-4 my-2"><strong>Network: </strong> <?=$val['coins_network']?> </div>
<? } ?>
<? if($val['coins_address']){ ?>
<div class="col-sm-4 my-2"><strong>Address: </strong> <?=decrypts_string($val['coins_address']);?> </div>
<? } ?>
<? if($val['coins_wallet_provider']){ ?>
<div class="col-sm-4 my-2"><strong>Wallet Provider: </strong> <?=$val['coins_wallet_provider']?> </div>
<? } ?>
<? if($val['required_currency']){ ?>
<div class="col-sm-4 my-2"><strong>Requested Currency: </strong> <?=$val['required_currency']?> </div>
<? } ?>
<? if($val['withdrawFee']){ ?>
<div class="col-sm-4 my-2"><strong>Withdraw Fee: </strong><?=$val['withdrawFee']?> %</div>
<? } ?>			  			  
<div class="col-sm-4 my-2"><strong>Bank Document:</strong>
<?  $pro_img=display_docfile("../user_doc/", $val['bank_doc']);?>
</div>


</div>	

<div class="container text-center my-2">
  
  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_bank_add_edit'])&&$_SESSION['clients_bank_add_edit']==1)){ ?>
   <? if($val['status']==0){ ?>  
   
   <a href="?=$data['Admins'];?>/<?=$data['MER']?><?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&action=insert_bank&type=<?=(isset($post['type'])?$post['type']:'');?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" class="btn btn-primary btn-sm my-2" title="Add New Crypto Wallet"><i class="<?=$data['fwicon']['circle-plus'];?>"></i></a>
   
   <a href="<?=$data['Admins'];?>/<?=$data['MER']?><?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&bid=<?=$val['id']?>&action=update_bank&type=<?=(isset($post['type'])?$post['type']:'');?>&insertType=Crypto Wallet<?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" class="btn btn-primary btn-sm my-2" title="Edit"><i class="<?=$data['fwicon']['edit'];?> text-success"></i></a>
   
    <a href="<?=$data['Admins'];?>/<?=$data['MER']?><?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&bid=<?=$val['id']?>&action=delete_crpto&type=<?=(isset($post['type'])?$post['type']:'');?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" onClick="return confirm('Are you Sure to DELETE this')"  class="btn btn-primary btn-sm my-2" title="Delete"><i class="<?=$data['fwicon']['delete'];?> text-danger"></i></a>
						<? 
						}
					}
					?>
				</div>
				</div> 
			</div>
			<?
		}
	}
}
else include('../oops'.$data['iex']);
?>

<? db_disconnect();?>