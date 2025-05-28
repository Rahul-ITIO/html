<?
//70 (ICE (Indian Customs Electronic Gateway) ) , 711 (Collect) - Indusind bank 
	$tr_upd_order=array();
	$tr_upd_order=$apc_get;
	
	
	$apc_get['Account-number'].=$_SESSION['transID'];

	################################################
	//host url
	if($_SESSION['b_'.$acquirer]['bank_process_url']){
		$bank_process_url=$_SESSION['b_'.$acquirer]['bank_process_url'];
	}else{
		$bank_process_url=$data['HostG'];
	}

	$apc_get['bank_process_url']=$bank_process_url;
	
	$check_status = "bankstatus{$data['ex']}?transID=".$_SESSION['transID'];	//status url
	$redirect_status_url = "{$bank_process_url}/bankstatus{$data['ex']}?transID=".$_SESSION['transID']."&action=webhook";	//redirect url
	$fetch_iec = $status_url;	//redirect url
	

	$server_callback_url = $webhook_url;	//callback url
	
	if($data['localhosts']==true){	//set webhook as a callback url if execute from localhost
		$server_callback_url="https://webhook.site/582372d8-e11d-4e89-bd31-3777c63f6844";
	}

		
	##############-- SECTION ACCESS BY LIBRARY -- ##################
	//require_once 'post.php';

	
	//trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);

	if($acquirer==71)  // ice 	//for QR dynamic code
	{
		$json_arr_set['html_data']="<div class='row'><div class='col-4 text-end pe-2'>Ben Name : </div><div class='col'><strong>{$apc_get['Account-name']}</strong></div></div><div class='row my-2'><div class='col-4 text-end pe-2'>IFSC :</div><div class='col'><strong>{$apc_get['Account-ifsc']}</strong></div></div><div class='row'><div class='col-4 text-end pe-2'>A/c. Number :</div><div class='col'><strong>{$apc_get['Account-number']}</strong></div></div>";
		
		//echo $opener_script;
		//echo $opener_transID;
	?>
	
	<?/*?>
	<div id="IndiaBankTransfer_details_id" class="row m-1 p-2 border rounded">
		<div class="row"><div class="col-4">Beneficiary Name</div><div class="col"><strong><?=$apc_get['Account-name'];?></strong></div></div>
		<div class="row my-2"><div class="col-4">IFSC</div><div class="col"><strong><?=$apc_get['Account-ifsc'];?></strong></div></div>
		<div class="row"><div class="col-4">Account Number</div><div class="col"><strong><?=$apc_get['Account-number'];?></strong></div></div>
	</div>
	<script>
		opener.document.getElementById("IndiaBankTransfer_details").innerHTML=document.getElementById("IndiaBankTransfer_details_id").innerHTML;
		opener.$('.submit_div.m-button').hide();
		window.close();
	</script>
	<?*/?>
	
	<?
	}
	elseif($acquirer==711)	//for UPI Collect
	{
		$payerVpa	= $post['upi_address'];	//$payerVpa  = 'reg7@indusuat';
		if(isset($post['upi_address_suffix'])&&$post['upi_address_suffix']) {
			$payerVpa .= $post['upi_address_suffix'];
		}
	
		$payerName	= $post['fullname'];	//payer fullname
		$mcc = '00';

		require_once 'collect.do';	//to execute collect query via library
		
		//$tr_upd_order['Payload']=@$Payload;
		
		if(isset($response_json)&&$response_json)
		{
			$response_param = json_decode($response_json,1);
		//	print_r($response_param);
			
			
		
			$tr_upd_order['response']=$response_param?$response_param:$response_json;
		
			$curl_values_arr['responseInfo']	=$tr_upd_order['response'];
			$curl_values_arr['browserOsInfo']	=$browserOs;
		
			$_SESSION['acquirer_action']=1;
			$_SESSION['curl_values']=$curl_values_arr;

			if(isset($response_param['custRefNo'])&&$response_param['custRefNo'])
			{
				$tr_upd_order['acquirer_ref']=$response_param['custRefNo'];
			}
			if(isset($response_param['status'])&&strtoupper($response_param['status'])=='SUCCESS')	//for initiate
			{
				//if received success for collect then redirect transaction_processing to check payment status 
				$payment_url = $fetch_iec; //"{$data['Host']}/transaction_processing{$data['ex']}?transID={$transID}&action=hkip"; 
		
				//$_SESSION['hkip_status']=1;
				$_SESSION['acquirer_status_code']=1;
				
				$_SESSION['acquirer_response']=" Pending";
				
				
			}
			elseif(isset($response_param['status'])&&strtoupper($response_param['status'])=='FAILURE')	//failed
			{
				//$_SESSION['hkip_status']=-1;
				$_SESSION['acquirer_status_code']=-1;
				
				$_SESSION['acquirer_response']=" failed";

				$process_url = $return_url; 
			}
			else
			{
				$payment_url = $trans_processing; 
				//$_SESSION['hkip_status']=1;
				$_SESSION['acquirer_status_code']=1;
				
			}
			//trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);
		}
	}
//	print_r($tr_upd_order);
//	echo 'aaa'.$_SESSION['tr_newid'];
	trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);

	
?>