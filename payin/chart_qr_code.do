<?
$config_root='../config_root.do';
if(file_exists($config_root)){require_once($config_root);}
$data['Host2']=$data['Host'];



if(isset($_SESSION['url_redirect_mode'])&&trim($_SESSION['url_redirect_mode'])){
	unset($_SESSION['url_redirect_mode']);
}

// Dev Tech : 23-09-30 fetch transID 
$transID='';
if(isset($_REQUEST['transID'])&&$_REQUEST['transID']) $transID=$_REQUEST['transID'];
elseif(isset($_SESSION['transID'])) $transID=$_SESSION['transID'];
elseif(isset($_SESSION['SA']['transID'])) $transID=$_SESSION['SA']['transID'];

$transID=transIDf($transID,0);	
	
	if(isset($_SESSION['3ds2_auth']['processed'])&&$_SESSION['3ds2_auth']['processed'])
		$processed=$_SESSION['3ds2_auth']['processed'];
	else
		$processed=$data['Host']."/status".$data['ex']."?transID=".$transID;
	
	
	if(isset($_SESSION['3ds2_auth']['customer_service_email'])&&$_SESSION['3ds2_auth']['customer_service_email']){
		$_SESSION['customer_service_email']=$_SESSION['3ds2_auth']['customer_service_email'];
	}
	
	if(isset($_SESSION['3ds2_auth']['netWorkType'])&&$_SESSION['3ds2_auth']['netWorkType']){
		$paytitle=$_SESSION['3ds2_auth']['netWorkType'];
	}elseif(isset($_SESSION['3ds2_auth']['paytitle'])&&$_SESSION['3ds2_auth']['paytitle']){
		$paytitle=$_SESSION['3ds2_auth']['paytitle'];
	}else{
		$paytitle='';
	}
	
	// Bitcoin currency
	if(isset($_SESSION['3ds2_auth']['coinName'])&&$_SESSION['3ds2_auth']['coinName']){
		$paycurrency=$_SESSION['3ds2_auth']['coinName'];
	}elseif(isset($_SESSION['3ds2_auth']['currname'])&&$_SESSION['3ds2_auth']['currname']){
		$paycurrency=$_SESSION['3ds2_auth']['currname'];
	}elseif(isset($_SESSION['3ds2_auth']['paycurrency'])&&$_SESSION['3ds2_auth']['paycurrency']){
		$paycurrency=$_SESSION['3ds2_auth']['paycurrency'];
	}
	else{
		$paycurrency=' ';
	}
	
	
	if(isset($_SESSION['3ds2_auth']['bill_amt'])&&$_SESSION['3ds2_auth']['bill_amt']){
		$_SESSION['3ds2_auth']['amount']=$_SESSION['3ds2_auth']['bill_amt'];
	}
	
	if(isset($_SESSION['3ds2_auth']['bill_currency'])&&$_SESSION['3ds2_auth']['bill_currency']){
		$bill_currency=$_SESSION['3ds2_auth']['bill_currency'];
	}else{
		$bill_currency='';
	}

$microtimestamp_div_id=(new DateTime())->format('ymdHisu');
		
?>
<script src="<?=$data['Host2']?>/js/jquery-3.6.0.min.js"></script>
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
		
		var qr = $("#qr_code_div_id_<?=$microtimestamp_div_id;?>");
		
		var data = "<?php echo $_SESSION['3ds2_auth']['payaddress'];?>";
		if (qr.length && data != null && data.length > 0) {
			qr.html('');
			var qrcode = new QRCode(
				"qr_code_div_id_<?=$microtimestamp_div_id;?>",
				{
					text : data,
					width : 150,
					height : 150,
					colorDark : "#000000",
					colorLight : "#ffffff",
					correctLevel : QRCode.CorrectLevel.M
				});
		}
	});
