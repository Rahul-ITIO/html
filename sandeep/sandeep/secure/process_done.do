<?if(!isset($_SESSION)){	session_start(); }	?><!DOCTYPE html>
<html lang="en" data-bs-theme="light">
<head>
<title>Processing Done...</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
<meta http-equiv="Content-Security-Policy" content="default-src 'self'; font-src * 'unsafe-inline'; style-src * 'unsafe-inline'; script-src * 'unsafe-inline' 'unsafe-eval'; img-src * data: 'unsafe-inline'; connect-src * 'unsafe-inline'; frame-src *; object-src 'none'" />
<script type="text/javascript">
function closeWindow() {
    window.close();
}
</script>
</head>
<body onload="javascript:window.close();" style="text-align:center;font-family:arial,sans-serif;font-size:14px;color:#4d4c4c;">
<h3 style="font-size:14px;color:#4d4c4c;margin:30px 0;">Processing Done...</h3>
<button onclick="javascript:window.close();location.reload();" style="float:none;display:block;clear:both;width:250px;text-align:center;margin:15px auto;line-height:40px;border-radius:3px;background-color:#dff0d8;font-size:14px;border:none;">Close Window</button>
<?if(isset($_SESSION['fetch_trnsStatusUrl'])){ 

?>
<br/><br/>OR <br/><br/>
<a target="_top" href='<?=@$_SESSION['fetch_trnsStatusUrl'];?>' class="upd_status" style="float:none;display:block;clear:both;width:250px;text-align:center;margin:15px auto;line-height:40px;border-radius:3px;background-color:#dff0d8;font-size:16px;text-decoration: none;color:#011801;border:none;">Check Status</a>
<? } ?>
</body>
</html>