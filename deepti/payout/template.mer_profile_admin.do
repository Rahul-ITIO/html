<??>

<div class="col m-col">
	<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['show_payout_request'])&&$_SESSION['show_payout_request']==1)){?>
	
	<label for="vtid">Payout Gateway</label>
	<!--oninvalid="alert('Please Select Payout Request');"-->
	<select name="payout_request" id="payout_request" class="form-select w-100" title="Payout Request" >
		<option value="">Payout Gateway</option>
		<option value="1">Live</option>
		<option value="2">Test</option>
		<option value="3">Inactive</option>
	</select>
	<? if(isset($post['MemberInfo']['payout_request'])){ ?>
	<script>$('#payout_request option[value="<?=$post['MemberInfo']['payout_request']?>"]').prop('selected','selected');</script>
	<? } ?>
 <? } ?>
</div>


<? ############## Payout Scrubbed Period ?>
				
<div class="my-2" id="Payout_Scrubbed_Period">
	<div class="row text-start vkg border border-primary bg-vlight rounded" >
		<div class="row col-sm-12 my-2">
			<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['show_payout_fee'])&&$_SESSION['show_payout_fee']==1)){ ?>
			<div class="col">
				<label for="gst_fee" style="clear:left;">Payout Fee</label>
				<div class="input-group mb-2">
					<input type="text" name="payoutFee" id="payoutFee" class="form-control"  value="<?php if(isset($post['payoutFee'])&&$post['payoutFee']){echo number_formatf_2(stf($post['MemberInfo']['payoutFee']));}else{echo number_formatf_2(stf($payoutFee));}?>" />
					<span class="input-group-text" id="basic-addon1">&nbsp;%&nbsp;</span> </div>
	   		</div>
		<? } ?>
		<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['show_payout_account'])&&$_SESSION['show_payout_account']==1)){?>				
			<div class="col">
				<label for="gst_fee" style="clear:left;">Payout A/C</label>
				<div class="input-group mb-2">
					<select name="payout_account" id="payout_account" class="form-select w-100">
					<option value="">Payout A/C</option>
					<? 
					$bank_list=db_rows("SELECT `id`,`payout_id`,`payout_json`
						FROM `{$data['DbPrefix']}bank_payout_table` 
						$where_clause ORDER BY id",$qprint
					);
					foreach ($bank_list as $key => $val) {
						$b_id			= $val['id'];
						$b_payout_id	= $val['payout_id'];
						$payout_json_a= json_decode($val['payout_json'],1);
						$b_ch_name		= $payout_json_a['checkout_level_name'];
						?>
						<option value="<?=$b_id?>"> <?=$b_payout_id;?> <?=$b_ch_name;?></option>
						<? } ?>
					</select>
					<? if(isset($post['MemberInfo']['payout_account'])) { ?>
						<script>$('#payout_account option[value="<?=$post['MemberInfo']['payout_account']?>"]').prop('selected','selected');</script>
					<? } ?>
				</div>
			</div>
		<? } ?>	
		<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['show_payout_keys'])&&$_SESSION['show_payout_keys']==1)){?>
	  <div class="col">
	<?php if(isset($post['payout_secret_key'])&&$post['payout_secret_key']){ ?>
	<a class="btn btn-primary text-start" title="Payout Secret Key Generated" style="margin-top: 21px !important;"><i class="far fa-check-circle"></i></a>
	<?
				  if(isset($_SESSION['login_adm'])&&$_SESSION['login_adm']&&$post['payout_secret_key']){?>
	<a class="btn btn-primary text-start" onclick="return confirm_remove(this, <?=$post['gid']?>);" title="Remove Payout Secret Key" style="margin-top: 21px !important;"><i class="fas fa-times-circle"></i></a>
	<? }
				 }else{ ?>
	<a class="btn btn-primary text-start" title="Payout Secret Key Not Generated" style="margin-top: 21px !important;"><i class="far fa-times-circle"></i></a>
	<? } ?>
	<?php if(isset($post['payout_token'])&&$post['payout_token']){ ?>
	<b id="generate_api_token" class="hide"><?php if(isset($post['payout_token'])&&$post['payout_token']){echo $post['payout_token'];}else{echo $payout_token;}?></b>
	
	 <a class="btn btn-primary float-end text-start" title="Copy Payout API Token - <?php if(isset($post['payout_token'])&&$post['payout_token']){echo $post['payout_token'];}else{echo $payout_token;}?>" onclick="CopyToClipboard2('#generate_api_token')" style="margin-top: 21px !important;"> <i class="fas fa-copy"></i> </a>
	<? }else{ ?>
	<a class="btn btn-primary float-end mx-1" title="Payout Token Not Generated" style="margin-top: 21px !important;"><i class="fas fa-file-excel"></i></a>
	<? } ?>
  </div>
	  <? } ?>
  </div>
  
  
	<div class="row col-sm-6 my-2" >
	  <div class="col-sm-4">
		<label title="Scrubbed Period">Scrubbed Period: <i class="fa-solid fa-star-of-life  text-danger"></i></label>
	  </div>
	  <div class="col-sm-8">
		<select name="scrubbed_period" id="p_scrubbed_period" title="Scrubbed Period" class="form-select" oninvalid="alert('Please Select Scrubbed Period');">
		  <option value="">Select Scrubbed Period</option>
		  <option value="1">1 Day</option>
		  <option value="7">7 Days</option>
		  <option value="15">15 Days</option>
		  <option value="30">30 Days</option>
		  <option value="90">90 Days</option>
		</select>
		<?
		if(isset($post['scrubbed_period']))
		{
		?>
			<script>$('#p_scrubbed_period option[value="<?=$post['scrubbed_period']?>"]').prop('selected','selected');</script>
		<?
		}?>
	  </div>
	</div>
	<div class="row col-sm-6 my-2">
	  <div class="col-sm-4">
		<label title="Min Trxn Limit:">Min Trxn Limit: <i class="fa-solid fa-star-of-life  text-danger"></i></label>
	  </div>
	  <div class="col-sm-8">
		<input type="text" name="min_limit" id="p_min_limit" class="form-control" title="Min Trxn Limit" value="<?=(isset($post['min_limit'])?$post['min_limit']:'');?>" oninvalid="alert('Please Fill Min Trxn Limit');">
	  </div>
	</div>
	<div class="row col-sm-6 my-2">
	  <div class="col-sm-4">
		<label title="Max Trxn Limit">Max Trxn Limit: <i class="fa-solid fa-star-of-life  text-danger"></i></label>
	  </div>
	  <div class="col-sm-8">
		<input type="text" name="max_limit" id="p_max_limit" class="form-control" value="<?=(isset($post['max_limit'])?$post['max_limit']:'');?>"  oninvalid="alert('Please Fill Max Trxn Limit');" >
	  </div>
	</div>
	<div class="row col-sm-6 my-2">
	  <div class="col-sm-4">
		<label title="Min. Success Count">Min Success Count: <i class="fa-solid fa-star-of-life  text-danger"></i></label>
	  </div>
	  <div class="col-sm-8">
		<input type="text" name="tr_scrub_success_count" id="p_tr_scrub_success_count" class="form-control" value="<?=(isset($post['tr_scrub_success_count'])&&$post['tr_scrub_success_count'])?$post['tr_scrub_success_count']:'2'?>" oninvalid="alert('Please Fill Min. Success Count');" >
	  </div>
	</div>
	<div class="row col-sm-6 my-2" >
	  <div class="col-sm-4">
		<label title="Min. Failed Count">Min. Failed Count: <i class="fa-solid fa-star-of-life  text-danger"></i></label>
	  </div>
	  <div class="col-sm-8">
		<input type="text" name="tr_scrub_failed_count" id="p_tr_scrub_failed_count" class="form-control" value="<?=(isset($post['tr_scrub_failed_count'])&&$post['tr_scrub_failed_count'])?$post['tr_scrub_failed_count']:'5'?>" oninvalid="alert('Please Fill Min. Failed Count');">
	  </div>
	</div>
	<div class="row col-sm-6 my-2" >
	  <div class="col-sm-4">
		<label title="Min. Failed Count">Whitelisted IPs:<br />
		Seperated by Comma (,)</label>
	  </div>
			<div class="col-sm-8">
				<textarea name="whitelisted_ips" id="p_whitelisted_ips" class="textAreaAdjust form-control"><?=(isset($post['whitelisted_ips'])&&$post['whitelisted_ips'])?$post['whitelisted_ips']:'';?>
