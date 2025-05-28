<?php
function print_mem()
{
   /* Currently used memory */
   $mem_usage = memory_get_usage();
   
   /* Peak memory usage */
   $mem_peak = memory_get_peak_usage();
   echo 'Memory Consumption is: <strong>' . round($mem_usage / 1048576,2) . ' MB</strong> of memory. | ';
   echo 'Peak usage: <strong>' . round($mem_peak / 1048576,2) . ' MB</strong> of memory.';
}
print_mem();



include('../config.do');

if(!isset($_SESSION['adm_login'])){
       echo('ACCESS DENIED.');
       exit;
}

//echo "<br/>cid1=>".@$data['cid'];

function findStrf1($str, $arr) {  
    foreach ($arr as &$s){
       if(strpos($str, $s) !== false){
			return $s; //return true;break;
	   }
    }
    return false;
}

$queryArray1=["UPDATE","DELETE","INSERT","ALTER"];

$p='';
if((isset($_GET['qr'])&&($_GET['qr']))||(isset($_POST['qr'])&&($_POST['qr']))){
	$q=$_REQUEST['qr'];
	$p=$q;
	$q_str = str_ireplace(array('update','delete','insert','alter'), array('UPDATE','DELETE','INSERT','ALTER'), $q );
	$isNotQuery=findStrf1($q_str, $queryArray1);
	//echo "<br/><br/>q_str=>".$q_str."<br/><br/>"; echo "<br/><br/>isNotQuery=>".$isNotQuery."<br/><br/>";
	if(@$isNotQuery){
		echo "Not Allow this Query";
	}
	else
	{
		$db_query=db_query($q,1); echo "<hr/>Result=>"; print_r($db_query);
	}
	
	
}elseif((isset($_GET['s'])&&($_GET['s']))||(isset($_POST['s'])&&($_POST['s']))){
	$s=$_REQUEST['s'];
	$p=$s;
	
	$q_str = str_ireplace(array('update','delete','insert','alter'), array('UPDATE','DELETE','INSERT','ALTER'), $s );
	$isNotQuery=findStrf1($q_str, $queryArray1);
	
	if($isNotQuery){
		echo "Not Allow this Query";
	}else{
		$db_rows1=db_rows($s,1);
	}
	
	
	
	if((isset($_GET['p'])&&($_GET['p']))||(isset($_POST['p'])&&($_POST['p']))){
		echo "<hr/>Result=>";
		print_r($db_rows1);
	}
	
}

echo "connection_type=>". $data['connection_type'];
if($data['connection_type']=='PSQL')
{
	//$cid=pg_fetch_all_columns($data['cid']);
	//echo ", cid=>";print_r(@$cid);

	if(empty($db_rows1)) echo " | <div style=\"background:#bf0000;color:#e6e6e6;display:inline-block;padding:4px;border-radius:3px;font-weight:bold;\">".pg_last_error($data['cid'])."</div>";

}
else print_r($data['cid']);


//db_disconnect();	//disconnect DB connection
//ob_end_flush();		//Deletes the topmost output buffer and outputs all of its contents.
	
//@mysqli_close($data['cid']);


?>
<!DOCTYPE html>
<html lang="en-US">
<head>
<title>PHP Query...</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
<script src="<?=$data['Host']?>/js/jquery-3.6.0.min.js"></script>


<link rel="stylesheet" type="text/css" href="<?=$data['Host']?>/js/jquery-te-1.4.0.css"/>
<script src="<?=$data['Host']?>/js/jquery-te-1.4.0.min.js"></script>


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

.active {
  color: #ea2c00 !important;
}
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
	

function scrollLeft_f(e,theId){
	$('.resultTable font').removeClass('active');
	$('.resultCaption .rowCaption').removeClass('active');
	$('.'+theId).addClass('active');
	$(e).addClass('active');
	$('.resultTbId').eq(0).animate({ scrollLeft: '+=' + (($('.'+theId).offset().left) - 52) }, 1000);
	//alert(($('.'+theId).offset().left)+"\r\n"+$('.'+theId).html());

}
</script>

