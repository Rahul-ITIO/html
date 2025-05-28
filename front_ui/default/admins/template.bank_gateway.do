<? if(isset($data['ScriptLoaded'])){ ?>

<?
	$data['account_types']=[1=>'e-Check Payment',2=>'2D Card Payment',3=>'3D Card Payment',4=>'Wallets Payment',5=>'Click Zep Project',6=>'UPI Payment',7=>'Net Banking Payment',8=>'Nodal Account Payment',9=>'Coins Payment',9=>'Network Payment',99=>'Other Payment'];
	$data['account_connects']=[1=>'Direct (Curl Option)',2=>'Redirect (Get Method)',3=>'Redirect (Post Method)',4=>'Whitelisting IP - Direct (Curl Option)',5=>'Whitelisting IP - Redirect (Post Method)'];
?>
<div class="container border my-1 rounded">
  <form method="post" name="data">
    <input type="hidden" name="step" value="<?=$post['step']?>">
    <script>
	// js for scrubbed validation
function account_typef(theValue){
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

function textAreaAdjust(o) {
 // o.style.height = "1px";
 // o.style.height = (10+o.scrollHeight)+"px";
}

function activeFilterf() {
	//var thisVal = $(this).val();
   var thisVal = $("#active_filter option:selected").val();
   var se = $('#se_filter').val();
   var sub_q2="&se="+se;
   if(thisVal=='0' || thisVal=='1' || thisVal=='2' || thisVal=='ALL'){
	  sub_q2=""; 
   }else if(thisVal=='ac' && se.trim()==''){
	 ///alert('Can not empty search');
	 $('#se_filter').val('');
	 $('#se_filter').focus();
	 return false;
   }
	window.location.href="<?=$data['Admins']?>/bank_gateway<?=$data['ex']?>?active_filter="+thisVal+sub_q2;
}


$(document).ready(function(){ 
	
	//$(".textAreaAdjust").trigger("keyup");
	textAreaAdjustf('.textAreaAdjust');
	
	$('#account_type').trigger('change');
	
	$('#se_filter').bind("keypress", function(e) {
		var keycode = (e.keyCode ? e.keyCode : e.which);
		if (keycode == 13) {               
			e.preventDefault();
			activeFilterf();
			return false;
		}
	});

	$('#active_filter, #se_filter').change(function(e){
		activeFilterf();
    });
    
});
</script>
    <? if((isset($data['Error'])&& $data['Error'])){ ?>
    <div class="alert alert-danger alert-dismissible my-2">
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      <strong>Error!</strong>
      <?=prntext($data['Error'])?>
    </div>
    <? }?>
    <? if((isset($data['sucess'])&& $data['sucess'])){ ?>
    <div class="alert alert-success alert-dismissible my-2">
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      <strong>Success! </strong>
      <?=prntext($post['success'])?>
    </div>
    <? }?>
    <? if((isset($_SESSION['msgsuccess'])&& $_SESSION['msgsuccess'])){ ?>
    <div class="alert alert-success alert-dismissible my-2">
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      <strong>Success! </strong>
      <?=$_SESSION['msgsuccess']?>
    </div>
    <? 
	unset($_SESSION['msgsuccess']); 
	}
	?>
    <? if($post['step']==1){ ?>
    <div class="container row text-end px-0 title_addnew_common">
      <div class="col-sm-6 ps-0 text-start">
        <div class="container vkg px-0">
          <h4 class="my-2"><i class="<?=$data['fwicon']['bank-gateway'];?>"></i> Bank Gateway Table <?php /*?><b><?=$data['db_count']?> </b><?php */?> <a data-ihref="<?=$data['Admins']?>/json_log_all<?=$data['ex']?>?tablename=bank_gateway_table" title="View Json Log History" onclick="iframe_open_modal(this);"><i class="<?=$data['fwicon']['circle-info'];?> text-danger fa-fw"></i></a></h4>
          
        </div>
      </div>
      <div class="col-sm-3 my-2 ps-0 text-end">
	  <input name="se" id="se_filter" class="form-control default" type="text" autocomplete="off" value="<?=((isset($_GET['se'])&&$_GET['se'])?$_GET['se']:'')?>">
	  </div>
      <div class="col-sm-3 my-2 ps-0 text-end">
        <select name="active_filter" id="active_filter" class="select_cs_21 form-select me-2 float-start" autocomplete="off" style="width: calc(100% - 50px);">
          <option value="0" title="Show Data List of Inactive Only" >Inactive</option>
          <option value="1" title="Show Data List of Active Only" >Active</option>
          <option value="2" title="Show Data List of Inactive Only" >Common</option>
		  <option value="mcc_code" title="Show Data List of MCC Code" >MCC Code</option>
          <option value="ALL" title="Show Data List of All" selected="selected">All</option>
          <option value="ac" title="Show Data List of Acquirer wise">A/c. No.</option>
        </select>
        <script>
			$('#active_filter option[value="<?=($_GET['active_filter'])?>"]').prop("selected", "selected");
		</script>
        <button type="submit" name="send" value="Add A New Bank Gateway!"  class="btn btn-primary" title="Add A New Bank Gateway"><i></i><i class="<?=$data['fwicon']['circle-plus'];?>"></i></button>
      </div>
    </div>
   <div class="container table-responsive-sm">
      <table class="table table-hover">
        <thead>
          <tr>
		    <th scope="col">#</th>
            <th scope="col">Status</th>
            <th scope="col">A/c No./Mode</th>
            <th scope="col">Bank URL</th>
            <th scope="col" class="hide-768">Domain</th>
            <th scope="col" class="hide-768">MID</th>
            <th scope="col" class="hide-768">API Token</th>
            <th scope="col" class="hide-768">Site ID</th>
            <th scope="col" class="hide-768">B. Country</th>
            <th scope="col" class="hide-768">URL</th>
            <th scope="col">Action</th>
          </tr>
        </thead>
        <? $j=1; foreach($post['result_list'] as $key=>$value) {
		  $bgcolor=$j%2 ?'#FFFFFF':'#E7E7E7';
		
		if($value['acquirer_json']){
			$value['acq']=isJsonDe($value['acquirer_json']);
			$value['a_arr']=isJsonDe($value['acquirer_json']);
			$pro_cur=(isset($value['a_arr']['processing_currency'])?$value['a_arr']['processing_currency']:'');
			//echo "<br/><br/>a_arr({$value['account_no']})=>"; print_r($value['a_arr']);
			if(isset($value['acq']['mcc_code'])&&$value['acq']['mcc_code']){
				$mcc_code_str=implode(",",$value['acq']['mcc_code']);
				$website_mcc_code=merchant_categoryf(0,0,$mcc_code_str);
				if(isset($website_mcc_code)&&$website_mcc_code&&isset($mcc_code_str)&&$mcc_code_str){
				$value['acq']['mcc_codes']=implode(" , ",$data['mcc_codes_list']);
				}
			}
			
			if( (isset($value['acq'])&&$value['acq']) && (is_array($value['acq']) || is_object($value['acq'])) ){
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
          <td nowrap data-label="Status - ">
			<? if($value['bg_active']==1){ ?>
            Active
            <? }elseif($value['bg_active']==2){ ?>
            Common
            <? }else{ ?>
            Inactive
            <? }?>
            </td>
          <td  data-label="A/c No./Mode - " ><span class="text-wrap" style="max-width: 150px;" title="<? if(isset($value['account_no'])) echo $value['account_no'];?> / <? if(isset($value['account_mode'])&&$value['account_mode']==1){echo "Live";}else{echo "Test";}?> <? if(isset($data['t'][$value['account_no']]['name1'])) echo ' / '.$data['t'][$value['account_no']]['name1'];?> <? if(isset($data['t'][$value['account_no']]['name4'])) echo ' / '.$data['t'][$value['account_no']]['name4'];?> ">
            <? if(isset($value['account_no'])) echo $value['account_no'];?>
            /
            <? if(isset($value['account_mode'])&&$value['account_mode']==1){echo "Live";}else{echo "Test";}?>
            <? if(isset($data['t'][$value['account_no']]['name1'])) echo ' / '.substr($data['t'][$value['account_no']]['name1'],0,10);?>
				</span>
				
				<? if(isset($value['acq']['mcc_codes'])&&$value['acq']['mcc_codes']){ ?>
					<a class="dotdot nomid modal_for_iframe" href='<?=$data['Admins'];?>/json_pretty_print<?=$data['ex']?>?json=<?=encryptres($value['acq']['mcc_codes']);?>' title="MCC Code: <?=prntext($value['acq']['mcc_codes']);?>" style="cursor:pointer;float:none;display:inline-block;position: relative;padding: 3px 10px;vertical-align: middle;" >
						<i class="<?=$data['fwicon']['tag'];?> text-success"></i>
						 
					 </a>
				<? } ?>
			</td>
          <td  data-label="Bank Gateway Url - "><div title="<?=prntext(lf($value['bank_payment_url'],25,1));?>" class="short_display_on_mobile">
            <a class="dotdot nomid modal_for_iframe" data-ihref='<?=$data['Admins'];?>/json_pretty_print<?=$data['ex']?>?json=<?=encryptres($value['bank_payment_url']);?>' href='<?=$data['Admins'];?>/json_pretty_print<?=$data['ex']?>?json=<?=encryptres($value['bank_payment_url']);?>'> 
            <?=prntext(lf($value['bank_payment_url'],25,1));?>
            </a> </div></td>
          <td title='<?=$value['bank_process_url']?>' class="hide-768"><span class='text-wrap'>
            <?=$value['bank_process_url']?>
            </span></td>
          <td  title='<?=$value['bank_merchant_id']?>' class="hide-768"><span class="d-inline-block text-truncate" style="max-width: 80px;">
            <?=$value['bank_merchant_id']?>
            </span></td>
          <td title='<?=$value['bank_api_token']?>' class="hide-768"><span class="d-inline-block text-truncate" style="max-width: 80px;">
            <?=$value['bank_api_token']?>
            </span></td>
          <td  title='<?=$value['siteid']?>' class="hide-768"><span class="d-inline-block text-truncate" style="max-width: 80px;">
            <?=$value['siteid']?>
            </span></td>
          <td title='<?=$value['developer_url']?>' class="hide-768"><span class="text-wrap"><?=$value['bank_country_name']?></span></td>
            
            
          <td title='<?=$value['developer_url']?>' class="hide-768"><? if(isset($value['developer_url'])&&$value['developer_url']){?>
            <a class="text-wrap" href="<?=$value['developer_url']?>" title="<?=$value['developer_url']?>"  target="_blank"> <i class="<?=$data['fwicon']['external-url'];?> text-success" title="<?=$value['developer_url']?>"></i> </a>
            <? } ?>
          </td>
          <td data-label="Action - " class="text-wrap" ><? if(isset($_SESSION['login_adm'])){ ?>
		  
		  <div class="btn-group dropstart short-menu-auto-main"> <a data-bs-toggle="dropdown" aria-expanded="false"  title="Action"><i class="<?=$data['fwicon']['circle-down'];?> text-link"></i></a>
                <ul class="dropdown-menu dropdown-menu-icon pull-right text-center" >
                  <li> <a class="dropdown-item" href="<?=$data['Admins'];?>/bank_gateway<?=$data['ex']?>?id=<?=$value['id']?>&action=update" title="Edit" ><i class="<?=$data['fwicon']['edit'];?> text-success"></i></a></li>
				  
                  <li> <a class="dropdown-item" href="<?=$data['Admins'];?>/bank_gateway<?=$data['ex']?>?id=<?=$value['id']?>&action=duplicate" title="Duplicate" onclick="return confirm('Are you Sure to Create Duplicate');"><i class="<?=$data['fwicon']['copy'];?>"></i></a></li>

                  <li> <a class="dropdown-item"  href="<?=$data['Admins'];?>/bank_gateway<?=$data['ex']?>?id=<?=$value['id']?>&action=delete" onclick="return confirm('Are you Sure to Delete');" title="Delete"><i class="<?=$data['fwicon']['delete'];?> text-danger"></i></a></li>
				  
			<? if(isset($value['json_log_history'])&&$value['json_log_history']){?>
			<li> 
			<i class="<?=$data['fwicon']['circle-info'];?> text-info fa-fw" 
			onclick="popup_openv('<?=$data['Host']?>/include/json_log<?=$data['ex']?>?tableid=<?=$value['id'];?>&tablename=bank_gateway_table')" title="View Json History"></i>
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
	 <div class="mboxtitle hide">Bank Gateway Detail : <?=$value['id'];?></div>
              <div class="row border bg-light my-2 text-start rounded">
			<? if(isset($value['acq']['mcc_code'])&&$value['acq']['mcc_code']){?>
                  <div class=" col-sm-6">
                  <div class="card my-2 ps-2">MCC Codes: <?=$value['acq']['mcc_code'];?> == <?=$value['acq']['mcc_codes'];?></div>
                  </div>
			<?}?> 
                <div class="row col-sm-6">
                  <div class="card my-2">Bank Gateway Activation:
                    <? if($value['bg_active']==1){ ?>
                    Active
                    <? }elseif($value['bg_active']==2){ ?>
                    Common
                    <? }else{ ?>
                    Inactive
                    <? }?>
                  </div>
                </div>
                <div class="row col-sm-6 ">
                  <div class="card my-2">Acquirer Mode:
                    <? if($value['account_mode']==1){echo "Live";}else{echo "Test";}?>
                  </div>
                </div>
                <? if(isset($value['account_no'])&&$value['account_no']){?>
                <div class="row col-sm-6 ">
                  <div class="card my-2">Acquirer No.:
                    <? if(isset($value['account_no'])) echo prntext($value['account_no']);?>
                    /
                    <? if(isset($data['t'][$value['account_no']]['name1'])) echo prntext($data['t'][$value['account_no']]['name1']);?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['account_types'])&&$value['account_types']){?>
                <div class="row col-sm-6 ">
                  <div class="card my-2">Acquirer Type:
                    <? if(isset($data['account_types'][$value['account_type']])) echo prntext($data['account_types'][$value['account_type']]);?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['account_connects'])&&$value['account_connects']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Acquirer to Connect:
                    <? if(isset($data['account_connects'][$value['account_connect']])) echo prntext($data['account_connects'][$value['account_connect']]);?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['bank_country_name'])&&$value['bank_country_name']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Bank Country Name:
                    <? if(isset($value['bank_country_name'])) echo prntext($value['bank_country_name']);?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['bank_merchant_id'])&&$value['bank_merchant_id']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Bank Merchant ID:
                    <? if(isset($value['bank_merchant_id'])) echo prntext($value['bank_merchant_id']);?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['siteid'])&&$value['siteid']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">SiteID/PublicKey:
                    <? if(isset($value['siteid'])) echo $value['siteid'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['bank_api_token'])&&$value['bank_api_token']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Bank API Token/Secret Key:
                    <? if(isset($value['bank_api_token'])) echo $value['bank_api_token'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['hash_code'])&&$value['hash_code']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Digest/Hash Code/Encryption Key :
                    <? if(isset($value['hash_code'])) echo $value['hash_code'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['billing_descriptor'])&&$value['billing_descriptor']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Billing Descriptor :
                    <? if(isset($value['billing_descriptor'])) echo $value['billing_descriptor'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['billing_ip'])&&$value['billing_ip']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">If Static Billing IP :
                    <? if(isset($value['billing_ip'])) echo $value['billing_ip'];?>
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
                  <div class="card my-2">Domain for Callback/Process:
                    <? if(isset($value['bank_process_url'])) echo $value['bank_process_url'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['account_custom_field_14'])&&$value['account_custom_field_14']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Card Name:
                    <? if(isset($value['account_custom_field_14'])) echo $value['account_custom_field_14'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['account_custom_field_15'])&&$value['account_custom_field_15']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Acquirer Custom 15:
                    <? if(isset($value['account_custom_field_15'])) echo $value['account_custom_field_15'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['date'])&&$value['date']&&$value['date']<>"0000-00-00"){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Payout Date: <?php echo date("Y-m-d",strtotime($value['date']));?></div>
                </div>
                <? } ?>
                <? if(isset($value['currency'])&&$value['currency']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Currency From:
                    <? if(isset($value['currency'])) echo prntext($value['currency'])?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['currency_to'])&&$value['currency_to']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Processing Currency for Bank:
                    <? if(isset($value['currency_to'])) echo prntext($value['currency_to'])?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['currency_rate'])&&$value['currency_rate']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Currency Rate:
                    <? if(isset($value['currency_rate'])) echo prntext($value['currency_rate'])?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['bank_payment_url'])&&$value['bank_payment_url']){?>
                <div class="row col-sm-12">
                  <div class="card my-2">Bank Payment Live URL: <a href='<?=prntext($value['bank_payment_url']);?>' target="_blank">
                    <?=prntext($value['bank_payment_url']);?>
                    </a> </div>
                </div>
                <? } ?>
                <? if(isset($value['bank_payment_url'])&&$value['bank_payment_url']){?>
                <div class="row col-sm-12">
                  <div class="text-wrap card my-2">Bank Payment Test URL: <a  href='<?=prntext($value['bank_payment_url']);?>' target="_blank">
                    <?=prntext($value['bank_payment_test_url']);?>
                    </a></div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['bank_status_url'])&&$value['acq']['bank_status_url']){?>
                <div class="row col-sm-12">
                  <div class="card my-2 ps-2">Bank Status URL: <a  href='<?=prntext($value['acq']['bank_status_url']);?>' target="_blank">
                    <?=prntext($value['acq']['bank_status_url']);?>
                    </a> </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['bank_refund_type'])&&$value['acq']['bank_refund_type']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">Bank Refund Type:
                    <?=prntext($value['acq']['bank_refund_type']);?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['bank_refund_url'])&&$value['acq']['bank_refund_url']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">Bank Refund URL: <a  href='<?=prntext($value['acq']['bank_refund_url']);?>' target="_blank">
                    <?=prntext($value['acq']['bank_refund_url']);?>
                    </a> </div>
                </div>
                <? } ?>
                <? if(isset($value['developer_url'])&&$value['developer_url']){?>
                <div class="row col-sm-12">
                  <div class="text-wrap card my-2">Bank Developer API URL : <a  href='<?=prntext($value['developer_url']);?>' target="_blank">
                    <?=prntext($value['developer_url']);?>
                    </a></div>
                </div>
                <? } ?>
                <? if(isset($value['bank_json'])&&$value['bank_json']){?>
                <div class="row col-sm-12">
                  <div class="text-wrap card my-2">Bank Json:
                    <?=$value['bank_json'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['comments'])&&$value['comments']){?>
                <div class=" rowcol-sm-12">
                  <div class="text-wrap card my-2">Note/Comments:
                    <?=$value['comments'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['hard_code_url'])&&$value['acq']['hard_code_url']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Hard Code Payment URL: <a href='<?=$data['Host'];?>/<? if(isset($value['acq']['hard_code_url'])) echo ($value['acq']['hard_code_url']);?>' class="link-primary" target="_blank" >
                    <?=$data['Host'];?>/ <font style="font-style:italic;">
                    <? if(isset($value['acq']['hard_code_url'])) echo ($value['acq']['hard_code_url']);?>
                    </font></a> </div>
                </div>
                <?  }?>
                <? if(isset($value['acq']['hard_code_status_url'])&&$value['acq']['hard_code_status_url']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Hard Code Status URL: <a href='<?=$data['Host'];?>/<? if(isset($value['acq']['hard_code_status_url'])) echo ($value['acq']['hard_code_status_url']);?>' class="link-primary" target="_blank" >
                    <?=$data['Host'];?>/<font style="font-style:italic;">
                    <? if(isset($value['acq']['hard_code_status_url'])) echo ($value['acq']['hard_code_status_url']);?>
                    </font></a> </div>
                </div>
                <? }?>
                <? if(isset($value['acq']['hard_code_live_status_url'])&&$value['acq']['hard_code_live_status_url']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Live Code Status URL: <a href='<?=$data['Host'];?>/<? if(isset($value['acq']['hard_code_live_status_url'])) echo ($value['acq']['hard_code_live_status_url']);?>' class="link-primary"  target="_blank" >
                    <?=$data['Host'];?>/<font style="font-style:italic;">
                    <? if(isset($value['acq']['hard_code_live_status_url'])) echo ($value['acq']['hard_code_live_status_url']);?>
                    </font></a></div>
                </div>
                <? }?>
                <? if(isset($value['acq']['hard_code_refund_url'])&&$value['acq']['hard_code_refund_url']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Hard Code Refund URL: <a href='<?=$data['Host'];?>/<? if(isset($value['acq']['hard_code_refund_url'])) echo ($value['acq']['hard_code_refund_url']);?>' target="_blank" class="link-primary"  >
                    <?=$data['Host'];?>/<font style="font-style:italic;">
                    <? if(isset($value['acq']['hard_code_refund_url'])) echo ($value['acq']['hard_code_refund_url']);?>
                    </font></a> </div>
                </div>
                <? }?>
              </div>
              <div class="row border bd-yellow-100 text-start vkg px-2 my-2 rounded" >
                <h4 class="row btn btn-outline-light text-dark text-start" >Additional Bank Response</h4>
                <? if(isset($value['acq']['br_success'])&&$value['acq']['br_success']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">B. Success Response:
                    <?=(isset($value['acq']['br_success'])?$value['acq']['br_success']:'');?>
                  </div>
                </div>
                <? }?>
                <? if(isset($value['acq']['br_failed'])&&$value['acq']['br_failed']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">B. Failed Response:
                    <?=(isset($value['acq']['br_failed'])?$value['acq']['br_failed']:'');?>
                  </div>
                </div>
                <? }?>
                <? if(isset($value['acq']['br_pending'])&&$value['acq']['br_pending']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">B. Pending Response:
                    <?=(isset($value['acq']['br_pending'])?$value['acq']['br_pending']:'');?>
                  </div>
                </div>
                <? }?>
                <? if(isset($value['acq']['br_status_path'])&&$value['acq']['br_status_path']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">Bank Status Path:
                    <?=(isset($value['acq']['br_status_path'])?$value['acq']['br_status_path']:'');?>
                  </div>
                </div>
                <? }?>
              </div>
              <div class="row border bd-blue-100 text-start vkg px-2 my-2 rounded" >
                <h4 class="row btn btn-outline-light text-dark text-start" >Bank Transaction</h4>
                <? if(isset($value['acq']['min_limit'])&&$value['acq']['min_limit']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">Min Trxn Limit: <font class="acct_curr">(
                    <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
                    )</font>
                    <?=(isset($value['acq']['min_limit'])&&$value['acq']['min_limit']?$value['acq']['min_limit']:"1");?>
                  </div>
                </div>
                <? }?>
                <? if(isset($value['acq']['max_limit'])&&$value['acq']['max_limit']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">Max Trxn Limit: <font class="acct_curr">(
                    <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
                    )</font>
                    <?=(isset($value['acq']['max_limit'])&&$value['acq']['max_limit']?$value['acq']['max_limit']:"500");?>
                  </div>
                </div>
                <? }?>
                <? if(isset($value['acq']['scrubbed_period'])&&$value['acq']['scrubbed_period']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">Scrubbed Period:
                    <? if(isset($value['acq']['scrubbed_period'])) echo $value['acq']['scrubbed_period']?>
                    Days</div>
                </div>
                <? }?>
                <? if(isset($value['acq']['transaction_count'])&&$value['acq']['transaction_count']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">Trxn Count:
                    <?=(isset($value['acq']['transaction_count'])&&$value['acq']['transaction_count']?$value['acq']['transaction_count']:"7");?>
                  </div>
                </div>
                <? }?>
                <? if(isset($value['acq']['tr_scrub_success_count'])&&$value['acq']['tr_scrub_success_count']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">Min. Success Count:
                    <?=(isset($value['acq']['tr_scrub_success_count'])&&$value['acq']['tr_scrub_success_count']?$value['acq']['tr_scrub_success_count']:'2');?>
                  </div>
                </div>
                <? }?>
                <? if(isset($value['acq']['tr_scrub_failed_count'])&&$value['acq']['tr_scrub_failed_count']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">Min. Failed Count:
                    <?=(isset($value['acq']['tr_scrub_failed_count'])&&$value['acq']['tr_scrub_failed_count']?$value['acq']['tr_scrub_failed_count']:'5');?>
                  </div>
                </div>
                <? }?>
                <? if(isset($value['acq']['setup_fee'])&&$value['acq']['setup_fee']){?>
                <span class="hide1 noneClick1"></span>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">Setup Fee (USD):
                    <? if(isset($value['acq']['setup_fee'])) echo $value['acq']['setup_fee'];?>
                  </div>
                </div>
                <? }?>
                <? if(isset($value['acq']['setup_fee_status'])&&$value['acq']['setup_fee_status']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">Setup Fee  Collected:
                    <? if(isset($value['acq']['setup_fee_status'])&&$value['acq']['setup_fee_status']==1){echo "Yes";}else{echo "Not Yet";}?>
                  </div>
                </div>
                <? }?>
              </div>
              <div class="row border bd-red-100 text-start vkg px-2 my-2 rounded" >
                <h4 class="row btn btn-outline-light text-dark text-start"  style="color:#dc3545 !important;">Process Transaction</h4>
                <? if(isset($value['acq']['account_login_url'])&&$value['acq']['account_login_url']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">Processing Mode:
                    <? if(isset($value['acq']['account_login_url'])&&$value['acq']['account_login_url']==1){echo "Live";}elseif(isset($value['acq']['account_login_url'])&&$value['acq']['account_login_url']==2){echo "Test";}else{echo "Inactive";}?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['processing_currency'])&&$value['acq']['processing_currency']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">Default Currency:
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
                    Discount Rate(%):
                    <? if(isset($value['acq']['transaction_rate'])) echo $value['acq']['transaction_rate'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['gst_fee'])&&$value['acq']['gst_fee']){ ?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">GST Fee(%):
                    <?=$value['acq']['gst_fee'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['settelement_period'])&&$value['acq']['settelement_period']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">Settlement Period:
                    <? if(isset($value['acq']['settelement_period'])) echo $value['acq']['settelement_period']?>
                    Days </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['txn_fee'])&&$value['acq']['txn_fee']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">
                    <? if(isset($acc_arr[2])) echo $acc_arr[2];?>
                    Txn. Fee (Success):
                    <? if(isset($value['acq']['txn_fee'])) echo $value['acq']['txn_fee'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['txn_fee_failed'])&&$value['acq']['txn_fee_failed']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">
                    <? if(isset($acc_arr[2])) echo $acc_arr[2];?>
                    Txn. Fee (Failed):
                    <? if(isset($value['acq']['txn_fee_failed'])) echo $value['acq']['txn_fee_failed'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['shorting'])&&$value['acq']['shorting']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">Display Order: <? if(isset($value['acq']['shorting'])) echo $value['acq']['shorting'];?></div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['rolling_period'])&&$value['acq']['rolling_period']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">Rolling Reserve:
                    <? if(isset($value['acq']['rolling_period'])) echo $value['acq']['rolling_period'];?>
                    Days</div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['settled_amt'])&&$value['acq']['settled_amt']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2"> Min. Settlement Amt.:<font class="acct_curr hide">(
                    <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
                    )</font>
                    <? if(isset($value['acq']['settled_amt'])) echo $value['acq']['settled_amt'];?>
                  </div>
                </div>
                <? } ?>
              </div>
              <div class="row border bd-gray-100 text-start vkg px-2 my-2 rounded" >
                <h4 class="row btn btn-outline-light text-dark text-start" >Charge Back</h4>
                <? if(isset($value['acq']['charge_back_fee_1'])&&$value['acq']['charge_back_fee_1']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">CB Fee Tier 1: <font class="acct_curr">(
                    <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
                    )</font>
                    <? if(isset($value['acq']['charge_back_fee_1'])) echo $value['acq']['charge_back_fee_1'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['charge_back_fee_2'])&&$value['acq']['charge_back_fee_2']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">CB Fee Tier 2:
                    <? if(isset($value['acq']['charge_back_fee_2'])) echo $value['acq']['charge_back_fee_2'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['charge_back_fee_3'])&&$value['acq']['charge_back_fee_3']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">CB Fee Tier 3: <font class="acct_curr">(
                    <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
                    )</font>
                    <? if(isset($value['acq']['charge_back_fee_3'])) echo $value['acq']['charge_back_fee_3'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['cbk1'])&&$value['acq']['cbk1']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">CBK1:
                    <? if(isset($value['acq']['cbk1'])) echo $value['acq']['cbk1'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['monthly_fee'])&&$value['acq']['monthly_fee']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">Monthly Maintenance Fee: <font class="acct_curr">(
                    <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
                    )</font>
                    <? if(isset($value['acq']['monthly_fee'])) echo $value['acq']['monthly_fee'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['refund_fee'])&&$value['acq']['refund_fee']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">Refund Fee: <font class="acct_curr">(
                    <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
                    )</font>
                    <? if(isset($value['acq']['refund_fee'])) echo $value['acq']['refund_fee'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['return_wire_fee'])&&$value['acq']['return_wire_fee']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">Settlement Wire Fee: <font class="acct_curr">(
                    <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
                    )</font>
                    <? if(isset($value['acq']['return_wire_fee'])) echo $value['acq']['return_wire_fee'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['view_settelement_report'])&&$value['acq']['view_settelement_report']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">Settlement Report View:
                    <? if(isset($value['acq']['view_settelement_report'])&&$value['acq']['view_settelement_report']==1){echo "Allowed";}else{echo "Not Allowed";}?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['virtual_fee'])&&$value['acq']['virtual_fee']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">Virtual Terminal Fee: <font class="acct_curr">(
                    <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
                    )</font>
                    <? if(isset($value['acq']['virtual_fee'])) echo $value['acq']['virtual_fee'];?>
                  </div>
                </div>
                <? } ?>
              </div>
              <div class="row border bd-green-100 text-start vkg px-2 my-2 rounded" >
                <h4 class="row btn btn-outline-light text-dark text-start text-white" style="color:#dc3545 !important;">Other Details</h4>
                <? if(isset($value['acq']['hkip_siteid'])&&$value['acq']['hkip_siteid']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">Bank Siteid:
                    <? if(isset($value['acq']['hkip_siteid'])) echo $value['acq']['hkip_siteid'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['checkout_level_name'])&&$value['acq']['checkout_level_name']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">Checkout Level Name:
                    <? if(isset($value['acq']['checkout_level_name'])) echo $value['acq']['checkout_level_name'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['notification_to_005'])&&$value['acq']['notification_to_005']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">Merchant Preferences:
                    <?php if(isset($value['acq']['notification_to_005'])&&strpos($value['acq']['notification_to_005'],"005")!==false){echo "Encrypt Customer Email ";}?>
                  </div>
                </div>
                <? } ?>
              </div>
            </div>
            <!--//////////Click Details9999//////////////-->
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
    <div class=" container vkg px-0">
      <h4 class="my-2">
        <?php if(isset($post['gid'])&&$post['gid']){ ?>
        <i class="<?=$data['fwicon']['edit'];?>"></i> Edit
        <? } else { ?>
        <i class="<?=$data['fwicon']['circle-plus'];?>"></i> Add New
        <? } ?>
        Bank Gateway</h4>
      <div class="vkg-main-border"></div>
    </div>
    <div class="row">
      <div class="col-sm-12 my-2"><? echo json_log_view($post['json_log_history'],'View Json Log','0','json_log','','100');?></div>
    </div>
    <div class="badge rounded-pill bg-vdark mb-2 ms-1" style="display: inline-block !important;">
      <? if(isset($post['bg_active'])&&$post['bg_active']==1){?>
      Active
      <? }elseif(isset($post['bg_active'])&&$post['bg_active']==2){?>
      Common
      <? }else{ ?>
      Inactive
      <? }?>
      <? if(isset($post['account_no'])&&isset($data['t'][$post['account_no']]['name1']))
			echo prntext($data['t'][$post['account_no']]['name1']).' / ';?>
      <? if(isset($post['account_mode'])&&$post['account_mode']==1){echo "Live";}else{echo "Test";}?>
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
      <div class="col-sm-12 my-2 ps-0  row">
        <?
		if(isset($post['acq']['mcc_code'])&&$post['acq']['mcc_code']){
			$mcc_code_ex=jsondecode($post['acq']['mcc_code']);
		}

	?>
        <div class="col-sm-4 pe-0">
          <div><span class="input-group-text" for="mcc_code_no_add" style="height:50px;">MCC Codes :</span></div>
        </div>
        <div class="col-sm-8 pe-0">
          <select id="mcc_code_no_add" data-placeholder="Start typing the MCC Codes " multiple class="chosen-select form-control" name="acq[mcc_code][]" style="clear:right;" >
            <?=showselect($data['mcc_codes_list'], 0,1)?>
          </select>
          <script>
