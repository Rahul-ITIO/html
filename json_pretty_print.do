<? 
include('config_db.do');
//header("Content-Type: application/json", true);	
if(isset($_REQUEST['strip'])){
	$array = ($_REQUEST['json']);
}else{
	$array = strip_tags($_REQUEST['json']);
}
$array = decryptres($array);


if(isset($_REQUEST['strip'])){
	echo $array;
}else{
	$array = json_decode($array,1);
	//print_r($array);

	//echo json_encode($array, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES | JSON_FORCE_OBJECT); // Now it's multiline and indented properly

	?>
<style>
@import url("https://fonts.googleapis.com/css?family=Open+Sans:400,800,700,600");
@import url("https://fonts.googleapis.com/css?family=Raleway:400,600,700");
.hideText{text-indent:-999em;letter-spacing:-999em;overflow:hidden;}
*,a:focus{outline:none !important;}
button:focus{outline:none !important;}
button::-moz-focus-inner{border:0;}
body{font-family:'Open Sans',sans-serif;background:#ffffff;font-size:10pt;padding-bottom:35px;}

pre{font-family:'Open Sans',sans-serif;font-weight:300;width:96%;display:block;margin:0 auto;padding:10px 20px;font-size:16px;line-height:26px;word-break:break-all;word-wrap:break-word;white-space:pre;white-space:pre-wrap;background-color:#f6f4f4;border:1px solid #ccc;border:1px solid rgba(0,0,0,0.15);-webkit-border-radius:4px;-moz-border-radius:4px;border-radius:4px;color:#3c3c3c;}
</style>
<pre><?php
echo json_encode($array, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT | JSON_FORCE_OBJECT); // Now it's multiline and indented properly
?></pre>
<?}?>
