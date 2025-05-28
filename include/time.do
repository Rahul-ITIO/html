<!DOCTYPE html> 
<html> 
  <head> 
    <title>jQuery Clock server side example</title> 
    <meta charset="UTF-8"> 
    <style type="text/css"> 
      
      /* SAMPLE CSS STYLES FOR JQUERY CLOCK PLUGIN */ 
      .jqclock { text-align:center; border: 2px #369 ridge; background-color: #69B; padding: 10px; margin:20px auto; width: 40%; box-shadow: 5px 5px 15px #005; } 
      .clockdate { color: DarkRed; font-weight: bold; background-color: #7AC; margin-bottom: 10px; font-size: 18px; display: block; padding: 5px 0; } 
      .clocktime { border: 2px inset DarkBlue; background-color: #444; padding: 5px 0; font-size: 14px; font-family: "Courier"; color: LightGreen; margin: 2px; display: block; font-weight:bold; text-shadow: 1px 1px 1px Black; } 
    </style> 
    <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script> 
    <script type="text/javascript" src="//gitcdn.link/repo/Lwangaman/jQuery-Clock-Plugin/master/jqClock.min.js"></script> 
    <script type="text/javascript"> 
      $(document).ready(function(){ 
        customtimestamp = parseInt($("#jqclock").data("time"));
        $("#jqclock").clock({"langSet":"en","timestamp":customtimestamp}); 
        $("#jqclock-local").clock({"langSet":"en"}); 
      }); 
    </script> 
	<style>
		.clockdate{font-size:12px;color:#eee;}
		.jqclock{text-align:center;border:0px #369 ridge;background-color:#DAE1E6;padding:0;margin:0; width:40%;box-shadow:0 0 0 #005;}
		.clocktime {margin:0px;position:relative;top:-10px;margin-bottom:-10px;}
	</style>
  </head> 
  <body> 
   
    <div id="jqclock" class="jqclock" data-time="<?php echo time(); ?>" style="width:135px;height:55px;"></div>  
  </body> 
</html>