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
<a data-ihref="<?=@$data['Admins']?>/json_log_all<?=@$data['ex']?>?tablename=account" title="View Deleted Json Log History" onclick="iframe_open_modal(this);" data-bs-toggle="tooltip" data-bs-placement="top" ><i class="<?=@$data['fwicon']['circle-info'];?> text-danger fa-2x mt-2"></i></a>
</div>
<div class="float-start w-75 text-end">  
<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_acquirer_add_edit'])&&$_SESSION['clients_acquirer_add_edit']==1)||(isset($_SESSION['merchant_action_add_associate_account'])&&$_SESSION['merchant_action_add_associate_account']==1)){?>
	
			<a onClick="viewAll(this,'.merSettingInfo .aq_n1','.aq_div1','.slide_next1')"  class="btn btn-sm btn-primary  my-2"> + Expand</a>
		
		<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_acquirer_add_edit'])&&$_SESSION['clients_acquirer_add_edit']==1)){?>
			<a href="<?=@$data['Admins'];?>/<?=@$data['my_project'];?><?=@$data['ex']?>?id=<?=@$post['MemberInfo']['id']?>&action=insert_mer_setting&type=<?=@$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>"  class="btn btn-primary btn-sm my-2"> <i class="<?=@$data['fwicon']['circle-plus'];?>"></i> Add New Acquirer</a>
			<? } ?>
	<? if($post['MemberInfo']['sponsor']) { ?>
		<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_add_associate_account'])&&$_SESSION['merchant_action_add_associate_account']==1)){?>
		
			<a href="<?=@$data['Admins'];?>/<?=@$data['my_project'];?><?=@$data['ex']?>?id=<?=@$post['MemberInfo']['id']?>&action=insert_mer_setting_associate&type=<?=@$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" class="btn btn-primary btn-sm my-2"> <i class="<?=@$data['fwicon']['circle-plus'];?>"></i> Add New Gateway Partner</a>
		
		<? } ?>
	<? } ?>

<? } ?>
		</div>
