<?if(isset($data['ScriptLoaded'])){?>
<?
$getresponse=$data['getresponse'];
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
	
	$redirecturl="";$transID="";$get="";
	if(isset($_GET)){
		$get=http_build_query($_GET);
	}
	
	$nexturl=''; $nexturl_type=''; $source_url='';
	
	
	if((isset($getresponse['source_url']))&&(trim($getresponse['source_url']))){
		$source_url=nexturl_f($getresponse['source_url']);
	}
	
	if(($data['moto_vt']==true||$getresponse['status_nm']==0)&&($_SESSION['s30_count_1']<1)&&(isset($getresponse['type'])&&!in_array($getresponse['type'],["27","28"]))){
		$nexturl=$data['Host']."/bankstatus".$data['ex']."?transID=".$getresponse['transID']."&action=redirect&check_auth=1";
		$redirecturl=nexturl_f($nexturl);
		include('api/loading_icon'.$data['iex']);
	}else{
		$redirecturl=nexturl_f($data['urlpath']);
		include('api/loading_icon'.$data['iex']);
	}
	
	
	//echo "<br/>redirecturl=> ".$redirecturl;  echo "<br/>s30_count_1=> ".$_SESSION['s30_count_1']; 

		
$template_header=($data['FrontUI']."/".$data['frontUiName']."/user/template.header".$data['iex']);
if(!file_exists($template_header)){
?>
<style>
body{color:#72869d!important;background-color:#e2e2e2;border-color:#e2e2e2}
</style>
<? } ?>

<style>
.container-flex.user_header_main {
    display1: none;
}
body{background:<?=$_SESSION['background_g'];?> !important;border-color:#e2e2e2}
.proccess_timer{font-size:14px;color:#5c5c5c;text-align:center;float:left;width:100%;margin:3px 0}
.timerActive .proccess_timer_border{display:block;}
.proccess_timer_border{display:none;float:unset;width:110px;height:2px;text-align:center;clear:both;position:relative;margin:0 auto 10px;background:#020024;background:linear-gradient(90deg,rgba(2,0,36,1) 0%,rgba(218,0,203,1) 0%,rgba(204,204,204,1) 0%,rgba(255,255,255,1) 0%,rgba(255,255,255,1) 25%,rgba(197,196,198,1) 50%,rgba(255,255,255,1) 75%,rgba(255,255,255,1) 100%)}


.submit{float:none;display:block;text-decoration:none;clear:both;width:80%;margin:20px auto;padding:10px;background:#ff8c00;border:0;color:#fff!important;font-size:16px;text-transform:uppercase;border-radius:3px;font-weight:700}
br {display:none;}
body{margin:0;padding:0;overflow:hidden;overflow-y: auto;width:100%;height:100%;font-size:14px;font-family:Arial,Helvetica,sans-serif;color:#5d5c5d;line-height:24px;text-align:center;color:#468847;}	
p{font-size:16px;margin:4px 0;font-family:Arial,Helvetica,sans-serif;color:#5d5c5d;float:left;width:100%;line-height:22px}
.container-fluid.fixed {background: transparent;}

h2{color:#575655;}
h3{color:#ff8c00;}
h4{color:#6a6a6a;}
h5.text-amt {font-size:18px;}

.containerMain{position:relative;display:flex;flex-direction:column;min-width:0;word-wrap:break-word;background-color:#fff;background-clip:border-box;border:1px solid rgba(0,0,0,0.1);width:60%;margin:5% auto 0 auto;border-radius:20px;padding:55px;float:unset;}

.hr{margin:10px 0 0;border:0;border-top:1px solid rgba(0,0,0,0.1);height:11px}
.text-footer {padding: 10px 0 0 0;margin-top:1rem;margin-bottom:1rem;border:0;border-top:1px solid rgba(0,0,0,0.1)}
.text-muted {color:#969696 !important;}
.text-amt {color:#6a6a6a;font-size:24px;}

@media (max-width:999px){
	html .transaction_processing .containerMain{width:calc(100% - 50px);margin:5% auto 0!important;padding:20px;display:block;float:unset;left:0}
}

</style>
<div class="containerMain processing">
	<div id="timer" class="proccess_timer" style="display:none1">00:20</div>
	<div class="proccess_timer_border" >&nbsp;</div>
	
	
	<i class="far fa-clock text-warning fa-w-16 fa-7x"></i>
	
	
	<div class="text-header"><?=$data['header_suc']?></div>
	<div class="hr">&nbsp;</div>
	<? if($getresponse['reason']){?>
		<h4 class="text-reason">Reason  : <?=($getresponse['reason']?$getresponse['reason']:$getresponse['status']);?></h4>
	<? } ?>
	<h4 class="text-amt">Amount : <?=get_currency($getresponse['curr']);?><?=$getresponse['amount']?></h4>
	<div class="text-muted"> Transaction ID : <?=$getresponse['transaction_id']?></div>
	<div class="text-muted"> <?=date("l jS \of F Y h:i:s A", strtotime($getresponse['tdate']));?> </div>
	<div class="text-footer"><?=$data['footer_suc']?></div>
	
	
	<a class='submit1 btn btn-warning nopopup' target='_top' href='<?=$source_url;?>'>Go to Merchant Website</a><br/>

</div>
<?
//cmn
//exit;
?>
<script>

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
	var redirecturl="<?=$redirecturl?>";
	if(redirecturl){
		$('body').addClass('timerActive');
		$('#timer').slideDown(100);
		timeLeft = 19992; // 999.6333 sec * 20 sec ;
		//timeLeft = 29988; // 999.6333 sec * 30 sec ;
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



