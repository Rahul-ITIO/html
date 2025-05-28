<?php
include('../include/fontawasome_icon'.$data['iex']); // for display fw icon on ajax call page
$is_admin=isset($post['is_admin'])&&$post['is_admin']?$post['is_admin']:'';
$post['type']=isset($post['type'])&&$post['type']?$post['type']:'';

$clients_active_type = $_SESSION['MemberInfo']['active'];
$mtype = $data['MEMBER_TYPE'][$clients_active_type];

if((isset($_SESSION['login_adm']))||(isset($_SESSION[$mtype])&&$_SESSION[$mtype]==1))
{
?>
<div class="container border rounded my-1 ">

<div class="row">
<div class="float-end w-25">      
<a data-ihref="<?=$data['Admins']?>/json_log_all<?=$data['ex']?>?tablename=account" title="View Deleted Json Log History" onclick="iframe_open_modal(this);" data-bs-toggle="tooltip" data-bs-placement="top" ><i class="<?=$data['fwicon']['circle-info'];?> text-danger fa-2x mt-2"></i></a>
</div>
<div class="float-start w-75 text-end">  
<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_acquirer_add_edit'])&&$_SESSION['clients_acquirer_add_edit']==1)||(isset($_SESSION['merchant_action_add_associate_account'])&&$_SESSION['merchant_action_add_associate_account']==1)){?>
	
			<a onClick="viewAll(this,'.accountInfo .aq_n1','.aq_div1','.slide_next1')"  class="btn btn-sm btn-primary  my-2"> + EXPAND</a>
		
		<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_acquirer_add_edit'])&&$_SESSION['clients_acquirer_add_edit']==1)){?>
			<a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&action=insert_account&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>"  class="btn btn-success btn-sm my-2"> <i class="<?=$data['fwicon']['circle-plus'];?>"></i> Add New Acquirer</a>
			<? } ?>
	<? if($post['MemberInfo']['sponsor']) { ?>
		<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_add_associate_account'])&&$_SESSION['merchant_action_add_associate_account']==1)){?>
		
			<a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&action=insert_account_associate&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" class="btn btn-warning btn-sm my-2"> <i class="<?=$data['fwicon']['circle-plus'];?>"></i> Add New Gateway Partner</a>
		
		<? } ?>
	<? } ?>

<? } ?>
		</div>
