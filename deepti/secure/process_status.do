<?php
include('../config_db.do');
$host_path=$data['Host'];
$redirect_url="";$redirect_url2="";
function unset_sessionf2($unsetPram){
	//print_r($unsetPram);
	if(is_array($unsetPram)){
		foreach($unsetPram as $k=>$v){
			if(isset($_SESSION[$v])){unset($_SESSION[$v]);}
		}
	}
}

?>
<?php
	
	function getSignature($body, $secretKey){
	  $hash = hash_hmac('sha256', $body, $secretKey, false);
	  return $hash;
	}
	
	$transactionId=$_SESSION['ps']['transactionId'];//'GE00002001133952';
	$x_site_id=$_SESSION['ps']['x_site_id'];
	$secret_key=$_SESSION['ps']['secret_key'];
	
	if(isset($_REQUEST['t'])&&$_REQUEST['t']){$transactionId=$_REQUEST['t'];	}
	
	##################################################
	
	
	// Get status by TransactionId.
	
	$get_status_url="https://ep.gate.express/transactions/{$transactionId}";
	$orderset=$_SESSION['ps']['orderset'];
	$uniqueTrId=$orderset.(rand(10,99999));
	
	
	
	$StatusSignature="GET\n".
	"/transactions/{$transactionId}\n".
	"{$x_site_id}\n".
	"{$uniqueTrId}\n";
	
	
	$signatureStatus=hash_hmac('sha256', $StatusSignature, $secret_key, false); 
	
	if($_SESSION['post']['qp']){
		echo "<br/><hr/><br/>2. Get status by TransactionId:<br/>";
		echo "<br/>StatusSignature=><br/><br/>".nl2br($StatusSignature)."<br/>";
		echo "<br/><hr/>secret_key=> ".$secret_key;
		echo "<br/><hr/>signatureStatus=> ".$signatureStatus;
	}
	
	$ch_status = curl_init();
	curl_setopt($ch_status, CURLOPT_URL, $get_status_url);
	curl_setopt($ch_status, CURLOPT_HEADER, 0);
	curl_setopt($ch_status, CURLOPT_RETURNTRANSFER, 1);
	$headers = array();
	$headers[] = 'X-SITE-ID: '.$x_site_id;
	$headers[] = 'X-REQUEST-ID: '.$uniqueTrId;
	$headers[] = 'X-REQUEST-SIGNATURE: '.$signatureStatus;
	curl_setopt($ch_status, CURLOPT_HTTPHEADER, $headers);
	$result_status = curl_exec($ch_status);
	if (curl_errno($ch_status)) {
		echo '<hr/><br/><br/>Error:' . curl_error($ch_status);
	}
	curl_close($ch_status);
	
	$result_status_de = json_decode($result_status,true);
	if($_SESSION['post']['qp']){
		echo "<br/><hr/>get_status_url=><br/>".$get_status_url; 
		echo "<br/><hr/>result_status=><br/>".$result_status; 
		echo "<br/><hr/>status headers=><br/>";print_r($headers);
		echo "<br/><hr/>result_status_de=><br/>";print_r($result_status_de);
	}
	$sd=$result_status_de;
	$_SESSION['sd']=$sd;
	$post_s['sd']=$sd;
	
	######################################### 
	
		$unset_session_2=["hkip_action","hkip_info","hkip_status","hkip_order_status","hkip_pid","hkip_billing_desc","hkip_billing_desc","curl_values"];
		unset_sessionf2($unset_session_2);
	
		$result=$sd;
		
		$curl_values_arr['responseInfo2']=$result?$result:$response;
		$curl_values_arr['browserOsInfo']=$browserOs;
		
		
		$hkip_info=$result['StateDetails']['Code'] ." : ". $result['StateDetails']['Description'];
		
		$_SESSION['hkip_action']="hkip";
		$_SESSION['hkip_info']=$result['TransactionState'];
		//$_SESSION['hkip_status']=$result['message'];
		$_SESSION['hkip_order_status']=$result['TransactionState'];
		$_SESSION['hkip_pid']=$result['TransactionId'];
		
		//$_SESSION['hkip_billing_desc']=$result['bAddr'];
		$_SESSION['curl_values']=$curl_values_arr;
	
	########################################
	
	function post_redirect_status($url, array $data)
	{
		?>
		<!DOCTYPE html>
		<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
			<?php if(isset($data['b_submit'])){?>
				<script type="text/javascript">
					function closethisasap() {
						
					}
				</script>
			<?php } else {?>
				<script type="text/javascript">
					function closethisasap() {
						document.forms["redirectpost"].submit();
					}
				</script>
			<?php } ?>
		</head>
		<body onload="closethisasap();">
		<form name="redirectpost" method="post" action="<?php echo $url; ?>" target="_top">
			<?php
			if ( !is_null($data) ) {
				foreach ($data as $k => $v) {
					if(isset($data['b_submit'])){
						echo $k.' : <input type="text" name="'.$k.'" value="'.$v.'" style="display:none1;width:90%;"><br/> ';
					}else{
						echo '<input type="hidden" name="'.$k.'" value="'.$v.'" style="display:none;">';
					}
				}
			}
			?>
			<?php if(isset($data['b_submit'])){?>
				<input type="submit" name="sendfrm" id="sendfrm" value="SUBMIT" class='btn' />
			<?php }?>
			
		</form>
		</body>
		</html>
		<?php
		exit;
	}