$(".chosen-select").chosen({
no_results_text: "Opps, nothing found - "
});

<? if(isset($mcc_code_ex)&&$mcc_code_ex){ ?>
	chosen_more_value_f("mcc_code_no_add",[<?=('"'.implodes('", "',$mcc_code_ex).'"');?>]);
<? } ?>
			  
</script>
          <script>
$("#mcc_code_no_add_chosen").css("width", "100%");
$("#mcc_code_no_add_chosen").addClass("bg-vlight4");
$("#mcc_code_no_add_chosen").addClass("form-control");
</script>
        </div>
      </div>
      <div class="col-sm-6"> <span class="form-label" id="basic-addon4">Gateway Activation :</span>
        <select name="bg_active" id="bg_active" class="form-select" required>
          <option value="" disabled selected>Gateway Activation</option>
          <option value="1">Active</option>
          <option value="0">Inactive</option>
          <option value="2">Common</option>
        </select>
        <?
					if(isset($post['bg_active']))
					{?>
        <script>$('#bg_active option[value="<?=prntext($post['bg_active'])?>"]').prop('selected','selected');</script>
        <?
					}?>
      </div>
      <div class="col-sm-6">
        <div class=""> <span class="form-label" id="basic-addon4">Acquirer Mode :</span>
          <select name="account_mode" id="account_mode" class="form-select" required>
            <option value="" disabled selected>Acquirer Mode</option>
            <option value="1">Live</option>
            <option value="2">Test</option>
          </select>
          <? 
		if(isset($post['account_mode']))
		{?>
          <script>$('#account_mode option[value="<?=prntext($post['account_mode'])?>"]').prop('selected','selected');</script>
          <?
		}?>
        </div>
      </div>
      <div class="col-sm-6">
        <div class=""> <span class="form-label" id="basic-addon4">Acquirer No.: </span>
          <input type="text" name="account_no" id="account_no" placeholder="Enter Acquirer No. for Your API" class="form-control" value="<? if(isset($post['account_no'])) echo prntext($post['account_no'])?>"  />
        </div>
      </div>
      <div class="col-sm-6">
        <div class=""> <span class="form-label" id="basic-addon4">Channel Type: </span>
          <select name="account_type" class="form-select" id="account_type" onChange="account_typef(this.value)" required>
            <option value="" disabled selected>Channel Type</option>
            <?
			foreach($data['channel'] as $k3=>$v3){
				echo "<option value='{$k3}'>{$k3}. {$v3['name1']} ({$v3['name2']})</option>";
			}
			?>
          </select>
          <?
		if(isset($post['account_type']))
		{?>
          <script>$('#account_type option[value="<?=prntext($post['account_type'])?>"]').prop('selected','selected');</script>
          <?
		}
		?>
        </div>
      </div>
      <div class="col-sm-6">
        <div class=""> <span class="form-label" id="basic-addon4">Proccessing Mode: </span>
          <select name="account_connect" class="form-select" id="account_connect" required>
            <option value="" disabled selected>Proccessing Mode</option>
            <option value="1">Direct (Curl Option)</option>
            <option value="4">Whitelisting IP - Direct (Curl Option)</option>
            <option value="2">Redirect (Get Method)</option>
            <option value="3">Redirect (Post Method)</option>
            <option value="5">Whitelisting IP - Redirect (Post Method)</option>
          </select>
          <?
		if(isset($post['account_connect']))
		{
		?>
          <script>$('#account_connect option[value="<?=prntext($post['account_connect'])?>"]').prop('selected','selected');</script>
          <?
		}
		?>
        </div>
      </div>
      <div class="col-sm-6"> <span class="form-label" id="basic-addon4">Bank Country Name : </span>
        <input type="text" name="bank_country_name" id="bank_country_name" placeholder="Enter Bank Country Name" class="form-control" value="<? if(isset($post['bank_country_name'])) echo prntext($post['bank_country_name'])?>"  />
      </div>
      <div class="col-sm-6"> <span class="form-label" id="basic-addon4">Bank Payment Live URL: </span>
        <textarea class="form-control w-100" name="bank_payment_url" id="bank_payment_url" rows="3" placeholder="Bank Payment Live URL" ><? if(isset($post['bank_payment_url'])) echo $post['bank_payment_url'];?></textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label" id="basic-addon4">Bank Payment Test URL : </span>
        <textarea class="form-control w-100" name="bank_payment_test_url" id="bank_payment_test_url" rows="3" placeholder="" ><? if(isset($post['bank_payment_test_url'])) echo $post['bank_payment_test_url'];?></textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label" id="basic-addon4">Bank Status URL : </span>
        <textarea class="form-control w-100" name="acq[bank_status_url]" id="bank_status_url" rows="3" placeholder="" ><? if(isset($post['acq']['bank_status_url'])) echo $post['acq']['bank_status_url']?></textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label" id="basic-addon4">Bank Refund URL : </span>
        <textarea class="form-control w-100" name="acq[bank_refund_url]" id="bank_refund_url" rows="3" placeholder="" ><? if(isset($post['acq']['bank_refund_url'])) echo $post['acq']['bank_refund_url']?></textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label w-100" id="basic-addon4">Bank Refund Type: </span>
        <select name="acq[bank_refund_type]" id="bank_refund_type" class="form-select"  required>
          <option value="" disabled selected>Bank Refund Type</option>
          <option value="Full Refund">Full Refund</option>
          <option value="Partial Refund">Partial Refund</option>
          <option value="Manual Refund">Manual Refund</option>
          <option value="No Refund">No Refund</option>
        </select>
        <?
		if(isset($post['acq']['bank_refund_type']))
		{
		?>
        <script>$('#bank_refund_type option[value="<?=prntext($post['acq']['bank_refund_type'])?>"]').prop('selected','selected');</script>
        <?
		}
		?>
      </div>
      <div class="col-sm-6"> <span class="form-label " id="basic-addon4">Bank Merchant ID: </span>
        <textarea class="form-control w-100" name="bank_merchant_id" id="bank_merchant_id" rows="3" placeholder="" ><? if(isset($post['bank_merchant_id'])) echo $post['bank_merchant_id'];?></textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label " id="basic-addon4">SiteID/PublicKey: </span>
        <textarea class="form-control w-100" name="siteid" id="siteid" rows="3" placeholder="" ><? if(isset($post['siteid'])) echo $post['siteid'];?></textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label " id="basic-addon4" title="Bank API Token/Secret Key">Bank API Token/Secret: </span>
        <textarea class="form-control w-100" name="bank_api_token" id="bank_api_token" rows="3" placeholder="" ><? if(isset($post['bank_api_token'])) echo $post['bank_api_token'];?></textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label " id="basic-addon4" title="Digest/Hash Code/Encryption Key">Digest/Hash Code/Key: </span>
        <textarea class="form-control w-100" name="hash_code" id="hash_code" rows="3" placeholder=" " ><? if(isset($post['hash_code'])) echo $post['hash_code'];?></textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label " id="basic-addon4">Billing Descriptor : </span>
        <textarea class="form-control w-100" name="billing_descriptor" id="billing_descriptor" rows="3" placeholder=" " ><? if(isset($post['billing_descriptor'])) echo $post['billing_descriptor'];?></textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label " id="basic-addon4">If Static / Whitelisting IP : </span>
        <textarea title="If Static Billing / Whitelisting IP " class="form-control w-100" name="billing_ip" id="billing_ip" rows="3" placeholder=" " ><? if(isset($post['billing_ip'])) echo $post['billing_ip'];?></textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label " id="basic-addon4">Bank Login URL : </span>
        <textarea class="form-control w-100" name="bank_login_url" id="bank_login_url" rows="3" placeholder='{"login_live_url":"","login_test_url":""}' ><? if(isset($post['bank_login_url'])) echo $post['bank_login_url'];?></textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label " id="basic-addon4">Bank User Id : </span>
        <textarea class="form-control w-100" name="bank_user_id" id="bank_user_id" rows="3" placeholder='{"login_live_userId":"","login_test_userId":""}' ><? if(isset($post['bank_user_id'])) echo $post['bank_user_id'];?></textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label " id="basic-addon4">Bank Login Password : </span>
        <textarea class="form-control w-100" name="bank_login_password" id="bank_login_password" rows="3" placeholder="" ><? if(isset($post['bank_login_password'])) echo $post['bank_login_password'];?></textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label " id="basic-addon4">Bank Developer API URL : </span>
        <textarea class="form-control w-100" name="developer_url" id="developer_url" rows="3" placeholder="" ><? if(isset($post['developer_url'])) echo $post['developer_url'];?></textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label " id="basic-addon4">Bank Validate/Status : </span>
        <textarea class="form-control w-100" name="bank_status_url" id="bank_status_url" rows="3" placeholder=" " ><? if(isset($post['bank_status_url'])) echo $post['bank_status_url'];?></textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label " id="basic-addon4" title="Domain for Callback/Process">Domain for Callback: </span>
        <textarea class="form-control w-100" name="bank_process_url" id="bank_process_url" rows="3" placeholder=" https://my.domain.com" ><? if(isset($post['bank_process_url'])) echo $post['bank_process_url'];?></textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label " id="basic-addon4" title="Card Name in comma separated values">Card Name: </span>
        <textarea class="form-control" name="account_custom_field_14" id="account_custom_field_14" rows="3" placeholder="visa,mastercard,amex,jcb,discover,diners" ><? if(isset($post['account_custom_field_14'])) echo $post['account_custom_field_14'];?></textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label " id="basic-addon4" title="Acquirer Custom Field 15">Acquirer Custom Field: </span>
        <textarea class="form-control w-100" name="account_custom_field_15" id="account_custom_field_15" rows="3" placeholder="" ><? if(isset($post['account_custom_field_15'])) echo $post['account_custom_field_15'];?></textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label " id="basic-addon4">Payout Date: </span>
        <select name="date" class="form-select" id="date_payout" >
          <option value="" disabled selected>Payout Date</option>
          <?php foreach($alldate as $key=>$value){ ?>
          <option value="<?php echo date("Y-m-d",strtotime($value));?>"><?php echo date("D d-m-Y",strtotime($value)); ?> (eCheck) </option>
          <?php } ?>
          <?php foreach($alldatem as $key=>$value){ ?>
          <option value="<?php echo date("Y-m-d",strtotime($value));?>"><?php echo date("D d-m-Y",strtotime($value)); ?> (Card) </option>
          <?php } ?>
        </select>
        <?
			if(isset($post['date']))
			{?>
        <script>$('#date_payout option[value="<?php echo date("Y-m-d",strtotime($post['date']));?>"]').prop('selected','selected');</script>
        <?
			}?>
      </div>
      <div class="col-sm-6"> <span class="form-label " id="basic-addon4">Currency From: </span>
        <select name="currency" class="form-select" id="currency" >
          <option value="" disabled selected>Currency From</option>
          <? foreach ($data['AVAILABLE_CURRENCY'] as $k11) { ?>
          <option value="<?=$k11?>">
          <?=$k11?>
          </option>
          <? } ?>
        </select>
        <?
			if(isset($post['currency']))
			{
			?>
        <script>$('#currency option[value="<?=prntext($post['currency'])?>"]').prop('selected','selected');</script>
        <?
			}?>
      </div>
      <div class="col-sm-6"> <span class="form-label " id="basic-addon4">Processing Currency for Bank: </span>
        <select name="currency_to"  class="form-select" id="currency_to" >
          <option value="" disabled selected>Currency To</option>
          <? foreach ($data['AVAILABLE_CURRENCY'] as $k11) {?>
          <option value="<?=$k11?>">
          <?=$k11?>
          </option>
          <? } ?>
        </select>
        <?
			if(isset($post['currency_to']))
			{?>
        <script>$('#currency_to option[value="<?=prntext($post['currency_to'])?>"]').prop('selected','selected');</script>
        <?
			}?>
      </div>
      <div class="col-sm-6"> <span class="form-label " id="basic-addon4">Currency Rate: </span>
        <input type="text" name="currency_rate" placeholder="Enter The Currency Rate" class="form-control" value="<? if(isset($post['currency_rate'])) echo prntext($post['currency_rate'])?>"  />
      </div>
      <div class="col-sm-12"> <span class="form-label" id="basic-addon4">Bank Json: </span>
        <textarea  class="textAreaAdjust form-control w-100" onkeyup="textAreaAdjust(this)" name="bank_json" row="3" placeholder="Enter Bank Json" ><? if(isset($post['bank_json'])) echo $post['bank_json'];?></textarea>
      </div>
      <div class="col-sm-12"> <span class="form-label" id="basic-addon4">Note/Comments: </span>
        <textarea class="textAreaAdjust form-control  w-100" onkeyup="textAreaAdjust(this)"  name="comments" row="3" placeholder="Enter Note"><? if(isset($post['comments'])) echo $post['comments'];?></textarea>
      </div>
      <div class="col-sm-12"> <span class="form-label" id="basic-addon4" title="Hard Code Payment URL">Payment URL</span>
        <textarea class="textAreaAdjust form-control" onKeyUp="textAreaAdjust(this)" name="acq[hard_code_url]" id="hard_code_url" placeholder="Enter Hard Code URL after Base URL " onfocusout="javascript:$('#after_base_hard_code_url').html(this.value);$('#a_after_base_hard_code_url').attr('href',$('#a_after_base_hard_code_url').text());" ><? if(isset($post['acq']['hard_code_url'])) echo $post['acq']['hard_code_url'];?></textarea>
      
      </div>
      <div id="emailHelp" class="form-text44 my-2"><i class="<?=$data['fwicon']['hand'];?>"></i> <a id="a_after_base_hard_code_url" href='<?=$data['Host'];?>/<? if(isset($post['acq']['hard_code_url'])) echo $post['acq']['hard_code_url'];?>' target="_blank" >
