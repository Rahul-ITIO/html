<?
include('../config_root.do');

$data['TEMPATH']=$data['Host'];


if(isset($_REQUEST['webhook'])){
	$webhook_url= $_REQUEST['mcb_notify_url'];
	$mcb_body=json_decode($_REQUEST['mcb_body'],1);
	print_r($mcb_body);
	
	$webhook_body=http_build_query($mcb_body);
	
	
	echo "<hr/><br/>webhook_url=>".$webhook_url;
	echo "<hr/><br/>webhook body=>".$webhook_body;
	
	
	$chs = curl_init();
			curl_setopt($chs, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);
		curl_setopt($chs, CURLOPT_URL, $webhook_url);
		curl_setopt($chs, CURLOPT_HEADER, 0); // FALSE || true || 
			curl_setopt($chs, CURLOPT_MAXREDIRS, 10);
		curl_setopt($chs, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($chs, CURLOPT_SSL_VERIFYHOST, 0);
		curl_setopt($chs, CURLOPT_SSL_VERIFYPEER, 0);
		curl_setopt($chs, CURLOPT_POST, true);
		curl_setopt($chs, CURLOPT_POSTFIELDS, $webhook_body);
		curl_setopt($chs, CURLOPT_TIMEOUT, 30);
		$notify_res = curl_exec($chs);
		curl_close($chs);
	
	if(isset($_REQUEST['q'])){
		echo "<hr/><br/>notify_res=>".$notify_res;
	}
	
	
	$notify_de = json_decode($notify_res,true);
	
	echo "<hr/><br/>notify_de=>";
	print_r($notify_de);
	
	exit;
}

$ctest="";
if(isset($_GET)&&($_GET)){
	unset($_GET['h']);
	$ctest="?".http_build_query($_GET);
}
?>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Webhook Sent</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
<style>
.btn-primary {
    color: #ffffff !important;
    border-color: #000000 !important;
    background: #808080 !important;
}
</style>
<?
$theme_path=$data['TEMPATH'].'/common/js/jquery-3.6.0.min.js';
if(!file_exists($theme_path)){
	//$data['TEMPATH']='';
	//echo "</br/>TEMPATH=>".$data['TEMPATH'];
	$data['TEMPATH']=$data['Host'].'/front_ui/default';
	/*
	echo "</br/>Path=>".$data['Path'];
	echo "</br/>TEMPATH=>".$data['TEMPATH'];
	echo "</br/>Host=>".$data['Host'];
	*/
}
?>
<script src="<?=$data['TEMPATH']?>/common/js/jquery-3.6.0.min.js"></script>
<link href="<?=$data['TEMPATH']?>/common/css/bootstrap.min.css" rel="stylesheet">
<link href="<?=$data['TEMPATH']?>/common/css/all.min.lates.icon.css" rel="stylesheet">
<link href="<?=$data['TEMPATH']?>/common/css/template-custom.css" rel="stylesheet">
<script src="<?=$data['TEMPATH']?>/common/js/bootstrap.bundle.min.js"></script>
<script>
window.name='hostPost';
function closeWindowf(){
	alert('closeWindowf');
	//window.close();
}
</script>
<script>
function storetypes(thisScl,theValue,theTitle){
	//alert('ok');
	//alert(theValue+'\r\n'+theTitle+'\r\n'+thisScl.title);
}



$(document).ready(function(){
	$("#BusinessType option").change(function() {
		
	   var selectedItem = $(this).val();
	   var titles= $(this).attr('data-title');
	   //var titles= $('#BusinessType option:selected', this).attr('data-title');
	  // var titles= $(this).data('title');
	  // alert(selectedItem); alert(titles);
	   $("#BusinessType1").val(selectedItem);
	   $("#terNO").val(titles);
	   
	   
	  // alert(selectedItem+'\r\n'+titles);
	   
	   //console.log(abc,selectedItem);
	 });
	
	
});

</script>
</head>
<body>
<?

if(isset($_REQUEST['j'])&&$_REQUEST['j']){
	$j=$j_de=json_decode($_REQUEST['j'],1);
	if(isset($j['terNO'])&&empty($j['terNO']))unset($j['terNO']);
	if(isset($j['country_name']))unset($j['country_name']);
	if(@$j['post']) $j=@$j['post'];
	$j2=http_build_query($j);
	
	$directapi='directapi'.$data['ex'];
	
	echo '<div class="bg-primary text-wrap" style="width: 90vw;line-height: 155%;word-break:break-word;max-width: 90%;display:block !important;text-align: center;margin:10px auto;">';
	
	echo "<br/><br/>".$j2."<br/><hr/>";
	if(@$j_de['actionUrl']) print_r($j_de['actionUrl'].'/'.$directapi.'?'.$j2);
	if(@$j_de['hostUrl']) print_r($j_de['hostUrl'].'/'.$directapi.'?'.$j2);
	
	
		echo '</div>';
	//exit;
}

?>
<form id="formId" target="_blank" method="post" ?>
  <div class="entry-content container-flex p-3 bd-gray-100  text-center">
  <div class="col-sm-6 border bd-blue-100 p-2 rounded" style="max-width:400px; margin:0 auto;">
  <div class="card card-body my-2 bg-dark-subtle">
    <div class="f">
      <div class="w_98 g row"> <span class="col-sm-12 text-start ">
        <h6>Webhook Url :</h6>
        </span><span class="col-sm-12">
        <textarea name="mcb_notify_url" id="mcb_notify_url" class="form-control"></textarea>
        </span> </div>
		<?/*?>
      <div class="w_98 g row"><span class="col-sm-12 text-start">
        <h6>Return Url :</h6>
        </span> <span class="col-sm-12">
        <textarea name="mcb_redirect_url" id="mcb_redirect_url" class="form-control"></textarea>
        </span></div>
		<?*/?>
    </div>
    <div class="my-2">
      <textarea name="mcb_body" id="mcb_body" class="form-control" style="height: 191px;"></textarea>
    </div>
    <input name="webhook" class="btn btn-primary btn-sm w-100 my-1" type="submit" value="WEBHOOK" >
    <div class="clearfix"></div>
  </div>
</form>
<form id="formId" target="_blank" method="post" action="<?=$data['Host'];?>/p/curl_enc<?=$data['ex'];?><?=$ctest;?>">
  <textarea name="j"  class="form-control"></textarea>
  <input id="p_json_post_submit" name="p_json_post_submit" class="btn btn-primary btn-sm w-100 my-1" type="submit" value="CONTINUE TO JOSN POST" >
</form>
</div>
</div>
</body>

<script>
/*for display tooltip message*/
var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
  return new bootstrap.Tooltip(tooltipTriggerEl)
});


</script>
