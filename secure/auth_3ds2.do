<?

if(!isset($data['config_root'])){
	$config_root='../config_root.do';
	if(file_exists($config_root)){include($config_root);}
	//echo "<br/>Host1=>".$data['Host']; echo "<br/>urlpath1=>".$urlpath;
}

//cmn
if(@$_SERVER['SERVER_NAME']=='localhost'){
	/*
	$_SESSION['3ds2_auth']['payaddress']='http://localhost/gw/payin/pay44/reprocess_44.do';
	$_SESSION['3ds2_auth']['action']='otp';
	$_SESSION['3ds2_auth']['action']='pin';
	*/
}

if(isset($_REQUEST['qp'])) 
{	
	echo "<hr/>3ds2_auth=><br/>";
	print_r($_SESSION['3ds2_auth']);
	if(@$_REQUEST['qp']==1) exit;
}

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
<?if(isset($_SESSION['3ds2_auth']['action'])&&$_SESSION['3ds2_auth']['action']=='redirect'){?>
.loder_div{display:none !important;}
<?}?>

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
//$data['startSetInterval']='Y';
//file use for  payin_auto_status_common_script 
$payin_auto_status_common_script=@$data['Path'].'/payin/payin_auto_status_common_script'.$data['iex'];
if(file_exists($payin_auto_status_common_script)){include($payin_auto_status_common_script);}
?>


<?php 

if(isset($_SESSION['3ds2_auth']['payaddress'])&&!empty($_SESSION['3ds2_auth']['payaddress'])){

	$_SESSION['3ds2_auth']['payaddress']=str_replace(" ","+",$_SESSION['3ds2_auth']['payaddress']);

	//remove tab and new line from json encode value 
	$_SESSION['3ds2_auth']['payaddress'] = preg_replace('~[\r\n\t]+~', '', $_SESSION['3ds2_auth']['payaddress']);
}	


if(isset($_SESSION['opener_script'])){
 //echo $_SESSION['opener_script'];
} 
//exit;
?>
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
//exit;
	if(isset($_SESSION['3ds2_auth']['payaddress'])&&isset($_SESSION['3ds2_auth']['action'])&&( @$_SESSION['3ds2_auth']['action']=='otp' || @$_SESSION['3ds2_auth']['action']=='pin') )
	{ 
?>	
	<style>
		.loder_div{display:none !important;}
	</style>
	
	<div id="ProceedtoPayment" style="width:100%; margin:5px auto;">
			<div class="text-header"><? if(isset($data['processor_response']) && !empty($data['processor_response'])) echo $data['processor_response'];else echo '<h1>Enter '. @$_SESSION['3ds2_auth']['action'] .'</h1>';?></div>
			<?if(@$_SESSION['3ds2_auth']['action']=='pin'){?>
				<h3 class="mt-3">Please validate with the your card pin </h3>
			<?} else {?>
				<h3 class="mt-3">Please validate with the OTP sent to your mobile or email </h3>
			<?} ?>
			<form name="myForm" id="myForm" action="<?=@$_SESSION['3ds2_auth']['payaddress'];?>" method="post">
				<input type="hidden" name="mode" value="<?=@$_SESSION['3ds2_auth']['action']?>"/>
				<input type="hidden" name="transID" value="<?=@$_REQUEST['transID'];?>"/>
				<input type="password" name="otp" value="" placeholder="Enter <?=@$_SESSION['3ds2_auth']['action']?> here"  style="padding:5px 20px;line-height:40px;" maxlength="10" required />
				<input type="submit" value="Confirm" class="button" onclick="javascript:changepagetext();" style="padding:0 30px;height:54px;line-height:54px;" />
				<a class="button button5" onclick="goRePost()" style="color:#fff !important;">No</a>
			</form>
		</div>
		

	<?}
	elseif(isset($_SESSION['3ds2_auth']['payaddress'])&&isset($_SESSION['3ds2_auth']['action'])&&$_SESSION['3ds2_auth']['action']=='redirect'){
		/*
		if(isset($_REQUEST['qp'])) echo "<br/><hr/>payaddress=><br/>".$_SESSION['3ds2_auth']['payaddress'];
		ob_start();
		header("Location: ".$_SESSION['3ds2_auth']['payaddress']);
		ob_end_flush();
		*/
		echo "<script>top.window.location.href='".$_SESSION['3ds2_auth']['payaddress']."';</script>";
		if(isset($_REQUEST['qp'])) echo "<br/><hr/>2 payaddress=><br/>".$_SESSION['3ds2_auth']['payaddress'];
		exit();
	}
	elseif(isset($_SESSION['3ds2_auth']['payaddress'])&&isset($_SESSION['3ds2_auth']['action'])&&$_SESSION['3ds2_auth']['action']=='post_redirect'){
		
		if(isset($_REQUEST['sqp'])) 
		$_SESSION['3ds2_auth']['post_redirect']['b_submit']=1;
		 
		//unset($_SESSION['3ds2_auth']['post_redirect']['b_submit']);
		post_redirect($_SESSION['3ds2_auth']['payaddress'], @$_SESSION['3ds2_auth']['post_redirect']);exit();
	}
	elseif(isset($_SESSION['3ds2_auth']['payaddress'])&&isset($_SESSION['3ds2_auth']['action'])&&($_SESSION['3ds2_auth']['action']=='iframe_base64'||$_SESSION['3ds2_auth']['action']=='redirect_base64')){

		$url_base64_payaddress=base64_decode($_SESSION['3ds2_auth']['payaddress']);
		
		if(isset($_SESSION['3ds2_auth']['base64_data'])&&@$_SESSION['3ds2_auth']['base64_data']){
			//$base64_data=base64_decode($_SESSION['3ds2_auth']['base64_data']);
			$base64_data=$_SESSION['3ds2_auth']['base64_data'];
			$url_base64_payaddress=$url_base64_payaddress.'&load_data='.$base64_data;
		}

		if(@$_SESSION['3ds2_auth']['action']=='redirect_base64'){
			echo "<script>top.window.location.href='".$url_base64_payaddress."';</script>";
			if(isset($_REQUEST['qp'])) echo "<br/><hr/>2 payaddress=><br/>".$url_base64_payaddress;
			exit();
		}
		elseif(@$_SESSION['3ds2_auth']['action']=='iframe_base64'){
		echo '<iframe src="'.$url_base64_payaddress.'" 
              name="iframe_base64" 
              width="100%" height="100%" marginwidth="0" marginheight="0" frameborder="0" vspace="0" hspace="0" style="overflow:visible; height:100vh; width:100vw; border:0px; position:relative; left:0px;"></iframe>';
		}

	}
	
	elseif(isset($_SESSION['3ds2_auth']['payaddress'])&&isset($_SESSION['3ds2_auth']['action'])&&$_SESSION['3ds2_auth']['action']=='echo'){
		echo $_SESSION['3ds2_auth']['payaddress'];exit();
	}
	elseif(isset($_SESSION['3ds2_auth']['payaddress'])&&isset($_SESSION['3ds2_auth']['base64'])){
		echo base64_decode($_SESSION['3ds2_auth']['payaddress']);
	} 
	elseif(isset($_SESSION['3ds2_auth'])){
		//echo htmlspecialchars_decode($_SESSION['3ds2_auth'], ENT_QUOTES | ENT_XML1, 'UTF-8');
		//echo html_entity_decode($_SESSION['3ds2_auth']);
		echo htmlspecialchars_decode($_SESSION['3ds2_auth']);
	}?>

</body>
<?
if(isset($_SESSION['3ds2_auth'])){
	//unset($_SESSION['3ds2_auth']);
}
?>
</html>