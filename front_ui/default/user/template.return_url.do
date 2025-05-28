<? if(isset($data['ScriptLoaded'])){ ?>
	<?
	$getresponse=$data['getresponse'];
	$return_response_arr=$data['return_response_arr'];
	//echo "<br/> getresponse=>"; print_r($getresponse);
	//$data['getresponse']['order_status']=1;

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



	if($data['moto_vt']==true){
		$source_url = $data['source_url']."&actionurl=success";
		$return_url=nexturl_f(stf($source_url),$return_response_arr);
	}else{
		if(!empty($data['return_url'])){
			$return_url=squrlf(stf($data['return_url']),$return_response_arr);
		}
	}
	
	$dataPost=json_encode($return_response_arr);
	
	
	#####	TRANS_NOTIFY_BRIDGE by Dev Tech : 23-02-14 | hisotry : 24-12-22		######
	if(isset($data['TRANS_NOTIFY_BRIDGE'])&&trim($data['TRANS_NOTIFY_BRIDGE'])&&(isset($data['webhook_url'])&&trim($data['webhook_url']))&&!isset($_SESSION['SA']['WEBHOOK_BRIDGE'])){
		$_SESSION['notifybridge_url_nofity']=$data['webhook_url'];
		$_SESSION['transID']=$getresponse['transID'];
		$_SESSION['notifybridge_url_type']='return_url';
		$_SESSION['notifybridge_url_mer']=@$return_url;
		$_SESSION['notifybridge_res']=$getresponse;
		$return_url=$data['Host']."/".$data['TRANS_NOTIFY_BRIDGE'].$data['ex']."?transID=".$getresponse['transID'];
	}
	
	
	if(isset($_SESSION['return_url'])){
		unset($_SESSION['return_url']);
	}
	?>
	
	
	<?php /*?><?
		
	//echo "<br/>return_url=>".$return_url;
	$template_header=($data['FrontUI']."/".$data['frontUiName']."/user/template.header".$data['iex']);
	if(!file_exists($template_header)){
	?>
	<style>
	body{color:#468847;background-color:#dff0d8;border-color:#d6e9c6;}	
	</style>
	<? } ?>

    <? if(isset($data['getresponse']['order_status'])&&$data['getresponse']['order_status']==1){ //success ?>

	<style>
		h3{color:#008000;}
	</style>
	
   <? }elseif(isset($data['getresponse']['order_status'])&&$data['getresponse']['order_status']>1){ //failed ?>

	<style>
		h3{color:#dc3545;}
	</style>
	
   <? } ?><?php */?>

<style>
/*.h3, h3 {font-size:24px !important;}*/

/*.container-flex.user_header_main {display:none !important;}*/
.proccess_timer{font-size:14px;color:#5c5c5c;text-align:center;float:left;width:100%;margin:3px 0}
.timerActive .proccess_timer_border{display:block;}
.proccess_timer_border{display:none;float:unset;width:110px;height:2px;text-align:center;clear:both;position:relative;margin:0 auto 10px;background:#020024;background:linear-gradient(90deg,rgba(2,0,36,1) 0%,rgba(218,0,203,1) 0%,rgba(204,204,204,1) 0%,rgba(255,255,255,1) 0%,rgba(255,255,255,1) 25%,rgba(197,196,198,1) 50%,rgba(255,255,255,1) 75%,rgba(255,255,255,1) 100%)}

	/*body{margin:0;padding:0;overflow:hidden;overflow-y: auto;width:100%;height:100%;font-size:14px;font-family:Arial,Helvetica,sans-serif;color:#5d5c5d;line-height:24px;text-align:center;color:#468847;}	
	p{font-size:18px;margin:10px;font-family:Arial,Helvetica,sans-serif;color:#5d5c5d;float:left;width:100%;line-height:34px;}
	.container-fluid.fixed {background: transparent;}*/

	/*.containerMain{position:relative;display:flex;flex-direction:column;min-width:0;word-wrap:break-word;background-clip:border-box;width:60%;margin:10% auto 0 auto;float:unset;}*/

	/*.hr{margin-top:1rem;margin-bottom:1rem;border:0;border-top:1px solid rgba(0,0,0,0.1)}*/
	/*.text-muted {color:#969696 !important;}
	.text-amt {color:#6a6a6a;font-size:24px;}*/
	
	/*.gobutton{background:#43cd0a;color: #fff !important;border:0;height:42px;font-size:15px;font-weight:400;padding:0 40px;text-align:center;outline:none;-webkit-border-radius:60px;border-radius:60px;box-shadow:0 10px 10px -10px #3cb20b;display: inline-block;width:246px;line-height:46px;min-height: 46px;margin:0 auto;}*/

	/*@media (max-width:999px){
		html .containerMain{width:calc(100% - 100px);margin:15% auto 0!important;padding:5px;display:block;float:unset;left:0}
	}
*/

.box-width{width:500px;}
@media (max-width:500px){
.box-width{width: auto !important;}
}
	</style>
	<div class="containerMain border rounded text-center rounded-tringle mt-5 box-width" style="max-width:500px; margin:0 auto;background:#fff;">
		<div id="timer" class="proccess_timer" style="display:none;" ></div>
		<div class="proccess_timer_border" >&nbsp;</div>
		
		<? if(isset($data['getresponse']['order_status'])&&$data['getresponse']['order_status']==1){	?>
		
			<i class="<?=@$data['fwicon']['tick-circle'];?> text-success fa-w-16 fa-7x mt-4"></i>
			
		<? }else if(isset($data['getresponse']['order_status'])&&$data['getresponse']['order_status']<>1){	?>
		
			<i class="<?=@$data['fwicon']['circle-info'];?> text-danger fa-w-16 fa-7x mt-4"></i>
			
		<? } ?>
		
		<div class="text-header my-2"><?=@$data['header_msg']?></div>
		<hr>
		
		<? if($getresponse['response']||$getresponse['status']){ ?>
			<div class="btn btn-outline-primary mx-2 btn-sm">Reason  : <?=($getresponse['response']?$getresponse['response']:$getresponse['status']);?></div>
		<? } ?>
		
		<div class="my-2 fs-5 text-primary-emphasis">Amount : <?=get_currency($getresponse['bill_currency']);?><?=@$getresponse['amt']?></div>
		<div class="text-muted my-2 fs-6 fw-bold text-info-emphasis"> TransID : <?=@$getresponse['transID']?></div>

		
		<div class="text-muted my-2 fs-6"> Reference : <?=@$getresponse['reference']?></div>
		<div class="text-muted my-2 fs-6 fw-bold text-secondary-emphasis"> <?=date("l jS \of F Y h:i:s A", strtotime($getresponse['tdate']));?> </div>
		
		<div class="p-2 bg-body-secondary text-decoration-underline click-to-redirect"><div style="cursor:pointer;"> Redirecting in <span class="lblCount_span"><i class="<?=@$data['fwicon']['clock'];?>"></i> <span id="lblCount"></span>&nbsp;seconds... </span></div></div>
		
		
		<div class="text-footer my-2"><?=@$data['footer_msg']?></div>
		
		<?if(!empty($data['return_url'])){?>
			<a onclick="paycont();" class="btn btn-primary my-2">Return to Merchant Website</a>
		<?}?>
		
	</div>

<?
//echo "<br/><br/>WEBHOOK_BRIDGE=>".@$_SESSION['SA']['WEBHOOK_BRIDGE'];
?>

<script type="text/javascript">
if (typeof jQuery == 'undefined') {
  document.write('<script type="text/javascript" src="<?=@$data['Host']?>/js/jquery-3.6.0.min.js"><\/script>');        
  } 
</script>

	<script>
	function redirect_Postf(url, data) {
		console.log("==== return_url :: redirect_Postf===="+url);
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
			window.location.reload(true);
			
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
	
	
		
	var redirecturl="<?=@$return_url?>";
	var dataPost=<?=@$dataPost?>;

	console.log("====return_url :: redirecturl===="+redirecturl);
	
	function paycont(){
		console.log("====paycont redirecturl===="+redirecturl);
		top.window.location.href=redirecturl;
		//if(redirecturl){redirect_Postf(redirecturl,dataPost);}
	}
	

	$(document).ready(function(){ 
		
		
	<?if(!isset($_SESSION['SA']['WEBHOOK_BRIDGE'])){?>
	
		if(redirecturl){
			$('body').addClass('timerActive');
			$('#timer').slideDown(100);
			
			/*
			//timeLeft = 899678; // 15 min = 59978.53333333333 * 15 ;
			//timeLeft = 29989.26666666667; // 30 sec. 
			timeLeft = 10000; // 10 sec. 
			setTimeout(function(){ 
				console.log("====setTimeout - redirect_Postf redirecturl===="+redirecturl);
				redirect_Postf(redirecturl,dataPost);
			}, timeLeft);
			
			timer = $('#timer');
			setInterval(updateTimer, 1000);

			*/

			

			var seconds = 5;  
			$("#lblCount").html(seconds); 
				clear_count_st = setInterval(function () {  
				seconds--;  
				$("#lblCount").html(seconds);  
				console.log("== "+seconds+" :: setInterval redirecturl==== "+redirecturl);						
				if(seconds < 1) {
					
					top.window.location.href=redirecturl;
				}
			}, 1000); // after 10 seconds 
		}
		
	<?}?>	
	
		if (parent.window && parent.window.document) {
			parent.window.close();
			//opener.window.close();
		}
		if (window.opener && window.opener.document) {
			//parent.window.close();
			window.close();
		}
		
	});
	</script>

<?
//exit;
}
?>