<?=$data['Host'];?>/<span id="after_base_hard_code_url"><? if(isset($post['acq']['hard_code_url'])) echo $post['acq']['hard_code_url'];?></span></a>
        </div>
      <div class="col-sm-12"> <span class="form-label" id="basic-addon4" title="Hard Code Status URL">Status URL:</span>
        <textarea class="textAreaAdjust form-control" onKeyUp="textAreaAdjust(this)" row="3" name="acq[hard_code_status_url]" id="hard_code_status_url"  placeholder="Enter Hard Code URL after Base URL " onfocusout="javascript:$('#after_base_hard_code_status_url').html(this.value);$('#a_after_base_hard_code_status_url').attr('href',$('#a_after_base_hard_code_status_url').text());" ><? if(isset($post['acq']['hard_code_status_url'])) echo $post['acq']['hard_code_status_url'];?></textarea>
       
      </div>
      <div class="my-2"><i class="<?=$data['fwicon']['hand'];?>"></i> <a id="a_after_base_hard_code_status_url" href='<?=$data['Host'];?>/<? if(isset($post['acq']['hard_code_status_url'])) echo $post['acq']['hard_code_status_url'];?>' target="_blank" >
<?=$data['Host'];?>/<span id="after_base_hard_code_status_url"><? if(isset($post['acq']['hard_code_status_url'])) echo $post['acq']['hard_code_status_url'];?></span></a>
</div>
      <div class="col-sm-12"> <span class="form-label" id="basic-addon4" title="Hard Code Live Status URL">Live Status URL:</span>
        <textarea class="textAreaAdjust form-control" onKeyUp="textAreaAdjust(this)" row="3" name="acq[hard_code_live_status_url]" id="hard_code_live_status_url" placeholder="Enter Hard Code URL after Base URL " onfocusout="javascript:$('#after_base_hard_code_live_status_url').html(this.value);$('#a_after_base_hard_code_live_status_url').attr('href',$('#a_after_base_hard_code_live_status_url').text());" ><? if(isset($post['acq']['hard_code_live_status_url'])) echo $post['acq']['hard_code_live_status_url'];?></textarea>
      </div>
      <div class="my-2"> <i class="<?=$data['fwicon']['hand'];?>"></i> <a id="a_after_base_hard_code_live_status_url" href='<?=$data['Host'];?>/<? if(isset($post['acq']['hard_code_live_status_url'])) echo $post['acq']['hard_code_live_status_url'];?>' target="_blank" >
        <?=$data['Host'];?>/<span id="after_base_hard_code_live_status_url"><? if(isset($post['acq']['hard_code_live_status_url'])) echo $post['acq']['hard_code_live_status_url'];?></span></a></div>
      <div class="col-sm-12"> <span class="form-label" id="basic-addon4" title="Hard Code Refund URL">Refund URL:</span>
        <textarea class="textAreaAdjust form-control" onKeyUp="textAreaAdjust(this)" row="3" name="acq[hard_code_refund_url]" id=hard_code_refund_url placeholder="Enter Hard Code URL after Base URL " onfocusout="javascript:$('#after_base_hard_code_refund_url').html(this.value);$('#a_after_base_hard_code_refund_url').attr('href',$('#a_after_base_hard_code_refund_url').text());" ><? if(isset($post['acq']['hard_code_refund_url'])) echo $post['acq']['hard_code_refund_url'];?></textarea>
      </div>
      <div class="my-2"> <i class="<?=$data['fwicon']['hand'];?>"></i> <a id="a_after_base_hard_code_refund_url" href='<?=$data['Host'];?>/<? if(isset($post['acq']['hard_code_refund_url'])) echo $post['acq']['hard_code_refund_url'];?>' target="_blank" >
