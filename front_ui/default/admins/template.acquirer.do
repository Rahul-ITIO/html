<? if(isset($data['ScriptLoaded'])){ ?>

<?
$lableName="Acquirer";
//$lableName="Connector";

	$data['channel_types']=[1=>'e-Check Payment',2=>'2D Card Payment',3=>'3D Card Payment',4=>'Wallets Payment',5=>'Click Zep Project',6=>'UPI Payment',7=>'Net Banking Payment',8=>'Nodal Account Payment',9=>'Coins Payment',9=>'Network Payment',99=>'Other Payment'];
	$data['connection_methods']=[1=>'Direct (Curl Option)',2=>'Redirect (Get Method)',3=>'Redirect (Post Method)',4=>'Whitelisting IP - Direct (Curl Option)',5=>'Whitelisting IP - Redirect (Post Method)'];
?>
<style>
  .hide_connector_X {display:none;}
.mop_div i, img {padding:0 3px;font-size:30px !important;height:24px !important;}
</style>
<div class="container border my-1 rounded">
  <form method="post" name="data">
    <input type="hidden" name="step" value="<?=$post['step']?>">
    <script>
	// js for scrubbed validation
function channel_typef(theValue){
	if(theValue=="5"){
		$('.noneClick').slideUp(500);
		$('#scrubbed_period option[value="1"]').prop('selected','selected');
		$('#acquirer_processing_mode option[value="1"]').prop('selected','selected');
		$('#acquirer_processing_currency option[value="₹ INR"]').prop('selected','selected');
		$('#settelement_delay option[value="1"]').prop('selected','selected');
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
	window.location.href="<?=$data['Admins']?>/acquirer<?=$data['ex']?>?active_filter="+thisVal+sub_q2;
}


$(document).ready(function(){ 
	
	//$(".textAreaAdjust").trigger("keyup");
	textAreaAdjustf('.textAreaAdjust');
	
	$('#channel_type').trigger('change');
	
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
      <? if((isset($data['ErroFocus'])&& $data['ErroFocus'])){ ?>
			$( "input[name=<?=$data['ErroFocus']?>], #<?=$data['ErroFocus']?>" ).focus();
	   <? }?>
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
      <?=prntext($data['sucess'])?>
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
          <h4 class="my-2"><i class="<?=$data['fwicon']['bank-gateway'];?>"></i> Acquirer Table <?php /*?><b><?=$data['db_count']?> </b><?php */?> <a data-ihref="<?=$data['Admins']?>/json_log_all<?=$data['ex']?>?tablename=acquirer_table" title="View Json Log History" onclick="iframe_open_modal(this);"><i class="<?=$data['fwicon']['circle-info'];?> text-danger fa-fw"></i></a></h4>
          
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
			$('#active_filter option[value="<?=(@$_GET['active_filter'])?>"]').prop("selected", "selected");
		</script>
        <button type="submit" name="send" value="Add A New <?=@$lableName;?>!"  class="btn btn-primary" title="Add A New <?=@$lableName;?>"><i></i><i class="<?=$data['fwicon']['circle-plus'];?>"></i></button>
      </div>
    </div>
   <div class="container table-responsive">
      <table class="table table-hover">
        <thead>
          <tr>
		    <th scope="col">#</th>
            <th scope="col">Status</th>
            <th scope="col">Acquirer No./Mode</th>
            <th scope="col">Bank URL</th>
            <th scope="col">Action</th>
          </tr>
        </thead>
        <? $j=1; foreach($post['result_list'] as $key=>$value) {
		  $bgcolor=$j%2 ?'#FFFFFF':'#E7E7E7';
		  
		if(isset($value['select_mcc'])&&$value['select_mcc']){
			//$select_mcc=jsonencode($value['select_mcc']);
			$select_mcc_exp=explode(",",$value['select_mcc']);
			$mcc_code_str=implode(",",$select_mcc_exp);
			$website_mcc_code=merchant_categoryf(0,0,$mcc_code_str);
			if(isset($website_mcc_code)&&$website_mcc_code&&isset($mcc_code_str)&&$mcc_code_str){
			$value['select_mcc']=implode(" , ",$data['mcc_codes_list']);
			}
		}
		
		if($value['mer_setting_json']){
			$value['acq']=isJsonDe($value['mer_setting_json']);
			$value['a_arr']=isJsonDe($value['mer_setting_json']);
			$pro_cur=(isset($value['a_arr']['acquirer_processing_currency'])?$value['a_arr']['acquirer_processing_currency']:'');
			//echo "<br/><br/>a_arr({$value['acquirer_id']})=>"; print_r($value['a_arr']);
			
			
			if( (isset($value['acq'])&&$value['acq']) && (is_array($value['acq']) || is_object($value['acq'])) ){
				foreach($value['acq'] as $key2=>$value2){
					if(is_array($value2)){
						$value['acq'][$key2]=json_encode($value2);
					}
				}
			} 
		}
		
		if($value['acquirer_label_json']){
			$value['aLj']=isJsonDe($value['acquirer_label_json']);
			if( (isset($value['aLj'])&&$value['aLj']) && (is_array($value['aLj']) || is_object($value['aLj'])) ){
				foreach($value['aLj'] as $key3=>$value3){
					if(is_array($value2)){
						$value['aLj'][$key3]=json_encode($value3);
					}
				}
			} 
		}
		//?a=popup_msg_web
		if(isset($_GET['a'])&&isset($value['aLj'][$_GET['a']])&&trim($value['aLj'][$_GET['a']])){
			echo "<br/><=".$_GET['a']."=>".$value['aLj'][$_GET['a']];
		}
	?>
        <tr>
		<td><a data-bs-toggle="modal" data-count="<?=prntext($value['id'])?>" class="tr_open_on_modal text-decoration-none" data-bs-target="#myModal"><i class="<?=$data['fwicon']['display'];?> text-link pointer" title="View details"></i></a></td>
          
		<td nowrap data-label="Status - ">
			<? if($value['acquirer_status']==1){ ?>
            Active
            <? }elseif($value['acquirer_status']==2){ ?>
            Common
            <? }else{ ?>
            Inactive
            <? }?>
          </td>
			
          <td  data-label="A/c No./Mode - " ><span class="text-wrap" style="max-width: 150px;" title="<? if(isset($value['acquirer_id'])) echo $value['acquirer_id'];?> / <? if(isset($value['acquirer_prod_mode'])&&$value['acquirer_prod_mode']==1){echo "Live";}else{echo "Test";}?>  <?=(isset($value['aLj']['acquirer_name'])&&$value['aLj']['acquirer_name']?' / '.$value['aLj']['acquirer_name']:" ");?> <?=(isset($data['channel'][$value['channel_type']]['name1'])&&$value['channel_type']?' / '.strtoupper($data['channel'][$value['channel_type']]['name1']):" ");?> ">
            <? if(isset($value['acquirer_id'])) echo $value['acquirer_id'];?>
            /
            <? if(isset($value['acquirer_prod_mode'])&&$value['acquirer_prod_mode']==1){echo "Live";}else{echo "Test";}?>
            			
			<?=(isset($value['aLj']['acquirer_name'])&&$value['aLj']['acquirer_name']?' / '.$value['aLj']['acquirer_name']:" ");?>
			
			<?=(isset($data['channel'][$value['channel_type']]['name1'])&&$value['channel_type']?' / '.strtoupper($data['channel'][$value['channel_type']]['name1']):" ");?>
			
			<?=(isset($data['channel'][$value['channel_type']]['name2'])&&$value['channel_type']?' / '.$data['channel'][$value['channel_type']]['name2']:" ");?>
 
				</span>
				
				<? if(isset($value['select_mcc'])&&$value['select_mcc']){ ?>
					<a class="dotdot nomid modal_for_iframe" href='<?=$data['Admins'];?>/json_pretty_print<?=$data['ex']?>?json=<?=encryptres($value['select_mcc']);?>' title="MCC Code: <?=prntext($value['select_mcc']);?>" style="cursor:pointer;float:none;display:inline-block;position: relative;padding: 3px 10px;vertical-align: middle;" >
						<i class="<?=$data['fwicon']['tag'];?> text-success"></i>
						 
					 </a>
				<? } ?>
			</td>
			
          <td  data-label="Acquirer Url - "><div title="<?=prntext(lf($value['acquirer_prod_url'],25,1));?>" class="short_display_on_mobile">
            <a class="dotdot nomid modal_for_iframe" data-ihref='<?=$data['Admins'];?>/json_pretty_print<?=$data['ex']?>?json=<?=encryptres($value['acquirer_prod_url']);?>' href='<?=$data['Admins'];?>/json_pretty_print<?=$data['ex']?>?json=<?=encryptres($value['acquirer_prod_url']);?>'> 
            <?=prntext(lf($value['acquirer_prod_url'],125,1));?>
            </a> </div></td>
          
          <td data-label="Action - " class="text-wrap" ><? if(isset($_SESSION['login_adm'])){ ?>
		  
		  <div class="btn-group dropstart short-menu-auto-main"> <a data-bs-toggle="dropdown" aria-expanded="false"  title="Action"><i class="<?=$data['fwicon']['action'];?> text-link"></i></a>
                <ul class="dropdown-menu dropdown-menu-icon pull-right" >
                  <li> <a class="dropdown-item" href="<?=$data['Admins'];?>/acquirer<?=$data['ex']?>?id=<?=$value['id']?>&action=update" title="Edit" ><i class="<?=$data['fwicon']['edit'];?> text-success fa-fw float-start"></i> <span class="action_menu">Edit</span></a></li>
				  
                  <li> <a class="dropdown-item" href="<?=$data['Admins'];?>/acquirer<?=$data['ex']?>?id=<?=$value['id']?>&action=duplicate" title="Duplicate" onclick="return confirm('Are you Sure to Create Duplicate');"><i class="<?=$data['fwicon']['copy'];?> fa-fw float-start"></i> <span class="action_menu">Create Duplicate</span></a></li>

                  <li> <a class="dropdown-item"  href="<?=$data['Admins'];?>/acquirer<?=$data['ex']?>?id=<?=$value['id']?>&action=delete" onclick="return confirm('Are you Sure to Delete');" title="Delete"><i class="<?=$data['fwicon']['delete'];?>   fa-fw text-danger float-start"></i> <span class="action_menu">Delete</span></a></li>
				  
			<? if(isset($value['json_log_history'])&&$value['json_log_history']){?>
			<li> 
			<a class="dropdown-item"  
			onclick="popup_openv('<?=$data['Host']?>/include/json_log<?=$data['ex']?>?tableid=<?=$value['id'];?>&tablename=acquirer_table')" title="View Json History"> 
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
    <td colspan="5">
	 <div class="next_tr_<?=prntext($value['id']);?> hide row">
	 <div class="mboxtitle hide">
		Acquirer Detail :: <?=$value['id'];?> = 
		(<? if(isset($value['acquirer_id'])) echo $value['acquirer_id'];?>
            /
            <? if(isset($value['acquirer_prod_mode'])&&$value['acquirer_prod_mode']==1){echo "Live";}else{echo "Test";}?>
            			
			<?=(isset($value['aLj']['acquirer_name'])&&$value['aLj']['acquirer_name']?' / '.$value['aLj']['acquirer_name']:" ");?>
			
			<?=(isset($value['channel_type'])&&$value['channel_type']?' / '.strtoupper($data['channel'][$value['channel_type']]['name1']):" ");?>
			
			<?=(isset($value['channel_type'])&&$value['channel_type']?' / '.$data['channel'][$value['channel_type']]['name2']:" ");?>)
	 </div>
              <div class="row border bg-light my-2 text-start rounded">
			<? if(isset($value['select_mcc'])&&$value['select_mcc']){?>
                  <div class=" col-sm-6">
                  <div class="card my-2 ps-2">MCC Codes: <?=$value['select_mcc'];?></div>
                  </div>
			<?}?> 
                <div class="row col-sm-6">
                  <div class="card my-2">Acquirer Status:
                    <? if($value['acquirer_status']==1){ ?>
                    Active 
                    <? }elseif($value['acquirer_status']==2){ ?>
                    Common
                    <? }else{ ?>
                    Inactive
                    <? }?>
                  </div>
                </div>
                <div class="row col-sm-6 ">
                  <div class="card my-2">Acquirer Mode:
                    <? if($value['acquirer_prod_mode']==1){echo "Live";}else{echo "Test";}?>
                  </div>
                </div>
                <? if(isset($value['acquirer_id'])&&$value['acquirer_id']){?>
                <div class="row col-sm-6 ">
                  <div class="card my-2">Acquirer No.:
                    <? if(isset($value['acquirer_id'])) echo prntext($value['acquirer_id']);?>
                    /
                    <?=(isset($value['aLj']['acquirer_name'])&&$value['aLj']['acquirer_name']?$value['aLj']['acquirer_name']:" ");?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['channel_type'])&&$value['channel_type']){?>
                <div class="row col-sm-6 ">
                  <div class="card my-2">Channel Type:
                    <?=($value['channel_type']);?> | 
                    <?=($data['channel'][$value['channel_type']]['name1']);?> | 
                    <?=($data['channel'][$value['channel_type']]['name2']);?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['connection_method'])&&$value['connection_method']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Connection Method:
                    <? if(isset($data['connection_methods'][$value['connection_method']])) echo prntext($data['connection_methods'][$value['connection_method']]);?>
                  </div>
                </div>
                <? } ?>
               
                
                
                <? if(isset($value['acquirer_descriptor'])&&$value['acquirer_descriptor']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Acquirer Descriptor :
                    <? if(isset($value['acquirer_descriptor'])) echo $value['acquirer_descriptor'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acquirer_wl_ip'])&&$value['acquirer_wl_ip']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Acquirer Whitelisting IP / Webhook url :
                    <? if(isset($value['acquirer_wl_ip'])) echo $value['acquirer_wl_ip'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acquirer_login_creds'])&&$value['acquirer_login_creds']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Acquirer Login Credentials :
                    <? if(isset($value['acquirer_login_creds'])) echo $value['acquirer_login_creds'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acquirer_refund_url'])&&$value['acquirer_refund_url']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Acquirer Refund URL :
                    <? if(isset($value['acquirer_refund_url'])) echo $value['acquirer_refund_url'];?>
                  </div>
                </div>
                <? } ?>
               
			   
                <? if(isset($value['acquirer_status_url'])&&$value['acquirer_status_url']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Acquirer Status URL :
                    <? if(isset($value['acquirer_status_url'])) echo $value['acquirer_status_url'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acquirer_wl_domain'])&&$value['acquirer_wl_domain']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Acquirer Whitelisting Domain:
                    <? if(isset($value['acquirer_wl_domain'])) echo $value['acquirer_wl_domain'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['mop'])&&$value['mop']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">MOP [WEB]:
                    <span title="<?=$value['mop'];?>" class="mop_div btn btn-abv-search text-start"  style="width:max-content;padding:5px 5px 8px 5px;margin:2px 0 5px 0;"><?=mop_option_list_f(2,$value['mop']);?> </span>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['mop_mobile'])&&$value['mop_mobile']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">MOP [MOBILE]:
                    <span class="mop_div btn btn-abv-search text-start"  style="width:max-content;padding:5px 5px 8px 5px;margin:2px 0 5px 0;"><?=mop_option_list_f(2,$value['mop_mobile']);?> </span>
                  </div>
                </div>
                <? } ?>
                
				
            
             
                <? if(isset($value['acquirer_processing_currency'])&&$value['acquirer_processing_currency']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Acquirer Processing Currency:
                    <? if(isset($value['acquirer_processing_currency'])) echo prntext($value['acquirer_processing_currency'])?>
                  </div>
                </div>
                <? } ?>
				
				 <? if(isset($value['acquirer_refund_policy'])&&$value['acquirer_refund_policy']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">Acquirer Refund Policy :
                    <?=prntext($value['acquirer_refund_policy']);?>
                  </div>
                </div>
                <? } ?>
				
				
				<? if(isset($value['bank_refund_type'])&&$value['bank_refund_type']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">Acquirer Refund URL :
                    <?=prntext($value['bank_refund_type']);?>
                  </div>
                </div>
                <? } ?>
				
                
				
                <? if(isset($value['processing_currency_markup'])&&$value['processing_currency_markup']){?>
                <div class="row col-sm-6">
                  <div class="card my-2">Processing currency markup:
                    <? if(isset($value['processing_currency_markup'])) echo prntext($value['processing_currency_markup'])?> %
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acquirer_prod_url'])&&$value['acquirer_prod_url']){?>
                <div class="row col-sm-12">
                  <div class="card my-2">Acquirer Payment Live/Prod. URL: <a href='<?=prntext($value['acquirer_prod_url']);?>' target="_blank">
                    <?=prntext($value['acquirer_prod_url']);?>
                    </a> </div>
                </div>
                <? } ?>
                <? if(isset($value['acquirer_uat_url'])&&$value['acquirer_uat_url']){?>
                <div class="row col-sm-12">
                  <div class="text-wrap card my-2">Acquirer Payment Test/Uat. URL: <a  href='<?=prntext($value['acquirer_uat_url']);?>' target="_blank">
                    <?=prntext($value['acquirer_uat_url']);?>
                    </a></div>
                </div>
                <? } ?>
                <? if(isset($value['acquirer_status_url'])&&$value['acquirer_status_url']){?>
                <div class="row col-sm-12">
                  <div class="card my-2 ps-2">Acquirer Status URL: <a  href='<?=prntext($value['acquirer_status_url']);?>' target="_blank">
                    <?=prntext($value['acquirer_status_url']);?>
                    </a> </div>
                </div>
                <? } ?>
                
                
				
                <? if(isset($value['acquirer_dev_url'])&&$value['acquirer_dev_url']){?>
                <div class="row col-sm-12">
                  <div class="text-wrap card my-2">Acquirer Developer/API URL : <a  href='<?=prntext($value['acquirer_dev_url']);?>' target="_blank">
                    <?=prntext($value['acquirer_dev_url']);?>
                    </a></div>
                </div>
                <? } ?>
              
				
				<div class="row border bd-blue-100 text-start vkg px-2 my-2 rounded" >
					<h4 class="row btn btn-outline-light text-dark text-start" >Acquirer Label Json</h4>
					 <? if(isset($value['acquirer_processing_creds'])&&$value['acquirer_processing_creds']){?>
						<div class="row col-sm-12">
						  <div class="text-wrap card my-2">Acquirer Processing Creds.:
							<?=$value['acquirer_processing_creds'];?>
						  </div>
						</div>
					<? } ?>
						
					<? if(isset($value['aLj']['acquirer_name'])&&$value['aLj']['acquirer_name']){?>
					<div class=" col-sm-6">
					  <div class="card my-2 ps-2" title="name1">Acquirer Name: 
						<?=(isset($value['aLj']['acquirer_name'])&&$value['aLj']['acquirer_name']?$value['aLj']['acquirer_name']:" ");?>
					  </div>
					</div>
					<? }?>
					
					<? if(isset($value['aLj']['skip_checkout_validation'])&&$value['aLj']['skip_checkout_validation']){?>
					<div class=" col-sm-6">
					  <div class="card my-2 ps-2" title="name5">Skip Checkout Validation: 
						<?=(isset($value['aLj']['skip_checkout_validation'])&&$value['aLj']['skip_checkout_validation']?$value['aLj']['skip_checkout_validation']:" ");?>
					  </div>
					</div>
					<? }?>
					
					<? if(isset($value['aLj']['payment_option_web'])&&$value['aLj']['payment_option_web']){?>
					<div class=" col-sm-6">
					  <div class="card my-2 ps-2" title="name2">Checkout Page define [web]: 
						<?=(isset($value['aLj']['payment_option_web'])&&$value['aLj']['payment_option_web']?$value['aLj']['payment_option_web']:" ");?>
					  </div>
					</div>
					<? }?>
				
					<? if(isset($value['aLj']['payment_option_mobile'])&&$value['aLj']['payment_option_mobile']){?>
					<div class=" col-sm-6">
					  <div class="card my-2 ps-2" title="name2">Checkout Page define [mobile]: 
						<?=(isset($value['aLj']['payment_option_mobile'])&&$value['aLj']['payment_option_mobile']?$value['aLj']['payment_option_mobile']:" ");?>
					  </div>
					</div>
					<? }?>
				
					<? if(isset($value['aLj']['popup_msg_web'])&&$value['aLj']['popup_msg_web']){?>
					<div class=" col-sm-6">
					  <div class="card my-2 ps-2" title="name6 for web">Acquirer Redirect Popup Msg [web]:
						<?=(isset($value['aLj']['popup_msg_web'])&&$value['aLj']['popup_msg_web']?$value['aLj']['popup_msg_web']:" ");?>
					  </div>
					</div>
					<? }?>
				
					<? if(isset($value['aLj']['popup_msg_mobile'])&&$value['aLj']['popup_msg_mobile']){?>
					<div class=" col-sm-6">
					  <div class="card my-2 ps-2" title="name6 for mobile">Acquirer Redirect Popup Msg [mobile]:
						<?=(isset($value['aLj']['popup_msg_mobile'])&&$value['aLj']['popup_msg_mobile']?$value['aLj']['popup_msg_mobile']:" ");?>
					  </div>
					</div>
					<? }?>
				
					
				
					<? if(isset($value['aLj']['checkout_label_web'])&&$value['aLj']['checkout_label_web']){?>
					<div class=" col-sm-6">
					  <div class="card my-2 ps-2" title="Checkout Label Name for web">Checkout Label Name [web]:
						<?=(isset($value['aLj']['checkout_label_web'])&&$value['aLj']['checkout_label_web']?$value['aLj']['checkout_label_web']:" ");?>
					  </div>
					</div>
					<? }?>
					
					<? if(isset($value['aLj']['checkout_label_mobile'])&&$value['aLj']['checkout_label_mobile']){?>
					<div class=" col-sm-6">
					  <div class="card my-2 ps-2" title="Checkout Label Name for mobile">Checkout Label Name [mobile]:
						<?=(isset($value['aLj']['checkout_label_mobile'])&&$value['aLj']['checkout_label_mobile']?$value['aLj']['checkout_label_mobile']:" ");?>
					  </div>
					</div>
					<? }?>
					
					<? if(isset($value['aLj']['logo_web'])&&$value['aLj']['logo_web']){?>
					<div class=" col-sm-6">
					  <div class="card my-2 ps-2" title="Logo for web">Checkout Sub-Label Name [web]:
						<?=(isset($value['aLj']['logo_web'])&&$value['aLj']['logo_web']?$value['aLj']['logo_web']:" ");?>
					  </div>
					</div>
					<? }?>
				
					<? if(isset($value['aLj']['logo_mobile'])&&$value['aLj']['logo_mobile']){?>
					<div class=" col-sm-6">
					  <div class="card my-2 ps-2" title="Logo for mobile">Checkout Sub-Label Name [mobile]:
						<?=(isset($value['aLj']['logo_mobile'])&&$value['aLj']['logo_mobile']?$value['aLj']['logo_mobile']:" ");?>
					  </div>
					</div>
					<? }?>
				
				</div>
				
                <? if(isset($value['tech_comments'])&&$value['tech_comments']){?>
                <div class=" rowcol-sm-12">
                  <div class="text-wrap card my-2">Tech Comments:
                    <?=$value['tech_comments'];?>
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
              <div class="row border bd-yellow-100 text-start vkg px-2 my-2 rounded hide_connector" >
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
                <? if(isset($value['acq']['trans_count'])&&$value['acq']['trans_count']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">Trxn Count:
                    <?=(isset($value['acq']['trans_count'])&&$value['acq']['trans_count']?$value['acq']['trans_count']:"7");?>
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
              <div class="row border bd-red-100 text-start vkg px-2 my-2 rounded hide_connector" >
                <h4 class="row btn btn-outline-light text-dark text-start"  style="color:#dc3545 !important;">Process Transaction</h4>
                <? if(isset($value['acq']['acquirer_processing_mode'])&&$value['acq']['acquirer_processing_mode']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">Processing Mode:
                    <? if(isset($value['acq']['acquirer_processing_mode'])&&$value['acq']['acquirer_processing_mode']==1){echo "Live";}elseif(isset($value['acq']['acquirer_processing_mode'])&&$value['acq']['acquirer_processing_mode']==2){echo "Test";}else{echo "Inactive";}?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['acquirer_processing_currency'])&&$value['acq']['acquirer_processing_currency']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">Default Currency:
                    <?
			if(isset($value['acq']['acquirer_processing_currency']))
				$ac_processing_currency=get_currency($value['acq']['acquirer_processing_currency'],1);
			?>
                    <? if(isset($value['acq']['acquirer_processing_currency'])) echo $value['acq']['acquirer_processing_currency'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['mdr_rate'])&&$value['acq']['mdr_rate']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">
                    <? if(isset($acc_arr[2])) echo $acc_arr[2];?>
                    Discount Rate(%):
                    <? if(isset($value['acq']['mdr_rate'])) echo $value['acq']['mdr_rate'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['gst_rate'])&&$value['acq']['gst_rate']){ ?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">GST Fee(%):
                    <?=$value['acq']['gst_rate'];?>
                  </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['settelement_delay'])&&$value['acq']['settelement_delay']){?>
                <div class="col-sm-6">
                  <div class="card my-2 ps-2">Settlement Period:
                    <? if(isset($value['acq']['settelement_delay'])) echo $value['acq']['settelement_delay']?>
                    Days </div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['txn_fee_success'])&&$value['acq']['txn_fee_success']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">
                    <? if(isset($acc_arr[2])) echo $acc_arr[2];?>
                    Txn. Fee (Success):
                    <? if(isset($value['acq']['txn_fee_success'])) echo $value['acq']['txn_fee_success'];?>
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
                <? if(isset($value['acq']['acquirer_display_order'])&&$value['acq']['acquirer_display_order']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">Acquirer Display Order: <? if(isset($value['acq']['acquirer_display_order'])) echo $value['acq']['acquirer_display_order'];?></div>
                </div>
                <? } ?>
                <? if(isset($value['acq']['rolling_delay'])&&$value['acq']['rolling_delay']){?>
                <div class=" col-sm-6">
                  <div class="card my-2 ps-2">Rolling Reserve:
                    <? if(isset($value['acq']['rolling_delay'])) echo $value['acq']['rolling_delay'];?>
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
              <div class="row border text-start vkg px-2 my-2 rounded" >
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
                <? if(isset($value['acq']['acquirer_processing_json'])&&$value['acq']['acquirer_processing_json']){?>
                <div class="col-sm-12">
                  <div class="card my-2 ps-2">Acquirer Processing Json:
                    <? if(isset($value['acq']['acquirer_processing_json'])) echo $value['acq']['acquirer_processing_json'];?>
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
        Acquirer</h4>
      <div class="vkg-main-border"></div>
    </div>
    <div class="row">
      <div class="col-sm-12 my-2"><?=(isset($post['json_log_history'])&&$post['json_log_history']?json_log_view($post['json_log_history'],'View Json Log','0','json_log','','100'):'');?></div>
    </div>
    <div class="badge rounded-pill bg-vdark mb-2 ms-1" style="display: inline-block !important;">
      <? if(isset($post['acquirer_status'])&&$post['acquirer_status']==1){?>
      Active
      <? }elseif(isset($post['acquirer_status'])&&$post['acquirer_status']==2){?>
      Common
      <? }else{ ?>
      Inactive
      <? }?>
	 
	  <?=(isset($post['acquirer_label_json']['acquirer_name'])&&$post['acquirer_label_json']['acquirer_name']?' / '.$post['acquirer_label_json']['acquirer_name'].' / ':" ");?>
	  
    
      <? if(isset($post['acquirer_prod_mode'])&&$post['acquirer_prod_mode']==1){echo "Live";}else{echo "Test";}?>
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
		if(isset($post['select_mcc'])&&$post['select_mcc']&&is_string($post['select_mcc'])){
			//$mcc_code_ex=jsondecode($post['select_mcc']);
			$mcc_code_ex=explode(",",$post['select_mcc']);
		}

	?>
        <div class="col-sm-4 pe-0">
          <div><span class="input-group-text" for="mcc_code_no_add" style="height:50px;">MCC Codes :</span></div>
        </div>
        <div class="col-sm-8 pe-0">
          <select id="mcc_code_no_add" data-placeholder="Start typing the MCC Codes " multiple class="chosen-select form-control" name="select_mcc[]" style="clear:right;" >
            <?=showselect($data['mcc_codes_list'], 0,1)?>
          </select>
          <script>
$(".chosen-select").chosen({
no_results_text: "Opps, nothing found - "
});

<?if(isset($mcc_code_ex)&&$mcc_code_ex){?>
	chosen_more_value_f("mcc_code_no_add",[<?=('"'.implodes('", "',$mcc_code_ex).'"');?>]);
<?}?>
			  
</script>
          <script>
$("#mcc_code_no_add_chosen").css("width", "100%");
$("#mcc_code_no_add_chosen").addClass("bg-vlight99");
$("#mcc_code_no_add_chosen").addClass("form-control");
</script>
        </div>
      </div>
      <div class="col-sm-6"> <span class="form-label Activation" ><?=@$lableName;?> Status : <i class="<?=$data['fwicon']['star'];?> text-danger"></i></span>
        <select name="acquirer_status" id="acquirer_status" class="form-select" required >
          <option value="" disabled selected><?=@$lableName;?> Status</option>
          <option value="1">Active</option>
          <option value="0">Inactive</option>
          <option value="2">Common</option>
        </select>
        <?if(isset($post['acquirer_status'])){?>
        <script>$('#acquirer_status option[value="<?=prntext($post['acquirer_status'])?>"]').prop('selected','selected');</script>
        <?}?>
      </div>
      <div class="col-sm-6">
        <div class=""> <span class="form-label" ><?=@$lableName;?> Mode : <i class="<?=$data['fwicon']['star'];?> text-danger"></i></span>
          <select name="acquirer_prod_mode" id="acquirer_prod_mode" class="form-select" required >
            <option value="" disabled selected><?=@$lableName;?> Mode</option>
            <option value="1">Live</option>
            <option value="2">Test</option>
          </select>
          <? 
		if(isset($post['acquirer_prod_mode']))
		{?>
          <script>$('#acquirer_prod_mode option[value="<?=prntext($post['acquirer_prod_mode'])?>"]').prop('selected','selected');</script>
          <?
		}?>
        </div>
      </div>
      <div class="col-sm-6">
        <div class=""> <span class="form-label" ><?=@$lableName;?> No.: <i class="<?=$data['fwicon']['star'];?> text-danger"></i></span>
          <input type="text" name="acquirer_id" id="acquirer_id" placeholder="Enter <?=@$lableName;?> No. for Your API" class="form-control" value="<? if(isset($post['acquirer_id'])) echo prntext($post['acquirer_id'])?>" required />
        </div>
      </div>
	  <div class="col-sm-6">
        <div class=""> <span class="form-label" >Default <?=@$lableName;?>: <i class="<?=$data['fwicon']['star'];?> text-danger"></i></span>
          <input type="text" name="default_acquirer" id="default_acquirer" placeholder="Enter Default <?=@$lableName;?> No. for Your API" class="form-control" value="<? if(isset($post['default_acquirer'])) echo prntext($post['default_acquirer'])?>" required />
        </div>
      </div>
      <div class="col-sm-6">
        <div class=""> <span class="form-label" >Channel Type : <i class="<?=$data['fwicon']['star'];?> text-danger"></i></span>
          <select name="channel_type" class="form-select" id="channel_type" onChange="channel_typef(this.value)" required >
            <option value="" >Channel Type</option>
            <?
			foreach($data['channel'] as $k3=>$v3){
				echo "<option value='{$k3}'>{$k3}. {$v3['name1']} ({$v3['name2']})</option>";
			}
			?>
          </select>
          <?
		if(isset($post['channel_type']))
		{?>
          <script>$('#channel_type option[value="<?=prntext($post['channel_type'])?>"]').prop('selected','selected');</script>
          <?
		}
		?>
        </div>
      </div>
      <div class="col-sm-6">
        <div class=""> <span class="form-label" >Connection Method : <i class="<?=$data['fwicon']['star'];?> text-danger"></i></span>
          <select name="connection_method" class="form-select" id="connection_method" required >
            <option value="" disabled selected>Connection Method</option>
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
      </div>
     
	 
      <div class="col-sm-6"> <span class="form-label" ><?=@$lableName;?> Payment Live/Prod. URL: <i class="<?=$data['fwicon']['star'];?> text-danger"></i></span>
        <textarea class="form-control w-100" name="acquirer_prod_url" id="acquirer_prod_url" rows="3" placeholder="Bank Payment Live URL" required ><? if(isset($post['acquirer_prod_url'])) echo $post['acquirer_prod_url'];?></textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label" ><?=@$lableName;?> Payment Test/Uat. URL : </span>
        <textarea class="form-control w-100" name="acquirer_uat_url" id="acquirer_uat_url" rows="3" placeholder="" ><? if(isset($post['acquirer_uat_url'])) echo $post['acquirer_uat_url'];?></textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label" ><?=@$lableName;?> Status URL : <i class="<?=$data['fwicon']['star'];?> text-danger"></i></span>
        <textarea class="form-control w-100" name="acquirer_status_url" id="acquirer_status_url" rows="3" placeholder="" required ><? if(isset($post['acquirer_status_url'])) echo $post['acquirer_status_url']?></textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label " ><?=@$lableName;?> Refund URL : </span>
        <textarea class="form-control w-100" name="acquirer_refund_url" id="acquirer_refund_url" rows="3" placeholder='{"login_live_userId":"","login_test_userId":""}' ><? if(isset($post['acquirer_refund_url'])) echo $post['acquirer_refund_url'];?></textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label w-100" ><?=@$lableName;?> Refund Policy :  <i class="<?=$data['fwicon']['star'];?> text-danger"></i></span>
        <select name="acquirer_refund_policy" id="acquirer_refund_policy" class="form-select"  required>
          <option value="" disabled selected>Bank Refund Type</option>
          <option value="Full Refund only">Full Refund only</option>
          <option value="Full & Partial Both">Full & Partial Both</option>
          <option value="Manual Processing">Manual Processing</option>
          <option value="No Refund supported">No Refund supported</option>
        </select>
        <?
		if(isset($post['acquirer_refund_policy']))
		{
		?>
        <script>$('#acquirer_refund_policy option[value="<?=($post['acquirer_refund_policy'])?>"]').prop('selected','selected');</script>
        <?
		}
		?>
      </div>
      
	  <div class="col-sm-6"> <span class="form-label " ><?=@$lableName;?> Descriptor : </span>
		 <input type="text" name="acquirer_descriptor" id="acquirer_descriptor" placeholder="Enter <?=@$lableName;?> Descriptor for Your API" class="form-control" value="<? if(isset($post['acquirer_descriptor'])) echo ($post['acquirer_descriptor'])?>"  />
      </div>
	  
	  <div class="col-sm-6"> <span class="form-label " >Auto Expired : </span>
		 <input type="text" name="trans_auto_expired" id="trans_auto_expired" placeholder="Enter Time in minutes for Auto Expired " class="form-control" value="<? if(isset($post['trans_auto_expired'])) echo ($post['trans_auto_expired'])?>"  />
      </div>
	  
	  <div class="col-sm-6"> <span class="form-label " >Auto Refund : </span>
		 <input type="text" name="trans_auto_refund" id="trans_auto_refund" placeholder="Enter Time in minutes for Auto Refund " class="form-control" value="<? if(isset($post['trans_auto_refund'])) echo ($post['trans_auto_refund'])?>"  />
      </div>
	  
      
      

      <div class="col-sm-6"> <span class="form-label " ><?=@$lableName;?> Whitelisting IP / Webhook url : 
	  
	  <?if(isset($post['acquirer_wl_ip'])&&preg_match("/(\[host\])/i",$post['acquirer_wl_ip'])){
		  $acquirer_wl_ip=str_replace('[host]',$data['Host'],$post['acquirer_wl_ip']);
		  ?>
	   <div class="" style="display:inline-block;"><i class="<?=$data['fwicon']['hand'];?>"></i> <a id="a_after_base_hard_code_url" href='<?=$acquirer_wl_ip;?>' target="_blank" ><?=$acquirer_wl_ip;?></span></a>
        </div>
	  <?}?>
	  
	  </span>
        <textarea title="If Static Billing / Whitelisting IP " class="form-control w-100" name="acquirer_wl_ip" id="acquirer_wl_ip" rows="3" placeholder=" " ><? if(isset($post['acquirer_wl_ip'])) echo $post['acquirer_wl_ip'];?></textarea>
      </div>
      <div class="col-sm-6"> <span class="form-label " ><?=@$lableName;?> Login Credentials : </span>
        <textarea class="form-control w-100" name="acquirer_login_creds" id="acquirer_login_creds" rows="3" placeholder='{"login_live_url":"","login_test_url":""}' ><? if(isset($post['acquirer_login_creds'])) echo $post['acquirer_login_creds'];?></textarea>
      </div>
      
      
      <div class="col-sm-6"> <span class="form-label " ><?=@$lableName;?> Developer API URL : </span>
        <textarea class="form-control w-100" name="acquirer_dev_url" id="acquirer_dev_url" rows="3" placeholder="" ><? if(isset($post['acquirer_dev_url'])) echo $post['acquirer_dev_url'];?></textarea>
      </div>
      
      <div class="col-sm-6"> <span class="form-label "  title="Domain for Callback/Process"><?=@$lableName;?> Whitelisting Domain: </span>
        <textarea class="form-control w-100" name="acquirer_wl_domain" id="acquirer_wl_domain" rows="3" placeholder="https://my.domain.com" ><? if(isset($post['acquirer_wl_domain'])) echo $post['acquirer_wl_domain'];?></textarea>
      </div>
	  
	   <div class="col-sm-6"> <span class="form-label " for="processing_countries" >Processing Countries: </span>
        <textarea class="form-control" name="processing_countries" id="processing_countries" rows="3" placeholder='["AF","AM","AZ","BH","BY","CF","CN","CI","CU","CG","CY","ER","GE","HT","HK","IR","IQ","KZ","KW","KG","LB","LR","LY","MD","OM","QA","RU","SA","SG","SO","LK","SD","SY","TJ","TM","AE","UA","UZ","VE","VN","ZW"]' ><? if(isset($post['processing_countries'])) echo $post['processing_countries'];?></textarea>
      </div>
	  
	  <div class="col-sm-6"> <span class="form-label " for="block_countries" >Block Countries: </span>
        <textarea class="form-control" name="block_countries" id="block_countries" rows="3" placeholder='["AO","BY","BW","BF","BI","CM","CF","CG","TD","CI","EG","GA","GM","GH","ID","IR","IQ","KE","KP","LS","LR","LY","MW","MY","ML","MR","MA","NE","NG","PS","RW","SL","SO","SD","SZ","SY","TG","UG","ZA","ZM","ZW"]' ><? if(isset($post['block_countries'])) echo $post['block_countries'];?></textarea>
      </div>
	  
     
      

      <div class="col-sm-6"> <span class="form-label " ><?=@$lableName;?> Processing Currency :   <i class="<?=$data['fwicon']['star'];?> text-danger"></i></span>
        <select name="acquirer_processing_currency"  class="form-select" id="acquirer_processing_currency"  required >
          <option value="" disabled selected><?=@$lableName;?> Processing Currency *</option>
          <? foreach ($data['AVAILABLE_CURRENCY'] as $k11) {?>
          <option value="<?=$k11?>">
          <?=$k11?>
          </option>
          <? } ?>
        </select>
        <?
			if(isset($post['acquirer_processing_currency']))
			{?>
        <script>$('#acquirer_processing_currency option[value="<?=prntext($post['acquirer_processing_currency'])?>"]').prop('selected','selected');</script>
        <?
			}?>
      </div>
      <div class="col-sm-6"> <span class="form-label " >Processing currency markup % : </span>
        <input type="text" name="processing_currency_markup" placeholder="Enter The Currency Rate" class="form-control" value="<? if(isset($post['processing_currency_markup'])) echo prntext($post['processing_currency_markup'])?>"  />
      </div>
	  
	   <div class="col-sm-6 mt-2"> <span class="form-label "  title="MOP for UPI or Card Name in comma separated values">MOP - Mode of payment [WEB]: <i class="<?=$data['fwicon']['star'];?> text-danger"></i> </span>
		<?/*?>
		 <input type="text" name="mop" id="mop" placeholder="visa,mastercard,amex,jcb,discover,diners,UPI," class="form-control" value="<? if(isset($post['mop'])) echo ($post['mop'])?>"  />
		 <?*/?>
		  <select id="mop_name_no_add" data-placeholder="Start typing the MOP " multiple class="chosen-select form-control" name="mop[]" style="clear:right;" >
            <?=($post['mop_option']);?>
          </select>
          <script>
			$(".chosen-select").chosen({
			no_results_text: "Opps, nothing found - "
			});

			<?
			if(isset($post['mop'])&&$post['mop']&&is_string($post['mop'])) 
			{
			$mop_name_ex=explode(",",$post['mop']);
				if(isset($mop_name_ex)&&$mop_name_ex){?>
					chosen_more_value_f("mop_name_no_add",[<?=('"'.implodes('", "',$mop_name_ex).'"');?>]);
			<?
				}
			}
			?>
			</script>
			<script>
				$("#mop_name_no_add_chosen").css("width", "100%");
				$("#mop_name_no_add_chosen").addClass("bg-vlight99");
				$("#mop_name_no_add_chosen").addClass("form-control");
			</script>
      </div>
	  
	  <div class="col-sm-6 mt-2"> <span class="form-label "  title="MOP for UPI or Card Name in comma separated values">MOP - Mode of payment [MOBILE]: <i class="<?=$data['fwicon']['star'];?> text-danger"></i> </span>
		  <select id="mop_mobile_name_no_add" data-placeholder="Start typing the MOP " multiple class="chosen-select form-control" name="mop_mobile[]" style="clear:right;" >
            <?=($post['mop_option']);?>
          </select>
          <script>
			$(".chosen-select").chosen({
			no_results_text: "Opps, nothing found - "
			});

			<?
			if(isset($post['mop_mobile'])&&$post['mop_mobile']&&is_string($post['mop_mobile'])) 
			{
			$mop_mobile_name_ex=explode(",",$post['mop_mobile']);
				if(isset($mop_mobile_name_ex)&&$mop_mobile_name_ex){?>
					chosen_more_value_f("mop_mobile_name_no_add",[<?=('"'.implodes('", "',$mop_mobile_name_ex).'"');?>]);
			<?
				}
			}
			?>
			</script>
			<script>
				$("#mop_mobile_name_no_add_chosen").css("width", "100%");
				$("#mop_mobile_name_no_add_chosen").addClass("bg-vlight99");
				$("#mop_mobile_name_no_add_chosen").addClass("form-control");
			</script>
      </div>
      
      
	  <div class="row border bd-blue-100 my-2 text-start py-2 vkgclr rounded">
        <div class="row btn btn-outline-light text-dark fw-bold mb-2"><?=@$lableName;?> Label Json</div>
		
		<div class="col-sm-12"> <span class="form-label" ><?=@$lableName;?> Processing Creds. : <i class="<?=$data['fwicon']['star'];?> text-danger"></i></span>
        <textarea  class="textAreaAdjust form-control w-100" onkeyup="textAreaAdjust(this)" name="acquirer_processing_creds" id="acquirer_processing_creds" row="3" placeholder="Enter Processing Json" required  ><? if(isset($post['acquirer_processing_creds'])) echo $post['acquirer_processing_creds'];?></textarea>
      </div>
	  
        <div class="col-sm-6 mt-2">
          <label for="acquirer_name" class="form-label" title="Name1"><?=@$lableName;?> Name : <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
          <input type="text" class="form-control" name="acquirer_label_json[acquirer_name]" id="acquirer_name" value="<?=(isset($post['acquirer_label_json']['acquirer_name'])&&$post['acquirer_label_json']['acquirer_name']?$post['acquirer_label_json']['acquirer_name']:"")?>" required >
        </div>
		
		<div class="col-sm-6 mt-2">
          <label for="skip_checkout_validation" class="form-label" title="Name5 for skip checkout validation">Skip Checkout Validation : </label>
          <input type="text" class="form-control" name="acquirer_label_json[skip_checkout_validation]" id="payment_option_mobile" value="<?=(isset($post['acquirer_label_json']['skip_checkout_validation'])&&$post['acquirer_label_json']['skip_checkout_validation']?$post['acquirer_label_json']['skip_checkout_validation']:"")?>" placeholder="AddressFalse CardFalse LuhnValidationFalse">
        </div>
		
	<?/*?>
	
		<div class="col-sm-6 mt-2">
          <label for="payment_option_web" class="form-label" title="Name2 for Web">Checkout Page define [web] : <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
          <input type="text" class="form-control" name="acquirer_label_json[payment_option_web]" id="payment_option_web" value="<?=(isset($post['acquirer_label_json']['payment_option_web'])&&$post['acquirer_label_json']['payment_option_web']?$post['acquirer_label_json']['payment_option_web']:"")?>" placeholder="Card Payment or eWallets or QR-Code Scan or UPI" required >
        </div>
		
       <div class="col-sm-6 mt-2">
          <label for="payment_option_mobile" class="form-label" title="Name2 for Mobile"> Checkout Page define [mobile]:</label>
          <input type="text" class="form-control" name="acquirer_label_json[payment_option_mobile]" id="payment_option_mobile" value="<?=(isset($post['acquirer_label_json']['payment_option_mobile'])&&$post['acquirer_label_json']['payment_option_mobile']?$post['acquirer_label_json']['payment_option_mobile']:"")?>" placeholder="Card Payment or Intent or UPI">
        </div>
		
	<?*/?>
		
		
		<div class="col-sm-6 mt-2">
          <label for="popup_msg_web_no_add" class="form-label" title="Name6 for Web"><?=@$lableName;?> Redirect Popup Msg [web] :</label>
		 
        <?if(!isset($data['arpm']))
		  {?>
			<input type="text" class="form-control" name="acquirer_label_json[popup_msg_web]" id="popup_msg_web_no_add" value="<?=(isset($post['acquirer_label_json']['popup_msg_web'])&&$post['acquirer_label_json']['popup_msg_web']?$post['acquirer_label_json']['popup_msg_web']:"")?>" placeholder="upiAppListForCollect upiWalletIndiaList upiaddress qrcodeadd">
		<?}else {?>
		<?
			$post['acquirer_label_json']['popup_msg_web']=str_replace(',',' ',@$post['acquirer_label_json']['popup_msg_web']);
			if(isset($post['acquirer_label_json']['popup_msg_web'])&&$post['acquirer_label_json']&&is_string($post['acquirer_label_json']['popup_msg_web'])){
				$popup_msg_web_ex=explode(" ",$post['acquirer_label_json']['popup_msg_web']);
				//print_r($popup_msg_web_ex);
			}
		?>
		  <select id="popup_msg_web_no_add" data-placeholder="<?=@$lableName;?> Redirect Popup Msg [web] " multiple class="chosen-select form-control" name="popup_msg_web[]" style="clear:right;" >
            <?
			foreach($data['arpm'] as $ke){
				echo "<option value='{$ke}'>{$ke}</option>";
			}
			
			?>
          </select>
          <script>
			$(".chosen-select").chosen({
			no_results_text: "Opps, nothing found - "
			});

			<?if(isset($popup_msg_web_ex)&&$popup_msg_web_ex){?>
				chosen_more_value_f("popup_msg_web_no_add",[<?=('"'.implodes('", "',$popup_msg_web_ex).'"');?>]);
			<?}?>
						  
			</script>
					  <script>
			$("#popup_msg_web_no_add_chosen").css("width", "100%");
			$("#popup_msg_web_no_add_chosen").addClass("bg-vlight99");
			$("#popup_msg_web_no_add_chosen").addClass("form-control");
			</script>
			<?}?>
        </div>
		
       <div class="col-sm-6 mt-2">
          <label for="popup_msg_mobile_no_add" class="form-label" title="Name6 for Mobile"><?=@$lableName;?> Redirect Popup Msg [mobile] :</label>
		  <?if(!isset($data['arpm']))
		  {?>
			<input type="text" class="form-control" name="acquirer_label_json[popup_msg_mobile]" id="popup_msg_mobile_no_add" value="<?=(isset($post['acquirer_label_json']['popup_msg_mobile'])&&$post['acquirer_label_json']['popup_msg_mobile']?$post['acquirer_label_json']['popup_msg_mobile']:"")?>" placeholder="upiAppListForIntent appIntent_submitMsg">
		  <?}else {?>
			  <?
				$post['acquirer_label_json']['popup_msg_mobile']=str_replace(',',' ',@$post['acquirer_label_json']['popup_msg_mobile']);
				if(isset($post['acquirer_label_json']['popup_msg_mobile'])&&$post['acquirer_label_json']&&is_string($post['acquirer_label_json']['popup_msg_mobile'])){
					$popup_msg_mobile_ex=explode(" ",$post['acquirer_label_json']['popup_msg_mobile']);
					//print_r($popup_msg_mobile_ex);
				}
			?>
			  <select id="popup_msg_mobile_no_add" data-placeholder="<?=@$lableName;?> Redirect Popup Msg [mobile] " multiple class="chosen-select form-control" name="popup_msg_mobile[]" style="clear:right;" >
				<?
				foreach($data['arpm'] as $ke){
					echo "<option value='{$ke}'>{$ke}</option>";
				}
				
				?>
			  </select>
			  <script>
				$(".chosen-select").chosen({
				no_results_text: "Opps, nothing found - "
				});

				<?if(isset($popup_msg_mobile_ex)&&$popup_msg_mobile_ex){?>
					chosen_more_value_f("popup_msg_mobile_no_add",[<?=('"'.implodes('", "',$popup_msg_mobile_ex).'"');?>]);
				<?}?>
							  
				</script>
						  <script>
				$("#popup_msg_mobile_no_add_chosen").css("width", "100%");
				$("#popup_msg_mobile_no_add_chosen").addClass("bg-vlight99");
				$("#popup_msg_mobile_no_add_chosen").addClass("form-control");
				</script>
			<?}?>
       </div>
		
		
		<div class="col-sm-6 mt-2">
          <label for="checkout_label_web" class="form-label" title="Label for Web">Checkout Label Name [web] : <i class="<?=$data['fwicon']['star'];?> text-danger"></i></label>
          <input type="text" class="form-control" name="acquirer_label_json[checkout_label_web]" id="checkout_label_web" value="<?=(isset($post['acquirer_label_json']['checkout_label_web'])&&$post['acquirer_label_json']['checkout_label_web']?$post['acquirer_label_json']['checkout_label_web']:"")?>" placeholder="Card or UPI Payment or Qr-Code Scan " required >
        </div>
		
       <div class="col-sm-6 mt-2">
          <label for="checkout_label_mobile" class="form-label" title="Label for Mobile">Checkout Label Name [mobile]:</label>
          <input type="text" class="form-control" name="acquirer_label_json[checkout_label_mobile]" id="checkout_label_mobile" value="<?=(isset($post['acquirer_label_json']['checkout_label_mobile'])&&$post['acquirer_label_json']['checkout_label_mobile']?$post['acquirer_label_json']['checkout_label_mobile']:"")?>" placeholder="UPI Intent or UPI Collect">
        </div>
		
		
		<div class="col-sm-6 mt-2">
          <label for="logo_web" class="form-label" title="Checkout Sub-Label Name for Web">Checkout Sub-Label Name  [web] : </label>
          <input type="text" class="form-control" name="acquirer_label_json[logo_web]" id="logo_web" value="<?=(isset($post['acquirer_label_json']['logo_web'])&&$post['acquirer_label_json']['logo_web']?$post['acquirer_label_json']['logo_web']:"")?>" placeholder="cardIcon netBanking vimPhonePeGpayPaytm qr_code indiaWallets" required >
        </div>
		
       <div class="col-sm-6 mt-2">
          <label for="logo_mobile" class="form-label" title="Checkout Sub-Label Name for Mobile">Checkout Sub-Label Name [mobile]:</label>
          <input type="text" class="form-control" name="acquirer_label_json[logo_mobile]" id="logo_mobile" value="<?=(isset($post['acquirer_label_json']['logo_mobile'])&&$post['acquirer_label_json']['logo_mobile']?$post['acquirer_label_json']['logo_mobile']:"")?>" placeholder="cardIcon netBanking vimPhonePeGpayPaytm qr_code indiaWallets">
        </div>
		
		
		
        
      </div>
	  
	  
	  
      <div class="col-sm-12"> <span class="form-label" >Tech Comments: </span>
        <textarea class="textAreaAdjust form-control  w-100" onkeyup="textAreaAdjust(this)"  name="tech_comments" row="3" placeholder="Enter Note"><? if(isset($post['tech_comments'])) echo $post['tech_comments'];?></textarea>
      </div>
      <div class="col-sm-12"> <span class="form-label"  title="Hard Code Payment URL">Payment URL</span>
        <textarea class="textAreaAdjust form-control" onKeyUp="textAreaAdjust(this)" name="acq[hard_code_url]" id="hard_code_url" placeholder="Enter Hard Code URL after Base URL " onfocusout="javascript:$('#after_base_hard_code_url').html(this.value);$('#a_after_base_hard_code_url').attr('href',$('#a_after_base_hard_code_url').text());" ><? if(isset($post['acq']['hard_code_url'])) echo $post['acq']['hard_code_url'];?></textarea>
      
      </div>
      <div id="emailHelp" class="form-text44 my-2 hide_connector"><i class="<?=$data['fwicon']['hand'];?>"></i> <a id="a_after_base_hard_code_url" href='<?=$data['Host'];?>/<? if(isset($post['acq']['hard_code_url'])) echo $post['acq']['hard_code_url'];?>' target="_blank" >
<?=$data['Host'];?>/<span id="after_base_hard_code_url"><? if(isset($post['acq']['hard_code_url'])) echo $post['acq']['hard_code_url'];?></span></a>
        </div>
      <div class="col-sm-12"> <span class="form-label"  title="Hard Code Status URL">Status URL:</span>
        <textarea class="textAreaAdjust form-control" onKeyUp="textAreaAdjust(this)" row="3" name="acq[hard_code_status_url]" id="hard_code_status_url"  placeholder="Enter Hard Code URL after Base URL " onfocusout="javascript:$('#after_base_hard_code_status_url').html(this.value);$('#a_after_base_hard_code_status_url').attr('href',$('#a_after_base_hard_code_status_url').text());" ><? if(isset($post['acq']['hard_code_status_url'])) echo $post['acq']['hard_code_status_url'];?></textarea>
       
      </div>
      <div class="my-2 hide_connector"><i class="<?=$data['fwicon']['hand'];?>"></i> <a id="a_after_base_hard_code_status_url" href='<?=$data['Host'];?>/<? if(isset($post['acq']['hard_code_status_url'])) echo $post['acq']['hard_code_status_url'];?>' target="_blank" >
<?=$data['Host'];?>/<span id="after_base_hard_code_status_url"><? if(isset($post['acq']['hard_code_status_url'])) echo $post['acq']['hard_code_status_url'];?></span></a>
</div>
      <div class="col-sm-12"> <span class="form-label"  title="Hard Code Live Status URL">Live Status URL:</span>
        <textarea class="textAreaAdjust form-control" onKeyUp="textAreaAdjust(this)" row="3" name="acq[hard_code_live_status_url]" id="hard_code_live_status_url" placeholder="Enter Hard Code URL after Base URL " onfocusout="javascript:$('#after_base_hard_code_live_status_url').html(this.value);$('#a_after_base_hard_code_live_status_url').attr('href',$('#a_after_base_hard_code_live_status_url').text());" ><? if(isset($post['acq']['hard_code_live_status_url'])) echo $post['acq']['hard_code_live_status_url'];?></textarea>
      </div>
      <div class="my-2 hide_connector"> <i class="<?=$data['fwicon']['hand'];?>"></i> <a id="a_after_base_hard_code_live_status_url" href='<?=$data['Host'];?>/<? if(isset($post['acq']['hard_code_live_status_url'])) echo $post['acq']['hard_code_live_status_url'];?>' target="_blank" >
        <?=$data['Host'];?>/<span id="after_base_hard_code_live_status_url"><? if(isset($post['acq']['hard_code_live_status_url'])) echo $post['acq']['hard_code_live_status_url'];?></span></a></div>
      <div class="col-sm-12"> <span class="form-label"  title="Hard Code Refund URL">Refund URL:</span>
        <textarea class="textAreaAdjust form-control" onKeyUp="textAreaAdjust(this)" row="3" name="acq[hard_code_refund_url]" id=hard_code_refund_url placeholder="Enter Hard Code URL after Base URL " onfocusout="javascript:$('#after_base_hard_code_refund_url').html(this.value);$('#a_after_base_hard_code_refund_url').attr('href',$('#a_after_base_hard_code_refund_url').text());" ><? if(isset($post['acq']['hard_code_refund_url'])) echo $post['acq']['hard_code_refund_url'];?></textarea>
      </div>
      <div class="my-2 hide_connector"> <i class="<?=$data['fwicon']['hand'];?>"></i> <a id="a_after_base_hard_code_refund_url" href='<?=$data['Host'];?>/<? if(isset($post['acq']['hard_code_refund_url'])) echo $post['acq']['hard_code_refund_url'];?>' target="_blank" >
<?=$data['Host'];?>/<span id="after_base_hard_code_refund_url"><? if(isset($post['acq']['hard_code_refund_url'])) echo $post['acq']['hard_code_refund_url'];?></span></a>
         </div>
      <div class="row border bd-yellow-100 my-2 text-start py-2 vkgclr rounded hide_connector" >
        <div class="row btn btn-outline-light fw-bold text-dark mb-2">Additional Bank Response</div>
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label">Maximum Continuously Fail Transaction Allowed:</label>
          <input type="number" class="form-control" name="inactive_failed_count" value="<? if(isset($post['inactive_failed_count'])) echo $post['inactive_failed_count'];?>" placeholder="50" />
        </div>
        <?
$post['inactive_start_time']=isset($post['inactive_start_time'])&&$post['inactive_start_time']?$post['inactive_start_time']:'';
$post['inactive_end_time']=isset($post['inactive_end_time'])&&$post['inactive_end_time']?$post['inactive_end_time']:'';
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
          <label for="notification_email" class="form-label">Email Ids:</label>
          <textarea class="textAreaAdjust form-control" onkeyup="textAreaAdjust(this)" row="3" id="notification_email" name="notification_email" placeholder='Email1, Email2, Email3'><? if(isset($post['notification_email'])) echo $post['notification_email'];?></textarea>
        </div>
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label"></label>
        </div>
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label">B. Success Response:</label>
          <textarea class="textAreaAdjust form-control" onkeyup="textAreaAdjust(this)" row="3" name="acq[br_success]"  placeholder='value1,value2,value3' ><? if(isset($post['acq']['br_success'])) echo $post['acq']['br_success'];?></textarea>
        </div>
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label">B. Failed Response:</label>
          <textarea class="textAreaAdjust form-control" onkeyup="textAreaAdjust(this)" rows="1" name="acq[br_failed]"  placeholder='value1,value2,value3' ><? if(isset($post['acq']['br_failed'])) echo $post['acq']['br_failed'];?></textarea>
        </div>
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label">B. Pending Response:</label>
          <textarea class="textAreaAdjust form-control" onkeyup="textAreaAdjust(this)" rows="1" name="acq[br_pending]"  placeholder='value1,value2,value3' ><? if(isset($post['acq']['br_pending'])) echo $post['acq']['br_pending'];?></textarea>
        </div>
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label">Bank Status Path:</label>
          <textarea class="textAreaAdjust form-control" onkeyup="textAreaAdjust(this)" rows="1" name="acq[br_status_path]"  placeholder='api/pay22/processed' ><? if(isset($post['acq']['br_status_path'])) echo $post['acq']['br_status_path'];?></textarea>
        </div>
      </div>
      <div class="row border bd-blue-100 my-2 text-start py-2 vkgclr rounded hide_connector">
        <div class="row btn btn-outline-light text-dark fw-bold mb-2">Bank Transaction</div>
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label">Min Trxn Limit: <font class="acct_curr">(
          <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
          )</font></label>
          <input type="text" class="form-control" name="acq[min_limit]" id="min_limit" size="20" value="<?=(isset($post['acq']['min_limit'])&&$post['acq']['min_limit']?$post['acq']['min_limit']:"1")?>">
        </div>
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label">Max Trxn Limit: <font class="acct_curr">(
          <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
          )</font></label>
          <input type="text" class="form-control" name="acq[max_limit]" id="max_limit" size="30" value="<?=(isset($post['acq']['max_limit'])&&$post['acq']['max_limit']?$post['acq']['max_limit']:"500");?>">
        </div>
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label">Scrubbed Period:</label>
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
          <label for="<?=@$lableName;?> ID" class="form-label">Trxn Count:</label>
          <input type="text"  class="form-control" name="acq[trans_count]" id="trans_count" size="20" value="<?=(isset($post['acq']['trans_count'])&&$post['acq']['trans_count']?$post['acq']['trans_count']:"7");?>">
        </div>
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label">Min. Success Count:</label>
          <input class="form-control" type="text" name="acq[tr_scrub_success_count]" id="tr_scrub_success_count" size="20" value="<?=(isset($post['acq']['tr_scrub_success_count'])&&$post['acq']['tr_scrub_success_count']?$post['acq']['tr_scrub_success_count']:'2');?>">
        </div>
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label">Min. Failed Count:</label>
          <input type="text" class="form-control" name="acq[tr_scrub_failed_count]" id="tr_scrub_failed_count" size="20" value="<?=(isset($post['acq']['tr_scrub_failed_count'])&&$post['acq']['tr_scrub_failed_count']?$post['acq']['tr_scrub_failed_count']:'5')?>">
        </div>
        <!--<span class="hide1 noneClick1 row">-->
<?/*?>
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label">Setup Fee (USD):</label>
          <input type="text" class="form-control" name="acq[setup_fee]" id="setup_fee" size="20" value="<? if(isset($post['acq']['setup_fee'])) echo $post['acq']['setup_fee']?>">
        </div>
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label">Setup Fee  Collected:</label>
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
      <div class="row border bd-red-100 my-2 text-start py-2 vkg text-dark rounded hide_connector_1">
        <div class="row btn btn-outline-info text-dark fw-bold mb-2">Process Transaction</div>
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label">Processing Mode:
          <?
			if(isset($post['acquirer_name']))
			{
			?>
          <script>$('#acquirer_name option[value="<?=$post['acquirer_name']?>"]').prop('selected','selected');</script>
          <?
			}?>
          </label>
          <select name="acq[acquirer_processing_mode]" class="form-select" id="acquirer_processing_mode">
            <option value="" disabled="" >Processing Mode</option>
            <option value="1">Live</option>
            <option value="2" selected="">Test</option>
            <option value="3">Inactive</option>
          </select>
          <?
			if(isset($post['acq']['acquirer_processing_mode']))
			{
			?>
          <script>$('#acquirer_processing_mode option[value="<?=$post['acq']['acquirer_processing_mode']?>"]').prop('selected','selected');</script>
          <?
			}?>
        </div>
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label">Default Currency:</label>
          <select class="form-select hide1" name="acq[acquirer_processing_currency]" id="acquirer_processing_currency2" onChange="procurrency(this)" >
            <option value="" disabled="" selected="">Processing Currency</option>
            <?foreach ($data['AVAILABLE_CURRENCY'] as $k11) {?>
            <option value="<?=$k11?>">
            <?=$k11?>
            </option>
            <?}?>
          </select>
          <?
			if(isset($post['acq']['acquirer_processing_currency']))
			{
				$ac_processing_currency=get_currency($post['acq']['acquirer_processing_currency'],1);
			?>
          <script>
				$('#acquirer_processing_currency2').find('option:contains("<?=$ac_processing_currency;?>")', this).prop('selected', 'selected');
				$('#acquirer_processing_currency2').find('option:contains("<?=$ac_processing_currency;?>")', this).attr('selected', 'selected');
			</script>
          <?
			}
			?>
        </div>
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label">
          <? if(isset($acc_arr[2])) echo $acc_arr[2];?>
          Discount Rate(%):</label>
          <? if(isset($acc_arr[2])) echo $acc_arr[2];?>
          <input type="text" class="form-control" name="acq[mdr_rate]" id="mdr_rate" size="20" placeholder="13%" value="<? if(isset($post['acq']['mdr_rate'])) echo $post['acq']['mdr_rate']?>">
        </div>
        <? if(($data['con_name']=='clk')||(isset($data['domain_server']['as']['gst_fee'])&&$data['domain_server']['as']['gst_fee'])){ ?>
        <div class="col-sm-6">
          <label class="form-label" for="gst_rate" >GST Rate(%):<span class="mand">*</span></label>
          <input class="form-control" type="text" name="acq[gst_rate]" id="gst_rate" size=20 placeholder="Ex. 18" value="<?=((isset($post['acq']['gst_rate'])&&$post['acq']['gst_rate'])?$post['acq']['gst_rate']:((isset($data['domain_server']['as']['gst_fee'])&&$data['domain_server']['as']['gst_fee'])?$data['domain_server']['as']['gst_fee']:"18"));?>">
        </div>
        <? } ?>
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label">Settlement Period:</label>
          <select class="form-select" name="acq[settelement_delay]" id="settelement_delay">
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
			if(isset($post['acq']['settelement_delay']))
			{?>
          <script>$('#settelement_delay option[value="<?=$post['acq']['settelement_delay']?>"]').prop('selected','selected');</script>
          <?
			}?>
        </div>
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label">
          <? if(isset($acc_arr[2])) echo $acc_arr[2];?>
          Txn. Fee (Success): </label>
          <input type="text" class="form-control" name="acq[txn_fee_success]" id="txn_fee_success" size="20" placeholder="4.0" value="<? if(isset($post['acq']['txn_fee_success'])) echo $post['acq']['txn_fee_success']?>">
        </div>
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label">
          <? if(isset($acc_arr[2])) echo $acc_arr[2];?>
          Txn. Fee (Failed): </label>
          <input type="text" name="acq[txn_fee_failed]" id="txn_fee_failed" size="20"  class="form-control" value="<? if(isset($post['acq']['txn_fee_failed'])) echo $post['acq']['txn_fee_failed']?>">
        </div>
        <div class="col-sm-6">
<label for="<?=@$lableName;?> ID" class="form-label"><?=@$lableName;?> Display Order: </label>
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
          <select class='slc_color form-select' name="acq[acquirer_display_order]" id="acquirer_display_order" title="Rolling Period"  >
            <option title="" value="">Select Display Order</option>
            <?
				$sum = 0;
				for($f = 1; $f <= 290; $f++){ 
					//unset($data['subadmin'][$f]['id']);$sum = $sum + $f;
					if(isset($_SESSION['shorting_ar'])&&(in_array((int)$f, $_SESSION['shorting_ar'], false))){?>
            <option title="<?=($post['acq']['acquirer_display_order']==$f?"Current":"Added")?> in <?=array_search($f,$_SESSION['shorting_ar']);?> <?=@$lableName;?>" value="<?=$f;?>" <?=($post['acq']['acquirer_display_order']==$f?"":" disabled='disabled'")?> >
            <?=$f;?>
            :
            <?=($post['acq']['acquirer_display_order']==$f?"Current":"Added")?>
            in
            <?=array_search($f,$_SESSION['shorting_ar']);?>
            <?=@$lableName;?> </option>
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
				if(isset($post['acq']['acquirer_display_order']))
				{
				?>
          <script>$('#acquirer_display_order option[value="<?=$post['acq']['acquirer_display_order']?>"]').prop('selected','selected');$('#acquirer_display_order option[value="<?=$post['acq']['acquirer_display_order']?>"]').attr('selected','selected');</script>
          <?
				}?>
        </div>
        <div class="col-sm-6 row px-0">
          <label for="<?=@$lableName;?> ID col-sm-4" class="form-label">Rolling Reserve: </label>
          <div class="col-sm-6 mb-1">
            <input type="text" class="form-control float-start" style="width: calc(100% - 50px);" name="acq[reserve_rate]" id="reserve_rate" placeholder="10%" value="<? if(isset($post['acq']['reserve_rate'])) echo $post['acq']['reserve_rate']?>">
            <span class="float-start" style="width:50px;" >&nbsp;% for</span></div>
          <div class="col-sm-6 mb-1">
            <select name="acq[reserve_delay]" id="reserve_delay" class="form-select float-start" title="Reserve Delay" style="width: calc(100% - 50px);">
              <option value="" disabled selected>Rolling Reserve</option>
			  <option value="0.00">0</option>
              <option value="180">180</option>
              <option value="90">90</option>
              <option value="120">120</option>
              <option value="210">210</option>
              <option value="270">270</option>
              <option value="360">360</option>
            </select>
            <span class="float-start" style="width:50px;" >&nbsp;Days</span>
            <?
				if(isset($post['acq']['reserve_delay']))
				{?>
            <script>$('#reserve_delay option[value="<?=$post['acq']['reserve_delay']?>"]').prop('selected','selected');</script>
            <?
				}?>
          </div>
        </div>
        <div class="col-sm-6 hide">
          <label for="<?=@$lableName;?> ID" class="form-label">Min. Settlement Amt.:<font class="acct_curr hide">(
          <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
          )</font></label>
          <input type="text" class="form-control"  style="display:none"; name="acq[settled_amt]" id="settled_amt" size="20" value="<? if(isset($post['acq']['settled_amt'])) echo $post['acq']['settled_amt']?>"></div>
      </div>
      <div class="row border bd-gray-100 my-2 text-start py-2 border text-dark rounded hide_connector">
        <h4 class="row btn btn-outline-light text-dark fw-bold mb-2 text-dark">Charge Back</h4>
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label">CB Fee Tier 1: <font class="acct_curr">(
          <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
          )</font></label>
          <input type="text" class="form-control" name="acq[charge_back_fee_1]" id="charge_back_fee_1" value="<? if(isset($post['acq']['charge_back_fee_1'])) echo $post['acq']['charge_back_fee_1']?>">
        </div>
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label">CB Fee Tier 2:</label>
          <input type="text" class="form-control" name="acq[charge_back_fee_2]" id="charge_back_fee_2"value="<? if(isset($post['acq']['charge_back_fee_2'])) echo $post['acq']['charge_back_fee_2']?>">
        </div>
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label">CB Fee Tier 3: <font class="acct_curr">(
          <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
          )</font></label>
          <input type="text" class="form-control" name="acq[charge_back_fee_3]" id="charge_back_fee_3" value="<? if(isset($post['acq']['charge_back_fee_3'])) echo $post['acq']['charge_back_fee_3']?>">
        </div>
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label">CBK1:</label>
          <input type="text" class="form-control" name="acq[cbk1]" id="cbk1" value="<? if(isset($post['acq']['cbk1'])) echo $post['acq']['cbk1']?>">
        </div>
        <div class="col-sm-6 hide">
          <label for="<?=@$lableName;?> ID" class="form-label">Monthly Maintenance Fee: <font class="acct_curr">(
          <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
          )</font></label>
          <input type="text" class="form-control" name="acq[monthly_fee]" id="monthly_fee"  value="<? if(isset($post['acq']['monthly_fee'])) echo $post['acq']['monthly_fee']?>">
        </div>
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label">Refund Fee: <font class="acct_curr">(
          <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
          )</font></label>
          <input type="text"  class="form-control" name="acq[refund_fee]" id="refund_fee" value="<? if(isset($post['acq']['refund_fee'])) echo $post['acq']['refund_fee']?>">
        </div>
        <div class="col-sm-6 hide">
          <label for="<?=@$lableName;?> ID" class="form-label">Settlement Wire Fee: <font class="acct_curr">(
          <? if(isset($pro_cur)) echo '('.$pro_cur.')';?>
          )</font></label>
          <input type="text" style="display:none;" class="form-control" name="acq[return_wire_fee]" id="return_wire_fee" value="<? if(isset($post['acq']['return_wire_fee'])) echo $post['acq']['return_wire_fee']?>">
        </div>
<?/*?>		
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label">Settlement Report View:</label>
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
      <div class="row border bd-green-100 my-2 me-2 text-start py-2 px-2 border text-dark rounded">
        <div class="row btn btn-outline-light text-dark fw-bold mb-2 ">Other Details</div>
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label" title="aPj"><?=@$lableName;?> Processing Json:</label>
          <textarea class="textAreaAdjust form-control" onKeyUp="textAreaAdjust(this)" name="acq[acquirer_processing_json]" id="acquirer_processing_json"><? if(isset($post['acq']['acquirer_processing_json'])) echo $post['acq']['acquirer_processing_json'];?></textarea>
        </div>
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label">Bank Salt:</label>
          <textarea class="textAreaAdjust form-control" onKeyUp="textAreaAdjust(this)" name="acq[bank_salt]" id="acquirer_processing_json" ><? if(isset($post['acq']['bank_salt'])) echo $post['acq']['bank_salt'];?></textarea>
        </div>
        
        <div class="col-sm-6">
          <label for="<?=@$lableName;?> ID" class="form-label">Merchant Preferences:</label>
          <input type="checkbox" name="acq[notification_to_005]" id='notification_to5' class='checkbox_d form-check-input' value='005'<?php if(isset($post['acq']['notification_to_005'])&&strpos($post['acq']['notification_to_005'],"005")!==false){echo "checked='checked'";}?>>
          Encrypt Customer Email </div>
      </div>
    </div>
    <div class="my-2 text-center row p-0">
      <div class="col-sm-12 my-2 remove-link-css">
        <button formnovalidate type="submit" name="send" value="CONTINUE"  class="btn btn-icon btn-primary"><i class="<?=$data['fwicon']['circle-plus'];?>"></i> Submit</button>
        <a href="<?=$data['Admins']?>/acquirer<?=$data['ex']?>" class="btn btn-icon btn-primary"><i class="<?=$data['fwicon']['back'];?>"></i> Back</a> </div>
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
