<?
$config_root='../config_root.do';
if(file_exists($config_root)){require_once($config_root);}
$data['Host2']=$data['Host'];



// Dev Tech : 23-09-30 fetch transID 
$transID='';
if(isset($_REQUEST['transID'])&&$_REQUEST['transID']) $transID=$_REQUEST['transID'];
elseif(isset($_SESSION['transID'])) $transID=$_SESSION['transID'];
elseif(isset($_SESSION['SA']['transID'])) $transID=$_SESSION['SA']['transID'];

$transID=transIDf($transID,0);	

if(isset($_SESSION['url_redirect_mode'])&&trim($_SESSION['url_redirect_mode'])){
	header('Location:'.$_SESSION['url_redirect_mode']);exit;
}

	
	if(isset($_SESSION['3ds2_auth']['processed'])&&$_SESSION['3ds2_auth']['processed'])
		$processed=$_SESSION['3ds2_auth']['processed'];
	else
		$processed=$data['Host']."/status".$data['ex']."?transID=".$transID;
	
	if(isset($_SESSION['3ds2_auth']['paytitle'])&&$_SESSION['3ds2_auth']['paytitle']){
		$paytitle=$_SESSION['3ds2_auth']['paytitle'];
	}else{
		$paytitle=''; // Bitcoin
	}
	
	if(isset($_SESSION['3ds2_auth']['paycurrency'])&&$_SESSION['3ds2_auth']['paycurrency']){
		$paycurrency=$_SESSION['3ds2_auth']['paycurrency'];
	}else{
		$paycurrency=''; // Bitcoin currency
	}
	
	if(isset($_SESSION['3ds2_auth']['bill_amt'])&&$_SESSION['3ds2_auth']['bill_amt']){
		$_SESSION['3ds2_auth']['amount']=$_SESSION['3ds2_auth']['bill_amt'];
	}
	
	if(isset($_SESSION['3ds2_auth']['bill_currency'])&&$_SESSION['3ds2_auth']['bill_currency']){
		$bill_currency=$_SESSION['3ds2_auth']['bill_currency'];
	}else{
		$bill_currency=''; //BTC
	}
		
?>
<!DOCTYPE html>
<html lang="en-US">
<head>
<title>Scan of QR Code ...</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" >
<meta http-equiv="Content-Security-Policy" content="default-src 'self'; font-src * 'unsafe-inline'; style-src * 'unsafe-inline'; script-src * 'unsafe-inline' 'unsafe-eval'; img-src * data: 'unsafe-inline'; connect-src * 'unsafe-inline'; frame-src *; object-src 'none'" >

<script src="<?=$data['Host2']?>/js/jquery-3.6.0.min.js"></script>