<?=$data['Host'];?>/<span id="after_base_hard_code_refund_url"><? if(isset($post['acq']['hard_code_refund_url'])) echo $post['acq']['hard_code_refund_url'];?></span></a>
         </div>
      <div class="row border bd-yellow-100 my-2 text-start py-2 vkgclr rounded" >
        <div class="row btn btn-outline-light fw-bold text-dark mb-2">Additional Bank Response</div>
        <div class="col-sm-6">
          <label for="Acquirer ID" class="form-label">Maximum Continuously Fail Transaction Allowed:</label>
          <input type="number" class="form-control" name="inactive_failed_count" value="<? if(isset($post['inactive_failed_count'])) echo $post['inactive_failed_count'];?>" placeholder="50" />
        </div>
        <?
				$post['inactive_start_time'] = str_replace('0000-00-00 00:00:00','',$post['inactive_start_time']);
				$post['inactive_end_time'] = str_replace('0000-00-00 00:00:00','',$post['inactive_end_time']);
				if(isset($post['inactive_start_time'])&&$post['inactive_start_time']&&isset($post['inactive_end_time'])&&$post['inactive_end_time'])
				{
					$post['inactive_time_period'] = $post['inactive_start_time'].' to '.$post['inactive_end_time'];
				}
				?>
        <div class="col-sm-6">
          <label for="inactive_time_period" class="form-label">Down Schedule Periods </label>
          <input type="text" class="form-control" id="inactive_time_period" name="inactive_time_period" placeholder="Inactive Start Time" value="<? if(isset($post['inactive_time_period'])) echo $post['inactive_time_period'];?>" />
        </div>
        <div class="col-sm-6">
          <label for="emailIds" class="form-label">Email Ids:</label>
          <textarea class="textAreaAdjust form-control" onkeyup="textAreaAdjust(this)" row="3" id="emailIds" name="emailIds" placeholder='Email1, Email2, Email3'><? if(isset($post['emailIds'])) echo $post['emailIds'];?></textarea>
        </div>
        <div class="col-sm-6">
          <label for="Acquirer ID" class="form-label"></label>
        </div>
        <div class="col-sm-6">
          <label for="Acquirer ID" class="form-label">B. Success Response:</label>
          <textarea class="textAreaAdjust form-control" onkeyup="textAreaAdjust(this)" row="3" name="acq[br_success]"  placeholder='value1,value2,value3' ><? if(isset($post['acq']['br_success'])) echo $post['acq']['br_success'];?></textarea>
        </div>
        <div class="col-sm-6">
          <label for="Acquirer ID" class="form-label">B. Failed Response:</label>
          <textarea class="textAreaAdjust form-control" onkeyup="textAreaAdjust(this)" rows="1" name="acq[br_failed]"  placeholder='value1,value2,value3' ><? if(isset($post['acq']['br_failed'])) echo $post['acq']['br_failed'];?></textarea>
        </div>
        <div class="col-sm-6">
          <label for="Acquirer ID" class="form-label">B. Pending Response:</label>
          <textarea class="textAreaAdjust form-control" onkeyup="textAreaAdjust(this)" rows="1" name="acq[br_pending]"  placeholder='value1,value2,value3' ><? if(isset($post['acq']['br_pending'])) echo $post['acq']['br_pending'];?></textarea>
        </div>
        <div class="col-sm-6">
          <label for="Acquirer ID" class="form-label">Bank Status Path:</label>
          <textarea class="textAreaAdjust form-control" onkeyup="textAreaAdjust(this)" rows="1" name="acq[br_status_path]"  placeholder='api/pay22/processed' ><? if(isset($post['acq']['br_status_path'])) echo $post['acq']['br_status_path'];?></textarea>
        </div>
      </div>
      <div class="row border bd-blue-100 my-2 text-start py-2 vkgclr rounded">
        <div class="row btn btn-outline-light text-dark fw-bold mb-2">Bank Transaction</div>
        <div class="col-sm-6">
          <label for="Acquirer ID" class="form-label">Min Trxn Limit: <font class="acct_curr">(
          <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
          )</font></label>
          <input type="text" class="form-control" name="acq[min_limit]" id="min_limit" size="20" value="<?=(isset($post['acq']['min_limit'])&&$post['acq']['min_limit']?$post['acq']['min_limit']:"1")?>">
        </div>
        <div class="col-sm-6">
          <label for="Acquirer ID" class="form-label">Max Trxn Limit: <font class="acct_curr">(
          <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
          )</font></label>
          <input type="text" class="form-control" name="acq[max_limit]" id="max_limit" size="30" value="<?=(isset($post['acq']['max_limit'])&&$post['acq']['max_limit']?$post['acq']['max_limit']:"500");?>">
        </div>
        <div class="col-sm-6">
          <label for="Acquirer ID" class="form-label">Scrubbed Period:</label>
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
          <label for="Acquirer ID" class="form-label">Trxn Count:</label>
          <input type="text"  class="form-control" name="acq[transaction_count]" id="transaction_count" size="20" value="<?=(isset($post['acq']['transaction_count'])&&$post['acq']['transaction_count']?$post['acq']['transaction_count']:"7");?>">
        </div>
        <div class="col-sm-6">
          <label for="Acquirer ID" class="form-label">Min. Success Count:</label>
          <input class="form-control" type="text" name="acq[tr_scrub_success_count]" id="tr_scrub_success_count" size="20" value="<?=(isset($post['acq']['tr_scrub_success_count'])&&$post['acq']['tr_scrub_success_count']?$post['acq']['tr_scrub_success_count']:'2');?>">
        </div>
        <div class="col-sm-6">
          <label for="Acquirer ID" class="form-label">Min. Failed Count:</label>
          <input type="text" class="form-control" name="acq[tr_scrub_failed_count]" id="tr_scrub_failed_count" size="20" value="<?=(isset($post['acq']['tr_scrub_failed_count'])&&$post['acq']['tr_scrub_failed_count']?$post['acq']['tr_scrub_failed_count']:'5')?>">
        </div>
        <!--<span class="hide1 noneClick1 row">-->