</textarea>
			</div>
		</div>
	</div>
</div>
<script>
<?
if((isset($post['MemberInfo']['payout_request'])&&($post['MemberInfo']['payout_request']==3)) || $post['MemberInfo']['payout_request']=="") {
?>
	$("#Payout_Scrubbed_Period").hide();
<?
}else{
?>
	$("#p_scrubbed_period").attr("required","required");
	$("#payout_account").attr("required","required");
	$("#p_min_limit").attr("required","required");
	$("#p_max_limit").attr("required","required");
	$("#p_tr_scrub_success_count").attr("required","required");
	$("#p_tr_scrub_failed_count").attr("required","required");
<? } ?>

$("#payout_request").change(function(){
	if($(this).val()==3||$(this).val()==''){
		$("#Payout_Scrubbed_Period" ).hide(1000);
		$("#p_scrubbed_period").removeAttr("required","required");
		$("#payout_account").removeAttr("required","required");
		$("#p_min_limit").removeAttr("required","required");
		$("#p_max_limit").removeAttr("required","required");
		$("#p_tr_scrub_success_count").removeAttr("required","required");
		$("#p_tr_scrub_failed_count").removeAttr("required","required");
	}else{
		$("#Payout_Scrubbed_Period" ).show(1000);
		$("#p_scrubbed_period").attr("required","required");
		$("#payout_account").attr("required","required");
		$("#p_min_limit").attr("required","required");
		$("#p_max_limit").attr("required","required");
		$("#p_tr_scrub_success_count").attr("required","required");
		$("#p_tr_scrub_failed_count").attr("required","required");
	}
});
</script>