</script>
<?/*?>
<style>
body{margin:0;padding:0;overflow:auto;width:100%;height:100%;
font-size:14px; font-family: Arial, Helvetica, sans-serif; color: #5d5c5d; 
	 line-height: 24px; text-align: center;
	color: #468847;
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
.address_coins {float:right;text-align:right;font-size:18px;font-weight:normal;color:#000;margin: 30px 105px 0 0;}
.qr_code_div {float:left;width:96%;border-bottom:2px solid #ccc;padding:0 0 40px 0;margin:0 0 20px 0;font-weight:normal;}
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
<?*/?>
<div class="qr_code_div" DONE_AJAX >

		<div class="text_place" style="text-align:left;" >
			<h1 style="display:none;"><?=$paytitle;?> </h1>
			
			<p class="my-1">Please transfer exactly <strong><?php echo $_SESSION['3ds2_auth']['payamt'];?> <?=$paycurrency;?></strong> to the provided <strong><?=$paycurrency;?></strong> address using the <b><?php echo $_SESSION['3ds2_auth']['netWorkType'];?></b> network protocol.</p>
			
			<p class="my-1">Ensure it's a single transaction and include any fees charged by your wallet provider. Your transaction will be successful once we receive the exact amount of <strong><?php echo $_SESSION['3ds2_auth']['payamt'];?> <?=$paycurrency;?></strong>. Any lesser amount will be refunded, but this process may take longer than usual. 

			<? if(isset($_SESSION['customer_service_email'])&&$_SESSION['customer_service_email']){ ?>
				For assistance, contact us at <a target='_blank' title="Customer Service Email" href="mailto:<?=@$_SESSION['customer_service_email'];?>?subject=I need help&body=Dear <?=$data['SiteName'];?>, I need your help about ..." class="" ><b><?=@$_SESSION['customer_service_email'];?></b></a>
			<? } ?>
			</p>
		</div>

		<div class="coins_amt">
			<div class="bch" style="font-size:24px;font-weight:bold;color:#000;margin:24px 0;"><?php echo $_SESSION['3ds2_auth']['payamt'];?> <?=$paycurrency;?></div>
			<div class="none_bch" style="font-size:18px;font-weight:bold;color:#999;margin-bottom:40px;display:none"><?php echo $_SESSION['3ds2_auth']['bill_amt'];?> <?php echo $bill_currency;?></div>
		</div>
		
		<div id="qr_code_div_id_<?=$microtimestamp_div_id;?>" class="fl qr_code" title="<?php echo $paytitle;?>:<?php echo $_SESSION['3ds2_auth']['payaddress'];?>?amount=<?php echo $_SESSION['3ds2_auth']['payamt'];?>" style="width:150px;margin:auto;float:unset;">
		</div>
		
		
		<div class="row w-100 clear" style="margin:44px 0 0 0;"> </div>
		
		<div class="address_coins" id="qr_code_address" onClick="copytext_f(this,'<?=@$paytitle;?>');" data-value='<?=@$_SESSION['3ds2_auth']['payaddress'];?>' style="text-align:left;padding-left:0px;overflow-x:auto;width:fit-content;word-break: break-all;font-size:15px;" ><?=@$_SESSION['3ds2_auth']['payaddress'];?></div>
		
		<a style="padding-left:10px; float:right;clear: both; position:relative; top:-20px;margin-right:10px;" href="javascript:void(0)"  onClick="copytext_f(this,'<?=@$paytitle;?>');" data-value='<?=@$_SESSION['3ds2_auth']['payaddress'];?>' >
		<img src="<?=$data['Host']?>/images/copy.png" alt="Copy Qrcode" title="Copy Qrcode" width="15"></a>

		<div class="iHavPaid1 col-sm-12 p-0 m-0 d-flex justify-content-center">
			<a id="iHavPaidLink" class="iHavPaid my-2 btn btn-slide next w-50 float-end bnnn666" onclick="pendingCheckStartf('reStart');">I HAVE PAID</a>
		</div>
		
</div>
