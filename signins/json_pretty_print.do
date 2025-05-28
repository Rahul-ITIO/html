<? 
//include('../config_db.do');
include('../config.do');
//if((!isset($_SESSION['adm_login']))&&(!isset($_SESSION['sub_admin_id'])))
if(!isset($_SESSION['adm_login'])&&!isset($_SESSION['login']))
{
	echo('ACCESS DENIED.'); exit;
}

$qp=0;
if(isset($_GET['qp'])) $qp=$_GET['qp'];

//header("Content-Type: application/json", true);	
if(isset($_REQUEST['strip'])){
	$array = htmlentitiesf($_REQUEST['json']);
}else{
	if(isset($_REQUEST['json'])&&$_REQUEST['json']) $array = htmlentitiesf($_REQUEST['json']);
	else $array ='';
}

$array = $json_log = stripslashes(decryptres($array));
//print_r($array);

//replace 
if(isset($array)&&is_string($array)){
	$array=str_replace([':{"},'],[':{},'],$array);
	$array=curly_braces_join($array);
}


if(@$data['cqp']==2)
print_r($_REQUEST);

//print_r($json_log);
$strip_tags = htmlentitiesf($array);
//print_r($strip_tags);
if(isset($_REQUEST['strip'])){
	echo $array;
}else{
	$array = json_decode($array,1);

	if(isset($_REQUEST['payload_stage1'])&&@$_REQUEST['payload_stage1']){
		$payload_stage1 = stripslashes(decode64f($_REQUEST['payload_stage1']));
		$payload_stage1 = urldecode($payload_stage1);
		$payload_stage1 = stf($payload_stage1);
		$payload_stage1_arr = isJsonDe($payload_stage1,1);
		$array['payload_stage1']=$payload_stage1_arr;
	}

	if(isset($_REQUEST['response1'])&&@$_REQUEST['response1']){
		$acquirer_response_stage1 = stripslashes(decode64f($_REQUEST['response1']));
		//$acquirer_response_stage1 = str_replace(["MY_SECRET_ANQtkR7ak8RZ"],"",$acquirer_response_stage1);
		$acquirer_response_stage1 = urldecode($acquirer_response_stage1);
		$acquirer_response_stage1 = stf($acquirer_response_stage1);
		$acquirer_response_stage1_arr = isJsonDe($acquirer_response_stage1,1);
		$array['acquirer_response_stage1']=$acquirer_response_stage1_arr;
	}

	if(isset($_REQUEST['response2'])&&@$_REQUEST['response2']){
		$acquirer_response_stage2 = stripslashes(decode64f($_REQUEST['response2']));
		$acquirer_response_stage2 = urldecode($acquirer_response_stage2);
		//$acquirer_response_stage2 = html_entity_decodef($acquirer_response_stage2);
		$acquirer_response_stage2 = stf($acquirer_response_stage2);
		//remove tab and new line from json encode value 
		//$acquirer_response_stage2 = preg_replace('~[\r\n\t]+~', '', $arrayEncoded2);
		$acquirer_response_stage2 = jsonreplace($acquirer_response_stage2);
		$acquirer_response_stage2_arr = isJsonDe($acquirer_response_stage2,1);
		$array['acquirer_response_stage2']=$acquirer_response_stage2_arr;
	}


	$json_decode=$array;
	//print_r($json_decode);


?>
<style>
.rmk_date {float:unset;width:170px;display:table-cell;}
.rmk_row {margin:0;padding:0;width:100%;clear:both;display:table;background-color:#f0f8ff;padding-left:10px;}

.hideText{text-indent:-999em;letter-spacing:-999em;overflow:hidden;}
*,a:focus{outline:none !important;}
button:focus{outline:none !important;}
button::-moz-focus-inner{border:0;}
body{font-family:'Open Sans',sans-serif;background:#ffffff;font-size:10pt;padding-bottom:35px;}

/*pre22{font-family:'Open Sans',sans-serif;font-weight:300;width:96%;display:block;margin:0 auto;padding:10px 20px;font-size:16px;line-height:26px;word-break:break-all;word-wrap:break-word;white-space:pre;white-space:pre-wrap;background-color:#f6f4f4;border:1px solid #ccc;border:1px solid rgba(0,0,0,0.15);-webkit-border-radius:4px;-moz-border-radius:4px;border-radius:4px;color:#3c3c3c;}*/

pre{ word-break:break-all;word-wrap:break-word;letter-spacing:0.03em;line-height: 150%; }



</style>
<pre class="jsonColorId"><?php
if(is_array($json_decode)){
	$json_encode=json_encode($array, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT | JSON_FORCE_OBJECT); // Now it's multiline and indented properly
	//echo htmlentitiesf($json_encode);
	echo htmlentitiesf($json_encode);
}else{
	echo $strip_tags; // none json
}
?></pre>
<?}?>

<?/*?>
<script type="text/javascript" src="<?=$data['Host']?>/js/jquery-3.6.0.min.js"></script>
<?*/?>
<script type="text/javascript">
if (typeof jQuery == 'undefined') {
  document.write('<script type="text/javascript" src="<?=$data['Host']?>/js/jquery-3.6.0.min.js"><\/script>');        
  } 
</script>
<script type="text/javascript" src="<?=$data['Host']?>/thirdpartyapp/json_color/json-in-color.js"></script>
<script>
	//var jsonClean = JSON.stringify(JSON.parse($('.json-clean').text()), null, 3);
		
	//$('.json-color').html(jsonClean.jsonColor());
	
	jsonCleanDiv = JSON.stringify(JSON.parse($('.jsonColorId').text()), null, 3);
	$('.jsonColorId').html(jsonCleanDiv.jsonColor());
	
	//JSONstringify($('.jsonColorId').text());
</script>