</div>
<? 
		$accountInfo=$post['AccountInfo'];
		if($accountInfo){ ?>
        <div class="accountInfo acc_tb" >
          <? $acc_arr= array(); $gPartnerAcq= array();	$j=0;
			$_SESSION['gPartnerAcq_'.$post['gid']]=array();
		     foreach($accountInfo as $key=>$val){
				$pro_cur1=explode(' ',$val['processing_currency']);
				
				 $pro_cur=(isset($pro_cur1[1])&&$pro_cur1[1])?$pro_cur1[1]:'';
				
				//if(isset($pro_cur)&&$pro_cur=$pro_cur1[1]);

				$shorting_ar[$val['nick_name']]=$val['shorting'];
				$gPartnerAcq[]=$val['nick_name'];
				if(isset($j)&&$j){ $prev= $accountInfo[$j-1];}else{ $prev= $accountInfo[0];}
				$next= $accountInfo[$j+1];//$accountInfo[$j+1];
				//if($next['user_type']=="2"&&$next['nick_name']==$val['nick_name']){
				if(isset($next['user_type'])&&$next['user_type']=="2"&&isset($next['nick_name'])&&$next['nick_name']==$val['nick_name']){
				
					$next_element = $val['id']." accts_m";	
				}elseif($prev['user_type']=="2"&&$prev['nick_name']==$val['nick_name']){
					$next_element = $val['id']." accts_m";	
				}else{
					$next_element = $j;
				}
	  
				if($val['user_type']=="2" ){
					$next_element = $val['id']." accts_r";	
					
					$acc_arr[1]="Commission";$usertypelabel="Gateway Partner";$usertype="GATEWAY PARTNER";$usertype_nam="_associate";}
				else{
					$acc_arr[1]="Discount";$usertypelabel="Acquirer";$usertype="ACQUIRER";$usertype_nam="";		
				}
				$crbk_1="Charge Back Fee 1%";$crbk_2="Charge Back Fee 1%<3%";$crbk_3="Charge Back Fee 3%<";
				if(strpos($data['t'][$val['nick_name']]['name2'],"Check")!==false){
					$crbk_1="Return Fee <10%";$crbk_2="Return Fee 10%<=15%";$crbk_3="Return Fee 15%<=20%";
				}
				
				if($val['salt_id']&&in_array((int)$val['salt_id'],$data['smDb']['salt_id'])){
				   $sm=$data['smDb'][$val['salt_id']];	//$sm=select_table_details($val['salt_id'],'salt_management',0);
				}else{
					$sm=array();
				}
		  ?>
		 
          <div class="acounts accts<?=$val['user_type'];?> <?=$next_element;?>" data-rows="<?=$val['nick_name']?>" id="ac<?=$val['nick_name']?>" >

<div class="aq_div1">
			 
<div 6666 class="aq_p1 <?=($val['account_login_url']==3?'inactive_act_div':'')?>">
				
				
<div  class="input ">
    <span class="py-2 rounded text-white slide_next1  btn btn-primary w-100 text-start" onclick="slide_next1(this,'.aq_n1','2')"  title="Click for View Details <?=$val['user_type']?>" >&nbsp;<i class="<?=$data['fwicon']['hand'];?>"></i>&nbsp;<?=ucwords(strtolower($usertype));?> Id :
				 
                  <?=$val['nick_name']?> =  <?=$data['t'][$val['nick_name']]['name4']?> 
				  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_acquirer_label'])&&$_SESSION['merchant_acquirer_label']==1)){?>
 
				  - <?=$data['t'][$val['nick_name']]['name2']?> (<?=$val['mid_name']?>)
				  <? } ?>
				  
</span>
				   
                
			  
<div class="<?=($val['account_login_url']==3?'inactive_act aq_n1':'')?>" >
				
				<div class="row m-1 bd-gray-100 border rounded text-start text-white">
				
					<div class="col-sm-6 my-2"><strong>Display Order: </strong><span title="Shorting"><b><?=$val['shorting']?></b></span></div>
					
					<div class="col-sm-6 my-2"><strong>Processing Mode: </strong><?php $proc_mode="Test";
					if($val['account_login_url']=="1"){
					$proc_mode="LIVE"; 
					$proc_string="&nbsp;&nbsp;
					(<a target='_top' onclick='popuploadig();' href='{$data['Admins']}/merchant{$data['ex']}?id=".$post['MemberInfo']['id']."&action=detail&bid={$val['id']}&type=active&code=303&ac=".$val['nick_name']."'>Inactive</a>
					 | <a target='_top' onclick='popuploadig();' href='{$data['Admins']}/merchant{$data['ex']}?id=".$post['MemberInfo']['id']."&action=detail&bid={$val['id']}&type=active&code=302&ac=".$val['nick_name']."'>Test</a>)"; 
					}elseif($val['account_login_url']=="2")
						{$proc_mode="TEST"; 
						$proc_string=" (<a target='_top' onclick='popuploadig();' href='{$data['Admins']}/merchant{$data['ex']}?id=".$post['MemberInfo']['id']."&action=detail&bid={$val['id']}&type=active&code=301&ac=".$val['nick_name']."'>Live</a> | <a target='_top' onclick='popuploadig();' href='{$data['Admins']}/merchant{$data['ex']}?id=".$post['MemberInfo']['id']."&action=detail&bid={$val['id']}&type=active&code=303&ac=".$val['nick_name']."'>Inactive</a>)";}
					elseif($val['account_login_url']=="3")
						{$proc_mode="IN-ACTIVE"; 
						$proc_string=" (<a target='_top' onclick='popuploadig();' href='{$data['Admins']}/merchant{$data['ex']}?id=".$post['MemberInfo']['id']."&action=detail&bid={$val['id']}&type=active&code=301&ac=".$val['nick_name']."'>Live</a> | <a target='_top' onclick='popuploadig();' href='{$data['Admins']}/merchant{$data['ex']}?id=".$post['MemberInfo']['id']."&action=detail&bid={$val['id']}&type=active&page=0&code=302&ac=".$val['nick_name']."'>Test</a>)";}
				 echo "<font color='green'><b>".$proc_mode."</b></font>".$proc_string; ?></div>
					
					<div class="col-sm-6 my-2">Edit Permission: <span data-bs-toggle="tooltip" title="" data-bs-original-title="Merchant is not to allowed to Update Acquirer Information in Disable Mode"><i class="<?=$data['fwicon']['circle-info'];?> text-info"></i></span>
					
					<b><? if($val['edit_permission']=="2")
			{echo "<a target='hform' onclick='popuploadig();' href='?id=".$post['MemberInfo']['id']."&action=detail&type=active&page=0&code=306&ac=".$val['nick_name']."'>Disable</a>";}
			else
			{echo "<a target='hform' onclick='popuploadig();' href='?id=".$post['MemberInfo']['id']."&action=detail&type=active&page=0&code=307&ac=".$val['nick_name']."'>Enable</a>";} ?></b></div>
					
<div class="col-sm-6 my-2"><strong>Default Currency: </strong><?=$pro_cur?></div>
					
<div class="col-sm-6 my-2"><strong><?=$usertypelabel;?> <?=$acc_arr[1];?> Rate:</strong> <?=$val['transaction_rate']?> %</div>

<?if(isset($val['gst_fee'])&&$val['gst_fee']){?>
	<div class="col-sm-6 my-2"><strong><?=$usertypelabel;?> GST Fee: </strong> <?=$val['gst_fee']?> % </div>
	
<?}?>
					
<div class="col-sm-6 my-2"><strong><?=$usertypelabel;?> Trxn. Fee (Success):</strong> <?=$val['txn_fee']?> <?=$pro_cur?></div>
					
<div class="col-sm-6 my-2"><strong><?=$usertypelabel;?> Trxn. Fee (Failed):</strong> <?=$val['txn_fee_failed']?> <?=$pro_cur?></div>
					
<? if($val['user_type']!="2" ) { ?>
					
<div class="col-sm-6 my-2"><strong>Rolling Reserve:</strong> <?=$val['rolling_fee']?>% for <?=$val['rolling_period']?> days</div>
					
<div class="col-sm-6 my-2"><strong>Min. Settlement Amt.:</strong> <?=$val['settled_amt']?> <?=$pro_cur?></div>
				
				</div>

			 </div>
	 </div>		  
			  <div class="aq_n1 hide">
			  
				
			<? if($val['json_log_history']){?>	
			
				
					  <div class="m-2" style="float:left;width:100%;clear:both !important;">
					  <? echo json_log_view($val['json_log_history'],'View Json Log','0','json_log','','100');?>
					  </div>
      
			 <? } ?>
			  <!-- Div Starts -->
			  
    
			  <!-- Div Starts -->
			  <div class="row m-1  border rounded text-start bd-blue-100 text-dark">
				
				 <? if(!isset($val['scrubbed_json'])){ ?>
					<div class="col-sm-6 my-2"><strong>Scrubbed Period: </strong><? if($val['scrubbed_period']){?> <?=$val['scrubbed_period'];?> Days <? }?></div>
					
                	<div class="col-sm-6 my-2"><strong>Min Trxn Limit: </strong><? if($val['min_limit']){?>
                  <?=$val['min_limit']?> <?=$pro_cur?>
                  <? }?></div>
				  
					<div class="col-sm-6 my-2"><strong>Max Trx. Limit: </strong><?=$val['max_limit']?> <?=$pro_cur?></div>
					
					<div class="col-sm-6 my-2"><strong>Min Success Count: </strong><?=($val['tr_scrub_success_count'])?$val['tr_scrub_success_count']:'2'?></div>
					
					<div class="col-sm-6 my-2"><strong>Min Failed Count: </strong><?=($val['tr_scrub_failed_count'])?$val['tr_scrub_failed_count']:'5'?></div>
					
					<div class="col-sm-6 my-2"><strong>Trxn Count: </strong><?=$val['transaction_count']?></div>
				<? } ?>		
					<div class="col-sm-6 my-2 hide"><strong>Setup Fee (USD):</strong><?=$val['setup_fee']?></div>
				
					<div class="col-sm-6 my-2 hide"><strong>Setup Fee Collected:</strong>
					
				<?php if ($val['setup_fee_status']==1){
				 ?>
				
				 	<a target="hform" onclick="popuploadig();" href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?action=detail&type=active&id=<?=$post['MemberInfo']['id']?>&ac=<?=$val['nick_name']?>&code=304" class="text-success">
					 Collected <i class="<?=$data['fwicon']['circle-check'];?>"></i></span>
				 </a>
				 <?php } else { ?>
				
				 <a target="hform" onclick="popuploadig();" href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?action=detail&type=active&id=<?=$post['MemberInfo']['id']?>&ac=<?=$val['nick_name']?>&code=305" class="text-danger">
				 	Not Collected  <i class="<?=$data['fwicon']['circle-cross'];?>"></i></a>
				 <?php } ?></div>
		  
		     </div>
				<!-- Div Ends -->	
			<? if(isset($val['scrubbed_json'])&&$val['scrubbed_json']){?>	
			<div class="row m-1 border rounded text-start bd-green-100 text-white" >
				 
				<?php
				$datascrubbed1=[];
				 $datascrubbed1 =  json_decode($val['scrubbed_json'],1);
				
				if(!is_array($datascrubbed1)) $datascrubbed1=[];
				//print_r($datascrubbed);
				$j=1;
				foreach($datascrubbed1 as $k => $v){
				$sp_kay=$k;
				$i=0;
				  if(is_array($v)){
				
				  $cap=str_replace('sp_','',$sp_kay)." Day/S";
				  //echo "<p>$cap</p>";
				 ?>
				<!--=====================-->
				<div class="col-sm-12 my-2"><strong>Scrubbed Period:</strong> <?=$cap;?> </div>
				
				<div class="col-sm-6 my-2"><strong>Min Trxn Limit:</strong> <?=$v['min_limit']?> <?=$pro_cur?></div>
				
				<div class="col-sm-6 my-2"><strong>Max Trxn Limit:</strong> <?=$v['max_limit']?> <?=$pro_cur?></div>
				
				<div class="col-sm-6 my-2"><strong>Min Success Count:</strong> <?=$v['tr_scrub_success_count'];?></div>
				
				<div class="col-sm-6 my-2"><strong>Min Failed Count:</strong> <?=$v['tr_scrub_failed_count'];?></div>
				
				<div class="col-sm-6 my-2"><strong>Trxn Count:</strong> <?=($v['tr_scrub_success_count'] + $v['tr_scrub_failed_count'])?></div>
				
				<div style="height: 10px;float: left;width: 100%;clear: both;">&nbsp;&nbsp;</div>
				<hr>
					
				 <?
				  }$j++;
				    }
				 ?>
					
			 </div>		
			<? }?>	
			
			  <!-- Div Starts -->
			  <div class="row m-1  border rounded text-start bd-red-100 text-white">
			  
					<div class="col-sm-6 my-2 hide"><strong>Monthly Maintenance Fee: </strong><?=$val['monthly_fee']?> <?=$pro_cur?></div>
					<div class="col-sm-6 my-2"><strong><?=$crbk_1;?>:</strong> <?=$val['charge_back_fee_1']?></div>
					
					<div class="col-sm-6 my-2"><strong><?=$crbk_2;?>:</strong> <?=$val['charge_back_fee_2']?></div>
					
					<div class="col-sm-6 my-2"><strong><?=$crbk_3;?>:</strong> <?=$val['charge_back_fee_3']?></div>
					
					<? if(isset($val['cbk1'])&&$val['cbk1']){ ?>
					<div class="col-sm-6 my-2"><strong>CBK1:</strong> <?=$val['cbk1']?></div>
					
					<? } ?>
					<div class="col-sm-6 my-2"><strong>Refund Fee:</strong> <?=$val['refund_fee']?> <?=$pro_cur?></div>
					
					<div class="col-sm-6 my-2"><strong>Settlement Wire Fee: </strong><?=$val['return_wire_fee']?> <?=$pro_cur?></div>
					<div class="col-sm-6 my-2"><strong>Settlement Period: </strong><?=$val['settelement_period']?> Days</div>
					
					<div class="col-sm-6 my-2"><strong>Settlement Report View: </strong><?php $view_settelement_report="Allowed"; if($val['view_settelement_report']=="1"){$view_settelement_report="Allowed";}elseif($val['view_settelement_report']=="2"){$view_settelement_report="Not Allowed";} echo $view_settelement_report; ?></div>
					
              <div class="col-sm-6 my-2 hide"><strong>Virtual Terminal Fee:</strong> <?=$val['virtual_fee']?> <?=$pro_cur?></div>
			<div class="col-sm-6 my-2 hide"><strong>VT:</strong> <?php $vt="Not Allowed"; if($val['vt']=="1"){$vt="Allowed";}if($val['vt']=="2"){$vt="Not Allowed";} echo $vt; ?></div>
					
					
					</div>
					<!-- Div Ends -->	
		
				<div class="row m-1 border rounded text-start bd-yellow-100 text-white" >
				<? if($val['salt_id']){ ?>
					<div class="col-sm-6 my-2"><strong> Bank Salt ID : </strong>
					<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['edit_salt'])&&$_SESSION['edit_salt']==1)){ ?>
						<a class="saltpop99 datahref1 hrefmodal1 nopopup" onclick="iframe_open_modal(this);" data-ihref="<?=$data['Admins'];?>/salt_management<?=$data['ex']?>?id=<?=$val['salt_id']?>&action=update&hideAllMenu=1&type=active" style="background-color:<?=($sm['salt_status']==1?"#37a238":"#f24a02");?>!important;color:#fff!important;border:0px solid #37a238 !important;display:inline-block;width:80px;text-align:center;padding:5px 0;margin:6px 0 0 0;border-radius:3px;">Edit Salt</a>
					<? } ?>
				
						<pre><?=($val['salt_id']." | <b>".$sm['salt_name']."</b> | ".$sm['bank_json']);?></pre>
					</div>
				<? }else{ ?>
					<div class="col-sm-6 my-2" style=" width:300px;"><strong>Bank Siteid : </strong><span class="Bank Siteid"><?=$val['hkip_siteid'];?></span></div>
				
				<? } ?>
				
			  	<div class="col-sm-6 my-2"><strong>Checkout Level Name : </strong><?=$val['checkout_level_name']?></div>
				
				<div class="col-sm-6 my-2 hide"><strong>Merchant Preferences :</strong>

						<?php if(strpos($val['notification_to'],"001")!==false)
						{echo "(Notification to Merchant on Approved.";}?> 
						
						<?php if(strpos($val['notification_to'],"004")!==false)
						{echo "(Notification to Merchant on Declined.";}?> 
						
						<?php if(strpos($val['notification_to'],"002")!==false)
						{echo " Notification to Customer)";}?> 
						<?php if(strpos($val['notification_to'],"003")!==false)
						{echo " Money Request)";}?> 
						<?php if(strpos($val['notification_to'],"005")!==false){echo "Encrypt Customer Email";}?>
					</div>
				<div class="col-sm-6 my-2 hide"><strong>Trxn. Notification Email : </strong><?=encrypts_decrypts_emails($val['transaction_notification_email'],2);?></div>
				
				<div class="col-sm-6 my-2 hide"><strong>DBA/Brand Name: </strong><?=$val['dba_brand_name']?></div>
				<!-- Div Ends -->
				<!-- Div Starts noti_1-->
				<div class="col-sm-6 my-2 hide"><strong>Business URL: </strong><?=$val['bussiness_url']?></div>
				
				<div class="col-sm-6 my-2 hide"><strong>Customer Service No.: </strong><?=$val['customer_service_no']?></div>
				
				<div class="col-sm-6 my-2 hide"><strong>Customer Service Email: </strong><?=encrypts_decrypts_emails($val['customer_service_email'],2);?></div>
				
				<? if(isset($val['descriptor'])&&$val['descriptor']){ ?>
				<div class="col-sm-6 my-2"><strong>Descriptor:</strong> <?=$val['descriptor']?></div>
				<? } ?>
				
				<div class="col-sm-6 my-2 hide"><strong>T &amp; C:</strong> <?=$val['merchant_term_condition_url']?></div>
				
				<div class="col-sm-6 my-2 hide"><strong>Refund Policy: </strong><?=$val['merchant_refund_policy_url']?></div>
				
				<div class="col-sm-6 my-2 hide"><strong>Privacy Policy : </strong><?=$val['merchant_privacy_policy_url']?></div>
				
				<div class="col-sm-6 my-2 hide"><strong>Contact US : </strong><?=$val['merchant_contact_us_url']?></div>
				
				<div class="col-sm-6 my-2 hide"><strong>Logo:</strong> <?=$val['merchant_logo']?></div>
				
				<? if(isset($val['mdr_visa_rate'])&&$val['mdr_visa_rate']){ ?>
				<div class="col-sm-6 my-2"><strong>Visa Rate: </strong><?=$val['mdr_visa_rate']?></div>
				
				<? } ?>
				<? if(isset($val['mdr_mc_rate'])&&$val['mdr_mc_rate']){ ?>
				<div class="col-sm-6 my-2"><strong>Master Rate: </strong><?=$val['mdr_mc_rate']?></div>
				
				<? } ?>
				<? if(isset($val['mdr_jcb_rate'])&&$val['mdr_jcb_rate']){ ?>
				<div class="col-sm-6 my-2"><strong>JCB Rate: </strong><?=$val['mdr_jcb_rate']?></div>
			  	
				<? } ?>
				<? if(isset($val['mdr_amex_rate'])&&$val['mdr_amex_rate']){ ?>
				<div class="col-sm-6 my-2"><strong>Amex Rate: </strong><?=$val['mdr_amex_rate']?></div>
               <? } ?>
				
				</div>
			  <!-- Div Starts -->
				<div class="row m-1 border text-start acc_hide bd-blue-100 text-dark">
				<div class="col-sm-6 my-2"><strong>Card Type:</strong>
						<?php if(strpos($val['card_type'],"001")!==false){echo "Visa Card<br/>";}?> 
						<?php if(strpos($val['card_type'],"002")!==false){echo "Master Card<br/>";}?> 
						<?php if(strpos($val['card_type'],"003")!==false){echo "Amex Card<br/>";}?> 
						<?php if(strpos($val['card_type'],"004")!==false){echo "JCB Card<br/>";}?> 
					</div>
				</div>
					<!-- Div Ends -->	
	
			 
			  <div class="row m-1 border text-start acc_hide" style="background: #c1d5ac;">
				<div class="col-sm-6 my-2"><strong>Account Custom field 14:</strong> <?=$val['account_custom_field_14']?></div>
			  </div>
			  
			  <div class="row m-1 border text-start acc_hide" style="background: #c1d5ac;">
				<div class="col-sm-6 my-2"><strong>Login Required:</strong> <?php $login_required="Not Allowed"; if($val['login_required']=="1"){$login_required="Allowed";}if($val['login_required']=="2"){$login_required="Not Allowed";} echo $login_required; ?></div>
			  </div>
				
              <? }  ?>
			  
			
