<?
$address_con=$post['address_con'];
$card_con=$post['card_con'];
$is_admin=$post['is_admin'];
$rParam1=$post['rParam1'];
$json_value=$post['json_value'];

$json_value1=@$post['json_value1'];

//`acquirer_creds_processing_final`,`payload_stage1`,`acquirer_response_stage1`,`acquirer_response_stage2`
$acquirer_creds_processing_final=@$post['TransactionDetails']['acquirer_creds_processing_final'];
$payload_stage1=@$post['TransactionDetails']['payload_stage1'];
$acquirer_response_stage1=@$post['TransactionDetails']['acquirer_response_stage1'];
$acquirer_response_stage2=@$post['TransactionDetails']['acquirer_response_stage2'];


$bankName=$post['bankName'];
$upi_vpa_lable=$post['upi_vpa_lable'];
$upi_vpa=$post['upi_vpa'];

$trans_href=$post['trans_href'];
$trans_datah=$post['trans_datah'];
$trans_target=$post['trans_target'];
$trans_class=$post['trans_class'];
$typenum=@$post['TransactionDetails']['typenum'];

if($post['TransactionDetails']['typenum']==2||$post['TransactionDetails']['typenum']==3||$post['TransactionDetails']['typenum']==4){
$show_ui=0; $address_con=0;
if(isset($post['TransactionDetails']['bussiness_url'])) unset($post['TransactionDetails']['bussiness_url']);
}
else { $show_ui=1; }
				

?>

<!DOCTYPE>
<html>

<style>
/*css for inline page title / underline / modal /button etc*/
.addrembtn{margin-top: -67px; margin-bottom:0px; width:100% !important;}
.commentrow .title2{margin-top:5px;}
.addremarkform {display: none;}
.listActive1, .listActive1 td, .listActive1 td, .listActive1 a, .listActive1 font {}

.rmk_date {
	float: unset;
    width: 112px;
    display: table-cell;
	}
	
.modal-body .row {
    --bs-gutter-x: 0rem !important;
}

button.btn-close {position: absolute;right: 13px;z-index: 999999;}
.modal-body .col-sm-9 {text-indent: -7px;}
<? if(strstr($_SESSION['root_background_color'],"gradient")){?>
.vkg-underline-red { border-bottom: 5px solid <?=$_SESSION['background_gd4'];?> !important; }
<? } else{ ?>
.vkg-underline-red { border-bottom: 5px solid var(--background-1)!important; }
<? } ?>
	