</div>
<? 
//print_r($post['merSettingInfo']);
		$merSettingInfo=$post['merSettingInfo'];
		if($merSettingInfo){ ?>
        <div class="merSettingInfo acc_tb" >
          <? $acc_arr= array(); $gPartnerAcq= array();	$j=0;
			$_SESSION['gPartnerAcq_'.$post['gid']]=array();
		     foreach($merSettingInfo as $key=>$val){
				
			 // fetch MOP Data from acquirer_table 
			 $mop_data=select_tablef($where_pred=" `acquirer_id`={$val['acquirer_id']} ", $tbl='acquirer_table', $prnt=0, $limit=1, $select='`mop`');
			 if(isset($mop_data['mop'])&&$mop_data['mop']){
			 $mop_logo=mop_option_list_f(2,$mop_data['mop']);
			 }else{
			 $mop_logo="";
			 }
				$pro_cur=$val['acquirer_processing_currency'];
				
				$shorting_ar[$val['acquirer_id']]=$val['acquirer_display_order'];
				$gPartnerAcq[]=$val['acquirer_id'];
				if(isset($j)&&$j&&isset($merSettingInfo[$j-1])){ $prev= $merSettingInfo[$j-1];}else{ $prev= $merSettingInfo[0];}
				
				if(isset($j)&&$j&&isset($merSettingInfo[$j+1])){
					$next= $merSettingInfo[$j+1];
				}
				
				if(isset($next['assignee_type'])&&$next['assignee_type']=="2"&&isset($next['acquirer_id'])&&$next['acquirer_id']==$val['acquirer_id']){
				
					$next_element = $val['id']." accts_m";	
				}elseif($prev['assignee_type']=="2"&&$prev['acquirer_id']==$val['acquirer_id']){
					$next_element = $val['id']." accts_m";	
				}else{
					$next_element = $j;
				}
	  
				if($val['assignee_type']=="2" ){
					$next_element = $val['id']." accts_r";	
					
					$acc_arr[1]="Commission";$usertypelabel="Gateway Partner";$usertype="GATEWAY PARTNER";$usertype_nam="_associate";}
				else{
					$acc_arr[1]="Discount";$usertypelabel="Acquirer";$usertype="ACQUIRER";$usertype_nam="";		
				}
				$crbk_1="Charge Back Fee 1%";$crbk_2="Charge Back Fee 1%<3%";$crbk_3="Charge Back Fee 3%<";
				
				
				
				if($val['salt_id']&&in_array((int)$val['salt_id'],$data['smDb']['salt_id'])){
				   $sm=$data['smDb'][$val['salt_id']];	//$sm=select_table_details($val['salt_id'],'salt_management',0);
				}else{
					$sm=array();
				}
		  ?>
		 
          <div class="acounts accts<?=@$val['assignee_type'];?> <?=@$next_element;?>" data-rows="<?=@$val['acquirer_id']?>" id="ac<?=@$val['acquirer_id']?>" >

<div class="aq_div1">
			 
<div 6666 class="aq_p1 <?=($val['acquirer_processing_mode']==3?'inactive_act_div':'')?>">
				
				
<div  class="input ">
    <span class="py-2 rounded text-white slide_next1  btn btn-primary w-100 text-start" onclick="slide_next1(this,'.aq_n1','2')"  title="Click for View Details" >&nbsp;<i class="<?=@$data['fwicon']['hand'];?>"></i>&nbsp;<?=ucwords(strtolower($usertype));?> Id :
				
				<?if(isset($data['acquirer_list'][$val['acquirer_id']])&&$val['acquirer_id']>0){?>
				  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_acquirer_label'])&&$_SESSION['merchant_acquirer_label']==1)){?>
					( <?=@$data['acquirer_list'][$val['acquirer_id']]?> ) <!--<span title="Checkout Label Name"><?=@$val['checkout_label_web']?></span>--><span title="Mop" class="mop_primary"><?=@$mop_logo;?></span>
				  <? }else{ ?>
					<?=@$val['acquirer_id']?> =  <?=@$data['acquirer_name'][$val['acquirer_id']]?> 
				  <?}?>
				<?}?>
				  
</span>
				   
                
			  
<div class="<?=($val['acquirer_processing_mode']==3?'inactive_act aq_n1':'')?>" >
				
				<div class="row m-1  border rounded text-start text-white">
				
					<div class="col-sm-6 my-2"><strong>Display Order: </strong><span title="Shorting"><b><?=@$val['acquirer_display_order']?></b></span></div>
					
					<div class="col-sm-6 my-2"><strong>Processing Mode: </strong><?php $proc_mode="Test";
					if($val['acquirer_processing_mode']=="1"){
					$proc_mode="LIVE"; 
					$proc_string="&nbsp;&nbsp;
					(<a target='_top' onclick='popuploadig();' href='{$data['Admins']}/{$data['my_project']}{$data['ex']}?id=".$post['MemberInfo']['id']."&action=detail&bid={$val['id']}&type=active&code=303&ac=".$val['acquirer_id']."'>Inactive</a>
					 | <a target='_top' onclick='popuploadig();' href='{$data['Admins']}/{$data['my_project']}{$data['ex']}?id=".$post['MemberInfo']['id']."&action=detail&bid={$val['id']}&type=active&code=302&ac=".$val['acquirer_id']."'>Test</a>)"; 
					}elseif($val['acquirer_processing_mode']=="2")
						{$proc_mode="TEST"; 
						$proc_string=" (<a target='_top' onclick='popuploadig();' href='{$data['Admins']}/{$data['my_project']}{$data['ex']}?id=".$post['MemberInfo']['id']."&action=detail&bid={$val['id']}&type=active&code=301&ac=".$val['acquirer_id']."'>Live</a> | <a target='_top' onclick='popuploadig();' href='{$data['Admins']}/{$data['my_project']}{$data['ex']}?id=".$post['MemberInfo']['id']."&action=detail&bid={$val['id']}&type=active&code=303&ac=".$val['acquirer_id']."'>Inactive</a>)";}
					elseif($val['acquirer_processing_mode']=="3")
						{$proc_mode="IN-ACTIVE"; 
						$proc_string=" (<a target='_top' onclick='popuploadig();' href='{$data['Admins']}/{$data['my_project']}{$data['ex']}?id=".$post['MemberInfo']['id']."&action=detail&bid={$val['id']}&type=active&code=301&ac=".$val['acquirer_id']."'>Live</a> | <a target='_top' onclick='popuploadig();' href='{$data['Admins']}/{$data['my_project']}{$data['ex']}?id=".$post['MemberInfo']['id']."&action=detail&bid={$val['id']}&type=active&page=0&code=302&ac=".$val['acquirer_id']."'>Test</a>)";}
				 echo "<font color='green'><b>".$proc_mode."</b></font>".$proc_string; ?></div>
					
					
					
<div class="col-sm-6 my-2"><strong>Default Currency: </strong><?=@$pro_cur?></div>
					
<div class="col-sm-6 my-2"><strong><?=@$usertypelabel;?> <?=@$acc_arr[1];?> Rate:</strong> <?=@$val['mdr_rate']?> %</div>

<?if(isset($val['gst_rate'])&&$val['gst_rate']){?>
	<div class="col-sm-6 my-2"><strong><?=@$usertypelabel;?> GST Rage: </strong> <?=@$val['gst_rate']?> % </div>
	
<?}?>
					
<div class="col-sm-6 my-2"><strong><?=@$usertypelabel;?> Trxn. Fee (Success):</strong> <?=@$val['txn_fee_success']?> <?=@$pro_cur?></div>
					
<div class="col-sm-6 my-2"><strong><?=@$usertypelabel;?> Trxn. Fee (Failed):</strong> <?=@$val['txn_fee_failed']?> <?=@$pro_cur?></div>
					
<? if($val['assignee_type']!="2" ) { ?>
					
<div class="col-sm-6 my-2"><strong>Rolling Reserve:</strong> <?=@$val['reserve_rate']?>% for <?=@$val['reserve_delay']?> days</div>
					

				
				</div>

			 </div>
	 </div>		  
			  <div class="aq_n1 hide">
			  
				
			<? if($val['json_log_history']){?>	
			
				
					  <div class="m-2" style="float:left;width:100%;clear:both !important;">
					  	<?echo json_log_view($val['json_log_history'],'View Json Log','0','mer_setting','','calc(100vw - 200px)');?>
					  <?/*?>
					  <div type="button" class="btn btn-success my-2" style="word-wrap:break-word;background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:98vw;display:block;max-width:94%;text-align:left;"><?=html_entity_decodef(@$val['json_log_history']);?></div>
					  <?*/?>
					  </div>
      
			 <? } ?>
			  <!-- Div Starts -->
			  
    
			  <!-- Div Starts -->
			  <div class="row m-1  border rounded text-start bd-blue-100 text-white">
				
				 <? if(!isset($val['scrubbed_json'])){ ?>
					<div class="col-sm-6 my-2"><strong>Scrubbed Period: </strong><? if($val['scrubbed_period']){?> <?=@$val['scrubbed_period'];?> Days <? }?></div>
					
                	<div class="col-sm-6 my-2"><strong>Min Trxn Limit: </strong><? if($val['min_limit']){?>
                  <?=@$val['min_limit']?> <?=@$pro_cur?>
                  <? }?></div>
				  
					<div class="col-sm-6 my-2"><strong>Max Trxn Limit: </strong><?=@$val['max_limit']?> <?=@$pro_cur?></div>
					
					<div class="col-sm-6 my-2"><strong>Min Success Count: </strong><?=($val['tr_scrub_success_count'])?$val['tr_scrub_success_count']:'2'?></div>
					
					<div class="col-sm-6 my-2"><strong>Min Failed Count: </strong><?=($val['tr_scrub_failed_count'])?$val['tr_scrub_failed_count']:'5'?></div>
					
					<div class="col-sm-6 my-2"><strong>Trxn Count: </strong><?=@$val['trans_count']?></div>
				<? } ?>		
					<div class="col-sm-6 my-2 hide"><strong>Setup Fee (USD):</strong><?=@$val['setup_fee']?></div>
				
					<div class="col-sm-6 my-2 hide"><strong>Setup Fee Collected:</strong>
					
				<?php if (@$val['setup_fee_status']==1){
				 ?>
				
				 	<a target="hform" onclick="popuploadig();" href="<?=@$data['Admins'];?>/<?=@$data['my_project'];?><?=@$data['ex']?>?action=detail&type=active&id=<?=@$post['MemberInfo']['id']?>&ac=<?=@$val['acquirer_id']?>&code=304" class="text-success">
					 Collected <i class="<?=@$data['fwicon']['circle-check'];?>"></i></span>
				 </a>
				 <?php } else { ?>
				
				 <a target="hform" onclick="popuploadig();" href="<?=@$data['Admins'];?>/<?=@$data['my_project'];?><?=@$data['ex']?>?action=detail&type=active&id=<?=@$post['MemberInfo']['id']?>&ac=<?=@$val['acquirer_id']?>&code=305" class="text-danger">
				 	Not Collected  <i class="<?=@$data['fwicon']['circle-cross'];?>"></i></a>
				 <?php } ?></div>
		  
		     </div>
				<!-- Div Ends -->	
			<? if(isset($val['scrubbed_json'])&&$val['scrubbed_json']){?>	
			<div class="row m-1 border rounded text-start bd-green-100 text-dark" >
				 
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
				<div class="col-sm-12 my-1"><strong>Scrubbed Period:</strong> <?=@$cap;?> </div>
				
				<div class="col-sm-6 my-1"><strong>Min. Trxn Limit:</strong> <?=@$v['min_limit']?> <?=@$pro_cur?></div>
				
				<div class="col-sm-6 my-1"><strong>Max Trxn Limit:</strong> <?=@$v['max_limit']?> <?=@$pro_cur?></div>
				
				<div class="col-sm-6 my-1"><strong>Min Success Count:</strong> <?=@$v['tr_scrub_success_count'];?></div>
				
				<div class="col-sm-6 my-1"><strong>Min Failed Count:</strong> <?=@$v['tr_scrub_failed_count'];?></div>
				
				<div class="col-sm-6 my-1"><strong>Trxn Count:</strong> <?=($v['tr_scrub_success_count'] + $v['tr_scrub_failed_count'])?></div>
				
				<div style="height: 10px;float: left;width: 100%;clear: both;">&nbsp;&nbsp;</div>
				<hr>
					
				 <?
				  }$j++;
				    }
				 ?>
					
			 </div>		
			<? }?>	
			
			  <!-- Div Starts -->
			  <div class="row m-1  border rounded text-start bd-red-100 text-dark">
			  
					<div class="col-sm-6 my-2 hide"><strong>Monthly Maintenance Fee: </strong><?=@$val['monthly_fee']?> <?=@$pro_cur?></div>
					<div class="col-sm-6 my-2"><strong><?=@$crbk_1;?>:</strong> <?=@$val['charge_back_fee_1']?></div>
					
					<div class="col-sm-6 my-2"><strong><?=@$crbk_2;?>:</strong> <?=@$val['charge_back_fee_2']?></div>
					
					<div class="col-sm-6 my-2"><strong><?=@$crbk_3;?>:</strong> <?=@$val['charge_back_fee_3']?></div>
					
					<? if(isset($val['cbk1'])&&$val['cbk1']){ ?>
					<div class="col-sm-6 my-2"><strong>CBK1:</strong> <?=@$val['cbk1']?></div>
					
					<? } ?>
					<div class="col-sm-6 my-2"><strong>Refund Fee:</strong> <?=@$val['refund_fee']?> <?=@$pro_cur?></div>
					
					
					<div class="col-sm-6 my-2"><strong>Settlement Period: </strong><?=@$val['settelement_delay']?> Days</div>
					
					
					
              <div class="col-sm-6 my-2 hide"><strong>Virtual Terminal Fee:</strong> <?=@$val['virtual_fee']?> <?=@$pro_cur?></div>
			<div class="col-sm-6 my-2 hide"><strong>MOTO:</strong> <?php $moto_status="Not Allowed"; if($val['moto_status']=="1"){$moto_status="Allowed";}if($val['moto_status']=="2"){$moto_status="Not Allowed";} echo $moto_status; ?></div>
					
					
					</div>
					<!-- Div Ends -->	
		
				<div class="row m-1 border rounded text-start bd-yellow-100 text-dark" >
				<? if(@$val['salt_id']){ ?>
					<div class="col-sm-6 my-2"><strong> Bank Salt ID : </strong>
					<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['edit_salt'])&&$_SESSION['edit_salt']==1)){ ?>
						<a class="saltpop99 datahref1 hrefmodal1 nopopup" onclick="iframe_open_modal(this);" data-ihref="<?=@$data['Admins'];?>/salt_management<?=@$data['ex']?>?id=<?=@$val['salt_id']?>&action=update&hideAllMenu=1&type=active" style="background-color:<?=($sm['salt_status']==1?"#37a238":"#f24a02");?>!important;color:#fff!important;border:0px solid #37a238 !important;display:inline-block;width:80px;text-align:center;padding:5px 0;margin:6px 0 0 0;border-radius:3px;">Edit Salt</a>
					<? } ?>
				
						<pre><?=(@$val['salt_id']." | <b>".@$sm['salt_name']."</b> | ".@$sm['acquirer_processing_creds']);?></pre>
					</div>
				<? }else{ ?>
					<div class="col-sm-12 my-2" ><strong>Acquirer Processing json : </strong><span ><?=@$val['acquirer_processing_json'];?></span></div>
				
				<? } ?>
				
			  	<div class="col-sm-6 my-2"><strong>Checkout label Name [web] : </strong><?=@$val['checkout_label_web']?></div>
				
			  	<div class="col-sm-6 my-2"><strong>Checkout label Name [mobile] : </strong><?=@$val['checkout_label_mobile']?></div>
				
				<div class="col-sm-6 my-2 hide"><strong>Merchant Preferences :</strong>

						<?php if(strpos($val['encrypt_email'],"001")!==false)
						{echo "(Notification to Merchant on Approved.";}?> 
						
						<?php if(strpos($val['encrypt_email'],"004")!==false)
						{echo "(Notification to Merchant on Declined.";}?> 
						
						<?php if(strpos($val['encrypt_email'],"002")!==false)
						{echo " Notification to Customer)";}?> 
						<?php if(strpos($val['encrypt_email'],"003")!==false)
						{echo " Money Request)";}?> 
						<?php if(strpos($val['encrypt_email'],"005")!==false){echo "Encrypt Customer Email";}?>
					</div>
				
				
				
				<? if(isset($val['mdr_visa_rate'])&&$val['mdr_visa_rate']){ ?>
				<div class="col-sm-6 my-2"><strong>Visa Rate: </strong><?=@$val['mdr_visa_rate']?></div>
				
				<? } ?>
				<? if(isset($val['mdr_mc_rate'])&&$val['mdr_mc_rate']){ ?>
				<div class="col-sm-6 my-2"><strong>Master Rate: </strong><?=@$val['mdr_mc_rate']?></div>
				
				<? } ?>
				<? if(isset($val['mdr_jcb_rate'])&&$val['mdr_jcb_rate']){ ?>
				<div class="col-sm-6 my-2"><strong>JCB Rate: </strong><?=@$val['mdr_jcb_rate']?></div>
			  	
				<? } ?>
				<? if(isset($val['mdr_amex_rate'])&&$val['mdr_amex_rate']){ ?>
				<div class="col-sm-6 my-2"><strong>Amex Rate: </strong><?=@$val['mdr_amex_rate']?></div>
               <? } ?>
				
				</div>
			  
			  
	
			 
			  <div class="row m-1 border text-start acc_hide" style="background: #c1d5ac;">
				<div class="col-sm-6 my-2"><strong>Account Custom field 14:</strong> <?=@$val['mop']?></div>
			  </div>
			  
			  <div class="row m-1 border text-start acc_hide" style="background: #c1d5ac;">
				<div class="col-sm-6 my-2"><strong>Login Required:</strong> <?php $login_required="Not Allowed"; if(@$val['login_required']=="1"){$login_required="Allowed";}if(@$val['login_required']=="2"){$login_required="Not Allowed";} echo $login_required; ?></div>
			  </div>
				
              <? }  ?>
			  
			