</head>
<body oncontextmenu1='return false;'>
<?if(isset($db_rows1)&&$db_rows1){$results=array();?>
	<?
	$row_0='';$row_0_a='';$row_0_href='';
	foreach($db_rows1[0] as $key0=>$value0){
		if(isset($_REQUEST['a'])&&$_REQUEST['a']=='col') $row_0_a.=$key0."|"; 
		elseif(isset($_REQUEST['a'])&&$_REQUEST['a']=='col1') $row_0_a.=$key0.","; 
		$row_0_href.="<a style=\"font-weight:bold;color:#1515b7;\" onclick=\"scrollLeft_f(this,'{$key0}')\" data-href=\"#{$key0}\">{$key0}</a> | ";
		$row_0.="<th style=\"font-weight:bold;\" title=\"{$key0}\"><font class=\"rowCaption {$key0}\" id=\"{$key0}\">{$key0}</font></th>";
	}
	if(!empty($row_0_a))
	{
		echo "<div style=\"float:left;width:98vw;background:#eee;margin:2px 0 4px 0;padding:4px 10px;overflow:hidden;word-wrap:break-word;\">{$row_0_a}</div>";
	}
	?>

<div class="resultCaption" style="float:left;width:98vw;background:#eee;margin:2px 0 4px 0;padding:4px 10px;overflow:hidden;word-wrap:break-word;">
<a class="copyLink nopopup btn btn-icon btn-primary glyphicons file" onclick1="myCopyFunction('resultTbId1','Result')" onclick2="copyToClipboard('#resultTbId1');" onclick="CopyToClipboard2('#resultTbId1');" style="width:100px;background: #d5d5d5 !important;border-radius:3px;cursor:pointer;float:left;margin:0 10px;"><i></i>Copy text </a>
<?=@$row_0_href;?>
</div>
<div class="resultTbId tbl_exl" id="resultTbId1" style="width: 100%;background:#fff;height:394px;padding:0;margin:0;">
	<table class="tb1 resultTable" border="0" cellpadding="0" cellspacing="0">
		<thead><tr>
			<th> </th>
			<?
			echo $row_0;
			?>
		</tr></thead>
		<tbody>
	<?$i=1;foreach($db_rows1 as $key=>$value){?>
		<tr>
			<td><?=$i;?></td>
			<?foreach($value as $name=>$v){ ?>
				<td wrap><?=htmlentities($v);?></td>
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

<form method='post'>
<?if(isset($_GET['qr'])){
  $input_name='qr';
}else{
	$input_name='s';
}	
?>
<hr/>
<textarea id='q_textarea' name='<?=$input_name;?>' style='width:90%;height:96px;
'><?=$p;?></textarea>
<input type='submit' value='Submit' />



<br/><?=print_mem();?> 

<?
		

	?>

<input type="text" name="tableList"
	value="<?=(@$post['tableList']?@$post['tableList']:'');?>"
	id="tableList" list="input_tableList" title="Bill Country" minlength="1" class="form-control is-invalid" style="display:inline-block;padding:4px 10px;width:300px;" >
	

<datalist id="input_tableList" >
		<option value="1">Show tables</option>
		<option value="2">Show databases</option>
	<?
		if($data['connection_type']=='PSQL') $tblList ="SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';";
		elseif($data['connection_type']=='MYSQLI') $tblList ="show tables";

		$tblList_db=db_rows($tblList,0);
		$tblList_db_count=count($tblList_db);
		//echo "<optgroup label='{$tblList_db_count} - Tables'>";
		echo "<option label='{$tblList_db_count} - Tables'>{$tblList_db_count} - Tables2</option>";
		if(@$tblList_db&&count($tblList_db)>0)foreach($tblList_db AS $v111) foreach($v111 AS $k222=>$v222) echo "<option value='{$v222}'>{$v222}</option>";
		//print_r($tblList_db);

		//echo "</optgroup>";
	?>
</datalist>

<input type="text" name="generateQuery"
	value="<?=(@$post['generateQuery']?@$post['generateQuery']:'');?>"
	id="generateQuery" list="input_generateQuery" title="Bill Country" minlength="1" class="form-control is-invalid" style="display:inline-block;padding:4px 10px;width:300px;" >
	

<datalist id="input_generateQuery" >
		<option value="1">DB Stat Activity</option>
		<option value="2">Indexes</option>
		<option value="3">Total record for Table Wise</option>
		<option value="4">DB Current Setting via run-time parameters</option>
</datalist>
	
</form>

<script>
var tableName='';
$(document).ready(function() {

$(".textAreaAdjust").trigger("keyup");


$("#tableList").change(function(e)
{

	//alert($(this).val()+"\r\n"+$(this).find('option:selected').text()+"\r\n"+$(this).find('option:selected').attr('data-val'));
	
	//var objValue=$(this).find('option:selected').text();
	var objValue=$(this).val().trim();
	//alert(objValue);
	tableName='';
	<? if($data['connection_type']=='PSQL')
	{
		?>
		if(objValue==='1') 
		{ 
			$('#q_textarea').html("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';"); 
		}
		else if(objValue==='2') 
		{ 
			$('#q_textarea').html('SELECT datname FROM pg_database;'); 
		}
		else if(objValue!=='') 
		{
			tableName=objValue;
			if( (objValue !== undefined) && (objValue) && (objValue.match('_trans_additional_')) )
			{
				$('#q_textarea').html('SELECT * FROM `'+objValue+'` ORDER BY id_ad DESC LIMIT 10;'); 
			}
			else 
			{
				$('#q_textarea').html('SELECT * FROM `'+objValue+'` ORDER BY id DESC LIMIT 10;'); 
			}
		}
		
		<?
	}
	elseif($data['connection_type']=='MYSQLI')
	{
		?>
		if(objValue==='1') 
		{ 
			$('#q_textarea').html('show tables;'); 
		}
		else if(objValue==='2') 
		{ 
			$('#q_textarea').html('show databases;'); 
		}
		else if(objValue!=='') 
		{
			tableName=objValue;
			if( (objValue !== undefined) && (objValue) && (objValue.match('_trans_additional_')) )
			{
				$('#q_textarea').html('SELECT * FROM `'+objValue+'` ORDER BY id_ad DESC LIMIT 10;'); 
			}
			else 
			{
				$('#q_textarea').html('SELECT * FROM `'+objValue+'` ORDER BY id DESC LIMIT 10;'); 
			}
		}
		
		<?
	}	
		?>
});


$("#generateQuery").change(function(e)
{

	//alert($(this).val()+"\r\n"+$(this).find('option:selected').text()+"\r\n"+$(this).find('option:selected').attr('data-val'));
	
	//var objValue=$(this).find('option:selected').text();
	var objValue=$(this).val().trim();
	//alert(objValue);
	<? if($data['connection_type']=='PSQL')
	{
		?>
		if(objValue==='1') 
		{ 
			$('#q_textarea').html('SELECT * FROM pg_stat_activity;'); 
		}
		else if(objValue==='2') 
		{ 
			$('#q_textarea').html('select * from pg_indexes;'); 
		}
		else if(objValue==='3') 
		{ 
			$('#q_textarea').html("select n.nspname as table_schema, c.relname as table_name, c.reltuples as rows from pg_class c join pg_namespace n on n.oid = c.relnamespace where c.relkind = 'r' and n.nspname not in ('information_schema','pg_catalog') order by c.reltuples desc;"); 
		}
		else if(objValue==='4') 
		{ 
			$('#q_textarea').html("show all;"); 
		}
		<?
	}
	elseif($data['connection_type']=='MYSQLI')
	{
		?>
		if(objValue==='1') 
		{ 
			$('#q_textarea').html('SHOW FULL PROCESSLIST;'); 
		}
		else if(objValue==='2') 
		{ 
			$('#q_textarea').html('select * from sys.schema_index_statistics;'); 
		}
		else if(objValue==='3') 
		{ 
			$('#q_textarea').html("SELECT TABLE_NAME, SUM(TABLE_ROWS) AS record_count FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = '<?=@$data['Database'];?>' GROUP BY TABLE_NAME ORDER BY record_count DESC ;"); 
		}
		else if(objValue==='4') 
		{ 
			$('#q_textarea').html("show variables;"); 
		}
		<?
	}	
		?>
});


});



</script>

<?db_disconnect();?>
</body>
</html>