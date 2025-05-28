<?  if(isset($data['ScriptLoaded'])){ ?>
<style>
	/*body{overflow:hidden;}*/
	
	body .rows3 {float:none;display:block;width:600px;margin:0 auto;}
	body .rows4 {float:left;width:100%;border-bottom:0px solid #fff;}
	
	body .rowsl {float:left;width:100%;padding:10px 0;font-size:13px;}
	body .rowsl a{font-size:13px;}
	
	.span_1 {float:left; width:60%;padding:0 0 0 0.5%;}
	.span_2 {float:left; width:28%;padding:0 0.5% 0 0;text-align:right;}
	
	@media (max-width:1279px){
	body .rows3 {width:98%;}
	body .rows4 {float:left;width:100%;border-bottom:1px solid #ccc;}
	}
	
</style>
<script>
	//$('#duspay_form_popup').slideDown(1000);
	top.closeLoader();
	function betaVersion_ov(){
	 $('#betaVersion_ut').slideDown(2000);
	}
	function betaVersion_ut(){
	 $('#betaVersion_ut').slideUp(500);
	}
</script>

<div class="container border bg-white">

      <div class="container vkg px-0">
        <h4 class="my-2"><i class="<?=$data['fwicon']['chart'];?>"></i> Success Ratio</h4>
        <div class="vkg-main-border"></div>
      </div>

<div style="float: right;margin-right: 10px;">
   	<form action="" method="post">
    <select name="graph_type" class="form-select" id="graph_type" onchange="submit();" >
    <option value="pie">Pie Graph</option>
    <option value="line">Line Graph</option>
    <option value="bar">Bar Graph</option>
    <option value="column">Column Graph</option>
    <option value="area">Area Graph</option>
    </select>
    </form>
</div>
<? if(isset($post['graph_type']) && $post['graph_type']){ ?>
<script>$('#graph_type option[value="<?=$post['graph_type']?>"]').prop('selected','selected');</script>
<? } ?>


<?
$type='pie';
if(isset($_POST['graph_type'])){$type=$_POST['graph_type'];}

	if(isset($_GET['ftype'])){
		$sRate=success_rate($_SESSION['uid'],$_GET['ftype']);
	}else{
		$sRate=success_rate($_SESSION['uid'],1);
	}

$chart=$dvalue=0;
foreach($sRate as $key=>$value){
		if ($key!='Completed rate'){
			$dvalue=	str_replace(" Count","",$value);
			if ($dvalue>0){$chart=true;}
		}
}
$dvalue=0;
if ($chart==true){?>
<div class="rowsl" style="text-align:center;margin:10px 0;">
	<div id="chartContainer" style="height: 370px; width: 100%;"></div>
</div>
<?php
}

	$dataPoints = array();
	echo '<h4>Summary of '.$data["Heading"].'</h4><hr/>';
	echo '<div class="row">';
	foreach($sRate as $key=>$value){
		if ($key=='Completed rate'){
			echo '<div class="row">
				<div class="col-sm-6"><strong><p><strong>'.$key.'</strong></p></strong></div>
				<div class="col-sm-6"><strong><p><strong>'.$value.'</strong></p></strong></div>
 			</div>';
	  		}
			if ($key!='Completed rate') {
				echo '<div class="row">
				<div class="col-sm-6"><p><strong>'.$key.'</strong></p></div>
				<div class="col-sm-6"><p><strong>'.$value.'</strong></p></div>
 			</div>';
			}
		
		if (($key=='Completed transaction count')||($key=='Cancelled transaction count')) {
		$dvalue=	str_replace(" Count","",$value);
		$dataPoints []= (array("label"=>$key, "y"=>$dvalue));
		}
	}
	echo '</div>';
	
	
?>


<script>
window.onload = function() { 
 
var chart = new CanvasJS.Chart("chartContainer", {
	animationEnabled: true,
	title: {
		text: "Success Ratio Summary"
	},
	subtitles: [{
		text: ""
	}],
	data: [{
		type: "<?=$type?>",
		yValueFormatString: "",
		indexLabel: "{label} ({y})",
		dataPoints: <?php echo json_encode($dataPoints, JSON_NUMERIC_CHECK); ?>
	}]
});
chart.render();
 
}
</script>

<div class="formula"><b>Formula: </b><i>(Completed count * 100) / (Transaction count-Repeat count)</i></div>
<div class="rowsl" style="text-align:center;margin:10px 0;">
	<!--View Summary of--> 
<a href="<?=$data['USER_FOLDER'];?>/tr_info<?=$data['ex']?>?trinfo=1&ftype=1" onclick="top.openLoader()" class="btn btn-primary"> Today</a> 
<a href="<?=$data['USER_FOLDER'];?>/tr_info<?=$data['ex']?>?trinfo=1&ftype=2" onclick="top.openLoader()" class="btn btn-primary">Weekly</a>
<a href="<?=$data['USER_FOLDER'];?>/tr_info<?=$data['ex']?>?trinfo=1&ftype=3" onclick="top.openLoader()" class="btn btn-primary">Monthly</a> 
<a href="<?=$data['USER_FOLDER'];?>/tr_info<?=$data['ex']?>?trinfo=1&ftype=0" onclick="top.openLoader()" class="btn btn-primary">Overall</a>
</div>


<script src="<?=$data['Host']?>/js/canvasjs.min.js"></script>
</script>

</center>

<div  style="clear:both;"></div>
</div>



<? }else{ ?>
SECURITY ALERT: Access Denied
<? }?>
