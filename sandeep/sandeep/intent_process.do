<?
if(!isset($data['config_root'])){
	$config_root='config_root.do';
	if(file_exists($config_root)){include($config_root);}

	if(isset($_SESSION['3ds2_auth']['bank_process_url'])){
		$data['Host']=$_SESSION['3ds2_auth']['bank_process_url'];
	}
	if(isset($_SESSION['3ds2_auth']['paytitle'])&&$_SESSION['3ds2_auth']['paytitle']){
		$data['payTitle']=$_SESSION['3ds2_auth']['paytitle'];
	}
	if(isset($_SESSION['3ds2_auth']['appName'])&&$_SESSION['3ds2_auth']['appName']){
		$data['appName']=$_SESSION['3ds2_auth']['appName'];
	}
	
	if(isset($_SESSION['3ds2_auth']['payaddress'])&&$_SESSION['3ds2_auth']['payaddress']){
		$data['intent_paymentUrl']=$_SESSION['3ds2_auth']['payaddress'];
	}
}


if(isset($data['intent_paymentUrl'])&&trim($data['intent_paymentUrl']))
$data['intent_paymentUrl']=urldecodef($data['intent_paymentUrl']);


if(isset($transID)&&$transID){
	$data['transID']="?transID={$transID}";
}
if(!isset($data['payTitle'])){
	$data['payTitle']='UPI / APP / Wallet';
	//$data['payTitle']='Paytm ';
}
if(!isset($data['appName'])){
	$data['appName']='UPI / APP / Wallet ';
}

$data['Host2']=$data['Host'];
		
?>

<?
$transID='';
if(isset($_REQUEST['transID'])&&$_REQUEST['transID']) $transID=$_REQUEST['transID'];
elseif(isset($_REQUEST['orderset'])&&$_REQUEST['orderset']) $transID=$_REQUEST['orderset'];
elseif(isset($_SESSION['transID'])) $transID=$_SESSION['transID'];
elseif(isset($_SESSION['SA']['transID'])) $transID=$_SESSION['SA']['transID'];

$transID=transIDf($transID,0);

$data['fetch_trnsStatus']=$fetch_trnsStatus=$data['Host']."/fetch_trnsStatus".$data['ex']."?transID=".$transID;
$data['curl_status']=$curl_status=$data['Host']."/status".$data['ex']."?action=webhook&transID=".$transID;

if(isset($transID)&&$transID&&!isset($data['transID'])){
	$data['transID']="?transID={$transID}";
}
?>