<? 
if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_add_associate_account'])&&$_SESSION['merchant_action_add_associate_account']==1)){
?>
<div class="col-sm-12 text-center my-2"><?php /*?><strong><?=ucfirst($usertype);?> : </strong><?php */?>
<div class="btn-group" role="group" aria-label="Basic example">
<a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&action=insert_account<?=$usertype_nam;?>&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>"  class="btn btn-primary"><i class="<?=$data['fwicon']['circle-plus'];?>"></i></a> 

 <a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&bid=<?=$val['id']?>&action=update_account<?=$usertype_nam;?>&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" class="btn btn-primary"><i class="<?=$data['fwicon']['edit'];?> text-success"></i></a> 

 <a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&bid=<?=$val['id']?>&action=delete_account&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" onClick="return confirm('Are you Sure to Delete this')" class="btn btn-primary"><i class="<?=$data['fwicon']['delete'];?> text-danger"></i></a> 
 </div>
					
				</div>	
				
			
              <? }?>
			  
		
			  
			  </div>
			  
			  </div>
          
          </div>
          <? 
			$j++;
			
			$gPartnerAcq = array_unique($gPartnerAcq);
			$gPartnerAcq = array_filter($gPartnerAcq);
			$_SESSION['gPartnerAcq_'.$post['gid']]=$gPartnerAcq;
			
		  } ?>
		  
		  <? $_SESSION['shorting_ar']=$shorting_ar;?>
		  </div>
        <? }?>
       
		<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_acquirer_add_edit'])&&$_SESSION['clients_acquirer_add_edit']==1)||(isset($_SESSION['merchant_action_add_associate_account'])&&$_SESSION['merchant_action_add_associate_account']==1)){?>
        <? if (!$post['AccountInfo']){ ?>
			<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_acquirer_add_edit'])&&$_SESSION['clients_acquirer_add_edit']==1)){?>
				
				
				<div class="text-center my-2">
				
				<div class="alert alert-danger alert-dismissible fade show mx-2 text-center" role="alert">
					<strong>No Acquirer Information</strong> 
					<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>
				
				</div>
			<? } ?>
        <? } ?>
	<? }?>
	</div>

<?
}
else
{
	include('../oops'.$data['iex']);
}
?>
<? db_disconnect();?>