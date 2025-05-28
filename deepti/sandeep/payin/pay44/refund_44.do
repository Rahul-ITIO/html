<?php
if(!isset($_SESSION['adm_login'])){
	echo('ACCESS DENIED.');
	exit;
}

$mop=$td['mop'];
//$apc_get=$apc_get[$mop];
if(isset($qp)&&$qp){
	echo "<br/><br/>acquirer_refund_url=>".$acquirer_refund_url;
	//echo "<br/><br/>apc_get via \"{$mop}\" => ";print_r($apc_get);echo "<br/><br/>";
}

if(empty($acquirer_refund_url)){
	$acquirer_refund_url="https://api.flutterwave.com/v3/transactions";
}

/*
$paramsInfo=array();
//$paramsInfo['refundCurrency']=$td['bill_currency'];
$paramsInfo['refundCurrency']=$td['bank_processing_curr'];
$paramsInfo['refundAmount']=$td['bill_amt'];
$paramsInfo['busCurrency']=$td['bill_currency']; //bank_processing_curr

if($td['bank_processing_amount']!="0.00"&&!empty($td['bank_processing_amount'])){
	$paramsInfo['refundAmount']=$td['bank_processing_amount'];
}else{
	$paramsInfo['refundAmount']=$td['bill_amt'];
}
$acquirer_ref=$td['acquirer_ref'];
*/

$get_json_info=array();

//$get_json_info['bank_url']	=$apc_get['bank_url'];
//$get_json_info['PublicKey']	=$apc_get['PublicKey'];

$get_json_info['SecretKey']	=$apc_get['SecretKey'];
$get_json_info['acquirer_ref']	=$acquirer_ref;
//$get_json_info['flw_ref']	=$apc_get['flw_ref'];
$get_json_info['flw_ref']	=$json_value['response_step_1']['data']['flw_ref'];


$params=array();
$params['amount']	= $paramsInfo['refundAmount']; 
$params['flw_ref']	= $get_json_info['flw_ref']; //flwRef

$gateway_url=$acquirer_refund_url."/{$get_json_info['acquirer_ref']}/refund";

if(isset($_GET['rtest']))
{
	echo "<hr/>params=>";
	print_r($params);	

	print_r($get_json_info);

}

//echo "<hr/>params=>";print_r($params); 

//if(!isset($_GET['rtest']))
{
	echo "<hr/>acquirer_refund_url=>".$acquirer_refund_url;
}
$curl = curl_init();

curl_setopt_array($curl, array(
	CURLOPT_URL => $gateway_url,
	CURLOPT_RETURNTRANSFER => true,
	CURLOPT_ENCODING => "",
	CURLOPT_MAXREDIRS => 10,
	CURLOPT_TIMEOUT => 0,
	CURLOPT_FOLLOWLOCATION => true,
	CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	CURLOPT_CUSTOMREQUEST => "POST",
	CURLOPT_POSTFIELDS => json_encode($params),
	CURLOPT_HTTPHEADER => array(
		"Content-Type: application/json",
		"Authorization: Bearer ".$get_json_info['SecretKey']
	),
));
$curl_exec=curl_exec($curl);
curl_close($curl);
$result=json_decode($curl_exec,true);
			
	//if(!isset($_GET['rtest']))
	{
		echo "<hr/>result=>";print_r($result);
	}
	
	
	if((!empty($result['data']['status']))&&(strpos($result['data']['status'],"completed")!==false)){
		$post_reply="Refund Successful";
		$live_refund_status='Y';
	}
	else $live_refund_status='N';
	
	

/*

	$refund_qry_db=true;
	
	
	if((!empty($result['data']['status']))&&(strpos($result['data']['status'],"completed")!==false))
	{
		$post_reply="Refund Successful";
	}
	else
	{
		$post_reply="Update Refund Manually";
		
		if(isset($_GET['upd_request'])){
		
		}else{
			$refund_qry=false;
			$refund_qry_db=false;

			$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
			$urlpath=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
		?>
			<a target="hform" onclick="javascript:top.popuploadig();" href="<?=$urlpath."&upd_request=1";?>" class="upd_status" style="outline:0px !important;color:rgb(0, 102, 204);text-decoration:none;cursor:pointer;float:none;display: block;clear:both;width:90%;text-align:center;margin:100px auto 15px auto;line-height:30px;border-radius:3px;background-color:rgb(223, 240, 216);font-size:16px;font-family:'Open Sans', sans-serif;font-style:normal;font-variant-ligatures: normal;font-variant-caps:normal;font-weight: 400;letter-spacing: normal;orphans:2;text-indent:0px;text-transform:none;white-space: normal;widows:2;word-spacing:0px;-webkit-text-stroke-width:0px;">Update Refund Manually</a>
			
		<? exit;}
	}
			
		//echo $urlpath;
		

		if($refund_qry_db==true)
		{	
		
			$reply_date=date('d-m-Y h:i:s A');
			$reply_remark = "<div class=rmk_row><div class=rmk_date>".$reply_date."</div><div class=rmk_msg>".$post_reply."</div></div>".$system_note;
		
			// query update for master_trans_additional
			$additional_update=$master_update="`system_note`='{$reply_remark}'";
			
			if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y')
			{
				$master_update='';
				$additional_update=ltrim($additional_update,',');
				db_query("UPDATE `{$data['DbPrefix']}{$data['ASSIGN_MASTER_TRANS_ADDITIONAL']}` SET ".$additional_update." WHERE `id_ad`='".$post['gid']."' ",0); 
			}
			else 
			{
				db_query(
					"UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
					" SET ".$master_update.
					" WHERE `id`={$post['gid']}"
				);
			}
		}	
		
			//exit;
	
		
//if($result['status']==1){
if((!empty($result['data']['status']))&&(strpos($result['data']['status'],"completed")!==false)){
			
?>
	<a onclick="javascript:top.popupclose();" class="upd_status" style="outline:0px !important;color:rgb(0, 102, 204);text-decoration:none;cursor:pointer;float:none;display: block;clear:both;width:90%;text-align:center;margin:100px auto 15px auto;line-height:30px;border-radius:3px;background-color:rgb(223, 240, 216);font-size:16px;font-family:'Open Sans', sans-serif;font-style:normal;font-variant-ligatures: normal;font-variant-caps:normal;font-weight: 400;letter-spacing: normal;orphans:2;text-indent:0px;text-transform:none;white-space: normal;widows:2;word-spacing:0px;-webkit-text-stroke-width:0px;">Refund Successful</a>
	<script>
		setTimeout(function(){ 
			top.popupclose();
		},900); 
	</script>
<?}
*/
?>