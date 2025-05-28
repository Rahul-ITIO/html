<?
$config_root='../config_root.do';
if(file_exists($config_root)){include($config_root);}
//echo "<br/>Host1=>".$data['Host']; echo "<br/>urlpath1=>".$urlpath;
?>
<!DOCTYPE html>
<html lang="en-US">
<head>
<title>Bank 3D Secure 2 Processing...</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
<style>
body{margin:0;padding:0;overflow:auto;width:100%;height:100%;font-size:14px;font-family:Arial,Helvetica,sans-serif;color:#5d5c5d;line-height:24px;text-align:center;color:#468847;background1:url("<?php echo $data['Host'];?>/images/criss-cross.png");border-color:#d6e9c6;overflow:hidden}

html iframe, html frame {
    position: relative;
    z-index: 0;
    height: 100vh !important;
    margin: 0 !important;
    padding: 0 !important;
    min-height: 100% !important;
    width: 100vw !important;
}
div#initiate3dsSimpleRedirect {
    position: relative;
    z-index: 0;
    width: 100% !important;
    height: 100% !important;
}

.loder_div{position:absolute;z-index:99;height:60px;width:270px;left:50%;top:0;margin:0 0 0 -140px;clear:both;padding:0}
.patience{text-align:center;position:relative;margin:-6px 0 0;white-space:nowrap;padding:0;color: #d10b13;line-height:130%;}

.middle{top:53%;left:20%;transform:translate(-20%,-50%);position:absolute}
.bar{width:5px;height:30px;background:#fff;display:inline-block;transform-origin:bottom center;border-top-right-radius:20px;border-top-left-radius:20px;animation:loader 1.2s linear infinite}
.bar1{animation-delay:.1s}
.bar2{animation-delay:.2s}
.bar3{animation-delay:.3s}
.bar4{animation-delay:.4s}
.bar5{animation-delay:.5s}
.bar6{animation-delay:.6s}
.bar7{animation-delay:.7s}
.bar8{animation-delay:.8s}

@keyframes loader {
	0%{transform:scaleY(0.1)}
	50%{transform:scaleY(1);background:#9acd32}
	100%{transform:scaleY(0.1);background:transparent}
}

</style>
<?
$transaction_id='';
if(isset($_REQUEST['orderset'])&&$_REQUEST['orderset']) $transaction_id=$_REQUEST['orderset'];
elseif(isset($_REQUEST['transaction_id'])&&$_REQUEST['transaction_id']) $transaction_id=$_REQUEST['transaction_id'];
elseif(isset($_SESSION['transaction_id'])) $transaction_id=$_SESSION['transaction_id'];
elseif(isset($_SESSION['SA']['transaction_id'])) $transaction_id=$_SESSION['SA']['transaction_id'];
$data['validate']=$validate=$data['Host']."/validate".$data['ex']."?transaction_id=".$transaction_id;
$data['curl_bankstatus']=$curl_bankstatus=$data['Host']."/bankstatus".$data['ex']."?action=webhook&orderset=".$transaction_id;
?>
<script type="text/javascript">
if (typeof jQuery == 'undefined') {
  document.write('<script type="text/javascript" src="<?=$data['Host']?>/js/jquery-3.6.0.min.js"><\/script>');        
  } 
</script>
<script>
var bank_status ="<?=$data['Host']?>/bank_status<?=$data['ex']?>";
var validate ="<?=$data['validate']?>";
var transaction_id ="<?=$transaction_id?>";
function check_statusf(){
	//alert(validate);
	$.ajax({url: validate, type: "GET", dataType: 'json', success: function(result){
		//alert(result);
		//alert(result["status_nm"]);
		if(result["status_nm"] && result["status_nm"] > 0 ){
			top.window.location.href=validate+'&actionurl=validate';
		}
	}});
}

if(transaction_id){
	setTimeout(function(){ 
		setInterval(check_statusf, 10000);  // every 1 second   
	}, 119957); // 2 minutes after
}



//timeLeft = 299892; // 5 minutes = 59978.53333333333 * 5 ; 
var timeLeft = 299892;
setTimeout(function(){ 
	if (parent.window && parent.window.document) {
		//parent.window.close();
	}
	if (window.opener && window.opener.document) {
		//parent.window.close();
	}
	top.window.location.href=bank_status;
	//check_statusf();
}, timeLeft); // 5 minutes after

//check_statusf();

</script>
</head>
<body oncontextmenu='return false;'>
<div class="loder_div">
<div class="middle">
  <div class="bar bar1"></div>
  <div class="bar bar2"></div>
  <div class="bar bar3"></div>
  <div class="bar bar4"></div>
  <div class="bar bar5"></div>
  <div class="bar bar6"></div>
  <div class="bar bar7"></div>
  <div class="bar bar8"></div>
  <div class="patience" >Please wait... your payment is being processed.<br/>Do not refresh or close your browser.</div>
</div>

</div>
<?php 
	
	if(isset($_SESSION['3ds2_auth'])){
		//echo htmlspecialchars_decode($_SESSION['3ds2_auth'], ENT_QUOTES | ENT_XML1, 'UTF-8');
		//echo html_entity_decode($_SESSION['3ds2_auth']);
		echo htmlspecialchars_decode($_SESSION['3ds2_auth']);
	} 
?>

</body>
<?
if(isset($_SESSION['3ds2_auth'])){
	//unset($_SESSION['3ds2_auth']);
}
?>
</html>