</style>
</head>
<body>
<? if($post['ViewMode']=='details'){ ?>
		
		
			<div class="addrembtn px-0 vnextParent">
			  <div class="rightlink text-end" style="width: 95%;clear: right;">
				<? if((isset($post['TransactionDetails']['canrefund'])&&$post['TransactionDetails']['canrefund'])){ ?>
					<a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?id=<?=$post['TransactionDetails']['id']?><? if(isset($post['StartPage'])){ ?>&page=<?=$post['StartPage']?><? } ?>&action=refund" onClick="return confirm('Are you Sure to REFUND the Amount of <?=$post['TransactionDetails']['fees_o_txt'];?> and Transaction id is <?=$post['TransactionDetails']['transID'];?>');">Refund</a> |
				<? } ?>
	

				<? if(($is_admin)&&((isset($_SESSION['login_adm']))||(isset($_SESSION['json_post_view']))&&$_SESSION['json_post_view']==1)){?>	
				<p onClick="collapse_close_all('targethtml');popup_openv1('<?=$data['Admins'];?>/json_html_display<?=$data['ex']?>','<?=encryptres($json_value1);?>');" id="targethtml" class="modal_trans99 nomid88 btn btn-outline-success btn-sm my-2"  title="Json Html View" ><i class="<?=$data['fwicon']['table-list'];?>"></i></p>
					<p onClick="rActive(this,'.vnextParent','.vnext','active');collapse_close_all('targetvkg');popup_openv1('<?=$data['Admins'];?>/json_pretty_print<?=$data['ex']?>','<?=encryptres($json_value1);?>','<?=encryptres($payload_stage1);?>','<?=@$acquirer_response_stage1;?>','<?=@$acquirer_response_stage2;?>');" id="targetvkg" class="modal_trans99 nomid88 btn btn-outline-success btn-sm my-2"  title="Payload View" ><i class="<?=$data['fwicon']['eye-solid'];?>"></i></p>

					<!--<a class=" btn btn-outline-warning view_json99 btn-sm" onClick="vnext(this,'.postjson_div','.vnextParent','.vnext')" title="Payload Json"><i class="<?=$data['fwicon']['eye-solid'];?>"></i></a>-->
					<a class="btn btn-outline-warning btn-sm" data-bs-toggle="collapse" href="#collapsePayloadJson" id="collapsePayloadJsonlavel" role="button" aria-expanded="false" aria-controls="collapsePayloadJson" title="Payload Json" onClick="collapse_close_all('collapsePayloadJson')"><i class="<?=$data['fwicon']['eye-solid'];?>"></i></a>
					
					
				<? } ?>


				<? if(($is_admin)&&((isset($_SESSION['login_adm']))||(isset($_SESSION['txn_detail']))&&$_SESSION['txn_detail']==1)){?>	
					<? $acquirer_response1=jsonencode1($post['TransactionDetails']['acquirer_response'],'',1);?>
					<a onClick="rActive(this,'.vnextParent','.vnext','active');collapse_close_all('acqresp');popup_openv1('<?=$data['Admins'];?>/json_pretty_print<?=$data['ex']?>','<?=encryptres($acquirer_response1);?>');" class="nomid btn btn-outline-danger btn-sm my-2"  title="Acquier Response" id="acqresp"><i class="<?=$data['fwicon']['eye-solid'];?>"></i></a>

					
<a class="btn btn-outline-danger btn-sm" data-bs-toggle="collapse" href="#collapseAcquierResponseJson" id="collapseAcquierResponseJsonlavel" role="button" aria-expanded="false" aria-controls="collapseAcquierResponseJson" title="Acquier Response Json" onClick="collapse_close_all('collapseAcquierResponseJson')"><i class="<?=$data['fwicon']['eye-solid'];?>"></i></a>
					
				<? } ?>

				<? if((($is_admin)&&(in_array($post['TransactionDetails']['typenum'],["2","3", "4", "5"])))&&((isset($_SESSION['login_adm']))||(isset($_SESSION['decode_json_acc'])&&$_SESSION['decode_json_acc']==1))){ ?>
					<a onClick="vnext(this,'.acquier_tesponse_json1','.vnextParent','.vnext');ajaxf1(this,'<?=$data['Admins']?>/<?=$data['trnslist']?><?=$data['ex']?>?action=wd_view_acc&id=<?=$_REQUEST['id']?>&viewaction=viewAccountOrAddress','.acquier_tesponse_json_log','1');" class="btn btn-outline-warning view_json99 btn-sm" title="Bank Decode"><i class="<?=$data['fwicon']['eye-solid'];?>"></i></a>
				<? } ?>
 
<? if((($is_admin)&&(!in_array($post['TransactionDetails']['typenum'],[0=>"2",1=>"3",2=>"4",3=>"5",4=>"6"])))&&((isset($_SESSION['login_adm']))||(isset($_SESSION['role_push_notify'])&&$_SESSION['role_push_notify']==1))){ ?>

					 
<a class="btn btn-outline-secondary btn-sm" data-bs-toggle="collapse" href="#collapsePushNotify" id="collapsePushNotifylavel" role="button" aria-expanded="false" aria-controls="collapsePushNotify" title="Push Notify" onClick="collapse_close_all('collapsePushNotify')"><i class="<?=$data['fwicon']['eye-solid'];?>"></i></a>
					 
				<? } ?>	 
					 
<a class="addremarklink btn btn-outline-primary btn-sm my-2" id="addremarklinklavel" onClick="addremarks(this);collapse_close_all('addremarklinklavel')" title="Add Remark"><i class="<?=$data['fwicon']['edit'];?> text-success" data-bs-toggle="collapse" href="#collapseAddremark" role="button" aria-expanded="false" aria-controls="collapseAddremark"></i></a> 


				
				</div>
			</div>






<!-- start: slider  -->	

<? if((($is_admin)&&(!in_array($post['TransactionDetails']['typenum'],[0=>"2",1=>"3",2=>"4",3=>"5",4=>"6"])))&&((isset($_SESSION['login_adm']))||(isset($_SESSION['role_push_notify'])&&$_SESSION['role_push_notify']==1))){ ?>
<div class="collapse"  id="collapsePushNotify">		
<div class="card card-body my-2 bg-dark-subtle">

		<div class='f'>
						<div class="w_98 g row">
						
		<span class='col-sm-12 text-start '><h6>Webhook Url :</h6></span><span class='col-sm-12' ><textarea name="mcb_notify_url" id='mcb_notify_url' class="form-control"><?=$post['TransactionDetails']['webhook_url']?></textarea>
						</span>
						
						</div>
						
						<div class="w_98 g row"><span class='col-sm-12 text-start' ><h6>Return Url :</h6></span>
						
						<span class='col-sm-12' ><textarea name="mcb_redirect_url" id='mcb_redirect_url' class="form-control" ><?=$post['TransactionDetails']['return_url']?></textarea></span></div>
						
						</div>
		<div class="my-2"><textarea name="mcb_body" id='mcb_body' class="form-control"><?=json_encode($rParam1);?></textarea></div>
				
<a class="btn btn-primary btn-sm my-2 float-end" onClick="callback_send(this)">Submit</a>	
<div class="clearfix"></div>	
</div>
</div>		
<? } ?>		
		
		
<? if(($is_admin)&&((isset($_SESSION['login_adm']))||(isset($_SESSION['json_post_view']))&&$_SESSION['json_post_view']==1)){?>


<div class="collapse" id="collapsePayloadJson">
	<div class="card card-body my-2">
	 	<h6 class="btn btn-outline-primary w-100 text-start mt-2">Payload Json</h6>
		<?=htmlentitiesf($json_value1);?>
		<?
		if(isset($payload_stage1)&&@$payload_stage1){
			$payload_stage1 = urldecode($payload_stage1);
			echo '<h6 class="btn btn-outline-primary w-100 text-start mt-2">Payload Stage 1</h6>';
			echo $payload_stage1 = stf($payload_stage1);
		}

		if(isset($acquirer_response_stage1)&&@$acquirer_response_stage1){
			$acquirer_response_stage1 = stripslashes(decode64f($acquirer_response_stage1));
			$acquirer_response_stage1 = urldecode($acquirer_response_stage1);
			echo '<h6 class="btn btn-outline-primary w-100 text-start mt-2">Acquirer Response Stage 1</h6>';
			echo $acquirer_response_stage1 = stf($acquirer_response_stage1);
		}

		if(isset($acquirer_response_stage2)&&@$acquirer_response_stage2){
			$acquirer_response_stage2 = stripslashes(decode64f($acquirer_response_stage2));
			$acquirer_response_stage2 = urldecode($acquirer_response_stage2);
			echo '<h6 class="btn btn-outline-primary w-100 text-start mt-2">Acquirer Response Stage 2 </h6>';
			echo $acquirer_response_stage2 = stf($acquirer_response_stage2);
		}


		?>
	</div>
</div>


<? } ?>


<? if(($is_admin)&&((isset($_SESSION['login_adm']))||(isset($_SESSION['txn_detail']))&&$_SESSION['txn_detail']==1)){?>
	
<div class="collapse" id="collapseAcquierResponseJson">
<div class="card card-body my-2"><?=$acquirer_response1=jsonencode1($post['TransactionDetails']['acquirer_response'],'',1);?></div>
</div>

<? }


 if(($is_admin)&&((isset($_SESSION['login_adm']))||(isset($_SESSION['txn_detail']))&&$_SESSION['txn_detail']==1)){?>
	
<div class="col-sm-12 mb-2 border rounded bg-light p-2 text-break acquier_tesponse_json1 vnext" style="display:none">
<div class="acquier_tesponse_json_log1">
	<? if(isset($post['TransactionDetails']['json_log_history'])&&$post['TransactionDetails']['json_log_history']){?>	
			  <div class="m-2" style="float:left;width:100%;clear:both !important;">
			  <? echo json_log_view($post['TransactionDetails']['json_log_history'],'wd_view_acc', 0,'','','99%');?>
			  </div>

	 <? } ?>
 </div>
<?
echo $acquirer_response = decode_json_acc($post['TransactionDetails']['acquirer_response'],1);
?></div>
<? }
 ?>

<!-- end: slider  -->	



	
    <div class="col-sm-12 ">
	<div class="text-center text-danger" id="gmsg"></div>
			<div id="addremarkform" class="addremarkform comtabdiv addremarkform_tab vnext border rounded my-2 px-2">
			  <form method="post" target="hform">
				<input type="hidden" name="action" value="addremark">
				<input type="hidden" name="gid" id="p_gid" value="<?=$post['TransactionDetails']['id']?>">
				<input type="hidden" name="page" value="<?=$post['StartPage']?>">
<div class="row mx-0">	

<div class="col-sm-12">			
<textarea required name="mer_note" id="gdesc" placeholder="Add Remark" class="form-control remarkcoment my-2"><?=prntext(((isset($post['mer_note']) &&$post['mer_note'])?$post['mer_note']:''));?></textarea>
</div>				
 <div class="col-sm-9">
<? if($is_admin&&((isset($_SESSION['login_adm']))||(isset($_SESSION['t_add_remark'])&&$_SESSION['t_add_remark']==1))){ ?>
<div class="replytype is_admin ms-2">
 <input type="radio" name="reply_type" value="support" id="support<?=$post['TransactionDetails']['id']?>" checked="checked" >
<label for="support<?=$post['TransactionDetails']['id']?>" >&nbsp;&nbsp;Support Note</label>
				  
<input type="radio" name="reply_type" value="system" id="system<?=$post['TransactionDetails']['id']?>" >
<label for="system<?=$post['TransactionDetails']['id']?>" >&nbsp;&nbsp;System Note </label>

</div>
				
<? } ?>
</div>
				
<div class="col-sm-3 text-end">				
<a name="send" id="sub_remark" value="CONTINUE"  class="add_remark_submit btn btn-primary btn-sm mb-2"><i class="<?=$data['fwicon']['circle-plus'];?>"></i> Submit</a>
</div>			  
</div>			  
			  
			  </form>
			</div>
	</div> 
	<div class="col-sm-12 border rounded mb-2">
			<div class="row m-2">
			 <h6 class="vkg-underline-red">Buyer's Detail</h6> 
			<?if($show_ui) {?>
				<div class="col-sm-3">Full Name</div>
				<div class="col-sm-9">: <a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select<? if(isset($type)){ ?>&type=<?=$type?><? } ?>&status=-1&keyname=2&searchkey=<?=$post['TransactionDetails']['fullname']?>">
				  <?=$post['TransactionDetails']['fullname']?>
				  </a></div>
				  
				  
				<div class="col-sm-3">Bill Phone</div>
				<div class="col-sm-9">: <a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select<? if(isset($type)){ ?>&type=<?=$type?><? } ?>&status=-1&keyname=5&searchkey=<?=$post['TransactionDetails']['bill_phone']?>">
				  <?=$post['TransactionDetails']['bill_phone']?>
				  </a></div>

				<div class="col-sm-3">Bill Email</div>
				<div class="col-sm-9 ">: 
				
				
				<?
				if($post['TransactionDetails']['typenum']==2||$post['TransactionDetails']['typenum']==3||$post['TransactionDetails']['typenum']==4)
				{
					
					//echo encrypts_decrypts_emails($post['TransactionDetails']['bill_email'],2,true);
				
				}
				else
				{
				
				?>
				
				<a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select<? if(isset($type)){?>&type=<?=$type?><? } ?>&status=-1&keyname=3&searchkey=<?=$post['TransactionDetails']['bill_email']?>"> <?=($post['TransactionDetails']['bill_email']);?>
				  </a>
				  <? } ?>
				  </div>
			<?}?>
			  
			  <?php if($post['TransactionDetails']['upa']){ ?>
			    <div class="col-sm-3">UPA</div>
				<div class="col-sm-9" style="word-break:break-all;">: 
				
					<? if((($post['TransactionDetails']['upa']==991)&&(in_array($post['TransactionDetails']['typenum'],["2","3", "4", "5"])))){ ?>
						<?=jsonvaluef($post['TransactionDetails']['acquirer_response'],'bnameacc');?><b> :: </b><?=jsonvaluef($post['TransactionDetails']['acquirer_response'],'bswift');?>
					<? }else{ ?>
						<?=$post['TransactionDetails']['upa'];?>
					<? } ?>
					
				</div> 
			   <? } ?>
			  
			  <?php if($post['TransactionDetails']['card']){ ?>
				<div class="col-sm-3">CCNo.</div>
				<div class="col-sm-9">: <? $cc_number = card_decrypts256($post['TransactionDetails']['card']);?>
				<?=bclf($cc_number,$post['TransactionDetails']['bin_no']);?>
				
		
	   
				
				
				</div> 
				
				<? if((isset($json_value['bin_bank_name'])&&$json_value['bin_bank_name'])){ ?>
				<div class="col-sm-3">Issuing Bank</div>
				<div class="col-sm-9">: <?=prntext($json_value['bin_bank_name']);?>
					 <?=prntext($json_value['bin_bank_name']?', '.$json_value['bin_bank_name']:'');?></div> 
				<? } ?>
				
			  <? } ?>
			  
			  <?php if($post['TransactionDetails']['json_value'] && $bankName){ ?>
				<div class="col-sm-3">Bank Name</div>
				<div class="col-sm-9">: <?=$bankName;?></div>
				
			  <? } ?>
			  
			  <?php if($post['TransactionDetails']['json_value'] && $upi_vpa_lable){ ?>
				<div class="col-sm-3">UPI</div>
				<div class="col-sm-9">: <?=$upi_vpa_lable;?> : <?=$upi_vpa;?></div>
				  
			  
			  <? } ?>
			  
			  

			<?if($post['TransactionDetails']['mop']){ ?>
				<div class="col-sm-3">MOP</div>
				<div title="<?=$post['TransactionDetails']['mop']?>" class="col-sm-9" style="text-transform:capitalize;text-indent: 0px;margin-left: -7px;">: 
	   			<?
					// dynamic and manual mop icon list 
					$typenum=@$post['TransactionDetails']['typenum'];
					$get_mop=@$post['TransactionDetails']['mop'];
					include($data['Path'].'/include/mop_icon_list'.$data['iex']);
 				?>
				</div>
			<? } ?>
			  
			<?php if(isset($post['TransactionDetails']['rrn'])&&$post['TransactionDetails']['rrn']){ ?>
			    <div class="col-sm-3">RRN</div>
				<div class="col-sm-9">: <?=$post['TransactionDetails']['rrn'];?>
				</div> 
			<? } ?>


                <?php if($post['full_address']){ ?>
			  
				<div class="col-sm-3">Bill Address</div>
				<div class="col-sm-9">: 
				  <?=$post['full_address']?>
				  </div>
			   <? } ?>
			   <? if($is_admin){ ?>
			 
				<div class="col-sm-3">Bill IP</div>
				<div class="col-sm-9">: <a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select<? if(isset($type)){ ?>&type=<?=$type?><? } ?>&status=-1&keyname=18&searchkey=<?=$post['TransactionDetails']['bill_ip']?>">
				  <?=$post['TransactionDetails']['bill_ip']?> <span class="badge bg-primary px-2" title="View Transacrtion From This IP"><?=$post['TransactionDetails']['ip_count']?></span>
				  </a></div>
			  
			  <? } ?>
			  
			  <?php if($post['TransactionDetails']['related_transID']){ 
					$related_transID=jsondecode($post['TransactionDetails']['related_transID'],1);
					if(isset($related_transID['success_transID'])){
						$related_id_success=$related_transID['success_transID'];
				   } 
				  }
				?>
			  
			  
			  <? if(($is_admin)&&((isset($_SESSION['login_adm']))||(isset($_SESSION['json_post_view']))&&$_SESSION['json_post_view']==1)){ ?>

						
						<?php if(isset($related_transID)){ ?>
						 <div class="row">
							<div class="col-sm-6" >
							  <? if(isset($related_id_success)){ ?>
							  <a  href="<?=$data['Admins']?>/<?=$data['trnslist']?><?=$data['ex']?>?action=select&type=-1&status=-1&keyname=1&searchkey=<?=$related_id_success;?><?=(isset($_GET['mview'])?"&bid=".$post['TransactionDetails']['merID']:"");?>" class="btn btn-primary view_json glyphicons file" style="float:left;width:100%;"><i></i><span>View <?=$related_id_success;?> Success</span></a>
							  <? } ?>
							</div>
						  </div>
						<? } ?>
				<? } ?>
			  

			  <div class="riskdivid"></div>
			  <? if(($is_admin)&&((isset($_SESSION['login_adm']))||(isset($_SESSION['transaction_payout'])&&$_SESSION['transaction_payout']==1))){ ?>
			   <div class="row" >
				   <? if($post['TransactionDetails']['typenum']==2){ ?>
				   
				<?/*?>
				   <div class="col-sm-6 my-2">
					<a class="<?=$trans_class;?> btn btn-primary rounded w-100 btn-sm" <?=$trans_datah;?> href="<?=$trans_href;?>?action=select<? if(isset($type)){ ?>&type=<?=$type?><? } ?>&keyname=223&searchkey=<?=$post['TransactionDetails']['transaction_period']?>&bid=<?=$post['TransactionDetails']['merID']?>&id=<?=$post['TransactionDetails']['id']?>&pay_type=2"> View Withdrawal </a>
					</div>
				<?*/?>
					
					
					<? $report_file_name="payout_report";?>
					<div class="col-sm-12">
					<div class="btn-group w-100">
<button type="button" class="btn btn-primary my-2 rounded btn-sm" data-bs-toggle="dropdown" aria-expanded="false" autocomplete="off">
<i class="<?=$data['fwicon']['eye-solid'];?>"></i> Settlement</button>
<ul class="dropdown-menu col-sm-12">
<?/*?>
<li><a onClick="filteraction(this)" target="selltedview" href="<?=$trans_href;?>?action=select<?=$post['wd_payout_date'];?><? if(isset($type)){ ?>&acquirer=<?=$type?><? } ?>&keyname=223&bid=<?=$post['TransactionDetails']['merID']?>&id=<?=$post['TransactionDetails']['id']?>&pay_type=2" class="dropdown-item payoutpdf"><i class="<?=$data['fwicon']['eye-solid'];?>"></i> <span>View </span></a></li>
<?*/?>
<li><a onClick="filteraction(this)" target="_blank" href="<?=$trans_href;?>?action=select<? if(isset($type)){ ?>&type=<?=$type?><? } ?>&keyname=223&searchkey=<?=$post['TransactionDetails']['transaction_period']?>&bid=<?=$post['TransactionDetails']['merID']?>&id=<?=$post['TransactionDetails']['id']?>&pay_type=2" class="dropdown-item payoutpdf"><i class="<?=$data['fwicon']['eye-solid'];?>"></i> <span>View </span></a></li>

<? if(isset($paydLink)&&$paydLink){ ?>
<li><a onClick="filteraction(this)" target="selltedview_wd" data-action="selltedall" data-label="Settled List" data-reason="Settled by SWIFT Reference" data-href="<?=$data['trnslist']?><?=$data['ex']?>?bid=<?=$post['TransactionDetails']['merID']?>&tp=<?=$post['TransactionDetails']['transaction_period']?>&id=<?=$post['TransactionDetails']['id']?><?php echo $common_get;?>&action=payoutsellted&querytype=sellted" class="dropdown-item payoutpdf"><i></i><span>Ok Settled</span></a></li>
<? } ?>

<? if($data['con_name']!='clk'){ ?>
<li><a onClick="filteraction(this)" target="pdfreport_wd" href="<?=$data['Host']?>/trans_dynamic_ac_reporting<?=$data['ex']?>?bid=<?=$post['TransactionDetails']['merID']?>&id=<?=$post['TransactionDetails']['id']?>" class="dropdown-item payoutpdf"><i class="<?=$data['fwicon']['pdf'];?>"></i> File PDF REPORT-A/c.</a></li>
<? } ?>

<li><a onClick="filteraction(this)" target="pdfreport_1_wd" href="<?=$data['Host']?>/trans_db_reporting<?=$data['ex']?>?bid=<?=$post['TransactionDetails']['merID']?>&id=<?=$post['TransactionDetails']['id']?>" class="dropdown-item payoutpdf"><i class="<?=$data['fwicon']['pdf'];?>"></i> File PDF REPORT-TR.</a></li>

<? if($data['con_name']!='clk'){ ?>
<li><a onClick="filteraction(this);popuploadig();" target="hform" href="../transaction_fee_calculation<?=$data['ex']?>?bid=<?=$post['TransactionDetails']['merID']?>&id=<?=$post['TransactionDetails']['id']?>&tp=<?=$post['TransactionDetails']['transaction_period']?><?php echo $common_get; ?>&action=select&querytype=tfcupdate" class="dropdown-item"><i class="<?=$data['fwicon']['setting'];?>"></i> Update</a></li>
<? } ?>							
							

  </ul>
</div>
                    </div>

					
				   <? } ?>
				   <? if(isset($_GET['keyname'])&&$_GET['keyname']==224){ ?>
					<a target="hform" class="" href="<?=$data['Host'];?>/transaction_fee_calculation<?=$data['ex']?>?action=select&id=<?=$post['TransactionDetails']['id']?>&bid=<?=$post['TransactionDetails']['merID']?>">Update Transaction Calculation </a>
				   <? } ?>
				</div>
			  <? } ?>
			</div>
	</div>
	<div class="col-sm-12 border rounded">
			<div class="row m-2">
			  <h6 class="vkg-underline-red">Transaction Details</h6>
			   
			  <? if(($is_admin)&&((isset($_SESSION['login_adm']))||(isset($_SESSION['source_url'])&&$_SESSION['source_url']==1))){ ?>
				  <div class="row is_admin">
					<div class="col-sm-3 ">Source Url </div>
					<div class="col-sm-9 text-break">: <?=$post['TransactionDetails']['source_url']?>
					</div>
				  </div>
			<? } ?>		  
				  <? if((isset($post['TransactionDetails']['bussiness_url'])&&$post['TransactionDetails']['bussiness_url'])){ ?>

				<div class="col-sm-3">Business URL</div>
				<div class="col-sm-9">: <? if($is_admin){ ?>
				  <a <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_add_stores'])&&$_SESSION['merchant_action_add_stores']==1)){ ?> onClick="iframe_open_modal(this);" class="database_plus" data-mid="<?=$post['TransactionDetails']['merID']?>" data-href="" data-tabname="" data-url="" data-ihref="<?=$data['Host'];?>/user/business<?=$data['ex']?>?admin=1&mid=<?=$post['TransactionDetails']['merID']?>&id=<?=$post['TransactionDetails']['terNO']?>&action=view&gid=<?=$post['TransactionDetails']['merID']?>&tempui=<?=$data['frontUiName']?>" <? } ?> title="View TerNO Details" >
				  <span class="badge bg-primary text-white"><?=$post['TransactionDetails']['terNO']?></span></a>
				 <? }else{ ?>
					<? if((strpos($_SESSION['themeName'],'LeftPanel')!==false)&&($is_admin==false)){ ?>
		
					<? }else{ ?>
	
					<a  >
					 <?=$post['TransactionDetails']['terNO']?></a>
					<? } ?>
				 <? } ?>
				 
				  
				  <? if($post['TransactionDetails']['bussiness_url']){ ?>
					 (<?=$post['TransactionDetails']['bussiness_url']?>)
				  <? } ?>
				  
				</div>

			  <? } ?>
			
					
				  
			
			  <? if(($is_admin)&&(isset($_SESSION['login_adm']))){ ?>
				  <div class="row is_admin" style="display:none;background:#e4e3e3;">

							<div class="col-sm-3">TransID</div>
							<div class="col-sm-9">: <?=$post['TransactionDetails']['id']?></div>

							<div class="col-sm-3">TerNO</div>
							<div class="col-sm-9">: <?=$post['TransactionDetails']['terNO']?></div>

							<div class="col-sm-3">Webhook Url </div>
							<div class="col-sm-9">: <?=$post['TransactionDetails']['webhook_url']?></div>

							<?php /*?><div class="col-sm-3">Success Url</div>
							<div class="col-sm-9">: <?=$post['TransactionDetails']['return_url']?></div><?php */?>

						    <div class="col-sm-3">Return Url</div>
						    <div class="col-sm-6">: <?=$post['TransactionDetails']['return_url']?></div>
				 </div>
			  <? } ?>
			  
			  
		
				<div class="col-sm-3">Trans Status</div>
				<div class="col-sm-9">: <?=$post['TransactionDetails']['trans_status']?> 
				</div>
		
			  <? if($post['TransactionDetails']['trans_response']){ ?>
			  
				<div class="col-sm-3">Trans Response</div>
				<div class="col-sm-9">: <?=$post['TransactionDetails']['trans_response']?></div>

			  <? } ?>
			 
			<? if(($is_admin)&&(isset($_SESSION['login_adm']))){ ?>			 
			  <? if(isset($post['TransactionDetails']['dba_brand_name'])&&$post['TransactionDetails']['dba_brand_name']){ ?>
					  <div class="row is_admin">
						<div class="col-sm-3 ">DBA/Brand</div>
						<div class="col-sm-9">: <?=$post['TransactionDetails']['dba_brand_name']?>
						</div>
					  </div>
				  <? } ?>
			<? } ?>
			
			  <? if($post['TransactionDetails']['product_name']){ ?>

				<div class="col-sm-3">Product Name</div>
				<div class="col-sm-9">: <a class="<?=$trans_class;?> text-white" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select<? if(isset($type)){ ?>&type=<?=$type?><? } ?>&status=-1&keyname=16&searchkey=<?=$post['TransactionDetails']['product_name']?>">
				  <?=$post['TransactionDetails']['product_name']?>
				  </a></div>

			  <? } ?>
	<? if($is_admin){ ?>
	
		<div style="clear:both;display:none" class="row my-2">
	<? }else{ ?>
		<div class="row">
	<? } ?>
			  <? if($post['TransactionDetails']['acquirer_ref']&&$is_admin&&((isset($_SESSION['login_adm']))||(isset($_SESSION['acquirer_ref'])&&$_SESSION['acquirer_ref']==1))){ ?>
			  <? if($post['TransactionDetails']['acquirer_ref']){ ?>
 				<div class="col-sm-3">Acquirer Ref </div>
				<div class="col-sm-9">: <?=$post['TransactionDetails']['acquirer_ref']?></div>
				  
				
				
 			  <? } ?>

			 
			 
			
		<? } ?>

			  <? if($post['TransactionDetails']['descriptor']){ ?>
			  
 				<div class="col-sm-3">Descriptor</div>
				<div class="col-sm-9">: <?=$post['TransactionDetails']['descriptor']?></div>
				

			  <? } ?>
			  
			  
<div class="col-sm-3">Bill Amt.(<?=$post['TransactionDetails']['curr_nam']?>) </div>
<div class="col-sm-9">: <a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select<? if(isset($type)){ ?>&type=<?=$type?><? } ?>&status=-1&keyname=4&searchkey=<?=$post['TransactionDetails']['oamount']?>"><?=$post['TransactionDetails']['bill_amt']?>
<? if(($is_admin)&&(trim($post['TransactionDetails']['bank_processing_amount'])&&$post['TransactionDetails']['bank_processing_amount']!='0.00')&&(isset($_SESSION['login_adm']))){ ?>
 (<?=$post['TransactionDetails']['bank_processing_amount']?> <?=$post['TransactionDetails']['bank_processing_curr']?>)<? } ?></a></div>
			 
			 
	<? if((($is_admin)&&((isset($_SESSION['login_adm']))||(isset($_SESSION['t_calculation_row'])&&$_SESSION['t_calculation_row']==1)))||(($_SESSION['login'])&&($post['TransactionDetails']['typenum']==2))){ ?>
	
			  <? if($post['TransactionDetails']['trans_amt']){ ?>
			  
<div class="col-sm-3" title="Trans Amt">Trans Amt(<?=$post['TransactionDetails']['trans_currency']?>) </div>
<div class="col-sm-9">: <?=$post['TransactionDetails']['transaction_amount'];?></div>

			 <? } ?>
			 <? if($post['TransactionDetails']['buy_mdr_amt']&&$post['TransactionDetails']['buy_mdr_amt']!="0"){ ?>
				 
				 
<div class="col-sm-3 " title="Buy MDR Amt">Buy MDR Amt(<?=$post['TransactionDetails']['trans_currency']?>)</div>
<div class="col-sm-9">: <?=$post['TransactionDetails']['buy_mdr_amt'];?></div>
				  
				  
			 <? } ?>
			 <? if($post['TransactionDetails']['buy_txnfee_amt']&&$post['TransactionDetails']['buy_txnfee_amt']!="0"){ ?>

<div class="col-sm-3 " title="Buy TxnFee Amt">Buy TxnFee Amt(<?=$post['TransactionDetails']['trans_currency']?>)</div>
<div class="col-sm-9">: <?=$post['TransactionDetails']['mdr_txtfee_amt2'];?> 
<?php /*?>
<? if($post['TransactionDetails']['fee_details']){ ?> = <em>( <?=$post['TransactionDetails']['fee_details2'];?> )</em>
<? } ?><?php */?>
					

				  </div>
			 <? } ?>
			 <? if($post['TransactionDetails']['rolling_amt']&&$post['TransactionDetails']['rolling_amt']!="0"){ ?>
				 
				 
<div class="col-sm-3 ">Rolling Amt(<?=$post['TransactionDetails']['trans_currency']?>)</div>
<div class="col-sm-9">: <?=$post['TransactionDetails']['rolling_amt2'];?></div>
				  
				  
			 <? } ?>
			 <? if($post['TransactionDetails']['mdr_cbk1_amt']&&$post['TransactionDetails']['mdr_cbk1_amt']!="0"){ ?>
				
				
<div class="col-sm-3 ">MDR cbk1 Amt(<?=$post['TransactionDetails']['trans_currency']?>)</div>
<div class="col-sm-9">: <?=$post['TransactionDetails']['mdr_cbk1_amt2'];?></div>
				 
				 
			 <? } ?>
			 <? if($post['TransactionDetails']['mdr_refundfee_amt']&&$post['TransactionDetails']['mdr_refundfee_amt']!="0"){ ?>
				
				
<div class="col-sm-3 "><?=$data['TransactionStatus'][$post['TransactionDetails']['ostatus']];?> Fee(<?=$post['TransactionDetails']['trans_currency']?>)</div>
<div class="col-sm-9">: <?=$post['TransactionDetails']['mdr_refundfee_amt2'];?></div>
				 
				 
			 <? } ?>
			<? if($post['TransactionDetails']['mdr_cb_amt']&&$post['TransactionDetails']['mdr_cb_amt']!="0"){ ?>
				
				
<div class="col-sm-3 "><?=$data['TransactionStatus'][$post['TransactionDetails']['ostatus']];?> Fee(<?=$post['TransactionDetails']['trans_currency']?>)</div>
<div class="col-sm-9">: <?=$post['TransactionDetails']['mdr_cb_amt2'];?></div>
				  
				  
			 <? } ?>
			 <? if($post['TransactionDetails']['pay_txn']){ ?>
			
<div class="col-sm-3 " title="Payable Amt of Txn">Payable Amt of Txn(<?=$post['TransactionDetails']['payout_curr']?>)</div>
<div class="col-sm-9">: <? if(isset($post['TransactionDetails']['wd_payable_amt_of_txn_from'])&&$post['TransactionDetails']['wd_payable_amt_of_txn_from']){ ?>
				   <?=$post['TransactionDetails']['wd_payable_amt_of_txn_from2']?> =
				<? } ?>
				
				<a class="<?=$trans_class;?>" <?=$trans_datah;?>href="<?=$trans_href;?>?action=select<? if(isset($type)){ ?>&type=<?=$type?><? } ?>&status=-1&keyname=20&searchkey=<?=$post['TransactionDetails']['payable_amt_of_txn']?>">
				  <?=$post['TransactionDetails']['payable_amt_of_txn']?>
				  </a></div>
			  
			 <? } ?>
			 
			 <? if(isset($post['TransactionDetails']['rates'])&&$post['TransactionDetails']['rates']){ ?>
				
					<div class="col-sm-3">Exchange Rate </div>
					<div class="col-sm-9">: <?=$post['TransactionDetails']['rates']?></div>
				
			 <? } ?>
			 
			 
			 
			<? if(isset($post['TransactionDetails']['available_balance_amt'])&&$post['TransactionDetails']['available_balance_amt']){ ?>
				 
					<div class="col-sm-3 ">Available Balance (<?=$post['TransactionDetails']['trans_currency']?>)</div>
					<div class="col-sm-9">: <b><?=$post['TransactionDetails']['available_balance'];?></b></div>
				 
			<? } ?>
			<? if(isset($post['TransactionDetails']['settelement_date'])&&$post['TransactionDetails']['settelement_date']){ ?>
				
					<div class="col-sm-3 ">Settelement Date</div>
					<div class="col-sm-9">: <b><?=prndate($post['TransactionDetails']['settelement_date']);?></b></div>
				
			<? } ?>
			
			
		<? if(isset($post['TransactionDetails']['wd_account_curr'])&&$post['TransactionDetails']['wd_account_curr']){ ?>
				
					<div class="col-sm-3 ">Account Currency</div>
					<div class="col-sm-9">: <?=$post['TransactionDetails']['wd_account_curr'];?></div>
				
				<? } ?>
				
				<? if(isset($post['TransactionDetails']['wd_requested_bank_currency'])&&$post['TransactionDetails']['wd_requested_bank_currency']){ ?>
				
					<div class="col-sm-3 ">Withdrawal Currency</div>
					<div class="col-sm-9">: <?=$post['TransactionDetails']['wd_requested_bank_currency'];?></div>
				 
				<? } ?>
			 
<? } ?>			  
			  <? if($is_admin&&((isset($_SESSION['login_adm']))||(isset($_SESSION['t_a_require'])&&$_SESSION['t_a_require']==1))){ ?>
			
					<div class="col-sm-3  ">Acquirer</div>
					<div class="col-sm-9">: <?=$post['TransactionDetails']['acquirer']?></div>
			
			   <? } ?>
		  
			
			
	</div>
	 <? if($is_admin==true){ ?>
		<a class="btn btn-primary btn-sm view_json99 w-100" onClick="view_next3(this,'','prv','1')" >Expand </a>
	 <? } ?>
			</div>
	

<div class='commentrow99 row mx-2'>
			
<? if($post['TransactionDetails']['system_note']&&$is_admin&&((isset($_SESSION['login_adm']))||(isset($_SESSION['note_system'])&&$_SESSION['note_system']==1))){ ?>

<h6 class="vkg-underline-red">Note System</h6>
			  
<div class="col-sm-12 is_admin text-break clearfix"><?=print_note_system($post['TransactionDetails']['system_note'])?>


				<?php if(isset($related_transID)){ ?>
					
					<div>
					<div class="col-sm-12" ><a href="<?=$data['Admins']?>/<?=$data['trnslist']?><?=$data['ex']?>?action=select&type=-1&status=-1&keyname=1&searchkey=<?=$post['TransactionDetails']['transID']?><?=(isset($_GET['mview'])?"&bid=".$post['TransactionDetails']['merID']:"");?>" style=" clear:both" class="btn btn-primary view_json99"><i></i><span>SORTING</span></a></div>
					<div class="rmk_msg text-break clearfix"><?=$post['TransactionDetails']['related_transID']?></div>
					</div>
						 
					<? } ?>
						
			  <? } ?>
<? if((isset($post['TransactionDetails']['ch_comments'])&&$post['TransactionDetails']['ch_comments'])){ ?>
			  <h6 class="my-2">Merchant Comment :: </h6>
			  
			  
			  <? } ?>
<? if($post['TransactionDetails']['mer_note']){ ?>
			  
			  <h6 class="vkg-underline-red">Note Merchant</h6>
			 <div class="col-sm-12 hide" id="jq_div"><div class="rmk_row"><div class="rmk_date jq_date" title=""></div><div class="rmk_msg jq_desc"></div></div></div>
			  <div class="col-sm-12"><? if($post['TransactionDetails']['remark_status']==1&&$is_admin&&((isset($_SESSION['login_adm']))||(isset($_SESSION['t_add_remark'])&&$_SESSION['t_add_remark']==1))){ ?>
					<!--<a class="addremarklink reply_supports is_admin " onClick="addremarks(this)">Reply Now</a>-->
				<? } ?>
				<?=print_note_system($post['TransactionDetails']['mer_note'])?>
			  
			  <? } ?>
			 
		
			 <? if($is_admin==true){ ?>

				<? if($post['TransactionDetails']['support_note']){ ?>

				 <h6 class="vkg-underline-red mt-1">Note Support</h6>
				 <div class="col-sm-12"><? if($post['TransactionDetails']['remark_status']==2&&empty($is_admin)){ ?>
						<a class="reply_supports">Review Reply</a>
					<? } ?>
					
				  </div>
				 <div class="col-sm-12"><?=print_note_system($post['TransactionDetails']['support_note'])?></div>
				   
				  <? } ?>
			  
			  <? } ?>
			  
			
	

	<? } ?>
	</div>
	</div></div>
	
	</div>
