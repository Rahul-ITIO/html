<? if(isset($data['ScriptLoaded'])){ ?>
	<?
	$getresponse=$data['getresponse'];
	//echo "<br/> getresponse=>"; print_r($getresponse);
	
	if(isset($_GET['scrubbed_msg'])&&$_GET['scrubbed_msg']){
		$getresponse['reason']=$_GET['scrubbed_msg'];
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
			header("Location:$url");
		}
	}
	function nexturl_f($url,$post=''){
		$url_1=url_f($url);
		if($url_1){
			return $url;
		}else{
			return "";
		}
	}



	if((isset($_GET['redirecturl']))&&(!empty($_GET['redirecturl']))){
		$failed_url=nexturl_f(stf($_GET['redirecturl']),$getresponse);
	}elseif($data['moto_vt']==true){
		$source_url = $data['source_url']."&actionurl=success";
		$failed_url=nexturl_f(stf($source_url),$getresponse);
	}elseif(!empty($data['failed_url'])){
		$failed_url=nexturl_f(stf($data['failed_url']),$getresponse);
	}else{
		if(!empty($data['ucancel'])){
			$failed_url=squrlf(stf($data['ucancel']),$getresponse);
		}
	}
	
	$dataPost=json_encode($getresponse);
	
	
	#####	NOTIFYBRIDGE by DevTech:24-12-22		######
	if(isset($data['NOTIFYBRIDGE'])&&trim($data['NOTIFYBRIDGE'])){
		if(isset($data['notify_url'])&&$data['notify_url'])
			$_SESSION['notifybridge_url_nofity']=$data['notify_url'];
		
		$_SESSION['transID']=$getresponse['transID'];
		$_SESSION['notifybridge_url_type']='failed_url';
		$_SESSION['notifybridge_url_mer']=$failed_url;
		$_SESSION['notifybridge_res']=$getresponse;
		$failed_url=$data['Host']."/".$data['NOTIFYBRIDGE'].$data['ex']."?transID=".$getresponse['transID'];
	}
	
	if(isset($_SESSION['failed_url'])){
		unset($_SESSION['failed_url']);
	}
	

	$template_header=($data['FrontUI']."/".$data['frontUiName']."/user/template.header".$data['iex']);
	if(!file_exists($template_header)){
	?>
	<style>
	body{color:#884646;background-color:#f5d8d8;border-color:#e9c6c6;}	
	</style>
	<?}?>

	<style>
.proccess_timer{font-size:14px;color:#5c5c5c;text-align:center;float:left;width:100%;margin:3px 0}
.timerActive .proccess_timer_border{display:block;}
.proccess_timer_border{display:none;float:unset;width:110px;height:2px;text-align:center;clear:both;position:relative;margin:0 auto 10px;background:#020024;background:linear-gradient(90deg,rgba(2,0,36,1) 0%,rgba(218,0,203,1) 0%,rgba(204,204,204,1) 0%,rgba(255,255,255,1) 0%,rgba(255,255,255,1) 25%,rgba(197,196,198,1) 50%,rgba(255,255,255,1) 75%,rgba(255,255,255,1) 100%)}

	body{margin:0;padding:0;overflow:hidden;overflow-y: auto;width:100%;height:100%;font-size:14px;font-family:Arial,Helvetica,sans-serif;color:#5d5c5d;line-height:24px;text-align:center;color:#468847;}	
	p{font-size:18px;margin:10px;font-family:Arial,Helvetica,sans-serif;color:#5d5c5d;float:left;width:100%;line-height:34px;}
	.container-fluid.fixed{background:transparent;}

	h3{color:#ff0000;}
	h4{color:#6a6a6a;}
	h5.text-amt {font-size:18px;}
	.containerMain{position:relative;display:flex;flex-direction:column;min-width:0;word-wrap:break-word;background-color:#fff;background-clip:border-box;border:1px solid rgba(0,0,0,0.1);width:60%;margin:10% auto 0 auto;border-radius:20px;padding:55px;float:unset;}

	.hr{margin-top:1rem;margin-bottom:1rem;border:0;border-top:1px solid rgba(0,0,0,0.1)}
	.text-muted {color:#969696 !important;}
	.text-amt {color:#6a6a6a;font-size:24px;} 
	
	.gobutton{background:#f81111;color: #fff !important;border:0;height:42px;font-size:15px;font-weight:400;padding:0 40px;text-align:center;outline:none;-webkit-border-radius:60px;border-radius:60px;box-shadow:0 10px 10px -10px #f81111;display: inline-block;width:246px;line-height:46px;min-height: 46px;margin:30px auto 0 auto;}
	

	@media (max-width:999px){
		html .containerMain{width:calc(100% - 100px);margin:15% auto 0!important;padding:30px;display:block;float:unset;left:0}
	}

	</style>
	<div class="containerMain failed my-2" >
		<div id="timer" class="proccess_timer" style="display:none">0:30</div>
		<div class="proccess_timer_border" >&nbsp;</div>
		
	
		<i class="<?=$data['fwicon']['circle-info'];?> text-danger fa-w-16 fa-7x my-2"></i>
		
		<div class="text-header my-2"><?=$data['hder_fail']?></div>
		<div class="hr">&nbsp;</div>
		<? if($getresponse['reason']){ ?>
			<h4 class="text-reason">Reason  : <?=($getresponse['reason']?$getresponse['reason']:$getresponse['status']);?></h4>
		<?}?>
		<h5 class="text-amt">Amount : <?=get_currency($getresponse['curr']);?><?=$getresponse['amt']?></h5>
		<div class="text-muted"> Transaction ID : <?=$getresponse['transID']?></div>
		<div class="text-muted"> <?=date("l jS \of F Y h:i:s A", strtotime($getresponse['tdate']));?> </div>
		<?/*?>
		<div class="text-footer msg_fail"><?=$data['msg_fail']?></div>
		<div class="text-footer ftr_fail"><?=$data['ftr_fail']?></div>
		<?*/?>
		
		<a onclick="paycont();" class="btn btn-primary my-2">Return to Merchant Website</a>
		
	</div>
	
	<script>
	window.name='authenticate';
	function redirect_Postf(url, data) {
		var form = document.createElement('form');
		document.body.appendChild(form);
		form.method = 'post';
		form.target = '_top';
		form.action = url;
		for (var name in data) {
			var input = document.createElement('input');
			input.type = 'hidden';
			input.name = name;
			input.value = data[name];
			form.appendChild(input);
		}
		form.submit();
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
	
	var redirecturl="<?=$failed_url?>";
	var dataPost=<?=$dataPost?>;
	
	function paycont(){
		if(redirecturl){redirect_Postf(redirecturl,dataPost);}
	}
	
	$(document).ready(function(){ 
		
		if(redirecturl){
			$('body').addClass('timerActive');
			$('#timer').slideDown(100);
			
			//timeLeft = 899678; // 15 min = 59978.53333333333 * 15 ;
			timeLeft = 29989.26666666667; // 30 sec. 
			
			setTimeout(function(){ 
				redirect_Postf(redirecturl,dataPost);
			}, timeLeft);
			
			timer = $('#timer');
			setInterval(updateTimer, 1000);
		}
		
	});
	</script>

<?
//exit;
}
?>