?>
<!DOCTYPE html>
<html lang="en-US">
<head>
<title>Processing...</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
<style>
body{margin:0;padding:0;overflow:hidden;width:100%;height:100%;font-size:14px; font-family: Arial, Helvetica, sans-serif; color: #5d5c5d; 
	 line-height: 24px; text-align: center;
	color: #468847;
    background-color: #dff0d8;
    border-color: #d6e9c6;}
</style>

<?if(isset($sd['StateDetails']['PaReq'])){?>
	<script type="text/javascript">
		
	</script>
<?}else{?>
<script>
	/*
	setTimeout( function(){ 
		//alert("OK==");
		document.location.href=window.document.location.href;
	}, 60000 );
	*/
</script>
<?}?>

</head>
<body>
<?php
	include("../api/include/loading_icon.do");
?>
<?	
	$subQuery="";
	if(isset($_SESSION['hkip_order_status'])&&($_SESSION['hkip_order_status']=='success')){ // success
		$_SESSION['hkip_order_status']=2;
		$_SESSION['hkip_info']="Success"; 
		
		transactions_updates($_SESSION['ps']['tr_newid'], $post_s);
		
		$callbacks_url = $host_path."/success{$data['ex']}?orderset={$orderset}&action=hkip".$subQuery; 
		header("Location:$callbacks_url");exit;
		
	}
	elseif(isset($_SESSION['hkip_order_status'])&&($_SESSION['hkip_order_status']=='declined' || $_SESSION['hkip_order_status']=='rejected' )){ // failed 
		$_SESSION['hkip_order_status']=-1;
		$_SESSION['hkip_info']=$hkip_info." - Cancelled"; 
		
		transactions_updates($_SESSION['ps']['tr_newid'], $post_s);
		
		$callbacks_url = $host_path."/failed{$data['ex']}?orderset={$orderset}&action=hkip".$subQuery; 
		header("Location:$callbacks_url");exit;
		
	}
	elseif(isset($sd['StateDetails']['PaReq'])){
	
	$dataStatus['PaReq']=$sd['StateDetails']['PaReq'];
	$dataStatus['MD']=$sd['StateDetails']['MD'];
	$dataStatus['TermUrl']=$_SESSION['ps']['TermUrl'];
	
	$_SESSION['cbd']=$dataStatus;
	
	$post_s['cbd']=$dataStatus;
	
	transactions_updates($_SESSION['ps']['tr_newid'], $post_s);
	
	post_redirect_status($sd['StateDetails']['AcsUrl'], $dataStatus);
	
	}
	else{?>
	<script>
		setTimeout( function(){ 
			//alert("OK==");
			document.location.href=window.document.location.href;
		}, 30000 );
	</script>
<?}?>
</html>