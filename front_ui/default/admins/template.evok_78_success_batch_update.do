<? if(isset($data['ScriptLoaded'])){?>

<?
if((!isset($_SESSION['login_adm']))&&(!$_SESSION['useful_link'])){
	echo $data['OppsAdmin'];
	exit;
}
?>


<style type="text/css">
.separator {display:none;}
.jqte {width:100% !important;float:left;margin:7px 0;}
.no_input{border:0!important;background:transparent!important;box-shadow: inset 0 0px 0px rgba(0,0,0,0.075) !important;}
</style> 



<style>
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



<div class="container border my-1 vkg rounded">
	<h2 class="my-2"><i class="<?=$data['fwicon']['link'];?>"></i> Evok Status Update via CSV - <?=@$post['print_mem']?></h2>

<?if(isset($db_rows1)&&$db_rows1){$results=array();?>

<a class="copyLink nopopup btn btn-icon btn-primary glyphicons file" onclick1="myCopyFunction('resultTbId1','Result')" onclick2="copyToClipboard('#resultTbId1');" onclick="CopyToClipboard2('#resultTbId1');" style="display:none1;"><i></i>Copy text </a>
<div class="resultTbId tbl_exl" id="resultTbId1" style="width: 100%;background:#fff;height:394px;padding:0;margin:0;">
	<table class="tb1" border="0" cellpadding="0" cellspacing="0">
		<thead><tr>
			<th> </th>
			<?foreach($db_rows1[0] as $key0=>$value0){?>
			<?if(isset($_REQUEST['a'])&&$_REQUEST['a']=='col') echo$key0."|";  ?>
			<th style="font-weight:bold;"><?=$key0;?></th>
			<?}?>
		</tr></thead>
		<tbody>
	<?$i=1;foreach($db_rows1 as $key=>$value){?>
		<tr>
			<td><?=$i;?></td>
			<?foreach($value as $name=>$v){ ?>
				<td nowrap><?=$v;?> &nbsp;</td>
			<?}?>
		</tr>
	<?$i++;}?>
		</tbody>
	</table>
	<?/*?>
	<textarea id="resultTbId1" class="textAreaAdjust jqte-test" onkeyup="textAreaAdjust(this)" rows="10" style="width:90%;font-family:Courier New;height:250px;line-height:150%;overflow:hidden;" readonly>
	</textarea>
	<?*/?>
</div>
<?}?>

<?if(isset($post['csv_file_on'])&&trim($post['csv_file_on'])){?>
<hr/>

<form method="post" target="_blank" style="padding: 0;margin: 0;display: inline-block;">
    <input type="hidden" name="download" value="1" />
   
    <textarea class="hide" style="display:none" name="downloadHtml" readonly ><?=@$post['downloadHtml_2'];?></textarea>
    <br/>
   
    <button type="submit" name="send" value="send" class="btn btn-sm btn-primary showbutton ms-2 mb-2 float-endX" title="Download to Log" data-bs-toggle="tooltip" data-bs-placement="top" /><i class="<?=$data['fwicon']['download'];?> fa-fw"></i>Download Logs</button>

    <a class="btn btn-sm btn-primary showbutton ms-2 mb-2" data-bs-toggle="collapse" href="#multiCollapseExample1" role="button" aria-expanded="true" aria-controls="multiCollapseExample1">View Logs</a>


    <a class="btn btn-sm btn-primary ms-2 mb-2" href="<?=@$data['urlpath']?>" >Upload CSV File</a>


    <br/><br/>
    <div class="row">
        <div class="col-sm-12">
            <div class="collapse multi-collapse show" id="multiCollapseExample1">
                <div class="card card-body" style="word-break: break-all;">
                    <?=@$post['downloadHtml_2']?>
                </div>
            </div>
        </div>
    </div>
   
</form>
<hr/>
<?}
else {
?>

<form method="post" id="myPostForm" name="data" enctype="multipart/form-data" style="text-align:center;padding:20px 0px; ">
<?if(isset($_GET['qr'])){
  $input_name='qr';
}else{
	$input_name='s';
}	
?>

<? if((isset($data['Error'])&& $data['Error'])){ ?>
    <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error!</strong>
      <?=prntext($data['Error'])?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <? } ?>

<h3>You can upload the bath file recevied from NPST - Evok with all successfull transaction below. Our system will mark all the transactions approved into our system by updating the current date and also send the webhook to merchant. After the excustion you will be able to download the Log in notpad. </h3>
<h4 style="text-align:left;">Please upload the file in csv formate with position below. <br/>
1. Date<br/>
2. Amount<br/>
3. RRN<br/>
4. Ext ID<br/>
5. Transaction Status<br/>
6. NPCI Code<br/>
7. Switch Code<br/>
8. Switch Msg<br/>
9. Payee VPA<br/>
10. Payer PVA<br/>
11. Ten Id<br/>
12. MCC<br/>
13. Remarks  </h4>

<b>Upload CSV File :</b> <input type="file" class="form-control px-2  my-2 fileUpload" style="height:35px;"  name="file" title="Upload CSV File" placeHolder="Upload CSV File" required >
<br/>

<?/*?>
<textarea name='<?=$input_name;?>' style='width:90%;height:96px;
'><?=@$p;?></textarea>
 <?*/?>

<input class="btn btn-sm btn-primary showbutton ms-2 mb-2" type='submit' name='submit' value='Submit' style="font-weight:bold;" />
</form>
<br/>
<hr/>

<?
}
?>
<?=print_mem();?>

</div>

<? }else{?>
	SECURITY ALERT: Access Denied
<? }?>