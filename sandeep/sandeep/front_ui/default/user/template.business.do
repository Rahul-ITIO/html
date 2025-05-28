<? if(isset($data['ScriptLoaded'])){ 

if(isset($post['is_admin'])&&($post['is_admin'])&&isset($_GET)){ 
	//$admin_subquery=http_build_query($_GET);
	$admin_subquery="admin=1&hideAllMenu=1"; // check user is admin
  } else{
	  $admin_subquery='';
  }
$post['gid']=isset($post['gid'])&&$post['gid']?$post['gid']:'';
$data['clkStore']=0;
?>

<style>
@media(max-width: 576px) {
.b-heading .col-sm-3{ width: 33.33% !important;}
.b-heading .col-sm-6{ width: 33.33% !important;}
}
@media(max-width: 400px) {
.b-heading .col-sm-3{ width: 50% !important;}
.b-heading .col-sm-6{ width: 100% !important;}
}




</style>

<div id="zink_id" class="container border my-2 bg-primary rounded" >
  <?php if((!isset($_GET['action']) || $_GET['action']!='update') and (!isset($post['step']) || $post['step']!="2")){ ?>
  <div class="row vkg row clearfix_ice">
    <div class="col-sm-12 py-2">
      <h4 class="float-start"><i class="<?=$data['fwicon']['website'];?>"></i> My <?=$data['MYWEBSITE']?></h4>
      <? if(!isset($_GET['admin'])) { ?>
      <div class="float-end"> <a href="<?=$data['USER_FOLDER'];?>/new_<?=($data['PageFileName']);?><?=$data['ex']?>"  class="btn btn-primary btn-sm" title="Add A New <?=($data['PageName']);?>"><i class="<?=$data['fwicon']['circle-plus'];?>"></i></a> </div>
      <? } ?>
    </div>
  </div>
  <? } ?>
  <form method="post" name="data">
    <input type="hidden" name="step" value="<?=$post['step']?>">
    <? if($post['step']==1){ ?>
    <? if(isset($_SESSION['query_status'])&&$_SESSION['query_status']){ ?>
    <div class="container mt-2 px-0">
      <div class="alert alert-success alert-dismissible fade show" role="alert"> <strong>Success!</strong>
        <?=$_SESSION['query_status']?>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
    </div>
    <? unset($_SESSION["query_status"]);} ?>
    
    <div class="table-responsive-sm mb-2 ">
      <table id="display-large-screen" class="table table-hover bg-primary text-white">
        <? if(count($post['Terminals'])!=0){ ?>
        <thead class="bg-dark-subtleX">
          <tr >
            <th scope="col">#</th>
            <th scope="col">Business&nbsp;Name</th>
            <th scope="col">Business&nbsp;URL</th>
            <th scope="col">TerNO</th>
            <th scope="col">Public&nbsp;Key</th>
            <th scope="col">Status</th>
            <th scope="col">Sold</th>
            <th scope="col">&nbsp;</th>
          </tr>
        </thead>
        <? }else{ ?>
        <thead>
          <tr>
            <th scope="col" colspan="8"> <div class="my-2 ms-2 fs-5 text-start">Add your <?=$data['MYWEBSITE']?> to receive payments </div>
                <div class="text-start my-2 ms-2" style="max-width:400px !important;"> you can create new <?=$data['MYWEBSITE']?>, manage added <?=$data['MYWEBSITE']?></div>
              <? if(!isset($_GET['admin'])) { ?>
                <div class="float-start"> <a href="<?=$data['USER_FOLDER'];?>/new_<?=($data['PageFileName']);?><?=$data['ex']?>"  class="btn btn-primary my-2 ms-2 float-start" title="Add A New <?=($data['PageName']);?>"><i class="<?=$data['fwicon']['circle-plus'];?>"></i> Add A New
                  <?=($data['PageName']);?>
                </a> </div>
              <? } ?>
            </th>
          </tr>
        </thead>
        <? } ?>
        <tbody>
          <?  $idx=1;$k;foreach($post['Terminals'] as $value){ ?>
          <tr>
            <td>
			<a data-bs-toggle="modal" data-count="<?=prntext($value['id'])?>" class="tr_open_on_modal text-decoration-none" data-bs-target="#myModal"><i class="<?=$data['fwicon']['display'];?> text-link" title="View details"></i></a>
			
			
			</td>
            <td><?=prntext($value['ter_name'])?></td>
            <td><a href="<?=$value['bussiness_url'];?>" class="text-break url_small text-white" target="_blank" title="<?=$value['bussiness_url'];?>" data-bs-toggle="tooltip" data-bs-placement="bottom"><span class="d-none d-sm-block"><?=$value['bussiness_url'];?></span><span class="d-block d-sm-none"><i class="fa-solid fa-link"></i></span></a></td>
            <td><span class="badge rounded-pill bg-primary text-white"><?=prntext($value['id'])?></span></td>
            <td class="text-break"><span class="hide-999 float-start"><?=($value['public_key'])?></span>
			<? if($value['public_key']){ ?>
			<i class="<?=$data['fwicon']['copy'];?> float-start ms-2 mt-1" title="Copy Public Key" data-value='<?=($value['public_key'])?>' onclick="copytext_f(this,'Public Key for TerNO - <?=($value['id'])?> ')"></i>
			<? } ?>
			</td>
            <td><? if($value['active']==1){
		$icon="<span title='Verified'><i class='".$data['fwicon']['check-circle']." text-success'></i></span>";
		}elseif($value['active']==3){
		$icon="<span title='Inactive'><i class='".$data['fwicon']['delete']."'></i></i></span>";
		}elseif($value['active']==4){
		$icon="<a title='Under review'><i class='".$data['fwicon']['eye-solid']."'></i> </a>";
		} elseif($value['active']==5){
		$icon="<span title='Awaiting terminal'><i class='".$data['fwicon']['clock']."'></i></span>";
		}elseif($value['active']==6){
		$icon="<span title='Terminated'><i class='".$data['fwicon']['ban']."'></i></span>";
		}else{
		$icon="<span title='Not define yet'><i class='".$data['fwicon']['circle-cross']."'></i></span>";
		} ?>
                <?=$icon;?>
                <script>
		  $('#store_status_<?=$k;?> option[value="<?=$value['active']?>"]').prop('disabled','true');
		  $('#store_status_<?=$k;?> option[value="<?=$value['active']?>"]').removeAttr("disabled");
		  $('#store_status_<?=$k;?> option[value="<?=$value['active']?>"]').prop('selected','selected');</script>
            </td>
            <td><a class="restartfa" onclick="ajaxf1(this,'<?=$data['USER_FOLDER']?>/<?=$data['PageFileName'];?><?=$data['ex'];?>?action=transcount&id=<?=$value['id']?>','#tracount_<?=$value['id']?>')"  title="Click to View"><i class="<?=$data['fwicon']['refund'];?> text-link"></i></a>
                <div id="tracount_<?=$value['id']?>"></div></td>
            <td align="center"><div class="btn-group dropstart short-menu-auto-main"> <a data-bs-toggle="dropdown" aria-expanded="false" title="Action"><i class="<?=$data['fwicon']['action'];?> text-link"></i></a>
                    <ul class="dropdown-menu dropdown-menu-icon pull-right" >
                      <li> <a class="dropdown-item " href="<?=$data['USER_FOLDER']?>/<?=($data['PageFileName']);?><?=$data['ex']?>?id=<?=$value['id']?>&action=update" title="Edit"><i class="<?=$data['fwicon']['edit'];?> text-success fa-fw float-start"></i> <span class="action_menu">Edit</span></a> </li>
                      <li> <a class="dropdown-item " href="<?=$data['USER_FOLDER']?>/<?=($data['PageFileName']);?><?=$data['ex']?>?id=<?=$value['id']?>&action=delete" onclick="return confirm('Do you want to delete the <?=$data['MYWEBSITE']?>?');" title="Delete" ><i class="<?=$data['fwicon']['delete'];?> text-danger fa-fw float-start"></i> <span class="action_menu">Delete</span></a></a> </li>
                      <? if($data['clkStore']==1){ ?>
                      <li> <a class="dropdown-item " href="<?=$data['USER_FOLDER']?>/requests<?=$data['ex']?>?wid=<?=$value['id']?>&type=<?=$value['public_key']?>&action=addrequests" title="Generate Code" ><i class="<?=$data['fwicon']['book-reader'];?> fa-fw float-start text-link"></i> <span class="action_menu">Generate Code</span></a></li>
                      <? }else{ ?>
                      <li> <a class="dropdown-item " href="<?=$data['USER_FOLDER']?>/generate_code<?=$data['ex']?>?id=<?=$value['id']?>&action=business" title="Generate Code"><i class="<?=$data['fwicon']['code'];?> fa-fw float-start text-link"></i> <span class="action_menu">Generate Code</span></a></li>
                      <li> <a class="dropdown-item " href="<?=$data['USER_FOLDER']?>/<?=$data['MYWEBSITEURL']?><?=$data['ex']?>?id=<?=$value['id']?>&action=re_generate_public_key&type=0&page=0" onclick="return confirm('Do you want to re-generate Api Public Key? <?='\n';?> Regenerating a new Public Key may result in losing access to the previous Public Key');"><i class="<?=$data['fwicon']['arrow-rotate-right'];?> text-warning fa-fw float-start" title="Are you sure you want to Re-generate Public Key"></i> <span class="action_menu">Re-generate</span></a></li>
                      <? } ?>
                    </ul>
            </div></td>
          </tr>
		  
		  
		  <tr class="hide">
          <td colspan="8">
	<div class="next_tr_<?=prntext($value['id'])?>  hide row">
	<div class="mboxtitle hide"><?=($data['PageName']);?> Detail : <?=$value['id']?> - <?=prntext($value['ter_name'])?></div>
	<div class="col-sm-12 border rounded mb-2 mboxcss">
	     
			    <div class="row m-2">
				<div class="col-sm-3"><?=($data['PageName']);?> ID</div>
				<div class="col-sm-9">: <?=$value['id']?></div>
			    </div>
			

                <? if(isset($value['active'])&&$value['active']){ ?>
                <div class="row m-2">
				<div class="col-sm-3"><?=($data['PageName']);?> Status </div>
				<div class="col-sm-9">: <?=$data['store_status'][$value['active']]['title'];?></div>
                </div>
                <? } ?>
		
                <? if(isset($value['ter_name'])&&$value['ter_name']){ ?>
                <div class="row m-2">
				<div class="col-sm-3"><?=($data['PageName']);?> Name</div>
				<div class="col-sm-9 ">: <?=prntext($value['ter_name'])?></div>
				</div>
                <? } ?>
		
		
                <? if(isset($value['public_key'])&&$value['public_key']){ ?>
				<div class="row m-2">
				<div class="col-sm-3">Public Key</div>
				<div class="col-sm-9">: <?=substr($value['public_key'],0,10);?> ****************</div>
				</div>
		        <? } ?>
				
				<? if(isset($value['bussiness_url'])&&$value['bussiness_url']){ ?>
        <div class="row m-2">
				<div class="col-sm-3">Business URL</div>
				<div class="col-sm-9">: <?=$value['bussiness_url']?>
          </div>
        </div>
        <? } ?>
        <? if(($value['deleted_bussiness_url'])&&(isset($post['is_admin']))&&($post['is_admin'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['deleted_business_url'])&&$_SESSION['deleted_business_url']==1))){ ?>
        <div class="row m-2">
				<div class="col-sm-3">Updated Business URL</div>
				<div class="col-sm-9">: <?=$value['deleted_bussiness_url']?></div>
        </div>
        <? } ?>
        <? if(isset($value['transaction_currency'])&&$value['transaction_currency']){ ?>
        <div class="row m-2">
				<div class="col-sm-3">Transaction Currency</div>
				<div class="col-sm-9">: <?=$value['transaction_currency']?></div>
          </div>
        <? } ?>
        <? if(isset($value['business_nature'])&&$value['business_nature']){ ?>
        <div class="row m-2">
				<div class="col-sm-3">Business Nature</div>
				<div class="col-sm-9">: <?=$value['business_nature']?></div>
          </div>
        <? } ?>
        
       
        <? if(isset($value['mer_trans_alert_email'])&&$value['mer_trans_alert_email']){ ?>
        <div class="row m-2">
				<div class="col-sm-3">T.Notification Email</div>
				<div class="col-sm-9">: <?=encrypts_decrypts_emails($value['mer_trans_alert_email'],2);?>
          </div>
        </div>
        <? } ?>
        <? if(isset($value['dba_brand_name'])&&$value['dba_brand_name']){ ?>
        <div class="row m-2">
				<div class="col-sm-3">DBA/Brand Name</div>
				<div class="col-sm-9">: <?=$value['dba_brand_name']?>
          </div>
        </div>
        <? } ?>
        <? if(isset($value['customer_service_no'])&&$value['customer_service_no']){ ?>
        <div class="row m-2">
				<div class="col-sm-3">Customer Service No.</div>
				<div class="col-sm-9">: <?=$value['customer_service_no']?>
          </div>
        </div>
        <? } ?>
        <? if(isset($value['customer_service_email'])&&$value['customer_service_email']){ ?>
        <div class="row m-2">
				<div class="col-sm-3">Customer Service Email</div>
				<div class="col-sm-9">: <?=encrypts_decrypts_emails($value['customer_service_email'],2)?>
          </div>
        </div>
        <? } ?>
        <? if(isset($value['merchant_term_condition_url'])&&$value['merchant_term_condition_url']){ ?>
        <div class="row m-2">
				<div class="col-sm-3">T & C</div>
				<div class="col-sm-9">: <?=$value['merchant_term_condition_url']?>
          </div>
        </div>
        <? } ?>
        <? if(isset($value['merchant_refund_policy_url'])&&$value['merchant_refund_policy_url']){ ?>
        <div class="row m-2">
				<div class="col-sm-3">URL of Refund Policy</div>
				<div class="col-sm-9">: <?=$value['merchant_refund_policy_url']?>
          </div>
        </div>
        <? } ?>
        <? if(isset($value['merchant_privacy_policy_url'])&&$value['merchant_privacy_policy_url']){ ?>
        <div class="row m-2">
				<div class="col-sm-3">URL of Privacy Policy</div>
				<div class="col-sm-9">: <?=$value['merchant_privacy_policy_url']?>
          </div>
        </div>
        <? } ?>
        <? if(isset($value['merchant_contact_us_url'])&&$value['merchant_contact_us_url']){ ?>
        <div class="row m-2">
				<div class="col-sm-3">URL of Contact US</div>
				<div class="col-sm-9">: <?=$value['merchant_contact_us_url']?>
          </div>
        </div>
        <? } ?>
        <? if(isset($value['merchant_logo_url'])&&$value['merchant_logo_url']){ ?>
        <div class="row m-2">
				<div class="col-sm-3">URL of Logo</div>
				<div class="col-sm-9">: <?=$value['merchant_logo_url']?>
          </div>
        </div>
        <? } ?>
        <? if(isset($value['return_url'])&&$value['return_url']){ ?>
        <div class="row m-2">
				<div class="col-sm-3">Return Url</div>
				<div class="col-sm-9">: <?=$value['return_url']?>
          </div>
        </div>
        <? } ?>
        <? if(isset($value['webhook_url'])&&$value['webhook_url']){ ?>
        <div class="row m-2">
				<div class="col-sm-3">Webhook Url</div>
				<div class="col-sm-9">: <?=$value['webhook_url']?>
          </div>
        </div>
        <? } ?>
        <? if(isset($value['business_description'])&&$value['business_description']){ ?>
        <div class="row m-2">
				<div class="col-sm-3">Business Description:</div>
				<div class="col-sm-9">: <?=prntext($value['business_description'])?>
          </div>
        </div>
        <? } ?>
        
		
		 <? if(isset($value['tarns_alert_email'])&&$value['tarns_alert_email']){ ?>
        <div class="row m-2">
          <div class="col-sm-3">Notification  Alert :</div>
		  <div class="col-sm-9">:
            <? if(is_array($value['tarns_alert_email'])){$tarns_alert_email=implode(",",$value['tarns_alert_email']);}else{$tarns_alert_email=$value['tarns_alert_email'];} ?>
            <?php 
			if($tarns_alert_email&&strpos($tarns_alert_email,"001")!==false){echo "Notification to Merchant on Approved, ";}
			if($tarns_alert_email&&strpos($tarns_alert_email,"004")!==false){echo "Notification to Merchant on Declined, ";}
			if($tarns_alert_email&&strpos($tarns_alert_email,"002")!==false){echo "Notification to Customer, ";}
			if($tarns_alert_email&&strpos($tarns_alert_email,"011")!==false){echo "Notify to Merchant on Withdraw, ";}
			if($tarns_alert_email&&strpos($tarns_alert_email,"012")!==false){echo "Notify to Merchant on Chargeback, ";}
			if($tarns_alert_email&&strpos($tarns_alert_email,"013")!==false){echo "Notify to Merchant on Refunded";}
			
		  ?>
          </div>
        </div>
        <? } ?>
		
		</div>
			 
      </div>
		  </td>
        </tr>
		
          <? $idx++; } ?>
        </tbody>
      </table>
    </a> </div>
    <? }elseif($post['step']==2){ ?>
    <? if(isset($post['gid'])&&$post['gid']){$titleLabel="Update";?>
    <input type="hidden" name="gid" value="<?=$post['gid']?>">
    <? }else{
	  $post['active']=0;
	  $titleLabel="Add A New";
  } ?>
    <? $ep=isset($ep)&&$ep?$ep:'';
  
  if($post['gid']&&$_SESSION['store_active']==1){$ep="disabled='disabled'";} ?>
    <? if((isset($data['Error'])&& $data['Error'])){ ?>
    <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error!</strong>
      <?=prntext($data['Error'])?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <? } ?>
    <div class="vkg"  >
      <? if(isset($post['gid'])&&$post['gid']){?>
      <h4 class="my-2"><i class="<?=$data['fwicon']['website'];?>"></i> Edit <?=$data['MYWEBSITE']?> :
        <?=prntext($post['ter_name'])?>
      </h4>
      <div class="row my-2 mx-0 px-2 border bg-primary text-white rounded" >
        <div class="col-sm-2 my-2"><strong>
          <?=($data['PageName']);?>
          TerNO ::
          <?=$post['gid']?>
          </strong></div>
        <div class="col-sm-2 my-2" ><strong>Status ::
          <?=$data['store_status'][$post['active']]['title'];?>
          </strong></div>
        <div class="col-sm-8 text-end  my-2">
          <div>
		  
             <a class="btn btn-icon btn-primary btn-sm text-end float-end" ><i class="<?=$data['fwicon']['copy'];?>" title="Copy Private Key" data-value='<?=$post['public_key'];?>' onclick="copytext_f(this,'Public Key for TerNO : <?=$post['gid']?>')"></i></a>
			 
             <a onClick="ajaxf1(this,'<?=$data['USER_FOLDER'];?>/<?=($data['PageFileName']);?><?=$data['ex']?>?bid=<? if(isset($post['bid'])) echo $post['bid'];?>&id=<?=$post['gid']?>&action=generate_private_key&ajax=1','#generate_private_key2')" class="btn btn-icon btn-primary btn-sm text-end mx-2 float-end" title="Regenerate Private Key"><i class="<?=$data['fwicon']['arrow-rotate-right'];?>"></i></a> 
			 
			 <b id="generate_private_key2" class="text-break d-none d-sm-block float-end" ><?=$post['public_key'];?></b>
			 </div>
        </div>
      </div>
      <? } else { ?>
      <h4 class="my-2"><i class="<?=$data['fwicon']['website'];?>"></i> Add New <?=$data['MYWEBSITE']?></h4>
      <? } ?>
      <div class="my-2 row rounded text-white px-2 was-validated">
        <div class="px-1 col-sm-6">
          <div class="input-field mt-4">
          <input <? //=$ep;?> type="text" class="form-control is-invalid" minlength="3" name="ter_name" id="input_ter_name" value="<? if(isset($post['ter_name'])) echo $post['ter_name']?>"  title=" <?=($data['PageName']);?> of your choice" data-bs-toggle="tooltip" data-bs-placement="bottom" autocomplete="off" required >
		  <label for="input_ter_name"><?=($data['PageName']);?> of your choice</label>
		  </div>
        </div>
		
        <div class="px-1 col-sm-6">
          <div class="input-field mt-4" title="Enter your business url (Non Editable)" data-bs-toggle="tooltip" data-bs-placement="bottom" >
      
          <input <?=$ep;?> type="text" class="form-control is-invalid" minlength="3" name="bussiness_url" id="input_bussiness_url" value="<? if(isset($post['bussiness_url'])) echo $post['bussiness_url']?>" title="Enter your business url"  autocomplete="off" required />
        <label for="input_bussiness_url">Business URL</label>
		  </div>
        </div>
		
<!--Chosen Script for advance search and multi select dropdown-->
<script src="<?=$data['TEMPATH']?>/common/css/chosen/chosen.jquery.min.js"></script>
<link href="<?=$data['TEMPATH']?>/common/css/chosen/chosen.min.css" rel="stylesheet"/>

		 <div class="px-1 col-sm-6">
          <div class="input-field select mt-4">
				
			<?
				if(isset($post['terminal_type'])&&$post['terminal_type']){
					$terminal_type_ex=explode(",",$post['terminal_type']);
				}

			?>
				
				  <select id="terminal_type_no_add" data-placeholder="Start typing the Terminal Type " multiple class="chosen-select form-control" name="terminal_type[]" style="clear:right;width:100%;" >
					<option value="Website">Website</option>
					<option value="Mobile App">Mobile App</option>
					<option value="Point of Sale">Point of Sale</option>
					<option value="Display QR">Display QR</option>
					<option value="Others">Others</option>
				  </select>
					
				<script>
				$(".chosen-select").chosen({
				no_results_text: "Oops, nothing found!"
				});
				<? if(isset($terminal_type_ex)&&$terminal_type_ex){ ?>
					chosen_more_value_f("terminal_type_no_add",[<?=('"'.implodes('", "',$terminal_type_ex).'"');?>]);
				<? } ?>
				
				$("#terminal_type_no_add_chosen").css("width", "100%");
				$("#terminal_type_no_add_chosen").css("padding", "0");
				$("#terminal_type_no_add_chosen").addClass("form-control");
				</script>

		 
		  </div>
        </div>
        
        <div class="px-1 col-sm-6">
          <div class="input-field mt-4">
          <input <? //=$ep;?> type="text" class="form-control" name="business_nature"  id="input_business_nature" value="<? if(isset($post['business_nature'])) echo $post['business_nature']?>" title="Enter your business nature in short" data-bs-toggle="tooltip" data-bs-placement="bottom" autocomplete="off"   >
             <label for="input_business_nature">Business Nature</label>
		  </div>
        </div>
        
		<div class="px-1 col-sm-6">
          <div class="input-field mt-4">
          <input type="text" class="form-control" name="dba_brand_name"  id="input_dba_brand_name" value="<? if(isset($post['dba_brand_name'])) echo $post['dba_brand_name']?>" title="Enter DBA/Brand Name - This will be shown to your customers as your company_name name" data-bs-toggle="tooltip" data-bs-placement="bottom" autocomplete="off" >
        <label for="input_dba_brand_name">DBA/Brand Name</label>
		  </div>
        </div>
       
        <div class="px-1 col-sm-6">
          <div class="input-field mt-4">
          <input type="text" class="form-control" name="customer_service_no"  id="input_customer_service_no" value="<? if(isset($post['customer_service_no'])) echo $post['customer_service_no']?>" title="Enter customer service No. This will be displayed to your customers to contact you" data-bs-toggle="tooltip" data-bs-placement="bottom" autocomplete="off" >
        <label for="input_customer_service_no">Customer Service No.</label>
		  </div>
        </div>
		
        <div class="px-1 col-sm-6">
          <div class="input-field mt-4">
          <input type="text" class="form-control" name="customer_service_email"  id="input_customer_service_email" value="<? if(isset($post['customer_service_email'])) echo encrypts_decrypts_emails($post['customer_service_email'],2);?>" title="Enter customer service email This will be displayed to your customers to contact you" data-bs-toggle="tooltip" data-bs-placement="bottom" autocomplete="off" >
        <label for="input_customer_service_email">Customer Service Email</label>
		  </div>
        </div>
		
        <div class="px-1 col-sm-6">
          <div class="input-field mt-4">
          <input type="text" class="form-control" name="merchant_term_condition_url"  id="input_merchant_term_condition_url" value="<? if(isset($post['merchant_term_condition_url'])) echo $post['merchant_term_condition_url']?>" title=" Your web url for t&c" data-bs-toggle="tooltip" data-bs-placement="bottom" autocomplete="off" >
        <label for="input_merchant_term_condition_url">T & C</label>
		  </div>
        </div>
		
        <div class="px-1 col-sm-6">
          <div class="input-field mt-4">
          <input type="text" class="form-control" name="merchant_refund_policy_url"  id="input_merchant_refund_policy_url" value="<? if(isset($post['merchant_refund_policy_url'])) echo $post['merchant_refund_policy_url']?>" title=" Your web url for refund policy" data-bs-toggle="tooltip" data-bs-placement="bottom" autocomplete="off" >
        <label for="input_merchant_refund_policy_url">URL of Refund Policy</label>
		  </div>
        </div>
		
        <div class="px-1 col-sm-6">
          <div class="input-field mt-4">
          <input type="text" class="form-control" name="merchant_privacy_policy_url"  id="input_merchant_privacy_policy_url" value="<? if(isset($post['merchant_privacy_policy_url'])) echo $post['merchant_privacy_policy_url']?>" title=" Your web url for privacy policy" data-bs-toggle="tooltip" data-bs-placement="bottom" autocomplete="off" >
        <label for="input_merchant_privacy_policy_url">URL of Privacy Policy</label>
		  </div>
        </div>
		
        <div class="px-1 col-sm-6">
          <div class="input-field mt-4">
          <input type="text" class="form-control" name="merchant_contact_us_url"  id="input_merchant_contact_us_url" value="<? if(isset($post['merchant_contact_us_url'])) echo $post['merchant_contact_us_url']?>" title="Your web url for contact us" data-bs-toggle="tooltip" data-bs-placement="bottom" autocomplete="off" >
        <label for="input_merchant_contact_us_url">URL of Contact US</label>
		  </div>
        </div>
		
        <div class="px-1 col-sm-6">
          <div class="input-field mt-4">
          <input type="text" class="form-control" name="merchant_logo_url"  id="input_merchant_logo_url" value="<? if(isset($post['merchant_logo_url'])) echo $post['merchant_logo_url']?>" title="Your web url for logo" data-bs-toggle="tooltip" data-bs-placement="bottom" autocomplete="off" >
        <label for="input_merchant_logo_url">URL of Logo</label>
		  </div>
        </div>
		
        
        <div class="col-sm-12 hide">
          <textarea class="form-control" name="business_description" id="input_business_description" title="Describe your business in details" data-bs-toggle="tooltip" ><? if(isset($post['business_description'])) echo $post['business_description']?>
</textarea>
        <label for="input_business_description">Business Description</label>
		  </div>
        </div>
		
        <div class="accordion px-0 mt-1" id="accordionExample">
          <div class="accordion-item">
            <h2 class="accordion-header" id="headingTwo">
              <button class="accordion-button btn btn-outline-primary w-100 collapsed rounded" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo"> <i class="<?=$data['fwicon']['circle-plus'];?> ps-2"></i>&nbsp;&nbsp;Additional Fields </button>
            </h2>
            <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
              <div class="accordion-body">
                <div class="row was-validated">
                  <div class="p-1 col-sm-4">
				  <div class="input-field mt-4">
                    <input type="text" class="form-control" name="mer_trans_alert_email"  id="input_mer_trans_alert_email" value="<? if(isset($post['mer_trans_alert_email'])) echo encrypts_decrypts_emails($post['mer_trans_alert_email'],2);?>" autocomplete="off" title="Enter email id where we can send the transaction notification" data-bs-toggle="tooltip" data-bs-placement="bottom" >
					<label for="input_mer_trans_alert_email" >Notification Email</label>
                  </div>
				  </div>
                  <div class="p-1 col-sm-4">
				  <div class="input-field mt-4">
                    <input type="text" class="form-control" name="return_url" id="return_url"  id="input_return_url" value="<? if(isset($post['return_url'])) echo $post['return_url']?>" autocomplete="off" title="Enter return url (additional field for custom programming)" data-bs-toggle="tooltip" data-bs-placement="bottom" >
					<label for="input_return_url" >Return Url</label>
                  </div>
				  </div>
                  <div class="p-1 col-sm-4">
                    <div class="input-field mt-4">
                    <input type="text" class="form-control" name="webhook_url"  id="input_webhook_url" value="<? if(isset($post['webhook_url'])) echo $post['webhook_url']?>" autocomplete="off" title="Enter webhook url (additional field for custom programming)" data-bs-toggle="tooltip" data-bs-placement="bottom" >
					<label for="input_webhook_url" >Webhook Url</label>
                  </div>
				  </div>
                  
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="row my-2 p-2 ms-1">
          <div class="col-sm-12 my-2 ">
            <label data-bs-toggle="tooltip" title="" data-bs-original-title="You can decide about the email notification sent by us">Notification Alert <i class="<?=$data['fwicon']['circle-question'];?> text-color-dark"></i></label>
          </div>
          <? if(isset($post['tarns_alert_email'])&&is_array($post['tarns_alert_email'])){$tarns_alert_email=implode(",",$post['tarns_alert_email']);}else{$tarns_alert_email=((isset($post['tarns_alert_email']) &&$post['tarns_alert_email'])?$post['tarns_alert_email']:'');}?>
          <div class="col-sm-2" title="Notify to Merchant on Approval"> <span class="form-check form-switch  float-start">
            <input type="checkbox" name='tarns_alert_email[]2' id='tarns_alert_email1' class='checkbox_d form-check-input' size="100" value='001' <?php if($tarns_alert_email&&strpos($tarns_alert_email,"001")!==false){echo "checked='checked'";} ?> />
            </span>
            <label for="tarns_alert_email1" title="Merchant on Approval">Approved</label>
          </div>
          <div class="col-sm-2" title="Notify to Merchant on Declined"> <span class="form-check form-switch  float-start">
            <input type="checkbox" name='tarns_alert_email[]' id='tarns_alert_email4' class='checkbox_d form-check-input' size="100" value='004' <?php if($tarns_alert_email&&strpos($tarns_alert_email,"004")!==false){echo "checked='checked'";} ?>>
            </span>
            <label for="tarns_alert_email4" title="Merchant on Declined">Declined</label>
          </div>
          <div class="col-sm-2"> <span class="form-check form-switch  float-start" title="Notify to Merchant on Withdraw">
            <input type="checkbox" name='tarns_alert_email[]' id='tarns_alert_email_011' class='checkbox_d form-check-input' size="100" value='011' <?php if($tarns_alert_email&&strpos($tarns_alert_email,"011")!==false){echo "checked='checked'";} ?>>
            </span>
            <label for="tarns_alert_email_011" title="Notify to Merchant on Withdraw">Withdraw</label>
          </div>
          <div class="col-sm-2" title="Notify to Merchant on Chargeback"> <span class="form-check form-switch  float-start">
            <input type="checkbox" name='tarns_alert_email[]' id='tarns_alert_email_012' class='checkbox_d form-check-input' size="100" value='012' <?php if($tarns_alert_email&&strpos($tarns_alert_email,"012")!==false){echo "checked='checked'";} ?>>
            </span>
            <label for="tarns_alert_email_012" title="Notify to Merchant on Chargeback">Chargeback</label>
          </div>
          <div class="col-sm-2" title="Notify to Merchant on Refunded"> <span class="form-check form-switch  float-start">
            <input type="checkbox" name='tarns_alert_email[]' id='tarns_alert_email_013' class='checkbox_d form-check-input' size="100" value='013' <?php if($tarns_alert_email&&strpos($tarns_alert_email,"013")!==false){echo "checked='checked'";} ?>>
            </span>
            <label for="tarns_alert_email_013" title="Notify to Merchant on Refunded">Refund</label>
          </div>
          <div class="col-sm-2" title="Notify to Customer"> <span class="form-check form-switch  float-start">
            <input type="checkbox" name='tarns_alert_email[]' id='tarns_alert_email2' class='checkbox_d form-check-input' size="100" value='002' <?php if($tarns_alert_email&&strpos($tarns_alert_email,"002")!==false){echo "checked='checked'";} ?>>
            </span>
            <label for="tarns_alert_email2" title="Notification to customer for success and decline.">Customer</label>
          </div>
        </div>

        <div class="my-2 text-center">
          <button type="submit" name="send" value="CONTINUE"  class="btn btn-primary my-2" ><i class="<?=$data['fwicon']['check-circle'];?>"></i> Submit</button>
          <a href="<?=$data['USER_FOLDER']?>/<?=($data['PageFileName']);?><?=$data['ex']?>" class="btn btn-primary my-2"><i class="<?=$data['fwicon']['back'];?>"></i> Back</a> </div>
      </div>
    </div>
    <? }elseif($post['step']==3){ ?>
    <? if($post['is_admin']==true){ ?>
    <? } ?>
    <? if(($post['is_admin'])&&($post['is_admin'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_add_stores'])&&$_SESSION['merchant_action_add_stores']==1))){ ?>
    <div class="float-end"> <a class="sub_logins nopopup" href='<?=$data['Admins']?>/merchant<?=$data['ex']?>?bid=<?=$post['gid']?>&id=<?=$post['id']?>&action=update_terminals&type=active&page=0&admin=1&hideAllMenu=1'><i class="<?=$data['fwicon']['edit'];?> text-success"></i></a> </div>
    <? if(isset($post['templates_log'])&&$post['templates_log']){ ?>
    <!--<a class="btn btn-primary view_json" onclick="view_next3(this,'')" style="float:left;padding:1px 6px 1px 8px;margin: 5px 0 0 10px;">View Log11</a>-->
    <div class="row hide">
      <div class="col_2" style="width:100%;padding:0;">
        <?
		  $all_log=jsondecode($post['templates_log']);
		?>
        <div class="tbl_exl" style="width:99px;height:100px;">
          <table style="margin-top: -2px;" class="table">
            <tbody>
              <? if(is_array($all_log)){foreach($all_log as $key6=>$value6){ ?>
              <tr>
                <td title="<?=$key6;?>" style="width: 122px;"><div>
                    <?=$value6['tm_user'];?>
                  </div>
                  <div>
                    <?=$value6['tm_date'];?>
                  </div></td>
                <td title="<?=$key6;?>" ><?
							 if(is_array($value6)){
							 $value6_0=jsondecode($value6['tm_log']);
							 foreach($value6_0 as $key6_1=>$value6_1){
							 ?>
                  <div class="dtd" title="<?=$key6_1?>" >
                    <?=$key6_1?>
                    : <b>
                    <?=$value6_1;?>
                    </b> </div>
                  <? }} ?>
                </td>
              </tr>
              <? }} ?>
            </tbody>
          </table>
        </div>
      </div>
    </div>
    <? } ?>
    <div class="col-sm-12">
    <? echo $jsonVew=json_log_view1($post['json_log_history'],'View Json Log',$_GET['id'],'terminal','','100'); ?> </div>
    <? } ?>
	
	<!--//Detail used on admin section merchant <?=$data['MYWEBSITE']?> details-->
	
    <div class="container my-2 px-0 table-responsive vkg">
      <h2 class="ms-1"><?=$data['MYWEBSITE']?> Details :: <?=prntext($post['ter_name'])?> !!</h2>
      <!--<div class="vkg-main-border2"></div>-->
      <!--class="table table-light table-striped"-->
      <div class="row border bg-light my-2 text-start rounded p-2">
        <div class="row col-sm-6 my-2 p-2">
          <div><strong><?=($data['PageName']);?> TerNO: </strong> <?=$post['gid']?></div>
        </div>
        <? if(isset($post['active'])&&$post['active']){ ?>
        <div class="row col-sm-6 my-2 p-2 ">
          <div><strong>
            <?=($data['PageName']);?>
            Status :</strong>
            <?=$data['store_status'][$post['active']]['title'];?>
          </div>
        </div>
        <? } ?>
        <? if(isset($post['ter_name'])&&$post['ter_name']){ ?>
        <div class="row col-sm-6 my-2 p-2 ">
          <div><strong>
            <?=($data['PageName']);?>
            Name:</strong>
            <?=prntext($post['ter_name'])?>
          </div>
        </div>
        <? } ?>
        <? if(isset($post['public_key'])&&$post['public_key']){ ?>
        <div class="row col-sm-6 my-2 p-2 ">
          <div><strong>Public Key:</strong>
            <?=substr($post['public_key'],0,10);?>
            ****************</div>
        </div>
        <? } ?>
        <!--<div class="row col-sm-12  my-2 p-2 ">
    <div><strong>Acquirer Id:</strong> <? if(is_array($post['tarns_alert_email'])){$tarns_alert_email=implode(",",$post['tarns_alert_email']);}else{$tarns_alert_email=$post['tarns_alert_email'];} ?>
          <?php if($tarns_alert_email&&strpos($tarns_alert_email,"007")!==false){echo "Request Money | ";} ?>
          <?php if($tarns_alert_email&&strpos($tarns_alert_email,"008")!==false){echo "VT |";} ?>
          <? $acquirerIDs=explode(',',$post['acquirerIDs']);
		foreach ($acquirerIDs as $value){
		if ($value==$post['curling_access_key']){
				$curling_access_key='<span title=" Verified" class="glyphicons ok_2" style="color: rgb(0, 164, 30);"><i></i></span>';
			}else {
				$curling_access_key='';
			}
			
		
		?>
          <?=$data['t'][$value]['name1'];?>
          <? echo $curling_access_key.' | ';?>
          <? } ?> </div>
  </div>-->
        <? if(isset($post['bussiness_url'])&&$post['bussiness_url']){ ?>
        <div class="row col-sm-6  my-2 p-2 ">
          <div><strong>Business URL: </strong>
            <?=$post['bussiness_url']?>
          </div>
        </div>
        <? } ?>
        <? if(($post['deleted_bussiness_url'])&&($post['is_admin'])&&($post['is_admin'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['deleted_business_url'])&&$_SESSION['deleted_business_url']==1))){ ?>
        <div class="row col-sm-6 my-2 p-2 "> <strong>Updated Business URL: </strong>
          <?=$post['deleted_bussiness_url']?>
        </div>
        <? } ?>
        <? if(isset($post['transaction_currency'])&&$post['transaction_currency']){ ?>
        <div class="row col-sm-6 my-2 p-2 ">
          <div><strong>Transaction Currency: </strong>
            <?=$post['transaction_currency']?>
          </div>
        </div>
        <? } ?>
        <? if(isset($post['business_nature'])&&$post['business_nature']){ ?>
        <div class="row col-sm-6 my-2 p-2 ">
          <div><strong>Business Nature:</strong>
            <?=$post['business_nature']?>
          </div>
        </div>
        <? } ?>
       
	   
        <? if(isset($post['mer_trans_alert_email'])&&$post['mer_trans_alert_email']){ ?>
        <div class="row col-sm-6  my-2 p-2 ">
          <div ><strong>T.Notification Email : </strong>
            <?=encrypts_decrypts_emails($post['mer_trans_alert_email'],2);?>
          </div>
        </div>
        <? } ?>
        <? if(isset($post['dba_brand_name'])&&$post['dba_brand_name']){ ?>
        <div class="row col-sm-6 my-2 p-2 ">
          <div><strong>DBA/Brand Name :</strong>
            <?=$post['dba_brand_name']?>
          </div>
        </div>
        <? } ?>
		<? if(isset($value['dba_brand_name'])&&$value['dba_brand_name']){ ?>
        <div class="row m-2">
				<div class="col-sm-3">DBA/Brand Name</div>
				<div class="col-sm-9">: <?=$value['dba_brand_name']?>
          </div>
        </div>
        <? } ?>
        <? if(isset($post['customer_service_no'])&&$post['customer_service_no']){ ?>
        <div class="row col-sm-6  my-2 p-2 ">
          <div><strong>Customer Service No. :</strong>
            <?=$post['customer_service_no']?>
          </div>
        </div>
        <? } ?>
        <? if(isset($post['customer_service_email'])&&$post['customer_service_email']){ ?>
        <div class="row col-sm-6  my-2 p-2 ">
          <div><strong>Customer Service Email : </strong>
            <?=encrypts_decrypts_emails($post['customer_service_email'],2)?>
          </div>
        </div>
        <? } ?>
        <? if(isset($post['merchant_term_condition_url'])&&$post['merchant_term_condition_url']){ ?>
        <div class="row col-sm-6 my-2 p-2 ">
          <div><strong>T & C :</strong>
            <?=$post['merchant_term_condition_url']?>
          </div>
        </div>
        <? } ?>
        <? if(isset($post['merchant_refund_policy_url'])&&$post['merchant_refund_policy_url']){ ?>
        <div class="row col-sm-6  my-2 p-2 ">
          <div><strong>URL of Refund Policy :</strong>
            <?=$post['merchant_refund_policy_url']?>
          </div>
        </div>
        <? } ?>
        <? if(isset($post['merchant_privacy_policy_url'])&&$post['merchant_privacy_policy_url']){ ?>
        <div class="row col-sm-6  my-2 p-2 ">
          <div><strong>URL of Privacy Policy :</strong>
            <?=$post['merchant_privacy_policy_url']?>
          </div>
        </div>
        <? } ?>
        <? if(isset($post['merchant_contact_us_url'])&&$post['merchant_contact_us_url']){ ?>
        <div class="row col-sm-6 my-2 p-2 ">
          <div><strong>URL of Contact US: </strong>
            <?=$post['merchant_contact_us_url']?>
          </div>
        </div>
        <? } ?>
        <? if(isset($post['merchant_logo_url'])&&$post['merchant_logo_url']){ ?>
        <div class="row col-sm-6 my-2 p-2 ">
          <div><strong>URL of Logo:</strong>
            <?=$post['merchant_logo_url']?>
          </div>
        </div>
        <? } ?>
        <? if(isset($post['return_url'])&&$post['return_url']){ ?>
        <div class="row col-sm-6 my-2 p-2 ">
          <div><strong>Return Url:</strong>
            <?=$post['return_url']?>
          </div>
        </div>
        <? } ?>
        <? if(isset($post['webhook_url'])&&$post['webhook_url']){ ?>
        <div class="row col-sm-6 my-2 p-2 ">
          <div><strong>Webhook Url:</strong>
            <?=$post['webhook_url']?>
          </div>
        </div>
        <? } ?>
        <? if(isset($post['business_description'])&&$post['business_description']){ ?>
        <div class="row col-sm-6 my-2 p-2 ">
          <div><strong>Business Description:</strong>
            <?=prntext($post['business_description'])?>
          </div>
        </div>
        <? } ?>
      
        <? if(isset($post['tarns_alert_email'])&&$post['tarns_alert_email']){ ?>
        <div class="row col-sm-6 my-2 p-2 ">
          <div><strong>Notification  Alert :</strong>
            <? if(is_array($post['tarns_alert_email'])){$tarns_alert_email=implode(",",$post['tarns_alert_email']);}else{$tarns_alert_email=$post['tarns_alert_email'];} ?>
            <?php 
			if($tarns_alert_email&&strpos($tarns_alert_email,"001")!==false){echo "Notification to Merchant on Approved, ";}
			if($tarns_alert_email&&strpos($tarns_alert_email,"004")!==false){echo "Notification to Merchant on Declined, ";}
			if($tarns_alert_email&&strpos($tarns_alert_email,"002")!==false){echo "Notification to Customer, ";}
			if($tarns_alert_email&&strpos($tarns_alert_email,"011")!==false){echo "Notify to Merchant on Withdraw, ";}
			if($tarns_alert_email&&strpos($tarns_alert_email,"012")!==false){echo "Notify to Merchant on Chargeback, ";}
			if($tarns_alert_email&&strpos($tarns_alert_email,"013")!==false){echo "Notify to Merchant on Refunded";}
			
		  ?>
          </div>
        </div>
        <? } ?>
      </div>
      <? if(!isset($_GET['admin'])) { ?>
      <div class="text-center"> <a href="<?=$data['USER_FOLDER']?>/<?=($data['PageFileName']);?><?=$data['ex']?>?<?=($admin_subquery);?>" class="btn btn-primary my-2" id="w100"><i class="<?=$data['fwicon']['back'];?>"></i> Back</a> </div>
      <? } ?>
    </div>
	
    <? } ?>
  </form>
</div>
<?php /*?>js for copy Public Key and resize width on mobile<?php */?>
<script>
$(window).bind("load resize scroll",function(){
	if ($(window).width() < 400) {
	  $('#w100').addClass("w-100");
	}else{
	$('#w100').removeClass("w-100");
	}
});
	


</script>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