<!DOCTYPE html>
<html lang="en-US">
<head>
<title>Continue the process ...</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" >
<?/*?>
<meta http-equiv="Content-Security-Policy" content="default-src 'self'; font-src * 'unsafe-inline'; style-src * 'unsafe-inline'; script-src * 'unsafe-inline' 'unsafe-eval'; img-src * data: 'unsafe-inline'; connect-src * 'unsafe-inline'; frame-src *; object-src 'none'" />
<?*/?>
<script src="<?=$data['Host2']?>/js/jquery-3.6.0.min.js"></script>
<style>
body{margin:0;padding:0;overflow:auto;width:100%;height:100%;
font-size:14px; font-family: Arial, Helvetica, sans-serif; color: #5d5c5d; 
	 line-height: 24px; text-align: center;
	color: #468847;
	background: url("<?php echo $data['Host'];?>/images/criss-cross.png");
	border-color: #d6e9c6;
}
h1 {float:left;font-size:18px;width:100%;border-bottom:2px solid #ccc;padding:0 0 20px 0;margin:0 0 20px 0;font-weight:normal;line-height:150%;}
.warper {
	display:block;width:310px;margin:10px auto; 
}
.warper_div1 {
	float:left;display:block;width:100%;padding:0px;margin:10px auto; background-color:#fff;border:4px solid #ccc;border-radius:7px;
}
.warper_div {
    float: left;
    display: block;
    width: 310px;
    padding: 0px;
    margin: -221px 0 0 -157px;
    background-color: #fff;
    border: 4px solid #ccc;
    border-radius: 7px;
    position: absolute;
    top: 50%;
    left: 50%;
}

.text_place{font-size:16px; margin:10px 10px; font-family: Arial, Helvetica, sans-serif; color: #5d5c5d; float:left; width:100%; line-height: 22px; text-align:justify;}
.red {color:red;}
.green {color:green;}
.qr_code {float:left;}

.coins_amt {float:right;text-align:right;}
.bch {font-size:24px;font-weight:bold;color:#000;}
.none_bch {font-size:18px;font-weight:bold;color:#999;}
.address_coins {float:right;text-align:right;font-size:18px;font-weight:normal;color:#000;margin: 168px 25px 0 0;}
.authenticated_div {float:left;width:100%;border-bottom:0px solid #ccc;padding:0 0 10px 0;margin:0 0 20px 0;font-weight:normal;display:none;}
.warper_master {padding:20px 40px 20px 20px;}
.payToNextDiv {float:left;width:100%;text-align:center;margin:10px 0 20px 0px;}
.payToNext{float:none;display:inline-block;background:#da8f05;padding:10px 30px;font-size:18px;color:#fff;text-decoration:none;border-radius:5px}

.iHavPaid1 {float:left;width:100%;}
.iHavPaid{float:right;background:#da8f05;padding:10px 30px;font-size:18px;color:#fff;text-decoration:none;border-radius:5px}

.hr {float:left;width:100%;clear:both;height:6px;margin:20px 0;border-bottom:2px solid #ccc;}

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
function intentf(){
	setTimeout(timerMessage, 10000); //10000
	//setTimeout(timerMessage, 100); //10000
}
function timerMessage() {
  $('.authenticated_div').show(1000);
  $('#redirected').hide(500);
}   

$(document).ready(function(){
  $(".iHavPaidLink").click(function(){
     //alert('lll');
	if (parent.window && parent.window.document) {
		//parent.window.close();
	}
	if (window.opener && window.opener.document) {
		window.opener.close();
	}
  });
});

</script>

<script>
/* Dev Tech : 23-04-25 fetch_trnsStatus for auto fetch_trnsStatus start after 30 second than every 10 second check for bank notify updated than go to success or failed failed */

var bank_status ="<?=$data['Host']?>/bank_status<?=$data['ex']?>";
var fetch_trnsStatus ="<?=$data['fetch_trnsStatus']?>";
var transID ="<?=$transID?>";
var curl_status ="<?=$curl_status?>";


var order_status = 0;
function curl_statusf(){
	//alert(curl_status);
	$.ajax({url: curl_status, type: "GET", dataType: 'json', success: function(result){
		//alert(result);
		//alert(result["order_status"]);
	}});
}

function check_statusf(){
	//alert(fetch_trnsStatus);
	$.ajax({url: fetch_trnsStatus+'&actionurl=viasystem', type: "GET", dataType: 'json', success: function(result){
		//alert(result);
		//alert(result["order_status"]);
		order_status = result["order_status"];
		if(result["order_status"] && result["order_status"] == 1 ){
			if (parent.window && parent.window.document) {
				//parent.window.close();
			}
			if (window.opener && window.opener.document) {
				//parent.window.close();
			}
			top.window.location.href=fetch_trnsStatus+'&actionurl=validate';
		}
		else if(result["order_status"] && result["order_status"] > 0 ){
			top.window.location.href=fetch_trnsStatus+'&actionurl=validate';
		}
	}});
}


var clear_check_statusf = '';
var clear_curl_statusf = '';
function clearIntervalf() {
  clearInterval(clear_check_statusf);
  clearInterval(clear_curl_statusf);
}

if(transID){
	/*	for fetch_trnsStatus and status check	*/
	setTimeout(function(){ 
		clear_check_statusf = setInterval(check_statusf, 10000); // every 10000 = 1000 * 10 second 
	}, 30000); // after 30000 = 1000 * 30 second 
	
	/*	for acquirer status check	*/
	setTimeout(function(){ 
		clear_curl_statusf = setInterval(curl_statusf, 15000); // every 15000 = 1000 * 15 second 
	}, 20000); // after 20000 = 1000 * 20 second 
	
	
	/*	clear Interval	*/
	setTimeout(function(){ 
		clearIntervalf();
	}, 419849); // after 419849 = 59978.53333333333 * 7 minutes ; 
	
	
}


//check_statusf();
//curl_statusf();

</script>

</head>
<body oncontextmenu='return false;'>
<div class="warper">
  <div class="warper_div">
    <div class="warper_master">
      <div class="text_place" >
        <div class="payToNextDiv" id="redirected">
          <h1>You will be redirected to <b>
            <?=$data['appName'];?>
            </b> for authentication. </h1>
          <p> </p>
          <a class="payToNext" href="<?=($data['intent_paymentUrl']);?>" target="_blank" onClick="intentf()">OK</a> 
		  <a class="payToNext" onClick="clearIntervalf();" href="<?=$data['Host']?>/bank_status<?=$data['ex']?><?=$data['transID']?>" target="_top">Cancel</a> </div>
        <div class="authenticated_div" >
          <p>Have you authenticated the transaction at <span class="green"><b>
            <?=$data['appName'];?>
            </span>?</p>
          <div class="payToNextDiv"><a class="payToNext iHavPaidLink" onClick="clearIntervalf();" href="<?=$data['Host']?>/bank_status<?=$data['ex']?><?=$data['transID']?>" target="_top">Yes</a></div>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
<?
if(isset($_SESSION['3ds2_auth'])){
	//unset($_SESSION['3ds2_auth']);
}
?>
</html>
