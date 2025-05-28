<?
$config_root='../config_root.do';
if(file_exists($config_root)){include($config_root);}
//echo "<br/>Host1=>".$data['Host']; echo "<br/>urlpath1=>".$urlpath;

$redirect_url="";$redirect_url2="";$cross_domain=""; $cross_domain2="";

// redirect_url for bank otp page
if(isset($_SESSION['redirect_url'])){
	$redirect_url=$_SESSION['redirect_url'];
	
	//echo $redirect_url=base64_decode($_SESSION['redirect_url']);
}

if(isset($_GET['redirect_url'])&&(!empty($_GET['redirect_url']))){
	$redirect_url=($_GET['redirect_url']);
}

if(isset($_POST['redirect_url'])&&(!empty($_POST['redirect_url']))){
	$redirect_url=($_POST['redirect_url']);
}


if(!empty($redirect_url)){
		$_SESSION['redirect_url']=$redirect_url;
}
if(isset($_SESSION['curl_process'])&&$_SESSION['curl_process']){
	$redirect_url=$data['Host']."/secure/process_req.do";
	//$redirect_url=$data['Host']."/secure/process_post.do";
}
//echo "<hr/>redirect_url=>".$redirect_url;echo "<hr/>_SESSION redirect_url=>".$_SESSION['redirect_url'];

// cross_domain

if(isset($_SESSION['cross_domain'])&&($_SESSION['cross_domain'])){
	$cross_domain=$_SESSION['cross_domain'];
}
if(isset($_SESSION['cross_domain2'])&&($_SESSION['cross_domain2'])){
	$cross_domain2=$_SESSION['cross_domain2'];
}

if(isset($_POST['cross_domain'])&&(!empty($_POST['cross_domain']))){
	$cross_domain=$_POST['cross_domain'];
}
if(isset($_POST['cross_domain2'])&&(!empty($_POST['cross_domain2']))){
	$cross_domain2=$_POST['cross_domain2'];
}


/*
if(isset($_POST)){
	unset($_POST['redirect_url']);
	$sub_query=http_build_query($_POST);
	if($sub_query){
		if(strpos($redirect_url,'?')!==false){
			$redirect_url.="&".$sub_query;
		}else{
			$redirect_url.="?".$sub_query;
		}
	}
}
*/
//echo "redirect_url=>".$redirect_url;
?>
<!DOCTYPE html>
<html lang="en-US">
<head>
<title>3D Secure 2 Processing...</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
<style>
body{margin:0;padding:0;overflow:hidden;width:100%;height:100%;}
</style>
<script>
 
</script>
</head>
<body oncontextmenu='return false;'>
<?if(!empty($redirect_url)){
		//$_SESSION['redirect_url']=$redirect_url;
	?>
<iframe name='open_frame' id='open_frame' src="<?php echo $redirect_url;?>" width='100%' height='550px' scrolling='auto' frameborder='0' marginwidth='0' marginheight='0' style='width:100%!important;min-height:550px!important;height:100vh!important;max-height:100vh!important;display:block!important;margin:0px auto;overflow:hidden;'  sandbox="allow-top-navigation"></iframe>
<?}?>
<?if(!empty($cross_domain)){
//position:absolute;z-index:999;top:0;height:200px;width: 100% !important;background:#ccc;
?>
<iframe src='<?php echo $cross_domain;?>' width='0' height='0' scrolling='no' frameborder='0' marginwidth='0' marginheight='0' style='width:0px !important;min-height:0px !important;display:none !important;margin:0px auto;overflow:hidden;' sandbox="allow-same-origin allow-scripts allow-popups allow-forms" ></iframe>
<?}?>
<?if(!empty($cross_domain2)){?>
<iframe src='<?php echo $cross_domain2;?>' width='0' height='0' scrolling='no' frameborder='0' marginwidth='0' marginheight='0' style='width:0px !important;min-height:0px !important;display:none !important;margin:0px auto;overflow:hidden;' sandbox="allow-same-origin allow-scripts allow-popups allow-forms" ></iframe>
<?}?>
</body>
<?
if(isset($_SESSION['redirect_url'])){
	//unset($_SESSION['redirect_url']);
	unset($_SESSION['cross_domain2']);
}
?>
</html>