<style>
body{margin:0;padding:0;overflow:auto;width:100%;height:100%;
font-size:14px; font-family: Arial, Helvetica, sans-serif; color: #5d5c5d; 
	 line-height: 24px; text-align: center;
	color: #468847;
	background: url("<?php echo $data['Host'];?>/images/criss-cross.png");
	border-color: #d6e9c6;
}
h1 {float:left;width:100%;border-bottom:2px solid #ccc;padding:0 0 20px 0;margin:0 0 20px 0;font-weight:normal;}
.warper {
	display:block;width:700px;margin:10px auto; 
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
.iHavPaid1 {float:left;width:100%;}
.iHavPaid{float:right;background:#da8f05;padding:10px 30px;font-size:18px;color:#fff;text-decoration:none;border-radius:5px}

@media (max-width: 770px) {
	.warper {width:85%;margin:0 auto;}
	
	.coins_amt {float:left;text-align:right;width:100%;margin-bottom: 20px;}
	.address_coins {margin:30px 0 0 0;width:100%;font-size:14px;font-weight:bold;text-align: center;}
	.qr_code {float: none;}
}
</style>
<script>
 
</script>
</head>
<body oncontextmenu='return false;'>
<script src="<?=$data['Host2']?>/js/qrcode.min.js"></script>	
<script type="text/javascript">
var processed = "<?php echo $processed;?>";
//alert(processed);
function CopyToClipboard2(text) {
			text=$(text).html();
			var $txt = $('<textarea />');

            $txt.val(text)
                .css({ width: "1px", height: "1px" })
                .appendTo('body');

            $txt.select();

            if (document.execCommand('copy')) {
                $txt.remove();
            }
	}
	function updateTimer() {
		timeLeft -= 1000;
		if (timeLeft > 0) {
			timer.text(msToTime(timeLeft));
			//alert('11if');
		} else {
			//window.location.reload(true);
			
		}
	}
	function msToTime(s) {
		  var ms = s % 1000;
		  s = (s - ms) / 1000;
		  var secs = s % 60;
		  s = (s - secs) / 60;
		  var mins = s % 60;
		  var zero = secs <= 9 ? '0' : '';
		  return mins + ':' + zero + secs;
	}
	var timeLeft = 0;
	var timer;
	
	

	
	$(document).ready(function() {
		timeLeft = 899678; // 15 min = 59978.53333333333 * 15 ;
		//timeLeft = 9000;
		setTimeout(function(){ 
			//alert(processed); 
			top.window.location.href=processed;
		}, timeLeft);
		
		timer = $('#timer');
		setInterval(updateTimer, 1000);
		var qr = $('#qr_code_div_id');
		
		
		var data = "<?php echo $_SESSION['3ds2_auth']['payaddress'];?>";
		if (qr.length && data != null && data.length > 0) {
			qr.html('');
			var qrcode = new QRCode(
				'qr_code_div_id',
				{
					text : data,
					width : 200,
					height : 200,
					colorDark : "#000000",
					colorLight : "#ffffff",
					correctLevel : QRCode.CorrectLevel.M
				});
		}
	});
</script>
  
<div class="warper"><div class="warper_div"><div class="warper_master">
	<div class="text_place" >
		<h1><?=$paytitle;?> </h1>
		<p>Please transfer the exact amount of <strong><?php echo $_SESSION['3ds2_auth']['payamt'];?> <?=$paycurrency;?></strong> to the <?=$paycurrency;?> address shown on this page in one transaction.</p>
		<p>The Network protocol type to be used for this transfer should be: <b><?php echo $_SESSION['3ds2_auth']['netWorkType'];?></b> </p>
		<p>The amount must be exactly the same, otherwise refunds and processing   issues are possible. The amount must be paid in one transaction only,   payments in multiple transactions are not supported.</p>
		
		<p>The funds will be credited to your wallet as soon as we get 6 confirmations from the <?=$paytitle;?> network.</p>
	  
		<p><span class="red">Attention!</span> <b>Once the Payment is sent successfully from your <?=$paycurrency;?> wallet. Click on I have paid button below.</b></p>
		
		
	</div>	
	<div class="qr_code_div">
		<div class="coins_amt">
			<div class="bch"><?php echo $_SESSION['3ds2_auth']['payamt'];?> <?=$_SESSION['3ds2_auth']['paycurrency'];?></div>
			<div class="none_bch"><?php echo $_SESSION['3ds2_auth']['bill_amt'];?> <?php echo $bill_currency;?></div>
		</div>
		
		<div id="qr_code_div_id" class="fl qr_code" border="0" title="<?php echo $paytitle;?>:<?php echo $_SESSION['3ds2_auth']['payaddress'];?>?amount=<?php echo $_SESSION['3ds2_auth']['payamt'];?>">
				  
				  
		</div>
		
		
		<div class="address_coins" id="qr_code_address" onClick="CopyToClipboard2('#qr_code_address');"><?php echo $_SESSION['3ds2_auth']['payaddress'];?> </div>
		<a style="padding-left:10px; float:right;clear: both; position:relative; top:-20px;" href="javascript:void(0)" onClick="CopyToClipboard2('#qr_code_address');">
		<img src="<?=$data['Host']?>/images/copy.png" alt="Copy Qrcode" title="Copy Qrcode" width="15"></a>
		<div id="timer" class="btc-timer">15:00</div>
		
		<div class="iHavPaid1"><a id="iHavPaidLink" class="iHavPaid" href="<?=$processed;?>">I HAVE PAID</a></div> 
	</div>
	
</div></div></div>	
</body>
<?
if(isset($_SESSION['3ds2_auth'])){
	//unset($_SESSION['3ds2_auth']);
}
?>
</html>