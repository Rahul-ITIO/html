<?
if(!isset($data['config_root'])){
	$config_root='config_root.do';
	if(file_exists($config_root)){require_once($config_root);}

	if(isset($_SESSION['process']['bank_process_url'])){
		$data['Host']=$_SESSION['process']['bank_process_url'];
	}
	if(isset($_SESSION['process']['payTitle'])&&$_SESSION['process']['payTitle']){
		$data['payTitle']=$_SESSION['process']['payTitle'];
	}
	if(isset($_SESSION['process']['appName'])&&$_SESSION['process']['appName']){
		$data['appName']=$_SESSION['process']['appName'];
	}
}
if(isset($transID)&&$transID){
	$data['transID']="?transID={$transID}";
}
if(!isset($data['payTitle'])){
	$data['payTitle']='Continue the process';
}
if(!isset($data['payTitle'])){
	$data['appName']='UPI / APP / ';
}

$data['Host2']=$data['Host'];
		
?>
<!DOCTYPE html>
<html lang="en-US">
<head>
<title>Continue the process ...</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" >
<meta http-equiv="Content-Security-Policy" content="default-src 'self'; font-src * 'unsafe-inline'; style-src * 'unsafe-inline'; script-src * 'unsafe-inline' 'unsafe-eval'; img-src * data: 'unsafe-inline'; connect-src * 'unsafe-inline'; frame-src *; object-src 'none' frame-ancestors 'self' 'budpay.com'; " >

<script src="<?=$data['Host2']?>/js/jquery-3.6.0.min.js"></script>

<style>
body{margin:0;padding:0;overflow:auto;width:100%;height:100%;
font-size:14px; font-family: Arial, Helvetica, sans-serif; color: #5d5c5d; 
	 line-height: 24px; text-align: center;
	color: #468847;
	background: url("<?php echo $data['Host'];?>/images/criss-cross.png");
	border-color: #d6e9c6;
}
h1 {float:left;font-size:22px;width:100%;border-bottom:2px solid #ccc;padding:0 0 20px 0;margin:0 0 20px 0;font-weight:normal;}
.warper {
	display:block;width:380px;margin:10px auto; 
}
.warper_div {
	float:left;display:block;width:100%;padding:0px;margin:10px auto; background-color:#fff;border:4px solid #ccc;border-radius:7px;
}
.text_place{font-size:16px; margin:10px 10px; font-family: Arial, Helvetica, sans-serif; color: #5d5c5d; float:left; width:100%; line-height: 22px; text-align:justify;}
.red {color:red;}
.qr_code {float:left;}

.coins_amt {float:right;text-align:right;}
.bch {font-size:24px;font-weight:bold;color:#000;}
.none_bch {font-size:18px;font-weight:bold;color:#999;}
.address_coins {float:right;text-align:right;font-size:18px;font-weight:normal;color:#000;margin: 168px 25px 0 0;}
.qr_code_div {float:left;width:100%;border-bottom:2px solid #ccc;padding:0 0 40px 0;margin:0 0 20px 0;font-weight:normal;}
.warper_master {padding:20px 40px 20px 20px;}
.payToNextDiv {float:left;width:100%;text-align:center;margin:10px 0 20px 0px;}
.payToNext{float: unset;display:inline-block;background:#da8f05;padding:10px 30px;font-size:18px;color:#fff;text-decoration:none;border-radius:5px}

.iHavPaid1 {float:left;width:100%;}
.iHavPaid{float:right;background:#da8f05;padding:10px 30px;font-size:18px;color:#fff;text-decoration:none;border-radius:5px}

/*
@media (max-width: 770px) {
	.warper {width:85%;margin:0 auto;}
	
	.coins_amt {float:left;text-align:right;width:100%;margin-bottom: 20px;}
	.address_coins {margin:30px 0 0 0;width:100%;font-size:14px;font-weight:bold;text-align: center;}
	.qr_code {float: none;}
}
*/
</style>
<script>
 
</script>
</head>
<body oncontextmenu1='return false;'>  
<div class="warper"><div class="warper_div"><div class="warper_master">
	<div class="text_place" >
		<h1><?=$data['payTitle'];?> </h1>
		<p>We are about to redirect you to bank page to authenticate this transactions in the next tab.</p>
		
		<div class="payToNextDiv"><a  class="payToNext" href="<?=$data['intent_paymentUrl']?>" target="_blank"  >Pay to continue the process</a></div>
	  
		<p><span class="red">Attention!</span> <b>Once the Payment is sent successfully from your <?=$data['appName'];?> wallet. Click on I have paid button below.</b></p>
		
		
	</div>	
	<div class="qr_code_div">
		<div class="iHavPaid1"><a id="iHavPaidLink" class="iHavPaid" href="<?=$data['Host']?>/bank_status<?=$data['ex']?><?=$data['transID']?>" target="_blank"  >I HAVE PAID</a></div>
	</div>
	
</div></div></div>	
</body>
<?
if(isset($_SESSION['process'])){
	//unset($_SESSION['process']);
}
?>
</html>