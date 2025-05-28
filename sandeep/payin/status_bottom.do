<?
//if(isset($td)&&isset($td['transID'])&&trim($td['transID'])){
?>
<? /*?>
<script>
// code for open popup to update transaction amount and status
$('.status_modal').click(function(){
	var detailHtml=$('#update_trans').html();
	var Modtitle="Update Transaction";
	$('#myModal9').css({"z-index":"99999999"});
	$('#myModal9 .modal-dialog').css({"max-width":"600px", "margin-top": "5px"});
	$('#myModal9 .modal-title').html(Modtitle);
	$('#myModal9 .modal-body').html(detailHtml);
	$('#myModal9').modal('show');
	$('#upd_status').attr('disabled','disabled')
	$('#submit').attr('disabled','disabled')
});
</script>
<? */?>

<?
if(isset($td['transID'])&&trim($td['transID'])&&(empty($transID) || !isset($transID))){
	if(trim($td['transID'])) $transID=$td['transID'];
}
if($qp){
	echo "<br/><br/>transID on bottom =>".$transID;
}


if(!isset($integrationType)&&isset($td['json_value'])){
	$integrationType=jsonvaluef($td['json_value'],'integration-type');
}

$upd_field=isset($upd_field)&&$upd_field?$upd_field:'';

// start : include_status_bottom

//start: cron step: 1 -----------------------------------------

	if(isset($_SESSION['acquirer_response'])){
		$_SESSION['acquirer_response']=str_replace('N/A - ','',$_SESSION['acquirer_response']);
	}
	
	
		
		
	//Dev Tech : 23-05-10 Auto Expired  - if trans_status is 0 pending and not included on acquirer status page than include for status expired  
	//if((!isset($expired_times_count))&&((!isset($_SESSION['acquirer_status_code']))||(isset($_SESSION['acquirer_status_code'])&&$_SESSION['acquirer_status_code']==1)))
		
	if( (@$is_expired=='Y') && ((!isset($_SESSION['acquirer_status_code']))||(isset($_SESSION['acquirer_status_code'])&&$_SESSION['acquirer_status_code']==1)) )
	{	
		include($data['Path'].'/payin/status_expired'.$data['iex']); 
		
		if($qp)
		{
			echo "<hr/>expired_times_count=>".$expired_times_count;
			echo "<hr/>acquirer_status_code=>".$_SESSION['acquirer_status_code'];
			echo "<hr/>acquirer_response=>".$_SESSION['acquirer_response'];
		}
	}
	
	
	
// Dev Tech : 23-08-16  condation for Check Bank Processing Amount and Trans Amt are same or not
if(isset($_SESSION['bank_processing_amount'])&&$_SESSION['bank_processing_amount']&&isset($_SESSION['responseAmount'])&&$_SESSION['responseAmount']&&$_SESSION['bank_processing_amount']<>""&&isset($_SESSION['acquirer_status_code'])&&$_SESSION['acquirer_status_code']==2){

	if($_SESSION['bank_processing_amount'] <> $_SESSION['responseAmount']){
		$_SESSION['bank_processing_amount_equal_to_acquirer_response_amount']=1;
		$_SESSION['acquirer_status_code']=1;
		
		$_SESSION['acquirer_response']=" Under Pending - Reason: Update Status With Amount [".$_SESSION['acquirer_response']."]. Bank Processing Amount :: ".$_SESSION['bank_processing_amount']." & Bank Response Amount ::  ".$_SESSION['responseAmount'];
	}

}


	$data_send=array();
	$data_send['transID']=@$transID;
	$data_send['acquirer_action']=(isset($_SESSION['acquirer_action'])?$_SESSION['acquirer_action']:'');
	$data_send['acquirer_response']=(isset($_SESSION['acquirer_response'])?$_SESSION['acquirer_response']:'');
	$data_send['acquirer_status_code']=(isset($_SESSION['acquirer_status_code'])?$_SESSION['acquirer_status_code']:'1');
	$data_send['acquirer_transaction_id']=(isset($_SESSION['acquirer_transaction_id'])?$_SESSION['acquirer_transaction_id']:'');
	$data_send['acquirer_descriptor']=(isset($_SESSION['acquirer_descriptor'])?$_SESSION['acquirer_descriptor']:'');
	$data_send['acquirer']=@$td['acquirer'];
	$data_send['admin']='1';

	if(isset($_SESSION['curl_values'])&&is_array($_SESSION['curl_values'])) {
		$curl_values_data=strip_tags_d($_SESSION['curl_values']);
		$_SESSION['curl_values']=jsonencode($curl_values_data,1,1);
	}

	if(isset($_SESSION['curl_values'])) $data_send['curl_values'] =$_SESSION['curl_values'];