</div>
<script>
	$(".viewthistrans").click(function(){
		var thisText = $(this).text().replace("R","");
		
		top.window.location.href="<?=$data['trnslist']?><?=$data['ex']?>?"+"action=select&keyname=17&searchkey="+thisText+"&type=-1&status=-1&bid=<? if(isset($post['bid'])) echo $post['bid']?>";
	});
	
	$('.add_remark_submit').click(function(){
		//$('#form_popup').slideDown(900);
	});
	<? if($is_admin){ ?>
	$('.ip_view').each(function(){	
		//$(this).replaceWith($('<a class="ip_viewa" onClick="ip_viewf1(this,\'<?=$data['Host']?>/include/ips<?=$data['ex']?>?remote=' + $.trim($(this).text()) + '\')">' + $.trim($(this).text()) + '</a>'));
		$(this).replaceWith($('<a class="ip_viewa" onClick="ip_viewf1(this,\'<?=$data['Host']?>/third_party_api/ips<?=$data['ex']?>?remote=' + $.trim($(this).text()) + '\')">' + $.trim($(this).text()) + '</a>'));	<? // fetch IP detail from rapid api - added on 6-10 ()?>
	});
	/*$('.ip_view').click(function(){	
		var ipurl="<?=$data['Host']?>/include/ips<?=$data['ex']?>?remote=" + $.trim($(this).text());
		var placeurl=$(this).parent().parent().find('.rmk_msg');
		alert(ipurl+"\r\n"+placeurl+"\r\n"+placeurl.html());
		ajaxf2(ipurl,placeurl,1);
	});*/
	<? } ?>
