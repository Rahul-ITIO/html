<? if(isset($data['ScriptLoaded'])){ ?>
<?
$getresponse=$data['getresponse'];
//echo "<br/> getresponse=>"; print_r($getresponse);
/*
if(!isset($_SESSION['s30_count'])){
	if(isset($data['s30_count'])&&$data['s30_count']){
		$_SESSION['s30_count'] = (int)$data['s30_count'];
	}else{
		$_SESSION['s30_count'] = 10;
	}
}else{
	$_SESSION['s30_count']--;
}
*/	


//echo "<br/>intent_paymentUrl=>".$_SESSION['SA']['intent_paymentUrl'];
//echo "<br/>intent_acitve=>".$_SESSION['SA']['intent_acitve'];
/*
if((!isset($_SESSION['SA']['intent_acitve']))&&(isset($_SESSION['SA']['intent_paymentUrl']))&&($_SESSION['SA']['intent_paymentUrl'])){
	$_SESSION['SA']['intent_acitve']=1;
	$intent_paymentUrl=$_SESSION['SA']['intent_paymentUrl'];
	//echo "<br/>intent_paymentUrl2=>".$_SESSION['SA']['intent_paymentUrl'];
	header("Location:$intent_paymentUrl");
	//exit;
}
*/	
//echo $post['type'];
$pay_type=strtolower($data['t'][$_SESSION['SA']['type']]['name2']);
if(isset($_REQUEST['dtest'])){
	echo "<br/> pay_type=>".$pay_type;
	echo "<br/><br/> getresponse=>"; print_r($getresponse);
}
if(strstr($pay_type,"upi")){ $pay_type="upi"; }
elseif($pay_type=="ewallets"){ $pay_type="ewallets"; }
elseif(strstr($pay_type,"net")){ $pay_type="netbanking"; }
else{
$pay_type="default";
}

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
		if(strpos($url,"/transaction_processing")!==false){
			
		}else{
			header("Location:$url");
		}
	}
}

function nexturl_f($url){
	$url_1=url_f($url);
	if($url_1){
		if(strpos($url,"/transaction_processing")!==false){
			
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
	
	
	if(($data['moto_vt']==true||$getresponse['status_nm']==0)&&($_SESSION['s30_count']>0)){
		if(isset($data['check_status'])&&$data['check_status']){
			$nexturl=$data['Host']."/".$data['check_status'];
			include('api/loading_icon'.$data['iex']);
		}else{
			$nexturl=$data['source_url'];
		}
		$nexturl_type='moto_vt';
	}elseif($getresponse['status_nm']==1){
		$nexturl=$data['success_url'];
		$nexturl_type='success_url';
	}elseif($getresponse['status_nm']==2){
		$nexturl=$data['failed_url'];
		$nexturl_type='failed_url';
	}elseif($getresponse['status_nm']==0){
		$nexturl=$data['source_url'];
		$nexturl_type='source_url';
	}
	
	
	if((!isset($_GET['redirecturl']))||(empty($_GET['redirecturl']))){
		$redirecturl=nexturl_f($nexturl);
	}
	// redirect - to intent url if exists (acq 743) add by 
	if(isset($_SESSION['intent_url'])) {
		$intent_url = trim($_SESSION['intent_url']); 
		unset($_SESSION['intent_url']);
		header("Location:$intent_url");
		exit;
	}

$template_header=($data['FrontUI']."/".$data['frontUiName']."/user/template.header".$data['iex']);
if(!file_exists($template_header)){
?>
<style>
body{color:#72869d!important;background-color:#e2e2e2;border-color:#e2e2e2}
</style>
<? } ?>

<style>
body { background:#ffffff !important; }
.timerActive .proccess_timer_border{display:block;}
.proccess_timer_border{display:none;float:unset;width:110px;height:2px;text-align:center;clear:both;position:relative;margin:0 auto 10px;background:#020024;background:linear-gradient(90deg,rgba(2,0,36,1) 0%,rgba(218,0,203,1) 0%,rgba(204,204,204,1) 0%,rgba(255,255,255,1) 0%,rgba(255,255,255,1) 25%,rgba(197,196,198,1) 50%,rgba(255,255,255,1) 75%,rgba(255,255,255,1) 100%)}


.container-fluid.fixed {background: transparent;}

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
	html .transaction_processing .containerMain{width:calc(100% - 50px);margin:5% auto 0!important;padding:20px;display:block;float:unset;left:0}
}

</style>
<div class="containerMain processing text-center">
	
<? if($pay_type=="upi"){ ?>
<div><img class="float-start" src="<?=$data['Host'];?>/images/upi.png" style="height:50px;width:90px;"/></div>
<? } ?>	
<div class="text-center clearfix"><i class="fa-solid fa-circle-info text-info fa-w-16 fa-6x"></i></div>
	
<? if($pay_type!="upi"){ ?>	
<div class="text-header my-2"><?=$data['header_suc']?></div>
<? if($getresponse['reason']){?>
<h4 class="text-reason">Reason : <?=($getresponse['reason']?$getresponse['reason']:$getresponse['status']);?></h4>
<? } ?>
<? }else{ ?>
<div class="my-2" style="font-size:16px !important;">Please Login to your UPI app and approve the payment request for </div>
<? } ?>


	<h4 class="text-amt my-3"><?=get_currency($getresponse['curr']);?><?=$getresponse['amt']?></h4>
	
	<? if($pay_type!="upi"){ ?>
	<div class="text-muted"> Transaction ID : <?=$getresponse['transaction_id']?></div>
	<div class="text-muted"> <?=date("l jS \of F Y h:i:s A", strtotime($getresponse['tdate']));?> </div>
	<div class="text-footer"><?=$data['footer_suc']?></div>
	<a class='submit1 btn btn-primary nopopup' target='_top' href='<?=$redirecturl;?>'>Go to Merchant Website</a>
	<? }else{ ?>
	<div class="my-2 fw-lighter" style="font-size:16px !important;">Please be Patience awaiting to get responce</div>
	
	
	<div class="my-2">
	<div class="text-center fw-light">Approve Payment Within <span id="timer" class="proccess_timer" style="display:none1">00:30</span></div>
	</div>
	
	<div class="proccess_timer_border" >&nbsp;</div>
	<? } ?>
	
	<br/>

</div>
<?
//cmn
//exit;
?>
<script>
window.name='authenticate';

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



$(document).ready(function(){ 
	var redirecturl="<?=urldecode($redirecturl);?>";
	if(redirecturl){
		$('body').addClass('timerActive');
		$('#timer').slideDown(100);
		timeLeft = 29988; // 999.6333 sec * 30 sec ;
		//timeLeft = 899678; // 15 min = 59978.53333333333 * 15 ;
		//timeLeft = 59978; // 1 min 
		
		setTimeout(function(){ 
			//alert(processed); 
			top.window.location.href = redirecturl;
		}, timeLeft);
		
		timer = $('#timer');
		setInterval(updateTimer, 1000);
	}
	
});
</script>

<?

	
	
	if(isset($_GET['dtest'])){
		echo "<br/><br/><hr/>tr_status=> ".$tr_status;
		echo "<hr/>nexturl_type=> ".$nexturl_type;
		echo "<hr/>nexturl=> ".$nexturl;
		
		echo "<hr/>success_url=> ".$data['success_url'];
		echo "<hr/>failed_url=> ".$data['failed_url'];
		echo "<hr/>redirecturl=> ".$redirecturl;
		echo "<hr/>hkip_status_url=> ".$hkip_status_url;
		echo "<hr/>status_cc=> ".$status_cc;echo "<hr/>getresponse=>";
		print_r($getresponse);
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



