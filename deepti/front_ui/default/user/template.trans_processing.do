<? if(isset($data['ScriptLoaded'])){ ?>
<?

$getresponse=$data['getresponse'];
if(isset($data['mop'])&&trim($data['mop']))$pay_type=strtoupper($data['mop']);
else $pay_type="default";


if(isset($_REQUEST['dtest']))
{
	echo "<br/> pay_type=>".@$pay_type;
	echo "<br/><br/> 2 getresponse=>"; print_r(@$getresponse);
	
	echo "<hr/>33 transID=>".@$getresponse['transID'];
	echo "<hr/>return_response_arr=>";print_r(@$return_response_arr);
	
}
if(strstr($pay_type,"UPI")){ $pay_type="upi"; }
elseif($pay_type=="WL"){ $pay_type="ewallets"; }
elseif(strstr($pay_type,"NB")){ $pay_type="netbanking"; }
else { $pay_type="default";}

if(isset($_REQUEST['dtest'])){
	echo "<br/> pay_type3=>".$pay_type;
}



function url_f($url){
	$result=0;
	if(($url)&&((strpos($url,"http:")!==false) || (strpos($url,"https:")!==false))){
		$result=1;
	}
	return $result;
}
function header_f($url){
	$url_1=url_f($url);
	if($url_1){
		if(strpos($url,"/trans_processing")!==false){
			
		}else{
			header("Location:$url");
		}
	}
}

function nexturl_f($url){
	$url_1=url_f($url);
	if($url_1){
		if(strpos($url,"/trans_processing")!==false){
			
		}else{
			return $url;
		}
	}
}
	

	unset($_GET['action']);
	$redirecturl="";$transID="";$get="";
	
	if((isset($_GET['transID']))&&(!empty($_GET['transID']))){
		$transID=$_GET['transID'];
		//unset($_GET['transID']);
	}
	if((isset($_GET['redirecturl']))&&(!empty($_GET['redirecturl']))){
		$redirecturl=$_GET['redirecturl'];
		unset($_GET['redirecturl']);
		if(strpos($redirecturl,'id_order')!==false){
			unset($_GET['id_order']);
		}
	}

	if(isset($_GET)){
		$get=http_build_query($_GET);
	}
	
	if(strpos($redirecturl,'?')!==false){
		$redirecturl=nexturl_f($redirecturl."&".$get);
	}else{
		$redirecturl=nexturl_f($redirecturl."?".$get);
	}
	
	

	if(isset($transID_tr)&&$transID_tr){$transID=$transID_tr;}
	$typenum="";
	if(isset($type_tr)&&$type_tr){$typenum=$type_tr;}
		
	$nexturl=''; $nexturl_type='';
	
	
	if(($data['moto_vt']==true||$getresponse['order_status']==0)&&($_SESSION['s30_count']>0)){
		if(isset($data['check_status'])&&$data['check_status']){
			$nexturl=$data['Host']."/".$data['check_status'];
			include('api/loading_icon'.$data['iex']);
		}else{
			$nexturl=$data['source_url'];
		}
		$nexturl_type='moto_vt';
	}if($getresponse['order_status']==0){
		$nexturl=$data['source_url'];
		$nexturl_type='source_url';
	}elseif($getresponse['order_status']>0){
		$nexturl=$data['return_url'];
		$nexturl_type='return_url';
	}
	
	
	if((!isset($_GET['redirecturl']))||(empty($_GET['redirecturl']))){
		$redirecturl=nexturl_f($nexturl);
	}
	// redirect - to intent url if exists (acq 743) add by 
	/*
	if(isset($_SESSION['intent_url'])) {
		$intent_url = trim($_SESSION['intent_url']); 
		unset($_SESSION['intent_url']);
		header("Location:$intent_url");
		exit;
	}
	*/

$template_header=($data['FrontUI']."/".$data['frontUiName']."/user/template.header".$data['iex']);
if(!file_exists($template_header)){
?>
<style>
body{color:#72869d!important;background-color:#e2e2e2;border-color:#e2e2e2}
</style>
<? } ?>

<style>
.proccess_timer{/*font-size:14px;color:#5c5c5c;text-align:center;float:left;*/}
.timerActive .proccess_timer_border{display:block;}
.proccess_timer_border{display:none;float:unset;width:110px;height:2px;text-align:center;clear:both;position:relative;margin:0 auto 10px;background:#020024;background:linear-gradient(90deg,rgba(2,0,36,1) 0%,rgba(218,0,203,1) 0%,rgba(204,204,204,1) 0%,rgba(255,255,255,1) 0%,rgba(255,255,255,1) 25%,rgba(197,196,198,1) 50%,rgba(255,255,255,1) 75%,rgba(255,255,255,1) 100%)}


.submit{float:none;display:block;text-decoration:none;clear:both;width:80%;margin:20px auto;padding:10px;background:#ff8c00;border:0;color:#fff!important;font-size:16px;text-transform:uppercase;border-radius:3px;font-weight:700}
br {display:none;}
/*body{margin:0;padding:0;overflow:hidden;overflow-y: auto;width:100%;height:100%;font-size:14px;font-family:Arial,Helvetica,sans-serif;color:#5d5c5d;line-height:24px;text-align:center;color:#468847;}	
p{font-size:16px;margin:4px 0;font-family:Arial,Helvetica,sans-serif;color:#5d5c5d;float:left;width:100%;line-height:22px}
.container-fluid.fixed {background: transparent;}*/

h2{color:#575655;}
h3{color:#ff8c00;}
h4{color:#6a6a6a;}
h5.text-amt {font-size:18px;}

.containerMain{position:relative;display:flex;flex-direction:column;min-width:0;word-wrap:break-word;background-color:#fff;background-clip:border-box;border:1px solid rgba(0,0,0,0.1);width:60%;margin:20px auto 0 auto;border-radius:20px;padding:55px;float:unset;}

.hr{margin:10px 0 0;border:0;border-top:1px solid rgba(0,0,0,0.1);height:11px}
.text-footer {padding: 10px 0 0 0;margin-top:1rem;margin-bottom:1rem;border:0;border-top:1px solid rgba(0,0,0,0.1)}
.text-muted {color:#969696 !important;}
.text-amt {color:#ffc107!important;font-size:24px !important;}

@media (max-width:999px){
	html .trans_processing .containerMain{width:calc(100% - 50px);margin:5% auto 0!important;padding:20px;display:block;float:unset;left:0}
}

.box-width{width:500px;}
@media (max-width:500px){
.box-width{width: auto !important;}
}
</style>
<div class="containerMain processing text-center rounded-tringle mt-5 box-width" style="max-width:500px; margin:0 auto;">
	
<? if($pay_type=="upi"){ ?>
<div><img class="float-start" src="<?=$data['Host'];?>/images/upi.png" style="height:50px;width:90px;"/></div>
<? } ?>	
<div class="text-center clearfix"><i class="fa-solid fa-circle-info text-info fa-w-16 fa-6x"></i></div>
	
<? if($pay_type!="upi"){ ?>	
<div class="text-header my-2"><?=$data['header_msg']?></div>
<? if(isset($getresponse['reason'])&&$getresponse['reason']){?>
<h4 class="text-reason">Reason : <?=($getresponse['reason']?$getresponse['reason']:$getresponse['status']);?></h4>
<? } ?>
<? }else{ ?>
<div class="my-2" style="font-size:16px !important;">Please Login to your UPI app and approve the payment request for </div>
<? } ?>


<div class="my-2">
	<div class="text-center fw-light">Approve Payment Within <i class="fa-solid fa-spinner fa-spin-pulse"></i> <span id="timer" class="proccess_timer" style="display:none1">00:30</span></div>
	</div>
	
	<div class="proccess_timer_border" >&nbsp;</div>
	

	<div class="my-2 fs-5 text-primary-emphasis"><?=get_currency($getresponse['bill_currency']);?><?=$getresponse['amt']?></div>
	
	<? if($pay_type!="upi"){ ?>
	<div class="my-2 fs-6 fw-bold text-info-emphasis"> TransID : <?=$getresponse['transID']?></div>
	<div class="text-muted my-2 fs-6"> Referance : <?=$getresponse['reference']?></div>

	<div class="my-2 fs-6 fw-bold text-secondary-emphasis"> <?=date("l jS \of F Y h:i:s A", strtotime($getresponse['tdate']));?> </div>

	<div class="text-footer"><?=$data['footer_msg']?></div>

	<a class='submit1 btn btn-primary nopopup' target='_top' href='<?=$redirecturl;?>'  onclick="clearIntervalf();"><i class="fa-solid fa-spinner fa-spin-pulse hide"></i> Go to Merchant Website</a>
	<? }else{ ?>
	<div class="my-2 fw-lighter" style="font-size:16px !important;">Please be Patience awaiting to get responce</div>
	
	
	
	<? } ?>
	
	
	
	<br/>

</div>
<?
//cmn
//exit;
?>
<script>
//window.name='authenticate';

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

var trans_auto_expired = <?=(isset($getresponse['trans_auto_expired'])&&trim($getresponse['trans_auto_expired'])? (59978.53333333333 * (int)$getresponse['trans_auto_expired']):299892)?>; 
/* after 299892 = 59978.53333333333 * 5 minutes ; */

var timeLeft = 0;
var timer;



$(document).ready(function(){ 

	if(window.opener && window.opener.document && opener.transID !='') {
		window.close();
	}
	//alert("lllljjjjj"); 
	
	if (window.opener && window.opener.document) { 
		window.close();
		//alert(opener.transID);
	}

	var redirecturl="<?=urldecode($redirecturl);?>";
	if(redirecturl){
		$('body').addClass('timerActive');
		$('#timer').slideDown(100);
		
		/*
		timeLeft = 29988; // 999.6333 sec * 30 sec ;
		//timeLeft = 899678; // 15 min = 59978.53333333333 * 15 ;
		//timeLeft = 59978; // 1 min 
		
		setTimeout(function(){ 
			//alert(processed); 
			 top.window.location.href = redirecturl;
		}, timeLeft);
		*/
		
		timeLeft = trans_auto_expired; // after 299892 = 59978.53333333333 * 5 minutes ; 
		/*	clear Interval	*/
		setTimeout(function(){ 
			clearIntervalf();
		}, trans_auto_expired); // after 299892 = 59978.53333333333 * 5 minutes ; 
		
		
		
		
		timer = $('#timer');
		setInterval(updateTimer, 1000);
	}
	
});
</script>


<?
//$transID='';
if(isset($getresponse['transID'])&&$getresponse['transID']) $transID=$getresponse['transID'];
elseif(isset($_REQUEST['transID'])&&$_REQUEST['transID']) $transID=$_REQUEST['transID'];
elseif(isset($_REQUEST['orderset'])&&$_REQUEST['orderset']) $transID=$_REQUEST['orderset'];
elseif(isset($_SESSION['transID'])) $transID=$_SESSION['transID'];
elseif(isset($_SESSION['SA']['transID'])) $transID=$_SESSION['SA']['transID'];

if(isset($transID)&&$transID){
	$transID=transIDf($transID,0);
}

$data['fetch_trnsStatus']=$fetch_trnsStatus=$data['Host']."/fetch_trnsStatus".$data['ex']."?transID=".$transID;
$data['curl_status']=$curl_status=$data['Host']."/status".$data['ex']."?action=webhook&transID=".$transID;

if(isset($transID)&&$transID&&!isset($data['transID'])){
	$data['transID']="?transID={$transID}";
}
?>


<script>
/* Dev Tech : 23-05-09 fetch_trnsStatus for auto fetch_trnsStatus start after 30 second than every 10 second check for bank webhook updated than go to success or failed failed */

var bank_status ="<?=$data['Host']?>/bank_status<?=$data['ex']?>";
var fetch_trnsStatus ="<?=$data['fetch_trnsStatus']?>";
var transID ="<?=$transID?>";
var curl_status ="<?=$curl_status?>";

var wn=0;

var order_status = 0;
function curl_statusf(){
	
	if(wn){ alert('curl_statusf=>'+curl_status); }
	
	$.ajax({url: curl_status, type: "GET", dataType: 'json', success: function(result){
		//alert(result);
		//alert(result["order_status"]);
	}});
}

function fetch_trans_statusf(){
	//alert(fetch_trnsStatus);
	if(wn){ alert('fetch_trans_statusf=>'+fetch_trnsStatus); }
	
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


var clear_fetch_trans_statusf = '';
var clear_curl_statusf = '';
function clearIntervalf() {
  clearInterval(clear_fetch_trans_statusf);
  clearInterval(clear_curl_statusf);
}

if(transID){
	/*	for fetch_trnsStatus and status check	*/
	setTimeout(function(){ 
		clear_fetch_trans_statusf = setInterval(fetch_trans_statusf, 10000); // every 10000 = 1000 * 10 second 
	}, 30000); // after 30000 = 1000 * 30 second 
	
	/*	for acquirer status check	*/
	setTimeout(function(){ 
		clear_curl_statusf = setInterval(curl_statusf, 15000); // every 15000 = 1000 * 15 second 
	}, 20000); // after 20000 = 1000 * 20 second 
	
	
	/*	clear Interval	*/
	setTimeout(function(){ 
		clearIntervalf();
	}, trans_auto_expired); // after 419849 = 59978.53333333333 * 7 minutes ; 
	
	
}


//fetch_trans_statusf();
//curl_statusf();

</script>

<?

	
	
	if(isset($_GET['dtest'])){
		echo "<br/><br/><hr/>tr_status=> ".@$tr_status;
		echo "<hr/>nexturl_type=> ".@$nexturl_type;
		echo "<hr/>nexturl=> ".@$nexturl;
		
		echo "<hr/>return_url=> ".@$data['return_url'];
		echo "<hr/>source_url=> ".@$data['source_url'];
		echo "<hr/>redirecturl=> ".@$redirecturl;
		echo "<hr/>hkip_status_url=> ".@$hkip_status_url;
		echo "<hr/>status_cc=> ".@$status_cc;echo "<hr/>3 getresponse=>";
		print_r(@$getresponse);
		//echo "<hr/>_SESSION=>";
		//print_r($_SESSION);
		//exit;
	}
	
	//exit;
	
	if($nexturl){
		//header_f($nexturl);
	}
	
	//exit;
}
?>