</script>

<? if($post['TransactionDetails']['remark_status']==2&&isset($_SESSION['login'])&&$is_admin==false&&$data['frontUiName']=='ice'){ ?>
<? $_SESSION['mNotificationCount']=$trans_reply_counts=trans_reply_counts($_SESSION['uid'],'1,2');?>
<script>
setTimeout(function(){ 
	if($("#treply_opn_count")){
		$("#treply_opn_count").html("<?=$trans_reply_counts;?>");
	}
}, 200);
</script>
<? } ?>
</body>
</html>

<?php /*?>js for Add mer_note / show / hide transaction detail popup top icon click display<?php */?>
<script>
function redirect_Post5(url, data) {
	var form = document.createElement('form');
	document.body.appendChild(form);
	form.method = 'post';
	form.target = '_blank';
	form.action = url;
	for (var name in data) {
		var input = document.createElement('input');
		input.type = 'hidden';
		input.name = name;
		input.value = data[name];
		form.appendChild(input);
	}
	form.submit();
}
var frontUiName="<?=$data['frontUiName']?>";
function topInViewport1(element) {
	return $(element).offset().top >= $(window).scrollTop() && $(element).offset().top; 
}
 
function autoheightPopUp1(e,contentBody=''){
	//var Ah=(screen.height-150)+'px';
	$(e).removeAttr('style');
	
	var Bh=$(contentBody).height();
	var Ah=Bh+60+'px';
	//alert(frontUiName);
	if (typeof top.window.NameOfFile !== "undefined" && top.window.NameOfFile=="withdraw-fund-list" ) {
		vp=vp-77;
	 //alert('\r\n marginTop=>'+vp+'\r\n height=>'+Ah+'\r\n NameOfFile=>'+top.window.NameOfFile);
	} 
	
	if(frontUiName=='ruby'){
		vp=vp-40;
	}

	var vp_1=vp+20+'px'; 
	
	
	$(e).animate({height:Ah,marginTop:vp_1}, 1000);
}
<? if($is_admin==false){ ?>
$(document).ready(function(){
	autoheightPopUp1('.modalpopup_body','#modalpopup_cdiv');
	
	
	
});
<? } ?>