<?/*?>
        <div class="col-sm-6">
          <label for="Acquirer ID" class="form-label">Setup Fee (USD):</label>
          <input type="text" class="form-control" name="acq[setup_fee]" id="setup_fee" size="20" value="<? if(isset($post['acq']['setup_fee'])) echo $post['acq']['setup_fee']?>">
        </div>
        <div class="col-sm-6">
          <label for="Acquirer ID" class="form-label">Setup Fee  Collected:</label>
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
        <!--</span>-->
      </div>
      <div class="row border bd-red-100 my-2 text-start py-2 vkg text-white rounded">
        <div class="row btn btn-outline-info text-dark fw-bold mb-2">Process Transaction</div>
        <div class="col-sm-6">
          <label for="Acquirer ID" class="form-label">Processing Mode:
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
          <label for="Acquirer ID" class="form-label">Default Currency:</label>
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
          <label for="Acquirer ID" class="form-label">
          <? if(isset($acc_arr[2])) echo $acc_arr[2];?>
          Discount Rate(%):</label>
          <? if(isset($acc_arr[2])) echo $acc_arr[2];?>
          <input type="text" class="form-control" name="acq[transaction_rate]" id="transaction_rate" size="20" placeholder="13%" value="<? if(isset($post['acq']['transaction_rate'])) echo $post['acq']['transaction_rate']?>">
        </div>
        <? if($data['con_name']=='clk'){ ?>
        <div class="col-sm-6">
          <label class="form-label" for="gst_fee" >GST Fee(%):<span class="mand">*</span></label>
          <input class="form-control" type="text" name="acq[gst_fee]" id="gst_fee" size=20 placeholder="Ex. 18" value="<?=((isset($post['acq']['gst_fee'])&&$post['acq']['gst_fee'])?$post['acq']['gst_fee']:((isset($data['domain_server']['as']['gst_fee'])&&$data['domain_server']['as']['gst_fee'])?$data['domain_server']['as']['gst_fee']:"18"));?>">
        </div>
        <? } ?>
        <div class="col-sm-6">
          <label for="Acquirer ID" class="form-label">Settlement Period:</label>
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
          <label for="Acquirer ID" class="form-label">
          <? if(isset($acc_arr[2])) echo $acc_arr[2];?>
          Txn. Fee (Success): </label>
          <input type="text" class="form-control" name="acq[txn_fee]" id="txn_fee" size="20" placeholder="4.0" value="<? if(isset($post['acq']['txn_fee'])) echo $post['acq']['txn_fee']?>">
        </div>
        <div class="col-sm-6">
          <label for="Acquirer ID" class="form-label">
          <? if(isset($acc_arr[2])) echo $acc_arr[2];?>
          Txn. Fee (Failed): </label>
          <input type="text" name="acq[txn_fee_failed]" id="txn_fee_failed" size="20"  class="form-control" value="<? if(isset($post['acq']['txn_fee_failed'])) echo $post['acq']['txn_fee_failed']?>">
        </div>
        <div class="col-sm-6">
<label for="Acquirer ID" class="form-label">Display Order: </label>
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
            <option title="" value="">Select Display Order</option>
            <?
				$sum = 0;
				for($f = 1; $f <= 290; $f++){ 
					//unset($data['subadmin'][$f]['id']);$sum = $sum + $f;
					if(isset($_SESSION['shorting_ar'])&&(in_array((int)$f, $_SESSION['shorting_ar'], false))){?>
            <option title="<?=($post['acq']['shorting']==$f?"Current":"Added")?> in <?=array_search($f,$_SESSION['shorting_ar']);?> Acquirer" value="<?=$f;?>" <?=($post['acq']['shorting']==$f?"":" disabled='disabled'")?> >
            <?=$f;?>
            :
            <?=($post['acq']['shorting']==$f?"Current":"Added")?>
            in
            <?=array_search($f,$_SESSION['shorting_ar']);?>
            Acquirer </option>
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
          <label for="Acquirer ID col-sm-4" class="form-label">Rolling Reserve: </label>
          <div class="col-sm-6 mb-1">
            <input type="text" class="form-control float-start" style="width: calc(100% - 50px);" name="acq[rolling_fee]" id="rolling_fee" placeholder="10%" value="<? if(isset($post['acq']['rolling_fee'])) echo $post['acq']['rolling_fee']?>">
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
            <?
				if(isset($post['acq']['rolling_period']))
				{?>
            <script>$('#rolling_period option[value="<?=$post['acq']['rolling_period']?>"]').prop('selected','selected');</script>
            <?
				}?>
          </div>
        </div>
        <div class="col-sm-6 hide">
          <label for="Acquirer ID" class="form-label">Min. Settlement Amt.:<font class="acct_curr hide">(
          <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
          )</font></label>
          <input type="text" class="form-control"  style="display:none"; name="acq[settled_amt]" id="settled_amt" size="20" value="<? if(isset($post['acq']['settled_amt'])) echo $post['acq']['settled_amt']?>"></div>
      </div>
      <div class="row border bd-gray-100 my-2 text-start py-2 border text-dark rounded">
        <h4 class="row btn btn-outline-light text-dark fw-bold mb-2 text-dark">Charge Back</h4>
        <div class="col-sm-6">
          <label for="Acquirer ID" class="form-label">CB Fee Tier 1: <font class="acct_curr">(
          <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
          )</font></label>
          <input type="text" class="form-control" name="acq[charge_back_fee_1]" id="charge_back_fee_1" value="<? if(isset($post['acq']['charge_back_fee_1'])) echo $post['acq']['charge_back_fee_1']?>">
        </div>
        <div class="col-sm-6">
          <label for="Acquirer ID" class="form-label">CB Fee Tier 2:</label>
          <input type="text" class="form-control" name="acq[charge_back_fee_2]" id="charge_back_fee_2"value="<? if(isset($post['acq']['charge_back_fee_2'])) echo $post['acq']['charge_back_fee_2']?>">
        </div>
        <div class="col-sm-6">
          <label for="Acquirer ID" class="form-label">CB Fee Tier 3: <font class="acct_curr">(
          <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
          )</font></label>
          <input type="text" class="form-control" name="acq[charge_back_fee_3]" id="charge_back_fee_3" value="<? if(isset($post['acq']['charge_back_fee_3'])) echo $post['acq']['charge_back_fee_3']?>">
        </div>
        <div class="col-sm-6">
          <label for="Acquirer ID" class="form-label">CBK1:</label>
          <input type="text" class="form-control" name="acq[cbk1]" id="cbk1" value="<? if(isset($post['acq']['cbk1'])) echo $post['acq']['cbk1']?>">
        </div>
        <div class="col-sm-6 hide">
          <label for="Acquirer ID" class="form-label">Monthly Maintenance Fee: <font class="acct_curr">(
          <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
          )</font></label>
          <input type="text" class="form-control" name="acq[monthly_fee]" id="monthly_fee"  value="<? if(isset($post['acq']['monthly_fee'])) echo $post['acq']['monthly_fee']?>">
        </div>
        <div class="col-sm-6">
          <label for="Acquirer ID" class="form-label">Refund Fee: <font class="acct_curr">(
          <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
          )</font></label>
          <input type="text"  class="form-control" name="acq[refund_fee]" id="refund_fee" value="<? if(isset($post['acq']['refund_fee'])) echo $post['acq']['refund_fee']?>">
        </div>
        <div class="col-sm-6 hide">
          <label for="Acquirer ID" class="form-label">Settlement Wire Fee: <font class="acct_curr">(
          <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
          )</font></label>
          <input type="text" style="display:none;" class="form-control" name="acq[return_wire_fee]" id="return_wire_fee" value="<? if(isset($post['acq']['return_wire_fee'])) echo $post['acq']['return_wire_fee']?>">
        </div>
<?/*?>		
        <div class="col-sm-6">
          <label for="Acquirer ID" class="form-label">Settlement Report View:</label>
          <select name="acq[view_settelement_report]" class="form-select" id="view_settelement_report">
            <option value="" disabled="" >Download Report</option>
            <option value="1">Allowed</option>
            <option value="2">Not Allowed</option>
          </select>
          <?
			if(isset($post['acq']['view_settelement_report']))
			{?>
          <script>$('#view_settelement_report option[value="<?=$post['acq']['view_settelement_report']?>"]').prop('selected','selected');</script>
          <?
			}
			?>				 </div>
<?*/?>	
        </div>
      </div>
      <!--</span> -->
      <div class="row border bd-green-100 my-2 text-start py-2 border text-white rounded">
        <div class="row btn btn-outline-light text-dark fw-bold mb-2">Other Details</div>
        <div class="col-sm-6">
          <label for="Acquirer ID" class="form-label">Bank Siteid:</label>
          <textarea class="textAreaAdjust form-control" onKeyUp="textAreaAdjust(this)" name="acq[hkip_siteid]" id="hkip_siteid"><? if(isset($post['acq']['hkip_siteid'])) echo $post['acq']['hkip_siteid'];?></textarea>
        </div>
        <div class="col-sm-6">
          <label for="Acquirer ID" class="form-label">Bank Salt:</label>
          <textarea class="textAreaAdjust form-control" onKeyUp="textAreaAdjust(this)" name="acq[bank_salt]" id="hkip_siteid" ><? if(isset($post['acq']['bank_salt'])) echo $post['acq']['bank_salt'];?></textarea>
        </div>
        <div class="col-sm-6">
          <label for="Acquirer ID" class="form-label">Checkout Level Name:</label>
          <input type="text" class="form-control" name="acq[checkout_level_name]" id="checkout_level_name" value="<? if(isset($post['acq']['checkout_level_name'])) echo $post['acq']['checkout_level_name']?>">
        </div>
        <div class="col-sm-6">
          <label for="Acquirer ID" class="form-label">Merchant Preferences:</label>
          <input type="checkbox" name="acq[notification_to_005]" id='notification_to5' class='checkbox_d form-check-input' value='005'<?php if(isset($post['acq']['notification_to_005'])&&strpos($post['acq']['notification_to_005'],"005")!==false){echo "checked='checked'";}?>>
          Encrypt Customer Email </div>
      </div>
    </div>
    <div class="my-2 text-center row p-0">
      <div class="col-sm-12 my-2 remove-link-css">
        <button formnovalidate type="submit" name="send" value="CONTINUE"  class="btn btn-icon btn-primary"><i class="<?=$data['fwicon']['circle-plus'];?>"></i> Submit</button>
        <a href="<?=$data['Admins']?>/bank_gateway<?=$data['ex']?>" class="btn btn-icon btn-primary"><i class="<?=$data['fwicon']['back'];?>"></i> Back</a> </div>
    </div>
    <? }?>
  </form>
