<?php
if(!isset($_SESSION)) {
	session_start(); 
	//session_regenerate_id(true); 
}
?><!DOCTYPE html>
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
<base1 href='https://acs.fssnet.co.in'>
</head>
<body >
<?php

echo @$_SESSION['html_data'];


?>


</body>

</html>

