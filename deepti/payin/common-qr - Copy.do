<?
//error_reporting(0); // reports all errors
include('../config.do');

//print_r($_SESSION['3ds2_auth']);

$data['Host2']=$data['Host'];

	if(isset(//$_SESSION['3ds2_auth']['bank_process_url'])){
		$data['Host']=//$_SESSION['3ds2_auth']['bank_process_url'];
	}else{
		//$data['Host'];
	}
	
	if(isset($_SESSION['3ds2_auth']['processed'])&&$_SESSION['3ds2_auth']['processed']) {
		$processed=$_SESSION['3ds2_auth']['processed'];
	}	
	else
	{
		$processed=$data['Host']."/status".$data['ex']."?transID=".$transID;
	}
	
	if(isset($_SESSION['3ds2_auth']['paytitle'])&&$_SESSION['3ds2_auth']['paytitle']){
		$paytitle=$_SESSION['3ds2_auth']['paytitle'];
	}else{
		$paytitle=' UPI / APP / Wallet ';
	}
	
	if(isset($_SESSION['3ds2_auth']['currname'])&&$_SESSION['3ds2_auth']['currname']){
		$currname=$_SESSION['3ds2_auth']['currname'];
	}else{
		$currname=' ';
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

<?
if(file_exists('../front_ui/silver/common/css/bootstrap.min.css'))
	$css_file = $data['Host'].'/front_ui/silver/common/css/bootstrap.min.css';
else
	$css_file = $data['Host'].'/front_ui/default/common/css/bootstrap.min.css';
?>

<script src="<?=$data['Host']?>/js/jquery-3.6.0.min.js"></script>

<link href="<?=$css_file;?>" rel="stylesheet">


<? 
///////////////////// Color Code Get From Header - Hardcoded ////////////////
$body_bg_color="#ffffff";
$body_text_color="#000000";
	
$heading_bg_color="#ffffff";;
$heading_text_color="#000000";
///////////////////// End Color Code Get From Header ////////////////

// include for display dynamic template color
include($data['Path'].'/include/header_color'.$data['iex']); 
/*
// include for display font awasome icon
include($data['Path'].'/include/fontawasome_icon'.$data['iex']);

// include for Adjustment Template Color & size by merchant added by vikash on 29122022
include($data['Path'].'/include/color_font_adjustment'.$data['iex']);
*/
?>


<style>
body {color: var(--body_text_color-1) !important;}
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
.address_coins {float:right;text-align:right;font-size:18px;font-weight:normal;color:#000;margin: 0px 25px 0 0;}
.qr_code_div {float:left;width:100%;border-bottom:2px solid #ccc;padding:0 0 40px 0;margin:0 0 20px 0;font-weight:normal;}
.warper_master {padding:20px 40px 20px 20px;}
.iHavPaid1 {float:left;width:100%;}
.iHavPaid {float:right;background:#da8f05;padding:10px 30px;font-size:18px;color:#fff;text-decoration:none;border-radius:5px}

.main-col-sm{width:100%; max-width:600px; margin:0 auto;}
.text12 {font-size:12px;}

#column1 {float:left; width:48%; min-width:250px;}
#column2 {float:right; width:48%; min-width:250px;}

html div, html span, html .text-start, html .text-light {
    color: var(--body_text_color-1) !important;
    
}

@media (max-width: 770px) {
	.warper {width:85%;margin:0 auto;}
	
	.coins_amt {float:left;text-align:right;width:100%;margin-bottom: 20px;}
	.address_coins {margin:30px 0 0 0;width:100%;font-size:14px;font-weight:bold;text-align: center;}
	.qr_code {float: none;}
	
	#column1 {float:none; width:98%; text-align:center; margin:auto;}
	#column2 {float:none; width:98%;}
	#pay_qr_code {margin:0 auto;}

}

* {
	box-sizing: border-box;
}

/* Create two equal columns that floats next to each other */
.column {
	float: left;
	width: 48%;
	padding: 10px;
	height: 600px; /* Should be removed. Only for demonstration */
}

/* Clear floats after the columns */
.row:after {
	content: "";
	display: table;
	clear: both;
}

</style>
</head>

<body oncontextmenu1='return false;'>
<script src="<?=$data['Host']?>/js/qrcode.min.js"></script>	
<script type="text/javascript">
var processed = "<?php echo $processed;?>";

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
		timer1.text(msToTime(timeLeft));
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
	var timer, timer1;

	$(document).ready(function() {
		timeLeft = 899678; // 15 min = 59978.53333333333 * 15 ;
		//timeLeft = 9000;
		setTimeout(function(){ 
			top.window.location.href=processed;
		}, timeLeft);
		
		timer = $('#timer');
		timer1 = $('#timer1');
		setInterval(updateTimer, 1000);
		var qr = $('#pay_qr_code');

		var data = "<?php echo $_SESSION['3ds2_auth']['payaddress'];?>";
		if (qr.length && data != null && data.length > 0) {
			qr.html('');
			var qrcode = new QRCode(
				'pay_qr_code',
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
<?
//print_r($_SESSION);
?>
<div class="container-sm my-2" style=" margin:0 auto;">
	<div class="row">
	<? 
	##########################
	if(!isset($_SESSION['action'])||$_SESSION['action']!="vt")
	{
	?>
		<div class="main-col-sm p-2" style="background: <? if(isset($_SESSION['background_g'])) {?><?=$_SESSION['background_g'];?>;<? }else{?>#ACACDE<? }?>; margin:0 auto;">
			<div class="row">
				<div class="my-2 fs-1 text-center text-light"><?=$paytitle;?></div>	 
			</div>
			<hr class="bg-danger border-2 border-top border-danger">
			<div class="row">
				<div class="col-sm-6 text-center" id="column1">
				<center>
					<div id="pay_qr_code" class="p-2" title="<?php echo $_SESSION['3ds2_auth']['payaddress'];?>?amount=<? echo $_SESSION['3ds2_auth']['payamt'];?>">
					</div>
				
					<div class="col-sm-12">
						<div class="address_coins text-break my-2" id="qr_code_address" onClick="CopyToClipboard2('#qr_code_address');" style="display:none"><?php echo $_SESSION['3ds2_auth']['payaddress'];?> </div>
							<br><a style="padding-left:10px; clear: both; position:relative; top:-20px; text-decoration:none; color:#FFFFFF; font-size:12px; background-color:#d07c00;" href="javascript:void(0)" onClick="CopyToClipboard2('#qr_code_address');">
							Copy QR Code <img src="../images/copy.png" alt="Copy Qrcode" title="Copy Qrcode" width="15"></a>	
						</div>
					</center>
				</div>

				<div class="col-sm-6" id="column2">
					<div class="my-2 py-2 badge rounded-pill w-100" style="background-color:#d07c00;" >TRANSACTION DETAILS</div>
					<? if(isset($_SESSION['info_data']['company'])){
					?> 
					<div class="my-2 text-start"><span class="text-light">Pay To:&nbsp;</span><span class="text-light">
					<? echo ($_SESSION['info_data']['company']);?></span></div>
					<?
					}?>
					<div class="my-2 text-start"><span class="text-light">Product/Service:&nbsp;</span><span class="text-light"><? if(isset($_SESSION['3ds2_auth']['product'])) echo $_SESSION['3ds2_auth']['product'];?></span></div>
				
					<div class="my-2 text-start"><span class="text-light">Total Amount:&nbsp;</span><span class="text-light"><?php echo $_SESSION['3ds2_auth']['amount'];?> <?php echo $_SESSION['3ds2_auth']['currency'];?> ( <strong><?php echo $_SESSION['3ds2_auth']['payamt'];?> <?=$currname;?></strong> )</span></div>
				</div>

					
					<div class="text-start text12 text-light">This QR code will be invalid after <span id="timer" class="col-sm-2 fs-6 text-light">15:00</span> minutes. Please scan and complete the payment from your bank App within <span id="timer1" class="col-sm-2 fs-6 text-light">15:00</span> minutes.</div>

					<div class="iHavPaid1 text-end"><hr class="bg-danger border-2 my-2 border-top border-danger" >
					<a id="iHavPaidLink" class="btn text-light"style="background-color:#d07c00;" href="<?=$processed;?>">I HAVE PAID</a></div>
					
		</div>
		<?
		if(isset($_SESSION['3ds2_auth'])){
			//unset($_SESSION['3ds2_auth']);
		}
	}
	?></div>
	</div>
</div>
</body>
</html>