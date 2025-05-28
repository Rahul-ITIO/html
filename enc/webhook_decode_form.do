<?php 
error_reporting(0); // reports all errors
if(!isset($_SESSION)) {
	session_start(); 
	//session_regenerate_id(true); 
}

//  https://aws-cc-uat.web1.one/enc/webhook_decode_form.do

?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Rave 3D Redirect URL</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
<style>
body {font-family:Arial, Helvetica, sans-serif}
.frm{width:98%; margin:0 auto; border:1px solid gray; height:auto;padding:5px;border-radius: 4px;}
.lab{width:15%; float:left;text-align:right;padding:10px;font-weight:bold;}
.txt{width:32%; float:left;text-align:left;padding:3px;}
.fld {width:90%; padding:10px;}
.sub{clear:both;width:90%; padding:10px; margin:0 auto; float:none; text-align:center;}
.btn{ background-color:#009; color:#FFF; padding:15px; margin:20px; width:25%; font-eight:bold; border:1px solid #000;cursor:pointer;font-size:20px;border-radius:6px;}
.msg{padding:15px;color:#00F;font-size:15px; text-align:center; height:30px; margin:0 auto;}
p {width: 99%;word-wrap: break-word;border-bottom: 1px solid #ede6e6;margin: 0 auto;padding: 10px;font-size: 13px;}
.small{width:auto !important; font-size:15px;margin:5 !important; padding:10px !important;float:left }
</style>
</head>

<body>
<div class="frm">
<?php if (!empty($txtmsg)){?><div class="msg">Your Message is sent.</div><? }?>
  <form  method="post" action="decode_encryption_method_aes256.php" target="_blank" name="frm" id="frm">
  <div class="lab">Public Key <span style="color:red;">*</span></div>
  <div class="txt">
  	<input type="text" name="public_key" class="fld" required="required" value="" />
  </div>
  <div class="lab">Private Key <span style="color:red;">*</span></div>
  <div class="txt">
  	<input type="text" name="private_key" id="private_key" class="fld" required="required" value="" />
  </div>
  <div class="lab">Encoded Response from $_REQUEST['encryption_data'] <span style="color:red;">*</span></div>
  <div class="txt" style="width: 78.6%;">
    <textarea name="encryption_data" class="form-control" style="width: 100%;float: left;min-height: 200px;"></textarea>
  </div>
  
  
  
  <div class="sub">
  <input type="submit" name="sendfrm" id="sendfrm" value="SUBMIT" class='btn' />
  <a href="webhook_decode_form.do"><input type="button" value="Reset" class='btn' /></a>
  
  </div>
  </form>
</div>
</body>
</html>