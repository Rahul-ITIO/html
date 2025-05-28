<?
include('config_db.do');
global $data;
//		/responseDataListGet.do


$json_value['post']=array();$json_value['get']=array();
	if(isset($_POST)){$json_value['post']=$_POST;}
	if(isset($_GET)){$json_value['get']=$_GET;}

$json_value=json_encode($json_value);
 
 
$db_rows1=db_rows(
		"SELECT * FROM `db_test` ".
		" ORDER BY Id DESC LIMIT 50  ",1
	);
	
//print_r($db_rows1);
?>

<!DOCTYPE html>
<html lang="en-US">
<head>
<title>PHP Query...</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
<script src="<?=$data['Host']?>/theme/scripts/jquery-3.4.0.min.js"></script>


<link rel="stylesheet" type="text/css" href="<?=$data['Host']?>/js/jquery-te-1.4.0.css"/>
<script src="<?=$data['Host']?>/js/jquery-te-1.4.0.min.js"></script>
<script>
hostPath ="<?=$data['Host']?>";
</script>
<script src="<?=$data['Host']?>/js/common_use.js"></script>

<style>
body{margin:0;padding:0;overflow:auto;width:100%;height:100%;font-size:14px!important;font-family:'PT Sans',sans-serif;line-height:24px;text-align:center;color:#434343;background-color:#e1e1e1;border-color:#e1e1e1}	
p{font-size:18px; margin:10px 10px; font-family: Arial, Helvetica, sans-serif; color: #5d5c5d; float:left; width:100%;width: 100%; line-height: 34px;}	

.separator {display:none;}
.jqte {width:100% !important;float:left;margin:7px 0;}
.no_input{border:0!important;background:transparent!important;box-shadow: inset 0 0px 0px rgba(0,0,0,0.075) !important;}

	.tb1 {border:1px solid #ccc;}
	.tb1 th td{font-size: 14px;}
	.tb1 td {border-top: 1px solid #ccc;border-right: 1px solid #ccc;font-size:12px;}
	
.copyLink{float:left;width:96%;text-align:left;height:40px;margin:10px 0;background:#eee;line-height:40px;padding:0 2%;text-transform:uppercase;font-weight:bold;}
body{font-family: 'PT Sans', sans-serif;font-size: 14px;}


/* start: tabel excel  */
.tbl_exl {width: 93vw;overflow:scroll;max-height: 500px;margin: 0 auto;float: left;}
.tbl_exl table {position:relative;border:1px solid #ddd;border-collapse:collapse;max-width: inherit;}
.tbl_exl td, .tbl_exl th, .dtd {white-space:nowrap;border:1px solid #ddd;padding: 0px 10px;text-align:left;}
.tbl_exl th {background-color:#eee !important;position:sticky;top:-1px;z-index:2; &:first-of-type {left:0;z-index:3;} }
.tbl_exl tbody tr td:first-of-type{background-color:#eee;position:sticky;left:-1px;text-align:left;}
.dtd {display:table-cell;}
/* end: tabel excel  */
</style>
<script>
function copyToClipboard(element) {
  var $temp = $("<input>");
  $("body").append($temp);
  $temp.val($(element).text()).select();
  document.execCommand("copy");
  $temp.remove();
}
function myCopyFunction(theId,theLabel) {
  /* Get the text field */
  var copyText = document.getElementById(theId);

  /* Select the text field */
 // copyText.select();
  copyText.html();

  /* Copy the text inside the text field */
  document.execCommand("copy");

  /* Alert the copied text */
  alert("Copied : " + theLabel);
}

function textAreaAdjust(o) {
  o.style.height = "1px";
  o.style.height = (10+o.scrollHeight)+"px";
}

	$(document).ready(function() {$(".textAreaAdjust").trigger("keyup");});
	
	
	function CopyToClipboard(containerid) {
		if (document.selection) { 
			var range = document.body.createTextRange();
			range.moveToElementText(document.getElementById(containerid));
			range.select().createTextRange();
			document.execCommand("copy"); 

		} else if (window.getSelection) {
			var range = document.createRange();
			 range.selectNode(document.getElementById(containerid));
			 window.getSelection().addRange(range);
			 document.execCommand("copy");
			 alert("text copied") 
		}
	}
	function CopyToClipboard2(text) {
			text=$(text).html();
			var $txt = $('<textarea />');

            $txt.val(text)
                .css({ width: "1px", height: "1px" })
                .appendTo('body');

            $txt.select();

            if (document.execCommand('copy')) {
                $txt.remove();
            }
	}
</script>

</head>
<body oncontextmenu1='return false;'>
<?if(isset($db_rows1)&&$db_rows1){$results=array();?>

<a class="copyLink nopopup btn btn-icon btn-primary glyphicons file" onclick1="myCopyFunction('resultTbId1','Result')" onclick2="copyToClipboard('#resultTbId1');" onclick="CopyToClipboard2('#resultTbId1');" style="display:none1;"><i></i>Copy text </a>
<div class="resultTbId tbl_exl" id="resultTbId1" style="width: 100%;background:#fff;height:394px;padding:0;margin:0;">
	<table class="tb1" border="0" cellpadding="0" cellspacing="0">
		<thead><tr>
			<th> </th>
			<?foreach($db_rows1[0] as $key0=>$value0){?>
			<th style="font-weight:bold;"><?=$key0;?></th>
			<?}?>
		</tr></thead>
		<tbody>
	<?$i=1;foreach($db_rows1 as $key=>$value){?>
		<tr>
			<td><?=$i;?></td>
			<?foreach($value as $name=>$v){ ?>
				<td nowrap>
				
				<a onclick="iframe_openf(this);" class="nomid" data-ihref='<?=$data['Host'];?>/json_pretty_print<?=$data['ex']?>?json=<?=encryptres($v);?>' >
						 <?=htmlentitiesf($v);?> &nbsp;
						</a>
				</td>
			<?}?>
		</tr>
	<?$i++;}?>
		</tbody>
	</table>
	
</div>
<?}?>


<script>
	//$('.jqte-test').jqte();
	
	// settings of status
	var jqteStatus = true;
	$(".status").click(function()
	{
		jqteStatus = jqteStatus ? false : true;
		//$('.jqte-test').jqte({"status" : jqteStatus})
	});
</script>


<style>.modal_popup_popup {display:none; position:fixed;z-index:999999; top:0; left:0;}.modal_popup_popup_layer {display:block; position:fixed; z-index:999999; width:100%; height:100%; background:#000; opacity:0.5; top:0; left:0; }.modal_popup_popup_body {display:block; position:fixed; z-index:9999999; width:90%; height:520px; background:#fff; opacity:1; border-radius:5px; left:5%; top:50%; margin:-260px 0 0 0; }.modal_popup_popup_close {position: absolute; z-index: 99; float: right; right: -20px; top: -20px; width:40px; height:40px; font: 800 40px/40px 'Open Sans'; color:#fff !important; background:#f30606; text-align:center; border-radius:110%; overflow:hidden; cursor: pointer;}</style><div class=modal_popup_popup id=modal_popup_popup> <div class=modal_popup_popup_layer> </div> <div class=modal_popup_popup_body> <a class=modal_popup_popup_close onclick="document.getElementById('modal_popup_popup').style.display='none';">&times;</a><div id=modal_popup_iframe_div><iframe src=about:blank name=modal_popup_iframe id=modal_popup_iframe frameborder=0 marginwidth=0 marginheight=0 class=modal_popup_iframe width=100% height=400></iframe></div></div></div>
<style>.modal_popup_form_popup {display:none; position:fixed;z-index:999999; top:0; left:0;}.modal_popup_form_popup_layer {display:block; position:fixed; z-index:999999; width:100%; height:100%; background:#000; opacity:0.2; top:0; left:0; }.modal_popup_form_popup_body {display:block; position:fixed; z-index:9999999;left:50%;top:50%;width:300px;height:260px;margin:-130px 0 0 -150px;opacity:1;border-radius:5px;color:#fff;text-align:center;overflow:hidden; }.modal_popup_form_popup_close {position: absolute; z-index: 99; float: right; right: -20px; top: -20px; width:40px; height:40px; font: 800 40px/40px 'Open Sans'; color:#fff !important; background:#f30606; text-align:center; border-radius:110%; overflow:hidden; cursor: pointer;}.waitxt{font-size: 14px;margin:10px 0 0 0;background:#444;color:#fff;padding:3px;border-radius:3px;white-space:nowrap;position:absolute;z-index:3;bottom:0px;width:100%;}</style><div class=modal_popup_form_popup id=modal_popup_form_popup> <div class=modal_popup_form_popup_layer> </div> <div class=modal_popup_form_popup_body> <div id=modal_popup_form_iframe_div><img src='<?=$data['Host']?>/images/icons/loading_spin_icon.gif' style='width:100%;position:relative;top:-110px;' /> <div class='waitxt'>Please Wait...<div></div></div></div></div></div>    
<script>
function popuploadig(){
	$('#modal_popup_form_popup').slideDown(900);
}
function popupclose(){
	$('#modal_popup_form_popup').slideUp(70);
	$('#modal_popup_popup').slideUp(70);
	
}
function popupclose2(){
	setTimeout(function(){ 
		$('#modal_popup_form_popup').slideUp(100); 
		activeslide();
		top.window.popupclose();
		
	},1500); 
}
function hformf(thisValue){
	//alert(thisValue.contentWindow.location.href);
	if(thisValue.contentWindow.location.href=="about:blank"){
		//alert(thisValue.contentWindow.location.href);
	}else{
		$('#modal_popup_form_popup').slideDown(900);
		setTimeout(function(){ 
			$('#modal_popup_form_popup').slideUp(100); 
			activeslide();
			top.window.popupclose();
			parent.window.popupclose();
		},1000); 
	}
}

</script>	  
<div style="display:none!important;width:0!important;height:0!important"><iframe onload="hformf(this)" name="hform" id="hform" src="about:blank" width="0" height="0" scrolling="no" frameborder="0" marginwidth="0" marginheight="0" style="display:none!important;width:0!important;height:0!important" ></iframe>

<iframe name="modal_popup3_frame" id="modal_popup3_frame" onLoad="return  dashboarAjaxLoad_Div3(this.contentWindow.location.href,false);" src="about:blank" style="display:none!important; width: 0px; height: 0px;" width="0" height="0" frameborder="0" scrolling="no" marginwidth="0" marginheight="0" security="none"></iframe>
</div>


<div class="modalpopup popup_close" id="modalpopup" style="display: none;">
  <div class="modalpopup_form_popup_layer"> </div>
  <div class="modalpopup_body absolute" id="modalpopup_body"> <a class="close_popup modal_popup_close" onClick="document.getElementById('modalpopup').style.display='none';">×</a> <div class="modalpopup_cdiv" id="modalpopup_cdiv"> </div>
  </div>
</div>

<div class="modal_popup3_frame_img_div" style="display:none;">
	<img class="modal_popup3_frame_img" id="modal_popup3_frame_img" src="<?=$data['Host']?>/images/icons/ajax-loader.gif" />
</div>
</body>
</html>