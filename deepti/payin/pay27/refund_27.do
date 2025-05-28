<?
if(!isset($_SESSION['adm_login'])){
	echo('ACCESS DENIED.'); exit;
}
//	17, 26, 27  fhtPay		
//	/payin/pay27/refund_27.do?oid=682912&amount=365.25&site_id=421;

$mop=$tr_st['mop'];
$apc_get=$apc_get[$mop];
if(isset($qp)&&$qp){
	echo "<br/><br/>acquirer_refund_url=>".$acquirer_refund_url;
	echo "<br/><br/>apc_get via \"{$mop}\" => ";print_r($apc_get);echo "<br/><br/>";
}

$params=array();

//$tr_st=get_transaction_detail($post['gid'], -1);
$reply_get=$tr_st['system_note'];//reply_remark

if(empty($acquirer_refund_url)){
	$acquirer_refund_url="https://payment.gantenpay.com/payment/refund/requestForRefund";
}

if($tr_st['acquirer']==27){
	$hash=$apc_get['hash'];
	$params['merNo']=$apc_get['merNO'];
	$params['terNo']=$apc_get['terNO'];
	$merMgrURL=$apc_get['merMgrURL'];
}

//$params['refundCurrency']=$tr_st['bill_currency'];
$params['refundCurrency']=$tr_st['bank_processing_curr'];
$params['refundAmount']=$tr_st['bill_amt'];
$params['busCurrency']=$tr_st['bill_currency']; //bank_processing_curr

if($tr_st['bank_processing_amount']!="0.00"&&!empty($tr_st['bank_processing_amount'])){
	$params['refundAmount']=$params['busAmount']=$tr_st['bank_processing_amount'];
}else{
	$params['refundAmount']=$params['busAmount']=$tr_st['bill_amt'];
}
$params['tradeNo']=$tr_st['acquirer_ref'];



$params_data= http_build_query($params);
$hashCode=hash("sha256",$params_data."&".$hash);

$params['refundReason']="Requested by Merchant";


//echo "<hr/>params_data=>".$params_data; 
echo "<hr/>hashCode=>".$hashCode;
echo "<hr/>hash=>".$hash; 

//print_r($tr_st);



if(isset($_GET['confirm_amount'])&&!empty($_GET['confirm_amount'])){
	//$refund_amount=$_GET['confirm_amount'];
}


			
if(isset($_GET['rtest'])){
			
	echo "<hr/>params=>";print_r($params);	
	echo "<hr/>TransDetails=>";print_r($tr_st);	
}

echo "<br/><hr/>acquirer_refund_urls=>".$acquirer_refund_url;
echo "<br/><hr/>params=>";print_r($params); 
	
			
			
			$params_data=http_build_query($params)."&hashCode=".$hashCode; 
			//hashCode	

			
			$curl = curl_init();  
			curl_setopt($curl,CURLOPT_URL,$acquirer_refund_url);
			curl_setopt($curl,CURLOPT_RETURNTRANSFER,true);
			curl_setopt($curl,CURLOPT_HEADER, 0); 
			curl_setopt($curl,CURLOPT_POST, 1);
			curl_setopt($curl,CURLOPT_POSTFIELDS, $params_data);
			curl_setopt($curl,CURLOPT_SSL_VERIFYPEER, false); 
			curl_setopt($curl,CURLOPT_SSL_VERIFYHOST, false);
			$curl_exec=curl_exec($curl);
			curl_close($curl);
			$result=json_decode($curl_exec,true);
			
			if(isset($_GET['rtest'])){
				echo "<hr/>result=>";print_r($result);
			}
			
			echo "<hr/>curl_exec=>".$curl_exec;
			echo "<hr/>result=>";print_r($result);
			
			
		
		if($result&&($result['respCode']==0000||$result['respCode']=="0000")){
			$post_reply="Refund Successful";
			$live_refund_status='Y';
		}
		else $live_refund_status='N';
			

/*		
		$refund_qry_db=true;
		if($result&&($result['respCode']==0000||$result['respCode']=="0000")){
			$post_reply="Refund Successful";
		}else{
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
	
		
if($result['respCode']==0000||$result['respCode']=="0000"){		
			
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