</div>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? }?>
<!--</div> -->
<!--Include file for calender script  already added on header-->
<?php /*?><script type="text/javascript" src="<?=$data['Host']?>/thirdpartyapp/date_range/moment.min.js"></script>
<script type="text/javascript" src="<?=$data['Host']?>/thirdpartyapp/date_range/daterangepicker.js"></script>
<link rel="stylesheet" type="text/css" href="<?=$data['Host']?>/thirdpartyapp/date_range/daterangepicker.css" /><?php */?>
<?
if(isset($post['inactive_time_period'])&&$post['inactive_time_period'])
{
	$periodArr = explode('to', $post['inactive_time_period']);
	$start	= trim($periodArr[0]);
	$end	= trim($periodArr[1]);
}
else
{
	$start	= date('Y-m-d H:i:s');
	$end	= date('Y-m-d H:i:s', strtotime("+1 days"));
}
?>
<script>

var start_bg = "<?=((isset(($start))&&($start))?(date('m/d/Y H:i',strtotime($start))):'')?>";
var end_bg = "<?=((isset(($end))&&($end))?(date('m/d/Y H:i',strtotime($end))):'')?>";


$(function() {

	$('input[name="inactive_time_period"]').daterangepicker({
		autoUpdateInput: false,
		timePicker: true,
		timePicker24Hour: true,
		
		startDate: start_bg,
		endDate: end_bg,
		locale: {
			cancelLabel: 'Clear',
			format: 'M/DD HH:mm'
		}
	});

	$('input[name="inactive_time_period"]').on('apply.daterangepicker', function(ev, picker) {
		$(this).val(picker.startDate.format('YYYY-MM-DD HH:mm:ss') + ' to ' + picker.endDate.format('YYYY-MM-DD HH:mm:ss'));
	});
	
	$('input[name="inactive_time_period"]').on('cancel.daterangepicker', function(ev, picker) {
		$(this).val('');
	});
});
</script>