$("#sub_remark").click(function(){
var gdata=$("#gdesc").val();
var gid=$("#p_gid").val();
var mtype=$('input[name="reply_type"]:checked').val();

  $.ajax({
		type: "POST",
		url: "../include/add_remarks<?=$data['ex'];?>",
		data: { gdata: gdata, gid : gid, mtype : mtype } 
	}).done(function(data){
		//alert(data);
		if(data=="done"){
		$("#gmsg").html("<b>Data Submitted Successfully</b>");
		$("#gdesc").val("");
		}else{
		$("#gmsg").html("<b>Data Not Submitted Try Again</b>");
		}
		
	});
});


function collapse_close_all(gdata){
	//alert(gdata);

	if(gdata=="collapsePayloadJson"){
		$('#collapseAcquierResponseJson').removeClass('show');
		$('#collapsePushNotify').removeClass('show');
		$('#addremarkform').css('display', 'none');

		$('#collapseAcquierResponseJsonlavel').attr("aria-expanded","false");
		$('#collapsePushNotifylavel').attr("aria-expanded","false");
		$('#addremarklinklavel').attr("aria-expanded","false");
		$('#addremarklinklavel').removeClass('active');

	}else if(gdata=="collapseAcquierResponseJson"){
		$('#collapsePayloadJson').removeClass('show');
		$('#collapsePushNotify').removeClass('show');
		$('#addremarkform').css('display', 'none');


		$('#collapsePayloadJsonlavel').attr("aria-expanded","false");
		$('#collapsePushNotifylavel').attr("aria-expanded","false");
		$('#addremarklinklavel').attr("aria-expanded","false");
		$('#addremarklinklavel').removeClass('active');

	}else if(gdata=="collapsePushNotify"){
		$('#collapsePayloadJson').removeClass('show');
		$('#collapseAcquierResponseJson').removeClass('show');
		$('#addremarkform').css('display', 'none');

		$('#collapsePayloadJsonlavel').attr("aria-expanded","false");
		$('#collapseAcquierResponseJsonlavel').attr("aria-expanded","false");
		$('#addremarklinklavel').attr("aria-expanded","false");
		$('#addremarklinklavel').removeClass('active');

		}else if(gdata=="addremarklinklavel"){
		$('#collapsePayloadJson').removeClass('show');
		$('#collapseAcquierResponseJson').removeClass('show');
		$('#collapsePushNotify').removeClass('show');

		$('#collapsePayloadJsonlavel').attr("aria-expanded","false");
		$('#collapseAcquierResponseJsonlavel').attr("aria-expanded","false");
		$('#collapsePushNotifylavel').attr("aria-expanded","false");

	}else if(gdata=="targetvkg"){
		$('#targetvkg').attr("aria-expanded","false");
		$('#targetvkg').removeClass('active');

		$('#collapsePayloadJsonlavel').attr("aria-expanded","false");
		$('#collapseAcquierResponseJsonlavel').attr("aria-expanded","false");
		$('#collapsePushNotifylavel').attr("aria-expanded","false");
		$('#addremarklinklavel').attr("aria-expanded","false");

	}else if(gdata=="acqresp"){
		$('#acqresp').attr("aria-expanded","false");
		$('#acqresp').removeClass('active');

		$('#collapsePayloadJsonlavel').attr("aria-expanded","false");
		$('#collapseAcquierResponseJsonlavel').attr("aria-expanded","false");
		$('#collapsePushNotifylavel').attr("aria-expanded","false");
		$('#addremarklinklavel').attr("aria-expanded","false");
	}
	//$('#addremarkform').css('display', 'none');
	//$('#'+gdata).addClass('show');
}

function popup_openv1(url,json1='',payload_stage1='',response1='',response2=''){
	if(json1&&payload_stage1){
		var urlJsn={"json":json1,"payload_stage1":payload_stage1,"response1":response1,"response2":response2};
		if(typeof(wn) != 'undefined' && wn != null && wn ==2)
		{
			redirect_Post5(url,urlJsn);	
		}
		else {
			$('#myModal9').modal('show').find('.modal-body').load(url,urlJsn);
		}
	}
	else if(json1){
		var urlJsn={"json":json1};
		if(typeof(wn) != 'undefined' && wn != null && wn ==2)
		{
			redirect_Post5(url,urlJsn);	
		}
		else {
			$('#myModal9').modal('show').find('.modal-body').load(url,urlJsn);
		}
		
	}else{
		$('#myModal9').modal('show').find('.modal-body').load(url);
	}
	$('#myModal9 .modal-dialog').css({"max-width":"80%"});
}

</script>
<? db_disconnect();?>