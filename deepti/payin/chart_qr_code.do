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
		$bill_currency='';
	}
		
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
		
		var qr = $('#qr_code_div_id');
		
		var data = "<?php echo $_SESSION['3ds2_auth']['payaddress'];?>";
		if (qr.length && data != null && data.length > 0) {
			qr.html('');
			var qrcode = new QRCode(
				'qr_code_div_id',
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
<div class="qr_code_div">

		<div class="coins_amt">
			<div class="bch" style="font-size:24px;font-weight:bold;color:#000;"><?php echo $_SESSION['3ds2_auth']['payamt'];?> <?=$_SESSION['3ds2_auth']['paycurrency'];?></div>
			<div class="none_bch" style="font-size:18px;font-weight:bold;color:#999;margin-bottom:40px;"><?php echo $_SESSION['3ds2_auth']['bill_amt'];?> <?php echo $bill_currency;?></div>
		</div>
		
		<div id="qr_code_div_id" class="fl qr_code" border="0" title="<?php echo $paytitle;?>:<?php echo $_SESSION['3ds2_auth']['payaddress'];?>?amount=<?php echo $_SESSION['3ds2_auth']['payamt'];?>" style="width:150px;margin:auto;">
		</div>
		
		
		<div class="row w-100 clear" style="margin:44px 0 0 0;"> </div>
		
		<div class="address_coins" id="qr_code_address" onClick="copytext_f(this,'<?=@$paytitle;?>');" data-value='<?=@$_SESSION['3ds2_auth']['payaddress'];?>' style="text-align:left;padding-left:10px;" ><?=@$_SESSION['3ds2_auth']['payaddress'];?></div>
		
		<a style="padding-left:10px; float:right;clear: both; position:relative; top:-20px;margin-right:10px;" href="javascript:void(0)"  onClick="copytext_f(this,'<?=@$paytitle;?>');" data-value='<?=@$_SESSION['3ds2_auth']['payaddress'];?>' >
		<img src="<?=$data['Host']?>/images/copy.png" alt="Copy Qrcode" title="Copy Qrcode" width="15"></a>
		
</div>
