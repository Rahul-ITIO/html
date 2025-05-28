<? if(isset($data['ScriptLoaded'])){  ?>

<?
	$data['payout_types']=[1=>'e-Check Payment',2=>'2D Card Payment',3=>'3D Card Payment',4=>'Wallets Payment',5=>'Click Zep Project',6=>'UPI Payment',7=>'Net Banking Payment',8=>'Nodal Account Payment',9=>'Coins Payment',9=>'Network Payment',99=>'Other Payment'];
	$data['connection_methods']=[1=>'Direct (Curl Option)',2=>'Redirect (Get Method)',3=>'Redirect (Post Method)',4=>'Whitelisting IP - Direct (Curl Option)',5=>'Whitelisting IP - Redirect (Post Method)'];
	
	//echo $_SESSION['action_success'];
?>
<div class="container border my-1 rounded">
<?php /*?> <? if((isset($data['sucess'])&& $data['sucess'])){ ?>
    <div class="alert alert-success alert-dismissible my-2">
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      <strong>Success! </strong>
      <?=prntext($post['success'])?>
    </div>
    <? }?><?php */?>
	<? if((isset($_SESSION['action_success'])&& $_SESSION['action_success'])){ ?>
    <div class="alert alert-success alert-dismissible my-2">
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      <strong>Success! </strong>
      <?=$_SESSION['action_success']?>
    </div>
    <? 
	unset($_SESSION['action_success']); 
	}
	?>
	
	 <? if((isset($_SESSION['action_success'])&& $_SESSION['action_success'])){ ?>
    <div class="alert alert-success alert-dismissible my-2">
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      <strong>Success! </strong>
      <?=$_SESSION['action_success']?>
    </div>
    <? 
	unset($_SESSION['action_success']); 
	}
	?>
	
<script>
function payout_typef(theValue){
	if(theValue=="5"){
		$('.noneClick').slideUp(500);
		$('#scrubbed_period option[value="1"]').prop('selected','selected');
		$('#account_login_url option[value="1"]').prop('selected','selected');
		$('#processing_currency option[value="₹ INR"]').prop('selected','selected');
		$('#settelement_period option[value="1"]').prop('selected','selected');
	}else{
		$('.noneClick').slideDown(1500);
	}
}


function textAreaAdjust(o) {
 // o.style.height = "1px";
 // o.style.height = (10+o.scrollHeight)+"px";
}


$(document).ready(function(){ 
	
	//$(".textAreaAdjust").trigger("keyup");
	textAreaAdjustf('.textAreaAdjust');
	//textAreaAdjustf('');
	$('#payout_type').trigger('change');
    
});
</script>
 
  
  <form method="post" name="data">
    <input type="hidden" name="step" value="<?=$post['step']?>">


  
	
	
	
    <? if($post['step']==1){ ?>
    <div class="container row text-end px-0 title_addnew_common">
      <div class="col-sm-6 ps-0 text-start">
        <div class="container vkg px-0">
          <h4 class="my-2"><i class="<?=$data['fwicon']['bank'];?>"></i> Bank Table <a data-ihref="<?=$data['Admins']?>/json_log_all<?=$data['ex']?>?tablename=bank_payout_table" title="View Json Log History" onclick="iframe_open_modal(this);"><i class="<?=$data['fwicon']['circle-info'];?> text-danger fa-fw"></i></a></h4>
          <div class="vkg-main-border"></div>
        </div>
      </div>
      <div class="col-sm-6 my-2 ps-0 text-end">
        <button type="submit" name="send" value="Add A New Bank" class="btn btn-primary" title="Add A New Bank"><i class="<?=$data['fwicon']['circle-plus'];?>"></i></button>
      </div>
    </div>
   <div class="container table-responsive">
      <table class="table table-hover">
        <thead>
          <tr>
		    <th scope="col">#</th>
            <th scope="col">Status</th>
            <th scope="col">A/c No. | Mode | A/c Name</th>
            <th scope="col">Bank Live URL</th>
			<th scope="col">Bank Test URL</th>
            <th scope="col" title="Processing Currency" class="hide-768">Pro.Curr.</th>
            
            <th scope="col">Action</th>
          </tr>
        </thead>
        <? 
			$j=1; 
			foreach($post['result_list'] as $key=>$value) {
			

		if(isset($value['payout_json'])&&$value['payout_json']){
			$value['acq']=isJsonDe($value['payout_json']);
			$value['a_arr']=isJsonDe($value['payout_json']);
			$pro_cur=(isset($value['a_arr']['processing_currency'])?$value['a_arr']['processing_currency']:'');
			//echo "<br/><br/>a_arr({$value['payout_id']})=>"; print_r($value['a_arr']);
			if($value['acq']){
				foreach($value['acq'] as $key2=>$value2){
					if(is_array($value2)){
						$value['acq'][$key2]=json_encode($value2);
					}
				}
			} 
		}
	?>
        <tr>
		<td><a data-bs-toggle="modal" data-count="<?=prntext($value['id'])?>" class="tr_open_on_modal text-decoration-none" data-bs-target="#myModal"><i class="<?=$data['fwicon']['display'];?> text-link pointer" title="View details"></i></a></td>
        <td> <? if(@$value['payout_status']==1){ ?> Active <? }elseif(@$value['payout_status']==2){ ?> Common <? }else{ ?> Inactive <? }?>
        </td>
          <td  data-label="A/c No./Mode - "><span class="text-wrap" style="max-width: 200px;" title="<? if(isset($value['payout_id'])) echo @$value['payout_id'];?> | <? if(isset($value['payout_prod_mode'])&&$value['payout_prod_mode']==1){echo "Live";}else{echo "Test";}?> ">
            <? if(isset($value['payout_id'])) echo @$value['payout_id'];?>
            |
            <? if(isset($value['payout_prod_mode'])&&$value['payout_prod_mode']==1){echo "Live";}else{echo "Test";}?>
			
			 <? if(isset($value['acq']['checkout_level_name'])) echo " | ".$value['acq']['checkout_level_name'];?>
			
            </span></td>
			
			
          <td  data-label="Bank Url - "><div title="<?=prntext(lf($value['bank_payment_url'],50,1));?>" class="short_display_on_mobile"><a  class="dotdot nomid modal_for_iframe" data-ihref='<?=$data['Admins'];?>/json_pretty_print<?=$data['ex']?>?json=<?=encryptres($value['bank_payment_url']);?>' href='<?=$data['Admins'];?>/json_pretty_print<?=$data['ex']?>?json=<?=encryptres($value['bank_payment_url']);?>' >
            <?=prntext(lf($value['bank_payment_url'],50,1));?></a>
            </div></td>
			
		 <td title='<?=$value['payout_uat_url']?>' class="hide-768"><? if(isset($value['payout_uat_url'])&&$value['payout_uat_url']){?>
            <a class="text-wrap" href="<?=$value['payout_uat_url']?>" title="<?=$value['payout_uat_url']?>"  target="_blank"> <i class="<?=$data['fwicon']['external-url'];?> text-success" title="<?=$value['payout_uat_url']?>"></i> <?=$value['payout_uat_url']?> </a>
            <? } ?>
          </td>
		  
          <td title='<?=$value['payout_processing_currency']?>' class="hide-768"><span class='text-wrap'>
            <?=$value['payout_processing_currency']?>
            </span></td>
          
          
         
		  
		  
          <td data-label="Action - " class="text-wrap" ><? if(isset($_SESSION['login_adm'])){ ?>
            <div class="btn-group dropstart short-menu-auto-main"> <a data-bs-toggle="dropdown" aria-expanded="false"  title="Action"><i class="<?=$data['fwicon']['action'];?> text-link"></i> </a>
                <ul class="dropdown-menu dropdown-menu-icon pull-right" >
                  <li> <a class="dropdown-item" href="<?=$data['Admins'];?>/bank<?=$data['ex']?>?id=<?=$value['id']?>&action=update" title="Edit" ><i class="<?=$data['fwicon']['edit'];?> text-success fa-fw float-start"></i> <span class="action_menu">Edit</span></a></li>
				  
                  <li> <a class="dropdown-item" href="<?=$data['Admins'];?>/bank<?=$data['ex']?>?id=<?=$value['id']?>&action=duplicate" title="Duplicate" onclick="return confirm('Are you Sure to Create Duplicate');"><i class="<?=$data['fwicon']['copy'];?>  fa-fw float-start"></i> <span class="action_menu">Create Duplicate</span></a></li>

                  <li> <a class="dropdown-item"  href="<?=$data['Admins'];?>/bank<?=$data['ex']?>?id=<?=$value['id']?>&action=delete" onclick="return confirm('Are you Sure to Delete');" title="Delete"><i class="<?=$data['fwicon']['delete'];?> text-danger  fa-fw float-start"></i> <span class="action_menu">Delete</span></a></li>
				  
			<? if(isset($value['json_log_history'])&&$value['json_log_history']){?>
			<li> 
			<a class="dropdown-item" onclick="popup_openv('<?=$data['Host']?>/include/json_log<?=$data['ex']?>?tableid=<?=$value['id'];?>&tablename=bank_payout_table')" title="View Json History">
		<i class="<?=$data['fwicon']['circle-info'];?> text-info float-start"></i> <span class="action_menu">Json History</span>
			</a>
			</li>
			<? } ?>

                </ul>
              </div>
			

            <? }?>
          </td>
        </tr>
   <tr class="hide">
    <td colspan="8">
	 <div class="next_tr_<?=prntext($value['id']);?> hide row">
	 <div class="mboxtitle hide">Bank Detail : <?=$value['id'];?>s</div>
	 
              <div class="row border bg-light my-2 text-start rounded">
                <div class="row col-sm-6">
                  <div class="card my-2">Bank Payout Status :
                    <? if($value['payout_status']==1){ ?>
                    Active
                    <? }elseif($value['payout_status']==2){ ?>
                    Common
                    <? }else{ ?>
                    Inactive
                    <? }?>
                  </div>
                </div>
                <div class="row col-sm-6 ">
                  <div class="card my-2">Payout Mode :
                    <? if($value['payout_prod_mode']==1){echo "Live";}else{echo "Test";}?>
                  </div>
                </div>
                <? if(isset($value['payout_id'])&&$value['payout_id']){?>
                <div class="row col-sm-6 ">
                  <div class="card my-2">Payout ID. :
                    <? if(isset($value['payout_id'])) echo prntext($value['payout_id']);?>
                    /
                    <? if(isset($data['t'][$value['payout_id']]['name1'])) echo prntext($data['t'][$value['payout_id']]['name1']);?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['payout_types'])&&$value['payout_types']){?>
                <div class="row col-sm-6 ">
                  <div class="card my-2">Payout Type :
                    <? if(isset($data['payout_types'][$value['payout_type']])) echo prntext($data['payout_types'][$value['payout_type']]);?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['connection_methods'])&&$value['connection_methods']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Payout to Connect :
                    <? if(isset($data['connection_methods'][$value['connection_method']])) echo prntext($data['connection_methods'][$value['connection_method']]);?>
                  </div>
                </div>
                <? } ?>
               
			   
                
                
				
                <? if(isset($value['payout_wl_ip'])&&$value['payout_wl_ip']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">If Static Billing IP :
                    <? if(isset($value['payout_wl_ip'])) echo $value['payout_wl_ip'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['bank_login_url'])&&$value['bank_login_url']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Bank Login URL :
                    <? if(isset($value['bank_login_url'])) echo $value['bank_login_url'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['bank_user_id'])&&$value['bank_user_id']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Bank User Id :
                    <? if(isset($value['bank_user_id'])) echo $value['bank_user_id'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['bank_login_password'])&&$value['bank_login_password']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Bank Login Password :
                    <? if(isset($value['bank_login_password'])) echo $value['bank_login_password'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['bank_status_url'])&&$value['bank_status_url']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Bank Validate/Status :
                    <? if(isset($value['bank_status_url'])) echo $value['bank_status_url'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['bank_process_url'])&&$value['bank_process_url']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Domain for Callback/Process :
                    <? if(isset($value['bank_process_url'])) echo $value['bank_process_url'];?>
                  </div>
                </div>
                <? } ?>
                <? 
			   ?>
                <? if(isset($value['payout_processing_currency'])&&$value['payout_processing_currency']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Processing Currency for Bank :
                    <? if(isset($value['payout_processing_currency'])) echo prntext($value['payout_processing_currency'])?>
                  </div>
                </div>
                <? } ?>

                <? if(isset($value['bank_payment_url'])&&$value['bank_payment_url']){?>
                <div class="row col-sm-12">
                  <div class="card my-2">Bank Payment Live URL : <a href='<?=prntext($value['bank_payment_url']);?>' target="_blank">
                    <?=prntext($value['bank_payment_url']);?>
                    </a> </div>
                </div>
                <? } ?>
                <? if(isset($value['bank_payment_url'])&&$value['bank_payment_url']){?>
                <div class="row col-sm-12">
                  <div class="text-wrap card my-2">Bank Payment Test URL : <a  href='<?=prntext($value['bank_payment_url']);?>' target="_blank">
                    <?=prntext($value['payout_uat_url']);?>
                    </a></div>
                </div>
                <? } ?>
                <? if(isset($value['developer_url'])&&$value['developer_url']){?>
                <div class="row col-sm-12">
                  <div class="text-wrap card my-2">Bank Developer API URL :
                    <?=$value['developer_url'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['encode_processing_creds'])&&$value['encode_processing_creds']){?>
                <div class="row col-sm-12">
                  <div class="text-wrap card my-2">Bank Json :
                    <?=decode_f($value['encode_processing_creds']);?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['tech_comments'])&&$value['tech_comments']){?>
                <div class=" rowcol-sm-12">
                  <div class="text-wrap card my-2">Note/Comments :
                    <?=$value['tech_comments'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['hard_code_url'])&&$value['acq']['hard_code_url']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Hard Code Payment URL : <a href='<?=$data['Host'];?>/<? if(isset($value['acq']['hard_code_url'])) echo ($value['acq']['hard_code_url']);?>' class="link-primary" target="_blank" >
                    <?=$data['Host'];?>/
                     <font style="font-style:italic;">
                    <? if(isset($value['acq']['hard_code_url'])) echo ($value['acq']['hard_code_url']);?>
                    </font></a> </div>
                </div>
                <?  }?>
                <? if(isset($value['acq']['hard_code_status_url'])&&$value['acq']['hard_code_status_url']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Hard Code Status URL : <a href='<?=$data['Host'];?>/<? if(isset($value['acq']['hard_code_status_url'])) echo ($value['acq']['hard_code_status_url']);?>' class="link-primary" target="_blank" >
                    <?=$data['Host'];?>/
                    <font style="font-style:italic;">
                    <? if(isset($value['acq']['hard_code_status_url'])) echo ($value['acq']['hard_code_status_url']);?>
                    </font></a> </div>
                </div>
                <? }?>
                <? if(isset($value['acq']['hard_code_live_status_url'])&&$value['acq']['hard_code_live_status_url']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Live Code Status URL : <a href='<?=$data['Host'];?>/<? if(isset($value['acq']['hard_code_live_status_url'])) echo ($value['acq']['hard_code_live_status_url']);?>' class="link-primary"  target="_blank" >
                    <?=$data['Host'];?>/
                    <font style="font-style:italic;">
                    <? if(isset($value['acq']['hard_code_live_status_url'])) echo ($value['acq']['hard_code_live_status_url']);?>
                    </font></a></div>
                </div>
                <? }?>
                <? if(isset($value['acq']['hard_code_refund_url'])&&$value['acq']['hard_code_refund_url']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Hard Code Refund URL : <a href='<?=$data['Host'];?>/<? if(isset($value['acq']['hard_code_refund_url'])) echo ($value['acq']['hard_code_refund_url']);?>' target="_blank" class="link-primary"  >
                    <?=$data['Host'];?>/<font style="font-style:italic;">
                    <? if(isset($value['acq']['hard_code_refund_url'])) echo ($value['acq']['hard_code_refund_url']);?>
                    </font></a> </div>
                </div>
                <? }?>
              </div>
			  <?/*?>  
              <div class="row border bd-yellow-100 text-start vkg px-2 my-2 rounded" >
                <div class="row btn btn-outline-light text-dark my-2 text-start" >Additional Bank Response</div>
                <? if(isset($value['acq']['br_success'])&&$value['acq']['br_success']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">B. Success Response :
                    <?=(isset($value['acq']['br_success'])?$value['acq']['br_success']:'');?>
                  </div>
                </div>
                <? }?>
                <? if(isset($value['acq']['br_failed'])&&$value['acq']['br_failed']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">B. Failed Response :
                    <?=(isset($value['acq']['br_failed'])?$value['acq']['br_failed']:'');?>
                  </div>
                </div>
                <? }?>
                <? if(isset($value['acq']['br_pending'])&&$value['acq']['br_pending']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">B. Pending Response :
                    <?=(isset($value['acq']['br_pending'])?$value['acq']['br_pending']:'');?>
                  </div>
                </div>
                <? }?>
                <? if(isset($value['acq']['br_status_path'])&&$value['acq']['br_status_path']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">Bank Status Path :
                    <?=(isset($value['acq']['br_status_path'])?$value['acq']['br_status_path']:'');?>
                  </div>
                </div>
                <? }?>
              </div>
              
			
			  <?*/?>
			  <div class="row border bd-blue-100 text-start vkg px-2 my-2 rounded" >
                <h4 class="row btn btn-outline-light text-dark text-start" >Bank Transaction</h4>
                <? if(isset($value['acq']['min_limit'])&&$value['acq']['min_limit']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">Min. Transaction Limit <font class="acct_curr">(
                    <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
                    ) :</font>
                    <?=(isset($value['acq']['min_limit'])&&$value['acq']['min_limit']?$value['acq']['min_limit']:"1");?>
                  </div>
                </div>
                <? }?>
                <? if(isset($value['acq']['max_limit'])&&$value['acq']['max_limit']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">Max. Transaction Limit<font class="acct_curr">(
                    <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
                    ) : </font>
                    <?=(isset($value['acq']['max_limit'])&&$value['acq']['max_limit']?$value['acq']['max_limit']:"500");?>
                  </div>
                </div>
                <? }?>
                <? if(isset($value['acq']['scrubbed_period'])&&$value['acq']['scrubbed_period']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">Scrubbed Period :
                    <? if(isset($value['acq']['scrubbed_period'])) echo $value['acq']['scrubbed_period']?>
                    Days</div>
                </div>
                <? }?>
                <? if(isset($value['acq']['transaction_count'])&&$value['acq']['transaction_count']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">Transaction Count :
                    <?=(isset($value['acq']['transaction_count'])&&$value['acq']['transaction_count']?$value['acq']['transaction_count']:"7");?>
                  </div>
                </div>
                <? }?>
                <? if(isset($value['acq']['tr_scrub_success_count'])&&$value['acq']['tr_scrub_success_count']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">Min. Success Count :
                    <?=(isset($value['acq']['tr_scrub_success_count'])&&$value['acq']['tr_scrub_success_count']?$value['acq']['tr_scrub_success_count']:'2');?>
                  </div>
                </div>
                <? }?>
                <? if(isset($value['acq']['tr_scrub_failed_count'])&&$value['acq']['tr_scrub_failed_count']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">Min. Failed Count :
                    <?=(isset($value['acq']['tr_scrub_failed_count'])&&$value['acq']['tr_scrub_failed_count']?$value['acq']['tr_scrub_failed_count']:'5');?>
                  </div>
                </div>
                <? }?>
                <? if(isset($value['acq']['setup_fee'])&&$value['acq']['setup_fee']){?>
                <span class="hide1 noneClick1"></span>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">Setup Fee (USD) :
                    <? if(isset($value['acq']['setup_fee'])) echo $value['acq']['setup_fee'];?>
                  </div>
                </div>
                <? }?>
                <? if(isset($value['acq']['setup_fee_status'])&&$value['acq']['setup_fee_status']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">Setup Fee  Collected :
                    <? if(isset($value['acq']['setup_fee_status'])&&$value['acq']['setup_fee_status']==1){echo "Yes";}else{echo "Not Yet";}?>
                  </div>
                </div>
                <? }?>
              </div>
              <div class="row border bd-red-100 text-start vkg px-2 my-2 rounded" >
                <h4 class="row btn btn-outline-light text-dark text-start"  style="color:#dc3545 !important;">Process Transaction</h4>
                <? if(isset($value['acq']['account_login_url'])&&$value['acq']['account_login_url']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">Processing Mode :
                    <? if(isset($value['acq']['account_login_url'])&&$value['acq']['account_login_url']==1){echo "Live";}elseif(isset($value['acq']['account_login_url'])&&$value['acq']['account_login_url']==2){echo "Test";}else{echo "Inactive";}?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['processing_currency'])&&$value['acq']['processing_currency']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">Default Currency :
                    <?
					if(isset($value['acq']['processing_currency']))
						$ac_processing_currency=get_currency($value['acq']['processing_currency'],1);
					?>
                    <? if(isset($value['acq']['processing_currency'])) echo $value['acq']['processing_currency'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['transaction_rate'])&&$value['acq']['transaction_rate']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">
                    <? if(isset($acc_arr[2])) echo $acc_arr[2];?>
                    Discount Rate(%) :
                    <? if(isset($value['acq']['transaction_rate'])) echo $value['acq']['transaction_rate'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['settelement_period'])&&$value['acq']['settelement_period']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">Settlement Period :
                    <? if(isset($value['acq']['settelement_period'])) echo $value['acq']['settelement_period']?>
                    Days </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['txn_fee'])&&$value['acq']['txn_fee']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">
                    <? if(isset($acc_arr[2])) echo $acc_arr[2];?>
                    Trxn Fee (Success) :
                    <? if(isset($value['acq']['txn_fee'])) echo $value['acq']['txn_fee'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['txn_fee_failed'])&&$value['acq']['txn_fee_failed']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">
                    <? if(isset($acc_arr[2])) echo $acc_arr[2];?>
                    Trxn Fee (Failed) :
                    <? if(isset($value['acq']['txn_fee_failed'])) echo $value['acq']['txn_fee_failed'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['shorting'])&&$value['acq']['shorting']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">Shorting :
                    <? if(isset($value['acq']['shorting'])) echo $value['acq']['shorting'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['rolling_period'])&&$value['acq']['rolling_period']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">Rolling Reserve :
                    <? if(isset($value['acq']['rolling_period'])) echo $value['acq']['rolling_period'];?>
                    Days</div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['settled_amt'])&&$value['acq']['settled_amt']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2"> Min. Settlement Amt. :<font class="acct_curr hide">(
                    <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
                    )</font>
                    <? if(isset($value['acq']['settled_amt'])) echo $value['acq']['settled_amt'];?>
                  </div>
                </div>
                <? } ?>
              </div>
              
              <div class="row border bd-green-100 text-start vkg px-2 my-2 rounded" >
                <h4 class="row btn btn-outline-light text-dark text-start text-white" style="color:#dc3545 !important;">Other Details</h4>
                <? if(isset($value['acq']['hkip_siteid'])&&$value['acq']['hkip_siteid']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">Bank Siteid :
                    <? if(isset($value['acq']['hkip_siteid'])) echo $value['acq']['hkip_siteid'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['checkout_level_name'])&&$value['acq']['checkout_level_name']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">Checkout Level Name :
                    <? if(isset($value['acq']['checkout_level_name'])) echo $value['acq']['checkout_level_name'];?>
                  </div>
                </div>
                <? } ?>
                
              </div>
            </div>
          </td>
        </tr>
        <? $j++; }?>
      </table>
    </div>
    <? }elseif($post['step']==2){?>
    <? if(isset($post['gid'])&&$post['gid']){?>
    <input type="hidden" name="gid" value="<?=$post['gid']?>">
    <input type="hidden" name="id" value="<?=(isset($post['id'])?$post['id']:'')?>">
    <input type="hidden" name="action" value="update_db">
    <? }else{ ?>
    <input type="hidden" name="action" value="insert">
    <? }?>
    <script>document.write('<input type=hidden name=aurl value="'+top.window.document.location.href+'">');</script>
    <?
?>
    <div class="container vkg px-1">
      <h4 class="my-2">
        <?php if(isset($post['gid'])&&$post['gid']){ ?>
        <i class="<?=$data['fwicon']['edit'];?>"></i> Edit
        <? } else { ?>
        <i class="<?=$data['fwicon']['circle-plus'];?>"></i> Add New
        <? } ?>
        Bank</h4>
      <div class="vkg-main-border"></div>
    </div>
    <?
	if(isset($post['json_log_history'])&&$post['json_log_history'])
	{?>
    <div class="row">
      <div class="col-sm-12 my-2"><? echo json_log_view($post['json_log_history'],'View Json Log','0','json_log','','100');?></div>
    </div>
    <?
	}?>
    <div class="badge rounded-pill bg-vdark mb-2 ms-1" style="display: inline-block !important;">
      <? if(isset($post['payout_status'])&&$post['payout_status']==1){?>
      Active
      <? }elseif(isset($post['payout_status'])&&$post['payout_status']==2){?>
      Common
      <? }else{ ?>
      Inactive
      <? }?>
      <? if(isset($post['payout_id'])&&isset($data['t'][$post['payout_id']]['name1']))
			echo prntext($data['t'][$post['payout_id']]['name1']).' / ';?>
      <? if(isset($post['payout_prod_mode'])&&$post['payout_prod_mode']==1){echo "Live";}else{echo "Test";}?>
    </div>
    <div class="bgc_10 row pe-2 p-1 rounded" id="bankgatewaycss">
      <?php	
									
		function getMondaysInRange1($dateFromString, $dateToString, $days='')
		{
			$dateFrom = new \DateTime($dateFromString);
			$dateTo = new \DateTime($dateToString);
			$dates = array();

			if ($dateFrom > $dateTo) {
				return $dates;
			}
			

			if (3 != $dateFrom->format('N')) {
				$dateFrom->modify("next $days");
			}

			while ($dateFrom <= $dateTo) {
				$dates[] = $dateFrom->format('Y-m-d');
				$dateFrom->modify('+1 week');
			}

			return $dates;
		}
		$fromDate 	= date("Y-m-d",strtotime("-10 day",strtotime(date("Y-m-01",strtotime("now") ) )));
		$toDate 	= date("Y-m-d",strtotime("+2 month",strtotime("now")));
		$alldate 	= getMondaysInRange1($fromDate,$toDate,"Wednesday");
		$alldatem 	= getMondaysInRange1($fromDate,$toDate,"Monday");
		//$alldate = getMondaysInRange("2017-05-01","2017-06-31");

		
		?>
      <div class="col-sm-6"> <span class="form-label" id="basic-addon4"> Payout Status :</span>
        <select name="payout_status" id="payout_status" class="form-select" required>
          <option value="" disabled selected> Payout Status</option>
          <option value="1">Active</option>
          <option value="0">Inactive</option>
          <option value="2">Common</option>
        </select>
        <? if(isset($post['payout_status']))
		{?>
        <script>$('#payout_status option[value="<?=prntext($post['payout_status'])?>"]').prop('selected','selected');</script>
        <? }?>
      </div>
      <div class="col-sm-6"> <span class="form-label" id="basic-addon4">Payout Mode :</span>
        <select name="payout_prod_mode" id="payout_prod_mode" class="form-select" required>
          <option value="" disabled selected>Payout Mode</option>
          <option value="1">Live</option>
          <option value="2">Test</option>
        </select>
        <? 
		if(isset($post['payout_prod_mode']))
		{?>
        <script>$('#payout_prod_mode option[value="<?=prntext($post['payout_prod_mode'])?>"]').prop('selected','selected');</script>
        <?
		}?>
      </div>
      <div class="col-sm-6"> <span class="form-label" id="basic-addon4">Payout ID. : </span>
        <input type="text" name="payout_id" id="payout_id" placeholder="Enter Payout ID. for Your API" class="form-control" value="<? if(isset($post['payout_id'])) echo prntext($post['payout_id'])?>"  />
      </div>
      <div class="col-sm-6"> <span class="form-label" id="basic-addon4">Channel Type : </span>
        <select name="payout_type" class="form-select" id="payout_type" onChange="payout_typef(this.value)" required>
          <option value="" disabled selected>Channel Type</option>
          <?
			foreach($data['channel'] as $k3=>$v3){
				echo "<option value='{$k3}'>{$k3}. {$v3['name1']} ({$v3['name2']})</option>";
			}
			?>
        </select>
        <?
		if(isset($post['payout_type']))
		{?>
        <script>$('#payout_type option[value="<?=prntext($post['payout_type'])?>"]').prop('selected','selected');</script>
        <?
		}
		?>
      </div>
      <div class="col-sm-6"> <span class="form-label" id="basic-addon4">Payout to Connect : </span>
        <select name="connection_method" class="form-select" id="connection_method" required>
          <option value="" disabled selected>Payout to Connect</option>
          <option value="1">Direct (Curl Option)</option>
          <option value="4">Whitelisting IP - Direct (Curl Option)</option>
          <option value="2">Redirect (Get Method)</option>
          <option value="3">Redirect (Post Method)</option>
          <option value="5">Whitelisting IP - Redirect (Post Method)</option>
        </select>
        <?
		if(isset($post['connection_method']))
		{
		?>
        <script>$('#connection_method option[value="<?=prntext($post['connection_method'])?>"]').prop('selected','selected');</script>
        <?
		}
		?>
      </div>
	  
	   <div class="col-sm-6"> <span class="form-label" id="basic-addon4">Processing Currency for Bank : </span>
        <select name="payout_processing_currency"  class="form-select" id="payout_processing_currency" >
          <option value="" disabled selected>Currency To</option>
          <?foreach ($data['AVAILABLE_CURRENCY'] as $k11) {?>
          <option value="<?=$k11?>">
          <?=$k11?>
          </option>
          <?}?>
        </select>
        <?
			if(isset($post['payout_processing_currency']))
			{?>
        <script>$('#payout_processing_currency option[value="<?=prntext($post['payout_processing_currency'])?>"]').prop('selected','selected');</script>
        <?
			}?>
      </div>
   
   
      
      <div class="col-sm-6"> <span class="form-label" id="basic-addon4">Bank Payment Live URL : </span>
        <textarea class="form-control" name="bank_payment_url" id="bank_payment_url" rows="3" placeholder="Bank Payment Live URL"><? if(isset($post['bank_payment_url'])) echo $post['bank_payment_url'];?>
</textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label" id="basic-addon4">Bank Payment Test URL : </span>
        <textarea class="form-control" name="payout_uat_url" id="payout_uat_url" rows="3" placeholder=""><? if(isset($post['payout_uat_url'])) echo $post['payout_uat_url'];?>
</textarea>
      </div>
      
		  <div class="col-sm-12 mt-2"> <span class="form-label" id="basic-addon4">Encode Processing Creds : </span>
        <textarea  class="textAreaAdjust form-control" onkeyup="textAreaAdjust(this)" name="encode_processing_creds" row="3" placeholder="Enter Bank Json"><? if(isset($post['encode_processing_creds'])) echo decode_f($post['encode_processing_creds']);?>
</textarea>
      </div>	
    
	
      <div class="col-sm-6"> <span class="form-label" id="basic-addon4">If Static / Whitelisting IP : </span>
        <textarea title="If Static Billing / Whitelisting IP " class="form-control" name="payout_wl_ip" id="payout_wl_ip" rows="3" placeholder=" " ><? if(isset($post['payout_wl_ip'])) echo $post['payout_wl_ip'];?>
</textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label" id="basic-addon4">Bank Login URL : </span>
        <textarea class="form-control" name="bank_login_url" id="bank_login_url" rows="3" placeholder='{"login_live_url":"","login_test_url":""}' ><? if(isset($post['bank_login_url'])) echo $post['bank_login_url'];?>
</textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label" id="basic-addon4">Bank User Id : </span>
        <textarea class="form-control" name="bank_user_id" id="bank_user_id" rows="3" placeholder='{"login_live_userId":"","login_test_userId":""}' ><? if(isset($post['bank_user_id'])) echo $post['bank_user_id'];?>
</textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label" id="basic-addon4">Bank Login Password : </span>
        <textarea class="form-control" name="bank_login_password" id="bank_login_password" rows="3" placeholder="" ><? if(isset($post['bank_login_password'])) echo $post['bank_login_password'];?>
</textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label" id="basic-addon4">Bank Developer API URL : </span>
        <textarea class="form-control" name="developer_url" id="developer_url" rows="3" placeholder="" ><? if(isset($post['developer_url'])) echo $post['developer_url'];?>
</textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label" id="basic-addon4">Bank Validate/Status : </span>
        <textarea class="form-control" name="bank_status_url" id="bank_status_url" rows="3" placeholder=" " ><? if(isset($post['bank_status_url'])) echo $post['bank_status_url'];?>
</textarea>
      </div>
      
      
     
    
      <div class="col-sm-6 mt-2"> <span class="form-label" id="basic-addon4">Tech Comments : </span>
        <textarea class="textAreaAdjust form-control" onkeyup="textAreaAdjust(this)"  name="tech_comments" row="3" placeholder="Enter Note"><? if(isset($post['tech_comments'])) echo $post['tech_comments'];?>
</textarea>
      </div>
	  <div class="col-sm-6 mt-2"> <span class="form-label" id="basic-addon4" title="Domain for Callback/Process">Domain for Callback : </span>
        <textarea class="textAreaAdjust form-control" name="bank_process_url" row="3"  id="bank_process_url" rows="3" placeholder=" https://my.domain.com" ><? if(isset($post['bank_process_url'])) echo $post['bank_process_url'];?>
</textarea>
      </div>
      <div class="col-sm-12"> <span class="form-label" id="basic-addon4" title="Hard Code Payment URL">Payment URL for Hardcode testing : </span>
        <textarea class="textAreaAdjust form-control" onKeyUp="textAreaAdjust(this)" name="acq[hard_code_url]" id="hard_code_url" placeholder="Enter Hard Code URL after Base URL " onfocusout="javascript:$('#after_base_hard_code_url').html(this.value);$('#a_after_base_hard_code_url').attr('href',$('#a_after_base_hard_code_url').text());" ><? if(isset($post['acq']['hard_code_url'])) echo $post['acq']['hard_code_url'];?>
</textarea>
      </div>

      <div id="emailHelp" class="form-text44 my-2"><i class="<?=$data['fwicon']['hand'];?>"></i> <a id="a_after_base_hard_code_url" href='<?=$data['Host'];?>/<? if(isset($post['acq']['hard_code_url'])) echo $post['acq']['hard_code_url'];?>' target="_blank" >
        <?=$data['Host'];?>/
        <span id="after_base_hard_code_url">
        <? if(isset($post['acq']['hard_code_url'])) echo $post['acq']['hard_code_url'];?>
        </span></a></div>
      <div class="col-sm-12"> <span class="form-label" id="basic-addon4" title="Hard Code Status URL">Status URL :</span>
        <textarea class="textAreaAdjust form-control" onKeyUp="textAreaAdjust(this)" row="3" name="acq[hard_code_status_url]" id="hard_code_status_url"  placeholder="Enter Hard Code URL after Base URL " onfocusout="javascript:$('#after_base_hard_code_status_url').html(this.value);$('#a_after_base_hard_code_status_url').attr('href',$('#a_after_base_hard_code_status_url').text());" ><? if(isset($post['acq']['hard_code_status_url'])) echo $post['acq']['hard_code_status_url'];?>
</textarea>
       
      </div>
      <div class="my-2"><i class="<?=$data['fwicon']['hand'];?>"></i> <a id="a_after_base_hard_code_status_url" href='<?=$data['Host'];?>/<? if(isset($post['acq']['hard_code_status_url'])) echo $post['acq']['hard_code_status_url'];?>' target="_blank" >
        <?=$data['Host'];?>/
        <span id="after_base_hard_code_status_url">
        <? if(isset($post['acq']['hard_code_status_url'])) echo $post['acq']['hard_code_status_url'];?>
        </span></a></div>
      <div class="col-sm-12"> <span class="form-label" id="basic-addon4" title="Hard Code Live Status URL">Live Status URL :</span>
        <textarea class="textAreaAdjust form-control" onKeyUp="textAreaAdjust(this)" row="3" name="acq[hard_code_live_status_url]" id="hard_code_live_status_url" placeholder="Enter Hard Code URL after Base URL " onfocusout="javascript:$('#after_base_hard_code_live_status_url').html(this.value);$('#a_after_base_hard_code_live_status_url').attr('href',$('#a_after_base_hard_code_live_status_url').text());" ><? if(isset($post['acq']['hard_code_live_status_url'])) echo $post['acq']['hard_code_live_status_url'];?>
</textarea>
      </div>
      <div class="my-2"> <i class="<?=$data['fwicon']['hand'];?>"></i> <a id="a_after_base_hard_code_live_status_url" href='<?=$data['Host'];?>/<? if(isset($post['acq']['hard_code_live_status_url'])) echo $post['acq']['hard_code_live_status_url'];?>' target="_blank" >
        <?=$data['Host'];?>/
        <span id="after_base_hard_code_live_status_url">
        <? if(isset($post['acq']['hard_code_live_status_url'])) echo $post['acq']['hard_code_live_status_url'];?>
        </span></a></div>
      <div class="col-sm-12"> <span class="form-label" id="basic-addon4" title="Hard Code Refund URL">Refund URL :</span>
        <textarea class="textAreaAdjust form-control" onKeyUp="textAreaAdjust(this)" row="3" name="acq[hard_code_refund_url]" id="hard_code_refund_url" placeholder="Enter Hard Code URL after Base URL " onfocusout="javascript:$('#after_base_hard_code_refund_url').html(this.value);$('#a_after_base_hard_code_refund_url').attr('href',$('#a_after_base_hard_code_refund_url').text());" ><? if(isset($post['acq']['hard_code_refund_url'])) echo $post['acq']['hard_code_refund_url'];?>
</textarea>
      </div>
      <div class="my-2"> <i class="<?=$data['fwicon']['hand'];?>"></i> <a id="a_after_base_hard_code_refund_url" href='<?=$data['Host'];?>/<? if(isset($post['acq']['hard_code_refund_url'])) echo $post['acq']['hard_code_refund_url'];?>' target="_blank" >
        <?=$data['Host'];?>/
        <span id="after_base_hard_code_refund_url">
        <? if(isset($post['acq']['hard_code_refund_url'])) echo $post['acq']['hard_code_refund_url'];?>
        </span></a> </div>
		
	<?/*?>
      <div class="row border bd-yellow-100 my-2 text-start py-2 vkgclr my-2 rounded" >
        <div class="row btn btn-outline-light text-dark fw-bold mb-2">Additional Bank Response</div>
        <div class="col-sm-6">
          <label for="Payout ID" class="form-label">B. Success Response :</label>
          <textarea class="textAreaAdjust form-control" onkeyup="textAreaAdjust(this)" row="3" name="acq[br_success]"  
placeholder='value1,value2,value3' ><? if(isset($post['acq']['br_success'])) echo $post['acq']['br_success'];?>
</textarea>
        </div>
        <div class="col-sm-6">
          <label for="Payout ID" class="form-label">B. Failed Response :</label>
          <textarea class="textAreaAdjust form-control" onkeyup="textAreaAdjust(this)" rows="1" name="acq[br_failed]"  placeholder='value1,value2,value3' ><? if(isset($post['acq']['br_failed'])) echo $post['acq']['br_failed'];?>
</textarea>
        </div>
        <div class="col-sm-6">
          <label for="Payout ID" class="form-label">B. Pending Response :</label>
          <textarea class="textAreaAdjust form-control" onkeyup="textAreaAdjust(this)" rows="1" name="acq[br_pending]"  placeholder='value1,value2,value3' ><? if(isset($post['acq']['br_pending'])) echo $post['acq']['br_pending'];?>
</textarea>
        </div>
        <div class="col-sm-6">
          <label for="Payout ID" class="form-label">Bank Status Path :</label>
          <textarea class="textAreaAdjust form-control" onkeyup="textAreaAdjust(this)" rows="1" name="acq[br_status_path]"  placeholder='api/pay22/processed' ><? if(isset($post['acq']['br_status_path'])) echo $post['acq']['br_status_path'];?>
</textarea>
        </div>
      </div>
	  <?*/?>
	  
      <div class="row border bd-blue-100 my-2 text-start py-2 vkgclr rounded">
        <!--<h4 class="row border my-2 text-start">Bank Transaction</h4>-->
        <div class="row btn btn-outline-light text-dark fw-bold mb-2">Bank Transaction</div>
        <div class="col-sm-6">
          <label for="Payout ID" class="form-label">Min. Transaction Limit <font class="acct_curr">(
          <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
          ) : </font></label>
          <input type="text" class="form-control" name="acq[min_limit]" id="min_limit" size="20" value="<?=(isset($post['acq']['min_limit'])&&$post['acq']['min_limit']?$post['acq']['min_limit']:"1")?>">
        </div>
        <div class="col-sm-6">
          <label for="Payout ID" class="form-label">Max. Transaction Limit <font class="acct_curr">(
          <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
          ) : </font></label>
          <input type="text" class="form-control" name="acq[max_limit]" id="max_limit" size="30" value="<?=(isset($post['acq']['max_limit'])&&$post['acq']['max_limit']?$post['acq']['max_limit']:"500");?>">
        </div>
        <div class="col-sm-6">
          <label for="Payout ID" class="form-label">Scrubbed Period :</label>
          <select name="acq[scrubbed_period]" class="form-select" id="scrubbed_period">
            <option value="" disabled="" selected="">Scrubbed Period</option>
            <option value="1">1 Day</option>
            <option value="7">7 Days</option>
            <option value="15">15 Days</option>
            <option value="30">30 Days</option>
            <option value="90">90 Days</option>
          </select>
          <?
			if(isset($post['acq']['scrubbed_period']))
			{
			?>
          <script>$('#scrubbed_period option[value="<?=$post['acq']['scrubbed_period']?>"]').prop('selected','selected');</script>
          <?
			}
			?>
        </div>
        <div class="col-sm-6">
          <label for="Payout ID" class="form-label">Transaction Count :</label>
          <input type="text"  class="form-control" name="acq[transaction_count]" id="transaction_count" size="20" value="<?=(isset($post['acq']['transaction_count'])&&$post['acq']['transaction_count']?$post['acq']['transaction_count']:"7");?>">
        </div>
        <div class="col-sm-6">
          <label for="Payout ID" class="form-label">Min. Success Count :</label>
          <input class="form-control" type="text" name="acq[tr_scrub_success_count]" id="tr_scrub_success_count" size="20" value="<?=(isset($post['acq']['tr_scrub_success_count'])&&$post['acq']['tr_scrub_success_count']?$post['acq']['tr_scrub_success_count']:'2');?>">
        </div>
        <div class="col-sm-6">
          <label for="Payout ID" class="form-label">Min. Failed Count :</label>
          <input type="text" class="form-control" name="acq[tr_scrub_failed_count]" id="tr_scrub_failed_count" size="20" value="<?=(isset($post['acq']['tr_scrub_failed_count'])&&$post['acq']['tr_scrub_failed_count']?$post['acq']['tr_scrub_failed_count']:'5')?>">
        </div>
        <!--<span class="hide1 noneClick1 row">-->
        <div class="col-sm-6">
          <label for="Payout ID" class="form-label">Setup Fee (USD) :</label>
          <input type="text" class="form-control" name="acq[setup_fee]" id="setup_fee" size="20" value="<? if(isset($post['acq']['setup_fee'])) echo $post['acq']['setup_fee']?>">
        </div>
		<?/*?>
        <div class="col-sm-6">
          <label for="Payout ID" class="form-label">Setup Fee  Collected :</label>
          <select name="acq[setup_fee_status]" class="form-select" id="setup_fee_status">
            <option value="0" selected>Not Yet</option>
            <option value="1">Yes</option>
          </select>
          <?
			if(isset($post['acq']['setup_fee_status']))
			{?>
          <script>$('#setup_fee_status option[value="<?=$post['acq']['setup_fee_status']?>"]').prop('selected','selected');</script>
          <?
			}?>
        </div>
		<?*/?>
		<div class="col-sm-6">
          <label for="Payout ID" class="form-label">Checkout Level Name :</label>
          <input type="text" class="form-control" name="acq[checkout_level_name]" id="checkout_level_name" value="<? if(isset($post['acq']['checkout_level_name'])) echo $post['acq']['checkout_level_name']?>">
        </div>
		
        <!--</span>-->
      </div>
	  
	<?/*?>
      <div class="row border bd-red-100 my-2 text-start py-2 vkg text-white rounded">
        <!--<h4 class="row border my-2 text-start text-white bg-light">Process Transaction</h4> -->
        <div class="row btn btn-outline-info text-dark fw-bold mb-2">Process Transaction</div>
        <div class="col-sm-6">
          <label for="Payout ID" class="form-label">Processing Mode:
          <?
			if(isset($post['mid_name']))
			{
			?>
          <script>$('#mid_name option[value="<?=$post['mid_name']?>"]').prop('selected','selected');</script>
          <?
			}?>
          </label>
          <select name="acq[account_login_url]" class="form-select" id="account_login_url">
            <option value="" disabled="" >Processing Mode</option>
            <option value="1">Live</option>
            <option value="2" selected="">Test</option>
            <option value="3">Inactive</option>
          </select>
          <?
			if(isset($post['acq']['account_login_url']))
			{
			?>
          <script>$('#account_login_url option[value="<?=$post['acq']['account_login_url']?>"]').prop('selected','selected');</script>
          <?
			}?>
        </div>
        <div class="col-sm-6">
          <label for="Payout ID" class="form-label">Default Currency:</label>
          <select class="form-select hide1" name="acq[processing_currency]" id="processing_currency" onChange="procurrency(this)" >
            <option value="" disabled="" selected="">Processing Currency</option>
            <?foreach ($data['AVAILABLE_CURRENCY'] as $k11) {?>
            <option value="<?=$k11?>">
            <?=$k11?>
            </option>
            <?}?>
          </select>
          <?
			if(isset($post['acq']['processing_currency']))
			{
				$ac_processing_currency=get_currency($post['acq']['processing_currency'],1);
			?>
          <script>
				$('#processing_currency').find('option:contains("<?=$ac_processing_currency;?>")', this).prop('selected', 'selected');
				$('#processing_currency').find('option:contains("<?=$ac_processing_currency;?>")', this).attr('selected', 'selected');
			</script>
          <?
			}
			?>
        </div>
        <div class="col-sm-6">
          <label for="Payout ID" class="form-label">
          <? if(isset($acc_arr[2])) echo $acc_arr[2];?>
          Discount Rate (%) :</label>
          <? if(isset($acc_arr[2])) echo $acc_arr[2];?>
          <input type="text" class="form-control" name="acq[transaction_rate]" id="transaction_rate" size="20" placeholder="13%" value="<? if(isset($post['acq']['transaction_rate'])) echo $post['acq']['transaction_rate']?>">
        </div>
        <div class="col-sm-6">
          <label for="Payout ID" class="form-label">Settlement Period :</label>
          <select class="form-select" name="acq[settelement_period]" id="settelement_period">
            <option value="" disabled="" selected="">Settlement Period</option>
            <option value="1">1 Day</option>
            <option value="2">2 Days</option>
            <option value="3">3 Days</option>
            <option value="4">4 Days</option>
            <option value="5">5 Days</option>
            <option value="6">6 Days</option>
            <option value="7">7 Days</option>
            <option value="8">8 Days</option>
            <option value="9">9 Days</option>
            <option value="10">10 Days</option>
            <option value="11">11 Days</option>
            <option value="12">12 Days</option>
            <option value="13">13 Days</option>
            <option value="14">14 Days</option>
            <option value="15">15 Days</option>
            <option value="16">16 Days</option>
            <option value="17">17 Days</option>
            <option value="18">18 Days</option>
            <option value="19">19 Days</option>
            <option value="20">20 Days</option>
            <option value="21">21 Days</option>
            <option value="22">22 Days</option>
            <option value="23">23 Days</option>
            <option value="24">24 Days</option>
            <option value="25">25 Days</option>
            <option value="26">26 Days</option>
            <option value="27">27 Days</option>
            <option value="28">28 Days</option>
            <option value="29">29 Days</option>
            <option value="30">30 Days</option>
          </select>
          <?
			if(isset($post['acq']['settelement_period']))
			{?>
          <script>$('#settelement_period option[value="<?=$post['acq']['settelement_period']?>"]').prop('selected','selected');</script>
          <?
			}?>
        </div>
        <div class="col-sm-6">
          <label for="Payout ID" class="form-label">
          <? if(isset($acc_arr[2])) echo $acc_arr[2];?>
          Trxn Fee (Success) : </label>
          <input type="text" class="form-control" name="acq[txn_fee]" id="txn_fee" size="20" placeholder="4.0" value="<? if(isset($post['acq']['txn_fee'])) echo $post['acq']['txn_fee']?>">
        </div>
        <div class="col-sm-6">
          <label for="Payout ID" class="form-label">
          <? if(isset($acc_arr[2])) echo $acc_arr[2];?>
          Trxn Fee (Failed) : </label>
          <input type="text" name="acq[txn_fee_failed]" id="txn_fee_failed" size="20"  class="form-control" value="<? if(isset($post['acq']['txn_fee_failed'])) echo $post['acq']['txn_fee_failed']?>">
        </div>
        <div class="col-sm-6">
          <label for="Payout ID" class="form-label">Shorting : </label>
          <?
				 unset($_SESSION['shorting_ar']);
				?>
          <style>
				body .slc_color option[disabled] {
					background: #e38d00 !important;color:#fff;
				}
				body .slc_color option[selected], body .slc_color option[selected]:hover, body .slc_color option[selected]:active, body .slc_color option[selected]:focus, body .slc_color option[selected]:focus-within{
					background: #189302 !important;color:#fff;
				}
			 </style>
          <select class='slc_color form-select' name="acq[shorting]" id="shorting" title="Rolling Period"  >
            <option title="" value="">Select Shorting</option>
            <?
				$sum = 0;
				for($f = 1; $f <= 290; $f++){ 
					//unset($data['subadmin'][$f]['id']);$sum = $sum + $f;
					if(isset($_SESSION['shorting_ar'])&&(in_array((int)$f, $_SESSION['shorting_ar'], false))){?>
            <option title="<?=($post['acq']['shorting']==$f?"Current":"Added")?> in <?=array_search($f,$_SESSION['shorting_ar']);?> Payout" value="<?=$f;?>" <?=($post['acq']['shorting']==$f?"":" disabled='disabled'")?> >
            <?=$f;?>
            :
            <?=($post['acq']['shorting']==$f?"Current":"Added")?>
            in
            <?=array_search($f,$_SESSION['shorting_ar']);?>
            Payout </option>
            <? }
					else{ ?>
            <option title="Empty: Addable" value="<?=$f;?>"  >
            <?=$f;?>
            </option>
            <? }
				}
				?>
          </select>
          <?
				if(isset($post['acq']['shorting']))
				{
				?>
          <script>$('#shorting option[value="<?=$post['acq']['shorting']?>"]').prop('selected','selected');$('#shorting option[value="<?=$post['acq']['shorting']?>"]').attr('selected','selected');</script>
          <?
				}?>
        </div>
        <div class="col-sm-6 row px-0">
          <label for="Payout ID col-sm-4" class="form-label">Rolling Reserve : </label>
          <div class="col-sm-6 mb-1">
            <input type="text" class="form-control float-start" style="width: calc(100% - 50px);" name="acq[rolling_fee]" id="rolling_fee" placeholder="10" value="<? if(isset($post['acq']['rolling_fee'])) echo $post['acq']['rolling_fee']?>">
            <span class="float-start" style="width:50px;" >&nbsp;% for</span></div>
          <div class="col-sm-6 mb-1">
            <select name="acq[rolling_period]" id="rolling_period" class="form-select float-start" title="Rolling Period" style="width: calc(100% - 50px);">
              <option value="180" selected>180</option>
              <option value="90">90</option>
              <option value="120">120</option>
              <option value="210">210</option>
              <option value="270">270</option>
              <option value="360">360</option>
            </select>
<span class="float-start" style="width:50px;" >&nbsp;Days</span>
<? if(isset($post['acq']['rolling_period'])) { ?>
<script>$('#rolling_period option[value="<?=$post['acq']['rolling_period']?>"]').prop('selected','selected');</script>
<? } ?>
          </div>
        </div>
        <div class="col-sm-6 hide">
          <label for="Payout ID" class="form-label">Min. Settlement Amt. :<font class="acct_curr hide">(
          <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
          )</font></label>
          <input type="text" class="form-control"  style="display:none"; name="acq[settled_amt]" id="settled_am" size="20" value="<? if(isset($post['acq']['settled_amt'])) echo $post['acq']['settled_amt']?>"></div>
      </div>
      <div class="row border bd-green-100 my-2 text-start py-2 border text-white rounded">
        <div class="row btn btn-outline-light text-dark fw-bold mb-2">Other Details</div>
        <div class="col-sm-6">
          <label for="Payout ID" class="form-label">Bank Siteid :</label>
          <textarea class="textAreaAdjust form-control" onKeyUp="textAreaAdjust(this)" name="acq[hkip_siteid]" id="hkip_siteid"><? if(isset($post['acq']['hkip_siteid'])) echo $post['acq']['hkip_siteid'];?>
</textarea>
        </div>

        
       
      </div>
    
	<?*/?>
	
	</div>
    <div class="my-2 text-center row p-0">
      <div class="col-sm-12 my-2 remove-link-css">
        <button formnovalidate type="submit" name="send" value="CONTINUE"  class="btn btn-icon btn-primary"><i class="<?=$data['fwicon']['circle-plus'];?>"></i> Submit</button>
        <a href="<?=$data['Admins']?>/bank<?=$data['ex']?>" class="btn btn-icon btn-primary"><i class="<?=$data['fwicon']['back'];?>"></i> Back</a> </div>
    </div>
    <? }?>
  </form>
</div>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? }?>
<!--</div> -->