<? 
if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_add_associate_account'])&&$_SESSION['merchant_action_add_associate_account']==1)){
?>
<div class="col-sm-12 text-center my-2"><?php /*?><strong><?=ucfirst($usertype);?> : </strong><?php */?>
<div class="btn-group" role="group" aria-label="Basic example">
<a href="<?=@$data['Admins'];?>/<?=@$data['my_project'];?><?=@$data['ex']?>?id=<?=@$post['MemberInfo']['id']?>&action=insert_mer_setting<?=@$usertype_nam;?>&type=<?=@$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>"  class="btn btn-outline-primary"><i class="<?=@$data['fwicon']['circle-plus'];?>"></i></a> 

 <a href="<?=@$data['Admins'];?>/<?=@$data['my_project'];?><?=@$data['ex']?>?id=<?=@$post['MemberInfo']['id']?>&bid=<?=@$val['id']?>&action=update_mer_setting<?=@$usertype_nam;?>&type=<?=@$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" class="btn btn-outline-primary"><i class="<?=@$data['fwicon']['edit'];?> text-success"></i></a> 

 <a href="<?=@$data['Admins'];?>/<?=@$data['my_project'];?><?=@$data['ex']?>?id=<?=@$post['MemberInfo']['id']?>&bid=<?=@$val['id']?>&action=delete_mer_setting&type=<?=@$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" onClick="return confirm('Are you Sure to Delete this')" class="btn btn-outline-primary"><i class="<?=@$data['fwicon']['delete'];?> text-danger"></i></a> 
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
        <? if (!$post['merSettingInfo']){ ?>
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