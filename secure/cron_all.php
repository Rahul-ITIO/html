<!DOCTYPE html>
<?php 
// localhost/gw/secure/cron_all.php?re=60000
// http://localhost/gw/secure/cron_all.php?re=20000&stop=1
?> 
<head>
<title>Cron Host!!</title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Pragma-directive" content="no-cache">
<meta http-equiv="Cache-Directive" content="no-cache">
<meta http-equiv="Expires" content="0">
<!-- Meta -->
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
<style>
body{margin:0;padding:0;overflow:auto;width:100%;height:100%;font-size:14px;font-family:Arial,Helvetica,sans-serif;color:#5d5c5d;line-height:24px;text-align:center;color:#468847;background1:#ccc;border-color:#d6e9c6;}

html iframe, html frame {
    position:relative;
    z-index:0;
    height:48vh !important;
    margin:-20px 0 0 0 !important;
    padding:0 !important;
    min-height:100% !important;
    width: 98vw !important;
	overflow:visible;
	bottom:-20px;
}
.h1 {
overflow:visible;width:100%;border:0px; position:relative;left:0px;background:#036d03;color:#fff;padding:3px 0;border-radius:5px;font-size:16px;
}
</style>

</head>
<html> 
  <body> 
    <center> 
	 <?php /*?>
      <div class="h1">Cron Host 1. : 05 to 20 second</div>
      <iframe src="https://cronl1.web1.one/cron_host_05_to_20_second" 
              name="iframe1" 
              width="100%" height="100" marginwidth="0" marginheight="0" frameborder="0" vspace="0" hspace="0" style="overflow:visible; height:100%; width:100%; border:0px; position:relative; left:0px;"> 
      </iframe> 
	    <?php */?>
      <div class="h1">2. : 20 to 30 second</div>
      <iframe src="https://cronl1.web1.one/cron_host_20_to_30_second" 
              name="iframe2" 
              width="100%" height="100" marginwidth="0" marginheight="0" frameborder="0" vspace="0" hspace="0" style="overflow:visible; height:100%; width:100%; border:0px; position:relative; left:0px;"> 
      </iframe> 
	 <div class="h1">3. : 30 to 40 second</div>
      <iframe src="https://cronl1.web1.one/cron_host_30_to_45_second" 
              name="iframe3" 
              width="100%" height="100" marginwidth="0" marginheight="0" frameborder="0" vspace="0" hspace="0" style="overflow:visible; height:100%; width:100%; border:0px; position:relative; left:0px;"> 
      </iframe> 
	   <?php /*?>
	 <div class="h1">4. : 45 to 90 second</div>
      <iframe src="https://cronl1.web1.one/cron_host_45_to_90_second" 
              name="iframe4" 
              width="100%" height="100" marginwidth="0" marginheight="0" frameborder="0" vspace="0" hspace="0" style="overflow:visible; height:100%; width:100%; border:0px; position:relative; left:0px;"> 
      </iframe> 
	   <?php */?>
    </center> 
  </body> 
</html> 
<?php
if(!isset($_REQUEST['stop']))
{
	
	
	if((isset($_REQUEST['re']))&&($_REQUEST['re'])){
		$timeOut=(int)$_REQUEST['re'];
	}else{
		$timeOut=10000;
	}
	echo "<br/>timeOut=>".$timeOut;
	
	echo "<script>
		var timeOut = $timeOut;
		//alert(timeOut);
		setTimeout( function(){ 
			top.document.location.href=top.document.location.href;
		}, timeOut ); //120000
	</script>";
	
}
?>