//end: cron step: 1 -----------------------------------------

	//db_disconnect();
	$data_send = strip_tags_d($data_send);
	
	//Dev Tech : 23-02-04 modify the style
	
	if($data_send['acquirer_status_code']==2){ //success
		$return_url = $host_path."/return_url{$r2}{$data['ex']}?transID=$transID&action=redirect".$subQuery;
		$style='background:#008000!important;color:#fff!important;';
		$cls="btn btn-success w-100";
	}
	elseif($data_send['acquirer_status_code']==1){ //pending
		if(isset($_SESSION['adm_login'])){
			$return_url = 'javascript:alert("'.$data_send['acquirer_response'].'");';
			
		}
		//elseif($integrationType==strtolower("encode-checkout"))
		else
		{
			$return_url = @$host_path."/trans_processing{$r2}{$data['ex']}?transID=".@$transID."&action=redirect".@$subQuery;
		}
		//$onclick='javascript:top.popupclose();';
		$style='background:#ffa500!important;color:#fff!important;';
		$cls="btn btn-warning w-100";
	}
	elseif(($data_send['acquirer_status_code']==22||$data_send['acquirer_status_code']==23)&&(isset($_SESSION['adm_login'])&&(!empty($_SESSION['adm_login'])))){ //expired
		$return_url = $host_path."/return_url{$r2}{$data['ex']}?transID=$transID&action=expired".$subQuery;
		$style='background:#ff0000!important;color:#fff!important;';
		$cls="btn btn-danger w-100";
	}
	else{ //failed
		$return_url = $host_path."/return_url{$r2}{$data['ex']}?transID=$transID&action=redirect".$subQuery;
		$style='background:#ff0000!important;color:#fff!important;';
		$cls="btn btn-danger w-100";
	}
	
	
	
	
	
	
	
	
	
	//Dev Tech : 23-03-22 stop the redirect on url of merchant like webhook, success & etc and stop email 
	if(isset($_REQUEST['no_merchant_redirect'])){
		$data_send['tr_trans_status']=$td['trans_status'];
		$data_send['tr_transID']=$td['transID'];
		$data_send['return_url']=$return_url;
		json_print($data_send);
	}


	//email check for webhook etc 
	if(isset($data['status_in_email'])&&$data['status_in_email']){
		include('status_in_email'.$data['iex']);
	}
	
	

			
	if($qp)
	{
		echo "<hr/>is_admin=>".$is_admin;
		if(isset($_REQUEST['actionurl'])) echo "<hr/>actionurl=>".$_REQUEST['actionurl'];
	
		echo "<hr/>acquirer_status_code=>".$data_send['acquirer_status_code'];
		echo "<hr/>info=>".$data_send['acquirer_response'];
		echo "<hr/>return_url=>".$return_url;
		echo "<hr/>results=>";print_r($results);
		exit;
	}
	if(isset($_GET['check_auth'])&&$_GET['check_auth'])
	{
		$is_admin = false;
	}
	if($is_admin==false){
		// Dev Tech : 23-01-25 modify for check the callbacks url is not empaty 
		$return_url_exist=[];
		if(isset($return_url)&&trim($return_url)){
			$return_url_exist = @get_headers($return_url);
		}
		if((isset($return_url_exist[0])&&strpos(@$return_url_exist[0],'404') !== false) || (empty($return_url)))
		{
			$err_404=[];
			$err_404['Error']="404";
			$err_404['Message']="404 Page not found via ".@$transID;
			$err_404['return_url']=$return_url;
			json_print($err_404);
		}
		else
		{
			if((isset($_REQUEST['actionurl'])&&$_REQUEST['actionurl']=='notify')||(isset($_REQUEST['action'])&&($_REQUEST['action']=='notify' || $_REQUEST['action']=='webhook'))){
				$use_curl=use_curl($return_url,$data_send);
				exit;
			}else{
				post_redirect($return_url, $data_send);
			}
		}
	}



	##### admin status #######################################
	
	//Dev Tech : 23-03-22 retrun response when cron host 
	if(isset($_REQUEST['cron_host_response'])){
		$data_send['tr_trans_status']=$td['trans_status'];
		$data_send['tr_transID']=$td['transID'];
		$data_send['return_url']=$return_url;
		
		header("Content-Type: application/json", true);	
		echo $arrayEncoded2 = jsonencode($data_send);
	}

	//json
	if((isset($_REQUEST['json']))&&(!empty($_REQUEST['json']))){
		$json["acquirer_status_code"]=$data_send['acquirer_status_code'];
		$json["return_url"]=$return_url;

		header("Content-Type: application/json", true);
		echo json_encode($json);
		exit;
	}
	
	
	
	if($is_admin){
		if((isset($_REQUEST['actionurl']))&&($_REQUEST['actionurl']=="merchant"||$_REQUEST['actionurl']=="customer"||$_REQUEST['actionurl']=="admin_direct")){
			//echo $return_url;
			if($data_send['acquirer_status_code']==1){
				exit;
			}else{
				//start: cron step: 2 --------------------
				if($_REQUEST['actionurl']=="admin_direct"){
					// Dev Tech : 23-01-25 modify for check the callbacks url is not empaty 
					if(!empty($return_url)&&trim($return_url))
						$use_curl=use_curl($return_url,$data_send);
					exit;
				} //end: cron step: 2 --------------------
				else{
					// Dev Tech : 23-01-25 modify for check the callbacks url is not empaty 
					
					if(!empty($return_url)&&trim($return_url))
						post_redirect($return_url, $data_send);

					//header("location:$return_url");
				}
			}
		}

		if ((strpos ( $return_url, $_SERVER['SERVER_NAME'] ) !== false) ){

		}else{
			$return_url=str_replace('actionurl=by_admin','actionurl=admin_direct',$data['urlpath']);
		}


// Dev Tech : 23-02-03 modify for Grid - columns wise  

		echo "<div class='hk_sts' style1='padding:10px 1.5%;'>";
		
		if(isset($data_send['acquirer_status_code'])){
		   //if in differerence in amount then I've bank_processing_amount_equal_to_acquirer_response_amount in status.do of related acquier, but if already approved then this section not to be execute
			if(isset($_SESSION['bank_processing_amount_equal_to_acquirer_response_amount'])&&$_SESSION['bank_processing_amount_equal_to_acquirer_response_amount']&&$td['trans_status']!=1)
			{ 
				unset($_SESSION['bank_processing_amount_equal_to_acquirer_response_amount']);	//unset bank_processing_amount_equal_to_acquirer_response_amount from $_SESSION

				//$_SESSION['bank_processing_amount']='0.01';

				if($_SESSION['bank_processing_amount'] <> $_SESSION['responseAmount'])
				{
					$upd_field='disabled="disabled"';
				}
				echo "<a class='upd_status status_modal {$cls}' style='{$style}' >Update Status With Amount [<b>".$data_send['acquirer_response']."</b>]<br>Bank Processing Amount :: ".$_SESSION['bank_processing_amount']." & Bank Response Amount ::  ".$_SESSION['responseAmount']."
				
				</a>";
				
				
				
			}elseif(isset($td['trans_status'])&&$td['trans_status']==1){
			echo "<div href='$return_url' class='upd_status {$cls}' style='{$style}' >Status [<b>".$data_send['acquirer_response']."</b>]</div>";
			}else{
				echo "<a target='hform' onclick='{$onclick}' href='$return_url' class='upd_status {$cls}' style='{$style}'>Update Status [<b>".$data_send['acquirer_response']."</b>]</a>";
			}
		
		}else{
			if(isset($bank_status_limit)&&$bank_status_limit){
				echo "<a class='upd_status' style='{$style}'>transaction not found <b style='color:red!important;'>please recheck after 1 minutes</b>"."</a>";
			}else{
				echo "<a target='hform' onclick='{$onclick}' href='$return_url' class='upd_status' style='{$style}'>transaction not found [<b>Proceed to Cancelled </b>]"."</a>";
			}
			
		}
		?>
		
		<?
		/*this form use for if the the difference in the transaction amount and response amount
		1. Pass bank_processing_amount and responseAmount, and current in DB via hidden fields
		2. New amount for update to be enter and reason in remark fields
		3. To Select new  status 
		*/
		?>
		<div class='w-100 my-2 hide1' id="update_trans">
			<form action="<?=$data['Host']?>/<?=$data['AdminFolder']?>/trnslist<?=$data['ex']?>?action=upd_response_amt" method="post" name="fa">
				<input type="hidden" name="gid" value="<?=$td['id'];?>" />
				<input type="hidden" name="actual_status" value="<?=$td['trans_status'];?>" />
				<input type="hidden" name="bank_processing_amount" value="<?=@$_SESSION['bank_processing_amount'];?>" />
				<input type="hidden" name="received_amount" value="<?=@$_SESSION['responseAmount'];?>" />
				<input type="hidden" name="re_direct_url" value="<?=@$_SERVER['HTTP_REFERER'];?>" />
				
				<div class="row">
					<div class="col">
						<label>Update amount:</label> 
						<input type="text" name="new_amount" class="form-control w-100 my-2" value="<?=@$_SESSION['responseAmount'];?>" required1 />
					</div>
					<div class="col">
						<label>Status:</label>
					<select name="upd_status" class="form-select w-100  my-2">
						<option value="0" <? if($td['trans_status']==0) echo 'selected';?>>Pending</option>
						<option value="1" <? if($td['trans_status']==1 || $data_send['acquirer_status_code']==2 ) echo 'selected';?>>Approved</option>
						<option value="2" <? if($td['trans_status']==-1 || $data_send['acquirer_status_code']==-1 ) echo 'selected';?>>Declined</option>
						<option value="23" <? if($td['trans_status']==23 || $data_send['acquirer_status_code']==23) echo 'selected';?>>Cancelled</option>
						<? 
						//if(!($td['trans_status']==1||$td['trans_status']==23||$td['trans_status']==2))	//if transaction already approved or cancel then we can make scrubbed or Expired of this transaction
						{
						?>
						<option value="22" <? if($td['trans_status']==22 || $data_send['acquirer_status_code']==22) echo 'selected';?>>Expired</option>
						<option value="10" <? if($td['trans_status']==10) echo 'selected';?>>Scrubbed</option>
						<?
						}?>
					</select>
					</div>
					<div class="col">
						<label>Remark:</label>
						<input type="remark" name="new_remark" value="<?=@$data_send['acquirer_response']?>" placeholder="Remark" class="form-control w-100 my-2" required1 />
					</div>
				</div>
				<input type="submit" name="submit" value="Update" class="btn btn-primary w-100 my-2">
			</form>
		</div>

		<?
		/*this form use to update status forcely by admin
		
		*/
		?>
		
		<div class='w-100 my-2 border rounded clearfix p-2 alert hide' id="update_status" style="background:<?=$_SESSION['background_gl7'];?>">
		<form action="<?=$data['Host']?>/<?=$data['AdminFolder']?>/trnslist<?=$data['ex']?>?action=upd_status" method="post">
			<input type="hidden" name="gid" value="<?=$td['id'];?>" />
			<input type="hidden" name="actual_status" value="<?=$td['trans_status'];?>" />
			<div><label class='form-label'>OR Update As A :</label></div>
			<div class="row">
			<div class="col">
			<select name="upd_status" id="upd_status"  class="form-select" <?=$upd_field;?>>
				<option value="0" <? if($td['trans_status']==0) echo 'selected';?>>Pending</option>
				<option value="1" <? if($td['trans_status']==1) echo 'selected';?>>Approved</option>
				<option value="2" <? if($td['trans_status']==2) echo 'selected';?>>Declined</option>
				
				<option value="23" <? if($td['trans_status']==23) echo 'selected';?>>Cancelled</option>
				<? 
				if(!($td['trans_status']==1||$td['trans_status']==23||$td['trans_status']==2))	//if transaction already approved or cancel then we can make scrubbed or Expired of this transaction
				{
				?>
				<option value="22" <? if($td['trans_status']==22) echo 'selected';?>>Expired</option>
				<option value="10" <? if($td['trans_status']==10) echo 'selected';?>>Scrubbed</option>
				<?
				}?>
			</select>
			</div><div class="col">
			<input type="submit" name="submit" id="submit" class="btn btn-primary w-100" value="Update" <?=$upd_field;?>>
			</div>
			</div>
			
		</form></div>
		<br /></div>
		
		<?
		
		echo "<div class='row rounded border px-1'>";

		if(isset($results)) display_nested_array($results);
							
		echo "</div>";
		
		
		
		

		
		echo "<div class='row rounded border my-2 px-1'>";
		echo "<div class='col-sm-4 fw-bold'><strong>Acquirer Status Code:</strong></div> <div class='col-sm-8'>".$data_send['acquirer_status_code']." [".$data_send['acquirer_response']."] </div>" ;
		echo "<div class='col-sm-4 fw-bold'><b>Acquirer Transaction ID:</b></div> <div class='col-sm-8'>".$data_send['acquirer_transaction_id']."</div>" ;
        if(isset($data_send['acquirer_descriptor'])&&trim($data_send['acquirer_descriptor']))
		echo "<div class='col-sm-4 fw-bold'><b>Acquirer Descriptor:</div> <div class='col-sm-8'>".$data_send['acquirer_descriptor']."</div>" ;
		echo "<div class='col-sm-4 fw-bold'><b>Acquirer Response:</b></div> <div class='col-sm-8'>".$data_send['acquirer_response']."</div>" ;
		echo "<div class='col-sm-4 fw-bold'><b>transID:</b></div> <div class='col-sm-8'>".$transID."</div>" ;

	
		if(isset($site_id))
			echo "<div class='col-sm-4 fw-bold'>site_id:</div> <div class='col-sm-8'>".$site_id."</div>" ;

		echo "</div>";
	}
	
//}
exit;

// end : include_status_bottom


?>